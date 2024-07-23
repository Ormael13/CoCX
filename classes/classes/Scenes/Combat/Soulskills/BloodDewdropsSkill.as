package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBloodSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class BloodDewdropsSkill extends AbstractBloodSoulSkill {
    public function BloodDewdropsSkill(sfInfusion: Boolean = false) {
        super(
            "Blood Dewdrops",
            sfInfusion? "(Soulforce infused) Blood Dewdrops, infused by a small amount of soulforce. Blood Dewdrops will fire many blood droplets from your hand.  "
			: "Blood Dewdrops will fire many bloody droplets from your hand.  ",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_PHYSICAL, TAG_TIER2],
            sfInfusion? StatusEffects.KnowsBloodDewdropsSF: StatusEffects.KnowsBloodDewdrops,
			true,
			sfInfusion
        )
		baseSFCost = 240;
		lastAttackType = Combat.LAST_ATTACK_PHYS;
    }

	override protected function baseName():String {
		return "Blood Dewdrops";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(Math.round(calcDamage(target) * 4)) + " blood damage"
	}

	override public function calcCooldown():int {
		return soulskillTier2Cooldown(bloodSoulSkillCoolDown(2));
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 6;
		var damageFloor:Number = 10;
		if (damage < damageFloor) damage = damageFloor;
		if (monster && monster.plural) damage *= 5;
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
		var additionalSFLine: String = sfInfusion? "You close your eyes for a moment, sending soulforce into the pellets. " : "";
		if (display) outputText("You concentrate, focusing on the power of your blood before opening your hand and pointing it toward the enem"+(monster.plural?"ies":"y")
			+". Blood spurts from your fingertips, beads of crimson darkening as they harden. " + additionalSFLine
			+ "You flick your wrist, sending the blood pellets flying towards [themonster].\n\n");
		
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
		if (display && display) outputText("[Themonster] takes ");
		doDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		if (display) outputText(" damage.");
		endTurnByBloodSkillUse(damage);
    }
}
}