/**
 * Coded by aimozg on 30.05.2018.
 */
package classes.Stats {
import classes.internals.Jsonable;
import classes.internals.Utils;

public class Buff implements Jsonable {
	private var _tag:String;
	public var rawValue:Number;
	public var save:Boolean;
	public var text:String;
	public var show:Boolean;
	public var rate:int;
	public var tick:int;
	private var _stat:BuffableStat;
	
	public static const RATE_PERMANENT:int = 0;
	public static const RATE_ROUNDS:int    = 1;
	public static const RATE_HOURS:int     = 2;
	public static const RATE_DAYS:int      = 3;
	
	public function get stat():BuffableStat {
		return _stat;
	}
	public function Buff(stat:BuffableStat, value:Number,tag:String,save:Boolean=true,show:Boolean=true,text:String=null) {
		this._stat    = stat;
		this.rawValue = value;
		this._tag     = tag;
		this.save     = save;
		this.show     = show;
		this.text     = (text === null) ? Utils.capitalizeFirstLetter(tag) : text;
		this.rate     = RATE_PERMANENT;
		this.tick     = 0;
	}
	public function withOptions(options:Object):Buff {
		this.options = options;
		return this;
	}
	public function get options():Object {
		return {save:save,show:show,text:text,rate:rate,tick:tick};
	}
	public function set options(value:Object):void {
		if (!value) return;
		if ('save' in value) this.save = value.save;
		if ('text' in value) this.text = value.text;
		if ('show' in value) this.show = value.show;
		if ('rate' in value) this.rate = value.rate;
		if ('tick' in value) this.tick = value.tick;
	}
	public function saveToObject():Object {
		return [rawValue,_tag,options];
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o is Array) {
			rawValue = +o[0];
			_tag     = o[1];
			options  = o[2];
			return;
		}
		if (ignoreErrors) {
			return;
		}
		throw "Not a valid Buff: "+o;
	}
	
	public function get tag():String {
		return _tag;
	}
	public function get value():Number {
		return rawValue;
	}
	public function set value(value:Number):void {
		rawValue = value;
		_stat.recalculate();
	}
}
}
