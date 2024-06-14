package classes.Scenes.Combat.SpellsBlack {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class DuskWaveSpell extends AbstractBlackSpell {
	public var ex:Boolean;
	
	public function DuskWaveSpell(ex:Boolean = false) {
		super(
			ex ? "Dusk Wave (Ex)" : "Dusk Wave",
			ex ?
				"This spell draws your own lust to condense part of the ambient darkness into a wave to attack your enemies."
				: "This spell draws your own lust and wrath to condense part of the ambient darkness into a wave to attack your enemies.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_DARKNESS, TAG_AOE, TAG_TIER1]
		);
		baseManaCost = 200;
		if (ex) baseWrathCost = 100;
		this.ex = ex;
	}
	
	override public function get buttonName():String {
		return ex ? "DuskWave(Ex)" : "Dusk Wave"
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false, false) + " darkness damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsDuskWave) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx));
	}
	
	override public function calcCooldown():int {
		var calcC:int = 0;
		calcC += spellBlackCooldown();
		if (player.weaponRange == weaponsrange.RB_TOME && player.level < 18) {
			if (player.level < 6) calcC -= 1;
			if (player.level < 12) calcC -= 1;
			calcC -= 1;
			if (calcC < 0) calcC = 0;
		}
		return calcC;
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = 2 * scalingBonusIntelligence(randomize);
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (ex) baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.DARKNESS, CAT_SPELL_BLACK, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You draw your lust, enfused with your power, into your eyes and down into your hands. You clasp your palms together, and as you draw them apart, your power condenses, pushing the light between your palms back. You aim both palms at [themonster], bringing them together as if snuffing out a light. A wave of darkness erupts from you, engulfing [themonster] in shadows. \n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.DARKNESS);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
