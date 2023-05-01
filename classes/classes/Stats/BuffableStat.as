package classes.Stats {
import classes.Creature;
import classes.internals.EnumValue;
import classes.internals.Jsonable;
import classes.internals.Utils;

/**
 * BuffableStat is aggregation (sum/min/max/product) of buffs.
 * Buff contains (see Buff.as for details) unique tag:String, value:Number, and other options
 * Total value is maintained as a cache
 *
 * Options object structure:
 * save: boolean = true, <-- save and load the effect. False for effects created by other creature properties (race, perks)
 * show: boolean = true, <-- can be viewed by player. Note that player might figure that there is a hidden effect
 * text: String = null, (default is same as tag) <-- displayable name in the list of effects
 */
public class BuffableStat implements IStat, Jsonable {
	private static const AggregateTypes:/*EnumValue*/Array = [];
	
	public static const AGGREGATE_SUM:int  = EnumValue.add(AggregateTypes, 0, 'AGGREGATE_SUM', {short: 'sum'});
	public static const AGGREGATE_MAX:int  = EnumValue.add(AggregateTypes, 1, 'AGGREGATE_MAX', {short: 'max'});
	public static const AGGREGATE_MIN:int  = EnumValue.add(AggregateTypes, 2, 'AGGREGATE_MIN', {short: 'min'});
	public static const AGGREGATE_PROD:int = EnumValue.add(AggregateTypes, 3, 'AGGREGATE_PROD', {short: 'prod'});
	
	private var _base:Number = 0.0;
	private var _baseFn:Function = null;
	private var _aggregate:int = AGGREGATE_SUM;
	private var _min:Number = -Infinity;
	private var _max:Number = +Infinity;
	private var _value:Number = 0.0; // Aggregate of buffs ONLY
	private var _buffs:/*Buff*/Array = [];
	private var _name:String;
	private var _host:Creature;
	
	/**
	 * Set of buff tags (key is tag and value is true) that were removed since last
	 * `advanceTime`, `removeCombatRoundTrackingBuffs`, or `addTicksToBuff` call.
	 */
	public var recentlyRemovedTags:Object = {};
	
	public function get base():Number {
		return (_baseFn != null) ? _baseFn() : _base;
	}
	public function get aggregate():int {
		return _aggregate;
	}
	public function get min():Number {
		return _min;
	}
	public function get max():Number {
		return _max;
	}
	public function redefine(options:Object):void {
		options    = Utils.extend({
			aggregate: this.aggregate,
			base     : this._baseFn || this.base,
			min      : this.min,
			max      : this.max
		}, options);
		if (options.aggregate is String) {
			options.aggregate = EnumValue.findByProperty(AggregateTypes, 'short', options.aggregate).value;
		}
		if (options.aggregate == AGGREGATE_PROD && options.base == 0.0) options.base = 1.0;
		this._aggregate = options.aggregate;
		var base:* = options['base'];
		if (base is Function) {
			this._baseFn = base;
			this._base = aggregateBase();
		} else {
			this._base = base;
			this._baseFn = null;
		}
		this._min       = options['min'];
		this._max       = options['max'];
		recalculate();
	}
	public function get value():Number {
		var x:Number = aggregateStep(this.base, _value);
		if (x < min) return min;
		if (x > max) return max;
		return x;
	}

	/**
	 * @param options Options object: {
	 *     aggregate: how to aggregate multiple effects, AGGREGATE_constant or 'sum'/'min'/'max';
	 *     base: default 0; can be Function ()=>Number
	 *     min: default -Infinity;
	 *     max: default +Infinity;
	 * }
	 */
	public function BuffableStat(host:Creature, name:String, options:*=null) {
		this._host = host;
		this._name = name;
		redefine(options);
		
		if (!(this._aggregate in AggregateTypes)) throw new Error("Invalid aggregate type");
	}
	
	public function get host():Creature {
		return _host;
	}
	
	public function get statName():String {
		return _name;
	}
	
	/**
	 * Add `amount` ticks to buff tagged `tag`.
	 * Does nothing if no such buff or it is permanent.
	 *
	 * Will reset & populate`recentlyRemovedTags`
	 */
	public function addTicksToBuff(tag:String, amount:Number):void {
		recentlyRemovedTags = {};
		var buff:Buff = findBuff(tag);
		if (!buff || buff.rate == Buff.RATE_PERMANENT) return;
		buff.tick += amount;
		if (buff.tick <= 0) {
			recentlyRemovedTags[tag] = true;
			removeBuff(tag);
		}
	}
	
	private function aggregateBase():Number {
		return _aggregate == AGGREGATE_PROD ? 1 : 0;
	}
	private function aggregateStep(accumulator:Number, value:Number):Number {
		switch (_aggregate) {
			case AGGREGATE_SUM:
				accumulator += value;
				break;
			case AGGREGATE_MAX:
				accumulator = (accumulator > value) ? accumulator : value;
				break;
			case AGGREGATE_MIN:
				accumulator = (accumulator < value) ? accumulator : value;
				break;
			case AGGREGATE_PROD:
				accumulator *= value;
				break;
		}
		return accumulator;
	}
	public function calculate():Number {
		var value:Number = aggregateBase();
		for each(var buff:Buff in _buffs) {
			value = aggregateStep(value, buff.value);
		}
		return value;
	}
	public function recalculate():void {
		_value = calculate();
	}
	private function indexOfBuff(tag:String):int {
		for (var i:int = 0; i < _buffs.length; i++) {
			if (_buffs[i].tag == tag) return i;
		}
		return -1;
	}
	public function hasBuff(tag:String):Boolean {
		return indexOfBuff(tag) != -1;
	}
	/**
	 * @return Buff or null
	 */
	public function findBuff(tag:String):Buff {
		var i:int = indexOfBuff(tag);
		if (i == -1) return null;
		return _buffs[i];
	}
	public function valueOfBuff(tag:String, defaultValue:Number = 0.0):Number {
		var i:int = indexOfBuff(tag);
		if (i == -1) return defaultValue;
		return _buffs[i].value;
	}
	public function ticksOfBuff(tag:String):int {
		var i:int = indexOfBuff(tag);
		if (i == -1) return 0;
		return _buffs[i].tick;
	}
	public function addOrIncreaseBuff(tag:String, buffValue:Number, newOptions:Object = null):void {
		var i:int = indexOfBuff(tag);
		if (i == -1) {
			_buffs.push(new Buff(this, buffValue, tag).withOptions(newOptions));
		} else {
			_buffs[i].rawValue += buffValue;
			if (newOptions !== null) _buffs[i].options = newOptions;
		}
		if (_aggregate == AGGREGATE_SUM) {
			_value += buffValue;
		} else if (_aggregate == AGGREGATE_PROD) {
			_value *= buffValue;
		} else {
			_value = calculate();
		}
	}
	public function addOrReplaceBuff(tag:String, buffValue:Number, newOptions:Object = null):void {
		var i:int = indexOfBuff(tag);
		if (i == -1) {
			_buffs.push(new Buff(this, buffValue, tag).withOptions(newOptions));
		} else {
			_buffs[i].rawValue = buffValue;
			if (newOptions !== null) _buffs[i].options = newOptions;
		}
		_value = calculate();
	}
	public function removeBuff(tag:String):void {
		var i:int = indexOfBuff(tag);
		if (i == -1) return;
		var buffValue:Number = _buffs[i].value;
		_buffs.splice(i, 1);
		if (_aggregate == AGGREGATE_SUM) {
			_value -= buffValue;
		} else if (_aggregate == AGGREGATE_PROD && buffValue != 0) {
			_value /= buffValue;
		} else {
			_value = calculate();
		}
	}
	public function listBuffs():/*Buff*/Array {
		return _buffs.slice();
	}
	public function removeAllBuffs():void {
		this._buffs = [];
		this._value = aggregateBase();
	}
	/**
	 * Advance time-tracking buffs by `ticks` units, unit type is defined by `rate`
	 * Buffs with their countdown expired are removed.
	 *
	 * Will reset & populate `recentlyRemovedTags`
	 */
	public function advanceTime(rate:int, tick:int):void {
		if (rate == Buff.RATE_PERMANENT) throw "Invalid time unit "+rate;
		if (tick < 0) throw "Invalid ticks count "+tick;
		if (tick == 0) return;
		var changed:Boolean = false;
		recentlyRemovedTags = {};
		for (var i:int = _buffs.length-1; i>=0; i--) {
			var buff:Buff = _buffs[i];
			if (buff.rate == Buff.RATE_ROUNDS && buff.tick == 9999) continue;
			if (buff.rate == rate) {
				buff.tick-=tick;
				if (buff.tick <= 0) {
					recentlyRemovedTags[buff.tag] = true;
					_buffs.splice(i,1);
					changed = true;
				}
			}
			//else{
			//	trace(buff.text + ": " + buff.rate);
			//}
		}
		if (changed) recalculate();
	}
	
	/**
	 * Remove all buffs with `rate == RATE_ROUNDS`.
	 *
	 * Will reset & populate `recentlyRemovedTags`
	 */
	public function removeCombatRoundTrackingBuffs():void {
		var changed:Boolean = false;
		recentlyRemovedTags = {};
		for (var i:int = _buffs.length-1; i>=0; i--) {
			if (_buffs[i].rate == Buff.RATE_ROUNDS) {
				recentlyRemovedTags[_buffs[i].tag] = true;
				_buffs.splice(i,1);
				changed = true;
			}
		}
		if (changed) recalculate();
	}
	
	public function saveToObject():Object {
		var jbuffs:Array = [];
		for each(var b:Buff in _buffs) {
			if (!b.save) continue;
			jbuffs.push(b.saveToObject());
		}
		return {effects: jbuffs};
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		removeAllBuffs();
		var value:Number = aggregateBase();
		for each(var savedBuff:Object in o.effects) {
			var buff:Buff = new Buff(this, 0, '', false);
			buff.loadFromObject(savedBuff, ignoreErrors);
			var buffValue:Number = buff.value;
			value                = aggregateStep(value, buffValue);
			_buffs.push(buff);
		}
		this._value = value;
	}
}
}
