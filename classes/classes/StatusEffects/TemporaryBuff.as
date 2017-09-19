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
	private var stat1:String;
	private var stat2:String;
	private var stat3:String;
	private var stat4:String;
	public function TemporaryBuff(stype:StatusEffectType, stat1:String, stat2:String ='', stat3:String ='', stat4:String ='') {
		super(stype);
		this.stat1 = stat1;
		this.stat2 = stat2;
		this.stat3 = stat3;
		this.stat4 = stat4;
	}
	/**
	 * This function does a host.dynStats(...args) and stores the buff in status effect values
	 */
	protected function buffHost(...args):* {
		var buff:* = host.dynStats.apply(host,args);
		if (stat1) value1 += buff[stat1];
		if (stat2) value2 += buff[stat2];
		if (stat3) value3 += buff[stat3];
		if (stat4) value4 += buff[stat4];
		LOGGER.debug("buffHost("+args.join(",")+"): " +
					 stat1+(stat1?buff[stat1]:"")+
					 stat2+(stat2?buff[stat2]:"")+
					 stat3+(stat3?buff[stat3]:"")+
					 stat4+(stat4?buff[stat4]:"")+
					 "->("+value1+", "+value2+", "+value3+", "+value4+")");
		return buff;
	}
	protected function restore():void {
		var dsargs:Array = ['scale',false];
		if (stat1) dsargs.push(stat1,-value1);
		if (stat2) dsargs.push(stat2,-value2);
		if (stat3) dsargs.push(stat3,-value3);
		if (stat4) dsargs.push(stat4,-value4);
		var debuff:* = host.dynStats.apply(host,dsargs);
		if (stat1) value1 += debuff[stat1];
		if (stat2) value2 += debuff[stat2];
		if (stat3) value3 += debuff[stat3];
		if (stat4) value4 += debuff[stat4];
		LOGGER.debug("restore("+dsargs.join(",")+"): " +
					 stat1+" "+(stat1?debuff[stat1]:"")+" "+
					 stat2+" "+(stat2?debuff[stat2]:"")+" "+
					 stat3+" "+(stat3?debuff[stat3]:"")+" "+
					 stat4+" "+(stat4?debuff[stat4]:"")+" "+
					 "->("+value1+", "+value2+", "+value3+", "+value4+")");
	}
	public function buffValue(stat:String):Number {
		switch (stat) {
			case stat1:return value1;
			case stat2:return value2;
			case stat3:return value3;
			case stat4:return value4;
			default: return 0;
		}
	}
	protected function apply(firstTime:Boolean):void {
	}
	override public function onAttach():void {
		super.onAttach();
		apply(true);
	}
	public function increase():void {
		if (host == null) return;
		apply(false);
	}
	override public function onRemove():void {
		super.onRemove();
		restore();
	}
}
}
