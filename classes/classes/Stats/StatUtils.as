/**
 * Coded by aimozg on 01.06.2018.
 */
package classes.Stats {
import classes.Creature;
import classes.internals.Utils;

import coc.script.Eval;

import flash.sampler.startSampling;

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

	/**
	 * Returns a multi-line string of "BuffName: +20"
	 * @param asPercent show "+20%" instead of "+0.2"
	 * @param includeHidden show hidden buffs
	 */
	public static function describeBuffs(stat:BuffableStat, asPercent:Boolean, isPositiveStat:Boolean = true, includeHidden:Boolean = false, IncludePerkBuff:Boolean = false):String {
		var buffs:/*Buff*/Array = stat.listBuffs();
		var hasHidden:Boolean = false;
		var text:String = "";
		var PerkBuff:Number = 0;
		for each(var buff:Buff in buffs) {
			var value:Number = buff.value;
			if (buff.tag.indexOf("perk_") == 0 && !IncludePerkBuff)
			{
				PerkBuff = PerkBuff+buff.value;
			}
			else{
				if (value >= 0.0 && value < 0.01) continue;
				if (!buff.show && !includeHidden) {
					hasHidden = true;
					continue;
				}
				if (isPositiveStat) {
					if (value > 0) text += '<font color="#008000">';
					else text += '<font color="#800000">';
				}
				if (!isPositiveStat) {
					if (value > 0) text += '<font color="#800000">';
					else text += '<font color="#008000">';
				}
				text += '<b>' + buff.text + ':</b> ';
				if (asPercent) {
					text += (value >= 0 ? '+' : '') + Utils.floor(value * 100) + '%';
				} else {
					text += (value >= 0 ? '+' : '') + Utils.floor(value, 1);
				}
				if (buff.rate != Buff.RATE_PERMANENT) {
					text += ' ('+Utils.numberOfThings(buff.tick, {
						([Buff.RATE_ROUNDS]):'round',
						([Buff.RATE_HOURS]):'hour',
						([Buff.RATE_DAYS]):'day'
					}[buff.rate])+')'
				}
				text += '\n';
				text += "</font>";
				//if (!isPositiveStat) text += '<font color="#800000">'
				//if (isPositiveStat) text = "<font color=\"#008000\">"+text+"</font>";
			}
		}
		if (PerkBuff != 0)
		{
			if (isPositiveStat) {
				if (PerkBuff > 0) text += '<font color="#008000">';
				else text += '<font color="#800000">';
			}
			if (!isPositiveStat) {
				if (PerkBuff > 0) text += '<font color="#800000">';
				else text += '<font color="#008000">';
			}
			text += "<b>Perk:</b> ";
			if (asPercent) {
				text += (PerkBuff >= 0 ? '+' : '') + Utils.floor(PerkBuff * 100) + '%';
			} else {
				text += (PerkBuff >= 0 ? '+' : '') + Utils.floor(PerkBuff, 1);
			}
			text += "</font>";
		}
		if (hasHidden) text += '<b>Unknown Sources:</b> ±??';
		return text;
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
		return !(statname in PlainNumberStats);
	}
	public static function isPercentageStat(statname:String):Boolean {
		return statname in PercentageStats;
	}
	public static const PlainNumberStats:Object = Utils.createMapFromPairs([
		// [StatNames.STR, 'Strength']
		["str", "Strength"],
		["tou", "Toughness"],
		["spe", "Speed"],
		["int", "Intelligence"],
		["wis", "Wisdom"],
		["lib", "Libido"],
		["sens", "Sensitivity"],

		["str.core", "Strength"],
		["tou.core", "Toughness"],
		["spe.core", "Speed"],
		["int.core", "Intelligence"],
		["wis.core", "Wisdom"],
		["lib.core", "Libido"],
		["sens.core", "Sensitivity"],

		["str.bonus", "Strength"],
		["tou.bonus", "Toughness"],
		["spe.bonus", "Speed"],
		["int.bonus", "Intelligence"],
		["wis.bonus", "Wisdom"],
		["lib.bonus", "Libido"],
		["sens.bonus", "Sensitivity"],

		["maxhp_base", "Max HP"],
		['maxlust_base', "Max Lust"],
		['maxwrath_base', "Max Wrath"],
		['maxfatigue_base', "Max Fatigue"],
		['maxmana_base', "Max Mana"],
		['maxsf_base', "Max Soulforce"],
		
		['maxlust_perlib', "Max Lust per libido"],
		['maxfatigue_perspe', "Max Fatigue per speed"],
		['maxmana_perint', "Max Mana per intelligence"],
		['maxmana_perwis', "Max Mana per wisdom"],
		['maxsf_perwis', "Max Soulforce per wisdom"],

		["maxhp_perlevel", "Max HP per level"],
		['maxlust_perlevel', "Max Lust per level"],
		['maxwrath_perlevel', "Max Wrath per level"],
		['maxfatigue_perlevel', "Max Fatigue per level"],
		['maxmana_perlevel', "Max Mana per level"],
		['maxsf_perlevel', "Max Soulforce per level"],
	]);
	public static const PercentageStats:Object = Utils.createMapFromPairs([
		// [StatNames.SPELLPOWER, 'Spellpower']
		["str.mult", "Strength"],
		["tou.mult", "Toughness"],
		["spe.mult", "Speed"],
		["int.mult", "Intelligence"],
		["wis.mult", "Wisdom"],
		["lib.mult", "Libido"],
		
		["maxhp_mult", "Max HP"],
		['maxlust_mult', "Max Lust"],
		['maxwrath_mult', "Max Wrath"],
		['maxfatigue_mult', "Max Fatigue"],
		['maxmana_mult', "Max Mana"],
		['maxsf_mult', "Max Soulforce"],
		
		['spellpower', "Spellpower"],
	]);
}
}
