package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBloodSoulSkill;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class BloodSwipePuppiesSkill extends AbstractBloodSoulSkill {
    public function BloodSwipePuppiesSkill(sfInfusion: Boolean = false) {
        super(
            "Blood Puppies: Blood Swipe",
            "Command Blood Puppies to attack the enemy with Blood Swipe. Deals slightly increased damage to groups.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_PHYSICAL],
            PerkLib.MyBloodForBloodPuppies,
			true,
			sfInfusion
        )
		baseSFCost = 20;
		lastAttackType = Combat.LAST_ATTACK_PHYS;
    }

	override protected function baseName():String {
		return "BP: Blood Swipe";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target) * 6) + " blood damage"
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 6.75;
		var damageFloor:Number = 10;

		damage *= bloodPuppiesDamageBonusMod();
		damage *= soulskillPhysicalMod();

		if (damage < damageFloor) damage = damageFloor;
		if (monster && monster.plural) damage *= 10;
		if (player.hasPerk(PerkLib.BloodAffinity)) damage *= 2;
		if (player.hasPerk(PerkLib.BloodMastery)) damage *= 2;
		damage *= combat.bloodDamageBoostedByDao();

		return Math.round(damage);

	}

    override public function doEffect(display:Boolean = true):void {
		if (display) outputText("Giving command to your blood puppies, they start focusing the power of blood. Within an instant, many red claw-like lines coalesce briefly before being shot from their paws, flying toward [themonster]! ");

		var damage:Number = calcDamage(monster);

		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= ((bloodPuppiesDamageBonusMod() / 2) + 1.25);
		}

		doMinionPhysDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		doMinionPhysDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		doMinionPhysDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		doMinionPhysDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		doMinionPhysDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		doMinionPhysDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		
		if (flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] = 1;
		endTurnByBloodSkillUse(damage, display, false);
    }
}
}