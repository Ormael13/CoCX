package classes.Scenes.Combat.SpellsGrey {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreySpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class WindBulletSwiftcastSpell extends AbstractGreySpell {
	
	public function WindBulletSwiftcastSpell() 
	{
		super(
			"Wind Bullet (S)",
			"Devastate the enemy ranks with a barrage of wind bullets.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_WIND, TAG_TIER1]
		);
		baseManaCost = 8;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsWindBullet) &&
				player.hasPerk(PerkLib.SwiftCasting);
	}
	
	override public function calcCooldown():int {
		return 0;
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = 0.4 * scalingBonusIntelligence(randomize);
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (player.armorName == "FrancescaCloak") baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.WIND, CAT_SPELL_GREY, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You focus your intents at your opponent as the air swirls around them. By your command, the zephyr coalesces into a bullet that immediately darts into [themonster].\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.WIND);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}