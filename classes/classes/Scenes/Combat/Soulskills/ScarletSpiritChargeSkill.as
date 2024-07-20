package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractBloodSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.Races;
import classes.Scenes.API.FnHelpers;

public class ScarletSpiritChargeSkill extends AbstractBloodSoulSkill {
	private static const ScarletSpiritChargeABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
    public function ScarletSpiritChargeSkill() {
        super(
            "Scarlet Spirit Charge",
            "Activate Scarlet Spirit Charge state, which enhances your physical and mental abilities.  Allow to use during it Charge action.",
            TARGET_SELF,
            TIMING_TOGGLE,
            [TAG_BUFF],
            StatusEffects.KnowsScarletSpiritCharge
        )
		baseSFCost = 0;
    }

	override public function get buttonName():String {
		if (isActive())
			return "DeActSSCharge";
		else
			return "ScarletSpiritCharge";
	}

	override public function isActive():Boolean {
		return player.statStore.hasBuff("ScarletSpiritCharge");
	}

	override public function describeEffectVs(target:Monster):String {
		return "Increases all stats, reduces health by 5% per round";
	}

	override public function sfCost():int {
        return baseSFCost;
    }

	override public function toggleOff(display:Boolean = true):void {
		if (display) outputText("You disrupt the flow of blood within you, your body slumps as the glow radiating from your [skin] dissipates back into your natural hue.");
		player.statStore.removeBuffs("ScarletSpiritCharge");
	}

    override public function doEffect(display:Boolean = true):void {
		var tempStrTouSpe:Number = 0;
		if (display) outputText("You focus the power of your blood and soul, allowing the scarlet energy fill your being. Your [skin] begins to glow as the power within you coalesces, whirling within you with the force of a tsunami.\n");
		var ScarletSpiritChargeBoost:Number = 10;
		ScarletSpiritChargeBoost += player.wisStat.core.value;
		ScarletSpiritChargeBoost *= spellModBlood();
		if (ScarletSpiritChargeBoost < 10) ScarletSpiritChargeBoost = 10;
		ScarletSpiritChargeBoost = FnHelpers.FN.logScale(ScarletSpiritChargeBoost,ScarletSpiritChargeABC,10);
		ScarletSpiritChargeBoost = Math.round(ScarletSpiritChargeBoost);
		tempStrTouSpe = ScarletSpiritChargeBoost;
		mainView.statsView.showStatUp('str');
		mainView.statsView.showStatUp('tou');
		mainView.statsView.showStatUp('spe');
		mainView.statsView.showStatUp('inte');
		mainView.statsView.showStatUp('wis');
		player.buff("ScarletSpiritCharge").addStats({
			"str.mult":(ScarletSpiritChargeBoost*0.02),
			"tou.mult":(ScarletSpiritChargeBoost*0.02),
			"spe.mult":(ScarletSpiritChargeBoost*0.02),
			"int.mult":(ScarletSpiritChargeBoost*0.01),
			"wis.mult":(ScarletSpiritChargeBoost*0.01)}).withText("Scarlet Spirit Charge").combatPermanent();
    }
}
}