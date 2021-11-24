package classes.Scenes.Combat.SpellsWhite {
import classes.Monster;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class FireStormSpell extends AbstractWhiteSpell{
	public function FireStormSpell() {
		super(
				"Fire Storm",
				"Drawning your own force of the willpower to fuel radical change in the surrounding you can call forth an Fire Storm that will attack enemies in a wide area.",
				TARGET_ENEMY,
				TIMING_INSTANT,
				[TAG_DAMAGING,TAG_AOE,TAG_FIRE]
		);
		baseManaCost = 500;
	}
	
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsFireStorm)
	}
	
	override public function calcCooldown():int {
		return spellWhiteTier2Cooldown();
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target,false)+" fire daamge."
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean=true):Number {
		var baseDamage:Number = scalingBonusIntelligence(randomize)*6;
		return adjustSpellDamage(baseDamage,DamageType.FIRE,CAT_SPELL_WHITE,monster);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You narrow your eyes, focusing your own willpower with a deadly intent. You cojure a small vortex of embers that expand into a vicious gout of flames.  With a single thought, you send a pillar of flames at [themonster]. You intend to leave nothing but ashes!");
		}
		var damage:Number = calcDamage(monster);
		critAndRepeatDamage(display, damage, DamageType.FIRE);
		damage *= omnicasterRepeatCount();
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
