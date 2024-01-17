package classes.Scenes {
import classes.*;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Items.*;
import classes.Scenes.Camp.*;
import classes.Scenes.NPCs.*;
import classes.Scenes.Places.HeXinDao.AdventurerGuild;
import classes.Scenes.Places.Mindbreaker;
import classes.Scenes.Places.RuinedTownRebuilt;
import classes.Scenes.Places.TrollVillage;
import classes.Scenes.Places.WoodElves;
import classes.display.SpriteDb;
import classes.lists.Gender;

import coc.view.ButtonDataList;
import coc.view.MainView;
import classes.Scenes.Combat.CombatAbilities;

use namespace CoC;

public class Camp extends NPCAwareContent{

	protected function set timeQ(value:Number):void {
		CoC.instance.timeQ = value;
	}

	private var campQ:Boolean = false;
	private var waitingORresting:int = 1;

	protected function hasItemInStorage(itype:ItemType):Boolean {
		return SceneLib.inventory.hasItemInStorage(itype);
	}

	public function Camp() {
		EventParser.doCamp = doCamp;
	}

	public var saveUpdater:SaveUpdater = new SaveUpdater();
	public static var harvestMoonScenes:HarvestMoonScenes = new HarvestMoonScenes();

	public var cabinProgress:CabinProgress = new CabinProgress();
	public var campUpgrades:CampUpgrades = new CampUpgrades();
	public var campScenes:CampScenes = new CampScenes();
	public var campMake:CampMakeWinions = new CampMakeWinions();
	public var campUniqueScenes:UniqueCampScenes = new UniqueCampScenes();
	public var codex:Codex = new Codex();
	public var questlog:Questlog = new Questlog();
	public var soulforce:Soulforce = new Soulforce();
	public var testmenu:TestMenu = new TestMenu();
	public var Magnolia:MagnoliaFollower = new MagnoliaFollower();
	public var HolliPure:HolliPureScene = new HolliPureScene();

	private static var _campFollowers:Vector.<XXCNPC> = new Vector.<XXCNPC>;

	public static function addFollower(newEntry:XXCNPC):void {
		_campFollowers.push(newEntry);
	}

	public static function removeFollower(toRemove:XXCNPC):void {
		var i:int = _campFollowers.indexOf(toRemove);
		if (i >= 0) {
			_campFollowers.splice(i, 1);
		}
	}

	public function campAfterMigration():void {
		clearOutput();
		doCamp();
	}

	public function returnToCamp(timeUsed:int):void {
		clearOutput();
		if (player.hasStatusEffect(StatusEffects.HumanForm) && player.statusEffectv1(StatusEffects.HumanForm) <= 0){
			player.addStatusValue(StatusEffects.HumanForm, 1, 1);
		}
		if (explorer.inEncounter) {
			if (timeUsed == 1) {
				// Encounter ended with returnToCampUsingOneHour.
				// Report a bug and continue exploration.
				// To actually return to camp, call explorer.stopExploring() before return
				outputText("Encounter '" + explorer.getCurrentEntry().encounterName + "' does not end with 'endEncounter()'. This is a bug.");
				endEncounter();
				return;
			} else {
				// Encounter ended with returnToCampUsing<MoreThan1>Hours.
				// Should have had `explorer.stopExploring();`
				outputText("Encounter '"+explorer.getCurrentEntry().encounterName+"' does not end with 'explorer.stopExploring()'. This is a bug.\n\n");
				explorer.stopExploring();
			}
		}
		explorer.clear();
		if (timeUsed == 1)
			outputText("An hour passes...\n");
		else outputText(Num2Text(timeUsed) + " hours pass...\n");
		if (!CoC.instance.inCombat) spriteSelect(null);
		//SceneHunter cleanups
		recalling = false; // should be handled by recallWakeUp(), but I'll leave it here just in case something is bugged.
		mocking = false;
		//
		hideMenus();
		timeQ = timeUsed;
		goNext(false);
	}

	public function returnToCampUseOneHour():void {
		returnToCamp(1);
	} //Replacement for event number 13;
	public function returnToCampUseTwoHours():void {
		returnToCamp(2);
	} //Replacement for event number 14;
	public function returnToCampUseFourHours():void {
		returnToCamp(4);
	} //Replacement for event number 15;
	public function returnToCampUseSixHours():void {
		returnToCamp(6);
	}

	public function returnToCampUseEightHours():void {
		returnToCamp(8);
	} //Replacement for event number 16;
	public function returnToCampUseTenHours():void {
		returnToCamp(10);
	}
	public function returnToCampUseTwelveHours():void {
		returnToCamp(12);
	}

	//Used to determine scenes if you choose to play joke on them. Should the variables be moved to flags?
	protected var izmaJoinsStream:Boolean;
	protected var marbleJoinsStream:Boolean;
	protected var heliaJoinsStream:Boolean;
	protected var amilyJoinsStream:Boolean;

	public var IsSleeping: Boolean = false;
	public var CanDream: Boolean = false;
	public var IsWaitingResting: Boolean = false;

	/**
	 * @return 0: normal lust, 1: over lust, 2: over lust, can't do anything
	 */
	public function overLustCheck():int {
		if (player.lust >= player.maxOverLust()) {
			if (player.hasStatusEffect(StatusEffects.Dysfunction)) {
				outputText("<b>You are debilitatingly aroused, but your sexual organs are so numbed the only way to get off would be to find something tight to fuck or get fucked...</b>\n\n");
				return 1;
			} else if (flags[kFLAGS.UNABLE_TO_MASTURBATE_BECAUSE_CENTAUR] > 0 && player.isTaur()) {
				outputText("<b>You are delibitatingly aroused, but your sex organs are so difficult to reach that masturbation isn't at the forefront of your mind.</b>\n\n");
				return 1;
			} else if (player.hasStatusEffect(StatusEffects.IsRaiju) || player.hasStatusEffect(StatusEffects.IsThunderbird) || player.hasStatusEffect(StatusEffects.IsKirin)) {
				outputText("<b>You are delibitatingly aroused, but have no ways to reach true release on your own. The first thing up your mind right now is to find a partner willing or unwilling to discharge yourself into.</b>\n\n");
				return 1;
			} else {
				outputText("<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>\n\n");
				return 2;
			}
		}
		return 0;
	}

	public function doCamp():void { //Only called by playerMenu
		//Force autosave on HARDCORE MODE! And level-up.

		if (player.slotName != "VOID" && mainView.getButtonText(0) != "Game Over" && flags[kFLAGS.HARDCORE_MODE] > 0) {
			trace("Autosaving to slot: " + player.slotName);

			CoC.instance.saves.saveGame(player.slotName);
		}
		if (Metamorph.TriggerUpdate) {
			Metamorph.update();
			return;
		}
		CoC.instance.inCombat = false;
		if (ingnam.inIngnam) { //Ingnam
			SceneLib.ingnam.menuIngnam();
			return;
		}
		mainView.showMenuButton(MainView.MENU_NEW_MAIN);
		if (player.hasStatusEffect(StatusEffects.PostAkbalSubmission)) {
			player.removeStatusEffect(StatusEffects.PostAkbalSubmission);
			SceneLib.forest.akbalScene.akbalSubmissionFollowup();
			return;
		}
		if (player.hasStatusEffect(StatusEffects.PostAnemoneBeatdown)) {
			HPChange(Math.round(player.maxHP() / 2), false);
			player.removeStatusEffect(StatusEffects.PostAnemoneBeatdown);
		}

		flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = "";
		//History perk backup
		if (flags[kFLAGS.HISTORY_PERK_SELECTED] == 0) {
			flags[kFLAGS.HISTORY_PERK_SELECTED] = 2;
			hideMenus();
			CoC.instance.charCreation.chooseHistory();
			return;
		}
		saveUpdater.fixFlags();
		if (player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
			player.removeStatusEffect(StatusEffects.ChargeWeapon);
		}
		if (player.hasStatusEffect(StatusEffects.ChargeArmor)) {
			player.removeStatusEffect(StatusEffects.ChargeArmor);
		}
		if (player.hasItem(useables.SOULGEM, 1) && player.hasStatusEffect(StatusEffects.CampRathazul) && flags[kFLAGS.DEN_OF_DESIRE_QUEST] < 1) {
			campUniqueScenes.playsRathazulAndSoulgemScene();
			return;
		}
		if ((player.isRaceCached(Races.FMINDBREAKER, 1) || player.isRaceCached(Races.MMINDBREAKER, 1) || player.isRaceCached(Races.ATLACH_NACHA, 2)) && player.cor < 100) player.cor = 100;
		if (TrollVillage.ZenjiVillageStage == 2 && TrollVillage.ZenjiTrollVillageTimeChk == time.days && time.hours >= 8) {
			hideMenus();
			SceneLib.trollVillage.yenza.YenzaBeratePart2();
			return;
		}
		if (ZenjiScenes.isLover() && time.days != ZenjiScenes.ZenjiLoverDaysTracker){
			ZenjiScenes.ZenjiLoverDays++;
			ZenjiScenes.ZenjiLoverDaysTracker = time.days;
		}
		if (TrollVillage.ZenjiMoneyHelp > 0) TrollVillage.ZenjiMoneyHelp -= 1;
		if (!marbleScene.marbleFollower() && flags[kFLAGS.MARBLE_LEFT_OVER_CORRUPTION] == 1/* && player.cor <= 40*/) { //Removed the check to make her return to everyone
			hideMenus();
			marblePurification.pureMarbleDecidesToBeLessOfABitch();
			return;
		}
		if ((model.time.hours >= 7 && model.time.hours <= 9) && TyrantiaFollower.isLover() && BelisaFollower.BelisaFollowerStage >= 5 && BelisaFollower.BelisaEncounternum >= 5 && BelisaFollower.BelisaAffectionMeter >= 80 && !BelisaFollower.BelisaConfessed) {
			hideMenus();
			SceneLib.belisa.BelisaConfession();
			return;
		}
		if ((model.time.hours >= 7 && model.time.hours <= 9) && TyrantiaFollower.isLover() && BelisaFollower.BelisaFollowerStage >= 4 && BelisaFollower.BelisaEncounternum < 5) {
			hideMenus();
			SceneLib.belisa.BelisaAndTyrantia();
			return;
		}
		if (DriderTown.BelisaPregnancy >= 30 && DriderTown.BelisaPregnancy < 48) {
			hideMenus();
			SceneLib.dridertown.BelisaBroodmotherMoment();
			return;
		}
		if (DriderTown.BelisaPregnancy == 1) {
			hideMenus();
			SceneLib.dridertown.BelisaEggLaying();
			return;
		}
		if (DriderTown.BelisaKidsEggsHatching == 1 || DriderTown.BelisaKidsEggsHatching1 == 1 || DriderTown.BelisaKidsEggsHatching2 == 1) {
			hideMenus();
			SceneLib.dridertown.BelisaEggsHatched();
			return;
		}
		if (DriderTown.LilyKidsPCPregnancy == 1) {
			hideMenus();
			SceneLib.dridertown.LilyEggLayingPC();
			return;
		}
		if (DriderTown.LilyKidsPCEggsHatching == 1 || DriderTown.LilyKidsPCEggsHatching1 == 1 || DriderTown.LilyKidsPCEggsHatching2 == 1) {
			hideMenus();
			SceneLib.dridertown.LilyEggsHatchedPC();
			return;
		}
		if (DriderTown.TyrantiaPregnancy >= 30 && DriderTown.TyrantiaPregnancy < 48) {
			hideMenus();
			SceneLib.dridertown.TyrantiaBroodmotherMoment();
			return;
		}
		if (DriderTown.TyrantiaPregnancy == 1) {
			hideMenus();
			SceneLib.dridertown.TyrantiaEggLaying();
			return;
		}
		if (DriderTown.TyrantiaKidsEggsHatching == 1 || DriderTown.TyrantiaKidsEggsHatching1 == 1 || DriderTown.TyrantiaKidsEggsHatching2 == 1) {
			hideMenus();
			SceneLib.dridertown.TyrantiaEggsHatched();
			return;
		}
		if (TyrantiaFollower.TyraniaCorrupteedLegendaries == 0 && TyrantiaFollower.TyrantiaAffectionMeter >= 100) {
			hideMenus();
			SceneLib.tyrantia.unlockingCorruptLegendariesOption();
			return;
		}
		if ((model.time.hours >= 7 && model.time.hours <= 9) && flags[kFLAGS.AMILY_AFFECTION] >= 40 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && RuinedTownRebuilt.RebuildState == 0 && !RuinedTownRebuilt.AmilyAtWetBitch) {
			hideMenus();
			SceneLib.ruinedTown.amilyRebuild();
			return;
		}
		if (marbleScene.marbleFollower()) {
			//Cor < 50
			//No corrupt: Jojo, Amily, or Vapula
			//Purifying Murble
			//SH update: check disabled cause it still makes zero sense.
//			if (player.cor < 50 + player.corruptionTolerance && !campCorruptJojo() && !amilyScene.amilyCorrupt() && !vapulaSlave()
//					&& flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 0 && flags[kFLAGS.MARBLE_COUNTUP_TO_PURIFYING] >= 200
//					&& !player.hasPerk(PerkLib.MarblesMilk)) {
			if (flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 0 && flags[kFLAGS.MARBLE_COUNTUP_TO_PURIFYING] >= 200 && !player.hasPerk(PerkLib.MarblesMilk)) {
				hideMenus();
				marblePurification.BLUHBLUH();
				return;
			}
            /* Marble flipouts are disabled because they made no sense
			if (flags[kFLAGS.MARBLE_PURIFICATION_STAGE] >= 5) {
				if (flags[kFLAGS.MARBLE_WARNED_ABOUT_CORRUPTION] == 0 && player.cor >= 50 + player.corruptionTolerance) {
					hideMenus();
					marblePurification.marbleWarnsPCAboutCorruption();
					return;
				}
				if (flags[kFLAGS.MARBLE_WARNED_ABOUT_CORRUPTION] == 1 && flags[kFLAGS.MARBLE_LEFT_OVER_CORRUPTION] == 0 && player.cor >= 60 + player.corruptionTolerance) {
					hideMenus();
					marblePurification.marbleLeavesThePCOverCorruption();
					return;
				}
			}
            */
			if (flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_1] == 1 && (time.hours == 6 || time.hours == 7)) {
				hideMenus();
				marblePurification.rathazulsMurbelReport();
				return;
			}
			if (flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_2] == 1) {
				hideMenus();
				marblePurification.claraShowsUpInCampBECAUSESHESACUNT();
				return;
			}
		}
		if (arianFollower() && flags[kFLAGS.ARIAN_MORNING] == 1) {
			hideMenus();
			arianScene.wakeUpAfterArianSleep();
			return;
		}
		if (arianFollower() && flags[kFLAGS.ARIAN_EGG_EVENT] >= 30) {
			hideMenus();
			arianScene.arianEggingEvent();
			return;
		}
		if (arianFollower() && flags[kFLAGS.ARIAN_EGG_COUNTER] >= 24 && flags[kFLAGS.ARIAN_VAGINA] > 0) {
			hideMenus();
			arianScene.arianLaysEggs();
			return;
		}
		if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 && flags[kFLAGS.JOY_NIGHT_FUCK] == 1) {
			joyScene.wakeUpWithJoyPostFuck();
			return;
		}
        if (flags[kFLAGS.JOJO_BIMBO_STATE] == 4 && flags[kFLAGS.TALKED_TO_JOJO_ABOUT_JOY] == 0) { //post-debimbo conversation
            jojoScene.afterDebimboTalk();
            return;
        }
		if (flags[kFLAGS.EMBER_MORNING] > 0 && ((flags[kFLAGS.BENOIT_CLOCK_BOUGHT] > 0 && model.time.hours >= flags[kFLAGS.BENOIT_CLOCK_ALARM]) || (flags[kFLAGS.BENOIT_CLOCK_BOUGHT] <= 0 && model.time.hours >= 6))) {
			hideMenus();
			emberScene.postEmberSleep();
			return;
		}
		if (sceneHunter.other && camp.IsSleeping && flags[kFLAGS.HACK_CELESS_INCUBATION] == 1) {
			celessScene.hackCelessSpawn();
			return;
		}
		if (flags[kFLAGS.JACK_FROST_PROGRESS] > 0) {
			hideMenus();
			SceneLib.holidays.processJackFrostEvent();
			return;
		}
		if (player.hasKeyItem("Super Reducto") < 0 && milkSlave() && player.hasStatusEffect(StatusEffects.CampRathazul) && player.statusEffectv2(StatusEffects.MetRathazul) >= 4) {
			hideMenus();
			milkWaifu.ratducto();
			return;
		}
		if (Holidays.nieveHoliday() && camp.IsSleeping) {
			if (player.hasKeyItem("Nieve's Tear") >= 0 && flags[kFLAGS.NIEVE_STAGE] != 5) {
				SceneLib.holidays.returnOfNieve();
				hideMenus();
				return;
			} else if (flags[kFLAGS.NIEVE_STAGE] == 0) {
				hideMenus();
				SceneLib.holidays.snowLadyActive();
				return;
			} else if (flags[kFLAGS.NIEVE_STAGE] == 4) {
				hideMenus();
				SceneLib.holidays.nieveComesToLife();
				return;
			}
		}
		if (Holidays.isHalloween() && ZenjiScenes.isLover() && (model.time.hours >= 6 && model.time.hours < 9) && player.statusEffectv4(StatusEffects.ZenjiZList) == 0) {
			hideMenus();
			SceneLib.zenjiScene.loverZenjiHalloweenEvent();
			return;
		}
		if (SceneLib.helScene.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff)) {
			if (Holidays.isHeliaBirthday() && flags[kFLAGS.HEL_FOLLOWER_LEVEL] >= 2 && date.fullYear > flags[kFLAGS.HELIA_BIRTHDAY_LAST_YEAR]) {
				hideMenus();
				helFollower.heliasBirthday();
				return;
			}
			if (SceneLib.helScene.pregnancy.isPregnant) {
				switch (SceneLib.helScene.pregnancy.eventTriggered()) {
					case 2:
						hideMenus();
						helSpawnScene.bulgyCampNotice();
						return;
					case 3:
						hideMenus();
						helSpawnScene.heliaSwollenNotice();
						return;
					case 4:
						hideMenus();
						helSpawnScene.heliaGravidity();
						return;
					default:
						if (SceneLib.helScene.pregnancy.incubation == 0 && (model.time.hours == 6 || model.time.hours == 7)) {
							hideMenus();
							helSpawnScene.heliaBirthtime();
							return;
						}
				}
			}
		}
		if (flags[kFLAGS.HELSPAWN_AGE] == 1 && flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] == 7) {
			hideMenus();
			helSpawnScene.helSpawnGraduation();
			return;
		}
		if (helSpawnScene.helspawnFollower() && flags[kFLAGS.HELSPAWN_DADDY] > 0 && flags[kFLAGS.HELSPAWN_DAD_EVENT] == 0) {
			if (flags[kFLAGS.HELSPAWN_DADDY] == 1 && model.time.hours == 6) {
				hideMenus();
				helSpawnScene.spiderBrosGift();
				return;
			}
			if (flags[kFLAGS.HELSPAWN_DADDY] == 2 && model.time.hours == 12) {
				hideMenus();
				helSpawnScene.maiVisitsHerKids();
				return;
			}

		}
		if (model.time.hours >= 10 && model.time.hours <= 18 && (model.time.days % 15 == 0 || model.time.hours == 12) && helSpawnScene.helspawnFollower() && flags[kFLAGS.HAKON_AND_KIRI_VISIT] == 0) {
			hideMenus();
			helSpawnScene.hakonAndKiriComeVisit();
			return;
		}
		if (flags[kFLAGS.HELSPAWN_AGE] == 2 && flags[kFLAGS.HELSPAWN_DISCOVER_BOOZE] == 0 && (rand(10) == 0 || flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] == 6)) {
			hideMenus();
			helSpawnScene.helspawnDiscoversBooze();
			return;
		}
		if (flags[kFLAGS.HELSPAWN_AGE] == 2 && flags[kFLAGS.HELSPAWN_WEAPON] == 0 && flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] >= 3 && model.time.hours >= 10 && model.time.hours <= 18) {
			hideMenus();
			helSpawnScene.helSpawnChoosesAFightingStyle();
			return;
		}
		if (flags[kFLAGS.HELSPAWN_AGE] == 2 && (model.time.hours == 6 || model.time.hours == 7) && flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] >= 7 && flags[kFLAGS.HELSPAWN_FUCK_INTERRUPTUS] == 1) {
			helSpawnScene.helspawnAllGrownUp();
			return;
		}
		if ((sophieFollower() || bimboSophie()) && flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] == 1) {
			flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] = 0;
			sophieBimbo.sophieKidMaturation();
			hideMenus();
			return;
		}
		//Bimbo Sophie Move In Request!
		if (bimboSophie() && flags[kFLAGS.SOPHIE_BROACHED_SLEEP_WITH] == 0 && sophieScene.pregnancy.event >= 2) {
			hideMenus();
			sophieBimbo.sophieMoveInAttempt();
			return;
		}
		if (!Holidays.nieveHoliday() && model.time.hours == 6 && flags[kFLAGS.NIEVE_STAGE] > 0) {
			SceneLib.holidays.nieveIsOver();
			return;
		}
		//Amily followup!
		if (flags[kFLAGS.PC_PENDING_PREGGERS] == 1) {
			SceneLib.amilyScene.postBirthingEndChoices();
			flags[kFLAGS.PC_PENDING_PREGGERS] = 2;
			return;
		}
		if (timeQueued) {
			if (!campQ) {
				clearOutput();
				outputText("More time passes...\n");
				goNext(false);
				return;
			} else {
				if (IsSleeping) {
					doSleep();
				}
				if (IsWaitingResting){
					rest();
				}
				return;
			}
		}
		IsSleeping = false;
		IsWaitingResting = false;
		if (flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] > 0 && !flags[kFLAGS.IN_INGNAM]) {
			if (flags[kFLAGS.FUCK_FLOWER_LEVEL] == 0 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 8) {
				holliScene.getASprout();
				hideMenus();
				return;
			}
			if (flags[kFLAGS.FUCK_FLOWER_LEVEL] == 1 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 7) {
				holliScene.fuckPlantGrowsToLevel2();
				hideMenus();
				return;
			}
			if (flags[kFLAGS.FUCK_FLOWER_LEVEL] == 2 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 25) {
				holliScene.flowerGrowsToP3();
				hideMenus();
				return;
			}
			//Level 4 growth
			if (flags[kFLAGS.FUCK_FLOWER_LEVEL] == 3 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 40) {
				holliScene.treePhaseFourGo();
				hideMenus();
				return;
			}
		}
		if (flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.MARAE_QUEST_COMPLETE] == 1 && !flags[kFLAGS.IN_INGNAM]) {
			if (flags[kFLAGS.FLOWER_LEVEL] == 0 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 8) {
				HolliPure.getASprout();
				hideMenus();
				return;
			}
			if (flags[kFLAGS.FLOWER_LEVEL] == 1 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 7) {
				HolliPure.plantGrowsToLevel2();
				hideMenus();
				return;
			}
			if (flags[kFLAGS.FLOWER_LEVEL] == 2 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 25) {
				HolliPure.flowerGrowsToP3();
				hideMenus();
				return;
			}
			//Level 4 growth
			if (flags[kFLAGS.FLOWER_LEVEL] == 3 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 40) {
				HolliPure.treePhaseFourGo();
				hideMenus();
				return;
			}
		}
		if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] > 1 && flags[kFLAGS.CHRISTMAS_TREE_LEVEL] < 5 && !flags[kFLAGS.IN_INGNAM]) {
			if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 3 && flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] >= 6) {
				Magnolia.plantGrowsToLevel2();
				hideMenus();
				return;
			}
			if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 4 && flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] >= 22) {
				Magnolia.plantGrowsToLevel3();
				hideMenus();
				return;
			}
			if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 5 && flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] >= 34) {
				Magnolia.plantGrowsToLevel4();
				hideMenus();
				return;
			}
		}
		//Jojo treeflips!
		if (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] != 3) {
			holliScene.JojoTransformAndRollOut();
			hideMenus();
			return;
		}
		//Amily flips out
		if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt() && flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0) {
			holliScene.amilyHatesTreeFucking();
			hideMenus();
			return;
		}
		if (flags[kFLAGS.FUCK_FLOWER_KILLED] == 1 && flags[kFLAGS.AMILY_TREE_FLIPOUT] == 1 && !amilyScene.amilyFollower() && flags[kFLAGS.AMILY_VISITING_URTA] == 0) {
			holliScene.amilyComesBack();
			flags[kFLAGS.AMILY_TREE_FLIPOUT] = 2;
			hideMenus();
			return;
		}
		//Anemone birth followup!
		if (player.hasStatusEffect(StatusEffects.CampAnemoneTrigger)) {
			player.removeStatusEffect(StatusEffects.CampAnemoneTrigger);
			kidAScene.anemoneKidBirthPtII();
			hideMenus();
			return;
		}
		for each (var npc:XXCNPC in _campFollowers) {
			if (npc.checkCampEvent()) {
				return;
			}
		}
		//Izzys tits asplode
		if (isabellaFollower() && flags[kFLAGS.ISABELLA_MILKED_YET] >= 10 && player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") >= 0) {
			isabellaFollowerScene.milktasticLacticLactation();
			hideMenus();
			return;
		}
		//Isabella and Valeria sparring.
		if (isabellaFollower() && flags[kFLAGS.VALERIA_AT_CAMP] > 0 && flags[kFLAGS.ISABELLA_VALERIA_SPARRED] == 0) {
			valeria.isabellaAndValeriaSpar();
			return;
		}
		//Marble meets follower izzy when moving in
		if (flags[kFLAGS.ISABELLA_MURBLE_BLEH] == 1 && isabellaFollower() && player.hasStatusEffect(StatusEffects.CampMarble)) {
			isabellaFollowerScene.angryMurble();
			hideMenus();
			return;
		}
		//Mitzi Daughters + Izma Daughters
		if (flags[kFLAGS.MITZI_DAUGHTERS] >= 4 && izmaScene.totalIzmaChildren() >= 2 && !player.hasStatusEffect(StatusEffects.MitziIzmaDaughters) && rand(5) == 0) {
			SceneLib.mitziFollower.MitziDaughtersIzmaDaughters();
			return;
		}
		//Excellia + Jojo
		if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 33 && player.hasStatusEffect(StatusEffects.PureCampJojo) && !player.hasStatusEffect(StatusEffects.ExcelliaJojo) && rand(5) == 0) {
			SceneLib.excelliaFollower.ExcelliaAndJojoCampScene();
			return;
		}
		/*Rathazul april fool:
            - aprel fools, no effect, OR max stage and a year passed since the beginning, BUT limited at 5 elixirs
            - second stage. No checking for fools.
        */
        if (player.hasStatusEffect(StatusEffects.CampRathazul) && isAprilFools() && (!player.hasStatusEffect(StatusEffects.RathazulAprilFool) ||
        player.statusEffectv3(StatusEffects.RathazulAprilFool) == 2
        && player.statusEffectv2(StatusEffects.RathazulAprilFool) < 5
        && date.fullYear > player.statusEffectv1(StatusEffects.RathazulAprilFool))) {
            SceneLib.rathazul.rathazulAprilFool();
            hideMenus();
            return;
        }
		//Cotton preg freakout
		if (((player.pregnancyIncubation <= 280 && player.pregnancyType == PregnancyStore.PREGNANCY_COTTON)||(player.pregnancy2Incubation <= 280 && player.pregnancy2Type == PregnancyStore.PREGNANCY_COTTON)) &&
				flags[kFLAGS.COTTON_KNOCKED_UP_PC_AND_TALK_HAPPENED] == 0 && (model.time.hours == 6 || model.time.hours == 7)) {
			SceneLib.telAdre.cotton.goTellCottonShesAMomDad();
			hideMenus();
			return;
		}
		//Bimbo Sophie finds ovi elixer in chest!
		if (bimboSophie() && hasItemInStorage(consumables.OVIELIX) && rand(5) == 0 && flags[kFLAGS.TIMES_SOPHIE_HAS_DRUNK_OVI_ELIXIR] == 0 && player.gender > 0) {
			sophieBimbo.sophieEggApocalypse();
			hideMenus();
			return;
		}
		//Amily + Urta freakout!
		if (!SceneLib.urtaQuest.urtaBusy() && flags[kFLAGS.AMILY_VISITING_URTA] == 0 && rand(10) == 0 && flags[kFLAGS.URTA_DRINK_TOOGLE] >= 0 && flags[kFLAGS.URTA_NO_MORE_SCYLLA] == 0 && flags[kFLAGS.AMILY_NEED_TO_FREAK_ABOUT_URTA] == 1 && amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && !amilyScene.pregnancy.isPregnant) {
			finter.amilyUrtaReaction();
			hideMenus();
			return;
		}
		//Find jojo's note!
		if (flags[kFLAGS.JOJO_FIXED_STATUS] == 1 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0) {
			finter.findJojosNote();
			hideMenus();
			return;
		}
		//Bimbo Jojo warning
		if (player.hasStatusEffect(StatusEffects.PureCampJojo) && inventory.hasItemInStorage(consumables.BIMBOLQ) && flags[kFLAGS.BIMBO_LIQUEUR_STASH_COUNTER_FOR_JOJO] >= 72 && flags[kFLAGS.JOJO_BIMBO_STATE] == 0) {
			joyScene.jojoPromptsAboutThief();
			hideMenus();
			return;
		}
		//Jojo gets bimbo'ed!
		if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.BIMBO_LIQUEUR_STASH_COUNTER_FOR_JOJO] >= 24 && flags[kFLAGS.JOJO_BIMBO_STATE] == 2) {
			joyScene.jojoGetsBimbofied();
			hideMenus();
			return;
		}
		//Joy gives birth!
		if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 && jojoScene.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER && jojoScene.pregnancy.incubation == 0) {
			joyScene.joyGivesBirth();
			return;
		}
		//Rathazul freaks out about jojo
		if (flags[kFLAGS.RATHAZUL_CORRUPT_JOJO_FREAKOUT] == 0 && rand(5) == 0 && player.hasStatusEffect(StatusEffects.CampRathazul) && campCorruptJojo()) {
			finter.rathazulFreaksOverJojo();
			hideMenus();
			return;
		}
		//Zenji freaks out about jojo
		if (ZenjiScenes.isLover() && !ZenjiScenes.ZenjiMarried && campCorruptJojo() && rand(4) == 0) {
			finter.zenjiFreaksOverJojo();
			hideMenus();
			return;
		}
		//Zenji freaks out about corrupted celess
		if (ZenjiScenes.isLover() && CelessScene.instance.isCorrupt && !CelessScene.instance.setDeadOrRemoved() && !sceneHunter.other && rand(4) == 0) {
			finter.zenjiFreaksOverCorruptCeless();
			hideMenus();
			return;
		}
		//Izma/Marble freakout - marble moves in
		if (flags[kFLAGS.IZMA_MARBLE_FREAKOUT_STATUS] == 1) {
			izmaScene.newMarbleMeetsIzma();
			hideMenus();
			return;
		}
		//Izma/Amily freakout - Amily moves in
		if (flags[kFLAGS.IZMA_AMILY_FREAKOUT_STATUS] == 1) {
			izmaScene.newAmilyMeetsIzma();
			hideMenus();
			return;
		}
		//Amily/Marble Freakout
		if (flags[kFLAGS.AMILY_NOT_FREAKED_OUT] == 0 && player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower() && marbleScene.marbleAtCamp()) {
			finter.marbleVsAmilyFreakout();
			hideMenus();
			return;
		}
		//Amily and/or Jojo freakout about Vapula!!
		if (vapulaSlave() && ((player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.KEPT_PURE_JOJO_OVER_VAPULA] <= 0) || (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt() && flags[kFLAGS.KEPT_PURE_AMILY_OVER_VAPULA] <= 0))) {
			//Jojo but not Amily (Must not be bimbo!)
			if ((player.hasStatusEffect(StatusEffects.PureCampJojo)) && !(amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) && flags[kFLAGS.KEPT_PURE_JOJO_OVER_VAPULA] == 0)
				vapula.mouseWaifuFreakout(false, true);
			//Amily but not Jojo
			else if ((amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) && !player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.KEPT_PURE_AMILY_OVER_VAPULA] == 0) {
				vapula.mouseWaifuFreakout(true, false);
			}
			//Both
			else vapula.mouseWaifuFreakout(true, true);
			hideMenus();
			return;
		}
		if (followerKiha() && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] == 144) {
			kihaFollower.kihaTellsChildrenStory();
			return;
		}
		if (flags[kFLAGS.EXCELLIA_RECRUITED] == 1) {
			SceneLib.excelliaFollower.ExcelliaPathChoice();
			return;
		}
		if (SceneLib.chichiScene.ChiChiCorruption >= 90 && !SceneLib.chichiScene.ChiChiKickedOut) {
			SceneLib.chichiScene.corruptionOverflowing();
			return;
		}
		//Go through Helia's first time move in interactions if  you haven't yet.
		if (flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 2 && SceneLib.helScene.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff) && flags[kFLAGS.HEL_INTROS_LEVEL] == 0) {
			helFollower.helFollowersIntro();
			hideMenus();
			return;
		}
		//If you've gone through Hel's first time actions and Issy moves in without being okay with threesomes.
		if (flags[kFLAGS.HEL_INTROS_LEVEL] > 9000 && SceneLib.helScene.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff) && isabellaFollower() && flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] == 0) {
			helFollower.angryHelAndIzzyCampHelHereFirst();
			hideMenus();
			return;
		}
		if (flags[kFLAGS.D3_GOBLIN_MECH_PRIME] == 1 && player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) {
			outputText("Finally back to [camp], you get to work calling on your crew of daughters to pass the upgrades from one mech to another.\n\n");
			outputText("You make a final checkup for potential glitches and possible mechanical errors and find none, guess the lizards didn't damage it. Gosh this little beauty is going to be fun to use.\n\n");
			flags[kFLAGS.D3_GOBLIN_MECH_PRIME] = 2;
			return;
		}
		//Reset.
		flags[kFLAGS.CAME_WORMS_AFTER_COMBAT] = 0;
		campQ = false;
		//Clear stuff
		if (player.hasStatusEffect(StatusEffects.SlimeCravingOutput)) player.removeStatusEffect(StatusEffects.SlimeCravingOutput);
		//Reset luststick display status (see event parser)
		flags[kFLAGS.PC_CURRENTLY_LUSTSTICK_AFFECTED] = 0;
		//Display Proper Buttons
		mainView.showMenuButton(MainView.MENU_APPEARANCE);
		mainView.showMenuButton(MainView.MENU_PERKS);
		mainView.showMenuButton(MainView.MENU_STATS);
		mainView.showMenuButton(MainView.MENU_DATA);
		showStats();
		//Change settings of new game buttons to go to main menu
		mainView.setMenuButton(MainView.MENU_NEW_MAIN, "Main Menu", CoC.instance.mainMenu.mainMenu);
		mainView.newGameButton.toolTipText = "Return to main menu.";
		mainView.newGameButton.toolTipHeader = "Main Menu";
		//clear up/down arrows
		hideUpDown();
		//Level junk
		if (setLevelButton(true)) return;
		//Build main menu
		var exploreEvent:Function = SceneLib.exploration.doExplore;
		var placesEvent:Function = (placesKnown() ? places : null);
		var canExploreAtNight:Boolean = (player.isNightCreature());
		var isAWerebeast:Boolean = (player.isWerebeast());
		clearOutput();
		saveUpdater.updateAchievements();

		outputText(images.showImage("camping"));
		//Isabella upgrades camp level!


		if (isabellaFollower()) {
			outputText("Your campsite got a lot more comfortable once Isabella moved in.  Carpets cover up much of the barren ground, simple awnings tied to the rocks provide shade, and hand-made wooden furniture provides comfortable places to sit and sleep.  ");
		}
		//Live in-ness
		else {
			if (model.time.days < 10) outputText("Your campsite is fairly simple at the moment.  Your tent and bedroll are set in front of the rocks that lead to the portal.  You have a small fire pit as well.  ");
			if (model.time.days >= 10 && model.time.days < 20) outputText("Your campsite is starting to get a very 'lived-in' look.  The fire-pit is well defined with some rocks you've arranged around it, and your bedroll and tent have been set up in the area most sheltered by rocks.  ");
			if (model.time.days >= 20) {
				if (!isabellaFollower()) outputText("Your new home is as comfy as a camp site can be.  ");
				outputText("The fire-pit ");
				if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0) outputText("is ");
				else outputText("and tent are both ");
				outputText("set up perfectly, and in good repair.  ");
			}
		}
		if (model.time.days >= 20) outputText("You've even managed to carve some artwork into the rocks around the [camp] perimeter.\n\n");
		if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 7) outputText("There's an unfinished wooden structure. As of right now, it's little more than wooden frames nailed together.\n\n");
		if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 8) outputText("There's an unfinished cabin. It's currently missing both windows and a door.\n\n");
		if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 9) outputText("There's a nearly-finished cabin. It looks complete from the outside, but inside, the floors are still bare earth.\n\n");
		if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10) outputText("Your cabin is situated near the edge of [camp].\n\n");
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 0 || flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 1) outputText("Halfway between the portal and the edge of your [camp] is a place where you will store piles of wood or stones for construction. ");
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 3) outputText("Halfway between the portal and the edge of your [camp]  rests a medium sized wood platform, which you use to store wood and next to it is place for storing stones. ");
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4) outputText("Halfway between the portal and the edge of your [camp]  rests a long and wide wood platform with protective barriers at the edges. Inside it, you can safely store large amounts of wood and stone. ");
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 1) outputText("There's a half finished warehouse construction near the east edge of your campsite.\n\n");
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 2) outputText("There's a warehouse located in the east section of your campsite.\n\n");
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 3) outputText("There's a warehouse and connected to it half finished granary construction located in the east section of your campsite.\n\n");
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 4) outputText("There's a warehouse and connected to it granary located in the east section of your campsite.\n\n");
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 5) outputText("There's a warehouse and second one warehouse half finished construction connected by granary located in the east section of your campsite.\n\n");
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 6) outputText("There are two warehouses and granary connecting them located in the east section of your campsite.\n\n");
		if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) {
			outputText("Some of your friends are currently sparring at the ");
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 4 && flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 7) outputText("massive");
			else if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 3) outputText("large");
			else outputText("small");
			outputText(" ring");
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 5) outputText(" with wooden floor");
			outputText(" toward side of your [camp].");
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 3) outputText(" Given how large the sparring ring, maybe it's a little excessive for even the largest of people around.");
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 4) outputText(" A small stand rests adjacent, allowing spectators to cheer on any duels taking place.");
			outputText("\n\n");
		}
		if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 1) {
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 8) outputText("Eight large arcane circles are");
			else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 7) outputText("Seven large arcane circles are");
			else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 6) outputText("Six large arcane circles are");
			else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 5) outputText("Five large arcane circles are");
			else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 4) outputText("Four large arcane circles are");
			else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 3) outputText("Three large arcane circles are");
			else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 2) outputText("Two large arcane circles are");
			else outputText("Large arcane circle is");
			outputText(" written at the edge of your [camp]. Their runes regularly glow with impulse of power.\n\n");
		}
		if (flags[kFLAGS.CAMP_UPGRADES_DAM] >= 1) {
			if (flags[kFLAGS.CAMP_UPGRADES_DAM] == 3) outputText("Big, wooden dam noticably increases the width of the nearby stream, slowing the water to a near still. It's created a small bay next to camp.");
			else if (flags[kFLAGS.CAMP_UPGRADES_DAM] == 2) outputText("Wooden dam noticably increases the width of the nearby stream, slowing the passage of water");
			else outputText("Small wooden dam drapes across the stream, slowing the passage of water");
			outputText(".\n\n");
			if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 1) {
				outputText("Not so far from it is your ");
				if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 1) outputText("small");
				if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 2) outputText("medium-sized");
				if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 3) outputText("big");
				if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 4) outputText("large");
				outputText(" fishery. You can see several barrels at its side to store any fish that are caught.\n\n");
			}
		}
		if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] >= 2 && flags[kFLAGS.CHRISTMAS_TREE_LEVEL] < 8) {
			if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 2) outputText("At the corner of camp where you planted a seed, a sapling has grown. It has dozens of branches and bright green leaves.\n\n");
			else if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 3) outputText("At the corner of camp, the tree like sapling has grown bigger having grown more branches and leaves.\n\n");
			else if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 4) outputText("At the corner of camp, a small tree has grown. The bright green leaves gently sway with the blowing wind.\n\n");
			else outputText("At the corner of camp sits a rather large tree. It's leafy canopy sways with the wind and the thick trunk is covered in sturdy bark." + (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 7 ? " The tree is covered in colorful ornaments and lights for the season." : "") + "\n\n");
		}
		//Nursery
		if (flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] == 100 && player.hasStatusEffect(StatusEffects.CampMarble)) {
			outputText("Marble has built a fairly secure nursery amongst the rocks to house your ");
			if (flags[kFLAGS.MARBLE_KIDS] == 0) outputText("future children");
			else {
				outputText(num2Text(flags[kFLAGS.MARBLE_KIDS]) + " child");
				if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("ren");
			}
			outputText(".\n\n");
		}
		//HARPY ROOKERY
		if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] > 0) {
			//Rookery Descriptions (Short)
			//Small (1 mature daughter)
			if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] == 1) {
				outputText("There's a small harpy nest that your daughter has built up, made from rocks near the fringes of your [camp].  It's kind of pathetic, but she seems proud of her accomplishment.  ");
			}
			//Medium (2-3 mature daughters)
			else if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 3) {
				outputText("There's a growing pile of stones built up at the fringes of your [camp].  It's big enough to be considered a small hill by this point, dotted with a couple small harpy nests just barely big enough for two.  ");
			}
			//Big (4 mature daughters)
			else if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 4) {
				outputText("The harpy rookery at the edge of [camp] has gotten pretty big.  It's taller than most of the standing stones that surround the portal, and there's more nests than harpies at this point.  Every now and then you see the four of them managing a boulder they dragged in from somewhere to add to it.  ");
			}
			//Large (5-10 mature daughters)
			else if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 10) {
				outputText("The rookery has gotten quite large.  It stands nearly two stories tall at this point, dotted with nests and hollowed out places in the center.  It's surrounded by the many feathers the assembled harpies leave behind.  ");
			}
			//Giant (11-20 mature daughters)
			else if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 20) {
				outputText("A towering harpy rookery has risen up at the fringes of your [camp], filled with all of your harpy brood.  It's at least three stories tall at this point, and it has actually begun to resemble a secure structure.  These harpies are always rebuilding and adding onto it.  ");
			}
			//Massive (21-50 mature daughters)
			else if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 50) {
				outputText("A massive harpy rookery towers over the edges of your [camp].  It's almost entirely built out of stones that are fit seamlessly into each other, with many ledges and overhangs for nests.  There's a constant hum of activity over there day or night.  ");
			}
			//Immense (51+ Mature daughters)
			else {
				outputText("An immense harpy rookery dominates the edge of your [camp], towering over the rest of it.  Innumerable harpies flit around it, always working on it, assisted from below by the few sisters unlucky enough to be flightless.  ");
			}
			outputText("\n\n");
		}
		//Traps
		if (player.hasStatusEffect(StatusEffects.DefenseCanopy)) {
			outputText("A thorny tree has sprouted near the center of the [camp], growing a protective canopy of spiky vines around the portal and your [camp].  ");
		}
        //Wall
		if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 10 && flags[kFLAGS.CAMP_WALL_PROGRESS] < 100) {
			if (flags[kFLAGS.CAMP_WALL_PROGRESS] / 10 == 1) outputText("A thick wooden wall has been erected. Incomplete as it is, it provides only a small amount of defense.  ");
			else outputText("Thick wooden walls have been erected around your camp.  ");
		} else if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100) {
			outputText("Thick wooden walls have been erected; they surround half of your [camp] perimeter and provide sound defense, leaving the open half for access to the stream.  ");
			if (flags[kFLAGS.CAMP_WALL_GATE] > 0) outputText("A gate has been constructed in the middle of the walls; it gets closed at night to keep any invaders out.  ");
		}
        //Imp Skulls
        if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 10 && flags[kFLAGS.CAMP_WALL_SKULLS] > 0) {
            if (flags[kFLAGS.CAMP_WALL_SKULLS] == 1)
                outputText("A single imp skull has been mounted " + (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100 ? "near the gateway" : "on the wall segments"));
            else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 2 && flags[kFLAGS.CAMP_WALL_SKULLS] < 5)
                outputText("Few imp skulls have been mounted " + (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100 ? "near the gateway" : "on the wall segments"));
            else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 5 && flags[kFLAGS.CAMP_WALL_SKULLS] < 15)
                outputText("Several imp skulls have been mounted " + (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100 ? "near the gateway" : "on the wall segments"));
            else
                outputText("Innumerable imp skulls decorate the " + (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100 ? "gateway and " : "") + "wall, some are even impaled on wooden spikes");
            outputText(" to serve as a deterrence.  ");
            if (flags[kFLAGS.CAMP_WALL_SKULLS] == 1) outputText("There is currently one skull.  ");
            else outputText("There are currently " + num2Text(flags[kFLAGS.CAMP_WALL_SKULLS]) + " skulls.  ");
        }
			outputText("\n\n");
		//Magic Ward
		if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] >= 2) {
			if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100) outputText("Just within the wall are the");
			else outputText("Right before the ring of traps are your");
			outputText(" warding stones. They are ");
			if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 2) outputText("currently inactive.");
			if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 3) outputText("glowing with power, protecting your [camp] from intruders.");
			outputText("\n\n");
		} else outputText("You have a number of traps surrounding your makeshift home, but they are fairly simple and may not do much to deter a demon.  ");
		outputText("The portal shimmers in the background as it always does, looking menacing and reminding you of why you came.");
		if (flags[kFLAGS.ANT_KIDS] > 1000) outputText(" Really close to it there is a small entrance to the underground maze created by your ant children. And due to Phylla wish from time to time one of your children coming out this entrance to check on the situation near portal. You feel a little more safe now knowing that it will be harder for anyone to go near the portal without been noticed or...if someone came out of the portal.");
		outputText("\n\n");
		if (flags[kFLAGS.CLARA_IMPRISONED] > 0) {
			marblePurification.claraCampAddition();
		}
		//Ember's anti-minotaur crusade!
		if (flags[kFLAGS.EMBER_CURRENTLY_FREAKING_ABOUT_MINOCUM] == 1) {
			//Modified Camp Description
			outputText("Since Ember began [ember eir] 'crusade' against the minotaur population, skulls have begun to pile up on either side of the entrance to " + emberScene.emberMF("his", "her") + " den.  There're quite a lot of them.\n\n");
		}
		//Dat tree!
		if (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0) {
			outputText("On the outer edges, half-hidden behind a rock, is a large, very healthy tree.  It grew fairly fast, but seems to be fully developed now.  Holli, Marae's corrupt spawn, lives within.\n\n");
		}
		if (flags[kFLAGS.FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0) {
			outputText("On the outer edges, half-hidden behind a rock, is a large, very healthy tree.  It grew fairly fast, but seems to be fully developed now.  Holli, Marae's spawn, lives within.\n\n");
		}
		//Hot Spring
		if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] >= 4) {
			outputText("You can see the fumes from the hot spring at the edge of your [camp].\n\n");
		}
		//Kitsune Shrine
		if (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] >= 4) {
			outputText("A shrine to Taoth stands next to your [camp], its presence warms your heart with the fox god’s laughter.\n\n");
		}

		//Display NPCs
		campFollowers(true);

		//MOUSEBITCH
		if (amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1) {
			if (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0) outputText("Amily has relocated her grass bedding to the opposite side of the [camp] from the strange tree; every now and then, she gives it a suspicious glance, as if deciding whether to move even further.\n\n");
			else outputText("A surprisingly tidy nest of soft grasses and sweet-smelling herbs has been built close to your " + (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 ? "cabin" : "bedroll") + ". A much-patched blanket draped neatly over the top is further proof that Amily sleeps here. She changes the bedding every few days, to ensure it stays as nice as possible.\n\n");
		}

		campLoversMenu(true);

		campSlavesMenu(true);

		//Hunger check!
		if (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger < 25) {
			outputText("<b>You have to eat something; your stomach is growling " + (player.hunger < 1 ? "painfully" : "loudly") + ". </b>");
			if (player.hunger < 10) {
				outputText("<b>You are getting thinner and you're losing muscles. </b>");
			}
			if (player.hunger <= 0) {
				outputText("<b>You are getting weaker due to starvation. </b>");
			}
			outputText("\n\n");
		}

		//The uber horny
		if (overLustCheck() == 2) {
			exploreEvent = null;
			placesEvent = null;
			//This once disabled the ability to rest, sleep or wait, but ir hasn't done that for many many builds
		}
		//Set up rest stuff
		//Night
		if (model.time.hours < 6 || model.time.hours > 20) {
			if (flags[kFLAGS.D3_GARDENER_DEFEATED] <= 0 && flags[kFLAGS.D3_CENTAUR_DEFEATED] <= 0 && flags[kFLAGS.D3_STATUE_DEFEATED] <= 0) outputText("It is dark out, made worse by the lack of stars in the sky.  A blood-red moon hangs in the sky, seeming to watch you, but providing little light.  It's far too dark to leave the [camp].\n\n");
			else outputText("It is dark out. Stars dot the night sky. A blood-red moon hangs in the sky, seeming to watch you, but providing little light.  It's far too dark to leave the [camp].\n\n");
			if (companionsCount() > 0 && !(model.time.hours > 4 && model.time.hours < 23)) {
				outputText("Your [camp] is silent as your companions are sleeping right now.\n");
			}
		}
		//Day Time!
		else {
			if (model.time.hours == 19) outputText("The sun is close to the horizon, getting ready to set. ");
			if (model.time.hours == 20) outputText("The sun has already set below the horizon. The sky glows orange. ");
			outputText("It's light outside, a good time to explore and forage for supplies with which to fortify your [camp].\n");
		}

		//Unlock cabin.
		if (flags[kFLAGS.CAMP_CABIN_PROGRESS] <= 0 && model.time.days >= 7) {
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 1;
			clearOutput();
			outputText("You realize that you have spent a whole week sleeping in tent every night. You need to make something so you can sleep better, long-term. Perhaps a cabin will suffice?");
			doNext(playerMenu);
			return;
		}
		//Unlock something in character creation.
		if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] == 0) {
			if (player.gender == Gender.GENDER_HERM) {
				flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] = 1;
				outputText("\n\n<b>Congratulations! You have unlocked hermaphrodite option on character creation, accessible from New Game Plus!</b>");
				CoC.instance.saves.savePermObject(false);
			}
		}
		//Unlock hot spring.
		if (loversHotBathCount() > 1) {
			if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] < 1) flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] = 1;
		}
		//Unlock sparring ring.
		if (sparableCampMembersCount() >= 2) {
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 1) flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] = 1;
		}
		//Unlock Coronation Quest
		if (flags[kFLAGS.THE_TRENCH_ENTERED] == 11 && player.level >= 30 && rand(4) == 0) {
			clearOutput();
			outputText("You can’t help but furiously start rubbing your eyes as you feel a sharp pricking, as if something was in your eyes, maybe the nearby stream could help you wash whatever has gotten in your eyes out.\n\n");
			outputText("Now over at the stream, you dip your face into the water, and after a few moments of attempting to clear out whatever has gotten stuck in your eyes with no progress, you begrudgingly give up and stare at the water’s surface as you start to go over your options. ");
			outputText("However you see something quite strange in the reflection, mainly your eyes which seem to be shifting from their usual yellow to a blue before reverting with an irritating itch. Maybe Grayda knows what’s happening to you?\n\n");
			flags[kFLAGS.THE_TRENCH_ENTERED] = 12;
			doNext(playerMenu);
			return;
		}
		//Wood Elf weapon fix.
		if (!player.hasPerk(PerkLib.Rigidity) && ((flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] != 0) || (flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] != 0))) {
			if (!player.weapon.isNothing){
				if (flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] != 0){
					inventory.takeItem(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]), playerMenu);
				}
				else{
					inventory.takeItem(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID]), playerMenu);
				}
			}
			else {
				if (flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] != 0){
					player.setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
				}
				else{
					player.setWeaponRange(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID])as WeaponRange);
				}
			}
			flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = 0;
			flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] = 0;
		}

		//Menu
		// [Explore  ] [Places    ] [Inventory] [Stash       ] [      ]
		// [Followers] [Lovers    ] [Slaves   ] [Camp Actions] [Cabin ]
		// [SF/Morph ] [Masturbate] [Wait/R/S ] [            ] [Cheats]

		menu();
		addButton(0, "Explore", exploreEvent).hint("Explore to find new regions and visit any discovered regions.");
		addButton(1, "Places", placesEvent).hint("Visit any places you have discovered so far.");
		addButton(2, "Inventory", inventory.inventoryMenu).hint("The inventory allows you to use an item.  Be careful, as this leaves you open to a counterattack when in combat.");
		if (inventory.showStash()) addButton(3, "Stash", inventory.stash).hint("The stash allows you to store your items safely until you need them later.");
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 2) addButton(4, "Warehouse", inventory.warehouse).hint("The warehouse and granary allow you to store your items in a more organized manner.");
		if (followersCount() > 0) addButton(5, "Followers", campFollowers).hint("Check up on any followers or companions who are joining you in or around your [camp].  You'll probably just end up sleeping with them.");
		if (loversCount() > 0) addButton(6, "Lovers", campLoversMenu).hint("Check up on any lovers you have invited to your [camp] so far and interact with them.");
		if (slavesCount() > 0) addButton(7, "Slaves", campSlavesMenu).hint("Check up on any slaves you have received and interact with them.");
		addButton(8, "Camp Actions", campActions).hint("Read your codex, questlog or interact with the [camp] surroundings.");
		if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10 || flags[kFLAGS.CAMP_BUILT_CABIN] >= 1) addButton(9, "Enter Cabin", cabinProgress.initiateCabin).hint("Enter your cabin."); //Enter cabin for furnish.
		if (player.hasPerk(PerkLib.JobSoulCultivator)) {
			if (player.hasPerk(PerkLib.Soulless)) addButtonDisabled(10, "Soulforce", "You no longer have soul that allow you to use cultivation options.");
			else addButton(10, "Soulforce", soulforce.accessSoulforceMenu).hint("Spend some time on the cultivation, or spend some of the soulforce.");
		}
		else if (!player.hasPerk(PerkLib.JobSoulCultivator) && player.hasPerk(PerkLib.Metamorph)) {
			if (player.blockingBodyTransformations()) addButtonDisabled(10, "Metamorph", "Your current body state prevents you from using Metamorph. (Either cure it or ascend to gain access to metamorph menu again)");
			else if (player.hasPerk(PerkLib.Soulless)) addButtonDisabled(10, "Metamorph", "Your current soul state prevents you from using Metamorph. (If you could somehow fix it you would gain access to metamorph menu again)");
			else addButton(10, "Metamorph", SceneLib.metamorph.openMetamorph).hint("Use your soulforce to mold your body.");
		}
		SceneLib.masturbation.masturButton(11);
		addButton(12, "Wait", doWaitMenu).hint("Wait for one to twelve hours. Or until the night comes.");
		if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(12, "Rest", restMenu).hint("Rest for one to twelve hours. Or until fully healed / night comes.");
		if(((model.time.hours <= 5 || model.time.hours >= 21) && !canExploreAtNight) || (!isNightTime && canExploreAtNight)) {
			addButton(12, "Sleep", doSleep).hint("Turn yourself in for the night.");
			if(isAWerebeast && flags[kFLAGS.LUNA_MOON_CYCLE] == 8) {
				addButtonDisabled(12, "Sleep", "Try as you may you cannot find sleep tonight. The damn moon won't let you rest as your urges to hunt and fuck are on the rise.");
			}
		}
		if (CoC_Settings.debugBuild) addButton(14, "Cheats", testmenu.SoulforceCheats).hint("This should be obvious. ^^");

		//Remove buttons according to conditions.
		if (isNightTime) {
			if (model.time.hours >= 22 || model.time.hours < 6) {
				if (nightTimeActiveFollowers() == 0) removeButton(5); //Followers
				if (nightTimeActiveLovers() == 0) removeButton(6); //Lovers
				if (nightTimeActiveSlaves() == 0) removeButton(7); //Slaves
				//removeButton(8); //Camp Actions, removing this to change it further down
			}
		}
		//Update saves
		if (flags[kFLAGS.ERLKING_CANE_OBTAINED] == 0 && player.hasKeyItem("Golden Antlers") >= 0) {
			clearOutput();
			outputText("Out of nowhere, a cane appears on your " + bedDesc() + ". It looks like it once belonged to the Erlking. Perhaps the cane has been introduced into the game and you've committed a revenge on the Erlking? Regardless, you take it anyway. ");
			flags[kFLAGS.ERLKING_CANE_OBTAINED] = 1;
			inventory.takeItem(weapons.HNTCANE, doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] < CoC.instance.modSaveVersion) {
			saveUpdater.promptSaveUpdate();
			return;
		}
		//if (!player.hasPerk(IMutationsLib.MutationsTemplateIM)){
		//	CoC.instance.charCreation.setupMutations();
		//	return;
		//}
		//Massive Balls Bad End (Realistic Mode only)
		if (flags[kFLAGS.HUNGER_ENABLED] >= 1 && player.ballSize > (18 + (player.str / 2) + (player.tallness / 4))) {
			badEndGIANTBALLZ();
			return;
		}
		//Hunger Bad End
		if (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger <= 0) {
			//Bad end at 0 HP!
			if (player.HP <= 0 && (player.str + player.tou) < 30) {
				badEndHunger();
				return;
			}
		}
		//Min Lust Bad End (Must not have any removable/temporary min lust.)
		if (player.minLust() >= player.maxOverLust() && !flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= 168 && !player.eggs() >= 20 && !player.hasStatusEffect(StatusEffects.BimboChampagne) && !player.hasStatusEffect(StatusEffects.Luststick) && player.jewelryEffectId != 1) {
			badEndMinLust();
		}
	}

	public function hasCompanions():Boolean {
		return companionsCount() > 0;
	}

	public function companionsCount():Number {
		return followersCount() + slavesCount() + loversCount();
	}

	public function followersCount():Number {
		var counter:Number = 0;
		if (flags[kFLAGS.ALVINA_FOLLOWER] > 12 && flags[kFLAGS.ALVINA_FOLLOWER] < 20) counter++;
		if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 3) counter++;
		if (flags[kFLAGS.AURORA_LVL] >= 1) counter++;
		if (emberScene.followerEmber()) counter++;
		if (flags[kFLAGS.VALERIA_AT_CAMP] == 1) counter++;
		if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] > 0) counter++;
		if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] > 0) counter++;
		if (player.hasStatusEffect(StatusEffects.PureCampJojo)) counter++;
		if (player.hasStatusEffect(StatusEffects.CampRathazul)) counter++;
		if (followerShouldra() && !player.hasStatusEffect(StatusEffects.ShouldraOff)) counter++;
		if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0 && !player.hasStatusEffect(StatusEffects.SophieOff)) counter++;
		if (EvangelineFollower.EvangelineFollowerStage >= 1) counter++;
		if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) counter++;
		if (flags[kFLAGS.DINAH_LVL_UP] >= 1) counter++;
		if (flags[kFLAGS.MICHIKO_FOLLOWER] >= 1) counter++;
		if (flags[kFLAGS.NEISA_FOLLOWER] >= 7) counter++;
		if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) counter++;
		if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 3 && flags[kFLAGS.EXCELLIA_RECRUITED] < 33) counter++;
		if (flags[kFLAGS.MITZI_RECRUITED] >= 4) counter++;
		if (flags[kFLAGS.MITZI_DAUGHTERS] >= 4) counter++;
		if (helspawnFollower()) counter++;
		if (flags[kFLAGS.ANEMONE_KID] > 0) counter++;
		if (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4) counter++;
		if (flags[kFLAGS.FLOWER_LEVEL] >= 4) counter++;
		if (flags[kFLAGS.ZENJI_PROGRESS] == 8 || flags[kFLAGS.ZENJI_PROGRESS] == 9) counter++;
		if (flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2 && !player.hasStatusEffect(StatusEffects.KonstantinOff)) counter++;
		if (flags[kFLAGS.SIDONIE_FOLLOWER] >= 1) counter++;
		if (flags[kFLAGS.THE_TRENCH_ENTERED] > 14) counter++;
		if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) counter++;
		if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 0) counter++;
		if (flags[kFLAGS.TIFA_FOLLOWER] > 5) counter++;
		if (etnaScene().etnaTotalKids() > 0) counter++;
		for each (var npc:XXCNPC in _campFollowers) {
			if (npc.isCompanion(XXCNPC.FOLLOWER)) {
				counter++;
			}
		}
		return counter;
	}

	public function slavesCount():Number {
		var counter:Number = 0;
		if (flags[kFLAGS.EXCELLIA_RECRUITED] == 2) counter++;
		if (latexGooFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 0) counter++;
		if (vapulaSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0) counter++;
		if (campCorruptJojo() && flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 0) counter++;
		if (amilyScene.amilyFollower() && amilyScene.amilyCorrupt() && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) counter++;
		if (bimboSophie() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0 && !player.hasStatusEffect(StatusEffects.SophieOff)) counter++;//Bimbo sophie
		if (flags[kFLAGS.GALIA_LVL_UP] >= 1) counter++;
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] >= 5) counter++;
		if (ceraphIsFollower()) counter++;
		if (milkSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0) counter++;
		if (player.hasStatusEffect(StatusEffects.Familiar) && player.statusEffectv3(StatusEffects.Familiar) > 0 && player.statusEffectv3(StatusEffects.Familiar) < 4 && player.hasPerk(PerkLib.Familiar)) counter++;
		for each (var npc:XXCNPC in _campFollowers) {
			if (npc.isCompanion(XXCNPC.SLAVE)) {
				counter++;
			}
		}
		return counter;
	}

	public function slavesOptionalCount():Number {
		var counter:Number = 0;
		if (campCorruptJojo() && flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 0) counter++;
		if (amilyScene.amilyFollower() && amilyScene.amilyCorrupt() && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) counter++;
		if (bimboSophie() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) counter++;//Bimbo sophie
		return counter;
	}

	public function loversCount():Number {
		var counter:Number = 0;
		if (flags[kFLAGS.ALVINA_FOLLOWER] > 19 || SceneLib.alvinaFollower.AlvinaPurified) counter++;
		if (arianScene.arianFollower()) counter++;
		if (BelisaFollower.BelisaInCamp) counter++;
		if (LilyFollower.LilyFollowerState) counter++;
		if (TyrantiaFollower.isLover()) counter++;
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5 && !player.hasStatusEffect(StatusEffects.ChiChiOff)) counter++;
		if (flags[kFLAGS.CEANI_FOLLOWER] > 0) counter++;
		if (flags[kFLAGS.NADIA_FOLLOWER] >= 6 && !player.hasStatusEffect(StatusEffects.NadiaOff)) counter++;
		if (flags[kFLAGS.ELECTRA_FOLLOWER] > 1 && !player.hasStatusEffect(StatusEffects.ElectraOff)) counter++;
		if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] != 2 && !player.hasStatusEffect(StatusEffects.EtnaOff)) counter++;
		if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) counter++;
		if (followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff)) counter++;
		//Izma!
		if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) counter++;
		if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) counter++;
		if (player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) counter++;
		if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) counter++;
		if (followerKiha()) counter++;
		if (flags[kFLAGS.NIEVE_STAGE] == 5) counter++;
		if (flags[kFLAGS.ANT_WAIFU] > 0) counter++;
		if (flags[kFLAGS.SAMIRAH_FOLLOWER] > 9) counter++;
		if (ZenjiScenes.isLover()) counter++;
		for each (var npc:XXCNPC in _campFollowers) {
			if (npc.isCompanion(XXCNPC.LOVER)) {
				counter++;
			}
		}
		return counter;
	}

	public function submissivesAtCampCount():Number {
		var counter:Number = 0;
		counter += slavesCount();
		counter += LunaFollower.WerewolfPackMember;
		if (player.hasPerk(IMutationsLib.HellhoundFireBallsIM)) counter += LunaFollower.HellhoundPackMember;
		if (arianScene.arianFollower()) counter++;
		if (BelisaFollower.BelisaInCamp) counter++;
		if (CelessScene.instance.isCompanion() && CelessScene.instance.isCorrupt) counter++;
		if (LilyFollower.LilyFollowerState) counter++;
		if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] != 2 && !player.hasStatusEffect(StatusEffects.EtnaOff)) counter++;
		if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) counter++;
		if (flags[kFLAGS.ANT_WAIFU] > 0) counter++;
		if (flags[kFLAGS.AURORA_LVL] >= 1) counter++;
		if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) counter++;
		if (flags[kFLAGS.MITZI_RECRUITED] >= 4) counter++;
		if (flags[kFLAGS.ANEMONE_KID] > 0) counter++;
		if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) counter++;
		if (player.hasStatusEffect(StatusEffects.Familiar) && player.statusEffectv3(StatusEffects.Familiar) > 0 && player.statusEffectv3(StatusEffects.Familiar) < 4 && player.hasPerk(PerkLib.Familiar)) counter++;
		return counter;
	}

	public function loversHotBathCount():Number {
		var counter:Number = 0;
		if (flags[kFLAGS.ALVINA_FOLLOWER] > 12) counter++;
		//if (BelisaFollower.BelisaInCamp) counter++;
		//if (LilyFollower.LilyFollowerState) counter++;
		//if (TyrantiaFollower.isLover()) counter++;
		if (emberScene.followerEmber()) counter++;
		if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0 && !player.hasStatusEffect(StatusEffects.SophieOff)) counter++;
		if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) counter++;
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5 && !player.hasStatusEffect(StatusEffects.ChiChiOff)) counter++;
		if (flags[kFLAGS.CEANI_FOLLOWER] > 0) counter++;
		if (flags[kFLAGS.NADIA_FOLLOWER] >= 6 && !player.hasStatusEffect(StatusEffects.NadiaOff)) counter++;
		if (flags[kFLAGS.ELECTRA_FOLLOWER] > 1 && !player.hasStatusEffect(StatusEffects.ElectraOff)) counter++;
		if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] != 2 && !player.hasStatusEffect(StatusEffects.EtnaOff)) counter++;
		if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) counter++;
		if (followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff)) counter++;
		if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) counter++;
		if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) counter++;
		if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) counter++;
		//if (flags[kFLAGS.DINAH_LVL_UP] >= 1) counter++;
		//if (flags[kFLAGS.GALIA_LVL_UP] >= 1) counter++;
		//if (flags[kFLAGS.MICHIKO_FOLLOWER] >= 1) counter++;
		if (flags[kFLAGS.ZENJI_PROGRESS] == 8 || flags[kFLAGS.ZENJI_PROGRESS] == 9 || ZenjiScenes.isLover()) counter++;
		if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) counter++;
		if (flags[kFLAGS.MITZI_RECRUITED] >= 4) counter++;
		if (flags[kFLAGS.THE_TRENCH_ENTERED] > 14) counter++;
		if (player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) counter++;
		if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) counter++;
		if (followerKiha()) counter++;
		if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 && flags[kFLAGS.JOY_COCK_SIZE] < 1) counter++;
		if (flags[kFLAGS.SIDONIE_FOLLOWER] >= 1) counter++;
		if (flags[kFLAGS.SAMIRAH_FOLLOWER] > 9) counter++;
		return counter;
	}

	public function maleNpcsHotBathCount():Number {
		var counter:Number = 0;
		if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] != 3) counter++;
		if (player.hasStatusEffect(StatusEffects.CampRathazul)) counter++;
		if (arianScene.arianFollower() && flags[kFLAGS.ARIAN_VAGINA] < 1 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) counter++;
		if (flags[kFLAGS.IZMA_BROFIED] == 1) counter++;
		if (flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2 && !player.hasStatusEffect(StatusEffects.KonstantinOff)) counter++;
		if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 3) counter++;
		if (emberScene.followerEmber() && flags[kFLAGS.EMBER_GENDER] == 1) counter++;
		return counter;
	}

	public function sparableCampMembersCount():Number {
		var counter:Number = 0;
		if (emberScene.followerEmber()) counter++;
		if (flags[kFLAGS.AURORA_LVL] >= 1) counter++;
		if (flags[kFLAGS.VALERIA_AT_CAMP] == 1) counter++;
		if (EvangelineFollower.EvangelineFollowerStage >= 1) counter++;
		if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) counter++;
		if (flags[kFLAGS.NADIA_FOLLOWER] >= 6 && !player.hasStatusEffect(StatusEffects.NadiaOff)) counter++;
		if (flags[kFLAGS.DINAH_LVL_UP] >= 1) counter++;
		//if (flags[kFLAGS.GALIA_LVL_UP] >= 1) counter++;
		if (flags[kFLAGS.NEISA_FOLLOWER] >= 7) counter++;
		if (flags[kFLAGS.ZENJI_PROGRESS] == 8 || flags[kFLAGS.ZENJI_PROGRESS] == 9) counter++;
		if (helspawnFollower()) counter++;
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5 && !player.hasStatusEffect(StatusEffects.ChiChiOff)) counter++;
		if (flags[kFLAGS.CEANI_FOLLOWER] > 0) counter++;
		if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] != 2 && !player.hasStatusEffect(StatusEffects.EtnaOff)) counter++;
		if (flags[kFLAGS.LUNA_FOLLOWER] > 10 && !player.hasStatusEffect(StatusEffects.LunaOff)) counter++;
		if (followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff)) counter++;
		if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) counter++;
		if (followerKiha()) counter++;
		return counter;
	}

	public function nightTimeActiveFollowers():Number {
		var counter:Number = 0;
		if (followerShouldra() && !player.hasStatusEffect(StatusEffects.ShouldraOff)) counter++;
		if (flags[kFLAGS.LUNA_FOLLOWER] > 10 && !player.hasStatusEffect(StatusEffects.LunaOff)) counter++;
		return counter;
	}

	public function nightTimeActiveLovers():Number {
		var counter:Number = 0;
		if (DivaScene.instance.isCompanion()) counter++;
		return counter;
	}

	public function nightTimeActiveSlaves():Number {
		var counter:Number = 0;
		return counter;
	}

//-----------------
//-- COMPANIONS
//-----------------
	public function campLoversMenu(descOnly:Boolean = false):void {
		var buttons:ButtonDataList = new ButtonDataList();
		if (!descOnly) {
			hideMenus();
			spriteSelect(null);
			clearOutput();
			CoC.instance.inCombat = false;
			menu();
		}
		if (!(model.time.hours <= 5 || model.time.hours >= 23)) {
			if (isAprilFools() && flags[kFLAGS.DLC_APRIL_FOOLS] == 0 && !descOnly) {
				SceneLib.holidays.DLCPrompt("Lovers DLC", "Get the Lovers DLC to be able to interact with them and have sex! Start families! The possibilities are endless!", "$4.99", doCamp);
				return;
			}
			//Dridertown
			if (DriderTown.DriderTownComplete) {
				outputText("The Stone Hutch, Treehouse and Watery Orb have been changed and expanded. The Stone hutch has large swathes of silk hung off it, connecting to poles stuck deep into the ground and creating a large covered pavilion around it. ");
				outputText("The extension is enclosed with wicker walls lined with stone. The treehouse hasn’t changed much, but there’s a rope bridge connecting the flat roof of Tyrantia’s hutch with the silken treehouse.\n\n");
				outputText("Belisa’s Orb appears at first glance to have been punctured and dragged to shore. The three dwellings are connected by strings of more spider silk, with odd, dangling lamps lighting up the connected houses. Gravel paths have been constructed between the three houses.\n\n");
				buttons.add("DriderTown", SceneLib.dridertown.DriderTownEnter).hint("Check up on Belisa, Lily & Tyrantia.");
			}
			//Alvina
			if (SceneLib.alvinaFollower.AlvinaPurified) {
				SceneLib.alvinaFollower.alvinaPureCampDescript();
				buttons.add("Alvina", SceneLib.alvinaFollower.alvinaPureMainCampMenu).hint("Check up on Alvina.");
			}
			else if (flags[kFLAGS.ALVINA_FOLLOWER] > 19) {
				outputText("Alvina isn’t so far from here, having made her [camp] in a corrupted plant groove she created so to have easy access to reagents.\n\n");
				buttons.add("Alvina", SceneLib.alvinaFollower.alvinaMainCampMenu).hint("Check up on Alvina.");
			}
			//AMILY
			if (amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0 && !descOnly) {
				outputText("Amily is currently strolling around your [camp], ");
				switch (rand(6)) {
					case 0:
						outputText("dripping water and stark naked from a bath in the stream");
						if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText(".  Rathazul glances over and immediately gets a nosebleed");

						break;

					case 1:
						outputText("slouching in the shade of some particularly prominent rocks, whittling twigs to create darts for her blowpipe");
						break;

					case 2:
						outputText("dipping freshly-made darts into a jar of something that looks poisonous");
						break;

					case 3:
						outputText("eating some of your supplies");
						break;

					case 4:
						outputText("and she flops down on her nest to have a rest");
						break;
					default:
						outputText("peeling the last strips of flesh off of an imp's skull and putting it on a particularly flat, sun-lit rock to bleach as a trophy");
						break;
				}
				outputText(".\n\n");
				buttons.add("Amily", amilyScene.amilyFollowerEncounter2).disableIf(player.statusEffectv1(StatusEffects.CampLunaMishaps1) > 0, "Hurt foot.");
			}
			//Amily out freaking Urta?
			else if (flags[kFLAGS.AMILY_VISITING_URTA] == 1 || flags[kFLAGS.AMILY_VISITING_URTA] == 2) {
				outputText("Amily's bed of grass and herbs lies empty, the mouse-woman still absent from her sojourn to meet your other lover.\n\n");
			}
			//Arian
			if (arianScene.arianFollower()) {
				outputText("Arian's tent is here, if you'd like to go inside.\n\n");
				buttons.add("Arian", arianScene.visitAriansHouse);
			}
			//Belisa
			if (BelisaFollower.BelisaInCamp && !DriderTown.DriderTownComplete) {
				outputText("On the water, Belisa anchored her silk dome. However, since you’ve seen it, the dwelling has changed. Instead of a fully submerged bubble-like structure, it’s got a silky curtain for a door, and a solid wooden dock’s been added to anchor the odd building to the ground. Outside the dwelling, a small stall’s been set up, and Belisa’s wares are on display.\n\n");
				buttons.add("Belisa", SceneLib.belisa.BelisaMainCampMenu).disableIf(player.statusEffectv3(StatusEffects.CampSparingNpcsTimers5) > 0, "Training.");
			}
			//Cai'Lin
//	buttons.add("???").disable("Look into my eyes and answer me: Am I beautiful?");
			//Ceani
			if (flags[kFLAGS.CEANI_FOLLOWER] > 0) {
				outputText("Ceani is lazily sunbathing at the other side of the [camp].\n\n");
				buttons.add("Ceani", SceneLib.ceaniScene.ceaniCampMainMenu).disableIf(player.statusEffectv3(StatusEffects.CampSparingNpcsTimers2) > 0, "Training.");
			}
			//Chi Chi
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5 && !player.hasStatusEffect(StatusEffects.ChiChiOff)) {
				outputText("You can see Chi Chi " + (player.hasStatusEffect(StatusEffects.PureCampJojo) ?  "not so far from Jojo's place" : "near the center of your camp") + ". She’s busy practicing her many combos on a dummy. Said dummy will more than likely have to be replaced within the next twenty-four hours.\n\n");
				if (player.statusEffectv4(StatusEffects.CampLunaMishaps2) > 0) buttons.add("Chi Chi", SceneLib.chichiScene.ChiChiCampMainMenu2).disableIf(player.statusEffectv4(StatusEffects.CampLunaMishaps2) > 0, "Wet.");
				else buttons.add("Chi Chi", SceneLib.chichiScene.ChiChiCampMainMenu2).disableIf(player.statusEffectv2(StatusEffects.CampSparingNpcsTimers2) > 0, "Training.");
			}
			//Electra
			if (flags[kFLAGS.ELECTRA_FOLLOWER] > 1 && !player.hasStatusEffect(StatusEffects.ElectraOff)) {
				outputText("Electra is quietly resting in the grass. Occasional static jolts zap nearby bugs that gets too close.\n\n");
				buttons.add("Electra", SceneLib.electraScene.ElectraCampMainMenu).disableIf(player.statusEffectv3(StatusEffects.CampSparingNpcsTimers4) > 0, "Training.");
			}
			//Etna
			if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] != 2 && !player.hasStatusEffect(StatusEffects.EtnaOff)) {
				if (EtnaFollower.EtnaHunting && time.hours >= 8 && time.hours <= 17)
					outputText("Etna is out hunting for cock since you dont have enough fluids to sustain her.\n\n");
				else outputText("Etna is resting lazily on a rug in a very cat-like manner. She’s looking at you always with this adorable expression of hers, her tail wagging expectantly at your approach.\n\n");
				buttons.add("Etna", SceneLib.etnaScene.etnaCampMenu2)
						.disableIf(player.statusEffectv1(StatusEffects.CampLunaMishaps2) > 0 && player.statusEffectv1(StatusEffects.CampLunaMishaps2) > 0, "Sleeping.")
						.disableIf(player.statusEffectv4(StatusEffects.CampSparingNpcsTimers1) > 0, "Training.")
						.disableIf(EtnaFollower.EtnaHunting && time.hours >= 8 && time.hours <= 17, "Hunting");
			}
			//Excellia Lover
			if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) {
				outputText("Excellia seems to be working on her combat skills against a training dummy. " + (SceneLib.excelliaFollower.totalExcelliaChildren() > 1 ? "She shows her children a few fighting techniques as they watch her attentively. Some even practice them with friendly spars between one another. " : "") + "When she notices you, she gives a friendly nod before going back to pummeling the dummy.\n\n");
				buttons.add("Excellia", SceneLib.excelliaFollower.ExcelliaCampMainMenuFixHer).hint("Visit Excellia.");
			}
			//Helia
			if (SceneLib.helScene.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff)) {
				if (flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 2) {
					//Hel @ Camp: Follower Menu
					//(6-7)
					if (model.time.hours <= 7) outputText("Hel is currently sitting at the edge of [camp], surrounded by her scraps of armor, sword, and a few half-empty bottles of vodka.  By the way she's grunting and growling, it looks like she's getting ready to flip her shit and go running off into the plains in her berserker state.\n\n");
					//(8a-5p)
					else if (model.time.hours <= 17) outputText("Hel's out of [camp] at the moment, adventuring on the plains.  You're sure she'd be on hand in moments if you needed her, though.\n\n");
					//5-7)
					else if (model.time.hours <= 19) outputText("Hel's out visiting her family in Tel'Adre right now, though you're sure she's only moments away if you need her.\n\n");
					//(7+)
					else outputText("Hel is fussing around her hammock, checking her gear and sharpening her collection of blades.  Each time you glance her way, though, the salamander puts a little extra sway in her hips and her tail wags happily.\n\n");
				} else if (flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 1) {
					if (flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] == 1) {
						outputText("Hel has returned to [camp], though for now she looks a bit bored.  Perhaps she is waiting on something.\n\n");
					} else {
						outputText("<b>You see the salamander Helia pacing around [camp], anxiously awaiting your departure to the harpy roost. Seeing you looking her way, she perks up, obviously ready to get underway.</b>\n\n");
					}
				}
				buttons.add("Helia", helFollower.heliaFollowerMenu2).disableIf(player.statusEffectv3(StatusEffects.CampLunaMishaps2) > 0, "Sleeping.");
			}
			//Isabella
			if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) {
				if (model.time.hours >= 21 || model.time.hours <= 5) outputText("Isabella is sound asleep in her bunk and quietly snoring.");
				else if (model.time.hours == 6) outputText("Isabella is busy eating some kind of grain-based snack for breakfast.  The curly-haired cow-girl gives you a smile when she sees you look her way.");
				else if (model.time.hours == 7) outputText("Isabella, the red-headed cow-girl, is busy with a needle and thread, fixing up some of her clothes.");
				else if (model.time.hours == 8) outputText("Isabella is busy cleaning up the [camp], but when she notices you looking her way, she stretches up and arches her back, pressing eight bullet-hard nipples into the sheer silk top she prefers to wear.");
				else if (model.time.hours == 9) outputText("Isabella is out near the fringes of your campsite.  She has her massive shield in one hand and appears to be keeping a sharp eye out for intruders or demons.  When she sees you looking her way, she gives you a wave.");
				else if (model.time.hours == 10) outputText("The cow-girl warrioress, Isabella, is sitting down on a chair and counting out gems from a strange pouch.  She must have defeated someone or something recently.");
				else if (model.time.hours == 11) outputText("Isabella is sipping from a bottle labelled 'Lactaid' in a shaded corner.  When she sees you looking she blushes, though dark spots appear on her top and in her skirt's middle.");
				else if (model.time.hours == 12) outputText("Isabella is cooking a slab of meat over the fire.  From the smell that's wafting this way, you think it's beef.  Idly, you wonder if she realizes just how much like her chosen food animal she has become.");
				else if (model.time.hours == 13) {
					outputText("Isabella ");
					var izzyCreeps:Array = [];
					//Build array of choices for izzy to talk to
					if (player.hasStatusEffect(StatusEffects.CampRathazul))
						izzyCreeps[izzyCreeps.length] = 0;
					if (player.hasStatusEffect(StatusEffects.PureCampJojo))
						izzyCreeps[izzyCreeps.length] = 1;
					if (amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0)
						izzyCreeps[izzyCreeps.length] = 2;
					if (amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 2 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0)
						izzyCreeps[izzyCreeps.length] = 3;
					if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0)
						izzyCreeps[izzyCreeps.length] = 4;
					//Base choice - book
					izzyCreeps[izzyCreeps.length] = 5;
					//Select!
					var choice:int = rand(izzyCreeps.length);

					if (izzyCreeps[choice] == 0) outputText("is sitting down with Rathazul, chatting amiably about the weather.");
					else if (izzyCreeps[choice] == 1) outputText("is sitting down with Jojo, smiling knowingly as the mouse struggles to keep his eyes on her face.");
					else if (izzyCreeps[choice] == 2) outputText("is talking with Amily, sharing stories of the fights she's been in and the enemies she's faced down.  Amily seems interested but unimpressed.");
					else if (izzyCreeps[choice] == 3) outputText("is sitting down chatting with Amily, but the corrupt mousette is just staring at Isabella's boobs and masturbating.  The cow-girl is pretending not to notice.");
					else if (izzyCreeps[choice] == 4) outputText("is sitting down with Izma and recounting some stories, somewhat nervously.  Izma keeps flashing her teeth in a predatory smile.");
					else outputText("is sitting down and thumbing through a book.");
				} else if (model.time.hours == 14) outputText("Isabella is working a grindstone and sharpening her tools.  She even hones the bottom edge of her shield into a razor-sharp cutting edge.  The cow-girl is sweating heavily, but it only makes the diaphanous silk of her top cling more alluringly to her weighty chest.");
				else if (model.time.hours == 15) outputText("The warrior-woman, Isabella is busy constructing dummies of wood and straw, then destroying them with vicious blows from her shield.  Most of the time she finishes by decapitating them with the sharp, bottom edge of her weapon.  She flashes a smile your way when she sees you.");
				else if (model.time.hours == 16) outputText("Isabella is sitting down with a knife, the blade flashing in the sun as wood shavings fall to the ground.  Her hands move with mechanical, practiced rhythm as she carves a few hunks of shapeless old wood into tools or art.");
				else if (model.time.hours == 17) outputText("Isabella is sitting against one of the large rocks near the outskirts of your [camp], staring across the wasteland while idly munching on what you assume to be a leg of lamb.  She seems lost in thought, though that doesn't stop her from throwing a wink and a goofy food-filled grin toward you.");
				else if (model.time.hours == 18) outputText("The dark-skinned cow-girl, Isabella, is sprawled out on a carpet and stretching.  She seems surprisingly flexible for someone with hooves and oddly-jointed lower legs.");
				else if (model.time.hours == 19) {
					//[(Izzy Milked Yet flag = -1)
					if (flags[kFLAGS.ISABELLA_MILKED_YET] == -1) outputText("Isabella has just returned from a late visit to Whitney's farm, bearing a few filled bottles and a small pouch of gems.");
					else outputText("Isabella was hidden behind a rock when you started looking for her, but as soon as you spot her in the darkness, she jumps, a guilty look flashing across her features.  She turns around and adjusts her top before looking back your way, her dusky skin even darker from a blush.  The cow-girl gives you a smile and walks back to her part of [camp].  A patch of white decorates the ground where she was standing - is that milk?  Whatever it is, it's gone almost as fast as you see it, devoured by the parched, wasteland earth.");
				} else if (model.time.hours == 20) outputText("Your favorite chocolate-colored cowgirl, Isabella, is moving about, gathering all of her scattered belongings and replacing them in her personal chest.  She yawns more than once, indicating her readiness to hit the hay, but her occasional glance your way lets you know she wouldn't mind some company before bed.");
				else outputText("Isabella looks incredibly bored right now.");
				if (isabellaScene.totalIsabellaChildren() > 0) {
					var babiesList:Array = [];
					if (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_BOYS) > 0) {
						babiesList.push((isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_BOYS) == 1 ? "a" : num2Text(isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_BOYS))) + " human son" + (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_BOYS) == 1 ? "" : "s"));
					}
					if (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_GIRLS) > 0) {
						babiesList.push((isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_GIRLS) == 1 ? "a" : num2Text(isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_GIRLS))) + " human daughter" + (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_GIRLS) == 1 ? "" : "s"));
					}
					if (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_HERMS) > 0) {
						babiesList.push((isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_HERMS) == 1 ? "a" : num2Text(isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_HERMS))) + " human herm" + (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_HERMS) == 1 ? "" : "s"));
					}
					if (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWGIRLS) > 0) {
						babiesList.push((isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWGIRLS) == 1 ? "a" : num2Text(isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWGIRLS))) + " cow girl" + (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWGIRLS) == 1 ? "" : "s"));
					}
					if (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWFUTAS) > 0) {
						babiesList.push((isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWFUTAS) == 1 ? "a" : num2Text(isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWFUTAS))) + " cow herm" + (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWFUTAS) == 1 ? "" : "s"));
					}
					outputText("  Isabella has set up a small part of her \"corner\" in the [camp] as a nursery. She has sawn a " + (Math.ceil(isabellaScene.totalIsabellaChildren() / 2) == 1 ? "barrel" : "number of barrels") + " in half and lined " + (Math.ceil(isabellaScene.totalIsabellaChildren() / 2) == 1 ? "it" : "them") + " with blankets and pillows to serve as rocking cribs. ");
					outputText("You have " + formatStringArray(babiesList) + " with her, all living here; unlike native Marethians, they will need years and years of care before they can go out into the world on their own.");
				}
				outputText("\n\n");
				buttons.add("Isabella", isabellaFollowerScene.callForFollowerIsabella).disableIf(player.statusEffectv2(StatusEffects.CampSparingNpcsTimers1) > 0, "Training.");
			}
			//Izma
			if (izmaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
				if (flags[kFLAGS.IZMA_BROFIED] > 0) {
					if (rand(6) == 0 && camp.vapulaSlave() && flags[kFLAGS.VAPULA_HAREM_FUCK] > 0) outputText("Izmael is standing a short distance away with an expression of unadulterated joy on his face, Vapula knelt in front of him and fellating him with noisy enthusiasm.  The shark morph dreamily opens his eyes to catch you staring, and proceeds to give you a huge grin and two solid thumbs up.");
					else if (model.time.hours >= 6 && model.time.hours <= 12) outputText("You keep hearing the sound of objects hitting water followed by peals of male laughter coming from the stream. It sounds as if Izmael is throwing large rocks into the stream and finding immense gratification from the results. In fact, you’re pretty sure that’s exactly what he’s doing.");
					else if (model.time.hours <= 16) outputText("Izmael is a short distance away doing squat thrusts, his body working like a piston, gleaming with sweat. He keeps bobbing his head up to see if anybody is watching him.");
					else if (model.time.hours <= 19) outputText("Izmael is sat against his book chest, masturbating furiously without a care in the world. Eyes closed, both hands pumping his immense shaft, there is an expression of pure, childish joy on his face.");
					else if (model.time.hours <= 22) outputText("Izmael has built a fire and is flopped down next to it. You can’t help but notice that he’s used several of his books for kindling. His eyes are locked on the flames, mesmerized by the dancing light and heat.");
					else outputText("Izmael is currently on his bedroll, sleeping for the night.");
					outputText("\n\n");
					buttons.add("Izmael", izmaScene.izmaelScene.izmaelMenu);
				} else {
					outputText("Neatly laid near the base of your own is a worn bedroll belonging to Izma, your tigershark lover. It's a snug fit for her toned body, though it has some noticeable cuts and tears in the fabric. Close to her bed is her old trunk, almost as if she wants to have it at arms length if anyone tries to rob her in her sleep. ");
					switch (rand(3)) {
						case 0:
							outputText("Izma's lazily sitting on the trunk beside her bedroll, reading one of the many books from inside it. She smiles happily when your eyes linger on her, and you know full well she's only half-interested in it.");
							break;
						case 1:
							outputText("You notice Izma isn't around right now. She's probably gone off to the nearby stream to get some water. Never mind, she comes around from behind a rock, still dripping wet.");
							break;
						case 2:
							outputText("Izma is lying on her back near her bedroll. You wonder at first just why she isn't using her bed, but as you look closer you notice all the water pooled beneath her and the few droplets running down her arm, evidence that she's just returned from the stream.");
							break;
					}
					outputText("\n\n");
					buttons.add("Izma", izmaScene.izmaFollowerMenu).disableIf(player.statusEffectv4(StatusEffects.CampLunaMishaps1) > 0, "Fish smell.");
				}
			}
			//Kiha!
			if (followerKiha()) {
				if (KihaFollower.DergKidnapped == 1)
					outputText("Kiha is nowhere to be seen");
				//(6-7)
				else if (model.time.hours < 7) outputText("Kiha is sitting near the fire, her axe laying across her knees as she polishes it.\n\n");
				else if (model.time.hours < 19) {
					if (kihaFollower.totalKihaChildren() > 0 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] > 160 && (flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] % 3 == 0 || model.time.hours == 17)) outputText("Kiha is breastfeeding her offspring right now.\n\n");
					else if (kihaFollower.totalKihaChildren() > 0 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] > 80 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] <= 160 && (flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] % 7 == 0 || model.time.hours == 17)) outputText("Kiha is telling stories to her draconic child" + (kihaFollower.totalKihaChildren() == 1 ? "" : "ren") + " right now.\n\n");
					else outputText("Kiha's out right now, likely patrolling for demons to exterminate.  You're sure a loud call could get her attention.\n\n");
				} else {
					if (kihaFollower.totalKihaChildren() > 0 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] > 160 && (flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] % 3 == 0 || model.time.hours == 20)) outputText("Kiha is breastfeeding her offspring right now.\n\n");
					else if (kihaFollower.totalKihaChildren() > 0 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] > 80 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] <= 160 && (flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] % 7 == 0 || model.time.hours == 20)) outputText("Kiha is telling stories to her draconic child" + (kihaFollower.totalKihaChildren() == 1 ? "" : "ren") + " right now.\n\n");
					else if (kihaFollower.totalKihaChildren() > 0 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] <= 80 && (flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] % 3 == 0 || model.time.hours == 20)) {
						outputText("Kiha is training her " + (kihaFollower.totalKihaChildren() == 1 ? "child to become a strong warrior" : "children to become strong warriors") + ". ");
						if (rand(2) == 0) outputText("Right now, she's teaching various techniques.");
						else outputText("Right now, she's teaching her child" + (kihaFollower.totalKihaChildren() == 1 ? "" : "ren") + " how to make use of axes.\n\n");
					} else {
						outputText("Kiha is utterly decimating a set of practice dummies she's set up out on the edge of [camp].  All of them have crudely drawn horns. ");
						if (kihaFollower.totalKihaChildren() > 0 && (kihaFollower.totalKihaChildren() >= 2 || flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] <= 60)) outputText("Some of them are saved for her child" + (kihaFollower.totalKihaChildren() == 1 ? "" : "ren") + " to train on. ");
						outputText("Most of them are on fire.\n\n");
					}
				}
				if (KihaFollower.DergKidnapped == 1) buttons.add("Kiha", kihaFollower.KihaKidnapped);
				else if (player.statusEffectv3(StatusEffects.CampLunaMishaps1) > 0) buttons.add("Kiha", kihaScene.encounterKiha2).disableIf(player.statusEffectv3(StatusEffects.CampLunaMishaps1) > 0, "Cleaning burnt meat.");
				else buttons.add("Kiha", kihaScene.encounterKiha2).disableIf(player.statusEffectv3(StatusEffects.CampSparingNpcsTimers1) > 0, "Training.");
			}
			//Lily
			if (LilyFollower.LilyFollowerState && !DriderTown.DriderTownComplete) {
				outputText("A line of targets have been set up along the river and a small house of silk has been constructed in one of the trees. You hear the occasional whizz of arrows, or rustling in the trees.\n\n");
				buttons.add("Lily", SceneLib.lily.LilyCampFollower).disableIf(player.statusEffectv2(StatusEffects.CampSparingNpcsTimers5) > 0, "Training.");
			}
			//MARBLE
			if (player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) {
				outputText((flags[kFLAGS.CAMP_BUILT_CABIN] > 0 ? "A bedroll rests next to your cabin" : "A second bedroll rests next to yours") + "; a large two handed hammer sometimes rests against it, depending on whether or not its owner needs it at the time.  ");
				//Normal Murbles
				if (flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 4) outputText("Marble isn’t here right now; she’s still off to see her family.");
				//requires at least 1 kid, time is just before sunset, this scene always happens at this time if the PC has at least one kid.
				else if (flags[kFLAGS.MARBLE_KIDS] >= 1 && (model.time.hours == 19 || model.time.hours == 20)) {
					outputText("Marble herself is currently in the nursery, putting your ");
					if (flags[kFLAGS.MARBLE_KIDS] == 1) outputText("child");
					else outputText("children");
					outputText(" to bed.");
				}
				//at 6-7 in the morning, scene always displays at this time
				else if (model.time.hours == 6 || model.time.hours == 7) outputText("Marble is off in an open area to the side of your [camp] right now.  She is practicing with her large hammer, going through her daily training.");
				//after nightfall, scene always displays at this time unless PC is wormed
				else if (model.time.hours >= 21 && !player.hasStatusEffect(StatusEffects.Infested)) {
					outputText("Marble is hanging around her bedroll waiting for you to come to bed.  However, sometimes she lies down for a bit, and sometimes she paces next to it.");
					if (flags[kFLAGS.MARBLE_LUST] > 30) outputText("  She seems to be feeling antsy.");
				} else if (flags[kFLAGS.MARBLE_KIDS] > 0 && model.time.hours < 19 && model.time.hours > 7) {
					//requires at least 6 kids, and no other parental characters in camp
					if (rand(2) == 0 && flags[kFLAGS.MARBLE_KIDS] > 5) outputText("Marble is currently tending to your kids, but she looks a bit stressed out right now.  It looks like " + num2Text(flags[kFLAGS.MARBLE_KIDS]) + " might just be too many for her to handle on her own...");
					//requires at least 4 kids
					else if (rand(3) == 0 && flags[kFLAGS.MARBLE_KIDS] > 3) outputText("Marble herself is in the [camp] right now, telling a story about her travels around the world to her kids as they gather around her.  The children are completely enthralled by her words.  You can't help but smile.");
					//Requires 2 boys
					else if (rand(3) == 0 && flags[kFLAGS.MARBLE_BOYS] > 1) {
						outputText("Marble herself is currently refereeing a wrestling match between two of your sons.  It seems like it's a contest to see which one of them gets to go for a ride between her breasts in a game of <i>Bull Blasters</i>, while the loser has to sit on her shoulders.");
					}
					//requires at least 2 kids
					else if (rand(3) == 0 && flags[kFLAGS.MARBLE_KIDS] - flags[kFLAGS.MARBLE_BOYS] > 1) outputText("Marble herself is involved in a play fight with two of your kids brandishing small sticks.  It seems that the <i>mommy monster</i> is terrorising the [camp] and needs to be stopped by the <i>Mighty Moo and her sidekick Bovine Lass</i>.");
					else if (rand(3) == 0 && flags[kFLAGS.MARBLE_KIDS] > 1) outputText("Marble herself is out right now; she's taken her kids to go visit Whitney.  You're sure though that she'll be back within the hour, so you could just wait if you needed her.");
					else {
						//requires at least 1 kid
						if (rand(2) == 0) {
							outputText("Marble herself is nursing ");
							if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("one of your cow-girl children");
							else outputText("your cow-girl child");
							outputText(" with a content look on her face.");
						} else {
							outputText("Marble herself is watching your kid");
							if (flags[kFLAGS.MARBLE_KIDS] > 0) outputText("s");
							outputText(" playing around the [camp] right now.");
						}
					}
				} else {
					//(Choose one of these at random to display each hour)
					var c:int = rand(5);
					switch (c) {
						case 0:
							outputText("Marble herself has gone off to Whitney's farm to get milked right now.");
							break;
						case 1:
							outputText("Marble herself has gone off to Whitney's farm to do some chores right now.");
							break;
						case 2:
							outputText("Marble herself isn't at the [camp] right now; she is probably off getting supplies, though she'll be back soon enough.");
							break;
						case 3:
							outputText("Marble herself is resting on her bedroll right now.");
							break;
						case 4:
							outputText("Marble herself is wandering around the [camp] right now.");
							break;
					}
					if (c < 3) {
						outputText("  You're sure she'd be back in moments if you needed her.");
					}
				}
				//Out getting family
				//else outputText("Marble is out in the wilderness right now, searching for a relative.");
				outputText("\n\n");
				if (flags[kFLAGS.MARBLE_PURIFICATION_STAGE] != 4) buttons.add("Marble", marbleScene.interactWithMarbleAtCamp).hint("Go to Marble the cowgirl for talk and companionship.");
			}
			//Nadia
			if (flags[kFLAGS.NADIA_FOLLOWER] >= 6 && !player.hasStatusEffect(StatusEffects.NadiaOff)) {
				outputText("Nadia is resting next to her many medical tools and medicines.\n\n");
				buttons.add("Nadia", SceneLib.nadiaScene.mainCampMenu).disableIf(player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) > 0, "Training.");
			}
			//Phylla
			if (flags[kFLAGS.ANT_WAIFU] > 0) {
				outputText("You see Phylla's anthill in the distance.  Every now and then you see");
				//If PC has children w/ Phylla:
				if (flags[kFLAGS.ANT_KIDS] > 0 && flags[kFLAGS.ANT_KIDS] <= 250) outputText(" one of your children exit the anthill to unload some dirt before continuing back down into the colony.  It makes you feel good knowing your offspring are so productive.");
				else if (flags[kFLAGS.ANT_KIDS] > 250 && flags[kFLAGS.ANT_KIDS] <= 1000) outputText(" few of your many children exit the anthill to unload some dirt before vanishing back inside.  It makes you feel good knowing your offspring are so productive.");
				else if (flags[kFLAGS.ANT_KIDS] > 1000) outputText(" some of your children exit the anthill using main or one of the additionally entrances to unload some dirt. Some of them instead of unloading dirt coming out to fulfill some other task that their mother gave them.  You feel a little nostalgic seeing how this former small colony grown to such a magnificent size.");
				else outputText(" Phylla appear out of the anthill to unload some dirt.  She looks over to your campsite and gives you an excited wave before heading back into the colony.  It makes you feel good to know she's so close.");
				outputText("\n\n");
				buttons.add("Phylla", SceneLib.phyllaScene.introductionToPhyllaFollower);
			}
			//Samirah
			if (flags[kFLAGS.SAMIRAH_FOLLOWER] > 9) {
				outputText("Samirah is quietly sunbathing on a rock, her long tail wrapped around on itself. She looks like she is very busy having a hissing conversation with a common snake which, considering her way of speech, isn’t really that strange.\n\n");
				buttons.add("Samirah", SceneLib.samirah.samirahMainCampMenu);
			}
			//Tyrantia
			if (TyrantiaFollower.isLover() && !DriderTown.DriderTownComplete) {
				outputText("A decent distance away from your camp, in between the river and some trees, a hut’s been erected. Constructed mostly from stone and logs, with odd, goopy webbing as a crude mortar, the dwelling is nonetheless huge. ");
				outputText("Tyrantia occasionally walks into the dwelling, coming out with a different tool or material. She’s keeping herself busy, if the line of demon skulls around the house are any indication.\n\n");
				buttons.add("Tyrantia", SceneLib.tyrantia.TyrantiaAtCamp).disableIf(player.statusEffectv1(StatusEffects.CampSparingNpcsTimers5) > 0, "Training.");
			}
			//Zenji
			if (ZenjiScenes.isLover() && TrollVillage.ZenjiVillageStage != 2) {
				if (model.time.hours >= 7 && model.time.hours <= 18) {
					if (slavesCount() > 0 && rand(5) == 0) outputText("Zenji is keeping a close eye on some of your more corrupt camp members, ensuring that they don’t cause any harm.");
					else if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 998700 && rand(5) == 0) outputText("Zenji is around your [camp], it’s impossible to miss him as he strokes his length as cascades of cum leak from his erection.");
					else if (ZenjiScenes.Z1stKid != "" && rand(5) == 0) {
						if (rand(2) == 0) outputText("Zenji is at his bedroll, playing around with "+(flags[kFLAGS.ZENJI_KIDS] == 1 ? ""+ZenjiScenes.Z1stKid+"":"some of the children you've made")+".");
						else outputText("Zenji is around your [camp], he remains vigilant, surveying the area for danger atop a tree.");
					}
					else {
						var z:int = rand(7);
						switch (z) {
							case 0:
								outputText("Zenji is around your [camp], he remains vigilant, surveying the area for danger atop a tree.");
								break;
							case 1:
								outputText("Zenji is around your [camp], you see him doing a routine of stretches and working out.");
								break;
							case 2:
								outputText("Zenji is around your [camp], he is looking at you with intent almost as if you were his child.");
								break;
							case 3:
								outputText("Zenji is around your [camp], he is eyeing some of your followers warily, almost as if he doesn’t trust them.");
								break;
							case 4:
								outputText("Zenji is around your [camp], his ears twitch attentively to any signs of danger.");
								break;
							case 5:
								outputText("Zenji is around your [camp], he’s gently stroking the brush of his tail, running his fingers through them almost worriedly as he surveys his surroundings.");
								break;
							case 6:
								outputText("Zenji is around your [camp], he appears to be eating some cooked meat.");
								break;
						}
					}
				}
				else {
					if (ZenjiScenes.Z1stKid != "" && rand(5) == 0) outputText("Zenji is currently lying down on his bedroll, with "+(flags[kFLAGS.ZENJI_KIDS] == 1 ? ""+ZenjiScenes.Z1stKid+"":"one of the children you've made")+" sleeping atop his torso, as Zenji gently strokes their head.");
					else {
						if (rand(4) == 0) outputText("Zenji is around your [camp], he gives a small yawn before shaking himself awake.");
						else {
							if (rand(3) == 0) outputText("Zenji is around your [camp], it looks like he’s polishing his tusks and brushing his teeth with something.");
							else {
								if (rand(2) == 0) outputText("Zenji is around your [camp], he is coating his fur in some ashes as he grooms himself.");
								else outputText("With how dark it is, Zenji is keeping much closer to you, making sure that you’re safe. His eyes never seem to stray from you.");
							}
						}
					}
				}
				outputText("\n\n");
				buttons.add("Zenji", SceneLib.zenjiScene.loverZenjiMainCampMenu2).hint("Visit Zenji the troll.").disableIf(player.statusEffectv1(StatusEffects.CampLunaMishaps3) > 0, "Zenji is still unconscious, his steady breaths assure you he’s doing fine..");
			}
			//Nieve (jako, ze jest sezonowym camp member powinna byc na koncu listy...chyba, ze zrobie cos w stylu utworzenia mini lodowej jaskini dla niej)
			if (flags[kFLAGS.NIEVE_STAGE] == 5) {
				SceneLib.holidays.nieveCampDescs();
				outputText("\n\n");
				buttons.add("Nieve", SceneLib.holidays.approachNieve);
			}
		}
		for each(var npc:XXCNPC in _campFollowers) {
			npc.campDescription(buttons, XXCNPC.LOVER);
		}
		if (!descOnly) {
			submenu(buttons, playerMenu)
		}
	}

	public function campSlavesMenu(descOnly:Boolean = false):void {
		var buttons:ButtonDataList = new ButtonDataList();
		if (!descOnly) {
			hideMenus();
			spriteSelect(null);
			clearOutput();
			CoC.instance.inCombat = false;
			menu();
		}
		if (!(model.time.hours <= 5 || model.time.hours >= 23)) {
			if (isAprilFools() && flags[kFLAGS.DLC_APRIL_FOOLS] == 0 && !descOnly) {
				SceneLib.holidays.DLCPrompt("Slaves DLC", "Get the Slaves DLC to be able to interact with them. Show them that you're dominating!", "$4.99", doCamp);
				return;
			}
			if (latexGooFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 0) {
				outputText(flags[kFLAGS.GOO_NAME] + " lurks in a secluded section of rocks, only venturing out when called for or when she needs to gather water from the stream.\n\n");
				buttons.add(flags[kFLAGS.GOO_NAME], latexGirl.approachLatexy);
			}
			if (milkSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0) {
				outputText("Your well-endowed, dark-skinned milk-girl is here.  She flicks hopeful eyes towards you whenever she thinks she has your attention.\n\n");
				buttons.add(flags[kFLAGS.MILK_NAME], milkWaifu.milkyMenu);
			}
			//Ceraph
			if (ceraphIsFollower()) {
				buttons.add("Ceraph", ceraphFollowerScene.ceraphFollowerEncounter);
			}
			//Vapula
			if (vapulaSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0) {
				vapula.vapulaSlaveFlavorText();
				outputText("\n\n");
				buttons.add("Vapula", vapula.callSlaveVapula);
			}
			//Galia Slave
			if (flags[kFLAGS.GALIA_LVL_UP] >= 1 && EvangelineFollower.EvangelineFollowerStage >= 1) {
				if (flags[kFLAGS.GALIA_AFFECTION] < 2) outputText("Near the [camp] edge nearly next to Evangeline bedroll sits a large wooden cage for keeping female imp brought back from Adventure Guild. Despite been one of those more feral she most of the time spend sitting motionlessly and gazing into the horizon.\n\n");
				else {
					outputText("Near the [camp] edge nearly next to Evangeline bedroll sits a large wooden cage for keeping Galia. Despite been one of those more feral she most of the time spend sitting motionlessly and gazing into the horizon.\n\n");
					buttons.add("Galia", SceneLib.galiaFollower.GaliaCampMainMenuSlave).hint("Visit Galia.");
				}
			}
			//Excellia Slave
			if (flags[kFLAGS.EXCELLIA_RECRUITED] == 2) {
				outputText("Excellia sits near your " + (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "cabin" : "tent") + ". " + (SceneLib.excelliaFollower.totalExcelliaChildren() > 1 ? "Her children clamor around, groping, suckling, and licking at her supple flesh. She moos loudly as they have their way with her. When she finally notices you, she beckons for you to join too." : "She moos faintly as she idly caresses her own full breasts and wet snatch. When she notices you, she spreads her legs a bit and her tail eagerly swishes back and forth, hoping you'll come over.") + "\n\n");
				buttons.add("Excellia", SceneLib.excelliaFollower.ExcelliaCampMainMenuMakeSlave).hint("Visit Excellia.");
			}
			//Patchouli
			if (flags[kFLAGS.PATCHOULI_FOLLOWER] >= PatchouliScene.TIEDINCAMP) {
				if (flags[kFLAGS.PATCHOULI_FOLLOWER] == PatchouliScene.TIEDINCAMP) outputText("Patchouli is still tied to a tree. Even incapacitated in this way, he keeps grinning at you, as if taunting you.\n\n");
				else outputText("Patchoulie is lazily resting on a branch in the nearby tree. When she looks at you, she always has that unsettling smile of hers, as if taunting you.\n\n");
				buttons.add("Patchoule", SceneLib.patchouliScene.patchouleMainCampMenu);
			}
			//Modified Camp/Follower List Description:
			if (amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 2 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) {
				outputText("Sometimes you hear a faint moan from not too far away. No doubt the result of your slutty toy mouse playing with herself.\n\n");
				buttons.add("Amily", amilyScene.amilyFollowerEncounter);
			}
			//JOJO
			//If Jojo is corrupted, add him to the masturbate menu.
			if (campCorruptJojo() && flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 0) {
				outputText("From time to time you can hear movement from around your [camp], and you routinely find thick puddles of mouse semen.  You are sure Jojo is here if you ever need to sate yourself.\n\n");
				buttons.add("Jojo", jojoScene.corruptCampJojo).hint("Call your corrupted pet into [camp] in order to relieve your desires in a variety of sexual positions?  He's ever so willing after your last encounter with him.");
			}
			//Bimbo Sophie
			if (bimboSophie() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0 && !player.hasStatusEffect(StatusEffects.SophieOff)) {
				sophieBimbo.sophieCampLines();
				buttons.add("Sophie", sophieBimbo.approachBimboSophieInCamp);
			}
			//Ghoulish Vampire servant
			if (player.hasStatusEffect(StatusEffects.Familiar) && player.statusEffectv3(StatusEffects.Familiar) > 0 && player.statusEffectv3(StatusEffects.Familiar) < 4 && player.hasPerk(PerkLib.Familiar)) {
				//outputText(".\n\n");
				buttons.add(""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"", SceneLib.ghoulishVampireServant.ghoulishVampireServantMain).hint("Visit your ghoulish vampire servant.");
			}
		}
		for each(var npc:XXCNPC in _campFollowers) {
			npc.campDescription(buttons, XXCNPC.SLAVE);
		}
		if (!descOnly) {
			submenu(buttons, playerMenu);
		}
	}

	public function campFollowers(descOnly:Boolean = false):void {
		var buttons:ButtonDataList = new ButtonDataList();
		if (!descOnly) {
			hideMenus();
			spriteSelect(null);
			clearOutput();
			CoC.instance.inCombat = false;
			//ADD MENU FLAGS/INDIVIDUAL FOLLOWER TEXTS
			menu();
		}
		if (!(model.time.hours <= 5 || model.time.hours >= 23)) {
			//Aether Twins
			if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] > 0 || flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] > 0) {
				buttons.add("Aether Twins", SceneLib.aethertwins.aethertwinsFollowers).hint("Visit Aether twins the sentient weapons. You can even take and wear them as weapon and shield if you like.");
			}
			//Aurora
			if (flags[kFLAGS.AURORA_LVL] >= 1) {
				buttons.add("Aurora", SceneLib.auroraFollower.auroraCampMenu).hint("Check up on Aurora.").disableIf(player.statusEffectv2(StatusEffects.CampSparingNpcsTimers4) > 0, "Training.");
			}
			//Alvina
			if (flags[kFLAGS.ALVINA_FOLLOWER] > 12 && flags[kFLAGS.ALVINA_FOLLOWER] < 20 && !SceneLib.alvinaFollower.AlvinaPurified) {
				outputText("Alvina isn’t so far from here, having made her [camp] in a corrupted plant groove she created so to have easy access to reagents.\n\n");
				buttons.add("Alvina", SceneLib.alvinaFollower.alvinaMainCampMenu).hint("Check up on Alvina.");
			}
			//Siegweird
			if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 3) {
				outputText("Siegweird is in your [camp], his armor set to the side while he reads a book.\n\n");
				buttons.add("Siegweird", SceneLib.siegweirdFollower.siegweirdMainCampMenu).hint("Check up on Siegweird.");
			}
			//Ember
			if (emberScene.followerEmber()) {
				emberScene.emberCampDesc();
				if (player.statusEffectv2(StatusEffects.CampLunaMishaps2) > 0) buttons.add("Ember", emberScene.emberCampMenu2).hint("Check up on Ember the dragon-" + (flags[kFLAGS.EMBER_ROUNDFACE] == 0 ? "morph" : flags[kFLAGS.EMBER_GENDER] == 1 ? "boy" : "girl") + "").disableIf(player.statusEffectv2(StatusEffects.CampLunaMishaps2) > 0, "Busy searching.");
				else buttons.add("Ember", emberScene.emberCampMenu2).hint("Check up on Ember the dragon-" + (flags[kFLAGS.EMBER_ROUNDFACE] == 0 ? "morph" : flags[kFLAGS.EMBER_GENDER] == 1 ? "boy" : "girl") + "").disableIf(player.statusEffectv1(StatusEffects.CampSparingNpcsTimers1) > 0, "Training.");
			}
			//Sophie
			if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0 && !player.hasStatusEffect(StatusEffects.SophieOff)) {
				if (rand(5) == 0) outputText("Sophie is sitting by herself, applying yet another layer of glittering lip gloss to her full lips.\n\n");
				else if (rand(4) == 0) outputText("Sophie is sitting in her nest, idly brushing out her feathers.  Occasionally, she looks up from her work to give you a sultry wink and a come-hither gaze.\n\n");
				else if (rand(3) == 0) outputText("Sophie is fussing around in her nest, straightening bits of straw and grass, trying to make it more comfortable.  After a few minutes, she flops down in the middle and reclines, apparently satisfied for the moment.\n\n");
				else if (rand(2) == 0 || flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] == 0) {
					if (flags[kFLAGS.SOPHIE_BIMBO_ACCEPTED] > 0) outputText("Your platinum-blonde harpy, Sophie, is currently reading a book - a marked change from her bimbo-era behavior.  Occasionally, though, she glances up from the page and gives you a lusty look.  Some things never change....\n\n");
					else outputText("Your pink harpy, Sophie, is currently reading a book.  She seems utterly absorbed in it, though you question how she obtained it.  Occasionally, though, she'll glance up from the pages to shoot you a lusty look.\n\n");
				} else {
					outputText("Sophie is sitting in her nest, ");
					if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] < 5) {
						outputText("across from your daughter");
						if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] > 1) outputText("s");
					} else outputText("surrounded by your daughters");
					outputText(", apparently trying to teach ");
					if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] == 1) outputText("her");
					else outputText("them");
					outputText(" about hunting and gathering techniques.  Considering their unusual upbringing, it can't be as easy for them...\n\n");
				}
				buttons.add("Sophie", sophieFollowerScene.followerSophieMainScreen).hint("Check up on Sophie the harpy.");
			}
			//Pure Jojo
			if (player.hasStatusEffect(StatusEffects.PureCampJojo)) {
				if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3) {
					outputText("Joy's tent is set up in a quiet corner of the [camp], close to a boulder. Inside the tent, you can see a chest holding her belongings, as well as a few clothes and books spread about her bedroll. ");
					if (flags[kFLAGS.JOJO_LITTERS] > 0 && model.time.hours >= 16 && model.time.hours < 19) outputText("You spot the little mice you had with Joy playing about close to her tent.");
					else outputText("Joy herself is nowhere to be found, she's probably out frolicking about or sitting atop the boulder.");
					outputText("\n\n");
					buttons.add("Joy", joyScene.approachCampJoy).hint("Go find Joy around the edges of your [camp] and meditate with her or have sex with her.");
				} else if (SceneLib.alvinaFollower.JojoDevilPurification == 1 && !player.hasStatusEffect(StatusEffects.DevilPurificationScar)) {
					outputText("Jojo is waiting in the forrest, bring him a pure artifact and he will cleanse you of your taint.");
				} else {
					outputText("There is a small bedroll for Jojo near your own");
					if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) outputText(" cabin");
					if (!(model.time.hours > 4 && model.time.hours < 23)) outputText(" and the mouse is sleeping on it right now.\n\n");
					else outputText(", though the mouse is probably hanging around the [camp]'s perimeter.\n\n");
					buttons.add("Jojo", jojoScene.jojoCamp2).hint("Go find Jojo around the edges of your [camp] and meditate with him or talk about watch duty.").disableIf(player.statusEffectv2(StatusEffects.CampLunaMishaps1) > 0, "Annoyed.");//wpisać blokowanie mishapów jak opcja wyłączenia jej jest aktywna
				}
			}
			//Celess
			//Evangeline
			if (EvangelineFollower.EvangelineFollowerStage >= 1 && flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] <= 0) {
				outputText("There is a small bedroll for Evangeline near the [camp] edge");
				if (!(model.time.hours > 4 && model.time.hours < 23)) outputText(" and she's sleeping on it right now.");
				else outputText(". Though, she probably wandered off not far from [camp], looking for more ingredients to make her potions.");
				outputText(" Next to it lies a small chest with her personal stuff.\n\n");
				buttons.add("Evangeline", SceneLib.evangelineFollower.meetEvangeline).hint("Visit Evangeline.");
			}
			else if (EvangelineFollower.EvangelineFollowerStage >= 1 && flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] >= 1) {
				/*if (flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] >= 1)*/
				outputText("Evangeline isn't in the [camp] as she went to buy some items. She should be out no longer than a few hours.\n\n");
				//if () outputText("Evangeline is busy training now. She should be done with it in a few hours.\n\n");
			}
			//Grayda
			if (flags[kFLAGS.THE_TRENCH_ENTERED] > 14) {
				outputText("You can see Grayda patrolling the edges of the camp, keeping an eye out for any potential threats.");
				buttons.add("Grayda", SceneLib.graydaScene.graydaMainWhenCalled).hint("Visit Grayda.").disableIf(player.statusEffectv2(StatusEffects.CampLunaMishaps3) > 0, "Grayda is still curled up underneath the water at the stream.");
			}
			//Kindra
			if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) {
				outputText("You can see a set of finely crafted traps around your [camp]. Kindra must be hunting nearby.\n\n");
				buttons.add("Kindra", SceneLib.kindraFollower.meet2Kindra).hint("Visit Kindra the sheep-morph.").disableIf(player.statusEffectv1(StatusEffects.CampSparingNpcsTimers2) > 0, "Training.");
			}
			//Dinah
			if (flags[kFLAGS.DINAH_LVL_UP] >= 1) {
				outputText("You can see a cart with various vials standing next to a bedroll. Dinah must be somewhere nearby.\n\n");
				buttons.add("Dinah", SceneLib.dinahScene.DinahIntro2).hint("Visit Dinah the cat chimera merchant.").disableIf(player.statusEffectv3(StatusEffects.CampSparingNpcsTimers3) > 0, "Training.");
			}
			//Neisa
			if (flags[kFLAGS.NEISA_FOLLOWER] >= 7) {
				outputText("Neisa is hanging by a tree next to the [camp] practicing her swordplay on a makeshift dummy for the next expedition.\n\n");
				buttons.add("Neisa", SceneLib.neisaFollower.neisaCampMenu).hint("Visit Neisa the shield maiden.");
			}
			//Zenji follower
			if ((flags[kFLAGS.ZENJI_PROGRESS] == 8 || flags[kFLAGS.ZENJI_PROGRESS] == 9) && TrollVillage.ZenjiVillageStage != 2) {
				if (model.time.hours >= 7 && model.time.hours <= 18) {
					if (rand(3) == 0) outputText("Zenji is around your [camp], you see him currently relaxing atop a tree.");
					else {
						if (rand(2) == 0) outputText("Zenji is around your [camp], you see him doing a routine of stretches.");
						else outputText("Zenji is around your [camp], you see him doing some push-ups.");
					}
				}
				else {
					if (rand(3) == 0) outputText("Zenji is around your [camp], you see him resting on his bedroll.");
					else {
						if (rand(2) == 0) outputText("Zenji is around your [camp], he is coating his fur in some ashes as he grooms himself.");
						else outputText("Zenji is around your [camp], it looks like he’s polishing his tusks and brushing his teeth with something.");
					}
				}
				outputText("\n\n");
				buttons.add("Zenji", SceneLib.zenjiScene.followerZenjiMainCampMenu).hint("Visit Zenji the troll.");
			}
			//Helspawn
			if (helspawnFollower()) {
				buttons.add(flags[kFLAGS.HELSPAWN_NAME], helSpawnScene.helspawnsMainMenu);
			}
			//Etna daughter
			if (followerEtnaKid()) {
				etnaKidFollower.etnaDaughterCampDescription();
				buttons.add(EtnaDaughterScene.EtnaDaughterName, etnaKidFollower.etnaDaughterMainMenu);
			}
			//Midoka, Chi-Chi's daughter
			if (followerMidoka()) {
				midokaScene.midokaCampDescription();
				buttons.add(SceneLib.midokaScene.MidokaName, midokaScene.midokaMainMenu);
			}
			//Valaria
			if (flags[kFLAGS.VALERIA_AT_CAMP] == 1 && flags[kFLAGS.TOOK_GOO_ARMOR] == 1) {
				buttons.add("Valeria", valeria.valeriaFollower).hint("Visit Valeria the goo-girl. You can even take and wear her as goo armor if you like.");
			}
			//RATHAZUL
			//if rathazul has joined the camp
			if (player.hasStatusEffect(StatusEffects.CampRathazul)) {
				if (flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] <= 1) {
					outputText("Tucked into a shaded corner of the rocks is a bevy of alchemical devices and equipment.  ");
					if (!(model.time.hours > 4 && model.time.hours < 23)) outputText("The alchemist is absent from his usual work location. He must be sleeping right now.");
					else outputText("The alchemist Rathazul looks to be hard at work with his chemicals, working on who knows what.");
					if (flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] == 1) {
						if (flags[kFLAGS.RATHAZUL_ARMOR_TYPE] < 10) outputText("  Some kind of spider-silk-based equipment is hanging from a nearby rack.");
						outputText("  <b>He's finished with the task you gave him!</b>");
					}
					outputText("\n\n");
				} else outputText("Tucked into a shaded corner of the rocks is a bevy of alchemical devices and equipment.  The alchemist Rathazul looks to be hard at work on the silken equipment you've commissioned him to craft.\n\n");
				if (flags[kFLAGS.MITZI_RECRUITED] == 2) outputText("Mitzi is laying on a cot in Rathazul's lab. A deep blush is present her face and she pants heavily, constantly fading in and out of consciousness.\n\n");
				buttons.add("Rathazul", SceneLib.rathazul.returnToRathazulMenu).hint("Visit with Rathazul to see what alchemical supplies and services he has available at the moment.");
			}
			else {
				if (flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] == 1) {
					outputText("There is a note on your ");
					if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) outputText("bed inside your cabin.");
					else outputText("bedroll");
					outputText(". It reads: \"<i>Come see me at the lake. I've finished your ");
					switch (flags[kFLAGS.RATHAZUL_ARMOR_TYPE]) {
						case 1:
							outputText("spider-silk armor");
							break;
						case 2:
							outputText("spider-silk robes");
							break;
						case 3:
							outputText("spider-silk bra");
							break;
						case 4:
							outputText("spider-silk panties");
							break;
						case 5:
							outputText("spider-silk loincloth");
							break;
						case 11:
							outputText("staff");
							break;
						case 12:
							outputText("staff");
							break;
						case 13:
							outputText("staff");
							break;
						default:
							outputText("robes");
					}
					outputText(". -Rathazul</i>\".\n\n");
				}
			}
			//Excellia Follower
			if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 3 && flags[kFLAGS.EXCELLIA_RECRUITED] < 33) {
				outputText("Excellia sits just outside her tent looking a bit lost and confused. When she sees you, she immediately perks up, swishing her tail back and forth in the hopes that you come over to her.\n\n");
				buttons.add("Excellia", SceneLib.excelliaFollower.ExcelliaCampMainMenuFixHer).hint("Visit Excellia.");
			}
			//Mitzi + brood
			if (flags[kFLAGS.MITZI_RECRUITED] >= 4) {
				outputText("Mitzi is laying back on a blanket in the shade. When she notices you, she gives you a sultry look then pushes out her chest a bit to entice you.\n\n");
				buttons.add("Mitzi", SceneLib.mitziFollower.MitziCampMainMenu).hint("Visit Mitzi.");
			}
			if (flags[kFLAGS.MITZI_DAUGHTERS] >= 4) {
				outputText("At the West of [camp] sits a cluster of small, surprisingly sturdy looking huts built by Mitzi's daughters. You can see some of them building some strange gadgets while others work in front of a large melding pot over a fire, more than likely experimenting with some new types of potions.\n\n");
				buttons.add("Mitzi D.", SceneLib.mitziFollower.MitziDaughtersCampMainMenu).hint("Visit Mitzi daughters.");
			}
			//Konstantin
			if (flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2 && !player.hasStatusEffect(StatusEffects.KonstantinOff)) {
				if (model.time.hours >= 6 && model.time.hours <= 8) outputText("Konstantin has dragged out of his [camp] a mat, and is doing some flexing postures under the early morning light. He’s not particularly good at it, so most of times he ends up in awkward positions.");
				else if (model.time.hours <= 12) outputText("You ursine smith is currently at work, sharpening and polishing blades.");
				else if (model.time.hours <= 15) outputText("Konstantin has stopped his work to have a meal, and quite an abundant one. From where you are, you can smell the cooked meat and spice from his plate.");
				else if (model.time.hours <= 18) outputText("The sound of metal on metal is heard, and you easily find the source. The bear smith is currently shaping some plates, polishing them each now and then and putting them aside once he satisfied with how they look.");
				else if (model.time.hours <= 20) outputText("Your local smith, Konstantin isn’t working right now. He has gone to his tent to rest and relax for awhile.");
				else {
					outputText("Konstantin is lying on a patch of grass, peacefully looking at the ");
					outputText("red sky.");
					if (flags[kFLAGS.LETHICE_DEFEATED] > 0) outputText("the starry night above you.");
				}
				outputText("\n\n");
				buttons.add("Konstantin", SceneLib.konstantin.KonstantinMainCampMenu);
			}
			//Ayane
			if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) {
				outputText("Ayane is tidying your items to make sure everything is clean and well organised.\n\n");
				buttons.add("Ayane", SceneLib.ayaneFollower.ayaneCampMenu).hint("Visit Ayane a kitsune priestess of Taoth.");
			}
			if (SceneLib.ayaneFollower.ayaneChildren() == 1){
				outputText("You can see Ayane's child is playing around in the grass.\n\n");
			}
			if (SceneLib.ayaneFollower.ayaneChildren() >= 2){
				outputText("You can see Ayane's children are playing around in the grass.\n\n");
			}
			//Pure/Corrupted Holli
			if (flags[kFLAGS.FUCK_FLOWER_LEVEL] == 4) {
				buttons.add("Holli", holliScene.treeMenu).hint("Holli is in her tree at the edges of your [camp].  You could go visit her if you want.");
			}
			if (flags[kFLAGS.FLOWER_LEVEL] == 4) {
				buttons.add("Holli", HolliPure.treeMenu).hint("Holli is in her tree at the edges of your [camp].  You could go visit her if you want.");
			}
			//Michiko
			if (flags[kFLAGS.MICHIKO_FOLLOWER] >= 1) {
				outputText("Michiko is sitting on a tree stump, busy writing her latest notes about your adventures.\n\n");
				buttons.add("Michiko", SceneLib.michikoFollower.campMichikoMainMenu).hint("Check up on Michiko.");
			}
			//Sidonie
			if (flags[kFLAGS.SIDONIE_FOLLOWER] == 1) {
				if (model.time.hours >= 6 && model.time.hours <= 8) outputText("Sidonie has taken a table out to have breakfast outside. From what you can see, she’s eating from a bowl filled with oats, milk and strawberries.");
				else if (model.time.hours <= 9) outputText("On a far part of the [camp], you can distinguish Sidonie’s figure. Seems like she’s using the early morning to cut some long planks into smaller ones, as the unmistakable sound of saw on wood makes evident.");
				else if (model.time.hours <= 10) outputText("The equine carpenter is looking at a book containing some furniture designs. She’s probably looking for ideas for her next piece.");
				else if (model.time.hours <= 12) outputText("Near her tent, your equine friend is busy at work, currently sanding some pieces.");
				else if (model.time.hours <= 13) outputText("Sidonie probably went to take her meal, given the hour. The recognizable smell of home-made food coming from her tent confirms quickly your suspicions.");
				else if (model.time.hours <= 15) outputText("Some furniture pieces lie scattered near the equine carpenter’s workspace, who is varnishing them. A few finished ones are a bit away.");
				else if (model.time.hours <= 16) outputText("Looks like Sidonie went to some place to sell her furniture. Se may return in an hour or so.");
				else if (model.time.hours <= 18) outputText("Your equine friend is currently relaxing inside her tent, if you’d like to come in and spend some time with her.");
				else if (model.time.hours <= 20) outputText("Oddly enough, Sidonie is picking some sandalwood sawdust and putting it on boiling water. Not matter the reason, the smell of the resulting liquid is certainly wonderful.");
				else outputText("The horse-girl is having her dinner, as you manage to spot from outside. Seems like she’s having a hot drink with some bread.");
				outputText("\n\n");
				buttons.add("Sidonie", SceneLib.sidonieFollower.mainSidonieMenu).hint("Visit Sidonie.");
			}
			//PC Goblin daughters
			if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 0) buttons.add("Goblin kids", campScenes.PCGoblinDaughters).hint("Check up on your goblin daughters.");
			//Tifa
			if (flags[kFLAGS.TIFA_FOLLOWER] > 5) buttons.add("Tifa", SceneLib.tifaFollower.tifaMainMenu).hint("Check up on Tifa.");
		}
		//Shouldra
		if (followerShouldra() && !player.hasStatusEffect(StatusEffects.ShouldraOff)) {
			buttons.add("Shouldra", shouldraFollower.shouldraFollowerScreen).hint("Talk to Shouldra. She is currently residing in your body.");
		}
		//Luna
		if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) {
			if (!isNightTime)
			{
				outputText("Luna wanders around the [camp], doing her chores as usual.");
			}
			else if (isNightTime && flags[kFLAGS.LUNA_MOON_CYCLE] == 8 && flags[kFLAGS.LUNA_FOLLOWER] >= 7) {
				outputText("Luna is taking a break siting on a nearby rock to watch over the full moon. She's clearly heating up with the desire to mate with you but out of respect for her you is letting you do the first move.");
			}
			else {
				outputText("Luna is taking a break siting on a nearby rock to watch over the moon.");
			}
			if (flags[kFLAGS.LUNA_JEALOUSY] >= 100) outputText(" She looks at you from time to time, as if expecting you to notice her.");
			outputText("\n\n");
			buttons.add("Luna", SceneLib.lunaFollower.mainLunaMenu).hint("Visit Luna.").disableIf(player.statusEffectv1(StatusEffects.CampSparingNpcsTimers3) > 0, "Training.");
		}
		for each(var npc:XXCNPC in _campFollowers) {
			npc.campDescription(buttons, XXCNPC.FOLLOWER);
		}
		if (!descOnly) {
			submenu(buttons, playerMenu);
		}
	}

//-----------------
//-- CAMP ACTIONS
//-----------------
	public function campActions():void {
		hideMenus();
		menu();
		// [Build   ] [Winions] [Misc     ] [SpendTime] [NPC's     ]
		// [Crafting] [Garden ] [Herbalism] [         ] [Quest Loot]
		// [Questlog] [Recall ] [Dummy    ] [Ascension] [Back      ]
		clearOutput();
		outputText("What would you like to do?");
		addButton(0, "Build", campBuildingSim).hint("Check your [camp] build options.").disableIf(isNightTime,"It's too dark for that!");
		addButton(1, "Winions", campWinionsArmySim).hint("Check your options for making some Winions.").disableIf((!player.hasPerk(PerkLib.JobElementalConjurer) && !player.hasPerk(PerkLib.JobGolemancer) && !player.hasPerk(PerkLib.PrestigeJobNecromancer)), "You need to be able to make some minions that fight for you to use this option.");
		addButton(2, "Misc", campMiscActions).hint("Misc options to do things in and around [camp].");
		addButton(3, "Spend Time", campSpendTimeActions).hint("Check your options to spend time in and around [camp].");
		addButton(4, "NPC's", SparrableNPCsMenu);
		addButton(5, "Crafting", SceneLib.crafting.craftingMain).hint("Craft some items.");
		//addButtonDisabled(6, "Garden", "Local Committee of Alraunes took over this place for re-nationalization.");
		if (SceneLib.garden.canAccessGarden()) addButton(6, "Garden", SceneLib.garden.accessGarden).hint("Manage your garden of medicinal plants.");
		else addButtonDisabled(6, "Garden", "Req. to have Herb bag of any sort.");
		addButton(7, "Herbalism", SceneLib.garden.herbalismMenu).hint("Use ingrediants to craft poultrice and battle medicines.").disableIf(isNightTime,"It's too dark to do any gardening!").disableIf(!player.hasStatusEffect(StatusEffects.CampRathazul),"Would you kindly find Rathazul first?");
		addButton(9, "Quest Loot", SceneLib.adventureGuild.questItemsBag).hint("Manage your bag with quest items.").disableIf(!AdventurerGuild.playerInGuild, "Join the Adventure Guild for a quest bag!");
		addButton(10, "Questlog", questlog.accessQuestlogMainMenu).hint("Check your questlog.");
		addButton(11, "Recall", sceneHunter.recallScenes).hint("Recall some of the unique events happened during your adventure.");
		if (SceneLib.exploration.counters.explore >= 1) addButton(12, "Dummy", dummyTraining).hint("Train your mastery level on this dummy.").disableIf(isNightTime,"It's too dark for that!");
		addButton(13, "Ascension", promptAscend).hint("Perform an ascension? This will restart your adventures. The game depending on your choice would also get harder. If you have Sky Poison Pearl could carry over some items to new adventure.").disableIf(flags[kFLAGS.LETHICE_DEFEATED] <= 0, "Don't you have a job to finish first? Like... to defeat someone, maybe Lethice?");
		addButton(14, "Back", playerMenu);
	}

	private function campSpendTimeActions():void {
		menu();
		addButton(0, "SwimInStream", swimInStream).hint("Swim in stream and relax to pass time.", "Swim In Stream");
		addButton(1, "ExaminePortal", examinePortal).hint("Examine the portal. This scene is placeholder.", "Examine Portal"); //Examine portal.
		if (model.time.hours == 19) {
			addButton(2, "Watch Sunset", watchSunset).hint("Watch the sunset and relax."); //Relax and watch at the sunset.
		} else if ((model.time.hours >= 20 || model.time.hours <= 5) && flags[kFLAGS.LETHICE_DEFEATED] > 0) {
			addButton(2, "Stargaze", watchStars).hint("Look at the starry night sky."); //Stargaze. Only available after Lethice is defeated.
		} else {
			if (flags[kFLAGS.LETHICE_DEFEATED] == 0) addButtonDisabled(2, "Watch Sky", "The option to watch sunset is available at 7pm.");
			else addButtonDisabled(2, "Watch Sky", "The option to watch sunset is available at 7pm, \n\nStargazing 8pm-5am.");
		}
		addButton(3, "Read Codex", codex.accessCodexMenu).hint("Read any codex entries you have unlocked.");
		if (player.hasKeyItem("Gryphon Statuette") >= 0) addButton(9, "Gryphon", useGryphonStatuette);
		if (player.hasKeyItem("Peacock Statuette") >= 0) addButton(9, "Peacock", usePeacockStatuette);
		if (player.hasKeyItem("Gryphon Statuette") == 0 && player.hasKeyItem("Peacock Statuette") == 0) addButtonDisabled(9, "???", "Perhaps if you had a magical statuette...");
		addButton(14, "Back", campActions);
	}

	public function campBuildingSim():void {
		menu();
		if (player.hasKeyItem("Carpenter's Toolbox") >= 0) {
			if (flags[kFLAGS.CAMP_WALL_PROGRESS] < 100) {
				if (getCampPopulation() >= 4) addButton(0, "Build Wall", buildCampWallPrompt).hint("Build a wall around your [camp] to defend from the imps." + (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 10 ? "\n\nProgress: " + (flags[kFLAGS.CAMP_WALL_PROGRESS] / 10) + "/10 complete" : "") + "");
				else addButtonDisabled(0, "Build Wall", "Req. 4+ camp population.");
				addButtonDisabled(1, "Build Gate", "Req. to build wall fully first.");
			}
			if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100) {
				addButtonDisabled(0, "Build Wall", "Already built.");
				if (flags[kFLAGS.CAMP_WALL_GATE] > 0) addButtonDisabled(1, "Build Gate", "Already built.");
				else addButton(1, "Build Gate", buildCampGatePrompt).hint("Build a gate to complete your [camp] defense.");
			}
			//addButton(3, "Build Cabin(O)", campUpgrades.buildCampMembersCabinsMenu).hint("Work on your camp members cabins.");
			addButton(5, "Build Misc", campUpgrades.buildmisc1Menu).hint("Build other structures than walls or cabins for your [camp].");
			//addButton(6, "Build Misc(O)", campUpgrades.).hint("Other structures than walls or cabins for your camp.");
		}
		else {
			addButtonDisabled(0, "Build Wall", "Req. Carpenter's Toolbox.");
			//addButtonDisabled(2, "Build Cabin(O)", "Req. Carpenter's Toolbox.");
			addButtonDisabled(5, "Build Misc", "Req. Carpenter's Toolbox.");
			//addButtonDisabled(6, "Build Misc(O)", "Req. Carpenter's Toolbox.");
		}
		if (flags[kFLAGS.CAMP_CABIN_PROGRESS] > 0 && flags[kFLAGS.CAMP_CABIN_PROGRESS] < 10) addButton(2, "Build Cabin", cabinProgress.initiateCabin).hint("Work on your cabin."); //Work on cabin.
		else if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 0) addButtonDisabled(2, "Build Cabin", "You need to wait until 7th day.");
		else addButtonDisabled(2, "Build Cabin", "Looking at your cabin, it's evidently already built.");
		if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 10) {
			if (player.hasItem(useables.IMPSKLL, 1)) {
				addButton(10, "AddImpSkull", promptHangImpSkull).hint("Add an imp skull to decorate the wall and to serve as deterrent for imps.", "Add Imp Skull");
			} //How was this never caught???
			else{
				addButtonDisabled(10, "AddImpSkull", "Req. at least one imp skull.");
			}
		}
		else addButtonDisabled(10, "AddImpSkull", "Req. built at least one wall section.");
		addButton(14, "Back", campActions);
	}

	private function campMiscActions():void {
		clearOutput();
		outputText("What would you like to do?");
		menu();
		if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 1) addButton(0, "Fishery", VisitFishery).hint("Visit Fishery.");
		else addButtonDisabled(0, "Fishery", "Would you kindly build it first?");
		if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] >= 2) addButton(1, "Ward", MagicWardMenu).hint("Activate or Deactivate Magic Ward around [camp].");
		else addButtonDisabled(1, "Ward", "Would you kindly install it first?");
		if (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] >= 4) addButton(2, "Kitsune Shrine", campScenes.KitsuneShrine).hint("Meditate at [camp] Kitsune Shrine.");
		else addButtonDisabled(2, "Kitsune Shrine", "Would you kindly build it first?");
		if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] >= 4) addButton(3, "Hot Spring", campScenes.HotSpring).hint("Visit Hot Spring.").disableIf(isNightTime,"It's not safe to take a dip in the hotsprings at night.");
		else addButtonDisabled(3, "Hot Spring", "Would you kindly build it first?");
		if (player.hasPerk(PerkLib.CursedTag)) addButton(4, "AlterBindScroll", AlterBindScroll).hint("Alter Bind Scroll - DIY aka modify your cursed tag").disableIf(isNightTime, "It's too dark to modify your scroll.");
		else addButtonDisabled(4, "Alter Bind Scroll", "Req. to be Jiangshi and having Cursed Tag perk.");
		var bottles:Array = [
			[consumables.LG_SFRP, consumables.LGSFRPB, "low"],
			[consumables.MG_SFRP, consumables.MGSFRPB, "mid"],
			[consumables.HG_SFRP, consumables.HGSFRPB, "high"],
			[consumables.SG_SFRP, consumables.SGSFRPB, "superior"],
		];
		for (var i:int = 0; i < bottles.length; ++i) {
			addButton(5 + i, "FillBottle(" + bottles[i][2].charAt(0).toUpperCase() + ")", fillUpPillBottle.apply, this, bottles[i])
				.hint("Fill up one of your pill bottles with "+bottles[i][2]+"-grade soulforce recovery pills.")
				.disableIf(!player.hasItem(bottles[i][0], 10) || !player.hasItem(useables.E_P_BOT, 1),
					"You need one empty pill bottle and ten "+bottles[i][2]+"-grade soulforce recovery pills.");
		}
		if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) addButton(10, "Clone", CloneMenu).hint("Check on your clone(s).");
		else addButtonDisabled(10, "Clone", "Would you kindly go face F class Heaven Tribulation first?");
		addButtonIfTrue(11, "Pocket Watch", mainPagePocketWatch, "Req. having Pocket Watch key item.", player.hasKeyItem("Pocket Watch") >= 0);
		if (player.hasItem(useables.ENECORE, 1) && CampStatsAndResources.EnergyCoreResc < 200) addButton(12, "E.Core", convertingEnergyCoreIntoFlagValue).hint("Convert Energy Core item into flag value.");
		if (player.hasItem(useables.MECHANI, 1) && CampStatsAndResources.MechanismResc < 200) addButton(12, "C.Mechan", convertingMechanismIntoFlagValue).hint("Convert Mechanism item into flag value.");
		addButton(13, "C & S", menuForCombiningAndSeperating).hint("Combining & Seperating");
		addButton(14, "Back", campActions);
	}
	private function convertingEnergyCoreIntoFlagValue():void {
		clearOutput();
		outputText("1 Energy Core converted succesfully.");
		player.destroyItems(useables.ENECORE, 1);
		CampStatsAndResources.EnergyCoreResc += 1;
		doNext(campMiscActions);
	}
	private function convertingMechanismIntoFlagValue():void {
		clearOutput();
		outputText("1 Mechanism converted succesfully.");
		player.destroyItems(useables.MECHANI, 1);
		CampStatsAndResources.MechanismResc += 1;
		doNext(campMiscActions);
	}

	public function menuForCombiningAndSeperating():void {
		clearOutput();
		outputText("You can combine two single weapons into one dual weapon or separate dual weapons into two single weapons. <b>(WARNING: ENCHANTED ITEMS WOULD IRREVERSABLE LOOSE ENCHANTMENTS DURING COMBINING!!!)</b>");
		menu();
		var weaponList: Array = [
			[weapons.KAMA, weapons.D_KAMA],
			[weapons.DAGGER, weapons.DDAGGER],
			[weapons.ANGSTD1, weapons.ANGSTD],
			[weapons.DAGWHIP, weapons.DDAGWHIP],
			[weapons.BFSWORD, weapons.DBFSWO],
			[weapons.BFTHSWORD, weapons.DBFTHSWO],
			[weapons.BFWHIP, weapons.DBFWHIP],
			[weapons.NODACHI, weapons.DNODACHI],
			[weapons.WHIP, weapons.PWHIP],
			[weapons.WARHAMR, weapons.D_WHAM_],
			[weapons.SUCWHIP, weapons.PSWHIP],
			[weapons.KATANA, weapons.DKATANA],//1st page
			[weapons.L__AXE, weapons.DL_AXE_],
			[weapons.MACGRSW, weapons.TMACGRSW],
			[weapons.RIPPER1, weapons.TRIPPER1],
			[weapons.RIPPER2, weapons.TRIPPER2],
			[weapons.ACLAYMO, weapons.TACLAYM],
			[weapons.RCLAYMO, weapons.TRCLAYM],
			[weapons.SCLAYMO, weapons.TSCLAYM],
			[weapons.TCLAYMO, weapons.TTCLAYM],
			[weapons.S_RULER, weapons.TSRULER],
			[weapons.PHALLUS, weapons.PHALUSS],
			[weapons.L_WHIP, weapons.DL_WHIP],
			[weapons.B_SWORD, weapons.DBSWORD],//2nd page
			[weapons.EXCALIB, weapons.DEXCALI],
			[weaponsrange.SIXSHOT, weaponsrange.TWINSIXS],
			[weaponsrange.M1CERBE, weaponsrange.TM1CERB],
			[weaponsrange.ALAKABL, weaponsrange.DALAKABL],
			[weaponsrange.DESEAGL, weaponsrange.TDEEAGL]
			//[weaponsrange.HARKON1, weaponsrange.HARKON2],
		];
		addButton(0, "Combine Weapons", menuCombineStaging, weaponList);
		addButton(4, "Seperate Weapons", menuSeperateStaging, weaponList)
		addButton(14, "Back", campMiscActions);
	}

	public function menuCombineStaging(weaponList:Array):void{
		menu();
		var bd:ButtonDataList = new ButtonDataList();
		for each(var weapongroup:Array in weaponList){
			bd.add(weapongroup[0].name,curry(menuCombining, weapongroup[0], weapongroup[1])).disableIf(player.itemCount(weapongroup[0]) < 2, "You need more than one " + weapongroup[0].name + "to make a " + weapongroup[1].name + "!").hint("Combine 2 "+ weapongroup[0].name + " into a " + weapongroup[1].name)
		}
		submenu(bd, menuForCombiningAndSeperating,0,false);
	}

	public function menuSeperateStaging(weaponList:Array):void{
		menu();
		var bd:ButtonDataList = new ButtonDataList();
		for each(var weapongroup:Array in weaponList){
			bd.add(weapongroup[1].name,curry(menuSeparating, weapongroup[1], weapongroup[0])).disableIf(player.itemCount(weapongroup[1]) == 0, "You need at least one " + weapongroup[1].name + "to break back down to two " + weapongroup[0].name + "!").hint("Disassemble "+ weapongroup[1].name + " to get 2 " + weapongroup[0].name)
		}
		submenu(bd, menuForCombiningAndSeperating,0,false);
	}

	public function menuCombining(weapon1: *, weapon2: *):void {
		clearOutput();
		outputText("Combining.\n\n");
		player.destroyItems(weapon1, 2);
		inventory.takeItem(weapon2, menuForCombiningAndSeperating);
	}
	public function menuSeparating(weapon1: *, weapon2: *):void {
		clearOutput();
		outputText("Separating.\n\n");
		player.destroyItems(weapon1, 1);
		inventory.takeItem(weapon2, curry(menuSeparating1a, weapon2));
	}
	public function menuSeparating1a(weapon2: *):void {
		outputText("\n\n");
		inventory.takeItem(weapon2, menuForCombiningAndSeperating);
	}

	public function mainPagePocketWatch(page:int = 1):void {
		clearOutput();
		outputText("Which perks would you like to combine using the watch?");
		menu();
		if (page == 1) {
			addButton(0, "DoTE", mainPagePocketWatch, 2).hint("View Merged Perks related to Elemental Contract perk line", "Dao Of The Elements");
			addButton(1, "EC: M&B", mainPagePocketWatch, 3).hint("View Merged Perks related to Elemental Conjurer: Mind and Body perk line", "Elemental Conjurer: Mind and Body");
			addButton(2, "Chimera", mainPagePocketWatch, 4).hint("View Merged Perks related to Chimerical Body perk line", "Chimerical Body");
			addButton(3, "Mage", mainPagePocketWatch, 5).hint("View Merged Perks related to the Mage perk line", "Mage");
			addButton(4, "Diehard", mainPagePocketWatch, 6).hint("View Merged Perks related to the Diehard perk line", "Diehard");
		}

		if (page == 2) {
			if (player.hasPerk(PerkLib.DaoOfTheElements)) addButtonDisabled(0, "DotE (layer 1)", "You already have this merged perk.");
			else addButtonIfTrue(0, "DotE (layer 1)", mainPagePocketWatchDaoOfTheElementsPerkLayer1, "Req. Elemental Contract Rank 5 & Elements of the orthodox Path perks", player.hasPerk(PerkLib.ElementalContractRank5) && player.hasPerk(PerkLib.ElementsOfTheOrtodoxPath));
			
			if (player.hasPerk(PerkLib.DaoOfTheElements)) {
				if (player.hasPerk(PerkLib.ElementalContractRank9) && player.hasPerk(PerkLib.ElementsOfMarethBasics) && player.perkv1(PerkLib.DaoOfTheElements) < 2) addButton(1, "DotE (layer 2)", mainPagePocketWatchDaoOfTheElementsPerkLayer2);
				else if (player.perkv1(PerkLib.DaoOfTheElements) >= 2) addButtonDisabled(1, "DotE (layer 2)", "You already have this merged perk.");
				else addButtonDisabled(1, "DotE (layer 2)", "Req. Elemental Contract Rank 9 & Elements of Mareth: Basics & Dao of the Elements perks.");
			}
			else addButtonDisabled(1, "DotE (layer 2)", "Req. Elemental Contract Rank 9 & Elements of Mareth: Basics & Dao of the Elements perks.");
			
			if (player.hasPerk(PerkLib.DaoOfTheElements) && player.perkv1(PerkLib.DaoOfTheElements) > 1) {
				if (player.hasPerk(PerkLib.ElementalContractRank13) && player.hasPerk(PerkLib.ElementsOfMarethAdvanced) && player.perkv1(PerkLib.DaoOfTheElements) < 3) addButton(2, "DotE (layer 3)", mainPagePocketWatchDaoOfTheElementsPerkLayer3);
				else if (player.perkv1(PerkLib.DaoOfTheElements) >= 3) addButtonDisabled(2, "DotE (layer 3)", "You already have this merged perk.");
				else addButtonDisabled(2, "DotE (layer 3)", "Req. Elemental Contract Rank 13 & Elements of Mareth: Advanced & Dao of the Elements (layer 2) perks.");
			}
			else addButtonDisabled(2, "DotE (layer 3)", "Req. Elemental Contract Rank 13 & Elements of Mareth: Advanced & Dao of the Elements (layer 2) perks.");

			//Additional layers removed until additional elemental perks have been made
			/*addButton(3, "DotE (layer 4)", mainPagePocketWatchDaoOfTheElementsPerkLayer4)
			.disableIf(!player.hasPerk(PerkLib.DaoOfTheElements) || player.perkv1(PerkLib.DaoOfTheElements) < 3 || !player.hasPerk(PerkLib.ElementalContractRank18),
						"Req. Elemental Contract Rank 18 & Dao of the Elements (layer 3) perks.")
			.disableIf(player.hasPerk(PerkLib.DaoOfTheElements) && player.perkv1(PerkLib.DaoOfTheElements) >= 4, "You already have this merged perk.");

			addButton(4, "DotE (layer 5)", mainPagePocketWatchDaoOfTheElementsPerkLayer5)
			.disableIf(!player.hasPerk(PerkLib.DaoOfTheElements) || player.perkv1(PerkLib.DaoOfTheElements) < 4 || !player.hasPerk(PerkLib.ElementalContractRank23),
						"Req. Elemental Contract Rank 23 & Dao of the Elements (layer 4) perks.")
			.disableIf(player.hasPerk(PerkLib.DaoOfTheElements) && player.perkv1(PerkLib.DaoOfTheElements) >= 5, "You already have this merged perk.");

			addButton(5, "DotE (layer 6)", mainPagePocketWatchDaoOfTheElementsPerkLayer6)
			.disableIf(!player.hasPerk(PerkLib.DaoOfTheElements) || player.perkv1(PerkLib.DaoOfTheElements) < 5 || !player.hasPerk(PerkLib.ElementalContractRank28),
						"Req. Elemental Contract Rank 28 & Dao of the Elements (layer 5) perks.")
			.disableIf(player.hasPerk(PerkLib.DaoOfTheElements) && player.perkv1(PerkLib.DaoOfTheElements) >= 6, "You already have this merged perk.");

			addButton(6, "DotE (layer 7)", mainPagePocketWatchDaoOfTheElementsPerkLayer7)
			.disableIf(!player.hasPerk(PerkLib.DaoOfTheElements) || player.perkv1(PerkLib.DaoOfTheElements) < 6 || !player.hasPerk(PerkLib.ElementalContractRank31),
						"Req. Elemental Contract Rank 31 & Dao of the Elements (layer 6) perks.")
			.disableIf(player.hasPerk(PerkLib.DaoOfTheElements) && player.perkv1(PerkLib.DaoOfTheElements) >= 7, "You already have this merged perk."); */

			addButton(13, "Next", mainPagePocketWatch, page + 1);
		}

		if (page == 3) {			
			addButton(0, "E C M & B R (Ex)", mainPagePocketWatchElementalConjurerMindAndBodyResolveEx)
			.disableIf(!player.hasPerk(PerkLib.ElementalConjurerMindAndBodyResolve), 
				"Req. Elemental Conjurer Mind and Body Resolve perks")
			.disableIf(player.hasPerk(PerkLib.ElementalConjurerMindAndBodyResolveEx) 
				|| player.hasPerk(PerkLib.ElementalConjurerMindAndBodyDedicationEx)
				|| player.hasPerk(PerkLib.ElementalConjurerMindAndBodySacrificeEx), "You already got this merged perk");

			addButton(1, "E C M & B D (Ex)", mainPagePocketWatchElementalConjurerMindAndBodyDedicationEx)
			.disableIf(!player.hasPerk(PerkLib.ElementalConjurerMindAndBodyDedication) || !player.hasPerk(PerkLib.ElementalConjurerMindAndBodyResolveEx), 
				"Req. Elemental Conjurer Mind and Body Resolve (Ex) & Elemental Conjurer Mind and Body Dedication perks")
			.disableIf(player.hasPerk(PerkLib.ElementalConjurerMindAndBodyDedicationEx)
				|| player.hasPerk(PerkLib.ElementalConjurerMindAndBodySacrificeEx), "You already got this merged perk");
			
			addButton(2, "E C M & B S (Ex)", mainPagePocketWatchElementalConjurerMindAndBodySacrificeEx)
			.disableIf(!player.hasPerk(PerkLib.ElementalConjurerMindAndBodySacrifice) || !player.hasPerk(PerkLib.ElementalConjurerMindAndBodyDedicationEx), 
				"Req. Elemental Conjurer Mind and Body Dedication (Ex) & Elemental Conjurer Mind and Body Sacrifice perks")
			.disableIf(player.hasPerk(PerkLib.ElementalConjurerMindAndBodySacrificeEx), "You already got this merged perk");
			
			addButton(12, "Previous", mainPagePocketWatch, page - 1);
			addButton(13, "Next", mainPagePocketWatch, page + 1);
		}
		
		if (page == 4) {			
			addButton(0, "ChBS-I (Ex)", mainPagePocketWatchChimericalBodySemiImprovedStageEx)
			.disableIf(!player.hasPerk(PerkLib.ChimericalBodySemiImprovedStage), 
				"Req. Chimerical Body: Semi-Improved Stage perk")
			.disableIf(player.hasPerk(PerkLib.ChimericalBodySemiImprovedStageEx) 
				|| player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStageEx)
				|| player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx), "You already got this merged perk");

			addButton(1, "ChBS-S (Ex)", mainPagePocketWatchChimericalBodySemiSuperiorStageEx)
			.disableIf(!player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStage) || !player.hasPerk(PerkLib.ChimericalBodySemiImprovedStageEx), 
				"Req. Chimerical Body: Semi-Superior Stage & Chimerical Body: Semi-Improved (Ex) Stage perks")
			.disableIf(player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStageEx)
				|| player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx), "You already got this merged perk");
			
			addButton(2, "ChBS-E (Ex)", mainPagePocketWatchChimericalBodySemiEpicStageEx)
			.disableIf(!player.hasPerk(PerkLib.ChimericalBodySemiEpicStage) || !player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStageEx), 
				"Req. Chimerical Body: Semi-Epic Stage & Chimerical Body: Semi-Superior (Ex) Stage perks")
			.disableIf(player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx), "You already got this merged perk");
			
			addButton(12, "Previous", mainPagePocketWatch, page - 1);
			addButton(13, "Next", mainPagePocketWatch, page + 1);;
		}

		if (page == 5) {
			addButton(0, "Raging Inferno (Mst)", mainPagePocketWatchRagingInfernoMastered)
			.disableIf(!player.hasPerk(PerkLib.RagingInfernoSu), "Req. Raging Inferno (Su) perk")
			.disableIf(player.hasPerk(PerkLib.RagingInfernoMastered), "You already got this merged perk");

			addButton(1, "Glacial Storm (Mst)", mainPagePocketWatchGlacialStormMastered)
			.disableIf(!player.hasPerk(PerkLib.GlacialStormSu), "Req. Glacial Storm (Su) perk")
			.disableIf(player.hasPerk(PerkLib.GlacialStormMastered), "You already got this merged perk");

			addButton(2, "High Voltage (Mst)", mainPagePocketWatchHighVoltageMastered)
			.disableIf(!player.hasPerk(PerkLib.HighVoltageSu), "Req. High Voltage (Su) perk")
			.disableIf(player.hasPerk(PerkLib.HighVoltageMastered), "You already got this merged perk");

			addButton(3, "Eclipsing Shadow (Mst)", mainPagePocketWatchEclipsingShadowMastered)
			.disableIf(!player.hasPerk(PerkLib.EclipsingShadowSu), "Req. Eclipsing Shadow (Su) perk")
			.disableIf(player.hasPerk(PerkLib.EclipsingShadowMastered), "You already got this merged perk");

			addButton(4, "Archmage (Ex)", mainPagePocketWatchArchmageEx)
			.disableIf(!player.hasPerk(PerkLib.Archmage), "Req. Archmage perk")
			.disableIf(player.hasPerk(PerkLib.ArchmageEx), "You already got this merged perk");

			addButton(5, "High Tide (Mst)", mainPagePocketWatchHighTideMastered)
			.disableIf(!player.hasPerk(PerkLib.HighTideSu), "Req. High Tide (Su) perk")
			.disableIf(player.hasPerk(PerkLib.HighTideMastered), "You already got this merged perk");

			addButton(6, "Howling Gale (Mst)", mainPagePocketWatchHowlingGaleMastered)
			.disableIf(!player.hasPerk(PerkLib.HowlingGaleSu), "Req. Howling Gale (Su) perk")
			.disableIf(player.hasPerk(PerkLib.HowlingGaleMastered), "You already got this merged perk");

			addButton(7, "Rumbling Quake (Mst)", mainPagePocketWatchRumblingQuakeMastered)
			.disableIf(!player.hasPerk(PerkLib.RumblingQuakeSu), "Req. Rumbling Quake (Su) perk")
			.disableIf(player.hasPerk(PerkLib.RumblingQuakeMastered), "You already got this merged perk");

			addButton(8, "Corrosive Meltdown (Mst)", mainPagePocketWatchCorrosiveMeltdownMastered)
			.disableIf(!player.hasPerk(PerkLib.CorrosiveMeltdownSu), "Req. Corrosive Meltdown (Su) perk")
			.disableIf(player.hasPerk(PerkLib.CorrosiveMeltdownMastered), "You already got this merged perk");

			addButton(12, "Previous", mainPagePocketWatch, page - 1);
			addButton(13, "Next", mainPagePocketWatch, page + 1);		
		}

		if (page == 6) {
			addButton(0, "G.Diehard (Ex)", mainPagePocketWatchGreaterDiehardEx)
			.disableIf(!player.hasPerk(PerkLib.GreaterDiehard), "Req. Greater Diehard perk")
			.disableIf(player.hasPerk(PerkLib.GreaterDiehardEx), "You already got this merged perk");

			addButton(12, "Previous", mainPagePocketWatch, page - 1);
		}

		if (page == 1) {
			addButton(14, "Back", campMiscActions);
		} else {
			addButton(14, "Back", mainPagePocketWatch, 1);
		}
	}
	private function mainPagePocketWatchDaoOfTheElementsPerkLayer1():void {
		clearOutput();
		outputText("Perks combined: Dao of the Elements (layer 1) perk attained.");
		player.removePerk(PerkLib.ElementalContractRank1);
		player.removePerk(PerkLib.ElementalContractRank2);
		player.removePerk(PerkLib.ElementalContractRank3);
		player.removePerk(PerkLib.ElementalContractRank4);
		player.removePerk(PerkLib.ElementsOfTheOrtodoxPath);
		player.createPerk(PerkLib.DaoOfTheElements, 1, 9, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 4);
		player.perkPoints += 3;
		doNext(mainPagePocketWatch, 2);
	}
	private function mainPagePocketWatchDaoOfTheElementsPerkLayer2():void {
		clearOutput();
		outputText("Perks combined: Dao of the Elements (layer 2) attained.");
		player.removePerk(PerkLib.ElementalContractRank5);
		player.removePerk(PerkLib.ElementalContractRank6);
		player.removePerk(PerkLib.ElementalContractRank7);
		player.removePerk(PerkLib.ElementalContractRank8);
		player.removePerk(PerkLib.ElementsOfMarethBasics);
		player.addPerkValue(PerkLib.DaoOfTheElements, 1, 1);
		player.addPerkValue(PerkLib.DaoOfTheElements, 2, 9);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 5);
		player.perkPoints += 3;
		doNext(mainPagePocketWatch, 2);
	}
	private function mainPagePocketWatchDaoOfTheElementsPerkLayer3():void {
		clearOutput();
		outputText("Perks combined: Dao of the Elements (layer 3) attained.");
		player.removePerk(PerkLib.ElementalContractRank9);
		player.removePerk(PerkLib.ElementalContractRank10);
		player.removePerk(PerkLib.ElementalContractRank11);
		player.removePerk(PerkLib.ElementalContractRank12);
		player.removePerk(PerkLib.ElementsOfMarethAdvanced);
		player.addPerkValue(PerkLib.DaoOfTheElements, 1, 1);
		player.addPerkValue(PerkLib.DaoOfTheElements, 2, 9);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 5);
		player.perkPoints += 3;
		doNext(mainPagePocketWatch, 2);
	}
	private function mainPagePocketWatchDaoOfTheElementsPerkLayer4():void {
		clearOutput();
		outputText("Perks combined: Dao of the Elements (layer 4) attained.");
		player.removePerk(PerkLib.ElementalContractRank13);
		player.removePerk(PerkLib.ElementalContractRank14);
		player.removePerk(PerkLib.ElementalContractRank15);
		player.removePerk(PerkLib.ElementalContractRank16);
		player.removePerk(PerkLib.ElementalContractRank17);
		player.addPerkValue(PerkLib.DaoOfTheElements, 1, 1);
		player.addPerkValue(PerkLib.DaoOfTheElements, 2, 8);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 5);
		player.perkPoints += 3;
		doNext(mainPagePocketWatch, 2);
	}
	private function mainPagePocketWatchDaoOfTheElementsPerkLayer5():void {
		clearOutput();
		outputText("Perks combined: Dao of the Elements (layer 5) attained.");
		player.removePerk(PerkLib.ElementalContractRank18);
		player.removePerk(PerkLib.ElementalContractRank19);
		player.removePerk(PerkLib.ElementalContractRank20);
		player.removePerk(PerkLib.ElementalContractRank21);
		player.removePerk(PerkLib.ElementalContractRank22);
		player.addPerkValue(PerkLib.DaoOfTheElements, 1, 1);
		player.addPerkValue(PerkLib.DaoOfTheElements, 2, 8);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 5);
		player.perkPoints += 3;
		doNext(mainPagePocketWatch, 2);
	}
	private function mainPagePocketWatchDaoOfTheElementsPerkLayer6():void {
		clearOutput();
		outputText("Perks combined: Dao of the Elements (layer 6) attained.");
		player.removePerk(PerkLib.ElementalContractRank23);
		player.removePerk(PerkLib.ElementalContractRank24);
		player.removePerk(PerkLib.ElementalContractRank25);
		player.removePerk(PerkLib.ElementalContractRank26);
		player.removePerk(PerkLib.ElementalContractRank27);
		player.addPerkValue(PerkLib.DaoOfTheElements, 1, 1);
		player.addPerkValue(PerkLib.DaoOfTheElements, 2, 8);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 5);
		player.perkPoints += 3;
		doNext(mainPagePocketWatch, 2);
	}
	private function mainPagePocketWatchDaoOfTheElementsPerkLayer7():void {
		clearOutput();
		outputText("Perks combined: Dao of the Elements (layer 7) attained.");
		player.removePerk(PerkLib.ElementalContractRank28);
		player.removePerk(PerkLib.ElementalContractRank29);
		player.removePerk(PerkLib.ElementalContractRank30);
		player.removePerk(PerkLib.ElementalContractRank31);
		player.addPerkValue(PerkLib.DaoOfTheElements, 1, 1);
		player.addPerkValue(PerkLib.DaoOfTheElements, 2, 7);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 4);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 2);
	}
	private function mainPagePocketWatchElementalConjurerMindAndBodyResolveEx():void {
		clearOutput();
		outputText("Perks combined: 'Elemental Conjurer Mind and Body Resolve (Ex)' perk attained.");
		player.removePerk(PerkLib.ElementalConjurerResolve);
		player.removePerk(PerkLib.ElementalConjurerMindAndBodyResolve);
		player.createPerk(PerkLib.ElementalConjurerMindAndBodyResolveEx, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 1);
		player.perkPoints++;
		doNext(mainPagePocketWatch, 3);
	}
	private function mainPagePocketWatchElementalConjurerMindAndBodyDedicationEx():void {
		clearOutput();
		outputText("Perks combined: 'Elemental Conjurer Mind and Body Dedication (Ex)' perk attained.");
		player.removePerk(PerkLib.ElementalConjurerMindAndBodyResolveEx);
		player.removePerk(PerkLib.ElementalConjurerDedication);
		player.removePerk(PerkLib.ElementalConjurerMindAndBodyDedication);
		player.createPerk(PerkLib.ElementalConjurerMindAndBodyDedicationEx, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 2);
		player.perkPoints++;
		doNext(mainPagePocketWatch, 3);
	}
	private function mainPagePocketWatchElementalConjurerMindAndBodySacrificeEx():void {
		clearOutput();
		outputText("Perks combined: 'Elemental Conjurer Mind and Body Sacrifice (Ex)' perk attained.");
		player.removePerk(PerkLib.ElementalConjurerMindAndBodyDedicationEx);
		player.removePerk(PerkLib.ElementalConjurerSacrifice);
		player.removePerk(PerkLib.ElementalConjurerMindAndBodySacrifice);
		player.createPerk(PerkLib.ElementalConjurerMindAndBodySacrificeEx, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 2);
		player.perkPoints++;
		doNext(mainPagePocketWatch, 3);
	}
	private function mainPagePocketWatchChimericalBodySemiImprovedStageEx():void {
		clearOutput();
		outputText("Perks combined: 'Chimerical Body: Semi-Improved (Ex) Stage' perk attained.");
		player.removePerk(PerkLib.ChimericalBodyInitialStage);
		player.removePerk(PerkLib.ChimericalBodySemiBasicStage);
		player.removePerk(PerkLib.ChimericalBodyBasicStage);
		player.removePerk(PerkLib.ChimericalBodySemiImprovedStage);
		player.createPerk(PerkLib.ChimericalBodySemiImprovedStageEx, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 3);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 4);
	}
	private function mainPagePocketWatchChimericalBodySemiSuperiorStageEx():void {
		clearOutput();
		outputText("Perks combined: 'Chimerical Body: Semi-Superior (Ex) Stage' perk attained.");
		player.removePerk(PerkLib.ChimericalBodyImprovedStage);
		player.removePerk(PerkLib.ChimericalBodySemiAdvancedStage);
		player.removePerk(PerkLib.ChimericalBodyAdvancedStage);
		player.removePerk(PerkLib.ChimericalBodySemiSuperiorStage);
		player.removePerk(PerkLib.ChimericalBodySemiImprovedStageEx);
		player.createPerk(PerkLib.ChimericalBodySemiSuperiorStageEx, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 4);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 4);
	}
	private function mainPagePocketWatchChimericalBodySemiEpicStageEx():void {
		clearOutput();
		outputText("Perks combined: 'Chimerical Body: Semi-Epic (Ex) Stage' perk attained.");
		player.removePerk(PerkLib.ChimericalBodySuperiorStage);
		player.removePerk(PerkLib.ChimericalBodySemiPeerlessStage);
		player.removePerk(PerkLib.ChimericalBodyPeerlessStage);
		player.removePerk(PerkLib.ChimericalBodySemiEpicStage);
		player.removePerk(PerkLib.ChimericalBodySemiSuperiorStageEx);
		player.createPerk(PerkLib.ChimericalBodySemiEpicStageEx, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 4);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 4);
	}
	private function mainPagePocketWatchRagingInfernoMastered():void {
		clearOutput();
		outputText("Perks combined: 'Raging Inferno (Mastered)' perk attained.");
		player.removePerk(PerkLib.RagingInferno);
		player.removePerk(PerkLib.RagingInfernoEx);
		player.removePerk(PerkLib.RagingInfernoSu);
		player.createPerk(PerkLib.RagingInfernoMastered, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 2);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 5);
	}
	private function mainPagePocketWatchGlacialStormMastered():void {
		clearOutput();
		outputText("Perks combined: 'Glacial Storm (Mastered)' perk attained.");
		player.removePerk(PerkLib.GlacialStorm);
		player.removePerk(PerkLib.GlacialStormEx);
		player.removePerk(PerkLib.GlacialStormSu);
		player.createPerk(PerkLib.GlacialStormMastered, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 2);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 5);
	}
	private function mainPagePocketWatchHighVoltageMastered():void {
		clearOutput();
		outputText("Perks combined: 'High Voltage (Mastered)' perk attained.");
		player.removePerk(PerkLib.HighVoltage);
		player.removePerk(PerkLib.HighVoltageEx);
		player.removePerk(PerkLib.HighVoltageSu);
		player.createPerk(PerkLib.HighVoltageMastered, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 2);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 5);
	}
	private function mainPagePocketWatchEclipsingShadowMastered():void {
		clearOutput();
		outputText("Perks combined: 'Eclipsing Shadow (Mastered)' perk attained.");
		player.removePerk(PerkLib.EclipsingShadow);
		player.removePerk(PerkLib.EclipsingShadowEx);
		player.removePerk(PerkLib.EclipsingShadowSu);
		player.createPerk(PerkLib.EclipsingShadowMastered, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 2);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 5);
	}
	private function mainPagePocketWatchArchmageEx():void {
		clearOutput();
		outputText("Perks combined: 'Archmage (Ex)' perk attained.");
		player.removePerk(PerkLib.Mage);
		player.removePerk(PerkLib.GrandMage);
		player.removePerk(PerkLib.Archmage);
		player.createPerk(PerkLib.ArchmageEx, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 2);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 5);
	}
	private function mainPagePocketWatchHighTideMastered():void {
		clearOutput();
		outputText("Perks combined: 'High Tide (Mastered)' perk attained.");
		player.removePerk(PerkLib.HighTide);
		player.removePerk(PerkLib.HighTideEx);
		player.removePerk(PerkLib.HighTideSu);
		player.createPerk(PerkLib.HighTideMastered, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 2);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 5);
	}
	private function mainPagePocketWatchHowlingGaleMastered():void {
		clearOutput();
		outputText("Perks combined: 'Howling Gale (Mastered)' perk attained.");
		player.removePerk(PerkLib.HowlingGale);
		player.removePerk(PerkLib.HowlingGaleEx);
		player.removePerk(PerkLib.HowlingGaleSu);
		player.createPerk(PerkLib.HowlingGaleMastered, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 2);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 5);
	}
	private function mainPagePocketWatchRumblingQuakeMastered():void {
		clearOutput();
		outputText("Perks combined: 'Rumbling Quake (Mastered)' perk attained.");
		player.removePerk(PerkLib.RumblingQuake);
		player.removePerk(PerkLib.RumblingQuakeEx);
		player.removePerk(PerkLib.RumblingQuakeSu);
		player.createPerk(PerkLib.RumblingQuakeMastered, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 2);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 5);
	}
	private function mainPagePocketWatchCorrosiveMeltdownMastered():void {
		clearOutput();
		outputText("Perks combined: 'Corrosive Meltdown (Mastered)' perk attained.");
		player.removePerk(PerkLib.CorrosiveMeltdown);
		player.removePerk(PerkLib.CorrosiveMeltdownEx);
		player.removePerk(PerkLib.CorrosiveMeltdownSu);
		player.createPerk(PerkLib.CorrosiveMeltdownMastered, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 2);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 5);
	}
	private function mainPagePocketWatchGreaterDiehardEx():void {
		clearOutput();
		outputText("Perks combined: 'Greater Diehard (Ex)' perk attained.");
		player.removePerk(PerkLib.Diehard);
		player.removePerk(PerkLib.ImprovedDiehard);
		player.removePerk(PerkLib.GreaterDiehard);
		player.createPerk(PerkLib.GreaterDiehardEx, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, 2);
		player.perkPoints += 2;
		doNext(mainPagePocketWatch, 6);
	}/*
	private function mainPagePocketWatch():void {
		clearOutput();
		outputText("Perks combined: '' perk attained.");
		player.removePerk(PerkLib.);
		player.createPerk(PerkLib.);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, );
		player.perkPoints++;
		doNext(mainPagePocketWatch, 1);
	}
	private function mainPagePocketWatch():void {
		clearOutput();
		outputText("Perks combined: '' perk attained.");
		player.removePerk(PerkLib.);
		player.createPerk(PerkLib.);
		player.addStatusValue(StatusEffects.MergedPerksCount, 1, );
		player.perkPoints++;
		doNext(mainPagePocketWatch, 1);
	}*/

	public function campWinionsArmySim():void {
		clearOutput();
		outputText("On which group of minions you want to check on?");
		menu();
		if (player.hasPerk(PerkLib.JobGolemancer)) addButton(0, "Make", campMake.accessMakeWinionsMainMenu).hint("Check your options for making some golems.");
		else addButtonDisabled(0, "Make", "You need to learn Golemancer job to use this option.");player.hasPerk(PerkLib.JobElementalConjurer)
		if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] > 0) addButton(1, "Summon", campMake.accessSummonElementalsMainMenu).hint("Check your options for managing your elemental summons.");
		else addButtonDisabled(1, "Summon", "You should first build Arcane Circle. Without some tools from the carpenter's toolbox it would be near impossible to do this OR you not yet learned Elemental Conjurer job.");
		if (player.hasPerk(PerkLib.PrestigeJobNecromancer)) addButton(5, "Skeletons", campMake.accessMakeSkeletonWinionsMainMenu).hint("Check your options for making some skeletons.");
		else addButtonDisabled(5, "Skeletons", "You need to learn Necromancer job to use this option.");
		if (player.hasPerk(PerkLib.PrestigeJobDruid)) addButton(6, "Fusions", druidMenu);
		else addButtonDisabled(6, "Fusions", "You need to learn Druid job to use this option.");
		addButton(14, "Back", campActions);
	}
	private function druidMenu():void {
		clearOutput();
		outputText("Would you like to fuse with an elemental and if so which?");
		if (player.hasPerk(PerkLib.SharedPower) && player.perkv1(PerkLib.SharedPower) > 0) outputText("\n\n+"+player.perkv1(PerkLib.SharedPower)+"0% multi bonus to health and damage when in an infused state");//temporaly to check if perk working as intended
		menu();
		if (player.hasPerk(PerkLib.ElementalBody)) {
			addButtonDisabled(0, "Air", "You need to unfuse first before trying to use this fusion option.");
			addButtonDisabled(1, "Earth", "You need to unfuse first before trying to use this fusion option.");
			addButtonDisabled(2, "Fire", "You need to unfuse first before trying to use this fusion option.");
			addButtonDisabled(3, "Water", "You need to unfuse first before trying to use this fusion option.");
			addButton(13, "Unfuse", druidMenuUnfuseScene);
		}
		else {
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsAirE)) {
				if (player.hasPerk(PerkLib.EclipticInfusion)) addButton(0, "Air", druidMenuAir);
				else addButton(0, "Air", druidMenuFuseScene, "air", 1, 0);
			}
			else addButtonDisabled(0, "Air", "You need to summon Epic Air Elemental first before trying to use this fusion option.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarthE)) {
				if (player.hasPerk(PerkLib.EclipticInfusion)) addButton(1, "Earth", druidMenuEarth);
				else addButton(1, "Earth", druidMenuFuseScene, "earth", 2, 0);
			}
			else addButtonDisabled(1, "Earth", "You need to summon Epic Earth Elemental first before trying to use this fusion option.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsFireE)) {
				if (player.hasPerk(PerkLib.EclipticInfusion)) addButton(2, "Fire", druidMenuFire);
				else addButton(2, "Fire", druidMenuFuseScene, "fire", 3, 0);
			}
			else addButtonDisabled(2, "Fire", "You need to summon Epic Fire Elemental first before trying to use this fusion option.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWaterE)) {
				if (player.hasPerk(PerkLib.EclipticInfusion)) addButton(3, "Water", druidMenuWater);
				else addButton(3, "Water", druidMenuFuseScene, "water", 4, 0);
			}
			else addButtonDisabled(3, "Water", "You need to summon Epic Water Elemental first before trying to use this fusion option.");
			addButtonDisabled(13, "Unfuse", "You need to be fused with any of epic elementals to use this option.");
		}
		addButton(14, "Back", campWinionsArmySim);
	}
	private function druidMenuAir():void {
		clearOutput();
		outputText("Would you like to also add an aligned elemental to your fusion?");
		menu();
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsPurity)) addButton(1, "Purity", druidMenuFuseScene, "air", 1, 2);
		else addButtonDisabled(1, "Purity", "You need to summon Normal Purity Elemental first before trying to use this fusion option.");
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsCorruption)) addButton(2, "Corruption", druidMenuFuseScene, "air", 1, 1);
		else addButtonDisabled(2, "Corruption", "You need to summon Normal Corruption Elemental first before trying to use this fusion option.");
		addButton(3, "No", druidMenuFuseScene, "air", 1, 0);
	}
	private function druidMenuEarth():void {
		clearOutput();
		outputText("Would you like to also add an aligned elemental to your fusion?");
		menu();
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsPurity)) addButton(1, "Purity", druidMenuFuseScene, "earth", 2, 2);
		else addButtonDisabled(1, "Purity", "You need to summon Normal Purity Elemental first before trying to use this fusion option.");
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsCorruption)) addButton(2, "Corruption", druidMenuFuseScene, "earth", 2, 1);
		else addButtonDisabled(2, "Corruption", "You need to summon Normal Corruption Elemental first before trying to use this fusion option.");
		addButton(3, "No", druidMenuFuseScene, "earth", 2, 0);
	}
	private function druidMenuFire():void {
		clearOutput();
		outputText("Would you like to also add an aligned elemental to your fusion?");
		menu();
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsPurity)) addButton(1, "Purity", druidMenuFuseScene, "fire", 3, 2);
		else addButtonDisabled(1, "Purity", "You need to summon Normal Purity Elemental first before trying to use this fusion option.");
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsCorruption)) addButton(2, "Corruption", druidMenuFuseScene, "fire", 3, 1);
		else addButtonDisabled(2, "Corruption", "You need to summon Normal Corruption Elemental first before trying to use this fusion option.");
		addButton(3, "No", druidMenuFuseScene, "fire", 3, 0);
	}
	private function druidMenuWater():void {
		clearOutput();
		outputText("Would you like to also add an aligned elemental to your fusion?");
		menu();
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsPurity)) addButton(1, "Purity", druidMenuFuseScene, "water", 4, 2);
		else addButtonDisabled(1, "Purity", "You need to summon Normal Purity Elemental first before trying to use this fusion option.");
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsCorruption)) addButton(2, "Corruption", druidMenuFuseScene, "water", 4, 1);
		else addButtonDisabled(2, "Corruption", "You need to summon Normal Corruption Elemental first before trying to use this fusion option.");
		addButton(3, "No", druidMenuFuseScene, "water", 4, 0);
	}
	private function druidMenuFuseScene(element:String, type:Number, type2:Number):void {
		clearOutput();
		var oldHPratio:Number = player.hp100/100;
		outputText("You concentrate on the "+element+" elemental slowly infusing its essence within yours. "+(type2 > 0 ? "Half way through the fusion a second elemental that of "+(type2 > 1 ? "purity":"corruption")+" also joins in. ":"")+"Your body begins to change accordly to take on the aspect of "+element+".\n\n");
		outputText("After a few seconds, you open your eyes, now one with "+element+" as a");
		if (type == 1) outputText(" Sylph");
		if (type == 2) outputText(" Gnome");
		if (type == 3) outputText("n Ignis");
		if (type == 4) outputText("n Undine");
		outputText(".\n\nYou admire your new ");
		if (type == 1) outputText("light green");
		if (type == 2) outputText("dark brown");
		if (type == 3) outputText("tan");
		if (type == 4) outputText("light blue");
		outputText(" skin which emphasizes the element you’ve become. Your ears have changed to "+(type == 4?"gain fins":"becoming pointed")+" like those of an "+(type == 4?"aquatic creature":"elf")+". ");
		outputText("Your irises also have changed, the new hue is ");
		if (type == 1) outputText("orange like the twilight sky");
		if (type == 2) outputText("green like a leaf");
		if (type == 3) outputText("orange like glittering embers");
		if (type == 4) outputText("turquoise like the sea");
		outputText(".\n\n");
		if (type == 1) outputText("A Constant gust of wind seems to constantly lift the ethereal skirt that formed beneath your chest like a bell or a parachute. The four winds answer your masterful call like an old friend, always happy to please whether with a smooth breeze or with a violent gust. You have acquired true control over the winds.\n\n");
		if (type == 2) outputText("In your hair grows a small vine decorated with leaves, and your skin has achieved the durability of hard rock. Your legs and hands reshape, craggy and golem-like; large and crude but very powerful. Your feet are embedded in stone and heavily but not for you, the weight of the world seems no longer to affect you, rather you have acquired true control over not only rock and ground but also soil and plants.\n\n");
		if (type == 3) outputText("Your hair, wrist, and knees burn with the excess of your fiery power, the fire ready to do your bidding. Some say you shouldn’t play with fire, but who’s going to stop you now? You have achieved true control over the fire element.\n\n");
		if (type == 4) outputText("Your hairs now regularly drip fluid on the ground beneath you if you forget them. Not only that but you seem to be able to control and generate what appears to be an endless quantity of water. You have acquired true control over water.\n\n");
		if (player.hasPerk(PerkLib.SharedPower)) player.addPerkValue(PerkLib.SharedPower, 1, druidMenuSharedPowerPerkCounting());
		var tier:Number = 1;
		if (type == 1 && player.statusEffectv2(StatusEffects.SummonedElementalsAirE) > 3) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) > 9) tier += 3;
			else if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) > 6) tier += 2;
			else tier += 1;
		}
		if (type == 2 && player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) > 3) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) > 9) tier += 3;
			else if (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) > 6) tier += 2;
			else tier += 1;
		}
		if (type == 3 && player.statusEffectv2(StatusEffects.SummonedElementalsFireE) > 3) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) > 9) tier += 3;
			else if (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) > 6) tier += 2;
			else tier += 1;
		}
		if (type == 4 && player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) > 3) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) > 9) tier += 3;
			else if (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) > 6) tier += 2;
			else tier += 1;
		}
		player.createPerk(PerkLib.ElementalBody,type,tier,type2,0);
		if (type == 1) player.createPerk(PerkLib.AffinitySylph,0,0,0,0);
		if (type == 2) player.createPerk(PerkLib.AffinityGnome,0,0,0,0);
		if (type == 3) player.createPerk(PerkLib.AffinityIgnis,0,0,0,0);
		if (type == 4) player.createPerk(PerkLib.AffinityUndine,0,0,0,0);
		CoC.instance.mainViewManager.updateCharviewIfNeeded();
		player.HP = oldHPratio*player.maxHP();
		statScreenRefresh();
		doNext(druidMenu);
	}
	private function druidMenuUnfuseScene():void {
		clearOutput();
		var oldHPratio:Number = player.hp100/100;
		outputText("You end your fusion separating from the elemental back into two different entities.");
		if (player.hasPerk(PerkLib.SharedPower)) player.setPerkValue(PerkLib.SharedPower, 1, 0);
		player.removePerk(PerkLib.ElementalBody);
		if (player.hasPerk(PerkLib.AffinitySylph)) player.removePerk(PerkLib.AffinitySylph);
		if (player.hasPerk(PerkLib.AffinityGnome)) player.removePerk(PerkLib.AffinityGnome);
		if (player.hasPerk(PerkLib.AffinityIgnis)) player.removePerk(PerkLib.AffinityIgnis);
		if (player.hasPerk(PerkLib.AffinityUndine)) player.removePerk(PerkLib.AffinityUndine);
		CoC.instance.mainViewManager.updateCharviewIfNeeded();
		player.HP = oldHPratio*player.maxHP();
		statScreenRefresh();
		doNext(druidMenu);
	}
	private function druidMenuSharedPowerPerkCounting():Number {
		var dmSPPC:Number = 12;
		if (player.hasPerk(PerkLib.ElementsOfTheOrtodoxPath)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementsOfMarethBasics)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalBondFlesh)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementsOfMarethAdvanced)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalBondUrges)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.StrongElementalBond)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalConjurerKnowledge)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.StrongElementalBondEx)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.FirstAttackElementals)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.FirstAttackElementalsEx)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.StrongElementalBondSu)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.FirstAttackElementalsSu)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank8)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank9)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalConjurerSacrifice)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank10)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank11)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalTouch)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank12)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.GreaterSharedPower)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank13)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.StrongerElementalBondEx)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.EclipticInfusion)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank14)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank15)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank16)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.StrongerElementalBondSu)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank17)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank18)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank19)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank20)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.StrongestElementalBond)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank21)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank22)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank23)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank24)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.StrongestElementalBondEx)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank25)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank26)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank27)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank28)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.StrongestElementalBondSu)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank29)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank30)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalContractRank31)) dmSPPC += 1;
		if (player.hasPerk(PerkLib.ElementalConjurerMindAndBodySacrificeEx)) dmSPPC += 4;
		if (player.hasPerk(PerkLib.DaoOfTheElements)) {
			dmSPPC += 5;
			if (player.perkv1(PerkLib.DaoOfTheElements) > 1) dmSPPC += (5 * (player.perkv1(PerkLib.DaoOfTheElements) - 1));
			if (player.perkv1(PerkLib.DaoOfTheElements) == 7) dmSPPC -= 1;
		}
		if (player.hasPerk(PerkLib.GreaterSharedPower)) dmSPPC *= 2;
		return dmSPPC;
	}

	private function VisitFishery():void {
		outputText("\n\nYou go check at the barrels for food.");
		if (flags[kFLAGS.FISHES_STORED_AT_FISHERY] > 0) outputText(" There is currently " + flags[kFLAGS.FISHES_STORED_AT_FISHERY] + " fish in the barrel.");
		menu();
		if (flags[kFLAGS.FISHES_STORED_AT_FISHERY] > 0) addButton(0, "Retrieve", Retrieve);
		if (flags[kFLAGS.FISHES_STORED_AT_FISHERY] > 0) addButton(1, "Retrieve Stack", RetrieveStack);
		addButton(14, "Back", campMiscActions);
	}

	private function Retrieve():void {
		outputText("\n\nYou pick up a fish and add it to your inventory.");
		flags[kFLAGS.FISHES_STORED_AT_FISHERY]--;
		inventory.takeItem(consumables.FREFISH, VisitFishery);
	}

	private function RetrieveStack():void {
		if (flags[kFLAGS.FISHES_STORED_AT_FISHERY] >= 10) {
			outputText("\n\nYou pick up and bag a stack of fish and add them to your inventory.");
			flags[kFLAGS.FISHES_STORED_AT_FISHERY] -= 10;
			inventory.takeItem(useables.STAFISH, VisitFishery);
		} else {
			outputText("\n\nYou need more fish to bag out a bundle.");
			doNext(VisitFishery);
		}
	}

	public function FisheryDailyProduction():Number {
		var fishproduction:Number = 0;
		if (flags[kFLAGS.FOLLOWER_AT_FISHERY_1] != "") {
			fishproduction += 5;
			if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 2) fishproduction += 1;
		}
		if (flags[kFLAGS.FOLLOWER_AT_FISHERY_2] != "") {
			fishproduction += 5;
			if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 2) fishproduction += 1;
		}
		if (flags[kFLAGS.FOLLOWER_AT_FISHERY_3] != "") {
			fishproduction += 5;
			if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 2) fishproduction += 1;
		}
		if (flags[kFLAGS.CEANI_FOLLOWER] > 0) fishproduction -= 5;
		return fishproduction;
	}
	public function FisheryWorkersCount():Number {
		var fisheryworkers:Number = 0;
		if (flags[kFLAGS.FOLLOWER_AT_FISHERY_1] != "") fisheryworkers += 1;
		if (flags[kFLAGS.FOLLOWER_AT_FISHERY_2] != "") fisheryworkers += 1;
		if (flags[kFLAGS.FOLLOWER_AT_FISHERY_3] != "") fisheryworkers += 1;
		return fisheryworkers;
	}
	public function FisheryMaxWorkersCount():Number {
		var fisherymaxworkers:Number = 1;
		if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 2) fisherymaxworkers += 1;
		if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 3) fisherymaxworkers += 1;
		return fisherymaxworkers;
	}

	private function MagicWardMenu():void {
		clearOutput();
		outputText("You touch one of the warding stones");
		if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 2) {
			outputText(", and feel a surge of power as every stone comes alive with power.  The ward is up, and your [camp] should be safe.");
			flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] = 3;
			doNext(campMiscActions);
			return;
		}
		if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 3) {
			outputText(" and murmur a incantation.  Gradually, the power within the stones fade as they go dormant. Soon, the glow of the glyphs adorning the stones has gone dark.");
			flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] = 2;
			doNext(campMiscActions);
		}
	}

	private function AlterBindScroll():void {
		var statusNames:Array = [
			[StatusEffects.AlterBindScroll1, "No Limiter"],
			[StatusEffects.AlterBindScroll2, "Unliving Leech"],
			[StatusEffects.AlterBindScroll3, "Undead Resistance"],
			[StatusEffects.AlterBindScroll4, "Vital Sense"],
			[StatusEffects.AlterBindScroll5, "Zombified"],
		];
		var i:int;
		clearOutput();
		var limitOnAltering:Number = 1;
		if (player.hasPerk(PerkLib.ImprovedCursedTag)) limitOnAltering += 1;
		if (player.hasPerk(PerkLib.GreaterCursedTag)) limitOnAltering += 3;
		var currentAltering:Number = 0;
		for (i = 0; i < statusNames.length; ++i) {
			if (player.hasStatusEffect(statusNames[i][0])) ++currentAltering;
		}
		outputText("Would you like to alter your curse tag, and if so, with what changes?\n\n");
		outputText("Current active powers / Limit of active powers: "+currentAltering+" / "+limitOnAltering+"\n\n");
		outputText("<u><b>Active powers:</b></u>\n");
		for (i = 0; i < statusNames.length; ++i) {
			if (player.hasStatusEffect(statusNames[i][0])) outputText("<b>- " + statusNames[i][1] + "</b>\n")
		}
		outputText("\n<u><b>Effects of each powers:</b></u>\n");
		outputText("No Limiter -> <i>Your zombified body is extremely resilient to physical damage and thus grants you +40% damage reduction. Furthermore the absence of a brain limiter allows you to push your limb strength beyond their normal capacity increasing your total strength by 100% of its value at the cost of your body integrity, taking light libido weakening on each attack. This is a togglable ability.</i>\n");
		outputText("Unliving Leech -> <i>Double the benefits of Life Leech and the power cap on Energy harvested from Energy Dependant.</i>\n");
		outputText("Undead Resistance -> <i>Gain Immunity to Cold, Poison and Fatigue damage.</i>\n");
		outputText("Vital Sense -> <i>You sense and see your opponents strong vital points which grants you increased critical damage. Increase critical strike damage multiplier by 1 time.</i>\n");
		outputText("Zombified -> <i>You are immune to mental attacks that would affect living sane beings. Furthermore you have unlimited fatigue.</i>\n");
		menu();
		for (i = 0; i < statusNames.length; ++i) {
			addButton(i, statusNames[i][1], alterBindScrollToggle, statusNames[i][0]);
			if (player.hasStatusEffect(statusNames[i][0])) {
				button(i).hint("You already have this power active. Do you want to deactivate it?");
			} else {
				if (currentAltering < limitOnAltering) button(i).hint("You don't have this power active. Do you want to activate it?");
				else button(i).disable("You already have the maximum amount of powers active as you can maintain without breaking yourself.");
			}
		}
		addButton(14, "Back", campMiscActions);
	}

	private function alterBindScrollToggle(status:StatusEffectType):void {
		if (player.hasStatusEffect(status)) player.removeStatusEffect(status);
		else player.createStatusEffect(status,0,0,0,0);
		AlterBindScroll();
	}

	private function fillUpPillBottle(pills:ItemType, result:ItemType, grade:String):void {
		clearOutput();
		outputText("You pick up one of your empty pill bottles and start to put in some of your loose "+grade+"-grade soulforce recovery pills. Then you close the bottle and put it into your backpack.");
		player.destroyItems(useables.E_P_BOT, 1);
		player.destroyItems(pills, 10);
		inventory.takeItem(result, campMiscActions);
	}
	
	/**
	 * Gets clone count (or buff existence)
	 * @param	buffexist If true, returns player.hasStatusEffect(StatusEffects.PCClone) 0=no, 1=yes instead
	 * @return player.statusEffectv3(StatusEffects.PCClone) aka "clone count", 0 if no buff
	 */public function gcc(buffexist:Boolean = false):Number {
		 if (buffexist) return player.hasStatusEffect(StatusEffects.PCClone) ? 1 : 0;
		 if (player.hasStatusEffect(StatusEffects.PCClone)) return player.statusEffectv3(StatusEffects.PCClone);
		 return 0;
	}
	public function maximumClonesCount(absolutemax:Boolean = false):Number {
		// Don't forget to extend Soulforce.clones[] and related buffs if increasing
		if (absolutemax) return Soulforce.clones.length;
		var mCC:Number = Soulforce.clones.length;
		if (!player.hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) mCC = 1;
		return mCC;
	}

	private function CloneMenu():void {
		var clone:int;
		clearOutput();
		if (gcc() > 0) {
			outputText("Your clone" + (gcc() > 1 ? "s are" : " is") + " wandering around [camp]. What would you ask "+ (gcc() > 1 ? "them" : "[him]") + " to do?\n\n");
			for (clone = 0; clone < Soulforce.clones.length; ++clone) {
				outputText("\nCurrent clone (" + (clone + 1) + ") task: ");
				if (player.statusEffectv1(Soulforce.clones[clone]) > 10 && player.statusEffectv1(Soulforce.clones[clone]) < 21) {
					outputText("Contemplating Dao of ");
					for (var d:int = 0; d < Soulforce.daos.length; ++d) {
						if (player.statusEffectv1(Soulforce.clones[clone]) == Soulforce.daos[d][2])
							outputText(Soulforce.daos[d][0]);
					}
				} else outputText("Nothing");
				outputText("\n\n");
			}
		} else outputText("You do not have a clone right now, whether you've never made one or one was sacrificed. You would need to make a new one, first.");
		outputText("\n\n");
		menu();
		addButton(13, "Create", FormClone)
			.disableIf(player.isGargoyle(), "You can't clone your stone body!")
			.disableIf(player.negativeLevel > 0, "You need to regain your power before you can create another clone. Unrecovered levels: " + player.negativeLevel)
			.disableIf(gcc() >= maximumClonesCount(), "You cannot have more than " + maximumClonesCount() + " clone" + (maximumClonesCount() > 1 ? "s" : "") + " right now.")
			.disableIf(gcc() >= maximumClonesCount(true), "You cannot have more than " + maximumClonesCount() + " clones.")
			.disableIf(player.HP <= player.maxHP() * 0.9, "Your HP is too low.")
			.disableIf(player.soulforce < player.maxSoulforce() * 0.9, "Your Soulforce is too low.");
		
		for (clone = 0; clone < Soulforce.clones.length; ++clone) {
			if (clone > 12) continue; // short circuit for too many, maybe add pagination if clone cap gets upped for some reason
			addButton(clone, "Contempl. (" + (clone + 1) + ")", cloneContemplateDao, clone)
				.hint("Task your clone (" + (clone + 1) + ") with contemplating one of the Daos you know.")
				.disableIf(!player.hasStatusEffect(Soulforce.clones[clone]), "Req. fully formed clone (" + (clone + 1) + ").");
		}
		addButton(14, "Back", campMiscActions);
	}
	
	private function FormClone():void {
		clearOutput();
		var newClone:int;
		if (gcc(true)) {
			for (var i:int = gcc(); i < maximumClonesCount(); i++) {
				if (player.hasStatusEffect(Soulforce.clones[i-1])) newClone = i;
			}
		} else {
			newClone = 0;
			player.createStatusEffect(StatusEffects.PCClone, 0, 0, 0, 0);
		}
		player.addStatusValue(StatusEffects.PCClone, 3, 1);
		player.createStatusEffect(Soulforce.clones[newClone], 0, 0, 0, 0);
		FormCloneText();
		outputText("You share a grin now that the process is successful. Your quest remains to be completed, but now you have the power of "+NUMBER_WORDS_NORMAL[newClone+2]+".\n\n");
		EngineCore.SoulforceChange(-player.maxSoulforce()*0.85);
		HPChange(-(player.maxHP() * 0.85), true);
		player.negativeLevel += Soulforce.clonelevelcost;
		doNext(camp.returnToCampUseEightHours);
	}
	private function FormCloneText():void {
		outputText("You close your eyes with the intent of forming your " + (gcc(true) ? "next" : "first") + " clone. Minutes pass as the sensation of soul force and life essence slowly escapes from your being.\n\n");
		outputText("Time passes as you steadily concentrate on the essence that has left your body. Keeping your concentration on the swirling energy, you guide more of the essence and soul energy to leave your body and drift toward the new creation growing before you.\n\n");
		outputText("An hour later, the sphere begins to take the shape of your body with the energy you've guided into it. It is slightly larger than you, with the outer layer being nothing more than something to prevent the essences you've given it from escaping.\n\n");
		outputText("The outer layer steadily begins to change into the form of a translucent cocoon. It's barely noticeable, but you can see the vital organs form inside the incubator.\n\n");
		outputText("Two hours pass as the cocoon hardens into a substance akin to hard, black chitin until the cocoon is opaque. A small part of the layer around the navel keeps some translucent properties.\n\n");
		outputText("Minutes go by as time slowly passes. Your energies enter the clone through the only malleable part of the carapace around the navel. After around five hours, you notice a dull rhythm. A heart beats with increasing life as the moments pass.\n\n");
		outputText("Soon after the heartbeat, other rapid changes begin inside the clone. The body itself begins to animate as the clone takes its first breaths. With the transfer nearly completely, the new life is on the verge of its complete vitality.\n\n");
		outputText("Now that the body is full of life, you need to link it to your soul. The process is foreign, almost invasive as you link your essence to something alien, but as the minutes pass, the feeling steadily becomes more natural.\n\n");
		outputText("Suddenly, the clone has begun to feel like an extension of your body, almost as if you could move it yourself. It's not long until you're properly attuned to your clone.\n\n");
		outputText("The shell cracks before your clone emerges from the incubator. It's a glorious reflection of you, though it seems to have the common decency to give itself a simple grey robe before presenting its barren body.\n\n");
	}
	/*
	 * old primaltwin flavor	 * 
			/*if (player.statusEffectv3(StatusEffects.PCClone) < 4) {
				outputText("Your clone is ");
				if (player.statusEffectv3(StatusEffects.PCClone) == 1) outputText("slowly rotating basketball sized sphere of soul and life essences");
				else if (player.statusEffectv3(StatusEffects.PCClone) == 2) outputText("looking like you, albeit with translucent body");
				else outputText("looking like you covered with black chitin-like carapace");
				outputText(". Would you work on completing it?");
			}
			else {*/		//that part will be later used for primaltwin - note for Svalkash
			
			
	/*private function FormPrimalTwin():void {//cringe name of function - change it later on but need it for other death/bad end evade option for cultivators - note for.... err he know it's for him by now, right?
		clearOutput();
		if (player.hasStatusEffect(StatusEffects.PCClone)) {
			if (player.statusEffectv3(StatusEffects.PCClone) == 3) {
				outputText("It's time to finish what you started. Your clone won't simply create itself. With the black carapace-like layer in front of you, you resume focusing on transferring your life essence and soulforce to the clone.\n\n");
				outputText("Minutes draw by as time slowly passes. Your energies enter the clone through the only malleable part of the carapace around the navel. After around five hours, you notice a dull rhythm. A heart beats with increasing life as the moments pass.\n\n");
				outputText("Soon after the heartbeat, other rapid changes begin inside the clone. The body itself begins to animate as the clone takes its first breaths. With the transfer nearly completely, the new life is on the verge of its complete vitality.\n\n");
				outputText("Now that the body is full of life, you need to link it to your soul. The process is foreign, almost invasive as you link your essence to something alien, but as the minutes pass, the feeling steadily becomes more natural. ");
				outputText("It's not long until the clone feels like an extension of your body, almost as if you could move it yourself. ");
				outputText("It's not long until you're properly attuned to your clone. The shell cracks before your clone emerges from the incubator. It's a glorious reflection of you, though it seems to have the common decency to give itself a simple grey robe before presenting its barren body.\n\n");
				outputText("You share a grin now that the process is successful. Your quest remains to be completed, but now you have the power of two.\n\n");
				outputText("<b>Your clone is fully formed.</b>\n\n");
				player.addStatusValue(StatusEffects.PCClone, 3, 1);
				EngineCore.SoulforceChange(-player.maxSoulforce());
				HPChange(-(player.maxHP() * 0.5), true);
				player.addNegativeLevels(30);
			}
			else if (player.statusEffectv3(StatusEffects.PCClone) == 2) {
				outputText("You return to work on completing your clone. Compared to the previous form of the large sphere, it now looks more like you. You begin the process for the third time.\n\n");
				outputText("The outer layer steadily begins to change into the form of a translucent cocoon. It's barely noticeable, but you can see the vital organs form inside the incubator.\n\n");
				outputText("Six hours pass as the cocoon hardens into a substance akin to hard, black chitin until the cocoon is opaque. A small part of the layer around the navel keeps some translucent properties.\n\n");
				outputText("Fatigue steadily overwhelms you after expending such intense amounts of your life energy. You lie down and rest for an hour before you decide to resume.\n\n");
				player.addStatusValue(StatusEffects.PCClone, 3, 1);
				EngineCore.SoulforceChange(-player.maxSoulforce());
				HPChange(-(player.maxHP() * 0.5), true);
			}
			else {
				outputText("Having recovered your spent life force and soul energy, you return to the halted ritual. Sitting before you is a slowly rotating basketball-sized sphere of soul and life essences. You start to focus on the next phase of clone formation.\n\n");
				outputText("Without further delay, you focus the essence from your body, guiding it to the sphere before you.\n\n");
				outputText("A few hours later, the sphere begins to take the shape of your body with the energy you've guided into it. It is slightly larger than you, with the outer layer being nothing more than something to prevent the essences you've given it from escaping.\n\n");
				outputText("With the second phase completed, you slowly break the connection with your clone. Your mind and body wrack from the expended essence you've given to your clone. You decide to take the time to rest.\n\n");
				outputText("After a couple of hours, you rise before leaving the half-finished creation in the corner of your [camp].\n\n");
				player.addStatusValue(StatusEffects.PCClone, 3, 1);
				EngineCore.SoulforceChange(-player.maxSoulforce());
				HPChange(-(player.maxHP() * 0.5), true);
			}
		}
		else {
			outputText("You close your eyes with the intent of forming the core of your clone. Minutes pass as the sensation of your soul force and life essence slowly escapes from your being.\n\n");
			outputText("An hour passes as you steadily concentrate on the essence that has left your body. Keeping your concentration on the swirling life, you guide more of essence and soul energy to leave your body and drift toward the new creation growing before you.\n\n");
			outputText("The process is slow. While nourishing the core of the clone, you find yourself unable to expend any more of your life essence or risk being completely drained of soul essence.\n\n");
			player.createStatusEffect(StatusEffects.PCClone, 0, 0, 1, 0);
			EngineCore.SoulforceChange(-(player.maxSoulforce()));
			HPChange(-(player.maxHP() * 0.5), true);
		}
		doNext(camp.returnToCampUseEightHours);
	}
	*/
	private function cloneContemplateDao(clone:int):void {
		clearOutput();
		outputText("Maybe your clone ("+clone+") could contemplate one of the Daos you know while you adventure outside the [camp]? But which one it should be?");
		menu();
		var btn:int = 0;
		for (var d:int = 0; d < Soulforce.daos.length; ++d) {
			addButton(btn++, Soulforce.daos[d][0], cloneContemplateDaoSet, clone, Soulforce.daos[d][2])
				.disableIf(player.statusEffectv1(Soulforce.clones[clone]) == Soulforce.daos[d][2], "Your clone ("+clone+") is currently contemplating this Dao.");
		}
		addButton(13, "None", cloneContemplateDaoSet, clone, 10)
			.disableIf(player.statusEffectv1(Soulforce.clones[clone]) == 10, "Your clone ("+clone+") is currently not contemplating any Dao.");
		addButton(14, "Back", CloneMenu);
	}

	private function cloneContemplateDaoSet(clone:int, newdao:Number):void {
		player.changeStatusValue(Soulforce.clones[clone], 1, newdao);
		cloneContemplateDao(clone);
	}

	private function dummyTraining(lvl:int = 0, lustImmune:Boolean = true, isGroup:Boolean = false):void {
		clearOutput();
		outputText("You walk towards the sparring ring, wondering how to approach your training:\n");
		outputText("Current Configuration:\n\n");

		switch(lvl) {
			case 0: outputText("Level: 0\n");
					break;
			case 1: outputText("Level: 30\n");
					break;
			case 2: outputText("Level: 60\n");
					break;
			case 3: outputText("Level: 90\n");
					break;
			case 4: outputText("Level: 150\n");
					break;
		}

		if (lustImmune) {
			outputText("Lust: Will not respond to lust\n")
		} else {
			outputText("Lust: Will simulate the effects of lust\n")
		}

		if (isGroup) {
			outputText("Group: Will face multiple dummies at once\n")
		} else {
			outputText("Group: Will face a single dummy\n")
		}

		menu();
		addButton(0, "Lvl0", dummyTraining, 0, lustImmune, isGroup)
			.disableIf(lvl == 0, "Already selected");
		addButton(1, "Lvl30", dummyTraining, 1, lustImmune, isGroup)
			.disableIf(lvl == 1, "Already selected")
			.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 3, "You need to improve the sparring ring more first!");
		addButton(2, "Lvl60", dummyTraining, 2, lustImmune, isGroup)
			.disableIf(lvl == 2, "Already selected")
			.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 4, "You need to improve the sparring ring more first!");
		addButton(3, "Lvl90", dummyTraining, 3, lustImmune, isGroup)
			.disableIf(lvl == 3, "Already selected")
			.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 5, "You need to improve the sparring ring more first!");
		addButton(4, "Lvl150", dummyTraining, 4, lustImmune, isGroup)
			.disableIf(lvl == 4, "Already selected")
			.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 5, "You need to improve the sparring ring more first!");
		addButton(5, "Normal", dummyTraining, lvl, true, isGroup)
			.disableIf(lustImmune, "Already selected");
		addButton(6, "Sim. Lust", dummyTraining, lvl, false, isGroup)
			.disableIf(!lustImmune, "Already selected")
			.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 3, "You need to improve the sparring ring more first!");
		addButton(7, "Solo", dummyTraining, lvl, lustImmune, false)
			.disableIf(!isGroup, "Already selected");
		addButton(8, "Group", dummyTraining, lvl, lustImmune, true)
			.disableIf(isGroup, "Already selected")
			.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 5, "You need to improve the sparring ring more first!");
		addButton(13, "Fight", dummyTrainingStart, lvl, lustImmune, isGroup);
		addButton(14, "Back", campActions);
	}

	private function dummyTrainingStart(lvl:int = 0, lustImmune:Boolean = true, isGroup:Boolean = false):void {
		clearOutput();
		outputText("You walk toward the worn out " + (isGroup? "dummies": "dummy") + " as you draw your [weapon].");
		startCombat(new TrainingDummy(lvl, lustImmune, isGroup));
	}

	private function SparrableNPCsMenuText():void {
		outputText("Champion party composition: [name]");
		if (player.hasPerk(PerkLib.BasicLeadership)) {
			if (flags[kFLAGS.PLAYER_COMPANION_1] != "") outputText(", " + flags[kFLAGS.PLAYER_COMPANION_1]);
			else outputText(", (no combat companion)");
		}
		if (player.hasPerk(PerkLib.IntermediateLeadership)) {
			if (flags[kFLAGS.PLAYER_COMPANION_2] != "") outputText(", " + flags[kFLAGS.PLAYER_COMPANION_2]);
			else outputText(", (no combat companion)");
		}/*
		if (player.hasPerk(PerkLib.AdvancedLeadership)) {
			if (flags[kFLAGS.PLAYER_COMPANION_3] != "") outputText(", " + flags[kFLAGS.PLAYER_COMPANION_3]);
			else outputText(", (no combat companion)");
		}*/
		outputText(" (Efficiency of Attacks: "+combat.comfoll.increasedEfficiencyOfAttacks()*100+" %)");
		if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) {
			outputText("\n\nPlaceholder text about deciding if sparrable npc's in [camp] should train or relax (train mean rising in lvl after enough time loosing to PC in sparrings).");
			outputText("\n\nPlaceholder text about current mode [camp] combat NPC's are in: ");
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) outputText("Training Mode\n");
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] < 2) outputText("Relax Mode\n");
		}
		if (player.hasStatusEffect(StatusEffects.ChiChiOff)) outputText("\nChi Chi: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.DivaOff)) outputText("\nDiva: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.ElectraOff)) outputText("\nElectra: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.EtnaOff)) outputText("\nEtna: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.LunaOff)) outputText("\nLuna: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.NadiaOff)) outputText("\nNadia: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.TedOff)) outputText("\nDragon Boi: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.SophieOff)) outputText("\nSophie: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.HeliaOff)) outputText("\nHelia: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.KonstantinOff)) outputText("\nKonstantin: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.SpoodersOff)) outputText("\nSpooders: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.ShouldraOff)) outputText("\nShouldra: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.CalluOff)) outputText("\nCallu (Otter girl): <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.VenusOff)) outputText("\nVenus (Gigantic Turtle): <font color=\"#800000\"><b>Disabled</b></font>");
	}
	private function SparrableNPCsMenu():void {
		clearOutput();
		SparrableNPCsMenuText();
		menu();
		
		if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) {
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] < 2) addButton(10, "Train", NPCsTrain);
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) addButton(10, "Relax", NPCsRelax);
		}
		//since this section is WIP anyway, let her be here too, lol
		if (flags[kFLAGS.GOTTA_CAMP_THEM_ALL_MODE] < 2) addButton(11, "Activate", GottaCampThemALLOn).hint("Turn on 'Gotta Camp them ALL' Mode.");
		if (flags[kFLAGS.GOTTA_CAMP_THEM_ALL_MODE] == 2) addButton(11, "Deactivate", GottaCampThemALLOff).hint("Turn off 'Gotta Camp them ALL' Mode.");
        
		addButton(13, "Others", SparrableNPCsMenuOthers).hint("Out of camp encounters only.");
		addButton(14, "Back", campActions);
	}
	private function SparrableNPCsMenuCampNPCs():void {
		clearOutput();
		SparrableNPCsMenuText();
		menu();
		addButton(0, "Chi Chi", toggleNPCStatus, StatusEffects.ChiChiOff).hint("Enable or Disable Chi Chi. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(1, "Nadia", toggleNPCStatus, StatusEffects.NadiaOff).hint("Enable or Disable Nadia. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(2, "Diva", toggleNPCStatus, StatusEffects.DivaOff).hint("Enable or Disable Diva. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(3, "Electra", toggleNPCStatus, StatusEffects.ElectraOff).hint("Enable or Disable Electra. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(4, "Etna", toggleEtna).hint("Enable or Disable Etna. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(5, "Luna", toggleLuna).hint("Enable or Disable Luna. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(6, "DragonBoi", toggleNPCStatus, StatusEffects.TedOff).hint("Enable or Disable Dragon Boi. This will remove him from enc table.");
		addButton(7, "Konstantin", toggleNPCStatus, StatusEffects.KonstantinOff).hint("Enable or Disable Konstantin. This will remove him from enc table and if already in [camp] disable access to him.");
		addButton(8, "Sophie", toggleSophie).hint("Enable or Disable Sophie. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(9, "Helia", toggleHelia).hint("Enable or Disable Helia. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(12, "Spooders", toggleNPCStatus, StatusEffects.SpoodersOff).hint("Enable or Disable spooder followers. This will remove them ONLY from enc table.");
		addButton(13, "Shouldra", toggleShouldra).hint("Enable or Disable Shouldra. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(14, "Back", SparrableNPCsMenu);
	}
	private function SparrableNPCsMenuOthers():void {
		clearOutput();
		SparrableNPCsMenuText();
		menu();
		addButton(0, "Callu", toggleNPCStatus, StatusEffects.CalluOff).hint("Enable or Disable Callu (Otter girl). This will remove her from enc table.");
		addButton(1, "Venus", toggleNPCStatus, StatusEffects.VenusOff).hint("Enable or Disable Venus (Gigantic Turtle). This will remove her from enc table.");
		addButton(14, "Back", SparrableNPCsMenu);
	}

	private function NPCsTrain():void {
		outputText("\n\nPlaceholder text about telling NPC's to train.");
		flags[kFLAGS.SPARRABLE_NPCS_TRAINING] = 2;
		doNext(SparrableNPCsMenu);
	}
	private function NPCsRelax():void {
		outputText("\n\nPlaceholder text about telling NPC's to relax.");
		flags[kFLAGS.SPARRABLE_NPCS_TRAINING] = 1;
		doNext(SparrableNPCsMenu);
	}
	private function GottaCampThemALLOn():void {
		outputText("\n\nPlaceholder text about turning on 'Gotta Camp them ALL' mode.");
		flags[kFLAGS.GOTTA_CAMP_THEM_ALL_MODE] = 2;
		doNext(SparrableNPCsMenu);
	}
	private function GottaCampThemALLOff():void {
		outputText("\n\nPlaceholder text about turning off 'Gotta Camp them ALL' mode.");
		flags[kFLAGS.GOTTA_CAMP_THEM_ALL_MODE] = 1;
		doNext(SparrableNPCsMenu);
	}

	private function toggleNPCStatus(status:StatusEffectType):void {
		if (player.hasStatusEffect(status)) player.removeStatusEffect(status);
		else player.createStatusEffect(status, 0, 0, 0, 0);
		SparrableNPCsMenu();
	}

	private function toggleLuna():void {
		if (flags[kFLAGS.SLEEP_WITH] == "Luna") flags[kFLAGS.SLEEP_WITH] = ""; //reset sleeping thingy
		toggleNPCStatus(StatusEffects.LunaOff);
	}
	private function toggleEtna():void {
		if (flags[kFLAGS.SLEEP_WITH] == "Etna") flags[kFLAGS.SLEEP_WITH] = ""; //reset sleeping thingy
		toggleNPCStatus(StatusEffects.EtnaOff);
	}
	private function toggleSophie():void {
		if (flags[kFLAGS.SLEEP_WITH] == "Sophie") flags[kFLAGS.SLEEP_WITH] = ""; //reset sleeping thingy
		toggleNPCStatus(StatusEffects.SophieOff);
	}
	private function toggleHelia():void {
		if (flags[kFLAGS.SLEEP_WITH] == "Helia") flags[kFLAGS.SLEEP_WITH] = ""; //reset sleeping thingy
		toggleNPCStatus(StatusEffects.HeliaOff);
	}
	private function toggleShouldra():void {
		if (flags[kFLAGS.SHOULDRA_SLEEP_TIMER] != 0) flags[kFLAGS.SHOULDRA_SLEEP_TIMER] = 0; //reset neglation tracker
		toggleNPCStatus(StatusEffects.ShouldraOff);
	}

	private function swimInStream():void {
		var prankChooser:Number = rand(3);
		clearOutput();
		outputText("You ponder over the nearby stream that's flowing. Deciding you'd like a dip, ");
		if (player.armorName == "slutty swimwear") outputText("you are going to swim while wearing just your swimwear. ");
		else outputText("you strip off your [armor] until you are completely naked. ");
		outputText("You step into the flowing waters. You shiver at first but you step in deeper. Incredibly, it's not too deep. ");
		if (player.basetallness < 60) outputText("Your feet aren't even touching the riverbed. ");
		if (player.basetallness >= 60 && player.basetallness < 72) outputText("Your feet are touching the riverbed and your head is barely above the water. ");
		if (player.basetallness >= 72) outputText("Your feet are touching touching the riverbed and your head is above water. You bend down a bit so you're at the right height. ");
		outputText("\n\nYou begin to swim around and relax. ");
		//Izma!
		if (rand(2) == 0 && camp.izmaFollower()) {
			outputText("\n\nYour tiger-shark beta, Izma, joins you. You are frightened at first when you saw the fin protruding from the water and the fin approaches you! ");
			outputText("As the fin approaches you, the familiar figure comes up. \"<i>I was going to enjoy my daily swim, alpha,</i>\" she says.");
			izmaJoinsStream = true;
		}
		//Helia!
		if (rand(2) == 0 && camp.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff) && flags[kFLAGS.HEL_CAN_SWIM]) {
			outputText("\n\nHelia, your salamander lover, joins in for a swim. \"<i>Hey, lover mine!</i>\" she says. As she enters the waters, the water seems to become warmer until it begins to steam like a sauna.");
			heliaJoinsStream = true;
		}
		//Marble!
		if (rand(2) == 0 && camp.marbleFollower()) {
			outputText("\n\nYour cow-girl lover Marble strips herself naked and joins you. \"<i>Sweetie, you enjoy swimming, don't you?</i>\" she says.");
			marbleJoinsStream = true;
		}
		//Amily! (Must not be corrupted and must have given Slutty Swimwear.)
		if (rand(2) == 0 && camp.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_OWNS_BIKINI] > 0) {
			outputText("\n\nYour mouse-girl lover Amily is standing at the riverbank. She looks flattering in her bikini");
			if (flags[kFLAGS.AMILY_WANG_LENGTH] > 0) outputText(", especially when her penis is exposed");
			outputText(". She walks into the waters and swims.  ");
			amilyJoinsStream = true;
		}
		//Ember
		if (rand(4) == 0 && camp.followerEmber()) {
			outputText("\n\nYou catch a glimpse of Ember taking a daily bath.");
		}
		//Rathazul (RARE)
		if (rand(10) == 0 && player.hasStatusEffect(StatusEffects.CampRathazul)) {
			outputText("\n\nYou spot Rathazul walking into the shallow section of stream, most likely taking a bath to get rid of the smell.");
		}
		//Pranks!
		if (prankChooser == 0 && (camp.izmaFollower() || (camp.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff) && flags[kFLAGS.HEL_CAN_SWIM]) || camp.marbleFollower() || (camp.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_OWNS_BIKINI] > 0))) {
			outputText("\n\nYou could play some pranks by making the water curiously warm. Do you?");
			doYesNo(swimInStreamPrank1, swimInStreamFinish);
		}
		else doNext(swimInStreamFinish);

	}

	private function swimInStreamPrank1():void {
		var pranked:Boolean = false;
		var prankRoll:Number = 1;
		//How many people joined!
		if (izmaJoinsStream) prankRoll++;
		if (marbleJoinsStream) prankRoll++;
		if (heliaJoinsStream) prankRoll++;
		if (amilyJoinsStream) prankRoll++;
		if (prankRoll > 4) prankRoll = 4;
		//Play joke on them!
		clearOutput();
		outputText("You look around to make sure no one is looking then you smirk and you can feel yourself peeing. When you're done, you swim away.  ");
		if (rand(prankRoll) == 0 && camp.izmaFollower() && !pranked && izmaJoinsStream) {
			outputText("\n\nIzma just swims over, unaware of the warm spot you just created. \"<i>Who pissed in the stream?</i>\" she growls. You swim over to her and admit to her that you admit you did pee in the stream. \"<i>Oh, alpha! What a naughty alpha you are,</i>\" she grins, her shark-teeth clearly visible.");
			pranked = true;
		}
		if (rand(prankRoll) == 0 && (camp.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff) && flags[kFLAGS.HEL_CAN_SWIM]) && !pranked && heliaJoinsStream) {
			outputText("\n\nHelia swims around until she hits the warm spot you just created. \"<i>Heyyyyyyy,</i>\" the salamander yells towards you. She comes towards you and asks \"<i>Did you just piss in the stream?</i>\" after which you sheepishly chuckle and tell her that you admit it. Yes, you've done it. \"<i>I knew it! Oh, you're naughty, lover mine!</i>\" she says.");
			pranked = true;
		}
		if (rand(prankRoll) == 0 && camp.marbleFollower() && !pranked && marbleJoinsStream) {
			outputText("\n\nMarble is oblivious to the warm spot and when she swims over, she yells \"<i>Hey, sweetie! Did you just urinate in the stream?</i>\" You sheepishly smile and admit that yes, you did it. She says, \"<i>You're naughty, you know, sweetie!</i>\"");
			pranked = true;
		}
		if (!pranked) outputText("  No one managed to swim past where you left the warm spot before it dissipated. You feel a bit disappointed and just go back to swimming.");
		else outputText("  You feel accomplished from the prank and resume swimming. ");
		awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE);
		doNext(swimInStreamFinish);
	}

	private function swimInStreamFinish():void {
		clearOutput();
		//Blown up factory? Corruption gains.
		if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
			outputText("You feel a bit dirtier after swimming in the tainted waters. \n\n");
			dynStats("cor", 0.5);
			if (player.cor < 25) dynStats("lust", 30, "scale", true);
			if (player.cor >= 25 && player.cor < 50) dynStats("lust", 20, "scale", true);
			if (player.cor >= 50) dynStats("lust", 10, "scale", true);
		} else if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) {
			outputText("You feel a bit cleaner after swimming in the waters. \n\n");
			if (player.cor < 33) dynStats("lust", -30, "scale", false);
			if (player.cor >= 33 && player.cor < 66) dynStats("lust", -20, "scale", false);
			if (player.cor >= 66) dynStats("lust", -10, "scale", false);
		} else {
			outputText("You feel a little bit cleaner after swimming in the waters. \n\n");
			if (player.cor < 33) dynStats("lust", -15, "scale", false);
			if (player.cor >= 33 && player.cor < 66) dynStats("lust", -10, "scale", false);
			if (player.cor >= 66) dynStats("lust", -5, "scale", false);
		}
		outputText("Eventually, you swim back to the riverbank and dry yourself off");
		if (player.armorName != "slutty swimwear") outputText(" before you re-dress yourself in your " + player.armorName);
		outputText(".");
		doNext(camp.returnToCampUseOneHour);
	}

	private function examinePortal():void {
		clearOutput();
		if (flags[kFLAGS.CAMP_PORTAL_PROGRESS] <= 0) {
			outputText("You walk over to the portal, reminded by how and why you came. You wonder if you can go back to Ingnam. You start by picking up a small pebble and throw it through the portal. It passes through the portal. As you walk around the portal, you spot the pebble at the other side. Seems like you can't get back right now.");
			flags[kFLAGS.CAMP_PORTAL_PROGRESS] = 1;
			doNext(camp.returnToCampUseOneHour);
			return;
		} else outputText("You walk over to the portal, reminded by how and why you came. You let out a sigh, knowing you can't return to Ingnam.");
		doNext(playerMenu);
	}

	private function watchSunset():void {
		clearOutput();
		outputText(images.showImage("camp-watch-sunset"));
		outputText("You pick a location where the sun is clearly visible from and sit down. The sun is just above the horizon, ready to set. It's such a beautiful view. \n\n");
		var randText:Number = rand(3);
		//Childhood nostalgia GO!
		if (randText == 0) {
			if (player.cor < 33) {
				outputText("A wave of nostalgia washes over you as you remember your greatest moments from your childhood.");
				dynStats("cor", -1, "lust", -30, "scale", false);
			}
			if (player.cor >= 33 && player.cor < 66) {
				outputText("A wave of nostalgia washes over you as you remember your greatest moments from your childhood. Suddenly, your memories are somewhat twisted from some of the perverted moments. You shake your head and just relax.");
				dynStats("cor", -0.5, "lust", -20, "scale", false);
			}
			if (player.cor >= 66) {
				outputText("A wave of nostalgia washes over you as you remember your greatest moments from your childhood. Suddenly, your memories twist into some of the dark and perverted moments. You chuckle at that moment but you shake your head and focus on relaxing.");
				dynStats("cor", 0, "lust", -10, "scale", false);
			}
		}
		//Greatest moments GO!
		if (randText == 1) {
			if (player.cor < 33) {
				outputText("You reflect back on your greatest adventures and how curiosity got the best of you. You remember some of the greatest places you discovered.");
				dynStats("lust", -30, "scale", false);
			}
			if (player.cor >= 33 && player.cor < 66) {
				outputText("You reflect back on your greatest adventures. Of course, some of them involved fucking and getting fucked by the denizens of Mareth. You suddenly open your eyes from the memory and just relax, wondering why you thought of that in the first place.");
				dynStats("lust", -20, "scale", false);
			}
			if (player.cor >= 66) {
				outputText("You reflect back on your greatest adventures. You chuckle at the moments you were dominating and the moments you were submitting. You suddenly open your eyes from the memory and just relax.");
				dynStats("lust", -10, "scale", false);
			}
		}
		//Greatest moments GO!
		if (randText >= 2) {
			outputText("You think of what you wanted like to ");
			if (rand(2) == 0) outputText("do");
			else outputText("accomplish");
			outputText(" before you went through the portal. You felt a bit sad that you didn't get to achieve your old goals.");
			dynStats("lust", -30, "scale", false);
		}
		outputText("\n\nAfter the thought, you spend a good while relaxing and watching the sun setting. By now, the sun has already set below the horizon. The sky is glowing orange after the sunset. It looks like you could explore more for a while.");
		doNext(camp.returnToCampUseOneHour);
	}

	private function watchStars():void {
		clearOutput();
		outputText(images.showImage("camp-watch-stars"));
		outputText("You pick a location not far from your " + homeDesc() + " and lay on the ground, looking up at the starry night sky.");
		outputText("\n\nEver since the fall of Lethice, the stars are visible.");
		outputText("\n\nYou relax and point at various constellations.");
		var consellationChoice:int = rand(4);
		switch (consellationChoice) {
			case 0:
				outputText("\n\nOne of them even appears to be phallic. You blush at the arrangement.");
				break;
			case 1:
				outputText("\n\nOne of them even appears to be arranged like breasts. You blush at the arrangement.");
				break;
			case 2:
				outputText("\n\nOne of the constellations have the stars arranged to form the shape of a centaur. Interesting.");
				break;
			case 3:
				outputText("\n\nAh, the familiar Big Dipper. Wait a minute... you remember that constellation back in Ingnam. You swear the star arrangements are nearly the same.");
				break;
			default:
				outputText("\n\nSomehow, one of them spells out \"ERROR\". Maybe you should let Ormael/Aimozg know?");
		}
		outputText("\n\nYou let your mind wander and relax.");
		dynStats("lus", -15, "scale", false);
		doNext(camp.returnToCampUseOneHour);
	}

	private function useGryphonStatuette():void {
		CoC.instance.mutations.skybornSeed(1, player);
		advanceMinutes(5);
		doNext(playerMenu);
	}
	private function usePeacockStatuette():void {
		CoC.instance.mutations.skybornSeed(2, player);
		advanceMinutes(5);
		doNext(playerMenu);
	}

//-----------------
//-- REST
//-----------------
	public function restMenu():void {
		menu();
		addButton(0, "1 Hour",  restFor, 1).hint("Rest for one hour.");
		addButton(1, "2 Hours", restFor, 2).hint("Rest for two hours.");
		addButton(2, "3 Hours", restFor, 3).hint("Rest for three hours.");
		addButton(3, "4 Hours", restFor, 4).hint("Rest for four hours.");
		addButton(4, "6 Hours", restFor, 6).hint("Rest for six hours.");
		addButton(5, "8 Hours", restFor, 8).hint("Rest for eight hours.");
		addButton(6, "10 Hours",restFor, 10).hint("Rest for ten hours.");
		addButton(7, "12 Hours",restFor, 12).hint("Rest for twelve hours.");
		if (player.isNightCreature()) addButton(8, "Till Dawn", restTillDawn).hint("Rest until the dawn comes.");
		else addButton(8, "Till Dusk", restTillDusk).hint("Rest until the night comes.");
		addButton(14, "Back", playerMenu);
	}

	public function restFor(hours:int):void {
		waitingORresting = hours;
		rest();
	}

	public function restTillDusk():void {
		restFor(21 - model.time.hours);
	}

	public function restTillDawn():void {
		restFor(model.time.hours >= 22 ? 6 + (24 - model.time.hours) : 6 - model.time.hours);
	}

	// Multiply by this instead of hours to account for uninterrupted rest bonus
	public function acceleratingRecoveryFactor(hours:Number, isSleeping:Boolean):Number {
		var perHour:Number = 1;
		if (isSleeping) {
			if (player.hasPerk(PerkLib.RecuperationSleep)) perHour += 1;
			if (player.hasPerk(PerkLib.RejuvenationSleep)) perHour += 2;
		}
		var bonus:Number = perHour * hours;
		// Bonus for uninterrupted rest: accumulating +50% for every hour starting with 2nd
		bonus += 0.5*(hours*(hours-1)/2); // 0 + 0.5 + 1 + 1.5 + ...
		return bonus;
	}

	public function rest():void {
		campQ = true;
		IsWaitingResting = true;
		clearOutput();
		//Fatigue recovery
		var multiplier:Number = 1.0;
		var fatRecovery:Number = 4;
		var hpRecovery:Number = 10;
		var hpTime:Number = acceleratingRecoveryFactor(waitingORresting, false);
		if (player.level >= 24) {
			fatRecovery += 2;
			hpRecovery += 5;
		}
		if (player.level >= 42) {
			fatRecovery += 2;
			hpRecovery += 5;
		}
		if (player.hasPerk(PerkLib.Medicine)) hpRecovery *= 1.5;
		if (player.hasPerk(PerkLib.SpeedyRecovery)) fatRecovery += 2;
		if (player.hasPerk(PerkLib.SpeedyRecuperation)) fatRecovery += 4;
		if (player.hasPerk(PerkLib.SpeedyRejuvenation)) fatRecovery += 8;
		if (player.hasPerk(PerkLib.ControlledBreath)) fatRecovery *= 1.1;
		if (player.hasStatusEffect(StatusEffects.BathedInHotSpring)) fatRecovery *= 1.2;
		if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) fatRecovery *= 3;
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && !ingnam.inIngnam)
			multiplier += 0.5;
		//Marble withdrawal
		if (player.hasStatusEffect(StatusEffects.MarbleWithdrawl))
			multiplier /= 2;
		//Hungry
		if (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger < 25)
			multiplier /= 2;
		if (timeQ == 0) {
			var hpBefore:int = player.HP;
			timeQ = waitingORresting;
			//THIS IS THE TEXT AREA FOR NOCTURNAL
			HPChange(hpTime * hpRecovery * multiplier, false);
			fatigue(timeQ * -fatRecovery * multiplier);

			if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && !ingnam.inIngnam) {
				if (timeQ != 1) outputText("You head into your cabin to rest. You lie down on your bed to rest for " + num2Text(timeQ) + " hours.\n");
				else outputText("You head into your cabin to rest. You lie down on your bed to rest for an hour.\n");
			} else if (player.lowerBody == LowerBody.PLANT_FLOWER) {
				if (timeQ != 1) outputText("You lie down in your pitcher, closing off your petals as you get comfortable for " + num2Text(timeQ) + " hours.\n");
				else outputText("You lie down in your pitcher, closing off your petals as you get comfortable for an hour.\n");
			} else if (player.lowerBody == LowerBody.FLOWER_LILIRAUNE) {
				if (timeQ != 1) outputText("You and your twin sister lie down in your pitcher, closing off your petals as you get comfortable for " + num2Text(timeQ) + " hours.\n");
				else outputText("You and your twin sister lie down in your pitcher, closing off your petals as you get comfortable for an hour.\n");
			} else if (player.isGargoyle()) {
				if (timeQ != 1) outputText("You sit on your pedestal, your body petrifying like stone as you briefly slumber for " + num2Text(timeQ) + " hours.\n");
				else outputText("You sit on your pedestal, your body petrifying like stone as you briefly slumber for an hour.\n");
			} else {
				if (timeQ != 1) outputText("You lie down to rest for " + num2Text(timeQ) + " hours.\n");
				else outputText("You lie down to rest for an hour.\n");
			}
			//Ayane
			if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) {
				if (timeQ != 1) outputText("\nYou tell Ayane you wish to rest for a few hours. The devoted priestess assists your recovery by bandaging your wounds and preparing a meditation tea ceremony.\n");
				else outputText("\nYou tell Ayane you wish to rest for a hour. The devoted priestess assists your recovery by bandaging your wounds and preparing a meditation tea ceremony.\n");
			}
			//Marble withdrawal
			if (player.hasStatusEffect(StatusEffects.MarbleWithdrawl)) {
				outputText("\nYour rest is very troubled, and you aren't able to settle down. You get up feeling tired and unsatisfied, always thinking of Marble's milk.\n");
				player.addCurse("tou", 0.1, 2);
				player.addCurse("int", 0.1, 2);
			}
			//Bee cock
			if (player.hasCock() && player.cocks[0].cockType == CockTypesEnum.BEE) {
				outputText("\nThe desire to find the bee girl that gave you this cursed [cock] and have her spread honey all over it grows with each passing minute\n");
			}
			//Starved goo armor
			if (player.armor == armors.GOOARMR && flags[kFLAGS.VALERIA_FLUIDS] <= 0 && valeria.valeriaFluidsEnabled()) {
				outputText("\nYou feel the fluid-starved goo rubbing all over your groin as if Valeria wants you to feed her.\n");
			}
			//Hungry
			if (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger < 25) {
				outputText("\nYou have difficulty resting as you toss and turn with your stomach growling.\n");
			}
			if (SceneLib.alvinaFollower.AlvinaPurified) {
				var mincor:int = player.getAllMinStats().cor;
				if (player.cor == 0 || player.cor <= mincor) {}
				else {
					outputText("\nYour purified lover Alvina exudes a calming and purifying aura which helps you shed some of your build up corruption.\n");
					if (player.cor >= mincor+10) dynStats("cor", -10);
					else dynStats("cor", -(player.cor - mincor));
				}

			}

			EngineCore.HPChangeNotify(player.HP - hpBefore);
		} else {
			clearOutput();
			if (timeQ != 1) outputText("You continue to rest for " + num2Text(timeQ) + " more hours.\n");
			else outputText("You continue to rest for another hour.\n");
		}
		goNext(true);
	}

//-----------------
//-- WAIT
//-----------------
	public function doWaitMenu():void {
		menu();
		addButton(0, "1 Hour",  doWaitFor, 1).hint("Wait one hour.");
		addButton(1, "2 Hours", doWaitFor, 2).hint("Wait two hours.");
		addButton(2, "3 Hours", doWaitFor, 3).hint("Wait three hours.");
		addButton(3, "4 Hours", doWaitFor, 4).hint("Wait four hours.");
		addButton(4, "6 Hours", doWaitFor, 6).hint("Wait six hours.");
		addButton(5, "8 Hours", doWaitFor, 8).hint("Wait eight hours.");
		addButton(6, "10 Hours", doWaitFor, 10).hint("Wait ten hours.");
		addButton(7, "12 Hours", doWaitFor, 12).hint("Wait twelve hours.");
		if (player.isNightCreature()) addButton(8, "Till Dawn", doWaitTillDawn).hint("Wait until the dawn comes.");
		else addButton(8, "Till Dusk", doWaitTillDusk).hint("Wait until the night comes.");
		addButton(14, "Back", playerMenu);
	}

	public function doWaitFor(hours:int):void {
		waitingORresting = hours;
		doWait();
	}

	public function doWaitTillDusk():void {
		doWaitFor(21 - model.time.hours);
	}

	public function doWaitTillDawn():void {
		doWaitFor(model.time.hours >= 22 ? 6 + (24 - model.time.hours) : 6 - model.time.hours);
	}

	public function doWait():void {
		IsWaitingResting = true;
		campQ = true;
		clearOutput();
		//Fatigue recovery
		var fatRecovery:Number = 2;
		if (player.level >= 24) fatRecovery += 1;
		if (player.level >= 42) fatRecovery += 1;
		if (player.hasPerk(PerkLib.SpeedyRecovery)) fatRecovery += 1;
		if (player.hasPerk(PerkLib.SpeedyRecuperation)) fatRecovery += 2;
		if (player.hasPerk(PerkLib.SpeedyRejuvenation)) fatRecovery += 4;
		if (player.hasPerk(PerkLib.ControlledBreath)) fatRecovery *= 1.1;
		if (player.hasStatusEffect(StatusEffects.BathedInHotSpring)) fatRecovery *= 1.2;
		if (timeQ == 0) {
			timeQ = waitingORresting;

			if (player.lowerBody == LowerBody.PLANT_FLOWER) outputText("You lie down in your pitcher, closing off your petals as you get comfortable for " + num2Text(timeQ) + " hour" + (timeQ % 10 == 1 ? "" : "s") + "...\n");
			else outputText("You wait " + num2Text(timeQ) + " hour" + (timeQ % 10 == 1 ? "" : "s") + "...\n");
			//Marble withdrawl
			if (player.hasStatusEffect(StatusEffects.MarbleWithdrawl)) {
				outputText("\nYour time spent waiting is very troubled, and you aren't able to settle down.  You get up feeling tired and unsatisfied, always thinking of Marble's milk.\n");
				//fatigue
				fatRecovery /= 2;
				fatigue(-fatRecovery * timeQ);
			}
			//Bee cock
			if (player.hasCock() && player.cocks[0].cockType == CockTypesEnum.BEE) {
				outputText("\nThe desire to find the bee girl that gave you this cursed [cock] and have her spread honey all over it grows with each passing minute\n");
			}
			//Starved goo armor
			if (player.armor == armors.GOOARMR && flags[kFLAGS.VALERIA_FLUIDS] <= 0) {
				outputText("\nYou feel the fluid-starved goo rubbing all over your groin as if Valeria wants you to feed her.\n");
			}
			//REGULAR HP/FATIGUE RECOVERY
			else {
				//fatigue
				fatigue(-fatRecovery * timeQ);
			}
		} else {
			if (timeQ != 1) outputText("You continue to wait for " + num2Text(timeQ) + " more hours.\n");
			else outputText("You continue to wait for another hour.\n");
		}
		goNext(true);
	}

//-----------------
//-- SLEEP
//-----------------
	public function sleepInCabin():Boolean {
		return flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0
			&& ["", "Marble", "Zenji", "Excellia", "Luna", "Samirah", "Sophie", "Hel"].indexOf(flags[kFLAGS.SLEEP_WITH]) != -1;
	}

	public function doSleep(clrScreen:Boolean = true):void {
		IsSleeping = true;
		campQ = true;
		if (CoC.instance.timeQ == 0) {
			CanDream = true;
			model.time.minutes = 0;
			if (player.isNightCreature())
			{
				if (model.time.hours >= 6 && model.time.hours <=21)
						CoC.instance.timeQ += 15 - model.time.hours + 7;
			}
			else
			{
				if (model.time.hours >= 21)
					CoC.instance.timeQ += 24-model.time.hours +6;
				if (model.time.hours < 6)
					CoC.instance.timeQ += 6-model.time.hours;
			}
			if (flags[kFLAGS.BENOIT_CLOCK_ALARM] > 0) {
				CoC.instance.timeQ += (flags[kFLAGS.BENOIT_CLOCK_ALARM] - 6);
			}
			//Autosave stuff
			if (player.slotName != "VOID" && player.autoSave && mainView.getButtonText(0) != "Game Over") {
				trace("Autosaving to slot: " + player.slotName);
				CoC.instance.saves.saveGame(player.slotName);
			}
			//Clear screen
			if (clrScreen) clearOutput();
			/******************************************************************/
			/*       ONE TIME SPECIAL EVENTS                                  */
			/******************************************************************/
			//HEL SLEEPIES!
			if (helFollower.helAffection() >= 70 && flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE] == 0 && flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 0) {
				SceneLib.dungeons.heltower.heliaDiscoveryPrompt();
				sleepRecovery(false);
				return;
			}
			//Shouldra xgartuan fight
			if (followerShouldra() && !player.hasStatusEffect(StatusEffects.ShouldraOff) && SceneLib.exgartuan.dickPresent()) {
				if (flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] == 0) {
					shouldraFollower.shouldraAndExgartumonFightGottaCatchEmAll();
					sleepRecovery(false);
					return;
				} else if (flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] == 3) {
					shouldraFollower.exgartuMonAndShouldraShowdown();
					sleepRecovery(false);
					return;
				}
			}
			if (player.hasCock() && followerShouldra() && !player.hasStatusEffect(StatusEffects.ShouldraOff) && flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] == -0.5) {
				shouldraFollower.keepShouldraPartIIExgartumonsUndeatH();
				sleepRecovery(false);
				return;
			}
			//Full Moon
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8 && flags[kFLAGS.LUNA_FOLLOWER] < 9 && flags[kFLAGS.LUNA_AFFECTION] >= 50 && flags[kFLAGS.SLEEP_WITH] == "Luna" && player.gender > 0 && !player.hasStatusEffect(StatusEffects.LunaOff)) {
				SceneLib.lunaFollower.fullMoonEvent();
				sleepRecovery(false);
				return;
			}
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8 && flags[kFLAGS.LUNA_JEALOUSY] >= 400 && player.gender > 0 && player.hasStatusEffect(StatusEffects.LunaWasWarned) && !player.hasStatusEffect(StatusEffects.LunaOff)) {
				SceneLib.lunaFollower.fullMoonEvent();
				sleepRecovery(false);
				return;
			}
			/******************************************************************/
			/*       SLEEP WITH SYSTEM GOOOO                                  */
			/******************************************************************/
			if (sleepInCabin() && (flags[kFLAGS.SLEEP_WITH] == "" || flags[kFLAGS.SLEEP_WITH] == "Marble")) {
				outputText("You enter your cabin to turn yourself in for the night. ")
			}
			//Marble Sleepies
			if (marbleScene.marbleAtCamp() && player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.SLEEP_WITH] == "Marble" && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) {
				if (marbleScene.marbleNightSleepFlavor()) {
					sleepRecovery(false);
					return;
				}
			} else if (flags[kFLAGS.SLEEP_WITH] == "Alvina") {
				SceneLib.alvinaFollower.postMarriageSleep();
				return;
			} else if (flags[kFLAGS.SLEEP_WITH] == "Arian" && arianScene.arianFollower()) {
				arianScene.sleepWithArian();
				return;
			} else if (flags[kFLAGS.SLEEP_WITH] == "Zenji" && ZenjiScenes.isLover()) {
				spriteSelect(SpriteDb.s_zenji);
				if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0) {
					outputText("You approach Zenji, ready to call it a day and spend the rest of your night with him in your cabin.\n\n");
					outputText("As you approach him, you ask if he wouldn’t mind spending the night with you as well. Zenji caresses your cheek with his soft and fuzzy hand, \"<i>Of course, [name]. If dat is ya request, den who would I be ta deny it?</i>\" His hand slides down to your shoulder, giving it a gentle squeeze before letting you go.\n\n");
					outputText("You grab onto Zenji’s hand, to which he responds by giving your palm a gentle squeeze. After a moment of holding his hand you realize what you were about to do and lead him to your cabin. Breaking the hand hold, he opens the door for you, letting you in first as you guide him to your bedroom.\n\n");
					outputText("You take off your [armor], leaving you "+(player.isNaked2() ? "completely naked":"left in your underwear")+", Zenji strips off his loincloth, getting comfortable with you as well. It doesn't take long before he begins sporting an erection, you consider for a moment if you want to have sex with him before bed.");
					menu();
					if (player.hasVagina()) addButton(1, "Get Penetrated", curry(SceneLib.zenjiScene.loverZenjiSleepWithGetPenetrated, timeQ));
					else addButtonDisabled(1, "Get Penetrated", "You need a vagina for this scene.");
					addButton(2,"Catch Anal", curry(SceneLib.zenjiScene.loverZenjiSleepWithCatchAnal, timeQ));
					addButton(3,"No Sex", curry(SceneLib.zenjiScene.loverZenjiSleepWithNoSex, timeQ));
				}
				else {
					outputText("You approach Zenji, ready to call it a day, and spend the rest of the night with him.\n\n");
					outputText("As you approach, you ask him if he has any room in his bedroll for you. Zenji gives a wary glance around the camp, \"<i>Alright, [name], I will watch over you tonight, but I don’ wanna do anyting else. It doesn't feel safe letting my guard down when it’s so late, especially out in de open.</i>\"\n\n");
					outputText("You sigh, you suppose that if you had somewhere safe to sleep in during the night he’d be more open to doing something with you. At least it’s better than sleeping alone.\n\n");
					outputText("You curl up with Zenji in his sleeping roll, planning on sleeping for " + num2Text(timeQ) + " hours.");
					if (player.tailType != Tail.NONE) outputText(" As you lie beside him, you feel his tail coil around you, you reflexively bring your [tail] to tangle with his, the two of you locking tails each other.");
					else outputText(" As you lie beside him, you can feel his tail coil around you, protectively stroking your [legs].");
					if (player.tailType == Tail.FOX) outputText(" You hate to admit it, but Zenji’s tail just might almost kind of rival yours in terms of how soft and cuddly it is.");
					outputText("\n\nHe pulls you closer to his fuzzy body, \"<i>Good night, [name].</i>\"\n\n");
					if (silly() && rand(5) == 0) {
						outputText("You are jolted awake by a strange sound in the middle of the night. Fear overwhelms you for a moment as you survey your surroundings, but your cabin is empty. You remain wary for a moment, not willing to rest easy just yet.\n\n");
						outputText("You nearly jump by the faint sound of groaning from beneath you. You cautiously peer over the edge of the mattress to be met with Zenji rubbing the side of his head softly.\n\n");
						outputText("He looks up at you, \"<i>Ack, [name]... Ya kicked me off de bed...</i>\"\n\n");
						outputText("You apologize as you help him back up with you.\n\n");
						outputText("\"<i>No worries, I'll just be sure t' keep ya tighter in my arms so ya don't try to kick me away again. Heheh...</i>\"\n\n");
						outputText("With that, Zenji wraps his strong arms around you as you ready yourself to sleep for another " + num2Text(timeQ) + " hours.\n");
					}
					menu();
					addButton(0,"Next", sleepWrapper);
				}
				return;
			} else if (flags[kFLAGS.SLEEP_WITH] == "Excellia" && flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) {
				outputText("When you head to bed for the night, Excellia is already there waiting. You lay down next to her and get comfortable. She wraps her arms around you and pulls you into her warm embrace nuzzling your neck.");
				outputText("\n\n\"<i>See you in the morning [name]...</i>\"\n");
			} else if (flags[kFLAGS.SLEEP_WITH] == "Luna" && flags[kFLAGS.LUNA_FOLLOWER] >= 4) {
				outputText("You head to bed, Luna following you. ");
				flags[kFLAGS.LUNA_JEALOUSY] -= (timeQ * 2);
				if (flags[kFLAGS.LUNA_JEALOUSY] < -timeQ) flags[kFLAGS.LUNA_JEALOUSY] = -timeQ;
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8 && flags[kFLAGS.LUNA_FOLLOWER] >= 9) {
					SceneLib.lunaFollower.sleepingFullMoon();
					return;
				} else outputText("Luna hugs you tightly, almost possessively so as you both doze off to sleep.");
			} else if (flags[kFLAGS.SLEEP_WITH] == "Samirah" && flags[kFLAGS.SAMIRAH_FOLLOWER] > 9) {
				outputText("As you both head to sleep, Samirah slithers to you and coils her tail around " + ((player.lowerBody == 3)? "yours" : "your lower half") + ", wrapping her arms around your torso as she rests her head on your shoulder. Her body is cold and she looks at you as if in a daze.");
				if (player.isNaga()) outputText(" She’s not alone either. It indeed took you a while to realise that you are also cold-blooded now. The cold night air sure puts you in a similar state as of late.");
				outputText("\n\n\"<i>Sweet dreams [name], till morning and sunshine come.</i>\"\n");
			} else if (flags[kFLAGS.SLEEP_WITH] == "Belisa" && BelisaFollower.BelisaInCamp) {
				outputText("You decide to sleep with Belisa tonight. You help her close up her shop, packing the bands away, and climb into her hammock/bed, putting a hand on her cheek. Belisa pulls you towards her, resting one of her pillows under each of your heads. She hugs your arm, head on your shoulder, and you can’t help but feel safe as she expertly pulls a light blanket over the two of you. ");
				outputText("She whispers a sweet \"<i>good night</i>\" to you, and you drift into sleep, a soft, sweet scent of cinnamon in your nostrils.");
			} else if (flags[kFLAGS.SLEEP_WITH] == "Etna" && flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) {
				SceneLib.etnaScene.sleepWithEtna();
				return;
			} else if (flags[kFLAGS.SLEEP_WITH] == "Tyrantia" && TyrantiaFollower.isLover()) {
				outputText("You decide to lie down next to Tyrantia, in her hutch. She wraps her muscular, fluffy arms around you, and you rest your head on one of her massive breasts. The soft tit is better than most pillows, and as Tyrantia pulls a massive, crudely made quilt over you both, you quickly warm up, sinking into a deep sleep.");
			} else if (flags[kFLAGS.SLEEP_WITH] == "Ember" && flags[kFLAGS.EMBER_AFFECTION] >= 75 && followerEmber()) {
				if (flags[kFLAGS.TIMES_SLEPT_WITH_EMBER] > 3) {
					outputText("You curl up next to Ember, planning to sleep for " + num2Text(timeQ) + " hour. Ember drapes one of " + emberScene.emberMF("his", "her") + " wing over you, keeping you warm.");
				} else {
					emberScene.sleepWithEmber();
					return;
				}
			} else if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 && jojoScene.pregnancy.isPregnant && jojoScene.pregnancy.event == 4 && player.hasCock() && flags[kFLAGS.SLEEP_WITH] == 0) {
				joyScene.hornyJoyIsPregnant();
				return;
			} else if (flags[kFLAGS.SLEEP_WITH] == "Sophie" && (bimboSophie() || sophieFollower()) && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
				//Night Time Snuggle Alerts!*
				//(1)
				if (rand(4) == 0) {
					outputText("You curl up next to Sophie, planning to sleep for " + num2Text(timeQ) + " hour");
					if (timeQ > 1) outputText("s");
					outputText(".  She wraps her feathery arms around you and nestles her chin into your shoulder.  Her heavy breasts cushion flat against your back as she gives you a rather chaste peck on the cheek and drifts off towards dreamland...");
				}
				//(2)
				else if (rand(3) == 0) {
					outputText("While you're getting ready for bed, you see that Sophie has already beaten you there.  She's sprawled out on her back with her arms outstretched, making little beckoning motions towards the valley of her cleavage.  You snuggle in against her, her pillowy breasts supporting your head and her familiar heartbeat drumming you to sleep for " + num2Text(timeQ) + " hour");
					if (timeQ > 1) outputText("s");
					outputText(".");
				}
				//(3)
				else if (rand(2) == 0) {
					outputText("As you lay down to sleep for " + num2Text(timeQ) + " hour");
					if (timeQ > 1) outputText("s");
					outputText(", you find the harpy-girl, Sophie, snuggling herself under her blankets with you.  She slips in between your arms and guides your hands to her enormous breasts, her backside already snug against your loins.  She whispers, \"<i>Something to think about for next morning...  Sweet dreams.</i>\" as she settles in for the night.");
				}
				//(4)
				else {
					outputText("Sophie climbs under the sheets with you when you go to sleep, planning on resting for " + num2Text(timeQ) + " hour");
					if (timeQ > 1) outputText("s");
					outputText(".  She sleeps next to you, just barely touching you.  You rub her shoulder affectionately before the two of you nod off.");
				}
				outputText("\n");
			} else if (flags[kFLAGS.SLEEP_WITH] == "Helia" && SceneLib.helScene.followerHel()) {
				outputText("You curl up next to Helia, planning to sleep for " + num2Text(timeQ) + " ");
			} else {
				//Normal sleep message
				if (player.isGargoyle()) {
					outputText("You sit on your pedestal, your body petrifying like stone as you sleep for " + num2Text(timeQ) + " ");
					if (timeQ == 1) outputText("hour.\n");
					else outputText("hours.\n")
					sleepRecovery(false);
				}
				else if (player.isHarpy()) {
					outputText("You lay down in your nest");
					if (SophieFollowerScene.HarpyEggHatching) outputText(", spreading your wings protectively over your egg to keep it warm ");
					outputText(" as you sleep for " + num2Text(timeQ) + " ");
					if (timeQ == 1) outputText("hour.\n");
					else outputText("hours.\n")
				}
				else if (player.isRaceCached(Races.IMP, 3)) {
					outputText("Done with your day you open the tome and dive into the security of your personal sanctuary. ");
					if (player.perkv1(PerkLib.ImpNobility) < 5) outputText("Nalcanthet quarters include a luxurious bed for your convenience and you are keen on using it.");
					else outputText("You order your subjects to prepare a throne for you by stacking their tiny bodies on top of one another for you to rest on. They are quick to comply and soon the imp throne is readied. Satisfied with the result you sit down on the impromptu throne.[pg]");
					if (player.perkv1(PerkLib.ImpNobility) >= 5) {
						if (player.hasVagina()) outputText(" You tap the imp in charge of the back area then whisper to his ears to harden up and fuck your pussy gently. If for any reason including him thrusting too fast or roughly you have to wake up early, he will suffer punishment. Without need to be told twice the lesser imp's cock hardens on the spot and slides seamlessly into your royal snatch, his corrupt pre tingling your passage most comfortably.[pg]");
						outputText((player.hasCock()? (player.hasVagina()?"With your wet passage taken good care of you":"You"):""));
						if (player.hasCock()) outputText(" then call out to the imp underneath you ordering him to offer his ass to sleeve your hardening cock and move on his own so that you can relax. Soon his cheeks wraps around your [cock], massaging you at a slow and steady rhythm.[pg]");
					}
					outputText("Satisfied with the current arrangements you head to sleep.");
				}
				else{
					outputText("You curl up, planning to sleep for " + num2Text(timeQ) + " ");
					if (timeQ == 1) outputText("hour.\n");
					else outputText("hours.\n");
				}
			}
			sleepRecovery(true);
		} else {
			clearOutput();
			if (timeQ != 1) outputText("You lie down to resume sleeping for the remaining " + num2Text(timeQ) + " hours.\n");
			else outputText("You lie down to resume sleeping for the remaining hour.\n");
		}
		player.updateRacialAndPerkBuffs();
		goNext(true);
	}

//For shit that breaks normal sleep processing.
	public function sleepWrapper(multiplier:Number = 1.0):void {
		timeQ = (model.time.hours < 6 ? 6 : 24 + 6) - model.time.hours;
		if (flags[kFLAGS.BENOIT_CLOCK_ALARM] > 0 && (flags[kFLAGS.SLEEP_WITH] == "Ember" || flags[kFLAGS.SLEEP_WITH] == 0)) CoC.instance.timeQ += (flags[kFLAGS.BENOIT_CLOCK_ALARM] - 6);
		clearOutput();
		if (timeQ != 1) outputText("You lie down to resume sleeping for the remaining " + num2Text(timeQ) + " hours.\n");
		else outputText("You lie down to resume sleeping for the remaining hour.\n");
		sleepRecovery(true, multiplier);
		goNext(true);
	}

	public function cheatSleepUntilMorning(multiplier:Number = 1.0):void {
		var timeToSleep:int = (model.time.hours < 6 ? 6 : 24 + 6) - model.time.hours;
		CoC.instance.timeQ = timeToSleep;
		camp.sleepRecovery(true, multiplier);
		outputText("<b>" + NUMBER_WORDS_CAPITAL[timeToSleep] + " hours pass...</b>\n\n");
	}

	public function sleepRecovery(display:Boolean = false, multiplier:Number = 1.0):void {
		var fatRecovery:Number = 20;
		var hpRecovery:Number = 20;
		if (player.level >= 24) {
			fatRecovery += 10;
			hpRecovery += 10;
		}
		if (player.level >= 42) {
			fatRecovery += 10;
			hpRecovery += 10;
		}
		if (sleepInCabin()) {
			multiplier += 0.5;
		}
		if (player.hasPerk(PerkLib.SpeedyRecovery)) fatRecovery += 5;
		if (player.hasPerk(PerkLib.SpeedyRecuperation)) fatRecovery += 10;
		if (player.hasPerk(PerkLib.SpeedyRejuvenation)) fatRecovery += 20;
		if (player.hasPerk(PerkLib.ControlledBreath)) fatRecovery *= 1.1;
		if (player.hasStatusEffect(StatusEffects.BathedInHotSpring)) fatRecovery *= 1.2;
		if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) fatRecovery *= 3;
		if (flags[kFLAGS.HUNGER_ENABLED] > 0) {
			if (player.hunger < 25) {
				outputText("\nYou have difficulty sleeping as your stomach is growling loudly.\n");
				multiplier *= 0.5;
			}
		}
		//Ayane
		if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) {
			if (timeQ != 1) outputText("\nYou tell Ayane you are planning to sleep for a few hours. The devoted priestess pulls a magnificent bed out of her bag of infinite holding and tends to your wounds if any.\n");
			else outputText("\nYou tell Ayane you are planning to sleep for an hour. The devoted priestess pulls a magnificent bed out of her bag of infinite holding and tends to your wounds if any.\n");
		}
		//Marble withdrawl
		if (player.hasStatusEffect(StatusEffects.MarbleWithdrawl)) {
			if (display) outputText("\nYour sleep is very troubled, and you aren't able to settle down.  You get up feeling tired and unsatisfied, always thinking of Marble's milk.\n");
			multiplier *= 0.5;
			dynStats("tou", -.1, "int", -.1);
		}
		//Mino withdrawal
		else if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) {
			if (display) outputText("\nYou spend much of the night tossing and turning, aching for a taste of minotaur cum.\n");
			multiplier *= 0.75;
		}
		//Bee cock
		if (player.hasCock() && player.cocks[0].cockType == CockTypesEnum.BEE) {
			outputText("\nThe desire to find the bee girl that gave you this cursed [cock] and have her spread honey all over it grows with each passing minute\n");
		}
		//Starved goo armor
		if (player.armor == armors.GOOARMR && flags[kFLAGS.VALERIA_FLUIDS] <= 0) {
			outputText("\nYou feel the fluid-starved goo rubbing all over your groin as if Valeria wants you to feed her.\n");
		}
		if (player.lowerBody == LowerBody.PLANT_FLOWER) {
			outputText("You lie down in your pitcher, dozing off for the night as you close off your petals to sleep.\n");
		}
		if (player.lowerBody == LowerBody.FLOWER_LILIRAUNE) {
			outputText("You and your twin sister lie down in your pitcher, dozing off for the night as you close off your petals to sleep. You hug her before closing your eyes.\n\n" +
					"\"<i>Good night, sis.</i>\"\n\n" +
					"\"<i>Good night.</i>\"\n\n");
		}
		//REGULAR HP/FATIGUE RECOVERY
		HPChange(acceleratingRecoveryFactor(timeQ, true) * hpRecovery * multiplier, display);
		//fatigue
		fatigue(-(timeQ * fatRecovery * multiplier));
	}

//Bad End if your balls are too big. Only happens in Realistic Mode.
	public function badEndGIANTBALLZ():void {
		clearOutput();
		outputText("You suddenly fall over due to your extremely large [balls].  You struggle to get back up but the size made it impossible.  Panic spreads throughout your mind and your heart races.\n\n");
		outputText("You know that you can't move and you're aware that you're going to eventually starve to death.");
		menu();
		if (player.hasItem(consumables.REDUCTO, 1)) {
			outputText("\n\nFortunately, you have some Reducto.  You can shrink your balls and get back to your adventures!");
			addButton(1, "Reducto", applyReductoAndEscapeBadEnd);
		} else if (player.hasStatusEffect(StatusEffects.CampRathazul)) {
			outputText("\n\nYou could call for Rathazul to help you.");
			addButton(2, "Rathazul", callRathazulAndEscapeBadEnd);
		} else EventParser.gameOver();
	}

	private function applyReductoAndEscapeBadEnd():void {
		clearOutput();
		outputText("You smear the foul-smelling paste onto your " + sackDescript() + ".  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n");
		player.ballSize -= (4 + rand(6));
		if (player.ballSize > 18 + (player.str / 2) + (player.tallness / 4)) player.ballSize = 17 + (player.str / 2) + (player.tallness / 4);
		if (player.ballSize < 1) player.ballSize = 1;
		outputText("You feel your scrotum shift, shrinking down along with your [balls].  ");
		outputText("Within a few seconds the paste has been totally absorbed and the shrinking stops.  ");
		dynStats("lus", -10, "scale", false);
		player.consumeItem(consumables.REDUCTO, 1);
		doNext(camp.returnToCampUseOneHour);
	}

	private function callRathazulAndEscapeBadEnd():void {
		clearOutput();
		outputText("You shout as loud as you can to call Rathazul.  Your call is answered as the alchemist walks up to you.\n\n");
		outputText("\"<i>My, my... Look at yourself! Don't worry, I can help, </i>\" he says.  He rushes to his alchemy equipment and mixes ingredients.  He returns to you with a Reducto.\n\n");
		outputText("He rubs the paste all over your massive balls. It's incredibly effective. \n\n");
		player.ballSize -= (4 + rand(6));
		if (player.ballSize > 18 + (player.str / 2) + (player.basetallness / 4)) player.ballSize = 16 + (player.str / 2) + (player.basetallness / 4);
		if (player.ballSize < 1) player.ballSize = 1;
		outputText("You feel your scrotum shift, shrinking down along with your [balls].  ");
		outputText("Within a few seconds the paste has been totally absorbed and the shrinking stops.  ");
		outputText("\"<i>Try not to make your balls bigger. If it happens, make sure you have Reducto,</i>\" he says.  He returns to his alchemy equipment, working on who knows what.\n\n");
		doNext(camp.returnToCampUseOneHour);
	}

//Bad End if you starved to death.
	public function badEndHunger():void {
		clearOutput();
		player.hunger = 0.1; //For Easy Mode/Debug Mode.
		outputText("Too weak to be able to stand up, you collapse onto the ground. Your vision blurs as the world around you finally fades to black. ");
		if (companionsCount() > 0) {
			outputText("\n\n");
			if (companionsCount() > 1) {
				outputText("Your companions gather to mourn over your passing.");
			} else {
				outputText("Your fellow companion mourns over your passing.");
			}
		}
		player.HP = player.minHP();
		EventParser.gameOver();
		removeButton(1); //Can't continue, you're dead!
	}

//Bad End if you have 100 min lust.
	public function badEndMinLust():void {
		clearOutput();
		outputText("The thought of release overwhelms you. You frantically remove your [armor] and begin masturbating furiously.  The first orgasm hits you but the desire persists.  You continue to masturbate but unfortunately, no matter how hard or how many times you orgasm, your desires will not go away.  Frustrated, you keep masturbating furiously but you are unable to stop.  Your minimum lust is too high.  No matter how hard you try, you cannot even satisfy your desires.");
		outputText("\n\nYou spend the rest of your life masturbating, unable to stop.");
		player.orgasm();
		EventParser.gameOver();
		removeButton(1); //Can't wake up, must load.
	}

	private function dungeonFound():Boolean { //Returns true as soon as any known dungeon is found
		return flags[kFLAGS.FACTORY_FOUND] > 0
			|| flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0
			|| flags[kFLAGS.DEMON_LABORATORY_DISCOVERED] > 0
			|| flags[kFLAGS.D3_DISCOVERED] > 0
			|| flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0
			|| SceneLib.dungeons.checkPhoenixTowerClear()
			|| flags[kFLAGS.EBON_LABYRINTH] > 0
			|| flags[kFLAGS.HIDDEN_CAVE_FOUND] > 0
			|| flags[kFLAGS.DEN_OF_DESIRE_BOSSES] > 0
			|| flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] > 0
			|| flags[kFLAGS.LUMI_MET] > 0
			|| flags[kFLAGS.ANZU_PALACE_UNLOCKED] > 0;
	}

	private function farmFound():Boolean { //Returns true as soon as any known dungeon is found
		if (player.hasStatusEffect(StatusEffects.MetWhitney) && player.statusEffectv1(StatusEffects.MetWhitney) > 1) {
			if (flags[kFLAGS.FARM_DISABLED] == 0) return true;
			if (player.cor >= 70 && player.level >= 12 && SceneLib.farm.farmCorruption.corruptFollowers() >= 2 && flags[kFLAGS.FARM_CORRUPTION_DISABLED] == 0) return true;
		}
		return flags[kFLAGS.FARM_CORRUPTION_STARTED];
	}

//-----------------
//-- PLACES MENU
//-----------------
	private function placesKnown():Boolean { //Returns true as soon as any known place is found
		return placesCount() > 0;
	}

	public function placesCount():int {
		var places:int = 0;
		if (flags[kFLAGS.BAZAAR_ENTERED] > 0) places++;
		if (flags[kFLAGS.FOUND_CATHEDRAL] > 0) places++;
		if (flags[kFLAGS.FACTORY_FOUND] >= 0 || flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0 || flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0) places++;
		if (farmFound()) places++;
		if (flags[kFLAGS.OWCA_UNLOCKED] > 0) places++;
		if (player.hasStatusEffect(StatusEffects.HairdresserMeeting)) places++;
		if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) places++;
		if (flags[kFLAGS.AMILY_VILLAGE_ACCESSIBLE] > 0) places++;
		if (flags[kFLAGS.MET_MINERVA] >= 4) places++;
		if (flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED] > 0) places++;
		if (flags[kFLAGS.HEXINDAO_UNLOCKED] > 0) places++;
		if (flags[kFLAGS.DILAPIDATED_SHRINE_UNLOCKED] > 1) places++;
		if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] > 0) places++;
		if (flags[kFLAGS.YU_SHOP] == 2) places++;
		if (flags[kFLAGS.THE_TRENCH_ENTERED] > 0) places++;
		if (player.hasStatusEffect(StatusEffects.ResourceNode1)) {
			if (player.statusEffectv1(StatusEffects.ResourceNode1) >= 5) places++;
			if (player.statusEffectv2(StatusEffects.ResourceNode1) >= 5) places++;
		}
		return places;
	}

//All cleaned up!

	public function places():void {
		hideMenus();
		clearOutput();
		outputText("Which place would you like to visit?\n");
		if (flags[kFLAGS.EXPLORE_MENU_STYLE] == 1) {
			oldPlacesMenu();
			return;
		}

		menu();

		var bd:ButtonDataList = new ButtonDataList();
		// Row 1 - towns 1-5
		bd.add("He'Xin'Dao", SceneLib.hexindao.riverislandVillageStuff0)
				.hint("Visit the village of He'Xin'Dao, a place where all greenhorn soul cultivators come together.")
				.disableIf(flags[kFLAGS.HEXINDAO_UNLOCKED]<1, "Explore the realm.", null, "???")
		bd.add("Tel'Adre", SceneLib.telAdre.visitTelAdre)
				.hint("Visit the city of Tel'Adre in desert, easily recognized by the massive tower.")
				.disableIf(player.statusEffectv1(StatusEffects.TelAdre) < 1, "Explore the realm.", null, "???");
		bd.add("Bazaar", SceneLib.bazaar.enterTheBazaar)
				.hint("Visit the Bizarre Bazaar where the demons and corrupted beings hang out.")
				.disableIf(flags[kFLAGS.BAZAAR_ENTERED] <= 0, "Explore the realm.", null, "???");
		bd.add("Owca", SceneLib.owca.gangbangVillageStuff)
				.hint("Visit the sheep village of Owca, known for its pit where a person is hung on the pole weekly to be gang-raped by the demons.")
				.disableIf(flags[kFLAGS.OWCA_UNLOCKED] != 1, "Search the plains (at late afternoon to ealry evening hours).", null, "???");
		bd.add("Troll Village", SceneLib.trollVillage.EnterTheVillage)
				.hint("Visit the Troll Village.")
				.disableIf(TrollVillage.ZenjiVillageStage <= 0, "You have not visited this place yet.", null, "???");
		// Row 2 - towns/places/NPCs 1-5
		bd.add("The Trench", SceneLib.theTrench.theTrenchEntrance)
				.hint("Visit the Trench where the Arigeans hang out.")
				.disableIf(flags[kFLAGS.THE_TRENCH_ENTERED] <= 0, "Only for Arigeans.", null, "???");
		bd.add("Lumi's Lab", SceneLib.lumi.lumiEncounter)
				.hint("Visit Lumi's laboratory.")
				.disableIf(flags[kFLAGS.LUMI_MET] <= 0, "Explore the realm", null, "???");
		bd.add("Town Ruins", SceneLib.amilyScene.exploreVillageRuin)
				.hint("Visit the village ruins. \n\nRecommended level: 12")
				.disableIf(!flags[kFLAGS.AMILY_VILLAGE_ACCESSIBLE], "Search the lake.", null, "???");
		bd.add("Farm", SceneLib.farm.farmExploreEncounter)
				.hint("Visit Whitney's farm.")
				.disableIf(!farmFound(), "Search the lake.", null, "???");
		bd.add("Marae", maraeIsland)
				.hint("Visit Marae's Island in middle of the Lake.")
				.disableIf(flags[kFLAGS.MARAE_ISLAND] <= 0, "Search the lake on the boat.", null, "???")
		// Row 3 - places/NPCs 6-10
		bd.add("Salon", SceneLib.mountain.salon.salonGreeting)
				.hint("Visit the salon for hair services.")
				.disableIf(!player.hasStatusEffect(StatusEffects.HairdresserMeeting), "Search the mountains.", null, "???");
		bd.add("Eldritch Caves", SceneLib.mindbreaker.CaveLayout)
				.hint("Visit the mindbreaker lair.")
				.disableIf(Mindbreaker.MindBreakerQuest != Mindbreaker.QUEST_STAGE_ISMB,"???", null,"???");
		bd.add("Temple", SceneLib.templeofdivine.repeatvisitintro)
				.hint("Visit the temple in the high mountains where Sapphire resides.")
				.disableIf(!flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE], "Search the high mountains.", null, "???");
		bd.add("Chicken Harpy", SceneLib.mountain.chickenHarpy)
				.hint("Visit Chicken Harpy in the High Mountains.")
				.disableIf(!player.hasItem(consumables.OVIELIX), "You need to have at least 1-2 ovi elixirs to have reason to look for her.")
				.disableIf(flags[kFLAGS.TIMES_MET_CHICKEN_HARPY] <= 1, "Search the high mountains with ovi elixir.", null, "???");
		bd.add("Oasis Tower", SceneLib.mountain.minervaScene.encounterMinerva)
				.hint("Visit the ruined tower in the mountains where Minerva resides.")
				.disableIf(flags[kFLAGS.MET_MINERVA] < 4, "Search the mountains.", null, "???");
		// Row 4 - places/NPCs 11-15
		bd.add("Elven grove", SceneLib.woodElves.GroveLayout)
				.hint("Visit the elven grove where the wood elves spend their somewhat idylic lives.")
				.disableIf(WoodElves.WoodElvesQuest < 5, "Search the forest", null, "???");
		bd.add("Shrine", SceneLib.kitsuneScene.kitsuneShrine)
				.hint("Visit the kitsune shrine in the deepwoods.")
				.disableIf(!flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED], "Search the deepwoods", null, "???");
		bd.add("Great Tree", SceneLib.aikoScene.encounterAiko)
				.hint("Visit the Great Tree in the Deep Woods where Aiko lives.")
				.disableIf(flags[kFLAGS.AIKO_TIMES_MET] <= 3, "???", null, "???");
		bd.add("Dilapid.Shrine", SceneLib.dilapidatedShrine.repeatvisitshrineintro)
				.hint("Visit the dilapidated shrine where the echoses of the golden age of gods still lingers.")
				.disableIf(flags[kFLAGS.DILAPIDATED_SHRINE_UNLOCKED] <= 1, "Search the battlefield. (After hearing an npc mention this place)", null, "???");
		bd.add("Winter Gear", SceneLib.glacialYuShop.YuIntro)
				.hint("Visit the Winter gear shop.")
				.disableIf(flags[kFLAGS.YU_SHOP] != 2, "Search the (outer) glacial rift.",null, "???");
		// Row 5 - places/NPCs 16-20
		bd.add("Anzu's Palace", SceneLib.dungeons.anzupalace.enterDungeon)
				.hint("Visit the palace in the Glacial Rift where Anzu the avian deity resides.")
				.disableIf(flags[kFLAGS.ANZU_PALACE_UNLOCKED] <= 0, "???", null, "???");
		bd.add("Cathedral", SceneLib.gargoyle.gargoyleRouter)
				.hint(flags[kFLAGS.GAR_NAME] == 0
						? "Visit the ruined cathedral you've recently discovered."
						: "Visit the ruined cathedral where " + flags[kFLAGS.GAR_NAME] + " resides.")
				.disableIf(!flags[kFLAGS.FOUND_CATHEDRAL], "Explore the realm", null, "???");
		bd.add("Woodcutting", camp.cabinProgress.gatherWoods)
				.hint("You need to explore Forest more to unlock this place.")
				.disableIf(player.statusEffectv1(StatusEffects.ResourceNode1) < 5, "You need to explore Forest more to unlock this place.", null, "???")
				.disableIf(!player.hasStatusEffect(StatusEffects.ResourceNode1), "Search the forest.", null, "???");
		bd.add("Quarry", camp.cabinProgress.quarrySite)
				.hint("You can mine here to get stones, gems and maybe even some ores. <b>(Daylight)</b>")
				.disableIf(player.statusEffectv2(StatusEffects.ResourceNode1) < 5, "You need to explore Mountains more to unlock this place.", null, "???")
				.disableIf(!player.hasStatusEffect(StatusEffects.ResourceNode1), "Search the mountains.", null, "???");
		bd.add("");
		// Row 6 - separator between places and dungeons
		if (debug) {
			bd.add("Ingnam", SceneLib.ingnam.returnToIngnam)
					.hint("Return to Ingnam for debugging purposes. Night-time event weirdness might occur. You have been warned!");
		} else {
			bd.add("");
		}
		bd.add("");
		bd.add("");
		bd.add("");
		bd.add("");
		// Row 7 - dungeons 1-5
		bd.add("Factory", SceneLib.dungeons.factory.enterDungeon)
				.hint("Visit the demonic factory in the mountains."
						+ (flags[kFLAGS.FACTORY_SHUTDOWN] > 0 ? "\n\nYou've managed to shut down the factory." : "The factory is still running. Marae wants you to shut down the factory!")
						+ (SceneLib.dungeons.checkFactoryClear() ? "\n\nCLEARED!" : ""))
				.disableIf(flags[kFLAGS.FACTORY_FOUND] <= 0, "???", null, "???");
		bd.add("Deep Cave", SceneLib.dungeons.deepcave.enterDungeon)
				.hint("Visit the cave you've found in the Deepwoods."
						+ (flags[kFLAGS.DEFEATED_ZETAZ] > 0 ? "\n\nYou've defeated Zetaz, your old rival." : "")
						+ (SceneLib.dungeons.checkDeepCaveClear() ? "\n\nCLEARED!" : ""))
				.disableIf(flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] <= 0, "???", null, "???");
		bd.add("Demon Laboratory", SceneLib.dungeons.demonLab.EnteringDungeon)
				.hint("Visit the demon laboratory in the mountains."
						+ (SceneLib.dungeons.checkDemonLaboratoryClear() ? "\n\nYou have destroyed that laboratory and put an end to the demonic experiments. You've one step closer to defeating Lethice!\n\nCLEARED!" : ""))
				.disableIf(flags[kFLAGS.DEMON_LABORATORY_DISCOVERED] <= 0, "???", null, "???");
		bd.add("Stronghold", SceneLib.d3.enterD3)
				.hint("Visit the stronghold in the high mountains that belongs to Lethice, the demon queen."
						+ ((flags[kFLAGS.LETHICE_DEFEATED] > 0) ? "\n\nYou have slain Lethice and put an end to the demonic threats. Congratulations, you've beaten the main story!" : "")
						+ (SceneLib.dungeons.checkLethiceStrongholdClear() ? "\n\nCLEARED!" : ""))
				.disableIf(flags[kFLAGS.D3_DISCOVERED] <= 0, "???", null, "???");
		bd.add("Desert Cave", SceneLib.dungeons.desertcave.enterDungeon)
				.hint("Visit the cave you've found in the desert."
						+ (flags[kFLAGS.SAND_WITCHES_COWED] + flags[kFLAGS.SAND_WITCHES_FRIENDLY] > 0 ? "\n\nFrom what you've known, this is the source of the Sand Witches." : "")
						+ (SceneLib.dungeons.checkSandCaveClear() ? "\n\nCLEARED!" : ""))
				.disableIf(flags[kFLAGS.DESERT_CAVE_DISABLED], "You can't find the entrance. Maybe it's hidden. Or locked forever. Who knows?")
				.disableIf(flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] <= 0, "???", null, "???");
		bd.add("Phoenix Tower", SceneLib.dungeons.heltower.returnToHeliaDungeon)
				.hint("Re-visit the tower you went there as part of Helia's quest."
						+ (SceneLib.dungeons.checkPhoenixTowerClear() ? "\n\nYou've helped Helia in the quest and resolved the problems. \n\nCLEARED!" : ""))
				.disableIf(!SceneLib.dungeons.checkPhoenixTowerClear(), "???", null, "???");
		// Row 8 - dungeons 6-10
		bd.add("Hidden Cave", SceneLib.dungeons.hiddencave.enterDungeon)
				.hint("Visit the hidden cave in the hills."
						+ (SceneLib.dungeons.checkHiddenCaveClear() ? "\n\nCLEARED!" : ""))
				.disableIf(flags[kFLAGS.HIDDEN_CAVE_FOUND] <= 0, "???", null, "???");
		bd.add("Bee Hive", SceneLib.dungeons.beehive.enterDungeon)
				.hint("Visit the bee hive you've found in the forest."
						+ (flags[kFLAGS.TIFA_FOLLOWER] > 5 ? "\n\nYou've defeated all corrupted bees." : "")
						+ (SceneLib.dungeons.checkBeeHiveClear() ? "\n\nCLEARED!" : ""))
				.disableIf(flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] <= 0, "???", null, "???");
		bd.add("EbonLabyrinth", SceneLib.dungeons.ebonlabyrinth.enterDungeon)
				.hint("Visit Ebon Labyrinth."
						+ (SceneLib.dungeons.checkEbonLabyrinthClear() ? "\n\nSEMI-CLEARED!" : ""))
				.disableIf(flags[kFLAGS.EBON_LABYRINTH] <= 0, "???", null, "???");
		bd.add("Den of Desire", SceneLib.dungeons.denofdesire.enterDungeon)
				.hint("Visit the den in blight ridge."
						+ (SceneLib.dungeons.checkDenOfDesireClear() ? "\n\nCLEARED!" : ""))
				.disableIf(flags[kFLAGS.DEN_OF_DESIRE_BOSSES] <= 0, "???", null, "???");
		bd.add("");
		// Row 9 - spare
		// Row 10 - spare
		// Row 11 - spare
		// Row 12 - spare

		bigButtonGrid(bd);
		addButton(14, "Back", playerMenu);
	}

	public function oldPlacesMenu():Boolean {
		hideMenus();
		clearOutput();
		outputText("Which place would you like to visit?");
		//Build menu
		if (flags[kFLAGS.PLACES_PAGE] == 2) {
			placesPage3();
			return true;
		}
		if (flags[kFLAGS.PLACES_PAGE] == 1) {
			placesPage2();
			return true;
		}
		menu();
		if (dungeonFound()) addButton(0, "Dungeons", dungeons).hint("Delve into dungeons.");
		else addButtonDisabled(0, "???", "Find at least one dungeon.");
		//1 - ???
		if (flags[kFLAGS.MARAE_ISLAND] > 0) addButton(2, "Marae", maraeIsland).hint("Visit Marae's Island in middle of the Lake.");
		else addButtonDisabled(2, "???", "Search the lake on the boat.");
		addButton(4, "Next", placesPage2);

		if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) addButton(5, "Tel'Adre", SceneLib.telAdre.visitTelAdre).hint("Visit the city of Tel'Adre in desert, easily recognized by the massive tower.");
		else addButtonDisabled(5, "???", "Search the desert.");
		if (flags[kFLAGS.BAZAAR_ENTERED] > 0) addButton(6, "Bazaar", SceneLib.bazaar.enterTheBazaar).hint("Visit the Bizarre Bazaar where the demons and corrupted beings hang out.");
		else addButtonDisabled(6, "???", "Search the plains.");
		if (flags[kFLAGS.OWCA_UNLOCKED] == 1) addButton(7, "Owca", SceneLib.owca.gangbangVillageStuff).hint("Visit the sheep village of Owca, known for its pit where a person is hung on the pole weekly to be gang-raped by the demons.");
		else addButtonDisabled(7, "???", "Search the plains.");
		if (TrollVillage.ZenjiVillageStage > 0) addButton(8, "Troll Village", SceneLib.trollVillage.EnterTheVillage).hint("Visit the Troll Village.");
		else addButtonDisabled(8, "???", "Clear the factory first.");
		if (flags[kFLAGS.THE_TRENCH_ENTERED] > 0) addButton(9, "The Trench", SceneLib.theTrench.theTrenchEntrance).hint("Visit the Trench where the Arigeans hang out.");
		else addButtonDisabled(9, "???", "Only for Arigeans.");

		if (flags[kFLAGS.HEXINDAO_UNLOCKED] >= 1) addButton(10, "He'Xin'Dao", SceneLib.hexindao.riverislandVillageStuff0).hint("Visit the village of He'Xin'Dao, a place where all greenhorn soul cultivators come together.");
		else addButtonDisabled(10, "???", "Explore the realm.");
		if (flags[kFLAGS.TIMES_MET_CHICKEN_HARPY] > 1) {
			if (player.hasItem(consumables.OVIELIX)) addButton(11, "Chicken Harpy", SceneLib.mountain.chickenHarpy).hint("Visit Chicken Harpy in the High Mountains.");
			else addButtonDisabled(11, "Chicken Harpy", "You need to have at least 1-2 ovi elixirs to have reason to look for her.");
		}
		else addButtonDisabled(11, "???", "Search the high mountains with ovi elixir.");
		if (flags[kFLAGS.DILAPIDATED_SHRINE_UNLOCKED] > 1) addButton(12, "Dilapidated Shrine", SceneLib.dilapidatedShrine.repeatvisitshrineintro).hint("Visit the dilapidated shrine where the echoses of the golden age of gods still lingers.");
		else addButtonDisabled(12, "???", "Search the battlefield. (After hearing an npc mention this place)");
		if (WoodElves.WoodElvesQuest >= 5) addButton(13, "Elven grove", SceneLib.woodElves.GroveLayout).hint("Visit the elven grove where the wood elves spend their somewhat idylic lives.");
		else addButtonDisabled(13, "???", "Search the forest.");
		addButton(14, "Back", playerMenu);
		return true;
	}

	private function placesPage2():void {
		menu();
		flags[kFLAGS.PLACES_PAGE] = 1;
		if (flags[kFLAGS.FOUND_CATHEDRAL] > 0) {
			if (flags[kFLAGS.GAR_NAME] == 0) addButton(0, "Cathedral", SceneLib.gargoyle.gargoylesTheShowNowOnWBNetwork).hint("Visit the ruined cathedral you've recently discovered.");
			else addButton(0, "Cathedral", SceneLib.gargoyle.returnToCathedral).hint("Visit the ruined cathedral where " + flags[kFLAGS.GAR_NAME] + " resides.");
		}
		else addButtonDisabled(0, "???", "Explore the realm.");
		if (farmFound()) addButton(1, "Farm", SceneLib.farm.farmExploreEncounter).hint("Visit Whitney's farm.");
		else addButtonDisabled(1, "???", "Search the lake.");
		if (flags[kFLAGS.AMILY_VILLAGE_ACCESSIBLE] > 0) addButton(2, "Town Ruins", SceneLib.amilyScene.exploreVillageRuin).hint("Visit the village ruins. \n\nRecommended level: 12");
		else addButtonDisabled(2, "???", "Search the lake.");
		if (player.hasStatusEffect(StatusEffects.HairdresserMeeting)) addButton(3, "Salon", SceneLib.mountain.salon.salonGreeting).hint("Visit the salon for hair services.");
		else addButtonDisabled(3, "???", "Search the mountains.");
		addButton(4, "Next", placesPage3);

		if (flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED] > 0) addButton(5, "Shrine", SceneLib.kitsuneScene.kitsuneShrine).hint("Visit the kitsune shrine in the deepwoods.");
		else addButtonDisabled(5, "???", "Search the deepwoods.");
		if (flags[kFLAGS.MET_MINERVA] >= 4) addButton(6, "Oasis Tower", SceneLib.mountain.minervaScene.encounterMinerva).hint("Visit the ruined tower in the mountains where Minerva resides.");
		else addButtonDisabled(6, "???", "Search the mountains.");
		if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] > 0) addButton(7, "Temple", SceneLib.templeofdivine.repeatvisitintro).hint("Visit the temple in the high mountains where Sapphire resides.");
		else addButtonDisabled(7, "???", "Search the high mountains.");
		if (flags[kFLAGS.YU_SHOP] == 2) addButton(8, "Winter Gear", SceneLib.glacialYuShop.YuIntro).hint("Visit the Winter gear shop.");
		else addButtonDisabled(8, "???", "Search the (outer) glacial rift.");
		addButton(9, "Previous", placesToPage1);

		if (flags[kFLAGS.AIKO_TIMES_MET] > 3) addButton(10, "Great Tree", SceneLib.aikoScene.encounterAiko).hint("Visit the Great Tree in the Deep Woods where Aiko lives.");
		else addButtonDisabled(10, "???", "???");
		if (Mindbreaker.MindBreakerQuest == Mindbreaker.QUEST_STAGE_ISMB) addButton(11, "Eldritch Caves", SceneLib.mindbreaker.CaveLayout).hint("Visit the mindbreaker lair.");
		if (debug) addButton(13, "Ingnam", SceneLib.ingnam.returnToIngnam).hint("Return to Ingnam for debugging purposes. Night-time event weirdness might occur. You have been warned!");
		addButton(14, "Back", playerMenu);
	}

	private function placesPage3():void {
		menu();
		flags[kFLAGS.PLACES_PAGE] = 2;
		if (player.hasStatusEffect(StatusEffects.ResourceNode1)) {
			if (player.statusEffectv1(StatusEffects.ResourceNode1) < 5) addButtonDisabled(0, "???", "You need to explore Forest more to unlock this place.");
			else addButton(0, "Woodcutting", camp.cabinProgress.gatherWoods).hint("You can cut some trees here to get wood.");
			if (player.statusEffectv2(StatusEffects.ResourceNode1) < 5) addButtonDisabled(1, "???", "You need to explore Mountains more to unlock this place.");
			else addButton(1, "Quarry", camp.cabinProgress.quarrySite).hint("You can mine here to get stones, gems and maybe even some ores.");
		}
		else {
			addButtonDisabled(0, "???", "Search the forest.");
			addButtonDisabled(1, "???", "Search the mountains.");
		}

		addButton(9, "Previous", placesToPage2);
		addButton(14, "Back", playerMenu);
	}

	private function placesToPage1():void {
		flags[kFLAGS.PLACES_PAGE] = 0;
		places();
	}

	private function placesToPage2():void {
		flags[kFLAGS.PLACES_PAGE] = 1;
		placesPage2();
	}

	private function dungeons():void {
		menu();
		//Main story dungeons
		if (flags[kFLAGS.FACTORY_FOUND] > 0) addButton(0, "Factory", SceneLib.dungeons.factory.enterDungeon).hint("Visit the demonic factory in the mountains." + (flags[kFLAGS.FACTORY_SHUTDOWN] > 0 ? "\n\nYou've managed to shut down the factory." : "The factory is still running. Marae wants you to shut down the factory!") + (SceneLib.dungeons.checkFactoryClear() ? "\n\nCLEARED!" : ""));
		else addButtonDisabled(0, "???", "???");
		if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0) addButton(1, "Deep Cave", SceneLib.dungeons.deepcave.enterDungeon).hint("Visit the cave you've found in the Deepwoods." + (flags[kFLAGS.DEFEATED_ZETAZ] > 0 ? "\n\nYou've defeated Zetaz, your old rival." : "") + (SceneLib.dungeons.checkDeepCaveClear() ? "\n\nCLEARED!" : ""));
		else addButtonDisabled(1, "???", "???");
		if (flags[kFLAGS.DEMON_LABORATORY_DISCOVERED] > 0) addButton(2, "Demon Laboratory", SceneLib.dungeons.demonLab.EnteringDungeon).hint("Visit the demon laboratory in the mountains." + (SceneLib.dungeons.checkDemonLaboratoryClear() ? "\n\nYou have destroyed that laboratory and put an end to the demonic experiments. You've one step closer to defeating Lethice!\n\nCLEARED!" : ""));
		else addButtonDisabled(2, "???", "???");
		if (flags[kFLAGS.D3_DISCOVERED] > 0) addButton(3, "Stronghold", SceneLib.d3.enterD3).hint("Visit the stronghold in the high mountains that belongs to Lethice, the demon queen." + ((flags[kFLAGS.LETHICE_DEFEATED] > 0) ? "\n\nYou have slain Lethice and put an end to the demonic threats. Congratulations, you've beaten the main story!" : "") + (SceneLib.dungeons.checkLethiceStrongholdClear() ? "\n\nCLEARED!" : ""));
		else addButtonDisabled(3, "???", "???");
		//Side dungeons
		if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0 && !flags[kFLAGS.DESERT_CAVE_DISABLED]) addButton(5, "Desert Cave", SceneLib.dungeons.desertcave.enterDungeon).hint("Visit the cave you've found in the desert." + (flags[kFLAGS.SAND_WITCHES_COWED] + flags[kFLAGS.SAND_WITCHES_FRIENDLY] > 0 ? "\n\nFrom what you've known, this is the source of the Sand Witches." : "") + (SceneLib.dungeons.checkSandCaveClear() ? "\n\nCLEARED!" : ""));
		else if (flags[kFLAGS.DESERT_CAVE_DISABLED]) addButtonDisabled(5, "Desert Cave", "You can't find the entrance. Maybe it's hidden. Or locked forever. Who knows?");
		else addButtonDisabled(5, "???", "???");
		if (flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] > 0) addButton(6, "Bee Hive", SceneLib.dungeons.beehive.enterDungeon).hint("Visit the bee hive you've found in the forest." + (flags[kFLAGS.TIFA_FOLLOWER] > 5 ? "\n\nYou've defeated all corrupted bees." : "") + (SceneLib.dungeons.checkBeeHiveClear() ? "\n\nCLEARED!" : ""));
		else addButtonDisabled(6, "???", "???");
		if (SceneLib.dungeons.checkPhoenixTowerClear()) addButton(7, "Phoenix Tower", SceneLib.dungeons.heltower.returnToHeliaDungeon).hint("Re-visit the tower you went there as part of Helia's quest." + (SceneLib.dungeons.checkPhoenixTowerClear() ? "\n\nYou've helped Helia in the quest and resolved the problems. \n\nCLEARED!" : ""));
		else addButtonDisabled(7, "???", "???");
		if (flags[kFLAGS.EBON_LABYRINTH] > 0) addButton(9, "EbonLabyrinth", SceneLib.dungeons.ebonlabyrinth.enterDungeon).hint("Visit Ebon Labyrinth." + (SceneLib.dungeons.checkEbonLabyrinthClear() ? "\n\nSEMI-CLEARED!" : ""));
		else addButtonDisabled(9, "???", "???");
		if (flags[kFLAGS.HIDDEN_CAVE_FOUND] > 0) addButton(10, "Hidden Cave", SceneLib.dungeons.hiddencave.enterDungeon).hint("Visit the hidden cave in the hills." + (SceneLib.dungeons.checkHiddenCaveClear() ? "\n\nCLEARED!" : ""));
		else addButtonDisabled(10, "???", "???");
		if (flags[kFLAGS.DEN_OF_DESIRE_BOSSES] > 0) addButton(11, "Den of Desire", SceneLib.dungeons.denofdesire.enterDungeon).hint("Visit the den in blight ridge." + (SceneLib.dungeons.checkDenOfDesireClear() ? "\n\nCLEARED!" : ""));
		else addButtonDisabled(11, "???", "???");
		if (flags[kFLAGS.LUMI_MET] > 0) addButton(12, "Lumi's Lab", SceneLib.lumi.lumiEncounter).hint("Visit Lumi's laboratory.");
		else addButtonDisabled(12, "???", "???");
		if (flags[kFLAGS.ANZU_PALACE_UNLOCKED] > 0) addButton(13, "Anzu's Palace", SceneLib.dungeons.anzupalace.enterDungeon).hint("Visit the palace in the Glacial Rift where Anzu the avian deity resides.");
		else addButtonDisabled(13, "???", "???");
		addButton(14, "Back", places);
	}

	private function maraeIsland():void {
		menu();
		addButtonIfTrue(0, "Visit", SceneLib.boat.marae.visitSelector, "You can't do that currently.", SceneLib.boat.marae.canVisit(), "Normal visit.");
		addButtonIfTrue(1, "Minerva", SceneLib.boat.marae.talkToMaraeAboutMinervaPurification, "",
			flags[kFLAGS.FACTORY_SHUTDOWN] == 1 && flags[kFLAGS.MARAE_QUEST_COMPLETE] >= 1 && flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] == 1,
			"Visit godess island to talk about help for Minerva.");
		addButtonIfTrue(2, "Alraune", SceneLib.boat.marae.alraunezeMe, "Req. to have a fully grown Holli and to have high Alraune racial score. Also, don't kill Marae please.",
			(Races.PLANT.basicScore(player.bodyData()) >= 7) && (player.gender == 2 || player.gender == 3) && flags[kFLAGS.FACTORY_SHUTDOWN] > 0 &&
			(flags[kFLAGS.FUCK_FLOWER_LEVEL] == 4 || flags[kFLAGS.FLOWER_LEVEL] == 4) && flags[kFLAGS.CORRUPTED_MARAE_KILLED] == 0,
			"Visit godess island to turn yourself into Alraune.");
		addButton(4, "Back", places);
	}

//Wake up from a bad end.
public function wakeFromBadEnd():void {
	clearOutput();
	EventParser.badEnded = false;
	trace("Escaping bad end!");
	outputText("No, it can't be.  It's all just a dream!  You've got to wake up!");
	outputText("\n\nYou wake up and scream.  You pull out a mirror and take a look at yourself.  Yep, you look normal again.  That was the craziest dream you ever had.");
	if (flags[kFLAGS.TIMES_BAD_ENDED] >= 2) { //FOURTH WALL BREAKER
		outputText("\n\nYou mumble to yourself \"<i>Another goddamn bad-end.</i>\"");
	}
	if (marbleFollower()) outputText("\n\n\"<i>Are you okay, sweetie?</i>\" Marble asks.  You assure her that you're fine; you've just had a nightmare.");
	if (flags[kFLAGS.HUNGER_ENABLED] > 0) player.hunger = 40;
	if (flags[kFLAGS.HUNGER_ENABLED] >= 1 && player.ballSize > (18 + (player.str / 2) + (player.tallness / 4))) {
		outputText("\n\nYou realize the consequences of having oversized balls and you NEED to shrink it right away. Reducto will do.");
		player.ballSize = (14 + (player.str / 2) + (player.tallness / 4));
		if (player.ballSize < 1) player.ballSize = 1;
	}
	outputText("\n\nYou get up, still feeling traumatized from the nightmares.");
	//Skip time forward
	var timeskip:Number = 24;
	if (flags[kFLAGS.BENOIT_CLOCK_BOUGHT] > 0) timeskip += flags[kFLAGS.BENOIT_CLOCK_ALARM];
	else timeskip += 6;
	CoC.instance.timeQ = timeskip - model.time.hours;
	camp.sleepRecovery(true);
	CoC.instance.timeQ = 0;
	//Set so you're in camp.
	inDungeon = false;
	inRoomedDungeon = false;
	inRoomedDungeonResume = null;
    CoC.instance.inCombat = false;
	player.removeStatusEffect(StatusEffects.RiverDungeonA);
	if (player.hasStatusEffect(StatusEffects.RivereDungeonIB)) player.removeStatusEffect(StatusEffects.RivereDungeonIB);
	if (player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.removeStatusEffect(StatusEffects.ThereCouldBeOnlyOne);
    //Restore stats
	player.HP = player.maxOverHP();
	player.fatigue = 0;
	statScreenRefresh();
	//PENALTY!
	var penaltyMultiplier:int = 1;
	penaltyMultiplier += flags[kFLAGS.GAME_DIFFICULTY] * 0.5;
	//Deduct XP and gems.
	player.gems -= int((player.gems / 10) * penaltyMultiplier);
	player.XP -= int((player.level * 10) * penaltyMultiplier);
	if (player.gems < 0) player.gems = 0;
	if (player.XP < 0) player.XP = 0;
	menu();
	addButton(0, "Next", doCamp);//addButton(0, "Next", playerMenu);
}

//Moving nascent soul to your clone body
public function rebirthFromBadEnd():void {
	clearOutput();
	EventParser.badEnded = false;
	trace("Escaping bad end!");
	outputText("No... Not like this! Your quest is... not... over..!");
	outputText("\n\nYour nascent soul leaves your body, and unfetteredly escapes back to [camp] where it finds your clone and fuse with it. A pang of mental pain hits you after the sacrifice. After a moment of disorientation, you consider whether or not you should make another.");
	if (silly()) outputText(" With another chance, you know your journey is far from over. You still have so much to do.");
	if (flags[kFLAGS.HUNGER_ENABLED] > 0) player.hunger = 40;
	if (flags[kFLAGS.HUNGER_ENABLED] >= 1 && player.ballSize > (18 + (player.str / 2) + (player.tallness / 4))) {
		outputText("\n\nYou realize the consequences of having oversized balls and you NEED to shrink it right away. Reducto will do.");
		player.ballSize = (14 + (player.str / 2) + (player.tallness / 4));
		if (player.ballSize < 1) player.ballSize = 1;
	}
	//Skip time forward
	model.time.days++;
	if (flags[kFLAGS.BENOIT_CLOCK_BOUGHT] > 0) model.time.hours = flags[kFLAGS.BENOIT_CLOCK_ALARM];
	else model.time.hours = 6;
	//Set so you're in camp.
	inDungeon = false;
	inRoomedDungeon = false;
	inRoomedDungeonResume = null;
    CoC.instance.inCombat = false;
	player.removeStatusEffect(StatusEffects.RiverDungeonA);
	if (player.hasStatusEffect(StatusEffects.RivereDungeonIB)) player.removeStatusEffect(StatusEffects.RivereDungeonIB);
	if (player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.removeStatusEffect(StatusEffects.ThereCouldBeOnlyOne);
    //Restore stats
	player.HP = player.maxOverHP();
	player.fatigue = 0;
	statScreenRefresh();
	player.addStatusValue(StatusEffects.PCClone, 3, -1);
	if (player.statusEffectv3(StatusEffects.PCClone) <= 0) player.removeStatusEffect(StatusEffects.PCClone);
	if (player.hasStatusEffect(StatusEffects.PCClone4th)) player.removeStatusEffect(StatusEffects.PCClone4th);
	else if (player.hasStatusEffect(StatusEffects.PCClone3rd)) player.removeStatusEffect(StatusEffects.PCClone3rd);
	else if (player.hasStatusEffect(StatusEffects.PCClone2nd)) player.removeStatusEffect(StatusEffects.PCClone2nd);
	else player.removeStatusEffect(StatusEffects.PCClone1st);
	menu();
	addButton(0, "Next", doCamp);//addButton(0, "Next", playerMenu);
}

//Camp wall
	private function buildCampWallPrompt():void {
		clearOutput();
		if (player.fatigue >= player.maxFatigue() - 50) {
			outputText("You are too exhausted to work on your [camp] wall!");
			doNext(doCamp);
			return;
		}
		if (flags[kFLAGS.CAMP_WALL_PROGRESS] == 0) {
			outputText("A feeling of unrest grows within you as the population of your [camp] is growing. Maybe it's time you build a wall to secure the perimeter?\n\n");
			flags[kFLAGS.CAMP_WALL_PROGRESS] = 1;
		} else {
			outputText("You can continue work on building the wall that surrounds your [camp].\n\n");
			outputText("Segments complete: " + Math.floor(flags[kFLAGS.CAMP_WALL_PROGRESS] / 10) + "/10\n");
		}
		SceneLib.camp.campUpgrades.checkMaterials();
		outputText("\n\nIt will cost 80 nails, 80 wood and 10 stones to work on a segment of the wall.\n\n");
		if (CampStatsAndResources.StonesResc >= 10 && CampStatsAndResources.WoodResc >= 80 && CampStatsAndResources.NailsResc >= 80) {
			doYesNo(buildCampWall, doCamp);
		} else {
			outputText("\n<b>Unfortunately, you do not have sufficient resources.</b>");
			doNext(doCamp);
		}
	}

	private function buildCampWall():void {
		var helpers:int = 0;
		var helperArray:Array = [];
		if (flags[kFLAGS.ANT_KIDS] > 100) {
			helperArray[helperArray.length] = "A group of your ant children";
			helpers++;
		}
		if (marbleFollower()) {
			helperArray[helperArray.length] = "Marble";
			helpers++;
		}
		if (followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff)) {
			helperArray[helperArray.length] = "Helia";
			helpers++;
		}
		if (followerKiha()) {
			helperArray[helperArray.length] = "Kiha";
			helpers++;
		}
		CampStatsAndResources.StonesResc -= 10;
		CampStatsAndResources.WoodResc -= 80;
		CampStatsAndResources.NailsResc -= 80;
		clearOutput();
		if (flags[kFLAGS.CAMP_WALL_PROGRESS] == 1) {
			outputText("You pull out a book titled \"Carpenter's Guide\" and flip pages until you come across instructions on how to build a wall. You spend minutes looking at the instructions and memorize the procedures.");
			flags[kFLAGS.CAMP_WALL_PROGRESS] = 10;
		} else {
			outputText("You remember the procedure for building a wall.");
			flags[kFLAGS.CAMP_WALL_PROGRESS] += 10;
		}
		outputText("\n\nYou dig four holes, six inches deep and one foot wide each, before putting up wood posts, twelve feet high and one foot thick each. You take the wood from supplies, saw the wood and cut them into planks before nailing them to the wooden posts. At the end you use stones to strengthen base of the segment.");
		if (helpers > 0) {
			outputText("\n\n" + formatStringArray(helperArray));
			outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with building the wall, helping to speed up the process and make construction less fatiguing.");
		}
		//Gain fatigue.
		var fatigueAmount:int = 100;
		fatigueAmount -= player.str / 5;
		fatigueAmount -= player.tou / 10;
		fatigueAmount -= player.spe / 10;
		if (player.hasPerk(PerkLib.IronMan)) fatigueAmount -= 20;
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) fatigueAmount -= 10;
		fatigueAmount /= (helpers + 1);
		if (fatigueAmount < 15) fatigueAmount = 15;
		fatigue(fatigueAmount);
		if (helpers >= 2) {
			outputText("\n\nThanks to your assistants, the construction takes only one hour!");
			doNext(camp.returnToCampUseOneHour);
		} else if (helpers == 1) {
			outputText("\n\nThanks to your assistant, the construction takes only two hours.");
			doNext(camp.returnToCampUseTwoHours);
		} else {
			outputText("\n\nIt's " + (fatigueAmount >= 75 ? "a daunting" : "an easy") + " task but you eventually manage to finish building a segment of the wall for your [camp]!");
			doNext(camp.returnToCampUseFourHours);
		}
		if (flags[kFLAGS.CAMP_WALL_PROGRESS] == 10) {
			outputText("\n\n<b>Well done! You have finished your first section of the walls! Now you can decorate it with imp skulls to further deter whoever might try to come and rape you.</b>");
			flushOutputTextToGUI();
		}
		if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100) {
			outputText("\n\n<b>Well done! You have finished the wall! You can build a gate.</b>");
			flushOutputTextToGUI();
		}
	}

//Camp gate
	private function buildCampGatePrompt():void {
		clearOutput();
		if (player.fatigue >= player.maxFatigue() - 50) {
			outputText("You are too exhausted to work on your [camp] wall!");
			doNext(doCamp);
			return;
		}
		outputText("You can build a gate to further secure your [camp] by having it closed at night.\n\n");
		SceneLib.camp.campUpgrades.checkMaterials();
		outputText("\n\nIt will cost 100 nails and 100 wood to build a gate.\n\n");
		if (CampStatsAndResources.WoodResc >= 100 && CampStatsAndResources.NailsResc >= 100) {
			doYesNo(buildCampGate, doCamp);
		} else {
			outputText("\n<b>Unfortunately, you do not have sufficient resources.</b>");
			doNext(doCamp);
		}
	}

	private function buildCampGate():void {
		var helpers:int = 0;
		var helperArray:Array = [];
		if (flags[kFLAGS.ANT_KIDS] > 100) {
			helperArray[helperArray.length] = "A group of your ant children";
			helpers++;
		}
		if (marbleFollower()) {
			helperArray[helperArray.length] = "Marble";
			helpers++;
		}
		if (followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff)) {
			helperArray[helperArray.length] = "Helia";
			helpers++;
		}
		if (followerKiha()) {
			helperArray[helperArray.length] = "Kiha";
			helpers++;
		}
		CampStatsAndResources.WoodResc -= 100;
		CampStatsAndResources.NailsResc -= 100;
		clearOutput();
		outputText("You pull out a book titled \"Carpenter's Guide\" and flip pages until you come across instructions on how to build a gate that can be opened and closed. You spend minutes looking at the instructions and memorize the procedures.");
		flags[kFLAGS.CAMP_WALL_GATE] = 1;
		outputText("\n\nYou take the wood from supplies, saw the wood and cut them into planks before nailing them together. ");
		if (helpers > 0) {
			outputText("\n\n" + formatStringArray(helperArray));
			outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with building the gate, helping to speed up the process and make construction less fatiguing.");
		}
		outputText("\n\nYou eventually finish building the gate.");
		//Gain fatigue.
		var fatigueAmount:int = 100;
		fatigueAmount -= player.str / 5;
		fatigueAmount -= player.tou / 10;
		fatigueAmount -= player.spe / 10;
		if (player.hasPerk(PerkLib.IronMan)) fatigueAmount -= 20;
		fatigueAmount /= (helpers + 1);
		if (fatigueAmount < 15) fatigueAmount = 15;
		fatigue(fatigueAmount);
		doNext(camp.returnToCampUseOneHour);
	}

	private function promptHangImpSkull():void {
		clearOutput();
		if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 7 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 10) {
			outputText("There is no room; you have already hung a total of 7 imp skulls! To add more you need to build next segment of the wall.");
			doNext(doCamp);
			return;
		} else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 14 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 20) {
			outputText("There is no room; you have already hung a total of 14 imp skulls! To add more you need to build next segment of the wall.");
			doNext(doCamp);
			return;
		} else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 22 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 30) {
			outputText("There is no room; you have already hung a total of 22 imp skulls! To add more you need to build next segment of the wall.");
			doNext(doCamp);
			return;
		} else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 30 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 40) {
			outputText("There is no room; you have already hung a total of 30 imp skulls! To add more you need to build next segment of the wall.");
			doNext(doCamp);
			return;
		} else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 39 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 50) {
			outputText("There is no room; you have already hung a total of 39 imp skulls! To add more you need to build next segment of the wall.");
			doNext(doCamp);
			return;
		} else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 50 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 60) {
			outputText("There is no room; you have already hung a total of 50 imp skulls! To add more you need to build next segment of the wall.");
			doNext(doCamp);
			return;
		} else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 62 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 70) {
			outputText("There is no room; you have already hung a total of 62 imp skulls! To add more you need to build next segment of the wall.");
			doNext(doCamp);
			return;
		} else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 74 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 80) {
			outputText("There is no room; you have already hung a total of 74 imp skulls! To add more you need to build next segment of the wall.");
			doNext(doCamp);
			return;
		} else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 86 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 90) {
			outputText("There is no room; you have already hung a total of 86 imp skulls! To add more you need to build next segment of the wall.");
			doNext(doCamp);
			return;
		} else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 100 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 100) {
			outputText("There is no room; you have already hung a total of 100 imp skulls! With such a macabre display, no imp would dare approach you within the veil of night, now.");
			doNext(doCamp);
			return;
		}
		outputText("Would you like to hang the skull of an imp onto wall? ");
		if (flags[kFLAGS.CAMP_WALL_SKULLS] > 0) outputText("There " + (flags[kFLAGS.CAMP_WALL_SKULLS] == 1 ? "is" : "are") + " currently " + num2Text(flags[kFLAGS.CAMP_WALL_SKULLS]) + " imp skull" + (flags[kFLAGS.CAMP_WALL_SKULLS] == 1 ? "" : "s") + " hung on the wall, serving to deter any imps who might try to rape you.");
		doYesNo(hangImpSkull, doCamp);
	}

	private function hangImpSkull():void {
		clearOutput();
		outputText("You hang the skull of an imp on the wall. ");
		player.consumeItem(useables.IMPSKLL, 1);
		flags[kFLAGS.CAMP_WALL_SKULLS]++;
		outputText("There " + (flags[kFLAGS.CAMP_WALL_SKULLS] == 1 ? "is" : "are") + " currently " + num2Text(flags[kFLAGS.CAMP_WALL_SKULLS]) + " imp skull" + (flags[kFLAGS.CAMP_WALL_SKULLS] == 1 ? "" : "s") + " hung on the wall, serving to deter any imps who might try to rape you.");
		doNext(campBuildingSim);
	}

	public function homeDesc():String {
		var textToChoose:String;
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0) {
			textToChoose = "cabin";
		} else {
			textToChoose = "tent";
		}
		return textToChoose;
	}

	public function bedDesc():String {
		var textToChoose:String;
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0) {
			textToChoose = "bed";
		} else {
			textToChoose = "bedroll";
		}
		return textToChoose;
	}

	private function promptAscend():void {
		clearOutput();
		outputText("Are you sure you want to ascend? This will restart the game and put you into ");
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) outputText("<b>New Game+</b>");
		else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 1) outputText("<b>New Game++</b>");
		else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 2) outputText("<b>New Game+++</b>");
		else outputText("<b>New Game+" + (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] + 1) + "</b>");
		outputText(". Your items stored in Sky Poison Pearl (if you have it) will be carried over into new playthrough. You'll revert back to human completely. You'll also retain your name and gender.");
		outputText("\n\n<b>Proceed?</b>");
		doYesNo(ascendForReal, campActions);
	}

	private function ascendForReal():void {
		//Check performance!
		var performancePoints:int = 0;
		//Sum up ascension perk points!
		performancePoints += possibleToGainAscensionPoints();
		player.ascensionPerkPoints += performancePoints;
		player.knockUpForce(); //Clear pregnancy
		player.knockUpForce(0, 0, 1); //Clear pregnancy
		player.buttKnockUpForce(); //Clear Butt preggos.
		//Scene GO!
		clearOutput();
		outputText("It's time for you to ascend. You walk to the center of the [camp], announce that you're going to ascend to a higher plane of existence, and lay down. ");
		if (companionsCount() == 1) outputText("\n\nYour fellow companion comes to witness.");
		else if (companionsCount() > 1) outputText("\n\nYour fellow companions come to witness.");
		outputText("\n\nYou begin to glow; you can already feel yourself leaving your body and you announce your departure.");
		if (marbleFollower()) outputText("\n\n\"<i>Sweetie, I'm going to miss you. See you in the next playthrough,</i>\" Marble says, tears leaking from her eyes.");
		outputText("\n\nThe world around you slowly fades to black and stars dot the endless void. <b>You have ascended.</b>");
		doNext(CoC.instance.charCreation.ascensionMenuChoice);
	}

	public function possibleToGainAscensionPoints():Number {
		var performancePointsPrediction:Number = 0;
		//Companions
		performancePointsPrediction += companionsCount();
		if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 0) performancePointsPrediction--;
		if (flags[kFLAGS.ALVINA_FOLLOWER] == 12) performancePointsPrediction++;
		if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 3) performancePointsPrediction++;
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 2 || flags[kFLAGS.CHI_CHI_FOLLOWER] == 5 || player.hasStatusEffect(StatusEffects.ChiChiOff)) performancePointsPrediction++;
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == 3) performancePointsPrediction++;
		if (player.hasStatusEffect(StatusEffects.DivaOff)) performancePointsPrediction++;
		if (player.hasStatusEffect(StatusEffects.ElectraOff)) performancePointsPrediction++;
		if (player.hasStatusEffect(StatusEffects.EtnaOff)) performancePointsPrediction++;
		if (player.hasStatusEffect(StatusEffects.LunaOff)) performancePointsPrediction++;
		if (player.hasStatusEffect(StatusEffects.NadiaOff)) performancePointsPrediction++;
		if (player.hasStatusEffect(StatusEffects.ShouldraOff)) performancePointsPrediction++;
		if (player.hasStatusEffect(StatusEffects.HeliaOff)) performancePointsPrediction++;
		//Dungeons
		performancePointsPrediction += possibleToGainAscensionPointsDungeons();
		//Quests
		performancePointsPrediction += possibleToGainAscensionPointsQuests();
		//Camp structures
		performancePointsPrediction += possibleToGainAscensionPointsCampStructures();
		//Children
		performancePointsPrediction += possibleToGainAscensionPointsChildren();
		//Various Level trackers
		performancePointsPrediction += player.level;
		if (player.level >= 42) performancePointsPrediction += (player.level - 41);
		if (player.level >= 102) performancePointsPrediction += (player.level - 101);
		if (player.level >= 180) performancePointsPrediction += (player.level - 179);
		performancePointsPrediction += player.herbalismLevel;
		performancePointsPrediction += player.miningLevel;
		performancePointsPrediction += player.farmingLevel;
		if (player.teaseLevel >= 25) {
			performancePointsPrediction += 25;
		}
		else performancePointsPrediction += player.teaseLevel;
        performancePointsPrediction += getTotalWeaponMasteryLevels();
		performancePointsPrediction = Math.round(performancePointsPrediction);
		return performancePointsPrediction;
	}
	public function possibleToGainAscensionPointsDungeons():Number {
		var performancePointsPredictionDungeons:Number = 0;
		if (SceneLib.dungeons.checkFactoryClear()) performancePointsPredictionDungeons++;
		if (SceneLib.dungeons.checkDeepCaveClear()) performancePointsPredictionDungeons += 2;
		if (SceneLib.dungeons.checkDemonLaboratoryClear()) performancePointsPredictionDungeons += 3;
		if (SceneLib.dungeons.checkLethiceStrongholdClear()) performancePointsPredictionDungeons += 4;
		if (SceneLib.dungeons.checkSandCaveClear()) performancePointsPredictionDungeons++;
		if (SceneLib.dungeons.checkHiddenCaveClear()) performancePointsPredictionDungeons++;
		if (SceneLib.dungeons.checkHiddenCaveHiddenStageClear()) performancePointsPredictionDungeons++;
		if (SceneLib.dungeons.checkRiverDungeon1stFloorClear()) performancePointsPredictionDungeons++;
		if (SceneLib.dungeons.checkDenOfDesireClear()) performancePointsPredictionDungeons++;
		if (SceneLib.dungeons.checkEbonLabyrinthClear()) performancePointsPredictionDungeons += 3;
		if (SceneLib.dungeons.checkPhoenixTowerClear()) performancePointsPredictionDungeons += 2;
		if (SceneLib.dungeons.checkBeeHiveClear()) performancePointsPredictionDungeons += 2;
		return performancePointsPredictionDungeons;
	}
	public function possibleToGainAscensionPointsQuests():Number {
		var performancePointsPredictionQuests:Number = 0;
		if (flags[kFLAGS.MARBLE_PURIFIED] > 0) performancePointsPredictionQuests += 2;
		if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] >= 10) performancePointsPredictionQuests += 2;
		if (flags[kFLAGS.URTA_QUEST_STATUS] > 0) performancePointsPredictionQuests += 2;
		if (player.hasPerk(PerkLib.Enlightened)) performancePointsPredictionQuests += 1;
		if (flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0 || flags[kFLAGS.PURE_MARAE_ENDGAME] >= 2) performancePointsPredictionQuests += 3;
		if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) >= 4) performancePointsPredictionQuests += 2;
		if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) >= 4) performancePointsPredictionQuests += 2;
		if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) >= 4) performancePointsPredictionQuests += 2;
		if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) >= 4) performancePointsPredictionQuests += 2;
		if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) >= 4) performancePointsPredictionQuests += 2;
		if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) >= 2) performancePointsPredictionQuests++;
		if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) >= 2) performancePointsPredictionQuests++;
		if (flags[kFLAGS.GALIA_LVL_UP] >= 0.5) performancePointsPredictionQuests += 5;
		return performancePointsPredictionQuests;
	}
	public function possibleToGainAscensionPointsCampStructures():Number {
		var performancePointsPredictionCampStructures:Number = 0;
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) performancePointsPredictionCampStructures += 10;
		if (flags[kFLAGS.CAMP_WALL_GATE] > 0) performancePointsPredictionCampStructures += 11;
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] > 2) performancePointsPredictionCampStructures += 2;
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] > 3) performancePointsPredictionCampStructures += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] > 1) performancePointsPredictionCampStructures += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] > 3) performancePointsPredictionCampStructures += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] > 5) performancePointsPredictionCampStructures += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] > 3) performancePointsPredictionCampStructures += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] > 3) performancePointsPredictionCampStructures += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 1) performancePointsPredictionCampStructures += ((flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] - 1) * 2);//obecnie +4*2
		if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] > 0) performancePointsPredictionCampStructures += flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE];//obecnie +8
		if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] > 1) performancePointsPredictionCampStructures += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_DAM] > 0) performancePointsPredictionCampStructures += (flags[kFLAGS.CAMP_UPGRADES_DAM] * 2);//obecnie +3*2
		if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] > 0) performancePointsPredictionCampStructures += (flags[kFLAGS.CAMP_UPGRADES_FISHERY] * 2);//obecnie +2*2
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) performancePointsPredictionCampStructures += 2;
		return performancePointsPredictionCampStructures;
	}
	public function possibleToGainAscensionPointsChildren():Number {
		var performancePointsPredictionChildren:Number = 0;
		var childPerformance:int = 0;
		childPerformance += (flags[kFLAGS.MINERVA_CHILDREN] + flags[kFLAGS.BEHEMOTH_CHILDREN] + flags[kFLAGS.MARBLE_KIDS] + (flags[kFLAGS.SHEILA_JOEYS] + flags[kFLAGS.SHEILA_IMPS]) + izmaScene.totalIzmaChildren() + isabellaScene.totalIsabellaChildren() + kihaFollower.totalKihaChildren() + emberScene.emberChildren() + urtaPregs.urtaKids() + sophieBimbo.sophieChildren());
		childPerformance += (flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] + flags[kFLAGS.KELLY_KIDS] + flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] + flags[kFLAGS.COTTON_KID_COUNT] + flags[kFLAGS.AMILY_BIRTH_TOTAL] + flags[kFLAGS.PC_TIMES_BIRTHED_AMILYKIDS] + joyScene.getTotalLitters() + SceneLib.excelliaFollower.totalExcelliaChildren() + flags[kFLAGS.ZENJI_KIDS]);
		childPerformance += ((flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 4) + (flags[kFLAGS.LYNNETTE_BABY_COUNT] / 4) + (flags[kFLAGS.ANT_KIDS] / 100) + (flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] / 4) + (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] / 4) + (flags[kFLAGS.MITZI_DAUGHTERS] / 4) + (etnaScene().etnaTotalKids()));
		childPerformance += ((DriderTown.BelisaKids / 4) + (DriderTown.LilyKidsPC / 4) + ((DriderTown.TyrantiaFemaleKids + DriderTown.TyrantiaMaleKids) / 4) + SceneLib.ayaneFollower.ayaneChildren() + flags[kFLAGS.LOPPE_KIDS]);
		performancePointsPredictionChildren += Math.sqrt(childPerformance);
		return performancePointsPredictionChildren;
	}

    public static function getTotalWeaponMasteryLevels():Number{
		// 10 max level, + 1 up to level 90, + 50 with perk ( 150 max total per mastery )
		// so at most 10 points per mastery grind
        var total:Number = 0;
		for(var i:int = 0; i < player.combatMastery.length; i++){
			total += player.combatMastery[i].level;
		}
        total = total / 12;
        return total;
    }
	public function setLevelButton(allowAutoLevelTransition:Boolean):Boolean {
		var levelup:Boolean = player.XP >= player.requiredXP() && (player.level < CoC.instance.levelCap || player.negativeLevel > 0);
		if (levelup || player.perkPoints > 0 || player.statPoints > 0) {
			if (!levelup) {
				if (player.statPoints > 0) {
					mainView.setMenuButton(MainView.MENU_LEVEL, "Stat Up");
					mainView.levelButton.toolTipText = "Distribute your stats points. \n\nYou currently have " + String(player.statPoints) + ".";
				} else  if (player.perkPoints > 0) {
					mainView.setMenuButton(MainView.MENU_LEVEL, "Perk Up");
					mainView.levelButton.toolTipText = "Spend your perk points on a new perk. \n\nYou currently have " + String(player.perkPoints) + ".";
				}
			} else {
				if (player.negativeLevel > 0) {
					mainView.setMenuButton(MainView.MENU_LEVEL, "Restore Lvl");
				} else {
					mainView.setMenuButton(MainView.MENU_LEVEL, "Level Up");
				}
				mainView.levelButton.toolTipText = getLevelUpStatsForButton();
				if (flags[kFLAGS.AUTO_LEVEL] > 0 && allowAutoLevelTransition) {
					CoC.instance.playerInfo.levelUpMenu();
					return true; //True indicates that you should be routed to level-up.
				}
			}
			mainView.showMenuButton(MainView.MENU_LEVEL);
			mainView.statsView.showLevelUp();
			if (player.str >= player.strStat.max && player.tou >= player.touStat.max && player.inte >= player.intStat.max && player.spe >= player.speStat.max && (player.perkPoints <= 0 || PerkTree.availablePerks(CoC.instance.player, false).length <= 0) && (player.XP < player.requiredXP() || player.level >= CoC.instance.levelCap)) {
				mainView.statsView.hideLevelUp();
			}
		} else {
			mainView.hideMenuButton(MainView.MENU_LEVEL);
			mainView.statsView.hideLevelUp();
		}
		return false;
	}
	
	public function getLevelUpStatsForButton():String {
		// This is all just display for the button text and affects nothing directly
		var statpoints:int = 5;
		var perkpoints:int = 1;
		if (player.hasPerk(PerkLib.AscensionAdvTrainingX)) statpoints += player.perkv1(PerkLib.AscensionAdvTrainingX) * 4;
		if (player.level < 1) {
			statpoints *= 3;
			perkpoints *= 3;
		}
		if (player.level < 9) {
			statpoints *= 2;
			perkpoints *= 2;
		}
		var output:String = "";
		output = "Level up to increase your base stats,\nas well as gain <b>"+num2Text(statpoints,100)+"</b> stat points and <b>"+num2Text(perkpoints,100)+"</b> perk points!";
		return output;
		// If someone with more free time than I wants to go dig through and update/verify info feel free to re-add it
		// Honestly it's not worth the processing time though since this gets redrawn a *lot* ?
		//var hp:int = 60, fatigue:int = 5, mana:int = 10, soulforce:int = 5, wrath:int = 5, lust:int = 3;
		//if (player.level <= 6) hp += 60, fatigue += 5, mana += 10, soulforce += 5, wrath += 5, lust += 3;
		//if (player.hasPerk(PerkLib.AscensionUnlockedPotential)) hp += 80, lust += 6, fatigue += 6;
		//if (player.hasPerk(PerkLib.AscensionUnlockedPotential2ndStage)) wrath += 10, mana += 12, soulforce += 6;
		//if (player.hasPerk(PerkLib.AscensionUnlockedPotential3rdStage)) hp += 80, lust += 6, fatigue += 6;
		//if (player.hasPerk(PerkLib.AscensionUnlockedPotential4thStage)) wrath += 10, mana += 12, soulforce += 6;
		//if (player.hasPerk(PerkLib.UnlockBody)) hp += 60;
		//if (player.hasPerk(PerkLib.UnlockBody2ndStage)) hp += 60;
		//if (player.hasPerk(PerkLib.UnlockBody3rdStage)) hp += 60;
		//if (player.hasPerk(PerkLib.UnlockBody4thStage)) hp += 60;
		//if (player.hasPerk(PerkLib.UnlockEndurance)) fatigue += 5;
		//if (player.hasPerk(PerkLib.UnlockEndurance2ndStage)) fatigue += 5;
		//if (player.hasPerk(PerkLib.UnlockEndurance3rdStage)) fatigue += 5;
		//if (player.hasPerk(PerkLib.UnlockEndurance4thStage)) fatigue += 5;
		//if (player.hasPerk(PerkLib.UnlockForce)) mana += 10;
		//if (player.hasPerk(PerkLib.UnlockForce2ndStage)) mana += 10;
		//if (player.hasPerk(PerkLib.UnlockForce3rdStage)) mana += 10;
		//if (player.hasPerk(PerkLib.UnlockForce4thStage)) mana += 10;
		//if (player.hasPerk(PerkLib.UnlockSpirit)) soulforce += 5;
		//if (player.hasPerk(PerkLib.UnlockSpirit2ndStage)) soulforce += 5;
		//if (player.hasPerk(PerkLib.UnlockSpirit3rdStage)) soulforce += 5;
		//if (player.hasPerk(PerkLib.UnlockSpirit4thStage)) soulforce += 5;
		//if (player.hasPerk(PerkLib.UnlockId)) wrath += 5;
		//if (player.hasPerk(PerkLib.UnlockId2ndStage)) wrath += 5;
		//if (player.hasPerk(PerkLib.UnlockId3rdStage)) wrath += 5;
		//if (player.hasPerk(PerkLib.UnlockId4thStage)) wrath += 5;
		//if (player.hasPerk(PerkLib.UnlockArdor)) lust += 3;
		//if (player.hasPerk(PerkLib.UnlockArdor2ndStage)) lust += 3;
		//if (player.hasPerk(PerkLib.UnlockArdor3rdStage)) lust += 3;
		//if (player.hasPerk(PerkLib.UnlockArdor4thStage)) lust += 3;
		//output += "Level up to increase your maximum: HP by " + hp + ", Lust by " + lust + ", Wrath by " + wrath + ", Fatigue by " + fatigue + ", Mana by " + mana + " and Soulforce by " + soulforce + "; gain " + statpoints + " attribute points and " + perkpoints + " perk point" + 		(perkpoints > 1?"s":"") + ".";
	}

//Camp population!
	public function getCampPopulation():int {
		var pop:int = 0; //Once you enter Mareth, this will increase to 1.
		if (!flags[kFLAGS.IN_INGNAM]) pop++; //You count toward the population!
		pop += companionsCount();
		if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 0) pop--;
		//------------
		//Misc check!
		if (ceraphIsFollower()) pop--; //Ceraph doesn't stay in your camp.
		if (player.armor == armors.GOOARMR) pop++; //Include Valeria if you're wearing her.
		if (player.weapon == weapons.AETHERD) pop++; //Include Aether D twin if you're wearing her.
		if (player.shield == shields.AETHERS) pop++; //Include Aether S twin if you're wearing her.
		if (flags[kFLAGS.CLARA_IMPRISONED] > 0) pop++;
		if (player.isAnyRaceCached(Races.WEREWOLF, Races.CERBERUS) && player.hasMutation(IMutationsLib.AlphaHowlIM)) pop += LunaFollower.WerewolfPackMember;
		if (player.isRaceCached(Races.CERBERUS) && player.hasMutation(IMutationsLib.AlphaHowlIM) && player.hasMutation(IMutationsLib.HellhoundFireBallsIM)) pop += LunaFollower.HellhoundPackMember;
		if (player.hasPerk(PerkLib.MummyLord)) pop += player.perkv1(PerkLib.MummyLord);
		//------------
		//Children check!
		//Followers
		if (followerEmber() && emberScene.emberChildren() > 0) pop += emberScene.emberChildren();
		if (flags[kFLAGS.MITZI_DAUGHTERS] > 0) pop += flags[kFLAGS.MITZI_DAUGHTERS];
		if (SceneLib.ayaneFollower.ayaneChildren() > 0) pop += SceneLib.ayaneFollower.ayaneChildren();
		//Jojo's offsprings don't stay in your camp; they will join with Amily's litters as well.
		if (sophieFollower()) {
			if (flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) pop++;
			if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT]) pop += flags[kFLAGS.SOPHIE_ADULT_KID_COUNT];
		}
		//Lovers
		//Amily's offsprings don't stay in your camp.
		//Helia can only have 1 child: Helspawn. She's included in companions count. The same with Etna child.
		if (isabellaFollower() && isabellaScene.totalIsabellaChildren() > 0) pop += isabellaScene.totalIsabellaChildren();
		if (izmaFollower() && izmaScene.totalIzmaChildren() > 0) pop += izmaScene.totalIzmaChildren();
		if (followerKiha() && kihaFollower.totalKihaChildren() > 0) pop += kihaFollower.totalKihaChildren();
		if (marbleFollower() && flags[kFLAGS.MARBLE_KIDS] > 0) pop += flags[kFLAGS.MARBLE_KIDS];
		if (flags[kFLAGS.ANT_WAIFU] > 0 && (flags[kFLAGS.ANT_KIDS] > 0 || flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] > 0)) pop += (flags[kFLAGS.ANT_KIDS] + flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT]);
		if (flags[kFLAGS.ZENJI_KIDS] > 0) pop += flags[kFLAGS.ZENJI_KIDS];
		if (DriderTown.BelisaKids > 0) pop += DriderTown.BelisaKids;
		if (DriderTown.LilyKidsPC > 0) pop += DriderTown.LilyKidsPC;
		if (DriderTown.TyrantiaFemaleKids > 0) pop += DriderTown.TyrantiaFemaleKids;
		if (DriderTown.TyrantiaMaleKids > 0) pop += DriderTown.TyrantiaMaleKids;
		if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 0) pop += flags[kFLAGS.PC_GOBLIN_DAUGHTERS];
		//From npcs that can be in more than one tab
		if (SceneLib.excelliaFollower.totalExcelliaChildren() > 0) pop += SceneLib.excelliaFollower.totalExcelliaChildren();
		//------------
		//Return number!
		return pop;
	}

//Camp underground population!
	public function getCampUndergroundPopulation():int {
		var undpop:int = 0;
		if (flags[kFLAGS.ANT_WAIFU] > 0) undpop++;
		if (flags[kFLAGS.ANT_KIDS] > 0 || flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] > 0) undpop += (flags[kFLAGS.ANT_KIDS] + flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT]);
		return undpop;
	}

}
}