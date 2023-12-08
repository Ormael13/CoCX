package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Races.ElementalRace;
import classes.EngineCore;

public class FusionSpecialFieryRageSkill extends AbstractMagicSpecial {
    public function FusionSpecialFieryRageSkill() {
        super (
            "Fiery Rage",
            "Use your inner flames to increase your physical damage",
            TARGET_SELF,
            TIMING_TOGGLE,
            [TAG_BUFF, TAG_MAGICAL, TAG_TIER2, TAG_FIRE],
            PerkLib.ElementalBody
        )
    }

    override public function get isKnown():Boolean {
        return super.isKnown && ElementalRace.getElement(player) == ElementalRace.ELEMENT_IGNIS && player.statusEffectv2(StatusEffects.SummonedElementalsFireE) >= 5;
    }

    override public function calcCooldown():int {
        return 6;
    }

    override public function describeEffectVs(target:Monster):String {
		return "Double physical damage at the cost of " + " soulforce per turn.";
    }

    override public function sfCost():int {
        return sfCostMod(baseSFCost);
    }

    override public function advance(display:Boolean):void {
        if (isActive()) {
            if (player.soulforce < (player.maxSoulforce() * 0.05)) toggleOff(display);
            else EngineCore.SoulforceChange(-Math.round(player.maxSoulforce() * 0.05));
		}
    }

    override public function doEffect(display:Boolean = true):void {
        clearOutput();
		if (display) outputText("You let the flame of anger consume you entering a fiery rage.\n\n");
        setDuration();
    }

    override public function toggleOff(display:Boolean = true):void {
        super.toggleOff(display);
        if (display) outputText("You extinguish your flames, calming down from your fiery rage.\n\n");
    }

  
}
}  