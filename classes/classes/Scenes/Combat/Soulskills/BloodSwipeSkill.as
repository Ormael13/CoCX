package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBloodSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.Scenes.Combat.Combat;

public class BloodSwipeSkill extends AbstractBloodSoulSkill {
    public function BloodSwipeSkill(sfInfusion: Boolean = false) {
        super(
            "Blood Swipe",
            sfInfusion? "(Soulforce infused) Blood Swipe, infused by a small amount of soulforce. This skill will fire three red lines of blood energy from your hand.  "
			: "Blood Swipe will fire three red lines of blood energy from your hand.  ",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_PHYSICAL, TAG_TIER2],
            sfInfusion? StatusEffects.KnowsBloodSwipeSF: StatusEffects.KnowsBloodSwipe,
			true,
			sfInfusion
        )
		baseSFCost = 60;
		lastAttackType = Combat.LAST_ATTACK_PHYS;
    }

	override protected function baseName():String {
		return "Blood Swipe";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(Math.round(calcDamage(target) * 3)) + " blood damage"
	}

	override public function calcCooldown():int {
		return soulskillTier2Cooldown(bloodSoulSkillCoolDown(2));
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 6;
		var damageFloor:Number = 10;

		if (sfInfusion) {
			damage *= 3;
			damageFloor *= 3;
		}

		if (damage < damageFloor) damage = damageFloor;
		if (player.hasPerk(PerkLib.BloodAffinity)) damage *= 2;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;

		if (sfInfusion) {
			//soulskill mod effect
			damage *= soulskillPhysicalMod();
		}

		if (player.hasPerk(PerkLib.BloodMastery)) damage *= 2;
		damage *= combat.bloodDamageBoostedByDao();

		return Math.round(damage);

	}

    override public function doEffect(display:Boolean = true):void {
		var additionalSFLine: String = sfInfusion? "You infuse a bit of soulforce into the blood, before swiping your hand across your chest. " : "You swipe your hand across your chest. ";
		if (display) outputText("You concentrate, focusing on the power of your blood. " + additionalSFLine
			+ "Three trails of blood pour from your fingertips, condensing into thin crimson blades. You point your clawlike blades at your foe, and they detach with a small crunch, flying toward [themonster].\n\n");
		
		var damage:Number = calcDamage(monster);

		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		
		if (display) outputText("[Themonster] takes ");
		doDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		if (display) outputText(" damage.");
		endTurnByBloodSkillUse(damage, display);
    }
}
}