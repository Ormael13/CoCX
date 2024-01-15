package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class NightOfBrotherhoodSkill extends AbstractSoulSkill {
    public function NightOfBrotherhoodSkill() {
        super(
            "Night of Brotherhood",
            "Condense your wrath into a wreath of shadows, filled with the hate of your brotherhood.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_DARKNESS, TAG_RECOVERY, TAG_MAGICAL, TAG_AOE],
            StatusEffects.KnowsNightOfBrotherhood
        )
		lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

	override public function get buttonName():String {
		return "Night of Brotherhood";
	} 

	override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

        if (player.wrath < 50) {
			return "Your current wrath is too low.";
		}

        return "";
    }  

	override public function describeEffectVs(target:Monster):String {
		var wrathRestore: Number = calcWrathRestore();
		return "~" + numberFormat(calcDamage(target, wrathRestore)) + " darkness damage, restores ~" + numberFormat(wrathRestore) + " wrath";
	}

	override public function calcCooldown():int {
		return  Math.round(player.statusEffectv1(StatusEffects.KnowsNightOfBrotherhood));
	}

	public function nightOfBrotherhoodWC():Number {
    	return 10 * player.statusEffectv1(StatusEffects.KnowsNightOfBrotherhood);
	}

	private function calcWrathRestore():Number {
		var restoreAmount:Number = 0;
		restoreAmount += Math.round(player.wrath * (nightOfBrotherhoodWC() * 0.01));
		return restoreAmount;
	}

	public function calcDamage(monster:Monster, baseDamage: Number):Number {
		var damage:Number = baseDamage * (5 * player.statusEffectv1(StatusEffects.KnowsNightOfBrotherhood));

		//group enemies bonus
		if (monster && monster.plural) damage *= 5;

		damage *= combat.darknessDamageBoostedByDao();
		return Math.round(damage);
	}

    override public function doEffect(display:Boolean = true):void {
		var wrathRestore:Number = calcWrathRestore();
		player.wrath -= wrathRestore;

		var damage:Number = calcDamage(monster, wrathRestore);

		if (display) {
			outputText("You start concentrate on the wrath flowing in your body, your veins while imaging a joy of sharing storm of sisterhood with enemy. Shortly after that wrath starts to gather around your hands till it envelop your hands in ligthing.\n\n");
    		outputText("With joy, you sends a mass of ligthing toward [themonster] while mumbling about 'sharing the storm of sisterhood'. ");
		}
		doDarknessDamage(damage, true, display);
		if (display) outputText("\n\n");
    }
}
}