/**
 * Coded by aimozg on 06.05.2018.
 */
package classes.Stats {
import classes.Creature;
import classes.internals.Jsonable;
import classes.internals.Utils;

public class RawStat implements IStat,Jsonable {
	
	private var _min:Number   = -Infinity;
	private var _max:Number   = +Infinity;
	private var _value:Number = 0;
	private var _name:String;
	private var _host:Creature;
	
	/**
	 * @param options Options object:
	 * value: default 0;
	 * min: default -Infinity
	 * max: default +Infinity
	 */
	public function RawStat(owner:Creature, name:String, options:*=null) {
		options = Utils.extend({
			value:0.0,
			min:-Infinity,
			max:+Infinity
		},options);
		this._name = name;
		this._value = options['value'];
		this._min = options['min'];
		this._max = options['max'];
		this._host = owner;
	}
	
	
	public function get host():Creature {
		return _host;
	}
	
	public function get statName():String {
		return _name;
	}
	
	public function get min():Number {
		return _min;
	}
	public function set min(value:Number):void {
		_min = value;
	}
	public function get max():Number {
		return _max;
	}
	public function set max(value:Number):void {
		_max = value;
	}
	public function get value():Number {
		return Utils.boundFloat(min,_value,max);
	}
	public function set value(value:Number):void {
		_value = value;
	}
	public function saveToObject():Object {
		return {value:_value};
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		var x:* = o['value'];
		if (typeof x != 'number') {
			var errmsg:String = "Expected number, got " + (typeof x) + " " + x;
			if (!ignoreErrors) throw errmsg;
			else trace(errmsg);
			x = 0.0;
		}
		_value = x;
	}
}
}
