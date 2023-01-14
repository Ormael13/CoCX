package classes.Scenes.Combat.SpellsGrey {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreySpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class WaterBallSwiftcastSpell extends AbstractGreySpell {
	
	public function WaterBallSwiftcastSpell() 
	{
		super(
			"Water Ball (S)",
			"Condense part of the ambient moisture into sphere water to attack your enemy.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_WATER, TAG_TIER1]
		);
		baseManaCost = 8;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsWaterBall) &&
				player.hasPerk(PerkLib.SwiftCasting);
	}
	
	override public function calcCooldown():int {
		return 0;
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = 0.4 * scalingBonusIntelligence(randomize);
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (player.armorName == "FrancescaCloak") baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.WATER, CAT_SPELL_GREY, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			if (player.hasStatusEffect(StatusEffects.InWater)) {
				outputText("You focus your intents on the water around your body. A vortex whirls around your palms as the force of your magic fuses with the water before you shoot several spheres of water at [themonster].\n");
				outputText("The waves crash against them!\n");
			}
			else {
				outputText("You focus your intents toward your open palm as water begins welling up in the air above your hand. A sphere of water forms within your grasp before you shoot it toward [themonster] with full force.\n");
				outputText("It violently crashes against them!\n");
			}
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.WATER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}