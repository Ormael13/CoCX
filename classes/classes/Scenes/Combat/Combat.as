package classes.Scenes.Combat {
import classes.BaseContent;
import classes.BodyParts.*;
import classes.CoC;
import classes.CoC_Settings;
import classes.CockTypesEnum;
import classes.EngineCore;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.ItemType;
import classes.Items.JewelryLib;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Monster;
import classes.MutationsLib;
import classes.PerkLib;
import classes.PotionType;
import classes.Scenes.Areas.Beach.Gorgon;
import classes.Scenes.Areas.Bog.CorruptedMaleTroll;
import classes.Scenes.Areas.Caves.DisplacerBeast;
import classes.Scenes.Areas.Desert.*;
import classes.Scenes.Areas.Forest.*;
import classes.Scenes.Areas.GlacialRift.*;
import classes.Scenes.Areas.HighMountains.*;
import classes.Scenes.Areas.Mountain.Minotaur;
import classes.Scenes.Areas.Ocean.SeaAnemone;
import classes.Scenes.Areas.Tundra.YoungFrostGiant;
import classes.Scenes.Dungeons.DeepCave.EncapsulationPod;
import classes.Scenes.Dungeons.D3.*;
import classes.Scenes.Dungeons.EbonLabyrinth.*;
import classes.Scenes.Dungeons.HelDungeon.*;
import classes.Scenes.NPCs.*;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.Codex;
import classes.Scenes.SceneLib;
import classes.Stats.Buff;
import classes.StatusEffectClass;
import classes.StatusEffectType;
import classes.StatusEffects;
import classes.StatusEffects.VampireThirstEffect;

import coc.view.ButtonData;
import coc.view.ButtonDataList;
import coc.view.MainView;

public class Combat extends BaseContent {
    public var pspecials:PhysicalSpecials = new PhysicalSpecials();
    public var mspecials:MagicSpecials = new MagicSpecials();
    public var magic:CombatMagic = new CombatMagic();
    public var teases:CombatTeases = new CombatTeases();
    public var soulskills:CombatSoulskills = new CombatSoulskills();
    public var comfoll:CombatFollowersActions = new CombatFollowersActions();
    public var ui:CombatUI = new CombatUI();
	public var codex:Codex = new Codex();
	public var meleeDamageNoLag:Number = 0;
    public var MDODialogs:Boolean = false; // JA dialogs, look 3875
    public var MDOCount:int = 0; // count of how many times damage was deal
    public var MSGControll:Boolean = false; // need to correctly display damage MSG
    public var MSGControllForEvasion:Boolean = false; // need to correctly display damage MSG. This way as i use it game will show just first damage msg.
    public var isBowDamageMDO:Boolean = false; // use it as a switch between melee and bow damage for correct calculations and display

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
        } else if (monster.lust >= monster.maxLust()) {
            doNext(endLustVictory);
        } else if(player.lust >= player.maxLust()) {
            doNext(endLustLoss);
        } else {
            enemyAI();
        }
    }

    public function physicalCost(mod:Number):Number {
        var costPercent:Number = 100;
        if (player.hasPerk(PerkLib.IronMan)) costPercent -= 50;
        if (player.hasPerk(PerkLib.ZenjisInfluence3)) costPercent -= 20;
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

    public function masteryFeralCombatLevel():Number {
        return player.masteryFeralCombatLevel;
    }
    public function maxFeralCombatLevel():Number {
        return player.maxFeralCombatLevel();
    }
    public function FeralCombatExpToLevelUp():Number {
        return player.FeralCombatExpToLevelUp();
    }

    public function masteryGauntletLevel():Number {
        return player.masteryGauntletLevel;
    }
    public function maxGauntletLevel():Number {
        return player.maxGauntletLevel();
    }
    public function GauntletExpToLevelUp():Number {
        return player.GauntletExpToLevelUp();
    }

	public function masteryDaggerLevel():Number {
        return player.masteryDaggerLevel;
    }
    public function maxDaggerLevel():Number {
        return player.maxDaggerLevel();
    }
    public function DaggerExpToLevelUp():Number {
        return player.DaggerExpToLevelUp();
    }

    public function masterySwordLevel():Number {
        return player.masterySwordLevel;
    }
    public function maxSwordLevel():Number {
        return player.maxSwordLevel();
    }
    public function SwordExpToLevelUp():Number {
        return player.SwordExpToLevelUp();
    }

	public function masteryAxeLevel():Number {
        return player.masteryAxeLevel;
    }
    public function maxAxeLevel():Number {
        return player.maxAxeLevel();
    }
    public function AxeExpToLevelUp():Number {
        return player.AxeExpToLevelUp();
    }

    public function masteryMaceHammerLevel():Number {
        return player.masteryMaceHammerLevel;
    }
    public function maxMaceHammerLevel():Number {
        return player.maxMaceHammerLevel();
    }
    public function MaceHammerExpToLevelUp():Number {
        return player.MaceHammerExpToLevelUp();
    }

	public function masteryDuelingSwordLevel():Number {
        return player.masteryDuelingSwordLevel;
    }
    public function maxDuelingSwordLevel():Number {
        return player.maxDuelingSwordLevel();
    }
    public function DuelingSwordExpToLevelUp():Number {
        return player.DuelingSwordExpToLevelUp();
    }

	public function masteryPolearmLevel():Number {
        return player.masteryPolearmLevel;
    }
    public function maxPolearmLevel():Number {
        return player.maxPolearmLevel();
    }
    public function PolearmExpToLevelUp():Number {
        return player.PolearmExpToLevelUp();
    }

	public function masterySpearLevel():Number {
        return player.masterySpearLevel;
    }
    public function maxSpearLevel():Number {
        return player.maxSpearLevel();
    }
    public function SpearExpToLevelUp():Number {
        return player.SpearExpToLevelUp();
    }

	public function masteryWhipLevel():Number {
        return player.masteryWhipLevel;
    }
    public function maxWhipLevel():Number {
        return player.maxWhipLevel();
    }
    public function WhipExpToLevelUp():Number {
        return player.WhipExpToLevelUp();
    }

	public function masteryExoticLevel():Number {
        return player.masteryExoticLevel;
    }
    public function maxExoticLevel():Number {
        return player.maxExoticLevel();
    }
    public function ExoticExpToLevelUp():Number {
        return player.ExoticExpToLevelUp();
    }

	public function masteryArcheryLevel():Number {
        return player.masteryArcheryLevel;
    }
    public function maxArcheryLevel():Number {
        return player.maxArcheryLevel();
    }
    public function ArcheryExpToLevelUp():Number {
        return player.ArcheryExpToLevelUp();
    }

	public function masteryThrowingLevel():Number {
        return player.masteryThrowingLevel;
    }
    public function maxThrowingLevel():Number {
        return player.maxThrowingLevel();
    }
    public function ThrowingExpToLevelUp():Number {
        return player.ThrowingExpToLevelUp();
    }

	public function masteryFirearmsLevel():Number {
        return player.masteryFirearmsLevel;
    }
    public function maxFirearmsLevel():Number {
        return player.maxFirearmsLevel();
    }
    public function FirearmsExpToLevelUp():Number {
        return player.FirearmsExpToLevelUp();
    }

	public function dualWSLevel():Number {
        return player.dualWSLevel;
    }
    public function maxDualWieldSmallLevel():Number {
        return player.maxDualWieldSmallLevel();
    }
    public function DualWieldSmallExpToLevelUp():Number {
        return player.DualWieldSmallExpToLevelUp();
    }

    public function dualWNLevel():Number {
        return player.dualWNLevel;
    }
    public function maxDualWieldNormalLevel():Number {
        return player.maxDualWieldNormalLevel();
    }
    public function DualWieldNormalExpToLevelUp():Number {
        return player.DualWieldNormalExpToLevelUp();
    }

    public function dualWLLevel():Number {
        return player.dualWLLevel;
    }
    public function maxDualWieldLargeLevel():Number {
        return player.maxDualWieldLargeLevel();
    }
    public function DualWieldLargeExpToLevelUp():Number {
        return player.DualWieldLargeExpToLevelUp();
    }

    public function dualWFLevel():Number {
        return player.dualWFLevel;
    }
    public function maxDualWieldFirearmsLevel():Number {
        return player.maxDualWieldFirearmsLevel();
    }
    public function DualWieldFirearmsExpToLevelUp():Number {
        return player.DualWieldFirearmsExpToLevelUp();
    }

    public function maxTeaseLevel():Number {
        return player.maxTeaseLevel();
    }
    public function teaseExpToLevelUp():Number {
        return player.teaseExpToLevelUp();
    }

    public function bonusExpAfterSuccesfullTease():Number {
        return teases.bonusExpAfterSuccesfullTease();
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

    public function healCost(mod:Number):Number {
        return magic.healCostImpl(mod);
    }

    public function healCostWhite(mod:Number):Number {
        return magic.healCostWhiteImpl(mod);
    }

    public function healCostBlack(mod:Number):Number {
        return magic.healCostBlackImpl(mod);
    }

    public function spellMod():Number {
        return magic.spellModImpl();
    }

    //public function spellGreyCooldown():Number {
        //return magic.spellGreyCooldownImpl();
    //}

    public function spellModWhite():Number {
        return magic.spellModWhiteImpl();
    }

    public function spellWhiteCooldown():Number {
        return magic.spellWhiteCooldownImpl();
    }

    public function spellWhiteTier2Cooldown():Number {
        return magic.spellWhiteTier2CooldownImpl();
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

    public function spellModGrey():Number {
        return magic.spellModGreyImpl();
    }

    public function spellGreyCooldown():Number {
        return magic.spellGreyCooldownImpl();
    }

    public function spellGreyTier2Cooldown():Number {
        return magic.spellGreyTier2CooldownImpl();
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

    public function maxFistAttacks():int {
        if (player.hasPerk(PerkLib.FlurryOfBlows)) return 5;
        else if (player.hasPerk(PerkLib.ComboMaster)) return 3;
        else if (player.hasPerk(PerkLib.Combo)) return 2;
        else return 1;
    }

    public function maxClawsAttacks():int {
        if (player.hasPerk(PerkLib.ClawingFlurry)) return 5;
        else if (player.hasPerk(PerkLib.MultiClawAttack)) return 4;
        else if (player.hasPerk(PerkLib.ExtraClawAttack)) return 3;
        else if (player.hasPerk(PerkLib.ClawTraining)) return 2;
        else return 1;
    }

    public function maxSmallAttacks():int {
        var extraHits:Number = 0;
        if (player.hasPerk(PerkLib.DecaAttackSmall)) return 10+extraHits;
        else if (player.hasPerk(PerkLib.NonaAttackSmall)) return 9+extraHits;
        else if (player.hasPerk(PerkLib.OctaAttackSmall)) return 8+extraHits;
        else if (player.hasPerk(PerkLib.HectaAttackSmall)) return 7+extraHits;
        else if (player.hasPerk(PerkLib.HexaAttackSmall)) return 6+extraHits;
        else if (player.hasPerk(PerkLib.PentaAttackSmall)) return 5+extraHits;
        else if (player.hasPerk(PerkLib.QuadrupleAttackSmall)) return 4+extraHits;
        else if (player.hasPerk(PerkLib.TripleAttackSmall)) return 3+extraHits;
        else if (player.hasPerk(PerkLib.DoubleAttackSmall)) return 2+extraHits;
        else return 1+extraHits;
    }

    public function maxLargeAttacks():int {
        var extraHits:Number = 0;
        if (player.hasPerk(PerkLib.TripleAttackLarge)) return 3+extraHits;
        else if (player.hasPerk(PerkLib.DoubleAttackLarge)) return 2+extraHits;
        else return 1+extraHits;
    }

    public function maxCommonAttacks():int {
        var extraHits:Number = 0;
        if (player.hasPerk(PerkLib.HexaAttack)) return 6+extraHits;
        else if (player.hasPerk(PerkLib.PentaAttack)) return 5+extraHits;
        else if (player.hasPerk(PerkLib.QuadrupleAttack)) return 4+extraHits;
        else if (player.hasPerk(PerkLib.TripleAttack)) return 3+extraHits;
        else if (player.hasPerk(PerkLib.DoubleAttack)) return 2+extraHits;
        else return 1+extraHits;
    }

    public function canSpearDance():Boolean{
        return (player.hasPerk(PerkLib.ELFElvenSpearDancingFlurry1to4) && player.isElf());
    }

    public function maxCurrentAttacks():int {
        if (player.weaponSpecials("Staff") || player.weaponSpecials("Wand") || player.weaponSpecials("Massive")) return 1;
        else if (flags[kFLAGS.FERAL_COMBAT_MODE] != 1 && player.isFistOrFistWeapon()) return maxFistAttacks();
        else if (flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && ((player.weaponName == "fists" && player.haveNaturalClaws()) || player.haveNaturalClawsTypeWeapon())) return maxClawsAttacks();
        else if (canSpearDance() && player.isSpearTypeWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()){
            var Special:Number = 0;
            if (player.hasPerk(PerkLib.ELFElvenSpearDancingFlurry1to4)) Special += player.perkv1(PerkLib.ELFElvenSpearDancingFlurry1to4);
            if (player.weaponSpecials("Large") || player.weaponSpecials("Dual Large")) return maxLargeAttacks()+Special;
            else if (player.weaponSpecials("Small") || player.weaponSpecials("Dual Small")) return maxSmallAttacks()+Special;
            else return maxCommonAttacks()+Special;
        }
        else if (player.weaponSpecials("Large") || player.weaponSpecials("Dual Large")) return maxLargeAttacks();
        else if (player.weaponSpecials("Small") || player.weaponSpecials("Dual Small")) return maxSmallAttacks();
        else return maxCommonAttacks();
    }

    public function maxBowAttacks():int {
        var extraHits:Number = 0;
        if (player.isElf() && player.hasPerk(PerkLib.ELFMasterShot)) extraHits = 1;
        if (player.hasPerk(PerkLib.Multishot)) return 6+extraHits;
        else if (player.hasPerk(PerkLib.WildQuiver)) return 5+extraHits;
        else if (player.hasPerk(PerkLib.Manyshot)) return 4+extraHits;
        else if (player.hasPerk(PerkLib.TripleStrike)) return 3+extraHits;
        else if (player.hasPerk(PerkLib.DoubleStrike)) return 2+extraHits;
        else return 1+extraHits;
    }

    public function maxCrossbowAttacks():int {
        if (player.hasPerk(PerkLib.TripleStrike)) return 3;
        else if (player.hasPerk(PerkLib.DoubleStrike)) return 2;
        else return 1;
    }

    public function maxThrowingAttacks():int {
        if (player.hasPerk(PerkLib.TripleStrike)) return 3;
        else if (player.hasPerk(PerkLib.DoubleStrike)) return 2;
        else return 1;
    }

    public function maxFirearmsAttacks():int {
		var bonusShots:Number = 0;
		if (player.hasPerk(PerkLib.LockAndLoad)) {
			if (player.hasPerk(PerkLib.Multishot)) bonusShots = 2;
			bonusShots = 1;
		}
        if (player.hasPerk(PerkLib.MasterGunslinger)) return 4+bonusShots;
        else if (player.hasPerk(PerkLib.ExpertGunslinger)) return 3+bonusShots;
        else if (player.hasPerk(PerkLib.AmateurGunslinger)) return 2+bonusShots;
        else return 1;
    }

    public function maxCurrentRangeAttacks():int {
        if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle" || player.weaponRangePerk == "2H Firearm" || player.weaponRangePerk == "Dual Firearms") return maxFirearmsAttacks();
        else if (player.weaponRangePerk == "Throwing") return maxThrowingAttacks();
        else if (player.weaponRangePerk == "Crossbow") return maxCrossbowAttacks();
        else if (player.weaponRangePerk == "Bow"){
            var Special:Number = 0;
            if (player.isElf() && player.hasPerk(PerkLib.ELFMasterShot) && player.weaponRangePerk == "Bow") Special += 1;
            return maxBowAttacks()+Special;
        }
        else return 1;
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
			player.HP = player.maxOverHP();
			player.lust = player.minLust();
			doNext(curry(combatMenu, true));
		}
		else if ((player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking)) && player.hasPerk(PerkLib.TooAngryToDie)) {
			if (!player.hasStatusEffect(StatusEffects.TooAngryTooDie)) player.createStatusEffect(StatusEffects.TooAngryTooDie, 0, 0, 0, 0);
			player.HP = player.minHP() + 1;
			doNext(curry(combatMenu, true));
		}
        else monster.won_(true, false);
    }

    public function endLustLoss():void {
		if (player.hasStatusEffect(StatusEffects.TearsOfDenial) && player.statusEffectv1(StatusEffects.TearsOfDenial) == 1) {
			player.addStatusValue(StatusEffects.TearsOfDenial, 1, -1);
			outputText("Just as you would be defeated, the Tears of Denial you prepared restores you to full health and clarity of mind. To [themonster] dismay you get back up, still undefeated and ready to keep fighting.");
			player.HP = player.maxOverHP();
			player.lust = player.minLust();
			doNext(curry(combatMenu, true));
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

    public function spellPerkUnlock():void {
        if (flags[kFLAGS.SPELLS_CAST] >= 10 && !player.hasPerk(PerkLib.SpellcastingAffinity)) {
            outputText("<b>You've become more comfortable with your spells, unlocking the Spellcasting Affinity perk and reducing mana cost of spells by 10%!</b>\n\n");
            player.createPerk(PerkLib.SpellcastingAffinity, 10, 0, 0, 0);
        }
        if (flags[kFLAGS.SPELLS_CAST] >= 30 && player.perkv1(PerkLib.SpellcastingAffinity) < 20) {
            outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
            player.setPerkValue(PerkLib.SpellcastingAffinity, 1, 20);
        }
        if (flags[kFLAGS.SPELLS_CAST] >= 70 && player.perkv1(PerkLib.SpellcastingAffinity) < 30) {
            outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
            player.setPerkValue(PerkLib.SpellcastingAffinity, 1, 30);
        }
        if (flags[kFLAGS.SPELLS_CAST] >= 150 && player.perkv1(PerkLib.SpellcastingAffinity) < 40) {
            outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
            player.setPerkValue(PerkLib.SpellcastingAffinity, 1, 40);
        }
        if (flags[kFLAGS.SPELLS_CAST] >= 310 && player.perkv1(PerkLib.SpellcastingAffinity) < 50) {
            outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
            player.setPerkValue(PerkLib.SpellcastingAffinity, 1, 50);
        }
    }

	internal function applyAutocast0():void {
		outputText("\n\n");
		if (flags[kFLAGS.AUTO_FLIGHT] > 0) {
			if (flags[kFLAGS.AUTO_FLIGHT] == 1 && player.canFly()) {
				if (player.wings.type == Wings.WINDY_AURA && player.arms.type == Arms.KAMAITACHI) outputText("You create a small cyclone to ride upon and lift yourself up in the air.");
				else if (player.wings.type == Wings.THUNDEROUS_AURA) outputText("You take flight, letting the raging storm carry you into the air.");
				else if (player.wings.type == Wings.ETHEREAL) outputText("You take flight, ascending through the storm.");
				else if (player.wings.type == Wings.LEVITATION) outputText("You focus your kinetic abilities, willing yourself into the air.");
				else outputText("You open you wing taking flight.");
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

//combat is over. Clear shit out and go to main
    public function cleanupAfterCombatImpl(nextFunc:Function = null, ThisIsNotATFScene:Boolean = true):void {
        magic.cleanupAfterCombatImpl();
        if (nextFunc == null) nextFunc = camp.returnToCampUseOneHour;
        if (prison.inPrison && prison.prisonCombatWinEvent != null) nextFunc = prison.prisonCombatWinEvent;
        if (inCombat) {
            //clear status
            clearStatuses(false);
            //Clear itemswapping in case it hung somehow
//No longer used:		itemSwapping = false;
            //Player won
            if (monster.HP <= monster.minHP() || monster.lust > monster.maxLust()) {
                awardPlayer(nextFunc);
            }
            //Player lost
            else {
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
                if (monster.short == "Ember") {
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
                    if (monster.short == "manticore") gemsLost = 0;
                    var timePasses:int = monster.handleCombatLossText(inDungeon, gemsLost); //Allows monsters to customize the loss text and the amount of time lost
                    if (player.hasStatusEffect(StatusEffects.SoulArena) || (monster.short == "Hellfire Snail" && (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)))) timePasses = 1;
                    player.gems -= gemsLost;
                    if (monster.perkv3(PerkLib.NoGemsLost) > 0) player.gems += monster.perkv3(PerkLib.NoGemsLost);
                }
                inCombat = false;
                if (player.hasStatusEffect(StatusEffects.SoulArena)) player.removeStatusEffect(StatusEffects.SoulArena);
                if (player.hasStatusEffect(StatusEffects.SoulArenaGaunlet)) player.removeStatusEffect(StatusEffects.SoulArenaGaunlet);
                if (!prison.inPrison && flags[kFLAGS.PRISON_CAPTURE_CHANCE] > 0 && rand(100) < flags[kFLAGS.PRISON_CAPTURE_CHANCE] && (prison.trainingFeed.prisonCaptorFeedingQuestTrainingIsTimeUp() || !prison.trainingFeed.prisonCaptorFeedingQuestTrainingExists()) && (monster.short == "goblin" || monster.short == "goblin assassin" || monster.short == "imp" || monster.short == "imp lord" || monster.short == "imp warlord" || monster.short == "hellhound" || monster.short == "minotaur" || monster.short == "satyr" || monster.short == "gnoll" || monster.short == "gnoll spear-thrower" || monster.short == "basilisk")) {
                    outputText("  You feel yourself being dragged and carried just before you black out.");
                    doNext(prison.prisonIntro);
                    return;
                }
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
                } else doNext(createCallBackFunction(camp.returnToCamp, timePasses));
				//SF harvest
				if (player.hasPerk(PerkLib.PrestigeJobNecromancer) && monster.soulforce > 0) {
					var SFHarvest:Number = monster.level * (1 + rand(3));
					if (SFHarvest > monster.soulforce) SFHarvest = monster.soulforce;
					EngineCore.SoulforceChange(SFHarvest, false);
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
        outputText("You close the distance between you and [monster a] [monster name] as quickly as possible.\n\n");
        player.removeStatusEffect(StatusEffects.KnockedBack);
        if (player.weaponRange == weaponsrange.LBLASTR) {
            var milkAmmo:Number = Math.round(player.lactationQ() / 100);
			if (milkAmmo > 20) milkAmmo = 20;
            player.ammo = milkAmmo;
        }
        if (player.weaponRange == weaponsrange.TWINGRA) player.ammo = 12;
        if (player.weaponRange == weaponsrange.IVIARG_) player.ammo = 12;
        if (player.weaponRange == weaponsrange.BLUNDER) player.ammo = 9;
        if (player.weaponRange == weaponsrange.TDPISTO) player.ammo = 6;
        if (player.weaponRange == weaponsrange.DESEAGL) player.ammo = 4;
        if (player.weaponRange == weaponsrange.DPISTOL) player.ammo = 3;
        if (player.weaponRange == weaponsrange.ADBSHOT) player.ammo = 2;
        if (player.weaponRange == weaponsrange.ADBSCAT) player.ammo = 2;
		if (player.weaponRange == weaponsrange.DBDRAGG) player.ammo = 2;
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
            outputText("At the same time, you moo in pleasure as milk flows from your udders, pumped by the suction cup all the way to the tank on your back.");
            var lustDmg:int = rand(player.lib / 10) + 20;
            player.dynStats("lus", lustDmg);
        }
        else outputText("At the same time, you open the magazine of your " + player.weaponRangeName + " to reload.");
        if (!player.hasPerk(PerkLib.RapidReload)) {
            outputText("  This takes some time, giving your enemy a chance to act.\n\n");
            enemyAI();
        } else {
            outputText("\n\n");
            doNext(curry(combatMenu, false));
        }
    }

    public function approachAfterKnockback2():void {
        clearOutput();
        outputText("You close the distance between you and [monster a] [monster name] as quickly as possible.\n\n");
        player.removeStatusEffect(StatusEffects.KnockedBack);
        outputText("At the same time, you fire a round at [monster name]. ");
        fireBow();
    }

    public function approachAfterKnockback3():void {
        clearOutput();
        outputText("You close the distance between you and [monster a] [monster name] as quickly as possible.\n\n");
        player.removeStatusEffect(StatusEffects.KnockedBack);
        enemyAI();
    }

    public function get isEnnemyInvisible():Boolean {
        var isEnnemyInvisible:Boolean = false;
        if (player.hasStatusEffect(StatusEffects.MonsterInvisible)) isEnnemyInvisible = true;
        return isEnnemyInvisible;
    }

    public function isPlayerSilenced():Boolean {
        var silenced:Boolean = false;
        if (player.hasStatusEffect(StatusEffects.ThroatPunch)) silenced = true;
        if (player.hasStatusEffect(StatusEffects.WebSilence)) silenced = true;
        if (player.hasStatusEffect(StatusEffects.GooArmorSilence)) silenced = true;
        return silenced;
    }

    public function isPlayerBound():Boolean {
        var bound:Boolean = false;
        if (player.hasStatusEffect(StatusEffects.HarpyBind) || player.hasStatusEffect(StatusEffects.GooBind) || player.hasStatusEffect(StatusEffects.TentacleBind) || player.hasStatusEffect(StatusEffects.NagaBind) || player.hasStatusEffect(StatusEffects.ScyllaBind) || monster.hasStatusEffect(StatusEffects.QueenBind)
             || player.hasStatusEffect(StatusEffects.WolfHold) || player.hasStatusEffect(StatusEffects.TrollHold) || player.hasStatusEffect(StatusEffects.PossessionWendigo) || player.hasStatusEffect(StatusEffects.ArcaneWeb) || monster.hasStatusEffect(StatusEffects.PCTailTangle)) bound = true;
        if (player.hasStatusEffect(StatusEffects.HolliConstrict)) bound = true;
        if (player.hasStatusEffect(StatusEffects.GooArmorBind)) bound = true;
        if (monster.hasStatusEffect(StatusEffects.MinotaurEntangled)) {
            outputText("\n<b>You're bound up in the minotaur lord's chains!  All you can do is try to struggle free!</b>");
            bound = true;
        }
        if (player.hasStatusEffect(StatusEffects.UBERWEB)) bound = true;
        if (player.hasStatusEffect(StatusEffects.Bound)) bound = true;
        if (player.hasStatusEffect(StatusEffects.CancerMonsterGrab)) bound = true;
        if (player.hasStatusEffect(StatusEffects.Chokeslam)) bound = true;
        if (player.hasStatusEffect(StatusEffects.Titsmother)) bound = true;
        if (player.hasStatusEffect(StatusEffects.Pounced)) bound = true;
        if (player.hasStatusEffect(StatusEffects.GiantGrabbed)) {
            outputText("\n<b>You're trapped in the giant's hand!  All you can do is try to struggle free!</b>");
            bound = true;
        }
        if (player.hasStatusEffect(StatusEffects.Tentagrappled)) {
            outputText("\n<b>The demoness's tentacles are constricting your limbs!</b>");
            bound = true;
        }
        if (player.hasStatusEffect(StatusEffects.YamataEntwine)) bound = true;
        return bound;
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
        return true;
    }

    public function combatMenu(newRound:Boolean = true):void { //If returning from a sub menu set newRound to false
        clearOutput();
        if (flags[kFLAGS.MELEE_DAMAGE_OVERHAUL] == 1) {
            MDODialogs = true; // JA dialogs, look 3875
        }
		meleeDamageNoLag = 0;
        MDOCount = 0;
        MSGControll = false;
        MSGControllForEvasion = false;
        isBowDamageMDO = false;
        flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] = 0;
        if (newRound) {
            flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_0_ACTION] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_WILL_O_THE_WISP_ATTACKED] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] = 0;
            flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] = 0;
			if (player.hasPerk(PerkLib.MyBloodForBloodPuppies)) flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] = 0;
			if (player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn) && player.statusEffectv1(StatusEffects.SimplifiedNonPCTurn) == 1) player.addStatusValue(StatusEffects.SimplifiedNonPCTurn, 1, -1);
			if (player.armor == armors.BMARMOR) dynStats("lus", -(Math.round(player.maxLust() * 0.02)));
			if (player.hasStatusEffect(StatusEffects.TyrantState)) dynStats("lus", (Math.round(player.maxLust() * 0.05)));
        }
        mainView.hideMenuButton(MainView.MENU_DATA);
        mainView.hideMenuButton(MainView.MENU_APPEARANCE);
        mainView.hideMenuButton(MainView.MENU_PERKS);
        hideUpDown();
        if (newRound) combatStatusesUpdate(); //Update Combat Statuses
        display();
        statScreenRefresh();
        if (newRound) combatRoundOver();
        if (combatIsOver()) return;
        ui.mainMenu();
        //Modify menus.
        if (SceneLib.urtaQuest.isUrta()) {
            addButton(0, "Attack", basemeleeattacks).hint("Attempt to attack the enemy with your [weapon].  Damage done is determined by your strength and weapon.");
            addButton(1, "P. Specials", SceneLib.urtaQuest.urtaSpecials).hint("Physical special attack menu.", "Physical Specials");
            addButton(2, "M. Specials", SceneLib.urtaQuest.urtaMSpecials).hint("Mental and supernatural special attack menu.", "Magical Specials");
            addButton(3, "Tease", teaseAttack);
            addButton(5, "Fantasize", fantasize).hint("Fantasize about your opponent in a sexual way.  Its probably a pretty bad idea to do this unless you want to end up getting raped.");
            addButton(6, "Wait", wait).hint("Take no action for this round.  Why would you do this?  This is a terrible idea.");
        }
        if (player.statusEffectv1(StatusEffects.ChanneledAttack) >= 1 && (isPlayerBound() || isPlayerSilenced() || isPlayerStunned() || isPlayerFeared())) {
            addButton(1, "Stop", stopChanneledSpecial);
        }
        /*
	if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
		if (player.statusEffectv1(StatusEffects.ChanneledAttackType) == 3) {
			addButton(0, "Continue", mspecials.OrgasmicLightningStrike).hint("Continue charging Orgasmic Lightning Strike.");
			addButton(1, "Stop", stopChanneledSpecial).hint("Stop charging Orgasmic Lightning Strike.");
		}
	}
	if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 2) {
		if (player.statusEffectv1(StatusEffects.ChanneledAttackType) == 3) {
			addButton(0, "Continue", mspecials.OrgasmicLightningStrike).hint("Continue charging Orgasmic Lightning Strike.");
			addButton(1, "Stop", stopChanneledSpecial).hint("Stop charging Orgasmic Lightning Strike.");
		}
	}
	*/
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

    internal function buildOtherActions(buttons:ButtonDataList):void {
        var bd:ButtonData;
		buttons.add("Surrender(H)", combat.surrenderByHP, "Stop defending youself. You'll take a hell of a beating. Why would you do this?");
        buttons.add("Surrender(L)", combat.surrenderByLust, "Fantasize about your opponent in a sexual way so much it would fill up your lust. You'll end up getting raped...But is it rape if you get what you want?");
        if (player.hasPerk(PerkLib.DoubleAttack) || player.hasPerk(PerkLib.DoubleAttackLarge) || player.hasPerk(PerkLib.DoubleAttackSmall) || player.hasPerk(PerkLib.Combo) || (player.hasPerk(PerkLib.JobBeastWarrior) && (player.hasNaturalWeapons() || player.haveNaturalClawsTypeWeapon())) ||
            ((player.hasPerk(PerkLib.Berzerker) || (player.hasPerk(PerkLib.Lustzerker)) && player.hasPerk(MutationsLib.SalamanderAdrenalGlandsEvolved))) || player.hasPerk(PerkLib.Poisoning) || player.hasPerk(PerkLib.SwiftCasting) || player.hasStatusEffect(StatusEffects.SoulDrill1) || player.hasStatusEffect(StatusEffects.ThePhalluspear1)) {
            buttons.add("Melee Opt", CoC.instance.perkMenu.doubleAttackOptions, "You can adjust your melee attack settings.");
        }
        if (player.hasPerk(PerkLib.DoubleStrike) || player.hasPerk(PerkLib.ElementalArrows) || player.hasPerk(PerkLib.Cupid) || player.hasPerk(PerkLib.EnvenomedBolt) || player.hasPerk(PerkLib.AmateurGunslinger)) {
            buttons.add("Range Opt", CoC.instance.perkMenu.doubleStrikeOptions, "You can adjust your range strike settings.");
        }
        if (player.hasPerk(PerkLib.JobLeader)) {
            buttons.add("Will-o'-the-wisp", CoC.instance.perkMenu.WOTWbehaviourOptions, "You can adjust how your will-o'-the-wisp will behave during combat.");
        }
        if (player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) {
            buttons.add("Elementals", CoC.instance.perkMenu.summonsbehaviourOptions, "You can adjust how your elemental summons act during combat.");
        }
        if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] > 0) {
            buttons.add("P.Golems", CoC.instance.perkMenu.golemsbehaviourOptions, "You can adjust your permanent golems behaviour during combat.");
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
		if (player.weaponFlyingSwordsName != "nothing") {
			bd = buttons.add("Flying Sword", attackFlyingSword).hint("Attack the enemy with your " + player.weaponFlyingSwordsName + ".  Damage done is determined by your wisdom and weapon.\n\nSoulforce cost per attack: "+flyingSwordAttackCost()+"");
			if (player.soulforce < flyingSwordAttackCost()) {
                bd.disable("Your current soulforce is too low.");
            } else if (player.hasStatusEffect(StatusEffects.Flying) && player.statusEffectv2(StatusEffects.Flying) == 1) {
				bd.disable("You're currently using your sword to fly, you can't attack with it as well.");
			}
		}
        if (!player.isFlying()) {
            if (player.canFly()) buttons.add("Take Flight", takeFlightWings).hint("Make use of your wings or other options avilable to take flight into the air for up to 7 turns. \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.");
			if (player.weaponFlyingSwordsName != "nothing" && player.canFlyOnFlyingSwords()) buttons.add("Take Flight", takeFlightByFlyingSword).hint("Make use of your flying sword to take flight into the air. \n\nSoulforce cost per turn: "+flyingSwordUseCost()+" \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.");
			if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) buttons.add("Take Flight", takeFlightNoWings).hint("Use your own soulforce to take flight into the air. \n\nSoulforce cost per turn: "+flyingWithSoulforceCost()+" \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.");
        }
		if (player.isFlying()) {
			if (player.statusEffectv2(StatusEffects.Flying) == 1) buttons.add("Land", landAfterUsingFlyingSword);
			if (player.statusEffectv2(StatusEffects.Flying) == 2) buttons.add("Land", landAfterUsingSoulforce);
            buttons.add("Great Dive", greatDive).hint("Make a Great Dive to deal TONS of damage!");
        }
        if (player.hasStatusEffect(StatusEffects.KnowsFlamesOfLove)) {
            bd = buttons.add("Flames of Love", flamesOfLove).hint("Turn your burning lust into literal flames of passion. Can your enemies take your heat?  \n\nWould go into cooldown after use for: "+Math.round(player.statusEffectv1(StatusEffects.KnowsFlamesOfLove))+" round  \n\nLust cost: "+flamesOfLoveLC()+"% of current lust");
            if (player.hasStatusEffect(StatusEffects.CooldownFlamesOfLove)) {
                bd.disable("You need more time before you can use Flames of Love again.");
            } else if (player.lust < 50) {
                bd.disable("Your current lust is too low.");
            }
        }
        if (player.hasStatusEffect(StatusEffects.KnowsIciclesOfLove)) {
            bd = buttons.add("Icicles of Love", iciclesOfLove).hint("Crystalise your lust into cold spikes. Impale your foes with love!  \n\nWould go into cooldown after use for: "+Math.round(player.statusEffectv1(StatusEffects.KnowsIciclesOfLove))+" round  \n\nLust cost: "+iciclesOfLoveLC()+"% of current lust");
            if (player.hasStatusEffect(StatusEffects.CooldownIciclesOfLove)) {
                bd.disable("You need more time before you can use Icicles of Love again.");
            } else if (player.lust < 50) {
                bd.disable("Your current lust is too low.");
            }
        }
		if (player.hasStatusEffect(StatusEffects.KnowsStormOfSisterhood)) {
			bd = buttons.add("Storm of Sisterhood", stormOfSisterhood).hint("Focus your wrath into the storm of sisterhood.  \n\nWould go into cooldown after use for: "+Math.round(player.statusEffectv1(StatusEffects.KnowsStormOfSisterhood))+" round  \n\nWrath cost: "+stormOfSisterhoodWC()+"% of current wrath");
			if (player.hasStatusEffect(StatusEffects.CooldownStormOfSisterhood)) {
				bd.disable("You need more time before you can use Storm of Sisterhood again.");
			} else if (player.wrath < 50) {
				bd.disable("Your current wrath is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsNightOfBrotherhood)) {
			bd = buttons.add("Night of Brotherhood", nightOfBrotherhood).hint("Condense your wrath into a wreath of shadows, filled with the hate of your brotherhood.  \n\nWould go into cooldown after use for: "+Math.round(player.statusEffectv1(StatusEffects.KnowsNightOfBrotherhood))+" round  \n\nWrath cost: "+nightOfBrotherhoodWC()+"% of current wrath");
			if (player.hasStatusEffect(StatusEffects.CooldownNightOfBrotherhood)) {
				bd.disable("You need more time before you can use Night of Brotherhood again.");
			} else if (player.wrath < 50) {
				bd.disable("Your current wrath is too low.");
			}
		}
        if (player.hasStatusEffect(StatusEffects.KnowsHeavensDevourer)) {
            bd = buttons.add("Devourer", heavensDevourer).hint("Form a small sphere inscribed by symbols to drain from enemy a bit of lust and/or wrath.  \n\nWould go into cooldown after use for: 3 rounds");
            if (player.hasStatusEffect(StatusEffects.CooldownHeavensDevourer)) {
                bd.disable("You need more time before you can use Devourer again.");
            }
        }
		if ((monster.hasStatusEffect(StatusEffects.Stunned) || monster.hasStatusEffect(StatusEffects.StunnedTornado) || monster.hasStatusEffect(StatusEffects.Polymorphed) || monster.hasStatusEffect(StatusEffects.Sleep) || monster.hasStatusEffect(StatusEffects.Fascinated)) && (player.fatigueLeft() > combat.physicalCost(20)) && player.hasPerk(MutationsLib.HollowFangsPrimitive)) {
			bd = buttons.add("Bite", VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
		}// || monster.hasStatusEffect(StatusEffects.InvisibleOrStealth)
		if (player.hasStatusEffect(StatusEffects.CombatFollowerZenji) && (player.statusEffectv3(StatusEffects.CombatFollowerZenji) == 1 || player.statusEffectv3(StatusEffects.CombatFollowerZenji) == 3)) {
			bd = buttons.add("Heal Zenji", HealZenji);
		}
		if (player.hasPerk(PerkLib.JobGolemancer) && (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] > 0 || flags[kFLAGS.PERMANENT_GOLEMS_BAG] > 0)) bd = buttons.add("Golems", GolemsMenu);
		if (player.hasPerk(PerkLib.JobElementalConjurer) && player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) bd = buttons.add("Elem.Asp", ElementalAspectsMenu);
		if (player.hasPerk(PerkLib.PrestigeJobNecromancer) && player.perkv2(PerkLib.PrestigeJobNecromancer) > 0) {
			bd = buttons.add("S.S. to F.", sendSkeletonToFight).hint("Send Skeleton to fight - Order your Skeletons to beat the crap out of your foe.");
			if (monster.isFlying() && (!player.hasPerk(PerkLib.GreaterHarvest) || player.perkv1(PerkLib.GreaterHarvest) == 0)) {
				bd.disable("None of your skeletons can attack airborn enemies.");
			}
			if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 5) {
				bd = buttons.add("S.S.", skeletonSmash).hint("Skeleton Smash - Order your Skeletons to go all out on your foe.");
				if (monster.isFlying()) {
					bd.disable("None of your skeletons can attack airborn enemies.");
				}
			}
		}
		if (player.hasPerk(PerkLib.MyBloodForBloodPuppies)) {
			var bloodForBloodGod:Number = (player.HP - player.minHP());
			bd = buttons.add("B.P. BS", bloodSwipeBloodPuppies).hint("Command Blood Puppies to attack enemy/ies with Blood Swipe. Would deal 2x dmg to group enemies. (Can be used once per turn and will not end PC combat turn after use)  Blood Cost: " + spellCostBlood(20) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(20)) {
				bd.disable("Your hp is too low to summon your Blood Puppies.");
			}
			else if (flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] == 1) {
				bd.disable("You've already commanded your Puppies to attack this turn.");
			}
			bd = buttons.add("B.P. HS", heartSeekerBloodPuppies).hint("Command Blood Puppies to attack enemy/ies with Heart Seeker. Would deal 10x dmg to group enemies. (Can be used once per turn and will not end PC combat turn after use)  Blood Cost: " + spellCostBlood(40) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(40)) {
				bd.disable("Your hp is too low to allow Blood Puppies use this soulskill.");
			}
			else if (flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] == 1) {
				bd.disable("Your already commanded Puppies to attack this turn.");
			}
			bd = buttons.add("B.P. BD", bloodDewdropsBloodPuppies).hint("Command Blood Puppies to attack enemy/ies with Blood Dewdrops. Would deal 10x dmg to group enemies. (Can be used once per turn and will not end PC combat turn after use)  Blood Cost: " + spellCostBlood(80) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(80)) {
				bd.disable("Your hp is too low to allow Blood Puppies use this soulskill.");
			}
			else if (flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] == 1) {
				bd.disable("Your already commanded Puppies to attack this turn.");
			}
		}
		if (player.hasPerk(PerkLib.HiddenJobAsura)) {
			if (player.statStore.hasBuff("AsuraForm")) {
				bd = buttons.add("Return", returnToNormalShape).hint("Return to normal from Asura form.");
				bd = buttons.add("Asura's Howl", asurasHowl).hint("Unleash a howl before giving enemy good punching. \n\nWrath Cost: 50");
				if (player.wrath < 50) {
					bd.disable("Your wrath is too low to unleash your howl!");
				}
				if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) {
					bd = buttons.add("SFoD", asurasSixFingersOfDestruction).hint("Six Fingers of Destruction - Poke your enemies Asura Style. \n\nWrath Cost: 50% of max Wrath");
					if (player.wrath < (player.maxWrath() * 0.5)) {
						bd.disable("Your wrath is too low to use Six Fingers of Destruction!");
					}
				}
				if (player.hasPerk(PerkLib.AsuraStrength)) {
				
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
		if (player.hasPerk(PerkLib.Lustzerker) || player.jewelryName == "Flame Lizard ring" || player.jewelryName2 == "Flame Lizard ring" || player.jewelryName3 == "Flame Lizard ring" || player.jewelryName4 == "Flame Lizard ring") {
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
		if (player.oniScore() >= mspecials.minOniScoreReq()) {
			bd = buttons.add("Oni Rampage", mspecials.startOniRampage).hint("Increase all damage done by a massive amount but silences you. While this is active, you cannot use spells or magical oriented soulskills.");
			bd.requireFatigue(spellCost(50));
			if(player.hasStatusEffect(StatusEffects.OniRampage)) {
				bd.disable("You're already rampaging!");
			}
		}
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll1)) {
			if (player.statStore.hasBuff("NoLimiterState")) bd = buttons.add("No limiter", returnToNormalState).hint("Toggle off No limiter.");
			else bd = buttons.add("No limiter", noLimiterState).hint("Toggle on No limiter. (STR+++, ?Lib-?)");
		}
		if (player.hasPerk(PerkLib.ElementalBody)) {
			if (player.perkv1(PerkLib.ElementalBody) == 1) {//sylph
				bd = buttons.add("Wind Blade", curry(mspecials.FusionSpecialFirst, player.statusEffectv2(StatusEffects.SummonedElementalsAirE), 1)).hint("Soulforce cost: " + Math.round(10 * soulskillCost() * soulskillcostmulti()));
				if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
					bd.disable("Your current soulforce is too low.");
				}
				else if (player.hasStatusEffect(StatusEffects.InsideSmallSpace)) {
					bd.disable("You can't use this inside too small spaces.");
				}
				bd = buttons.add("Healing Breeze", curry(mspecials.FusionSpecialSecond, player.statusEffectv2(StatusEffects.SummonedElementalsAirE), 1)).hint("Soulforce cost: " + Math.round(10 * soulskillCost() * soulskillcostmulti()));
				if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
					bd.disable("Your current soulforce is too low.");
				}
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 5) {
					//True Evasion
				}
			}
			if (player.perkv1(PerkLib.ElementalBody) == 2) {//gnome
				bd = buttons.add("Wild Growth", curry(mspecials.FusionSpecialFirst, player.statusEffectv2(StatusEffects.SummonedElementalsEarthE), 2)).hint("Soulforce cost: " + Math.round(10 * soulskillCost() * soulskillcostmulti()));
				if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
					bd.disable("Your current soulforce is too low.");
				}
				else if (monster.hasStatusEffect(StatusEffects.Flying)) {
					bd.disable("You can reach flying targets.");
				}
				bd = buttons.add("Synthesis", curry(mspecials.FusionSpecialSecond, player.statusEffectv2(StatusEffects.SummonedElementalsEarthE), 2)).hint("Soulforce cost: " + Math.round(10 * soulskillCost() * soulskillcostmulti()));
				if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
					bd.disable("Your current soulforce is too low.");
				}
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) == 5) {
					//Adamantine Shell
				}
			}
			if (player.perkv1(PerkLib.ElementalBody) == 3) {//ignis
				bd = buttons.add("Pyroblast", curry(mspecials.FusionSpecialFirst, player.statusEffectv2(StatusEffects.SummonedElementalsFireE), 3)).hint("Soulforce cost: " + Math.round(10 * soulskillCost() * soulskillcostmulti()));
				if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
					bd.disable("Your current soulforce is too low.");
				}
				bd = buttons.add("Warmth", curry(mspecials.FusionSpecialSecond, player.statusEffectv2(StatusEffects.SummonedElementalsFireE), 3)).hint("Soulforce cost: " + Math.round(10 * soulskillCost() * soulskillcostmulti()));
				if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
					bd.disable("Your current soulforce is too low.");
				}
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) == 5) {
					//Fiery Rage
				}
			}
			if (player.perkv1(PerkLib.ElementalBody) == 4) {//undine
				bd = buttons.add("Hydraulic Torrent", curry(mspecials.FusionSpecialFirst, player.statusEffectv2(StatusEffects.SummonedElementalsWaterE), 4)).hint("Soulforce cost: " + Math.round(10 * soulskillCost() * soulskillcostmulti()));
				if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
					bd.disable("Your current soulforce is too low.");
				}
				bd = buttons.add("Lifewater", curry(mspecials.FusionSpecialSecond, player.statusEffectv2(StatusEffects.SummonedElementalsWaterE), 4)).hint("Soulforce cost: " + Math.round(10 * soulskillCost() * soulskillcostmulti()));
				if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
					bd.disable("Your current soulforce is too low.");
				}
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) == 5) {
					//Moment of Clarity
				}
			}
		}
    }
	public function GolemsMenu():void {
		menu();
		if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] > 0) {
			if (monster.isFlying() && !player.hasPerk(PerkLib.ExpertGolemMaker)) {
				addButtonDisabled(0, "Send T.Gol/1", "Your golems can't attack flying targets. (Only golems made by an expert golem maker can do this!)");
				if (monster.plural) {
					addButtonDisabled(5, "Send T.Gol/3", "Your golems can't attack flying targets. (Only golems made by an expert golem maker can do this!)");
					addButtonDisabled(10, "Send T.Gol/5", "Your golems can't attack flying targets. (Only golems made by an expert golem maker can do this!)");
				}
				if (player.hasPerk(PerkLib.TemporalGolemsRestructurationEx)) addButtonDisabled(3, "KamikazeProtocol", "Your golems can't attack flying targets. (Only golems made by an expert golem maker can do this)");
			}
			else {
				addButton(0, "Send T.Gol/1", combat.pspecials.sendTemporalGolem1)
					.hint("Send one golem from your bag to attack the enemy. <b>After attacking, the golem will fall apart"+(player.hasPerk(PerkLib.MasterGolemMaker)?"":" and its core can shatter, leaving it unable to be reused in future")+"!</b>");
				if (player.hasPerk(PerkLib.TemporalGolemsRestructuration)) {
					if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] >= 4) addButton(1, "Send T.Gol/4", combat.pspecials.sendTemporalGolem4)
						.hint("Send four golems from your bag to attack the enemy. <b>After attacking, the golem will fall apart!</b>");
					if (monster.plural) {
						if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] >= 10) addButton(6, "Send T.Gol/10", combat.pspecials.sendTemporalGolem10)
							.hint("Send ten golems from your bag to attack the enemy. <b>After attacking, the golems will fall apart!</b>");
						if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] >= 20) addButton(11, "Send T.Gol/20", combat.pspecials.sendTemporalGolem20)
							.hint("Send twenty golems from your bag to attack the enemy. <b>After attacking, the golems will fall apart!</b>");
					}
				}
				if (monster.plural) {
					if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] >= 3) addButton(5, "Send T.Gol/3", combat.pspecials.sendTemporalGolem3)
						.hint("Send three golems from your bag to attack the enemy. <b>After attacking, the golems will fall apart"+(player.hasPerk(PerkLib.MasterGolemMaker)?"":" and their cores can shatter, leaving them unable to be reused in future")+"!</b>");
					if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] >= 5) addButton(10, "Send T.Gol/5", combat.pspecials.sendTemporalGolem5)
						.hint("Send five golems from your bag to attack the enemy. <b>After attacking, the golems will fall apart"+(player.hasPerk(PerkLib.MasterGolemMaker)?"":" and their cores can shatter, leaving them unable to be reused in future")+"!</b>");
				}
				if (player.hasPerk(PerkLib.TemporalGolemsRestructurationEx)) addButton(4, "KamikazeProtocol", combat.pspecials.sendTemporalGolemKamikazeProtocol)
					.hint("Send all temporal golems from your bag to attack the enemy. <b>After attacking, the golems will fall apart!</b>");
			}
		}
        if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] > 0) {
            if (monster.isFlying() && !player.hasPerk(PerkLib.GrandMasterGolemMaker)) {
				addButtonDisabled(2, "Send P.Gol/1", "Your golems can't attack flying targets. (Only golems made by a grand-master golem maker can do this!)");
				if (monster.plural) {
					addButtonDisabled(7, "Send P.Gol/3", "Your golems can't attack flying targets. (Only golems made by a grand-master golem maker can do this!)");
					addButtonDisabled(12, "Send P.Gol/5", "Your golems can't attack flying targets. (Only golems made by a grand-master golem maker can do this!)");
				}
            }
			else {
				addButton(2, "Send P.Gol/1", combat.pspecials.sendPermanentGolem1)
					.hint("Send one stone golem from your bag to attack the enemy.");
				if (monster.plural) {
					if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] >= 3) addButton(7, "Send P.Gol/3", combat.pspecials.sendPermanentGolem3)
						.hint("Send three stone golems from your bag to attack the enemy.");
					if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] >= 5) addButton(12, "Send P.Gol/5", combat.pspecials.sendPermanentGolem5)
						.hint("Send five stone golems from your bag to attack the enemy.");
				}
			}
        }
        if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] > 0) {
            addButton(3, "Send I.P.Gol/1", combat.pspecials.sendPermanentImprovedGolem1)
				.hint("Send one improved stone golem from your bag to attack the enemy.");
			if (monster.plural) {
				if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] >= 3) addButton(8, "Send I.P.Gol/3", combat.pspecials.sendPermanentImprovedGolem3)
					.hint("Send three improved stone golems from your bag to attack the enemy.");
				if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] >= 5) addButton(13, "Send I.P.Gol/5", combat.pspecials.sendPermanentImprovedGolem5)
					.hint("Send five improved stone golems from your bag to attack the enemy.");
			}
        }
		if (flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] > 0) {
			addButton(9, "Send S.Gol/1", combat.pspecials.sendPermanentSteelGolem1)
				.hint("Send one steel golem from your bag to attack the enemy.");
		}
		addButton(14, "Back", combat.combatMenu, false);
	}
	public function ElementalAspectsMenu():void {
		menu();
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectAir)) addButtonDisabled(0, "Air E.Asp", "You've already used the air elemental aspect in this fight!");
			else addButton(0, "Air E.Asp", combat.mspecials.ElementalAspectAir);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectEarth)) addButtonDisabled(1, "Earth E.Asp", "You've already used the earth elemental aspect in this fight!");
			else addButton(1, "Earth E.Asp", combat.mspecials.ElementalAspectEarth);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectFire)) addButtonDisabled(2, "Fire E.Asp", "You've already used the fire elemental aspect in this fight!");
			else addButton(2, "Fire E.Asp", combat.mspecials.ElementalAspectFire);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectWater)) addButtonDisabled(3, "Water E.Asp", "You've already used the water elemental aspect in this fight!");
			else addButton(3, "Water E.Asp", combat.mspecials.ElementalAspectWater);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectEther)) addButtonDisabled(4, "Ether E.Asp", "You've already used the ether elemental aspect in this fight!");
			else addButton(4, "Ether E.Asp", combat.mspecials.ElementalAspectEther);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectWood)) addButtonDisabled(5, "Wood E.Asp", "You've already used the wood elemental aspect in this fight!");
			else addButton(5, "Wood E.Asp", combat.mspecials.ElementalAspectWood);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectMetal)) addButtonDisabled(6, "Metal E.Asp", "You've already used the metal elemental aspect in this fight!");
			else addButton(6, "Metal E.Asp", combat.mspecials.ElementalAspectMetal);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectIce)) addButtonDisabled(7, "Ice E.Asp", "You've already used the ice elemental aspect in this fight!");
			else addButton(7, "Ice E.Asp", combat.mspecials.ElementalAspectIce);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectLightning)) addButtonDisabled(8, "Lightning E.Asp", "You've already used the lightning elemental aspect in this fight!");
			else addButton(8, "Lightning E.Asp", combat.mspecials.ElementalAspectLightning);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectDarkness)) addButtonDisabled(9, "Darkness E.Asp", "You've already used the darkness elemental aspect in this fight!");
			else addButton(9, "Darkness E.Asp", combat.mspecials.ElementalAspectDarkness);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsPoison)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectPoison)) addButtonDisabled(10, "Poison E.Asp", "You've already used the poison elemental aspect in this fight!");
			else addButton(10, "Poison E.Asp", combat.mspecials.ElementalAspectPoison);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsPurity)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectPurity)) addButtonDisabled(11, "Purity E.Asp", "You've already used the purity elemental aspect in this fight!");
			else addButton(11, "Purity E.Asp", combat.mspecials.ElementalAspectPurity);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsCorruption)) {
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectCorruption)) addButtonDisabled(12, "Corruption E.Asp", "You've already used the corruption elemental aspect in this fight!");
			else addButton(12, "Corruption E.Asp", combat.mspecials.ElementalAspectCorruption);
		}
		//?lust?
		addButton(14, "Back", combat.combatMenu, false);
	}

    //ALCHEMY ZONE
    public function CalcAlchemyPower():Number{
        var power:Number = 0;
        power += scalingBonusWisdom();
        if (player.hasPerk(PerkLib.PlantKnowledge)) power += scalingBonusLibido();
        power += player.herbalismLevel*10;
        power = Math.round(power);
        return power;
    }

    public function Poultice():void {
        clearOutput();
        var power:Number = CalcAlchemyPower();
        power += (player.maxHP()*0.15)+(power*0.01*player.maxHP());
        if (player.hasPerk(PerkLib.NaturalHerbalism)) power *= 2;
        Math.round(power);
        HPChange(power,false);
        outputText("You apply the poultice, your wounds closing at high speed. Healed for "+power+"");
    }

    public function EnergyDrink():void {
        clearOutput();
        var power:Number = CalcAlchemyPower()*5;
        fatigue(-power);
        player.mana += power;
        player.soulforce += power;
        outputText("You chug your energy drink, and as you toss the container aside, you feel your body loosen, your mind fizzing with sudden mana. Your soul feels much better, power whirling through you. Recovered "+power+" ressources.");
    }

    public function Cure():void {
        clearOutput();
        player.buff("Poison").remove();
        player.removeStatusEffect(StatusEffects.BurnDoT);
        player.removeStatusEffect(StatusEffects.BurnDoT2);
        player.removeStatusEffect(StatusEffects.FrostburnDoT);
        player.removeStatusEffect(StatusEffects.FrozenLung);
        player.removeStatusEffect(StatusEffects.Hemorrhage);
        outputText("You drink up the cure, feeling relieved as your status ailments are cleansed.");
    }

    public function Painkiller():void {
        clearOutput();
        var power:Number = (CalcAlchemyPower()*0.05)+10; //needs to be calculated in game
        var duration:Number = Math.round(power/100)+5;
        //strength then Duration in hours
        player.createStatusEffect(StatusEffects.ArmorPotion,power,duration,0,0);
        outputText("You drink up the medicine, feeling any lingering pain recede as your skin hardens like stone. "+power+" "+duration+"");
    }

    public function Stimulant():void {
        clearOutput();
        var power:Number = (CalcAlchemyPower()*0.05)+10; //needs to be calculated in game
        var duration:Number = Math.round(power/100)+5;
        //strength then Duration in hours
        player.createStatusEffect(StatusEffects.AttackPotion,power,duration,0,0);
        outputText("You drink up the medicine, feeling stronger and more agile already. "+power+" "+duration+"");
    }

    public function Perfume():void {
        clearOutput();
        var power:Number = (CalcAlchemyPower()*0.05)+10; //needs to be calculated in game
        var duration:Number = Math.round(power/100)+5;
        //strength then Duration in hours
        if (!player.isAlraune()){
            outputText("You grab your bottle of Alraune perfume and spray yourself knowingly. Your opponent is going to have issues resisting your charms now. "+power+" "+duration+"");
            player.createStatusEffect(StatusEffects.ArousalPotion,power,duration,0,0);
        }
        else {
            outputText("You grab your bottle of Alraune perfume and almost spray yourself before remembering that you actualy already produce your own perfume, heck you are bathing into it! You slap yourself before puting back the item in your bag... what a dummy.");
            player.changeNumberOfPotions(PotionType.PERFUME, +1);
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
        teases.teaseAttack();
    }

    public function stopChanneledSpecial():void {
        clearOutput();
        outputText("You decided to stop preparing your super ultra hyper mega fabulous attack!\n\n");
		if (player.hasPerk(PerkLib.RagingInfernoSu) && player.hasStatusEffect(StatusEffects.CounterRagingInferno)) player.addStatusValue(StatusEffects.CounterRagingInferno, 3, -1);
		if (player.hasPerk(PerkLib.GlacialStormSu) && player.hasStatusEffect(StatusEffects.CounterGlacialStorm)) player.addStatusValue(StatusEffects.CounterGlacialStorm, 3, -1);
		if (player.hasPerk(PerkLib.HighVoltageSu) && player.hasStatusEffect(StatusEffects.CounterHighVoltage)) player.addStatusValue(StatusEffects.CounterHighVoltage, 3, -1);
		if (player.hasPerk(PerkLib.EclipsingShadowSu) && player.hasStatusEffect(StatusEffects.CounterEclipsingShadow)) player.addStatusValue(StatusEffects.CounterEclipsingShadow, 3, -1);
        player.removeStatusEffect(StatusEffects.ChanneledAttack);
        player.removeStatusEffect(StatusEffects.ChanneledAttackType);
        combatRoundOver();
    }

    public function unarmedAttack():Number {
        var unarmed:Number = 0;
        var unarmedMulti:Number = 1;
        if (player.hasPerk(PerkLib.JobMonk) && player.wis >= 60) unarmed += 10 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.PrestigeJobSoulArtMaster) && player.wis >= 200) unarmed += 10 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.BodyCultivator)) unarmed += 2 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.FleshBodyApprenticeStage)) {
            if (player.hasPerk(PerkLib.SoulApprentice)) unarmed += 5 * (1 + player.newGamePlusMod());
            if (player.hasPerk(PerkLib.SoulPersonage)) unarmed += 5 * (1 + player.newGamePlusMod());
            if (player.hasPerk(PerkLib.SoulWarrior)) unarmed += 5 * (1 + player.newGamePlusMod());
        }
        if (player.hasPerk(PerkLib.FleshBodyWarriorStage)) {
            if (player.hasPerk(PerkLib.SoulSprite)) unarmed += 8 * (1 + player.newGamePlusMod());
            if (player.hasPerk(PerkLib.SoulScholar)) unarmed += 8 * (1 + player.newGamePlusMod());
            if (player.hasPerk(PerkLib.SoulElder)) unarmed += 8 * (1 + player.newGamePlusMod());
        }
        if (player.hasPerk(PerkLib.FleshBodyElderStage)) {
            if (player.hasPerk(PerkLib.SoulExalt)) unarmed += 11 * (1 + player.newGamePlusMod());
            if (player.hasPerk(PerkLib.SoulOverlord)) unarmed += 11 * (1 + player.newGamePlusMod());
            if (player.hasPerk(PerkLib.SoulTyrant)) unarmed += 11 * (1 + player.newGamePlusMod());
        }
        if (player.hasPerk(PerkLib.FleshBodyOverlordStage)) {
            if (player.hasPerk(PerkLib.SoulKing)) unarmed += 14 * (1 + player.newGamePlusMod());
            if (player.hasPerk(PerkLib.SoulEmperor)) unarmed += 14 * (1 + player.newGamePlusMod());
            if (player.hasPerk(PerkLib.SoulAncestor)) unarmed += 14 * (1 + player.newGamePlusMod());
        }
        if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) unarmed += 12 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) unarmed += 18 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) unarmed += 24 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) unarmed += 30 * (1 + player.newGamePlusMod());
        if (player.hasStatusEffect(StatusEffects.MetalSkin)) {
            if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 6) unarmed += 4 * player.statusEffectv2(StatusEffects.SummonedElementalsMetal) * (1 + player.newGamePlusMod());
            else unarmed += 2 * player.statusEffectv2(StatusEffects.SummonedElementalsMetal) * (1 + player.newGamePlusMod());
        }
		if (player.hasPerk(PerkLib.ElementalBody)) {
			if (player.perkv1(PerkLib.ElementalBody) == 1) {
				if (player.perkv2(PerkLib.ElementalBody) == 1) unarmedMulti += .05;
				if (player.perkv2(PerkLib.ElementalBody) == 2) unarmedMulti += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 3) unarmedMulti += .15;
				if (player.perkv2(PerkLib.ElementalBody) == 4) unarmedMulti += .2;
			}
			if (player.perkv1(PerkLib.ElementalBody) == 2) {
				if (player.perkv2(PerkLib.ElementalBody) == 1) unarmedMulti += .05;
				if (player.perkv2(PerkLib.ElementalBody) == 2) unarmedMulti += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 3) unarmedMulti += .15;
				if (player.perkv2(PerkLib.ElementalBody) == 4) unarmedMulti += .2;
			}
			if (player.perkv1(PerkLib.ElementalBody) == 3) {
				if (player.perkv2(PerkLib.ElementalBody) == 1) unarmedMulti += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 2) unarmedMulti += .2;
				if (player.perkv2(PerkLib.ElementalBody) == 3) unarmedMulti += .3;
				if (player.perkv2(PerkLib.ElementalBody) == 4) unarmedMulti += .4;
			}
		}
		if (player.isGargoyle() && Forgefather.material == "marble")
			{
				if (Forgefather.refinement == 1) unarmedMulti += (.15);
				if (Forgefather.refinement == 2) unarmedMulti += (.25);
				if (Forgefather.refinement == 3 || Forgefather.refinement == 4) unarmedMulti += (.5);
				if (Forgefather.refinement == 5) unarmedMulti += (1);
			}
        if (player.statStore.hasBuff("CrinosShape") && player.hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalWeapons)) unarmed *= 1.1;
        if (player.hasPerk(PerkLib.Lycanthropy)) unarmed += 8 * (1 + player.newGamePlusMod());
		if (player.arms.type == Arms.HINEZUMI) unarmed += 4 * (1 + player.newGamePlusMod());
        if (player.arms.type == Arms.YETI || player.arms.type == Arms.BEAR) unarmed += 5 * (1 + player.newGamePlusMod());
        if (player.arms.type == Arms.CAT || player.arms.type == Arms.LION) unarmed += 6 * (1 + player.newGamePlusMod());
        if (player.arms.type == Arms.FROSTWYRM) unarmed += 12 * (1 + player.newGamePlusMod());
        if (player.arms.type == Arms.MANTIS || player.arms.type == Arms.KAMAITACHI) unarmed += 15 * (1 + player.newGamePlusMod());
        if (player.arms.type == Arms.DISPLACER) {
            unarmed += 6 * (1 + player.newGamePlusMod());
            if (player.hasPerk(MutationsLib.DisplacerMetabolism)) unarmed += 6 * (1 + player.newGamePlusMod());
            if (player.hasPerk(MutationsLib.DisplacerMetabolismPrimitive)) unarmed += 6 * (1 + player.newGamePlusMod());
        }
        if (player.lowerBody == LowerBody.HINEZUMI) unarmed += 4 * (1 + player.newGamePlusMod());
        if (player.lowerBody == LowerBody.BEAR) unarmed += 5 * (1 + player.newGamePlusMod());
        if (player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.LION) unarmed += 6 * (1 + player.newGamePlusMod());
        if (player.lowerBody == LowerBody.CANCER) unarmed += 12 * (1 + player.newGamePlusMod());
        if (player.tailType == Tail.HINEZUMI) unarmed += 4 * (1 + player.newGamePlusMod());
        if (player.hasPerk(MutationsLib.DraconicBones)) unarmed += 10 * (1 + player.newGamePlusMod());
        if (player.hasPerk(MutationsLib.DraconicBonesPrimitive)) unarmed += 10 * (1 + player.newGamePlusMod());
        if (player.hasPerk(MutationsLib.DraconicBonesEvolved)) unarmed += 20 * (1 + player.newGamePlusMod());
        if (player.hasKeyItem("Rocket Boots") >= 0) unarmed += 2;
        if (player.hasKeyItem("Nitro Boots") >= 0) unarmed += 4;
        if (player.hasPerk(PerkLib.Brawn)) unarmedMulti += .05;
        if (player.hasPerk(PerkLib.ImprovedBrawn)) unarmedMulti += .1;
        if (player.hasPerk(PerkLib.GreaterBrawn)) unarmedMulti += .15;
        if (player.hasPerk(PerkLib.EpicBrawn)) unarmedMulti += .2;
        if (player.hasPerk(PerkLib.LegendaryBrawn)) unarmedMulti += .25;
        if (player.hasPerk(PerkLib.MythicalBrawn)) unarmedMulti += .3;
        if (player.hasPerk(MutationsLib.DraconicBonesEvolved)) unarmedMulti += .5;
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
        /*if (player.hasPerk(PerkLib.)) historyTacticianB += 0.1;
	if (player.hasPerk(PerkLib.)) historyTacticianB += 0.1;
	if (player.hasPerk(PerkLib.)) historyTacticianB += 0.1;
	if (player.hasPerk(PerkLib.)) historyTacticianB += 0.1;
	if (player.hasPerk(PerkLib.)) historyTacticianB += 0.1;
	if (player.hasPerk(PerkLib.)) historyTacticianB += 0.1;
	if (player.hasPerk(PerkLib.)) historyTacticianB += 0.1;*/
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

    public function basemeleeattacks():void {
        /*if (flags[kFLAGS.MELEE_DAMAGE_OVERHAUL] == 1) {
	MDODialogs = true; // JA dialogs, look 3875
	}*/
        if (player.hasStatusEffect(StatusEffects.TaintedMind)) {
            if (monster as DriderIncubus) taintedMindAttackAttempt();
            return;
        }

        clearOutput();
        if (SceneLib.urtaQuest.isUrta()) {
            flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
        }
        if ((player.weaponSpecials("") || player.weaponSpecials("Dual") || player.weaponSpecials("Hybrid"))) {
            if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] >= 0) {
                flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = Math.min(maxCurrentAttacks(), (flags[kFLAGS.DOUBLE_ATTACK_STYLE] || 0) + 1);
				if (canSpearDance() && player.isSpearTypeWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise() && player.hasPerk(PerkLib.ELFElvenSpearDancingFlurry1to4)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += player.perkv1(PerkLib.ELFElvenSpearDancingFlurry1to4);
                if (player.statusEffectv1(StatusEffects.CounterAction) > 0) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = player.statusEffectv1(StatusEffects.CounterAction);
                if (player.hasStatusEffect(StatusEffects.BladeDance) || player.weaponSpecials("Dual")) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 2;
                if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 1 && player.hasPerk(PerkLib.SteelStorm) && !player.hasStatusEffect(StatusEffects.CounterAction) && player.weaponSpecials("Dual")) {
                    if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 9) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 6;
                    else if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 5) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 4;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 2;
                }
            }
			else {
				flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			}
			if (player.statStore.hasBuff("AsuraForm")) {
				if (player.hasPerk(PerkLib.AsuraStrength)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 4;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 3;
			}
        }
        if (player.weaponSpecials("Large") || player.weaponSpecials("Dual Large")) {
            if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] >= 0) {
                if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] >= 2) {
                    if (player.hasPerk(PerkLib.TripleAttackLarge)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) {
                    if (player.hasPerk(PerkLib.DoubleAttackLarge)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 2;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
				if (canSpearDance() && player.isSpearTypeWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise() && player.hasPerk(PerkLib.ELFElvenSpearDancingFlurry1to4)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += player.perkv1(PerkLib.ELFElvenSpearDancingFlurry1to4);
                if (player.statusEffectv1(StatusEffects.CounterAction) > 0) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = player.statusEffectv1(StatusEffects.CounterAction);
				if ((player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking)) && (player.hasPerk(PerkLib.FuelForTheFire) || player.hasPerk(PerkLib.Anger))) {
					if (player.hasPerk(PerkLib.Anger) && player.hp100 < 50) {
						if (player.hp100 < 100) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 2;
						else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 1;
					}
					flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 1;
				}
                if (player.weaponSpecials("Dual Large")) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 2;
                if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 1 && player.hasPerk(PerkLib.SteelStorm) && !player.hasStatusEffect(StatusEffects.CounterAction) && player.weaponSpecials("Dual Large")) {
                    if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 9) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 4;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 2;
                }
            } else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			if (player.statStore.hasBuff("AsuraForm")) {
				if (player.hasPerk(PerkLib.AsuraStrength)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 4;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 3;
			}
        }
        if (player.weaponSpecials("Small") || player.weaponSpecials("Dual Small")) {
            if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] >= 0) {
                if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 9) {
                    if (player.hasPerk(PerkLib.DecaAttackSmall)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 10;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 8) {
                    if (player.hasPerk(PerkLib.NonaAttackSmall)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 9;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 7) {
                    if (player.hasPerk(PerkLib.OctaAttackSmall)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 8;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 6) {
                    if (player.hasPerk(PerkLib.HectaAttackSmall)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 7;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 5) {
                    if (player.hasPerk(PerkLib.HexaAttackSmall)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 6;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 4) {
                    if (player.hasPerk(PerkLib.PentaAttackSmall)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 5;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 3) {
                    if (player.hasPerk(PerkLib.QuadrupleAttackSmall)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 4;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 2) {
                    if (player.hasPerk(PerkLib.TripleAttackSmall)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) {
                    if (player.hasPerk(PerkLib.DoubleAttackSmall)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 2;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 1 && player.hasPerk(PerkLib.SteelStorm) && !player.hasStatusEffect(StatusEffects.CounterAction) && player.weaponSpecials("Dual Small")) {
					if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 8) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 6;
					else if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 4) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 4;
					else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 2;
                }
                if (player.weaponSpecials("Dual Small")) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 2;
            } else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			if (player.statStore.hasBuff("AsuraForm")) {
				if (player.hasPerk(PerkLib.AsuraStrength)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 4;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 3;
			}
        }
        if (player.weaponSpecials("Massive")) {
            //	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] >= 0) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			//	if (canSpearDance() && player.isSpearTypeWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise() && player.hasPerk(PerkLib.ELFElvenSpearDancingFlurry1to4)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += player.perkv1(PerkLib.ELFElvenSpearDancingFlurry1to4);
			if ((player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking)) && (player.hasPerk(PerkLib.FuelForTheFire) || player.hasPerk(PerkLib.Anger))) {
				if (player.hasPerk(PerkLib.Anger) && player.hp100 < 50) {
					if (player.hp100 < 100) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 2;
					else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 1;
				}
				flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] += 1;
			}
            if (player.statStore.hasBuff("AsuraForm")) {
				if (player.hasPerk(PerkLib.AsuraStrength)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 4;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 3;
			}
        }
        if (player.weaponSpecials("Staff") || player.weaponSpecials("Wand")) {
            //	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] >= 0) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
            flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			if (player.statStore.hasBuff("AsuraForm")) {
				if (player.hasPerk(PerkLib.AsuraStrength)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 4;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 3;
			}
        }
        if (player.isFistOrFistWeapon()) {
            if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] >= 0) {
                if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 5) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
                else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 4) {
                    if (player.hasPerk(PerkLib.FlurryOfBlows) || (player.hasPerk(PerkLib.ClawingFlurry) && flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon()))) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 5;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 3) {
                    if (player.hasPerk(PerkLib.FlurryOfBlows) || (player.hasPerk(PerkLib.MultiClawAttack) && flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon()))) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 4;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 2) {
                    if (player.hasPerk(PerkLib.ComboMaster) || (player.hasPerk(PerkLib.ExtraClawAttack) && flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon()))) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) {
                    if (player.hasPerk(PerkLib.Combo) || (player.hasPerk(PerkLib.ClawTraining) && flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon()))) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 2;
                    else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                } else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                if (player.statusEffectv1(StatusEffects.CounterAction) > 0) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = player.statusEffectv1(StatusEffects.CounterAction);
                var multimeleefistattacksCost:Number = 0;
                //multiple melee unarmed attacks costs
                if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 5) multimeleefistattacksCost += 10;
                if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 4) multimeleefistattacksCost += 6;
                if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 3) multimeleefistattacksCost += 3;
                if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 2) multimeleefistattacksCost += 1;
                if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 1) {
                    if (player.fatigue + multimeleefistattacksCost <= player.maxFatigue()) {
                        if (flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon())) fatigue(multimeleefistattacksCost);
                        else {
                            if (player.soulforce < multimeleefistattacksCost * 3) {
                                outputText("Your current soulforce is too low to attack more than once in this turn!\n\n");
                                flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                            } else {
                                fatigue(multimeleefistattacksCost);
                                player.soulforce -= multimeleefistattacksCost * 3;
                            }
                        }
                    } else {
                        outputText("You're too fatigued to attack more than once in this turn!\n\n");
                        flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
                    }
                }
            } else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			if (player.statStore.hasBuff("AsuraForm")) {
				if (player.hasPerk(PerkLib.AsuraStrength)) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 4;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] *= 3;
			}
        }
        attack();
    }

	public function simplifiedPrePCTurn():void {
		clearOutput();
		player.addStatusValue(StatusEffects.SimplifiedNonPCTurn,1,1);
		if (flags[kFLAGS.WILL_O_THE_WISP] == 0 && flags[kFLAGS.IN_COMBAT_PLAYER_WILL_O_THE_WISP_ATTACKED] != 1) {
			willothewispattacks0();
			if (flags[kFLAGS.IN_COMBAT_PLAYER_WILL_O_THE_WISP_ATTACKED] != 1 && flags[kFLAGS.WILL_O_THE_WISP] == 0) flags[kFLAGS.IN_COMBAT_PLAYER_WILL_O_THE_WISP_ATTACKED] = 1;
		}
		if (player.hasPerk(PerkLib.FirstAttackGolems) && flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1 && flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] != 1 && player.mana >= combat.pspecials.permanentgolemsendcost()) combat.pspecials.sendPermanentGolem1();
		if (player.hasPerk(PerkLib.FirstAttackElementalsSu) && player.statusEffectv2(StatusEffects.SummonedElementals) > 0 && (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 3 || flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 4) && flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] < 1) {
			if (player.hasPerk(PerkLib.ElementalBody)) {
				if (player.hasStatusEffect(StatusEffects.SummonedElementalsAirE) && player.perkv1(PerkLib.ElementalBody) != 1) baseelementalattacks(Combat.AIR_E);
				else if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarthE) && player.perkv1(PerkLib.ElementalBody) != 2) baseelementalattacks(Combat.EARTH_E);
				else if (player.hasStatusEffect(StatusEffects.SummonedElementalsFireE) && player.perkv1(PerkLib.ElementalBody) != 3) baseelementalattacks(Combat.FIRE_E);
				else if (player.hasStatusEffect(StatusEffects.SummonedElementalsWaterE) && player.perkv1(PerkLib.ElementalBody) != 4) baseelementalattacks(Combat.WATER_E);
				else baseelementalattacks(Combat.NONE_E);
			}
			else {
				if (player.hasStatusEffect(StatusEffects.SummonedElementalsAirE)) baseelementalattacks(Combat.AIR_E);
				else if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarthE)) baseelementalattacks(Combat.EARTH_E);
				else if (player.hasStatusEffect(StatusEffects.SummonedElementalsFireE)) baseelementalattacks(Combat.FIRE_E);
				else if (player.hasStatusEffect(StatusEffects.SummonedElementalsWaterE)) baseelementalattacks(Combat.WATER_E);
				else baseelementalattacks(Combat.NONE_E);
			}
		}
		if (player.hasPerk(PerkLib.FirstAttackElementals) && (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 3 || flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 4) && flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] < 2) {
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) baseelementalattacks(Combat.AIR);
			else if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) baseelementalattacks(Combat.EARTH);
			else if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) baseelementalattacks(Combat.FIRE);
			else if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) baseelementalattacks(Combat.WATER);
			else baseelementalattacks(Combat.NONE);
		}
		if (flags[kFLAGS.PLAYER_COMPANION_1] != "" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1 && !player.hasStatusEffect(StatusEffects.MinoKing)) {
			outputText("\n\n");
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Alvina") {
				comfoll.alvinaCombatActions();
				if (player.hasPerk(PerkLib.MotivationSu)) comfoll.alvinaCombatActions();
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Amily") {
				comfoll.amilyCombatActions();
				if (player.hasPerk(PerkLib.MotivationSu)) comfoll.amilyCombatActions();
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Aurora") {
				comfoll.auroraCombatActions();
				if (player.hasPerk(PerkLib.MotivationSu)) comfoll.auroraCombatActions();
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Etna") {
				comfoll.etnaCombatActions();
				if (player.hasPerk(PerkLib.MotivationSu)) comfoll.etnaCombatActions();
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Excellia") {
				comfoll.excelliaCombatActions();
				if (player.hasPerk(PerkLib.MotivationSu)) comfoll.excelliaCombatActions();
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Mitzi") {
				comfoll.mitziCombatActions();
				if (player.hasPerk(PerkLib.MotivationSu)) comfoll.mitziCombatActions();
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Neisa") {
				comfoll.neisaCombatActions();
				if (player.hasPerk(PerkLib.MotivationSu)) comfoll.neisaCombatActions();
			}
			//if (flags[kFLAGS.PLAYER_COMPANION_1] == "Siegweird") comfoll.siegweirdCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Zenji") {
				comfoll.zenjiCombatActions();
				if (player.hasPerk(PerkLib.MotivationSu)) comfoll.zenjiCombatActions();
			}
		}
		menu();
		addButton(0, "Next", combatMenu, false);
	}

    public function willothewispattacks():void {
        outputText("\n\n");
		willothewispattacks0();
        if (flags[kFLAGS.IN_COMBAT_PLAYER_WILL_O_THE_WISP_ATTACKED] != 1 && flags[kFLAGS.WILL_O_THE_WISP] == 0) {
            flags[kFLAGS.IN_COMBAT_PLAYER_WILL_O_THE_WISP_ATTACKED] = 1;
            menu();
            addButton(0, "Next", combatMenu, false);
        } else enemyAI();
    }
	private function willothewispattacks0():void {
		var willothewispDamage:Number = 0;
        willothewispDamage += intwisscaling() * 0.4;
        /*bonus do dmgh wisp-a jeśli sa inne pety/miniony ^^ im wiecej podwładnych ma tym mocniej sam bedzie bił (jak efekt perku później w drzewie Job: Leader ^^)
	if (summonedElementals >= 1) elementalDamage += baseDamage;
	if (summonedElementals >= 5) elementalDamage += baseDamage;
	if (summonedElementals >= 9) elementalDamage += baseDamage;*/
        if (willothewispDamage < 10) willothewispDamage = 10;
        if (player.hasPerk(PerkLib.HistoryTactician) || player.hasPerk(PerkLib.PastLifeTactician)) willothewispDamage *= historyTacticianBonus();
        var willothewispamplification:Number = 1;
        if (player.weapon == weapons.SCECOMM) willothewispamplification += 0.5;
        willothewispDamage *= willothewispamplification;
        //Determine if critical hit!
        var crit:Boolean = false;
        var critChance:int = 5;
        var critChanceMulti:int = 1.75;
        critChance += combatMagicalCritical();
        //dodać tu nieco szans na wyższą % szans crita - jak zwykle to z perków efekty
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        //dodać tu nieco wyższy przelicznik do crit dmg - może nawet jak crit chance jest powyżej 100% to nadmiar bedzie dodawany do obrażeń krytycznych ^^ - jak zwykle to z perków efekty
        if (rand(100) < critChance) {
            crit = true;
            willothewispDamage *= critChanceMulti;
        }
        willothewispDamage = Math.round(willothewispDamage);
        outputText("Your will-o'-the-wisp hit [monster a] [monster name]! ");
        doMagicDamage(willothewispDamage, true, true);
        if (crit) outputText(" <b>Critical! </b>");
        //checkMinionsAchievementDamage(elementalDamage);
	}

    public function baseelementalattacks(elementType:int = -1):void {
        if (elementType == -1) {
            elementType = flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE];
        } else {
            flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = elementType;
        }
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
				flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] = 2;
				break;
			case NONE_E		:
				flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] = 1;
				break;
        }
		if (elementType == NONE || elementType == NONE_E) {
			doNext(curry(combatMenu, false));
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
				doNext(curry(combatMenu, false));
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
				outputText(" hit"+(summonedElementalsMulti > 1 ? "s":"")+" [monster a] [monster name]! ");
				elementalattacks(elementType, summonedElementals, summonedElementalsMulti, summonedEpicElemental);
			}
		}
    }

    public function intwisscaling():Number {
        var intwisscalingvar:Number = 0;
        intwisscalingvar += scalingBonusIntelligence();
        intwisscalingvar += scalingBonusWisdom();
        return intwisscalingvar;
    }

    public function elementalattacks(elementType:int, summonedElementals:int, summonedElementalsMulti:Number, summonedEpicElemental:Boolean):void {
        var elementalDamage:Number = 0;
        var baseDamage:Number = summonedElementals * intwisscaling() * 0.1;
        if (summonedElementals >= 1) elementalDamage += baseDamage;
        if (summonedElementals >= 5) elementalDamage += baseDamage;
        if (summonedElementals >= 9) elementalDamage += baseDamage;
        if (summonedElementals >= 13) elementalDamage += baseDamage;
        if (elementalDamage < 10) elementalDamage = 10;
        if (player.hasPerk(PerkLib.HistoryTactician) || player.hasPerk(PerkLib.PastLifeTactician)) elementalDamage *= historyTacticianBonus();
        if (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 2 || flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 4) {
            if (summonedElementals >= 9) elementalDamage *= 4;
            else if (summonedElementals >= 5) elementalDamage *= 3;
            else elementalDamage *= 2;
        }
        var elementalamplification:Number = 1;
        if (player.hasPerk(PerkLib.ElementalConjurerResolve)) elementalamplification += 0.1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
        if (player.hasPerk(PerkLib.ElementalConjurerDedication)) elementalamplification += 0.2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
        if (player.hasPerk(PerkLib.ElementalConjurerSacrifice)) elementalamplification += 0.3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
        if (player.weapon == weapons.SCECOMM) elementalamplification += 0.5;
		if (player.weaponRange == weaponsrange.E_TOME_) elementalamplification += 0.5;
        if (player.shield == shields.Y_U_PAN) elementalamplification += 0.25;
        if (flags[kFLAGS.WILL_O_THE_WISP] == 1) {
            elementalamplification += 0.1;
            if (player.hasPerk(PerkLib.WispLieutenant)) elementalamplification += 0.2;
            if (player.hasPerk(PerkLib.WispCaptain)) elementalamplification += 0.3;
            if (player.hasPerk(PerkLib.WispMajor)) elementalamplification += 0.4;
            if (player.hasPerk(PerkLib.WispColonel)) elementalamplification += 0.5;
        }
        elementalDamage *= elementalamplification;
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
        if (elementType != AIR && elementType != AIR_E && elementType != ETHER) elementalDamage *= (monster.damagePercent() / 100);
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
                doLightingDamage(elementalDamage, true, true);
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
        if (monster.HP >= 1 && monster.lust <= monster.maxLust()) {
			if (summonedElementalsMulti > 1) {
				summonedElementalsMulti -= 1;
				elementalattacks(elementType, summonedElementals, summonedElementalsMulti, summonedEpicElemental);
			} else {
				outputText("\n\n");
				if (flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] < 2 && (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 3 || flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 4)) {
					if (summonedEpicElemental) {
						flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] = 1;
						summonedEpicElemental = false;
					}
					else flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] = 2;
					if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) {
						menu();
						addButton(0, "Next", combatMenu, false);
					}
				} else {
					wrathregeneration1();
					fatigueRecovery1();
					manaregeneration1();
					soulforceregeneration1();
					venomCombatRecharge1();
					enemyAI();
				}
			}
        } else {
            if (monster.HP <= monster.minHP()) doNext(endHpVictory);
            else doNext(endLustVictory);
        }
    }

    public function basemechmeleeattacks():void {
        flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
        clearOutput();
        var weapon:String = "";
        if (player.isInGoblinMech()) weapon = "saw blade";
		if (player.vehicles == vehicles.HB_MECH) weapon = "twin power blades";
        if (player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 0) {
            outputText("You attempt to attack, but at the last moment your mech wrenches away, preventing you from even coming close to landing a blow!  ");
            if (monster is ChaosChimera) outputText("Curse");
            else outputText("The kitsune's seals");
            outputText(" have made normal melee attacks impossible!  Maybe you could try something else?\n\n");
            enemyAI();
            return;
        }
        if (player.hasStatusEffect(StatusEffects.Sealed2) && player.statusEffectv2(StatusEffects.Sealed2) == 0) {
            outputText("You attempt to attack, but at the last moment your mech wrenches away, preventing you from even coming close to landing a blow!  Recent enemy actions have made normal melee attack impossible!  Maybe you could try something else?\n\n");
            enemyAI();
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
            enemyAI();
            return;
        }
        //Worms are special
        if (monster.short == "worms") {
            //50% chance of hit (int boost)
            if (rand(100) + player.inte / 3 >= 50) {
                var dam:int = int(player.str / 5 - rand(5));
                if (dam == 0) dam = 1;
                outputText("You strike at the amalgamation, crushing countless worms into goo, dealing <b><font color=\"#800000\">" + dam + "</font></b> damage.\n\n");
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
            enemyAI();
            return;
        }
        //Determine if dodged!
        if ((player.playerIsBlinded() && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
            //Akbal dodges special education
            if (monster.short == "Akbal") outputText("Akbal moves like lightning, weaving in and out of your furious strikes with the speed and grace befitting his jaguar body.\n");
            else if (monster.short == "plain girl") outputText("You wait patiently for your opponent to drop her guard. She ducks in and throws a right cross, which you roll away from before smacking your " + weapon + " against her side. Astonishingly, the attack appears to phase right through her, not affecting her in the slightest. You glance down to your " + weapon + " as if betrayed.\n");
            else if (monster.short == "kitsune") {
                //Player Miss:
                outputText("You swing your " + weapon + " ferociously, confident that you can strike a crushing blow.  To your surprise, you stumble awkwardly as the attack passes straight through her - a mirage!  You curse as you hear a giggle behind you, turning to face her once again.\n\n");
            } else {
                if (player.isInGoblinMech()) outputText("You activate the mech’s saw blade, intent on slicing your opponent in half. [Themonster] avoids the blade as best as it can.\n\n");
            }
            enemyAI();
            return;
        }
        //BLOCKED ATTACK:
        if (monster.hasStatusEffect(StatusEffects.Earthshield) && rand(4) == 0) {
            outputText("Your strike is deflected by the wall of sand, dirt, and rock!  Damn!\n");
            if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
                attack();
                return;
            } else outputText("\n");
            enemyAI();
            return;
        }
        baseMechMeleeAttacksDamage();
    }

    public function baseMechMeleeAttacksDamage():void {
        var damage:Number = 0;
		var weapon:String = "";
        if (player.isInGoblinMech()) weapon = "saw blade";
		if (player.vehicles == vehicles.HB_MECH) weapon = "twin power blades";
        //------------
        // DAMAGE
        //------------
        //Determine damage
        //BASIC DAMAGE STUFF
        damage += player.str;
        damage += scalingBonusStrength() * 0.25;
        if (player.hasKeyItem("HB Agility") >= 0) {
			damage += player.spe;
			damage += scalingBonusSpeed() * 0.20;
			if (player.keyItemvX("HB Agility", 1) == 1) {
				damage += (player.spe / 2);
				damage += scalingBonusSpeed() * 0.10;
			}
		}
        if (damage < 10) damage = 10;
		if (player.isInGoblinMech()) {
			damage *= 1.3;
			if (player.armor == armors.GTECHC_) damage *= 1.5;
			if (player.upperGarment == undergarments.TECHBRA) damage *= 1.05;
			if (player.lowerGarment == undergarments.T_PANTY) damage *= 1.05;
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
        if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= historyFighterBonus();
        if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
        if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
        if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
        if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
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
			damage *= (1.75 + buffMultiplier);
        }
        //Apply AND DONE!
        damage *= (monster.damagePercent() / 100);
        //One final round
        damage = Math.round(damage);
        if (damage <= 0) {
            damage = 0;
            outputText("Your attacks are deflected or blocked by [monster a] [monster name].");
        } else {
            outputText("You activate the mech’s "+weapon+", intent on slicing your opponent in half. [Themonster] takes ");
            doPhysicalDamage(damage, true, true);
			if (player.vehicles == vehicles.HB_MECH) doPhysicalDamage(damage, true, true);
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
        checkAchievementDamage(damage);
		WrathGenerationPerHit2(5);
        heroBaneProc(damage);
        EruptingRiposte();
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxLust()) {
            doNext(endLustVictory);
            return;
        }
        outputText("\n");
        wrathregeneration1();
        fatigueRecovery1();
        manaregeneration1();
        soulforceregeneration1();
		venomCombatRecharge1();
        enemyAI();
    }

    public function packAttack():void {
        //Determine if dodged!
        if (player.spe - monster.spe > 0 && int(Math.random() * (((player.spe - monster.spe) / 4) + 80)) > 80) {
            outputText("You duck, weave, and dodge.  Despite their best efforts, the throng of demons only hit the air and each other.");
        }
        //Determine if evaded
        else if ((player.hasPerk(PerkLib.Evade) && rand(100) < 10) || (player.hasPerk(PerkLib.JunglesWanderer) && rand(100) < 35)) {
            outputText("Using your skills at evading attacks, you anticipate and sidestep [monster a] [monster name]' attacks.");
        }
        //("Misdirection"
        else if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 15 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
            outputText("Using Raphael's teachings, you anticipate and sidestep [monster a] [monster name]' attacks.");
        }
        //Determine if cat'ed
        else if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
            outputText("With your incredible flexibility, you squeeze out of the way of [monster a] [monster name]' attacks.");
        } else {
            var damage:int = int((monster.str + monster.weaponAttack) * (player.damagePercent() / 100)); //Determine damage - str modified by enemy toughness!
            if (damage <= 0) {
                if (!monster.plural)
                    outputText("You deflect and block every " + monster.weaponVerb + " [monster a] [monster name] throw at you.");
                else outputText("You deflect [monster a] [monster name] " + monster.weaponVerb + ".");
            } else {
                if (damage <= 5)
                    outputText("You are struck a glancing blow by [monster a] [monster name]! ");
                else if (damage <= 10)
                    outputText(monster.capitalA + monster.short + " wound you! ");
                else if (damage <= 20)
                    outputText(monster.capitalA + monster.short + " stagger you with the force of [monster his] " + monster.weaponVerb + "s! ");
                else outputText(monster.capitalA + monster.short + " <b>mutilates</b> you with powerful fists and " + monster.weaponVerb + "s! ");
                player.takePhysDamage(damage, true);
            }
            statScreenRefresh();
            outputText("\n");
        }
    }

    public function lustAttack():void {
        flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
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
        dynStats("lus", 10 + player.effectiveSensitivity() / 10);
    }

    internal function wait():void {
        var skipMonsterAction:Boolean = false; // If false, enemyAI() will be called. If true, combatRoundOver()
        flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] = 1;
        fatigue(-5);
        wrathregeneration1();
        manaregeneration1();
        soulforceregeneration1();
        if (monster.hasStatusEffect(StatusEffects.PCTailTangle)) {
            (monster as Kitsune).kitsuneWait();
            skipMonsterAction = true;
        } else if (monster.hasStatusEffect(StatusEffects.MinotaurEntangled)) {
            clearOutput();
            outputText("You sigh and relax in the chains, eying the well-endowed minotaur as you await whatever rough treatment he desires to give.  His musky, utterly male scent wafts your way on the wind, and you feel droplets of your lust dripping down your thighs.  You lick your lips as you watch the pre-cum drip from his balls, eager to get down there and worship them.  Why did you ever try to struggle against this fate?\n\n");
            dynStats("lus", 30 + rand(5), "scale", false);
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
            dynStats("lus", player.effectiveSensitivity() / 5 + 5);
            player.takePhysDamage(5 + rand(5));
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.ScyllaBind)) {
            clearOutput();
            outputText("You're being squeezed tightly by the scylla’s powerful tentacles. That's without mentioning the fact she's rubbing your sensitive place quite a bit, giving you a knowing grin.");
            dynStats("lus", player.effectiveSensitivity() / 4 + 20);
            player.takePhysDamage(100 + rand(40));
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
				player.dynStats("lus", licklust, "scale", false);
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
            dynStats("lus", (8 + player.effectiveSensitivity() / 10));
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
            enemyAI();
        }
    }

    internal function wait2():void {
        if (monster is SandTrap) {
            (monster as SandTrap).sandTrapClimb();
        }
        if (monster is Alraune) {
            (monster as Alraune).alrauneStruggle();
        }
        wrathregeneration1();
        manaregeneration1();
        soulforceregeneration1();
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
        } else if (player.hasStatusEffect(StatusEffects.GooBind)) {
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
                outputText("You wriggle and squirm violently, tearing yourself out from within [monster a] [monster name]'s coils.");
                player.removeStatusEffect(StatusEffects.NagaBind);
            } else {
                if (monster is CaiLin && flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
                else outputText("The [monster name]");
                outputText("'s grip on you tightens as you struggle to break free from the stimulating pressure.");
                dynStats("lus", player.effectiveSensitivity() / 10 + 2);
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
                outputText("As force alone seems ineffective, you bite one of her tentacles and she screams in surprise, releasing you.");
                player.removeStatusEffect(StatusEffects.ScyllaBind);
            } else {
                outputText("Despite all of your struggles, she manages to maintain her hold on you.");
                dynStats("lus", player.effectiveSensitivity() / 5 + 5);
                player.takePhysDamage(100 + rand(80));
            }
            skipMonsterAction = true;
        } else if (player.hasStatusEffect(StatusEffects.WolfHold)) {
            clearOutput();
            if (rand(3) == 0 || rand(80) < player.str / 1.5 || player.hasPerk(PerkLib.FluidBody)) {
                if (monster is WinterWolf) outputText("You slam your forehead in the wolf's sensitive muzzle. It recoils, whining in pain. Its focus shattered, you push the winter wolf off you, allowing you to stand up.");
                if (monster is Luna) outputText("You shove Luna off of you, standing back up; Luna growls at you, licking her lips hungrily.");
                player.removeStatusEffect(StatusEffects.WolfHold);
            } else {
                if (monster is WinterWolf) {
                    outputText("The wolf growls, bringing its maw down and biting deep into you. It growls through your flesh, trying to rip a giant hunk off of you. This creature is trying to eat you alive!");
                    player.takePhysDamage(7 + rand(5));
                }
                if (monster is Luna) {
                    outputText("You try and shove Luna off but she anticipates the attempt, countering you and pinning you down again.\n");
                    outputText("Luna rends you twice with her claws.");
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
				player.dynStats("lus", licklust, "scale", false);
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
                dynStats("lus", (3 + player.effectiveSensitivity() / 10 + player.lib / 20));
                skipMonsterAction = true;
            }
        }
        if (skipMonsterAction) {
            combatRoundOver();
        } else {
            enemyAI();
        }
    }

    internal function pickUpThrownWeapons():void {
        clearOutput();
        outputText("You boldly approach your enemy. instead of attacking, you simply pick up some of your thrown weapons.");
		player.ammo += 5;
        wrathregeneration1();
        manaregeneration1();
        soulforceregeneration1();
        combatRoundOver();
    }

    public function attacksAccuracy():Number {		//unused for now function - maybe use later for some other attacks accuracy or maybe spells? xD
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
*/
        return atkmod;
    }

    public function meleeAccuracy():Number {
        var accmod:Number = 128;
		if (player.level > 0) {
			if (player.level > 5) accmod += 72;
			else accmod += 12 * player.level;
		}
        if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) accmod += 40;
        if (player.isFlying() && player.hasPerk(PerkLib.AerialCombat) && !player.haveWeaponForJouster() && !player.haveThrowableMeleeWeapon()) {
            if (player.jewelryName != "Ring of Ambidexty") accmod -= 60;
            if (player.hasPerk(PerkLib.Aerobatics)) accmod += 40;
            if (player.hasPerk(PerkLib.AdvancedAerobatics)) accmod += 100;
        }
		if (player.hasPerk(PerkLib.TrueSeeing)) accmod += 40;
        if (monster.hasStatusEffect(StatusEffects.EvasiveTeleport) && !player.hasPerk(PerkLib.TrueSeeing)) accmod -= player.statusEffectv1(StatusEffects.EvasiveTeleport);
        if (player.jewelryName == "Ring of Ambidexty") accmod += 30;
		if (player.weaponName == "fists") accmod += Math.round((masteryFeralCombatLevel() - 1) / 2);
		if (player.isGauntletWeapon()) accmod += Math.round((masteryGauntletLevel() - 1) / 2);
		if (player.isSwordTypeWeapon()) accmod += Math.round((masterySwordLevel() - 1) / 2);
		if (player.isAxeTypeWeapon()) accmod += Math.round((masteryAxeLevel() - 1) / 2);
		if (player.isMaceHammerTypeWeapon()) accmod += Math.round((masteryMaceHammerLevel() - 1) / 2);
		if (player.isDuelingTypeWeapon()) accmod += Math.round((masteryDuelingSwordLevel() - 1) / 2);
		if (player.isPolearmTypeWeapon()) accmod += Math.round((masteryPolearmLevel() - 1) / 2);
		if (player.isSpearTypeWeapon()) accmod += Math.round((masterySpearLevel() - 1) / 2);
		if (player.isDaggerTypeWeapon()) accmod += Math.round((masteryDaggerLevel() - 1) / 2);
		if (player.isWhipTypeWeapon()) accmod += Math.round((masteryWhipLevel() - 1) / 2);
		if (player.isExoticTypeWeapon()) accmod += Math.round((masteryExoticLevel() - 1) / 2);
		if (player.weaponSpecials("Dual Small")) accmod += Math.round((dualWSLevel() - 1) / 2);
		if (player.weaponSpecials("Dual")) accmod += Math.round((dualWNLevel() - 1) / 2);
		if (player.weaponSpecials("Dual Large")) accmod += Math.round((dualWLLevel() - 1) / 2);
		if (player.weaponSpecials("Dual Small") || player.weaponSpecials("Dual") || player.weaponSpecials("Dual Large")) accmod += meleeDualWieldAccuracyPenalty();
        return accmod;
    }

    public function meleeAccuracyPenalty():Number {
        var accmmodpenalty:Number = 10;
        if (player.hasPerk(MutationsLib.ElvishPeripheralNervSysEvolved)) accmmodpenalty -= 5;
		//if (player.statStore.hasBuff("AsuraForm") && player.hasPerk(PerkLib.)) accmmodpenalty -= 5;
        if (accmmodpenalty < 0) accmmodpenalty = 0;
        return accmmodpenalty;
    }

	public function meleeDualWieldAccuracyPenalty():Number {
		var accmdwmodpenalty:Number = -25;
        if (player.weaponSpecials("Dual")) {
			if (player.hasPerk(PerkLib.DualWieldNormal)) accmdwmodpenalty += 10;
		}
        if (player.weaponSpecials("Dual Large")) {
			if (player.hasPerk(PerkLib.DualWieldLarge)) accmdwmodpenalty += 10;
		}
        if (player.weaponSpecials("Dual Small")) {
			if (player.hasPerk(PerkLib.DualWieldSmall)) accmdwmodpenalty += 10;
		}
        if (player.weaponSpecials("Quad")) {
			accmdwmodpenalty -= 50;
		}
        return accmdwmodpenalty;
	}

	public function meleeDualWieldDamagePenalty():Number {
		var dmgmdwmodpenalty:Number = 1;
        if (player.weaponSpecials("Dual")) {
			if (player.hasPerk(PerkLib.DualWieldNormal)) dmgmdwmodpenalty -= 0.3;
			else dmgmdwmodpenalty -= 0.5;
		}
        if (player.weaponSpecials("Dual Large")) {
			if (player.hasPerk(PerkLib.DualWieldLarge)) dmgmdwmodpenalty -= 0.3;
			else dmgmdwmodpenalty -= 0.5;
		}
        if (player.weaponSpecials("Dual Small")) {
			if (player.hasPerk(PerkLib.DualWieldSmall)) dmgmdwmodpenalty -= 0.3;
			else dmgmdwmodpenalty -= 0.5;
		}
        if (player.weaponSpecials("Quad")) {
			dmgmdwmodpenalty -= 0.9;
		}
        return dmgmdwmodpenalty;
	}

	public function baseRangeAccuracy():Number {
		var baccmod:Number = 128;
		if (player.level > 0) {
			if (player.level > 5) baccmod += 72;
			else baccmod += 12 * player.level;
		}
        if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) baccmod += 40;
        if (player.hasPerk(PerkLib.Accuracy1)) {
            baccmod += player.perkv1(PerkLib.Accuracy1);
        }
        if (player.hasPerk(PerkLib.Accuracy2)) {
            baccmod -= player.perkv1(PerkLib.Accuracy2);
        }
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
            if (player.jewelryName != "Ring of deadeye aim") baccmod -= 100;
            if (player.hasPerk(PerkLib.Aerobatics)) baccmod += 40;
            if (player.hasPerk(PerkLib.AdvancedAerobatics)) baccmod += 100;
        }
		if (player.hasPerk(PerkLib.TrueSeeing)) baccmod += 40;
        if (monster.hasStatusEffect(StatusEffects.EvasiveTeleport) && !player.hasPerk(PerkLib.TrueSeeing)) baccmod -= player.statusEffectv1(StatusEffects.EvasiveTeleport);
        if (player.jewelryName == "Ring of deadeye aim") baccmod += 40;
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
        if (player.hasPerk(MutationsLib.ElvishPeripheralNervSysEvolved)) accrmodpenalty -= 5;
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
		if (player.weaponRangePerk == "Dual Firearms") faccmod += Math.round((dualWFLevel() - 1) / 2);
		if (player.weaponRangePerk == "Dual Firearms") faccmod += firearmsDualWieldAccuracyPenalty();
        return faccmod;
    }

    public function firearmsAccuracyPenalty():Number {
        var accfmodpenalty:Number = 10;
		if (player.hasPerk(PerkLib.LockAndLoad)) accfmodpenalty -= 5;
        if (accfmodpenalty < 0) accfmodpenalty = 0;
        return accfmodpenalty;
    }

	public function firearmsDualWieldAccuracyPenalty():Number {
		var accfdwmodpenalty:Number = -25;
		if (player.weaponSpecials("Dual Firearms")) {
			if (player.hasPerk(PerkLib.DualWieldSmall)) accfdwmodpenalty += 10;
		}
        if (player.weaponSpecials("Quad Firearms")) {
			accfdwmodpenalty -= 50;
		}
        return accfdwmodpenalty;
	}

	public function firearmsDualWieldDamagePenalty():Number {
		var dmgfdwmodpenalty:Number = 1;
        if (player.weaponSpecials("Dual Firearms")) {
			if (player.hasPerk(PerkLib.DualWieldFirearms)) dmgfdwmodpenalty -= 0.3;
			else dmgfdwmodpenalty -= 0.5;
		}
        if (player.weaponSpecials("Quad Firearms")) {
			dmgfdwmodpenalty -= 0.9;
		}
        return dmgfdwmodpenalty;
	}

    public function oneArrowTotalCost():Number {
        var onearrowcost:Number = 5;
        //additional arrow effects costs
        if (flags[kFLAGS.ELEMENTAL_ARROWS] >= 1 && flags[kFLAGS.ELEMENTAL_ARROWS] <= 7) onearrowcost += 3;
        if (flags[kFLAGS.CUPID_ARROWS] == 1) onearrowcost += 1;
        if (flags[kFLAGS.ENVENOMED_BOLTS] == 1) onearrowcost += 1;
		//cost increase (likely temporal until i make more rework on this)
		if (player.level >= 12) {//player.masteryArcheryLevel - maybe use that?
			if (player.level >= 24) {
				if (player.level >= 36) {
					if (player.level >= 48) onearrowcost *= 5;
					else onearrowcost *= 4;
				}
				else onearrowcost *= 3;
			}
			else onearrowcost *= 2;
		}
        //Bow Shooting perk cost reduction
        if (player.hasPerk(PerkLib.BowShooting)) onearrowcost *= (1 - ((player.perkv1(PerkLib.BowShooting)) / 100));
        return onearrowcost;
    }

    public function oneThrowTotalCost():Number {
        var onearrowcost:Number = 25;
        return onearrowcost;
    }

    public function fireBow():void {
        if (flags[kFLAGS.MELEE_DAMAGE_OVERHAUL] == 1) isBowDamageMDO = true;
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
        flags[kFLAGS.LAST_ATTACK_TYPE] = 1;
        if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow") {
            if (player.weaponRangePerk == "Crossbow") flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = Math.min((flags[kFLAGS.DOUBLE_STRIKE_STYLE] || 0) + 1, 3);
            else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = Math.min((flags[kFLAGS.DOUBLE_STRIKE_STYLE] || 0) + 1, maxBowAttacks());
			if (player.isElf() && player.hasPerk(PerkLib.ELFMasterShot) && player.weaponRangePerk == "Bow") flags[kFLAGS.MULTIPLE_ARROWS_STYLE] += 1;
            if (player.weaponRangeName == "Avelynn") flags[kFLAGS.MULTIPLE_ARROWS_STYLE] *= 3;
        }
        if (player.weaponRangePerk == "Throwing") {
            if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] >= 2) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
            else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 1) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
            else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 1;
        }
        if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle" || player.weaponRangePerk == "2H Firearm" || player.weaponRangePerk == "Dual Firearms") {
            if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] >= 3) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 4;
            else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 2) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
            else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 1) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
            else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 1;
			if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] >= 1 && player.hasPerk(PerkLib.LockAndLoad)) {
				if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] >= 3) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] += 2;
				else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] += 1;
			}
			if ((player.weaponRange == weaponsrange.M1CERBE || player.weaponRange == weaponsrange.SNIPPLE) && flags[kFLAGS.MULTIPLE_ARROWS_STYLE] > 1) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 1;
            if (player.weaponRange == weaponsrange.TRFATBI || player.weaponRange == weaponsrange.HARPGUN || player.weaponRange == weaponsrange.TOUHOM3 || player.weaponRange == weaponsrange.DERPLAU || player.weaponRange == weaponsrange.DUEL_P_ || player.weaponRange == weaponsrange.FLINTLK) {
				if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] >= 1 && player.hasPerk(PerkLib.PrimedClipWarp)) {
					if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] >= 6) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 6;
					else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = flags[kFLAGS.DOUBLE_STRIKE_STYLE];
				}
				else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] >= 1 && player.hasPerk(PerkLib.TaintedMagazine)) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
				else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 1;
			}
            if ((player.weaponRange == weaponsrange.ADBSCAT || player.weaponRange == weaponsrange.ADBSHOT || player.weaponRange == weaponsrange.DBDRAGG) && flags[kFLAGS.MULTIPLE_ARROWS_STYLE] > 2) {
				if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] >= 3 && player.hasPerk(PerkLib.PrimedClipWarp)) {
					if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] >= 6) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 6;
					else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = flags[kFLAGS.DOUBLE_STRIKE_STYLE];
				}
				else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] >= 3 && player.hasPerk(PerkLib.TaintedMagazine)) {
					if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] >= 4) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 4;
					else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = flags[kFLAGS.DOUBLE_STRIKE_STYLE];
				}
				else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
			}
            if (player.weaponRangePerk == "Dual Firearms") flags[kFLAGS.MULTIPLE_ARROWS_STYLE] *= 2;
        }
		if (player.vehicles == vehicles.HB_MECH) {
			if (player.hasKeyItem("HB Rapid Reload") >= 0) {
				if (player.keyItemvX("HB Rapid Reload", 1) == 1) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 4;
				else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
			}
			else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
		}
//	if (player.weaponRangePerk == "Rifle") {
        //fatigue(50, USEFATG_BOW);	//wstawić tutaj typ redukcji kosztów jak dla physical specials
//	}
        if (flags[kFLAGS.ARROWS_ACCURACY] > 0) flags[kFLAGS.ARROWS_ACCURACY] = 0;
        var weaponRangeName:String = player.weaponRangeName;
        var ammoWord:String;
        switch (weaponRangeName) {
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
        //Keep logic sane if this attack brings victory
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
        if (checkConcentration("[monster name] easily glides around your attack" + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "s" : "") + " thanks to [monster his] complete concentration on your movements.\n\n")) return; //Amily concentration
        if (monster.hasStatusEffect(StatusEffects.Sandstorm) && rand(10) > 1) {
            outputText("Your attack" + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "s" : "") + " is blown off target by the tornado of sand and wind.  Damn!\n\n");
            enemyAI();
            return;
        }
        //[Bow Response]
        if (monster.short == "Isabella" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
            if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind)) {
                outputText("Isabella hears the shot" + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "s" : "") + " and turns her shield towards " + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "them" : "it") + ", completely blocking " + (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2 ? "them" : "it") + " with her wall of steel.\n\n");
            } else {
                outputText("You ");
                if (player.weaponRangePerk == "Bow") outputText("arrow");
                if (player.weaponRangePerk == "Crossbow") outputText("bolt");
                if (player.weaponRangePerk == "Throwing") outputText("projectile");
                if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle" || player.weaponRangePerk == "2H Firearm" || player.weaponRangePerk == "Dual Firearms") outputText("" + ammoWord + "");
				if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) outputText("s");
                outputText(" thunks into Isabella's shield, completely blocked by the wall of steel.\n\n");
            }
            if (SceneLib.isabellaFollowerScene.isabellaAccent())
                outputText("\"<i>You remind me of ze horse-people.  Zey cannot deal vith mein shield either!</i>\" cheers Isabella.\n\n");
            else outputText("\"<i>You remind me of the horse-people.  They cannot deal with my shield either!</i>\" cheers Isabella.\n\n");
            enemyAI();
            return;
        }
        //worms are immune
        if (monster.short == "worms") {
            outputText("The ");
            if (player.weaponRangePerk == "Bow") outputText("arrow");
            if (player.weaponRangePerk == "Crossbow") outputText("bolt");
            if (player.weaponRangePerk == "Throwing") outputText("projectile");
            if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle" || player.weaponRangePerk == "2H Firearm" || player.weaponRangePerk == "Dual Firearms") outputText("" + ammoWord + "");
            if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) outputText("s");
            outputText(" slips between the worms, sticking into the ground.\n\n");
            enemyAI();
            return;
        }
        //Vala miss chance!
        if (monster.short == "Vala" && rand(10) < 7 && !monster.hasStatusEffect(StatusEffects.Stunned)) {
            outputText("Vala flaps her wings and twists her body. Between the sudden gust of wind and her shifting of position, the ");
            if (player.weaponRangePerk == "Bow") outputText("arrow");
            if (player.weaponRangePerk == "Crossbow") outputText("bolt");
            if (player.weaponRangePerk == "Throwing") outputText("projectile");
            if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle" || player.weaponRangePerk == "2H Firearm" || player.weaponRangePerk == "Dual Firearms") outputText("" + ammoWord + "");
            if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) outputText("s");
            outputText(" goes wide.\n\n");
            enemyAI();
            return;
        }
        //Blind miss chance
        if (player.playerIsBlinded()) {
            outputText("The ");
            if (player.weaponRangePerk == "Bow") outputText("arrow");
            if (player.weaponRangePerk == "Crossbow") outputText("bolt");
            if (player.weaponRangePerk == "Throwing") outputText("projectile");
            if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle" || player.weaponRangePerk == "2H Firearm" || player.weaponRangePerk == "Dual Firearms") outputText("" + ammoWord + "");
            if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) outputText("s");
            outputText(" hits something, but blind as you are, you don't have a chance in hell of hitting anything with a " + player.weaponRangeName + ".\n\n");
            enemyAI();
            return;
        }
        if (monster is Lethice && monster.hasStatusEffect(StatusEffects.Shell)) {
            outputText("Your ");
            if (player.weaponRangePerk == "Bow") outputText("arrow");
            if (player.weaponRangePerk == "Crossbow") outputText("bolt");
            if (player.weaponRangePerk == "Throwing") outputText("projectile");
            if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle" || player.weaponRangePerk == "2H Firearm" || player.weaponRangePerk == "Dual Firearms") outputText("" + ammoWord + "");
            outputText(" pings of the side of the shield and spins end over end into the air. Useless.\n\n");
            enemyAI();
            return;
        }
        if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow") {
            if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) outputText("Your bow nudges as you ready the next shot, helping you keep your aimed at [monster name].\n\n");
            multiArrowsStrike();
        }
        if (player.weaponRangePerk == "Throwing"){
            if (player.hasPerk(PerkLib.Telekinesis)) {
                outputText("Weapons begins to float around you as you draw several projectiles from your arsenal using your powers.\n\n");
                TelekinesisThrow();
                outputText(" Adding to the initial attack, you begin grab additional [weaponrange] before taking aim.\n\n");
            }
            throwWeapon();
        }
        if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle" || player.weaponRangePerk == "2H Firearm" || player.weaponRangePerk == "Dual Firearms") shootWeapon();
		if (player.vehicles == vehicles.HB_MECH) multiArrowsStrike();
    }

    public function multiArrowsStrike():void {
        var accRange:Number = 0;
        accRange += (arrowsAccuracy() / 2);
        if (flags[kFLAGS.ARROWS_ACCURACY] > 0) accRange -= flags[kFLAGS.ARROWS_ACCURACY];
        if (player.weaponRangeName == "Guided bow" || player.vehicles == vehicles.HB_MECH) accRange = 100;
        var weaponRangePerk:String = player.weaponRangePerk;
        var ammoWord:String;
        switch (weaponRangePerk) {
            case "Bow":
                ammoWord = "arrow";
                break;
            case "Crossbow" :
                ammoWord = "bolt";
                break;
        }
        if (rand(100) < accRange) {
            var damage:Number = 0;
			if (player.vehicles == vehicles.HB_MECH) {
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
				if (weaponRangePerk == "Bow") {
					damage += player.spe * 2;
					damage += scalingBonusSpeed() * 0.4;
					if (damage < 20) damage = 20;
				}
				if (weaponRangePerk == "Crossbow") damage += player.weaponRangeAttack * 20;
			}
            if (!player.hasPerk(PerkLib.DeadlyAim)) damage *= (monster.damageRangePercent() / 100);
            //Weapon addition!
            if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
            else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
            else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
            else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
            else damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
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
			if (weaponRangePerk == "Bow" && player.hasStatusEffect(StatusEffects.FletchingTable)) {
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
			damage *= (1 + (0.01 * masteryArcheryLevel()));
            if (damage == 0) {
                if (monster.inte > 0) {
                    outputText(monster.capitalA + monster.short + " shrugs as the " + ammoWord + " bounces off them harmlessly.\n\n");
                } else {
                    outputText("The " + ammoWord + " bounces harmlessly off [monster a] [monster name].\n\n");
                }
                flags[kFLAGS.ARROWS_SHOT]++;
            }
            if (monster is EncapsulationPod) {
                outputText("The " + ammoWord + " lodges deep into the pod's fleshy wall");
            } else if (monster.plural) {
                var textChooser1:int = rand(12);
                if (textChooser1 >= 9) {
                    outputText(monster.capitalA + monster.short + " look down at the " + ammoWord + " that now protrudes from one of [monster his] bodies");
                } else if (textChooser1 >= 6 && textChooser1 < 9) {
                    outputText("You pull an " + ammoWord + " and fire it at one of [monster a] [monster name]");
                } else if (textChooser1 >= 3 && textChooser1 < 6) {
                    outputText("With one smooth motion you draw, nock, and fire your deadly " + ammoWord + " at one of your opponents");
                } else {
                    outputText("You casually fire an " + ammoWord + " at one of [monster a] [monster name]");
                }
            } else {
                var textChooser2:int = rand(12);
                if (textChooser2 >= 9) {
                    outputText(monster.capitalA + monster.short + " looks down at the " + ammoWord + " that now protrudes from [monster his] body");
                } else if (textChooser2 >= 6) {
                    outputText("You pull an " + ammoWord + " and fire it at [monster a] [monster name]");
                } else if (textChooser2 >= 3) {
                    outputText("With one smooth motion you draw, nock, and fire your deadly " + ammoWord + " at your opponent");
                } else {
                    outputText("You casually fire an " + ammoWord + " at [monster a] [monster name]");
                }
            }
            if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) damage *= historyScoutBonus();
            if (player.hasPerk(PerkLib.JobRanger)) damage *= 1.05;
            if (player.jewelryEffectId == JewelryLib.MODIFIER_R_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
            if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
                if (player.statusEffectv1(StatusEffects.Kelt) < 100) damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
                else {
                    if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
                        if (player.statusEffectv1(StatusEffects.Kindra) < 150) damage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
                        else damage *= 3.5;
                    } else damage *= 2;
                }
            }
            //Section for item damage modifiers
            if (player.weaponRangeName == "Wild Hunt" && (player.level + playerLevelAdjustment()) > monster.level) damage *= 2;
            if (player.weaponRangeName == "Hodr's bow" && monster.hasStatusEffect(StatusEffects.Blind)) damage *= 1.1;
            if (weaponRangePerk == "Bow"){
                if (player.hasPerk(PerkLib.ElvenRangerArmor)) damage *= 1.5;
                if (player.isElf() && player.hasPerk(PerkLib.ELFArcherCovenant) && player.isSpearTypeWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise())  damage *= 1.25;
            }
            if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
                damage += Math.round(player.inte * 0.1);
                if (player.inte >= 50) damage += Math.round(player.inte * ((player.inte / 50) * 0.05));
				if (player.weaponRangeName == "Artemis") damage *= 1.5;
				damage *= fireDamageBoostedByDao();
            }
            if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
                damage += Math.round(player.inte * 0.1);
                if (player.inte >= 50) damage += Math.round(player.inte * ((player.inte / 50) * 0.05));
				if (player.weaponRangeName == "Artemis") damage *= 1.5;
				damage *= iceDamageBoostedByDao();
            }
            if (flags[kFLAGS.ELEMENTAL_ARROWS] == 3) {
                damage += Math.round(player.inte * 0.1);
                if (player.inte >= 50) damage += Math.round(player.inte * ((player.inte / 50) * 0.05));
				if (player.weaponRangeName == "Artemis") damage *= 1.5;
				damage *= lightningDamageBoostedByDao();
            }
            if (flags[kFLAGS.ELEMENTAL_ARROWS] == 4) {
                damage += Math.round(player.inte * 0.1);
                if (player.inte >= 50) damage += Math.round(player.inte * ((player.inte / 50) * 0.05));
				if (player.weaponRangeName == "Artemis") damage *= 1.5;
				damage *= darknessDamageBoostedByDao();
            }
            if (flags[kFLAGS.ELEMENTAL_ARROWS] == 5) {
                damage += Math.round(player.inte * 0.1);
                if (player.inte >= 50) damage += Math.round(player.inte * ((player.inte / 50) * 0.05));
				if (player.weaponRangeName == "Artemis") damage *= 1.5;
				damage *= waterDamageBoostedByDao();
            }
            if (flags[kFLAGS.ELEMENTAL_ARROWS] == 6) {
                damage += Math.round(player.inte * 0.1);
                if (player.inte >= 50) damage += Math.round(player.inte * ((player.inte / 50) * 0.05));
				if (player.weaponRangeName == "Artemis") damage *= 1.5;
				damage *= windDamageBoostedByDao();
            }
            if (flags[kFLAGS.ELEMENTAL_ARROWS] == 7) {
                damage += Math.round(player.inte * 0.1);
                if (player.inte >= 50) damage += Math.round(player.inte * ((player.inte / 50) * 0.05));
				if (player.weaponRangeName == "Artemis") damage *= 1.5;
				damage *= earthDamageBoostedByDao();
            }
			damage *= rangePhysicalForce();
            //Determine if critical hit!
            var crit:Boolean = false;
            var critChance:int = 5;
            critChance += combatPhysicalCritical();
            if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
            if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
            if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "bow") critChance += 10;
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
            if (rand(100) < critChance) {
                crit = true;
                var buffMultiplier:Number = 0;
                if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "bow") buffMultiplier += 1;
                damage *= 1.75+buffMultiplier;
            }
            damage = Math.round(damage);
            if (monster.HP <= monster.minHP()) {
                if (monster.short == "pod")
                    outputText(". ");
                else if (monster.plural)
                    outputText(" and [monster he] stagger, collapsing onto each other from the wounds you've inflicted on [monster him]. ");
                else outputText(" and [monster he] staggers, collapsing from the wounds you've inflicted on [monster him]. ");
                if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) doFireDamage(damage, true, true);
                else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) doIceDamage(damage, true, true);
                else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 3) doLightingDamage(damage, true, true);
                else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 4) doDarknessDamage(damage, true, true);
                else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 5) doWaterDamage(damage, true, true);
                else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 6) doWindDamage(damage, true, true);
                else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 7) doEarthDamage(damage, true, true);
                else doPhysicalDamage(damage, true, true);
                if (crit) {
					outputText(" <b>*Critical Hit!*</b>");
					archeryXP(1);
				}
				archeryXP(1);
                outputText("\n\n");
				WeaponRangeStatusProcs();
                checkAchievementDamage(damage);
                flags[kFLAGS.ARROWS_SHOT]++;
                doNext(endHpVictory);
                return;
            } else {
                if (rand(100) < 15 && player.weaponRangeName == "Artemis" && !monster.hasStatusEffect(StatusEffects.Blind)) {
                    monster.createStatusEffect(StatusEffects.Blind, 3, 0, 0, 0);
                    outputText(",  your radiant shots blinded [monster he]");
                }
                if (!MSGControll) {
                    outputText(".  It's clearly very painful. ");
                    if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) doFireDamage(damage, true, true);
                    else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) doIceDamage(damage, true, true);
                    else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 3) doLightingDamage(damage, true, true);
                    else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 4) doDarknessDamage(damage, true, true);
					else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 5) doWaterDamage(damage, true, true);
					else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 6) doWindDamage(damage, true, true);
					else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 7) doEarthDamage(damage, true, true);
                    else doPhysicalDamage(damage, true, true);
					if (crit) archeryXP(1);
					archeryXP(1);
                }
                if (crit) outputText(" <b>*Critical Hit!*</b>");
				WeaponRangeStatusProcs();
				WrathGenerationPerHit1(5);
                heroBaneProc(damage);
            }
            if (flags[kFLAGS.CUPID_ARROWS] == 1) {
                outputText("  ");
                if (monster.lustVuln == 0) {
                    if ((MDOCount == maxCurrentRangeAttacks()) && (MSGControll)) outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.");
                } else {
                    var lustArrowDmg:Number = monster.lustVuln * (player.inte / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
                    if (monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects [monster him].  ");
                    if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
                        if (monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
                        else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
                    }
                    if (monster.lust >= (monster.maxLust() * 0.6)) {
                        outputText(monster.capitalA + monster.short + "'");
                        if (!monster.plural) outputText("s");
                        outputText(" eyes glaze over with desire for a moment.  ");
                    }
                    lustArrowDmg *= 0.25;
                    lustArrowDmg = Math.round(lustArrowDmg);
                    monster.lust += lustArrowDmg;
                    outputText("<b>(<font color=\"#ff00ff\">" + lustArrowDmg + "</font>)</b>");
                    if (monster.lust >= monster.maxLust()) doNext(endLustVictory);
                }
            }
            if (flags[kFLAGS.ENVENOMED_BOLTS] == 1 && player.tailVenom >= player.VenomWebCost()) {
                outputText("  ");
                if (monster.lustVuln == 0) {
                    outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
                }
                if (player.tailType == Tail.BEE_ABDOMEN) {
                    outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
                    var damage1B:Number = 35 + rand(player.lib / 10);
					var damage1Ba:Number = 1;
                    if (player.level < 10) damage1B += 20 + (player.level * 3);
                    else if (player.level < 20) damage1B += 50 + (player.level - 10) * 2;
                    else if (player.level < 30) damage1B += 70 + (player.level - 20) * 1;
                    else damage1B += 80;
                    damage1B *= 0.2;
					if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
						damage1B *= 2;
						damage1Ba *= 2;
					}
                    monster.teased(damage1B);
                    if (monster.hasStatusEffect(StatusEffects.BeeVenom)) {
                        monster.addStatusValue(StatusEffects.BeeVenom, 3, damage1Ba);
                    } else monster.createStatusEffect(StatusEffects.BeeVenom, 0, 0, damage1Ba, 0);
                    player.tailVenom -= player.VenomWebCost();
					flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                }
                if (player.tailType == Tail.SCORPION) {
                    outputText("  [monster he] seems to be effected by the poison, its movements slowing rapidly.");
					var DBP:Number = 2;
					var DBPa:Number = 1;
					if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
						DBP *= 2;
						DBPa *= 2;
					}
                    monster.statStore.addBuffObject({tou:-DBP, spe:-DBP}, "Poison",{text:"Poison"});
                    if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                        monster.addStatusValue(StatusEffects.NagaVenom, 3, DBPa);
                    } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, DBPa, 0);
                    player.tailVenom -= player.VenomWebCost();
					flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                }
                if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
                    outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
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
                    monster.teased(lustdamage, false);
                    monster.statStore.addBuffObject({tou:-(DBPaa*2)}, "Poison",{text:"Poison"});
                    if (monster.hasStatusEffect(StatusEffects.ManticoreVenom)) {
                        monster.addStatusValue(StatusEffects.ManticoreVenom, 3, DBPaa);
                    } else monster.createStatusEffect(StatusEffects.ManticoreVenom, 0, 0, DBPaa, 0);
                    player.tailVenom -= player.VenomWebCost();
					flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                }
                if (player.faceType == Face.SNAKE_FANGS) {
                    outputText("  [monster he] seems to be effected by the poison, its movements slowing down.");
					var DBPaaa:Number = 1;
					if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) DBPaaa *= 2;
                    monster.statStore.addBuffObject({spe:-DBPaaa}, "Poison",{text:"Poison"});
                    var venomType:StatusEffectType = StatusEffects.NagaVenom;
                    if (player.nagaScore() >= 23) venomType = StatusEffects.ApophisVenom;
                    if (monster.hasStatusEffect(venomType)) {
                        monster.addStatusValue(venomType, 2, 0.4);
                        monster.addStatusValue(venomType, 1, (DBPaaa * 0.4));
                    } else monster.createStatusEffect(venomType, (DBPaaa * 0.4), 0.4, 0, 0);
                    player.tailVenom -= player.VenomWebCost();
					flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                }
                if (player.faceType == Face.SPIDER_FANGS) {
                    if (player.lowerBody == LowerBody.ATLACH_NACHA){
                        outputText("  [monster he] seems to be affected by the poison, showing increasing sign of weakness and arousal.");
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
                        monster.teased(damage2B);
                        monster.statStore.addBuffObject({tou:-poisonScaling}, "Poison",{text:"Poison"});
                        if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                            monster.addStatusValue(StatusEffects.NagaVenom, 3, damage2Ba);
                        } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, damage2Ba, 0);
                        player.tailVenom -= player.VenomWebCost();
						flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                    }
                    else{
                        outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
                        var lustDmg:int = 6 * monster.lustVuln;
						if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) lustDmg *= 2;
                        monster.teased(lustDmg);
                        if (monster.lustVuln > 0) {
                            monster.lustVuln += 0.01;
                            if (monster.lustVuln > 1) monster.lustVuln = 1;
                        }
                        player.tailVenom -= player.VenomWebCost();
						flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                    }
                }
                if (monster.lust >= monster.maxLust()) {
                    outputText("\n\n");
                    checkAchievementDamage(damage);
                    flags[kFLAGS.ARROWS_SHOT]++;
                    doNext(endLustVictory);
                }
                outputText("\n");
            }
            if (flags[kFLAGS.ENVENOMED_BOLTS] == 1 && player.tailVenom < player.VenomWebCost()) outputText("  You do not have enough venom to apply on the " + ammoWord + " tip!\n");
            if (player.weaponRangeName == "Hodr's bow" && !monster.hasStatusEffect(StatusEffects.Blind)) monster.createStatusEffect(StatusEffects.Blind, 1, 0, 0, 0);
            outputText("\n");
            if (flags[kFLAGS.ARROWS_SHOT] >= 1) EngineCore.awardAchievement("Arrow to the Knee", kACHIEVEMENTS.COMBAT_ARROW_TO_THE_KNEE);
            flags[kFLAGS.ARROWS_SHOT]++;
			WrathWeaponsProc();
        } else {
            if (monster is DisplacerBeast) outputText("\n\nThe displacer beast teleports, dodging your attack.\n");
            else {
                outputText("The " + ammoWord + " goes wide, disappearing behind your foe");
                if (monster.plural) outputText("s");
                outputText(".\n\n");
            }
        }
        if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 1) {
            if (monster is Lethice && (monster as Lethice).fightPhase == 3) {
                outputText("\n\n<i>\"Ouch. Such a cowardly weapon,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your pathetic " + ammoWord + "s?\"</i>\n\n");
                monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
            }
            enemyAI();
        }
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxLust()) {
            doNext(endLustVictory);
            return;
        }
        if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) {
            flags[kFLAGS.MULTIPLE_ARROWS_STYLE]--;
            flags[kFLAGS.ARROWS_ACCURACY] += arrowsAccuracyPenalty();
            multiArrowsStrike();
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

    public function throwElementalAttack():void {
        var damage:Number = 0;
		damage += player.str;
		var crit:Boolean = false;
		var critChance:int = 5;
		var critDmg:Number = 1.75;
		critChance += combatPhysicalCritical();
		if (player.weapon == weapons.MGSWORD) {
			damage += scalingBonusIntelligence() * 0.2;
			if (player.isFlying()){
				if (player.hasPerk(MutationsLib.HarpyHollowBones)) damage *= 1.2;
				if (player.hasPerk(MutationsLib.HarpyHollowBonesPrimitive)) damage *= 1.3;
				if (player.hasPerk(MutationsLib.HarpyHollowBonesEvolved)) damage *= 1.5;
			}
			if (player.hasPerk(PerkLib.HoldWithBothHands) && !player.isFistOrFistWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) damage *= 1.2;
			if (damage < 10) damage = 10;
			//Weapon addition!
			if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.03));
			else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (2.5 + ((player.weaponAttack - 50) * 0.025));
			else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (3.75 + ((player.weaponAttack - 100) * 0.02));
			else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (4.75 + ((player.weaponAttack - 150) * 0.015));
			else damage *= (5.5 + ((player.weaponAttack - 200) * 0.01));
			//Bonus sand trap / alraune damage!
			if (monster.hasStatusEffect(StatusEffects.Level) && (monster is SandTrap || monster is Alraune)) damage = Math.round(damage * 1.75);
			//All special weapon effects like...fire/ice
			if (player.hasStatusEffect(StatusEffects.FlameBlade)) {
				var damage2:Number = damage;
				if (monster.hasPerk(PerkLib.IceNature)) damage2 += (damage2 * 0.5);
				if (monster.hasPerk(PerkLib.FireVulnerability)) damage2 += (damage2 * 0.2);
				if (monster.hasPerk(PerkLib.IceVulnerability)) damage2 += (damage2 * 0.05);
				if (monster.hasPerk(PerkLib.FireNature)) damage2 += (damage2 * 0.02);
				if (player.hasPerk(PerkLib.FireAffinity)) damage2 *= 2;
				damage += scalingBonusLibido() * 0.20;
				damage += damage2;
			}
			damage *= (1 + (0.01 * masterySwordLevel()));
			//Thunderous Strikes
			if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
			if (player.hasPerk(PerkLib.ChiReflowMagic)) damage *= UmasShop.NEEDLEWORK_MAGIC_REGULAR_MULTI;
			if (player.hasPerk(PerkLib.ChiReflowAttack)) damage *= UmasShop.NEEDLEWORK_ATTACK_REGULAR_MULTI;
			if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
			if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
			if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
			if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
			if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= historyFighterBonus();
			if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
			if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
			if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
			if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
			if (player.armor == armors.SPKIMO) damage *= 1.2;
			if (player.hasPerk(PerkLib.OniTyrantKimono || PerkLib.OniEnlightenedKimono)) damage *= 1.4;
			if (player.necklace == necklaces.OBNECK) damage *= 1.2;
			if (player.hasPerk(PerkLib.GoblinoidBlood)) {
				if (player.hasKeyItem("Power bracer") >= 0) damage *= 1.1;
				if (player.hasKeyItem("Powboy") >= 0) damage *= 1.15;
				if (player.hasKeyItem("M.G.S. bracer") >= 0) damage *= 1.2;
			}
			if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
			if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
			damage *= meleePhysicalForce();
			//Determine if critical hit!
            critChance += 10;
            if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponSpecials("Large") && player.str >= 100) critChance += 10;
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
            if (rand(100) < critChance) {
                crit = true;
				critDmg += bonusCriticalDamageFromMissingHP();
                damage *= critDmg;
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
			if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) damage *= historyScoutBonus();
			if (player.hasPerk(PerkLib.JobRanger)) damage *= 1.05;
			if (player.hasPerk(PerkLib.Ghostslinger)) damage *= 1.15;
			if (player.jewelryEffectId == JewelryLib.MODIFIER_R_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
			if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
			if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
				if (player.statusEffectv1(StatusEffects.Kelt) < 100) damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
				else {
					if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
						if (player.statusEffectv1(StatusEffects.Kindra) < 150) damage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
						else damage *= 3.5;
					} else damage *= 2;
				}
			}
		}
        damage = Math.round(damage);
        checkAchievementDamage(damage);
		var elementalVariant:Number = player.perkv1(PerkLib.ElementalBody);
		if (player.weapon == weapons.MGSWORD) elementalVariant = 5;
        switch (elementalVariant) {
            case 1:
                outputText("You form and unleash a wind blade. ");
				doWindDamage(damage, true, true);
                break;
            case 2:
                outputText("You launch a huge rock. ");
				doEarthDamage(damage, true, true);
                break;
            case 3:
                outputText("You charge and toss a fireball. ");
				doFireDamage(damage, true, true);
                break;
            case 4:
                outputText("You unleash an arrow of lethally pressurized water. ");
				doWaterDamage(damage, true, true);
                break;
            case 5:
                outputText("You form and unleash a wave of moonlight. ");
				doMagicDamage(damage, true, true);
                break;
            default:
                outputText("You form and unleash a wind blade. ");
				doWindDamage(damage, true, true);
                break;
        }
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.weapon == weapons.MGSWORD) swordXP(1);
			else throwingXP(1);
		}
		if (player.weapon == weapons.MGSWORD) swordXP(1);
		else throwingXP(1);
		WrathGenerationPerHit1(5);
        heroBaneProc(damage);
        if (monster.HP <= monster.minHP()) {
            if (monster.plural) outputText(" [monster He] stagger, collapsing onto each other from the wounds you've inflicted on [monster him].");
            else outputText(" [monster He] staggers, collapsing from the wounds you've inflicted on [monster him].");
            outputText("\n\n");
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxLust()) {
            doNext(endLustVictory);
            return;
        }
		outputText(" It's clearly very painful.\n\n");
        wrathregeneration1();
        fatigueRecovery1();
        manaregeneration1();
        soulforceregeneration1();
		venomCombatRecharge1();
        enemyAI();
    }

    public function TelekinesisThrow():void {
        var fc:Number = oneThrowTotalCost();
        var accRange:Number = 0;
        var numberOfExtraShots:Number = Math.round(player.level / 15);
        if (numberOfExtraShots < 2) numberOfExtraShots = 2;
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
        outputText("You use your spiritual powers to launch a rain of floating [weaponrange] at [monster a] [monster name].");
        while (currentShot < numberOfExtraShots) {
            if (rand(100) < accRange) {
                var damage:Number = 0;
                damage += player.str;
                damage += ghostStrength();
                damage += scalingBonusStrength() * 0.4;
                if (player.hasPerk(PerkLib.Telekinesis)) {
                    damage += player.inte;
                    damage += scalingBonusIntelligence() * 0.4;
                }
                if (damage < 20) damage = 20;
                if (player.hasPerk(PerkLib.DeadlyThrow)) damage += player.spe;
				damage *= 1.5;
                //Weapon addition!
                if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
                else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
                else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
                else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
                else damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
                if (player.weaponRange == weaponsrange.KSLHARP) {
                    if (monster.cor < 33) damage = Math.round(damage * 1.0);
                    else if (monster.cor < 50) damage = Math.round(damage * 1.1);
                    else if (monster.cor < 75) damage = Math.round(damage * 1.2);
                    else if (monster.cor < 90) damage = Math.round(damage * 1.3);
                    else damage = Math.round(damage * 1.4);
                }
                if (player.weaponRange == weaponsrange.LEVHARP) {
                    if (monster.cor >= 66) damage = Math.round(damage * 1.0);
                    else if (monster.cor >= 50) damage = Math.round(damage * 1.1);
                    else if (monster.cor >= 25) damage = Math.round(damage * 1.2);
                    else if (monster.cor >= 10) damage = Math.round(damage * 1.3);
                    else damage = Math.round(damage * 1.4);
                }
				if (player.miscJewelry == miscjewelries.ATLATL_ || player.miscJewelry2 == miscjewelries.ATLATL_) damage *= 1.25;
                damage *= (1 + (0.01 * masteryThrowingLevel()));
                if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) damage *= historyScoutBonus();
                if (player.hasPerk(PerkLib.JobRanger)) damage *= 1.05;
                if (player.hasPerk(PerkLib.Ghostslinger)) damage *= 1.15;
                if (player.hasPerk(PerkLib.PhantomShooting)) damage *= 1.05;
                if (player.jewelryEffectId == JewelryLib.MODIFIER_R_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
                if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
                if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
				if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
                if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
                    if (player.statusEffectv1(StatusEffects.Kelt) < 100) damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
                    else {
                        if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
                            if (player.statusEffectv1(StatusEffects.Kindra) < 150) damage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
                            else damage *= 3.5;
                        } else damage *= 2;
                    }
                }
                //Determine if critical hit!
                var crit:Boolean = false;
                var critChance:int = 5;
                critChance += combatPhysicalCritical();
                if (player.weaponRangeName == "gnoll throwing axes") critChance += 10;
                if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
                if (player.hasPerk(PerkLib.AnatomyExpert)) critChance += 10;
                if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
                if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
                if (rand(100) < critChance) {
                    crit = true;
                    if (player.hasPerk(PerkLib.AnatomyExpert)) damage *= 2.25;
                    else damage *= 1.75;
                }
				damage *= rangePhysicalForce();
                damage = Math.round(damage);
                checkAchievementDamage(damage);
                if (monster.HP <= monster.minHP()) {
                    if (monster.short == "pod")
                        outputText(". ");
                    else if (monster.plural)
                        outputText(" Your opponents staggers, collapsing onto each other from the wounds you've inflicted on [monster him]. ");
                    else outputText(" Your opponent staggers, collapsing from the wounds you've inflicted on [monster him]. ");
                    doPhysicalDamage(damage, true, true);
                    if (crit) {
                        outputText(" <b>*One or more of the projectile did a Critical Hit!*</b>");
                        throwingXP(1);
                    }
                    throwingXP(1);
                    outputText("\n\n");
					WeaponRangeStatusProcs();
                    doNext(endHpVictory);
                    return;
                } else {
                    if (!MSGControll) {
                        outputText(" ");
                        doPhysicalDamage(damage, true, true);
                        if (crit) throwingXP(1);
                        throwingXP(1);
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
            enemyAI();
        }
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxLust()) {
            doNext(endLustVictory);
        }
    }

    public function throwWeapon():void {
        var fc:Number = oneThrowTotalCost();
        var accRange:Number = 0;
        accRange += (throwingAccuracy() / 2);
        if (flags[kFLAGS.ARROWS_ACCURACY] > 0) accRange -= flags[kFLAGS.ARROWS_ACCURACY];
        if (player.hasPerk(PerkLib.PhantomShooting)) {
            if (player.weaponRange != weaponsrange.SHUNHAR && player.weaponRange != weaponsrange.KSLHARP && player.weaponRange != weaponsrange.LEVHARP) player.takePhysDamage(fc);
        }
        else {
            if (player.weaponRange != weaponsrange.SHUNHAR && player.weaponRange != weaponsrange.KSLHARP && player.weaponRange != weaponsrange.LEVHARP) player.ammo--;
        }
        if (rand(100) < accRange) {
            var damage:Number = 0;
            damage += player.str;
            damage += ghostStrength();
            damage += scalingBonusStrength() * 0.4;
            if (player.hasPerk(PerkLib.Telekinesis)){
                damage += player.inte;
                damage += scalingBonusIntelligence() * 0.4;
            }
            if (damage < 20) damage = 20;
            if (player.hasPerk(PerkLib.DeadlyThrow)) damage += player.spe;
			damage *= 1.5;
            //Weapon addition!
            if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
            else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
            else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
            else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
            else damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
            if (player.weaponRange == weaponsrange.KSLHARP) {
                if (monster.cor < 33) damage = Math.round(damage * 1.0);
                else if (monster.cor < 50) damage = Math.round(damage * 1.1);
                else if (monster.cor < 75) damage = Math.round(damage * 1.2);
                else if (monster.cor < 90) damage = Math.round(damage * 1.3);
                else damage = Math.round(damage * 1.4);
            }
            if (player.weaponRange == weaponsrange.LEVHARP) {
                if (monster.cor >= 66) damage = Math.round(damage * 1.0);
                else if (monster.cor >= 50) damage = Math.round(damage * 1.1);
                else if (monster.cor >= 25) damage = Math.round(damage * 1.2);
                else if (monster.cor >= 10) damage = Math.round(damage * 1.3);
                else damage = Math.round(damage * 1.4);
            }
			if (player.miscJewelry == miscjewelries.ATLATL_ || player.miscJewelry2 == miscjewelries.ATLATL_) damage *= 1.25;
			damage *= (1 + (0.01 * masteryThrowingLevel()));
            if ((MDOCount == maxCurrentRangeAttacks()) && (MSGControllForEvasion) && (!MSGControll)) {
                //if (damage == 0) {
                if (monster.inte > 0) {
                    outputText(monster.capitalA + monster.short + " shrugs as the [weaponrange] bounces off them harmlessly.\n\n");
                } else {
                    outputText("The [weaponrange] bounces harmlessly off [monster a] [monster name].\n\n");
                }
            }
            if (monster is EncapsulationPod) {
                outputText("The [weaponrange] lodges deep into the pod's fleshy wall");
            } else if (monster.plural) {
                var textChooser1:int = rand(12);
                if (textChooser1 >= 9) {
                    outputText(monster.capitalA + monster.short + " look down at the mark left by the [weaponrange] on one of their bodies");
                } else if (textChooser1 >= 6 && textChooser1 < 9) {
                    outputText("You firmly grasp [weaponrange] and then throw it at one of [monster a] [monster name]");
                } else if (textChooser1 >= 3 && textChooser1 < 6) {
                    outputText("With one smooth motion you aim and throw your [weaponrange] at one of your opponents");
                } else {
                    outputText("You casually throw [weaponrange] at one of [monster a] [monster name]");
                }
            } else {
                var textChooser2:int = rand(12);
                if (textChooser2 >= 9) {
                    outputText(monster.capitalA + monster.short + " looks down at the mark left by the [weaponrange] on it body");
                } else if (textChooser2 >= 6) {
                    outputText("You grasp firmly [weaponrange] and then throw it at [monster a] [monster name]");
                } else if (textChooser2 >= 3) {
                    outputText("With one smooth motion you aim and throw your [weaponrange] at your opponent");
                } else {
                    outputText("You casually throws [weaponrange] at [monster a] [monster name]");
                }
            }
			if (player.hasPerk(PerkLib.PrestigeJobStalker)) damage *= 1.2;
            if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) damage *= historyScoutBonus();
            if (player.hasPerk(PerkLib.JobRanger)) damage *= 1.05;
            if (player.hasPerk(PerkLib.Ghostslinger)) damage *= 1.15;
            if (player.hasPerk(PerkLib.PhantomShooting)) damage *= 1.05;
            if (player.jewelryEffectId == JewelryLib.MODIFIER_R_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
            if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
            if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
            if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
                if (player.statusEffectv1(StatusEffects.Kelt) < 100) damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
                else {
                    if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
                        if (player.statusEffectv1(StatusEffects.Kindra) < 150) damage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
                        else damage *= 3.5;
                    } else damage *= 2;
                }
            }
            /*		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 2;
		}zachowane jeśli potem dodam elemental dmg do ataków innych broni dystansowych też
*/			damage *= rangePhysicalForce();
            //Determine if critical hit!
            var crit:Boolean = false;
            var critChance:int = 5;
            var critDmg:Number = 1.75;
            critChance += combatPhysicalCritical();
            if (player.weaponRangeName == "gnoll throwing axes") critChance += 10;
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
            damage = Math.round(damage);
			WeaponRangeStatusProcs();
            checkAchievementDamage(damage);
            if (monster.HP <= monster.minHP()) {
                if (monster.short == "pod")
                    outputText(". ");
                else if (monster.plural)
                    outputText(" and [monster he] stagger, collapsing onto each other from the wounds you've inflicted on [monster him]. ");
                else outputText(" and [monster he] staggers, collapsing from the wounds you've inflicted on [monster him]. ");
                doPhysicalDamage(damage, true, true);
                if (crit) {
					outputText(" <b>*Critical Hit!*</b>");
					throwingXP(1);
				}
				throwingXP(1);
                outputText("\n\n");
                doNext(endHpVictory);
                return;
            } else {
                if (!MSGControll) {
                    outputText(".  It's clearly very painful. ");
                    doPhysicalDamage(damage, true, true);
					if (crit) throwingXP(1);
					throwingXP(1);
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
            enemyAI();
        }
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxLust()) {
            doNext(endLustVictory);
        } else if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] > 1) {
            flags[kFLAGS.MULTIPLE_ARROWS_STYLE] -= 1;
            flags[kFLAGS.ARROWS_ACCURACY] += 15;
            throwWeapon();
        }
    }

    public function shootWeapon():void {
        var accRange:Number = 0;
        accRange += (firearmsAccuracy() / 2);
        if (flags[kFLAGS.ARROWS_ACCURACY] > 0) accRange -= flags[kFLAGS.ARROWS_ACCURACY];
		if (!player.hasPerk(PerkLib.PrimedClipWarp) || (player.hasPerk(PerkLib.PrimedClipWarp) && rand(4) > 0)) {
			if (player.hasPerk(PerkLib.PhantomShooting)) {
				if (player.weaponRange == weaponsrange.M1CERBE) player.takePhysDamage(150);
				else player.takePhysDamage(25);
			}
			else player.ammo--;
		}
        var weaponRangeName:String = player.weaponRangeName;
        var ammoWord:String;
        switch (weaponRangeName) {
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
        if (rand(100) < accRange) {
            var damage:Number = 0;
            damage += player.weaponRangeAttack * 2;
            if (player.hasPerk(PerkLib.JobGunslinger)) damage += player.weaponRangeAttack * 2;
            if (player.hasPerk(PerkLib.ChurchOfTheGun)) damage += scalingBonusWisdom() * 0.5;
            if (player.hasPerk(PerkLib.AlchemicalCartridge)) damage += scalingBonusIntelligence() * 0.25;
            if (!player.hasPerk(PerkLib.DeadlyAim)) damage *= (monster.damageRangePercent() / 100);
            //Weapon addition!
            if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
            else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
            else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
            else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
            else if (player.weaponRangeAttack >= 201 && player.weaponRangeAttack < 251) damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
            else damage *= (6 + ((player.weaponRangeAttack - 250) * 0.005));
			if (player.weaponRangePerk == "Dual Firearms") damage *= firearmsDualWieldDamagePenalty();
            //any aoe effect from firearms
            if (monster.plural) {
                if (player.weaponRange == weaponsrange.ADBSCAT || player.weaponRange == weaponsrange.DBDRAGG) damage *= 2;
                if (player.weaponRange == weaponsrange.TRFATBI || player.weaponRange == weaponsrange.DERPLAU) damage *= 5;
            }
            if (player.hasPerk(PerkLib.ExplosiveCartridge) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType) || monster.hasPerk(PerkLib.EnemyHugeType) || monster.hasPerk(PerkLib.Enemy300Type) || monster.hasPerk(PerkLib.EnemyGigantType) || monster.hasPerk(PerkLib.EnemyColossalType))) damage *= 2;
            if (player.hasPerk(PerkLib.NamedBullet) && monster.hasPerk(PerkLib.EnemyBossType)) damage *= 1.5;
            //other effects
            if (player.weaponRange == weaponsrange.M1CERBE) damage *= 6;
            if (player.weaponRange == weaponsrange.HARPGUN && player.hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) damage *= 1.2;
            if (player.armor == armors.GTECHC_ && !player.isInGoblinMech()) damage *= 1.2;
            if (player.hasKeyItem("Gun Scope") >= 0) damage *= 1.2;
            if (player.hasKeyItem("Gun Scope with Aim tech") >= 0) damage *= 1.4;
            if (player.hasKeyItem("Gun Scope with Aimbot") >= 0) damage *= 1.6;
            if (player.isInGoblinMech()) {
                if (player.armor == armors.GTECHC_) damage *= 1.5;
                if (player.upperGarment == undergarments.TECHBRA) damage *= 1.05;
                if (player.lowerGarment == undergarments.T_PANTY) damage *= 1.05;
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
			damage *= (1 + (0.01 * masteryFirearmsLevel()));
			if (player.weaponRangePerk == "Dual Firearms") damage *= (1 + (0.01 * dualWFLevel()));
            if ((MDOCount == maxCurrentRangeAttacks()) && (MSGControllForEvasion) && (!MSGControll)) {
                //if ((damage == 0) ){
                if (monster.inte > 0) {
                    outputText(monster.capitalA + monster.short + " shrugs as the " + ammoWord + " bounces off them harmlessly.\n\n");
                } else {
                    outputText("The " + ammoWord + " bounces harmlessly off [monster a] [monster name].\n\n");
                }
            }
            if (monster is EncapsulationPod) {
                outputText("The " + ammoWord + " lodges deep into the pod's fleshy wall");
                if (player.isInGoblinMech()) {
                    if (player.hasKeyItem("Repeater Gun") >= 0) outputText("You shoot the pod with your mech’s repeater gun for ");
                    if (player.hasKeyItem("Machine Gun MK1") >= 0 || player.hasKeyItem("Machine Gun MK2") >= 0 || player.hasKeyItem("Machine Gun MK3") >= 0) outputText("You fire metal rounds at pod using the mech’s machine gun for ");
                }
            } else if (monster.plural) {
                if (player.isInGoblinMech()) {
                    if (player.hasKeyItem("Repeater Gun") >= 0) outputText("You shoot your opponent with your mech’s repeater gun for ");
                    if (player.hasKeyItem("Machine Gun MK1") >= 0 || player.hasKeyItem("Machine Gun MK2") >= 0 || player.hasKeyItem("Machine Gun MK3") >= 0) outputText("You fire metal rounds at [monster a] [monster name] with your mech’s machine gun for ");
                } else {
                    var textChooser1:int = rand(12);
                    if (textChooser1 >= 9) {
                        outputText(monster.capitalA + monster.short + " look down at the mark left by the " + ammoWord + " on one of their bodies");
                    } else if (textChooser1 >= 6 && textChooser1 < 9) {
                        outputText("You pull the trigger and fire the " + ammoWord + " at one of [monster a] [monster name]");
                    } else if (textChooser1 >= 3 && textChooser1 < 6) {
                        outputText("With one smooth motion you aim and fire your deadly " + ammoWord + " at one of your opponents");
                    } else {
                        outputText("You casually fire an " + ammoWord + " at one of [monster a] [monster name] with supreme skill");
                    }
                }
            } else {
                if (player.isInGoblinMech()) {
                    if (player.hasKeyItem("Repeater Gun") >= 0) outputText("You shoot your opponent using the mech repeater gun for ");
                    if (player.hasKeyItem("Machine Gun MK1") >= 0 || player.hasKeyItem("Machine Gun MK2") >= 0 || player.hasKeyItem("Machine Gun MK3") >= 0) outputText("You fire metal rounds at [monster a] [monster name] using the mech machine gun for ");
                } else {
                    var textChooser2:int = rand(12);
                    if (textChooser2 >= 9) outputText(monster.capitalA + monster.short + " looks down at the mark left by the " + ammoWord + " on it body");
                    else if (textChooser2 >= 6) outputText("You pull the trigger and fire the " + ammoWord + " at [monster a] [monster name]");
                    else if (textChooser2 >= 3) outputText("With one smooth motion you aim and fire your deadly " + ammoWord + " at your opponent");
                    else outputText("You casually fire an " + ammoWord + " at [monster a] [monster name] with supreme skill");
                }
            }
            if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) damage *= historyScoutBonus();
            if (player.hasPerk(PerkLib.JobRanger)) damage *= 1.05;
            if (player.hasPerk(PerkLib.Ghostslinger)) damage *= 1.15;
            if (player.hasPerk(PerkLib.PhantomShooting)) damage *= 1.05;
			if (player.hasPerk(PerkLib.SilverForMonsters) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1.2;
            if (player.jewelryEffectId == JewelryLib.MODIFIER_R_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
            if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
                if (player.statusEffectv1(StatusEffects.Kelt) < 100) damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
                else {
                    if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
                        if (player.statusEffectv1(StatusEffects.Kindra) < 150) damage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
                        else damage *= 3.5;
                    } else damage *= 2;
                }
            }
            /*		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 2;
		}zachowane jeśli potem dodam elemental dmg do ataków innych broni dystansowych też*/
            //Determine if critical hit!
            var crit:Boolean = false;
            var critChance:int = 5;
            critChance += combatPhysicalCritical();
            if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
            if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
            if ((monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) || player.weaponRange == weaponsrange.TRFATBI) critChance = 0;
            if (rand(100) < critChance) {
                crit = true;
                if (player.hasPerk(PerkLib.SilverForMonsters) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 2.25;
				else damage *= 1.75;
            }
			damage *= rangePhysicalForce();
			damage = Math.round(damage);
            checkAchievementDamage(damage);
			WeaponRangeStatusProcs();
			WrathGenerationPerHit1(5);
            if (monster.HP <= monster.minHP()) {
                if (monster.short == "pod")
                    outputText(". ");
                else if (monster.plural)
                    outputText(" and [monster he] stagger, collapsing onto each other from the wounds you've inflicted on [monster him]. ");
                else outputText(" and [monster he] staggers, collapsing from the wounds you've inflicted on [monster him]. ");
                doPhysicalDamage(damage, true, true);
                if (crit) {
					outputText(" <b>*Critical Hit!*</b>");
					firearmsXP(1);
				}
				firearmsXP(1);
				if (player.weaponRangePerk == "Dual Firearms") {
					if (crit) dualWieldFirearmsXP(1);
					dualWieldFirearmsXP(1);
				}
                outputText("\n\n");
                doNext(endHpVictory);
                return;
            } else {
                if (player.isInGoblinMech() && (player.hasKeyItem("Repeater Gun") >= 0 || player.hasKeyItem("Machine Gun MK1") >= 0 || player.hasKeyItem("Machine Gun MK2") >= 0 || player.hasKeyItem("Machine Gun MK3") >= 0)) {
                    outputText(".  It's clearly very painful. ");
                    doPhysicalDamage(damage, true, true);
					if (crit) firearmsXP(1);
					firearmsXP(1);
					if (player.weaponRangePerk == "Dual Firearms") {
						if (crit) dualWieldFirearmsXP(1);
						dualWieldFirearmsXP(1);
					}
					if (player.weaponRange == weaponsrange.M1CERBE) {
						if (player.hasPerk(PerkLib.AmateurGunslinger)) doPhysicalDamage(damage, true, true);
						if (player.hasPerk(PerkLib.ExpertGunslinger)) doPhysicalDamage(damage, true, true);
						if (player.hasPerk(PerkLib.MasterGunslinger)) doPhysicalDamage(damage, true, true);
						if (player.hasPerk(PerkLib.LockAndLoad)) doPhysicalDamage(damage, true, true);
						if (player.hasPerk(PerkLib.MasterGunslinger) && player.hasPerk(PerkLib.LockAndLoad)) doPhysicalDamage(damage, true, true);
					}
                } else {
                    if (!MSGControll) {
                        outputText(".  It's clearly very painful. ");
                        if (player.weaponRange == weaponsrange.HARKON1) doTrueDamage(damage, true, true);
						else {
                            doPhysicalDamage(damage, true, true);
							if (player.weaponRange == weaponsrange.M1CERBE) {
								if (player.hasPerk(PerkLib.AmateurGunslinger)) doPhysicalDamage(damage, true, true);
								if (player.hasPerk(PerkLib.ExpertGunslinger)) doPhysicalDamage(damage, true, true);
								if (player.hasPerk(PerkLib.MasterGunslinger)) doPhysicalDamage(damage, true, true);
								if (player.hasPerk(PerkLib.LockAndLoad)) doPhysicalDamage(damage, true, true);
								if (player.hasPerk(PerkLib.MasterGunslinger) && player.hasPerk(PerkLib.LockAndLoad)) doPhysicalDamage(damage, true, true);
							}
						}
						if (crit) firearmsXP(1);
						firearmsXP(1);
						if (player.weaponRangePerk == "Dual Firearms") {
							if (crit) dualWieldFirearmsXP(1);
							dualWieldFirearmsXP(1);
						}
                    }
                    if (crit) outputText(" <b>*Critical Hit!*</b>");
                    //	if (flaga dla efektu arouse arrow) outputText(" tekst dla arouse arrow effect.");
                    //	if (flaga dla efektu poison arrow) outputText(" tekst dla poison arrow effect.");
					if (player.weaponRange == weaponsrange.TOUHOM3) {
						outputText(" ");
                        doPhysicalDamage(damage, true, true);
						if (crit) outputText(" <b>*Critical Hit!*</b>");
						if (player.hasPerk(PerkLib.AmateurGunslinger)) {
							outputText(" ");
                            doPhysicalDamage(damage, true, true);
							if (crit) outputText(" <b>*Critical Hit!*</b>");
							outputText(" ");
                            doPhysicalDamage(damage, true, true);
							if (crit) outputText(" <b>*Critical Hit!*</b>");
						}
						if (player.hasPerk(PerkLib.ExpertGunslinger)) {
							outputText(" ");
                            doPhysicalDamage(damage, true, true);
							if (crit) outputText(" <b>*Critical Hit!*</b>");
							outputText(" ");
                            doPhysicalDamage(damage, true, true);
							if (crit) outputText(" <b>*Critical Hit!*</b>");
						}
						if (player.hasPerk(PerkLib.MasterGunslinger)) {
							outputText(" ");
                            doPhysicalDamage(damage, true, true);
							if (crit) outputText(" <b>*Critical Hit!*</b>");
							outputText(" ");
                            doPhysicalDamage(damage, true, true);
							if (crit) outputText(" <b>*Critical Hit!*</b>");
						}
						if (player.hasPerk(PerkLib.LockAndLoad)) {
							outputText(" ");
                            doPhysicalDamage(damage, true, true);
							if (crit) outputText(" <b>*Critical Hit!*</b>");
							outputText(" ");
                            doPhysicalDamage(damage, true, true);
							if (crit) outputText(" <b>*Critical Hit!*</b>");
						}
						if (player.hasPerk(PerkLib.MasterGunslinger) && player.hasPerk(PerkLib.LockAndLoad)) {
							outputText(" ");
                            doPhysicalDamage(damage, true, true);
							if (crit) outputText(" <b>*Critical Hit!*</b>");
							outputText(" ");
                            doPhysicalDamage(damage, true, true);
							if (crit) outputText(" <b>*Critical Hit!*</b>");
						}
					}
                }
                //Lust raising weapon bonuses
                if (monster.lustVuln > 0) {
                    var rangeweaponLustDmg:Number = 0;
                    if (player.weaponRange == weaponsrange.TDPISTO || player.weaponRange == weaponsrange.DPISTOL || player.weaponRange == weaponsrange.LBLASTR) {
                        rangeweaponLustDmg = (20 + player.cor / 15); // 20-26.7
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
        if (monster.lust >= monster.maxLust()) {
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
            } else enemyAI();
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
        if (player.weaponRange == weaponsrange.BLUNDER) player.ammo = 9;
        if (player.weaponRange == weaponsrange.TDPISTO) player.ammo = 6;
        if (player.weaponRange == weaponsrange.DESEAGL) player.ammo = 4;
        if (player.weaponRange == weaponsrange.DPISTOL) player.ammo = 3;
        if (player.weaponRange == weaponsrange.ADBSHOT) player.ammo = 2;
        if (player.weaponRange == weaponsrange.ADBSCAT) player.ammo = 2;
		if (player.weaponRange == weaponsrange.DBDRAGG) player.ammo = 2;
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
            player.dynStats("lus", lustDmg);
        } else outputText("You open the magazine of your " + player.weaponRangeName + " to reload the ammunition.");
    }

    public function reloadWeapon1():void {
        clearOutput();
        reloadWeapon();
        if (player.fatigue + (oneBulletReloadCost() * player.ammo) > player.maxFatigue()) {
            outputText(" You are too tired to act in this round after reloading your weapon.\n\n");
            player.fatigue += (oneBulletReloadCost() * player.ammo);
            enemyAI();
        } else {
            fatigue(oneBulletReloadCost() * player.ammo);
            if (player.hasPerk(PerkLib.RapidReload)) {
                outputText("\n\n");
                doNext(curry(combatMenu, false));
            } else {
                outputText("Reloading took some time. Your opponent takes advantage of this.\n\n");
                enemyAI();
            }
        }
    }

    public function reloadWeapon2():void {
        reloadWeapon();
        if (player.fatigue + (oneBulletReloadCost() * player.ammo) > player.maxFatigue()) {
            outputText("You are too tired to keep shooting in this round after reloading your weapon.\n\n");
            player.fatigue += (oneBulletReloadCost() * player.ammo);
            enemyAI();
        } else {
            fatigue(oneBulletReloadCost() * player.ammo);
            if (player.hasPerk(PerkLib.LightningReload) && flags[kFLAGS.MULTIPLE_ARROWS_STYLE] > 1) {
                flags[kFLAGS.MULTIPLE_ARROWS_STYLE] -= 1;
                flags[kFLAGS.ARROWS_ACCURACY] += firearmsAccuracyPenalty();
                outputText("\n\n");
                shootWeapon();
            } else {
                if (player.weaponRange != weaponsrange.M1CERBE && player.weaponRange != weaponsrange.TRFATBI && player.weaponRange != weaponsrange.HARPGUN && player.weaponRange != weaponsrange.SNIPPLE && player.weaponRange != weaponsrange.TOUHOM3 && player.weaponRange != weaponsrange.DERPLAU && player.weaponRange != weaponsrange.DUEL_P_
                        && player.weaponRange != weaponsrange.FLINTLK && player.weaponRange != weaponsrange.HARKON1) outputText(" Due to slow reloading you spent rest of your round on it and can't act until next turn.");
                outputText("\n\n");
                enemyAI();
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
                buttons.list.push(button);
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
        if (monster.short == "frost giant" && (player.hasStatusEffect(StatusEffects.GiantBoulder))) {
            lustChange = 20 + rand(player.lib / 4 + player.cor / 5);
            dynStats("lus", lustChange, "scale", false);
            (monster as FrostGiant).giantBoulderFantasize();
            enemyAI();
            return;
        }
        if (monster.short == "young frost giant" && (player.hasStatusEffect(StatusEffects.GiantBoulder))) {
            lustChange = 10 + rand(player.lib / 5 + player.cor / 8);
            dynStats("lus", lustChange, "scale", false);
            (monster as YoungFrostGiant).youngGiantBoulderFantasize();
            enemyAI();
            return;
        }
        if (player.armor == armors.GOOARMR) {
            outputText("As you fantasize, you feel Valeria rubbing her gooey body all across your sensitive skin");
            if (player.gender > 0) outputText(" and genitals");
            outputText(", arousing you even further.\n");
            lustChange = 25 + rand(player.lib / 8 + player.cor / 8)
        } else if (player.balls > 0 && player.ballSize >= 10 && rand(2) == 0) {
            outputText("You daydream about fucking [monster a] [monster name], feeling your balls swell with seed as you prepare to fuck [monster him] full of cum.\n");
            lustChange = 5 + rand(player.lib / 8 + player.cor / 8);
            outputText("You aren't sure if it's just the fantasy, but your [balls] do feel fuller than before...\n");
            player.hoursSinceCum += 50;
        } else if (player.biggestTitSize() >= 6 && rand(2) == 0) {
            outputText("You fantasize about grabbing [monster a] [monster name] and shoving [monster him] in between your jiggling mammaries, nearly suffocating [monster him] as you have your way.\n");
            lustChange = 5 + rand(player.lib / 8 + player.cor / 8)
        } else if (player.biggestLactation() >= 6 && rand(2) == 0) {
            outputText("You fantasize about grabbing [monster a] [monster name] and forcing [monster him] against a " + nippleDescript(0) + ", and feeling your milk let down.  The desire to forcefeed SOMETHING makes your nipples hard and moist with milk.\n");
            lustChange = 5 + rand(player.lib / 8 + player.cor / 8)
        } else {
            clearOutput();
            outputText("You fill your mind with perverted thoughts about [monster a] [monster name], picturing [monster him] in all kinds of perverse situations with you.\n");
            lustChange = 10 + rand(player.lib / 5 + player.cor / 8);
        }
        if (lustChange >= 20) outputText("The fantasy is so vivid and pleasurable you wish it was happening now.  You wonder if [monster a] [monster name] can tell what you were thinking.\n\n");
        else outputText("\n");
        dynStats("lus", lustChange, "scale", false);
        if (player.lust >= player.maxOverLust()) {
            if (monster is EncapsulationPod) {
                outputText("<b>You nearly orgasm, but the terror of the situation reasserts itself, muting your body's need for release.  If you don't escape soon, you have no doubt you'll be too fucked up to ever try again!</b>\n\n");
                player.lust = (player.maxOverLust() - 1);
                dynStats("lus", -25);
            } else {
                doNext(endLustLoss);
                return;
            }
        }
        enemyAI();
    }

    public function goboLustnadeLauncher():void {
        clearOutput();
        var damage:Number = 6 + rand(3);
        damage += scalingBonusIntelligence() * 0.1;
        if (player.hasKeyItem("Lustnade Launcher") >= 0) {
            if (player.hasPerk(PerkLib.SensualLover)) damage += 2;
            if (player.hasPerk(PerkLib.Seduction)) damage += 5;
            if (player.hasPerk(PerkLib.SluttySeduction)) damage += player.perkv1(PerkLib.SluttySeduction);
            if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
            if (player.hasPerk(PerkLib.JobSeducer)) damage += player.teaseLevel * 3;
            else damage += player.teaseLevel * 2;
            if (player.hasPerk(PerkLib.JobCourtesan) && monster.hasPerk(PerkLib.EnemyBossType)) damage *= 1.2;
            //partial skins bonuses
            switch (player.coatType()) {
                case Skin.FUR:
                    damage += (1 + player.newGamePlusMod());
                    break;
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
        if (player.armor == armors.GTECHC_) damage *= 1.5;
        if (player.upperGarment == undergarments.TECHBRA) damage *= 1.05;
        if (player.lowerGarment == undergarments.T_PANTY) damage *= 1.05;
        damage = damage * monster.lustVuln;
        damage = Math.round(damage);
        if (player.hasKeyItem("Lustnade Launcher") >= 0) {
            player.createStatusEffect(StatusEffects.CooldownLustnadeLauncher, 5, 0, 0, 0);
            outputText("You ready the Lustnade launcher and shoot. The exploding container covers the entire area in pink mist, massively arousing everyone in the vicinity for " + Math.round(monster.lustVuln * damage) + " lust damage.");
            monster.teased(Math.round(monster.lustVuln * monster.lustVuln * damage));
        } else {
            outputText("You spray a cloud of aphrodisiac with your gas gun. [monster a] [monster name] tries to pinch [monster his] nose and hold [monster his] breath ");
            if (rand(100) > 25) {
                outputText("but it’s too late and you can see arousal flushing [monster a] [monster name] skin for " + Math.round(monster.lustVuln * damage) + " lust damage.");
                monster.teased(Math.round(monster.lustVuln * damage));
            } else outputText("and it worked, to an extent, allowing your opponent to retreat away from the gas.");
        }
        if (monster.lust >= monster.maxLust()) doNext(endLustVictory);
        enemyAI();
    }

    public function defendpose():void {
        clearOutput();
        outputText("You decide not to take any offensive action this round preparing for [monster a] [monster name]'s attack. You take a defensive pose, watching your enemy's movements.\n\n");
        player.createStatusEffect(StatusEffects.Defend, 0, 0, 0, 0);
        if (player.hasPerk(PerkLib.DefenceStance)) {
            wrathregeneration1();
            fatigueRecovery1();
            manaregeneration1();
            soulforceregeneration1();
			venomCombatRecharge1();
        }
        enemyAI();
    }

    public function seconwindGo():void {
        clearOutput();
        outputText("You enter your second wind, recovering your energy.\n\n");
        fatigue((player.maxFatigue() - player.fatigue) / 2);
        player.createStatusEffect(StatusEffects.SecondWindRegen, 10, 0, 0, 0);
        player.createStatusEffect(StatusEffects.CooldownSecondWind, 0, 0, 0, 0);
        wrathregeneration1();
        fatigueRecovery1();
        manaregeneration1();
        soulforceregeneration1();
		venomCombatRecharge1();
        enemyAI();
    }

    public function surrenderByHP():void {
		doNext(combatMenu);
        clearOutput();
        outputText("You stop fighting, letting [monster a] [monster name] beat you to the brink of death.\n");
        player.HP = player.minHP();
        doNext(endHpLoss);
    }
    public function surrenderByLust():void {
        var remainingLust:Number = (player.maxLust() - player.lust);
        doNext(combatMenu);
        clearOutput();
        outputText("You fill your mind with perverted thoughts about [monster a] [monster name], picturing [monster him] in all kinds of perverse situations with you.\n");
        dynStats("lus", remainingLust, "scale", false);
        doNext(endLustLoss);
    }

    //ATTACK
    public function attack():void {
        var IsFeralCombat:Boolean = false;
        flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
        //	if(!player.hasStatusEffect(StatusEffects.FirstAttack)) {
        //		clearOutput();
        //		fatigueRecovery1();
        //	}
        if (player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 0) {
            outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  ");
            if (monster is ChaosChimera) outputText("Curse");
            else outputText("The kitsune's seals");
            outputText(" have made normal melee attacks impossible!  Maybe you could try something else?\n\n");
            enemyAI();
            return;
        }
        if (player.hasStatusEffect(StatusEffects.Sealed2) && player.statusEffectv2(StatusEffects.Sealed2) == 0) {
            outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Recent enemy attack have made normal melee attacks impossible!  Maybe you could try something else?\n\n");
            enemyAI();
            return;
        }
        if (flags[kFLAGS.PC_FETISH] >= 3 && !SceneLib.urtaQuest.isUrta()) {
            outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Ceraph's piercings have made normal melee attacks impossible!  Maybe you could try something else?\n\n");
            enemyAI();
            return;
        }
		if (checkConcentration()) return; //Amily concentration
        if (monster.hasStatusEffect(StatusEffects.Level) && !player.hasStatusEffect(StatusEffects.FirstAttack)) {
            if (monster is SandTrap) {
                outputText("It's all or nothing!  With a bellowing cry you charge down the treacherous slope and smite the sandtrap as hard as you can!  ");
                (monster as SandTrap).trapLevel(-4);
            }
            if (monster is Alraune) {
                outputText("It’s all or nothing!  If this leafy woman is so keen on pulling you in, you will let her do just that!  You use her own strength against her, using it to increase your momentum as you leap towards her and smash into her with your weapon!  ");
                (monster as Alraune).trapLevel(-6);
            }
        }
        /*if(player.hasPerk(PerkLib.DoubleAttack) && player.spe >= 50 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] < 2) {
		if(player.hasStatusEffect(StatusEffects.FirstAttack)) player.removeStatusEffect(StatusEffects.FirstAttack);
		else {
			//Always!
			if(flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0) player.createStatusEffect(StatusEffects.FirstAttack,0,0,0,0);
			//Alternate!
			else if(player.str < 61 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) player.createStatusEffect(StatusEffects.FirstAttack,0,0,0,0);
		}
	    }*/
        //"Brawler perk". Urta only. Thanks to Fenoxo for pointing this out... Even though that should have been obvious :<
        //Urta has fists and the Brawler perk. Don't check for that because Urta can't drop her fists or lose the perk!
        else if (SceneLib.urtaQuest.isUrta()) {
            if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
                player.removeStatusEffect(StatusEffects.FirstAttack);
            } else {
                player.createStatusEffect(StatusEffects.FirstAttack, 0, 0, 0, 0);
                outputText("Utilizing your skills as a bareknuckle brawler, you make two attacks!\n");
            }
        }
        //Blind
        if (player.playerIsBlinded()) {
            outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ");
        }
        if (monster is Basilisk && !player.hasPerk(PerkLib.BasiliskResistance)) {
            if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind))
                outputText("The Blind basilisk can't use his eyes, so you can actually aim your strikes!  ");
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
                outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You twist unexpectedly, bringing your [weapon] up at an oblique angle; the basilisk doesn't anticipate this attack!  ");
            }
        }
        if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
            if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(0);
            if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(0);
            enemyAI();
            return;
        }
        //Worms are special
        if (monster.short == "worms") {
            //50% chance of hit (int boost)
            if (rand(100) + player.inte / 3 >= 50) {
                var dam:int = int(player.str / 5 - rand(5));
                if (dam == 0) dam = 1;
                outputText("You strike at the amalgamation, crushing countless worms into goo, dealing <b><font color=\"#800000\">" + dam + "</font></b> damage.\n\n");
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
            enemyAI();
            return;
        }

        //Determine if dodged!
        if ((player.playerIsBlinded() && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
            //Akbal dodges special education
            if (monster.short == "Akbal") outputText("Akbal moves like lightning, weaving in and out of your furious strikes with the speed and grace befitting his jaguar body.\n");
            else if (monster.short == "plain girl") outputText("You wait patiently for your opponent to drop her guard. She ducks in and throws a right cross, which you roll away from before smacking your [weapon] against her side. Astonishingly, the attack appears to phase right through her, not affecting her in the slightest. You glance down to your [weapon] as if betrayed.\n");
            else if (monster.short == "kitsune") {
                //Player Miss:
                outputText("You swing your [weapon] ferociously, confident that you can strike a crushing blow.  To your surprise, you stumble awkwardly as the attack passes straight through her - a mirage!  You curse as you hear a giggle behind you, turning to face her once again.\n\n");
            } else {
                if (player.weapon == weapons.HNTCANE && rand(2) == 0) {
                    if (rand(2) == 0) outputText("You slice through the air with your cane, completely missing your enemy.");
                    else outputText("You lunge at your enemy with the cane.  It glows with a golden light but fails to actually hit anything.");
                }
                if (!MSGControll) {
                    if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
                    if (monster.spe - player.spe >= 8 && monster.spe - player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior speed!");
                    if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your attack.");
                }
                outputText("\n");
                if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
                    attack();
                    return;
                } else outputText("\n");
            }
            enemyAI();
            return;
        }
        //BLOCKED ATTACK:
        if (monster.hasStatusEffect(StatusEffects.Earthshield) && rand(4) == 0) {
            outputText("Your strike is deflected by the wall of sand, dirt, and rock!  Damn!\n");
            if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
                attack();
                return;
            } else outputText("\n");
            enemyAI();
            return;
        }
        if (flags[kFLAGS.ATTACKS_ACCURACY] > 0) flags[kFLAGS.ATTACKS_ACCURACY] = 0;
        //Natural weapon Full attack list
        if (flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && ((player.hasNaturalWeapons() || player.haveNaturalClawsTypeWeapon()))) {
            IsFeralCombat = true;
            resolveFeralCombatAdditionnalAttacks();
        }
        // Do all other attacks
        meleeDamageAcc(IsFeralCombat);
        if (player.hasPerk(PerkLib.LightningClaw)){
            outputText(" The residual electricity leaves your foe's skin tingling with pleasure.");
        }
    }

    public function attack2():void {
        // ESSENTIALY DO EVERYTHING AGAIN BUT without THE NATURAL ATTACK SET
        flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
        //	if(!player.hasStatusEffect(StatusEffects.FirstAttack)) {
        //		clearOutput();
        //		fatigueRecovery1();
        //	}
        if (player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 0) {
            outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  ");
            if (monster is ChaosChimera) outputText("Curse");
            else outputText("The kitsune's seals");
            outputText(" have made normal melee attack impossible!  Maybe you could try something else?\n\n");
            enemyAI();
            return;
        }
        if (player.hasStatusEffect(StatusEffects.Sealed2) && player.statusEffectv2(StatusEffects.Sealed2) == 0) {
            outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Recent enemy attack have made normal melee attack impossible!  Maybe you could try something else?\n\n");
            enemyAI();
            return;
        }
        if (flags[kFLAGS.PC_FETISH] >= 3 && !SceneLib.urtaQuest.isUrta()) {
            outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Ceraph's piercings have made normal melee attack impossible!  Maybe you could try something else?\n\n");
            enemyAI();
            return;
        }
        if (checkConcentration()) return; //Amily concentration
        if (monster.hasStatusEffect(StatusEffects.Level) && !player.hasStatusEffect(StatusEffects.FirstAttack)) {
            if (monster is SandTrap) {
                outputText("It's all or nothing!  With a bellowing cry you charge down the treacherous slope and smite the sandtrap as hard as you can!  ");
                (monster as SandTrap).trapLevel(-4);
            }
            if (monster is Alraune) {
                outputText("It’s all or nothing!  If this leafy woman is so keen on pulling you in, you will let her do just that!  You use her own strength against her, using it to increase your momentum as you leap towards her and smash into her with your weapon!  ");
                (monster as Alraune).trapLevel(-6);
            }
        }
                /*if(player.hasPerk(PerkLib.DoubleAttack) && player.spe >= 50 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] < 2) {
                if(player.hasStatusEffect(StatusEffects.FirstAttack)) player.removeStatusEffect(StatusEffects.FirstAttack);
                else {
                    //Always!
                    if(flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0) player.createStatusEffect(StatusEffects.FirstAttack,0,0,0,0);
                    //Alternate!
                    else if(player.str < 61 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) player.createStatusEffect(StatusEffects.FirstAttack,0,0,0,0);
                }
                }*/
                //"Brawler perk". Urta only. Thanks to Fenoxo for pointing this out... Even though that should have been obvious :<
        //Urta has fists and the Brawler perk. Don't check for that because Urta can't drop her fists or lose the perk!
        else if (SceneLib.urtaQuest.isUrta()) {
            if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
                player.removeStatusEffect(StatusEffects.FirstAttack);
            } else {
                player.createStatusEffect(StatusEffects.FirstAttack, 0, 0, 0, 0);
                outputText("Utilizing your skills as a bareknuckle brawler, you make two attacks!\n");
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
                outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You twist unexpectedly, bringing your [weapon] up at an oblique angle; the basilisk doesn't anticipate this attack!  ");
            }
        }
        if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
            if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(0);
            if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(0);
            enemyAI();
            return;
        }
        //Worms are special
        if (monster.short == "worms") {
            //50% chance of hit (int boost)
            if (rand(100) + player.inte / 3 >= 50) {
                var dam:int = int(player.str / 5 - rand(5));
                if (dam == 0) dam = 1;
                outputText("You strike at the amalgamation, crushing countless worms into goo, dealing <b><font color=\"#800000\">" + dam + "</font></b> damage.\n\n");
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
            enemyAI();
            return;
        }

        //Determine if dodged!
        if ((player.playerIsBlinded() && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
            //Akbal dodges special education
            if (monster.short == "Akbal") outputText("Akbal moves like lightning, weaving in and out of your furious strikes with the speed and grace befitting his jaguar body.\n");
            else if (monster.short == "plain girl") outputText("You wait patiently for your opponent to drop her guard. She ducks in and throws a right cross, which you roll away from before smacking your [weapon] against her side. Astonishingly, the attack appears to phase right through her, not affecting her in the slightest. You glance down to your [weapon] as if betrayed.\n");
            else if (monster.short == "kitsune") {
                //Player Miss:
                outputText("You swing your [weapon] ferociously, confident that you can strike a crushing blow.  To your surprise, you stumble awkwardly as the attack passes straight through her - a mirage!  You curse as you hear a giggle behind you, turning to face her once again.\n\n");
            } else {
                if (player.weapon == weapons.HNTCANE && rand(2) == 0) {
                    if (rand(2) == 0) outputText("You slice through the air with your cane, completely missing your enemy.");
                    else outputText("You lunge at your enemy with the cane.  It glows with a golden light but fails to actually hit anything.");
                }
                if (!MSGControll) {
                    if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
                    if (monster.spe - player.spe >= 8 && monster.spe - player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior speed!");
                    if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your attack.");
                }
                outputText("\n");
                if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
                    attack();
                    return;
                } else outputText("\n");
            }
            enemyAI();
            return;
        }
        //BLOCKED ATTACK:
        if (monster.hasStatusEffect(StatusEffects.Earthshield) && rand(4) == 0) {
            outputText("Your strike is deflected by the wall of sand, dirt, and rock!  Damn!\n");
            if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
                attack();
                return;
            } else outputText("\n");
            enemyAI();
            return;
        }
        if (flags[kFLAGS.ATTACKS_ACCURACY] > 0) flags[kFLAGS.ATTACKS_ACCURACY] = 0;
        // Do all other attacks
        meleeDamageAcc();
    }

    public function resolveFeralCombatAdditionnalAttacks():void {
        //DOING BITE ATTACKS
        if (player.hasABiteAttack()) {
            var biteMultiplier:Number = 0.5;
            outputText("You bite your foe, sinking your teeth in");
            if (player.hasPerk(PerkLib.FenrirSpiritstrike) && !monster.hasPerk(PerkLib.EnemyTrueDemon)){
                biteMultiplier = 10;
                outputText(" and tearing at your foe's very soul!");
                HPChange(player.maxHP()*0.25,false);
            }
            if (player.faceType == Face.SHARK_TEETH || player.faceType == Face.ORCA) biteMultiplier = 2.0;
            if (player.faceType == Face.SHARK_TEETH || player.faceType == Face.VAMPIRE) {
                outputText(" and drawing blood out.");
                if (!monster.hasStatusEffect(StatusEffects.SharkBiteBleed)) monster.createStatusEffect(StatusEffects.SharkBiteBleed,15,0,0,0);
                else {
                    monster.removeStatusEffect(StatusEffects.SharkBiteBleed);
                    monster.createStatusEffect(StatusEffects.SharkBiteBleed,15,0,0,0);
                }
            }
            if ((player.faceType == Face.SNAKE_FANGS || player.faceType == Face.SPIDER_FANGS) && player.tailVenom >= player.VenomWebCost()) {
                outputText(" and inject your venom into the wound!");
                if (player.faceType == Face.SNAKE_FANGS){
                    var DBPb:Number = 1;
                    if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) DBPb *= 2;
                    monster.statStore.addBuffObject({spe:-DBPb}, "Poison",{text:"Poison"});
                    var venomType:StatusEffectType = StatusEffects.NagaVenom;
                    if (player.nagaScore() >= 23) venomType = StatusEffects.ApophisVenom;
                    if (monster.hasStatusEffect(venomType)) {
                        monster.addStatusValue(venomType, 2, 0.4);
                        monster.addStatusValue(venomType, 1, (DBPb * 0.4));
                    } else monster.createStatusEffect(venomType, (DBPb * 0.4), 0.4, 0, 0);
                    player.tailVenom -= player.VenomWebCost();
                    flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                }
                if(player.faceType == Face.SPIDER_FANGS){
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
                        if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) damage3Ba *= 2;
                        damage3B *= damage3Ba;
                        poisonScaling *= damage3Ba;
                        damage3B *= 1 + (poisonScaling / 10);
                        monster.teased(Math.round(monster.lustVuln * damage3B));
                        monster.statStore.addBuffObject({tou:-poisonScaling}, "Poison",{text:"Poison"});
                        if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                            monster.addStatusValue(StatusEffects.NagaVenom, 3, damage3Ba);
                        } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, damage3Ba, 0);
                        player.tailVenom -= player.VenomWebCost();
                        flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                    } else {
                        var lustDmg:int = 6 * monster.lustVuln;
                        if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) lustDmg *= 2;
                        monster.teased(lustDmg);
                        if (monster.lustVuln > 0) {
                            monster.lustVuln += 0.01;
                            if (monster.lustVuln > 1) monster.lustVuln = 1;
                        }
                        player.tailVenom -= player.VenomWebCost();
                        flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                    }
                }
            }
            outputText(".");
            ExtraNaturalWeaponAttack(biteMultiplier);
            outputText(".\n");
            if (player.hasStatusEffect(StatusEffects.HydraTailsPlayer)){ //WTF, This can be so much simplier.
                biteMultiplier = 1;
                if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 2){
                    biteMultiplier *= 2;
                    outputText("You stand up erect and pull back for a second only to dart out with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    outputText("\n");
                }
                else if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 3){
                    biteMultiplier *= 3;
                    outputText("You stand up erect and pull back for a second only to dart out with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    outputText("\n");
                }
                else if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 4){
                    biteMultiplier *= 4;
                    outputText("You stand up erect and pull back for a second only to dart out with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    outputText("\n");
                }
                else if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 5){
                    biteMultiplier *= 5;
                    outputText("You stand up erect and pull back for a second only to dart out with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    outputText("\n");
                }
                else if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 6){
                    biteMultiplier *= 6;
                    outputText("You stand up erect and pull back for a second only to dart out with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    outputText("\n");
                }
                else if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 7){
                    biteMultiplier *= 7;
                    outputText("You stand up erect and pull back for a second only to dart out with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    outputText("\n");
                }
                else if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 8){
                    biteMultiplier *= 8;
                    outputText("You stand up erect and pull back for a second only to dart out with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    outputText("\n");
                }
                else if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 9){
                    biteMultiplier *= 9;
                    outputText("You stand up erect and pull back for a second only to dart out with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    outputText("\n");
                }
                else if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 10){
                    biteMultiplier *= 10;
                    outputText("You stand up erect and pull back for a second only to dart out with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    outputText("\n");
                }
                else if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 11){
                    biteMultiplier *= 11;
                    outputText("You stand up erect and pull back for a second only to dart out with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    outputText("\n");
                }
                else if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 12){
                    biteMultiplier *= 12;
                    outputText("You stand up erect and pull back for a second only to dart out with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
                    ExtraNaturalWeaponAttack(biteMultiplier);
                    outputText("\n");
                }
            }
        }
        //DOING EXTRA CLAW ATTACKS
        if (player.haveNaturalClaws()) {
            var ClawDamageMultiplier:Number = 1;
            if (player.arms.type == Arms.FROSTWYRM) ClawDamageMultiplier = 2;
            if (player.arms.type != Arms.MANTIS && player.arms.type != Arms.KAMAITACHI){
                outputText("You claw viciously at your opponent, tearing away at its body.");
            }
            else {
                ClawDamageMultiplier *= 1.5;
                outputText("You slash at your opponent with your scythes.");
                if (player.arms.type == Arms.KAMAITACHI){
                    outputText(" that bleeds profusely");
                }
                outputText(".");
            }
            if (player.arms.type == Arms.KAMAITACHI){
                ExtraNaturalWeaponAttack(ClawDamageMultiplier, "KamaitachiScythe");
                ExtraNaturalWeaponAttack(ClawDamageMultiplier, "KamaitachiScythe");
            }
            if (player.arms.type == Arms.WENDIGO){
                ExtraNaturalWeaponAttack(ClawDamageMultiplier, "WendigoClaw");
                ExtraNaturalWeaponAttack(ClawDamageMultiplier, "WendigoClaw");
            }
            if ((player.arms.type == Arms.GARGOYLE)){
				switch (Forgefather.channelInlay){
					case "amethyst":
						ExtraNaturalWeaponAttack(ClawDamageMultiplier, "darkness");
						ExtraNaturalWeaponAttack(ClawDamageMultiplier, "darkness");
						break;
					case "ruby":
						ExtraNaturalWeaponAttack(ClawDamageMultiplier, "fire");
						ExtraNaturalWeaponAttack(ClawDamageMultiplier, "fire");
						break;
					case "sapphire":
						ExtraNaturalWeaponAttack(ClawDamageMultiplier, "ice");
						ExtraNaturalWeaponAttack(ClawDamageMultiplier, "ice");
						break;
					case "topaz":
						ExtraNaturalWeaponAttack(ClawDamageMultiplier, "lightning");
						ExtraNaturalWeaponAttack(ClawDamageMultiplier, "lightning");
						break;
					default:
						ExtraNaturalWeaponAttack(ClawDamageMultiplier);
						ExtraNaturalWeaponAttack(ClawDamageMultiplier);
						break;
				}
			}
			else{
                ExtraNaturalWeaponAttack(ClawDamageMultiplier);
                ExtraNaturalWeaponAttack(ClawDamageMultiplier);
            }
            outputText("\n");
            if (player.arms.type == Arms.WOLF && player.hasPerk(PerkLib.Lycanthropy)){
                if (flags[kFLAGS.LUNA_MOON_CYCLE] != 7){
                    outputText("The moon grants you strength as you rend your opponent one more time with your claws.");
                    ExtraNaturalWeaponAttack();
                    outputText("\n");
                } else  {
                    outputText("The full moon grants you strength as you rend your opponent two more times with your claws.");
                    ExtraNaturalWeaponAttack();
                    ExtraNaturalWeaponAttack();
                    outputText("\n");
                }
            }
            if (player.arms.type == Arms.DISPLACER)
            {
                outputText("You use your extra arms to rend your opponent two more times.");
                ExtraNaturalWeaponAttack();
                ExtraNaturalWeaponAttack();
                outputText("\n");
            }
            if (player.arms.type == Arms.WENDIGO)
            {
                outputText("Your maddening hunger gives you strength allowing you to attack two more times, your strike delivering cursed wounds.");
                ExtraNaturalWeaponAttack(1, "WendigoClaw");
                ExtraNaturalWeaponAttack(1, "WendigoClaw");
                outputText("\n");
            }
        }
        //CENTAUR TIME!
        if (player.isTaur()) {
            if (player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.CLOVEN_HOOFED){
                outputText("You rear up and trample your opponent with your hooves.");
            }
            else{
                outputText("You rear up and claw at your opponent with your forepaws.");
            }
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            outputText("\n");
        }
        //POUNCING FOR THE KILL
        if (player.canPounce()) {
            outputText("You leap up at [monster a] [monster name] raking [monster him] with your hind claws twice.");
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            outputText("\n");
        }
        if (player.isFlying()){
            if (player.hasTalonsAttack()){
                outputText("You rend at your opponent with your talons twice.");
                ExtraNaturalWeaponAttack();
                ExtraNaturalWeaponAttack();
                outputText("\n");
            }
        }
        //DEALING WING ATTACKS
        if (player.hasAWingAttack())
        {
            if (player.wings.type == Wings.THUNDEROUS_AURA){
                outputText("You zap your opponent with your aura, delivering a barrage of arousing discharge");
                LustyEnergyNaturalWeaponAttack(0.20)
                LustyEnergyNaturalWeaponAttack(0.20)
                LustyEnergyNaturalWeaponAttack(0.20)
                LustyEnergyNaturalWeaponAttack(0.20)
                LustyEnergyNaturalWeaponAttack(0.20)
            }
            else{
                if (player.wings.type == Wings.WINDY_AURA){
                    outputText("You unleash your sharp winds on your opponent delivering bruise and cuts");
                }
                else{
                    outputText("You batter your foe with your two powerful wings");
                }
                if (player.wings.type == Wings.GARGOYLE_LIKE_LARGE){
                    //(If gargoyle stun proc)
                    outputText(" the stony impact sending it reel to the side, dazed");
                }
                outputText(".");
                ExtraNaturalWeaponAttack(0.5);
            }
            outputText("\n");
        }
        //DOING HORN ATACK
        if (player.hasAGoreAttack()) {
            if (player.horns.type == Horns.UNICORN)
            {
                outputText("You impale your foe on your horn, blood coating the tip.");
            } else {
                outputText("You impale your foe on your horns, blood coating the tips.");
            }
            if (!monster.hasStatusEffect(StatusEffects.GoreBleed)) monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
            else {
                monster.removeStatusEffect(StatusEffects.GoreBleed);
                monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
            }
            ExtraNaturalWeaponAttack(1.5);
            outputText("\n");
        }
        //TAIL SLAPPING FOR THE KILL
        if (player.hasATailSlapAttack()) {
            var TailDamageMultiplier:Number = 1;
            if (player.lowerBody == LowerBody.NAGA || player.lowerBody == LowerBody.FROSTWYRM) TailDamageMultiplier = 3;
            if (player.tail.type == Tail.MANTICORE_PUSSYTAIL){
                outputText("You hiss and raise your tail. You strike at blinding speed, impaling your opponent twice with your spike");
                if (player.tailVenom >= player.VenomWebCost()) {
                    outputText(" and injecting your venom in the process");
                    //TailVenomArea
                    var lustdamage:Number = 35 + rand(player.lib / 10);
                    var lustDmg2:Number = 1;
                    if (player.level < 10) lustdamage += 20 + (player.level * 3);
                    else if (player.level < 20) lustdamage += 50 + (player.level - 10) * 2;
                    else if (player.level < 30) lustdamage += 70 + (player.level - 20) * 1;
                    else lustdamage += 80;
                    lustdamage *= 0.14;
                    if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) lustDmg2 *= 2;
                    lustdamage *= lustDmg2;
                    monster.teased(Math.round(monster.lustVuln * lustdamage), false);
                    monster.statStore.addBuffObject({tou:-(lustDmg2*2)}, "Poison",{text:"Poison"});
                    player.tailVenom -= player.VenomWebCost();
                    flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                    if (player.tailVenom >= player.VenomWebCost()) {
                        monster.teased(Math.round(monster.lustVuln * lustdamage), false);
                        monster.statStore.addBuffObject({tou:-(lustDmg2*2)}, "Poison",{text:"Poison"});
                        player.tailVenom -= player.VenomWebCost();
                        flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                    }
                    var dBd1c:Number = 1;
                    if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) dBd1c *= 2;
                    monster.teased(Math.round(monster.lustVuln * lustdamage * dBd1c), false);
                    combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
                    monster.statStore.addBuffObject({spe:-(dBd1c*10)}, "Poison",{text:"Poison"});
                    if (monster.hasStatusEffect(StatusEffects.ManticoreVenom)) monster.addStatusValue(StatusEffects.ManticoreVenom,3,(dBd1c*5));
                    else monster.createStatusEffect(StatusEffects.ManticoreVenom, 0, 0, (dBd1c*5), 0);
                    player.tailVenom -= player.VenomWebCost();
                }
                outputText(".")
                ExtraNaturalWeaponAttack(0.5);
                ExtraNaturalWeaponAttack(0.5);
                outputText("\n")
            }
            if (player.tail.type == Tail.RAIJU || player.tail.type == Tail.THUNDERBIRD){
                outputText("You overcharge your tail in order to deliver a pleasant but electrifying caress to your opponent.");
                LustyEnergyNaturalWeaponAttack(1);
                outputText("\n")
            }
            else if (player.tail.type == Tail.SCORPION || player.tail.type == Tail.BEE_ABDOMEN ){
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
                if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) dBd2c *= 2;
                monster.teased(Math.round(monster.lustVuln * lustdamage2 * dBd2c), false);
                combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
                if (monster.hasStatusEffect(StatusEffects.BeeVenom)) monster.addStatusValue(StatusEffects.BeeVenom,3,(dBd2c*5));
                else monster.createStatusEffect(StatusEffects.BeeVenom, 0, 0, (dBd2c*5), 0);
                outputText("\n")
            }
			if ((player.tail.type == (Tail.GARGOYLE || Tail.GARGOYLE_2))){
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
			}
            else{
                outputText("You hit your opponent with a slam of your mighty tail");
                if (player.tail.type == Tail.SALAMANDER) outputText(" setting your target on fire");
                if (player.tail.type == Tail.GARGOYLE) outputText(" leaving it dazed");
                outputText(".")
                ExtraNaturalWeaponAttack(TailDamageMultiplier);
                outputText("\n");
            }
        }
        //Unique attack Mantis Prayer
        if (player.mantisScore() >= 12 && player.arms.type == Arms.MANTIS){
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
        if (player.kamaitachiScore() >= 12 && player.arms.type == Arms.KAMAITACHI){
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
        //Unique attack Slime
        if (player.hasPerk(PerkLib.MorphicWeaponry)) {
            outputText("You form tentacles out of your slimy body and batter your opponent with them.");
            var TentacleDamageMultiplier:Number = Math.round(player.level/10);
            ExtraNaturalWeaponAttack(TentacleDamageMultiplier);
        }

        //Unique attack Sea dragon shock
        if (player.antennae.type == Antennae.SEA_DRAGON && player.hasPerk(PerkLib.LightningAffinity)) {
            outputText("You lash out with your whiskers delivering a pair of deadly electrical discharges.");
            var ThunderDamageMultiplier:Number = Math.round(player.inte/100);
            ExtraNaturalWeaponAttack(ThunderDamageMultiplier);
            ExtraNaturalWeaponAttack(ThunderDamageMultiplier);
            if (rand(100)>95 && !monster.hasPerk(PerkLib.LightningNature) && !monster.hasPerk(PerkLib.LightningAffinity)){
                if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
                    if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
                    outputText(" The discharge leaves your opponent stunned!.");
                }
            }
        }

        //Unique attack Alraune
        if (player.isAlraune()) {
            outputText("You lash at your opponent with your many vines, striking twelve times.");
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
            ExtraNaturalWeaponAttack();
        }

        //Unique TENTACLES STRIKES
        if ((player.isScylla() || player.isKraken()) && player.tallness >= 70){
            if(player.hasStatusEffect(StatusEffects.InvisibleOrStealth)){
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
        }
    }

    public function CommasForDigits(damage:Number):void {
        var damagemsg:Array = new Array(String(damage).length);
        var damageTemp:Number = damage;
        outputText("<b>(</b>");
        for (var i:int = 0; i < damagemsg.length; i++) {
            damagemsg[i] = int(damageTemp % 10);
            damageTemp = Math.floor(damageTemp / 10);
        }
        for (var j:int = 0, k:int = (damagemsg.length % 3); j < damagemsg.length; j++) {
            if (k == 0) {
                if (j != 0) outputText(",");
                k = 3;
            }
            outputText("<b><font color=\"#800000\">" + String(damagemsg[damagemsg.length - j - 1]) + "</font></b>");
            k--;
        }
        outputText("<b>)</b>");
    }

	private function meleeDamageNoLagSingle(IsFeralCombat:Boolean = false):Number {
		var damage:Number = 0;
		//------------
		// DAMAGE
		//------------
		//Determine damage
		//BASIC DAMAGE STUFF
		if (IsFeralCombat && player.hasPerk(PerkLib.VerdantMight)) {
			damage += player.tou;
			damage += scalingBonusToughness() * 0.2;
		}
		else {
			if (player.isElf() && player.isSpearTypeWeapon() && player.hasPerk(PerkLib.ELFElvenBattleStyle)) {
				damage += player.inte;
				damage += scalingBonusToughness() * 0.2;
				if (player.hasPerk(PerkLib.ELFElvenSpearDancingFlurry1to4)) damage*=1+(0.2*player.perkv1(PerkLib.ELFElvenSpearDancingFlurry1to4));
			}
			else if (player.weapon == weapons.MGSWORD) {
				damage += player.inte;
				damage += scalingBonusIntelligence() * 0.2;
			}
			else {
				damage += player.str;
				damage += scalingBonusStrength() * 0.2;
			}
		}
		if (player.isFlying()){
			if (player.hasPerk(MutationsLib.HarpyHollowBones)) damage *= 1.2;
			if (player.hasPerk(MutationsLib.HarpyHollowBonesPrimitive)) damage *= 1.3;
			if (player.hasPerk(MutationsLib.HarpyHollowBonesEvolved)) damage *= 1.5;
		}
		if ((player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) && player.isFistOrFistWeapon()){
			damage *= 2;
			if (player.hasPerk(MutationsLib.YetiFatPrimitive)) damage *= 1.5;
			if (player.hasPerk(MutationsLib.YetiFatEvolved)) damage *= 1.5;
		}
		if (player.hasPerk(PerkLib.SpeedDemon) && player.isNoLargeNoStaffWeapon()) {
			damage += player.spe;
			damage += scalingBonusSpeed() * 0.20;
			if (player.hasStatusEffect(StatusEffects.JabbingStyle)) damage += player.spe * player.statusEffectv1(StatusEffects.JabbingStyle);
		}
		if (player.hasPerk(PerkLib.QuickStrike) && (player.weaponSpecials("Small") || player.weaponSpecials("Dual Small"))) {
			damage += (player.spe / 2);
			damage += scalingBonusSpeed() * 0.10;
		}
		if (player.hasPerk(PerkLib.HoldWithBothHands) && !player.isFistOrFistWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) damage *= 1.2;
		if (damage < 10) damage = 10;
		//Weapon addition!
		if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.03));
		else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (2.5 + ((player.weaponAttack - 50) * 0.025));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (3.75 + ((player.weaponAttack - 100) * 0.02));
		else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (4.75 + ((player.weaponAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponAttack - 200) * 0.01));
		if (player.hasPerk(PerkLib.DivineArmament) && player.isUsingStaff() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) damage *= 3;
		if (player.weaponSpecials("Dual Small") || player.weaponSpecials("Dual") || player.weaponSpecials("Dual Large")) damage *= meleeDualWieldDamagePenalty();
		//Bonus sand trap / alraune damage!
		if (monster.hasStatusEffect(StatusEffects.Level) && (monster is SandTrap || monster is Alraune)) damage = Math.round(damage * 1.75);
		//All special weapon effects like...fire/ice
		if (player.weapon == weapons.L_WHIP) {
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		}
		if (player.weapon == weapons.NPHBLDE || player.weapon == weapons.MOONLIT || player.weapon == weapons.MASAMUN || player.weapon == weapons.SESPEAR || player.weapon == weapons.WG_GAXE || player.weapon == weapons.KARMTOU || player.weapon == weapons.ARMAGED) {
			if (monster.cor < 33) damage = Math.round(damage * 1.0);
			else if (monster.cor < 50) damage = Math.round(damage * 1.1);
			else if (monster.cor < 75) damage = Math.round(damage * 1.2);
			else if (monster.cor < 90) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
		}
		if (player.weapon == weapons.EBNYBLD || player.weapon == weapons.C_BLADE || player.weapon == weapons.BLETTER || player.weapon == weapons.DSSPEAR || player.weapon == weapons.DE_GAXE || player.weapon == weapons.YAMARG || player.weapon == weapons.CHAOSEA) {
			if (monster.cor >= 66) damage = Math.round(damage * 1.0);
			else if (monster.cor >= 50) damage = Math.round(damage * 1.1);
			else if (monster.cor >= 25) damage = Math.round(damage * 1.2);
			else if (monster.cor >= 10) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
		}
		if (flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon()) && player.hasStatusEffect(StatusEffects.WinterClaw)) {
			damage *= 2.2;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 10;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 4;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.4;
			if (player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 10;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 4;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.25;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.1;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			var damage1:Number = damage;
			if (monster.hasPerk(PerkLib.IceNature)) damage1 += (damage1 * 0.5);
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage1 += (damage1 * 0.2);
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage1 += (damage1 * 0.05);
			if (monster.hasPerk(PerkLib.FireNature)) damage1 += (damage1 * 0.02);
			if (player.hasPerk(PerkLib.FireAffinity)) damage1 *= 2;
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
			damage += damage1;
		}
		if ((player.isDuelingTypeWeapon() || player.isSwordTypeWeapon() || player.isAxeTypeWeapon() || player.isDaggerTypeWeapon()) && player.hasStatusEffect(StatusEffects.FlameBlade)) {
			var damage2:Number = damage;
			if (monster.hasPerk(PerkLib.IceNature)) damage2 += (damage2 * 0.5);
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage2 += (damage2 * 0.2);
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage2 += (damage2 * 0.05);
			if (monster.hasPerk(PerkLib.FireNature)) damage2 += (damage2 * 0.02);
			if (player.hasPerk(PerkLib.FireAffinity)) damage2 *= 2;
			damage += scalingBonusLibido() * 0.20;
			damage += damage2;
		}
		if (player.weapon == weapons.BFGAUNT || (player.shield == shields.AETHERS && player.weapon == weapons.AETHERD && AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets")) damage *= 4;
		if (player.weapon == weapons.FRTAXE && monster.isFlying()) damage *= 1.5;
		if (player.weapon == weapons.VENCLAW && flags[kFLAGS.FERAL_COMBAT_MODE] == 1) damage *= 1.2;
		if (player.weapon == weapons.ARMAGED) damage *= 1.25;
		if (player.weaponName == "fists") damage *= (1 + (0.01 * masteryFeralCombatLevel()));
		if (player.isGauntletWeapon()) damage *= (1 + (0.01 * masteryGauntletLevel()));
		if (player.isSwordTypeWeapon()) damage *= (1 + (0.01 * masterySwordLevel()));
		if (player.isAxeTypeWeapon()) damage *= (1 + (0.01 * masteryAxeLevel()));
		if (player.isMaceHammerTypeWeapon()) damage *= (1 + (0.01 * masteryMaceHammerLevel()));
		if (player.isDuelingTypeWeapon()) damage *= (1 + (0.01 * masteryDuelingSwordLevel()));
		if (player.isPolearmTypeWeapon()) damage *= (1 + (0.01 * masteryPolearmLevel()));
		if (player.isSpearTypeWeapon()) damage *= (1 + (0.01 * masterySpearLevel()));
		if (player.isDaggerTypeWeapon()) damage *= (1 + (0.01 * masteryDaggerLevel()));
		if (player.isWhipTypeWeapon()) damage *= (1 + (0.01 * masteryWhipLevel()));
		if (player.isExoticTypeWeapon()) damage *= (1 + (0.01 * masteryExoticLevel()));
		if (player.weaponSpecials("Dual Small")) damage *= (1 + (0.01 * dualWSLevel()));
		if (player.weaponSpecials("Dual")) damage *= (1 + (0.01 * dualWNLevel()));
		if (player.weaponSpecials("Dual Large")) damage *= (1 + (0.01 * dualWLLevel()));
		//Thunderous Strikes
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.ChiReflowMagic)) damage *= UmasShop.NEEDLEWORK_MAGIC_REGULAR_MULTI;
		if (player.hasPerk(PerkLib.ChiReflowAttack)) damage *= UmasShop.NEEDLEWORK_ATTACK_REGULAR_MULTI;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
		if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
		if (player.hasPerk(PerkLib.LifeLeech) && player.isFistOrFistWeapon()) {
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) damage *= 1.1;
			else damage *= 1.05;
		}
		if (player.isSpearTypeWeapon() && player.hasPerk(PerkLib.ElvenRangerArmor)) damage *= 1.5;
		if ((player.weapon == weapons.S_RULER) && (monster.hasPerk(PerkLib.EnemyHugeType) || monster.hasPerk(PerkLib.EnemyGigantType) || monster.hasPerk(PerkLib.EnemyColossalType))) damage *= 1.5;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.hasPerk(PerkLib.OniTyrantKimono || PerkLib.OniEnlightenedKimono)) damage *= 1.4;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasPerk(PerkLib.GoblinoidBlood)) {
			if (player.hasKeyItem("Power bracer") >= 0) damage *= 1.1;
			if (player.hasKeyItem("Powboy") >= 0) damage *= 1.15;
			if (player.hasKeyItem("M.G.S. bracer") >= 0) damage *= 1.2;
		}
		if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
		if (SceneLib.urtaQuest.isUrta()) damage *= 2;
		damage *= meleePhysicalForce();
		return damage;
	}

    public function meleeDamageAcc(IsFeralCombat:Boolean = false):void {
        var accMelee:Number = 0;
        var damage:Number = 0;
        accMelee += (meleeAccuracy() / 2);
        if (flags[kFLAGS.ATTACKS_ACCURACY] > 0) accMelee -= flags[kFLAGS.ATTACKS_ACCURACY];
        if (player.weaponName == "Truestrike sword") accMelee = 100;
    	if (rand(100) < accMelee) {
			if (meleeDamageNoLag != 0) damage += meleeDamageNoLag;
			else {
				if (IsFeralCombat) {
					meleeDamageNoLag += meleeDamageNoLagSingle(IsFeralCombat);
					damage += meleeDamageNoLagSingle(IsFeralCombat);
				}
				else {
					meleeDamageNoLag += meleeDamageNoLagSingle();
					damage += meleeDamageNoLagSingle();
				}
			}
			//Determine if critical hit!
            var crit:Boolean = false;
            var critChance:int = 5;
            var critDamage:Number = 1.75;
            critChance += combatPhysicalCritical();
            if (player.isSwordTypeWeapon()) critChance += 10;
            if (player.isDuelingTypeWeapon()) critChance += 20;
            if (player.hasPerk(PerkLib.JobDervish) && (!player.weaponSpecials("Large") || !player.weaponSpecials("Staff"))) critChance += 10;
            if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponSpecials("Large") && player.str >= 100) critChance += 10;
            if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weaponSpecials("Dual Large") && player.str >= 140) critChance += 10;
            if (player.hasPerk(PerkLib.GigantGripEx) && player.weaponSpecials("Massive")) {
                if (player.hasPerk(PerkLib.WeaponMastery) && player.str >= 100) critChance += 10;
                if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.str >= 140) critChance += 10;
            }
            if (player.weapon == weapons.MASAMUN || (player.weapon == weapons.WG_GAXE && monster.cor > 66) || ((player.weapon == weapons.DE_GAXE || player.weapon == weapons.YAMARG) && monster.cor < 33)) critChance += 10;
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
            if (rand(100) < critChance) {
                crit = true;
				critDamage += bonusCriticalDamageFromMissingHP();
                if ((player.weapon == weapons.WG_GAXE && monster.cor > 66) || (player.weapon == weapons.DE_GAXE && monster.cor < 33)) critDamage += 0.1;
				if (player.hasPerk(PerkLib.OrthodoxDuelist) && player.isDuelingTypeWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) critDamage += 0.2;
				if (player.hasStatusEffect(StatusEffects.AlterBindScroll4)) critDamage += 1;
                damage *= critDamage;
            }
            //Apply AND DONE!
            damage *= (monster.damagePercent() / 100);
            //One final round
            damage = Math.round(damage);
            //ANEMONE SHIT
            if (monster.short == "anemone") {
                //hit successful:
                //special event, block (no more than 10-20% of turns, also fails if PC has >75 corruption):
                if (rand(10) <= 1) {
                    outputText("Seeing your [weapon] raised, the anemone looks down at the water, angles her eyes up at you, and puts out a trembling lip.  ");
                    if (player.cor < 75) {
                        outputText("You stare into her hangdog expression and lose most of the killing intensity you had summoned up for your attack, stopping a few feet short of hitting her.\n");
                        damage = 0;
                        //Kick back to main if no damage occured!
                        if (monster.HP > 0 && monster.lust < monster.maxLust()) {
                            if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
                                attack2();
                                return;
                            }
                            enemyAI();
                        } else {
                            if (monster.HP <= monster.minHP()) doNext(endHpVictory);
                            else doNext(endLustVictory);
                        }
                        return;
                    } else outputText("Though you lose a bit of steam to the display, the drive for dominance still motivates you to follow through on your swing.");
                }
            }
            if (monster.short == "sea anemone") {
                //hit successful:
                //special event, block (no more than 10-20% of turns, also fails if PC has >75 corruption):
                if (rand(10) <= 1) {
                    outputText("Seeing your [weapon] raised, the anemone looks down at the ocean, angles her eyes up at you, and puts out a trembling lip.  ");
                    if (player.cor < 75) {
                        outputText("You stare into her hangdog expression and lose most of the killing intensity you had summoned up for your attack, stopping a few feet short of hitting her.\n");
                        damage = 0;
                        //Kick back to main if no damage occured!
                        if (monster.HP > 0 && monster.lust < monster.maxLust()) {
                            if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
                                attack2();
                                return;
                            }
                            enemyAI();
                        } else {
                            if (monster.HP <= monster.minHP()) doNext(endHpVictory);
                            else doNext(endLustVictory);
                        }
                        return;
                    } else outputText("Though you lose a bit of steam to the display, the drive for dominance still motivates you to follow through on your swing.");
                }
            }
            // Have to put it before doDamage, because doDamage applies the change, as well as status effects and shit.
            if (monster is Doppleganger) {
                if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
                    if (damage > 0) {
                        if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= historyFighterBonus();
                        if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
                        if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
                        if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
                        if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
                        if (player.armor == armors.SPKIMO) damage *= 1.2;
                        if (player.hasPerk(PerkLib.OniTyrantKimono || PerkLib.OniEnlightenedKimono)) damage *= 1.4;
                        if (player.necklace == necklaces.OBNECK) damage *= 1.2;
                        if (player.hasPerk(PerkLib.GoblinoidBlood)) {
                            if (player.hasKeyItem("Power bracer") >= 0) damage *= 1.1;
                            if (player.hasKeyItem("Powboy") >= 0) damage *= 1.15;
                            if (player.hasKeyItem("M.G.S. bracer") >= 0) damage *= 1.2;
                        }
                    }
                    if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
                    if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
                    if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
					if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
                    if (damage > 0) doPhysicalDamage(damage, false);
                    (monster as Doppleganger).mirrorAttack(damage);
                    return;
                }
                // Stunning the doppleganger should now "buy" you another round.
            }
            if (player.weapon == weapons.HNTCANE) {
                switch (rand(2)) {
                    case 0:
                        outputText("You swing your cane through the air. The light wood lands with a loud CRACK that is probably more noisy than painful. ");
                        damage *= 0.5;
                        break;
                    case 1:
                        outputText("You brandish your cane like a sword, slicing it through the air. It thumps against your adversary, but doesn’t really seem to harm them much. ");
                        damage *= 0.5;
                        break;
                    default:
                }
            }
            if ((damage <= 0) && ((MDOCount == maxCurrentRangeAttacks()) && (MSGControllForEvasion) && (!MSGControll))) {
                damage = 0;
                outputText("Your attacks are deflected or blocked by [monster a] [monster name].");
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
                if (flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon())) {
                    //DOING BASIC EXTRA NATURAL ATTACKS
                    outputText("You savagely rend [monster a] [monster name] with your natural weapons.");
                    if (player.hasPerk(PerkLib.LightningClaw)) {
						var damageLC:Number = 0;
                        damageLC = 6 + rand(3);
                        if (player.hasPerk(PerkLib.SensualLover)) damageLC += 2;
                        if (player.hasPerk(PerkLib.Seduction)) damageLC += 5;
                        //+ slutty armor bonus
                        if (player.hasPerk(PerkLib.SluttySeduction)) damageLC += player.perkv1(PerkLib.SluttySeduction);
                        if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damageLC += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
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
                        if (player.hasPerk(PerkLib.SluttySimplicity) && player.armorName == "nothing") damageLC *= (1 + ((10 + rand(11)) / 100));
                        damageLC *= .7;
                        var damagemultiplier:Number = 1;
                        if (player.hasPerk(PerkLib.ElectrifiedDesire)) damagemultiplier += player.lust100 * 0.01;
                        if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) damagemultiplier += combat.historyWhoreBonus();
                        if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 10) damagemultiplier += 0.2;
                        if (player.hasPerk(MutationsLib.RaijuCathode)) damagemultiplier += 0.5;
                        if (player.hasPerk(MutationsLib.RaijuCathodePrimitive)) damagemultiplier += 0.5;
                        if (player.hasPerk(MutationsLib.RaijuCathodeEvolved)) damagemultiplier += 1;
                        if (player.armorName == "desert naga pink and black silk dress") damagemultiplier += 0.1;
                        if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
                        damageLC *= damagemultiplier;
                        //Determine if critical tease!
                        var crit1:Boolean = false;
                        var critChance1:int = 5;
                        if (player.hasPerk(PerkLib.CriticalPerformance)) {
                            if (player.lib <= 100) critChance1 += player.lib / 5;
                            if (player.lib > 100) critChance1 += 20;
                        }
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
                } else if (vbladeeffect) outputText("As you strike, the sword shines with a red glow. The sword twists in your hand, guiding you right at [monster a] [monster name]'s throat. ");
                else if (MDODialogs) {
                } else if (!MSGControll) {
					outputText("You "+player.weaponVerb+" [monster a] [monster name]! "); // for not displaying the same msg a lot of times.
                }
                if (crit) {
                    outputText("<b>Critical! </b>");
                    if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
                }
                if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
                    if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
                    else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
                }
                //Damage is delivered HERE
                if (((player.weapon == weapons.RCLAYMO || player.weapon == weapons.RDAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon) || Forgefather.channelInlay == "ruby") || (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) || (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) || ((player.isDuelingTypeWeapon() || player.isSwordTypeWeapon() || player.isAxeTypeWeapon() || player.isDaggerTypeWeapon()) && player.hasStatusEffect(StatusEffects.FlameBlade))) {
					damage = Math.round(damage * fireDamageBoostedByDao());
					doFireDamage(damage, true, true);
				}
                else if (((player.weapon == weapons.SCLAYMO || player.weapon == weapons.SDAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon) || Forgefather.channelInlay == "sapphire") || (flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon()) && player.hasStatusEffect(StatusEffects.WinterClaw))) {
					damage = Math.round(damage * iceDamageBoostedByDao());
					doIceDamage(damage, true, true);
				}
                else if (((player.weapon == weapons.TCLAYMO || player.weapon == weapons.TODAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon) || Forgefather.channelInlay == "topaz") || player.weapon == weapons.S_RULER) {
					damage = Math.round(damage * lightningDamageBoostedByDao());
					doLightingDamage(damage, true, true);
				}
                else if (((player.weapon == weapons.ACLAYMO || player.weapon == weapons.ADAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon) || Forgefather.channelInlay == "amethyst")) {
					damage = Math.round(damage * darknessDamageBoostedByDao());
					doDarknessDamage(damage, true, true);
				}
				else if (player.weapon == weapons.MGSWORD) doMagicDamage(damage, true, true);
				else if (player.weapon == weapons.PHALLUS) {
					if (player.statusEffectv1(StatusEffects.ThePhalluspear1) == 1) monster.teased(Math.round(monster.lustVuln * damage * 0.05));
					else {
						doPhysicalDamage(Math.round(damage * 0.75), true, true);
						monster.teased(Math.round(monster.lustVuln * damage * 0.0125));
					}
				}
                else {
                    doPhysicalDamage(damage, true, true);
                    if (player.weapon == weapons.DAISHO) doPhysicalDamage(Math.round(damage * 0.5), true, true);
				}
                if (player.hasStatusEffect(StatusEffects.AlchemicalThunderBuff)) doLightingDamage(Math.round(damage * 0.3), true, true);
                if (player.weapon == weapons.PRURUMI && player.spe >= 150) {
                    doPhysicalDamage(damage, true, true);
                    if (player.hasStatusEffect(StatusEffects.AlchemicalThunderBuff)) doLightingDamage(Math.round(damage * 0.3), true, true);
                    if (player.spe >= 225) {
                        doPhysicalDamage(damage, true, true);
                        if (player.hasStatusEffect(StatusEffects.AlchemicalThunderBuff)) doLightingDamage(Math.round(damage * 0.3), true, true);
                    }
                    if (player.spe >= 300) {
                        doPhysicalDamage(damage, true, true);
                        if (player.hasStatusEffect(StatusEffects.AlchemicalThunderBuff)) doLightingDamage(Math.round(damage * 0.3), true, true);
                    }
                }
				if (player.hasStatusEffect(StatusEffects.FalseWeapon)) {
					if (player.weapon == weapons.PHALLUS) doPhysicalDamage((damage * 2), true, true);
					else doPhysicalDamage(Math.round(damage * 0.2), true, true);
				}
				if (player.weapon == weapons.PRURUMI && player.spe >= 150) {
					if (player.spe >= 300) damage += damage * 3;
                    else if (player.spe >= 225) damage += damage * 2;
					else damage += damage;
				}
                JabbingStyleIncrement();
                if (player.hasStatusEffect(StatusEffects.AlchemicalThunderBuff)) damage += Math.round(damage * 0.3);
				var meleeMasteryEXPgains:Number = 1;
				if (crit) meleeMasteryEXPgains *= 2;
				if (player.weapon == weapons.CHAOSEA) meleeMasteryEXPgains *= 3;
				if (player.weaponName == "fists" && player.haveNaturalClaws()) feralCombatXP(meleeMasteryEXPgains);
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
				if (player.weaponSpecials("Dual Small")) dualWieldSmallXP(meleeMasteryEXPgains);
				if (player.weaponSpecials("Dual")) dualWieldNormalXP(meleeMasteryEXPgains);
				if (player.weaponSpecials("Dual Large")) dualWieldLargeXP(meleeMasteryEXPgains);
            }
            if (player.hasPerk(PerkLib.BrutalBlows) && player.str > 75) {
                if (monster.armorDef > 0) outputText("\nYour hits are so brutal that you damage [monster a] [monster name]'s defenses!");
                if (monster.armorDef - 5 > 0) monster.armorDef -= 5;
                else monster.armorDef = 0;
            }
			if (player.statStore.hasBuff("NoLimiterState") && player.weaponName == "fists") {
				var curseLib:Number = player.lib * 0.005;
				if (curseLib < 1) curseLib = 1;
				else curseLib = Math.round(curseLib);
				player.addCurse("lib", curseLib, 1);
			}
            //Damage cane.
            if (player.weapon == weapons.HNTCANE) {
                flags[kFLAGS.ERLKING_CANE_ATTACK_COUNTER]++;
                //Break cane
                if (flags[kFLAGS.ERLKING_CANE_ATTACK_COUNTER] >= 10 && rand(20) == 0) {
                    outputText("\n<b>The cane you're wielding finally snaps! It looks like you won't be able to use it anymore.</b>");
                    player.setWeapon(WeaponLib.FISTS);
                }
            }
            if (damage > 0) {
                //Lust raised by anemone contact!
                if (monster.short == "anemone") {
                    outputText("\nThough you managed to hit the anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
                    //(gain lust, temp lose str/spd)
                    (monster as Anemone).applyVenom((1 + rand(2)));
                }
                if (monster.short == "sea anemone") {
                    outputText("\nThough you managed to hit the sea anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
                    //(gain lust, temp lose str/spd)
                    (monster as SeaAnemone).applyVenom((1 + rand(2)));
                }
                //Lust raising weapon bonuses
                if (monster.lustVuln > 0) {
                    if (player.weapon == weapons.L_CLAWS || player.weapon == weapons.L_DAGGR || player.weapon == weapons.LRAPIER || player.weapon == weapons.DEPRAVA || player.weapon == weapons.ASCENSU
					|| (player.shield == shields.AETHERS && player.weapon == weapons.AETHERD && AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets")) {//player.weapon == weapons.large || player.weapon == weapons.massive ||
                        outputText("\n[Themonster] shivers as your weapon's 'poison' goes to work.");
                        if (player.weapon == weapons.L_CLAWS || player.weapon == weapons.LRAPIER || player.weapon == weapons.DEPRAVA || player.weapon == weapons.ASCENSU || (player.shield == shields.AETHERS && player.weapon == weapons.AETHERD && AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets")) monster.teased(monster.lustVuln * (10 + player.cor / 8));
                        else monster.teased(monster.lustVuln * (5 + player.cor / 10));
                    }
                    var whipLustDmg:Number = 0;
                    var whipCorSelf:Number = 0;
                    var whipLustSelf:Number = 0;
                    var hasArcaneLash:Boolean = player.hasPerk(PerkLib.ArcaneLash);
                    if ((player.weapon == weapons.WHIP || player.weapon == weapons.PWHIP || player.weapon == weapons.NTWHIP) && rand(2) == 0) {
                        whipLustDmg = (5 + player.cor / 12) * (hasArcaneLash ? 1.4 : 1); // 5-13.3 (7-18.7 w/perk)
                        whipCorSelf = 0;
                        whipLustSelf = 0;
                    } else if (player.weapon == weapons.SUCWHIP || player.weapon == weapons.PSWHIP) {
                        whipLustDmg = (20 + player.cor / 15) * (hasArcaneLash ? 1.8 : 1); // 20-26.7 (36-48 w/perk)
                        whipCorSelf = 0.3;
                        whipLustSelf = (rand(2) == 0) ? 0 : 1; // 50% +1
                    } else if (player.weapon == weapons.L_WHIP) {
                        whipLustDmg = (10 + player.cor / 5) * (hasArcaneLash ? 2.0 : 1); // 10-30 (20-60 w/perk)
                        whipCorSelf = 0.6;
                        whipLustSelf = (rand(4) == 0) ? 0 : 1; // 75% +1
                    }
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
                if ((player.weapon == weapons.DEMSCYT || player.weapon == weapons.EBNYBLD) && player.cor < 90) dynStats("cor", 0.3);
                //Selfpurifying and Lust lowering weapons
                if ((player.weapon == weapons.LHSCYTH || player.weapon == weapons.NPHBLDE) && player.cor > 10) dynStats("cor", -0.3);
                if (player.weapon == weapons.EXCALIB) {
                    if (player.cor > 10) dynStats("cor", -0.3);
                    var excaliburLustSelf:Number;
                    excaliburLustSelf = (rand(2) == 0) ? 0 : 1;
                    if (excaliburLustSelf > 0) dynStats("lus", -excaliburLustSelf);
                }
                //Weapon Procs!
                WeaponMeleeStatusProcs();
                if (player.weapon == weapons.RIPPER2) {
                    outputText("  Reeling in pain [themonster] begins to burn.");
                    if (monster.hasStatusEffect(StatusEffects.BurnDoT)) monster.addStatusValue(StatusEffects.BurnDoT,1,1);
					else monster.createStatusEffect(StatusEffects.BurnDoT, 5, 0.05, 0, 0);
                }
                if (player.hasPerk(PerkLib.PoisonNails) && player.isFistOrFistWeapon()) {
                    var lust0damage:Number = 35 + rand(player.lib / 10);
                    lust0damage *= 0.14;
                    monster.teased(Math.round(monster.lustVuln * lust0damage));
                    monster.statStore.addBuffObject({tou:-2, spe:-2}, "Poison",{text:"Poison"});
                    if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                        monster.addStatusValue(StatusEffects.NagaVenom, 3, 1);
                    } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
                }
            }
            if (flags[kFLAGS.ENVENOMED_MELEE_ATTACK] == 1 && (player.weaponSpecials("Small") || player.weaponSpecials("Dual Small"))) {
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
							player.tailVenom -= player.VenomWebCost();
							flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
						}
						if (player.tailType == Tail.SCORPION) {
							outputText("  [monster he] seems to be effected by the poison, its movement turning sluggish.");
							var damBa:Number = 1;
							if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) damBa *= 2;
							monster.statStore.addBuffObject({spe:-(damBa*2)}, "Poison",{text:"Poison"});
							if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
								monster.addStatusValue(StatusEffects.NagaVenom, 3, damBa);
							} else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, damBa, 0);
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
							if (player.nagaScore() >= 23) venomType = StatusEffects.ApophisVenom;
							if (monster.hasStatusEffect(venomType)) {
								monster.addStatusValue(venomType, 2, 0.4);
								monster.addStatusValue(venomType, 1, (DBPaaaa*0.4));
							} else monster.createStatusEffect(venomType, (DBPaaaa*0.4), 0.4, 0, 0);
							player.tailVenom -= player.VenomWebCost();
							flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
						}
						if (player.faceType == Face.SPIDER_FANGS) {
							if (player.lowerBody == LowerBody.ATLACH_NACHA){
								outputText("  [monster he] seems to be affected by the poison, showing increasing sign of weakness and arousal.");
								var damage4B:Number = 35 + rand(player.lib / 10);
								var poisonScaling:Number = 1;
								var damage4Ba:Number = 1;
								if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) DBPaaaa *= 2;
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
								player.tailVenom -= player.VenomWebCost();
								flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
							} else {
								outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
								var lustDmg:int = 6 * monster.lustVuln;
								if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) lustDmg *= 2;
								monster.teased(lustDmg);
								if (monster.lustVuln > 0) {
									monster.lustVuln += 0.01;
									if (monster.lustVuln > 1) monster.lustVuln = 1;
								}
								player.tailVenom -= player.VenomWebCost();
								flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
							}
						}
						if (monster.lust >= monster.maxLust()) {
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
            }
            if (monster is JeanClaude && !player.hasStatusEffect(StatusEffects.FirstAttack)) {
                if (monster.HP <= monster.minHP() || monster.lust > monster.maxLust()) {
                    // noop
                }
                if (player.lust <= 30) {
                    outputText("\n\nJean-Claude doesn’t even budge when you wade into him with your [weapon].");
                    outputText("\n\n\"<i>Why are you attacking me, slave?</i>\" he says. The basilisk rex sounds genuinely confused. His eyes pulse with hot, yellow light, reaching into you as he opens his arms, staring around as if begging the crowd for an explanation. \"<i>You seem lost, unable to understand, lashing out at those who take care of you. Don’t you know who you are? Where you are?</i>\" That compulsion in his eyes, that never-ending heat, it’s... it’s changing things. You need to finish this as fast as you can.");
                } else if (player.lust <= 50) {
                    outputText("\n\nAgain your [weapon] thumps into Jean-Claude. Again it feels wrong. Again it sends an aching chime through you, that you are doing something that revolts your nature.");
                    outputText("\n\n\"<i>Why are you fighting your master, slave?</i>\" he says. He is bigger than he was before. Or maybe you are smaller. \"<i>You are confused. Put your weapon down- you are no warrior, you only hurt yourself when you flail around with it. You have forgotten what you were trained to be. Put it down, and let me help you.</i>\" He’s right. It does hurt. Your body murmurs that it would feel so much better to open up and bask in the golden eyes fully, let it move you and penetrate you as it may. You grit your teeth and grip your [weapon] harder, but you can’t stop the warmth the hypnotic compulsion is building within you.");
                } else if (player.lust <= 80) {
                    outputText("\n\n\"<i>Do you think I will be angry at you?</i>\" growls Jean-Claude lowly. Your senses feel intensified, his wild, musky scent rich in your nose. It’s hard to concentrate... or rather it’s hard not to concentrate on the sweat which runs down his hard, defined frame, the thickness of his bulging cocks, the assured movement of his powerful legs and tail, and the glow, that tantalizing, golden glow, which pulls you in and pushes so much delicious thought and sensation into your head…  \"<i>I am not angry. You will have to be punished, yes, but you know that is only right, that in the end you will accept and enjoy being corrected. Come now, slave. You only increase the size of the punishment with this silliness.</i>\"");
                } else {
                    outputText("\n\nYou can’t... there is a reason why you keep raising your weapon against your master, but what was it? It can’t be that you think you can defeat such a powerful, godly alpha male as him. And it would feel so much better to supplicate yourself before the glow, lose yourself in it forever, serve it with your horny slut body, the only thing someone as low and helpless as you could possibly offer him. Master’s mouth is moving but you can no longer tell where his voice ends and the one in your head begins... only there is a reason you cling to like you cling onto your [weapon], whatever it is, however stupid and distant it now seems, a reason to keep fighting...");
                }
                dynStats("lus", 25);
            }
            outputText(" ");
            outputText("\n\n"); //Move to next attack line
            if (MDOCount == maxCurrentAttacks()) outputText("\n");
            checkAchievementDamage(damage);
			WrathGenerationPerHit1(5);
            WrathWeaponsProc();
            heroBaneProc(damage);
            EruptingRiposte();
            if (player.hasPerk(PerkLib.SwiftCasting) && (player.isOneHandedWeapons() || (player.weaponSpecials("Large") && player.hasPerk(PerkLib.GigantGrip))) && player.isHavingFreeOffHand() && flags[kFLAGS.ELEMENTAL_MELEE] > 0) {
                if (flags[kFLAGS.ELEMENTAL_MELEE] == 1 && CombatAbilities.Whitefire.isUsable) {
                    outputText("\n\n");
                    CombatAbilities.Whitefire.perform();
                }
                if (flags[kFLAGS.ELEMENTAL_MELEE] == 2 && CombatAbilities.IceSpike.isUsable) {
                    outputText("\n\n");
                    CombatAbilities.IceSpike.perform();
                }
                if (flags[kFLAGS.ELEMENTAL_MELEE] == 3 && CombatAbilities.LightningBolt.isUsable) {
                    outputText("\n\n");
                    CombatAbilities.LightningBolt.perform();
                }
                if (flags[kFLAGS.ELEMENTAL_MELEE] == 4 && CombatAbilities.DarknessShard.isUsable) {
                    outputText("\n\n");
                    CombatAbilities.DarknessShard.perform();
                }
                if (flags[kFLAGS.ELEMENTAL_MELEE] == 5 && CombatAbilities.WaterBall.isUsable) {
                    outputText("\n\n");
                    CombatAbilities.WaterBall.perform();
                }
                if (flags[kFLAGS.ELEMENTAL_MELEE] == 6 && CombatAbilities.WindBullet.isUsable) {
                    outputText("\n\n");
                    CombatAbilities.WindBullet.perform();
                }
                if (flags[kFLAGS.ELEMENTAL_MELEE] == 7 && CombatAbilities.Stalagmite.isUsable) {
                    outputText("\n\n");
                    CombatAbilities.Stalagmite.perform();
                }
                if (flags[kFLAGS.ELEMENTAL_MELEE] == 8 && CombatAbilities.AcidSpray.isUsable) {
                    outputText("\n\n");
                    CombatAbilities.AcidSpray.perform();
                }
            }
            if (player.hasPerk(PerkLib.LifeLeech) && player.isFistOrFistWeapon()) {
                var sippedA:Number = 0.01;
				if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) sippedA *= 2;
				player.HP += player.maxHP() * sippedA;
                player.mana += player.maxMana() * sippedA;
                player.fatigue -= player.maxFatigue() * sippedA;
                player.soulforce += player.maxSoulforce() * sippedA;
                if (player.HP > player.maxHP()) player.HP = player.maxHP();
                if (player.mana > player.maxMana()) player.mana = player.maxMana();
                if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
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
            if (player.isFistOrFistWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()){
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
                    var playerMaxCarry:Number = player.str+(player.tallness/12*100);
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
        } else { //MISSED THE TARGET THUS DAMAGE = 0;
            if (monster is DisplacerBeast) outputText("The displacer beast teleports, dodging your attack.\n");
            else outputText("You swing your [weapon] ferociously, confident that you can strike a crushing blow. In your confidence, you focus too much on force, and not where your swing is headed. You miss, your enemy barely needing to move to evade your blow.\n");
        }

        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return;
        }
        if (monster.lust >= monster.maxLust()) {
            doNext(endLustVictory);
            return;
        }
        if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] >= 2) {
			if (player.wrath > 0) {
				flags[kFLAGS.MULTIPLE_ATTACKS_STYLE]--;
				flags[kFLAGS.ATTACKS_ACCURACY] += meleeAccuracyPenalty();
				player.wrath -= 1;
				attack2();
				return;
			}
            else outputText("\nYou're too <b>'calm'</b> to attack again in this turn!");
        }
        if (player.hasStatusEffect(StatusEffects.FirstAttack)) {
            attack2();
            return;
        }
        if (player.statusEffectv1(StatusEffects.CounterAction) > 0) {
            player.removeStatusEffect(StatusEffects.CounterAction);
            doNext(playerMenu);
        }
        outputText("\n");
        if (monster.hasStatusEffect(StatusEffects.HypnosisNaga)) {
            outputText("\nThe pain makes your target snap out of the trance, causing them to realise what is going on.\n");
            player.removeStatusEffect(StatusEffects.HypnosisNaga);
        }
        wrathregeneration1();
        fatigueRecovery1();
        manaregeneration1();
        soulforceregeneration1();
		venomCombatRecharge1();
        enemyAI();
    }

    public function JabbingStyleIncrement():void{
        if (player.hasPerk(PerkLib.JabbingStyle)){
            var JabbingValue:Number = 0.02;
            if (player.hasPerk(PerkLib.JabbingMaster)) JabbingValue = 0.04;
            if(!player.hasStatusEffect(StatusEffects.JabbingStyle)) player.createStatusEffect(StatusEffects.JabbingStyle,JabbingValue,0,0,0);
            else player.addStatusValue(StatusEffects.JabbingStyle,1,JabbingValue);
        }
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

    public function ExtraNaturalWeaponAttack(FeraldamageMultiplier:Number = 1, SpecialEffect:String = ""):void {
        var accMelee:Number = 0;
        accMelee += (meleeAccuracy() / 2);
        if (flags[kFLAGS.ATTACKS_ACCURACY] > 0) accMelee -= flags[kFLAGS.ATTACKS_ACCURACY];
        if (rand(100) < accMelee) {
            var damage:Number = 0;
            //------------
            // DAMAGE
            //------------
            //Determine damage
            //BASIC DAMAGE STUFF
            if (player.hasPerk(PerkLib.VerdantMight)){
                damage += player.tou;
                damage += scalingBonusToughness() * 0.25;
            }
            else{
                damage += player.str;
                damage += scalingBonusStrength() * 0.25;
            }
            if (player.isFlying()){
                if (player.hasPerk(MutationsLib.HarpyHollowBones)) damage *= 1.2;
                if (player.hasPerk(MutationsLib.HarpyHollowBonesPrimitive)) damage *= 1.3;
                if (player.hasPerk(MutationsLib.HarpyHollowBonesPrimitive)) damage *= 1.5;
            }
            if ((player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) && player.isFistOrFistWeapon()) damage *= 2;
            if (player.hasPerk(PerkLib.SpeedDemon) && player.isNoLargeNoStaffWeapon()) {
                damage += player.spe;
                damage += scalingBonusSpeed() * 0.20;
            }
            if (damage < 10) damage = 10;
            //Weapon addition!
            if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.03));
            else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (2.5 + ((player.weaponAttack - 50) * 0.025));
            else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (3.75 + ((player.weaponAttack - 100) * 0.02));
            else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (4.75 + ((player.weaponAttack - 150) * 0.015));
            else damage *= (5.5 + ((player.weaponAttack - 200) * 0.01));
            //Bonus sand trap damage!
            if (monster.hasStatusEffect(StatusEffects.Level) && (monster is SandTrap || monster is Alraune)) damage = Math.round(damage * 1.75);
            //Determine if critical hit!
            var crit:Boolean = false;
            var critChance:int = 5;
            var critDamage:Number = 1.75;
            critChance += combatPhysicalCritical();
			critDamage += bonusCriticalDamageFromMissingHP();
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
                crit = true;
                damage *= critDamage;
            }
            //Apply AND DONE!
            damage *= (monster.damagePercent() / 100);
            //Damage post processing!
            //Thunderous Strikes
            if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
            if (player.hasPerk(PerkLib.ChiReflowMagic)) damage *= UmasShop.NEEDLEWORK_MAGIC_REGULAR_MULTI;
            if (player.hasPerk(PerkLib.ChiReflowAttack)) damage *= UmasShop.NEEDLEWORK_ATTACK_REGULAR_MULTI;
            if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
            if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
            if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
            if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
            //One final round
            damage = Math.round(damage);
            if (SpecialEffect == "KamaitachiScythe"){
                if (!monster.hasStatusEffect(StatusEffects.KamaitachiBleed)) monster.createStatusEffect(StatusEffects.KamaitachiBleed,0,0,0,0);
                else monster.addStatusValue(StatusEffects.KamaitachiBleed, 1, player.spe*2);
            }
            if (SpecialEffect == "WendigoClaw"){
                monster.addCurse("tou.mult",0.05,2);
                monster.addCurse("str.mult",0.05,2);
            }
            // Have to put it before doDamage, because doDamage applies the change, as well as status effects and shit.
            if (monster is Doppleganger) {
                if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
                    if (damage > 0) {
                        if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= historyFighterBonus();
                        if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
                        if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
                        if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
                        if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
                        if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
						if (player.armor == armors.SPKIMO) damage *= 1.2;
                        if (player.hasPerk(PerkLib.OniTyrantKimono || PerkLib.OniEnlightenedKimono)) damage *= 1.4;
                        if (player.necklace == necklaces.OBNECK) damage *= 1.2;
                        if (player.hasPerk(PerkLib.GoblinoidBlood)) {
                            if (player.hasKeyItem("Power bracer") >= 0) damage *= 1.1;
                            if (player.hasKeyItem("Powboy") >= 0) damage *= 1.15;
                            if (player.hasKeyItem("M.G.S. bracer") >= 0) damage *= 1.2;
                        }
                    }
                    if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
                    if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
                    if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
					if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
                    if (damage > 0) doPhysicalDamage(damage, false);
                    (monster as Doppleganger).mirrorAttack(damage);
                    return;
                }
                // Stunning the doppleganger should now "buy" you another round.
            }
            if ((damage <= 0) && ((MDOCount == maxCurrentRangeAttacks()) && (MSGControllForEvasion) && (!MSGControll))) {
                damage = 0;
                outputText("Your attacks are deflected or blocked by [monster a] [monster name].");
            } else {
                if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= historyFighterBonus();
                if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
                if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
                if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
                if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
                if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
				if (player.armor == armors.SPKIMO) damage *= 1.2;
                if (player.hasPerk(PerkLib.OniTyrantKimono || PerkLib.OniEnlightenedKimono)) damage *= 1.4;
                if (player.necklace == necklaces.OBNECK) damage *= 1.2;
                if (player.hasPerk(PerkLib.GoblinoidBlood)) {
                    if (player.hasKeyItem("Power bracer") >= 0) damage *= 1.1;
                    if (player.hasKeyItem("Powboy") >= 0) damage *= 1.15;
                    if (player.hasKeyItem("M.G.S. bracer") >= 0) damage *= 1.2;
                }
                if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
                if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
                if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
				if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();

                else if (MDODialogs) {

                }
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
				if (SpecialEffect == "fire") doFireDamage(damage, true, true);
				else if (SpecialEffect == "ice") doIceDamage(damage, true, true);
				else if (SpecialEffect == "lightning") doLightingDamage(damage, true, true);
				else if (SpecialEffect == "darkness") doDarknessDamage(damage, true, true);
                else doPhysicalDamage(damage, true, true);
                if (player.hasPerk(PerkLib.LightningClaw)) {
                    damage = 6 + rand(3);
                    if (player.hasPerk(PerkLib.SensualLover)) damage += 2;
                    if (player.hasPerk(PerkLib.Seduction)) damage += 5;
                    //+ slutty armor bonus
                    if (player.hasPerk(PerkLib.SluttySeduction)) damage += player.perkv1(PerkLib.SluttySeduction);
                    if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
                    if (player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)) damage += 5;
                    if (player.hasPerk(PerkLib.FlawlessBody)) damage += 10;
                    damage += scalingBonusLibido() * 0.1;
                    if (player.hasPerk(PerkLib.JobSeducer)) damage += player.teaseLevel * 3;
                    else damage += player.teaseLevel * 2;
                    //partial skins bonuses
                    switch (player.coatType()) {
                        case Skin.FUR:
                            damage += (1 + player.newGamePlusMod());
                            break;
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
                    //slutty simplicity bonus
                    if (player.hasPerk(PerkLib.SluttySimplicity) && player.armorName == "nothing") damage *= (1 + ((10 + rand(11)) / 100));
                    damage *= .7;
                    var damagemultiplier:Number = 1;
                    if (player.hasPerk(PerkLib.ElectrifiedDesire)) damagemultiplier += player.lust100 * 0.01;
                    if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) damagemultiplier += combat.historyWhoreBonus();
                    if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 10) damagemultiplier += 0.2;
                    if (player.armorName == "desert naga pink and black silk dress") damagemultiplier += 0.1;
                    if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
                    if (player.hasPerk(MutationsLib.RaijuCathode)) damagemultiplier += 0.5;
                    if (player.hasPerk(MutationsLib.RaijuCathodePrimitive)) damagemultiplier += 0.5;
                    if (player.hasPerk(MutationsLib.RaijuCathodeEvolved)) damagemultiplier += 1;
                    damage *= damagemultiplier;
                    //Determine if critical tease!
                    var crit1:Boolean = false;
                    var critChance1:int = 5;
                    if (player.hasPerk(PerkLib.CriticalPerformance)) {
                        if (player.lib <= 100) critChance1 += player.lib / 5;
                        if (player.lib > 100) critChance1 += 20;
                    }
                    if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance1 = 0;
                    if (rand(100) < critChance1) {
                        crit1 = true;
                        damage *= 1.75;
                    }
                    if (player.hasPerk(PerkLib.ChiReflowLust)) damage *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
                    if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
                    damage = damage * 0.33 * monster.lustVuln;
                    damage = Math.round(damage);
                    monster.teased(damage,false);
                    if (crit1) outputText(" <b>Critical!</b>");
                    outputText(" ");
                    if (player.hasPerk(PerkLib.SuperSensual) && player.hasPerk(PerkLib.Sensual)) teaseXP(2);
                    else teaseXP(1);
                    if (player.hasPerk(MutationsLib.HeartOfTheStormEvolved)){
                        if (rand(100) < 5) {
                            if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
                        }
                    }
                }
            }
            if (player.hasPerk(PerkLib.BrutalBlows) && player.str > 75) {
                if (monster.armorDef - 5 > 0) monster.armorDef -= 5;
                else monster.armorDef = 0;
            }
			if (player.statStore.hasBuff("NoLimiterState") && player.weaponName == "fists") {
				var curseLib:Number = player.lib * 0.005;
				if (curseLib < 1) curseLib = 1;
				else curseLib = Math.round(curseLib);
				player.addCurse("lib", curseLib, 1);
			}
        }
        wrathregeneration1();
        fatigueRecovery1();
        manaregeneration1();
        soulforceregeneration1();
		venomCombatRecharge1();
    }

    public function LustyEnergyNaturalWeaponAttack(FeraldamageMultiplier:Number = 1, stunChance:Number = 10):void {
        var damage:Number = scalingBonusIntelligence() * spellModWhite();
        damage = damage*FeraldamageMultiplier;
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
        if (player.hasPerk(MutationsLib.FloralOvaries)) damage *= 1.25;
        if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
        damage *= 2;
        damage = Math.round(damage);
        doLightingDamage(damage, true, true);
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
        if (player.hasPerk(PerkLib.SluttySeduction)) lustDmgF += player.perkv1(PerkLib.SluttySeduction);
        if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) lustDmgF += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
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
        if (player.hasPerk(PerkLib.SluttySimplicity) && player.armorName == "nothing") lustDmgF *= (1 + ((10 + rand(11)) / 100));
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
        if (player.hasPerk(PerkLib.CriticalPerformance)) {
            if (player.lib <= 100) critChance2 += player.lib / 5;
            if (player.lib > 100) critChance2 += 20;
        }
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance2 = 0;
        if (rand(100) < critChance2) {
            crit2 = true;
            lustDmgF *= 1.75;
        }
        if (player.hasPerk(PerkLib.ChiReflowLust)) lustDmgF *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
        if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) lustDmgF *= 1.5;
        if (player.hasPerk(MutationsLib.HeartOfTheStorm)) damage *= 1.1;
        if (player.hasPerk(MutationsLib.HeartOfTheStormPrimitive)) damage *= 1.2;
        if (player.hasPerk(MutationsLib.HeartOfTheStormEvolved)) damage *= 1.3;
        if (player.hasPerk(MutationsLib.RaijuCathodePrimitive)) damage *= 1.2;
        if (player.hasPerk(PerkLib.RacialParagon)) lustDmgF *= RacialParagonAbilityBoost();
        if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmgF *= 1.50;
        lustDmgF = lustDmgF * monster.lustVuln;
        lustDmgF = Math.round(lustDmgF);
        monster.teased(lustDmgF, false);
        combat.bonusExpAfterSuccesfullTease();
        if (crit2) outputText(" <b>Critical!</b>");
        if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
        if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
        if (player.hasPerk(MutationsLib.HeartOfTheStormEvolved)){
            if (rand(100) < stunChance) {
                if (monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
            }
        }
    }

    public function WeaponMeleeStatusProcs():void {
        var stun:Boolean = false;
        var stunChance:int = 0;
        var bleed:Boolean = false;
        var bleedChance:int = 0;
        if (player.isMaceHammerTypeWeapon()) stunChance += 10;
        if (player.isAxeTypeWeapon()) bleedChance += 25;
        //10% Stun chance
        if (player.weapon == weapons.S_GAUNT && player.hasPerk(PerkLib.MightyFist) || player.weaponSpecials("Stun10") || (player.shield == shields.AETHERS && player.weapon == weapons.AETHERD && AetherTwinsFollowers.AetherTwinsShape == "Human-tier Gaunlets")) stunChance += 10;
        //15% Stun Chance
        if (player.weaponSpecials("Stun15")) stunChance += 15;
        //20% Stun chance
        if ((player.isFistOrFistWeapon() && player.weapon != weapons.KARMTOU && player.weapon != weapons.BFGAUNT && player.hasPerk(PerkLib.MightyFist)) || player.weaponSpecials("Stun20")) stunChance += 20;
        //25% Stun chance
        if (player.weapon == weapons.KARMTOU && player.hasPerk(PerkLib.MightyFist)) stunChance += 25;
        //30% Stun chance
        if (player.weapon == weapons.ZWNDER && !monster.hasStatusEffect(StatusEffects.Stunned)) stunChance += 30;
        //40% Stun chance
        if (player.weapon == weapons.BFGAUNT && player.hasPerk(PerkLib.MightyFist)) stunChance += 40;
		//50% Stun chance
		if (player.shield == shields.AETHERS && player.weapon == weapons.AETHERD && AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets") stunChance += 50;
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
        if (player.weaponSpecials("Bleed10") || (player.shield == shields.AETHERS && player.weapon == weapons.AETHERD && AetherTwinsFollowers.AetherTwinsShape == "Human-tier Gaunlets")) bleedChance += 10;
        //25% Bleed chance
        if (player.weaponSpecials("Bleed25")) bleedChance += 25;
		//45% Bleed chance
        if (player.weaponSpecials("Bleed45") || (player.shield == shields.AETHERS && player.weapon == weapons.AETHERD && AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets")) bleedChance += 45;
        //100% Bleed chance
        if (player.weaponSpecials("Bleed100")) bleedChance += 100;
        if (monster.hasPerk(PerkLib.EnemyConstructType) || monster.hasPerk(PerkLib.EnemyPlantType) || monster.hasPerk(PerkLib.EnemyGooType)) bleedChance = 0;
        if (rand(100) < bleedChance) bleed = true;
        if (bleed) {
            if (monster.hasPerk(PerkLib.EnemyConstructType)) {
                if (monster is LivingStatue) outputText("Despite the rents you've torn in its stony exterior, the statue does not bleed.");
                else outputText("Despite the gashes you've torn in its exterior, [monster a] [monster name] does not bleed.");
            } else {
                if (player.weapon == weapons.MACGRSW || player.weapon == weapons.RIPPER1 || player.weapon == weapons.RIPPER2) {
					if (monster.hasStatusEffect(StatusEffects.Hemorrhage))  monster.removeStatusEffect(StatusEffects.Hemorrhage);
                    if (player.weapon == weapons.MACGRSW) monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.02, 0, 0);
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
        if ((player.hasPerk(PerkLib.VampiricBlade) || player.hasStatusEffect(StatusEffects.LifestealEnchantment) || player.weapon == weapons.T_HEART || player.weapon == weapons.DORSOUL || player.weapon == weapons.LHSCYTH || player.weapon == weapons.ARMAGED) && !monster.hasPerk(PerkLib.EnemyConstructType)) {
			var restoreamount:Number = 0;
			if (player.hasPerk(PerkLib.VampiricBlade)) restoreamount += 1;
			if (player.hasStatusEffect(StatusEffects.LifestealEnchantment)) restoreamount += 1;
			if (player.weapon == weapons.LHSCYTH) restoreamount += 1;
			if (player.weapon == weapons.T_HEART || player.weapon == weapons.DORSOUL || player.weapon == weapons.ARMAGED) restoreamount += 0.5;
            if (player.weaponSpecials("Small") || player.weaponSpecials("Dual Small")) HPChange(Math.round(player.maxHP() * restoreamount * 0.005), false);
            else if (player.weaponSpecials("Large") || player.weaponSpecials("Dual Large")) HPChange(Math.round(player.maxHP() * restoreamount * 0.02), false);
            else if (player.weaponSpecials("Massive")) HPChange(Math.round(player.maxHP() * restoreamount * 0.04), false);
            else HPChange(Math.round(player.maxHP() * restoreamount * 0.01), false);
        }
		if (player.weapon == weapons.VENCLAW && monster.lustVuln > 0) {
            outputText("\n[monster he] seems to be affected by the poison, showing increasing sign of arousal.");
            var Ldamage:Number = 8 + rand(3);
            monster.teased(Math.round(monster.lustVuln * Ldamage));
            monster.statStore.addBuffObject({tou:-1}, "Poison",{text:"Poison"});
            if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                monster.addStatusValue(StatusEffects.NagaVenom, 3, 1);
            } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
        }
		if (player.weapon == weapons.CHAOSEA) {
			var devouredWrath:Number = 0;
			var transferedWrath:Number = 0;
			var devouredMana:Number = 0;
			var transferedMana:Number = 0;
			if (monster.wrath > 400) {
				monster.wrath -= 400;
				transferedWrath += 200;
			} else {
				devouredWrath = monster.wrath;
				monster.wrath = 0;
				transferedWrath += Math.round(devouredWrath / 2)
			}
			if (transferedWrath > 0) {
				outputText("(+" + transferedWrath + " wrath)");
				player.wrath += transferedWrath;
			}
			if (monster.mana > 400) {
				monster.mana -= 400;
				transferedMana += 200;
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
				if (monster.hasStatusEffect(StatusEffects.Frostbite)) monster.addStatusValue(StatusEffects.Frostbite,1,1);
				else monster.createStatusEffect(StatusEffects.Frostbite,1,0,0,0);
			}
		}
    }

    public function WeaponRangeStatusProcs():void {
		if (player.hasStatusEffect(StatusEffects.LifestealEnchantment) && !monster.hasPerk(PerkLib.EnemyConstructType)) HPChange(Math.round(player.maxHP() * 0.01), false);
    }

    public function WeaponFlyingSwordsStatusProcs():void {
		var bleed:Boolean = false;
        var bleedChance:int = 10;
		if (player.weaponFlyingSwords == weaponsflyingswords.MOONLGT) bleedChance += 15;
		if (player.weaponFlyingSwords == weaponsflyingswords.ASAUCHI) bleedChance -= 5;
        if (monster.hasPerk(PerkLib.EnemyConstructType) || monster.hasPerk(PerkLib.EnemyPlantType) || monster.hasPerk(PerkLib.EnemyGooType)) bleedChance = 0;
        if (rand(100) < bleedChance) bleed = true;
        if (bleed) {
            if (monster.hasPerk(PerkLib.EnemyConstructType)) {
                if (monster is LivingStatue) outputText("Despite the rents you've torn in its stony exterior, the statue does not bleed.");
                else outputText("Despite the gashes you've torn in its exterior, [monster a] [monster name] does not bleed.");
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
        if (player.shield == shields.SPIL_SH || player.shield == shields.SPIH_SH || player.shield == shields.SPIM_SH || (player.shield == shields.AETHERS && player.weapon == weapons.AETHERD && AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets")) bleedChance += 50;
		if (monster.hasPerk(PerkLib.EnemyConstructType) || monster.hasPerk(PerkLib.EnemyPlantType) || monster.hasPerk(PerkLib.EnemyGooType)) bleedChance = 0;
        if (rand(100) < bleedChance) bleed = true;
		if (bleed) {
			if (monster.hasStatusEffect(StatusEffects.HemorrhageShield)) monster.addStatusValue(StatusEffects.HemorrhageShield, 1, 2);
			else monster.createStatusEffect(StatusEffects.HemorrhageShield, 2, 0.01, 0, 0);
            if (player.shield == shields.SPIH_SH) monster.addStatusValue(StatusEffects.HemorrhageShield, 2, 0.01);
            if (player.shield == shields.SPIM_SH) monster.addStatusValue(StatusEffects.HemorrhageShield, 2, 0.04);
			if (monster.plural) outputText("\n[Themonster] bleed profusely from the many bloody gashes your [shield] leave behind.");
            else outputText("\n[Themonster] bleeds profusely from the many bloody gashes your [shield] leave behind.");
		}
	}

    public function ArmorStatusProcs():void {
		var bleed:Boolean = false;
        var bleedChance:int = 0;
		//xx% bleed chance

		if (monster.hasPerk(PerkLib.EnemyConstructType) || monster.hasPerk(PerkLib.EnemyPlantType) || monster.hasPerk(PerkLib.EnemyGooType)) bleedChance = 0;
        if (rand(100) < bleedChance) bleed = true;
		if (bleed) {
			if (monster.hasStatusEffect(StatusEffects.HemorrhageArmor)) monster.addStatusValue(StatusEffects.HemorrhageArmor, 1, 2);
			else monster.createStatusEffect(StatusEffects.HemorrhageArmor, 2, 0.01, 0, 0);
			if (monster.plural) outputText("\n[Themonster] bleed profusely from the many bloody gashes your [armor] left behind.");
            else outputText("\n[Themonster] bleeds profusely from the many bloody gashes your [armor] left behind.");
		}
    }

	public function WrathGenerationPerHit(damage:int = 0):void {
		if (damage > 0) {
			var generatedWrath:Number = 0;
			generatedWrath += damage / 10;
			generatedWrath = Math.sqrt(generatedWrath);
			generatedWrath = Math.round(generatedWrath);
			if (generatedWrath > 0) EngineCore.WrathChange(generatedWrath, false);
		}
	}

	public function WrathGenerationPerHit1(damage:int = 0):void {	//base melee/range attacks wrath generation
		var addedWrath:Number = damage;
		if (player.hasPerk(PerkLib.FuriousStrikes)) addedWrath *= 3;
		if (player.hasPerk(PerkLib.UnlimitedRage)) addedWrath *= 3;
		if (player.hasPerk(PerkLib.ImprovedAdrenaline)) addedWrath += Math.round(player.maxWrath() * 0.02);
		if (player.hasPerk(PerkLib.PrestigeJobBerserker)) addedWrath += Math.round(player.maxWrath() * 0.01);
		EngineCore.WrathChange(addedWrath, false);
	}
	public function WrathGenerationPerHit2(damage:int = 0):void {	//specials wrath generation
		var addedWrath:Number = damage;
		if (player.hasPerk(PerkLib.FuriousStrikes)) addedWrath *= 3;
		if (player.hasPerk(PerkLib.UnlimitedRage)) addedWrath *= 3;
		if (player.hasPerk(PerkLib.ImprovedAdrenaline)) addedWrath += Math.round(player.maxWrath() * 0.02);
		if (player.hasPerk(PerkLib.PrestigeJobBerserker)) addedWrath += Math.round(player.maxWrath() * 0.01);
		EngineCore.WrathChange(addedWrath, false);
	}
	public function PASPAS():Number {
		var PAS:Number = 0.5;
		var Wr100:Number = player.wrath100;
		if (Wr100 > 100) Wr100 = 100;
		PAS += Wr100 * 0.02;
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
            if (player.wrath >= 1) player.wrath -= 1;
            else {
                player.takePhysDamage(10);
                if (player.HP <= player.minHP()) {
                    doNext(endHpLoss);
                    return;
                }
            }
        }
        if (player.isDualLowGradeWrathWeapon()) {
            if (player.wrath >= 2) player.wrath -= 2;
            else {
                player.takePhysDamage(20);
                if (player.HP <= player.minHP()) {
                    doNext(endHpLoss);
                }
            }
        }
        if (player.isDualMidGradeWrathWeapon()) {
            if (player.wrath >= 4) player.wrath -= 4;
            else {
                player.takePhysDamage(40);
                if (player.HP <= player.minHP()) {
                    doNext(endHpLoss);
                }
            }
        }
    }

    public function heroBaneProc(damage:int = 0):void {
        if (player.hasStatusEffect(StatusEffects.HeroBane)) {
            if (damage > 0) {
                outputText("\nYou feel [monster a] [monster name]'s wounds as well as your own. The link mirrors the creature's pain back to you. " + damage + " damage!\n");
                player.takePhysDamage(damage);
            }
            if (player.HP <= player.minHP()) {
                doNext(endHpLoss);
            }
        }
    }

    public function heroBaneProc2():void {
        if (flags[kFLAGS.HERO_BANE_DAMAGE_BANK] > 0) {
            outputText("\nYou feel [monster a] [monster name]'s wounds as well as your own. The link mirrors the creature's pain back to you. " + flags[kFLAGS.HERO_BANE_DAMAGE_BANK] + " damage!\n");
            player.takePhysDamage(flags[kFLAGS.HERO_BANE_DAMAGE_BANK]);
            flags[kFLAGS.HERO_BANE_DAMAGE_BANK] = 0;
        }
        if (player.HP <= player.minHP()) {
            doNext(endHpLoss);
        }
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

    public function combatMiss():Boolean {
        return player.spe - monster.spe > 0 && int(Math.random() * (((player.spe - monster.spe) / 4) + 80)) > 80;
    }

    public function combatParry():Boolean {
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
            if (player.hasPerk(PerkLib.BladeBarrier) && (player.weaponSpecials("Dual") || player.weaponSpecials("Dual Large"))) parryChance2 += 15;
        }
		if (player.hasPerk(PerkLib.OrthodoxDuelist) && player.isDuelingTypeWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) {
			if (player.spe <= 100) parryChance2 += player.spe / 10;
            else parryChance2 += 10;
		}
		if (player.hasPerk(PerkLib.KnightlySword) && player.isSwordTypeWeapon() && player.isShieldsForShieldBash()) parryChance2 += 15;
		if (player.weaponSpecials("Massive")) parryChance2 += 5;
        if (player.weaponName == "Undefeated King's Destroyer") parryChance2 += 15;
        if (player.hasPerk(PerkLib.DexterousSwordsmanship)) parryChance2 += 10;
        if (player.hasPerk(PerkLib.CatchTheBlade) && player.spe >= 50 && player.shieldName == "nothing" && player.isFistOrFistWeapon()) parryChance2 += 15;
        if (player.hasPerk(PerkLib.Backlash) && player.shieldName == "nothing" && player.isFistOrFistWeapon()) parryChance2 += 5;
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
        if (player.hasPerk(PerkLib.Blademaster) && player.isNotHavingShieldCuzPerksNotWorkingOtherwise() && (player.isSwordTypeWeapon() || player.isDuelingTypeWeapon() || player.isAxeTypeWeapon() || player.isDaggerTypeWeapon())) critPChance += 5;
        if (player.hasPerk(PerkLib.GrandBlademaster) && player.isNotHavingShieldCuzPerksNotWorkingOtherwise() && (player.isSwordTypeWeapon() || player.isDuelingTypeWeapon() || player.isAxeTypeWeapon() || player.isDaggerTypeWeapon())) critPChance += 15;
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
		if (player.hasPerk(PerkLib.DivineArmament) && player.isUsingStaff() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) blockChance += 10;
		if (player.hasStatusEffect(StatusEffects.Aegis)) blockChance += player.statusEffectv1(StatusEffects.Aegis);
        if (blockChance < 10) blockChance = 10;
        //Wrath limit
		var wrathShieldSize:int = 6;
		if (player.shieldPerk == "Large") wrathShieldSize += 4;
		if (player.shieldPerk == "Massive") wrathShieldSize += 4;
        if (blockChance >= (rand(100) + 1) && player.wrath >= wrathShieldSize && player.shieldName != "nothing" && player.isShieldsForShieldBash()) {// && player.weaponRange != weaponsrange.M1CERBE
            if (doFatigue) {
                if (player.hasPerk(PerkLib.ShieldGrandmastery) && player.tou >= 100) EngineCore.WrathChange((wrathShieldSize * 0.5), true);
                else EngineCore.WrathChange(wrathShieldSize, true);
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
		if (player.hasPerk(PerkLib.DivineArmament) && player.isUsingStaff() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) blockChance2 += 10;
		if (player.hasStatusEffect(StatusEffects.Aegis)) blockChance2 += player.statusEffectv1(StatusEffects.Aegis);
        if (blockChance2 < 10) blockChance2 = 10;
        //if (player.weaponRange == weaponsrange.M1CERBE) blockChance2 = 0;
        return blockChance2;
    }

// DamageOverhaul calculation
    /*
	public function DamageOverhaul(damage:Number):Number {
        /* From here will be XWOLKX's alpha damage overhaul for melee sh*t coding
	 * Base idea:
	 * damage varies from 15% to 115%
	 * Lower threshold scailing from wis up to 10%
	 * Upper threshold scailing from int up to 10%
	 * Speed difference add roll for random
	 * If player.spe > monster.spe => roll for greater multiplier
	 * else roll for worser
	 *//*
        if (flags[kFLAGS.MELEE_DAMAGE_OVERHAUL] == 1) {
            var higher_threshold:Number = 105; // base highest damage multiplier value that deal player
            var lower_threshold:Number = 55; // base lowest
            var percent:Number;
            var times:int = 1;
            var lock:Boolean = false; // when false - enemy SPE greater
            // threshold math
            if (isBowDamageMDO) {
                lower_threshold = 25;
                higher_threshold = 125;
            } // Bow damage would have higher difference than melee.
            percent = player.spe / 100; // this var is needed for comprehension Player SPE and Monster SPE in % difference
            percent = Math.round(monster.spe / percent) - 100; // this operation give us info how bigger/smaller monster SPE in comprehension with player SPE
            if (percent > 20) {
                lower_threshold -= (percent - 20); // if Monster SPE higher, then we deal more likely weak damage
            } else {
                lower_threshold += (percent - 20); // if Monster SPE lower, then we deal more likely good damage
            }
            if ((lower_threshold < 15) && (!isBowDamageMDO)) { // Lowest possible value for melee
                lower_threshold = 15;
                if ((lower_threshold < 10) && (isBowDamageMDO)) // Lowest possible value for bow
                    lower_threshold = 10;
            }
            // applying stats modificators for thresholds
            if (player.wis >= 190) {
                lower_threshold += 10; // written value is how much you want to boost damage by wis
            } else {
                lower_threshold += Math.round(player.wis / 20) // + percent damage per 20 wis
            }
            if (player.inte >= 285) {
                higher_threshold += 10; // written value is how much you want to boost damage by int
            } else {
                higher_threshold += Math.round(player.inte / 30) // + percent damage per 30 int
            }
            if (player.level > monster.level) lower_threshold++;
            if (lower_threshold > 95) { // We still need some random space
                lower_threshold = 95;
            }
            // multiplier math
            /* outputText(percent.toString());
	outputText("    ");  for test only*//*
            if (percent != 0) {
                if (percent < 0) {
                    percent *= (-1);
                    lock = true; // that means that our speed greater then monsters
                }
                times = int(Math.round(percent / 15)); // how many times damage would be rolled
            }
            if (times > 7) times = 7; // roll times limit
            var random_value:Number = Math.round(Math.random() * (higher_threshold - lower_threshold)) + lower_threshold; // roll multiplier from lower to higher threshold
            for (var i:int = 1; i < times; i++) // rolling higher / lower value
            {
                var b:Number = Math.round(Math.random() * (higher_threshold - lower_threshold)) + lower_threshold;
                if (lock) { // we would deal greater damage
                    if ((random_value < b) && (Math.round(Math.random() * (times * 2 / 3)) == Math.round(times * 2 / 6))) {  // formula for random multiplier calculation. If you don't like results - use another one. This one give us some-like exponential distribution when <times> rises up tp 7 and uniform distribution when <times> = 1
                        random_value = b;
                    }
                } else // we would deal worse damage
                if ((random_value > b) && (Math.round(Math.random() * (times * 2 / 3)) == Math.round(times * 2 / 6))) {
                    random_value = b;
                }
            }
            function firstLetterUpperCase(strData:String):String  // for text
            {
                var strArray:Array = strData.split(' ');
                var newArray:Array = [];
                for (var str:String in strArray) {
                    newArray.push(strArray[str].charAt(0).toUpperCase() + strArray[str].slice(1));
                }
                return newArray.join(' ');
            }
            // damage dialogs for just attack
            if ((MDODialogs) && (!isBowDamageMDO) && (MDOCount == 1)) {
                if (lock) {
                    if (percent > 30) {
                        if (random_value <= 20) outputText("Due to your recklessness, you barely hit [monster a] [monster name]. ");
                        if ((random_value > 20) && (random_value <= 40)) outputText("You underestimated [monster a] [monster name]'s moves, your [weapon] grazing your foe. ");
                        if ((random_value > 40) && (random_value <= 70)) outputText("As you swing your [weapon] down at [monster a] [monster name], they dodge back. your [weapon] cracks the ground below. [monster a] [monster name] was very lucky they didn't take that hit! ");
                        if ((random_value > 70) && (random_value <= 85)) outputText("You rush towards your foe. " + firstLetterUpperCase("[monster a]") + " [monster name] trying to parry your strike, but it's not enough to stop your hard blow! ");
                        if ((random_value > 85) && (random_value <= 100)) outputText("Your foe watches you coming closer, trying to dodge. You move so fast that [monster a] [monster name] doesn't have time to react to your powerful strike! ");
                        if ((random_value > 100) && (random_value < higher_threshold)) outputText("As you watch [monster a] [monster name] recoils. Time seems to slow, and you bat aside your foe's clumsy block, landing a hard blow into their vitals.");
                        if (random_value == higher_threshold) outputText("You crush their defenses, landing a deadly blow on [monster a] [monster name]! ");
                    }
                }
                if (percent <= 30) {
                    if (random_value <= 20) outputText("[monster a] [monster name] feints, and you fall for it, your [weapon] missing outright. ");
                    if ((random_value > 20) && (random_value <= 40)) outputText("You underestimated [monster a] [monster name]'s moves and just slighty wounded your foe. "); // copy-pasta
                    if ((random_value > 40) && (random_value <= 70)) outputText(" [monster a] [monster name] dodges your first strike handily, but their movements unbalance them, and you rush in. Your next swing lands solidly! ");
                    if ((random_value > 70) && (random_value <= 85)) outputText("You hit [monster a] [monster name]! "); // default one, sorry :D
                    if ((random_value > 85) && (random_value <= 100)) outputText("Predicting [monster a] [monster name] moves, you strike a powerful blow! ");
                    if ((random_value > 100) && (random_value < higher_threshold)) outputText("Your mighty blow made [monster a] [monster name] stagger for a moment! ");
                    if (random_value == higher_threshold) outputText("Nimbly shortening the distance, you hit [monster a] [monster name] with overwhelming power! ");
                } else if (!lock) {
                    if (random_value <= 20) outputText("You hit your opponent, but the [monster a] [monster name] catches the blow handily, rendering your blow useless. ");
                    if ((random_value > 20) && (random_value <= 40)) outputText("You hit [monster a] [monster name], but [monster.pronoun1] moves with the blow. It lands, but most of the impact is gone. ");
                    if ((random_value > 40) && (random_value <= 70)) outputText("As you hurtle toward [monster a] [monster name], you ready your [weapon] and prepare to hit. Getting close enough, you swing and crush your [weapon] onto [monster.pronoun2]. The [monster.pronoun1] wasn't able to evade your attack! ");
                    if ((random_value > 70) && (random_value <= 85)) outputText("You take your [weapon] in steady grip of your hands and widely swing at the foe. " + firstLetterUpperCase("[monster a]") + " [monster name] predicted your attack, but you manage to ajdust, landing the blow anyway. ");
                    if ((random_value > 85) && (random_value <= 100)) outputText("You miraculously reflected [monster a] [monster name] attack and did riposte to [monster.pronoun2]! ");
                    if ((random_value > 100) && (random_value < higher_threshold)) outputText("With a sudden burst of adrenaline, you managed to get inside their guard, landing several hard blows on [monster a] [monster name]! ");
                    if (random_value == higher_threshold) outputText("You found a gap in [monster a] [monster name]'s defence. You block a strike, then take advantage of the opening. Your [weapon] lands a devastating blow, right in their weak point! ");
                }
            }
            random_value /= 100; // back to %
            // damage math
            damage *= random_value;
            damage = Math.round(damage);
            isBowDamageMDO = false;
        }
        return damage;
        // outputText(random_value.toString()); for test only
        // End of overhaul and of sh*t coding
    }
	*/
	public function DamageOverhaul(damage:Number):Number {
        /* From here will be XWOLKX's alpha damage overhaul for melee sh*t coding
	 * Base idea:
	 * damage varies from 15% to 115%
	 * Lower threshold scailing from wis up to 10%
	 * Upper threshold scailing from int up to 10%
	 * Speed difference add roll for random
	 * If player.spe > monster.spe => roll for greater multiplier
	 * else roll for worser
	 */
        if (flags[kFLAGS.MELEE_DAMAGE_OVERHAUL] == 1) {
            var higher_threshold:Number = 105; // base highest damage multiplier value that deal player
            var lower_threshold:Number = 55; // base lowest
            var speed_difference:Number = player.spe - monster.spe;
            // threshold math
            if (isBowDamageMDO) {
                lower_threshold = 35;
                higher_threshold = 125;
            } // Bow damage would have higher difference than melee.
            //speed_difference;
            if (speed_difference < 0) {
                lower_threshold += Math.max(-20, Math.round(speed_difference/10));
            } else {
                lower_threshold += Math.min(20, Math.round(speed_difference/10));
                if (speed_difference > 200) {
                    higher_threshold += Math.round((speed_difference-200)/50);
                }
            }
            // applying stats modificators for thresholds
            lower_threshold += Math.min(10, Math.round(player.wis / 20)); // + percent damage per 20 wis, maximum at 200 wis
            higher_threshold += Math.min(10, Math.round(player.inte / 30)); // + percent damage per 30 int, maximum at 300 int
            if (player.level > monster.level) lower_threshold += Math.min(10, player.level - monster.level); // More reliable damage against lower level foes
            lower_threshold = Math.min(95, lower_threshold); // Maximum lower threshold is 95%
            // multiplier math
            /* outputText(percent.toString());
	outputText("    ");  for test only*/
            var random_value:Number = Math.round(Math.random() * (higher_threshold - lower_threshold)) + lower_threshold; // roll multiplier from lower to higher threshold

            function firstLetterUpperCase(strData:String):String  // for text
            {
                var strArray:Array = strData.split(' ');
                var newArray:Array = [];
                for (var str:String in strArray) {
                    newArray.push(strArray[str].charAt(0).toUpperCase() + strArray[str].slice(1));
                }
                return newArray.join(' ');
            }
            // damage dialogs for just attack
            if ((MDODialogs) && (!isBowDamageMDO) && (MDOCount == 1)) {
                if (speed_difference > 200) {
                    if (random_value <= 20) outputText("Due to your recklessness, your strike is poorly aimed, missing [monster a] [monster name]. ");
                    if ((random_value > 20) && (random_value <= 40)) outputText("You underestimated [monster a] [monster name]'s moves, your [weapon] grazing your foe. ");
                        if ((random_value > 40) && (random_value <= 70)) outputText("As you swing your [weapon] down at [monster a] [monster name], they dodge back. your [weapon] cracks the ground below. [monster a] [monster name] was very lucky they didn't take that hit! ");
                        if ((random_value > 70) && (random_value <= 85)) outputText("You rush towards your foe. " + firstLetterUpperCase("[monster a]") + " [monster name] trying to parry your strike, but it's not enough to stop your hard blow! ");
                        if ((random_value > 85) && (random_value <= 100)) outputText("Your foe watches you coming closer, trying to dodge. You move so fast that [monster a] [monster name] doesn't have time to react to your powerful strike! ");
                        if ((random_value > 100) && (random_value < higher_threshold)) outputText("As you watch [monster a] [monster name] recoils. Time seems to slow, and you bat aside your foe's clumsy block, landing a hard blow into their vitals.");
                        if (random_value == higher_threshold) outputText("You crush their defenses, landing a deadly blow on [monster a] [monster name]! ");
                } else if (speed_difference >= 0) {
                    if (random_value <= 20) outputText("[monster a] [monster name] feints, and you fall for it, your [weapon] missing outright. ");
                    if ((random_value > 20) && (random_value <= 40)) outputText("You underestimated [monster a] [monster name]'s moves and just slighty wounded your foe. "); // copy-pasta
                    if ((random_value > 40) && (random_value <= 70)) outputText(" [monster a] [monster name] dodges your first strike handily, but their movements unbalance them, and you rush in. Your next swing lands solidly! ");
                    if ((random_value > 70) && (random_value <= 85)) outputText("You hit [monster a] [monster name]! "); // default one, sorry :D
                    if ((random_value > 85) && (random_value <= 100)) outputText("Predicting [monster a] [monster name] moves, you strike a powerful blow! ");
                    if ((random_value > 100) && (random_value < higher_threshold)) outputText("Your mighty blow made [monster a] [monster name] stagger for a moment! ");
                    if (random_value == higher_threshold) outputText("Nimbly shortening the distance, you hit [monster a] [monster name] with overwhelming power! ");
                } else  {
                    if (random_value <= 20) outputText("You hit your opponent, but the [monster a] [monster name] catches the blow handily, rendering your blow useless. ");
                    if ((random_value > 20) && (random_value <= 40)) outputText("You hit [monster a] [monster name], but [monster.pronoun1] moves with the blow. It lands, but most of the impact is gone. ");
                    if ((random_value > 40) && (random_value <= 70)) outputText("As you hurtle toward [monster a] [monster name], you ready your [weapon] and prepare to hit. Getting close enough, you swing and crush your [weapon] onto [monster.pronoun2]. The [monster.pronoun1] wasn't able to evade your attack! ");
                    if ((random_value > 70) && (random_value <= 85)) outputText("You take your [weapon] in steady grip of your hands and widely swing at the foe. " + firstLetterUpperCase("[monster a]") + " [monster name] predicted your attack, but you manage to ajdust, landing the blow anyway. ");
                    if ((random_value > 85) && (random_value <= 100)) outputText("You miraculously reflected [monster a] [monster name] attack and did riposte to [monster.pronoun2]! ");
                    if ((random_value > 100) && (random_value < higher_threshold)) outputText("With a sudden burst of adrenaline, you managed to get inside their guard, landing several hard blows on [monster a] [monster name]! ");
                    if (random_value == higher_threshold) outputText("You found a gap in [monster a] [monster name]'s defence. You block a strike, then take advantage of the opening. Your [weapon] lands a devastating blow, right in their weak point! ");
                }
            }
            random_value /= 100; // back to %
            // damage math
            damage *= random_value;
            damage = Math.round(damage);
            isBowDamageMDO = false;
        }
        return damage;
        // outputText(random_value.toString()); for test only
        // End of overhaul and of sh*t coding
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
		if (player.hasPerk(PerkLib.EyesOfTheHunterEx) && player.sens >= 30) {
			if (player.sens >= 450) playerLevelAdjustment += 30;
			else playerLevelAdjustment += 1 * Math.round((player.sens - 25) / 25);
		}
        return playerLevelAdjustment;
    }

    public function monsterLevelAdjustment():Number {
        var monsterLvlAdjustment:Number = 0;
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

    public function MonsterIsBleeding():Boolean {
        var isBleeding:Boolean = false;
        if (monster.hasStatusEffect(StatusEffects.KamaitachiBleed)) isBleeding = true;
        if (monster.hasStatusEffect(StatusEffects.Hemorrhage)) isBleeding = true;
        if (monster.hasStatusEffect(StatusEffects.SharkBiteBleed)) isBleeding = true;
        if (monster.hasStatusEffect(StatusEffects.IzmaBleed)) isBleeding = true;
        return isBleeding;
    }

    //DEAL DAMAGE
    public function doDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
		if (damage < 1) damage = 1;
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
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
        if (monster.hasStatusEffect(StatusEffects.AcidDoT)) {
            if (monster.statusEffectv3(StatusEffects.AcidDoT) > 0) damage *= (1 + (0.3 * monster.statusEffectv3(StatusEffects.AcidDoT)));
            if (monster.statusEffectv4(StatusEffects.AcidDoT) > 0) damage *= (1 + (0.1 * monster.statusEffectv4(StatusEffects.AcidDoT)));
        }
		if (monster.hasStatusEffect(StatusEffects.Provoke)) damage *= monster.statusEffectv2(StatusEffects.Provoke);
		if (player.hasPerk(PerkLib.KnowledgeIsPower)) {
			if (player.hasPerk(MutationsLib.RatatoskrSmartsEvolved)) damage *= (1 + (Math.round(codex.checkUnlocked() / 100) * 3));
			else damage *= (1 + Math.round(codex.checkUnlocked() / 100));
		}
		if (player.hasPerk(PerkLib.SharedPower) && player.perkv1(PerkLib.SharedPower) > 0) damage *= (1+(0.1*player.perkv1(PerkLib.SharedPower)));
		damage *= EyesOfTheHunterDamageBonus();
        damage = DamageOverhaul(damage);
		if (monster.hasPerk(PerkLib.EnemyGhostType)) damage = 0;
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
            monster.HP -= damage;
			var WrathGains:Number = 0;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) WrathGains += Math.round((damage / 5)*BonusWrathMult);
            else WrathGains += Math.round((damage / 10) * BonusWrathMult);
			if ((monster.hasStatusEffect(StatusEffects.CouatlHurricane) || monster.hasStatusEffect(StatusEffects.IzmaBleed) || monster.hasStatusEffect(StatusEffects.SharkBiteBleed)
			 || monster.hasStatusEffect(StatusEffects.KamaitachiBleed) || monster.hasStatusEffect(StatusEffects.GoreBleed)
			 || monster.hasStatusEffect(StatusEffects.Hemorrhage) || monster.hasStatusEffect(StatusEffects.HemorrhageArmor)
			 || monster.hasStatusEffect(StatusEffects.HemorrhageShield) || monster.hasStatusEffect(StatusEffects.Hemorrhage2))
			 && player.hasPerk(PerkLib.YourPainMyPower)) {
				player.HP += damage;
				if (player.HP > (player.maxHP() + player.maxOverHP())) player.HP = player.maxHP() + player.maxOverHP();
				EngineCore.WrathChange(WrathGains, false);
			}
			else monster.wrath += WrathGains;
            if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
        }
        if (display) {
            if (damage > 0) {
                if (damage > 1000) CommasForDigits(damage);
                else outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
            } else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
            else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
        }
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doPhysicalDamage(damage:Number, apply:Boolean = true, display:Boolean = false):void {
        if (player.hasPerk(MutationsLib.SharkOlfactorySystem) && MonsterIsBleeding()) damage *= 1.1;
        if (player.hasPerk(MutationsLib.SharkOlfactorySystemPrimitive) && MonsterIsBleeding()) damage *= 1.15;
        if (player.hasPerk(MutationsLib.SharkOlfactorySystemEvolved) && MonsterIsBleeding()) damage *= 1.25;
        doDamage(damage, apply, display);
    }

    public function doMinionPhysDamage(damage:Number, apply:Boolean = true, display:Boolean = false):void {
        doDamage(damage, apply, display);
    }

    public function doMagicDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
		if (damage < 1) damage = 1;
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            dynStats("lus", 3);
            if (player.armorName == "Scandalous Succubus Clothing") {
                damage *= 1.2;
                dynStats("lus", 3);
            }
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
        if (monster.hasStatusEffect(StatusEffects.AcidDoT)) damage *= (1 + (0.3 * monster.statusEffectv3(StatusEffects.AcidDoT)));
		if (monster.hasStatusEffect(StatusEffects.Provoke)) damage *= monster.statusEffectv2(StatusEffects.Provoke);
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
		damage *= EyesOfTheHunterDamageBonus();
        damage = DamageOverhaul(damage);
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
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
        }
        if (display) {
            if (damage > 0) {
                if (damage > 1000) CommasForDigits(damage);
                else outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
            } else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
            else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
        }
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doFireDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
		if (damage < 1) damage = 1;
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            dynStats("lus", 3);
            if (player.armorName == "Scandalous Succubus Clothing") {
                damage *= 1.2;
                dynStats("lus", 3);
            }
        }
		if (player.weapon == weapons.R_STAFF) damage *= 1.4;
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
		if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.925;
        if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
        if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
        if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
        if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
        if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 2;
        if (player.hasStatusEffect(StatusEffects.YukiOnnaKimono)) damage *= 0.2;
        if (player.hasPerk(PerkLib.WalpurgisIzaliaRobe)) damage *= 2;
        if (player.hasPerk(PerkLib.IceQueenGown)) damage = damage / 100;
		damage *= EyesOfTheHunterDamageBonus();
        damage = DamageOverhaul(damage);
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
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
        }
        if (display) {
            if (damage > 0) {
                if (damage > 1000) CommasForDigits(damage);
                else outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
            } else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
            else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
        }
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        if (monster.hasPerk(PerkLib.HydraRegeneration)) {
            if (monster.short == "Hydra") {
				monster.createStatusEffect(StatusEffects.HydraRegenerationDisabled, 5, 0, 0, 0);
				outputText(" The hydra hisses in anger as her wound cauterised, preventing regeneration. It's the time to strike!");
			}
			if (monster.short == "adult troll male" || monster.short == "adult troll female" || monster.short == "troll" || monster.short == "Zenji") monster.createStatusEffect(StatusEffects.HydraRegenerationDisabled, 2, 0, 0, 0);
        }
        if (monster.hasStatusEffect(StatusEffects.IceArmor)) {
            monster.addStatusValue(StatusEffects.IceArmor, 1, -1);
            outputText(" The icy shield encasing [themonster] begins to melt from the heat.");
        }
        return damage;
    }

    public function doIceDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
		if (damage < 1) damage = 1;
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            dynStats("lus", 3);
            if (player.armorName == "Scandalous Succubus Clothing") {
                damage *= 1.2;
                dynStats("lus", 3);
            }
        }
		if (player.weapon == weapons.S_STAFF) damage *= 1.4;
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
        if (monster.hasStatusEffect(StatusEffects.FrostburnDoT) && monster.statusEffectv3(StatusEffects.FrostburnDoT) > 0) damage *= (1 + (0.5 * monster.statusEffectv3(StatusEffects.FrostburnDoT)));
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
        if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.2;
        if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.5;
        if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 2;
        if (monster.hasPerk(PerkLib.FireNature)) damage *= 5;
        if (monster.hasPerk(PerkLib.IcyFlesh)) damage *= 0.6;
        if (player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
        if (player.hasStatusEffect(StatusEffects.YukiOnnaKimono)) damage *= 1.4;
        if (player.hasPerk(PerkLib.IceQueenGown)) damage *= 2;
        if (player.hasPerk(PerkLib.WalpurgisIzaliaRobe)) damage = damage / 100;
		damage *= EyesOfTheHunterDamageBonus();
        damage = DamageOverhaul(damage);
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
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
        }
        if (display) {
            if (damage > 0) {
                if (damage > 1000) CommasForDigits(damage);
                else outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
            } else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
            else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
        }
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

    public function doLightingDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
		if (damage < 1) damage = 1;
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            dynStats("lus", 3);
            if (player.armorName == "Scandalous Succubus Clothing") {
                damage *= 1.2;
                dynStats("lus", 3);
            }
        }
		if (player.weapon == weapons.T_STAFF) damage *= 1.4;
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
        if (monster.hasPerk(PerkLib.LightningNature)) damage *= 0.2;
        if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 0.5;
        if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 2;
        if (monster.hasStatusEffect(StatusEffects.DragonWaterBreath)) damage *= 5;
        if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 5;
        if (player.hasPerk(PerkLib.LightningAffinity)) damage *= 2;
        if (player.hasPerk(MutationsLib.RaijuCathodePrimitive)) damage *= 1.20;
        if (player.hasPerk(MutationsLib.HeartOfTheStorm)) damage *= 1.1;
        if (player.hasPerk(MutationsLib.HeartOfTheStormPrimitive)) damage *= 1.2;
        if (player.hasPerk(MutationsLib.HeartOfTheStormEvolved)) damage *= 1.3;
        if (player.hasPerk(PerkLib.IceQueenGown)) damage *= 2;
        if (player.hasPerk(PerkLib.WalpurgisIzaliaRobe)) damage = damage / 100;
		damage *= EyesOfTheHunterDamageBonus();
        damage = DamageOverhaul(damage);
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
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
        }
        if (display) {
            if (damage > 0) {
                if (damage > 1000) CommasForDigits(damage);
                else outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
            } else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
            else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
        }
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doDarknessDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
		if (damage < 1) damage = 1;
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            dynStats("lus", 3);
            if (player.armorName == "Scandalous Succubus Clothing") {
                damage *= 1.2;
                dynStats("lus", 3);
            }
        }
		if (player.weapon == weapons.A_STAFF) damage *= 1.4;
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
        if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 0.2;
        if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 0.5;
        if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 2;
        if (monster.hasPerk(PerkLib.LightningNature)) damage *= 5;
        if (player.hasPerk(PerkLib.DarknessAffinity)) damage *= 2;
        if (player.hasPerk(PerkLib.WalpurgisIzaliaRobe)) damage *= 2;
        if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
        if (player.hasPerk(PerkLib.IceQueenGown)) damage = damage / 100;
//	if (player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
		damage *= EyesOfTheHunterDamageBonus();
        damage = DamageOverhaul(damage);
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
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
        }
        if (display) {
            if (damage > 0) {
                if (damage > 1000) CommasForDigits(damage);
                else outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
            } else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
            else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
        }
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doPoisonDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
		if (damage < 1) damage = 1;
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            dynStats("lus", 3);
            if (player.armorName == "Scandalous Succubus Clothing") {
                damage *= 1.2;
                dynStats("lus", 3);
            }
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
        if (monster.hasStatusEffect(StatusEffects.AcidDoT)) damage *= (1 + (0.3 * monster.statusEffectv3(StatusEffects.AcidDoT)));
		if (monster.hasStatusEffect(StatusEffects.Provoke)) damage *= monster.statusEffectv2(StatusEffects.Provoke);
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
		damage *= EyesOfTheHunterDamageBonus();
        damage = DamageOverhaul(damage);
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
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
        }
        if (display) {
            if (damage > 0) {
                if (damage > 1000) CommasForDigits(damage);
                else outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
            } else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
            else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
        }
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doWindDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
		if (damage < 1) damage = 1;
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            dynStats("lus", 3);
            if (player.armorName == "Scandalous Succubus Clothing") {
                damage *= 1.2;
                dynStats("lus", 3);
            }
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
        if (monster.hasStatusEffect(StatusEffects.AcidDoT)) damage *= (1 + (0.3 * monster.statusEffectv3(StatusEffects.AcidDoT)));
		if (monster.hasStatusEffect(StatusEffects.Provoke)) damage *= monster.statusEffectv2(StatusEffects.Provoke);
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
		damage *= EyesOfTheHunterDamageBonus();
        damage = DamageOverhaul(damage);
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
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
        }
        if (display) {
            if (damage > 0) {
                if (damage > 1000) CommasForDigits(damage);
                else outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
            } else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
            else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
        }
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doWaterDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
		if (damage < 1) damage = 1;
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            dynStats("lus", 3);
            if (player.armorName == "Scandalous Succubus Clothing") {
                damage *= 1.2;
                dynStats("lus", 3);
            }
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
        if (monster.hasStatusEffect(StatusEffects.AcidDoT)) damage *= (1 + (0.3 * monster.statusEffectv3(StatusEffects.AcidDoT)));
		if (monster.hasStatusEffect(StatusEffects.Provoke)) damage *= monster.statusEffectv2(StatusEffects.Provoke);
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
		damage *= EyesOfTheHunterDamageBonus();
        damage = DamageOverhaul(damage);
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
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
        }
        if (display) {
            if (damage > 0) {
                if (damage > 1000) CommasForDigits(damage);
                else outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
            } else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
            else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
        }
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doEarthDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
		if (damage < 1) damage = 1;
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            dynStats("lus", 3);
            if (player.armorName == "Scandalous Succubus Clothing") {
                damage *= 1.2;
                dynStats("lus", 3);
            }
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
        if (monster.hasStatusEffect(StatusEffects.AcidDoT)) damage *= (1 + (0.3 * monster.statusEffectv3(StatusEffects.AcidDoT)));
		if (monster.hasStatusEffect(StatusEffects.Provoke)) damage *= monster.statusEffectv2(StatusEffects.Provoke);
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
		damage *= EyesOfTheHunterDamageBonus();
        damage = DamageOverhaul(damage);
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
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
        }
        if (display) {
            if (damage > 0) {
                if (damage > 1000) CommasForDigits(damage);
                else outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
            } else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
            else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
        }
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

    public function doAcidDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        damage *= doDamageReduction();
		if (damage < 1) damage = 1;
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
        if (player.hasPerk(PerkLib.Sadist)) {
            damage *= 1.2;
            dynStats("lus", 3);
            if (player.armorName == "Scandalous Succubus Clothing") {
                damage *= 1.2;
                dynStats("lus", 3);
            }
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
        if (monster.hasStatusEffect(StatusEffects.AcidDoT)) damage *= (1 + (0.3 * monster.statusEffectv3(StatusEffects.AcidDoT)));
		if (monster.hasStatusEffect(StatusEffects.Provoke)) damage *= monster.statusEffectv2(StatusEffects.Provoke);
        if (monster.hasPerk(PerkLib.TrollResistance)) damage *= 0.85;
		damage *= EyesOfTheHunterDamageBonus();
        damage = DamageOverhaul(damage);
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
            monster.HP -= damage;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) monster.wrath += Math.round((damage / 5)*BonusWrathMult);
            else monster.wrath += Math.round((damage / 10)*BonusWrathMult);
            if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
        }
        if (display) {
            if (damage > 0) {
                if (damage > 1000) CommasForDigits(damage);
                else outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
            } else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
            else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
        }
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
    }

	public function doTrueDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
        MDOCount++; // for multipile attacks to prevent stupid repeating of damage messages
        if (damage < 1) damage = 1;
        if (monster.hasStatusEffect(StatusEffects.TranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.TranscendentSoulField));
        if (monster.hasStatusEffect(StatusEffects.ATranscendentSoulField)) damage *= (1 / monster.statusEffectv1(StatusEffects.ATranscendentSoulField));
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
        if (monster.hasStatusEffect(StatusEffects.AcidDoT)) {
            if (monster.statusEffectv3(StatusEffects.AcidDoT) > 0) damage *= (1 + (0.3 * monster.statusEffectv3(StatusEffects.AcidDoT)));
            if (monster.statusEffectv4(StatusEffects.AcidDoT) > 0) damage *= (1 + (0.1 * monster.statusEffectv4(StatusEffects.AcidDoT)));
        }
		if (monster.hasStatusEffect(StatusEffects.Provoke)) damage *= monster.statusEffectv2(StatusEffects.Provoke);
		if (player.hasPerk(PerkLib.KnowledgeIsPower)) {
			if (player.hasPerk(MutationsLib.RatatoskrSmartsEvolved)) damage *= (1 + (Math.round(codex.checkUnlocked() / 100) * 3));
			else damage *= (1 + Math.round(codex.checkUnlocked() / 100));
		}
		damage *= EyesOfTheHunterDamageBonus();
        damage = DamageOverhaul(damage);
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
            monster.HP -= damage;
			var WrathGains:Number = 0;
            var BonusWrathMult:Number = 1;
            if (monster.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult = 1.20;
            if (monster.hasPerk(PerkLib.FuelForTheFire)) WrathGains += Math.round((damage / 5)*BonusWrathMult);
            else WrathGains += Math.round((damage / 10) * BonusWrathMult);
			if ((monster.hasStatusEffect(StatusEffects.CouatlHurricane) || monster.hasStatusEffect(StatusEffects.IzmaBleed) || monster.hasStatusEffect(StatusEffects.SharkBiteBleed)
			 || monster.hasStatusEffect(StatusEffects.KamaitachiBleed) || monster.hasStatusEffect(StatusEffects.GoreBleed)
			 || monster.hasStatusEffect(StatusEffects.Hemorrhage) || monster.hasStatusEffect(StatusEffects.HemorrhageArmor)
			 || monster.hasStatusEffect(StatusEffects.HemorrhageShield) || monster.hasStatusEffect(StatusEffects.Hemorrhage2))
			 && player.hasPerk(PerkLib.YourPainMyPower)) {
				player.HP += damage;
				if (player.HP > (player.maxHP() + player.maxOverHP())) player.HP = player.maxHP() + player.maxOverHP();
				EngineCore.WrathChange(WrathGains, false);
			}
			else monster.wrath += WrathGains;
            if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
        }
        if (display) {
            if (damage > 0) {
                if (damage > 1000) CommasForDigits(damage);
                else outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
            } else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
            else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
        }
        //Interrupt gigaflare if necessary.
        if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
        //Keep shit in bounds.
        if (monster.HP < monster.minHP()) monster.HP = monster.minHP();
        return damage;
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

    //Modify mana (mod>0 - subtract, mod<0 - regen)
    public function useManaImpl(mod:Number, type:int = USEMANA_NORMAL):void {
        //Spell reductions
        switch (type) {
            case USEMANA_MAGIC:
            case USEMANA_MAGIC_NOBM:
                mod = spellCost(mod);
                break;
			case USEMANA_GREY:
			case USEMANA_GREY_NOBM:
				mod = spellCostGrey(mod);
				break;
            case USEMANA_WHITE:
            case USEMANA_WHITE_NOBM:
                mod = spellCostWhite(mod);
                break;
            case USEMANA_BLACK:
            case USEMANA_BLACK_NOBM:
                mod = spellCostBlack(mod);
                break;
            case USEMANA_MAGIC_HEAL:
                mod = healCost(mod);
                break;
            case USEMANA_WHITE_HEAL:
                mod = healCostWhite(mod);
                break;
            case USEMANA_BLACK_HEAL:
                mod = healCostBlack(mod);
                break;
        }
        //Blood mages use HP for spells
        var damage:Number;
        if (player.hasStatusEffect(StatusEffects.DarkRitual)) {
            damage = player.maxHP() * 0.1;
            player.takePhysDamage(damage);
            //statScreenRefresh();
        }
        if (mod < 0) {
            mod *= manaRecoveryMultiplier();
        }
        player.mana = boundFloat(0, player.mana - mod, player.maxMana());
        if (mod < 0) {
            mainView.statsView.showStatUp('mana');
        }
        if (mod > 0) {
            mainView.statsView.showStatDown('mana');
        }
        statScreenRefresh();
    }

    public function manaRecoveryMultiplier():Number {
        var multi:Number = 1;
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
        if (player.alicornScore() >= 12) multi += 0.1;
        if (player.kitsuneScore() >= 5) {
            if (player.kitsuneScore() >= 10) multi += 1;
            else multi += 0.5;
        }
        if (player.unicornScore() >= 10) multi += 0.05;
        return multi;
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
        if (player.fatigue >= player.maxFatigue() && mod > 0) return;
        if (player.fatigue <= 0 && mod < 0) return;
        //Fatigue restoration buffs!
        if (mod < 0) {
            mod *= fatigueRecoveryMultiplier();
        }
        player.fatigue += mod;
        if (mod < 0) {
            mainView.statsView.showStatUp('fatigue');
        }
        if (mod > 0) {
            mainView.statsView.showStatDown('fatigue');
        }
        dynStats("lus", 0, "scale", false); //Force display fatigue up/down by invoking zero lust change.
        if (player.fatigue > player.maxFatigue()) player.fatigue = player.maxFatigue();
        if (player.fatigue < 0) player.fatigue = 0;
        statScreenRefresh();
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
        if (player.hasPerk(MutationsLib.TwinHeart)) multi += 0.4;
        if (player.hasPerk(MutationsLib.TwinHeartPrimitive)) multi += 0.4;
        if (player.hasPerk(MutationsLib.TwinHeartEvolved)) multi += 0.4;
        if (player.hasPerk(MutationsLib.TwinHeart) && (player.isTaur() || player.isDrider())) multi += 0.6;
        if (player.hasPerk(MutationsLib.TwinHeartPrimitive) && (player.isTaur() || player.isDrider())) multi += 0.6;
        if (player.hasPerk(MutationsLib.TwinHeartEvolved) && (player.isTaur() || player.isDrider())) multi += 0.6;
        return multi;
    }

//ENEMYAI!
    public function enemyAIImpl():void {
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return;
        }
        monster.doAI();
        if (player.statStore.hasBuff("TranceTransformation")) player.soulforce -= 50;
        if (player.statStore.hasBuff("CrinosShape")) player.wrath -= mspecials.crinosshapeCost();
        if (player.statStore.hasBuff("AsuraForm")) player.wrath -= asuraformCost();
        combatRoundOver();
    }

    public function finishCombat():void {
        var hpVictory:Boolean = monster.HP <= monster.minHP();//monster.HP < 1
        clearOutput();
        if (hpVictory) {
            outputText("You defeat [monster a] [monster name].\n");
        } else {
            outputText("You smile as [monster a] [monster name] collapses and begins masturbating feverishly.");
        }
        cleanupAfterCombat();
    }

    public function dropItem(monster:Monster, nextFunc:Function = null):void {
        if (nextFunc == null) nextFunc = camp.returnToCampUseOneHour;
        if (monster.hasStatusEffect(StatusEffects.NoLoot)) {
            return;
        }
        if (player.hasStatusEffect(StatusEffects.SoulArena)) {
            player.removeStatusEffect(StatusEffects.SoulArena);
            return;
        }
        var itype:ItemType = monster.dropLoot();
        if (monster.short == "tit-fucked Minotaur") {
            itype = consumables.MINOCUM;
        }
        if (monster is Minotaur) {
            if (monster.weaponName == "axe") {
                if (rand(2) == 0) {
                    //50% breakage!
                    if (rand(2) == 0) {
                        itype = weapons.L__AXE;
                        if (player.tallness < 78 && player.str < 90) {
                            outputText("\nYou find a large axe on the minotaur, but it is too big for a person of your stature to comfortably carry.  ");
                            if (rand(2) == 0) itype = null;
                            else itype = consumables.SDELITE;
                        }
                        //Not too tall, dont rob of axe!
                        else CoC.instance.plotFight = true;
                    } else outputText("\nThe minotaur's axe appears to have been broken during the fight, rendering it useless.  ");
                } else itype = consumables.MINOBLO;
            }
        }
        if (monster is BeeGirl) {
            //force honey drop if milked
            if (flags[kFLAGS.FORCE_BEE_TO_PRODUCE_HONEY] == 1) {
                if (rand(2) == 0) itype = consumables.BEEHONY;
                else itype = consumables.PURHONY;
                flags[kFLAGS.FORCE_BEE_TO_PRODUCE_HONEY] = 0;
            }
        }
        if (monster is Jojo && JojoScene.monk > 4) {
            if (rand(2) == 0) itype = consumables.INCUBID;
            else {
                if (rand(2) == 0) itype = consumables.B__BOOK;
                else itype = consumables.SUCMILK;
            }
        }
        if (monster is Harpy || monster is Sophie) {
            if (rand(10) == 0) itype = armors.W_ROBES;
            else if (rand(3) == 0 && player.hasPerk(PerkLib.LuststickAdapted)) itype = consumables.LUSTSTK;
            else itype = consumables.GLDSEED;
        }
        //Chance of armor if at level 1 pierce fetish
        if (!CoC.instance.plotFight && !(monster is Ember) && !(monster is Kiha) && !(monster is Hel) && !(monster is Isabella)
                && flags[kFLAGS.PC_FETISH] == 1 && rand(10) == 0 && !player.hasItem(armors.SEDUCTA, 1) && !SceneLib.ceraphFollowerScene.ceraphIsFollower()) {
            itype = armors.SEDUCTA;
        }

        if (!CoC.instance.plotFight && rand(200) == 0 && player.level >= 7) itype = consumables.BROBREW;
        if (!CoC.instance.plotFight && rand(200) == 0 && player.level >= 7) itype = consumables.BIMBOLQ;
        if (!CoC.instance.plotFight && rand(1000) == 0 && player.level >= 7) itype = consumables.RAINDYE;
        //Chance of eggs if Easter!
        if (!CoC.instance.plotFight && rand(6) == 0 && isEaster()) {
            itype = randomChoice(
                    consumables.BROWNEG,
                    consumables.L_BRNEG,
                    consumables.PURPLEG,
                    consumables.L_PRPEG,
                    consumables.BLUEEGG,
                    consumables.L_BLUEG,
                    consumables.PINKEGG,
                    consumables.NPNKEGG,
                    consumables.L_PNKEG,
                    consumables.L_WHTEG,
                    consumables.WHITEEG,
                    consumables.BLACKEG,
                    consumables.L_BLKEG
            );
        }
        //Bonus loot overrides others
        if (flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] != "") {
            itype = ItemType.lookupItem(flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID]);
        }
        monster.handleAwardItemText(itype); //Each monster can now override the default award text
        if (itype != null) {
            if (inDungeon)
                inventory.takeItem(itype, playerMenu);
            else inventory.takeItem(itype, nextFunc);
        }
    }

    public function awardPlayer(nextFunc:Function = null):void {
        if (nextFunc == null) nextFunc = camp.returnToCampUseOneHour; //Default to returning to camp.
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
            if (monster.lust >= monster.maxLust()) monster.gems += bonusGems3;
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
        if (!inDungeon && !inRoomedDungeon && !prison.inPrison) { //Not in dungeons
            if (nextFunc != null) doNext(nextFunc);
            else doNext(playerMenu);
        } else {
            if (nextFunc != null) doNext(nextFunc);
            else doNext(playerMenu);
        }
        dropItem(monster, nextFunc);
        inCombat = false;
        player.gems += monster.gems;
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
                    dynStats("lus", 5);
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
                    dynStats("lus", 5);
                } else if (tentaround == 3) {
                    outputText("Another inky length rises up from the floor and slaps against your face, inexpertly attempting to thrust itself inside your mouth. Resenting its temerity, you steadfastly hold your lips closed and turn your head away. The corrupt magics powering this spell won’t let you get off so easily, though. The others redouble their efforts, inundating you with maddening pleasure. You can’t help but gasp and moan, giving the oiled feeler all the opening it needs to enter your maw.\n\n");
                    dynStats("lus", 5);
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
                    dynStats("lus", 10);
                } else {
                    outputText("You’ve really fucked up now. An entire throne room full of demons is watching a bunch of summoned tentacles rape you in every hole, bouncing your body back and forth with the force of their thrusts, repeatedly spilling their corruptive payloads into your receptive holes. The worst part is");
                    if (player.cor >= 50) outputText(" how much of a bitch it makes you look like... and how good it feels to be Lethice’s bitch.");
                    else outputText(" how dirty it makes you feel... and how good it feels to be dirty.\n\n");
                    dynStats("lus", 10, "cor", 1);
                }
            } else {
                outputText("The tentacles grab at you again!");
                if (player.canFly()) outputText(" No matter how they strain, they can’t reach you.\n\n");
                else if (combatMiss() || player.hasPerk(PerkLib.Evade) || player.hasPerk(PerkLib.Flexibility)) outputText(" You twist out of their slick, bizarrely sensuous grasp for now.\n\n");
                else {
                    outputText(" Damn, they got you! They yank your arms and [legs] taut, holding you helpless in the air for their brothers to further violate. You can already feel a few oily tendrils sneaking under your [armor].\n\n");
                    player.changeStatusValue(StatusEffects.LethicesRapeTentacles, 3, 1);
                    dynStats("lus", 5);
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
        if (player.hasStatusEffect(StatusEffects.CounterEclipsingShadow)) {
            if (player.statusEffectv1(StatusEffects.CounterEclipsingShadow) > 0 && player.statusEffectv2(StatusEffects.CounterEclipsingShadow) == 0 && player.statusEffectv3(StatusEffects.CounterEclipsingShadow) == 0) {
				if (player.hasPerk(PerkLib.EclipsingShadowSu)) player.addStatusValue(StatusEffects.CounterEclipsingShadow, 1, -2);
				else if (player.hasPerk(PerkLib.EclipsingShadowEx)) player.addStatusValue(StatusEffects.CounterEclipsingShadow, 1, -3);
				player.addStatusValue(StatusEffects.CounterEclipsingShadow, 1, -4);
			}
			if (player.statusEffectv2(StatusEffects.CounterEclipsingShadow) > 0) player.addStatusValue(StatusEffects.CounterEclipsingShadow, 2, -1);
        }
        if (player.hasStatusEffect(StatusEffects.CounterGlacialStorm)) {
            if (player.statusEffectv1(StatusEffects.CounterGlacialStorm) > 0 && player.statusEffectv2(StatusEffects.CounterGlacialStorm) == 0 && player.statusEffectv3(StatusEffects.CounterGlacialStorm) == 0) {
				if (player.hasPerk(PerkLib.GlacialStormSu)) player.addStatusValue(StatusEffects.CounterGlacialStorm, 1, -2);
				else if (player.hasPerk(PerkLib.GlacialStormEx)) player.addStatusValue(StatusEffects.CounterGlacialStorm, 1, -3);
				player.addStatusValue(StatusEffects.CounterGlacialStorm, 1, -4);
			}
			if (player.statusEffectv2(StatusEffects.CounterGlacialStorm) > 0) player.addStatusValue(StatusEffects.CounterGlacialStorm, 2, -1);
        }
        if (player.hasStatusEffect(StatusEffects.CounterHighVoltage)) {
            if (player.statusEffectv1(StatusEffects.CounterHighVoltage) > 0 && player.statusEffectv2(StatusEffects.CounterHighVoltage) == 0 && player.statusEffectv3(StatusEffects.CounterHighVoltage) == 0) {
				if (player.hasPerk(PerkLib.HighVoltageSu)) player.addStatusValue(StatusEffects.CounterHighVoltage, 1, -2);
				else if (player.hasPerk(PerkLib.HighVoltageEx)) player.addStatusValue(StatusEffects.CounterHighVoltage, 1, -3);
				player.addStatusValue(StatusEffects.CounterHighVoltage, 1, -4);
			}
			if (player.statusEffectv2(StatusEffects.CounterHighVoltage) > 0) player.addStatusValue(StatusEffects.CounterHighVoltage, 2, -1);
        }
        if (player.hasStatusEffect(StatusEffects.CounterRagingInferno)) { //if has perk
            if (player.statusEffectv1(StatusEffects.CounterRagingInferno) > 0 && player.statusEffectv2(StatusEffects.CounterRagingInferno) == 0 && player.statusEffectv3(StatusEffects.CounterRagingInferno) == 0) {
                if (player.hasPerk(PerkLib.RagingInfernoSu)) player.addStatusValue(StatusEffects.CounterRagingInferno, 1, -2); //decrease by 10%
				else if (player.hasPerk(PerkLib.RagingInfernoEx)) player.addStatusValue(StatusEffects.CounterRagingInferno, 1, -3); //decrease by 15%
				player.addStatusValue(StatusEffects.CounterRagingInferno, 1, -4); //decrease by full 20%
			}//v3 = 1 - jesli chaneluje zaklecie/special to nie traci wzmocnienia
			if (player.statusEffectv2(StatusEffects.CounterRagingInferno) > 0) player.addStatusValue(StatusEffects.CounterRagingInferno, 2, -1);
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
            dynStats("lus", player.statusEffectv1(StatusEffects.LustStones) + 4);
        }
		if (player.hasStatusEffect(StatusEffects.LustTransferance)) dynStats("lus", player.statusEffectv1(StatusEffects.LustTransferance) + 4);
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
                    outputText("<b>You finish wiping the demon's tainted oils away from your eyes; though the smell lingers, you can at least see.  Sheila actually seems happy to once again be under your gaze.</b>\n\n");
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
            if (player.statusEffectv1(StatusEffects.IzmaBleed) <= 0) {
                player.removeStatusEffect(StatusEffects.IzmaBleed);
                outputText("<b>You sigh with relief; your bleeding has slowed considerably.</b>\n\n");
            }
            //Bleed effect:
            else {
                var bleed:Number = (4 + rand(7)) / 100;
                bleed *= player.HP;
                bleed = player.takePhysDamage(bleed);
                outputText("<b>You gasp and wince in pain, feeling fresh blood pump from your wounds. (<font color=\"#800000\">" + bleed + "</font>)</b>\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.Hemorrhage)) {
            player.addStatusValue(StatusEffects.Hemorrhage, 1, -1);
            if (player.statusEffectv1(StatusEffects.Hemorrhage) <= 0) {
                player.removeStatusEffect(StatusEffects.Hemorrhage);
                outputText("<b>You sigh with relief; your hemorrhage has slowed considerably.</b>\n\n");
            }
            //Hemorrhage effect:
            else {
                var hemorrhage:Number = 0;
                hemorrhage += player.maxHP() * player.statusEffectv2(StatusEffects.Hemorrhage);
                hemorrhage = player.takePhysDamage(hemorrhage);
                outputText("<b>You gasp and wince in pain, feeling fresh blood pump from your wounds. (<font color=\"#800000\">" + hemorrhage + "</font>)</b>\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.BurnDoT)) {
            player.addStatusValue(StatusEffects.BurnDoT, 1, -1);
            if (player.statusEffectv1(StatusEffects.BurnDoT) <= 0) {
                player.removeStatusEffect(StatusEffects.BurnDoT);
                outputText("<b>You sigh with relief; fire has stopped searing your wounds.</b>\n\n");
            }
            //Deal damage if still wounded.
            else {
                var burndot:Number = 0;
                burndot += player.maxHP() * player.statusEffectv2(StatusEffects.BurnDoT);
                burndot = player.takeFireDamage(burndot);
                outputText("<b>You gasp and wince in pain, feeling fire still searing your wounds. (<font color=\"#800000\">" + burndot + "</font>)</b>\n\n");
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
                if (player.weapon == WeaponLib.FISTS) {
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
        if (player.hasStatusEffect(StatusEffects.UnderwaterOutOfAir)) {
            var deoxigen:Number = 0;
            deoxigen += (player.maxHP() * 0.05);
            deoxigen = player.takePhysDamage(deoxigen);
            outputText("<b>You are running out of oxygen. You need to finish this fight and fast before you lose consciousness. <b>(<font color=\"#800000\">" + deoxigen + "</font>)</b></b>\n\n");
        }
		if (player.hasStatusEffect(StatusEffects.UnderwaterAndIgnis)) {
			var ignishurt:Number = 0;
            ignishurt += (player.maxHP() * 0.05);
            ignishurt = player.takeWaterDamage(ignishurt);
            outputText("<b>Your entire body is wracked with pain, steam curling from where the water touches your form. Maybe submerging your fiery body in water was a bad idea. <b>(<font color=\"#800000\">" + ignishurt + "</font>)</b></b>\n\n");
		}
        if (player.hasStatusEffect(StatusEffects.HeroBane)) {
            player.addStatusValue(StatusEffects.HeroBane, 1, -1);
            if (player.statusEffectv1(StatusEffects.HeroBane) <= 0) {
                player.removeStatusEffect(StatusEffects.HeroBane);
                outputText("<b>You feel your body lighten as the curse linking your vitality to that of [monster a] [monster name] ends.</b>\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.AcidSlap)) {
            var slap:Number = 3 + (player.maxHP() * 0.02);
            outputText("<b>Your muscles twitch in agony as the acid keeps burning you. <b>(<font color=\"#800000\">" + slap + "</font>)</b></b>\n\n");
        }
        if (monster.hasStatusEffect(StatusEffects.AuraOfMadness) && !player.hasPerk(PerkLib.Insanity) && !player.hasStatusEffect(StatusEffects.AlterBindScroll3)) {
			player.addCurse("int.mult", monster.statusEffectv1(StatusEffects.AuraOfMadness)/100,3);//non bosses have it 5
			player.addCurse("wis.mult", monster.statusEffectv2(StatusEffects.AuraOfMadness)/100,3);//bosses have it at 20
            outputText("<b>As the battle draws on you feel yourself slowly losing your grip on reality.</b>\n\n");
			if (player.inte <= 10 || player.wis <= 10) {
                doNext(endHpLoss);
                return;
            }
        }
        //Apophis Unholy Aura
        if (player.apophisScore() >= 23){
            outputText("Your unholy aura seeps into [monster a] [monster name], slowly and insidiously eroding its resiliance to your unholy charms.\n\n");
            monster.lustVuln += 0.10;
        }
        //Arousing Aura
        if (player.hasPerk(PerkLib.ArousingAura) && monster.lustVuln > 0 && player.cor >= 70) {
            if (monster.lust < (monster.maxLust() * 0.5)) outputText("Your aura seeps into [monster a] [monster name] but does not have any visible effects just yet.\n\n");
            else if (monster.lust < (monster.maxLust() * 0.6)) {
                if (!monster.plural) outputText(monster.capitalA + monster.short + " starts to squirm a little from your unholy presence.\n\n");
                else outputText(monster.capitalA + monster.short + " start to squirm a little from your unholy presence.\n\n");
            } else if (monster.lust < (monster.maxLust() * 0.75)) outputText("Your arousing aura seems to be visibly affecting [monster a] [monster name], making [monster him] squirm uncomfortably.\n\n");
            else if (monster.lust < (monster.maxLust() * 0.85)) {
                if (!monster.plural) outputText(monster.capitalA + monster.short + "'s skin colors red as [monster he] inadvertently basks in your presence.\n\n");
                else outputText(monster.capitalA + monster.short + "' skin colors red as [monster he] inadvertently bask in your presence.\n\n");
            } else {
                if (!monster.plural) outputText("The effects of your aura are quite pronounced on [monster a] [monster name] as [monster he] begins to shake and steal glances at your body.\n\n");
                else outputText("The effects of your aura are quite pronounced on [monster a] [monster name] as [monster he] begin to shake and steal glances at your body.\n\n");
            }
            if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) monster.lust += monster.lustVuln * 1.2 * (2 + rand(4));
            else monster.lust += monster.lustVuln * (2 + rand(4));
        }
        //Perfume
        if ((player.hasPerk(PerkLib.AlrauneNectar) || player.hasStatusEffect(StatusEffects.ArousalPotion)) && monster.lustVuln > 0) {
            if (player.isAlraune()){
                if (monster.lust < (monster.maxLust() * 0.5)) outputText("The perfumed scent of your nectar messes with [monster a] [monster name] but does not have any visible effects just yet.\n\n");
                else if (monster.lust < (monster.maxLust() * 0.6)) {
                    if (!monster.plural) outputText(monster.capitalA + monster.short + " starts to squirm a little from your nectar scent.\n\n");
                    else outputText(monster.capitalA + monster.short + " start to squirm a little from your nectar perfumed scent.\n\n");
                } else if (monster.lust < (monster.maxLust() * 0.75)) outputText("The perfumed scent of your nectar seems to be visibly affecting [monster a] [monster name], making [monster him] squirm uncomfortably.\n\n");
                else if (monster.lust < (monster.maxLust() * 0.85)) {
                    if (!monster.plural) outputText(monster.capitalA + monster.short + "'s skin colors red as [monster he] inadvertently basks in your scent.\n\n");
                    else outputText(monster.capitalA + monster.short + "' skin colors red as [monster he] inadvertently bask in your scent.\n\n");
                } else {
                    if (!monster.plural) outputText("The effects of your perfumed scent are quite pronounced on [monster a] [monster name] as [monster he] begins to shake and steal glances at your body.\n\n");
                    else outputText("The effects of your perfumed scent are quite pronounced on [monster a] [monster name] as [monster he] begin to shake and steal glances at your body.\n\n");
                }
            } else {
                if (monster.lust < (monster.maxLust() * 0.5)) outputText("The perfume messes with [monster a] [monster name] but does not have any visible effects just yet.\n\n");
                else if (monster.lust < (monster.maxLust() * 0.6)) {
                    if (!monster.plural) outputText(monster.capitalA + monster.short + " starts to squirm a little from your nectar scent.\n\n");
                    else outputText(monster.capitalA + monster.short + " start to squirm a little from your nectar perfumed scent.\n\n");
                } else if (monster.lust < (monster.maxLust() * 0.75)) outputText("The perfume seems to be visibly affecting [monster a] [monster name], making [monster him] squirm uncomfortably.\n\n");
                else if (monster.lust < (monster.maxLust() * 0.85)) {
                    if (!monster.plural) outputText(monster.capitalA + monster.short + "'s skin colors red as [monster he] inadvertently basks in your perfume.\n\n");
                    else outputText(monster.capitalA + monster.short + "' skin colors red as [monster he] inadvertently bask in your scent.\n\n");
                } else {
                    if (!monster.plural) outputText("The effects of your perfume are quite pronounced on [monster a] [monster name] as [monster he] begins to shake and steal glances at your body.\n\n");
                    else outputText("The effects of your perfume are quite pronounced on [monster a] [monster name] as [monster he] begin to shake and steal glances at your body.\n\n");
                }
            }
            var power:Number = CalcAlchemyPower()/5;
            if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) monster.lust += monster.lustVuln * 1.2 * (2+power + rand(4));
            else monster.lust += monster.lustVuln * (2+power+ rand(4));
        }
        //Unicorn and Bicorn aura
        //Unicorn
        if (player.hasPerk(PerkLib.AuraOfPurity)) {
            if (monster.cor > 20) {
                var damage:Number = (scalingBonusIntelligence() * 1);
                //Determine if critical hit!
                var crit:Boolean = false;
                var critChance:int = 5;
                critChance += combatMagicalCritical();
                if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
                if (rand(100) < critChance) {
                    crit = true;
                    damage *= 1.75;
                }
                damage = magic.calcInfernoModImpl(damage, true);
                damage *= 0.5;
                var SpellMultiplier:Number = 1;
                SpellMultiplier += spellMod() - 1;
                damage *= SpellMultiplier;
                if (monster.cor < 33) damage = Math.round(damage * 1.0);
                else if (monster.cor < 50) damage = Math.round(damage * 1.1);
                else if (monster.cor < 75) damage = Math.round(damage * 1.2);
                else if (monster.cor < 90) damage = Math.round(damage * 1.3);
                else damage = Math.round(damage * 1.4); //30% more damage against very high corruption.
                var corruptionModifier:Number = ((100 - player.cor) / 50);
                if (corruptionModifier < 1) corruptionModifier = 1;
                if (player.hasPerk(MutationsLib.EclipticMind)) damage *= corruptionModifier;
                if (player.hasPerk(MutationsLib.EclipticMindPrimitive)) damage *= corruptionModifier;
                if (player.hasPerk(MutationsLib.EclipticMindEvolved)) damage *= corruptionModifier;
                if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
                if (player.hasPerk(MutationsLib.EclipticMindPrimitive) && monster.cor > player.cor / 2) damage = Math.round(damage * 2);
                else if (player.hasPerk(MutationsLib.EclipticMindEvolved) && monster.cor > player.cor / 2) damage = Math.round(damage * 3);
				damage *= fireDamageBoostedByDao();
                damage = Math.round(damage);
                if (damage > (monster.maxHP()/10)) damage = Math.round(monster.maxHP()/10);
                outputText("Your aura of purity burns [monster a] [monster name] with holy fire for ");
                doFireDamage(damage, true, true);
                outputText(" damage!");
                if (crit) outputText(" <b>*Critical Hit!*</b>");
                outputText("\n\n");
            } else {
                outputText("Your opponent seems not to be affected by the cleansing flames of your aura of purity. Probably because [monster he] has no corruption within [monster his] body.\n\n");
            }
        }
        //Bicorn
        if (player.hasPerk(PerkLib.AuraOfCorruption) && monster.lustVuln > 0) {
            var lustDmg:Number = ((scalingBonusIntelligence() * 0.30) + (scalingBonusLibido() * 0.30));
            if (player.hasPerk(PerkLib.SensualLover)) lustDmg += 2;
            if (player.hasPerk(PerkLib.Seduction)) lustDmg += 5;
            if (player.hasPerk(PerkLib.SluttySeduction)) lustDmg += player.perkv1(PerkLib.SluttySeduction);
            if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) lustDmg += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
            if (player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)) lustDmg += 5;
            if (player.hasPerk(PerkLib.FlawlessBody)) lustDmg += 10;
            if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
            if (player.hasPerk(PerkLib.ArcaneLash)) lustDmg *= 1.5;
            if (player.hasPerk(PerkLib.JobSeducer)) lustDmg += player.teaseLevel * 3;
            else lustDmg += player.teaseLevel * 2;
            if (player.hasPerk(PerkLib.JobCourtesan) && monster.hasPerk(PerkLib.EnemyBossType)) lustDmg *= 1.2;
            if (player.hasPerk(PerkLib.SluttySimplicity) && player.armorName == "nothing") lustDmg *= (1 + ((10 + rand(11)) / 100));
            if (player.hasPerk(PerkLib.ElectrifiedDesire)) lustDmg *= (1 + (player.lust100 * 0.01));
            if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) lustDmg *= (1 + combat.historyWhoreBonus());
            if (player.hasPerk(MutationsLib.EclipticMind)) lustDmg *= ((player.cor / 50 / 100)+1);
            if (player.hasPerk(MutationsLib.EclipticMindPrimitive)) lustDmg *= ((player.cor / 50 / 100)+1);
            if (player.hasPerk(MutationsLib.EclipticMindEvolved)) lustDmg *= ((player.cor / 50 / 100)+1);
            if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= RacialParagonAbilityBoost();
            if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) monster.lust += monster.lustVuln * 1.2 * (2 + rand(4));
            if (player.hasPerk(MutationsLib.EclipticMindPrimitive) && monster.cor < (player.cor / 2)) lustDmg = Math.round(lustDmg * 2);
            else if (player.hasPerk(MutationsLib.EclipticMindEvolved) && monster.cor < (player.cor / 2)) lustDmg = Math.round(lustDmg * 3);
            if (lustDmg > (monster.maxLust()/10)) lustDmg = Math.round(monster.maxLust()/10);
            outputText("[monster A] [monster name] slowly succumbs to [monster his] basest desires as your aura of corruption seeps through [monster him].");
            if (monster.cor < 100) outputText("Your victims purity is slowly becoming increasingly eroded by your seeping corruption.");
            lustDmg = Math.round(monster.lustVuln * lustDmg);
            monster.teased(lustDmg, false);
            outputText("\n\n");
            bonusExpAfterSuccesfullTease();
        }
        //Alraune Pollen
        if (player.hasStatusEffect(StatusEffects.AlraunePollen) && monster.lustVuln > 0) {
            var lustDmgA:Number = (scalingBonusLibido() * 0.5);
            if (player.hasPerk(PerkLib.SensualLover)) lustDmgA += 2;
            if (player.hasPerk(PerkLib.Seduction)) lustDmgA += 5;
            if (player.hasPerk(PerkLib.SluttySeduction)) lustDmgA += player.perkv1(PerkLib.SluttySeduction);
            if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction) >= 0) lustDmgA += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
            if (player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)) lustDmgA += 5;
            if (player.hasPerk(PerkLib.FlawlessBody)) lustDmgA += 10;
            if (player.hasPerk(PerkLib.EromancyExpert)) lustDmgA *= 1.5;
            if (player.hasPerk(PerkLib.JobSeducer)) lustDmgA += player.teaseLevel * 3;
            else lustDmgA += player.teaseLevel * 2;
            if (player.hasPerk(PerkLib.JobCourtesan) && monster.hasPerk(PerkLib.EnemyBossType)) lustDmgA *= 1.2;
            if (player.hasPerk(PerkLib.SluttySimplicity) && player.armorName == "nothing") lustDmgA *= (1 + ((10 + rand(11)) / 100));
            if (player.hasPerk(PerkLib.ElectrifiedDesire)) lustDmgA *= (1 + (player.lust100 * 0.01));
            if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) lustDmgA *= (1 + combat.historyWhoreBonus());
            if (player.hasPerk(PerkLib.RacialParagon)) lustDmgA *= RacialParagonAbilityBoost();
            if (player.hasPerk(MutationsLib.FloralOvaries)) lustDmgA *= 1.2;
            if (player.hasPerk(MutationsLib.FloralOvariesPrimitive)) {
                if (monster.isMaleOrHerm()) lustDmgA *= 1.5;
                lustDmgA *= 1.25;
            }
            if (player.hasPerk(MutationsLib.FloralOvariesEvolved)) {
                if (rand(100) > 69) monster.createStatusEffect(StatusEffects.Fascinated,0,0,0,0);
                lustDmgA *= 1.3;
            }
            if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) monster.lust += monster.lustVuln * 1.2 * (2 + rand(4));
            if (monster.lust < (monster.maxLust() * 0.5)) outputText(monster.capitalA + monster.short + " breathes in your pollen but does not have any visible effects yet.");
            else if (monster.lust < (monster.maxLust() * 0.6)) {
                if (!monster.plural) outputText(monster.capitalA + monster.short + " start to squirm a little. Your pollen's starting to get to them.");
                else outputText(monster.capitalA + monster.short + " starts to squirm a little from your pollen.");
            } else if (monster.lust < (monster.maxLust() * 0.75)) outputText("Your pollen seems to be visibly affecting [monster a] [monster name], making [monster him] squirm uncomfortably.");
            else if (monster.lust < (monster.maxLust() * 0.85)) {
                if (!monster.plural) outputText(monster.capitalA + monster.short + "'s skin flushes red, blood in their cheeks as [monster he] inadvertently breathes in your pollen.");
                else outputText(monster.capitalA + monster.short + "' skin blushes red as [monster he] inadvertently breathes in your pollen.");
            } else {
                if (!monster.plural) outputText("The effects of your pollen are quite pronounced on [monster a] [monster name] as [monster he] begin to shake, occasionally stealing glances at your body.");
                else outputText("The effects of your pollen are quite pronounced on [monster a] [monster name] as [monster he] begin to shake, stealing glances at your body.");
            }
            if (lustDmgA > (monster.maxLust()/10)) lustDmgA = Math.round(monster.maxLust()/10);
            lustDmgA = Math.round(monster.lustVuln * lustDmgA);
            monster.teased(lustDmgA, false);
            outputText("\n\n");
            bonusExpAfterSuccesfullTease();
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
            if (player.hasPerk(PerkLib.RacialParagon)) lustDmgA *= RacialParagonAbilityBoost();
            damage0 = Math.round(damage0);
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
            if (player.hasPerk(PerkLib.SluttySeduction)) lustDmgF += player.perkv1(PerkLib.SluttySeduction);
            if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) lustDmgF += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
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
            if (player.hasPerk(PerkLib.SluttySimplicity) && player.armorName == "nothing") lustDmgF *= (1 + ((10 + rand(11)) / 100));
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
            if (player.hasPerk(PerkLib.CriticalPerformance)) {
                if (player.lib <= 100) critChance2 += player.lib / 5;
                if (player.lib > 100) critChance2 += 20;
            }
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance2 = 0;
            if (rand(100) < critChance2) {
                crit2 = true;
                lustDmgF *= 1.75;
            }
            if (player.hasPerk(PerkLib.ChiReflowLust)) lustDmgF *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
            if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) lustDmgF *= 1.5;
            lustDmgF = lustDmgF * monster.lustVuln;
            if (player.hasPerk(PerkLib.RacialParagon)) lustDmgF *= RacialParagonAbilityBoost();
            lustDmgF = lustDmgF/2;
            lustDmgF = Math.round(lustDmgF);
            outputText("Your opponent is struck by lightning as your lust storm rages on.")
            damage0 = doLightingDamage(damage0, true, true);
            if (crit1) outputText(" <b>*Critical!*</b>");
            monster.teased(lustDmgF, false);
            if (crit2) outputText(" <b>Critical!</b>");
            outputText(" as a bolt falls from the sky!\n\n");
            combat.bonusExpAfterSuccesfullTease();
            if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
            if (player.hasPerk(MutationsLib.HeartOfTheStormEvolved)){
                if (rand(100) < 10) {
                    if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
                }
            }
            checkAchievementDamage(damage0);
            statScreenRefresh();
            if (monster.HP <= monster.minHP()) doNext(endHpVictory);
            if (monster.lust >= monster.maxLust()) doNext(endLustVictory);
        }
        //Black Frost Aura
        if (player.hasPerk(PerkLib.IceQueenGown) && player.yukiOnnaScore()>=14) {
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
                damageBFA = magic.calcGlacialModImpl(damageBFA, true)/2;
                var SpellMultiplier2:Number = 1;
                SpellMultiplier2 += spellMod() - 1;
                damageBFA *= SpellMultiplier2;
                if (player.hasPerk(PerkLib.RacialParagon)) damageBFA *= RacialParagonAbilityBoost();
                damageBFA = Math.round(damageBFA * iceDamageBoostedByDao());
                if (damageBFA > (monster.maxHP()/10)) damageBFA = Math.round(monster.maxHP()/10);
                outputText("Your black frost aura chills [monster a] [monster name] to the bone, dealing ");
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
        if (player.hasStatusEffect(StatusEffects.Bound) && flags[kFLAGS.PC_FETISH] >= 2) {
            outputText("The feel of tight leather completely immobilizing you turns you on more and more.  Would it be so bad to just wait and let her play with you like this?\n\n");
            dynStats("lus", 3);
        }
        if (player.hasStatusEffect(StatusEffects.GooArmorBind)) {
            if (flags[kFLAGS.PC_FETISH] >= 2) {
                outputText("The feel of the all-encapsulating goo immobilizing your helpless body turns you on more and more.  Maybe you should just wait for it to completely immobilize you and have you at its mercy.\n\n");
                dynStats("lus", 3);
            } else outputText("You're utterly immobilized by the goo flowing around you.  You'll have to struggle free!\n\n");
        }
        if (player.hasStatusEffect(StatusEffects.HarpyBind)) {
            if (flags[kFLAGS.PC_FETISH] >= 2) {
                outputText("The harpies are holding you down and restraining you, making the struggle all the sweeter!\n\n");
                dynStats("lus", 3);
            } else outputText("You're restrained by the harpies so that they can beat on you with impunity.  You'll need to struggle to break free!\n\n");
        }
        if ((player.hasStatusEffect(StatusEffects.NagaBind) || player.hasStatusEffect(StatusEffects.ScyllaBind)) && flags[kFLAGS.PC_FETISH] >= 2) {
            outputText("Coiled tightly by [monster a] [monster name] and utterly immobilized, you can't help but become aroused thanks to your bondage fetish.\n\n");
            dynStats("lus", 5);
        }
        if (player.hasStatusEffect(StatusEffects.TentacleBind)) {
            outputText("You are firmly trapped in the tentacle's coils.  <b>The only thing you can try to do is struggle free!</b>\n\n");
            if (flags[kFLAGS.PC_FETISH] >= 2) {
                outputText("Wrapped tightly in the tentacles, you find it hard to resist becoming more and more aroused...\n\n");
                dynStats("lus", 3);
            }
        }
        if (player.hasStatusEffect(StatusEffects.DriderKiss)) {
            //(VENOM OVER TIME: WEAK)
            if (player.statusEffectv1(StatusEffects.DriderKiss) == 0) {
                outputText("Your heart hammers a little faster as a vision of the drider's nude, exotic body on top of you assails you.  It'll only get worse if she kisses you again...\n\n");
                dynStats("lus", 8);
            }
            //(VENOM OVER TIME: MEDIUM)
            else if (player.statusEffectv1(StatusEffects.DriderKiss) == 1) {
                outputText("You shudder and moan, nearly touching yourself as your ");
                if (player.gender > 0) outputText("loins tingle and leak, hungry for the drider's every touch.");
                else outputText("asshole tingles and twitches, aching to be penetrated.");
                outputText("  Gods, her venom is getting you so hot.  You've got to end this quickly!\n\n");
                dynStats("lus", 15);
            }
            //(VENOM OVER TIME: MAX)
            else {
                outputText("You have to keep pulling your hands away from your crotch - it's too tempting to masturbate here on the spot and beg the drider for more of her sloppy kisses.  Every second that passes, your arousal grows higher.  If you don't end this fast, you don't think you'll be able to resist much longer.  You're too turned on... too horny... too weak-willed to resist much longer...\n\n");
                dynStats("lus", 25);
            }
        }
        if (player.hasStatusEffect(StatusEffects.AikoLightningArrow)) {
            if (player.statusEffectv1(StatusEffects.AikoLightningArrow) <= 0) {
                player.removeStatusEffect(StatusEffects.AikoLightningArrow);
                outputText("<b>You feel stronger as Aiko's lightning finally fades, though the arrow is still lodged in your side.</b>\n\n");
                player.buff("LightningArrowStr").remove();
				player.buff("LightningArrowSpe").remove();
            }
            //Shock effect:
            else {
                outputText("You fall to one knee as Aiko's Lighting pulses through your limbs, Oh how this hurts...");
                player.takeLightningDamage(15, true);
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
            if (player.hasPerk(PerkLib.Medicine) && rand(100) <= 14) {
                outputText("You manage to cleanse the harpy lip-gloss from your system with your knowledge of medicine!\n\n");
                player.removeStatusEffect(StatusEffects.Luststick);
            } else if (rand(5) == 0) {
                if (rand(2) == 0) outputText("A fantasy springs up from nowhere, dominating your thoughts for a few moments.  In it, you're lying down in a soft nest.  Gold-rimmed lips are noisily slurping around your [cock], smearing it with her messy aphrodisiac until you're completely coated in it.  She looks up at you knowingly as the two of you get ready to breed the night away...\n\n");
                else outputText("An idle daydream flutters into your mind.  In it, you're fucking a harpy's asshole, clutching tightly to her wide, feathery flanks as the tight ring of her pucker massages your [cock].  She moans and turns around to kiss you on the lips, ensuring your hardness.  Before long her feverish grunts of pleasure intensify, and you feel the egg she's birthing squeezing against you through her internal walls...\n\n");
                dynStats("lus", 20);
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
            dynStats("lus", 7 + int(player.effectiveSensitivity()) / 10);
        }
        if (player.hasStatusEffect(StatusEffects.RaijuStaticDischarge)) {
            outputText("The raiju electricity stored in your body continuously tingle around your genitals!\n\n");
            dynStats("lus", 14 + int(player.effectiveSensitivity()) / 8);
        }
        if (player.hasStatusEffect(StatusEffects.KissOfDeath)) {
            //Effect
            outputText("Your lips burn with an unexpected flash of heat.  They sting and burn with unholy energies as a puff of ectoplasmic gas escapes your lips.  That puff must be a part of your soul!  It darts through the air to [monster a] [monster name], who slurps it down like a delicious snack.  You feel feverishly hot and exhausted...\n\n");
            dynStats("lus", 5);
            player.takePhysDamage(15);
        }
        if (player.hasStatusEffect(StatusEffects.DemonSeed)) {
            outputText("You feel something shift inside you, making you feel warm.  Finding the desire to fight this... hunk gets harder and harder.\n\n");
            dynStats("lus", (player.statusEffectv1(StatusEffects.DemonSeed) + int(player.effectiveSensitivity() / 30) + int(player.lib / 30) + int(player.cor / 30)));
        }
        if (player.inHeat && player.vaginas.length > 0 && monster.cockTotal() > 0) {
            dynStats("lus", (rand(player.lib / 5) + 3 + rand(5)));
            outputText("Your " + vaginaDescript(0) + " clenches with an instinctual desire to be touched and filled.  ");
            outputText("If you don't end this quickly you'll give in to your heat.\n\n");
        }
        if (player.inRut && player.cockTotal() > 0 && monster.hasVagina()) {
            dynStats("lus", (rand(player.lib / 5) + 3 + rand(5)));
            if (player.cockTotal() > 1) outputText("Each of y");
            else outputText("Y");
            if (monster.plural) outputText("our [cocks] dribbles pre-cum as you think about plowing [monster a] [monster name] right here and now, fucking [monster his] " + monster.vaginaDescript() + "s until they're totally fertilized and pregnant.\n\n");
            else outputText("our [cocks] dribbles pre-cum as you think about plowing [monster a] [monster name] right here and now, fucking [monster his] " + monster.vaginaDescript() + " until it's totally fertilized and pregnant.\n\n");
        }
        if (player.hasStatusEffect(StatusEffects.NagaVenom)) {
            //Chance to cleanse!
            if (player.hasPerk(PerkLib.Medicine) && rand(100) <= 14) {
                outputText("Using your knowledge of medicine, you manage to cleanse [monster a] [monster name] venom from your system.\n\n");
                player.removeStatusEffect(StatusEffects.NagaVenom);
            } else if (player.spe > 3) {
                player.addStatusValue(StatusEffects.NagaVenom, 1, 2);
                player.statStore.addBuffObject({"spe": -player.statusEffectv1(StatusEffects.NagaVenom)}, "Poison", {text: "Poisoned!"})
            } else player.takePhysDamage(5);
            outputText("You wince in pain and try to collect yourself, [monster a] [monster name]'s venom still plaguing you.\n\n");
            player.takePhysDamage(2);
        }
        if (player.hasStatusEffect(StatusEffects.MedusaVenom)) {
            //Chance to cleanse!
            if (player.hasPerk(PerkLib.Medicine) && rand(100) <= 14) {
                outputText("Using your knowledge of medicine, you manage to cleanse [monster a] [monster name] venom from your system.\n\n");
                player.statStore.removeBuffs("Poison");
                player.removeStatusEffect(StatusEffects.MedusaVenom);
            } else if (player.str <= 5 && player.tou <= 5 && player.spe <= 5 && player.inte <= 5) player.takePhysDamage(5);
            else {
                player.addStatusValue(StatusEffects.MedusaVenom, 1, 2);
                player.addStatusValue(StatusEffects.MedusaVenom, 2, 1);
                player.statStore.addBuffObject({"str": player.statusEffectv1(StatusEffects.MedusaVenom), "tou": player.statusEffectv1(StatusEffects.MedusaVenom), "spe": player.statusEffectv1(StatusEffects.MedusaVenom), "int": player.statusEffectv2(StatusEffects.MedusaVenom)}, "Poison", {text: "Poisoned!"})
            }
            outputText("You wince in pain and try to collect yourself, [monster a] [monster name]'s venom still plaguing you.\n\n");
            player.takePhysDamage(2);
        }
        //Temporary heat
        if (player.hasStatusEffect(StatusEffects.TemporaryHeat)) {
            //Chance to cleanse!
            if (player.hasPerk(PerkLib.Medicine) && rand(100) <= 14) {
                outputText("With your knowledge of medicine, you manage to cleanse the heat and rut drug from your system.\n\n");
                player.removeStatusEffect(StatusEffects.TemporaryHeat);
            } else {
                dynStats("lus", (player.lib / 12 + 5 + rand(5)) * player.statusEffectv2(StatusEffects.TemporaryHeat));
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
            if (player.hasPerk(PerkLib.Medicine) && rand(100) <= 14) {
                outputText("You manage to cleanse the poison from your system with your knowledge of medicine!\n\n");
                player.removeStatusEffect(StatusEffects.Poison);
            } else {
                outputText("The poison continues to work on your body, wracking you with pain!\n\n");
                player.takePhysDamage(8 + rand(player.maxHP() / 20) * player.statusEffectv2(StatusEffects.Poison));
            }
        }
        //Bondage straps + bondage fetish
        if (flags[kFLAGS.PC_FETISH] >= 2 && player.armorName == "barely-decent bondage straps") {
            outputText("The feeling of the tight, leather straps holding tightly to your body while exposing so much of it turns you on a little bit more.\n\n");
            dynStats("lus", 2);
        }
        // Drider incubus venom
        if (player.hasStatusEffect(StatusEffects.DriderIncubusVenom)) {
            if (player.hasPerk(PerkLib.Medicine) && rand(100) <= 41) {
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
            if (player.statusEffectv1(StatusEffects.AcidDoT) <= 0) {
                outputText("Acid wounds left by [themonster] finally close ups.\n\n");
                player.removeStatusEffect(StatusEffects.AcidDoT);
            }
        }
        //Frostburn DoT
        if (player.hasStatusEffect(StatusEffects.FrostburnDoT)) {
            player.addStatusValue(StatusEffects.FrostburnDoT, 1, -1);
            //Heal wounds
            if (player.statusEffectv1(StatusEffects.FrostburnDoT) <= 0) {
                outputText("Frostburn wounds left by [themonster] finally close ups.\n\n");
                player.removeStatusEffect(StatusEffects.FrostburnDoT);
            } else {
                var frostburnPlayer:Number = (monster.str + monster.spe + monster.tou) * 2.5;
                frostburnPlayer += player.maxHP() * player.statusEffectv2(StatusEffects.FrostburnDoT);
                outputText("You are hurt by lingering Frostburn after-effect. ");
                player.takeIceDamage(frostburnPlayer, true);
                outputText("\n\n");
            }
        }
        //Frozen Lung DoT
        if (player.hasStatusEffect(StatusEffects.FrozenLung)) {
            player.addStatusValue(StatusEffects.FrozenLung, 1, -1);
            //Heal wounds
            if (player.statusEffectv1(StatusEffects.FrozenLung) <= 0) {
                outputText("Frozen Lung left by [themonster] finally ends.\n\n");
                player.removeStatusEffect(StatusEffects.FrozenLung);
            } else {
                var frozenlung:Number = player.maxHP() * player.statusEffectv2(StatusEffects.FrozenLung);
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
						if (player.wrath >= (player.maxWrath() * 0.1)) player.wrath -= (player.maxWrath() * 0.1);
						else {
							player.removeStatusEffect(StatusEffects.TooAngryTooDie);
							player.removeStatusEffect(StatusEffects.Berzerking);
							outputText("<b>Berserker effect wore off!</b>\n\n");
						}
					} else {
						if (player.wrath >= 10) player.wrath -= 10;
						else {
							player.removeStatusEffect(StatusEffects.Berzerking);
							outputText("<b>Berserker effect wore off!</b>\n\n");
						}
					}
				} else player.addStatusValue(StatusEffects.Berzerking, 1, -1);
			}
        }
        //Blood Frenzy until ennemies stops bleeding
        if (player.hasStatusEffect(StatusEffects.BloodFrenzy)) {
            if (!MonsterIsBleeding()) {
                player.removeStatusEffect(StatusEffects.BloodFrenzy);
                player.statStore.removeBuffs("Blood Frenzy");
                outputText("<b>With no blood in the air, your mind clears, your frenzy fades. </b>\n\n");
            }
        }
        if (player.hasStatusEffect(StatusEffects.Lustzerking)) {
            if (player.statusEffectv1(StatusEffects.Lustzerking) <= 0) {
                player.removeStatusEffect(StatusEffects.Lustzerking);
                outputText("<b>Lustzerker effect wore off!</b>\n\n");
            } else {
				if (player.hasPerk(PerkLib.EndlessRage)) {
					if (player.hasStatusEffect(StatusEffects.TooAngryTooDie)) {
						if (player.wrath >= (player.maxWrath() * 0.1)) player.wrath -= (player.maxWrath() * 0.1);
						else {
							player.removeStatusEffect(StatusEffects.TooAngryTooDie);
							player.removeStatusEffect(StatusEffects.Lustzerking);
							outputText("<b>Lustzerker effect wore off!</b>\n\n");
						}
					} else {
						if (player.wrath >= 10) player.wrath -= 10;
						else {
							player.removeStatusEffect(StatusEffects.Lustzerking);
							outputText("<b>Lustzerker effect wore off!</b>\n\n");
						}
					}
				} else player.addStatusValue(StatusEffects.Lustzerking, 1, -1);
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
        if (player.hasStatusEffect(StatusEffects.Maleficium)) {
            if (player.statusEffectv1(StatusEffects.Maleficium) <= 0) {
                player.removeStatusEffect(StatusEffects.Maleficium);
                outputText("<b>Maleficium effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.Maleficium, 1, -1);
        }
        if (player.hasStatusEffect(StatusEffects.WinterClaw)) {
            if (player.statusEffectv1(StatusEffects.WinterClaw) <= 0) {
                player.removeStatusEffect(StatusEffects.WinterClaw);
                outputText("<b>Winter Claw effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.WinterClaw, 1, -1);
        }
        //Spell buffs
        //Violet Pupil Transformation
        if (player.hasStatusEffect(StatusEffects.VioletPupilTransformation)) {
            if (player.soulforce < 100) {
                player.removeStatusEffect(StatusEffects.VioletPupilTransformation);
                outputText("<b>Your soulforce is too low to continue using Violet Pupil Transformation. </b>\n\n");
            } else {
                var soulforcecost:int = 100;
                player.soulforce -= soulforcecost;
                var hpChange1:int = 200;
                if (player.unicornScore() >= 10) hpChange1 += 150;
                if (player.alicornScore() >= 12) hpChange1 += 200;
                outputText("<b>As your soulforce is drained you can feel Violet Pupil Transformation's regenerative power spreading throughout your body. (<font color=\"#008000\">+" + hpChange1 + "</font>)</b>\n\n");
                HPChange(hpChange1, false);
            }
        }
        //Goblin Mech Stimpack
        if (player.hasStatusEffect(StatusEffects.GoblinMechStimpack)) {
            if (player.statusEffectv1(StatusEffects.GoblinMechStimpack) <= 0) {
                player.removeStatusEffect(StatusEffects.GoblinMechStimpack);
                outputText("<b>" + (player.hasKeyItem("Medical Dispenser 2.0") >= 0 ? "Medical Dispenser 2.0" : "Stimpack Dispenser 1.0") + " effects wore off!</b>\n\n");
            } else {
                player.addStatusValue(StatusEffects.GoblinMechStimpack, 1, -1);
                var hpChange3:int = player.statusEffectv2(StatusEffects.GoblinMechStimpack);
                outputText("<b>" + (player.hasKeyItem("Medical Dispenser 2.0") >= 0 ? "Medical Dispenser 2.0" : "Stimpack Dispenser 1.0") + " healing power spreading throughout your body. (<font color=\"#008000\">+" + hpChange3 + "</font>)</b>\n\n");
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
                outputText("<b>The flow of power through you suddenly stops, as you no longer have the wrath to sustain it.  You drop roughly to the floor. Your Asura form slowly fades away, leaving you in your normal form.</b>\n\n");
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
        //Ezekiel Curse
        if (player.hasStatusEffect(StatusEffects.EzekielCurse)) {/*
            if (EvangelineFollower.EvangelineAffectionMeter >= 2 && player.hasPerk(PerkLib.EzekielBlessing)) {
                outputText("<b>You feel your lifeforce slipping away, leaving you weaker, slower, your mind reeling.  This ailment is crippling, and getting worse. Finish this fight quickly!</b>\n\n");
                player.takePhysDamage(500);
            } else */if (EvangelineFollower.EvangelineAffectionMeter >= 2) {
                outputText("<b>You feel your lifeforce slipping away, leaving you weaker, slower, your mind reeling.  You better finsh this fight fast, or find a way to cure this ailment...You know you can't keep this up forever.</b>\n\n");
                if (player.maxHP() < 1000) player.takePhysDamage(player.maxHP() * 0.1);
                else player.takePhysDamage(100);
			}
        }
        //Flying
        if (player.isFlying()) {
			if (player.statusEffectv2(StatusEffects.Flying) == 0) {
				if (!player.hasPerk(MutationsLib.HeartOfTheStormEvolved)) player.addStatusValue(StatusEffects.Flying, 1, -1);
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
			if (player.statusEffectv1(StatusEffects.Flying) <= 0) player.removeStatusEffect(StatusEffects.FlyingDisabled);
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
        if (player.hasStatusEffect(StatusEffects.CooldownMilkBlast) && player.hasPerk(MutationsLib.LactaBovinaOvariesEvolved)) {
            if (player.statusEffectv1(StatusEffects.CooldownMilkBlast) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownMilkBlast);
            } else {
                player.addStatusValue(StatusEffects.CooldownMilkBlast, 1, -1);
            }
        }
        //Cum Cannon
        if (player.hasStatusEffect(StatusEffects.CooldownCumCannon) && player.hasPerk(MutationsLib.MinotaurTesticlesEvolved)) {
            if (player.statusEffectv1(StatusEffects.CooldownCumCannon) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownCumCannon);
            } else {
                player.addStatusValue(StatusEffects.CooldownCumCannon, 1, -1);
            }
        }
        //Plasma blast
        if (player.hasStatusEffect(StatusEffects.CooldownPlasmaBlast) && (player.hasPerk(MutationsLib.LactaBovinaOvariesEvolved) || player.hasPerk(MutationsLib.MinotaurTesticlesEvolved))) {
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
        //Spells
        if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodSwipe)) {
            if (player.statusEffectv1(StatusEffects.CooldownSpellBloodSwipe) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownSpellBloodSwipe);
            } else {
                player.addStatusValue(StatusEffects.CooldownSpellBloodSwipe, 1, -1);
            }
        }
        if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodSwipeSF)) {
            if (player.statusEffectv1(StatusEffects.CooldownSpellBloodSwipeSF) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownSpellBloodSwipeSF);
            } else {
                player.addStatusValue(StatusEffects.CooldownSpellBloodSwipeSF, 1, -1);
            }
        }
        if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodDewdrops)) {
            if (player.statusEffectv1(StatusEffects.CooldownSpellBloodDewdrops) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownSpellBloodDewdrops);
            } else {
                player.addStatusValue(StatusEffects.CooldownSpellBloodDewdrops, 1, -1);
            }
        }
        if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodDewdropsSF)) {
            if (player.statusEffectv1(StatusEffects.CooldownSpellBloodDewdropsSF) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownSpellBloodDewdropsSF);
            } else {
                player.addStatusValue(StatusEffects.CooldownSpellBloodDewdropsSF, 1, -1);
            }
        }
        //Companion Boosting PC Armor Value
        if (player.hasStatusEffect(StatusEffects.CompBoostingPCArmorValue)) player.removeStatusEffect(StatusEffects.CompBoostingPCArmorValue);
        //Elemental Aspect status effects
        if (player.hasStatusEffect(StatusEffects.WindWall)) {
            if (player.statusEffectv2(StatusEffects.WindWall) <= 0) {
                player.removeStatusEffect(StatusEffects.WindWall);
                outputText("<b>Wind Wall effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.WindWall, 2, -1);
        }
        if (player.hasStatusEffect(StatusEffects.StoneSkin)) {
            if (player.statusEffectv2(StatusEffects.StoneSkin) <= 0) {
                player.removeStatusEffect(StatusEffects.StoneSkin);
                outputText("<b>Stone Skin effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.StoneSkin, 2, -1);
        }
        if (player.hasStatusEffect(StatusEffects.BarkSkin)) {
            if (player.statusEffectv2(StatusEffects.BarkSkin) <= 0) {
                player.removeStatusEffect(StatusEffects.BarkSkin);
                outputText("<b>Bark Skin effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.BarkSkin, 2, -1);
        }
        if (player.hasStatusEffect(StatusEffects.MetalSkin)) {
            if (player.statusEffectv2(StatusEffects.MetalSkin) <= 0) {
                player.removeStatusEffect(StatusEffects.MetalSkin);
                outputText("<b>Metal Skin effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.MetalSkin, 2, -1);
        }
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
        //Hurricane Dance
        if (player.hasStatusEffect(StatusEffects.CooldownHurricaneDance)) {
            if (player.statusEffectv1(StatusEffects.CooldownHurricaneDance) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownHurricaneDance);
            } else {
                player.addStatusValue(StatusEffects.CooldownHurricaneDance, 1, -1);
            }
        }
        if (player.hasStatusEffect(StatusEffects.HurricaneDance)) {
            if (player.statusEffectv1(StatusEffects.HurricaneDance) <= 0) {
                player.removeStatusEffect(StatusEffects.HurricaneDance);
                outputText("<b>Hurricane Dance effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.HurricaneDance, 1, -1);
        }
        //Earth Stance
        if (player.hasStatusEffect(StatusEffects.CooldownEarthStance)) {
            if (player.statusEffectv1(StatusEffects.CooldownEarthStance) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownEarthStance);
            } else {
                player.addStatusValue(StatusEffects.CooldownEarthStance, 1, -1);
            }
        }
        if (player.hasStatusEffect(StatusEffects.EarthStance)) {
            if (player.statusEffectv1(StatusEffects.EarthStance) <= 0) {
                player.removeStatusEffect(StatusEffects.EarthStance);
                outputText("<b>Earth Stance effect wore off!</b>\n\n");
            } else player.addStatusValue(StatusEffects.EarthStance, 1, -1);
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
        //Sextuple Thrust
        if (player.hasStatusEffect(StatusEffects.CooldownSextupleThrust)) {
            if (player.statusEffectv1(StatusEffects.CooldownSextupleThrust) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownSextupleThrust);
            } else {
                player.addStatusValue(StatusEffects.CooldownSextupleThrust, 1, -1);
            }
        }
        //Nonuple Thrust
        if (player.hasStatusEffect(StatusEffects.CooldownNonupleThrust)) {
            if (player.statusEffectv1(StatusEffects.CooldownNonupleThrust) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownNonupleThrust);
            } else {
                player.addStatusValue(StatusEffects.CooldownNonupleThrust, 1, -1);
            }
        }
        //Grandiose Hail of Blades
        if (player.hasStatusEffect(StatusEffects.CooldownGrandioseHailOfBlades)) {
            if (player.statusEffectv1(StatusEffects.CooldownGrandioseHailOfBlades) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownGrandioseHailOfBlades);
            } else {
                player.addStatusValue(StatusEffects.CooldownGrandioseHailOfBlades, 1, -1);
            }
        }
        //Grandiose Hail of Moon Blades
        if (player.hasStatusEffect(StatusEffects.CooldownGrandioseHailOfMoonBlades)) {
            if (player.statusEffectv1(StatusEffects.CooldownGrandioseHailOfMoonBlades) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownGrandioseHailOfMoonBlades);
            } else {
                player.addStatusValue(StatusEffects.CooldownGrandioseHailOfMoonBlades, 1, -1);
            }
        }
        //Soul Blast
        if (player.hasStatusEffect(StatusEffects.CooldownSoulBlast)) {
            if (player.statusEffectv1(StatusEffects.CooldownSoulBlast) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownSoulBlast);
            } else {
                player.addStatusValue(StatusEffects.CooldownSoulBlast, 1, -1);
            }
        }
		//Flames of Love
		if (player.hasStatusEffect(StatusEffects.CooldownFlamesOfLove)) {
            if (player.statusEffectv1(StatusEffects.CooldownFlamesOfLove) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownFlamesOfLove);
            } else {
                player.addStatusValue(StatusEffects.CooldownFlamesOfLove, 1, -1);
            }
        }
		//Icicles of Love
		if (player.hasStatusEffect(StatusEffects.CooldownIciclesOfLove)) {
            if (player.statusEffectv1(StatusEffects.CooldownIciclesOfLove) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownIciclesOfLove);
            } else {
                player.addStatusValue(StatusEffects.CooldownIciclesOfLove, 1, -1);
            }
        }
		//Storm of Sisterhood
		if (player.hasStatusEffect(StatusEffects.CooldownStormOfSisterhood)) {
            if (player.statusEffectv1(StatusEffects.CooldownStormOfSisterhood) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownStormOfSisterhood);
            } else {
                player.addStatusValue(StatusEffects.CooldownStormOfSisterhood, 1, -1);
            }
        }
		//Night of Brotherhood
		if (player.hasStatusEffect(StatusEffects.CooldownNightOfBrotherhood)) {
            if (player.statusEffectv1(StatusEffects.CooldownNightOfBrotherhood) <= 0) {
                player.removeStatusEffect(StatusEffects.CooldownNightOfBrotherhood);
            } else {
                player.addStatusValue(StatusEffects.CooldownNightOfBrotherhood, 1, -1);
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
        if (player.hasStatusEffect(StatusEffects.BladeDance)) player.removeStatusEffect(StatusEffects.BladeDance);
        if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) player.removeStatusEffect(StatusEffects.ResonanceVolley);
        if (player.hasStatusEffect(StatusEffects.Defend)) player.removeStatusEffect(StatusEffects.Defend);
        regeneration1(true);
        if (player.lust >= player.maxOverLust()) doNext(endLustLoss);
        if (player.HP <= player.minHP()) doNext(endHpLoss);
		if (monster.lust >= monster.maxLust()) doNext(endLustVictory);
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
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
            if ((player.hasStatusEffect(StatusEffects.UnderwaterCombatBoost) || player.hasStatusEffect(StatusEffects.NearWater)) && (player.hasPerk(PerkLib.AquaticAffinity) || player.hasPerk(PerkLib.AffinityUndine)) && player.necklaceName == "Magic coral and pearl necklace") healingPercent += 1;
            if (player.statStore.hasBuff("CrinosShape") && player.hasPerk(PerkLib.ImprovingNaturesBlueprintsApexPredator)) healingPercent += 2;
            if (player.perkv1(PerkLib.Sanctuary) == 1) healingPercent += ((player.corruptionTolerance - player.cor) / (100 + player.corruptionTolerance));
            if (player.perkv1(PerkLib.Sanctuary) == 2) healingPercent += player.cor / (100 + player.corruptionTolerance);
            if (player.hasStatusEffect(StatusEffects.SecondWindRegen)) healingPercent += 5;
            if (player.hasStatusEffect(StatusEffects.Cauterize)) {
                healingPercent += 1.5;
                if (player.hasPerk(MutationsLib.HinezumiBurningBlood)) healingPercent += 0.5;
                if (player.hasPerk(MutationsLib.HinezumiBurningBloodPrimitive)) healingPercent += 0.5;
                if (player.hasPerk(MutationsLib.HinezumiBurningBloodEvolved)) healingPercent += 0.5;
            }
            if (player.headJewelry == headjewelries.CUNDKIN && player.HP < 1) healingPercent += 1;
            if (player.hasStatusEffect(StatusEffects.Overlimit)) healingPercent -= 10;
            if (player.hasPerk(PerkLib.Ferocity) && player.HP < 1) negativeHPRegen -= 1;
            if (player.hasPerk(PerkLib.Diehard) && !player.hasPerk(PerkLib.EpicDiehard) && player.HP < 1) negativeHPRegen -= 1;
            if (player.hasPerk(MutationsLib.LizanMarrowEvolved) && player.HP < 1) negativeHPRegen -= 1;
			if (negativeHPRegen < 0 && !player.hasPerk(PerkLib.BloodDemonToughness)) healingPercent += negativeHPRegen;
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
		if (flags[kFLAGS.HUNGER_ENABLED] <= 0 && !player.hasPerk(PerkLib.EndlessHunger) && player.hasPerk(PerkLib.AxillaryVenomGlands)) maxPercentRegen -= 1;
		//if (player.hasStatusEffect(StatusEffects.GnomeHomeBuff) && player.statusEffectv1(StatusEffects.GnomeHomeBuff) == 1) maxPercentRegen += 15;
        if (player.armor == armors.NURSECL) maxPercentRegen += 0.5;
        if (player.armor == armors.BLIZZ_K) {
            if (!player.hasPerk(PerkLib.ColdAffinity)) maxPercentRegen -= 10;
            if (player.yukiOnnaScore() >= 14) maxPercentRegen += 5;
        }
        if (player.weapon == weapons.SESPEAR) maxPercentRegen += 2;
        if (player.hasPerk(PerkLib.LustyRegeneration)) maxPercentRegen += 0.5;
        if (player.hasPerk(PerkLib.LizanRegeneration)) maxPercentRegen += 1.5;
        if (player.hasPerk(MutationsLib.LizanMarrow)) maxPercentRegen += 0.5;
        if (player.hasPerk(MutationsLib.LizanMarrowPrimitive)) maxPercentRegen += 1;
        if (player.hasPerk(MutationsLib.LizanMarrowEvolved)) {
			maxPercentRegen += 1.5;
			if (player.HP < (player.maxHP() * 0.25)) maxPercentRegen += 4.5;
		}
		if (player.hasPerk(MutationsLib.DraconicHeartEvolved)) maxPercentRegen += 1;
        if (player.hasPerk(MutationsLib.EclipticMindEvolved)) maxPercentRegen += 1.5;
        if (player.hasPerk(PerkLib.HydraRegeneration) && !player.hasStatusEffect(StatusEffects.HydraRegenerationDisabled)) maxPercentRegen += 1 * player.statusEffectv1(StatusEffects.HydraTailsPlayer);
        if (player.hasPerk(PerkLib.IcyFlesh)) maxPercentRegen += 1;
        if (player.hasPerk(PerkLib.BodyCultivator)) maxPercentRegen += 0.5;
		if (player.hasPerk(PerkLib.BloodDemonToughness)) maxPercentRegen += 0.5;
        if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) maxPercentRegen += 0.5;
        if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) maxPercentRegen += 0.5;
        if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) maxPercentRegen += 0.5;
        if (player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) maxPercentRegen += 0.5;
        if (player.hasKeyItem("M.G.S. bracer") >= 0) maxPercentRegen += 2;
        if ((player.internalChimeraRating() >= 1 && player.hunger < 1 && flags[kFLAGS.HUNGER_ENABLED] > 0) || (player.internalChimeraRating() >= 1 && flags[kFLAGS.HUNGER_ENABLED] <= 0)) maxPercentRegen -= (0.5 * player.internalChimeraRating());
        return maxPercentRegen;
    }

    public function nonPercentBasedRegeneration():Number {
        var maxNonPercentRegen:Number = 0;
        if (player.hasPerk(PerkLib.Lifeline)) maxNonPercentRegen += 45 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.ImprovedLifeline)) maxNonPercentRegen += 60 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.GreaterLifeline)) maxNonPercentRegen += 90 * (1 + player.newGamePlusMod());
        if (player.hasPerk(PerkLib.EpicLifeline)) maxNonPercentRegen += 120 * (1 + player.newGamePlusMod());
        if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) maxNonPercentRegen *= 2;
        return maxNonPercentRegen;
    }

    public function maximumRegeneration():Number {
        var maxRegen:Number = 2;
        if (player.newGamePlusMod() >= 1) maxRegen += 1;
        if (player.newGamePlusMod() >= 2) maxRegen += 1;
        if (player.newGamePlusMod() >= 3) maxRegen += 1;
        if (player.newGamePlusMod() >= 4) maxRegen += 1;
        if (player.newGamePlusMod() >= 5) maxRegen += 1;
        if (player.hasPerk(PerkLib.LizanRegeneration)) maxRegen += 1.5;
        if (player.hasPerk(MutationsLib.LizanMarrow)) maxRegen += 0.5;
        if (player.hasPerk(MutationsLib.LizanMarrowPrimitive)) maxRegen += 1;
        if (player.hasPerk(MutationsLib.LizanMarrowEvolved)) {
			maxRegen += 1.5;
			if (player.HP < (player.maxHP() * 0.25)) maxRegen += 4.5;
		}
		if (player.hasPerk(MutationsLib.DraconicHeartEvolved)) maxRegen += 1;
        if (player.hasPerk(PerkLib.HydraRegeneration) && !player.hasStatusEffect(StatusEffects.HydraRegenerationDisabled)) maxRegen += 1 * player.statusEffectv1(StatusEffects.HydraTailsPlayer);
        if ((player.hasStatusEffect(StatusEffects.UnderwaterCombatBoost) || player.hasStatusEffect(StatusEffects.NearWater)) && (player.hasPerk(PerkLib.AquaticAffinity) || player.hasPerk(PerkLib.AffinityUndine)) && player.necklaceName == "Magic coral and pearl necklace") maxRegen += 1;
        //if (player.hasStatusEffect(StatusEffects.GnomeHomeBuff) && player.statusEffectv1(StatusEffects.GnomeHomeBuff) == 1) maxRegen += 15;
		if (player.statStore.hasBuff("CrinosShape") && player.hasPerk(PerkLib.ImprovingNaturesBlueprintsApexPredator)) maxRegen += 2;
        if (player.hasStatusEffect(StatusEffects.SecondWindRegen)) maxRegen += 5;
        if (player.hasStatusEffect(StatusEffects.Cauterize)) {
            maxRegen += 1.5;
            if (player.hasPerk(MutationsLib.HinezumiBurningBlood)) maxRegen += 0.5;
            if (player.hasPerk(MutationsLib.HinezumiBurningBloodPrimitive)) maxRegen += 0.5;
            if (player.hasPerk(MutationsLib.HinezumiBurningBloodEvolved)) maxRegen += 0.5;
        }
        if (player.hasPerk(PerkLib.IcyFlesh)) maxRegen += 1;
        if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) maxRegen += 0.5;
        if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) maxRegen += 0.5;
        if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) maxRegen += 0.5;
        if (player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) maxRegen += 0.5;
        if (player.armor == armors.BLIZZ_K && player.yukiOnnaScore() >= 14) maxRegen += 5;
        if (combat && player.headJewelry == headjewelries.CUNDKIN && player.HP < 1) maxRegen += 1;
        if (player.hasKeyItem("M.G.S. bracer") >= 0) maxRegen += 2;
        return maxRegen;
    }

    public function fatigueRecovery(minutes:Number = 1):void {
        var fatigue1:Number = fatigueRecovery2();
        fatigue1 *= 0.02;
		fatigue(-Math.round(fatigue1 * minutes));
    }
    public function fatigueRecovery1(combat:Boolean = true):void {
        var fatigue1:Number = 0;
        fatigue1 += fatigueRecovery2();
        if (combat) fatigue(-fatigue1);
		else {
			fatigue1 *= 2;
			fatigue(-fatigue1);
		}
    }

    public function fatigueRecovery2():Number {
        var fatiguecombatrecovery:Number = 1;
        if (player.hasPerk(PerkLib.StarSphereMastery)) fatiguecombatrecovery += player.perkv1(PerkLib.StarSphereMastery);
        if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) fatiguecombatrecovery += 1;
        if (player.hasPerk(PerkLib.EnlightenedNinetails)) fatiguecombatrecovery += 1;
        if (player.hasPerk(PerkLib.CorruptedNinetails)) fatiguecombatrecovery += 1;
        if (player.hasPerk(PerkLib.EnlightenedKitsune)) fatiguecombatrecovery += 1;
        if (player.hasPerk(PerkLib.CorruptedKitsune)) fatiguecombatrecovery += 1;
        if (player.hasPerk(PerkLib.MasteredDefenceStance)) fatiguecombatrecovery += 1;
        if (player.hasPerk(PerkLib.PerfectDefenceStance)) fatiguecombatrecovery += 1;
        if (player.hasPerk(MutationsLib.DraconicHeart)) fatiguecombatrecovery += 1;
        if (player.hasPerk(MutationsLib.DraconicHeartPrimitive)) fatiguecombatrecovery += 1;
        if (player.hasPerk(MutationsLib.DraconicHeartEvolved)) fatiguecombatrecovery += 1;
		if (player.hasPerk(MutationsLib.KitsuneParathyroidGlandsPrimitive)) fatiguecombatrecovery += 5;
        if (player.hasPerk(PerkLib.HydraRegeneration) && !player.hasStatusEffect(StatusEffects.HydraRegenerationDisabled)) fatiguecombatrecovery += 1 * player.statusEffectv1(StatusEffects.HydraTailsPlayer);
        if (player.hasPerk(PerkLib.JobGunslinger)) fatiguecombatrecovery += 1;
		if (player.hasPerk(PerkLib.AmateurGunslinger)) fatiguecombatrecovery += 1;
		if (player.hasPerk(PerkLib.ExpertGunslinger)) fatiguecombatrecovery += 1;
		if (player.hasPerk(PerkLib.MasterGunslinger)) fatiguecombatrecovery += 1;
		if (player.hasPerk(PerkLib.AlchemicalCartridge)) fatiguecombatrecovery += 2;
		if (player.hasPerk(PerkLib.ChurchOfTheGun)) fatiguecombatrecovery += 3;
		fatiguecombatrecovery *= fatigueRecoveryMultiplier();
        fatiguecombatrecovery = Math.round(fatiguecombatrecovery);
        return fatiguecombatrecovery;
    }

    public function soulforceregeneration(minutes:Number = 1):void {
		var gainedsoulforce:Number = 0;
		gainedsoulforce += soulforceregeneration2();
		gainedsoulforce *= soulforceRecoveryMultiplier();
		if (player.hasPerk(PerkLib.Necromancy)) gainedsoulforce += Math.round(player.maxSoulforce() * 0.02);
		if (player.hasPerk(PerkLib.RecoveryMantra)) gainedsoulforce += Math.round(player.maxSoulforce() * 0.02);
		gainedsoulforce = Math.round(gainedsoulforce * 0.02 * minutes);
		if (player.hasPerk(PerkLib.EnergyDependent)) gainedsoulforce = 0;
		EngineCore.SoulforceChange(gainedsoulforce, false);
	}
	public function soulforceregeneration1(combat:Boolean = true, minutes:Number = 1):void {
        var gainedsoulforce:Number = 0;
        if (combat) {
            gainedsoulforce += soulforceregeneration2();
            if (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.MasteredDefenceStance)) gainedsoulforce += 2;
            if (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.PerfectDefenceStance)) gainedsoulforce += 2;
            gainedsoulforce *= soulforceRecoveryMultiplier();
            if (player.hasPerk(PerkLib.Necromancy)) gainedsoulforce += Math.round(player.maxSoulforce() * 0.02);
            if (player.hasPerk(PerkLib.RecoveryMantra)) gainedsoulforce += Math.round(player.maxSoulforce() * 0.02);
            if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) gainedsoulforce *= 2;
            gainedsoulforce = Math.round(gainedsoulforce);
            if (player.hasPerk(PerkLib.EnergyDependent)) gainedsoulforce = 0;
            EngineCore.SoulforceChange(gainedsoulforce, false);
        }
		else {
            gainedsoulforce += soulforceregeneration2() * 2;
            gainedsoulforce *= soulforceRecoveryMultiplier();
            if (player.hasPerk(PerkLib.Necromancy)) gainedsoulforce += Math.round(player.maxSoulforce() * 0.02);
            if (player.hasPerk(PerkLib.RecoveryMantra)) gainedsoulforce += Math.round(player.maxSoulforce() * 0.02);
            gainedsoulforce = Math.round(gainedsoulforce);
            if (player.hasPerk(PerkLib.EnergyDependent)) gainedsoulforce = 0;
            EngineCore.SoulforceChange(gainedsoulforce, false);
        }
    }

    public function soulforceregeneration2():Number {
        var soulforceregen:Number = 0;
        if (player.hasPerk(PerkLib.JobSoulCultivator)) soulforceregen += 4;
        if (player.hasPerk(PerkLib.SoulApprentice)) soulforceregen += 2;
        if (player.hasPerk(PerkLib.SoulPersonage)) soulforceregen += 2;
        if (player.hasPerk(PerkLib.SoulWarrior)) soulforceregen += 2;
        if (player.hasPerk(PerkLib.SoulSprite)) soulforceregen += 3;
        if (player.hasPerk(PerkLib.SoulScholar)) soulforceregen += 3;
        if (player.hasPerk(PerkLib.SoulElder)) soulforceregen += 3;
        if (player.hasPerk(PerkLib.SoulExalt)) soulforceregen += 4;
        if (player.hasPerk(PerkLib.SoulOverlord)) soulforceregen += 4;
        if (player.hasPerk(PerkLib.SoulTyrant)) soulforceregen += 4;
        if (player.hasPerk(PerkLib.SoulKing)) soulforceregen += 5;
        if (player.hasPerk(PerkLib.SoulEmperor)) soulforceregen += 5;
        if (player.hasPerk(PerkLib.SoulAncestor)) soulforceregen += 5;
        if (player.hasPerk(MutationsLib.DraconicHeart)) soulforceregen += 4;
        if (player.hasPerk(MutationsLib.DraconicHeartPrimitive)) soulforceregen += 4;
        if (player.hasPerk(MutationsLib.DraconicHeartEvolved)) soulforceregen += 4;
		if (player.hasPerk(MutationsLib.KitsuneThyroidGlandPrimitive)) soulforceregen += 40;
        if (player.hasPerk(MutationsLib.KitsuneThyroidGlandEvolved) && player.hasPerk(PerkLib.StarSphereMastery)) soulforceregen += (player.perkv1(PerkLib.StarSphereMastery) * 4);
        return soulforceregen;
    }

    public function soulforceRecoveryMultiplier():Number {
        var multi:Number = 1;
        if (player.hasPerk(PerkLib.DaoistCultivator)) multi += 0.5;
        if (player.hasPerk(PerkLib.ControlledBreath) && player.cor < (30 + player.corruptionTolerance)) multi += 0.2;
        if (player.alicornScore() >= 12) multi += 0.1;
        if (player.kitsuneScore() >= 5) {
            if (player.kitsuneScore() >= 10) multi += 1;
            else multi += 0.5;
        }
        if (player.unicornScore() >= 10) multi += 0.05;
        return multi;
    }

    public function manaregeneration(minutes:Number = 1):void {
        var gainedmana:Number = 0;
        gainedmana += manaregeneration2();
        gainedmana *= manaRecoveryMultiplier();
        gainedmana = Math.round(gainedmana * 0.02 * minutes);
        EngineCore.ManaChange(gainedmana, false);
    }
	public function manaregeneration1(combat:Boolean = true):void {
        var gainedmana:Number = 0;
        if (combat) {
            gainedmana += manaregeneration2();
			if (player.hasPerk(PerkLib.WarMageApprentice)) gainedmana += 10;
			if (player.hasPerk(PerkLib.WarMageAdept)) gainedmana += 15;
            if (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.MasteredDefenceStance)) gainedmana += 10;
            if (player.hasStatusEffect(StatusEffects.Defend) && player.hasPerk(PerkLib.PerfectDefenceStance)) gainedmana += 10;
            if (player.statStore.hasBuff("DMorada")) gainedmana *= 1.25;
            gainedmana *= manaRecoveryMultiplier();
            if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) gainedmana *= 2;
            gainedmana = Math.round(gainedmana);
            EngineCore.ManaChange(gainedmana, false);
        }
		else {
            gainedmana += manaregeneration2() * 2;
            gainedmana *= manaRecoveryMultiplier();
            gainedmana = Math.round(gainedmana);
            EngineCore.ManaChange(gainedmana, false);
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
        if (player.hasPerk(MutationsLib.DraconicHeart)) manaregen += 5;
        if (player.hasPerk(MutationsLib.DraconicHeartPrimitive)) manaregen += 5;
        if (player.hasPerk(MutationsLib.DraconicHeartEvolved)) manaregen += 5;
        if (player.hasPerk(MutationsLib.FeyArcaneBloodstream)) manaregen += 5;
        if (player.hasPerk(MutationsLib.FeyArcaneBloodstream)) manaregen += 10;
        if (player.hasPerk(MutationsLib.FeyArcaneBloodstream)) manaregen += 15;
		if (player.hasPerk(MutationsLib.KitsuneParathyroidGlandsPrimitive)) manaregen += 30;
        if (player.hasPerk(MutationsLib.KitsuneParathyroidGlandsEvolved) && player.hasPerk(PerkLib.StarSphereMastery)) manaregen += (player.perkv1(PerkLib.StarSphereMastery) * 3);
        if (player.miscJewelry == miscjewelries.DMAGETO || player.miscJewelry2 == miscjewelries.DMAGETO) manaregen += Math.round(player.maxMana()*0.02);
        return manaregen;
    }

    public function wrathregeneration(minutes:Number = 1):void {
        var gainedwrath:Number = 0;
        if (player.hasPerk(PerkLib.AbsoluteStrength)) gainedwrath += wrathregeneration2() * 0.02 * minutes;
		else {
			var LostWrathPerTick:Number = player.maxWrath();
			LostWrathPerTick *= -0.01 * minutes;
			gainedwrath += LostWrathPerTick;
		}
		gainedwrath = Math.round(gainedwrath);
        EngineCore.WrathChange(gainedwrath, false);
    }
	public function wrathregeneration1(combat:Boolean = true):void {
        var gainedwrath:Number = 0;
        if (combat) {
            var BonusWrathMult:Number = 1;
            if (player.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult += 0.2;
            gainedwrath += wrathregeneration2() * 2 * BonusWrathMult;
            if (player.hasStatusEffect(StatusEffects.Berzerking)) gainedwrath += 6 * BonusWrathMult;
            if (player.hasStatusEffect(StatusEffects.Lustzerking)) gainedwrath += 6 * BonusWrathMult;
            if (player.hasStatusEffect(StatusEffects.Rage)) gainedwrath += 6 * BonusWrathMult;
            if (player.hasStatusEffect(StatusEffects.OniRampage)) gainedwrath += 12 * BonusWrathMult;
            if (player.statStore.hasBuff("CrinosShape")) {
                gainedwrath += 2 * BonusWrathMult;
                if (player.hasPerk(PerkLib.ImprovedCrinosShape)) gainedwrath += 2 * BonusWrathMult;
                if (player.hasPerk(PerkLib.GreaterCrinosShape)) gainedwrath += 4 * BonusWrathMult;
                if (player.hasPerk(PerkLib.MasterCrinosShape)) gainedwrath += 8 * BonusWrathMult;
            }
			if (player.statStore.hasBuff("AsuraForm")) {
				gainedwrath += 2 * BonusWrathMult;
                if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) gainedwrath += 2 * BonusWrathMult;
				if (player.hasPerk(PerkLib.AsuraStrength)) gainedwrath += 2 * BonusWrathMult;
			}
            if (player.hasPerk(PerkLib.Ferocity) && player.HP < 1) gainedwrath *= 2 * BonusWrathMult;
            EngineCore.WrathChange(gainedwrath, false);
        }
		else {
			if (player.hasPerk(PerkLib.AbsoluteStrength)) gainedwrath += wrathregeneration2();
			else {
				var LostWrathPerTick:Number = player.maxWrath();
				LostWrathPerTick *= -0.6;
				LostWrathPerTick = Math.round(LostWrathPerTick);
				gainedwrath += LostWrathPerTick;
			}
            EngineCore.WrathChange(gainedwrath, false);
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
        if (player.hasPerk(MutationsLib.DraconicHeart)) wrathregen += 1;
        if (player.hasPerk(MutationsLib.DraconicHeartPrimitive)) wrathregen += 1;
        if (player.hasPerk(MutationsLib.DraconicHeartEvolved)) wrathregen += 1;
        if (player.hasPerk(MutationsLib.OrcAdrenalGlandsEvolved)) wrathregen += 4;
        if (player.hasPerk(MutationsLib.SalamanderAdrenalGlandsEvolved)) wrathregen += 4;
        if (player.necklace == necklaces.CSNECK) {
            var csneckb:Number = 2;
            if (player.wrath >= player.wrath100 * 0.2) csneckb += 2;
            if (player.wrath >= player.wrath100 * 0.4) csneckb += 2;
            if (player.wrath >= player.wrath100 * 0.6) csneckb += 2;
            if (player.wrath >= player.wrath100 * 0.8) csneckb += 2;
            if (player.hasPerk(PerkLib.Lycanthropy)) csneckb *= 2;
            wrathregen += csneckb;
        }
        if (player.jewelry == jewelries.FLLIRNG) wrathregen += 1;
        if (player.jewelry == jewelries.INMORNG) wrathregen += 1;
        if (player.jewelry2 == jewelries.FLLIRNG) wrathregen += 1;
        if (player.jewelry2 == jewelries.INMORNG) wrathregen += 1;
        if (player.jewelry3 == jewelries.FLLIRNG) wrathregen += 1;
        if (player.jewelry3 == jewelries.INMORNG) wrathregen += 1;
        if (player.jewelry4 == jewelries.FLLIRNG) wrathregen += 1;
        if (player.jewelry4 == jewelries.INMORNG) wrathregen += 1;
        if (player.jewelry4 == jewelries.UNDKINS || player.jewelry3 == jewelries.UNDKINS || player.jewelry2 == jewelries.UNDKINS || player.jewelry == jewelries.UNDKINS) wrathregen += 3;
        if (player.hasPerk(PerkLib.BerserkerArmor)) BonusWrathMult += 1;
        //if (player.hasPerk(PerkLib.HiddenJobAsura)) BonusWrathMult *= 2;
		return wrathregen*BonusWrathMult;
    }

	public function venomCombatRechargeInfo():Number {
        var venomRecharge:Number = 0;
		venomRecharge += venomCombatRecharge2();
		if (player.hasPerk(PerkLib.HighlyVenomousDiet) && player.maxVenom() > 0) {
			if (player.maxHunger() > 1600) venomRecharge += 27.5;
			else if (player.maxHunger() > 800) venomRecharge += 22.5;
			else if (player.maxHunger() > 400) venomRecharge += 17.5;
			else if (player.maxHunger() > 200) venomRecharge += 12.5;
			else if (player.maxHunger() > 100) venomRecharge += 7.5;
			else venomRecharge += 2.5;
		}
		venomRecharge = Math.round(venomRecharge * 0.1);
		return venomRecharge;
    }
	public function venomCombatRecharge(minutes:Number = 1):void {
        var venomRecharge:Number = 0;
		venomRecharge += venomCombatRecharge2();
		if (player.hasPerk(PerkLib.HighlyVenomousDiet) && player.maxVenom() > 0) {
			if (player.maxHunger() > 1600) venomRecharge += 27.5;
			else if (player.maxHunger() > 800) venomRecharge += 22.5;
			else if (player.maxHunger() > 400) venomRecharge += 17.5;
			else if (player.maxHunger() > 200) venomRecharge += 12.5;
			else if (player.maxHunger() > 100) venomRecharge += 7.5;
			else venomRecharge += 2.5;
		}
		venomRecharge = Math.round(venomRecharge * 0.02 * minutes);
		player.tailVenom += venomRecharge;
		if (player.tailVenom > player.maxVenom()) player.tailVenom = player.maxVenom();
    }
	public function venomCombatRecharge1():void {
        player.tailVenom += venomCombatRecharge2() * 2;
		if (player.tailVenom > player.maxVenom()) player.tailVenom = player.maxVenom();
    }
	public function venomCombatRecharge2():Number {
		var venomCRecharge:Number = 0;
		if (player.maxVenom() > 0) {
			venomCRecharge += player.tailRecharge;
			if (venomCRecharge < 2.5) venomCRecharge = 5;
			if (player.hasPerk(PerkLib.ImprovedVenomGland)) venomCRecharge += 2.5;
			if (player.hasPerk(PerkLib.ImprovedVenomGlandEx)) venomCRecharge += 7.5;
			if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) venomCRecharge += 22.5;
			if (player.hasPerk(MutationsLib.VenomGlandsPrimitive)) venomCRecharge += 1;
			if (player.hasPerk(MutationsLib.VenomGlandsEvolved)) venomCRecharge += 4;
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
			if (player.hasPerk(PerkLib.HighlyVenomousDiet)) {
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
			venomCRecharge = Math.round(venomCRecharge);
		}
		return venomCRecharge;
	}

    internal var combatRound:int = 0;

    public function startCombatImpl(monster_:Monster, plotFight_:Boolean = false):void {
        combatRound = 0;
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
        monster.mana = monster.maxMana();
        monster.soulforce = monster.maxSoulforce();
        monster.XP = monster.totalXP();
        settingPCforFight();
        if (prison.inPrison && prison.prisonCombatAutoLose) {
            dynStats("lus", player.maxLust(), "scale", false);
            doNext(endLustLoss);
            return;
        }
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
        monster.mana = monster.maxMana();
        monster.soulforce = monster.maxSoulforce();
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
			player.wrath += 100;
			if (player.wrath > player.maxOverWrath()) player.wrath = player.maxOverWrath();
		}
		meleeDamageNoLag = 0;
		applyAutocast0();
        magic.applyAutocast();
        mspecials.applyAutocast2();
        if (player.weaponRange == weaponsrange.LBLASTR) {
            var milkAmmo:Number = player.lactationQ() / 100;
            if (milkAmmo > 20) milkAmmo = 20;
            player.ammo = milkAmmo;
        }
        if (player.weaponRange == weaponsrange.TWINGRA) player.ammo = 12;
        if (player.weaponRange == weaponsrange.IVIARG_) player.ammo = 12;
        if (player.weaponRange == weaponsrange.BLUNDER) player.ammo = 9;
        if (player.weaponRange == weaponsrange.TDPISTO) player.ammo = 6;
        if (player.weaponRange == weaponsrange.DESEAGL) player.ammo = 4;
        if (player.weaponRange == weaponsrange.DPISTOL) player.ammo = 3;
        if (player.weaponRange == weaponsrange.ADBSHOT) player.ammo = 2;
        if (player.weaponRange == weaponsrange.ADBSCAT) player.ammo = 2;
        if (player.weaponRange == weaponsrange.DBDRAGG) player.ammo = 2;
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
        if (player.weaponRange == weaponsrange.GTHRAXE) player.ammo = 10;
        if (player.weaponRange == weaponsrange.TRJAVEL) player.ammo = 10;
        if (player.weaponRange == weaponsrange.SHUNHAR || player.weaponRange == weaponsrange.KSLHARP || player.weaponRange == weaponsrange.LEVHARP) player.ammo = 1;
        if (player.statusEffectv1(StatusEffects.SoulDrill1) > 0) {
            player.removeStatusEffect(StatusEffects.SoulDrill1);
            player.createStatusEffect(StatusEffects.SoulDrill1, 0, 0, 0, 0);
        }
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
        outputText(monster.a + monster.short + ":</b> \n");
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
				if (monster.hasPerk(PerkLib.EnemyBossType)) generalTypes.push("Boss");
                if (monster.hasPerk(PerkLib.EnemyChampionType)) generalTypes.push("Champion");
                if (monster.hasPerk(PerkLib.EnemyEliteType)) generalTypes.push("Elite");
                if (monster.hasPerk(PerkLib.EnemyGodType)) generalTypes.push("God");
				if (monster.hasPerk(PerkLib.DarknessNature)) elementalTypes.push("Darkness Nature");
                if (monster.hasPerk(PerkLib.FireNature)) elementalTypes.push("Fire Nature");
                if (monster.hasPerk(PerkLib.IceNature)) elementalTypes.push("Ice Nature");
                if (monster.hasPerk(PerkLib.LightningNature)) elementalTypes.push("Lightning Nature");
				if (monster.hasPerk(PerkLib.DarknessVulnerability)) elementalTypes.push("Darkness Vulnerability");
                if (monster.hasPerk(PerkLib.FireVulnerability)) elementalTypes.push("Fire Vulnerability");
                if (monster.hasPerk(PerkLib.IceVulnerability)) elementalTypes.push("Ice Vulnerability");
                if (monster.hasPerk(PerkLib.LightningVulnerability)) elementalTypes.push("Lightning Vulnerability");
            }
            outputText("\n");
            if (player.hasPerk(PerkLib.EyesOfTheHunterNovice)){
                outputText("Enemy information - General: " + generalTypes.join(", ") + "\n");
                outputText("Enemy information - Elemental: " + elementalTypes.join(", ") + "\n");
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
            outputText(monster.capitalA + monster.short + " is currently wrapped up in your tail-coils!  ");
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
            monster.statStore.addBuffObject({str:-monster.statusEffectv1(StatusEffects.NagaVenom), spe:-monster.statusEffectv1(StatusEffects.NagaVenom)}, "Poison",{text:"Poison"});
            if (monster.statusEffectv3(StatusEffects.NagaVenom) >= 1 && monster.lustVuln > 0) monster.lust += monster.statusEffectv3(StatusEffects.NagaVenom);
            if (combatIsOver()) return;
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
            damage1B = calculateBasicTeaseDamage();
            if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
                damage1B *= 2;
            }
            monster.teased(Math.round(monster.lustVuln * damage1B));
            combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
            monster.statStore.addBuffObject({str:-monster.statusEffectv1(StatusEffects.ApophisVenom)*2, spe:-monster.statusEffectv1(StatusEffects.ApophisVenom)*2, tou:-monster.statusEffectv1(StatusEffects.ApophisVenom)*2}, "Poison",{text:"Poison"});
            if (monster.statusEffectv3(StatusEffects.ApophisVenom) >= 1 && monster.lustVuln > 0) monster.lust += monster.statusEffectv3(StatusEffects.ApophisVenom);
            if (combatIsOver()) return;
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
            damage1B = calculateBasicTeaseDamage();
            if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
                damage1B *= 2;
            }
            monster.teased(Math.round(monster.lustVuln * damage1B));
            combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
            monster.lustVuln += 0.05;
            monster.statStore.addBuffObject({tou:-monster.statusEffectv1(StatusEffects.ManticoreVenom)*2}, "Poison",{text:"Poison"});

            if (monster.statusEffectv3(StatusEffects.BeeVenom) >= 1 && monster.lustVuln > 0) monster.lust += monster.statusEffectv3(StatusEffects.BeeVenom);
            if (combatIsOver()) return;
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
            damage1B = calculateBasicTeaseDamage();
            if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
                damage1B *= 2;
            }
            monster.teased(Math.round(monster.lustVuln * damage1B));
            combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
            monster.lustVuln += 0.05;
            monster.statStore.addBuffObject({tou:-monster.statusEffectv1(StatusEffects.JabberwockyVenom)*2}, "Poison",{text:"Poison"});

            if (monster.statusEffectv3(StatusEffects.JabberwockyVenom) >= 1 && monster.lustVuln > 0) monster.lust += monster.statusEffectv3(StatusEffects.JabberwockyVenom);
            if (combatIsOver()) return;
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
            damage1B = calculateBasicTeaseDamage();
            if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
                damage1B *= 2;
            }
            monster.teased(Math.round(monster.lustVuln * damage1B));
            combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
            monster.statStore.addBuffObject({tou:-monster.statusEffectv1(StatusEffects.ManticoreVenom)*2}, "Poison",{text:"Poison"});
            if (monster.statusEffectv3(StatusEffects.ManticoreVenom) >= 1 && monster.lustVuln > 0) monster.lust += monster.statusEffectv3(StatusEffects.ManticoreVenom);
            if (combatIsOver()) return;
        }
        if (monster.short == "harpy") {
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
        else if (monster.short == "Minerva") {
            if (monster.lust < (monster.maxLust() * 0.4)) {
            }
            //(40)
            else if (monster.lust < (monster.maxLust() * 0.6)) outputText("Letting out a groan Minerva shakes her head, focusing on the fight at hand.  The bulge in her shorts is getting larger, but the siren ignores her growing hard-on and continues fighting.  ");
            //(60)
            else if (monster.lust < (monster.maxLust() * 0.8)) outputText("Tentacles are squirming out from the crotch of her shorts as the throbbing bulge grows bigger and bigger, becoming harder and harder... for Minerva to ignore.  A damp spot has formed just below the bulge.  ");
            //(80)
            else outputText("She's holding onto her weapon for support as her face is flushed and pain-stricken.  Her tiny short-shorts are painfully holding back her quaking bulge, making the back of the fabric look more like a thong as they ride up her ass and struggle against her cock.  Her cock-tentacles are lashing out in every direction.  The dampness has grown and is leaking down her leg.");
        } else if (monster.short == "Cum Witch") {
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
        } else if (monster.short == "Kelt") {
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
        } else if (monster.short == "green slime") {
            if (monster.lust >= (monster.maxLust() * 0.45) && monster.lust < (monster.maxLust() * 0.65)) outputText("A lump begins to form at the base of the figure's torso, where its crotch would be.  ");
            if (monster.lust >= (monster.maxLust() * 0.65) && monster.lust < (monster.maxLust() * 0.85)) outputText("A distinct lump pulses at the base of the slime's torso, as if something inside the creature were trying to escape.  ");
            if (monster.lust >= (monster.maxLust() * 0.85) && monster.lust < (monster.maxLust() * 0.93)) outputText("A long, thick pillar like a small arm protrudes from the base of the slime's torso.  ");
            if (monster.lust >= (monster.maxLust() * 0.93)) outputText("A long, thick pillar like a small arm protrudes from the base of the slime's torso.  Its entire body pulses, and it is clearly beginning to lose its cohesion.  ");
        } else if (monster.short == "Sirius, a naga hypnotist") {
            if (monster.lust < (monster.maxLust() * 0.4)) {
            } else if (monster.lust >= (monster.maxLust() * 0.4)) outputText("You can see the tip of his reptilian member poking out of its protective slit. ");
            else if (monster.lust >= (monster.maxLust() * 0.6)) outputText("His cock is now completely exposed and half-erect, yet somehow he still stays focused on your eyes and his face is inexpressive.  ");
            else outputText("His cock is throbbing hard, you don't think it will take much longer for him to pop.   Yet his face still looks inexpressive... despite the beads of sweat forming on his brow.  ");
        } else if (monster.short == "Tyrantia") {
            if (monster.lust > (monster.maxLust() * 0.5) && monster.lust < (monster.maxLust() * 0.6)) outputText("Drider Giantess's skin remains flushed with the beginnings of arousal.  ");
            if (monster.lust >= (monster.maxLust() * 0.6) && monster.lust < (monster.maxLust() * 0.7)) outputText("Drider Giantess's eyes constantly dart over your most sexual parts, betraying [monster his] lust.  ");
            if (monster.lust >= (monster.maxLust() * 0.7) && monster.lust < (monster.maxLust() * 0.8)) outputText("Drider Giantess is obviously turned on, you can smell [monster his] arousal in the air.  ");
            if (monster.lust >= (monster.maxLust() * 0.8) && monster.lust < monster.maxLust()) outputText("You can see the giantess’s back legs trembling, the armored hatch on her front gushing lubricant.  ");
        } else if (monster.short == "kitsune") {
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
            if (monster.lust > (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) outputText("The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you.");
            if (monster.lust >= (monster.maxLust() * 0.6) && monster.lust < (monster.maxLust() * 0.8)) outputText("The demons are obviously steering clear from damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow. Some are starting to cop quick feels with their other hands and you can smell the demonic lust of a dozen bodies on the air.");
            if (monster.lust >= (monster.maxLust() * 0.8)) outputText(" The demons are less and less willing to hit you and more and more willing to just stroke their hands sensuously over you. The smell of demonic lust is thick on the air and part of the group just stands there stroking themselves openly.");
        } else if (monster.short == "Aiko") {
            if (monster.lust100 > 50 && monster.lust100 < 60) outputText("Aiko’s face is slightly pink from arousal. You can see her fidgeting in her stance once or twice, biting her lip slightly.  ");
            if (monster.lust100 >= 60 && monster.lust100 < 80) outputText("Aiko’s cheeks are a deep crimson, and she breaks stance frequently to fan herself, panting visibly.  ");
            if (monster.lust100 >= 80) outputText("Aiko’s knees are trembling with barely-restrained arousal, and you can see a small puddle forming at her feet as she takes a deep breath, trying to calm her flustered nerves.  ");
        } else if (monster.short == "Yamata") {
            if (monster.lust100 < 20) outputText("Yamata seems to be fairly calm and collected, in spite of her obviously deranged nature. A barely-restrained psychosis swims just under the surface, threatening to boil over at any moment." + (monster.lust100 > 10 ? " Is she getting stronger?" : "") + "  ");
            if (monster.lust100 >= 20 && monster.lust100 < 40) outputText("Yamata is swaying a little with sadistic glee now, her psychotic grin wide and toothy. She occasionally twirls her sword around, cracking the joints in her neck from time to time and goading you into attacking. It seems like the more turned-on she becomes, the more powerful her attacks are.  ");
            if (monster.lust100 >= 40 && monster.lust100 < 60) outputText("Yamata’s movements have started to become reckless, but that only serves to make her even more dangerous. The psychotic flame in her eyes is now accompanied by a lusty gaze and an occasional lick of her lips. You’re sure of it now; the more turned-on she is, the more dangerous her attacks become.  ");
            if (monster.lust100 >= 60 && monster.lust100 < 80) outputText("Bloodlust is evident in Yamata’s eyes now, and it seems like she is subsisting on animalistic rage and adrenaline alone. Every swing is accompanied by hysterical laughter, and the smells of sex and violence emanating from her are overpowering. She’s getting more and more reckless with each swing! You should end this soon!  ");
            if (monster.lust100 >= 80) outputText("Yamata has whipped herself into a lustful berserk frenzy, lashing out with reckless abandon. All of her self control has been cast aside, and she’s putting everything she has into every attack now. If things keep going like this, she might even end up wearing herself out! Though it might be hard to hold out until she eventually burns out!  ");
        } else {
            if (monster.plural) {
                if (monster.lust > (monster.maxLust() * 0.5) && monster.lust < (monster.maxLust() * 0.6)) outputText(monster.capitalA + monster.short + "' skin remains flushed with the beginnings of arousal.  ");
                if (monster.lust >= (monster.maxLust() * 0.6) && monster.lust < (monster.maxLust() * 0.7)) outputText(monster.capitalA + monster.short + "' eyes constantly dart over your most sexual parts, betraying [monster his] lust.  ");
                if (monster.cocks.length > 0) {
                    if (monster.lust >= (monster.maxLust() * 0.7) && monster.lust < (monster.maxLust() * 0.85)) outputText(monster.capitalA + monster.short + " are having trouble moving due to the rigid protrusion in [monster his] groins.  ");
                    if (monster.lust >= (monster.maxLust() * 0.85) && monster.lust < monster.maxLust()) outputText(monster.capitalA + monster.short + " are panting and softly whining, each movement seeming to make [monster his] bulges more pronounced.  You don't think [monster he] can hold out much longer.  ");
                }
                if (monster.vaginas.length > 0) {
                    if (monster.lust >= (monster.maxLust() * 0.7) && monster.lust < (monster.maxLust() * 0.85)) outputText(monster.capitalA + monster.short + " are obviously turned on, you can smell [monster his] arousal in the air.  ");
                    if (monster.lust >= (monster.maxLust() * 0.85) && monster.lust < monster.maxLust()) outputText(monster.capitalA + monster.short + "' " + monster.vaginaDescript() + "s are practically soaked with their lustful secretions.  ");
                }
            } else {
                if (monster.lust > (monster.maxLust() * 0.5) && monster.lust < (monster.maxLust() * 0.6)) outputText(monster.capitalA + monster.short + "'s skin remains flushed with the beginnings of arousal.  ");
                if (monster.lust >= (monster.maxLust() * 0.6) && monster.lust < (monster.maxLust() * 0.7)) outputText(monster.capitalA + monster.short + "'s eyes constantly dart over your most sexual parts, betraying [monster his] lust.  ");
                if (monster.cocks.length > 0) {
                    if (monster.lust >= (monster.maxLust() * 0.7) && monster.lust < (monster.maxLust() * 0.85)) outputText(monster.capitalA + monster.short + " is having trouble moving due to the rigid protrusion in [monster his] groin.  ");
                    if (monster.lust >= (monster.maxLust() * 0.85) && monster.lust < monster.maxLust()) outputText(monster.capitalA + monster.short + " is panting and softly whining, each movement seeming to make [monster his] bulge more pronounced.  You don't think [monster he] can hold out much longer.  ");
                }
                if (monster.vaginas.length > 0) {
                    if (monster.lust >= (monster.maxLust() * 0.7) && monster.lust < (monster.maxLust() * 0.85)) outputText(monster.capitalA + monster.short + " is obviously turned on, you can smell [monster his] arousal in the air.  ");
                    if (monster.lust >= (monster.maxLust() * 0.85) && monster.lust < monster.maxLust()) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " is practically soaked with her lustful secretions.  ");
                }
            }
        }
    }

    // Just text should force the function to purely emit the test text to the output display, and not have any other side effects
    public function tease(justText:Boolean = false):void {
        teases.tease(justText);
    }

    public function teaseXP(XP:Number = 0):void {
        if (player.armor == armors.SCANSC) player.SexXP(XP);
        player.SexXP(XP);
    }

	private function weaponmasteryXPMulti():Number {
		var multi:Number = 1;
		if (player.humanScore() >= player.humanMaxScore() - 9) {
			multi += 1;
			if (player.humanScore() == player.humanMaxScore()) multi += 1;
		}
		if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 4) multi *= 3;
		if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 3) multi *= 2;
        return multi;
	}

	public function feralCombatXP(XP:Number = 0):void {
		player.feralCombatXP(XP * weaponmasteryXPMulti());
    }
	public function gauntletXP(XP:Number = 0):void {
		player.gauntletXP(XP * weaponmasteryXPMulti());
    }
	public function swordXP(XP:Number = 0):void {
		player.swordXP(XP * weaponmasteryXPMulti());
    }
	public function axeXP(XP:Number = 0):void {
		player.axeXP(XP * weaponmasteryXPMulti());
    }
	public function macehammerXP(XP:Number = 0):void {
		player.macehammerXP(XP * weaponmasteryXPMulti());
    }
	public function duelingswordXP(XP:Number = 0):void {
		player.duelingswordXP(XP * weaponmasteryXPMulti());
    }
	public function polearmXP(XP:Number = 0):void {
		player.polearmXP(XP * weaponmasteryXPMulti());
    }
	public function spearXP(XP:Number = 0):void {
		player.spearXP(XP * weaponmasteryXPMulti());
    }
	public function daggerXP(XP:Number = 0):void {
		player.daggerXP(XP * weaponmasteryXPMulti());
    }
	public function whipXP(XP:Number = 0):void {
		player.whipXP(XP * weaponmasteryXPMulti());
    }
	public function exoticXP(XP:Number = 0):void {
		player.exoticXP(XP * weaponmasteryXPMulti());
    }

	public function archeryXP(XP:Number = 0):void {
		player.archeryXP(XP * weaponmasteryXPMulti());
    }
	public function throwingXP(XP:Number = 0):void {
		player.throwingXP(XP * weaponmasteryXPMulti());
    }
	public function firearmsXP(XP:Number = 0):void {
		player.firearmsXP(XP * weaponmasteryXPMulti());
    }

	public function dualWieldSmallXP(XP:Number = 0):void {
		player.dualWieldSmallXP(XP * weaponmasteryXPMulti());
    }
	public function dualWieldNormalXP(XP:Number = 0):void {
		player.dualWieldNormalXP(XP * weaponmasteryXPMulti());
    }
	public function dualWieldLargeXP(XP:Number = 0):void {
		player.dualWieldLargeXP(XP * weaponmasteryXPMulti());
    }
	public function dualWieldFirearmsXP(XP:Number = 0):void {
		player.dualWieldFirearmsXP(XP * weaponmasteryXPMulti());
    }

    //VICTORY OR DEATH?
    // Called after the monster's action. Increments round counter. Setups doNext to win/loss/combat menu
    public function combatRoundOver():void {
        var HPPercent:Number;
        HPPercent = player.HP/player.maxHP();
        combatRound++;
        player.statStore.advanceTime(Buff.RATE_ROUNDS,1);
        monster.statStore.advanceTime(Buff.RATE_ROUNDS,1);
        if (player.statStore.recentlyRemovedTags["WarriorsRage"]){
			EngineCore.outputText("\nYour warriors rage has ended.\n");
        }
        if (player.statStore.recentlyRemovedTags["Might"]){
			if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx) && player.mana >= CombatAbilities.Might.manaCost()) CombatAbilities.Might.autocast();
			else EngineCore.outputText("\nYour powers wanes as your Might spell ends.\n");
        }
        if (player.statStore.recentlyRemovedTags["Blink"]){
			if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx) && player.mana >= CombatAbilities.Blink.manaCost()) CombatAbilities.Blink.autocast();
			else EngineCore.outputText("\nYour speeds wanes as your Blink spell ends.\n");
        }
        statScreenRefresh();
        flags[kFLAGS.ENEMY_CRITICAL] = 0;
        player.HP = HPPercent*player.maxHP();
        combatIsOver();
    }

    // Returns true if combat is over. Setups doNext to win/loss/combat menu
    public function combatIsOver():Boolean {
        if (!inCombat) return false;
        if (monster.HP <= monster.minHP()) {
            doNext(endHpVictory);
            return true;
        }
        if (monster.lust > monster.maxLust()) {
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
        if (monster.short == "basilisk" && player.spe <= 1) {
            doNext(endHpLoss);
            return true;
        }
        if (player.HP <= player.minHP()) {
            doNext(endHpLoss);
            return true;
        }
        if (player.lust >= player.maxOverLust()) {
            doNext(endLustLoss);
            return true;
        }
        doNext(playerMenu); //This takes us back to the combatMenu and a new combat round
        return false;
    }

    public function OrcaJuggle():void {
        clearOutput();
        if (player.statusEffectv1(StatusEffects.OrcaCanJuggleStill) == 2 && !player.hasPerk(MutationsLib.WhaleFatEvolved)) {
            outputText("You have already juggled twice.");
            addButton(0, "Next", combatMenu, false);
            return;
        }
        if (player.statusEffectv1(StatusEffects.OrcaCanJuggleStill) == 3 && player.hasPerk(MutationsLib.WhaleFatEvolved)) {
            outputText("You have already juggled three time.");
            addButton(0, "Next", combatMenu, false);
            return;
        }
        if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
            outputText("You are too tired to juggle with [monster a] [monster name].");
            addButton(0, "Next", combatMenu, false);
        } else {
            fatigue(20, USEFATG_PHYSICAL);
            var damage:Number = unarmedAttack();
            damage += player.str;
            damage += scalingBonusStrength() * 0.25;
            if (damage < 10) damage = 10;
            if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= historyFighterBonus();
            if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
            if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
            if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
            if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
            if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
			if (player.armor == armors.SPKIMO) damage *= 1.2;
            if (player.hasPerk(PerkLib.OniTyrantKimono || PerkLib.OniEnlightenedKimono)) damage *= 1.4;
            if (player.necklace == necklaces.OBNECK) damage *= 1.2;
            if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
            if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
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
            if (player.hasPerk(MutationsLib.WhaleFatPrimitive)) player.addStatusValue(StatusEffects.OrcaPlayRoundLeft, 1, +1);
            player.addStatusValue(StatusEffects.OrcaCanJuggleStill, 1, +1);
            if (player.statusEffectv1(StatusEffects.OrcaCanJuggleStill) == 1) {
                if (!player.hasPerk(MutationsLib.WhaleFatEvolved)) {
                    outputText("\n\nYou can still juggle one more time. ");
                } else {
                    outputText("\n\nYou can still juggle two more time. ");
                }
            }
            if (player.statusEffectv1(StatusEffects.OrcaCanJuggleStill) == 2) {
                if (!player.hasPerk(MutationsLib.WhaleFatEvolved)) {
                    outputText("\n\nYou cannot juggle any further. ");
                } else {
                    outputText("\n\nYou can still juggle one more time. ");
                }
            }
            if (player.statusEffectv1(StatusEffects.OrcaCanJuggleStill) == 3) {
                outputText("\n\nYou cannot juggle any further. ");
            }
            outputText("\n\n" + player.statusEffectv1(StatusEffects.OrcaPlayRoundLeft) + " rounds to play  left.\n\n");
            enemyAI();
        }
    }

    public function OrcaCleanup():void {
        player.addStatusValue(StatusEffects.OrcaPlayRoundLeft, 1, -1);
        if (player.statusEffectv1(StatusEffects.OrcaPlayRoundLeft) <= 0) {
            outputText("\n\nUnable to prolong the game further you finally let your opponent drop to the ground. ");
            var damage:Number = unarmedAttack();
            damage += player.str;
            damage += scalingBonusStrength() * 0.25;
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
        enemyAI();
    }

    public function OrcaWack():void {
        clearOutput();
        if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
            outputText("You are too tired to wack your opponent with your tail.");
            addButton(0, "Next", combatMenu, false);
        } else {
            fatigue(20, USEFATG_PHYSICAL);
            var damage:Number = unarmedAttack();
            damage += player.str;
            damage += scalingBonusStrength() * 0.25;
            if (damage < 10) damage = 10;
            if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= historyFighterBonus();
            if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
            if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
            if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
            if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
            if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
			if (player.armor == armors.SPKIMO) damage *= 1.2;
            if (player.hasPerk(PerkLib.OniTyrantKimono || PerkLib.OniEnlightenedKimono)) damage *= 1.4;
            if (player.necklace == necklaces.OBNECK) damage *= 1.2;
            if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
            if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
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
        if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
            outputText("You are too tired to smash your opponent.");
            addButton(0, "Next", combatMenu, false);
        } else {
            fatigue(20, USEFATG_PHYSICAL);
            var damage:Number = player.str;
            damage += scalingBonusStrength() * 0.25;
            if (player.hasPerk(PerkLib.HoldWithBothHands) && !player.isFistOrFistWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) damage *= 1.2;
            if (damage < 10) damage = 10;
            if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.03));
            else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (2.5 + ((player.weaponAttack - 50) * 0.025));
            else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (3.75 + ((player.weaponAttack - 100) * 0.02));
            else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (4.75 + ((player.weaponAttack - 150) * 0.015));
            else damage *= (5.5 + ((player.weaponAttack - 200) * 0.01));
            if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= historyFighterBonus();
            if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
            if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
            if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
            if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
            if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
			if (player.armor == armors.SPKIMO) damage *= 1.2;
            if (player.hasPerk(PerkLib.OniTyrantKimono || PerkLib.OniEnlightenedKimono)) damage *= 1.4;
            if (player.necklace == necklaces.OBNECK) damage *= 1.2;
            if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
            if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
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
        if (player.isSpearTypeWeapon() || player.isSwordTypeWeapon()) {
            outputText("You cannot impale your foe without a piercing weapon.");
            addButton(0, "Next", combatMenu, false);
        } else {
            fatigue(20, USEFATG_PHYSICAL);
            var damage:Number = player.str;
            var SAMulti:Number = 1;
            if (player.level >= 6) SAMulti += 1;
            if (player.level >= 12) SAMulti += 1;
            if (player.level >= 18) SAMulti += 1;
            if (player.level >= 24) SAMulti += 1;
            if (player.level >= 30) SAMulti += 1;
            if (player.level >= 36) SAMulti += 1;
            damage += scalingBonusStrength() * 0.25;
            if (player.hasPerk(PerkLib.HoldWithBothHands) && !player.isFistOrFistWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) damage *= 1.2;
            if (damage < 10) damage = 10;
            if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.03));
            else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (2.5 + ((player.weaponAttack - 50) * 0.025));
            else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (3.75 + ((player.weaponAttack - 100) * 0.02));
            else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (4.75 + ((player.weaponAttack - 150) * 0.015));
            else damage *= (5.5 + ((player.weaponAttack - 200) * 0.01));
            if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= historyFighterBonus();
            if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
            if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
            if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
            if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
            if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
			if (player.armor == armors.SPKIMO) damage *= 1.2;
            if (player.hasPerk(PerkLib.OniTyrantKimono || PerkLib.OniEnlightenedKimono)) damage *= 1.4;
            if (player.necklace == necklaces.OBNECK) damage *= 1.2;
            if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
            if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
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
				damage *= (1.75 + buffMultiplier);
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
            damage = unarmedAttack();
            damage += player.str;
            damage += scalingBonusStrength() * 0.25;
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
            enemyAI();
        }
    }

    public function OrcaLeggoMyEggo():void {
        clearOutput();
        outputText("You let [monster a] [monster name] drop, tired of playing.");
        var damage:Number = unarmedAttack();
        damage += player.str;
        damage += scalingBonusStrength() * 0.25;
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
        enemyAI();
    }

    public function CancerGrab():void {
        flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
        clearOutput();
        if (monster.plural) {
            outputText("You cannot grab a single target while fighting multiple opponents at the same times!");
            addButton(0, "Next", combatMenu, false);
        }
        if (player.fatigue + physicalCost(10) > player.maxFatigue()) {
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
        if(monster.plural) {
            if (monster.hasStatusEffect(StatusEffects.Dig))
            {
                outputText("You begin to dig up toward [themonster], but with multiple enemies, grabbing one up would leave you completely open to attack.  You halt your progression and dig back down before you expose yourself to danger.");
                outputText("\n\n");
                SceneLib.combat.enemyAIImpl();
                return;
            }
            else {
                outputText("You launch yourself at [themonster], but with multiple enemies, grabbing one up would leave you completely open to attack.  You hastily dig backwards before you expose yourself to danger.");
                outputText("\n\n");
                SceneLib.combat.enemyAIImpl();
                return;
            }
        }
        fatigue(10, USEFATG_PHYSICAL);
		if (checkConcentration()) return; //Amily concentration
        //WRAP IT UPPP
        if (monster.hasStatusEffect(StatusEffects.Dig)) {
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
            outputText("You launch yourself at your opponent,");
            if (40 + rand(player.spe) > monster.spe) {
                outputText("grabbing it with your powerful pincers as you prepare to crush it to death.");
            }
            //Failure
            else {
                //Failure (-10 HPs) -
                outputText("Sadly, you miss by a mere inch. Your opponent escapes your grapple attempt.");
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
        enemyAI();
    }

    public function Tremor():void {
        flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
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
        if (player.fatigue + physicalCost(10) > player.maxFatigue()) {
            clearOutput();
            outputText("You just don't have the energy to create a tremor right now...");
            //Gone		menuLoc = 1;
            menu();
            addButton(0, "Next", combatMenu, false);
            return;
        }
        fatigue(10, USEFATG_PHYSICAL);
        //WRAP IT UPPP
        outputText("You wriggle underground, collapsing the tunnel behind you. You shake, causing some serious seismic activity. [monster a] [monster name] loses [monster his] balance, falling to the ground, dazed. ");
        damage = unarmedAttack();
        damage *= player.tallness / 10;
        damage *= scalingBonusStrength() * 0.5;
        if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
        if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
        if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
        if (monster.plural) damage *= 5;
        damage = Math.round(damage);
        doPhysicalDamage(damage, true, true);
        monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
        player.createStatusEffect(StatusEffects.CooldownTremor, 5, 0, 0, 0);
        outputText("\n\n");
        enemyAI();
    }

    public function calculateBasicTeaseDamage(BaseTeaseDamage:Number = 18):Number {
        var damage:Number = BaseTeaseDamage + rand(6);
        var bimbo:Boolean = false;
        var bro:Boolean = false;
        var futa:Boolean = false;

        if (player.hasPerk(PerkLib.BimboBody)) bimbo = true;
        if (player.hasPerk(PerkLib.BroBody)) bro = true;
        if (player.hasPerk(PerkLib.FutaForm)) futa = true;

        if (player.hasPerk(PerkLib.SensualLover)) damage += 6;
        if (player.hasPerk(PerkLib.Seduction)) damage += 15;
        if (player.hasPerk(PerkLib.SluttySeduction)) damage += (2 * player.perkv1(PerkLib.SluttySeduction));
        if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += (2 * player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction));
        if (bimbo || bro || futa) {
            damage += 15;
        }
        //partial skins bonuses
        switch (player.coatType()) {
            case Skin.FUR:
                damage += (1 + player.newGamePlusMod());
                break;
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
        if (player.hasPerk(PerkLib.FlawlessBody)) damage += 20;
        damage += scalingBonusLibido() * 0.2;
        if (player.hasPerk(PerkLib.JobSeducer)) damage += player.teaseLevel * 3;
        else damage += player.teaseLevel * 2;
        if (player.hasPerk(PerkLib.JobCourtesan) && monster.hasPerk(PerkLib.EnemyBossType)) damage *= 1.2;

        var damagemultiplier:Number = 1;
        if (player.hasPerk(PerkLib.ElectrifiedDesire)) damagemultiplier += player.lust100 * 0.01;
        if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) damagemultiplier += combat.historyWhoreBonus();
        if (player.hasPerk(PerkLib.DazzlingDisplay)) damagemultiplier += 0.2;
        if (player.hasPerk(PerkLib.SuperSensual)) damagemultiplier += 0.50;
        if (player.hasPerk(PerkLib.SluttySimplicity) && player.armorName == "nothing") damage *= (1 + ((10 + rand(11)) / 100));
        if (player.armorName == "desert naga pink and black silk dress") damagemultiplier += 0.1;
        if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
        damage *= damagemultiplier;
        if (player.hasPerk(PerkLib.ChiReflowLust)) damage *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
        if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) damage *= 1.5;
        damage = (damage * monster.lustVuln);
        if (SceneLib.urtaQuest.isUrta()) damage *= 2;
        damage = Math.round(damage);
        return damage;
    }

    public function Straddle():void {
        flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
        clearOutput();
            if (player.fatigue + physicalCost(10) > player.maxFatigue()) {
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
            enemyAI();
    }

    private var StraddleDamage:Number
    private var Randomcrit:Boolean;
    public function StraddleTease():void {
        clearOutput();
        var bonusDamage:int = 10;
        StraddleDamage = calculateBasicTeaseDamage(20+rand(bonusDamage));
        if (player.hasPerk(MutationsLib.ManticoreMetabolismEvolved) && player.tail.type == Tail.MANTICORE_PUSSYTAIL) StraddleDamage *= 2;
        //Determine if critical tease!
        Randomcrit = false;
        var critChance:int = 5;
        if (player.hasPerk(PerkLib.CriticalPerformance)) {
            if (player.lib <= 100) critChance += player.lib / 5;
            if (player.lib > 100) critChance += 20;
        }
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            Randomcrit = true;
            StraddleDamage *= 1.75;
        }
        StraddleDamage = (StraddleDamage) * monster.lustVuln;
        if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) StraddleDamage *= 2;
        StraddleDamage = Math.round(StraddleDamage);

        //Select the scene
        var TeaseFunctionList:Array = [RandomTeaseKiss];
        if (monster.hasCock() > 0) {
            if (player.tail.type == Tail.DEMONIC || player.tail.type == Tail.MOUSE || player.tail.type == Tail.THUNDERBIRD || player.tail.type == Tail.HINEZUMI) TeaseFunctionList.push(RandomTeaseStranglingTail);
            if (player.tail.type == Tail.MANTICORE_PUSSYTAIL) TeaseFunctionList.push(RandomTeaseManticoreTailfuckInitiate);
        }
        if (player.tail.type == Tail.MANTICORE_PUSSYTAIL && player.tailVenom >= player.VenomWebCost()) TeaseFunctionList.push(RandomTeaseManticoreTailSpike);
        if (player.tail.type == Tail.LIZARD || player.tail.type == Tail.CAVE_WYRM || player.tail.type == Tail.SALAMANDER) TeaseFunctionList.push(RandomTeaseButtfuckTail);
        if (player.lowerBody == LowerBody.PLANT_FLOWER){
            if (player.isLiliraune()) TeaseFunctionList.push(RandomTeaseLiliraune);
            else TeaseFunctionList.push(RandomTeaseAlraune);
        }
        if (player.rearBody.type == RearBody.DISPLACER_TENTACLES) TeaseFunctionList.push(RandomTeaseDisplacerMilkingInitiate);
        if (player.lowerBody == LowerBody.GOO){
            TeaseFunctionList.push(RandomTeaseSlime);
            TeaseFunctionList.push(RandomTeaseSlimeInsert());
        }
        if (player.countCocksOfType(CockTypesEnum.ANEMONE) > 0) TeaseFunctionList.push(RandomTeaseAnemone);
        if (player.hasPerk(PerkLib.ElectrifiedDesire)) TeaseFunctionList.push(RandomTeaseRaiju);
        if (player.hasPerk(PerkLib.DragonLustPoisonBreath) && player.tailVenom >= player.VenomWebCost()) TeaseFunctionList.push(RandomTeaseJabberwocky);
        if (player.harpyScore() >= 8  || player.thunderbirdScore() >= 10 || player.phoenixScore() >= 10) TeaseFunctionList.push(RandomTeaseHarpy);
        if (player.kitsuneScore() >= 8) TeaseFunctionList.push(RandomTeaseKitsune);
        if (player.hasPerk(MutationsLib.BlackHeart)) TeaseFunctionList.push(RandomTeaseLustStrike);
        if (monster.hasBreasts()) TeaseFunctionList.push(RandomTeaseViolateOpponentBreast);
        if (monster.hasVagina()) {
            TeaseFunctionList.push(RandomTeaseViolateOpponentPussy);
            if (player.tongue.type == Tongue.DEMONIC || player.tongue.type == Tongue.DRACONIC || player.tongue.type == Tongue.SNAKE) TeaseFunctionList.push(RandomTeaseLongTongue);
        }
        if (monster.hasCock()) {
            TeaseFunctionList.push(RandomTeaseIfEnnemyCock);
            if (player.hasVagina() && !player.hasVirginVagina()) TeaseFunctionList.push(RandomTeaseIfEnnemyCockIfPCNoVirgin);
        }
        var ChosenTease:Function = randomChoice(TeaseFunctionList);
        ChosenTease();
        combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
        outputText("\n\n");
        if (player.hasPerk(PerkLib.DemonEnergyThirst) || player.hasPerk(PerkLib.KitsuneEnergyThirst)) {
            outputText("You gasp in delight as you drink on your victim's energy to replenish your own, feeding of [monster his] pleasure. ");
            if (player.hunger < player.maxHunger())
            {
                player.refillHunger(2, false);
            }
            if (player.HP < player.maxHP()) {
                EngineCore.HPChange(25 + (player.tou/2), true);
            }
            if (player.mana < player.maxMana()) {
                EngineCore.ManaChange(25 + (player.inte/2), true);
            }
            EngineCore.changeFatigue(-(25 + (player.spe/2)));
            if (player.soulforce < player.maxSoulforce() && player.hasPerk(PerkLib.KitsuneEnergyThirst)) {
                EngineCore.SoulforceChange(100 + (player.wis*2), true);
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
        enemyAI();
    }

    public function RandomTeaseKiss():void {
        outputText("You pull in [monster a] [monster name] into a wild french kiss, forcing your tongue in as you begin to choke the protest out of [monster him]. " +
                "Your opponent starts to struggle, shoving you off his face. They stagger back, doing [monster his] best not to show how much this aroused [monster him].");
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
    }

    public function RandomTeaseIfEnnemyCock():void {
        outputText("You gently and skillfully begin to stroke [monster a] [monster name] " + monster.cockDescriptShort() + " giving the tip a wet kiss every now and then in order to coax the delicious pre out, " +
                "your saliva dripping from the length. [monster a] [monster name] mouths open to let out a confused moan as you work [monster his] tool. ");
        if (monster.balls > 0) outputText("Your second hand is busy massaging the ball sack beneath, " +
                "intent on speeding up the inevitable and messy orgasm your skillful play will force out of [monster him]. ");
        outputText("Your opponent finally tries to fight back, forcing you to unwrap your grip on [monster his] dick momentarily. You back off, but the damage is already done.");
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
    }

    public function RandomTeaseIfEnnemyCockIfPCNoVirgin():void {
        outputText("You lower yourself onto [monster a] [monster name] " + monster.cockDescriptShort() + " and begin to gently gyrate your hips, " +
                "drooling from your mouth as you drink in the pleasure. [monster a] [monster name] mouths open to let out a confused moan as you work [monster his] tool. " +
                "You bounce up and down the rod, keeping your pussy tightly wrapped around [monster a] [monster name]'s aching member in order to speed up the inevitable and messy orgasm your " +
                "skilled cunt will force out of [monster him]. Your opponent finally fights back, forcing you up and off [monster his] dick. You back off, but the damage is already done, your foe's arousal clear. " +
                "And you lick your lips still riding on your own pleasure.");
        StraddleDamage *= 1.5;
        StraddleDamage = Math.round(StraddleDamage);
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
        player.lust += (20 * (1 + monster.newGamePlusMod()));
    }

    public function RandomTeaseStranglingTail():void {
        outputText("You wrap your prehensile tail around [monster a] [monster name] " + monster.cockDescriptShort() + " and skillfully begin to stroke it, your tail tip poking inside the urethra every now and then, " +
                "pre gushing out through whatever space is left between. [monster a] [monster name]'s mouth opens to let out a confused moan as you work [monster his] tool. ");
        if (monster.balls > 0) outputText("Your hand is busy massaging the ball sack beneath, intent on speeding up the inevitable and messy orgasm your skillful play will force out of [monster him].");
        outputText("Your opponent finally fights back, forcing you to unwrap your tail from them. You back off, but the damage has already been done.");
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
    }

    public function RandomTeaseButtfuckTail():void {
        outputText("You smile mischievously as you insert inch after inch of your tail into your opponent, slowly stretching that cute pucker of [monster his], " +
                "[monster a] [monster name]'s eyes widen as you slowly proceed to analy tail fuck [monster him]. Ahhh such tightness in that hole. " +
                "Sadly it only lasts for a while before [monster he] finally fights back. " +
                "You give [monster a] a smirk and a wink, yanking your tail out in one go. You get back into a fighting stance, but the damage is already done.");
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
    }

    public function RandomTeaseViolateOpponentBreast():void {
        outputText("You begin to groppe [monster a] [monster name] " + monster.breastDescript(0) + " with both hands, licking the areola and smirking knowingly as the tips hardens in reaction. " +
                "[monster a] [monster name] moans coax you in doubling up the attention your tongue circling a nipple then moving to the other. " +
                "It takes great effort from [monster a] [monster name] to snap out and force you off [monster his] tormented chest but the blush you see on [monster his] cheeks was worth it.");
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
    }

    public function RandomTeaseViolateOpponentPussy():void {
        outputText("You mischievously begin to finger [monster a] [monster name] " + monster.vaginaDescript() + " forcing a surprised moan out of [monster him] as you attack [monster his] clitoris relentlessly. " +
                "clear, sticky pre coats your hand, a clear sign of your victim's pleasure as you rub their clit." +
                "It takes great effort from [monster a] [monster name], [monster he] lets loose a cry, breaking your hold and forcing your fingers from [monster his] tormented cunt. You back off, but you see their blushing cheeks.");
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
    }

    public function RandomTeaseLongTongue():void {
        outputText("Oh god, [monster a] [monster name] had it coming as you prepare yourself to use your strongest weapon. " +
                "Your long prehensile tongue slides into [monster a] [monster name] " + monster.vaginaDescript() + " like a tentacle, striking the sweet spot with unerring precision. " +
                "Your almost jerk your victim's clit with your flexible tongue, forcing out delirious moans from [monster a] [monster name] as [monster his] knee goes weak from your ministration. " +
                "In desperation [monster he] punches you in the face. Your head whipped back, you're forced to pull your tongue out of [monster his] tormented cunt. You back off, but your foe is blushing madly, beads of sweat" +
                "on [monster his] forehead. Your opponent is so staggered by your expert tongueing that you easily keep [monster him] pinned. ");
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
        player.addStatusValue(StatusEffects.StraddleRoundLeft, 1, +1);
    }

    public function RandomTeaseManticoreTailSpike():void {
        outputText("Taking advantage of your opponent's precarious position, you reach back and grab one of your back-spikes. " +
                "You grin widely as you bring your hand down, stabbing your opponent with your venomous spike. You bat aside their clumsy attempt at a block, stabbing them again and again. With each stab, venom frothes from the spike, and blood spills from the deep injuries." +
                "Your victim eventually rallies, blocking your wrist, then knocking the spike from your hand. You jump off them before they can strike you, but as they fight their way upright, you can tell that it was worth it");
        if (player.hasPerk(MutationsLib.ManticoreMetabolismEvolved) && player.tail.type == Tail.MANTICORE_PUSSYTAIL) StraddleDamage *= 2;
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
		var dam4Ba:Number = 1;
		if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) dam4Ba *= 2;
        monster.statStore.addBuffObject({tou:-(dam4Ba*6)}, "Poison",{text:"Poison"});
        if (monster.hasStatusEffect(StatusEffects.ManticoreVenom)) {
            monster.addStatusValue(StatusEffects.ManticoreVenom, 3, dam4Ba);
        } else monster.createStatusEffect(StatusEffects.ManticoreVenom, 0, 0, dam4Ba, 0);
        player.tailVenom -= player.VenomWebCost();
		flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
    }

    public function RandomTeaseManticoreTailfuckInitiate():void {
        outputText("You lick your lips and hold your victim down as you get into position,  engulfing [monster a] [monster name] juicy " + monster.cockDescriptShort() + " with your tail pussy. You’re going to milk that cumpump for what its worth.");
        var DurationLeft:int = player.statusEffectv1(StatusEffects.StraddleRoundLeft);
        var BasePlugDuration:int = 1;
        if (player.hasPerk(MutationsLib.ManticoreMetabolismEvolved)) BasePlugDuration += 3;
        monster.createStatusEffect(StatusEffects.ManticorePlug, BasePlugDuration + rand(3), DurationLeft, 0, 0);
        player.removeStatusEffect(StatusEffects.StraddleRoundLeft);
        monster.removeStatusEffect(StatusEffects.Straddle);
    }

    public function RandomTeaseDisplacerMilkingInitiate():void {
        outputText("You lick your lips in anticipation as you hold your victim's arms to the ground and plug your two tentacle suckers to [monster his] breasts. " +
                "[monster he] struggles, flushing red as you flood [monster his] nipples with your lactation inducing venom and begin to force the delicious milk out of [monster his] chest. ");
        var DurationLeft:int = player.statusEffectv1(StatusEffects.StraddleRoundLeft);
        monster.createStatusEffect(StatusEffects.DisplacerPlug, DurationLeft + rand(3), 0, 0, 0);
        player.removeStatusEffect(StatusEffects.StraddleRoundLeft);
        monster.removeStatusEffect(StatusEffects.Straddle);
    }

    public function RandomTeaseJabberwocky():void {
        outputText("You inhale deeply before forcing yourself in, kissing your foe. You force their mouth open, breathing poison directly down [monster His] throat!");
        var dam4Ba:Number = 1;
        var Multiplier:Number = 1;
        if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) Multiplier += 1;
        if (player.hasPerk(MutationsLib.DrakeLungs)) Multiplier += 2;
        if (player.hasPerk(MutationsLib.DrakeLungsPrimitive)) Multiplier += 2;
        if (player.hasPerk(MutationsLib.DrakeLungsEvolved)) Multiplier += 2;
        if (player.hasPerk(MutationsLib.DrakeLungsFinalForm)) Multiplier += 2;
        if (player.hasPerk(PerkLib.RacialParagon)) Multiplier += 0.5;
        if (player.hasPerk(PerkLib.Apex)) Multiplier += 0.5;
        if (player.hasPerk(PerkLib.AlphaAndOmega)) Multiplier += 0.5;
        if (player.hasPerk(PerkLib.NaturalArsenal)) Multiplier += 0.5;
        dam4Ba *= Multiplier;
        monster.statStore.addBuffObject({tou:-(dam4Ba*2)}, "Poison",{text:"Poison"});
        if (monster.hasStatusEffect(StatusEffects.JabberwockyVenom)) {
            monster.addStatusValue(StatusEffects.JabberwockyVenom, 3, dam4Ba);
        } else monster.createStatusEffect(StatusEffects.JabberwockyVenom, 0, 0, dam4Ba, 0);
        player.tailVenom -= player.VenomWebCost();
        StraddleDamage *= 1+(scalingBonusToughness()*2/100);
        StraddleDamage *= 2;
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
        monster.lustVuln += 0.50;
    }

    public function RandomTeaseRaiju():void {
        outputText("You begin gathering up electricity before discharging it into your opponent's genitals at point blank range. [monster His] ");
        if (monster.hasCock()) outputText("cock begins shooting an endless flow of cum");
        if (monster.hasCock() && monster.hasVagina()) outputText(" as [monster his]");
        if (monster.hasVagina()) outputText(" pussy starts gushing like a fountain, lips swelling like a blooming flower. ");
        if (monster.hasCock() && monster.hasVagina()) outputText("They");
        else outputText("It");
        outputText(" pulse");
        if (monster.hasCock() && monster.hasVagina()) outputText("s");
        outputText(" with your current at the rhythm of [monster a] [monster name] owns heartbeat.");
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
        monster.lustVuln += 0.50;
    }

    public function RandomTeaseHarpy():void {
        outputText("You wrap your wings around [monster a] [monster name], firmly planting your plush backside down onto [monster his] cock and slipping it between your cheeks. " +
                "Your soft ass completely engulfs [monster his] dick and hugs it tightly. " +
                "You moving your hips up and down massaging and stroking it between your warm soft flesh. You pull [monster a] [monster name] into a kiss, " +
                "your drug laced lipstick already having an effect on [monster him]. " +
                "[monster His] pre drooling " + monster.cockDescriptShort() + " twitches and strains between your plush cheeks making them slicker. " +
                "You giggle planting a few more kisses around [monster his] mouth and neck as you push [monster him] closer to the edge. " +
                "Your opponent finally fights back, forcing you to release [monster his] dick from between your cheeks. You push off, getting back into a fighting stance, almost laughing as you see [monster him] arousal.");
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
        monster.lustVuln += 0.50;
    }

    public function RandomTeaseKitsune():void {
        outputText("With a mischievous grin you coat your hands and tail tips with foxfire, running the tingling flames deliciously along the length of [monster a] [monster name] body");
        if (monster.hasBreasts()) outputText(", your tails tracing [monster his] " + monster.breastDescript(0) + "");
        outputText(". You finish [monster him] up by focusing your flames on [monster his] crotch bathing [monster his]");
        if (monster.hasVagina()) outputText(" pussy");
        if (monster.hasCock() && monster.hasVagina()) outputText(" and");
        if (monster.hasCock()) outputText(" " + monster.cockDescriptShort() + "");
        outputText(" with fiery lust. Your opponent eventually shakes off your magic, striking you and breaking your concentration, but they clearly enjoyed the experience. Nothing's preventing you from doing it again, after all");
        StraddleDamage *= 1+((scalingBonusWisdom() + scalingBonusIntelligence())/100);
        StraddleDamage = Math.round(StraddleDamage);
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
    }

    public function RandomTeaseAlraune():void {
        outputText("Now that [monster a] [monster name] is nicely tied up you giggle and you pull [monster him] into a kiss, " +
                "feeding [monster him] your aphrodisiac nectar as your hand sweetly traces [monster his] cheek, one of your stamen going straight for");
        if (monster.hasVagina()) outputText(" the waiting love canal up front as another takes aim and plunge into ");
        outputText("his/her waiting backdoor hole stretching the passage up and going as deep as [monster his] bowels. ");
        if (monster.hasCock()) outputText("Not one to waste any potential seed you sit [monster him] deeper in the bath and wrap yourself tightly around [monster his]" +
                " waist impaling your pistil on [monster his] already drooling stamen so to pollinate yourself with [monster his] fertile seed. ");
        outputText("\n\nThe sex is mind melting but short lived as suddenly aware of what is going on [monster a] [monster name] " +
                "begins trashing about. You hold on, but they roar, forcing [monster him]self out of your grip. You shake your head, retreating back to your previous position, and [monster him] takes a few steps back. " +
                "You will mate eventually… it's just a matter of time now.");
        //(Add a toughness modifier and double lust damage)
        StraddleDamage *= 1+(scalingBonusToughness()*2/100);
        StraddleDamage *= 2;
        StraddleDamage = Math.round(StraddleDamage);
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
    }

    public function RandomTeaseLiliraune():void {
        outputText("With your lovely guest comfortably set in your pitcher its time for you to get to the fun part." +
                "\n\n\"Oh my! An early treat sister, look at how she/he is well tied up.\"" +
                "\n\n\"It sure gets my sap pumping.\"\n\n");
        outputText("Now that [monster a] [monster name] is nicely tied up you giggle and you pull [monster him] into a kiss, " +
                "feeding [monster him] your aphrodisiac nectar as your hand sweetly traces [monster his] cheek. One of your stamens plunges straight towards");
        if (monster.hasVagina()) outputText(" the waiting love canal up front as another takes aim and plunge into ");
        outputText("his/her waiting backdoor hole stretching the passage up and going as deep as [monster his] bowels. " +
                "Meanwhile, your sister going into position to take care of your guest other available areas, not leaving any inches of that body unstimulated.");
        if (monster.hasCock()) outputText("Not one to waste any potential seed she pulls [monster him] deeper in the bath and wraps herself around [monster his]" +
                " waist, impaling herself on [monster his] already drooling stamen so to pollinate the both of you with [monster his] fertile pollen. ");
        outputText("\n\nThe sex is mind melting but short lived as suddenly, you feel your prey jolt awake. Now aware of what is going on [monster a] [monster name] " +
                "begins thrashing about. You hold on, but your prey is desperate, forcing [monster him]self out of your grip with enough strength to throw the three of you back into the previous position. " +
                "\n\n\"You're just delaying the inevitable you know? You should just surrender and let us take good care of your pleasure.\"" +
                "\n\n\"We're going to give you the sweetest orgasm of your life. So sweet your eyes will probably cross thehehe...\"\n\n" +
                "You will mate eventually… it's just a matter of time now.");
        //(Add a toughness modifier and double lust damage)
        StraddleDamage *= 1+(scalingBonusToughness()*2/100);
        StraddleDamage *= 3;
        StraddleDamage = Math.round(StraddleDamage);
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
    }

    public function RandomTeaseLustStrike():void {
        outputText("You smile lewdly, almost moaning the syllables as you pose your hand on [monster a] [monster name] crotch " +
                "waving the demonic signs and delivering your unholy magic directly into your victim's endowment. [monster His] ");
        if (monster.hasCock() > 0) outputText("cock drools black precum, swelling in size");
        if (monster.hasCock() && monster.hasVagina()) outputText(" as [monster his] ");
        if (monster.hasVagina()) outputText("pussy starts gushing like a fountain, lips swelling with arousal. ");
        if (monster.hasCock() && monster.hasVagina()) outputText("They");
        else outputText("It");
        outputText(" pulse");
        if (monster.hasCock() && monster.hasVagina()) outputText("s");
        outputText(" with your demonic powers at the rhythm of [monster a] [monster name]'s heartbeat. " +
                "The unholy transformation, even if temporary, arouses [monster a] [monster name] to no end.");
        StraddleDamage *= 1+((scalingBonusIntelligence()*2)/100);
		//StraddleDamage *= 1+((player.intStat.core.max*2)/100);
        StraddleDamage = Math.round(StraddleDamage);
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
        monster.lustVuln += 0.50;
    }

    public function RandomTeaseAnemone():void {
        outputText("You take no time, plugging your venomous tentacled anemone cock into [monster a] [monster name]'s vulnerable pussy. " +
                "The effect is instantaneous as [monster he] is stung on the entire surface of [monster his] vaginal walls, " +
                "the lips puffing up and the hole gushing with a telltale spray of girlcum. You begin to piston inside, " +
                "insensate to [monster a] [monster name] crazed moans as you attempt to force in as much pleasure as you can. " +
                "In desperation [monster he] punches you, forcing you to pull your devilish cock out of its tormented cunt. " +
                "[monster he] breathes heavily, blushing as [monster he] fights to [monster his] feet. You can tell you've rattled [monster him]");
        StraddleDamage *= 2;
        StraddleDamage = Math.round(StraddleDamage);
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
    }

    public function RandomTeaseSlime():void {
        outputText("You take no time, violating [monster a] [monster name]'s vulnerable ");
        if (monster.hasVagina()) outputText("pussy");
        if (monster.hasVagina() && monster.hasCock()) outputText(" and ");
        if (monster.hasCock() > 0) outputText(" urethra");
        outputText("molding yourself into various sex toys to cause [monster him] a maximum amount of pleasure and maximise the fluid output.");
        if (monster.hasVagina() && monster.hasCock()) outputText("Meanwhile, deep");
        if (monster.hasVagina() && !monster.hasCock()) outputText("Once deep");
        if (monster.hasVagina()) outputText(" inside [monster his] vagina, you begin viciously bumping into as many of [monster his] sensitive spots as you can, coaxing numerous loud moans from your partner.");
        outputText("Eventually, [monster his] forceful contractions force you back out of your opponent. They manage to get back up, but they look like they enjoyed it." +
                "Thats nice because you intend to to do it again, the first chance you get.");
        StraddleDamage *= 1+(scalingBonusToughness()*2/100+scalingBonusLibido()*2/100);
        StraddleDamage = Math.round(StraddleDamage);
        monster.teased(StraddleDamage, false);
        if (Randomcrit) outputText(" <b>Critical!</b>");
    }

    public function RandomTeaseSlimeInsert():void {
        outputText("Hungry for fluids you forcefully inject yourself into your opponent body, using every available orifice as an entryway. ");
        if (monster.hasCock()) outputText("Within seconds you reach the fresh cum storage of your opponent feeding straight from the tap. Your forceful entry causes [monster him] no short amount of pleasure as you mess [monster him] up inside. ");
        if (monster.balls > 0) outputText("Your victims balls double in size the veins pulsing as your slushing presense causes them to easily triple in volume. You get a firm grip on your victim's gonads, ready to milk them for what the are worth. ");
        if (monster.hasVagina() && monster.hasCock()) outputText("Unsatisfied with your victim's cock alone, you go for the herm's other treasure, invading your victim deep");
        if (monster.hasVagina() && !monster.hasCock()) outputText("Once deep");
        if (monster.hasVagina()) outputText(" inside [monster his] vagina, flooding your gelatinous body all the way past the cervix, into the womb.");
        outputText("Whatever is left of you you pour straight into your victim's ass, fully flooding [monster his] innards all the way to the stomach, causing your body to bloat your opponents belly. <b>Its snacking time!</b>");
        var DurationLeft:int = player.statusEffectv1(StatusEffects.StraddleRoundLeft);
        monster.createStatusEffect(StatusEffects.SlimeInsert, 2 + rand(3), DurationLeft, 0, 0);
        player.removeStatusEffect(StatusEffects.StraddleRoundLeft);
        monster.removeStatusEffect(StatusEffects.Straddle);
    }

    public function StraddleLeggoMyEggo():void {
        clearOutput();
        outputText("You let [monster a] [monster name] go, prefering to continue the fight normally.");
        monster.removeStatusEffect(StatusEffects.Straddle);
        player.removeStatusEffect(StatusEffects.StraddleRoundLeft);
        outputText("[monster He] catches [monster his] breath before [monster he] stands back up, apparently prepared to fight some more. ");
        outputText("\n\n");
        enemyAI();
    }

    public function DigOut():void {
        clearOutput();
        outputText("You dig back up to the surface, gasping for air.\n\n");
        monster.removeStatusEffect(StatusEffects.Dig);
        enemyAI();
    }

    public function Guillotine():void {
        clearOutput();
        if (monster.plural) {
            if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
                outputText("You are too tired to crush [monster a] [monster name].");
                addButton(0, "Next", combatMenu, false);
                return;
            }
        } else {
            if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
                outputText("You are too tired to crush [monster a] [monster name].");
                addButton(0, "Next", combatMenu, false);
                return;
            }
        }
        fatigue(20, USEFATG_PHYSICAL);
        var damage:int = (monster.maxHP() * (.10 + rand(15) / 100) * 1.5) + unarmedAttack();
        damage *= scalingBonusStrength()*0.4;
        damage *= scalingBonusToughness()*0.2;
        if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
        if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
        if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
        if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
        if (player.hasPerk(PerkLib.KrakenBlackDress)) damage *= 2;
        //Squeeze -
        outputText("You begin to crush your foe with your pincer, aiming to squeeze it to death in your mighty grip. You can feel it in your claw as [monster his] struggles intensify, smacking your armored pincher as hard as they can. \n\n[Themonster] takes ");
        doPhysicalDamage(damage, true, true);
        outputText(" damage.");
        //Enemy faints -
        if (monster.HP <= monster.minHP()) {
            outputText("\n\nYou can feel [monster a] [monster name]'s life signs beginning to fade, and before you crush all the life from [monster him], you let go, dropping [monster him] to the floor, unconscious but alive.  In no time, [monster his]'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.\n\n");
            doNext(endHpVictory);
            return;
        }
        outputText("\n\n");
        enemyAI();
    }

    public function ScyllaSqueeze():void {
        clearOutput();
        if (monster.plural) {
            if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
                outputText("You are too tired to squeeze [monster a] [monster name].");
                addButton(0, "Next", combatMenu, false);
                return;
            }
        } else {
            if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
                outputText("You are too tired to squeeze [monster a] [monster name].");
                addButton(0, "Next", combatMenu, false);
                return;
            }
        }
        if (monster.plural) {
            fatigue(50, USEFATG_PHYSICAL);
        } else fatigue(20, USEFATG_PHYSICAL);
        var damage:int = monster.maxHP() * (.10 + rand(15) / 100) * 1.5;
        if (player.isKraken()) {
            damage *= player.tallness / 25;
            damage += player.str;
        }
        if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
        if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
        if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
        if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
        if (monster.plural) damage *= 5;
        if (player.hasPerk(PerkLib.KrakenBlackDress)) damage *= 2;
		if (player.hasPerk(PerkLib.UnbreakableBind)) damage *= 2;
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
            outputText("\n\nYou can feel [monster a] [monster name]'s life signs beginning to fade, and before you crush all the life from [monster him], you let go, dropping [monster him] to the floor, unconscious but alive.  In no time, [monster his]'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
            if (monster.short == "demons")
                outputText("The others quickly back off, terrified at the idea of what you might do to them.");
            outputText("\n\n");
            doNext(endHpVictory);
            return;
        }
        outputText("\n\n");
        enemyAI();
    }

    public function ScyllaTease():void {
        clearOutput();
        //(if poisoned)
        if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
            outputText("You casually caress your opponent with a free hand as you use one of your tentacles to expertly molest its bottom half.\n\n");
        } else if (monster.gender == 0) {
            outputText("You look over [monster a] [monster name], but can't figure out how to tease such an unusual foe.\n\n");
        }
        if (monster.lustVuln == 0) {
            outputText("You casually caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
            enemyAI();
            return;
        }
        //(Otherwise)
        else {
            wrathregeneration1();
            fatigueRecovery1();
            manaregeneration1();
            soulforceregeneration1();
			venomCombatRecharge1();
            var damage:Number;
            var chance:Number;
            var bimbo:Boolean = false;
            var bro:Boolean = false;
            var futa:Boolean = false;
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
            if (player.hasPerk(PerkLib.SluttySeduction) || player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) chance += 10;
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
            damage = 6 + rand(3);
            if (player.hasPerk(PerkLib.SensualLover)) {
                damage += 2;
            }
            if (player.hasPerk(PerkLib.Seduction)) damage += 5;
            //+ slutty armor bonus
            if (player.hasPerk(PerkLib.SluttySeduction)) damage += player.perkv1(PerkLib.SluttySeduction);
            if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
            //10% for bimbo shits
            if (bimbo || bro || futa) {
                damage += 5;
            }
            if (player.hasPerk(PerkLib.FlawlessBody)) damage += 10;
            damage += scalingBonusLibido() * 0.1;
            damage += player.teaseLevel;
            damage += rand(7);
            //partial skins bonuses
            switch (player.coatType()) {
                case Skin.FUR:
                    damage += (1 + player.newGamePlusMod());
                    break;
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
            chance += 2;
            //Specific cases for slimes and demons, as the normal ones would make no sense
            if (monster.short == "demons") {
                outputText("As you stimulate one of their brethren, the other demons can't help but to feel more aroused by this sight, all wishing to touch and feel the contact of your smooth, scaly body.");
            } else if (monster.short == "slime") {
                outputText("You attempt to stimulate the slime despite its lack of any sex organs. Somehow, it works!");
            }
            //Normal cases for other monsters
            else {
                if (monster.gender == 1) {
                    outputText("Your nimble tentacle begins to gently stroke his " + monster.cockDescriptShort(0) + ", and you can see it on his face as he tries to hold back the fact that it feels good.");
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
                if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) damagemultiplier += historyWhoreBonus();
                if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 10) damagemultiplier += 0.2;
                if (player.hasPerk(PerkLib.SuperSensual) && chance > 100) damagemultiplier += (0.01 * (chance - 100));
                if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
                if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
				if (player.hasPerk(PerkLib.UnbreakableBind)) damagemultiplier += 1;
				if (player.hasStatusEffect(StatusEffects.ControlFreak)) damagemultiplier += (2 - player.statusEffectv1(StatusEffects.ControlFreak));
				if (player.hasPerk(PerkLib.Sadomasochism)) damage *= player.sadomasochismBoost();
                damage *= damagemultiplier;
                //Determine if critical tease!
                var crit:Boolean = false;
                var critChance:int = 5;
                if (player.hasPerk(PerkLib.CriticalPerformance)) {
                    if (player.lib <= 100) critChance += player.lib / 5;
                    if (player.lib > 100) critChance += 20;
                }
                if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
                if (rand(100) < critChance) {
                    crit = true;
                    damage *= 1.75;
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
            if (monster.lust >= monster.maxLust()) {
                doNext(endLustVictory);
                return;
            }
        }
        enemyAI();
    }

    public function ScyllaLeggoMyEggo():void {
        clearOutput();
        outputText("You release [monster a] [monster name] from [monster his] bonds, and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
        outputText("\n\n");
        monster.removeStatusEffect(StatusEffects.ConstrictedScylla);
        enemyAI();
    }

    public function WhipStrangulate():void {
		clearOutput();
		if (player.fatigue + combat.physicalCost(20) > player.maxFatigue()) {
			outputText("You are too tired to strangulate " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", SceneLib.combat.combatMenu, false);
			return;
		}
		fatigue(20, USEFATG_PHYSICAL);
		//Squeeze -
		outputText("You tighten the noose around your opponent's necks, your whip leaving red marks into the flesh. ");
		var damage:int = monster.maxHP() * (.10 + rand(15) / 100);
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
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
		enemyAI();
    }

    public function WhipLeggoMyEggo():void {
        clearOutput();
        outputText("You release [monster a] [monster name] from your "+player.weaponName+", and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
        outputText("\n\n");
        monster.removeStatusEffect(StatusEffects.ConstrictedWhip);
        enemyAI();
    }

    public function CrabLeggoMyEggo():void {
        clearOutput();
        outputText("You release [monster a] [monster name] from your grip, and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
        outputText("\n\n");
        monster.removeStatusEffect(StatusEffects.CancerGrab);
        enemyAI();
    }


    public function WebTease():void {
        clearOutput();
        //(if poisoned)
        if (monster.gender == 0) {
            outputText("You look over [monster a] [monster name], but can't figure out how to tease such an unusual foe.\n\n");
        }
        if (monster.lustVuln == 0) {
            outputText("You giggle and run your hands against your victim's flesh, naughty bits purposely left exposed for you to grope and tease, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
            enemyAI();
            return;
        }
        //(Otherwise)
        else {
            wrathregeneration1();
            fatigueRecovery1();
            manaregeneration1();
            soulforceregeneration1();
			venomCombatRecharge1();
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
            if (player.hasPerk(PerkLib.SluttySeduction) || player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) chance += 10;
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
            damage = 6 + rand(3);
            if (player.hasPerk(PerkLib.SensualLover)) {
                damage += 2;
            }
            if (player.hasPerk(PerkLib.Seduction)) damage += 5;
            //+ slutty armor bonus
            if (player.hasPerk(PerkLib.SluttySeduction)) damage += player.perkv1(PerkLib.SluttySeduction);
            if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
            //10% for bimbo shits
            if (bimbo || bro || futa) {
                damage += 5;
            }
            if (player.hasPerk(PerkLib.FlawlessBody)) damage += 10;
            damage += scalingBonusLibido() * 0.1;
            damage += player.teaseLevel;
            damage += rand(7);
            //partial skins bonuses
            switch (player.coatType()) {
                case Skin.FUR:
                    damage += (1 + player.newGamePlusMod());
                    break;
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
            chance += 2;
            //Land the hit!
            if (rand(100) <= chance) {
                outputText("You giggle and run your hands against your helpless victim's flesh, their naughty bits purposely left exposed out of your web for you to groppe and play with.")
                //NERF TEASE DAMAGE
                damage += scalingBonusLibido();
                damage *= 0.25;
                damage = Math.round(damage);
                var damagemultiplier:Number = 1;
                if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) damagemultiplier += historyWhoreBonus();
                if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 10) damagemultiplier += 0.2;
                if (player.hasPerk(PerkLib.SuperSensual) && chance > 100) damagemultiplier += (0.01 * (chance - 100));
                if (player.hasPerk(PerkLib.RacialParagon)) damagemultiplier *= RacialParagonAbilityBoost();
                if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
				if (player.hasPerk(PerkLib.UnbreakableBind)) damagemultiplier += 1;
				if (player.hasStatusEffect(StatusEffects.ControlFreak)) damagemultiplier += (2 - player.statusEffectv1(StatusEffects.ControlFreak));
				if (player.hasPerk(PerkLib.Sadomasochism)) damage *= player.sadomasochismBoost();
                damage *= damagemultiplier;
                //Determine if critical tease!
                var crit:Boolean = false;
                var critChance:int = 5;
                if (player.hasPerk(PerkLib.CriticalPerformance)) {
                    if (player.lib <= 100) critChance += player.lib / 5;
                    if (player.lib > 100) critChance += 20;
                }
                if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
                if (rand(100) < critChance) {
                    crit = true;
                    damage *= 1.75;
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
            if (monster.lust >= monster.maxLust()) {
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
            outputText("You look over [monster a] [monster name], but can't figure out how to tease such an unusual foe.\n\n");
        }
        if (monster.lustVuln == 0) {
            outputText("You casually caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
            enemyAI();
            return;
        }
        //(Otherwise)
        else {
            wrathregeneration1();
            fatigueRecovery1();
            manaregeneration1();
            soulforceregeneration1();
			venomCombatRecharge1();
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
            if (player.hasPerk(PerkLib.SluttySeduction) || player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) chance += 10;
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
            damage = 6 + rand(3);
            if (player.hasPerk(PerkLib.SensualLover)) {
                damage += 2;
            }
            if (player.hasPerk(PerkLib.Seduction)) damage += 5;
            //+ slutty armor bonus
            if (player.hasPerk(PerkLib.SluttySeduction)) damage += player.perkv1(PerkLib.SluttySeduction);
            if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
            //10% for bimbo shits
            if (bimbo || bro || futa) {
                damage += 5;
            }
            if (player.hasPerk(PerkLib.FlawlessBody)) damage += 10;
            damage += scalingBonusLibido() * 0.1;
            damage += player.teaseLevel;
            damage += rand(7);
            //partial skins bonuses
            switch (player.coatType()) {
                case Skin.FUR:
                    damage += (1 + player.newGamePlusMod());
                    break;
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
            chance += 2;
            //Land the hit!
            if (rand(100) <= chance) {
                outputText("You start to play with [monster a] [monster name]'s body ");
                if (monster.gender == 1) {
                    outputText("stroking his " + monster.cockDescriptShort(0) + " from inside of you to feast on his precum.");
                }
                if (monster.gender == 2) {
                    outputText("forcefully filling her pussy and ass with your fluid form as you molest her breasts.");
                }
                if (monster.gender == 3) {
                    outputText("forcefully filling her pussy and ass with your fluid form as you molest her breast. Unsatisfied with her female parts you also stroke her cock to feast on her precum.");
                }
                outputText(" This feels very pleasurable to you but not as much as to your opponent who starts to drool, shuddering at your ministration.");
                //NERF TEASE DAMAGE
                damage += scalingBonusLibido();
                damage *= 0.25;
                damage = Math.round(damage);
                var damagemultiplier:Number = 1;
                if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) damagemultiplier += historyWhoreBonus();
                if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 10) damagemultiplier += 0.2;
                if (player.hasPerk(PerkLib.SuperSensual) && chance > 100) damagemultiplier += (0.01 * (chance - 100));
                if (player.hasPerk(PerkLib.RacialParagon)) damagemultiplier *= RacialParagonAbilityBoost();
                if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
				if (player.hasPerk(PerkLib.UnbreakableBind)) damagemultiplier += 1;
				if (player.hasStatusEffect(StatusEffects.ControlFreak)) damagemultiplier += (2 - player.statusEffectv1(StatusEffects.ControlFreak));
				if (player.hasPerk(PerkLib.Sadomasochism)) damage *= player.sadomasochismBoost();
                damage *= damagemultiplier;
                //Determine if critical tease!
                var crit:Boolean = false;
                var critChance:int = 5;
                if (player.hasPerk(PerkLib.CriticalPerformance)) {
                    if (player.lib <= 100) critChance += player.lib / 5;
                    if (player.lib > 100) critChance += 20;
                }
                if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
                if (rand(100) < critChance) {
                    crit = true;
                    damage *= 1.75;
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
            if (monster.lust >= monster.maxLust()) {
                doNext(endLustVictory);
                return;
            }
        }
        enemyAI();
    }

    public function GooLeggoMyEggo():void {
        clearOutput();
        outputText("You release [monster a] [monster name] from your body and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.\n\n");
        monster.removeStatusEffect(StatusEffects.GooEngulf);
        enemyAI();
    }

    public function spiderBiteAttack():void {
        flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
        clearOutput();
        if (monster is LivingStatue)
        {
            outputText("Your fangs can't even penetrate the giant's flesh.");
            enemyAI();
            return;
        }
        if(monster.lustVuln == 0) outputText("  Your aphrodisiac toxin has no effect!");
        else {
                outputText("You pull [monster a] [monster name] in  wriggling close and sink in your fangs, injecting your venom right into [monster his] bloodstream!");
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
                monster.teased(Math.round(monster.lustVuln * lustDmg), true);
                monster.statStore.addBuffObject({tou:-poisonScaling}, "Poison",{text:"Poison"});
                if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
                monster.addStatusValue(StatusEffects.NagaVenom, 3, 1);
                } else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
        }
        outputText("\n\n");
        combat.WrathGenerationPerHit2(5);
        player.tailVenom -= player.VenomWebCost() * 5;
        flags[kFLAGS.VENOM_TIMES_USED] += 1;
        if (!combatIsOver()) enemyAI();
    }

    public function ManticoreFeed():void {
        clearOutput();
        if (monster.lustVuln == 0) {
            outputText("You attempt to suck out the cum from your victim's penis, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
            enemyAI();
            return;
        }
        //(Otherwise)
        else {
            wrathregeneration1();
            fatigueRecovery1();
            manaregeneration1();
            soulforceregeneration1();
			venomCombatRecharge1();
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
            damage = 6 + rand(3);
            if (player.hasPerk(PerkLib.SensualLover)) {
                damage += 2;
            }
            if (player.hasPerk(PerkLib.Seduction)) damage += 5;
            //+ slutty armor bonus
            if (player.hasPerk(PerkLib.SluttySeduction)) damage += player.perkv1(PerkLib.SluttySeduction);
            if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
            //10% for bimbo shits
            if (bimbo || bro || futa) {
                damage += 5;
            }
            if (player.hasPerk(PerkLib.FlawlessBody)) damage += 10;
            damage += scalingBonusLibido() * 0.1;
            damage += player.teaseLevel;
            damage += rand(7);
            //partial skins bonuses
            switch (player.coatType()) {
                case Skin.FUR:
                    damage += (1 + player.newGamePlusMod());
                    break;
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
            outputText("You use your tail-cunt vaginal walls to forcefully milk your victim for his delicious cum, biting your own lips at the pleasure of [monster his] twitching member in your tail.");
            //NERF TEASE DAMAGE
            damage += scalingBonusLibido();
            damage *= 0.25;
            damage = Math.round(damage);
            var damagemultiplier:Number = 1;
            if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) damagemultiplier += historyWhoreBonus();
            if (player.hasPerk(PerkLib.DazzlingDisplay)) damagemultiplier += 0.2;
            if (player.hasPerk(PerkLib.SuperSensual)) damagemultiplier += 0.5;
            if (player.hasPerk(PerkLib.RacialParagon)) damagemultiplier *= RacialParagonAbilityBoost();
            if (player.hasPerk(MutationsLib.ManticoreMetabolismEvolved)) damagemultiplier *= 2;
            if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
            damage *= damagemultiplier;
            //Determine if critical tease!
            var crit:Boolean = false;
            var critChance:int = 5;
            if (player.hasPerk(PerkLib.CriticalPerformance)) {
                if (player.lib <= 100) critChance += player.lib / 5;
                if (player.lib > 100) critChance += 20;
            }
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
            if (rand(100) < critChance) {
                crit = true;
                damage *= 1.75;
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
                if (player.HP < player.maxHP()) {
                    EngineCore.HPChange(100 + (player.tou*2), true);
                }
                EngineCore.changeFatigue(-(100 + (player.spe*2)));
                player.manticoreFeed();
                player.addStatusValue(StatusEffects.ManticorePlug,3,+1);
            }
        }
        //Nuttin honey
        outputText("\n\n");
        if (monster.lust >= monster.maxLust()) {
            doNext(endLustVictory);
            return;
        }
        enemyAI();
    }

    public function displacerFeedContinue():void {
        clearOutput();
        if (monster.lustVuln == 0) {
            outputText("You attempt to suck out the milk from your victim's breast, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
            enemyAI();
            return;
        }
        //(Otherwise)
        else {
            wrathregeneration1();
            fatigueRecovery1();
            manaregeneration1();
            soulforceregeneration1();
			venomCombatRecharge1();
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
            damage = 6 + rand(3);
            if (player.hasPerk(PerkLib.SensualLover)) {
                damage += 2;
            }
            if (player.hasPerk(PerkLib.Seduction)) damage += 5;
            //+ slutty armor bonus
            if (player.hasPerk(PerkLib.SluttySeduction)) damage += player.perkv1(PerkLib.SluttySeduction);
            if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
            //10% for bimbo shits
            if (bimbo || bro || futa) {
                damage += 5;
            }
            if (player.hasPerk(PerkLib.FlawlessBody)) damage += 10;
            damage += scalingBonusLibido() * 0.1;
            damage += player.teaseLevel;
            damage += rand(7);
            //partial skins bonuses
            switch (player.coatType()) {
                case Skin.FUR:
                    damage += (1 + player.newGamePlusMod());
                    break;
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
            outputText("You mewl in primal ecstasy at the passage of milks through your appendages, filling yourself with white vitality. Mmmmm delicious. Your opponent on the other end is getting increasingly flushed from the treatment.");
            //NERF TEASE DAMAGE
            damage += scalingBonusLibido();
            damage *= 0.25;
            damage = Math.round(damage);
            var damagemultiplier:Number = 1;
            if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) damagemultiplier += historyWhoreBonus();
            if (player.hasPerk(PerkLib.DazzlingDisplay)) damagemultiplier += 0.2;
            if (player.hasPerk(PerkLib.SuperSensual)) damagemultiplier += 0.5;
            if (player.hasPerk(PerkLib.RacialParagon)) damagemultiplier *= RacialParagonAbilityBoost();
            if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
            damage *= damagemultiplier;
            //Determine if critical tease!
            var crit:Boolean = false;
            var critChance:int = 5;
            if (player.hasPerk(PerkLib.CriticalPerformance)) {
                if (player.lib <= 100) critChance += player.lib / 5;
                if (player.lib > 100) critChance += 20;
            }
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
            if (rand(100) < critChance) {
                crit = true;
                damage *= 1.75;
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
                if (player.HP < player.maxHP()) {
                    EngineCore.HPChange(100 + (player.tou*2), true);
                }
                EngineCore.changeFatigue(-(100 + (player.spe*2)));
                player.displacerFeed();
                player.addStatusValue(StatusEffects.DisplacerPlug,3,+1);
            }
        }
        //Nuttin honey
        outputText("\n\n");
        if (monster.lust >= monster.maxLust()) {
            doNext(endLustVictory);
            return;
        }
        enemyAI();
    }

    public function SlimeRapeFeed():void {
        clearOutput();
        if (monster.lustVuln == 0) {
            outputText("Despite your best effort you can't seem to stimulate your opponent using your fluidic body. Your foe clearly does not experience lust in the same way as you.\n\n");
            enemyAI();
            return;
        }
        //(Otherwise)
        else {
            wrathregeneration1();
            fatigueRecovery1();
            manaregeneration1();
            soulforceregeneration1();
			venomCombatRecharge1();
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
            damage = 6 + rand(3);
            if (player.hasPerk(PerkLib.SensualLover)) {
                damage += 2;
            }
            if (player.hasPerk(PerkLib.Seduction)) damage += 5;
            //+ slutty armor bonus
            if (player.hasPerk(PerkLib.SluttySeduction)) damage += player.perkv1(PerkLib.SluttySeduction);
            if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
            //10% for bimbo shits
            if (bimbo || bro || futa) {
                damage += 5;
            }
            if (player.hasPerk(PerkLib.FlawlessBody)) damage += 10;
            damage += scalingBonusLibido() * 0.1;
            damage += player.teaseLevel;
            damage += rand(7);
            //partial skins bonuses
            switch (player.coatType()) {
                case Skin.FUR:
                    damage += (1 + player.newGamePlusMod());
                    break;
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
            outputText("You begin to forcefully rape [Themonster] from the inside, wrecking [monster his] body as you attempt to extract fluids from [monster his] abused genitals.");
            //NERF TEASE DAMAGE
            damage += scalingBonusLibido();
            damage *= 0.25;
            damage = Math.round(damage);
            var damagemultiplier:Number = 1;
            if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) damagemultiplier += historyWhoreBonus();
            if (player.hasPerk(PerkLib.DazzlingDisplay)) damagemultiplier += 0.2;
            if (player.hasPerk(PerkLib.SuperSensual)) damagemultiplier += 0.5;
            if (player.hasPerk(PerkLib.RacialParagon)) damagemultiplier *= RacialParagonAbilityBoost();
            if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
            damage *= damagemultiplier;
            //Determine if critical tease!
            var crit:Boolean = false;
            var critChance:int = 5;
            if (player.hasPerk(PerkLib.CriticalPerformance)) {
                if (player.lib <= 100) critChance += player.lib / 5;
                if (player.lib > 100) critChance += 20;
            }
            if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
            if (rand(100) < critChance) {
                crit = true;
                damage *= 1.75;
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
                if (player.HP < player.maxHP()) {
                    EngineCore.HPChange(100 + (player.tou*2), true);
                }
                EngineCore.changeFatigue(-(100 + (player.spe*2)));
                player.slimeFeed();
                player.addStatusValue(StatusEffects.SlimeInsert,3,+1);
            }
        }
        //Nuttin honey
        outputText("\n\n");
        if (monster.lust >= monster.maxLust()) {
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
            enemyAI();
            return;
        }
        outputText("You bite [monster a] [monster name] drinking deep of [monster his] blood ");
        var damage:int = player.maxHP() * 0.05;
        if (player.hasPerk(MutationsLib.HollowFangsPrimitive)) damage += player.maxHP() * 0.02;
        if (player.hasPerk(MutationsLib.HollowFangsEvolved)) damage += player.maxHP() * 0.08;
        if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
        if (player.hasPerk(PerkLib.RacialParagon)) damage *= RacialParagonAbilityBoost();
        damage = Math.round(damage);
        doPhysicalDamage(damage, true, true);
        player.HP += damage;
        if (player.HP > player.maxHP()) player.HP = player.maxHP();
        outputText(" damage. You feel yourself grow stronger with each drop. ");
        var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
        if (player.hasPerk(MutationsLib.HollowFangsEvolved)) thirst.drink(2);
        else thirst.drink(1);
        if (monster.gender != 0 && monster.lustVuln != 0) {
            var lustDmg:int = (10 + (player.lib * 0.1)) * monster.lustVuln;
            if (player.hasPerk(MutationsLib.HollowFangsEvolved)) lustDmg *= 1.5;
            if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= RacialParagonAbilityBoost();
            lustDmg = Math.round(monster.lustVuln * lustDmg);
            outputText(" [monster he] can’t help but moan, aroused from the aphrodisiac in your saliva for ");
            monster.teased(lustDmg);
            outputText(".");
        }
        //Enemy faints -
        if (monster.HP <= monster.minHP()) {
            outputText("You can feel [monster a] [monster name]'s life signs beginning to fade, and before you crush all the life from [monster him], you let go, dropping [monster him] to the floor, unconscious but alive.  In no time, [monster his] eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
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
        enemyAI();
    }

    public function VampireLeggoMyEggo():void {
        clearOutput();
        outputText("You let your opponent free, ending your embrace.");
        outputText("\n\n");
        monster.removeStatusEffect(StatusEffects.EmbraceVampire);
        enemyAI();
    }

    //Claws Rend
    public function clawsRendDamage():void {
        var damage:int;
        damage = unarmedAttack();
        damage += scalingBonusStrength() * 0.5;
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
        doPhysicalDamage(damage);
        outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
        if (crit) outputText(" <b>Critical!</b>");
        if (player.hasPerk(PerkLib.PhantomStrike)) doPhysicalDamage(damage, true, true);
    }

    public function clawsRend():void {
        clearOutput();
        if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(40, USEFATG_PHYSICAL);
        else fatigue(20, USEFATG_PHYSICAL);
        outputText("You begin to rend [monster a] [monster name] with your claws. ");
        clawsRendDamage();
        if (player.hasPerk(PerkLib.ClawTraining)) {
            clawsRendDamage();
        }
        if (player.hasPerk(PerkLib.ExtraClawAttack)) {
            clawsRendDamage();
        }
        if (player.hasPerk(PerkLib.MultiClawAttack)) {
            clawsRendDamage();
        }
        if (player.hasPerk(PerkLib.ClawingFlurry)) {
            clawsRendDamage();
        }
        if (monster.HP <= monster.minHP()) {
            doNext(combat.endHpVictory);
            return;
        }
        outputText("\n\n");
        enemyAI();
    }

    public function displacerCombatFeed():void {
        clearOutput();
        fatigue(50, USEFATG_PHYSICAL);
        outputText("You lick your lips in anticipation as you hold your victim's arms to the ground and plug your two tentacle suckers to [the monster]'s breasts. She struggles, flushing red as you flood her nipples with your lactation inducing venom and begin to force the delicious milk out of her tits.\n\n");
        monster.createStatusEffect(StatusEffects.DisplacerPlug, 1 + rand(3), 0, 0, 0);
        addButton(0, "Next", SceneLib.combat.combatMenu, false);
    }

    public function PussyLeggoMyEggo():void {
        clearOutput();
        outputText("You let your opponent free ending your grapple.\n\n");
		if (monster.hasStatusEffect(StatusEffects.DisplacerPlug)) monster.removeStatusEffect(StatusEffects.DisplacerPlug);
        monster.removeStatusEffect(StatusEffects.Pounce);
        enemyAI();
    }

    public function BreakOutWeb():void {
        clearOutput();
        outputText("You let your opponent free from your web.\n\n");
        monster.removeStatusEffect(StatusEffects.MysticWeb);
        enemyAI();
    }

	//Naga Hypnosis
    public function HypnosisHeal():void {
        clearOutput();
        useMana(30, USEMANA_WHITE_HEAL);
        outputText("You initiate a healing spell. ");
        CombatAbilities.Heal.doEffect(false);
        outputText("\n\nIt's only when you finish your casting that [themonster] snaps out of the hypnosis...But it's too late. ");
        if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
        statScreenRefresh();
        flags[kFLAGS.SPELLS_CAST]++;
        if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
        monster.removeStatusEffect(StatusEffects.HypnosisNaga);
        spellPerkUnlock();
        enemyAI();
    }

    public function HypnosisDarknessShard():void {
        clearOutput();
        useMana(30, USEMANA_BLACK);
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
        enemyAI();
    }

    public function HypnosisDuskWave():void {
        clearOutput();
        useMana(30, USEMANA_BLACK);
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
        enemyAI();
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
        enemyAI();
    }

    public function HypnosisMaintain():void {
        clearOutput();
        var damagemultiplier:Number = 1;
        if (player.armorName == "desert naga pink and black silk dress") damagemultiplier += 0.1;
        if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
        var lustDmg:int = (10 + (player.lib * 0.1)) * monster.lustVuln;
        lustDmg *= damagemultiplier;
        lustDmg = Math.round(lustDmg);
        outputText("You maintain the trance, smiling as you prolong the mesmerising dance, moving your hips from side to side and displaying your assets. [Themonster] is lost in your gaze, and unable to act. ");
        monster.teased(lustDmg);
        outputText("\n\n");
        enemyAI();
    }

	//Bear hug
    public function bearHug():void {
        fatigue(30, USEFATG_PHYSICAL);
        outputText("You squeeze [monster a] [monster name] with a mighty hug, slowly crushing the life out of [monster him]. ");
        var damage:int = unarmedAttack();
        damage += player.str;
        damage += scalingBonusStrength() * 0.5;
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
        enemyAI();
    }

    public function BearLeggoMyEggo():void {
        clearOutput();
        outputText("You let your opponent free, ending your grab.\n\n");
        monster.removeStatusEffect(StatusEffects.GrabBear);
        enemyAI();
    }

    public function taintedMindAttackAttempt():void {
        clearOutput();
        outputText("You ready an attack, but find your hands groping your own body instead. Somehow the demon’s magic has made it impossible to strike at him, crossing wires that weren’t meant to be crossed. Frowning, you look down at your more aroused form, determined not to fall for this a second time.");
        player.dynStats("lus", 15);
        enemyAI();
    }

	//Heal Zenji
    public function HealZenji():void {
        outputText("Noticing the injuries Zenji has sustained in efforts to protect you, you channel some magic to heal him.\n\n");
		outputText("Zenji readies his spear, wedging himself between you and your opponent, \"<i>I am stronger! Thank you, [name]!</i>\"\n\n");
        var recharge:Number = player.statusEffectv3(StatusEffects.CombatFollowerZenji);
		player.addStatusValue(StatusEffects.CombatFollowerZenji, 3, -recharge);
        enemyAI();
    }

    public function runAway(callHook:Boolean = true):void {
        if (callHook && monster.onPcRunAttempt != null) {
            monster.onPcRunAttempt();
            return;
        }
        clearOutput();
        if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 4) {
            clearOutput();
            outputText("You try to run, but you just can't seem to escape.  <b>Your ability to run was sealed, and now you've wasted a chance to attack!</b>\n\n");
            enemyAI();
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
            doNext(camp.returnToCampUseOneHour);
            return;
        }
        if (monster.hasStatusEffect(StatusEffects.Dig)) {
            clearOutput();
            outputText("You tunnel away from your opponent, escaping the fight and fleeing back to camp.\n");
            inCombat = false;
            clearStatuses(false);
            doNext(camp.returnToCampUseOneHour);
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
                doNext(camp.returnToCampUseOneHour);
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
        if (player.jiangshiScore() > 19) {
            outputText("Your cadaverous rigidity prevents any form of escape in battle!");
            //Pass false to combatMenu instead:		menuLoc = 3;
            //		doNext(combatMenu);
            menu();
            addButton(0, "Next", combatMenu, false);
            return;
        }
        if (player.statStore.hasBuff("Supercharged")) {
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
            doNext(camp.returnToCampUseOneHour);
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
            if (monster.short == "Hellfire Snail") {
                outputText("You run as fast as you can, taking random corridors and running past the confused enemies all the way back to the labyrinth entrance. You lose the slug-woman quickly, however your flight attracts more attention, forcing you all the way back to the surface. \n\n");
                SceneLib.dungeons.ebonlabyrinth.room = 1;
                SceneLib.dungeons.ebonlabyrinth.depth = 0;
                doNext(playerMenu);
            } else {
                outputText("You're trapped in your foe's domain - there is nowhere to run!\n\n");
                enemyAI();
            }
            return;
        }
        if (prison.inPrison && !prison.prisonCanEscapeRun()) {
            addButton(0, "Next", combatMenu, false);
            return;
        }
        //Attempt texts!
        if (monster.short == "Marae") {
            outputText("Your boat is blocked by tentacles! ");
            if (!player.canFly()) outputText("You will not be able to swim fast enough. ");
            else outputText("You grit your teeth with effort as you try to fly away but the tentacles suddenly grab your [legs] and pull you down. ");
            outputText("It looks like you cannot escape. ");
            enemyAI();
            return;
        }
        if (monster.short == "Ember") {
            outputText("You take off");
            if (!player.canFly()) outputText(" running");
            else outputText(", flapping as hard as you can");
            outputText(", and Ember, caught up in the moment, gives chase.  ");
        }
        if (monster.short == "lizan rogue") {
            outputText("As you retreat the lizan doesn't even attempt to stop you. When you look back for him, you find nothing but the empty bog around you.");
            CoC.instance.inCombat = false;
            clearStatuses(false);
            doNext(camp.returnToCampUseOneHour);
            return;
        }
		if (monster.short == "training dummy") {
			outputText("As you retreat the training dummy just stands there. ");
		}
		else if (player.canFly()) {
            if(player.wings.type != Wings.ETHEREAL || player.wings.type != Wings.LEVITATION || player.wings.type != Wings.THUNDEROUS_AURA){
                outputText("Gritting your teeth with effort, you beat your wings quickly and lift off!  ");
            }
            else{
                outputText("You leap into the air, and hover in the sky!  ");
            }
        }

        //Nonflying PCs
        else {
            //In prison!
            if (prison.inPrison) {
                outputText("You make a quick dash for the door and attempt to escape! ");
            }
            //Stuck!
            else if (player.hasStatusEffect(StatusEffects.NoFlee)) {
                clearOutput();
                if (monster.short == "goblin") outputText("You try to flee, but get stuck in the sticky white goop surrounding you.\n\n");
                else outputText("You put all your skills at running to work, ducking and diving in an effort to escape, but are unable to get away!\n\n");
                enemyAI();
                return;
            }
            //Nonstuck!
            else outputText("You turn tail and attempt to flee!  ");
        }

        //Calculations
        var escapeMod:Number = 20 + monster.level * 3;
        if (debug) escapeMod -= 300;
        if (player.canFly()) escapeMod -= 20;
        if (player.tailType == Tail.RACCOON && player.ears.type == Ears.RACCOON && player.hasPerk(PerkLib.Runner)) escapeMod -= 25;
        if (monster.hasStatusEffect(StatusEffects.Stunned)) escapeMod -= 50;
		if (player.hasStatusEffect(StatusEffects.Snow) && player.tallness < 84) escapeMod += 200;
        if (player.hasKeyItem("Nitro Boots") >= 0 && player.tallness < 48 && player.isBiped()) escapeMod -= 20;
        if (player.hasKeyItem("Rocket Boots") >= 0 && player.tallness < 48 && player.isBiped()) escapeMod -= 40;
        if (player.hasKeyItem("Spring Boots") >= 0 && player.tallness < 48 && player.isBiped()) escapeMod -= 60;

        //Big tits doesn't matter as much if ya can fly!
        else {
            if (player.biggestTitSize() >= 35) escapeMod += 5;
            if (player.biggestTitSize() >= 66) escapeMod += 10;
            if (player.hips.type >= 20) escapeMod += 5;
            if (player.butt.type >= 20) escapeMod += 5;
            if (player.ballSize >= 24 && player.balls > 0) escapeMod += 5;
            if (player.ballSize >= 48 && player.balls > 0) escapeMod += 10;
            if (player.ballSize >= 120 && player.balls > 0) escapeMod += 10;
        }
        //ANEMONE OVERRULES NORMAL RUN
        if (monster.short == "anemone") {
            //Autosuccess - less than 60 lust
            if (player.lust < (player.maxLust() * 0.6)) {
                clearOutput();
                outputText("Marshalling your thoughts, you frown at the strange girl and turn to march up the beach.  After twenty paces inshore you turn back to look at her again.  The anemone is clearly crestfallen by your departure, pouting heavily as she sinks beneath the water's surface.");
                inCombat = false;
                clearStatuses(false);
                doNext(camp.returnToCampUseOneHour);
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
                    doNext(camp.returnToCampUseOneHour);
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
        if (monster.short == "sea anemone") {
            //Autosuccess - less than 60 lust
            if (player.lust < (player.maxLust() * 0.6)) {
                clearOutput();
                outputText("Marshalling your thoughts, you frown at the strange girl and turn to march up the beach.  After twenty paces inshore you turn back to look at her again.  The anemone is clearly crestfallen by your departure, pouting heavily as she sinks beneath the water's surface.");
                inCombat = false;
                clearStatuses(false);
                doNext(camp.returnToCampUseOneHour);
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
                    doNext(camp.returnToCampUseOneHour);
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
        if (monster.short == "Ember") {
            //GET AWAY
            if (player.spe > rand(monster.spe + escapeMod) || (player.hasPerk(PerkLib.Runner) && rand(100) < 50)) {
                if (player.hasPerk(PerkLib.Runner)) outputText("Using your skill at running, y");
                else outputText("Y");
                outputText("ou easily outpace the dragon, who begins hurling imprecations at you.  \"What the hell, [name], you weenie; are you so scared that you can't even stick out your punishment?\"");
                outputText("\n\nNot to be outdone, you call back, \"Sucks to be you!  If even the mighty Last Ember of Hope can't catch me, why do I need to train?  Later, little bird!\"");
                inCombat = false;
                clearStatuses(false);
                doNext(camp.returnToCampUseOneHour);
            }
            //Fail:
            else {
                outputText("Despite some impressive jinking, " + SceneLib.emberScene.emberMF("he", "she") + " catches you, tackling you to the ground.\n\n");
                enemyAI();
            }
            return;
        }
        //SUCCESSFUL FLEE
        if ((player.spe > rand(monster.spe + escapeMod)) || monster.hasPerk(PerkLib.AlwaysSuccesfullRunaway)) {
            //Escape prison
            if (prison.inPrison) {
                outputText("You quickly bolt out of the main entrance and after hiding for a good while, there's no sign of [monster a] [monster name]. You sneak back inside to retrieve whatever you had before you were captured. ");
                inCombat = false;
                clearStatuses(false);
                prison.prisonEscapeSuccessText();
                doNext(prison.prisonEscapeFinalePart1);
                return;
            }
            //Fliers flee!
            else if (player.canFly()) outputText(monster.capitalA + monster.short + " can't catch you.");
            //sekrit benefit: if you have coon ears, coon tail, and Runner perk, change normal Runner escape to flight-type escape
            else if (player.tailType == Tail.RACCOON && player.ears.type == Ears.RACCOON && player.hasPerk(PerkLib.Runner)) {
                outputText("Using your running skill, you build up a head of steam and jump, then spread your arms and flail your tail wildly; your opponent dogs you as best [monster he] can, but stops and stares dumbly as your spastic tail slowly propels you several meters into the air!  You leave [monster him] behind with your clumsy, jerky, short-range flight.");
            }
            //Non-fliers flee
            else {
				if (monster.short == "training dummy") outputText("When you look back you see it's still in the same spot seemly grinning at you.");
				else outputText(monster.capitalA + monster.short + " rapidly disappears into the shifting landscape behind you.");
			}
            if (monster.short == "Izma") {
                outputText("\n\nAs you leave the tigershark behind, her taunting voice rings out after you.  \"<i>Oooh, look at that fine backside!  Are you running or trying to entice me?  Haha, looks like we know who's the superior specimen now!  Remember: next time we meet, you owe me that ass!</i>\"  Your cheek tingles in shame at her catcalls.");
            }
            inCombat = false;
            clearStatuses(false);
            doNext(camp.returnToCampUseOneHour);
            return;
        }
        //Runner perk chance
        else if (player.hasPerk(PerkLib.Runner) && rand(100) < 50) {
            inCombat = false;
            outputText("Thanks to your talent for running, you manage to escape.");
            if (monster.short == "Izma") {
                outputText("\n\nAs you leave the tigershark behind, her taunting voice rings out after you.  \"<i>Oooh, look at that fine backside!  Are you running or trying to entice me?  Haha, looks like we know who's the superior specimen now!  Remember: next time we meet, you owe me that ass!</i>\"  Your cheek tingles in shame at her catcalls.");
            }
            clearStatuses(false);
            doNext(camp.returnToCampUseOneHour);
            return;
        }
		else if (onlyZenjiRunnawayTrain()) {
			outputText("You tell Zenji that you need to run, you can't handle these opponents.");
			outputText("\n\nZenji immediately hoists you on his shoulder and makes a break for it");
			if (rand(4) > 0) {
				outputText(", leaving your opponent in the dust.");
				inCombat = false;
				clearStatuses(false);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			else outputText(". Despite his best attempt, he is unable to drag the two of you to safety. He stumbles, barely managing to gently set you on the ground as you resume combat.");
		}
        //FAIL FLEE
        else {
            if (monster.short == "Holli") {
                (monster as Holli).escapeFailWithHolli();
                return;
            }
            //Flyers get special failure message.
            if (player.canFly()) {
                if (monster.plural) outputText(monster.capitalA + monster.short + " manage to grab your [legs] and drag you back to the ground before you can fly away!");
                else outputText(monster.capitalA + monster.short + " manages to grab your [legs] and drag you back to the ground before you can fly away!");
            }
            //fail
            else if (player.tailType == Tail.RACCOON && player.ears.type == Ears.RACCOON && player.hasPerk(PerkLib.Runner)) outputText("Using your running skill, you build up a head of steam and jump, but before you can clear the ground more than a foot, your opponent latches onto you and drags you back down with a thud!");
            //Nonflyer messages
            else {
                //Huge balls messages
                if (player.balls > 0 && player.ballSize >= 24) {
                    if (player.ballSize < 48) outputText("With your [balls] swinging ponderously beneath you, getting away is far harder than it should be.  ");
                    else outputText("With your [balls] dragging along the ground, getting away is far harder than it should be.  ");
                }
                //FATASS BODY MESSAGES
                if (player.biggestTitSize() >= 35 || player.butt.type >= 20 || player.hips.type >= 20) {
                    //FOR PLAYERS WITH GIANT BREASTS
                    if (player.biggestTitSize() >= 35 && player.biggestTitSize() < 66) {
                        if (player.hips.type >= 20) {
                            outputText("Your " + hipDescript() + " forces your gait to lurch slightly side to side, which causes the fat of your " + player.skinTone + " ");
                            if (player.butt.type >= 20) outputText(buttDescript() + " and ");
                            outputText(chestDesc() + " to wobble immensely, throwing you off balance and preventing you from moving quick enough to escape.");
                        } else if (player.butt.type >= 20) outputText("Your " + player.skinTone + buttDescript() + " and " + chestDesc() + " wobble and bounce heavily, throwing you off balance and preventing you from escaping.");
                        else outputText("Your " + chestDesc() + " jiggle and wobble side to side like the " + player.skinTone + " sacks of milky fat they are, with enough force to constantly throw you off balance, preventing you from escaping.");
                    }
                    //FOR PLAYERS WITH MASSIVE BREASTS
                    else if (player.biggestTitSize() >= 66) {
                        if (player.hips.type >= 20) {
                            outputText("Your " + chestDesc() + " nearly drag along the ground while your " + hipDescript() + " swing side to side ");
                            if (player.butt.type >= 20) outputText("causing the fat of your " + player.skinTone + buttDescript() + " to wobble, ");
                            outputText("forcing you off balance and preventing you from escaping.");
                        } else if (player.butt.type >= 20) outputText("Your " + chestDesc() + " nearly drag along the ground while the fat of your " + player.skinTone + buttDescript() + " wobbles heavily from side to side, forcing your body off balance and preventing you from moving quick enough to escape.");
                        else outputText("Your " + chestDesc() + " nearly drag along the ground, preventing you from moving quick enough to get escape.");
                    }
                    //FOR PLAYERS WITH EITHER GIANT HIPS OR BUTT BUT NOT THE BREASTS
                    else if (player.hips.type >= 20) {
                        outputText("Your " + hipDescript() + " swing heavily from side to side ");
                        if (player.butt.type >= 20) outputText("causing your " + player.skinTone + buttDescript() + " to wobble obscenely ");
                        outputText(", forcing your body into an awkward gait that prevents you from escaping.");
                    }
                    //JUST DA BOOTAH
                    else if (player.butt.type >= 20) outputText("Your " + player.skinTone + buttDescript() + " wobbles so heavily that you're unable to move quick enough to escape.");
                }
                //NORMAL RUN FAIL MESSAGES
                else if (monster.plural) outputText(monster.capitalA + monster.short + " stay hot on your heels, denying you a chance at escape!");
                else outputText(monster.capitalA + monster.short + " stays hot on your heels, denying you a chance at escape!");
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
		if (player.hasStatusEffect(StatusEffects.CombatFollowerZenji) && partySize == 2) return true;
		else return false;
	}

    public function struggleCreepingDoom():void {
        outputText("You shake away the pests in disgust, managing to get rid of them for a time.\n\n");
        monster.removeStatusEffect(StatusEffects.CreepingDoom);
        enemyAI();
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
        enemyAI();
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
		doNext(curry(combatMenu, false));
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
		doNext(curry(combatMenu, false));
	}

	public function attackFlyingSword():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
        clearOutput();
		player.soulforce -= flyingSwordAttackCost();
		var damage:Number = 0;
        damage += player.weaponFlyingSwordsAttack * 10;
		damage += scalingBonusWisdom() * 0.2;
		//Weapon addition!
        if (player.weaponFlyingSwordsAttack < 51) damage *= (1 + (player.weaponFlyingSwordsAttack * 0.03));
        else if (player.weaponFlyingSwordsAttack >= 51 && player.weaponFlyingSwordsAttack < 101) damage *= (2.5 + ((player.weaponFlyingSwordsAttack - 50) * 0.025));
        else if (player.weaponFlyingSwordsAttack >= 101 && player.weaponFlyingSwordsAttack < 151) damage *= (3.75 + ((player.weaponFlyingSwordsAttack - 100) * 0.02));
        else if (player.weaponFlyingSwordsAttack >= 151 && player.weaponFlyingSwordsAttack < 201) damage *= (4.75 + ((player.weaponFlyingSwordsAttack - 150) * 0.015));
        else damage *= (5.5 + ((player.weaponFlyingSwordsAttack - 200) * 0.01));
		if (player.weaponFlyingSwordsPerk == "Massive") damage *= 1.5;
		//if (player.hasPerk(PerkLib.SoaringBlades)) damage *= 1;
		//damage *= (1 + (0.01 * masteryArcheryLevel()));
        //Determine if critical hit!
        var crit:Boolean = false;
        var critChance:int = 25;
        critChance += combatPhysicalCritical();
		if (player.weaponFlyingSwords == weaponsflyingswords.ASAUCHI) critChance -= 15;
		if (rand(100) < critChance) {
            crit = true;
            damage *= 1.75;
        }
        damage = Math.round(damage);
		outputText("You send a bit of soulforce to " + player.weaponFlyingSwordsName+" and sends it towards [themonster]. "+(player.usingSingleFlyingSword()?"It":"They")+" slash target leaving minor wound"+(player.usingSingleFlyingSword()?"":"s")+". ");
		if (player.weaponFlyingSwords == weaponsflyingswords.W_HALFM) doFireDamage(damage, true, true);
		else if (player.weaponFlyingSwords == weaponsflyingswords.B_HALFM) doIceDamage(damage, true, true);
		else if (player.weaponFlyingSwords == weaponsflyingswords.S_HALFM) doLightingDamage(damage, true, true);
		else if (player.weaponFlyingSwords == weaponsflyingswords.E_HALFM) doDarknessDamage(damage, true, true);
		else doPhysicalDamage(damage, true, true);
		if (player.weaponFlyingSwordsPerk == "Large Two") doPhysicalDamage(damage, true, true);
        if (crit) outputText(" <b>*Critical Hit!*</b>");
		WeaponFlyingSwordsStatusProcs();
		outputText("\n\n");
		enemyAI();
	}

    public function greatDive():void {
        flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
        clearOutput();
        if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
            clearOutput();
            outputText("You are too tired to perform a great dive.");
            doNext(combatMenu);
            return;
        }
        doNext(combatMenu);
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
        fatigue(50, USEFATG_PHYSICAL);
        var damage:Number = unarmedAttack();
        damage += player.str;
        damage += player.spe * 2;
        if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) {
            damage += player.str;
            damage += player.spe * 2;
        }
        if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= oniRampagePowerMulti();
        if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
        if (player.hasPerk(MutationsLib.HarpyHollowBones)) damage *= 1.2;
        if (player.hasPerk(MutationsLib.HarpyHollowBonesPrimitive)) damage *= 1.5;
        if (player.hasPerk(MutationsLib.HarpyHollowBonesEvolved)) damage *= 2;
		if (Forgefather.channelInlay == "emerald" && Forgefather.refinement == 4) damage *= 1.25;
		if (Forgefather.channelInlay == "emerald" && Forgefather.refinement == 5) damage *= 1.5;
		if (Forgefather.gem == "emerald" && Forgefather.refinement == 4) damage *= 1.12;
		if (Forgefather.gem == "emerald" && Forgefather.refinement == 5) damage *= 1.25;
        outputText("You focus on [Themonster], ");
		if (player.statusEffectv1(StatusEffects.Flying) == 0) outputText("fold your wings and dive");
		if (player.statusEffectv1(StatusEffects.Flying) == 1) outputText("direct your "+player.weaponFlyingSwordsName+" downward");
		if (player.statusEffectv1(StatusEffects.Flying) == 2) outputText("fold your arms and dive");
		outputText(", using gravity to increase the impact");
        if (player.hasPerk(PerkLib.DeathPlunge)) {
            if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.03));
            else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (2.5 + ((player.weaponAttack - 50) * 0.025));
            else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (3.75 + ((player.weaponAttack - 100) * 0.02));
            else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (4.75 + ((player.weaponAttack - 150) * 0.015));
            else damage *= (5.5 + ((player.weaponAttack - 200) * 0.01));
            outputText(" of your [weapon]. Your [weapon] strikes true, inflicting severe wounds as ");
            if (player.lowerBody == LowerBody.HARPY && player.statusEffectv1(StatusEffects.Flying) != 1) {
                outputText("your talons leave a bloody trail across your foe");
                damage *= 1.5;
            }
			else outputText("the rest of your body collides against your target" + (monster.plural?"s":"") + "");
            if (player.statusEffectv1(StatusEffects.Flying) > 0 && player.weaponFlyingSwordsName != "nothing") {
				outputText(". At the same time " + player.weaponFlyingSwordsName+" impales your target" + (monster.plural?"s":"") + "");
				if (player.weaponFlyingSwordsAttack < 51) damage *= (1 + (player.weaponFlyingSwordsAttack * 0.03));
				else if (player.weaponFlyingSwordsAttack >= 51 && player.weaponFlyingSwordsAttack < 101) damage *= (2.5 + ((player.weaponFlyingSwordsAttack - 50) * 0.025));
				else if (player.weaponFlyingSwordsAttack >= 101 && player.weaponFlyingSwordsAttack < 151) damage *= (3.75 + ((player.weaponFlyingSwordsAttack - 100) * 0.02));
				else if (player.weaponFlyingSwordsAttack >= 151 && player.weaponFlyingSwordsAttack < 201) damage *= (4.75 + ((player.weaponFlyingSwordsAttack - 150) * 0.015));
				else damage *= (5.5 + ((player.weaponFlyingSwordsAttack - 200) * 0.01));
			}
            if (player.haveWeaponForJouster()) {
                var JousterDamageMod:Number = 1;
                //if (player.isPolearmTypeWeapon()) JousterDamageMod = 0.75;
                if ((((player.isTaur() || player.isDrider() || player.canFly()) && player.spe >= 60) && player.hasPerk(PerkLib.Naturaljouster)) || (player.spe >= 150 && player.hasPerk(PerkLib.Naturaljouster))) damage *= 3*JousterDamageMod;
                if ((((player.isTaur() || player.isDrider() || player.canFly()) && player.spe >= 180) && player.hasPerk(PerkLib.NaturaljousterMastergrade)) || (player.spe >= 450 && player.hasPerk(PerkLib.NaturaljousterMastergrade))) damage *= 5*JousterDamageMod;

            }
			damage *= (1 + PASPAS());
        } else {
            if (player.lowerBody == LowerBody.HARPY && player.statusEffectv1(StatusEffects.Flying) != 1) {
                outputText(" making a bloody trail with your talons");
                damage *= 1.5;
            }
			else outputText(" hitting your target with violence");
			if (player.statusEffectv1(StatusEffects.Flying) > 0 && player.weaponFlyingSwordsName != "nothing") {
				outputText(". At the same time " + player.weaponFlyingSwordsName+" impales your target" + (monster.plural?"s":"") + "");
				if (player.weaponFlyingSwordsAttack < 51) damage *= (1 + (player.weaponFlyingSwordsAttack * 0.03));
				else if (player.weaponFlyingSwordsAttack >= 51 && player.weaponFlyingSwordsAttack < 101) damage *= (2.5 + ((player.weaponFlyingSwordsAttack - 50) * 0.025));
				else if (player.weaponFlyingSwordsAttack >= 101 && player.weaponFlyingSwordsAttack < 151) damage *= (3.75 + ((player.weaponFlyingSwordsAttack - 100) * 0.02));
				else if (player.weaponFlyingSwordsAttack >= 151 && player.weaponFlyingSwordsAttack < 201) damage *= (4.75 + ((player.weaponFlyingSwordsAttack - 150) * 0.015));
				else damage *= (5.5 + ((player.weaponFlyingSwordsAttack - 200) * 0.01));
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
			if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponSpecials("Large") && player.str >= 100) critChance += 10;
			if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weaponSpecials("Dual Large") && player.str >= 140) critChance += 10;
			if (player.hasPerk(PerkLib.GigantGripEx) && player.weaponSpecials("Massive")) {
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
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= (1.75 + (2 * buffMultiplier));
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
        if (((!player.hasPerk(MutationsLib.HarpyHollowBonesEvolved) || (!Forgefather.channelInlay == "emerald")) && player.statusEffectv1(StatusEffects.Flying) == 0) || player.statusEffectv2(StatusEffects.Flying) != 3) {
            if (player.isFlying()) player.removeStatusEffect(StatusEffects.Flying);
            if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
                player.removeStatusEffect(StatusEffects.FlyingNoStun);
                player.removePerk(PerkLib.Resolute);
            }
            monster.removeStatusEffect(StatusEffects.MonsterAttacksDisabled);
        }
        checkAchievementDamage(damage);
        enemyAI();
    }

    public function flamesOfLoveLC():Number {
		var follc:Number = 10;
		return follc;
	}
	public function flamesOfLove():void {
        clearOutput();
        var fireDMG:Number = 0;
        fireDMG += Math.round(player.lust * (flamesOfLoveLC() * 0.01));
        player.createStatusEffect(StatusEffects.CooldownFlamesOfLove, Math.round(player.statusEffectv1(StatusEffects.KnowsFlamesOfLove)), 0, 0, 0);
        player.lust -= fireDMG;
        fireDMG *= (5 * player.statusEffectv1(StatusEffects.KnowsFlamesOfLove));
		if (monster.plural) fireDMG *= 2;
		fireDMG *= fireDamageBoostedByDao();
		fireDMG = Math.round(fireDMG);
        outputText("You concentrate on the lust flowing in your body, your veins heating up rapidly. With every beat of your heart, the heat rises, the heat in your groin transfering to the palm of your hands. \n\n");
        outputText("With almost orgasmic joy, you send a wave of flames toward [themonster]. ");
		doFireDamage(fireDMG, true, true);
        outputText("\n\n");
        enemyAI();
    }

    public function iciclesOfLoveLC():Number {
		var iollc:Number = 10;
		return iollc;
	}
	public function iciclesOfLove():void {
        clearOutput();
        var iceDMG:Number = 0;
        iceDMG += Math.round(player.lust * (iciclesOfLoveLC() * 0.01));
        player.createStatusEffect(StatusEffects.CooldownIciclesOfLove, Math.round(player.statusEffectv1(StatusEffects.KnowsIciclesOfLove)), 0, 0, 0);
        player.lust -= iceDMG;
        iceDMG *= (5 * player.statusEffectv1(StatusEffects.KnowsIciclesOfLove));
        if (monster.plural) iceDMG *= 2;
		iceDMG *= iceDamageBoostedByDao();
		iceDMG = Math.round(iceDMG);
        outputText("You start concentrate on the lust flowing in your body, your veins while imaging a joy of sharing icicles of love with enemy. Shortly after that lust starts to gather around your hands getting colder and colder till it envelop your hands in icicles.\n\n");
        outputText("And with almost orgasmic joy, you sends a wave of ice shards toward [themonster] while mumbling about 'sharing the icicles of love'. ");
		doIceDamage(iceDMG, true, true);
        outputText("\n\n");
        enemyAI();
    }

    public function stormOfSisterhoodWC():Number {
		var soswc:Number = 10;
		return soswc;
	}
	public function stormOfSisterhood():void {
        clearOutput();
        var lightingDMG:Number = 0;
        lightingDMG += Math.round(player.wrath * (stormOfSisterhoodWC() * 0.01));
        player.createStatusEffect(StatusEffects.CooldownStormOfSisterhood, Math.round(player.statusEffectv1(StatusEffects.KnowsStormOfSisterhood)), 0, 0, 0);
        player.wrath -= lightingDMG;
        lightingDMG *= (5 * player.statusEffectv1(StatusEffects.KnowsStormOfSisterhood));
        if (monster.plural) lightingDMG *= 2;
		lightingDMG *= lightningDamageBoostedByDao();
		lightingDMG = Math.round(lightingDMG);
        outputText("You start concentrate on the wrath flowing in your body, your veins while imaging a joy of sharing storm of sisterhood with enemy. Shortly after that wrath starts to gather around your hands till it envelop your hands in ligthing.\n\n");
        outputText("With joy, you sends a mass of ligthing toward [themonster] while mumbling about 'sharing the storm of sisterhood'. ");
		doLightingDamage(lightingDMG, true, true);
        outputText("\n\n");
        enemyAI();
    }

    public function nightOfBrotherhoodWC():Number {
		var nobwc:Number = 10;
		return nobwc;
	}
	public function nightOfBrotherhood():void {
        clearOutput();
        var darknessDMG:Number = 0;
		darknessDMG += Math.round(player.wrath * (nightOfBrotherhoodWC() * 0.01));
        player.createStatusEffect(StatusEffects.CooldownNightOfBrotherhood, Math.round(player.statusEffectv1(StatusEffects.KnowsNightOfBrotherhood)), 0, 0, 0);
        player.wrath -= darknessDMG;
        darknessDMG *= (5 * player.statusEffectv1(StatusEffects.KnowsNightOfBrotherhood));
        if (monster.plural) darknessDMG *= 2;
		darknessDMG *= darknessDamageBoostedByDao();
		darknessDMG = Math.round(darknessDMG);
        outputText("You start concentrate on the wrath flowing in your body, your veins while imaging a joy of sharing night of brotherhood with enemy. Shortly after that wrath starts to gather around your hands till it envelop your hands in darkness.\n\n");
        outputText("With joy, you sends a mass of darkness toward [themonster] while mumbling about 'sharing the night of brotherhood'. ");
		doDarknessDamage(darknessDMG, true, true);
        outputText("\n\n");
        enemyAI();
    }

    public function heavensDevourer():void {
        clearOutput();
        player.createStatusEffect(StatusEffects.CooldownHeavensDevourer, 4, 0, 0, 0);
        outputText("You start to concentrate and between your hands forms small black sphere inscribed with many tiny symbols. With a simple flick of hand you send it toward [themonster], which preparing to defend. But sphere stops a round twenty centimiters before [monster his]. ");
        outputText("And then it starts greedy sucking our any bit of lust or wrath it can find in [themonster] trasmiting part of it back to you.");
        var devouredLust:Number = 0;
        var transferedLust:Number = 0;
        var devouredWrath:Number = 0;
        var transferedWrath:Number = 0;
        if (monster.lust > 400) {
            monster.lust -= 400;
            transferedLust += 200;
        } else {
            devouredLust = monster.lust;
            monster.lust = 0;
            transferedLust += Math.round(devouredLust / 2)
        }
        if (transferedLust > 0) {
            outputText("(+" + transferedLust + " lust)");
            player.lust += transferedLust;
        }
        if (monster.wrath > 400) {
            monster.wrath -= 400;
            transferedWrath += 200;
        } else {
            devouredWrath = monster.wrath;
            monster.wrath = 0;
            transferedWrath += Math.round(devouredWrath / 2)
        }
        if (transferedWrath > 0) {
            outputText("(+" + transferedWrath + " wrath)");
            player.wrath += transferedWrath;
        }
        outputText("\n\n");
        statScreenRefresh();
        enemyAI();
    }

	public function bloodSwipeBloodPuppies():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(spellCostBlood(20), false);
		outputText("Giving command your blood puppies, they start focusing the power of blood. Within an instant, many red claw-like lines coalesce briefly before being shot from their paws, flying toward [themonster].\n\n");
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 0.125;
		if (damage < 10) damage = 10;
		var puppies:Number = 1;
		if (player.hasPerk(PerkLib.AsuraStrength)) puppies += 0.1;
		damage *= puppies;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= ((puppies / 2) + 1.25);
		}
		if (monster.plural) damage *= 2;
		damage = Math.round(damage * bloodDamageBoostedByDao());
		outputText(monster.capitalA + monster.short + " takes ");
        doMinionPhysDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
        doMinionPhysDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
        doMinionPhysDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
        doMinionPhysDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
        doMinionPhysDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
        doMinionPhysDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(" damage.");
		if (rand(20) < 4) {
			if (monster.hasStatusEffect(StatusEffects.Hemorrhage))  monster.removeStatusEffect(StatusEffects.Hemorrhage);
			monster.createStatusEffect(StatusEffects.Hemorrhage, 2, 0.05, 0, 0);
			outputText(" Attack leave many bloody gashes.");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		WrathGenerationPerHit2(15);
		heroBaneProc(damage);
		statScreenRefresh();
		if (flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] = 1;
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else {
			menu();
			addButton(0, "Next", combatMenu, false);
		}
	}
	public function heartSeekerBloodPuppies():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(spellCostBlood(40), false);
		outputText("Giving command your blood puppies, they start focusing the power of blood. Within an instant, large blood dripping spears coalesce briefly before being shot, flying toward [themonster] vital spot.\n\n");
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 0.25;
		if (damage < 10) damage = 10;
		var puppies:Number = 1;
		if (player.hasPerk(PerkLib.AsuraStrength)) puppies += 0.1;
		damage *= puppies;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= ((puppies / 2) + 1.25);
		}
		damage = Math.round(damage * bloodDamageBoostedByDao());
		outputText(monster.capitalA + monster.short + " takes ");
		doTrueDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doTrueDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(" damage.");
		if (rand(20) < 4) {
			if (monster.hasStatusEffect(StatusEffects.Hemorrhage))  monster.removeStatusEffect(StatusEffects.Hemorrhage);
			monster.createStatusEffect(StatusEffects.Hemorrhage, 2, 0.05, 0, 0);
			outputText(" Attack leave many bloody gashes.");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		WrathGenerationPerHit2(15);
		heroBaneProc(damage);
		statScreenRefresh();
		if (flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] = 1;
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else {
			menu();
			addButton(0, "Next", combatMenu, false);
		}
	}
	public function bloodDewdropsBloodPuppies():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(spellCostBlood(80), false);
		outputText("Giving command your blood puppies, they start focusing the power of blood. Within an instant, many red dewdrops shoots from one of their front paws their rised for short moment, flying toward [themonster].\n\n");
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 0.5;
		if (damage < 10) damage = 10;
		var puppies:Number = 1;
		if (player.hasPerk(PerkLib.AsuraStrength)) puppies += 0.1;
		damage *= puppies;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= ((puppies / 2) + 1.25);
		}
		if (monster.plural) damage *= 10;
		damage = Math.round(damage * bloodDamageBoostedByDao());
		outputText(monster.capitalA + monster.short + " takes ");
        doPhysicalDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
        doPhysicalDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
        doPhysicalDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
        doPhysicalDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(" damage.");
		if (rand(20) < 4) {
			if (monster.hasStatusEffect(StatusEffects.Hemorrhage))  monster.removeStatusEffect(StatusEffects.Hemorrhage);
			monster.createStatusEffect(StatusEffects.Hemorrhage, 2, 0.05, 0, 0);
			outputText(" Attack leave many bloody gashes.");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		WrathGenerationPerHit2(15);
		heroBaneProc(damage);
		statScreenRefresh();
		if (flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] = 1;
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else {
			menu();
			addButton(0, "Next", combatMenu, false);
		}
	}

	public function asuraformCost():Number {
		var modcsc:Number = 20;
		if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) modcsc += 20;
		if (player.hasPerk(PerkLib.AsuraStrength)) modcsc += 20;
		//if (player.hasPerk(PerkLib.)) modcsc += 20;
		//if (player.hasPerk(PerkLib.)) modcsc += 20;
		return modcsc;
	}
	public function assumeAsuraForm():void {
		clearOutput();
		player.wrath -= asuraformCost();
		outputText("As you starts to unleash your inner wrath two additional faces emerge from head on sides and " + (player.playerHasFourArms() ? "":"two ") + "additional pair" + (player.playerHasFourArms() ? "":"s") + " of arms grows under your " + (player.playerHasFourArms() ? "second":"first") + " pair" + (player.playerHasFourArms() ? "s":"") + " of arms. ");
		if (player.hasPerk(PerkLib.AsuraStrength)) {
			outputText("Additionaly from your back emerge ");
			outputText("pair ");
			outputText("of semi-transparent arms. ");
		}
		outputText("Finishing assuming Asura form you're ready to destroy anyone that would dare to stand in your way!\n\n");
		assumeAsuraForm007();
		statScreenRefresh();
		enemyAI();
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
		if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) {
			temp1 += player.strStat.core.value * 0.6;
			temp2 += player.touStat.core.value * 0.3;
			temp3 += player.speStat.core.value * 0.2;
		}
		if (player.hasPerk(PerkLib.AsuraStrength)) {
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
		player.statStore.removeBuffs("AsuraForm");
		enemyAI();
	}

	public function asurasHowl():void {
		clearOutput();
		player.wrath -= 50;
		var heal:Number = 0;
		heal += scalingBonusIntelligence();
		if (player.hasPerk(PerkLib.WisenedHealer)) heal += scalingBonusWisdom();
		heal *= healMod();
		if (player.armorName == "skimpy nurse's outfit") heal *= 1.2;
		if (player.weaponName == "unicorn staff") heal *= 1.5;
		if (player.hasPerk(PerkLib.CloseToDeath) && player.HP < (player.maxHP() * 0.25)) {
			if (player.hasPerk(PerkLib.CheatDeath) && player.HP < (player.maxHP() * 0.1)) heal *= 2.5;
			else heal *= 1.5;
		}
		if (player.hasPerk(PerkLib.AbsoluteStrength)) heal *= 1.1;
		if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) heal *= 1.2;
		if (player.hasPerk(PerkLib.ICastAsuraFist)) heal *= 1.3;
		if (player.hasPerk(PerkLib.AsuraStrength)) heal *= 1.4;
		//Determine if critical heal!
		var crit:Boolean = false;
		var critHeal:int = 5;
		critHeal += combatMagicalCritical();
		if (rand(100) < critHeal) {
			crit = true;
			heal *= 1.75;
		}
		heal = Math.round(heal);
		outputText("Gathering all you wrath you unleash howl while your wounds healing a bit. <b>(<font color=\"#008000\">+" + heal + "</font>)</b>.");
		if (crit) outputText(" <b>*Critical Heal!*</b>");
		HPChange(heal,false);
		basemeleeattacks();
	}

	public function asurasSixFingersOfDestruction():void {
		clearOutput();
		var SFoDMulti:Number = 1;
		SFoDMulti += player.wrath100 * 0.03;
		if (player.hasPerk(PerkLib.JobWarrior) || player.hasPerk(PerkLib.JobBeastWarrior)) SFoDMulti *= 2.5;
		if (player.hasPerk(PerkLib.PrestigeJobBerserker)) SFoDMulti *= 2;
		if (player.hasPerk(PerkLib.VexedNocking)) SFoDMulti *= 2;
		player.wrath -= Math.round(player.maxWrath() * 0.5);
		var damage:Number = unarmedAttack();
		damage += player.str;
		damage += ghostStrength();
		damage += scalingBonusStrength() * 0.25;
		if (damage < 50) damage = 50;
		if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
		}
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.hasPerk(PerkLib.OniTyrantKimono || PerkLib.OniEnlightenedKimono)) damage *= 1.4;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		if (player.hasStatusEffect(StatusEffects.TyrantState)) damage *= tyrantStagePowerMulti();
		damage *= (1 + SFoDMulti);
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
		outputText("You focus the force of your wrath, pushing the energy to the tip of your fingers. With a deep breath, you release the stored energy, thrusting it upon [themonster]. Six finger-shaped constructs materialize before you as they fly toward [themonster]. ");
        doPhysicalDamage(damage, true, true);
        doPhysicalDamage(damage, true, true);
        doPhysicalDamage(damage, true, true);
        doPhysicalDamage(damage, true, true);
        doPhysicalDamage(damage, true, true);
        doPhysicalDamage(damage, true, true);
		if (crit) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		outputText("\n\n");
		heroBaneProc(damage);
		EruptingRiposte();
        statScreenRefresh();
        enemyAI();
	}

	public function sendSkeletonToFight():void {
		clearOutput();
		outputText("Your skeleton warrior"+(player.perkv2(PerkLib.PrestigeJobNecromancer) > 1 ? "s":"")+" charge into battle swinging "+(player.perkv2(PerkLib.PrestigeJobNecromancer) > 1 ? "they're":"his")+" blade arounds. ");
		var damage:Number = 0;
		var dmgamp:Number = 1;
		damage += 500 + rand(151);
		damage += scalingBonusIntelligence() * 0.2;
		damage += scalingBonusWisdom() * 0.4;
		if (player.hasPerk(PerkLib.GreaterHarvest)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.BoneSoul)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.SkeletonLord)) dmgamp += 0.1;
		if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) {
			dmgamp += 0.1;
			if (player.hasPerk(PerkLib.WispLieutenant)) dmgamp += 0.2;
			if (player.hasPerk(PerkLib.WispCaptain)) dmgamp += 0.3;
			if (player.hasPerk(PerkLib.WispMajor)) dmgamp += 0.4;
			if (player.hasPerk(PerkLib.WispColonel)) dmgamp += 0.5;
		}
		damage *= dmgamp;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
        doMinionPhysDamage(damage, true, true);
		if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 1) doMinionPhysDamage(damage, true, true);
		if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 2) doMinionPhysDamage(damage, true, true);
		if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 3) doMinionPhysDamage(damage, true, true);
		if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 4) doMinionPhysDamage(damage, true, true);
		if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 5) doMinionPhysDamage(damage, true, true);
		if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 6) doMinionPhysDamage(damage, true, true);
		if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 7) doMinionPhysDamage(damage, true, true);
		if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 8) doMinionPhysDamage(damage, true, true);
		if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 9) doMinionPhysDamage(damage, true, true);
		if (player.hasPerk(PerkLib.GreaterHarvest) && player.perkv1(PerkLib.GreaterHarvest) > 0) {
			outputText("Your archer"+(player.perkv1(PerkLib.GreaterHarvest) > 1 ? "s":"")+" fellow suit unleashing a volley of arrows. ");
            doMinionPhysDamage(damage, true, true);
			if (player.perkv1(PerkLib.GreaterHarvest) > 1) doMinionPhysDamage(damage, true, true);
			if (player.perkv1(PerkLib.GreaterHarvest) > 2) doMinionPhysDamage(damage, true, true);
			if (player.perkv1(PerkLib.GreaterHarvest) > 3) doMinionPhysDamage(damage, true, true);
			if (player.perkv1(PerkLib.GreaterHarvest) > 4) doMinionPhysDamage(damage, true, true);
			if (player.perkv1(PerkLib.GreaterHarvest) > 5) doMinionPhysDamage(damage, true, true);
			if (player.perkv1(PerkLib.GreaterHarvest) > 6) doMinionPhysDamage(damage, true, true);
			if (player.perkv1(PerkLib.GreaterHarvest) > 7) doMinionPhysDamage(damage, true, true);
			if (player.perkv1(PerkLib.GreaterHarvest) > 8) doMinionPhysDamage(damage, true, true);
			if (player.perkv1(PerkLib.GreaterHarvest) > 9) doMinionPhysDamage(damage, true, true);
			if (player.perkv2(PerkLib.GreaterHarvest) > 0) {
				outputText("Finally the skeletal mage"+(player.perkv2(PerkLib.GreaterHarvest) > 1 ? "s":"")+" unleash a barrage of magic missles. ");
				doMagicDamage(damage, true, true);
				if (player.perkv2(PerkLib.GreaterHarvest) > 1) doMinionPhysDamage(damage, true, true);
				if (player.perkv2(PerkLib.GreaterHarvest) > 2) doMinionPhysDamage(damage, true, true);
				if (player.perkv2(PerkLib.GreaterHarvest) > 3) doMinionPhysDamage(damage, true, true);
				if (player.perkv2(PerkLib.GreaterHarvest) > 4) doMinionPhysDamage(damage, true, true);
				if (player.perkv2(PerkLib.GreaterHarvest) > 5) doMinionPhysDamage(damage, true, true);
				if (player.perkv2(PerkLib.GreaterHarvest) > 6) doMinionPhysDamage(damage, true, true);
				if (player.perkv2(PerkLib.GreaterHarvest) > 7) doMinionPhysDamage(damage, true, true);
				if (player.perkv2(PerkLib.GreaterHarvest) > 8) doMinionPhysDamage(damage, true, true);
				if (player.perkv2(PerkLib.GreaterHarvest) > 9) doMinionPhysDamage(damage, true, true);
			}
		}
		outputText("\n\n");
		//checkAchievementDamage(damage);
		statScreenRefresh();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	public function skeletonSmash():void {
		clearOutput();
		outputText("Your Skeletons upon command gang up on [themonster] swarming from all side and leaving [monster him] stunned. ");
		var damage:Number = 0;
		var dmgamp:Number = 1;
		damage += 500 + rand(151);
		damage += scalingBonusIntelligence() * 0.2;
		damage += scalingBonusWisdom() * 0.4;
		if (player.hasPerk(PerkLib.GreaterHarvest)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.BoneSoul)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.SkeletonLord)) dmgamp += 0.1;
		if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) {
			dmgamp += 0.1;
			if (player.hasPerk(PerkLib.WispLieutenant)) dmgamp += 0.2;
			if (player.hasPerk(PerkLib.WispCaptain)) dmgamp += 0.3;
			if (player.hasPerk(PerkLib.WispMajor)) dmgamp += 0.4;
			if (player.hasPerk(PerkLib.WispColonel)) dmgamp += 0.5;
		}
		damage *= dmgamp;
		if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 0) damage *= player.perkv2(PerkLib.PrestigeJobNecromancer);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		doMinionPhysDamage(damage, true, true);
		monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		//checkAchievementDamage(damage);
		outputText("\n\n");
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	
	public function noLimiterState():void {
		clearOutput();
		outputText("No limiter on!\n\n");
		var tempStr:Number = player.str;
		mainView.statsView.showStatUp('str');
		player.buff("NoLimiterState").addStats({"str":tempStr}).withText("No limiter").combatPermanent();
		statScreenRefresh();
		menu();
		addButton(0, "Next", combatMenu, false);
	}
	public function returnToNormalState():void {
		clearOutput();
		outputText("No limiter off!\n\n");
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
		if (player.hasStatusEffect(StatusEffects.DaoOfFire)) {
			if (player.statusEffectv2(StatusEffects.DaoOfFire) == 5) boostF += 0.7;
			if (player.statusEffectv2(StatusEffects.DaoOfFire) == 4) boostF += 0.5;
			if (player.statusEffectv2(StatusEffects.DaoOfFire) == 3) boostF += 0.3;
			if (player.statusEffectv2(StatusEffects.DaoOfFire) == 2) boostF += 0.2;
			if (player.statusEffectv2(StatusEffects.DaoOfFire) == 1) boostF += 0.1;
		}
		return boostF;
	}
	public function iceDamageBoostedByDao():Number {
		var boostI:Number = 1;
		if (player.hasStatusEffect(StatusEffects.DaoOfIce)) {
			if (player.statusEffectv2(StatusEffects.DaoOfIce) == 5) boostI += 0.7;
			if (player.statusEffectv2(StatusEffects.DaoOfIce) == 4) boostI += 0.5;
			if (player.statusEffectv2(StatusEffects.DaoOfIce) == 3) boostI += 0.3;
			if (player.statusEffectv2(StatusEffects.DaoOfIce) == 2) boostI += 0.2;
			if (player.statusEffectv2(StatusEffects.DaoOfIce) == 1) boostI += 0.1;
		}
		return boostI;
	}
	public function lightningDamageBoostedByDao():Number {
		var boostL:Number = 1;
		if (player.hasStatusEffect(StatusEffects.DaoOfLightning)) {
			if (player.statusEffectv2(StatusEffects.DaoOfLightning) == 5) boostL += 0.7;
			if (player.statusEffectv2(StatusEffects.DaoOfLightning) == 4) boostL += 0.5;
			if (player.statusEffectv2(StatusEffects.DaoOfLightning) == 3) boostL += 0.3;
			if (player.statusEffectv2(StatusEffects.DaoOfLightning) == 2) boostL += 0.2;
			if (player.statusEffectv2(StatusEffects.DaoOfLightning) == 1) boostL += 0.1;
		}
		return boostL;
	}
	public function darknessDamageBoostedByDao():Number {
		var boostD:Number = 1;
		if (player.hasStatusEffect(StatusEffects.DaoOfDarkness)) {
			if (player.statusEffectv2(StatusEffects.DaoOfDarkness) == 5) boostD += 0.7;
			if (player.statusEffectv2(StatusEffects.DaoOfDarkness) == 4) boostD += 0.5;
			if (player.statusEffectv2(StatusEffects.DaoOfDarkness) == 3) boostD += 0.3;
			if (player.statusEffectv2(StatusEffects.DaoOfDarkness) == 2) boostD += 0.2;
			if (player.statusEffectv2(StatusEffects.DaoOfDarkness) == 1) boostD += 0.1;
		}
		return boostD;
	}
	public function poisonDamageBoostedByDao():Number {
		var boostP:Number = 1;
		if (player.hasStatusEffect(StatusEffects.DaoOfPoison)) {
			if (player.statusEffectv2(StatusEffects.DaoOfPoison) == 5) boostP += 0.7;
			if (player.statusEffectv2(StatusEffects.DaoOfPoison) == 4) boostP += 0.5;
			if (player.statusEffectv2(StatusEffects.DaoOfPoison) == 3) boostP += 0.3;
			if (player.statusEffectv2(StatusEffects.DaoOfPoison) == 2) boostP += 0.2;
			if (player.statusEffectv2(StatusEffects.DaoOfPoison) == 1) boostP += 0.1;
		}
		return boostP;
	}
	public function windDamageBoostedByDao():Number {
		var boostWi:Number = 1;
		if (player.hasStatusEffect(StatusEffects.DaoOfWind)) {
			if (player.statusEffectv2(StatusEffects.DaoOfWind) == 5) boostWi += 0.7;
			if (player.statusEffectv2(StatusEffects.DaoOfWind) == 4) boostWi += 0.5;
			if (player.statusEffectv2(StatusEffects.DaoOfWind) == 3) boostWi += 0.3;
			if (player.statusEffectv2(StatusEffects.DaoOfWind) == 2) boostWi += 0.2;
			if (player.statusEffectv2(StatusEffects.DaoOfWind) == 1) boostWi += 0.1;
		}
		return boostWi;
	}
	public function bloodDamageBoostedByDao():Number {
		var boostBl:Number = 1;
		if (player.hasStatusEffect(StatusEffects.DaoOfBlood)) {
			if (player.statusEffectv2(StatusEffects.DaoOfBlood) == 5) boostBl += 0.7;
			if (player.statusEffectv2(StatusEffects.DaoOfBlood) == 4) boostBl += 0.5;
			if (player.statusEffectv2(StatusEffects.DaoOfBlood) == 3) boostBl += 0.3;
			if (player.statusEffectv2(StatusEffects.DaoOfBlood) == 2) boostBl += 0.2;
			if (player.statusEffectv2(StatusEffects.DaoOfBlood) == 1) boostBl += 0.1;
		}
		return boostBl;
	}
	public function waterDamageBoostedByDao():Number {
		var boostWa:Number = 1;
		if (player.hasStatusEffect(StatusEffects.DaoOfWater)) {
			if (player.statusEffectv2(StatusEffects.DaoOfWater) == 5) boostWa += 0.7;
			if (player.statusEffectv2(StatusEffects.DaoOfWater) == 4) boostWa += 0.5;
			if (player.statusEffectv2(StatusEffects.DaoOfWater) == 3) boostWa += 0.3;
			if (player.statusEffectv2(StatusEffects.DaoOfWater) == 2) boostWa += 0.2;
			if (player.statusEffectv2(StatusEffects.DaoOfWater) == 1) boostWa += 0.1;
		}
		return boostWa;
	}
	public function earthDamageBoostedByDao():Number {
		var boostEa:Number = 1;
		if (player.hasStatusEffect(StatusEffects.DaoOfEarth)) {
			if (player.statusEffectv2(StatusEffects.DaoOfEarth) == 5) boostEa += 0.7;
			if (player.statusEffectv2(StatusEffects.DaoOfEarth) == 4) boostEa += 0.5;
			if (player.statusEffectv2(StatusEffects.DaoOfEarth) == 3) boostEa += 0.3;
			if (player.statusEffectv2(StatusEffects.DaoOfEarth) == 2) boostEa += 0.2;
			if (player.statusEffectv2(StatusEffects.DaoOfEarth) == 1) boostEa += 0.1;
		}
		return boostEa;
	}
	public function acidDamageBoostedByDao():Number {
		var boostAc:Number = 1;
		if (player.hasStatusEffect(StatusEffects.DaoOfAcid)) {
			if (player.statusEffectv2(StatusEffects.DaoOfAcid) == 5) boostAc += 0.7;
			if (player.statusEffectv2(StatusEffects.DaoOfAcid) == 4) boostAc += 0.5;
			if (player.statusEffectv2(StatusEffects.DaoOfAcid) == 3) boostAc += 0.3;
			if (player.statusEffectv2(StatusEffects.DaoOfAcid) == 2) boostAc += 0.2;
			if (player.statusEffectv2(StatusEffects.DaoOfAcid) == 1) boostAc += 0.1;
		}
		return boostAc;
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

    public function oniRampagePowerMulti():Number {
        var oniRampagePowerMulti:Number = 3;
        if (player.hasPerk(MutationsLib.OniMusculaturePrimitive)) oniRampagePowerMulti += 1;
        if (player.hasPerk(MutationsLib.OniMusculatureEvolved)) oniRampagePowerMulti += 2;
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
		if (player.hasPerk(PerkLib.IronFistsIV)) mod += .1;
		if (player.hasPerk(PerkLib.IronFistsV)) mod += .1;
		if (player.hasPerk(PerkLib.IronFistsVI)) mod += .1;
		if (player.hasPerk(PerkLib.UnlimitedRage)) mod += .1;
		if (player.hasPerk(PerkLib.GigantGrip)) mod += .1;
		if (player.hasPerk(PerkLib.ImprovedBrute)) mod += .1;
		if (player.hasPerk(PerkLib.ImprovedBrawn)) mod += .1;
		if (player.hasPerk(PerkLib.ThirstForBlood)) mod += .15;
		if (player.hasPerk(PerkLib.GigantGripEx)) mod += .15;
		if (player.hasPerk(PerkLib.GreaterBrute)) mod += .15;
		if (player.hasPerk(PerkLib.GreaterBrawn)) mod += .15;
		//if (player.hasPerk(PerkLib.GigantGripSu)) mod += .2; - not included in calculations yet
		if (player.hasPerk(PerkLib.EpicBrute)) mod += .2;
		if (player.hasPerk(PerkLib.EpicBrawn)) mod += .2;
		if (player.hasPerk(PerkLib.LegendaryBrute)) mod += .25;
		if (player.hasPerk(PerkLib.LegendaryBrawn)) mod += .25;
		if (player.hasPerk(PerkLib.MythicalBrute)) mod += .3;
		if (player.hasPerk(PerkLib.MythicalBrawn)) mod += .3;//450% up to here
		if (player.hasPerk(PerkLib.PrestigeJobBerserker)) {
			mod += .8;
			if (player.hasPerk(PerkLib.FuelForTheFire)) {
				var berzerkermulti:Number = 0.1;
				if (player.hasPerk(PerkLib.Rage)) berzerkermulti += .1;
				if (player.hasPerk(PerkLib.Anger)) berzerkermulti += .1;
				if (player.hasPerk(PerkLib.TooAngryToDie)) berzerkermulti += .1;
				if (player.hasPerk(PerkLib.EndlessRage)) berzerkermulti += .1;
				if (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking)) berzerkermulti *= 2;
				if (player.weaponSpecials("Large") || player.weaponSpecials("Dual Large") || player.weaponSpecials("Massive")) berzerkermulti *= 2;
				mod += berzerkermulti;
			}
		}
		if (player.hasPerk(PerkLib.PrestigeJobSpellKnight)) mod += .4;
		if (player.hasPerk(PerkLib.PrestigeJobTempest)) mod += .4;
		if (player.hasPerk(PerkLib.PrestigeJobSoulArtMaster)) mod += .4;
		if (player.hasPerk(PerkLib.WarCaster)) mod += .2;
		if (player.hasPerk(PerkLib.VampiricBlade)) mod += .2;
		if (player.hasPerk(PerkLib.TwinRiposte)) mod += .2;
		if (player.hasPerk(PerkLib.PerfectStrike)) mod += .2;//780~830~930% up to here
		if (player.hasPerk(PerkLib.AscensionKillingIntent)) mod *= 1 + (player.perkv1(PerkLib.AscensionKillingIntent) * 0.1);
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	public function rangePhysicalForce():Number {
		var mod:Number = 1;
		if (player.hasPerk(PerkLib.JobRanger)) mod += .1;
		if (player.hasPerk(PerkLib.JobHunter)) mod += .2;
		if (player.hasPerk(PerkLib.JobGunslinger)) mod += .2;
		if (player.hasPerk(PerkLib.CarefulButRecklessAimAndShooting)) mod += .05;
		if (player.hasPerk(PerkLib.Sharpshooter)) mod += .05;
		if (player.hasPerk(PerkLib.PowerShot)) mod += .05;
		if (player.hasPerk(PerkLib.AlchemicalCartridge)) mod += .05;
		if (player.hasPerk(PerkLib.ColdAim)) mod += .1;
		if (player.hasPerk(PerkLib.DeadlyThrow)) mod += .1;
		if (player.hasPerk(PerkLib.PracticedShot)) mod += .1;
		if (player.hasPerk(PerkLib.ChurchOfTheGun)) mod += .1;
		if (player.hasPerk(PerkLib.ExplosiveCartridge)) mod += .1;
		if (player.hasPerk(PerkLib.TaintedMagazine)) mod += .1;
		if (player.hasPerk(PerkLib.AnatomyExpert)) mod += .15;
		if (player.hasPerk(PerkLib.EagleEye)) mod += .15;
		if (player.hasPerk(PerkLib.SilverForMonsters)) mod += .15;
		if (player.hasPerk(PerkLib.NamedBullet)) mod += .2;//195% up to here
		if (player.hasPerk(PerkLib.PrestigeJobArcaneArcher)) mod += .4;
		if (player.hasPerk(PerkLib.ElementalArrows)) mod += .2;
		if (player.hasPerk(PerkLib.Cupid)) mod += .2;//275% up to here
		if (player.hasPerk(PerkLib.AscensionBloodlust)) mod *= 1 + (player.perkv1(PerkLib.AscensionBloodlust) * 0.1);
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

    public function soulskillMod():Number {
        var modss:Number = 1;
        if (player.hasPerk(PerkLib.DaoistCultivator) && player.wis >= 20) modss += .2;
        if (player.hasPerk(PerkLib.DaoistApprenticeStage)) {
            if (player.hasPerk(PerkLib.SoulApprentice) && player.wis >= 30) modss += .4;
            if (player.hasPerk(PerkLib.SoulPersonage) && player.wis >= 40) modss += .4;
            if (player.hasPerk(PerkLib.SoulWarrior) && player.wis >= 50) modss += .4;
        }
        if (player.hasPerk(PerkLib.DaoistWarriorStage)) {
            if (player.hasPerk(PerkLib.SoulSprite) && player.wis >= 60) modss += .6;
            if (player.hasPerk(PerkLib.SoulScholar) && player.wis >= 70) modss += .6;
            if (player.hasPerk(PerkLib.SoulElder) && player.wis >= 80) modss += .6;
        }
        if (player.hasPerk(PerkLib.DaoistElderStage)) {
            if (player.hasPerk(PerkLib.SoulExalt) && player.wis >= 90) modss += .8;
            if (player.hasPerk(PerkLib.SoulOverlord) && player.wis >= 100) modss += .8;
            if (player.hasPerk(PerkLib.SoulTyrant) && player.wis >= 110) modss += .8;
        }
        if (player.hasPerk(PerkLib.DaoistOverlordStage)) {
            if (player.hasPerk(PerkLib.SoulKing) && player.wis >= 120) modss += 1;
            if (player.hasPerk(PerkLib.SoulEmperor) && player.wis >= 130) modss += 1;
            if (player.hasPerk(PerkLib.SoulAncestor) && player.wis >= 140) modss += 1;
        }
        if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) modss += .3;
        if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) modss += .4;
        if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) modss += .5;
        if (player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) modss += .6;
        if (player.hasPerk(PerkLib.DaoistsFocus)) modss += player.perkv1(PerkLib.DaoistsFocus);
        if (player.hasPerk(PerkLib.DaoistsFocusRange)) modss += player.perkv1(PerkLib.DaoistsFocusRange);
        if (player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) modss += player.perkv2(PerkLib.WizardsAndDaoistsFocus);
        if (player.hasPerk(PerkLib.SeersInsight)) modss += player.perkv1(PerkLib.SeersInsight);
        if (player.hasPerk(PerkLib.AscensionSpiritualEnlightenment)) modss *= 1 + (player.perkv1(PerkLib.AscensionSpiritualEnlightenment) * 0.1);
        if (player.hasPerk(PerkLib.InariBlessedKimono)){
            var mod1:Number = 0.5;
            mod1 -= player.cor / 100;
            if (mod1 < 0.1) mod1 = 0.1;
            modss += mod1;
        }
        if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) modss += (player.cor * .01)/2;
        if (player.necklaceName == "Yin Yang Amulet") modss += .15;
        if (player.armorName == "Traditional clothes") modss += .4;
		if (player.hasPerk(PerkLib.ElementalBody)) {
			if (player.perkv1(PerkLib.ElementalBody) == 1 || player.perkv1(PerkLib.ElementalBody) == 2 || player.perkv1(PerkLib.ElementalBody) == 3) {
				if (player.perkv2(PerkLib.ElementalBody) == 1) modss += .05;
				if (player.perkv2(PerkLib.ElementalBody) == 2) modss += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 3) modss += .15;
				if (player.perkv2(PerkLib.ElementalBody) == 4) modss += .2;
			}
			else {
				if (player.perkv2(PerkLib.ElementalBody) == 1) modss += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 2) modss += .2;
				if (player.perkv2(PerkLib.ElementalBody) == 3) modss += .3;
				if (player.perkv2(PerkLib.ElementalBody) == 4) modss += .4;
			}
		}
        modss = Math.round(modss * 100) / 100;
        return modss;
    }

    public function soulskillPhysicalMod():Number {
        var modssp:Number = 1;
        if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) modssp += .3;
        if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) modssp += .4;
        if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) modssp += .5;
        if (player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) modssp += .6;
        if (player.hasPerk(PerkLib.BodyCultivatorsFocus)) modssp += player.perkv1(PerkLib.BodyCultivatorsFocus);
        if (player.hasPerk(PerkLib.BodyCultivatorsFocusRange)) modssp += player.perkv1(PerkLib.BodyCultivatorsFocusRange);
        if (player.hasPerk(PerkLib.AscensionSpiritualEnlightenment)) modssp *= 1 + (player.perkv1(PerkLib.AscensionSpiritualEnlightenment) * 0.1);
        if (player.hasPerk(PerkLib.InariBlessedKimono)){
            var mod1:Number = 0.5;
            mod1 -= player.cor / 100;
            if (mod1 < 0.1) mod1 = 0.1;
            modssp += mod1;
        }
        if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) modssp += (player.cor * .01)/2;
        if (player.necklaceName == "Yin Yang Amulet") modssp += .15;
        if (player.armorName == "Traditional clothes") modssp += .4;
		if (player.hasPerk(PerkLib.ElementalBody)) {
			if (player.perkv1(PerkLib.ElementalBody) == 1 || player.perkv1(PerkLib.ElementalBody) == 2 || player.perkv1(PerkLib.ElementalBody) == 3) {
				if (player.perkv2(PerkLib.ElementalBody) == 1) modssp += .05;
				if (player.perkv2(PerkLib.ElementalBody) == 2) modssp += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 3) modssp += .15;
				if (player.perkv2(PerkLib.ElementalBody) == 4) modssp += .2;
			}
			else {
				if (player.perkv2(PerkLib.ElementalBody) == 1) modssp += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 2) modssp += .2;
				if (player.perkv2(PerkLib.ElementalBody) == 3) modssp += .3;
				if (player.perkv2(PerkLib.ElementalBody) == 4) modssp += .4;
			}
		}
        modssp = Math.round(modssp * 100) / 100;
        return modssp;
    }

    public function soulskillMagicalMod():Number {
        var modssm:Number = 1;
        if (player.hasPerk(PerkLib.DaoistCultivator) && player.wis >= 20) modssm += .2;
        if (player.hasPerk(PerkLib.DaoistApprenticeStage)) {
            if (player.hasPerk(PerkLib.SoulApprentice) && player.wis >= 30) modssm += .4;
            if (player.hasPerk(PerkLib.SoulPersonage) && player.wis >= 40) modssm += .4;
            if (player.hasPerk(PerkLib.SoulWarrior) && player.wis >= 50) modssm += .4;
        }
        if (player.hasPerk(PerkLib.DaoistWarriorStage)) {
            if (player.hasPerk(PerkLib.SoulSprite) && player.wis >= 60) modssm += .6;
            if (player.hasPerk(PerkLib.SoulScholar) && player.wis >= 70) modssm += .6;
            if (player.hasPerk(PerkLib.SoulElder) && player.wis >= 80) modssm += .6;
        }
        if (player.hasPerk(PerkLib.DaoistElderStage)) {
            if (player.hasPerk(PerkLib.SoulExalt) && player.wis >= 90) modssm += .8;
            if (player.hasPerk(PerkLib.SoulOverlord) && player.wis >= 100) modssm += .8;
            if (player.hasPerk(PerkLib.SoulTyrant) && player.wis >= 110) modssm += .8;
        }
        if (player.hasPerk(PerkLib.DaoistOverlordStage)) {
            if (player.hasPerk(PerkLib.SoulKing) && player.wis >= 120) modssm += 1;
            if (player.hasPerk(PerkLib.SoulEmperor) && player.wis >= 130) modssm += 1;
            if (player.hasPerk(PerkLib.SoulAncestor) && player.wis >= 140) modssm += 1;
        }
        if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) modssm += .3;
        if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) modssm += .4;
        if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) modssm += .5;
        if (player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) modssm += .6;
        if (player.hasPerk(PerkLib.DaoistsFocus)) modssm += player.perkv1(PerkLib.DaoistsFocus);
        if (player.hasPerk(PerkLib.DaoistsFocusRange)) modssm += player.perkv1(PerkLib.DaoistsFocusRange);
        if (player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) modssm += player.perkv2(PerkLib.WizardsAndDaoistsFocus);
        if (player.hasPerk(PerkLib.SeersInsight)) modssm += player.perkv1(PerkLib.SeersInsight);
        if (player.hasPerk(PerkLib.AscensionSpiritualEnlightenment)) modssm *= 1 + (player.perkv1(PerkLib.AscensionSpiritualEnlightenment) * 0.1);
        if (player.hasPerk(PerkLib.InariBlessedKimono)){
            var mod1:Number = 0.5;
            mod1 -= player.cor / 100;
            if (mod1 < 0.1) mod1 = 0.1;
            modssm += mod1;
        }
        if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) modssm += (player.cor * .01)/2;
        if (player.necklaceName == "Yin Yang Amulet") modssm += .15;
        if (player.shieldName == "spirit focus") modssm += .25;
        if (player.armorName == "Traditional clothes") modssm += .4;
		if (player.hasPerk(PerkLib.ElementalBody)) {
			if (player.perkv1(PerkLib.ElementalBody) == 1 || player.perkv1(PerkLib.ElementalBody) == 2 || player.perkv1(PerkLib.ElementalBody) == 3) {
				if (player.perkv2(PerkLib.ElementalBody) == 1) modssm += .05;
				if (player.perkv2(PerkLib.ElementalBody) == 2) modssm += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 3) modssm += .15;
				if (player.perkv2(PerkLib.ElementalBody) == 4) modssm += .2;
			}
			else {
				if (player.perkv2(PerkLib.ElementalBody) == 1) modssm += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 2) modssm += .2;
				if (player.perkv2(PerkLib.ElementalBody) == 3) modssm += .3;
				if (player.perkv2(PerkLib.ElementalBody) == 4) modssm += .4;
			}
		}
        modssm = Math.round(modssm * 100) / 100;
        return modssm;
    }

    public function soulskillcostmulti():Number {
        var multiss:Number = 1;
        if (soulskillMod() > 1) multiss += (soulskillMod() - 1) * 0.1;
        if (player.level >= 27 && player.wis >= 80) multiss += 1;//początek używania Dao of Elements
        if (player.level >= 54 && player.wis >= 140) multiss += 1;//początek zdolności latania
        if (player.level >= 78 && player.wis >= 200) multiss += 1;//początek tworzenia klonów
        //if (player.level >= 78 && player.wis >= 260) multiss += 1;//początek czegoś tam
        multiss = Math.round(multiss * 100) / 100;
        return multiss;
    }

    public function soulskillCost():Number {
        var modssc:Number = 1;
        if (player.hasPerk(PerkLib.DaoistCultivator)) modssc -= .1;
        if (player.hasPerk(PerkLib.WizardsAndDaoistsEndurance)) modssc -= (0.01 * player.perkv2(PerkLib.WizardsAndDaoistsEndurance));
        if (player.hasPerk(PerkLib.SeersInsight)) modssc -= player.perkv1(PerkLib.SeersInsight);
        if (player.jewelryName == "fox hairpin") modssc -= .2;
        if (modssc < 0.1) modssc = 0.1;
        modssc = Math.round(modssc * 100) / 100;
        return modssc;
    }

	public function flyingSwordAttackCost():Number {
		var fsac:Number = 25;
		if (player.hasPerk(PerkLib.SoaringBlades)) {
			fsac -= 5;
			if (player.perkv1(PerkLib.Dantain) > 0) fsac -= 5;
			if (player.perkv1(PerkLib.Dantain) > 1) fsac -= 5;
			if (player.perkv1(PerkLib.Dantain) > 2) fsac -= 5;
		}
		if (player.weaponFlyingSwordsPerk == "Large") fsac *= 2;
		if (player.weaponFlyingSwordsPerk == "Massive") fsac *= 3;
		if (player.weaponFlyingSwords == weaponsflyingswords.ASAUCHI) fsac *= 0.8;
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
        if (player.hasPerk(PerkLib.ThirstForBlood)) BleedMod += 0.5;
        if (player.hasPerk(MutationsLib.SharkOlfactorySystem)) BleedMod += 0.5;
        if (player.hasPerk(MutationsLib.SharkOlfactorySystemPrimitive)) BleedMod += 0.5;
        if (player.hasPerk(MutationsLib.SharkOlfactorySystemEvolved)) BleedMod += 0.5;
        if (isARacialAbility) BleedMod *= combat.RacialParagonAbilityBoost();
        return BleedMod;
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
        if (player.hasPerk(MutationsLib.DraconicHeartPrimitive)) ghostStrMulti += 0.05;
        if (player.hasPerk(MutationsLib.DraconicHeartEvolved)) ghostStrMulti += 0.1;
        if (player.hasPerk(MutationsLib.OrcAdrenalGlands)) ghostStrMulti += 0.05;
        if (player.hasPerk(MutationsLib.OrcAdrenalGlandsPrimitive)) ghostStrMulti += 0.1;
        if (player.hasPerk(MutationsLib.OrcAdrenalGlandsEvolved)) ghostStrMulti += 0.15;
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
        if (player.hasPerk(MutationsLib.DraconicLungsPrimitive)) ghostSpeMulti += 0.05;
        if (player.hasPerk(MutationsLib.DraconicLungsEvolved)) ghostSpeMulti += 0.1;
        if (player.hasPerk(MutationsLib.ElvishPeripheralNervSys)) ghostSpeMulti += 0.05;
        if (player.hasPerk(MutationsLib.ElvishPeripheralNervSysPrimitive)) ghostSpeMulti += 0.1;
        if (player.hasPerk(MutationsLib.ElvishPeripheralNervSysEvolved)) ghostSpeMulti += 0.15;
        if (player.hasPerk(MutationsLib.MantislikeAgilityEvolved)) ghostSpeMulti += 0.3;
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
        if (player.hasPerk(MutationsLib.DraconicBonesPrimitive)) ghostTouMulti += 0.05;
        if (player.hasPerk(MutationsLib.DraconicBonesEvolved)) ghostTouMulti += 0.1;
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
        var ghostRealStrCompanion:Number = 0;
        if (flags[kFLAGS.PLAYER_COMPANION_1] == "Aurora") ghostRealStrCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAurora);
        if (flags[kFLAGS.PLAYER_COMPANION_2] == "Aurora") ghostRealStrCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAurora);
        if (flags[kFLAGS.PLAYER_COMPANION_3] == "Aurora") ghostRealStrCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAurora);
        return ghostRealStrCompanion;
    }

    private function ghostRealIntelligenceCompanion():Number {
        var ghostRealInteCompanion:Number = 0;
        if (flags[kFLAGS.PLAYER_COMPANION_1] == "Alvina") ghostRealInteCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAlvina);
        if (flags[kFLAGS.PLAYER_COMPANION_2] == "Alvina") ghostRealInteCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAlvina);
        if (flags[kFLAGS.PLAYER_COMPANION_3] == "Alvina") ghostRealInteCompanion += player.statusEffectv2(StatusEffects.CombatFollowerAlvina);
        if (flags[kFLAGS.PLAYER_COMPANION_0] == "Tyrantia") ghostRealInteCompanion += player.statusEffectv3(StatusEffects.CombatFollowerTyrantia);
        if (flags[kFLAGS.PLAYER_COMPANION_1] == "Tyrantia") ghostRealInteCompanion += player.statusEffectv3(StatusEffects.CombatFollowerTyrantia);
        if (flags[kFLAGS.PLAYER_COMPANION_2] == "Tyrantia") ghostRealInteCompanion += player.statusEffectv3(StatusEffects.CombatFollowerTyrantia);
        if (flags[kFLAGS.PLAYER_COMPANION_3] == "Tyrantia") ghostRealInteCompanion += player.statusEffectv3(StatusEffects.CombatFollowerTyrantia);
        return ghostRealInteCompanion;
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
}
}