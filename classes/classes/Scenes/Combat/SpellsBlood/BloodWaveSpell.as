package classes.Scenes.Combat.SpellsBlood {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBloodSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class BloodWaveSpell extends AbstractBloodSpell {
	public function BloodWaveSpell() {
		super(
				"Blood Wave",
				"Blood Shield will attack all surrounding foes with a wave of blood.  It would deal more damage when used against larger than averange sized group of enemies.",
				TARGET_ENEMY,
				TIMING_INSTANT,
				[TAG_DAMAGING,TAG_AOE]
		);
		baseHpCost = 400;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsBloodWave);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target,false)+" magical damage"
	}
	
	override public function calcCooldown():int {
		return 5;
	}
	
	public function calcDamage(target:Monster, randomize:Boolean=true):Number {
		var damage:Number = adjustSpellDamage(
				scalingBonusIntelligence(randomize)*4,
				DamageType.MAGICAL,
				CAT_SPELL_BLOOD,
				target,
				false
		);
		if (damage < 10) damage = 10;
		if (target != null && target.hasPerk(PerkLib.EnemyLargeGroupType)) damage *= 5;
		return Math.round(damage);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + (player.HP < player.maxOverHP() ? "wounds":"skin pores") + ". Blood starts to gather around you, coalescing into a crimson ring. ");
			outputText("It roils as you concentrate on it before you release it. It moves in all directions looking like a raging waves until it hits [themonster].");
		}
		var damage:Number = calcDamage(monster);
		damage = critAndRepeatDamage(display,damage,DamageType.MAGICAL,false,false);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
