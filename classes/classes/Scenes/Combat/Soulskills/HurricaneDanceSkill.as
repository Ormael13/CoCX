package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.Scenes.Combat.CombatAbility;
import classes.StatusEffects;
import classes.Monster;

public class HurricaneDanceSkill extends AbstractSoulSkill {
    public function HurricaneDanceSkill() {
        super(
            "Hurricane Dance",
            "Take on the aspect of the wind, dodging attacks like a leaf in the wind.",
            TARGET_SELF,
            TIMING_LASTING,
            [TAG_BUFF],
            StatusEffects.KnowsHurricaneDance
        )
		baseSFCost = 30;
    }

	override public function get buttonName():String {
		return "Hurricane Dance";
	}

    override public function calcCooldown():int {
        return soulskillTier3Cooldown(10);
    }

    override public function calcDuration():int {
        return 5;
    }

    override public function describeEffectVs(target:Monster):String {
		return "Increases speed and evasion for " + calcDuration() + " rounds";
	}

    override public function doEffect(display:Boolean = true):void {
		if (display)
			outputText("Your movement becomes more fluid and precise, increasing your speed and evasion.\n\n");
		setDuration();
    }

    override public function durationEnd(display:Boolean = true):void {
        if (display) outputText("<b>Hurricane Dance effect wore off!</b>\n\n");
    }
}
}