package classes.Scenes.Combat {
import classes.BaseContent;
import classes.BodyParts.*;
import classes.CoC;
import classes.CoC_Settings;
import classes.CockTypesEnum;
import classes.EngineCore;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.*;
import classes.ItemType;
import classes.Items.EnchantmentLib;
import classes.Items.IELib;
import classes.Items.ItemConstants;
import classes.Items.JewelryLib;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Items.WeaponRange;
import classes.Items.Weapons.*;
import classes.Items.WeaponsRange.*;
import classes.Monster;
import classes.PerkLib;
import classes.Races;
import classes.Races.ElementalRace;
import classes.Scenes.Areas.Bog.*;
import classes.Scenes.Areas.Caves.DisplacerBeast;
import classes.Scenes.Areas.Desert.*;
import classes.Scenes.Areas.Forest.*;
import classes.Scenes.Areas.GlacialRift.*;
import classes.Scenes.Areas.HighMountains.*;
import classes.Scenes.Areas.Lake.GreenSlime;
import classes.Scenes.Areas.Mountain.*;
import classes.Scenes.Areas.Ocean.SeaAnemone;
import classes.Scenes.Areas.Tundra.YoungFrostGiant;
import classes.Scenes.Areas.VolcanicCrag.GolemsTrueFire;
import classes.Scenes.Camp.TrainingDummy;
import classes.Scenes.Dungeons.D3.*;
import classes.Scenes.Dungeons.DeepCave.*;
import classes.Scenes.Dungeons.DemonLab.*;
import classes.Scenes.Dungeons.EbonLabyrinth.*;
import classes.Scenes.Dungeons.HelDungeon.*;
import classes.Scenes.Dungeons.RiverDungeon.TwinBosses;
import classes.Scenes.Monsters.Magnar;
import classes.Scenes.Monsters.WerewolfFemale;
import classes.Scenes.Monsters.WerewolfHuntress;
import classes.Scenes.NPCs.*;
import classes.Scenes.Places.Boat.*;
import classes.Scenes.Places.Farm.Kelt;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.Quests.UrtaQuest.Sirius;
import classes.Scenes.SceneLib;
import classes.Stats.Buff;
import classes.StatusEffectClass;
import classes.StatusEffectType;
import classes.StatusEffects;
import classes.StatusEffects.VampireThirstEffect;
import com.bit101.components.NumericStepper;

import coc.view.ButtonData;
import coc.view.ButtonDataList;
import coc.view.MainView;

import mx.formatters.NumberFormatter;

//import flash.utils.getTimer;

public class Combat extends BaseContent {
    public var pspecials:PhysicalSpecials = new PhysicalSpecials();
    public var mspecials:MagicSpecials = new MagicSpecials();
    public var magic:CombatMagic = new CombatMagic();
    public var teases:CombatTeases = new CombatTeases();
    public var soulskills:CombatSoulskills = new CombatSoulskills();
    public var comfoll:CombatFollowersActions = new CombatFollowersActions();
    public var ui:CombatUI = new CombatUI();
	public var meleeDamageNoLag:Number = 0;
    public var MDOCount:int = 0; // count of how many times damage was deal
    public var MSGControll:Boolean = false; // need to correctly display damage MSG
    public var MSGControllForEvasion:Boolean = false; // need to correctly display damage MSG. This way as i use it game will show just first damage msg.

    // Following is reused variables throughout the multiple feral attack function calls
    // E.N.W.A, kinda sounds like something out of Tolkein/Lord of the Ring
    public var enwa_accMelee:Number = 0;
    public var enwa_damage:Number = 0;
    public var enwa_critChance:int = 5;
    public var enwa_lustClawDamage:Number = 6;
    public var enwa_lustMultiplier:Number = 1;
    public var enwa_lustCritChance:Number = 5;
    public var enwa_lustPostMulti:Number = 1;

    public static const NONE:int = 0;
    public static const AIR:int = 1;
    public static const EARTH:int = 2;
    public static const FIRE:int = 3;
    public static const WATER:int = 4;
    public static const ICE:int = 5;
    public static const LIGHTNING:int = 6;
    public static const DARKNESS:int = 7;
    public static const WOOD:int = 8;
    public static const METAL:int = 9;
    public static const ETHER:int = 10;
    public static const POISON:int = 11;
    public static const PURITY:int = 12;
    public static const CORRUPTION:int = 13;
    public static const NONE_E:int = 30;
    public static const AIR_E:int = 31;
    public static const EARTH_E:int = 32;
    public static const FIRE_E:int = 33;
    public static const WATER_E:int = 34;

    // 1 => arrow, 2 => hp spell, 3 => lust spell, 4 => physical
    public static const LAST_ATTACK_BOW:int = 1;
    public static const LAST_ATTACK_SPELL:int = 2;
    public static const LAST_ATTACK_LUST:int = 3;
    public static const LAST_ATTACK_PHYS:int = 4;


    public function get inCombat():Boolean {
        return CoC.instance.inCombat;
    }
    public function set inCombat(value:Boolean):void {
        CoC.instance.inCombat = value;
    }
    
    public function callbackBeforeAbility(ability:CombatAbility):void {
        clearOutput();
        doNext(combatMenu);
    }
    public function callbackAfterAbility(ability:CombatAbility):void {
        statScreenRefresh();
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
        } else if (monster.lust >= monster.maxOverLust()) {
            doNext(endLustVictory);
        } else if(player.lust >= player.maxOverLust() && !player.statStore.hasBuff("Supercharged") && !tyrantiaTrainingExtension()) {
            doNext(endLustLoss);
        } else {
            enemyAI();
        }
    }

    public function masteryFeralCombatLevel():Number {return player.combatMastery[0].level;}
    public function masteryGauntletLevel():Number {return player.combatMastery[1].level;}
	public function masteryDaggerLevel():Number {return player.combatMastery[2].level;}
    public function masterySwordLevel():Number {return player.combatMastery[3].level;}
	public function masteryAxeLevel():Number {return player.combatMastery[4].level;}
    public function masteryMaceHammerLevel():Number {return player.combatMastery[5].level;}
	public function masteryDuelingSwordLevel():Number {return player.combatMastery[6].level;}
	public function masteryPolearmLevel():Number {return player.combatMastery[7].level;}
	public function masterySpearLevel():Number {return player.combatMastery[8].level;}
	public function masteryWhipLevel():Number {return player.combatMastery[9].level;}
	public function masteryExoticLevel():Number {return player.combatMastery[10].level;}
	public function masteryArcheryLevel():Number {return player.combatMastery[11].level;}
	public function masteryThrowingLevel():Number {return player.combatMastery[12].level;}
	public function masteryFirearmsLevel():Number {return player.combatMastery[13].level}
	public function dualWSLevel():Number {return player.combatMastery[14].level;}
    public function dualWNLevel():Number {return player.combatMastery[15].level;}
    public function dualWLLevel():Number {return player.combatMastery[16].level;}
    public function dualWFLevel():Number {return player.combatMastery[17].level;}
    public function weaponSizeSmall():Number {return player.combatMastery[18].level;}
    public function weaponSizeNormal():Number {return player.combatMastery[19].level;}
    public function weaponSizeLarge():Number {return player.combatMastery[20].level;}
    public function weaponSizeMassive():Number {return player.combatMastery[21].level;}
    //public function weaponSizeRange():Number {return player.combatMastery[22].level;}
    public function masteryUnarmedCombatLevel():Number {return player.combatMastery[23].level;}
    public function dualWMLevel():Number {return player.combatMastery[24].level;}

    public function bonusExpAfterSuccesfullTease():Number {
        return teases.bonusExpAfterSuccesfullTease();
    }

    public function physicalCost(mod:Number):Number {
        var costPercent:Number = 100;
        if (player.hasPerk(PerkLib.IronMan)) costPercent -= 50;
        if (player.hasPerk(PerkLib.ZenjisInfluence3)) costPercent -= 20;
		if (player.perkv1(IMutationsLib.HumanParathyroidGlandIM) >= 3 && player.racialScore(Races.HUMAN) > 17) costPercent -= 10;
        if (costPercent < 10) costPercent = 10;
        mod *= costPercent / 100;
        return mod;
    }

    public function bowCost(mod:Number):Number {
        var costPercent:Number = 100;
        if (player.hasPerk(PerkLib.BowShooting)) costPercent -= player.perkv1(PerkLib.BowShooting);
        //if(player.hasPerk(PerkLib.)) costPercent -= x0; ((tu umieścić perk dający zmniejszenie % kosztu użycia łuku jak IronMan dla fiz specjali ^^))
        if (costPercent < 10) costPercent = 10;
        mod *= costPercent / 100;
        return mod;
    }

    public function spellCost(mod:Number):Number {
        return magic.spellCostImpl(mod);
    }

    public function spellCostWhite(mod:Number):Number {
        return magic.spellCostWhiteImpl(mod);
    }

    public function spellCostBlack(mod:Number):Number {
        return magic.spellCostBlackImpl(mod);
    }

    public function spellCostGrey(mod:Number):Number {
        return magic.spellCostGreyImpl(mod);
    }

    public function spellCostBlood(mod:Number):Number {
        return magic.spellCostBloodImpl(mod);
    }

    public function spellCostGreen(mod:Number):Number {
        return magic.spellCostWhiteImpl(mod);
    }

    public function healCost(mod:Number):Number {
        return magic.healCostImpl(mod);
    }

    public function healCostWhite(mod:Number):Number {
        return magic.healCostWhiteImpl(mod);
    }

    public function healCostBlack(mod:Number):Number {
        return magic.healCostBlackImpl(mod);
    }

    public function spellPerkUnlock():void {
        var counter:Number = flags[kFLAGS.SPELLS_CAST];
        var max:Number = 10;
        if (counter >= 10) {
            if (!player.hasPerk(PerkLib.SpellcastingAffinity)) {
                outputText("<b>You've become more comfortable with your spells, unlocking the Spellcasting Affinity perk and reducing mana cost of spells by 10%!</b>\n\n");
                player.createPerk(PerkLib.SpellcastingAffinity, 10, 0, 0, 0);
            }
            max = 30;
        }
        if (counter >= 30) {
            if (player.perkv1(PerkLib.SpellcastingAffinity) < 20) {
                outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
                player.setPerkValue(PerkLib.SpellcastingAffinity, 1, 20);
            }
            max = 70;
        }
        if (counter >= 70) {
            if (player.perkv1(PerkLib.SpellcastingAffinity) < 30) {
                outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
                player.setPerkValue(PerkLib.SpellcastingAffinity, 1, 30);
            }
            max = 150;
        }
        if (counter >= 150) {
            if (player.perkv1(PerkLib.SpellcastingAffinity) < 40) {
                outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
                player.setPerkValue(PerkLib.SpellcastingAffinity, 1, 40);
            }
            max = 310;
        }
        if (counter >= 310) {
            if (player.perkv1(PerkLib.SpellcastingAffinity) < 50) {
                outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
                player.setPerkValue(PerkLib.SpellcastingAffinity, 1, 50);
            }
            max = Infinity;
        }
        if (isFinite(max)) {
            notificationView.popupProgressBar2("spellXP","spellXP",
                    "Spellcasting XP", (counter-1)/max, counter/max);
        }
    }

    internal function applyAutocast0():void {
        outputText("\n\n");
        if (flags[kFLAGS.AUTO_FLIGHT] > 0 && !player.hasStatusEffect(StatusEffects.FlyingDisabled)) {
            if (flags[kFLAGS.AUTO_FLIGHT] == 1 && player.canFly()) {
                if (player.wings.type == Wings.WINDY_AURA && player.arms.type == Arms.KAMAITACHI) outputText("You create a small cyclone to ride upon and lift yourself up in the air.");
                else if (player.wings.type == Wings.THUNDEROUS_AURA) outputText("You take flight, letting the raging storm carry you into the air.");
                else if (player.wings.type == Wings.ETHEREAL) outputText("You take flight, ascending through the storm.");
                else if (player.wings.type == Wings.LEVITATION) outputText("You focus your kinetic abilities, willing yourself into the air.");
                else outputText("You open your wings and take flight.");
                player.createStatusEffect(StatusEffects.Flying, flightDurationNatural(), 0, 0, 0);
            }
            else if (flags[kFLAGS.AUTO_FLIGHT] == 2 && player.soulforce >= flyingSwordUseCost() && player.weaponFlyingSwordsName != "nothing") {
                outputText("You jump on your "+player.weaponFlyingSwordsName+", taking flight.");
                player.createStatusEffect(StatusEffects.Flying, 1, 1, 0, 0);
            }
            else if (flags[kFLAGS.AUTO_FLIGHT] == 3 && player.soulforce >= flyingWithSoulforceCost()) {
                outputText("You surround your body with soulforce, taking to the sky with a brilliant aura"+(player.weaponFlyingSwordsName != "nothing"?" as "+player.weaponFlyingSwordsName+" hovers near you. Your flying weapon is ready to be used at any time":"")+".");
                player.createStatusEffect(StatusEffects.Flying, 1, 2, 0, 0);
            }
            if (player.hasPerk(PerkLib.Resolute) < 0) {
                player.createStatusEffect(StatusEffects.FlyingNoStun, 0, 0, 0, 0);
                player.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
            }
            monster.createStatusEffect(StatusEffects.MonsterAttacksDisabled, 0, 0, 0, 0);
            outputText("\n\n");
        }
        if (player.hasPerk(PerkLib.AffinitySylph) && !player.hasStatusEffect(StatusEffects.InsideSmallSpace) && !player.hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
            player.createStatusEffect(StatusEffects.Flying, 1, 3, 0, 0);
            if (player.hasPerk(PerkLib.Resolute) < 0) {
                player.createStatusEffect(StatusEffects.FlyingNoStun, 0, 0, 0, 0);
                player.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
            }
            monster.createStatusEffect(StatusEffects.MonsterAttacksDisabled, 0, 0, 0, 0);
        }
    }

    public function soulskillCost():Number {
		return soulskills.soulskillCostImpl();
	}
	public function soulskillcostmulti():Number {
		return soulskills.soulskillcostmultiImpl();
	}
	public function soulskillMod():Number {
		return soulskills.soulskillModImpl();
	}
	public function soulskillPhysicalMod():Number {
		return soulskills.soulskillPhysicalModImpl();
	}
	public function soulskillMagicalMod():Number {
		return soulskills.soulskillMagicalModImpl();
	}
	public function soulskillCooldown(duration:int = 2, physical:Boolean = true):Number {
		return soulskills.soulskillCooldownImpl(duration, physical);
	}
	public function soulskillTier2Cooldown(duration:int = 4, physical:Boolean = true):Number {
		return soulskills.soulskillTier2CooldownImpl(duration, physical);
	}
	public function soulskillTier3Cooldown(duration:int = 10, physical:Boolean = true):Number {
		return soulskills.soulskillTier3CooldownImpl(duration, physical);
	}

    public function spellMod():Number {
        return magic.spellModImpl();
    }

    public function spellModWhite():Number {
        return magic.spellModWhiteImpl();
    }

    public function spellWhiteCooldown():Number {
        return magic.spellWhiteCooldownImpl();
    }

    public function spellWhiteTier2Cooldown():Number {
        return magic.spellWhiteTier2CooldownImpl();
    }

    public function spellWhiteTier3Cooldown():Number {
        return magic.spellWhiteTier3CooldownImpl();
    }

    public function spellModBlack():Number {
        return magic.spellModBlackImpl();
    }

    public function spellModBlood():Number {
        return magic.spellModBloodImpl();
    }

    public function spellBlackCooldown():Number {
        return magic.spellBlackCooldownImpl();
    }

    public function spellBlackTier2Cooldown():Number {
        return magic.spellBlackTier2CooldownImpl();
    }

    public function spellBlackTier3Cooldown():Number {
        return magic.spellBlackTier3CooldownImpl();
    }

    public function spellModGrey():Number {
        return magic.spellModGreyImpl();
    }

    public function spellGreyCooldown():Number {
        return magic.spellGreyCooldownImpl();
    }

    public function spellGreyTier2Cooldown():Number {
        return magic.spellGreyTier2CooldownImpl();
    }

    public function spellGenericCooldown():Number {
        return magic.spellGenericCooldownImpl();
    }

    public function spellModGreen():Number {
        return magic.spellModGreenImpl();
    }

    public function healMod():Number {
        return magic.healModImpl();
    }

    public function healModWhite():Number {
        return magic.healModWhiteImpl();
    }

    public function healModBlack():Number {
        return magic.healModBlackImpl();
    }

    public function canSpearDance():Boolean{
        return (player.hasPerk(PerkLib.ELFElvenSpearDancingFlurry1to4) && player.isElf());
    }

    public function maxCurrentAttacks():int {
        if (player.isStaffTypeWeapon() || player.isWandTypeWeapon()) return 1;
        else return player.calculateMultiAttacks();
    }

    public function maxBowAttacks():int {
        /*var extraHits:Number = 0;
        var baseHits:Number;
        if (player.isElf() && player.hasPerk(PerkLib.ELFMasterShot)) extraHits = 1;
        if (player.hasPerk(PerkLib.Multishot)) baseHits = 6;
        else if (player.hasPerk(PerkLib.WildQuiver)) baseHits = 5;
        else if (player.hasPerk(PerkLib.Manyshot)) baseHits = 4;
        else if (player.hasPerk(PerkLib.WeaponRangeTripleStrike)) baseHits = 3;
        else if (player.hasPerk(PerkLib.WeaponRangeDoubleStrike)) baseHits = 2;
        else baseHits = 1;
        return (baseHits+extraHits) * (flags[kFLAGS.ELVEN_TWINSHOT_ENABLED] ? 2 : 1);*/
        return player.calculateMaxAttacksForClass(false, 0) +
            (player.isBowTypeWeapon() && player.hasPerk(PerkLib.ELFMasterShot))? 1: 0;
    }

    public function maxCrossbowAttacks():int {
        /*if (player.hasPerk(PerkLib.WeaponRangeTripleStrike)) return 3;
        else if (player.hasPerk(PerkLib.WeaponRangeDoubleStrike)) return 2;
        else return 1;*/
        return player.calculateMaxAttacksForClass(false, 1);
    }

    public function maxThrowingAttacks():int {
        /*if (player.hasPerk(PerkLib.WeaponRangeTripleStrike)) return 3;
        else if (player.hasPerk(PerkLib.WeaponRangeDoubleStrike)) return 2;
        else return 1;*/
        return player.calculateMaxAttacksForClass(false, 2);
    }

    public function maxFirearmsAttacks():int {
		/*var bonusShots:Number = 0;
		if (player.hasPerk(PerkLib.LockAndLoad)) {
			if (player.hasPerk(PerkLib.Multishot)) bonusShots = 2;
			bonusShots = 1;
		}
        if (player.hasPerk(PerkLib.MasterGunslinger)) return 4+bonusShots;
        else if (player.hasPerk(PerkLib.ExpertGunslinger)) return 3+bonusShots;
        else if (player.hasPerk(PerkLib.AmateurGunslinger)) return 2+bonusShots;
        else return 1;*/
        return player.calculateMaxAttacksForClass(false, 3);
    }

    public function maxCurrentRangeAttacks():int {
        return player.calculateMultiAttacks(false);
    }

    public function endHpVictory():void {
        monster.defeated_(true);
    }

    public function endLustVictory():void {
        monster.defeated_(false);
    }

    public function endHpLoss():void {
		if (player.hasStatusEffect(StatusEffects.TearsOfDenial) && player.statusEffectv1(StatusEffects.TearsOfDenial) == 1) {
			player.addStatusValue(StatusEffects.TearsOfDenial, 1, -1);
			outputText("Just as you would be defeated, the Tears of Denial you prepared restores you to full health and clarity of mind. To [themonster] dismay you get back up, still undefeated and ready to keep fighting.");
			if (player.hasStatusEffect(StatusEffects.CombatWounds)) player.removeStatusEffect(StatusEffects.CombatWounds);
			player.HP = player.maxOverHP();
			player.lust = player.minLust();
			combatMenu(false);
		}
		else if ((player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking)) && player.hasPerk(PerkLib.TooAngryToDie)) {
			if (!player.hasStatusEffect(StatusEffects.TooAngryTooDie)) player.createStatusEffect(StatusEffects.TooAngryTooDie, 0, 0, 0, 0);
			player.HP = player.minHP() + 1;
            combatMenu(false);
		}
        else if (player.hasPerk(PerkLib.Immortality) || player.hasPerk(PerkLib.WhatIsReality)) {
            player.takeLustDamage( player.HP - player.minHP(), true);
            player.HP = player.minHP() + 1;
            combatMenu(false);
        }
        else monster.won_(true, false);
    }

    public function endLustLoss():void {
		if (player.hasStatusEffect(StatusEffects.TearsOfDenial) && player.statusEffectv1(StatusEffects.TearsOfDenial) == 1) {
			player.addStatusValue(StatusEffects.TearsOfDenial, 1, -1);
			outputText("Just as you would be defeated, the Tears of Denial you prepared restores you to full health and clarity of mind. To [themonster] dismay you get back up, still undefeated and ready to keep fighting.");
			player.HP = player.maxOverHP();
			player.lust = player.minLust();
			doNext(combatMenu, true);
		}
        else {
			if (player.hasStatusEffect(StatusEffects.Infested) && flags[kFLAGS.CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[kFLAGS.CAME_WORMS_AFTER_COMBAT] = 1;
				SceneLib.mountain.wormsScene.infestOrgasm();
				monster.won_(false, true);
			}
			else monster.won_(false, false);
        }
    }
	
	public function tyrantiaTrainingExtension():Boolean {
		var extension:Boolean = false;
        if (player.hasStatusEffect(StatusEffects.TyrantState) && TyrantiaFollower.TyrantiaTrainingSessions >= 30 && (!player.hasStatusEffect(StatusEffects.TyrantiaTraining30) || (player.hasStatusEffect(StatusEffects.TyrantiaTraining30) && player.statusEffectv1(StatusEffects.TyrantiaTraining30) < 2))) extension = true;
		return extension;
	}

//combat is over. Clear shit out and go to main
    public function cleanupAfterCombatImpl(nextFunc:Function = null, ThisIsNotATFScene:Boolean = true):void {
        magic.cleanupAfterCombatImpl();
        if (nextFunc == null) nextFunc = inDungeon ? playerMenu : explorer.done;
        if (inCombat) {
            //clear status
            clearStatuses(false);
            //Clear itemswapping in case it hung somehow
//No longer used:		itemSwapping = false;
            //Player won
            if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) {
                awardPlayer(nextFunc);
            }
            //Player lost
            else {
                explorer.stopExploring();
                if (monster.statusEffectv1(StatusEffects.Sparring) == 2) {
                    clearOutput();
                    outputText("The cow-girl has defeated you in a practice fight!");
                    outputText("\n\nYou have to lean on Isabella's shoulder while the two of your hike back to camp.  She clearly won.");
                    inCombat = false;
                    player.HP = player.minHP()+1;
                    statScreenRefresh();
                    doNext(nextFunc);
                    return;
                }
                //Next button is handled within the minerva loss function
                if (monster.hasStatusEffect(StatusEffects.PeachLootLoss)) {
                    inCombat = false;
                    player.HP = player.minHP()+1;
                    statScreenRefresh();
                    return;
                }
                if (monster is Ember) {
                    inCombat = false;
                    player.HP = player.minHP()+1;
                    statScreenRefresh();
                    doNext(nextFunc);
                    return;
                }
                if(ThisIsNotATFScene){
                    var gemsLost:int = rand(10) + 1 + Math.round(monster.level / 2);
                    if (inDungeon) gemsLost += 20 + monster.level * 2;
                    //Increases gems lost in NG+.
                    gemsLost *= 1 + (player.newGamePlusMod() * 0.5);
                    //Round gems.
                    gemsLost = Math.round(gemsLost);
                    if (player.hasStatusEffect(StatusEffects.SoulArena) || monster.hasPerk(PerkLib.NoGemsLost)) gemsLost = 0;
				    //Keep gems from going below zero.
                    if (gemsLost > player.gems) gemsLost = player.gems;
                    if (monster is Etna) gemsLost = 0;
                    var timePasses:int = monster.handleCombatLossText(inDungeon, gemsLost); //Allows monsters to customize the loss text and the amount of time lost
                    if (player.hasStatusEffect(StatusEffects.SoulArena) || (monster is HellfireSnail && (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)))) timePasses = 1;
                    player.gems -= gemsLost;
                    if (monster.perkv3(PerkLib.NoGemsLost) > 0) player.gems += monster.perkv3(PerkLib.NoGemsLost);
                }
                inCombat = false;
                if (player.hasStatusEffect(StatusEffects.SoulArena)) player.removeStatusEffect(StatusEffects.SoulArena);
                if (player.hasStatusEffect(StatusEffects.SoulArenaGaunlet)) player.removeStatusEffect(StatusEffects.SoulArenaGaunlet);
                if (player.hasStatusEffect(StatusEffects.LockingCurse)) player.removeStatusEffect(StatusEffects.LockingCurse);
                //BUNUS XPZ
                if (flags[kFLAGS.COMBAT_BONUS_XP_VALUE] > 0) {
                    player.XP += flags[kFLAGS.COMBAT_BONUS_XP_VALUE];
                    outputText("  Somehow you managed to gain " + flags[kFLAGS.COMBAT_BONUS_XP_VALUE] + " XP from the situation.");
                    flags[kFLAGS.COMBAT_BONUS_XP_VALUE] = 0;
                }
                //Bonus lewts
                if (flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] != "") {
                    outputText("  Somehow you came away from the encounter with " + ItemType.lookupItem(flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID]).longName + ".\n\n");
                    inventory.takeItem(ItemType.lookupItem(flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID]), createCallBackFunction(camp.returnToCamp, timePasses));
                    flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = "";
                } else doNext(createCallBackFunction(camp.returnToCamp, timePasses));
				//SF harvest
				if (player.hasPerk(PerkLib.PrestigeJobNecromancer) && monster.soulforce > 0) {
					var SFHarvest:Number = monster.level * (1 + rand(3));
					if (SFHarvest > monster.soulforce) SFHarvest = monster.soulforce;
					EngineCore.SoulforceChange(SFHarvest);
				}
            }
        }
        //Not actually in combat
        else doNext(nextFunc);
    }

    public function checkAchievementDamage(damage:Number):void {
        flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] += damage;
        if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 50000) EngineCore.awardAchievement("Bloodletter", kACHIEVEMENTS.COMBAT_BLOOD_LETTER);
        if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 200000) EngineCore.awardAchievement("Reiterpallasch", kACHIEVEMENTS.COMBAT_REITERPALLASCH);
        if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 1000000) EngineCore.awardAchievement("Uncanny Bloodletter", kACHIEVEMENTS.COMBAT_UNCANNY_BLOOD_LETTER);
        if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 5000000) EngineCore.awardAchievement("Uncanny Reiterpallasch", kACHIEVEMENTS.COMBAT_UNCANNY_REITERPALLASCH);
        /*if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 500000000) EngineCore.awardAchievement("Re:Bloodletter", kACHIEVEMENTS.COMBAT_BLOOD_LETTER);
        if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 2000000000) EngineCore.awardAchievement("Re:Reiterpallasch", kACHIEVEMENTS.COMBAT_REITERPALLASCH);
        if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 10000000000) EngineCore.awardAchievement("Re:Uncanny Bloodletter", kACHIEVEMENTS.COMBAT_UNCANNY_BLOOD_LETTER);
        if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 50000000000) EngineCore.awardAchievement("Re:Uncanny Reiterpallasch", kACHIEVEMENTS.COMBAT_UNCANNY_REITERPALLASCH);*/
        if (damage >= 50) EngineCore.awardAchievement("Pain", kACHIEVEMENTS.COMBAT_PAIN);
        if (damage >= 100) EngineCore.awardAchievement("Fractured Limbs", kACHIEVEMENTS.COMBAT_FRACTURED_LIMBS);
        if (damage >= 250) EngineCore.awardAchievement("Broken Bones", kACHIEVEMENTS.COMBAT_BROKEN_BONES);
        if (damage >= 500) EngineCore.awardAchievement("Overkill", kACHIEVEMENTS.COMBAT_OVERKILL);
        if (damage >= 1000) EngineCore.awardAchievement("Meat Pasty", kACHIEVEMENTS.COMBAT_MEAT_PASTY);
        if (damage >= 2500) EngineCore.awardAchievement("Pulverize", kACHIEVEMENTS.COMBAT_PULVERIZE);
        if (damage >= 5000) EngineCore.awardAchievement("Erase", kACHIEVEMENTS.COMBAT_ERASE);
        /*if (damage >= 50000) EngineCore.awardAchievement("Re:Pain", kACHIEVEMENTS.COMBAT_PAIN);
        if (damage >= 100000) EngineCore.awardAchievement("Re:Fractured Limbs", kACHIEVEMENTS.COMBAT_FRACTURED_LIMBS);
        if (damage >= 250000) EngineCore.awardAchievement("Re:Broken Bones", kACHIEVEMENTS.COMBAT_BROKEN_BONES);
        if (damage >= 500000) EngineCore.awardAchievement("Re:Overkill", kACHIEVEMENTS.COMBAT_OVERKILL);
        if (damage >= 1000000) EngineCore.awardAchievement("Re:Meat Pasty", kACHIEVEMENTS.COMBAT_MEAT_PASTY);
        if (damage >= 2500000) EngineCore.awardAchievement("Re:Pulverize", kACHIEVEMENTS.COMBAT_PULVERIZE);
        if (damage >= 5000000) EngineCore.awardAchievement("Re:Erase", kACHIEVEMENTS.COMBAT_ERASE);*/
    }

    /*public function checkMinionsAchievementDamage(damage:Number):void
{
	flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] += damage;
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 50000) CoC.instance.awardAchievement("Bloodletter", kACHIEVEMENTS.COMBAT_BLOOD_LETTER);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 200000) CoC.instance.awardAchievement("Reiterpallasch", kACHIEVEMENTS.COMBAT_REITERPALLASCH);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 1000000) CoC.instance.awardAchievement("Uncanny Bloodletter", kACHIEVEMENTS.COMBAT_UNCANNY_BLOOD_LETTER);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 5000000) CoC.instance.awardAchievement("Uncanny Reiterpallasch", kACHIEVEMENTS.COMBAT_UNCANNY_REITERPALLASCH);
	if (damage >= 50) CoC.instance.awardAchievement("Pain", kACHIEVEMENTS.COMBAT_PAIN);
	if (damage >= 100) CoC.instance.awardAchievement("Fractured Limbs", kACHIEVEMENTS.COMBAT_FRACTURED_LIMBS);
	if (damage >= 250) CoC.instance.awardAchievement("Broken Bones", kACHIEVEMENTS.COMBAT_BROKEN_BONES);
	if (damage >= 500) CoC.instance.awardAchievement("Overkill", kACHIEVEMENTS.COMBAT_OVERKILL);
	if (damage >= 1000) CoC.instance.awardAchievement("Meat Pasty", kACHIEVEMENTS.COMBAT_MEAT_PASTY);
	if (damage >= 2500) CoC.instance.awardAchievement("Pulverize", kACHIEVEMENTS.COMBAT_PULVERIZE);
	if (damage >= 5000) CoC.instance.awardAchievement("Erase", kACHIEVEMENTS.COMBAT_ERASE);
}*/

	public function checkConcentration(replacetext:String = "", sceneimpl:Boolean = false):Boolean {
	//Amily concentration
	//	if (checkConcentration()) return;
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			if (replacetext == "") {
				outputText("[monster name] easily glides around your attack thanks to [monster his] complete concentration on your movements.\n\n");
			} else {
				outputText(replacetext);
			}
			if (!sceneimpl) enemyAI();
			if (sceneimpl) SceneLib.combat.enemyAIImpl();
			return true;
		}
		return false;
	}

    public function approachAfterKnockback1():void {
        clearOutput();
        outputText("You close the distance between you and [themonster] as quickly as possible.\n\n");
        player.removeStatusEffect(StatusEffects.KnockedBack);
        reloadWeapon1();
    }

    public function approachAfterKnockback2():void {
        clearOutput();
        outputText("You close the distance between you and [themonster] as quickly as possible.\n\n");
        player.removeStatusEffect(StatusEffects.KnockedBack);
        outputText("At the same time, you fire a round at [monster name]. ");
        fireBow();
    }

    public function approachAfterKnockback3():void {
        clearOutput();
        outputText("You close the distance between you and [themonster] as quickly as possible.\n\n");
        player.removeStatusEffect(StatusEffects.KnockedBack);
		enemyAIImpl();
    }

    public function get isEnemyInvisible():Boolean {
        return player.hasStatusEffect(StatusEffects.MonsterInvisible) && (player.hasStatusEffect(StatusEffects.MonsterDig) || !player.hasPerk(PerkLib.TrueSeeing));
    }
    public function get isEnemyInvisibleButNotUnderground():Boolean {
        return player.hasStatusEffect(StatusEffects.MonsterInvisible) && !player.hasStatusEffect(StatusEffects.MonsterDig) && !player.hasPerk(PerkLib.TrueSeeing);
    }

    public function isPlayerSilenced():Boolean {
        var silenced:Boolean = false;
        if (player.hasStatusEffect(StatusEffects.ThroatPunch)) silenced = true;
        if (player.hasStatusEffect(StatusEffects.WebSilence)) silenced = true;
        if (player.hasStatusEffect(StatusEffects.GooArmorSilence)) silenced = true;
        return silenced;
    }

    public function isPlayerBound():Boolean {
        var playerStatuses:Array = [
            StatusEffects.HarpyBind,
            StatusEffects.GooBind,
            StatusEffects.TentacleBind,
            StatusEffects.NagaBind,
            StatusEffects.ScyllaBind,
            StatusEffects.WolfHold,
            StatusEffects.TrollHold,
            StatusEffects.PossessionWendigo,
            StatusEffects.ArcaneWeb,
            StatusEffects.HolliConstrict,
            StatusEffects.GooArmorBind,
            StatusEffects.UBERWEB,
            StatusEffects.Bound,
            StatusEffects.CancerMonsterGrab,
            StatusEffects.Chokeslam,
            StatusEffects.Titsmother,
            StatusEffects.Pounced,
            StatusEffects.YamataEntwine,
            StatusEffects.GiantGrabbed,
            StatusEffects.Tentagrappled,
            StatusEffects.SiegweirdGrapple,
            StatusEffects.MagnarPinned,
            StatusEffects.Straddle,
            StatusEffects.DragonsNom,
            StatusEffects.Devoured,
            StatusEffects.Terrorize,
                //Monster statuses
            StatusEffects.QueenBind,
            StatusEffects.PCTailTangle,
            StatusEffects.MinotaurEntangled,
        ];
        if (monster.hasStatusEffect(StatusEffects.MinotaurEntangled)) outputText("\n<b>You're bound up in the minotaur lord's chains!  All you can do is try to struggle free!</b>");
        if (player.hasStatusEffect(StatusEffects.GiantGrabbed)) outputText("\n<b>You're trapped in the giant's hand!  All you can do is try to struggle free!</b>");
        if (player.hasStatusEffect(StatusEffects.Tentagrappled)) outputText("\n<b>The demoness's tentacles are constricting your limbs!</b>");
        if (player.hasStatusEffect(StatusEffects.Straddle) && monster is ProjectNightwalker) (monster as ProjectNightwalker).faceSittingDescript();
        if (player.hasStatusEffect(StatusEffects.DragonsNom)) outputText("\n<b>The Dragon has you firmly clamped between its jaws!</b>");
        var foundStatus:Boolean = playerStatuses.some(function (status:StatusEffectType, index:int, array:Array):Boolean {
            return player.hasStatusEffect(status);
        });
        return foundStatus;
    }

    public function isPlayerStunned():Boolean {
        var stunned:Boolean = false;
        if (player.hasStatusEffect(StatusEffects.IsabellaStunned) || player.hasStatusEffect(StatusEffects.Stunned)) {
            outputText("\n<b>You're too stunned to attack!</b>  All you can do is wait and try to recover!");
            stunned = true;
        }
        if (player.hasStatusEffect(StatusEffects.Whispered)) {
            outputText("\n<b>Your mind is too addled to focus on combat!</b>  All you can do is try and recover!");
            stunned = true;
        }
        if (player.hasStatusEffect(StatusEffects.Confusion)) {
            outputText("\n<b>You're too confused</b> Who are you trying to attack? You grab your head in confusion");
            stunned = true;
        }
        return stunned;
    }

	public function isPlayerPowerStunned():Boolean {
		var powerstunned:Boolean = false;
        if (player.hasStatusEffect(StatusEffects.Polymorphed)) {
            outputText("\n<b>You fight against the spell to return to your true form!</b>");
            powerstunned = true;
        }
        if (player.hasStatusEffect(StatusEffects.FrozenSolid)) {
            outputText("\n<b>placeholder text</b>");
            powerstunned = true;
        }
		return powerstunned;
	}

    public function isPlayerFeared():Boolean {
        var feared:Boolean = false;
        if (player.hasStatusEffect(StatusEffects.Fear)) {
			outputText("\n<b>You're too busy shivering with fear</b> to fight.");
			feared = true;
		}
        return feared;
    }

    public function canUseMagic():Boolean {
        if (player.hasStatusEffect(StatusEffects.ThroatPunch)) return false;
        else if (player.hasStatusEffect(StatusEffects.WebSilence)) return false;
        else if (player.hasStatusEffect(StatusEffects.GooArmorSilence)) return false;
        else if (player.hasStatusEffect(StatusEffects.WhipSilence)) return false;
        else if (player.hasStatusEffect(StatusEffects.PiercingBlow)) return false;
		else if (player.statStore.hasBuff("Supercharged")) return false;
        return true;
    }

    public function combatMenu(newRound:Boolean = true):void { //If returning from a sub menu set newRound to false
        clearOutput();
		meleeDamageNoLag = 0;
        MDOCount = 0;
        MSGControll = false;
        MSGControllForEvasion = false;
        flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] = 0;
        if (newRound) {
            flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_0_ACTION] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_WILL_O_THE_WISP_ATTACKED] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_FLYING_SWORD_ATTACKED] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_EPIC_ELEMENTAL_ATTACKED] = 0;
			flags[kFLAGS.IN_COMBAT_PLAYER_MUMMY_ATTACKED] = 0;
			flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] = 0;
			if (player.hasPerk(PerkLib.FirstAttackSkeletons)) flags[kFLAGS.IN_COMBAT_PLAYER_SKELETONS_ATTACKED] = 0;
			if (player.hasPerk(PerkLib.MyBloodForBloodPuppies)) flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] = 0;
			if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 4) flags[kFLAGS.IN_COMBAT_PLAYER_USED_SHARK_BITE] = 0;
			if (player.armor == armors.BMARMOR) dynStats("lus", -(Math.round(player.maxLust() * 0.05)));
			if (player.hasStatusEffect(StatusEffects.TyrantState)) dynStats("lus", (Math.round(player.maxLust() * 0.05)));
			if (player.hasStatusEffect(StatusEffects.VampThirstStacksHPMana)) player.removeStatusEffect(StatusEffects.VampThirstStacksHPMana);
			if (player.hasStatusEffect(StatusEffects.TyrantState) && TyrantiaFollower.TyrantiaTrainingSessions >= 30) {
				if (!player.hasStatusEffect(StatusEffects.TyrantiaTraining30)) player.createStatusEffect(StatusEffects.TyrantiaTraining30, 0, 0, 0, 0);
				else player.addStatusValue(StatusEffects.TyrantiaTraining30, 1, 1);
			}
			if (player.hasStatusEffect(StatusEffects.TyrantiaTraining30) && player.lust < player.maxOverLust()) player.removeStatusEffect(StatusEffects.TyrantiaTraining30);
        }
        mainView.hideMenuButton(MainView.MENU_DATA);
        mainView.hideMenuButton(MainView.MENU_APPEARANCE);
        mainView.hideMenuButton(MainView.MENU_PERKS);
        hideUpDown();
        if (newRound) combatStatusesUpdate(); //Update Combat Statuses
        display();
        statScreenRefresh();
        if (combatIsOver()) return;
        ui.mainMenu();
        //Modify menus.
        if (SceneLib.urtaQuest.isUrta()) {
            addButton(0, "Attack", basemeleeattacks).hint("Attempt to attack the enemy with your [weapon].  Damage done is determined by your strength and weapon.");
            addButton(1, "P. Specials", SceneLib.urtaQuest.urtaSpecials).hint("Physical special attack menu.", "Physical Specials");
            addButton(2, "M. Specials", SceneLib.urtaQuest.urtaMSpecials).hint("Mental and supernatural special attack menu.", "Magical Specials");
            CombatAbilities.Tease.createButton(monster).applyTo(button(3));
            addButton(5, "Fantasize", fantasize).hint("Fantasize about your opponent in a sexual way.  Its probably a pretty bad idea to do this unless you want to end up getting raped.");
            addButton(6, "Wait", wait).hint("Take no action for this round.  Why would you do this?  This is a terrible idea.");
        }
        if (player.statusEffectv1(StatusEffects.ChanneledAttack) >= 1 && (isPlayerBound() || isPlayerSilenced() || isPlayerStunned() || isPlayerFeared())) {
            addButton(1, "Stop", stopChanneledSpecial);
        }
        if (monster.hasStatusEffect(StatusEffects.AttackDisabled)) {
            if (monster is Lethice) {
                outputText("\n<b>With Lethice up in the air, you've got no way to reach her with your attacks!</b>");
            } else {
                outputText("\n<b>Chained up as you are, you can't manage any real physical attacks!</b>");
            }
        }
        //Disabled physical attacks
        if (monster.hasStatusEffect(StatusEffects.PhysicalDisabled)) {
            outputText("<b>  Even physical special attacks are out of the question.</b>");
            removeButton(1); //Removes bow usage.
        }
    }
	
	public function disableEachHelperIfTheyCauseSoftLock():void {
		if (flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] != 0 && flags[kFLAGS.BLOOD_PUPPY_SUMMONS] > 0) flags[kFLAGS.BLOOD_PUPPY_SUMMONS] = 0;
		if (flags[kFLAGS.IN_COMBAT_PLAYER_EPIC_ELEMENTAL_ATTACKED] != 0 && flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] > 1) flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] = 1;
		if (flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] != 0 && flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] > 1) flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] = 1;
		if (flags[kFLAGS.IN_COMBAT_PLAYER_SKELETONS_ATTACKED] != 0 && flags[kFLAGS.NECROMANCER_SKELETONS] == 1) flags[kFLAGS.NECROMANCER_SKELETONS] = 0;
		if (flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] != 0 && flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1) flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] = 0;
		if (flags[kFLAGS.IN_COMBAT_PLAYER_FLYING_SWORD_ATTACKED] != 0 && flags[kFLAGS.FLYING_SWORD] == 1) flags[kFLAGS.FLYING_SWORD] = 0;
		if (flags[kFLAGS.IN_COMBAT_PLAYER_MUMMY_ATTACKED] != 0 && flags[kFLAGS.MUMMY_ATTACK] == 1) flags[kFLAGS.MUMMY_ATTACK] = 01;
		if (flags[kFLAGS.IN_COMBAT_PLAYER_WILL_O_THE_WISP_ATTACKED] != 0 && flags[kFLAGS.WILL_O_THE_WISP] == 0) flags[kFLAGS.WILL_O_THE_WISP] = 1;
	}

    internal function buildOtherActions(buttons:ButtonDataList, backFunc:Function, aspectButtons:ButtonDataList = null):void {
        var bd:ButtonData;
		buttons.add("Surrender(H)", combat.surrenderByHP, "Stop defending youself. You'll take a hell of a beating. Why would you do this?");
        buttons.add("Surrender(L)", combat.surrenderByLust, "Fantasize about your opponent in a sexual way so much it would fill up your lust. You'll end up getting raped...But is it rape if you get what you want?");
        buttons.add("Minions", CoC.instance.perkMenu.minionOptions, "You can adjust the behaviour of your minions during combat.");
        buttons.add("F.S. Opt", CoC.instance.perkMenu.flyingSwordBehaviourOptions, "You can adjust the behaviour of your flying sword during combat.");
        if ((player.calculateMultiAttacks() > 1) || (player.hasPerk(PerkLib.JobBeastWarrior) && (player.hasNaturalWeapons() || player.haveNaturalClawsTypeWeapon())) ||
            ((player.hasPerk(PerkLib.Berzerker) || (player.hasPerk(PerkLib.Lustzerker)) && player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 3)) || player.hasPerk(PerkLib.Poisoning) || player.hasPerk(PerkLib.SwiftCasting) || player.hasStatusEffect(StatusEffects.SoulDrill1) || player.hasStatusEffect(StatusEffects.ThePhalluspear1)) {
            buttons.add("Melee Opt", CoC.instance.perkMenu.meleeOptions, "You can adjust your melee attack settings.");
        }
        if (player.hasPerk(PerkLib.ELFTwinShot) || player.hasPerk(PerkLib.ElementalArrows) || player.hasPerk(PerkLib.Cupid) || player.hasPerk(PerkLib.EnvenomedBolt) || player.hasPerk(PerkLib.ELFThornShot) || player.calculateMultiAttacks(false) > 1) {
            buttons.add("Range Opt", CoC.instance.perkMenu.rangedOptions, "You can adjust your range strike settings.");
        }
        if (CoC_Settings.debugBuild && !debug) {
            buttons.add("Inspect", combat.debugInspect).hint("Use your debug powers to inspect your enemy.");
        }
        if (debug) {
            buttons.add("CheatAbility", combat.debugCheatAbility).hint("Use any ability");
            buttons.add("CheatStats", combat.debugCheatStats).hint("Adjust your or enemy stats. May break things!");
        }
        if (player.hasPerk(PerkLib.JobDefender)) {
            buttons.add("Defend", defendpose).hint("Take no offensive action for this round.  Are you that confident in your defensive stance?");
        }
        if (player.hasPerk(PerkLib.SecondWind) && !player.hasStatusEffect(StatusEffects.CooldownSecondWind)) {
            buttons.add("Second Wind", seconwindGo).hint("Enter your second wind, recovering from your wounds and fatigue once per battle.");
        }
        if (player.hasStatusEffect(StatusEffects.SoulDrill1)) {
            buttons.add("Soul Drill", soul1Drill).hint("Menu to adjust your Soul Drill spinning speed.");
        }
        if (player.hasStatusEffect(StatusEffects.ThePhalluspear1)) {
            buttons.add("ThePhalluspear", the1Phalluspear).hint("Menu to toggle The Phalluspear lust to normal damage ratio.");
        }
        if (CombatAbilities.FlyingSwordAttack.isKnown) {
            buttons.append(CombatAbilities.FlyingSwordAttack.createButton(monster));
        }
        if (!player.isFlying()) {
            if (player.canFly()) buttons.add("Take Flight", takeFlightWings)
                .hint("Make use of your wings or other options avilable to take flight into the air for up to 7 turns. \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.")
                .disableIf(player.hasStatusEffect(StatusEffects.FlyingDisabled), "You're being prevented from taking flight!");
			if (player.weaponFlyingSwordsName != "nothing" && player.canFlyOnFlyingSwords()) buttons.add("Take Flight", takeFlightByFlyingSword)
                .hint("Make use of your flying sword to take flight into the air. \n\nSoulforce cost per turn: "+flyingSwordUseCost()+" \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.")
                .disableIf(player.hasStatusEffect(StatusEffects.FlyingDisabled), "You're being prevented from taking flight!");
			if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) buttons.add("Take Flight", takeFlightNoWings)
                .hint("Use your own soulforce to take flight into the air. \n\nSoulforce cost per turn: "+flyingWithSoulforceCost()+" \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.")
                .disableIf(player.hasStatusEffect(StatusEffects.FlyingDisabled), "You're being prevented from taking flight!");
        }
		if (player.isFlying()) {
			if (player.statusEffectv2(StatusEffects.Flying) == 1) buttons.add("Land", landAfterUsingFlyingSword);
			if (player.statusEffectv2(StatusEffects.Flying) == 2) buttons.add("Land", landAfterUsingSoulforce);
            buttons.add("Great Dive", greatDive)
            .hint("Make a Great Dive to deal TONS of damage!")
            .disableIf(isEnemyInvisible, "You cannot use offensive skills against an opponent you cannot see or target.");
        }
        if (CombatAbilities.FlamesOfLove.isKnown) {
            buttons.append(CombatAbilities.FlamesOfLove.createButton(monster));
        }
        if (CombatAbilities.IciclesOfLove.isKnown) {
            buttons.append(CombatAbilities.IciclesOfLove.createButton(monster));
        }
		if (CombatAbilities.StormOfSisterhood.isKnown) {
            buttons.append(CombatAbilities.StormOfSisterhood.createButton(monster));
		}
		if (CombatAbilities.NightOfBrotherhood.isKnown) {
            buttons.append(CombatAbilities.NightOfBrotherhood.createButton(monster));
		}
        if (CombatAbilities.Devourer.isKnown) {
            buttons.append(CombatAbilities.Devourer.createButton(monster));
        }
		if ((monster.hasStatusEffect(StatusEffects.Stunned) || monster.hasStatusEffect(StatusEffects.StunnedTornado) || monster.hasStatusEffect(StatusEffects.Polymorphed) || monster.hasStatusEffect(StatusEffects.Sleep) || monster.hasStatusEffect(StatusEffects.Fascinated)) && (player.fatigueLeft() > combat.physicalCost(20)) && player.perkv1(IMutationsLib.HollowFangsIM) >= 2) {
			bd = buttons.add("Bite", VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
		}// || monster.hasStatusEffect(StatusEffects.InvisibleOrStealth)
		if (player.hasPerk(PerkLib.SwordIntentAura)) {
			if (player.statStore.hasBuff("SwordIntentAura")) {
				buttons.add("SwordIntentAD", deactivateSwordIntentAura).hint("Disperse sword intent aura.");
			} else {
				bd = buttons.add("SwordIntentAA", activateSwordIntentAura, "Coat your weapons with sword intent aura. (It would drain soulforce and fatigue until dispersed)\n");
				bd.requireSoulforce(10 * soulskillCost() * soulskillcostmulti());
				bd.requireFatigue(10);
			}
		}
		if (player.hasStatusEffect(StatusEffects.CombatFollowerZenji) && (player.statusEffectv3(StatusEffects.CombatFollowerZenji) == 1 || player.statusEffectv3(StatusEffects.CombatFollowerZenji) == 3)) {
			bd = buttons.add("Heal Zenji", HealZenji);
		}
		if (player.hasPerk(PerkLib.JobGolemancer) && (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] > 0 || flags[kFLAGS.PERMANENT_GOLEMS_BAG] > 0 || flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] > 0 || flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] > 0 || flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] > 0)) bd = buttons.add("Golems", GolemsMenu);
		if (player.hasPerk(PerkLib.JobElementalConjurer) && player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) {
            var buttonFunc:Function;
            if (aspectButtons != null) {
                buttonFunc = curry(submenu, aspectButtons, backFunc);
            }
            else {
                buttonFunc = ElementalAspectsMenu
            }
            bd = buttons.add("Elem.Asp", buttonFunc, "Use the once-per-battle elemental aspects of your basic elementals.", "Elemental Aspects");
        }
		if (player.shieldName == "Ancient Conduit") bd = buttons.add("A.Conduit", AncientConduitMenu);
		if (player.hasPerk(PerkLib.PrestigeJobNecromancer) && player.perkv2(PerkLib.PrestigeJobNecromancer) > 0) {
			bd = buttons.add("S.S. to F.", sendSkeletonToFight).hint("Send Skeleton to fight - Order your Skeletons to beat the crap out of your foe.");
			if (monster.isFlying() && (!player.hasPerk(PerkLib.GreaterHarvest) || (player.perkv1(PerkLib.GreaterHarvest) == 0 && player.perkv2(PerkLib.GreaterHarvest) == 0))) {
				bd.disable("None of your skeletons can attack airborn enemies.");
			}
			if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 5) {
				bd = buttons.add("S.S.", skeletonSmash).hint("Skeleton Smash - Order your Skeletons to go all out on your foe.");
				if (monster.isFlying()) {
					bd.disable("None of your skeletons can attack airborn enemies.");
				}
			}
		}
		if (player.hasPerk(PerkLib.HiddenJobAsura)) {
			if (player.statStore.hasBuff("AsuraForm")) {
				bd = buttons.add("Return", returnToNormalShape).hint("Return to normal from Asura form.");
				bd = buttons.add("Asura's Howl", asurasHowl).hint("Unleash a howl before giving enemy good punching. \n\nWrath Cost: 100");
				if (player.wrath < 100) {
					bd.disable("Your wrath is too low to unleash your howl!");
				}
				if (player.hasPerk(PerkLib.AbsoluteStrength)) {
					if (player.hasPerk(PerkLib.ItsZerkingTime)) bd = buttons.add("TwFoD", asuras12FingersOfDestruction).hint("Twelve Fingers of Destruction - Poke your enemies Asura Style. \n\nWrath Cost: 50% of max Wrath");
					else if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) bd = buttons.add("TFoD", asuras10FingersOfDestruction).hint("Ten Fingers of Destruction - Poke your enemies Asura Style. \n\nWrath Cost: 50% of max Wrath");
					else if (player.hasPerk(PerkLib.AsuraStrength)) bd = buttons.add("EFoD", asuras8FingersOfDestruction).hint("Eight Fingers of Destruction - Poke your enemies Asura Style. \n\nWrath Cost: 50% of max Wrath");
					else bd = buttons.add("SFoD", asuras6FingersOfDestruction).hint("Six Fingers of Destruction - Poke your enemies Asura Style. \n\nWrath Cost: 50% of max Wrath");
					if (player.wrath < (player.maxWrath() * 0.5)) {
						bd.disable("Your wrath is too low to poke your enemies Asura Style!");
					}
				}
				if (player.hasPerk(PerkLib.AsuraStrength)) {
				
				}
				if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) {
				
				}
			} else {
				bd = buttons.add("Asura Form", assumeAsuraForm).hint("Let your wrath flow thou you, transforming you into Asura! \n\nWrath Cost: " + asuraformCost() + " per turn");
				if (player.wrath < asuraformCost()) {
					bd.disable("Your wrath is too low to enter this state!");
				}
				if (player.statStore.hasBuff("CrinosShape")) {// && !player.hasPerk(PerkLib.HiddenJobAsura)
					bd.disable("You are under transformantion effect incompatibile with Asura Form!");
				}
			}
		}
		if (player.hasPerk(PerkLib.JobWarrior)) {
			bd = buttons.add("WarriorRage", mspecials.warriorsrage).hint("Throw yourself into a warrior's rage!  Greatly increases your strength, speed and fortitude! \n", "Warrior's Rage");
			bd.requireWrath(50);
			if(player.statStore.hasBuff("WarriorsRage")) {
				bd.disable("You're already raging!");
			}
		}
		if (player.hasPerk(PerkLib.Berzerker)) {
			bd = buttons.add("Berserk", mspecials.berzerk);
			if (player.hasPerk(PerkLib.ColderFury)) {
				bd.hint("Throw yourself into a cold(er) rage!  Greatly increases the strength of your attacks and increases lust resistance. \n");
			} else if (player.hasPerk(PerkLib.ColdFury)) {
				bd.hint("Throw yourself into a cold rage!  Greatly increases the strength of your attacks and increases lust resistance, but your magical resistance is reduced to zero! \n");
			} else {
				bd.hint("Throw yourself into a rage!  Greatly increases the strength of your attacks and increases lust resistance, but your defense and magical resistance are reduced to zero! \n");
			}
			bd.requireWrath(50);
			if (player.hasStatusEffect(StatusEffects.Berzerking)) {
				bd.disable("You're already pretty goddamn mad!");
			}
		}
		if (player.hasPerk(PerkLib.Anger) && player.hasStatusEffect(StatusEffects.Berzerking)) {
			bd = buttons.add("Berserk G2", mspecials.berzerkG2);
			if (player.statusEffectv2(StatusEffects.Berzerking) >= 1) {
				bd.disable("You're already reached 2nd grade of Berserk!");
			}
			if (player.statusEffectv2(StatusEffects.Berzerking) >= 1) {
				bd = buttons.add("Berserk G3", mspecials.berzerkG3);
				if (player.statusEffectv2(StatusEffects.Berzerking) >= 2) {
					bd.disable("You're already reached 3rd grade of Berserk!");
				}
			}
			if (player.hasPerk(PerkLib.EndlessRage) && player.statusEffectv2(StatusEffects.Berzerking) >= 2) {
				bd = buttons.add("Berserk G4", mspecials.berzerkG4);
				if (player.statusEffectv2(StatusEffects.Berzerking) >= 3) {
					bd.disable("You're already reached 4th grade of Berserk!");
				}
			}
		}
		if (player.hasPerk(PerkLib.Lustzerker) || player.countRings(jewelries.FLLIRNG)) {
			bd = buttons.add("Lustserk", mspecials.lustzerk);
			if (player.hasPerk(PerkLib.ColderLust)) {
				bd.hint("Throw yourself into a cold(er) lust rage!  Greatly increases the strength of your attacks and increases armor defense. \n");
			} else if (player.hasPerk(PerkLib.ColdLust)) {
				bd.hint("Throw yourself into a cold lust rage!  Greatly increases the strength of your attacks and increases physical defense, but your magical resistance is reduced to zero! \n");
			} else {
				bd.hint("Throw yourself into a lust rage!  Greatly increases the strength of your attacks and increases physical defense, but your lust and magical resistances are reduced to zero! \n")
			}
			bd.requireWrath(50);
			if (player.hasStatusEffect(StatusEffects.Lustzerking)) {
				bd.disable("You're already raging, anger and lust combined!");
			}
		}
		if (player.hasPerk(PerkLib.Anger) && player.hasStatusEffect(StatusEffects.Lustzerking)) {
			bd = buttons.add("Lustserk G2", mspecials.lustzerkG2);
			if (player.statusEffectv2(StatusEffects.Lustzerking) >= 1) {
				bd.disable("You're already reached 2nd grade of Lustserk!");
			}
			if (player.statusEffectv2(StatusEffects.Lustzerking) >= 1) {
				bd = buttons.add("Lustserk G3", mspecials.lustzerkG3);
				if (player.statusEffectv2(StatusEffects.Lustzerking) >= 2) {
					bd.disable("You're already reached 3rd grade of Lustserk!");
				}
			}
			if (player.hasPerk(PerkLib.EndlessRage) && player.statusEffectv2(StatusEffects.Lustzerking) >= 2) {
				bd = buttons.add("Lustserk G4", mspecials.lustzerkG4);
				if (player.statusEffectv2(StatusEffects.Lustzerking) >= 3) {
					bd.disable("You're already reached 4th grade of Lustserk!");
				}
			}
		}
		if (player.hasPerk(PerkLib.JobBeastWarrior) || player.necklaceName == "Crinos Shape necklace") {
			if (player.statStore.hasBuff("CrinosShape")) {
				buttons.add("Return", mspecials.returnToNormalShape).hint("Return to normal from Crinos Shape.");
			} else {
				bd = buttons.add("CrinosShape", mspecials.assumeCrinosShape).hint("Let your wrath flow through you, transforming you into a bestial shape!  Greatly increases your strength, speed and fortitude! \n\nWrath Cost: " + mspecials.crinosshapeCost() + " per turn");
				if (player.wrath < mspecials.crinosshapeCost()) {
					bd.disable("Your wrath is too low to enter this state!");
				}
				if (player.statStore.hasBuff("AsuraForm")) {// && !player.hasPerk(PerkLib.HiddenJobAsura)
					bd.disable("You are under transformantion effect incompatibile with Crinos Shape!");
				}
			}
		}
		if (player.racialScore(Races.ONI, false) >= mspecials.minOniScoreReq()) {
			bd = buttons.add("Oni Rampage", mspecials.startOniRampage).hint("Increase all damage done by a massive amount but silences you. While this is active, you cannot use spells or magical oriented soulskills.");
			bd.requireFatigue(spellCost(50));
			if(player.hasStatusEffect(StatusEffects.OniRampage)) {
				bd.disable("You're already rampaging!");
			}
		}
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll1)) {
			if (player.statStore.hasBuff("NoLimiterState")) bd = buttons.add("No Limiter", returnToNormalState).hint("Toggle off No Limiter.");
			else bd = buttons.add("No Limiter", noLimiterState).hint("Toggle on No Limiter. (STR+++, ?Lib-?)");
		}
		if (player.hasPerk(PerkLib.ElementalBody)) {
            for each (var fusionAbility:CombatAbility in CombatAbilities.ALL_ELEMENTAL_FUSION_ATTACKS) {
                if (fusionAbility.isKnown) {
                    buttons.append(fusionAbility.createButton(monster));
                }
            }
		}
    }
	public function GolemsMenu(page:int = 1):void {
		menu();
		if (page == 1) {
			if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] > 0) {
				if (monster.isFlying() && !player.hasPerk(PerkLib.ExpertGolemMaker)) {
					addButtonDisabled(0, "Send T.Gol/1", "Your golems can't attack flying targets. (Only golems made by an expert golem maker can do this!)");
					if (monster.plural) {
						addButtonDisabled(1, "Send T.Gol/3", "Your golems can't attack flying targets. (Only golems made by an expert golem maker can do this!)");
						addButtonDisabled(2, "Send T.Gol/5", "Your golems can't attack flying targets. (Only golems made by an expert golem maker can do this!)");
					}
					if (player.hasPerk(PerkLib.TemporalGolemsRestructurationEx)) addButtonDisabled(3, "KamikazeProtocol", "Your golems can't attack flying targets. (Only golems made by an expert golem maker can do this)");
				}
				else {
					addButton(0, "Send T.Gol/1", combat.pspecials.sendTemporalGolem1)
						.hint("Send one golem from your bag to attack the enemy. <b>After attacking, the golem will fall apart"+(player.hasPerk(PerkLib.MasterGolemMaker)?"":" and its core can shatter, leaving it unable to be reused in future")+"!</b>");
					if (player.hasPerk(PerkLib.TemporalGolemsRestructuration)) {
						if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] >= 4) addButton(5, "Send T.Gol/4", combat.pspecials.sendTemporalGolem4)
							.hint("Send four golems from your bag to attack the enemy. <b>After attacking, the golems will fall apart!</b>");
						if (monster.plural) {
							if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] >= 10) addButton(6, "Send T.Gol/10", combat.pspecials.sendTemporalGolem10)
								.hint("Send ten golems from your bag to attack the enemy. <b>After attacking, the golems will fall apart!</b>");
							if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] >= 20) addButton(7, "Send T.Gol/20", combat.pspecials.sendTemporalGolem20)
								.hint("Send twenty golems from your bag to attack the enemy. <b>After attacking, the golems will fall apart!</b>");
						}
					}
					if (monster.plural) {
						if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] >= 3) addButton(1, "Send T.Gol/3", combat.pspecials.sendTemporalGolem3)
							.hint("Send three golems from your bag to attack the enemy. <b>After attacking, the golems will fall apart"+(player.hasPerk(PerkLib.MasterGolemMaker)?"":" and their cores can shatter, leaving them unable to be reused in future")+"!</b>");
						if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] >= 5) addButton(2, "Send T.Gol/5", combat.pspecials.sendTemporalGolem5)
							.hint("Send five golems from your bag to attack the enemy. <b>After attacking, the golems will fall apart"+(player.hasPerk(PerkLib.MasterGolemMaker)?"":" and their cores can shatter, leaving them unable to be reused in future")+"!</b>");
					}
					if (player.hasPerk(PerkLib.TemporalGolemsRestructurationEx)) addButton(4, "KamikazeProtocol", combat.pspecials.sendTemporalGolemKamikazeProtocol)
						.hint("Send all temporal golems from your bag to attack the enemy. <b>After attacking, the golems will fall apart!</b>");
				}
			}
			if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] > 0) {
				if (monster.isFlying() && !player.hasPerk(PerkLib.GrandMasterGolemMaker)) {
					addButtonDisabled(10, "Send P.Gol/1", "Your golems can't attack flying targets. (Only golems made by a grand-master golem maker can do this!)");
					if (monster.plural) {
						addButtonDisabled(11, "Send P.Gol/3", "Your golems can't attack flying targets. (Only golems made by a grand-master golem maker can do this!)");
						addButtonDisabled(12, "Send P.Gol/5", "Your golems can't attack flying targets. (Only golems made by a grand-master golem maker can do this!)");
					}
				}
				else {
					addButton(10, "Send P.Gol/1", combat.pspecials.sendPermanentGolem, 1, true)
						.hint("Send one stone golem from your bag to attack the enemy.");
					if (monster.plural) {
						if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] >= 3) addButton(11, "Send P.Gol/3", combat.pspecials.sendPermanentGolem, 3, true)
							.hint("Send three stone golems from your bag to attack the enemy.");
						if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] >= 5) addButton(12, "Send P.Gol/5", combat.pspecials.sendPermanentGolem, 5, true)
							.hint("Send five stone golems from your bag to attack the enemy.");
					}
				}
			}
			if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] > 0 || flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] > 0 || flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] > 0) addButton(9, "-2-", GolemsMenu, page + 1);
			addButton(14, "Back", combat.combatMenu, false);
		}
		if (page == 2) {
			if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] > 0) {
				addButton(0, "Send I.P.Gol/1", combat.pspecials.sendPermanentImprovedGolem, 1, true)
					.hint("Send one improved stone golem from your bag to attack the enemy.");
				if (monster.plural) {
					if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] >= 3) addButton(1, "Send I.P.Gol/3", combat.pspecials.sendPermanentImprovedGolem, 3, true)
						.hint("Send three improved stone golems from your bag to attack the enemy.");
					if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] >= 5) addButton(2, "Send I.P.Gol/5", combat.pspecials.sendPermanentImprovedGolem, 5, true)
						.hint("Send five improved stone golems from your bag to attack the enemy.");
				}
			}
			if (flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] > 0) {
				addButton(5, "Send S.Gol/1", combat.pspecials.sendPermanentSteelGolem, 1, true)
					.hint("Send one steel golem from your bag to attack the enemy.");
				if (monster.plural) {
					if (flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] >= 3) addButton(6, "Send S.Gol/3", combat.pspecials.sendPermanentSteelGolem, 3, true)
						.hint("Send three steel golems from your bag to attack the enemy.");
					if (flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] >= 5) addButton(7, "Send S.Gol/5", combat.pspecials.sendPermanentSteelGolem, 5, true)
						.hint("Send five steel golems from your bag to attack the enemy.");
				}
			}
			if (flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] > 0) {
				addButton(10, "Send S.Gol/1", combat.pspecials.sendPermanentImprovedSteelGolem, 1, true)
					.hint("Send one improved steel golem from your bag to attack the enemy.");
				if (monster.plural) {
					if (flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] >= 3) addButton(11, "Send I.S.Gol/3", combat.pspecials.sendPermanentImprovedSteelGolem, 3, true)
						.hint("Send three improved steel golems from your bag to attack the enemy.");
					if (flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] >= 5) addButton(12, "Send I.S.Gol/5", combat.pspecials.sendPermanentImprovedSteelGolem, 5, true)
						.hint("Send five improved steel golems from your bag to attack the enemy.");
				}
			}
			addButton(9, "-1-", GolemsMenu, page - 1);
			addButton(14, "Back", combat.combatMenu, false);
		}
	}
	public function ElementalAspectsMenu():void {
		menu();
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectAir)) addButtonDisabled(0, "Air E.Asp", "You've already used the air elemental aspect in this fight!");
			else addButton(0, "Air E.Asp", combat.mspecials.ElementalAspectAir)
            .hint("Creates a Wind Wall that deflects incoming projectiles for few turns.\n\nDuration depends on elemental rank.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectEarth)) addButtonDisabled(1, "Earth E.Asp", "You've already used the earth elemental aspect in this fight!");
			else addButton(1, "Earth E.Asp", combat.mspecials.ElementalAspectEarth)
            .hint("Creates an Earth armor around PC, increasing armor and magic resistance for a few turns.\n\nDuration depends on elemental rank.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectFire)) addButtonDisabled(2, "Fire E.Asp", "You've already used the fire elemental aspect in this fight!");
			else addButton(2, "Fire E.Asp", combat.mspecials.ElementalAspectFire)
            .hint("Stronger version of fire attributed attack.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectWater)) addButtonDisabled(3, "Water E.Asp", "You've already used the water elemental aspect in this fight!");
			else addButton(3, "Water E.Asp", combat.mspecials.ElementalAspectWater)
            .hint("Heals PC.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectEther)) addButtonDisabled(4, "Ether E.Asp", "You've already used the ether elemental aspect in this fight!");
			else addButton(4, "Ether E.Asp", combat.mspecials.ElementalAspectEther)
            .hint("Deals increased damage as a bonus to enemy if enemy is weak to any of the four major elements.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectWood)) addButtonDisabled(5, "Wood E.Asp", "You've already used the wood elemental aspect in this fight!");
			else addButton(5, "Wood E.Asp", combat.mspecials.ElementalAspectWood)
            .hint("PC (Minor) Healing and small increase to armor / magic resistance for a few turns.\n\nDuration depends on elemental rank.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectMetal)) addButtonDisabled(6, "Metal E.Asp", "You've already used the metal elemental aspect in this fight!");
			else addButton(6, "Metal E.Asp", combat.mspecials.ElementalAspectMetal)
            .hint("Increases PC unarmed damage for a few turns.\n\nDuration depends on elemental rank.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectIce)) addButtonDisabled(7, "Ice E.Asp", "You've already used the ice elemental aspect in this fight!");
			else addButton(7, "Ice E.Asp", combat.mspecials.ElementalAspectIce)
            .hint("Stronger version of ice attributed attack.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectLightning)) addButtonDisabled(8, "Lightning E.Asp", "You've already used the lightning elemental aspect in this fight!");
			else addButton(8, "Lightning E.Asp", combat.mspecials.ElementalAspectLightning)
            .hint("Stronger version of lightning attributed attack.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectDarkness)) addButtonDisabled(9, "Darkness E.Asp", "You've already used the darkness elemental aspect in this fight!");
			else addButton(9, "Darkness E.Asp", combat.mspecials.ElementalAspectDarkness)
            .hint("Stronger version of darkness attributed attack.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsPoison)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectPoison)) addButtonDisabled(10, "Poison E.Asp", "You've already used the poison elemental aspect in this fight!");
			else addButton(10, "Poison E.Asp", combat.mspecials.ElementalAspectPoison)
            .hint("Stronger version of poison attributed attack.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsPurity)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectPurity)) addButtonDisabled(11, "Purity E.Asp", "You've already used the purity elemental aspect in this fight!");
			else addButton(11, "Purity E.Asp", combat.mspecials.ElementalAspectPurity)
            .hint("Stronger version of purity attributed attack.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsCorruption)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectCorruption)) addButtonDisabled(12, "Corruption E.Asp", "You've already used the corruption elemental aspect in this fight!");
			else addButton(12, "Corruption E.Asp", combat.mspecials.ElementalAspectCorruption)
            .hint("Stronger version of corruption attributed attack.");
		}
		//?lust?
		addButton(14, "Back", combat.combatMenu, false);
	}
	public function AncientConduitMenu(page:int = 1):void {
		menu();
		if (page == 1) {
			
			addButton(9, "-2-", AncientConduitMenu, page + 1);
			addButton(14, "Back", combat.combatMenu, false);
		}
		if (page == 2) {
			
			addButton(9, "-1-", AncientConduitMenu, page - 1);
			addButton(14, "Back", combat.combatMenu, false);
		}
	}
	
    public function calcHerbalismPower():Number{
        var power:Number = 0;
        power += scalingBonusWisdom();
        if (player.hasPerk(PerkLib.PlantKnowledge)) power += scalingBonusLibido();
        power += player.herbalismLevel*10;
        power = Math.round(power);
        return power;
    }
	public function Poultice():void {
        clearOutput();
        var power:Number = calcHerbalismPower();
        power += (player.maxOverHP()*0.2);
        if (player.hasPerk(PerkLib.NaturalHerbalism)) power *= 2;
        Math.round(power);
		if (player.hasStatusEffect(StatusEffects.CombatWounds)) {
			if (player.statusEffectv1(StatusEffects.CombatWounds) > 0.04) player.addStatusValue(StatusEffects.CombatWounds, 1, -0.04);
			else player.removeStatusEffect(StatusEffects.CombatWounds);
		}
        HPChange(power,false);
        outputText("You apply the poultice, your wounds closing at high speed. Healed for ");
        CommasForDigits(power*-1);
    }
    public function EnergyDrink():void {
        clearOutput();
        var power:Number = calcHerbalismPower()*5;
        fatigue(-power);
        player.mana += power;
        player.soulforce += power;
        outputText("You chug your energy drink, and as you toss the container aside, you feel your body loosen, your mind fizzing with sudden mana. Your soul feels much better, power whirling through you. Recovered "+power+" ressources.");
    }
    public function Cure():void {
        clearOutput();
		for each (var buff:String in CurableBuffs) player.buff(buff).remove();
		for each (var type:StatusEffectType in CurableEffects) player.removeStatusEffect(type);
		if (player.statStore.hasBuff("Weakened") || player.statStore.hasBuff("Drained")) {
			for each (var stat:String in ["str","spe","tou","int","wis","lib","sens"]) {
				player.removeCurse(stat, 6,1);
				player.removeCurse(stat, 3,2);
				if (stat != "sens") {
					player.removeCurse(stat+".mult", 0.06,1);
					player.removeCurse(stat+".mult", 0.03,2);
				}
			}
		}
        outputText("You drink up the cure, feeling relieved as your status ailments are cleansed.");
    }
	private const CurableBuffs:/*String*/Array = [
		"LightningArrowStr",
		"LightningArrowSpe",
		"FireArrow",
		"IceArrow",
		"Illusion",
		"Fear",
		"CombatDebuffStr",
		"CombatDebuffSpe",
		"BasiliskGaze",
		"LightningArrow",
		"AkbalDebuff",
		"FrostGiantDebuff",
		"GnollSpearThrowerDebuff",
		"YoungFrostGiantDebuff",
		"PoisonedArrow",
		"MalikoreVenom",
		"ManticoreVenom",
		"Nightmare",
		"Entwine",
		"Poison"
	];
	private const CurableEffects:/*StatusEffectType*/Array = [
		StatusEffects.BurnDoT,
		StatusEffects.AcidSlap,
		StatusEffects.DriderKiss,
		StatusEffects.AikoLightningArrow,
		StatusEffects.NagaVenom,
		StatusEffects.MedusaVenom,
		StatusEffects.DriderIncubusVenom,
		StatusEffects.Poison,
		StatusEffects.AcidDoT,
		StatusEffects.FrostburnDoT,
		StatusEffects.FrozenLung,
	];
    public function Ginseng():void {
        clearOutput();
        var power:Number = (calcHerbalismPower()*0.05)+10; //needs to be calculated in game
        var duration:Number = Math.round(power/100)+5;
        //strength then Duration in hours
        player.createStatusEffect(StatusEffects.TeasePotion,power,duration,0,0);
        outputText("You eat the ginseng and gulp it down. Your breath will now smells like ginseng for a while wich should increase your appeal. "+power+" "+duration+"");
    }
    public function Painkiller():void {
        clearOutput();
        var power:Number = (calcHerbalismPower()*0.05)+10; //needs to be calculated in game
        var duration:Number = Math.round(power/100)+5;
        //strength then Duration in hours
        player.createStatusEffect(StatusEffects.ArmorPotion,power,duration,0,0);
        outputText("You drink up the medicine, feeling any lingering pain recede as your skin hardens like stone. "+power+" "+duration+"");
    }
    public function Stimulant():void {
        clearOutput();
        var power:Number = (calcHerbalismPower()*0.05)+10; //needs to be calculated in game
        var duration:Number = Math.round(power/100)+5;
        //strength then Duration in hours
        player.createStatusEffect(StatusEffects.AttackPotion,power,duration,0,0);
        outputText("You drink up the medicine, feeling stronger and more agile already. "+power+" "+duration+"");
    }
    public function Perfume():void {
        clearOutput();
        var power:Number = (calcHerbalismPower()*0.05)+10; //needs to be calculated in game
        var duration:Number = Math.round(power/100)+5;
        //strength then Duration in hours
        if (!player.isAlraune()){
            outputText("You grab your bottle of Alraune perfume and spray yourself knowingly. Your opponent is going to have issues resisting your charms now. "+power+" "+duration+"");
            player.createStatusEffect(StatusEffects.ArousalPotion,power,duration,0,0);
        }
        else {
            outputText("You grab your bottle of Alraune perfume and almost spray yourself before remembering that you actualy already produce your own perfume, heck you are bathing into it! You slap yourself before puting back the item in your bag... what a dummy.");
            //player.changeNumberOfPotions(PotionType.PERFUME, +1);
        }
    }

    public function soul1Drill():void {
        menu();
        if (player.statusEffectv1(StatusEffects.SoulDrill1) != 0) addButton(0, "0", soul1Drill00);
        if (player.statusEffectv1(StatusEffects.SoulDrill1) != 1) addButton(1, "1", soul1Drill01).hint("Req. 10 SF per turn.");
        if (player.statusEffectv1(StatusEffects.SoulDrill1) != 2) {
            if (player.level < 36) addButtonDisabled(5, "2", "Your soul(current level) is too weak(low) to use this drill setting.");
            else addButton(5, "2", soul1Drill02).hint("Req. 25 SF per turn.");
        }
        if (player.statusEffectv1(StatusEffects.SoulDrill1) != 3) {
            if (player.level < 54) addButtonDisabled(6, "3", "Your soul(current level) is too weak(low) to use this drill setting.");
            else addButton(6, "3", soul1Drill03).hint("Req. 45 SF per turn.");
        }
        if (player.statusEffectv1(StatusEffects.SoulDrill1) != 4) {
            if (player.level < 72) addButtonDisabled(10, "4", "Your soul(current level) is too weak(low) to use this drill setting.");
            else addButton(10, "4", soul1Drill04).hint("Req. 70 SF per turn.");
        }
        if (player.statusEffectv1(StatusEffects.SoulDrill1) != 5) {
            if (player.level < 90) addButtonDisabled(11, "5", "Your soul(current level) is too weak(low) to use this drill setting.");
            else addButton(11, "5", soul1Drill05).hint("Req. 100 SF per turn.");
        }
        addButton(14, "Back", combat.combatMenu, false);
    }
    public function soul1Drill00():void {
        player.removeStatusEffect(StatusEffects.SoulDrill1);
        player.createStatusEffect(StatusEffects.SoulDrill1, 0, 0, 0, 0);
        doNext(soul1Drill);
    }
    public function soul1Drill01():void {
        player.removeStatusEffect(StatusEffects.SoulDrill1);
        player.createStatusEffect(StatusEffects.SoulDrill1, 1, 0, 0, 0);
        doNext(soul1Drill);
    }
    public function soul1Drill02():void {
        player.removeStatusEffect(StatusEffects.SoulDrill1);
        player.createStatusEffect(StatusEffects.SoulDrill1, 2, 0, 0, 0);
        doNext(soul1Drill);
    }
    public function soul1Drill03():void {
        player.removeStatusEffect(StatusEffects.SoulDrill1);
        player.createStatusEffect(StatusEffects.SoulDrill1, 3, 0, 0, 0);
        doNext(soul1Drill);
    }
    public function soul1Drill04():void {
        player.removeStatusEffect(StatusEffects.SoulDrill1);
        player.createStatusEffect(StatusEffects.SoulDrill1, 4, 0, 0, 0);
        doNext(soul1Drill);
    }
    public function soul1Drill05():void {
        player.removeStatusEffect(StatusEffects.SoulDrill1);
        player.createStatusEffect(StatusEffects.SoulDrill1, 5, 0, 0, 0);
        doNext(soul1Drill);
    }
	
	public function the1Phalluspear():void {
		menu();
		if (player.statusEffectv1(StatusEffects.ThePhalluspear1) != 0) addButton(0, "25%", the1Phalluspear00).hint("Deal 25% dmg as lust damage.");
		else addButtonDisabled(0, "25%", "Phalluspear deal currently 25% of dmg as lust dmg.");
        if (player.statusEffectv1(StatusEffects.ThePhalluspear1) != 1) addButton(1, "100%", the1Phalluspear01).hint("Deal 100% dmg as lust damage.");
		else addButtonDisabled(1, "100%", "Phalluspear deal currently 100% of dmg as lust dmg.");
		addButton(14, "Back", combat.combatMenu, false);
	}
    public function the1Phalluspear00():void {
        player.addStatusValue(StatusEffects.ThePhalluspear1, 1, -1);
        doNext(the1Phalluspear);
    }
    public function the1Phalluspear01():void {
       player.addStatusValue(StatusEffects.ThePhalluspear1, 1, 1);
       doNext(the1Phalluspear);
    }

    internal function teaseAttack():void {
        CombatAbilities.Tease.perform();
    }

    public function stopChanneledSpecial():void {
        clearOutput();
        if (player.statusEffectv1(StatusEffects.ChanneledAttackType) == 8) {
			if (isPlayerBound() || isPlayerSilenced() || isPlayerStunned() || isPlayerFeared()) outputText("Your maw goes off without warning or aim causing it to go wide.");
			else outputText("You cease charging your mouth in favor of retaining mobility.");
		}
        else outputText("You decided to stop preparing your super ultra hyper mega fabulous attack!");
        outputText("\n\n");
        for each (var perkObj:Object in CombatMagic.magicCounterPerks) {
            if ((player.hasPerk(perkObj.tier3) || player.hasPerk(perkObj.tier4)) && player.hasStatusEffect(perkObj.counter)) player.addStatusValue(perkObj.counter, 3, -1);
        }
		player.removeStatusEffect(StatusEffects.ChanneledAttack);
        player.removeStatusEffect(StatusEffects.ChanneledAttackType);
        combatRoundOver();
    }

    /**
     * Prep melee attack
     * check multi-attack style
     * Go to attack func for melee logic
     */
    public function basemeleeattacks():void {
        if (player.hasStatusEffect(StatusEffects.TaintedMind)) {
            if (monster as DriderIncubus) taintedMindAttackAttempt();
            return;
        }
        clearOutput();
        if (SceneLib.urtaQuest.isUrta()) {
            flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
        }
        var dualWeapon:Boolean = false;
        if (player.weapon.isDual()){
            dualWeapon = true;
        }
        if (flags[kFLAGS.MULTIATTACK_STYLE] >= 0) {
            flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = Math.min(maxCurrentAttacks(), (flags[kFLAGS.MULTIATTACK_STYLE] || 0) + 1);
            if (player.statusEffectv1(StatusEffects.CounterAction) > 0)
                flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += player.statusEffectv1(StatusEffects.CounterAction);
            if (player.weapon.isLarge() || player.weapon.isMassive()) {
                if( player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking) ){
                    if (player.hasPerk(PerkLib.FuelForTheFire)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 1;
                    if (player.hasPerk(PerkLib.Anger) && (player.statusEffectv2(StatusEffects.Berzerking) >= 1 || player.statusEffectv2(StatusEffects.Lustzerking) >= 1)) {
                        if (player.statusEffectv2(StatusEffects.Berzerking) >= 3 || player.statusEffectv2(StatusEffects.Lustzerking) >= 3) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 3;
                        else if (player.statusEffectv2(StatusEffects.Berzerking) >= 2 || player.statusEffectv2(StatusEffects.Lustzerking) >= 2) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 2;
                        else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 1;
                    }
                }
            }
            if (player.hasStatusEffect(StatusEffects.BladeDance) || dualWeapon) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 2;
            if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 1 && player.hasPerk(PerkLib.SteelStorm) && !player.hasStatusEffect(StatusEffects.CounterAction) && (dualWeapon || player.weapon == weapons.DAISHO)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 2;
        }
        else {
            flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
        }
        attack();
    }

    //Calls actions for wisp and henchmen, no 'Next' buttons or choices.
    //Can be used independently of PC
    public function simplifiedPrePCTurn_smart():void {
        if (ui.isWispTurn()) {
            CombatAbilities.WillOfTheWisp.perform();
            flags[kFLAGS.IN_COMBAT_PLAYER_WILL_O_THE_WISP_ATTACKED] = 1;
        }
        if (ui.isMummyTurn())
            ui.doMummyTurn();
        if (ui.isFlyingSwordTurn())
            ui.doFlyingSwordTurn();
        for (var ci:int = 0; ci <= 3; ++ci)
            if (ui.isCompanionTurn(ci))
                ui.doCompanionTurn(ci, false);
        flushOutputTextToGUI();
    }

    //Calls actions for golems and elementals, no 'Next' buttons or choices.
    //Requires PC to not be stunned or channel anything
    public function simplifiedPrePCTurn_stupid():void {
        if (ui.isGolemTurn()) {
            //array of possible golems. Sorted ascending by power.
            // [Function, mana cost, requirements]
            var golemArray:Array = [
                [curry(pspecials.sendPermanentGolem, 1)              , pspecials.permanentgolemsendcost()                 , true],
                [curry(pspecials.sendPermanentGolem, 3)              , pspecials.permanentgolemsendcost() * 3             , monster.plural && flags[kFLAGS.PERMANENT_GOLEMS_BAG] >= 3],
                [curry(pspecials.sendPermanentGolem, 5)              , pspecials.permanentgolemsendcost() * 5             , monster.plural && flags[kFLAGS.PERMANENT_GOLEMS_BAG] >= 5],
                [curry(pspecials.sendPermanentSteelGolem, 1)         , pspecials.permanentsteelgolemsendcost()            , flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] > 0],
                [curry(pspecials.sendPermanentSteelGolem, 3)         , pspecials.permanentsteelgolemsendcost() * 3        , monster.plural && flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] >= 3],
                [curry(pspecials.sendPermanentSteelGolem, 5)         , pspecials.permanentsteelgolemsendcost() * 5        , monster.plural && flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] >= 5],
                [curry(pspecials.sendPermanentImprovedGolem, 1)      , pspecials.permanentimprovedgolemsendcost()         , flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] > 0],
                [curry(pspecials.sendPermanentImprovedGolem, 3)      , pspecials.permanentimprovedgolemsendcost() * 3     , monster.plural && flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] >= 3],
                [curry(pspecials.sendPermanentImprovedGolem, 5)      , pspecials.permanentimprovedgolemsendcost() * 5     , monster.plural && flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] >= 5],
                [curry(pspecials.sendPermanentImprovedSteelGolem, 1) , pspecials.permanentimprovedsteelgolemsendcost()    , flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] > 0],
                [curry(pspecials.sendPermanentImprovedSteelGolem, 3) , pspecials.permanentimprovedsteelgolemsendcost() * 3, monster.plural && flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] >= 3],
                [curry(pspecials.sendPermanentImprovedSteelGolem, 5) , pspecials.permanentimprovedsteelgolemsendcost() * 5, monster.plural && flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] >= 5]
                //new powerful golems go here.
            ];
            var bestGolem:Array = null;
            for each (var golem:Array in golemArray)
                if (golem[2] && player.mana >= golem[1])
                    bestGolem = golem;
            outputText("\n\n");
            if (bestGolem == null) {
                outputText("You don't have enough mana to send any golems.");
                pspecials.notSendAnyGolem();
            }
            else bestGolem[0]();
        }
        if (ui.isEpicElementalTurn()) {
            
            var attackingEpicElementalTypeFlag:int = flags[kFLAGS.ATTACKING_EPIC_ELEMENTAL_TYPE];

            var epicElementalObj:Object = {
                31: [StatusEffects.SummonedElementalsAirE, AIR],
                32: [StatusEffects.SummonedElementalsEarthE, EARTH],
                33: [StatusEffects.SummonedElementalsFireE, FIRE],
                34: [StatusEffects.SummonedElementalsWaterE, WATER]
            }

            if (epicElementalObj.hasOwnProperty(String(attackingEpicElementalTypeFlag))) {
                var elementalEpicSelection:Array = epicElementalObj[attackingEpicElementalTypeFlag];
                //Force user to choose if currently fused if Elemental, or does not known currently chosen Epic Elemental
                if (player.hasStatusEffect(elementalEpicSelection[0]) && (!player.hasPerk(PerkLib.ElementalBody) || player.perkv1(PerkLib.ElementalBody) != elementalEpicSelection[1])) {
                    baseelementalattacks(attackingEpicElementalTypeFlag);
                }
            }
        }
        if (ui.isElementalTurn()) {
            
            var attackingElementalTypeFlag:int = flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE];

            var baseElementalObj:Object = {
                1: [StatusEffects.SummonedElementalsAir, AIR],
                2: [StatusEffects.SummonedElementalsEarth, EARTH],
                3: [StatusEffects.SummonedElementalsFire, FIRE],
                4: [StatusEffects.SummonedElementalsWater, WATER],
                5: [StatusEffects.SummonedElementalsIce, ICE],
                6: [StatusEffects.SummonedElementalsLightning, LIGHTNING],
                7: [StatusEffects.SummonedElementalsDarkness, DARKNESS],
                8: [StatusEffects.SummonedElementalsWood, WOOD],
                9: [StatusEffects.SummonedElementalsMetal, METAL],
                10: [StatusEffects.SummonedElementalsEther, ETHER],
                11: [StatusEffects.SummonedElementalsPoison, POISON],
                12: [StatusEffects.SummonedElementalsPurity, PURITY],
                13: [StatusEffects.SummonedElementalsCorruption, CORRUPTION]
            }

            if (baseElementalObj.hasOwnProperty(String(attackingElementalTypeFlag))) {
                var elementalSelection:Array = baseElementalObj[attackingElementalTypeFlag];
                //Force user to choose if currently fused if Elemental, or does not known currently chosen Epic Elemental
                if (player.hasStatusEffect(elementalSelection[0]) && (!player.hasPerk(PerkLib.ElementalBody) || player.perkv1(PerkLib.ElementalBody) != elementalSelection[1])) {
                    baseelementalattacks(attackingElementalTypeFlag);
                }
            }
        }
        if (ui.isBloodPuppiesTurn()) {
            var bloodAbility:CombatAbility;
            switch (flags[kFLAGS.BLOOD_PUPPY_SUMMONS]) {
                case 1: bloodAbility = CombatAbilities.BPBloodSwipe;
                        break;
                case 2: bloodAbility = CombatAbilities.BPBloodDewdrops;
                        break;
                case 3: bloodAbility = CombatAbilities.BPHeartSeeker;
                        break;
            }

            if (bloodAbility) {
                if (bloodAbility.isKnownAndUsable) {
                    bloodAbility.perform();
                } else {
                    ui.doBloodPuppiesTurn();
                }
            }
        }
        flushOutputTextToGUI();
    }

    public function willothewispskip():void {
        flags[kFLAGS.IN_COMBAT_PLAYER_WILL_O_THE_WISP_ATTACKED] = 1;
        if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn))
            combatMenu(false);
    }

    public function baseelementalattacks(elementType:int = -1, showNext:Boolean = false):void {
        if (elementType == -1) {
            clearOutput();
            elementType = flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE];
        } /*else {
            flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = elementType;
        }*/
        var summonedElementals:int;
		var summonedElementalsMulti:Number = 1;
		var summonedEpicElemental:Boolean = false;
        switch (elementType) {
            case AIR        :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsAir);
                break;
            case EARTH      :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsEarth);
                break;
            case FIRE       :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsFire);
                break;
            case WATER      :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsWater);
                break;
            case ICE        :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsIce);
                break;
            case LIGHTNING  :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsLightning);
                break;
            case DARKNESS   :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsDarkness);
                break;
            case WOOD       :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsWood);
                break;
            case METAL      :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsMetal);
                break;
            case ETHER      :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsEther);
                break;
            case POISON     :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsPoison);
                break;
            case PURITY     :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsPurity);
                break;
            case CORRUPTION :
                summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsCorruption);
                break;
            case AIR_E      :
                summonedElementals = (5 * player.statusEffectv2(StatusEffects.SummonedElementalsAirE));
				summonedEpicElemental = true;
                break;
            case EARTH_E    :
                summonedElementals = (5 * player.statusEffectv2(StatusEffects.SummonedElementalsEarthE));
				summonedEpicElemental = true;
                break;
            case FIRE_E     :
                summonedElementals = (5 * player.statusEffectv2(StatusEffects.SummonedElementalsFireE));
				summonedEpicElemental = true;
                break;
            case WATER_E    :
                summonedElementals = (5 * player.statusEffectv2(StatusEffects.SummonedElementalsWaterE));
				summonedEpicElemental = true;
                break;
			case NONE		:
				flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] = 1;
				break;
			case NONE_E		:
				flags[kFLAGS.IN_COMBAT_PLAYER_EPIC_ELEMENTAL_ATTACKED] = 1;
				break;
        }
		if (elementType == NONE || elementType == NONE_E) {
			doNext(combatMenu, false);
		}
		else {
			var manaCost:Number = 1;
			var manaCostInt:Number = 8;
			var manaCostWis:Number = 8;
			if (player.hasPerk(PerkLib.FirstAttackElementalsSu)) {
				manaCostInt += 17;
				manaCostWis += 42;
			}
			manaCost += summonedElementals;
			if (summonedElementals >= 11) manaCost += summonedElementals;
			if (summonedElementals >= 21) manaCost += summonedElementals;
			if (summonedElementals >= 29) manaCost += summonedElementals;
			manaCost += player.inte / manaCostInt;
			manaCost += player.wis / manaCostWis;
			if (summonedElementals >= 2 && manaCost > 11 && player.hasPerk(PerkLib.StrongElementalBond)) manaCost -= 10;
			if (summonedElementals >= 4 && manaCost > 22 && player.hasPerk(PerkLib.StrongElementalBondEx)) manaCost -= 20;
			if (summonedElementals >= 6 && manaCost > 33 && player.hasPerk(PerkLib.StrongElementalBondSu)) manaCost -= 30;
			if (summonedElementals >= 9 && manaCost > 44 && player.hasPerk(PerkLib.StrongerElementalBond)) manaCost -= 40;
			if (summonedElementals >= 12 && manaCost > 55 && player.hasPerk(PerkLib.StrongerElementalBondEx)) manaCost -= 50;
			if (summonedElementals >= 15 && manaCost > 66 && player.hasPerk(PerkLib.StrongerElementalBondSu)) manaCost -= 60;
			if (summonedElementals >= 19 && manaCost > 77 && player.hasPerk(PerkLib.StrongestElementalBond)) manaCost -= 70;
			if (summonedElementals >= 23 && manaCost > 88 && player.hasPerk(PerkLib.StrongestElementalBondEx)) manaCost -= 80;
			if (summonedElementals >= 27 && manaCost > 99 && player.hasPerk(PerkLib.StrongestElementalBondSu)) manaCost -= 90;
			if (manaCost > 1 && player.hasPerk(PerkLib.FirstAttackElementalsSu)) manaCost *= 0.5;
			manaCost = Math.round(manaCost);
			if (player.mana < manaCost) {
				outputText("\n\nYour mana is too low to fuel your elemental attack!");
				flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] = 1;
				doNext(combatMenu, false);
			} else {
				if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) outputText("\n\n");
				switch (elementType) {
					case AIR_E      :
						outputText("Sylph");
						break;
					case EARTH_E    :
						outputText("Golem");
						break;
					case FIRE_E     :
						outputText("Ifrit");
						break;
					case WATER_E    :
						outputText("Undine");
						break;
					default:
						outputText("Your elemental");
						break;
				}
				if (manaCost > 0) player.mana -= manaCost;
				if (player.hasPerk(PerkLib.FirstAttackElementalsEx) && player.hasStatusEffect(StatusEffects.SummonedElementals)) {
					var elementalDamageMulti:Number = 1;
					elementalDamageMulti += 0.05 * (player.statusEffectv1(StatusEffects.SummonedElementals));
					elementalDamageMulti += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementals));
					elementalDamageMulti += 0.2 * (player.statusEffectv3(StatusEffects.SummonedElementals));
					summonedElementals *= elementalDamageMulti;
					summonedElementalsMulti += 1;
					if (rand(10) == 0 || player.hasPerk(PerkLib.FirstAttackElementalsSu)) summonedElementalsMulti += 1;
					if (player.hasPerk(PerkLib.FirstAttackElementalsSu)) summonedElementalsMulti += 1;
				}
				outputText(" hit"+(summonedElementalsMulti > 1 ? "s":"")+" [themonster]! ");
				elementalattacks(elementType, summonedElementals, summonedElementalsMulti, summonedEpicElemental, showNext);
			}
		}
    }

    public function elementalattacks(elementType:int, summonedElementals:int, summonedElementalsMulti:Number, summonedEpicElemental:Boolean, showNext:Boolean = false):void {
        var elementalDamage:Number = 0;
        var baseDamage:Number = summonedElementals * intwisscaling() * 0.1;
        if (summonedElementals >= 1) elementalDamage += baseDamage;
        if (summonedElementals >= 5) elementalDamage += baseDamage;
        if (summonedElementals >= 9) elementalDamage += baseDamage;
        if (summonedElementals >= 13) elementalDamage += baseDamage;
        if (elementalDamage < 10) elementalDamage = 10;
        
        elementalDamage *= elementalAmplificationMod(summonedElementals);

        //Determine if critical hit!
        var crit:Boolean = false;
        var critChance:int = 5;
        critChance += combatMagicalCritical();
        if (elementType == AIR || elementType == AIR_E || elementType == WATER || elementType == WATER_E || elementType == METAL || elementType == ETHER) critChance += 10;
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
            switch (elementType) {
                case ETHER:
                    elementalDamage *= 2;
                    break;
                case AIR:
                case AIR_E:
                case METAL:
                    elementalDamage *= 1.75;
                    break;
                default:
                    elementalDamage *= 1.5;
                    break;
            }
        }
        
        elementalDamage = Math.round(elementalDamage);
        switch (elementType) {
            case EARTH:
            case EARTH_E:
                elementalDamage *= 2;
                doEarthDamage(elementalDamage, true, true);
                break;
            case WOOD:
                elementalDamage *= 2;
                doMinionPhysDamage(elementalDamage, true, true);
                break;
            case METAL:
                elementalDamage *= 1.3;
                doMinionPhysDamage(elementalDamage, true, true);
                break;
            case AIR:
            case AIR_E:
                doWindDamage(elementalDamage, true, true);
                break;
            case FIRE:
            case FIRE_E:
                doFireDamage(elementalDamage, true, true);
                break;
            case WATER:
            case WATER_E:
                doWaterDamage(elementalDamage, true, true);
                break;
            case ICE:
                doIceDamage(elementalDamage, true, true);
                break;
            case LIGHTNING:
                doLightningDamage(elementalDamage, true, true);
                break;
            case DARKNESS:
                doDarknessDamage(elementalDamage, true, true);
                break;
            case POISON:
                doPoisonDamage(elementalDamage, true, true);
                break;
            case PURITY:
                elementalDamage *= purityScalingDA();
                doMinionPhysDamage(elementalDamage, true, true);
                break;
            case CORRUPTION:
                elementalDamage *= corruptionScalingDA();
                doMinionPhysDamage(elementalDamage, true, true);
                break;
            default:
                doMinionPhysDamage(elementalDamage, true, true);
                break;
        }
        if (crit) outputText(" <b>Critical!</b>");
        //checkMinionsAchievementDamage(elementalDamage);
		outputText(" ");
        if (monster.HP > monster.minHP() && monster.lust < monster.maxOverLust()) {
			if (summonedElementalsMulti > 1) {
				summonedElementalsMulti -= 1;
				elementalattacks(elementType, summonedElementals, summonedElementalsMulti, summonedEpicElemental, showNext);
			} else {
				outputText("\n\n");
				if (!flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] || !flags[kFLAGS.IN_COMBAT_PLAYER_EPIC_ELEMENTAL_ATTACKED]
                    && (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 3 || flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 4)) {
					if (summonedEpicElemental) {
						flags[kFLAGS.IN_COMBAT_PLAYER_EPIC_ELEMENTAL_ATTACKED] = 1;
						//summonedEpicElemental = false;
					}
					else flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] = 1;
					if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn) || showNext) {
						menu();
						addButton(0, "Next", combatMenu, false);
					}
				}
				else enemyAIImpl();
			}
        } else {
            //If monster is dead, prevent further elemental attack calls
            flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] = 1;
            flags[kFLAGS.IN_COMBAT_PLAYER_EPIC_ELEMENTAL_ATTACKED] = 1;
            if (monster.HP <= monster.minHP()) doNext(endHpVictory);
            else doNext(endLustVictory);
        }
    }

    /**
     * Mech melee attack
     * 1. Check if can attack (sealed, pacifism) and describe attack
     * 2. Check if attack missed (player bind, monster is fast, blocked)
     * 3. Go to mech melee attack calc
     */
    public function basemechmeleeattacks():void {
        flags[kFLAGS.LAST_ATTACK_TYPE] = LAST_ATTACK_PHYS;
        clearOutput();
        var weapon:String = "";
        if (player.isInGoblinMech()) weapon = "saw blade";
		if (player.vehicles == vehicles.HB_MECH) weapon = "twin power blades";
        if (player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 0) {
            outputText("You attempt to attack, but at the last moment your mech wrenches away, preventing you from even coming close to landing a blow!  ");
            if (monster is ChaosChimera) outputText("Curse");
            else outputText("The kitsune's seals");
            outputText(" have made normal melee attacks impossible!  Maybe you could try something else?\n\n");
            enemyAIImpl();
            return;
        }
        if (player.hasStatusEffect(StatusEffects.Sealed2) && player.statusEffectv2(StatusEffects.Sealed2) == 0) {
            outputText("You attempt to attack, but at the last moment your mech wrenches away, preventing you from even coming close to landing a blow!  Recent enemy actions have made normal melee attack impossible!  Maybe you could try something else?\n\n");
            enemyAIImpl();
            return;
        }
		if (checkConcentration()) return; //Amily concentration
		if (monster.hasStatusEffect(StatusEffects.Level) && !player.hasStatusEffect(StatusEffects.FirstAttack)) {
            if (monster is SandTrap) {
                outputText("It's all or nothing!  With a bellowing cry you charge down the treacherous slope and smite the sandtrap as hard as you can!  ");
                (monster as SandTrap).trapLevel(-4);
            }
            if (monster is Alraune) {
                outputText("It’s all or nothing!  If this leafy woman is so keen on pulling you in, you will let her do just that!  You use her own strength against her, using it to increase your momentum as you leap towards her and smash into her with your " + weapon + "!  ");
                (monster as Alraune).trapLevel(-6);
            }
        }
        //Blind
        if (player.playerIsBlinded()) {
            outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ");
        }
        if (monster is Basilisk && !player.hasPerk(PerkLib.BasiliskResistance)) {
            if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind))
                outputText("Blind basilisk can't use his eyes, so you can actually aim your strikes!  ");
            //basilisk counter attack (block attack, significant speed loss):
            else if (player.inte / 5 + rand(20) < 25) {
                outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You find yourself staring directly into the basilisk's face!  Quickly you snap your eyes shut and recoil backwards, swinging madly at the lizard to force it back, but the damage has been done; you can see the terrible grey eyes behind your closed lids, and you feel a great weight settle on your bones as it becomes harder to move.");
                player.addCombatBuff('spe', -20,"Basilisk Gaze","BasiliskGaze");
                player.removeStatusEffect(StatusEffects.FirstAttack);
                combatRoundOver();
                flags[kFLAGS.BASILISK_RESISTANCE_TRACKER] += 2;
                return;
            }
            //Counter attack fails: (random chance if PC int > 50 spd > 60; PC takes small physical damage but no block or spd penalty)
            else {
                outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You twist unexpectedly, bringing your " + weapon + " up at an oblique angle; the basilisk doesn't anticipate this attack!  ");
            }
        }
        if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
            if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(0);
            if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(0);
            enemyAIImpl();
            return;
        }
        //Worms are special
        if (monster is WormMass) {
            //50% chance of hit (int boost)
            if (rand(100) + player.inte / 3 >= 50) {
                var dam:int = int(player.str / 5 - rand(5));
                if (dam == 0) dam = 1;
                outputText("You strike at the amalgamation, crushing countless worms into goo, dealing <b>[font-damage]" + dam + "[/font]</b> damage.\n\n");
                monster.HP -= dam;
                if (monster.HP <= monster.minHP()) {
                    doNext(endHpVictory);
                    return;
                }
            }
            //Fail
            else {
                outputText("You attempt to crush the worms with your reprisal, only to have the collective move its individual members, creating a void at the point of impact, leaving you to attack only empty air.\n\n");
            }
            if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
                attack();
                return;
            }
            enemyAIImpl();
            return;
        }
        //Determine if dodged!
        if (((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe) && !monster.hasPerk(PerkLib.NoDodges))) && !monster.monsterIsStunned()) {
            //Akbal dodges special education
            if (monster is Akbal) outputText("Akbal moves like lightning, weaving in and out of your furious strikes with the speed and grace befitting his jaguar body.\n");
            else if (monster is Shouldra) outputText("You wait patiently for your opponent to drop her guard. She ducks in and throws a right cross, which you roll away from before smacking your " + weapon + " against her side. Astonishingly, the attack appears to phase right through her, not affecting her in the slightest. You glance down to your " + weapon + " as if betrayed.\n");
            else if (monster is Kitsune) {
                //Player Miss:
                outputText("You swing your " + weapon + " ferociously, confident that you can strike a crushing blow.  To your surprise, you stumble awkwardly as the attack passes straight through her - a mirage!  You curse as you hear a giggle behind you, turning to face her once again.\n\n");
            } else {
                if (player.isInGoblinMech()) outputText("You activate the mech’s saw blade, intent on slicing your opponent in half. [Themonster] avoids the blade as best as it can.\n\n");
            }
            enemyAIImpl();
            return;
        }
        //BLOCKED ATTACK:
        if (monster.hasStatusEffect(StatusEffects.Earthshield) && rand(4) == 0) {
            outputText("Your strike is deflected by the wall of sand, dirt, and rock!  Damn!\n");
            if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
                attack();
                return;
            } else outputText("\n");
            enemyAIImpl();
            return;
        }
        baseMechMeleeAttacksDamage();
    }

    /**
     * Do Mech physical attack
     * 1. Basic damage: based on str
     * - Howling Banshee Agility upgrade adds speed to basic damage
     * 2. bonus damage from mech gear, perks
     * 3. crit chance
     * 4. do damage
     */
    public function baseMechMeleeAttacksDamage():void {
        var damage:Number = 0;
		var weapon:String = "";
        if (player.isInGoblinMech()) {
            weapon = "saw blade";

            //Only Mech friendly twin weapons count whenusing an goblin mech
            if (player.weapon == weapons.TRIPPER1 || player.weapon == weapons.TRIPPER2 || player.weapon == weapons.TMACGRSW) {
                weapon = "saw blades";
            }
        }
		if (player.vehicles == vehicles.HB_MECH) weapon = "twin power blades";
        //------------
        // DAMAGE
        //------------
        //Determine damage
        //BASIC DAMAGE STUFF
        if (player.hasKeyItem("HB Agility") >= 0) {
			damage += player.spe;
			damage += scalingBonusSpeed() * 0.20;
			if (player.keyItemvX("HB Agility", 1) == 1) {
				damage += (player.spe / 2);
				damage += scalingBonusSpeed() * 0.10;
			}
		}
        damage += meleeDamageNoLagSingle(false, damage);
		if (player.isInGoblinMech()) {
			damage *= 1.3;
			damage = goblinDamageBonus(damage);
			if (player.vehicles == vehicles.GOBMPRI) damage *= 1.5;
			if (player.vehicles == vehicles.GS_MECH) damage *= 1.25;
		}
		if (player.isInNonGoblinMech()) {
			if (player.vehicles == vehicles.HB_MECH) {
				if (player.armor == armors.HBARMOR) damage *= 1.5;
				if (player.headJewelry == headjewelries.HBHELM) damage *= 1.2;
				if (player.upperGarment == undergarments.HBSHIRT) damage *= 1.1;
				if (player.lowerGarment == undergarments.HBSHORT) damage *= 1.1;
				if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) damage *= 1.25;
			}
			else {
				if (player.armor == armors.HBARMOR) damage *= 1.2;
				if (player.headJewelry == headjewelries.HBHELM) damage *= 1.1;
				if (player.upperGarment == undergarments.HBSHIRT) damage *= 1.05;
				if (player.lowerGarment == undergarments.HBSHORT) damage *= 1.05;
			}
		}
        //Bonus sand trap damage!
        if (monster.hasStatusEffect(StatusEffects.Level) && (monster is SandTrap || monster is Alraune)) damage = Math.round(damage * 1.75);
        damage = perkBonusDamage(damage);
        if (player.hasPerk(PerkLib.GoblinoidBlood) && player.isInGoblinMech()) {
			if (player.hasKeyItem("Power bracer") >= 0) damage *= 1.1;
			if (player.hasKeyItem("Powboy") >= 0) damage *= 1.15;
			if (player.hasKeyItem("M.G.S. bracer") >= 0) damage *= 1.2;
		}
        //Determine if critical hit!
        var crit:Boolean = false;
        var critChance:int = 5;
        critChance += combatPhysicalCritical();
        if (player.hasPerk(PerkLib.WeaponMastery)) critChance += 10;
        if (player.hasPerk(PerkLib.WeaponGrandMastery)) critChance += 10;
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
        }
        //One final round
        damage = Math.round(damage);
        if (damage <= 0) {
            damage = 0;
            outputText("Your attacks are deflected or blocked by [themonster].");
        } else {
            outputText("You activate the mech’s "+weapon+", intent on slicing your opponent in half. [Themonster] takes ");
            doPhysicalDamage(damage, true, true);
            if (player.hasStatusEffect(StatusEffects.ChargeWeapon) && !player.isUnarmedCombat()) {
                doMagicDamage(Math.round(damage * 0.2), true, true);
            }
			if (weapon == "twin power blades" || weapon == "saw blades" || (weapon == "saw blade" && player.hasStatusEffect(StatusEffects.BladeDance))) {
                doPhysicalDamage(damage, true, true);
                if (player.hasStatusEffect(StatusEffects.ChargeWeapon) && !player.isUnarmedCombat()) {
                    doMagicDamage(Math.round(damage * 0.2), true, true);
                }
            }
            outputText(" damage.");
            if (crit) {
                outputText("<b>Critical! </b>");
                if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
            }
            if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
                if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
                else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
            }
        }
        outputText("\n");

        //Chainsword weapon procs
        if (monster.canMonsterBleed() && (player.isUsingMechMeleeWeapons())) {
            if (monster.hasStatusEffect(StatusEffects.Hemorrhage))  monster.removeStatusEffect(StatusEffects.Hemorrhage);
            if (player.weapon == weapons.MACGRSW || player.weapon == weapons.TMACGRSW) monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.02, 0, 0);
            else monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.05, 0, 0);

            if (monster.plural) outputText("\n[Themonster] bleed profusely from the many bloody gashes your [weapon] leave behind.");
            else outputText("\n[Themonster] bleeds profusely from the many bloody gashes your [weapon] left behind.");
        }

        if (player.weapon == weapons.RIPPER2 || player.weapon == weapons.TRIPPER2) {
            outputText("\nReeling in pain [themonster] begins to burn.");
            if (monster.hasStatusEffect(StatusEffects.BurnDoT)) monster.addStatusValue(StatusEffects.BurnDoT,1,1);
            else monster.createStatusEffect(StatusEffects.BurnDoT, 5, 0.05, 0, 0);
        }

        //Gain weapon experience when using goblin weapons
        if (player.isUsingMechMeleeWeapons()) {
            var hitCounter:int = player.vehicles == vehicles.HB_MECH? 2: 1;
            var critCounter:int = crit? 1: 0;
            meleeMasteryGain(hitCounter, critCounter);
        }

        checkAchievementDamage(damage);
		WrathGenerationPerHit2(5);
        heroBaneProc(damage);
        EruptingRiposte();
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxOverLust()) {
            doNext(endLustVictory);
            return;
        }
        outputText("\n\n");
        enemyAIImpl();
    }

    public function packAttack():void {
        //Determine if dodged!
        if (player.speedDodge(monster))
            outputText("You duck, weave, and dodge.  Despite their best efforts, the throng of demons only hit the air and each other.");
        //Determine if evaded
        else if ((player.hasPerk(PerkLib.Evade) && rand(100) < 10) || (player.hasPerk(PerkLib.JunglesWanderer) && rand(100) < 35))
            outputText("Using your skills at evading attacks, you anticipate and sidestep [themonster]' attacks.");
        //("Misdirection"
        else if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 15 && player.armor.hasTag(ItemConstants.A_AGILE))
            outputText("Using Raphael's teachings, you anticipate and sidestep [themonster]' attacks.");
        //Determine if cat'ed
        else if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 6)
            outputText("With your incredible flexibility, you squeeze out of the way of [themonster]' attacks.");
        else {
            var damage:int = int((monster.str + monster.weaponAttack) * (player.damagePercent() / 100)); //Determine damage - str modified by enemy toughness!
            if (damage <= 0) {
                if (!monster.plural)
                    outputText("You deflect and block every " + monster.weaponVerb + " [themonster] throw at you.");
                else outputText("You deflect [themonster] " + monster.weaponVerb + ".");
            } else {
                if (damage <= 5)
                    outputText("You are struck a glancing blow by [themonster]! ");
                else if (damage <= 10)
                    outputText("[Themonster] wounds you! ");
                else if (damage <= 20)
                    outputText("[Themonster] staggers you with the force of [monster his] " + monster.weaponVerb + "! ");
                else outputText("[Themonster] <b>mutilates</b> you with powerful fists and " + monster.weaponVerb + "! ");
                player.takePhysDamage(damage, true);
            }
            statScreenRefresh();
            outputText("\n");
        }
    }

    public function lustAttack():void {
        flags[kFLAGS.LAST_ATTACK_TYPE] = LAST_ATTACK_LUST;
        if (player.lust < (player.maxLust() * 0.35)) {
            outputText("The [monster name] presses in close against you. Although they fail to hit you with an attack, the sensation of their skin rubbing against yours feels highly erotic.");
        } else if (player.lust < (player.maxLust() * 0.65)) {
            outputText("The push of the [monster name]' sweaty, seductive bodies sliding over yours is deliciously arousing and you feel your ");
            if (player.cocks.length > 0)
                outputText(player.multiCockDescriptLight() + " hardening ");
            else if (player.vaginas.length > 0) outputText(vaginaDescript(0) + " get wetter ");
            outputText("in response to all the friction.");
        } else {
            outputText("As the [monster name] mill around you, their bodies rub constantly over yours, and it becomes harder and harder to keep your thoughts on the fight or resist reaching out to touch a well lubricated cock or pussy as it slips past.  You keep subconsciously moving your ");
            if (player.gender == 1) outputText(player.multiCockDescriptLight() + " towards the nearest inviting hole.");
            if (player.gender == 2) outputText(vaginaDescript(0) + " towards the nearest swinging cock.");
            if (player.gender == 3) outputText("aching cock and thirsty pussy towards the nearest thing willing to fuck it.");
            if (player.gender == 0) outputText("groin, before remember there is nothing there to caress.");
        }
        player.takeLustDamage(10 + player.effectiveSensitivity() / 10, true);
    }

    internal function wait():void {
        var skipMonsterAction:Boolean = false; // If false, enemyAI() will be called. If true, combatRoundOver()
        flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] = 1;
        if (monster.hasStatusEffect(StatusEffects.PCTailTangle)) {
            (monster as Kitsune).kitsuneWait();
            skipMonsterAction = true;
        } else if (monster.hasStatusEffect(StatusEffects.MinotaurEntangled)) {
            clearOutput();
            outputText("You sigh and relax in the chains, eying the well-endowed minotaur as you await whatever rough treatment he desires to give.  His musky, utterly male scent wafts your way on the wind, and you feel droplets of your lust dripping down your thighs.  You lick your lips as you watch the pre-cum drip from his balls, eager to get down there and worship them.  Why did you ever try to struggle against this fate?\n\n");
            player.takeLustDamage(30 + rand(5), true);
        } else if (player.hasStatusEffect(StatusEffects.Whispered)) {
            clearOutput();
            outputText("You shake off the mental compulsions and ready yourself to fight!\n\n");
            player.removeStatusEffect(StatusEffects.Whispered);
        } else if (monster.hasStatusEffect(StatusEffects.Dig)) {
            clearOutput();
            outputText("You bid your time underground preparing your next move.\n\n");
        } else if (player.hasStatusEffect(StatusEffects.HarpyBind)) {
            clearOutput();
            outputText("The brood continues to hammer away at your defenseless self. ");
            var damage:int = 80 + rand(40);
            player.takePhysDamage(damage, true);
            skipMonsterAction = true;
        } else if (monster.hasStatusEffect(StatusEffects.QueenBind)) {
            (monster as HarpyQueen).ropeStruggles(true);
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.MagnarPinned)) {
            (monster as Magnar).magnarPinStruggle(true);
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.Straddle)) {
            if (monster is ProjectNightwalker)(monster as ProjectNightwalker).struggleFaceSitting(true);
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.DragonsNom)) {
            if (monster is UltimisFlamespreader)(monster as UltimisFlamespreader).struggleNom(true);
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.GooBind)) {
            clearOutput();
            if (monster is HellfireSnail) outputText("Your flesh begins burning as the snail embraces you with her molten body! You scream, but the molten girl doesn't stop!");
            else if (monster is DarkSlimeEmpress) outputText("You writhe uselessly, trapped inside the dark slime girls warm, seething bodies. Darkness creeps at the edge of your vision as you are lulled into surrendering by the rippling vibrations of the girls pulsing bodies around yours.");
            else outputText("You writhe uselessly, trapped inside the goo girl's warm, seething body. Darkness creeps at the edge of your vision as you are lulled into surrendering by the rippling vibrations of the girl's pulsing body around yours.");
            if (monster is HellfireSnail) player.takeFireDamage((.1 + (.01 * monster.statusEffectv1(StatusEffects.RisingInferno))) * player.maxHP(), true);
            else player.takePhysDamage(.35 * player.maxHP(), true);
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.GooArmorBind)) {
            clearOutput();
            outputText("Suddenly, the goo-girl leaks half-way out of her heavy armor and lunges at you. You attempt to dodge her attack, but she doesn't try and hit you - instead, she wraps around you, pinning your arms to your chest. More and more goo latches onto you - you'll have to fight to get out of this.");
            player.addStatusValue(StatusEffects.GooArmorBind, 1, 1);
            if (player.statusEffectv1(StatusEffects.GooArmorBind) >= 5) {
                if (monster.hasStatusEffect(StatusEffects.Spar))
                    SceneLib.valeria.pcWinsValeriaSparDefeat();
                else SceneLib.dungeons.heltower.gooArmorBeatsUpPC();
                return;
            }
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.NagaBind)) {
            clearOutput();
            if (monster is Diva) {
                (monster as Diva).moveBite();
            }
            if (monster is CaiLin && flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
            else outputText("The [monster name]");
            outputText("'s grip on you tightens as you relax into the stimulating pressure.");
            player.takeLustDamage(player.effectiveSensitivity() / 5 + 5, true);
            player.takePhysDamage(5 + rand(5));
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.ScyllaBind)) {
            clearOutput();
			if (monster is Charybdis) {
				outputText("Instead of squeezing, as you’d assumed he would, a sharp stabbing pain in your flank reminds you that he’s still holding knives. As you struggle, his knives stab into your flesh.");
				
			}
			else {
				outputText("You're being squeezed tightly by the scylla’s powerful tentacles. That's without mentioning the fact she's rubbing your sensitive place quite a bit, giving you a knowing grin.");
				player.takeLustDamage(player.effectiveSensitivity() / 4 + 20, true);
				player.takePhysDamage(100 + rand(40));
			}
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.WolfHold)) {
            clearOutput();
            if (monster is WinterWolf) {
                outputText("The wolf tears at your body with its maw, ripping skin and muscle as it starts to eat you alive!");
                player.takePhysDamage(10 + rand(10));
            }
            if (monster is Luna) {
                outputText("Luna tears your body with her claws.");
                player.takePhysDamage(5 + rand(5));
            }
            if (monster is WerewolfFemale || monster is WerewolfHuntress) {
                outputText("The wolf tears at your body with her maw, ripping skin and muscle as she starts to eat you alive!");
                player.takePhysDamage(5 + rand(5));
            }
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.TrollHold)) {
            clearOutput();
			if (monster as GlacialMaleTroll) {
				outputText("You don’t feel motivated, something about his big, strong arms and soothing fur is getting to you, granting you safety from the cold.");
				player.addStatusValue(StatusEffects.TrollHold, 1, 1);
			}
			if (monster as CorruptedMaleTroll) {
				outputText("You don’t feel motivated, something about his strong arms and soothing fur is getting to you, it’s not so bad once you really sink into him.");
				outputText("\n\nHe leans in close to you, sniffing you intently as he gives you a long lick across your cheek.");
				var licklust:Number = (monster.inte / 5) + rand(10);
				licklust = Math.round(licklust);
				player.takeLustDamage(licklust, true);
			}
            if (player.statusEffectv1(StatusEffects.TrollHold) < 2) skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.PossessionWendigo)) {
            clearOutput();
            outputText("You decide to do nothing for now as the wendigo takes advantage of your inaction, gleefully forcing you to masturbate while enjoying every sensation your tormented body is inflicted with.");
            var possessionWendigo:Number = (monster.inte / 4) + rand(15);
			possessionWendigo = Math.round(possessionWendigo);
			player.dynStats("lus", possessionWendigo, "scale", false);
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.HolliConstrict)) {
            (monster as Holli).waitForHolliConstrict(true);
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.TentacleBind)) {
            clearOutput();
            if (player.cocks.length > 0)
                outputText("The creature continues spiraling around your cock, sending shivers up and down your body. You must escape or this creature will overwhelm you!");
            else if (player.hasVagina())
                outputText("The creature continues sucking your clit and now has latched two more suckers on your nipples, amplifying your growing lust. You must escape or you will become a mere toy to this thing!");
            else outputText("The creature continues probing at your asshole and has now latched " + num2Text(player.totalNipples()) + " more suckers onto your nipples, amplifying your growing lust.  You must escape or you will become a mere toy to this thing!");
            player.takeLustDamage((8 + player.effectiveSensitivity() / 10), true);
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.GiantGrabbed)) {
            clearOutput();
            if (monster as FrostGiant) (monster as FrostGiant).giantGrabFail(false);
            if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantGrabFail(false);
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.GiantBoulder)) {
            clearOutput();
            if (monster as FrostGiant) (monster as FrostGiant).giantBoulderMiss();
            if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderMiss();
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.IsabellaStunned)) {
            clearOutput();
            outputText("You wobble about for some time but manage to recover. Isabella capitalizes on your wasted time to act again.\n\n");
            player.removeStatusEffect(StatusEffects.IsabellaStunned);
        } else if (player.hasStatusEffect(StatusEffects.Stunned)) {
            clearOutput();
            outputText("You wobble about, stunned for a moment.  After shaking your head, you clear the stars from your vision, but by then you've squandered your chance to act.\n\n");
            player.removeStatusEffect(StatusEffects.Stunned);
        } else if (player.hasStatusEffect(StatusEffects.Confusion)) {
            clearOutput();
            outputText("You shake your head and file your memories in the past, where they belong.  It's time to fight!\n\n");
            player.removeStatusEffect(StatusEffects.Confusion);
        } else if (monster is Doppleganger) {
            clearOutput();
            outputText("You decide not to take any action this round.\n\n");
            (monster as Doppleganger).handlePlayerWait();
        } else {
            clearOutput();
            outputText("You decide not to take any action this round.\n\n");
        }
        if (skipMonsterAction) {
            combatRoundOver();
        } else {
            enemyAIImpl();
        }
    }

    public function wait2():void {
        if (monster is SandTrap) {
            (monster as SandTrap).sandTrapClimb();
        }
        if (monster is Alraune) {
            (monster as Alraune).alrauneStruggle();
        }
        combatRoundOver();
    }

    internal function struggle():void {
        var skipMonsterAction:Boolean = false; // If false, enemyAI() will be called. If true, combatRoundOver()
        if (monster.hasStatusEffect(StatusEffects.MinotaurEntangled)) {
            clearOutput();
            if ((player.str / 9 + rand(20) + 1 >= 15) || player.hasPerk(PerkLib.FluidBody)) {
                outputText("Utilizing every ounce of your strength and cunning, you squirm wildly, shrugging through weak spots in the chain's grip to free yourself!  Success!\n\n");
                monster.removeStatusEffect(StatusEffects.MinotaurEntangled);
                if (flags[kFLAGS.URTA_QUEST_STATUS] == 0.75) outputText("\"<i>No!  You fool!  You let her get away!  Hurry up and finish her up!  I need my serving!</i>\"  The succubus spits out angrily.\n\n");
                skipMonsterAction = true;
            }
            //Struggle Free Fail*
            else {
                outputText("You wiggle and struggle with all your might, but the chains remain stubbornly tight, binding you in place.  Damnit!  You can't lose like this!\n\n");
            }
        } else if (monster.hasStatusEffect(StatusEffects.PCTailTangle)) {
            (monster as Kitsune).kitsuneStruggle();
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.HolliConstrict)) {
            (monster as Holli).struggleOutOfHolli();
            skipMonsterAction = true;
        } else if (monster.hasStatusEffect(StatusEffects.QueenBind)) {
            (monster as HarpyQueen).ropeStruggles();
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.SiegweirdGrapple)) (monster as SiegweirdBoss).siegweirdStruggle(); //no skipping?
         else if (player.hasStatusEffect(StatusEffects.GooBind)) {
            clearOutput();
            //[Struggle](successful) :
            if (rand(3) == 0 || rand(80) < player.str) {
                if (monster is HellfireSnail) {
                    outputText("You manage to break out of the snail’s burning embrace and she sighs in frustration as you take some distance.");
                    outputText("\n\n\"<i>Aw come back here! I just want a hug!</i>\"");
                } else if (monster is DarkSlimeEmpress) outputText("You barely manage to break out of the slimes clingy bodies standing up to resume the battle.");
                else outputText("You claw your fingers wildly within the slime and manage to brush against her heart-shaped nucleus. The girl silently gasps and loses cohesion, allowing you to pull yourself free while she attempts to solidify.");
                player.removeStatusEffect(StatusEffects.GooBind);
            }
            //Failed struggle
            else {
                if (monster is HellfireSnail) outputText("Your flesh begins burning as the snail embraces you with her molten body! The sound is terrifying, like cooking meat...YOUR meat!");
                else if (monster is DarkSlimeEmpress) outputText("You writhe uselessly, trapped inside the dark slime girls warm, seething bodies. Darkness creeps at the edge of your vision as you are lulled into surrendering by the rippling vibrations of the girls pulsing bodies around yours.");
                else outputText("You writhe uselessly, trapped inside the goo girl's warm, seething body. Darkness creeps at the edge of your vision as you slow, lulled into surrendering by the rippling vibrations of the girl's pulsing body around yours. ");
                if (monster is HellfireSnail) player.takeFireDamage((.05 + (.005 * monster.statusEffectv1(StatusEffects.RisingInferno))) * player.maxHP(), true);
                else player.takePhysDamage(.15 * player.maxHP(), true);
            }
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.ArcaneWeb)) {
			clearOutput();
			outputText("You struggle against your magical bonds");
			if (rand(3) == 0 || rand(80) < player.str) {
				outputText(" breaking free of the insidious spell");
				player.removeStatusEffect(StatusEffects.ArcaneWeb);
			}
			else outputText(".");
			skipMonsterAction = true;
		} else if (player.hasStatusEffect(StatusEffects.HarpyBind)) {
            (monster as HarpyMob).harpyHordeGangBangStruggle();
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.MagnarPinned)) {
            (monster as Magnar).magnarPinStruggle();
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.Straddle)) {
            if (monster is ProjectNightwalker)(monster as ProjectNightwalker).struggleFaceSitting();
            else {
                //33% chance to break free + up to 50% chance for strength
                if (rand(3) == 0 || rand(80) < player.str / 2 || player.hasPerk(PerkLib.FluidBody)) {
                    outputText("You grunt in anger, bending your body as quickly as you can. You slam [themonster] into the ground, and you can feel her legs loosen around your neck. With a roar of effort, you get a hold of her ankles, break her grip on your face, and throw [monster him] away from you.\n\n");
                    player.removeStatusEffect(StatusEffects.Straddle);
                }
            }
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.DragonsNom)) {
            if (monster is UltimisFlamespreader)(monster as UltimisFlamespreader).struggleNom(true);
            else {
                //33% chance to break free + up to 50% chance for strength
                if (rand(3) == 0 || rand(80) < player.str / 2 || player.hasPerk(PerkLib.FluidBody)) {
                    outputText("You grunt in anger, managing to slip out of [themonster]'s jaws and roll away.\n\n");
                    player.removeStatusEffect(StatusEffects.DragonsNom);
                }
            }
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.GooArmorBind)) {
            (monster as Valeria).struggleAtGooBind();
            if (player.statusEffectv1(StatusEffects.GooArmorBind) >= 5) {
                if (monster.hasStatusEffect(StatusEffects.Spar)) SceneLib.valeria.pcWinsValeriaSparDefeat();
                else SceneLib.dungeons.heltower.gooArmorBeatsUpPC();
                return;
            }
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.UBERWEB)) {
            clearOutput();
            outputText("You claw your way out of the webbing while Kiha does her best to handle the spiders single-handedly!\n\n");
            player.removeStatusEffect(StatusEffects.UBERWEB);
        } else if (player.hasStatusEffect(StatusEffects.NagaBind)) {
            clearOutput();
            if (rand(3) == 0 || rand(80) < player.str / 1.5 || player.hasPerk(PerkLib.FluidBody)) {
                outputText("You wriggle and squirm violently, tearing yourself out from within [themonster]'s coils.");
                player.removeStatusEffect(StatusEffects.NagaBind);
            } else {
                if (monster is CaiLin && flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
                else outputText("The [monster name]");
                outputText("'s grip on you tightens as you struggle to break free from the stimulating pressure.");
                player.takeLustDamage(player.effectiveSensitivity() / 10 + 2, true);
                if (monster is Naga) player.takePhysDamage(7 + rand(5));
                if (monster is Gorgon) player.takePhysDamage(17 + rand(15));
                if (monster is CaiLin) player.takePhysDamage(10 + rand(8));
                if (monster is Diva) {
                    (monster as Diva).moveBite();
                }
            }
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.ScyllaBind)) {
            clearOutput();
            outputText("You struggle to get free from the [monster name]'s mighty tentacles. ");
            if (rand(3) == 0 || rand(120) < player.str / 1.5 || player.hasPerk(PerkLib.FluidBody)) {
                if (monster is Charybdis) outputText("You grunt with effort, struggling against the muscular bands of his tentacles. You loosen his grip by just enough, popping out of his embrace with a roar of effort. You slide along the ground for a moment, getting to your feet.");
				else outputText("As force alone seems ineffective, you bite one of her tentacles and she screams in surprise, releasing you.");
                player.removeStatusEffect(StatusEffects.ScyllaBind);
            } else {
                if (monster is Charybdis) outputText("His limbs tighten around you. The sucker-tipped limbs hold firm against your attempt to loosen them, and you slump, exhausted.");
				else outputText("Despite all of your struggles, she manages to maintain her hold on you.");
                player.takeLustDamage(player.effectiveSensitivity() / 5 + 5, true);
                player.takePhysDamage(100 + rand(80));
            }
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.WolfHold)) {
            clearOutput();
            if (rand(3) == 0 || rand(80) < player.str / 1.5 || player.hasPerk(PerkLib.FluidBody)) {
                if (monster is WinterWolf) outputText("You slam your forehead in the wolf's sensitive muzzle. It recoils, whining in pain. Its focus shattered, you push the winter wolf off you, allowing you to stand up.");
                if (monster is Luna || monster is WerewolfFemale || monster is WerewolfHuntress) outputText("You shove [themonster] off of you, standing back up; she growls at you, licking her lips hungrily.");
                player.removeStatusEffect(StatusEffects.WolfHold);
            } else {
                if (monster is WinterWolf) {
                    outputText("The wolf growls, bringing its maw down and biting deep into you. It growls through your flesh, trying to rip a giant hunk off of you. This creature is trying to eat you alive!");
                    player.takePhysDamage(7 + rand(5));
                }
                if (monster is Luna || monster is WerewolfFemale || monster is WerewolfHuntress) {
                    outputText("You try and shove [themonster] off but she anticipates the attempt, countering you and pinning you down again.\n");
                    outputText("[Themonster] rends you twice with her claws.");
                    var RavageDmg:Number = monster.eBaseStrengthDamage();
                    if (flags[kFLAGS.LUNA_LVL_UP] >= 3) RavageDmg += monster.eBaseStrengthDamage() * 0.2;
                    if (flags[kFLAGS.LUNA_LVL_UP] >= 6) RavageDmg += monster.eBaseStrengthDamage() * 0.3;
                    RavageDmg = Math.round(RavageDmg);
                    player.takePhysDamage(RavageDmg);
                    player.takePhysDamage(RavageDmg);
                }
            }
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.TrollHold)) {
			clearOutput();
			if (rand(3) == 0 || rand(80) < player.str / 1.5 || player.hasPerk(PerkLib.FluidBody)) {
				outputText("You squirm violently, trying to shake out of his grasp. You break free, pushing him away. The troll staggers back, disoriented.");
				player.removeStatusEffect(StatusEffects.TrollHold);
			}
			else {
				if (monster as GlacialMaleTroll) {
					outputText("You squirm violently, trying to shake out of his grasp. He maintains a fierce grip on you.");
					player.addStatusValue(StatusEffects.TrollHold, 1, 1);
				}
				if (monster as CorruptedMaleTroll) outputText("The troll clutches onto you tighter as you are pulled deeper into his embrace. Your struggles seem to be in vain as he pokes your body with his pre-leaking erection. The warm fluid makes you flush reflexively, but you cannot give in!");
				player.takePhysDamage(7 + rand(5));
				var licklust:Number = (monster.inte / 5) + rand(10) + player.statusEffectv3(StatusEffects.TrollHold);
				licklust = Math.round(licklust);
				player.takeLustDamage(licklust, true);
				if (monster as CorruptedMaleTroll) player.addStatusValue(StatusEffects.TrollHold, 3, 1);
			}
            if (player.statusEffectv1(StatusEffects.TrollHold) < 2) skipMonsterAction = true;
		} else if (player.hasStatusEffect(StatusEffects.PossessionWendigo)) {
            clearOutput();
            outputText("You struggle for control over your body ");
            if (rand(3) == 0 || rand(80) < player.str / 1.5) {
				outputText("and manage to force the fiend out.");
				player.removeStatusEffect(StatusEffects.PossessionWendigo);
			}
            else {
				outputText("but the wendigo overpowers you and gleefully forces you to masturbate yourself, enjoying every sensation your tormented body is inflicted with.");
				var possessionWendigo:Number = (monster.inte / 4) + rand(15);
				possessionWendigo = Math.round(possessionWendigo);
				player.dynStats("lus", possessionWendigo, "scale", false);
			}
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.GiantGrabbed)) {
            if (monster as FrostGiant) (monster as FrostGiant).giantGrabStruggle();
            if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantGrabStruggle();
            skipMonsterAction = true;
        } else {
            clearOutput();
            outputText("You struggle with all of your might to free yourself from the tentacles before the creature can fulfill whatever unholy desire it has for you.\n");
            //33% chance to break free + up to 50% chance for strength
            if (rand(3) == 0 || rand(80) < player.str / 2 || player.hasPerk(PerkLib.FluidBody)) {
                outputText("As the creature attempts to adjust your position in its grip, you free one of your [legs] and hit the beast in its beak, causing it to let out an inhuman cry and drop you to the ground smartly.\n\n");
                player.removeStatusEffect(StatusEffects.TentacleBind);
                monster.createStatusEffect(StatusEffects.TentacleCoolDown, 3, 0, 0, 0);
            }
            //Fail to break free
            else {
                outputText("Despite trying to escape, the creature only tightens its grip, making it difficult to breathe.\n\n");
                player.takePhysDamage(5);
                if (player.cocks.length > 0)
                    outputText("The creature continues spiraling around your cock, sending shivers up and down your body. You must escape or this creature will overwhelm you!");
                else if (player.hasVagina())
                    outputText("The creature continues sucking your clit and now has latched two more suckers on your nipples, amplifying your growing lust. You must escape or you will become a mere toy to this thing!");
                else outputText("The creature continues probing at your asshole and has now latched " + num2Text(player.totalNipples()) + " more suckers onto your nipples, amplifying your growing lust.  You must escape or you will become a mere toy to this thing!");
                player.takeLustDamage((3 + player.effectiveSensitivity() / 10 + player.lib / 20), true);
                skipMonsterAction = true;
            }
        }
        if (skipMonsterAction) {
            combatRoundOver();
        } else {
            enemyAIImpl();
        }
    }

    internal function pickUpThrownWeapons():void {
        clearOutput();
        outputText("You boldly approach your enemy. instead of attacking, you simply pick up some of your thrown weapons.");
		player.ammo += 5;
        enemyAI();
    }

    //unused for now function - maybe use later for some other attacks accuracy or maybe spells? xD
    //SH comment: THIS IS NOT FUCKING DND, HOW DO YOU MISS WITH A FIREBALL
    /*
    public function attacksAccuracy():Number {
        var atkmod:Number = 100;
        /*	if (player.inte > 50 && player.hasPerk(PerkLib.JobHunter)) {
		if (player.inte <= 150) atkmod += (player.inte - 50);
		else atkmod += 100;
	}
//	if(player.hasPerk(PerkLib.GreyMage) && player.inte >= 125) mod += .7;
//	if(player.hasPerk(PerkLib.Mage)) mod += .2;
//	if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
//	if (player.hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
//	if (flags[kFLAGS.CUPID_ARROWS] == 1) onearrowcost += 5;
        return atkmod;
    }
    */

    public function meleeAccuracy():Number {
        var accmod:Number = 128;
		if (player.level > 0) {
			if (player.level > 5) accmod += 72;
			else accmod += 12 * player.level;
		}
        if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) accmod += 40;
        if (player.hasPerk(PerkLib.HistoryFeral) || player.hasPerk(PerkLib.PastLifeFeral)) accmod += 20;
        if (player.isFlying() && player.hasPerk(PerkLib.AerialCombat) && !player.haveWeaponForJouster() && !player.haveThrowableMeleeWeapon()) {
            if (player.jewelry1 != jewelries.RNGAMBI) accmod -= 60;
            if (player.hasPerk(PerkLib.Aerobatics)) accmod += 40;
            if (player.hasPerk(PerkLib.AdvancedAerobatics)) accmod += 100;
        }
		if (player.hasPerk(PerkLib.TrueSeeing)) accmod += 40;
        if (monster.hasStatusEffect(StatusEffects.EvasiveTeleport) && !player.hasPerk(PerkLib.TrueSeeing)) accmod -= monster.statusEffectv1(StatusEffects.EvasiveTeleport);
        if (player.jewelry1 == jewelries.RNGAMBI) accmod += 30;
        if (player.hasMutation(IMutationsLib.EyeOfTheTigerIM)) accmod += 5;
        if (player.hasMutation(IMutationsLib.HumanEyesIM) && player.racialScore(Races.HUMAN) > 17) {
			accmod += 5;
			if (player.perkv1(IMutationsLib.HumanEyesIM) >= 3) accmod += 5;
			if (player.perkv1(IMutationsLib.HumanEyesIM) >= 4) accmod += 10;
		}
		if (player.isFistOrFistWeapon()) {
			if (flags[kFLAGS.FERAL_COMBAT_MODE] == 1) accmod += Math.round((masteryFeralCombatLevel() - 1) / 2);
			else {
				if (player.isGauntletWeapon()) accmod += Math.round((masteryGauntletLevel() - 1) / 2);
				else accmod += Math.round((masteryUnarmedCombatLevel() - 1) / 2);
			}
		}
		if (player.isSwordTypeWeapon()) accmod += Math.round((masterySwordLevel() - 1) / 2);
		if (player.isAxeTypeWeapon()) accmod += Math.round((masteryAxeLevel() - 1) / 2);
		if (player.isMaceHammerTypeWeapon()) accmod += Math.round((masteryMaceHammerLevel() - 1) / 2);
		if (player.isDuelingTypeWeapon()) accmod += Math.round((masteryDuelingSwordLevel() - 1) / 2);
		if (player.isPolearmTypeWeapon()) accmod += Math.round((masteryPolearmLevel() - 1) / 2);
		if (player.isSpearTypeWeapon()) accmod += Math.round((masterySpearLevel() - 1) / 2);
		if (player.isDaggerTypeWeapon()) accmod += Math.round((masteryDaggerLevel() - 1) / 2);
		if (player.isWhipTypeWeapon()) accmod += Math.round((masteryWhipLevel() - 1) / 2);
		if (player.isExoticTypeWeapon()) accmod += Math.round((masteryExoticLevel() - 1) / 2);
		if (player.weapon.isDualSmall() || player.hasAetherTwinsTierS2()) accmod += Math.round((dualWSLevel() - 1) / 2);
		if (player.weapon.isDualMedium()) accmod += Math.round((dualWNLevel() - 1) / 2);
		if (player.weapon.isDualLarge()) accmod += Math.round((dualWLLevel() - 1) / 2);
		if (player.weapon.isDualMassive()) accmod += Math.round((dualWMLevel() - 1) / 2);
		if (player.weapon.isDual()) accmod += meleeDualWieldAccuracyPenalty();
        var weaponSize:Number = 1;
        if (player.weapon.isSingleSmall()) weaponSize = 0;
        if (player.weapon.isSingleLarge()) weaponSize = 2;
        if (player.weapon.isSingleMassive()) weaponSize = 3;
        if (weaponSize == 0 || player.hasAetherTwinsTierS1() || player.hasAetherTwinsTierS2()) accmod += Math.round((weaponSizeSmall() - 1) / 2);
        if (weaponSize == 1) accmod += Math.round((weaponSizeNormal() - 1) / 2);
        if (weaponSize == 2) accmod += Math.round((weaponSizeLarge() - 1) / 2);
        if (weaponSize == 3) accmod += Math.round((weaponSizeMassive() - 1) / 2);
        return accmod;
    }

    public function meleeAccuracyPenalty():Number {
        var accmmodpenalty:Number = 10;
        if (player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 3) accmmodpenalty -= 5;
		if (player.hasMutation(IMutationsLib.HumanEyesIM) && player.perkv1(IMutationsLib.HumanEyesIM) >= 3 && player.racialScore(Races.HUMAN) > 17) {
			accmmodpenalty -= 5;
			if (player.perkv1(IMutationsLib.HumanEyesIM) >= 4) accmmodpenalty -= 5;
		}
		//if (player.statStore.hasBuff("AsuraForm") && player.hasPerk(PerkLib.)) accmmodpenalty -= 5;
        if (accmmodpenalty < 0) accmmodpenalty = 0;
        return accmmodpenalty;
    }

	public function meleeDualWieldAccuracyPenalty():Number {
		var accmdwmodpenalty:Number = -25;
        if (player.weapon.isDualMedium()) {
			if (player.hasPerk(PerkLib.DualWieldNormal)) accmdwmodpenalty += 10;
		}
        if (player.weapon.isDualMassive()) {
			if (player.hasPerk(PerkLib.DualWieldMassive)) accmdwmodpenalty += 10;
		}
        if (player.weapon.isDualLarge()) {
			if (player.hasPerk(PerkLib.DualWieldLarge)) accmdwmodpenalty += 10;
		}
        if (player.weapon.isDualSmall()) {
			if (player.hasPerk(PerkLib.DualWieldSmall)) accmdwmodpenalty += 10;
		}
        /*
        if (player.weapon.isQuad()) {
			accmdwmodpenalty -= 50;
		}
         */
        return accmdwmodpenalty;
	}

	public function meleeDualWieldDamagePenalty():Number {
		var dmgmdwmodpenalty:Number = 1;
        if (player.weapon.isDualMedium()) {
			if (player.hasPerk(PerkLib.DualWieldNormal)) dmgmdwmodpenalty -= 0.3;
			else dmgmdwmodpenalty -= 0.5;
		}
        if (player.weapon.isDualMassive()) {
			if (player.hasPerk(PerkLib.DualWieldMassive)) dmgmdwmodpenalty -= 0.3;
			else dmgmdwmodpenalty -= 0.5;
		}
        if (player.weapon.isDualLarge()) {
			if (player.hasPerk(PerkLib.DualWieldLarge)) dmgmdwmodpenalty -= 0.3;
			else dmgmdwmodpenalty -= 0.5;
		}
        if (player.weapon.isDualSmall()) {
			if (player.hasPerk(PerkLib.DualWieldSmall)) dmgmdwmodpenalty -= 0.3;
			else dmgmdwmodpenalty -= 0.5;
		}
        /*
        if (player.weapon.isQuad()) {
			dmgmdwmodpenalty -= 0.9;
		}
         */
        return dmgmdwmodpenalty;
	}

	public function baseRangeAccuracy():Number {
		var baccmod:Number = 128;
		if (player.level > 0) {
			if (player.level > 5) baccmod += 72;
			else baccmod += 12 * player.level;
		}
        if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) baccmod += 40;
        baccmod += player.rangedAccuracyStat.value;
        if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
            if (player.statusEffectv1(StatusEffects.Kelt) <= 100) baccmod += player.statusEffectv1(StatusEffects.Kelt);
            else baccmod += 100;
        }
        if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
            if (player.statusEffectv1(StatusEffects.Kindra) <= 150) baccmod += player.statusEffectv1(StatusEffects.Kindra);
            else baccmod += 150;
        }
        if (player.inte > 50 && player.hasPerk(PerkLib.JobHunter)) {
            if (player.inte <= 150) baccmod += (player.inte - 50);
            else baccmod += 100;
        }
        if (player.hasPerk(PerkLib.CarefulButRecklessAimAndShooting)) baccmod += 60;
        if (player.isFlying()) {
            if (player.jewelry1 != jewelries.RINGDEA) baccmod -= 100;
            if (player.hasPerk(PerkLib.Aerobatics)) baccmod += 40;
            if (player.hasPerk(PerkLib.AdvancedAerobatics)) baccmod += 100;
        }
		if (player.hasPerk(PerkLib.TrueSeeing)) baccmod += 40;
        if (monster.hasStatusEffect(StatusEffects.EvasiveTeleport) && !player.hasPerk(PerkLib.TrueSeeing)) baccmod -= player.statusEffectv1(StatusEffects.EvasiveTeleport);
        if (player.jewelry1 == jewelries.RINGDEA) baccmod += 40;
        if (player.hasMutation(IMutationsLib.HumanEyesIM) && player.racialScore(Races.HUMAN) > 17) {
			baccmod += 10;
			if (player.perkv1(IMutationsLib.HumanEyesIM) >= 3) baccmod += 10;
			if (player.perkv1(IMutationsLib.HumanEyesIM) >= 4) baccmod += 20;
		}
		return baccmod;
	}

    public function arrowsAccuracy():Number {
        var accmod:Number = 0;
		accmod += baseRangeAccuracy();
		accmod += Math.round((masteryArcheryLevel() - 1) / 2);
        return accmod;
    }

    public function arrowsAccuracyPenalty():Number {
        var accrmodpenalty:Number = 15;
        if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) accrmodpenalty -= 10;
        if (player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 3) accrmodpenalty -= 5;
		if (player.hasMutation(IMutationsLib.HumanEyesIM) && player.perkv1(IMutationsLib.HumanEyesIM) >= 3 && player.racialScore(Races.HUMAN) > 17) {
			accrmodpenalty -= 5;
			if (player.perkv1(IMutationsLib.HumanEyesIM) >= 4) accrmodpenalty -= 5;
		}
        if (player.weaponRangeName == "Avelynn") accrmodpenalty -= 5;
        if (accrmodpenalty < 0) accrmodpenalty = 0;
        return accrmodpenalty;
    }

    public function throwingAccuracy():Number {
        var taccmod:Number = 0;
		taccmod += baseRangeAccuracy();
		taccmod += Math.round((masteryThrowingLevel() - 1) / 2);
		if (player.miscjewelryName == "Atlatl" || player.miscjewelryName2 == "Atlatl") taccmod += 50;
        return taccmod;
    }

    public function firearmsAccuracy():Number {
        var faccmod:Number = 0;
        faccmod += baseRangeAccuracy();
        if (player.hasKeyItem("Gun Scope") >= 0) faccmod += 40;
        if (player.hasKeyItem("Gun Scope with Aim tech") >= 0) faccmod += 60;
        if (player.hasKeyItem("Gun Scope with Aimbot") >= 0) faccmod += 80;
		faccmod += Math.round((masteryFirearmsLevel() - 1) / 2);
        if (player.weaponRangeName == "Touhouna M3") faccmod -= 20;
		if (player.weaponRangePerk == "Dual Firearms" || player.weaponRangePerk == "Dual 2H Firearms") faccmod += Math.round((dualWFLevel() - 1) / 2);
		if (player.weaponRangePerk == "Dual Firearms" || player.weaponRangePerk == "Dual 2H Firearms") faccmod += firearmsDualWieldAccuracyPenalty();
        return faccmod;
    }

    public function firearmsAccuracyPenalty():Number {
        var accfmodpenalty:Number = 10;
		if (player.hasPerk(PerkLib.LockAndLoad)) accfmodpenalty -= 5;
		if (player.hasMutation(IMutationsLib.HumanEyesIM) && player.perkv1(IMutationsLib.HumanEyesIM) >= 3 && player.racialScore(Races.HUMAN) > 17) {
			accfmodpenalty -= 5;
			if (player.perkv1(IMutationsLib.HumanEyesIM) >= 4) accfmodpenalty -= 5;
		}
        if (accfmodpenalty < 0) accfmodpenalty = 0;
        return accfmodpenalty;
    }

	public function firearmsDualWieldAccuracyPenalty():Number {
		var accfdwmodpenalty:Number = -25;
		if (player.weaponRange.hasSpecial("Dual Firearms")) {
			if (player.hasPerk(PerkLib.DualWieldFirearms)) accfdwmodpenalty += 10;
		}
        if (player.weaponRange.hasSpecial("Dual 2H Firearms")) {
			accfdwmodpenalty -= 50;
		}
        return accfdwmodpenalty;
	}

	public function firearmsDualWieldDamagePenalty():Number {
		var dmgfdwmodpenalty:Number = 1;
        if (player.weaponRange.hasSpecial("Dual Firearms")) {
			if (player.hasPerk(PerkLib.DualWieldFirearms)) dmgfdwmodpenalty -= 0.3;
			else dmgfdwmodpenalty -= 0.5;
		}
        if (player.weaponRange.hasSpecial("Dual 2H Firearms")) {
			dmgfdwmodpenalty -= 0.9;
		}
        return dmgfdwmodpenalty;
	}

    public function oneArrowTotalCost():Number {
        var onearrowcost:Number = 5;
        //additional arrow effects costs
        if (flags[kFLAGS.ELEMENTAL_ARROWS] >= 1 && flags[kFLAGS.ELEMENTAL_ARROWS] <= 8) onearrowcost += 3;
        if (flags[kFLAGS.CUPID_ARROWS] == 1) onearrowcost += 1;
        if (flags[kFLAGS.ENVENOMED_BOLTS] == 1) onearrowcost += 1;
		//cost increase (likely temporal until i make more rework on this)  //player.masteryArcheryLevel - maybe use that?
        if (player.level >= 48) onearrowcost *= 5;
        else onearrowcost *= Math.floor(player.level/12)+1;
        //Bow Shooting perk cost reduction
        if (player.hasPerk(PerkLib.BowShooting)) onearrowcost *= (1 - ((player.perkv1(PerkLib.BowShooting)) / 100));
        return onearrowcost;
    }

    public function oneThrowTotalCost():Number {
        var onearrowcost:Number = 25;
        return onearrowcost;
    }

    public function get weaponRangeAmmo():String {
        var ammoWord:String;
        switch (player.weaponRangeName) {
            case "Lactoblaster":
                ammoWord = "milky streams";
                break;
            case "Touhouna M3":
                ammoWord = "bullets";
                break;
            case "M1 Cerberus":
                ammoWord = "pellets";
                break;
            case "Harkonnen" :
                ammoWord = "shell";
                break;
            case "Harpoon gun" :
                ammoWord = "harpoon";
                break;
            default:
                ammoWord = "bullet";
                break;
        }
        if (player.weaponRangePerk == "Bow") ammoWord = "arrow";
        if (player.weaponRangePerk == "Crossbow") ammoWord = "bolt";
        if (player.weaponRangePerk == "Throwing") ammoWord = "projectile";
        return ammoWord;
    }

    /**
     * Use ranged weapon
     * 1. Check can use ranged weapon
     * 2. Check for multiple shots
     * 3. Get ammo description and check auto-miss
     * 4. Do the atack
     */
    public function fireBow():void {
        clearOutput();
        if (monster.hasStatusEffect(StatusEffects.BowDisabled)) {
            outputText("You can't use your range weapon right now!");
            menu();
            addButton(0, "Next", combatMenu, false);
            return;
        }
        if (player.hasStatusEffect(StatusEffects.TaintedMind)) {
            if (monster as DriderIncubus) taintedMindAttackAttempt();
            return;
        }
        //Incubus Scientist
        if (monster is IncubusScientist && (monster as IncubusScientist).ShieldHits > 0) {
            (monster as IncubusScientist).ShieldsHitRanged();
            enemyAIImpl();
            return;
        }
        flags[kFLAGS.LAST_ATTACK_TYPE] = LAST_ATTACK_BOW;
        var maxRangedAttacks:int = player.calculateMultiAttacks(false);

        if (player.vehicles == vehicles.HB_MECH) {
            if (player.hasKeyItem("HB Rapid Reload") >= 0) {
                if (player.keyItemvX("HB Rapid Reload", 1) == 1) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 4;
                else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
            }
            else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
        }
        else if (player.weaponRangePerk == ItemConstants.WT_BOW) {
            flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = Math.min((flags[kFLAGS.MULTISHOT_STYLE] || 0) + 1, maxRangedAttacks);
			if (player.isWoodElf() && player.hasPerk(PerkLib.ELFTwinShot)) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] *= (flags[kFLAGS.ELVEN_TWINSHOT_ENABLED] ? 2 : 1);
        }
        else if (player.weaponRangePerk == ItemConstants.WT_CROSSBOW) {
            flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = Math.min((flags[kFLAGS.MULTISHOT_STYLE] || 0) + 1, maxRangedAttacks);
            if (player.weaponRange == weaponsrange.AVELYNN) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] *= 3;
        }
        else if (player.weaponRangePerk == ItemConstants.WT_THROWING) {
            flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = Math.min((flags[kFLAGS.MULTISHOT_STYLE] || 0) + 1, maxRangedAttacks);
            /*if (flags[kFLAGS.MULTISHOT_STYLE] >= 2) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
            else if (flags[kFLAGS.MULTISHOT_STYLE] == 1) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
            else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 1;*/
        }
        else if (player.isFirearmTypeWeapon()) {
            /*if (flags[kFLAGS.MULTISHOT_STYLE] >= 3) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 4;
            else if (flags[kFLAGS.MULTISHOT_STYLE] == 2) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
            else if (flags[kFLAGS.MULTISHOT_STYLE] == 1) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
            else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 1; */
            flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = Math.min((flags[kFLAGS.MULTISHOT_STYLE] || 0) + 1, maxRangedAttacks);

			if (player.weaponRange == weaponsrange.GOODSAM || player.weaponRange == weaponsrange.BADOMEN) {
				var recoil:Number = 1;
				if (player.str >= 50) recoil += 1;
				if (player.str >= 100) recoil += 1;
				if (player.str >= 200) recoil += 1;
				flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = recoil;
			}
            else if (player.weaponRange == weaponsrange.TRFATBI || player.weaponRange == weaponsrange.HARPGUN || player.weaponRange == weaponsrange.TOUHOM3 || player.weaponRange == weaponsrange.DERPLAU || player.weaponRange == weaponsrange.DUEL_P_ || player.weaponRange == weaponsrange.FLINTLK) {
				if (flags[kFLAGS.MULTISHOT_STYLE] >= 1 && player.hasPerk(PerkLib.PrimedClipWarp)) {
					if (flags[kFLAGS.MULTISHOT_STYLE] >= 6) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 6;
					else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = flags[kFLAGS.MULTISHOT_STYLE];
				}
				else if (flags[kFLAGS.MULTISHOT_STYLE] >= 1 && player.hasPerk(PerkLib.TaintedMagazine)) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
				else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 1;
			}

            if ((player.weaponRange == weaponsrange.ADBSCAT || player.weaponRange == weaponsrange.ADBSHOT || player.weaponRange == weaponsrange.ALAKABL || player.weaponRange == weaponsrange.DALAKABL || player.weaponRange == weaponsrange.DBDRAGG) && flags[kFLAGS.MULTIPLE_ARROWS_STYLE] > 2) {
				if (flags[kFLAGS.MULTISHOT_STYLE] >= 3 && player.hasPerk(PerkLib.PrimedClipWarp)) {
					if (flags[kFLAGS.MULTISHOT_STYLE] >= 6) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 6;
					else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = flags[kFLAGS.MULTISHOT_STYLE];
				}
				else if (flags[kFLAGS.MULTISHOT_STYLE] >= 3 && player.hasPerk(PerkLib.TaintedMagazine)) {
					if (flags[kFLAGS.MULTISHOT_STYLE] >= 4) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 4;
					else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = flags[kFLAGS.MULTISHOT_STYLE];
				}
				else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
			}

            if ((player.weaponRange == weaponsrange.M1CERBE || player.weaponRange == weaponsrange.TM1CERB || player.weaponRange == weaponsrange.SNIPPLE) && flags[kFLAGS.MULTIPLE_ARROWS_STYLE] > 1)
                flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 1;
            
            if (player.isDualWieldRanged()) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] *= 2;

            if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 && player.hasPerk(PerkLib.LockAndLoad)) {
				/*if (flags[kFLAGS.MULTISHOT_STYLE] >= 3) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] += 2;
				else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] += 1;*/
                flags[kFLAGS.MULTIPLE_ARROWS_STYLE] += Math.floor(flags[kFLAGS.MULTIPLE_ARROWS_STYLE] / 2);
			}
        }
        if (flags[kFLAGS.ARROWS_ACCURACY] > 0) flags[kFLAGS.ARROWS_ACCURACY] = 0;
        var ammoWord:String = weaponRangeAmmo;
        //Keep logic sane if this attack brings victory
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
        if (checkConcentration("[monster name] easily glides around your attack" + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "s" : "") + " thanks to [monster his] complete concentration on your movements.\n\n")) return; //Amily concentration
        if (monster.hasStatusEffect(StatusEffects.Sandstorm) && rand(10) > 1) {
            outputText("Your attack" + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "s" : "") + " is blown off target by the tornado of sand and wind.  Damn!\n\n");
            enemyAIImpl();
            return;
        }
        //[Bow Response]
        if (monster is Isabella && !monster.hasStatusEffect(StatusEffects.Stunned)) {
            if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind)) {
                outputText("Isabella hears the shot" + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "s" : "") + " and turns her shield towards " + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "them" : "it") + ", completely blocking " + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "them" : "it") + " with her wall of steel.\n\n");
            } else {
                outputText("Your " + ammoWord + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "s" : "") + " thunks into Isabella's shield, completely blocked by the wall of steel.\n\n");
            }
            if (SceneLib.isabellaFollowerScene.isabellaAccent())
                outputText("\"<i>You remind me of ze horse-people.  Zey cannot deal vith mein shield either!</i>\" cheers Isabella.\n\n");
            else outputText("\"<i>You remind me of the horse-people.  They cannot deal with my shield either!</i>\" cheers Isabella.\n\n");
            enemyAIImpl();
            return;
        }
        //worms are immune
        if (monster is WormMass) {
            outputText("The " + ammoWord + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "s" : "") +" slips between the worms, sticking into the ground.\n\n");
            enemyAIImpl();
            return;
        }
        //Vala miss chance!
        if (monster is Vala && rand(10) < 7 && !monster.hasStatusEffect(StatusEffects.Stunned)) {
            outputText("Vala flaps her wings and twists her body. Between the sudden gust of wind and her shifting of position, the " + ammoWord + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "s" : "") +" goes wide.\n\n");
            enemyAIImpl();
            return;
        }
        //Blind miss chance
        if (player.playerIsBlinded()) {
            outputText("The " + ammoWord + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "s" : "") +" hits something, but blind as you are, you don't have a chance in hell of hitting anything with a " + player.weaponRangeName + ".\n\n");
            enemyAIImpl();
            return;
        }
        if (monster is Lethice && monster.hasStatusEffect(StatusEffects.Shell)) {
            outputText("Your " + ammoWord + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "s" : "") +" pings of the side of the shield and spins end over end into the air. Useless.\n\n");
            enemyAIImpl();
            return;
        }
        if (player.isBowTypeWeapon() || player.isCrossbowTypeWeapon()) {
            if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) outputText("Your bow nudges as you ready the next shot, helping you keep your aimed at [monster name].\n\n");
            multiArrowsStrike(0);
        }
        else if (player.isThrownTypeWeapon()){
            if (player.hasPerk(PerkLib.Telekinesis)) {
                outputText("Weapons begins to float around you as you draw several projectiles from your arsenal using your powers.\n\n");
                TelekinesisThrow();
                outputText(" Adding to the initial attack, you begin grab additional [weaponrange] before taking aim.\n\n");
            }
            throwWeapon();
        }
        else if (player.isFirearmTypeWeapon()) shootWeapon();
    }

    /**
     * Do bow/crossbow/mech ranged attack
     * 1. Check accuracy
     * 2. Attack
     * - Get base damage: Bow is speed based, crossbow and mech based on weapon damage
     * - Miss if no damage
     * - Describe shot
     * - bonus from weapon, archery mastery & skill, perks, items, fletching table, weapon modifiers, elemental arrows, ranged perks
     * - check crit
     * - do damage, apply status effects
     * 3. Repeat if Multi-shot style > 1
     */
    public function multiArrowsStrike(type:Number = 0):void {
        var accRange:Number = 0;
        accRange += (arrowsAccuracy() / 2);
        if (flags[kFLAGS.ARROWS_ACCURACY] > 0) accRange -= flags[kFLAGS.ARROWS_ACCURACY];
        if (player.weaponRange == weaponsrange.BOWGUID || player.vehicles == vehicles.HB_MECH) accRange = 100;
        var weaponRangePerk:String = player.weaponRangePerk;
        var ammoWord:String = weaponRangeAmmo;
        if (rand(100) < accRange) {
            var damage:Number = 0;
			/*if (player.vehicles == vehicles.HB_MECH) {
				if (player.hasKeyItem("HB Rapid Reload") >= 0) {
					if (player.inte < 201) player.weaponRangeAttack *= (1 + (player.inte / 200));
					else player.weaponRangeAttack *= 2;
					if (player.keyItemvX("HB Rapid Reload", 1) == 1) {
						player.weaponRangeAttack *= 1.25;
						damage += player.spe;
						damage += scalingBonusSpeed() * 0.2;
					}
					player.weaponRangeAttack = Math.round(player.weaponRangeAttack);
				}
				damage += player.weaponRangeAttack * 20;
				damage += player.spe * 2;
				damage += scalingBonusSpeed() * 0.4;
			}
			else {
				if (isBowTypeWeapon()) damage = rangeDamageNoLagSingle(0);
				else if (isCrossbowTypeWeapon()) damage = rangeDamageNoLagSingle(1);
			}*/
            if (player.isBowTypeWeapon()) damage = rangeDamageNoLagSingle(0);
			else if (player.isCrossbowTypeWeapon()) damage = rangeDamageNoLagSingle(1);

            if (damage == 0) {
                if (monster.inte > 0) {
                    outputText("[Themonster] shrugs as the " + ammoWord + " bounces off them harmlessly.\n\n");
                } else {
                    outputText("The " + ammoWord + " bounces harmlessly off [themonster].\n\n");
                }
            }

            if (!MSGControll) {
                if (monster is EncapsulationPod) {
                    outputText("The " + ammoWord + " lodges deep into the pod's fleshy wall");
                } else if (monster.plural) {
                    var textChooser1:int = rand(12);
                    if (textChooser1 >= 9) {
                        outputText("[Themonster] look down at the " + ammoWord + " that now protrudes from one of [monster his] bodies");
                    } else if (textChooser1 >= 6 && textChooser1 < 9) {
                        outputText("You pull an " + ammoWord + " and fire it at one of [themonster]");
                    } else if (textChooser1 >= 3 && textChooser1 < 6) {
                        outputText("With one smooth motion you draw, nock, and fire your deadly " + ammoWord + " at one of your opponents");
                    } else {
                        outputText("You casually fire an " + ammoWord + " at one of [themonster]");
                    }
                } else {
                    var textChooser2:int = rand(12);
                    if (textChooser2 >= 9) {
                        outputText("[Themonster] looks down at the " + ammoWord + " that now protrudes from [monster his] body");
                    } else if (textChooser2 >= 6) {
                        outputText("You pull an " + ammoWord + " and fire it at [themonster]");
                    } else if (textChooser2 >= 3) {
                        outputText("With one smooth motion you draw, nock, and fire your deadly " + ammoWord + " at your opponent");
                    } else {
                        outputText("You casually fire an " + ammoWord + " at [themonster]");
                    }
                }
            }
            if (player.isInNonGoblinMech()) {
                if (player.vehicles == vehicles.HB_MECH) {
                    if (player.armor == armors.HBARMOR) damage *= 1.5;
                    if (player.headJewelry == headjewelries.HBHELM) damage *= 1.2;
                    if (player.upperGarment == undergarments.HBSHIRT) damage *= 1.1;
                    if (player.lowerGarment == undergarments.HBSHORT) damage *= 1.1;
                    if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) damage *= 1.25;
                }
                else {
                    if (player.armor == armors.HBARMOR) damage *= 1.2;
                    if (player.headJewelry == headjewelries.HBHELM) damage *= 1.1;
                    if (player.upperGarment == undergarments.HBSHIRT) damage *= 1.05;
                    if (player.lowerGarment == undergarments.HBSHORT) damage *= 1.05;
                }
            }
            if (player.isBowTypeWeapon()){
                if (player.hasPerk(PerkLib.ElvenRangerArmor)) damage *= 1.5;
                if (player.isElf() && player.hasPerk(PerkLib.ELFArcherCovenant) && player.isSpearTypeWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) damage *= 1.25;
            }
            if (player.isBowTypeWeapon() && player.hasStatusEffect(StatusEffects.FletchingTable)) {
                if (player.statusEffectv1(StatusEffects.FletchingTable) > 0) damage *= (1 + (0.1 * player.statusEffectv1(StatusEffects.FletchingTable)));
                if (player.statusEffectv2(StatusEffects.FletchingTable) > 0) damage *= (1 + (0.1 * player.statusEffectv2(StatusEffects.FletchingTable)));
                if (player.hasPerk(PerkLib.CraftedArrows)) {
                    if (player.perkv4(PerkLib.CraftedArrows) > 0) {
                        player.addPerkValue(PerkLib.CraftedArrows, 4, -1);
                        damage *= 1.4;
                    }
                    else if (player.perkv3(PerkLib.CraftedArrows) > 0) {
                        player.addPerkValue(PerkLib.CraftedArrows, 3, -1);
                        damage *= 1.3;
                    }
                    else if (player.perkv2(PerkLib.CraftedArrows) > 0) {
                        player.addPerkValue(PerkLib.CraftedArrows, 2, -1);
                        damage *= 1.2;
                    }
                    else if (player.perkv1(PerkLib.CraftedArrows) > 0) {
                        player.addPerkValue(PerkLib.CraftedArrows, 1, -1);
                        damage *= 1.1;
                    }
                    else player.removePerk(PerkLib.CraftedArrows);
                }
            }
            //Section for item damage modifiers
            if (player.weaponRange is WildHunt && (player.level + playerLevelAdjustment()) > monster.level) damage *= 2;
            if (player.weaponRange == weaponsrange.BOWHODR && monster.hasStatusEffect(StatusEffects.Blind)) damage *= 1.1;
            if (flags[kFLAGS.ELEMENTAL_ARROWS] > 0) damage = elementalArrowDamageMod(damage);
			//Determine if critical hit!
            var crit:Boolean;
            var critChance:Number = 0;
			var critDamage:Number = 0;
            if (player.isInNonGoblinMech() || player.isInGoblinMech()) {
				critChance += calculateCritFirearms();
				critDamage += calculateCritDamageFirearms();
			}
			else {
				critChance += calculateCritRange();
				critDamage += calculateCritDamageRange();
			}
			crit = rand(100) < critChance;
            if(crit) damage *= critDamage;
            damage = Math.round(damage);
            if (monster.HP <= monster.minHP()) {
                if (monster is EncapsulationPod)
                    outputText(". ");
                else if (monster.plural)
                    outputText(" and [monster he] stagger, collapsing onto each other from the wounds you've inflicted on [monster him]. ");
                else outputText(" and [monster he] staggers, collapsing from the wounds you've inflicted on [monster him]. ");
                if (type == 1) doArcheryDamage(damage, 1);
                else doArcheryDamage(damage, 0);
                if (crit) outputText(" <b>*Critical Hit!*</b>");
				archeryXP(rangeMasteryEXPgained(crit));
                outputText("\n\n");
				WeaponRangeStatusProcs();
                checkAchievementDamage(damage);
                flags[kFLAGS.ARROWS_SHOT]++;
                doNext(endHpVictory);
                return;
            } else {
                if (rand(100) < 15 && player.weaponRange is Artemis && !monster.hasStatusEffect(StatusEffects.Blind)) {
                    monster.createStatusEffect(StatusEffects.Blind, 3, 0, 0, 0);
                    if (!MSGControll) outputText(",  your radiant shots blinded [monster him]");
                    else outputText("Your radiant shots blinded [monster him]");
                }
                if (!MSGControll) outputText(".  It's clearly very painful. ");
				if (type == 1) doArcheryDamage(damage, 1);
                else doArcheryDamage(damage, 0);
                archeryXP(rangeMasteryEXPgained(crit));
                if (crit) outputText(" <b>*Critical Hit!*</b>");
				WeaponRangeStatusProcs();
				WrathGenerationPerHit1(5);
                heroBaneProc(damage);
            }
            cupidArrowsEffect();
            if ((flags[kFLAGS.ENVENOMED_BOLTS] == 1 && player.tailVenom >= player.VenomWebCost()) || (flags[kFLAGS.ELVEN_THORNSHOT_ENABLED] == 1 && player.isWoodElf() && player.mana >= 10)) {
                if (!MSGControll) outputText("  ");
                if (monster.lustVuln == 0) {
                    if (!MSGControll) outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
                }
                if (flags[kFLAGS.ELVEN_THORNSHOT_ENABLED] == 1 && player.isWoodElf() && player.mana >= 10) {
                    player.mana -= 10;
					var lustDMG:Number = 35 + rand(player.lib / 10);
					if (player.hasPerk(PerkLib.VegetalAffinity)) lustDMG *= 1.5;
					if (player.hasPerk(PerkLib.GreenMagic)) lustDMG *= 2;
					if (player.hasStatusEffect(StatusEffects.GreenCovenant)) lustDMG *= 2;
					if (player.armor == armors.ELFDRES && player.isElf()) lustDMG *= 2;
					if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDMG *= 2;
					lustDMG = Math.round(monster.lustVuln * lustDMG);
					monster.teased(lustDMG, false);
					combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
					if (player.hasPerk(PerkLib.VerdantLeech)) {
						if (monster.lustVuln != 0 && !monster.hasPerk(PerkLib.EnemyTrueAngel)) monster.lustVuln += 0.01;
						HPChange(Math.round(player.maxHP() * 0.05), false);
					}
					if (monster.hasStatusEffect(StatusEffects.Rosethorn) && monster.statusEffectv1(StatusEffects.Rosethorn) < 6) monster.addStatusValue(StatusEffects.Rosethorn, 1, 1);
					else monster.createStatusEffect(StatusEffects.Rosethorn, 6, 0, 0, 0);
                }
                if (player.tailType == Tail.BEE_ABDOMEN) {
                    if (!MSGControll) outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
                    var damage1B:Number = 35 + rand(player.lib / 10);
					var damage1Ba:Number = 1;
					if (player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) damage1B += scalingBonusToughness() * 0.5;
                    if (player.level < 10) damage1B += 20 + (player.level * 3);
                    else if (player.level < 20) damage1B += 50 + (player.level - 10) * 2;
                    else if (player.level < 30) damage1B += 70 + (player.level - 20) * 1;
                    else damage1B += 80;
                    damage1B *= 0.2;
					if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
						damage1B *= 2;
						damage1Ba *= 2;
					}
                    if (player.armor == armors.ELFDRES && player.isElf()) damage1B *= 2;
                    if (player.armor == armors.FMDRESS && player.isWoodElf()) damage1B *= 2;
                    monster.teased(damage1B);
                    if (monster.hasStatusEffect(StatusEffects.BeeVenom)) {
                        monster.addStatusValue(StatusEffects.BeeVenom, 3, damage1Ba);
                    } else monster.createStatusEffect(StatusEffects.BeeVenom, 0, 0, damage1Ba, 0);
					if (player.hasPerk(PerkLib.ToxineMaster)) monster.statStore.addBuffObject({tou:-5}, "Poison",{text:"Poison"});
                    player.tailVenom -= player.VenomWebCost();
					flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                }
                if (player.tailType == Tail.SCORPION || player.hasKeyItem("Sky Poison Pearl") >= 0) {
                    if (!MSGControll) outputText("  [monster he] seems to be effected by the poison, its movements slowing rapidly.");
					var DBP:Number = 2;
					var DBPa:Number = 1;
					if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
						DBP *= 2;
						DBPa *= 2;
					}
					if (player.hasPerk(PerkLib.ToxineMaster)) monster.statStore.addBuffObject({tou:-(DBP+5), spe:-DBP}, "Poison",{text:"Poison"});
                    else monster.statStore.addBuffObject({tou:-DBP, spe:-DBP}, "Poison",{text:"Poison"});
                    if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                        monster.addStatusValue(StatusEffects.NagaVenom, 3, DBPa);
                    } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, DBPa, 0);
                    if (player.hasPerk(PerkLib.WoundPoison)){
                        if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                        else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
                    }
                    player.tailVenom -= player.VenomWebCost();
					flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                }
                if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
                    if (!MSGControll) outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
                    var lustdamage:Number = 35 + rand(player.lib / 10);
					var DBPaa:Number = 1;
                    if (player.level < 10) lustdamage += 20 + (player.level * 3);
                    else if (player.level < 20) lustdamage += 50 + (player.level - 10) * 2;
                    else if (player.level < 30) lustdamage += 70 + (player.level - 20) * 1;
                    else lustdamage += 80;
                    lustdamage *= 0.14;
					if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
						lustdamage *= 2;
						DBPaa *= 2;
					}
                    if (player.armor == armors.ELFDRES && player.isElf()) lustdamage *= 2;
                    if (player.armor == armors.FMDRESS && player.isWoodElf()) lustdamage *= 2;
                    monster.teased(lustdamage, false);
					if (player.hasPerk(PerkLib.ToxineMaster)) DBPaa += 2.5;
                    monster.statStore.addBuffObject({tou:-(DBPaa*2)}, "Poison",{text:"Poison"});
                    if (monster.hasStatusEffect(StatusEffects.ManticoreVenom)) {
                        monster.addStatusValue(StatusEffects.ManticoreVenom, 3, DBPaa);
                    } else monster.createStatusEffect(StatusEffects.ManticoreVenom, 0, 0, DBPaa, 0);
                    player.tailVenom -= player.VenomWebCost();
					flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                }
                if (player.faceType == Face.SNAKE_FANGS) {
                    if (!MSGControll) outputText("  [monster he] seems to be effected by the poison, its movements slowing down.");
					var DBPaaa:Number = 1;
					if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) DBPaaa *= 2;
					if (player.hasPerk(PerkLib.ToxineMaster)) monster.statStore.addBuffObject({tou:-5, spe:-DBPaaa}, "Poison",{text:"Poison"});
					else monster.statStore.addBuffObject({spe:-DBPaaa}, "Poison",{text:"Poison"});
                    var venomType:StatusEffectType = StatusEffects.NagaVenom;
                    if (player.racialScore(Races.NAGA) >= 23) venomType = StatusEffects.ApophisVenom;
                    if (monster.hasStatusEffect(venomType)) {
                        monster.addStatusValue(venomType, 2, 0.4);
                        monster.addStatusValue(venomType, 1, (DBPaaa * 0.4));
                    } else monster.createStatusEffect(venomType, (DBPaaa * 0.4), 0.4, 0, 0);
                    if (player.hasPerk(PerkLib.WoundPoison)){
                        if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                        else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
                    }
                    player.tailVenom -= player.VenomWebCost();
					flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                }
                if (player.faceType == Face.SPIDER_FANGS) {
                    if (player.lowerBody == LowerBody.ATLACH_NACHA){
                        if (!MSGControll) outputText("  [monster he] seems to be affected by the poison, showing increasing sign of weakness and arousal.");
                        var damage2B:Number = 35 + rand(player.lib / 10);
                        var poisonScaling:Number = 1;
						var damage2Ba:Number = 1;
                        poisonScaling += player.lib/100;
                        poisonScaling += player.tou/100;
                        if (player.level < 10) damage2B += 20 + (player.level * 3);
                        else if (player.level < 20) damage2B += 50 + (player.level - 10) * 2;
                        else if (player.level < 30) damage2B += 70 + (player.level - 20) * 1;
                        else damage2B += 80;
                        damage2B *= 0.2;
                        damage2B *= 1 + (poisonScaling / 10);
						if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
							damage2B *= 2;
							damage2Ba *= 2;
						}
                        if (player.armor == armors.ELFDRES && player.isElf()) damage2B *= 2;
                        if (player.armor == armors.FMDRESS && player.isWoodElf()) damage2B *= 2;
                        monster.teased(damage2B);
						if (player.hasPerk(PerkLib.ToxineMaster)) poisonScaling += 5;
                        monster.statStore.addBuffObject({tou:-poisonScaling}, "Poison",{text:"Poison"});
                        if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                            monster.addStatusValue(StatusEffects.NagaVenom, 3, damage2Ba);
                        } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, damage2Ba, 0);
                        if (player.hasPerk(PerkLib.WoundPoison)){
                            if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                            else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
                        }
                        player.tailVenom -= player.VenomWebCost();
						flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                    }
                    else{
                        if (!MSGControll) outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
                        var lustDmg:int = 6 * monster.lustVuln;
						if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) lustDmg *= 2;
                        if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
                        if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
                        monster.teased(lustDmg);
                        if (monster.lustVuln > 0 && !monster.hasPerk(PerkLib.EnemyTrueAngel)) {
                            monster.lustVuln += 0.01;
                            if (monster.lustVuln > 1) monster.lustVuln = 1;
                        }
                        player.tailVenom -= player.VenomWebCost();
						if (player.hasPerk(PerkLib.ToxineMaster)) monster.statStore.addBuffObject({tou:-5}, "Poison",{text:"Poison"});
						flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                    }
                }
                if (monster.lust >= monster.maxOverLust()) {
                    outputText("\n\n");
                    checkAchievementDamage(damage);
                    flags[kFLAGS.ARROWS_SHOT]++;
                    doNext(endLustVictory);
                }
                if (!MSGControll) outputText("\n");
            }
            else if (flags[kFLAGS.ENVENOMED_BOLTS] == 1 && player.tailVenom < player.VenomWebCost()) {
				if (player.hasPerk(PerkLib.ToxineMaster) && player.hasKeyItem("Sky Poison Pearl") >= 0) {
                    if (!MSGControll) outputText("  [monster he] seems to be affected by the poison, showing increasing sign of weakness.\n");
					monster.statStore.addBuffObject({tou:-5}, "Poison",{text:"Poison"});
				}
				else outputText("  You do not have enough venom to apply on the " + ammoWord + " tip!\n");
			}
            if (player.weaponRangeName == "Hodr's bow" && !monster.hasStatusEffect(StatusEffects.Blind)) monster.createStatusEffect(StatusEffects.Blind, 1, 0, 0, 0);
            if (!MSGControll) outputText("\n");
            if (flags[kFLAGS.ARROWS_SHOT] >= 1) EngineCore.awardAchievement("Arrow to the Knee", kACHIEVEMENTS.COMBAT_ARROW_TO_THE_KNEE);
            flags[kFLAGS.ARROWS_SHOT]++;
			WrathWeaponsProc();
        } else {
            if (monster is DisplacerBeast) outputText("The displacer beast teleports, dodging your attack.\n");
            else {
                outputText("The " + ammoWord + " goes wide, disappearing behind your foe");
                if (monster.plural) outputText("s");
                outputText(".\n\n");
            }
        }
        if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 1) { //Lethice waits till after your last arrow to put up her shield, how nice
            if (monster is Lethice && (monster as Lethice).fightPhase == 3) {
                outputText("\n\n<i>\"Ouch. Such a cowardly weapon,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your pathetic " + ammoWord + "s?\"</i>\n\n");
                monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
            }
            if (MSGControll) outputText("\n\n");
            enemyAIImpl();
        }
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxOverLust()) {
            doNext(endLustVictory);
            return;
        }
        MSGControll = true;
        if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) {
            flags[kFLAGS.MULTIPLE_ARROWS_STYLE]--;
            flags[kFLAGS.ARROWS_ACCURACY] += arrowsAccuracyPenalty();
            multiArrowsStrike(type);
        }
    }

    public function archerySkillDamageMod(damage:Number):Number {
        if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
            if (player.statusEffectv1(StatusEffects.Kelt) < 100) damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
            else {
                if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
                    if (player.statusEffectv1(StatusEffects.Kindra) < 150) damage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
                    else damage *= 3.5;
                } else damage *= 2;
            }
        }
        return damage;
    }

    public function doArcheryDamage(damage:Number, type:Number = 0):void {
        var ignoreDR:Boolean = ((player.hasPerk(PerkLib.DeadlyAim) && type == 0) || (player.hasPerk(PerkLib.Penetrator) && type == 1));
        if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			doFireDamage(damage, true, true, ignoreDR);
		}
        else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			doIceDamage(damage, true, true, ignoreDR);
		}
        else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 3) {
			doLightningDamage(damage, true, true, ignoreDR);
		}
        else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 4) {
			doDarknessDamage(damage, true, true, ignoreDR);
		}
        else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 5) {
			doWaterDamage(damage, true, true, ignoreDR);
		}
        else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 6) {
			doWindDamage(damage, true, true, ignoreDR);
		}
        else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 7) {
			doEarthDamage(damage, true, true, ignoreDR);
		}
        else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 8) {
			doAcidDamage(damage, true, true, ignoreDR);
		}
        else {
			doPhysicalDamage(damage, true, true, ignoreDR);
		}
		if (player.statStore.hasBuff("FoxflamePelt")) {
			doFireDamage((damage*2), true, true, ignoreDR);
			monster.teased((monster.lustVuln * (10 + player.cor / 8)), false);
		}
        if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) {
			doMagicDamage(Math.round(damage * 0.2), true, true, ignoreDR);
		}
    }

    public function elementalArrowDamageMod(damage:Number):Number {
        damage += Math.round(player.inte * 0.1);
        if (player.inte >= 50) damage += Math.round(player.inte * ((player.inte / 50) * 0.05));
        if (player.weaponRange is Artemis) damage *= 1.5;
        if (player.armorName == "FrancescaCloak") damage *= 2;
        switch (flags[kFLAGS.ELEMENTAL_ARROWS]) {
            case 1:
                damage *= fireDamageBoostedByDao();
                break;
            case 2:
                damage *= iceDamageBoostedByDao();
                break;
            case 3:
                damage *= lightningDamageBoostedByDao();
                break;
            case 4:
                damage *= darknessDamageBoostedByDao();
                break;
            case 5:
                damage *= waterDamageBoostedByDao();
                break;
            case 6:
                damage *= windDamageBoostedByDao();
                break;
            case 7:
                damage *= earthDamageBoostedByDao();
                break;
            case 8:
                damage *= acidDamageBoostedByDao();
                break;
        }
        return damage;
    }

    public function cupidArrowsEffect():void {
        if (flags[kFLAGS.CUPID_ARROWS] == 1) {
            outputText("  ");
            if (monster.lustVuln == 0) {
                if ((MDOCount == maxCurrentRangeAttacks()) && (MSGControll)) outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.");
            } else {
                var lustArrowDmg:Number = lustDamageCalc();
                if (!MSGControll) {
                    if (monster.lust < (monster.maxLust() * 0.3)) outputText("[Themonster] squirm[monster s] as the magic affects [monster him].  ");
                    else if (monster.lust < (monster.maxLust() * 0.6)) {
                        outputText("[Themonster] stagger[monster s], suddenly weak and having trouble focusing on staying upright.  ");
                    } else {
                        outputText("[Themonster]'[monster s]");
                        outputText(" eyes glaze over with desire for a moment.  ");
                    }
                }
                lustArrowDmg *= 0.25;
                lustArrowDmg = Math.round(lustArrowDmg);
                monster.teased(lustArrowDmg, false, true);
                if (monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
            }
        }
    }

    public function bowPerkUnlock():void {
        if (flags[kFLAGS.ARROWS_SHOT] >= 10 && !player.hasPerk(PerkLib.BowShooting)) {
            outputText("<b>You've become more comfortable with using a bow, unlocking the Bow Shooting perk and reducing fatigue cost of bow related specials by 20%!</b>\n\n");
            player.createPerk(PerkLib.BowShooting, 20, 0, 0, 0);
        }
        if (flags[kFLAGS.ARROWS_SHOT] >= 30 && player.perkv1(PerkLib.BowShooting) < 40) {
            outputText("<b>You've become more comfortable with using a bow, further reducing cost of bow related specials by an additional 20%!</b>\n\n");
            player.setPerkValue(PerkLib.BowShooting, 1, 40);
        }
        if (flags[kFLAGS.ARROWS_SHOT] >= 90 && player.perkv1(PerkLib.BowShooting) < 60) {
            outputText("<b>You've become more comfortable with using a bow, further reducing cost of bow related specials by an additional 20%!</b>\n\n");
            player.setPerkValue(PerkLib.BowShooting, 1, 60);
        }
        if (flags[kFLAGS.ARROWS_SHOT] >= 270 && player.perkv1(PerkLib.BowShooting) < 80) {
            outputText("<b>You've become more comfortable with using a bow, further reducing cost of bow related specials by an additional 20%!</b>\n\n");
            player.setPerkValue(PerkLib.BowShooting, 1, 80);
        }
    }
	
	public function doThrowPierceDamage(damage:Number):void {
		doThrowDamage(damage);
		if (player.hasPerk(PerkLib.PenetratingThrow) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) {
			if (rand(100) > 74) {
				doThrowDamage(damage);
				if (rand(100) > 64) {
					doThrowDamage(damage);
					if (rand(100) > 54) {
						doThrowDamage(damage);
						if (rand(100) > 44) {
							doThrowDamage(damage);
							if (monster.hasPerk(PerkLib.EnemyLargeGroupType) && rand(100) > 34) {
								doThrowDamage(damage);
								if (rand(100) > 24) {
									doThrowDamage(damage);
									if (rand(100) > 14) {
										doThrowDamage(damage);
										if (rand(100) > 4) doThrowDamage(damage);
									}
								}
							}
						}
					}
				}
			}
		}
	}
	public function doThrowDamage(damage:Number):void {
		if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) {
			if (player.weaponRange == weaponsrange.RTKNIFE) {
				damage = Math.round(damage * fireDamageBoostedByDao());
				doFireDamage(damage, true, true);
			}
			else if (player.weaponRange == weaponsrange.STKNIFE) {
				damage = Math.round(damage * iceDamageBoostedByDao());
				doIceDamage(damage, true, true);
			}
			else if (player.weaponRange == weaponsrange.TTKNIFE) {
				damage = Math.round(damage * lightningDamageBoostedByDao());
				doLightningDamage(damage, true, true);
			}
			else if (player.weaponRange == weaponsrange.ATKNIFE) {
				damage = Math.round(damage * darknessDamageBoostedByDao());
				doDarknessDamage(damage, true, true);
			}
			else {
				doPhysicalDamage(damage, true, true);
				doMagicDamage(Math.round(damage * 0.2), true, true);
			}
		}
		else if (player.statStore.hasBuff("FoxflamePelt")) {
			doFireDamage((damage * 2), true, true);
			if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) doMagicDamage(Math.round(damage * 0.2), true, true);
			monster.teased((monster.lustVuln * (10 + player.cor / 8)), false);
		}
		else doPhysicalDamage(damage, true, true);
	}

    /**
     * Elemental range attack from Elemental Body or Moonlight Greatsword
     */
    public function throwElementalAttack():void {
        clearOutput();
        var damage:Number = 0;
		damage += player.str;
		var crit:Boolean = false;
		var critChance:int = 5;
		var critDmg:Number = 1.75;
		critChance += combatPhysicalCritical();
		if (player.weapon == weapons.MGSWORD || player.weapon == weapons.MCLAWS || player.weapon is Tidarion) {
            if (player.weapon is Tidarion) meleeDamageNoLag = 0; //recalc damage
            if (meleeDamageNoLag != 0) damage += meleeDamageNoLag;
            else {
                var temp:Number = meleeDamageNoLagSingle();
                meleeDamageNoLag += temp;
                damage += temp;
            }
			//Determine if critical hit!
            critChance += 10;
            if (player.hasPerk(PerkLib.WeaponMastery) && player.weapon.isSingleLarge() && player.str >= 100) critChance += 10;
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
            if (rand(100) < critChance) {
                crit = true;
				critDmg += bonusCriticalDamageFromMissingHP();
                if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= (critDmg * impaleMultiplier());
				else damage *= critDmg;
            }
		}
		else {
			damage += ghostStrength();
			damage += scalingBonusStrength() * 0.4;
			if (player.hasPerk(PerkLib.Telekinesis)){
				damage += player.inte;
				damage += scalingBonusIntelligence() * 0.4;
			}
			if (damage < 20) damage = 20;
			if (player.hasPerk(PerkLib.DeadlyThrow)) damage += player.spe;
			damage *= 1.5;
			damage *= (1 + (0.01 * masteryThrowingLevel()));
			//Determine if critical hit!
			if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
			if (player.hasPerk(PerkLib.AnatomyExpert)) critChance += 10;
			if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				if (player.hasPerk(PerkLib.AnatomyExpert)) critDmg += 0.5;
				if (player.hasPerk(PerkLib.PrestigeJobStalker)) critDmg += 0.2;
				damage *= critDmg;
			}
			if (player.hasPerk(PerkLib.PrestigeJobStalker)) damage *= 1.2;
			damage *= player.jewelryRangeModifier();
			damage = statusEffectBonusDamage(damage);
            if (player.hasPerk(PerkLib.Ghostslinger)) damage *= 1.15;
            damage = archerySkillDamageMod(damage);
		}
        damage = Math.round(damage);
        checkAchievementDamage(damage);
		var elementalVariant:Number = ElementalRace.getElement(player);
		if (player.weapon == weapons.MGSWORD) elementalVariant = 5;
		if (player.weapon == weapons.MCLAWS) elementalVariant = 5;
        if (player.weapon is Tidarion) elementalVariant = 6;
        switch (elementalVariant) {
            case ElementalRace.ELEMENT_SYLPH:
                outputText("You form and unleash a wind blade. ");
                damage = magic.calcGaleModImpl(damage, true);
                damage *= windDamageBoostedByDao();
				doWindDamage(damage, true, true);
                break;
            case ElementalRace.ELEMENT_GNOME:
                outputText("You launch a huge rock. ");
                damage = magic.calcQuakeModImpl(damage, true);
                damage *= earthDamageBoostedByDao();
				doEarthDamage(damage, true, true);
                break;
            case ElementalRace.ELEMENT_IGNIS:
                outputText("You charge and toss a fireball. ");
				damage = magic.calcInfernoModImpl(damage, true);
                damage *= fireDamageBoostedByDao();
				doFireDamage(damage, true, true);
                break;
            case ElementalRace.ELEMENT_UNDINE:
                outputText("You unleash an arrow of lethally pressurized water. ");
				damage = magic.calcTideModImpl(damage, true);
                damage *= waterDamageBoostedByDao();
				doWaterDamage(damage, true, true);
                break;
            case 5:
                outputText("You form and unleash a wave of moonlight. ");
				doMagicDamage(damage, true, true);
                break;
            case 6:
                outputText("You point your flame sword at the enemy, shooting a searing ray from its tip. ");
                damage *= fireDamageBoostedByDao();
                doFireDamage(damage, true, true);
                break;
            default:
                outputText("You form and unleash a wind blade. ");
                damage *= windDamageBoostedByDao();
				doWindDamage(damage, true, true);
                break;
        }
		if (player.weapon == weapons.MGSWORD || player.weapon == weapons.MCLAWS || player.weapon is Tidarion) {
			var critCounter:int = 0;
			if (crit) critCounter++;
			meleeMasteryGain(1,critCounter);
            if (player.weapon is Tidarion) (player.weapon as Tidarion).afterStrike();
		}
		else {
			if (crit) outputText(" <b>*Critical Hit!*</b>");
			throwingXP(rangeMasteryEXPgained(crit));
		}
		if (player.hasPerk(PerkLib.ImpactThrow) && rand(10) == 0) {
            outputText(" Attack leaves your opponent dazed!");
            monster.createStatusEffect(StatusEffects.Stunned, 1,0,0,0);
		}
		WrathGenerationPerHit1(5);
        heroBaneProc(damage);
        if (monster.HP <= monster.minHP()) {
            if (monster.plural) outputText(" [monster He] stagger, collapsing onto each other from the wounds you've inflicted on [monster him].");
            else outputText(" [monster He] staggers, collapsing from the wounds you've inflicted on [monster him].");
            outputText("\n\n");
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxOverLust()) {
            doNext(endLustVictory);
            return;
        }
		outputText(" It's clearly very painful.\n\n");
        enemyAIImpl();
    }

    /**
     * Additional thrown weapons from Telekinesis perk
     */
    public function TelekinesisThrow():void {
        var fc:Number = oneThrowTotalCost();
        var accRange:Number = 0;
        var numberOfExtraShots:Number = Math.max(2, Math.round(player.level / 15));
        var currentShot:Number = 0;
        var hasCritAtLeastOnce:Boolean = false
        var hasMissedAtLeastOnce:Boolean = false
        accRange += (throwingAccuracy() / 2);
        if (flags[kFLAGS.ARROWS_ACCURACY] > 0) accRange -= flags[kFLAGS.ARROWS_ACCURACY];
        if (player.hasPerk(PerkLib.PhantomShooting)) {
            if (player.weaponRange != weaponsrange.SHUNHAR && player.weaponRange != weaponsrange.KSLHARP && player.weaponRange != weaponsrange.LEVHARP) player.takePhysDamage(fc);
        } else {
            if (player.weaponRange != weaponsrange.SHUNHAR && player.weaponRange != weaponsrange.KSLHARP && player.weaponRange != weaponsrange.LEVHARP) player.ammo--;
            fatigue(fc);
        }
        outputText("You use your spiritual powers to launch a rain of floating [weaponrange] at [themonster].");
        while (currentShot < numberOfExtraShots) {
            if (rand(100) < accRange) {
                var damage:Number = 0;
				damage += rangeDamageNoLagSingle(2);
				damage *= 1.5;
                //Weapon addition!
                if (player.weaponRange == weaponsrange.KSLHARP || player.weaponRange == weaponsrange.GOODSAM || Forgefather.purePearlEaten) {
                    damage = monsterPureDamageBonus(damage);
                }
                if (player.weaponRange == weaponsrange.LEVHARP || player.weaponRange == weaponsrange.BADOMEN || Forgefather.lethiciteEaten) {
                    damage = monsterCorruptDamageBonus(damage);
                }
				if (player.countMiscJewelry(miscjewelries.ATLATL_) > 0) damage *= 1.25;
                if (player.hasPerk(PerkLib.Ghostslinger)) damage *= 1.15;
                if (player.hasPerk(PerkLib.PhantomShooting)) damage *= 1.05;
                //Determine if critical hit!
                var crit:Boolean = false;
                var critChance:Number = calculateCritRange();
				var critDamage:Number = calculateCritDamageRange();
				crit = rand(100) < critChance;
				if(crit) damage *= critDamage;
				damage *= rangePhysicalForce();
                damage = Math.round(damage);
                checkAchievementDamage(damage);
                if (monster.HP <= monster.minHP()) {
                    if (monster is EncapsulationPod)
                        outputText(". ");
                    else if (monster.plural)
                        outputText(" Your opponents staggers, collapsing onto each other from the wounds you've inflicted on [monster him]. ");
                    else outputText(" Your opponent staggers, collapsing from the wounds you've inflicted on [monster him]. ");
                    doThrowPierceDamage(damage);
                    if (crit) outputText(" <b>*One or more of the projectile did a Critical Hit!*</b>");
                    throwingXP(rangeMasteryEXPgained(crit));
                    outputText("\n\n");
					WeaponRangeStatusProcs();
                    doNext(endHpVictory);
                    return;
                } else {
                    if (!MSGControll) {
                        outputText(" ");
						doThrowPierceDamage(damage);
                        throwingXP(rangeMasteryEXPgained(crit));
                    }
                    if (crit) hasCritAtLeastOnce = true;
					WeaponRangeStatusProcs();
                    WrathGenerationPerHit1(5);
                    heroBaneProc(damage);
                }
            }
            else{
                hasMissedAtLeastOnce = true;
            }
            currentShot++;
        }
        if (hasMissedAtLeastOnce){
            outputText(" Sadly one or more of your projectiles miss the mark, falling harmlessly to the side. ");
        }
        if (hasMissedAtLeastOnce && hasCritAtLeastOnce) outputText(" <b>*However o</b>");
        if (!hasMissedAtLeastOnce && hasCritAtLeastOnce) outputText(" <b>*O</b>");
        if (hasCritAtLeastOnce) outputText(" <b>ne or more of your projectile hit a weak point!*</b>");
        if (player.ammo == 0) {
            if (player.ammo == 0) outputText("\n\n<b>You're out of weapons to throw in this fight!</b>\n\n");
            enemyAIImpl();
        }
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxOverLust()) {
            doNext(endLustVictory);
        }
    }

    /**
     * Throw weapon ranged attack
     * 1. Check accuracy
     * 2. Ammo cost
     * 3. Do attack
     * - Base damage (strength), Telekinesis add inte, DeadlyThrow add spe
     * - Describe throw
     * - bonus from weapon purity/corruption, throwing mastery, archery skill, perks, items, status effects, ranged perks
     * - check crit
     * - do damage
     * 4. Repeat if multi-shot style > 1 and has ammo
     */
    public function throwWeapon():void {
        var fc:Number = oneThrowTotalCost();
        var accRange:Number = 0;
        accRange += (throwingAccuracy() / 2);
        if (flags[kFLAGS.ARROWS_ACCURACY] > 0) accRange -= flags[kFLAGS.ARROWS_ACCURACY];
        if (player.hasPerk(PerkLib.PhantomShooting)) {
            if (player.weaponRange != weaponsrange.SHUNHAR && player.weaponRange != weaponsrange.KSLHARP && player.weaponRange != weaponsrange.LEVHARP) {
                player.takePhysDamage(fc);
            }
        }
        else {
            if (player.weaponRange != weaponsrange.SHUNHAR && player.weaponRange != weaponsrange.KSLHARP && player.weaponRange != weaponsrange.LEVHARP) {
                player.ammo--;
            }
        }
        if (rand(100) < accRange) {
            var damage:Number = 0;
			damage += rangeDamageNoLagSingle(2);
			damage *= 1.5;
            if ((MDOCount == maxCurrentRangeAttacks()) && (MSGControllForEvasion) && (!MSGControll)) {
                if (monster.inte > 0) {
                    outputText("[Themonster] shrugs as the [weaponrange] bounces off them harmlessly.\n\n");
                } else {
                    outputText("The [weaponrange] bounces harmlessly off [themonster].\n\n");
                }
            }
            if (monster is EncapsulationPod) {
                outputText("The [weaponrange] lodges deep into the pod's fleshy wall");
            } else if (monster.plural) {
                var textChooser1:int = rand(12);
                if (textChooser1 >= 9) {
                    outputText("[Themonster] look down at the mark left by the [weaponrange] on one of their bodies");
                } else if (textChooser1 >= 6 && textChooser1 < 9) {
                    outputText("You firmly grasp [weaponrange] and then throw it at one of [themonster]");
                } else if (textChooser1 >= 3 && textChooser1 < 6) {
                    outputText("With one smooth motion you aim and throw your [weaponrange] at one of your opponents");
                } else {
                    outputText("You casually throw [weaponrange] at one of [themonster]");
                }
            } else {
                var textChooser2:int = rand(12);
                if (textChooser2 >= 9) {
                    outputText("[Themonster] looks down at the mark left by the [weaponrange] on it body");
                } else if (textChooser2 >= 6) {
                    outputText("You grasp firmly [weaponrange] and then throw it at [themonster]");
                } else if (textChooser2 >= 3) {
                    outputText("With one smooth motion you aim and throw your [weaponrange] at your opponent");
                } else {
                    outputText("You casually throws [weaponrange] at [themonster]");
                }
            }
            //Weapon addition!
            if (player.weaponRange == weaponsrange.KSLHARP || player.weaponRange == weaponsrange.GOODSAM || Forgefather.purePearlEaten) {
                damage = monsterPureDamageBonus(damage);
            }
            if (player.weaponRange == weaponsrange.LEVHARP || player.weaponRange == weaponsrange.BADOMEN || Forgefather.lethiciteEaten) {
                damage = monsterCorruptDamageBonus(damage);
            }
			if (player.hasPerk(PerkLib.PrestigeJobStalker)) damage *= 1.2;
            if (player.hasPerk(PerkLib.Ghostslinger)) damage *= 1.15;
            if (player.hasPerk(PerkLib.PhantomShooting)) damage *= 1.05;
            if (player.countMiscJewelry(miscjewelries.ATLATL_) > 0) damage *= 1.25;
            //Determine if critical hit!
            var crit:Boolean;
            var critChance:Number = calculateCritRange();
			var critDamage:Number = calculateCritDamageRange();
			crit = rand(100) < critChance;
            if(crit) damage *= critDamage;
            damage = Math.round(damage);
			WeaponRangeStatusProcs();
            checkAchievementDamage(damage);
            if (monster.HP <= monster.minHP()) {
                if (monster is EncapsulationPod)
                    outputText(". ");
                else if (monster.plural)
                    outputText(" and [monster he] stagger, collapsing onto each other from the wounds you've inflicted on [monster him]. ");
                else outputText(" and [monster he] staggers, collapsing from the wounds you've inflicted on [monster him]. ");
                doThrowPierceDamage(damage);
                if (crit) outputText(" <b>*Critical Hit!*</b>");
				throwingXP(rangeMasteryEXPgained(crit));
                outputText("\n\n");
                doNext(endHpVictory);
                return;
            } else {
                if (!MSGControll) {
                    outputText(".  It's clearly very painful. ");
                    doThrowPierceDamage(damage);
					throwingXP(rangeMasteryEXPgained(crit));
                }
                if (crit) outputText(" <b>*Critical Hit!*</b>");
                outputText("\n\n");
				WrathGenerationPerHit1(5);
                heroBaneProc(damage);
            }
        } else {
            outputText("The [weaponrange] goes wide, disappearing behind your foe");
            if (monster.plural) outputText("s");
            outputText(".\n\n");
        }
        if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 1 || player.ammo == 0) {
            if (monster is Lethice && (monster as Lethice).fightPhase == 3) {
                outputText("\n\n<i>\"Ouch. A coward's weapon, to be sure,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your pathetic weapon?\"</i>\n\n");
                monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
            }
            if (player.ammo == 0) outputText("\n\n<b>You're out of weapons to throw in this fight!</b>\n\n");
            enemyAIImpl();
        }
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxOverLust()) {
            doNext(endLustVictory);
        } else if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] > 1) {
            flags[kFLAGS.MULTIPLE_ARROWS_STYLE] -= 1;
            flags[kFLAGS.ARROWS_ACCURACY] += 15;
            throwWeapon();
        }
    }

    /**
     * Firearm ranged attack
     * 1. Check accuracy
     * 2. Ammo cost
     * 2. Describe ammo
     * 4. Do attack
     * - Base damage Based on weapon attack and perks
     * - Describe shot
     * - bonus from weapon, firearms mastery, archery skill, perks, items, ranged perks
     * - check crit
     * - do damage
     * 5. Repeat if multi-shot style > 1 and has ammo
     */
    public function shootWeapon():void {
        var accRange:Number = 0;
        accRange += (firearmsAccuracy() / 2);
        if (flags[kFLAGS.ARROWS_ACCURACY] > 0) accRange -= flags[kFLAGS.ARROWS_ACCURACY];
		if (!player.hasPerk(PerkLib.PrimedClipWarp) || (player.hasPerk(PerkLib.PrimedClipWarp) && rand(4) > 0)) {
			if (player.hasPerk(PerkLib.PhantomShooting)) {
				if (player.weaponRange == weaponsrange.TM1CERB) player.takePhysDamage(300);
				else if (player.weaponRange == weaponsrange.M1CERBE) player.takePhysDamage(150);
				else player.takePhysDamage(25);
			}
			else {
				if (player.miscJewelry1 != miscjewelries.BAMOBAG && player.miscJewelry2 != miscjewelries.BAMOBAG) player.ammo--;
			}
		}
        var ammoWord:String = weaponRangeAmmo;
        if (rand(100) < accRange) {
            var damage:Number = 0;
            damage += firearmsDamageNoLagSingle();
            //[Describe shot]
            if ((MDOCount == maxCurrentRangeAttacks()) && (MSGControllForEvasion) && (!MSGControll)) {
                //if ((damage == 0) ){
                if (monster.inte > 0) {
                    outputText("[Themonster] shrugs as the " + ammoWord + " bounces off them harmlessly.\n\n");
                } else {
                    outputText("The " + ammoWord + " bounces harmlessly off [themonster].\n\n");
                }
            }
            if (monster is EncapsulationPod) {
                outputText("The " + ammoWord + " lodges deep into the pod's fleshy wall");
                if (player.isInGoblinMech()) {
                    if (player.hasKeyItem("Repeater Gun") >= 0) outputText("You shoot the pod with your mech’s repeater gun");
                    if (player.hasKeyItem("Machine Gun MK1") >= 0 || player.hasKeyItem("Machine Gun MK2") >= 0 || player.hasKeyItem("Machine Gun MK3") >= 0) outputText("You fire metal rounds at pod using the mech’s machine gun");
                }
            } else if (monster.plural) {
                if (player.isInGoblinMech()) {
                    if (player.hasKeyItem("Repeater Gun") >= 0) outputText("You shoot your opponent with your mech’s repeater gun");
                    if (player.hasKeyItem("Machine Gun MK1") >= 0 || player.hasKeyItem("Machine Gun MK2") >= 0 || player.hasKeyItem("Machine Gun MK3") >= 0) outputText("You fire metal rounds at [themonster] with your mech’s machine gun");
                } else {
                    var textChooser1:int = rand(12);
                    if (textChooser1 >= 9) {
                        outputText("[Themonster] look down at the mark left by the " + ammoWord + " on one of their bodies");
                    } else if (textChooser1 >= 6 && textChooser1 < 9) {
                        outputText("You pull the trigger and fire the " + ammoWord + " at one of [themonster]");
                    } else if (textChooser1 >= 3 && textChooser1 < 6) {
                        outputText("With one smooth motion you aim and fire your deadly " + ammoWord + " at one of your opponents");
                    } else {
                        outputText("You casually fire an " + ammoWord + " at one of [themonster] with supreme skill");
                    }
                }
            } else {
                if (player.isInGoblinMech()) {
                    if (player.hasKeyItem("Repeater Gun") >= 0) outputText("You shoot your opponent using the mech repeater gun");
                    if (player.hasKeyItem("Machine Gun MK1") >= 0 || player.hasKeyItem("Machine Gun MK2") >= 0 || player.hasKeyItem("Machine Gun MK3") >= 0) outputText("You fire metal rounds at [themonster] using the mech machine gun");
                } else {
                    var textChooser2:int = rand(12);
                    if (textChooser2 >= 9) outputText("[Themonster] looks down at the mark left by the " + ammoWord + " on it body");
                    else if (textChooser2 >= 6) outputText("You pull the trigger and fire the " + ammoWord + " at [themonster]");
                    else if (textChooser2 >= 3) outputText("With one smooth motion you aim and fire your deadly " + ammoWord + " at your opponent");
                    else outputText("You casually fire an " + ammoWord + " at [themonster] with supreme skill");
                }
            }
			if (player.isDualWieldRanged()) damage *= firearmsDualWieldDamagePenalty();
            //any aoe effect from firearms
            if (monster.plural) {
                if (player.weaponRange == weaponsrange.ADBSCAT || player.weaponRange == weaponsrange.DBDRAGG) damage *= 2;
                if (player.weaponRange == weaponsrange.TRFATBI || player.weaponRange == weaponsrange.DERPLAU) damage *= 5;
            }
            //other effects
            if (player.weaponRange == weaponsrange.M1CERBE || player.weaponRange == weaponsrange.TM1CERB) damage *= 6;
            if (player.weaponRange == weaponsrange.HARPGUN && player.hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) damage *= 1.2;
            if (player.isDualWieldRanged()) damage *= (1 + (0.01 * dualWFLevel()));
            if (player.armor == armors.GTECHC_ && !player.isInGoblinMech()) damage *= 1.2;
            if (player.hasKeyItem("Gun Scope") >= 0) damage *= 1.2;
            if (player.hasKeyItem("Gun Scope with Aim tech") >= 0) damage *= 1.4;
            if (player.hasKeyItem("Gun Scope with Aimbot") >= 0) damage *= 1.6;
            if (player.isInGoblinMech()) {
                damage = goblinDamageBonus(damage);
                if (player.hasKeyItem("Repeater Gun") >= 0) {
                    if (player.vehicles == vehicles.GOBMPRI) {
                        damage *= 1.3;
                        if (damage < 60) damage = 60;
					} else if (player.vehicles == vehicles.GS_MECH) {
						damage *= 1.25;
                        if (damage < 50) damage = 50;
					} else {
                        damage *= 1.2;
                        if (damage < 40) damage = 40;
                    }
                }
                if (player.hasKeyItem("Machine Gun MK1") >= 0) {
                    if (player.vehicles == vehicles.GOBMPRI) {
                        damage *= 1.6;
                        if (damage < 120) damage = 120;
                    } else if (player.vehicles == vehicles.GS_MECH) {
						damage *= 1.5;
                        if (damage < 100) damage = 100;
					} else {
                        damage *= 1.4;
                        if (damage < 80) damage = 80;
                    }
                }
                if (player.hasKeyItem("Machine Gun MK2") >= 0) {
                    if (player.vehicles == vehicles.GOBMPRI) {
                        damage *= 1.9;
                        if (damage < 180) damage = 180;
                    } else if (player.vehicles == vehicles.GS_MECH) {
						damage *= 1.75;
                        if (damage < 150) damage = 150;
					} else {
                        damage *= 1.6;
                        if (damage < 120) damage = 120;
                    }
                }
                if (player.hasKeyItem("Machine Gun MK3") >= 0) {
                    if (player.vehicles == vehicles.GOBMPRI) {
                        damage *= 2.2;
                        if (damage < 240) damage = 240;
                    } else if (player.vehicles == vehicles.GS_MECH) {
						damage *= 2;
                        if (damage < 200) damage = 200;
					} else {
                        damage *= 1.8;
                        if (damage < 160) damage = 160;
                    }
                }
				if (player.hasKeyItem("Machine Gun MK4") >= 0) {
					if (player.vehicles == vehicles.GS_MECH) {
						damage *= 2.25;
                        if (damage < 250) damage = 250;
					} else {
                        damage *= 2;
                        if (damage < 200) damage = 200;
                    }
				}
            }
            var ignoreDR:Boolean = player.hasPerk(PerkLib.Penetrator);
            if (!ignoreDR) damage *= (monster.damageRangePercent() / 100);
            if (player.hasPerk(PerkLib.ExplosiveCartridge) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType) || monster.hasPerk(PerkLib.EnemyHugeType) || monster.hasPerk(PerkLib.Enemy300Type) || monster.hasPerk(PerkLib.EnemyGigantType) || monster.hasPerk(PerkLib.EnemyColossalType))) damage *= 2;
            if (player.hasPerk(PerkLib.NamedBullet) && monster.hasPerk(PerkLib.EnemyBossType)) damage *= 1.5;
            if (player.hasPerk(PerkLib.Ghostslinger)) damage *= 1.15;
            if (player.hasPerk(PerkLib.PhantomShooting)) damage *= 1.05;
			if (player.hasPerk(PerkLib.SilverForMonsters) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1.2;
            if (monster.hasStatusEffect(StatusEffects.WoundPoison)) damage*=1+(monster.statusEffectv1(StatusEffects.WoundPoison)/100);
            //Determine if critical hit!
			var crit:Boolean;
            var critChance:Number = calculateCritFirearms();
			var critDamage:Number = calculateCritDamageFirearms();
            crit = rand(100) < critChance;
            if(crit) damage *= critDamage;
			damage = Math.round(damage);
            checkAchievementDamage(damage);
			WeaponRangeStatusProcs();
			WrathGenerationPerHit1(5);
            if (monster.HP <= monster.minHP()) {
                if (monster is EncapsulationPod)
                    outputText(". ");
                else if (monster.plural)
                    outputText(" and [monster he] stagger, collapsing onto each other from the wounds you've inflicted on [monster him]. ");
                else outputText(" and [monster he] staggers, collapsing from the wounds you've inflicted on [monster him]. ");
                if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) {
					doPhysicalDamage(damage, true, true, ignoreDR);
					doMagicDamage(Math.round(damage * 0.2), true, true, ignoreDR);
				}
				else if (player.statStore.hasBuff("FoxflamePelt")) {
					doFireDamage((damage * 2), true, true, ignoreDR);
					if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) doMagicDamage(Math.round(damage * 0.2), true, true, ignoreDR);
					monster.teased((monster.lustVuln * (10 + player.cor / 8)), false);
				}
				else doPhysicalDamage(damage, true, true, ignoreDR);
                if (crit) outputText(" <b>*Critical Hit!*</b>");
				firearmsXP(rangeMasteryEXPgained(crit));
				if (player.weaponRangePerk == "Dual Firearms" || player.weaponRangePerk == "Dual 2H Firearms") {
					dualWieldFirearmsXP(rangeMasteryEXPgained(crit));
				}
                outputText("\n\n");
                doNext(endHpVictory);
                return;
            } else {
                var maxFirearmAttacks:int = player.calculateMultiAttacks(false);
                if (player.hasPerk(PerkLib.LockAndLoad)) maxFirearmAttacks += 1;

                if (player.isInGoblinMech() && (player.hasKeyItem("Repeater Gun") >= 0 || player.hasKeyItem("Machine Gun MK1") >= 0 || player.hasKeyItem("Machine Gun MK2") >= 0 || player.hasKeyItem("Machine Gun MK3") >= 0)) {
                    outputText(".  It's clearly very painful. ");
                    if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) {
						doPhysicalDamage(damage, true, true, ignoreDR);
						doMagicDamage(Math.round(damage * 0.2), true, true, ignoreDR);
					}
					else doPhysicalDamage(damage, true, true, ignoreDR);
					firearmsXP(rangeMasteryEXPgained(crit));
					if (player.weaponRangePerk == "Dual Firearms" || player.weaponRangePerk == "Dual 2H Firearms") {
						dualWieldFirearmsXP(rangeMasteryEXPgained(crit));
					}
					if (player.weaponRange == weaponsrange.M1CERBE || player.weaponRange == weaponsrange.TM1CERB) {
                        for (var attack:int = 0; attack < maxFirearmAttacks; attack++) {
                            if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) {
								doPhysicalDamage(damage, true, true, ignoreDR);
								doMagicDamage(Math.round(damage * 0.2), true, true, ignoreDR);
							}
							else doPhysicalDamage(damage, true, true, ignoreDR);
                        }
                        if (crit) outputText(" <b>*Critical Hit!*</b>");
					}
                } else {
                    if (!MSGControll) {
                        outputText(".  It's clearly very painful. ");
                        if (player.weaponRange == weaponsrange.HARKON1 || player.weaponRange == weaponsrange.HARKON2) {
							if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) {
								doTrueDamage(damage, true, true);
								doMagicDamage(Math.round(damage * 0.2), true, true, ignoreDR);
								if (player.statStore.hasBuff("FoxflamePelt")) {
									doFireDamage((damage * 2), true, true, ignoreDR);
									monster.teased((monster.lustVuln * (10 + player.cor / 8)), false);
								}
							}
							else {
								doTrueDamage(damage, true, true);
								if (player.statStore.hasBuff("FoxflamePelt")) {
									doFireDamage((damage * 2), true, true, ignoreDR);
									monster.teased((monster.lustVuln * (10 + player.cor / 8)), false);
								}
							}
						}
						else if (player.weaponRange == weaponsrange.ALAKABL || player.weaponRange == weaponsrange.DALAKABL) {
							if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) {
								doMagicDamage(Math.round(damage * 1.2), true, true, ignoreDR);
								if (player.statStore.hasBuff("FoxflamePelt")) {
									doFireDamage((damage * 2), true, true, ignoreDR);
									monster.teased((monster.lustVuln * (10 + player.cor / 8)), false);
								}
							}
							else {
								doMagicDamage(damage, true, true, ignoreDR);
								if (player.statStore.hasBuff("FoxflamePelt")) {
									doFireDamage((damage * 2), true, true, ignoreDR);
									monster.teased((monster.lustVuln * (10 + player.cor / 8)), false);
								}
							}
						}
						else {
                            if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) {
								doPhysicalDamage(damage, true, true, ignoreDR);
								doMagicDamage(Math.round(damage * 0.2), true, true, ignoreDR);
							}
							else if (player.statStore.hasBuff("FoxflamePelt")) {
								doFireDamage((damage * 2), true, true, ignoreDR);
								if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) doMagicDamage(Math.round(damage * 0.2), true, true, ignoreDR);
								monster.teased((monster.lustVuln * (10 + player.cor / 8)), false);
							}
							else doPhysicalDamage(damage, true, true, ignoreDR);
							if (player.weaponRange == weaponsrange.M1CERBE || player.weaponRange == weaponsrange.TM1CERB) {
                                for (var cerbAttack:int = 0; cerbAttack < maxFirearmAttacks; cerbAttack++) {
                                    if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) {
										doPhysicalDamage(damage, true, true, ignoreDR);
										doMagicDamage(Math.round(damage * 0.2), true, true, ignoreDR);
									}
									else if (player.statStore.hasBuff("FoxflamePelt")) {
										doFireDamage((damage * 2), true, true, ignoreDR);
										if (player.hasStatusEffect(StatusEffects.ChargeRWeapon)) doMagicDamage(Math.round(damage * 0.2), true, true, ignoreDR);
										monster.teased((monster.lustVuln * (10 + player.cor / 8)), false);
									}
									else doPhysicalDamage(damage, true, true, ignoreDR);
                                }
							}
						}
						firearmsXP(rangeMasteryEXPgained(crit));
						if (player.weaponRangePerk == "Dual Firearms" || player.weaponRangePerk == "Dual 2H Firearms") {
							dualWieldFirearmsXP(rangeMasteryEXPgained(crit));
						}
                    }
                    if (crit) outputText(" <b>*Critical Hit!*</b>");
                    //	if (flaga dla efektu arouse arrow) outputText(" tekst dla arouse arrow effect.");
                    //	if (flaga dla efektu poison arrow) outputText(" tekst dla poison arrow effect.");
					if (player.weaponRange == weaponsrange.TOUHOM3) {
						outputText(" ");
                        doPhysicalDamage(damage, true, true, ignoreDR);
						if (crit) outputText(" <b>*Critical Hit!*</b>");

                        for (var touAttack:int = 0; touAttack < maxFirearmAttacks; touAttack++) {
                            outputText(" ");
                            doPhysicalDamage(damage, true, true, ignoreDR);
							if (crit) outputText(" <b>*Critical Hit!*</b>");
							outputText(" ");
                            doPhysicalDamage(damage, true, true, ignoreDR);
							if (crit) outputText(" <b>*Critical Hit!*</b>");
                        }
					}
                }
                //Lust raising weapon bonuses
                if (monster.lustVuln > 0) {
                    var rangeweaponLustDmg:Number = 0;
                    if (player.weaponRange == weaponsrange.TDPISTO || player.weaponRange == weaponsrange.DPISTOL || player.weaponRange == weaponsrange.LBLASTR) {
                        rangeweaponLustDmg = (20 + player.cor / 15); // 20-26.7
                        if (player.armor == armors.ELFDRES && player.isElf()) rangeweaponLustDmg *= 2;
                        if (player.armor == armors.FMDRESS && player.isWoodElf()) rangeweaponLustDmg *= 2;
                        if (rangeweaponLustDmg > 0) {
                            var s:String = monster.plural ? "" : "s";
                            if (player.weaponRange == weaponsrange.LBLASTR){
                                if (rand(2) == 0) outputText("\n[Themonster] shiver" + s + " and get" + s + " turned on as he is splashed with your milk.");
                                else outputText("\n[Themonster] shiver" + s + " and moan" + s + " involuntarily highly turned on by your moo moo milk.");
                            }
                            else{
                                if (rand(2) == 0) outputText("\n[Themonster] shiver" + s + " and get" + s + " turned on from the injected chemicals.");
                                else outputText("\n[Themonster] shiver" + s + " and moan" + s + " involuntarily from the injected chemicals effects.");
                            }
                        }
                        monster.teased(rangeweaponLustDmg, false);
                    }
                }
                outputText("\n\n");
                heroBaneProc(damage);
                if (player.weaponRange == weaponsrange.DERPLAU && rand(10) == 0) {
                    outputText(" You shoot but curse your bad luck as the grenade bounce back toward you! ");
                    player.takePhysDamage(Math.round(damage * 0.2));
                }
            }
        } else {
            outputText("The " + ammoWord + " goes wide, disappearing behind your foe" + (monster.plural ? "s" : "") + ".\n\n");
        }
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxOverLust()) {
            doNext(endLustVictory);
            return;
        }
        if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] > 1) {
            if (player.ammo > 0) {
                flags[kFLAGS.MULTIPLE_ARROWS_STYLE] -= 1;
                flags[kFLAGS.ARROWS_ACCURACY] += firearmsAccuracyPenalty();
                shootWeapon();
            } else {
                if (player.weaponRange == weaponsrange.LBLASTR) outputText("<b>Your milk tank is empty.</b>\n\n");
                else outputText("<b>Your firearm clip is empty.</b>\n\n");
                reloadWeapon2();
            }
        } else {
            if (player.ammo <= 0) {
                if (player.weaponRange == weaponsrange.LBLASTR) outputText("<b>Your milk tank is empty.</b>\n\n");
                else outputText("<b>Your firearm clip is empty.</b>\n\n");
                reloadWeapon2();
            } else enemyAIImpl();
        }
    }

    public function oneBulletReloadCost():Number {
        var reloaderCost:Number = 4;
		if (player.hasPerk(PerkLib.TaintedMagazine)) reloaderCost += 2;
		if (player.hasPerk(PerkLib.LightningReload)) reloaderCost *= 0.5;
        return reloaderCost;
    }

    public function reloadWeapon():void {
        if (player.weaponRange == weaponsrange.LBLASTR){
            var milkAmmo:Number = player.lactationQ()/100
            if (milkAmmo > 20) milkAmmo = 20;
            player.ammo = milkAmmo;
        }
        if (player.weaponRange == weaponsrange.TWINGRA) player.ammo = 12;
        if (player.weaponRange == weaponsrange.IVIARG_) player.ammo = 12;
        if (player.weaponRange == weaponsrange.TWINSIXS) player.ammo = 12;
        if (player.weaponRange == weaponsrange.BLUNDER) player.ammo = 9;
        if (player.weaponRange == weaponsrange.TDEEAGL) player.ammo = 8;
        if (player.weaponRange == weaponsrange.SIXSHOT) player.ammo = 6;
        if (player.weaponRange == weaponsrange.TDPISTO) player.ammo = 6;
        if (player.weaponRange == weaponsrange.GOODSAM) player.ammo = 4;
        if (player.weaponRange == weaponsrange.BADOMEN) player.ammo = 4;
        if (player.weaponRange == weaponsrange.DESEAGL) player.ammo = 4;
        if (player.weaponRange == weaponsrange.DALAKABL) player.ammo = 4;
        if (player.weaponRange == weaponsrange.DPISTOL) player.ammo = 3;
        if (player.weaponRange == weaponsrange.ALAKABL) player.ammo = 2;
        if (player.weaponRange == weaponsrange.ADBSHOT) player.ammo = 2;
        if (player.weaponRange == weaponsrange.ADBSCAT) player.ammo = 2;
		if (player.weaponRange == weaponsrange.DBDRAGG) player.ammo = 2;
        if (player.weaponRange == weaponsrange.TM1CERB) player.ammo = 2;
        if (player.weaponRange == weaponsrange.HARKON2) player.ammo = 2;
        if (player.weaponRange == weaponsrange.FLINTLK) player.ammo = 1;
        if (player.weaponRange == weaponsrange.DUEL_P_) player.ammo = 1;
        if (player.weaponRange == weaponsrange.M1CERBE) player.ammo = 1;
        if (player.weaponRange == weaponsrange.HARPGUN) player.ammo = 1;
        if (player.weaponRange == weaponsrange.TRFATBI) player.ammo = 1;
        if (player.weaponRange == weaponsrange.SNIPPLE) player.ammo = 1;
        if (player.weaponRange == weaponsrange.TOUHOM3) player.ammo = 1;
        if (player.weaponRange == weaponsrange.DERPLAU) player.ammo = 1;
        if (player.weaponRange == weaponsrange.HARKON1) player.ammo = 1;
		if (player.hasPerk(PerkLib.TaintedMagazine)) player.ammo *= 2;
		if (player.hasPerk(PerkLib.PrimedClipWarp)) player.ammo *= 3;
        if (player.weaponRange == weaponsrange.LBLASTR) {
            outputText("You moo in pleasures as milk flows from your udders, pumped by the suction cup all the way to the tank on your back. Almost immediately fresh cream fills your blasters, you're ready to resume shooting!");
            var lustDmg:int = rand(player.lib / 10) + 20;
            player.takeLustDamage(lustDmg, true);
        } else outputText("You open the magazine of your " + player.weaponRangeName + " to reload the ammunition.");
    }

    public function reloadWeapon1():void {
        clearOutput();
        reloadWeapon();
        if (player.fatigue + (oneBulletReloadCost() * player.ammo) > player.maxOverFatigue()) {
            outputText(" You are too tired to act in this round after reloading your weapon.\n\n");
            player.fatigue += (oneBulletReloadCost() * player.ammo);
            enemyAIImpl();
        } else {
            fatigue(oneBulletReloadCost() * player.ammo);
            if (player.hasPerk(PerkLib.RapidReload)) {
                outputText("\n\n");
                doNext(combatMenu, false);
            } else {
                outputText("Reloading took some time. Your opponent takes advantage of this.\n\n");
                enemyAIImpl();
            }
        }
    }

    public function reloadWeapon2():void {
        reloadWeapon();
        if (player.fatigue + (oneBulletReloadCost() * player.ammo) > player.maxOverFatigue()) {
            outputText("You are too tired to keep shooting in this round after reloading your weapon.\n\n");
            player.fatigue += (oneBulletReloadCost() * player.ammo);
            enemyAIImpl();
        } else {
            fatigue(oneBulletReloadCost() * player.ammo);
            if (player.hasPerk(PerkLib.LightningReload) && flags[kFLAGS.MULTIPLE_ARROWS_STYLE] > 1) {
                flags[kFLAGS.MULTIPLE_ARROWS_STYLE] -= 1;
                flags[kFLAGS.ARROWS_ACCURACY] += firearmsAccuracyPenalty();
                outputText("\n\n");
                shootWeapon();
            } else {
                if (player.weaponRange != weaponsrange.M1CERBE && player.weaponRange != weaponsrange.TM1CERB && player.weaponRange != weaponsrange.TRFATBI && player.weaponRange != weaponsrange.HARPGUN && player.weaponRange != weaponsrange.SNIPPLE && player.weaponRange != weaponsrange.TOUHOM3 && player.weaponRange != weaponsrange.DERPLAU && player.weaponRange != weaponsrange.DUEL_P_
                        && player.weaponRange != weaponsrange.FLINTLK && player.weaponRange != weaponsrange.HARKON1 && player.weaponRange != weaponsrange.HARKON2) outputText(" Due to slow reloading you spent rest of your round on it and can't act until next turn.");
                outputText("\n\n");
                enemyAIImpl();
            }
        }
    }

    private function debugCheatStats():void {
        function cheatProperty(object:*, propName:*, newValue:*):void {
            object[propName] = newValue;
            statScreenRefresh();
        }
        var buttons:ButtonDataList = new ButtonDataList();
        
        buttons.add("HP 10%",curry(cheatProperty,player,"HP",Math.round(player.maxHP()*0.1)));
        buttons.add("HP 50%",curry(cheatProperty,player,"HP",Math.round(player.maxHP()*0.5)));
        buttons.add("HP 100%",curry(cheatProperty,player,"HP",player.maxHP()));
        buttons.add("Lust 0%",curry(cheatProperty,player,"lust",player.minLust()));
        buttons.add("Lust 50%",curry(cheatProperty,player,"lust",Math.round(player.maxLust()*0.5)));
        buttons.add("Lust 90%",curry(cheatProperty,player,"lust",Math.round(player.maxLust()*0.9)));
        buttons.add("Mana 100%",curry(cheatProperty,player,"mana",player.maxMana()));
        buttons.add("Wrath 100%",curry(cheatProperty,player,"wrath",player.maxWrath()));
        buttons.add("Fatigue 0%",curry(cheatProperty,player,"fatigue",0));
        buttons.add("SF 100%",curry(cheatProperty,player,"soulforce",player.maxSoulforce()));
        buttons.add("Foe HP 10%",curry(cheatProperty,monster,"HP",(monster.maxHP()*0.1)));
        buttons.add("Foe HP 50%",curry(cheatProperty,monster,"HP",Math.round(monster.maxHP()*0.5)));
        buttons.add("Foe HP 100%",curry(cheatProperty,monster,"HP",monster.maxHP()));
        buttons.add("Foe Lust 0%",curry(cheatProperty,monster,"lust",monster.minLust()));
        buttons.add("Foe Lust 50%",curry(cheatProperty,monster,"lust",Math.round(monster.maxLust()*0.5)));
        buttons.add("Foe Lust 90%",curry(cheatProperty,monster,"lust",Math.round(monster.maxLust()*0.9)));
        
        submenu(buttons,combatMenu,0,false);
    }
    private function debugCheatAbility():void {
        function cheatSubmenu(abilities:/*CombatAbility*/Array):void {
            var buttons:ButtonDataList = new ButtonDataList();
            for each (var ability:CombatAbility in abilities) {
                var button:ButtonData = ability.createButton(monster);
                button.enabled = true;
                buttons.append(button);
            }
            submenu(buttons,debugCheatAbility);
        }
        
        var buttons:ButtonDataList = new ButtonDataList();
        for each (var category:Object in CombatAbility.AllCategories) {
            var abilities:/*CombatAbility*/Array = CombatAbilities.ALL.filter(
                    function(ability:CombatAbility, index:int, array:Array):Boolean {
                        return ability.category == category.value;
                    }
            );
            if (abilities.length > 0) {
                buttons.add(category.name,curry(cheatSubmenu,abilities.slice()));
            }
        }
        submenu(buttons,combatMenu,0,false);
    }
    
    private function debugInspect():void {
        outputText(monster.generateDebugDescription());
        menu();
        addButton(0, "Next", combatMenu, false);
    }

//Fantasize
    public function fantasize():void {
        var lustChange:Number;
        doNext(combatMenu);
        clearOutput();
        var baseLustDmg:Number = teases.teaseBaseLustDamage();
        if (monster is FrostGiant && (player.hasStatusEffect(StatusEffects.GiantBoulder))) {
            lustChange = baseLustDmg + rand(player.lib / 4 + player.cor / 5);
            dynStats("lus", lustChange, "scale", false);
            (monster as FrostGiant).giantBoulderFantasize();
            enemyAIImpl();
            return;
        }
        if (monster is YoungFrostGiant && (player.hasStatusEffect(StatusEffects.GiantBoulder))) {
            lustChange = baseLustDmg / 2 + rand(player.lib / 5 + player.cor / 8);
            dynStats("lus", lustChange, "scale", false);
            (monster as YoungFrostGiant).youngGiantBoulderFantasize();
            enemyAIImpl();
            return;
        }
        if (player.armor == armors.GOOARMR) {
            outputText("As you fantasize, you feel Valeria rubbing her gooey body all across your sensitive skin");
            if (player.gender > 0) outputText(" and genitals");
            outputText(", arousing you even further.\n");
            lustChange = baseLustDmg * 1.25 + rand(player.lib / 8 + player.cor / 8)
        } else if (player.hasBalls() && player.ballSize >= 10 && rand(2) == 0) {
            outputText("You daydream about fucking [themonster], feeling your balls swell with seed as you prepare to fuck [monster him] full of cum.\n");
            lustChange = baseLustDmg / 4 + rand(player.lib / 8 + player.cor / 8);
            outputText("You aren't sure if it's just the fantasy, but your [balls] do feel fuller than before...\n");
            player.hoursSinceCum += 50;
        } else if (player.biggestTitSize() >= 6 && rand(2) == 0) {
            outputText("You fantasize about grabbing [themonster] and shoving [monster him] in between your jiggling mammaries, nearly suffocating [monster him] as you have your way.\n");
            lustChange = baseLustDmg  / 4 + rand(player.lib / 8 + player.cor / 8)
        } else if (player.biggestLactation() >= 6 && rand(2) == 0) {
            outputText("You fantasize about grabbing [themonster] and forcing [monster him] against a " + nippleDescript(0) + ", and feeling your milk let down.  The desire to forcefeed SOMETHING makes your nipples hard and moist with milk.\n");
            lustChange = baseLustDmg / 4 + rand(player.lib / 8 + player.cor / 8)
        } else {
            clearOutput();
            outputText("You fill your mind with perverted thoughts about [themonster], picturing [monster him] in all kinds of perverse situations with you.\n");
            lustChange = baseLustDmg / 2 + rand(player.lib / 5 + player.cor / 8);
        }
        if (lustChange >= 20) outputText("The fantasy is so vivid and pleasurable you wish it was happening now.  You wonder if [themonster] can tell what you were thinking.\n\n");
        else outputText("\n");
        dynStats("lus", lustChange, "scale", false);
        if (player.lust >= player.maxOverLust() && !player.statStore.hasBuff("Supercharged") && !tyrantiaTrainingExtension()) {
            if (monster is EncapsulationPod) {
                outputText("<b>You nearly orgasm, but the terror of the situation reasserts itself, muting your body's need for release.  If you don't escape soon, you have no doubt you'll be too fucked up to ever try again!</b>\n\n");
                player.lust = (player.maxOverLust() - 1);
                dynStats("lus", -25);
            } else {
                doNext(endLustLoss);
                return;
            }
        }
        enemyAIImpl();
    }

    public function goboLustnadeLauncher():void {
        clearOutput();
        var damage:Number = 6 + rand(3);
        damage += scalingBonusIntelligence() + scalingBonusLibido() * 0.1;
        if (player.hasKeyItem("Lustnade Launcher") >= 0) {
            if (player.hasPerk(PerkLib.SensualLover)) damage += 2;
            if (player.hasPerk(PerkLib.Seduction)) damage += 5;
            damage += player.teaseDmgStat.value;
            if (player.hasPerk(PerkLib.JobSeducer)) damage += player.teaseLevel * 3;
            else damage += player.teaseLevel * 2;
            if (player.hasPerk(PerkLib.JobCourtesan) && monster.hasPerk(PerkLib.EnemyBossType)) damage *= 1.2;
            //partial skins bonuses
            switch (player.coatType()) {
                case Skin.FUR:
                    damage += (1 + player.newGamePlusMod());
                    break;
                case Skin.AQUA_SCALES:
                case Skin.DRAGON_SCALES:
                case Skin.SCALES:
                    damage += (2 * (1 + player.newGamePlusMod()));
                    break;
                case Skin.CHITIN:
                    damage += (3 * (1 + player.newGamePlusMod()));
                    break;
                case Skin.BARK:
                    damage += (4 * (1 + player.newGamePlusMod()));
                    break;
            }
            damage *= 2;
        }
        if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) damage *= 5;
        damage = goblinDamageBonus(damage);
        if (player.armor == armors.ELFDRES && player.isElf()) damage *= 2;
        if (player.armor == armors.FMDRESS && player.isWoodElf()) damage *= 2;
        damage = damage * monster.lustVuln;
        damage = Math.round(damage);
        if (player.hasKeyItem("Lustnade Launcher") >= 0) {
            outputText("You ready the Lustnade launcher and shoot. The exploding container covers the entire area in pink mist, massively arousing everyone in the vicinity for " + Math.round(damage) + " lust damage.");
            monster.teased(Math.round(damage));
        } else {
            outputText("You spray a cloud of aphrodisiac with your gas gun. [themonster] tries to pinch [monster his] nose and hold [monster his] breath ");
            if (rand(100) > 25) {
                outputText("but it’s too late and you can see arousal flushing [themonster] skin.\n");
                monster.teased(Math.round(damage));
            } else outputText("and it worked, to an extent, allowing your opponent to retreat away from the gas.");
        }
        outputText("\n\n")
        if (monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
        enemyAIImpl();
    }

    public function defendpose():void {
        clearOutput();
        outputText("You decide not to take any offensive action this round preparing for [themonster]'s attack. You take a defensive pose, watching your enemy's movements.\n\n");
        player.createStatusEffect(StatusEffects.Defend, 0, 0, 0, 0);
        if (player.hasPerk(PerkLib.DefenceStance)) {
            fatigueRecovery1();
            manaregeneration1();
            soulforceregeneration1();
        }
		enemyAIImpl();
    }

    public static function playerWaitsOrDefends():Boolean {
        return flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1 && flags[kFLAGS.WAIT_STAND_STILL] == 0
            || player.hasStatusEffect(StatusEffects.Defend);
    }

    public static function autoHitPlayer():Boolean {
        return flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1 && flags[kFLAGS.WAIT_STAND_STILL] == 1;
    }

    public function seconwindGo():void {
        clearOutput();
        outputText("You enter your second wind, recovering your energy.\n\n");
        fatigue((player.maxOverFatigue() - player.fatigue) / 2);
        player.createStatusEffect(StatusEffects.SecondWindRegen, 10, 0, 0, 0);
        player.createStatusEffect(StatusEffects.CooldownSecondWind, 0, 0, 0, 0);
        enemyAIImpl();
    }

    public function surrenderByHP():void {
		doNext(combatMenu);
        clearOutput();
        outputText("You stop fighting, letting [themonster] beat you to the brink of death.\n");
        player.HP = player.minHP();
        doNext(endHpLoss);
    }
    public function surrenderByLust():void {
        var remainingLust:Number = (player.maxLust() - player.lust);
        doNext(combatMenu);
        clearOutput();
        outputText("You fill your mind with perverted thoughts about [themonster], picturing [monster him] in all kinds of perverse situations with you.\n");
        dynStats("lus", remainingLust, "scale", false);
        doNext(endLustLoss);
    }

    /**
     * Melee attack action
     * 1. Check if can attack (sealed, pacifism) and describe attack
     * 2. Check if attack missed (player bind, monster is fast, blocked)
     * 3. Do Feral additional attacks
     * 4. Go to melee accuracy check
     */
    public function attack(followupAttacks:Boolean = true):void {
        var IsFeralCombat:Boolean = false;
        flags[kFLAGS.LAST_ATTACK_TYPE] = LAST_ATTACK_PHYS;

        // migrate kitsune's(and their retarded cousins that does not use extend Kitsune)/chaos chimera's Seal check
        // kitsune/yamata/chaos chimera/kitsuneancestor/kitsuneelder/aiko
        // migrate knife ears that uses StatusEffects.Seal2
        // woodelveshuntingparty/darkelf/lightelf
        // migrate amily concentration check
        if(monster.preAttackSeal()){
            // Fetish pacifism stays for now until someone gets a better idea
            if (flags[kFLAGS.PC_FETISH] >= 3 && !SceneLib.urtaQuest.isUrta()) {
                outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Ceraph's piercings have made normal melee attacks impossible!  Maybe you could try something else?\n\n");
            } else {
                // I hate urta flag checks honestly cant we just make urta's dedicated melee function after this uh
                //"Brawler perk". Urta only. Thanks to Fenoxo for pointing this out... Even though that should have been obvious :<
                //Urta has fists and the Brawler perk. Don't check for that because Urta can't drop her fists or lose the perk!
                if (SceneLib.urtaQuest.isUrta()) {
                    if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
                        player.removeStatusEffect(StatusEffects.FirstAttack);
                    } else {
                        player.createStatusEffect(StatusEffects.FirstAttack, 0, 0, 0, 0);
                        outputText("Utilizing your skills as a bareknuckle brawler, you make two attacks!\n");
                    }
                }
                
                // migrate alruine/sandtrap flavor text and trap level changes
                monster.preAttack();

                //Blind
                if (player.playerIsBlinded()) {
                    outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ");
                }

                // Migrate basilisk blind check
                // Gimmick now way easier to implement if any fucker want to use it kekvv
                if(monster.midAttackSkip()){
                    // Migrate demondragonGroup meleeresponse()
                    // Migrate frost giant boulder check. Every single one of them. And not just a giant, but the giants and the children too!
                    // Migrate worm. Worm is so special they can skip the rest of your shit (first attack guaranteed then call enemyAI() and end)
                    // Migrate Incubus Scientist ShieldHits checks and ShieldsHitMelee()
                    if(monster.midAttackSeal()){
                        // rest of the attack here

                        if (player.HP <= player.minHP()) {
                            doNext(endHpLoss);
                            return;
                        }

                        // Check if player missed
                        // enemyAI() should still be called in the end
                        if (((player.playerIsBlinded() && rand(2) == 0)
                                || (monster.getEvasionRoll(false, player.spe)
                                        && !monster.hasPerk(PerkLib.NoDodges)))
                                && !monster.monsterIsStunned()) {

                            // Migrate akbal/shouldra/kitsune/default dodge text
                            monster.midDodge();
                            outputText("\n\n");
                        }
                        else{
                            // Congratulations, you hit it
                            // Oh wait sandmother can block shit (Earthshield Statuseffects only used by her)
                            if(monster.postDodge()){
                                // Almost there, probably
                                if (flags[kFLAGS.ATTACKS_ACCURACY] > 0) flags[kFLAGS.ATTACKS_ACCURACY] = 0;

                                //Natural weapon Full attack list
                                if (followupAttacks && flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && ((player.hasNaturalWeapons() || player.haveNaturalClawsTypeWeapon()))) {
                                    IsFeralCombat = true;
                                    resolveFeralCombatAdditionnalAttacks();
                                }
                                // Do all other attacks
                                meleeDamageAcc(IsFeralCombat);
                                if (player.hasPerk(PerkLib.LightningClaw)){
                                    outputText(" The residual electricity leaves your foe's skin tingling with pleasure.");
                                }
                            }
                            // YOOOOU SHALL NOOOOOT PAAAAAAAAAASSSSSS!!!!!
                        }
                    }
                }
                else{
                    combatRoundOver();
                    return;
                }

            }
        }

        // This should be the end ideally probably
        enemyAI();

        //Determine if dodged!
        //BLOCKED ATTACK:
    }

    /**
     * Additional feral attacks to melee attack
     * 1. Bite (Fenrir heal, Shark bleed, Snake/Spider venom, Hydra tails)
     * 2. Claws (Frostwyrm, Mantis/Kamaitachi, Wendigo, Gargoyle, Werewolf, Displacer, Wendigo again)
     * 3. Taur
     * 4. Pounce
     * 5. Flying talons
     * 6. Wings
     * 7. Horns
     * 8. Tail slap
     * 9. Mantis/Kamaitatchi
     * 10. Sea dragon lightning
     * 11. TENTACLE TIME!!!
     */
    public function resolveFeralCombatAdditionnalAttacks():void {
        ExtraNaturalWeaponPrep();
        var pLibHellFireCoat:Boolean = player.hasPerk(PerkLib.HellfireCoat);
        var pFoxFlamePelt:Boolean = player.statStore.hasBuff("FoxflamePelt");

        //DOING BITE ATTACKS
        if (player.hasABiteAttack()) {
            var biteMultiplier:Number = 0.5;
            outputText("You bite your foe, sinking your teeth in");
            if (player.hasPerk(PerkLib.FenrirSpiritstrike) && !monster.hasPerk(PerkLib.EnemyTrueDemon)){
                biteMultiplier = 10;
                outputText(" and tearing at your foe's very soul!");
                HPChange(player.maxHP()*0.25,false);
            }
            // Bite Attacks Check
            switch(player.faceType){
                case Face.ORCA:
                    // from 0.5 to 2.0 effectively +1.5
                    biteMultiplier += 1.5;
                    break;
                case Face.ABYSSAL_SHARK:
                    // should also trigger shark_teeth and vampire
                    biteMultiplier += 2.0;
                case Face.SHARK_TEETH:
                    biteMultiplier += 1.5;
                case Face.VAMPIRE:
                    // Vampire dont have bitemultiplier bonus FeelsBadMan
                    if (!monster.isImmuneToBleed()){
                        outputText(" and drawing blood out.");
                        if (!monster.hasStatusEffect(StatusEffects.SharkBiteBleed)) monster.createStatusEffect(StatusEffects.SharkBiteBleed,15,0,0,0);
                        else {
                            monster.removeStatusEffect(StatusEffects.SharkBiteBleed);
                            monster.createStatusEffect(StatusEffects.SharkBiteBleed,15,0,0,0);
                        }
                    }
                    break;
                case Face.SNAKE_FANGS:
                    if (player.tailVenom >= player.VenomWebCost()){
                        outputText(" and inject your venom into the wound!");
                        var DBPb:Number = 1;
                        if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) DBPb *= 2;
                        monster.statStore.addBuffObject({spe:-DBPb}, "Poison",{text:"Poison"});
                        var venomType:StatusEffectType = StatusEffects.NagaVenom;
                        if (player.racialScore(Races.NAGA) >= 23) venomType = StatusEffects.ApophisVenom;
                        if (monster.hasStatusEffect(venomType)) {
                            monster.addStatusValue(venomType, 2, 0.4);
                            monster.addStatusValue(venomType, 1, (DBPb * 0.4));
                        } else monster.createStatusEffect(venomType, (DBPb * 0.4), 0.4, 0, 0);
                        if (player.hasPerk(PerkLib.WoundPoison)){
                            if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                            else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
                        }
                        player.tailVenom -= player.VenomWebCost();
                        flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                    }
                    break;
                case Face.SPIDER_FANGS:
                    if (player.tailVenom >= player.VenomWebCost()){
                        var sharedVenomMulti:Number = 1;
                        if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) sharedVenomMulti *= 2;
                        if (player.armor == armors.ELFDRES && player.isElf()) sharedVenomMulti *= 2;
                        if (player.armor == armors.FMDRESS && player.isWoodElf()) sharedVenomMulti *= 2;

                        outputText(" and inject your venom into the wound!");
                        if (player.lowerBody == LowerBody.ATLACH_NACHA){
                            outputText("  [monster he] seems to be affected by the poison, showing increasing sign of weakness and arousal.");
                            var damage3B:Number = 35 + rand(player.lib / 10);
                            var poisonScaling:Number = 1;
                            var damage3Ba:Number = 1;
                            poisonScaling += player.lib/100;
                            poisonScaling += player.tou/100;
                            if (player.level < 10) damage3B += 20 + (player.level * 3);
                            else if (player.level < 20) damage3B += 50 + (player.level - 10) * 2;
                            else if (player.level < 30) damage3B += 70 + (player.level - 20) * 1;
                            else damage3B += 80;
                            damage3B *= 0.2;

                            damage3Ba *= sharedVenomMulti;

                            damage3B *= damage3Ba;
                            poisonScaling *= damage3Ba;
                            damage3B *= 1 + (poisonScaling / 10);
                            monster.teased(Math.round(monster.lustVuln * damage3B));
                            monster.statStore.addBuffObject({tou:-poisonScaling}, "Poison",{text:"Poison"});
                            if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                                monster.addStatusValue(StatusEffects.NagaVenom, 3, damage3Ba);
                            } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, damage3Ba, 0);
                            if (player.hasPerk(PerkLib.WoundPoison)){
                                if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                                else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
                            }
                        }
                        else {
                            var lustDmg:int = 6 * monster.lustVuln;
                            lustDmg *= sharedVenomMulti;
                            monster.teased(lustDmg);
                            if (monster.lustVuln > 0 && !monster.hasPerk(PerkLib.EnemyTrueAngel)) {
                                monster.lustVuln += 0.01;
                                if (monster.lustVuln > 1) monster.lustVuln = 1;
                            }
                        }
                        player.tailVenom -= player.VenomWebCost();
                        flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                    }
                    break;
                case Face.CERBERUS:
                    //Unique attack Cerberus fire breath
                    if (player.hasPerk(PerkLib.Hellfire)) {
                        outputText("You unleash a tripple blast of fire from your heads, engulfing [themonster] in Hellfire.");
                        ExtraNaturalWeaponAttack(1, "fire");
                        ExtraNaturalWeaponAttack(1, "fire");
                        ExtraNaturalWeaponAttack(1, "fire");
                        outputText("\n");
                    }
                    break;
                default:
            }
            outputText(".");

            if (pLibHellFireCoat) ExtraNaturalWeaponAttack(biteMultiplier, "fire");
            else if (pFoxFlamePelt) ExtraNaturalWeaponAttack(biteMultiplier, "foxflame");
            else ExtraNaturalWeaponAttack(biteMultiplier);
            if (player.faceType == Face.CERBERUS) {
                if (pLibHellFireCoat) {
                    ExtraNaturalWeaponAttack(biteMultiplier, "fire");
                    ExtraNaturalWeaponAttack(biteMultiplier, "fire");
                } else {
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    ExtraNaturalWeaponAttack(biteMultiplier);
                }
            }
            outputText(".\n");
            if (player.hasStatusEffect(StatusEffects.HydraTailsPlayer)){ //WTF, This can be so much simplier.   //There I simplified it :)
                biteMultiplier = 1;
                var heads:Number = player.statusEffectv1(StatusEffects.HydraTailsPlayer);
                if (heads >= 2) {
                    biteMultiplier *= heads;
                    outputText("You stand up erect and pull back for a second only to dart out with all your " + heads + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    outputText("\n");
                    var DBPc:Number = 1;
                    if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) DBPc *= 2;
                    monster.statStore.addBuffObject({spe:-DBPc}, "Poison",{text:"Poison"});
                    var venomType2:StatusEffectType = StatusEffects.NagaVenom;
                    if (player.racialScore(Races.NAGA) >= 23) venomType2 = StatusEffects.ApophisVenom;
                    if (monster.hasStatusEffect(venomType2)) {
                        monster.addStatusValue(venomType2, 2, 0.4*biteMultiplier);
                        monster.addStatusValue(venomType2, 1, (DBPc * 0.4*biteMultiplier));
                    } else monster.createStatusEffect(venomType2, (DBPc * 0.4*biteMultiplier), 0.4*biteMultiplier, 0, 0);
                    if (player.hasPerk(PerkLib.WoundPoison)){
                        if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10*biteMultiplier);
                        else monster.createStatusEffect(StatusEffects.WoundPoison, 10*biteMultiplier,0,0,0);
                    }
                    player.tailVenom -= player.VenomWebCost();
                    flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                }
            }
        }
        //DOING EXTRA CLAW ATTACKS
        if (player.haveNaturalClaws()) {
            var ClawDamageMultiplier:Number = 1;
            if (player.hasMutation(IMutationsLib.EyeOfTheTigerIM)) ClawDamageMultiplier *= 1.5;
            switch(player.arms.type){
                case Arms.MANTIS:
                case Arms.KAMAITACHI:
                    ClawDamageMultiplier *= 1.5;
                    var oText:String = "You slash at your opponent with your scythes";
                    if (player.arms.type == Arms.KAMAITACHI){
                        oText+= " that bleeds profusely";
                    }
                    oText+=".";
                    outputText(oText);
                    break;
                case Arms.FROSTWYRM:
                    // Why does frostwyrm has lower clawdamagemultipler value than insect
                    ClawDamageMultiplier *= 2;
                default:
                    outputText("You claw viciously at your opponent, tearing away at its body.");
            }

            var feralNotGargoyle:Boolean = true;

            switch(player.arms.type){
                case Arms.KAMAITACHI:
                    ExtraNaturalWeaponAttack(ClawDamageMultiplier, "KamaitachiScythe", true);
                    ExtraNaturalWeaponAttack(ClawDamageMultiplier, "KamaitachiScythe", true);
                    break;
                case Arms.WENDIGO:
                    ExtraNaturalWeaponAttack(ClawDamageMultiplier, "WendigoClaw", true);
                    ExtraNaturalWeaponAttack(ClawDamageMultiplier, "WendigoClaw", true);
                    break;
                case Arms.GARGOYLE:
                    feralNotGargoyle = false;
                    switch (Forgefather.channelInlay){
                        case "amethyst":
                            ExtraNaturalWeaponAttack(ClawDamageMultiplier, "darkness", true);
                            ExtraNaturalWeaponAttack(ClawDamageMultiplier, "darkness", true);
                            break;
                        case "ruby":
                            ExtraNaturalWeaponAttack(ClawDamageMultiplier, "fire", true);
                            ExtraNaturalWeaponAttack(ClawDamageMultiplier, "fire", true);
                            break;
                        case "sapphire":
                            ExtraNaturalWeaponAttack(ClawDamageMultiplier, "ice", true);
                            ExtraNaturalWeaponAttack(ClawDamageMultiplier, "ice", true);
                            break;
                        case "topaz":
                            ExtraNaturalWeaponAttack(ClawDamageMultiplier, "lightning", true);
                            ExtraNaturalWeaponAttack(ClawDamageMultiplier, "lightning", true);
                            break;
                        default:
                            ExtraNaturalWeaponAttack(ClawDamageMultiplier, "", true);
                            ExtraNaturalWeaponAttack(ClawDamageMultiplier, "", true);
                            break;
                    }
                    break;
                default:
            }
            // If not gargolye
            if(feralNotGargoyle){
                if (pLibHellFireCoat) {
                    ExtraNaturalWeaponAttack(ClawDamageMultiplier, "fire", true);
                    ExtraNaturalWeaponAttack(ClawDamageMultiplier, "fire", true);
                } else if (pFoxFlamePelt) {
                    ExtraNaturalWeaponAttack(ClawDamageMultiplier, "foxflame", true);
                    ExtraNaturalWeaponAttack(ClawDamageMultiplier, "foxflame", true);
                } else {
                    ExtraNaturalWeaponAttack(ClawDamageMultiplier, "", true);
                    ExtraNaturalWeaponAttack(ClawDamageMultiplier, "", true);
                    if (player.weaponName == "black cat glove" && Arms.hasFelineArms(player)) {
                        ExtraNaturalWeaponAttack(ClawDamageMultiplier, "", true);
                        ExtraNaturalWeaponAttack(ClawDamageMultiplier, "", true);
                    }
                }
            }
            outputText("\n");
            // Should we put this to one of the switch above uh
            switch(player.arms.type){
                case Arms.WOLF:
                    if (player.hasPerk(PerkLib.Lycanthropy)){
                        if (flags[kFLAGS.LUNA_MOON_CYCLE] != 7){
                            outputText("The moon grants you strength as you rend your opponent one more time with your claws.");
                            ExtraNaturalWeaponAttack(1, "", true);
                            outputText("\n");
                        } else  {
                            outputText("The full moon grants you strength as you rend your opponent two more times with your claws.");
                            ExtraNaturalWeaponAttack(1, "", true);
                            ExtraNaturalWeaponAttack(1, "", true);
                            outputText("\n");
                        }
                    }
                    break;
                case Arms.DISPLACER:
                    outputText("You use your extra arms to rend your opponent two more times.");
                    if (pFoxFlamePelt) {
                        ExtraNaturalWeaponAttack(1, "foxflame", true);
                        ExtraNaturalWeaponAttack(1, "foxflame", true);
                    }
                    else {
                        ExtraNaturalWeaponAttack(1, "", true);
                        ExtraNaturalWeaponAttack(1, "", true);
                    }
                    outputText("\n");
                    break;
                case Arms.WENDIGO:
                    outputText("Your maddening hunger gives you strength allowing you to attack two more times, your strike delivering cursed wounds.");
                    ExtraNaturalWeaponAttack(1, "WendigoClaw", true);
                    ExtraNaturalWeaponAttack(1, "WendigoClaw", true);
                    outputText("\n");
                    break;
                default:

            }
        }
        //CENTAUR TIME!
        if (player.isTaur()) {
            switch(player.lowerBody){
                case LowerBody.HOOFED:
                case LowerBody.CLOVEN_HOOFED:
                    outputText("You rear up and trample your opponent with your hooves.");
                    break;
                default:
                    outputText("You rear up and claw at your opponent with your forepaws.");
            }

            if (pLibHellFireCoat) {
                ExtraNaturalWeaponAttack(1, "fire");
                ExtraNaturalWeaponAttack(1, "fire");
            } else if (pFoxFlamePelt) {
                ExtraNaturalWeaponAttack(1, "foxflame");
                ExtraNaturalWeaponAttack(1, "foxflame");
            } else {
                ExtraNaturalWeaponAttack();
                ExtraNaturalWeaponAttack();
            }
            outputText("\n");
        }
        //POUNCING FOR THE KILL
        if (player.canPounce()) {
            outputText("You leap up at [themonster] raking [monster him] with your hind claws twice.");
            if (pLibHellFireCoat) {
                ExtraNaturalWeaponAttack(1, "fire");
                ExtraNaturalWeaponAttack(1, "fire");
            } else {
                ExtraNaturalWeaponAttack();
                ExtraNaturalWeaponAttack();
            }
            outputText("\n");
        }
        //TALON
        if (player.isFlying()){
            if (player.hasTalonsAttack()){
                outputText("You rend at your opponent with your talons twice.");
                if (pLibHellFireCoat) {
                    ExtraNaturalWeaponAttack(1, "fire");
                    ExtraNaturalWeaponAttack(1, "fire");
                } else {
                    ExtraNaturalWeaponAttack();
                    ExtraNaturalWeaponAttack();
                }
                outputText("\n");
            }
        }
        //DEALING WING ATTACKS
        if (player.hasAWingAttack())
        {
            switch(player.wings.type){
                case Wings.THUNDEROUS_AURA:
                    outputText("You zap your opponent with your aura, delivering a barrage of arousing discharge");
                    LustyEnergyNaturalWeaponAttack(0.20);
                    LustyEnergyNaturalWeaponAttack(0.20);
                    LustyEnergyNaturalWeaponAttack(0.20);
                    LustyEnergyNaturalWeaponAttack(0.20);
                    LustyEnergyNaturalWeaponAttack(0.20);
                    break;
                case Wings.WINDY_AURA:
                    outputText("You unleash your sharp winds on your opponent delivering bruise and cuts.");
                    ExtraNaturalWeaponAttack(0.5);
                    break;
                case Wings.GARGOYLE_LIKE_LARGE:
                    outputText("You batter your foe with your two powerful wings the stony impact sending it reel to the side, dazed.");
                    ExtraNaturalWeaponAttack(0.5);
                    break;
                default:
                    outputText("You batter your foe with your two powerful wings.");
                    ExtraNaturalWeaponAttack(0.5);
            }
            outputText("\n");
        }
        //DOING HORN ATACK
        if (player.hasAGoreAttack()) {
            switch(player.horns.type){
                case Horns.UNICORN:
                case Horns.KIRIN:
                    outputText("You impale your foe on your horn, blood coating the tip.");
                    break;
                default:
                    outputText("You impale your foe on your horns, blood coating the tips.");
            }

            if (!monster.hasStatusEffect(StatusEffects.GoreBleed)) monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
            else {
                monster.removeStatusEffect(StatusEffects.GoreBleed);
                monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
            }

            if (pLibHellFireCoat) {
                ExtraNaturalWeaponAttack(1.5, "fire");
            } else if (pFoxFlamePelt) {
                ExtraNaturalWeaponAttack(1.5, "foxflame");
            } else {
                ExtraNaturalWeaponAttack(1.5);
            }
            outputText("\n");
        }
        //TAIL SLAPPING FOR THE KILL
        if (player.hasATailSlapAttack()) {
            var TailDamageMultiplier:Number = 1;

            switch(player.lowerBody){
                case LowerBody.NAGA:
                case LowerBody.FROSTWYRM:
                    TailDamageMultiplier = 3;
                    outputText("You hit your opponent with a slam of your mighty tail.")
                    if (pLibHellFireCoat) {
                        ExtraNaturalWeaponAttack(TailDamageMultiplier, "fire");
                    } else {
                        ExtraNaturalWeaponAttack(TailDamageMultiplier);
                    }
                    outputText("\n");
                    break;
                default:
                    switch(player.tail.type){
                        case Tail.MANTICORE_PUSSYTAIL:
                            outputText("You hiss and raise your tail. You strike at blinding speed, impaling your opponent twice with your spike");
                            var pVenomWebCost:Number = player.VenomWebCost();

                            if (player.tailVenom >= pVenomWebCost) {
                                outputText(" and injecting your venom in the process");
                                //TailVenomArea
                                var lustdamage:Number = 35 + rand(player.lib / 10);
                                var lustDmg2:Number = 1;
                                var pLibImprovedVenomGlandSu:Boolean = player.hasPerk(PerkLib.ImprovedVenomGlandSu);

                                if (player.level < 10) lustdamage += 20 + (player.level * 3);
                                else if (player.level < 20) lustdamage += 50 + (player.level - 10) * 2;
                                else if (player.level < 30) lustdamage += 70 + (player.level - 20) * 1;
                                else lustdamage += 80;
                                lustdamage *= 0.14;
                                if (pLibImprovedVenomGlandSu) lustDmg2 *= 2;
                                lustdamage *= lustDmg2;
                                if (player.armor == armors.ELFDRES && player.isElf()) lustdamage *= 2;
                                if (player.armor == armors.FMDRESS && player.isWoodElf()) lustdamage *= 2;
                                monster.teased(Math.round(monster.lustVuln * lustdamage), false);
                                monster.statStore.addBuffObject({tou:-(lustDmg2*2)}, "Poison",{text:"Poison"});
                                player.tailVenom -= pVenomWebCost;
                                flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                                if (player.tailVenom >= pVenomWebCost) {
                                    monster.teased(Math.round(monster.lustVuln * lustdamage), false);
                                    monster.statStore.addBuffObject({tou:-(lustDmg2*2)}, "Poison",{text:"Poison"});
                                    player.tailVenom -= pVenomWebCost;
                                    flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                                }
                                var dBd1c:Number = 1;
                                if (pLibImprovedVenomGlandSu) dBd1c *= 2;
                                monster.teased(Math.round(monster.lustVuln * lustdamage * dBd1c), false);
                                combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
                                monster.statStore.addBuffObject({spe:-(dBd1c*10)}, "Poison",{text:"Poison"});
                                if (monster.hasStatusEffect(StatusEffects.ManticoreVenom)) monster.addStatusValue(StatusEffects.ManticoreVenom,3,(dBd1c*5));
                                else monster.createStatusEffect(StatusEffects.ManticoreVenom, 0, 0, (dBd1c*5), 0);
                                player.tailVenom -= pVenomWebCost;
                            }
                            outputText(".")
                            ExtraNaturalWeaponAttack(0.5);
                            ExtraNaturalWeaponAttack(0.5);
                            outputText("\n")
                            break;
                        case Tail.RAIJU:
                        case Tail.THUNDERBIRD:
                            outputText("You overcharge your tail in order to deliver a pleasant but electrifying caress to your opponent.");
                            LustyEnergyNaturalWeaponAttack(1);
                            outputText("\n");
                            break;
                        case Tail.SCORPION:
                        case Tail.BEE_ABDOMEN:
                            outputText("You ready your stinger and plunge it deep into your opponent, delivering your poison in the process");
                            ExtraNaturalWeaponAttack(0.5);
                            var dBd2c:Number = 1;
                            //var venomType:StatusEffectType = StatusEffects.BeeVenom;
                            var lustdamage2:Number = 35 + rand(player.lib / 10);
                            var lustDmg3:Number = 1;
                            if (player.level < 10) lustdamage2 += 20 + (player.level * 3);
                            else if (player.level < 20) lustdamage2 += 50 + (player.level - 10) * 2;
                            else if (player.level < 30) lustdamage2 += 70 + (player.level - 20) * 1;
                            else lustdamage2 += 80;
                            lustdamage2 *= 0.14;
                            if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) lustDmg3 *= 2;
                            lustdamage2 *= lustDmg3;
                            if (player.armor == armors.ELFDRES && player.isElf()) lustdamage2 *= 2;
                            if (player.armor == armors.FMDRESS && player.isWoodElf()) lustdamage2 *= 2;
                            monster.teased(Math.round(monster.lustVuln * lustdamage2), false);
                            combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
                            if (monster.hasStatusEffect(StatusEffects.BeeVenom)) monster.addStatusValue(StatusEffects.BeeVenom,3,(dBd2c*5));
                            else monster.createStatusEffect(StatusEffects.BeeVenom, 0, 0, (lustDmg3 * 5), 0);
                            if (player.perkv1(IMutationsLib.SlimeFluidIM) >= 4 && player.HP < player.maxHP()) monster.teased(combat.teases.teaseBaseLustDamage() * monster.lustVuln, false);
                            outputText("\n")
                            break;
                        case Tail.GARGOYLE:
                            outputText("You hit your opponent with a slam of your mighty tail leaving it dazed");
                            switch (Forgefather.channelInlay){
                                case "amethyst":
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "darkness");
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "darkness");
                                    break;
                                case "ruby":
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "fire");
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "fire");
                                    break;
                                case "sapphire":
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "ice");
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "ice");
                                    break;
                                case "topaz":
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "lightning");
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "lightning");
                                    break;
                                default:
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier);
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier);
                                    break;
                            }
                            outputText("\n");
                            break;
                        case Tail.GARGOYLE_2:
                            outputText("You hit your opponent with a slam of your mighty tail");
                            switch (Forgefather.channelInlay){
                                case "amethyst":
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "darkness");
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "darkness");
                                    break;
                                case "ruby":
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "fire");
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "fire");
                                    break;
                                case "sapphire":
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "ice");
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "ice");
                                    break;
                                case "topaz":
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "lightning");
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier, "lightning");
                                    break;
                                default:
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier);
                                    ExtraNaturalWeaponAttack(TailDamageMultiplier);
                                    break;
                            }
                            outputText("\n");
                            break;
                        case Tail.SALAMANDER:
                        case Tail.KITSHOO:
                            outputText("You hit your opponent with a slam of your tail, setting your target on fire");
                            for (var tail:int = player.tailCount; tail > 0; tail--) {
                                if (pFoxFlamePelt) ExtraNaturalWeaponAttack(TailDamageMultiplier, "foxflame");
                                else ExtraNaturalWeaponAttack(TailDamageMultiplier, "fire");
                            }
                            outputText("\n");
                            break;
                        default:
                            outputText("You hit your opponent with a slam of your mighty tail.")
                            if (pLibHellFireCoat) {
                                ExtraNaturalWeaponAttack(TailDamageMultiplier, "fire");
                            } else {
                                ExtraNaturalWeaponAttack(TailDamageMultiplier);
                            }
                            outputText("\n");
                    }
            }
        }
        //Unique attack Mantis Prayer
        if (player.isRaceCached(Races.MANTIS) && player.arms.type == Arms.MANTIS){
            if(player.hasStatusEffect(StatusEffects.InvisibleOrStealth)){
                outputText("Taking advantage of your opponent's obliviousness you strike four more times with your scythes.");
                ExtraNaturalWeaponAttack();
                ExtraNaturalWeaponAttack();
                ExtraNaturalWeaponAttack();
                ExtraNaturalWeaponAttack();
                outputText("\n");
            }
            else{
                outputText("You lunge for two additional slashes, your scythes glinting.");
                ExtraNaturalWeaponAttack();
                ExtraNaturalWeaponAttack();
                outputText("\n");
            }
        }
        //Unique attack Kamaitachi Three way Cut
        if (player.isRaceCached(Races.KAMAITACHI) && player.arms.type == Arms.KAMAITACHI){
            outputText("You strike at blinding speed, seeming to divide yourself into multiple copies, and slash with your scythes again. You cut once, twice, then finish it with a double scythe strike for a three-hit combo. \n");
            ExtraNaturalWeaponAttack(1, "KamaitachiScythe");
            if (player.hasABiteAttack()) {
                outputText("You head in for a bite sinking your teeth in.");
                ExtraNaturalWeaponAttack();
                outputText("\n");
            }
            outputText("You swirl for two more scythe slash.");
            ExtraNaturalWeaponAttack(1, "KamaitachiScythe");
            ExtraNaturalWeaponAttack(1, "KamaitachiScythe");
            outputText("\n");
            if (player.hasABiteAttack()) {
                outputText("You lunge for a final bite drawing blood out.");
                ExtraNaturalWeaponAttack();
                outputText("\n");
            }
        }
        //Unique attack Sea dragon shock
        if (player.antennae.type == Antennae.SEA_DRAGON && player.hasPerk(PerkLib.LightningAffinity)) {
            outputText("You lash out with your whiskers delivering a pair of deadly electrical discharges.");
            var ThunderDamageMultiplier:Number = Math.round(player.inte/100);
            ExtraNaturalWeaponAttack(ThunderDamageMultiplier, "lightning");
            ExtraNaturalWeaponAttack(ThunderDamageMultiplier, "lightning");
            if (rand(100)>95 && !monster.hasPerk(PerkLib.LightningNature) && !monster.hasPerk(PerkLib.LightningAffinity)){
                if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
                    if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
                    outputText(" The discharge leaves your opponent stunned!.");
                }
            }
        }
        // Migrate cerberus check to face checks together
        //Unique attack Slime
        if (player.hasPerk(PerkLib.MorphicWeaponry)) {
            outputText("You form tentacles out of your slimy body and batter your opponent with them.");
            var TentacleDamageMultiplier:Number = Math.round(player.level/10);
            ExtraNaturalWeaponAttack(TentacleDamageMultiplier);
        }
        //Unique attack Alraune
        if (player.isAlraune()) {
            outputText("You lash at your opponent with your many vines, striking twelve times.");
            var x:int = 12;
            while (x-->0) ExtraNaturalWeaponAttack();
            outputText("\n");
        }
        //Unique TENTACLES STRIKES
        if ((player.isScylla() || player.isKraken()) && player.effectiveTallness >= 70){
            outputText("You raise your tentacles and begin to violently slam them against your opponent as if you were trying to wreck a ship.");
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            if(player.isKraken()){
                ExtraNaturalWeaponAttack(1.5);
                ExtraNaturalWeaponAttack(1.5);
            }
            outputText("\n");
        }
        //Unique attack werewolf
        // I really really really want to congregate these isRaceCached attacks together
        if ((player.isRaceCached(Races.WEREWOLF) || player.isRaceCached(Races.CERBERUS)) && player.hasMutation(IMutationsLib.AlphaHowlIM)) {
            var WerewolfPackDamageMultiplier:Number = 0.5;
            var packMembers:Number = LunaFollower.WerewolfPackMember;
            if (player.hasMutation(IMutationsLib.HellhoundFireBallsIM)) packMembers += LunaFollower.HellhoundPackMember;
            outputText("Your beta, Luna, jumps into the melee");
            if (packMembers >= 1){
                outputText("your other pack member");
                if (packMembers >= 2)outputText("s");
                outputText(" joining in to deliver bites and claw swipes from all sides.");
                if (player.perkv3(IMutationsLib.HellhoundFireBallsIM) > 0)
                    WerewolfPackDamageMultiplier += (packMembers/2);
            }
            ExtraNaturalWeaponAttack(WerewolfPackDamageMultiplier);
        }
    }

    public function CommasForDigits(damage:Number, lustColor:Boolean = false, text:String = "", elementTag:String = ""):void {
        var numberformat:NumberFormatter = new NumberFormatter();
        var dmgText:String = numberformat.format(Math.floor(Math.abs(damage)));
        if (elementTag == ""){
            outputText("<b>([font-" + (damage < 0 ? "heal" : damage == 0 ? "miss" : lustColor ? "lust" : "damage") + "]" + text + dmgText + "[/font])</b>");
        }
        else {
            outputText("<b>[font-" + elementTag + "](" + text + dmgText + " " + elementTag + ")[/font]</b>");
        }
        /*
        var damagemsg:Array = new Array(String(damage).length);
        var damageTemp:Number = damage;
        if (elementTag != ""){
            outputText("<b>[font-" + elementTag + "]([/font]</b>");
        }
        else{
            outputText("<b>(</b>");
        }
        for (var i:int = 0; i < damagemsg.length; i++) {
            damagemsg[i] = int(damageTemp % 10);
            damageTemp = Math.floor(damageTemp / 10);
        }
        for (var j:int = 0, k:int = (damagemsg.length % 3); j < damagemsg.length; j++) {
            if (k == 0) {
                if (j != 0) outputText(",");
                k = 3;
            }
            if (elementTag == ""){
                outputText("<b>[font-" + (damage < 0 ? "heal" : damage == 0 ? "miss" : lustColor ? "lust" : "damage") + "]" + text + String(damagemsg[damagemsg.length - j - 1]) + "[/font]</b>");
            }
            else{
                outputText("<b>[font-" + elementTag + "]" + text + String(damagemsg[damagemsg.length - j - 1])+"[/font]</b>");
            }
            k--;
        }
        if (elementTag != ""){
            outputText("<b>[font-" + elementTag + "] "+ elementTag +")[/font]</b>");
        }
        else{
            outputText("<b>)</b>");
        }
        */
    }

    /**
     * Cached Melee damage calculation
     * 1. Basic damage (feral: tou, Elf spear: inte, MGE: inte, else str)
     * 2. Bonus from perks & weapontype, weapon, mastery, perks, status effects, items, melee perks
     * @param IsFeralCombat
     * @param damage
     * @return damage calulation
     */
	public function meleeDamageNoLagSingle(IsFeralCombat:Boolean = false, damage:Number = 0):Number {
		if (IsFeralCombat && player.hasPerk(PerkLib.RampantMight)) {
            damage += player.tou;
			damage += scalingBonusToughness() * 0.2;
            damage += player.str;
			damage += scalingBonusStrength() * 0.2;
        }
        else if (IsFeralCombat && player.hasPerk(PerkLib.VerdantMight)) {
			damage += player.tou;
			damage += scalingBonusToughness() * 0.2;
		}
		else {
			if (player.isElf() && player.isSpearTypeWeapon() && player.hasPerk(PerkLib.ELFElvenBattleStyle)) {
				damage += player.inte;
				damage += scalingBonusIntelligence() * 0.2;
				if (player.hasPerk(PerkLib.ELFElvenSpearDancingFlurry1to4)) damage*=1+(0.2*player.perkv1(PerkLib.ELFElvenSpearDancingFlurry1to4));
			}
			else if (player.weapon == weapons.MGSWORD || player.weapon == weapons.MCLAWS || player.weapon is Tidarion || player.isInGoblinMech() || player.isInNonGoblinMech()) {
				damage += player.inte;
				damage += scalingBonusIntelligence() * 0.2;
			}
			else {
				damage += player.str;
				damage += scalingBonusStrength() * 0.2;
			}
		}
		if (player.hasPerk(PerkLib.SpeedDemon) && player.isNoLargeNoStaffWeapon()) {
			damage += player.spe;
			damage += scalingBonusSpeed() * 0.20;
			if (player.hasStatusEffect(StatusEffects.JabbingStyle)) damage += player.spe * player.statusEffectv1(StatusEffects.JabbingStyle);
		}
		if (player.hasPerk(PerkLib.QuickStrike) && player.weapon.isSmall()) {
			damage += (player.spe / 2);
			damage += scalingBonusSpeed() * 0.10;
		}
		if (player.hasPerk(PerkLib.PowerAttack)) {
			if (player.hasPerk(PerkLib.PowerAttackEx)) damage *= 1.5;
			else damage *= 1.2;
		}
        damage = harpyDamageBonus(damage);
		if ((player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) && player.isFistOrFistWeapon()){
			damage *= 2;
			if (player.perkv1(IMutationsLib.YetiFatIM) >= 2) damage *= 1.5;
			if (player.perkv1(IMutationsLib.YetiFatIM) >= 3) damage *= 1.5;
		}
		if (player.gaindHoldWithBothHandBonus()) damage *= 1.5;
		if (player.hasPerk(PerkLib.DivineArmament) && (player.isUsingStaff() || player.isUsingWand() || player.isPartiallyStaffTypeWeapon()) && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) damage *= 3;
		if (player.weapon.isDual()) damage *= meleeDualWieldDamagePenalty();
        //Weapon addition!
        damage = weaponAttackModifier(damage);
		damage *= calculateMeleeDamageMultiplier();
        if (damage < 10) damage = 10;
		//All special weapon effects like...fire/ice
		if (player.weapon == weapons.L_WHIP || player.weapon == weapons.DL_WHIP || player.weapon == weapons.TIDAR)
            damage = fireTypeDamageBonus(damage);
		if (isPureWeapon()  || Forgefather.purePearlEaten) {
			damage = monsterPureDamageBonus(damage);
		}
		if (isCorruptWeapon() || Forgefather.lethiciteEaten) {
            damage = monsterCorruptDamageBonus(damage);
		}
        //Bonus sand trap / alraune damage!
        if (monster.hasStatusEffect(StatusEffects.Level) && (monster is SandTrap || monster is Alraune)) damage = Math.round(damage * 1.75);
		if (flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon()) && player.hasStatusEffect(StatusEffects.WinterClaw)) {
			damage *= 2.2;
			damage = iceTypeDamageBonusLarge(damage);
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
            if (player.isRaceCached(Races.MOUSE, 2) && player.countRings(jewelries.INMORNG)) damage *= 2.2;
            else damage *= 2;
            damage = fireTypeDamageBonusLarge(damage);
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
            damage = fireTypeDamageBonus(damage);
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
		}
		if (player.flameBladeActive()) {
            damage += scalingBonusLibido() * 0.20;
            damage = fireTypeDamageBonus(damage);
        }
		if (player.weapon == weapons.BFGAUNT || player.hasAetherTwinsTier2()) damage *= 2;
		if (player.weapon == weapons.FRTAXE && monster.isFlying()) damage *= 1.5;
		if (player.weapon == weapons.VENCLAW && flags[kFLAGS.FERAL_COMBAT_MODE] == 1) damage *= 1.2;
		if (player.weapon == weapons.ARMAGED) damage *= 1.5;
        if (player.hasPerk(PerkLib.LifeLeech) && player.isFistOrFistWeapon()) {
            if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) damage *= 1.1;
            else damage *= 1.05;
        }
        if (player.isSpearTypeWeapon() && player.hasPerk(PerkLib.ElvenRangerArmor)) damage *= 1.5;
        if ((player.weapon == weapons.S_RULER || player.weapon == weapons.TSRULER) && (monster.hasPerk(PerkLib.EnemyHugeType) || monster.hasPerk(PerkLib.EnemyGigantType) || monster.hasPerk(PerkLib.EnemyColossalType))) damage *= 1.5;
		if (monster.hasStatusEffect(StatusEffects.Stunned) && player.isMaceHammerTypeWeapon() && player.hasPerk(PerkLib.Backbreaker)) damage *= 1.5;
        // Mastery bonus damage
		if (IsFeralCombat) damage *= MasteryBonusDamageMelee(true);
		else damage *= MasteryBonusDamageMelee();
		//Thunderous Strikes
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.ChiReflowMagic)) damage *= UmasShop.NEEDLEWORK_MAGIC_REGULAR_MULTI;
		if (player.hasPerk(PerkLib.ChiReflowAttack)) damage *= UmasShop.NEEDLEWORK_ATTACK_REGULAR_MULTI;
		damage = statusEffectBonusDamage(damage);
		damage = itemsBonusDamageDamage(damage);
		if (player.hasPerk(PerkLib.GoblinoidBlood)) {
			if (player.hasKeyItem("Power bracer") >= 0) damage *= 1.1;
			if (player.hasKeyItem("Powboy") >= 0) damage *= 1.15;
			if (player.hasKeyItem("M.G.S. bracer") >= 0) damage *= 1.2;
		}
        if (player.statStore.hasBuff("AsuraForm")) {
			var AFAAM:Number = 3;
            if (player.hasPerk(PerkLib.AsuraStrength)) AFAAM += 1;
			if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) AFAAM += 1;
			if (player.hasPerk(PerkLib.ItsZerkingTime)) AFAAM += 1;
			if (player.isUnarmedCombat() && player.playerHasFourArms()) AFAAM *= 0.5;
            damage *= AFAAM;
        }
		if (SceneLib.urtaQuest.isUrta()) damage *= 2;
		damage *= meleePhysicalForce();
		return damage;
	}

	public function meleeUnarmedDamageNoLagSingle(subtype:Number = 0, IsFeralCombat:Boolean = false):Number {
		var damage:Number = 0;
		if (player.hasPerk(PerkLib.RampantMight)) {
            damage += player.tou;
			damage += scalingBonusToughness() * 0.25;
            damage += player.str;
			damage += scalingBonusStrength() * 0.25;
        }
        else if (player.hasPerk(PerkLib.VerdantMight)){
            damage += player.tou;
            damage += scalingBonusToughness() * 0.25;
        }
        else{
            damage += player.str;
            damage += scalingBonusStrength() * 0.25;
        }
        if (subtype == 1) {
            damage += player.tou;
            damage += scalingBonusToughness() * 0.25;
        }
        if (subtype == 2) {
            damage += player.spe;
            damage += scalingBonusSpeed() * 0.25;
        }
        if (subtype == 3) {
            damage += player.inte;
			damage += scalingBonusIntelligence() * 0.25;
        }
        damage += unarmedAttack();
		if (damage < 10) damage = 10;
        damage = harpyDamageBonus(damage);
        damage = itemsBonusDamageDamage(damage);
        damage = statusEffectBonusDamage(damage);
        //PERKS
        if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
        if (player.hasPerk(PerkLib.ChiReflowMagic)) damage *= UmasShop.NEEDLEWORK_MAGIC_REGULAR_MULTI;
        if (player.hasPerk(PerkLib.ChiReflowAttack)) damage *= UmasShop.NEEDLEWORK_ATTACK_REGULAR_MULTI;
        if (player.hasPerk(PerkLib.GoblinoidBlood)) {
            if (player.hasKeyItem("Power bracer") >= 0) damage *= 1.1;
            if (player.hasKeyItem("Powboy") >= 0) damage *= 1.15;
            if (player.hasKeyItem("M.G.S. bracer") >= 0) damage *= 1.2;
        }
        if ((player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet))) damage *= 2;
		if (!IsFeralCombat) damage *= (1 + (0.01 * masteryUnarmedCombatLevel()));
        else damage *= (1 + (0.01 * masteryFeralCombatLevel()));
		damage *= meleePhysicalForce();
		return damage;
	}

	public function rangeDamageNoLagSingle(subtype:Number = 0):Number {
		var damage:Number = 0;//0 - bow, 1 - crossbow, 2 - thrown
		if (subtype == 0) {
			damage += player.str;
            damage += scalingBonusStrength() * 0.2;
			damage += player.spe * 2;
			damage += scalingBonusSpeed() * 0.4;
			if (damage < 20) damage = 20;
            damage *= (1 + (0.01 * masteryArcheryLevel()));
		}
		if (subtype == 1) {
			damage += player.weaponRangeAttack * 20;
			damage += player.spe * 2;
			damage *= (1 + (0.01 * masteryArcheryLevel()));
		}
		if (subtype == 2) {
			damage += player.str * 2;
            damage += scalingBonusStrength() * 0.4;
			damage += player.spe;
			damage += scalingBonusSpeed() * 0.2;
            if (player.hasPerk(PerkLib.Telekinesis)){
                damage += player.inte;
                damage += scalingBonusIntelligence() * 0.4;
            }
            if (player.hasPerk(PerkLib.DeadlyThrow)) damage += player.spe;
            if (damage < 20) damage = 20;
            damage *= (1 + (0.01 * masteryThrowingLevel()));
            damage = statusEffectBonusDamage(damage);
		}
		if (player.hasPerk(PerkLib.PowerShot)) {
			if (player.hasPerk(PerkLib.PowerShotEx)) damage *= 1.5;
			else damage *= 1.2;
		}
        damage = rangeAttackModifier(damage);
        damage = archerySkillDamageMod(damage);
        damage *= player.jewelryRangeModifier();
		damage *= rangePhysicalForce();
		return damage;
	}
	public function firearmsDamageNoLagSingle():Number {
		var damage:Number = 0;
		damage += player.weaponRangeAttack * 2;
		damage += player.speStat.core.value + player.intStat.core.value + player.wisStat.core.value;
        if (player.hasPerk(PerkLib.JobGunslinger)) damage *= 2;
        if (player.hasPerk(PerkLib.ChurchOfTheGun)) damage += scalingBonusWisdom() * 0.5;
        if (player.hasPerk(PerkLib.AlchemicalCartridge)) damage += scalingBonusIntelligence() * 0.25;
		if (player.hasPerk(PerkLib.SaintOfZariman)) {
			damage += scalingBonusSpeed() * 0.25;
			damage += scalingBonusIntelligence() * 0.25;
			damage += scalingBonusWisdom() * 0.5;
		}
		damage *= (1 + (0.01 * masteryFirearmsLevel()));
        damage = rangeAttackModifier(damage);
        damage = archerySkillDamageMod(damage);
        damage *= player.jewelryRangeModifier();
		damage *= firearmsForce();
		return damage;
	}
	
	public function MasteryBonusDamageMelee(IsFeralCombat:Boolean = false):Number {
		var Mastery_bonus_damage:Number = 1;
		if (player.isFistOrFistWeapon()) {
			if (IsFeralCombat) Mastery_bonus_damage += 0.01 * masteryFeralCombatLevel();
			else {
				if (player.isGauntletWeapon()) Mastery_bonus_damage += 0.01 * masteryGauntletLevel();
				else Mastery_bonus_damage += 0.01 * masteryUnarmedCombatLevel();
			}
		}
		if (player.isSwordTypeWeapon()) Mastery_bonus_damage += 0.01 * masterySwordLevel();
		if (player.isAxeTypeWeapon()) Mastery_bonus_damage += 0.01 * masteryAxeLevel();
		if (player.isMaceHammerTypeWeapon()) Mastery_bonus_damage += 0.01 * masteryMaceHammerLevel();
		if (player.isDuelingTypeWeapon()) Mastery_bonus_damage += 0.01 * masteryDuelingSwordLevel();
		if (player.isPolearmTypeWeapon()) Mastery_bonus_damage += 0.01 * masteryPolearmLevel();
		if (player.isSpearTypeWeapon()) Mastery_bonus_damage += 0.01 * masterySpearLevel();
		if (player.isDaggerTypeWeapon()) Mastery_bonus_damage += 0.01 * masteryDaggerLevel();
		if (player.isWhipTypeWeapon()) Mastery_bonus_damage += 0.01 * masteryWhipLevel();
		if (player.isExoticTypeWeapon()) Mastery_bonus_damage += 0.01 * masteryExoticLevel();
		if (player.weapon.isDualSmall()) Mastery_bonus_damage += 0.01 * dualWSLevel();
		if (player.weapon.isDualMedium()) Mastery_bonus_damage += 0.01 * dualWNLevel();
		if (player.weapon.isDualLarge()) Mastery_bonus_damage += 0.01 * dualWLLevel();
		if (player.weapon.isDualMassive()) Mastery_bonus_damage += 0.01 * dualWMLevel();
        var weaponSize:Number = 1;
        if( player.weapon.isSmall() ) weaponSize = 0;
        if( player.weapon.isLarge() ) weaponSize = 2;
        if( player.weapon.isMassive() ) weaponSize = 3;
        if (weaponSize == 0) Mastery_bonus_damage += 0.01 * weaponSizeSmall();
        if (weaponSize == 1) Mastery_bonus_damage += 0.01 * weaponSizeNormal();
        if (weaponSize == 2) Mastery_bonus_damage += 0.01 * weaponSizeLarge();
        if (weaponSize == 3) Mastery_bonus_damage += 0.01 * weaponSizeMassive();
		if (player.compatibileSwordImmortalWeapons() && player.hasPerk(PerkLib.HiddenJobSwordImmortal)) Mastery_bonus_damage *= 2;
		return Mastery_bonus_damage;
	}

    /*
     * Calculate Crit Potential
     */
    private function calculateCrit():int{
        var critChance:Number = 5;
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        else {
            critChance += combatPhysicalCritical();
            if (player.isSwordTypeWeapon()) critChance += 10;
            if (player.isDuelingTypeWeapon()) critChance += 20;
            if (player.hasPerk(PerkLib.JobDervish) && (!player.weapon.isLarge() || !player.weapon.isStaffType())) critChance += 10;
            if (player.hasPerk(PerkLib.WeaponMastery) && player.weapon.isSingleLarge() && player.str >= 100) critChance += 10;
            if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weapon.isDualLarge() && player.str >= 140) critChance += 10;
            if (player.hasPerk(PerkLib.GigantGripEx) && (player.weapon.isMassive())) {
                if (player.hasPerk(PerkLib.WeaponMastery) && player.str >= 100) critChance += 10;
                if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.str >= 140) critChance += 10;
            }
            if (player.weapon == weapons.MASAMUN || (player.weapon == weapons.WG_GAXE && monster.cor > 66) || (player.weapon == weapons.DE_GAXE && monster.cor < 33)) critChance += 10;
			if (player.weapon == weapons.YAMARG && monster.cor < 33) critChance += 20;
        }
        return critChance;
    }
    private function calculateCritDamage():Number{
        var critDamage:Number = 1.75;
        critDamage += bonusCriticalDamageFromMissingHP();
        if ((player.weapon == weapons.WG_GAXE && monster.cor > 66) || (player.weapon == weapons.DE_GAXE && monster.cor < 33)) critDamage += 0.1;
        if (player.hasPerk(PerkLib.OrthodoxDuelist) && player.isDuelingTypeWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) critDamage += 0.2;
        if (player.hasStatusEffect(StatusEffects.AlterBindScroll4)) critDamage += 1;
		if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) critDamage *= impaleMultiplier();
        if (player.hasPerk(PerkLib.SkilledFighterEx) && calculateCrit() > 100) {
			if (calculateCrit() > 200) critDamage *= 3;
			else critDamage *= 2;
		}
        return critDamage;
    }
	
    private function calculateCritRange():int{
        var critChance:Number = 5;
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        else {
            critChance += combatPhysicalCritical();
            if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
			if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
			if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "bow") critChance += 20;
			if (player.weaponRangePerk == "Throwing") {
				if (player.weaponRangeName == "gnoll throwing axes") critChance += 10;
				if (player.hasPerk(PerkLib.AnatomyExpert)) critChance += 10;
			}
		}
        return critChance;
    }
    private function calculateCritDamageRange():Number{
        var critDamage:Number = 1.75;
        if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") critDamage += 2;
		if (player.weaponRangePerk == "Throwing") {
			if (player.hasPerk(PerkLib.AnatomyExpert)) critDamage += 0.5;
			if (player.hasPerk(PerkLib.PrestigeJobStalker)) critDamage += 0.2;
		}
		if (player.hasPerk(PerkLib.SkilledRangerEx) && calculateCrit() > 100) {
			if (calculateCrit() > 200) critDamage *= 3;
			else critDamage *= 2;
		}
        return critDamage;
    }
	
    private function calculateCritFirearms():int{
        var critChance:Number = 5;
        if ((monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) || player.weaponRange == weaponsrange.TRFATBI) critChance = 0;
        else {
            critChance += combatPhysicalCritical();
            if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
            if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
        }
        return critChance;
    }
    private function calculateCritDamageFirearms():Number{
        var critDamage:Number = 1.75;
        if (player.hasPerk(PerkLib.SilverForMonsters) && monster.hasPerk(PerkLib.EnemyTrueDemon)) critDamage += 0.5;
		if (player.hasPerk(PerkLib.SkilledGunslingerEx) && calculateCrit() > 100) {
			if (calculateCrit() > 200) critDamage *= 3;
			else critDamage *= 2;
		}
        return critDamage;
    }
	
    private function calculateMeleeDamageMultiplier():Number{
        var damageMult:Number = 1;
        //Sneak attack checks
        if (player.isDaggerTypeWeapon()){
            if (monster.isIncapacitated()){
				if (player.hasPerk(PerkLib.SneakyAttack)) damageMult += 1;
                if (player.hasPerk(PerkLib.DeadlySneaker)) damageMult += 2;
                if (player.hasPerk(PerkLib.Slayer)) damageMult += 3;
            }
        }
        return damageMult;
    }
	
    public function calculateRangeDamageMultiplier():Number{
        var damageMult:Number = 1;
        //Sneak attack checks
        if (player.hasPerk(PerkLib.MarkedForDeath) && player.haveWeaponForSneakAttackRange()){
            if (monster.isIncapacitated()){
				if (player.hasPerk(PerkLib.SneakyAttack)) damageMult += 1;
                if (player.hasPerk(PerkLib.DeadlySneaker)) damageMult += 2;
                if (player.hasPerk(PerkLib.Slayer)) damageMult += 3;
            }
        }
        return damageMult;
    }

    private function meleeMasteryGain(hit:int, crit:int):void{
        var baseMasteryXP:Number = 1;
        if (player.hasPerk(PerkLib.MeleeWeaponsMastery)) baseMasteryXP += 2;
        if (player.compatibileSwordImmortalWeapons() && player.hasPerk(PerkLib.HiddenJobSwordImmortal)) baseMasteryXP += 2;
        if (monster is TrainingDummy && flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 1) {
            var bMXPMulti:Number = 1;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 2) bMXPMulti += 1.5;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 3) bMXPMulti += 2;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 4) bMXPMulti += 2.5;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 5) bMXPMulti += 3;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 6) bMXPMulti += 5;
			baseMasteryXP *= bMXPMulti;
        }
        if (player.weapon == weapons.CHAOSEA) baseMasteryXP *= 4;
		if (player.weapon == weapons.B_SWORD || player.weapon == weapons.B_WHIP) baseMasteryXP *= 2;
        var masteryXPCrit:Number = baseMasteryXP * crit * 2;
        if (player.hasPerk(PerkLib.MeleeWeaponsMasteryEx)) masteryXPCrit *= 2;
        var masteryXPNatural:Number = baseMasteryXP * (hit - crit);
        var meleeMasteryEXPgains:Number = masteryXPCrit + masteryXPNatural;
		if (player.hasMutation(IMutationsLib.HumanVersatilityIM) && player.perkv1(IMutationsLib.HumanVersatilityIM) >= 3 && rand(5) == 0) meleeMasteryEXPgains *= 3;
        if (player.isGauntletWeapon()) gauntletXP(meleeMasteryEXPgains);
        if (player.isSwordTypeWeapon()) swordXP(meleeMasteryEXPgains);
        if (player.isAxeTypeWeapon()) axeXP(meleeMasteryEXPgains);
        if (player.isMaceHammerTypeWeapon()) macehammerXP(meleeMasteryEXPgains);
        if (player.isDuelingTypeWeapon()) duelingswordXP(meleeMasteryEXPgains);
        if (player.isPolearmTypeWeapon()) polearmXP(meleeMasteryEXPgains);
        if (player.isSpearTypeWeapon()) spearXP(meleeMasteryEXPgains);
        if (player.isDaggerTypeWeapon()) daggerXP(meleeMasteryEXPgains);
        if (player.isWhipTypeWeapon()) whipXP(meleeMasteryEXPgains);
        if (player.isExoticTypeWeapon()) exoticXP(meleeMasteryEXPgains);
        if (player.weapon.isDualSmall() || player.hasAetherTwinsTierS2()) dualWieldSmallXP(meleeMasteryEXPgains);
        if (player.weapon.isDualMedium()) dualWieldNormalXP(meleeMasteryEXPgains);
        if (player.weapon.isDualLarge()) dualWieldLargeXP(meleeMasteryEXPgains);
        if (player.weapon.isDualMassive()) dualWieldMassiveXP(meleeMasteryEXPgains);
        if (player.isFeralCombat()) feralCombatXP(meleeMasteryEXPgains);
        else if (flags[kFLAGS.FERAL_COMBAT_MODE] != 1 && player.weaponName == "fists") unarmedCombatXP(meleeMasteryEXPgains);
        else if (player.weapon.isSmall() || player.hasAetherTwinsTierWeapon() || player.hasAetherTwinsTierWeapon2()) weaponSmallMastery(meleeMasteryEXPgains);
        else if (player.weapon.isLarge()) weaponLargeMastery(meleeMasteryEXPgains);
        else if (player.weapon.isMassive()) weaponMassiveMastery(meleeMasteryEXPgains);
        else weaponNormalMastery(meleeMasteryEXPgains);
    }
	public function meleeUnarmedMasteryGain(hit:int, crit:int):void{
		var baseMasteryXP:Number = 1;
		if (monster is TrainingDummy && flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 1) {
            var bMXPMulti:Number = 1;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 2) bMXPMulti += 1.5;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 3) bMXPMulti += 2;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 4) bMXPMulti += 2.5;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 5) bMXPMulti += 3;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 6) bMXPMulti += 5;
			baseMasteryXP *= bMXPMulti;
        }
		var masteryXPCrit:Number = baseMasteryXP * crit * 2;
        var masteryXPNatural:Number = baseMasteryXP * (hit - crit);
        var meleeMasteryEXPgains:Number = masteryXPCrit + masteryXPNatural;
		if (player.hasMutation(IMutationsLib.HumanVersatilityIM) && player.perkv1(IMutationsLib.HumanVersatilityIM) >= 3 && rand(5) == 0) meleeMasteryEXPgains *= 3;
		unarmedCombatXP(meleeMasteryEXPgains);
	}

    /**
     * Do melee attack
     * 1. Check accuracy
     * 2. Attack
     * - get cached damage or do meleeDamageNoLagSingle()
     * - check crit
     * - check miss (anemones)
     * - doppleganger mirror attack (lose all dmg)
     * - huntsman cane (lose 50% dmg)
     * - lightning claw lust attack
     * - describe attack
     * - do damage
     * - mastery exp gains
     * 3. montser counter attacks
     * 4. lust damage
     * 5. status effects proc
     * 7. repeat for multi-attack style
     * @param IsFeralCombat
     */
    public function meleeDamageAcc(IsFeralCombat:Boolean = false):void {
        //var timer:int = getTimer();
        var accMelee:Number = 0;
        var damage:Number = 0;
        accMelee += (meleeAccuracy() / 2);
        if (flags[kFLAGS.ATTACKS_ACCURACY] > 0) accMelee -= flags[kFLAGS.ATTACKS_ACCURACY];
        if (player.weaponName == "Truestrike sword") accMelee = 100;
        //Determine if critical hit!
        var crit:Boolean = false;
        var critCounter:int = 0;
        var critChance:Number = calculateCrit();
        var critDamage:Number = calculateCritDamage();
        var hitCounter:int = 0;
        var fireDamage:Number = fireDamageBoostedByDao();
        var iceDamage:Number = iceDamageBoostedByDao();
        var lightningDamage:Number = lightningDamageBoostedByDao();
        var darkDamage:Number = darknessDamageBoostedByDao();
        if (player.weapon is Tidarion) meleeDamageNoLag = 0; //recalc damage for current mana.. okay, get it, multi-attackers-fuckers!


        var boolSwiftCast:Boolean = player.hasPerk(PerkLib.SwiftCasting) && flags[kFLAGS.ELEMENTAL_MELEE] > 0 && (player.isOneHandedWeapons() || player.weapon == weapons.ATWINSCY || (player.weapon.isSingleLarge() && player.hasPerk(PerkLib.GigantGrip)) || (player.weapon.isSingleMassive() && player.hasPerk(PerkLib.TitanGrip))) && player.isHavingFreeOffHand();
        var boolLifeLeech:Boolean = player.hasPerk(PerkLib.LifeLeech) && player.isFistOrFistWeapon();
        var boolFistingIs300Bucks:Boolean = player.isFistOrFistWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise();

        for(var i:int = 1; i <= flags[kFLAGS.MULTIPLE_ATTACKS_STYLE]; i++){
            damage = 0;
            if (rand(100) < accMelee) { // Attack hits... do stuff
                //  get the raw damage value here
                if (meleeDamageNoLag != 0) damage += meleeDamageNoLag;
                else {
                    var temp:Number = meleeDamageNoLagSingle(IsFeralCombat);
                    meleeDamageNoLag += temp;
                    damage += temp;
                }
                //ANEMONE SHIT
                // I think I should just change the mechanic completely and intuite based on the comment
                // The intention of anemone check seems to be: allows first melee attack and skip the rest of the proc if check passes
                // Flavor text migrate to preMeleeSkip(), attack skip executed in postMeleeDmgSkip later here
                crit = rand(100) < critChance;
                if(crit) damage *= critDamage;
                hitCounter++;
                damage = Math.round(damage);
                // Have to put it before doDamage, because doDamage applies the change, as well as status effects and shit.
                // Migrate mirror
                // Migrate LabGuard shieldWall check
                // Migrate anemone/seaanemone skip check
                // This is a long ass spaghet
                damage = monster.preMeleeDmg(damage);
                if (player.weapon is HuntsmansCane) {
                    outputText(randomChoice("You swing your cane through the air. The light wood lands with a loud CRACK that is probably more noisy than painful. ",
                            "You brandish your cane like a sword, slicing it through the air. It thumps against your adversary, but doesn’t really seem to harm them much. "));
                    damage *= 0.5;
                }
                else if ((damage <= 0) && ((MDOCount == maxCurrentRangeAttacks()) && (MSGControllForEvasion) && (!MSGControll))) {
                    damage = 0;
                    outputText("Your attacks are deflected by [themonster].");
                }
                else {
                    if (player.weapon == weapons.VBLADE) {
                        var vbladeeffect:Boolean = false;
                        var vbladeeffectChance:int = 1;
                        if (rand(100) < vbladeeffectChance) {
                            vbladeeffect = true;
                            damage *= 5;
                        }
                    }
                    //FERAL COMBAT
                    if (flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && (player.hasNaturalWeapons() || player.haveNaturalClawsTypeWeapon())) {
                        //DOING BASIC EXTRA NATURAL ATTACKS
                        outputText("You savagely strike [themonster] with your natural weapons.");
                        if (player.hasPerk(PerkLib.LightningClaw)) {
                            var damageLC:Number;
                            damageLC = 6 + rand(3);
                            if (player.hasPerk(PerkLib.SensualLover)) damageLC += 2;
                            if (player.hasPerk(PerkLib.Seduction)) damageLC += 5;
                            //+ slutty armor bonus
                            damageLC += player.teaseDmgStat.value;
                            if (player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)) damageLC += 5;
                            if (player.hasPerk(PerkLib.FlawlessBody)) damageLC += 10;
                            damageLC += scalingBonusLibido() * 0.1;
                            if (player.hasPerk(PerkLib.JobSeducer)) damageLC += player.teaseLevel * 3;
                            else damageLC += player.teaseLevel * 2;
                            //partial skins bonuses
                            switch (player.coatType()) {
                                case Skin.FUR:
                                    damageLC += (1 + player.newGamePlusMod());
                                    break;
                                case Skin.SCALES:
                                    damageLC += (2 * (1 + player.newGamePlusMod()));
                                    break;
                                case Skin.CHITIN:
                                    damageLC += (3 * (1 + player.newGamePlusMod()));
                                    break;
                                case Skin.BARK:
                                    damageLC += (4 * (1 + player.newGamePlusMod()));
                                    break;
                            }
                            //slutty simplicity bonus
                            if (player.hasPerk(PerkLib.SluttySimplicity) && player.armor.hasTag(ItemConstants.A_REVEALING)) damageLC *= (1 + ((10 + rand(11)) / 100));
                            damageLC *= .7;
                            var damagemultiplier:Number = 1;
                            if (player.hasPerk(PerkLib.ElectrifiedDesire)) damagemultiplier += player.lust100 * 0.01;
                            if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) damagemultiplier += combat.historyWhoreBonus();
                            if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 10) damagemultiplier += 0.2;
                            if (player.perkv1(IMutationsLib.RaijuCathodeIM) >= 1) damagemultiplier += 0.5;
                            if (player.perkv1(IMutationsLib.RaijuCathodeIM) >= 2) damagemultiplier += 0.5;
                            if (player.perkv1(IMutationsLib.RaijuCathodeIM) >= 3) damagemultiplier += 1;
                            if (player.armorName == "desert naga pink and black silk dress") damagemultiplier += 0.1;
                            if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
                            if (player.armor == armors.ELFDRES && player.isElf()) damagemultiplier += 2;
                            if (player.armor == armors.FMDRESS && player.isWoodElf()) damagemultiplier *= 2;
                            damageLC *= damagemultiplier;
                            //Determine if critical tease!
                            var crit1:Boolean = false;
                            var critChance1:int = 5;
                            critChance1 += teases.combatTeaseCritical();
                            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance1 = 0;
                            if (rand(100) < critChance1) {
                                crit1 = true;
                                damageLC *= 1.75;
                            }
                            if (player.hasPerk(PerkLib.ChiReflowLust)) damageLC *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
                            if (player.hasPerk(PerkLib.RacialParagon)) damageLC *= RacialParagonAbilityBoost();
                            damageLC = damageLC * 0.33 * monster.lustVuln;
                            damageLC = Math.round(damageLC);
                            monster.teased(damageLC);
                            if (crit1) outputText(" <b>Critical!</b>");
                            outputText(" ");
                            if (player.hasPerk(PerkLib.SuperSensual) && player.hasPerk(PerkLib.Sensual)) teaseXP(2);
                            else teaseXP(1);
                        }
                    } else if (vbladeeffect) outputText("As you strike, the sword shines with a red glow. The sword twists in your hand, guiding you right at [themonster]'s throat. ");
                    else if (!MSGControll) {
                        outputText("You "+player.weaponVerb+" [themonster]! "); // for not displaying the same msg a lot of times.
                    }
                    // If Crit... do this thing here
                    if (crit) {
                        critCounter++;
                        outputText("<b>Critical! </b>");
                        if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
                    }
                    else if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
                        if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
                        else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
                    }
                    //Damage is delivered HERE
                    if (isFireTypeWeapon()) {
                        damage = Math.round(damage * fireDamage);
						if (canLayerSwordIntentAura()) damage += layerSwordIntentAuraOnThis(damage);
						doFireDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
                    }
                    else if (isIceTypeWeapon()) {
                        damage = Math.round(damage * iceDamage);
						if (canLayerSwordIntentAura()) damage += layerSwordIntentAuraOnThis(damage);
                        doIceDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
                    }
                    else if (isLightningTypeWeapon()) {
                        damage = Math.round(damage * lightningDamage);
						if (canLayerSwordIntentAura()) damage += layerSwordIntentAuraOnThis(damage);
                        doLightningDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
                    }
                    else if (isDarknessTypeWeapon()) {
                        damage = Math.round(damage * darkDamage);
						if (canLayerSwordIntentAura()) damage += layerSwordIntentAuraOnThis(damage);
                        doDarknessDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
                    }
                    else if (isPlasmaTypeWeapon()) {
						if (canLayerSwordIntentAura()) damage += layerSwordIntentAuraOnThis(damage);
                        doPlasmaDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
                    }
                    else if (isUnarmedCombatButDealFireDamage()) {
                        damage = Math.round(damage * fireDamage);
						doFireDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
						if (player.perkv1(IMutationsLib.SlimeFluidIM) >= 4 && player.HP < player.maxHP()) monster.teased(combat.teases.teaseBaseLustDamage() * monster.lustVuln);
						doFireDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
						if (player.perkv1(IMutationsLib.SlimeFluidIM) >= 4 && player.HP < player.maxHP()) monster.teased(combat.teases.teaseBaseLustDamage() * monster.lustVuln);
						if (player.playerHasFourArms()) {
							doFireDamage(damage, true, true);
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
							doFireDamage(damage, true, true);
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
						}
                    }
					else if (isUnarmedCombatButDealIceDamage()) {
						damage = Math.round(damage * iceDamage);
                        doIceDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
						if (player.perkv1(IMutationsLib.SlimeFluidIM) >= 4 && player.HP < player.maxHP()) monster.teased(combat.teases.teaseBaseLustDamage() * monster.lustVuln);
                        doIceDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
						if (player.perkv1(IMutationsLib.SlimeFluidIM) >= 4 && player.HP < player.maxHP()) monster.teased(combat.teases.teaseBaseLustDamage() * monster.lustVuln);
						if (player.playerHasFourArms()) {
							doIceDamage(damage, true, true);
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
							doIceDamage(damage, true, true);
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
						}
					}
                    else if (player.hasStatusEffect(StatusEffects.ChargeWeapon) && !player.isUnarmedCombat()) {
						if (canLayerSwordIntentAura()) damage += layerSwordIntentAuraOnThis(damage);
						doPhysicalDamage(damage, true, true);
                        doMagicDamage(Math.round(damage * 0.2), true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
					}
                    else if (player.weapon == weapons.MGSWORD) {
						if (canLayerSwordIntentAura()) damage += layerSwordIntentAuraOnThis(damage);
						doMagicDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
					}
                    else if (player.weapon == weapons.MCLAWS) {
						doMagicDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
                        doMagicDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
					}
                    else if (player.weapon == weapons.PHALLUS || player.weapon == weapons.PHALUSS) {
                        if (player.statusEffectv1(StatusEffects.ThePhalluspear1) == 1) {
							monster.teased(Math.round(monster.lustVuln * damage * 0.05));
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
						}
                        else {
                            doPhysicalDamage(Math.round(damage * 0.75), true, true);
                            monster.teased(Math.round(monster.lustVuln * damage * 0.0125));
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
                        }
                    }
					else if (player.isUnarmedCombat() || IsFeralCombat) {
						doPhysicalDamage(damage, true, true);
						if (player.hasStatusEffect(StatusEffects.ChargeWeapon)) doMagicDamage(Math.round(damage * 0.2), true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
						if (player.perkv1(IMutationsLib.SlimeFluidIM) >= 4 && player.HP < player.maxHP()) monster.teased(combat.teases.teaseBaseLustDamage() * monster.lustVuln);
						doPhysicalDamage(damage, true, true);
						if (player.hasStatusEffect(StatusEffects.ChargeWeapon)) doMagicDamage(Math.round(damage * 0.2), true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
						if (player.perkv1(IMutationsLib.SlimeFluidIM) >= 4 && player.HP < player.maxHP()) monster.teased(combat.teases.teaseBaseLustDamage() * monster.lustVuln);
						if (player.playerHasFourArms()) {
							doPhysicalDamage(damage, true, true);
							if (player.hasStatusEffect(StatusEffects.ChargeWeapon)) doMagicDamage(Math.round(damage * 0.2), true, true);
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
							doPhysicalDamage(damage, true, true);
							if (player.hasStatusEffect(StatusEffects.ChargeWeapon)) doMagicDamage(Math.round(damage * 0.2), true, true);
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
						}
					}
                    else {
						if (player.weapon == weapons.ARI_SPR) {
							var bonus:Number = 1;
							if (player.mana100 < 100) bonus += 0.4;
							else if (player.mana100 < 70) bonus += 0.8;
							else if (player.mana100 < 40) bonus += 1.2;
							else bonus += 1.6;
						}
                        doPhysicalDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
                        if (player.weapon == weapons.DAISHO) {
							doPhysicalDamage(Math.round(damage * 0.5), true, true);
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage * 0.5);
						}
                    }
                    if (player.hasStatusEffect(StatusEffects.AlchemicalThunderBuff)) {
						if (canLayerSwordIntentAura()) damage += layerSwordIntentAuraOnThis(damage);
						doLightningDamage(Math.round(damage * 0.3), true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
					}
                    if (player.weapon == weapons.PRURUMI && player.spe >= 150) {
						if (canLayerSwordIntentAura()) damage += layerSwordIntentAuraOnThis(damage);
                        doPhysicalDamage(damage, true, true);
                        if (player.hasStatusEffect(StatusEffects.AlchemicalThunderBuff)) doLightningDamage(Math.round(damage * 0.3), true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
                        if (player.spe >= 225) {
                            doPhysicalDamage(damage, true, true);
                            if (player.hasStatusEffect(StatusEffects.AlchemicalThunderBuff)) doLightningDamage(Math.round(damage * 0.3), true, true);
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
                        }
                        if (player.spe >= 300) {
                            doPhysicalDamage(damage, true, true);
                            if (player.hasStatusEffect(StatusEffects.AlchemicalThunderBuff)) doLightningDamage(Math.round(damage * 0.3), true, true);
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
                        }
                    }
                    if (player.hasStatusEffect(StatusEffects.FalseWeapon)) {
						if (canLayerSwordIntentAura()) damage += layerSwordIntentAuraOnThis(damage);
                        if (player.weapon == weapons.PHALLUS) {
							doPhysicalDamage((damage * 2), true, true);
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage);
						}
                        else {
							doPhysicalDamage(Math.round(damage * 0.2), true, true);
							if (player.statStore.hasBuff("FoxflamePelt")) layerFoxflamePeltOnThis(damage * 0.1);
						}
                    }
                    if (player.weapon == weapons.PRURUMI && player.spe >= 150) {
                        if (player.spe >= 300) damage *= 4;
                        else if (player.spe >= 225) damage *= 3;
                        else damage *= 2;
                    }
                    JabbingStyleIncrement();
                    if (player.hasStatusEffect(StatusEffects.AlchemicalThunderBuff)) damage += Math.round(damage * 0.3);
                }
                if (player.hasPerk(PerkLib.BrutalBlows) && player.str > 75 && damage > 0) {
                    if (monster.armorDef > 0) outputText("\nYour hits are so brutal that you damage [themonster]'s defenses!");
                    var bbc:Number = (Math.round(monster.armorDef * 0.1) + 5);
					if (monster.armorDef - bbc > 0) monster.armorDef -= bbc;
                    else monster.armorDef = 0;
                }
                if (player.statStore.hasBuff("NoLimiterState") && player.weaponName == "fists") {
                    var curseLib:Number = player.lib * 0.005;
                    if (curseLib < 1) curseLib = 1;
                    else curseLib = Math.round(curseLib);
                    player.addCurse("lib", curseLib, 1);
                }
                //Damage cane.
                if (player.weapon is HuntsmansCane) {
                    flags[kFLAGS.ERLKING_CANE_ATTACK_COUNTER]++;
                    //Break cane
                    if (flags[kFLAGS.ERLKING_CANE_ATTACK_COUNTER] >= 50 && rand(20) == 0) {
                        outputText("\n<b>The cane you're wielding finally snaps! It looks like you won't be able to use it anymore.</b>");
                        player.setWeapon(WeaponLib.FISTS);
                    }
                }
                if (damage > 0) {
                    //Lust raised by anemone contact!
                    if (monster is Anemone) {
                        outputText("\nThough you managed to hit the anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
                        //(gain lust, temp lose str/spd)
                        (monster as Anemone).applyVenom((1 + rand(2)));
                    }
                    if (monster is SeaAnemone) {
                        outputText("\nThough you managed to hit the sea anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
                        //(gain lust, temp lose str/spd)
                        (monster as SeaAnemone).applyVenom((1 + rand(2)));
                    }
                    //Lust raising weapon bonuses
                    if (monster.lustVuln > 0) {
                        if (player.weapon == weapons.L_CLAWS || player.weapon == weapons.L_DAGGR || player.weapon == weapons.LRAPIER || player.weapon == weapons.DEPRAVA || player.weapon == weapons.ASCENSU || player.hasAetherTwinsTier2() || player.hasAetherTwinsTierS1() || player.hasAetherTwinsTierS2()) {
                            outputText("\n[Themonster] shivers as your weapon's 'poison' goes to work.");
                            if (player.weapon == weapons.L_DAGGR || player.hasAetherTwinsTierS1() || player.hasAetherTwinsTierS2()) monster.teased(monster.lustVuln * (5 + player.cor / 10));
                            else monster.teased(monster.lustVuln * (10 + player.cor / 8));
                        }
                        var whipLustDmg:Number = 0;
                        var whipCorSelf:Number = 0;
                        var whipLustSelf:Number = 0;
                        var hasArcaneLash:Boolean = player.hasPerk(PerkLib.ArcaneLash);
                        if ((player.weapon == weapons.B_WHIP || player.weapon == weapons.WHIP || player.weapon == weapons.PWHIP || player.weapon == weapons.NTWHIP) && rand(2) == 0) {
                            whipLustDmg = (5 + player.cor / 12) * (hasArcaneLash ? 1.4 : 1); // 5-13.3 (7-18.7 w/perk)
                            whipCorSelf = 0;
                            whipLustSelf = 0;
                        } else if (player.weapon == weapons.SUCWHIP || player.weapon == weapons.PSWHIP) {
                            whipLustDmg = (20 + player.cor / 15) * (hasArcaneLash ? 1.8 : 1); // 20-26.7 (36-48 w/perk)
                            whipCorSelf = 0.3;
                            whipLustSelf = (rand(2) == 0) ? 0 : 1; // 50% +1
                        } else if (player.weapon == weapons.L_WHIP || player.weapon == weapons.DL_WHIP) {
                            whipLustDmg = (10 + player.cor / 5) * (hasArcaneLash ? 2.0 : 1); // 10-30 (20-60 w/perk)
                            whipCorSelf = 0.6;
                            whipLustSelf = (rand(4) == 0) ? 0 : 1; // 75% +1
                        } else if (player.weapon == weapons.D_FLAIL) {
							whipLustDmg = (10 + player.cor / 10); // 10-20
							whipCorSelf = 0.5;
                            whipLustSelf = 0;
						}
                        if (player.armor == armors.ELFDRES && player.isElf()) whipLustDmg *= 2;
                        if (player.armor == armors.FMDRESS && player.isWoodElf()) whipLustDmg *= 2;
                        if (whipLustDmg > 0) {
                            var s:String = monster.plural ? "" : "s";
                            if (rand(2) == 0) {
                                outputText("\n[Themonster] shiver" + s + " and get" + s + " turned on from the whipping.");
                            } else {
                                outputText("\n[Themonster] shiver" + s + " and moan" + s + " involuntarily from the whip's touches.");
                            }
                            if (whipCorSelf > 0 && player.cor < 90) dynStats("cor", whipCorSelf);
                            monster.teased(monster.lustVuln * whipLustDmg);
                            if (whipLustSelf > 0) {
                                outputText(" You get a sexual thrill from it. ");
                                dynStats("lus", whipLustSelf);
                            }
                        }
                    }
                    //Selfcorrupting weapons
                    if ((player.weapon == weapons.HELRAIS || player.weapon == weapons.EBNYBLD) && player.cor < 90) dynStats("cor", 1);
                    //Selfpurifying and Lust lowering weapons
                    if ((player.weapon == weapons.LHSCYTH || player.weapon == weapons.NPHBLDE) && player.cor > 10) dynStats("cor", -1);
                    if (player.weapon == weapons.EXCALIB || player.weapon == weapons.DEXCALI) {
                        if (player.cor > 10) dynStats("cor", -0.3);
                        var excaliburLustSelf:Number;
                        excaliburLustSelf = (rand(2) == 0) ? 0 : 1;
                        if (excaliburLustSelf > 0) dynStats("lus", -excaliburLustSelf);
                    }
                    //Weapon Procs!
                    WeaponMeleeStatusProcs();
                }
                if (flags[kFLAGS.ENVENOMED_MELEE_ATTACK] == 1 && (player.weapon.isSmall())) {
                    if (player.tailVenom >= player.VenomWebCost()) {
                        outputText("  ");
                        if (monster.lustVuln == 0) {
                            outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
                        }
                        else {
                            if (player.tailType == Tail.BEE_ABDOMEN) {
                                outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
                                var damageB:Number = 35 + rand(player.lib / 10);
                                var damageBa:Number = 1;
                                if (player.armor == armors.ELFDRES && player.isElf()) damageBa *= 2;
                                if (player.armor == armors.FMDRESS && player.isWoodElf()) damageBa *= 2;
                                if (player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) damageB += scalingBonusToughness() * 0.5;
                                if (player.level < 10) damageB += 20 + (player.level * 3);
                                else if (player.level < 20) damageB += 50 + (player.level - 10) * 2;
                                else if (player.level < 30) damageB += 70 + (player.level - 20) * 1;
                                else damageB += 80;
                                damageB *= 0.2;
                                if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) damageBa *= 2;
                                damageB *= damageBa;
                                monster.teased(Math.round(monster.lustVuln * damageB));
                                if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                                    monster.addStatusValue(StatusEffects.NagaVenom, 3, damageBa);
                                } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, damageBa, 0);
                                if (player.hasPerk(PerkLib.WoundPoison)){
                                    if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                                    else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
                                }
                                player.tailVenom -= player.VenomWebCost();
                                flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                            }
                            if (player.tailType == Tail.SCORPION || player.hasKeyItem("Sky Poison Pearl") >= 0) {
                                outputText("  [monster he] seems to be effected by the poison, its movement turning sluggish.");
                                var damBa:Number = 1;
                                if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) damBa *= 2;
                                monster.statStore.addBuffObject({spe:-(damBa*2)}, "Poison",{text:"Poison"});
                                if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                                    monster.addStatusValue(StatusEffects.NagaVenom, 3, damBa);
                                } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, damBa, 0);
                                if (player.hasPerk(PerkLib.WoundPoison)){
                                    if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                                    else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
                                }
                                player.tailVenom -= player.VenomWebCost();
                                flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                            }
                            if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
                                outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
                                var lustdamage:Number = 35 + rand(player.lib / 10);
                                var DBPaaa:Number = 1;
                                if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) DBPaaa *= 2;
                                if (player.level < 10) lustdamage += 20 + (player.level * 3);
                                else if (player.level < 20) lustdamage += 50 + (player.level - 10) * 2;
                                else if (player.level < 30) lustdamage += 70 + (player.level - 20) * 1;
                                else lustdamage += 80;
                                if (player.hasPerk(PerkLib.RacialParagon)) lustdamage *= RacialParagonAbilityBoost();
                                if (player.armor == armors.ELFDRES && player.isElf()) lustdamage *= 2;
                                if (player.armor == armors.FMDRESS && player.isWoodElf()) lustdamage *= 2;
                                lustdamage *= 0.14;
                                lustdamage *= DBPaaa;
                                monster.teased(Math.round(monster.lustVuln * lustdamage));
                                monster.statStore.addBuffObject({tou:-(DBPaaa*2)}, "Poison",{text:"Poison"});
                                if (monster.hasStatusEffect(StatusEffects.ManticoreVenom)) {
                                    monster.addStatusValue(StatusEffects.ManticoreVenom, 3, DBPaaa);
                                } else monster.createStatusEffect(StatusEffects.ManticoreVenom, 0, 0, DBPaaa, 0);
                                player.tailVenom -= player.VenomWebCost();
                                flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                            }
                            if (player.faceType == Face.SNAKE_FANGS) {
                                outputText("  [monster he] seems to be effected by the poison, its movement turning sluggish.");
                                var DBPaaaa:Number = 1;
                                if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) DBPaaaa *= 2;
                                monster.statStore.addBuffObject({spe:-DBPaaaa}, "Poison",{text:"Poison"});
                                var venomType:StatusEffectType = StatusEffects.NagaVenom;
                                if (player.racialScore(Races.NAGA) >= 23) venomType = StatusEffects.ApophisVenom;
                                if (monster.hasStatusEffect(venomType)) {
                                    monster.addStatusValue(venomType, 2, 0.4);
                                    monster.addStatusValue(venomType, 1, (DBPaaaa*0.4));
                                } else monster.createStatusEffect(venomType, (DBPaaaa*0.4), 0.4, 0, 0);
                                if (player.hasPerk(PerkLib.WoundPoison)){
                                    if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                                    else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
                                }
                                player.tailVenom -= player.VenomWebCost();
                                flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                            }
                            if (player.faceType == Face.SPIDER_FANGS) {
                                if (player.lowerBody == LowerBody.ATLACH_NACHA){
                                    outputText("  [monster he] seems to be affected by the poison, showing increasing sign of weakness and arousal.");
                                    var damage4B:Number = 35 + rand(player.lib / 10);
                                    var poisonScaling:Number = 1;
                                    var damage4Ba:Number = 1;
                                    if (player.armor == armors.ELFDRES && player.isElf()) damage4Ba *= 2;
                                    if (player.armor == armors.FMDRESS && player.isWoodElf()) damage4Ba *= 2;
                                    if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) damage4B *= 2;
                                    poisonScaling += player.lib/100;
                                    poisonScaling += player.tou/100;
                                    if (player.level < 10) damage4B += 20 + (player.level * 3);
                                    else if (player.level < 20) damage4B += 50 + (player.level - 10) * 2;
                                    else if (player.level < 30) damage4B += 70 + (player.level - 20) * 1;
                                    else damage4B += 80;
                                    damage4B *= 0.2;
                                    damage4B *= damage4Ba;
                                    damage4B *= 1+(poisonScaling/10);
                                    poisonScaling *= damage4Ba;
                                    monster.teased(Math.round(monster.lustVuln * damage4B));
                                    monster.statStore.addBuffObject({tou:-poisonScaling}, "Poison",{text:"Poison"});
                                    if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                                        monster.addStatusValue(StatusEffects.NagaVenom, 3, damage4Ba);
                                    } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, damage4Ba, 0);
                                    if (player.hasPerk(PerkLib.WoundPoison)){
                                        if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                                        else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
                                    }
                                    player.tailVenom -= player.VenomWebCost();
                                    flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                                } else {
                                    outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
                                    var lustDmg:int = 6 * monster.lustVuln;
                                    if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) lustDmg *= 2;
                                    if (player.armor == armors.ELFDRES && player.isElf()) lustdamage *= 2;
                                    if (player.armor == armors.FMDRESS && player.isWoodElf()) lustdamage *= 2;
                                    monster.teased(lustDmg);
                                    if (monster.lustVuln > 0 && !monster.hasPerk(PerkLib.EnemyTrueAngel)) {
                                        monster.lustVuln += 0.01;
                                        if (monster.lustVuln > 1) monster.lustVuln = 1;
                                    }
                                    player.tailVenom -= player.VenomWebCost();
                                    flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                                }
                            }
                            if (monster.lust >= monster.maxOverLust()) {
                                outputText("\n\n");
                                checkAchievementDamage(damage);
                                doNext(endLustVictory);
                            }
                        }
                        outputText("\n");
                    } else outputText("  You do not have enough venom to apply on [weapon]!\n");
                }
                if (player.weapon == weapons.DSSPEAR) {
                    monster.statStore.addBuff("str",-2, "DemonSnakeSpear",{text:"DemonSnakeSpear"});
                    monster.statStore.addBuffObject({spe:-2}, "Poison",{text:"Poison"});
                    if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                        monster.addStatusValue(StatusEffects.NagaVenom, 2, 2);
                        monster.addStatusValue(StatusEffects.NagaVenom, 1, 2);
                    } else monster.createStatusEffect(StatusEffects.NagaVenom, 2, 2, 0, 0);
                    if (player.hasPerk(PerkLib.WoundPoison)){
                        if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                        else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
                    }
                }
                monster.postMeleeDmg();
                // Migrate anemonecheck() remaining attacks skip
                if(!monster.postMeleeDmgSkip(i)){
                    return;
                }
                outputText(" ");
                outputText("\n\n"); //Move to next attack line
                if (MDOCount == maxCurrentAttacks()) outputText("\n");
                checkAchievementDamage(damage);
                WrathGenerationPerHit1(5);
                WrathWeaponsProc();
                heroBaneProc(damage);
                EruptingRiposte();
                if (boolSwiftCast && !player.statStore.hasBuff("Supercharged")) {
                    if (flags[kFLAGS.ELEMENTAL_MELEE] == 1 && CombatAbilities.WhitefireSwiftcast.isUsable) {
                        CombatAbilities.WhitefireSwiftcast.perform();
                    }
                    if (flags[kFLAGS.ELEMENTAL_MELEE] == 2 && CombatAbilities.IceSpikeSwiftcast.isUsable) {
                        CombatAbilities.IceSpikeSwiftcast.perform();
                    }
                    if (flags[kFLAGS.ELEMENTAL_MELEE] == 3 && CombatAbilities.LightningBoltSwiftcast.isUsable) {
                        CombatAbilities.LightningBoltSwiftcast.perform();
                    }
                    if (flags[kFLAGS.ELEMENTAL_MELEE] == 4 && CombatAbilities.DarknessShardSwiftcast.isUsable) {
                        CombatAbilities.DarknessShardSwiftcast.perform();
                    }
                    if (flags[kFLAGS.ELEMENTAL_MELEE] == 5 && CombatAbilities.WaterBallSwiftcast.isUsable) {
                        CombatAbilities.WaterBallSwiftcast.perform();
                    }
                    if (flags[kFLAGS.ELEMENTAL_MELEE] == 6 && CombatAbilities.WindBulletSwiftcast.isUsable) {
                        CombatAbilities.WindBulletSwiftcast.perform();
                    }
                    if (flags[kFLAGS.ELEMENTAL_MELEE] == 7 && CombatAbilities.StalagmiteSwiftcast.isUsable) {
                        CombatAbilities.StalagmiteSwiftcast.perform();
                    }
                    if (flags[kFLAGS.ELEMENTAL_MELEE] == 8 && CombatAbilities.AcidSpraySwiftcast.isUsable) {
                        CombatAbilities.AcidSpraySwiftcast.perform();
                    }
                }
                if (boolLifeLeech) {
                    var sippedA:Number = 0.01;
                    if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) sippedA *= 2;
                    player.HP += player.maxHP() * sippedA;
                    player.mana += player.maxMana() * sippedA;
                    player.fatigue -= player.maxFatigue() * sippedA;
                    player.soulforce += player.maxSoulforce() * sippedA;
                    if (player.HP > player.maxOverHP()) player.HP = player.maxOverHP();
                    if (player.mana > player.maxOverMana()) player.mana = player.maxOverMana();
                    if (player.soulforce > player.maxOverSoulforce()) player.soulforce = player.maxOverSoulforce();
                    if (player.fatigue < 0) player.fatigue = 0;
                }
                //Damage Unarmed Strike chaining combos. GRABBING STYLE AND JABBING STYLE
                var extraHitChance:Number;
                var extraHitDamage:Number;
                var extraHitDamage2:Number;
                if (crit){
                    extraHitDamage = damage / critDamage;
                    extraHitDamage2 = damage / critDamage;
                }
                else {
                    extraHitDamage = damage;
                    extraHitDamage2 = damage;
                }
                if (boolFistingIs300Bucks){
                    if (player.hasPerk(PerkLib.JabbingStyle)){
                        if (player.hasPerk(PerkLib.JabbingGrandmaster)){
                            extraHitChance = 10;
                            if (player.hasPerk(PerkLib.MeteorStrike)) extraHitChance = 20
                            if (rand(100) < extraHitChance){
                                if (player.hasPerk(PerkLib.SpeedDemon) && player.isNoLargeNoStaffWeapon()) {
                                    if(player.hasStatusEffect(StatusEffects.JabbingStyle)){
                                        extraHitDamage += player.spe*player.statusEffectv1(StatusEffects.JabbingStyle);
                                    }
                                }
                                //var critJab:Boolean = false;
                                var critJab:Boolean = CritRoll()
                                extraHitDamage = CritDamage(extraHitDamage, critJab);
                                //Deal the fellow up blow!
                                outputText("You chain up the jab with a second blow! ");
                                extraHitDamage2 = Math.round(extraHitDamage);
                                doPhysicalDamage(extraHitDamage, true ,true);
                                if (critJab) outputText("<b>Critical! </b>");
                                outputText("\n\n");
                                JabbingStyleIncrement();
                            }
                        }
                    }
                    if (player.hasPerk(PerkLib.GrabbingStyle)){
                        extraHitChance = 10;
                        var playerMaxCarry:Number = player.str+(player.effectiveTallness/12*100);
                        if (player.hasPerk(PerkLib.GrabbingMaster)) playerMaxCarry += player.str;
                        var ennemyMaxSize:Boolean = playerMaxCarry > (monster.tallness/12*100);
                        if (player.hasPerk(PerkLib.GrabbingMaster)) extraHitChance = 20;
                        if (rand(100) < extraHitChance && ennemyMaxSize){
                            if (player.hasPerk(PerkLib.SpeedDemon) && player.isNoLargeNoStaffWeapon()) {
                                if(player.hasStatusEffect(StatusEffects.JabbingStyle)){
                                    extraHitDamage2 += player.spe*player.statusEffectv1(StatusEffects.JabbingStyle);
                                }
                            }
                            //Determine if critical hit!
                            var critGrab:Boolean = CritRoll();
                            extraHitDamage2 = CritDamage(extraHitDamage2, critJab);
                            //Deal the fellow up blow!
                            outputText("You grab your opponent mid swing and supplex it against the ground! ");
                            if (player.hasPerk(PerkLib.MeteorStrike)) extraHitDamage2 *= 2;
                            extraHitDamage2 = Math.round(extraHitDamage2);
                            doPhysicalDamage(extraHitDamage2, true ,true);
                            if (critGrab) outputText("<b>Critical! </b>");
                            if (player.hasPerk(PerkLib.GrabbingGrandmaster)){
                                var extraHitStunChance:Number = 20;
                                if (rand(100) < extraHitStunChance){
                                    outputText("The concusion leaves your opponent dazed! ");
                                    monster.createStatusEffect(StatusEffects.Stunned, 1,0,0,0);
                                }
                            }
                            outputText("\n\n");
                            JabbingStyleIncrement();
                        }
                    }
                }
            }
            else { //MISSED THE TARGET THUS DAMAGE = 0;
                // Migrate DisplacerBeast custom evade text and default evade text
                monster.preMeleeMissed();
            }
            if (monster.HP <= monster.minHP()) {
                doNext(endHpVictory);
                meleeMasteryGain(hitCounter, critCounter);
                return;
            }
            else if (monster.lust >= monster.maxOverLust()) {
                doNext(endLustVictory);
                meleeMasteryGain(hitCounter, critCounter);
                return;
            }
			if (i > 1 && flags[kFLAGS.MULTIATTACK_STYLE] > 0) {
				if (player.weapon.isLarge() || player.weapon.isMassive()) {
					if (player.wrath - 5 >= 0) player.wrath -= 5;
					else i = flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] + 1;
				}
				else {
					if (player.fatigue + 5 > player.maxOverFatigue()) i = flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] + 1;
					else fatigue(5);
				}
			}
        }
        if (player.weapon is Tidarion) (player.weapon as Tidarion).afterStrike();
        meleeMasteryGain(hitCounter, critCounter);
        if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
            attack(false);
            return;
        }
        if (player.statusEffectv1(StatusEffects.CounterAction) > 0) {
            player.removeStatusEffect(StatusEffects.CounterAction);
            doNext(playerMenu);
        }
        //outputText("HIT : " + hitCounter + " times\n");
        //outputText("CRIT: " + critCounter + " times\n");
        //outputText("TIME: " + (timer - getTimer()) + "\n");
        if (monster.hasStatusEffect(StatusEffects.HypnosisNaga)) {
            outputText("\nThe pain makes your target snap out of the trance, causing them to realise what is going on.\n");
            player.removeStatusEffect(StatusEffects.HypnosisNaga);
        }
    }
	
	public function layerFoxflamePeltOnThis(damage:Number, display:Boolean = true):void {
		doFireDamage(Math.round(damage * 2 * fireDamageBoostedByDao()), true, display);
		var foxpunchlust:Number = (10 + player.cor / 8);
		monster.teased((monster.lustVuln * foxpunchlust), false);
	}
	public function canLayerSwordIntentAura():Boolean {
		if (player.statStore.hasBuff("SwordIntentAura") && player.compatibileSwordImmortalWeapons()) return true;
		else return false;
	}
	public function layerSwordIntentAuraOnThis(damage:Number):Number {
		var swordintentaura:Number = 1.1;
		if (player.hasPerk(PerkLib.SwordImmortalFirstForm)) swordintentaura += 0.15;
		damage *= swordintentaura;
		damage = Math.round(damage);
		return damage;
	}

    public function JabbingStyleIncrement():void{
        if (player.hasPerk(PerkLib.JabbingStyle)){
            var JabbingValue:Number = 0.02;
            if (player.hasPerk(PerkLib.JabbingMaster)) JabbingValue = 0.04;
            if(!player.hasStatusEffect(StatusEffects.JabbingStyle)) player.createStatusEffect(StatusEffects.JabbingStyle,JabbingValue,0,0,0);
            else player.addStatusValue(StatusEffects.JabbingStyle,1,JabbingValue);
        }
    }

    public function unarmedAttack():Number {
        var unarmed:Number = 0;
        var unarmedMulti:Number = 1;
        if (player.hasPerk(PerkLib.JobMonk) && player.wis >= 60) unarmed += 10 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.PrestigeJobSoulArtMaster) && player.wis >= 200) unarmed += 10 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.FleshBodyApprenticeStage)) {
            if (player.hasPerk(PerkLib.SoulApprentice)) unarmed += 3 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
            if (player.hasPerk(PerkLib.SoulPersonage)) unarmed += 3 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
            if (player.hasPerk(PerkLib.SoulWarrior)) unarmed += 3 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
        }
        if (player.hasPerk(PerkLib.FleshBodyWarriorStage)) {
            if (player.hasPerk(PerkLib.SoulSprite)) unarmed += 5 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
            if (player.hasPerk(PerkLib.SoulScholar)) unarmed += 5 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
            if (player.hasPerk(PerkLib.SoulGrandmaster)) unarmed += 5 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
        }
        if (player.hasPerk(PerkLib.FleshBodyElderStage)) {
            if (player.hasPerk(PerkLib.SoulElder)) unarmed += 7 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
            if (player.hasPerk(PerkLib.SoulExalt)) unarmed += 7 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
            if (player.hasPerk(PerkLib.SoulOverlord)) unarmed += 7 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
        }
        if (player.hasPerk(PerkLib.FleshBodyOverlordStage)) {
            if (player.hasPerk(PerkLib.SoulTyrant)) unarmed += 9 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
            if (player.hasPerk(PerkLib.SoulKing)) unarmed += 9 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
            if (player.hasPerk(PerkLib.SoulEmperor)) unarmed += 9 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
        }
        if (player.hasPerk(PerkLib.FleshBodyTyrantStage)) {
            if (player.hasPerk(PerkLib.SoulAncestor)) unarmed += 11 * (1 + player.newGamePlusMod()) * player.humanBodyCultivators();
        }
        if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) unarmed += 12 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) unarmed += 18 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) unarmed += 24 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) unarmed += 30 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) unarmed += 36 * (1 + player.newGamePlusMod());
        if (CombatAbilities.EAspectMetal.isActive()) unarmed += CombatAbilities.EAspectMetal.getBonus();
        if (player.hasPerk(PerkLib.ElementalBody)) {
            switch (ElementalRace.getElementAndTier(player)) {
                case ElementalRace.SYLPH_1:
                    unarmedMulti += .05;
                    break;
                case ElementalRace.SYLPH_2:
                    unarmedMulti += .1;
                    break;
                case ElementalRace.SYLPH_3:
                    unarmedMulti += .15;
                    break;
                case ElementalRace.SYLPH_4:
                    unarmedMulti += .2;
                    break;
                case ElementalRace.IGNIS_1:
                    unarmedMulti += .1;
                    break;
                case ElementalRace.IGNIS_2:
                    unarmedMulti += .2;
                    break;
                case ElementalRace.IGNIS_3:
                    unarmedMulti += .3;
                    break;
                case ElementalRace.IGNIS_4:
                    unarmedMulti += .4;
                    break;
            }
        }
        if (player.isGargoyle() && Forgefather.material == "marble")
        {
            if (Forgefather.refinement == 0) unarmedMulti += (.15);
            if (Forgefather.refinement == 1) unarmedMulti += (.25);
            if (Forgefather.refinement == 2 || Forgefather.refinement == 3) unarmedMulti += (.5);
            if (Forgefather.refinement == 4) unarmedMulti += (1);
        }
        if (player.statStore.hasBuff("CrinosShape") && player.hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalWeapons)) {
			if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 2) unarmed *= 1.2;
			else unarmed *= 1.1;
		}
        if (player.hasPerk(PerkLib.Lycanthropy)) unarmed += 8 * (1 + player.newGamePlusMod());
        if (player.arms.type == Arms.HINEZUMI) unarmed += 4 * (1 + player.newGamePlusMod());
        if (player.arms.type == Arms.YETI || player.arms.type == Arms.BEAR) unarmed += 5 * (1 + player.newGamePlusMod());
        if (player.arms.type == Arms.CAT || player.arms.type == Arms.LION) unarmed += 6 * (1 + player.newGamePlusMod());
        if (player.arms.type == Arms.FROSTWYRM) unarmed += 12 * (1 + player.newGamePlusMod());
        if (player.arms.type == Arms.MANTIS || player.arms.type == Arms.KAMAITACHI) unarmed += 15 * (1 + player.newGamePlusMod());
        if (player.arms.type == Arms.DISPLACER) {
            unarmed += 6 * (1 + player.newGamePlusMod());
            if (player.perkv1(IMutationsLib.DisplacerMetabolismIM) >= 1) unarmed += 6 * (1 + player.newGamePlusMod());
            if (player.perkv1(IMutationsLib.DisplacerMetabolismIM) >= 2) unarmed += 6 * (1 + player.newGamePlusMod());
        }
        if (player.lowerBody == LowerBody.HINEZUMI) unarmed += 4 * (1 + player.newGamePlusMod());
        if (player.lowerBody == LowerBody.BEAR) unarmed += 5 * (1 + player.newGamePlusMod());
        if (player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.LION) unarmed += 6 * (1 + player.newGamePlusMod());
        if (player.lowerBody == LowerBody.CANCER) unarmed += 12 * (1 + player.newGamePlusMod());
        if (player.tailType == Tail.HINEZUMI) unarmed += 4 * (1 + player.newGamePlusMod());
        if (player.perkv1(IMutationsLib.DraconicBonesIM) >= 1) unarmed += 10 * (1 + player.newGamePlusMod());
        if (player.perkv1(IMutationsLib.DraconicBonesIM) >= 2) unarmed += 10 * (1 + player.newGamePlusMod());
        if (player.perkv1(IMutationsLib.DraconicBonesIM) >= 3) unarmed += 20 * (1 + player.newGamePlusMod());
        if (player.hasKeyItem("Rocket Boots") >= 0) unarmed += 2;
        if (player.hasKeyItem("Nitro Boots") >= 0) unarmed += 4;
        if (player.hasPerk(PerkLib.Brawn)) unarmedMulti += .05;
        if (player.hasPerk(PerkLib.ImprovedBrawn)) unarmedMulti += .1;
        if (player.hasPerk(PerkLib.GreaterBrawn)) unarmedMulti += .15;
        if (player.hasPerk(PerkLib.EpicBrawn)) unarmedMulti += .2;
        if (player.hasPerk(PerkLib.LegendaryBrawn)) unarmedMulti += .25;
        if (player.hasPerk(PerkLib.MythicalBrawn)) unarmedMulti += .3;
        if (player.perkv1(IMutationsLib.DraconicBonesIM) >= 3) unarmedMulti += .5;
        unarmed *= unarmedMulti;
        unarmed = Math.round(unarmed);
        return unarmed;
    }

    public function historyFighterBonus():Number {
        var historyFighterB:Number = 1.1;
        if (player.hasPerk(PerkLib.BonesOfSteel)) historyFighterB += 0.1;
        if (player.hasPerk(PerkLib.MusclesOfSteel)) historyFighterB += 0.1;
        if (player.hasPerk(PerkLib.HeartOfSteel)) historyFighterB += 0.1;
        if (player.hasPerk(PerkLib.BodyOfSteel)) historyFighterB += 0.1;
        if (player.hasPerk(PerkLib.MindOfSteel)) historyFighterB += 0.1;
        if (player.hasPerk(PerkLib.SoulOfSteel)) historyFighterB += 0.1;
        if (player.hasPerk(PerkLib.GodOfSteel)) historyFighterB += 0.1;
        return historyFighterB;
    }

    public function historyScoutBonus():Number {
        var historyScoutB:Number = 1.1;
        if (player.hasPerk(PerkLib.SoldiersFriend)) historyScoutB += 0.1;
        if (player.hasPerk(PerkLib.PyrosFriend)) historyScoutB += 0.1;
        if (player.hasPerk(PerkLib.HeavysFriend)) historyScoutB += 0.1;
        if (player.hasPerk(PerkLib.EngineersFriend)) historyScoutB += 0.1;
        if (player.hasPerk(PerkLib.SnipersFriend)) historyScoutB += 0.1;
        if (player.hasPerk(PerkLib.SpysEnemy)) historyScoutB += 0.1;
        if (player.hasPerk(PerkLib.ShitYouTouchedSasha)) historyScoutB += 0.1;
        return historyScoutB;
    }

    public function historyTacticianBonus():Number {
        var historyTacticianB:Number = 1.1;
        if (player.hasPerk(PerkLib.HistoryBuff)) historyTacticianB += 0.1;
		if (player.hasPerk(PerkLib.GuerrillaTactics)) historyTacticianB += 0.1;
		if (player.hasPerk(PerkLib.StrengthInNumbers)) historyTacticianB += 0.1;
		if (player.hasPerk(PerkLib.General)) historyTacticianB += 0.1;
		if (player.hasPerk(PerkLib.SmallArmy)) historyTacticianB += 0.1;
		if (player.hasPerk(PerkLib.Fellowship)) historyTacticianB += 0.1;
		if (player.hasPerk(PerkLib.Alliance)) historyTacticianB += 0.1;
        return historyTacticianB;
    }

    public function historyWhoreBonus():Number {
        var historyWhoreB:Number = 0.15;
        if (player.hasPerk(PerkLib.Amateur)) historyWhoreB += 0.15;
        if (player.hasPerk(PerkLib.Prostitute)) historyWhoreB += 0.15;
        if (player.hasPerk(PerkLib.Escort)) historyWhoreB += 0.15;
        if (player.hasPerk(PerkLib.BrothelOwner)) historyWhoreB += 0.15;
        if (player.hasPerk(PerkLib.Pornstar)) historyWhoreB += 0.15;
        if (player.hasPerk(PerkLib.SexChampion)) historyWhoreB += 0.15;
        if (player.hasPerk(PerkLib.SexDeity)) historyWhoreB += 0.15;
        return historyWhoreB;
    }

    public function intwisscaling():Number {
        var intwisscalingvar:Number = 0;
        intwisscalingvar += scalingBonusIntelligence();
        intwisscalingvar += scalingBonusWisdom();
        return intwisscalingvar;
    }

    public function perkBonusDamage(damage:Number):Number {
        if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= historyFighterBonus();
        if (player.weaponRange == weaponsrange.BADOMEN && monster.hasPerk(PerkLib.EnemyTrueAngel)) damage *= 1.25;
        if (player.weaponRange == weaponsrange.GOODSAM && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1.25;
        if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
        if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
        if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
        if (player.hasPerk(PerkLib.JobBeastWarrior)) damage *= 1.1;
        if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType) || monster.hasPerk(PerkLib.EnemyGigantType) || monster.hasPerk(PerkLib.EnemyColossalType))) damage *= 2;
        return damage;
    }

    /**
     * Bonus Melee damage from items
     */
    public function itemsBonusDamageDamage(damage:Number):Number {
        damage = perkBonusDamage(damage);
        if (player.armor == armors.SPKIMO) damage *= 1.2;
        if (player.hasPerk(PerkLib.OniTyrantKimono)) damage *= 2;
        if (player.hasPerk(PerkLib.OniEnlightenedKimono)) damage *= 1.5;
        if (player.necklace == necklaces.OBNECK) damage *= 1.2;
        if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
        damage *= player.jewelryAttackModifier();
        return damage;
    }

    public function statusEffectBonusDamage(damage:Number):Number {
        if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
        if (CombatAbilities.Overlimit.isActive() || CombatAbilities.FieryRage.isActive()) damage *= 2;
        if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
        return damage;
    }

    private function harpyDamageBonus(damage:Number):Number {
        if (player.isFlying()) {
            if (player.perkv1(IMutationsLib.HarpyHollowBonesIM) >= 1) damage *= 1.2;
            if (player.perkv1(IMutationsLib.HarpyHollowBonesIM) >= 2) damage *= 1.3;
            if (player.perkv1(IMutationsLib.HarpyHollowBonesIM) >= 3) damage *= 1.5;
        }
        return damage;
    }

    public function goblinDamageBonus(damage:Number):Number {
        if (player.armor == armors.GTECHC_) damage *= 1.5;
		if (player.upperGarment == undergarments.TECHBRA) damage *= 1.05;
		if (player.lowerGarment == undergarments.T_PANTY) damage *= 1.05;
        return damage;
    }

    public function isPureWeapon():Boolean {
        return player.weapon.hasTag(ItemConstants.W_PURE_TYPE)
    }

    public function isCorruptWeapon():Boolean {
        return player.weapon.hasTag(ItemConstants.W_CORRUPT_TYPE)
    }

    public function isFireTypeWeapon():Boolean {
        return (
                        (player.weapon == weapons.RCLAYMO || player.weapon == weapons.TRCLAYM || player.weapon == weapons.RDAGGER)
                        && (player.hasStatusEffect(StatusEffects.ChargeWeapon) || Forgefather.channelInlay == "ruby"))
                || player.weapon.hasTag(ItemConstants.W_FIRE_TYPE)
                || (player.hasStatusEffect(StatusEffects.FlameBlade) && !player.hasStatusEffect(StatusEffects.ElectrifyWeapon));
    }
    public function isIceTypeWeapon():Boolean {
        return (
                (player.weapon == weapons.SCLAYMO || player.weapon == weapons.TSCLAYM || player.weapon == weapons.SDAGGER) && (player.hasStatusEffect(StatusEffects.ChargeWeapon) || Forgefather.channelInlay == "sapphire"))
                || player.weapon.hasTag(ItemConstants.W_ICE_TYPE);
    }
    public function isLightningTypeWeapon():Boolean {
        return ((player.weapon == weapons.TCLAYMO || player.weapon == weapons.TTCLAYM || player.weapon == weapons.TODAGGER) && (player.hasStatusEffect(StatusEffects.ChargeWeapon) || Forgefather.channelInlay == "topaz"))
                || player.weapon.hasTag(ItemConstants.W_LIGHTNING_TYPE)
                || (player.hasStatusEffect(StatusEffects.ElectrifyWeapon) && !player.hasStatusEffect(StatusEffects.FlameBlade));
    }
    public function isDarknessTypeWeapon():Boolean {
        return ((player.weapon == weapons.ACLAYMO || player.weapon == weapons.TACLAYM || player.weapon == weapons.ADAGGER) && (player.hasStatusEffect(StatusEffects.ChargeWeapon) || Forgefather.channelInlay == "amethyst"));
    }
    public function isPlasmaTypeWeapon():Boolean {
        return (player.hasStatusEffect(StatusEffects.FlameBlade) && player.hasStatusEffect(StatusEffects.ElectrifyWeapon));
    }
	
	public function isUnarmedCombatButDealFireDamage():Boolean {
		return (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) || (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat));
	}
	public function isUnarmedCombatButDealIceDamage():Boolean {
		return (flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon()) && player.hasStatusEffect(StatusEffects.WinterClaw));
	}

    public function monsterPureDamageBonus(damage:Number):Number {
        if (monster.cor <= 33) damage = Math.round(damage * 1.0);
        else if (monster.cor <= 50) damage = Math.round(damage * 1.2);
        else if (monster.cor <= 70) damage = Math.round(damage * 1.6);
        else if (monster.cor <= 90) damage = Math.round(damage * 2.2);
        else if (monster.cor <= 99) damage = Math.round(damage * 3);//200% more damage against very high corruption.
        else damage = Math.round(damage * 5);//400% more damage against full corruption.
        return damage;
    }

    public function monsterCorruptDamageBonus(damage:Number):Number {
        if (monster.cor >= 66) damage = Math.round(damage * 1.0);
        else if (monster.cor >= 50) damage = Math.round(damage * 1.2);
        else if (monster.cor >= 30) damage = Math.round(damage * 1.6);
        else if (monster.cor >= 10) damage = Math.round(damage * 2.2);
        else if (monster.cor >= 1) damage = Math.round(damage * 3);
        else damage = Math.round(damage * 5);
        return damage;
    }

    public function fireTypeDamageBonus(damage:Number):Number {
        if (monster.hasPerk(PerkLib.IceNature)) damage *= 1.5;
        if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 1.2;
        if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.8;
        if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.5;
        if (player.hasAnyPerk(PerkLib.FireAffinity, PerkLib.AffinityIgnis)) damage *= 2;
        return damage;
    }

    public function fireTypeDamageBonusLarge(damage:Number):Number {
        if (monster.hasPerk(PerkLib.IceNature)) damage *= 10;
        if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 4;
        if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.25;
        if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.1;
        if (player.hasAnyPerk(PerkLib.FireAffinity, PerkLib.AffinityIgnis)) damage *= 2;
        return damage;
    }

    public function iceTypeDamageBonus(damage:Number):Number {
        if (monster.hasPerk(PerkLib.FireNature)) damage *= 1.5;
        if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 1.2;
        if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.8;
        if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.5;
        if (player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
        if (player.hasPerk(PerkLib.ColdMastery)) damage *= 2;
        return damage;
    }

    public function iceTypeDamageBonusLarge(damage:Number):Number {
        if (monster.hasPerk(PerkLib.FireNature)) damage *= 10;
        if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 4;
        if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.25;
        if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.4;
        if (player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
        if (player.hasPerk(PerkLib.ColdMastery)) damage *= 2;
        return damage;
    }

     public function windTypeDamageBonus(damage:Number):Number {
        if (monster.hasPerk(PerkLib.WindVulnerability)) damage *= 1.2;
        if (monster.hasPerk(PerkLib.WindNature)) damage *= 0.5;
        if (player.hasAnyPerk(PerkLib.WindAffinity, PerkLib.AffinitySylph)) damage *= 2;
        return damage;
    }

    public function windTypeDamageBonusLarge(damage:Number):Number {
        if (monster.hasPerk(PerkLib.WindVulnerability)) damage *= 4;
        if (monster.hasPerk(PerkLib.WindNature)) damage *= 0.4;
        if (player.hasAnyPerk(PerkLib.WindAffinity, PerkLib.AffinitySylph)) damage *= 2;
        return damage;
    }

     public function earthTypeDamageBonus(damage:Number):Number {
        if (monster.hasPerk(PerkLib.EarthVulnerability)) damage *= 1.2;
        if (monster.hasPerk(PerkLib.EarthNature)) damage *= 0.5;
        if (player.hasAnyPerk(PerkLib.EarthAffinity, PerkLib.AffinityGnome)) damage *= 2;
        return damage;
    }

    public function earthTypeDamageBonusLarge(damage:Number):Number {
        if (monster.hasPerk(PerkLib.EarthVulnerability)) damage *= 4;
        if (monster.hasPerk(PerkLib.EarthNature)) damage *= 0.4;
        if (player.hasAnyPerk(PerkLib.EarthAffinity, PerkLib.AffinityGnome)) damage *= 2;
        return damage;
    }

     public function waterTypeDamageBonus(damage:Number):Number {
        if (monster.hasPerk(PerkLib.WaterVulnerability)) damage *= 1.2;
        if (monster.hasPerk(PerkLib.WaterNature)) damage *= 0.5;
        if (player.hasAnyPerk(PerkLib.WaterAffinity, PerkLib.AffinityUndine)) damage *= 2;
        return damage;
    }

    public function waterTypeDamageBonusLarge(damage:Number):Number {
        if (monster.hasPerk(PerkLib.WaterVulnerability)) damage *= 4;
        if (monster.hasPerk(PerkLib.WaterNature)) damage *= 0.4;
        if (player.hasAnyPerk(PerkLib.WaterAffinity, PerkLib.AffinityUndine)) damage *= 2;
        return damage;
    }

     public function lightningTypeDamageBonus(damage:Number):Number {
        if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 1.5;
        if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 1.2;
        if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 0.8;
        if (monster.hasPerk(PerkLib.LightningNature)) damage *= 0.5;
        if (player.hasPerk(PerkLib.LightningAffinity)) damage *= 2;
        return damage;
    }

    public function lightningTypeDamageBonusLarge(damage:Number):Number {
        if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 10;
        if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 4;
        if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 0.25;
        if (monster.hasPerk(PerkLib.LightningNature)) damage *= 0.4;
        if (player.hasPerk(PerkLib.LightningAffinity)) damage *= 2;
        return damage;
    }

     public function darknessTypeDamageBonus(damage:Number):Number {
        if (monster.hasPerk(PerkLib.LightningNature)) damage *= 1.5;
        if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 1.2;
        if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 0.8;
        if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 0.5;
        if (player.hasPerk(PerkLib.DarknessAffinity)) damage *= 2;
        return damage;
    }

    public function darknessTypeDamageBonusLarge(damage:Number):Number {
        if (monster.hasPerk(PerkLib.LightningNature)) damage *= 10;
        if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 4;
        if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 0.25;
        if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 0.4;
        if (player.hasPerk(PerkLib.DarknessAffinity)) damage *= 2;
        return damage;
    }

     public function poisonTypeDamageBonus(damage:Number):Number {
        if (monster.hasPerk(PerkLib.PoisonVulnerability)) damage *= 1.2;
        if (monster.hasPerk(PerkLib.PoisonNature)) damage *= 0.5;
        if (player.hasPerk(PerkLib.PoisonAffinity)) damage *= 2;
        return damage;
    }

    public function poisonTypeDamageBonusLarge(damage:Number):Number {
        if (monster.hasPerk(PerkLib.PoisonVulnerability)) damage *= 4;
        if (monster.hasPerk(PerkLib.PoisonNature)) damage *= 0.4;
        if (player.hasPerk(PerkLib.PoisonAffinity)) damage *= 2;
        return damage;
    }

     public function acidTypeDamageBonus(damage:Number):Number {
        if (monster.hasPerk(PerkLib.AcidVulnerability)) damage *= 1.2;
        if (monster.hasPerk(PerkLib.AcidNature)) damage *= 0.5;
        if (player.hasPerk(PerkLib.AcidAffinity)) damage *= 2;
        return damage;
    }

    public function acidTypeDamageBonusLarge(damage:Number):Number {
        if (monster.hasPerk(PerkLib.AcidVulnerability)) damage *= 4;
        if (monster.hasPerk(PerkLib.AcidNature)) damage *= 0.4;
        if (player.hasPerk(PerkLib.AcidAffinity)) damage *= 2;
        return damage;
    }

    public function elementalAmplificationMod(summonedElementals:int):Number {
        var elementalamplification:Number = 1;
        if (player.hasPerk(PerkLib.ElementalConjurerResolve)) elementalamplification += 0.1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
        if (player.hasPerk(PerkLib.ElementalConjurerDedication)) elementalamplification += 0.2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
        if (player.hasPerk(PerkLib.ElementalConjurerSacrifice)) elementalamplification += 0.3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
        if (player.weapon == weapons.SCECOMM) elementalamplification += 0.5;
		if (player.weaponRange == weaponsrange.E_TOME_) elementalamplification += 0.5;
        if (player.shield == shields.Y_U_PAN) elementalamplification += 0.25;
        if (flags[kFLAGS.WILL_O_THE_WISP] == 2) {
            elementalamplification += 0.1;
            if (player.hasPerk(PerkLib.WispLieutenant)) elementalamplification += 0.2;
            if (player.hasPerk(PerkLib.WispCaptain)) elementalamplification += 0.3;
            if (player.hasPerk(PerkLib.WispMajor)) elementalamplification += 0.4;
            if (player.hasPerk(PerkLib.WispColonel)) elementalamplification += 0.5;
        }
        if (player.hasPerk(PerkLib.HistoryTactician) || player.hasPerk(PerkLib.PastLifeTactician)) elementalamplification += (1 - historyTacticianBonus());
        
        if (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 2 || flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 4) {
            if (summonedElementals >= 9) elementalamplification += 3;
            else if (summonedElementals >= 5) elementalamplification += 2;
            else elementalamplification += 1;
        }

        return elementalamplification;
    }

    public function lustDamageCalc():Number {
        var damage:Number = (player.inte / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
        if (player.armor == armors.ELFDRES && player.isElf()) damage *= 2;
        if (player.armor == armors.FMDRESS && player.isWoodElf()) damage *= 2;
        return monster.lustVuln * damage;
    }

    public function CritRoll(BonusCritChance:Number = 0):Boolean{
        //Determine if critical hit!
        var crit:Boolean = false;
        var critChance:int = 5;
        critChance += BonusCritChance;
        critChance += combatPhysicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
        }
        return crit;
    }

    public function CritDamage(Damage:Number, WasItACrit:Boolean, CritDamageMultiplierBoost:Number = 0):Number{
        //Multiply damage
        var critDamage:Number = 1.75;
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll4)) critDamage += 1;
        critDamage += CritDamageMultiplierBoost;
        if (WasItACrit) {
            Damage *= critDamage;
        }
        return Damage;
    }

    public function CalcBaseDamageUnarmed(damage:Number = 0):Number{
        //BASIC DAMAGE STUFF
        if (player.hasPerk(PerkLib.RampantMight)) {
            damage += player.tou;
			damage += scalingBonusToughness() * 0.25;
            damage += player.str;
			damage += scalingBonusStrength() * 0.25;
        }
        else if (player.hasPerk(PerkLib.VerdantMight)){
            damage += player.tou;
            damage += scalingBonusToughness() * 0.25;
        }
        else{
            damage += player.str;
            damage += scalingBonusStrength() * 0.25;
        }
        if (player.hasPerk(PerkLib.SpeedDemon)) {
            damage += player.spe;
            damage += scalingBonusSpeed() * 0.20;
        }
        damage += unarmedAttack();
        damage = harpyDamageBonus(damage);
        damage = itemsBonusDamageDamage(damage);
        damage = statusEffectBonusDamage(damage);
        //PERKS
        if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
        if (player.hasPerk(PerkLib.ChiReflowMagic)) damage *= UmasShop.NEEDLEWORK_MAGIC_REGULAR_MULTI;
        if (player.hasPerk(PerkLib.ChiReflowAttack)) damage *= UmasShop.NEEDLEWORK_ATTACK_REGULAR_MULTI;
        if (player.hasPerk(PerkLib.GoblinoidBlood)) {
            if (player.hasKeyItem("Power bracer") >= 0) damage *= 1.1;
            if (player.hasKeyItem("Powboy") >= 0) damage *= 1.15;
            if (player.hasKeyItem("M.G.S. bracer") >= 0) damage *= 1.2;
        }
        if ((player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet))) damage *= 2;
        return damage;
    }

    public function CalcBaseDamageArmed(damage:Number = 0):Number{
        //BASIC DAMAGE STUFF
        if (player.hasPerk(PerkLib.RampantMight)) {
            damage += player.tou;
			damage += scalingBonusToughness() * 0.25;
            damage += player.str;
			damage += scalingBonusStrength() * 0.25;
        }
        else if (player.hasPerk(PerkLib.VerdantMight)){
            damage += player.tou;
            damage += scalingBonusToughness() * 0.25;
        }
        else{
            damage += player.str;
            damage += scalingBonusStrength() * 0.25;
        }
        if (player.hasPerk(PerkLib.SpeedDemon) && player.isNoLargeNoStaffWeapon()) {
            damage += player.spe;
            damage += scalingBonusSpeed() * 0.20;
        }
        damage = weaponAttackModifier(damage);
        damage = harpyDamageBonus(damage);
        damage = itemsBonusDamageDamage(damage);
        damage = statusEffectBonusDamage(damage);
        //PERKS
        if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
        if (player.hasPerk(PerkLib.ChiReflowMagic)) damage *= UmasShop.NEEDLEWORK_MAGIC_REGULAR_MULTI;
        if (player.hasPerk(PerkLib.ChiReflowAttack)) damage *= UmasShop.NEEDLEWORK_ATTACK_REGULAR_MULTI;
        if (player.hasPerk(PerkLib.GoblinoidBlood)) {
            if (player.hasKeyItem("Power bracer") >= 0) damage *= 1.1;
            if (player.hasKeyItem("Powboy") >= 0) damage *= 1.15;
            if (player.hasKeyItem("M.G.S. bracer") >= 0) damage *= 1.2;
        }
        if ((player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) && player.isFistOrFistWeapon()) damage *= 2;
        return damage;
    }
    /**
     * Call to initialize variables for feral attacks before calling them
     */
    public function ExtraNaturalWeaponPrep():void{
        enwa_accMelee = 0;
        enwa_accMelee += (meleeAccuracy() / 2);
        if (flags[kFLAGS.ATTACKS_ACCURACY] > 0) enwa_accMelee -= flags[kFLAGS.ATTACKS_ACCURACY];

        enwa_damage = meleeDamageNoLagSingle(true);
        //Bonus sand trap damage!
        // I will genocide you all monster checks later
        if (monster.hasStatusEffect(StatusEffects.Level) && (monster is SandTrap || monster is Alraune)) enwa_damage = Math.round(enwa_damage * 1.75);

        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)){
            enwa_critChance = 0;
        }
        else{
            enwa_critChance = 5;
            enwa_critChance += combatPhysicalCritical();
        }

        enwa_lustClawDamage = 6;
        if (player.hasPerk(PerkLib.SensualLover)) enwa_lustClawDamage += 2;
        if (player.hasPerk(PerkLib.Seduction)) enwa_lustClawDamage += 5;

        if (player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)) enwa_lustClawDamage += 5;
        if (player.hasPerk(PerkLib.FlawlessBody)) enwa_lustClawDamage += 10;

        //partial skins bonuses
        switch (player.coatType()) {
            case Skin.FUR:
                enwa_lustClawDamage += (1 + player.newGamePlusMod());
                break;
            case Skin.SCALES:
                enwa_lustClawDamage += (2 * (1 + player.newGamePlusMod()));
                break;
            case Skin.CHITIN:
                enwa_lustClawDamage += (3 * (1 + player.newGamePlusMod()));
                break;
            case Skin.BARK:
                enwa_lustClawDamage += (4 * (1 + player.newGamePlusMod()));
                break;
        }

        enwa_lustMultiplier = 1;
        if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) enwa_lustMultiplier = combat.historyWhoreBonus();

        if (player.armorName == "desert naga pink and black silk dress") enwa_lustMultiplier += 0.1;
        if (player.headjewelryName == "pair of Golden Naga Hairpins") enwa_lustMultiplier += 0.1;
        if (player.perkv1(IMutationsLib.RaijuCathodeIM) >= 1) enwa_lustMultiplier += 0.5;
        if (player.perkv1(IMutationsLib.RaijuCathodeIM) >= 2) enwa_lustMultiplier += 0.5;
        if (player.perkv1(IMutationsLib.RaijuCathodeIM) >= 3) enwa_lustMultiplier += 1;

        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)){
            enwa_lustCritChance = 0;
        }
        else{
            enwa_lustCritChance = 5;
            enwa_lustCritChance += teases.combatTeaseCritical();
        }

        enwa_lustPostMulti = 1;
        if (player.hasPerk(PerkLib.ChiReflowLust)) enwa_lustPostMulti *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
        if (player.hasPerk(PerkLib.RacialParagon)) enwa_lustPostMulti *= RacialParagonAbilityBoost();
        if (player.armor == armors.ELFDRES && player.isElf()) enwa_lustPostMulti *= 2;
        if (player.armor == armors.FMDRESS && player.isWoodElf()) enwa_lustPostMulti *= 2;
    }

    /**
     * Remember to call ExtraNaturalWeaponPrep() at the beginning of all ExtraNaturalWeaponAttack call if you want to add it outside resolveFeralCombatAdditionnalAttacks() e.g. see devastatingBiteAttack() physical special
     * @param FeraldamageMultiplier
     * @param SpecialEffect
     * @param isClawAttack
     */
    public function ExtraNaturalWeaponAttack(FeraldamageMultiplier:Number = 1, SpecialEffect:String = "", isClawAttack:Boolean = false):void {
        var accMelee:Number = enwa_accMelee;

        if (rand(100) < accMelee) {
            var damage:Number = enwa_damage;
            //------------
            // DAMAGE
            //------------
            //Determine if critical hit!
            var crit:Boolean = false;
            var critChance:int = enwa_critChance;
            var critDamage:Number = 1.75;

			critDamage += bonusCriticalDamageFromMissingHP();
            if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) critDamage *= impaleMultiplier();

			if (rand(100) < critChance) {
                crit = true;
                if (player.perkv1(IMutationsLib.EyeOfTheTigerIM) >= 3) {
                    if (monster.canMonsterBleed()) {
                        if (!monster.hasStatusEffect(StatusEffects.SharkBiteBleed)) monster.createStatusEffect(StatusEffects.SharkBiteBleed,4,0,0,0);
                        else {
                            monster.addStatusValue(StatusEffects.SharkBiteBleed,1, 3);
                        }
                    }
                }
                if (player.perkv1(IMutationsLib.EyeOfTheTigerIM) >= 4) damage *= 1.5;
                if (player.hasPerk(PerkLib.VorpalClaw)) damage *= 2;
                damage *= critDamage;
            }
            //One final round
            damage = Math.round(damage);
            // switch statement is slightly faster than if
            switch(SpecialEffect){
                case "KamaitachiScythe":
                    if (!monster.hasStatusEffect(StatusEffects.KamaitachiBleed)) monster.createStatusEffect(StatusEffects.KamaitachiBleed,1,0,0,1);
                    else {
                        monster.addStatusValue(StatusEffects.KamaitachiBleed, 1, 1);
                        monster.addStatusValue(StatusEffects.KamaitachiBleed, 4, 1);
                    }
                    break;
                case "WendigoClaw":
                    monster.addCurse("tou.mult",0.05,2);
                    monster.addCurse("str.mult",0.05,2);
                    break;
                default:
            }
            // Have to put it before doDamage, because doDamage applies the change, as well as status effects and shit.
            if (monster is Doppleganger) {
                if (!monster.monsterIsStunned()) {
                    if (damage > 0) {
                        doPhysicalDamage(damage, false);
                        (monster as Doppleganger).mirrorAttack(damage);
                    }
                    return;
                }
                // Stunning the doppleganger should now "buy" you another round.
            }
            //Lab Guard tanking
            if (monster is LabGuard && (monster as LabGuard).shieldWall && !monster.hasStatusEffect(StatusEffects.Stunned)) {
                monster.eOneAttack(true);
                if (player.HP <= player.minHP()) {
                    doNext(endHpLoss);
                    return;
                }
                damage /= 2;
            }
            if ((damage <= 0) && ((MDOCount == maxCurrentRangeAttacks()) && (MSGControllForEvasion) && (!MSGControll))) {
                //damage = 0;
                outputText("Your attacks are deflected or blocked by [themonster].");
            } else {
                if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
                if (crit) {
                    outputText("<b>Critical! </b>");
                    if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
                }
                if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
                    if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
                    else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
                }
                //Damage is delivered HERE
                damage *= FeraldamageMultiplier;
				if (BelisaFollower.HolyBand6 > 0) damage *= 1.25;
                switch(SpecialEffect){
                    case "fire":
                        doFireDamage(damage, true, true);
                        break;
                    case "foxflame":
                        doFireDamage((damage * 2), true, true);
                        monster.teased((monster.lustVuln * (10 + player.cor / 8)), false);
                        break;
                    case "ice":
                        doIceDamage(damage, true, true);
                        break;
                    case "lightning":
                        doLightningDamage(damage, true, true);
                        break;
                    case "darkness":
                        doDarknessDamage(damage, true, true);
                        break;
                    case "acid":
                        doAcidDamage(damage, true, true);
                        break;
                    default:
                        doPhysicalDamage(damage, true, true);
                } // Below down here are just for lust damage dont be confused by The Enemy I mean the damage variable
                if (player.hasPerk(PerkLib.LightningClaw)) {
                    damage = enwa_lustClawDamage + rand(3);
                    //+ slutty armor bonus
                    damage += player.teaseDmgStat.value;
                    damage += scalingBonusLibido() * 0.1;
                    if (player.hasPerk(PerkLib.JobSeducer)) damage += player.teaseLevel * 3;
                    else damage += player.teaseLevel * 2;
                    //slutty simplicity bonus
                    if (player.hasPerk(PerkLib.SluttySimplicity) && player.armor.hasTag(ItemConstants.A_REVEALING)) damage *= (1 + ((10 + rand(11)) / 100));
                    damage *= .7;
                    var damagemultiplier:Number = enwa_lustMultiplier;
                    if (player.hasPerk(PerkLib.ElectrifiedDesire)) damagemultiplier += player.lust100 * 0.01;
                    if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 10) damagemultiplier += 0.2;
                    damage *= damagemultiplier;
                    //Determine if critical tease!
                    var crit1:Boolean = false;
                    var critChance1:int = enwa_lustCritChance;
                    if (rand(100) < critChance1) {
                        crit1 = true;
                        damage *= 1.75;
                    }
                    damage *= enwa_lustPostMulti;
                    damage = damage * 0.33 * monster.lustVuln;
                    damage = Math.round(damage);
                    monster.teased(damage,false);
                    if (crit1) outputText(" <b>Critical!</b>");
                    outputText(" ");
                    if (player.hasPerk(PerkLib.SuperSensual) && player.hasPerk(PerkLib.Sensual)) teaseXP(2);
                    else teaseXP(1);
                    if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3){
                        if (rand(100) < 5) {
                            if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
                        }
                    }
                }
            }
            if (player.hasPerk(PerkLib.BrutalBlows) && player.str > 75) {
                var bbc:Number = (Math.round(monster.armorDef * 0.1) + 5);
				if (monster.armorDef - bbc > 0) monster.armorDef -= bbc;
                else monster.armorDef = 0;
            }
			if (player.statStore.hasBuff("NoLimiterState") && player.weaponName == "fists") {
				var curseLib:Number = player.lib * 0.005;
				if (curseLib < 1) curseLib = 1;
				else curseLib = Math.round(curseLib);
				player.addCurse("lib", curseLib, 1);
			}
			if (player.perkv1(IMutationsLib.SlimeFluidIM) >= 4 && player.HP < player.maxHP()) monster.teased(combat.teases.teaseBaseLustDamage() * monster.lustVuln, false);
        }
    }

    public function flyingSwordAttackModifier(damage:Number):Number {
        var wAttack:Number = player.weaponFlyingSwordsAttack;
        if (wAttack < 51) damage *= (1 + (wAttack * 0.03));
        else if (wAttack < 101) damage *= (2.5 + ((wAttack - 50) * 0.0275));
        else if (wAttack < 151) damage *= (3.875 + ((wAttack - 100) * 0.025));
        else if (wAttack < 201) damage *= (5.125 + ((wAttack - 150) * 0.0225));
        else if (wAttack < 251) damage *= (6.25 + ((wAttack - 200) * 0.02));
        else if (wAttack < 301) damage *= (7.25 + ((wAttack - 250) * 0.0175));
        else if (wAttack < 351) damage *= (8.125 + ((wAttack - 300) * 0.015));
        else if (wAttack < 401) damage *= (8.875 + ((wAttack - 350) * 0.0125));
        else damage *= (9.5 + ((wAttack - 400) * 0.01));
        return damage;
    }

    public function weaponAttackModifier(damage:Number):Number {
        var wAttack:Number = player.weaponAttack;
        if (wAttack < 51) damage *= (1 + (wAttack * 0.03));
        else if (wAttack < 101) damage *= (2.5 + ((wAttack - 50) * 0.0275));
        else if (wAttack < 151) damage *= (3.875 + ((wAttack - 100) * 0.025));
        else if (wAttack < 201) damage *= (5.125 + ((wAttack - 150) * 0.0225));
        else if (wAttack < 251) damage *= (6.25 + ((wAttack - 200) * 0.02));
        else if (wAttack < 301) damage *= (7.25 + ((wAttack - 250) * 0.0175));
        else if (wAttack < 351) damage *= (8.125 + ((wAttack - 300) * 0.015));
        else if (wAttack < 401) damage *= (8.875 + ((wAttack - 350) * 0.0125));
        else damage *= (9.5 + ((wAttack - 400) * 0.01));
        return damage;
    }

    public function rangeAttackModifier(damage:Number):Number {
        var wAttack:Number = player.weaponRangeAttack;
        if (wAttack < 51) damage *= (1 + (wAttack * 0.03));
        else if (wAttack < 101) damage *= (2.5 + ((wAttack - 50) * 0.0275));
        else if (wAttack < 151) damage *= (3.875 + ((wAttack - 100) * 0.025));
        else if (wAttack < 201) damage *= (5.125 + ((wAttack - 150) * 0.0225));
        else if (wAttack < 251) damage *= (6.25 + ((wAttack - 200) * 0.02));
        else if (wAttack < 301) damage *= (7.25 + ((wAttack - 250) * 0.0175));
        else if (wAttack < 351) damage *= (8.125 + ((wAttack - 300) * 0.015));
        else if (wAttack < 401) damage *= (8.875 + ((wAttack - 350) * 0.0125));
        else damage *= (9.5 + ((wAttack - 400) * 0.01));
        return damage;
    }

    public function LustyEnergyNaturalWeaponAttack(FeraldamageMultiplier:Number = 1, stunChance:Number = 10):void {
        var damage:Number = scalingBonusIntelligence() * spellModWhite();
        damage = damage * FeraldamageMultiplier;
		if (BelisaFollower.HolyBand6 > 0) damage *= 1.25;
        //Determine if critical hit!
        var crit1:Boolean = false;
        var critChance1:int = 5;
        critChance1 += combatMagicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance1 = 0;
        if (rand(100) < critChance1) {
            crit1 = true;
            damage *= 1.75;
        }
        //High damage to goes.
        damage = combat.magic.calcVoltageModImpl(damage, true);
        if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
        if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
        if (player.perkv1(IMutationsLib.FloralOvariesIM) >= 1) damage *= 1.25;
        if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
        damage *= 2;
        damage = Math.round(damage);
        doLightningDamage(damage, true, true);
        if (crit1) outputText(" <b>*Critical Hit!*</b>");
        dynStats("lus", (Math.round(player.maxLust() * 0.02)), "scale", false);
        var lustDmgF:Number = 20 + rand(6);
        var lustBoostToLustDmg:Number = 0;
        var bimbo:Boolean   = false;
        var bro:Boolean     = false;
        var futa:Boolean    = false;
        if (player.hasPerk(PerkLib.SensualLover)) {
            lustDmgF += 2;
        }
        if (player.hasPerk(PerkLib.Seduction)) lustDmgF += 5;
        lustDmgF += player.teaseDmgStat.value;
        if (bimbo || bro || futa) {
            lustDmgF += 5;
        }
        if (player.hasPerk(PerkLib.FlawlessBody)) lustDmgF += 10;
        lustDmgF += scalingBonusLibido() * 0.1;
        if (player.hasPerk(PerkLib.EromancyExpert)) lustDmgF *= 1.5;
        if (player.hasPerk(PerkLib.JobSeducer)) lustDmgF += player.teaseLevel * 3;
        else lustDmgF += player.teaseLevel * 2;
        if (player.hasPerk(PerkLib.JobCourtesan) && monster.hasPerk(PerkLib.EnemyBossType)) lustDmgF *= 1.2;
        switch (player.coatType()) {
            case Skin.FUR:
                lustDmgF += (1 + player.newGamePlusMod());
                break;
            case Skin.SCALES:
                lustDmgF += (2 * (1 + player.newGamePlusMod()));
                break;
            case Skin.CHITIN:
                lustDmgF += (3 * (1 + player.newGamePlusMod()));
                break;
            case Skin.BARK:
                lustDmgF += (4 * (1 + player.newGamePlusMod()));
                break;
        }
        if (player.hasPerk(PerkLib.SluttySimplicity) && player.armor.hasTag(ItemConstants.A_REVEALING)) lustDmgF *= (1 + ((10 + rand(11)) / 100));
        if (player.hasPerk(PerkLib.ElectrifiedDesire)) {
            lustDmgF *= (1 + (player.lust100 * 0.01));
        }
        if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) {
            lustDmgF *= (1 + combat.historyWhoreBonus());
        }
        lustBoostToLustDmg += lustDmgF * 0.01;
        lustDmgF *= 0.2;
        if (player.lust100 * 0.01 >= 0.9) lustDmgF += (lustBoostToLustDmg * 140);
        else if (player.lust100 * 0.01 < 0.2) lustDmgF += (lustBoostToLustDmg * 140);
        else lustDmgF += (lustBoostToLustDmg * 2 * (20 - (player.lust100 * 0.01)));
        //Determine if critical tease!
        var crit2:Boolean = false;
        var critChance2:int = 5;
        critChance2 += teases.combatTeaseCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance2 = 0;
        if (rand(100) < critChance2) {
            crit2 = true;
            lustDmgF *= 1.75;
        }
        if (player.hasPerk(PerkLib.ChiReflowLust)) lustDmgF *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
        if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) lustDmgF *= 1.5;
        if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 1) lustDmgF *= 1.1;
        if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) lustDmgF *= 1.2;
        if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) lustDmgF *= 1.3;
        if (player.perkv1(IMutationsLib.RaijuCathodeIM) >= 2) lustDmgF *= 1.2;
        if (player.hasPerk(PerkLib.RacialParagon)) lustDmgF *= RacialParagonAbilityBoost();
        if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmgF *= 1.50;
        if (player.armor == armors.ELFDRES && player.isElf()) lustDmgF *= 2;
        if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmgF *= 2;
        lustDmgF = lustDmgF * monster.lustVuln;
        lustDmgF = Math.round(lustDmgF);
        monster.teased(lustDmgF, false);
        combat.bonusExpAfterSuccesfullTease();
        if (crit2) outputText(" <b>Critical!</b>");
        if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
        if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
        if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3){
            if (rand(100) < stunChance) {
                if (monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
            }
        }
		if (player.perkv1(IMutationsLib.SlimeFluidIM) >= 4 && player.HP < player.maxHP()) monster.teased(combat.teases.teaseBaseLustDamage() * monster.lustVuln, false);
    }

    public function WeaponMeleeStatusProcs():void {
        var stun:Boolean = false;
        var stunChance:int = 0;
        var bleed:Boolean = false;
        var bleedChance:int = 0;
        if (player.isMaceHammerTypeWeapon()) stunChance += 10;
        if (player.isAxeTypeWeapon()) bleedChance += 25;
        // Item effects
        stunChance += player.weapon.effectPower(IELib.Stun);
        bleedChance += player.weapon.effectPower(IELib.Bleed);
        //10% Stun chance
        if (player.weapon == weapons.S_GAUNT && player.hasPerk(PerkLib.MightyFist) || player.hasAetherTwinsTier1()) stunChance += 10;
        //20% Stun chance
        if ((player.isFistOrFistWeapon() && player.weapon != weapons.KARMTOU && player.weapon != weapons.BFGAUNT && player.hasPerk(PerkLib.MightyFist))) stunChance += 20;
        //30% Stun chance
        if (player.weapon == weapons.ZWNDER && !monster.hasStatusEffect(StatusEffects.Stunned)) stunChance += 30;
        //40% Stun chance
        if (player.weapon == weapons.BFGAUNT && player.hasPerk(PerkLib.MightyFist)) stunChance += 40;
		//50% Stun chance
		if (player.hasAetherTwinsTier2() || (player.weapon == weapons.KARMTOU && player.hasPerk(PerkLib.MightyFist))) stunChance += 50;
		if (player.isMaceHammerTypeWeapon() && player.hasPerk(PerkLib.BalanceBreaker)) stunChance *= 0.5;
        if ((rand(100) < stunChance) && (!monster.hasPerk(PerkLib.Resolute) || (monster.hasPerk(PerkLib.Resolute) && player.isMaceHammerTypeWeapon() && player.hasPerk(PerkLib.BalanceBreaker)))) stun = true;
        if (stun) {
            outputText("\n[Themonster] reels from the brutal blow, stunned.");
            if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
                if (player.weapon == weapons.ZWNDER || player.weapon == weapons.UDKDEST) monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
                else monster.createStatusEffect(StatusEffects.Stunned, rand(2), 0, 0, 0);
            }
        }
        //10% Bleed chance
        if (player.hasAetherTwinsTier1()) bleedChance += 10;
        //25% Bleed chance
        if (player.hasAetherTwinsTierS1() || player.hasAetherTwinsTierS2()) bleedChance += 25;
		//45% Bleed chance
        if (player.hasAetherTwinsTier2()) bleedChance += 45;
        if (monster.hasPerk(PerkLib.EnemyConstructType) || monster.hasPerk(PerkLib.EnemyPlantType) || monster.hasPerk(PerkLib.EnemyGooType) || monster.hasPerk(PerkLib.EnemyUndeadType)) bleedChance = 0;
        if (rand(100) < bleedChance) bleed = true;
        if (bleed) {
            if (!monster.canMonsterBleed()) {
                if (monster is LivingStatue) outputText("Despite the rents you've torn in its stony exterior, the statue does not bleed.");
                else outputText("Despite the gashes you've torn in its exterior, [themonster] does not bleed.");
            } else {
                if (player.weapon == weapons.MACGRSW || player.weapon == weapons.TMACGRSW || player.weapon == weapons.RIPPER1 ||  player.weapon == weapons.TRIPPER1 || player.weapon == weapons.RIPPER2 || player.weapon == weapons.TRIPPER2) {
					if (monster.hasStatusEffect(StatusEffects.Hemorrhage))  monster.removeStatusEffect(StatusEffects.Hemorrhage);
                    if (player.weapon == weapons.MACGRSW || player.weapon == weapons.TMACGRSW) monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.02, 0, 0);
                    else monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.05, 0, 0);
                } else {
                    if (monster.hasStatusEffect(StatusEffects.IzmaBleed)) {
                        if (monster.statusEffectv4(StatusEffects.IzmaBleed) == 0) monster.addStatusValue(StatusEffects.IzmaBleed, 4, 1);
                        monster.addStatusValue(StatusEffects.IzmaBleed, 2, 1);
                    } else monster.createStatusEffect(StatusEffects.IzmaBleed, 3, 0, 0, 0);
                }
                if (monster.plural) outputText("\n[Themonster] bleed profusely from the many bloody gashes your [weapon] leave behind.");
                else outputText("\n[Themonster] bleeds profusely from the many bloody gashes your [weapon] left behind.");
            }
        }
        //Burn chances
        if (player.weapon == weapons.RIPPER2 || player.weapon == weapons.TRIPPER2) {
            outputText("\nReeling in pain [themonster] begins to burn.");
            if (monster.hasStatusEffect(StatusEffects.BurnDoT)) monster.addStatusValue(StatusEffects.BurnDoT,1,1);
            else monster.createStatusEffect(StatusEffects.BurnDoT, 5, 0.05, 0, 0);
        }
        if (player.weapon == weapons.ATWINSCY) {
            outputText("\nReeling in pain [themonster] begins to burn.");
            if (monster.hasStatusEffect(StatusEffects.BurnDoT)) monster.addStatusValue(StatusEffects.BurnDoT,1,3);
            else monster.createStatusEffect(StatusEffects.BurnDoT, 5, 0.05, 0, 0);
            if (monster.mana > 100)
            outputText("\n\nYour scythes also strip away measure of the enemies mana");
            monster.mana -= 100;
            if (monster.mana <0) monster.mana = 0;
        }
        if ((player.hasPerk(PerkLib.VampiricBlade) || player.hasStatusEffect(StatusEffects.LifestealEnchantment) || player.weapon == weapons.T_HEART || player.weapon == weapons.DORSOUL || player.weapon == weapons.LHSCYTH || player.weapon == weapons.ARMAGED) && !monster.hasPerk(PerkLib.EnemyConstructType)) {
			var restoreamount:Number = 0;
			if (player.hasPerk(PerkLib.VampiricBlade)) restoreamount += 1;
			if (player.hasStatusEffect(StatusEffects.LifestealEnchantment)) {
				if (player.hasPerk(PerkLib.WayOfTheBlood)) restoreamount += (1 + (0.25 * player.progressBloodDemon()));
				else restoreamount += 1;
			}
			if (player.weapon == weapons.LHSCYTH) restoreamount += 1;
			if (player.weapon == weapons.T_HEART || player.weapon == weapons.DORSOUL || player.weapon == weapons.ARMAGED) restoreamount += 1;
            if (player.weapon.isSmall()) HPChange(Math.round(player.maxHP() * restoreamount * 0.005), false);
            else if (player.weapon.isLarge()) HPChange(Math.round(player.maxHP() * restoreamount * 0.02), false);
            else if (player.weapon.isMassive()) HPChange(Math.round(player.maxHP() * restoreamount * 0.04), false);
            else HPChange(Math.round(player.maxHP() * restoreamount * 0.01), false);
        }
		if (player.weapon == weapons.VENCLAW && monster.lustVuln > 0) {
            outputText("\n[monster he] seems to be affected by the poison, showing increasing sign of arousal.");
            var Ldamage:Number = 8 + rand(3);
            if (player.armor == armors.ELFDRES && player.isElf()) Ldamage *= 2;
            if (player.armor == armors.FMDRESS && player.isWoodElf()) Ldamage *= 2;
            monster.teased(Math.round(monster.lustVuln * Ldamage));
            monster.statStore.addBuffObject({tou:-1}, "Poison",{text:"Poison"});
            if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                monster.addStatusValue(StatusEffects.NagaVenom, 3, 1);
            } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
            if (player.hasPerk(PerkLib.WoundPoison)){
                if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
            }
        }
		if (player.weapon == weapons.CHAOSEA) {
			var devouredWrath:Number = 0;
			var transferedWrath:Number = 0;
			var devouredMana:Number = 0;
			var transferedMana:Number = 0;
			if (monster.wrath > 1000) {
				monster.wrath -= 1000;
				transferedWrath += 500;
			} else {
				devouredWrath = monster.wrath;
				monster.wrath = 0;
				transferedWrath += Math.round(devouredWrath / 2)
			}
			if (transferedWrath > 0) {
				outputText("(+" + transferedWrath + " wrath)");
				player.wrath += transferedWrath;
			}
			if (monster.mana > 1000) {
				monster.mana -= 1000;
				transferedMana += 500;
			} else {
				devouredMana = monster.mana;
				monster.mana = 0;
				transferedMana += Math.round(devouredMana / 2)
			}
			if (transferedMana > 0) {
				outputText("(+" + transferedMana + " mana)");
				player.mana += transferedMana;
			}
		}
		if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch) && player.hasPerk(PerkLib.ElementalBody)) {
			if (player.perkv1(PerkLib.ElementalBody) == 1) {
				if (monster.hasStatusEffect(StatusEffects.Hemorrhage)) monster.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
                else monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.05, 0, 0);
			}
			if (player.perkv1(PerkLib.ElementalBody) == 2) {
				if (monster.hasStatusEffect(StatusEffects.AcidDoT)) {
					monster.addStatusValue(StatusEffects.AcidDoT,1,1);
					monster.addStatusValue(StatusEffects.AcidDoT,3,1);
				}
				else monster.createStatusEffect(StatusEffects.AcidDoT,4,0.02,1,0);
			}
			if (player.perkv1(PerkLib.ElementalBody) == 3) {
				if (monster.hasStatusEffect(StatusEffects.BurnDoT)) monster.addStatusValue(StatusEffects.BurnDoT,1,1);
				else monster.createStatusEffect(StatusEffects.BurnDoT,10,0.02,0,0);
			}
			if (player.perkv1(PerkLib.ElementalBody) == 4) {
				monster.statStore.addBuffObject({str:-10,spe:-10}, "Poison",{text:"Poison"});
				if (monster.hasStatusEffect(StatusEffects.FrostburnDoT)) monster.addStatusValue(StatusEffects.FrostburnDoT,1,1);
				else monster.createStatusEffect(StatusEffects.FrostburnDoT,4,0,0,0);
			}
		}
        if (player.hasPerk(PerkLib.PoisonNails) && player.isFistOrFistWeapon()) {
            var lust0damage:Number = 35 + rand(player.lib / 10);
            lust0damage *= 0.14;
            if (player.armor == armors.ELFDRES && player.isElf()) lust0damage *= 2;
            if (player.armor == armors.FMDRESS && player.isWoodElf()) lust0damage *= 2;
            monster.teased(Math.round(monster.lustVuln * lust0damage));
            monster.statStore.addBuffObject({tou:-2, spe:-2}, "Poison",{text:"Poison"});
            if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                monster.addStatusValue(StatusEffects.NagaVenom, 3, 1);
            } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
            if (player.hasPerk(PerkLib.WoundPoison)){
                if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
            }
        }
    }

    public function WeaponRangeStatusProcs():void {
		if (player.hasStatusEffect(StatusEffects.LifestealEnchantment) && !monster.hasPerk(PerkLib.EnemyConstructType)) {
			if (player.hasPerk(PerkLib.WayOfTheBlood)) HPChange(Math.round(player.maxHP() * (0.01+(0.0025 * player.progressBloodDemon()))), false);
			else HPChange(Math.round(player.maxHP() * 0.01), false);
		}
		if (player.weaponRangePerk == "Throwing" && player.hasPerk(PerkLib.ImpactThrow) && rand(10) == 0) {
            outputText("Attack leaves your opponent dazed!\n\n");
            monster.createStatusEffect(StatusEffects.Stunned, 1,0,0,0);
		}
    }

    public function WeaponFlyingSwordsStatusProcs():void {
		var bleed:Boolean = false;
        var bleedChance:int = 10;
		if (player.weaponFlyingSwords == weaponsflyingswords.MOONLGT) bleedChance += 15;
		if (player.weaponFlyingSwords == weaponsflyingswords.ASAUCHI) bleedChance -= 5;
        if (monster.hasPerk(PerkLib.EnemyConstructType) || monster.hasPerk(PerkLib.EnemyPlantType) || monster.hasPerk(PerkLib.EnemyGooType) || monster.hasPerk(PerkLib.EnemyUndeadType)) bleedChance = 0;
        if (rand(100) < bleedChance) bleed = true;
        if (bleed) {
            if (monster.hasPerk(PerkLib.EnemyConstructType)) {
                if (monster is LivingStatue) outputText("Despite the rents you've torn in its stony exterior, the statue does not bleed.");
                else outputText("Despite the gashes you've torn in its exterior, [themonster] does not bleed.");
            }
			else monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.05, 0, 0);
            if (monster.plural) outputText("\n[Themonster] bleed profusely from the many bloody gashes your "+player.weaponFlyingSwordsName+" leave"+(player.usingSingleFlyingSword()?"":"s")+" behind.");
            else outputText("\n[Themonster] bleeds profusely from the many bloody gashes your "+player.weaponFlyingSwordsName+" leave"+(player.usingSingleFlyingSword()?"":"s")+" behind.");
        }
		if (player.hasStatusEffect(StatusEffects.LifestealEnchantment) && !monster.hasPerk(PerkLib.EnemyConstructType)) HPChange(Math.round(player.maxHP() * 0.01), false);
    }

	public function ShieldsStatusProcs():void {
		var bleed:Boolean = false;
        var bleedChance:int = 0;
		//50% bleed chance
        if (player.shield == shields.SPIL_SH || player.shield == shields.SPIH_SH || player.shield == shields.SPIM_SH || (player.hasAetherTwinsTier2())) bleedChance += 50;
		if (monster.hasPerk(PerkLib.EnemyConstructType) || monster.hasPerk(PerkLib.EnemyPlantType) || monster.hasPerk(PerkLib.EnemyGooType) || monster.hasPerk(PerkLib.EnemyUndeadType)) bleedChance = 0;
        if (rand(100) < bleedChance) bleed = true;
		if (bleed) {
			if (monster.hasStatusEffect(StatusEffects.Hemorrhage)) monster.addStatusValue(StatusEffects.Hemorrhage, 1, 2);
			else {
                monster.createStatusEffect(StatusEffects.Hemorrhage, 2, 0.01, 0, 0);
                if (player.shield == shields.SPIH_SH) monster.addStatusValue(StatusEffects.Hemorrhage, 2, 0.01);
                else if (player.shield == shields.SPIM_SH) monster.addStatusValue(StatusEffects.Hemorrhage, 2, 0.04);
            }
			if (monster.plural) outputText("\n[Themonster] bleed profusely from the many bloody gashes your [shield] leave behind.");
            else outputText("\n[Themonster] bleeds profusely from the many bloody gashes your [shield] leave behind.");
		}
	}

	public function WrathGenerationPerHit1(damage:int = 0):void {	//base melee/range attacks wrath generation
		var addedWrath:Number = damage;
		if (player.hasPerk(PerkLib.FuriousStrikes)) addedWrath *= 3;
		if (player.hasPerk(PerkLib.UnlimitedRage)) addedWrath *= 3;
		if (player.perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 4 && player.racialScore(Races.HUMAN) > 17) addedWrath *= 5;
		if (player.hasPerk(PerkLib.ImprovedAdrenaline)) addedWrath += Math.round(player.maxWrath() * 0.02);
		if (player.hasPerk(PerkLib.PrestigeJobBerserker)) addedWrath += Math.round(player.maxWrath() * 0.01);
		EngineCore.WrathChange(addedWrath);
	}
	public function WrathGenerationPerHit2(damage:int = 0):void {	//specials wrath generation
		var addedWrath:Number = damage;
		if (player.hasPerk(PerkLib.FuriousStrikes)) addedWrath *= 3;
		if (player.hasPerk(PerkLib.UnlimitedRage)) addedWrath *= 3;
		if (player.perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 4 && player.racialScore(Races.HUMAN) > 17) addedWrath *= 5;
		if (player.hasPerk(PerkLib.ImprovedAdrenaline)) addedWrath += Math.round(player.maxWrath() * 0.02);
		if (player.hasPerk(PerkLib.PrestigeJobBerserker)) addedWrath += Math.round(player.maxWrath() * 0.01);
		EngineCore.WrathChange(addedWrath);
	}
	public function PASPAS(type:Number = 1):Number {
		var PAS:Number = 0.5;
		var Wr100:Number = player.wrath100;
		var overE:Boolean = true;
		if ((type == 1 && player.hasPerk(PerkLib.PowerAttackSu)) || (type == 2 && player.hasPerk(PerkLib.PowerShotSu))) overE = false;
		if ((Wr100 > 100) && overE) Wr100 = 100;
		if ((type == 1 && player.hasPerk(PerkLib.PowerAttackSu)) || (type == 2 && player.hasPerk(PerkLib.PowerShotSu))) PAS += Wr100 * 0.04;
		else PAS += Wr100 * 0.02;
		if (player.hasPerk(PerkLib.JobWarrior) || player.hasPerk(PerkLib.JobBeastWarrior)) PAS *= 2.5;
		if (player.hasPerk(PerkLib.PrestigeJobBerserker)) PAS *= 2;
		if (player.hasPerk(PerkLib.VexedNocking)) PAS *= 2;
        return PAS;
	}

    public function WrathWeaponsProc():void {
        if (player.weapon == weapons.BLETTER || player.weapon == weapons.C_BLADE) {
            player.takePhysDamage(player.maxHP() * 0.02);
            if (player.HP <= player.minHP()) {
                doNext(endHpLoss);
                return;
            }
        }
        if (player.isLowGradeWrathWeapon()) {
            if (player.wrath >= 5) player.wrath -= 5;
            else {
                player.takePhysDamage(50);
                if (player.HP <= player.minHP()) {
                    doNext(endHpLoss);
                    return;
                }
            }
        }
        if (player.isDualLowGradeWrathWeapon()) {
            if (player.wrath >= 10) player.wrath -= 10;
            else {
                player.takePhysDamage(100);
                if (player.HP <= player.minHP()) {
                    doNext(endHpLoss);
                }
            }
        }
        if (player.isMidGradeWrathWeapon()) {
            if (player.wrath >= 20) player.wrath -= 20;
            else {
                player.takePhysDamage(200);
                if (player.HP <= player.minHP()) {
                    doNext(endHpLoss);
                }
            }
        }
        if (player.isDualMidGradeWrathWeapon()) {
            if (player.wrath >= 40) player.wrath -= 40;
            else {
                player.takePhysDamage(400);
                if (player.HP <= player.minHP()) {
                    doNext(endHpLoss);
                }
            }
        }
    }

    //Let's use this shit for all damage reactions?
    public function heroBaneProc(damage:int = 0):void {
        if (monster is SiegweirdBoss) (monster as SiegweirdBoss).damageReaction(damage);
        if (player.hasStatusEffect(StatusEffects.HeroBane)) {
            if (damage > 0) {
                outputText("\nYou feel [themonster]'s wounds as well as your own. The link mirrors the creature's pain back to you. " + damage + " damage!\n");
                player.takePhysDamage(damage);
            }
        }
        if (player.HP <= player.minHP()) doNext(endHpLoss);
    }

    public function heroBaneProc2():void {
        if (monster is SiegweirdBoss) (monster as SiegweirdBoss).damageReaction(flags[kFLAGS.HERO_BANE_DAMAGE_BANK]);
        if (flags[kFLAGS.HERO_BANE_DAMAGE_BANK] > 0) {
            outputText("\nYou feel [themonster]'s wounds as well as your own. The link mirrors the creature's pain back to you. " + flags[kFLAGS.HERO_BANE_DAMAGE_BANK] + " damage!\n");
            player.takePhysDamage(flags[kFLAGS.HERO_BANE_DAMAGE_BANK]);
            flags[kFLAGS.HERO_BANE_DAMAGE_BANK] = 0;
        }
        if (player.HP <= player.minHP()) doNext(endHpLoss);
    }

    public function EruptingRiposte():void {
        if (monster.hasStatusEffect(StatusEffects.EruptingRiposte)) {
            var ERD:Number = monster.tou + monster.inte + monster.wis;
            outputText("\nAs you strike the snail her shell erupts with magma, splashing with liquid fire. \n");
            player.takeFireDamage(ERD, true);
            outputText(" \n");
            if (player.HP <= player.minHP()) {
                doNext(endHpLoss);
            }
        }
    }

    public function EruptingRiposte2():void {
        if (monster.hasStatusEffect(StatusEffects.EruptingRiposte)) {
            outputText("\nAs you strike the snail her shell erupts with magma, splashing with liquid fire. \n");
            player.takeFireDamage(flags[kFLAGS.ERUPTING_RIPOSTE_DAMAGE_BANK], true);
            flags[kFLAGS.ERUPTING_RIPOSTE_DAMAGE_BANK] = 0;
            outputText(" \n");
            if (player.HP <= player.minHP()) {
                doNext(endHpLoss);
            }
        }
    }

    public function wearingWinterScarf():Boolean {
        return player.necklace == necklaces.BWSCARF ||
                player.necklace == necklaces.GWSCARF ||
                player.necklace == necklaces.PWSCARF ||
                player.necklace == necklaces.RWSCARF ||
                player.necklace == necklaces.YWSCARF;
    }

    public function combatParry():Boolean {
        if (autoHitPlayer()) return false;
        var parryChance:int = 0;
        parryChance += combatParry2();
        return rand(100) <= parryChance;
//	trace("Parried!");
    }

    public function combatParry2():Number {
        var parryChance2:int = 0;
        if (player.hasPerk(PerkLib.Parry) && player.spe >= 50 && player.str >= 50 && player.weapon != WeaponLib.FISTS) {
            if (player.spe <= 100) parryChance2 += (player.spe - 50) / 5;
            else parryChance2 += 10;
            if (player.hasPerk(PerkLib.BladeBarrier) && (player.weapon.isDual() && !player.weapon.isSmall())) parryChance2 += 25;
        }
		if (player.hasPerk(PerkLib.OrthodoxDuelist) && player.isDuelingTypeWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) {
			if (player.spe <= 100) parryChance2 += player.spe / 10;
            else parryChance2 += 10;
		}
		if (player.hasPerk(PerkLib.KnightlySword) && player.isSwordTypeWeapon() && player.isShieldsForShieldBash()) parryChance2 += 15;
		if (player.weapon.isSingleMassive()) parryChance2 += 5;
        if (player.weaponName == "Undefeated King's Destroyer") parryChance2 += 15;
        if (player.hasPerk(PerkLib.DexterousSwordsmanship)) parryChance2 += 10;
        if (player.hasPerk(PerkLib.CatchTheBlade) && player.spe >= 50 && player.shieldName == "nothing" && player.isFistOrFistWeapon()) parryChance2 += 15;
        if (player.hasPerk(PerkLib.Backlash) && player.shieldName == "nothing" && player.isFistOrFistWeapon()) parryChance2 += 5;
		if (player.hasPerk(PerkLib.SereneMind) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) parryChance2 += 10;
        return parryChance2;
    }

    public function combatPhysicalCritical():Number {
        var critPChance:int = 0;
        if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
            if (player.inte <= 100) critPChance += (player.inte - 50) / 5;
            if (player.inte > 100) critPChance += 10;
        }
        if (player.hasPerk(PerkLib.GrandTactician) && player.inte >= 150) {
            if (player.inte <= 300) critPChance += (player.inte - 150) / 5;
            if (player.inte > 300) critPChance += 30;
        }
        if (player.hasPerk(PerkLib.WarCaster) && player.inte >= 50) {
            if (player.inte <= 300) critPChance += (player.inte - 50) / 10;
            if (player.inte > 300) critPChance += 25;
        }
        if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critPChance += 5;
        if (player.hasPerk(PerkLib.Blademaster) && player.isNotHavingShieldCuzPerksNotWorkingOtherwise() && (player.isSwordTypeWeapon() || player.isDuelingTypeWeapon() || player.isAxeTypeWeapon() || player.isDaggerTypeWeapon() || player.isScytheTypeWeapon())) critPChance += 5;
        if (player.hasPerk(PerkLib.GrandBlademaster) && player.isNotHavingShieldCuzPerksNotWorkingOtherwise() && (player.isSwordTypeWeapon() || player.isDuelingTypeWeapon() || player.isAxeTypeWeapon() || player.isDaggerTypeWeapon() || player.isScytheTypeWeapon())) critPChance += 15;
        if (player.armor == armors.R_CHANG || player.armor == armors.R_QIPAO || player.armor == armors.G_CHANG || player.armor == armors.G_QIPAO || player.armor == armors.B_CHANG || player.armor == armors.B_QIPAO || player.armor == armors.P_CHANG || player.armor == armors.P_QIPAO) critPChance += 5;
        if (player.headJewelry == headjewelries.SCANGOG) critPChance += 5;
        if (player.headJewelry == headjewelries.SATGOG) critPChance += 10;
        if (player.hasStatusEffect(StatusEffects.Rage)) critPChance += player.statusEffectv1(StatusEffects.Rage);
		if (player.eyesOfTheHunterAdeptBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterAdept) && player.sens >= 50) critPChance += 5;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) critPChance += 95;
				else critPChance += 2 * Math.round((player.sens - 25) / 5);
			}
		}
		if (player.eyesOfTheHunterExpertBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterExpert) && player.sens >= 75) critPChance += 5;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) critPChance += 95;
				else critPChance += 2 * Math.round((player.sens - 25) / 5);
			}
		}
		if (player.eyesOfTheHunterMasterBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterMaster) && player.sens >= 100) critPChance += 5;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) critPChance += 95;
				else critPChance += 2 * Math.round((player.sens - 25) / 5);
			}
		}
		if (player.eyesOfTheHunterGrandMasterBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterGrandMaster) && player.sens >= 125) critPChance += 5;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) critPChance += 95;
				else critPChance += 2 * Math.round((player.sens - 25) / 5);
			}
		}
        if (player.perkv1(IMutationsLib.EyeOfTheTigerIM) >= 2) critPChance += 5;
        return critPChance;
    }

    public function combatMagicalCritical():Number {
        var critMChance:int = 0;
        if (player.hasPerk(PerkLib.MagiculesTheory) && player.wis >= 50) {
            if (player.wis <= 100) critMChance += (player.wis - 50) / 5;
            if (player.wis > 100) critMChance += 10;
        }
        if (player.hasPerk(PerkLib.AdvancedMagiculesTheory) && player.wis >= 150) {
            if (player.wis <= 300) critMChance += (player.wis - 150) / 5;
            if (player.wis > 300) critMChance += 30;
        }
        if (player.hasPerk(PerkLib.WarCaster) && player.inte >= 50) {
            if (player.inte <= 300) critMChance += (player.inte - 50) / 10;
            if (player.inte > 300) critMChance += 25;
        }
        if (player.hasPerk(PerkLib.ElvenSense) && player.wis >= 50) critMChance += 5;
        if (player.armor == armors.R_CHANG || player.armor == armors.R_QIPAO || player.armor == armors.G_CHANG || player.armor == armors.G_QIPAO || player.armor == armors.B_CHANG || player.armor == armors.B_QIPAO || player.armor == armors.P_CHANG || player.armor == armors.P_QIPAO) critMChance += 5;
        if (player.headJewelry == headjewelries.SCANGOG) critMChance += 5;
        if (player.headJewelry == headjewelries.SATGOG) critMChance += 10;
		if (player.eyesOfTheHunterAdeptBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterAdept) && player.sens >= 50) critMChance += 5;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) critMChance += 95;
				else critMChance += 2 * Math.round((player.sens - 25) / 5);
			}
		}
		if (player.eyesOfTheHunterExpertBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterExpert) && player.sens >= 75) critMChance += 5;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) critMChance += 95;
				else critMChance += 2 * Math.round((player.sens - 25) / 5);
			}
		}
		if (player.eyesOfTheHunterMasterBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterMaster) && player.sens >= 100) critMChance += 5;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) critMChance += 95;
				else critMChance += 2 * Math.round((player.sens - 25) / 5);
			}
		}
		if (player.eyesOfTheHunterGrandMasterBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterGrandMaster) && player.sens >= 125) critMChance += 5;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) critMChance += 95;
				else critMChance += 2 * Math.round((player.sens - 25) / 5);
			}
		}
        return critMChance;
    }

    public function combatBlock(doFatigue:Boolean = false):Boolean {
        if (autoHitPlayer()) return false;
        //Set chance
        var blockChance:int = 20 + player.shieldBlock + Math.floor((player.str - monster.str) / 5);
        if (player.hasPerk(PerkLib.ShieldMastery) && player.tou >= 50 && player.isShieldsForShieldBash()) {
            if (player.tou < 100) blockChance += (player.tou - 50) / 5;
            else blockChance += 10;
        }
        if (player.hasPerk(PerkLib.ShieldGrandmastery) && player.tou >= 100 && player.isShieldsForShieldBash()) {
            if (player.tou < 150) blockChance += (player.tou - 100) / 5;
            else blockChance += 10;
        }
		if (player.hasPerk(PerkLib.DivineArmament) && (player.isUsingStaff() || player.isUsingWand() || player.isPartiallyStaffTypeWeapon()) && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) blockChance += 10;
		if (player.hasStatusEffect(StatusEffects.Aegis)) blockChance += player.statusEffectv1(StatusEffects.Aegis);
		if (player.hasPerk(PerkLib.SereneMind) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) blockChance += 10;
        if (blockChance < 10) blockChance = 10;
        //Wrath limit
		var wrathShieldSize:int = 6;
		if (player.shieldPerk == "Large") wrathShieldSize += 4;
		if (player.shieldPerk == "Massive") wrathShieldSize += 4;
        if (blockChance >= (rand(100) + 1) && player.wrath >= wrathShieldSize && player.shieldName != "nothing" && player.isShieldsForShieldBash()) {// && player.weaponRange != weaponsrange.M1CERBE
            if (doFatigue) {
                if (player.hasPerk(PerkLib.ShieldGrandmastery) && player.tou >= 100) EngineCore.WrathChange((wrathShieldSize * 0.5));
                else EngineCore.WrathChange(wrathShieldSize);
            }
            return true;
        } else return false;
    }

    public function combatBlock2():Number {
        var blockChance2:Number = 20 + player.shieldBlock;
        if (player.hasPerk(PerkLib.ShieldMastery) && player.tou >= 50 && player.isShieldsForShieldBash()) {
            if (player.tou < 100) blockChance2 += (player.tou - 50) / 5;
            else blockChance2 += 10;
        }
        if (player.hasPerk(PerkLib.ShieldGrandmastery) && player.tou >= 100 && player.isShieldsForShieldBash()) {
            if (player.tou < 150) blockChance2 += (player.tou - 100) / 5;
            else blockChance2 += 10;
        }
		if (player.hasPerk(PerkLib.DivineArmament) && (player.isUsingStaff() || player.isUsingWand() || player.isPartiallyStaffTypeWeapon()) && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) blockChance2 += 10;
		if (player.hasStatusEffect(StatusEffects.Aegis)) blockChance2 += player.statusEffectv1(StatusEffects.Aegis);
        if (blockChance2 < 10) blockChance2 = 10;
        //if (player.weaponRange == weaponsrange.M1CERBE) blockChance2 = 0;
        return blockChance2;
    }

//DR depending on diff in lvl between PC and enemy(ies)
    public function doDamageReduction():Number {
        var damagereduction:Number = 1;
        var plaLvl:Number = player.level + playerLevelAdjustment();
        var monLvl:Number = monster.level + monsterLevelAdjustment();
        if (plaLvl > monLvl) {
            damagereduction += 0.02 * (plaLvl - monLvl);
            if (damagereduction > 2) damagereduction = 2;//200% dmg przy różnicy 50+ lvl-i
        }
        if (plaLvl < monLvl) {
            if ((monLvl - plaLvl) < 50) damagereduction -= 0.02 * (monLvl - plaLvl);
            else damagereduction = 0;
        }
        return damagereduction;
    }

    public function playerLevelAdjustment():Number {
        var playerLevelAdjustment:Number = 0;
		if (player.hasPerk(PerkLib.EyesOfTheHunterEx) && player.sens >= 25) {
			if (player.sens >= 750) playerLevelAdjustment += 30;
			else playerLevelAdjustment += Math.round((player.sens - 12) / 25);
		}
		if (player.hasMutation(IMutationsLib.GorgonEyesIM) && player.perkv1(IMutationsLib.GorgonEyesIM) >= 3 && player.sens >= 25) {
			var maxSensG:Number = 125;
			if (player.perkv1(IMutationsLib.GorgonEyesIM) >= 4) maxSensG += 250;
			if (player.hairType == Hair.GORGON) maxSensG *= 2;
			if (player.sens >= maxSensG) playerLevelAdjustment += (maxSensG * 0.04);
			else playerLevelAdjustment += Math.round((player.sens - 12) / 25);
		}
		if (player.hasMutation(IMutationsLib.HumanEyesIM) && player.racialScore(Races.HUMAN) > 17 && player.sens >= 25) {
			var maxSens:Number = 125;
			if (player.perkv1(IMutationsLib.HumanEyesIM) >= 2) maxSens += 125;
			if (player.perkv1(IMutationsLib.HumanEyesIM) >= 3) maxSens += 500;
			if (player.perkv1(IMutationsLib.HumanEyesIM) >= 4) maxSens += 750;
			if (player.sens >= maxSens) playerLevelAdjustment += (maxSens * 0.04);
			else playerLevelAdjustment += Math.round((player.sens - 12) / 25);
		}
        return playerLevelAdjustment;
    }

    public function monsterLevelAdjustment():Number {
        var monsterLvlAdjustment:Number = 0;
		if (player.miscjewelryName == "Kratia's Seal") {
			if (monster is TrainingDummy) monsterLvlAdjustment += 50;
			monsterLvlAdjustment += 100;
		}
		if (player.miscjewelryName2 == "Kratia's Seal") {
			if (monster is TrainingDummy) monsterLvlAdjustment += 50;
			monsterLvlAdjustment += 100;
		}
		if (player.vehiclesName == "Giant Slayer Mech") {
			if (monster.hasPerk(PerkLib.EnemyGigantType) || monster.hasPerk(PerkLib.EnemyColossalType) || monster.hasPerk(PerkLib.EnemyGodType)) monsterLvlAdjustment -= 10;
			else monsterLvlAdjustment += 10;
		}
		if (monster.hasPerk(PerkLib.EnemyHugeType)) monsterLvlAdjustment += 2;
		if (monster.hasPerk(PerkLib.EnemyGigantType)) monsterLvlAdjustment += 5;
		if (monster.hasPerk(PerkLib.EnemyColossalType)) monsterLvlAdjustment += 10;
		//if (player.hasPerk(PerkLib.EnemyGodType))
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) monsterLvlAdjustment += monster.statusEffectv2(StatusEffects.TranscendentSoulField);
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) monsterLvlAdjustment += monster.statusEffectv2(StatusEffects.ATranscendentSoulField);
        return monsterLvlAdjustment;
    }

	private function EyesOfTheHunterDamageBonus():Number {
		var EOTHDBonus:Number = 1;
		if (player.eyesOfTheHunterAdeptBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterAdept) && player.sens >= 50) EOTHDBonus += 0.1;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) EOTHDBonus += 1.9;
				else EOTHDBonus += 0.02 * Math.round((player.sens - 25) / 5);
			}
		}
		if (player.eyesOfTheHunterExpertBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterExpert) && player.sens >= 75) EOTHDBonus += 0.1;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) EOTHDBonus += 1.9;
				else EOTHDBonus += 0.02 * Math.round((player.sens - 25) / 5);
			}
		}
		if (player.eyesOfTheHunterMasterBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterMaster) && player.sens >= 100) EOTHDBonus += 0.1;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) EOTHDBonus += 1.9;
				else EOTHDBonus += 0.02 * Math.round((player.sens - 25) / 5);
			}
		}
		if (player.eyesOfTheHunterGrandMasterBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterGrandMaster) && player.sens >= 125) EOTHDBonus += 0.1;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) EOTHDBonus += 1.9;
				else EOTHDBonus += 0.02 * Math.round((player.sens - 25) / 5);
			}
		}
		return EOTHDBonus;
	}

    //DEAL DAMAGE
    public function doTrueDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) damage *= doDamageAscensionModifer();
        if (damage < 1) damage = 1;
		if (monster.damageReductionBasedOnDifficulty() > 1) damage *= (1 / monster.damageReductionBasedOnDifficulty());
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.NecroticRot)) damage *= (1 + (0.25 * monster.statusEffectv1(StatusEffects.NecroticRot)));
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            if (player.armor == armors.SCANSC) {
                damage *= 1.2;
                dynStats("lus", 3);
            }
            dynStats("lus", 3);
        }
		if (player.hasPerk(PerkLib.EclipticInfusion) && player.perkv3(PerkLib.ElementalBody) > 0) {
			if (player.perkv3(PerkLib.ElementalBody) == 1) damage *= 1 + (0.01 * player.cor);
			else damage *= 1 + (0.01 * (100 - player.cor));
		}
        if (monster.hasStatusEffect(StatusEffects.BerzerkingSiegweird)) damage *= 1.2;
        if (player.hasPerk(PerkLib.Anger) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
            var bonusDamageFromMissingHP:Number = 1;
            if (player.hp100 < 100) {
                if (player.hp100 < 1) bonusDamageFromMissingHP += 0.99;
                else bonusDamageFromMissingHP += (1 - (player.hp100 * 0.01));
            }
            damage *= bonusDamageFromMissingHP;
        }
        if (monster.hasStatusEffect(StatusEffects.AcidDoT)) {
            if (monster.statusEffectv3(StatusEffects.AcidDoT) > 0) damage *= (1 + (0.3 * monster.statusEffectv3(StatusEffects.AcidDoT)));
            if (monster.statusEffectv4(StatusEffects.AcidDoT) > 0) damage *= (1 + (0.1 * monster.statusEffectv4(StatusEffects.AcidDoT)));
        }
		if (monster.hasStatusEffect(StatusEffects.Provoke)) damage *= monster.statusEffectv2(StatusEffects.Provoke);
		if (player.hasPerk(PerkLib.KnowledgeIsPower)) {
			if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 3) damage *= (1 + (Math.round(camp.codex.checkUnlocked() / 100) * 3));
			else damage *= (1 + Math.round(camp.codex.checkUnlocked() / 100));
		}
		damage *= EyesOfTheHunterDamageBonus();
        if (damage == 0) MSGControllForEvasion = true;
        if (monster.HP - damage <= monster.minHP()) {
            /* No monsters use this perk, so it's been removed for now
		if(monster.hasPerk(PerkLib.LastStrike)) doNext(monster.perk(monster.findPerk(PerkLib.LastStrike)).value1);
		else doNext(endHpVictory);
		*/
            doNext(endHpVictory);
        }
        damage = Math.round(damage);
        if (damage < 0) damage = 1;
        if (apply) {
            damage = monster.doTrueDamageBefore(damage);
            if(damage<=0){
                return 0;
            }
            monster.HP -= damage;
			var WrathGains:Number = 0;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) WrathGains += Math.round((damage / 5)*BonusWrathMult);
            else WrathGains += Math.round((damage / 10) * BonusWrathMult);
			if (monster.monsterIsBleeding() && player.hasPerk(PerkLib.YourPainMyPower)) {
				player.HP += damage;
				if (player.HP > (player.maxHP() + player.maxOverHP())) player.HP = player.maxHP() + player.maxOverHP();
				if (flags[kFLAGS.YPMP_WRATH_GEN] == 0) EngineCore.WrathChange(WrathGains);
			}
			else monster.wrath += WrathGains;
            if (monster.wrath > monster.maxOverWrath()) monster.wrath = monster.maxOverWrath();
        }
        if (display) CommasForDigits(damage);
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
		if (!ignoreDR) damage *= (monster.damagePercent() / 100);
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) damage *= doDamageAscensionModifer();
		if (damage < 1) damage = 1;
		if (monster.damageReductionBasedOnDifficulty() > 1) damage *= (1 / monster.damageReductionBasedOnDifficulty());
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.NecroticRot)) damage *= (1 + (0.25 * monster.statusEffectv1(StatusEffects.NecroticRot)));
        if (player.hasStatusEffect(StatusEffects.Minimise)) damage *= 0.01;
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            if (player.armorName == "Scandalous Succubus Clothing") {
                damage *= 1.2;
                dynStats("lus", 3);
            }
            dynStats("lus", 3);
        }
		if (player.hasPerk(PerkLib.EclipticInfusion) && player.perkv3(PerkLib.ElementalBody) > 0) {
			if (player.perkv3(PerkLib.ElementalBody) == 1) damage *= 1 + (0.01 * player.cor);
			else damage *= 1 + (0.01 * (100 - player.cor));
		}
        if (monster.hasStatusEffect(StatusEffects.BerzerkingSiegweird)) damage *= 1.2;
        if (player.hasPerk(PerkLib.Anger) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
            var bonusDamageFromMissingHP:Number = 1;
            if (player.hp100 < 100) {
                if (player.hp100 < 1) bonusDamageFromMissingHP += 0.99;
                else bonusDamageFromMissingHP += (1 - (player.hp100 * 0.01));
            }
            damage *= bonusDamageFromMissingHP;
        }
        if (monster.hasStatusEffect(StatusEffects.IceArmor)) damage *= 0.1;
        if (monster.hasStatusEffect(StatusEffects.DefendMonsterVer)) damage *= (1 - monster.statusEffectv2(StatusEffects.DefendMonsterVer));
        if (monster.hasStatusEffect(StatusEffects.Provoke)) damage *= monster.statusEffectv2(StatusEffects.Provoke);
		if (player.hasPerk(PerkLib.KnowledgeIsPower)) {
			if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 3) damage *= (1 + (Math.round(camp.codex.checkUnlocked() / 100) * 3));
			else damage *= (1 + Math.round(camp.codex.checkUnlocked() / 100));
		}
		if (player.hasPerk(PerkLib.SharedPower) && player.perkv1(PerkLib.SharedPower) > 0) damage *= (1+(0.1*player.perkv1(PerkLib.SharedPower)));
		damage *= EyesOfTheHunterDamageBonus();
		if (monster.hasPerk(PerkLib.EnemyGhostType) && !canLayerSwordIntentAura()) damage = 0;
        if (damage == 0) MSGControllForEvasion = true;
        if (monster.HP - damage <= monster.minHP()) {
            doNext(endHpVictory);
        }
        // Uma's Massage Bonuses
        var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
        if (sac) {
            if (sac.value1 == UmasShop.MASSAGE_POWER) {
                damage *= sac.value2;
            }
        }
        damage = Math.round(damage);
        if (damage < 0) damage = 1;
        if (apply) {
            damage = monster.doDamageBefore(damage);
            if(damage<=0){
                return 0;
            }
            monster.HP -= damage;
			var WrathGains:Number = 0;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) WrathGains += Math.round((damage / 5)*BonusWrathMult);
            else WrathGains += Math.round((damage / 10) * BonusWrathMult);
			if (monster.monsterIsBleeding() && player.hasPerk(PerkLib.YourPainMyPower)) {
				player.HP += damage;
				if (player.HP > (player.maxHP() + player.maxOverHP())) player.HP = player.maxHP() + player.maxOverHP();
				if (flags[kFLAGS.YPMP_WRATH_GEN] == 0) EngineCore.WrathChange(WrathGains);
			}
			else monster.wrath += WrathGains;
            if (monster.wrath > monster.maxOverWrath()) monster.wrath = monster.maxOverWrath();
        }
        if (display) CommasForDigits(damage);
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

	public function doPhysicalDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 1 && monster.monsterIsBleeding()) {
			var ddd:Number = 1.1;
			if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 2) ddd += 0.15;
			if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 3) ddd += 0.2;
			if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 4) ddd += 0.25;
			damage *= ddd;
		}
        if (monster.hasStatusEffect(StatusEffects.WoundPoison)) damage *= 1+(monster.statusEffectv1(StatusEffects.WoundPoison)/100);
        if (player.perkv1(IMutationsLib.AlphaHowlIM) >= 3) {
            var packmultiplier:Number = 1.0;
            var PerkMultiplier:Number = 2;
            var packMembers:Number = LunaFollower.WerewolfPackMember;
            if (player.hasMutation(IMutationsLib.HellhoundFireBallsIM)) packMembers += LunaFollower.HellhoundPackMember;
            if (player.perkv1(IMutationsLib.AlphaHowlIM) >= 4) PerkMultiplier = 5;
            packmultiplier += (packMembers*PerkMultiplier)/100
            damage *= packmultiplier;
        }
        if (monster.hasStatusEffect(StatusEffects.AcidDoT)) {
            if (monster.statusEffectv3(StatusEffects.AcidDoT) > 0) damage *= (1 + (0.3 * monster.statusEffectv3(StatusEffects.AcidDoT)));
            if (monster.statusEffectv4(StatusEffects.AcidDoT) > 0) damage *= (1 + (0.1 * monster.statusEffectv4(StatusEffects.AcidDoT)));
        }
		return doDamage(damage, apply, display, ignoreDR);
    }

    public function doMinionPhysDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        return doDamage(damage, apply, display, ignoreDR);
    }
	
	public function doDamageAscensionModifer():Number {
		var dDAM:Number = 1;
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 1) dDAM *= (1 / 2);
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 2) dDAM *= (1 / 5);
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 3) dDAM *= (1 / 9);
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 4) dDAM *= (1 / 14);
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 5) dDAM *= (1 / 20);
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 6) dDAM *= (1 / 27);//dla gier powyżej obecnego ostatniego NG+ posiadającego nowe perki dla graczy
		//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 7) dDAM *= (1 / 35);
		//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 8) dDAM *= (1 / 44);
		//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 9) dDAM *= (1 / 54);
		return dDAM;
	}

    public function doMagicDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) damage *= doDamageAscensionModifer();
		if (!ignoreDR) damage *= (monster.damageMagicalPercent() / 100);
		if (monster.damageReductionBasedOnDifficulty() > 1) damage *= (1 / monster.damageReductionBasedOnDifficulty());
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.NecroticRot)) damage *= (1 + (0.25 * monster.statusEffectv1(StatusEffects.NecroticRot)));
		if (damage < 1) damage = 1;
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            dynStats("lus", 3);
            if (player.armor == armors.SCANSC) {
                damage *= 1.2;
                dynStats("lus", 3);
            }
        }
        if (player.hasPerk(PerkLib.SharedPower) && player.perkv1(PerkLib.SharedPower) > 0) damage *= (1+(0.1*player.perkv1(PerkLib.SharedPower)));
		if (player.hasPerk(PerkLib.EclipticInfusion) && player.perkv3(PerkLib.ElementalBody) > 0) {
			if (player.perkv3(PerkLib.ElementalBody) == 1) damage *= 1 + (0.01 * player.cor);
			else damage *= 1 + (0.01 * (100 - player.cor));
		}
        if (monster.hasStatusEffect(StatusEffects.BerzerkingSiegweird)) damage *= 1.2;
        if (player.hasPerk(PerkLib.Anger) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
            var bonusDamageFromMissingHP:Number = 1;
            if (player.hp100 < 100) {
                if (player.hp100 < 1) bonusDamageFromMissingHP += 0.99;
                else bonusDamageFromMissingHP += (1 - (player.hp100 * 0.01));
            }
            damage *= bonusDamageFromMissingHP;
        }
        if (monster.hasStatusEffect(StatusEffects.IceArmor)) damage *= 0.1;
        if (monster.hasStatusEffect(StatusEffects.DefendMonsterVer)) damage *= (1 - monster.statusEffectv2(StatusEffects.DefendMonsterVer));
        if (monster.hasStatusEffect(StatusEffects.AcidDoT)) damage *= (1 + (0.3 * monster.statusEffectv3(StatusEffects.AcidDoT)));
		if (monster.hasStatusEffect(StatusEffects.Provoke)) damage *= monster.statusEffectv2(StatusEffects.Provoke);
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
		damage *= EyesOfTheHunterDamageBonus();
        if (damage == 0) MSGControllForEvasion = true;
        if (monster.HP - damage <= monster.minHP()) {
            doNext(endHpVictory);
        }
        // Uma's Massage Bonuses
        var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
        if (sac) {
            if (sac.value1 == UmasShop.MASSAGE_POWER) {
                damage *= sac.value2;
            }
        }
        damage = Math.round(damage);
        if (damage < 0) damage = 1;
        if (apply) {
            damage = monster.doMagicDamageBefore(damage);
            if(damage<=0){
                return 0;
            }
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxOverWrath()) monster.wrath = monster.maxOverWrath();
        }
        if (display) CommasForDigits(damage);
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    private function doElementalDamageMultiplier(damage:Number):Number {
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) damage *= doDamageAscensionModifer();
        if (damage < 1) damage = 1;
		if (monster.damageReductionBasedOnDifficulty() > 1) damage *= (1 / monster.damageReductionBasedOnDifficulty());
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.NecroticRot)) damage *= (1 + (0.25 * monster.statusEffectv1(StatusEffects.NecroticRot)));
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            dynStats("lus", 3);
            if (player.armor == armors.SCANSC) {
                damage *= 1.2;
                dynStats("lus", 3);
            }
        }
        if (player.hasPerk(PerkLib.SharedPower) && player.perkv1(PerkLib.SharedPower) > 0) damage *= (1+(0.1*player.perkv1(PerkLib.SharedPower)));
        if (player.hasPerk(PerkLib.EclipticInfusion) && player.perkv3(PerkLib.ElementalBody) > 0) {
            if (player.perkv3(PerkLib.ElementalBody) == 1) damage *= 1 + (0.01 * player.cor);
            else damage *= 1 + (0.01 * (100 - player.cor));
        }
        if (monster.hasStatusEffect(StatusEffects.BerzerkingSiegweird)) damage *= 1.2;
        if (player.hasPerk(PerkLib.Anger) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
            var bonusDamageFromMissingHP:Number = 1;
            if (player.hp100 < 100) {
                if (player.hp100 < 1) bonusDamageFromMissingHP += 0.99;
                else bonusDamageFromMissingHP += (1 - (player.hp100 * 0.01));
            }
            damage *= bonusDamageFromMissingHP;
        }
        if (monster.hasStatusEffect(StatusEffects.IceArmor)) damage *= 0.1;
        if (monster.hasStatusEffect(StatusEffects.DefendMonsterVer)) damage *= (1 - monster.statusEffectv2(StatusEffects.DefendMonsterVer));
        if (monster.hasStatusEffect(StatusEffects.AcidDoT)) damage *= (1 + (0.3 * monster.statusEffectv3(StatusEffects.AcidDoT)));
        if (monster.hasStatusEffect(StatusEffects.Provoke)) damage *= monster.statusEffectv2(StatusEffects.Provoke);
        if (monster.hasStatusEffect(StatusEffects.ElementalResist)) damage *= (1 - monster.statusEffectv1(StatusEffects.ElementalResist));
        return damage;
    }

    public function doFireDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
        damage = doElementalDamageMultiplier(damage);
		if (!ignoreDR) damage *= (monster.damageMagicalPercent() / 100);
        if (player.weapon === weapons.R_STAFF) damage *= 1.4;
		if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.925;
        damage = fireTypeDamageBonus(damage);
        if (player.hasStatusEffect(StatusEffects.YukiOnnaKimono)) damage *= 0.2;
        if (player.hasPerk(PerkLib.WalpurgisIzaliaRobe)) damage *= 2;
        if (player.hasPerk(PerkLib.IceQueenGown)) damage = damage / 100;
        if (player.hasPerk(PerkLib.InfernalRage)) damage *= (1 + (player.wrath100 * 0.01));
        if (player.shieldName == "Nekonomicon") damage *= 2;
		damage *= EyesOfTheHunterDamageBonus();
        if (damage == 0) MSGControllForEvasion = true;
        if (player.hasMutation(IMutationsLib.HellhoundFireBallsIM)) {
            if(player.perkv1(IMutationsLib.HellhoundFireBallsIM) >= 3){
                damage *= (0.1* player.cumQ());
            }
            else if(player.perkv1(IMutationsLib.HellhoundFireBallsIM) >= 2){
                damage *= (0.05* player.cumQ())
            }
        }
        // if (player.hasMutation(IMutationsLib.HellhoundFireBallsIM) && player.perkv1(IMutationsLib.HellhoundFireBallsIM) >= 2) damage *= (0.05* player.cumQ());
        // if (player.hasMutation(IMutationsLib.HellhoundFireBallsIM) && player.perkv1(IMutationsLib.HellhoundFireBallsIM) >= 3) damage *= (0.05* player.cumQ());
        if (monster.HP - damage <= monster.minHP()) {
            /* No monsters use this perk, so it's been removed for now
		if(monster.hasPerk(PerkLib.LastStrike)) doNext(monster.perk(monster.findPerk(PerkLib.LastStrike)).value1);
		else doNext(endHpVictory);
		*/
            doNext(endHpVictory);
        }
        // Uma's Massage Bonuses
        var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
        if (sac) {
            if (sac.value1 == UmasShop.MASSAGE_POWER) {
                damage *= sac.value2;
            }
        }
        damage = Math.round(damage);
        if (damage < 0) damage = 1;
        if (apply) {
            damage = monster.doFireDamageBefore(damage);
            if(damage<=0){
                return 0;
            }
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxOverWrath()) monster.wrath = monster.maxOverWrath();
        }
        if (display) CommasForDigits(damage, false, "", "fire");
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        if (monster.hasPerk(PerkLib.HydraRegeneration)) {
            if (monster is Hydra) {
				monster.createStatusEffect(StatusEffects.HydraRegenerationDisabled, 5, 0, 0, 0);
				outputText(" The hydra hisses in anger as her wound cauterised, preventing regeneration. It's the time to strike!");
			}
			if (monster is CorruptedMaleTroll || monster is CorruptedFemaleTroll || monster is Zenji) monster.createStatusEffect(StatusEffects.HydraRegenerationDisabled, 2, 0, 0, 0);
        }
        if (monster.hasStatusEffect(StatusEffects.IceArmor)) {
            monster.addStatusValue(StatusEffects.IceArmor, 1, -1);
            outputText(" The icy shield encasing [themonster] begins to melt from the heat.");
        }
        return damage;
    }

    public function doIceDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
        damage = doElementalDamageMultiplier(damage);
		if (!ignoreDR) damage *= (monster.damageMagicalPercent() / 100);
		if (player.weapon == weapons.S_STAFF) damage *= 1.4;
        if (monster.hasStatusEffect(StatusEffects.FrostburnDoT) && monster.statusEffectv3(StatusEffects.FrostburnDoT) > 0) damage *= (1 + (0.5 * monster.statusEffectv3(StatusEffects.FrostburnDoT)));
        damage = iceTypeDamageBonus(damage);
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
        if (monster.hasPerk(PerkLib.IcyFlesh)) damage *= 0.6;
        if (player.hasStatusEffect(StatusEffects.YukiOnnaKimono)) damage *= 1.4;
        if (player.hasPerk(PerkLib.IceQueenGown)) damage *= 2;
        if (player.hasPerk(PerkLib.WalpurgisIzaliaRobe)) damage = damage / 100;
		damage *= EyesOfTheHunterDamageBonus();
        if (damage == 0) MSGControllForEvasion = true;
        if (monster.HP - damage <= monster.minHP()) {
            doNext(endHpVictory);
        }
        // Uma's Massage Bonuses
        var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
        if (sac) {
            if (sac.value1 == UmasShop.MASSAGE_POWER) {
                damage *= sac.value2;
            }
        }
        damage = Math.round(damage);
        if (damage < 0) damage = 1;
        if (apply) {
            damage = monster.doIceDamageBefore(damage);
            if(damage<=0){
                return 0;
            }
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxOverWrath()) monster.wrath = monster.maxOverWrath();
        }
        if (display) CommasForDigits(damage, false, "", "cold");
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        if (monster.hasStatusEffect(StatusEffects.IceArmor)) {
            monster.addStatusValue(StatusEffects.IceArmor, 1, 1);
            outputText(" The icy shield encasing [themonster] hardens from the cold.");
        }
        return damage;
    }

    public function doLightningDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
        damage = doElementalDamageMultiplier(damage);
		if (!ignoreDR) damage *= (monster.damageMagicalPercent() / 100);
        if (player.weapon == weapons.T_STAFF) damage *= 1.4;
        damage = lightningTypeDamageBonus(damage);
		if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
        if (monster.hasStatusEffect(StatusEffects.DragonWaterBreath)) damage *= 5;
        if (player.perkv1(IMutationsLib.RaijuCathodeIM) >= 2) damage *= 1.20;
        if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 1) damage *= 1.1;
        if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) damage *= 1.2;
        if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) damage *= 1.3;
        if (player.hasPerk(PerkLib.IceQueenGown)) damage *= 2;
        if (player.hasPerk(PerkLib.WalpurgisIzaliaRobe)) damage = damage / 100;
		damage *= EyesOfTheHunterDamageBonus();
        if (damage == 0) MSGControllForEvasion = true;
        if (monster.HP - damage <= monster.minHP()) {
            /* No monsters use this perk, so it's been removed for now
		if(monster.hasPerk(PerkLib.LastStrike)) doNext(monster.perk(monster.findPerk(PerkLib.LastStrike)).value1);
		else doNext(endHpVictory);
		*/
            doNext(endHpVictory);
        }
        // Uma's Massage Bonuses
        var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
        if (sac) {
            if (sac.value1 == UmasShop.MASSAGE_POWER) {
                damage *= sac.value2;
            }
        }
        damage = Math.round(damage);
        if (damage < 0) damage = 1;
        if (apply) {
            damage = monster.doLightningDamageBefore(damage);
            if(damage<=0){
                return 0;
            }
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxOverWrath()) monster.wrath = monster.maxOverWrath();
        }
        if (display) CommasForDigits(damage, false, "", "lightning");
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doDarknessDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
        damage = doElementalDamageMultiplier(damage);
		if (!ignoreDR) damage *= (monster.damageMagicalPercent() / 100);
        if (player.weapon == weapons.A_STAFF) damage *= 1.4;
        damage = darknessTypeDamageBonus(damage);
		if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
        if (player.hasPerk(PerkLib.WalpurgisIzaliaRobe)) damage *= 2;
        if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
        if (player.hasPerk(PerkLib.IceQueenGown)) damage = damage / 100;
        if (player.shieldName == "Nekonomicon") damage *= 2;
		damage *= EyesOfTheHunterDamageBonus();
        if (damage == 0) MSGControllForEvasion = true;
        if (monster.HP - damage <= monster.minHP()) {
            doNext(endHpVictory);
        }
        // Uma's Massage Bonuses
        var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
        if (sac) {
            if (sac.value1 == UmasShop.MASSAGE_POWER) {
                damage *= sac.value2;
            }
        }
        damage = Math.round(damage);
        if (damage < 0) damage = 1;
        if (apply) {
            damage = monster.doDarknessDamageBefore(damage);
            if(damage<=0){
                return 0;
            }
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxOverWrath()) monster.wrath = monster.maxOverWrath();
        }
        if (display) CommasForDigits(damage, false, "", "dark");
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doPoisonDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
        damage = doElementalDamageMultiplier(damage);
		if (!ignoreDR) damage *= (monster.damageMagicalPercent() / 100);
        damage = poisonTypeDamageBonus(damage);
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
		damage *= EyesOfTheHunterDamageBonus();
        if (damage == 0) MSGControllForEvasion = true;
        if (monster.HP - damage <= monster.minHP()) {
            /* No monsters use this perk, so it's been removed for now
		if(monster.hasPerk(PerkLib.LastStrike)) doNext(monster.perk(monster.findPerk(PerkLib.LastStrike)).value1);
		else doNext(endHpVictory);
		*/
            doNext(endHpVictory);
        }
        // Uma's Massage Bonuses
        var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
        if (sac) {
            if (sac.value1 == UmasShop.MASSAGE_POWER) {
                damage *= sac.value2;
            }
        }
        damage = Math.round(damage);
        if (damage < 0) damage = 1;
        if (apply) {
            damage = monster.doPoisonDamageBefore(damage);
            if(damage<=0){
                return 0;
            }
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxOverWrath()) monster.wrath = monster.maxOverWrath();
        }
        if (display) CommasForDigits(damage, false, "", "poison");
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doWindDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
        damage = doElementalDamageMultiplier(damage);
		if (!ignoreDR) damage *= (monster.damageMagicalPercent() / 100);
        damage = windTypeDamageBonus(damage);
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
		damage *= EyesOfTheHunterDamageBonus();
        if (damage == 0) MSGControllForEvasion = true;
        if (monster.HP - damage <= monster.minHP()) {
            doNext(endHpVictory);
        }
        // Uma's Massage Bonuses
        var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
        if (sac) {
            if (sac.value1 == UmasShop.MASSAGE_POWER) {
                damage *= sac.value2;
            }
        }
        damage = Math.round(damage);
        if (damage < 0) damage = 1;
        if (apply) {
            damage = monster.doWindDamageBefore(damage);
            if(damage<=0){
                return 0;
            }
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxOverWrath()) monster.wrath = monster.maxOverWrath();
        }
        if (display) CommasForDigits(damage, false, "", "wind");
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doWaterDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
        damage = doElementalDamageMultiplier(damage);
		if (!ignoreDR) damage *= (monster.damageMagicalPercent() / 100);
        damage = waterTypeDamageBonus(damage);
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
		damage *= EyesOfTheHunterDamageBonus();
        if (damage == 0) MSGControllForEvasion = true;
        if (monster.HP - damage <= monster.minHP()) {
            /* No monsters use this perk, so it's been removed for now
		if(monster.hasPerk(PerkLib.LastStrike)) doNext(monster.perk(monster.findPerk(PerkLib.LastStrike)).value1);
		else doNext(endHpVictory);
		*/
            doNext(endHpVictory);
        }
        // Uma's Massage Bonuses
        var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
        if (sac) {
            if (sac.value1 == UmasShop.MASSAGE_POWER) {
                damage *= sac.value2;
            }
        }
        damage = Math.round(damage);
        if (damage < 0) damage = 1;
        if (apply) {
            damage = monster.doWaterDamageBefore(damage);
            if(damage<=0){
                return 0;
            }
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxOverWrath()) monster.wrath = monster.maxOverWrath();
        }
        if (display) CommasForDigits(damage, false, "", "water");
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doEarthDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
        damage = doElementalDamageMultiplier(damage);
		if (!ignoreDR) damage *= (monster.damageMagicalPercent() / 100);
        damage = earthTypeDamageBonus(damage);
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
		damage *= EyesOfTheHunterDamageBonus();
        if (damage == 0) MSGControllForEvasion = true;
        if (monster.HP - damage <= monster.minHP()) {
            doNext(endHpVictory);
        }
        // Uma's Massage Bonuses
        var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
        if (sac) {
            if (sac.value1 == UmasShop.MASSAGE_POWER) {
                damage *= sac.value2;
            }
        }
        damage = Math.round(damage);
        if (damage < 0) damage = 1;
        if (apply) {
            damage = monster.doEarthDamageBefore(damage);
            if(damage<=0){
                return 0;
            }
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxOverWrath()) monster.wrath = monster.maxOverWrath();
        }
        if (display) CommasForDigits(damage, false, "", "earth");
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doAcidDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
        damage = doElementalDamageMultiplier(damage);
		if (!ignoreDR) damage *= (monster.damageMagicalPercent() / 100);
        damage = acidTypeDamageBonus(damage);
		if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
		damage *= EyesOfTheHunterDamageBonus();
        if (damage == 0) MSGControllForEvasion = true;
        if (monster.HP - damage <= monster.minHP()) {
            doNext(endHpVictory);
        }
        // Uma's Massage Bonuses
        var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
        if (sac) {
            if (sac.value1 == UmasShop.MASSAGE_POWER) {
                damage *= sac.value2;
            }
        }
        damage = Math.round(damage);
        if (damage < 0) damage = 1;
        if (apply) {
            damage = monster.doAcidDamageBefore(damage);
            if(damage<=0){
                return 0;
            }
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxOverWrath()) monster.wrath = monster.maxOverWrath();
        }
        if (display) CommasForDigits(damage, false, "", "acid");
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }
	
	public function doPlasmaDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		var split:Number = (damage * 0.5);
		var fdamage:Number = Math.round(split * fireDamageBoostedByDao());
		var ldamage:Number = Math.round(split * lightningDamageBoostedByDao());
		doFireDamage(fdamage, apply, display, ignoreDR);
		doLightningDamage(ldamage, apply, display, ignoreDR);
		return split;
	}

    public static const USEMANA_NORMAL:int = 0;
    public static const USEMANA_MAGIC:int = 1;
    public static const USEMANA_GREY:int = 2;
    public static const USEMANA_MAGIC_NOBM:int = 3;
    public static const USEMANA_GREY_NOBM:int = 4;
    public static const USEMANA_WHITE:int = 5;
    public static const USEMANA_BLACK:int = 6;
    public static const USEMANA_WHITE_NOBM:int = 7;
    public static const USEMANA_BLACK_NOBM:int = 8;
    public static const USEMANA_MAGIC_HEAL:int = 9;
    public static const USEMANA_WHITE_HEAL:int = 10;
    public static const USEMANA_BLACK_HEAL:int = 11;
    public static const USEMANA_GREEN:int = 12;

    public function finalSpellCost(base:Number, type:int = USEMANA_NORMAL):Number {
        switch (type) {
            case USEMANA_MAGIC:
            case USEMANA_MAGIC_NOBM:
                return spellCost(base);
            case USEMANA_GREY:
            case USEMANA_GREY_NOBM:
                return spellCostGrey(base);
            case USEMANA_WHITE:
            case USEMANA_WHITE_NOBM:
                return spellCostWhite(base);
            case USEMANA_BLACK:
            case USEMANA_BLACK_NOBM:
                return spellCostBlack(base);
            case USEMANA_MAGIC_HEAL:
                return healCost(base);
            case USEMANA_WHITE_HEAL:
                return healCostWhite(base);
            case USEMANA_BLACK_HEAL:
                return healCostBlack(base);
            case USEMANA_GREEN:
                return spellCostGreen(base);
            default: // including normal
                return base;
        }
    }

    public function darkRitualCheckDamage():void {
        if (player.hasStatusEffect(StatusEffects.DarkRitual)) HPChange(-Math.round(player.maxHP() * 0.1), false);
    }

    //Modify mana (mod>0 - subtract, mod<0 - regen)
    public function useManaImpl(mod:Number, type:int = USEMANA_NORMAL):void {
        mod = finalSpellCost(mod, type); //Spell reductions - spells do this for themselves!
        if (mod < 0) mod *= manaRecoveryMultiplier();
        EngineCore.ManaChange(-mod);
    }

    public function fatigueCost(mod:Number, type:Number = USEFATG_NORMAL):Number {
        switch (type) {
                //Spell reductions
            case USEFATG_MAGIC:
            case USEFATG_MAGIC_NOBM:
                return spellCost(mod);
            case USEFATG_WHITE:
            case USEFATG_WHITE_NOBM:
                return spellCostWhite(mod);
            case USEFATG_BLACK:
            case USEFATG_BLACK_NOBM:
                return spellCostBlack(mod);
            case USEFATG_PHYSICAL:
                return physicalCost(mod);
            case USEFATG_BOW:
                return bowCost(mod);
            default:
                return mod;
        }
    }

//Modify fatigue (mod>0 - subtract, mod<0 - regen)//types:
    public function fatigueImpl(mod:Number, type:Number = USEFATG_NORMAL):void {
        mod = fatigueCost(mod, type);
        if (type === USEFATG_MAGIC || type === USEFATG_WHITE || type === USEFATG_BLACK) {
            //Blood mages use HP for spells
            if (player.hasPerk(PerkLib.BloodMage)) {
                player.takePhysDamage(mod);
                statScreenRefresh();
                return;
            }
        }
        if (player.fatigue >= player.maxOverFatigue() && mod > 0) return;
        if (player.fatigue <= 0 && mod < 0) return;
        //Fatigue restoration buffs!
        if (mod < 0) {
            mod *= fatigueRecoveryMultiplier();
        }
        if (mod > 0 && (player.hasStatusEffect(StatusEffects.AlterBindScroll3) || player.hasStatusEffect(StatusEffects.AlterBindScroll5) || player.hasPerk(PerkLib.Undeath))) return;
		else player.fatigue += mod;
        if (mod < 0) {
            mainView.statsView.showStatUp('fatigue');
        }
        if (mod > 0) {
            mainView.statsView.showStatDown('fatigue');
        }
        dynStats("lus", 0, "scale", false); //Force display fatigue up/down by invoking zero lust change.
        if (player.fatigue > player.maxOverFatigue()) player.fatigue = player.maxOverFatigue();
        if (player.fatigue < 0) player.fatigue = 0;
        statScreenRefresh();
    }

    //ENEMYAI!
    public function enemyAIImpl():void {
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxOverLust()) {
            doNext(endLustVictory);
            return;
        }
        monster.doAI();
        if (player.statStore.hasBuff("ScarletSpiritCharge")) HPChange(-Math.round(player.maxHP()*0.05), false);
        if (player.statStore.hasBuff("TranceTransformation")) player.soulforce -= 50;
        if (player.statStore.hasBuff("CrinosShape")) player.wrath -= mspecials.crinosshapeCost();
        if (player.statStore.hasBuff("AsuraForm")) player.wrath -= asuraformCost();
		if (player.statStore.hasBuff("FoxflamePelt")) {
			var soulforcecost:int = 50 * soulskillCost() * soulskillcostmulti();
			player.soulforce -= soulforcecost;
			useMana((100 * combat.mspecials.kitsuneskill2Cost()), Combat.USEMANA_MAGIC_NOBM);
		}
		if (player.statStore.hasBuff("SwordIntentAura")) {
			var soulforcecost2:int = 10 * soulskillCost() * soulskillcostmulti();
			player.soulforce -= soulforcecost2;
			fatigue(physicalCost(10));
		}
        combatRoundOver();
    }

    public function finishCombat():void {
        var hpVictory:Boolean = monster.HP <= monster.minHP();//monster.HP < 1
        clearOutput();
        if (hpVictory) {
            outputText("You defeat [themonster].\n");
        } else {
            outputText("You smile as [themonster] collapses and begins masturbating feverishly.");
        }
        cleanupAfterCombat();
    }

    public function dropItem(monster:Monster, nextFunc:Function = null):void {
        if (nextFunc == null) nextFunc = explorer.done;
        if (monster.hasStatusEffect(StatusEffects.NoLoot)) {
            return;
        }
        if (player.hasStatusEffect(StatusEffects.SoulArena)) {
            player.removeStatusEffect(StatusEffects.SoulArena);
            return;
        }
        var itype:ItemType;
        //Bonus loot overrides others
        if (flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] != "") {
            itype = ItemType.lookupItem(flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID]);
            flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = "";
        } else {
            itype = monster.dropLoot();
        }
        if (itype != null) {
            itype = monster.handleAwardItemText(itype); //Each monster can now override the default award text
        }
        if (itype != null) {
            if (inDungeon)
                inventory.takeItem(itype, playerMenu);
            else inventory.takeItem(itype, nextFunc);
        }
    }

    public function awardPlayer(nextFunc:Function = null):void {
        if (nextFunc == null) nextFunc = explorer.done;
        if (player.countCockSocks("gilded") > 0) {
            //trace( "awardPlayer found MidasCock. Gems bumped from: " + monster.gems );
            var bonusGems:int = monster.gems * 0.15 + 5 * player.countCockSocks("gilded"); // int so AS rounds to whole numbers
            monster.gems += bonusGems;
            //trace( "to: " + monster.gems )
        }
        if (player.hasPerk(PerkLib.HistoryFortune) || player.hasPerk(PerkLib.PastLifeFortune)) {
            var bonusGems2:int = monster.gems * 0.15;
            if (player.hasPerk(PerkLib.Lucky)) bonusGems2 += monster.gems * 0.15;
            if (player.hasPerk(PerkLib.ExtremelyLucky)) bonusGems2 += monster.gems * 0.15;
            if (player.hasPerk(PerkLib.MoneyFinder)) bonusGems2 += monster.gems * 0.15;
            if (player.hasPerk(PerkLib.Collector)) bonusGems2 += monster.gems * 0.15;
            if (player.hasPerk(PerkLib.Hoarder)) bonusGems2 += monster.gems * 0.15;
            if (player.hasPerk(PerkLib.BlessedByLadyGodiva)) bonusGems2 += monster.gems * 0.15;
            if (player.hasPerk(PerkLib.LadyGodivasFavoriteChild)) bonusGems2 += monster.gems * 0.15;
            bonusGems2 = Math.round(bonusGems2);
            monster.gems += bonusGems2;
        }
        if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) {
            var bonusGems3:int = (monster.gems * 0.04) * (player.teaseLevel * 0.2);
            if (monster.lust >= monster.maxOverLust()) monster.gems += bonusGems3;
        }
        if (player.hasPerk(PerkLib.AscensionFortune)) {
            monster.gems *= 1 + (player.perkv1(PerkLib.AscensionFortune) * 0.2);
            monster.gems = Math.round(monster.gems);
        }
        if (player.hasPerk(PerkLib.Greedy)){
            monster.gems *= 2;
            monster.gems = Math.round(monster.gems);
        }
        if (player.hasPerk(PerkLib.TravelingMerchantOutfit)){
            monster.gems *= 2;
            monster.gems = Math.round(monster.gems);
        }
        if (!monster.hasPerk(PerkLib.NoExpGained)) monster.handleAwardText(); //Each monster can now override the default award text
        if (!inDungeon && !inRoomedDungeon) { //Not in dungeons
            if (nextFunc != null) doNext(nextFunc);
            else doNext(playerMenu);
        } else {
            if (nextFunc != null) doNext(nextFunc);
            else doNext(playerMenu);
        }
        dropItem(monster, nextFunc);
        inCombat = false;
        if (monster.gems <= 0) monster.gems = 0;
        if (((player.gems + monster.gems) >= 1000000000 || (player.gems + monster.gems) < 0) && monster.gems > 0) player.gems = 1000000000;
        else player.gems += monster.gems;
        if (monster.XP <= 0) monster.XP = 0;
        if (!monster.hasPerk(PerkLib.NoExpGained)) player.XP += monster.XP;
        mainView.statsView.showStatUp('xp');
        dynStats("lust", 0, "scale", false); //Forces up arrow.
    }

//Update combat status effects
    private function combatStatusesUpdate():void {
        //Reset menuloc
        //This is now automatic - newRound arg defaults to true:	menuLoc = 0;
        hideUpDown();
        if (player.hasStatusEffect(StatusEffects.MinotaurKingMusk)) {
            dynStats("lus", 3);
        }
        if (player.hasStatusEffect(StatusEffects.Sealed)) {
            //Countdown and remove as necessary
            if (player.statusEffectv1(StatusEffects.Sealed) > 0) {
                player.addStatusValue(StatusEffects.Sealed, 1, -1);
                if (player.statusEffectv1(StatusEffects.Sealed) <= 0) player.removeStatusEffect(StatusEffects.Sealed);
                else {
                    outputText("<b>One of your combat abilities is currently sealed by ");
                    if (monster is ChaosChimera || monster is LivingFailure) outputText("curse");
                    else outputText("magic");
                    outputText("!</b>\n\n");
                }
            }
        }
        if (player.hasStatusEffect(StatusEffects.Sealed2)) {
            //Countdown and remove as necessary
            if (player.statusEffectv1(StatusEffects.Sealed2) > 0) {
                player.addStatusValue(StatusEffects.Sealed2, 1, -1);
                if (player.statusEffectv1(StatusEffects.Sealed2) <= 0) player.removeStatusEffect(StatusEffects.Sealed2);
                else outputText("<b>One of your combat abilities is currently disabled as aftereffect of recent enemy attack!</b>\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.WhipSilence)) {
            player.addStatusValue(StatusEffects.WhipSilence, 1, -1);
            if (player.statusEffectv1(StatusEffects.WhipSilence) <= 0) {
                player.removeStatusEffect(StatusEffects.WhipSilence);
                outputText("<b>The constricting cords encircling your neck fall away, their flames guttering into nothingness. It seems even a Demon Queen’s magic has an expiration date.</b>\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.PigbysHands)) {
            dynStats("lus", 5);
        }
        if (player.hasStatusEffect(StatusEffects.TaintedMind)) {
            player.addStatusValue(StatusEffects.TaintedMind, 1, -1);
            if (player.statusEffectv1(StatusEffects.TaintedMind) <= 0) {
                player.removeStatusEffect(StatusEffects.TaintedMind);
                outputText("Some of the drider’s magic fades, and you heft your [weapon] with a grin. No more of this ‘fight like a demon’ crap!\n\n");
            } else {
                outputText("There is a thin film of filth layered upon your mind, latent and waiting. The drider said something about fighting like a demon. Is this supposed to interfere with your ability to fight?\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.PurpleHaze)) {
            player.addStatusValue(StatusEffects.PurpleHaze, 1, -1);
            if (player.statusEffectv1(StatusEffects.PurpleHaze) <= 0) {
                player.removeStatusEffect(StatusEffects.PurpleHaze);
                player.removeStatusEffect(StatusEffects.Blind);
                outputText("The swirling mists that once obscured your vision part, allowing you to see your foe once more! <b>You are no longer blinded!</b>\n\n");
            } else {
                outputText("Your vision is still clouded by swirling purple mists bearing erotic shapes. You are effectively blinded and a little turned on by the display.\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles)) {
            player.addStatusValue(StatusEffects.LethicesRapeTentacles, 1, -1);
            if (player.statusEffectv3(StatusEffects.LethicesRapeTentacles) != 0) {
                player.addStatusValue(StatusEffects.LethicesRapeTentacles, 2, 1);
                var tentaround:Number = player.statusEffectv2(StatusEffects.LethicesRapeTentacles);
                if (tentaround == 1) {
                    outputText("Taking advantage of your helpless state, the tentacles wind deeper under your [armor], caressing your [nipples] and coating your [butt] in slippery goo. One even seeks out your crotch, none-too-gently prodding around for weak points.\n\n");
                    player.takeLustDamage(5, true);
                } else if (tentaround == 2) {
                    outputText("Now that they’ve settled in, the tentacles go to work on your body, rudely molesting every sensitive place they can find.");
                    if (player.hasCock()) outputText(" They twirl and writhe around your [cocks].");
                    if (player.hasVagina()) outputText(" One flosses your nether-lips, rubbing slippery bumps maddenly against your [clit].");
                    outputText(" " + num2Text(player.totalNipples()) + " tendrils encircle your [nipples]");
                    if (player.hasFuckableNipples()) outputText(", threatening to slide inside them at a moment’s notice");
                    else {
                        outputText(", pinching and tugging them");
                        if (player.isLactating()) outputText(", squeezing out small jets of milk");
                    }
                    outputText(". Worst of all is the tentacle slithering between your buttcheeks. It keeps stopping to rub around the edge of your [asshole]. You really ought to break free...\n\n");
                    player.takeLustDamage(5, true);
                } else if (tentaround == 3) {
                    outputText("Another inky length rises up from the floor and slaps against your face, inexpertly attempting to thrust itself inside your mouth. Resenting its temerity, you steadfastly hold your lips closed and turn your head away. The corrupt magics powering this spell won’t let you get off so easily, though. The others redouble their efforts, inundating you with maddening pleasure. You can’t help but gasp and moan, giving the oiled feeler all the opening it needs to enter your maw.\n\n");
                    player.takeLustDamage(5, true);
                } else if (tentaround == 4) {
                    outputText("If you thought having one tentacle in your mouth was bad, then the two floating in front of you are potentially terrifying. Unfortunately, they turn out to be mere distractions. The tendril plying your buns rears back and stabs inside, splitting your sphincter");
                    if (player.hasVagina()) {
                        outputText(" while its brother simultaneously pierces your tender folds, rapaciously double-penetrating you");
                        if (player.hasVirginVagina()) outputText(" <b>You've come all this way only to lose your virginity to these things!</b>");
                    }
                    outputText(".");
                    if (player.hasFuckableNipples()) outputText(" Your [nipples] are similarly entered.");
                    if (player.hasCock()) outputText(" And [eachCock] is suddenly coated in slimy, extraplanar oil and pumped with rapid, sure strokes.");
                    outputText(" There’s too much. If you don’t break free, you’re going to wind up losing to a simple spell!\n\n");
                    player.takeLustDamage(10, true);
                } else {
                    outputText("You’ve really fucked up now. An entire throne room full of demons is watching a bunch of summoned tentacles rape you in every hole, bouncing your body back and forth with the force of their thrusts, repeatedly spilling their corruptive payloads into your receptive holes. The worst part is");
                    if (player.cor >= 50) outputText(" how much of a bitch it makes you look like... and how good it feels to be Lethice’s bitch.");
                    else outputText(" how dirty it makes you feel... and how good it feels to be dirty.\n\n");
                    dynStats("lus", 10, "cor", 1);
                }
            } else {
                outputText("The tentacles grab at you again!");
                if (player.canFly()) outputText(" No matter how they strain, they can’t reach you.\n\n");
                else if (player.getEvasionRoll()) outputText(" You twist out of their slick, bizarrely sensuous grasp for now.\n\n");
                else {
                    outputText(" Damn, they got you! They yank your arms and [legs] taut, holding you helpless in the air for their brothers to further violate. You can already feel a few oily tendrils sneaking under your [armor].\n\n");
                    player.changeStatusValue(StatusEffects.LethicesRapeTentacles, 3, 1);
                    player.takeLustDamage(5, true);
                }
            }
            if (player.statusEffectv1(StatusEffects.LethicesRapeTentacles) <= 0) {
                if (player.statusEffectv3(StatusEffects.LethicesRapeTentacles) != 0) {
                    outputText("The tentacles in front of you suddenly pop like balloons of black smoke, leaving a greasy mist in their wake. A breeze from nowhere dissipates the remnants of the rapacious tendrils, their magic expended.\n\n");
                } else {
                    outputText("The tentacles holding you abruptly let go, dropping you to the ground. Climbing up, you look around in alarm, but the tendrils have faded into puffs of black smoke. A breeze from nowhere blows them away, their magic expended.\n\n");
                }
                player.removeStatusEffect(StatusEffects.LethicesRapeTentacles);
            }
        }
        //Manage cumulative magic damage counter degradation
        for each (var perkObj:Object in CombatMagic.magicCounterPerks) {
            if (player.hasStatusEffect(perkObj.counter)) {
            if (player.statusEffectv1(perkObj.counter) > 0 && player.statusEffectv2(perkObj.counter) == 0 && player.statusEffectv3(perkObj.counter) == 0) {
				if (player.hasPerk(perkObj.tier3) || player.hasPerk(perkObj.tier4)) player.addStatusValue(perkObj.counter, 1, -4);
				else if (player.hasPerk(perkObj.tier2)) player.addStatusValue(perkObj.counter, 1, -6);
				player.addStatusValue(perkObj.counter, 1, -8);
			}
			if (player.statusEffectv2(perkObj.counter) > 0) player.addStatusValue(perkObj.counter, 2, -1);
        }
        }
        
		if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 3 && player.HP < 1 && !player.hasStatusEffect(StatusEffects.RegenSurge)) {
			if (player.perkv1(IMutationsLib.FerasBirthrightIM) == 3) player.createStatusEffect(StatusEffects.RegenSurge,3,0,0,0);
			if (player.perkv1(IMutationsLib.FerasBirthrightIM) == 4) player.createStatusEffect(StatusEffects.RegenSurge,4,0,0,0);
		}
        monster.combatRoundUpdate();
		// Advance abilities
        for each (var ability:CombatAbility in CombatAbility.Registry) {
            if (ability.isActive()) {
                ability.advance(true);
            }
        }
        //[Silence warning]
        if (player.hasStatusEffect(StatusEffects.ThroatPunch)) {
            player.addStatusValue(StatusEffects.ThroatPunch, 1, -1);
            if (player.statusEffectv1(StatusEffects.ThroatPunch) >= 0) outputText("Thanks to Isabella's wind-pipe crushing hit, you're having trouble breathing and are <b>unable to cast spells as a consequence.</b>\n\n");
            else {
                outputText("Your wind-pipe recovers from Isabella's brutal hit.  You'll be able to focus to cast spells again!\n\n");
                player.removeStatusEffect(StatusEffects.ThroatPunch);
            }
        }
        if (player.hasStatusEffect(StatusEffects.GooArmorSilence)) {
            if (player.statusEffectv1(StatusEffects.GooArmorSilence) >= 2 || rand(20) + 1 + player.str / 10 >= 15) {
                //if passing str check, output at beginning of turn
                outputText("<b>The sticky slop covering your mouth pulls away reluctantly, taking more force than you would expect, but you've managed to free your mouth enough to speak!</b>\n\n");
                player.removeStatusEffect(StatusEffects.GooArmorSilence);
            } else {
                outputText("<b>Your mouth is obstructed by sticky goo!  You are silenced!</b>\n\n");
                player.addStatusValue(StatusEffects.GooArmorSilence, 1, 1);
            }
        }
		if (player.hasStatusEffect(StatusEffects.PiercingBlow)) {
            player.addStatusValue(StatusEffects.PiercingBlow, 1, -1);
            if (player.statusEffectv1(StatusEffects.PiercingBlow) < 0) player.removeStatusEffect(StatusEffects.PiercingBlow);
        }
        if (player.hasStatusEffect(StatusEffects.LustStones)) {
            //[When witches activate the stones for goo bodies]
            if (player.isGoo()) {
                outputText("<b>The stones start vibrating again, making your liquid body ripple with pleasure.  The witches snicker at the odd sight you are right now.\n\n</b>");
            }
            //[When witches activate the stones for solid bodies]
            else {
                outputText("<b>The smooth stones start vibrating again, sending another wave of teasing bliss throughout your body.  The witches snicker at you as you try to withstand their attack.\n\n</b>");
            }
            player.takeLustDamage(player.statusEffectv1(StatusEffects.LustStones) + 4, true);
        }
		if (player.hasStatusEffect(StatusEffects.GreenCovenant)) {
			outputText("<b>Your connection to corrupted flora makes you increasingly lustful.</b> ");
			player.takeLustDamage(Math.round(player.maxLust() * 0.05), true);
			outputText("\n\n");
		}
		if (player.hasStatusEffect(StatusEffects.LustTransferance)) player.takeLustDamage(player.statusEffectv1(StatusEffects.LustTransferance) + 4, true);
        if (player.hasStatusEffect(StatusEffects.WebSilence)) {
            if (player.statusEffectv1(StatusEffects.WebSilence) >= 2 || rand(20) + 1 + player.str / 10 >= 15) {
                outputText("You rip off the webbing that covers your mouth with a cry of pain, finally able to breathe normally again!  Now you can cast spells!\n\n");
                player.removeStatusEffect(StatusEffects.WebSilence);
            } else {
                outputText("<b>Your mouth and nose are obstructed by sticky webbing, making it difficult to breathe and impossible to focus on casting spells.  You try to pull it off, but it just won't work!</b>\n\n");
                player.addStatusValue(StatusEffects.WebSilence, 1, 1);
            }
        }
        if (player.hasStatusEffect(StatusEffects.HolliConstrict)) {
            outputText("<b>You're tangled up in Holli's verdant limbs!  All you can do is try to struggle free...</b>\n\n");
        }
        if (player.hasStatusEffect(StatusEffects.UBERWEB)) outputText("<b>You're pinned under a pile of webbing!  You should probably struggle out of it and get back in the fight!</b>\n\n");
        if (player.playerIsBlinded() && !monster.hasStatusEffect(StatusEffects.Sandstorm) && !player.hasStatusEffect(StatusEffects.PurpleHaze)) {
            if (player.hasStatusEffect(StatusEffects.SheilaOil)) {
                if (player.statusEffectv1(StatusEffects.Blind) <= 0) {
                    outputText("<b>You finish wiping the demon's tainted oils away from your eyes; though the smell lingers, you can at least see.  [sheilaname] actually seems happy to once again be under your gaze.</b>\n\n");
                    player.removeStatusEffect(StatusEffects.Blind);
                } else {
                    outputText("<b>You scrub at the oily secretion with the back of your hand and wipe some of it away, but only smear the remainder out more thinly.  You can hear the demon giggling at your discomfort.</b>\n\n");
                    player.addStatusValue(StatusEffects.Blind, 1, -1);
                }
            } else {
                //Remove blind if countdown to 0
                if (player.statusEffectv1(StatusEffects.Blind) == 0) {
                    player.removeStatusEffect(StatusEffects.Blind);
                    //Alert PC that blind is gone if no more stacks are there.
                    if (!player.hasStatusEffect(StatusEffects.Blind)) {
                        if (monster is Lethice && (monster as Lethice).fightPhase == 2) {
                            outputText("<b>You finally blink away the last of the demonic spooge from your eyes!</b>\n\n");
                        } else {
                            outputText("<b>Your eyes have cleared and you are no longer blind!</b>\n\n");
                        }
                    } else outputText("<b>You are blind, and many physical attacks will miss much more often.</b>\n\n");
                } else {
                    player.addStatusValue(StatusEffects.Blind, 1, -1);
                    outputText("<b>You are blind, and many physical attacks will miss much more often.</b>\n\n");
                }
            }
        }
        //Basilisk compulsion
        if (player.hasStatusEffect(StatusEffects.BasiliskCompulsion)) {
            player.addCombatBuff('spe', -15,"Basilisk Gaze","BasiliskGaze");
            //Continuing effect text:
            outputText("<b>You still feel the spell of those grey eyes, making your movements slow and difficult, the remembered words tempting you to look into its eyes again. You need to finish this fight as fast as your heavy limbs will allow.</b>\n\n");
            flags[kFLAGS.BASILISK_RESISTANCE_TRACKER]++;
        }
        if (player.hasStatusEffect(StatusEffects.IzmaBleed)) {
            player.addStatusValue(StatusEffects.IzmaBleed, 1, -1);
            if (player.statusEffectv1(StatusEffects.IzmaBleed) <= 0 || player.hasPerk(PerkLib.KingOfTheJungle)) {
                player.removeStatusEffect(StatusEffects.IzmaBleed);
                outputText("<b>You sigh with relief; your bleeding has slowed considerably.</b>\n\n");
            }
            //Bleed effect:
            else {
                var bleed:Number = (4 + rand(7)) / 100;
				if (player.statStore.hasBuff("Crossed Holy Band")) bleed *= 0.5;
                bleed *= player.HP;
                bleed = player.takePhysDamage(bleed);
                outputText("<b>You gasp and wince in pain, feeling fresh blood pump from your wounds.</b>"
                    + "");
                CommasForDigits(bleed);
                outputText("[pg]");
            }
        }
        if (player.hasStatusEffect(StatusEffects.Hemorrhage)) {
            player.addStatusValue(StatusEffects.Hemorrhage, 1, -1);
            if (player.statusEffectv1(StatusEffects.Hemorrhage) <= 0 || player.hasPerk(PerkLib.KingOfTheJungle)) {
                player.removeStatusEffect(StatusEffects.Hemorrhage);
                outputText("<b>You sigh with relief; your hemorrhage has slowed considerably.</b>\n\n");
            }
            //Hemorrhage effect:
            else {
                var hemorrhage:Number = 0;
                hemorrhage += player.maxHP() * player.statusEffectv2(StatusEffects.Hemorrhage);
				if (player.statStore.hasBuff("Crossed Holy Band")) hemorrhage *= 0.5;
                hemorrhage = player.takePhysDamage(hemorrhage);
                outputText("<b>You gasp and wince in pain, feeling fresh blood pump from your wounds. ([font-damage]" + hemorrhage + "[/font])</b>\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.LockingCurse)) {
            var mummyservants:Number = 0;
            mummyservants += player.maxHP() * player.statusEffectv2(StatusEffects.LockingCurse);
			if (player.statStore.hasBuff("Crossed Holy Band")) mummyservants *= 0.5;
            mummyservants = player.takePhysDamage(mummyservants);
			outputText("<b>The mummies swarm you, punching and kicking you from all sides with unhinged strength. ([font-damage]" + mummyservants + "[/font])</b>\n\n");
        }
        if (player.hasStatusEffect(StatusEffects.BurnDoT)) {
            player.addStatusValue(StatusEffects.BurnDoT, 1, -1);
            if (player.statusEffectv1(StatusEffects.BurnDoT) <= 0 || player.hasPerk(PerkLib.KingOfTheJungle)) {
                player.removeStatusEffect(StatusEffects.BurnDoT);
                outputText("<b>You sigh with relief; fire has stopped searing your wounds.</b>\n\n");
            }
            //Deal damage if still wounded.
            else {
                var burndot:Number = 0;
                burndot += player.maxHP() * player.statusEffectv2(StatusEffects.BurnDoT);
				if (player.statStore.hasBuff("Crossed Holy Band")) burndot *= 0.5;
                burndot = player.takeFireDamage(burndot);
                outputText("<b>You gasp and wince in pain, feeling fire still searing your wounds. ([font-damage]" + burndot + "[/font])</b>\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.Polymorphed)) {
            player.addStatusValue(StatusEffects.Polymorphed, 1, -1);
            if (player.statusEffectv1(StatusEffects.Polymorphed) <= 0) {
                player.removeStatusEffect(StatusEffects.Polymorphed);
                outputText("<b>You finally manage to break free from the spell, regaining your true form.</b>\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.Fear)) {
            player.addStatusValue(StatusEffects.Fear, 1, -1);
            if (player.statusEffectv1(StatusEffects.Fear) <= 0) {
                player.removeStatusEffect(StatusEffects.Fear);
                outputText("<b>You finally manage to shake off the fear.</b>\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.Disarmed)) {
            player.addStatusValue(StatusEffects.Disarmed, 1, -1);
            if (player.statusEffectv1(StatusEffects.Disarmed) <= 0) {
                player.removeStatusEffect(StatusEffects.Disarmed);
                if (player.weapon.isNothing) {
                    player.setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
                } else {
                    flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID];
                }
                outputText("You manage to grab your weapon back!\n\n");
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = 0;
            }
        }
		if (player.hasStatusEffect(StatusEffects.ConstantHeatConditions) && !player.hasPerk(PerkLib.FireAffinity) && !player.hasPerk(PerkLib.AffinityIgnis)) SceneLib.volcanicCrag.ConstantHeatConditionsTick();
		if (player.hasStatusEffect(StatusEffects.SubZeroConditions) && !player.hasPerk(PerkLib.ColdAffinity)) SceneLib.glacialRift.SubZeroConditionsTick();
        if (monster is Incels) (monster as Incels).DraftSupportCheck();
        if (player.hasStatusEffect(StatusEffects.UnderwaterOutOfAir)) {
            var deoxigen:Number = 0;
            deoxigen += (player.maxHP() * 0.05);
            deoxigen = player.takePhysDamage(deoxigen);
            outputText("<b>You are running out of oxygen. You need to finish this fight and fast before you lose consciousness. <b>([font-damage]" + deoxigen + "[/font])</b></b>\n\n");
        }
		if (player.hasStatusEffect(StatusEffects.UnderwaterAndIgnis)) {
			var ignishurt:Number = 0;
            ignishurt += (player.maxHP() * 0.05);
            ignishurt = player.takeWaterDamage(ignishurt);
            outputText("<b>Your entire body is wracked with pain, steam curling from where the water touches your form. Maybe submerging your fiery body in water was a bad idea. <b>([font-damage]" + ignishurt + "[/font])</b></b>\n\n");
		}
        if (player.hasStatusEffect(StatusEffects.HeroBane)) {
            player.addStatusValue(StatusEffects.HeroBane, 1, -1);
            if (player.statusEffectv1(StatusEffects.HeroBane) <= 0) {
                player.removeStatusEffect(StatusEffects.HeroBane);
                outputText("<b>You feel your body lighten as the curse linking your vitality to that of [themonster] ends.</b>\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.AcidSlap)) {
			if (player.hasPerk(PerkLib.KingOfTheJungle)) player.removeStatusEffect(StatusEffects.AcidSlap);
			else {
				var slap:Number = 3 + (player.maxHP() * 0.02);
				if (player.statStore.hasBuff("Crossed Holy Band")) slap *= 0.5;
				slap = player.takeAcidDamage(slap);
				outputText("<b>Your muscles twitch in agony as the acid keeps burning you. <b>([font-damage]" + slap + "[/font])</b></b>\n\n");
			}
        }
        if (monster.hasStatusEffect(StatusEffects.AuraOfMadness) && !player.hasPerk(PerkLib.Insanity) && !player.hasStatusEffect(StatusEffects.AlterBindScroll5)) {
			if (player.hasPerk(PerkLib.ArigeanKnowledge)) {
				var laugh:Number = rand(5);
				switch (laugh) {
					case 0:
						outputText("\"<i>He… hehe… AhahaHAHA!</i>\"\n\n");
						break;
					case 1:
						outputText("\"<i>Ahaha… it stings so good!</i>\"\n\n");
						break;
					case 2:
						outputText("\"<i>Hahaha… you're going to have to try MUCH harder than that, whelp!</i>\"\n\n");
						break;
					case 3:
						outputText("\"<i>An bhfuil eagla ort fós, Cur!?</i>\"\n\n");
						break;
					case 4:
						outputText("\"<i>AHAHAHA… is that fear I smell, mo chreach?</i>\"\n\n");
						break;
				}
			}
			else {
				player.addCurse("int.mult", monster.statusEffectv1(StatusEffects.AuraOfMadness)/100,3);//non bosses have it 5
				player.addCurse("wis.mult", monster.statusEffectv2(StatusEffects.AuraOfMadness)/100,3);//bosses have it at 20
				outputText("<b>As the battle draws on you feel yourself slowly losing your grip on reality.</b>\n\n");
				if (player.inte <= 10 || player.wis <= 10) {
					doNext(endHpLoss);
					return;
				}
			}
        }
        //Apophis Unholy Aura
        if (player.isRaceCached(Races.APOPHIS) && monster.lustVuln > 0 && !monster.hasPerk(PerkLib.EnemyTrueAngel) && !flags[kFLAGS.DISABLE_AURAS]) {
            outputText("Your unholy aura seeps into [themonster], slowly and insidiously eroding its resiliance to your unholy charms.\n\n");
            monster.lustVuln += 0.10;
        }
        //Arousing Aura
        if (player.hasPerk(PerkLib.ArousingAura) && monster.lustVuln > 0 && player.cor >= 70 && !flags[kFLAGS.DISABLE_AURAS]) {
            if (monster.lust < (monster.maxLust() * 0.5)) outputText("Your aura seeps into [themonster] but does not have any visible effects just yet. ");
            else if (monster.lust < (monster.maxLust() * 0.6)) {
                if (!monster.plural) outputText("[Themonster] starts to squirm a little from your unholy presence. ");
                else outputText("[Themonster] start to squirm a little from your unholy presence. ");
            } else if (monster.lust < (monster.maxLust() * 0.75)) outputText("Your arousing aura seems to be visibly affecting [themonster], making [monster him] squirm uncomfortably. ");
            else if (monster.lust < (monster.maxLust() * 0.85)) {
                if (!monster.plural) outputText("[Themonster]'s skin colors red as [monster he] inadvertently basks in your presence. ");
                else outputText("[Themonster]' skin colors red as [monster he] inadvertently bask in your presence. ");
            } else {
                if (!monster.plural) outputText("The effects of your aura are quite pronounced on [themonster] as [monster he] begins to shake and steal glances at your body. ");
                else outputText("The effects of your aura are quite pronounced on [themonster] as [monster he] begin to shake and steal glances at your body. ");
            }

            var lustAADmg:Number = (scalingBonusLibido() * 0.5);
            lustAADmg = teases.teaseAuraLustDamageBonus(monster, lustAADmg);
            lustAADmg *= monster.lustVuln;
            lustAADmg = combat.fixPercentLust(lustAADmg);
            monster.teased(Math.round(lustAADmg), false);
            outputText("\n\n");
            if (player.hasPerk(PerkLib.EromancyMaster)) teaseXP(1 + bonusExpAfterSuccesfullTease());
        }
        //Alraune Nectar
        if (player.hasPerk(PerkLib.AlrauneNectar) && monster.lustVuln > 0 && !flags[kFLAGS.DISABLE_AURAS]) {
            if (monster.lust < (monster.maxLust() * 0.5)) outputText("The perfumed scent of your nectar messes with [themonster] but does not have any visible effects just yet. ");
                else if (monster.lust < (monster.maxLust() * 0.6)) {
                    if (!monster.plural) outputText("[Themonster] starts to squirm a little from your nectar scent. ");
                    else outputText("[Themonster] start to squirm a little from your nectar perfumed scent. ");
                } else if (monster.lust < (monster.maxLust() * 0.75)) outputText("The perfumed scent of your nectar seems to be visibly affecting [themonster], making [monster him] squirm uncomfortably. ");
                else if (monster.lust < (monster.maxLust() * 0.85)) {
                    if (!monster.plural) outputText("[Themonster]'s skin colors red as [monster he] inadvertently basks in your scent. ");
                    else outputText("[Themonster]' skin colors red as [monster he] inadvertently bask in your scent. ");
                } else {
                    if (!monster.plural) outputText("The effects of your perfumed scent are quite pronounced on [themonster] as [monster he] begins to shake and steal glances at your body. ");
                    else outputText("The effects of your perfumed scent are quite pronounced on [themonster] as [monster he] begin to shake and steal glances at your body. ");
            }

            var lustANDmg:Number = calcHerbalismPower()/2;
            lustANDmg = teases.teaseAuraLustDamageBonus(monster, lustANDmg);
            if (player.hasPerk(PerkLib.RacialParagon)) lustANDmg *= RacialParagonAbilityBoost();
            lustANDmg *= monster.lustVuln;
            lustANDmg = combat.fixPercentLust(lustANDmg);
            monster.teased(Math.round(lustANDmg), false);
            outputText("\n\n");
            if (player.hasPerk(PerkLib.EromancyMaster)) teaseXP(1 + bonusExpAfterSuccesfullTease());
        }
        //Perfume
        if (player.hasStatusEffect(StatusEffects.ArousalPotion) && monster.lustVuln > 0) {
            if (monster.lust < (monster.maxLust() * 0.5)) outputText("The perfume messes with [themonster] but does not have any visible effects just yet. ");
                else if (monster.lust < (monster.maxLust() * 0.6)) {
                    if (!monster.plural) outputText("[Themonster] starts to squirm a little from your nectar scent. ");
                    else outputText("[Themonster] start to squirm a little from your nectar perfumed scent. ");
                } else if (monster.lust < (monster.maxLust() * 0.75)) outputText("The perfume seems to be visibly affecting [themonster], making [monster him] squirm uncomfortably. ");
                else if (monster.lust < (monster.maxLust() * 0.85)) {
                    if (!monster.plural) outputText("[Themonster]'s skin colors red as [monster he] inadvertently basks in your perfume. ");
                    else outputText("[Themonster]' skin colors red as [monster he] inadvertently bask in your scent. ");
                } else {
                    if (!monster.plural) outputText("The effects of your perfume are quite pronounced on [themonster] as [monster he] begins to shake and steal glances at your body. ");
                    else outputText("The effects of your perfume are quite pronounced on [themonster] as [monster he] begin to shake and steal glances at your body. ");
            }

            var power:Number = player.statusEffectv1(StatusEffects.ArousalPotion);
            power = teases.teaseAuraLustDamageBonus(monster, power);
            power *= monster.lustVuln;
            monster.teased(Math.round(power), false);
            outputText("\n\n");
            if (player.hasPerk(PerkLib.EromancyMaster)) teaseXP(1 + bonusExpAfterSuccesfullTease());
        }
        //Unicorn and Bicorn aura
        //Unicorn
        if ((player.hasPerk(PerkLib.AuraOfPurity)|| Forgefather.purePearlEaten) && !flags[kFLAGS.DISABLE_AURAS]) {
            if (monster.cor > 20) {
                var damage:Number = scalingBonusIntelligence();
                //Determine if critical hit!
                var crit:Boolean = false;
                var critChance:int = 5;
                critChance += combatMagicalCritical();
                if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
                if (rand(100) < critChance) {
                    crit = true;
                    damage *= 1.75;
                }
                damage = magic.calcInfernoModImpl(damage, false);
                magic.maintainInfernoModImpl();
                damage *= 0.5;
                var SpellMultiplier:Number = 1;
                SpellMultiplier += spellMod() - 1;
                damage *= SpellMultiplier;
                damage = monsterPureDamageBonus(damage);
                var corruptionModifier:Number = ((100 - player.cor) / 50);
                if (corruptionModifier < 1) corruptionModifier = 1;
                if (player.perkv1(IMutationsLib.EclipticMindIM) >= 1) damage *= corruptionModifier;
                if (player.perkv1(IMutationsLib.EclipticMindIM) >= 2) damage *= corruptionModifier;
                if (player.perkv1(IMutationsLib.EclipticMindIM) >= 3) damage *= corruptionModifier;
                if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
                if (player.perkv1(IMutationsLib.EclipticMindIM) >= 2 && monster.cor > player.cor / 2) damage = Math.round(damage * 2);
                else if (player.perkv1(IMutationsLib.EclipticMindIM) >= 3 && monster.cor > player.cor / 2) damage = Math.round(damage * 3);
				damage *= fireDamageBoostedByDao();
                damage = Math.round(damage);
                damage = fixPercentDamage(damage);
                outputText("Your aura of purity burns [themonster] with holy fire for ");
                doFireDamage(damage, true, true);
                outputText(" damage!");
                if (crit) outputText(" <b>*Critical Hit!*</b>");
                outputText("\n\n");
            } else {
                outputText("Your opponent seems not to be affected by the cleansing flames of your aura of purity. Probably because [monster he] has no corruption within [monster his] body.\n\n");
            }
        }
        //Bicorn
        if ((player.hasPerk(PerkLib.AuraOfCorruption) && monster.lustVuln > 0 || Forgefather.lethiciteEaten) && !flags[kFLAGS.DISABLE_AURAS]) {
            var lustDmg:Number = ((scalingBonusIntelligence() * 0.30) + (scalingBonusLibido() * 0.30));
            lustDmg = teases.teaseAuraLustDamageBonus(monster, lustDmg);
            if (player.perkv1(IMutationsLib.EclipticMindIM) >= 1) lustDmg *= ((player.cor / 50 / 100)+1);
            if (player.perkv1(IMutationsLib.EclipticMindIM) >= 2) lustDmg *= ((player.cor / 50 / 100)+1);
            if (player.perkv1(IMutationsLib.EclipticMindIM) >= 3) lustDmg *= ((player.cor / 50 / 100)+1);
            if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= RacialParagonAbilityBoost();
            if (player.perkv1(IMutationsLib.EclipticMindIM) >= 2 && monster.cor < (player.cor / 2)) lustDmg = Math.round(lustDmg * 2);
            else if (player.perkv1(IMutationsLib.EclipticMindIM) >= 3 && monster.cor < (player.cor / 2)) lustDmg = Math.round(lustDmg * 3);
            outputText("[Themonster] slowly succumbs to [monster his] basest desires as your aura of corruption seeps through [monster him]. ");
            if (monster.cor < 100) outputText("Your victims purity is slowly becoming increasingly eroded by your seeping corruption. ");
            lustDmg *= monster.lustVuln;
            lustDmg = combat.fixPercentLust(lustDmg);
            monster.teased(Math.round(lustDmg), false);
            outputText("\n\n");
            if (player.hasPerk(PerkLib.EromancyMaster)) teaseXP(1 + bonusExpAfterSuccesfullTease());
        }
        //Alraune Pollen
        if (player.hasStatusEffect(StatusEffects.AlraunePollen) && monster.lustVuln > 0) {
            if (monster.lust < (monster.maxLust() * 0.5)) outputText("[Themonster] breathes in your pollen but does not have any visible effects yet. ");
            else if (monster.lust < (monster.maxLust() * 0.6)) {
                if (!monster.plural) outputText("[Themonster] start to squirm a little. Your pollen's starting to get to them. ");
                else outputText("[Themonster] starts to squirm a little from your pollen. ");
            } else if (monster.lust < (monster.maxLust() * 0.75)) outputText("Your pollen seems to be visibly affecting [themonster], making [monster him] squirm uncomfortably. ");
            else if (monster.lust < (monster.maxLust() * 0.85)) {
                if (!monster.plural) outputText("[Themonster]'s skin flushes red, blood in their cheeks as [monster he] inadvertently breathes in your pollen. ");
                else outputText("[Themonster]' skin blushes red as [monster he] inadvertently breathes in your pollen. ");
            } else {
                if (!monster.plural) outputText("The effects of your pollen are quite pronounced on [themonster] as [monster he] begin to shake, occasionally stealing glances at your body. ");
                else outputText("The effects of your pollen are quite pronounced on [themonster] as [monster he] begin to shake, stealing glances at your body. ");
            }
            var lustDmgA:Number = (scalingBonusLibido() * 0.5);
            lustDmgA = teases.teaseAuraLustDamageBonus(monster, lustDmgA);
            if (player.hasPerk(PerkLib.RacialParagon)) lustDmgA *= RacialParagonAbilityBoost();
            if (player.perkv1(IMutationsLib.FloralOvariesIM) >= 1) lustDmgA *= 1.2;
            if (player.perkv1(IMutationsLib.FloralOvariesIM) >= 2) {
                if (monster.isMaleOrHerm()) lustDmgA *= 1.5;
                lustDmgA *= 1.25;
            }
            if (player.perkv1(IMutationsLib.FloralOvariesIM) >= 3) {
                if (rand(100) > 69) monster.createStatusEffect(StatusEffects.Fascinated,0,0,0,0);
                lustDmgA *= 1.3;
            }
            lustDmgA *= monster.lustVuln;
            lustDmgA = combat.fixPercentLust(lustDmgA);
            monster.teased(Math.round(lustDmgA), false);
            outputText("\n\n");
            if (player.hasPerk(PerkLib.EromancyMaster)) teaseXP(1 + bonusExpAfterSuccesfullTease());
        }
        //Lust storm
        if (player.hasStatusEffect(StatusEffects.lustStorm)) {
            var damage0:Number = scalingBonusIntelligence() * spellModWhite();
            //Determine if critical hit!
            var crit1:Boolean = false;
            var critChance1:int = 5;
            critChance1 += combatMagicalCritical();
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance1 = 0;
            if (rand(100) < critChance1) {
                crit1 = true;
                damage0 *= 1.75;
            }
            //High damage to goes.
            damage0 = magic.calcVoltageModImpl(damage0, true);
            if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage0 *= (1 + (player.lust100 * 0.01));
            if (player.hasPerk(PerkLib.RacialParagon)) damage0 *= RacialParagonAbilityBoost();
            damage0 = Math.round(damage0);
            dynStats("lus", (Math.round(player.maxLust() * 0.02)), "scale", false);
            var lustDmgF:Number = (scalingBonusLibido() * 0.1 + scalingBonusIntelligence() * 0.1);
            var lustBoostToLustDmg:Number = lustDmgF * 0.01;
            lustDmgF = teases.teaseAuraLustDamageBonus(monster, lustDmgF);
            if (player.hasPerk(PerkLib.RacialParagon)) lustDmgF *= RacialParagonAbilityBoost();
            if (player.lust100 * 0.01 >= 0.9) lustDmgF += (lustBoostToLustDmg * 140);
            else if (player.lust100 * 0.01 < 0.2) lustDmgF += (lustBoostToLustDmg * 140);
            else lustDmgF += (lustBoostToLustDmg * 2 * (20 - (player.lust100 * 0.01)));
            //Determine if critical tease!
            var crit2:Boolean = false;
            var critChance2:int = 5;
            critChance2 += teases.combatTeaseCritical();
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance2 = 0;
            if (rand(100) < critChance2) {
                crit2 = true;
                lustDmgF *= 1.75;
            }
            lustDmgF = lustDmgF * monster.lustVuln;
            lustDmgF = Math.round(lustDmgF);
            outputText("Your opponent is struck by lightning as your lust storm rages on.")
            damage0 = doLightningDamage(damage0, true, true);
            if (crit1) outputText(" <b>*Critical!*</b>");
            monster.teased(lustDmgF, false);
            if (crit2) outputText(" <b>Critical!</b>");
            outputText(" as a bolt falls from the sky!\n\n");
            if (player.hasPerk(PerkLib.EromancyMaster)) teaseXP(1 + bonusExpAfterSuccesfullTease());
            if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3){
                if (rand(100) < 10) {
                    if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
                }
            }
            checkAchievementDamage(damage0);
            statScreenRefresh();
            if (monster.HP <= monster.minHP()) doNext(endHpVictory);
            if (monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
        }
        //Sing
        if (player.hasStatusEffect(StatusEffects.Sing) && monster.lustVuln > 0) {
            outputText("[Themonster] slowly succumbs to [monster his] basest desires as your continous singing compels [monster him] toward increasingly lustful thoughts.");
            var LustDamage:int = combat.teases.teaseBaseLustDamage();
            if (player.perkv1(IMutationsLib.MelkieLungIM) >= 2) LustDamage += scalingBonusIntelligence();
            if (player.perkv1(IMutationsLib.MelkieLungIM) >= 3) LustDamage += scalingBonusIntelligence();
            var randomcrit:Boolean = false;
            //Determine if critical tease!
            var critChance4:int = 5;
            critChance4 += teases.combatTeaseCritical();
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance4 = 0;
            if (rand(100) < critChance4) {
                randomcrit = true;
                LustDamage *= 1.75;
            }
            if (player.hasPerk(PerkLib.RacialParagon)) LustDamage *= combat.RacialParagonAbilityBoost();
            if (player.hasPerk(PerkLib.NaturalArsenal)) LustDamage *= 1.50;
            if (player.perkv1(IMutationsLib.MelkieLungIM) >= 1) LustDamage *= (1 + (0.25 * player.perkv1(IMutationsLib.MelkieLungIM)));
            //Apply intensity multiplier
            LustDamage *= player.statusEffectv1(StatusEffects.Sing);
            if (player.armor == armors.ELFDRES && player.isElf()) LustDamage *= 2;
            if (player.armor == armors.FMDRESS && player.isWoodElf()) LustDamage *= 2;
            //Resolve
            LustDamage = (LustDamage) * monster.lustVuln;
            LustDamage = Math.round(LustDamage);
            monster.teased(LustDamage, false);
            if (randomcrit) outputText(" Critical hit!");
            outputText("\n\n");
            if (player.hasPerk(PerkLib.EromancyMaster)) teaseXP(1 + bonusExpAfterSuccesfullTease());
        }
        //Black Frost Aura
        if (player.hasPerk(PerkLib.IceQueenGown) && player.isRaceCached(Races.YUKIONNA) && !flags[kFLAGS.DISABLE_AURAS]) {
            if (!monster.hasPerk(PerkLib.IceNature)) {
                var damageBFA:Number = scalingBonusIntelligence();
                //Determine if critical hit!
                var crit3:Boolean = false;
                var critChance3:int = 5;
                critChance3 += combatMagicalCritical();
                if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance3 = 0;
                if (rand(100) < critChance3) {
                    crit3 = true;
                    damageBFA *= 1.75;
                }
                damageBFA = magic.calcGlacialModImpl(damageBFA, false)/2;
                magic.maintainGlacialModImpl();
                var SpellMultiplier2:Number = 1;
                SpellMultiplier2 += spellMod() - 1;
                damageBFA *= SpellMultiplier2;
                if (player.hasPerk(PerkLib.RacialParagon)) damageBFA *= RacialParagonAbilityBoost();
                damageBFA = Math.round(damageBFA * iceDamageBoostedByDao());
                if (damageBFA > (monster.maxHP()/10)) damageBFA = Math.round(monster.maxHP()/10);
                outputText("Your black frost aura chills [themonster] to the bone, dealing ");
                doIceDamage(damageBFA, true, true);
                outputText(" damage!");
                if (crit3) outputText(" <b>*Critical Hit!*</b>");
                if (monster.plural) outputText(" Your opponents are affected by the freezing cold, slowing down their reflexes and thoughts as ice creeps on their body.");
                else outputText(" Your opponent is affected by the freezing cold, slowing  down [monster his] reflexes and thoughts as ice creeps on [monster his] body.");
                monster.statStore.replaceBuffObject({"spe.mult":-5, "int.mult":-5}, "Black Frost",{text:"Black Frost"});
                outputText("\n\n");
                if (monster.HP <= monster.minHP()) doNext(endHpVictory);
            } else {
                outputText("Your opponent seems not to be affected by the cold of your aura of black frost. Probably because [monster he] is immune to the cold's effects.");
            }
        }

        //Desert Summoner Spells
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedFluffBall)) {
            outputText("[themonster] comes in for an attack, but your fluffball jumps between you and [themonster]. Fur flies, your fluffball vanishing into shards of light. But the [themonster]  is thrown back, their attack foiled. ");
            player.removeStatusEffect (StatusEffects.MonsterSummonedFluffBall);
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedWetNymph)) {
            outputText("Your Nymph slides forward, fingers slipping into her crotch and giving [themonster] a clear view of her gushing pussy. ");
            
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedDarkMage)) {
            outputText("Black energy spirals from the violet orb on the end of Dark mage’s staff. Your monster hurls a black blob of energy, striking [themonster] square in the chest");
        
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedDarkEnchantress)) {
            outputText("Your Dark enchantress gives an evil little giggle, twirling her staff. She shoves it forward, sending a violet, heart-shaped blob of darkness at [themonster]");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedSummonersAcolyte)) {
            outputText("Your Summoner’s Acolyte seems panicked, but he brandishes his khopesh like a true warrior, jumping forward and slashing [themonster]");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedGolemancersAssistant)) {
            outputText("You notice your golems moving faster than normal, allowing them to get an additional attack in. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedSnowWhite)) {
            outputText("");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedVampireBaroness)) {
            outputText("Your Vampire Baroness’s teeth elongate, and she flaps her bat wings, sending her cape floating as she latches onto the [themonster]. Her teeth sink into their neck, and she closes her eyes in delight. After a few moments, she kicks off, coming back to you.");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedFlameheartedDragonAxe)) {
            outputText("Your Axe-dragon roars, belching flame at the [themonster]. It leaps after the flames, following it up with its blade-wings, cutting an X in their body.");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedWhiteLotus)) {
            outputText("Your lotus monk rushes the [themonster], arms, legs and tail a blur of motion. He lands several strikes, and as the [themonster] rallies, he leaps back, avoiding the counterattack with practised ease. He stands on his flower, looking at them with calm detachment.");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedPinkLotus)) {
            outputText("Lady Lotus’s flower withers as she spreads her arms. She comes behind you, wrapping both arms around your waist. You can feel your body relaxing, muscles filling with power. Your fatigue vanishes, but as you look around, your Lady Lotus seems to be gone");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedLanguishingLotus)) {
            outputText("Your corrupted mouse seems to vanish, reappearing in front of [themonster]. He fires off a series of rapid jabs, then a kick, then in an odd, somewhat off-putting move, thrusts his hips forward into [themonster]’s stomach, striking them with his dick. While they’re off-balance, he vanishes, reappearing in front of you. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedBlackLotus)) {
            outputText("The tentacled creature lopes forward, jabbing at [themonster] with his arms. Two of his tendrils wrap around their legs, while the others slither up");
            outputText("(If male) They jam into [themonster]’s ass, pumping a few times. Black Lotus licks his lips, withdrawing before they can throw him off.");
            outputText("They prod at the entrance to [themonster]’s pussy and ass, Black Lotus licking his lips. [themonster] lashes out, and Black Lotus chuckles, withdrawing fast as lightning. ");
            outputText("(If genderless or immune) They strike [themonster]’s undercarriage, to no effect. Seemingly frustrated, Black Lotus returns to your side. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedFlamingBreakerFist)) {
            outputText("Flaming Breaker fist lunges at [themonster], leaving a trail of flame in her wake. [themonster] reels back as she strikes once, twice, with her burning knuckles. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedSpectreofSpite)) {
            outputText("Your spectre floats towards [themonster], enveloping their body in smoke. ");
            outputText("(Success) Your foe stops to pleasure themselves, eyes wide. After a few seconds, they shudder, and your spectre emerges, seemingly thrown out. ");
            outputText("(Failure) Your foe shudders, but your spectre is unable to possess them.");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedLactaWarhammer)) {
            outputText("Your Milky Monster rubs her milky breasts, getting close to [themonster] before letting loose a war cry. Raising her hammer high, she brings it down onto [themonster]. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedMilkyShieldmaiden)) {
            outputText("With a mix between a moo and a roar, your milky shieldmaiden rushes the enemy. ");
            outputText("(On hit) her shield collides with [themonster] with a loud, metallic clang of impact. ");
            outputText("(on miss) [themonster] dodges, and your shieldmaiden huffs, returning to your side. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedUnicornsAscent)) {
            outputText("");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedJealousSheWolf)) {
            outputText("A small teacup appears beside your head. You take the cup, slugging the contents. Your mana and stamina are filling faster. Your she-wolf sprints at [themonster], slashing with her claws.");
            outputText("(If you have other monsters out) She slashes even harder than usual, digging into the foe with wild abandon!");
            outputText("As your she-wolf jumps back to you, her tail wags happily.");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedAlchemicalElder)) {
            outputText("With a squeak, your alchemical elder chucks a random vial on his workbench at [themonster]. ");
            
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedSequesteredSiren)) {
            outputText("Your siren dives towards [themonster], taking you with her. She lashes out with her talons, cutting gashes across [themonster]’s upper body!");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedFinalFlamebearer)) {
            outputText("Attack: Your draconic Flamebearer roars, swooping down on your foe. They grab [themonster] in their razor-sharp talons, then bring their maw in close, shooting a stream of flames into their face. ");
        }
if (player.hasStatusEffect(StatusEffects.MonsterSummonedFeatheredBroodmother)) {
            outputText("Your broodmother leaps at [themonster], talons out…and lands a kiss on their lips, rubbing her pussy lips on them. They swipe at her, but your broodmother’s already moving, wings pumping. She lands back in front of you, ready to attack again. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedHarpyMatriarch)) {
            outputText("Your harpy matriarch swoops down upon [themonster], grabbing them with her razor-sharp talons. She pulls her head in, kissing [themonster] before letting go, flying back to you.");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedFeatheredHorde)) {
            outputText("[themonster] is suddenly engulfed by a feathery storm! You hear muffled sounds from within the bunch, kissing, rubbing…A few even try to grab at them and pull them away, with no success. After a few seconds, they break off, circling you again. [themonster] is covered in little lipstick marks. ");
            
        }
if (player.hasStatusEffect(StatusEffects.MonsterSummonedArmouredGoo)) {
            outputText("");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedReluctantRebirther)) {
            outputText("The Reluctant Rebirther reaches into her pouch, finding a blowpipe and several nasty-looking darts. She rapidly fires the darts at [themonster].");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedShackledRat)) {
            outputText("");
        }
if (player.hasStatusEffect(StatusEffects.MonsterSummonedRodentsReborn)) {
            outputText("With many high pitched war cries, your little army charges [themonster]. Some shoot undersized darts, others rush in with tiny weapons. Individually, they don’t seem to be doing much, but they’re many, and [themonster] constantly has to watch their footing. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedMartyrMagician)) {
            outputText("Your Martyr Magician spreads their fingers, sending a bolt of electricity arcing from their fingertips to [themonster]. You can feel the raw power…and a draining sensation. This power is sapping your health!");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedLakeLibrarian)) {
            outputText("Your Lake Librarian rushes at [themonster], deftly dodging their attempts to fend her off and sinking her teeth into them. She punches once, twice, before ripping her teeth off and away. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedQueenUnderEarth)) {
            outputText("The Queen Under the Earth motions imperiously, pointing at [themonster]. The ground trembles, and hundreds of small holes seemingly open from below. Ants, more like the ones from your home, pour from the holes, rushing at [themonster], covering them. A few moments pass, and your foe is covered in bites.");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedLactationDrowned)) {
            outputText("You feel the milk absorbing into your [skin]. Your injuries are knitting together! ");
            outputText("Your chocolate-skinned girl seems to melt into her milk, giving you a dumb, happy smile as she vanishes. The milky tide drains away, a small hole in the ground seemingly sucking all the healing fluids back into the ground.");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedMadnessHarbinger)) {
            outputText("");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedFetishMerchant)) {
            outputText("Your summoned omnibus tackles [themonster], smothering their face in her breasts. She coos, her demonic dick rubbing between their legs. After a few seconds, your foe pushes her off, but the damage is already done. A small sigil glows on your foe’s body. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedFriendlyFuckinFisherwoman)) {
            outputText("Your Friendly Fisherwoman heaves on her rod. From below [themonster], you see a large, spiny fish, pulled up as fast as any arrow would fly. It smacks [themonster] hard, bouncing back into your fisherwoman’s arms. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedHorseplaySentinel)) {
            outputText("Your sentinel charges your foe, swinging her halberd. [themonster] tries to block, but her blade cuts deep. As she turns around, you can see [themonster] swooning slightly at the musk.");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedCockHunter)) {
            outputText("");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedHornyHorde)) {
            outputText("");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedmountainscissors)) {
            outputText("Your summoned goblin approaches [themonster] slowly, but pounces once she’s within range. Her scissors flash out like swords, leaving gashes on [themonster]’s body. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedEquineYogamaster)) {
            outputText("Your Yogamaster saunters in, before leaping into the air, kicking [themonster] hard. She lands quickly, landing two more solid strikes before leaping into a backflip, kicking [themonster] again and rolling backwards toward you. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedGuardedAlleycat)) {
            outputText("");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedLaquineOdoriko)) {
            outputText("");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedDivineMother)) {
            outputText("Your Divine Mother advances, her ‘child’ behind her. She swings her halberd with both hands, and while [themonster] tries to block that, her ‘child’ leaps over her, landing on them. He claws their face, then leaps off as she swings her halberd once more. The two then step back, rejoining you. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedCorruptedKaiju)) {
            outputText("Your Kaiju makes lewd noises. You’re assuming from the angle of her arms that she’s jilling off, but you can’t see from back here. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedSwamplandProtector)) {
            outputText("");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedBuriedKing)) {
            outputText("“I summon [monstername]” The pharaoh roars. Beside him, the ground explodes into multicoloured light. ");
            outputText("The Pharaoh begins to fade, your power stretched thin. He turns, giving you a respectful salute before his body explodes into fragments of light. “Until you need me again, my friend.”");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedDriderLadyCorruptedSteel)) {
            outputText("Your giant Drider lady silently charges at [themonster], arms outstretched. She rears back, and with the squeal of tortured steel, she strikes, a brutal warhammer of a fist striking [themonster] in the face. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedDriderLadyManaWeaver)) {
            outputText("Your Weaver shoots a braided strand of webbing at [themonster], the thick strands wrapping around them. She pulls, anchoring the silk to the ground. [themonster] will have a hard time moving with this silk dragging them down!");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedDriderLadyHuntressBound)) {
            outputText("As [themonster] attacks, your Bound huntress moves into their way, latching onto them. "); 
			outputText("(if immune to lust damage) [Themonster] throws her off, more annoyed than aroused. ");
			outputText("(otherwise) you see a blush rise in their cheeks as they push past her. ");
        }
        if (player.hasStatusEffect(StatusEffects.MonsterSummonedDriderLadySisters)) {
            outputText("");
        }/*
        if (player.hasStatusEffect(StatusEffects.)) {
            outputText("");
        }*/

		//Bat swarm
        if (player.isRaceCached(Races.DRACULA) && !flags[kFLAGS.DISABLE_AURAS]) {
            var damageBS:Number = scalingBonusIntelligence();
            //Determine if critical hit!
            var crit4:Boolean = false;
            var critChance5:int = 5;
            critChance5 += combatMagicalCritical();
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance5 = 0;
            if (rand(100) < critChance5) {
                crit4 = true;
                damageBS *= 1.75;
            }
            damageBS *= 0.5;
            var SpellMultiplierBS:Number = 1;
            SpellMultiplierBS += spellMod() - 1;
            damageBS *= SpellMultiplierBS;
            if (player.hasPerk(PerkLib.RacialParagon)) damageBS *= RacialParagonAbilityBoost();
            damageBS = Math.round(damageBS);
            damageBS = fixPercentDamage(damageBS);
            outputText("The cloud of bat surrounding you bite and scratch at your opponent"+(monster.plural?"s":"")+" viciously harvesting its lifeblood wich you promptly take onto yourself with your fiendish magic. ");
            doPhysicalDamage(damageBS, true, true);
            outputText(" damage!");
            if (crit4) outputText(" <b>*Critical Hit!*</b>");
            outputText("\n\n");
			var dmg002:Number = damageBS;
			if (dmg002 > Math.round(player.maxHP() * 0.03)) dmg002 = Math.round(player.maxHP() * 0.03);
			HPChange(dmg002, true);
			var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
			var drinked:Number = 1;
			if (player.perkv1(IMutationsLib.HollowFangsIM) >= 3) drinked += 1;
			if (player.perkv1(IMutationsLib.HollowFangsIM) >= 4) drinked += 3;
			if (player.perkv1(IMutationsLib.VampiricBloodstreamIM) >= 4) drinked *= 2;
			if (player.hasPerk(PerkLib.BloodMastery)) drinked *= 2;
			thirst.drink(drinked);
        }

        //Plant Growth
        if (player.hasStatusEffect(StatusEffects.PlantGrowth) && monster.lustVuln > 0) {
            outputText("The vine slithers around [monster him] before groping at [monster his] erogenous zones, enticing them as their focus and grip on combat weakens.");
			var damagePG:Number = scalingBonusIntelligence() * 0.1 * spellModWhite();
            repeatArcaneVenom(damagePG, 1, 0);
			outputText("\n\n");
        }
		//Entagled
		if (monster.hasStatusEffect(StatusEffects.Entangled)) {
			if (40 + rand(player.inte) + rand(player.lib) > monster.spe) outputText("The vines are currently wrapped around [themonster], ensuring that [monster he] cannot escape their clutches. ");
			else {
				outputText("[Themonster] wriggles free from the vines, regaining control of [himself]\n\n");
				monster.removeStatusEffect(StatusEffects.Entangled);
			}
		}
		//Briarthorn
		if (monster.hasStatusEffect(StatusEffects.Briarthorn) && monster.lustVuln > 0) {
			outputText("The poison inflicted by the thorns gnaws at your opponent countenance.");
			var damageB:Number = scalingBonusIntelligence() * 0.15 * spellModWhite();
			repeatArcaneVenom(damageB, 0, 0);
			outputText("\n\n");
		}
		//Death Blossom
		if (monster.hasStatusEffect(StatusEffects.DeathBlossom)) {
			outputText("The airborne poisons and aphrodisiacs spread by the blossoming flowers thickens.\n");
			var damageDBH:Number = scalingBonusIntelligence() * 0.2 * spellModWhite() * monster.statusEffectv2(StatusEffects.DeathBlossom);
			damageDBH = Math.round(damageDBH * poisonDamageBoostedByDao());
			var damageDBL:Number = 0;
			if (monster.lustVuln > 0) damageDBL += scalingBonusIntelligence() * 0.03 * spellModWhite() * monster.statusEffectv2(StatusEffects.DeathBlossom);
			repeatArcaneVenom(damageDBL, 0, damageDBH);
			outputText("\n\n");
		}
        if (player.hasStatusEffect(StatusEffects.Bound) && flags[kFLAGS.PC_FETISH] >= 2) {
            outputText("The feel of tight leather completely immobilizing you turns you on more and more.  Would it be so bad to just wait and let her play with you like this?\n\n");
            player.takeLustDamage(3, true);
        }
        if (player.hasStatusEffect(StatusEffects.GooArmorBind)) {
            if (flags[kFLAGS.PC_FETISH] >= 2) {
                outputText("The feel of the all-encapsulating goo immobilizing your helpless body turns you on more and more.  Maybe you should just wait for it to completely immobilize you and have you at its mercy.\n\n");
                player.takeLustDamage(3, true);
            } else outputText("You're utterly immobilized by the goo flowing around you.  You'll have to struggle free!\n\n");
        }
        if (player.hasStatusEffect(StatusEffects.HarpyBind)) {
            if (flags[kFLAGS.PC_FETISH] >= 2) {
                outputText("The harpies are holding you down and restraining you, making the struggle all the sweeter!\n\n");
                player.takeLustDamage(3, true);
            } else outputText("You're restrained by the harpies so that they can beat on you with impunity.  You'll need to struggle to break free!\n\n");
        }
        if ((player.hasStatusEffect(StatusEffects.NagaBind) || player.hasStatusEffect(StatusEffects.ScyllaBind)) && flags[kFLAGS.PC_FETISH] >= 2) {
            outputText("Coiled tightly by [themonster] and utterly immobilized, you can't help but become aroused thanks to your bondage fetish.\n\n");
            player.takeLustDamage(5, true);
        }
        if (player.hasStatusEffect(StatusEffects.TentacleBind)) {
            outputText("You are firmly trapped in the tentacle's coils.  <b>The only thing you can try to do is struggle free!</b>\n\n");
            if (flags[kFLAGS.PC_FETISH] >= 2) {
                outputText("Wrapped tightly in the tentacles, you find it hard to resist becoming more and more aroused...\n\n");
                player.takeLustDamage(3, true);
            }
        }
        if (player.hasStatusEffect(StatusEffects.MagnarPinned)) {
            outputText("You are firmly held in Magnar's grip.  <b>The only thing you can try to do is struggle free!</b>\n\n");
            if (flags[kFLAGS.PC_FETISH] >= 2) {
                outputText("With him constantly chocking you, you find it hard to resist becoming more and more aroused...\n\n");
                player.takeLustDamage(3, true);
            }
        }
        if (player.hasStatusEffect(StatusEffects.DriderKiss)) {
            //(VENOM OVER TIME: WEAK)
            if (player.statusEffectv1(StatusEffects.DriderKiss) == 0) {
                outputText("Your heart hammers a little faster as a vision of the drider's nude, exotic body on top of you assails you.  It'll only get worse if she kisses you again...\n\n");
                player.takeLustDamage(8, true);
            }
            //(VENOM OVER TIME: MEDIUM)
            else if (player.statusEffectv1(StatusEffects.DriderKiss) == 1) {
                outputText("You shudder and moan, nearly touching yourself as your ");
                if (player.gender > 0) outputText("loins tingle and leak, hungry for the drider's every touch.");
                else outputText("asshole tingles and twitches, aching to be penetrated.");
                outputText("  Gods, her venom is getting you so hot.  You've got to end this quickly!\n\n");
                player.takeLustDamage(15, true);
            }
            //(VENOM OVER TIME: MAX)
            else {
                outputText("You have to keep pulling your hands away from your crotch - it's too tempting to masturbate here on the spot and beg the drider for more of her sloppy kisses.  Every second that passes, your arousal grows higher.  If you don't end this fast, you don't think you'll be able to resist much longer.  You're too turned on... too horny... too weak-willed to resist much longer...\n\n");
                player.takeLustDamage(25, true);
            }
        }
        if (player.hasStatusEffect(StatusEffects.AikoLightningArrow)) {
            if (player.statusEffectv1(StatusEffects.AikoLightningArrow) <= 0 || player.hasPerk(PerkLib.KingOfTheJungle)) {
                player.removeStatusEffect(StatusEffects.AikoLightningArrow);
                outputText("<b>You feel stronger as Aiko's lightning finally fades, though the arrow is still lodged in your side.</b>\n\n");
                player.buff("LightningArrowStr").remove();
				player.buff("LightningArrowSpe").remove();
            }
            //Shock effect:
            else {
                outputText("You fall to one knee as Aiko's Lighting pulses through your limbs, Oh how this hurts...");
				if (player.statStore.hasBuff("Crossed Holy Band")) player.takeLightningDamage(8, true);
				else player.takeLightningDamage(15, true);
                outputText("\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.YamataEntwine)) {
            //Corrupting entwine effect:
            outputText("Yamata's serpentine hair continues to pump their corrupted flames into you!  ");
            player.takeFireDamage(8, true);
            player.takeLustDamage(7, true);
            player.dynStats("cor", 1);
            flags[kFLAGS.YAMATA_MASOCHIST]++;
        }
        //Harpy lip gloss
        if (player.hasCock() && player.hasStatusEffect(StatusEffects.Luststick) && (monster.short == "harpy" || monster.short == "Sophie")) {
            //Chance to cleanse!
            if ((player.hasPerk(PerkLib.Medicine) && rand(100) <= 14) || player.hasPerk(PerkLib.KingOfTheJungle)) {
                outputText("You manage to cleanse the harpy lip-gloss from your system with your knowledge of medicine!\n\n");
                player.removeStatusEffect(StatusEffects.Luststick);
                player.minLustXStat.removeBuff("Luststick");
            } else if (rand(5) == 0) {
                if (rand(2) == 0) outputText("A fantasy springs up from nowhere, dominating your thoughts for a few moments.  In it, you're lying down in a soft nest.  Gold-rimmed lips are noisily slurping around your [cock], smearing it with her messy aphrodisiac until you're completely coated in it.  She looks up at you knowingly as the two of you get ready to breed the night away...\n\n");
                else outputText("An idle daydream flutters into your mind.  In it, you're fucking a harpy's asshole, clutching tightly to her wide, feathery flanks as the tight ring of her pucker massages your [cock].  She moans and turns around to kiss you on the lips, ensuring your hardness.  Before long her feverish grunts of pleasure intensify, and you feel the egg she's birthing squeezing against you through her internal walls...\n\n");
                player.takeLustDamage(20, true);
            }
        }
        if (player.hasStatusEffect(StatusEffects.StoneLust)) {
            if (player.vaginas.length > 0) {
                if (player.lust < 40) outputText("You squirm as the smooth stone orb vibrates within you.\n\n");
                if (player.lust >= 40 && player.lust < 70) outputText("You involuntarily clench around the magical stone in your twat, in response to the constant vibrations.\n\n");
                if (player.lust >= 70 && player.lust < 85) outputText("You stagger in surprise as a particularly pleasant burst of vibrations erupt from the smooth stone sphere in your " + vaginaDescript(0) + ".\n\n");
                if (player.lust >= 85) outputText("The magical orb inside of you is making it VERY difficult to keep your focus on combat, white-hot lust suffusing your body with each new motion.\n\n");
            } else {
                outputText("The orb continues vibrating in your ass, doing its best to arouse you.\n\n");
            }
            player.takeLustDamage(7 + int(player.effectiveSensitivity()) / 10, true);
        }
        if (player.hasStatusEffect(StatusEffects.RaijuStaticDischarge)) {
            outputText("The raiju electricity stored in your body continuously tingle around your genitals!\n\n");
            player.takeLustDamage(14 + int(player.effectiveSensitivity()) / 8, true);
        }
        if (player.hasStatusEffect(StatusEffects.KissOfDeath)) {
            //Effect
            if (player.hasPerk(PerkLib.AlteredAnima)) {
				outputText("Your body suddenly goes slack as you feel bits of your soul leave your body. But before long, violet whisps return to your body with a reinvigorating spasm, as you try desperately to hold back frenzied laughter from the sensation.\n\n");
				EngineCore.ManaChange(Math.round(player.maxMana() * 0.005));
			}
			else {
				outputText("Your lips burn with an unexpected flash of heat.  They sting and burn with unholy energies as a puff of ectoplasmic gas escapes your lips.  That puff must be a part of your soul!  It darts through the air to [themonster], who slurps it down like a delicious snack.  You feel feverishly hot and exhausted...\n\n");
				player.takeLustDamage(5, true);
				player.takePhysDamage(15);
			}
        }
        if (player.hasStatusEffect(StatusEffects.DemonSeed)) {
            outputText("You feel something shift inside you, making you feel warm.  Finding the desire to fight this... hunk gets harder and harder.\n\n");
            player.takeLustDamage((player.statusEffectv1(StatusEffects.DemonSeed) + int(player.effectiveSensitivity() / 30) + int(player.lib / 30) + int(player.cor / 30)), true);
        }
        if (player.inHeat && player.vaginas.length > 0 && monster.cockTotal() > 0) {
            player.takeLustDamage((rand(player.lib / 5) + 3 + rand(5)), true);
            outputText("Your " + vaginaDescript(0) + " clenches with an instinctual desire to be touched and filled.  ");
            outputText("If you don't end this quickly you'll give in to your heat.\n\n");
        }
        if (player.inRut && player.cockTotal() > 0 && monster.hasVagina()) {
            player.takeLustDamage((rand(player.lib / 5) + 3 + rand(5)), true);
            if (player.cockTotal() > 1) outputText("Each of y");
            else outputText("Y");
            if (monster.plural) outputText("our [cocks] dribbles pre-cum as you think about plowing [themonster] right here and now, fucking [monster his] [monster cunt]s until they're totally fertilized and pregnant.\n\n");
            else outputText("our [cocks] dribbles pre-cum as you think about plowing [themonster] right here and now, fucking [monster his] [monster cunt] until it's totally fertilized and pregnant.\n\n");
        }
        if (player.hasStatusEffect(StatusEffects.NagaVenom)) {
            //Chance to cleanse!
            if ((player.hasPerk(PerkLib.Medicine) && rand(100) <= 14)  || player.hasPerk(PerkLib.KingOfTheJungle)) {
                outputText("Using your knowledge of medicine, you manage to cleanse [themonster] venom from your system.\n\n");
                player.removeStatusEffect(StatusEffects.NagaVenom);
            } else if (player.spe > 3) {
                player.addStatusValue(StatusEffects.NagaVenom, 1, 2);
                player.statStore.addBuffObject({"spe": -player.statusEffectv1(StatusEffects.NagaVenom)}, "Poison", {text: "Poisoned!"})
            } else player.takePhysDamage(5);
            outputText("You wince in pain and try to collect yourself, [themonster]'s venom still plaguing you.\n\n");
            player.takePhysDamage(2);
        }
        if (player.hasStatusEffect(StatusEffects.MedusaVenom)) {
            //Chance to cleanse!
            if ((player.hasPerk(PerkLib.Medicine) && rand(100) <= 14)  || player.hasPerk(PerkLib.KingOfTheJungle)) {
                outputText("Using your knowledge of medicine, you manage to cleanse [themonster] venom from your system.\n\n");
                player.statStore.removeBuffs("Poison");
                player.removeStatusEffect(StatusEffects.MedusaVenom);
            } else if (player.str <= 5 && player.tou <= 5 && player.spe <= 5 && player.inte <= 5) player.takePhysDamage(5);
            else {
                player.addStatusValue(StatusEffects.MedusaVenom, 1, 2);
                player.addStatusValue(StatusEffects.MedusaVenom, 2, 1);
                player.statStore.addBuffObject({"str": player.statusEffectv1(StatusEffects.MedusaVenom), "tou": player.statusEffectv1(StatusEffects.MedusaVenom), "spe": player.statusEffectv1(StatusEffects.MedusaVenom), "int": player.statusEffectv2(StatusEffects.MedusaVenom)}, "Poison", {text: "Poisoned!"})
            }
            outputText("You wince in pain and try to collect yourself, [themonster]'s venom still plaguing you.\n\n");
            player.takePhysDamage(2);
        }
        //Temporary heat
        if (player.hasStatusEffect(StatusEffects.TemporaryHeat)) {
            //Chance to cleanse!
			if ((player.hasPerk(PerkLib.Medicine) && rand(100) <= 14) || player.hasPerk(PerkLib.KingOfTheJungle)) {
                outputText("With your knowledge of medicine, you manage to cleanse the heat and rut drug from your system.\n\n");
                player.removeStatusEffect(StatusEffects.TemporaryHeat);
            } else {
                player.takeLustDamage((player.lib / 12 + 5 + rand(5)) * player.statusEffectv2(StatusEffects.TemporaryHeat), true);
                if (player.hasVagina()) {
                    outputText("Your " + vaginaDescript(0) + " clenches with an instinctual desire to be touched and filled.  ");
                } else if (player.cockTotal() > 0) {
                    outputText("Your [cock] pulses and twitches, overwhelmed with the desire to breed.  ");
                }
                if (player.gender == 0) {
                    outputText("You feel a tingle in your " + assholeDescript() + ", and the need to touch and fill it nearly overwhelms you.  ");
                }
                outputText("If you don't finish this soon you'll give in to this potent drug!\n\n");
            }
        }
        //Poison
        if (player.hasStatusEffect(StatusEffects.Poison)) {
            //Chance to cleanse!
            if ((player.hasPerk(PerkLib.Medicine) && rand(100) <= 14) || player.hasPerk(PerkLib.KingOfTheJungle)) {
                outputText("You manage to cleanse the poison from your system with your knowledge of medicine!\n\n");
                player.removeStatusEffect(StatusEffects.Poison);
            } else {
                outputText("The poison continues to work on your body, wracking you with pain!\n\n");
				if (player.statStore.hasBuff("Crossed Holy Band")) player.takePhysDamage((8 + rand(player.maxHP() / 20) * player.statusEffectv2(StatusEffects.Poison)) * 0.5);
                else player.takePhysDamage(8 + rand(player.maxHP() / 20) * player.statusEffectv2(StatusEffects.Poison));
            }
        }
        //Bondage straps + bondage fetish
        if (flags[kFLAGS.PC_FETISH] >= 2 && player.armorName == "barely-decent bondage straps") {
            outputText("The feeling of the tight, leather straps holding tightly to your body while exposing so much of it turns you on a little bit more.\n\n");
            player.takeLustDamage(2, true);
        }
        // Drider incubus venom
        if (player.hasStatusEffect(StatusEffects.DriderIncubusVenom)) {
            if ((player.hasPerk(PerkLib.Medicine) && rand(100) <= 41) || player.hasPerk(PerkLib.KingOfTheJungle)) {
                outputText("You negate the effects of the drider incubus’ venom with your knowledge of medicine!\n\n");
                player.statStore.removeBuffs("Poison");
                player.removeStatusEffect(StatusEffects.DriderIncubusVenom);
                CoC.instance.mainView.statsView.showStatUp('str');
            } else {
                player.addStatusValue(StatusEffects.DriderIncubusVenom, 1, -1);
                if (player.statusEffectv1(StatusEffects.DriderIncubusVenom) <= 0) {
                    player.statStore.removeBuffs("Poison");
                    player.removeStatusEffect(StatusEffects.DriderIncubusVenom);
                    CoC.instance.mainView.statsView.showStatUp('str');
                    outputText("The drider incubus’ venom wanes, the effects of the poision weakening as strength returns to your limbs!\n\n");
                } else {
                    outputText("The demonic drider managed to bite you, infecting you with his strength-draining poison!\n\n");
                }
            }
        }
        if (monster.hasStatusEffect(StatusEffects.OnFire)) {
            var damage1:Number = 20 + rand(5);
            monster.HP -= damage1;
            monster.addStatusValue(StatusEffects.OnFire, 1, -1);
            if (monster.statusEffectv1(StatusEffects.OnFire) <= 0) {
                monster.removeStatusEffect(StatusEffects.OnFire);
                outputText("\n\nFlames lick at the horde of demons before finally petering out!");
            } else {
                outputText("\n\nFlames continue to lick at the horde of demons!");
            }
        }
        //Acid DoT
        if (player.hasStatusEffect(StatusEffects.AcidDoT)) {
            player.addStatusValue(StatusEffects.AcidDoT, 1, -1);
            //Heal wounds
            if (player.statusEffectv1(StatusEffects.AcidDoT) <= 0 || player.hasPerk(PerkLib.KingOfTheJungle)) {
                outputText("Acid wounds left by [themonster] finally close ups.\n\n");
                player.removeStatusEffect(StatusEffects.AcidDoT);
            }
        }
        //Frostburn DoT
        if (player.hasStatusEffect(StatusEffects.FrostburnDoT)) {
            player.addStatusValue(StatusEffects.FrostburnDoT, 1, -1);
            //Heal wounds
            if (player.statusEffectv1(StatusEffects.FrostburnDoT) <= 0 || player.hasPerk(PerkLib.KingOfTheJungle)) {
                outputText("Frostburn wounds left by [themonster] finally close ups.\n\n");
                player.removeStatusEffect(StatusEffects.FrostburnDoT);
            } else {
                var frostburnPlayer:Number = (monster.str + monster.spe + monster.tou) * 2.5;
                frostburnPlayer += player.maxHP() * player.statusEffectv2(StatusEffects.FrostburnDoT);
				if (player.statStore.hasBuff("Crossed Holy Band")) frostburnPlayer *= 0.5;
                outputText("You are hurt by lingering Frostburn after-effect. ");
                player.takeIceDamage(frostburnPlayer, true);
                outputText("\n\n");
            }
        }
        //Frozen Lung DoT
        if (player.hasStatusEffect(StatusEffects.FrozenLung)) {
            player.addStatusValue(StatusEffects.FrozenLung, 1, -1);
            //Heal wounds
            if (player.statusEffectv1(StatusEffects.FrozenLung) <= 0 || player.hasPerk(PerkLib.KingOfTheJungle)) {
                outputText("Frozen Lung left by [themonster] finally ends.\n\n");
                player.removeStatusEffect(StatusEffects.FrozenLung);
            } else {
                var frozenlung:Number = player.maxHP() * player.statusEffectv2(StatusEffects.FrozenLung);
				if (player.statStore.hasBuff("Crossed Holy Band")) frozenlung *= 0.5;
                outputText("You are hurt by lingering Frozen Lung after-effect. ");
                player.takeIceDamage(frozenlung, true);
                outputText("\n\n");
            }
        }
        //Hydra Regeneration Inhibition
        if (player.hasStatusEffect(StatusEffects.HydraRegenerationDisabled)) {
            player.addStatusValue(StatusEffects.HydraRegenerationDisabled, 1, -1);
            if (player.statusEffectv1(StatusEffects.HydraRegenerationDisabled) <= 0) player.removeStatusEffect(StatusEffects.HydraRegenerationDisabled);
        }
        //Giant boulder
        if (player.hasStatusEffect(StatusEffects.GiantBoulder)) {
            outputText("<b>There is a large boulder coming your way. If you don't avoid it in time, you might be crushed!</b>\n\n");
        }
        //Creeping doom
        if (monster.hasStatusEffect(StatusEffects.CreepingDoom)) {
            dynStats("lus", 20);
        }
        //Berzerker/Lustzerker/Dwarf Rage/Oni Rampage/Maleficium/Blazing battle spirit/Cauterize
        if (player.hasStatusEffect(StatusEffects.Berzerking)) {
            if (player.statusEffectv1(StatusEffects.Berzerking) <= 0) {
                player.removeStatusEffect(StatusEffects.Berzerking);
                outputText("<b>Berserker effect wore off!</b>\n\n");
            } else {
				if (player.hasPerk(PerkLib.EndlessRage)) {
					if (player.hasStatusEffect(StatusEffects.TooAngryTooDie)) {
						if (player.wrath >= (player.maxWrath() * (0.1*(1+player.statusEffectv2(StatusEffects.Berzerking))))) player.wrath -= (player.maxWrath() * (0.1*(1+player.statusEffectv2(StatusEffects.Berzerking))));
						else {
							player.removeStatusEffect(StatusEffects.TooAngryTooDie);
							player.removeStatusEffect(StatusEffects.Berzerking);
							outputText("<b>Berserker effect wore off!</b>\n\n");
						}
					} else {
						if (player.wrath >= (50*(1+player.statusEffectv2(StatusEffects.Berzerking)))) player.wrath -= (50*(1+player.statusEffectv2(StatusEffects.Berzerking)));
						else {
							player.removeStatusEffect(StatusEffects.Berzerking);
							outputText("<b>Berserker effect wore off!</b>\n\n");
						}
					}
				} else player.addStatusValue(StatusEffects.Berzerking, 1, -1);
				if (player.statStore.hasBuff("AsuraForm") && player.hasPerk(PerkLib.ItsZerkingTime)) player.addStatusValue(StatusEffects.Berzerking, 1, 1);
			}
        }
        if (player.hasStatusEffect(StatusEffects.Lustzerking)) {
            if (player.statusEffectv1(StatusEffects.Lustzerking) <= 0) {
                player.removeStatusEffect(StatusEffects.Lustzerking);
                outputText("<b>Lustzerker effect wore off!</b>\n\n");
            } else {
				if (player.hasPerk(PerkLib.EndlessRage)) {
					if (player.hasStatusEffect(StatusEffects.TooAngryTooDie)) {
						if (player.wrath >= (player.maxWrath() * (0.1*(1+player.statusEffectv2(StatusEffects.Lustzerking))))) player.wrath -= (player.maxWrath() * (0.1*(1+player.statusEffectv2(StatusEffects.Lustzerking))));
						else {
							player.removeStatusEffect(StatusEffects.TooAngryTooDie);
							player.removeStatusEffect(StatusEffects.Lustzerking);
							outputText("<b>Lustzerker effect wore off!</b>\n\n");
						}
					} else {
						if (player.wrath >= (50*(1+player.statusEffectv2(StatusEffects.Lustzerking)))) player.wrath -= (50*(1+player.statusEffectv2(StatusEffects.Lustzerking)));
						else {
							player.removeStatusEffect(StatusEffects.Lustzerking);
							outputText("<b>Lustzerker effect wore off!</b>\n\n");
						}
					}
				} else player.addStatusValue(StatusEffects.Lustzerking, 1, -1);
				if (player.statStore.hasBuff("AsuraForm") && player.hasPerk(PerkLib.ItsZerkingTime)) player.addStatusValue(StatusEffects.Lustzerking, 1, 1);
			}
        }
        if (player.hasStatusEffect(StatusEffects.OniRampage)) {
            if (player.statusEffectv1(StatusEffects.OniRampage) <= 0) {
                player.removeStatusEffect(StatusEffects.OniRampage);
                outputText("<b>Your rage wear off.</b>\n\n");
            } else player.addStatusValue(StatusEffects.OniRampage, 1, -1);
        }
        if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
            if (player.statusEffectv1(StatusEffects.BlazingBattleSpirit) <= 0) {
                player.removeStatusEffect(StatusEffects.BlazingBattleSpirit);
                outputText("<b>Blazing battle spirit effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.BlazingBattleSpirit, 1, -1);
        }
        if (player.hasStatusEffect(StatusEffects.Cauterize)) {
            if (player.statusEffectv1(StatusEffects.Cauterize) <= 0) {
                player.removeStatusEffect(StatusEffects.Cauterize);
                outputText("<b>Cauterize effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.Cauterize, 1, -1);
        }
        //Blood Frenzy until ennemies stops bleeding
        if (player.hasStatusEffect(StatusEffects.BloodFrenzy)) {
            if (!monster.monsterIsBleeding()) {
                player.removeStatusEffect(StatusEffects.BloodFrenzy);
                player.statStore.removeBuffs("Blood Frenzy");
                outputText("<b>With no blood in the air, your mind clears, your frenzy fades. </b>\n\n");
            }
        }
        //Elven Eye
        if (player.hasStatusEffect(StatusEffects.ElvenEye)) {
            if (player.statusEffectv1(StatusEffects.ElvenEye) <= 0) {
                player.removeStatusEffect(StatusEffects.ElvenEye);
                outputText("<b>Elven Eye effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.ElvenEye, 1, -1);
        }
        if (player.hasStatusEffect(StatusEffects.FlameBlade)) {
            if (player.statusEffectv1(StatusEffects.FlameBlade) <= 0) {
                player.removeStatusEffect(StatusEffects.FlameBlade);
                outputText("<b>Flame Blade effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.FlameBlade, 1, -1);
        }
        if (player.hasStatusEffect(StatusEffects.ElectrifyWeapon)) {
            if (player.statusEffectv1(StatusEffects.ElectrifyWeapon) <= 0) {
                player.removeStatusEffect(StatusEffects.ElectrifyWeapon);
                outputText("<b>Electrify Weapon effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.ElectrifyWeapon, 1, -1);
        }
        if (player.hasStatusEffect(StatusEffects.Maleficium)) {
            if (player.statusEffectv1(StatusEffects.Maleficium) <= 0) {
                player.removeStatusEffect(StatusEffects.Maleficium);
                outputText("<b>Maleficium effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.Maleficium, 1, -1);
        }
        if (player.hasStatusEffect(StatusEffects.PerfectClarity)) {
            if (player.statusEffectv1(StatusEffects.PerfectClarity) <= 0) {
                player.removeStatusEffect(StatusEffects.PerfectClarity);
                outputText("<b>Perfect Clarity effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.PerfectClarity, 1, -1);
        }
        if (player.hasStatusEffect(StatusEffects.WinterClaw)) {
            if (player.statusEffectv1(StatusEffects.WinterClaw) <= 0) {
                player.removeStatusEffect(StatusEffects.WinterClaw);
                outputText("<b>Winter Claw effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.WinterClaw, 1, -1);
        }
		//Alchemic potions
		if (player.hasStatusEffect(StatusEffects.ArmorPotion)) {
            if (player.statusEffectv2(StatusEffects.ArmorPotion) <= 0) {
                player.removeStatusEffect(StatusEffects.ArmorPotion);
                outputText("<b>Painkiller effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.ArmorPotion, 2, -1);
        }
		if (player.hasStatusEffect(StatusEffects.AttackPotion)) {
            if (player.statusEffectv2(StatusEffects.AttackPotion) <= 0) {
                player.removeStatusEffect(StatusEffects.AttackPotion);
                outputText("<b>Stimulant effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.AttackPotion, 2, -1);
        }
		if (player.hasStatusEffect(StatusEffects.TeasePotion)) {
            if (player.statusEffectv2(StatusEffects.TeasePotion) <= 0) {
                player.removeStatusEffect(StatusEffects.TeasePotion);
                outputText("<b>Ginseng effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.TeasePotion, 2, -1);
        }
        //Spell buffs
        //Goblin Mech Stimpack
        if (player.hasStatusEffect(StatusEffects.GoblinMechStimpack)) {
            if (player.statusEffectv1(StatusEffects.GoblinMechStimpack) <= 0) {
                player.removeStatusEffect(StatusEffects.GoblinMechStimpack);
                outputText("<b>" + (player.hasKeyItem("Medical Dispenser 2.0") >= 0 ? "Medical Dispenser 2.0" : "Stimpack Dispenser 1.0") + " effects wore off!</b>\n\n");
            } else {
                player.addStatusValue(StatusEffects.GoblinMechStimpack, 1, -1);
                var hpChange3:int = player.statusEffectv2(StatusEffects.GoblinMechStimpack);
                outputText("<b>" + (player.hasKeyItem("Medical Dispenser 2.0") >= 0 ? "Medical Dispenser 2.0" : "Stimpack Dispenser 1.0") + " healing power spreading throughout your body. ([font-heal]+" + hpChange3 + "[/font])</b>\n\n");
                var selfLust:Number = player.maxLust() * 0.01;
                if (player.hasKeyItem("Medical Dispenser 2.0") >= 0) selfLust *= 0.5;
                if (selfLust < 1) selfLust = 1;
                selfLust = Math.round(selfLust);
                player.dynStats("lus", selfLust);
                HPChange(hpChange3, false);
            }
        }
        //Bone armor
        if (player.hasStatusEffect(StatusEffects.BoneArmor)) {
            if (player.statusEffectv1(StatusEffects.BoneArmor) <= 0) {
                player.removeStatusEffect(StatusEffects.BoneArmor);
            } else {
                player.addStatusValue(StatusEffects.BoneArmor, 1, -1);
            }
        }
        //Trance Transformation
        if (player.statStore.hasBuff("TranceTransformation")) {
            if (player.soulforce < 50) {
                player.statStore.removeBuffs("TranceTransformation");
                outputText("<b>The flow of power through you suddenly stops, as you no longer have the soulforce to sustain it.  You drop roughly to the floor, the crystal coating your [skin] cracking and fading to nothing.</b>\n\n");
            }
            //	else {
            //		outputText("<b>As your soulforce is drained you can feel the Violet Pupil Transformation's regenerative power spreading throughout your body.</b>\n\n");
            //	}
        }
        //Soul Drill
        if (player.hasStatusEffect(StatusEffects.SoulDrill1) >= 1) {
            if ((player.statusEffectv1(StatusEffects.SoulDrill1) == 1 && player.soulforce < 10) || (player.statusEffectv1(StatusEffects.SoulDrill1) == 2 && player.soulforce < 25) || (player.statusEffectv1(StatusEffects.SoulDrill1) == 3 && player.soulforce < 45) || (player.statusEffectv1(StatusEffects.SoulDrill1) == 4 && player.soulforce < 70) || (player.statusEffectv1(StatusEffects.SoulDrill1) == 5 && player.soulforce < 100)) {
                player.addStatusValue(StatusEffects.SoulDrill1, 1, -player.statusEffectv1(StatusEffects.SoulDrill1));
                outputText("<b>Your soulforce is too low to continue spinning your Soul Drill. </b>\n\n");
            }
            if ((player.statusEffectv1(StatusEffects.SoulDrill1) == 1 && player.soulforce >= 10) || (player.statusEffectv1(StatusEffects.SoulDrill1) == 2 && player.soulforce >= 25) || (player.statusEffectv1(StatusEffects.SoulDrill1) == 3 && player.soulforce >= 45) || (player.statusEffectv1(StatusEffects.SoulDrill1) == 4 && player.soulforce >= 70) || (player.statusEffectv1(StatusEffects.SoulDrill1) == 5 && player.soulforce >= 100)) {
                if (player.statusEffectv1(StatusEffects.SoulDrill1) == 1) player.soulforce -= 10;
                if (player.statusEffectv1(StatusEffects.SoulDrill1) == 2) player.soulforce -= 25;
                if (player.statusEffectv1(StatusEffects.SoulDrill1) == 3) player.soulforce -= 45;
                if (player.statusEffectv1(StatusEffects.SoulDrill1) == 4) player.soulforce -= 70;
                if (player.statusEffectv1(StatusEffects.SoulDrill1) == 5) player.soulforce -= 100;
            }
        }
        //Crinos Shape
        if (player.statStore.hasBuff("CrinosShape")) {
            if (player.wrath < mspecials.crinosshapeCost()) {
                player.statStore.removeBuffs("CrinosShape");
                outputText("<b>The flow of power through you suddenly stops, as you no longer have the wrath to sustain it.  You drop roughly to the floor, the bestial chanches slowly fading away, leaving you in your normal form.</b>\n\n");
            }
            //	else {
            //		outputText("<b>As your soulforce is drained you can feel Violet Pupil Transformation regenerative power spreading throughout your body.</b>\n\n");
            //	}
        }
        //Asura form
        if (player.statStore.hasBuff("AsuraForm")) {
            if (player.wrath < asuraformCost()) {
                player.statStore.removeBuffs("AsuraForm");
				if (player.buff("WarriorsRage").getRemainingTicks() > 9000) player.statStore.removeBuffs("WarriorsRage");
                outputText("<b>The flow of power through you suddenly stops, as you no longer have the wrath to sustain it.  Your Asura form slowly fades away, leaving you in your normal form.</b>\n\n");
            }
            //	else {
            //		outputText("<b>As your soulforce is drained you can feel the Violet Pupil Transformation's regenerative power spreading in your body.</b>\n\n");
            //	}
        }
        //Foxflame Pelt
        if (player.statStore.hasBuff("FoxflamePelt")) {
            if ((player.soulforce < 50 * soulskillCost() * soulskillcostmulti()) || (player.mana < spellCost(100 * combat.mspecials.kitsuneskill2Cost()))) {
                player.statStore.removeBuffs("FoxflamePelt");
                outputText("<b>The flow of power through you suddenly stops, as you no longer able to sustain it.  Your Foxflame Pelt slowly extinguish, leaving you in your normal form.</b>\n\n");
            }
            //	else {
            //		outputText("<b>As your soulforce is drained you can feel the Violet Pupil Transformation's regenerative power spreading in your body.</b>\n\n");
            //	}
        }
        //Scarlet Spirit Charge
        if (player.statStore.hasBuff("ScarletSpiritCharge")) {
            if (player.HP <= (player.minHP() + Math.round(player.maxHP()*0.05))) {
                player.statStore.removeBuffs("ScarletSpiritCharge");
                outputText("<b>The flow of blood within you is disturbed, causing your body to slump as the glow radiating from your [skin] dissipates back into your natural hue.</b>\n\n");
            }
            //	else {
            //		outputText("<b>As your soulforce is drained you can feel the Violet Pupil Transformation's regenerative power spreading in your body.</b>\n\n");
            //	}
        }
        //Sword Intent Aura
        if (player.statStore.hasBuff("SwordIntentAura")) {
            if ((player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) || (player.fatigue + physicalCost(10) > player.maxOverFatigue())) {
                player.statStore.removeBuffs("SwordIntentAura");
                outputText("<b>You can't no longer sustain sword intent aura, which flicker before it disperse fully.</b>\n\n");
            }
            //	else {
            //		outputText("<b>As your soulforce is drained you can feel the Violet Pupil Transformation's regenerative power spreading in your body.</b>\n\n");
            //	}
        }
        //Displacement
        if (player.hasStatusEffect(StatusEffects.Displacement)) {
            if (player.statusEffectv1(StatusEffects.Displacement) <= 0) {
                player.removeStatusEffect(StatusEffects.Displacement);
                outputText("<b>Displacement effect ended!</b>\n\n");
            } else player.addStatusValue(StatusEffects.Displacement, 1, -1);
        }
        //Everywhere and nowhere
        if (player.hasStatusEffect(StatusEffects.EverywhereAndNowhere)) {
            if (player.statusEffectv1(StatusEffects.EverywhereAndNowhere) <= 0) {
                player.removeStatusEffect(StatusEffects.EverywhereAndNowhere);
                outputText("<b>Everywhere and nowhere effect ended!</b>\n\n");
            } else player.addStatusValue(StatusEffects.EverywhereAndNowhere, 1, -1);
        }
        //Shadow Teleport
        if (player.hasStatusEffect(StatusEffects.ShadowTeleport)) {
            if (player.statusEffectv1(StatusEffects.ShadowTeleport) <= 0) {
                player.removeStatusEffect(StatusEffects.ShadowTeleport);
                outputText("<b>You sense your shadow teleport approaching its limit as the spell ends.</b>\n\n");
            } else player.addStatusValue(StatusEffects.ShadowTeleport, 1, -1);
        }
		//Blackout
        if (player.hasStatusEffect(StatusEffects.Blackout)) {
            if (player.statusEffectv1(StatusEffects.Blackout) <= 0) {
                player.removeStatusEffect(StatusEffects.Blackout);
				outputText("<b>Blackout ended!</b>\n\n");
            } else {
                player.addStatusValue(StatusEffects.Blackout, 1, -1);
            }
        }
        //Ezekiel Curse
        if (player.hasStatusEffect(StatusEffects.EzekielCurse)) {/*
            if (EvangelineFollower.EvangelineAffectionMeter >= 2 && player.hasPerk(PerkLib.EzekielBlessing)) {
                outputText("<b>You feel your lifeforce slipping away, leaving you weaker, slower, your mind reeling.  This ailment is crippling, and getting worse. Finish this fight quickly!</b>\n\n");
                player.takePhysDamage(500);
            } else */if (EvangelineFollower.EvangelineAffectionMeter >= 2) {
                outputText("<b>You feel your lifeforce slipping away, leaving you weaker, slower, your mind reeling.  You better finish this fight fast, or find a way to cure this ailment...You know you can't keep this up forever.</b>\n\n");
                if (player.maxHP() < 1000) player.takePhysDamage(player.maxHP() * 0.1);//maybe make them true damage?
                else player.takePhysDamage(100);
			}
        }
        //Flying
        if (player.isFlying()) {
			if (player.statusEffectv2(StatusEffects.Flying) == 0) {
				if (!player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) player.addStatusValue(StatusEffects.Flying, 1, -1);
			}
            if (player.statusEffectv2(StatusEffects.Flying) == 1) {
				if (player.soulforce < flyingSwordUseCost()) {
					player.removeStatusEffect(StatusEffects.Flying);
					outputText("<b>You land gently on the ground, having too little soulforce to keep yourself aloft. </b>\n\n");
				}
				else player.soulforce -= flyingSwordUseCost();
			}
			if (player.statusEffectv2(StatusEffects.Flying) == 2) {
				if (player.soulforce < flyingWithSoulforceCost()) {
					player.removeStatusEffect(StatusEffects.Flying);
					outputText("<b>You realise that your SoulForce can't sustain your flight any longer. You land lightly, sighing as the drain on your Soul stops. </b>\n\n");
				}
				else player.soulforce -= flyingWithSoulforceCost();
			}
            if (player.statusEffectv1(StatusEffects.Flying) >= 0) outputText("<b>You keep out of reach, flying circles in the air around your opponent.</b>\n\n");
            else {
				if (player.statusEffectv2(StatusEffects.Flying) == 0) {
					if (player.hasKeyItem("Jetpack") >= 0 || player.hasKeyItem("MK2 Jetpack") >= 0) {
						outputText("<b>You hear the fuel gauge beeping, and you land your mech before you run out of fuel completely.</b>\n\n");
						player.createStatusEffect(StatusEffects.CooldownJetpack, 3, 0, 0, 0);
					}
					else outputText("<b>You land, too tired to keep flying.</b>\n\n");
				}
                if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
                    player.removeStatusEffect(StatusEffects.FlyingNoStun);
                    player.removePerk(PerkLib.Resolute);
                }
                monster.removeStatusEffect(StatusEffects.MonsterAttacksDisabled);
                player.removeStatusEffect(StatusEffects.Flying);
            }
        }
		//Flying disabled
		if (player.hasStatusEffect(StatusEffects.FlyingDisabled)) {
			player.addStatusValue(StatusEffects.FlyingDisabled, 1, -1);
			if (player.statusEffectv1(StatusEffects.FlyingDisabled) <= 0) {
                player.removeStatusEffect(StatusEffects.FlyingDisabled);
                outputText("<b>You're no longer restricted from flying!</b>\n\n");
            }
		}
        // Cooldowns
        for (var i:int = 0; i < player.cooldowns.length; i++) {
            if (player.cooldowns[i] > 0) {
                player.cooldowns[i]--;
            }
        }
        //Baleful Polymorph
        if (player.hasStatusEffect(StatusEffects.CooldownBalefulPolymorph)) {
            if (player.statusEffectv1(StatusEffects.CooldownBalefulPolymorph) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownBalefulPolymorph);
            } else {
                player.addStatusValue(StatusEffects.CooldownBalefulPolymorph, 1, -1);
            }
        }
        //Ink Spray
        if (player.hasStatusEffect(StatusEffects.CooldownInkSpray)) {
            if (player.statusEffectv1(StatusEffects.CooldownInkSpray) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownInkSpray);
            } else {
                player.addStatusValue(StatusEffects.CooldownInkSpray, 1, -1);
            }
        }
        //Everywhere And Nowhere
        if (player.hasStatusEffect(StatusEffects.CooldownEveryAndNowhere)) {
            if (player.statusEffectv1(StatusEffects.CooldownEveryAndNowhere) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownEveryAndNowhere);
            } else {
                player.addStatusValue(StatusEffects.CooldownEveryAndNowhere, 1, -1);
            }
        }
        //Shadow Teleport
        if (player.hasStatusEffect(StatusEffects.CooldownShadowTeleport)) {
            if (player.statusEffectv1(StatusEffects.CooldownShadowTeleport) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownShadowTeleport);
            } else {
                player.addStatusValue(StatusEffects.CooldownShadowTeleport, 1, -1);
            }
        }
        //Flicker
        if (player.hasStatusEffect(StatusEffects.CooldownFlicker)) {
            if (player.statusEffectv1(StatusEffects.CooldownFlicker) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownFlicker);
            } else {
                player.addStatusValue(StatusEffects.CooldownFlicker, 1, -1);
            }
        }
        //Warrior Shout
        if (player.hasStatusEffect(StatusEffects.CooldownWarriorShout)) {
            if (player.statusEffectv1(StatusEffects.CooldownWarriorShout) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownWarriorShout);
            } else {
                player.addStatusValue(StatusEffects.CooldownWarriorShout, 1, -1);
            }
        }
        //Jabbing Style Periodic removal
        if (player.hasStatusEffect(StatusEffects.JabbingStyle)) {
            player.removeStatusEffect(StatusEffects.JabbingStyle);
        }
        //Play
        if (player.hasStatusEffect(StatusEffects.CooldownPlay)) {
            if (player.statusEffectv1(StatusEffects.CooldownPlay) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownPlay);
            } else {
                player.addStatusValue(StatusEffects.CooldownPlay, 1, -1);
            }
        }
        //Tail Smack
        if (player.hasStatusEffect(StatusEffects.CooldownTailSmack)) {
            if (player.statusEffectv1(StatusEffects.CooldownTailSmack) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownTailSmack);
            } else {
                player.addStatusValue(StatusEffects.CooldownTailSmack, 1, -1);
            }
        }
        //Stone Claw
        if (player.hasStatusEffect(StatusEffects.CooldownStoneClaw)) {
            if (player.statusEffectv1(StatusEffects.CooldownStoneClaw) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownStoneClaw);
            } else {
                player.addStatusValue(StatusEffects.CooldownStoneClaw, 1, -1);
            }
        }
        //Stone Fist
        if (player.hasStatusEffect(StatusEffects.CooldownStoneFist)) {
            if (player.statusEffectv1(StatusEffects.CooldownStoneFist) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownStoneFist);
            } else {
                player.addStatusValue(StatusEffects.CooldownStoneFist, 1, -1);
            }
        }
        //Tail Slam
        if (player.hasStatusEffect(StatusEffects.CooldownTailSlam)) {
            if (player.statusEffectv1(StatusEffects.CooldownTailSlam) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownTailSlam);
            } else {
                player.addStatusValue(StatusEffects.CooldownTailSlam, 1, -1);
            }
        }
        //Tail Cleave
        if (player.hasStatusEffect(StatusEffects.CooldownTailCleave)) {
            if (player.statusEffectv1(StatusEffects.CooldownTailCleave) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownTailCleave);
            } else {
                player.addStatusValue(StatusEffects.CooldownTailCleave, 1, -1);
            }
        }
        //Hurricane
        if (player.hasStatusEffect(StatusEffects.CooldownHurricane)) {
            if (player.statusEffectv1(StatusEffects.CooldownHurricane) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownHurricane);
            } else {
                player.addStatusValue(StatusEffects.CooldownHurricane, 1, -1);
            }
        }
        //Wind Scythe
        if (player.hasStatusEffect(StatusEffects.CooldownWindScythe)) {
            if (player.statusEffectv1(StatusEffects.CooldownWindScythe) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownWindScythe);
            } else {
                player.addStatusValue(StatusEffects.CooldownWindScythe, 1, -1);
            }
        }
        //Knowledge overload
        if (player.hasStatusEffect(StatusEffects.CooldownKnowledgeOverload)) {
            if (player.statusEffectv1(StatusEffects.CooldownKnowledgeOverload) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownKnowledgeOverload);
            } else {
                player.addStatusValue(StatusEffects.CooldownKnowledgeOverload, 1, -1);
            }
        }
        //Provoke
        if (player.hasStatusEffect(StatusEffects.CooldownProvoke)) {
            if (player.statusEffectv1(StatusEffects.CooldownProvoke) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownProvoke);
            } else {
                player.addStatusValue(StatusEffects.CooldownProvoke, 1, -1);
            }
        }
        //Weird words
        if (player.hasStatusEffect(StatusEffects.CooldownWeirdWords)) {
            if (player.statusEffectv1(StatusEffects.CooldownWeirdWords) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownWeirdWords);
            } else {
                player.addStatusValue(StatusEffects.CooldownWeirdWords, 1, -1);
            }
        }
        //Wing Buffet
        if (player.hasStatusEffect(StatusEffects.CooldownWingBuffet)) {
            if (player.statusEffectv1(StatusEffects.CooldownWingBuffet) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownWingBuffet);
            } else {
                player.addStatusValue(StatusEffects.CooldownWingBuffet, 1, -1);
            }
        }
        //Kick
        if (player.hasStatusEffect(StatusEffects.CooldownKick)) {
            if (player.statusEffectv1(StatusEffects.CooldownKick) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownKick);
            } else {
                player.addStatusValue(StatusEffects.CooldownKick, 1, -1);
            }
        }
        //Freezing Breath Fenrir
        if (player.hasStatusEffect(StatusEffects.CooldownFreezingBreath)) {
            if (player.statusEffectv1(StatusEffects.CooldownFreezingBreath) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownFreezingBreath);
            } else {
                player.addStatusValue(StatusEffects.CooldownFreezingBreath, 1, -1);
            }
        }
        //Freezing Breath Yeti
        if (player.hasStatusEffect(StatusEffects.CooldownFreezingBreathYeti)) {
            if (player.statusEffectv1(StatusEffects.CooldownFreezingBreathYeti) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownFreezingBreathYeti);
            } else {
                player.addStatusValue(StatusEffects.CooldownFreezingBreathYeti, 1, -1);
            }
        }
        //Phoenix Fire Breath
        if (player.hasStatusEffect(StatusEffects.CooldownPhoenixFireBreath)) {
            if (player.statusEffectv1(StatusEffects.CooldownPhoenixFireBreath) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownPhoenixFireBreath);
            } else {
                player.addStatusValue(StatusEffects.CooldownPhoenixFireBreath, 1, -1);
            }
        }
        //Green Covenant
        if (player.hasStatusEffect(StatusEffects.CooldownGreenCovenant)) {
            if (player.statusEffectv1(StatusEffects.CooldownGreenCovenant) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownGreenCovenant);
            } else {
                player.addStatusValue(StatusEffects.CooldownGreenCovenant, 1, -1);
            }
        }
        //Mana Shot
        if (player.hasStatusEffect(StatusEffects.CooldownManaShot)) {
            if (player.statusEffectv1(StatusEffects.CooldownManaShot) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownManaShot);
            } else {
                player.addStatusValue(StatusEffects.CooldownManaShot, 1, -1);
            }
        }
        //Mana Barrage
        if (player.hasStatusEffect(StatusEffects.CooldownManaBarrage)) {
            if (player.statusEffectv1(StatusEffects.CooldownManaBarrage) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownManaBarrage);
            } else {
                player.addStatusValue(StatusEffects.CooldownManaBarrage, 1, -1);
            }
        }
        //Charged Shot
        if (player.hasStatusEffect(StatusEffects.CooldownChargedShot)) {
            if (player.statusEffectv1(StatusEffects.CooldownChargedShot) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownChargedShot);
            } else {
                player.addStatusValue(StatusEffects.CooldownChargedShot, 1, -1);
            }
        }
        //Hydra Acid Breath
        if (player.hasStatusEffect(StatusEffects.CooldownHydraAcidBreath)) {
            if (player.statusEffectv1(StatusEffects.CooldownHydraAcidBreath) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownHydraAcidBreath);
            } else {
                player.addStatusValue(StatusEffects.CooldownHydraAcidBreath, 1, -1);
            }
        }
        //Hungering cold
        if (player.hasStatusEffect(StatusEffects.CooldownHungeringCold)) {
            if (player.statusEffectv1(StatusEffects.CooldownHungeringCold) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownHungeringCold);
            } else {
                player.addStatusValue(StatusEffects.CooldownHungeringCold, 1, -1);
            }
        }
        //Frozen kiss
        if (player.hasStatusEffect(StatusEffects.CooldownFrozenKiss)) {
            if (player.statusEffectv1(StatusEffects.CooldownFrozenKiss) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownFrozenKiss);
            } else {
                player.addStatusValue(StatusEffects.CooldownFrozenKiss, 1, -1);
            }
        }
        //Illusion
        if (player.hasStatusEffect(StatusEffects.CooldownIllusion)) {
            if (player.statusEffectv1(StatusEffects.CooldownIllusion) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownIllusion);
            } else {
                player.addStatusValue(StatusEffects.CooldownIllusion, 1, -1);
            }
        }
        if (player.hasStatusEffect(StatusEffects.Illusion)) {
            if (player.statusEffectv1(StatusEffects.Illusion) <= 0) {
                player.removeStatusEffect(StatusEffects.Illusion);
            } else {
                player.addStatusValue(StatusEffects.Illusion, 1, -1);
            }
        }
        //Terror
        if (player.hasStatusEffect(StatusEffects.CooldownTerror)) {
            if (player.statusEffectv1(StatusEffects.CooldownTerror) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownTerror);
            } else {
                player.addStatusValue(StatusEffects.CooldownTerror, 1, -1);
            }
        }
        //Fascinate
        if (player.hasStatusEffect(StatusEffects.CooldownFascinate)) {
            if (player.statusEffectv1(StatusEffects.CooldownFascinate) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownFascinate);
            } else {
                player.addStatusValue(StatusEffects.CooldownFascinate, 1, -1);
            }
        }
        //Compelling Aria
        if (player.hasStatusEffect(StatusEffects.CooldownCompellingAria)) {
            if (player.statusEffectv1(StatusEffects.CooldownCompellingAria) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownCompellingAria);
            } else {
                player.addStatusValue(StatusEffects.CooldownCompellingAria, 1, -1);
            }
        }
        //Oni Rampage
        if (player.hasStatusEffect(StatusEffects.CooldownOniRampage)) {
            if (player.statusEffectv1(StatusEffects.CooldownOniRampage) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownOniRampage);
            } else {
                player.addStatusValue(StatusEffects.CooldownOniRampage, 1, -1);
            }
        }
        //Milk Blast
        if (player.hasStatusEffect(StatusEffects.CooldownMilkBlast) && player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3) {
            if (player.statusEffectv1(StatusEffects.CooldownMilkBlast) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownMilkBlast);
            } else {
                player.addStatusValue(StatusEffects.CooldownMilkBlast, 1, -1);
            }
        }
        //Cum Cannon
        if (player.hasStatusEffect(StatusEffects.CooldownCumCannon) && player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3) {
            if (player.statusEffectv1(StatusEffects.CooldownCumCannon) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownCumCannon);
            } else {
                player.addStatusValue(StatusEffects.CooldownCumCannon, 1, -1);
            }
        }
        //Plasma blast
        if (player.hasStatusEffect(StatusEffects.CooldownPlasmaBlast) && (player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3 || player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3)) {
            if (player.statusEffectv1(StatusEffects.CooldownPlasmaBlast) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownPlasmaBlast);
            } else {
                player.addStatusValue(StatusEffects.CooldownPlasmaBlast, 1, -1);
            }
        }
        //Prank
        if (player.hasStatusEffect(StatusEffects.CooldownPrank)) {
            if (player.statusEffectv1(StatusEffects.CooldownPrank) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownPrank);
            } else {
                player.addStatusValue(StatusEffects.CooldownPrank, 1, -1);
            }
        }
        //Tactical Distraction
        if (player.hasStatusEffect(StatusEffects.CooldownTDistraction)) {
            if (player.statusEffectv1(StatusEffects.CooldownTDistraction) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownTDistraction);
            } else {
                player.addStatusValue(StatusEffects.CooldownTDistraction, 1, -1);
            }
        }
        //Tremor
        if (player.hasStatusEffect(StatusEffects.CooldownTremor)) {
            if (player.statusEffectv1(StatusEffects.CooldownTremor) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownTremor);
            } else {
                player.addStatusValue(StatusEffects.CooldownTremor, 1, -1);
            }
        }
        //Tremor
        if (player.hasStatusEffect(StatusEffects.CooldownThunderGore)) {
            if (player.statusEffectv1(StatusEffects.CooldownThunderGore) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownThunderGore);
            } else {
                player.addStatusValue(StatusEffects.CooldownThunderGore, 1, -1);
            }
        }
        //Charging
        if (player.hasStatusEffect(StatusEffects.CooldownCharging)) {
            if (player.statusEffectv1(StatusEffects.CooldownCharging) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownCharging);
            } else {
                player.addStatusValue(StatusEffects.CooldownCharging, 1, -1);
            }
        }
        //Net
        if (player.hasStatusEffect(StatusEffects.CooldownNet)) {
            if (player.statusEffectv1(StatusEffects.CooldownNet) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownNet);
            } else {
                player.addStatusValue(StatusEffects.CooldownNet, 1, -1);
            }
        }
        //Pin Down
        if (player.hasStatusEffect(StatusEffects.CooldownPinDown)) {
            if (player.statusEffectv1(StatusEffects.CooldownPinDown) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownPinDown);
            } else {
                player.addStatusValue(StatusEffects.CooldownPinDown, 1, -1);
            }
        }
        //Telekinetic Grab
        if (player.hasStatusEffect(StatusEffects.CooldownTelekineticGrab)) {
            if (player.statusEffectv1(StatusEffects.CooldownTelekineticGrab) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownTelekineticGrab);
            } else {
                player.addStatusValue(StatusEffects.CooldownTelekineticGrab, 1, -1);
            }
        }
        //Tazer
        if (player.hasStatusEffect(StatusEffects.CooldownTazer)) {
            if (player.statusEffectv1(StatusEffects.CooldownTazer) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownTazer);
            } else {
                player.addStatusValue(StatusEffects.CooldownTazer, 1, -1);
            }
        }
        //Dynapunch Glove
        if (player.hasStatusEffect(StatusEffects.CooldownDynapunchGlove)) {
            if (player.statusEffectv1(StatusEffects.CooldownDynapunchGlove) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownDynapunchGlove);
            } else {
                player.addStatusValue(StatusEffects.CooldownDynapunchGlove, 1, -1);
            }
        }
        //Whitefire Beam Cannon
        if (player.hasStatusEffect(StatusEffects.CooldownWhitefireBeamCannon)) {
            if (player.statusEffectv1(StatusEffects.CooldownWhitefireBeamCannon) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownWhitefireBeamCannon);
            } else {
                player.addStatusValue(StatusEffects.CooldownWhitefireBeamCannon, 1, -1);
            }
        }
        //Snowball Generator
        if (player.hasStatusEffect(StatusEffects.CooldownSnowballGenerator)) {
            if (player.statusEffectv1(StatusEffects.CooldownSnowballGenerator) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownSnowballGenerator);
            } else {
                player.addStatusValue(StatusEffects.CooldownSnowballGenerator, 1, -1);
            }
        }
        //Raijin Blaster
        if (player.hasStatusEffect(StatusEffects.CooldownRaijinBlaster)) {
            if (player.statusEffectv1(StatusEffects.CooldownRaijinBlaster) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownRaijinBlaster);
            } else {
                player.addStatusValue(StatusEffects.CooldownRaijinBlaster, 1, -1);
            }
        }
        //Gravity Shots
        if (player.hasStatusEffect(StatusEffects.CooldownGravityShots)) {
            if (player.statusEffectv1(StatusEffects.CooldownGravityShots) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownGravityShots);
            } else {
                player.addStatusValue(StatusEffects.CooldownGravityShots, 1, -1);
            }
        }
        //Stimpack Dispenser
        if (player.hasStatusEffect(StatusEffects.CooldownStimpackDispenser)) {
            if (player.statusEffectv1(StatusEffects.CooldownStimpackDispenser) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownStimpackDispenser);
            } else {
                player.addStatusValue(StatusEffects.CooldownStimpackDispenser, 1, -1);
            }
        }
        //Lustnade Launcher
        if (player.hasStatusEffect(StatusEffects.CooldownLustnadeLauncher)) {
            if (player.statusEffectv1(StatusEffects.CooldownLustnadeLauncher) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownLustnadeLauncher);
            } else {
                player.addStatusValue(StatusEffects.CooldownLustnadeLauncher, 1, -1);
            }
        }
        //Jetpack
        if (player.hasStatusEffect(StatusEffects.CooldownJetpack)) {
            if (player.statusEffectv1(StatusEffects.CooldownJetpack) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownJetpack);
            } else {
                player.addStatusValue(StatusEffects.CooldownJetpack, 1, -1);
            }
        }
		//Mutant Incubus Venom
		if (player.hasStatusEffect(StatusEffects.MutantIncubusVenom)) {
            if (player.statusEffectv1(StatusEffects.MutantIncubusVenom) <= 0) {
                player.removeStatusEffect(StatusEffects.MutantIncubusVenom);
            } else {
                player.addStatusValue(StatusEffects.MutantIncubusVenom, 1, -1);
				player.takePoisonDamage(player.tou);
            }
        }
		//Blacken
		if (monster.hasStatusEffect(StatusEffects.Blacken)) {
            if (monster.statusEffectv1(StatusEffects.Blacken) <= 0) {
                monster.removeStatusEffect(StatusEffects.Blacken);
				player.removeStatusEffect(StatusEffects.Blind);
				player.buff("Black Gas").remove();
            } else {
                monster.addStatusValue(StatusEffects.Blacken, 1, -1);
				player.takePoisonDamage(player.tou);
            }
        }
        //Companion Boosting PC Armor Value
        if (player.hasStatusEffect(StatusEffects.CompBoostingPCArmorValue)) player.removeStatusEffect(StatusEffects.CompBoostingPCArmorValue);
        //Possess
        if (player.hasStatusEffect(StatusEffects.CooldownPossess)) {
            if (player.statusEffectv1(StatusEffects.CooldownPossess) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownPossess);
            } else {
                player.addStatusValue(StatusEffects.CooldownPossess, 1, -1);
            }
        }
        //Feline Curse
        if (player.hasStatusEffect(StatusEffects.CooldownFelineCurse)) {
            if (player.statusEffectv1(StatusEffects.CooldownFelineCurse) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownFelineCurse);
            } else {
                player.addStatusValue(StatusEffects.CooldownFelineCurse, 1, -1);
            }
        }
        //Infernal Claw
        if (player.hasStatusEffect(StatusEffects.CooldownInfernalClaw)) {
            if (player.statusEffectv1(StatusEffects.CooldownInfernalClaw) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownInfernalClaw);
            } else {
                player.addStatusValue(StatusEffects.CooldownInfernalClaw, 1, -1);
            }
        }
        //Spectral Scream
        if (player.hasStatusEffect(StatusEffects.CooldownSpectralScream)) {
            if (player.statusEffectv1(StatusEffects.CooldownSpectralScream) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownSpectralScream);
            } else {
                player.addStatusValue(StatusEffects.CooldownSpectralScream, 1, -1);
            }
        }
        //Punishing Kick
        if (player.hasStatusEffect(StatusEffects.CooldownPunishingKick)) {
            if (player.statusEffectv1(StatusEffects.CooldownPunishingKick) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownPunishingKick);
            } else {
                player.addStatusValue(StatusEffects.CooldownPunishingKick, 1, -1);
            }
        }
        //Eclipsing shadow
        if (player.hasStatusEffect(StatusEffects.CooldownEclipsingShadow)) {
            if (player.statusEffectv1(StatusEffects.CooldownEclipsingShadow) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownEclipsingShadow);
            } else {
                player.addStatusValue(StatusEffects.CooldownEclipsingShadow, 1, -1);
            }
        }
        //Sonic scream
        if (player.hasStatusEffect(StatusEffects.CooldownSonicScream)) {
            if (player.statusEffectv1(StatusEffects.CooldownSonicScream) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownSonicScream);
            } else {
                player.addStatusValue(StatusEffects.CooldownSonicScream, 1, -1);
            }
        }
        //Sing Captivate
        if (player.hasStatusEffect(StatusEffects.CooldownSingCaptivate)) {
            if (player.statusEffectv1(StatusEffects.CooldownSingCaptivate) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownSingCaptivate);
            } else {
                player.addStatusValue(StatusEffects.CooldownSingCaptivate, 1, -1);
            }
        }
        //Tornado Strike
        if (player.hasStatusEffect(StatusEffects.CooldownTornadoStrike)) {
            if (player.statusEffectv1(StatusEffects.CooldownTornadoStrike) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownTornadoStrike);
            } else {
                player.addStatusValue(StatusEffects.CooldownTornadoStrike, 1, -1);
            }
        }
        //Chaos beams
        if (player.hasStatusEffect(StatusEffects.CooldownChaosBeams)) {
            if (player.statusEffectv1(StatusEffects.CooldownChaosBeams) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownChaosBeams);
            } else {
                player.addStatusValue(StatusEffects.CooldownChaosBeams, 1, -1);
            }
        }
        //Baleful Polymorph
        if (player.hasStatusEffect(StatusEffects.CooldownBalefulPolymorph)) {
            if (player.statusEffectv1(StatusEffects.CooldownBalefulPolymorph) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownBalefulPolymorph);
            } else {
                player.addStatusValue(StatusEffects.CooldownBalefulPolymorph, 1, -1);
            }
        }
        //Second Wind Regen
        if (player.hasStatusEffect(StatusEffects.SecondWindRegen)) {
            if (player.statusEffectv2(StatusEffects.SecondWindRegen) <= 0) {
                player.removeStatusEffect(StatusEffects.SecondWindRegen);
                outputText("<b></b>\n\n");
            } else player.addStatusValue(StatusEffects.SecondWindRegen, 2, -1);
        }
		if (player.statusEffectv3(StatusEffects.CombatFollowerZenji) > 0 && (player.statusEffectv3(StatusEffects.CombatFollowerZenji) == 1 || player.statusEffectv3(StatusEffects.CombatFollowerZenji) == 3)) player.addStatusValue(StatusEffects.CombatFollowerZenji, 3, 1);
		if (player.statusEffectv4(StatusEffects.CombatFollowerZenji) > 1) player.addStatusValue(StatusEffects.CombatFollowerZenji, 4, -1);
		if (player.statusEffectv4(StatusEffects.CombatFollowerAyane) > 1) player.addStatusValue(StatusEffects.CombatFollowerAyane, 4, -1);
        if (player.hasStatusEffect(StatusEffects.BladeDance)) player.removeStatusEffect(StatusEffects.BladeDance);
        if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) player.removeStatusEffect(StatusEffects.ResonanceVolley);
        if (player.hasStatusEffect(StatusEffects.Defend)) player.removeStatusEffect(StatusEffects.Defend);
        regeneration1(true);
        if (player.lust >= player.maxOverLust() && !player.statStore.hasBuff("Supercharged") && !tyrantiaTrainingExtension()) doNext(endLustLoss);
        if (player.HP <= player.minHP()) doNext(endHpLoss);
		if (monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
    }
	
	private function repeatArcaneVenom(dmg:Number, subtype:Number, poisonele:Number):void {
		var randomCritAV:Boolean = false;
		if (player.hasPerk(PerkLib.VegetalAffinity)) dmg *= 1.5;
		if (player.hasPerk(PerkLib.GreenMagic)) dmg *= 2;
		if (player.hasStatusEffect(StatusEffects.GreenCovenant)) dmg *= 2;
		//Determine if critical tease!
		var critChanceAV:int = 5;
		critChanceAV += teases.combatTeaseCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChanceAV = 0;
		if (rand(100) < critChanceAV) {
			randomCritAV = true;
			dmg *= 1.75;
		}
		if (player.hasPerk(PerkLib.RacialParagon)) dmg *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) dmg *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) dmg *= 2;

		var arve:Number = 1;
		if (player.hasPerk(PerkLib.ArcaneVenom)) arve += AbstractSpell.stackingArcaneVenom();
		while (arve-->0) {
			if (randomCritAV) repeatArcaneVenom2(dmg, 0, poisonele);
			else repeatArcaneVenom2(dmg, 0, poisonele, false);
		}
	}
	private function repeatArcaneVenom2(dmg:Number, subtype:Number, poisonele:Number, crit:Boolean = true):void {
		if (poisonele != 0) doPoisonDamage(poisonele, true, true);
		dmg = Math.round(dmg * monster.lustVuln);
		monster.teased(dmg, false);
		if (crit) outputText(" <b>Critical!</b> " );
		if (subtype == 1) combat.teaseXP((1 + combat.bonusExpAfterSuccesfullTease()*2));
		else combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if (player.hasPerk(PerkLib.VerdantLeech)) {
			if (monster.lustVuln != 0 && !monster.hasPerk(PerkLib.EnemyTrueAngel)) monster.lustVuln += 0.025;
			HPChange(Math.round(player.maxHP() * 0.01), false);
		}
	}
	
	public function recoveryOfResourcesImpl():void {
		wrathregeneration1();
		fatigueRecovery1();
		manaregeneration1();
		soulforceregeneration1();
		venomCombatRecharge1();
	}

    public function regeneration(minutes:Number = 1):void {
		var healingPercent:Number = 0;
		healingPercent += PercentBasedRegeneration();
        if (player.armor == armors.GOOARMR) healingPercent += (SceneLib.valeria.valeriaFluidsEnabled() ? (flags[kFLAGS.VALERIA_FLUIDS] < 50 ? flags[kFLAGS.VALERIA_FLUIDS] / 16 : 3) : 3);
        if (healingPercent > maximumRegeneration()) healingPercent = maximumRegeneration();
        HPChange(Math.round(((player.maxHP() * healingPercent / 100) + nonPercentBasedRegeneration()) * 0.02), false);
	}
	public function regeneration1(combat:Boolean = true):void {
        var healingPercent:Number;
        if (combat) {
            var negativeHPRegen:Number = 0;
			healingPercent = 0;
            healingPercent += PercentBasedRegeneration();
            if (player.armor == armors.GOOARMR) healingPercent += (SceneLib.valeria.valeriaFluidsEnabled() ? (flags[kFLAGS.VALERIA_FLUIDS] < 50 ? flags[kFLAGS.VALERIA_FLUIDS] / 25 : 2) : 2);
            if (isNearWater() && (player.hasPerk(PerkLib.AquaticAffinity) || player.hasPerk(PerkLib.AffinityUndine)) && player.necklaceName == "Magic coral and pearl necklace") healingPercent += 1;
            if (player.statStore.hasBuff("CrinosShape") && player.hasPerk(PerkLib.ImprovingNaturesBlueprintsApexPredator) && !player.hasStatusEffect(StatusEffects.WereraceRegenerationDisabled)) {
				if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 3) healingPercent += 2;
				healingPercent += 2;
			}
            if (player.hasPerk(PerkLib.Sanctuary)) healingPercent += 1;
            if (player.shield == shields.SANCTYL) healingPercent += ((player.corruptionTolerance - player.cor) / (100 + player.corruptionTolerance)) * 4;
            if (player.shield == shields.SANCTYD) healingPercent += (player.cor / (100 + player.corruptionTolerance)) * 4;
            if (player.hasStatusEffect(StatusEffects.SecondWindRegen)) healingPercent += 5;
            if (player.hasStatusEffect(StatusEffects.Cauterize)) {
                healingPercent += 1.5;
                if (player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 1) healingPercent += 0.5;
                if (player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 2) healingPercent += 0.5;
                if (player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 3) healingPercent += 0.5;
            }
            if (player.headJewelry == headjewelries.CUNDKIN && player.HP < 1) healingPercent += 1;
            if (CombatAbilities.Overlimit.isActive() || CombatAbilities.FieryRage.isActive()) healingPercent -= 10;
			if (player.hasStatusEffect(StatusEffects.GreenCovenant)) healingPercent += 25;
            if (player.hasPerk(PerkLib.Ferocity) && player.HP < 1) negativeHPRegen -= 1;
            if ((player.hasPerk(PerkLib.Diehard) || player.hasPerk(PerkLib.GreaterDiehardEx)) && !player.hasPerk(PerkLib.EpicDiehard) && player.HP < 1) negativeHPRegen -= 1;
            if (player.perkv1(IMutationsLib.LizanMarrowIM) >= 3 && player.HP < 1) negativeHPRegen -= 1;
			if (negativeHPRegen < 0 && !player.hasPerk(PerkLib.BloodDemonToughness)) healingPercent += negativeHPRegen;
			if (player.hasStatusEffect(StatusEffects.CombatWounds) && player.hasMutation(IMutationsLib.LizanMarrowIM) && player.perkv1(IMutationsLib.LizanMarrowIM) > 3) {
				if (player.statusEffectv1(StatusEffects.CombatWounds) > 0.005) player.addStatusValue(StatusEffects.CombatWounds, 1, -0.005);
				else player.removeStatusEffect(StatusEffects.CombatWounds);
			}
            if (healingPercent > maximumRegeneration()) healingPercent = maximumRegeneration();
            HPChange(Math.round((player.maxHP() * healingPercent / 100) + nonPercentBasedRegeneration()), false);
        }
		else {
			healingPercent = 0;
            healingPercent += PercentBasedRegeneration() * 2;
            if (player.armor == armors.GOOARMR) healingPercent += (SceneLib.valeria.valeriaFluidsEnabled() ? (flags[kFLAGS.VALERIA_FLUIDS] < 50 ? flags[kFLAGS.VALERIA_FLUIDS] / 16 : 3) : 3);
            if (healingPercent > (maximumRegeneration() * 2)) healingPercent = (maximumRegeneration() * 2);
            HPChange(Math.round(((player.maxHP() * healingPercent / 100) + nonPercentBasedRegeneration()) * 2), false);
        }
    }

    public function PercentBasedRegeneration():Number {
        var maxPercentRegen:Number = 0;
        if (player.hunger >= 25 || flags[kFLAGS.HUNGER_ENABLED] <= 0) {
            if (player.hasPerk(PerkLib.Regeneration)) maxPercentRegen += 0.5;
            if (player.hasPerk(PerkLib.Regeneration2)) maxPercentRegen += 0.5;
            if (player.hasPerk(PerkLib.Regeneration3)) maxPercentRegen += 0.5;
            if (player.hasPerk(PerkLib.Regeneration4)) maxPercentRegen += 0.5;
            if (player.hasPerk(PerkLib.Regeneration5)) maxPercentRegen += 0.5;
            if (player.hasPerk(PerkLib.Regeneration6)) maxPercentRegen += 0.5;
        }
		if (flags[kFLAGS.HUNGER_ENABLED] <= 0 && !player.hasPerk(PerkLib.EndlessHunger) && player.hasPerk(PerkLib.AxillaryVenomGlands) && player.tailVenom < player.maxVenom()) maxPercentRegen -= 1;
		//if (player.hasStatusEffect(StatusEffects.GnomeHomeBuff) && player.statusEffectv1(StatusEffects.GnomeHomeBuff) == 1) maxPercentRegen += 15;
        if (player.armor == armors.NURSECL) maxPercentRegen += 0.5;
        if (player.armor == armors.BLIZZ_K) {
            if (!player.hasPerk(PerkLib.ColdAffinity)) maxPercentRegen -= 10;
            if (player.isRaceCached(Races.YUKIONNA)) maxPercentRegen += 5;
        }
		if (player.weapon == weapons.BCLAWS) {
            if (!player.hasPerk(PerkLib.ColdAffinity)) maxPercentRegen -= 2;
            if (player.isRaceCached(Races.YUKIONNA)) maxPercentRegen += 1;
        }
        if (player.weapon == weapons.SESPEAR) maxPercentRegen += 2;
        if (player.hasPerk(PerkLib.LustyRegeneration)) maxPercentRegen += 0.5;
        if (player.hasPerk(PerkLib.LizanRegeneration)) maxPercentRegen += 1.5;
        if (player.perkv1(IMutationsLib.LizanMarrowIM) >= 1) maxPercentRegen += 0.5 * player.perkv1(IMutationsLib.LizanMarrowIM);
		if (player.perkv1(IMutationsLib.LizanMarrowIM) == 3 && player.HP < (player.maxHP() * 0.25)) maxPercentRegen += 1.5;
		if (player.perkv1(IMutationsLib.LizanMarrowIM) == 4) {
			if (player.HP < (player.maxHP() * 0.6)) maxPercentRegen += 2;
			if (player.HP < (player.maxHP() * 0.2)) maxPercentRegen += 2;
		}
		if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 3) maxPercentRegen += 1;
        if (player.perkv1(IMutationsLib.EclipticMindIM) >= 3) maxPercentRegen += 1.5;
        if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 1 && !player.hasStatusEffect(StatusEffects.WereraceRegenerationDisabled)) {
			var hbr:Number = 0.5;
			var mp:Number = 2;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 4) mp -= 1;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) mp += 2;
			if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 2) hbr += ((player.perkv1(IMutationsLib.FerasBirthrightIM) - 1) * 0.5);
			if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 3 && player.statStore.hasBuff("CrinosShape")) hbr *= 2;
			maxPercentRegen += (hbr * mp);
		}
		if (player.hasStatusEffect(StatusEffects.RegenSurge)) {
			maxPercentRegen += 20;
			if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 4) maxPercentRegen += 10;
		}
		if (player.perkv1(IMutationsLib.HumanThyroidGlandIM) >= 1 && player.racialScore(Races.HUMAN) > 17) maxPercentRegen += 1;
		if (player.perkv1(IMutationsLib.HumanThyroidGlandIM) >= 2 && player.racialScore(Races.HUMAN) > 17) maxPercentRegen += 1;
		if (player.perkv1(IMutationsLib.HumanThyroidGlandIM) >= 3 && player.racialScore(Races.HUMAN) > 17) maxPercentRegen += 1;
		if (player.hasStatusEffect(StatusEffects.PostfluidIntakeRegeneration)) maxPercentRegen += 1 * (player.perkv1(IMutationsLib.SlimeMetabolismIM)-2);
        if (player.hasPerk(PerkLib.HydraRegeneration) && !player.hasStatusEffect(StatusEffects.HydraRegenerationDisabled)) maxPercentRegen += 1 * player.statusEffectv1(StatusEffects.HydraTailsPlayer);
        if (player.hasPerk(PerkLib.IcyFlesh)) maxPercentRegen += 1;
        if (player.hasPerk(PerkLib.FleshBodyApprenticeStage)) maxPercentRegen += 0.5 * player.humanBodyCultivators();
        if (player.hasPerk(PerkLib.FleshBodyWarriorStage)) maxPercentRegen += 0.5 * player.humanBodyCultivators();
        if (player.hasPerk(PerkLib.FleshBodyElderStage)) maxPercentRegen += 0.5 * player.humanBodyCultivators();
        if (player.hasPerk(PerkLib.FleshBodyOverlordStage)) maxPercentRegen += 0.5 * player.humanBodyCultivators();
        if (player.hasPerk(PerkLib.FleshBodyTyrantStage)) maxPercentRegen += 0.5 * player.humanBodyCultivators();
		if (player.hasPerk(PerkLib.BloodDemonToughness)) maxPercentRegen += 0.5;
		if (player.hasPerk(PerkLib.BloodDemonIntelligence)) maxPercentRegen += 0.5;
		if (player.hasPerk(PerkLib.BloodDemonWisdom)) maxPercentRegen += 0.5;
        if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) maxPercentRegen += 0.5;
        if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) maxPercentRegen += 0.5;
        if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) maxPercentRegen += 0.5;
        if (player.hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) maxPercentRegen += 0.5;
        if (player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) maxPercentRegen += 0.5;
        if (player.hasKeyItem("M.G.S. bracer") >= 0) maxPercentRegen += 2;
        if ((player.internalChimeraRating() >= 1 && player.hunger < 1 && flags[kFLAGS.HUNGER_ENABLED] > 0) || (player.internalChimeraRating() >= 1 && flags[kFLAGS.HUNGER_ENABLED] <= 0)) maxPercentRegen -= (0.5 * player.internalChimeraRating());
        if (maxPercentRegen > maximumRegeneration()) maxPercentRegen = maximumRegeneration();
		return maxPercentRegen;
    }

    public function nonPercentBasedRegeneration():Number {
        var maxNonPercentRegen:Number = 0;
        if (player.hasPerk(PerkLib.Lifeline)) maxNonPercentRegen += 3 * player.level * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.ImprovedLifeline)) maxNonPercentRegen += 4 * player.level * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.GreaterLifeline)) maxNonPercentRegen += 6 * player.level * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.EpicLifeline)) maxNonPercentRegen += 8 * player.level * (1 + player.newGamePlusMod());
		if (player.perkv1(IMutationsLib.HumanParathyroidGlandIM) >= 1 && player.racialScore(Races.HUMAN) > 17) maxNonPercentRegen += 10 * player.level * (1 + player.newGamePlusMod());
		if (player.perkv1(IMutationsLib.HumanParathyroidGlandIM) >= 2 && player.racialScore(Races.HUMAN) > 17) maxNonPercentRegen += 10 * player.level * (1 + player.newGamePlusMod());
		if (player.perkv1(IMutationsLib.HumanParathyroidGlandIM) >= 3 && player.racialScore(Races.HUMAN) > 17) maxNonPercentRegen += 20 * player.level * (1 + player.newGamePlusMod());
        if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) maxNonPercentRegen *= 2;
        return maxNonPercentRegen;
    }

    public function maximumRegeneration():Number {
        var maxRegen:Number = 2;
        if (player.hasPerk(PerkLib.LizanRegeneration)) maxRegen += 1.5;
        if (player.perkv1(IMutationsLib.LizanMarrowIM) >= 1) maxRegen += 0.5 * player.perkv1(IMutationsLib.LizanMarrowIM);
        if (player.perkv1(IMutationsLib.LizanMarrowIM) == 3 && player.HP < (player.maxHP() * 0.25)) maxRegen += 1.5;
		if (player.perkv1(IMutationsLib.LizanMarrowIM) == 4) {
			if (player.HP < (player.maxHP() * 0.6)) maxRegen += 2;
			if (player.HP < (player.maxHP() * 0.2)) maxRegen += 2;
		}
		if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 3) maxRegen += 1;
        if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 1 && !player.hasStatusEffect(StatusEffects.WereraceRegenerationDisabled)) {
			var hbr:Number = 0.5;
			var mp:Number = 2;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 4) mp -= 1;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) mp += 2;
			if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 2) hbr += ((player.perkv1(IMutationsLib.FerasBirthrightIM) - 1) * 0.5);
			if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 3 && player.statStore.hasBuff("CrinosShape")) hbr *= 2;
			maxRegen += (hbr * mp);
		}
		if (player.hasStatusEffect(StatusEffects.RegenSurge)) {
			maxRegen += 20;
			if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 4) maxRegen += 10;
		}
		if (player.perkv1(IMutationsLib.HumanThyroidGlandIM) >= 1 && player.racialScore(Races.HUMAN) > 17) maxRegen += 1;
		if (player.perkv1(IMutationsLib.HumanThyroidGlandIM) >= 2 && player.racialScore(Races.HUMAN) > 17) maxRegen += 1;
		if (player.perkv1(IMutationsLib.HumanThyroidGlandIM) >= 3 && player.racialScore(Races.HUMAN) > 17) maxRegen += 1;
		if (player.hasStatusEffect(StatusEffects.PostfluidIntakeRegeneration)) maxRegen += 1 * (player.perkv1(IMutationsLib.SlimeMetabolismIM)-2);
        if (player.hasPerk(PerkLib.HydraRegeneration) && !player.hasStatusEffect(StatusEffects.HydraRegenerationDisabled)) maxRegen += 1 * player.statusEffectv1(StatusEffects.HydraTailsPlayer);
        if (isNearWater() && (player.hasPerk(PerkLib.AquaticAffinity) || player.hasPerk(PerkLib.AffinityUndine)) && player.necklaceName == "Magic coral and pearl necklace") maxRegen += 1;
        //if (player.hasStatusEffect(StatusEffects.GnomeHomeBuff) && player.statusEffectv1(StatusEffects.GnomeHomeBuff) == 1) maxRegen += 15;
		if (player.statStore.hasBuff("CrinosShape") && player.hasPerk(PerkLib.ImprovingNaturesBlueprintsApexPredator) && !player.hasStatusEffect(StatusEffects.WereraceRegenerationDisabled)) {
			if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 3) maxRegen += 2;
			maxRegen += 2;
		}
        if (player.hasStatusEffect(StatusEffects.SecondWindRegen)) maxRegen += 5;
        if (player.hasStatusEffect(StatusEffects.Cauterize)) {
            maxRegen += 1.5;
            if (player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 1) maxRegen += 0.5;
            if (player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 2) maxRegen += 0.5;
            if (player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 3) maxRegen += 0.5;
        }
        if (player.hasPerk(PerkLib.IcyFlesh)) maxRegen += 1;
        if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) maxRegen += 0.5;
        if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) maxRegen += 0.5;
        if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) maxRegen += 0.5;
        if (player.hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) maxRegen += 0.5;
        if (player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) maxRegen += 0.5;
        if (player.armor == armors.BLIZZ_K && player.isRaceCached(Races.YUKIONNA)) maxRegen += 5;
        if (player.weapon == weapons.BCLAWS && player.isRaceCached(Races.YUKIONNA)) maxRegen += 1;
        if (combat && player.headJewelry == headjewelries.CUNDKIN && player.HP < 1) maxRegen += 1;
        if (player.hasKeyItem("M.G.S. bracer") >= 0) maxRegen += 2;
        return maxRegen;
    }

    public function fatigueRecovery(minutes:Number = 1):void {
        var fatigue1:Number = fatigueRecovery2();
		fatigue(-Math.round(fatigue1 * 0.02 * minutes));
    }
    public function fatigueRecovery1(combat:Boolean = true):void {
        var fatigue1:Number = 0;
        fatigue1 += fatigueRecovery2();
        if (combat) {
            if (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.MasteredDefenceStance)) fatigue1 *= 1.2;
            if (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.PerfectDefenceStance)) fatigue1 *= 1.4;
			fatigue1 = Math.round(fatigue1);
			fatigue(-fatigue1);
		}
		else {
			fatigue1 *= 2;
			fatigue(-fatigue1);
		}
    }

    public function fatigueRecovery2():Number {
        var fatiguecombatrecovery:Number = 1;
        var maxFirearmAttacks:int = maxFirearmsAttacks();
        if (player.hasPerk(PerkLib.StarSphereMastery)) fatiguecombatrecovery += player.perkv1(PerkLib.StarSphereMastery);
        if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) fatiguecombatrecovery += 1;
        if (player.hasPerk(PerkLib.EnlightenedNinetails)) fatiguecombatrecovery += 1;
        if (player.hasPerk(PerkLib.CorruptedNinetails)) fatiguecombatrecovery += 1;
        if (player.hasPerk(PerkLib.EnlightenedKitsune)) fatiguecombatrecovery += 1;
        if (player.hasPerk(PerkLib.CorruptedKitsune)) fatiguecombatrecovery += 1;
        if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 1) fatiguecombatrecovery += 1;
        if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 2) fatiguecombatrecovery += 1;
        if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 3) fatiguecombatrecovery += 1;
		if (player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 3) fatiguecombatrecovery += 5;
		if (player.perkv1(IMutationsLib.HumanParathyroidGlandIM) >= 3 && player.racialScore(Races.HUMAN) > 17) fatiguecombatrecovery += 10;
		if (player.perkv1(IMutationsLib.HumanBloodstreamIM) >= 2 && player.racialScore(Races.HUMAN) > 17) fatiguecombatrecovery += 5;
		if (player.perkv1(IMutationsLib.HumanBloodstreamIM) >= 3 && player.racialScore(Races.HUMAN) > 17) fatiguecombatrecovery += 5;
        if (player.hasPerk(PerkLib.HydraRegeneration) && !player.hasStatusEffect(StatusEffects.HydraRegenerationDisabled)) fatiguecombatrecovery += 1 * player.statusEffectv1(StatusEffects.HydraTailsPlayer);
        if (player.hasPerk(PerkLib.JobGunslinger)) fatiguecombatrecovery += 1;
		if (maxFirearmAttacks >= 2) fatiguecombatrecovery += 1;
		if (maxFirearmAttacks >= 2) fatiguecombatrecovery += 1;
		if (maxFirearmAttacks >= 2) fatiguecombatrecovery += 1;
		if (player.hasPerk(PerkLib.AlchemicalCartridge)) fatiguecombatrecovery += 2;
		if (player.hasPerk(PerkLib.ChurchOfTheGun)) fatiguecombatrecovery += 3;
		if (player.hasPerk(PerkLib.SaintOfZariman)) fatiguecombatrecovery += 4;
		fatiguecombatrecovery *= fatigueRecoveryMultiplier();
        fatiguecombatrecovery = Math.round(fatiguecombatrecovery);
        return fatiguecombatrecovery;
    }

    public function fatigueRecoveryMultiplier():Number {
        var multi:Number = 1;
        if (player.hasPerk(PerkLib.HistorySlacker) || player.hasPerk(PerkLib.PastLifeSlacker)) multi += 0.2;
        if (player.hasPerk(PerkLib.Whistles)) multi += 0.2;
        if (player.hasPerk(PerkLib.LyingDown)) multi += 0.2;
        if (player.hasPerk(PerkLib.TakingABreak)) multi += 0.2;
        if (player.hasPerk(PerkLib.SkippingWork)) multi += 0.2;
        if (player.hasPerk(PerkLib.Napping)) multi += 0.2;
        if (player.hasPerk(PerkLib.ZZZ)) multi += 0.2;
        if (player.hasPerk(PerkLib.Lazy)) multi += 0.2;
        if (player.hasPerk(PerkLib.ControlledBreath) && player.cor < (30 + player.corruptionTolerance)) multi += 0.2;
        if (player.hasPerk(PerkLib.SpeedyRecovery)) multi += 0.5;
        if (player.hasPerk(PerkLib.SpeedyRecuperation)) multi += 1;
        if (player.hasPerk(PerkLib.SpeedyRejuvenation)) multi += 2;
        if (player.hasPerk(PerkLib.NaturesSpringI)) multi += 0.05;
        if (player.hasPerk(PerkLib.NaturesSpringII)) multi += 0.05;
        if (player.hasPerk(PerkLib.NaturesSpringIII)) multi += 0.05;
        if (player.hasPerk(PerkLib.NaturesSpringIV)) multi += 0.05;
        if (player.hasPerk(PerkLib.NaturesSpringV)) multi += 0.05;
        if (player.hasPerk(PerkLib.NaturesSpringVI)) multi += 0.05;
        if (player.perkv1(IMutationsLib.TwinHeartIM) >= 1) multi += (0.4 * player.perkv1(IMutationsLib.TwinHeartIM));
        if (player.perkv1(IMutationsLib.TwinHeartIM) >= 1 && (player.isTaur() || player.isDrider())) multi += (0.6 * player.perkv1(IMutationsLib.TwinHeartIM));
		if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1 || (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.DefenceStance))) multi *= 2;
        return multi;
    }

    public function soulforceregeneration(minutes:Number = 1):void {
		var gainedsoulforce:Number = 0;
		gainedsoulforce += soulforceregeneration2();
		gainedsoulforce *= soulforceRecoveryMultiplier();
		gainedsoulforce = Math.round(gainedsoulforce * 0.02 * minutes);
		if (player.hasPerk(PerkLib.EnergyDependent)) gainedsoulforce = 0;
		EngineCore.SoulforceChange(gainedsoulforce);
	}
	public function soulforceregeneration1(combat:Boolean = true, minutes:Number = 1):void {
        var gainedsoulforce:Number = 0;
        if (combat) {
            gainedsoulforce += soulforceregeneration2();
            if (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.MasteredDefenceStance)) gainedsoulforce *= 1.2;
            if (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.PerfectDefenceStance)) gainedsoulforce *= 1.4;
            gainedsoulforce *= soulforceRecoveryMultiplier();
            if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1 || (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.DefenceStance))) gainedsoulforce *= 2;
            gainedsoulforce = Math.round(gainedsoulforce);
            EngineCore.SoulforceChange(gainedsoulforce);
        }
		else {
            gainedsoulforce += soulforceregeneration2() * 2;
            gainedsoulforce *= soulforceRecoveryMultiplier();
            gainedsoulforce = Math.round(gainedsoulforce);
            EngineCore.SoulforceChange(gainedsoulforce);
        }
    }

    public function soulforceregeneration2():Number {
        var soulforceregen:Number = 0;
        if (player.hasPerk(PerkLib.JobSoulCultivator)) soulforceregen += 8;
        if (player.hasPerk(PerkLib.SoulApprentice)) soulforceregen += 4;
        if (player.hasPerk(PerkLib.SoulPersonage)) soulforceregen += 4;
        if (player.hasPerk(PerkLib.SoulWarrior)) soulforceregen += 4;
        if (player.hasPerk(PerkLib.SoulSprite)) soulforceregen += 6;
        if (player.hasPerk(PerkLib.SoulScholar)) soulforceregen += 6;
        if (player.hasPerk(PerkLib.SoulGrandmaster)) soulforceregen += 6;
        if (player.hasPerk(PerkLib.SoulElder)) soulforceregen += 8;
        if (player.hasPerk(PerkLib.SoulExalt)) soulforceregen += 8;
        if (player.hasPerk(PerkLib.SoulOverlord)) soulforceregen += 8;
        if (player.hasPerk(PerkLib.SoulTyrant)) soulforceregen += 10;
        if (player.hasPerk(PerkLib.SoulKing)) soulforceregen += 10;
        if (player.hasPerk(PerkLib.SoulEmperor)) soulforceregen += 10;
        if (player.hasPerk(PerkLib.SoulAncestor)) soulforceregen += 12;
        if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 1) soulforceregen += 4;
        if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 2) soulforceregen += 4;
        if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 3) soulforceregen += 4;
		if (player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 2) soulforceregen += 40;
        if (player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 3 && player.hasPerk(PerkLib.StarSphereMastery)) soulforceregen += (player.perkv1(PerkLib.StarSphereMastery) * 4);
        if (player.perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 1) {
			var wfob:Number = 0.0025;
			if (player.perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 2) wfob += 0.0025;
			if (player.perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 3) wfob += 0.0025;
			if (player.perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 4) wfob += 0.0025;
			soulforceregen += Math.round(player.maxSoulforce() * wfob * player.tailCount);
		}
		if (player.perkv1(IMutationsLib.HumanSmartsIM) >= 3 && player.racialScore(Races.HUMAN) > 17) soulforceregen += Math.round(player.maxSoulforce() * 0.01);
		if (player.perkv1(IMutationsLib.HumanThyroidGlandIM) >= 3 && player.racialScore(Races.HUMAN) > 17) soulforceregen += Math.round(player.maxSoulforce() * 0.01);
		if (player.hasPerk(PerkLib.Necromancy)) soulforceregen += Math.round(player.maxSoulforce() * 0.02);
		if (player.hasPerk(PerkLib.RecoveryMantra)) soulforceregen += Math.round(player.maxSoulforce() * 0.02);
		if (player.hasPerk(PerkLib.DaoistApprenticeStage)) soulforceregen += Math.round(player.maxSoulforce() * 0.005);
		if (player.hasPerk(PerkLib.DaoistWarriorStage)) soulforceregen += Math.round(player.maxSoulforce() * 0.005);
		if (player.hasPerk(PerkLib.DaoistElderStage)) soulforceregen += Math.round(player.maxSoulforce() * 0.005);
		if (player.hasPerk(PerkLib.DaoistOverlordStage)) soulforceregen += Math.round(player.maxSoulforce() * 0.005);
		if (player.hasPerk(PerkLib.SoulNexus)) soulforceregen += Math.round(player.maxSoulforce() * 0.05);
		if (player.hasPerk(PerkLib.Vulpesthropy)) soulforceregen += Math.round(player.maxSoulforce() * 0.01);
		if (player.hasKeyItem("Cultivation Manual: Duality") >= 0) soulforceregen += Math.round(player.maxSoulforce() * 0.01);
		if (player.hasKeyItem("Cultivation Manual: My Dao Sticks are better than Yours") >= 0) soulforceregen += Math.round(player.maxSoulforce() * 0.02);
		if (player.headJewelry == headjewelries.DEATHPR && player.soulforce >= Math.round(player.maxSoulforce() * 0.5)) soulforceregen += Math.round(player.maxSoulforce() * 0.01);
		if (player.armor == armors.DEATHPO && player.soulforce >= Math.round(player.maxSoulforce() * 0.5)) soulforceregen += Math.round(player.maxSoulforce() * 0.02);
		if (player.armor == armors.DEATHPGA && player.soulforce >= Math.round(player.maxSoulforce() * 0.5)) soulforceregen += Math.round(player.maxSoulforce() * 0.05);
		if (player.hasPerk(PerkLib.AlteredAnima)) soulforceregen = Math.round(soulforceregen * 0.3);
        if (player.hasPerk(PerkLib.EnergyDependent)) soulforceregen = 0;
        return soulforceregen;
    }

    public function soulforceRecoveryMultiplier():Number {
        var multi:Number = 1;
        if (player.hasPerk(PerkLib.ControlledBreath) && player.cor < (30 + player.corruptionTolerance)) multi += 0.2;
        multi += SceneLib.soulforce.sfRegenRacialMult();
        return multi;
    }

    public function manaregeneration(minutes:Number = 1):void {
        var gainedmana:Number = 0;
        gainedmana += manaregeneration2();
        gainedmana *= manaRecoveryMultiplier();
        gainedmana = Math.round(gainedmana * 0.02 * minutes);
        EngineCore.ManaChange(gainedmana);
    }
	public function manaregeneration1(combat:Boolean = true):void {
        var gainedmana:Number = 0;
        if (combat) {
            gainedmana += manaregeneration2();
            if (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.MasteredDefenceStance)) gainedmana *= 1.2;
            if (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.PerfectDefenceStance)) gainedmana *= 1.4;
            if (player.statStore.hasBuff("DMorada")) gainedmana *= 1.25;
            gainedmana *= manaRecoveryMultiplier();
            if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1 || (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.DefenceStance))) {
				gainedmana *= 2;
				if (player.hasPerk(PerkLib.WellOfMana)) gainedmana *= 2;
			}
            gainedmana = Math.round(gainedmana);
            EngineCore.ManaChange(gainedmana);
        }
		else {
            gainedmana += manaregeneration2() * 2;
            gainedmana *= manaRecoveryMultiplier();
            gainedmana = Math.round(gainedmana);
            EngineCore.ManaChange(gainedmana);
        }
    }

    public function manaregeneration2():Number {
        var manaregen:Number = 0;
        if (player.hasPerk(PerkLib.JobElementalConjurer)) manaregen += 10;
        if (player.hasPerk(PerkLib.JobEnchanter)) manaregen += 10;
        if (player.hasPerk(PerkLib.JobEromancer)) manaregen += 10;
        if (player.hasPerk(PerkLib.JobGolemancer)) manaregen += 10;
        if (player.hasPerk(PerkLib.JobHealer)) manaregen += 10;
        if (player.hasPerk(PerkLib.JobSorcerer)) manaregen += 10;
        if (player.hasPerk(PerkLib.ArcaneRegenerationMinor)) manaregen += 10;
        if (player.hasPerk(PerkLib.ArcaneRegenerationMajor)) manaregen += 20;
        if (player.hasPerk(PerkLib.ArcaneRegenerationEpic)) manaregen += 30;
        if (player.hasPerk(PerkLib.ArcaneRegenerationLegendary)) manaregen += 40;
        if (player.hasPerk(PerkLib.ArcaneRegenerationMythical)) manaregen += 50;
        if (player.hasPerk(PerkLib.StrongElementalBond)) manaregen += 2;
        if (player.hasPerk(PerkLib.StrongElementalBondEx)) manaregen += 4;
        if (player.hasPerk(PerkLib.StrongElementalBondSu)) manaregen += 6;
        if (player.hasPerk(PerkLib.StrongerElementalBond)) manaregen += 8;
        if (player.hasPerk(PerkLib.StrongerElementalBondEx)) manaregen += 10;
        if (player.hasPerk(PerkLib.StrongerElementalBondSu)) manaregen += 12;
        if (player.hasPerk(PerkLib.StrongestElementalBond)) manaregen += 14;
        if (player.hasPerk(PerkLib.StrongestElementalBondEx)) manaregen += 16;
        if (player.hasPerk(PerkLib.StrongestElementalBondSu)) manaregen += 18;
        if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 1) manaregen += 5;
        if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 2) manaregen += 5;
        if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 3) manaregen += 5;
        if (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 1) manaregen += 5;
        if (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 2) manaregen += 10;
        if (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 3) manaregen += 15;
		if (player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 2) manaregen += 30;
        if (player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 3 && player.hasPerk(PerkLib.StarSphereMastery)) manaregen += (player.perkv1(PerkLib.StarSphereMastery) * 3);
		if (player.perkv1(IMutationsLib.ArigeanAssociationCortexIM) >= 3) {
			if (player.perkv1(IMutationsLib.ArigeanAssociationCortexIM) >= 4) manaregen += Math.round(player.tou * 0.15);
			else manaregen += Math.round(player.tou * 0.1);
		}
		if (player.perkv1(IMutationsLib.HumanSmartsIM) >= 3 && player.racialScore(Races.HUMAN) > 17) manaregen += Math.round(player.maxMana() * 0.005);
		if (player.perkv1(IMutationsLib.HumanThyroidGlandIM) >= 3 && player.racialScore(Races.HUMAN) > 17) manaregen += Math.round(player.maxMana() * 0.005);
		if (player.hasPerk(PerkLib.WarMageExpert)) manaregen += Math.round(player.maxMana() * 0.005);
		if (player.hasPerk(PerkLib.WarMageMaster)) manaregen += Math.round(player.maxMana() * 0.01);
		if (player.hasPerk(PerkLib.GreySageIntelligence)) manaregen += Math.round(player.maxMana() * 0.005);
		if (player.hasPerk(PerkLib.WellOfMana)) manaregen += Math.round(player.maxMana() * player.intStat.core.value * 0.001);
		if (player.hasPerk(PerkLib.GreySageWisdom)) manaregen += Math.round(player.maxMana() * 0.005);
        if (player.countMiscJewelry(miscjewelries.DMAGETO) > 0) manaregen += Math.round(player.maxMana() * 0.02);
        return manaregen;
    }

    public function manaRecoveryMultiplier():Number {
        var multi:Number = 1;
		if (player.hasPerk(PerkLib.WarMageApprentice)) multi += 0.1;
		if (player.hasPerk(PerkLib.WarMageAdept)) multi += 0.2;
        if (player.hasPerk(PerkLib.ControlledBreath) && player.cor < (30 + player.corruptionTolerance)) multi += 0.2;
		if (player.hasPerk(PerkLib.GreyMageApprentice)) multi += 0.25;
		if (player.hasPerk(PerkLib.GreyMage)) multi += 0.5;
        if (player.hasPerk(PerkLib.GreyArchmage)) multi += 0.75;
		if (player.hasPerk(PerkLib.GrandGreyArchmage)) multi += 1;
		if (player.hasPerk(PerkLib.GrandGreyArchmage2ndCircle)) multi += 1.5;
        if (player.hasPerk(PerkLib.ManaAffinityI)) multi += 0.25;
        if (player.hasPerk(PerkLib.ManaAffinityII)) multi += 0.25;
        if (player.hasPerk(PerkLib.ManaAffinityIII)) multi += 0.25;
        if (player.hasPerk(PerkLib.ManaAffinityIV)) multi += 0.25;
        if (player.hasPerk(PerkLib.ManaAffinityV)) multi += 0.25;
        if (player.hasPerk(PerkLib.ManaAffinityVI)) multi += 0.25;
        if (player.isRaceCached(Races.ALICORN,2)) multi += 0.1;
        if (player.isRaceCached(Races.KITSUNE, 2)) multi += 1.5;
        if (player.isRaceCached(Races.UNICORN, 2)) multi += 0.05;
        return multi;
    }

    public function wrathregeneration(minutes:Number = 1):void {
        var gainedwrath:Number = 0;
        if (player.hasPerk(PerkLib.AbsoluteStrength)) gainedwrath += wrathregeneration2() * 0.02 * minutes;
		else if (player.perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 4 && player.wrath < Math.round(player.maxWrath()*0.1)) gainedwrath += Math.round(player.maxWrath()*0.02) * 0.02 * minutes;
		else {
			var LostWrathPerTick:Number = player.maxWrath();
			LostWrathPerTick *= -0.01 * minutes;
			gainedwrath += LostWrathPerTick;
		}
		gainedwrath = Math.round(gainedwrath);
        EngineCore.WrathChange(gainedwrath);
    }
	public function wrathregeneration1(combat:Boolean = true):void {
        var gainedwrath:Number = 0;
        if (combat) {
            var BonusWrathMult:Number = 1;
            if (player.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult += 0.2;
			if (player.perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 3 && player.racialScore(Races.HUMAN) > 17) {
				BonusWrathMult += 0.2;
				if (player.perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 4) BonusWrathMult += 0.4;
			}
            gainedwrath += wrathregeneration2() * 2 * BonusWrathMult;
            if (player.hasStatusEffect(StatusEffects.Berzerking)) gainedwrath += 6 * BonusWrathMult;
            if (player.hasStatusEffect(StatusEffects.Lustzerking)) gainedwrath += 6 * BonusWrathMult;
            if (player.hasStatusEffect(StatusEffects.Rage)) gainedwrath += 6 * BonusWrathMult;
            if (player.hasStatusEffect(StatusEffects.OniRampage)) gainedwrath += 12 * BonusWrathMult;
            if (player.statStore.hasBuff("CrinosShape")) {
				var com:Number = 2;
                if (player.hasPerk(PerkLib.ImprovedCrinosShape)) com += 2;
                if (player.hasPerk(PerkLib.GreaterCrinosShape)) com += 4;
                if (player.hasPerk(PerkLib.MasterCrinosShape)) com += 8;
				if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 2) com *= 2;
                gainedwrath += com * BonusWrathMult;
            }
			if (player.statStore.hasBuff("AsuraForm")) {
				gainedwrath += 2 * BonusWrathMult;
				if (player.hasPerk(PerkLib.AsuraStrength)) gainedwrath += 2 * BonusWrathMult;
                if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) gainedwrath += 2 * BonusWrathMult;
                if (player.hasPerk(PerkLib.ItsZerkingTime)) gainedwrath += 2 * BonusWrathMult;
			}
            if (player.hasPerk(PerkLib.Ferocity) && player.HP < 1) gainedwrath *= 2 * BonusWrathMult;
            EngineCore.WrathChange(gainedwrath);
        }
		else {
			if (player.hasPerk(PerkLib.AbsoluteStrength)) gainedwrath += wrathregeneration2();
			else if (player.perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 4 && player.wrath < Math.round(player.maxWrath()*0.1)) gainedwrath += Math.round(player.maxWrath()*0.02);
			else {
				var LostWrathPerTick:Number = player.maxWrath();
				LostWrathPerTick *= -0.6;
				LostWrathPerTick = Math.round(LostWrathPerTick);
				gainedwrath += LostWrathPerTick;
			}
            EngineCore.WrathChange(gainedwrath);
        }
    }

    public function wrathregeneration2():Number {
        var wrathregen:Number = 0;
        var BonusWrathMult:Number = 1;
        if (player.hasPerk(PerkLib.PrimalFuryI)) wrathregen += 2;
        if (player.hasPerk(PerkLib.PrimalFuryII)) wrathregen += 2;
        if (player.hasPerk(PerkLib.PrimalFuryIII)) wrathregen += 2;
        if (player.hasPerk(PerkLib.PrimalFuryIV)) wrathregen += 2;
        if (player.hasPerk(PerkLib.PrimalFuryV)) wrathregen += 2;
        if (player.hasPerk(PerkLib.PrimalFuryVI)) wrathregen += 2;
        if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 1) wrathregen += 1;
        if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 2) wrathregen += 1;
        if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 3) wrathregen += 1;
        if (player.perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 3) wrathregen += 4;
        if (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 3) wrathregen += 4;
		if (player.perkv1(IMutationsLib.HumanBloodstreamIM) >= 2 && player.racialScore(Races.HUMAN) > 17) wrathregen += 2;
		if (player.perkv1(IMutationsLib.HumanBloodstreamIM) >= 3 && player.racialScore(Races.HUMAN) > 17) wrathregen += 2;
        if (player.necklace == necklaces.CSNECK) {
            var csneckb:Number = 2;
            if (player.wrath >= player.wrath100 * 0.2) csneckb += 2;
            if (player.wrath >= player.wrath100 * 0.4) csneckb += 2;
            if (player.wrath >= player.wrath100 * 0.6) csneckb += 2;
            if (player.wrath >= player.wrath100 * 0.8) csneckb += 2;
            if (player.hasPerk(PerkLib.Lycanthropy)) csneckb *= 2;
            wrathregen += csneckb;
        }
        if (player.jewelry1 == jewelries.FLLIRNG) wrathregen += 1;
        if (player.jewelry1 == jewelries.INMORNG) wrathregen += 1;
        if (player.jewelry2 == jewelries.FLLIRNG) wrathregen += 1;
        if (player.jewelry2 == jewelries.INMORNG) wrathregen += 1;
        if (player.jewelry3 == jewelries.FLLIRNG) wrathregen += 1;
        if (player.jewelry3 == jewelries.INMORNG) wrathregen += 1;
        if (player.jewelry4 == jewelries.FLLIRNG) wrathregen += 1;
        if (player.jewelry4 == jewelries.INMORNG) wrathregen += 1;
        if (player.jewelry4 == jewelries.UNDKINS || player.jewelry3 == jewelries.UNDKINS || player.jewelry2 == jewelries.UNDKINS || player.jewelry1 == jewelries.UNDKINS) wrathregen += 3;
		if (player.hasPerk(PerkLib.AsuraStrength)) wrathregen += Math.round(player.maxWrath() * 0.005);
		if (player.hasPerk(PerkLib.AsuraToughness)) wrathregen += Math.round(player.maxWrath() * 0.005);
        if (player.perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 4) wrathregen += Math.round(player.maxWrath() * 0.005);
        if (player.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult += 1;
		if (player.perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 3 && player.racialScore(Races.HUMAN) > 17) {
			BonusWrathMult += 1;
			if (player.perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 4) BonusWrathMult += 2;
		}
        //if (player.hasPerk(PerkLib.HiddenJobAsura)) BonusWrathMult *= 2;
		return wrathregen*BonusWrathMult;
    }

	public function venomCombatRecharge(minutes:Number = 1):void {
        var venomRecharge:Number = 0;
		venomRecharge += venomCombatRecharge2();
		venomRecharge = Math.round(venomRecharge * 0.02 * minutes);
		player.tailVenom += venomRecharge;
		if (player.tailVenom > player.maxVenom()) player.tailVenom = player.maxVenom();
    }
	public function venomCombatRecharge1(combat:Boolean = true):void {
		var gainedVenom:Number = 0;
        if (combat) gainedVenom += venomCombatRecharge2();
		else gainedVenom += venomCombatRecharge2() * 2;
        EngineCore.VenomWebChange(gainedVenom);
    }
	public function venomCombatRecharge2():Number {
		var venomCRecharge:Number = 0;
		if (player.maxVenom() > 0) {
			venomCRecharge += player.tailRecharge;
			if (venomCRecharge < 2.5) venomCRecharge = 5;
			if (player.hasPerk(PerkLib.ImprovedVenomGland)) venomCRecharge += 2.5;
			if (player.hasPerk(PerkLib.ImprovedVenomGlandEx)) venomCRecharge += 7.5;
			if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) venomCRecharge += 22.5;
			if (player.perkv1(IMutationsLib.VenomGlandsIM) >= 2) venomCRecharge += 1;
			if (player.perkv1(IMutationsLib.VenomGlandsIM) >= 3) venomCRecharge += 4;
			if (player.perkv1(IMutationsLib.VenomGlandsIM) >= 4) venomCRecharge += 10;
			if (player.hasPerk(PerkLib.VenomousDiet)) {
				if (player.hunger > 1400) venomCRecharge += 15;
				else if (player.hunger > 1200) venomCRecharge += 14;
				else if (player.hunger > 1000) venomCRecharge += 13;
				else if (player.hunger > 900) venomCRecharge += 12;
				else if (player.hunger > 800) venomCRecharge += 11;
				else if (player.hunger > 700) venomCRecharge += 10;
				else if (player.hunger > 600) venomCRecharge += 9;
				else if (player.hunger > 500) venomCRecharge += 8;
				else if (player.hunger > 400) venomCRecharge += 7;
				else if (player.hunger > 300) venomCRecharge += 6;
				else if (player.hunger > 200) venomCRecharge += 5;
				else if (player.hunger > 150) venomCRecharge += 4;
				else if (player.hunger > 100) venomCRecharge += 3;
				else if (player.hunger > 50) venomCRecharge += 2;
				else venomCRecharge += 1;
			}
			if (player.hasPerk(PerkLib.HighlyVenomousDiet) && player.maxVenom() > 0) {
				if (player.maxHunger() > 1600) venomCRecharge += 2.5;
				else if (player.maxHunger() > 800) venomCRecharge += 2.5;
				else if (player.maxHunger() > 400) venomCRecharge += 2.5;
				else if (player.maxHunger() > 200) venomCRecharge += 2.5;
				else if (player.maxHunger() > 100) venomCRecharge += 2.5;
				else venomCRecharge += 2.5;
			}
			if (player.hasPerk(PerkLib.VenomousAdiposeTissue)) {
				if (player.tou > 20000) venomCRecharge += 10;
				else if (player.tou > 10000) venomCRecharge += 9;
				else if (player.tou > 5000) venomCRecharge += 8;
				else if (player.tou > 2000) venomCRecharge += 7;
				else if (player.tou > 1000) venomCRecharge += 6;
				else if (player.tou > 500) venomCRecharge += 5;
				else if (player.tou > 200) venomCRecharge += 4;
				else if (player.tou > 100) venomCRecharge += 3;
				else if (player.tou > 50) venomCRecharge += 2;
				else venomCRecharge += 1;
				if (player.thickness > 150) venomCRecharge += 10;
				else if (player.thickness > 100) venomCRecharge += 7.5;
				else if (player.thickness > 50) venomCRecharge += 5;
				else venomCRecharge += 2.5;
			}
			if (player.faceType == Face.SNAKE_FANGS) venomCRecharge += 2;
			if (player.faceType == Face.SPIDER_FANGS) venomCRecharge += 2;
			if (player.tailType == Tail.BEE_ABDOMEN) venomCRecharge += 3;
			if (player.tailType == Tail.SPIDER_ADBOMEN) venomCRecharge += 3;
			if (player.tailType == Tail.SCORPION) venomCRecharge += 3;
			if (player.tailType == Tail.MANTICORE_PUSSYTAIL) venomCRecharge += 4;
			if (player.lowerBody == LowerBody.HYDRA) venomCRecharge += 4;
			if (player.lowerBody == LowerBody.ATLACH_NACHA) venomCRecharge *= 2;
			if (player.hasPerk(PerkLib.AxillaryVenomGlands)) venomCRecharge *= 2;
			if (player.hasKeyItem("Sky Poison Pearl") >= 0) venomCRecharge += 3;
			if (player.hasPerk(PerkLib.AscensionSkyPoisonPearlMasteryStageX)) venomCRecharge += (3 * player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX));
			venomCRecharge = Math.round(venomCRecharge);
		}
		return venomCRecharge;
	}

    internal var combatRound:int = 1;

    public function startCombatImpl(monster_:Monster, plotFight_:Boolean = false):void {
        combatRound = 1;
        CoC.instance.plotFight = plotFight_;
        mainView.hideMenuButton(MainView.MENU_DATA);
        mainView.hideMenuButton(MainView.MENU_APPEARANCE);
        mainView.hideMenuButton(MainView.MENU_LEVEL);
        mainView.hideMenuButton(MainView.MENU_PERKS);
        mainView.hideMenuButton(MainView.MENU_STATS);
        showStats();
        //Flag the game as being "in combat"
        inCombat = true;
        monster = monster_;
        monster.prepareForCombat();
        if (monster.short == "Ember") {
            monster.pronoun1 = SceneLib.emberScene.emberMF("he", "she");
            monster.pronoun2 = SceneLib.emberScene.emberMF("him", "her");
            monster.pronoun3 = SceneLib.emberScene.emberMF("his", "her");
        }
        //Reduce enemy def if player has precision!
        if (player.hasPerk(PerkLib.Precision) && player.inte >= 25) {
            if (monster.armorDef <= 10) monster.armorDef = 0;
            else monster.armorDef -= 10;
        }
		//Adjust lust vulnerability in New Game+.
        if (player.newGamePlusMod() == 1) monster.lustVuln *= 0.9;
        else if (player.newGamePlusMod() == 2) monster.lustVuln *= 0.8;
        else if (player.newGamePlusMod() == 3) monster.lustVuln *= 0.7;
        else if (player.newGamePlusMod() >= 4) monster.lustVuln *= 0.6;
        monster.HP = monster.maxOverHP();
        monster.mana = monster.maxOverMana();
        monster.soulforce = monster.maxOverSoulforce();
        monster.XP = monster.totalXP();
        settingPCforFight();
        doNext(playerMenu);
    }

    public function startCombatImmediateImpl(monster_:Monster, _plotFight:Boolean):void {
        CoC.instance.plotFight = _plotFight;
        mainView.hideMenuButton(MainView.MENU_DATA);
        mainView.hideMenuButton(MainView.MENU_APPEARANCE);
        mainView.hideMenuButton(MainView.MENU_LEVEL);
        mainView.hideMenuButton(MainView.MENU_PERKS);
        //Flag the game as being "in combat"
        inCombat = true;
        monster = monster_;
        monster.prepareForCombat();
        if (monster.short == "Ember") {
            monster.pronoun1 = SceneLib.emberScene.emberMF("he", "she");
            monster.pronoun2 = SceneLib.emberScene.emberMF("him", "her");
            monster.pronoun3 = SceneLib.emberScene.emberMF("his", "her");
        }
        //Reduce enemy def if player has precision!
        if (player.hasPerk(PerkLib.Precision) && player.inte >= 25) {
            if (monster.armorDef <= 10) monster.armorDef = 0;
            else monster.armorDef -= 10;
        }
        //Adjust lust vulnerability in New Game+.
        if (player.newGamePlusMod() == 1) monster.lustVuln *= 0.9;
        else if (player.newGamePlusMod() == 2) monster.lustVuln *= 0.8;
        else if (player.newGamePlusMod() == 3) monster.lustVuln *= 0.7;
        else if (player.newGamePlusMod() >= 4) monster.lustVuln *= 0.6;
        monster.HP = monster.maxOverHP();
        monster.mana = monster.maxOverMana();
        monster.soulforce = monster.maxOverSoulforce();
        monster.XP = monster.totalXP();
		settingPCforFight();
        playerMenu();
    }

	private function settingPCforFight():void {
		if (player.hasPerk(PerkLib.WellspringOfLust)) {
            if (player.hasPerk(PerkLib.GreyMage) && player.lust < 30) player.lust = 30;
            if (!player.hasPerk(PerkLib.GreyMage) && player.lust < 50) player.lust = 50;
        }
		if (player.hasPerk(PerkLib.AdrenalineRush)) {
			player.wrath += 300;
			if (player.wrath > player.maxOverWrath()) player.wrath = player.maxOverWrath();
		}
		if (player.hasPerk(PerkLib.SwordImmortalFirstForm)) {
			player.wrath += 100;
			if (player.wrath > player.maxOverWrath()) player.wrath = player.maxOverWrath();
			player.fatigue -= 100;
			if (player.fatigue < 0) player.fatigue = 0;
			player.soulforce += 100;
			if (player.soulforce > player.maxOverSoulforce()) player.soulforce = player.maxOverSoulforce();
		}
		meleeDamageNoLag = 0;
		applyAutocast0();
        if (!player.statStore.hasBuff("Supercharged")) magic.applyAutocast();
        mspecials.applyAutocast2();
        if (player.weaponRange == weaponsrange.LBLASTR) {
            var milkAmmo:Number = player.lactationQ() / 100;
            if (milkAmmo > 20) milkAmmo = 20;
            player.ammo = milkAmmo;
        }
        if (player.weaponRange == weaponsrange.TWINGRA) player.ammo = 12;
        if (player.weaponRange == weaponsrange.IVIARG_) player.ammo = 12;
        if (player.weaponRange == weaponsrange.TWINSIXS) player.ammo = 12;
        if (player.weaponRange == weaponsrange.BLUNDER) player.ammo = 9;
        if (player.weaponRange == weaponsrange.TDEEAGL) player.ammo = 8;
        if (player.weaponRange == weaponsrange.SIXSHOT) player.ammo = 6;
        if (player.weaponRange == weaponsrange.TDPISTO) player.ammo = 6;
        if (player.weaponRange == weaponsrange.GOODSAM) player.ammo = 4;
        if (player.weaponRange == weaponsrange.BADOMEN) player.ammo = 4;
        if (player.weaponRange == weaponsrange.DESEAGL) player.ammo = 4;
        if (player.weaponRange == weaponsrange.DALAKABL) player.ammo = 4;
        if (player.weaponRange == weaponsrange.DPISTOL) player.ammo = 3;
        if (player.weaponRange == weaponsrange.ALAKABL) player.ammo = 2;
        if (player.weaponRange == weaponsrange.ADBSHOT) player.ammo = 2;
        if (player.weaponRange == weaponsrange.ADBSCAT) player.ammo = 2;
        if (player.weaponRange == weaponsrange.DBDRAGG) player.ammo = 2;
        if (player.weaponRange == weaponsrange.TM1CERB) player.ammo = 2;
        if (player.weaponRange == weaponsrange.HARKON2) player.ammo = 2;
        if (player.weaponRange == weaponsrange.FLINTLK) player.ammo = 1;
        if (player.weaponRange == weaponsrange.DUEL_P_) player.ammo = 1;
        if (player.weaponRange == weaponsrange.M1CERBE) player.ammo = 1;
        if (player.weaponRange == weaponsrange.HARPGUN) player.ammo = 1;
        if (player.weaponRange == weaponsrange.TRFATBI) player.ammo = 1;
        if (player.weaponRange == weaponsrange.SNIPPLE) player.ammo = 1;
        if (player.weaponRange == weaponsrange.TOUHOM3) player.ammo = 1;
        if (player.weaponRange == weaponsrange.DERPLAU) player.ammo = 1;
        if (player.weaponRange == weaponsrange.HARKON1) player.ammo = 1;
		if (player.hasPerk(PerkLib.TaintedMagazine) && player.ammo > 0) player.ammo *= 2;
		if (player.hasPerk(PerkLib.PrimedClipWarp) && player.ammo > 0) player.ammo *= 3;
        if (player.weaponRange == weaponsrange.GTHRSPE) player.ammo = 20;
        if (player.weaponRange == weaponsrange.ATKNIFE) player.ammo = 15;
        if (player.weaponRange == weaponsrange.RTKNIFE) player.ammo = 15;
        if (player.weaponRange == weaponsrange.STKNIFE) player.ammo = 15;
        if (player.weaponRange == weaponsrange.TTKNIFE) player.ammo = 15;
        if (player.weaponRange == weaponsrange.GTHRAXE) player.ammo = 10;
        if (player.weaponRange == weaponsrange.O_JAVEL) player.ammo = 10;
        if (player.weaponRange == weaponsrange.TRJAVEL) player.ammo = 10;
        if (player.weaponRange == weaponsrange.SHURIKE) player.ammo = 10;
        if (player.weaponRange == weaponsrange.T_KNIFE) player.ammo = 10;
        if (player.weaponRange == weaponsrange.SHUNHAR || player.weaponRange == weaponsrange.KSLHARP || player.weaponRange == weaponsrange.LEVHARP) player.ammo = 1;
        if (player.statusEffectv1(StatusEffects.SoulDrill1) > 0) {
            player.removeStatusEffect(StatusEffects.SoulDrill1);
            player.createStatusEffect(StatusEffects.SoulDrill1, 0, 0, 0, 0);
        }
		if (player.statStore.hasBuff("Turqouise Holy Band")) player.createStatusEffect(StatusEffects.TurquoiseBandProtection, 0, 0, 0, 0);
	}

    public function display():void {
        if (!monster.checkCalled) {
            outputText("<B>/!\\BUG! Monster.checkMonster() is not called! Calling it now...</B>\n");
            monster.checkMonster();
        }
        if (monster.checkError != "") {
            outputText("<B>/!\\BUG! Monster is not correctly initialized! </B>" +
                    monster.checkError + "</u></b>\n");
        }
        var math:Number = monster.HPRatio();

        //trace("trying to show monster image!");
        if (monster.imageName != "") {
            var monsterName:String = "monster-" + monster.imageName;
            //trace("Monster name = ", monsterName);
            outputText(images.showImage(monsterName));
        }
        outputText("<b>You are fighting ");
        outputText("[themonster]:</b> \n");
        if (player.playerIsBlinded()) {
            outputText("It's impossible to see anything!\n");
        } else {
            outputText(monster.long + "\n\n");
            //Bonus sand trap stuff
            if (monster.hasStatusEffect(StatusEffects.Level)) {
                var level:int = monster.statusEffectv1(StatusEffects.Level);
                if (monster is SandTrap) {
                    //[(new PG for PC height levels)PC level 4:
                    if (level == 4) outputText("You are right at the edge of its pit.  If you can just manage to keep your footing here, you'll be safe.");
                    else if (level == 3) outputText("The sand sinking beneath your feet has carried you almost halfway into the creature's pit.");
                    else outputText("The dunes tower above you and the hissing of sand fills your ears.  <b>The leering sandtrap is almost on top of you!</b>");
                    //no new PG)
                    outputText("  You could try attacking it with your [weapon], but that will carry you straight to the bottom.  Alternately, you could try to tease it or hit it at range, or wait and maintain your footing until you can clamber up higher.");
                }
                if (monster is Alraune) {
                    if (level == 5 || level == 6) outputText("The [monster name] keeps pulling you ever closer. You are a fair distance from her for now but she keeps drawing you in.");
                    else if (level == 4 || level == 3) outputText("The [monster name] keeps pulling you ever closer. You are getting dangerously close to her.");
                    else {
                        outputText("The [monster name] keeps pulling you ever closer. You are almost in the pitcher, the ");
                        if (isHalloween()) outputText("pumpkin");
                        else outputText("plant");
                        outputText(" woman smiling and waiting with open arms to help you in.  <b>You need to get some distance or you will be grabbed and drawn inside her flower!</b>");
                    }
                    outputText("  You could try attacking it with your [weapon], but that will carry you straight to the pitcher.  Alternately, you could try to tease it or hit it at range.");
                }
                outputText("\n\n");
            }
            if (monster.plural) {
                if (math >= 1) outputText("You see [monster he] are in perfect health.  ");
                else if (math > .75) outputText("You see [monster he] aren't very hurt.  ");
                else if (math > .5) outputText("You see [monster he] are slightly wounded.  ");
                else if (math > .25) outputText("You see [monster he] are seriously hurt.  ");
                else outputText("You see [monster he] are unsteady and close to death.  "+(math<0?"<b>It appears they have the ability to remain standing even on the brink of defeat. Looks like you'll have to keep the momentum longer than they can hold themself. They can't survive on the brink of death forever!</b>":"")+"");
            } else {
                if (math >= 1) outputText("You see [monster he] is in perfect health.  ");
                else if (math > .75) outputText("You see [monster he] isn't very hurt.  ");
                else if (math > .5) outputText("You see [monster he] is slightly wounded.  ");
                else if (math > .25) outputText("You see [monster he] is seriously hurt.  ");
                else outputText("You see [monster he] is unsteady and close to death.  "+(math<0?"<b>It appears it has the ability to remain standing even on the brink of defeat. Looks like you'll have to keep the momentum longer than it can hold itself. It can't survive on the brink of death forever!</b>":"")+"");
            }
            showMonsterLust();
            // haha literally fuck organising this shit properly any more
            // BURN THE SHIT TO THE GROUND ON MY WAY OUT INNIT
            if (player.hasStatusEffect(StatusEffects.MinotaurKingMusk)) {
                if (player.lust <= (player.maxLust() * 0.1)) outputText("\nYou catch yourself looking at the King’s crotch instead of his weapon. Ugh, it’s this scent. It’s so... so powerful, worming its way into you with every breath and reminding you that sex could be a single step away.\n");
                else if (player.lust <= (player.maxLust() * 0.2)) outputText("\nWhy does he have to smell so good? A big guy like that, covered in sweat - he should smell bad, if anything. But he doesn’t. He’s like sea salt and fresh-chopped wood after a quick soak between a slut’s legs. You shiver in what you hope is repulsion.\n");
                else if (player.lust <= (player.maxLust() * 0.3)) outputText("\nYou try to breathe through your mouth to minimize the effect of his alluring musk, but then your mouth starts watering... and your lips feel dry. You lick them a few times, just to keep them nice and moist. Only after a moment do you realize you were staring at his dripping-wet cock and polishing your lips like a wanton whore. You may need to change tactics.\n");
                else if (player.lust <= (player.maxLust() * 0.4)) {
                    outputText("\nGods-damned minotaurs with their tasty-smelling cum and absolutely domineering scent. Just breathing around this guy is making your");
                    if (player.tailType != 0) outputText(" tail quiver");
                    else if (!player.isBiped()) outputText(" lower body quiver");
                    else outputText(" knees weak");
                    outputText(". How must it feel to share a bed with such a royal specimen? To luxuriate in his aroma until all you want is for him to use you? If you stick around, you might find out.\n");
                } else if (player.lust <= (player.maxLust() * 0.5)) {
                    outputText("\nYou pant. You can’t help it, not with the exertion of fighting and how blessedly <i>warm</i> you’re starting to get between the legs.");
                    if (!player.hasCock() && !player.hasVagina()) outputText(" You wish, for a moment, that you hadn’t so carelessly lost your genitalia.");
                    outputText(" Trying not to breath about this beast was never going to work anyway.\n");
                } else if (player.lust <= (player.maxLust() * 0.6)) {
                    outputText("\nLicking your lips, you can’t help but admire at how intense the Minotaur King is. Everything from his piercing gaze to his diamond - hard cock to the delightful cloud of his natural cologne is extraordinary. Would it be so bad to lose to him?\n");
                } else if (player.lust <= (player.maxLust() * 0.7)) {
                    outputText("\nYou look between the gigantic minotaur and his eager pet, wondering just how they manage to have sex. He’s so big and so hard. A cock like that would split her in half, wouldn’t it?");
                    if (player.isTaur()) outputText(" She’s not a centaur like you. She couldn’t fit him like a glove, then milk him dry with muscles a humanoid body could never contain.\n");
                    else outputText(" She must have been a champion. It’s the only way she could have the fortitude to withstand such a thick, juicy cock. You’re a champion too. Maybe it’ll fit you as well.\n ");
                } else if (player.lust <= (player.maxLust() * 0.8)) {
                    if (player.hasVagina()) {
                        outputText("\nYou’re wet");
                        if (player.wetness() >= 4) outputText(", and not just wet in the normal, everyday, ready-to-fuck way");
                        outputText(". The pernicious need is slipping inside you with every breath you take around this virile brute, twisting through your body until cunt-moistening feelers are stroking your brain, reminding you how easy it would be to spread your legs. He’s a big, big boy, and you’ve got such a ready, aching pussy.\n");
                    } else if (player.hasCock()) {
                        outputText("\nYou’re hard - harder than you’d ever expect to be from being face to face with a corrupted bovine’s dripping dick. It just... it smells so good. His whole body does. Even when you duck under a swing, you’re blasted with nothing but pure pheromones. You get dizzy just trying keep your breath, and you desperately want to tend to the ache");
                        if (player.isTaur()) outputText(" below.\n");
                        else outputText(" between your legs.\n");
                    } else outputText("\nHow you can go so far as to remove your genitals and still get so turned on when confronted by a huge prick, you’ll never know. It must be all the pheromones in the air, slipping inside your body, releasing endorphins and sending signals to dormant sections of your brain that demand you mate.\n");
                } else if (player.lust <= (player.maxLust() * 0.9)) {
                    outputText("\nYou can’t even stop yourself from staring. Not now, not after getting so fucking horny from an attempt at combat. Lethice is right there behind him, and all you can think about is that fat pillar of flesh between the lordly beast - man’s legs, that delicious looking rod. You doubt you could fit your lips around it without a lot of effort, but if you can’t beat him, you’ll have all the time in the world to practice.\n");
                } else {
                    outputText("\nGods, your head is swimming. It’s hard to stay upright, not because of the dizziness but because you desperately want to bend over and lift your [ass] up in the air to present to the Minotaur King. He’s so powerful, so domineering, that even his scent is like a whip across your");
                    if (player.hasVagina()) outputText(" folds");
                    else outputText(" ass");
                    outputText(", lashing you with strokes of red-hot desire. If you don’t take him down fast, you’re going to become his bitch.\n");
                }
            }
            var generalTypes:/*String*/Array = [];
            var elementalTypes:/*String*/Array = [];
            var statusTypes:/*String*/Array = [];
            if (player.hasPerk(PerkLib.EyesOfTheHunterNovice) && player.sens >= 25) {
                if (monster.hasPerk(PerkLib.EnemyBeastOrAnimalMorphType)) generalTypes.push("Beast or Animal-morph");
                if (monster.hasPerk(PerkLib.EnemyColossalType)) generalTypes.push("Colossal");
                if (monster.hasPerk(PerkLib.EnemyConstructType)) generalTypes.push("Construct");
                if (monster.hasPerk(PerkLib.EnemyElementalType)) generalTypes.push("Elemental");
                if (monster.hasPerk(PerkLib.EnemyFeralType)) generalTypes.push("Feral");
                if (monster.hasPerk(PerkLib.EnemyFleshConstructType)) generalTypes.push("Flesh Construct");
                if (monster.hasPerk(PerkLib.EnemyGhostType)) generalTypes.push("Ghost");
                if (monster.hasPerk(PerkLib.EnemyGigantType)) generalTypes.push("Gigant");
                if (monster.hasPerk(PerkLib.EnemyGooType)) generalTypes.push("Goo");
                if (monster.hasPerk(PerkLib.EnemyGroupType)) generalTypes.push("Group");
                if (monster.hasPerk(PerkLib.EnemyHugeType)) generalTypes.push("Huge");
                if (monster.hasPerk(PerkLib.EnemyLargeGroupType)) generalTypes.push("Large Group");
                if (monster.hasPerk(PerkLib.EnemyPlantType)) generalTypes.push("Plant");
                if (monster.hasPerk(PerkLib.EnemyTrueDemon)) generalTypes.push("True Demon");
                if (monster.hasPerk(PerkLib.EnemyTrueAngel)) generalTypes.push("True Angel");
                if (monster.hasPerk(PerkLib.EnemyUndeadType)) generalTypes.push("Undead");
				if (monster.hasPerk(PerkLib.EnemyBossType)) generalTypes.push("Boss");
                if (monster.hasPerk(PerkLib.EnemyChampionType)) generalTypes.push("Champion");
                if (monster.hasPerk(PerkLib.EnemyEliteType)) generalTypes.push("Elite");
                if (monster.hasPerk(PerkLib.EnemyGodType)) generalTypes.push("God");
				if (monster.hasPerk(PerkLib.DarknessNature)) elementalTypes.push("Darkness Nature");
                if (monster.hasPerk(PerkLib.FireNature)) elementalTypes.push("Fire Nature");
                if (monster.hasPerk(PerkLib.IceNature)) elementalTypes.push("Ice Nature");
                if (monster.hasPerk(PerkLib.LightningNature)) elementalTypes.push("Lightning Nature");
                if (monster.hasPerk(PerkLib.WaterNature)) elementalTypes.push("Water Nature");
                if (monster.hasPerk(PerkLib.EarthNature)) elementalTypes.push("Earth Nature");
                if (monster.hasPerk(PerkLib.PoisonNature)) elementalTypes.push("Poison Nature");
                if (monster.hasPerk(PerkLib.AcidNature)) elementalTypes.push("Acid Nature");
                if (monster.hasPerk(PerkLib.WindNature)) elementalTypes.push("Wind Nature");
				if (monster.hasPerk(PerkLib.DarknessVulnerability)) elementalTypes.push("Darkness Vulnerability");
                if (monster.hasPerk(PerkLib.FireVulnerability)) elementalTypes.push("Fire Vulnerability");
                if (monster.hasPerk(PerkLib.IceVulnerability)) elementalTypes.push("Ice Vulnerability");
                if (monster.hasPerk(PerkLib.LightningVulnerability)) elementalTypes.push("Lightning Vulnerability");
                if (monster.hasPerk(PerkLib.AcidVulnerability)) elementalTypes.push("Acid Vulnerability");
                if (monster.hasPerk(PerkLib.EarthVulnerability)) elementalTypes.push("Earth Vulnerability");
                if (monster.hasPerk(PerkLib.PoisonVulnerability)) elementalTypes.push("Poison Vulnerability");
                if (monster.hasPerk(PerkLib.WaterVulnerability)) elementalTypes.push("Water Vulnerability");
                if (monster.hasPerk(PerkLib.WindVulnerability)) elementalTypes.push("Wind Vulnerability");
            }
            if (player.hasPerk(PerkLib.EyesOfTheHunterExpert) && player.sens >= 75) {
                if (monster.monsterIsStunned()) statusTypes.push("Stunned");
                if (monster.monsterIsConstricted()) statusTypes.push("Constricted");
                if (monster.monsterIsBleeding()) statusTypes.push("Bleeding");
                if (monster.monsterIsPoisoned()) statusTypes.push("Poisoned");
                if (monster.monsterIsLustPoisoned()) statusTypes.push("Lust Poisoned");
                if (monster.monsterIsAcidBurned()) statusTypes.push("Acid Burned");
                if (monster.hasStatusEffect(StatusEffects.Provoke)) statusTypes.push("Provoked");
                if (monster.hasStatusEffect(StatusEffects.Fear)) statusTypes.push("Afraid");
                if (monster.hasStatusEffect(StatusEffects.ConfusionM)) statusTypes.push("Confused");
                if (monster.hasStatusEffect(StatusEffects.FrostburnDoT)) statusTypes.push("Frostbitten");
                if (monster.hasStatusEffect(StatusEffects.Flying)) statusTypes.push("Flying");
                if (player.hasStatusEffect(StatusEffects.MonsterDig)) statusTypes.push("Underground");
                if (combat.isEnemyInvisibleButNotUnderground) statusTypes.push("Invisible");
                if (monster.lustVuln == 0) statusTypes.push("Lust Immune");
                statusTypes.push(monster.displaySpecialStatuses());
            }
            outputText("\n");
            if (player.hasPerk(PerkLib.EyesOfTheHunterNovice)){
                outputText("Enemy information - General: " + generalTypes.join(", ") + "\n");
                outputText("Enemy information - Elemental: " + elementalTypes.join(", ") + "\n");
            }
            if (player.hasPerk(PerkLib.EyesOfTheHunterExpert)){
                outputText("Enemy information - Status: " + statusTypes.join(", ") + "\n");
            }
        }
        if (debug) {
            outputText("\n----------------------------\n");
            outputText(monster.generateDebugDescription());
        }
    }

    public function showMonsterLust():void {
        var damage1B:Number;
        //Entrapped
        if (monster.hasStatusEffect(StatusEffects.Constricted)) {
            outputText("[Themonster] is currently wrapped up in your tail-coils!  ");
        }
        //Snake Venom
        if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
            if (monster.plural) {
                if (monster.statusEffectv1(StatusEffects.NagaVenom) <= 1) {
                    outputText("You notice [monster he] are beginning to show signs of weakening, but there still appears to be plenty of fight left in [monster him].  ");
                } else {
                    outputText("You notice [monster he] are obviously affected by your venom, [monster his] movements become unsure, and [monster his] balance begins to fade. Sweat begins to roll on [monster his] skin. You wager [monster he] are probably beginning to regret provoking you.  ");
                }
            }
            //Not plural
            else {
                if (monster.statusEffectv1(StatusEffects.NagaVenom) <= 1) {
                    outputText("You notice [monster he] is beginning to show signs of weakening, but there still appears to be plenty of fight left in [monster him].  ");
                } else {
                    outputText("You notice [monster he] is obviously affected by your venom, [monster his] movements become unsure, and [monster his] balance begins to fade. Sweat is beginning to roll on [monster his] skin. You wager [monster he] is probably beginning to regret provoking you.  ");
                }
            }
        }
        //Apophis Venom
        if (monster.hasStatusEffect(StatusEffects.ApophisVenom)) {
            if (monster.plural) {
                if (monster.statusEffectv1(StatusEffects.ApophisVenom) <= 1) {
                    outputText("You notice [monster he] are beginning to show signs of weakening, but there still appears to be plenty of fight left in [monster him].  ");
                } else {
                    outputText("You notice [monster he] are obviously affected by your venom, [monster his] movements become unsure, and [monster his] balance begins to fade. Sweat begins to roll on [monster his] skin. You wager [monster he] are probably beginning to regret provoking you.  ");
                }
            }
            //Not plural
            else {
                if (monster.statusEffectv1(StatusEffects.ApophisVenom) <= 1) {
                    outputText("You notice [monster he] is beginning to show signs of weakening, but there still appears to be plenty of fight left in [monster him].  ");
                } else {
                    outputText("You notice [monster he] is obviously affected by your venom, [monster his] movements become unsure, and [monster his] balance begins to fade. Sweat is beginning to roll on [monster his] skin. You wager [monster he] is probably beginning to regret provoking you.  ");
                }
            }
        }
        //Bee Venom
        if (monster.hasStatusEffect(StatusEffects.BeeVenom)) {
            if (monster.plural) {
                if (monster.statusEffectv1(StatusEffects.BeeVenom) <= 1) {
                    outputText("You notice [monster he] are beginning to show signs of weakening, but there still appears to be plenty of fight left in [monster him].  ");
                } else {
                    outputText("You notice [monster he] are obviously affected by your venom, [monster his] movements become unsure, and [monster his] balance begins to fade. Sweat begins to roll on [monster his] skin. You wager [monster he] are probably beginning to regret provoking you.  ");
                }
            }
            //Not plural
            else {
                if (monster.statusEffectv1(StatusEffects.BeeVenom) <= 1) {
                    outputText("You notice [monster he] is beginning to show signs of weakening, but there still appears to be plenty of fight left in [monster him].  ");
                } else {
                    outputText("You notice [monster he] is obviously affected by your venom, [monster his] movements become unsure, and [monster his] balance begins to fade. Sweat is beginning to roll on [monster his] skin. You wager [monster he] is probably beginning to regret provoking you.  ");
                }
            }
        }
        //Jabberwocky Poison Breath
        if (monster.hasStatusEffect(StatusEffects.JabberwockyVenom)) {
            if (monster.plural) {
                if (monster.statusEffectv1(StatusEffects.JabberwockyVenom) <= 1) {
                    outputText("You notice [monster he] are beginning to show signs of weakening, but there still appears to be plenty of fight left in [monster him].  ");
                } else {
                    outputText("You notice [monster he] are obviously affected by your venom, [monster his] movements become unsure, and [monster his] balance begins to fade. Sweat begins to roll on [monster his] skin. You wager [monster he] are probably beginning to regret provoking you.  ");
                }
            }
            //Not plural
            else {
                if (monster.statusEffectv1(StatusEffects.JabberwockyVenom) <= 1) {
                    outputText("You notice [monster he] is beginning to show signs of weakening, but there still appears to be plenty of fight left in [monster him].  ");
                } else {
                    outputText("You notice [monster he] is obviously affected by your venom, [monster his] movements become unsure, and [monster his] balance begins to fade. Sweat is beginning to roll on [monster his] skin. You wager [monster he] is probably beginning to regret provoking you.  ");
                }
            }
        }
        //Manticore Venom
        if (monster.hasStatusEffect(StatusEffects.ManticoreVenom)) {
            if (monster.plural) {
                if (monster.statusEffectv1(StatusEffects.ManticoreVenom) <= 1) {
                    outputText("You notice [monster he] are beginning to show signs of weakening, but there still appears to be plenty of fight left in [monster him].  ");
                } else {
                    outputText("You notice [monster he] are obviously affected by your venom, [monster his] movements become unsure, and [monster his] balance begins to fade. Sweat begins to roll on [monster his] skin. You wager [monster he] are probably beginning to regret provoking you.  ");
                }
            }
            //Not plural
            else {
                if (monster.statusEffectv1(StatusEffects.ManticoreVenom) <= 1) {
                    outputText("You notice [monster he] is beginning to show signs of weakening, but there still appears to be plenty of fight left in [monster him].  ");
                } else {
                    outputText("You notice [monster he] is obviously affected by your venom, [monster his] movements become unsure, and [monster his] balance begins to fade. Sweat is beginning to roll on [monster his] skin. You wager [monster he] is probably beginning to regret provoking you.  ");
                }
            }
        }
        if (monster is Harpy) {
            //(Enemy slightly aroused)
            if (monster.lust >= (monster.maxLust() * 0.45) && monster.lust < (monster.maxLust() * 0.7)) outputText("The harpy's actions are becoming more and more erratic as she runs her mad-looking eyes over your body, her chest jiggling, clearly aroused.  ");
            //(Enemy moderately aroused)
            if (monster.lust >= (monster.maxLust() * 0.7) && monster.lust < (monster.maxLust() * 0.9)) outputText("She stops flapping quite so frantically and instead gently sways from side to side, showing her soft, feathery body to you, even twirling and raising her tail feathers, giving you a glimpse of her plush pussy, glistening with fluids.");
            //(Enemy dangerously aroused)
            if (monster.lust >= (monster.maxLust() * 0.9)) outputText("You can see her thighs coated with clear fluids, the feathers matted and sticky as she struggles to contain her lust.");
        } else if (monster is Clara) {
            //Clara is becoming aroused
            if (monster.lust <= (monster.maxLust() * 0.4)) {
            } else if (monster.lust <= (monster.maxLust() * 0.65)) outputText("The anger in her motions is weakening.");
            //Clara is somewhat aroused
            else if (monster.lust <= (monster.maxLust() * 0.75)) outputText("Clara seems to be becoming more aroused than angry now.");
            //Clara is very aroused
            else if (monster.lust <= (monster.maxLust() * 0.85)) outputText("Clara is breathing heavily now, the signs of her arousal becoming quite visible now.");
            //Clara is about to give in
            else outputText("It looks like Clara is on the verge of having her anger overwhelmed by her lusts.");
        }
        //{Bonus Lust Descripts}
        else if (monster is Minerva) {
            if (monster.lust < (monster.maxLust() * 0.4)) {
            }
            //(40)
            else if (monster.lust < (monster.maxLust() * 0.6)) outputText("Letting out a groan Minerva shakes her head, focusing on the fight at hand.  The bulge in her shorts is getting larger, but the siren ignores her growing hard-on and continues fighting.  ");
            //(60)
            else if (monster.lust < (monster.maxLust() * 0.8)) outputText("Tentacles are squirming out from the crotch of her shorts as the throbbing bulge grows bigger and bigger, becoming harder and harder... for Minerva to ignore.  A damp spot has formed just below the bulge.  ");
            //(80)
            else outputText("She's holding onto her weapon for support as her face is flushed and pain-stricken.  Her tiny short-shorts are painfully holding back her quaking bulge, making the back of the fabric look more like a thong as they ride up her ass and struggle against her cock.  Her cock-tentacles are lashing out in every direction.  The dampness has grown and is leaking down her leg.");
        } else if (monster is CumWitch) {
            //{Bonus Lust Desc (40+)}
            if (monster.lust < (monster.maxLust() * 0.4)) {
            } else if (monster.lust < (monster.maxLust() * 0.5)) outputText("Her nipples are hard, and poke two visible tents into the robe draped across her mountainous melons.  ");
            //{Bonus Lust Desc (50-75)}
            else if (monster.lust < (monster.maxLust() * 0.75)) outputText("Wobbling dangerously, you can see her semi-hard shaft rustling the fabric as she moves, evidence of her growing needs.  ");
            //{75+}
            if (monster.lust >= (monster.maxLust() * 0.75)) outputText("Swelling obscenely, the Cum Witch's thick cock stands out hard and proud, its bulbous tip rustling through the folds of her fabric as she moves and leaving dark smears in its wake.  ");
            //(85+}
            if (monster.lust >= (monster.maxLust() * 0.85)) outputText("Every time she takes a step, those dark patches seem to double in size.  ");
            //{93+}
            if (monster.lust >= (monster.maxLust() * 0.93)) outputText("There's no doubt about it, the Cum Witch is dripping with pre-cum and so close to caving in.  Hell, the lower half of her robes are slowly becoming a seed-stained mess.  ");
            //{Bonus Lust Desc (60+)}
            if (monster.lust >= (monster.maxLust() * 0.70)) outputText("She keeps licking her lips whenever she has a moment, and she seems to be breathing awfully hard.  ");
        } else if (monster is Kelt) {
            //Kelt Lust Levels
            //(sub 50)
            if (monster.lust < (monster.maxLust() * 0.5)) outputText("Kelt actually seems to be turned off for once in his miserable life.  His maleness is fairly flaccid and droopy.  ");
            //(sub 60)
            else if (monster.lust < (monster.maxLust() * 0.6)) outputText("Kelt's gotten a little stiff down below, but he still seems focused on taking you down.  ");
            //(sub 70)
            else if (monster.lust < (monster.maxLust() * 0.7)) outputText("Kelt's member has grown to its full size and even flared a little at the tip.  It bobs and sways with every movement he makes, reminding him how aroused you get him.  ");
            //(sub 80)
            else if (monster.lust < (monster.maxLust() * 0.8)) outputText("Kelt is unabashedly aroused at this point.  His skin is flushed, his manhood is erect, and a thin bead of pre has begun to bead underneath.  ");
            //(sub 90)
            else if (monster.lust < (monster.maxLust() * 0.9)) outputText("Kelt seems to be having trouble focusing.  He keeps pausing and flexing his muscles, slapping his cock against his belly and moaning when it smears his pre-cum over his equine underside.  ");
            //(sub 100)
            else outputText("There can be no doubt that you're having quite the effect on Kelt.  He keeps fidgeting, dripping pre-cum everywhere as he tries to keep up the facade of fighting you.  His maleness is continually twitching and bobbing, dripping messily.  He's so close to giving in...");
        } else if (monster is GreenSlime) {
            if (monster.lust >= (monster.maxLust() * 0.45) && monster.lust < (monster.maxLust() * 0.65)) outputText("A lump begins to form at the base of the figure's torso, where its crotch would be.  ");
            if (monster.lust >= (monster.maxLust() * 0.65) && monster.lust < (monster.maxLust() * 0.85)) outputText("A distinct lump pulses at the base of the slime's torso, as if something inside the creature were trying to escape.  ");
            if (monster.lust >= (monster.maxLust() * 0.85) && monster.lust < (monster.maxLust() * 0.93)) outputText("A long, thick pillar like a small arm protrudes from the base of the slime's torso.  ");
            if (monster.lust >= (monster.maxLust() * 0.93)) outputText("A long, thick pillar like a small arm protrudes from the base of the slime's torso.  Its entire body pulses, and it is clearly beginning to lose its cohesion.  ");
        } else if (monster is Sirius) {
            if (monster.lust < (monster.maxLust() * 0.4)) {
            } else if (monster.lust >= (monster.maxLust() * 0.4)) outputText("You can see the tip of his reptilian member poking out of its protective slit. ");
            else if (monster.lust >= (monster.maxLust() * 0.6)) outputText("His cock is now completely exposed and half-erect, yet somehow he still stays focused on your eyes and his face is inexpressive.  ");
            else outputText("His cock is throbbing hard, you don't think it will take much longer for him to pop.   Yet his face still looks inexpressive... despite the beads of sweat forming on his brow.  ");
        } else if (monster is Tyrantia) {
            if (monster.lust > (monster.maxLust() * 0.5) && monster.lust < (monster.maxLust() * 0.6)) outputText("Drider Giantess's skin remains flushed with the beginnings of arousal.  ");
            if (monster.lust >= (monster.maxLust() * 0.6) && monster.lust < (monster.maxLust() * 0.7)) outputText("Drider Giantess's eyes constantly dart over your most sexual parts, betraying [monster his] lust.  ");
            if (monster.lust >= (monster.maxLust() * 0.7) && monster.lust < (monster.maxLust() * 0.8)) outputText("Drider Giantess is obviously turned on, you can smell [monster his] arousal in the air.  ");
            if (monster.lust >= (monster.maxLust() * 0.8) && monster.lust < monster.maxOverLust()) outputText("You can see the giantess’s back legs trembling, the armored hatch on her front gushing lubricant.  ");
        } else if (monster is Kitsune) {
            //Kitsune Lust states:
            //Low
            if (monster.lust > (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.5)) outputText("The kitsune's face is slightly flushed.  She fans herself with her hand, watching you closely.");
            //Med
            else if (monster.lust > (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.75)) outputText("The kitsune's cheeks are bright pink, and you can see her rubbing her thighs together and squirming with lust.");
            //High
            else if (monster.lust > (monster.maxLust() * 0.3)) {
                //High (redhead only)
                if (monster.hairColor == "red") outputText("The kitsune is openly aroused, unable to hide the obvious bulge in her robes as she seems to be struggling not to stroke it right here and now.");
                else outputText("The kitsune is openly aroused, licking her lips frequently and desperately trying to hide the trail of fluids dripping down her leg.");
            }
        } else if (monster.short == "demons") {
            if (monster.lust100 >= 80) outputText(" The demons are less and less willing to hit you and more and more willing to just stroke their hands sensuously over you. The smell of demonic lust is thick on the air and part of the group just stands there stroking themselves openly.");
            else if (monster.lust100 >= 60) outputText("The demons are obviously steering clear from damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow. Some are starting to cop quick feels with their other hands and you can smell the demonic lust of a dozen bodies on the air.");
            else if (monster.lust100 >= 30) outputText("The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you.");
        } else if (monster is Aiko) {
            if (monster.lust100 >= 80) outputText("Aiko’s knees are trembling with barely-restrained arousal, and you can see a small puddle forming at her feet as she takes a deep breath, trying to calm her flustered nerves.  ");
            else if (monster.lust100 >= 60) outputText("Aiko’s cheeks are a deep crimson, and she breaks stance frequently to fan herself, panting visibly.  ");
            else if (monster.lust100 > 50) outputText("Aiko’s face is slightly pink from arousal. You can see her fidgeting in her stance once or twice, biting her lip slightly.  ");
        } else if (monster is Yamata) {
            if (monster.lust100 >= 80) outputText("Yamata has whipped herself into a lustful berserk frenzy, lashing out with reckless abandon. All of her self control has been cast aside, and she’s putting everything she has into every attack now. If things keep going like this, she might even end up wearing herself out! Though it might be hard to hold out until she eventually burns out!  ");
            else if (monster.lust100 >= 60) outputText("Bloodlust is evident in Yamata’s eyes now, and it seems like she is subsisting on animalistic rage and adrenaline alone. Every swing is accompanied by hysterical laughter, and the smells of sex and violence emanating from her are overpowering. She’s getting more and more reckless with each swing! You should end this soon!  ");
            else if (monster.lust100 >= 40) outputText("Yamata’s movements have started to become reckless, but that only serves to make her even more dangerous. The psychotic flame in her eyes is now accompanied by a lusty gaze and an occasional lick of her lips. You’re sure of it now; the more turned-on she is, the more dangerous her attacks become.  ");
            else if (monster.lust100 >= 20) outputText("Yamata is swaying a little with sadistic glee now, her psychotic grin wide and toothy. She occasionally twirls her sword around, cracking the joints in her neck from time to time and goading you into attacking. It seems like the more turned-on she becomes, the more powerful her attacks are.  ");
            else outputText("Yamata seems to be fairly calm and collected, in spite of her obviously deranged nature. A barely-restrained psychosis swims just under the surface, threatening to boil over at any moment." + (monster.lust100 > 10 ? " Is she getting stronger?" : "") + "  ");
        } else if (monster.hasPerk(PerkLib.EnemyConstructType) && !monster.hasPerk(PerkLib.Sentience)) {
			if (monster.lust100 >= 85) {
				outputText("Your action causes visible chunks of [themonster] to fall appart as lust ravage its magical structure just a little more and the construct" + (monster.plural ? "s" : "") + " will break down into rubbles! ");
				outputText("At time the construct" + (monster.plural ? "s" : "") + " movement seems to stop or freeze causing it to eraticaly halt and resume " + (monster.plural ? "their" : "its") + " action at random.  ");
			}
            else if (monster.lust100 >= 70) outputText("Your action causes the already visible crack in [themonster] structure to expend as lust clash with whatever magic is making the golem"+(monster.plural ? "s" : "")+" function ravaging "+(monster.plural ? "their" : "its")+" body from the inside.  ");
            else if (monster.lust100 >= 60) outputText("Your actions causes visible cracks over [themonster] rigid body. It would seem lust is a form of energy highly incompatible with this magical construct"+(monster.plural ? "s" : "")+" constitution.  ");
            else if (monster.lust100 >= 50) outputText("Your actions do not seem to leave any visible change on [themonster] at first though you suspect the construct"+(monster.plural ? "s were" : " was")+" affected regardless.  ");
		} else {
            if (monster.plural) {
                if (monster.lust100 >= 85 && monster.cocks.length > 0) outputText("[Themonster] are panting and softly whining, each movement seeming to make [monster his] bulges more pronounced.  You don't think [monster he] can hold out much longer.  ");
                else if (monster.lust100 >= 85 && monster.vaginas.length > 0) outputText("[Themonster]' [monster cunt]s are practically soaked with their lustful secretions.  ");
                else if (monster.lust100 >= 70 && monster.cocks.length > 0) outputText("[Themonster] are having trouble moving due to the rigid protrusion in [monster his] groins.  ");
                else if (monster.lust100 >= 70 && monster.vaginas.length > 0) outputText("[Themonster] are obviously turned on, you can smell [monster his] arousal in the air.  ");
                else if (monster.lust100 >= 60) outputText("[Themonster]' eyes constantly dart over your most sexual parts, betraying [monster his] lust.  ");
                else if (monster.lust100 >= 50) outputText("[Themonster]' skin remains flushed with the beginnings of arousal.  ");
            } else {
                if (monster.lust100 >= 85 && monster.cocks.length > 0) outputText("[Themonster] is panting and softly whining, each movement seeming to make [monster his] bulge more pronounced.  You don't think [monster he] can hold out much longer.  ");
                else if (monster.lust100 >= 85 && monster.vaginas.length > 0) outputText("[Themonster]'s [monster cunt] is practically soaked with her lustful secretions.  ");
                else if (monster.lust100 >= 70 && monster.cocks.length > 0) outputText("[Themonster] is having trouble moving due to the rigid protrusion in [monster his] groin.  ");
                else if (monster.lust100 >= 70 && monster.vaginas.length > 0) outputText("[Themonster] is obviously turned on, you can smell [monster his] arousal in the air.  ");
                else if (monster.lust100 >= 60) outputText("[Themonster]'s eyes constantly dart over your most sexual parts, betraying [monster his] lust.  ");
                else if (monster.lust100 >= 50) outputText("[Themonster]'s skin remains flushed with the beginnings of arousal.  ");
            }
        }
    }

    public function teaseXP(XP:Number = 0):void {
		var teaseEXPgogo:Number = XP;
        if (player.armor == armors.SCANSC) teaseEXPgogo += 1;
		if (player.hasMutation(IMutationsLib.HumanVersatilityIM) && player.racialScore(Races.HUMAN) > 17) teaseEXPgogo += player.perkv1(IMutationsLib.HumanVersatilityIM);
        if (monster is TrainingDummy && flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 1) {
            var bMXPMulti:Number = 1;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 2) bMXPMulti += 1.5;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 3) bMXPMulti += 2;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 4) bMXPMulti += 2.5;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 5) bMXPMulti += 3;
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 6) bMXPMulti += 5;
			teaseEXPgogo *= bMXPMulti;
        }
		if (player.hasMutation(IMutationsLib.HumanVersatilityIM) && player.perkv1(IMutationsLib.HumanVersatilityIM) >= 3 && rand(5) == 0) teaseEXPgogo *= 3;
        player.SexXP(teaseEXPgogo);
    }

	private function weaponmasteryXPMulti():Number {
		var multi:Number = 1;
		if (player.isRaceCached(Races.HUMAN)) {
			multi += 1;
			if (player.isPureHuman()) multi += 1;
		}
		if (player.hasMutation(IMutationsLib.HumanVersatilityIM) && player.racialScore(Races.HUMAN) > 17) multi += player.perkv1(IMutationsLib.HumanVersatilityIM);
        return multi;
	}



public static const MASTERY_FERAL:int = 0;
public static const MASTERY_GAUNTLET:int = 1;
public static const MASTERY_DAGGER:int = 2;
public static const MASTERY_SWORD:int = 3;
public static const MASTERY_AXE:int = 4;
public static const MASTERY_MACEHAMMER:int = 5;
public static const MASTERY_DUELINGSWORD:int = 6;
public static const MASTERY_POLEARM:int = 7;
public static const MASTERY_SPEAR:int = 8;
public static const MASTERY_WHIP:int = 9;
public static const MASTERY_EXOTIC:int = 10;
public static const MASTERY_ARCHERY:int = 11;
public static const MASTERY_THROWING:int = 12;
public static const MASTERY_FIREARMS:int = 13;
public static const MASTERY_DUAL_SMALL:int = 14;
public static const MASTERY_DUAL_NORMAL:int = 15;
public static const MASTERY_DUAL_LARGE:int = 16;
public static const MASTERY_DUAL_FIREARMS:int = 17;
public static const MASTERY_SMALL:int = 18;
public static const MASTERY_NORMAL:int = 19;
public static const MASTERY_LARGE:int = 20;
public static const MASTERY_MASSIVE:int = 21;
public static const MASTERY_RANGED:int = 22;
public static const MASTERY_UNARMED:int = 23;
public static const MASTERY_DUAL_MASSIVE:int = 24;

public static const bonusAttackMasteries:Array = [
    MASTERY_FERAL,
    MASTERY_GAUNTLET,
    MASTERY_UNARMED,
    MASTERY_SMALL,
    MASTERY_LARGE,
    MASTERY_MASSIVE,
    MASTERY_RANGED,
    MASTERY_NORMAL,
    MASTERY_ARCHERY,
    MASTERY_THROWING,
    MASTERY_FIREARMS
];

public function feralCombatXP(XP:Number = 0):void       {player.gainCombatXP(MASTERY_FERAL, XP * weaponmasteryXPMulti());}
public function gauntletXP(XP:Number = 0):void          {player.gainCombatXP(MASTERY_GAUNTLET, XP * weaponmasteryXPMulti());}
public function daggerXP(XP:Number = 0):void            {player.gainCombatXP(MASTERY_DAGGER, XP * weaponmasteryXPMulti());}
public function swordXP(XP:Number = 0):void             {player.gainCombatXP(MASTERY_SWORD, XP * weaponmasteryXPMulti());}
public function axeXP(XP:Number = 0):void               {player.gainCombatXP(MASTERY_AXE, XP * weaponmasteryXPMulti());}
public function macehammerXP(XP:Number = 0):void        {player.gainCombatXP(MASTERY_MACEHAMMER, XP * weaponmasteryXPMulti());}
public function duelingswordXP(XP:Number = 0):void      {player.gainCombatXP(MASTERY_DUELINGSWORD, XP * weaponmasteryXPMulti());}
public function polearmXP(XP:Number = 0):void           {player.gainCombatXP(MASTERY_POLEARM, XP * weaponmasteryXPMulti());}
public function spearXP(XP:Number = 0):void             {player.gainCombatXP(MASTERY_SPEAR, XP * weaponmasteryXPMulti());}
public function whipXP(XP:Number = 0):void              {player.gainCombatXP(MASTERY_WHIP, XP * weaponmasteryXPMulti());}
public function exoticXP(XP:Number = 0):void            {player.gainCombatXP(MASTERY_EXOTIC, XP * weaponmasteryXPMulti());}
public function archeryXP(XP:Number = 0):void           {player.gainCombatXP(MASTERY_ARCHERY, XP * weaponmasteryXPMulti());}
public function throwingXP(XP:Number = 0):void          {player.gainCombatXP(MASTERY_THROWING, XP * weaponmasteryXPMulti());}
public function firearmsXP(XP:Number = 0):void          {player.gainCombatXP(MASTERY_FIREARMS, XP * weaponmasteryXPMulti());}
public function dualWieldSmallXP(XP:Number = 0):void    {player.gainCombatXP(MASTERY_DUAL_SMALL, XP * weaponmasteryXPMulti());}
public function dualWieldNormalXP(XP:Number = 0):void   {player.gainCombatXP(MASTERY_DUAL_NORMAL, XP * weaponmasteryXPMulti());}
public function dualWieldLargeXP(XP:Number = 0):void    {player.gainCombatXP(MASTERY_DUAL_LARGE, XP * weaponmasteryXPMulti());}
public function dualWieldMassiveXP(XP:Number = 0):void  {player.gainCombatXP(MASTERY_DUAL_MASSIVE, XP * weaponmasteryXPMulti());}
public function dualWieldFirearmsXP(XP:Number = 0):void {player.gainCombatXP(MASTERY_DUAL_FIREARMS, XP * weaponmasteryXPMulti());}
public function weaponSmallMastery(XP:Number = 0):void  {player.gainCombatXP(MASTERY_SMALL, XP * weaponmasteryXPMulti());}
public function weaponNormalMastery(XP:Number = 0):void {player.gainCombatXP(MASTERY_NORMAL, XP * weaponmasteryXPMulti());}
public function weaponLargeMastery(XP:Number = 0):void  {player.gainCombatXP(MASTERY_LARGE, XP * weaponmasteryXPMulti());}
public function weaponMassiveMastery(XP:Number = 0):void  {player.gainCombatXP(MASTERY_MASSIVE, XP * weaponmasteryXPMulti());}
//public function weaponRangeMastery(XP:Number = 0):void  {player.gainCombatXP(MASTERY_RANGED, XP * weaponmasteryXPMulti());}
public function unarmedCombatXP(XP:Number = 0):void  	{player.gainCombatXP(MASTERY_UNARMED, XP * weaponmasteryXPMulti());}

//VICTORY OR DEATH?
// Called after the monster's action. Increments round counter. Setups doNext to win/loss/combat menu
public function combatRoundOver():void {
    player.saveHPRatio();
    combatRound++;
    player.statStore.advanceTime(Buff.RATE_ROUNDS,1);
    monster.statStore.advanceTime(Buff.RATE_ROUNDS,1);
    if (player.statStore.recentlyRemovedTags["WarriorsRage"]){
		if (player.hasPerk(PerkLib.EnchancedWarriorsRage) && player.wrath >= 50) {
			player.wrath -= 50;
			mspecials.warriorsrage007();
		}
        else EngineCore.outputText("\nYour warriors rage has ended.\n");
    }
    if (player.statStore.recentlyRemovedTags["Might"]){
        if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx) && player.mana >= CombatAbilities.Might.manaCost()) CombatAbilities.Might.autocast();
        else EngineCore.outputText("\nYour powers wanes as your Might spell ends.\n");
    }
    if (player.statStore.recentlyRemovedTags["Blink"]){
        if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx) && player.mana >= CombatAbilities.Blink.manaCost()) CombatAbilities.Blink.autocast();
        else EngineCore.outputText("\nYour speeds wanes as your Blink spell ends.\n");
    }
    player.restoreHPRatio();
    recoveryOfResourcesImpl();
    statScreenRefresh();
    flags[kFLAGS.ENEMY_CRITICAL] = 0;
    combatIsOver();
}

/**
 * Returns true if combat is over. Setups doNext to win/loss/combat menu
 * @param goToPlayerMenu Determines whether the function starts a bew combat round if combat is to continue
 * */
public function combatIsOver(goToPlayerMenu:Boolean = true):Boolean {
    if (!inCombat) return false;
    if (monster.HP <= monster.minHP()) {
        doNext(endHpVictory);
        return true;
    }
    if (monster.lust >= monster.maxOverLust()) {
        doNext(endLustVictory);
        return true;
    }
    if (monster.hasStatusEffect(StatusEffects.Level)) {
        if (monster is SandTrap && (monster as SandTrap).trapLevel() <= 1) {
            SceneLib.desert.sandTrapScene.sandtrapmentLoss();
            return true;
        } else if (monster is Alraune && (monster as Alraune).trapLevel() <= 1) {
            SceneLib.forest.alrauneScene.alrauneDeepwoodsLost();
            return true;
        }
    }
    if (monster is Basilisk && player.spe <= 1) {
        doNext(endHpLoss);
        return true;
    }
    if (player.HP <= player.minHP()) {
        doNext(endHpLoss);
        return true;
    }
    if (player.lust >= player.maxOverLust() && !player.statStore.hasBuff("Supercharged") && !tyrantiaTrainingExtension()) {
        doNext(endLustLoss);
        return true;
    }
    if (player.lust >= player.maxOverLust() && player.statStore.hasBuff("Supercharged") && monster is Doppleganger && !tyrantiaTrainingExtension()) {
        doNext(endLustLoss);
        return true;
    }
    if (goToPlayerMenu) doNext(playerMenu); //This takes us back to the combatMenu and a new combat round
    return false;
}

public function OrcaJuggle():void {
    clearOutput();
    if (player.statusEffectv1(StatusEffects.OrcaCanJuggleStill) == 2 && !player.perkv1(IMutationsLib.WhaleFatIM) >= 3) {
        outputText("You have already juggled twice.");
        addButton(0, "Next", combatMenu, false);
        return;
    }
    if (player.statusEffectv1(StatusEffects.OrcaCanJuggleStill) == 3 && player.perkv1(IMutationsLib.WhaleFatIM) >= 3) {
        outputText("You have already juggled three time.");
        addButton(0, "Next", combatMenu, false);
        return;
    }
    if (player.fatigue + physicalCost(20) > player.maxOverFatigue()) {
        outputText("You are too tired to juggle with [themonster].");
        addButton(0, "Next", combatMenu, false);
    } else {
        fatigue(20, USEFATG_PHYSICAL);
        var damage:Number = 0;
        damage += meleeUnarmedDamageNoLagSingle();
        if (damage < 10) damage = 10;
        if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
        if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
        if (monster.statusEffectv1(StatusEffects.OrcaHasSmashed) >= 1) {
            damage *= 1.50;
            monster.addStatusValue(StatusEffects.OrcaHasSmashed, 1, -1);
            outputText("This blow is particularly vicious as your opponent defences were previously crushed. ");
            if (monster.statusEffectv1(StatusEffects.OrcaHasSmashed) == 0) monster.removeStatusEffect(StatusEffects.OrcaHasSmashed);
        }
        //Dealing damage -
        outputText("You catch your falling opponent back into your maw and send it flying, extending your playtime. ");
        doPhysicalDamage(damage, true, true);
        outputText(" damage.");
        //Enemy faints -
        if (monster.HP <= monster.minHP()) {
            outputText("\n\nYou can feel your foe's life signs beginning to fade, and before you you kill [monster him], you let go, letting [monster him] fall to the floor, unconscious but alive.  In no time, [monster his]'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
            doNext(endHpVictory);
            return;
        }
        player.addStatusValue(StatusEffects.OrcaPlayRoundLeft, 1, +2);
        if (player.perkv1(IMutationsLib.WhaleFatIM) >= 2) player.addStatusValue(StatusEffects.OrcaPlayRoundLeft, 1, +1);
        player.addStatusValue(StatusEffects.OrcaCanJuggleStill, 1, +1);
        if (player.statusEffectv1(StatusEffects.OrcaCanJuggleStill) == 1) {
            if (!player.perkv1(IMutationsLib.WhaleFatIM) >= 3) {
                outputText("\n\nYou can still juggle one more time. ");
            } else {
                outputText("\n\nYou can still juggle two more time. ");
            }
        }
        if (player.statusEffectv1(StatusEffects.OrcaCanJuggleStill) == 2) {
            if (!player.perkv1(IMutationsLib.WhaleFatIM) >= 3) {
                outputText("\n\nYou cannot juggle any further. ");
            } else {
                outputText("\n\nYou can still juggle one more time. ");
            }
        }
        if (player.statusEffectv1(StatusEffects.OrcaCanJuggleStill) == 3) {
            outputText("\n\nYou cannot juggle any further. ");
        }
        outputText("\n\n" + player.statusEffectv1(StatusEffects.OrcaPlayRoundLeft) + " rounds to play  left.\n\n");
        enemyAIImpl();
    }
}

public function OrcaCleanup():void {
    player.addStatusValue(StatusEffects.OrcaPlayRoundLeft, 1, -1);
    if (player.statusEffectv1(StatusEffects.OrcaPlayRoundLeft) <= 0) {
        outputText("\n\nUnable to prolong the game further you finally let your opponent drop to the ground. ");
        var damage:Number = 0;
        damage += meleeUnarmedDamageNoLagSingle();
        doPhysicalDamage(damage, true, true);
        outputText(" damage. ");
        outputText("[monster He] try catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
        monster.removeStatusEffect(StatusEffects.OrcaPlay);
        player.removeStatusEffect(StatusEffects.OrcaPlayRoundLeft);
        player.removeStatusEffect(StatusEffects.OrcaCanJuggleStill);
        monster.removeStatusEffect(StatusEffects.OrcaHasSmashed);
        //Enemy faints -
        if (monster.HP <= monster.minHP()) {
            if (monster.hasStatusEffect(StatusEffects.OrcaHasWacked)) monster.removeStatusEffect(StatusEffects.OrcaHasWacked);
            outputText("[monster He] stays still as [monster he] hit the ground, too weak to keep up on fighting. ");
            doNext(endHpVictory);
        }
        if (monster.hasStatusEffect(StatusEffects.OrcaHasWacked)) {
            monster.removeStatusEffect(StatusEffects.OrcaHasWacked);
            monster.createStatusEffect(StatusEffects.OrcaHasWackedFinish, 0, 0, 0, 0);
        }
    }
    outputText("\n\n" + player.statusEffectv1(StatusEffects.OrcaPlayRoundLeft) + " rounds to play left.\n\n");
    enemyAIImpl();
}

public function OrcaWack():void {
    clearOutput();
    if (player.fatigue + physicalCost(20) > player.maxOverFatigue()) {
        outputText("You are too tired to wack your opponent with your tail.");
        addButton(0, "Next", combatMenu, false);
    } else {
        fatigue(20, USEFATG_PHYSICAL);
        var damage:Number = 0;
        damage += meleeUnarmedDamageNoLagSingle();
        if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
        if (monster.statusEffectv1(StatusEffects.OrcaHasSmashed) >= 1) {
            damage *= 1.50;
            monster.addStatusValue(StatusEffects.OrcaHasSmashed, 1, -1);
            outputText("This blow is particularly vicious as your opponent defences were previously crushed. ");
            if (monster.statusEffectv1(StatusEffects.OrcaHasSmashed) == 0) monster.removeStatusEffect(StatusEffects.OrcaHasSmashed);
        }
        if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
        //Dealing damage -
        outputText("You give your opponent a powerful blow with your tail, sending them flying back in the sky and forcing the air out of its lungs. Your opponent is completely disoriented! ");
        doPhysicalDamage(damage, true, true);
        outputText(" damage. ");
        //Enemy faints -
        if (monster.HP <= monster.minHP()) {
            outputText("\n\nYou can feel your foe's life signs beginning to fade, and before you you kill [monster him], you let go, letting [monster him] fall to the floor, unconscious but alive.  In no time, [monster his]'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
            doNext(endHpVictory);
            return;
        }
        if (!monster.hasStatusEffect(StatusEffects.OrcaHasWacked)) {
            monster.createStatusEffect(StatusEffects.OrcaHasWacked, 2, 0, 0, 0);
        }
        OrcaCleanup();
    }
}

public function OrcaSmash():void {
    clearOutput();
    if (player.fatigue + physicalCost(20) > player.maxOverFatigue()) {
        outputText("You are too tired to smash your opponent.");
        addButton(0, "Next", combatMenu, false);
    } else {
        fatigue(20, USEFATG_PHYSICAL);
        var damage:Number = 0;
        damage += meleeUnarmedDamageNoLagSingle();
        if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
        if (monster.statusEffectv1(StatusEffects.OrcaHasSmashed) >= 1) {
            damage *= 1.50;
            monster.addStatusValue(StatusEffects.OrcaHasSmashed, 1, -1);
            outputText("This blow is particularly vicious as your opponent defences were previously crushed. ");
            if (monster.statusEffectv1(StatusEffects.OrcaHasSmashed) == 0) monster.removeStatusEffect(StatusEffects.OrcaHasSmashed);
        }
        if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
        //Dealing damage -
        outputText("You grab your weapon with both hands and smash your target back up in the air. You break through [monster his] defences, leaving [monster him] wide open! ");
        doPhysicalDamage(damage, true, true);
        outputText(" damage. ");
        //Enemy faints -
        if (monster.HP <= monster.minHP()) {
            outputText("\n\nYou can feel your foe's life signs beginning to fade, and before you you kill [monster him], you let go, letting [monster him] fall to the floor, unconscious but alive.  In no time, [monster his]'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
            doNext(endHpVictory);
            return;
        }
        if (!monster.hasStatusEffect(StatusEffects.OrcaHasSmashed)) {
            monster.createStatusEffect(StatusEffects.OrcaHasSmashed, 2, 0, 0, 0)
        } else {
            monster.addStatusValue(StatusEffects.OrcaHasSmashed, 1, +2);
        }
        OrcaCleanup();
    }
}

public function OrcaImpale():void {
    clearOutput();
    if (player.isSpearTypeWeapon() || player.isSwordTypeWeapon() || player.isDuelingTypeWeapon()) {
        outputText("You cannot impale your foe without a piercing weapon.");
        addButton(0, "Next", combatMenu, false);
    } else {
        fatigue(20, USEFATG_PHYSICAL);
        var damage:Number = 0;
        var SAMulti:Number = 1;
        if (player.level >= 6) SAMulti += 1;
        if (player.level >= 12) SAMulti += 1;
        if (player.level >= 18) SAMulti += 1;
        if (player.level >= 24) SAMulti += 1;
        if (player.level >= 30) SAMulti += 1;
        if (player.level >= 36) SAMulti += 1;
        damage += meleeDamageNoLagSingle();
        if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
        if (monster.statusEffectv1(StatusEffects.OrcaHasSmashed) >= 1) {
            damage *= 1.50;
            monster.addStatusValue(StatusEffects.OrcaHasSmashed, 1, -1);
            outputText("This blow lands hard on your opponent's already crushed defenses. ");
        }
        if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
        damage *= SAMulti;
        var crit:Boolean = false;
        var critChance:int = 5;
        var critMulti:Number = 1.75;
        critChance += combatPhysicalCritical();
        if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
        if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) critMulti += 0.75;
        if (rand(100) < critChance) {
            crit = true;
            damage *= critMulti;
            var buffMultiplier:Number = 0;
            buffMultiplier += bonusCriticalDamageFromMissingHP();
            if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
        }
        damage = Math.round(damage);
        //Dealing damage -
        outputText("You brace your [weapon], impaling your falling opponent on the length of your weapon.  ");
        doPhysicalDamage(damage, true, true);
        outputText(" damage");
        if (crit) {
            outputText("<b> Critical!</b>");
            if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
        }
        if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
            if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
            else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
        }
        outputText(". ");
        //Enemy faints -
        outputText("You finish the game by swinging your opponent off your weapon, brutaly tossing [monster him] to the side. ");
        damage = 0;
        damage += meleeDamageNoLagSingle();
        doPhysicalDamage(damage, true, true);
        outputText(" damage. ");
        combat.checkAchievementDamage(damage);
        monster.removeStatusEffect(StatusEffects.OrcaPlay);
        player.removeStatusEffect(StatusEffects.OrcaPlayRoundLeft);
        player.removeStatusEffect(StatusEffects.OrcaCanJuggleStill);
        monster.removeStatusEffect(StatusEffects.OrcaHasSmashed);
        if (monster.HP <= monster.minHP()) {
            outputText("[monster He] stays on the ground, too weak to keep up on fighting. ");
            if (monster.hasStatusEffect(StatusEffects.OrcaHasWacked)) monster.removeStatusEffect(StatusEffects.OrcaHasWacked);
            doNext(endHpVictory);
        }
        if (monster.hasStatusEffect(StatusEffects.OrcaHasWacked)) {
            monster.removeStatusEffect(StatusEffects.OrcaHasWacked);
            monster.createStatusEffect(StatusEffects.OrcaHasWackedFinish, 0, 0, 0, 0);
        }
        enemyAIImpl();
    }
}

public function OrcaLeggoMyEggo():void {
    clearOutput();
    outputText("You let [themonster] drop, tired of playing.");
    var damage:Number = 0;
    damage += meleeUnarmedDamageNoLagSingle(0,true);
    doPhysicalDamage(damage, true, true);
    outputText(" damage. ");
    monster.removeStatusEffect(StatusEffects.OrcaPlay);
    player.removeStatusEffect(StatusEffects.OrcaPlayRoundLeft);
    player.removeStatusEffect(StatusEffects.OrcaCanJuggleStill);
    monster.removeStatusEffect(StatusEffects.OrcaHasSmashed);
    if (monster.HP <= monster.minHP()) {
        if (monster.hasStatusEffect(StatusEffects.OrcaHasWacked)) monster.removeStatusEffect(StatusEffects.OrcaHasWacked);
        outputText("[monster He] stays still as he hit the ground, too weak to keep up on fighting. ");
        doNext(endHpVictory);
    }
    if (monster.hasStatusEffect(StatusEffects.OrcaHasWacked)) {
        monster.removeStatusEffect(StatusEffects.OrcaHasWacked);
        monster.createStatusEffect(StatusEffects.OrcaHasWackedFinish, 0, 0, 0, 0);
    }
    outputText("[monster He] heaves, trying to catch [monster his] breath before [monster he] stands back up, preparing to fight once more. ");
    outputText("\n\n");
    enemyAIImpl();
}

public function CancerGrab():void {
    flags[kFLAGS.LAST_ATTACK_TYPE] = LAST_ATTACK_PHYS;
    clearOutput();
    if (monster.plural) {
        outputText("You cannot grab a single target while fighting multiple opponents at the same times!");
        addButton(0, "Next", combatMenu, false);
    }
    if (player.fatigue + physicalCost(10) > player.maxOverFatigue()) {
        clearOutput();
        outputText("You just don't have the energy to grab your opponent right now...");
        //Gone		menuLoc = 1;
        menu();
        addButton(0, "Next", combatMenu, false);
        return;
    }
    if (monster is EncapsulationPod) {
        clearOutput();
        outputText("You can't grab something you're trapped inside of!");
        //Gone		menuLoc = 1;
        menu();
        addButton(0, "Next", combatMenu, false);
        return;
    }
    //Cannot be used on plural enemies
    if (monster.plural) {
		if (player.rearBody.type == RearBody.ARIGEAN_PINCER_LIMBS) {
			outputText("You launch yourself at [themonster], but with multiple enemies, grabbing one up would leave you completely open to attack.\n\n");
            SceneLib.combat.enemyAIImpl();
            return;
		}
        else if (monster.hasStatusEffect(StatusEffects.Dig))
        {
            outputText("You begin to dig up toward [themonster], but with multiple enemies, grabbing one up would leave you completely open to attack.  You halt your progression and dig back down before you expose yourself to danger.\n\n");
            SceneLib.combat.enemyAIImpl();
            return;
        }
        else {
            outputText("You launch yourself at [themonster], but with multiple enemies, grabbing one up would leave you completely open to attack.  You hastily dig backwards before you expose yourself to danger.\n\n");
            SceneLib.combat.enemyAIImpl();
            return;
        }
    }
    fatigue(10, USEFATG_PHYSICAL);
    if (checkConcentration()) return; //Amily concentration
    //WRAP IT UPPP
	if (player.rearBody.type == RearBody.ARIGEAN_PINCER_LIMBS) {
		outputText("You launch yourself at your opponent");
        if (40 + rand(player.spe) > monster.spe) {
            outputText(", grabbing it with your powerful pincers as you prepare to crush it to death.");
        }
        //Failure
        else {
            //Failure (-10 HPs) -
            outputText(". Sadly, you miss by a mere inch. Your opponent escapes your grapple attempt.");
            player.takePhysDamage(5, true);
            if (player.HP <= player.minHP()) {
                doNext(endHpLoss);
                return;
            }
        }
	} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
        outputText("You dig right underneath your opponent, ");
        if (80 + rand(player.spe) > monster.spe) {
            outputText(" taking it by surprise and grappling it with your powerful pincers as you prepare to crush it to death.");
        }
        //Failure
        else {
            //Failure (-10 HPs) -
            outputText("surging right under your target but missing by a mere inch as your opponent escapes your pincers.\n");
            player.takePhysDamage(5, true);
            if (player.HP <= player.minHP()) {
                doNext(endHpLoss);
                if (monster.hasStatusEffect(StatusEffects.Dig)) monster.removeStatusEffect(StatusEffects.Dig);
                return;
            }
        }
    } else {
        outputText("You launch yourself at your opponent");
        if (40 + rand(player.spe) > monster.spe) {
            outputText(", grabbing it with your powerful pincers as you prepare to crush it to death.");
        }
        //Failure
        else {
            //Failure (-10 HPs) -
            outputText(". Sadly, you miss by a mere inch. Your opponent escapes your grapple attempt.");
            player.takePhysDamage(5, true);
            if (player.HP <= player.minHP()) {
                doNext(endHpLoss);
                if (monster.hasStatusEffect(StatusEffects.Dig)) monster.removeStatusEffect(StatusEffects.Dig);
                return;
            }
        }
    }
    monster.createStatusEffect(StatusEffects.CancerGrab, 3 + rand(3), 0, 0, 0);
    if (monster.hasStatusEffect(StatusEffects.Dig)) monster.removeStatusEffect(StatusEffects.Dig);
    outputText("\n\n");
    enemyAIImpl();
}

public function Tremor():void {
    flags[kFLAGS.LAST_ATTACK_TYPE] = LAST_ATTACK_PHYS;
    var damage:int;
    clearOutput();
    if (monster.hasStatusEffect(StatusEffects.Flying)) {
        clearOutput();
        outputText("There is no point in causing a tremor against an opponent that isn't even touching the ground!");
        //Gone		menuLoc = 1;
        menu();
        addButton(0, "Next", combatMenu, false);
        return;
    }
    if (player.fatigue + physicalCost(10) > player.maxOverFatigue()) {
        clearOutput();
        outputText("You just don't have the energy to create a tremor right now...");
        //Gone		menuLoc = 1;
        menu();
        addButton(0, "Next", combatMenu, false);
        return;
    }
    fatigue(10, USEFATG_PHYSICAL);
    //WRAP IT UPPP
    outputText("You wriggle underground, collapsing the tunnel behind you. You shake, causing some serious seismic activity. [themonster] loses [monster his] balance, falling to the ground, dazed. ");
    damage = 0;
	damage += meleeUnarmedDamageNoLagSingle(0,true);
    damage *= player.effectiveTallness / 10;
    if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
    if (monster.plural) damage *= 5;
    damage = Math.round(damage);
    doPhysicalDamage(damage, true, true);
    monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
    player.createStatusEffect(StatusEffects.CooldownTremor, 5, 0, 0, 0);
    outputText("\n\n");
    enemyAIImpl();
}

public function SingIntensify(Bee:Boolean = false):void {
    clearOutput();
    var MaxIntensify:int = 5;
	if (player.perkv1(IMutationsLib.MelkieLungIM) >= 4) MaxIntensify += 10;
    if (player.hasPerk(PerkLib.MelkieSong) || player.hasPerk(PerkLib.HarpySong)) MaxIntensify *= 2;
    if (player.hasPerk(PerkLib.EmpoweredAria)) MaxIntensify *= 2;
    if (player.statusEffectv1(StatusEffects.Sing) < MaxIntensify){
        if (Bee) outputText("You increase the tempo and intensify the strength of your buzzing.");
        else {
			if (player.weapon.isMusicInstrument()) outputText("You increase the tempo and intensify the strength of your performance.");
			else outputText("You increase the tempo and intensify the strength of your aria.");
		}
        player.addStatusValue(StatusEffects.Sing,1,+1);
        if (player.hasPerk(PerkLib.EmpoweredAria)){
            player.addStatusValue(StatusEffects.Sing,1,+1);
        }
        outputText("\n\n");
        enemyAIImpl();
    }
    else {
        outputText("Try as you might you cannot intensify the strength of your song any further.");
        menu();
        addButton(0, "Next", combatMenu, false);
    }
}

public function SingArouse(Bee:Boolean = false):void {
    clearOutput();
    if (player.weapon.isMusicInstrument()) outputText("You continue playing. Your compelling performance reaches far up to your opponent’s ears insidiously increasing [monster his] lust for you.");
    else outputText("You continue singing. Your compelling voice reaches far up to your opponent’s ears insidiously increasing [monster his] lust for you.");
    var LustDamage:int = combat.teases.teaseBaseLustDamage();
    if (player.perkv1(IMutationsLib.MelkieLungIM) >= 2) LustDamage += scalingBonusIntelligence();
    if (player.perkv1(IMutationsLib.MelkieLungIM) >= 3) LustDamage += scalingBonusIntelligence();
    var randomcrit:Boolean = false;
    //Determine if critical tease!
    var critChance:int = 5;
    critChance += teases.combatTeaseCritical();
    if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
    if (rand(100) < critChance) {
        randomcrit = true;
        LustDamage *= 1.75;
    }
    if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 20) {
        outputText("\n[themonster] dreamily wave around to your tune.");
        monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
    }
    if (player.weapon.isMusicInstrument()) {
		var stuuu:Number = player.statusEffectv1(StatusEffects.Sing);
		if (stuuu > 100) stuuu = 100;
		if (rand(100) < stuuu) {
			outputText("\n[themonster] dreamily wave around to your tune.");
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
    }
    if (player.hasPerk(PerkLib.RacialParagon)) LustDamage *= combat.RacialParagonAbilityBoost();
    if (player.hasPerk(PerkLib.NaturalArsenal)) LustDamage *= 1.50;
    if (player.perkv1(IMutationsLib.MelkieLungIM) >= 1) LustDamage *= (1 + (0.25 * player.perkv1(IMutationsLib.MelkieLungIM)));
	if (player.weapon == weapons.ELYSIUM) LustDamage *= 2;
    //Apply intensity multiplier
    LustDamage *= player.statusEffectv1(StatusEffects.Sing);
    //Resolve
    LustDamage = (LustDamage) * monster.lustVuln;
    LustDamage = Math.round(LustDamage);
    monster.teased(LustDamage, false);
    if (randomcrit) outputText(" Critical hit!");
    outputText("\n\n");
    combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
    enemyAIImpl();
}

public function SingCaptivate():void {
    clearOutput();
    outputText("You temporarily strengthen the hypnotic beat causing your opponent to be fascinated for a brief moment.");
    monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
    player.createStatusEffect(StatusEffects.CooldownSingCaptivate,4,0,0,0);
    outputText("\n\n");
    enemyAIImpl();
}

public function SingDevastatingAria():void {
    clearOutput();
    if (player.weapon.isMusicInstrument()) outputText("You strike a deafening note unleashing a devastating wave of sound!");
	else outputText("You unleash a devastating wave of sound!");
    var damage:Number = combat.teases.teaseBaseLustDamage();
    if (player.perkv1(IMutationsLib.MelkieLungIM) >= 2) damage *= scalingBonusIntelligence();
    if (player.perkv1(IMutationsLib.MelkieLungIM) >= 3) damage *= scalingBonusIntelligence();
    damage *= player.statusEffectv1(StatusEffects.Sing);
    //Determine if critical hit!
    var crit:Boolean = false;
    var critChance:int = 5;
    critChance += combatMagicalCritical();
    if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
    if (rand(100) < critChance) {
        crit = true;
        damage *= 1.75;
    }
    if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
    if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
	if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
	if (player.hasPerk(PerkLib.PerformancePower)) damage *= (1 + player.perkv1(PerkLib.PerformancePower));
    if (player.perkv1(IMutationsLib.MelkieLungIM) >= 1) damage *= (1 + (0.25 * player.perkv1(IMutationsLib.MelkieLungIM)));
	if (player.weapon == weapons.HELLCAL) damage *= 1.5;
    damage = Math.round(damage);
    doMagicDamage(damage, true, true);
    if (crit) outputText(" Critical hit!");
    outputText("\n\n");
    combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
    enemyAIImpl();
}

public function SingOut():void {
    clearOutput();
    outputText("You stop singing and resume fighting normally.\n\n");
    player.removeStatusEffect(StatusEffects.Sing);
    enemyAIImpl();
}

public function Straddle():void {
    flags[kFLAGS.LAST_ATTACK_TYPE] = LAST_ATTACK_PHYS;
    clearOutput();
        if (player.fatigue + physicalCost(10) > player.maxOverFatigue()) {
            clearOutput();
            outputText("You just don't have the energy to straddle your opponent right now...");
            //Gone		menuLoc = 1;
            menu();
            addButton(0, "Next", combatMenu, false);
            return;
        }
        if (monster is EncapsulationPod) {
            clearOutput();
            outputText("You can't straddle something you are inside off!");
            //Gone		menuLoc = 1;
            menu();
            addButton(0, "Next", combatMenu, false);
            return;
        }
        fatigue(10, USEFATG_PHYSICAL);
        if(checkConcentration("[monster name] recovers just in time to get out of your reach as you attempt to straddle [monster him].")) return; //Amily concentration
        //WRAP IT UPPP
        monster.createStatusEffect(StatusEffects.Straddle, 0, 0, 0, 0);
        player.createStatusEffect(StatusEffects.StraddleRoundLeft, 2 + rand(3), 0, 0, 0);
        if (player.isAlraune()) {
            outputText("You giggle and take hold of your dazed opponent with your vines before gently pulling [monster him] into your nectar bath, straddling him with your pistil as you get into mating position.");
            if (!player.hasStatusEffect(StatusEffects.AlrauneEntangle)) player.createStatusEffect(StatusEffects.AlrauneEntangle, 0, 0, 0, 0);
        } else if (monster.hasStatusEffect(StatusEffects.Pounce)) {
            if (monster.statusEffectv1(StatusEffects.Pounce) < 3){
                monster.addStatusValue(StatusEffects.Pounce, 1, 3 - monster.statusEffectv1(StatusEffects.Pounce));
            }
            player.addStatusValue(StatusEffects.StraddleRoundLeft,1,monster.statusEffectv1(StatusEffects.Pounce)-3);
            if (monster.hasStatusEffect(StatusEffects.DisplacerPlug)) monster.removeStatusEffect(StatusEffects.DisplacerPlug);
            monster.removeStatusEffect(StatusEffects.Pounce);
            outputText("You change position and straddle your opponent in order to prepare for mating.");
        } else if (monster.hasStatusEffect(StatusEffects.MysticWeb)) {
            if (monster.statusEffectv1(StatusEffects.MysticWeb) < 3){
                monster.addStatusValue(StatusEffects.MysticWeb, 1, 3 - monster.statusEffectv1(StatusEffects.MysticWeb));
            }
            player.addStatusValue(StatusEffects.StraddleRoundLeft,1,monster.statusEffectv1(StatusEffects.MysticWeb)-3);
            monster.removeStatusEffect(StatusEffects.MysticWeb);
            outputText("You chuckle at your opponent's helplessness. As they struggle, you skitter over, straddling your webbed opponent. They'll be ready for mating soon.");
        }
        else outputText("You take hold of your dazed opponent and gently pull [monster him] to the ground, straddling [monster him] as you get into position.");
        if (player.hasPerk(PerkLib.StraddleImproved)) player.addStatusValue(StatusEffects.StraddleRoundLeft, 1, +2);
        enemyAIImpl();
}

//private var straddleDamage:Number
//private var randomcrit:Boolean;
public function StraddleTease():void {
    clearOutput();
    var straddleDamage:Number = combat.teases.teaseBaseLustDamage();
    if (player.perkv1(IMutationsLib.ManticoreMetabolismIM) >= 3 && player.tail.type == Tail.MANTICORE_PUSSYTAIL) straddleDamage *= 2;
    straddleDamage = combat.teases.fueledByDesireDamageBonus(straddleDamage);
    //Determine if critical tease!
    var randomcrit:Boolean = false;
    var critChance:int = 5;
    critChance += teases.combatTeaseCritical();
    if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
    if (rand(100) < critChance) {
        randomcrit = true;
        straddleDamage *= 1.75;
        if (monster.lustVuln != 0 && player.hasPerk(PerkLib.SweepDefenses) && !monster.hasPerk(PerkLib.EnemyTrueAngel)) monster.lustVuln += 0.05;
    }
    straddleDamage = (straddleDamage) * monster.lustVuln;
    if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) straddleDamage *= 2;
    straddleDamage = Math.round(straddleDamage);

    //Select the scene
    var teaseFunctionList:Array = [randomTeaseKiss];
    if (monster.hasBreasts()) teaseFunctionList.push(randomTeaseViolateOpponentBreast);
    if (monster.hasVagina()) {
        teaseFunctionList.push(randomTeaseViolateOpponentPussy);
        if (player.tongue.type == Tongue.DEMONIC || player.tongue.type == Tongue.DRACONIC || player.tongue.type == Tongue.SNAKE) teaseFunctionList.push(randomTeaseLongTongue);
    }
    if (monster.hasCock()) {
        if (player.tail.type == Tail.DEMONIC || player.tail.type == Tail.MOUSE || player.tail.type == Tail.THUNDERBIRD || player.tail.type == Tail.HINEZUMI) teaseFunctionList.push(randomTeaseStranglingTail);
        if (player.tail.type == Tail.MANTICORE_PUSSYTAIL) teaseFunctionList.push(randomTeaseManticoreTailfuckInitiate);
        if (player.hasVagina() && !player.hasVirginVagina()) teaseFunctionList.push(randomTeaseIfEnemyCockIfPCNoVirgin);
        teaseFunctionList.push(randomTeaseIfEnemyCock);
    }
    if (player.tail.type == Tail.MANTICORE_PUSSYTAIL && player.tailVenom >= player.VenomWebCost()) teaseFunctionList.push(randomTeaseManticoreTailSpike);
    if (player.hairType == Hair.MINDBREAKERMALE) teaseFunctionList.push(randomTeaseMindflayerCriticalOverload);
    if (player.tail.type == Tail.LIZARD || player.tail.type == Tail.CAVE_WYRM || player.tail.type == Tail.SALAMANDER) teaseFunctionList.push(randomTeaseButtfuckTail);
    if (player.lowerBody == LowerBody.PLANT_FLOWER || player.lowerBody == LowerBody.FLOWER_LILIRAUNE){
        if (player.isLiliraune()) teaseFunctionList.push(randomTeaseLiliraune);
        else teaseFunctionList.push(randomTeaseAlraune);
    }
    if (player.rearBody.type == RearBody.DISPLACER_TENTACLES && !monster.hasPerk(PerkLib.EnemyConstructType)) teaseFunctionList.push(randomTeaseDisplacerMilkingInitiate);
    if (player.lowerBody == LowerBody.GOO){
        teaseFunctionList.push(randomTeaseSlime);
        teaseFunctionList.push(randomTeaseSlimeInsert);
    }
    if (player.countCocksOfType(CockTypesEnum.ANEMONE) > 0) teaseFunctionList.push(randomTeaseAnemone);
    if (player.hasPerk(PerkLib.ElectrifiedDesire)) teaseFunctionList.push(randomTeaseRaiju);
    if (player.hasPerk(PerkLib.DragonLustPoisonBreath) && player.tailVenom >= player.VenomWebCost()) teaseFunctionList.push(randomTeaseJabberwocky);
    if (player.isAnyRace(Races.HarpylikeRaces)) teaseFunctionList.push(randomTeaseHarpy);
    if (player.isRaceCached(Races.KITSUNE)) teaseFunctionList.push(randomTeaseKitsune);
    if (player.perkv1(IMutationsLib.BlackHeartIM) > 0) teaseFunctionList.push(randomTeaseLustStrike);
    var chosenTease:Function = randomChoice(teaseFunctionList);
    chosenTease(straddleDamage, randomcrit);
    combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
    outputText("\n\n");
    combat.teases.fueledByDesireHeal();
    if (player.hasPerk(PerkLib.DemonEnergyThirst) || player.hasPerk(PerkLib.KitsuneEnergyThirst)) {
        outputText("You gasp in delight as you drink on your victim's energy to replenish your own, feeding of [monster his] pleasure. ");
        if (player.hunger < player.maxHunger())
        {
            player.refillHunger(2, false);
        }
        if (player.HP < player.maxOverHP()) {
            EngineCore.HPChange(25 + (player.tou/2), true);
        }
        if (player.mana < player.maxOverMana()) {
            EngineCore.ManaChange(25 + (player.inte/2));
        }
        EngineCore.changeFatigue(-(25 + (player.spe/2)));
        if (player.soulforce < player.maxOverSoulforce() && player.hasPerk(PerkLib.KitsuneEnergyThirst)) {
            EngineCore.SoulforceChange(100 + (player.wis*2));
        }
    }
    if (player.hasPerk(PerkLib.EnergyDependent)) {
        outputText("You moan in relief as you drink your victim's lifeforce, feeding off [monster his] pleasure. ");
        player.EnergyDependentRestore();
    }
    if (player.hasStatusEffect(StatusEffects.StraddleRoundLeft)) {
        player.addStatusValue(StatusEffects.StraddleRoundLeft, 1, -1);
        if (player.statusEffectv1(StatusEffects.StraddleRoundLeft) <= 0) {
            monster.removeStatusEffect(StatusEffects.Straddle);
            player.removeStatusEffect(StatusEffects.StraddleRoundLeft);
            outputText("Your opponent finally manages to struggle free of your grapple!\n\n");
        }
    }
    enemyAIImpl();
}

public function randomTeaseKiss(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You pull in [themonster] into a wild french kiss, forcing your tongue in as you begin to choke the protest out of [monster him]. " +
            "Your opponent starts to struggle, shoving you off his face. They stagger back, doing [monster his] best not to show how much this aroused [monster him].");
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
}

public function randomTeaseIfEnemyCock(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You gently and skillfully begin to stroke [themonster] [monster cockshort] giving the tip a wet kiss every now and then in order to coax the delicious pre out, " +
            "your saliva dripping from the length. [themonster] mouths open to let out a confused moan as you work [monster his] tool. ");
    if (monster.hasBalls()) outputText("Your second hand is busy massaging the ball sack beneath, " +
            "intent on speeding up the inevitable and messy orgasm your skillful play will force out of [monster him]. ");
    outputText("Your opponent finally tries to fight back, forcing you to unwrap your grip on [monster his] dick momentarily. You back off, but the damage is already done.");
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
}

public function randomTeaseIfEnemyCockIfPCNoVirgin(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You lower yourself onto [themonster] [monster cockshort] and begin to gently gyrate your hips, " +
            "drooling from your mouth as you drink in the pleasure. [themonster] mouths open to let out a confused moan as you work [monster his] tool. " +
            "You bounce up and down the rod, keeping your pussy tightly wrapped around [themonster]'s aching member in order to speed up the inevitable and messy orgasm your " +
            "skilled cunt will force out of [monster him]. Your opponent finally fights back, forcing you up and off [monster his] dick. You back off, but the damage is already done, your foe's arousal clear. " +
            "And you lick your lips still riding on your own pleasure.");
    straddleDamage *= 1.5;
    straddleDamage = Math.round(straddleDamage);
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
    player.lust += (20 * (1 + monster.newGamePlusMod()));
}

public function randomTeaseStranglingTail(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You wrap your prehensile tail around [themonster] [monster cockshort] and skillfully begin to stroke it, your tail tip poking inside the urethra every now and then, " +
            "pre gushing out through whatever space is left between. [themonster]'s mouth opens to let out a confused moan as you work [monster his] tool. ");
    if (monster.hasBalls()) outputText("Your hand is busy massaging the ball sack beneath, intent on speeding up the inevitable and messy orgasm your skillful play will force out of [monster him].");
    outputText("Your opponent finally fights back, forcing you to unwrap your tail from them. You back off, but the damage has already been done.");
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
}

public function randomTeaseButtfuckTail(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You smile mischievously as you insert inch after inch of your tail into your opponent, slowly stretching that cute pucker of [monster his], " +
            "[themonster]'s eyes widen as you slowly proceed to analy tail fuck [monster him]. Ahhh such tightness in that hole. " +
            "Sadly it only lasts for a while before [monster he] finally fights back. " +
            "You give [monster a] a smirk and a wink, yanking your tail out in one go. You get back into a fighting stance, but the damage is already done.");
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
}

public function randomTeaseViolateOpponentBreast(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You begin to groppe [themonster] [monster breasts] with both hands, licking the areola and smirking knowingly as the tips hardens in reaction. " +
            "[themonster] moans coax you in doubling up the attention your tongue circling a nipple then moving to the other. " +
            "It takes great effort from [themonster] to snap out and force you off [monster his] tormented chest but the blush you see on [monster his] cheeks was worth it.");
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
}

public function randomTeaseViolateOpponentPussy(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You mischievously begin to finger [themonster] [monster cunt] forcing a surprised moan out of [monster him] as you attack [monster his] clitoris relentlessly. " +
            "clear, sticky pre coats your hand, a clear sign of your victim's pleasure as you rub their clit." +
            "It takes great effort from [themonster], [monster he] lets loose a cry, breaking your hold and forcing your fingers from [monster his] tormented cunt. You back off, but you see their blushing cheeks.");
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
}

public function randomTeaseLongTongue(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("Oh god, [themonster] had it coming as you prepare yourself to use your strongest weapon. " +
            "Your long prehensile tongue slides into [themonster] [monster cunt] like a tentacle, striking the sweet spot with unerring precision. " +
            "Your almost jerk your victim's clit with your flexible tongue, forcing out delirious moans from [themonster] as [monster his] knee goes weak from your ministration. " +
            "In desperation [monster he] punches you in the face. Your head whipped back, you're forced to pull your tongue out of [monster his] tormented cunt. You back off, but your foe is blushing madly, beads of sweat" +
            "on [monster his] forehead. Your opponent is so staggered by your expert tongueing that you easily keep [monster him] pinned. ");
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
    player.addStatusValue(StatusEffects.StraddleRoundLeft, 1, 1);
}

public function randomTeaseMindflayerCriticalOverload(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("Immobilizing your opponent with your arms you lock [monster him] into a kiss as you insert your tentacles inside [themonster]'s head and wrap them around [monster his] brain," +
            " giving your victim a glimpse at every depraved lewd act your body has felt and done to others and the infinite maddening pleasure your insane mind has gone through " +
            "gifting your victim with the first hand experience of everything you have endured." +
            " Your opponent shove you off in panic but the damage is already done and you smile knowingly as you spot telltale sign of [monster his] increased arousal.");
    var multiplier:Number = 1;
    if (player.hasPerk(PerkLib.RacialParagon)) multiplier += RacialParagonAbilityBoost() - 1;
    if (player.hasPerk(PerkLib.NaturalArsenal)) multiplier += 0.5;
    if (player.hasPerk(PerkLib.MindbreakerBrain1toX)) multiplier += player.perkv1(PerkLib.MindbreakerBrain1toX)*0.5;
    straddleDamage *= multiplier;
    straddleDamage += scalingBonusIntelligence() * 2;
    monster.teased(straddleDamage, false);
    
    if (monster.lustVuln != 0) monster.lustVuln += 0.05;
    if (randomcrit) outputText(" <b>Critical!</b>");
}

public function randomTeaseManticoreTailSpike(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("Taking advantage of your opponent's precarious position, you reach back and grab one of your back-spikes. " +
            "You grin widely as you bring your hand down, stabbing your opponent with your venomous spike. You bat aside their clumsy attempt at a block, stabbing them again and again. With each stab, venom frothes from the spike, and blood spills from the deep injuries." +
            "Your victim eventually rallies, blocking your wrist, then knocking the spike from your hand. You jump off them before they can strike you, but as they fight their way upright, you can tell that it was worth it");
    if (player.perkv1(IMutationsLib.ManticoreMetabolismIM) >= 3 && player.tail.type == Tail.MANTICORE_PUSSYTAIL) straddleDamage *= 2;
    
    var multiplier:Number = 1;
    if (player.hasPerk(PerkLib.RacialParagon)) multiplier += RacialParagonAbilityBoost() - 1;
    if (player.hasPerk(PerkLib.NaturalArsenal)) multiplier += 0.5;
    straddleDamage *= multiplier;

    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");

    var dam4Ba:Number = 1;
    if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) dam4Ba *= 2;
    monster.statStore.addBuffObject({tou:-(dam4Ba*6)}, "Poison",{text:"Poison"});
    if (monster.hasStatusEffect(StatusEffects.ManticoreVenom)) {
        monster.addStatusValue(StatusEffects.ManticoreVenom, 3, dam4Ba);
    } else monster.createStatusEffect(StatusEffects.ManticoreVenom, 0, 0, dam4Ba, 0);

    player.tailVenom -= player.VenomWebCost();
    flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
}

public function randomTeaseManticoreTailfuckInitiate(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You lick your lips and hold your victim down as you get into position,  engulfing [themonster] juicy [monster cockshort] with your tail pussy. You’re going to milk that cumpump for what its worth.");
    var DurationLeft:int = player.statusEffectv1(StatusEffects.StraddleRoundLeft);
    var BasePlugDuration:int = 1;
    if (player.perkv1(IMutationsLib.ManticoreMetabolismIM) >= 3) BasePlugDuration += 3;
    monster.createStatusEffect(StatusEffects.ManticorePlug, BasePlugDuration + rand(3), DurationLeft, 0, 0);
    player.removeStatusEffect(StatusEffects.StraddleRoundLeft);
    monster.removeStatusEffect(StatusEffects.Straddle);
}

public function randomTeaseDisplacerMilkingInitiate(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You lick your lips in anticipation as you hold your victim's arms to the ground and plug your two tentacle suckers to [monster his] breasts. " +
            "[monster he] struggles, flushing red as you flood [monster his] nipples with your lactation inducing venom and begin to force the delicious milk out of [monster his] chest. ");
    var DurationLeft:int = player.statusEffectv1(StatusEffects.StraddleRoundLeft);
    monster.createStatusEffect(StatusEffects.DisplacerPlug, DurationLeft + rand(3), 0, 0, 0);
    player.removeStatusEffect(StatusEffects.StraddleRoundLeft);
    monster.removeStatusEffect(StatusEffects.Straddle);
}

public function randomTeaseJabberwocky(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You inhale deeply before forcing yourself in, kissing your foe. You force their mouth open, breathing poison directly down [monster His] throat!");
    var dam4Ba:Number = 1;
    var multiplier:Number = 1;
    if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) multiplier += 1;
    if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 1) multiplier += 2;
    if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) multiplier += 2;
    if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) multiplier += 2;
    if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 4) multiplier += 2;
    if (player.hasPerk(PerkLib.RacialParagon)) multiplier += RacialParagonAbilityBoost() - 1;
    if (player.hasPerk(PerkLib.NaturalArsenal)) multiplier += 0.5;
    dam4Ba *= multiplier;

    monster.statStore.addBuffObject({tou:-(dam4Ba*2)}, "Poison",{text:"Poison"});
    if (monster.hasStatusEffect(StatusEffects.JabberwockyVenom)) {
        monster.addStatusValue(StatusEffects.JabberwockyVenom, 3, dam4Ba);
    } else monster.createStatusEffect(StatusEffects.JabberwockyVenom, 0, 0, dam4Ba, 0);
    player.tailVenom -= player.VenomWebCost();
    straddleDamage += scalingBonusToughness() * 2;
    straddleDamage *= 2;
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
    if (monster.lustVuln != 0) monster.lustVuln += 0.05;
}

public function randomTeaseRaiju(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You begin gathering up electricity before discharging it into your opponent's genitals at point blank range. [monster His] ");
    if (monster.hasCock()) outputText("cock begins shooting an endless flow of cum");
    if (monster.hasCock() && monster.hasVagina()) outputText(" as [monster his]");
    if (monster.hasVagina()) outputText(" pussy starts gushing like a fountain, lips swelling like a blooming flower. ");
    if (monster.hasCock() && monster.hasVagina()) outputText("They");
    else outputText("It");
    outputText(" pulse");
    if (monster.hasCock() && monster.hasVagina()) outputText("s");
    outputText(" with your current at the rhythm of [themonster] owns heartbeat.");

    var multiplier:Number = 1;
    if (player.hasPerk(PerkLib.RacialParagon)) multiplier += RacialParagonAbilityBoost() - 1;
    straddleDamage *= multiplier;
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
    if (monster.lustVuln != 0) monster.lustVuln += 0.05;
}

public function randomTeaseHarpy(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You wrap your wings around [themonster], firmly planting your plush backside down onto [monster his] cock and slipping it between your cheeks. " +
            "Your soft ass completely engulfs [monster his] dick and hugs it tightly. " +
            "You moving your hips up and down massaging and stroking it between your warm soft flesh. You pull [themonster] into a kiss, " +
            "your drug laced lipstick already having an effect on [monster him]. " +
            "[monster His] pre drooling [monster cockshort] twitches and strains between your plush cheeks making them slicker. " +
            "You giggle planting a few more kisses around [monster his] mouth and neck as you push [monster him] closer to the edge. " +
            "Your opponent finally fights back, forcing you to release [monster his] dick from between your cheeks. You push off, getting back into a fighting stance, almost laughing as you see [monster him] arousal.");
    
    var multiplier:Number = 1;
    if (player.hasPerk(PerkLib.RacialParagon)) multiplier += RacialParagonAbilityBoost() - 1;
    straddleDamage *= multiplier;
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
    if (monster.lustVuln != 0) monster.lustVuln += 0.05;
}

public function randomTeaseKitsune(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("With a mischievous grin you coat your hands and tail tips with foxfire, running the tingling flames deliciously along the length of [themonster] body");
    if (monster.hasBreasts()) outputText(", your tails tracing [monster his] [monster breasts]");
    outputText(". You finish [monster him] up by focusing your flames on [monster his] crotch bathing [monster his]");
    if (monster.hasVagina()) outputText(" pussy");
    if (monster.hasCock() && monster.hasVagina()) outputText(" and");
    if (monster.hasCock()) outputText(" [monster cockshort]");
    outputText(" with fiery lust. Your opponent eventually shakes off your magic, striking you and breaking your concentration, but they clearly enjoyed the experience. Nothing's preventing you from doing it again, after all");
    
    straddleDamage += scalingBonusWisdom() + scalingBonusIntelligence();
    var multiplier:Number = 1;
    if (player.hasPerk(PerkLib.RacialParagon)) multiplier += RacialParagonAbilityBoost() - 1;
    straddleDamage *= multiplier;
    straddleDamage = Math.round(straddleDamage);
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
}

public function randomTeaseAlraune(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("Now that [themonster] is nicely tied up you giggle and you pull [monster him] into a kiss, " +
            "feeding [monster him] your aphrodisiac nectar as your hand sweetly traces [monster his] cheek, one of your stamen going straight for");
    if (monster.hasVagina()) outputText(" the waiting love canal up front as another takes aim and plunge into ");
    outputText("his/her waiting backdoor hole stretching the passage up and going as deep as [monster his] bowels. ");
    if (monster.hasCock()) outputText("Not one to waste any potential seed you sit [monster him] deeper in the bath and wrap yourself tightly around [monster his]" +
            " waist impaling your pistil on [monster his] already drooling stamen so to pollinate yourself with [monster his] fertile seed. ");
    outputText("\n\nThe sex is mind melting but short lived as suddenly aware of what is going on [themonster] " +
            "begins trashing about. You hold on, but they roar, forcing [monster him]self out of your grip. You shake your head, retreating back to your previous position, and [monster him] takes a few steps back. " +
            "You will mate eventually… it's just a matter of time now.");
    
    var multiplier:Number = 1;
    if (player.hasPerk(PerkLib.RacialParagon)) multiplier += RacialParagonAbilityBoost() - 1;
    straddleDamage *= multiplier;
    //(Add a toughness modifier and double lust damage)
    straddleDamage *= scalingBonusToughness() * 2;
    straddleDamage *= 2;
    straddleDamage = Math.round(straddleDamage);
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
}

public function randomTeaseLiliraune(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("With your lovely guest comfortably set in your pitcher its time for you to get to the fun part." +
            "\n\n\"Oh my! An early treat sister, look at how she/he is well tied up.\"" +
            "\n\n\"It sure gets my sap pumping.\"\n\n");
    outputText("Now that [themonster] is nicely tied up you giggle and you pull [monster him] into a kiss, " +
            "feeding [monster him] your aphrodisiac nectar as your hand sweetly traces [monster his] cheek. One of your stamens plunges straight towards");
    if (monster.hasVagina()) outputText(" the waiting love canal up front as another takes aim and plunge into ");
    outputText("his/her waiting backdoor hole stretching the passage up and going as deep as [monster his] bowels. " +
            "Meanwhile, your sister going into position to take care of your guest other available areas, not leaving any inches of that body unstimulated.");
    if (monster.hasCock()) outputText("Not one to waste any potential seed she pulls [monster him] deeper in the bath and wraps herself around [monster his]" +
            " waist, impaling herself on [monster his] already drooling stamen so to pollinate both of you with [monster his] fertile pollen. ");
    outputText("\n\nThe sex is mind melting but short lived as suddenly, you feel your prey jolt awake. Now aware of what is going on [themonster] " +
            "begins thrashing about. You hold on, but your prey is desperate, forcing [monster him]self out of your grip with enough strength to throw the three of you back into the previous position. " +
            "\n\n\"You're just delaying the inevitable you know? You should just surrender and let us take good care of your pleasure.\"" +
            "\n\n\"We're going to give you the sweetest orgasm of your life. So sweet your eyes will probably cross thehehe...\"\n\n" +
            "You will mate eventually… it's just a matter of time now.");
    
    var multiplier:Number = 1;
    if (player.hasPerk(PerkLib.RacialParagon)) multiplier += RacialParagonAbilityBoost() - 1;
    straddleDamage *= multiplier;
    //(Add a toughness modifier and double lust damage)
    straddleDamage += scalingBonusToughness() * 2;
    straddleDamage *= 3;
    straddleDamage = Math.round(straddleDamage);
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
}

public function randomTeaseLustStrike(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You smile lewdly, almost moaning the syllables as you pose your hand on [themonster] crotch " +
            "waving the demonic signs and delivering your unholy magic directly into your victim's endowment. [monster His] ");
    if (monster.hasCock() > 0) outputText("cock drools black precum, swelling in size");
    if (monster.hasCock() && monster.hasVagina()) outputText(" as [monster his] ");
    if (monster.hasVagina()) outputText("pussy starts gushing like a fountain, lips swelling with arousal");
	outputText(". ");
    if (monster.hasCock() && monster.hasVagina()) outputText(". They");
    else outputText("It");
    outputText(" pulse");
    if (monster.hasCock() && monster.hasVagina()) outputText("s");
    outputText(" with your demonic powers at the rhythm of [themonster]'s heartbeat. " +
            "The unholy transformation, even if temporary, arouses [themonster] to no end.");

    straddleDamage += scalingBonusIntelligence() * 2;
    straddleDamage = Math.round(straddleDamage);
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
    if (monster.lustVuln != 0) monster.lustVuln += 0.05;
}

public function randomTeaseAnemone(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You take no time, plugging your venomous tentacled anemone cock into [themonster]'s vulnerable pussy. " +
            "The effect is instantaneous as [monster he] is stung on the entire surface of [monster his] vaginal walls, " +
            "the lips puffing up and the hole gushing with a telltale spray of girlcum. You begin to piston inside, " +
            "insensate to [themonster] crazed moans as you attempt to force in as much pleasure as you can. " +
            "In desperation [monster he] punches you, forcing you to pull your devilish cock out of its tormented cunt. " +
            "[monster he] breathes heavily, blushing as [monster he] fights to [monster his] feet. You can tell you've rattled [monster him]");
    
    var multiplier:Number = 1;
    if (player.hasPerk(PerkLib.RacialParagon)) multiplier += RacialParagonAbilityBoost() - 1;
    straddleDamage *= multiplier;
    straddleDamage *= 2;
    straddleDamage = Math.round(straddleDamage);
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
}

public function randomTeaseSlime(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("You take no time, violating [themonster]'s vulnerable ");
    if (monster.hasVagina()) outputText("pussy");
    if (monster.hasVagina() && monster.hasCock()) outputText(" and ");
    if (monster.hasCock() > 0) outputText(" urethra");
    outputText("molding yourself into various sex toys to cause [monster him] a maximum amount of pleasure and maximise the fluid output.");
    if (monster.hasVagina() && monster.hasCock()) outputText("Meanwhile, deep");
    if (monster.hasVagina() && !monster.hasCock()) outputText("Once deep");
    if (monster.hasVagina()) outputText(" inside [monster his] vagina, you begin viciously bumping into as many of [monster his] sensitive spots as you can, coaxing numerous loud moans from your partner.");
    outputText("Eventually, [monster his] forceful contractions force you back out of your opponent. They manage to get back up, but they look like they enjoyed it." +
            "Thats nice because you intend to to do it again, the first chance you get.");
    
    var multiplier:Number = 1;
    if (player.hasPerk(PerkLib.RacialParagon)) multiplier += RacialParagonAbilityBoost() - 1;
    straddleDamage *= multiplier;
    straddleDamage += (scalingBonusToughness() * 2) + (scalingBonusLibido() * 2);
    straddleDamage = Math.round(straddleDamage);
    monster.teased(straddleDamage, false);
    if (randomcrit) outputText(" <b>Critical!</b>");
}

public function randomTeaseSlimeInsert(straddleDamage:Number, randomcrit:Boolean):void {
    outputText("Hungry for fluids you forcefully inject yourself into your opponent body, using every available orifice as an entryway. ");
    if (monster.hasCock()) outputText("Within seconds you reach the fresh cum storage of your opponent feeding straight from the tap. Your forceful entry causes [monster him] no short amount of pleasure as you mess [monster him] up inside. ");
    if (monster.hasBalls()) outputText("Your victims balls double in size the veins pulsing as your slushing presense causes them to easily triple in volume. You get a firm grip on your victim's gonads, ready to milk them for what the are worth. ");
    if (monster.hasVagina() && monster.hasCock()) outputText("Unsatisfied with your victim's cock alone, you go for the herm's other treasure, invading your victim deep");
    if (monster.hasVagina() && !monster.hasCock()) outputText("Once deep");
    if (monster.hasVagina()) outputText(" inside [monster his] vagina, flooding your gelatinous body all the way past the cervix, into the womb.");
    outputText("Whatever is left of you you pour straight into your victim's ass, fully flooding [monster his] innards all the way to the stomach, causing your body to bloat your opponents belly. <b>Its snacking time!</b>");
    
    var DurationLeft:int = player.statusEffectv1(StatusEffects.StraddleRoundLeft);
    monster.createStatusEffect(StatusEffects.SlimeInsert, 2 + rand(3), DurationLeft, 0, 0);
    player.removeStatusEffect(StatusEffects.StraddleRoundLeft);
    monster.removeStatusEffect(StatusEffects.Straddle);
}

public function straddleLeggoMyEggo():void {
    clearOutput();
    outputText("You let [themonster] go, prefering to continue the fight normally.");
    monster.removeStatusEffect(StatusEffects.Straddle);
    player.removeStatusEffect(StatusEffects.StraddleRoundLeft);
    outputText("[monster He] catches [monster his] breath before [monster he] stands back up, apparently prepared to fight some more. ");
    outputText("\n\n");
    enemyAIImpl();
}

public function DigOut():void {
    clearOutput();
    outputText("You dig back up to the surface, gasping for air.\n\n");
    monster.removeStatusEffect(StatusEffects.Dig);
    enemyAIImpl();
}

public function Guillotine():void {
    clearOutput();
    if (monster.plural) {
        if (player.fatigue + physicalCost(50) > player.maxOverFatigue()) {
            outputText("You are too tired to crush [themonster].");
            addButton(0, "Next", combatMenu, false);
            return;
        }
    } else {
        if (player.fatigue + physicalCost(20) > player.maxOverFatigue()) {
            outputText("You are too tired to crush [themonster].");
            addButton(0, "Next", combatMenu, false);
            return;
        }
    }
    fatigue(20, USEFATG_PHYSICAL);
    var damage:int = (monster.maxHP() * (.10 + rand(15) / 100) * 1.5) + meleeUnarmedDamageNoLagSingle(0,true);
    damage += scalingBonusToughness()*0.2;
    if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
    if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
    if (player.hasPerk(PerkLib.KrakenBlackDress)) damage *= 2;
    //Squeeze -
    outputText("You begin to crush your foe with your pincer, aiming to squeeze it to death in your mighty grip. You can feel it in your claw as [monster his] struggles intensify, smacking your armored pincher as hard as they can. \n\n[Themonster] takes ");
    doPhysicalDamage(damage, true, true);
    outputText(" damage.");
    //Enemy faints -
    if (monster.HP <= monster.minHP()) {
        outputText("\n\nYou can feel [themonster]'s life signs beginning to fade, and before you crush all the life from [monster him], you let go, dropping [monster him] to the floor, unconscious but alive.  In no time, [monster his]'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.\n\n");
        doNext(endHpVictory);
        return;
    }
    outputText("\n\n");
    enemyAIImpl();
}

public function ScyllaSqueeze():void {
    clearOutput();
    if (monster.plural) {
        if (player.fatigue + physicalCost(50) > player.maxOverFatigue()) {
            outputText("You are too tired to squeeze [themonster].");
            addButton(0, "Next", combatMenu, false);
            return;
        }
    } else {
        if (player.fatigue + physicalCost(20) > player.maxOverFatigue()) {
            outputText("You are too tired to squeeze [themonster].");
            addButton(0, "Next", combatMenu, false);
            return;
        }
    }
    if (monster.plural) {
        fatigue(50, USEFATG_PHYSICAL);
    } else fatigue(20, USEFATG_PHYSICAL);
    var damage:int = monster.maxHP() * (.10 + rand(15) / 100) * 1.5;
    if (player.isKraken()) {
        damage *= player.effectiveTallness / 25;
        damage += player.str;
    }
    damage = statusEffectBonusDamage(damage);
    if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
    if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
    if (monster.plural) damage *= 5;
    if (player.hasPerk(PerkLib.KrakenBlackDress)) damage *= 2;
    if (player.hasPerk(PerkLib.UnbreakableBind)) damage *= 2;
	if (player.perkv1(IMutationsLib.ScyllaInkGlandsIM) >= 2 && player.isKraken()) damage *= player.perkv1(IMutationsLib.ScyllaInkGlandsIM);
    if (player.hasStatusEffect(StatusEffects.ControlFreak)) damage *= player.statusEffectv1(StatusEffects.ControlFreak);
    //Squeeze -
    outputText("You start squeezing your");
    if (monster.plural) {
        outputText(" foes");
    } else {
        outputText(" foe");
    }
    outputText(" with your");
    if (monster.plural) {
        outputText(" tentacles");
    } else {
        outputText(" tentacle");
    }
    outputText(", leaving [monster him] short of breath. You can feel it in your tentacles as [monster his] struggles intensify. \n\n[Themonster] takes ");
    doPhysicalDamage(damage, true, true);
    outputText(" damage.");
    //Enemy faints -
    if (monster.HP <= monster.minHP()) {
        outputText("\n\nYou can feel [themonster]'s life signs beginning to fade, and before you crush all the life from [monster him], you let go, dropping [monster him] to the floor, unconscious but alive.  In no time, [monster his]'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
        if (monster.short == "demons")
            outputText("The others quickly back off, terrified at the idea of what you might do to them.");
        outputText("\n\n");
        doNext(endHpVictory);
        return;
    }
    outputText("\n\n");
    enemyAIImpl();
}

public function ScyllaTease():void {
    clearOutput();
    //(if poisoned)
    if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
        outputText("You casually caress your opponent with a free hand as you use one of your tentacles to expertly molest its bottom half.\n\n");
    } else if (monster.gender == 0) {
        outputText("You look over [themonster], but can't figure out how to tease such an unusual foe.\n\n");
    }
    if (monster.lustVuln == 0) {
        outputText("You casually caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
        enemyAIImpl();
        return;
    }
    //(Otherwise)
    else {
        var damage:Number;
        var chance:Number;
        //Tags used for bonus damage and chance later on
        //If auto = true, set up bonuses using above flags
        //==============================
        //Determine basic success chance.
        //==============================
        chance = 60;
        //1% chance for each tease level.
        chance += player.teaseLevel;
        //10% for seduction perk
        if (player.hasPerk(PerkLib.Seduction)) chance += 10;
        //10% for sexy armor types
        if (player.teaseDmgStat.value > 0) chance += 10;
        //10% for bimbo shits
        if (player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)) {
            chance += 10;
        }
        //2 & 2 for seductive valentines!
        if (player.hasPerk(PerkLib.SensualLover)) {
            chance += 2;
        }
        if (player.hasPerk(PerkLib.FlawlessBody)) chance += 10;
        //==============================
        //Determine basic damage.
        //==============================
        damage = combat.teases.teaseBaseLustDamage();
        chance += 2;
        //Specific cases for slimes and demons, as the normal ones would make no sense
        if (monster.short == "demons") {
            outputText("As you stimulate one of their brethren, the other demons can't help but to feel more aroused by this sight, all wishing to touch and feel the contact of your smooth, scaly body.");
        } else if (monster is GreenSlime) {
            outputText("You attempt to stimulate the slime despite its lack of any sex organs. Somehow, it works!");
        }
        //Normal cases for other monsters
        else {
            if (monster.gender == 1) {
                outputText("Your nimble tentacle begins to gently stroke his [monster cockshort], and you can see it on his face as he tries to hold back the fact that it feels good.");
            }
            if (monster.gender == 2) {
                outputText("Your nimble tentacle manages to work its way between her legs, grinding your tentacle's slippery skin against her clit. She appears to enjoy it, but it is obvious she is trying to hide it from you.");
            }
            if (monster.gender == 3) {
                outputText("Your nimble tentacle manages to work its way between [monster his] legs, gaining access to both sets of genitals. As your slippery skin rubs past [monster his] clit, your tentacle gently begins to stroke [monster his] cock. The repressed expression on [monster his] face betrays [monster his] own enjoyment of this kind of treatment.");
            }
        }
        //Land the hit!
        if (rand(100) <= chance) {
            //NERF TEASE DAMAGE
            damage *= .9;
            var damagemultiplier:Number = 1;
            if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
            if (player.hasPerk(PerkLib.UnbreakableBind)) damagemultiplier += 1;
            if (player.hasStatusEffect(StatusEffects.ControlFreak)) damagemultiplier += (2 - player.statusEffectv1(StatusEffects.ControlFreak));
            if (player.hasPerk(PerkLib.Sadomasochism)) damage *= player.sadomasochismBoost();
            damage *= damagemultiplier;
            damage = combat.teases.fueledByDesireDamageBonus(damage);
            //Determine if critical tease!
            var crit:Boolean = false;
            var critChance:int = 5;
            critChance += teases.combatTeaseCritical();
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
            if (rand(100) < critChance) {
                crit = true;
                damage *= 1.75;
                if (monster.lustVuln != 0 && player.hasPerk(PerkLib.SweepDefenses) && !monster.hasPerk(PerkLib.EnemyTrueAngel)) monster.lustVuln += 0.05;
            }
            if (player.hasPerk(PerkLib.KrakenBlackDress)) damage *= 2;
            monster.teased(Math.round(monster.lustVuln * damage));
            if (crit) outputText(" <b>Critical!</b>");
            teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
        }
        //Nuttin honey
        else {
            teaseXP(1);
            outputText("\n[Themonster] seems unimpressed.");
        }
        outputText("\n\n");
        combat.teases.fueledByDesireHeal();
        if (monster.lust >= monster.maxOverLust()) {
            doNext(endLustVictory);
            return;
        }
    }
    enemyAI();
}

public function ScyllaLeggoMyEggo():void {
    clearOutput();
    outputText("You release [themonster] from [monster his] bonds, and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
    outputText("\n\n");
    monster.removeStatusEffect(StatusEffects.ConstrictedScylla);
    enemyAIImpl();
}

public function SwallowWhole():void {
    flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
    clearOutput();
    if(player.fatigue + combat.physicalCost(10) > player.maxOverFatigue()) {
        outputText("You just don't have the energy to swallow someone right now...");
        //Gone		menuLoc = 1;
        menu();
        addButton(0, "Next", SceneLib.combat.combatMenu, false);
        return;
    }
    //Cannot be used on plural enemies
    if(monster.plural) {
        outputText("You begin to dig up toward [themonster], but with multiple enemies, swallowing one up would leave you completely open to attack.  You halt your progression and dig back down before you expose yourself to danger.[pg]");
        SceneLib.combat.enemyAIImpl();
        return;
    }
    if(monster.short == "pod") {
        outputText("You can't swallow something you're trapped inside of!");
        //Gone		menuLoc = 1;
        menu();
        addButton(0, "Next", SceneLib.combat.combatMenu, false);
        return;
    }
    fatigue(10, USEFATG_PHYSICAL);
    if (combat.checkConcentration("", true)) return; //Amily concentration... why(true) SceneLib.combat.enemyAIImpl(); and not enemyAI();? no idea

    outputText("You dig closer to [themonster] before surging out of the ground, flying briefly through the air as you open your enormous maw to draw [monster him] in!\n");
    if (rand(player.spe + 40) > monster.spe) {
        outputText("Unable to dodge in time, [monster name] is swallowed whole as you dig back underground!");
        monster.createStatusEffect(StatusEffects.Swallowed, 3 + rand(3), 0, 0, 0);
    }
    //Failure
    else {
        //Failure (-10 HPs) -
        outputText("[Themonster] begins running in panic to avoid you and barely manages to dive jump out of the way at the last second as you dig back underground.");
        player.takePhysDamage(5, true);
    }

    if (player.HP <= player.minHP()) {
        doNext(SceneLib.combat.endHpLoss);
        if (monster.hasStatusEffect(StatusEffects.Dig)) monster.removeStatusEffect(StatusEffects.Dig);
        return;
    }
    outputText("\n\n");
    SceneLib.combat.enemyAIImpl();
}

public function SwallowTease():void {
    clearOutput();
    //(if poisoned)
    if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
        outputText("You casually caress [themonster] with a free hand as you use some of your tentacles to expertly molest its bottom half.\n\n");
    } else if (monster.gender == 0) {
        outputText("You look over [themonster], but can't figure out how to tease such an unusual foe.\n\n");
    }
    if (monster.lustVuln == 0) {
        outputText("You casually caress your opponent with a free hand as you use some of your tentacles to expertly molest its bottom half, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
        enemyAIImpl();
        return;
    }
    //(Otherwise)
    else {
        var damage:Number;
        var chance:Number;
        //Tags used for bonus damage and chance later on
        //If auto = true, set up bonuses using above flags
        //==============================
        //Determine basic success chance.
        //==============================
        chance = 60;
        //1% chance for each tease level.
        chance += player.teaseLevel;
        //10% for seduction perk
        if (player.hasPerk(PerkLib.Seduction)) chance += 10;
        //10% for sexy armor types
        if (player.teaseDmgStat.value > 0) chance += 10;
        //10% for bimbo shits
        if (player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)) {
            chance += 10;
        }
        //2 & 2 for seductive valentines!
        if (player.hasPerk(PerkLib.SensualLover)) {
            chance += 2;
        }
        if (player.hasPerk(PerkLib.FlawlessBody)) chance += 10;
        //==============================
        //Determine basic damage.
        //==============================
        damage = combat.teases.teaseBaseLustDamage();
        chance += 2;
        //Specific cases for slimes and demons, as the normal ones would make no sense
        if (monster is GreenSlime) {
            outputText("You attempt to stimulate the slime despite its lack of any sex organs. Somehow, it works!");
        }
        //Normal cases for other monsters
        else {
            if (monster.gender == 1) {
                outputText("Your nimble tentacle begins to gently stroke his [monster cockshort], and you can see it on his face as he tries to hold back the fact that it feels good.");
            }
            if (monster.gender == 2) {
                outputText("Your nimble tentacle manages to work its way between her legs, grinding your tentacle's slippery skin against her clit. She appears to enjoy it, but it is obvious she is trying to hide it from you.");
            }
            if (monster.gender == 3) {
                outputText("Your nimble tentacle manages to work its way between [monster his] legs, gaining access to both sets of genitals. As your slippery skin rubs past [monster his] clit, your tentacle gently begins to stroke [monster his] cock. The repressed expression on [monster his] face betrays [monster his] own enjoyment of this kind of treatment.");
            }
        }
        //Land the hit!
        if (rand(100) <= chance) {
            //NERF TEASE DAMAGE
            damage *= .9;
            var damagemultiplier:Number = 1;
            if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
            if (player.hasPerk(PerkLib.UnbreakableBind)) damagemultiplier += 1;
            if (player.hasStatusEffect(StatusEffects.ControlFreak)) damagemultiplier += (2 - player.statusEffectv1(StatusEffects.ControlFreak));
            if (player.hasPerk(PerkLib.Sadomasochism)) damage *= player.sadomasochismBoost();
            damage *= damagemultiplier;
            damage = combat.teases.fueledByDesireDamageBonus(damage);
            //Determine if critical tease!
            var crit:Boolean = false;
            var critChance:int = 5;
            critChance += teases.combatTeaseCritical();
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
            if (rand(100) < critChance) {
                crit = true;
                damage *= 1.75;
                if (monster.lustVuln != 0 && player.hasPerk(PerkLib.SweepDefenses) && !monster.hasPerk(PerkLib.EnemyTrueAngel)) monster.lustVuln += 0.05;
            }
            monster.teased(Math.round(monster.lustVuln * damage));
            if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 20) {
                outputText("\n[Themonster] is so mesmerised by your show that it is stunned.");
                monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
            }
            if (crit) outputText(" <b>Critical!</b>");
            teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
        }
        //Nuttin honey
        else {
            teaseXP(1);
            outputText("\n[Themonster] seems unimpressed.");
        }
        outputText("\n\n");
        combat.teases.fueledByDesireHeal();
        if (monster.lust >= monster.maxOverLust()) {
            doNext(endLustVictory);
            return;
        }
    }
    enemyAI();
}

public function SwallowLeggoMyEggo():void {
    clearOutput();
    outputText("You rise to the surface and release [themonster] from [monster his] bonds, and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
    outputText("\n\n");
    monster.removeStatusEffect(StatusEffects.Swallowed);
    monster.removeStatusEffect(StatusEffects.Dig)
    SceneLib.combat.enemyAIImpl();
}

public function WhipStrangulate():void {
	clearOutput();
	if (player.fatigue + combat.physicalCost(20) > player.maxOverFatigue()) {
		outputText("You are too tired to strangulate [themonster].");
		addButton(0, "Next", SceneLib.combat.combatMenu, false);
		return;
	}
	fatigue(20, USEFATG_PHYSICAL);
	//Squeeze -
	outputText("You tighten the noose around your opponent's necks, your whip leaving red marks into the flesh. ");
	var damage:int = monster.maxHP() * (.10 + rand(15) / 100);
	damage = statusEffectBonusDamage(damage);
	if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
	if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
	if (player.hasPerk(PerkLib.UnbreakableBind)) damage *= 2;
	if (player.hasStatusEffect(StatusEffects.ControlFreak)) damage *= player.statusEffectv1(StatusEffects.ControlFreak);
	if (player.hasPerk(PerkLib.Sadomasochism)) damage *= player.sadomasochismBoost();
	damage = Math.round(damage);
	doPhysicalDamage(damage, true, true);
	//Enemy faints -
	if(monster.HP <= monster.minHP()) {
		outputText("You can feel [themonster]'s life signs beginning to fade, and before you squeeze all the life from [monster him], you let go, dropping [monster him] to the floor, unconscious but alive.  In no time, [monster his]'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
		if(monster.short == "demons")
			outputText("The others quickly back off, terrified at the idea of what you might do to them.");
		outputText("\n\n");
		doNext(endHpVictory);
		return;
	}
	outputText("\n\n");
	enemyAIImpl();
}

public function WhipLeggoMyEggo():void {
    clearOutput();
    outputText("You release [themonster] from your "+player.weaponName+", and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
    outputText("\n\n");
    monster.removeStatusEffect(StatusEffects.ConstrictedWhip);
    enemyAIImpl();
}

public function CrabLeggoMyEggo():void {
    clearOutput();
    outputText("You release [themonster] from your grip, and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
    outputText("\n\n");
    monster.removeStatusEffect(StatusEffects.CancerGrab);
    enemyAIImpl();
}

public function WebTease():void {
    clearOutput();
    //(if poisoned)
    if (monster.gender == 0) {
        outputText("You look over [themonster], but can't figure out how to tease such an unusual foe.\n\n");
    }
    if (monster.lustVuln == 0) {
        outputText("You giggle and run your hands against your victim's flesh, naughty bits purposely left exposed for you to grope and tease, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
        enemyAIImpl();
        return;
    }
    //(Otherwise)
    else {
        var damage:Number;
        var chance:Number;
        var bimbo:Boolean = false;
        var bro:Boolean = false;
        var futa:Boolean = false;
        //If auto = true, set up bonuses using above flags
        //==============================
        //Determine basic success chance.
        //==============================
        chance = 60;
        //1% chance for each tease level.
        chance += player.teaseLevel;
        //10% for seduction perk
        if (player.hasPerk(PerkLib.Seduction)) chance += 10;
        //10% for sexy armor types
        if (player.teaseDmgStat.value > 0) chance += 10;
        //10% for bimbo shits
        if (player.hasPerk(PerkLib.BimboBody)) {
            chance += 10;
            bimbo = true;
        }
        if (player.hasPerk(PerkLib.BroBody)) {
            chance += 10;
            bro = true;
        }
        if (player.hasPerk(PerkLib.FutaForm)) {
            chance += 10;
            futa = true;
        }
        //2 & 2 for seductive valentines!
        if (player.hasPerk(PerkLib.SensualLover)) {
            chance += 2;
        }
        if (player.hasPerk(PerkLib.FlawlessBody)) chance += 10;
        //==============================
        //Determine basic damage.
        //==============================
        damage = combat.teases.teaseBaseLustDamage();
        chance += 2;

        //Land the hit!
        if (rand(100) <= chance) {
            outputText("You giggle and run your hands against your helpless victim's flesh, their naughty bits purposely left exposed out of your web for you to groppe and play with.")
            
            var damagemultiplier:Number = 1;
            if (player.hasPerk(PerkLib.RacialParagon)) damagemultiplier *= RacialParagonAbilityBoost();
            if (player.hasPerk(PerkLib.UnbreakableBind)) damagemultiplier += 1;
            if (player.hasStatusEffect(StatusEffects.ControlFreak)) damagemultiplier += (2 - player.statusEffectv1(StatusEffects.ControlFreak));
            if (player.hasPerk(PerkLib.Sadomasochism)) damage *= player.sadomasochismBoost();
            damage *= damagemultiplier;
            damage = combat.teases.fueledByDesireDamageBonus(damage);
            //Determine if critical tease!
            var crit:Boolean = false;
            var critChance:int = 5;
            critChance += teases.combatTeaseCritical();
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
            if (rand(100) < critChance) {
                crit = true;
                damage *= 1.75;
                if (monster.lustVuln != 0 && player.hasPerk(PerkLib.SweepDefenses) && !monster.hasPerk(PerkLib.EnemyTrueAngel)) monster.lustVuln += 0.05;
            }
            monster.teased(Math.round(monster.lustVuln * damage), false);
            outputText(" Your unwilling toy makes an involuntary moan letting you know that your touch hit the mark.");
            if (crit) outputText(" <b>Critical!</b>");
            teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
        }
        //Nuttin honey
        else {
            teaseXP(1);
            outputText("\n[Themonster] seems unimpressed.");
        }
        outputText("\n\n");
        combat.teases.fueledByDesireHeal();
        if (monster.lust >= monster.maxOverLust()) {
            doNext(endLustVictory);
            return;
        }
    }
    enemyAI();
}

public function GooTease():void {
    clearOutput();
    //(if poisoned)
    if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
        outputText("You casually caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half.\n\n");
    } else if (monster.gender == 0) {
        outputText("You look over [themonster], but can't figure out how to tease such an unusual foe.\n\n");
    }
    if (monster.lustVuln == 0) {
        outputText("You casually caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
        enemyAIImpl();
        return;
    }
    //(Otherwise)
    else {
        var damage:Number;
        var chance:Number;
        var bimbo:Boolean = false;
        var bro:Boolean = false;
        var futa:Boolean = false;
        //If auto = true, set up bonuses using above flags
        //==============================
        //Determine basic success chance.
        //==============================
        chance = 60;
        //1% chance for each tease level.
        chance += player.teaseLevel;
        //10% for seduction perk
        if (player.hasPerk(PerkLib.Seduction)) chance += 10;
        //10% for sexy armor types
        if (player.teaseDmgStat.value > 0) chance += 10;
        //10% for bimbo shits
        if (player.hasPerk(PerkLib.BimboBody)) {
            chance += 10;
            bimbo = true;
        }
        if (player.hasPerk(PerkLib.BroBody)) {
            chance += 10;
            bro = true;
        }
        if (player.hasPerk(PerkLib.FutaForm)) {
            chance += 10;
            futa = true;
        }
        //2 & 2 for seductive valentines!
        if (player.hasPerk(PerkLib.SensualLover)) {
            chance += 2;
        }
        if (player.hasPerk(PerkLib.FlawlessBody)) chance += 10;
        //==============================
        //Determine basic damage.
        //==============================
        damage = combat.teases.teaseBaseLustDamage();
        chance += 2;

        //Land the hit!
        if (rand(100) <= chance) {
            outputText("You start to play with [themonster]'s body ");
            if (monster.gender == 1) {
                outputText("stroking his [monster cockshort] from inside of you to feast on his precum.");
            }
            if (monster.gender == 2) {
                outputText("forcefully filling her pussy and ass with your fluid form as you molest her breasts.");
            }
            if (monster.gender == 3) {
                outputText("forcefully filling her pussy and ass with your fluid form as you molest her breast. Unsatisfied with her female parts you also stroke her cock to feast on her precum.");
            }
            outputText(" This feels very pleasurable to you but not as much as to your opponent who starts to drool, shuddering at your ministration.");
            
            var damagemultiplier:Number = 1;
            if (player.hasPerk(PerkLib.RacialParagon)) damagemultiplier *= RacialParagonAbilityBoost();
            if (player.hasPerk(PerkLib.UnbreakableBind)) damagemultiplier += 1;
            if (player.hasStatusEffect(StatusEffects.ControlFreak)) damagemultiplier += (2 - player.statusEffectv1(StatusEffects.ControlFreak));
			damage *= damagemultiplier;
            damage = combat.teases.fueledByDesireDamageBonus(damage);
            
            if (player.hasPerk(PerkLib.Sadomasochism)) damage *= player.sadomasochismBoost();
			if (player.perkv1(IMutationsLib.SlimeMetabolismIM) >= 2) damage *= (1 + (0.25 * player.perkv1(IMutationsLib.SlimeMetabolismIM)));

            //Determine if critical tease!
            var crit:Boolean = false;
            var critChance:int = 5;
            critChance += teases.combatTeaseCritical();
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
            if (rand(100) < critChance) {
                crit = true;
                damage *= 1.75;
                if (monster.lustVuln != 0 && player.hasPerk(PerkLib.SweepDefenses) && !monster.hasPerk(PerkLib.EnemyTrueAngel)) monster.lustVuln += 0.05;
            }
            monster.teased(Math.round(monster.lustVuln * damage));
            if (crit) outputText(" <b>Critical!</b>");
            teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
        }
        //Nuttin honey
        else {
            teaseXP(1);
            outputText("\n[Themonster] seems unimpressed.");
        }
        outputText("\n\n");
        combat.teases.fueledByDesireHeal();
        if (monster.lust >= monster.maxOverLust()) {
            doNext(endLustVictory);
            return;
        }
    }
    enemyAI();
}

public function GooLeggoMyEggo():void {
    clearOutput();
    outputText("You release [themonster] from your body and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.\n\n");
    monster.removeStatusEffect(StatusEffects.GooEngulf);
    enemyAIImpl();
}

public function spiderBiteAttack():void {
    flags[kFLAGS.LAST_ATTACK_TYPE] = LAST_ATTACK_PHYS;
    clearOutput();
    if (monster is LivingStatue)
    {
        outputText("Your fangs can't even penetrate the giant's flesh.");
        enemyAIImpl();
        return;
    }
    if(monster.lustVuln == 0) outputText("  Your aphrodisiac toxin has no effect!");
    else {
        outputText("You pull [themonster] in  wriggling close and sink in your fangs, injecting your venom right into [monster his] bloodstream!");
        var lustDmg:Number = 35 + rand(player.lib / 10);
        var poisonScaling:Number = 1;
        var dam4Baa:Number = 1;
        if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) dam4Baa *= 2;
        poisonScaling += player.lib/100;
        poisonScaling += player.tou/100;
        if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= RacialParagonAbilityBoost();
        if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg *= 1.50;
        if (player.level < 10) lustDmg += 20 + (player.level * 3);
        else if (player.level < 20) lustDmg += 50 + (player.level - 10) * 2;
        else if (player.level < 30) lustDmg += 70 + (player.level - 20) * 1;
        else lustDmg += 80;
        lustDmg *= 0.2;
        lustDmg *= dam4Baa;
        lustDmg *= 1+(poisonScaling/10);
        poisonScaling *= dam4Baa;
        if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
        if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
        monster.teased(Math.round(monster.lustVuln * lustDmg), true);
        monster.statStore.addBuffObject({tou:-poisonScaling}, "Poison",{text:"Poison"});
        if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
            monster.addStatusValue(StatusEffects.NagaVenom, 3, 1);
        } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
        if (player.hasPerk(PerkLib.WoundPoison)){
            if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
            else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
        }
    }
    outputText("\n\n");
    WrathGenerationPerHit2(5);
    player.tailVenom -= player.VenomWebCost() * 5;
    flags[kFLAGS.VENOM_TIMES_USED] += 1;
    enemyAIImpl();
}

public function ManticoreFeed():void {
    clearOutput();
    if (monster.lustVuln == 0) {
        outputText("You attempt to suck out the cum from your victim's penis, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
        enemyAIImpl();
        return;
    }
    //(Otherwise)
    else {
        var damage:Number;
        var bimbo:Boolean = false;
        var bro:Boolean = false;
        var futa:Boolean = false;
        //==============================
        //Determine basic success chance.
        //==============================
        //10% for seduction perk
        if (player.hasPerk(PerkLib.BimboBody)) bimbo = true;
        if (player.hasPerk(PerkLib.BroBody)) bro = true;
        if (player.hasPerk(PerkLib.FutaForm)) futa = true;
        //==============================
        //Determine basic damage.
        //==============================
        damage = combat.teases.teaseBaseLustDamage();
        
        outputText("You use your tail-cunt vaginal walls to forcefully milk your victim for his delicious cum, biting your own lips at the pleasure of [monster his] twitching member in your tail.");
       
        var damagemultiplier:Number = 1;
        if (player.hasPerk(PerkLib.RacialParagon)) damagemultiplier *= RacialParagonAbilityBoost();
        if (player.perkv1(IMutationsLib.ManticoreMetabolismIM) >= 3) damagemultiplier *= 2;
        damage *= damagemultiplier;

        //Determine if critical tease!
        var crit:Boolean = false;
        var critChance:int = 5;
        critChance += teases.combatTeaseCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
            damage *= 1.75;
            if (monster.lustVuln != 0 && player.hasPerk(PerkLib.SweepDefenses) && !monster.hasPerk(PerkLib.EnemyTrueAngel)) monster.lustVuln += 0.05;
        }
        monster.teased(Math.round(monster.lustVuln * damage), false);
        if (crit) outputText(" <b>Critical!</b>");
        teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
        if (monster.lust>100)
        {
            outputText("\n\nYour partner cums, achieving orgasm from excessive arousal. You sigh in bliss as your victim fills your tail with a delicious load of cum.");
            if (player.hunger < player.maxHunger())
            {
                player.refillHunger(10, false);
            }
            EngineCore.HPChange(100 + (player.tou*2), true);
            EngineCore.changeFatigue(-(100 + (player.spe*2)));
            player.manticoreFeed();
            player.addStatusValue(StatusEffects.ManticorePlug,3,+1);
        }
    }
    //Nuttin honey
    outputText("\n\n");
    if (monster.lust >= monster.maxOverLust()) {
        doNext(endLustVictory);
        return;
    }
    enemyAI();
}

public function displacerFeedContinue():void {
    clearOutput();
    if (monster.lustVuln == 0) {
        outputText("You attempt to suck out the milk from your victim's breast, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
        enemyAIImpl();
        return;
    }
    //(Otherwise)
    else {
        var damage:Number;
        var bimbo:Boolean = false;
        var bro:Boolean = false;
        var futa:Boolean = false;
        //==============================
        //Determine basic success chance.
        //==============================
        //10% for seduction perk
        if (player.hasPerk(PerkLib.BimboBody)) bimbo = true;
        if (player.hasPerk(PerkLib.BroBody)) bro = true;
        if (player.hasPerk(PerkLib.FutaForm)) futa = true;
        //==============================
        //Determine basic damage.
        //==============================
        damage = combat.teases.teaseBaseLustDamage();
        
        outputText("You mewl in primal ecstasy at the passage of milk through your appendages, filling yourself with white vitality. Mmmmm delicious. Your opponent on the other end is getting increasingly flushed from the treatment.");
        
        var damagemultiplier:Number = 1;
        if (player.hasPerk(PerkLib.RacialParagon)) damagemultiplier *= RacialParagonAbilityBoost();
        damage *= damagemultiplier;

        //Determine if critical tease!
        var crit:Boolean = false;
        var critChance:int = 5;
        critChance += teases.combatTeaseCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
            damage *= 1.75;
            if (monster.lustVuln != 0 && player.hasPerk(PerkLib.SweepDefenses) && !monster.hasPerk(PerkLib.EnemyTrueAngel)) monster.lustVuln += 0.05;
        }
        monster.teased(Math.round(monster.lustVuln * damage), false);
        if (crit) outputText(" <b>Critical!</b>");
        teaseXP(1 + combat.bonusExpAfterSuccesfullTease());

        if (monster.lust>100)
        {
            outputText("\n\nYour partner cums, achieving boobgasm from excessive arousal. You sigh in bliss as an extra huge load of fresh milk floods into your tentacles.");
            if (player.hunger < player.maxHunger())
            {
                player.refillHunger(10, false);
            }
            EngineCore.HPChange(100 + (player.tou*2), true);
            EngineCore.changeFatigue(-(100 + (player.spe*2)));
            player.displacerFeed();
            player.addStatusValue(StatusEffects.DisplacerPlug,3,+1);
        }
    }
    //Nuttin honey
    outputText("\n\n");
    if (monster.lust >= monster.maxOverLust()) {
        doNext(endLustVictory);
        return;
    }
    enemyAI();
}

public function SlimeRapeFeed():void {
    clearOutput();
    if (monster.lustVuln == 0) {
        outputText("Despite your best effort you can't seem to stimulate your opponent using your fluidic body. Your foe clearly does not experience lust in the same way as you.\n\n");
        enemyAIImpl();
        return;
    }
    //(Otherwise)
    else {
        var damage:Number;
        var bimbo:Boolean = false;
        var bro:Boolean = false;
        var futa:Boolean = false;
        //==============================
        //Determine basic success chance.
        //==============================
        //10% for seduction perk
        if (player.hasPerk(PerkLib.BimboBody)) bimbo = true;
        if (player.hasPerk(PerkLib.BroBody)) bro = true;
        if (player.hasPerk(PerkLib.FutaForm)) futa = true;
        //==============================
        //Determine basic damage.
        //==============================
        damage = combat.teases.teaseBaseLustDamage();
        
        outputText("You begin to forcefully rape [Themonster] from the inside, wrecking [monster his] body as you attempt to extract fluids from [monster his] abused genitals.");
        
        var damagemultiplier:Number = 1;
        if (player.hasPerk(PerkLib.RacialParagon)) damagemultiplier *= RacialParagonAbilityBoost();
        damage *= damagemultiplier;

        //Determine if critical tease!
        var crit:Boolean = false;
        var critChance:int = 5;
        critChance += teases.combatTeaseCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
            damage *= 1.75;
            if (monster.lustVuln != 0 && player.hasPerk(PerkLib.SweepDefenses) && !monster.hasPerk(PerkLib.EnemyTrueAngel)) monster.lustVuln += 0.05;
        }
        monster.teased(Math.round(monster.lustVuln * damage), false);
        if (crit) outputText(" <b>Critical!</b>");
        teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
        
        if (monster.lust>100)
        {
            outputText("\n\nYour partner cums, achieving orgasm from excessive arousal. You drool in bliss as an extra huge load of fluids is injected into your body.");
            if (player.hunger < player.maxHunger())
            {
                player.refillHunger(10, false);
            }
            EngineCore.HPChange(100 + (player.tou*2), true);
            EngineCore.changeFatigue(-(100 + (player.spe*2)));
            player.slimeFeed();
            player.addStatusValue(StatusEffects.SlimeInsert,3,+1);
        }
    }
    //Nuttin honey
    outputText("\n\n");
    if (monster.lust >= monster.maxOverLust()) {
        doNext(endLustVictory);
        return;
    }
    enemyAI();
}

//Vampiric bite
public function VampiricBite():void {
    fatigue(20, USEFATG_PHYSICAL);
    if (monster.hasPerk(PerkLib.EnemyConstructType) || monster.hasPerk(PerkLib.EnemyPlantType)) {
        outputText("You gleefully bite in your foe but ");
        if (monster.hasPerk(PerkLib.EnemyConstructType)) {
            outputText("yelp in pain. This thing's skin is hard as rock...not surprising, since golems are made of solid stones.");
        }
        if (monster.hasPerk(PerkLib.EnemyPlantType)) {
            outputText("almost instantly spit it out. What manner of disgusting blood is this? Saps?");
        }
        outputText(" Your opponent makes use of your confusion to free itself.");
        HPChange((-100 * (1 + player.newGamePlusMod())), false);
        monster.removeStatusEffect(StatusEffects.EmbraceVampire);
        enemyAIImpl();
        return;
    }
    outputText("You bite [themonster] drinking deep of [monster his] blood ");
    var damage:int = player.maxHP() * 0.05;
    if (player.perkv1(IMutationsLib.HollowFangsIM) >= 2) damage += player.maxHP() * 0.02;
    if (player.perkv1(IMutationsLib.HollowFangsIM) >= 3) damage += player.maxHP() * 0.06;
    if (player.perkv1(IMutationsLib.HollowFangsIM) >= 4) damage += player.maxHP() * 0.12;
    if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
    if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
    damage = Math.round(damage);
    doPhysicalDamage(damage, true, true);
    EngineCore.HPChange(damage, false);
    outputText(" damage. You feel yourself grow stronger with each drop. ");
    var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
	var drinked:Number = 1;
    if (player.perkv1(IMutationsLib.HollowFangsIM) >= 3) drinked += 1;
    if (player.perkv1(IMutationsLib.HollowFangsIM) >= 4) drinked += 3;
    if (player.perkv1(IMutationsLib.VampiricBloodstreamIM) >= 4) drinked *= 2;
	if (player.hasPerk(PerkLib.BloodMastery)) drinked *= 2;
	if (player.racialScore(Races.VAMPIRE) >= 10) drinked *= 2;
    thirst.drink(drinked);
    if (monster.gender != 0 && monster.lustVuln != 0) {
        var lustDmg:int = (10 + (player.lib * 0.1)) * monster.lustVuln;
        if (player.perkv1(IMutationsLib.HollowFangsIM) == 3) lustDmg *= 1.5;
        if (player.perkv1(IMutationsLib.HollowFangsIM) == 4) lustDmg *= 2;
        if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= RacialParagonAbilityBoost();
        if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
        if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
        lustDmg = Math.round(monster.lustVuln * lustDmg);
        outputText(" [monster he] can’t help but moan, aroused from the aphrodisiac in your saliva for ");
        monster.teased(lustDmg);
        outputText(".");
    }
    //Enemy faints -
    if (monster.HP <= monster.minHP()) {
        outputText("You can feel [themonster]'s life signs beginning to fade, and before you crush all the life from [monster him], you let go, dropping [monster him] to the floor, unconscious but alive.  In no time, [monster his] eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
        if (monster.short == "demons")
            outputText("The others quickly back off, terrified at the idea of what you might do to them.");
        outputText("\n\n");
        doNext(combat.endHpVictory);
        return;
    }
    outputText("\n\n");
    if (monster.hasStatusEffect(StatusEffects.HypnosisNaga)) monster.removeStatusEffect(StatusEffects.HypnosisNaga);
    if (player.hasStatusEffect(StatusEffects.StraddleRoundLeft)) {
        player.addStatusValue(StatusEffects.StraddleRoundLeft, 1, -1);
        if (player.statusEffectv1(StatusEffects.StraddleRoundLeft) <= 0) {
            monster.removeStatusEffect(StatusEffects.Straddle);
            player.removeStatusEffect(StatusEffects.StraddleRoundLeft);
            outputText("\n\nYour opponent finally manages to struggle free of your grapple!\n\n");
        }
    }
    enemyAIImpl();
}

public function VampireLeggoMyEggo():void {
    clearOutput();
    outputText("You let your opponent free, ending your embrace.");
    outputText("\n\n");
    monster.removeStatusEffect(StatusEffects.EmbraceVampire);
    enemyAIImpl();
}

//Claws Rend
public function clawsRendDamage():void {
    var damage:int = 0;
    damage += meleeUnarmedDamageNoLagSingle(0,true);
    if (player.arms.type == Arms.DISPLACER) damage*= 2; //Displacers got extra limbs to rend
    if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
    if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
    //Determine if critical!
    var crit:Boolean = false;
    var critChance:int;
    critChance = combatPhysicalCritical();
    if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
    if (rand(100) < critChance) {
        crit = true;
        damage *= 1.75;
    }
    damage = Math.round(damage);
    doPhysicalDamage(damage, true, true);
    if (crit) outputText(" <b>Critical!</b>");
    if (player.hasPerk(PerkLib.PhantomStrike)) doPhysicalDamage(damage, true, true);
}

public function clawsRend():void {
    clearOutput();
    if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(40, USEFATG_PHYSICAL);
    else fatigue(20, USEFATG_PHYSICAL);
    outputText("You begin to rend [themonster] with your claws. ");
    clawsRendDamage();
    if (player.hasPerk(PerkLib.WeaponClawsClawTraining)) {
        clawsRendDamage();
    }
    if (player.hasPerk(PerkLib.WeaponClawsExtraClawAttack)) {
        clawsRendDamage();
    }
    if (player.hasPerk(PerkLib.WeaponClawsMultiClawAttack)) {
        clawsRendDamage();
    }
    if (player.hasPerk(PerkLib.WeaponClawsClawingFlurry)) {
        clawsRendDamage();
    }
    if (player.hasPerk(PerkLib.WeaponClawsSavageRend)) {
        clawsRendDamage();
    }
    if (player.hasPerk(PerkLib.HistoryFeral) || player.hasPerk(PerkLib.PastLifeFeral)){
        clawsRendDamage();
    }
    if (monster.HP <= monster.minHP()) {
        doNext(combat.endHpVictory);
        return;
    }
    outputText("\n\n");
    enemyAIImpl();
}

public function displacerCombatFeed():void {
    clearOutput();
    fatigue(50, USEFATG_PHYSICAL);
    outputText("You lick your lips in anticipation as you hold your victim's arms to the ground and plug your two tentacle suckers to [monster him]'s breasts. [monster he] struggles, flushing red as you flood [monster his] nipples with your lactation inducing venom and begin to force the delicious milk out of [monster his] chest.\n\n");
    monster.createStatusEffect(StatusEffects.DisplacerPlug, 1 + rand(3), 0, 0, 0);
    addButton(0, "Next", SceneLib.combat.combatMenu, false);
}

public function PussyLeggoMyEggo():void {
    clearOutput();
    outputText("You let your opponent free ending your grapple.\n\n");
    if (monster.hasStatusEffect(StatusEffects.DisplacerPlug)) monster.removeStatusEffect(StatusEffects.DisplacerPlug);
    monster.removeStatusEffect(StatusEffects.Pounce);
    enemyAIImpl();
}

public function BreakOutWeb():void {
    clearOutput();
    outputText("You let your opponent free from your web.\n\n");
    monster.removeStatusEffect(StatusEffects.MysticWeb);
    enemyAIImpl();
}

//Naga Hypnosis
public function HypnosisHeal():void {
    clearOutput();
    useMana(30, USEMANA_WHITE_HEAL);
    darkRitualCheckDamage();
    outputText("You initiate a healing spell. ");
    CombatAbilities.Heal.doEffect(false);
    outputText("\n\nIt's only when you finish your casting that [themonster] snaps out of the hypnosis...But it's too late. ");
    if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
    statScreenRefresh();
    flags[kFLAGS.SPELLS_CAST]++;
    if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
    monster.removeStatusEffect(StatusEffects.HypnosisNaga);
    spellPerkUnlock();
    enemyAIImpl();
}

public function HypnosisDarknessShard():void {
    clearOutput();
    useMana(30, USEMANA_BLACK);
    darkRitualCheckDamage();
    outputText("You initiate a Darkness spell. ");
    CombatAbilities.DarknessShard.doEffect(false);
    CombatAbilities.DarknessShard.doEffect(false);
    outputText("\n\nIt's only when you finish your casting that [themonster] snaps out of the hypnosis. Their eyes widen just in time to receive a darkness shard to the gut.");
    if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
    statScreenRefresh();
    flags[kFLAGS.SPELLS_CAST]++;
    if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
    monster.removeStatusEffect(StatusEffects.HypnosisNaga);
    spellPerkUnlock();
    enemyAIImpl();
}

public function HypnosisDuskWave():void {
    clearOutput();
    useMana(30, USEMANA_BLACK);
    darkRitualCheckDamage();
    outputText("You initiate a Darkness spell. ");
    CombatAbilities.DuskWave.doEffect(false);
    CombatAbilities.DuskWave.doEffect(false);
    outputText("\n\nIt's only when you finish your casting that [themonster] snaps out of the hypnosis. Your wave of darkness bowls over your foe.");
    if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
    statScreenRefresh();
    flags[kFLAGS.SPELLS_CAST]++;
    if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
    monster.removeStatusEffect(StatusEffects.HypnosisNaga);
    spellPerkUnlock();
    enemyAIImpl();
}

public function HypnosisAttack():void {
    basemeleeattacks();
}

public function HypnosisCoil():void {
    clearOutput();
    outputText("You maintain eye contact with the target, insidiously coiling your tail around it. ");
    if (rand(4) == 0) {
        outputText("It's only when you are fully wrapped around your victim that [themonster] snaps out of it.");
        monster.createStatusEffect(StatusEffects.Constricted, 1 + rand(4), 0, 0, 0);
        monster.removeStatusEffect(StatusEffects.HypnosisNaga);
    } else {
        var Duuuration:Number = monster.statusEffectv1(StatusEffects.HypnosisNaga);
        outputText("You maintain the trance, smiling as you prolong the mesmerising dance, moving your hips from side to side and displaying your assets. [Themonster] is lost in your gaze, and unable to act.");
        monster.createStatusEffect(StatusEffects.Constricted, Duuuration, 0, 0, 0);
    }
    enemyAIImpl();
}

public function HypnosisMaintain():void {
    clearOutput();
    var damagemultiplier:Number = 1;
    if (player.armorName == "desert naga pink and black silk dress") damagemultiplier += 0.1;
    if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
    if (player.armor == armors.ELFDRES && player.isElf()) damagemultiplier += 2;
    if (player.armor == armors.FMDRESS && player.isWoodElf()) damagemultiplier += 2;
    var lustDmg:int = (10 + (player.lib * 0.1)) * monster.lustVuln;
    lustDmg *= damagemultiplier;
    lustDmg = Math.round(lustDmg);
    outputText("You maintain the trance, smiling as you prolong the mesmerising dance, moving your hips from side to side and displaying your assets. [Themonster] is lost in your gaze, and unable to act. ");
    monster.teased(lustDmg);
    outputText("\n\n");
    enemyAIImpl();
}

//Bear hug
public function bearHug():void {
    fatigue(30, USEFATG_PHYSICAL);
    outputText("You squeeze [themonster] with a mighty hug, slowly crushing the life out of [monster him]. ");
    var damage:int = 0;
    damage += meleeUnarmedDamageNoLagSingle(0,true);
    if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) {
        damage += player.str;
        damage += scalingBonusStrength() * 0.5;
    }
    damage += player.tou;
    damage += scalingBonusToughness() * 0.5;
    if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
    if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
    damage = Math.round(damage);
    doPhysicalDamage(damage, true, true);
    if (monster.HP <= monster.minHP()) {
        doNext(combat.endHpVictory);
        return;
    }
    outputText("\n\n");
    enemyAIImpl();
}

public function BearLeggoMyEggo():void {
    clearOutput();
    outputText("You let your opponent free, ending your grab.\n\n");
    monster.removeStatusEffect(StatusEffects.GrabBear);
    enemyAIImpl();
}

public function taintedMindAttackAttempt():void {
    clearOutput();
    outputText("You ready an attack, but find your hands groping your own body instead. Somehow the demon’s magic has made it impossible to strike at him, crossing wires that weren’t meant to be crossed. Frowning, you look down at your more aroused form, determined not to fall for this a second time.");
    player.takeLustDamage(15, true);
    enemyAIImpl();
}

public function activateSwordIntentAura():void {
	flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
	clearOutput();
	var soulforcecost:int = 10 * soulskillCost() * soulskillcostmulti();
	player.soulforce -= soulforcecost;
	activateSwordIntentAura2();
}
public function activateSwordIntentAura2():void {
	fatigue(10, USEFATG_PHYSICAL);
	outputText("Holding out your palm, you conjure sword energy that dances across your fingertips.  Then is spread all over your weapons!\n\n");
	var temp1:Number = 0;
	var temp2:Number = 0.05;
	var tempSpe:Number;
	if (player.hasPerk(PerkLib.SwordImmortalFirstForm)) temp2 += 0.15;
	temp1 += player.speStat.core.value * temp2;
	temp1 = Math.round(temp1);
	var oldHPratio:Number = player.hp100/100;
	tempSpe = temp1;
	mainView.statsView.showStatUp('spe');
	player.buff("SwordIntentAura").addStats({spe:tempSpe}).withText("Sword Intent Aura").combatPermanent();
	player.HP = oldHPratio*player.maxHP();
	statScreenRefresh();
	enemyAI();
}
public function deactivateSwordIntentAura():void {
	clearOutput();
	outputText("You disperse sword intent aura coating weapons.");
	player.buff("SwordIntentAura").remove();
	enemyAI();
}

//Heal Zenji
public function HealZenji():void {
    outputText("Noticing the injuries Zenji has sustained in efforts to protect you, you channel some magic to heal him.\n\n");
    outputText("Zenji readies his spear, wedging himself between you and your opponent, \"<i>I am stronger! Thank you, [name]!</i>\"\n\n");
    var recharge:Number = player.statusEffectv3(StatusEffects.CombatFollowerZenji);
    player.addStatusValue(StatusEffects.CombatFollowerZenji, 3, -recharge);
    enemyAIImpl();
}

public function runAway(callHook:Boolean = true):void {
    if (flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] != 0){
        //outputText("Now that the fight's over, you go and retrieve your melee weapon from the ground where they knocked it out your hands.\n");
        player.setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
        flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = 0;
    }
    if(flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] != 0){
        //outputText("Now that the fight's over, you go and retrieve your ranged weapon from the ground where they knocked it out your hands.\n");
        player.setWeaponRange(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID]) as WeaponRange);
        flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] = 0;
    }
    if (callHook && monster.onPcRunAttempt != null) {
        monster.onPcRunAttempt();
        return;
    }
    clearOutput();
    if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 4) {
        clearOutput();
        outputText("You try to run, but you just can't seem to escape.  <b>Your ability to run was sealed, and now you've wasted a chance to attack!</b>\n\n");
        enemyAIImpl();
        return;
    }
    //Rut doesnt let you run from dicks.
    if (player.inRut && monster.cockTotal() > 0) {
        clearOutput();
        outputText("The thought of another male in your area competing for all the pussy infuriates you. There will be <i>no</i> competition to mate!");
        //Pass false to combatMenu instead:		menuLoc = 3;
        //		doNext(combatMenu);
        menu();
        addButton(0, "Next", combatMenu, false);
        return;
    }
    if (monster.hasStatusEffect(StatusEffects.Level) && player.canFly() && monster is SandTrap) {
        clearOutput();
        outputText("You flex the muscles in your back and, shaking clear of the sand, burst into the air!  Wasting no time you fly free of the sandtrap and its treacherous pit.  \"One day your wings will fall off, little ant,\" the snarling voice of the thwarted androgyne carries up to you as you make your escape.  \"And I will be waiting for you when they do!\"");
        inCombat = false;
        clearStatuses(false);
        endEncounter();
        return;
    }
    if (monster.hasStatusEffect(StatusEffects.Dig)) {
        clearOutput();
        outputText("You tunnel away from your opponent, escaping the fight and fleeing back to camp.\n");
        inCombat = false;
        clearStatuses(false);
        endEncounter();
        return;
    }
    if (monster.hasStatusEffect(StatusEffects.GenericRunDisabled) || SceneLib.urtaQuest.isUrta()) {
        outputText("You can't escape from this fight!");
//Pass false to combatMenu instead:		menuLoc = 3;
//		doNext(combatMenu);
        menu();
        addButton(0, "Next", combatMenu, false);
        return;
    }
    if (monster.hasStatusEffect(StatusEffects.AlrauneRunDisabled)) {
        if (player.hasKeyItem("Torch") < 0){
            clearOutput();
            outputText("You burn away the vines and run for it, much to the frustration of the [monster name]. You’re thankful that she’s this slow.\n");
            inCombat = false;
            clearStatuses(false);
            endEncounter();
            return;
        }
        else{
            outputText("You are currently being grappled by [monster name] vines, there's no way for you to simply break free!");
            menu();
            addButton(0, "Next", combatMenu, false);
            return;
        }
    }
    if (player.lowerBody == LowerBody.FIRE_SNAIL) {
        outputText("You're too slow to escape from this fight!");
        //Pass false to combatMenu instead:		menuLoc = 3;
        //		doNext(combatMenu);
        menu();
        addButton(0, "Next", combatMenu, false);
        return;
    }
    if (player.isRaceCached(Races.JIANGSHI)) {
        outputText("Your cadaverous rigidity prevents any form of escape in battle!");
        //Pass false to combatMenu instead:		menuLoc = 3;
        //		doNext(combatMenu);
        menu();
        addButton(0, "Next", combatMenu, false);
        return;
    }
    if (player.statStore.hasBuff("Supercharged") && monster.short != "training dummy" && monster.short != "training dummies") {
        outputText("Run...SERIOUSLY? There is no way you could run! You need to discharge NOW! Your genitals are glistening with dripping plasma. You need to FUCK!");
        if (monster.isHerm() && player.isHerm()) outputText(" Cock or cunt you don't even care! All you WANT is for that herm to fuck you wildly until your charge is gone!");
        else{
            if(monster.hasCock() && player.hasVagina()) outputText("Your drooling outlet DEMANDS that plug!");
            else if(player.hasCock() && monster.hasVagina()) outputText("Your drooling plug DEMANDS that outlet!");
        }
        //Pass false to combatMenu instead:		menuLoc = 3;
        //		doNext(combatMenu);
        menu();
        addButton(0, "Next", combatMenu, false);
        return;
    }
    if (monster.hasStatusEffect(StatusEffects.Level) && monster.statusEffectv1(StatusEffects.Level) < 4 && monster is SandTrap) {
        outputText("You're too deeply mired to escape!  You'll have to <b>climb</b> some first!");
        //Pass false to combatMenu instead:		menuLoc = 3;
        //		doNext(combatMenu);
        menu();
        addButton(0, "Next", combatMenu, false);
        return;
    }
    if (monster.hasStatusEffect(StatusEffects.RunDisabled)) {
        outputText("You'd like to run, but you can't scale the walls of the pit, not with so many demonic hands pulling you down!");
        //Pass false to combatMenu instead:		menuLoc = 3;
        //		doNext(combatMenu);
        menu();
        addButton(0, "Next", combatMenu, false);
        return;
    }
    if (monster is MinotaurMob && (monster as MinotaurMob).wastedTurn) {
        (monster as MinotaurMob).wastedTurn = false;
        //(Free run away)
        clearOutput();
        outputText("You slink away while the pack of brutes is arguing.  Once they finish that argument, they'll be sorely disappointed!");
        inCombat = false;
        clearStatuses(false);
        endEncounter();
        return;
    } else if (monster.short == "minotaur tribe" && monster.HPRatio() >= 0.75) {
        clearOutput();
        outputText("There's too many of them surrounding you to run!");
        //Pass false to combatMenu instead:		menuLoc = 3;
        //		doNext(combatMenu);
        menu();
        addButton(0, "Next", combatMenu, false);
        return;
    }
    if (inDungeon || inRoomedDungeon) {
        clearOutput();
        if (monster is HellfireSnail) {
            outputText("You run as fast as you can, taking random corridors and running past the confused enemies all the way back to the labyrinth entrance. You lose the slug-woman quickly, however your flight attracts more attention, forcing you all the way back to the surface. \n\n");
            SceneLib.dungeons.ebonlabyrinth.room = 1;
            SceneLib.dungeons.ebonlabyrinth.depth = 0;
            inCombat = false;
            clearStatuses(false);
            doNext(playerMenu);
        } else if (monster is TwinBosses) {
			SceneLib.dungeons.riverdungeon.almostdefeatedByTwinBosses();
		} else {
            outputText("You're trapped in your foe's domain - there is nowhere to run!\n\n");
            enemyAIImpl();
		}
        return;
    }
    //Attempt texts!
    if (monster is Marae) {
        outputText("Your boat is blocked by tentacles! ");
        if (!player.canFly()) outputText("You will not be able to swim fast enough. ");
        else outputText("You grit your teeth with effort as you try to fly away but the tentacles suddenly grab your [legs] and pull you down. ");
        outputText("It looks like you cannot escape. ");
        enemyAIImpl();
        return;
    }
    if (monster is Ember) {
        outputText("You take off");
        if (!player.canFly()) outputText(" running");
        else outputText(", flapping as hard as you can");
        outputText(", and Ember, caught up in the moment, gives chase.  ");
    }
    if (monster.short == "lizan rogue") {
        outputText("As you retreat the lizan doesn't even attempt to stop you. When you look back for him, you find nothing but the empty bog around you.");
        CoC.instance.inCombat = false;
        clearStatuses(false);
        endEncounter();
        return;
    }
    if (monster is TrainingDummy) {
        outputText("As you retreat the training dummy just stands there. ");
    }
	if (player.hasStatusEffect(StatusEffects.LockingCurse)) {
		if (player.statusEffectv1(StatusEffects.LockingCurse) == 1) {
			outputText("The anubis acursed magic prevents you from escaping as an invisible wall blocks your path!");
			enemyAIImpl();
			return;
		}
		if (player.statusEffectv1(StatusEffects.LockingCurse) == 0 && !monster.hasStatusEffect(StatusEffects.Dig)) {
			if (player.canFly()) {
				clearOutput();
				outputText("Gritting your teeth with effort, you beat your wings quickly and lift off!  Wasting no time you fly away.");
				inCombat = false;
				clearStatuses(false);
				endEncounter();
				return;
			}
			else {
				outputText("The anubis has you surrounded by h"+(monster.hasVagina()?"er":"is")+" pet, there is no escape by land!");
				enemyAIImpl();
				return;
			}
		}
	}
    else if (player.canFly() && !player.hasStatusEffect(StatusEffects.FlyingDisabled)) {
        var wingsNoFlap:Array = [Wings.ETHEREAL, Wings.LEVITATION, Wings.THUNDEROUS_AURA, Wings.WINDY_AURA];
        if(!(wingsNoFlap.indexOf(player.wings.type) >= 0)){
            outputText("Gritting your teeth with effort, you beat your wings quickly and lift off!  ");
        }
        else{
            outputText("You leap into the air, and hover in the sky!  ");
        }
    }

    //Nonflying PCs
    else {
        //Stuck!
        if (player.hasStatusEffect(StatusEffects.NoFlee)) {
            clearOutput();
            if (monster.short == "goblin") outputText("You try to flee, but get stuck in the sticky white goop surrounding you.\n\n");
            else outputText("You put all your skills at running to work, ducking and diving in an effort to escape, but are unable to get away!\n\n");
            enemyAIImpl();
            return;
        }
        //Nonstuck!
        else outputText("You turn tail and attempt to flee!  ");
    }

    //Calculations
    var escapeMod:Number = 20 + monster.level * 3;
    if (debug) escapeMod -= 300;
    if (player.tailType == Tail.RACCOON && player.ears.type == Ears.RACCOON && player.hasPerk(PerkLib.Runner)) escapeMod -= 25;
    if (monster.hasStatusEffect(StatusEffects.Stunned)) escapeMod -= 50;
    if (player.hasStatusEffect(StatusEffects.Snow) && player.effectiveTallness < 84) escapeMod += 200;
    if (player.effectiveTallness < 48 && player.isBiped()) {
        if (player.hasKeyItem("Nitro Boots") >= 0) escapeMod -= 20;
        if (player.hasKeyItem("Rocket Boots") >= 0) escapeMod -= 40;
        if (player.hasKeyItem("Spring Boots") >= 0) escapeMod -= 60;
    }
    if (player.canFly() && !player.hasStatusEffect(StatusEffects.FlyingDisabled)) escapeMod -= 20;

    //Big tits doesn't matter as much if ya can fly!
    else {
        if (player.biggestTitSize() >= 35) escapeMod += 5;
        if (player.biggestTitSize() >= 66) escapeMod += 10;
        if (player.hips.type >= 20) escapeMod += 5;
        if (player.butt.type >= 20) escapeMod += 5;
        if (player.ballSize >= 24 && player.hasBalls()) escapeMod += 5;
        if (player.ballSize >= 48 && player.hasBalls()) escapeMod += 10;
        if (player.ballSize >= 120 && player.hasBalls()) escapeMod += 10;
    }
    //ANEMONE OVERRULES NORMAL RUN
    if (monster is Anemone) {
        //Autosuccess - less than 60 lust
        if (player.lust < (player.maxLust() * 0.6)) {
            clearOutput();
            outputText("Marshalling your thoughts, you frown at the strange girl and turn to march up the beach.  After twenty paces inshore you turn back to look at her again.  The anemone is clearly crestfallen by your departure, pouting heavily as she sinks beneath the water's surface.");
            inCombat = false;
            clearStatuses(false);
            endEncounter();
            return;
        }
        //Speed dependent
        else {
            //Success
            if (player.spe > rand(monster.spe + escapeMod)) {
                inCombat = false;
                clearStatuses(false);
                clearOutput();
                outputText("Marshalling your thoughts, you frown at the strange girl and turn to march up the beach.  After twenty paces inshore you turn back to look at her again.  The anemone is clearly crestfallen by your departure, pouting heavily as she sinks beneath the water's surface.");
                endEncounter();
                return;
            }
            //Run failed:
            else {
                outputText("You try to shake off the fog and run, but the anemone slinks over to you and her tentacles wrap around your waist.  <i>\"Stay?\"</i> she asks, pressing her small breasts into you as a tentacle slides inside your [armor] and down to your nethers.  The combined stimulation of the rubbing and the tingling venom causes your knees to buckle, hampering your resolve and ending your escape attempt.");
                //(gain lust, temp lose spd/str)
                (monster as Anemone).applyVenom((4 + player.effectiveSensitivity() / 20));
                combatRoundOver();
                return;
            }
        }
    }
    //SEA ANEMONE OVERRULES NORMAL RUN
    if (monster is SeaAnemone) {
        //Autosuccess - less than 60 lust
        if (player.lust < (player.maxLust() * 0.6)) {
            clearOutput();
            outputText("Marshalling your thoughts, you frown at the strange girl and turn to march up the beach.  After twenty paces inshore you turn back to look at her again.  The anemone is clearly crestfallen by your departure, pouting heavily as she sinks beneath the water's surface.");
            inCombat = false;
            clearStatuses(false);
            endEncounter();
            return;
        }
        //Speed dependent
        else {
            //Success
            if (player.spe > rand(monster.spe + escapeMod)) {
                inCombat = false;
                clearStatuses(false);
                clearOutput();
                outputText("Marshalling your thoughts, you frown at the strange girl and turn to march up the beach.  After twenty paces inshore you turn back to look at her again.  The anemone is clearly crestfallen by your departure, pouting heavily as she sinks beneath the water's surface.");
                endEncounter();
                return;
            }
            //Run failed:
            else {
                outputText("You try to shake off the fog and run, but the anemone slinks over to you and her tentacles wrap around your waist.  <i>\"Stay?\"</i> she asks, pressing her small breasts into you as a tentacle slides inside your [armor] and down to your nethers.  The combined stimulation of the rubbing and the tingling venom causes your knees to buckle, hampering your resolve and ending your escape attempt.");
                //(gain lust, temp lose spd/str)
                (monster as SeaAnemone).applyVenom((4 + player.effectiveSensitivity() / 20));
                combatRoundOver();
                return;
            }
        }
    }
    //Ember is SPUCIAL
    if (monster is Ember) {
        //GET AWAY
        if (player.spe > rand(monster.spe + escapeMod) || (player.hasPerk(PerkLib.Runner) && rand(100) < 50)) {
            if (player.hasPerk(PerkLib.Runner)) outputText("Using your skill at running, y");
            else outputText("Y");
            outputText("ou easily outpace the dragon, who begins hurling imprecations at you.  \"What the hell, [name], you weenie; are you so scared that you can't even stick out your punishment?\"");
            outputText("\n\nNot to be outdone, you call back, \"Sucks to be you!  If even the mighty Last Ember of Hope can't catch me, why do I need to train?  Later, little bird!\"");
            inCombat = false;
            clearStatuses(false);
            endEncounter();
        }
        //Fail:
        else {
            outputText("Despite some impressive jinking, " + SceneLib.emberScene.emberMF("he", "she") + " catches you, tackling you to the ground.\n\n");
            enemyAIImpl();
        }
        return;
    }
    //SUCCESSFUL FLEE
    if ((player.spe > rand(monster.spe + escapeMod)) || monster.hasPerk(PerkLib.AlwaysSuccesfullRunaway)) {
        //Fliers flee!
        if (player.canFly() && !player.hasStatusEffect(StatusEffects.FlyingDisabled)) outputText("[Themonster] can't catch you.");
        //sekrit benefit: if you have coon ears, coon tail, and Runner perk, change normal Runner escape to flight-type escape
        else if (player.tailType == Tail.RACCOON && player.ears.type == Ears.RACCOON && player.hasPerk(PerkLib.Runner)) {
            outputText("Using your running skill, you build up a head of steam and jump, then spread your arms and flail your tail wildly; your opponent dogs you as best [monster he] can, but stops and stares dumbly as your spastic tail slowly propels you several meters into the air!  You leave [monster him] behind with your clumsy, jerky, short-range flight.");
        }
        //Non-fliers flee
        else {
            if (monster.short == "training dummy" || monster.short == "training dummies") outputText("When you look back you see "+(monster.short == "training dummies" ? "they're" : "it's")+" still in the same spot seemly grinning at you.");
            else outputText("[Themonster] rapidly disappears into the shifting landscape behind you.");
        }
        if (monster is Izma) {
            outputText("\n\nAs you leave the tigershark behind, her taunting voice rings out after you.  \"<i>Oooh, look at that fine backside!  Are you running or trying to entice me?  Haha, looks like we know who's the superior specimen now!  Remember: next time we meet, you owe me that ass!</i>\"  Your cheek tingles in shame at her catcalls.");
        }
        inCombat = false;
        clearStatuses(false);
        endEncounter();
        return;
    }
    //Runner perk chance
    else if (player.hasPerk(PerkLib.Runner) && rand(100) < 50) {
        inCombat = false;
        outputText("Thanks to your talent for running, you manage to escape.");
        if (monster is Izma) {
            outputText("\n\nAs you leave the tigershark behind, her taunting voice rings out after you.  \"<i>Oooh, look at that fine backside!  Are you running or trying to entice me?  Haha, looks like we know who's the superior specimen now!  Remember: next time we meet, you owe me that ass!</i>\"  Your cheek tingles in shame at her catcalls.");
        }
        clearStatuses(false);
        endEncounter();
        return;
    }
    else if (onlyZenjiRunnawayTrain()) {
        outputText("You tell Zenji that you need to run, you can't handle these opponents.");
        outputText("\n\nZenji immediately hoists you on his shoulder and makes a break for it");
        if (rand(4) > 0) {
            outputText(", leaving your opponent in the dust.");
            inCombat = false;
            clearStatuses(false);
            endEncounter();
            return;
        }
        else outputText(". Despite his best attempt, he is unable to drag the two of you to safety. He stumbles, barely managing to gently set you on the ground as you resume combat.");
    }
    //FAIL FLEE
    else {
        if (monster is Holli) {
            (monster as Holli).escapeFailWithHolli();
            return;
        }
        //Flyers get special failure message.
        if (player.canFly() && !player.hasStatusEffect(StatusEffects.FlyingDisabled)) {
            if (monster.plural) outputText("[Themonster] manage to grab your [legs] and drag you back to the ground before you can fly away!");
            else outputText("[Themonster] manages to grab your [legs] and drag you back to the ground before you can fly away!");
        }
        //fail
        else if (player.tailType == Tail.RACCOON && player.ears.type == Ears.RACCOON && player.hasPerk(PerkLib.Runner)) outputText("Using your running skill, you build up a head of steam and jump, but before you can clear the ground more than a foot, your opponent latches onto you and drags you back down with a thud!");
        //Nonflyer messages
        else {
            //Huge balls messages
            if (player.hasBalls() && player.ballSize >= 24) {
                if (player.ballSize < 48) outputText("With your [balls] swinging ponderously beneath you, getting away is far harder than it should be.  ");
                else outputText("With your [balls] dragging along the ground, getting away is far harder than it should be.  ");
            }
            //FATASS BODY MESSAGES
            if (player.biggestTitSize() >= 35 || player.butt.type >= 20 || player.hips.type >= 20) {
                //FOR PLAYERS WITH GIANT BREASTS
                if (player.biggestTitSize() >= 35 && player.biggestTitSize() < 66) {
                    if (player.hips.type >= 20) {
                        outputText("Your [hips] forces your gait to lurch slightly side to side, which causes the fat of your [color] ");
                        if (player.butt.type >= 20) outputText("[butt] and ");
                        outputText(chestDesc() + " to wobble immensely, throwing you off balance and preventing you from moving quick enough to escape.");
                    } else if (player.butt.type >= 20) outputText("Your [color] [butt] and [chest] wobble and bounce heavily, throwing you off balance and preventing you from escaping.");
                    else outputText("Your [chest] jiggle and wobble side to side like the [color] sacks of milky fat they are, with enough force to constantly throw you off balance, preventing you from escaping.");
                }
                //FOR PLAYERS WITH MASSIVE BREASTS
                else if (player.biggestTitSize() >= 66) {
                    if (player.hips.type >= 20) {
                        outputText("Your [chest] nearly drag along the ground while your [hips] swing side to side ");
                        if (player.butt.type >= 20) outputText("causing the fat of your [color] [butt] to wobble, ");
                        outputText("forcing you off balance and preventing you from escaping.");
                    } else if (player.butt.type >= 20) outputText("Your [chest] nearly drag along the ground while the fat of your [color] [butt] wobbles heavily from side to side, forcing your body off balance and preventing you from moving quick enough to escape.");
                    else outputText("Your [chest] nearly drag along the ground, preventing you from moving quick enough to get escape.");
                }
                //FOR PLAYERS WITH EITHER GIANT HIPS OR BUTT BUT NOT THE BREASTS
                else if (player.hips.type >= 20) {
                    outputText("Your [hips] swing heavily from side to side ");
                    if (player.butt.type >= 20) outputText("causing your [color] [butt] to wobble obscenely ");
                    outputText(", forcing your body into an awkward gait that prevents you from escaping.");
                }
                //JUST DA BOOTAH
                else if (player.butt.type >= 20) outputText("Your " + player.bodyColor + buttDescript() + " wobbles so heavily that you're unable to move quick enough to escape.");
            }
            //NORMAL RUN FAIL MESSAGES
            else if (monster.plural) outputText("[Themonster] stay hot on your heels, denying you a chance at escape!");
            else outputText("[Themonster] stays hot on your heels, denying you a chance at escape!");
        }
    }
    outputText("\n\n");
    enemyAI();
}
public function onlyZenjiRunnawayTrain():Boolean {
    var partySize:Number = 1;
    if (flags[kFLAGS.PLAYER_COMPANION_0] != "") partySize += 1;
    if (flags[kFLAGS.PLAYER_COMPANION_1] != "") partySize += 1;
    if (flags[kFLAGS.PLAYER_COMPANION_2] != "") partySize += 1;
    if (flags[kFLAGS.PLAYER_COMPANION_3] != "") partySize += 1;
    return (player.hasStatusEffect(StatusEffects.CombatFollowerZenji) && partySize == 2);
}

public function struggleCreepingDoom():void {
    outputText("You shake away the pests in disgust, managing to get rid of them for a time.\n\n");
    monster.removeStatusEffect(StatusEffects.CreepingDoom);
    enemyAIImpl();
}

public function takeFlightWings():void {
    clearOutput();
    if (player.wings.type == Wings.WINDY_AURA && player.arms.type == Arms.KAMAITACHI) outputText("You create a small cyclone to ride upon and lift yourself up in the air.\n\n");
    else if (player.wings.type == Wings.THUNDEROUS_AURA) outputText("You take flight, letting the storm carry you up.\n\n");
    else if (player.wings.type == Wings.ETHEREAL) outputText("You take flight, letting the storm carry you up.\n\n");
    else if (player.wings.type == Wings.LEVITATION) outputText("You take flight, letting the storm carry you up.\n\n");
    else outputText("You open your wings, taking off.\n\n");
    player.createStatusEffect(StatusEffects.Flying, flightDurationNatural(), 0, 0, 0);
    takeFlight();
}
public function takeFlightByFlyingSword():void {
    clearOutput();
    outputText("You jump on your "+player.weaponFlyingSwordsName+", riding it skyward.\n\n");
    player.createStatusEffect(StatusEffects.Flying, 1, 1, 0, 0);
    takeFlight();
}
public function takeFlightNoWings():void {
    clearOutput();
    outputText("You surround your body with soulforce, taking off into the air"+(player.weaponFlyingSwordsName != "nothing"?" as "+player.weaponFlyingSwordsName+" hover near you ready to be used at moment notice":"")+".\n\n");
    player.createStatusEffect(StatusEffects.Flying, 1, 2, 0, 0);
    takeFlight();
}
public function takeFlight():void {
    if (player.hasPerk(PerkLib.Resolute) < 0) {
        player.createStatusEffect(StatusEffects.FlyingNoStun, 0, 0, 0, 0);
        player.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
    }
    monster.createStatusEffect(StatusEffects.MonsterAttacksDisabled, 0, 0, 0, 0);
    enemyAIImpl();
}
public function flightDurationNatural():Number {
    var flightDurationNatural:Number = 7;
    if (player.hasPerk(PerkLib.AdvancedAerialCombat)) flightDurationNatural += 2;
    if (player.hasPerk(PerkLib.GreaterAerialCombat)) flightDurationNatural += 4;
    return flightDurationNatural;
}

public function landAfterUsingFlyingSword():void {
    clearOutput();
    outputText("You descend to the ground and step down from your "+player.weaponFlyingSwordsName+".\n\n");
    if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
        player.removeStatusEffect(StatusEffects.FlyingNoStun);
        player.removePerk(PerkLib.Resolute);
    }
    monster.removeStatusEffect(StatusEffects.MonsterAttacksDisabled);
    player.removeStatusEffect(StatusEffects.Flying);
    doNext(combatMenu, false);
}
public function landAfterUsingSoulforce():void {
    clearOutput();
    outputText("You descend to the ground.\n\n");
    if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
        player.removeStatusEffect(StatusEffects.FlyingNoStun);
        player.removePerk(PerkLib.Resolute);
    }
    monster.removeStatusEffect(StatusEffects.MonsterAttacksDisabled);
    player.removeStatusEffect(StatusEffects.Flying);
    doNext(combatMenu, false);
}

public function greatDive():void {
    flags[kFLAGS.LAST_ATTACK_TYPE] = LAST_ATTACK_SPELL;
    clearOutput();
    if (player.fatigue + physicalCost(50) > player.maxOverFatigue()) {
        clearOutput();
        outputText("You are too tired to perform a great dive.");
        doNext(combatMenu);
        return;
    }
    doNext(combatMenu);
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
    fatigue(50, USEFATG_PHYSICAL);
    var damage:Number = 0;
    damage += meleeUnarmedDamageNoLagSingle(0,true);
    damage += player.spe * 2;
    if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) {
        damage += player.str;
        damage += player.spe * 2;
    }
    if (player.perkv1(IMutationsLib.HarpyHollowBonesIM) >= 1) damage *= 1.2;
    if (player.perkv1(IMutationsLib.HarpyHollowBonesIM) >= 2) damage *= 1.5;
    if (player.perkv1(IMutationsLib.HarpyHollowBonesIM) >= 3) damage *= 2;
    if (Forgefather.channelInlay == "emerald" && Forgefather.refinement == 3) damage *= 1.25;
    if (Forgefather.channelInlay == "emerald" && Forgefather.refinement == 4) damage *= 1.5;
    if (Forgefather.gem == "emerald" && Forgefather.refinement == 3) damage *= 1.12;
    if (Forgefather.gem == "emerald" && Forgefather.refinement == 4) damage *= 1.25;
    outputText("You focus on [Themonster], ");
    if (player.statusEffectv2(StatusEffects.Flying) == 0) outputText("fold your wings and dive");
    if (player.statusEffectv2(StatusEffects.Flying) == 1) outputText("direct your "+player.weaponFlyingSwordsName+" downward");
    if (player.statusEffectv2(StatusEffects.Flying) == 2) outputText("fold your arms and dive");
    outputText(", using gravity to increase the impact");
    if (player.hasPerk(PerkLib.DeathPlunge)) {
        damage = weaponAttackModifier(damage);
        outputText(" of your [weapon]. Your [weapon] strikes true, inflicting severe wounds as ");
        if (player.lowerBody == LowerBody.HARPY && player.statusEffectv2(StatusEffects.Flying) != 1) {
            outputText("your talons leave a bloody trail across your foe");
            damage *= 1.5;
        }
        else outputText("the rest of your body collides against your target" + (monster.plural?"s":"") + "");
        if (player.statusEffectv2(StatusEffects.Flying) > 0 && player.weaponFlyingSwordsName != "nothing") {
            outputText(". At the same time " + player.weaponFlyingSwordsName+" impales your target" + (monster.plural?"s":"") + "");
            damage = flyingSwordAttackModifier(damage);
        }
        if (player.haveWeaponForJouster()) {
            var JousterDamageMod:Number = 1;
            if (player.isMeetingNaturalJousterReq()) JousterDamageMod += 2;
            if (player.isMeetingNaturalJousterMasterGradeReq()) JousterDamageMod += 2;
            if (player.isPolearmTypeWeapon()) JousterDamageMod *= 0.75;
			if (player.thirdtierWingsForWingSlap()) JousterDamageMod *= 2;
			damage *= JousterDamageMod;
        }
        damage *= (1 + PASPAS(1));
    } else {
        if (player.lowerBody == LowerBody.HARPY && player.statusEffectv2(StatusEffects.Flying) != 1) {
            outputText(" making a bloody trail with your talons");
            damage *= 1.5;
        }
        else outputText(" hitting your target with violence");
        if (player.statusEffectv2(StatusEffects.Flying) > 0 && player.weaponFlyingSwordsName != "nothing") {
            outputText(". At the same time " + player.weaponFlyingSwordsName+" impales your target" + (monster.plural?"s":"") + "");
            damage = flyingSwordAttackModifier(damage);
        }
    }
    if (player.hasPerk(PerkLib.SpiritedDive)) {
        if (monster.plural) damage *= 5;
        else damage *= 1.5;
    }
    var crit:Boolean = false;
    var critChance:int = 5;
    critChance += combatPhysicalCritical();
    if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
    if (player.hasPerk(PerkLib.DeathPlunge)) {
        if (player.hasPerk(PerkLib.WeaponMastery) && player.weapon.isSingleLarge() && player.str >= 100) critChance += 10;
        if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weapon.isDualLarge() && player.str >= 140) critChance += 10;
        if (player.hasPerk(PerkLib.GigantGripEx) && (player.weapon.isMassive())) {
            if (player.str >= 100) critChance += 10;
            if (player.str >= 140) critChance += 10;
        }
    }
    if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
    if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
    if (rand(100) < critChance) {
        crit = true;
        var buffMultiplier:Number = 0;
        buffMultiplier += bonusCriticalDamageFromMissingHP();
        if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * impaleMultiplier());
        else damage *= (1.75 + buffMultiplier);
    }
    outputText(".");
    damage = Math.round(damage);
    doPhysicalDamage(damage, true, true);
    if (crit) {
        outputText("<b>Critical! </b>");
        if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
    }
    if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
        if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
        else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
    }
    if (((!player.perkv1(IMutationsLib.HarpyHollowBonesIM) >= 3 || (!Forgefather.channelInlay == "emerald")) && player.statusEffectv1(StatusEffects.Flying) == 0) || player.statusEffectv2(StatusEffects.Flying) != 3) {
        if (player.isFlying()) player.removeStatusEffect(StatusEffects.Flying);
        if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
            player.removeStatusEffect(StatusEffects.FlyingNoStun);
            player.removePerk(PerkLib.Resolute);
        }
        monster.removeStatusEffect(StatusEffects.MonsterAttacksDisabled);
    }
    checkAchievementDamage(damage);
    enemyAIImpl();
}

public function impaleMultiplier():Number {
	var impaleM:Number = 0;
	if (player.spe >= 2000) impaleM += 2;
	else {
		impaleM += Math.round(player.spe * 0.05);
		impaleM *= 0.01;
		impaleM += 1;
	}
    return impaleM;
}

public function notAttackWithBloodPuppies():void {
    clearOutput();
    menu();
    outputText("You decided not to attack with your blood puppies this turn\n\n");
    
    //Set flag to show that you've already chosen not to attack this turn
    flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] = 1;

    if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn))
		addButton(0, "Next", combatMenu, false);
}

public function asuraformCost():Number {
    var modcsc:Number = 25;
    if (player.hasPerk(PerkLib.AsuraStrength)) modcsc += 25;
    if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) modcsc += 25;
	if (player.hasPerk(PerkLib.JobWarrior) && player.hasPerk(PerkLib.AsuraToughness)) {
		if (player.perkv1(IMutationsLib.HumanMusculatureIM) >= 3 && player.racialScore(Races.HUMAN) > 17) modcsc += 2;
		else modcsc += 5;
	}
    if (player.hasPerk(PerkLib.ItsZerkingTime) && (player.hasPerk(PerkLib.Berzerker) || player.hasPerk(PerkLib.Lustzerker) || player.countRings(jewelries.FLLIRNG))) {
		if (player.hasPerk(PerkLib.Berzerker)) modcsc += 5;
		if (player.hasPerk(PerkLib.Lustzerker) || player.countRings(jewelries.FLLIRNG)) modcsc += 5;
	}
    //if (player.hasPerk(PerkLib.)) modcsc += 20;
    return modcsc;
}
public function assumeAsuraForm():void {
    clearOutput();
    player.wrath -= asuraformCost();
    outputText("As you starts to unleash your inner wrath two additional faces emerge from head"+(player.faceType == Face.CERBERUS?"s":"")+" on sides and " + (player.playerHasFourArms() ? "":"two ") + "additional pair" + (player.playerHasFourArms() ? "":"s") + " of arms grows under your " + (player.playerHasFourArms() ? "second":"first") + " pair" + (player.playerHasFourArms() ? "s":"") + " of arms. ");
    if (player.hasPerk(PerkLib.AsuraStrength)) {
        outputText("Additionaly from your back emerge ");
		if (player.hasPerk(PerkLib.ItsZerkingTime)) outputText("three ");
		else if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) outputText("two ");
        outputText("pair ");
        outputText("of semi-transparent arms. ");
    }
    outputText("Finishing assuming Asura form you're ready to destroy anyone that would dare to stand in your way!\n\n");
    assumeAsuraForm007();
	if (player.hasPerk(PerkLib.JobWarrior) && player.hasPerk(PerkLib.AsuraToughness)) mspecials.warriorsrage007();
	if (player.hasPerk(PerkLib.ItsZerkingTime) && (player.hasPerk(PerkLib.Berzerker) || player.hasPerk(PerkLib.Lustzerker) || player.countRings(jewelries.FLLIRNG))) {
		if (player.hasPerk(PerkLib.Berzerker)) {
			if (player.hasPerk(PerkLib.PrestigeJobBerserker)) player.createStatusEffect(StatusEffects.Berzerking,0,1,0,0);
			else player.createStatusEffect(StatusEffects.Berzerking,0,0,0,0);
		}
		if (player.hasPerk(PerkLib.Lustzerker) || player.countRings(jewelries.FLLIRNG)) {
			if (player.hasPerk(PerkLib.PrestigeJobBerserker)) player.createStatusEffect(StatusEffects.Lustzerking,0,1,0,0);
			else player.createStatusEffect(StatusEffects.Lustzerking,0,0,0,0);
		}
	}
    statScreenRefresh();
    enemyAIImpl();
}
public function assumeAsuraForm007():void {
    var temp1:Number = 0;
    var temp2:Number = 0;
    var temp3:Number = 0;
    var tempStr:Number;
    var tempTou:Number;
    var tempSpe:Number;
    temp1 += player.strStat.core.value * 0.6;
    temp2 += player.touStat.core.value * 0.3;
    temp3 += player.speStat.core.value * 0.2;
    if (player.hasPerk(PerkLib.AsuraStrength)) {
        temp1 += player.strStat.core.value * 0.6;
        temp2 += player.touStat.core.value * 0.3;
        temp3 += player.speStat.core.value * 0.2;
    }
    if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) {
        temp1 += player.strStat.core.value * 0.6;
        temp2 += player.touStat.core.value * 0.3;
        temp3 += player.speStat.core.value * 0.2;
    }
    if (player.hasPerk(PerkLib.ItsZerkingTime)) {
        temp1 += player.strStat.core.value * 0.6;
        temp2 += player.touStat.core.value * 0.3;
        temp3 += player.speStat.core.value * 0.2;
    }
    temp1 = Math.round(temp1);
    temp2 = Math.round(temp2);
    temp3 = Math.round(temp3);
    var oldHPratio:Number = player.hp100/100;
    tempStr = temp1;
    tempTou = temp2;
    tempSpe = temp3;
    mainView.statsView.showStatUp('str');
    mainView.statsView.showStatUp('tou');
    mainView.statsView.showStatUp('spe');
    player.buff("AsuraForm").addStats({str:tempStr,tou:tempTou,spe:tempSpe}).withText("Asura Form").combatPermanent();
    player.HP = oldHPratio*player.maxHP();
}
public function returnToNormalShape():void {
    clearOutput();
    outputText("Gathering all you willpower you forcefully subduing your inner rage and returning to your normal shape.");
	//if (perkBonusDamage po asura toughness)
    player.statStore.removeBuffs("AsuraForm");
	if (player.buff("WarriorsRage").getRemainingTicks() > 9000) player.statStore.removeBuffs("WarriorsRage");
    enemyAIImpl();
}

public function asurasHowl():void {
    clearOutput();
    player.wrath -= 100;
    var heal:Number = 0;
    heal += scalingBonusIntelligence() * 2;
    if (player.hasPerk(PerkLib.WisenedHealer)) heal += scalingBonusWisdom() * 2;
    heal *= healMod() * 2;
    if (player.armorName == "skimpy nurse's outfit") heal *= 1.4;
    if (player.weaponName == "unicorn staff") heal *= 2;
    if (player.hasPerk(PerkLib.CloseToDeath) && player.HP < (player.maxHP() * 0.25)) {
        if (player.hasPerk(PerkLib.CheatDeath) && player.HP < (player.maxHP() * 0.1)) heal *= 4;
        else heal *= 2;
    }
    if (player.hasPerk(PerkLib.AbsoluteStrength)) {
		var add:Number = 1.2;
		if (player.hasPerk(PerkLib.AsuraStrength)) add += 0.4;
		if (player.hasPerk(PerkLib.ICastAsuraFist)) add += 0.6;
		if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) add += 0.8;
		if (player.hasPerk(PerkLib.AsuraToughness)) add += 1;
		//
		//
		if (player.hasPerk(PerkLib.AsuraSpeed)) add += 1.6;
		heal *= add;
	}
    //Determine if critical heal!
    var crit:Boolean = false;
    var critHeal:int = 5;
    critHeal += combatMagicalCritical();
    if (rand(100) < critHeal) {
        crit = true;
        heal *= 2.5;
    }
    heal = Math.round(heal);
    outputText("Gathering all you wrath you unleash howl while your wounds healing a bit. <b>([font-heal]+" + heal + "[/font])</b>.");
    if (crit) outputText(" <b>*Critical Heal!*</b>");
    HPChange(heal,false);
    basemeleeattacks();
}

public function asuras6FingersOfDestruction():void {
	asurasXFingersOfDestruction("Six");
}
public function asuras8FingersOfDestruction():void {
	asurasXFingersOfDestruction("Eight");
}
public function asuras10FingersOfDestruction():void {
	asurasXFingersOfDestruction("Ten");
}
public function asuras12FingersOfDestruction():void {
	asurasXFingersOfDestruction("Twelve");
}
public function asurasXFingersOfDestruction(fingercount:String):void {
    clearOutput();
    var FoDMulti:Number = 1;
    FoDMulti += player.wrath100 * 0.03;
    if (player.hasPerk(PerkLib.JobWarrior) || player.hasPerk(PerkLib.JobBeastWarrior)) FoDMulti *= 2.5;
    if (player.hasPerk(PerkLib.PrestigeJobBerserker)) FoDMulti *= 2;
    if (player.hasPerk(PerkLib.VexedNocking)) FoDMulti *= 2;
    player.wrath -= Math.round(player.maxWrath() * 0.5);
    var damage:Number = 0;
    damage += meleeUnarmedDamageNoLagSingle();
    damage += ghostStrength();
    if (damage < 50) damage = 50;
    if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
        if (player.isRaceCached(Races.MOUSE, 2) && player.countRings(jewelries.INMORNG)) damage *= 2.2;
        else damage *= 2;
    }
    if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
    damage *= (1 + FoDMulti);
    var crit:Boolean = false;
    var critChance:int = 65;
    critChance += combatPhysicalCritical();
    if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
    if (rand(100) < critChance) {
        crit = true;
        if (player.hasStatusEffect(StatusEffects.AlterBindScroll4)) damage *= 2.75;
        else damage *= 1.75;
    }
    damage = Math.round(damage);
    outputText("You focus the force of your wrath, pushing the energy to the tip of your fingers. With a deep breath, you release the stored energy, thrusting it upon [themonster]. "+fingercount+" finger-shaped constructs materialize before you as they fly toward [themonster]. ");
    doPhysicalDamage(damage, true, true);
    doPhysicalDamage(damage, true, true);
    doPhysicalDamage(damage, true, true);
    doPhysicalDamage(damage, true, true);
    doPhysicalDamage(damage, true, true);
    doPhysicalDamage(damage, true, true);
	if (fingercount == "Eight") {
	    doPhysicalDamage(damage, true, true);
		doPhysicalDamage(damage, true, true);
	}
	if (fingercount == "Ten") {
		doPhysicalDamage(damage, true, true);
		doPhysicalDamage(damage, true, true);
		doPhysicalDamage(damage, true, true);
		doPhysicalDamage(damage, true, true);
	}
    if (crit) {
        outputText("<b>Critical! </b>");
        if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
    }
    outputText("\n\n");
    heroBaneProc(damage);
    EruptingRiposte();
    statScreenRefresh();
    enemyAIImpl();
}

public function sendSkeletonToFight():void {
    if (!monster.isFlying()) outputText("Your skeleton warrior"+(player.perkv2(PerkLib.PrestigeJobNecromancer) > 1 ? "s":"")+" charge into battle swinging "+(player.perkv2(PerkLib.PrestigeJobNecromancer) > 1 ? "their":"his")+" blade"+(player.perkv2(PerkLib.PrestigeJobNecromancer) > 1 ? "s":"")+" around. ");
    var damage:Number = 0;
    var dmgamp:Number = 1;
    damage += 1500 + rand(451);
    damage += scalingBonusIntelligence() * 0.6;
    damage += scalingBonusWisdom() * 1.2;
	damage *= soulskillMod();
	if (player.hasPerk(PerkLib.HistoryTactician) || player.hasPerk(PerkLib.PastLifeTactician)) damage *= historyTacticianBonus();
    if (player.hasPerk(PerkLib.GreaterHarvest)) dmgamp += 0.1;
    if (player.hasPerk(PerkLib.BoneSoul)) dmgamp += 0.1;
    if (player.hasPerk(PerkLib.SkeletonLord)) dmgamp += 0.1;
    if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
    if (flags[kFLAGS.WILL_O_THE_WISP] == 2) {
        dmgamp += 0.1;
        if (player.hasPerk(PerkLib.WispLieutenant)) dmgamp += 0.2;
        if (player.hasPerk(PerkLib.WispCaptain)) dmgamp += 0.3;
        if (player.hasPerk(PerkLib.WispMajor)) dmgamp += 0.4;
        if (player.hasPerk(PerkLib.WispColonel)) dmgamp += 0.5;
    }
    damage *= dmgamp;
	if (player.hasStatusEffect(StatusEffects.BonusEffectsNecroSet)) damage *= (1 + (0.1 * player.statusEffectv2(StatusEffects.BonusEffectsNecroSet)));
    //Determine if critical hit!
    var critChance:int = 5;
    critChance += combatPhysicalCritical();
    if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
    if (rand(100) < critChance)
        damage *= 1.75;
    damage = Math.round(damage);
	var sSWTF:Number = player.perkv2(PerkLib.PrestigeJobNecromancer);
	while (sSWTF-->0) doMinionPhysDamage(damage, true, true);
    outputText("\n\n");
    if (player.hasPerk(PerkLib.GreaterHarvest) && player.perkv1(PerkLib.GreaterHarvest) > 0) {
		outputText("Your archer"+(player.perkv1(PerkLib.GreaterHarvest) > 1 ? "s":"")+" "+(monster.isFlying()?"":"follow suit ")+"unleashing a volley of arrows. ");
		var sSATF:Number = player.perkv1(PerkLib.GreaterHarvest);
		while (sSATF-->0) doMinionPhysDamage(damage, true, true);
        outputText("\n\n");
        if (player.perkv2(PerkLib.GreaterHarvest) > 0) {
			outputText((monster.isFlying()?"S":"Finally the s")+"keletal mage"+(player.perkv2(PerkLib.GreaterHarvest) > 1 ? "s":"")+" unleash a barrage of magic missiles. ");
			var sSMTF:Number = player.perkv2(PerkLib.GreaterHarvest);
			while (sSMTF-->0) doMinionPhysDamage(damage, true, true);
        }
    }
    outputText("\n\n");
    //checkAchievementDamage(damage);
    statScreenRefresh();
	if (monster.HP <= monster.minHP()) doNext(endHpVictory);
    else {
		if (flags[kFLAGS.IN_COMBAT_PLAYER_SKELETONS_ATTACKED] < 1) {
			flags[kFLAGS.IN_COMBAT_PLAYER_SKELETONS_ATTACKED] = 1;
			if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) {
				menu();
				addButton(0, "Next", combatMenu, false);
			}
		}
		else enemyAIImpl();
	}
}
public function skeletonSmash():void {
    clearOutput();
    outputText("Your Skeletons upon command gang up on [themonster] swarming from all side and leaving [monster him] stunned. ");
    var damage:Number = 0;
    var dmgamp:Number = 1;
    damage += 1500 + rand(451);
    damage += scalingBonusIntelligence() * 0.6;
    damage += scalingBonusWisdom() * 1.2;
	damage *= soulskillMod();
	if (player.hasPerk(PerkLib.HistoryTactician) || player.hasPerk(PerkLib.PastLifeTactician)) damage *= historyTacticianBonus();
    if (player.hasPerk(PerkLib.GreaterHarvest)) dmgamp += 0.1;
    if (player.hasPerk(PerkLib.BoneSoul)) dmgamp += 0.1;
    if (player.hasPerk(PerkLib.SkeletonLord)) dmgamp += 0.1;
    if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
    if (flags[kFLAGS.WILL_O_THE_WISP] == 2) {
        dmgamp += 0.1;
        if (player.hasPerk(PerkLib.WispLieutenant)) dmgamp += 0.2;
        if (player.hasPerk(PerkLib.WispCaptain)) dmgamp += 0.3;
        if (player.hasPerk(PerkLib.WispMajor)) dmgamp += 0.4;
        if (player.hasPerk(PerkLib.WispColonel)) dmgamp += 0.5;
    }
    damage *= dmgamp;
	if (player.hasStatusEffect(StatusEffects.BonusEffectsNecroSet)) damage *= (1 + (0.1 * player.statusEffectv2(StatusEffects.BonusEffectsNecroSet)));
    if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 0) damage *= player.perkv2(PerkLib.PrestigeJobNecromancer);
    //Determine if critical hit!
    var critChance:int = 5;
    critChance += combatPhysicalCritical();
    if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
    if (rand(100) < critChance)
        damage *= 1.75;
    damage = Math.round(damage);
    doMinionPhysDamage(damage, true, true);
    monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
    //checkAchievementDamage(damage);
    outputText("\n\n");
    if (monster.HP <= monster.minHP()) doNext(endHpVictory);
    else enemyAIImpl();
}

public function noLimiterState():void {
    clearOutput();
		outputText("No Limiter on!\n\n");
    var tempStr:Number = player.str;
    mainView.statsView.showStatUp('str');
		player.buff("NoLimiterState").addStats({"str":tempStr}).withText("No Limiter").combatPermanent();
    statScreenRefresh();
    menu();
    addButton(0, "Next", combatMenu, false);
}
public function returnToNormalState():void {
    clearOutput();
		outputText("No Limiter off!\n\n");
    player.statStore.removeBuffs("NoLimiterState");
    menu();
    addButton(0, "Next", combatMenu, false);
}

public function StealthModeMechCost():Number {
    var SMMC:Number = 100;
    if (player.keyItemvX("HB Stealth System", 1) >= 2) SMMC -= 20;
    //if (player.keyItemv1("HB Stealth System") >= 3) SMMC -= 20;
    //SMMC -= 10;
    return SMMC;
}

public function fireDamageBoostedByDao():Number {
    var boostF:Number = 1;
    if (player.hasStatusEffect(StatusEffects.DaoOfFire))
        boostF += daoModifier(player.statusEffectv2(StatusEffects.DaoOfFire));
    return boostF;
}
public function iceDamageBoostedByDao():Number {
    var boostI:Number = 1;
    if (player.hasStatusEffect(StatusEffects.DaoOfIce))
        boostI += daoModifier(player.statusEffectv2(StatusEffects.DaoOfIce));
    return boostI;
}
public function lightningDamageBoostedByDao():Number {
    var boostL:Number = 1;
    if (player.hasStatusEffect(StatusEffects.DaoOfLightning))
        boostL += daoModifier(player.statusEffectv2(StatusEffects.DaoOfLightning));
    return boostL;
}
public function darknessDamageBoostedByDao():Number {
    var boostD:Number = 1;
    if (player.hasStatusEffect(StatusEffects.DaoOfDarkness))
        boostD += daoModifier(player.statusEffectv2(StatusEffects.DaoOfDarkness));
    return boostD;
}
public function poisonDamageBoostedByDao():Number {
    var boostP:Number = 1;
    if (player.hasStatusEffect(StatusEffects.DaoOfPoison))
        boostP += daoModifier(player.statusEffectv2(StatusEffects.DaoOfPoison));
    return boostP;
}
public function windDamageBoostedByDao():Number {
    var boostWi:Number = 1;
    if (player.hasStatusEffect(StatusEffects.DaoOfWind))
        boostWi += daoModifier(player.statusEffectv2(StatusEffects.DaoOfWind));
    return boostWi;
}
public function bloodDamageBoostedByDao():Number {
    var boostBl:Number = 1;
    if (player.hasStatusEffect(StatusEffects.DaoOfBlood))
        boostBl += daoModifier(player.statusEffectv2(StatusEffects.DaoOfBlood));
    return boostBl;
}
public function waterDamageBoostedByDao():Number {
    var boostWa:Number = 1;
    if (player.hasStatusEffect(StatusEffects.DaoOfWater))
        boostWa += daoModifier(player.statusEffectv2(StatusEffects.DaoOfWater));
    return boostWa;
}
public function earthDamageBoostedByDao():Number {
    var boostEa:Number = 1;
    if (player.hasStatusEffect(StatusEffects.DaoOfEarth))
        boostEa += daoModifier(player.statusEffectv2(StatusEffects.DaoOfEarth));
    return boostEa;
}
public function acidDamageBoostedByDao():Number {
    var boostAc:Number = 1;
    if (player.hasStatusEffect(StatusEffects.DaoOfAcid))
        boostAc += daoModifier(player.statusEffectv2(StatusEffects.DaoOfAcid));
    return boostAc;
}
public function daoModifier(daoLevel:Number):Number {
    if (daoLevel == 9) return 1.5;
    if (daoLevel == 8) return 1.3;
    if (daoLevel == 7) return 1.1;
    if (daoLevel == 6) return 0.9;
    if (daoLevel == 5) return 0.7;
    if (daoLevel == 4) return 0.5;
    if (daoLevel == 3) return 0.3;
    if (daoLevel == 2) return 0.2;
    if (daoLevel == 1) return 0.1;
    return 0;
}

public function purityScalingDA():Number {
    var purityScalingDA:Number = 1;
    if (monster.cor < 33) purityScalingDA *= 0.6;
    else if (monster.cor < 50) purityScalingDA *= 1.2;
    else if (monster.cor < 75) purityScalingDA *= 1.8;
    else if (monster.cor < 90) purityScalingDA *= 2.4;
    else purityScalingDA *= 3;
    return purityScalingDA;
}
public function corruptionScalingDA():Number {
	var corruptionScalingDA:Number = 1;
    if (monster.cor >= 66) corruptionScalingDA *= 0.6;
    else if (monster.cor >= 50) corruptionScalingDA *= 1.2;
    else if (monster.cor >= 25) corruptionScalingDA *= 1.8;
    else if (monster.cor >= 10) corruptionScalingDA *= 2.4;
    else corruptionScalingDA *= 3;
    return corruptionScalingDA;
}
/* Can provide a scaling or additive bonus to damage depending on usage. Uses player.cor in function to assign scaling.
Uses Damage *= pcScalingBonusCorruption(player.cor); for scaling.
 */
public function pcScalingBonusCorruption(corStat:int):Number{
    var scalingNum:Number;
    if (corStat == 100) scalingNum = 1.5;
    else if (corStat >= 85) scalingNum = 1.35;
    else if (corStat >= 70) scalingNum = 1.2;
    else if (corStat >= 55) scalingNum = 1;
    else if (corStat >= 40) scalingNum = 0.75;
    else if (corStat >= 25) scalingNum = 0.5;
    else scalingNum = 0.1;
    return scalingNum;
}

public function oniRampagePowerMulti():Number {
    var oniRampagePowerMulti:Number = 3;
    if (player.perkv1(IMutationsLib.OniMusculatureIM) >= 2) oniRampagePowerMulti += 1;
    if (player.perkv1(IMutationsLib.OniMusculatureIM) >= 3) oniRampagePowerMulti += 2;
    return oniRampagePowerMulti;
}

public function tyrantStagePowerMulti():Number {
    var tyrantStagePowerMulti:Number = 1.5;
    if (TyrantiaFollower.TyrantiaTrainingSessions >= 10) tyrantStagePowerMulti += 0.2;
    return tyrantStagePowerMulti;
}

public function meleePhysicalForce():Number {
    var mod:Number = 1;
    if (player.hasPerk(PerkLib.JobWarrior)) mod += .1;
    if (player.hasPerk(PerkLib.JobBrawler)) mod += .2;
    if (player.hasPerk(PerkLib.JobSwordsman)) mod += .2;
    if (player.hasPerk(PerkLib.JobDervish)) mod += .2;
    if (player.hasPerk(PerkLib.JobRogue)) mod += .2;
    if (player.hasPerk(PerkLib.JobMonk)) mod += .2;
    if (player.hasPerk(PerkLib.JobBeastWarrior)) mod += .2;
    if (player.hasPerk(PerkLib.ThunderousStrikes)) mod += .05;
    if (player.hasPerk(PerkLib.BrutalBlows)) mod += .05;
    if (player.hasPerk(PerkLib.FuriousStrikes)) mod += .05;
    if (player.hasPerk(PerkLib.IronFistsI)) mod += .05;
    if (player.hasPerk(PerkLib.IronFistsII)) mod += .05;
    if (player.hasPerk(PerkLib.IronFistsIII)) mod += .05;
    if (player.hasPerk(PerkLib.Brute)) mod += .05;
    if (player.hasPerk(PerkLib.Brawn)) mod += .05;
	if (player.hasPerk(PerkLib.PowerAttack)) mod += .05;
    if (player.hasPerk(PerkLib.IronFistsIV)) mod += .1;
    if (player.hasPerk(PerkLib.IronFistsV)) mod += .1;
    if (player.hasPerk(PerkLib.IronFistsVI)) mod += .1;
    if (player.hasPerk(PerkLib.UnlimitedRage)) mod += .1;
    if (player.hasPerk(PerkLib.GigantGrip)) mod += .1;
    if (player.hasPerk(PerkLib.ImprovedBrute)) mod += .1;
    if (player.hasPerk(PerkLib.ImprovedBrawn)) mod += .1;
    if (player.hasPerk(PerkLib.ThirstForBlood)) mod += .15;
    if (player.hasPerk(PerkLib.GigantGripEx)) mod += .15;
    if (player.hasPerk(PerkLib.PowerAttackEx)) mod += .15;
    if (player.hasPerk(PerkLib.GreaterBrute)) mod += .15;
    if (player.hasPerk(PerkLib.GreaterBrawn)) mod += .15;
    if (player.hasPerk(PerkLib.GigantGripSu)) mod += .2;
    if (player.hasPerk(PerkLib.EpicBrute)) mod += .2;
    if (player.hasPerk(PerkLib.EpicBrawn)) mod += .2;
    if (player.hasPerk(PerkLib.TitanGrip)) mod += .25;
    if (player.hasPerk(PerkLib.LegendaryBrute)) mod += .25;
    if (player.hasPerk(PerkLib.LegendaryBrawn)) mod += .25;
    if (player.hasPerk(PerkLib.MythicalBrute)) mod += .3;
    if (player.hasPerk(PerkLib.MythicalBrawn)) mod += .3;//515% up to here
    if (player.hasPerk(PerkLib.PrestigeJobBerserker)) {
        mod += .8;
        if (player.hasPerk(PerkLib.FuelForTheFire)) {
            var berzerkermulti:Number = 0.1;
            if (player.hasPerk(PerkLib.Rage)) berzerkermulti += .1;
            if (player.hasPerk(PerkLib.Anger)) berzerkermulti += .1;
            if (player.hasPerk(PerkLib.TooAngryToDie)) berzerkermulti += .1;
            if (player.hasPerk(PerkLib.EndlessRage)) berzerkermulti += .1;
            if (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking)) berzerkermulti *= 2;
            if (player.weapon.isLarge() || player.weapon.isMassive()) berzerkermulti *= 2;
            mod += berzerkermulti;
        }
    }
    if (player.hasPerk(PerkLib.PrestigeJobSpellKnight)) mod += .4;
    if (player.hasPerk(PerkLib.PrestigeJobTempest)) mod += .4;
    if (player.hasPerk(PerkLib.PrestigeJobSoulArtMaster)) mod += .4;
    if (player.hasPerk(PerkLib.WarCaster)) mod += .2;
    if (player.hasPerk(PerkLib.VampiricBlade)) mod += .2;
    if (player.hasPerk(PerkLib.TwinRiposte)) mod += .2;
    if (player.hasPerk(PerkLib.PerfectStrike)) mod += .2;//845~895~985% up to here
	if (player.hasPerk(PerkLib.MeleeWeaponsAttackMultiplier)) mod += .05;
	if (player.hasPerk(PerkLib.MeleeWeaponsAttackMultiplier)) {
		if (player.hasPerk(PerkLib.SkilledFighterEx)) {
			mod += .15;
			mod *= 2;
		}
		else mod *= 1.5;
	}
    if (player.hasPerk(PerkLib.AscensionKillingIntent)) mod *= 1 + (player.perkv1(PerkLib.AscensionKillingIntent) * 0.1);
    mod = Math.round(mod * 100) / 100;
    return mod;
}

public function rangePhysicalForce():Number {
    var mod:Number = 1;
    if (player.hasPerk(PerkLib.JobRanger)) mod += .1;
    if (player.hasPerk(PerkLib.JobHunter)) mod += .2;
    if (player.hasPerk(PerkLib.JobGunslinger)) mod += .1;
    if (player.hasPerk(PerkLib.CarefulButRecklessAimAndShooting)) mod += .05;
    if (player.hasPerk(PerkLib.Sharpshooter)) mod += .05;
    if (player.hasPerk(PerkLib.DeadlyAim)) mod += .05;
    if (player.hasPerk(PerkLib.Penetrator)) mod += .05;
    if (player.hasPerk(PerkLib.PowerShot)) mod += .05;
    if (player.hasPerk(PerkLib.ColdAim)) mod += .1;
    if (player.hasPerk(PerkLib.DeadlyThrow)) mod += .1;
    if (player.hasPerk(PerkLib.PracticedShot)) mod += .1;
    if (player.hasPerk(PerkLib.AnatomyExpert)) mod += .15;
    if (player.hasPerk(PerkLib.EagleEye)) mod += .15;
    if (player.hasPerk(PerkLib.PowerShotEx)) mod += .15;
	if (player.hasPerk(PerkLib.ImpactThrow)) mod += .15;
	if (player.hasPerk(PerkLib.PenetratingThrow)) mod += .2;//165% up to here
    if (player.hasPerk(PerkLib.PrestigeJobArcaneArcher)) mod += .4;
    if (player.hasPerk(PerkLib.ElementalArrows)) mod += .2;
    if (player.hasPerk(PerkLib.Cupid)) mod += .2;//245% up to here
	if (player.hasPerk(PerkLib.RangeWeaponsAttackMultiplier)) mod += .05;
	if (player.hasPerk(PerkLib.RangeWeaponsAttackMultiplier)) {
		if (player.hasPerk(PerkLib.SkilledRangerEx)) {
			mod += .15;
			mod *= 2;
		}
		else mod *= 1.5;
	}
    if (player.hasPerk(PerkLib.AscensionBloodlust)) mod *= 1 + (player.perkv1(PerkLib.AscensionBloodlust) * 0.1);
    if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) mod *= historyScoutBonus();
    if (monster.hasStatusEffect(StatusEffects.WoundPoison)) mod *= 1+(monster.statusEffectv1(StatusEffects.WoundPoison)/100);
    mod = Math.round(mod * 100) / 100;
    return mod;
}

public function firearmsForce():Number {
	var mod:Number = 0;
    var maxFirearmAttacks:int = maxFirearmsAttacks();
	if (player.hasPerk(PerkLib.JobGunslinger)) mod += .1;
	if (maxFirearmAttacks >= 2) mod += .05;
	if (maxFirearmAttacks >= 3) mod += .1;
	if (maxFirearmAttacks >= 4) mod += .15;
    if (player.hasPerk(PerkLib.AlchemicalCartridge)) mod += .05;
    if (player.hasPerk(PerkLib.ChurchOfTheGun)) mod += .1;
    if (player.hasPerk(PerkLib.ExplosiveCartridge)) mod += .1;
    if (player.hasPerk(PerkLib.TaintedMagazine)) mod += .1;
    if (player.hasPerk(PerkLib.SaintOfZariman)) mod += .15;
    if (player.hasPerk(PerkLib.SilverForMonsters)) mod += .15;
    if (player.hasPerk(PerkLib.NamedBullet)) mod += .2;//125% up to here
	if (player.hasPerk(PerkLib.FirearmsAttackMultiplier)) {
		mod += .1;
		if (player.hasPerk(PerkLib.SkilledGunslingerEx)) {
			mod += .2;
			mod *= 2;
		}
		else mod *= 1.5;
	}
    if (player.hasPerk(PerkLib.CowGunslingerOutfit)) mod += .5;//125% up to here
    if (player.headJewelry == headjewelries.COWHAT) mod += .25;
	mod += rangePhysicalForce();
	mod = Math.round(mod * 100) / 100;
    return mod;
}

public function flyingSwordAttackCost():Number {
    var fsac:Number = 25;
    if (player.hasPerk(PerkLib.SoaringBlades)) {
        fsac -= 5;
        if (player.perkv1(PerkLib.Dantain) > 0) fsac -= 5;
        if (player.perkv1(PerkLib.Dantain) > 1) fsac -= 5;
        if (player.perkv1(PerkLib.Dantain) > 2) fsac -= 5;
    }
    if (player.weaponFlyingSwordsPerk == "") fsac *= 2;
    if (player.weaponFlyingSwordsPerk == "Large") fsac *= 3;
    if (player.weaponFlyingSwordsPerk == "Massive") fsac *= 6;
    if (player.weaponFlyingSwordsCount > 1) fsac *= player.weaponFlyingSwordsCount;
	if (player.weaponFlyingSwords == weaponsflyingswords.ASAUCHI) fsac *= 0.6;
	if (player.weaponFlyingSwords == weaponsflyingswords.C_NEW_M) fsac *= 1.1;
    return fsac;
}

public function flyingSwordUseCost():Number {
    var fsuc:Number = 100;
    if (player.hasPerk(PerkLib.SoaringBlades)) {
        fsuc -= 20;
        if (player.perkv1(PerkLib.Dantain) > 0) fsuc -= 20;
        if (player.perkv1(PerkLib.Dantain) > 1) fsuc -= 20;
        if (player.perkv1(PerkLib.Dantain) > 2) fsuc -= 20;
    }
    if (player.weaponFlyingSwordsPerk == "Massive") fsuc *= 1.5;
    if (player.weaponFlyingSwords == weaponsflyingswords.ASAUCHI) fsuc *= 0.8;
    return fsuc;
}

public function flyingWithSoulforceCost():Number {
    var fwsc:Number = 500;
    if (player.perkv1(PerkLib.Dantain) > 2) fwsc -= 100;
    return fwsc;
}

public function rangeMasteryEXPgained(crit:Boolean = false):Number {
    var rangeMasteryEXPgains:Number = 1;
    if (player.hasPerk(PerkLib.RangeWeaponsMastery)) rangeMasteryEXPgains += 2;
    if (player.weaponRange == weaponsrange.BEA_BOW) rangeMasteryEXPgains *= 2;
    if (monster is TrainingDummy && flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 1) {
        rangeMasteryEXPgains *= 2;
        var bMXPMulti:Number = 1;
        if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 2) bMXPMulti += 1.5;
        if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 3) bMXPMulti += 2;
        if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 4) bMXPMulti += 2.5;
        if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 5) bMXPMulti += 3;
        if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 6) bMXPMulti += 5;
		rangeMasteryEXPgains *= bMXPMulti;
    }
    if (crit) {
        rangeMasteryEXPgains *= 2;
        if (player.hasPerk(PerkLib.RangeWeaponsMasteryEx)) rangeMasteryEXPgains *= 2;
    }
	if (player.hasMutation(IMutationsLib.HumanVersatilityIM) && player.perkv1(IMutationsLib.HumanVersatilityIM) >= 3 && rand(5) == 0) rangeMasteryEXPgains *= 3;
    return rangeMasteryEXPgains;
}

public function bonusCriticalDamageFromMissingHP():Number {
    var bonusCriticalDamageFromMissingHP:Number = 0;
    if (player.hasStatusEffect(StatusEffects.Rage)) bonusCriticalDamageFromMissingHP += 0.025 * player.statusEffectv1(StatusEffects.Rage);
    if (player.hasPerk(PerkLib.Anger) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking)) && player.hp100 < 100) {
        if (player.hp100 < 0) bonusCriticalDamageFromMissingHP += 2;
        else bonusCriticalDamageFromMissingHP += (1 - (player.hp100 * 0.02));
    }
    return bonusCriticalDamageFromMissingHP;
}

public function RacialParagonAbilityBoost():Number {
    var rpab:Number = 1.5;
    if (player.hasPerk(PerkLib.Apex)) rpab += 0.75;
    if (player.hasPerk(PerkLib.AlphaAndOmega)) rpab += 0.75;
    if (player.hasPerk(PerkLib.AscensionOneRaceToRuleThemAllX)) rpab += (0.25 * player.perkv1(PerkLib.AscensionOneRaceToRuleThemAllX));
    return rpab;
}

public function BleedDamageBoost(isARacialAbility:Boolean = false):Number {
    var BleedMod:Number = 1.0;
    if (player.hasPerk(PerkLib.ThirstForBlood)) BleedMod += 0.25;
    if (player.hasPerk(PerkLib.KingOfTheJungle)) BleedMod += 0.2
    if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 1) BleedMod += (0.25 * player.perkv1(IMutationsLib.SharkOlfactorySystemIM));
    if (isARacialAbility) BleedMod *= combat.RacialParagonAbilityBoost();
    return BleedMod;
}

public function triggeredTurquoiseBandProtectionTexts():void {
    outputText(" [Themonster] tries to attack you, but their strike is repelled by your magical bubble. They reel back at the unexpected pushback. The skein of magic around you lets out a soft hiss, and the scent of cinnamon fills the air as the magic dissipates.");
    player.removeStatusEffect(StatusEffects.TurquoiseBandProtection);
    monster.createStatusEffect(StatusEffects.Stunned,0,0,0,0);
}

public function debuffsOrDoTDuration(duration:Number):Number {
    //var duration:Number = duration;
    if (player.statStore.hasBuff("Crossed Holy Band")) {
        duration *= 0.5;
        Math.round(duration);
    }
    return duration;
}

public function ghostStrength():Number {
    var ghostStr:Number = player.strStat.core.value;
    var ghostStrMulti:Number = 0;
    var ghostStrMulti2:Number = 1;
    if (player.hasPerk(PerkLib.Brute)) ghostStrMulti += 0.2;
    if (player.hasPerk(PerkLib.ImprovedBrute)) ghostStrMulti += 0.4;
    if (player.hasPerk(PerkLib.GreaterBrute)) ghostStrMulti += 0.6;
    if (player.hasPerk(PerkLib.EpicBrute)) ghostStrMulti += 0.8;
    if (player.hasPerk(PerkLib.LegendaryBrute)) ghostStrMulti += 1;
    if (player.hasPerk(PerkLib.MythicalBrute)) ghostStrMulti += 1.2;
    if (player.hasPerk(PerkLib.Brawn)) ghostStrMulti2 += .1;
    if (player.hasPerk(PerkLib.ImprovedBrawn)) ghostStrMulti2 += .15;
    if (player.hasPerk(PerkLib.GreaterBrawn)) ghostStrMulti2 += .2;
    if (player.hasPerk(PerkLib.EpicBrawn)) ghostStrMulti2 += .25;
    if (player.hasPerk(PerkLib.LegendaryBrawn)) ghostStrMulti2 += .3;
    if (player.hasPerk(PerkLib.MythicalBrawn)) ghostStrMulti2 += .35;
    if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 2) ghostStrMulti += 0.05;
    if (player.perkv1(IMutationsLib.DraconicHeartIM) >= 3) ghostStrMulti += 0.1;
    if (player.perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 1) ghostStrMulti += 0.05;
    if (player.perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 2) ghostStrMulti += 0.1;
    if (player.perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 3) ghostStrMulti += 0.15;
    if (player.perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 3) ghostStrMulti += 0.2;
    if (player.perkv1(IMutationsLib.HumanMusculatureIM) >= 2 && player.racialScore(Races.HUMAN) > 17) ghostStrMulti += 0.15;
    if (player.perkv1(IMutationsLib.HumanMusculatureIM) >= 3 && player.racialScore(Races.HUMAN) > 17) ghostStrMulti += 0.3;
    ghostStr *= ghostStrMulti;
    ghostStr *= ghostStrMulti2;
    ghostStr = Math.round(ghostStr);
    return ghostStr;
}
private function ghostRealStrength():Number {
    var ghostRealStr:Number = player.str;
    ghostRealStr += ghostStrength();
    return ghostRealStr;
}
private function ghostRealStrengthCompanion():Number {
    var ghostRealStrCompanion:Number = 0;
    if (!player.companionsInPCParty()) return ghostRealStrCompanion;
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Alvina") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerAlvina);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Alvina") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerAlvina);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Alvina") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerAlvina);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Amily") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerAmily);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Amily") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerAmily);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Amily") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerAmily);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Aurora") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerAurora);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Aurora") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerAurora);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Aurora") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerAurora);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Etna") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerEtna);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Etna") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerEtna);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Etna") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerEtna);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Excellia") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerExcellia);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Excellia") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerExcellia);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Excellia") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerExcellia);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerGVampServ);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerGVampServ);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerGVampServ);
    if (flags[kFLAGS.PLAYER_COMPANION_0] == "Kiha") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerKiha);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Kiha") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerKiha);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Kiha") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerKiha);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Kiha") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerKiha);
    if (flags[kFLAGS.PLAYER_COMPANION_0] == "Midoka") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerMidoka);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Midoka") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerMidoka);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Midoka") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerMidoka);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Midoka") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerMidoka);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Mitzi") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerMitzi);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Mitzi") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerMitzi);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Mitzi") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerMitzi);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Neisa") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerNeisa);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Neisa") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerNeisa);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Neisa") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerNeisa);
    if (flags[kFLAGS.PLAYER_COMPANION_0] == "Tyrantia") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerTyrantia);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Tyrantia") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerTyrantia);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Tyrantia") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerTyrantia);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Tyrantia") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerTyrantia);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Zenji") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerZenji);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Zenji") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerZenji);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Zenji") ghostRealStrCompanion += player.statusEffectv1(StatusEffects.CombatFollowerZenji);
    return ghostRealStrCompanion;
}

public function ghostSpeed():Number {
    var ghostSpe:Number = player.speStat.core.value;
    var ghostSpeMulti:Number = 0;
    if (player.perkv1(IMutationsLib.DraconicLungIM) >= 2) ghostSpeMulti += 0.05;
    if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3) ghostSpeMulti += 0.1;
    if (player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 1) ghostSpeMulti += 0.05;
    if (player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 2) ghostSpeMulti += 0.1;
    if (player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 3) ghostSpeMulti += 0.15;
    if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 3) ghostSpeMulti += 0.3;
    if (player.perkv1(IMutationsLib.CatLikeNimblenessIM) >= 4) ghostSpeMulti += 0.1;
    if (player.perkv1(IMutationsLib.HumanMusculatureIM) >= 3 && player.racialScore(Races.HUMAN) > 17) ghostSpeMulti += 0.15;
    ghostSpe *= ghostSpeMulti;
    ghostSpe = Math.round(ghostSpe);
    return ghostSpe;
}
private function ghostRealSpeed():Number {
    var ghostRealSpe:Number = player.spe;
    ghostRealSpe += ghostSpeed();
    return ghostRealSpe;
}

public function ghostToughness():Number {
    var ghostTou:Number = player.touStat.core.value;
    var ghostTouMulti:Number = 0;
    if (player.perkv1(IMutationsLib.DraconicBonesIM) >= 2) ghostTouMulti += 0.05;
    if (player.perkv1(IMutationsLib.DraconicBonesIM) >= 3) ghostTouMulti += 0.1;
    if (player.perkv1(IMutationsLib.HumanFatIM) >= 2 && player.racialScore(Races.HUMAN) > 17) ghostTouMulti += 0.15;
    if (player.perkv1(IMutationsLib.HumanFatIM) >= 3 && player.racialScore(Races.HUMAN) > 17) ghostTouMulti += 0.3;
    ghostTou *= ghostTouMulti;
    ghostTou = Math.round(ghostTou);
    return ghostTou;
}
private function ghostRealToughness():Number {
    var ghostRealTou:Number = player.tou;
    ghostRealTou += ghostToughness();
    return ghostRealTou;
}
private function ghostRealToughnessCompanion():Number {
    var ghostRealTouCompanion:Number = 0;
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Aurora") ghostRealTouCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAurora);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Aurora") ghostRealTouCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAurora);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Aurora") ghostRealTouCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAurora);
    return ghostRealTouCompanion;
}

private function ghostRealIntelligenceCompanion():Number {
    var ghostRealInteCompanion:Number = 0;
    if (!player.companionsInPCParty()) return ghostRealInteCompanion;
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Alvina") ghostRealInteCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAlvina);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Alvina") ghostRealInteCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAlvina);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Alvina") ghostRealInteCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAlvina);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Ayane") ghostRealInteCompanion += player.statusEffectv1(StatusEffects.CombatFollowerAyane);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Ayane") ghostRealInteCompanion += player.statusEffectv1(StatusEffects.CombatFollowerAyane);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Ayane") ghostRealInteCompanion += player.statusEffectv1(StatusEffects.CombatFollowerAyane);
    if (flags[kFLAGS.PLAYER_COMPANION_0] == "Tyrantia") ghostRealInteCompanion += player.statusEffectv3(StatusEffects.CombatFollowerTyrantia);
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Tyrantia") ghostRealInteCompanion += player.statusEffectv3(StatusEffects.CombatFollowerTyrantia);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Tyrantia") ghostRealInteCompanion += player.statusEffectv3(StatusEffects.CombatFollowerTyrantia);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Tyrantia") ghostRealInteCompanion += player.statusEffectv3(StatusEffects.CombatFollowerTyrantia);
    return ghostRealInteCompanion;
}

private function ghostRealWisdomCompanion():Number {
    var ghostRealWisCompanion:Number = 0;
    if (!player.companionsInPCParty()) return ghostRealWisCompanion;
    if (flags[kFLAGS.PLAYER_COMPANION_1] == "Ayane") ghostRealWisCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAyane);
    if (flags[kFLAGS.PLAYER_COMPANION_2] == "Ayane") ghostRealWisCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAyane);
    if (flags[kFLAGS.PLAYER_COMPANION_3] == "Ayane") ghostRealWisCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAyane);
    return ghostRealWisCompanion;
}

private function touSpeStrScale(stat:int):Number {
    var scale:Number = 0;
    for (var i:int = 20; (i <= 80) && (i <= stat); i += 20) {
        scale += stat - i;
    }
    for (i = 100; (i <= 10000) && (i <= stat); i += 50) {
        scale += stat - i;
    }
    return scale;
}

/**
 * Generate "effect value" by scaling a stat.
 * * stat x (2/6 + 1/6 per 20 points) for stat <= 100
 * * stat x (1 + 1/4 per 50 points over 50) for stat <= 100,000
 * * stat x 50.75 for stat > 100,000
 * + a random bonus of similar magnitude
 * @param stat
 * @param randomize Apply random bonus. If false, apply average random bonus.
 * @return
 */
    private function inteWisLibScale(stat:int, randomize:Boolean = true):Number {
        var scale:Number = 50.75;
        var changeBy:Number = 0.50;
        if (stat <= 100000) {
            if (stat <= 100) {
                scale = (2 / 6) + (int(stat / 20) * (1 / 6));
                changeBy = 0.25;
            } else {
                scale = 1 + (int((stat - 100) / 50) * 0.25);
            }
        }
        var rng:Number = stat * (scale + changeBy);
        if (!randomize) return (stat * scale) + 0.5*rng;
        else return (stat * scale) + rand(rng);
    }

    public function scalingBonusStrength(randomize:Boolean = true):Number {
        if (flags[kFLAGS.STRENGTH_SCALING] == 1) return touSpeStrScale(ghostRealStrength());
        else return inteWisLibScale(ghostRealStrength(), randomize);
    }

    public function scalingBonusStrengthCompanion(randomize:Boolean = true):Number {
        if (flags[kFLAGS.STRENGTH_SCALING] == 1) return touSpeStrScale(ghostRealStrengthCompanion());
        else return inteWisLibScale(ghostRealStrengthCompanion(), randomize);
    }

    public function scalingBonusToughness(randomize:Boolean = true):Number {
        return inteWisLibScale(ghostRealToughness(), randomize);
    }

    public function scalingBonusToughnessCompanion(randomize:Boolean = true):Number {
        if (flags[kFLAGS.TOUGHNESS_SCALING] == 1) return touSpeStrScale(ghostRealToughnessCompanion());
        else return inteWisLibScale(ghostRealToughnessCompanion(), randomize);
    }

    public function scalingBonusSpeed(randomize:Boolean = true):Number {
        if (flags[kFLAGS.SPEED_SCALING] == 1) return touSpeStrScale(ghostRealSpeed());
        else return inteWisLibScale(ghostRealSpeed(), randomize);
    }

    public function scalingBonusWisdom(randomize:Boolean = true):Number {
        if (flags[kFLAGS.WISDOM_SCALING] == 1) return touSpeStrScale(player.wis);
        else return inteWisLibScale(player.wis, randomize);
    }

    public function scalingBonusWisdomCompanion(randomize:Boolean = true):Number {
        if (flags[kFLAGS.WISDOM_SCALING] == 1) return touSpeStrScale(ghostRealWisdomCompanion());
        else return inteWisLibScale(ghostRealWisdomCompanion(), randomize);
    }

    public function scalingBonusIntelligence(randomize:Boolean = true):Number {
        if (flags[kFLAGS.INTELLIGENCE_SCALING] == 1) return touSpeStrScale(player.inte);
        else return inteWisLibScale(player.inte, randomize);
    }

    public function scalingBonusIntelligenceCompanion(randomize:Boolean = true):Number {
        if (flags[kFLAGS.INTELLIGENCE_SCALING] == 1) return touSpeStrScale(ghostRealIntelligenceCompanion());
        else return inteWisLibScale(ghostRealIntelligenceCompanion(), randomize);
    }

    public function scalingBonusLibido(randomize:Boolean = true):Number {
        return inteWisLibScale(player.lib, randomize);
    }

    public function fixPercentDamage(damage:Number, ignoreDiff:Boolean = true):Number {
        var plaLvl:Number = player.level + playerLevelAdjustment();
        var monLvl:Number = monster.level + monsterLevelAdjustment();

        /**
         * If player is equal or lower level than monster, DoT is bound to 20%
         * If player is higher level than monster, damage bound is increased up to 50%
         * at 10 levels below, then unbounded past that
         */
        if (plaLvl <= monLvl) {
            if (damage > (monster.maxHP() * 0.2)) damage = monster.maxHP() * 0.2; //Bound damage to 20% of health
        } else {
            var lvlDifference:int = plaLvl - monLvl;
            if (lvlDifference < 10) {
                var boundedDamage:Number = monster.maxHP() * (0.2 + (0.3 * (lvlDifference / 10)));
                if (damage > boundedDamage) damage = boundedDamage;
            }
        }

        if (ignoreDiff) damage *= monster.damageReductionBasedOnDifficulty(); //DoT effects are not punished on higher difficulties
        return damage;
    }

    public function fixPercentLust(damage:Number, ignoreDiff:Boolean = true):Number {
        var plaLvl:Number = player.level + playerLevelAdjustment();
        var monLvl:Number = monster.level + monsterLevelAdjustment();

        /**
         * If player is equal or lower level than monster, DoT is bound to 20%
         * If player is higher level than monster, damage bound is increased up to 50%
         * at 10 levels below, then unbounded past that
         */
        if (plaLvl <= monLvl) {
            if (damage > (monster.maxLust() * 0.2)) damage = monster.maxLust() * 0.2; //Bound damage to 20% of health
        } else {
            var lvlDifference:int = plaLvl - monLvl;
            if (lvlDifference < 10) {
                var boundedDamage:Number = monster.maxLust() * (0.2 + (0.3 * (lvlDifference / 10)));
                if (damage > boundedDamage) damage = boundedDamage;
            }
        }
        
        if (ignoreDiff) damage *= monster.damageReductionBasedOnDifficulty(); //DoT effects are not punished on higher difficulties
        return damage;
    }
    
    public function isNearPlants():Boolean {
        return player.hasStatusEffect(StatusEffects.NearbyPlants) || explorer.areaTags.plants;
    }
    public function isNearWater():Boolean {
        return player.hasStatusEffect(StatusEffects.UnderwaterCombatBoost) || player.hasStatusEffect(StatusEffects.NearWater) || explorer.areaTags.water;
    }
}
}
