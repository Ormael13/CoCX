/**
 * Coded by aimozg on 01.08.2018.
 */
package classes.Stats {
import classes.CoC;
import classes.internals.Utils;

import coc.script.Eval;

public class StatStore implements IStatHolder {
	private var _stats:Object = {};
	/**
	 * Set of buff tags (key is tag and value is true) that were removed since last
	 * `advanceTime`, `removeCombatRoundTrackingBuffs`, or `addTicksToBuffs` call.
	 */
	public var recentlyRemovedTags:Object = {};
	
	public function StatStore(setup:/*IStat*/Array =null) {
		if (setup) {
			for each (var stat:IStat in setup) {
				this._stats[stat.statName] = stat;
			}
		}
	}
	public function findStat(fullname:String):IStat {
		if (fullname.indexOf('.') == -1) return _stats[fullname];
		return StatUtils.findStatByPath(this, fullname);
	}
	public function addStat(stat:IStat):StatStore {
		this._stats[stat.statName] = stat;
		return this;
	}
	public function addStatList(setup:/*IStat*/Array):StatStore {
		for each (var stat:IStat in setup) {
			addStat(stat)
		}
		return this;
	}
	public function addStatObject(setup:Object):StatStore {
		Utils.extend(_stats,setup);
		return this;
	}
	public function allStats():Array {
		return Utils.values(_stats);
	}
	public function allStatNames():Array {
		return Utils.keys(_stats);
	}
	public function findBuffableStat(fullname:String):BuffableStat {
		var istat:IStat = findStat(fullname);
		if (istat is BuffableStat) {
			return istat as BuffableStat;
		} else if (istat is PrimaryStat) {
			return (istat as PrimaryStat).bonus;
		} else {
			return null;
		}
	}
	/**
	 * Advance time-tracking buffs by `ticks` units, unit type is defined by `rate`
	 * Buffs with their countdown expired are removed.
	 *
	 * Will reset & populate `recentlyRemovedTags`
	 */
	public function advanceTime(rate:int, tick:int):void {
		recentlyRemovedTags = {};
		forEachStat(function(stat:BuffableStat):void{
			stat.advanceTime(rate, tick);
			Utils.extend(recentlyRemovedTags, stat.recentlyRemovedTags);
		},BuffableStat);
	}
	/**
	 * Remove all buffs with `rate == RATE_ROUNDS`.
	 *
	 * Will reset & populate `recentlyRemovedTags`
	 */
	public function removeCombatRoundTrackingBuffs():void {
		recentlyRemovedTags = {};
		forEachStat(function(stat:BuffableStat):void{
			stat.removeCombatRoundTrackingBuffs();
			Utils.extend(recentlyRemovedTags, stat.recentlyRemovedTags);
		},BuffableStat);
	}
	
	/**
	 * @param iter (IStat)=>any
	 */
	public function forEachStat(iter:Function,filter:Class=null):void {
		var queue:/*Object*/Array = [this];
		while (queue.length > 0) {
			var e:IStatHolder = queue.pop() as IStatHolder;
			if (e == null) continue;
			var stats:/*IStat*/Array = e.allStats();
			for each (var stat:IStat in stats) {
				if (!filter || stat is filter) {
					iter(stat);
				}
			}
			queue = queue.concat(stats);
		}
	}
	public function allStatsAndSubstats():/*IStat*/Array {
		var result:/*IStat*/Array = [];
		forEachStat(function(stat:IStat):void{
			result.push(stat);
		});
		return result;
	}

	/**
	 * Options are
	 * text, displayed text in buff description
	 * show, default true. If false, then the buff will be hidden in detalization. You'll still see total value but not the reason.
	 * save, default true. If false, then the buff will not be saved. It is useable for buffs from races, perks, and items - they should be auto-added
	 * rate, default Buff.RATE_PERMANENT. Other options are: RATE_ROUNDS, RATE_HOURS, RATE_DAYS. Used with ticks, see below.
	 * ticks, default 0. How many units of time (see rate) the buff will last until it will be auto-removed
	 */
	public function addBuff(stat:String, amount:Number, tag:String, options:*):void {
		var s:BuffableStat = findBuffableStat(stat);
		if (!s) {
			trace("/!\\ addBuff(" + stat + ", " + amount + ") in " + tag);
		}
		 else {
			s.addOrIncreaseBuff(tag, amount, options);
		}
	}

	public function removeBuffs(tag:String):void {
		forEachStat(function(stat:BuffableStat):void{
			stat.removeBuff(tag);
		},BuffableStat);
	}

	public function hasBuff(tag:String):Boolean {
		var result:Boolean = false;
		forEachStat(function(stat:BuffableStat):void{
			if (stat.hasBuff(tag)) result = true;
		},BuffableStat);
		return result;
	}
	public function buffObjects(tag:String):/*Buff*/Array {
		var result:/*Buff*/Array = [];
		forEachStat(function(stat:BuffableStat):void{
			var buff:Buff = stat.findBuff(tag);
			if (buff) result.push(buff);
		},BuffableStat);
		return result;
	}

	/**
	 * Add `amount` ticks to all buffs tagged `tag`.
	 * Does nothing if no such buffs or they are permanent
	 */
	public function addTicksToBuffs(tag: String, amount: Number):void {
		recentlyRemovedTags = {};
		forEachStat(function(stat:BuffableStat):void{
			stat.addTicksToBuff(tag, amount);
			Utils.extend(recentlyRemovedTags, stat.recentlyRemovedTags);
		},BuffableStat);
	}

	public function replaceBuffObject(buffs:Object, tag:String, options:*=null, evalContext:*=null):void {
		applyBuffObject(buffs, tag, options, evalContext, true);
	}
	public function addBuffObject(buffs:Object, tag:String, options:*=null, evalContext:*=null):void {
		applyBuffObject(buffs, tag, options, evalContext, false);
	}
	public function setBuffOptions(tag: String, options:*):void {
		if(!options) return;
		forEachStat(function(stat:BuffableStat):void{
			var buff:Buff = stat.findBuff(tag);
			if (buff) buff.options = options;
		}, BuffableStat);
	}
	private function applyBuffObject(buffs:Object, tag:String, options:*, evalContext:*, replaceMode:Boolean=false):void {
		for (var statname:String in buffs) {
			var buff:* = buffs[statname];
			var value:Number;
			if (buff is Number) {
				value = buff;
			} else if (buff is String) {
				value = Eval.eval(evalContext, buff);
			} else {
				trace("/!\\ applyBuffObject: " + tag + "/" + statname);
				value = +buff;
			}
			var s:BuffableStat = findBuffableStat(statname);
			if (!s) {
				trace("/!\\ addBuff(" + statname + ", " + value + ") in " + tag);
			} else if (replaceMode){
				s.addOrReplaceBuff(tag, value, options);
			} else {
				s.addOrIncreaseBuff(tag, value, options);
			}
		}
	}
}
}
