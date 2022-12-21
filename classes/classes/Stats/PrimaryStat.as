/**
 * Coded by aimozg on 06.05.2018.
 */
package classes.Stats {
import classes.Creature;
import classes.internals.Jsonable;
import classes.internals.Utils;

public class PrimaryStat implements IStat,IStatHolder,Jsonable {
	private var _core:RawStat;
	private var _train:RawStat;
	private var _mult:BuffableStat;
	private var _bonus:BuffableStat;
	private var _name:String;
	private var _host:Creature;
	private var _substats:Object;
	
	public function reset(core:Number):void {
		_core.value = core;
		_train.value = 0;
		_mult.removeAllBuffs();
		_bonus.removeAllBuffs();
	}
	public function removeAllEffects():void {
		_mult.removeAllBuffs();
		_bonus.removeAllBuffs();
	}
	public function removeEffect(tag:String):void {
		_mult.removeBuff(tag);
		_bonus.removeBuff(tag);
	}
	
	public function get core():RawStat {
		return _core;
	}
	public function get train():RawStat {
		return _train;
	}
	public function get mult():BuffableStat {
		return _mult;
	}
	public function get bonus():BuffableStat {
		return _bonus;
	}
	public function get mult100():int {
		return Math.floor(_mult.value*100);
	}
	public function PrimaryStat(host:Creature, name:String) {
		_name = name;
		_host = host;
		_core = new CoreStat(host,name+'.core');
		_train = new TrainingStat(host, name+'.train');
		_mult = new BuffableStat(host,name+'.mult', {base:1.0,min:0});
		_bonus = new BuffableStat(host,name+'.bonus', {});
		_substats = {
			"core": _core,
			"train": _train,
			"mult": _mult,
			"bonus": _bonus
		};
	}
	
	
	public function get host():Creature {
		return _host;
	}
	
	public function get statName():String {
		return _name;
	}
	public function findStat(fullname:String):IStat {
		if (fullname.indexOf('.') == -1) return _substats[fullname];
		return StatUtils.findStatByPath(this, fullname);
	}
	public function allStats():Array {
		return Utils.values(_substats);
	}
	public function allStatNames():Array {
		return Utils.keys(_substats);
	}
	public function get trainMultValue():Number {
		return (mult.value+1)/2;
	}
	public function get value():Number {
		return Math.max(min, core.value * mult.value + train.value * trainMultValue + bonus.value);
	}
	public function get totalCore():Number {
		return Math.max(min, core.value + train.value);
	}
	public function get min():Number {
		return 1;
	}
	public function get max():Number {
		return core.max * mult.value + train.max * trainMultValue + Math.max(0, bonus.value);
	}
	
	public function saveToObject():Object {
		return {
			core:core.saveToObject(),
			train:train.saveToObject(),
			mult:mult.saveToObject(),
			bonus:bonus.saveToObject()
		};
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (typeof o.core == 'number') {
			core.value = o.core;
		} else {
			core.loadFromObject(o.core, ignoreErrors)
		}
		if (o.train) {
			train.loadFromObject(o.train, ignoreErrors);
		}
		mult.loadFromObject(o.mult,ignoreErrors);
		bonus.loadFromObject(o.bonus,ignoreErrors);
	}
}
}
