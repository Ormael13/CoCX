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
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
        baseSFCost = 10;
    }

    private var elementDescriptionArr:Array = [
        ["Fusion 2nd", "magical", null],
        ["Healing Breeze", "wind", StatusEffects.SummonedElementalsAirE],
        ["Synthesis", "earth", StatusEffects.SummonedElementalsEarthE],
        ["Warmth", "fire", StatusEffects.SummonedElementalsFireE],
        ["Lifewater", "water", StatusEffects.SummonedElementalsWaterE]
    ];

    override public function calcCooldown():int {
        return 0;
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

    /**
     * Change damage tags when fusing or unfusing with an elemental
     */
    public function updateAbility(element:int = 0):void
    {
    	switch(ElementalRace.getElement(player)) {
            case ElementalRace.ELEMENT_GNOME:   addTag(TAG_EARTH);
                                                break;
            case ElementalRace.ELEMENT_IGNIS:   addTag(TAG_FIRE);
                                                break;   
            case ElementalRace.ELEMENT_SYLPH:   addTag(TAG_WIND);
                                                break;   
            case ElementalRace.ELEMENT_UNDINE:  addTag(TAG_WATER);
                                                break;
            default:                            removeTag(TAG_FIRE);
                                                removeTag(TAG_EARTH);
                                                removeTag(TAG_WIND);
                                                removeTag(TAG_WATER);
                                                break;
        }
    }

    public function calcDamage(monster:Monster):Number {
        var damage:Number = 0;
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
		damage += scalingBonusIntelligence() * multiInt;
		damage += scalingBonusWisdom() * multiWis;

        return damage;
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

        if (display) outputText(" <b>([font-heal]+" + numberFormat(amountToHeal) + "</font>)</b>");
		HPChange(amountToHeal,false);

        outputText("\n\n");
    }

  
}
}  