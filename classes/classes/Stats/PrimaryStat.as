/**
 * Coded by aimozg on 06.05.2018.
 */
package classes.Stats {
import classes.internals.Jsonable;
import classes.internals.Utils;

public class PrimaryStat implements IStat,IStatHolder,Jsonable {
	private var _core:RawStat = new RawStat({value:1,min:1,max:100});
	private var _mult:BuffableStat = new BuffableStat({base:1.0,min:0});
	private var _bonus:BuffableStat = new BuffableStat({});
	private var _substats:Object = {
		"core": _core,
		"mult": _mult,
		"bonus": _bonus
	};
	
	public function reset(core:Number):void {
		_core.value = core;
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
	public function get mult():BuffableStat {
		return _mult;
	}
	public function get bonus():BuffableStat {
		return _bonus;
	}
	public function get mult100():int {
		return Math.floor(_mult.value*100);
	}
	public function PrimaryStat() {
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
	public function get value():Number {
		return Math.max(min, core.value * mult.value + bonus.value);
	}
	public function get min():Number {
		return 1;
	}
	public function get max():Number {
		return core.max * mult.value + Math.max(0, bonus.value);
	}
	
	public function saveToObject():Object {
		return {
			core:core.saveToObject(),
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
		mult.loadFromObject(o.mult,ignoreErrors);
		bonus.loadFromObject(o.bonus,ignoreErrors);
	}
}
}
