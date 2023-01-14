package classes.Scenes.Combat.SpellsGrey {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreySpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class StalagmiteSwiftcastSpell extends AbstractGreySpell {
	
	public function StalagmiteSwiftcastSpell() 
	{
		super(
			"Stalagmite (S)",
			"Harden part of the ground into an earth spike to attack your enemy.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_EARTH, TAG_TIER1]
		);
		baseManaCost = 8;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsStalagmite) &&
				player.hasPerk(PerkLib.SwiftCasting);
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
		return 0;
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = 0.4 * scalingBonusIntelligence(randomize);
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (player.armorName == "FrancescaCloak") baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.EARTH, CAT_SPELL_GREY, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You spread your hands, focusing your mana down, down, deep into the earth below. [Monster A] [monster name] in front of you leaves a slight indent, that you can feel through the earth. With a moment of hard focus, you harden the earth underneath them into a spike of solid stone. With a cry of effort, you motion, and your spike of stone shoots up from below, striking your foe.\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.EARTH);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}