package classes.Scenes.Combat.SpellsGrey {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreySpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class StalagmiteSpell extends AbstractGreySpell {
	public var ex:Boolean;
	
	public function StalagmiteSpell(ex:Boolean = false) {
		super(
			ex ? "Stalagmite (Ex)" : "Stalagmite",
			ex ?
				"Harden part of the ground into an wrath-empowered earth spike to attack your enemy."
				: "Harden part of the ground into an earth spike to attack your enemy.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_EARTH, TAG_TIER1]
		);
		baseManaCost = 40;
		if (ex) baseWrathCost = 100;
		this.ex = ex;
	}
	
	override public function get buttonName():String {
		return ex ? "Stalagmite(Ex)" : "Stalagmite";
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false, false) + " earth damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsStalagmite) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx));
	}
	
	override protected function usabilityCheck():String {
		if (monster.hasStatusEffect(StatusEffects.Flying)) {
			return "You can only use earth magic against enemy on the ground."
		}
		if (player.hasStatusEffect(StatusEffects.Flying)) {
			return "You can't use earth magic when too far from the ground."
		}
		return super.usabilityCheck();
	}
	
	override public function calcCooldown():int {
		var calcC:int = 0;
		calcC += spellGreyCooldown();
		if (player.weaponRange == weaponsrange.RG_TOME && player.level < 18) {
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
		return adjustSpellDamage(baseDamage, DamageType.EARTH, CAT_SPELL_GREY, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You spread your hands, focusing your mana down, down, deep into the earth below. [Monster A] [monster name] in front of you leaves a slight indent, that you can feel through the earth. With a moment of hard focus, you harden the earth underneath them into a spike of solid stone. With a cry of effort, you motion, and your spike of stone shoots up from below, striking your foe.\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.EARTH);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}

}
}