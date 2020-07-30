/**
 * Coded by aimozg on 06.05.2018.
 */
package classes.Stats {
import classes.internals.Jsonable;
import classes.internals.Utils;

public class RawStat implements IStat,Jsonable {
	
	private var _min:Number   = -Infinity;
	private var _max:Number   = +Infinity;
	private var _value:Number = 0;
	
	/**
	 * @param options Options object:
	 * value: default 0;
	 * min: default -Infinity
	 * max: default +Infinity
	 */
	public function RawStat(options:*=null) {
		options = Utils.extend({
			value:0.0,
			min:-Infinity,
			max:+Infinity
		},options);
		this._value = options['value'];
		this._min = options['min'];
		this._max = options['max'];
	}
	
	public function get min():Number {
		return _min;
	}
	public function set min(value:Number):void {
		_min = value;
		_value = Utils.boundFloat(min,value,max);
	}
	public function get max():Number {
		return _max;
	}
	public function set max(value:Number):void {
		_max = value;
		_value = Utils.boundFloat(min,value,max);
	}
	public function get value():Number {
		return _value;
	}
	public function set value(value:Number):void {
		_value = Utils.boundFloat(min,value,max);
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
