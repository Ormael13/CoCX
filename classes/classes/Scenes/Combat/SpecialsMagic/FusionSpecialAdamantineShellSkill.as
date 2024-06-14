package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Races.ElementalRace;

public class FusionSpecialAdamantineShellSkill extends AbstractMagicSpecial {
    public function FusionSpecialAdamantineShellSkill() {
        super (
            "Adamantine Shell",
            "Cover yourself with metal, acting as a shield against damage",
            TARGET_SELF,
            TIMING_LASTING,
            [TAG_BUFF, TAG_MAGICAL, TAG_TIER2, TAG_EARTH],
            PerkLib.ElementalBody
        )
        baseSFCost = 400;
    }

    override public function get isKnown():Boolean {
        return super.isKnown && ElementalRace.getElement(player) == ElementalRace.ELEMENT_GNOME && player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) >= 5;
    }

    override public function calcCooldown():int {
        return 10;
    }

    override public function describeEffectVs(target:Monster):String {
		return "Receive damage armour for " + calcDuration() + "rounds.";
    }

    override public function sfCost():int {
        return sfCostMod(baseSFCost);
    }

    override public function calcDuration():int {
        return 7;
    }

    override public function durationEnd(display:Boolean = true):void {
        if (display) outputText("<b>Adamantine Shell effect ended!</b>\n\n");
    }

    override public function doEffect(display:Boolean = true):void {
        clearOutput();
		if (display) outputText("You draw strength from the earth, your rock body turning to the metallic sheen and hardness of pure adamantium.\n\n");
        setDuration();
    }
  
}
}  