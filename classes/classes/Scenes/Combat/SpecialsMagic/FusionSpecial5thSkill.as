package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.Combat;
import classes.Races.ElementalRace;

public class FusionSpecial5thSkill extends AbstractMagicSpecial {
    public function FusionSpecial5thSkill() {
        super (
            "Fusion Special: Firth",
            "Attack with the power of your fused elemental over a wide area. Your elemental's power lingers, causing additional damage over time",
            TARGET_ENEMY,
            TIMING_LASTING,
            [TAG_DAMAGING, TAG_MAGICAL, TAG_TIER3, TAG_AOE],
            PerkLib.ElementalBody
        )
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
        baseSFCost = 600;
    }

    override public function get isKnown():Boolean {
        return super.isKnown && player.statusEffectv2(elementDescriptionArr[ElementalRace.getElement(player)][2]) >= 8;
    }

    private var elementDescriptionArr:Array = [
        ["Fusion 5th", "magical", null, null],
        ["Vortex", "wind", StatusEffects.SummonedElementalsAirE, TAG_WIND],
        ["Earthquake", "earth", StatusEffects.SummonedElementalsEarthE, TAG_EARTH],
        ["Eruption", "fire", StatusEffects.SummonedElementalsFireE, TAG_FIRE],
        ["Tsunami", "water", StatusEffects.SummonedElementalsWaterE, TAG_WATER]
    ];

    override protected function usabilityCheck():String {
        var uc:String = super.usabilityCheck();
		if (uc) return uc;

        if (ElementalRace.getElement(player) == ElementalRace.ELEMENT_SYLPH && player.hasStatusEffect(StatusEffects.InsideSmallSpace))
            return "You can't use this inside too small spaces.";
        
        if (ElementalRace.getElement(player) == ElementalRace.ELEMENT_GNOME && monster.hasStatusEffect(StatusEffects.Flying))
            return "You can't reach flying targets.";
            
        return "";
    }

    override public function calcCooldown():int {
        return 8;
    }

    override public function calcDuration():int {
        return 5;
    }

    override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(monster)) + " " + elementDescriptionArr[ElementalRace.getElement(player)][1] +  " damage";
    }

    override public function get name():String {
        return elementDescriptionArr[ElementalRace.getElement(player)][0];
    }

    override public function sfCost():int {
        return sfCostMod(baseSFCost);
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
        var damage:Number = 0;
		var multiInt:Number = 3;
		var multiWis:Number = 3;
        var element:int = player.statusEffectv2(elementDescriptionArr[ElementalRace.getElement(player)][2]);
        
        //Deals no damage when unfused with an elemental
        if (!element)
            return 0;

		if (element >= 4) {
			multiInt += 0.6 * (element - 3);
			multiWis += 0.6 * (element - 3);
		}
		if (element >= 7) {
			multiInt += 0.6 * (element - 6);
			multiWis += 0.6 * (element - 6);
		}
		if (element >= 10) {
			multiInt += 0.6 * (element - 9);
			multiWis += 0.6 * (element - 9);
		}
		damage += scalingBonusIntelligence() * multiInt;
		damage += scalingBonusWisdom() * multiWis;

        switch(ElementalRace.getElement(player)) {
            case ElementalRace.ELEMENT_GNOME:   damage *= 2;
                                                damage *= combat.earthDamageBoostedByDao();
                                                break;
            case ElementalRace.ELEMENT_IGNIS:   damage *= combat.fireDamageBoostedByDao();
                                                break;   
            case ElementalRace.ELEMENT_SYLPH:   if (monster && monster.isFlying()) damage *= 4;
                                                damage *= combat.windDamageBoostedByDao();
                                                break;   
            case ElementalRace.ELEMENT_UNDINE:  damage *= combat.waterDamageBoostedByDao();
                                                break;
        }

        damage *= soulskillMagicalMod();
        if (monster && monster.plural) damage *= 5;

        return damage;
    }

    override public function advance(display:Boolean):void {
        switch(ElementalRace.getElement(player)) {
            case ElementalRace.ELEMENT_GNOME:   if (display) outputText("The aftershocks of your attack continues to stike [Themonster]! ");
                                                doEarthDamage(calcDamage(monster), true, display);
                                                if (display) outputText("\n\n");
                                                break;
            case ElementalRace.ELEMENT_IGNIS:   if (display) outputText("A volanic vent sprews lava, burning [Themonster]! ");
                                                doFireDamage(calcDamage(monster), true, display);
                                                if (display) outputText("\n\n");
                                                break;
            case ElementalRace.ELEMENT_SYLPH:   if (display) outputText("[Themonster] continues to be struck by debris in the vortex! ");
                                                doWindDamage(calcDamage(monster), true, display);
                                                if (display) outputText("\n\n");
                                                break;
            case ElementalRace.ELEMENT_UNDINE:  if (display) outputText("Just as [Themonster] gathers their bearings, another wave crashes into them! ");
                                                doWaterDamage(calcDamage(monster), true, display);
                                                if (display) outputText("\n\n");
                                                break;
            default:                            throw new Error("Should not be able to call ability when not fused");
                                                break;
        }
        if (rand(5) == 0 && !monster.hasPerk(PerkLib.Resolute) && !monster.monsterIsStunned()) {
            outputText("\nThe experience leaves [Themonster] dazed!");
            monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
        }
        super.advance(display);
    }

    override public function durationEnd(display:Boolean = true):void {
        if (display) outputText("<b>The lingering elemental effects has ended.</b>")
    }

    override public function doEffect(display:Boolean = true):void {
        switch(ElementalRace.getElement(player)) {
            case ElementalRace.ELEMENT_GNOME:   if (display) outputText("You brutally ram your fists into the ground, awakening Mother Earth's rage. The entire area starts to shake, as the earth cracks and breaks all around [Themonster]! ");
                                                break;
            case ElementalRace.ELEMENT_IGNIS:   if (display) outputText("You slam your palm to the ground, causing the area around you to erupt into a sea of small volcanoes! The vents begins to spew lava, drowning [Themonster] in large molten rocks!. ");
                                                break;
            case ElementalRace.ELEMENT_SYLPH:   if (display) outputText("You move your palm upward, clouds swirling as you create an all powerful vortex of air, pulling everything around within it. [Themonster] is swiftly sucked inside to be hammered by countless debris and rocks! ");
                                                break;
            case ElementalRace.ELEMENT_UNDINE:  if (display) outputText("You turn both palms downward, deversing a deluge of water in front of you. What first started as a cresting wave of water becomes a castle-breaching tsunami within seconds, engulfing [Themonster] in its deadly and powerful currents! ");
                                                break;
            default:                            throw new Error("Should not be able to call ability when not fused");
                                                break;
        }
        
        var damage:Number = calcDamage(monster);

        //Determine if critical hit!
        var crit:Boolean = false;
        var critChance:int = 5;
        critChance += combatMagicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
			damage *= 1.5;
		}

        damage = Math.round(damage);

        switch(ElementalRace.getElement(player)) {
            case ElementalRace.ELEMENT_GNOME:   damage = calcQuakeMod(damage, true);
                                                doEarthDamage(damage, true, display);
                                                if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch)) {
                                                    if (monster.hasStatusEffect(StatusEffects.AcidDoT)) {
                                                        monster.addStatusValue(StatusEffects.AcidDoT,1,1);
                                                        monster.addStatusValue(StatusEffects.AcidDoT,3,1);
                                                    }
                                                    else monster.createStatusEffect(StatusEffects.AcidDoT,4,0.02,1,0);
                                                }
                                                break;
            case ElementalRace.ELEMENT_IGNIS:   damage = calcInfernoMod(damage, true);
                                                doFireDamage(damage, true, display);
                                                if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch)) {
                                                    if (monster.hasStatusEffect(StatusEffects.BurnDoT)) monster.addStatusValue(StatusEffects.BurnDoT,1,1);
                                                    else monster.createStatusEffect(StatusEffects.BurnDoT,10,0.02,0,0);
                                                }
                                                break;
            case ElementalRace.ELEMENT_SYLPH:   damage = calcGaleMod(damage, true);
                                                doWindDamage(damage, true, display);
                                                if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch)) {
                                                    if (monster.hasStatusEffect(StatusEffects.Hemorrhage)) monster.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
                                                    else monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.05*combat.BleedDamageBoost(), 0, 0);
                                                }
                                                break;
            case ElementalRace.ELEMENT_UNDINE:  damage = calcTideMod(damage, true);
                                                doWaterDamage(damage, true, display);
                                                if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch)) {
                                                    monster.statStore.addBuffObject({str:-10,spe:-10}, "Poison",{text:"Poison"});
                                                    if (monster.hasStatusEffect(StatusEffects.FrostburnDoT)) monster.addStatusValue(StatusEffects.FrostburnDoT,1,1);
                                                    else monster.createStatusEffect(StatusEffects.FrostburnDoT,4,0,0,0);
                                                }
                                                break;
            default:                            throw new Error("Should not be able to call ability when not fused");
                                                break;
        }

        outputText("\n\n");
        setDuration();
    }

  
}
}  