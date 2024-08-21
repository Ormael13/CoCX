/**
 * Coded by aimozg on 01.06.2018.
 */
package classes.Stats {
import classes.Parser.Parser;
import classes.internals.Utils;

public class StatUtils {
	public function StatUtils() {
	}
	
	public static function inverseBuffObject(src:Object):Object {
		var dest:Object = {};
		for (var key:String in src) {
			var v:Number = src[key];
			if (MultiplicativeStats.indexOf(key) >= 0) {
				dest[key] = 1.0/v;
			} else {
				dest[key] = -v;
			}
		}
		return dest;
	}
	/**
	 * Merge `src` into `dest`, producing sum/product of common keys
	 * @return dest
	 */
	public static function mergeBuffObjects(dest:Object, src:Object):Object {
		if (!dest) dest = {};
		for (var key:String in src) {
			addBuffToObject(dest, key, src[key]);
		}
		return dest;
	}
	public static function addBuffToObject(dest:Object, statName:String, value:Number):Object {
		if (!dest) dest = {};
		if (statName in dest) {
			if (MultiplicativeStats.indexOf(statName) >= 0) {
				dest[statName] *= value;
			} else {
				dest[statName] += value;
			}
		} else {
			dest[statName] = value;
		}
		return dest;
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
		// fix rounding errors (1.15*100 = 114.999999...)
		if (value > 0) value += 0.001;
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
					if (value > 0) text += "[font-dgreen]";
					else text += "[font-dred]";
				}
				if (!isPositiveStat) {
					if (value > 0) text += "[font-dred]";
					else text += "[font-dgreen]";
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
				text += "[/font]";
				//if (!isPositiveStat) text += '[font-dred]'
				//if (isPositiveStat) text = "[font-green]"+text+"[/font]";
			}
		}
		if (PerkBuff != 0)
		{
			if (isPositiveStat) {
				if (PerkBuff > 0) text += "[font-dgreen]";
				else text += "[font-dred]";
			}
			if (!isPositiveStat) {
				if (PerkBuff > 0) text += "[font-dred]";
				else text += "[font-dgreen]";
			}
			text += "<b>Perk:</b> ";
			if (asPercent) {
				text += (PerkBuff >= 0 ? '+' : '') + Utils.floor(PerkBuff * 100) + '%';
			} else {
				text += (PerkBuff >= 0 ? '+' : '') + Utils.floor(PerkBuff, 1);
			}
			text += "[/font]";
		}
		if (hasHidden) text += '<b>Unknown Sources:</b> ±??';
		text = Parser.recursiveParser(text);
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
	public static function isKnownStat(stat:String):Boolean {
		return stat in PlainNumberStats || stat in PercentageStats;
	}
	public static function isPlainNumberStat(statname:String):Boolean {
		return statname in PlainNumberStats;
	}
	public static function isPercentageStat(statname:String):Boolean {
		return statname in PercentageStats;
	}
	public static function validateBuffObject(buffs:Object, errorContext:String=""):void {
		for (var buff:String in buffs) validateBuff(buff, errorContext);
	}
	public static function validateBuff(statname:String, errorContext:String=""):void {
		if (!isKnownStat(statname)) {
			trace("[ERROR] Unknown stat "+statname+" "+errorContext);
		}
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

		["minlust", "Min Lust"],
		
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
		
		['def', 'Armor'],
		['mdef', 'Magic Resistance'], // armor mdef stat
		['rangedaccuracy', "Ranged Accuracy"],
		['teasedmg', "Tease Power"],
		['evade', "Evasion"],
		
		['res_physical', 'Resistance (Physical)'],
		['res_magic', 'Resistance (Magic)'], // atm works same way as 'mdef'
		['res_lust', 'Resistance (Lust)'],
		['res_fire', 'Resistance (Fire)'],
		['res_ice', 'Resistance (Ice)'],
		['res_lightning', 'Resistance (Lightning)'],
		['res_darkness', 'Resistance (Darkness)'],
		['res_poison', 'Resistance (Poison)'],
		['res_wind', 'Resistance (Wind)'],
		['res_water', 'Resistance (Water)'],
		['res_earth', 'Resistance (Earth)'],
		['res_acid', 'Resistance (Acid)'],
		
		// These are not IStats, but can be used in 'property id -> readable string' conversion
		['cor', 'Corruption'],
		['thickness', 'Thickness'],
		['tone', 'Muscle Tone'],
		['femininity', 'Femininity'],
	]);
	public static const PercentageStats:Object = Utils.createMapFromPairs([
		// [StatNames.SPELLPOWER, 'Spellpower']
		["str.mult", "Strength"],
		["tou.mult", "Toughness"],
		["spe.mult", "Speed"],
		["int.mult", "Intelligence"],
		["wis.mult", "Wisdom"],
		["lib.mult", "Libido"],
		
		["minlustx", "Min Lust"],
		
		["maxhp_mult", "Max HP"],
		['maxlust_mult', "Max Lust"],
		['maxwrath_mult', "Max Wrath"],
		['maxfatigue_mult', "Max Fatigue"],
		['maxmana_mult', "Max Mana"],
		['maxsf_mult', "Max Soulforce"],
		
		['spellpower', "Spellpower"],
		['spellcost', "Spell Cost"],
		['soulskillcost', "Soulskill Cost"],
		['psoulskillpower', "Physical Soulskill Power"],
		['msoulskillpower', "Magical Soulskill Power"],
	]);
	public static const MultiplicativeStats:/*String*/Array = [];
	
	/**
	 * List of racial buff names that should get scaled with NG+
	 */
	public static const  NgScaledRacialBuffs:/*String*/Array = [
		"maxhp_base",
		'maxlust_base',
		'maxwrath_base',
		'maxfatigue_base',
		'maxmana_base',
		'maxsf_base',
		'def'
	];
}
}
