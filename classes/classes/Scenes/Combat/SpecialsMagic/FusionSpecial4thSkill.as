package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.Combat;
import classes.Races.ElementalRace;

public class FusionSpecial4thSkill extends AbstractMagicSpecial {
    public function FusionSpecial4thSkill() {
        super (
            "Fusion Special: Fourth",
            "Attack with the power of your fused elemental over a wide area.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_MAGICAL, TAG_TIER2, TAG_AOE],
            PerkLib.ElementalBody
        )
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
        baseSFCost = 200;
    }

    override public function get isKnown():Boolean {
        return super.isKnown && player.statusEffectv2(elementDescriptionArr[ElementalRace.getElement(player)][2]) >= 6;
    }

    private var elementDescriptionArr:Array = [
        ["Fusion 4th", "magical", null, null],
        ["Tornado", "wind", StatusEffects.SummonedElementalsAirE, TAG_WIND],
        ["Stalagmite", "earth", StatusEffects.SummonedElementalsEarthE, TAG_EARTH],
        ["Explosion", "fire", StatusEffects.SummonedElementalsFireE, TAG_FIRE],
        ["Maelstrom", "water", StatusEffects.SummonedElementalsWaterE, TAG_WATER]
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
        return 4;
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
		var multiInt:Number = 2;
		var multiWis:Number = 2;
        var element:int = player.statusEffectv2(elementDescriptionArr[ElementalRace.getElement(player)][2]);
        
        //Deals no damage when unfused with an elemental
        if (!element)
            return 0;

		if (element >= 4) {
			multiInt += 0.4 * (element - 3);
			multiWis += 0.4 * (element - 3);
		}
		if (element >= 7) {
			multiInt += 0.4 * (element - 6);
			multiWis += 0.4 * (element - 6);
		}
		if (element >= 10) {
			multiInt += 0.4 * (element - 9);
			multiWis += 0.4 * (element - 9);
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

    override public function doEffect(display:Boolean = true):void {
        switch(ElementalRace.getElement(player)) {
            case ElementalRace.ELEMENT_GNOME:   if (display) outputText("You slam your fist into the ground, causing the soil to explode into a field of stalagmites impaling [Themonster]! ");
                                                break;
            case ElementalRace.ELEMENT_IGNIS:   if (display) outputText("You snap your finger, causing a small star shaped light to appear in front of [Themonster] which combusts into a massive explosion! ");
                                                break;
            case ElementalRace.ELEMENT_SYLPH:   if (display) outputText("You hold your breath before unleashing a swirling tornado at [Themonster], tossing them high in the air before letting gravity do the rest! ");
                                                break;
            case ElementalRace.ELEMENT_UNDINE:  if (display) outputText("Your body explodes into a large mass of water, pulling [Themonster] into your currents. You keep [Themonster] swirling into the maelstrom as you add rocks and debris to your attack, smashing and slamming them repeatedly before ejecting them onto the ground. ");
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
                                                if (rand(2) == 0 && !monster.hasPerk(PerkLib.Resolute) && !monster.monsterIsStunned()) {
                                                    outputText("\nThe experience leaves [Themonster] dazed!");
                                                    monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
                                                }
                                                break;
            default:                            throw new Error("Should not be able to call ability when not fused");
                                                break;
        }

        outputText("\n\n");
    }

  
}
}  