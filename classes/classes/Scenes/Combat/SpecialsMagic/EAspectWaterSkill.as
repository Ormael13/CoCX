package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.Combat;

public class EAspectWaterSkill extends AbstractMagicSpecial {
    public function EAspectWaterSkill() {
        super (
            "Elemental Aspect: Water",
            "Restores the user's HP.",
            TARGET_SELF,
            TIMING_INSTANT,
            [TAG_HEALING, TAG_WATER, TAG_TIER2],
            StatusEffects.SummonedElementalsWater
        )
    }

    override public function calcCooldown():int {
        return -1;
    }

    override public function get buttonName():String {
		return "Water E.Asp";
	}

    override public function describeEffectVs(target:Monster):String {
		return "Heals the player for ~" + numberFormat(calcDamage(monster)) + " HP";
    }

    override public function manaCost():Number {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsWater);
    }

    public function calcDamage(monster:Monster):Number {
        var amountToHeal:Number = elementalAspectBaseDamage(StatusEffects.SummonedElementalsWater);

        if (player.hasPerk(PerkLib.WisenedHealer)) amountToHeal += scalingBonusWisdom();
        if (player.armor == armors.NURSECL) amountToHeal *= 1.2;
		if (player.weapon == weapons.U_STAFF) amountToHeal *= 1.5;
		if (player.weapon == weapons.ECLIPSE) amountToHeal *= 0.5;
		if (player.weapon == weapons.OCCULUS) amountToHeal *= 1.5;
		if (player.hasPerk(PerkLib.CloseToDeath) && player.HP < (player.maxHP() * 0.25)) {
			if (player.hasPerk(PerkLib.CheatDeath) && player.HP < (player.maxHP() * 0.1)) amountToHeal *= 2.5;
			else amountToHeal *= 1.5;
		}

        return amountToHeal;
    }

    override public function doEffect(display:Boolean = true):void {
        var amountToHeal:Number = Math.round(calcDamage(monster));

        if (display) outputText("Your elemental encases your body within a bubble of curative spring water, slowly closing your wounds. The bubbles pop leaving you wet, but on the way to full recovery. <b>([font-heal]+" + numberFormat(amountToHeal) + "[/font])</b>");
		HPChange(amountToHeal,false);
		if (display) outputText("\n\n");        
    }
}
}  