package classes.StatusEffects {
import classes.StatusEffectClass;
import classes.StatusEffectType;
import classes.internals.LoggerFactory;

import mx.logging.ILogger;

/**
 * Common superclass for temporary stat [de]buffs with complete recovery after time.
 *
 * Implementation details:
 * 1. Subclass. Pass affected stat names (dynStat keys like 'str','spe','tou','int','lib','sen') as superclass
 *    constructor args.
 * 2. Override apply() with a call to buffHost to buff host and remember effect
 * 3. To apply buff, add it to host; call increase() on already existing buff to increase it effect
 *
 * Using host.dynStats instead of buffHost makes the effect permanent
 */
public class TemporaryBuff extends StatusEffectClass{
	private static var LOGGER:ILogger = LoggerFactory.getLogger(TemporaryBuff);
	private var _stat1:String;
	private var _stat2:String;
	private var _stat3:String;
	private var _stat4:String;
	public function TemporaryBuff(stype:StatusEffectType, stat1:String, stat2:String ='', stat3:String ='', stat4:String ='') {
		super(stype);
		this._stat1 = stat1;
		this._stat2 = stat2;
		this._stat3 = stat3;
		this._stat4 = stat4;
	}
	
	public function get stat1():String {
		return _stat1;
	}
	public function get stat2():String {
		return _stat2;
	}
	public function get stat3():String {
		return _stat3;
	}
	public function get stat4():String {
		return _stat4;
	}
	/**
	 * This function does a host.dynStats(...args) and stores the buff in status effect values
	 */
	protected function buffHost(...args):* {
		var buff:* = host.dynStats.apply(host,args);
		if (_stat1) value1 += buff[_stat1];
		if (_stat2) value2 += buff[_stat2];
		if (_stat3) value3 += buff[_stat3];
		if (_stat4) value4 += buff[_stat4];
		LOGGER.debug("buffHost(" + args.join(",") + "): " +
					 _stat1 + (_stat1?buff[_stat1]:"") +
					 _stat2 + (_stat2?buff[_stat2]:"") +
					 _stat3 + (_stat3?buff[_stat3]:"") +
					 _stat4 + (_stat4?buff[_stat4]:"") +
					 "->(" + value1 + ", " + value2 + ", " + value3 + ", " + value4 + ")");
		return buff;
	}
	protected function restore():void {
		var dsargs:Array = ['scale',false];
		if (_stat1) dsargs.push(_stat1,-value1);
		if (_stat2) dsargs.push(_stat2,-value2);
		if (_stat3) dsargs.push(_stat3,-value3);
		if (_stat4) dsargs.push(_stat4,-value4);
		var debuff:* = host.dynStats.apply(host,dsargs);
		if (_stat1) value1 += debuff[_stat1];
		if (_stat2) value2 += debuff[_stat2];
		if (_stat3) value3 += debuff[_stat3];
		if (_stat4) value4 += debuff[_stat4];
		LOGGER.debug("restore(" + dsargs.join(",") + "): " +
					 _stat1 + " " + (_stat1?debuff[_stat1]:"") + " " +
					 _stat2 + " " + (_stat2?debuff[_stat2]:"") + " " +
					 _stat3 + " " + (_stat3?debuff[_stat3]:"") + " " +
					 _stat4 + " " + (_stat4?debuff[_stat4]:"") + " " +
					 "->(" + value1 + ", " + value2 + ", " + value3 + ", " + value4 + ")");
	}
	public function buffValue(stat:String):Number {
		switch (stat) {
			case _stat1:return value1;
			case _stat2:return value2;
			case _stat3:return value3;
			case _stat4:return value4;
			default: return 0;
		}
	}
	override public function onRemove():void {
		super.onRemove();
		restore();
	}
}
}
