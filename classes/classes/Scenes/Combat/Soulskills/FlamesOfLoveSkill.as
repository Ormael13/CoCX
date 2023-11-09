package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class FlamesOfLoveSkill extends AbstractSoulSkill {
    public function FlamesOfLoveSkill() {
        super(
            "Flames of Love",
            "Enfuse your magic with your burning lust, transfering it to your enemy as a barrage of flames.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_FIRE, TAG_RECOVERY],
            StatusEffects.KnowsFlamesOfLove
        )
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

	override public function describeEffectVs(target:Monster):String {
		var lustRestore: Number = calcLustRestore();
		return "~" + calcDamage(target, lustRestore) + " fire damage, restores " + lustRestore + " lust";
	}

	override public function calcCooldown():int {
		return  Math.round(player.statusEffectv1(StatusEffects.KnowsFlamesOfLove));
	}

	public function flamesOfLoveLC():Number {
    	var follc:Number = 10;
    	return follc;
	}

	private function calcLustRestore():Number {
		var restoreAmount:Number = 0;
		restoreAmount += Math.round(player.lust * (flamesOfLoveLC() * 0.01));
		return restoreAmount;
	}

	public function calcDamage(monster:Monster, baseDamage: Number):Number {
		var damage:Number = baseDamage * (5 * player.statusEffectv1(StatusEffects.KnowsFlamesOfLove));
		if (monster.plural) damage *= 2;
		damage *= combat.fireDamageBoostedByDao();
		return Math.round(damage);
	}

    override public function doEffect(display:Boolean = true):void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;

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