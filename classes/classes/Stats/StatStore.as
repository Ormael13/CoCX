/**
 * Coded by aimozg on 01.08.2018.
 */
package classes.Stats {
import classes.internals.Utils;

import coc.script.Eval;

public class StatStore implements IStatHolder {
	private var _stats:Object = {};
	/**
	 * @param setup object { [statName:String] => IStat }
	 */
	public function StatStore(setup:Object =null) {
		if (setup) addStats(setup);
	}
	public function findStat(fullname:String):IStat {
		if (fullname.indexOf('.') == -1) return _stats[fullname];
		return StatUtils.findStatByPath(this, fullname);
	}
	public function addStats(setup:Object):StatStore {
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
	 * Buffs with their countdown expired are removed
	 */
	public function advanceTime(rate:int, ticks:int):void {
		forEachStat(function(stat:BuffableStat):void{
			stat.advanceTime(rate, ticks)
		},BuffableStat);
	}
	public function removeCombatRoundTrackingBuffs():void {
		forEachStat(function(stat:BuffableStat):void{
			stat.removeCombatRoundTrackingBuffs()
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
	
	public function addBuff(stat:String, amount:Number, tag:String, options:*):void {
		var s:BuffableStat = findBuffableStat(stat);
		if (!s) {
			trace("/!\\ addBuff(" + stat + ", " + amount + ") in " + tag);
		} else {
			s.addOrIncreaseBuff(tag, amount, options);
		}
	}
	public function removeBuffs(tag:String):void {
		forEachStat(function(stat:BuffableStat):void{
			stat.removeBuff(tag);
		},BuffableStat);
	}
	
	public function replaceBuffObject(buffs:Object, tag:String, options:*=null, evalContext:*=null):void {
		applyBuffObject(buffs, tag, options, evalContext, true);
	}
	public function addBuffObject(buffs:Object, tag:String, options:*=null, evalContext:*=null):void {
		applyBuffObject(buffs, tag, options, evalContext, false);
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
