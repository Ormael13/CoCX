package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBloodSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.Scenes.Combat.Combat;

public class BloodReqiuemSkill extends AbstractBloodSoulSkill {
    public function BloodReqiuemSkill(sfInfusion: Boolean = false) {
        super(
            "Blood Requiem",
            sfInfusion? "(Soulforce infused) Blood Requiem, infused by a small amount of soulforce to enhance its power, will create pillars of blood that would deal damage and reduce the recovery rate of enemies for a short time.  "
			: "Blood Requiem will create pillars of blood, dealing damage and reducing the recovery rate of enemies for a short time.  ",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_PHYSICAL, TAG_TIER2],
            sfInfusion? StatusEffects.KnowsBloodRequiemSF: StatusEffects.KnowsBloodRequiem,
			true,
			sfInfusion
        )
		baseSFCost = 150;
		lastAttackType  = Combat.LAST_ATTACK_PHYS;
    }

	override protected function baseName():String {
		return "Blood Requiem";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target)) + " blood damage, inflicts Bleed for 4 rounds"
	}

	override public function calcCooldown():int {
		return soulskillTier2Cooldown(bloodSoulSkillCoolDown(4));
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 6;
		var damageFloor:Number = 10;

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
		var additionalSFLine: String = sfInfusion? "You pour Soulforce into your hands, and they glow blue with each gesture, power pulsing with your heartbeat. " : "";
		if (display) outputText("You concentrate, focusing on the power of your blood before starting making gestures with your hands, precise movements sending power blazing through your body. " + 
			additionalSFLine + 
			"Within an instant, large, blood dripping pillars form above [themonster]. The pillars begin to fall, and [themonster] looks up in shock, too late to dodge such a large projectile. \n\n");
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
		if (display) outputText(" damage.");
		if (monster.hasStatusEffect(StatusEffects.BloodRequiem)) monster.addStatusValue(StatusEffects.BloodRequiem, 1, 4);
		else monster.createStatusEffect(StatusEffects.BloodRequiem,4,0,0,0);
		endTurnByBloodSkillUse(damage, display);
    }
}
}