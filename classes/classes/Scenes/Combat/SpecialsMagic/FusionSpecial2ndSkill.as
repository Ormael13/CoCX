package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.Combat;
import classes.Races.ElementalRace;

public class FusionSpecial2ndSkill extends AbstractMagicSpecial {
    public function FusionSpecial2ndSkill() {
        super (
            "Fusion Special: Second",
            "Heals the player with the power of your fused elemental.",
            TARGET_SELF,
            TIMING_INSTANT,
            [TAG_HEALING, TAG_MAGICAL, TAG_TIER2],
            PerkLib.ElementalBody
        )
        baseSFCost = 200;
    }

    private var elementDescriptionArr:Array = [
        ["Fusion 2nd", "magical", null, null],
        ["Healing Breeze", "wind", StatusEffects.SummonedElementalsAirE, TAG_WIND],
        ["Synthesis", "earth", StatusEffects.SummonedElementalsEarthE, TAG_EARTH],
        ["Warmth", "fire", StatusEffects.SummonedElementalsFireE, TAG_FIRE],
        ["Lifewater", "water", StatusEffects.SummonedElementalsWaterE, TAG_WATER]
    ];

    override public function calcCooldown():int {
        return 3;
    }

    override public function get buttonName():String {
		return elementDescriptionArr[ElementalRace.getElement(player)][0];
	}

    override public function describeEffectVs(target:Monster):String {
		return "Heals ~" + numberFormat(calcDamage(monster)) + " health";;
    }

    override public function sfCost():int {
        return sfCostMod(baseSFCost);
    }

    override public function get name():String {
        return elementDescriptionArr[ElementalRace.getElement(player)][0];
    }

    override public function presentTags():Array {
        var result:Array = super.presentTags();

        var element:int = ElementalRace.getElement(player);
        if (element) result.push(elementDescriptionArr[element][3]);

        return result;
    }

    override public function hasTag(tag:int):Boolean {
        return super.hasTag(tag) || (ElementalRace.getElement(player) && (elementDescriptionArr[ElementalRace.getElement(player)][3] == tag));
    }

    public function calcDamage(monster:Monster):Number {
        var amountToHeal:Number = 0;
		var multiInt:Number = 2;
		var multiWis:Number = 2;
        var element:int = player.statusEffectv2(elementDescriptionArr[ElementalRace.getElement(player)][2]);
        
        //Deals no damage when unfused with an elemental
        if (!element)
            return 0;

		if (element >= 4) {
			multiInt += 0.8 * (element - 3);
			multiWis += 0.8 * (element - 3);
		}
		if (element >= 7) {
			multiInt += 0.8 * (element - 6);
			multiWis += 0.8 * (element - 6);
		}
		if (element >= 10) {
			multiInt += 0.8 * (element - 9);
			multiWis += 0.8 * (element - 9);
		}
		amountToHeal += scalingBonusIntelligence() * multiInt;
		amountToHeal += scalingBonusWisdom() * multiWis;

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
        switch(ElementalRace.getElement(player)) {
            case ElementalRace.ELEMENT_GNOME:   if (display) outputText("You gather energy from sunlight into the vines covering your body, converting the nutrients and repairing some of your sustained damage.");
                                                break;
            case ElementalRace.ELEMENT_IGNIS:   if (display) outputText("You channel warmth into your wounds soothing the pain and repairing the damages you sustained.");
                                                break;
            case ElementalRace.ELEMENT_SYLPH:   if (display) outputText("You soothe your wounds with a calm breeze dulling down the pain.");
                                                break;
            case ElementalRace.ELEMENT_UNDINE:  if (display) outputText("You relax and concentrate on your liquid form closing breaches and repairing any damage you sustained.");
                                                break;
            default:                            throw new Error("Should not be able to call ability when not fused");
                                                break;
        }

        var amountToHeal:Number = calcDamage(monster);

        amountToHeal = Math.round(amountToHeal);

        if (display) outputText(" <b>([font-heal]+" + numberFormat(amountToHeal) + "[/font])</b>");
		HPChange(amountToHeal,false);

        outputText("\n\n");
    }

  
}
}  