package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class StormOfSisterhoodSkill extends AbstractSoulSkill {
    public function StormOfSisterhoodSkill() {
        super(
            "Storm of Sisterhood",
            "Transform your wrath into an electric storm, empowered by sisterhood.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_LIGHTNING, TAG_RECOVERY, TAG_MAGICAL],
            StatusEffects.KnowsStormOfSisterhood
        )
		lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

	override public function get buttonName():String {
		return "Storm of Sisterhood";
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
		return "~" + numberFormat(calcDamage(target, wrathRestore)) + " lightning damage, restores " + numberFormat(wrathRestore) + " wrath";
	}

	override public function calcCooldown():int {
		return  Math.round(player.statusEffectv1(StatusEffects.KnowsStormOfSisterhood));
	}

	public function stormOfSisterhoodWC():Number {
    	var soswc:Number = 10;
    	return soswc;
	}

	private function calcWrathRestore():Number {
		var restoreAmount:Number = 0;
		restoreAmount += Math.round(player.wrath * (stormOfSisterhoodWC() * 0.01));
		return restoreAmount;
	}

	public function calcDamage(monster:Monster, baseDamage: Number):Number {
		var damage:Number = baseDamage * (5 * player.statusEffectv1(StatusEffects.KnowsStormOfSisterhood));
		if (monster && monster.plural) damage *= 2;
		damage *= combat.lightningDamageBoostedByDao();
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
		doLightingDamage(damage, true, display);
		if (display) outputText("\n\n");
    }
}
}