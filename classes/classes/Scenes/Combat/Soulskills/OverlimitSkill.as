package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;

public class OverlimitSkill extends AbstractSoulSkill {
    public function OverlimitSkill() {
        super(
            "Overlimit",
            "Double your melee damage for a time, by ignoring your body's limits, pushing past them.",
            TARGET_SELF,
            TIMING_TOGGLE,
            [TAG_BUFF],
            StatusEffects.KnowsOverlimit
        )
		baseSFCost = 0;
    }

	override public function get buttonName():String {
		if (isActive())
			return "Overlimit(Off)";
		else
			return "Overlimit(On)";
	}

	override public function describeEffectVs(target:Monster):String {
		return "Increases melee damage by 100%, and lust resistance by 10%. Reduces Health by 10% per turn";
	}

	override public function toggleOff(display:Boolean = true):void {
		super.toggleOff(display);
		if (display) outputText("You let your rage fade, your red aura and manic strength vanishing along with it. You wince, feeling the strain you put your body through.\n\n");
	}

    override public function doEffect(display:Boolean = true):void {
		if (display) outputText("You let out a primal roar of pain and fury, as you push your body beyond its normal capacity, a blood red aura cloaking your form.\n\n");
		setDuration();
    }
}
}