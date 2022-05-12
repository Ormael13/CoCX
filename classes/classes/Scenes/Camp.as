package classes.Scenes {
import classes.*;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.*;
import classes.Items.Consumables.SimpleConsumable;
import classes.Scenes.Places.Mindbreaker;
import classes.Scenes.Places.TrollVillage;
import classes.Scenes.Places.WoodElves;
import classes.Scenes.Camp.*;
import classes.Scenes.NPCs.*;
import classes.Scenes.Places.HeXinDao.AdventurerGuild;
import classes.lists.Gender;
import classes.display.SpriteDb;

import coc.view.ButtonDataList;
import coc.view.MainView;

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

	public var cabinProgress:CabinProgress = new CabinProgress();
	public var campUpgrades:CampUpgrades = new CampUpgrades();
	public var campScenes:CampScenes = new CampScenes();
	public var campMake:CampMakeWinions = new CampMakeWinions();
	public var campUniqueScenes:UniqueCampScenes = new UniqueCampScenes();
	public var codex:Codex = new Codex();
	public var questlog:Questlog = new Questlog();
	public var soulforce:Soulforce = new Soulforce();
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
		if (timeUsed == 1)
			outputText("An hour passes...\n");
		else outputText(Num2Text(timeUsed) + " hours pass...\n");
		if (!CoC.instance.inCombat) spriteSelect(null);
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
	public function returnToCampUseFourteenHours():void {
		returnToCamp(14);
	}
	public function returnToCampUseSixteenHours():void {
		returnToCamp(16);
	}

	//Used to determine scenes if you choose to play joke on them. Should the variables be moved to flags?
	protected var izmaJoinsStream:Boolean;
	protected var marbleJoinsStream:Boolean;
	protected var heliaJoinsStream:Boolean;
	protected var amilyJoinsStream:Boolean;

	public var IsSleeping: Boolean = false;
	public var CanDream: Boolean = false;
	public var HadNightEvent: Boolean = false;
	public var IsWaitingResting: Boolean = false;

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
		if (prison.inPrison) { //Prison
			SceneLib.prison.prisonRoom(true);
			return;
		}
		//trace("Current fertility: " + player.totalFertility());
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
        
		//Clear out Izma's saved loot status
		flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = "";
		//History perk backup
		if (flags[kFLAGS.HISTORY_PERK_SELECTED] == 0) {
			flags[kFLAGS.HISTORY_PERK_SELECTED] = 2;
			hideMenus();
			CoC.instance.charCreation.chooseHistory();
//		fixHistory();
			return;
		}
		saveUpdater.fixFlags();
		if (player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
			player.removeStatusEffect(StatusEffects.ChargeWeapon);
		}
		if (player.hasStatusEffect(StatusEffects.ChargeArmor)) {
			player.removeStatusEffect(StatusEffects.ChargeArmor);
		}
		if (player.hasStatusEffect(StatusEffects.PCDaughters)) {
			campScenes.goblinsBirthScene();
			return;
		}
		if (player.hasItem(useables.SOULGEM, 1) && player.hasStatusEffect(StatusEffects.CampRathazul) && flags[kFLAGS.DEN_OF_DESIRE_QUEST] < 1) {
			campUniqueScenes.playsRathazulAndSoulgemScene();
			return;
		}
		if (TrollVillage.ZenjiVillageStage == 2 && TrollVillage.ZenjiTrollVillageTimeChk == time.days && time.hours >= 8) {
			hideMenus();
			SceneLib.trollVillage.yenza.YenzaBeratePart2();
			return;
		}
		if (flags[kFLAGS.ZENJI_PROGRESS] >= 11 && time.days != ZenjiScenes.ZenjiLoverDaysTracker){
			ZenjiScenes.ZenjiLoverDays++;
			ZenjiScenes.ZenjiLoverDaysTracker = time.days;
		}
		if (TrollVillage.ZenjiMoneyHelp > 0) TrollVillage.ZenjiMoneyHelp -= 1;
		if (!marbleScene.marbleFollower() && flags[kFLAGS.MARBLE_LEFT_OVER_CORRUPTION] == 1/* && player.cor <= 40*/) { //Removed the check to make her return to everyone
			hideMenus();
			marblePurification.pureMarbleDecidesToBeLessOfABitch();
			return;
		}
		if ((model.time.hours >= 7 && model.time.hours <= 9) && TyrantiaFollower.TyrantiaFollowerStage >= 4 && BelisaFollower.BelisaFollowerStage >= 5 && BelisaFollower.BelisaEncounternum >= 5 && BelisaFollower.BelisaAffectionMeter >= 80 && !BelisaFollower.BelisaConfessed) {
			hideMenus();
			SceneLib.belisa.BelisaConfession();
			return;
		}
		if ((model.time.hours >= 7 && model.time.hours <= 9) && TyrantiaFollower.TyrantiaFollowerStage >= 4 && BelisaFollower.BelisaFollowerStage >= 4 && BelisaFollower.BelisaEncounternum < 5) {
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
			SceneLib.tyrania.unlockingCorruptLegendariesOption();
			return;
		}
		if (marbleScene.marbleFollower()) {
			//Cor < 50
			//No corrupt: Jojo, Amily, or Vapula
			//Purifying Murble
			if (player.cor < 50 && !campCorruptJojo() && !amilyScene.amilyCorrupt() && !vapulaSlave()
					&& flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 0 && flags[kFLAGS.MARBLE_COUNTUP_TO_PURIFYING] >= 200
					&& !player.hasPerk(PerkLib.MarblesMilk)) {
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
		if (flags[kFLAGS.JACK_FROST_PROGRESS] > 0) {
			hideMenus();
			Holidays.processJackFrostEvent();
			return;
		}
		if (player.hasKeyItem("Super Reducto") < 0 && milkSlave() && player.hasStatusEffect(StatusEffects.CampRathazul) && player.statusEffectv2(StatusEffects.MetRathazul) >= 4) {
			hideMenus();
			milkWaifu.ratducto();
			return;
		}
		if (Holidays.nieveHoliday() && camp.IsSleeping) {
			if (player.hasKeyItem("Nieve's Tear") >= 0 && flags[kFLAGS.NIEVE_STAGE] != 5) {
				Holidays.returnOfNieve();
				hideMenus();
				return;
			} else if (flags[kFLAGS.NIEVE_STAGE] == 0) {
				hideMenus();
				Holidays.snowLadyActive();
				return;
			} else if (flags[kFLAGS.NIEVE_STAGE] == 4) {
				hideMenus();
				Holidays.nieveComesToLife();
				return;
			}
		}
		if (Holidays.isHalloween() && flags[kFLAGS.ZENJI_PROGRESS] == 11 && (model.time.hours >= 6 && model.time.hours < 9) && player.statusEffectv4(StatusEffects.ZenjiZList) == 0) {
			hideMenus();
			SceneLib.zenjiScene.loverZenjiHalloweenEvent();
			return;
		}
		if (SceneLib.helScene.followerHel()) {
			if (helFollower.isHeliaBirthday() && flags[kFLAGS.HEL_FOLLOWER_LEVEL] >= 2 && flags[kFLAGS.HELIA_BIRTHDAY_OFFERED] == 0) {
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
		if (model.time.hours >= 10 && model.time.hours <= 18 && (model.time.days % 20 == 0 || model.time.hours == 12) && flags[kFLAGS.HELSPAWN_DADDY] == 2 && helSpawnScene.helspawnFollower()) {
			hideMenus();
			helSpawnScene.maiVisitsHerKids();
			return;
		}
		if (model.time.hours == 6 && flags[kFLAGS.HELSPAWN_DADDY] == 1 && model.time.days % 30 == 0 && flags[kFLAGS.SPIDER_BRO_GIFT] == 0 && helSpawnScene.helspawnFollower()) {
			hideMenus();
			helSpawnScene.spiderBrosGift();
			return;
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
			Holidays.nieveIsOver();
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
		if (flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] > 0 && (flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0)) {
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
		if (flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.MARAE_QUEST_COMPLETE] == 1 && (flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0)) {
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
		if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] > 1 && flags[kFLAGS.CHRISTMAS_TREE_LEVEL] < 5 && (flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0)) {
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
			anemoneScene.anemoneKidBirthPtII();
			hideMenus();
			return;
		}
		for each (var npc:XXCNPC in _campFollowers) {
			if (npc.checkCampEvent()) {
				return;
			}
		}
		//Exgartuan clearing
		if (player.statusEffectv1(StatusEffects.Exgartuan) == 1 && (player.cockArea(0) < 100 || player.cocks.length == 0)) {
			exgartuanCampUpdate();
			return;
		} else if (player.statusEffectv1(StatusEffects.Exgartuan) == 2 && player.biggestTitSize() < 12) {
			exgartuanCampUpdate();
			return;
		}
		//Izzys tits asplode
		if (isabellaFollower() && flags[kFLAGS.ISABELLA_MILKED_YET] >= 10 && player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") >= 0) {
			isabellaFollowerScene.milktasticLacticLactation();
			hideMenus();
			return;
		}
		//Isabella and Valeria sparring.
		if (isabellaFollower() && flags[kFLAGS.VALARIA_AT_CAMP] > 0 && flags[kFLAGS.ISABELLA_VALERIA_SPARRED] == 0) {
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
		if (player.pregnancyIncubation <= 280 && player.pregnancyType == PregnancyStore.PREGNANCY_COTTON &&
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
		if (flags[kFLAGS.ZENJI_PROGRESS] == 11 && !ZenjiScenes.ZenjiMarried && campCorruptJojo() && rand(4) == 0) {
			finter.zenjiFreaksOverJojo();
			hideMenus();
			return;
		}
		//Zenji freaks out about corrupted celess
		if (flags[kFLAGS.ZENJI_PROGRESS] == 11 && CelessScene.instance.isCorrupt && !CelessScene.instance.setDeadOrRemoved() && rand(4) == 0) {
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
		//Go through Helia's first time move in interactions if  you haven't yet.
		if (flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 2 && SceneLib.helScene.followerHel() && flags[kFLAGS.HEL_INTROS_LEVEL] == 0) {
			helFollower.helFollowersIntro();
			hideMenus();
			return;
		}
		//If you've gone through Hel's first time actions and Issy moves in without being okay with threesomes.
		if (flags[kFLAGS.HEL_INTROS_LEVEL] > 9000 && SceneLib.helScene.followerHel() && isabellaFollower() && flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] == 0) {
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
		var isAWerewolf:Boolean = (player.isWerewolf());
		var placesAtTheNight:Boolean = (placesKnownNight());
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
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 4) outputText("massive");
			else if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 3) outputText("large");
			else outputText("small");
			outputText(" ring toward side of your [camp].");
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 3) outputText(" Given how large the sparring ring, maybe it's a little excessive for even the largest of people around..");
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
			else outputText("A large arcane circle is");
			outputText(" written at the edge of your [camp]. Their runes regularly glow with impulse of power.\n\n");
		}
		if (flags[kFLAGS.CAMP_UPGRADES_DAM] >= 1) {
			if (flags[kFLAGS.CAMP_UPGRADES_DAM] == 3) outputText("A big, wooden dam noticably increases the width of the nearby stream, slowing the water to a near still. It's created a small bay next to camp.");
			else if (flags[kFLAGS.CAMP_UPGRADES_DAM] == 2) outputText("A wooden dam noticably increases the width of the nearby stream, slowing the passage of water");
			else outputText("A small wooden dam drapes across the stream, slowing the passage of water");
			outputText(".\n\n");
		}
		if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 1) {
			outputText("Not so far from it is your ");
			if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 1) outputText("small");
			if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 2) outputText("medium-sized");
			if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 3) outputText("big");
			if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 4) outputText("large");
			outputText(" fishery. You can see several barrels at its side to store any fish that are caught.\n\n");
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
			outputText("Thick wooden walls have been erected; they surround half of your [camp] perimeter and provide sound defense, leaving the the open half for access to the stream.  ");
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
			outputText("Since Ember began " + emberMF("his", "her") + " 'crusade' against the minotaur population, skulls have begun to pile up on either side of the entrance to " + emberScene.emberMF("his", "her") + " den.  There're quite a lot of them.\n\n");
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
		if (player.lust >= player.maxOverLust()) {
			if (player.hasStatusEffect(StatusEffects.Dysfunction)) {
				outputText("<b>You are debilitatingly aroused, but your sexual organs are so numbed the only way to get off would be to find something tight to fuck or get fucked...</b>\n\n");
			} else if (flags[kFLAGS.UNABLE_TO_MASTURBATE_BECAUSE_CENTAUR] > 0 && player.isTaur()) {
				outputText("<b>You are delibitatingly aroused, but your sex organs are so difficult to reach that masturbation isn't at the forefront of your mind.</b>\n\n");
			} else if (player.hasStatusEffect(StatusEffects.IsRaiju) || player.hasStatusEffect(StatusEffects.IsThunderbird)) {
				outputText("<b>You are delibitatingly aroused, but have no ways to reach true release on your own. The first thing up your mind right now is to find a partner willing or unwilling to discharge yourself into.</b>\n\n");
			} else {
				outputText("<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>\n\n");
				exploreEvent = null;
				placesEvent = null;
				//This once disabled the ability to rest, sleep or wait, but ir hasn't done that for many many builds
			}
		}
		//Set up rest stuff
		//Night
		if (model.time.hours < 6 || model.time.hours > 20) {
			if (flags[kFLAGS.D3_GARDENER_DEFEATED] <= 0 && flags[kFLAGS.D3_CENTAUR_DEFEATED] <= 0 && flags[kFLAGS.D3_STATUE_DEFEATED] <= 0) outputText("It is dark out, made worse by the lack of stars in the sky.  A blood-red moon hangs in the sky, seeming to watch you, but providing little light.  It's far too dark to leave [camp].\n\n");
			else outputText("It is dark out. Stars dot the night sky. A blood-red moon hangs in the sky, seeming to watch you, but providing little light.  It's far too dark to leave [camp].\n\n");
			if (companionsCount() > 0 && !(model.time.hours > 4 && model.time.hours < 23)) {
				outputText("Your [camp] is silent as your companions are sleeping right now.\n");
			}
			if (canExploreAtNight || isAWerewolf){
			}
			else
			{
				exploreEvent = null;
				placesEvent = null;
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
		//Wood Elf weapon fix.
		if (!player.hasPerk(PerkLib.Rigidity) && ((flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] != 0) || (flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] != 0))) {
			if (player.weapon != WeaponLib.FISTS){
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

		menu();
		addButton(0, "Explore", exploreEvent).hint("Explore to find new regions and visit any discovered regions.");
		if ((canExploreAtNight || isAWerewolf || placesAtTheNight) && (model.time.hours < 6 || model.time.hours > 20)) addButton(1, "Places (N)", placesAtNight).hint("Visit any places you have discovered so far. (Night)");
		else addButton(1, "Places (D)", placesEvent).hint("Visit any places you have discovered so far. (Daylight)");
		addButton(2, "Inventory", inventory.inventoryMenu).hint("The inventory allows you to use an item.  Be careful, as this leaves you open to a counterattack when in combat.");
    if (inventory.showStash()) addButton(3, "Stash", inventory.stash).hint("The stash allows you to store your items safely until you need them later.");
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 2) addButton(4, "Warehouse", inventory.warehouse).hint("The warehouse and granary allow you to store your items in a more organized manner.");
		if (followersCount() > 0) addButton(5, "Followers", campFollowers).hint("Check up on any followers or companions who are joining you in or around your [camp].  You'll probably just end up sleeping with them.");
		if (loversCount() > 0) addButton(6, "Lovers", campLoversMenu).hint("Check up on any lovers you have invited to your [camp] so far and interact with them.");
		if (slavesCount() > 0) addButton(7, "Slaves", campSlavesMenu).hint("Check up on any slaves you have received and interact with them.");
		addButton(8, "Camp Actions", campActions).hint("Read your codex, questlog or interact with the [camp] surroundings.");
		if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10 || flags[kFLAGS.CAMP_BUILT_CABIN] >= 1) addButton(9, "Enter Cabin", cabinProgress.initiateCabin).hint("Enter your cabin."); //Enter cabin for furnish.
		if (player.hasPerk(PerkLib.JobSoulCultivator) || debug) addButton(10, "Soulforce", soulforce.accessSoulforceMenu).hint("Spend some time on the cultivation, or spend some of the soulforce.");
		else if (!player.hasPerk(PerkLib.JobSoulCultivator) && player.hasPerk(PerkLib.Metamorph)) addButton(10, "Metamorph", SceneLib.metamorph.openMetamorph).hint("Use your soulforce to mold your body.");
		if (player.lust >= 30) {
			addButton(11, "Masturbate", SceneLib.masturbation.masturbateMenu);
			if ((((player.hasPerk(PerkLib.HistoryReligious) || player.hasPerk(PerkLib.PastLifeReligious)) && player.cor <= 66) || (player.hasPerk(PerkLib.Enlightened) && player.cor < 10)) && !(player.hasStatusEffect(StatusEffects.Exgartuan) && player.statusEffectv2(StatusEffects.Exgartuan) == 0)) addButton(11, "Meditate", SceneLib.masturbation.masturbateMenu);
		}
		addButton(12, "Wait", doWaitMenu).hint("Wait for one to twelve hours. Or until the night comes.");
		if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(12, "Rest", restMenu).hint("Rest for one to twelve hours. Or until fully healed / night comes.");
		if(((model.time.hours <= 5 || model.time.hours >= 21) && !canExploreAtNight) || (!isNightTime && canExploreAtNight)) {
			addButton(12, "Sleep", doSleep).hint("Turn yourself in for the night.");
			if(isAWerewolf && flags[kFLAGS.LUNA_MOON_CYCLE] == 8) {
				addButtonDisabled(12, "Sleep", "Try as you may you cannot find sleep tonight. The damn moon won't let you rest as your urges to hunt and fuck are on the rise.");
			}
		}

		//Remove buttons according to conditions.
		if (isNightTime) {
			if (model.time.hours >= 22 || model.time.hours < 6) {
				if (nightTimeActiveFollowers() == 0) removeButton(5); //Followers
				if (nightTimeActiveLovers() == 0) removeButton(6); //Lovers
				if (nightTimeActiveSlaves() == 0) removeButton(7); //Slaves
				removeButton(8); //Camp Actions
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
		if (player.minLust() >= player.maxLust() && !flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= 168 && !player.eggs() >= 20 && !player.hasStatusEffect(StatusEffects.BimboChampagne) && !player.hasStatusEffect(StatusEffects.Luststick) && player.jewelryEffectId != 1) {
			badEndMinLust();
			return;
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
		if (flags[kFLAGS.VALARIA_AT_CAMP] == 1) counter++;
		if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] > 0) counter++;
		if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] > 0) counter++;
		if (player.hasStatusEffect(StatusEffects.PureCampJojo)) counter++;
		if (player.hasStatusEffect(StatusEffects.CampRathazul)) counter++;
		if (followerShouldra()) counter++;
		if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) counter++;
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
		if (flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2) counter++;
		if (flags[kFLAGS.SIDONIE_FOLLOWER] >= 1) counter++;
		if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) counter++;
		if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 0) counter++;
		if (flags[kFLAGS.TIFA_FOLLOWER] > 5) counter++;
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
		if (bimboSophie() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) counter++;//Bimbo sophie
		if (flags[kFLAGS.GALIA_LVL_UP] >= 1) counter++;
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] >= 5) counter++;
		if (ceraphIsFollower()) counter++;
		if (milkSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0) counter++;
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
		if (flags[kFLAGS.ALVINA_FOLLOWER] > 19) counter++;
		if (arianScene.arianFollower()) counter++;
		if (BelisaFollower.BelisaInCamp) counter++;
		if (LilyFollower.LilyFollowerState) counter++;
		if (TyrantiaFollower.TyrantiaFollowerStage >= 4) counter++;
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5 && !player.hasStatusEffect(StatusEffects.ChiChiOff)) counter++;
		if (flags[kFLAGS.CEANI_FOLLOWER] > 0) counter++;
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 6 && !player.hasStatusEffect(StatusEffects.DianaOff)) counter++;
		if (flags[kFLAGS.ELECTRA_FOLLOWER] > 1 && !player.hasStatusEffect(StatusEffects.ElectraOff)) counter++;
		if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) counter++;
		if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) counter++;
		if (followerHel()) counter++;
		//Izma!
		if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) counter++;
		if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) counter++;
		if (player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) counter++;
		if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) counter++;
		if (followerKiha()) counter++;
		if (flags[kFLAGS.NIEVE_STAGE] == 5) counter++;
		if (flags[kFLAGS.ANT_WAIFU] > 0) counter++;
		if (flags[kFLAGS.SAMIRAH_FOLLOWER] > 9) counter++;
		if (flags[kFLAGS.ZENJI_PROGRESS] == 11) counter++;
		for each (var npc:XXCNPC in _campFollowers) {
			if (npc.isCompanion(XXCNPC.LOVER)) {
				counter++;
			}
		}
		return counter;
	}

	public function loversHotBathCount():Number {
		var counter:Number = 0;
		if (flags[kFLAGS.ALVINA_FOLLOWER] > 12) counter++;
		//if (BelisaFollower.BelisaInCamp) counter++;
		//if (LilyFollower.LilyFollowerState) counter++;
		//if (TyrantiaFollower.TyrantiaFollowerStage >= 4) counter++;
		if (emberScene.followerEmber()) counter++;
		if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) counter++;
		if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) counter++;
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5 && !player.hasStatusEffect(StatusEffects.ChiChiOff)) counter++;
		if (flags[kFLAGS.CEANI_FOLLOWER] > 0) counter++;
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 6 && !player.hasStatusEffect(StatusEffects.DianaOff)) counter++;
		if (flags[kFLAGS.ELECTRA_FOLLOWER] > 1 && !player.hasStatusEffect(StatusEffects.ElectraOff)) counter++;
		if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) counter++;
		if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) counter++;
		if (followerHel()) counter++;
		if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) counter++;
		if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) counter++;
		if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) counter++;
		//if (flags[kFLAGS.DINAH_LVL_UP] >= 1) counter++;
		//if (flags[kFLAGS.GALIA_LVL_UP] >= 1) counter++;
		//if (flags[kFLAGS.MICHIKO_FOLLOWER] >= 1) counter++;
		if (flags[kFLAGS.ZENJI_PROGRESS] == 8 || flags[kFLAGS.ZENJI_PROGRESS] == 9 || flags[kFLAGS.ZENJI_PROGRESS] == 11) counter++;
		if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) counter++;
		if (flags[kFLAGS.MITZI_RECRUITED] >= 4) counter++;
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
		if (flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2) counter++;
		if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 3) counter++;
		if (emberScene.followerEmber() && flags[kFLAGS.EMBER_GENDER] == 1) counter++;
		return counter;
	}

	public function sparableCampMembersCount():Number {
		var counter:Number = 0;
		if (emberScene.followerEmber()) counter++;
		if (flags[kFLAGS.AURORA_LVL] >= 1) counter++;
		if (flags[kFLAGS.VALARIA_AT_CAMP] == 1) counter++;
		if (EvangelineFollower.EvangelineFollowerStage >= 1) counter++;
		if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) counter++;
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 6 && !player.hasStatusEffect(StatusEffects.DianaOff)) counter++;
		if (flags[kFLAGS.DINAH_LVL_UP] >= 1) counter++;
		//if (flags[kFLAGS.GALIA_LVL_UP] >= 1) counter++;
		if (flags[kFLAGS.NEISA_FOLLOWER] >= 7) counter++;
		if (flags[kFLAGS.ZENJI_PROGRESS] == 8 || flags[kFLAGS.ZENJI_PROGRESS] == 9) counter++;
		if (helspawnFollower()) counter++;
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5 && !player.hasStatusEffect(StatusEffects.ChiChiOff)) counter++;
		if (flags[kFLAGS.CEANI_FOLLOWER] > 0) counter++;
		if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) counter++;
		if (flags[kFLAGS.LUNA_FOLLOWER] > 10 && !player.hasStatusEffect(StatusEffects.LunaOff)) counter++;
		if (followerHel()) counter++;
		if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) counter++;
		if (followerKiha()) counter++;
		return counter;
	}

	public function nightTimeActiveFollowers():Number {
		var counter:Number = 0;
		if (followerShouldra()) counter++;
		if (flags[kFLAGS.LUNA_FOLLOWER] > 10 && !player.hasStatusEffect(StatusEffects.LunaOff)) counter++;
		return counter;
	}

	public function nightTimeActiveLovers():Number {
		var counter:Number = 0;
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
				Holidays.DLCPrompt("Lovers DLC", "Get the Lovers DLC to be able to interact with them and have sex! Start families! The possibilities are endless!", "$4.99", doCamp);
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
			if (flags[kFLAGS.ALVINA_FOLLOWER] > 19) {
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
				buttons.add("Belisa", SceneLib.belisa.BelisaMainCampMenu).hint("Visit Belisa.");
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
				outputText("You can see Chi Chi not so far from Jojo. She’s busy practicing her many combos on a dummy. Said dummy will more than likely have to be replaced within twenty four hours.\n\n");
				if (player.statusEffectv4(StatusEffects.CampLunaMishaps2) > 0) buttons.add("Chi Chi", SceneLib.chichiScene.ChiChiCampMainMenu2).disableIf(player.statusEffectv4(StatusEffects.CampLunaMishaps2) > 0, "Wet.");
				else buttons.add("Chi Chi", SceneLib.chichiScene.ChiChiCampMainMenu2).disableIf(player.statusEffectv2(StatusEffects.CampSparingNpcsTimers2) > 0, "Training.");
			}
			//Diana
			if (flags[kFLAGS.DIANA_FOLLOWER] >= 6 && !player.hasStatusEffect(StatusEffects.DianaOff)) {
				outputText("Diana is resting next to her many medical tools and medicines.\n\n");
				buttons.add("Diana", SceneLib.dianaScene.mainCampMenu).disableIf(player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) > 0, "Training.");
			}
			//Electra
			if (flags[kFLAGS.ELECTRA_FOLLOWER] > 1 && !player.hasStatusEffect(StatusEffects.ElectraOff)) {
				outputText("Electra is quietly resting in the grass. Occasional static jolts zap nearby bugs that gets too close.\n\n");
				buttons.add("Electra", SceneLib.electraScene.ElectraCampMainMenu).disableIf(player.statusEffectv3(StatusEffects.CampSparingNpcsTimers4) > 0, "Training.");
			}
			//Etna
			if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) {
				outputText("Etna is resting lazily on a rug in a very cat-like manner. She’s looking at you always with this adorable expression of hers, her tail wagging expectantly at your approach.\n\n");
				if (player.statusEffectv1(StatusEffects.CampLunaMishaps2) > 0) buttons.add("Etna", SceneLib.etnaScene.etnaCampMenu2).disableIf(player.statusEffectv1(StatusEffects.CampLunaMishaps2) > 0, "Sleeping.");
				else buttons.add("Etna", SceneLib.etnaScene.etnaCampMenu2).disableIf(player.statusEffectv4(StatusEffects.CampSparingNpcsTimers1) > 0, "Training.");
			}
			//Excellia Lover
			if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) {
				outputText("Excellia seems to be working on her combat skills against a training dummy. " + (SceneLib.excelliaFollower.totalExcelliaChildren() > 1 ? "She shows her children a few fighting techniques as they watch her attentively. Some even practice them with friendly spars between one another. " : "") + "When she notices you, she gives a friendly nod before going back to pummeling the dummy.\n\n");
				buttons.add("Excellia", SceneLib.excelliaFollower.ExcelliaCampMainMenuFixHer).hint("Visit Excellia.");
			}
			//Helia
			if (SceneLib.helScene.followerHel()) {
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
					buttons.add("Izma", izmaScene.izmaFollowerMenu2).disableIf(player.statusEffectv4(StatusEffects.CampLunaMishaps1) > 0, "Fish smell.");
				}
			}
			//Kiha!
			if (followerKiha()) {
				//(6-7)
				if (model.time.hours < 7) outputText("Kiha is sitting near the fire, her axe laying across her knees as she polishes it.\n\n");
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
				if (player.statusEffectv3(StatusEffects.CampLunaMishaps1) > 0) buttons.add("Kiha", kihaScene.encounterKiha2).disableIf(player.statusEffectv3(StatusEffects.CampLunaMishaps1) > 0, "Cleaning burnt meat.");
				else buttons.add("Kiha", kihaScene.encounterKiha2).disableIf(player.statusEffectv3(StatusEffects.CampSparingNpcsTimers1) > 0, "Training.");
			}
			//Lily
			if (LilyFollower.LilyFollowerState && !DriderTown.DriderTownComplete) {
				outputText("A line of targets have been set up along the river and a small house of silk has been constructed in one of the trees. You hear the occasional whizz of arrows, or rustling in the trees.\n\n");
				buttons.add("Lily", SceneLib.lily.LilyCampFollower).hint("Visit Lily.");
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
			if (TyrantiaFollower.TyrantiaFollowerStage >= 4 && !DriderTown.DriderTownComplete) {
				outputText("A decent distance away from your camp, in between the river and some trees, a hut’s been erected. Constructed mostly from stone and logs, with odd, goopy webbing as a crude mortar, the dwelling is nonetheless huge. ");
				outputText("Tyrantia occasionally walks into the dwelling, coming out with a different tool or material. She’s keeping herself busy, if the line of demon skulls around the house are any indication.\n\n");
				buttons.add("Tyrantia", SceneLib.tyrania.TyrantiaAtCamp).hint("Visit Tyrantia.");
			}
			//Zenji
			if (flags[kFLAGS.ZENJI_PROGRESS] == 11 && TrollVillage.ZenjiVillageStage != 2) {
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
				Holidays.nieveCampDescs();
				outputText("\n\n");
				buttons.add("Nieve", Holidays.approachNieve);
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
				Holidays.DLCPrompt("Slaves DLC", "Get the Slaves DLC to be able to interact with them. Show them that you're dominating!", "$4.99", doCamp);
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
			//Galia
			if (flags[kFLAGS.GALIA_LVL_UP] >= 1 && EvangelineFollower.EvangelineFollowerStage >= 1) {
				if (flags[kFLAGS.GALIA_AFFECTION] < 10) outputText("Near the [camp] edge nearly next to Evangeline bedroll sits a large wooden cage for keeping female imp brought back from Adventure Guild. Despite been one of those more feral she most of the time spend sitting motionlessly and gazing into the horizon.\n\n");
				else outputText("Nothing to see here yet.\n\n");
			}
			//Excellia Slave
			if (flags[kFLAGS.EXCELLIA_RECRUITED] == 2) {
				outputText("Excellia sits near your " + (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "cabin" : "tent") + ". " + (SceneLib.excelliaFollower.totalExcelliaChildren() > 1 ? "Her children clamor around, groping, suckling, and licking at her supple flesh. She moos loudly as they have their way with her. When she finally notices you, she beckons for you to join too." : "She moos faintly as she idly caresses her own full breasts and wet snatch. When she notices you, she spreads her legs a bit and her tail eagerly swishes back and forth, hoping you'll come over.") + "\n\n");
				buttons.add("Excellia", SceneLib.excelliaFollower.ExcelliaCampMainMenuMakeSlave).hint("Visit Excellia.");
			}
			//Patchouli
			if (flags[kFLAGS.PATCHOULI_FOLLOWER] >= 5) {
				if (flags[kFLAGS.PATCHOULI_FOLLOWER] == 5) outputText("Patchouli is still tied to a tree. Even incapacitated in this way, he keeps grinning at you, as if taunting you.\n\n");
				if (flags[kFLAGS.PATCHOULI_FOLLOWER] >= 6) outputText("Patchoulie is lazily resting on a branch in the nearby tree. When she looks at you, she always has that unsettling smile of hers, as if taunting you.\n\n");
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
			if (bimboSophie() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
				sophieBimbo.sophieCampLines();
				buttons.add("Sophie", sophieBimbo.approachBimboSophieInCamp);
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
			if (flags[kFLAGS.ALVINA_FOLLOWER] > 12 && flags[kFLAGS.ALVINA_FOLLOWER] < 20) {
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
			if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
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
			//Valaria
			if (flags[kFLAGS.VALARIA_AT_CAMP] == 1 && flags[kFLAGS.TOOK_GOO_ARMOR] == 1) {
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
						if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] < 10) outputText("  Some kind of spider-silk-based equipment is hanging from a nearby rack.");
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
					switch (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275]) {
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
			if (flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2) {
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
				outputText("Ayane is tiddying your items to make sure everything is clean and well organised.\n\n");
				buttons.add("Ayane", SceneLib.ayaneFollower.ayaneCampMenu).hint("Visit Ayane a kitsune priestess of Taoth.");
			}
			if (SceneLib.ayaneFollower.ayaneChildren() == 1){
				outputText("You can see Ayane's child are playing around in the grass.\n\n");
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
		if (followerShouldra()) {
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
		clearOutput();
		outputText("What would you like to do?");
		addButton(0, "Build", campBuildingSim).hint("Check your [camp] build options.");
		if (player.hasPerk(PerkLib.JobElementalConjurer) || player.hasPerk(PerkLib.JobGolemancer) || player.hasPerk(PerkLib.PrestigeJobNecromancer)) addButton(1, "Winions", campWinionsArmySim).hint("Check your options for making some Winions.");
		else addButtonDisabled(1, "Winions", "You need to be able to make some minions that fight for you to use this option.");
		addButton(2, "Misc", campMiscActions).hint("Misc options to do things in and around [camp].");
		addButton(3, "SpentTime", campSpendTimeActions).hint("Check your options to spend time in and around [camp].");
		addButton(4, "NPC's", SparrableNPCsMenu);
		//addButton(5, "Craft", kGAMECLASS.crafting.accessCraftingMenu).hint("Craft some items.");
		if (player.hasStatusEffect(StatusEffects.CampRathazul)) addButton(7, "Herbalism", HerbalismMenu).hint("Use ingrediants to craft poultrice and battle medicines.")
		else addButtonDisabled(7, "Herbalism", "Would you kindly find Rathazul first?");
		if (Crafting.BagSlot01Cap > 0) addButton(8, "Materials", SceneLib.crafting.accessCraftingMaterialsBag).hint("Manage your bag with crafting materials.");
		else addButtonDisabled(8, "Materials", "You have to find bag for materials.");
		if (AdventurerGuild.Slot01Cap > 0) addButton(9, "Quest Loot", questItemsBag).hint("Manage your bag with quest items.");
		else addButtonDisabled(9, "Quest Loot", "You have to join Adventure Guild to have bag for quest items.");
		addButton(10, "Questlog", questlog.accessQuestlogMainMenu).hint("Check your questlog.");
		addButton(11, "Recall", recallScenes).hint("Recall some of the unique events happened during your adventure.");
		if (player.explored >= 1) addButton(12, "Dummy", DummyTraining).hint("Train your mastery level on this dummy.");
		if (flags[kFLAGS.LETHICE_DEFEATED] > 0) addButton(13, "Ascension", promptAscend).hint("Perform an ascension? This will restart your adventures with your items, and gems carried over. The game will also get harder.");
		else addButtonDisabled(13, "Ascension", "Don't you have a job to finish first. Like... to defeat someone, maybe Lethice?");
		addButton(14, "Back", playerMenu);
	}

	private function campSpendTimeActions():void {
		menu();
		addButton(0, "SwimInStream", swimInStream).hint("Swim in stream and relax to pass time.", "Swim In Stream");
		addButton(1, "ExaminePortal", examinePortal).hint("Examine the portal. This scene is placeholder.", "Examine Portal"); //Examine portal.
		if (model.time.hours == 19) {
			addButton(2, "Watch Sunset", watchSunset).hint("Watch the sunset and relax."); //Relax and watch at the sunset.
		} else if (model.time.hours >= 20 && flags[kFLAGS.LETHICE_DEFEATED] > 0) {
			addButton(2, "Stargaze", watchStars).hint("Look at the starry night sky."); //Stargaze. Only available after Lethice is defeated.
		} else {
			addButtonDisabled(2, "Watch Sky", "The option to watch sunset is available at 7pm.");
		}
		addButton(3, "Read Codex", codex.accessCodexMenu).hint("Read any codex entries you have unlocked.");
		if (player.hasKeyItem("Gryphon Statuette") >= 0) addButton(9, "Gryphon", useGryphonStatuette);
		if (player.hasKeyItem("Peacock Statuette") >= 0) addButton(9, "Peacock", usePeacockStatuette);
		addButton(14, "Back", campActions);
	}

	private function campBuildingSim():void {
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
		if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] >= 4) addButton(3, "Hot Spring", campScenes.HotSpring).hint("Visit Hot Spring.");
		else addButtonDisabled(3, "Hot Spring", "Would you kindly build it first?");
		if (player.hasPerk(PerkLib.CursedTag)) addButton(4, "AlterBindScroll", AlterBindScroll).hint("Alter Bind Scroll - DIY aka modify your cursed tag");
		else addButtonDisabled(4, "Alter Bind Scroll", "Req. to be Jiangshi and having Cursed Tag perk.");
		if (player.hasItem(consumables.LG_SFRP, 10) && (player.hasItem(useables.E_P_BOT, 1))) addButton(5, "Fill bottle", fillUpPillBottle00).hint("Fill up one of your pill bottles with low-grade soulforce recovery pills.");
		else addButtonDisabled(5, "Fill bottle", "You need one empty pill bottle and ten low-grade soulforce recovery pills.");
		if (player.hasItem(consumables.MG_SFRP, 10) && (player.hasItem(useables.E_P_BOT, 1))) addButton(6, "Fill bottle", fillUpPillBottle01).hint("Fill up one of your pill bottles with mid-grade soulforce recovery pills.");
		else addButtonDisabled(6, "Fill bottle", "You need one empty pill bottle and ten mid-grade soulforce recovery pills.");
		if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) addButton(10, "Clone", VisitClone).hint("Check on your clone.");
		else addButtonDisabled(10, "Clone", "Would you kindly go face F class Heaven Tribulation first?");
		if (player.hasItem(useables.ENECORE, 1) && flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] < 200) addButton(12, "E.Core", convertingEnergyCoreIntoFlagValue).hint("Convert Energy Core item into flag value.");
		if (player.hasItem(useables.MECHANI, 1) && flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES] < 200) addButton(13, "C.Mechan", convertingMechanismIntoFlagValue).hint("Convert Mechanism item into flag value.");
		addButton(14, "Back", campActions);
	}
	private function convertingEnergyCoreIntoFlagValue():void {
		clearOutput();
		outputText("1 Energy Core converted succesfully.");
		player.destroyItems(useables.ENECORE, 1);
		flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] += 1;
		doNext(campMiscActions);
	}
	private function convertingMechanismIntoFlagValue():void {
		clearOutput();
		outputText("1 Mechanism converted succesfully.");
		player.destroyItems(useables.MECHANI, 1);
		flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES] += 1;
		doNext(campMiscActions);
	}

	public function campWinionsArmySim():void {
		clearOutput();
		outputText("On which group of minions you want to check on?");
		menu();
		if (player.hasPerk(PerkLib.JobGolemancer)) addButton(0, "Make", campMake.accessMakeWinionsMainMenu).hint("Check your options for making some golems.");
		else addButtonDisabled(0, "Make", "You need to be golemancer to use this option.");
		if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] > 0) addButton(1, "Summon", campMake.accessSummonElementalsMainMenu).hint("Check your options for managing your elemental summons.");
		else addButtonDisabled(1, "Summon", "You should first build Arcane Circle. Without some tools from the carpenter's toolbox it would be near impossible to do this.");
		if (player.hasPerk(PerkLib.PrestigeJobNecromancer)) addButton(5, "Skeletons", campMake.accessMakeSkeletonWinionsMainMenu).hint("Check your options for making some skeletons.");
		else addButtonDisabled(5, "Skeletons", "You need to be necromancer to use this option.");
		if (player.hasPerk(PerkLib.PrestigeJobDruid)) addButton(6, "Fusions", druidMenu);
		else addButtonDisabled(6, "Fusions", "You need to be druid to use this option.");
		if (((flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1 || flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 3 || flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 4) && (flags[kFLAGS.PLAYER_COMPANION_1] != "" || flags[kFLAGS.PLAYER_COMPANION_2] != "" || flags[kFLAGS.PLAYER_COMPANION_3] != "")) || player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) addButton(10, "SimpPreTurn", simplifiedPreTurn);
		addButton(14, "Back", campActions);
	}
	private function druidMenu():void {
		clearOutput();
		outputText("Would you like to fuse with an elemental and if so which?");
		if (player.hasPerk(PerkLib.SharedPower)) outputText("\n\n+"+player.perkv1(PerkLib.SharedPower)+"0% multi bonus to health, damage and spell power when in an infused state");//temporaly to check if perk working as intended
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
		if (player.hasPerk(PerkLib.GreaterSharedPower)) dmSPPC *= 2;
		return dmSPPC;
	}
	private function simplifiedPreTurn():void {
		menu();
		if (player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) {
			addButtonDisabled(1, "On", "It's already On ^^");
			addButton(2, "Off", simplifiedPreTurnOff);
		}
		else {
			addButton(1, "On", simplifiedPreTurnOn);
			addButtonDisabled(2, "Off", "It's already Off ^^");
		}
		addButton(3, "Back", campWinionsArmySim);
	}
	private function simplifiedPreTurnOn():void {
		player.createStatusEffect(StatusEffects.SimplifiedNonPCTurn,0,0,0,0);
		simplifiedPreTurn();
	}
	private function simplifiedPreTurnOff():void {
		player.removeStatusEffect(StatusEffects.SimplifiedNonPCTurn);
		simplifiedPreTurn();
	}

	private function HerbalismMenu():void {
		hideMenus();
		clearOutput();
		menu();
		outputText("You move to Rathazul’s side alchemy equipment. Using these tools you can process raw natural materials into poultices and medicines.\n\nWhat would you like to craft?");
		//Poultrice
		addButton(0, "Poultice", HerbalismCraftItem,CoC.instance.consumables.HEALHERB, "healing herb", PotionType.POULTICE).hint("Craft a Poultrice using healing herb.\n\nHealing herbs currently owned "+player.itemCount(CoC.instance.consumables.HEALHERB)+"")
				.disableIf(player.itemCount(CoC.instance.consumables.HEALHERB) == 0, "You lack the ingrediants to craft this item.\n\nHealing herbs currently owned "+player.itemCount(CoC.instance.consumables.HEALHERB)+"");
		//Energy drink
		addButton(1, "Energy drink", HerbalismCraftItem,CoC.instance.consumables.MOONGRASS, "moon grass", PotionType.ENERGYDRINK).hint("Craft a Energy drink using moon grass.\n\nMoon grass currently owned "+player.itemCount(CoC.instance.consumables.MOONGRASS)+"");
		if (player.herbalismLevel < 2) button(1).disable("You lack the skill to craft this item.\n\nRequire Herbalism level 2");
		if (player.itemCount(CoC.instance.consumables.MOONGRASS) == 0) button(1).disable("You lack the ingrediants to craft this item. \n\nMoon grass currently owned "+player.itemCount(CoC.instance.consumables.MOONGRASS)+"");
		//Cure
		addButton(2, "Cure", HerbalismCraftItem,CoC.instance.consumables.SNAKEBANE, "snakebane flower", PotionType.CURE).hint("Craft a Cure using snakebane flower.\n\nSnakebane flower currently owned "+player.itemCount(CoC.instance.consumables.SNAKEBANE)+"");
		if (player.herbalismLevel < 4) button(2).disable("You lack the skill to craft this item.\n\nRequire Herbalism level 4");
		if (player.itemCount(CoC.instance.consumables.SNAKEBANE) == 0) button(2).disable("You lack the ingrediants to craft this item. \n\nSnakebane flower currently owned "+player.itemCount(CoC.instance.consumables.SNAKEBANE)+"");
		//Painkiller
		addButton(3, "Painkiller", HerbalismCraftItem,CoC.instance.consumables.IRONWEED, "ironweed", PotionType.PAINKILLER).hint("Craft a Painkiller using ironweed.\n\nIronweed currently owned "+player.itemCount(CoC.instance.consumables.IRONWEED)+"");
		if (player.herbalismLevel < 6) button(3).disable("You lack the skill to craft this item.\n\nRequire Herbalism level 6");
		if (player.itemCount(CoC.instance.consumables.IRONWEED) == 0) button(3).disable("You lack the ingrediants to craft this item. \n\nIronweed currently owned "+player.itemCount(CoC.instance.consumables.IRONWEED)+"");
		//Stimulant
		addButton(4, "Stimulant", HerbalismCraftItem,CoC.instance.consumables.BLADEFERN, "blade ferns", PotionType.STIMULANT).hint("Craft a Stimulant using a handfull of blade ferns.\n\nBlade ferns currently owned "+player.itemCount(CoC.instance.consumables.BLADEFERN)+"");
		if (player.herbalismLevel < 8) button(4).disable("You lack the skill to craft this item.\n\nRequire Herbalism level 8");
		if (player.itemCount(CoC.instance.consumables.BLADEFERN) == 0) button(4).disable("You lack the ingrediants to craft this item. \n\nBlade ferns currently owned "+player.itemCount(CoC.instance.consumables.BLADEFERN)+"");
		//Perfume
		addButton(5, "Perfume", HerbalismCraftItem,CoC.instance.consumables.RAUNENECT, "alraune nectar", PotionType.PERFUME).hint("Craft a Perfume using Alraune nectar.\n\nAlraune nectar currently owned "+player.itemCount(CoC.instance.consumables.RAUNENECT)+"");
		if (player.herbalismLevel < 10) button(5).disable("You lack the skill to craft this item.\n\nRequire Herbalism level 10");
		if (player.itemCount(CoC.instance.consumables.RAUNENECT) == 0) button(5).disable("You lack the ingrediants to craft this item. \n\nAlraune nectar currently owned "+player.itemCount(CoC.instance.consumables.RAUNENECT)+"");
		//THE GARDEN!
		addButton(10, "Garden", Garden).hint("Manage your garden of medicinal plants")
		//.disableIf(1!=1, "You haven't built a garden yet."); //TO DO
		addButton(14, "Back", campActions);
	}

	private function Garden():void{
		hideMenus();
		clearOutput();
		menu();
		//Checks if pc has this ingrediant growing
		outputText("You move over to your gardening fields. You can plant and grow herbs here.");
		//plants typicaly takes 1 week to grow from a single ingrediant into 5 new ingrediants sample player can use this button to go to the harvest selection
		addButton(1, "Seed", Seed).hint("Plant down some seeds sacrificing an ingrediants.");
		addFiveArgButton(2, "Harvest", Harvest, HarvestMoonScenes.harvestmoonstageHH >= 1, HarvestMoonScenes.harvestmoonstageMG >= 1, HarvestMoonScenes.harvestmoonstageSB >= 1, HarvestMoonScenes.harvestmoonstageIW >= 1, HarvestMoonScenes.harvestmoonstageBF >= 1).hint("Check your harvests.")
		addButton(14, "Back", HerbalismMenu);
	}

	private function Seed():void{
		hideMenus();
		clearOutput();
		menu();
		outputText("What kind of herb would you like to grow?");
		addButton(0, "Healing herb", Seed2,CoC.instance.consumables.HEALHERB).hint("Plant new seeds.");
		if (HarvestMoonScenes.harvestmoonstageHH >= HarvestMoonScenes.HARVESTMOONPENDINGHH) addButtonDisabled(0,"Healing herb", "You already got crops growing.");
		else if (player.itemCount(CoC.instance.consumables.HEALHERB) == 0) addButtonDisabled(0,"Healing herb", "You lack a plant sample to get seeds from.");
		addButton(1, "Moon grass", Seed2,CoC.instance.consumables.MOONGRASS).hint("Harvest your ingrediants.");
		if (HarvestMoonScenes.harvestmoonstageMG >= HarvestMoonScenes.HARVESTMOONPENDINGMG) addButtonDisabled(1,"Moon grass", "You already got crops growing.");
		else if (player.itemCount(CoC.instance.consumables.MOONGRASS) == 0) addButtonDisabled(1,"Moon grass", "You lack a plant sample to get seeds from.");
		addButton(2, "Snakebane", Seed2,CoC.instance.consumables.SNAKEBANE).hint("Harvest your ingrediants.");
		if (HarvestMoonScenes.harvestmoonstageSB >= HarvestMoonScenes.HARVESTMOONPENDINGSB) addButtonDisabled(2,"Snakebane", "You already got crops growing.");
		else if (player.itemCount(CoC.instance.consumables.SNAKEBANE) == 0) addButtonDisabled(2,"Snakebane", "You lack a plant sample to get seeds from.");
		addButton(3, "Ironweed", Seed2,CoC.instance.consumables.IRONWEED).hint("Harvest your ingrediants.");
		if (HarvestMoonScenes.harvestmoonstageIW >= HarvestMoonScenes.HARVESTMOONPENDINGIW) addButtonDisabled(3,"Ironweed", "You already got crops growing.");
		else if (player.itemCount(CoC.instance.consumables.IRONWEED) == 0) addButtonDisabled(3, "Ironweed","You lack a plant sample to get seeds from.");
		addButton(4, "Blade fern", Seed2,CoC.instance.consumables.BLADEFERN).hint("Harvest your ingrediants.");
		if (HarvestMoonScenes.harvestmoonstageBF >= HarvestMoonScenes.HARVESTMOONPENDINGBF) addButtonDisabled(4,"Blade fern", "You already got crops growing.");
		else if (player.itemCount(CoC.instance.consumables.BLADEFERN) == 0) addButtonDisabled(4,"Blade fern", "You lack a plant sample to get seeds from.");
		addButton(14, "Back", Garden).hint("Go back to garden menu.");
	}

	public function Seed2(ItemID:SimpleConsumable):void{
		hideMenus();
		clearOutput();
		outputText("Planting a new herb will consume one of your herb items, proceed anyway?");
		doYesNo(curry(Seed3,ItemID), Seed);
	}

	public function Seed3(ItemID:SimpleConsumable):void{
		clearOutput();
		outputText("You begin carefully planting the");
		player.destroyItems(ItemID, 1);
		if (ItemID == CoC.instance.consumables.HEALHERB){
			HarvestMoonScenes.harvestmoonstageHH = HarvestMoonScenes.HARVESTMOONPENDINGHH;
			outputText("healing herb");
		}
		if (ItemID == CoC.instance.consumables.MOONGRASS){
			HarvestMoonScenes.harvestmoonstageMG = HarvestMoonScenes.HARVESTMOONPENDINGMG;
			outputText("moon grass");
		}
		if (ItemID == CoC.instance.consumables.SNAKEBANE) {
			HarvestMoonScenes.harvestmoonstageSB = HarvestMoonScenes.HARVESTMOONPENDINGSB;
			outputText("snakebane");
		}
		if (ItemID == CoC.instance.consumables.IRONWEED){
			HarvestMoonScenes.harvestmoonstageIW = HarvestMoonScenes.HARVESTMOONPENDINGIW;
			outputText("ironweed");
		}
		if (ItemID == CoC.instance.consumables.BLADEFERN){
			HarvestMoonScenes.harvestmoonstageBF = HarvestMoonScenes.HARVESTMOONPENDINGBF;
			outputText("bladefern");
		}
		outputText("into the fertile soil. It should grow back into several or more plants within a few days." +
				" Sometime you ponder if you shouldve just became a farmer back home you definitively have a knack for this.");
		var HE:Number = 20 + player.level;
		if (player.hasPerk(PerkLib.PlantKnowledge)) HE *= 2;
		if (player.hasPerk(PerkLib.NaturalHerbalism)) HE *= 2;
		player.herbXP(HE);
		doNext(Seed);
	}

	private function Harvest(HealingHerb:Boolean = false, MoonGrass:Boolean = false, Snakebane:Boolean = false, Ironweed:Boolean = false, BladeFern:Boolean = false):void{
		hideMenus();
		clearOutput();
		menu();
		outputText("You take a tour of your garden and survey your crops for readied harvests.");
		if (!HealingHerb && !MoonGrass && !Snakebane && !Ironweed && !BladeFern) outputText("\n\n There is no crops left to harvest you will need to plan new seeds.");
		if (HealingHerb)
		{
			addButton(0, "Healing herb", Harvest2,CoC.instance.consumables.HEALHERB,"Healing herbs").hint("Harvest your ingrediants.");
			if (HarvestMoonScenes.harvestmoonstageHH != HarvestMoonScenes.HARVESTMOONREADYHH) addButtonDisabled(0,"Healing herb","Your crops are still growing.");
		}
		if (MoonGrass)
		{
			addButton(1, "Moon grass", Harvest2,CoC.instance.consumables.MOONGRASS,"Moongrass").hint("Harvest your ingrediants.");
			if (HarvestMoonScenes.harvestmoonstageMG != HarvestMoonScenes.HARVESTMOONREADYMG) addButtonDisabled(1,"Moon grass","Your crops are still growing.");
		}
		if (Snakebane)
		{
			addButton(2, "Snakebane", Harvest2,CoC.instance.consumables.SNAKEBANE,"Snakebane").hint("Harvest your ingrediants.");
			if (HarvestMoonScenes.harvestmoonstageSB != HarvestMoonScenes.HARVESTMOONREADYSB) addButtonDisabled(2,"Snakebane","Your crops are still growing.");
		}
		if (Ironweed)
		{
			addButton(3, "Ironweed", Harvest2,CoC.instance.consumables.IRONWEED,"Ironweed").hint("Harvest your ingrediants.");
			if (HarvestMoonScenes.harvestmoonstageIW != HarvestMoonScenes.HARVESTMOONREADYIW) addButtonDisabled(3,"Ironweed","Your crops are still growing.");
		}
		if (BladeFern)
		{
			addButton(4, "Blade fern", Harvest2,CoC.instance.consumables.BLADEFERN,"Blade ferns").hint("Harvest your ingrediants.");
			if (HarvestMoonScenes.harvestmoonstageBF != HarvestMoonScenes.HARVESTMOONREADYBF) addButtonDisabled(4,"Blade fern","Your crops are still growing.");
		}
		addButton(14, "Back", Garden).hint("Go back to garden menu.")
	}

	public function Harvest2(ItemID:SimpleConsumable,IngrediantName:String):void{
		hideMenus();
		clearOutput();
		menu();
		if (ItemID == CoC.instance.consumables.HEALHERB) HarvestMoonScenes.harvestmoonstageHH = HarvestMoonScenes.HARVESTMOONNOTSTARTEDHH;
		if (ItemID == CoC.instance.consumables.MOONGRASS) HarvestMoonScenes.harvestmoonstageMG = HarvestMoonScenes.HARVESTMOONNOTSTARTEDMG;
		if (ItemID == CoC.instance.consumables.SNAKEBANE) HarvestMoonScenes.harvestmoonstageSB = HarvestMoonScenes.HARVESTMOONNOTSTARTEDSB;
		if (ItemID == CoC.instance.consumables.IRONWEED) HarvestMoonScenes.harvestmoonstageIW = HarvestMoonScenes.HARVESTMOONNOTSTARTEDIW;
		if (ItemID == CoC.instance.consumables.BLADEFERN) HarvestMoonScenes.harvestmoonstageBF = HarvestMoonScenes.HARVESTMOONNOTSTARTEDBF;
		outputText("Click to collect your "+IngrediantName+".");
		addButton(0, "Collect", curry(recoverHerbLoot,ItemID)).hint("Click to collect your "+IngrediantName+".");
	}

	public function recoverHerbLoot(ItemID:SimpleConsumable):void{
		clearOutput();
		inventory.takeItem(ItemID,curry(recoverHerbLoot2,ItemID));
	}
	public function recoverHerbLoot2(ItemID:SimpleConsumable):void{
		clearOutput();
		inventory.takeItem(ItemID,curry(recoverHerbLoot3,ItemID));
	}
	public function recoverHerbLoot3(ItemID:SimpleConsumable):void{
		clearOutput();
		inventory.takeItem(ItemID,curry(recoverHerbLoot4,ItemID));
	}
	public function recoverHerbLoot4(ItemID:SimpleConsumable):void{
		clearOutput();
		inventory.takeItem(ItemID,curry(recoverHerbLoot5,ItemID));
	}
	public function recoverHerbLoot5(ItemID:SimpleConsumable):void{
		clearOutput();
		inventory.takeItem(ItemID,recoverHerbLoot6);
	}
	public function recoverHerbLoot6():void{
		clearOutput();
		outputText("Youve collected all of the ingrediants.");
		doNext(curry(Harvest, HarvestMoonScenes.harvestmoonstageHH >= 1, HarvestMoonScenes.harvestmoonstageMG >= 1, HarvestMoonScenes.harvestmoonstageSB >= 1, HarvestMoonScenes.harvestmoonstageIW >= 1, HarvestMoonScenes.harvestmoonstageBF >= 1));
	}

	private function HerbalismCraftItem(ItemID:SimpleConsumable, IngrediantName:String, CraftingResult:PotionType):void {
		clearOutput();
		menu();
		outputText("Refine "+IngrediantName+" into a "+CraftingResult.name+"?");
		addButton(0, "Craft", HerbalismCraftItem2, ItemID, IngrediantName, CraftingResult);
		addButton(1, "Craft All", HerbalismCraftItem3, ItemID, IngrediantName, CraftingResult);
		addButton(2, "Cancel", HerbalismMenu);
	}

	public function HerbalismCraftItem2(ItemID:SimpleConsumable, IngrediantName:String, CraftingResult:PotionType):void {
		clearOutput();
		player.changeNumberOfPotions(CraftingResult,+1);
		if (player.hasPerk(PerkLib.NaturalHerbalism)){
			player.changeNumberOfPotions(CraftingResult,+2);
		}
		outputText("You spend the better part of the next hour refining the "+IngrediantName+" into a "+CraftingResult.name+" adding it to your bag.");
		if (player.hasPerk(PerkLib.NaturalHerbalism)) {
			outputText("Your natural knowledge of herbalism allowed you to craft two additionnal "+CraftingResult.name+".");
		}
		player.destroyItems(ItemID, 1);
		var HE:Number = 20 + player.level;
		if (player.hasPerk(PerkLib.PlantKnowledge)) HE *= 2;
		if (player.hasPerk(PerkLib.NaturalHerbalism)) HE *= 2;
		player.herbXP(HE);
		doNext(HerbalismMenu);
	}

	public function HerbalismCraftItem3(ItemID:SimpleConsumable, IngrediantName:String, CraftingResult:PotionType):void {
		clearOutput();

		player.changeNumberOfPotions(CraftingResult,player.itemCount(ItemID));
		if (player.hasPerk(PerkLib.NaturalHerbalism)){
			player.changeNumberOfPotions(CraftingResult,2*player.itemCount(ItemID));
		}
		outputText("You spend the better part of the next hour refining the "+IngrediantName+" into multiple "+CraftingResult.name+" adding them to your bag.");
		if (player.hasPerk(PerkLib.NaturalHerbalism)) {
			outputText("Your natural knowledge of herbalism allowed you to craft tice as many "+CraftingResult.name+".");
		}
		player.destroyItems(ItemID, player.itemCount(ItemID));
		var HE:Number = (20 + player.level)*player.itemCount(ItemID);
		if (player.hasPerk(PerkLib.PlantKnowledge)) HE *= 2;
		if (player.hasPerk(PerkLib.NaturalHerbalism)) HE *= 2;
		player.herbXP(HE);
		doNext(HerbalismMenu);
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
			return;
		}
	}
	
	private function AlterBindScroll():void {
		clearOutput();
		var limitOnAltering:Number = 1;
		var currentAltering:Number = 0;
		if (player.hasPerk(PerkLib.ImprovedCursedTag)) limitOnAltering += 1;
		if (player.hasPerk(PerkLib.GreaterCursedTag)) limitOnAltering += 3;
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll1)) currentAltering += 1;
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) currentAltering += 1;
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll3)) currentAltering += 1;
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll4)) currentAltering += 1;
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll5)) currentAltering += 1;
		outputText("Would you like to alter your curse tag, and if so, with what changes?\n\n");
		outputText("Current active powers / Limit of active powers: "+currentAltering+" / "+limitOnAltering+"\n\n");
		//displayHeader("Active powers:");
		//outputText("\n");
		outputText("<u><b>Active powers:</b></u>\n");
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll1)) outputText("<b>-No limiter</b>\n");
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) outputText("<b>-Unliving Leech</b>\n");
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll3)) outputText("<b>-Undead resistance</b>\n");
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll4)) outputText("<b>-Vital Sense</b>\n");
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll5)) outputText("<b>-Zombified</b>\n");
		//outputText("\n");
		//displayHeader("Effects of each powers:");
		outputText("\n<u><b>Effects of each powers:</b></u>\n");
		//outputText("\n");
		outputText("No limiter -> <i>Your zombified body is extremely resilient to physical damage and thus grants you +40% damage reduction. Furthermore the absence of a brain limiter allows you to push your limb strength beyond their normal capacity increasing your total strength by 100% of its value at the cost of your body integrity, taking light libido weakening on each attack. This is a togglable ability.</i>\n");
		outputText("Unliving Leech -> <i>Double the benefits of Life Leech and the power cap on Energy harvested from Energy Dependant.</i>\n");
		outputText("Undead resistance -> <i>Gain Immunity to Cold, Poison and Fatigue damage.</i>\n");
		outputText("Vital Sense -> <i>You sense and see your opponents strong vital points which grants you increased critical damage. Increase critical strike damage multiplier by 1 time.</i>\n");
		outputText("Zombified -> <i>You are immune to mental attacks that would affect living sane beings. Furthermore you have unlimited fatigue.</i>\n");
		menu();
		if (limitOnAltering > currentAltering && !player.hasStatusEffect(StatusEffects.AlterBindScroll1)) addButton(0, "No limiter", AlterBindScrollNoLimiter).hint("You not have this power active. Do you want to activate it?");
		else {
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll1)) addButton(0, "No limiter", AlterBindScrollNoLimiter).hint("You already have this power active. Do you want to deactivate it?");
			else addButtonDisabled(0, "No limiter", "You already have the maximum amount of powers active as you can maintain without breaking yourself.");
		}
		if (limitOnAltering > currentAltering && !player.hasStatusEffect(StatusEffects.AlterBindScroll2)) addButton(1, "Unliving Leech", AlterBindScrollUnlivingLeech).hint("You not have this power active. Do you want to activate it?");
		else {
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) addButton(1, "Unliving Leech", AlterBindScrollUnlivingLeech).hint("You already have this power active. Do you want to deactivate it?");
			else addButtonDisabled(1, "Unliving Leech", "You already have the maximum amount of powers active as you can maintain without breaking yourself.");
		}
		if (limitOnAltering > currentAltering && !player.hasStatusEffect(StatusEffects.AlterBindScroll3)) addButton(2, "Undead resistance", AlterBindScrollUndeadResistance).hint("You not have this power active. Do you want to activate it?");
		else {
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll3)) addButton(2, "Undead resistance", AlterBindScrollUndeadResistance).hint("You already have this power active. Do you want to deactivate it?");
			else addButtonDisabled(2, "Undead resistance", "You already have the maximum amount of powers active as you can maintain without breaking yourself.");
		}
		if (limitOnAltering > currentAltering && !player.hasStatusEffect(StatusEffects.AlterBindScroll4)) addButton(3, "Vital Sense", AlterBindScrollVitalSense).hint("You not have this power active. Do you want to activate it?");
		else {
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll4)) addButton(3, "Vital Sense", AlterBindScrollVitalSense).hint("You already have this power active. Do you want to deactivate it?");
			else addButtonDisabled(3, "Vital Sense", "You already have the maximum amount of powers active as you can maintain without breaking yourself.");
		}
		if (limitOnAltering > currentAltering && !player.hasStatusEffect(StatusEffects.AlterBindScroll5)) addButton(4, "Zombified", AlterBindScrollZombified).hint("You not have this power active. Do you want to activate it?");
		else {
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll5)) addButton(4, "Zombified", AlterBindScrollZombified).hint("You already have this power active. Do you want to deactivate it?");
			else addButtonDisabled(4, "Zombified", "You already have the maximum amount of powers active as you can maintain without breaking yourself.");
		}
		addButton(14, "Back", campMiscActions);
	}
	private function AlterBindScrollNoLimiter():void {
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll1)) player.removeStatusEffect(StatusEffects.AlterBindScroll1);
		else player.createStatusEffect(StatusEffects.AlterBindScroll1,0,0,0,0);
		doNext(AlterBindScroll);
	}
	private function AlterBindScrollUnlivingLeech():void {
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) player.removeStatusEffect(StatusEffects.AlterBindScroll2);
		else player.createStatusEffect(StatusEffects.AlterBindScroll2,0,0,0,0);
		doNext(AlterBindScroll);
	}
	private function AlterBindScrollUndeadResistance():void {
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll3)) player.removeStatusEffect(StatusEffects.AlterBindScroll3);
		else player.createStatusEffect(StatusEffects.AlterBindScroll3,0,0,0,0);
		doNext(AlterBindScroll);
	}
	private function AlterBindScrollVitalSense():void {
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll4)) player.removeStatusEffect(StatusEffects.AlterBindScroll4);
		else player.createStatusEffect(StatusEffects.AlterBindScroll4,0,0,0,0);
		doNext(AlterBindScroll);
	}
	private function AlterBindScrollZombified():void {
		if (player.hasStatusEffect(StatusEffects.AlterBindScroll5)) player.removeStatusEffect(StatusEffects.AlterBindScroll5);
		else player.createStatusEffect(StatusEffects.AlterBindScroll5,0,0,0,0);
		doNext(AlterBindScroll);
	}

	private function fillUpPillBottle00():void {
		clearOutput();
		outputText("You pick up one of your empty pills bottle and starts to put in some of your loose low-grade soulforce recovery pills. Then you close the bottle and puts into backpack.");
		player.destroyItems(useables.E_P_BOT, 1);
		player.destroyItems(consumables.LG_SFRP, 10);
		inventory.takeItem(consumables.LGSFRPB, campMiscActions);
	}
	private function fillUpPillBottle01():void {
		clearOutput();
		outputText("You pick up one of your empty pills bottle and starts to put in some of your loose mid-grade soulforce recovery pills. Then you close the bottle and puts into backpack.");
		player.destroyItems(useables.E_P_BOT, 1);
		player.destroyItems(consumables.MG_SFRP, 10);
		inventory.takeItem(consumables.MGSFRPB, campMiscActions);
	}

	private function questItemsBag():void {
		clearOutput();
		outputText("Would you like to put some quest items into the bag, and if so, with ones?\n\n");
		if (AdventurerGuild.Slot01Cap > 0) outputText("<b>Imp Skulls:</b> "+AdventurerGuild.Slot01+" / "+AdventurerGuild.Slot01Cap+"\n");
		if (AdventurerGuild.Slot02Cap > 0) outputText("<b>Feral Imp Skulls:</b> "+AdventurerGuild.Slot02+" / "+AdventurerGuild.Slot02Cap+"\n");
		if (AdventurerGuild.Slot03Cap > 0) outputText("<b>Minotaur Horns:</b> "+AdventurerGuild.Slot03+" / "+AdventurerGuild.Slot03Cap+"\n");
		if (AdventurerGuild.Slot04Cap > 0) outputText("<b>Demon Skulls:</b> "+AdventurerGuild.Slot04+" / "+AdventurerGuild.Slot04Cap+"\n");
		if (AdventurerGuild.Slot05Cap > 0) outputText("<b>Severed Tentacles:</b> "+AdventurerGuild.Slot05+" / "+AdventurerGuild.Slot05Cap+"\n");
		menu();
		if (AdventurerGuild.Slot01 < AdventurerGuild.Slot01Cap) {
			if (player.hasItem(useables.IMPSKLL, 1)) addButton(0, "ImpSkull", questItemsBagImpSkull1UP);
			else addButtonDisabled(0, "ImpSkull", "You not have any imp skulls to store.");
		}
		else addButtonDisabled(0, "ImpSkull", "You can't store more imp skulls in your bag.");
		if (AdventurerGuild.Slot01 > 0) addButton(1, "ImpSkull", questItemsBagImpSkull1Down);
		else addButtonDisabled(1, "ImpSkull", "You not have any imp skulls in your bag.");
		if (AdventurerGuild.Slot02 < AdventurerGuild.Slot02Cap) {
			if (player.hasItem(useables.FIMPSKL, 1)) addButton(2, "FeralImpS.", questItemsBagFeralImpSkull1Up);
			else addButtonDisabled(2, "FeralImpS.", "You not have any feral imp skulls to store.");
		}
		else addButtonDisabled(2, "FeralImpS.", "You can't store more feral imp skulls in your bag.");
		if (AdventurerGuild.Slot02 > 0) addButton(3, "FeralImpS.", questItemsBagFeralImpSkull1Down);
		else addButtonDisabled(3, "FeralImpS.", "You not have any feral imp skulls in your bag.");
		if (AdventurerGuild.Slot03 < AdventurerGuild.Slot03Cap) {
			if (player.hasItem(useables.MINOHOR, 1)) addButton(5, "MinoHorns", questItemsBagMinotaurHorns1Up);
			else addButtonDisabled(5, "MinoHorns", "You not have any minotaur horns to store.");
		}
		else addButtonDisabled(5, "MinoHorns", "You can't store more minotaur horns in your bag.");
		if (AdventurerGuild.Slot03 > 0) addButton(6, "MinoHorns", questItemsBagMinotaurHorns1Down);
		else addButtonDisabled(6, "MinoHorns", "You not have any minotaur horns in your bag.");
		if (AdventurerGuild.Slot04 < AdventurerGuild.Slot04Cap) {
			if (player.hasItem(useables.DEMSKLL, 1)) addButton(7, "DemonSkull", questItemsBagDemonSkull1Up);
			else addButtonDisabled(7, "DemonSkull", "You not have any demon skulls to store.");
		}
		else addButtonDisabled(7, "DemonSkull", "You can't store more demon skulls in your bag.");
		if (AdventurerGuild.Slot04 > 0) addButton(8, "DemonSkull", questItemsBagDemonSkull1Down);
		else addButtonDisabled(8, "DemonSkull", "You not have any demon skulls in your bag.");
		if (AdventurerGuild.Slot05 < AdventurerGuild.Slot05Cap) {
			if (player.hasItem(useables.SEVTENT, 1)) addButton(10, "SeveredTent", questItemsBagSeveredTentacle1Up);
			else addButtonDisabled(10, "SeveredTent", "You not have any severed tentacles to store.");
		}
		else addButtonDisabled(10, "SeveredTent", "You can't store more severed tentacles in your bag.");
		if (AdventurerGuild.Slot05 > 0) addButton(11, "SeveredTent", questItemsBagSeveredTentacle1Down);
		else addButtonDisabled(11, "SeveredTent", "You not have any severed tentacles in your bag.");
		addButton(14, "Back", campActions);
	}
	private function questItemsBagImpSkull1UP():void {
		player.destroyItems(useables.IMPSKLL, 1);
		AdventurerGuild.Slot01 += 1;
		doNext(questItemsBag);
	}
	private function questItemsBagImpSkull1Down():void {
		outputText("\n");
		AdventurerGuild.Slot01 -= 1;
		inventory.takeItem(useables.IMPSKLL, questItemsBag);
	}
	private function questItemsBagFeralImpSkull1Up():void {
		player.destroyItems(useables.FIMPSKL, 1);
		AdventurerGuild.Slot02 += 1;
		doNext(questItemsBag);
	}
	private function questItemsBagFeralImpSkull1Down():void {
		outputText("\n");
		AdventurerGuild.Slot02 -= 1;
		inventory.takeItem(useables.FIMPSKL, questItemsBag);
	}
	private function questItemsBagMinotaurHorns1Up():void {
		player.destroyItems(useables.MINOHOR, 1);
		AdventurerGuild.Slot03 += 1;
		doNext(questItemsBag);
	}
	private function questItemsBagMinotaurHorns1Down():void {
		outputText("\n");
		AdventurerGuild.Slot03 -= 1;
		inventory.takeItem(useables.MINOHOR, questItemsBag);
	}
	private function questItemsBagDemonSkull1Up():void {
		player.destroyItems(useables.DEMSKLL, 1);
		AdventurerGuild.Slot04 += 1;
		doNext(questItemsBag);
	}
	private function questItemsBagDemonSkull1Down():void {
		outputText("\n");
		AdventurerGuild.Slot04 -= 1;
		inventory.takeItem(useables.DEMSKLL, questItemsBag);
	}
	private function questItemsBagSeveredTentacle1Up():void {
		player.destroyItems(useables.SEVTENT, 1);
		AdventurerGuild.Slot05 += 1;
		doNext(questItemsBag);
	}
	private function questItemsBagSeveredTentacle1Down():void {
		outputText("\n");
		AdventurerGuild.Slot05 -= 1;
		inventory.takeItem(useables.SEVTENT, questItemsBag);
	}

	private function VisitClone():void {
		clearOutput();
		if (player.hasStatusEffect(StatusEffects.PCClone) && player.statusEffectv4(StatusEffects.PCClone) > 0) {
			if (player.statusEffectv4(StatusEffects.PCClone) < 4) {
				outputText("Your clone is ");
				if (player.statusEffectv4(StatusEffects.PCClone) == 1) outputText("slowly rotating basketball sized sphere of soul and life essences");
				else if (player.statusEffectv4(StatusEffects.PCClone) == 2) outputText("looking like you, albeit with translucent body");
				else outputText("looking like you covered with black chitin-like carapace");
				outputText(". Would you work on completing it?");
			}
			else {
				outputText("Your clone is wandering around [camp]. What would you ask " + player.mf("him","her") + " to do?\n\n");
				outputText("Current clone task: ");
				if (player.statusEffectv1(StatusEffects.PCClone) > 10 && player.statusEffectv1(StatusEffects.PCClone) < 21) outputText("Contemplating Dao of ");
				if (player.statusEffectv1(StatusEffects.PCClone) == 20) outputText("Acid");
				else if (player.statusEffectv1(StatusEffects.PCClone) == 19) outputText("Earth");
				else if (player.statusEffectv1(StatusEffects.PCClone) == 18) outputText("Water");
				else if (player.statusEffectv1(StatusEffects.PCClone) == 17) outputText("Blood");
				else if (player.statusEffectv1(StatusEffects.PCClone) == 16) outputText("Wind");
				else if (player.statusEffectv1(StatusEffects.PCClone) == 15) outputText("Poison");
				else if (player.statusEffectv1(StatusEffects.PCClone) == 14) outputText("Darkness");
				else if (player.statusEffectv1(StatusEffects.PCClone) == 13) outputText("Lightning");
				else if (player.statusEffectv1(StatusEffects.PCClone) == 12) outputText("Ice");
				else if (player.statusEffectv1(StatusEffects.PCClone) == 11) outputText("Fire");
				else outputText("Nothing");
			}
		}
		else outputText("You do not have a clone right now, whether you've never made one or one was sacrificed. You would need to make a new one, first.");
		outputText("\n\n");
		menu();
		if (player.isGargoyle()) addButtonDisabled(0, "Create", "Your current body cannot handle a clone.");
		else if (player.hasStatusEffect(StatusEffects.PCClone)) {
			if (player.statusEffectv3(StatusEffects.PCClone) > 0) addButtonDisabled(0, "Create", "You have not recovered enough from the ordeal of making your previous clone. Unrecovered levels: " + player.statusEffectv3(StatusEffects.PCClone) + "");
			else {
				if (player.statusEffectv4(StatusEffects.PCClone) == 4) addButtonDisabled(0, "Create", "You cannot have more than one clone.");
				else if (player.statusEffectv4(StatusEffects.PCClone) > 0 && player.statusEffectv4(StatusEffects.PCClone) < 4) addButton(0, "Create", CreateClone);
				else addButtonDisabled(0, "Create", "You must wait before creating a new clone.");
			}
		}
		else addButton(0, "Create", CreateClone);
		if (player.hasStatusEffect(StatusEffects.PCClone) && player.statusEffectv4(StatusEffects.PCClone) == 4) {
			addButton(1, "Contemplate", CloneContemplateDao).hint("Task your clone with contemplating one of the Daos you know.");

		}
		else {
			addButtonDisabled(1, "Contemplate", "Req. fully formed clone.");
			//addButtonDisabled(2, "Training", "Req. fully formed clone.");
		}
		addButton(14, "Back", campMiscActions);
	}
	private function CreateClone():void {
		menu();
		if (player.HP > player.maxHP() * 0.5 && player.soulforce >= player.maxSoulforce()) addButton(0, "Form", FormClone);
		else {
			if (player.soulforce < player.maxSoulforce()) addButtonDisabled(0, "Form", "Your soulforce is too low.");
			else addButtonDisabled(0, "Form", "Your health is too low.");
		}
		addButton(4, "Back", VisitClone);
	}
	private function FormClone():void {
		clearOutput();
		if (player.hasStatusEffect(StatusEffects.PCClone)) {
			if (player.statusEffectv4(StatusEffects.PCClone) == 3) {
				outputText("It's time to finish what you started. Your clone won't simply create itself. With the black carapace-like layer in front of you, you resume focusing on transferring your life essence and soulforce to the clone.\n\n");
				outputText("Minutes draw by as time slowly passes. Your energies enter the clone through the only malleable part of the carapace around the navel. After around five hours, you notice a dull rhythm. A heart beats with increasing life as the moments pass.\n\n");
				outputText("Soon after the heartbeat, other rapid changes begin inside the clone. The body itself begins to animate as the clone takes its first breaths. With the transfer nearly completely, the new life is on the verge of its complete vitality.\n\n");
				outputText("Now that the body is full of life, you need to link it to your soul. The process is foreign, almost invasive as you link your essence to something alien, but as the minutes pass, the feeling steadily becomes more natural. ");
				outputText("It's not long until the clone feels like an extension of your body, almost as if you could move it yourself. ");
				outputText("It's not long until you're properly attuned to your clone. The shell cracks before your clone emerges from the incubator. It's a glorious reflection of you, though it seems to have the common decency to give itself a simple grey robe before presenting its barren body.\n\n");
				outputText("You share a grin now that the process is successful. Your quest remains to be completed, but now you have the power of two.\n\n");
				outputText("<b>Your clone is fully formed.</b>\n\n");
				player.addStatusValue(StatusEffects.PCClone, 4, 1);
				player.addStatusValue(StatusEffects.PCClone, 3, 30);
				EngineCore.SoulforceChange(-player.maxSoulforce(), true);
				HPChange(-(player.maxHP() * 0.5), true);
				player.statPoints -= 150;
				player.perkPoints -= 30;
				player.level -= 30;
			}
			else if (player.statusEffectv4(StatusEffects.PCClone) == 2) {
				outputText("You return to work on completing your clone. Compared to the previous form of the large sphere, it now looks more like you. You begin the process for the third time.\n\n");
				outputText("The outer layer steadily begins to change into the form of a translucent cocoon. It's barely noticeable, but you can see the vital organs form inside the incubator.\n\n");
				outputText("Six hours pass as the cocoon hardens into a substance akin to hard, black chitin until the cocoon is opaque. A small part of the layer around the navel keeps some translucent properties.\n\n");
				outputText("Fatigue steadily overwhelms you after expending such intense amounts of your life energy. You lie down and rest for an hour before you decide to resume.\n\n");
				player.addStatusValue(StatusEffects.PCClone, 4, 1);
				EngineCore.SoulforceChange(-player.maxSoulforce(), true);
				HPChange(-(player.maxHP() * 0.5), true);
			}
			else {
				outputText("Having recovered your spent life force and soul energy, you return to the halted ritual. Sitting before you is a slowly rotating basketball-sized sphere of soul and life essences. You start to focus on the next phase of clone formation.\n\n");
				outputText("Without further delay, you focus the essence from your body, guiding it to the sphere before you.\n\n");
				outputText("A few hours later, the sphere begins to take the shape of your body with the energy you've guided into it. It is slightly larger than you, with the outer layer being nothing more than something to prevent the essences you've given it from escaping.\n\n");
				outputText("With the second phase completed, you slowly break the connection with your clone. Your mind and body wrack from the expended essence you've given to your clone. You decide to take the time to rest.\n\n");
				outputText("After a couple of hours, you rise before leaving the half-finished creation in the corner of your [camp].\n\n");
				player.addStatusValue(StatusEffects.PCClone, 4, 1);
				EngineCore.SoulforceChange(-player.maxSoulforce(), true);
				HPChange(-(player.maxHP() * 0.5), true);
			}
		}
		else {
			outputText("You close your eyes with the intent of forming the core of your clone. Minutes pass as the sensation of your soul force and life essence slowly escapes from your being.\n\n");
			outputText("An hour passes as you steadily concentrate on the essence that has left your body. Keeping your concentration on the swirling life, you guide more of essence and soul energy to leave your body and drift toward the new creation growing before you.\n\n");
			outputText("The process is slow. While nourishing the core of the clone, you find yourself unable to expend any more of your life essence or risk being completely drained of soul essence.\n\n");
			player.createStatusEffect(StatusEffects.PCClone, 0, 0, 0, 1);
			EngineCore.SoulforceChange(-(player.maxSoulforce()), true);
			HPChange(-(player.maxHP() * 0.5), true);
		}
		doNext(camp.returnToCampUseEightHours);
	}
	private function CloneContemplateDao():void {
		clearOutput();
		outputText("Maybe your clone could contemplate one of Daos you knew while you adventure outside the [camp]? But which one it should be?");
		menu();
		if (player.statusEffectv1(StatusEffects.PCClone) == 11) addButtonDisabled(0, "Fire", "Your clone is currently contemplating this Dao.");
		else addButton(0, "Fire", CloneContemplateDaoSet, 11);
		if (player.statusEffectv1(StatusEffects.PCClone) == 12) addButtonDisabled(1, "Ice", "Your clone is currently contemplating this Dao.");
		else addButton(1, "Ice", CloneContemplateDaoSet, 12);
		if (player.statusEffectv1(StatusEffects.PCClone) == 13) addButtonDisabled(2, "Lightning", "Your clone is currently contemplating this Dao.");
		else addButton(2, "Lightning", CloneContemplateDaoSet, 13);
		if (player.statusEffectv1(StatusEffects.PCClone) == 14) addButtonDisabled(3, "Darkness", "Your clone is currently contemplating this Dao.");
		else addButton(3, "Darkness", CloneContemplateDaoSet, 14);
		if (player.statusEffectv1(StatusEffects.PCClone) == 15) addButtonDisabled(4, "Poison", "Your clone is currently contemplating this Dao.");
		else addButton(4, "Poison", CloneContemplateDaoSet, 15);
		if (player.statusEffectv1(StatusEffects.PCClone) == 16) addButtonDisabled(5, "Wind", "Your clone is currently contemplating this Dao.");
		else addButton(5, "Wind", CloneContemplateDaoSet, 16);
		if (player.statusEffectv1(StatusEffects.PCClone) == 17) addButtonDisabled(6, "Blood", "Your clone is currently contemplating this Dao.");
		else addButton(6, "Blood", CloneContemplateDaoSet, 17);
		if (player.statusEffectv1(StatusEffects.PCClone) == 18) addButtonDisabled(7, "Water", "Your clone is currently contemplating this Dao.");
		else addButton(7, "Water", CloneContemplateDaoSet, 18);
		if (player.statusEffectv1(StatusEffects.PCClone) == 19) addButtonDisabled(8, "Earth", "Your clone is currently contemplating this Dao.");
		else addButton(8, "Earth", CloneContemplateDaoSet, 19);
		if (player.statusEffectv1(StatusEffects.PCClone) == 20) addButtonDisabled(9, "Acid", "Your clone is currently contemplating this Dao.");
		else addButton(9, "Acid", CloneContemplateDaoSet, 20);
		if (player.statusEffectv1(StatusEffects.PCClone) == 10) addButtonDisabled(13, "None", "Your clone is currently not contemplating any Dao.");
		else addButton(13, "None", CloneContemplateDaoSet, 10);
		addButton(14, "Back", VisitClone);
	}
	private function CloneContemplateDaoSet(newdao:Number):void {
		var olddao:Number = player.statusEffectv1(StatusEffects.PCClone);
		player.addStatusValue(StatusEffects.PCClone,1,(newdao-olddao));
		doNext(CloneContemplateDao);
	}
	private function CloneTrainWaponMastery():void {

	}

	private function DummyTraining():void {
		clearOutput();
		outputText("You walk toward the worn out dummy as you drawn your [weapon].");
		startCombat(new TrainingDummy());
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
		if (player.hasStatusEffect(StatusEffects.DianaOff)) outputText("\nDiana: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.DivaOff)) outputText("\nDiva: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.ElectraOff)) outputText("\nElectra: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.EtnaOff)) outputText("\nEtna: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.LunaOff)) outputText("\nLuna: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.TedOff)) outputText("\nDragon Boi: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.SpoodersOff)) outputText("\Spooders: <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.CalluOff)) outputText("\nCallu (Otter girl): <font color=\"#800000\"><b>Disabled</b></font>");
		if (player.hasStatusEffect(StatusEffects.VenusOff)) outputText("\nVenus (Gigantic Turtle): <font color=\"#800000\"><b>Disabled</b></font>");
	}
	private function SparrableNPCsMenu():void {
		clearOutput();
		SparrableNPCsMenuText();
		menu();
		if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) {
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] < 2) addButton(10, "Train", NPCsTrain);
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) addButton(11, "Relax", NPCsRelax);
		}
		addButton(0, "Chi Chi", toggleChiChiMenu).hint("Enable or Disable Chi Chi. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(1, "Diana", toggleDianaMenu).hint("Enable or Disable Diana. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(2, "Diva", toggleDivaMenu).hint("Enable or Disable Diva. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(3, "Electra", toggleElectraMenu).hint("Enable or Disable Electra. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(4, "Etna", toggleEtnaMenu).hint("Enable or Disable Etna. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(5, "Luna", toggleLunaMenu).hint("Enable or Disable Luna. This will remove her from enc table and if already in [camp] disable access to her.");
		addButton(6, "DragonBoi", toggleTedMenu).hint("Enable or Disable Dragon Boi. This will remove him from enc table.");
		//since this section is WIP anyway, let her be here too, lol
        addButton(12, "Spooders", toggleSpoodersMenu).hint("Enable or Disable spooder followers. This will remove them ONLY from enc table.");
		addButton(13, "Others", SparrableNPCsMenuOthers).hint("Out of camp encounters only.");
		addButton(14, "Back", campActions);
	}
	private function SparrableNPCsMenuOthers():void {
		clearOutput();
		SparrableNPCsMenuText();
		menu();
		addButton(0, "Callu", toggleCalluMenu).hint("Enable or Disable Callu (Otter girl). This will remove her from enc table.");
		addButton(1, "Venus", toggleVenusMenu).hint("Enable or Disable Venus (Gigantic Turtle). This will remove her from enc table.");
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

	private function toggleChiChiMenu():void {
		if (player.hasStatusEffect(StatusEffects.ChiChiOff)) player.removeStatusEffect(StatusEffects.ChiChiOff);
		else player.createStatusEffect(StatusEffects.ChiChiOff, 0, 0, 0, 0);
		SparrableNPCsMenu();
	}
	private function toggleDianaMenu():void {
		if (player.hasStatusEffect(StatusEffects.DianaOff)) player.removeStatusEffect(StatusEffects.DianaOff);
		else player.createStatusEffect(StatusEffects.DianaOff, 0, 0, 0, 0);
		SparrableNPCsMenu();
	}
	private function toggleDivaMenu():void {
		if (player.hasStatusEffect(StatusEffects.DivaOff)) player.removeStatusEffect(StatusEffects.DivaOff);
		else player.createStatusEffect(StatusEffects.DivaOff, 0, 0, 0, 0);
		SparrableNPCsMenu();
	}
	private function toggleElectraMenu():void {
		if (player.hasStatusEffect(StatusEffects.ElectraOff)) player.removeStatusEffect(StatusEffects.ElectraOff);
		else player.createStatusEffect(StatusEffects.ElectraOff, 0, 0, 0, 0);
		SparrableNPCsMenu();
	}
	private function toggleEtnaMenu():void {
		if (player.hasStatusEffect(StatusEffects.EtnaOff)) player.removeStatusEffect(StatusEffects.EtnaOff);
		else player.createStatusEffect(StatusEffects.EtnaOff, 0, 0, 0, 0);
		SparrableNPCsMenu();
	}
	private function toggleLunaMenu():void {
		if (player.hasStatusEffect(StatusEffects.LunaOff)) player.removeStatusEffect(StatusEffects.LunaOff);
		else {
			player.createStatusEffect(StatusEffects.LunaOff, 0, 0, 0, 0);
			flags[kFLAGS.SLEEP_WITH] == "";
		}
		SparrableNPCsMenu();
	}
	private function toggleTedMenu():void {
		if (player.hasStatusEffect(StatusEffects.TedOff)) player.removeStatusEffect(StatusEffects.TedOff);
		else player.createStatusEffect(StatusEffects.TedOff, 0, 0, 0, 0);
		SparrableNPCsMenu();
	}

	private function toggleSpoodersMenu():void {
		if (player.hasStatusEffect(StatusEffects.SpoodersOff)) player.removeStatusEffect(StatusEffects.SpoodersOff);
		else player.createStatusEffect(StatusEffects.SpoodersOff, 0, 0, 0, 0);
		SparrableNPCsMenu();
	}

	private function toggleCalluMenu():void {
		if (player.hasStatusEffect(StatusEffects.CalluOff)) player.removeStatusEffect(StatusEffects.CalluOff);
		else player.createStatusEffect(StatusEffects.CalluOff, 0, 0, 0, 0);
		SparrableNPCsMenuOthers();
	}
	private function toggleVenusMenu():void {
		if (player.hasStatusEffect(StatusEffects.VenusOff)) player.removeStatusEffect(StatusEffects.VenusOff);
		else player.createStatusEffect(StatusEffects.VenusOff, 0, 0, 0, 0);
		SparrableNPCsMenuOthers();
	}

	private function swimInStream():void {
		var prankChooser:Number = rand(3);
		clearOutput();
		outputText("You ponder over the nearby stream that's flowing. Deciding you'd like a dip, ");
		if (player.armorName == "slutty swimwear") outputText("you are going to swim while wearing just your swimwear. ");
		else outputText("you strip off your [armor] until you are completely naked. ");
		outputText("You step into the flowing waters. You shiver at first but you step in deeper. Incredibly, it's not too deep. ");
		if (player.tallness < 60) outputText("Your feet aren't even touching the riverbed. ");
		if (player.tallness >= 60 && player.tallness < 72) outputText("Your feet are touching the riverbed and your head is barely above the water. ");
		if (player.tallness >= 72) outputText("Your feet are touching touching the riverbed and your head is above water. You bend down a bit so you're at the right height. ");
		outputText("\n\nYou begin to swim around and relax. ");
		//Izma!
		if (rand(2) == 0 && camp.izmaFollower()) {
			outputText("\n\nYour tiger-shark beta, Izma, joins you. You are frightened at first when you saw the fin protruding from the water and the fin approaches you! ");
			outputText("As the fin approaches you, the familiar figure comes up. \"<i>I was going to enjoy my daily swim, alpha,</i>\" she says.");
			izmaJoinsStream = true;
		}
		//Helia!
		if (rand(2) == 0 && camp.followerHel() && flags[kFLAGS.HEL_CAN_SWIM]) {
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
		if (prankChooser == 0 && (camp.izmaFollower() || (camp.followerHel() && flags[kFLAGS.HEL_CAN_SWIM]) || camp.marbleFollower() || (camp.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_OWNS_BIKINI] > 0))) {
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
			outputText("\n\nIzma just swims over, unaware of the warm spot you just created. \"<i>Who've pissed in the stream?</i>\" she growls. You swim over to her and tell her that you admit you did pee in the stream. \"<i>Oh, alpha! What a naughty alpha you are,</i>\" she grins, her shark-teeth clearly visible.");
			pranked = true;
		}
		if (rand(prankRoll) == 0 && (camp.followerHel() && flags[kFLAGS.HEL_CAN_SWIM]) && !pranked && heliaJoinsStream) {
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
		outputText("You pick a location where the sun is clearly visible from that particular spot and sit down. The sun is just above the horizon, ready to set. It's such a beautiful view. \n\n");
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
			outputText("You think of what you'd like to ");
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
		eachMinuteCount(5);
		doNext(playerMenu);
	}
	private function usePeacockStatuette():void {
		CoC.instance.mutations.skybornSeed(2, player);
		eachMinuteCount(5);
		doNext(playerMenu);
	}

//-----------------
//-- REST
//-----------------
	public function restMenu():void {
		menu();
		addButton(0, "1 Hour", 	restFor, 1).hint("Rest for one hour.");
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

	public function rest():void {
		campQ = true;
		IsWaitingResting = true;
		clearOutput();
		//Fatigue recovery
		var multiplier:Number = 1.0;
		var fatRecovery:Number = 4;
		var hpRecovery:Number = 10;
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
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && !prison.inPrison && !ingnam.inIngnam)
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
			HPChange(timeQ * hpRecovery * multiplier, false);
			fatigue(timeQ * -fatRecovery * multiplier);

			if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && !prison.inPrison && !ingnam.inIngnam) {
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
				outputText("\nYour rest is very troubled, and you aren't able to settle down.  You get up feeling tired and unsatisfied, always thinking of Marble's milk.\n");
				dynStats("tou", -.1, "int", -.1);
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
	public function doSleep(clrScreen:Boolean = true):void {
		IsSleeping = true;
		if (SceneLib.urta.pregnancy.incubation == 0 && SceneLib.urta.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER && model.time.hours >= 20 && model.time.hours < 2) {
			urtaPregs.preggoUrtaGivingBirth();
			return;
		}
		campQ = true;
		if (timeQ == 0) {
			CanDream = true;
			model.time.minutes = 0;
			timeQ = 9;
			if (flags[kFLAGS.BENOIT_CLOCK_ALARM] > 0 && flags[kFLAGS.IN_PRISON] == 0) {
				timeQ += (flags[kFLAGS.BENOIT_CLOCK_ALARM] - 6);
			}
			//Autosave stuff
			if (player.slotName != "VOID" && player.autoSave && mainView.getButtonText(0) != "Game Over") {
				trace("Autosaving to slot: " + player.slotName);
				CoC.instance.saves.saveGame(player.slotName);
			}
			//Clear screen
			if (clrScreen) clearOutput();
			if (prison.inPrison) {
				outputText("You curl up on a slab, planning to sleep for " + num2Text(timeQ) + " hour");
				if (timeQ > 1) outputText("s");
				outputText(". ");
				sleepRecovery(true);
				goNext(true);
				return;
			}
			/******************************************************************/
			/*       ONE TIME SPECIAL EVENTS                                  */
			/******************************************************************/
			//HEL SLEEPIES!
			if (helFollower.helAffection() >= 70 && flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE] == 0 && flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 0) {
				SceneLib.dungeons.heltower.heliaDiscovery();
				sleepRecovery(false);
				return;
			}
			//Shouldra xgartuan fight
			if (player.hasCock() && followerShouldra() && player.statusEffectv1(StatusEffects.Exgartuan) == 1) {
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
			if (player.hasCock() && followerShouldra() && flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] == -0.5) {
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
			if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && (flags[kFLAGS.SLEEP_WITH] == "" || flags[kFLAGS.SLEEP_WITH] == "Marble")) {
				outputText("You enter your cabin to turn yourself in for the night. ")
			}
			//Marble Sleepies
			if (marbleScene.marbleAtCamp() && player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.SLEEP_WITH] == "Marble" && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) {
				if (marbleScene.marbleNightSleepFlavor()) {
					sleepRecovery(false);
					return;
				}
			} else if (flags[kFLAGS.SLEEP_WITH] == "Arian" && arianScene.arianFollower()) {
				arianScene.sleepWithArian();
				return;
			} else if (flags[kFLAGS.SLEEP_WITH] == "Zenji" && flags[kFLAGS.ZENJI_PROGRESS] == 11) {
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
				if (player.isNaga()) outputText(" She’s not alone either. It indeed took you a while to realise that you are also cold blooded now. The cold night air sure puts you in a similar state as of late.");
				outputText("\n\n\"<i>Sweet dreams [name], till morning and sunshine come.</i>\"\n");
			} else if (flags[kFLAGS.SLEEP_WITH] == "Belisa" && BelisaFollower.BelisaInCamp) {
				outputText("You decide to sleep with Belisa tonight. You help her close up her shop, packing the bands away, and climb into her hammock/bed, putting a hand on her cheek. Belisa pulls you towards her, resting one of her pillows under each of your heads. She hugs your arm, head on your shoulder, and you can’t help but feel safe as she expertly pulls a light blanket over the two of you. ");
				outputText("She whispers a sweet \"<i>good night</i>\" to you, and you drift into sleep, a soft, sweet scent of cinnamon in your nostrils.");
			} else if (flags[kFLAGS.SLEEP_WITH] == "Tyrantia" && TyrantiaFollower.TyrantiaFollowerStage >= 4) {
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
		player.sleepUpdateStat();
		goNext(true);
	}

//For shit that breaks normal sleep processing.
	public function sleepWrapper():void {
		if (model.time.hours == 16) timeQ = 14;
		if (model.time.hours == 17) timeQ = 13;
		if (model.time.hours == 18) timeQ = 12;
		if (model.time.hours == 19) timeQ = 11;
		if (model.time.hours == 20) timeQ = 10;
		if (model.time.hours == 21) timeQ = 9;
		if (model.time.hours == 22) timeQ = 8;
		if (model.time.hours >= 23) timeQ = 7;
		if (model.time.hours == 0) timeQ = 6;
		if (model.time.hours == 1) timeQ = 5;
		if (model.time.hours == 2) timeQ = 4;
		if (model.time.hours == 3) timeQ = 3;
		if (model.time.hours == 4) timeQ = 2;
		if (model.time.hours == 5) timeQ = 1;
		if (flags[kFLAGS.BENOIT_CLOCK_ALARM] > 0 && (flags[kFLAGS.SLEEP_WITH] == "Ember" || flags[kFLAGS.SLEEP_WITH] == 0)) timeQ += (flags[kFLAGS.BENOIT_CLOCK_ALARM] - 6);
		clearOutput();
		clearOutput();
		if (timeQ != 1) outputText("You lie down to resume sleeping for the remaining " + num2Text(timeQ) + " hours.\n");
		else outputText("You lie down to resume sleeping for the remaining hour.\n");
		sleepRecovery(true);
		goNext(true);
	}

	public function sleepRecovery(display:Boolean = false):void {
		var multiplier:Number = 1.0;
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
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && (flags[kFLAGS.SLEEP_WITH] == "" || flags[kFLAGS.SLEEP_WITH] == "Marble")) {
			multiplier += 0.5;
		}
		if (player.hasPerk(PerkLib.SpeedyRecovery)) fatRecovery += 5;
		if (player.hasPerk(PerkLib.SpeedyRecuperation)) fatRecovery += 10;
		if (player.hasPerk(PerkLib.SpeedyRejuvenation)) fatRecovery += 20;
		if (player.hasPerk(PerkLib.ControlledBreath)) fatRecovery *= 1.1;
		if (player.hasStatusEffect(StatusEffects.BathedInHotSpring)) fatRecovery *= 1.2;
		if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) fatRecovery *= 3;
		if (player.hasPerk(PerkLib.RecuperationSleep)) multiplier += 1;
		if (player.hasPerk(PerkLib.RejuvenationSleep)) multiplier += 2;
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
		HPChange(timeQ * hpRecovery * multiplier, display);
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
		dynStats("lus", -10);
		player.consumeItem(consumables.REDUCTO, 1);
		doNext(camp.returnToCampUseOneHour);
	}

	private function callRathazulAndEscapeBadEnd():void {
		clearOutput();
		outputText("You shout as loud as you can to call Rathazul.  Your call is answered as the alchemist walks up to you.\n\n");
		outputText("\"<i>My, my... Look at yourself! Don't worry, I can help, </i>\" he says.  He rushes to his alchemy equipment and mixes ingredients.  He returns to you with a Reducto.\n\n");
		outputText("He rubs the paste all over your massive balls. It's incredibly effective. \n\n");
		player.ballSize -= (4 + rand(6));
		if (player.ballSize > 18 + (player.str / 2) + (player.tallness / 4)) player.ballSize = 16 + (player.str / 2) + (player.tallness / 4);
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

	public function allNaturalSelfStimulationBeltContinuation():void {
		clearOutput();
		outputText("In shock, you scream as you realize the nodule has instantly grown into a massive, organic dildo. It bottoms out easily and rests against your cervix as you recover from the initial shock of its penetration. As the pangs subside, the infernal appendage begins working itself. It begins undulating in long, slow strokes. It takes great care to adjust itself to fit every curve of your womb. Overwhelmed, your body begins reacting against your conscious thought and slowly thrusts your pelvis in tune to the thing.\n\n");
		outputText("As suddenly as it penetrated you, it shifts into a different phase of operation. It buries itself as deep as it can and begins short, rapid strokes. The toy hammers your insides faster than any man could ever hope to do. You orgasm immediately and produce successive climaxes. Your body loses what motor control it had and bucks and undulates wildly as the device pistons your cunt without end. You scream at the top of your lungs. Each yell calls to creation the depth of your pleasure and lust.\n\n");
		outputText("The fiendish belt shifts again. It buries itself as deep as it can go and you feel pressure against the depths of your womanhood. You feel a hot fluid spray inside you. Reflexively, you shout, \"<b>IT'S CUMMING! IT'S CUMMING INSIDE ME!</b>\" Indeed, each push of the prodding member floods your box with juice. It cums... and cums... and cums... and cums...\n\n");
		outputText("An eternity passes, and your pussy is sore. It is stretched and filled completely with whatever this thing shoots for cum. It retracts itself from your hole and you feel one last pang of pressure as your body now has a chance to force out all of the spunk that it cannot handle. Ooze sprays out from the sides of the belt and leaves you in a smelly, sticky mess. You feel the belt's tension ease up as it loosens. The machine has run its course. You immediately pass out.");
		player.slimeFeed();
		player.orgasm();
		dynStats("lib", 1, "sen", (-0.5));
		doNext(camp.returnToCampUseOneHour);
	}

	public function allNaturalSelfStimulationBeltBadEnd():void {
		spriteSelect(SpriteDb.s_giacomo);
		clearOutput();
		outputText("Whatever the belt is, whatever it does, it no longer matters to you.  The only thing you want is to feel the belt and its creature fuck the hell out of you, day and night.  You quickly don the creature again and it begins working its usual lustful magic on your insatiable little box.  An endless wave of orgasms take you.  All you now know is the endless bliss of an eternal orgasm.\n\n");
		outputText("Your awareness hopelessly compromised by the belt and your pleasure, you fail to notice a familiar face approach your undulating form.  It is the very person who sold you this infernal toy.  The merchant, Giacomo.\n\n");
		outputText("\"<i>Well, well,</i>\" Giacomo says.  \"<i>The Libertines are right.  The creature's fluids are addictive. This poor " + player.mf("man", "woman") + " is a total slave to the beast!</i>\"\n\n");
		outputText("Giacomo contemplates the situation as you writhe in backbreaking pleasure before him.  His sharp features brighten as an idea strikes him.\n\n");
		outputText("\"<i>AHA!</i>\" the hawkish purveyor cries.  \"<i>I have a new product to sell! I will call it the 'One Woman Show!'</i>\"\n\n");
		outputText("Giacomo cackles smugly at his idea.  \"<i>Who knows how much someone will pay me for a live " + player.mf("man", "woman") + " who can't stop cumming!</i>\"\n\n");
		outputText("Giacomo loads you up onto his cart and sets off for his next sale.  You do not care.  You do not realize what has happened.  All you know is that the creature keeps cumming and it feels... sooooo GODDAMN GOOD!");
		EventParser.gameOver();
	}

	private function dungeonFound():Boolean { //Returns true as soon as any known dungeon is found
		if (flags[kFLAGS.FACTORY_FOUND] > 0) return true;
		if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0) return true;
		if (flags[kFLAGS.D3_DISCOVERED] > 0) return true;
		if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0) return true;
		if (SceneLib.dungeons.checkPhoenixTowerClear()) return true;
		if (flags[kFLAGS.EBON_LABYRINTH] > 0) return true;
		if (flags[kFLAGS.HIDDEN_CAVE_FOUND] > 0) return true;
		if (flags[kFLAGS.DEN_OF_DESIRE_BOSSES] > 0) return true;
		if (flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] > 0) return true;
		if (flags[kFLAGS.LUMI_MET] > 0) return true;
		if (flags[kFLAGS.ANZU_PALACE_UNLOCKED] > 0) return true;
		return false;
	}

	private function farmFound():Boolean { //Returns true as soon as any known dungeon is found
		if (player.hasStatusEffect(StatusEffects.MetWhitney) && player.statusEffectv1(StatusEffects.MetWhitney) > 1) {
			if (flags[kFLAGS.FARM_DISABLED] == 0) return true;
			if (player.cor >= 70 && player.level >= 12 && SceneLib.farm.farmCorruption.corruptFollowers() >= 2 && flags[kFLAGS.FARM_CORRUPTION_DISABLED] == 0) return true;
		}
		if (flags[kFLAGS.FARM_CORRUPTION_STARTED]) return true;
		return false;
	}

//-----------------
//-- PLACES MENU
//-----------------
	private function placesKnown():Boolean { //Returns true as soon as any known place is found
		if (placesCount() > 0) return true;
		return false;
	}

	public function placesCount():int {
		var places:int = 0;
		if (flags[kFLAGS.BAZAAR_ENTERED] > 0) places++;
		if (player.hasStatusEffect(StatusEffects.BoatDiscovery)) places++;
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
		if (flags[kFLAGS.PRISON_CAPTURE_COUNTER] > 0) places++;
		if (player.hasStatusEffect(StatusEffects.ResourceNode1)) {
			if (player.statusEffectv1(StatusEffects.ResourceNode1) >= 5) places++;
			if (player.statusEffectv2(StatusEffects.ResourceNode1) >= 5) places++;
		}
		return places;
	}
	
	private function placesKnownNight():Boolean {
		if (player.hasStatusEffect(StatusEffects.ResourceNode1)) {
			//if (player.statusEffectv1(StatusEffects.ResourceNode1) >= 5) return true;
			if (player.statusEffectv2(StatusEffects.ResourceNode1) >= 5) return true;
		}
		return false;
	}

//All cleaned up!

	public function places():Boolean {
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
		if (player.hasStatusEffect(StatusEffects.BoatDiscovery)) addButton(3, "Boat", SceneLib.boat.boatExplore).hint("Get on the boat and explore the lake. \n\nRecommended level: 12");
		else addButtonDisabled(3, "???", "Search the lake.");
		addButton(4, "Next", placesPage2);

		if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) addButton(5, "Tel'Adre", SceneLib.telAdre.telAdreMenu).hint("Visit the city of Tel'Adre in desert, easily recognized by the massive tower.");
		else addButtonDisabled(5, "???", "Search the desert.");
		if (flags[kFLAGS.BAZAAR_ENTERED] > 0) addButton(6, "Bazaar", SceneLib.bazaar.enterTheBazaar).hint("Visit the Bizarre Bazaar where the demons and corrupted beings hang out.");
		else addButtonDisabled(6, "???", "Search the plains.");
		if (flags[kFLAGS.OWCA_UNLOCKED] == 1) addButton(7, "Owca", SceneLib.owca.gangbangVillageStuff).hint("Visit the sheep village of Owca, known for its pit where a person is hung on the pole weekly to be gang-raped by the demons.");
		else addButtonDisabled(7, "???", "Search the plains.");
		if (TrollVillage.ZenjiVillageStage > 0) addButton(8, "Troll Village", SceneLib.trollVillage.EnterTheVillage).hint("Visit the Troll Village.");
		else addButtonDisabled(8, "???", "Clear the factory first.");
		//9 - ???

		if (flags[kFLAGS.HEXINDAO_UNLOCKED] >= 1) addButton(10, "He'Xin'Dao", SceneLib.hexindao.riverislandVillageStuff0).hint("Visit the village of He'Xin'Dao, a place where all greenhorn soul cultivators come together.");
		else addButtonDisabled(10, "???", "Explore the realm.");
		if (flags[kFLAGS.TIMES_MET_CHICKEN_HARPY] > 1) {
			if (player.hasItem(consumables.OVIELIX)) addButton(11, "Chicken Harpy", SceneLib.highMountains.chickenHarpy).hint("Visit Chicken Harpy in the High Mountains.");
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
		if (flags[kFLAGS.MET_MINERVA] >= 4) addButton(6, "Oasis Tower", SceneLib.highMountains.minervaScene.encounterMinerva).hint("Visit the ruined tower in the high mountains where Minerva resides.");
		else addButtonDisabled(6, "???", "Search the high mountains.");
		if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] > 0) addButton(7, "Temple", SceneLib.templeofdivine.repeatvisitintro).hint("Visit the temple in the high mountains where Sapphire resides.");
		else addButtonDisabled(7, "???", "Search the high mountains.");
		if (flags[kFLAGS.YU_SHOP] == 2) addButton(8, "Winter Gear", SceneLib.glacialYuShop.YuIntro).hint("Visit the Winter gear shop.");
		else addButtonDisabled(8, "???", "Search the (outer) glacial rift.");
		addButton(9, "Previous", placesToPage1);

		if (flags[kFLAGS.AIKO_TIMES_MET] > 3) addButton(10, "Great Tree", SceneLib.aikoScene.encounterAiko).hint("Visit the Great Tree in the Deep Woods where Aiko lives.");
		else addButtonDisabled(10, "???", "???");
		if (Mindbreaker.MindBreakerQuest == Mindbreaker.QUEST_STAGE_ISMB) addButton(11, "Eldritch Caves", SceneLib.mindbreaker.CaveLayout).hint("Visit the mindbreaker lair.");
		//11 - ???
//	if (flags[kFLAGS.PRISON_CAPTURE_COUNTER] > 0) addButton(12, "Prison", CoC.instance.prison.prisonIntro, false, null, null, "Return to the prison and continue your life as Elly's slave.");
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
			else addButton(1, "Quarry", camp.cabinProgress.quarrySite).hint("You can mine here to get stones, gems and maybe even some ores. <b>(Daylight)</b>");
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
	
	private function placesAtNight():void {
		hideMenus();
		clearOutput();
		outputText("Which place would you like to visit?");
		menu();
		if (player.hasStatusEffect(StatusEffects.ResourceNode1)) {
			//if (player.statusEffectv1(StatusEffects.ResourceNode1) < 5) addButtonDisabled(0, "???", "You need to explore Forest more to unlock this place.");
			//else addButton(0, "Woodcutting", camp.cabinProgress.gatherWoods).hint("You can cut some trees here to get wood.");
			if (player.statusEffectv2(StatusEffects.ResourceNode1) < 5) addButtonDisabled(1, "???", "You need to explore Mountains more to unlock this place.");
			else addButton(1, "Quarry (N)", curry(camp.cabinProgress.quarrySite, true)).hint("You can mine here to get stones, gems and maybe even some ores. <b>(Night)</b>");
		}
		else {
			//addButtonDisabled(0, "???", "Search the forest.");
			addButtonDisabled(1, "???", "Search the mountains.");
		}
		addButton(14, "Back", playerMenu);
	}

	private function dungeons():void {
		menu();
		//Main story dungeons
		if (flags[kFLAGS.FACTORY_FOUND] > 0) addButton(0, "Factory", SceneLib.dungeons.factory.enterDungeon).hint("Visit the demonic factory in the mountains." + (flags[kFLAGS.FACTORY_SHUTDOWN] > 0 ? "\n\nYou've managed to shut down the factory." : "The factory is still running. Marae wants you to shut down the factory!") + (SceneLib.dungeons.checkFactoryClear() ? "\n\nCLEARED!" : ""));
		else addButtonDisabled(0, "???", "???");
		if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0) addButton(1, "Deep Cave", SceneLib.dungeons.deepcave.enterDungeon).hint("Visit the cave you've found in the Deepwoods." + (flags[kFLAGS.DEFEATED_ZETAZ] > 0 ? "\n\nYou've defeated Zetaz, your old rival." : "") + (SceneLib.dungeons.checkDeepCaveClear() ? "\n\nCLEARED!" : ""));
		else addButtonDisabled(1, "???", "???");
		if (flags[kFLAGS.D3_DISCOVERED] > 0) addButton(2, "Stronghold", SceneLib.d3.enterD3).hint("Visit the stronghold in the high mountains that belongs to Lethice, the demon queen." + ((flags[kFLAGS.LETHICE_DEFEATED] > 0) ? "\n\nYou have slain Lethice and put an end to the demonic threats. Congratulations, you've beaten the main story!" : "") + (SceneLib.dungeons.checkLethiceStrongholdClear() ? "\n\nCLEARED!" : ""));
		else addButtonDisabled(2, "???", "???");
		//Side dungeons
		if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0) addButton(5, "Desert Cave", SceneLib.dungeons.desertcave.enterDungeon).hint("Visit the cave you've found in the desert." + (flags[kFLAGS.SAND_WITCHES_COWED] + flags[kFLAGS.SAND_WITCHES_FRIENDLY] > 0 ? "\n\nFrom what you've known, this is the source of the Sand Witches." : "") + (SceneLib.dungeons.checkSandCaveClear() ? "\n\nCLEARED!" : ""));
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
		if (flags[kFLAGS.MARAE_QUEST_COMPLETE] < 1 && flags[kFLAGS.MET_MARAE_CORRUPTED] < 2 && flags[kFLAGS.CORRUPTED_MARAE_KILLED] < 1) addButton(0, "Visit", SceneLib.boat.marae.encounterMarae).hint("Normal visit on godess island.");
		else addButtonDisabled(0, "Visit", "Visitation hours are closed till futher notice.");
		if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1 && flags[kFLAGS.MARAE_QUEST_COMPLETE] >= 1 && flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] != 1 && flags[kFLAGS.LETHICE_DEFEATED] > 0 && flags[kFLAGS.PURE_MARAE_ENDGAME] < 2) addButton(1, "P. Marae", SceneLib.boat.marae.encounterPureMaraeEndgame).hint("");
		else addButtonDisabled(1, "P. Marae", "");
		if (flags[kFLAGS.MET_MARAE_CORRUPTED] > 0 && player.gender > 0 && flags[kFLAGS.CORRUPTED_MARAE_KILLED] <= 0) {
			if (flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] == 2) addButton(2, "C. Marae", SceneLib.boat.marae.level3MaraeEncounter).hint("");
			if (flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] == 0) addButton(2, "C. Marae", SceneLib.boat.marae.level2MaraeEncounter).hint("");
		}
		else addButtonDisabled(2, "C. Marae", "");
		if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1 && flags[kFLAGS.MARAE_QUEST_COMPLETE] >= 1 && flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] == 1) addButton(3, "Minerva", SceneLib.boat.marae.talkToMaraeAboutMinervaPurification).hint("Visit godess island to talk about help for Minerva.");
		else addButtonDisabled(3, "Minerva", "");
		if (player.plantScore() >= 7 && (player.gender == 2 || player.gender == 3) && flags[kFLAGS.FACTORY_SHUTDOWN] > 0 && (flags[kFLAGS.FUCK_FLOWER_LEVEL] == 4 || flags[kFLAGS.FLOWER_LEVEL] == 4) && flags[kFLAGS.CORRUPTED_MARAE_KILLED] == 0) addButton(4, "Alraune", SceneLib.boat.marae.alraunezeMe).hint("Visit godess island to turn yourself into Alraune.");
		else addButtonDisabled(4, "Alraune", "");
		addButton(14, "Back", places);
	}

	private function exgartuanCampUpdate():void {
		//Update Exgartuan stuff
		if (player.hasStatusEffect(StatusEffects.Exgartuan)) {
			trace("EXGARTUAN V1: " + player.statusEffectv1(StatusEffects.Exgartuan) + " V2: " + player.statusEffectv2(StatusEffects.Exgartuan));
			//if too small dick, remove him
			if (player.statusEffectv1(StatusEffects.Exgartuan) == 1 && (player.cockArea(0) < 100 || player.cocks.length == 0)) {
				clearOutput();
				outputText("<b>You suddenly feel the urge to urinate, and stop over by some bushes.  It takes wayyyy longer than normal, and once you've finished, you realize you're alone with yourself for the first time in a long time.");
				if (player.hasCock()) outputText("  Perhaps you got too small for Exgartuan to handle?</b>\n");
				else outputText("  It looks like the demon didn't want to stick around without your manhood.</b>\n");
				player.removeStatusEffect(StatusEffects.Exgartuan);
				awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, true);
			}
			//Tit removal
			else if (player.statusEffectv1(StatusEffects.Exgartuan) == 2 && player.biggestTitSize() < 12) {
				clearOutput();
				outputText("<b>Black milk dribbles from your " + nippleDescript(0) + ".  It immediately dissipates into the air, leaving you feeling alone.  It looks like you became too small for Exgartuan!\n</b>");
				player.removeStatusEffect(StatusEffects.Exgartuan);
			}
		}
		doNext(playerMenu);
	}

//Wake up from a bad end.
public function wakeFromBadEnd():void {
	clearOutput();
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
	player.addStatusValue(StatusEffects.PCClone, 4, -4);
	if (player.statusEffectv1(StatusEffects.PCClone) > 0) {
		var resetjob:Number = player.statusEffectv1(StatusEffects.PCClone);
		player.addStatusValue(StatusEffects.PCClone, 1, -resetjob);
	}
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
		SceneLib.camp.cabinProgress.checkMaterials();
		outputText("\n\nIt will cost 80 nails, 80 wood and 10 stones to work on a segment of the wall.\n\n");
		if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 80 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 80) {
			doYesNo(buildCampWall, doCamp);
		} else {
			outputText("\n<b>Unfortunately, you do not have sufficient resources.</b>");
			doNext(doCamp);
		}
	}

	private function buildCampWall():void {
		var helpers:int = 0;
		var helperArray:Array = [];
		if (marbleFollower()) {
			helperArray[helperArray.length] = "Marble";
			helpers++;
		}
		if (followerHel()) {
			helperArray[helperArray.length] = "Helia";
			helpers++;
		}
		if (followerKiha()) {
			helperArray[helperArray.length] = "Kiha";
			helpers++;
		}
		if (flags[kFLAGS.ANT_KIDS] > 100) {
			helperArray[helperArray.length] = "group of your ant children";
			helpers++;
		}
		flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 80;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 80;
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
		SceneLib.camp.cabinProgress.checkMaterials();
		outputText("\n\nIt will cost 100 nails and 100 wood to build a gate.\n\n");
		if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 100 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100) {
			doYesNo(buildCampGate, doCamp);
		} else {
			outputText("\n<b>Unfortunately, you do not have sufficient resources.</b>");
			doNext(doCamp);
		}
	}

	private function buildCampGate():void {
		var helpers:int = 0;
		var helperArray:Array = [];
		if (marbleFollower()) {
			helperArray[helperArray.length] = "Marble";
			helpers++;
		}
		if (followerHel()) {
			helperArray[helperArray.length] = "Helia";
			helpers++;
		}
		if (followerKiha()) {
			helperArray[helperArray.length] = "Kiha";
			helpers++;
		}
		if (flags[kFLAGS.ANT_KIDS] > 100) {
			helperArray[helperArray.length] = "group of your ant children";
			helpers++;
		}
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 100;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
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
		player.buttKnockUpForce(); //Clear Butt preggos.
		//Scene GO!
		clearOutput();
		outputText("It's time for you to ascend. You walk to the center of the [camp], announce that you're going to ascend to a higher plane of existence, and lay down. ");
		if (companionsCount() == 1) outputText("\n\nYour fellow companion comes to witness.");
		else if (companionsCount() > 1) outputText("\n\nYour fellow companions come to witness.");
		outputText("\n\nYou begin to glow; you can already feel yourself leaving your body and you announce your departure.");
		if (marbleFollower()) outputText("\n\n\"<i>Sweetie, I'm going to miss you. See you in the next playthrough,</i>\" Marble says, tears leaking from her eyes.");
		outputText("\n\nThe world around you slowly fades to black and stars dot the endless void. <b>You have ascended.</b>");
		doNext(CoC.instance.charCreation.ascensionMenu);
	}

	public function possibleToGainAscensionPoints():Number {
		var performancePointsPrediction:Number = 0;
		//Companions
		performancePointsPrediction += companionsCount();
		if (flags[kFLAGS.ALVINA_FOLLOWER] == 12) performancePointsPrediction++;
		if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 3) performancePointsPrediction++;
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 2 || flags[kFLAGS.CHI_CHI_FOLLOWER] == 5 || player.hasStatusEffect(StatusEffects.ChiChiOff)) performancePointsPrediction++;
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == 3) performancePointsPrediction++;
		if (player.hasStatusEffect(StatusEffects.DianaOff)) performancePointsPrediction++;
		if (player.hasStatusEffect(StatusEffects.DivaOff)) performancePointsPrediction++;
		if (player.hasStatusEffect(StatusEffects.ElectraOff)) performancePointsPrediction++;
		if (player.hasStatusEffect(StatusEffects.EtnaOff)) performancePointsPrediction++;
		if (player.hasStatusEffect(StatusEffects.LunaOff)) performancePointsPrediction++;
		//Dungeons
		if (SceneLib.dungeons.checkFactoryClear()) performancePointsPrediction++;
		if (SceneLib.dungeons.checkDeepCaveClear()) performancePointsPrediction += 2;
		if (SceneLib.dungeons.checkLethiceStrongholdClear()) performancePointsPrediction += 3;
		if (SceneLib.dungeons.checkSandCaveClear()) performancePointsPrediction++;
		if (SceneLib.dungeons.checkHiddenCaveClear()) performancePointsPrediction++;
		if (SceneLib.dungeons.checkHiddenCaveHiddenStageClear()) performancePointsPrediction++;
		if (SceneLib.dungeons.checkRiverDungeon1stFloorClear()) performancePointsPrediction++;
		if (SceneLib.dungeons.checkDenOfDesireClear()) performancePointsPrediction++;
		if (SceneLib.dungeons.checkEbonLabyrinthClear()) performancePointsPrediction += 3;
		if (SceneLib.dungeons.checkPhoenixTowerClear()) performancePointsPrediction += 2;
		if (SceneLib.dungeons.checkBeeHiveClear()) performancePointsPrediction += 2;
		//Quests
		if (flags[kFLAGS.MARBLE_PURIFIED] > 0) performancePointsPrediction += 2;
		if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] >= 10) performancePointsPrediction += 2;
		if (flags[kFLAGS.URTA_QUEST_STATUS] > 0) performancePointsPrediction += 2;
		if (player.hasPerk(PerkLib.Enlightened)) performancePointsPrediction += 1;
		if (flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0 || flags[kFLAGS.PURE_MARAE_ENDGAME] >= 2) performancePointsPrediction += 3;
		if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) >= 4) performancePointsPrediction += 2;
		if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) >= 4) performancePointsPrediction += 2;
		if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) >= 4) performancePointsPrediction += 2;
		if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) >= 4) performancePointsPrediction += 2;
		if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) >= 4) performancePointsPrediction += 2;
		if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) >= 2) performancePointsPrediction++;
		if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) >= 2) performancePointsPrediction++;
		if (flags[kFLAGS.GALIA_LVL_UP] >= 0.5) performancePointsPrediction += 5;
		//Camp structures
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) performancePointsPrediction += 10;
		if (flags[kFLAGS.CAMP_WALL_GATE] > 0) performancePointsPrediction += 11;
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] > 2) performancePointsPrediction += 2;
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] > 3) performancePointsPrediction += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] > 1) performancePointsPrediction += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] > 3) performancePointsPrediction += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] > 5) performancePointsPrediction += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] > 3) performancePointsPrediction += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] > 3) performancePointsPrediction += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 1) performancePointsPrediction += ((flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] - 1) * 2);
		if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] > 0) performancePointsPrediction += flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE];
		if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] > 1) performancePointsPrediction += 2;
		if (flags[kFLAGS.CAMP_UPGRADES_DAM] > 0) performancePointsPrediction += (flags[kFLAGS.CAMP_UPGRADES_DAM] * 2);
		if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] > 0) performancePointsPrediction += (flags[kFLAGS.CAMP_UPGRADES_FISHERY] * 2);
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) performancePointsPrediction += 2;
		//Children
		var childPerformance:int = 0;
		childPerformance += (flags[kFLAGS.MINERVA_CHILDREN] + flags[kFLAGS.BEHEMOTH_CHILDREN] + flags[kFLAGS.MARBLE_KIDS] + (flags[kFLAGS.SHEILA_JOEYS] + flags[kFLAGS.SHEILA_IMPS]) + izmaScene.totalIzmaChildren() + isabellaScene.totalIsabellaChildren() + kihaFollower.totalKihaChildren() + emberScene.emberChildren() + urtaPregs.urtaKids() + sophieBimbo.sophieChildren());
		childPerformance += (flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] + flags[kFLAGS.KELLY_KIDS] + flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] + flags[kFLAGS.COTTON_KID_COUNT] + flags[kFLAGS.AMILY_BIRTH_TOTAL] + flags[kFLAGS.PC_TIMES_BIRTHED_AMILYKIDS] + joyScene.getTotalLitters() + SceneLib.excelliaFollower.totalExcelliaChildren() + flags[kFLAGS.ZENJI_KIDS]);
		childPerformance += ((flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 4) + (flags[kFLAGS.LYNNETTE_BABY_COUNT] / 4) + (flags[kFLAGS.ANT_KIDS] / 100) + (flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] / 4) + (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] / 4) + (flags[kFLAGS.MITZI_DAUGHTERS] / 4));
		childPerformance += ((DriderTown.BelisaKids / 4) + (DriderTown.LilyKidsPC / 4) + ((DriderTown.TyrantiaFemaleKids + DriderTown.TyrantiaMaleKids) / 4) + flags[kFLAGS.AYANE_CHILDREN_MALES] + flags[kFLAGS.AYANE_CHILDREN_FEMALES] + flags[kFLAGS.AYANE_CHILDREN_HERMS]);
		performancePointsPrediction += Math.sqrt(childPerformance);
		//Various Level trackers
		performancePointsPrediction += player.level;
		if (player.level >= 42) performancePointsPrediction += (player.level - 41);
		if (player.level >= 102) performancePointsPrediction += (player.level - 101);
		if (player.level >= 180) performancePointsPrediction += (player.level - 179);
		if (player.teaseLevel >= 25) {
			performancePointsPrediction += 25;
		}
		else performancePointsPrediction += player.teaseLevel;
		performancePointsPrediction = Math.round(performancePointsPrediction);
		return performancePointsPrediction;
	}

	public function setLevelButton(allowAutoLevelTransition:Boolean):Boolean {
		var levelup:Boolean = player.XP >= player.requiredXP() && player.level < CoC.instance.levelCap;
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
				mainView.setMenuButton(MainView.MENU_LEVEL, "Level Up");
				var hp:int = 60;
				var fatigue:int = 5;
				var mana:int = 10;
				var soulforce:int = 5;
				var wrath:int = 5;
				var lust:int = 3;
				var statpoints:int = 5;
				var perkpoints:int = 1;
				if (player.level <= 6) {
					hp += 60;
					fatigue += 5;
					mana += 10;
					soulforce += 5;
					wrath += 5;
					lust += 3;
				}
				if (player.hasPerk(PerkLib.AscensionUnlockedPotential)) {
					hp += 80;
					lust += 6;
					fatigue += 6;
				}
				if (player.hasPerk(PerkLib.AscensionUnlockedPotential2ndStage)) {
					wrath += 10;
					mana += 12;
					soulforce += 6;
				}
				if (player.hasPerk(PerkLib.AscensionUnlockedPotential3rdStage)) {
					hp += 80;
					lust += 6;
					fatigue += 6;
				}
				if (player.hasPerk(PerkLib.AscensionUnlockedPotential4thStage)) {
					wrath += 10;
					mana += 12;
					soulforce += 6;
				}
				if (player.hasPerk(PerkLib.AscensionAdvTrainingX)) statpoints += player.perkv1(PerkLib.AscensionAdvTrainingX);
				if (player.hasPerk(PerkLib.UnlockBody)) hp += 60;
				if (player.hasPerk(PerkLib.UnlockBody2ndStage)) hp += 60;
				if (player.hasPerk(PerkLib.UnlockBody3rdStage)) hp += 60;
				if (player.hasPerk(PerkLib.UnlockBody4thStage)) hp += 60;
				if (player.hasPerk(PerkLib.UnlockEndurance)) fatigue += 5;
				if (player.hasPerk(PerkLib.UnlockEndurance2ndStage)) fatigue += 5;
				if (player.hasPerk(PerkLib.UnlockEndurance3rdStage)) fatigue += 5;
				if (player.hasPerk(PerkLib.UnlockEndurance4thStage)) fatigue += 5;
				if (player.hasPerk(PerkLib.UnlockForce)) mana += 10;
				if (player.hasPerk(PerkLib.UnlockForce2ndStage)) mana += 10;
				if (player.hasPerk(PerkLib.UnlockForce3rdStage)) mana += 10;
				if (player.hasPerk(PerkLib.UnlockForce4thStage)) mana += 10;
				if (player.hasPerk(PerkLib.UnlockSpirit)) soulforce += 5;
				if (player.hasPerk(PerkLib.UnlockSpirit2ndStage)) soulforce += 5;
				if (player.hasPerk(PerkLib.UnlockSpirit3rdStage)) soulforce += 5;
				if (player.hasPerk(PerkLib.UnlockSpirit4thStage)) soulforce += 5;
				if (player.hasPerk(PerkLib.UnlockId)) wrath += 5;
				if (player.hasPerk(PerkLib.UnlockId2ndStage)) wrath += 5;
				if (player.hasPerk(PerkLib.UnlockId3rdStage)) wrath += 5;
				if (player.hasPerk(PerkLib.UnlockId4thStage)) wrath += 5;
				if (player.hasPerk(PerkLib.UnlockArdor)) lust += 3;
				if (player.hasPerk(PerkLib.UnlockArdor2ndStage)) lust += 3;
				if (player.hasPerk(PerkLib.UnlockArdor3rdStage)) lust += 3;
				if (player.hasPerk(PerkLib.UnlockArdor4thStage)) lust += 3;
				if (player.level < 6) {
					statpoints *= 2;
					perkpoints *= 2;
				}
				mainView.levelButton.toolTipText = "Level up to increase your maximum: HP by " + hp + ", Lust by " + lust + ", Wrath by " + wrath + ", Fatigue by " + fatigue + ", Mana by " + mana + " and Soulforce by " + soulforce + "; gain " + statpoints + " attribute points and " + perkpoints + " perk point"+(perkpoints>1?"s":"")+".";
				if (flags[kFLAGS.AUTO_LEVEL] > 0 && allowAutoLevelTransition) {
					CoC.instance.playerInfo.levelUpGo();
					return true; //True indicates that you should be routed to level-up.
				}

			}
			mainView.showMenuButton(MainView.MENU_LEVEL);
			mainView.statsView.showLevelUp();
			if (player.str >= player.strStat.max && player.tou >= player.touStat.max && player.inte >= player.intStat.max && player.spe >= player.speStat.max && (player.perkPoints <= 0 || PerkTree.availablePerks(CoC.instance.player).length <= 0) && (player.XP < player.requiredXP() || player.level >= CoC.instance.levelCap)) {
				mainView.statsView.hideLevelUp();
			}
		} else {
			mainView.hideMenuButton(MainView.MENU_LEVEL);
			mainView.statsView.hideLevelUp();
		}
		return false;
	}

//Camp population!
	public function getCampPopulation():int {
		var pop:int = 0; //Once you enter Mareth, this will increase to 1.
		if (flags[kFLAGS.IN_INGNAM] <= 0) pop++; //You count toward the population!
		pop += companionsCount();
		//------------
		//Misc check!
		if (ceraphIsFollower()) pop--; //Ceraph doesn't stay in your camp.
		if (player.armor == armors.GOOARMR) pop++; //Include Valeria if you're wearing her.
		if (flags[kFLAGS.CLARA_IMPRISONED] > 0) pop++;
		//------------
		//Children check!
		//Followers
		if (followerEmber() && emberScene.emberChildren() > 0) pop += emberScene.emberChildren();
		if (SceneLib.ayaneFollower.ayaneChildren() > 0) pop += SceneLib.ayaneFollower.ayaneChildren();
		//Jojo's offsprings don't stay in your camp; they will join with Amily's litters as well.
		if (sophieFollower()) {
			if (flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) pop++;
			if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT]) pop += flags[kFLAGS.SOPHIE_ADULT_KID_COUNT];
		}

		//Lovers
		//Amily's offsprings don't stay in your camp.
		//Helia can only have 1 child: Helspawn. She's included in companions count.
		if (isabellaFollower() && isabellaScene.totalIsabellaChildren() > 0) pop += isabellaScene.totalIsabellaChildren();
		if (izmaFollower() && izmaScene.totalIzmaChildren() > 0) pop += izmaScene.totalIzmaChildren();
		if (followerKiha() && kihaFollower.totalKihaChildren() > 0) pop += kihaFollower.totalKihaChildren();
		if (marbleFollower() && flags[kFLAGS.MARBLE_KIDS] > 0) pop += flags[kFLAGS.MARBLE_KIDS];
		if (flags[kFLAGS.ANT_WAIFU] > 0 && (flags[kFLAGS.ANT_KIDS] > 0 || flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] > 0)) pop += (flags[kFLAGS.ANT_KIDS] + flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT]);
		if (flags[kFLAGS.ZENJI_KIDS] > 0) pop += flags[kFLAGS.ZENJI_KIDS];
		if (DriderTown.BelisaKids > 0) pop += DriderTown.BelisaKids;
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

    public function recallScenes():void {
        clearOutput();
        outputText("You close your eyes, remembering all this life put you through. All your fights, friends... lovers.\n\n");
        outputText("Though many things are still repeatable, you still remember some unique events of your life, and one question bothers you - what would happen if you were different at the moment? How would you and your companions look and behave right now?\n");
		outputText("Falling asleep, you think about it, recalling the exact time and place...\n\n");
		outputText("\n\n<b>This part is WIP, and will be updated with SceneHunter.</b>");
		outputText("\n<i>All scenes listed here are unique one-timers that contained multiple choices or different variations for player's - or even followers' - race or body parts. When recalling, your <b>current</b> body and game state is used, so you can try to explore more options for yourself!");
		outputText("\nOf course, you need to unlock the scene in the game first. The hints are provided above the buttons.");
		outputText("\nIt's recommended to enable SceneHunter 'Print Checks' feature to keep track of all hidden checks during these scenes.</i>");
        recalling = true; //Setting the flag to disable everything but text
        menu();
        //Marble scene
		if (flags[kFLAGS.MARBLE_PURIFIED] == 1)
			addButton(0, "Marble & Clara", SceneLib.marblePurification.defeatClaraCuntInAFight, false).hint("The punishment for Marble's bitchy sister.");
		//Excellia slave first scene
		if (flags[kFLAGS.EXCELLIA_RECRUITED] == 2)
			addButton(1, "Excellia Slv", SceneLib.excelliaFollower.ExcelliaPathChoiceMakeSlave).hint("Excellia acknowledges herself as your slave.");
        //Phylla demon fuck
		if (flags[kFLAGS.ANT_COLONY_KEPT_HIDDEN] || flags[kFLAGS.PHYLLA_SAVED]) {
            if (player.cor >= 66 - player.corruptionTolerance && player.gender > 0)
                addButton(2, "PhyllaCart", SceneLib.desert.antsScene.demonsFuckAntgirl).hint("Maybe you should have left Phylla to demons and watch them having fun?");
            else addButtonDisabled(2, "PhyllaCart", "You must be corrupted and not genderless to recall this.");
        }
		//Phylla keks
		if (flags[kFLAGS.ANT_WAIFU] || flags[kFLAGS.PHYLLA_STAY_HOME])
			addButton(3, "PhyFirstTime", SceneLib.desert.antsScene.antGirlGoodEnd).hint("Your first time with Phylla.");
        //Tamani first time
		if (flags[kFLAGS.TAMANI_MET] == 1 && player.hasCock())
			addButton(4, "TamaniFirst", SceneLib.forest.tamaniScene.tamaniFirstTimeConsentual).hint("First time with Tamani.");
		//Tamani first time
		if (player.hasKeyItem("Deluxe Dildo") >= 0 && player.hasVagina())
			addButton(5, "TamaniLes", SceneLib.forest.tamaniScene.preferTamaniFemdom).hint("Girl-on-girl event with Tamani.");
		//Erlking revenge
		if (player.hasKeyItem("Golden Antlers") >= 0 && player.gender > 0)
			addButton(6, "Erlk.Revenge", SceneLib.forest.erlkingScene.howDareYou).hint("You show Erlking <b>who</b> is the hunter here.");
		//Nightmare
		if (celessScene.questFinishedNightmare)
			addButton(7, "Nightmare", SceneLib.forest.nightmareScene.nightmareVictory).hint("Demonic bicorn fucks you into a pile of mess.");
		//Sapphire
		if (flags[kFLAGS.SAPPHIRE_AFFECTION] == 100)
			addButton(8, "SapphireFirst", SceneLib.templeofdivine.sapphire.sapphireFirstTime).hint("Sapphire discovers carnal pleasures");
		//Venus cock scenes
		if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2 && flags[kFLAGS.KAIJU_COCK] == 1)
			addButton(9, "VenusCock", SceneLib.boat.kaiju.kaijuGrowsWangus).hint("Venus discovers her new cock.");

		addButton(13, "Dungeons", recallScenes_dungeons);
		addButton(14, "Wake Up", recallWakeUp);
	}

	public function recallScenes_dungeons():void {
		menu();
		if (flags[kFLAGS.SANDWITCH_MOB_DEFEATED])
			addButton(0, "SandWitchMob", SceneLib.dungeons.desertcave.yoYouBeatUpSomeSandWitchesYOUMONSTER).hint("Punish some sand witches for attacking you.");
		if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0) addButton(1, "Deep Cave", recallScenes_deepCave);
		if (flags[kFLAGS.D3_DISCOVERED] > 0) addButton(2, "Stronghold", recallScenes_d3);
		addButton(14, "Back", recallScenes);
	}

	public function recallScenes_deepCave():void {
		menu();
		//Doppel
		if (flags[kFLAGS.ZETAZ_IMP_HORDE_DEFEATED])
			addButton(0, "Imp Horde", SceneLib.dungeons.deepcave.impGangVICTORY).hint("I'll never stop at one. YOU'LL TAKE THEM ALL ON!");
		if (flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0 || flags[kFLAGS.TIMES_FUCKED_VALA_IN_DUNGEON] > 0)
			addButton(1, "Vala (Freed)", SceneLib.vala.freeValazLooseCoochie).hint("Vala tries to enjoy her freedom and fuck the first person she sees.");
        if (flags[kFLAGS.DEFEATED_ZETAZ])
			addButton(2, "Zetaz", SceneLib.dungeons.deepcave.defeatZetaz).hint("Maybe the little asshole should have been tortured a bit more?");
		if (flags[kFLAGS.INVESTIGATED_VALA_AFTER_ZETAZ_DEFEATED])
			addButton(3, "Vala (Later)", SceneLib.vala.leftValaAlone).hint("Vala has spent some time alone and is VERY bored..");
		addButton(14, "Back", recallScenes_dungeons);
	}

	public function recallScenes_d3():void {
		menu();
		//Doppel
		if (flags[kFLAGS.D3_MIRRORS_SHATTERED])
			addButton(0, "Doppelganger", SceneLib.d3.doppleganger.punchYourselfInTheBalls).hint("Go fuck yourself!");
		//DriderIncubus
		if (flags[kFLAGS.DRIDERINCUBUS_DEFEATED])
			addButton(1, "DriderI & M", SceneLib.d3.driderIncubus.beatTheSpooderbutt, false).hint("Recall the glorious defeat of the drider-incubus and maybe take your 'reward'.");
		//HermCentaur
		if (flags[kFLAGS.D3_CENTAUR_DEFEATED] > 0)
			addButton(2, "HermCentaur", SceneLib.d3.hermCentaur.beatThePony, false).hint("Get your 'reward' for beating the herm centaur in the stronghold.");
		//MinoKing
		if (flags[kFLAGS.MINOTAURKING_DEFEATED] > 0)
			addButton(3, "M.King & Exc", SceneLib.d3.minotaurKing.theKingIsDeadLongLiveTheKing).hint("If you didn't have time or the mood for using 2 cowsluts before fighting Lethice, you can do it in your imagination!");
		//Lethice
		if (flags[kFLAGS.LETHICE_DEFEATED] > 0)
			addButton(4, "Lethice", SceneLib.d3.lethice.defeated, false).hint("While you can't make her your eternal slave, you can punish her for her arrogance in your memories as much as you want.");

		addButton(14, "Back", recallScenes_dungeons);
	}

    public function recallWakeUp():void {
		clearOutput();
		outputText("You wake up from your dreams, satisfied. Well, this was a fun ride. But you still a lot ahead, so daydreaming is not the best way to waste your time. So... time to experience a few fresh adventures, so you'll have more to recall later?");
        recalling = false; //EVERY recall scene must return here to clear the flag.
        doNext(returnToCampUseOneHour);
    }
	}
}