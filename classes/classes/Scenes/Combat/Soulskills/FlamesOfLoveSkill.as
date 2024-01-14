package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.Scenes.Combat.Combat;

public class FlamesOfLoveSkill extends AbstractSoulSkill {
    public function FlamesOfLoveSkill() {
        super(
            "Flames of Love",
            "Enfuse your magic with your burning lust, transfering it to your enemy as a barrage of flames.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_FIRE, TAG_RECOVERY, TAG_MAGICAL, TAG_AOE],
            StatusEffects.KnowsFlamesOfLove
        )
		lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

	override public function get buttonName():String {
		return "Flames of Love";
	}

	override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

        if (player.lust < 50) {
			return "Your current lust is too low.";
		}

        return "";
    }

	override public function get description():String {
		var desc:String = super.description;
		var currentRank:int = player.statusEffectv1(this.knownCondition);
		var rankDescriptor:String = "";

		switch (currentRank) {
			case 1: rankDescriptor = "Rankless";
					break;
			case 2: rankDescriptor = "Low Rank";
					break;
		} 

		if (rankDescriptor) desc += "\nRank: " + rankDescriptor;
		return desc;
	} 

	override public function describeEffectVs(target:Monster):String {
		var lustRestore: Number = calcLustRestore();
		return "~" + numberFormat(calcDamage(target, lustRestore)) + " fire damage, restores ~" + numberFormat(lustRestore) + " lust";
	}

	override public function calcCooldown():int {
		return  Math.round(player.statusEffectv1(StatusEffects.KnowsFlamesOfLove));
	}

	public function flamesOfLoveLC():Number {
    	return 10 * player.statusEffectv1(StatusEffects.KnowsFlamesOfLove);
	}

	private function calcLustRestore():Number {
		var restoreAmount:Number = 0;
		restoreAmount += Math.round(player.lust * (flamesOfLoveLC() * 0.01));
		return restoreAmount;
	}

	public function calcDamage(monster:Monster, baseDamage: Number):Number {
		var damage:Number = baseDamage * (5 * player.statusEffectv1(StatusEffects.KnowsFlamesOfLove));
		damage += scalingBonusWisdom() * 0.5;
		
		//soulskill mod effect
		damage *= combat.soulskillMagicalMod();

		//group enemies bonus
		if (monster && monster.plural) damage *= 5;

		damage *= combat.fireDamageBoostedByDao();
		return Math.round(damage);
	}

    override public function doEffect(display:Boolean = true):void {
		var lustRestore:Number = calcLustRestore();
		player.lust -= lustRestore;

		var damage:Number = calcDamage(monster, lustRestore);

		if (display) {
			outputText("You concentrate on the lust flowing in your body, your veins heating up rapidly. With every beat of your heart, the heat rises, the heat in your groin transfering to the palm of your hands. \n\n");
			outputText("With almost orgasmic joy, you send a wave of flames toward [themonster]. ");
		}
		doFireDamage(damage, true, display);
		if (display) outputText("\n\n");
    }
}
}