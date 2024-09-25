package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class IceFistSkill extends AbstractSoulSkill {
    public function IceFistSkill() {
        super(
            "Ice Fist",
            "A chilling strike that can freeze an opponent solid, leaving it vulnerable to shattering soul art and hindering its movement.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_ICE, TAG_PHYSICAL],
            StatusEffects.KnowsIceFist
        )
		baseSFCost = 30;
		lastAttackType = Combat.LAST_ATTACK_PHYS;
    }

    override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

		if ((player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) && (player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity))) {
			return "When you try to use this technique, you shudder in revulsion. Ice, that close to your body? You're a creature of fire!";
		}
		if (!player.isFistOrFistWeapon()) {
			return "<b>Your [weapon] can't be used with this soulskill.</b>";
		}

        return "";
    }

	override public function get buttonName():String {
		return "Ice Fist";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target)) + " ice damage"
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle()
		if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) {
			damage += player.str;
			damage += scalingBonusStrength();
		}
		damage += player.wis;
		damage += scalingBonusWisdom() * 2;
		//soulskill mod effect
		damage *= soulskillPhysicalMod();
		//other bonuses
		if (player.hasPerk(PerkLib.PerfectStrike) && monster && monster.monsterIsStunned()) damage *= 1.5;
		if (player.hasPerk(PerkLib.Heroism) && monster && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (combat.wearingWinterScarf()) damage *= 1.2;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;
		return Math.round(damage);

	}

    override public function doEffect(display:Boolean = true):void {
		var damage:Number = calcDamage(monster);
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		monster.buff("FrozenSolid").addStats({spe:-20}).withText("Frozen Solid").combatTemporary(1);
		if (display) outputText("The air around your fist seems to lose all heat as you dash at [themonster]. You place your palm on [monster him], [monster his] body suddenly is frozen solid, encased in a thick block of ice! ");
		combat.checkForElementalEnchantmentAndDoDamageMain(damage, true, true, crit, false, 4);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		//stun
		if (monster.hasPerk(PerkLib.Resolute)) {
			if (display) {
				outputText("  <b>[Themonster] ");
				if(!monster.plural) outputText("is ");
				else outputText("are ");
				outputText("too sturdy to be frozen by your attack.</b>");
			}
		}
		else if (monster.hasStatusEffect(StatusEffects.FrozenSolid)) monster.addStatusValue(StatusEffects.FrozenSolid, 1, 2);
		else monster.createStatusEffect(StatusEffects.FrozenSolid, 2, 0, 0, 0);
		//speed debuff
		if (monster.buff("FrozenSolid").isPresent()) monster.buff("FrozenSolid").addStats({spe: -20}).addDuration(2);
		else monster.buff("FrozenSolid").addStats({spe: -20}).withText("Frozen Solid").combatTemporary(2);
		checkAchievementDamage(damage);
		combat.WrathGenerationPerHit2(5);
		if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0) anubiHeartLeeching(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		if (display) outputText("\n\n");
    }
}
}