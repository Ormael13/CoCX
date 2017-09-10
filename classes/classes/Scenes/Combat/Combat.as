package classes.Scenes.Combat {
import classes.BaseContent;
import classes.BodyParts.Skin;
import classes.CoC_Settings;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.ItemType;
import classes.Items.JewelryLib;
import classes.Items.ShieldLib;
import classes.Items.UndergarmentLib;
import classes.Items.WeaponLib;
import classes.Monster;
import classes.PerkLib;
import classes.Player;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.Areas.Beach.Gorgon;
import classes.Scenes.Areas.Desert.Naga;
import classes.Scenes.Areas.Desert.SandTrap;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Areas.Forest.BeeGirl;
import classes.Scenes.Areas.Forest.Kitsune;
import classes.Scenes.Areas.HighMountains.Basilisk;
import classes.Scenes.Areas.HighMountains.Harpy;
import classes.Scenes.Areas.HighMountains.Izumi;
import classes.Scenes.Areas.GlacialRift.FrostGiant;
import classes.Scenes.Areas.Mountain.Minotaur;
import classes.Scenes.Areas.Ocean.SeaAnemone;
import classes.Scenes.Dungeons.D3.*;
import classes.Scenes.Dungeons.HelDungeon.HarpyMob;
import classes.Scenes.Dungeons.HelDungeon.HarpyQueen;
import classes.Scenes.NPCs.*;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.StatusEffectClass;
import classes.StatusEffects;

import coc.view.MainView;
import classes.Saves;
import classes.internals.Utils;

import flash.net.SharedObject;

public class Combat extends BaseContent {
	public var pspecials:PhysicalSpecials  = new PhysicalSpecials();
	public var mspecials:MagicSpecials     = new MagicSpecials();
	public var magic:CombatMagic           = new CombatMagic();
	public var teases:CombatTeases         = new CombatTeases();
	public var soulskills:CombatSoulskills = new CombatSoulskills();

	public function get inCombat():Boolean {
		return getGame().inCombat;
	}
	public function set inCombat(value:Boolean):void {
		getGame().inCombat = value;
	}

	public function physicalCost(mod:Number):Number {
		var costPercent:Number = 100;
		if(player.findPerk(PerkLib.IronMan) >= 0) costPercent -= 50;
		mod *= costPercent/100;
		return mod;
	}
	public function bowCost(mod:Number):Number {
		var costPercent:Number = 100;
		if(player.findPerk(PerkLib.BowShooting) >= 0) costPercent -= player.perkv1(PerkLib.BowShooting);
		//if(player.findPerk(PerkLib.) >= 0) costPercent -= x0; ((tu umieścić perk dający zmniejszenie % kosztu użycia łuku jak IronMan dla fiz specjali ^^))
		mod *= costPercent/100;
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
	public function spellMod():Number {
		return magic.spellModImpl();
	}
	public function spellModWhite():Number {
		return magic.spellModWhiteImpl();
	}
	public function spellModBlack():Number {
		return magic.spellModBlackImpl();
	}
	public function maxFistAttacks():int {
		if (player.hasPerk(PerkLib.ComboMaster)) return 3;
		else if (player.hasPerk(PerkLib.Combo)) return 2;
		else return 1;
	}
	public function maxLargeAttacks():int {
		if (player.hasPerk(PerkLib.TripleAttackLarge)) return 3;
		else if (player.hasPerk(PerkLib.DoubleAttackLarge)) return 2;
		else return 1;
	}
	public function maxCommonAttacks():int {
		if (player.hasPerk(PerkLib.HexaAttack)) return 6;
		else if (player.hasPerk(PerkLib.PentaAttack)) return 5;
		else if (player.hasPerk(PerkLib.QuadrupleAttack)) return 4;
		else if (player.hasPerk(PerkLib.TripleAttack)) return 3;
		else if (player.hasPerk(PerkLib.DoubleAttack)) return 2;
		else return 1;
	}
	public function maxCurrentAttacks():int {
		if (player.weaponPerk == "Dual Large" || player.weaponPerk == "Dual" || player.weaponPerk == "Staff") return 1;
		else if (player.weaponPerk == "Large") return maxLargeAttacks();
		else if (player.isFistOrFistWeapon()) return maxFistAttacks();
		else return maxCommonAttacks();
	}
	public function maxBowAttacks():int {
		if (player.hasPerk(PerkLib.Multishot)) return 6;
		else if (player.hasPerk(PerkLib.WildQuiver)) return 5;
		else if (player.hasPerk(PerkLib.Manyshot)) return 4;
		else if (player.hasPerk(PerkLib.TripleStrike)) return 3;
		else if (player.hasPerk(PerkLib.DoubleStrike)) return 2;
		else return 1;
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
	public function maxCurrentRangeAttacks():int {
		if (player.weaponRangePerk == "Throwing") return maxThrowingAttacks();
		else if (player.weaponRangePerk == "Crossbow") return maxCrossbowAttacks();
		else if (player.weaponRangePerk == "Bow") return maxBowAttacks();
		else return 1;
	}
	
	public function PlayerHPRatio():Number{
		return player.HP/player.maxHP();
	}

	public function endHpVictory():void
{
	monster.defeated_(true);
}

public function endLustVictory():void
{
	monster.defeated_(false);
}

public function endHpLoss():void
{
	monster.won_(true,false);
}

public function endLustLoss():void
{
	if (player.hasStatusEffect(StatusEffects.Infested) && flags[kFLAGS.CAME_WORMS_AFTER_COMBAT] == 0) {
		flags[kFLAGS.CAME_WORMS_AFTER_COMBAT] = 1;
		getGame().mountain.wormsScene.infestOrgasm();
		monster.won_(false,true);
	} else {
		monster.won_(false,false);
	}
}

public function spellPerkUnlock():void {
		if(flags[kFLAGS.SPELLS_CAST] >= 10 && player.findPerk(PerkLib.SpellcastingAffinity) < 0) {
			outputText("<b>You've become more comfortable with your spells, unlocking the Spellcasting Affinity perk and reducing fatigue cost of spells by 10%!</b>\n\n");
			player.createPerk(PerkLib.SpellcastingAffinity,10,0,0,0);
		}
		if(flags[kFLAGS.SPELLS_CAST] >= 30 && player.perkv1(PerkLib.SpellcastingAffinity) < 20) {
			outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
			player.setPerkValue(PerkLib.SpellcastingAffinity,1,20);
		}
		if(flags[kFLAGS.SPELLS_CAST] >= 70 && player.perkv1(PerkLib.SpellcastingAffinity) < 30) {
			outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
			player.setPerkValue(PerkLib.SpellcastingAffinity,1,30);
		}
		if(flags[kFLAGS.SPELLS_CAST] >= 150 && player.perkv1(PerkLib.SpellcastingAffinity) < 40) {
			outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
			player.setPerkValue(PerkLib.SpellcastingAffinity,1,40);
		}
		if(flags[kFLAGS.SPELLS_CAST] >= 310 && player.perkv1(PerkLib.SpellcastingAffinity) < 50) {
			outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
			player.setPerkValue(PerkLib.SpellcastingAffinity,1,50);
		}
	}
//combat is over. Clear shit out and go to main
public function cleanupAfterCombatImpl(nextFunc:Function = null):void {
	magic.cleanupAfterCombatImpl();
	if (nextFunc == null) nextFunc = camp.returnToCampUseOneHour;
	if (prison.inPrison && prison.prisonCombatWinEvent != null) nextFunc = prison.prisonCombatWinEvent;
	if (inCombat) {
		//clear status
		clearStatuses(false);
		//Clear itemswapping in case it hung somehow
//No longer used:		itemSwapping = false;
		//Player won
		if(monster.HP < 1 || monster.lust > monster.eMaxLust()) {
			awardPlayer(nextFunc);
		}
		//Player lost
		else {
			if(monster.statusEffectv1(StatusEffects.Sparring) == 2) {
				clearOutput();
				outputText("The cow-girl has defeated you in a practice fight!");
				outputText("\n\nYou have to lean on Isabella's shoulder while the two of your hike back to camp.  She clearly won.");
				inCombat = false;
				player.HP = 1;
				statScreenRefresh();
				doNext(nextFunc);
				return;
			}
			//Next button is handled within the minerva loss function
			if(monster.hasStatusEffect(StatusEffects.PeachLootLoss)) {
				inCombat = false;
				player.HP = 1;
				statScreenRefresh();
				return;
			}
			if(monster.short == "Ember") {
				inCombat = false;
				player.HP = 1;
				statScreenRefresh();
				doNext(nextFunc);
				return;
			}
			temp = rand(10) + 1 + Math.round(monster.level / 2);
			if (inDungeon) temp += 20 + monster.level * 2;
			//Increases gems lost in NG+.
			temp *= 1 + (player.newGamePlusMod() * 0.5);
			//Round gems.
			temp = Math.round(temp);
			//Keep gems from going below zero.
			if (temp > player.gems) temp = player.gems;
			var timePasses:int = monster.handleCombatLossText(inDungeon, temp); //Allows monsters to customize the loss text and the amount of time lost
			player.gems -= temp;
			inCombat = false;
			if (prison.inPrison == false && flags[kFLAGS.PRISON_CAPTURE_CHANCE] > 0 && rand(100) < flags[kFLAGS.PRISON_CAPTURE_CHANCE] && (prison.trainingFeed.prisonCaptorFeedingQuestTrainingIsTimeUp() || !prison.trainingFeed.prisonCaptorFeedingQuestTrainingExists()) && (monster.short == "goblin" || monster.short == "goblin assassin" || monster.short == "imp" || monster.short == "imp lord" || monster.short == "imp warlord" || monster.short == "hellhound" || monster.short == "minotaur" || monster.short == "satyr" || monster.short == "gnoll" || monster.short == "gnoll spear-thrower" || monster.short == "basilisk")) {
				outputText("  You feel yourself being dragged and carried just before you black out.");
				doNext(prison.prisonIntro);
				return;
			}
			//BUNUS XPZ
			if(flags[kFLAGS.COMBAT_BONUS_XP_VALUE] > 0) {
				player.XP += flags[kFLAGS.COMBAT_BONUS_XP_VALUE];
				outputText("  Somehow you managed to gain " + flags[kFLAGS.COMBAT_BONUS_XP_VALUE] + " XP from the situation.");
				flags[kFLAGS.COMBAT_BONUS_XP_VALUE] = 0;
			}
			//Bonus lewts
			if (flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] != "") {
				outputText("  Somehow you came away from the encounter with " + ItemType.lookupItem(flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID]).longName + ".\n\n");
				inventory.takeItem(ItemType.lookupItem(flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID]), createCallBackFunction(camp.returnToCamp, timePasses));
			}
			else doNext(createCallBackFunction(camp.returnToCamp, timePasses));
		}
	}
	//Not actually in combat
	else doNext(nextFunc);
}

public function checkAchievementDamage(damage:Number):void
{
	flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] += damage;
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 50000) kGAMECLASS.awardAchievement("Bloodletter", kACHIEVEMENTS.COMBAT_BLOOD_LETTER);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 200000) kGAMECLASS.awardAchievement("Reiterpallasch", kACHIEVEMENTS.COMBAT_REITERPALLASCH);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 1000000) kGAMECLASS.awardAchievement("Uncanny Bloodletter", kACHIEVEMENTS.COMBAT_UNCANNY_BLOOD_LETTER);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 5000000) kGAMECLASS.awardAchievement("Uncanny Reiterpallasch", kACHIEVEMENTS.COMBAT_UNCANNY_REITERPALLASCH);
	if (damage >= 50) kGAMECLASS.awardAchievement("Pain", kACHIEVEMENTS.COMBAT_PAIN);
	if (damage >= 100) kGAMECLASS.awardAchievement("Fractured Limbs", kACHIEVEMENTS.COMBAT_FRACTURED_LIMBS);
	if (damage >= 250) kGAMECLASS.awardAchievement("Broken Bones", kACHIEVEMENTS.COMBAT_BROKEN_BONES);
	if (damage >= 500) kGAMECLASS.awardAchievement("Overkill", kACHIEVEMENTS.COMBAT_OVERKILL);
	if (damage >= 1000) kGAMECLASS.awardAchievement("Meat Pasty", kACHIEVEMENTS.COMBAT_MEAT_PASTY);
	if (damage >= 2500) kGAMECLASS.awardAchievement("Pulverize", kACHIEVEMENTS.COMBAT_PULVERIZE);
	if (damage >= 5000) kGAMECLASS.awardAchievement("Erase", kACHIEVEMENTS.COMBAT_ERASE);
}
/*public function checkMinionsAchievementDamage(damage:Number):void
{
	flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] += damage;
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 50000) kGAMECLASS.awardAchievement("Bloodletter", kACHIEVEMENTS.COMBAT_BLOOD_LETTER);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 200000) kGAMECLASS.awardAchievement("Reiterpallasch", kACHIEVEMENTS.COMBAT_REITERPALLASCH);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 1000000) kGAMECLASS.awardAchievement("Uncanny Bloodletter", kACHIEVEMENTS.COMBAT_UNCANNY_BLOOD_LETTER);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 5000000) kGAMECLASS.awardAchievement("Uncanny Reiterpallasch", kACHIEVEMENTS.COMBAT_UNCANNY_REITERPALLASCH);
	if (damage >= 50) kGAMECLASS.awardAchievement("Pain", kACHIEVEMENTS.COMBAT_PAIN);
	if (damage >= 100) kGAMECLASS.awardAchievement("Fractured Limbs", kACHIEVEMENTS.COMBAT_FRACTURED_LIMBS);
	if (damage >= 250) kGAMECLASS.awardAchievement("Broken Bones", kACHIEVEMENTS.COMBAT_BROKEN_BONES);
	if (damage >= 500) kGAMECLASS.awardAchievement("Overkill", kACHIEVEMENTS.COMBAT_OVERKILL);
	if (damage >= 1000) kGAMECLASS.awardAchievement("Meat Pasty", kACHIEVEMENTS.COMBAT_MEAT_PASTY);
	if (damage >= 2500) kGAMECLASS.awardAchievement("Pulverize", kACHIEVEMENTS.COMBAT_PULVERIZE);
	if (damage >= 5000) kGAMECLASS.awardAchievement("Erase", kACHIEVEMENTS.COMBAT_ERASE);
}*/
public function approachAfterKnockback1():void
{
	clearOutput();
	outputText("You close the distance between you and " + monster.a + monster.short + " as quickly as possible.\n\n");
	player.removeStatusEffect(StatusEffects.KnockedBack);
	if (player.weaponRangeName == "flintlock pistol") flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 4;
	if (player.weaponRangeName == "blunderbuss rifle") flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 2;
	outputText("At the same time, you open the magazine of your ");
	if (player.weaponRangePerk == "Pistol") outputText("pistol");
	if (player.weaponRangePerk == "Rifle") outputText("rifle");
	outputText(" to reload the ammunition.");
	if (player.findPerk(PerkLib.RapidReload) < 0) {
		outputText("  This takes up a turn.\n\n");
		enemyAI();
		return;
	}
	else {
		outputText("\n\n");
		doNext(combatMenu);
	}
}
public function approachAfterKnockback2():void
{
	clearOutput();
	outputText("You close the distance between you and " + monster.a + monster.short + " as quickly as possible.\n\n");
	player.removeStatusEffect(StatusEffects.KnockedBack);
	outputText("At the same time, you fire a round at " + monster.short + ". ");
	fireBow();
	return;
}
public function approachAfterKnockback3():void
{
	clearOutput();
	outputText("You close the distance between you and " + monster.a + monster.short + " as quickly as possible.\n\n");
	player.removeStatusEffect(StatusEffects.KnockedBack);
	enemyAI();
	return;
}

private function isPlayerSilenced():Boolean
{
	var temp:Boolean = false;
	if (player.hasStatusEffect(StatusEffects.ThroatPunch)) temp = true;
	if (player.hasStatusEffect(StatusEffects.WebSilence)) temp = true;
	if (player.hasStatusEffect(StatusEffects.GooArmorSilence)) temp = true;
	return temp;
}

private function isPlayerBound():Boolean 
{
	var temp:Boolean = false;
	if (player.hasStatusEffect(StatusEffects.HarpyBind) || player.hasStatusEffect(StatusEffects.GooBind) || player.hasStatusEffect(StatusEffects.TentacleBind) || player.hasStatusEffect(StatusEffects.NagaBind) || player.hasStatusEffect(StatusEffects.ScyllaBind)
	 || player.hasStatusEffect(StatusEffects.WolfHold) || monster.hasStatusEffect(StatusEffects.QueenBind) || monster.hasStatusEffect(StatusEffects.PCTailTangle)) temp = true;
	if (player.hasStatusEffect(StatusEffects.HolliConstrict)) temp = true;
	if (player.hasStatusEffect(StatusEffects.GooArmorBind)) temp = true;
	if (monster.hasStatusEffect(StatusEffects.MinotaurEntangled)) {
		outputText("\n<b>You're bound up in the minotaur lord's chains!  All you can do is try to struggle free!</b>");
		temp = true;
	}
	if (player.hasStatusEffect(StatusEffects.UBERWEB)) temp = true;
	if (player.hasStatusEffect(StatusEffects.Bound)) temp = true;
	if (player.hasStatusEffect(StatusEffects.Chokeslam)) temp = true;
	if (player.hasStatusEffect(StatusEffects.Titsmother)) temp = true;
	if (player.hasStatusEffect(StatusEffects.GiantGrabbed)) {
		outputText("\n<b>You're trapped in the giant's hand!  All you can do is try to struggle free!</b>");
		temp = true;
	}
	if (player.hasStatusEffect(StatusEffects.Tentagrappled)) {
		outputText("\n<b>The demonesses tentacles are constricting your limbs!</b>");
		temp = true;
	}
	return temp;
}

private function isPlayerStunned():Boolean 
{
	var temp:Boolean = false;
	if (player.hasStatusEffect(StatusEffects.IsabellaStunned) || player.hasStatusEffect(StatusEffects.Stunned)) {
		outputText("\n<b>You're too stunned to attack!</b>  All you can do is wait and try to recover!");
		temp = true;
	}
	if (player.hasStatusEffect(StatusEffects.Whispered)) {
		outputText("\n<b>Your mind is too addled to focus on combat!</b>  All you can do is try and recover!");
		temp = true;
	}
	if (player.hasStatusEffect(StatusEffects.Confusion)) {
		outputText("\n<b>You're too confused</b> about who you are to try to attack!");
		temp = true;
	}
	return temp;
}

private function canUseMagic():Boolean {
	if (player.hasStatusEffect(StatusEffects.ThroatPunch)) return false;
	if (player.hasStatusEffect(StatusEffects.WebSilence)) return false;
	if (player.hasStatusEffect(StatusEffects.GooArmorSilence)) return false;
	if (player.hasStatusEffect(StatusEffects.WhipSilence)) return false;
	return true;
}

public function combatMenu(newRound:Boolean = true):void { //If returning from a sub menu set newRound to false
	clearOutput();
	flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] = 0;
	mainView.hideMenuButton(MainView.MENU_DATA);
	mainView.hideMenuButton(MainView.MENU_APPEARANCE);
	mainView.hideMenuButton(MainView.MENU_PERKS);
	hideUpDown();
	if (newRound) combatStatusesUpdate(); //Update Combat Statuses
	display();
	statScreenRefresh();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
	if (combatRoundOver()) return;
	menu();
	var attacks:Function = normalAttack;
	if (!kGAMECLASS.urtaQuest.isUrta() && !player.hasStatusEffect(StatusEffects.ChanneledAttack)) {
		//Standard menu before modifications.
		if (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 2) addButton(0, "E.Attack", baseelementalattacks).hint( "Command your elemental to attack the enemy.  Damage it will deal is affcted by your wisdom and intelligence.");
		else if (!player.hasStatusEffect(StatusEffects.Flying) && !monster.hasStatusEffect(StatusEffects.Flying))
			addButton(0, "Attack", basemeleeattacks).hint( "Attempt to attack the enemy with your " + player.weaponName + ".  Damage done is determined by your strength and weapon.");
		else if (!player.hasStatusEffect(StatusEffects.Flying) && monster.hasStatusEffect(StatusEffects.Flying))
			addButtonDisabled(0, "Attack", "No way you could reach enemy in air with melee attacks.");
		else if (player.hasStatusEffect(StatusEffects.Flying))
		{
			if (player.weapon != weapons.SPEAR || player.weapon != weapons.LANCE) addButtonDisabled(0, "Attack", "No way you could reach enemy with melee attacks while flying.");
			else addButton(0, "Attack", basemeleeattacks).hint( "Attempt to attack the enemy with your " + player.weaponName + ".  Damage done is determined by your strength and weapon.");
		}
		//Bow attack
		if (player.weaponRangePerk == "Bow")
			addButton(1, "Bow", fireBow).hint( "Attempt to attack the enemy with your " + player.weaponRangeName + ".  Damage done is determined by your speed and weapon.");
		//Crossbow attack
		if (player.weaponRangePerk == "Crossbow")
			addButton(1, "Crossbow", fireBow).hint( "Attempt to attack the enemy with your " + player.weaponRangeName + ".  Damage done is determined only by your weapon.");
		if (player.weaponRangePerk == "Throwing") {
			if (flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] <= 0 && player.weaponRange != weaponsrange.SHUNHAR) addButtonDisabled(1, "Throw", "You have used all your throwing weapons in this fight.");
			else addButton(1, "Throw", fireBow).hint( "Attempt to throw " + player.weaponRangeName + " at enemy.  Damage done is determined by your strength and weapon.");
		}
		if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") {
			if (flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] <= 0)
				addButton(1, "Reload", reloadWeapon).hint( "Your " + player.weaponRangeName + " is out of ammo.  You'll have to reload it before attack.");
			else
				addButton(1, "Shoot", fireBow).hint( "Fire a round at your opponent with your " + player.weaponRangeName + "!  Damage done is determined only by your weapon.");
		}
		addButton(2, "Items", inventory.inventoryMenu).hint("The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
		if (canUseMagic()) addButton(3, "Spells", magic.magicMenu).hint("Opens your spells menu, where you can cast any spells you have learned.  Beware, casting spells increases your fatigue, and if you become exhausted you will be easier to defeat.");
		addButton(4, "Tease", teaseAttack).hint("Attempt to make an enemy more aroused by striking a seductive pose and exposing parts of your body.");
		if(!player.hasStatusEffect(StatusEffects.Flying) && !monster.hasStatusEffect(StatusEffects.Flying)) addButton(5, "P. Specials", pspecials.psMenu).hint("Physical special attack menu.", "Physical Specials");
		else if (!player.hasStatusEffect(StatusEffects.Flying) && monster.hasStatusEffect(StatusEffects.Flying)) {
			if (player.canFly()) addButton(5, "Take Flight", takeFlight).hint("Make use of your wings to take flight into the air for up to 7 turns. \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.");
			else addButtonDisabled(5, "P. Specials", "No way you could reach enemy in air with p. specials.");
		}
		else if(player.hasStatusEffect(StatusEffects.Flying)) addButton(5, "Great Dive", greatDive).hint("Make a Great Dive to deal TONS of damage!");
		addButton(6, "M. Specials", mspecials.msMenu).hint("Mental and supernatural special attack menu.", "Magical Specials");
		addButton(7, "Soulforce", soulskills.soulforceSpecials).hint("Soulforce attacks menu.", "Soulforce Specials");
		addButton(8, "Wait", wait).hint("Take no action for this round.  Why would you do this?  This is a terrible idea.");
		if (monster.hasStatusEffect(StatusEffects.Level)) {
			if (monster is SandTrap) addButton(8, "Climb", wait).hint("Climb the sand to move away from the sand trap.");
			if (monster is Alraune) {
				if (player.fatigue + 50 <= player.maxFatigue()) addButton(8, "Struggle", wait).hint("Struggle to forcefully pull yourself a good distance away from plant woman.");
				else addButtonDisabled(8, "Struggle", "You're too tired to struggle.");
			}
		}
		addButton(9, "Fantasize", fantasize).hint("Fantasize about your opponent in a sexual way.  Its probably a pretty bad idea to do this unless you want to end up getting raped.");
		if (player.findPerk(PerkLib.JobDefender) >= 0) addButton(10, "Defend", defendpose).hint("Take no offensive action for this round.  Why would you do this?  Maybe because you will assume defensive pose?");
		if (monster is DriderIncubus)
			{
				m = monster as DriderIncubus;
				if (!m.goblinFree) addButton(11, "Free Goblin", m.freeGoblin);
			}
		else if (monster is Lethice)
		{
			var ml:Lethice = monster as Lethice;
			whitefireLustCap = player.maxLust() * 0.75;
			if (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < (10 + player.corruptionTolerance())) whitefireLustCap += (player.maxLust() * 0.1);
			if (player.findPerk(PerkLib.FocusedMind) >= 0 && player.findPerk(PerkLib.GreyMage) < 0) whitefireLustCap += (player.maxLust() * 0.1);
			if (player.findPerk(PerkLib.GreyMage) >= 0) whitefireLustCap = (player.maxLust() - 45);
			if (player.findPerk(PerkLib.GreyMage) >= 0 && player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < (10 + player.corruptionTolerance())) whitefireLustCap = (player.maxLust() - 15);
			gotEnergy = player.findPerk(PerkLib.BloodMage) < 0 && player.mana >= 30;
			if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles))
			{
				if (player.lust < whitefireLustCap && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && gotEnergy)
				{
					addButton(11, "Dispell", ml.dispellRapetacles);
				}
			}
		}
		else addButton(11, "Surrender", surrender).hint("Fantasize about your opponent in a sexual way so much it would fill up your lust you'll end up getting raped.");
		if (player.findPerk(PerkLib.DoubleAttack) >= 0 || player.findPerk(PerkLib.DoubleAttackLarge) >= 0 || player.findPerk(PerkLib.Combo) >= 0 || player.findPerk(PerkLib.DoubleStrike) >= 0 || player.findPerk(PerkLib.ElementalArrows) >= 0 || player.findPerk(PerkLib.Cupid) >= 0 || player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) addButton(12,"Combat Options",combatOptionsSubMenu);
		if (CoC_Settings.debugBuild && !debug) addButton(13, "Inspect", debugInspect).hint("Use your debug powers to inspect your enemy.");
		addButton(14, "Run", runAway).hint("Choosing to run will let you try to escape from your enemy. However, it will be hard to escape enemies that are faster than you and if you fail, your enemy will get a free attack.");
	}
	//Modify menus.
	if (kGAMECLASS.urtaQuest.isUrta()) {
		addButton(0, "Attack", basemeleeattacks).hint("Attempt to attack the enemy with your " + player.weaponName + ".  Damage done is determined by your strength and weapon.");
		addButton(1, "P. Specials", pspecials.psMenu).hint("Physical special attack menu.", "Physical Specials");
		addButton(2, "M. Specials", mspecials.msMenu).hint("Mental and supernatural special attack menu.", "Magical Specials");
		addButton(3, "Tease", teaseAttack);
		addButton(5, "Fantasize", fantasize).hint("Fantasize about your opponent in a sexual way.  Its probably a pretty bad idea to do this unless you want to end up getting raped.");
		addButton(6, "Wait", wait).hint("Take no action for this round.  Why would you do this?  This is a terrible idea.");
	}
	if (player.statusEffectv1(StatusEffects.ChanneledAttack) >= 1 && (isPlayerBound() || isPlayerSilenced() || isPlayerStunned())) {
		addButton(1, "Stop", stopChanneledSpecial);
	}
	if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
		if (player.statusEffectv1(StatusEffects.ChanneledAttackType) == 1) {
			addButton(0, "Continue", mspecials.singCompellingAria).hint("Continue singing.");
			addButton(1, "Stop", stopChanneledSpecial).hint("Stop singing.");
		}
		if (player.statusEffectv1(StatusEffects.ChanneledAttackType) == 2) addButton(0, "Continue", mspecials.startOniRampage).hint("Continue starting rampage.");
	}
	if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 2) {
		if (player.statusEffectv1(StatusEffects.ChanneledAttackType) == 1) {
			addButton(0, "Continue", mspecials.singCompellingAria).hint("Continue singing.");
			addButton(1, "Stop", stopChanneledSpecial).hint("Stop singing.");
		}
	}
	if (monster.hasStatusEffect(StatusEffects.AttackDisabled))
	{
		if (monster is Lethice)
		{
			outputText("\n<b>With Lethice up in the air, you've got no way to reach her with your attacks!</b>");
		}
		else
		{
			outputText("\n<b>Chained up as you are, you can't manage any real physical attacks!</b>");
		}
		attacks = null;
	}
	if (player.hasStatusEffect(StatusEffects.TaintedMind)) {
		addButton(0, "Attack", (monster as DriderIncubus).taintedMindAttackAttempt);
		addButton(2, "Items", inventory.inventoryMenu);
		if (canUseMagic()) addButton(3, "Spells", magic.magicMenu);
		addButton(4, "Tease", teaseAttack);
		addButton(5, "P. Specials", (monster as DriderIncubus).taintedMindAttackAttempt);
		addButton(6, "M. Specials", mspecials.msMenu);
		addButton(8, (monster.hasStatusEffect(StatusEffects.Level) ? "Climb" : "Wait"), wait);
		addButton(9, "Fantasize", fantasize);
		var m:DriderIncubus = monster as DriderIncubus;
		if (!m.goblinFree) addButton(11, "Free Goblin", m.freeGoblin);
		addButton(14, "Run", runAway);
	}
	//Knocked back
	if (player.hasStatusEffect(StatusEffects.KnockedBack))
	{
		outputText("\n<b>You'll need to close some distance before you can use any physical attacks!</b>");
		if (flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] <= 0 && (player.weaponRangeName == "flintlock pistol" || player.weaponRangeName == "blunderbuss rifle")) addButton(0, "Reload&Approach", approachAfterKnockback1).hint("Reload your range weapon while approaching.", "Reload and Approach");
		else if (flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] > 0 && (player.weaponRangeName == "flintlock pistol" || player.weaponRangeName == "blunderbuss rifle")) addButton(0, "Shoot&Approach", approachAfterKnockback2).hint("Fire a round at your opponent and approach.", "Fire and Approach");
		else addButton(0, "Approach", approachAfterKnockback3).hint("Close some distance between you and your opponent.");
		if (player.weaponRangePerk == "Bow") addButton(1, "Bow", fireBow);
		if (player.weaponRangePerk == "Crossbow") addButton(1, "Crossbow", fireBow);
		if (player.weaponRangePerk == "Throwing") addButton(1, "Throw", fireBow);
		if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") addButton(1, "Shoot", fireBow);
	}
	//Disabled physical attacks
	if (monster.hasStatusEffect(StatusEffects.PhysicalDisabled)) {
		outputText("<b>  Even physical special attacks are out of the question.</b>");
		removeButton(1); //Removes bow usage.
		removeButton(5); //Removes physical special attack.
	}
	//Bound: Struggle or wait
	if (isPlayerBound()) {
		menu();
		addButton(0, "Struggle", struggle);
		addButton(1, "Wait", wait);
		if (player.hasStatusEffect(StatusEffects.UBERWEB)) {
			addButton(6, "M. Special", mspecials.msMenu);
		}
		if (player.hasStatusEffect(StatusEffects.Bound)) {
			addButton(0, "Struggle", (monster as Ceraph).ceraphBindingStruggle);
			addButton(1, "Wait", (monster as Ceraph).ceraphBoundWait);
		}
		if (player.hasStatusEffect(StatusEffects.Chokeslam)) {
			addButton(0, "Struggle", (monster as Izumi).chokeSlamStruggle);
			addButton(1, "Wait", (monster as Izumi).chokeSlamWait);
		}
		if (player.hasStatusEffect(StatusEffects.Titsmother)) {
			addButton(0, "Struggle", (monster as Izumi).titSmotherStruggle);
			addButton(1, "Wait", (monster as Izumi).titSmotherWait);
		}
		if (player.hasStatusEffect(StatusEffects.Tentagrappled)) {
			addButton(0, "Struggle", (monster as SuccubusGardener).grappleStruggle);
			addButton(1, "Wait", (monster as SuccubusGardener).grappleWait);
		}
		else if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles) && player.statusEffectv3(StatusEffects.LethicesRapeTentacles) == 1) {
			outputText("\n<b>Lethice's tentacles have a firm grip of your limbs!</b>");
			addButton(0, "Struggle", (monster as Lethice).grappleStruggle);
			addButton(5, "Wait", (monster as Lethice).grappleWait);
		
			var whitefireLustCap:int = player.maxLust() * 0.75;
			if (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < (10 + player.corruptionTolerance())) whitefireLustCap += (player.maxLust() * 0.1);
			if (player.findPerk(PerkLib.FocusedMind) >= 0 && player.findPerk(PerkLib.GreyMage) < 0) whitefireLustCap += (player.maxLust() * 0.1);
			if (player.findPerk(PerkLib.GreyMage) >= 0) whitefireLustCap = (player.maxLust() - 45);
			if (player.findPerk(PerkLib.GreyMage) >= 0 && player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < (10 + player.corruptionTolerance())) whitefireLustCap = (player.maxLust() - 15);
			var gotEnergy:Boolean = player.findPerk(PerkLib.BloodMage) < 0 && player.mana >= 30;
			if (player.lust < whitefireLustCap && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && gotEnergy)
			{
				addButton(1, "Dispell", (monster as Lethice).dispellRapetacles);
			}
		}
	}
	//Silence: Disables magic menu.
	if (isPlayerSilenced()) {
		removeButton(2);
	}
	//Stunned: Recover, lose 1 turn.
	if (isPlayerStunned()) {
		menu();
		addButton(0, "Recover", wait);
	}
	else if (monster.hasStatusEffect(StatusEffects.Constricted)) {
		menu();
		addButton(0, "Squeeze", kGAMECLASS.desert.nagaScene.naggaSqueeze).hint("Squeeze some HP out of your opponent! \n\nFatigue Cost: " + physicalCost(20) + "");
		addButton(1, "Tease", kGAMECLASS.desert.nagaScene.naggaTease);
		addButton(4, "Release", kGAMECLASS.desert.nagaScene.nagaLeggoMyEggo);
	}
	else if (monster.hasStatusEffect(StatusEffects.ConstrictedScylla)) {
		menu();
		if (monster.plural) {
			addButton(0, "Squeeze", ScyllaSqueeze).hint("Squeeze your foes with your tentacles attempting to break them appart! \n\nFatigue Cost: " + physicalCost(50) + "");
		}
		else addButton(0, "Squeeze", ScyllaSqueeze).hint("Squeeze your foe with your tentacle attempting to break it appart! \n\nFatigue Cost: " + physicalCost(20) + "");
		addButton(1, "Tease", ScyllaTease).hint("Use a free limb to caress and pleasure your grappled foe. \n\nFatigue Cost: " + physicalCost(20) + "");
		addButton(4, "Release", ScyllaLeggoMyEggo);
	}
	else if (monster.hasStatusEffect(StatusEffects.GooEngulf)) {
		menu();
		addButton(0, "Tease", GooTease).hint("Mold limb to caress and pleasure your grappled foe. \n\nFatigue Cost: " + physicalCost(20) + "");
		addButton(4, "Release", GooLeggoMyEggo);
	}
}

private function teaseAttack():void {
	teases.teaseAttack();
}

public function stopChanneledSpecial():void {
	clearOutput();
	outputText("You decided to stop preparing your super ultra hyper mega fabious attack!\n\n");
	player.removeStatusEffect(StatusEffects.ChanneledAttack);
	player.removeStatusEffect(StatusEffects.ChanneledAttackType);
	combatRoundOver();
}

public function unarmedAttack():Number {
	var unarmed:Number = 0;
	if (player.findPerk(PerkLib.JobMonk) >= 0 && player.wis >= 60) unarmed += 10 * (1 + player.newGamePlusMod());
	if (player.findPerk(PerkLib.PrestigeJobSoulArtMaster) >= 0 && player.wis >= 200) unarmed += 10 * (1 + player.newGamePlusMod());
	if (player.findPerk(PerkLib.BodyCultivator) >= 0) unarmed += 2 * (1 + player.newGamePlusMod());
	if (player.findPerk(PerkLib.FleshBodyApprenticeStage) >= 0) {
		if (player.findPerk(PerkLib.SoulApprentice) >= 0) unarmed += 4 * (1 + player.newGamePlusMod());
		if (player.findPerk(PerkLib.SoulPersonage) >= 0) unarmed += 4 * (1 + player.newGamePlusMod());
		if (player.findPerk(PerkLib.SoulWarrior) >= 0) unarmed += 4 * (1 + player.newGamePlusMod());
	}
	if (player.findPerk(PerkLib.FleshBodyWarriorStage) >= 0) {
		if (player.findPerk(PerkLib.SoulSprite) >= 0) unarmed += 6 * (1 + player.newGamePlusMod());
		if (player.findPerk(PerkLib.SoulScholar) >= 0) unarmed += 6 * (1 + player.newGamePlusMod());
		if (player.findPerk(PerkLib.SoulElder) >= 0) unarmed += 6 * (1 + player.newGamePlusMod());
	}
	if (player.findPerk(PerkLib.FleshBodyElderStage) >= 0) {
		if (player.findPerk(PerkLib.SoulExalt) >= 0) unarmed += 8 * (1 + player.newGamePlusMod());
		if (player.findPerk(PerkLib.SoulOverlord) >= 0) unarmed += 8 * (1 + player.newGamePlusMod());
		if (player.findPerk(PerkLib.SoulTyrant) >= 0) unarmed += 8 * (1 + player.newGamePlusMod());
	}
	if (player.findPerk(PerkLib.FleshBodyOverlordStage) >= 0) {
		if (player.findPerk(PerkLib.SoulKing) >= 0) unarmed += 10 * (1 + player.newGamePlusMod());
		if (player.findPerk(PerkLib.SoulEmperor) >= 0) unarmed += 10 * (1 + player.newGamePlusMod());
		if (player.findPerk(PerkLib.SoulAncestor) >= 0) unarmed += 10 * (1 + player.newGamePlusMod());
	}
	if (player.findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) unarmed += 12 * (1 + player.newGamePlusMod());
	if (player.findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) unarmed += 18 * (1 + player.newGamePlusMod());
//	if (findPerk(OneOfBeastWarriorPerks) >= 0) unarmed *= 1.05;
//	if (player.jewelryName == "fox hairpin") unarmed += .2;
	unarmed = Math.round(unarmed);
	return unarmed;
}

private function normalAttack():void {
	clearOutput();
	attack();
}
public function basemeleeattacks():void {
	clearOutput();
	if (kGAMECLASS.urtaQuest.isUrta()) {
		flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
	}
	if (player.weaponPerk != "Large" && player.weaponPerk != "Dual Large" && player.weaponPerk != "Staff" && !isWieldingRangedWeapon()) {
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] >= 0) {
			if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 5) {
				if (player.hasStatusEffect(StatusEffects.BladeDance) || player.weaponPerk == "Dual") flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 12;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 6;
			}
			else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 4) {
				if (player.hasStatusEffect(StatusEffects.BladeDance) || player.weaponPerk == "Dual") flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 10;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 5;
			}
			else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 3) {
				if (player.hasStatusEffect(StatusEffects.BladeDance) || player.weaponPerk == "Dual") flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 8;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 4;
			}
			else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 2) {
				if (player.findPerk(PerkLib.TripleAttack) >= 0) {
					if (player.hasStatusEffect(StatusEffects.BladeDance) || player.weaponPerk == "Dual") flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 6;
					else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
				}
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			}
			else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) {
				if (player.findPerk(PerkLib.DoubleAttack) >= 0) {
					if (player.hasStatusEffect(StatusEffects.BladeDance) || player.weaponPerk == "Dual") flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 4;
					else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 2;
				}
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			}
			else {
				if (player.hasStatusEffect(StatusEffects.BladeDance) || player.weaponPerk == "Dual") flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 2;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			}
			var mutlimeleeattacksCost:Number = 0;
			//multiple melee attacks costs
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 12) mutlimeleeattacksCost += 77;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 11) mutlimeleeattacksCost += 65;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 10) mutlimeleeattacksCost += 54;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 9) mutlimeleeattacksCost += 44;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 8) mutlimeleeattacksCost += 35;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 7) mutlimeleeattacksCost += 27;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 6) mutlimeleeattacksCost += 20;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 5) mutlimeleeattacksCost += 14;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 4) mutlimeleeattacksCost += 9;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 3) mutlimeleeattacksCost += 5;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 2) mutlimeleeattacksCost += 2;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 1) {
				if (player.wrath < mutlimeleeattacksCost) {
					if (player.weaponPerk == "Dual") {
						outputText("You're too <b>'calm'</b> to attack more than twice in this turn!\n\n");
						flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 2;
						player.HP -= 20;
					}
					else {
						outputText("You're too <b>'calm'</b> to attack more than once in this turn!\n\n");
						flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
					}
				}
				else {
					player.wrath -= mutlimeleeattacksCost;
				}
				
			}
		}
		else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
	}
	if (player.weaponPerk == "Large" || player.weaponPerk == "Dual Large") {
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] >= 0) {
			if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 5) {
				if (player.weaponPerk == "Dual Large") flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 6;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
			}
			else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 4) {
				if (player.weaponPerk == "Dual Large") flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 6;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
			}
			else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 3) {
				if (player.weaponPerk == "Dual Large") flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 6;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
			}
			else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 2) {
				if (player.findPerk(PerkLib.TripleAttackLarge) >= 0) {
					if (player.weaponPerk == "Dual Large") flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 6;
					else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
				}
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			}
			else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) {
				if (player.findPerk(PerkLib.DoubleAttackLarge) >= 0) {
					if (player.weaponPerk == "Dual Large") flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 4;
					else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 2;
				}
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			}
			else {
				if (player.weaponPerk == "Dual Large") flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 2;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			}
			var mutlimeleelargeattacksCost:Number = 0;
			//multiple melee large attacks costs
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 6) mutlimeleelargeattacksCost += 40;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 5) mutlimeleelargeattacksCost += 28;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 4) mutlimeleelargeattacksCost += 18;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 3) mutlimeleelargeattacksCost += 10;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 2) mutlimeleelargeattacksCost += 4;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 1) {
				if (player.wrath < mutlimeleelargeattacksCost) {
					if (player.weaponPerk == "Dual Large") {
						outputText("You're too <b>'calm'</b> to attack more than twice in this turn!\n\n");
						flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 2;
						player.HP -= 40;
					}
					else {
						outputText("You're too <b>'calm'</b> to attack more than once in this turn!\n\n");
						flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
					}
				}
				else {
					player.wrath -= mutlimeleelargeattacksCost;
				}
			}
		}
		else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
	}
	if (player.weaponPerk == "Dual Large" || player.weaponPerk == "Dual" || player.weaponPerk == "Staff") {
	//	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] >= 0) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
		flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
	}
	if (player.isFistOrFistWeapon()) {
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] >= 0) {
			if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 5) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
			else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 4) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
			else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 3) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
			else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 2) {
				if (player.findPerk(PerkLib.ComboMaster) >= 0) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 3;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			}
			else if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) {
				if (player.findPerk(PerkLib.Combo) >= 0) flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 2;
				else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			}
			else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
			var mutlimeleefistattacksCost:Number = 0;
			//multiple melee large attacks costs
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 3) mutlimeleefistattacksCost += 10;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 2) mutlimeleefistattacksCost += 4;
			if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] > 1) {
				if (player.fatigue + mutlimeleefistattacksCost <= player.maxFatigue()) {
					if (player.soulforce < mutlimeleefistattacksCost * 5) {
						outputText("Your current soulforce is too low to attack more than once in this turn!\n\n");
						flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
					}
					else {
						fatigue(mutlimeleefistattacksCost);
						player.soulforce -= mutlimeleefistattacksCost * 5;
					}
				}
				else {
					outputText("You're too fatigued to attack more than once in this turn!\n\n");
					flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
				}
			}
		}
		else flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] = 1;
	}
	attack();
}

public function baseelementalattacks():void {
	clearOutput();
	var manacostofelementalattacking:Number = 1;
	manacostofelementalattacking += player.inte / 25;
	manacostofelementalattacking += player.wis / 25;
	manacostofelementalattacking = Math.round(manacostofelementalattacking);
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 1) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 1 && manacostofelementalattacking > 0) manacostofelementalattacking = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 2 && manacostofelementalattacking > 5) manacostofelementalattacking = 5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 3 && manacostofelementalattacking > 10) manacostofelementalattacking = 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 4 && manacostofelementalattacking > 20) manacostofelementalattacking = 20;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 5 && manacostofelementalattacking > 40) manacostofelementalattacking = 40;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 6 && manacostofelementalattacking > 80) manacostofelementalattacking = 80;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 7 && manacostofelementalattacking > 120) manacostofelementalattacking = 120;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 8 && manacostofelementalattacking > 160) manacostofelementalattacking = 160;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 4 && player.findPerk(PerkLib.StrongElementalBond) >= 0) manacostofelementalattacking -= 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 6 && player.findPerk(PerkLib.StrongerElementalBond) >= 0) manacostofelementalattacking -= 30;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 8 && player.findPerk(PerkLib.StrongestElementalBond) >= 0) manacostofelementalattacking -= 90;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 2) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 1 && manacostofelementalattacking > 0) manacostofelementalattacking = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 2 && manacostofelementalattacking > 5) manacostofelementalattacking = 5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 3 && manacostofelementalattacking > 10) manacostofelementalattacking = 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 4 && manacostofelementalattacking > 20) manacostofelementalattacking = 20;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 5 && manacostofelementalattacking > 40) manacostofelementalattacking = 40;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 6 && manacostofelementalattacking > 80) manacostofelementalattacking = 80;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 7 && manacostofelementalattacking > 120) manacostofelementalattacking = 120;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 8 && manacostofelementalattacking > 160) manacostofelementalattacking = 160;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 4 && player.findPerk(PerkLib.StrongElementalBond) >= 0) manacostofelementalattacking -= 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 6 && player.findPerk(PerkLib.StrongerElementalBond) >= 0) manacostofelementalattacking -= 30;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 8 && player.findPerk(PerkLib.StrongestElementalBond) >= 0) manacostofelementalattacking -= 90;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 3) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 1 && manacostofelementalattacking > 0) manacostofelementalattacking = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 2 && manacostofelementalattacking > 5) manacostofelementalattacking = 5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 3 && manacostofelementalattacking > 10) manacostofelementalattacking = 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 4 && manacostofelementalattacking > 20) manacostofelementalattacking = 20;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 5 && manacostofelementalattacking > 40) manacostofelementalattacking = 40;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 6 && manacostofelementalattacking > 80) manacostofelementalattacking = 80;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 7 && manacostofelementalattacking > 120) manacostofelementalattacking = 120;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 8 && manacostofelementalattacking > 160) manacostofelementalattacking = 160;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 4 && player.findPerk(PerkLib.StrongElementalBond) >= 0) manacostofelementalattacking -= 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 6 && player.findPerk(PerkLib.StrongerElementalBond) >= 0) manacostofelementalattacking -= 30;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 8 && player.findPerk(PerkLib.StrongestElementalBond) >= 0) manacostofelementalattacking -= 90;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 4) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 1 && manacostofelementalattacking > 0) manacostofelementalattacking = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 2 && manacostofelementalattacking > 5) manacostofelementalattacking = 5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 3 && manacostofelementalattacking > 10) manacostofelementalattacking = 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 4 && manacostofelementalattacking > 20) manacostofelementalattacking = 20;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 5 && manacostofelementalattacking > 40) manacostofelementalattacking = 40;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 6 && manacostofelementalattacking > 80) manacostofelementalattacking = 80;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 7 && manacostofelementalattacking > 120) manacostofelementalattacking = 120;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 8 && manacostofelementalattacking > 160) manacostofelementalattacking = 160;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 4 && player.findPerk(PerkLib.StrongElementalBond) >= 0) manacostofelementalattacking -= 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 6 && player.findPerk(PerkLib.StrongerElementalBond) >= 0) manacostofelementalattacking -= 30;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 8 && player.findPerk(PerkLib.StrongestElementalBond) >= 0) manacostofelementalattacking -= 90;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 5) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 1 && manacostofelementalattacking > 0) manacostofelementalattacking = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 2 && manacostofelementalattacking > 5) manacostofelementalattacking = 5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 3 && manacostofelementalattacking > 10) manacostofelementalattacking = 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 4 && manacostofelementalattacking > 20) manacostofelementalattacking = 20;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 5 && manacostofelementalattacking > 40) manacostofelementalattacking = 40;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 6 && manacostofelementalattacking > 80) manacostofelementalattacking = 80;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 7 && manacostofelementalattacking > 120) manacostofelementalattacking = 120;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 8 && manacostofelementalattacking > 160) manacostofelementalattacking = 160;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 4 && player.findPerk(PerkLib.StrongElementalBond) >= 0) manacostofelementalattacking -= 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 6 && player.findPerk(PerkLib.StrongerElementalBond) >= 0) manacostofelementalattacking -= 30;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 8 && player.findPerk(PerkLib.StrongestElementalBond) >= 0) manacostofelementalattacking -= 90;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 6) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 1 && manacostofelementalattacking > 0) manacostofelementalattacking = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 2 && manacostofelementalattacking > 5) manacostofelementalattacking = 5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 3 && manacostofelementalattacking > 10) manacostofelementalattacking = 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 4 && manacostofelementalattacking > 20) manacostofelementalattacking = 20;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 5 && manacostofelementalattacking > 40) manacostofelementalattacking = 40;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 6 && manacostofelementalattacking > 80) manacostofelementalattacking = 80;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 7 && manacostofelementalattacking > 120) manacostofelementalattacking = 120;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 8 && manacostofelementalattacking > 160) manacostofelementalattacking = 160;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 4 && player.findPerk(PerkLib.StrongElementalBond) >= 0) manacostofelementalattacking -= 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 6 && player.findPerk(PerkLib.StrongerElementalBond) >= 0) manacostofelementalattacking -= 30;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 8 && player.findPerk(PerkLib.StrongestElementalBond) >= 0) manacostofelementalattacking -= 90;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 7) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 1 && manacostofelementalattacking > 0) manacostofelementalattacking = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 2 && manacostofelementalattacking > 5) manacostofelementalattacking = 5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 3 && manacostofelementalattacking > 10) manacostofelementalattacking = 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 4 && manacostofelementalattacking > 20) manacostofelementalattacking = 20;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 5 && manacostofelementalattacking > 40) manacostofelementalattacking = 40;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 6 && manacostofelementalattacking > 80) manacostofelementalattacking = 80;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 7 && manacostofelementalattacking > 120) manacostofelementalattacking = 120;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 8 && manacostofelementalattacking > 160) manacostofelementalattacking = 160;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 4 && player.findPerk(PerkLib.StrongElementalBond) >= 0) manacostofelementalattacking -= 10;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 6 && player.findPerk(PerkLib.StrongerElementalBond) >= 0) manacostofelementalattacking -= 30;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 8 && player.findPerk(PerkLib.StrongestElementalBond) >= 0) manacostofelementalattacking -= 90;
	}
	if (player.mana < manacostofelementalattacking) {
		outputText("Your mana is too low to fuel your elemental attack!\n\n");
		doNext(combatMenu);
		return;
	}
	else {
		if (manacostofelementalattacking > 0) player.mana -= manacostofelementalattacking;
		elementalattacks();
	}
}
public function intwisscaling():Number {
	var intwisscalingvar:Number = 0;
	intwisscalingvar += inteligencescalingbonus() * 0.25;
	intwisscalingvar += wisdomscalingbonus() * 0.5;//1750*0.5=875
	return intwisscalingvar;
}
public function elementalattacks():void {
	var damageelemental:Number = 0;
	damageelemental += intwisscaling();
	if (damageelemental < 10) damageelemental = 10;
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 1) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 1 && damageelemental > 50) damageelemental = 50;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 2 && damageelemental > 150) damageelemental = 150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 3 && damageelemental > 300) damageelemental = 300;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) > 3) damageelemental += intwisscaling();
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 4 && damageelemental > 600) damageelemental = 600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 5 && damageelemental > 1150) damageelemental = 1150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 6 && damageelemental > 1600) damageelemental = 1600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 7 && damageelemental > 2100) damageelemental = 2100;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 8 && damageelemental > 2700) damageelemental = 2700;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 2) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 1 && damageelemental > 50) damageelemental = 50;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 2 && damageelemental > 150) damageelemental = 150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 3 && damageelemental > 300) damageelemental = 300;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) > 3) damageelemental += intwisscaling();
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 4 && damageelemental > 600) damageelemental = 600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 5 && damageelemental > 1150) damageelemental = 1150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 6 && damageelemental > 1600) damageelemental = 1600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 7 && damageelemental > 2100) damageelemental = 2100;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 8 && damageelemental > 2700) damageelemental = 2700;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 3) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 1 && damageelemental > 50) damageelemental = 50;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 2 && damageelemental > 150) damageelemental = 150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 3 && damageelemental > 300) damageelemental = 300;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) > 3) damageelemental += intwisscaling();
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 4 && damageelemental > 600) damageelemental = 600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 5 && damageelemental > 1150) damageelemental = 1150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 6 && damageelemental > 1600) damageelemental = 1600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 7 && damageelemental > 2100) damageelemental = 2100;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 8 && damageelemental > 2700) damageelemental = 2700;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 4) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 1 && damageelemental > 50) damageelemental = 50;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 2 && damageelemental > 150) damageelemental = 150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 3 && damageelemental > 300) damageelemental = 300;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) > 3) damageelemental += intwisscaling();
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 4 && damageelemental > 600) damageelemental = 600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 5 && damageelemental > 1150) damageelemental = 1150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 6 && damageelemental > 1600) damageelemental = 1600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 7 && damageelemental > 2100) damageelemental = 2100;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 8 && damageelemental > 2700) damageelemental = 2700;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 5) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 1 && damageelemental > 50) damageelemental = 50;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 2 && damageelemental > 150) damageelemental = 150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 3 && damageelemental > 300) damageelemental = 300;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) > 3) damageelemental += intwisscaling();
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 4 && damageelemental > 600) damageelemental = 600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 5 && damageelemental > 1150) damageelemental = 1150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 6 && damageelemental > 1600) damageelemental = 1600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 7 && damageelemental > 2100) damageelemental = 2100;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 8 && damageelemental > 2700) damageelemental = 2700;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 6) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 1 && damageelemental > 50) damageelemental = 50;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 2 && damageelemental > 150) damageelemental = 150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 3 && damageelemental > 300) damageelemental = 300;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) > 3) damageelemental += intwisscaling();
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 4 && damageelemental > 600) damageelemental = 600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 5 && damageelemental > 1150) damageelemental = 1150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 6 && damageelemental > 1600) damageelemental = 1600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 7 && damageelemental > 2100) damageelemental = 2100;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 8 && damageelemental > 2700) damageelemental = 2700;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 7) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 1 && damageelemental > 50) damageelemental = 50;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 2 && damageelemental > 150) damageelemental = 150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 3 && damageelemental > 300) damageelemental = 300;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) > 3) damageelemental += intwisscaling();
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 4 && damageelemental > 600) damageelemental = 600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 5 && damageelemental > 1150) damageelemental = 1150;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 6 && damageelemental > 1600) damageelemental = 1600;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 7 && damageelemental > 2100) damageelemental = 2100;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 8 && damageelemental > 2700) damageelemental = 2700;
	}
	if (player.findPerk(PerkLib.ElementalConjurerResolve) >= 0) damageelemental *= (1 + (0.1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
	if (player.findPerk(PerkLib.ElementalConjurerDedication) >= 0) damageelemental *= (1 + (0.2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
	if (player.findPerk(PerkLib.ElementalConjurerSacrifice) >= 0) damageelemental *= (1 + (0.3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
	//Determine if critical hit!
	var crit:Boolean = false;
	var critChance:int = 5;
	if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
		if (player.inte <= 100) critChance += (player.inte - 50) / 5;
		if (player.inte > 100) critChance += 10;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 1 || flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 4) critChance += 10;
	if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
	if (rand(100) < critChance) {
		crit = true;
		if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 1) damageelemental *= 1.75;
		else damageelemental *= 1.5;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 2) damageelemental *= 1.5;
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 3) {
		if (monster.findPerk(PerkLib.IceNature) >= 0) damageelemental *= 5;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damageelemental *= 2;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damageelemental *= 0.5;
		if (monster.findPerk(PerkLib.FireNature) >= 0) damageelemental *= 0.2;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 4 || flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 5) {
		if (monster.findPerk(PerkLib.IceNature) >= 0) damageelemental *= 0.2;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damageelemental *= 0.5;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damageelemental *= 2;
		if (monster.findPerk(PerkLib.FireNature) >= 0) damageelemental *= 5;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 6) {
		if (monster.findPerk(PerkLib.DarknessNature) >= 0) temp *= 5;
		if (monster.findPerk(PerkLib.LightningVulnerability) >= 0) temp *= 2;
		if (monster.findPerk(PerkLib.DarknessVulnerability) >= 0) temp *= 0.5;
		if (monster.findPerk(PerkLib.LightningNature) >= 0) temp *= 0.2;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 7) {
		if (monster.findPerk(PerkLib.DarknessNature) >= 0) temp *= 0.2;
		if (monster.findPerk(PerkLib.LightningVulnerability) >= 0) temp *= 0.5;
		if (monster.findPerk(PerkLib.DarknessVulnerability) >= 0) temp *= 2;
		if (monster.findPerk(PerkLib.LightningNature) >= 0) temp *= 5;
	}
	if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] != 1) damageelemental *= (monster.damagePercent(false, true) / 100);
	damageelemental = Math.round(damageelemental);
	outputText("Your elemental hit " + monster.a + monster.short + "! ");
	if (crit == true) {
		outputText("<b>Critical! </b>");
	}
	outputText("<b>(<font color=\"#800000\">" + damageelemental + "</font>)</b>\n\n");
	damageelemental = doDamage(damageelemental);
	//checkMinionsAchievementDamage(damageelemental);
	if(monster.HP >= 1 && monster.lust <= monster.eMaxLust()) {
		fatigueRecovery();
		manaregeneration();
		soulforceregeneration();
		enemyAI();
	}
	else {
		if(monster.HP <= 0) doNext(endHpVictory);
		else doNext(endLustVictory);
	}
}

public function packAttack():void {
	//Determine if dodged!
	if (player.spe - monster.spe > 0 && int(Math.random() * (((player.spe - monster.spe) / 4) + 80)) > 80) {
		outputText("You duck, weave, and dodge.  Despite their best efforts, the throng of demons only hit the air and each other.");
	}
	//Determine if evaded
	else if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
		outputText("Using your skills at evading attacks, you anticipate and sidestep " + monster.a + monster.short + "' attacks.");
	}
	//("Misdirection"
	else if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 15 && player.armorName == "red, high-society bodysuit") {
		outputText("Using Raphael's teachings, you anticipate and sidestep " + monster.a + monster.short + "' attacks.");
	}
	//Determine if cat'ed
	else if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
		outputText("With your incredible flexibility, you squeeze out of the way of " + monster.a + monster.short + "' attacks.");
	}
	else {
		temp = int((monster.str + monster.weaponAttack) * (player.damagePercent() / 100)); //Determine damage - str modified by enemy toughness!
		if (temp <= 0) {
			temp = 0;
			if (!monster.plural)
				outputText("You deflect and block every " + monster.weaponVerb + " " + monster.a + monster.short + " throw at you.");
			else outputText("You deflect " + monster.a + monster.short + " " + monster.weaponVerb + ".");
		}
		else {
			if (temp <= 5)
				outputText("You are struck a glancing blow by " + monster.a + monster.short + "! ");
			else if (temp <= 10)
				outputText(monster.capitalA + monster.short + " wound you! ");
			else if (temp <= 20)
				outputText(monster.capitalA + monster.short + " stagger you with the force of " + monster.pronoun3 + " " + monster.weaponVerb + "s! ");
			else outputText(monster.capitalA + monster.short + " <b>mutilates</b> you with powerful fists and " + monster.weaponVerb + "s! ");
			takeDamage(temp, true);
		}
		statScreenRefresh();
		outputText("\n");
	}
	combatRoundOver();
}

public function lustAttack():void {
	flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
	if (player.lust < (player.maxLust() * 0.35)) {
		outputText("The " + monster.short + " press in close against you and although they fail to hit you with an attack, the sensation of their skin rubbing against yours feels highly erotic.");
	}
	else if (player.lust < (player.maxLust() * 0.65)) {
		outputText("The push of the " + monster.short + "' sweaty, seductive bodies sliding over yours is deliciously arousing and you feel your ");
		if (player.cocks.length > 0)
			outputText(player.multiCockDescriptLight() + " hardening ");
		else if (player.vaginas.length > 0) outputText(vaginaDescript(0) + " get wetter ");
		outputText("in response to all the friction.");
	}
	else {
		outputText("As the " + monster.short + " mill around you, their bodies rub constantly over yours, and it becomes harder and harder to keep your thoughts on the fight or resist reaching out to touch a well lubricated cock or pussy as it slips past.  You keep subconsciously moving your ");
		if (player.gender == 1) outputText(player.multiCockDescriptLight() + " towards the nearest inviting hole.");
		if (player.gender == 2) outputText(vaginaDescript(0) + " towards the nearest swinging cock.");
		if (player.gender == 3) outputText("aching cock and thirsty pussy towards the nearest thing willing to fuck it.");
		if (player.gender == 0) outputText("groin, before remember there is nothing there to caress.");
	}
	dynStats("lus", 10 + player.sens / 10);
	combatRoundOver();
}

private function wait():void {
	flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] = 1;
	//Gain fatigue if not fighting sand tarps
	if (!monster.hasStatusEffect(StatusEffects.Level)) {
		fatigue(-5);
		manaregeneration();
		soulforceregeneration();
	}
	if (monster.hasStatusEffect(StatusEffects.PCTailTangle)) {
		(monster as Kitsune).kitsuneWait();
	}
	else if (monster.hasStatusEffect(StatusEffects.Level)) {
		if (monster is SandTrap) {
			(monster as SandTrap).sandTrapWait();
		}
		if (monster is Alraune) {
			(monster as Alraune).alrauneWait();
		}
	}
	else if (monster.hasStatusEffect(StatusEffects.MinotaurEntangled)) {
		clearOutput();
		outputText("You sigh and relax in the chains, eying the well-endowed minotaur as you await whatever rough treatment he desires to give.  His musky, utterly male scent wafts your way on the wind, and you feel droplets of your lust dripping down your thighs.  You lick your lips as you watch the pre-cum drip from his balls, eager to get down there and worship them.  Why did you ever try to struggle against this fate?\n\n");
		dynStats("lus", 30 + rand(5), "resisted", false);
		enemyAI();
	}
	else if (player.hasStatusEffect(StatusEffects.Whispered)) {
		clearOutput();
		outputText("You shake off the mental compulsions and ready yourself to fight!\n\n");
		player.removeStatusEffect(StatusEffects.Whispered);
		enemyAI();
	}
	else if (player.hasStatusEffect(StatusEffects.HarpyBind)) {
		clearOutput();
		outputText("The brood continues to hammer away at your defenseless self. ");
		temp = 80 + rand(40);
		temp = takeDamage(temp, true);
		combatRoundOver();
	}
	else if (monster.hasStatusEffect(StatusEffects.QueenBind)) {
		(monster as HarpyQueen).ropeStruggles(true);
	}
	else if (player.hasStatusEffect(StatusEffects.GooBind)) {
		clearOutput();
		outputText("You writhe uselessly, trapped inside the goo girl's warm, seething body. Darkness creeps at the edge of your vision as you are lulled into surrendering by the rippling vibrations of the girl's pulsing body around yours.");
		temp = takeDamage(.35 * player.maxHP(), true);
		combatRoundOver();
	}
	else if (player.hasStatusEffect(StatusEffects.GooArmorBind)) {
		clearOutput();
		outputText("Suddenly, the goo-girl leaks half-way out of her heavy armor and lunges at you. You attempt to dodge her attack, but she doesn't try and hit you - instead, she wraps around you, pinning your arms to your chest. More and more goo latches onto you - you'll have to fight to get out of this.");
		player.addStatusValue(StatusEffects.GooArmorBind, 1, 1);
		if (player.statusEffectv1(StatusEffects.GooArmorBind) >= 5) {
			if (monster.hasStatusEffect(StatusEffects.Spar))
				kGAMECLASS.valeria.pcWinsValeriaSparDefeat();
			else kGAMECLASS.dungeons.heltower.gooArmorBeatsUpPC();
			return;
		}
		combatRoundOver();
	}
	else if (player.hasStatusEffect(StatusEffects.NagaBind)) {
		clearOutput();
		if (monster is CaiLin && flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
		else outputText("The " + monster.short + "");
		outputText("'s grip on you tightens as you relax into the stimulating pressure.");
		dynStats("lus", player.sens / 5 + 5);
		takeDamage(5 + rand(5));
		combatRoundOver();
	}
	else if (player.hasStatusEffect(StatusEffects.ScyllaBind)) {
		clearOutput();
		outputText("You're being squeezed tightly by the scylla’s powerful tentacles. That's without mentioning the fact she's rubbing in your sensitive place quite a bit, giving you a knowing grin.");
		dynStats("lus", player.sens / 4 + 20);
		takeDamage(100 + rand(40));
		combatRoundOver();
	}
	else if (player.hasStatusEffect(StatusEffects.WolfHold)) {
		clearOutput();
		outputText("The wolf tear your body with its maw wounding you greatly as it starts to eat you alive!");
		takeDamage(5 + rand(5));
		combatRoundOver();
	}
	else if (player.hasStatusEffect(StatusEffects.HolliConstrict)) {
		(monster as Holli).waitForHolliConstrict(true);
	}
	else if (player.hasStatusEffect(StatusEffects.TentacleBind)) {
		clearOutput();
		if (player.cocks.length > 0)
			outputText("The creature continues spiraling around your cock, sending shivers up and down your body. You must escape or this creature will overwhelm you!");
		else if (player.hasVagina())
			outputText("The creature continues sucking your clit and now has latched two more suckers on your nipples, amplifying your growing lust. You must escape or you will become a mere toy to this thing!");
		else outputText("The creature continues probing at your asshole and has now latched " + num2Text(player.totalNipples()) + " more suckers onto your nipples, amplifying your growing lust.  You must escape or you will become a mere toy to this thing!");
		dynStats("lus", (8 + player.sens / 10));
		combatRoundOver();
	}
	else if (player.hasStatusEffect(StatusEffects.GiantGrabbed)) {
		clearOutput();
		(monster as FrostGiant).giantGrabFail(false);
	}
	else if (player.hasStatusEffect(StatusEffects.GiantBoulder)) {
		clearOutput();
		(monster as FrostGiant).giantBoulderMiss();
	}
	else if (player.hasStatusEffect(StatusEffects.IsabellaStunned)) {
		clearOutput();
		outputText("You wobble about for some time but manage to recover. Isabella capitalizes on your wasted time to act again.\n\n");
		player.removeStatusEffect(StatusEffects.IsabellaStunned);
		enemyAI();
	}
	else if (player.hasStatusEffect(StatusEffects.Stunned)) {
		clearOutput();
		outputText("You wobble about, stunned for a moment.  After shaking your head, you clear the stars from your vision, but by then you've squandered your chance to act.\n\n");
		player.removeStatusEffect(StatusEffects.Stunned);
		enemyAI();
	}
	else if (player.hasStatusEffect(StatusEffects.Confusion)) {
		clearOutput();
		outputText("You shake your head and file your memories in the past, where they belong.  It's time to fight!\n\n");
		player.removeStatusEffect(StatusEffects.Confusion);
		enemyAI();
	}
	else if (monster is Doppleganger) {
		clearOutput();
		outputText("You decide not to take any action this round.\n\n");
		(monster as Doppleganger).handlePlayerWait();
		enemyAI();
	}
	else {
		clearOutput();
		outputText("You decide not to take any action this round.\n\n");
		enemyAI();
	}
}

private function struggle():void {
	if (monster.hasStatusEffect(StatusEffects.MinotaurEntangled)) {
		clearOutput();
		if (player.str / 9 + rand(20) + 1 >= 15) {
			outputText("Utilizing every ounce of your strength and cunning, you squirm wildly, shrugging through weak spots in the chain's grip to free yourself!  Success!\n\n");
			monster.removeStatusEffect(StatusEffects.MinotaurEntangled);
			if (flags[kFLAGS.URTA_QUEST_STATUS] == 0.75) outputText("\"<i>No!  You fool!  You let her get away!  Hurry up and finish her up!  I need my serving!</i>\"  The succubus spits out angrily.\n\n");
			combatRoundOver();
		}
		//Struggle Free Fail*
		else {
			outputText("You wiggle and struggle with all your might, but the chains remain stubbornly tight, binding you in place.  Damnit!  You can't lose like this!\n\n");
			enemyAI();
		}
	}
	else if (monster.hasStatusEffect(StatusEffects.PCTailTangle)) {
		(monster as Kitsune).kitsuneStruggle();
	}
	else if (player.hasStatusEffect(StatusEffects.HolliConstrict)) {
		(monster as Holli).struggleOutOfHolli();
	}
	else if (monster.hasStatusEffect(StatusEffects.QueenBind)) {
		(monster as HarpyQueen).ropeStruggles();
	}
	else if (player.hasStatusEffect(StatusEffects.GooBind)) {
		clearOutput();
		//[Struggle](successful) :
		if (rand(3) == 0 || rand(80) < player.str) {
			outputText("You claw your fingers wildly within the slime and manage to brush against her heart-shaped nucleus. The girl silently gasps and loses cohesion, allowing you to pull yourself free while she attempts to solidify.");
			player.removeStatusEffect(StatusEffects.GooBind);
		}
		//Failed struggle
		else {
			outputText("You writhe uselessly, trapped inside the goo girl's warm, seething body. Darkness creeps at the edge of your vision as you are lulled into surrendering by the rippling vibrations of the girl's pulsing body around yours. ");
			temp = takeDamage(.15 * player.maxHP(), true);
		}
		combatRoundOver();
	}
	else if (player.hasStatusEffect(StatusEffects.HarpyBind)) {
		(monster as HarpyMob).harpyHordeGangBangStruggle();
	}
	else if (player.hasStatusEffect(StatusEffects.GooArmorBind)) {
		(monster as GooArmor).struggleAtGooBind();
	}
	else if (player.hasStatusEffect(StatusEffects.UBERWEB)) {
		clearOutput();
		outputText("You claw your way out of the webbing while Kiha does her best to handle the spiders single-handedly!\n\n");
		player.removeStatusEffect(StatusEffects.UBERWEB);
		enemyAI();
	}
	else if (player.hasStatusEffect(StatusEffects.NagaBind)) {
		clearOutput();
		if (rand(3) == 0 || rand(80) < player.str / 1.5) {
			outputText("You wriggle and squirm violently, tearing yourself out from within " + monster.a + monster.short + "'s coils.");
			player.removeStatusEffect(StatusEffects.NagaBind);
		}
		else {
			if (monster is CaiLin && flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
			else outputText("The " + monster.short + "");
			outputText("'s grip on you tightens as you struggle to break free from the stimulating pressure.");
			dynStats("lus", player.sens / 10 + 2);
			if (monster is Naga) takeDamage(7 + rand(5));
			if (monster is Gorgon) takeDamage(17 + rand(15));
			if (monster is CaiLin) takeDamage(10 + rand(8));
		}
		combatRoundOver();
	}
	else if (player.hasStatusEffect(StatusEffects.ScyllaBind)) {
		clearOutput();
		outputText("You struggle to get free from the " + monster.short + " mighty tentacles. ");
		if (rand(3) == 0 || rand(120) < player.str / 1.5) {
			outputText("As force alone seems ineffective, you bite one of her tentacles and she screams in surprise, releasing you.");
			player.removeStatusEffect(StatusEffects.ScyllaBind);
		}
		else {
			outputText("Despite all of your struggle she manage to maintain her hold on you.");
			dynStats("lus", player.sens / 5 + 5);
			takeDamage(100 + rand(80));
		}
		combatRoundOver();
	}
	else if (player.hasStatusEffect(StatusEffects.WolfHold)) {
		clearOutput();
		if (rand(3) == 0 || rand(80) < player.str / 1.5) {
			outputText("You slam your head in the wolf sensible muzzle forcing it to recoil away as it whine in pain allowing you to stand up.");
			player.removeStatusEffect(StatusEffects.WolfHold);
		}
		else {
			outputText("The wolf tear your body with its maw wounding you greatly as it starts to eat you alive!");
			takeDamage(7 + rand(5));
		}
		combatRoundOver();
	}
	else if (player.hasStatusEffect(StatusEffects.GiantGrabbed)) {
		(monster as FrostGiant).giantGrabStruggle();
	}
	else {
		clearOutput();
		outputText("You struggle with all of your might to free yourself from the tentacles before the creature can fulfill whatever unholy desire it has for you.\n");
		//33% chance to break free + up to 50% chance for strength
		if (rand(3) == 0 || rand(80) < player.str / 2) {
			outputText("As the creature attempts to adjust your position in its grip, you free one of your [legs] and hit the beast in its beak, causing it to let out an inhuman cry and drop you to the ground smartly.\n\n");
			player.removeStatusEffect(StatusEffects.TentacleBind);
			monster.createStatusEffect(StatusEffects.TentacleCoolDown, 3, 0, 0, 0);
			enemyAI();
		}
		//Fail to break free
		else {
			outputText("Despite trying to escape, the creature only tightens its grip, making it difficult to breathe.\n\n");
			takeDamage(5);
			if (player.cocks.length > 0)
				outputText("The creature continues spiraling around your cock, sending shivers up and down your body. You must escape or this creature will overwhelm you!");
			else if (player.hasVagina())
				outputText("The creature continues sucking your clit and now has latched two more suckers on your nipples, amplifying your growing lust. You must escape or you will become a mere toy to this thing!");
			else outputText("The creature continues probing at your asshole and has now latched " + num2Text(player.totalNipples()) + " more suckers onto your nipples, amplifying your growing lust.  You must escape or you will become a mere toy to this thing!");
			dynStats("lus", (3 + player.sens / 10 + player.lib / 20));
			combatRoundOver();
		}
	}
}

public function arrowsAccuracy():Number {
	var accmod:Number = 60;
	if (player.findPerk(PerkLib.HistoryScout) >= 0 || player.findPerk(PerkLib.PastLifeScout) >= 0) accmod += 40;
	if (player.findPerk(PerkLib.Accuracy1) >= 0) {
		accmod += player.perkv1(PerkLib.Accuracy1);
	}
	if (player.findPerk(PerkLib.Accuracy2) >= 0) {
		accmod -= player.perkv1(PerkLib.Accuracy2);
	}
	if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
		if (player.statusEffectv1(StatusEffects.Kelt) <= 100) accmod += player.statusEffectv1(StatusEffects.Kelt);
		else accmod += 100;
	}
	if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
		if (player.statusEffectv1(StatusEffects.Kindra) <= 150) accmod += player.statusEffectv1(StatusEffects.Kindra);
		else accmod += 150;
	}
	if (player.inte > 50 && player.findPerk(PerkLib.JobHunter) >= 0) {
		if (player.inte <= 150) accmod += (player.inte - 50);
		else accmod += 100;
	}
	if (player.findPerk(PerkLib.CarefulButRecklessAimAndShooting) >= 0) accmod += 60;
	if (player.hasStatusEffect(StatusEffects.Flying)) accmod -= 100;
//	if(player.findPerk(PerkLib.GreyMage) >= 0 && player.inte >= 125) mod += .7;
//	if(player.findPerk(PerkLib.Mage) >= 0 && player.inte >= 50) mod += .2;
//	if (player.findPerk(PerkLib.ChiReflowMagic) >= 0) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
//	if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
//	if (player.countCockSocks("blue") > 0) mod += (player.countCockSocks("blue") * .05);
//	if (player.findPerk(PerkLib.AscensionMysticality) >= 0) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
	return accmod;
}

public function oneArrowTotalCost():Number {
	var onearrowcost:Number = 25;
	//additional arrow effects costs
	if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1 || flags[kFLAGS.ELEMENTAL_ARROWS] == 2) onearrowcost += 15;
	if (flags[kFLAGS.CUPID_ARROWS] == 1) onearrowcost += 5;
	if (flags[kFLAGS.ENVENOMED_BOLTS] == 1) onearrowcost += 5;
	//Bow Shooting perk cost reduction
	if (player.findPerk(PerkLib.BowShooting) >= 0) onearrowcost *= (1 - ((player.perkv1(PerkLib.BowShooting)) / 100));
	return onearrowcost;
}
public function oneThrowTotalCost():Number {
	var onearrowcost:Number = 25;
	//additional arrow effects costs
//	if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1 || flags[kFLAGS.ELEMENTAL_ARROWS] == 2) onearrowcost += 15;
//	if (flags[kFLAGS.CUPID_ARROWS] == 1) onearrowcost += 5;
//	if (flags[kFLAGS.ENVENOMED_BOLTS] == 1) onearrowcost += 5;
	//Bow Shooting perk cost reduction
//	if (player.findPerk(PerkLib.BowShooting) >= 0) onearrowcost *= (1 - ((player.perkv1(PerkLib.BowShooting)) / 100));
	return onearrowcost;
}

public function speedscalingbonus():Number {
	var speedscalingvalue:Number = 0;
	if (player.spe >= 21) speedscalingvalue += player.spe - 20;
	if (player.spe >= 41) speedscalingvalue += player.spe - 40;
	if (player.spe >= 61) speedscalingvalue += player.spe - 60;
	if (player.spe >= 81) speedscalingvalue += player.spe - 80;
	if (player.spe >= 101) speedscalingvalue += player.spe - 100;
	if (player.spe >= 151) speedscalingvalue += player.spe - 150;
	if (player.spe >= 201) speedscalingvalue += player.spe - 200;
	if (player.spe >= 251) speedscalingvalue += player.spe - 250;
	if (player.spe >= 301) speedscalingvalue += player.spe - 300;
	if (player.spe >= 351) speedscalingvalue += player.spe - 350;
	if (player.spe >= 401) speedscalingvalue += player.spe - 400;
	if (player.spe >= 451) speedscalingvalue += player.spe - 450;
	if (player.spe >= 501) speedscalingvalue += player.spe - 500;
	if (player.spe >= 551) speedscalingvalue += player.spe - 550;
	if (player.spe >= 601) speedscalingvalue += player.spe - 600;
	if (player.spe >= 651) speedscalingvalue += player.spe - 650;
	if (player.spe >= 701) speedscalingvalue += player.spe - 700;
	if (player.spe >= 751) speedscalingvalue += player.spe - 750;
	if (player.spe >= 801) speedscalingvalue += player.spe - 800;
	if (player.spe >= 851) speedscalingvalue += player.spe - 850;
	if (player.spe >= 901) speedscalingvalue += player.spe - 900;
	if (player.spe >= 951) speedscalingvalue += player.spe - 950;
	if (player.spe >= 1001) speedscalingvalue += player.spe - 1000;
	if (player.spe >= 1051) speedscalingvalue += player.spe - 1050;
	if (player.spe >= 1101) speedscalingvalue += player.spe - 1100;
	if (player.spe >= 1151) speedscalingvalue += player.spe - 1150;
	if (player.spe >= 1201) speedscalingvalue += player.spe - 1200;
	return speedscalingvalue;
}

public function fireBow():void {
	clearOutput();
	if (monster.hasStatusEffect(StatusEffects.BowDisabled)) {
		outputText("You can't use your range weapon right now!");
		menu();
		addButton(0, "Next", combatMenu, false);
		return;
	}
	flags[kFLAGS.LAST_ATTACK_TYPE] = 1;
	if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow") {
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 5) {
			if (player.weaponRangePerk == "Crossbow") flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
			else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 6;
		}
		else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 4) {
			if (player.weaponRangePerk == "Crossbow") flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
			else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 5;
		}
		else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 3) {
			if (player.weaponRangePerk == "Crossbow") flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
			else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 4;
		}
		else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 2) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
		else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 1) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
		else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 1;
		var fireBowCost:Number = 0;
		fireBowCost += oneArrowTotalCost();
		//multiple arrows shoot costs
		if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 6) fireBowCost *= 6;
		if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 5) fireBowCost *= 5;
		if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 4) fireBowCost *= 4;
		if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 3) fireBowCost *= 3;
		if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 2) fireBowCost *= 2;
		if (player.fatigue + fireBowCost > player.maxFatigue()) {
			outputText("You're too fatigued to fire the ");
			if (player.weaponRangePerk == "Crossbow") outputText("cross");
			outputText("bow!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
	//	fatigue(fireBowCost);
	}
	if (player.weaponRangePerk == "Throwing") {
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 5) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
		else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 4) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
		else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 3) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
		else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 2) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
		else if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 1) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
		else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 1;
	}
	if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") {
		flags[kFLAGS.FLINTLOCK_PISTOL_AMMO]--;
	}
//	if (player.weaponRangePerk == "Rifle") {
		//fatigue(50, 4);	//wstawić tutaj typ redukcji kosztów jak dla physical specials
//	}
	if (flags[kFLAGS.ARROWS_ACCURACY] > 0) flags[kFLAGS.ARROWS_ACCURACY] = 0;
	//Keep logic sane if this attack brings victory
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
	//Amily!
	if (monster.hasStatusEffect(StatusEffects.Concentration)) {
		outputText("Amily easily glides around your attack");
		if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) outputText("s");
		outputText(" thanks to her complete concentration on your movements.\n\n");
		enemyAI();
		return;
	}
	if (monster.hasStatusEffect(StatusEffects.Sandstorm) && rand(10) > 1) {
		outputText("Your attack");
		if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) outputText("s");
		outputText(" is blown off target by the tornado of sand and wind.  Damn!\n\n");
		enemyAI();
		return;
	}
	//[Bow Response]
	if (monster.short == "Isabella") {
		if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind)) {
			outputText("Isabella hears the shot");
			if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) outputText("s");
			outputText(" and turns her shield towards ");
			if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) outputText("them");
			if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 1) outputText("it");
			outputText(", completely blocking ");
			if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) outputText("them");
			if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 1) outputText("it");
			outputText(" with her wall of steel.\n\n");
		}
		else {
			outputText("You ");
			if (player.weaponRangePerk == "Bow") outputText("arrow");
			if (player.weaponRangePerk == "Crossbow") outputText("bolt");
			if (player.weaponRangePerk == "Throwing") outputText("projectile");
			if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") outputText("bullet");
			if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) outputText("s");
			outputText(" thunks into Isabella's shield, completely blocked by the wall of steel.\n\n");
		}
		if (kGAMECLASS.isabellaFollowerScene.isabellaAccent())
			outputText("\"<i>You remind me of ze horse-people.  They cannot deal vith mein shield either!</i>\" cheers Isabella.\n\n");
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
		if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") outputText("bullet");
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
		if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") outputText("bullet");
		if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) outputText("s");
		outputText(" goes wide.\n\n");
		enemyAI();
		return;
	}
	//Blind miss chance
	if (player.hasStatusEffect(StatusEffects.Blind)) {
		outputText("The ");
		if (player.weaponRangePerk == "Bow") outputText("arrow");
		if (player.weaponRangePerk == "Crossbow") outputText("bolt");
		if (player.weaponRangePerk == "Throwing") outputText("projectile");
		if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") outputText("bullet");
		if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] >= 2) outputText("s");
		outputText(" hits something, but blind as you are, you don't have a chance in hell of hitting anything with a bow.\n\n");
		enemyAI();
		return;
	}
	if (monster is Lethice && monster.hasStatusEffect(StatusEffects.Shell))
	{
		outputText("Your ");
		if (player.weaponRangePerk == "Bow") outputText("arrow");
		if (player.weaponRangePerk == "Crossbow") outputText("bolt");
		if (player.weaponRangePerk == "Throwing") outputText("projectile");
		if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") outputText("bullet");
		outputText(" pings of the side of the shield and spins end over end into the air. Useless.\n\n");
		enemyAI();
		return;
	}
	if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow") {
		if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) outputText("Your bow nudges as you ready the next shot, helping you keep your aimed at " + monster.short + ".\n\n");
		multiArrowsStrike();
	}
	if (player.weaponRangePerk == "Throwing") {
		var fc:Number       = oneThrowTotalCost();
		if (player.fatigue + fc > player.maxFatigue()) {
			outputText("You're too fatigued to throw the [weaponrangename]!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		throwWeapon();
	}
	if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") shootWeapon();
}

public function multiArrowsStrike():void {
	var accRange:Number = 0;
	accRange += (arrowsAccuracy() / 2);
	if (flags[kFLAGS.ARROWS_ACCURACY] > 0) accRange -= flags[kFLAGS.ARROWS_ACCURACY];
	if (player.weaponRangeName == "Guided bow") accRange = 100;
	fatigue(oneArrowTotalCost());
	if (rand(100) < accRange) {
		var damage:Number = 0;
		if (player.weaponRangePerk == "Bow") {
			damage += player.spe;
			damage += speedscalingbonus() * 0.2;
			if (damage < 10) damage = 10;
		}
		if (player.weaponRangePerk == "Crossbow") damage += player.weaponRangeAttack * 10;
		if (player.findPerk(PerkLib.DeadlyAim) < 0) damage *= (monster.damagePercent() / 100);//jak ten perk o ignorowaniu armora bedzie czy coś to tu dać jak nie ma tego perku to sie dolicza
		//Weapon addition!
		if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
		else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
		else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
		else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
		if (damage == 0) {
			if (monster.inte > 0) {
				outputText(monster.capitalA + monster.short + " shrugs as the ");
				if (player.weaponRangePerk == "Bow") outputText("arrow");
				if (player.weaponRangePerk == "Crossbow") outputText("bolt");
				outputText(" bounces off them harmlessly.\n\n");
			}
			else {
				outputText("The ");
				if (player.weaponRangePerk == "Bow") outputText("arrow");
				if (player.weaponRangePerk == "Crossbow") outputText("bolt");
				outputText(" bounces harmlessly off " + monster.a + monster.short + ".\n\n");
			}
			flags[kFLAGS.ARROWS_SHOT]++;
			bowPerkUnlock();
		}
		if (monster.short == "pod") {
			outputText("The ");
			if (player.weaponRangePerk == "Bow") outputText("arrow");
			if (player.weaponRangePerk == "Crossbow") outputText("bolt");
			outputText(" lodges deep into the pod's fleshy wall");
		}
		else if (monster.plural) {
			var textChooser1:int = rand(12);
			if (textChooser1 >= 9) {
				outputText(monster.capitalA + monster.short + " look down at the ");
				if (player.weaponRangePerk == "Bow") outputText("arrow");
				if (player.weaponRangePerk == "Crossbow") outputText("bolt");
				outputText(" that now protrudes from one of " + monster.pronoun3 + " bodies");
			}
			else if (textChooser1 >= 6 && textChooser1 < 9) {
				outputText("You pull an ");
				if (player.weaponRangePerk == "Bow") outputText("arrow");
				if (player.weaponRangePerk == "Crossbow") outputText("bolt");
				outputText(" and fire it at one of " + monster.a + monster.short + "");
			}
			else if (textChooser1 >= 3 && textChooser1 < 6) {
				outputText("With one smooth motion you draw, nock, and fire your deadly ");
				if (player.weaponRangePerk == "Bow") outputText("arrow");
				if (player.weaponRangePerk == "Crossbow") outputText("bolt");
				outputText(" at one of your opponents");
			}
			else {
				outputText("You casually fire an ");
				if (player.weaponRangePerk == "Bow") outputText("arrow");
				if (player.weaponRangePerk == "Crossbow") outputText("bolt");
				outputText(" at one of " + monster.a + monster.short + " with supreme skill");
			}
		}
		else {
			var textChooser2:int = rand(12);
			if (textChooser2 >= 9) {
				outputText(monster.capitalA + monster.short + " looks down at the ");
				if (player.weaponRangePerk == "Bow") outputText("arrow");
				if (player.weaponRangePerk == "Crossbow") outputText("bolt");
				outputText(" that now protrudes from " + monster.pronoun3 + " body");
			} else if (textChooser2 >= 6) {
				outputText("You pull an ");
				if (player.weaponRangePerk == "Bow") outputText("arrow");
				if (player.weaponRangePerk == "Crossbow") outputText("bolt");
				outputText(" and fire it at " + monster.a + monster.short + "");
			} else if (textChooser2 >= 3) {
				outputText("With one smooth motion you draw, nock, and fire your deadly ");
				if (player.weaponRangePerk == "Bow") outputText("arrow");
				if (player.weaponRangePerk == "Crossbow") outputText("bolt");
				outputText(" at your opponent");
			} else {
				outputText("You casually fire an ");
				if (player.weaponRangePerk == "Bow") outputText("arrow");
				if (player.weaponRangePerk == "Crossbow") outputText("bolt");
				outputText(" at " + monster.a + monster.short + " with supreme skill");
			}
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.VitalShot) >= 0 && player.inte >= 50) critChance += 10;
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (player.findPerk(PerkLib.HistoryScout) >= 0 || player.findPerk(PerkLib.PastLifeScout) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobRanger) >= 0) damage *= 1.05;
		if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
			if (player.statusEffectv1(StatusEffects.Kelt) < 100) damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
			else {
				if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
					if (player.statusEffectv1(StatusEffects.Kindra) < 150) damage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
					else damage *= 3.5;
				}
				else damage *= 2;
			}
		}	
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 0.5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 0.2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 2;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		if (flags[kFLAGS.ARROWS_SHOT] >= 1) kGAMECLASS.awardAchievement("Arrow to the Knee", kACHIEVEMENTS.COMBAT_ARROW_TO_THE_KNEE);
		if (monster.HP <= 0) {
			if (monster.short == "pod")
				outputText(". ");
			else if (monster.plural)
				outputText(" and " + monster.pronoun1 + " stagger, collapsing onto each other from the wounds you've inflicted on " + monster.pronoun2 + ". ");
			else outputText(" and " + monster.pronoun1 + " staggers, collapsing from the wounds you've inflicted on " + monster.pronoun2 + ". ");
			outputText("<b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText("\n\n");
			checkAchievementDamage(damage);
			flags[kFLAGS.ARROWS_SHOT]++;
			bowPerkUnlock();
			doNext(endHpVictory);
			return;
		}
		else {
			outputText(".  It's clearly very painful. <b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		}
		if (flags[kFLAGS.CUPID_ARROWS] == 1) {
			outputText("  ");
			if(monster.lustVuln == 0) {
				outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.");
			}
			else {
				var lustArrowDmg:Number = monster.lustVuln * (player.inte / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
				if (monster.lust < (monster.eMaxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
				if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6)) {
					if (monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
					else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
				}
				if (monster.lust >= (monster.eMaxLust() * 0.6)) {
					outputText(monster.capitalA + monster.short + "'");
					if(!monster.plural) outputText("s");
					outputText(" eyes glaze over with desire for a moment.  ");
				}
				lustArrowDmg *= 0.25;
				lustArrowDmg = Math.round(lustArrowDmg);
				monster.lust += lustArrowDmg;
				outputText("<b>(<font color=\"#ff00ff\">" + lustArrowDmg + "</font>)</b>");
				if (monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
			}
		}
		if (flags[kFLAGS.ENVENOMED_BOLTS] == 1 && player.tailVenom >= 10) {
			outputText("  ");
			if(monster.lustVuln == 0) {
				outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
			}
			if (player.tailType == TAIL_TYPE_BEE_ABDOMEN) {
				outputText("  " + monster.pronoun1 + " seems to be affected by the poison, showing increasing sign of arousal.");
				var damageB:Number = 35 + rand(player.lib/10);
				if (player.level < 10) damageB += 20 + (player.level * 3);
				else if (player.level < 20) damageB += 50 + (player.level - 10) * 2;
				else if (player.level < 30) damageB += 70 + (player.level - 20) * 1;
				else damageB += 80;
				damageB *= 0.2;
				monster.teased(monster.lustVuln * damageB);
				if (monster.hasStatusEffect(StatusEffects.NagaVenom))
				{
					monster.addStatusValue(StatusEffects.NagaVenom,3,1);
				}
				else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
				player.tailVenom -= 5;
			}
			if (player.tailType == TAIL_TYPE_SCORPION) {
				outputText("  " + monster.pronoun1 + " seems to be effected by the poison, its movement turning sluggish.");
				monster.spe -= 2;
				if (monster.spe < 1) monster.spe = 1;
				if (monster.hasStatusEffect(StatusEffects.NagaVenom))
				{
					monster.addStatusValue(StatusEffects.NagaVenom,3,1);
				}
				else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
				player.tailVenom -= 5;
			}
			if (player.tailType == TAIL_TYPE_MANTICORE_PUSSYTAIL) {
				outputText("  " + monster.pronoun1 + " seems to be affected by the poison, showing increasing sign of arousal.");
				var lustdamage:Number = 35 + rand(player.lib / 10);
				if (player.level < 10) damage += 20 + (player.level * 3);
				else if (player.level < 20) damage += 50 + (player.level - 10) * 2;
				else if (player.level < 30) damage += 70 + (player.level - 20) * 1;
				else damage += 80;
				lustdamage *= 0.14;
				monster.teased(monster.lustVuln * lustdamage);
				monster.tou -= 2;
				if (monster.tou < 1) monster.tou = 1;
				if (monster.hasStatusEffect(StatusEffects.NagaVenom))
				{
					monster.addStatusValue(StatusEffects.NagaVenom,3,1);
				}
				else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
				player.tailVenom -= 5;
			}
			if (player.faceType == FACE_SNAKE_FANGS) {
				outputText("  " + monster.pronoun1 + " seems to be effected by the poison, its movement turning sluggish.");
				monster.spe -= 0.4;
				monster.spe -= 0.4;
				if (monster.spe < 1) monster.spe = 1;
				if (monster.spe < 1) monster.spe = 1;
				if (monster.hasStatusEffect(StatusEffects.NagaVenom))
				{
					monster.addStatusValue(StatusEffects.NagaVenom,2,0.4);
					monster.addStatusValue(StatusEffects.NagaVenom,1,0.4);
				}
				else monster.createStatusEffect(StatusEffects.NagaVenom, 0.4, 0.4, 0, 0);
				player.tailVenom -= 5;
			}
			if (player.faceType == FACE_SPIDER_FANGS) {
				outputText("  " + monster.pronoun1 + " seems to be affected by the poison, showing increasing sign of arousal.");
				var lustDmg:int = 6 * monster.lustVuln;
				monster.teased(lustDmg);
				if (monster.lustVuln > 0) {
					monster.lustVuln += 0.01;
					if (monster.lustVuln > 1) monster.lustVuln = 1;
				}
				player.tailVenom -= 5;
			}
			if (monster.lust >= monster.eMaxLust()) {
				outputText("\n\n");
				checkAchievementDamage(damage);
				flags[kFLAGS.ARROWS_SHOT]++;
				bowPerkUnlock();
				doNext(endLustVictory);
			}
			outputText("\n");
		}
		if (flags[kFLAGS.ENVENOMED_BOLTS] == 1 && player.tailVenom < 10) {
			outputText("  You do not have enough venom to apply on the ");
			if (player.weaponRangePerk == "Bow") outputText("arrow");
			if (player.weaponRangePerk == "Crossbow") outputText("bolt");
			outputText(" tip!");
		}
		outputText("\n");
		flags[kFLAGS.ARROWS_SHOT]++;
		bowPerkUnlock();
	}
	else {
		outputText("The ");
		if (player.weaponRangePerk == "Bow") outputText("arrow");
		if (player.weaponRangePerk == "Crossbow") outputText("bolt");
		outputText(" goes wide, disappearing behind your foe");
		if (monster.plural) outputText("s");
		outputText(".\n\n");
	}
	if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 1) {
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such a cowardly weapon,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your pathetic ");
			if (player.weaponRangePerk == "Bow") outputText("arrow");
			if (player.weaponRangePerk == "Crossbow") outputText("bolt");
			outputText("s?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
		}
		enemyAI();
	}
	if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 2) {
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ARROWS_STYLE] -= 1;
			if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) flags[kFLAGS.ARROWS_ACCURACY] += 5;
			else flags[kFLAGS.ARROWS_ACCURACY] += 15;
			multiArrowsStrike();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 3) {
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ARROWS_STYLE] -= 1;
			if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) flags[kFLAGS.ARROWS_ACCURACY] += 5;
			else flags[kFLAGS.ARROWS_ACCURACY] += 15;
			multiArrowsStrike();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 4) {
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ARROWS_STYLE] -= 1;
			if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) flags[kFLAGS.ARROWS_ACCURACY] += 5;
			else flags[kFLAGS.ARROWS_ACCURACY] += 15;
			multiArrowsStrike();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 5) {
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ARROWS_STYLE] -= 1;
			if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) flags[kFLAGS.ARROWS_ACCURACY] += 5;
			else flags[kFLAGS.ARROWS_ACCURACY] += 15;
			multiArrowsStrike();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 6) {
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ARROWS_STYLE] -= 1;
			if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) flags[kFLAGS.ARROWS_ACCURACY] += 5;
			else flags[kFLAGS.ARROWS_ACCURACY] += 15;
			multiArrowsStrike();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
}

public function bowPerkUnlock():void {
	if(flags[kFLAGS.ARROWS_SHOT] >= 10 && player.findPerk(PerkLib.BowShooting) < 0) {
		outputText("<b>You've become more comfortable with using bow, unlocking the Bow Shooting perk and reducing fatigue cost of shooting arrows by 20%!</b>\n\n");
		player.createPerk(PerkLib.BowShooting,20,0,0,0);
	}
	if(flags[kFLAGS.ARROWS_SHOT] >= 30 && player.perkv1(PerkLib.BowShooting) < 40) {
		outputText("<b>You've become more comfortable with using bow, further reducing cost of shooting arrows by an additional 20%!</b>\n\n");
		player.setPerkValue(PerkLib.BowShooting,1,40);
	}
	if(flags[kFLAGS.ARROWS_SHOT] >= 90 && player.perkv1(PerkLib.BowShooting) < 60) {
		outputText("<b>You've become more comfortable with using bow, further reducing cost of shooting arrows by an additional 20%!</b>\n\n");
		player.setPerkValue(PerkLib.BowShooting,1,60);
	}
	if(flags[kFLAGS.ARROWS_SHOT] >= 270 && player.perkv1(PerkLib.BowShooting) < 80) {
		outputText("<b>You've become more comfortable with using bow, further reducing cost of shooting arrows by an additional 20%!</b>\n\n");
		player.setPerkValue(PerkLib.BowShooting,1,80);	
	}
}

public function throwWeapon():void {
	var fc:Number       = oneThrowTotalCost();
	var accRange:Number = 0;
	accRange += (arrowsAccuracy() / 2);
	if (flags[kFLAGS.ARROWS_ACCURACY] > 0) accRange -= flags[kFLAGS.ARROWS_ACCURACY];
	if (player.weaponRange != weaponsrange.SHUNHAR) flags[kFLAGS.FLINTLOCK_PISTOL_AMMO]--;
	fatigue(fc);
	if (rand(100) < accRange) {
		var damage:Number = 0;
		damage += player.str;
		damage += strenghtscalingbonus() * 0.2;
		if (damage < 10) damage = 10;
		if (player.findPerk(PerkLib.DeadlyThrow) >= 0) damage += player.spe;
		//Weapon addition!
		if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
		else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
		else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
		else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
		if (damage == 0) {
			if (monster.inte > 0) {
				outputText(monster.capitalA + monster.short + " shrugs as the [weaponrangename] bounces off them harmlessly.\n\n");
			}
			else {
				outputText("The [weaponrangename] bounces harmlessly off " + monster.a + monster.short + ".\n\n");
			}
		}
		if (monster.short == "pod") {
			outputText("The [weaponrangename] lodges deep into the pod's fleshy wall");
		}
		else if (monster.plural) {
			var textChooser1:int = rand(12);
			if (textChooser1 >= 9) {
				outputText(monster.capitalA + monster.short + " look down at the mark left by the [weaponrangename] on one of their bodies");
			}
			else if (textChooser1 >= 6 && textChooser1 < 9) {
				outputText("You grasps firmly [weaponrangename] and then throws it at one of " + monster.a + monster.short + "");
			}
			else if (textChooser1 >= 3 && textChooser1 < 6) {
				outputText("With one smooth motion you aim and throws your [weaponrangename] at one of your opponents");
			}
			else {
				outputText("You casually throws [weaponrangename] at one of " + monster.a + monster.short + " with supreme skill");
			}
		}
		else {
			var textChooser2:int = rand(12);
			if (textChooser2 >= 9) {
				outputText(monster.capitalA + monster.short + " looks down at the mark left by the [weaponrangename] on it body");
			}
			else if (textChooser2 >= 6) {
				outputText("You grasps firmly [weaponrangename] and then throws it at " + monster.a + monster.short + "");
			}
			else if (textChooser2 >= 3) {
				outputText("With one smooth motion you aim and throw your [weaponrangename] at your opponent");
			}
			else {
				outputText("You casually throws [weaponrangename] at " + monster.a + monster.short + " with supreme skill");
			}
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.weaponRangeName == "gnoll throwing axes") critChance += 10;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.VitalShot) >= 0 && player.inte >= 50) critChance += 10;
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (player.findPerk(PerkLib.HistoryScout) >= 0 || player.findPerk(PerkLib.PastLifeScout) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobRanger) >= 0) damage *= 1.05;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
			if (player.statusEffectv1(StatusEffects.Kelt) < 100) damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
			else {
				if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
					if (player.statusEffectv1(StatusEffects.Kindra) < 150) damage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
					else damage *= 3.5;
				}
				else damage *= 2;
			}
		}
/*		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 0.5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 0.2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 2;
		}zachowane jeśli potem dodam elemental dmg do ataków innych broni dystansowych też
*/		damage = Math.round(damage);
		damage = doDamage(damage);
		if (monster.HP <= 0) {
			if (monster.short == "pod")
				outputText(". ");
			else if (monster.plural)
				outputText(" and " + monster.pronoun1 + " stagger, collapsing onto each other from the wounds you've inflicted on " + monster.pronoun2 + ". ");
			else outputText(" and " + monster.pronoun1 + " staggers, collapsing from the wounds you've inflicted on " + monster.pronoun2 + ". ");
			outputText("<b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText("\n\n");
			checkAchievementDamage(damage);
			doNext(endHpVictory);
			return;
		}
		else {
		outputText(".  It's clearly very painful. <b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
	//	if (flaga dla efektu arouse arrow) outputText(" tekst dla arouse arrow effect.");
	//	if (flaga dla efektu poison arrow) outputText(" tekst dla poison arrow effect.");
		outputText("\n\n");
		}
		checkAchievementDamage(damage);
	}
	else {
		outputText("The [weaponrangename] goes wide, disappearing behind your foe");
		if (monster.plural) outputText("s");
		outputText(".\n\n");
	}
	if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 1 || flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] == 0) {
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such a cowardly weapon,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your pathetic ");
			if (player.weaponRangePerk == "Bow") outputText("arrow");
			if (player.weaponRangePerk == "Crossbow") outputText("bolt");
			outputText("s?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
		}
		if (flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] == 0) outputText("\n\n<b>You're out of weapons to throw in this fight.</b>\n\n");
		enemyAI();
	} else if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] > 1) {
		flags[kFLAGS.MULTIPLE_ARROWS_STYLE] -= 1;
		flags[kFLAGS.ARROWS_ACCURACY] += 15;
		throwWeapon();
	}
}

public function shootWeapon():void {
	var accRange:Number = 0;
	accRange += (arrowsAccuracy() / 2);
	if (rand(100) < accRange) {
		var damage:Number = 0;
		if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") damage += player.weaponRangeAttack * 20;
		if (player.findPerk(PerkLib.DeadlyAim) < 0) damage *= (monster.damagePercent() / 100);//jak ten perk o ignorowaniu armora bedzie czy coś to tu dać jak nie ma tego perku to sie dolicza
		//Weapon addition!
		if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
		else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
		else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
		else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
		if (damage == 0) {
			if (monster.inte > 0) {
				outputText(monster.capitalA + monster.short + " shrugs as the bullet bounces off them harmlessly.\n\n");
			}
			else {
				outputText("The bullet bounces harmlessly off " + monster.a + monster.short + ".\n\n");
			}
		}
		if (monster.short == "pod") {
			outputText("The bullet lodges deep into the pod's fleshy wall");
		}
		else if (monster.plural) {
			var textChooser1:int = rand(12);
			if (textChooser1 >= 9) {
				outputText(monster.capitalA + monster.short + " look down at the mark left by the bullet on one of their bodies");
			}
			else if (textChooser1 >= 6 && textChooser1 < 9) {
				outputText("You pull the trigger and fire the bullet at one of " + monster.a + monster.short + "");
			}
			else if (textChooser1 >= 3 && textChooser1 < 6) {
				outputText("With one smooth motion you aim and fire your deadly bullet at one of your opponents");
			}
			else {
				outputText("You casually fire an bullet at one of " + monster.a + monster.short + " with supreme skill");
			}
		}
		else {
			var textChooser2:int = rand(12);
			if (textChooser2 >= 9) {
				outputText(monster.capitalA + monster.short + " looks down at the mark left by the bullet on it body");
			}
			else if (textChooser2 >= 6) {
				outputText("You pull the trigger and fire the bullet at " + monster.a + monster.short + "");
			}
			else if (textChooser2 >= 3) {
				outputText("With one smooth motion you aim and fire your deadly bullet at your opponent");
			}
			else {
				outputText("You casually fire an bullet at " + monster.a + monster.short + " with supreme skill");
			}
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.VitalShot) >= 0 && player.inte >= 50) critChance += 10;
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (player.findPerk(PerkLib.HistoryScout) >= 0 || player.findPerk(PerkLib.PastLifeScout) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobRanger) >= 0) damage *= 1.05;
		if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
			if (player.statusEffectv1(StatusEffects.Kelt) < 100) damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
			else {
				if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
					if (player.statusEffectv1(StatusEffects.Kindra) < 150) damage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
					else damage *= 3.5;
				}
				else damage *= 2;
			}
		}
/*		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 0.5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 0.2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 2;
		}zachowane jeśli potem dodam elemental dmg do ataków innych broni dystansowych też
*/		damage = Math.round(damage);
		damage = doDamage(damage);
		if (monster.HP <= 0) {
			if (monster.short == "pod")
				outputText(". ");
			else if (monster.plural)
				outputText(" and " + monster.pronoun1 + " stagger, collapsing onto each other from the wounds you've inflicted on " + monster.pronoun2 + ". ");
			else outputText(" and " + monster.pronoun1 + " staggers, collapsing from the wounds you've inflicted on " + monster.pronoun2 + ". ");
			outputText("<b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText("\n\n");
			checkAchievementDamage(damage);
			doNext(endHpVictory);
			return;
		}
		else {
		outputText(".  It's clearly very painful. <b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
	//	if (flaga dla efektu arouse arrow) outputText(" tekst dla arouse arrow effect.");
	//	if (flaga dla efektu poison arrow) outputText(" tekst dla poison arrow effect.");
		outputText("\n\n");
		}
		checkAchievementDamage(damage);
	}
	else {
		outputText("The bullet goes wide, disappearing behind your foe");
		if (monster.plural) outputText("s");
		outputText(".\n\n");
	}
	if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such a cowardly weapon,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your pathetic weapon?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
		}
	enemyAI();
}

public function reloadWeapon():void {
	if (player.weaponRangeName == "flintlock pistol") flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 4;
	if (player.weaponRangeName == "blunderbuss rifle") flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 2;
	outputText("You open the magazine of your ");
	if (player.weaponRangeName == "flintlock pistol") outputText("pistol");
	if (player.weaponRangeName == "blunderbuss rifle") outputText("rifle");
	outputText(" to reload the ammunition.  If you too tired it would use up this turn action.\n\n");
	if(player.fatigue + (10 * flags[kFLAGS.FLINTLOCK_PISTOL_AMMO]) > player.maxFatigue()) {
		if (player.findPerk(PerkLib.RapidReload) < 0) {
			clearOutput();
			outputText("You are too tired to act in this round after reloaing your weapon.");
			enemyAI();
		}
		else doNext(combatMenu);
	}
	else {
		if (player.findPerk(PerkLib.RapidReload) < 0) fatigue(10 * flags[kFLAGS.FLINTLOCK_PISTOL_AMMO]);
		else fatigue(5 * flags[kFLAGS.FLINTLOCK_PISTOL_AMMO]);//czy całkiem usunąć koszt przeładowania?
		doNext(combatMenu);
	}
}

private function debugInspect():void {
	outputText(monster.generateDebugDescription());
	doNext(playerMenu);
}

//Fantasize
public function fantasize():void {
	var temp2:Number = 0;
	doNext(combatMenu);
	clearOutput();
	if (monster.short == "frost giant" && (player.hasStatusEffect(StatusEffects.GiantBoulder))) {
		temp2 = 10 + rand(player.lib / 5 + player.cor / 8);
		dynStats("lus", temp2, "resisted", false);
		(monster as FrostGiant).giantBoulderFantasize();
		enemyAI();
		return;
	}
	if(player.armorName == "goo armor") {
		outputText("As you fantasize, you feel Valeria rubbing her gooey body all across your sensitive skin");
		if(player.gender > 0) outputText(" and genitals");
		outputText(", arousing you even further.\n");
		temp2 = 25 + rand(player.lib/8+player.cor/8)
	}	
	else if(player.balls > 0 && player.ballSize >= 10 && rand(2) == 0) {
		outputText("You daydream about fucking " + monster.a + monster.short + ", feeling your balls swell with seed as you prepare to fuck " + monster.pronoun2 + " full of cum.\n");
		temp2 = 5 + rand(player.lib/8+player.cor/8);
		outputText("You aren't sure if it's just the fantasy, but your [balls] do feel fuller than before...\n");
		player.hoursSinceCum += 50;
	}
	else if(player.biggestTitSize() >= 6 && rand(2) == 0) {
		outputText("You fantasize about grabbing " + monster.a + monster.short + " and shoving " + monster.pronoun2 + " in between your jiggling mammaries, nearly suffocating " + monster.pronoun2 + " as you have your way.\n");
		temp2 = 5 + rand(player.lib/8+player.cor/8)
	}
	else if(player.biggestLactation() >= 6 && rand(2) == 0) {
		outputText("You fantasize about grabbing " + monster.a + monster.short + " and forcing " + monster.pronoun2 + " against a " + nippleDescript(0) + ", and feeling your milk let down.  The desire to forcefeed SOMETHING makes your nipples hard and moist with milk.\n");
		temp2 = 5 + rand(player.lib/8+player.cor/8)
	}
	else {
		clearOutput();
		outputText("You fill your mind with perverted thoughts about " + monster.a + monster.short + ", picturing " + monster.pronoun2 + " in all kinds of perverse situations with you.\n");
		temp2 = 10+rand(player.lib/5+player.cor/8);		
	}
	if(temp2 >= 20) outputText("The fantasy is so vivid and pleasurable you wish it was happening now.  You wonder if " + monster.a + monster.short + " can tell what you were thinking.\n\n");
	else outputText("\n");
	dynStats("lus", temp2, "resisted", false);
	if(player.lust >= player.maxLust()) {
		if(monster.short == "pod") {
			outputText("<b>You nearly orgasm, but the terror of the situation reasserts itself, muting your body's need for release.  If you don't escape soon, you have no doubt you'll be too fucked up to ever try again!</b>\n\n");
			player.lust = (player.maxLust() - 1);
			dynStats("lus", -25);
		}
		else {
			doNext(endLustLoss);
			return;
		}
	}
	enemyAI();	
}
public function defendpose():void {
	clearOutput();
	outputText("You decide not to take any offensive action this round preparing for " + monster.a + monster.short + " attack assuming defensive pose.\n\n");
	player.createStatusEffect(StatusEffects.Defend, 0, 0, 0, 0);
	if (player.findPerk(PerkLib.DefenceStance) >= 0) {
		fatigueRecovery();
		manaregeneration();
		soulforceregeneration();
	}
	enemyAI();
}
public function surrender():void {
	var temp3:Number = 0;
	doNext(combatMenu);
	clearOutput();
	temp3 += (player.maxLust() - player.lust);
	clearOutput();
	outputText("You fill your mind with perverted thoughts about " + monster.a + monster.short + ", picturing " + monster.pronoun2 + " in all kinds of perverse situations with you.\n");
	dynStats("lus", temp3, "resisted", false);
	doNext(endLustLoss);
}

public function fatigueRecovery():void {
	var fatiguecombatrecovery:Number = 0;
	if (player.findPerk(PerkLib.StarSphereMastery) >= 0) fatiguecombatrecovery += (player.perkv1(PerkLib.StarSphereMastery) * 2);
	if (player.findPerk(PerkLib.NinetailsKitsuneOfBalance) >= 0) fatiguecombatrecovery += 3;
	if (player.findPerk(PerkLib.EnlightenedNinetails) >= 0) fatiguecombatrecovery += 2;
	if (player.findPerk(PerkLib.CorruptedNinetails) >= 0) fatiguecombatrecovery += 2;
	if (player.findPerk(PerkLib.EnlightenedKitsune) >= 0) fatiguecombatrecovery += 1;
	if (player.findPerk(PerkLib.CorruptedKitsune) >= 0) fatiguecombatrecovery += 1;
	if (player.findPerk(PerkLib.KitsuneThyroidGland) >= 0) fatiguecombatrecovery += 1;
	if (player.findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0) fatiguecombatrecovery += 1;
	if (player.findPerk(PerkLib.MasteredDefenceStance) >= 0) fatiguecombatrecovery += 1;
	if (player.findPerk(PerkLib.PerfectDefenceStance) >= 0) fatiguecombatrecovery += 1;
	fatigue(-(1 + fatiguecombatrecovery));
}

public function attacksAccuracy():Number {
	var atkmod:Number = 100;
/*	if (player.findPerk(PerkLib.HistoryScout) >= 0 || player.findPerk(PerkLib.PastLifeScout) >= 0) accmod += 40;
	if (player.findPerk(PerkLib.Accuracy1) >= 0) {
		accmod += player.perkv1(PerkLib.Accuracy1);
	}
	if (player.findPerk(PerkLib.Accuracy2) >= 0) {
		accmod -= player.perkv1(PerkLib.Accuracy2);
	}
	if (player.inte > 50 && player.findPerk(PerkLib.JobHunter) >= 0) {
		if (player.inte <= 150) atkmod += (player.inte - 50);
		else atkmod += 100;
	}
	if (player.findPerk(PerkLib.CarefulButRecklessAimAndShooting) >= 0) atkmod += 60;
*/	return atkmod;
}

public function strenghtscalingbonus():Number {
	var strenghtscalingvalue:Number = 0;
	if (player.str >= 21) strenghtscalingvalue += player.str - 20;
	if (player.str >= 41) strenghtscalingvalue += player.str - 40;
	if (player.str >= 61) strenghtscalingvalue += player.str - 60;
	if (player.str >= 81) strenghtscalingvalue += player.str - 80;
	if (player.str >= 101) strenghtscalingvalue += player.str - 100;
	if (player.str >= 151) strenghtscalingvalue += player.str - 150;
	if (player.str >= 201) strenghtscalingvalue += player.str - 200;
	if (player.str >= 251) strenghtscalingvalue += player.str - 250;
	if (player.str >= 301) strenghtscalingvalue += player.str - 300;
	if (player.str >= 351) strenghtscalingvalue += player.str - 350;
	if (player.str >= 401) strenghtscalingvalue += player.str - 400;
	if (player.str >= 451) strenghtscalingvalue += player.str - 450;
	if (player.str >= 501) strenghtscalingvalue += player.str - 500;
	if (player.str >= 551) strenghtscalingvalue += player.str - 550;
	if (player.str >= 601) strenghtscalingvalue += player.str - 600;
	if (player.str >= 651) strenghtscalingvalue += player.str - 650;
	if (player.str >= 701) strenghtscalingvalue += player.str - 700;
	if (player.str >= 751) strenghtscalingvalue += player.str - 750;
	if (player.str >= 801) strenghtscalingvalue += player.str - 800;
	if (player.str >= 851) strenghtscalingvalue += player.str - 850;
	if (player.str >= 901) strenghtscalingvalue += player.str - 900;
	if (player.str >= 951) strenghtscalingvalue += player.str - 950;
	if (player.str >= 1001) strenghtscalingvalue += player.str - 1000;
	if (player.str >= 1051) strenghtscalingvalue += player.str - 1050;
	if (player.str >= 1101) strenghtscalingvalue += player.str - 1100;
	if (player.str >= 1151) strenghtscalingvalue += player.str - 1150;
	if (player.str >= 1201) strenghtscalingvalue += player.str - 1200;
	return strenghtscalingvalue;
}
public function inteligencescalingbonus():Number {
		var inteligencescalingvalue:Number = 0;
		if (player.inte >= 21 && player.inte < 41) inteligencescalingvalue += (player.inte / 2 + rand((player.inte * 3) / 4));
		if (player.inte >= 41 && player.inte < 61) inteligencescalingvalue += ((player.inte * 2) / 3 + rand(player.inte));
		if (player.inte >= 61 && player.inte < 81) inteligencescalingvalue += ((player.inte * 5) / 6 + rand(player.inte * 1.25));
		if (player.inte >= 81 && player.inte < 101) inteligencescalingvalue += (player.inte + rand(player.inte * 1.5));
		if (player.inte >= 101 && player.inte < 151) inteligencescalingvalue += ((player.inte * 1.25) + rand(player.inte * 1.75));
		if (player.inte >= 151 && player.inte < 201) inteligencescalingvalue += ((player.inte * 1.5) + rand(player.inte * 2));
		if (player.inte >= 201 && player.inte < 251) inteligencescalingvalue += ((player.inte * 1.75) + rand(player.inte * 2.25));
		if (player.inte >= 251 && player.inte < 301) inteligencescalingvalue += ((player.inte * 2) + rand(player.inte * 2.5));
		if (player.inte >= 301 && player.inte < 351) inteligencescalingvalue += ((player.inte * 2.25) + rand(player.inte * 2.75));
		if (player.inte >= 351 && player.inte < 401) inteligencescalingvalue += ((player.inte * 2.5) + rand(player.inte * 3));
		if (player.inte >= 401 && player.inte < 451) inteligencescalingvalue += ((player.inte * 2.75) + rand(player.inte * 3.25));
		if (player.inte >= 451 && player.inte < 501) inteligencescalingvalue += ((player.inte * 3) + rand(player.inte * 3.5));
		if (player.inte >= 501 && player.inte < 551) inteligencescalingvalue += ((player.inte * 3.25) + rand(player.inte * 3.75));
		if (player.inte >= 551 && player.inte < 601) inteligencescalingvalue += ((player.inte * 3.5) + rand(player.inte * 4));
		if (player.inte >= 601 && player.inte < 651) inteligencescalingvalue += ((player.inte * 3.75) + rand(player.inte * 4.25));
		if (player.inte >= 651 && player.inte < 701) inteligencescalingvalue += ((player.inte * 4) + rand(player.inte * 4.5));
		if (player.inte >= 701 && player.inte < 751) inteligencescalingvalue += ((player.inte * 4.25) + rand(player.inte * 4.75));
		if (player.inte >= 751 && player.inte < 801) inteligencescalingvalue += ((player.inte * 4.5) + rand(player.inte * 5));
		if (player.inte >= 801 && player.inte < 851) inteligencescalingvalue += ((player.inte * 4.75) + rand(player.inte * 5.25));
		if (player.inte >= 851 && player.inte < 901) inteligencescalingvalue += ((player.inte * 5) + rand(player.inte * 5.5));
		if (player.inte >= 901 && player.inte < 951) inteligencescalingvalue += ((player.inte * 5.25) + rand(player.inte * 5.75));
		if (player.inte >= 951 && player.inte < 1001) inteligencescalingvalue += ((player.inte * 5.5) + rand(player.inte * 6));
		if (player.inte >= 1001 && player.inte < 1051) inteligencescalingvalue += ((player.inte * 5.75) + rand(player.inte * 6.25));
		if (player.inte >= 1051 && player.inte < 1101) inteligencescalingvalue += ((player.inte * 6) + rand(player.inte * 6.5));
		if (player.inte >= 1101 && player.inte < 1151) inteligencescalingvalue += ((player.inte * 6.25) + rand(player.inte * 6.75));
		if (player.inte >= 1151 && player.inte < 1201) inteligencescalingvalue += ((player.inte * 6.5) + rand(player.inte * 7));
		if (player.inte >= 1201) inteligencescalingvalue += ((player.inte * 6.75) + rand(player.inte * 7.25));
		else inteligencescalingvalue += (player.inte/3 + rand(player.inte/2));
		return inteligencescalingvalue;
}
public function libidoscalingbonus():Number {
		var libidoscalingvalue:Number = 0;
		if (player.lib >= 21 && player.lib < 41) libidoscalingvalue += (player.lib / 2 + rand((player.lib * 3) / 4));
		if (player.lib >= 41 && player.lib < 61) libidoscalingvalue += ((player.lib * 2) / 3 + rand(player.lib));
		if (player.lib >= 61 && player.lib < 81) libidoscalingvalue += ((player.lib * 5) / 6 + rand(player.lib * 1.25));
		if (player.lib >= 81 && player.lib < 101) libidoscalingvalue += (player.lib + rand(player.lib * 1.5));
		if (player.lib >= 101 && player.lib < 151) libidoscalingvalue += ((player.lib * 1.25) + rand(player.lib * 1.75));
		if (player.lib >= 151 && player.lib < 201) libidoscalingvalue += ((player.lib * 1.5) + rand(player.lib * 2));
		if (player.lib >= 201 && player.lib < 251) libidoscalingvalue += ((player.lib * 1.75) + rand(player.lib * 2.25));
		if (player.lib >= 251 && player.lib < 301) libidoscalingvalue += ((player.lib * 2) + rand(player.lib * 2.5));
		if (player.lib >= 301 && player.lib < 351) libidoscalingvalue += ((player.lib * 2.25) + rand(player.lib * 2.75));
		if (player.lib >= 351 && player.lib < 401) libidoscalingvalue += ((player.lib * 2.5) + rand(player.lib * 3));
		if (player.lib >= 401 && player.lib < 451) libidoscalingvalue += ((player.lib * 2.75) + rand(player.lib * 3.25));
		if (player.lib >= 451 && player.lib < 501) libidoscalingvalue += ((player.lib * 3) + rand(player.lib * 3.5));
		if (player.lib >= 501 && player.lib < 551) libidoscalingvalue += ((player.lib * 3.25) + rand(player.lib * 3.75));
		if (player.lib >= 551 && player.lib < 601) libidoscalingvalue += ((player.lib * 3.5) + rand(player.lib * 4));
		if (player.lib >= 601 && player.lib < 651) libidoscalingvalue += ((player.lib * 3.75) + rand(player.lib * 4.25));
		if (player.lib >= 651 && player.lib < 701) libidoscalingvalue += ((player.lib * 4) + rand(player.lib * 4.5));
		if (player.lib >= 701 && player.lib < 751) libidoscalingvalue += ((player.lib * 4.25) + rand(player.lib * 4.75));
		if (player.lib >= 751 && player.lib < 801) libidoscalingvalue += ((player.lib * 4.5) + rand(player.lib * 5));
		if (player.lib >= 801 && player.lib < 851) libidoscalingvalue += ((player.lib * 4.75) + rand(player.lib * 5.25));
		if (player.lib >= 851 && player.lib < 901) libidoscalingvalue += ((player.lib * 5) + rand(player.lib * 5.5));
		if (player.lib >= 901 && player.lib < 951) libidoscalingvalue += ((player.lib * 5.25) + rand(player.lib * 5.75));
		if (player.lib >= 951 && player.lib < 1001) libidoscalingvalue += ((player.lib * 5.5) + rand(player.lib * 6));
		if (player.lib >= 1001 && player.lib < 1051) libidoscalingvalue += ((player.lib * 5.75) + rand(player.lib * 6.25));
		if (player.lib >= 1051 && player.lib < 1101) libidoscalingvalue += ((player.lib * 6) + rand(player.lib * 6.5));
		if (player.lib >= 1101 && player.lib < 1151) libidoscalingvalue += ((player.lib * 6.25) + rand(player.lib * 6.75));
		if (player.lib >= 1151 && player.lib < 1201) libidoscalingvalue += ((player.lib * 6.5) + rand(player.lib * 7));
		if (player.lib >= 1201) libidoscalingvalue += ((player.lib * 6.75) + rand(player.lib * 7.25));
		else libidoscalingvalue += (player.lib / 3 + rand(player.lib / 2));
		return libidoscalingvalue;
}

//ATTACK
public function attack():void {
	flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
//	if(!player.hasStatusEffect(StatusEffects.FirstAttack)) {
//		clearOutput();
//		fatigueRecovery();
//	}
	if(player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 0 && !isWieldingRangedWeapon()) {
		outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  The kitsune's seals have made normal melee attack impossible!  Maybe you could try something else?\n\n");
		enemyAI();
		return;
	}
	if(player.hasStatusEffect(StatusEffects.Sealed2) && player.statusEffectv2(StatusEffects.Sealed2) == 0) {
		outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Recent enemy attack have made normal melee attack impossible!  Maybe you could try something else?\n\n");
		enemyAI();
		return;
	}
	if(flags[kFLAGS.PC_FETISH] >= 3 && !kGAMECLASS.urtaQuest.isUrta() && !isWieldingRangedWeapon()) {
		outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Ceraph's piercings have made normal melee attack impossible!  Maybe you could try something else?\n\n");
		enemyAI();
		return;
	}
	//Amily!
	if(monster.hasStatusEffect(StatusEffects.Concentration) && !isWieldingRangedWeapon()) {
		clearOutput();
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
		enemyAI();
		return;
	}
	if(monster.hasStatusEffect(StatusEffects.Level) && !player.hasStatusEffect(StatusEffects.FirstAttack) && !isWieldingRangedWeapon()) {
		if (monster is SandTrap) {
			outputText("It's all or nothing!  With a bellowing cry you charge down the treacherous slope and smite the sandtrap as hard as you can!  ");
			(monster as SandTrap).trapLevel(-4);
		}
		if (monster is Alraune) {
			outputText("It’s all or nothing!  If this leafy woman is so keen on pulling you in, you will let her do just that!  You use her own strength against her, using it to increase your momentum as you leap towards her and smash into her with your weapon!  ");
			(monster as Alraune).trapLevel(-6);
		}
	}
	/*if(player.findPerk(PerkLib.DoubleAttack) >= 0 && player.spe >= 50 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] < 2) {
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
	else if(kGAMECLASS.urtaQuest.isUrta()) {
		if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
			player.removeStatusEffect(StatusEffects.FirstAttack);
		}
		else {
			player.createStatusEffect(StatusEffects.FirstAttack,0,0,0,0);
			outputText("Utilizing your skills as a bareknuckle brawler, you make two attacks!\n");
		}
	}
	//Blind
	if(player.hasStatusEffect(StatusEffects.Blind)) {
		outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ");
	}
	if (monster is Basilisk && player.findPerk(PerkLib.BasiliskResistance) < 0 && !isWieldingRangedWeapon()) {
		if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind))
			outputText("Blind basilisk can't use his eyes, so you can actually aim your strikes!  ");
		//basilisk counter attack (block attack, significant speed loss): 
		else if(player.inte/5 + rand(20) < 25) {
			outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You find yourself staring directly into the basilisk's face!  Quickly you snap your eyes shut and recoil backwards, swinging madly at the lizard to force it back, but the damage has been done; you can see the terrible grey eyes behind your closed lids, and you feel a great weight settle on your bones as it becomes harder to move.");
			Basilisk.basiliskSpeed(player,20);
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
	if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
		(monster as FrostGiant).giantBoulderHit(0);
		enemyAI();
		return;
	}
	//Worms are special
	if(monster.short == "worms") {
		//50% chance of hit (int boost)
		if(rand(100) + player.inte/3 >= 50) {
			temp = int(player.str/5 - rand(5));
			if(temp == 0) temp = 1;
			outputText("You strike at the amalgamation, crushing countless worms into goo, dealing <b><font color=\"#800000\">" + temp + "</font></b> damage.\n\n");
			monster.HP -= temp;
			if(monster.HP <= 0) {
				doNext(endHpVictory);
				return;
			}
		}
		//Fail
		else {
			outputText("You attempt to crush the worms with your reprisal, only to have the collective move its individual members, creating a void at the point of impact, leaving you to attack only empty air.\n\n");
		}
		if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
			attack();
			return;
		}
		enemyAI();
		return;
	}
	
	var damage:Number = 0;
	//Determine if dodged!
	if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
		//Akbal dodges special education
		if(monster.short == "Akbal") outputText("Akbal moves like lightning, weaving in and out of your furious strikes with the speed and grace befitting his jaguar body.\n");
		else if(monster.short == "plain girl") outputText("You wait patiently for your opponent to drop her guard. She ducks in and throws a right cross, which you roll away from before smacking your [weapon] against her side. Astonishingly, the attack appears to phase right through her, not affecting her in the slightest. You glance down to your [weapon] as if betrayed.\n");
		else if(monster.short == "kitsune") {
			//Player Miss:
			outputText("You swing your [weapon] ferociously, confident that you can strike a crushing blow.  To your surprise, you stumble awkwardly as the attack passes straight through her - a mirage!  You curse as you hear a giggle behind you, turning to face her once again.\n\n");
		}
		else {
			if (player.weapon == weapons.HNTCANE && rand(2) == 0) {
				if (rand(2) == 0) outputText("You slice through the air with your cane, completely missing your enemy.");
				else outputText("You lunge at your enemy with the cane.  It glows with a golden light but fails to actually hit anything.");
			}
			if(monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if(monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if(monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			outputText("\n");
			if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
				attack();
				return;
			}
			else outputText("\n");
		}
		enemyAI();
		return;
	}
	//BLOCKED ATTACK:
	if(monster.hasStatusEffect(StatusEffects.Earthshield) && rand(4) == 0) {
		outputText("Your strike is deflected by the wall of sand, dirt, and rock!  Damn!\n");
		if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
			attack();
			return;
		}
		else outputText("\n");
		enemyAI();
		return;
	}
	//------------
	// DAMAGE
	//------------
	//Determine damage
	//BASIC DAMAGE STUFF
	
	damage += player.str;
	damage += strenghtscalingbonus() * 0.25;
	if (player.findPerk(PerkLib.HoldWithBothHands) >= 0 && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
	if (damage < 10) damage = 10;
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1 && flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] >= 2) damage *= 0.95;
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 2 && flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] >= 3) damage *= 0.9;
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 3 && flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] >= 4) damage *= 0.85;
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 4 && flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] >= 5) damage *= 0.8;
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 5 && flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] >= 6) damage *= 0.75;
	
	//Weapon addition!
	if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.03));
	else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (2.5 + ((player.weaponAttack - 50) * 0.025));
	else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (3.75 + ((player.weaponAttack - 100) * 0.02));
	else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (4.75 + ((player.weaponAttack - 150) * 0.015));
	else damage *= (5.5 + ((player.weaponAttack - 200) * 0.01));
	//Bonus sand trap damage!
	if (monster.hasStatusEffect(StatusEffects.Level) && (monster is SandTrap || monster is Alraune)) damage = Math.round(damage * 1.75);
	//All special weapon effects like...fire/ice
	if (player.weapon == weapons.L_WHIP) {
		if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
		if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
	}
	if (player.weapon == weapons.RCLAYMO && player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
		if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
		if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
	}
	if (player.weapon == weapons.SCLAYMO && player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
		if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 0.2;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 0.5;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 2;
		if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 5;
	}
	//Determine if critical hit!
	var crit:Boolean = false;
	var critChance:int = 5;
	if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
		if (player.inte <= 100) critChance += (player.inte - 50) / 5;
		if (player.inte > 100) critChance += 10;
	}
	if (player.findPerk(PerkLib.JobDervish) >= 0 && (player.weaponPerk != "Large" || player.weaponPerk != "Staff")) critChance += 10;
	if (player.findPerk(PerkLib.WeaponMastery) >= 0 && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
	if (player.findPerk(PerkLib.WeaponGrandMastery) >= 0 && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
	if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
	if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
	if (rand(100) < critChance) {
		crit = true;
		if (player.findPerk(PerkLib.Impale) >= 0 && (player.findPerk(PerkLib.DoubleAttack) < 0 || (player.findPerk(PerkLib.DoubleAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && (player.weaponName == "deadly spear" || player.weaponName == "deadly lance" || player.weaponName == "deadly trident")) damage *= 2.5;
		else damage *= 1.75;
	}
	//Apply AND DONE!
	damage *= (monster.damagePercent(false, true) / 100);
	//Damage post processing!
	//Thunderous Strikes
	if(player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80)
		damage *= 1.2;
		
	if (player.findPerk(PerkLib.ChiReflowMagic) >= 0) damage *= UmasShop.NEEDLEWORK_MAGIC_REGULAR_MULTI;
	if (player.findPerk(PerkLib.ChiReflowAttack) >= 0) damage *= UmasShop.NEEDLEWORK_ATTACK_REGULAR_MULTI;
	if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
	if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
	if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
	//One final round
	damage = Math.round(damage);
	
	//ANEMONE SHIT
	if(monster.short == "anemone" && !isWieldingRangedWeapon()) {
		//hit successful:
		//special event, block (no more than 10-20% of turns, also fails if PC has >75 corruption):
		if(rand(10) <= 1) {
			outputText("Seeing your [weapon] raised, the anemone looks down at the water, angles her eyes up at you, and puts out a trembling lip.  ");
			if(player.cor < 75) {
				outputText("You stare into her hangdog expression and lose most of the killing intensity you had summoned up for your attack, stopping a few feet short of hitting her.\n");
				damage = 0;
				//Kick back to main if no damage occured!
				if(monster.HP > 0 && monster.lust < monster.eMaxLust()) {
					if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
						attack();
						return;
					}
					enemyAI();
				}
				else {
					if(monster.HP <= 0) doNext(endHpVictory);
					else doNext(endLustVictory);
				}
				return;
			}
			else outputText("Though you lose a bit of steam to the display, the drive for dominance still motivates you to follow through on your swing.");
		}
	}
	if(monster.short == "sea anemone" && !isWieldingRangedWeapon()) {
		//hit successful:
		//special event, block (no more than 10-20% of turns, also fails if PC has >75 corruption):
		if(rand(10) <= 1) {
			outputText("Seeing your [weapon] raised, the anemone looks down at the water, angles her eyes up at you, and puts out a trembling lip.  ");
			if(player.cor < 75) {
				outputText("You stare into her hangdog expression and lose most of the killing intensity you had summoned up for your attack, stopping a few feet short of hitting her.\n");
				damage = 0;
				//Kick back to main if no damage occured!
				if(monster.HP > 0 && monster.lust < monster.eMaxLust()) {
					if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
						attack();
						return;
					}
					enemyAI();
				}
				else {
					if(monster.HP <= 0) doNext(endHpVictory);
					else doNext(endLustVictory);
				}
				return;
			}
			else outputText("Though you lose a bit of steam to the display, the drive for dominance still motivates you to follow through on your swing.");
		}
	}

	// Have to put it before doDamage, because doDamage applies the change, as well as status effects and shit.
	if (monster is Doppleganger)
	{
		if (!monster.hasStatusEffect(StatusEffects.Stunned))
		{
			if (damage > 0 && player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
			if (damage > 0 && player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
			if (damage > 0 && player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
			if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
			if (damage > 0) damage = doDamage(damage, false);
		
			(monster as Doppleganger).mirrorAttack(damage);
			return;
		}
		
		// Stunning the doppleganger should now "buy" you another round.
	}
	if (player.weapon == weapons.HNTCANE) {
		switch(rand(2)) {
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
	if(damage > 0) {
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		damage = doDamage(damage);
	}
	if(damage <= 0) {
		damage = 0;
		outputText("Your attacks are deflected or blocked by " + monster.a + monster.short + ".");
	}
	else {
		outputText("You hit " + monster.a + monster.short + "! ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
	}
	if (player.findPerk(PerkLib.BrutalBlows) >= 0 && player.str > 75) {
		if (monster.armorDef > 0) outputText("\nYour hits are so brutal that you damage " + monster.a + monster.short + "'s defenses!");
		if (monster.armorDef - 5 > 0) monster.armorDef -= 5;
		else monster.armorDef = 0;
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
	if(damage > 0) {
		//Lust raised by anemone contact!
		if(monster.short == "anemone" && !isWieldingRangedWeapon()) {
			outputText("\nThough you managed to hit the anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
			//(gain lust, temp lose str/spd)
			(monster as Anemone).applyVenom((1 + rand(2)));
		}
		if(monster.short == "sea anemone" && !isWieldingRangedWeapon()) {
			outputText("\nThough you managed to hit the sea anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
			//(gain lust, temp lose str/spd)
			(monster as SeaAnemone).applyVenom((1+rand(2)));
		}
		
		//Lust raising weapon bonuses
		if(monster.lustVuln > 0) {
			if(player.weaponPerk == "Aphrodisiac Weapon" || player.weapon == weapons.DEPRAVA || player.weapon == weapons.ASCENSU) {
				outputText("\n" + monster.capitalA + monster.short + " shivers as your weapon's 'poison' goes to work.");
				monster.teased(monster.lustVuln * (5 + player.cor / 10));
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
				whipLustSelf = (rand(2) == 0)?0:1; // 50% +1
			} else if (player.weapon == weapons.L_WHIP) {
				whipLustDmg = (10 + player.cor / 5) * (hasArcaneLash ? 2.0 : 1); // 10-30 (20-60 w/perk)
				whipCorSelf = 0.6;
				whipLustSelf = (rand(4) == 0) ? 0 : 1; // 75% +1
			}
			if (whipLustDmg > 0) {
				var s:String = monster.plural?"":"s";
				if (rand(2) == 0) {
					outputText("\n" + monster.capitalA + monster.short + " shiver" +s+" and get" +s +" turned on from the whipping.");
				} else {
					outputText("\n" + monster.capitalA + monster.short + " shiver" +s +" and moan" +s +" involuntarily from the whip's touches.");
				}
				if(whipCorSelf > 0 && player.cor < 90) dynStats("cor", whipCorSelf);
				monster.teased(monster.lustVuln * whipLustDmg);
				if(whipLustSelf > 0) {
					outputText(" You get a sexual thrill from it. ");
					dynStats("lus", whipLustSelf);
				}
			}
		}
		//Selfcorrupting weapons
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		//Weapon Procs!
		//10% Stun chance
		if ((player.weapon == weapons.WARHAMR || player.weapon == weapons.D_WHAM_ || player.weapon == weapons.OTETSU || player.weapon == weapons.S_GAUNT) && rand(10) == 0 && monster.findPerk(PerkLib.Resolute) < 0) {
			outputText("\n" + monster.capitalA + monster.short + " reels from the brutal blow, stunned.");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) monster.createStatusEffect(StatusEffects.Stunned,rand(2),0,0,0);
		}
		//50% Bleed chance
		if ((player.weapon == weapons.H_GAUNT || player.weapon == weapons.CNTWHIP) && rand(2) == 0 && monster.armorDef < 10 && !monster.hasStatusEffect(StatusEffects.IzmaBleed))
		{
			if (monster.findPerk(PerkLib.EnemyConstructType) >= 0) {
				if (monster is LivingStatue)
				{
					outputText("Despite the rents you've torn in its stony exterior, the statue does not bleed.");
				}
				else outputText("Despite the rents you've torn in its exterior, " + monster.a + monster.short + " does not bleed.");
			}
			else
			{
				monster.createStatusEffect(StatusEffects.IzmaBleed,3,0,0,0);
				if(monster.plural) outputText("\n" + monster.capitalA + monster.short + " bleed profusely from the many bloody gashes your [weapon] leave behind.");
				else outputText("\n" + monster.capitalA + monster.short + " bleeds profusely from the many bloody gashes your [weapon] leave behind.");
			}
		}
	}
	
	if (monster is JeanClaude && !player.hasStatusEffect(StatusEffects.FirstAttack))
	{
		if (monster.HP < 1 || monster.lust > monster.eMaxLust())
		{
			// noop
		}
		if (player.lust <= 30)
		{
			outputText("\n\nJean-Claude doesn’t even budge when you wade into him with your [weapon].");

			outputText("\n\n“<i>Why are you attacking me, slave?</i>” he says. The basilisk rex sounds genuinely confused. His eyes pulse with hot, yellow light, reaching into you as he opens his arms, staring around as if begging the crowd for an explanation. “<i>You seem lost, unable to understand, lashing out at those who take care of you. Don’t you know who you are? Where you are?</i>” That compulsion in his eyes, that never-ending heat, it’s... it’s changing things. You need to finish this as fast as you can.");
		}
		else if (player.lust <= 50)
		{
			outputText("\n\nAgain your [weapon] thumps into Jean-Claude. Again it feels wrong. Again it sends an aching chime through you, that you are doing something that revolts your nature.");

			outputText("\n\n“<i>Why are you fighting your master, slave?</i>” he says. He is bigger than he was before. Or maybe you are smaller. “<i>You are confused. Put your weapon down- you are no warrior, you only hurt yourself when you flail around with it. You have forgotten what you were trained to be. Put it down, and let me help you.</i>” He’s right. It does hurt. Your body murmurs that it would feel so much better to open up and bask in the golden eyes fully, let it move you and penetrate you as it may. You grit your teeth and grip your [weapon] harder, but you can’t stop the warmth the hypnotic compulsion is building within you.");
		}
		else if (player.lust <= 80)
		{
			outputText("\n\n“<i>Do you think I will be angry at you?</i>” growls Jean-Claude lowly. Your senses feel intensified, his wild, musky scent rich in your nose. It’s hard to concentrate... or rather it’s hard not to concentrate on the sweat which runs down his hard, defined frame, the thickness of his bulging cocks, the assured movement of his powerful legs and tail, and the glow, that tantalizing, golden glow, which pulls you in and pushes so much delicious thought and sensation into your head…  “<i>I am not angry. You will have to be punished, yes, but you know that is only right, that in the end you will accept and enjoy being corrected. Come now, slave. You only increase the size of the punishment with this silliness.</i>”");
		}
		else
		{
			outputText("\n\nYou can’t... there is a reason why you keep raising your weapon against your master, but what was it? It can’t be that you think you can defeat such a powerful, godly alpha male as him. And it would feel so much better to supplicate yourself before the glow, lose yourself in it forever, serve it with your horny slut body, the only thing someone as low and helpless as you could possibly offer him. Master’s mouth is moving but you can no longer tell where his voice ends and the one in your head begins... only there is a reason you cling to like you cling onto your [weapon], whatever it is, however stupid and distant it now seems, a reason to keep fighting...");
		}
		
		dynStats("lus", 25);
	}
	
	outputText("\n");
	checkAchievementDamage(damage);
	meleeattackdamage();
}
public function meleeattackdamage():void {
	if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 1) {
		WrathWeaponsProc();
		if(monster.HP >= 1 && monster.lust <= monster.eMaxLust()) {
			if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
				attack();
				return;
			}
			outputText("\n");
			fatigueRecovery();
			manaregeneration();
			soulforceregeneration();
			enemyAI();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			else doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 2) {
		WrathWeaponsProc();
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] -= 1;
		//	flags[kFLAGS.ATTACKS_ACCURACY] += 15;
			attack();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 3) {
		WrathWeaponsProc();
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] -= 1;
		//	flags[kFLAGS.ATTACKS_ACCURACY] += 15;
			attack();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 4) {
		WrathWeaponsProc();
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] -= 1;
		//	flags[kFLAGS.ATTACKS_ACCURACY] += 15;
			attack();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 5) {
		WrathWeaponsProc();
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] -= 1;
		//	flags[kFLAGS.ATTACKS_ACCURACY] += 15;
			attack();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 6) {
		WrathWeaponsProc();
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] -= 1;
		//	flags[kFLAGS.ATTACKS_ACCURACY] += 15;
			attack();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 7) {
		WrathWeaponsProc();
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] -= 1;
		//	flags[kFLAGS.ATTACKS_ACCURACY] += 15;
			attack();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 8) {
		WrathWeaponsProc();
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] -= 1;
		//	flags[kFLAGS.ATTACKS_ACCURACY] += 15;
			attack();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 9) {
		WrathWeaponsProc();
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] -= 1;
		//	flags[kFLAGS.ATTACKS_ACCURACY] += 15;
			attack();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 10) {
		WrathWeaponsProc();
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] -= 1;
		//	flags[kFLAGS.ATTACKS_ACCURACY] += 15;
			attack();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 11) {
		WrathWeaponsProc();
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] -= 1;
		//	flags[kFLAGS.ATTACKS_ACCURACY] += 15;
			attack();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
	if (flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] == 12) {
		WrathWeaponsProc();
		if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			flags[kFLAGS.MULTIPLE_ATTACKS_STYLE] -= 1;
		//	flags[kFLAGS.ATTACKS_ACCURACY] += 15;
			attack();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
}

public function WrathWeaponsProc():void {
	if (player.isLowGradeWrathWeapon()) {
		if (player.findPerk(PerkLib.PrestigeJobBerserker) >= 0 && player.wrath >= 10) player.wrath -= 10;
		else {
			takeDamage(100);
			if (player.HP < 1) {
				doNext(endHpLoss);
				return;
			}
		}
	}
}

public function combatMiss():Boolean {
	return player.spe - monster.spe > 0 && int(Math.random() * (((player.spe - monster.spe) / 4) + 80)) > 80;
}
public function combatParry():Boolean {
	var parryChance:int = 0;
	if (player.findPerk(PerkLib.Parry) >= 0 && player.spe >= 50 && player.str >= 50 && player.weapon != WeaponLib.FISTS) {
		if (player.spe <= 100) parryChance += (player.spe - 50) / 5;
		else parryChance += 10;
	}
	if (player.findPerk(PerkLib.CatchTheBlade) >= 0 && player.spe >= 50 && player.shieldName == "nothing" && player.isFistOrFistWeapon()) parryChance += 15;
	return rand(100) <= parryChance;
//	trace("Parried!");
}
public function combatCritical():Boolean {
	var critChance:int = 4;
	if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
		if (player.inte <= 100) critChance += (player.inte - 50) / 50;
		if (player.inte > 100) critChance += 1;
	}
	if (player.findPerk(PerkLib.Blademaster) >= 0 && (player.weaponVerb == "slash" || player.weaponVerb == "cleave" || player.weaponVerb == "keen cut")) critChance += 5;
	return rand(100) <= critChance;
}

public function combatBlock(doFatigue:Boolean = false):Boolean {
	//Set chance
	var blockChance:int = 20 + player.shieldBlock + Math.floor((player.str - monster.str) / 5);
	if (player.findPerk(PerkLib.ShieldMastery) >= 0 && player.tou >= 50) {
		if (player.tou < 100) blockChance += (player.tou - 50) / 5;
		else blockChance += 10;
	}
	if (player.findPerk(PerkLib.ShieldGrandmastery) >= 0 && player.tou >= 100) {
		if (player.tou < 150) blockChance += (player.tou - 100) / 5;
		else blockChance += 10;
	}
	if (blockChance < 10) blockChance = 10;
	//Fatigue limit
	var fatigueLimit:int = player.maxFatigue() - physicalCost(10);
	if (blockChance >= (rand(100) + 1) && player.fatigue <= fatigueLimit && player.shieldName != "nothing") {
		if (doFatigue) {
			if (player.findPerk(PerkLib.ShieldGrandmastery) >= 0 && player.tou >= 100) fatigue(5);
			else fatigue(10);
		}
		return true;
	}
	else return false;
}
public function isWieldingRangedWeapon():Boolean {
	if (player.weaponName.indexOf("staff") != -1 && player.findPerk(PerkLib.StaffChanneling) >= 0) return true;
	else return false;
}

//DEAL DAMAGE
public function doDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
	if (player.findPerk(PerkLib.Sadist) >= 0) {
		damage *= 1.2;
		dynStats("lus", 3);
	}
	if (player.findPerk(PerkLib.Anger) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
		var bonusDamageFromMissingHP:Number = 1;
		if (PlayerHPRatio() < 1) bonusDamageFromMissingHP += 1 - PlayerHPRatio();
		damage *= bonusDamageFromMissingHP;
	}
	if (monster.HP - damage <= 0) {
		/* No monsters use this perk, so it's been removed for now
		if(monster.findPerk(PerkLib.LastStrike) >= 0) doNext(monster.perk(monster.findPerk(PerkLib.LastStrike)).value1);
		else doNext(endHpVictory);
		*/
		doNext(endHpVictory);
	}
	
	// Uma's Massage Bonuses
	var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
	if (sac)
	{
		if (sac.value1 == UmasShop.MASSAGE_POWER)
		{
			damage *= sac.value2;
		}
	}
	
	damage = Math.round(damage);
	
	if(damage < 0) damage = 1;
	if (apply) monster.HP -= damage;
	if (display) {
		if (damage > 0) outputText("<b>(<font color=\"#800000\">" + temp + "</font>)</b>"); //Damage
		else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + temp + "</font>)</b>"); //Miss/block
		else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + temp + "</font>)</b>"); //Heal
	}
	//Isabella gets mad
	if(monster.short == "Isabella") {
		flags[kFLAGS.ISABELLA_AFFECTION]--;
		//Keep in bounds
		if(flags[kFLAGS.ISABELLA_AFFECTION] < 0) flags[kFLAGS.ISABELLA_AFFECTION] = 0;
	}
	//Interrupt gigaflare if necessary.
	if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
	//Keep shit in bounds.
	if(monster.HP < 0) monster.HP = 0;
	return damage;
}

public function takeDamage(damage:Number, display:Boolean = false):Number {
	return player.takeDamage(damage, display);
}
	public static const USEMANA_NORMAL:int = 0;
	public static const USEMANA_MAGIC:int = 1;
	public static const USEMANA_PHYSICAL:int = 2;
	public static const USEMANA_MAGIC_NOBM:int = 3;
	public static const USEMANA_BOW:int = 4;
	public static const USEMANA_WHITE:int = 5;
	public static const USEMANA_BLACK:int = 6;
	public static const USEMANA_WHITE_NOBM:int = 7;
	public static const USEMANA_BLACK_NOBM:int = 8;
	//Modify mana (mod>0 - subtract, mod<0 - regen)
	public function useManaImpl(mod:Number,type:int=USEMANA_NORMAL):void {
		//Spell reductions
		switch (type) {
			case USEMANA_MAGIC:
			case USEMANA_MAGIC_NOBM:
				mod = spellCost(mod);
				break;
			case USEMANA_WHITE:
			case USEMANA_WHITE_NOBM:
				mod = spellCostWhite(mod);
				break;
			case USEMANA_BLACK:
			case USEMANA_BLACK_NOBM:
				mod = spellCostBlack(mod);
				break;
		}
		//Blood mages use HP for spells
		if (player.hasPerk(PerkLib.BloodMage)
			&& (type == USEMANA_MAGIC || type == USEMANA_WHITE || type == USEMANA_BLACK)) {
			combat.takeDamage(mod);
			statScreenRefresh();
			return;
		}
		//Mana restoration buffs!
		if (mod > 0) {
			mod *= manaRecoveryMultiplier();
		}
		player.mana = boundFloat(0, player.mana - mod, player.maxMana());
		if(mod > 0) {
			mainView.statsView.showStatUp( 'mana' );
		}
		if(mod < 0) {
			mainView.statsView.showStatDown( 'mana' );
		}
		statScreenRefresh();
	}
	public function manaRecoveryMultiplier():Number {
		var multi:Number = 1;
		if (player.findPerk(PerkLib.ControlledBreath) >= 0 && player.cor < (30 + player.corruptionTolerance())) multi += 0.3;
		if (player.findPerk(PerkLib.GreyMage) >= 0) multi += 1;
		if (player.findPerk(PerkLib.GreyArchmage) >= 0) multi += 3;
		if (player.findPerk(PerkLib.ManaAffinityI) >= 0) multi += 0.2;
		if (player.findPerk(PerkLib.ManaAffinityII) >= 0) multi += 0.2;
		if (player.findPerk(PerkLib.ManaAffinityIII) >= 0) multi += 0.2;
		if (player.findPerk(PerkLib.ManaAffinityIV) >= 0) multi += 0.2;
		if (player.findPerk(PerkLib.ManaAffinityV) >= 0) multi += 0.2;
		if (player.findPerk(PerkLib.ManaAffinityVI) >= 0) multi += 0.2;
		if (player.alicornScore() >= 6) multi += 0.1;
		if (player.kitsuneScore() >= 5) {
			if (player.kitsuneScore() >= 10) multi += 1;
			else multi += 0.5;
		}
		if (player.unicornScore() >= 5) multi += 0.05;
		return multi;
	}
	public static const USEFATG_NORMAL:int = 0;
	public static const USEFATG_MAGIC:int = 1;
	public static const USEFATG_PHYSICAL:int = 2;
	public static const USEFATG_MAGIC_NOBM:int = 3;
	public static const USEFATG_BOW:int = 4;
	public static const USEFATG_WHITE:int = 5;
	public static const USEFATG_BLACK:int = 6;
	public static const USEFATG_WHITE_NOBM:int = 7;
	public static const USEFATG_BLACK_NOBM:int = 8;
//Modify fatigue (mod>0 - subtract, mod<0 - regen)//types:
public function fatigueImpl(mod:Number,type:Number  = USEFATG_NORMAL):void {
	//Spell reductions
	if(type == USEFATG_MAGIC) {
		mod = spellCost(mod);
		//Blood mages use HP for spells
		if(player.findPerk(PerkLib.BloodMage) >= 0) {
			combat.takeDamage(mod);
			statScreenRefresh();
			return;
		}
	}
	//Physical special reductions
	if(type == USEFATG_PHYSICAL) {
		mod = physicalCost(mod);
	}
	if(type == USEFATG_MAGIC_NOBM) {
		mod = spellCost(mod);
	}
	if (type == USEFATG_BOW) {
		mod = bowCost(mod);
	}
	if (type == USEFATG_WHITE) {
		mod = spellCostWhite(mod);
		//Blood mages use HP for spells
		if(player.findPerk(PerkLib.BloodMage) >= 0) {
			combat.takeDamage(mod);
			statScreenRefresh();
			return;
		}
	}
	if (type == USEFATG_BLACK) {
		mod = spellCostBlack(mod);
		//Blood mages use HP for spells
		if(player.findPerk(PerkLib.BloodMage) >= 0) {
			combat.takeDamage(mod);
			statScreenRefresh();
			return;
		}
	}
	if (type == USEFATG_WHITE_NOBM) {
		mod = spellCostWhite(mod);
	}
	if (type == USEFATG_BLACK_NOBM) {
		mod = spellCostBlack(mod);
	}
	if(player.fatigue >= player.maxFatigue() && mod > 0) return;
	if(player.fatigue <= 0 && mod < 0) return;
	//Fatigue restoration buffs!
	if (mod < 0) {
		mod *= fatigueRecoveryMultiplier();
	}
	player.fatigue += mod;
	if(mod < 0) {
		mainView.statsView.showStatUp( 'fatigue' );
	}
	if(mod > 0) {
		mainView.statsView.showStatDown( 'fatigue' );
	}
	dynStats("lus", 0, "resisted", false); //Force display fatigue up/down by invoking zero lust change.
	if(player.fatigue > player.maxFatigue()) player.fatigue = player.maxFatigue();
	if(player.fatigue < 0) player.fatigue = 0;
	statScreenRefresh();
}
	public function fatigueRecoveryMultiplier():Number {
		var multi:Number = 1;
		if (player.findPerk(PerkLib.HistorySlacker) >= 0 || player.findPerk(PerkLib.PastLifeSlacker) >= 0) multi += 0.2;
		if (player.findPerk(PerkLib.ControlledBreath) >= 0 && player.cor < (30 + player.corruptionTolerance())) multi += 0.2;
		if (player.findPerk(PerkLib.SpeedyRecovery) >= 0) multi += 0.5;
		if (player.findPerk(PerkLib.NaturesSpringI) >= 0) multi += 0.05;
		if (player.findPerk(PerkLib.NaturesSpringII) >= 0) multi += 0.05;
		if (player.findPerk(PerkLib.NaturesSpringIII) >= 0) multi += 0.05;
		if (player.findPerk(PerkLib.NaturesSpringIV) >= 0) multi += 0.05;
		if (player.findPerk(PerkLib.NaturesSpringV) >= 0) multi += 0.05;
		if (player.findPerk(PerkLib.NaturesSpringVI) >= 0) multi += 0.05;
		return multi;
	}
//ENEMYAI!
public function enemyAIImpl():void {
	monster.doAI();
	//Violet Pupil Transformation
	if (player.hasStatusEffect(StatusEffects.VioletPupilTransformation)) {
		/*if (player.soulforce < 100)
		{
			player.removeStatusEffect(StatusEffects.VioletPupilTransformation);
			outputText("<b>Your soulforce is too low to continue using Violet Pupil Transformation so soul skill deactivated itself!  As long you can recover some soulforce before end of the fight you could then reactivate this skill.</b>\n\n");
		}
		else
		{*/
			var soulforcecost:int = 100;
			player.soulforce -= soulforcecost;
			var temp:int = 200;
			if (player.unicornScore() >= 5) temp += ((player.unicornScore() - 4) * 25);
			if (player.alicornScore() >= 6) temp += ((player.alicornScore() - 5) * 25);		
			//player.HP += 200;
			//if (player.HP >= player.maxHP()) player.HP = player.maxHP
			HPChange(temp,false);
		//}
	}
	if (player.hasStatusEffect(StatusEffects.TranceTransformation)) player.soulforce -= 50;
}
public function finishCombat():void
{
	var hpVictory:Boolean = monster.HP < 1;
	clearOutput();
	if (hpVictory) {
		outputText("You defeat " + monster.a + monster.short + ".\n");
	} else {
		outputText("You smile as " + monster.a + monster.short + " collapses and begins masturbating feverishly.");
	}
	cleanupAfterCombat();
}
public function dropItem(monster:Monster, nextFunc:Function = null):void {
	if (nextFunc == null) nextFunc = camp.returnToCampUseOneHour;
	if(monster.hasStatusEffect(StatusEffects.NoLoot)) {
		return;
	}
	if(player.hasStatusEffect(StatusEffects.SoulArena)) {
		player.removeStatusEffect(StatusEffects.SoulArena);
		return;
	}
	var itype:ItemType = monster.dropLoot();
	if(monster.short == "tit-fucked Minotaur") {
		itype = consumables.MINOCUM;
	}
	if(monster is Minotaur) {
		if(monster.weaponName == "axe") {
			if(rand(2) == 0) {
				//50% breakage!
				if(rand(2) == 0) {
					itype = weapons.L__AXE;
					if(player.tallness < 78 && player.str < 90) {
						outputText("\nYou find a large axe on the minotaur, but it is too big for a person of your stature to comfortably carry.  ");
						if(rand(2) == 0) itype = null;
						else itype = consumables.SDELITE;
					}
					//Not too tall, dont rob of axe!
					else kGAMECLASS.plotFight = true;
				}
				else outputText("\nThe minotaur's axe appears to have been broken during the fight, rendering it useless.  ");
			}
			else itype = consumables.MINOBLO;
		}
	}
	if(monster is BeeGirl) {
		//force honey drop if milked
		if(flags[kFLAGS.FORCE_BEE_TO_PRODUCE_HONEY] == 1) {
			if(rand(2) == 0) itype = consumables.BEEHONY;
			else itype = consumables.PURHONY;
			flags[kFLAGS.FORCE_BEE_TO_PRODUCE_HONEY] = 0;
		}
	}
	if(monster is Jojo && kGAMECLASS.monk > 4) {
		if(rand(2) == 0) itype = consumables.INCUBID;
		else {
			if(rand(2) == 0) itype = consumables.B__BOOK;
			else itype = consumables.SUCMILK;
		}
	}
	if(monster is Harpy || monster is Sophie) {
		if(rand(10) == 0) itype = armors.W_ROBES;
		else if(rand(3) == 0 && player.findPerk(PerkLib.LuststickAdapted) >= 0) itype = consumables.LUSTSTK;
		else itype = consumables.GLDSEED;
	}
	//Chance of armor if at level 1 pierce fetish
	if(!kGAMECLASS.plotFight && !(monster is Ember) && !(monster is Kiha) && !(monster is Hel) && !(monster is Isabella)
	   && flags[kFLAGS.PC_FETISH] == 1 && rand(10) == 0 && !player.hasItem(armors.SEDUCTA, 1) && !kGAMECLASS.ceraphFollowerScene.ceraphIsFollower()) {
		itype = armors.SEDUCTA;
	}
	
	if(!kGAMECLASS.plotFight && rand(200) == 0 && player.level >= 7) itype = consumables.BROBREW;
	if(!kGAMECLASS.plotFight && rand(200) == 0 && player.level >= 7) itype = consumables.BIMBOLQ;
	if(!kGAMECLASS.plotFight && rand(1000) == 0 && player.level >= 7) itype = consumables.RAINDYE;
	//Chance of eggs if Easter!
	if(!kGAMECLASS.plotFight && rand(6) == 0 && isEaster()) {
		temp = rand(13);
		if(temp == 0) itype =consumables.BROWNEG;
		if(temp == 1) itype =consumables.L_BRNEG;
		if(temp == 2) itype =consumables.PURPLEG;
		if(temp == 3) itype =consumables.L_PRPEG;
		if(temp == 4) itype =consumables.BLUEEGG;
		if(temp == 5) itype =consumables.L_BLUEG;
		if(temp == 6) itype =consumables.PINKEGG;
		if(temp == 7) itype =consumables.NPNKEGG;
		if(temp == 8) itype =consumables.L_PNKEG;
		if(temp == 9) itype =consumables.L_WHTEG;
		if(temp == 10) itype =consumables.WHITEEG;
		if(temp == 11) itype =consumables.BLACKEG;
		if(temp == 12) itype =consumables.L_BLKEG;
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
public function awardPlayer(nextFunc:Function = null):void
{
	if (nextFunc == null) nextFunc = camp.returnToCampUseOneHour; //Default to returning to camp.
	if (player.countCockSocks("gilded") > 0) {
		//trace( "awardPlayer found MidasCock. Gems bumped from: " + monster.gems );
		
		var bonusGems:int = monster.gems * 0.15 + 5 * player.countCockSocks("gilded"); // int so AS rounds to whole numbers
		monster.gems += bonusGems;
		//trace( "to: " + monster.gems )
	}
	if (player.findPerk(PerkLib.HistoryFortune) >= 0 || player.findPerk(PerkLib.PastLifeFortune) >= 0) {
		var bonusGems2:int = monster.gems * 0.15;
		monster.gems += bonusGems2;
	}
	if (player.findPerk(PerkLib.HistoryWhore) >= 0 || player.findPerk(PerkLib.PastLifeWhore) >= 0) {
		var bonusGems3:int = (monster.gems * 0.04) * player.teaseLevel;
		if (monster.lust >= monster.eMaxLust()) monster.gems += bonusGems3;
	}
	if (player.findPerk(PerkLib.AscensionFortune) >= 0) {
		monster.gems *= 1 + (player.perkv1(PerkLib.AscensionFortune) * 0.1);
		monster.gems = Math.round(monster.gems);
	}
	monster.handleAwardText(); //Each monster can now override the default award text
	if (!inDungeon && !inRoomedDungeon && !prison.inPrison) { //Not in dungeons
		if (nextFunc != null) doNext(nextFunc);
		else doNext(playerMenu);
	}
	else {
		if (nextFunc != null) doNext(nextFunc);
		else doNext(playerMenu);
	}
	dropItem(monster, nextFunc);
	inCombat = false;
	player.gems += monster.gems;
	player.XP += monster.XP;
	mainView.statsView.showStatUp('xp');
	dynStats("lust", 0, "resisted", false); //Forces up arrow.
}

//Update combat status effects
private function combatStatusesUpdate():void {
	//old outfit used for fetish cultists
	var oldOutfit:String = "";
	var changed:Boolean = false;
	//Reset menuloc
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
	hideUpDown();
	if (player.hasStatusEffect(StatusEffects.MinotaurKingMusk))
	{
		dynStats("lus+", 3);
	}
	if(player.hasStatusEffect(StatusEffects.Sealed)) {
		//Countdown and remove as necessary
		if(player.statusEffectv1(StatusEffects.Sealed) > 0) {
			player.addStatusValue(StatusEffects.Sealed,1,-1);
			if(player.statusEffectv1(StatusEffects.Sealed) <= 0) player.removeStatusEffect(StatusEffects.Sealed);
			else outputText("<b>One of your combat abilities is currently sealed by magic!</b>\n\n");
		}
	}
	if(player.hasStatusEffect(StatusEffects.Sealed2)) {
		//Countdown and remove as necessary
		if(player.statusEffectv1(StatusEffects.Sealed2) > 0) {
			player.addStatusValue(StatusEffects.Sealed2,1,-1);
			if(player.statusEffectv1(StatusEffects.Sealed2) <= 0) player.removeStatusEffect(StatusEffects.Sealed2);
			else outputText("<b>One of your combat abilities is currently disabled as aftereffect of recent enemy attack!</b>\n\n");
		}
	}
	if (player.hasStatusEffect(StatusEffects.WhipSilence))
	{
		player.addStatusValue(StatusEffects.WhipSilence, 1, -1);
		if (player.statusEffectv1(StatusEffects.WhipSilence) <= 0)
		{
			player.removeStatusEffect(StatusEffects.WhipSilence);
			outputText("<b>The constricting cords encircling your neck fall away, their flames guttering into nothingness. It seems even a Demon Queen’s magic has an expiration date.</b>\n\n");
		}
	}	
	if (player.hasStatusEffect(StatusEffects.PigbysHands))
	{
		dynStats("lus", 5);
	}
	if (player.hasStatusEffect(StatusEffects.TaintedMind)) {
		player.addStatusValue(StatusEffects.TaintedMind, 1, 1);
		if (player.statusEffectv1(StatusEffects.TaintedMind) <= 0)
		{
			player.removeStatusEffect(StatusEffects.TaintedMind);
			outputText("Some of the drider’s magic fades, and you heft your [weapon] with a grin. No more of this ‘fight like a demon’ crap!\n\n");
		}
		else
		{
			outputText("There is a thin film of filth layered upon your mind, latent and waiting. The drider said something about fighting like a demon. Is this supposed to interfere with your ability to fight?\n\n");
		}
	}
	if (player.hasStatusEffect(StatusEffects.PurpleHaze)) {
		player.addStatusValue(StatusEffects.PurpleHaze, 1, -1);
		if (player.statusEffectv1(StatusEffects.PurpleHaze) <= 0)
		{
			player.removeStatusEffect(StatusEffects.PurpleHaze);
			player.removeStatusEffect(StatusEffects.Blind);
			outputText("The swirling mists that once obscured your vision part, allowing you to see your foe once more! <b>You are no longer blinded!</b>\n\n");
		}
		else
		{
			outputText("Your vision is still clouded by swirling purple mists bearing erotic shapes. You are effectively blinded and a little turned on by the display.\n\n");
		}
	}
	if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles))
	{
		player.addStatusValue(StatusEffects.LethicesRapeTentacles, 1, -1);
		
		if (player.statusEffectv3(StatusEffects.LethicesRapeTentacles) != 0)
		{
			player.addStatusValue(StatusEffects.LethicesRapeTentacles, 2, 1);
			
			var tentaround:Number = player.statusEffectv2(StatusEffects.LethicesRapeTentacles);
			
			if (tentaround == 1)
			{
				outputText("Taking advantage of your helpless state, the tentacles wind deeper under your [armor], caressing your [nipples] and coating your [butt] in slippery goo. One even seeks out your crotch, none-too-gently prodding around for weak points.\n\n");
				dynStats("lus", 5);
			}
			else if (tentaround == 2)
			{
				outputText("Now that they’ve settled in, the tentacles go to work on your body, rudely molesting every sensitive place they can find.");
				if (player.hasCock()) outputText(" They twirl and writhe around your [cocks].");
				if (player.hasVagina()) outputText(" One flosses your nether-lips, rubbing slippery bumps maddenly against your [clit].");
				outputText(" " + num2Text(player.totalNipples()) + " tendrils encircle your [nipples]");
				if (player.hasFuckableNipples()) outputText(", threatening to slide inside them at a moment’s notice");
				else
				{
					outputText(", pinching and tugging them");
					if (player.isLactating()) outputText(", squeezing out small jets of milk");
				}
				outputText(". Worst of all is the tentacle slithering between your buttcheeks. It keeps stopping to rub around the edge of your [asshole]. You really ought to break free...\n\n");
				dynStats("lus", 5);
			}
			else if (tentaround == 3)
			{
				outputText("Another inky length rises up from the floor and slaps against your face, inexpertly attempting to thrust itself inside your mouth. Resenting its temerity, you steadfastly hold your lips closed and turn your head away. The corrupt magics powering this spell won’t let you get off so easily, though. The others redouble their efforts, inundating you with maddening pleasure. You can’t help but gasp and moan, giving the oiled feeler all the opening it needs to enter your maw.\n\n");
				dynStats("lus", 5);
			}
			else if (tentaround == 4)
			{
				outputText("If you thought having one tentacle in your mouth was bad, then the two floating in front of you are potentially terrifying. Unfortunately, they turn out to be mere distractions. The tendril plying your buns rears back and stabs inside, splitting your sphincter");
				if (player.hasVagina())
				{
					outputText(" while its brother simultaneously pierces your tender folds, rapaciously double-penetrating you");
					if (player.hasVirginVagina()) outputText(" <b>You've come all this way only to lose your virginity to these things!</b>");
				}
				outputText(".");
				if (player.hasFuckableNipples()) outputText(" Your [nipples] are similarly entered.");
				if (player.hasCock()) outputText(" And [eachCock] is suddenly coated in slimy, extraplanar oil and pumped with rapid, sure strokes.");
				outputText(" There’s too much. If you don’t break free, you’re going to wind up losing to a simple spell!\n\n");
				dynStats("lus", 10);
			}
			else
			{
				outputText("You’ve really fucked up now. An entire throne room full of demons is watching a bunch of summoned tentacles rape you in every hole, bouncing your body back and forth with the force of their thrusts, repeatedly spilling their corruptive payloads into your receptive holes. The worst part is");
				if (player.cor >= 50) outputText(" how much of a bitch it makes you look like... and how good it feels to be Lethice’s bitch.");
				else outputText(" how dirty it makes you feel... and how good it feels to be dirty.\n\n");				
				dynStats("lus", 10, "cor", 1);
			}
		}
		else
		{
			outputText("The tentacles grab at you again!");
			if (player.canFly()) outputText(" No matter how they strain, they can’t reach you.\n\n");
			else if (combatMiss() || player.findPerk(PerkLib.Evade) >= 0 || player.findPerk(PerkLib.Flexibility) >= 0) outputText(" You twist out of their slick, bizarrely sensuous grasp for now.\n\n");
			else
			{
				outputText(" Damn, they got you! They yank your arms and [legs] taut, holding you helpless in the air for their brothers to further violate. You can already feel a few oily tendrils sneaking under your [armor].\n\n");
				player.changeStatusValue(StatusEffects.LethicesRapeTentacles, 3, 1);
				dynStats("lus", 5);
			}
		}		
		if (player.statusEffectv1(StatusEffects.LethicesRapeTentacles) <= 0)
		{
			if (player.statusEffectv3(StatusEffects.LethicesRapeTentacles) != 0)
			{
				outputText("The tentacles in front of you suddenly pop like balloons of black smoke, leaving a greasy mist in their wake. A breeze from nowhere dissipates the remnants of the rapacious tendrils, their magic expended.\n\n");
			}
			else
			{
				outputText("The tentacles holding you abruptly let go, dropping you to the ground. Climbing up, you look around in alarm, but the tendrils have faded into puffs of black smoke. A breeze from nowhere blows them away, their magic expended.\n\n");
			}
			player.removeStatusEffect(StatusEffects.LethicesRapeTentacles);
		}
	}
	monster.combatRoundUpdate();
	//[Silence warning]
	if(player.hasStatusEffect(StatusEffects.ThroatPunch)) {
		player.addStatusValue(StatusEffects.ThroatPunch,1,-1);
		if(player.statusEffectv1(StatusEffects.ThroatPunch) >= 0) outputText("Thanks to Isabella's wind-pipe crushing hit, you're having trouble breathing and are <b>unable to cast spells as a consequence.</b>\n\n");
		else {
			outputText("Your wind-pipe recovers from Isabella's brutal hit.  You'll be able to focus to cast spells again!\n\n");
			player.removeStatusEffect(StatusEffects.ThroatPunch);
		}
	}
	if(player.hasStatusEffect(StatusEffects.GooArmorSilence)) {
		if(player.statusEffectv1(StatusEffects.GooArmorSilence) >= 2 || rand(20) + 1 + player.str / 10 >= 15) {
			//if passing str check, output at beginning of turn
			outputText("<b>The sticky slop covering your mouth pulls away reluctantly, taking more force than you would expect, but you've managed to free your mouth enough to speak!</b>\n\n");
			player.removeStatusEffect(StatusEffects.GooArmorSilence);
		}
		else {
			outputText("<b>Your mouth is obstructed by sticky goo!  You are silenced!</b>\n\n");
			player.addStatusValue(StatusEffects.GooArmorSilence,1,1);
		}
	}
	if(player.hasStatusEffect(StatusEffects.LustStones)) {
		//[When witches activate the stones for goo bodies]
		if(player.isGoo()) {
			outputText("<b>The stones start vibrating again, making your liquid body ripple with pleasure.  The witches snicker at the odd sight you are right now.\n\n</b>");
		}
		//[When witches activate the stones for solid bodies]
		else {
			outputText("<b>The smooth stones start vibrating again, sending another wave of teasing bliss throughout your body.  The witches snicker at you as you try to withstand their attack.\n\n</b>");
		}
		dynStats("lus", player.statusEffectv1(StatusEffects.LustStones) + 4);
	}
	if(player.hasStatusEffect(StatusEffects.WebSilence)) {
		if(player.statusEffectv1(StatusEffects.WebSilence) >= 2 || rand(20) + 1 + player.str / 10 >= 15) {
			outputText("You rip off the webbing that covers your mouth with a cry of pain, finally able to breathe normally again!  Now you can cast spells!\n\n");
			player.removeStatusEffect(StatusEffects.WebSilence);
		}
		else {
			outputText("<b>Your mouth and nose are obstructed by sticky webbing, making it difficult to breathe and impossible to focus on casting spells.  You try to pull it off, but it just won't work!</b>\n\n");
			player.addStatusValue(StatusEffects.WebSilence,1,1);
		}
	}		
	if(player.hasStatusEffect(StatusEffects.HolliConstrict)) {
		outputText("<b>You're tangled up in Holli's verdant limbs!  All you can do is try to struggle free...</b>\n\n");
	}
	if(player.hasStatusEffect(StatusEffects.UBERWEB))
		outputText("<b>You're pinned under a pile of webbing!  You should probably struggle out of it and get back in the fight!</b>\n\n");
	if (player.hasStatusEffect(StatusEffects.Blind) && !monster.hasStatusEffect(StatusEffects.Sandstorm) && !player.hasStatusEffect(StatusEffects.PurpleHaze))
	{
		if (player.hasStatusEffect(StatusEffects.SheilaOil))
		{
			if(player.statusEffectv1(StatusEffects.Blind) <= 0) {
				outputText("<b>You finish wiping the demon's tainted oils away from your eyes; though the smell lingers, you can at least see.  Sheila actually seems happy to once again be under your gaze.</b>\n\n");
				player.removeStatusEffect(StatusEffects.Blind);
			}
			else {
				outputText("<b>You scrub at the oily secretion with the back of your hand and wipe some of it away, but only smear the remainder out more thinly.  You can hear the demon giggling at your discomfort.</b>\n\n");
				player.addStatusValue(StatusEffects.Blind,1,-1);
			}
		}
		else 
		{
			//Remove blind if countdown to 0
			if (player.statusEffectv1(StatusEffects.Blind) == 0)
			{
				player.removeStatusEffect(StatusEffects.Blind);
				//Alert PC that blind is gone if no more stacks are there.
				if (!player.hasStatusEffect(StatusEffects.Blind))
				{
					if (monster is Lethice && (monster as Lethice).fightPhase == 2)
					{
						outputText("<b>You finally blink away the last of the demonic spooge from your eyes!</b>\n\n");
					}
					else
					{
						outputText("<b>Your eyes have cleared and you are no longer blind!</b>\n\n");
					}
				}
				else outputText("<b>You are blind, and many physical attacks will miss much more often.</b>\n\n");
			}
			else 
			{
				player.addStatusValue(StatusEffects.Blind,1,-1);
				outputText("<b>You are blind, and many physical attacks will miss much more often.</b>\n\n");
			}
		}
	}
	//Basilisk compulsion
	if(player.hasStatusEffect(StatusEffects.BasiliskCompulsion)) {
		Basilisk.basiliskSpeed(player,15);
		//Continuing effect text: 
		outputText("<b>You still feel the spell of those grey eyes, making your movements slow and difficult, the remembered words tempting you to look into its eyes again. You need to finish this fight as fast as your heavy limbs will allow.</b>\n\n");
		flags[kFLAGS.BASILISK_RESISTANCE_TRACKER]++;
	}
	if(player.hasStatusEffect(StatusEffects.IzmaBleed)) {
		player.addStatusValue(StatusEffects.IzmaBleed,1,-1);
		if(player.statusEffectv1(StatusEffects.IzmaBleed) <= 0) {
			player.removeStatusEffect(StatusEffects.IzmaBleed);
			outputText("<b>You sigh with relief; your bleeding has slowed considerably.</b>\n\n");
		}
		//Bleed effect:
		else {
			var bleed:Number = (4 + rand(7))/100;
			bleed *= player.HP;
			bleed = takeDamage(bleed);
			outputText("<b>You gasp and wince in pain, feeling fresh blood pump from your wounds. (<font color=\"#800000\">" + bleed + "</font>)</b>\n\n");
		}
	}
	if(player.hasStatusEffect(StatusEffects.Hemorrhage)) {
		player.addStatusValue(StatusEffects.Hemorrhage,1,-1);
		if(player.statusEffectv1(StatusEffects.Hemorrhage) <= 0) {
			player.removeStatusEffect(StatusEffects.Hemorrhage);
			outputText("<b>You sigh with relief; your hemorrhage has slowed considerably.</b>\n\n");
		}
		//Hemorrhage effect:
		else {
			var hemorrhage:Number = 0;
			hemorrhage += player.maxHP() * player.statusEffectv2(StatusEffects.Hemorrhage);
			hemorrhage = takeDamage(hemorrhage);
			outputText("<b>You gasp and wince in pain, feeling fresh blood pump from your wounds. (<font color=\"#800000\">" + bleed + "</font>)</b>\n\n");
		}
	}
	if(player.hasStatusEffect(StatusEffects.UnderwaterOutOfAir)) {
		var deoxigen:Number = 0;
		deoxigen += (player.maxHP() * 0.05);
		deoxigen = takeDamage(deoxigen);
		outputText("<b>You are running out of oxygen you need to finish this fight and fast before you lose consciousness. <b>(<font color=\"#800000\">" + deoxigen + "</font>)</b></b>\n\n");
	}
	if(player.hasStatusEffect(StatusEffects.AcidSlap)) {
		var slap:Number = 3 + (player.maxHP() * 0.02);
		outputText("<b>Your muscles twitch in agony as the acid keeps burning you. <b>(<font color=\"#800000\">" + slap + "</font>)</b></b>\n\n");
	}
	if(player.findPerk(PerkLib.ArousingAura) >= 0 && monster.lustVuln > 0 && player.cor >= 70) {
		if(monster.lust < (monster.eMaxLust() * 0.5)) outputText("Your aura seeps into " + monster.a + monster.short + " but does not have any visible effects just yet.\n\n");
		else if(monster.lust < (monster.eMaxLust() * 0.6)) {
			if(!monster.plural) outputText(monster.capitalA + monster.short + " starts to squirm a little from your unholy presence.\n\n");
			else outputText(monster.capitalA + monster.short + " start to squirm a little from your unholy presence.\n\n");
		}
		else if(monster.lust < (monster.eMaxLust() * 0.75)) outputText("Your arousing aura seems to be visibly affecting " + monster.a + monster.short + ", making " + monster.pronoun2 + " squirm uncomfortably.\n\n");
		else if(monster.lust < (monster.eMaxLust() * 0.85)) {
			if(!monster.plural) outputText(monster.capitalA + monster.short + "'s skin colors red as " + monster.pronoun1 + " inadvertently basks in your presence.\n\n");
			else outputText(monster.capitalA + monster.short + "' skin colors red as " + monster.pronoun1 + " inadvertently bask in your presence.\n\n");
		}
		else {
			if(!monster.plural) outputText("The effects of your aura are quite pronounced on " + monster.a + monster.short + " as " + monster.pronoun1 + " begins to shake and steal glances at your body.\n\n");
			else outputText("The effects of your aura are quite pronounced on " + monster.a + monster.short + " as " + monster.pronoun1 + " begin to shake and steal glances at your body.\n\n");
		}
		if (player.findPerk(PerkLib.ArouseTheAudience) >= 0 && player.findPerk(PerkLib.EnemyGroupType) >= 0) monster.lust += monster.lustVuln * 1.2 * (2 + rand(4));
		else monster.lust += monster.lustVuln * (2 + rand(4));
	}
	if(player.hasStatusEffect(StatusEffects.AlraunePollen) && monster.lustVuln > 0) {
		if(monster.lust < (monster.eMaxLust() * 0.5)) outputText(monster.capitalA + monster.short + " breaths in your pollen but does not have any visible effects just yet.\n\n");
		else if(monster.lust < (monster.eMaxLust() * 0.6)) {
			if(!monster.plural) outputText(monster.capitalA + monster.short + " starts to squirm a little from your pollen.\n\n");
			else outputText(monster.capitalA + monster.short + " start to squirm a little from your pollen.\n\n");
		}
		else if(monster.lust < (monster.eMaxLust() * 0.75)) outputText("Your pollen seems to be visibly affecting " + monster.a + monster.short + ", making " + monster.pronoun2 + " squirm uncomfortably.\n\n");
		else if(monster.lust < (monster.eMaxLust() * 0.85)) {
			if(!monster.plural) outputText(monster.capitalA + monster.short + "'s skin colors red as " + monster.pronoun1 + " inadvertently breths in your pollen.\n\n");
			else outputText(monster.capitalA + monster.short + "' skin colors red as " + monster.pronoun1 + " inadvertently breths in your pollen.\n\n");
		}
		else {
			if(!monster.plural) outputText("The effects of your pollen are quite pronounced on " + monster.a + monster.short + " as " + monster.pronoun1 + " begins to shake and steal glances at your body.\n\n");
			else outputText("The effects of your pollen are quite pronounced on " + monster.a + monster.short + " as " + monster.pronoun1 + " begin to shake and steal glances at your body.\n\n");
		}
		if (player.findPerk(PerkLib.ArouseTheAudience) >= 0 && player.findPerk(PerkLib.EnemyGroupType) >= 0) monster.lust += monster.lustVuln * 1.2 * (2 + rand(4));
		else monster.lust += monster.lustVuln * (2 + rand(4));
	}
	if(player.hasStatusEffect(StatusEffects.Bound) && flags[kFLAGS.PC_FETISH] >= 2) {
		outputText("The feel of tight leather completely immobilizing you turns you on more and more.  Would it be so bad to just wait and let her play with you like this?\n\n");
		dynStats("lus", 3);
	}
	if(player.hasStatusEffect(StatusEffects.GooArmorBind)) {
		if(flags[kFLAGS.PC_FETISH] >= 2) {
			outputText("The feel of the all-encapsulating goo immobilizing your helpless body turns you on more and more.  Maybe you should just wait for it to completely immobilize you and have you at its mercy.\n\n");
			dynStats("lus", 3);
		}
		else outputText("You're utterly immobilized by the goo flowing around you.  You'll have to struggle free!\n\n");
	}
	if(player.hasStatusEffect(StatusEffects.HarpyBind)) {
		if(flags[kFLAGS.PC_FETISH] >= 2) {
			outputText("The harpies are holding you down and restraining you, making the struggle all the sweeter!\n\n");
			dynStats("lus", 3);
		}
		else outputText("You're restrained by the harpies so that they can beat on you with impunity.  You'll need to struggle to break free!\n\n");
	}
if((player.hasStatusEffect(StatusEffects.NagaBind) || player.hasStatusEffect(StatusEffects.ScyllaBind)) && flags[kFLAGS.PC_FETISH] >= 2) {
		outputText("Coiled tightly by " + monster.a + monster.short + " and utterly immobilized, you can't help but become aroused thanks to your bondage fetish.\n\n");
		dynStats("lus", 5);
	}
	if(player.hasStatusEffect(StatusEffects.TentacleBind)) {
		outputText("You are firmly trapped in the tentacle's coils.  <b>The only thing you can try to do is struggle free!</b>\n\n");
		if(flags[kFLAGS.PC_FETISH] >= 2) {
			outputText("Wrapped tightly in the tentacles, you find it hard to resist becoming more and more aroused...\n\n");
			dynStats("lus", 3);
		}
	}
	if(player.hasStatusEffect(StatusEffects.DriderKiss)) {
		//(VENOM OVER TIME: WEAK)
		if(player.statusEffectv1(StatusEffects.DriderKiss) == 0) {
			outputText("Your heart hammers a little faster as a vision of the drider's nude, exotic body on top of you assails you.  It'll only get worse if she kisses you again...\n\n");
			dynStats("lus", 8);
		}
		//(VENOM OVER TIME: MEDIUM)
		else if(player.statusEffectv1(StatusEffects.DriderKiss) == 1) {
			outputText("You shudder and moan, nearly touching yourself as your ");
			if(player.gender > 0) outputText("loins tingle and leak, hungry for the drider's every touch.");
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
	//Harpy lip gloss
	if(player.hasCock() && player.hasStatusEffect(StatusEffects.Luststick) && (monster.short == "harpy" || monster.short == "Sophie")) {
		//Chance to cleanse!
		if(player.findPerk(PerkLib.Medicine) >= 0 && rand(100) <= 14) {
			outputText("You manage to cleanse the harpy lip-gloss from your system with your knowledge of medicine!\n\n");
			player.removeStatusEffect(StatusEffects.Luststick);
		}		
		else if(rand(5) == 0) {
			if(rand(2) == 0) outputText("A fantasy springs up from nowhere, dominating your thoughts for a few moments.  In it, you're lying down in a soft nest.  Gold-rimmed lips are noisily slurping around your [cock], smearing it with her messy aphrodisiac until you're completely coated in it.  She looks up at you knowingly as the two of you get ready to breed the night away...\n\n");
			else outputText("An idle daydream flutters into your mind.  In it, you're fucking a harpy's asshole, clutching tightly to her wide, feathery flanks as the tight ring of her pucker massages your [cock].  She moans and turns around to kiss you on the lips, ensuring your hardness.  Before long her feverish grunts of pleasure intensify, and you feel the egg she's birthing squeezing against you through her internal walls...\n\n");
			dynStats("lus", 20);
		}
	}
	if(player.hasStatusEffect(StatusEffects.StoneLust)) {
		if(player.vaginas.length > 0) {
			if(player.lust < 40) outputText("You squirm as the smooth stone orb vibrates within you.\n\n");
			if(player.lust >= 40 && player.lust < 70) outputText("You involuntarily clench around the magical stone in your twat, in response to the constant erotic vibrations.\n\n");
			if(player.lust >= 70 && player.lust < 85) outputText("You stagger in surprise as a particularly pleasant burst of vibrations erupt from the smooth stone sphere in your " + vaginaDescript(0) + ".\n\n");
			if(player.lust >= 85) outputText("The magical orb inside of you is making it VERY difficult to keep your focus on combat, white-hot lust suffusing your body with each new motion.\n\n");
		}
		else {
			outputText("The orb continues vibrating in your ass, doing its best to arouse you.\n\n");
		}
		dynStats("lus", 7 + int(player.sens)/10);
	}
	if(player.hasStatusEffect(StatusEffects.KissOfDeath)) {
		//Effect 
		outputText("Your lips burn with an unexpected flash of heat.  They sting and burn with unholy energies as a puff of ectoplasmic gas escapes your lips.  That puff must be a part of your soul!  It darts through the air to the succubus, who slurps it down like a delicious snack.  You feel feverishly hot and exhausted...\n\n");
		dynStats("lus", 5);
		takeDamage(15);		
	}
	if(player.hasStatusEffect(StatusEffects.DemonSeed)) {
		outputText("You feel something shift inside you, making you feel warm.  Finding the desire to fight this... hunk gets harder and harder.\n\n");
		dynStats("lus", (player.statusEffectv1(StatusEffects.DemonSeed) + int(player.sens / 30) + int(player.lib / 30) + int(player.cor / 30)));
	}
	if(player.inHeat && player.vaginas.length > 0 && monster.totalCocks() > 0) {
		dynStats("lus", (rand(player.lib/5) + 3 + rand(5)));
		outputText("Your " + vaginaDescript(0) + " clenches with an instinctual desire to be touched and filled.  ");
		outputText("If you don't end this quickly you'll give in to your heat.\n\n");
	}
	if(player.inRut && player.totalCocks() > 0 && monster.hasVagina()) {
		dynStats("lus", (rand(player.lib/5) + 3 + rand(5)));
		if(player.totalCocks() > 1) outputText("Each of y");
		else outputText("Y");
		if(monster.plural) outputText("our [cocks] dribbles pre-cum as you think about plowing " + monster.a + monster.short + " right here and now, fucking " + monster.pronoun3 + " " + monster.vaginaDescript() + "s until they're totally fertilized and pregnant.\n\n");
		else outputText("our [cocks] dribbles pre-cum as you think about plowing " + monster.a + monster.short + " right here and now, fucking " + monster.pronoun3 + " " + monster.vaginaDescript() + " until it's totally fertilized and pregnant.\n\n");
	}
	if(player.hasStatusEffect(StatusEffects.NagaVenom)) {
		//Chance to cleanse!
		if(player.findPerk(PerkLib.Medicine) >= 0 && rand(100) <= 14) {
			outputText("You manage to cleanse " + monster.a + monster.short + " venom from your system with your knowledge of medicine!\n\n");
			player.spe += player.statusEffectv1(StatusEffects.NagaVenom);
			mainView.statsView.showStatUp( 'spe' );
			// speUp.visible = true;
			// speDown.visible = false;
			player.removeStatusEffect(StatusEffects.NagaVenom);
		}
		else if(player.spe > 3) {
			player.addStatusValue(StatusEffects.NagaVenom,1,2);
			player.spe -= 2;
		}
		else takeDamage(5);
		outputText("You wince in pain and try to collect yourself, " + monster.a + monster.short + "'s venom still plaguing you.\n\n");
		takeDamage(2);
	}
	if(player.hasStatusEffect(StatusEffects.MedusaVenom)) {
		//Chance to cleanse!
		if(player.findPerk(PerkLib.Medicine) >= 0 && rand(100) <= 14) {
			outputText("You manage to cleanse " + monster.a + monster.short + " venom from your system with your knowledge of medicine!\n\n");
			player.str += player.statusEffectv1(StatusEffects.MedusaVenom);
			player.tou += player.statusEffectv2(StatusEffects.MedusaVenom);
			player.spe += player.statusEffectv3(StatusEffects.MedusaVenom);
			player.inte += player.statusEffectv4(StatusEffects.MedusaVenom);
			mainView.statsView.showStatUp( 'str' );
			mainView.statsView.showStatUp( 'tou' );
			mainView.statsView.showStatUp( 'spe' );
			mainView.statsView.showStatUp( 'inte' );
			player.removeStatusEffect(StatusEffects.MedusaVenom);
		}
		else if (player.str <= 5 && player.tou <= 5 && player.spe <= 5 && player.inte <= 5) takeDamage(5);
		else {
			if(player.str > 5) {
			player.addStatusValue(StatusEffects.MedusaVenom,1,1);
			player.str -= 1;
			}
			if(player.tou > 5) {
			player.addStatusValue(StatusEffects.MedusaVenom,2,1);
			player.tou -= 1;
			}
			if(player.spe > 5) {
			player.addStatusValue(StatusEffects.MedusaVenom,3,1);
			player.spe -= 1;
			}
			if(player.inte > 5) {
			player.addStatusValue(StatusEffects.MedusaVenom,4,1);
			player.inte -= 1;
			}
		}
		outputText("You wince in pain and try to collect yourself, " + monster.a + monster.short + "'s venom still plaguing you.\n\n");
		takeDamage(2);
	}
	else if(player.hasStatusEffect(StatusEffects.TemporaryHeat)) {
		//Chance to cleanse!
		if(player.findPerk(PerkLib.Medicine) >= 0 && rand(100) <= 14) {
			outputText("You manage to cleanse the heat and rut drug from your system with your knowledge of medicine!\n\n");
			player.removeStatusEffect(StatusEffects.TemporaryHeat);
		}
		else {
			dynStats("lus", (player.lib/12 + 5 + rand(5)) * player.statusEffectv2(StatusEffects.TemporaryHeat));
			if(player.hasVagina()) {
				outputText("Your " + vaginaDescript(0) + " clenches with an instinctual desire to be touched and filled.  ");
			}
			else if(player.totalCocks() > 0) {
				outputText("Your [cock] pulses and twitches, overwhelmed with the desire to breed.  ");
			}
			if(player.gender == 0) {
				outputText("You feel a tingle in your " + assholeDescript() + ", and the need to touch and fill it nearly overwhelms you.  ");
			}
			outputText("If you don't finish this soon you'll give in to this potent drug!\n\n");
		}
	}
	//Poison
	if(player.hasStatusEffect(StatusEffects.Poison)) {
		//Chance to cleanse!
		if(player.findPerk(PerkLib.Medicine) >= 0 && rand(100) <= 14) {
			outputText("You manage to cleanse the poison from your system with your knowledge of medicine!\n\n");
			player.removeStatusEffect(StatusEffects.Poison);
		}
		else {
			outputText("The poison continues to work on your body, wracking you with pain!\n\n");
			takeDamage(8+rand(player.maxHP()/20) * player.statusEffectv2(StatusEffects.Poison));
		}
	}
	//Bondage straps + bondage fetish
	if(flags[kFLAGS.PC_FETISH] >= 2 && player.armorName == "barely-decent bondage straps") {
		outputText("The feeling of the tight, leather straps holding tightly to your body while exposing so much of it turns you on a little bit more.\n\n");
		dynStats("lus", 2);
	}
	// Drider incubus venom
	if (player.hasStatusEffect(StatusEffects.DriderIncubusVenom))
	{
		if (player.findPerk(PerkLib.Medicine) >= 0 && rand(100) <= 41) {
			outputText("You negate the effects of the drider incubus’ venom with your knowledge of medicine!\n\n");
			
			player.str += player.statusEffectv2(StatusEffects.DriderIncubusVenom);
			player.removeStatusEffect(StatusEffects.DriderIncubusVenom);
			kGAMECLASS.mainView.statsView.showStatUp('str');
		}
		else
		{
			player.addStatusValue(StatusEffects.DriderIncubusVenom, 1, -1);
			if (player.statusEffectv1(StatusEffects.DriderIncubusVenom) <= 0)
			{
				player.str += player.statusEffectv2(StatusEffects.DriderIncubusVenom);
				player.removeStatusEffect(StatusEffects.DriderIncubusVenom);
				kGAMECLASS.mainView.statsView.showStatUp('str');
				outputText("The drider incubus’ venom wanes, the effects of the poision weakening as strength returns to your limbs!\n\n");
			}
			else
			{
				outputText("The demonic drider managed to bite you, infecting you with his strength-draining poison!\n\n");
			}
		}
	}
	if (monster.hasStatusEffect(StatusEffects.OnFire))
	{
		var damage:Number = 20 + rand(5);
		monster.HP -= damage;
		monster.addStatusValue(StatusEffects.OnFire, 1, -1);
		if (monster.statusEffectv1(StatusEffects.OnFire) <= 0)
		{
			monster.removeStatusEffect(StatusEffects.OnFire);
			outputText("\n\nFlames lick at the horde of demons before finally petering out!");
		}
		else
		{
			outputText("\n\nFlames continue to lick at the horde of demons!");
		}		
	}
	//Giant boulder
	if (player.hasStatusEffect(StatusEffects.GiantBoulder)) {
		outputText("<b>There is a large boulder coming your way. If you don't avoid it in time, you might take some serious damage.</b>\n\n");
	}
	//Berzerker/Lustzerker/Dwarf Rage/Oni Rampage/Maleficium
	if (player.hasStatusEffect(StatusEffects.Berzerking)) {
		if (player.statusEffectv1(StatusEffects.Berzerking) <= 0) {
			player.removeStatusEffect(StatusEffects.Berzerking);
			outputText("<b>Berserker effect wore off!</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.Berzerking,1,-1);
	}
	if (player.hasStatusEffect(StatusEffects.Lustzerking)) {
		if (player.statusEffectv1(StatusEffects.Lustzerking) <= 0) {
			player.removeStatusEffect(StatusEffects.Lustzerking);
			outputText("<b>Lustzerker effect wore off!</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.Lustzerking,1,-1);
	}
	if (player.hasStatusEffect(StatusEffects.DwarfRage)) {
		if (player.statusEffectv3(StatusEffects.DwarfRage) <= 0) {
			kGAMECLASS.dynStats("str", -player.statusEffectv1(StatusEffects.DwarfRage),"tou", -player.statusEffectv2(StatusEffects.DwarfRage),"spe", -player.statusEffectv2(StatusEffects.DwarfRage));
			player.removeStatusEffect(StatusEffects.DwarfRage);
			outputText("<b>Dwarf Rage effect wore off!</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.DwarfRage,3,-1);
	}
	if (player.hasStatusEffect(StatusEffects.OniRampage)) {
		if (player.statusEffectv1(StatusEffects.OniRampage) <= 0) {
			player.removeStatusEffect(StatusEffects.OniRampage);
			outputText("<b>Your rage wear off.</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.OniRampage,1,-1);
	}
	if (player.hasStatusEffect(StatusEffects.Maleficium)) {
		if (player.statusEffectv1(StatusEffects.Maleficium) <= 0) {
			player.removeStatusEffect(StatusEffects.Maleficium);
			outputText("<b>Maleficium effect wore off!</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.Maleficium,1,-1);
	}
	//Spell buffs
	if (player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
		if (player.statusEffectv2(StatusEffects.ChargeWeapon) <= 0) {
			player.removeStatusEffect(StatusEffects.ChargeWeapon);
			outputText("<b>Charged Weapon effect wore off!</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.ChargeWeapon,2,-1);
	}
	if (player.hasStatusEffect(StatusEffects.ChargeArmor)) {
		if (player.statusEffectv2(StatusEffects.ChargeArmor) <= 0) {
			player.removeStatusEffect(StatusEffects.ChargeArmor);
			outputText("<b>Charged Armor effect wore off!</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.ChargeArmor,2,-1);
	}
	if (player.hasStatusEffect(StatusEffects.Might)) {
		if (player.statusEffectv3(StatusEffects.Might) <= 0) {
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) kGAMECLASS.dynStats("int", -player.statusEffectv1(StatusEffects.Might));
			else kGAMECLASS.dynStats("str", -player.statusEffectv1(StatusEffects.Might));
			kGAMECLASS.dynStats("tou", -player.statusEffectv2(StatusEffects.Might));
			player.removeStatusEffect(StatusEffects.Might);
		//	statScreenRefresh();
			outputText("<b>Might effect wore off!</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.Might,3,-1);
	}
	if (player.hasStatusEffect(StatusEffects.Blink)) {
		if (player.statusEffectv3(StatusEffects.Blink) <= 0) {
			kGAMECLASS.dynStats("spe", -player.statusEffectv1(StatusEffects.Blink));
			player.removeStatusEffect(StatusEffects.Blink);
		//	statScreenRefresh();
			outputText("<b>Blink effect wore off!</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.Blink,3,-1);
	}
	//Blizzard
	if (player.hasStatusEffect(StatusEffects.Blizzard)) {
		//Remove blizzard if countdown to 0
		if (player.statusEffectv1(StatusEffects.Blizzard) <= 0) {
			player.removeStatusEffect(StatusEffects.Blizzard);
			outputText("<b>Blizzard spell exhausted all of it power and need to be casted again to provide protection from the fire attacks again!</b>\n\n");
		}
		else {
			player.addStatusValue(StatusEffects.Blizzard,1,-1);
			outputText("<b>Surrounding your blizzard slowly loosing it protective power.</b>\n\n");
		}
	}
	//Violet Pupil Transformation
	if (player.hasStatusEffect(StatusEffects.VioletPupilTransformation)) {
		if (player.soulforce < 100) {
			player.removeStatusEffect(StatusEffects.VioletPupilTransformation);
			outputText("<b>Your soulforce is too low to continue using Violet Pupil Transformation so soul skill deactivated itself!  As long you can recover some soulforce before end of the fight you could then reactivate this skill.</b>\n\n");
		}
		else {
			outputText("<b>As your soulforce is drained you can feel Violet Pupil Transformation regenerative power spreading in your body.</b>\n\n");
		}
	}
	//Trance Transformation
	if (player.hasStatusEffect(StatusEffects.TranceTransformation)) {
		if (player.soulforce < 50) {
			kGAMECLASS.dynStats("str", -player.statusEffectv1(StatusEffects.TranceTransformation));
			kGAMECLASS.dynStats("tou", -player.statusEffectv1(StatusEffects.TranceTransformation));
			player.removeStatusEffect(StatusEffects.TranceTransformation);
			outputText("<b>The flow of power through you suddenly stops, as you no longer have the soul energy to sustain it.  You drop roughly to the floor, the crystal coating your [skin] cracking and fading to nothing.</b>\n\n");
		}
	//	else {
	//		outputText("<b>As your soulforce is drained you can feel Violet Pupil Transformation regenerative power spreading in your body.</b>\n\n");
	//	}
	}
	//Ezekiel Curse
	if (player.hasStatusEffect(StatusEffects.EzekielCurse)) {
		if (flags[kFLAGS.EVANGELINE_AFFECTION] >= 2 && player.findPerk(PerkLib.EzekielBlessing) >= 0) {
			outputText("<b>You feel familiar feeling of your own lifeforce been slowly extinquished.  Maybe you should finish this fight as soon as possible to start healing this aligment?</b>\n\n");
			takeDamage(500);
		}
		else if (flags[kFLAGS.EVANGELINE_AFFECTION] >= 2) {
			outputText("<b>You suddenly feel like you very own lifeforce are been at steady pace extinquished the longer you keep fighting.  You better finsh this fight fast or find way to cure your current situation as otherwise...</b>\n\n");
			if (player.maxHP() < 1000) takeDamage(player.maxHP() * 0.1);
			else takeDamage(100);
		}
	}
	//Flying
	if(player.hasStatusEffect(StatusEffects.Flying)) {
		player.addStatusValue(StatusEffects.Flying,1,-1);
		if(player.statusEffectv1(StatusEffects.Flying) >= 0) outputText("<b>You keep making circles in the air around your opponent.</b>\n\n");
		else {
			outputText("<b>You land to tired to keep flying.</b>\n\n");
			player.removeStatusEffect(StatusEffects.Flying);
		}
	}
	//Ink Spray
	if (player.hasStatusEffect(StatusEffects.CooldownInkSpray)) {
		if (player.statusEffectv1(StatusEffects.CooldownInkSpray) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownInkSpray);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownInkSpray,1,-1);
		}
	}
	//Tail Smack
	if (player.hasStatusEffect(StatusEffects.CooldownTailSmack)) {
		if (player.statusEffectv1(StatusEffects.CooldownTailSmack) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownTailSmack);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownTailSmack,1,-1);
		}
	}
	//Stone Claw
	if (player.hasStatusEffect(StatusEffects.CooldownStoneClaw)) {
		if (player.statusEffectv1(StatusEffects.CooldownStoneClaw) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownStoneClaw);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownStoneClaw,1,-1);
		}
	}
	//Tail Slam
	if (player.hasStatusEffect(StatusEffects.CooldownTailSlam)) {
		if (player.statusEffectv1(StatusEffects.CooldownTailSlam) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownTailSlam);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownTailSlam,1,-1);
		}
	}
	//Wing Buffet
	if (player.hasStatusEffect(StatusEffects.CooldownWingBuffet)) {
		if (player.statusEffectv1(StatusEffects.CooldownWingBuffet) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownWingBuffet);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownWingBuffet,1,-1);
		}
	}
	//Kick
	if (player.hasStatusEffect(StatusEffects.CooldownKick)) {
		if (player.statusEffectv1(StatusEffects.CooldownKick) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownKick);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownKick,1,-1);
		}
	}
	//Freezing Breath Fenrir
	if (player.hasStatusEffect(StatusEffects.CooldownFreezingBreath)) {
		if (player.statusEffectv1(StatusEffects.CooldownFreezingBreath) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownFreezingBreath);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownFreezingBreath,1,-1);
		}
	}
	//Freezing Breath Yeti
	if (player.hasStatusEffect(StatusEffects.CooldownFreezingBreathYeti)) {
		if (player.statusEffectv1(StatusEffects.CooldownFreezingBreathYeti) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownFreezingBreathYeti);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownFreezingBreathYeti,1,-1);
		}
	}
	//Phoenix Fire Breath
	if (player.hasStatusEffect(StatusEffects.CooldownPhoenixFireBreath)) {
		if (player.statusEffectv1(StatusEffects.CooldownPhoenixFireBreath) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownPhoenixFireBreath);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownPhoenixFireBreath,1,-1);
		}
	}
	//Illusion
	if (player.hasStatusEffect(StatusEffects.CooldownIllusion)) {
		if (player.statusEffectv1(StatusEffects.CooldownIllusion) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownIllusion);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownIllusion,1,-1);
		}
	}
	if (player.hasStatusEffect(StatusEffects.Illusion)) {
		if (player.statusEffectv1(StatusEffects.Illusion) <= 0) {
			player.removeStatusEffect(StatusEffects.Illusion);
		}
		else {
			player.addStatusValue(StatusEffects.Illusion,1,-1);
		}
	}
	//Terror
	if (player.hasStatusEffect(StatusEffects.CooldownTerror)) {
		if (player.statusEffectv1(StatusEffects.CooldownTerror) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownTerror);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownTerror,1,-1);
		}
	}
	//Fascinate
	if (player.hasStatusEffect(StatusEffects.CooldownFascinate)) {
		if (player.statusEffectv1(StatusEffects.CooldownFascinate) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownFascinate);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownFascinate,1,-1);
		}
	}
	//Compelling Aria
	if (player.hasStatusEffect(StatusEffects.CooldownCompellingAria)) {
		if (player.statusEffectv1(StatusEffects.CooldownCompellingAria) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownCompellingAria);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownCompellingAria,1,-1);
		}
	}
	//Oni Rampage
	if (player.hasStatusEffect(StatusEffects.CooldownOniRampage)) {
		if (player.statusEffectv1(StatusEffects.CooldownOniRampage) <= 0) {
			player.removeStatusEffect(StatusEffects.CooldownOniRampage);
		}
		else {
			player.addStatusValue(StatusEffects.CooldownOniRampage,1,-1);
		}
	}
	//Elemental Aspect status effects
	if (player.hasStatusEffect(StatusEffects.StoneSkin)) {
		if (player.statusEffectv2(StatusEffects.StoneSkin) <= 0) {
			player.removeStatusEffect(StatusEffects.StoneSkin);
			outputText("<b>Stone Skin effect wore off!</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.StoneSkin,2,-1);
	}
	if (player.hasStatusEffect(StatusEffects.BladeDance)) player.removeStatusEffect(StatusEffects.BladeDance);
	if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) player.removeStatusEffect(StatusEffects.ResonanceVolley);
	if (player.hasStatusEffect(StatusEffects.Defend)) player.removeStatusEffect(StatusEffects.Defend);
	regeneration(true);
	if(player.lust >= player.maxLust()) doNext(endLustLoss);
	if(player.HP <= 0) doNext(endHpLoss);
}

public function regeneration(combat:Boolean = true):void {
	var healingPercent:Number = 0;
	if (combat) {
		//Regeneration
		healingPercent = 0;
		if (player.hunger >= 25 || flags[kFLAGS.HUNGER_ENABLED] <= 0)
		{
			if (player.findPerk(PerkLib.Regeneration) >= 0) healingPercent += 0.5;
			if (player.findPerk(PerkLib.Regeneration2) >= 0) healingPercent += 0.5;
			if (player.findPerk(PerkLib.Regeneration3) >= 0) healingPercent += 0.5;
			if (player.findPerk(PerkLib.Regeneration4) >= 0) healingPercent += 0.5;
			if (player.findPerk(PerkLib.Regeneration5) >= 0) healingPercent += 0.5;
			if (player.findPerk(PerkLib.Regeneration6) >= 0) healingPercent += 0.5;
		}
		if (player.armor == armors.NURSECL) healingPercent += 0.5;
		if (player.armor == armors.GOOARMR) healingPercent += (kGAMECLASS.valeria.valeriaFluidsEnabled() ? (flags[kFLAGS.VALERIA_FLUIDS] < 50 ? flags[kFLAGS.VALERIA_FLUIDS] / 25 : 2) : 2);
		if (player.findPerk(PerkLib.LustyRegeneration) >= 0) healingPercent += 0.5;
		if (player.findPerk(PerkLib.LizanRegeneration) >= 0) healingPercent += 1.5;
		if (player.findPerk(PerkLib.LizanMarrow) >= 0) healingPercent += 0.5;
		if (player.findPerk(PerkLib.BodyCultivator) >= 0) healingPercent += 0.5;
		if (player.findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) healingPercent += 1;
		if (player.findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) healingPercent += 1.5;
		if (player.perkv1(PerkLib.Sanctuary) == 1) healingPercent += ((player.corruptionTolerance() - player.cor) / (100 + player.corruptionTolerance()));
		if (player.perkv1(PerkLib.Sanctuary) == 2) healingPercent += player.cor / (100 + player.corruptionTolerance());
		if ((player.internalChimeraRating() >= 1 && player.hunger < 1 && flags[kFLAGS.HUNGER_ENABLED] > 0) || (player.internalChimeraRating() >= 1 && flags[kFLAGS.HUNGER_ENABLED] <= 0)) healingPercent -= (0.5 * player.internalChimeraRating());
		if (healingPercent > maximumRegeneration()) healingPercent = maximumRegeneration();
		HPChange(Math.round((player.maxHP() * healingPercent / 100) + nonPercentBasedRegeneration()), false);
	}
	else {
		//Regeneration
		healingPercent = 0;
		if (player.hunger >= 25 || flags[kFLAGS.HUNGER_ENABLED] <= 0)
		{
			if (player.findPerk(PerkLib.Regeneration) >= 0) healingPercent += 1;
			if (player.findPerk(PerkLib.Regeneration2) >= 0) healingPercent += 1;
			if (player.findPerk(PerkLib.Regeneration3) >= 0) healingPercent += 1;
			if (player.findPerk(PerkLib.Regeneration4) >= 0) healingPercent += 1;
			if (player.findPerk(PerkLib.Regeneration5) >= 0) healingPercent += 1;
			if (player.findPerk(PerkLib.Regeneration6) >= 0) healingPercent += 1;
		}
		if (player.armorName == "skimpy nurse's outfit") healingPercent += 1;
		if (player.armor == armors.NURSECL) healingPercent += 1;
		if (player.armor == armors.GOOARMR) healingPercent += (kGAMECLASS.valeria.valeriaFluidsEnabled() ? (flags[kFLAGS.VALERIA_FLUIDS] < 50 ? flags[kFLAGS.VALERIA_FLUIDS] / 16 : 3) : 3);
		if (player.findPerk(PerkLib.LustyRegeneration) >= 0) healingPercent += 1;
		if (player.findPerk(PerkLib.LizanRegeneration) >= 0) healingPercent += 3;
		if (player.findPerk(PerkLib.LizanMarrow) >= 0) healingPercent += 1;
		if (player.findPerk(PerkLib.BodyCultivator) >= 0) healingPercent += 1;
		if (player.findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) healingPercent += 1;
		if (player.findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) healingPercent += 1;
		if ((player.internalChimeraRating() >= 1 && player.hunger < 1 && flags[kFLAGS.HUNGER_ENABLED] > 0) || (player.internalChimeraRating() >= 1 && flags[kFLAGS.HUNGER_ENABLED] <= 0)) healingPercent -= player.internalChimeraRating();
		if (healingPercent > (maximumRegeneration() * 2)) healingPercent = (maximumRegeneration() * 2);
		HPChange(Math.round((player.maxHP() * healingPercent / 100) + (nonPercentBasedRegeneration() * 2)), false);
	}
}

public function soulforceregeneration(combat:Boolean = true):void {
	var gainedsoulforce:Number = 0;
	if (combat) {
		if (player.findPerk(PerkLib.JobSoulCultivator) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.DaoistCultivator) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.SoulApprentice) >= 0) gainedsoulforce += 2;
		if (player.findPerk(PerkLib.SoulPersonage) >= 0) gainedsoulforce += 2;
		if (player.findPerk(PerkLib.SoulWarrior) >= 0) gainedsoulforce += 2;
		if (player.findPerk(PerkLib.SoulSprite) >= 0) gainedsoulforce += 2;
		if (player.findPerk(PerkLib.SoulScholar) >= 0) gainedsoulforce += 2;
		if (player.findPerk(PerkLib.SoulElder) >= 0) gainedsoulforce += 2;
		if (player.findPerk(PerkLib.SoulExalt) >= 0) gainedsoulforce += 2;
		if (player.findPerk(PerkLib.SoulOverlord) >= 0) gainedsoulforce += 2;
		if (player.findPerk(PerkLib.SoulTyrant) >= 0) gainedsoulforce += 2;
		if (player.findPerk(PerkLib.SoulKing) >= 0) gainedsoulforce += 2;
		if (player.findPerk(PerkLib.SoulEmperor) >= 0) gainedsoulforce += 2;
		if (player.findPerk(PerkLib.SoulAncestor) >= 0) gainedsoulforce += 2;
		if (player.hasStatusEffect(StatusEffects.Defend) && player.findPerk(PerkLib.MasteredDefenceStance) >= 0) gainedsoulforce += 2;
		if (player.hasStatusEffect(StatusEffects.Defend) && player.findPerk(PerkLib.PerfectDefenceStance) >= 0) gainedsoulforce += 2;
		if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) gainedsoulforce *= 2;
		kGAMECLASS.SoulforceChange(gainedsoulforce, false);
	}
	else {
		if (player.findPerk(PerkLib.JobSoulCultivator) >= 0) gainedsoulforce += 8;
		if (player.findPerk(PerkLib.DaoistCultivator) >= 0) gainedsoulforce += 8;
		if (player.findPerk(PerkLib.SoulApprentice) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.SoulPersonage) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.SoulWarrior) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.SoulSprite) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.SoulScholar) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.SoulElder) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.SoulExalt) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.SoulOverlord) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.SoulTyrant) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.SoulKing) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.SoulEmperor) >= 0) gainedsoulforce += 4;
		if (player.findPerk(PerkLib.SoulAncestor) >= 0) gainedsoulforce += 4;
		kGAMECLASS.SoulforceChange(gainedsoulforce, false);
	}
}

public function manaregeneration(combat:Boolean = true):void {
	var gainedmana:Number = 0;
	if (combat) {
		if (player.findPerk(PerkLib.JobSorcerer) >= 0) gainedmana += 10;
		if (player.findPerk(PerkLib.ArcaneRegenerationMinor) >= 0) gainedmana += 5;
		if (player.findPerk(PerkLib.ArcaneRegenerationMajor) >= 0) gainedmana += 10;
		if (player.findPerk(PerkLib.ArcaneRegenerationEpic) >= 0) gainedmana += 15;
		if (player.findPerk(PerkLib.ArcaneRegenerationLegendary) >= 0) gainedmana += 20;
		if (player.hasStatusEffect(StatusEffects.Defend) && player.findPerk(PerkLib.MasteredDefenceStance) >= 0) gainedmana += 10;
		if (player.hasStatusEffect(StatusEffects.Defend) && player.findPerk(PerkLib.PerfectDefenceStance) >= 0) gainedmana += 10;
		gainedmana *= manaRecoveryMultiplier();
		if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) gainedmana *= 2;
		kGAMECLASS.ManaChange(gainedmana, false);
	}
	else {
		if (player.findPerk(PerkLib.JobSorcerer) >= 0) gainedmana += 20;
		if (player.findPerk(PerkLib.ArcaneRegenerationMinor) >= 0) gainedmana += 10;
		if (player.findPerk(PerkLib.ArcaneRegenerationMajor) >= 0) gainedmana += 20;
		if (player.findPerk(PerkLib.ArcaneRegenerationEpic) >= 0) gainedmana += 30;
		if (player.findPerk(PerkLib.ArcaneRegenerationLegendary) >= 0) gainedmana += 40;
		gainedmana *= manaRecoveryMultiplier();
		kGAMECLASS.ManaChange(gainedmana, false);
	}
}

public function wrathregeneration(combat:Boolean = true):void {
	var gainedwrath:Number = 0;
	if (combat) {
		if (player.findPerk(PerkLib.JobBeastWarrior) >= 0) gainedwrath += 2;
		if (player.findPerk(PerkLib.Berzerker) >= 0) gainedwrath += 2;
		if (player.findPerk(PerkLib.Lustzerker) >= 0) gainedwrath += 2;
		if (player.findPerk(PerkLib.Rage) >= 0) gainedwrath += 2;
		if (player.findPerk(PerkLib.Anger) >= 0) gainedwrath += 2;
		if (player.hasStatusEffect(StatusEffects.Berzerking)) gainedwrath += 3;
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) gainedwrath += 3;
		if (player.hasStatusEffect(StatusEffects.Rage)) gainedwrath += 3;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) gainedwrath += 6;
		kGAMECLASS.WrathChange(gainedwrath, false);
	}
	else {
		if (player.findPerk(PerkLib.JobBeastWarrior) >= 0) gainedwrath += 1;
		if (player.findPerk(PerkLib.Berzerker) >= 0) gainedwrath += 1;
		if (player.findPerk(PerkLib.Lustzerker) >= 0) gainedwrath += 1;
		if (player.findPerk(PerkLib.Rage) >= 0) gainedwrath += 1;
		if (player.findPerk(PerkLib.Anger) >= 0) gainedwrath += 1;
		kGAMECLASS.WrathChange(gainedwrath, false);
	}
}

public function maximumRegeneration():Number {
	var maxRegen:Number = 2;
	if (player.newGamePlusMod() >= 1) maxRegen += 1;
	if (player.newGamePlusMod() >= 2) maxRegen += 1;
	if (player.newGamePlusMod() >= 3) maxRegen += 1;
	if (player.newGamePlusMod() >= 4) maxRegen += 1;
	if (player.newGamePlusMod() >= 5) maxRegen += 1;
	if (player.findPerk(PerkLib.LizanRegeneration) >= 0) maxRegen += 1.5;
	if (player.findPerk(PerkLib.LizanMarrow) >= 0) maxRegen += 0.5;
	if (player.findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) maxRegen += 0.5;
	if (player.findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) maxRegen += 0.5;
	return maxRegen;
}

public function nonPercentBasedRegeneration():Number {
	var maxNonPercentRegen:Number = 0;
	if (player.findPerk(PerkLib.Lifeline) >= 0) maxNonPercentRegen += 50;
	if (player.findPerk(PerkLib.Lifeline) >= 0 && flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) maxNonPercentRegen += 50;
	return maxNonPercentRegen;
}

internal var combatRound:int = 0;
public function startCombatImpl(monster_:Monster, plotFight_:Boolean = false):void {
	combatRound = 0;
	kGAMECLASS.plotFight = plotFight_;
	mainView.hideMenuButton( MainView.MENU_DATA );
	mainView.hideMenuButton( MainView.MENU_APPEARANCE );
	mainView.hideMenuButton( MainView.MENU_LEVEL );
	mainView.hideMenuButton( MainView.MENU_PERKS );
	mainView.hideMenuButton( MainView.MENU_STATS );
	showStats();
	//Flag the game as being "in combat"
	inCombat = true;
	monster = monster_;
	if(monster.short == "Ember") {
		monster.pronoun1 = kGAMECLASS.emberScene.emberMF("he","she");
		monster.pronoun2 = kGAMECLASS.emberScene.emberMF("him","her");
		monster.pronoun3 = kGAMECLASS.emberScene.emberMF("his","her");
	}
	//Reduce enemy def if player has precision!
	if(player.findPerk(PerkLib.Precision) >= 0 && player.inte >= 25) {
		if(monster.armorDef <= 10) monster.armorDef = 0;
		else monster.armorDef -= 10;
	}
	if (player.findPerk(PerkLib.WellspringOfLust) >= 0) {
		if (player.findPerk(PerkLib.GreyMage) >= 0 && player.lust < 30) player.lust = 30;
		if (player.findPerk(PerkLib.GreyMage) < 0 && player.lust < 50) player.lust = 50;
	}
	magic.applyAutocast();
	//Bonus stats from monster perks
	if (monster.findPerk(PerkLib.EzekielBlessing) >= 0) {
		monster.str += (5 * (1 + player.newGamePlusMod()));
		monster.tou += (5 * (1 + player.newGamePlusMod()));
		monster.spe += (5 * (1 + player.newGamePlusMod()));
		monster.inte += (5 * (1 + player.newGamePlusMod()));
		monster.lib += (5 * (1 + player.newGamePlusMod()));
	}
	if (monster.findPerk(PerkLib.JobAllRounder) >= 0) {
		monster.str += (10 * (1 + player.newGamePlusMod()));
		monster.tou += (10 * (1 + player.newGamePlusMod()));
		monster.spe += (10 * (1 + player.newGamePlusMod()));
		monster.inte += (10 * (1 + player.newGamePlusMod()));
		monster.wis += (10 * (1 + player.newGamePlusMod()));
		monster.lib += (6 * (1 + player.newGamePlusMod()));
		monster.sens += (6 * (1 + player.newGamePlusMod()));
	}
	if (monster.findPerk(PerkLib.JobBrawler) >= 0) monster.str += (10 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobCourtesan) >= 0) monster.lib += (15 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobDefender) >= 0) monster.tou += (15 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobElementalConjurer) >= 0) monster.wis += (5 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobEnchanter) >= 0) monster.inte += (15 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobEromancer) >= 0) {
		monster.inte += (5 * (1 + player.newGamePlusMod()));
		monster.lib += (5 * (1 + player.newGamePlusMod()));
	}
	if (monster.findPerk(PerkLib.JobGolemancer) >= 0) {
		monster.inte += (5 * (1 + player.newGamePlusMod()));
		monster.wis += (5 * (1 + player.newGamePlusMod()));
	}
	if (monster.findPerk(PerkLib.JobGuardian) >= 0) monster.tou += (5 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobHunter) >= 0) {
		monster.spe += (10 * (1 + player.newGamePlusMod()));
		monster.inte += (5 * (1 + player.newGamePlusMod()));
	}
	if (monster.findPerk(PerkLib.JobKnight) >= 0) monster.tou += (10 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobMonk) >= 0) monster.wis += (15 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobRanger) >= 0) monster.spe += (5 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobSeducer) >= 0) monster.lib += (5 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobSorcerer) >= 0) monster.inte += (5 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobSoulCultivator) >= 0) monster.wis += (5 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobWarlord) >= 0) monster.tou += (20 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.JobWarrior) >= 0) monster.str += (5 * (1 + player.newGamePlusMod()));
	if (monster.findPerk(PerkLib.PrestigeJobArcaneArcher) >= 0) {
		monster.spe += (40 * (1 + player.newGamePlusMod()));
		monster.inte += (40 * (1 + player.newGamePlusMod()));
	}
	if (monster.findPerk(PerkLib.PrestigeJobBerserker) >= 0) {
		monster.str += (60 * (1 + player.newGamePlusMod()));
		monster.tou += (20 * (1 + player.newGamePlusMod()));
	}
	if (monster.findPerk(PerkLib.PrestigeJobSeer) >= 0) {
		monster.inte += (60 * (1 + player.newGamePlusMod()));
		monster.wis += (20 * (1 + player.newGamePlusMod()));
	}
	if (monster.findPerk(PerkLib.PrestigeJobSoulArcher) >= 0) {
		monster.spe += (40 * (1 + player.newGamePlusMod()));
		monster.wis += (40 * (1 + player.newGamePlusMod()));
	}
	if (monster.findPerk(PerkLib.PrestigeJobSoulArtMaster) >= 0) {
		monster.str += (40 * (1 + player.newGamePlusMod()));
		monster.wis += (40 * (1 + player.newGamePlusMod()));
	}
	if (monster.findPerk(PerkLib.DeityJobMunchkin) >= 0) {
		monster.str += (25 * (1 + player.newGamePlusMod()));
		monster.tou += (25 * (1 + player.newGamePlusMod()));
		monster.spe += (25 * (1 + player.newGamePlusMod()));
		monster.inte += (25 * (1 + player.newGamePlusMod()));
		monster.wis += (25 * (1 + player.newGamePlusMod()));
		monster.lib += (15 * (1 + player.newGamePlusMod()));
		monster.sens += (15 * (1 + player.newGamePlusMod()));
	}
	if (monster.findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) {
		monster.str += (10 * (1 + player.newGamePlusMod()));
		monster.tou += (10 * (1 + player.newGamePlusMod()));
		monster.spe += (10 * (1 + player.newGamePlusMod()));
		monster.inte += (10 * (1 + player.newGamePlusMod()));
		monster.wis += (10 * (1 + player.newGamePlusMod()));
		monster.lib += (10 * (1 + player.newGamePlusMod()));
	}
	if (monster.findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) {
		monster.str += (15 * (1 + player.newGamePlusMod()));
		monster.tou += (15 * (1 + player.newGamePlusMod()));
		monster.spe += (15 * (1 + player.newGamePlusMod()));
		monster.inte += (15 * (1 + player.newGamePlusMod()));
		monster.wis += (15 * (1 + player.newGamePlusMod()));
		monster.lib += (15 * (1 + player.newGamePlusMod()));
	}
	//Adjust lust vulnerability in New Game+.
	if (player.newGamePlusMod() == 1) monster.lustVuln *= 0.9;
	else if (player.newGamePlusMod() == 2) monster.lustVuln *= 0.8;
	else if (player.newGamePlusMod() == 3) monster.lustVuln *= 0.7;
	else if (player.newGamePlusMod() >= 4) monster.lustVuln *= 0.6;
	monster.HP = monster.eMaxHP();
	monster.XP = monster.totalXP();
	if (player.weaponRangeName == "gnoll throwing spear") flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 20;
	if (player.weaponRangeName == "gnoll throwing axes") flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 10;
	if (player.weaponRangeName == "training javelins") flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 10;
	if (player.weaponRangeName == "flintlock pistol") flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 4;
	if (player.weaponRangeName == "blunderbuss") flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 2;
	if (player.weaponRange == weaponsrange.SHUNHAR) flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 1;
	if (prison.inPrison && prison.prisonCombatAutoLose) {
		dynStats("lus", player.maxLust(), "resisted", false);
		doNext(endLustLoss);
		return;
	}
	doNext(playerMenu);
}
public function startCombatImmediateImpl(monster_:Monster, _plotFight:Boolean):void
{
	kGAMECLASS.plotFight = _plotFight;
	mainView.hideMenuButton( MainView.MENU_DATA );
	mainView.hideMenuButton( MainView.MENU_APPEARANCE );
	mainView.hideMenuButton( MainView.MENU_LEVEL );
	mainView.hideMenuButton( MainView.MENU_PERKS );
	//Flag the game as being "in combat"
	inCombat = true;
	monster = monster_;
	if(monster.short == "Ember") {
		monster.pronoun1 = kGAMECLASS.emberScene.emberMF("he","she");
		monster.pronoun2 = kGAMECLASS.emberScene.emberMF("him","her");
		monster.pronoun3 = kGAMECLASS.emberScene.emberMF("his","her");
	}
	//Reduce enemy def if player has precision!
	if(player.findPerk(PerkLib.Precision) >= 0 && player.inte >= 25) {
		if(monster.armorDef <= 10) monster.armorDef = 0;
		else monster.armorDef -= 10;
	}
	playerMenu();
}
public function display():void {
	if (!monster.checkCalled){
		outputText("<B>/!\\BUG! Monster.checkMonster() is not called! Calling it now...</B>\n");
		monster.checkMonster();
	}
	if (monster.checkError != ""){
		outputText("<B>/!\\BUG! Monster is not correctly initialized! </B>"+
				monster.checkError+"</u></b>\n");
	}
	var hpDisplay:String = "";
	var lustDisplay:String = "";
	var fatigueDisplay:String = "";
	var manaDisplay:String = "";
	var math:Number = monster.HPRatio();
	//hpDisplay = "(<b>" + String(int(math * 1000) / 10) + "% HP</b>)";
	hpDisplay = monster.HP + " / " + monster.eMaxHP() + " (" + (int(math * 1000) / 10) + "%)";
	lustDisplay = Math.floor(monster.lust) + " / " + monster.eMaxLust();
	fatigueDisplay = Math.floor(monster.fatigue) + " / " + monster.eMaxFatigue();
	manaDisplay = Math.floor(monster.mana) + " / " + monster.eMaxMana();

	//trace("trying to show monster image!");
	if (monster.imageName != "")
	{
		var monsterName:String = "monster-" + monster.imageName;
		//trace("Monster name = ", monsterName);
		outputText(images.showImage(monsterName));
	}
	outputText("<b>You are fighting ");
	outputText(monster.a + monster.short + ":</b> \n");
	if (player.hasStatusEffect(StatusEffects.Blind)) {
		outputText("It's impossible to see anything!\n");
	}
	else {
		outputText(monster.long + "\n\n");
		//Bonus sand trap stuff
		if(monster.hasStatusEffect(StatusEffects.Level)) {
			temp = monster.statusEffectv1(StatusEffects.Level);
			if (monster is SandTrap) {
				//[(new PG for PC height levels)PC level 4: 
				if(temp == 4) outputText("You are right at the edge of its pit.  If you can just manage to keep your footing here, you'll be safe.");
				else if(temp == 3) outputText("The sand sinking beneath your feet has carried you almost halfway into the creature's pit.");
				else outputText("The dunes tower above you and the hissing of sand fills your ears.  <b>The leering sandtrap is almost on top of you!</b>");
				//no new PG)
				outputText("  You could try attacking it with your [weapon], but that will carry you straight to the bottom.  Alternately, you could try to tease it or hit it at range, or wait and maintain your footing until you can clamber up higher.");
			}
			if (monster is Alraune) {
				if (temp == 5|| temp == 6) outputText("The " + monster.short + " keeps pulling you ever closer. You are a fair distance from her for now but she keeps drawing you in.");
				else if(temp == 4) outputText("The " + monster.short + " keeps pulling you ever closer. You are getting dangerously close to her.");
				else outputText("The " + monster.short + " keeps pulling you ever closer. You are almost in the pitcher, the plant woman smiling and waiting with open arms to help you in.  <b>You need to get some distance or you will be grabbed and drawn inside her flower!</b>");
				outputText("  You could try attacking it with your [weapon], but that will carry you straight to the pitcher.  Alternately, you could try to tease it or hit it at range.");
			}
			outputText("\n\n");
		}
		if(monster.plural) {
			if(math >= 1) outputText("You see " + monster.pronoun1 + " are in perfect health.  ");
			else if(math > .75) outputText("You see " + monster.pronoun1 + " aren't very hurt.  ");
			else if(math > .5) outputText("You see " + monster.pronoun1 + " are slightly wounded.  ");
			else if(math > .25) outputText("You see " + monster.pronoun1 + " are seriously hurt.  ");
			else outputText("You see " + monster.pronoun1 + " are unsteady and close to death.  ");
		}
		else {
			if(math >= 1) outputText("You see " + monster.pronoun1 + " is in perfect health.  ");
			else if(math > .75) outputText("You see " + monster.pronoun1 + " isn't very hurt.  ");
			else if(math > .5) outputText("You see " + monster.pronoun1 + " is slightly wounded.  ");
			else if(math > .25) outputText("You see " + monster.pronoun1 + " is seriously hurt.  ");
			else outputText("You see " + monster.pronoun1 + " is unsteady and close to death.  ");
		}
		showMonsterLust();		
		// haha literally fuck organising this shit properly any more
		// BURN THE SHIT TO THE GROUND ON MY WAY OUT INNIT
		if (player.hasStatusEffect(StatusEffects.MinotaurKingMusk))
		{
			if (player.lust <= (player.maxLust() * 0.1)) outputText("\nYou catch yourself looking at the King’s crotch instead of his weapon. Ugh, it’s this scent. It’s so... so powerful, worming its way into you with every breath and reminding you that sex could be a single step away.\n");
			else if (player.lust <= (player.maxLust() * 0.2)) outputText("\nWhy does he have to smell so good? A big guy like that, covered in sweat - he should smell bad, if anything. But he doesn’t. He’s like sea salt and fresh-chopped wood after a quick soak between a slut’s legs. You shiver in what you hope is repulsion.\n");
			else if (player.lust <= (player.maxLust() * 0.3)) outputText("\nYou try to breathe through your mouth to minimize the effect of his alluring musk, but then your mouth starts watering... and your lips feel dry. You lick them a few times, just to keep them nice and moist. Only after a moment do you realize you were staring at his dripping-wet cock and polishing your lips like a wanton whore. You may need to change tactics.\n");
			else if (player.lust <= (player.maxLust() * 0.4))
			{
				outputText("\nGods-damned minotaurs with their tasty-smelling cum and absolutely domineering scent. Just breathing around this guy is making your");
				if (player.tailType != 0) outputText(" tail quiver");
				else if (!player.isBiped()) outputText(" lower body quiver");
				else outputText(" knees weak");
				outputText(". How must it feel to share a bed with such a royal specimen? To luxuriate in his aroma until all you want is for him to use you? If you stick around, you might find out.\n");
			}
			else if (player.lust <= (player.maxLust() * 0.5))
			{
				outputText("\nYou pant. You can’t help it, not with the exertion of fighting and how blessedly <i>warm</i> you’re starting to get between the legs.");
				if (!player.hasCock() && !player.hasVagina()) outputText(" You wish, for a moment, that you hadn’t so carelessly lost your genitalia.");
				outputText(" Trying not to breath about this beast was never going to work anyway.\n");
			}
			else if (player.lust <= (player.maxLust() * 0.6))
			{
				outputText("\nLicking your lips, you can’t help but admire at how intense the Minotaur King is. Everything from his piercing gaze to his diamond - hard cock to the delightful cloud of his natural cologne is extraordinary. Would it be so bad to lose to him?\n");
			}
			else if (player.lust <= (player.maxLust() * 0.7))
			{
				outputText("\nYou look between the gigantic minotaur and his eager pet, wondering just how they manage to have sex. He’s so big and so hard. A cock like that would split her in half, wouldn’t it?");
				if (player.isTaur()) outputText(" She’s not a centaur like you. She couldn’t fit him like a glove, then milk him dry with muscles a humanoid body could never contain.\n");
				else outputText(" She must have been a champion. It’s the only way she could have the fortitude to withstand such a thick, juicy cock. You’re a champion too. Maybe it’ll fit you as well.\n ");
			}	
			else if (player.lust <= (player.maxLust() * 0.8))
			{
				if (player.hasVagina())
				{
					outputText("\nYou’re wet");
					if (player.wetness() >= 4) outputText(", and not just wet in the normal, everyday, ready-to-fuck way");
					outputText(". The pernicious need is slipping inside you with every breath you take around this virile brute, twisting through your body until cunt-moistening feelers are stroking your brain, reminding you how easy it would be to spread your legs. He’s a big, big boy, and you’ve got such a ready, aching pussy.\n");
				}
				else if (player.hasCock())
				{
					outputText("\nYou’re hard - harder than you’d ever expect to be from being face to face with a corrupted bovine’s dripping dick. It just... it smells so good. His whole body does. Even when you duck under a swing, you’re blasted with nothing but pure pheromones. You get dizzy just trying keep your breath, and you desperately want to tend to the ache");
					if (player.isTaur()) outputText(" below.\n");
					else outputText(" between your legs.\n");
				}	
				else outputText("\nHow you can go so far as to remove your genitals and still get so turned on when confronted by a huge prick, you’ll never know. It must be all the pheromones in the air, slipping inside your body, releasing endorphins and sending signals to dormant sections of your brain that demand you mate.\n");
			}
			else if (player.lust <= (player.maxLust() * 0.9))
			{
				outputText("\nYou can’t even stop yourself from staring. Not now, not after getting so fucking horny from an attempt at combat. Lethice is right there behind him, and all you can think about is that fat pillar of flesh between the lordly beast - man’s legs, that delicious looking rod. You doubt you could fit your lips around it without a lot of effort, but if you can’t beat him, you’ll have all the time in the world to practice.\n");
			}
			else
			{
				outputText("\nGods, your head is swimming. It’s hard to stay upright, not because of the dizziness but because you desperately want to bend over and lift your [ass] up in the air to present to the Minotaur King. He’s so powerful, so domineering, that even his scent is like a whip across your");
				if (player.hasVagina()) outputText(" folds");
				else outputText(" ass");
				outputText(", lashing you with strokes of red-hot desire. If you don’t take him down fast, you’re going to become his bitch.\n");
			}
		}
		outputText("\n\n<b><u>" + capitalizeFirstLetter(monster.short) + "'s Stats</u></b>\n");
		outputText("Level: " + monster.level + "\n");
		outputText("HP: " + hpDisplay + "\n");
		outputText("Lust: " + lustDisplay + "\n");
		outputText("Fatigue: " + fatigueDisplay + "\n");
		//soulforce
		outputText("Mana: " + manaDisplay + "\n");
		//wrath
		if (player.findPerk(PerkLib.EyesOfTheHunterNovice) >= 0 && player.sens >= 25) {
			outputText("\n----------------------------\n");
			outputText("\nGeneral Type: ");
			if (monster.hasPerk(PerkLib.EnemyBeastOrAnimalMorphType) >= 0) outputText("< Beast or Animal-morph > ");
			if (monster.hasPerk(PerkLib.EnemyConstructType) >= 0) outputText("< Construct > ");
			if (monster.hasPerk(PerkLib.EnemyGigantType) >= 0) outputText("< Gigant > ");
			if (monster.hasPerk(PerkLib.EnemyGodType) >= 0) outputText("< God > ");
			if (monster.hasPerk(PerkLib.EnemyGroupType) >= 0) outputText("< Group > ");
			if (player.findPerk(PerkLib.EyesOfTheHunterAdept) >= 0 && player.sens >= 50) {
				if (monster.hasPerk(PerkLib.EnemyBossType) >= 0) outputText("< Boss > ");
				outputText("\nElemental Type: ");
				if (monster.hasPerk(PerkLib.DarknessNature) >= 0) outputText("< Darkness Nature > ");
				if (monster.hasPerk(PerkLib.FireNature) >= 0) outputText("< Fire Nature > ");
				if (monster.hasPerk(PerkLib.IceNature) >= 0) outputText("< Ice Nature > ");
				if (monster.hasPerk(PerkLib.LightningNature) >= 0) outputText("< Lightning Nature > ");
				if (player.findPerk(PerkLib.EyesOfTheHunterMaster) >= 0 && player.sens >= 75) {
					if (monster.hasPerk(PerkLib.DarknessVulnerability) >= 0) outputText("< Darkness Vulnerability > ");
					if (monster.hasPerk(PerkLib.FireVulnerability) >= 0) outputText("< Fire Vulnerability > ");
					if (monster.hasPerk(PerkLib.IceVulnerability) >= 0) outputText("< Ice Vulnerability > ");
					if (monster.hasPerk(PerkLib.LightningVulnerability) >= 0) outputText("< Lightning Vulnerability > ");
					//if (monster.hasPerk(PerkLib) >= 0) outputText("");
					//if (monster.hasPerk(PerkLib) >= 0) outputText("");
				}
			}
			outputText("\n");
		}
	}
	if (debug){
		outputText("\n----------------------------\n");
		outputText(monster.generateDebugDescription());
	}
}
public function showMonsterLust():void {
	//Entrapped
	if(monster.hasStatusEffect(StatusEffects.Constricted)) {
		outputText(monster.capitalA + monster.short + " is currently wrapped up in your tail-coils!  ");
	}
	//Venom stuff!
	if(monster.hasStatusEffect(StatusEffects.NagaVenom)) {
		if(monster.plural) {
			if(monster.statusEffectv1(StatusEffects.NagaVenom) <= 1) {
				outputText("You notice " + monster.pronoun1 + " are beginning to show signs of weakening, but there still appears to be plenty of fight left in " + monster.pronoun2 + ".  ");
			}
			else {
				outputText("You notice " + monster.pronoun1 + " are obviously affected by your venom, " + monster.pronoun3 + " movements become unsure, and " + monster.pronoun3 + " balance begins to fade. Sweat begins to roll on " + monster.pronoun3 + " skin. You wager " + monster.pronoun1 + " are probably beginning to regret provoking you.  ");
			}
		}
		//Not plural
		else {
			if(monster.statusEffectv1(StatusEffects.NagaVenom) <= 1) {
				outputText("You notice " + monster.pronoun1 + " is beginning to show signs of weakening, but there still appears to be plenty of fight left in " + monster.pronoun2 + ".  ");
			}
			else {
				outputText("You notice " + monster.pronoun1 + " is obviously affected by your venom, " + monster.pronoun3 + " movements become unsure, and " + monster.pronoun3 + " balance begins to fade. Sweat is beginning to roll on " + monster.pronoun3 + " skin. You wager " + monster.pronoun1 + " is probably beginning to regret provoking you.  ");
			}
		}
		monster.spe -= monster.statusEffectv1(StatusEffects.NagaVenom);
		monster.str -= monster.statusEffectv1(StatusEffects.NagaVenom);
		if (monster.spe < 1) monster.spe = 1;
		if (monster.str < 1) monster.str = 1;
		if (monster.statusEffectv3(StatusEffects.NagaVenom) >= 1) monster.lust += monster.statusEffectv3(StatusEffects.NagaVenom);
		if (monster.lust > monster.eMaxLust()) combatRoundOver();
	}
	if(monster.short == "harpy") {
		//(Enemy slightly aroused) 
		if(monster.lust >= (monster.eMaxLust() * 0.45) && monster.lust < (monster.eMaxLust() * 0.7)) outputText("The harpy's actions are becoming more and more erratic as she runs her mad-looking eyes over your body, her chest jiggling, clearly aroused.  ");
		//(Enemy moderately aroused) 
		if(monster.lust >= (monster.eMaxLust() * 0.7) && monster.lust < (monster.eMaxLust() * 0.9)) outputText("She stops flapping quite so frantically and instead gently sways from side to side, showing her soft, feathery body to you, even twirling and raising her tail feathers, giving you a glimpse of her plush pussy, glistening with fluids.");
		//(Enemy dangerously aroused) 
		if(monster.lust >= (monster.eMaxLust() * 0.9)) outputText("You can see her thighs coated with clear fluids, the feathers matted and sticky as she struggles to contain her lust.");
	}
	else if(monster is Clara)
	{
		//Clara is becoming aroused
		if(monster.lust <= (monster.eMaxLust() * 0.4))	 {}
		else if(monster.lust <= (monster.eMaxLust() * 0.65)) outputText("The anger in her motions is weakening.");
		//Clara is somewhat aroused
		else if(monster.lust <= (monster.eMaxLust() * 0.75)) outputText("Clara seems to be becoming more aroused than angry now.");
		//Clara is very aroused
		else if(monster.lust <= (monster.eMaxLust() * 0.85)) outputText("Clara is breathing heavily now, the signs of her arousal becoming quite visible now.");
		//Clara is about to give in
		else outputText("It looks like Clara is on the verge of having her anger overwhelmed by her lusts.");
	}
	//{Bonus Lust Descripts}
	else if(monster.short == "Minerva") {
		if(monster.lust < (monster.eMaxLust() * 0.4)) {}
		//(40)
		else if(monster.lust < (monster.eMaxLust() * 0.6)) outputText("Letting out a groan Minerva shakes her head, focusing on the fight at hand.  The bulge in her short is getting larger, but the siren ignores her growing hard-on and continues fighting.  ");
		//(60) 
		else if(monster.lust < (monster.eMaxLust() * 0.8)) outputText("Tentacles are squirming out from the crotch of her shorts as the throbbing bulge grows bigger and bigger, becoming harder and harder... for Minerva to ignore.  A damp spot has formed just below the bulge.  ");
		//(80)
		else outputText("She's holding onto her weapon for support as her face is flushed and pain-stricken.  Her tiny, short shorts are painfully holding back her quaking bulge, making the back of the fabric act like a thong as they ride up her ass and struggle against her cock.  Her cock-tentacles are lashing out in every direction.  The dampness has grown and is leaking down her leg.");
	}
	else if(monster.short == "Cum Witch") {
		//{Bonus Lust Desc (40+)}
		if(monster.lust < (monster.eMaxLust() * 0.4)) {}
		else if(monster.lust < (monster.eMaxLust() * 0.5)) outputText("Her nipples are hard, and poke two visible tents into the robe draped across her mountainous melons.  ");
		//{Bonus Lust Desc (50-75)}
		else if(monster.lust < (monster.eMaxLust() * 0.75)) outputText("Wobbling dangerously, you can see her semi-hard shaft rustling the fabric as she moves, evidence of her growing needs.  ");
		//{75+}
		if(monster.lust >= (monster.eMaxLust() * 0.75)) outputText("Swelling obscenely, the Cum Witch's thick cock stands out hard and proud, its bulbous tip rustling through the folds of her fabric as she moves and leaving dark smears in its wake.  ");
		//(85+}
		if(monster.lust >= (monster.eMaxLust() * 0.85)) outputText("Every time she takes a step, those dark patches seem to double in size.  ");
		//{93+}
		if(monster.lust >= (monster.eMaxLust() * 0.93)) outputText("There's no doubt about it, the Cum Witch is dripping with pre-cum and so close to caving in.  Hell, the lower half of her robes are slowly becoming a seed-stained mess.  ");
		//{Bonus Lust Desc (60+)}
		if(monster.lust >= (monster.eMaxLust() * 0.70)) outputText("She keeps licking her lips whenever she has a moment, and she seems to be breathing awfully hard.  ");
	}
	else if(monster.short == "Kelt") {
		//Kelt Lust Levels
		//(sub 50)
		if(monster.lust < (monster.eMaxLust() * 0.5)) outputText("Kelt actually seems to be turned off for once in his miserable life.  His maleness is fairly flaccid and droopy.  ");
		//(sub 60)
		else if(monster.lust < (monster.eMaxLust() * 0.6)) outputText("Kelt's gotten a little stiff down below, but he still seems focused on taking you down.  ");
		//(sub 70)
		else if(monster.lust < (monster.eMaxLust() * 0.7)) outputText("Kelt's member has grown to its full size and even flared a little at the tip.  It bobs and sways with every movement he makes, reminding him how aroused you get him.  ");
		//(sub 80)
		else if(monster.lust < (monster.eMaxLust() * 0.8)) outputText("Kelt is unabashedly aroused at this point.  His skin is flushed, his manhood is erect, and a thin bead of pre has begun to bead underneath.  ");
		//(sub 90)
		else if(monster.lust < (monster.eMaxLust() * 0.9)) outputText("Kelt seems to be having trouble focusing.  He keeps pausing and flexing his muscles, slapping his cock against his belly and moaning when it smears his pre-cum over his equine underside.  ");
		//(sub 100) 
		else outputText("There can be no doubt that you're having quite the effect on Kelt.  He keeps fidgeting, dripping pre-cum everywhere as he tries to keep up the facade of fighting you.  His maleness is continually twitching and bobbing, dripping messily.  He's so close to giving in...");
	}
	else if(monster.short == "green slime") {
		if(monster.lust >= (monster.eMaxLust() * 0.45) && monster.lust < (monster.eMaxLust() * 0.65)) outputText("A lump begins to form at the base of the figure's torso, where its crotch would be.  ");
		if(monster.lust >= (monster.eMaxLust() * 0.65) && monster.lust < (monster.eMaxLust() * 0.85)) outputText("A distinct lump pulses at the base of the slime's torso, as if something inside the creature were trying to escape.  ");
		if(monster.lust >= (monster.eMaxLust() * 0.85) && monster.lust < (monster.eMaxLust() * 0.93)) outputText("A long, thick pillar like a small arm protrudes from the base of the slime's torso.  ");
		if(monster.lust >= (monster.eMaxLust() * 0.93)) outputText("A long, thick pillar like a small arm protrudes from the base of the slime's torso.  Its entire body pulses, and it is clearly beginning to lose its cohesion.  ");
	}
	else if(monster.short == "Sirius, a naga hypnotist") {
		if(monster.lust < (monster.eMaxLust() * 0.4)) {}
		else if(monster.lust >= (monster.eMaxLust() * 0.4)) outputText("You can see the tip of his reptilian member poking out of its protective slit. ");
		else if(monster.lust >= (monster.eMaxLust() * 0.6)) outputText("His cock is now completely exposed and half-erect, yet somehow he still stays focused on your eyes and his face is inexpressive.  ");
		else outputText("His cock is throbbing hard, you don't think it will take much longer for him to pop.   Yet his face still looks inexpressive... despite the beads of sweat forming on his brow.  ");

	}
	else if(monster.short == "kitsune") {
		//Kitsune Lust states:
		//Low
		if(monster.lust > (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.5)) outputText("The kitsune's face is slightly flushed.  She fans herself with her hand, watching you closely.");
		//Med
		else if(monster.lust > (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.75)) outputText("The kitsune's cheeks are bright pink, and you can see her rubbing her thighs together and squirming with lust.");
		//High
		else if(monster.lust > (monster.eMaxLust() * 0.3)) {
			//High (redhead only)
			if(monster.hairColor == "red") outputText("The kitsune is openly aroused, unable to hide the obvious bulge in her robes as she seems to be struggling not to stroke it right here and now.");
			else outputText("The kitsune is openly aroused, licking her lips frequently and desperately trying to hide the trail of fluids dripping down her leg.");
		}
	}
	else if(monster.short == "demons") {
		if(monster.lust > (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6)) outputText("The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you.");
		if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.lust < (monster.eMaxLust() * 0.8)) outputText("The demons are obviously steering clear from damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow. Some are starting to cop quick feels with their other hands and you can smell the demonic lust of a dozen bodies on the air.");
		if(monster.lust >= (monster.eMaxLust() * 0.8)) outputText(" The demons are less and less willing to hit you and more and more willing to just stroke their hands sensuously over you. The smell of demonic lust is thick on the air and part of the group just stands there stroking themselves openly.");
	}
	else {
		if(monster.plural) {
			if(monster.lust > (monster.eMaxLust() * 0.5) && monster.lust < (monster.eMaxLust() * 0.6)) outputText(monster.capitalA + monster.short + "' skin remains flushed with the beginnings of arousal.  ");
			if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.lust < (monster.eMaxLust() * 0.7)) outputText(monster.capitalA + monster.short + "' eyes constantly dart over your most sexual parts, betraying " + monster.pronoun3 + " lust.  ");
			if(monster.cocks.length > 0) {
				if(monster.lust >= (monster.eMaxLust() * 0.7) && monster.lust < (monster.eMaxLust() * 0.85)) outputText(monster.capitalA + monster.short + " are having trouble moving due to the rigid protrusion in " + monster.pronoun3 + " groins.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.85)) outputText(monster.capitalA + monster.short + " are panting and softly whining, each movement seeming to make " + monster.pronoun3 + " bulges more pronounced.  You don't think " + monster.pronoun1 + " can hold out much longer.  ");
			}
			if(monster.vaginas.length > 0) {
				if(monster.lust >= (monster.eMaxLust() * 0.7) && monster.lust < (monster.eMaxLust() * 0.85)) outputText(monster.capitalA + monster.short + " are obviously turned on, you can smell " + monster.pronoun3 + " arousal in the air.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.85)) outputText(monster.capitalA + monster.short + "' " + monster.vaginaDescript() + "s are practically soaked with their lustful secretions.  ");
			}
		}
		else {
			if(monster.lust > (monster.eMaxLust() * 0.5) && monster.lust < (monster.eMaxLust() * 0.6)) outputText(monster.capitalA + monster.short + "'s skin remains flushed with the beginnings of arousal.  ");
			if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.lust < (monster.eMaxLust() * 0.7)) outputText(monster.capitalA + monster.short + "'s eyes constantly dart over your most sexual parts, betraying " + monster.pronoun3 + " lust.  ");
			if(monster.cocks.length > 0) {
				if(monster.lust >= (monster.eMaxLust() * 0.7) && monster.lust < (monster.eMaxLust() * 0.85)) outputText(monster.capitalA + monster.short + " is having trouble moving due to the rigid protrusion in " + monster.pronoun3 + " groin.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.85)) outputText(monster.capitalA + monster.short + " is panting and softly whining, each movement seeming to make " + monster.pronoun3 + " bulge more pronounced.  You don't think " + monster.pronoun1 + " can hold out much longer.  ");
			}
			if(monster.vaginas.length > 0) {
				if(monster.lust >= (monster.eMaxLust() * 0.7) && monster.lust < (monster.eMaxLust() * 0.85)) outputText(monster.capitalA + monster.short + " is obviously turned on, you can smell " + monster.pronoun3 + " arousal in the air.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.85)) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " is practically soaked with her lustful secretions.  ");
			}
		}
	}
}

// This is a bullshit work around to get the parser to do what I want without having to fuck around in it's code.
public function teaseText():String
{
	tease(true);
	return "";
}

// Just text should force the function to purely emit the test text to the output display, and not have any other side effects
public function tease(justText:Boolean = false):void {
	teases.tease(justText);
}

public function teaseXP(XP:Number = 0):void {
	teases.teaseXP(XP);
}

//VICTORY OR DEATH?
public function combatRoundOverImpl():Boolean { //Called after the monster's action
	combatRound++;
	statScreenRefresh();
	flags[kFLAGS.ENEMY_CRITICAL] = 0;
	if (!inCombat) return false;
	if(monster.HP < 1) {
		doNext(endHpVictory);
		return true;
	}
	if(monster.lust > monster.eMaxLust()) {
		doNext(endLustVictory);
		return true;
	}
	if(monster.hasStatusEffect(StatusEffects.Level)) {
		if(monster is SandTrap && (monster as SandTrap).trapLevel() <= 1) {
			kGAMECLASS.desert.sandTrapScene.sandtrapmentLoss();
			return true;
		} else if(monster is Alraune &&(monster as Alraune).trapLevel() <= 1) {
			kGAMECLASS.forest.alrauneScene.alrauneDeepwoodsLost();
			return true;
		}
	}
	if(monster.short == "basilisk" && player.spe <= 1) {
		doNext(endHpLoss);
		return true;
	}
	if(player.HP < 1) {
		doNext(endHpLoss);
		return true;
	}
	if(player.lust >= player.maxLust()) {
		doNext(endLustLoss);
		return true;
	}
	doNext(playerMenu); //This takes us back to the combatMenu and a new combat round
	return false;
}

public function combatOptionsSubMenu():void {
	menu();
	clearOutput();
	if (player.findPerk(PerkLib.DoubleAttack) >= 0 || player.findPerk(PerkLib.DoubleAttackLarge) >= 0 || player.findPerk(PerkLib.Combo) >= 0) {
		outputText("\n<b>You can adjust your melee attack settings.</b>");
		addButton(0,"Melee Opt",kGAMECLASS.perkMenu.doubleAttackOptions);
	}
	if (player.findPerk(PerkLib.DoubleStrike) >= 0 || player.findPerk(PerkLib.ElementalArrows) >= 0 || player.findPerk(PerkLib.Cupid) >= 0) {
		outputText("\n<b>You can adjust your range strike settings.</b>");
		addButton(1,"Range Opt",kGAMECLASS.perkMenu.doubleStrikeOptions);
	}
//	if (player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(2,"Mana",ManaAndSoulforce);
	if (player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) {
		outputText("\n<b>You can adjust your elemental summons behaviour during combat.</b>");
		addButton(3,"Elementals",kGAMECLASS.perkMenu.summonsbehaviourOptions);
	}
	addButton(14, "Back", combatMenu, false);
}

public function ScyllaSqueeze():void {
	clearOutput();
	if (monster.plural) {
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to squeeze " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
	}
	else {
		if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
			outputText("You are too tired to squeeze " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
	}
	if (monster.plural) {
		fatigue(50, 2);
	}
	else fatigue(20, 2);
	var damage:int = monster.eMaxHP() * (.10 + rand(15) / 100) * 1.5;
	if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
	if (monster.plural == true) damage *= 5;
	//Squeeze -
	outputText("You start squeezing your");
	if (monster.plural) {
		outputText(" foes");
	}
	else {
		outputText(" foe");
	}
	outputText(" with your");
	if (monster.plural) {
		outputText(" tentacles");
	}
	else {
		outputText(" tentacle");
	}
	outputText(", leaving " + monster.pronoun2 + " short of breath. You can feel it in your tentacles as " + monster.pronoun3 + " struggles are briefly intensified. ");
	damage = doDamage(damage);
	outputText("\n\n" + monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + damage + "</font></b> damage.");
	//Enemy faints -
	if(monster.HP < 1) {
		outputText("\n\nYou can feel " + monster.a + monster.short + "'s life signs beginning to fade, and before you crush all the life from " + monster.pronoun2 + ", you let go, dropping " +monster.pronoun2 + " to the floor, unconscious but alive.  In no time, " + monster.pronoun3 + "'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
		if(monster.short == "demons")
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
	if(monster.hasStatusEffect(StatusEffects.NagaVenom))
	{
		outputText("You casualy caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half.\n\n");
	}
	else if(monster.gender == 0)
	{
		outputText("You look over " + monster.a + monster.short + ", but can't figure out how to tease such an unusual foe.\n\n");
	}
	if(monster.lustVuln == 0) {
		outputText("You casualy caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
		enemyAI();
		return;
	}
	//(Otherwise)
	else {
		fatigueRecovery();
		manaregeneration();
		soulforceregeneration();
		var damage:Number = 0;
		var chance:Number= 0;
		var bimbo:Boolean = false;
		var bro:Boolean = false;
		var futa:Boolean = false;
		var choices:Array = new Array();
		var select:Number = 0;
		//Tags used for bonus damage and chance later on
		var breasts:Boolean = false;
		var penis:Boolean = false;
		var balls:Boolean = false;
		var vagina:Boolean = false;
		var anus:Boolean = false;
		var ass:Boolean = false;
		//If auto = true, set up bonuses using above flags
		var auto:Boolean = true;
		//==============================
		//Determine basic success chance.
		//==============================
		chance = 60;
		//5% chance for each tease level.
		chance += player.teaseLevel * 5;
		//10% for seduction perk
		if(player.findPerk(PerkLib.Seduction) >= 0) chance += 10;
		//10% for sexy armor types
		if(player.findPerk(PerkLib.SluttySeduction) >= 0 || player.findPerk(PerkLib.WizardsEnduranceAndSluttySeduction) >= 0) chance += 10;
		//10% for bimbo shits
		if(player.findPerk(PerkLib.BimboBody) >= 0) {
			chance += 10;
			bimbo = true;
		}
		if(player.findPerk(PerkLib.BroBody) >= 0) {
			chance += 10;
			bro = true;
		}
		if(player.findPerk(PerkLib.FutaForm) >= 0) {
			chance += 10;
			futa = true;
		}
		//2 & 2 for seductive valentines!
		if(player.findPerk(PerkLib.SensualLover) >= 0) {
			chance += 2;
		}
		//==============================
		//Determine basic damage.
		//==============================
		damage = 6 + rand(3);
		if(player.findPerk(PerkLib.SensualLover) >= 0) {
			damage += 2;
		}
		if(player.findPerk(PerkLib.Seduction) >= 0) damage += 5;
		//+ slutty armor bonus
		if(player.findPerk(PerkLib.SluttySeduction) >= 0) damage += player.perkv1(PerkLib.SluttySeduction);
		if(player.findPerk(PerkLib.WizardsEnduranceAndSluttySeduction) >= 0) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
		//10% for bimbo shits
		if(bimbo || bro || futa) {
			damage += 5;
			bimbo = true;
		}
		damage += player.level;
		damage += player.teaseLevel*2;
		damage += rand(7);
		//partial skins bonuses
		switch (player.coatType()) {
			case SKIN_COAT_FUR:
				damage += (1 + player.newGamePlusMod());
				break;
			case SKIN_COAT_SCALES:
				damage += (2 * (1 + player.newGamePlusMod()));
				break;
			case SKIN_COAT_CHITIN:
				damage += (3 * (1 + player.newGamePlusMod()));
				break;
			case SKIN_COAT_BARK:
				damage += (4 * (1 + player.newGamePlusMod()));
				break;
		}
		chance += 2;
		//Specific cases for slimes and demons, as the normal ones would make no sense
		if(monster.short == "demons") {
			outputText("As you stimulate one of their brethren, the other demons can't help but to feel more aroused by this sight, all wishing to touch and feel the contact of your smooth, scaly body.");
		}
		else if(monster.short == "slime") {
			outputText("You attempt to stimulate the slime despite its lack of any sex organs. Somehow, it works!");
		}
		//Normal cases for other monsters
		else {
			if(monster.gender == 1)
			{
				outputText("Your nimble tentacle begins to gently stroke his " + monster.cockDescriptShort(0) + ", and you can see it on his face as he tries to hold back the fact that it feels good.");
			}
			if(monster.gender == 2)
			{
				outputText("Your nimble tentacle manages to work its way between her legs, grinding your tentacle's slippery skin against her clit. She appears to enjoy it, but it is obvious she is trying to hide it from you.");
			}
			if(monster.gender == 3)
			{
				outputText("Your nimble tentacle manages to work its way between " + monster.pronoun3 + " legs, gaining access to both sets of genitals. As your slippery skin rubs past " + monster.pronoun3 + " clit, your tentacle gently begins to stroke " + monster.pronoun3 + " cock. The repressed expression on " + monster.pronoun3 + " face betrays " + monster.pronoun3 + " own enjoyment of this kind of treatment.");
			}
		}
		//Land the hit!
		if(rand(100) <= chance) {
			//NERF TEASE DAMAGE
			damage *= .9;
			if(player.findPerk(PerkLib.HistoryWhore) >= 0 || player.findPerk(PerkLib.PastLifeWhore) >= 0) {
				damage *= 1.15;
			}
			if (player.findPerk(PerkLib.DazzlingDisplay) >= 0 && rand(100) < 10) damage *= 1.2;
			//Determine if critical tease!
			var crit:Boolean = false;
			var critChance:int = 5;
			if (player.findPerk(PerkLib.CriticalPerformance) >= 0) {
				if (player.lib <= 100) critChance += player.lib / 5;
				if (player.lib > 100) critChance += 20;
			}
			if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			monster.teased(monster.lustVuln * damage);
			if (crit == true) outputText(" <b>Critical!</b>");
			teaseXP(1);
		}
		//Nuttin honey
		else {
			teaseXP(5);
			outputText("\n" + monster.capitalA + monster.short + " seems unimpressed.");
		}
		outputText("\n\n");
		if(monster.lust >= monster.eMaxLust()) {
			doNext(endLustVictory);
			return;
		}
	}
	enemyAI();
}
public function ScyllaLeggoMyEggo():void {
	clearOutput();
	outputText("You release " + monster.a + monster.short + " from " + monster.pronoun3 + " bonds, and " + monster.pronoun1 + " drops to the ground, catching " + monster.pronoun3 + " breath before " + monster.pronoun1 + " stands back up, apparently prepared to fight some more.");
	outputText("\n\n");
	monster.removeStatusEffect(StatusEffects.ConstrictedScylla);
	enemyAI();
}

public function GooTease():void {
	clearOutput();
	//(if poisoned)
	if(monster.hasStatusEffect(StatusEffects.NagaVenom))
	{
		outputText("You casualy caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half.\n\n");
	}
	else if(monster.gender == 0)
	{
		outputText("You look over " + monster.a + monster.short + ", but can't figure out how to tease such an unusual foe.\n\n");
	}
	if(monster.lustVuln == 0) {
		outputText("You casualy caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
		enemyAI();
		return;
	}
	//(Otherwise)
	else {
		fatigueRecovery();
		manaregeneration();
		soulforceregeneration();
		var damage:Number = 0;
		var chance:Number= 0;
		var bimbo:Boolean = false;
		var bro:Boolean = false;
		var futa:Boolean = false;
		var choices:Array = new Array();
		var select:Number = 0;
		//Tags used for bonus damage and chance later on
		var breasts:Boolean = false;
		var penis:Boolean = false;
		var balls:Boolean = false;
		var vagina:Boolean = false;
		var anus:Boolean = false;
		var ass:Boolean = false;
		//If auto = true, set up bonuses using above flags
		var auto:Boolean = true;
		//==============================
		//Determine basic success chance.
		//==============================
		chance = 60;
		//5% chance for each tease level.
		chance += player.teaseLevel * 5;
		//10% for seduction perk
		if(player.findPerk(PerkLib.Seduction) >= 0) chance += 10;
		//10% for sexy armor types
		if(player.findPerk(PerkLib.SluttySeduction) >= 0 || player.findPerk(PerkLib.WizardsEnduranceAndSluttySeduction) >= 0) chance += 10;
		//10% for bimbo shits
		if(player.findPerk(PerkLib.BimboBody) >= 0) {
			chance += 10;
			bimbo = true;
		}
		if(player.findPerk(PerkLib.BroBody) >= 0) {
			chance += 10;
			bro = true;
		}
		if(player.findPerk(PerkLib.FutaForm) >= 0) {
			chance += 10;
			futa = true;
		}
		//2 & 2 for seductive valentines!
		if(player.findPerk(PerkLib.SensualLover) >= 0) {
			chance += 2;
		}
		//==============================
		//Determine basic damage.
		//==============================
		damage = 6 + rand(3);
		if(player.findPerk(PerkLib.SensualLover) >= 0) {
			damage += 2;
		}
		if(player.findPerk(PerkLib.Seduction) >= 0) damage += 5;
		//+ slutty armor bonus
		if(player.findPerk(PerkLib.SluttySeduction) >= 0) damage += player.perkv1(PerkLib.SluttySeduction);
		if(player.findPerk(PerkLib.WizardsEnduranceAndSluttySeduction) >= 0) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
		//10% for bimbo shits
		if(bimbo || bro || futa) {
			damage += 5;
			bimbo = true;
		}
		damage += player.level;
		damage += player.teaseLevel*2;
		damage += rand(7);
		//partial skins bonuses
		switch (player.coatType()) {
			case SKIN_COAT_FUR:
				damage += (1 + player.newGamePlusMod());
				break;
			case SKIN_COAT_SCALES:
				damage += (2 * (1 + player.newGamePlusMod()));
				break;
			case SKIN_COAT_CHITIN:
				damage += (3 * (1 + player.newGamePlusMod()));
				break;
			case SKIN_COAT_BARK:
				damage += (4 * (1 + player.newGamePlusMod()));
				break;
		}
		chance += 2;
		//Land the hit!
		if(rand(100) <= chance) {
			outputText("You start to play with " + monster.a + monster.short + " body ");
			if(monster.gender == 1)
			{
				outputText("stroking his " + monster.cockDescriptShort(0) + " from inside of you to feast on his precum.");
			}
			if(monster.gender == 2)
			{
				outputText("forcefully filling her pussy and ass with your fluid form as you molest her breast.");
			}
			if(monster.gender == 3)
			{
				outputText("forcefully filling her pussy and ass with your fluid form as you molest her breast. Unsatisfied with her female parts you also stroke her cock to feast on her precum.");
			}
			outputText(" This feels very pleasurable to you but not as much as to your opponent who start to drool at your ministration.");
			//NERF TEASE DAMAGE
			damage += libidoscalingbonus();
			damage *= 0.25;
			damage = Math.round(damage);
			if(player.findPerk(PerkLib.HistoryWhore) >= 0 || player.findPerk(PerkLib.PastLifeWhore) >= 0) {
				damage *= 1.15;
			}
			if (player.findPerk(PerkLib.DazzlingDisplay) >= 0 && rand(100) < 10) damage *= 1.2;
			//Determine if critical tease!
			var crit:Boolean = false;
			var critChance:int = 5;
			if (player.findPerk(PerkLib.CriticalPerformance) >= 0) {
				if (player.lib <= 100) critChance += player.lib / 5;
				if (player.lib > 100) critChance += 20;
			}
			if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			monster.teased(monster.lustVuln * damage);
			if (crit == true) outputText(" <b>Critical!</b>");
			teaseXP(1);
		}
		//Nuttin honey
		else {
			teaseXP(5);
			outputText("\n" + monster.capitalA + monster.short + " seems unimpressed.");
		}
		outputText("\n\n");
		if(monster.lust >= monster.eMaxLust()) {
			doNext(endLustVictory);
			return;
		}
	}
	enemyAI();
}
public function GooLeggoMyEggo():void {
	clearOutput();
	outputText("You release " + monster.a + monster.short + " from your body and " + monster.pronoun1 + " drops to the ground, catching " + monster.pronoun3 + " breath before " + monster.pronoun1 + " stands back up, apparently prepared to fight some more.");
	outputText("\n\n");
	monster.removeStatusEffect(StatusEffects.GooEngulf);
	enemyAI();
}


public function runAway(callHook:Boolean = true):void {
	if (callHook && monster.onPcRunAttempt != null){
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
	if(player.inRut && monster.totalCocks() > 0) {
		clearOutput();
		outputText("The thought of another male in your area competing for all the pussy infuriates you!  No way will you run!");
//Pass false to combatMenu instead:		menuLoc = 3;
//		doNext(combatMenu);
		menu();
		addButton(0, "Next", combatMenu, false);
		return;
	}
	if(monster.hasStatusEffect(StatusEffects.Level) && player.canFly() && monster is SandTrap) {
		clearOutput();
		outputText("You flex the muscles in your back and, shaking clear of the sand, burst into the air!  Wasting no time you fly free of the sandtrap and its treacherous pit.  \"One day your wings will fall off, little ant,\" the snarling voice of the thwarted androgyne carries up to you as you make your escape.  \"And I will be waiting for you when they do!\"");
		inCombat = false;
		clearStatuses(false);
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	if(monster.hasStatusEffect(StatusEffects.GenericRunDisabled) || kGAMECLASS.urtaQuest.isUrta()) {
		outputText("You can't escape from this fight!");
//Pass false to combatMenu instead:		menuLoc = 3;
//		doNext(combatMenu);
		menu();
		addButton(0, "Next", combatMenu, false);
		return;
	}
	if(monster.hasStatusEffect(StatusEffects.Level) && monster.statusEffectv1(StatusEffects.Level) < 4 && monster is SandTrap) {
		outputText("You're too deeply mired to escape!  You'll have to <b>climb</b> some first!");
//Pass false to combatMenu instead:		menuLoc = 3;
//		doNext(combatMenu);
		menu();
		addButton(0, "Next", combatMenu, false);
		return;
	}
	if(monster.hasStatusEffect(StatusEffects.RunDisabled)) {
		outputText("You'd like to run, but you can't scale the walls of the pit with so many demonic hands pulling you down!");
//Pass false to combatMenu instead:		menuLoc = 3;
//		doNext(combatMenu);
		menu();
		addButton(0, "Next", combatMenu, false);
		return;
	}
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00329] == 1 && (monster.short == "minotaur gang" || monster.short == "minotaur tribe")) {
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00329] = 0;
		//(Free run away) 
		clearOutput();
		outputText("You slink away while the pack of brutes is arguing.  Once they finish that argument, they'll be sorely disappointed!");
		inCombat = false;
		clearStatuses(false);
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	else if(monster.short == "minotaur tribe" && monster.HPRatio() >= 0.75) {
		clearOutput();
		outputText("There's too many of them surrounding you to run!");
//Pass false to combatMenu instead:		menuLoc = 3;
//		doNext(combatMenu);
		menu();
		addButton(0, "Next", combatMenu, false);
		return;
	}
	if(inDungeon || inRoomedDungeon) {
		clearOutput();
		outputText("You're trapped in your foe's home turf - there is nowhere to run!\n\n");
		enemyAI();
		return;
	}
	if (prison.inPrison && !prison.prisonCanEscapeRun()) {
		addButton(0, "Next", combatMenu, false);
		return;
	}
	//Attempt texts!
	if(monster.short == "Marae") {
		outputText("Your boat is blocked by tentacles! ");
		if(!player.canFly()) outputText("You may not be able to swim fast enough. ");
		else outputText("You grit your teeth with effort as you try to fly away but the tentacles suddenly grab your [legs] and pull you down. ");
		outputText("It looks like you cannot escape. ");
		enemyAI();
		return;
	}
	if(monster.short == "Ember") {
		outputText("You take off");
		if(!player.canFly()) outputText(" running");
		else outputText(", flapping as hard as you can");
		outputText(", and Ember, caught up in the moment, gives chase.  ");
	}
	if (monster.short == "lizan rogue") {
		outputText("As you retreat the lizan doesn't even attempt to stop you. When you look back to see if he's still there you find nothing but the empty bog around you.");
		kGAMECLASS.inCombat = false;
		clearStatuses(false);
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	else if(player.canFly()) outputText("Gritting your teeth with effort, you beat your wings quickly and lift off!  ");
	//Nonflying PCs
	else {
		//In prison!
		if (prison.inPrison) {
			outputText("You make a quick dash for the door and attempt to escape! ");
		}
		//Stuck!
		else if(player.hasStatusEffect(StatusEffects.NoFlee)) {
			clearOutput();
			if(monster.short == "goblin") outputText("You try to flee but get stuck in the sticky white goop surrounding you.\n\n");
			else outputText("You put all your skills at running to work and make a supreme effort to escape, but are unable to get away!\n\n");
			enemyAI();
			return;
		}
		//Nonstuck!
		else outputText("You turn tail and attempt to flee!  ");
	}
		
	//Calculations
	var escapeMod:Number = 20 + monster.level * 3;
	if(debug) escapeMod -= 300;
	if(player.canFly()) escapeMod -= 20;
	if(player.tailType == TAIL_TYPE_RACCOON && player.earType == EARS_RACCOON && player.findPerk(PerkLib.Runner) >= 0) escapeMod -= 25;
	if(monster.hasStatusEffect(StatusEffects.Stunned)) escapeMod -= 50;
	
	//Big tits doesn't matter as much if ya can fly!
	else {
		if(player.biggestTitSize() >= 35) escapeMod += 5;
		if(player.biggestTitSize() >= 66) escapeMod += 10;
		if(player.hipRating >= 20) escapeMod += 5;
		if(player.buttRating >= 20) escapeMod += 5;
		if(player.ballSize >= 24 && player.balls > 0) escapeMod += 5;
		if(player.ballSize >= 48 && player.balls > 0) escapeMod += 10;
		if(player.ballSize >= 120 && player.balls > 0) escapeMod += 10;
	}
	//ANEMONE OVERRULES NORMAL RUN
	if(monster.short == "anemone") {
		//Autosuccess - less than 60 lust
		if(player.lust < (player.maxLust() * 0.6)) {
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
			if(player.spe > rand(monster.spe+escapeMod)) {
				inCombat = false;
				clearStatuses(false);
				clearOutput();
				outputText("Marshalling your thoughts, you frown at the strange girl and turn to march up the beach.  After twenty paces inshore you turn back to look at her again.  The anemone is clearly crestfallen by your departure, pouting heavily as she sinks beneath the water's surface.");
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			//Run failed:
			else {
				outputText("You try to shake off the fog and run but the anemone slinks over to you and her tentacles wrap around your waist.  <i>\"Stay?\"</i> she asks, pressing her small breasts into you as a tentacle slides inside your [armor] and down to your nethers.  The combined stimulation of the rubbing and the tingling venom causes your knees to buckle, hampering your resolve and ending your escape attempt.");
				//(gain lust, temp lose spd/str)
				(monster as Anemone).applyVenom((4+player.sens/20));
				combatRoundOver();
				return;
			}
		}
	}
	//SEA ANEMONE OVERRULES NORMAL RUN
	if(monster.short == "sea anemone") {
		//Autosuccess - less than 60 lust
		if(player.lust < (player.maxLust() * 0.6)) {
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
			if(player.spe > rand(monster.spe+escapeMod)) {
				inCombat = false;
				clearStatuses(false);
				clearOutput();
				outputText("Marshalling your thoughts, you frown at the strange girl and turn to march up the beach.  After twenty paces inshore you turn back to look at her again.  The anemone is clearly crestfallen by your departure, pouting heavily as she sinks beneath the water's surface.");
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			//Run failed:
			else {
				outputText("You try to shake off the fog and run but the anemone slinks over to you and her tentacles wrap around your waist.  <i>\"Stay?\"</i> she asks, pressing her small breasts into you as a tentacle slides inside your [armor] and down to your nethers.  The combined stimulation of the rubbing and the tingling venom causes your knees to buckle, hampering your resolve and ending your escape attempt.");
				//(gain lust, temp lose spd/str)
				(monster as SeaAnemone).applyVenom((4+player.sens/20));
				combatRoundOver();
				return;
			}
		}
	}
	//Ember is SPUCIAL
	if(monster.short == "Ember") {
		//GET AWAY
		if(player.spe > rand(monster.spe + escapeMod) || (player.findPerk(PerkLib.Runner) >= 0 && rand(100) < 50)) {
			if(player.findPerk(PerkLib.Runner) >= 0) outputText("Using your skill at running, y");
			else outputText("Y");
			outputText("ou easily outpace the dragon, who begins hurling imprecations at you.  \"What the hell, [name], you weenie; are you so scared that you can't even stick out your punishment?\"");
			outputText("\n\nNot to be outdone, you call back, \"Sucks to you!  If even the mighty Last Ember of Hope can't catch me, why do I need to train?  Later, little bird!\"");
			inCombat = false;
			clearStatuses(false);
			doNext(camp.returnToCampUseOneHour);
		}
		//Fail: 
		else {
			outputText("Despite some impressive jinking, " + kGAMECLASS.emberScene.emberMF("he","she") + " catches you, tackling you to the ground.\n\n");
			enemyAI();
		}
		return;
	}
	//SUCCESSFUL FLEE
	if (player.spe > rand(monster.spe + escapeMod)) {
		//Escape prison
		if (prison.inPrison) {
			outputText("You quickly bolt out of the main entrance and after hiding for a good while, there's no sign of " + monster.a + " " + monster.short + ". You sneak back inside to retrieve whatever you had before you were captured. ");
			inCombat = false;
			clearStatuses(false);
			prison.prisonEscapeSuccessText();
			doNext(prison.prisonEscapeFinalePart1);
			return;
		}
		//Fliers flee!
		else if(player.canFly()) outputText(monster.capitalA + monster.short + " can't catch you.");
		//sekrit benefit: if you have coon ears, coon tail, and Runner perk, change normal Runner escape to flight-type escape
		else if(player.tailType == TAIL_TYPE_RACCOON && player.earType == EARS_RACCOON && player.findPerk(PerkLib.Runner) >= 0) {
			outputText("Using your running skill, you build up a head of steam and jump, then spread your arms and flail your tail wildly; your opponent dogs you as best " + monster.pronoun1 + " can, but stops and stares dumbly as your spastic tail slowly propels you several meters into the air!  You leave " + monster.pronoun2 + " behind with your clumsy, jerky, short-range flight.");
		}
		//Non-fliers flee
		else outputText(monster.capitalA + monster.short + " rapidly disappears into the shifting landscape behind you.");
		if(monster.short == "Izma") {
			outputText("\n\nAs you leave the tigershark behind, her taunting voice rings out after you.  \"<i>Oooh, look at that fine backside!  Are you running or trying to entice me?  Haha, looks like we know who's the superior specimen now!  Remember: next time we meet, you owe me that ass!</i>\"  Your cheek tingles in shame at her catcalls.");
		}
		inCombat = false;
		clearStatuses(false);
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	//Runner perk chance
	else if(player.findPerk(PerkLib.Runner) >= 0 && rand(100) < 50) {
		inCombat = false;
		outputText("Thanks to your talent for running, you manage to escape.");
		if(monster.short == "Izma") {
			outputText("\n\nAs you leave the tigershark behind, her taunting voice rings out after you.  \"<i>Oooh, look at that fine backside!  Are you running or trying to entice me?  Haha, looks like we know who's the superior specimen now!  Remember: next time we meet, you owe me that ass!</i>\"  Your cheek tingles in shame at her catcalls.");
		}
		clearStatuses(false);
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	//FAIL FLEE
	else {
		if(monster.short == "Holli") {
			(monster as Holli).escapeFailWithHolli();
			return;
		}
		//Flyers get special failure message.
		if(player.canFly()) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " manage to grab your [legs] and drag you back to the ground before you can fly away!");
			else outputText(monster.capitalA + monster.short + " manages to grab your [legs] and drag you back to the ground before you can fly away!");
		}
		//fail
		else if(player.tailType == TAIL_TYPE_RACCOON && player.earType == EARS_RACCOON && player.findPerk(PerkLib.Runner) >= 0) outputText("Using your running skill, you build up a head of steam and jump, but before you can clear the ground more than a foot, your opponent latches onto you and drags you back down with a thud!");
		//Nonflyer messages
		else {
			//Huge balls messages
			if(player.balls > 0 && player.ballSize >= 24) {
				if(player.ballSize < 48) outputText("With your [balls] swinging ponderously beneath you, getting away is far harder than it should be.  ");
				else outputText("With your [balls] dragging along the ground, getting away is far harder than it should be.  ");
			}
			//FATASS BODY MESSAGES
			if(player.biggestTitSize() >= 35 || player.buttRating >= 20 || player.hipRating >= 20)
			{
				//FOR PLAYERS WITH GIANT BREASTS
				if(player.biggestTitSize() >= 35 && player.biggestTitSize() < 66)
				{
					if(player.hipRating >= 20)
					{
						outputText("Your " + hipDescript() + " forces your gait to lurch slightly side to side, which causes the fat of your " + player.skinTone + " ");
						if(player.buttRating >= 20) outputText(buttDescript() + " and ");
						outputText(chestDesc() + " to wobble immensely, throwing you off balance and preventing you from moving quick enough to escape.");
					}
					else if(player.buttRating >= 20) outputText("Your " + player.skinTone + buttDescript() + " and " + chestDesc() + " wobble and bounce heavily, throwing you off balance and preventing you from moving quick enough to escape.");
					else outputText("Your " + chestDesc() + " jiggle and wobble side to side like the " + player.skinTone + " sacks of milky fat they are, with such force as to constantly throw you off balance, preventing you from moving quick enough to escape.");
				}
				//FOR PLAYERS WITH MASSIVE BREASTS
				else if(player.biggestTitSize() >= 66) {
					if(player.hipRating >= 20) {
						outputText("Your " + chestDesc() + " nearly drag along the ground while your " + hipDescript() + " swing side to side ");
						if(player.buttRating >= 20) outputText("causing the fat of your " + player.skinTone + buttDescript() + " to wobble heavily, ");
						outputText("forcing your body off balance and preventing you from moving quick enough to get escape.");
					}
					else if(player.buttRating >= 20) outputText("Your " +chestDesc() + " nearly drag along the ground while the fat of your " + player.skinTone + buttDescript() + " wobbles heavily from side to side, forcing your body off balance and preventing you from moving quick enough to escape.");
					else outputText("Your " + chestDesc() + " nearly drag along the ground, preventing you from moving quick enough to get escape.");
				}
				//FOR PLAYERS WITH EITHER GIANT HIPS OR BUTT BUT NOT THE BREASTS
				else if(player.hipRating >= 20) {
					outputText("Your " + hipDescript() + " swing heavily from side to side ");
					if(player.buttRating >= 20) outputText("causing your " + player.skinTone + buttDescript() + " to wobble obscenely ");
					outputText("and forcing your body into an awkward gait that slows you down, preventing you from escaping.");
				}
				//JUST DA BOOTAH
				else if(player.buttRating >= 20) outputText("Your " + player.skinTone + buttDescript() + " wobbles so heavily that you're unable to move quick enough to escape.");
			}
			//NORMAL RUN FAIL MESSAGES
			else if(monster.plural) outputText(monster.capitalA + monster.short + " stay hot on your heels, denying you a chance at escape!");
			else outputText(monster.capitalA + monster.short + " stays hot on your heels, denying you a chance at escape!");
		}
	}
	outputText("\n\n");
	enemyAI();
}

public function takeFlight():void {
	clearOutput();
	outputText("You open you wing taking flight.\n\n");
	player.createStatusEffect(StatusEffects.Flying, 7, 0, 0, 0);
	if (player.findPerk(PerkLib.Resolute) < 0) {
		player.createStatusEffect(StatusEffects.FlyingNoStun, 0, 0, 0, 0);
		player.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
	}
	monster.createStatusEffect(StatusEffects.MonsterAttacksDisabled, 0, 0, 0, 0);
	enemyAI();
}

public function greatDive():void {
	flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
	clearOutput();
	if(player.fatigue + physicalCost(50) > player.maxFatigue()) {
		clearOutput();
		outputText("You are too tired to perform a great dive attack.");
		doNext(combatMenu);
		return;
	}
	doNext(combatMenu);
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
	fatigue(50,1);
	var damage:Number = unarmedAttack();
	damage += player.str;
	damage += player.spe * 2;
	if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
	outputText("You focus on " + monster.capitalA + monster.short + " fold your wing and dive down using gravity to increase the impact");
	if (player.lowerBody == LOWER_BODY_TYPE_HARPY) {
		outputText("making a bloody trail with your talons");
		damage *= 1.5;
	}
	else outputText(" hitting your target with violence");
	damage = Math.round(damage);
	damage = doDamage(damage);
	checkAchievementDamage(damage);
	outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>).\n\n");
	if (player.hasStatusEffect(StatusEffects.Flying)) player.removeStatusEffect(StatusEffects.Flying);
	if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
		player.removeStatusEffect(StatusEffects.FlyingNoStun);
		player.removePerk(PerkLib.Resolute);
	}
	monster.removeStatusEffect(StatusEffects.MonsterAttacksDisabled);
	enemyAI();
}
public function toughnessscalingbonus():Number {
	var toughnessscalingvalue:Number = 0;
	if (player.tou >= 21) toughnessscalingvalue += player.tou - 20;
	if (player.tou >= 41) toughnessscalingvalue += player.tou - 40;
	if (player.tou >= 61) toughnessscalingvalue += player.tou - 60;
	if (player.tou >= 81) toughnessscalingvalue += player.tou - 80;
	if (player.tou >= 101) toughnessscalingvalue += player.tou - 100;
	if (player.tou >= 151) toughnessscalingvalue += player.tou - 150;
	if (player.tou >= 201) toughnessscalingvalue += player.tou - 200;
	if (player.tou >= 251) toughnessscalingvalue += player.tou - 250;
	if (player.tou >= 301) toughnessscalingvalue += player.tou - 300;
	if (player.tou >= 351) toughnessscalingvalue += player.tou - 350;
	if (player.tou >= 401) toughnessscalingvalue += player.tou - 400;
	if (player.tou >= 451) toughnessscalingvalue += player.tou - 450;
	if (player.tou >= 501) toughnessscalingvalue += player.tou - 500;
	if (player.tou >= 551) toughnessscalingvalue += player.tou - 550;
	if (player.tou >= 601) toughnessscalingvalue += player.tou - 600;
	if (player.tou >= 651) toughnessscalingvalue += player.tou - 650;
	if (player.tou >= 701) toughnessscalingvalue += player.tou - 700;
	if (player.tou >= 751) toughnessscalingvalue += player.tou - 750;
	if (player.tou >= 801) toughnessscalingvalue += player.tou - 800;
	if (player.tou >= 851) toughnessscalingvalue += player.tou - 850;
	if (player.tou >= 901) toughnessscalingvalue += player.tou - 900;
	if (player.tou >= 951) toughnessscalingvalue += player.tou - 950;
	if (player.tou >= 1001) toughnessscalingvalue += player.tou - 1000;
	if (player.tou >= 1051) toughnessscalingvalue += player.tou - 1050;
	if (player.tou >= 1101) toughnessscalingvalue += player.tou - 1100;
	if (player.tou >= 1151) toughnessscalingvalue += player.tou - 1150;
	if (player.tou >= 1201) toughnessscalingvalue += player.tou - 1200;
	return toughnessscalingvalue;
}


public function soulskillMod():Number {
	var modss:Number = 1;
	if(player.findPerk(PerkLib.DaoistCultivator) >= 0) modss += .1;		// && player.inte >= 25 (zmienić na wisdom)
	if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) {
		if (player.findPerk(PerkLib.SoulApprentice) >= 0) modss += .2;		// && player.inte >= 25 (zmienić na wisdom)
		if (player.findPerk(PerkLib.SoulPersonage) >= 0) modss += .2;		// && player.inte >= 25 (zmienić na wisdom)
		if (player.findPerk(PerkLib.SoulWarrior) >= 0) modss += .2;			// && player.inte >= 25 (zmienić na wisdom)
	}
	if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) {
		if (player.findPerk(PerkLib.SoulSprite) >= 0) modss += .3;			// && player.inte >= 25 (zmienić na wisdom)
		if (player.findPerk(PerkLib.SoulScholar) >= 0) modss += .3;			// && player.inte >= 25 (zmienić na wisdom)
		if (player.findPerk(PerkLib.SoulElder) >= 0) modss += .3;		// && player.inte >= 25 (zmienić na wisdom)
	}
	if (player.findPerk(PerkLib.DaoistElderStage) >= 0) {
		if (player.findPerk(PerkLib.SoulExalt) >= 0) modss += .4;			// && player.inte >= 25 (zmienić na wisdom)
		if (player.findPerk(PerkLib.SoulOverlord) >= 0) modss += .4;			// && player.inte >= 25 (zmienić na wisdom)
		if (player.findPerk(PerkLib.SoulTyrant) >= 0) modss += .4;			// && player.inte >= 25 (zmienić na wisdom)
	}
	if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) {
		if (player.findPerk(PerkLib.SoulKing) >= 0) modss += .5;
		if (player.findPerk(PerkLib.SoulEmperor) >= 0) modss += .5;
		if (player.findPerk(PerkLib.SoulAncestor) >= 0) modss += .5;
	}
	if (player.findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) modss += .3;
	if (player.findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) modss += .4;
//	if (player.findPerk(PerkLib.FclassHeavenTribulationSurvivor) >= 0) modss += .5;
	if (player.findPerk(PerkLib.DaoistsFocus) >= 0) modss += player.perkv1(PerkLib.DaoistsFocus);
	if (player.findPerk(PerkLib.WizardsAndDaoistsFocus) >= 0) modss += player.perkv2(PerkLib.WizardsAndDaoistsFocus);
	if (player.findPerk(PerkLib.AscensionSpiritualEnlightenment) >= 0) modss *= 1 + (player.perkv1(PerkLib.AscensionSpiritualEnlightenment) * 0.1);
	if (player.findPerk(PerkLib.SeersInsight) >= 0) modss += player.perkv1(PerkLib.SeersInsight);
	if (player.shieldName == "spirit focus") modss += .2;
	return modss;
}

public function soulskillcostmulti():Number {
	var multiss:Number = 1;
	if (player.findPerk(PerkLib.SoulApprentice) >= 0) multiss += 1;
	if (player.findPerk(PerkLib.SoulPersonage) >= 0) multiss += 1;
	if (player.findPerk(PerkLib.SoulWarrior) >= 0) multiss += 1;
	if (player.findPerk(PerkLib.SoulSprite) >= 0) multiss += 1;
	if (player.findPerk(PerkLib.SoulScholar) >= 0) multiss += 1;
	if (player.findPerk(PerkLib.SoulElder) >= 0) multiss += 1;
	if (player.findPerk(PerkLib.SoulExalt) >= 0) multiss += 1;
	if (player.findPerk(PerkLib.SoulOverlord) >= 0) multiss += 1;
	if (player.findPerk(PerkLib.SoulTyrant) >= 0) multiss += 1;
	if (player.findPerk(PerkLib.SoulKing) >= 0) multiss += 1;
	if (player.findPerk(PerkLib.SoulEmperor) >= 0) multiss += 1;
	if (player.findPerk(PerkLib.SoulAncestor) >= 0) multiss += 1;
	if (player.level >= 24 && player.wis >= 80) multiss += 1;//początek używania Dao of Elements
	if (player.level >= 42 && player.wis >= 140) multiss += 1;//początek zdolności latania
	if (player.level >= 60 && player.wis >= 200) multiss += 1;//początek czegoś tam 1
	if (player.level >= 78 && player.wis >= 260) multiss += 1;//początek czegoś tam 2
	return multiss;
}

public function soulskillCost():Number {
	var modssc:Number = 1;
	if (player.findPerk(PerkLib.DaoistCultivator) >= 0) modssc -= .1;
	if (player.findPerk(PerkLib.WizardsAndDaoistsEndurance) >= 0) modssc -= (0.01 * player.perkv2(PerkLib.WizardsAndDaoistsEndurance));
	if (player.findPerk(PerkLib.SeersInsight) >= 0) modssc -= player.perkv1(PerkLib.SeersInsight);
	if (player.jewelryName == "fox hairpin") modssc -= .2;
	if (modssc < 0.1) modssc = 0.1;
	return modssc;
}

public function wisdomscalingbonus():Number {
	var wisdomscalingvalue:Number = 0;
	if (player.wis >= 21 && player.wis < 41) wisdomscalingvalue += (player.wis / 2 + rand((player.wis * 3) / 4));
	if (player.wis >= 41 && player.wis < 61) wisdomscalingvalue += ((player.wis * 2) / 3 + rand(player.wis));
	if (player.wis >= 61 && player.wis < 81) wisdomscalingvalue += ((player.wis * 5) / 6 + rand(player.wis * 1.25));
	if (player.wis >= 81 && player.wis < 101) wisdomscalingvalue += (player.wis + rand(player.wis * 1.5));
	if (player.wis >= 101 && player.wis < 151) wisdomscalingvalue += ((player.wis * 1.25) + rand(player.wis * 1.75));
	if (player.wis >= 151 && player.wis < 201) wisdomscalingvalue += ((player.wis * 1.5) + rand(player.wis * 2));
	if (player.wis >= 201 && player.wis < 251) wisdomscalingvalue += ((player.wis * 1.75) + rand(player.wis * 2.25));
	if (player.wis >= 251 && player.wis < 301) wisdomscalingvalue += ((player.wis * 2) + rand(player.wis * 2.5));
	if (player.wis >= 301 && player.wis < 351) wisdomscalingvalue += ((player.wis * 2.25) + rand(player.wis * 2.75));
	if (player.wis >= 351 && player.wis < 401) wisdomscalingvalue += ((player.wis * 2.5) + rand(player.wis * 3));
	if (player.wis >= 401 && player.wis < 451) wisdomscalingvalue += ((player.wis * 2.75) + rand(player.wis * 3.25));
	if (player.wis >= 451 && player.wis < 501) wisdomscalingvalue += ((player.wis * 3) + rand(player.wis * 3.5));
	if (player.wis >= 501 && player.wis < 551) wisdomscalingvalue += ((player.wis * 3.25) + rand(player.wis * 3.75));
	if (player.wis >= 551 && player.wis < 601) wisdomscalingvalue += ((player.wis * 3.5) + rand(player.wis * 4));
	if (player.wis >= 601 && player.wis < 651) wisdomscalingvalue += ((player.wis * 3.75) + rand(player.wis * 4.25));
	if (player.wis >= 651 && player.wis < 701) wisdomscalingvalue += ((player.wis * 4) + rand(player.wis * 4.5));
	if (player.wis >= 701 && player.wis < 751) wisdomscalingvalue += ((player.wis * 4.25) + rand(player.wis * 4.75));
	if (player.wis >= 751 && player.wis < 801) wisdomscalingvalue += ((player.wis * 4.5) + rand(player.wis * 5));
	if (player.wis >= 801 && player.wis < 851) wisdomscalingvalue += ((player.wis * 4.75) + rand(player.wis * 5.25));
	if (player.wis >= 851 && player.wis < 901) wisdomscalingvalue += ((player.wis * 5) + rand(player.wis * 5.5));
	if (player.wis >= 901 && player.wis < 951) wisdomscalingvalue += ((player.wis * 5.25) + rand(player.wis * 5.75));
	if (player.wis >= 951 && player.wis < 1001) wisdomscalingvalue += ((player.wis * 5.5) + rand(player.wis * 6));
	if (player.wis >= 1001 && player.wis < 1051) wisdomscalingvalue += ((player.wis * 5.75) + rand(player.wis * 6.25));
	if (player.wis >= 1051 && player.wis < 1101) wisdomscalingvalue += ((player.wis * 6) + rand(player.wis * 6.5));
	if (player.wis >= 1101 && player.wis < 1151) wisdomscalingvalue += ((player.wis * 6.25) + rand(player.wis * 6.75));
	if (player.wis >= 1151 && player.wis < 1201) wisdomscalingvalue += ((player.wis * 6.5) + rand(player.wis * 7));
	if (player.wis >= 1201) wisdomscalingvalue += ((player.wis * 6.75) + rand(player.wis * 7.25));
	else wisdomscalingvalue += (player.wis/3 + rand(player.wis/2));
	return wisdomscalingvalue;
}
}
}
