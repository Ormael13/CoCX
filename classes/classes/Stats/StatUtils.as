/**
 * Coded by aimozg on 01.06.2018.
 */
package classes.Stats {
import classes.Creature;
import classes.internals.Utils;

import coc.script.Eval;

public class StatUtils {
	public function StatUtils() {
	}
	
	/**
	 * Warning: can cause infinite recursion if called from owner.findStat() unchecked
	 */
	public static function findStatByPath(owner:IStatHolder, path:String):IStat {
		var parts:Array = path.split(/\./);
		var s:IStat;
		for (var i:int = 0; i<parts.length; i++) {
			if (!owner) break;
			s = owner.findStat(parts[i]);
			owner = s as IStatHolder;
		}
		return s;
	}
	
	/**
	 * Returns string like "Strength +10" or "Spell Power -50%"
	 */
	public static function explainBuff(stat:String,value:Number):String {
		return explainStat(stat,value,true);
	}
	/**
	 * Returns string like "Strength 10" or "Spell Power -50%"
	 * if withSignum = true, positive values have "+"
	 */
	public static function explainStat(stat:String,value:Number,withSignum:Boolean=false):String {
		var signum:String  = (value >= 0 && withSignum ? '+' : '');
		var x:String       = signum + value;
		
		if (stat in PlainNumberStats) {
			return PlainNumberStats[stat]+' '+x;
		}
		var percent:String = signum + Math.floor(value * 100) + '%';
		if (stat in PercentageStats) {
			return PercentageStats[stat]+' '+percent;
		}
		trace('[WARN] Unexplainable stat '+stat);
		return stat+' '+x;
	}
	public static function nameOfStat(stat:String):String {
		if (stat in PlainNumberStats) {
			return PlainNumberStats[stat];
		} else if (stat in PercentageStats) {
			return PercentageStats[stat];
		} else {
			trace('[WARN] Unknown stat '+stat);
			return stat;
		}
	}
	public static function isPlainNumberStat(statname:String):Boolean {
		return statname in PlainNumberStats;
	}
	public static function isPercentageStat(statname:String):Boolean {
		return statname in PlainNumberStats;
	}
	public static const PlainNumberStats:Object = Utils.createMapFromPairs([
		// [StatNames.STR, 'Strength']
	]);
	public static const PercentageStats:Object = Utils.createMapFromPairs([
		// [StatNames.SPELLPOWER, 'Spellpower']
	]);
}
}
