package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;

public class EarthStanceSkill extends AbstractSoulSkill {
    public function EarthStanceSkill() {
        super(
            "Earth Stance",
            "Take on the stability and strength of the earth, gaining temporary damage reduction",
            TARGET_SELF,
            TIMING_LASTING,
            [TAG_BUFF],
            StatusEffects.KnowsEarthStance
        )
		baseSFCost = 30;
    }

	override public function get buttonName():String {
		return "Earth Stance";
	}

	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.EarthStance);
	}

    override public function advance(display:Boolean):void {
        advanceDuration(StatusEffects.EarthStance, display, "<b>Earth Stance effect wore off!</b>\n\n");
    }

    override public function calcCooldown():int {
        return 10;
    }

    public function calcDuration():int {
        return 3;
    }

    override public function describeEffectVs(target:Monster):String {
		return "Gains 30% damage reduction for the next " + calcDuration() + " rounds"; 
	}

    override public function doEffect(display:Boolean = true):void {
		if (display)
			outputText("Your body suddenly hardens like rock. You will be way harder to damage for a while.\n\n");
		
		player.createStatusEffect(StatusEffects.EarthStance, calcDuration(), 0, 0, 0);
    }
}
}