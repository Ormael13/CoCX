package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class CreateElementSkill extends AbstractSoulSkill {
	private var rank:int;
	private var element:String;
    public function CreateElementSkill(element:String, rank:int) {
        super(
            "Create Element (" + element + ")",
            "Form ball of " + element.toLowerCase() + " elemental energy to toss at the enemy.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            buildTagList(element),
            rank == 1? StatusEffects.KnowsCreateElementBasic: StatusEffects.KnowsCreateElementAdvanced
        )
		baseSFCost = 10;
		this.rank = rank;
		this.element = element;
		lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

	private function buildTagList(element:String):Array {
		var tagArr:Array = [TAG_DAMAGING, TAG_MAGICAL, TAG_TIER1];

		var tagToAdd:int;
		switch(element.toLowerCase()) {
			case "fire":
				tagToAdd = TAG_FIRE
				break;
			case "water":
				tagToAdd = TAG_WATER
				break;
			case "air":
				tagToAdd = TAG_WIND
				break;
			case "earth":
				tagToAdd = TAG_EARTH
				break;
			case "ice":
				tagToAdd = TAG_ICE
				break;
			case "lightning":
				tagToAdd = TAG_LIGHTNING
				break;
			case "darkness":
				tagToAdd = TAG_DARKNESS
				break;
			default:
				break;
		}

		if (tagToAdd) {
			tagArr.push(tagToAdd)
		}

		return tagArr;
	}

    override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

		if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
			return "You are too angry to think straight. Smash your puny opponents first and think later.";
		}

        return "";
    }

	override public function get buttonName():String {
		return "Create E. (" + element + ")";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target)) + " " + this.element.toLowerCase() + " damage";
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = scalingBonusWisdom() * 2;
		if (damage < 10) damage = 10;
		//soulskill mod effect
		damage *= combat.soulskillMagicalMod();
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType)))) damage *= 2;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;
		return Math.round(damage);
	}

    override public function doEffect(display:Boolean = true):void {
		if (display) outputText("You concentrate, focusing on the power of your soul. You infuse a bit of soulforce into a finger, " + 
			"bright blue energy covering the tip. You draw a simple rune in the air, the energy from your finger dissipating into it. A moment later, the rune swells, energy forming into a small ball of "
		 	+ element.toLowerCase() +". You motion, sending the ball flying toward [themonster].  ");
		if (monsterDodgeSkill("ball", display)) return;
		var damage:Number = calcDamage(monster);
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (display) outputText("The tossed projectile hits [themonster], dealing ");
		switch (element) {
			case "Fire":
				damage = Math.round(damage*combat.fireDamageBoostedByDao());
				doFireDamage(damage, true, display);
				break;
			case "Water":
				damage = Math.round(damage*combat.waterDamageBoostedByDao());
				doWaterDamage(damage, true, display);
				break;
			case "Air":
				damage = Math.round(damage*combat.windDamageBoostedByDao());
				doWindDamage(damage, true, display);
				break;
			case "Earth":
				damage = Math.round(damage*combat.earthDamageBoostedByDao());
				doEarthDamage(damage, true, display);
				break;
			case "Ice":
				damage = Math.round(damage*combat.iceDamageBoostedByDao());
				doIceDamage(damage, true, display);
				break;
			case "Lightning":
				damage = Math.round(damage*combat.lightningDamageBoostedByDao());
				doLightningDamage(damage, true, display);
				break;
			case "Darkness":
				damage = Math.round(damage*combat.darknessDamageBoostedByDao());
				doDarknessDamage(damage, true, display);
				break;
			default:
				damage = Math.round(damage*combat.fireDamageBoostedByDao());
				doFireDamage(damage, true, display);
				break;
		}
		if (display) outputText(" damage! ");
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		if (display) outputText("\n\n");
		if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0) anubiHeartLeeching(damage);
		combat.heroBaneProc(damage);
    }
}
}