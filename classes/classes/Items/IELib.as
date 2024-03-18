package classes.Items {
import classes.ItemType;
import classes.Items.Effects.DescriptionFnItemEffect;
import classes.Items.Effects.SimpleItemEffect;
import classes.Race;
import classes.Races;
import classes.internals.Utils;

/**
 * Item effects library
 */
public class IELib extends ItemConstants {
	
	//======================================//
	// Template for new simple item effects //
	//======================================//
	
	//	/**
	//	 * Add (power) to something
	//	 * - value1:Type = if effect has value1, explain here, otherwise delete this line
	//	 */
	//	public static const ItemEffectName:ItemEffectType = mk("ItemEffectName", "Tooltip display, +{power} to something");
	
	// ItemEffectName is for debugging, can be non-unique or changed between games
	// Description formatting exampless:
	//      if power = 34.567 then
	// "{power}"     = "34.567"   // use default Flash number format
	// "{power;d}"   = "35"       // round to integer
	// "{power;2f}"  = "34.57"    // 2 decimals
	// "{power;4f}"  = "34.5670"  // 4 decimals
	// "{power;2F}"  = "34.57"    // max. 2 decimals
	// "{power;4F}"  = "34.567"   // max. 4 decimals
	// "{power;+d}"  = "+35"      // always signed
	// "{power;+1f}" = "+34.6"    // always signed
	// {} can contain expressions, ex. "{power*100;d}%"
	
	//===============================================//
	// Template for effects with complex description //
	//===============================================//
	
	//	/**
	//	 * Add (power) to something
	//	 * - value1:Type = if effect has value1, explain here, otherwise delete this line
	//	 */
	//	public static const ItemEffectName:ItemEffectType = mkfn("ItemEffectName",
	//			function (ie:ItemEffect, item:ItemType):String {
	//				return "Add "+ie.power+" to "+ie.value1+" and the rest of tooltip text."
	//			}
	//			);
	
	//================//
	// All equipables //
	//================//
	
	/** must have corruption >= (power) to equip */
	public static const Require_Cor:ItemEffectType = mk("Require_Cor", "Requires corruption {power} or more").withFlags(IEF_REQUIREMENT);
	/** must have corruption < (power) to equip */
	public static const Require_CorBelow:ItemEffectType = mk("Require_CorBelow", "Requires coruption less than {power}").withFlags(IEF_REQUIREMENT);
	/** Change min femininity by (+power) */
	public static const MinFem:ItemEffectType = mk("MinFem", "Min. femininity {power;+d}")
	/** Change max femininity by (power). Power should be negative */
	public static const MaxFem:ItemEffectType = mk("MaxFem", "Max. femininity {power;+d}")
	/** increase XP gain by (power)% */
	public static const BonusXp:ItemEffectType = mk("BonusXp", "XP gain {power;+d}%")
	/** power doesn't matter */
	public static const TfImmunity:ItemEffectType = mk("TfImmunity", "Transformation immunity")
	/**
	 * Add (power)% to spellpower per racial tier.
	 * - value1:Race = race to check (Races.XXXX, not race id)
	 */
	public static const Spellpower_RaceTier:ItemEffectType = mkfn("Spellpower_RaceTier",
			function (ie:ItemEffect, item:ItemType):String {
				return Utils.substitute("{power;+d}% spellpower per {race} racial tier", ie, {
					race: (ie.value1 as Race).name
				})
			});
	/**
	 * Add (power)% to spellpower. Effect player for certain race.
	 * - value1:Race = race to check (Races.XXXX, not race id)
	 */
	public static const Spellpower_RaceX2:ItemEffectType = mkfn("Spellpower_RaceX2",
			function (ie:ItemEffect, item:ItemType):String {
				return Utils.substitute("{power;+d}% spellpower. Effect doubled for {race} race", ie, {
					race: (ie.value1 as Race).name
				})
			});
	/**
	 * Add (power)% to tease power. Effect player for certain race.
	 * - value1:Race = race to check (Races.XXXX, not race id)
	 */
	public static const Tease_RaceX2:ItemEffectType = mkfn("Tease_RaceX2",
			function (ie:ItemEffect, item:ItemType):String {
				return Utils.substitute("{power;+d}% tease potency. Effect doubled for {race} race", ie, {
					race: (ie.value1 as Race).name
				})
			});
	
	//===================//
	// Shields and armor //
	//===================//
	/**
	 * Add (power)% to defensse per racial tier.
	 * - value1:Race = race to check (Races.XXXX, not race id)
	 */
	public static const DefenseMult_RaceTier:ItemEffectType  = mkfn("DefenseMult_RaceTier",
			function (ie:ItemEffect, item:ItemType):String {
				return Utils.substitute("{power;+d}% defense per {race} racial tier", ie, {
					race: (ie.value1 as Race).name
				})
			}).withFlags(IEF_DEFENSE);
	
	//============================//
	// Weapons (melee and ranged) //
	//============================//
	
	
	//=================//
	// Weapons (melee) //
	//=================//
	
	/** reduce enemy armor by (power) % */
	public static const ArmorPenetration:ItemEffectType = mk("ArmorPenetration", "Armor Penetration {power}%");
	/** subtract (power) from enemy armor */
	public static const ArmorReduction:ItemEffectType = mk("ArmorReduction", "Armor Penetration {power}");
	/** power = stun chance in % */
	public static const Stun:ItemEffectType = mk("Stun", "Stun {power;+d}%");
	/** power = bleed chance in % */
	public static const Bleed:ItemEffectType = mk("Bleed", "Bleed {power;+d}%");
	/** Add (power*corruption) to base attack. Can be negative. */
	public static const AttackBonus_Cor:ItemEffectType = mk("AttackBonus_Cor", "{power;+2F} attack per corruption").withFlags(IEF_ATTACK);
	/** Add (power*(100-corruption)) to base attack. Can be negative. */
	public static const AttackBonus_Purity:ItemEffectType = mk("AttackBonus_Purity", "{power;+2F} attack per purity").withFlags(IEF_ATTACK);
	/** Add (power*femininity) to base attack. Can be negative. */
	public static const AttackBonus_Fem:ItemEffectType = mk("AttackBonus_Fem", "{power;+2F} attack per femininity").withFlags(IEF_ATTACK);
	/** Add (power*(100-femininity))% to base attack. Can be negative. */
	public static const AttackBonus_Masc:ItemEffectType = mk("AttackBonus_Masc", "{power;+2F} attack per masculinity").withFlags(IEF_ATTACK);
	/**
	 * Add (power) to attack per racial tier.
	 * - value1:Race = race to check (Races.XXXX, not race id)
	 */
	public static const AttackBonus_RaceTier:ItemEffectType = mkfn("AttackBonus_RaceTier",
			function (ie:ItemEffect, item:ItemType):String {
				return Utils.substitute("{power;+2F} attack per {race} racial tier", ie, {
					race: (ie.value1 as Race).name
				})
			}).withFlags(IEF_ATTACK);
	/**
	 * Add (power)% to attack per racial tier.
	 * - value1:Race = race to check (Races.XXXX, not race id)
	 */
	public static const AttackMult_RaceTier:ItemEffectType  = mkfn("AttackMult_RaceTier",
			function (ie:ItemEffect, item:ItemType):String {
				return Utils.substitute("{power;+d}% attack per {race} racial tier", ie, {
					race: (ie.value1 as Race).name
				})
			}).withFlags(IEF_ATTACK);
	/**
	 * Require (power) strength for full power.
	 * * 50% attack at 75% required strength,
	 * * 25% attack at 50% required strength,
	 * * 5% attack (min. 1) if below
	 * */
	public static const ScaleAttack_Str:ItemEffectType = mk("ScaleAttack_Str", "Full power at Strength {power}").withFlags(IEF_ATTACK);
	/**
	 * Require (power) strength for full power; special scale for Massive weapons:
	 * * 75% attack at 80% required strength,
	 * * 50% attack at 60% required strength,
	 * * 25% attack at 40% required strength,
	 * * 5% attack (min. 1) if below
	 * */
	public static const ScaleAttack_StrXL:ItemEffectType = mk("ScaleAttack_StrXL", "Full power at Strength {power}").withFlags(IEF_ATTACK);
	/**
	 * Require (power) sspeed for full power.
	 * * 50% attack at 75% required speed,
	 * * 25% attack at 50% required speed,
	 * * 5% attack (min. 1) if below
	 * */
	public static const ScaleAttack_Spe:ItemEffectType = mk("ScaleAttack_Spe", "Full power at Speed {power}").withFlags(IEF_ATTACK);
	/**
	 * Require (power) strength+speed for full power.
	 * * 50% attack at 75% required str+speed,
	 * * 25% attack at 50% required str+speed,
	 * * 5% attack (min. 1) if below
	 * */
	public static const ScaleAttack_StrSpe:ItemEffectType = mk("ScaleAttack_StrSpe", "Full power at Strength+Speed {power}").withFlags(IEF_ATTACK);
	
	//================//
	// Unique effects //
	//================//
	
	//===========//
	// Internals //
	//===========//
	
	function IELib() {
		throw new Error("This class should not be instantiated");
	}
	
	private static function mk(name:String, descPattern:String, priority:int = 80):ItemEffectType {
		return new SimpleItemEffect(name, descPattern, priority);
	}
	private static function mkfn(name:String, descFn:Function, priority:int = 80):ItemEffectType {
		return new DescriptionFnItemEffect(name, descFn, priority);
	}
}
}
