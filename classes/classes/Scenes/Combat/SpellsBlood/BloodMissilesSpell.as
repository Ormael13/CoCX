package classes.Scenes.Combat.SpellsBlood {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBloodSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class BloodMissilesSpell extends AbstractBloodSpell {
	public function BloodMissilesSpell() {
		super(
			"Blood Missiles",
			"Blood Missiles will attack foe with five blood spheres.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING]
		);
		baseHpCost = 50;
		magicAddonProcs = 5;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsBloodMissiles);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target, false, false)+"(x5) magical damage"
	}
	
	override public function calcCooldown():int {
		var calcC:int = -1;
		calcC += spellGenericCooldown();
		if (calcC < 0) calcC = 0;
		return calcC;
	}
	
	public function calcDamage(target:Monster, randomize:Boolean=true, casting:Boolean = true):Number {
		var damage:Number = adjustSpellDamage(
				scalingBonusIntelligence(randomize)*bloodAffinityBoost(),
				DamageType.MAGICAL,
				CAT_SPELL_BLOOD,
				target,
				false,
                casting
		);
		if (damage < 10) damage = 10;
		return Math.round(damage);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You concentrate, focusing on the power of your blood before drawing it from your body, "+(player.HP < player.maxOverHP() ? "wounds":"skin pores")+". Around you form a few crimson spheres you aim at [themonster]!\n\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (display) {
			outputText("[Themonster] takes ");
		}
		var n:int=5;
		while (n-->0) {
			doMagicDamage(damage,true,true);
			if (display && crit) {
				outputText(" <b>*Critical Hit!*</b>");
			}
		}
		if (display) {
			outputText(" damage.");
		}
		damage *= 5;
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
