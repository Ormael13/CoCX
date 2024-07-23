package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBloodSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class HeartSeekerSkill extends AbstractBloodSoulSkill {
    public function HeartSeekerSkill(sfInfusion: Boolean = false) {
        super(
            "Heart Seeker",
            sfInfusion? "(Soulforce infused) Heart Seeker, infused by a small amount of soulforce. This skill will hit the vital points of your foe.  "
			: "Heart Seeker will strike the vital points of your enemy, dealing true damage.  ",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_PHYSICAL, TAG_TIER2],
            sfInfusion? StatusEffects.KnowsHeartSeekerSF: StatusEffects.KnowsHeartSeeker,
			true,
			sfInfusion
        )
		baseSFCost = 120;
		lastAttackType = Combat.LAST_ATTACK_PHYS;
    }

	override protected function baseName():String {
		return "Heart Seeker";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target)) + " true damage"
	}

	override public function calcCooldown():int {
		return soulskillTier2Cooldown(bloodSoulSkillCoolDown(3));
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 6;
		var damageFloor:Number = 10;
		if (damage < damageFloor) damage = damageFloor;
		if (player.hasPerk(PerkLib.BloodAffinity)) damage *= 2;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;
		if (sfInfusion) {
			damage *= soulskillPhysicalMod();
		}
		return Math.round(damage);
	}

    override public function doEffect(display:Boolean = true):void {
		var additionalSFLine: String = sfInfusion? "You infuse a bit of soulforce into the blood, spreading your fingers wide. " : "";
		if (display) outputText("You concentrate, focusing on the power of your blood. " + additionalSFLine 
		+ "Within an instant, a large blood dripping spear forms in your hand. You motion, sending the spear flying toward [themonster]'s vitals.\n\n");
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
		if (player.hasPerk(PerkLib.BloodMastery)) damage *= 2;
		damage = Math.round(damage * combat.bloodDamageBoostedByDao());
		if (display) outputText("[Themonster] takes ");
		doTrueDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		if (display) outputText(" damage.");
		endTurnByBloodSkillUse(damage);
    }
}
}