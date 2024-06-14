package classes.Scenes.Combat.SpellsWhite {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class ChainLightningSpell extends AbstractWhiteSpell {
	
	private var ex:Boolean;
	
	public function ChainLightningSpell(ex:Boolean =false) {
		super(
			ex ? "Chain Lighting (Ex)":"Chain Lighting",
			ex ?
				"Chain Lighting (Ex) is a wrath-empowered lightning attack that will electrocute your foes with a chain bolts of lightning."
				: "Chain Lighting is a lightning attack that will electrocute your foes with a chain bolts of lightning.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_AOE, TAG_LIGHTNING, TAG_TIER1]
		);
		baseManaCost = 200;
		baseWrathCost = ex ? 100 : 0;
		this.ex = ex;
	}
	
	override public function get buttonName():String {
		return ex ? "ChainLtng (Ex)" : "ChainLtng"
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target, false, false)+" lightning damage";
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsChainLighting) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx))
	}
	
	override public function calcCooldown():int {
		var calcC:int = 0;
		calcC += spellWhiteCooldown();
		if (player.weaponRange == weaponsrange.RW_TOME && player.level < 18) {
			if (player.level < 6) calcC -= 1;
			if (player.level < 12) calcC -= 1;
			calcC -= 1;
			if (calcC < 0) calcC = 0;
		}
		return calcC;
	}
	
	/**
	 * Calculate real (or theoretic) damage dealt by this spell
	 * @param monster Target, or null if no target (ex. for description outside combat)
	 * @param randomize true: Apply random bonus, false: Apply average bonus
	 * @return {Number} Damage dealt by this spell
	 */
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = 2*scalingBonusIntelligence(randomize);
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (ex) baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.LIGHTNING, CAT_SPELL_WHITE, monster, true, casting);
	}
	
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("your mana, pushing the energy down into your hands. Electricity dances between your fingertips, and you raise your hands, fingers outstretched. Lightning crackles between your outstretched fingers, and you point them at [themonster].");
			if (monster.plural) {
				outputText("You keep hold of the energy, and with a flick of your wrist, you send it arcing from target to target.");
			}
			outputText("!");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.LIGHTNING);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
