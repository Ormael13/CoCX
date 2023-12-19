package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.Races;
import classes.EngineCore;

public class VioletPupilTransformationSkill extends AbstractSoulSkill {
    public function VioletPupilTransformationSkill() {
        super(
            "Violet Pupil Transformation",
            "Violet Pupil Transformation is a regeneration-oriented soul art. While it drains your SoulForce constantly, it allows one to rapidly heal their injuries.",
            TARGET_SELF,
            TIMING_TOGGLE,
            [TAG_RECOVERY],
            StatusEffects.KnowsVioletPupilTransformation
        )
		baseSFCost = 0;
    }

	override public function get buttonName():String {
		if (isActive())
			return "Deactiv VPT";
		else
			return "V P Trans";
	}

	override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

		var cm1:Number = 0.05;
		if (player.isRaceCached(Races.UNICORN, 2)) cm1 -= 0.01;
		if (player.isRaceCached(Races.ALICORN, 2)) cm1 -= 0.01;
		var cost1:Number = Math.round(player.maxSoulforce()*cm1);
		if (player.soulforce < cost1) {
			return "<b>Your current soulforce is too low.</b>";
		}

        return "";
    }


	override public function describeEffectVs(target:Monster):String {
		return "Regenerates " + numberFormat(calcHealAmount()) + " health for a cost of " + numberFormat(calcSFCost()) + " soulforce per turn";
	}

	private function calcHealAmount():Number {
		var healPercent:Number = 0.05;
		if (player.isRaceCached(Races.ALICORN, 2)) healPercent += 0.01;
		return Math.round(player.maxHP() * healPercent);
	}

	private function calcSFCost():Number {
		var cm1:Number = 0.05;
		if (player.isRaceCached(Races.UNICORN, 2)) cm1 -= 0.01;
		if (player.isRaceCached(Races.ALICORN, 2)) cm1 -= 0.01;
		return Math.round(player.maxSoulforce() * cm1);
	}

	override public function advance(display:Boolean):void {
		
		var sfCost:Number = calcSFCost();
		if (player.soulforce < sfCost) {
			super.toggleOff(display);
			if (display) outputText("<b>Your soulforce is too low to continue using Violet Pupil Transformation. </b>\n\n");
		} else {
			EngineCore.SoulforceChange(-sfCost);
			
			var amountToHeal:int = calcHealAmount();
			if (display) outputText("<b>As your soulforce is drained you can feel Violet Pupil Transformation's regenerative power spreading throughout your body. ([font-heal]+"
				 + numberFormat(amountToHeal) + "[/font])</b>\n\n");
			HPChange(amountToHeal, false);
		}
	}

	override public function toggleOff(display:Boolean = true):void {
		super.toggleOff(display);
		if (display) outputText("Deciding you not need for now to constantly using Violet Pupil Transformation you concentrate and deactivating it.");
	}

    override public function doEffect(display:Boolean = true):void {
		if (display) outputText("Deciding you need additional regeneration during current fight you spend moment to concentrate and activate Violet Pupil Transformation."
			+"  Your eyes starting to glow with a violet hua and you can feel refreshing feeling spreading all over your body.\n\n");
		setDuration();
    }
}
}