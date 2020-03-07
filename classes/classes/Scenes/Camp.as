package classes.Scenes{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.*;
import classes.Scenes.Areas.HighMountains.TempleOfTheDivine;
import classes.Scenes.Camp.*;
import classes.Scenes.Dungeons.*;
import classes.Scenes.NPCs.*;
import classes.Scenes.Places.HeXinDao;
import classes.lists.Gender;

import coc.view.CoCButton;
import coc.view.ButtonDataList;
import coc.view.MainView;

use namespace CoC;

	public class Camp extends NPCAwareContent{

		protected function set timeQ(value:Number):void
		{
			CoC.instance.timeQ = value;
		}
		private var campQ:Boolean = false;
		private var waitingORresting:int = 1;

		protected function hasItemInStorage(itype:ItemType):Boolean
		{
			return SceneLib.inventory.hasItemInStorage(itype);
		}
/*
		protected function hasItemsInStorage():Boolean
		{
			return CoC.instance.inventory.hasItemsInStorage();
		}
		protected function hasItemsInRacks(armor:Boolean = false):Boolean
		{
			return CoC.instance.inventory.hasItemsInRacks(type);
		}
*/

		public function Camp(/*campInitialize:Function*/) {
			EventParser.doCamp=doCamp;
			//campInitialize(doCamp); //Pass the doCamp function up to CoC. This way doCamp is private but the CoC class itself can call it.
		}
		
		public var cabinProgress:CabinProgress = new CabinProgress();
		public var campUpgrades:CampUpgrades = new CampUpgrades();
		public var campScenes:CampScenes = new CampScenes();
		public var campMake:CampMakeWinions = new CampMakeWinions();
		public var campUniqueScenes:UniqueCampScenes = new UniqueCampScenes();
		public var codex:Codex = new Codex();
		public var questlog:Questlog = new Questlog();
		public var soulforce:Soulforce = new Soulforce();
		public var hexindao:HeXinDao = new HeXinDao();
		public var dungeon1:Factory = new Factory();
		public var dungeon2:DeepCave = new DeepCave();
		public var dungeonS:DesertCave = new DesertCave();
		public var dungeonH:HelDungeon = new HelDungeon();
		public var dungeonHC:HiddenCave = new HiddenCave();
		public var dungeonDD:DenOfDesire = new DenOfDesire();
		public var dungeonAP:AnzuPalace = new AnzuPalace();
		public var dungeonEL:EbonLabyrinth = new EbonLabyrinth();
		public var EvangelineF:EvangelineFollower = new EvangelineFollower();
		public var Magnolia:MagnoliaFollower = new MagnoliaFollower();
		public var HolliPure:HolliPureScene = new HolliPureScene();
		public var templeofdivine:TempleOfTheDivine = new TempleOfTheDivine();
		
		private static var _campFollowers:Vector.<XXCNPC> = new Vector.<XXCNPC>;
		
		public static function addFollower(newEntry:XXCNPC):void {_campFollowers.push(newEntry); }
		
		public static function removeFollower(toRemove:XXCNPC):void{
			var i:int = _campFollowers.indexOf(toRemove);
			if (i >= 0){_campFollowers.splice(i, 1); }
		}
/* Replaced with calls to playerMenu
		public function campMenu():void {
			CoC.instance.playerMenu();
		}
*/
		
		public function returnToCamp(timeUsed:int):void {
			clearOutput();
			if (timeUsed == 1)
				outputText("An hour passes...\n");
			else outputText(Num2Text(timeUsed) + " hours pass...\n");
            if (!CoC.instance.inCombat) spriteSelect(-1);
            hideMenus();
			timeQ = timeUsed;
			goNext(timeUsed, false);
		}
		
		public function returnToCampUseOneHour():void { returnToCamp(1); } //Replacement for event number 13;
		public function returnToCampUseTwoHours():void { returnToCamp(2); } //Replacement for event number 14;
		public function returnToCampUseFourHours():void { returnToCamp(4); } //Replacement for event number 15;
		public function returnToCampUseSixHours():void { returnToCamp(6); }
		public function returnToCampUseEightHours():void { returnToCamp(8); } //Replacement for event number 16;
		public function returnToCampUseTwelveHours():void { returnToCamp(12); }
		
//  SLEEP_WITH:int = 701;

	//Used to determine scenes if you choose to play joke on them. Should the variables be moved to flags?
	protected var izmaJoinsStream:Boolean;
	protected var marbleJoinsStream:Boolean;
	protected var heliaJoinsStream:Boolean;
	protected var amilyJoinsStream:Boolean;

public function EzekielCurseQuickFix():void
{
	clearOutput();
	outputText("Like with a magic wand touch some divine being has blessed you. And before leaving meantioned about never again selling or discarding odd fruits.");
	if (player.findPerk(PerkLib.EzekielBlessing) < 0) player.createPerk(PerkLib.EzekielBlessing, 0, 0, 0, 0);
	if (player.hasStatusEffect(StatusEffects.EzekielCurse)) player.removeStatusEffect(StatusEffects.EzekielCurse);
	statScreenRefresh();
	dynStats("str", 5, "tou", 5, "spe", 5, "inte", 5, "lib", 5);
	doCamp();

}

private function doCamp():void { //Only called by playerMenu
	//Force autosave on HARDCORE MODE! And level-up.
	if (player.slotName != "VOID" && mainView.getButtonText(0) != "Game Over" && flags[kFLAGS.HARDCORE_MODE] > 0) 
	{
		trace("Autosaving to slot: " + player.slotName);

CoC.instance.saves.saveGame(player.slotName);
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
	mainView.showMenuButton( MainView.MENU_NEW_MAIN );
	if(player.hasStatusEffect(StatusEffects.PostAkbalSubmission)) {
		player.removeStatusEffect(StatusEffects.PostAkbalSubmission);
		SceneLib.forest.akbalScene.akbalSubmissionFollowup();
		return;
	}
	if(player.hasStatusEffect(StatusEffects.PostAnemoneBeatdown)) {
		HPChange(Math.round(player.maxHP()/2),false);
		player.removeStatusEffect(StatusEffects.PostAnemoneBeatdown);
	}
/* Can't happen - playerMenu will call dungeon appropriate menu instead of doCamp while inDungeon is true
	if (CoC.instance.inDungeon) {
		mainView.showMenuButton( MainView.MENU_DATA );
		mainView.showMenuButton( MainView.MENU_APPEARANCE );
		CoC.instance.playerMenu();
		return;
	}
*/
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
	fixFlags();
	if(player.hasStatusEffect(StatusEffects.Might)) {
		if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) player.dynStats("int", -player.statusEffectv1(StatusEffects.Might));
		else player.dynStats("str", -player.statusEffectv1(StatusEffects.Might));
		player.dynStats("tou", -player.statusEffectv2(StatusEffects.Might));
		player.removeStatusEffect(StatusEffects.Might);
	}
	if(player.hasStatusEffect(StatusEffects.Blink)) {
		player.dynStats("spe", -player.statusEffectv1(StatusEffects.Blink));
		player.removeStatusEffect(StatusEffects.Blink);
	}
	if(player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
		player.removeStatusEffect(StatusEffects.ChargeWeapon);
	}
	if(player.hasStatusEffect(StatusEffects.ChargeArmor)) {
		player.removeStatusEffect(StatusEffects.ChargeArmor);
	}
	if (player.hasStatusEffect(StatusEffects.PCDaughters)) {
		campScenes.goblinsBirthScene();
		return;
	}
	if(player.hasItem(useables.SOULGEM, 1) && player.hasStatusEffect(StatusEffects.CampRathazul) && flags[kFLAGS.DEN_OF_DESIRE_QUEST] < 1) {
		campUniqueScenes.playsRathazulAndSoulgemScene();
		return;
	}
	if(!marbleScene.marbleFollower()) {
		if(flags[kFLAGS.MARBLE_LEFT_OVER_CORRUPTION] == 1 && player.cor <= 40)
		{
			hideMenus();
			marblePurification.pureMarbleDecidesToBeLessOfABitch();
			return;
		}
	}
	if(marbleScene.marbleFollower()) {
		//Cor < 50
		//No corrupt: Jojo, Amily, or Vapula
		//Purifying Murble
		if(player.cor < 50 && !campCorruptJojo() && !amilyScene.amilyCorrupt() && !vapulaSlave() 
			&& flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 0 && flags[kFLAGS.MARBLE_COUNTUP_TO_PURIFYING] >= 200
			&& player.findPerk(PerkLib.MarblesMilk) < 0)
		{
			hideMenus();
			marblePurification.BLUHBLUH();
			return;
		}
		if(flags[kFLAGS.MARBLE_PURIFICATION_STAGE] >= 5)
		{
			if(flags[kFLAGS.MARBLE_WARNED_ABOUT_CORRUPTION] == 0 && player.cor >= 50 + player.corruptionTolerance())
			{
				hideMenus();
				marblePurification.marbleWarnsPCAboutCorruption();
				return;
			}
			if(flags[kFLAGS.MARBLE_WARNED_ABOUT_CORRUPTION] == 1 && flags[kFLAGS.MARBLE_LEFT_OVER_CORRUPTION] == 0 && player.cor >= 60 + player.corruptionTolerance())
			{
				hideMenus();
				marblePurification.marbleLeavesThePCOverCorruption();
				return;
			}
		}
		if(flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_1] == 1 && (time.hours == 6 || time.hours == 7))
		{
			hideMenus();
			marblePurification.rathazulsMurbelReport();
			return;
		}
		if(flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_2] == 1)
		{
			hideMenus();
			marblePurification.claraShowsUpInCampBECAUSESHESACUNT();
			return;
		}
	}
	if(arianFollower() && flags[kFLAGS.ARIAN_MORNING] == 1) {
		hideMenus();
		arianScene.wakeUpAfterArianSleep();
		return;
	}
	if(arianFollower() && flags[kFLAGS.ARIAN_EGG_EVENT] >= 30) {
		hideMenus();
		arianScene.arianEggingEvent();
		return;
	}
	if(arianFollower() && flags[kFLAGS.ARIAN_EGG_COUNTER] >= 24 && flags[kFLAGS.ARIAN_VAGINA] > 0) {
		hideMenus();
		arianScene.arianLaysEggs();
		return;
	}
	if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 && flags[kFLAGS.JOY_NIGHT_FUCK] == 1) {
		joyScene.wakeUpWithJoyPostFuck();
		return;
	}
	if (flags[kFLAGS.EMBER_MORNING] > 0 && ((flags[kFLAGS.BENOIT_CLOCK_BOUGHT] > 0 && model.time.hours >= flags[kFLAGS.BENOIT_CLOCK_ALARM]) || (flags[kFLAGS.BENOIT_CLOCK_BOUGHT] <= 0 && model.time.hours >= 6))) {
		hideMenus();
		emberScene.postEmberSleep();
		return;
	}
	if(flags[kFLAGS.JACK_FROST_PROGRESS] > 0) {
		hideMenus();
		Holidays.processJackFrostEvent();
		return;
	}
	if(player.hasKeyItem("Super Reducto") < 0 && milkSlave() && player.hasStatusEffect(StatusEffects.CampRathazul) && player.statusEffectv2(StatusEffects.MetRathazul) >= 4) {
		hideMenus();
		milkWaifu.ratducto();
		return;
	}
	if(Holidays.nieveHoliday() && model.time.hours == 6) {
		if(player.hasKeyItem("Nieve's Tear") >= 0 && flags[kFLAGS.NIEVE_STAGE] != 5)
		{
			Holidays.returnOfNieve();
			hideMenus();
			return;
		}
		else if(flags[kFLAGS.NIEVE_STAGE] == 0) {
			hideMenus();
			Holidays.snowLadyActive();
			return;
		}
		else if(flags[kFLAGS.NIEVE_STAGE] == 4) {
			hideMenus();
			Holidays.nieveComesToLife();
			return;
		}
	}
	if (SceneLib.helScene.followerHel()) {
		if (helFollower.isHeliaBirthday() && flags[kFLAGS.HEL_FOLLOWER_LEVEL] >= 2 && flags[kFLAGS.HELIA_BIRTHDAY_OFFERED] == 0) {
			hideMenus();
			helFollower.heliasBirthday();
			return;
		}
		if (SceneLib.helScene.pregnancy.isPregnant) {
			switch (SceneLib.helScene.pregnancy.eventTriggered()) {
				case 2: hideMenus();
						helSpawnScene.bulgyCampNotice();
						return;
				case 3: hideMenus();
						helSpawnScene.heliaSwollenNotice();
						return;
				case 4: hideMenus();
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
	if(flags[kFLAGS.HELSPAWN_AGE] == 1 && flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] == 7) {
		hideMenus();
		helSpawnScene.helSpawnGraduation();
		return;
	}
	if(model.time.hours >= 10 && model.time.hours <= 18 && (model.time.days % 20 == 0 || model.time.hours == 12) && flags[kFLAGS.HELSPAWN_DADDY] == 2 && helSpawnScene.helspawnFollower()) {
		hideMenus();
		helSpawnScene.maiVisitsHerKids();
		return;
	}
	if(model.time.hours == 6 && flags[kFLAGS.HELSPAWN_DADDY] == 1 && model.time.days % 30 == 0 && flags[kFLAGS.SPIDER_BRO_GIFT] == 0 && helSpawnScene.helspawnFollower())
	{
		hideMenus();
		helSpawnScene.spiderBrosGift();
		return;
	}
	if(model.time.hours >= 10 && model.time.hours <= 18 && (model.time.days % 15 == 0 || model.time.hours == 12) && helSpawnScene.helspawnFollower() && flags[kFLAGS.HAKON_AND_KIRI_VISIT] == 0) {
		hideMenus();
		helSpawnScene.hakonAndKiriComeVisit();
		return;
	}
	if(flags[kFLAGS.HELSPAWN_AGE] == 2 && flags[kFLAGS.HELSPAWN_DISCOVER_BOOZE] == 0 && (rand(10) == 0 || flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] == 6)) {
		hideMenus();
		helSpawnScene.helspawnDiscoversBooze();
		return;
	}
	if(flags[kFLAGS.HELSPAWN_AGE] == 2 && flags[kFLAGS.HELSPAWN_WEAPON] == 0 && flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] >= 3 && model.time.hours >= 10 && model.time.hours <= 18) {
		hideMenus();
		helSpawnScene.helSpawnChoosesAFightingStyle();
		return;
	}
	if(flags[kFLAGS.HELSPAWN_AGE] == 2 && (model.time.hours == 6 || model.time.hours == 7) && flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] >= 7 && flags[kFLAGS.HELSPAWN_FUCK_INTERRUPTUS] == 1) {
		helSpawnScene.helspawnAllGrownUp();
		return;
	}
	if((sophieFollower() || bimboSophie()) && flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] == 1) {
		flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] = 0;
		sophieBimbo.sophieKidMaturation();
		hideMenus();
		return;
	}
	//Bimbo Sophie Move In Request!
	if (bimboSophie() && flags[kFLAGS.SOPHIE_BROACHED_SLEEP_WITH] == 0 && sophieScene.pregnancy.event >= 2)
	{
		hideMenus();
		sophieBimbo.sophieMoveInAttempt();
		return;
	}
	if(!Holidays.nieveHoliday() && model.time.hours == 6 && flags[kFLAGS.NIEVE_STAGE] > 0) {
		Holidays.nieveIsOver();
		return;
	}
	//Amily followup!
	if(flags[kFLAGS.PC_PENDING_PREGGERS] == 1) {
		SceneLib.amilyScene.postBirthingEndChoices();
		flags[kFLAGS.PC_PENDING_PREGGERS] = 2;
		return;
	}
	if(timeQ > 0) {
		if(!campQ) {
			clearOutput();
			outputText("More time passes...\n");
			goNext(timeQ, false);
			return;
		}
		else {
			if (model.time.hours < 6 || model.time.hours > 20) {
				doSleep();
			}
			else {
				rest();
			}
			return;
		}
	}
	if(flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] > 0 && (flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0)) {
		if(flags[kFLAGS.FUCK_FLOWER_LEVEL] == 0 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 8) {
			holliScene.getASprout();
			hideMenus();
			return;
		}
		if(flags[kFLAGS.FUCK_FLOWER_LEVEL] == 1 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 7) {
			holliScene.fuckPlantGrowsToLevel2();
			hideMenus();
			return;
		}
		if(flags[kFLAGS.FUCK_FLOWER_LEVEL] == 2 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 25) {
			holliScene.flowerGrowsToP3();
			hideMenus();
			return;
		}
		//Level 4 growth
		if(flags[kFLAGS.FUCK_FLOWER_LEVEL] == 3 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 40) {
			holliScene.treePhaseFourGo();
			hideMenus();
			return;
		}
	}
	if(flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.MARAE_QUEST_COMPLETE] == 1 && (flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0)) {
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
		if(flags[kFLAGS.FLOWER_LEVEL] == 2 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 25) {
			HolliPure.flowerGrowsToP3();
			hideMenus();
			return;
		}
		//Level 4 growth
		if(flags[kFLAGS.FLOWER_LEVEL] == 3 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] >= 40) {
			HolliPure.treePhaseFourGo();
			hideMenus();
			return;
		}
	}
	if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] > 1 && flags[kFLAGS.CHRISTMAS_TREE_LEVEL] < 5 && (flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0)) {
		if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 2 && flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] >= 6) {
			Magnolia.plantGrowsToLevel2();
			hideMenus();
			return;
		}
		if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 3 && flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] >= 22) {
			Magnolia.plantGrowsToLevel3();
			hideMenus();
			return;
		}
		if(flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 4 && flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] >= 34) {
			Magnolia.plantGrowsToLevel4();
			hideMenus();
			return;
		}
	}
	//Jojo treeflips!
	if (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] < 3) {
		holliScene.JojoTransformAndRollOut();
		hideMenus();
		return;
	}
	//Amily flips out
	if(amilyScene.amilyFollower() && !amilyScene.amilyCorrupt() && flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0) {
		holliScene.amilyHatesTreeFucking();
		hideMenus();
		return;
	}
	if(flags[kFLAGS.FUCK_FLOWER_KILLED] == 1 && flags[kFLAGS.AMILY_TREE_FLIPOUT] == 1 && !amilyScene.amilyFollower() && flags[kFLAGS.AMILY_VISITING_URTA] == 0) {
		holliScene.amilyComesBack();
		flags[kFLAGS.AMILY_TREE_FLIPOUT] = 2;
		hideMenus();
		return;
	}
	//Anemone birth followup!
	if(player.hasStatusEffect(StatusEffects.CampAnemoneTrigger)) {
		player.removeStatusEffect(StatusEffects.CampAnemoneTrigger);
		anemoneScene.anemoneKidBirthPtII();
		hideMenus();
		return;
	}
	for each (var npc:XXCNPC in _campFollowers){
		if (npc.checkCampEvent()){return;}
	}
	//Exgartuan clearing
	if(player.statusEffectv1(StatusEffects.Exgartuan) == 1 && (player.cockArea(0) < 100 || player.cocks.length == 0)) {
		exgartuanCampUpdate();
		return;
	}
	else if(player.statusEffectv1(StatusEffects.Exgartuan) == 2 && player.biggestTitSize() < 12) {
		exgartuanCampUpdate();
		return;
	}
	//Izzys tits asplode
	if(isabellaFollower() && flags[kFLAGS.ISABELLA_MILKED_YET] >= 10 && player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") >= 0) {
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
	if(flags[kFLAGS.ISABELLA_MURBLE_BLEH] == 1 && isabellaFollower() && player.hasStatusEffect(StatusEffects.CampMarble)) {
		isabellaFollowerScene.angryMurble();
		hideMenus();
		return;
	}
	//Mitzi Daughters + Izma Daughters
	if(flags[kFLAGS.MITZI_DAUGHTERS] >= 4 && izmaScene.totalIzmaChildren() >= 2 && !player.hasStatusEffect(StatusEffects.MitziIzmaDaughters) && rand(5) == 0) {
		SceneLib.mitziFollower.MitziDaughtersIzmaDaughters();
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
	if(bimboSophie() && hasItemInStorage(consumables.OVIELIX) && rand(5) == 0 && flags[kFLAGS.TIMES_SOPHIE_HAS_DRUNK_OVI_ELIXIR] == 0 && player.gender > 0) {
		sophieBimbo.sophieEggApocalypse();
		hideMenus();
		return;
	}
	//Amily + Urta freakout!
	if(!SceneLib.urtaQuest.urtaBusy() && flags[kFLAGS.AMILY_VISITING_URTA] == 0 && rand(10) == 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00146] >= 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00147] == 0 && flags[kFLAGS.AMILY_NEED_TO_FREAK_ABOUT_URTA] == 1 && amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && !amilyScene.pregnancy.isPregnant) {
		finter.amilyUrtaReaction();
		hideMenus();
		return;
	}
	//Find jojo's note!
	if(flags[kFLAGS.JOJO_FIXED_STATUS] == 1 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0) {
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
	if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 && jojoScene.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER && jojoScene.pregnancy.incubation == 0) {
		joyScene.joyGivesBirth();
		return;
	}
	//Rathazul freaks out about jojo
	if(flags[kFLAGS.RATHAZUL_CORRUPT_JOJO_FREAKOUT] == 0 && rand(5) == 0 && player.hasStatusEffect(StatusEffects.CampRathazul) && campCorruptJojo()) {
		finter.rathazulFreaksOverJojo();
		hideMenus();
		return;
	}
	//Izma/Marble freakout - marble moves in
	if(flags[kFLAGS.IZMA_MARBLE_FREAKOUT_STATUS] == 1) {
		izmaScene.newMarbleMeetsIzma();
		hideMenus();
		return;
	}
	//Izma/Amily freakout - Amily moves in
	if(flags[kFLAGS.IZMA_AMILY_FREAKOUT_STATUS] == 1) {
		izmaScene.newAmilyMeetsIzma();
		hideMenus();
		return;
	}
	//Amily/Marble Freakout
	if(flags[kFLAGS.AMILY_NOT_FREAKED_OUT] == 0 && player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower() && marbleScene.marbleAtCamp()) {
		finter.marbleVsAmilyFreakout();
		hideMenus();
		return;
	}
	//Amily and/or Jojo freakout about Vapula!!
	if(vapulaSlave() && ((player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.KEPT_PURE_JOJO_OVER_VAPULA] <= 0) || (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt() && flags[kFLAGS.KEPT_PURE_AMILY_OVER_VAPULA] <= 0))) {
		//Jojo but not Amily (Must not be bimbo!)
		if((player.hasStatusEffect(StatusEffects.PureCampJojo)) && !(amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) && flags[kFLAGS.KEPT_PURE_JOJO_OVER_VAPULA] == 0)
			vapula.mouseWaifuFreakout(false,true);
		//Amily but not Jojo
		else if ((amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) && !player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.KEPT_PURE_AMILY_OVER_VAPULA] == 0) {
			vapula.mouseWaifuFreakout(true,false);
		}
		//Both
		else vapula.mouseWaifuFreakout(true,true);
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
	if(flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 2 && SceneLib.helScene.followerHel() && flags[kFLAGS.HEL_INTROS_LEVEL] == 0) {
		helFollower.helFollowersIntro();
		hideMenus();
		return;
	}
	//If you've gone through Hel's first time actions and Issy moves in without being okay with threesomes.
	if(flags[kFLAGS.HEL_INTROS_LEVEL] > 9000 && SceneLib.helScene.followerHel() && isabellaFollower() && flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] == 0) {
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
	if(player.hasStatusEffect(StatusEffects.SlimeCravingOutput)) player.removeStatusEffect(StatusEffects.SlimeCravingOutput);
	//Reset luststick display status (see event parser)
	flags[kFLAGS.PC_CURRENTLY_LUSTSTICK_AFFECTED] = 0;
	//Display Proper Buttons
	mainView.showMenuButton( MainView.MENU_APPEARANCE );
	mainView.showMenuButton( MainView.MENU_PERKS );
	mainView.showMenuButton( MainView.MENU_STATS );
	mainView.showMenuButton( MainView.MENU_DATA );
	showStats();
	//Change settings of new game buttons to go to main menu
	mainView.setMenuButton( MainView.MENU_NEW_MAIN, "Main Menu", CoC.instance.mainMenu.mainMenu );
	mainView.newGameButton.toolTipText = "Return to main menu.";
	mainView.newGameButton.toolTipHeader = "Main Menu";
	//clear up/down arrows
	hideUpDown();
	//Level junk
	if (setLevelButton(true)) return;
	//Build main menu
    var exploreEvent:Function = SceneLib.exploration.doExplore;
    var placesEvent:Function = (placesKnown() ? places : null);
	clearOutput();
	updateAchievements();
	
	outputText(images.showImage("camping"));
	//Isabella upgrades camp level!


	if(isabellaFollower()) {
		outputText("Your campsite got a lot more comfortable once Isabella moved in.  Carpets cover up much of the barren ground, simple awnings tied to the rocks provide shade, and hand-made wooden furniture provides comfortable places to sit and sleep.  ");
	}
	//Live in-ness
	else {
		if(model.time.days < 10) outputText("Your campsite is fairly simple at the moment.  Your tent and bedroll are set in front of the rocks that lead to the portal.  You have a small fire pit as well.  ");
		if(model.time.days >= 10 && model.time.days < 20) outputText("Your campsite is starting to get a very 'lived-in' look.  The fire-pit is well defined with some rocks you've arranged around it, and your bedroll and tent have been set up in the area most sheltered by rocks.  ");
		if(model.time.days >= 20) 
		{
			if (!isabellaFollower()) outputText("Your new home is as comfy as a camp site can be.  ");
			outputText("The fire-pit ");
			if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0) outputText("is ");
			else outputText("and tent are both ");
			outputText("set up perfectly, and in good repair.  ");
		}
	}
	if(model.time.days >= 20) outputText("You've even managed to carve some artwork into the rocks around the [camp]'s perimeter.\n\n");
	if(flags[kFLAGS.CAMP_CABIN_PROGRESS] == 7) outputText("There's an unfinished wooden structure. As of right now, it's just frames nailed together.\n\n");
	if(flags[kFLAGS.CAMP_CABIN_PROGRESS] == 8) outputText("There's an unfinished cabin. It's currently missing windows and door.\n\n");
	if(flags[kFLAGS.CAMP_CABIN_PROGRESS] == 9) outputText("There's a nearly-finished cabin. It looks complete from the outside but inside, it's missing flooring.\n\n");
	if(flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10) outputText("Your cabin is situated near the edge of [camp].\n\n");
	if(flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 0 || flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 1) outputText("In the middle of the distance between portal and [camp] edge is set place where you will store piles of wood or stones used for constructions. ");
	if(flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 3) outputText("In the middle of the distance between portal and [camp] edge is a medium sized wood platform, which you use to store wood and next to it is place for storing stones. ");
	if(flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4) outputText("In the middle of the distance between portal and [camp] edge is a long and wide wood platform with protective barriers at the three sided of it. Inside of it you could safely store large amounts of wood and stone. ");
	if(flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 1) outputText("There's a half finished warehouse construction near the east edge of your campsite.\n\n");
	if(flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 2) outputText("There's warehouse located in the east section of your campsite.\n\n");
	if(flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 3) outputText("There's warehouse and connected to it half finished granary construction located in the east section of your campsite.\n\n");
	if(flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 4) outputText("There's warehouse and connected to it granary located in the east section of your campsite.\n\n");
	if(flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 5) outputText("There's warehouse and second one warehouse half finished construction connected by granary located in the east section of your campsite.\n\n");
	if(flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 6) outputText("There's two warehouses and granary connecting them located in the east section of your campsite.\n\n");
	if(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) outputText("Some of your friends are currently sparring in the rings at the side of your [camp].\n\n");
	if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 1) {
		if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 8) outputText("Eight large arcane circles are");
		else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 7) outputText("Seven large arcane circles are");
		else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 6) outputText("Six large arcane circles are");
		else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 5) outputText("Five large arcane circles are");
		else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 4) outputText("Four large arcane circles are");
		else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 3) outputText("Three large arcane circles are");
		else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 2) outputText("Two large arcane circles are");
		else outputText("A large arcane circle is");
		outputText(" written at the edge of your [camp]. Its runes regularly glow with impulse of power.\n\n");
	}
	if (flags[kFLAGS.CAMP_UPGRADES_DAM] >= 1) {
		if (flags[kFLAGS.CAMP_UPGRADES_DAM] == 3) outputText("A big wooden dam increase the width of the nearby stream up to the point of creating very narrow miniature lake");
		else if (flags[kFLAGS.CAMP_UPGRADES_DAM] == 2) outputText("A woden dam help increase noticably the width of the nearby stream slowing the passage of water");
		else outputText("A small woden dam help increase the width of the nearby stream slowing the passage of water");
		outputText(".\n\n");
	}
	if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 1) {
		outputText("Not so far from it is your ");
		if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 1) outputText("small");
		if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 2) outputText("medium-sized");
		if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 3) outputText("big");
		if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 4) outputText("large");
		outputText(" fishery. You can see several barrel possibly full of freshly caught fish next to it.\n\n");
	}
	if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] >= 2 && flags[kFLAGS.CHRISTMAS_TREE_LEVEL] < 8) {
		if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 2) outputText("At the corner of camp where you planted a seed, sapling has grown. It has dozens of branches and bright green leaves.\n\n");
		else if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 3) outputText("At the corner of camp, the tree like sapling has grown bigger having grown more branches and leaves.\n\n");
		else if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 4) outputText("At the corner of camp, a small tree has grown. The bright green leaves gently sway with the blowing wind.\n\n");
		else outputText("At the corner of camp sits a rather large tree. It's leafy canopy sways with the wind and the thick trunk is covered in sturdy bark."+(flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 7 ? " The tree is covered in colorful ornaments and lights for the season.":"")+"\n\n");
	}
	//Nursery
	if(flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] == 100 && player.hasStatusEffect(StatusEffects.CampMarble)) {
		outputText("Marble has built a fairly secure nursery amongst the rocks to house your ");
		if(flags[kFLAGS.MARBLE_KIDS] == 0) outputText("future children");
		else {
			outputText(num2Text(flags[kFLAGS.MARBLE_KIDS]) + " child");
			if(flags[kFLAGS.MARBLE_KIDS] > 1) outputText("ren");
		}
		outputText(".\n\n");
	}
	//HARPY ROOKERY
	if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] > 0) {
		//Rookery Descriptions (Short)
		//Small (1 mature daughter)
		if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] == 1) {
			outputText("There's a smallish harpy nest that your daughter has built up with rocks piled high near the fringes of your [camp].  It's kind of pathetic, but she seems proud of her accomplishment.  ");
		}
		//Medium (2-3 mature daughters)
		else if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 3) {
			outputText("There's a growing pile of stones built up at the fringes of your [camp].  It's big enough to be considered a small hill by this point, dotted with a couple small harpy nests just barely big enough for two.  ");
		}
		//Big (4 mature daughters)
		else if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 4) {
			outputText("The harpy rookery at the edge of [camp] has gotten pretty big.  It's taller than most of the standing stones that surround the portal, and there's more nests than harpies at this point.  Every now and then you see the four of them managing a boulder they dragged in from somewhere to add to it.  ");
		}
		//Large (5-10 mature daughters)
		else if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 10) {
			outputText("The rookery has gotten quite large.  It stands nearly two stories tall at this point, dotted with nests and hollowed out places in the center.  It's surrounded by the many feathers the assembled harpies leave behind.  ");
		}
		//Giant (11-20 mature daughters)
		else if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 20) {
			outputText("A towering harpy rookery has risen up at the fringes of your [camp], filled with all of your harpy brood.  It's at least three stories tall at this point, and it has actually begun to resemble a secure structure.  These harpies are always rebuilding and adding onto it.  ");
		}
		//Massive (21-50 mature daughters)
		else if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 50) {
			outputText("A massive harpy rookery towers over the edges of your [camp].  It's almost entirely built out of stones that are fit seamlessly into each other, with many ledges and overhangs for nests.  There's a constant hum of activity over there day or night.  ");
		}
		//Immense (51+ Mature daughters)
		else {
			outputText("An immense harpy rookery dominates the edge of your [camp], towering over the rest of it.  Innumerable harpies flit around it, always working on it, assisted from below by the few sisters unlucky enough to be flightless.  ");
		}
		outputText("\n\n");
	}
	//Traps
	if(player.hasStatusEffect(StatusEffects.DefenseCanopy)) {
		outputText("A thorny tree has sprouted near the center of the [camp], growing a protective canopy of spiky vines around the portal and your [camp].  ");
	}
	if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 10 && flags[kFLAGS.CAMP_WALL_PROGRESS] < 100) {
		if (flags[kFLAGS.CAMP_WALL_PROGRESS] / 10 == 1) outputText("A thick wooden wall has been erected to provide a small amount of defense.  ");
		else outputText("Thick wooden walls have been erected to provide some defense.  ");
		if (flags[kFLAGS.CAMP_WALL_SKULLS] == 1) outputText("A single imp skull has been mounted on the wall segments");
			else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 2 && flags[kFLAGS.CAMP_WALL_SKULLS] < 5) outputText("Few imp skulls have been mounted on the wall segments");
			else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 5 && flags[kFLAGS.CAMP_WALL_SKULLS] < 15) outputText("Several imp skulls have been mounted on the wall segments");
			else outputText("Many imp skulls decorate the wall, some even impaled on wooden spikes");
			outputText(" to serve as deterrence.  ");
			if (flags[kFLAGS.CAMP_WALL_SKULLS] == 1) outputText("There is currently one skull.  ");
			else outputText("There are currently " + num2Text(flags[kFLAGS.CAMP_WALL_SKULLS]) + " skulls.  ");
	}
	else if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100) {
		outputText("Thick wooden walls have been erected; they surround one half of your [camp] perimeter and provide good defense, leaving the another half open for access to the stream.  ");
		if (flags[kFLAGS.CAMP_WALL_GATE] > 0) outputText("A gate has been constructed in the middle of the walls; it gets closed at night to keep any invaders out.  ");
		if (flags[kFLAGS.CAMP_WALL_SKULLS] > 0) {
			if (flags[kFLAGS.CAMP_WALL_SKULLS] == 1) outputText("A single imp skull has been mounted near the gateway");
			else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 2 && flags[kFLAGS.CAMP_WALL_SKULLS] < 5) outputText("Few imp skulls have been mounted near the gateway");
			else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 5 && flags[kFLAGS.CAMP_WALL_SKULLS] < 15) outputText("Several imp skulls have been mounted near the gateway");
			else outputText("Many imp skulls decorate the gateway and wall, some even impaled on wooden spikes");
			outputText(" to serve as deterrence.  ");
			if (flags[kFLAGS.CAMP_WALL_SKULLS] == 1) outputText("There is currently one skull.  ");
			else outputText("There are currently " + num2Text(flags[kFLAGS.CAMP_WALL_SKULLS]) + " skulls.  ");
		}
		outputText("\n\n");
	}
	//Magic Ward
	if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] >= 2) {
		if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100) outputText("Just within the wall are the");
		else outputText("Right before the ring of traps are your");
		outputText(" warding stones. They are ");
		if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 2) outputText("currently inactive.");
		if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 3)  outputText("glowing with power, protecting your [camp] from intruders.");
		outputText("\n\n");
	}
	else outputText("You have a number of traps surrounding your makeshift home, but they are fairly simple and may not do much to deter a demon.  ");
	outputText("The portal shimmers in the background as it always does, looking menacing and reminding you of why you came.");
	if (flags[kFLAGS.ANT_KIDS] > 1000) outputText(" Really close to it there is a small entrance to the underground maze created by your ant children. And due to Phylla wish from time to time one of your children coming out this entrance to check on the situation near portal. You feel a little more safe now knowing that it will be harder for anyone to go near the portal without been noticed or...if someone came out of the portal.");
	outputText("\n\n");
	if(flags[kFLAGS.CLARA_IMPRISONED] > 0) {
		marblePurification.claraCampAddition();
	}
	//Ember's anti-minotaur crusade!
	if(flags[kFLAGS.EMBER_CURRENTLY_FREAKING_ABOUT_MINOCUM] == 1) {
		//Modified Camp Description
		outputText("Since Ember began " + emberMF("his","her") + " 'crusade' against the minotaur population, skulls have begun to pile up on either side of the entrance to " + emberScene.emberMF("his","her") + " den.  There're quite a lot of them.\n\n");
	}
	//Dat tree!
	if(flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0) {
		outputText("On the outer edges, half-hidden behind a rock, is a large, very healthy tree.  It grew fairly fast, but seems to be fully developed now.  Holli, Marae's corrupt spawn, lives within.\n\n");
	}
	if(flags[kFLAGS.FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0) {
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
	if(amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1) {
		if(flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0) outputText("Amily has relocated her grass bedding to the opposite side of the [camp] from the strange tree; every now and then, she gives it a suspicious glance, as if deciding whether to move even further.\n\n");
		else outputText("A surprisingly tidy nest of soft grasses and sweet-smelling herbs has been built close to your " + (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 ? "cabin": "bedroll") + ". A much-patched blanket draped neatly over the top is further proof that Amily sleeps here. She changes the bedding every few days, to ensure it stays as nice as possible.\n\n");
	}
	
	campLoversMenu(true);
	
	campSlavesMenu(true);

	//Hunger check!
	if (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger < 25)
	{
		outputText("<b>You have to eat something; your stomach is growling " + (player.hunger < 1 ? "painfully": "loudly") + ". </b>");
		if (player.hunger < 10) {
			outputText("<b>You are getting thinner and you're losing muscles. </b>");
		}
		if (player.hunger <= 0) {
			outputText("<b>You are getting weaker due to starvation. </b>");
		}
		outputText("\n\n");
	}
	
	//The uber horny
	if(player.lust >= player.maxLust()) {
		if(player.hasStatusEffect(StatusEffects.Dysfunction)) {
			outputText("<b>You are debilitatingly aroused, but your sexual organs are so numbed the only way to get off would be to find something tight to fuck or get fucked...</b>\n\n");
		}
		else if(flags[kFLAGS.UNABLE_TO_MASTURBATE_BECAUSE_CENTAUR] > 0 && player.isTaur()) {
			outputText("<b>You are delibitatingly aroused, but your sex organs are so difficult to reach that masturbation isn't at the forefront of your mind.</b>\n\n");
		}
		else {
			outputText("<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>\n\n");
			exploreEvent = null;
			placesEvent = null;
			//This once disabled the ability to rest, sleep or wait, but ir hasn't done that for many many builds
		}
	}
	//Set up rest stuff
	//Night
	if(model.time.hours < 6 || model.time.hours > 20) {
		if (flags[kFLAGS.D3_GARDENER_DEFEATED] <= 0 && flags[kFLAGS.D3_CENTAUR_DEFEATED] <= 0 && flags[kFLAGS.D3_STATUE_DEFEATED] <= 0) outputText("It is dark out, made worse by the lack of stars in the sky.  A blood-red moon hangs in the sky, seeming to watch you, but providing little light.  It's far too dark to leave [camp].\n\n");
		else outputText("It is dark out. Stars dot the night sky. A blood-red moon hangs in the sky, seeming to watch you, but providing little light.  It's far too dark to leave [camp].\n\n");
		if (companionsCount() > 0 && !(model.time.hours > 4 && model.time.hours < 23)) {
			outputText("Your [camp] is silent as your companions are sleeping right now.\n");
		}
		exploreEvent = null;
		placesEvent = null;
	}
	//Day Time!
	else {
		if (model.time.hours == 19) outputText("The sun is close to the horizon, getting ready to set. ");
		if (model.time.hours == 20) outputText("The sun has already set below the horizon. The sky glows orange. ");
		outputText("It's light outside, a good time to explore and forage for supplies with which to fortify your [camp].\n");
	}
	
	//Unlock cabin.
	if (flags[kFLAGS.CAMP_CABIN_PROGRESS] <= 0 && model.time.days >= 7)
	{
		flags[kFLAGS.CAMP_CABIN_PROGRESS] = 1;
		clearOutput();
		outputText("You realize that you have spent week sleeping in tent every night. You think of something so you can sleep nicely and comfortably. Perhaps a cabin will suffice?");
		doNext(playerMenu);
		return;
	}
	//Unlock something in character creation.
	if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] == 0)
	{
		if (player.gender == Gender.GENDER_HERM)
		{
			flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] = 1;
			outputText("\n\n<b>Congratulations! You have unlocked hermaphrodite option on character creation, accessible from New Game Plus!</b>");
			CoC.instance.saves.savePermObject(false);
		}
	}
	//Unlock hot spring.
	if (loversHotBathCount() > 1)
	{
		if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] < 1) flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] = 1;
	}
	//Unlock sparring ring.
	if (sparableCampMembersCount() >= 2)
	{
		if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 1) flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] = 1;
	}
	
	//Menu
	
	menu();
	addButton(0, "Explore", exploreEvent).hint("Explore to find new regions and visit any discovered regions.");
	addButton(1, "Places", placesEvent).hint("Visit any places you have discovered so far.");
	addButton(2, "Inventory", inventory.inventoryMenu).hint("The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
	if (inventory.showStash()) addButton(3, "Stash", inventory.stash).hint("The stash allows you to store your items safely until you need them later.");
	if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 2) addButton(4, "Warehouse", inventory.warehouse).hint("The warehouse and granary allows you to store your items in larger amounts and more organized way than stash before.");
	if (followersCount() > 0) addButton(5, "Followers", campFollowers).hint("Check up on any followers or companions who are joining you in or around your [camp].  You'll probably just end up sleeping with them.");
	if (loversCount() > 0) addButton(6, "Lovers", campLoversMenu).hint("Check up on any lovers you have invited so far to your [camp] and interact with them.");
	if (slavesCount() > 0) addButton(7, "Slaves", campSlavesMenu).hint("Check up on any slaves you have received and interact with them.");
	addButton(8, "Camp Actions", campActions).hint("Interact with the [camp] surroundings and also read your codex or questlog.");
	if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10 || flags[kFLAGS.CAMP_BUILT_CABIN] >= 1) addButton(9, "Enter Cabin", cabinProgress.initiateCabin).hint("Enter your cabin."); //Enter cabin for furnish.
	if (player.hasPerk(PerkLib.JobSoulCultivator) || debug) addButton(10, "Soulforce", soulforce.accessSoulforceMenu).hint("Spend some time on the cultivation or spend some of the soulforce.");
	else if (!player.hasPerk(PerkLib.JobSoulCultivator) && player.hasPerk(PerkLib.Metamorph)) addButton(10, "Metamorf", SceneLib.metamorph.accessMetamorphMenu).hint("Use your soulforce to mold freely your body.");
	var canFap:Boolean = !player.hasStatusEffect(StatusEffects.Dysfunction) && (flags[kFLAGS.UNABLE_TO_MASTURBATE_BECAUSE_CENTAUR] == 0 && !player.isTaur());
	if (player.lust >= 30) {
		addButton(11, "Masturbate", SceneLib.masturbation.masturbateMenu);
		if ((((player.findPerk(PerkLib.HistoryReligious) >= 0 || player.findPerk(PerkLib.PastLifeReligious) >= 0) && player.cor <= 66) || (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < 10)) && !(player.hasStatusEffect(StatusEffects.Exgartuan) && player.statusEffectv2(StatusEffects.Exgartuan) == 0) || flags[kFLAGS.SFW_MODE] >= 1) addButton(11, "Meditate", SceneLib.masturbation.masturbateMenu);
	}
	addButton(12, "Wait", doWaitMenu).hint("Wait for one to eigth hours. Or until the night comes.");
	if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(12, "Rest", restMenu).hint("Rest for one to eight hours. Or until fully healed / night comes.");
	if (model.time.hours >= 21 || model.time.hours < 6) addButton(12, "Sleep", doSleep).hint("Turn yourself in for the night.");
//	if (flags[kFLAGS.EVANGELINE_FOLLOWER] >= 1 && player.findPerk(PerkLib.EzekielBlessing) < 0) addButton(13, "Remov. Curse", EzekielCurseQuickFix).hint("Quick fix for Ezekiel curse when ezekiel fruit was lost.");

	//Remove buttons according to conditions.
	if (model.time.hours >= 21 || model.time.hours < 6) {
		removeButton(0); //Explore
		removeButton(1); //Places
		if (model.time.hours >= 23 || model.time.hours < 5) {
			removeButton(5); //Followers
			removeButton(6); //Lovers
			removeButton(7); //Slaves
			removeButton(8); //Camp Actions
		}
	}
	if (player.lust >= player.maxLust() && canFap) {
		removeButton(0); //Explore
		removeButton(1); //Places
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
		promptSaveUpdate();
		return;
	}
	//Massive Balls Bad End (Realistic Mode only)
	if (flags[kFLAGS.HUNGER_ENABLED] >= 1 && player.ballSize > (18 + (player.str / 2) + (player.tallness / 4))) {
		badEndGIANTBALLZ();
		return;
	}
	//Hunger Bad End
	if (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger <= 0)
	{
		//Bad end at 0 HP!
		if (player.HP <= 0 && (player.str + player.tou) < 30)
		{
			badEndHunger();
			return;
		}
	}
	//Min Lust Bad End (Must not have any removable/temporary min lust.)
	if (player.minLust() >= player.maxLust() && !flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= 168 && !player.eggs() >= 20 && !player.hasStatusEffect(StatusEffects.BimboChampagne) && !player.hasStatusEffect(StatusEffects.Luststick) && player.jewelryEffectId != 1)
	{
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
	if (flags[kFLAGS.EVANGELINE_FOLLOWER] >= 1) counter++;
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
	if (flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2) counter++;
    if (flags[kFLAGS.SIDONIE_FOLLOWER] >= 1) counter++;
    if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) counter++;
	if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 0) counter++;
	for each (var npc:XXCNPC in _campFollowers){
        if(npc.isCompanion(XXCNPC.FOLLOWER)){counter++;}
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
    for each (var npc:XXCNPC in _campFollowers){
        if(npc.isCompanion(XXCNPC.SLAVE)){counter++;}
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
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5) counter++;
	if (flags[kFLAGS.CEANI_FOLLOWER] > 0) counter++;
	if (flags[kFLAGS.DIANA_FOLLOWER] > 5 && !player.hasStatusEffect(StatusEffects.DianaOff)) counter++;
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
	for each (var npc:XXCNPC in _campFollowers){
        if(npc.isCompanion(XXCNPC.LOVER)){counter++;}
    }
	return counter;
}

public function loversHotBathCount():Number {
	var counter:Number = 0;
	if (flags[kFLAGS.ALVINA_FOLLOWER] > 12) counter++;
	if (emberScene.followerEmber()) counter++;
	if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) counter++;
	if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) counter++;
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5) counter++;
	if (flags[kFLAGS.CEANI_FOLLOWER] > 0) counter++;
	if (flags[kFLAGS.DIANA_FOLLOWER] > 5 && !player.hasStatusEffect(StatusEffects.DianaOff)) counter++;
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
	if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] < 3) counter++;
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
	if (flags[kFLAGS.EVANGELINE_FOLLOWER] >= 1) counter++;
	if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) counter++;
	if (flags[kFLAGS.DINAH_LVL_UP] >= 1) counter++;
	//if (flags[kFLAGS.GALIA_LVL_UP] >= 1) counter++;
	if (flags[kFLAGS.NEISA_FOLLOWER] >= 7) counter++;
	if (helspawnFollower()) counter++;
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5) counter++;
	if (flags[kFLAGS.CEANI_FOLLOWER] > 0) counter++;
	if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) counter++;
	if (flags[kFLAGS.LUNA_FOLLOWER] > 10 && !player.hasStatusEffect(StatusEffects.LunaOff)) counter++;
	if (followerHel()) counter++;
	if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) counter++;
	if (followerKiha()) counter++;
	return counter;
}

//-----------------
//-- COMPANIONS 
//-----------------
public function campLoversMenu(descOnly:Boolean = false):void {
	var buttons:ButtonDataList = new ButtonDataList();
	if (!descOnly) {
		hideMenus();
		spriteSelect(-1);
		clearOutput();
        CoC.instance.inCombat = false;
        menu();
	}
	if (isAprilFools() && flags[kFLAGS.DLC_APRIL_FOOLS] == 0 && !descOnly) {
        Holidays.DLCPrompt("Lovers DLC", "Get the Lovers DLC to be able to interact with them and have sex! Start families! The possibilities are endless!", "$4.99", doCamp);
        return;
	}
	//Alvina
	if (flags[kFLAGS.ALVINA_FOLLOWER] > 19) {
		outputText("Alvina isn’t so far from here, having made her [camp] in a corrupted plant groove she created so to have easy access to reagents.\n\n");
		buttons.add( "Alvina", SceneLib.alvinaFollower.alvinaMainCampMenu).hint("Check up on Alvina.");
	}
	//AMILY
	if(amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0 && !descOnly) {
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
		buttons.add("Amily", amilyScene.amilyFollowerEncounter2).disableIf(player.statusEffectv1(StatusEffects.CampLunaMishaps1) > 0,"Hurt foot.");
	}
	//Amily out freaking Urta?
	else if(flags[kFLAGS.AMILY_VISITING_URTA] == 1 || flags[kFLAGS.AMILY_VISITING_URTA] == 2) {
		outputText("Amily's bed of grass and herbs lies empty, the mouse-woman still absent from her sojourn to meet your other lover.\n\n");
	}
	//Arian
	if (arianScene.arianFollower()) {
		outputText("Arian's tent is here, if you'd like to go inside.\n\n");
		buttons.add( "Arian", arianScene.visitAriansHouse);
	}
	//Cai'Lin
//	buttons.add("???").disable("Look into my eyes and answer me: Am I beautiful?");
	//Ceani
	if (flags[kFLAGS.CEANI_FOLLOWER] > 0) {
		outputText("Ceani is lazily sunbathing at the other side of the [camp].\n\n");
		buttons.add("Ceani", SceneLib.ceaniScene.ceaniCampMainMenu).disableIf(player.statusEffectv3(StatusEffects.CampSparingNpcsTimers2) > 0,"Training.");
	}
	//Chi Chi
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5) {
		outputText("You can see Chi Chi not so far from Jojo. She’s busy practicing her many combos on a dummy. Said dummy will more than likely have to be replaced within twenty four hours.\n\n");
		if (player.statusEffectv4(StatusEffects.CampLunaMishaps2) > 0) buttons.add( "Chi Chi", SceneLib.chichiScene.ChiChiCampMainMenu2).disableIf(player.statusEffectv4(StatusEffects.CampLunaMishaps2) > 0,"Wet.");
		else buttons.add( "Chi Chi", SceneLib.chichiScene.ChiChiCampMainMenu2).disableIf(player.statusEffectv2(StatusEffects.CampSparingNpcsTimers2) > 0,"Training.");
	}
	//Diana
	if (flags[kFLAGS.DIANA_FOLLOWER] > 5 && !player.hasStatusEffect(StatusEffects.DianaOff)) {
		outputText("Diana is resting next to her many medical tools and medicines.\n\n");
		buttons.add("Diana", SceneLib.dianaScene.mainCampMenu).disableIf(player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) > 0,"Training.");
	}
	//Electra
	if (flags[kFLAGS.ELECTRA_FOLLOWER] > 1 && !player.hasStatusEffect(StatusEffects.ElectraOff)) {
		outputText("Electra is quietly resting in the grass. Occasional static jolts zap nearby bugs that gets too close.\n\n");
		buttons.add("Electra", SceneLib.electraScene.ElectraCampMainMenu).disableIf(player.statusEffectv3(StatusEffects.CampSparingNpcsTimers4) > 0,"Training.");
	}
	//Etna
	if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) {
		outputText("Etna is resting lazily on a rug in a very cat-like manner. She’s looking at you always with this adorable expression of hers, her tail wagging expectantly at your approach.\n\n");
		if (player.statusEffectv1(StatusEffects.CampLunaMishaps2) > 0) buttons.add( "Etna", SceneLib.etnaScene.etnaCampMenu2).disableIf(player.statusEffectv1(StatusEffects.CampLunaMishaps2) > 0,"Sleeping.");
		else buttons.add( "Etna", SceneLib.etnaScene.etnaCampMenu2).disableIf(player.statusEffectv4(StatusEffects.CampSparingNpcsTimers1) > 0,"Training.");
	}
	//Excellia Lover
	if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) {
		outputText("Excellia seems to be working on her combat skills against a training dummy. "+(SceneLib.excelliaFollower.totalExcelliaChildren() > 1 ? "She shows her children a few fighting techniques as they watch her attentively. Some even practice them with friendly spars between one another. ":"")+"When she notices you, she gives a friendly nod before going back to pummeling the dummy.\n\n");
		buttons.add( "Excellia", SceneLib.excelliaFollower.ExcelliaCampMainMenuFixHer).hint("Visit Excellia.");
	}
	//Helia
	if(SceneLib.helScene.followerHel()) {
		if(flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 2) {
			//Hel @ Camp: Follower Menu
			//(6-7) 
			if(model.time.hours <= 7) outputText("Hel is currently sitting at the edge of [camp], surrounded by her scraps of armor, sword, and a few half-empty bottles of vodka.  By the way she's grunting and growling, it looks like she's getting ready to flip her shit and go running off into the plains in her berserker state.\n\n");
			//(8a-5p) 
			else if(model.time.hours <= 17) outputText("Hel's out of [camp] at the moment, adventuring on the plains.  You're sure she'd be on hand in moments if you needed her, though.\n\n");
			//5-7) 
			else if(model.time.hours <= 19) outputText("Hel's out visiting her family in Tel'Adre right now, though you're sure she's only moments away if you need her.\n\n");
			//(7+)
			else outputText("Hel is fussing around her hammock, checking her gear and sharpening her collection of blades.  Each time you glance her way, though, the salamander puts a little extra sway in her hips and her tail wags happily.\n\n");
		}
		else if(flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 1) {
			if(flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] == 1) {
				outputText("Hel has returned to [camp], though for now she looks a bit bored.  Perhaps she is waiting on something.\n\n");
			}
			else {
				outputText("<b>You see the salamander Helia pacing around [camp], anxiously awaiting your departure to the harpy roost. Seeing you looking her way, she perks up, obviously ready to get underway.</b>\n\n");
			}
		}
		buttons.add( "Helia", helFollower.heliaFollowerMenu2).disableIf(player.statusEffectv3(StatusEffects.CampLunaMishaps2) > 0,"Sleeping.");
	}
	//Isabella
	if(isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) {
		if(model.time.hours >= 21 || model.time.hours <= 5) outputText("Isabella is sound asleep in her bunk and quietly snoring.");
		else if(model.time.hours == 6) outputText("Isabella is busy eating some kind of grain-based snack for breakfast.  The curly-haired cow-girl gives you a smile when she sees you look her way.");
		else if(model.time.hours == 7) outputText("Isabella, the red-headed cow-girl, is busy with a needle and thread, fixing up some of her clothes.");
		else if(model.time.hours == 8) outputText("Isabella is busy cleaning up the [camp], but when she notices you looking her way, she stretches up and arches her back, pressing eight bullet-hard nipples into the sheer silk top she prefers to wear.");
		else if(model.time.hours == 9) outputText("Isabella is out near the fringes of your campsite.  She has her massive shield in one hand and appears to be keeping a sharp eye out for intruders or demons.  When she sees you looking her way, she gives you a wave.");
		else if(model.time.hours == 10) outputText("The cow-girl warrioress, Isabella, is sitting down on a chair and counting out gems from a strange pouch.  She must have defeated someone or something recently.");
		else if(model.time.hours == 11) outputText("Isabella is sipping from a bottle labelled 'Lactaid' in a shaded corner.  When she sees you looking she blushes, though dark spots appear on her top and in her skirt's middle.");
		else if(model.time.hours == 12) outputText("Isabella is cooking a slab of meat over the fire.  From the smell that's wafting this way, you think it's beef.  Idly, you wonder if she realizes just how much like her chosen food animal she has become.");
		else if(model.time.hours == 13) {
			outputText("Isabella ");
			var izzyCreeps:Array = [];
			//Build array of choices for izzy to talk to
			if(player.hasStatusEffect(StatusEffects.CampRathazul))
				izzyCreeps[izzyCreeps.length] = 0;
			if(player.hasStatusEffect(StatusEffects.PureCampJojo))
				izzyCreeps[izzyCreeps.length] = 1;
			if(amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0)
				izzyCreeps[izzyCreeps.length] = 2;
			if(amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 2 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0)
				izzyCreeps[izzyCreeps.length] = 3;
			if(flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0)
				izzyCreeps[izzyCreeps.length] = 4;
			//Base choice - book
			izzyCreeps[izzyCreeps.length] = 5;
			//Select!
			var choice:int = rand(izzyCreeps.length);
				
			if(izzyCreeps[choice] == 0) outputText("is sitting down with Rathazul, chatting amiably about the weather.");
			else if(izzyCreeps[choice] == 1) outputText("is sitting down with Jojo, smiling knowingly as the mouse struggles to keep his eyes on her face.");
			else if(izzyCreeps[choice] == 2) outputText("is talking with Amily, sharing stories of the fights she's been in and the enemies she's faced down.  Amily seems interested but unimpressed.");
			else if(izzyCreeps[choice] == 3) outputText("is sitting down chatting with Amily, but the corrupt mousette is just staring at Isabella's boobs and masturbating.  The cow-girl is pretending not to notice.");
			else if(izzyCreeps[choice] == 4) outputText("is sitting down with Izma and recounting some stories, somewhat nervously.  Izma keeps flashing her teeth in a predatory smile.");
			else outputText("is sitting down and thumbing through a book.");
		}
		else if(model.time.hours == 14) outputText("Isabella is working a grindstone and sharpening her tools.  She even hones the bottom edge of her shield into a razor-sharp cutting edge.  The cow-girl is sweating heavily, but it only makes the diaphanous silk of her top cling more alluringly to her weighty chest.");
		else if(model.time.hours == 15) outputText("The warrior-woman, Isabella is busy constructing dummies of wood and straw, then destroying them with vicious blows from her shield.  Most of the time she finishes by decapitating them with the sharp, bottom edge of her weapon.  She flashes a smile your way when she sees you.");
		else if(model.time.hours == 16) outputText("Isabella is sitting down with a knife, the blade flashing in the sun as wood shavings fall to the ground.  Her hands move with mechanical, practiced rhythm as she carves a few hunks of shapeless old wood into tools or art.");
		else if(model.time.hours == 17) outputText("Isabella is sitting against one of the large rocks near the outskirts of your [camp], staring across the wasteland while idly munching on what you assume to be a leg of lamb.  She seems lost in thought, though that doesn't stop her from throwing a wink and a goofy food-filled grin toward you.");
		else if(model.time.hours == 18) outputText("The dark-skinned cow-girl, Isabella, is sprawled out on a carpet and stretching.  She seems surprisingly flexible for someone with hooves and oddly-jointed lower legs.");
		else if(model.time.hours == 19) {
			//[(Izzy Milked Yet flag = -1)
			if(flags[kFLAGS.ISABELLA_MILKED_YET] == -1) outputText("Isabella has just returned from a late visit to Whitney's farm, bearing a few filled bottles and a small pouch of gems.");
			else outputText("Isabella was hidden behind a rock when you started looking for her, but as soon as you spot her in the darkness, she jumps, a guilty look flashing across her features.  She turns around and adjusts her top before looking back your way, her dusky skin even darker from a blush.  The cow-girl gives you a smile and walks back to her part of [camp].  A patch of white decorates the ground where she was standing - is that milk?  Whatever it is, it's gone almost as fast as you see it, devoured by the parched, wasteland earth.");
		}
		else if(model.time.hours == 20) outputText("Your favorite chocolate-colored cowgirl, Isabella, is moving about, gathering all of her scattered belongings and replacing them in her personal chest.  She yawns more than once, indicating her readiness to hit the hay, but her occasional glance your way lets you know she wouldn't mind some company before bed.");
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
		buttons.add( "Isabella", isabellaFollowerScene.callForFollowerIsabella).disableIf(player.statusEffectv2(StatusEffects.CampSparingNpcsTimers1) > 0,"Training.");
	}
	//Izma
	if(izmaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
		if (flags[kFLAGS.IZMA_BROFIED] > 0) {
			if (rand(6) == 0 && camp.vapulaSlave() && flags[kFLAGS.VAPULA_HAREM_FUCK] > 0) outputText("Izmael is standing a short distance away with an expression of unadulterated joy on his face, Vapula knelt in front of him and fellating him with noisy enthusiasm.  The shark morph dreamily opens his eyes to catch you staring, and proceeds to give you a huge grin and two solid thumbs up.");
			else if (model.time.hours >= 6 && model.time.hours <= 12) outputText("You keep hearing the sound of objects hitting water followed by peals of male laughter coming from the stream. It sounds as if Izmael is throwing large rocks into the stream and finding immense gratification from the results. In fact, you’re pretty sure that’s exactly what he’s doing.");
			else if (model.time.hours <= 16) outputText("Izmael is a short distance away doing squat thrusts, his body working like a piston, gleaming with sweat. He keeps bobbing his head up to see if anybody is watching him.");
			else if (model.time.hours <= 19) outputText("Izmael is sat against his book chest, masturbating furiously without a care in the world. Eyes closed, both hands pumping his immense shaft, there is an expression of pure, childish joy on his face.");
			else if (model.time.hours <= 22) outputText("Izmael has built a fire and is flopped down next to it. You can’t help but notice that he’s used several of his books for kindling. His eyes are locked on the flames, mesmerized by the dancing light and heat.");
			else outputText("Izmael is currently on his bedroll, sleeping for the night.");
			outputText("\n\n");
			buttons.add( "Izmael", izmaScene.izmaelScene.izmaelMenu);
		}
		else {
			outputText("Neatly laid near the base of your own is a worn bedroll belonging to Izma, your tigershark lover. It's a snug fit for her toned body, though it has some noticeable cuts and tears in the fabric. Close to her bed is her old trunk, almost as if she wants to have it at arms length if anyone tries to rob her in her sleep.\n\n");
			switch(rand(3)) {
				case 0: outputText("Izma's lazily sitting on the trunk beside her bedroll, reading one of the many books from inside it. She smiles happily when your eyes linger on her, and you know full well she's only half-interested in it."); break;
				case 1: outputText("You notice Izma isn't around right now. She's probably gone off to the nearby stream to get some water. Never mind, she comes around from behind a rock, still dripping wet."); break;
				case 2: outputText("Izma is lying on her back near her bedroll. You wonder at first just why she isn't using her bed, but as you look closer you notice all the water pooled beneath her and the few droplets running down her arm, evidence that she's just returned from the stream."); break;
			}
			outputText("\n\n");
			buttons.add( "Izma", izmaScene.izmaFollowerMenu2).disableIf(player.statusEffectv4(StatusEffects.CampLunaMishaps1) > 0,"Fish smell.");
		}
	}
	//Kiha!
	if(followerKiha()) {
		//(6-7) 
		if(model.time.hours < 7) outputText("Kiha is sitting near the fire, her axe laying across her knees as she polishes it.\n\n");
		else if (model.time.hours < 19) {
			if (kihaFollower.totalKihaChildren() > 0 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] > 160 && (flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] % 3 == 0 || model.time.hours == 17)) outputText("Kiha is breastfeeding her offspring right now.\n\n");
			else if (kihaFollower.totalKihaChildren() > 0 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] > 80 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] <= 160 && (flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] % 7 == 0 || model.time.hours == 17)) outputText("Kiha is telling stories to her draconic child" + (kihaFollower.totalKihaChildren() == 1 ? "" : "ren") + " right now.\n\n");
			else outputText("Kiha's out right now, likely patrolling for demons to exterminate.  You're sure a loud call could get her attention.\n\n");
		}
		else {
			if (kihaFollower.totalKihaChildren() > 0 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] > 160 && (flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] % 3 == 0 || model.time.hours == 20)) outputText("Kiha is breastfeeding her offspring right now.\n\n");
			else if (kihaFollower.totalKihaChildren() > 0 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] > 80 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] <= 160 && (flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] % 7 == 0 || model.time.hours == 20)) outputText("Kiha is telling stories to her draconic child" + (kihaFollower.totalKihaChildren() == 1 ? "" : "ren") + " right now.\n\n");
			else if (kihaFollower.totalKihaChildren() > 0 && flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] <= 80 && (flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] % 3 == 0 || model.time.hours == 20)) {
				outputText("Kiha is training her " + (kihaFollower.totalKihaChildren() == 1 ? "child to become a strong warrior" : "children to become strong warriors") + ". ");
				if (rand(2) == 0) outputText("Right now, she's teaching various techniques.");
				else outputText("Right now, she's teaching her child" + (kihaFollower.totalKihaChildren() == 1 ? "" : "ren") + " how to make use of axes.\n\n");
			}
			else {
				outputText("Kiha is utterly decimating a set of practice dummies she's set up out on the edge of [camp].  All of them have crudely drawn horns. ");
				if (kihaFollower.totalKihaChildren() > 0 && (kihaFollower.totalKihaChildren() >= 2 || flags[kFLAGS.KIHA_CHILD_MATURITY_COUNTER] <= 60)) outputText("Some of them are saved for her child" + (kihaFollower.totalKihaChildren() == 1 ? "" : "ren") + " to train on. ");
				outputText("Most of them are on fire.\n\n");
			}
		}
		if (player.statusEffectv3(StatusEffects.CampLunaMishaps1) > 0) buttons.add( "Kiha", kihaScene.encounterKiha2).disableIf(player.statusEffectv3(StatusEffects.CampLunaMishaps1) > 0,"Cleaning burnt meat.");
		else buttons.add( "Kiha", kihaScene.encounterKiha2).disableIf(player.statusEffectv3(StatusEffects.CampSparingNpcsTimers1) > 0,"Training.");
	}
	//MARBLE
	if(player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) {
		outputText("A second bedroll rests next to yours; a large two handed hammer sometimes rests against it, depending on whether or not its owner needs it at the time.  ");
		//Normal Murbles
		if(flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 4) outputText("Marble isn’t here right now; she’s still off to see her family.");
		//requires at least 1 kid, time is just before sunset, this scene always happens at this time if the PC has at least one kid.
		else if(flags[kFLAGS.MARBLE_KIDS] >= 1 && (model.time.hours == 19 || model.time.hours == 20)) {
			outputText("Marble herself is currently in the nursery, putting your ");
			if(flags[kFLAGS.MARBLE_KIDS] == 1) outputText("child");
			else outputText("children");
			outputText(" to bed.");
		}
		//at 6-7 in the morning, scene always displays at this time
		else if(model.time.hours == 6 || model.time.hours == 7) outputText("Marble is off in an open area to the side of your [camp] right now.  She is practicing with her large hammer, going through her daily training.");
		//after nightfall, scene always displays at this time unless PC is wormed
		else if(model.time.hours >= 21 && !player.hasStatusEffect(StatusEffects.Infested)) {
			outputText("Marble is hanging around her bedroll waiting for you to come to bed.  However, sometimes she lies down for a bit, and sometimes she paces next to it.");
			if(flags[kFLAGS.MARBLE_LUST] > 30) outputText("  She seems to be feeling antsy.");
		}
		else if(flags[kFLAGS.MARBLE_KIDS] > 0 && model.time.hours < 19 && model.time.hours > 7) {
			//requires at least 6 kids, and no other parental characters in camp
			if(rand(2) == 0 && flags[kFLAGS.MARBLE_KIDS] > 5) outputText("Marble is currently tending to your kids, but she looks a bit stressed out right now.  It looks like " + num2Text(flags[kFLAGS.MARBLE_KIDS]) + " might just be too many for her to handle on her own...");
			//requires at least 4 kids
			else if(rand(3) == 0 && flags[kFLAGS.MARBLE_KIDS] > 3) outputText("Marble herself is in the [camp] right now, telling a story about her travels around the world to her kids as they gather around her.  The children are completely enthralled by her words.  You can't help but smile.");
			//Requires 2 boys
			else if(rand(3) == 0 && flags[kFLAGS.MARBLE_BOYS] > 1)
			{
				outputText("Marble herself is currently refereeing a wrestling match between two of your sons.  It seems like it's a contest to see which one of them gets to go for a ride between her breasts in a game of <i>Bull Blasters</i>, while the loser has to sit on her shoulders.");
			}
			//requires at least 2 kids
			else if(rand(3) == 0 && flags[kFLAGS.MARBLE_KIDS] - flags[kFLAGS.MARBLE_BOYS] > 1) outputText("Marble herself is involved in a play fight with two of your kids brandishing small sticks.  It seems that the <i>mommy monster</i> is terrorising the [camp] and needs to be stopped by the <i>Mighty Moo and her sidekick Bovine Lass</i>.");
			else if(rand(3) == 0 && flags[kFLAGS.MARBLE_KIDS] > 1) outputText("Marble herself is out right now; she's taken her kids to go visit Whitney.  You're sure though that she'll be back within the hour, so you could just wait if you needed her.");
			else {
				//requires at least 1 kid
				if(rand(2) == 0) 
				{
					outputText("Marble herself is nursing ");
					if(flags[kFLAGS.MARBLE_KIDS] > 1) outputText("one of your cow-girl children");
					else outputText("your cow-girl child");
					outputText(" with a content look on her face.");
				}
				else 
				{
					outputText("Marble herself is watching your kid");
					if(flags[kFLAGS.MARBLE_KIDS] > 0) outputText("s");
					outputText(" playing around the [camp] right now.");
				}
			}
		}
		else{
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
			if(c < 3) {
				outputText("  You're sure she'd be back in moments if you needed her.");
			}
		}

		//Out getting family
		//else outputText("Marble is out in the wilderness right now, searching for a relative.");
		outputText("\n\n");
		if(flags[kFLAGS.MARBLE_PURIFICATION_STAGE] != 4) buttons.add( "Marble", marbleScene.interactWithMarbleAtCamp).hint("Go to Marble the cowgirl for talk and companionship.");
	}
	//Phylla
	if (flags[kFLAGS.ANT_WAIFU] > 0) {
		outputText("You see Phylla's anthill in the distance.  Every now and then you see");
		//If PC has children w/ Phylla:
		if(flags[kFLAGS.ANT_KIDS] > 0 && flags[kFLAGS.ANT_KIDS] <= 250) outputText(" one of your children exit the anthill to unload some dirt before continuing back down into the colony.  It makes you feel good knowing your offspring are so productive.");
		else if(flags[kFLAGS.ANT_KIDS] > 250 && flags[kFLAGS.ANT_KIDS] <= 1000) outputText(" few of your many children exit the anthill to unload some dirt before vanishing back inside.  It makes you feel good knowing your offspring are so productive.");
		else if(flags[kFLAGS.ANT_KIDS] > 1000) outputText(" some of your children exit the anthill using main or one of the additionally entrances to unload some dirt. Some of them instead of unloading dirt coming out to fulfill some other task that their mother gave them.  You feel a little nostalgic seeing how this former small colony grown to such a magnificent size.");
		else outputText(" Phylla appear out of the anthill to unload some dirt.  She looks over to your campsite and gives you an excited wave before heading back into the colony.  It makes you feel good to know she's so close.");
		outputText("\n\n");
        buttons.add( "Phylla", SceneLib.desert.antsScene.introductionToPhyllaFollower);
    }
	//Samirah
	if (flags[kFLAGS.SAMIRAH_FOLLOWER] > 9) {
		outputText("Samirah is quietly sunbathing on a rock, her long tail wrapped around on itself. She looks like she is very busy having a hissing conversation with a common snake which, considering her way of speech, isn’t really that strange.\n\n");
		buttons.add( "Samirah", SceneLib.samirah.samirahMainCampMenu);
	}
	//Nieve (jako, ze jest sezonowym camp member powinna byc na koncu listy...chyba, ze zrobie cos w stylu utworzenia mini lodowej jaskini dla niej)
	if(flags[kFLAGS.NIEVE_STAGE] == 5) {
		Holidays.nieveCampDescs();
		outputText("\n\n");
        buttons.add( "Nieve", Holidays.approachNieve);
    }
    for each(var npc:XXCNPC in _campFollowers){
		npc.campDescription(buttons,XXCNPC.LOVER);
    }
	if(!descOnly){submenu(buttons,playerMenu)}
}

public function campSlavesMenu(descOnly:Boolean = false):void {
	var buttons:ButtonDataList = new ButtonDataList();
	if (!descOnly) {
		hideMenus();
		spriteSelect(-1);
		clearOutput();
        CoC.instance.inCombat = false;
        menu();
	}
	if (isAprilFools() && flags[kFLAGS.DLC_APRIL_FOOLS] == 0 && !descOnly) {
        Holidays.DLCPrompt("Slaves DLC", "Get the Slaves DLC to be able to interact with them. Show them that you're dominating!", "$4.99", doCamp);
        return;
	}
	if(latexGooFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 0) {
		outputText(flags[kFLAGS.GOO_NAME] + " lurks in a secluded section of rocks, only venturing out when called for or when she needs to gather water from the stream.\n\n");
		buttons.add( flags[kFLAGS.GOO_NAME], latexGirl.approachLatexy);
	}
	if(milkSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0) {
		outputText("Your well-endowed, dark-skinned milk-girl is here.  She flicks hopeful eyes towards you whenever she thinks she has your attention.\n\n");
		buttons.add( flags[kFLAGS.MILK_NAME], milkWaifu.milkyMenu);
	}
	//Ceraph
	if (ceraphIsFollower()) {
		buttons.add( "Ceraph", ceraphFollowerScene.ceraphFollowerEncounter);
	}
	//Vapula
	if(vapulaSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0) {
		vapula.vapulaSlaveFlavorText();
		outputText("\n\n");
		buttons.add( "Vapula", vapula.callSlaveVapula);
	}
	//Galia
	if (flags[kFLAGS.GALIA_LVL_UP] >= 1) {
		if (flags[kFLAGS.GALIA_AFFECTION] < 10) outputText("Near the [camp] edge nearly next to Evangeline bedroll sits a large wooden cage for keeping female imp brought back from Adventure Guild. Despite been one of those more feral she most of the time spend sitting motionlessly and gazing into the horizon.\n\n");
		else outputText("Nothing to see here yet.\n\n");
	}
	//Excellia Slave
	if (flags[kFLAGS.EXCELLIA_RECRUITED] == 2) {
		outputText("Excellia sits near your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "cabin":"tent")+". "+(SceneLib.excelliaFollower.totalExcelliaChildren() > 1 ? "Her children clamor around, groping, suckling, and licking at her supple flesh. She moos loudly as they have their way with her. When she finally notices you, she beckons for you to join too.":"She moos faintly as she idly caresses her own full breasts and wet snatch. When she notices you, she spreads her legs a bit and her tail eagerly swishes back and forth, hoping you'll come over.")+"\n\n");
		buttons.add( "Excellia", SceneLib.excelliaFollower.ExcelliaCampMainMenuMakeSlave).hint("Visit Excellia.");
	}
	//Patchouli
	if (flags[kFLAGS.PATCHOULI_FOLLOWER] >= 5) {
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == 5) outputText("Patchouli is still tied to a tree. Even incapacitated in this way, he keeps grinning at you, as if taunting you.\n\n");
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] >= 6) outputText("Patchoulie is lazily resting on a branch in the nearby tree. When she looks at you, she always has that unsettling smile of hers, as if taunting you.\n\n");
		buttons.add( "Patchoule", SceneLib.patchouliScene.patchouleMainCampMenu);
	}
	//Modified Camp/Follower List Description:
	if(amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 2 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) {
		outputText("Sometimes you hear a faint moan from not too far away. No doubt the result of your slutty toy mouse playing with herself.\n\n");
		buttons.add( "Amily", amilyScene.amilyFollowerEncounter);
	}
	//JOJO
	//If Jojo is corrupted, add him to the masturbate menu.
	if (campCorruptJojo() && flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 0) {
		outputText("From time to time you can hear movement from around your [camp], and you routinely find thick puddles of mouse semen.  You are sure Jojo is here if you ever need to sate yourself.\n\n");
		buttons.add( "Jojo", jojoScene.corruptCampJojo).hint("Call your corrupted pet into [camp] in order to relieve your desires in a variety of sexual positions?  He's ever so willing after your last encounter with him.");
	}
	//Bimbo Sophie
	if(bimboSophie() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
		sophieBimbo.sophieCampLines();
		buttons.add( "Sophie", sophieBimbo.approachBimboSophieInCamp);
	}
    for each(var npc:XXCNPC in _campFollowers){
        npc.campDescription(buttons,XXCNPC.SLAVE);
    }
    if(!descOnly){submenu(buttons,playerMenu);}
}

public function campFollowers(descOnly:Boolean = false):void {
	var buttons:ButtonDataList = new ButtonDataList();
	if (!descOnly) {
		hideMenus();
		spriteSelect(-1);
		clearOutput();
        CoC.instance.inCombat = false;
        //ADD MENU FLAGS/INDIVIDUAL FOLLOWER TEXTS
		menu();
	}
	//Aether Twins
	if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] > 0 || flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] > 0) {
		buttons.add( "Aether Twins", SceneLib.aethertwins.aethertwinsFollowers).hint("Visit Aether twins the sentient weapons. You can even take and wear them as weapon and shield if you like.");
	}
	//Aurora
	if (flags[kFLAGS.AURORA_LVL] >= 1) {
		buttons.add( "Aurora", SceneLib.auroraFollower.auroraCampMenu).hint("Check up on Aurora.").disableIf(player.statusEffectv2(StatusEffects.CampSparingNpcsTimers4) > 0,"Training.");
	}
	//Alvina
	if (flags[kFLAGS.ALVINA_FOLLOWER] > 12 && flags[kFLAGS.ALVINA_FOLLOWER] < 20) {
		outputText("Alvina isn’t so far from here, having made her [camp] in a corrupted plant groove she created so to have easy access to reagents.\n\n");
		buttons.add( "Alvina", SceneLib.alvinaFollower.alvinaMainCampMenu).hint("Check up on Alvina.");
	}
	//Siegweird
	if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 3) {
		outputText("The regular pensive 'Mmmmmm' by the campfire and the delicious smell of soup reminds you that Siegweird the paladin is now residing in your [camp].\n\n");
		buttons.add( "Siegweird", SceneLib.siegweirdFollower.siegweirdMainCampMenu).hint("Check up on Siegweird.");
	}
	//Ember
	if(emberScene.followerEmber()) {
		emberScene.emberCampDesc();
		if (player.statusEffectv2(StatusEffects.CampLunaMishaps2) > 0) buttons.add( "Ember", emberScene.emberCampMenu2).hint("Check up on Ember the dragon-" + (flags[kFLAGS.EMBER_ROUNDFACE] == 0 ? "morph" : flags[kFLAGS.EMBER_GENDER] == 1 ? "boy" : "girl" ) + "").disableIf(player.statusEffectv2(StatusEffects.CampLunaMishaps2) > 0,"Busy searching.");
		else buttons.add( "Ember", emberScene.emberCampMenu2).hint("Check up on Ember the dragon-" + (flags[kFLAGS.EMBER_ROUNDFACE] == 0 ? "morph" : flags[kFLAGS.EMBER_GENDER] == 1 ? "boy" : "girl" ) + "").disableIf(player.statusEffectv1(StatusEffects.CampSparingNpcsTimers1) > 0,"Training.");
	}
	//Sophie
	if(sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
		if(rand(5) == 0) outputText("Sophie is sitting by herself, applying yet another layer of glittering lip gloss to her full lips.\n\n");
		else if(rand(4) == 0) outputText("Sophie is sitting in her nest, idly brushing out her feathers.  Occasionally, she looks up from her work to give you a sultry wink and a come-hither gaze.\n\n");
		else if(rand(3) == 0) outputText("Sophie is fussing around in her nest, straightening bits of straw and grass, trying to make it more comfortable.  After a few minutes, she flops down in the middle and reclines, apparently satisfied for the moment.\n\n");
		else if(rand(2) == 0 || flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] == 0) {
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00282] > 0) outputText("Your platinum-blonde harpy, Sophie, is currently reading a book - a marked change from her bimbo-era behavior.  Occasionally, though, she glances up from the page and gives you a lusty look.  Some things never change....\n\n");
			else outputText("Your pink harpy, Sophie, is currently reading a book.  She seems utterly absorbed in it, though you question how she obtained it.  Occasionally, though, she'll glance up from the pages to shoot you a lusty look.\n\n");
		}
		else {
			outputText("Sophie is sitting in her nest, ");
			if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] < 5) {
				outputText("across from your daughter");
				if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] > 1) outputText("s");
			}
			else outputText("surrounded by your daughters");
			outputText(", apparently trying to teach ");
			if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] == 1) outputText("her");
			else outputText("them");
			outputText(" about hunting and gathering techniques.  Considering their unusual upbringing, it can't be as easy for them...\n\n");
		}
		buttons.add( "Sophie", sophieFollowerScene.followerSophieMainScreen).hint("Check up on Sophie the harpy.");
	}
	//Pure Jojo
	if (player.hasStatusEffect(StatusEffects.PureCampJojo)) {
		if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) {
			outputText("Joy's tent is set up in a quiet corner of the [camp], close to a boulder. Inside the tent, you can see a chest holding her belongings, as well as a few clothes and books spread about her bedroll. ");
			if (flags[kFLAGS.JOJO_LITTERS] > 0 && model.time.hours >= 16 && model.time.hours < 19) outputText("You spot the little mice you had with Joy playing about close to her tent.");
			else outputText("Joy herself is nowhere to be found, she's probably out frolicking about or sitting atop the boulder.");
			outputText("\n\n");
			buttons.add( "Joy", joyScene.approachCampJoy).hint("Go find Joy around the edges of your [camp] and meditate with her or have sex with her.");
		}
		else {
			outputText("There is a small bedroll for Jojo near your own");
			if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) outputText(" cabin");
			if (!(model.time.hours > 4 && model.time.hours < 23)) outputText(" and the mouse is sleeping on it right now.\n\n");
			else outputText(", though the mouse is probably hanging around the [camp]'s perimeter.\n\n");
			buttons.add( "Jojo", jojoScene.jojoCamp2).hint("Go find Jojo around the edges of your [camp] and meditate with him or talk about watch duty.").disableIf(player.statusEffectv2(StatusEffects.CampLunaMishaps1) > 0,"Annoyed.");//wpisać blokowanie mishapów jak opcja wyłączenia jej jest aktywna
		}
	}
	//Celess
	//Evangeline
	if (flags[kFLAGS.EVANGELINE_FOLLOWER] >= 1 && flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] <= 0) {
		outputText("There is a small bedroll for Evangeline near the [camp] edge");
		if (!(model.time.hours > 4 && model.time.hours < 23)) outputText(" and she's sleeping on it right now.");
		else outputText(", though she probably wander somewhere near [camp] looking for more ingredients to make her potions.");
		outputText(" Next to it stands a small chest with her personal stuff.\n\n");
		buttons.add( "Evangeline", EvangelineF.meetEvangeline).hint("Visit Evangeline.");
	}
	else if (flags[kFLAGS.EVANGELINE_FOLLOWER] >= 1 && flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] >= 1) {
		/*if (flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] >= 1)*/ outputText("Evangeline isn't in the [camp] as she went to buy some items. She should be out no longer than a few hours.\n\n");
		//if () outputText("Evangeline is busy training now. She should be done with it in a few hours.\n\n");
	}
	//Kindra
	if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) {
		outputText("You can see a set of finely crafted traps around your [camp]. Kindra must be hunting nearby.\n\n");
		buttons.add( "Kindra", SceneLib.kindraFollower.meet2Kindra).hint("Visit Kindra the sheep-morph.").disableIf(player.statusEffectv1(StatusEffects.CampSparingNpcsTimers2) > 0,"Training.");
	}
	//Dinah
	if (flags[kFLAGS.DINAH_LVL_UP] >= 1) {
		outputText("You can see a cart with various vials standing next to bedroll. Dinah must be somewhere nearby.\n\n");
		buttons.add( "Dinah", SceneLib.dinahScene.DinahIntro2).hint("Visit Dinah the cat chimera merchant.").disableIf(player.statusEffectv1(StatusEffects.CampSparingNpcsTimers3) > 0,"Training.");
	}
	//Neisa
	if (flags[kFLAGS.NEISA_FOLLOWER] >= 7) {
		outputText("Neisa is hanging by a tree next to the [camp] practicing her swordplay on a makeshift dummy for the next expedition.\n\n");
		buttons.add( "Neisa", SceneLib.neisaFollower.neisaCampMenu).hint("Visit Neisa the shield maiden.");
	}
	//Helspawn
	if (helspawnFollower()) {
		buttons.add( flags[kFLAGS.HELSPAWN_NAME], helSpawnScene.helspawnsMainMenu);
	}
	//Valaria
	if (flags[kFLAGS.VALARIA_AT_CAMP] == 1 && flags[kFLAGS.TOOK_GOO_ARMOR] == 1) {
		buttons.add( "Valeria", valeria.valeriaFollower).hint("Visit Valeria the goo-girl. You can even take and wear her as goo armor if you like.");
	}
	//RATHAZUL
	//if rathazul has joined the camp
	if (player.hasStatusEffect(StatusEffects.CampRathazul)) {
		if(flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] <= 1) {
			outputText("Tucked into a shaded corner of the rocks is a bevy of alchemical devices and equipment.  ");
			if (!(model.time.hours > 4 && model.time.hours < 23)) outputText("The alchemist is absent from his usual work location. He must be sleeping right now.");
			else outputText("The alchemist Rathazul looks to be hard at work with his chemicals, working on who knows what.");
			if (flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] == 1) {
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] < 10) outputText("  Some kind of spider-silk-based equipment is hanging from a nearby rack.");
				outputText("  <b>He's finished with the task you gave him!</b>");
			}
			outputText("\n\n");
		}
		else outputText("Tucked into a shaded corner of the rocks is a bevy of alchemical devices and equipment.  The alchemist Rathazul looks to be hard at work on the silken equipment you've commissioned him to craft.\n\n");
		if (flags[kFLAGS.MITZI_RECRUITED] == 2) outputText("Mitzi is laying on a cot in Rathazul's lab. A deep blush is present her face and she pants heavily, constantly fading in and out of consciousness.\n\n");
		buttons.add( "Rathazul", SceneLib.rathazul.returnToRathazulMenu).hint("Visit with Rathazul to see what alchemical supplies and services he has available at the moment.");
	}
	else
	{
		if (flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] == 1)
		{
			outputText("There is a note on your ");
			if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) outputText("bed inside your cabin.");
			else outputText("bedroll");
			outputText(". It reads: \"<i>Come see me at the lake. I've finished your ");
			switch(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275]) {
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
				default: outputText("robes");
			}
			outputText(". -Rathazul</i>\".\n\n");
		}
	}
	//Excellia Follower
	if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 3 && flags[kFLAGS.EXCELLIA_RECRUITED] < 33) {
		outputText("Excellia sits just outside her tent looking a bit lost and confused. When she sees you, she immediately perks up, swishing her tail back and forth in the hopes that you come over to her.\n\n");
		buttons.add( "Excellia", SceneLib.excelliaFollower.ExcelliaCampMainMenuFixHer).hint("Visit Excellia.");
	}
	//Mitzi + brood
	if (flags[kFLAGS.MITZI_RECRUITED] >= 4) {
		outputText("Mitzi is laying back on a blanket in the shade. When she notices you, she gives you a sultry look then pushes out her chest a bit to entice you.\n\n");
		buttons.add( "Mitzi", SceneLib.mitziFollower.MitziCampMainMenu).hint("Visit Mitzi.");
	}
	if (flags[kFLAGS.MITZI_DAUGHTERS] >= 4) {
		outputText("At the West of [camp] sits a cluster of small, surprisingly sturdy looking huts built by Mitzi's daughters. You can see some of them building some strange gadgets while others work in front of a large melding pot over a fire, more than likely experimenting with some new types of potions.\n\n");
		buttons.add( "Mitzi D.", SceneLib.mitziFollower.MitziDaughtersCampMainMenu).hint("Visit Mitzi daughters.");
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
		buttons.add( "Konstantin", SceneLib.konstantin.KonstantinMainCampMenu);
	}
	//Shouldra
	if (followerShouldra()) {
		buttons.add( "Shouldra", shouldraFollower.shouldraFollowerScreen).hint("Talk to Shouldra. She is currently residing in your body.");
	}
	//Ayane
	if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) {
		outputText("Ayane is tiddying your items to make sure everything is clean and well organised.\n\n");
		buttons.add( "Ayane", SceneLib.ayaneFollower.ayaneCampMenu).hint("Visit Ayane a kitsune priestess of Taoth.");
	}
	//Pure/Corrupted Holli
	if (flags[kFLAGS.FUCK_FLOWER_LEVEL] == 4) {
		buttons.add( "Holli", holliScene.treeMenu).hint("Holli is in her tree at the edges of your [camp].  You could go visit her if you want.");
	}
	if (flags[kFLAGS.FLOWER_LEVEL] == 4) {
		buttons.add( "Holli", HolliPure.treeMenu).hint("Holli is in her tree at the edges of your [camp].  You could go visit her if you want.");
	}
	//Michiko
	if (flags[kFLAGS.MICHIKO_FOLLOWER] >= 1) {
		outputText("Michiko is sitting on a tree stump, busy writing her latest notes about your adventures.\n\n");
		buttons.add( "Michiko", SceneLib.michikoFollower.campMichikoMainMenu).hint("Check up on Michiko.");
	}
	//Sidonie
	if (flags[kFLAGS.SIDONIE_FOLLOWER] == 1) {
		if (model.time.hours >= 6 && model.time.hours <= 8) outputText("Sidonie has taken a table out to have breakfast outside. By you can see, she’s munching a large bowl filled with oath, milk and strawberries.");
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
		buttons.add( "Sidonie", SceneLib.sidonieFollower.mainSidonieMenu).hint("Visit Sidonie.");
	}
	//Luna
	if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) {
		outputText("Luna wanders around the [camp], doing her chores as usual.");
		if (flags[kFLAGS.LUNA_JEALOUSY] >= 100) outputText(" She looks at you from time to time, as if expecting you to notice her.");
		outputText("\n\n");
		buttons.add( "Luna", SceneLib.lunaFollower.mainLunaMenu).hint("Visit Luna.").disableIf(player.statusEffectv1(StatusEffects.CampSparingNpcsTimers3) > 0,"Training.");
	}
	//PC Goblin daughters
	if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 0) buttons.add( "Goblin kids", campScenes.PCGoblinDaughters).hint("Check up on your goblin daughters.");
    for each(var npc:XXCNPC in _campFollowers){
        npc.campDescription(buttons,XXCNPC.FOLLOWER);
    }
    if(!descOnly){submenu(buttons,playerMenu);}
}

//-----------------
//-- CAMP ACTIONS 
//-----------------
private function campActions():void {
	hideMenus();
	menu();
	clearOutput();
	outputText("What would you like to do?");
	addButton(0, "SpentTime", campSpendTimeActions).hint("Check your options to spend time in and around [camp].");
	addButton(1, "Build", campBuildingSim).hint("Check your [camp] build options.");
	addButton(2, "Read Codex", codex.accessCodexMenu).hint("Read any codex entries you have unlocked.");
	addButton(3, "Questlog", questlog.accessQuestlogMainMenu).hint("Check your questlog.");
	if (flags[kFLAGS.LETHICE_DEFEATED] > 0) addButton(4, "Ascension", promptAscend).hint("Perform an ascension? This will restart your adventures with your items, and gems carried over. The game will also get harder.");
	//addButton(5, "Craft", kGAMECLASS.crafting.accessCraftingMenu).hint("Craft some items.");
	if (player.hasPerk(PerkLib.JobElementalConjurer) || player.hasPerk(PerkLib.JobGolemancer)) addButton(6, "Winions", campWinionsArmySim).hint("Check your options for making some Winions.");
	else addButtonDisabled(6, "Winions", "You need to be able to make some minions that fight for you to use this option like elementals or golems...");
	if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 1) addButton(8, "Fishery", VisitFishery).hint("Visit Fishery.");
	if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] >= 2) addButton(9, "Ward", MagicWardMenu).hint("Activate or Deactivate Magic Ward around [camp].");
	if (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] >= 4) addButton(10, "Kitsune Shrine", campScenes.KitsuneShrine).hint("Meditate at [camp] Kitsune Shrine.");
	if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] >= 4) addButton(11, "Hot Spring", campScenes.HotSpring).hint("Visit Hot Spring.");
	addButton(12, "Misc", campMiscActions).hint("Misc options to do things in and around [camp].");
	addButton(13, "NPC's", SparrableNPCsMenu);
	addButton(14, "Back", playerMenu);
}

private function campSpendTimeActions():void {
	menu();
	addButton(0, "SwimInStream", swimInStream).hint("Swim in stream and relax to pass time.", "Swim In Stream");
	addButton(1, "ExaminePortal", examinePortal).hint("Examine the portal. This scene is placeholder.", "Examine Portal"); //Examine portal.
	if (model.time.hours == 19) {
		addButton(2, "Watch Sunset", watchSunset).hint("Watch the sunset and relax."); //Relax and watch at the sunset.
	}
	else if (model.time.hours >= 20 && flags[kFLAGS.LETHICE_DEFEATED] > 0) {
		addButton(2, "Stargaze", watchStars).hint("Look at the starry night sky."); //Stargaze. Only available after Lethice is defeated.
	}
	else {
		addButtonDisabled(2, "Watch Sky", "The option to watch sunset is available at 7pm.");
	}
	addButton(14, "Back", campActions);
}

private function campMiscActions():void {
	menu();
	if (player.hasItem(consumables.LG_SFRP, 10) && (player.hasItem(useables.E_P_BOT, 1))) addButton(0, "Fill bottle", fillUpPillBottle00).hint("Fill up one of your pill bottles with low-grade soulforce recovery pills.");
	else addButtonDisabled(0, "Fill bottle", "You need one empty pill bottle and ten low-grade soulforce recovery pills.");
	if (player.hasItem(consumables.MG_SFRP, 10) && (player.hasItem(useables.E_P_BOT, 1))) addButton(1, "Fill bottle", fillUpPillBottle01).hint("Fill up one of your pill bottles with mid-grade soulforce recovery pills.");
	else addButtonDisabled(1, "Fill bottle", "You need one empty pill bottle and ten mid-grade soulforce recovery pills.");
	addButton(14, "Back", campActions);
}

private function campBuildingSim():void {
	menu();
	if (player.hasKeyItem("Carpenter's Toolbox") >= 0) {
		if (flags[kFLAGS.CAMP_WALL_PROGRESS] < 100 && getCampPopulation() >= 4) addButton(0, "Build Wall", buildCampWallPrompt).hint("Build a wall around your [camp] to defend from the imps." + (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 10 ? "\n\nProgress: " + (flags[kFLAGS.CAMP_WALL_PROGRESS]/10) + "/10 complete": "") + "");
		if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100 && flags[kFLAGS.CAMP_WALL_GATE] <= 0) addButton(0, "Build Gate", buildCampGatePrompt).hint("Build a gate to complete your [camp] defense.");
		//addButton(2, "Build Cabin(O)", campUpgrades.buildCampMembersCabinsMenu).hint("Work on your camp members cabins.");
		addButton(5, "Build Misc", campUpgrades.buildmisc1Menu).hint("Build other structures than walls or cabins for your [camp].");
		//addButton(6, "Build Misc(O)", campUpgrades.).hint("Other structures than walls or cabins for your camp.");
	}
	else {
		addButtonDisabled(0, "Build Wall", "Req. Carpenter's Toolbox.");
		//addButtonDisabled(2, "Build Cabin(O)", "Req. Carpenter's Toolbox.");
		addButtonDisabled(5, "Build Misc", "Req. Carpenter's Toolbox.");
		//addButtonDisabled(6, "Build Misc(O)", "Req. Carpenter's Toolbox.");
	}
	if (flags[kFLAGS.CAMP_CABIN_PROGRESS] > 0 && flags[kFLAGS.CAMP_CABIN_PROGRESS] < 10) addButton(1, "Build Cabin", cabinProgress.initiateCabin).hint("Work on your cabin."); //Work on cabin.
	if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 10 && player.hasItem(useables.IMPSKLL, 1)) addButton(10, "AddImpSkull", promptHangImpSkull).hint("Add an imp skull to decorate the wall and to serve as deterrent for imps.", "Add Imp Skull");
	addButton(14, "Back", campActions);
}

private function campWinionsArmySim():void {
	menu();
	if (player.hasPerk(PerkLib.JobGolemancer)) addButton(0, "Make", campMake.accessMakeWinionsMainMenu).hint("Check your options for making some golems.");
	else addButtonDisabled(0, "Make", "You need to be golemancer to use this option.");
	if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] > 0) addButton(1, "Summon", campMake.accessSummonElementalsMainMenu).hint("Check your options for managing your elemental summons.");
	else addButtonDisabled(1, "Summon", "You should first build Arcane Circle. Without some tools from the carpenter's toolbox it would be near impossible to do this.");
	addButton(14, "Back", campActions);
}

private function MagicWardMenu():void {
	clearOutput();
	outputText("You touch one of the warding stones");
	if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 2) {
		outputText(", and feel a surge of power as every stone comes alive with power.  The ward is up, and your [camp] should be safe.");
		flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] = 3;
		doNext(campActions);
		return;
	}
	if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 3) {
		outputText(" and murmur a incantation.  Gradually, the power within the stones fade as they go dormant. Soon, the glow of the glyphs adorning the stones has gone dark.");
		flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] = 2;
		doNext(campActions);
		return;
	}
}

private function fillUpPillBottle00():void {
	outputText("\n\nYou pick up one of your empty pills bottle and starts to put in some of your loose low-grade soulforce recovery pills. Then you close the bottle and puts into backpack.");
	player.destroyItems(useables.E_P_BOT, 1);
	player.destroyItems(consumables.LG_SFRP, 10);
	inventory.takeItem(consumables.LGSFRPB, campMiscActions);
}
private function fillUpPillBottle01():void {
	outputText("\n\nYou pick up one of your empty pills bottle and starts to put in some of your loose mid-grade soulforce recovery pills. Then you close the bottle and puts into backpack.");
	player.destroyItems(useables.E_P_BOT, 1);
	player.destroyItems(consumables.MG_SFRP, 10);
	inventory.takeItem(consumables.MGSFRPB, campMiscActions);
}

private function SparrableNPCsMenu():void {
	clearOutput();
	outputText("Champion party composition: [name]");
	if (player.hasPerk(PerkLib.BasicLeadership)) {
		if (flags[kFLAGS.PLAYER_COMPANION_1] != "") outputText(", " + flags[kFLAGS.PLAYER_COMPANION_1]);
		else outputText(", (no combat companion)");
	}/*
	if (player.hasPerk(PerkLib.IntermediateLeadership)) {
		if (flags[kFLAGS.PLAYER_COMPANION_2] != "") outputText(", " + flags[kFLAGS.PLAYER_COMPANION_2]);
		else outputText(", (no combat companion)");
	}
	if (player.hasPerk(PerkLib.AdvancedLeadership)) {
		if (flags[kFLAGS.PLAYER_COMPANION_3] != "") outputText(", " + flags[kFLAGS.PLAYER_COMPANION_3]);
		else outputText(", (no combat companion)");
	}*/
	if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) {
		outputText("\n\nPlaceholder text about deciding if sparrable npc's in [camp] should train or relax (train mean rising in lvl after enough time loosing to PC in sparrings).");
		outputText("\n\nPlaceholder text about current mode [camp] combat NPC's are in: ");
		if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) outputText("Training Mode\n");
		if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] < 2) outputText("Relax Mode\n");
	}
	if (player.hasStatusEffect(StatusEffects.DianaOff)) outputText("\nDiana: <font color=\"#800000\"><b>Disabled</b></font>");
	if (player.hasStatusEffect(StatusEffects.DivaOff)) outputText("\nDiva: <font color=\"#800000\"><b>Disabled</b></font>");
	if (player.hasStatusEffect(StatusEffects.ElectraOff)) outputText("\nElectra: <font color=\"#800000\"><b>Disabled</b></font>");
	if (player.hasStatusEffect(StatusEffects.EtnaOff)) outputText("\nEtna: <font color=\"#800000\"><b>Disabled</b></font>");
	if (player.hasStatusEffect(StatusEffects.LunaOff)) outputText("\nLuna: <font color=\"#800000\"><b>Disabled</b></font>");
	menu();
	if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) {
		if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] < 2) addButton(10, "Train", NPCsTrain);
		if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) addButton(11, "Relax", NPCsRelax);
	}
	addButton(0, "Diana", toggleDianaMenu).hint("Enable or Disable Diana. This will remove her from enc table and if already in [camp] disable access to her.");
	addButton(1, "Diva", toggleDivaMenu).hint("Enable or Disable Diva. This will remove her from enc table and if already in [camp] disable access to her.");
	addButton(2, "Electra", toggleElectraMenu).hint("Enable or Disable Electra. This will remove her from enc table and if already in [camp] disable access to her.");
	addButton(3, "Etna", toggleEtnaMenu).hint("Enable or Disable Etna. This will remove her from enc table and if already in [camp] disable access to her.");
	addButton(5, "Luna", toggleLunaMenu).hint("Enable or Disable Luna. This will remove her from enc table and if already in [camp] disable access to her.");
	addButton(14, "Back", campActions);
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

private function VisitFishery():void {
	outputText("\n\nYou go check at the barrels for food.");
	if (flags[kFLAGS.FISHES_STORED_AT_FISHERY] > 0) outputText(" There is currently " + flags[kFLAGS.FISHES_STORED_AT_FISHERY] + " fish in the barrel.");
	menu();
	if (flags[kFLAGS.FISHES_STORED_AT_FISHERY] > 0) addButton(0, "Retrieve", Retrieve);
	if (flags[kFLAGS.FISHES_STORED_AT_FISHERY] > 0) addButton(1, "Retrieve Stack", RetrieveStack);
	addButton(14, "Back", campActions);
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
	}
	else {
		outputText("\n\nYou need more fish to bag out a bundle.");
		doNext(VisitFishery);
	}
}

private function swimInStream():void {
	var izmaJoinsStream:Boolean = false;
	var marbleJoinsStream:Boolean = false;
	var heliaJoinsStream:Boolean = false;
	var amilyJoinsStream:Boolean = false;
	var emberJoinsStream:Boolean = false;
	var rathazulJoinsStream:Boolean = false; //Rare, 10% chance.
	
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
	if (rand(2) == 0 && camp.izmaFollower())
	{
		outputText("\n\nYour tiger-shark beta, Izma, joins you. You are frightened at first when you saw the fin protruding from the water and the fin approaches you! ");
		outputText("As the fin approaches you, the familiar figure comes up. \"<i>I was going to enjoy my daily swim, alpha,</i>\" she says.");
		izmaJoinsStream = true;
	}
	//Helia!
	if (rand(2) == 0 && camp.followerHel() && flags[kFLAGS.HEL_CAN_SWIM])
	{
		outputText("\n\nHelia, your salamander lover, joins in for a swim. \"<i>Hey, lover mine!</i>\" she says. As she enters the waters, the water seems to become warmer until it begins to steam like a sauna.");
		heliaJoinsStream = true;
	}
	//Marble!
	if (rand(2) == 0 && camp.marbleFollower())
	{
		outputText("\n\nYour cow-girl lover Marble strips herself naked and joins you. \"<i>Sweetie, you enjoy swimming, don't you?</i>\" she says.");
		marbleJoinsStream = true;
	}
	//Amily! (Must not be corrupted and must have given Slutty Swimwear.)
	if (rand(2) == 0 && camp.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_OWNS_BIKINI] > 0)
	{
		outputText("\n\nYour mouse-girl lover Amily is standing at the riverbank. She looks flattering in her bikini");
		if (flags[kFLAGS.AMILY_WANG_LENGTH] > 0) outputText(", especially when her penis is exposed");
		outputText(". She walks into the waters and swims.  ");
		amilyJoinsStream = true;
	}
	//Ember 
	if (rand(4) == 0 && camp.followerEmber())
	{
		outputText("\n\nYou catch a glimpse of Ember taking a daily bath.");
		emberJoinsStream = true;
	}
	//Rathazul (RARE)
	if (rand(10) == 0 && player.hasStatusEffect(StatusEffects.CampRathazul))
	{
		outputText("\n\nYou spot Rathazul walking into the shallow section of stream, most likely taking a bath to get rid of the smell.");
		rathazulJoinsStream = true;
	}
	//Pranks!
	if (prankChooser == 0 && (camp.izmaFollower() || (camp.followerHel() && flags[kFLAGS.HEL_CAN_SWIM]) || camp.marbleFollower() || (camp.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_OWNS_BIKINI] > 0)) )
	{
		outputText("\n\nYou could play some pranks by making the water curiously warm. Do you?");
		doYesNo(swimInStreamPrank1, swimInStreamFinish);
		return;
	}
	/*if (prankChooser == 1 && (camp.izmaFollower() || (camp.followerHel() && flags[kFLAGS.HEL_CAN_SWIM]) || camp.marbleFollower()) )
	{
		outputText("\n\nYou could play some pranks by grabbing the leg of one of them and surprise them. Do you?");
		doYesNo(swimInStreamPrank2, swimInStreamFinish);
	}*/
	/*if (prankChooser == 2 && player.lust >= 33) {
		outputText("\n\nYou're feeling horny right now. Do you masturbate in the stream?");
		doYesNo(swimInStreamFap, swimInStreamFinish);
		return;
	}*/
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
	if (rand(prankRoll) == 0 && camp.izmaFollower() && pranked == false && izmaJoinsStream == true)
	{
		outputText("\n\nIzma just swims over, unaware of the warm spot you just created. \"<i>Who've pissed in the stream?</i>\" she growls. You swim over to her and tell her that you admit you did pee in the stream. \"<i>Oh, alpha! What a naughty alpha you are,</i>\" she grins, her shark-teeth clearly visible.");
		pranked = true;
	}
	if (rand(prankRoll) == 0 && (camp.followerHel() && flags[kFLAGS.HEL_CAN_SWIM]) && pranked == false && heliaJoinsStream == true)
	{
		outputText("\n\nHelia swims around until she hits the warm spot you just created. \"<i>Heyyyyyyy,</i>\" the salamander yells towards you. She comes towards you and asks \"<i>Did you just piss in the stream?</i>\" after which you sheepishly chuckle and tell her that you admit it. Yes, you've done it. \"<i>I knew it! Oh, you're naughty, lover mine!</i>\" she says.");
		pranked = true;
	}
	if (rand(prankRoll) == 0 && camp.marbleFollower() && pranked == false && marbleJoinsStream == true)
	{
		outputText("\n\nMarble is oblivious to the warm spot and when she swims over, she yells \"<i>Hey, sweetie! Did you just urinate in the stream?</i>\" You sheepishly smile and admit that yes, you did it. She says, \"<i>You're naughty, you know, sweetie!</i>\"");
		pranked = true;
	}
	/*if (rand(prankRoll) == 0 && camp.amilyFollower() && flags[kFLAGS.AMILY_OWNS_BIKINI] > 0 && pranked == false && amilyJoinsStream == true)
	{
		outputText("");
		pranked = true;
	}*/
	if (pranked == false) outputText("  No one managed to swim past where you left the warm spot before it dissipated. You feel a bit disappointed and just go back to swimming.");
	else outputText("  You feel accomplished from the prank and resume swimming. ");
	awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE);
	doNext(swimInStreamFinish);
}

private function swimInStreamFap():void {
	clearOutput();
	doNext(swimInStreamFinish);
}

private function swimInStreamFinish():void {
	clearOutput();
	//Blown up factory? Corruption gains.
	if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) 
	{
		outputText("You feel a bit dirtier after swimming in the tainted waters. \n\n");
		dynStats("cor", 0.5);
		if (player.cor < 25) dynStats("lust", 30, "scale", true);
		if (player.cor >= 25 && player.cor < 50) dynStats("lust", 20, "scale", true);
		if (player.cor >= 50) dynStats("lust", 10, "scale", true);
	}
	else if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) {
		outputText("You feel a bit cleaner after swimming in the waters. \n\n");
		if (player.cor < 33) dynStats("lust", -30, "scale", false);
		if (player.cor >= 33 && player.cor < 66) dynStats("lust", -20, "scale", false);
		if (player.cor >= 66) dynStats("lust", -10, "scale", false);
	}
	else {
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
	}
	else outputText("You walk over to the portal, reminded by how and why you came. You let out a sigh, knowing you can't return to Ingnam.");
	doNext(playerMenu);
}

private function watchSunset():void {
	clearOutput();
	outputText(images.showImage("camp-watch-sunset"));
	outputText("You pick a location where the sun is clearly visible from that particular spot and sit down. The sun is just above the horizon, ready to set. It's such a beautiful view. \n\n");
	var randText:Number = rand(3);
	//Childhood nostalgia GO!
	if (randText == 0)
	{
		if (player.cor < 33) 
		{
			outputText("A wave of nostalgia washes over you as you remember your greatest moments from your childhood.");
			dynStats("cor", -1, "lib", -1, "lust", -30, "scale", false);
		}
		if (player.cor >= 33 && player.cor < 66) 
		{
			outputText("A wave of nostalgia washes over you as you remember your greatest moments from your childhood. Suddenly, your memories are somewhat twisted from some of the perverted moments. You shake your head and just relax.");
			dynStats("cor", -0.5, "lib", -1, "lust", -20, "scale", false);
		}
		if (player.cor >= 66) 
		{
			outputText("A wave of nostalgia washes over you as you remember your greatest moments from your childhood. Suddenly, your memories twist into some of the dark and perverted moments. You chuckle at that moment but you shake your head and focus on relaxing.");
			dynStats("cor", 0, "lib", -1, "lust", -10, "scale", false);
		}
	}
	//Greatest moments GO!
	if (randText == 1)
	{
		if (player.cor < 33) 
		{
			outputText("You reflect back on your greatest adventures and how curiosity got the best of you. You remember some of the greatest places you discovered.");
			dynStats("lust", -30, "scale", false);
		}
		if (player.cor >= 33 && player.cor < 66) 
		{
			outputText("You reflect back on your greatest adventures. Of course, some of them involved fucking and getting fucked by the denizens of Mareth. You suddenly open your eyes from the memory and just relax, wondering why you thought of that in the first place.");
			dynStats("lust", -20, "scale", false);
		}
		if (player.cor >= 66) 
		{
			outputText("You reflect back on your greatest adventures. You chuckle at the moments you were dominating and the moments you were submitting. You suddenly open your eyes from the memory and just relax.");
			dynStats("lust", -10, "scale", false);
		}
	}
	//Greatest moments GO!
	if (randText >= 2)
	{
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
	switch(consellationChoice) {
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

//-----------------
//-- REST
//-----------------
public function restMenu():void {
	menu();
	addButton(0, "1 Hour", rest1).hint("Rest for one hour.");
	addButton(1, "2 Hours", rest2).hint("Rest for two hours.");
	addButton(2, "4 Hours", rest4).hint("Rest for four hours.");
	addButton(3, "8 Hours", rest8).hint("Rest for eight hours.");
	addButton(4, "Till Dusk", restTillDusk).hint("Rest until the night comes.");
	addButton(14, "Back", playerMenu);
}
public function rest1():void {
	waitingORresting = 1;
	rest();
}
public function rest2():void {
	waitingORresting = 2;
	rest();
}
public function rest4():void {
	waitingORresting = 4;
	rest();
}
public function rest8():void {
	waitingORresting = 8;
	rest();
}
public function restTillDusk():void {
	waitingORresting = 21 - model.time.hours;
	rest();
}
public function rest():void {
	campQ = true;
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
	if (player.findPerk(PerkLib.Medicine) >= 0) hpRecovery *= 1.5;
	if (player.findPerk(PerkLib.SpeedyRecovery) >= 0) fatRecovery += 2;
	if (player.findPerk(PerkLib.SpeedyRecuperation) >= 0) fatRecovery += 4;
	if (player.findPerk(PerkLib.SpeedyRejuvenation) >= 0) fatRecovery += 8;
	if (player.findPerk(PerkLib.ControlledBreath) >= 0) fatRecovery *= 1.1;
	if (player.hasStatusEffect(StatusEffects.BathedInHotSpring)) fatRecovery *= 1.2;
	if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) fatRecovery *= 3;
	if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && !prison.inPrison && !ingnam.inIngnam)
		multiplier += 0.5;
	//Marble withdrawal
	if(player.hasStatusEffect(StatusEffects.MarbleWithdrawl))
		multiplier /= 2;
	//Hungry
	if (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger < 25)
		multiplier /= 2;
	if (timeQ == 0) {
		var hpBefore:int = player.HP;
		if (flags[kFLAGS.SHIFT_KEY_DOWN] > 0) { //Rest until fully healed, midnight or hunger wake.
			while (player.HP < player.maxHP() || player.fatigue > 0) {
				timeQ += 1;
				HPChange(hpRecovery * multiplier, false); // no display since it is meant to be full rest anyway
				fatigue( -fatRecovery * multiplier);
				if (timeQ + model.time.hours == 24 || flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger < 5)
					break;
			}	
			if (timeQ == 0) timeQ = 1;
			if (timeQ > 21 - model.time.hours) timeQ = 21 - model.time.hours;
		} else {
			timeQ = Math.min(waitingORresting, 21 - model.time.hours);
			HPChange(timeQ * hpRecovery * multiplier, false);
			fatigue(timeQ * -fatRecovery * multiplier);
		}
		
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && !prison.inPrison && !ingnam.inIngnam)
		{
			if (timeQ != 1) outputText("You head into your cabin to rest. You lie down on your bed to rest for " + num2Text(timeQ) + " hours.\n");
			else outputText("You head into your cabin to rest. You lie down on your bed to rest for an hour.\n");
		}
		else if (player.lowerBody == LowerBody.PLANT_FLOWER)
		{
			if (timeQ != 1) outputText("You lie down in your pitcher, closing off your petals as you get comfortable for " + num2Text(timeQ) + " hours.\n");
			else outputText("You lie down in your pitcher, closing off your petals as you get comfortable for an hour.\n");
		}
		else if (player.isGargoyle())
		{
			if (timeQ != 1) outputText("You sit on your pedestal, your body petrifying like stone as you briefly slumber for " + num2Text(timeQ) + " hours.\n");
			else outputText("You sit on your pedestal, your body petrifying like stone as you briefly slumber for an hour.\n");
		}
		else 
		{
			if (timeQ != 1) outputText("You lie down to rest for " + num2Text(timeQ) + " hours.\n");
			else outputText("You lie down to rest for an hour.\n");
		}
		//Ayane
		if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) {
			if (timeQ != 1) outputText("\nYou tell Ayane you wish to rest for a few hours. The devoted priestess assists your recovery by bandaging your wounds and preparing a meditation tea ceremony.\n");
			else outputText("\nYou tell Ayane you wish to rest for a hour. The devoted priestess assists your recovery by bandaging your wounds and preparing a meditation tea ceremony.\n");
		}
		//Marble withdrawal
		if(player.hasStatusEffect(StatusEffects.MarbleWithdrawl)) {
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
		if (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger < 25)
		{
			outputText("\nYou have difficulty resting as you toss and turn with your stomach growling.\n");
		}
		
		EngineCore.HPChangeNotify(player.HP - hpBefore);
	}
	else {
		clearOutput();
		if(timeQ != 1) outputText("You continue to rest for " + num2Text(timeQ) + " more hours.\n");
		else outputText("You continue to rest for another hour.\n");
	}
	goNext(timeQ,true);
}

//-----------------
//-- WAIT
//-----------------
public function doWaitMenu():void {
	menu();
	addButton(0, "1 Hour", doWait1).hint("Wait one hour.");
	addButton(1, "2 Hours", doWait2).hint("Wait two hours.");
	addButton(2, "4 Hours", doWait4).hint("Wait four hours.");
	addButton(3, "8 Hours", doWait8).hint("Wait eight hours.");
	addButton(4, "Till Dusk", doWaitTillDusk).hint("Wait until the night comes.");
	addButton(14, "Back", playerMenu);
}
public function doWait1():void {
	waitingORresting = 1;
	doWait();
}
public function doWait2():void {
	waitingORresting = 2;
	doWait();
}
public function doWait4():void {
	waitingORresting = 4;
	doWait();
}
public function doWait8():void {
	waitingORresting = 8;
	doWait();
}
public function doWaitTillDusk():void {
	waitingORresting = 21 - model.time.hours;
	doWait();
}
public function doWait():void {
	campQ = true;
	clearOutput();
	//Fatigue recovery
	var fatRecovery:Number = 2;
	if (player.level >= 24) fatRecovery += 1;
	if (player.level >= 42) fatRecovery += 1;
	if (player.findPerk(PerkLib.SpeedyRecovery) >= 0) fatRecovery += 1;
	if (player.findPerk(PerkLib.SpeedyRecuperation) >= 0) fatRecovery += 2;
	if (player.findPerk(PerkLib.SpeedyRejuvenation) >= 0) fatRecovery += 4;
	if (player.findPerk(PerkLib.ControlledBreath) >= 0) fatRecovery *= 1.1;
	if (player.hasStatusEffect(StatusEffects.BathedInHotSpring)) fatRecovery *= 1.2;
	if (timeQ == 0) {
		timeQ = waitingORresting;
		if (player.lowerBody == LowerBody.PLANT_FLOWER) outputText("You lie down in your pitcher, closing off your petals as you get comfortable for " + num2Text(timeQ) + " hours...\n");
		else outputText("You wait " + num2Text(timeQ) + " hours...\n");
		//Marble withdrawl
		if(player.hasStatusEffect(StatusEffects.MarbleWithdrawl)) {
			outputText("\nYour time spent waiting is very troubled, and you aren't able to settle down.  You get up feeling tired and unsatisfied, always thinking of Marble's milk.\n");
			//fatigue
			fatRecovery /= 2;
			fatigue( -fatRecovery * timeQ);
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
			fatigue( -fatRecovery * timeQ);
		}
	}
	else {
		if(timeQ != 1) outputText("You continue to wait for " + num2Text(timeQ) + " more hours.\n");
		else outputText("You continue to wait for another hour.\n");
	}
	goNext(timeQ,true);
}
//-----------------
//-- SLEEP
//-----------------
public function doSleep(clrScreen:Boolean = true):void {
	if (SceneLib.urta.pregnancy.incubation == 0 && SceneLib.urta.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER && model.time.hours >= 20 && model.time.hours < 2) {
		urtaPregs.preggoUrtaGivingBirth();
		return;
	}
	campQ = true;
	if(timeQ == 0) {
		model.time.minutes = 0;
		if(model.time.hours == 21) timeQ = 9;
		if(model.time.hours == 22) timeQ = 8;
		if(model.time.hours >= 23) timeQ = 7;
		if(model.time.hours == 0) timeQ = 6;
		if(model.time.hours == 1) timeQ = 5;
		if(model.time.hours == 2) timeQ = 4;
		if(model.time.hours == 3) timeQ = 3;
		if(model.time.hours == 4) timeQ = 2;
		if(model.time.hours == 5) timeQ = 1;
		if (flags[kFLAGS.BENOIT_CLOCK_ALARM] > 0 && flags[kFLAGS.IN_PRISON] == 0) {
			timeQ += (flags[kFLAGS.BENOIT_CLOCK_ALARM] - 6);
		}
		//Autosave stuff		
		if (player.slotName != "VOID" && player.autoSave && mainView.getButtonText( 0 ) != "Game Over") 
		{
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
			goNext(timeQ, true);
			return;
		}
		/******************************************************************/
		/*       ONE TIME SPECIAL EVENTS                                  */
		/******************************************************************/
		//HEL SLEEPIES!
		if(helFollower.helAffection() >= 70 && flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE] == 0 && flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 0) {
            SceneLib.dungeons.heltower.heliaDiscovery();
            sleepRecovery(false);
			return;
		}
		//Shouldra xgartuan fight
		if(player.hasCock() && followerShouldra() && player.statusEffectv1(StatusEffects.Exgartuan) == 1) {
			if(flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] == 0) {
				shouldraFollower.shouldraAndExgartumonFightGottaCatchEmAll();
				sleepRecovery(false);
				return;
			}
			else if(flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] == 3) {
				shouldraFollower.exgartuMonAndShouldraShowdown();
				sleepRecovery(false);
				return;
			}
		}
		if(player.hasCock() && followerShouldra() && flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] == -0.5) {
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
		/******************************************************************/
		/*       SLEEP WITH SYSTEM GOOOO                                  */
		/******************************************************************/
		if (player.isGargoyle()) {
			outputText("You sit on your pedestal, your body petrifying like stone as you sleep for " + num2Text(timeQ) + " ");
			if(timeQ == 1) outputText("hour.\n");
			else outputText("hours.\n");
		}
		else if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && (flags[kFLAGS.SLEEP_WITH] == "" || flags[kFLAGS.SLEEP_WITH] == "Marble"))
		{
			outputText("You enter your cabin to turn yourself in for the night. ")
		}
		//Marble Sleepies
		if(marbleScene.marbleAtCamp() && player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.SLEEP_WITH] == "Marble" && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) {
			if(marbleScene.marbleNightSleepFlavor()) {
				sleepRecovery(false);
				return;
			}
		}
		else if(flags[kFLAGS.SLEEP_WITH] == "Arian" && arianScene.arianFollower()) {
			arianScene.sleepWithArian();
			return;
		}
		else if(flags[kFLAGS.SLEEP_WITH] == "Excellia" && flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) {
			outputText("When you head to bed for the night, Excellia is already there waiting. You lay down next to her and get comfortable. She wraps her arms around you and pulls you into her warm embrace nuzzling your neck.");
			outputText("\n\n\"<i>See you in the morning [name]...</i>\"\n");
		}
		else if(flags[kFLAGS.SLEEP_WITH] == "Luna" && flags[kFLAGS.LUNA_FOLLOWER] >= 4) {
			outputText("You head to bed, Luna following you. ");
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8 && flags[kFLAGS.LUNA_FOLLOWER] >= 9) {
				SceneLib.lunaFollower.sleepingFullMoon();
				return;
			}
			else outputText("Luna hugs you tightly, almost possessively so as you both doze off to sleep.");
		}
		else if(flags[kFLAGS.SLEEP_WITH] == "Samirah" && flags[kFLAGS.SAMIRAH_FOLLOWER] > 9) {
			outputText("As you both head to sleep, Samirah slithers to you and coils her tail around your legs, wrapping her arms around your torso as she rests her head on your shoulder. Her body is cold and she looks at you as if in a daze.");
			if (player.isNaga()) outputText(" She’s not alone either. It indeed took you a while to realise that you are also cold blooded now. The cold night air sure puts you in a similar state as of late.");
			outputText("\n\n\"<i>Sweet dreams [name], till morning and sunshine come.</i>\"\n");
		}
		else if (flags[kFLAGS.SLEEP_WITH] == "Ember" && flags[kFLAGS.EMBER_AFFECTION] >= 75 && followerEmber()) {
			if (flags[kFLAGS.TIMES_SLEPT_WITH_EMBER] > 3) {
				outputText("You curl up next to Ember, planning to sleep for " + num2Text(timeQ) + " hour. Ember drapes one of " + emberScene.emberMF("his", "her") + " wing over you, keeping you warm.");
			}
			else {
				emberScene.sleepWithEmber();
				return;
			}
		}
		else if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 && jojoScene.pregnancy.isPregnant && jojoScene.pregnancy.event == 4 && player.hasCock() && flags[kFLAGS.SLEEP_WITH] == 0) {
			joyScene.hornyJoyIsPregnant();
			return;
		}
		else if (flags[kFLAGS.SLEEP_WITH] == "Sophie" && (bimboSophie() || sophieFollower()) && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
			//Night Time Snuggle Alerts!*
			//(1) 
			if(rand(4) == 0) {
				outputText("You curl up next to Sophie, planning to sleep for " + num2Text(timeQ) + " hour");
				if(timeQ > 1 ) outputText("s");
				outputText(".  She wraps her feathery arms around you and nestles her chin into your shoulder.  Her heavy breasts cushion flat against your back as she gives you a rather chaste peck on the cheek and drifts off towards dreamland...");
			}
			//(2) 
			else if(rand(3) == 0) {
				outputText("While you're getting ready for bed, you see that Sophie has already beaten you there.  She's sprawled out on her back with her arms outstretched, making little beckoning motions towards the valley of her cleavage.  You snuggle in against her, her pillowy breasts supporting your head and her familiar heartbeat drumming you to sleep for " + num2Text(timeQ) + " hour");
				if(timeQ > 1) outputText("s");
				outputText(".");
			}
			//(3)
			else if(rand(2) == 0) {
				outputText("As you lay down to sleep for " + num2Text(timeQ) + " hour");
				if(timeQ > 1) outputText("s");
				outputText(", you find the harpy-girl, Sophie, snuggling herself under her blankets with you.  She slips in between your arms and guides your hands to her enormous breasts, her backside already snug against your loins.  She whispers, \"<i>Something to think about for next morning...  Sweet dreams.</i>\" as she settles in for the night.");
			}
			//(4)
			else {
				outputText("Sophie climbs under the sheets with you when you go to sleep, planning on resting for " + num2Text(timeQ) + " hour");
				if(timeQ > 1) outputText("s");
				outputText(".  She sleeps next to you, just barely touching you.  You rub her shoulder affectionately before the two of you nod off.");
			}
			outputText("\n");
		}
		else {
			if(flags[kFLAGS.SLEEP_WITH] == "Helia" && SceneLib.helScene.followerHel()) {
				outputText("You curl up next to Helia, planning to sleep for " + num2Text(timeQ) + " ");
			}
			//Normal sleep message
			else outputText("You curl up, planning to sleep for " + num2Text(timeQ) + " ");
			if(timeQ == 1) outputText("hour.\n");
			else outputText("hours.\n");
		}
		sleepRecovery(true);
	}
	else {
		clearOutput();
		if(timeQ != 1) outputText("You lie down to resume sleeping for the remaining " + num2Text(timeQ) + " hours.\n");
		else outputText("You lie down to resume sleeping for the remaining hour.\n");
	}
	goNext(timeQ, true);
}
//For shit that breaks normal sleep processing.
public function sleepWrapper():void {
	if(model.time.hours == 16) timeQ = 14;
	if(model.time.hours == 17) timeQ = 13;
	if(model.time.hours == 18) timeQ = 12;
	if(model.time.hours == 19) timeQ = 11;
	if(model.time.hours == 20) timeQ = 10;
	if(model.time.hours == 21) timeQ = 9;
	if(model.time.hours == 22) timeQ = 8;
	if(model.time.hours >= 23) timeQ = 7;
	if(model.time.hours == 0) timeQ = 6;
	if(model.time.hours == 1) timeQ = 5;
	if(model.time.hours == 2) timeQ = 4;
	if(model.time.hours == 3) timeQ = 3;
	if(model.time.hours == 4) timeQ = 2;
	if(model.time.hours == 5) timeQ = 1;
	if (flags[kFLAGS.BENOIT_CLOCK_ALARM] > 0 && (flags[kFLAGS.SLEEP_WITH] == "Ember" || flags[kFLAGS.SLEEP_WITH] == 0)) timeQ += (flags[kFLAGS.BENOIT_CLOCK_ALARM] - 6);
	clearOutput();
	clearOutput();
	if(timeQ != 1) outputText("You lie down to resume sleeping for the remaining " + num2Text(timeQ) + " hours.\n");
	else outputText("You lie down to resume sleeping for the remaining hour.\n");
	sleepRecovery(true);
	goNext(timeQ, true);
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
	if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && (flags[kFLAGS.SLEEP_WITH] == "" || flags[kFLAGS.SLEEP_WITH] == "Marble"))
	{
		multiplier += 0.5;
	}
	if (player.findPerk(PerkLib.SpeedyRecovery) >= 0) fatRecovery += 5;
	if (player.findPerk(PerkLib.SpeedyRecuperation) >= 0) fatRecovery += 10;
	if (player.findPerk(PerkLib.SpeedyRejuvenation) >= 0) fatRecovery += 20;
	if (player.findPerk(PerkLib.ControlledBreath) >= 0) fatRecovery *= 1.1;
	if (player.hasStatusEffect(StatusEffects.BathedInHotSpring)) fatRecovery *= 1.2;
	if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) fatRecovery *= 3;
	if (player.findPerk(PerkLib.RecuperationSleep) >= 0) multiplier += 1;
	if (player.findPerk(PerkLib.RejuvenationSleep) >= 0) multiplier += 2;
	if (flags[kFLAGS.HUNGER_ENABLED] > 0)
	{
		if (player.hunger < 25)
		{
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
	if(player.hasStatusEffect(StatusEffects.MarbleWithdrawl)) {
		if(display) outputText("\nYour sleep is very troubled, and you aren't able to settle down.  You get up feeling tired and unsatisfied, always thinking of Marble's milk.\n");
		multiplier *= 0.5;
		dynStats("tou", -.1, "int", -.1);
	}
	//Mino withdrawal
	else if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) {
		if(display) outputText("\nYou spend much of the night tossing and turning, aching for a taste of minotaur cum.\n");
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
	}
	else if (player.hasStatusEffect(StatusEffects.CampRathazul)) {
		outputText("\n\nYou could call for Rathazul to help you.");
		addButton(2, "Rathazul", callRathazulAndEscapeBadEnd);		
	}
	else EventParser.gameOver();
}
private function applyReductoAndEscapeBadEnd():void {
	clearOutput();
	outputText("You smear the foul-smelling paste onto your " + sackDescript() + ".  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n");
	player.ballSize -= (4 + rand(6));
	if (player.ballSize > 18 + (player.str / 2) + (player.tallness / 4)) player.ballSize = 17 + (player.str / 2) + (player.tallness / 4);
	if (player.ballSize < 1) player.ballSize = 1;
	outputText("You feel your scrotum shift, shrinking down along with your [balls].  ");
	outputText("Within a few seconds the paste has been totally absorbed and the shrinking stops.  ");
	dynStats("lib", -2, "lus", -10);
	player.consumeItem(consumables.REDUCTO, 1);
	doNext(camp.returnToCampUseOneHour);
}
private function callRathazulAndEscapeBadEnd():void {
	clearOutput();
	outputText("You shout as loud as you can to call Rathazul.  Your call is answered as the alchemist walks up to you.\n\n");
	outputText("\"<i>My, my... Look at yourself! Don't worry, I can help, </i>\" he says.  He rushes to his alchemy equipment and mixes ingredients.  He returns to you with a Reducto.\n\n");
	outputText("He rubs the paste all over your massive balls. It's incredibly effective. \n\n");
	player.ballSize -= (4 + rand(6));
	if (player.ballSize > 18 + (player.str/2) + (player.tallness / 4)) player.ballSize = 16 + (player.str/2) + (player.tallness / 4);
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
		}
		else {
			outputText("Your fellow companion mourns over your passing.");
		}
	}
	player.HP = 0;
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
	spriteSelect(23);
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
	if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0) return true;
	if (flags[kFLAGS.FACTORY_FOUND] > 0) return true;
	if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0) return true;
	if (flags[kFLAGS.D3_DISCOVERED] > 0) return true;
	if (SceneLib.dungeons.checkPhoenixTowerClear()) return true;
	if (flags[kFLAGS.HIDDEN_CAVE_FOUND] > 0) return true;
	if (flags[kFLAGS.DEN_OF_DESIRE_BOSSES] > 0) return true;
	if (flags[kFLAGS.LUMI_MET] > 0)  return true;
	if (flags[kFLAGS.ANZU_PALACE_UNLOCKED] > 0)  return true;
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
	if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] > 0) places++;
	if (flags[kFLAGS.YU_SHOP] == 2) places++;
	if (flags[kFLAGS.PRISON_CAPTURE_COUNTER] > 0) places++;
	if (player.hasStatusEffect(StatusEffects.ResourceNode1)) {
		if (player.statusEffectv1(StatusEffects.ResourceNode1) >= 5) places++;
		if (player.statusEffectv2(StatusEffects.ResourceNode1) >= 5) places++;
	}
	return places;
}

//All cleaned up!
public function places():Boolean {
	hideMenus();
	clearOutput();
	outputText("Which place would you like to visit?");
	if (flags[kFLAGS.PLACES_PAGE] == 1) placesPage2();
	if (flags[kFLAGS.PLACES_PAGE] == 2) placesPage3();
	//Build menu
	menu();
	if (dungeonFound()) addButton(0, "Dungeons", dungeons).hint("Delve into dungeons.");
	if (player.hasStatusEffect(StatusEffects.BoatDiscovery)) addButton(3, "Boat", SceneLib.boat.boatExplore).hint("Get on the boat and explore the lake. \n\nRecommended level: 12");
	
	if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) addButton(5, "Tel'Adre", SceneLib.telAdre.telAdreMenu).hint("Visit the city of Tel'Adre in desert, easily recognized by the massive tower.");
	if (flags[kFLAGS.BAZAAR_ENTERED] > 0) addButton(6, "Bazaar", SceneLib.bazaar.enterTheBazaar).hint("Visit the Bizarre Bazaar where the demons and corrupted beings hang out.");
	if (flags[kFLAGS.OWCA_UNLOCKED] == 1) addButton(7, "Owca", SceneLib.owca.gangbangVillageStuff).hint("Visit the sheep village of Owca, known for its pit where a person is hung on the pole weekly to be gang-raped by the demons.");
	if (flags[kFLAGS.HEXINDAO_UNLOCKED] == 1) addButton(10, "He'Xin'Dao", hexindao.riverislandVillageStuff0).hint("Visit the village of He'Xin'Dao, place where all greenhorn soul cultivators come together.");
	addButton(4, "Next", placesPage2);
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
	if (farmFound()) addButton(1, "Farm", SceneLib.farm.farmExploreEncounter).hint("Visit Whitney's farm.");
	if (flags[kFLAGS.AMILY_VILLAGE_ACCESSIBLE] > 0) addButton(2, "Town Ruins", SceneLib.amilyScene.exploreVillageRuin).hint("Visit the village ruins. \n\nRecommended level: 12");
	if (player.hasStatusEffect(StatusEffects.HairdresserMeeting)) addButton(3, "Salon", SceneLib.mountain.salon.salonGreeting).hint("Visit the salon for hair services.");

	if (flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED] > 0) addButton(5, "Shrine", SceneLib.kitsuneScene.kitsuneShrine).hint("Visit the kitsune shrine in the deepwoods.");
	if (flags[kFLAGS.MET_MINERVA] >= 4) addButton(6, "Oasis Tower", SceneLib.highMountains.minervaScene.encounterMinerva).hint("Visit the ruined tower in the high mountains where Minerva resides.");
	if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] > 0) addButton(7, "Temple", templeofdivine.repeatvisitintro).hint("Visit the temple in the high mountains where Sapphire resides.");
	if (flags[kFLAGS.YU_SHOP] == 2) addButton(8, "Winter Gear", SceneLib.glacialYuShop.YuIntro).hint("Visit the Winter gear shop.");
	
	if (flags[kFLAGS.AIKO_TIMES_MET] > 3) addButton(10, "Great Tree", SceneLib.aikoScene.encounterAiko).hint("Visit the Great Tree in the Deep Woods where Aiko lives.");
//	if (flags[kFLAGS.PRISON_CAPTURE_COUNTER] > 0) addButton(12, "Prison", CoC.instance.prison.prisonIntro, false, null, null, "Return to the prison and continue your life as Elly's slave.");
	if (debug) addButton(13, "Ingnam", SceneLib.ingnam.returnToIngnam).hint("Return to Ingnam for debugging purposes. Night-time event weirdness might occur. You have been warned!");
	addButton(4, "Next", placesPage3);
	addButton(9, "Previous", placesToPage1);
	addButton(14, "Back", playerMenu);
}
private function placesPage3():void {
	menu();
	flags[kFLAGS.PLACES_PAGE] = 2;
	if (player.hasStatusEffect(StatusEffects.ResourceNode1)) {
		if (player.statusEffectv1(StatusEffects.ResourceNode1) < 5) addButtonDisabled(0, "???", "You need to explore Forest more to unlock this place.");
		else addButton(0, "Woodcutting", camp.cabinProgress.gatherWoods);
		if (player.statusEffectv2(StatusEffects.ResourceNode1) < 5) addButtonDisabled(1, "???", "You need to explore Mountains more to unlock this place.");
		else addButton(1, "Quarry", camp.cabinProgress.quarrySite);
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
	places();
}

private function dungeons():void {
	menu();
	//Turn on dungeon 1
	if (flags[kFLAGS.FACTORY_FOUND] > 0) addButton(0, "Factory", dungeon1.enterDungeon).hint("Visit the demonic factory in the mountains." + (flags[kFLAGS.FACTORY_SHUTDOWN] > 0 ? "\n\nYou've managed to shut down the factory." : "The factory is still running. Marae wants you to shut down the factory!") + (SceneLib.dungeons.checkFactoryClear() ? "\n\nCLEARED!" : ""));
	//Turn on dungeon 2
	if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0) addButton(1, "Deep Cave", dungeon2.enterDungeon).hint("Visit the cave you've found in the Deepwoods." + (flags[kFLAGS.DEFEATED_ZETAZ] > 0 ? "\n\nYou've defeated Zetaz, your old rival." : "") + (SceneLib.dungeons.checkDeepCaveClear() ? "\n\nCLEARED!" : ""));
	//Turn on dungeon 3
	if (flags[kFLAGS.D3_DISCOVERED] > 0) addButton(2, "Stronghold", SceneLib.d3.enterD3).hint("Visit the stronghold in the high mountains that belongs to Lethice, the demon queen." + ((flags[kFLAGS.LETHICE_DEFEATED] > 0) ? "\n\nYou have slain Lethice and put an end to the demonic threats. Congratulations, you've beaten the main story!" : "") + (SceneLib.dungeons.checkLethiceStrongholdClear() ? "\n\nCLEARED!" : ""));
	//Side dungeons
	if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0) addButton(5, "Desert Cave", dungeonS.enterDungeon).hint("Visit the cave you've found in the desert." + (flags[kFLAGS.SAND_WITCHES_COWED] + flags[kFLAGS.SAND_WITCHES_FRIENDLY] > 0 ? "\n\nFrom what you've known, this is the source of the Sand Witches." : "") + (SceneLib.dungeons.checkSandCaveClear() ? "\n\nCLEARED!" : ""));
	if (SceneLib.dungeons.checkPhoenixTowerClear()) addButton(6, "Phoenix Tower", dungeonH.returnToHeliaDungeon).hint("Re-visit the tower you went there as part of Helia's quest." + (SceneLib.dungeons.checkPhoenixTowerClear() ? "\n\nYou've helped Helia in the quest and resolved the problems. \n\nCLEARED!" : ""));
	if (flags[kFLAGS.EBON_LABYRINTH] > 0) addButton(9, "EbonLabyrinth", dungeonEL.enterDungeon).hint("Visit Ebon Labyrinth." + (SceneLib.dungeons.checkEbonLabyrinthClear() ? "\n\nSEMI-CLEARED!" : ""));
	if (flags[kFLAGS.HIDDEN_CAVE_FOUND] > 0) addButton(10, "Hidden Cave", dungeonHC.enterDungeon).hint("Visit the hidden cave in the hills." + (SceneLib.dungeons.checkHiddenCaveClear() ? "\n\nCLEARED!" : ""));
	if (flags[kFLAGS.DEN_OF_DESIRE_BOSSES] > 0) addButton(11, "Den of Desire", dungeonDD.enterDungeon).hint("Visit the den in blight ridge." + (SceneLib.dungeons.checkDenOfDesireClear() ? "\n\nCLEARED!" : ""));
	if (flags[kFLAGS.LUMI_MET] > 0) addButton(12, "Lumi's Lab", SceneLib.lumi.lumiEncounter).hint("Visit Lumi's laboratory.");
	if (flags[kFLAGS.ANZU_PALACE_UNLOCKED] > 0) addButton(13, "Anzu's Palace", dungeonAP.enterDungeon).hint("Visit the palace in the Glacial Rift where Anzu the avian deity resides.");
	addButton(14, "Back", places);
}

private function exgartuanCampUpdate():void {
	//Update Exgartuan stuff
	if(player.hasStatusEffect(StatusEffects.Exgartuan))
	{
		trace("EXGARTUAN V1: " + player.statusEffectv1(StatusEffects.Exgartuan) + " V2: " + player.statusEffectv2(StatusEffects.Exgartuan));
		//if too small dick, remove him
		if(player.statusEffectv1(StatusEffects.Exgartuan) == 1 && (player.cockArea(0) < 100 || player.cocks.length == 0))
		{
			clearOutput();
			outputText("<b>You suddenly feel the urge to urinate, and stop over by some bushes.  It takes wayyyy longer than normal, and once you've finished, you realize you're alone with yourself for the first time in a long time.");
			if(player.hasCock()) outputText("  Perhaps you got too small for Exgartuan to handle?</b>\n");
			else outputText("  It looks like the demon didn't want to stick around without your manhood.</b>\n");
			player.removeStatusEffect(StatusEffects.Exgartuan);
			awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, true);
		}
		//Tit removal
		else if(player.statusEffectv1(StatusEffects.Exgartuan) == 2 && player.biggestTitSize() < 12)
		{
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
	model.time.days++;
	if (flags[kFLAGS.BENOIT_CLOCK_BOUGHT] > 0) model.time.hours = flags[kFLAGS.BENOIT_CLOCK_ALARM];
	else model.time.hours = 6;
	//Set so you're in camp.
	DungeonAbstractContent.inDungeon = false;
	inRoomedDungeon = false;
	inRoomedDungeonResume = null;
    CoC.instance.inCombat = false;
    //Restore stats
	player.HP = player.maxHP();
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
	//Deduct attributes.
	if (player.str > 20) dynStats("str", Math.ceil(-player.str * 0.02) * penaltyMultiplier);
	if (player.tou > 20) dynStats("tou", Math.ceil(-player.tou * 0.02) * penaltyMultiplier);
	if (player.spe > 20) dynStats("spe", Math.ceil(-player.spe * 0.02) * penaltyMultiplier);
	if (player.inte > 20) dynStats("inte", Math.ceil(-player.inte * 0.02) * penaltyMultiplier);
	if (player.wis > 20) dynStats("wis", Math.ceil(-player.wis * 0.02) * penaltyMultiplier);
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
	}
	else {
		outputText("You can continue work on building the wall that surrounds your [camp].\n\n");
		outputText("Segments complete: " + Math.floor(flags[kFLAGS.CAMP_WALL_PROGRESS] / 10) + "/10\n");
	}
	SceneLib.camp.cabinProgress.checkMaterials();
	outputText("\n\nIt will cost 80 nails, 80 wood and 10 stones to work on a segment of the wall.\n\n");
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 80 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 80) {
		doYesNo(buildCampWall, doCamp);
	}
	else {
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
	}
	else {
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
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 15) fatigueAmount = 15;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only one hour!");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only two hours.");
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
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
	}
	else {
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
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
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
	}
	else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 14 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 20) {
		outputText("There is no room; you have already hung a total of 14 imp skulls! To add more you need to build next segment of the wall.");
		doNext(doCamp);
		return;
	}
	else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 22 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 30) {
		outputText("There is no room; you have already hung a total of 22 imp skulls! To add more you need to build next segment of the wall.");
		doNext(doCamp);
		return;
	}
	else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 30 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 40) {
		outputText("There is no room; you have already hung a total of 30 imp skulls! To add more you need to build next segment of the wall.");
		doNext(doCamp);
		return;
	}
	else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 39 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 50) {
		outputText("There is no room; you have already hung a total of 39 imp skulls! To add more you need to build next segment of the wall.");
		doNext(doCamp);
		return;
	}
	else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 50 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 60) {
		outputText("There is no room; you have already hung a total of 50 imp skulls! To add more you need to build next segment of the wall.");
		doNext(doCamp);
		return;
	}
	else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 62 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 70) {
		outputText("There is no room; you have already hung a total of 62 imp skulls! To add more you need to build next segment of the wall.");
		doNext(doCamp);
		return;
	}
	else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 74 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 80) {
		outputText("There is no room; you have already hung a total of 74 imp skulls! To add more you need to build next segment of the wall.");
		doNext(doCamp);
		return;
	}
	else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 86 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 90) {
		outputText("There is no room; you have already hung a total of 86 imp skulls! To add more you need to build next segment of the wall.");
		doNext(doCamp);
		return;
	}
	else if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 100 && flags[kFLAGS.CAMP_WALL_PROGRESS] == 100) {
		outputText("There is no room; you have already hung a total of 100 imp skulls! No imp shall dare approaching you at night!");
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
	}
	else {
		textToChoose = "tent";
	}
	return textToChoose;
}

public function bedDesc():String {
	var textToChoose:String;
	if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0) {
		textToChoose = "bed";
	}
	else {
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
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 2 || flags[kFLAGS.CHI_CHI_FOLLOWER] == 5) performancePointsPrediction++;
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
	//Quests
	if (flags[kFLAGS.MARBLE_PURIFIED] > 0) performancePointsPrediction += 2;
	if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] >= 10) performancePointsPrediction += 2;
	if (flags[kFLAGS.URTA_QUEST_STATUS] > 0) performancePointsPrediction += 2;
	if (player.findPerk(PerkLib.Enlightened) >= 0) performancePointsPrediction += 1;
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
	//Children
	var childPerformance:int = 0;
	childPerformance += (flags[kFLAGS.MINERVA_CHILDREN] + flags[kFLAGS.BEHEMOTH_CHILDREN] + flags[kFLAGS.MARBLE_KIDS] + (flags[kFLAGS.SHEILA_JOEYS] + flags[kFLAGS.SHEILA_IMPS]) + izmaScene.totalIzmaChildren() + isabellaScene.totalIsabellaChildren() + kihaFollower.totalKihaChildren() + emberScene.emberChildren() + urtaPregs.urtaKids() + sophieBimbo.sophieChildren());
	childPerformance += (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] + flags[kFLAGS.KELLY_KIDS] + flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] + flags[kFLAGS.COTTON_KID_COUNT] + flags[kFLAGS.AMILY_BIRTH_TOTAL] + flags[kFLAGS.PC_TIMES_BIRTHED_AMILYKIDS] + joyScene.getTotalLitters() + SceneLib.excelliaFollower.totalExcelliaChildren());
	childPerformance += ((flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 4) + (flags[kFLAGS.LYNNETTE_BABY_COUNT] / 4) + (flags[kFLAGS.ANT_KIDS] / 100) + (flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] / 4) + (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] / 4) + (flags[kFLAGS.MITZI_DAUGHTERS] / 4));
	performancePointsPrediction += Math.sqrt(childPerformance);
	//Level
	performancePointsPrediction += player.level;
	performancePointsPrediction = Math.round(performancePointsPrediction);
	return performancePointsPrediction;
}

public function setLevelButton(allowAutoLevelTransition:Boolean):Boolean {
	var levelup:Boolean = player.XP >= player.requiredXP() && player.level < CoC.instance.levelCap;
	if (levelup || player.perkPoints > 0 || player.statPoints > 0) {
		if (!levelup) {
			if (player.statPoints > 0) {
				mainView.setMenuButton( MainView.MENU_LEVEL, "Stat Up" );
				mainView.levelButton.toolTipText = "Distribute your stats points. \n\nYou currently have " + String(player.statPoints) + ".";
			}
			else {
				mainView.setMenuButton( MainView.MENU_LEVEL, "Perk Up" );
				mainView.levelButton.toolTipText = "Spend your perk points on a new perk. \n\nYou currently have " + String(player.perkPoints) + ".";
			}
		}
		else {
			mainView.setMenuButton( MainView.MENU_LEVEL, "Level Up" );
			var hp:int = 15;
			var fatigue:int = 5;
			var mana:int = 10;
			var soulforce:int = 0;
			var wrath:int = 0;
			var lust:int = 0;
			var statpoints:int = 5;
			var perkpoints:int = 1;
			if (player.findPerk(PerkLib.AscensionUnlockedPotential) >= 0) {
				hp += 20;
				lust += 2;
				fatigue += 6;
			}
			if (player.findPerk(PerkLib.AscensionUnlockedPotential2ndStage) >= 0) {
				wrath += 2;
				mana += 12;
				soulforce += 6;
			}
			if (player.findPerk(PerkLib.UnlockBody) >= 0) hp += 15;
			if (player.findPerk(PerkLib.UnlockBody2ndStage) >= 0) hp += 15;
			if (player.findPerk(PerkLib.UnlockBody3rdStage) >= 0) hp += 15;
			if (player.findPerk(PerkLib.UnlockBody4thStage) >= 0) hp += 15;
			if (player.findPerk(PerkLib.UnlockEndurance) >= 0) fatigue += 5;
			if (player.findPerk(PerkLib.UnlockEndurance2ndStage) >= 0) fatigue += 5;
			if (player.findPerk(PerkLib.UnlockEndurance3rdStage) >= 0) fatigue += 5;
			if (player.findPerk(PerkLib.UnlockEndurance4thStage) >= 0) fatigue += 5;
			if (player.findPerk(PerkLib.UnlockForce) >= 0) mana += 10;
			if (player.findPerk(PerkLib.UnlockForce2ndStage) >= 0) mana += 10;
			if (player.findPerk(PerkLib.UnlockForce3rdStage) >= 0) mana += 10;
			if (player.findPerk(PerkLib.UnlockForce4thStage) >= 0) mana += 10;
			if (player.findPerk(PerkLib.UnlockSpirit) >= 0) soulforce += 5;
			if (player.findPerk(PerkLib.UnlockSpirit2ndStage) >= 0) soulforce += 5;
			if (player.findPerk(PerkLib.UnlockSpirit3rdStage) >= 0) soulforce += 5;
			if (player.findPerk(PerkLib.UnlockSpirit4thStage) >= 0) soulforce += 5;
			if (player.findPerk(PerkLib.UnlockId) >= 0) wrath += 1;
			if (player.findPerk(PerkLib.UnlockId2ndStage) >= 0) wrath += 1;
			if (player.findPerk(PerkLib.UnlockId3rdStage) >= 0) wrath += 1;
			if (player.findPerk(PerkLib.UnlockId4thStage) >= 0) wrath += 1;
			if (player.findPerk(PerkLib.UnlockArdor) >= 0) lust += 1;
			if (player.findPerk(PerkLib.UnlockArdor2ndStage) >= 0) lust += 1;
			if (player.findPerk(PerkLib.UnlockArdor3rdStage) >= 0) lust += 1;
			if (player.findPerk(PerkLib.UnlockArdor4thStage) >= 0) lust += 1;
			if (player.level < 6) {
				statpoints += 5;
				perkpoints += 1;
			}
			mainView.levelButton.toolTipText = "Level up to increase your maximum HP by " + hp + ", maximum Fatigue by " + fatigue + ", maximum Mana by " + mana + ", maximum Soulforce by " + soulforce + ", maximum Wrath by " + wrath + " and maximum Lust by " + lust + "; gain " + statpoints + " attribute points and " + perkpoints + " perk points.";
			if (flags[kFLAGS.AUTO_LEVEL] > 0 && allowAutoLevelTransition) {
                CoC.instance.playerInfo.levelUpGo();
                return true; //True indicates that you should be routed to level-up.
			}
			
		}
		mainView.showMenuButton( MainView.MENU_LEVEL );
		mainView.statsView.showLevelUp();
		if (player.str >= player.getMaxStats("str") && player.tou >= player.getMaxStats("tou") && player.inte >= player.getMaxStats("int") && player.spe >= player.getMaxStats("spe") && (player.perkPoints <= 0 || PerkTree.availablePerks(CoC.instance.player).length <= 0) && (player.XP < player.requiredXP() || player.level >= CoC.instance.levelCap)) {
			mainView.statsView.hideLevelUp();
		}
	}
	else {
		mainView.hideMenuButton( MainView.MENU_LEVEL );
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
	if (player.armorName == "goo armor") pop++; //Include Valeria if you're wearing her.
	if (flags[kFLAGS.CLARA_IMPRISONED] > 0) pop++;
	//------------
	//Children check!
	//Followers
	if (followerEmber() && emberScene.emberChildren() > 0) pop += emberScene.emberChildren();
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

private function fixFlags():void {
	//Marae
	if (player.hasStatusEffect(StatusEffects.MetMarae)) {
		flags[kFLAGS.MET_MARAE] = 1;
		player.removeStatusEffect(StatusEffects.MetMarae);
	}
	if (player.hasStatusEffect(StatusEffects.MaraesQuestStart)) {
		flags[kFLAGS.MARAE_QUEST_START] = 1;
		player.removeStatusEffect(StatusEffects.MaraesQuestStart);
	}
	if (player.hasStatusEffect(StatusEffects.MaraeComplete)) {
		flags[kFLAGS.MARAE_QUEST_COMPLETE] = 1;
		player.removeStatusEffect(StatusEffects.MaraeComplete);
	}
	if (player.hasStatusEffect(StatusEffects.MaraesLethicite)) {
		player.createKeyItem("Marae's Lethicite", 3, 0, 0, 0);
		player.removeStatusEffect(StatusEffects.MaraesLethicite);
	}
	//Factory Demons
	if (player.hasStatusEffect(StatusEffects.FactorySuccubusDefeated)) {
		flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED] = 1;
		player.removeStatusEffect(StatusEffects.FactorySuccubusDefeated);
	}
	if (player.hasStatusEffect(StatusEffects.FactoryIncubusDefeated)) {
		flags[kFLAGS.FACTORY_INCUBUS_DEFEATED] = 1;
		player.removeStatusEffect(StatusEffects.FactoryIncubusDefeated);
	}
	if (player.hasStatusEffect(StatusEffects.FactoryOmnibusDefeated)) {
		flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] = 1;
		player.removeStatusEffect(StatusEffects.FactoryOmnibusDefeated);
	}
	//Factory Variables
	if (player.hasStatusEffect(StatusEffects.FoundFactory)) {
		flags[kFLAGS.FACTORY_FOUND] = 1;
		player.removeStatusEffect(StatusEffects.FoundFactory);
	}
	if (player.hasStatusEffect(StatusEffects.IncubusBribed)) {
		flags[kFLAGS.FACTORY_INCUBUS_BRIBED] = 1;
		player.removeStatusEffect(StatusEffects.IncubusBribed);
	}
	if (player.hasStatusEffect(StatusEffects.DungeonShutDown)) {
		flags[kFLAGS.FACTORY_SHUTDOWN] = 1;
		player.removeStatusEffect(StatusEffects.DungeonShutDown);
	}
	if (player.hasStatusEffect(StatusEffects.FactoryOverload)) {
		flags[kFLAGS.FACTORY_SHUTDOWN] = 2;
		player.removeStatusEffect(StatusEffects.FactoryOverload);
	}
	if (player.hasStatusEffect(StatusEffects.TakenLactaid)) {
		flags[kFLAGS.FACTORY_TAKEN_LACTAID] = 5 - (player.statusEffectv1(StatusEffects.TakenLactaid));
		player.removeStatusEffect(StatusEffects.TakenLactaid);
	}
	if (player.hasStatusEffect(StatusEffects.TakenGroPlus)) {
		flags[kFLAGS.FACTORY_TAKEN_GROPLUS] = 5 - (player.statusEffectv1(StatusEffects.TakenGroPlus));
		player.removeStatusEffect(StatusEffects.TakenGroPlus);
	}
	if (SceneLib.dungeons.checkPhoenixTowerClear() && flags[kFLAGS.CLEARED_HEL_TOWER] < 2) flags[kFLAGS.CLEARED_HEL_TOWER] = 1;
}
private function promptSaveUpdate():void {
	clearOutput();
	if (flags[kFLAGS.MOD_SAVE_VERSION] < 2) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 2;
		outputText("<b><u>CAUTION</u></b>\n");
		outputText("Looks like you are importing your save from vanilla CoC.");
		outputText("\n\nIf you're planning to save over your original save file, I not going to stop you but... If you overwrite the save file from original game, it will no longer be backwards compatible with the original CoC. So maybe create separate save files.");
		outputText("\n\nWithout sound any more cranky, enjoy everything CoC Wuxia Mod has to offer!");
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 2) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 3;
		outputText("Ups looks like you not have achievements feature unlocked yet. So now you can get them.");
		outputText("\n\nDrill is as always. So not all achievements would be automaticaly gained but who of people playing this won't play again and again and...you get my drift right?");
		updateAchievements();
		outputText("\n\nAchievements are saved in a special savefile so no matter what savefile you're on, any earned achievements will be added to that special savefile. And now got catch them all traine...burp I mean fellow players ^^");
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 3) {
		//Reclaim flags for future use.
		flags[kFLAGS.GIACOMO_MET] = 0;
		flags[kFLAGS.GIACOMO_NOTICES_WORMS] = 0;
		flags[kFLAGS.PHOENIX_ENCOUNTERED] = 0;
		flags[kFLAGS.PHOENIX_WANKED_COUNTER] = 0;
		flags[kFLAGS.MOD_SAVE_VERSION] = 4;
		doCamp();
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 4) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 5;
		if (flags[kFLAGS.KELT_KILLED] > 0 && player.statusEffectv1(StatusEffects.Kelt) <= 0) {
			clearOutput();
			outputText("Due to a bug where your bow skill got reset after you've slain Kelt, your bow skill got reset. Fortunately, this is now fixed. As a compensation, your bow skill is now instantly set to 100!");
			if (player.statusEffectv1(StatusEffects.Kelt) <= 0) player.createStatusEffect(StatusEffects.Kelt, 100, 0, 0, 0);
			doNext(doCamp);
			return;
		}
		doCamp();
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 5) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 6;
		if (player.armorName == "revealing fur loincloths" || player.armorName == "comfortable underclothes" || player.weaponName == "dragon-shell shield") {
			clearOutput();
			outputText("Due to a bit of restructing regarding equipment, any reclassified equipment (eggshell shield and fur loincloth) that was equipped are now unequipped.");
			if (player.armorName == "comfortable underclothes") player.setArmor(ArmorLib.NOTHING);
			if (player.armorName == "revealing fur loincloths") inventory.takeItem(player.setArmor(ArmorLib.COMFORTABLE_UNDERCLOTHES), promptSaveUpdate);
			if (player.weaponName == "dragon-shell shield") inventory.takeItem(player.setWeapon(WeaponLib.FISTS), promptSaveUpdate);			
			doNext(doCamp);
			return;
		}
		doCamp();
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 6) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 7;
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 6) {
			flags[kFLAGS.D1_OMNIBUS_KILLED] = flags[kFLAGS.CORRUPTED_GLADES_DESTROYED];
			flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] = 0; //Reclaimed
		}
		if (player.armor == armors.GOOARMR) flags[kFLAGS.VALERIA_FLUIDS] = 100;
		doCamp();
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 7) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 8;
		//Move and reclaim flag.
		flags[kFLAGS.LETHICITE_ARMOR_TAKEN] = flags[kFLAGS.JOJO_ANAL_CATCH_COUNTER];
		flags[kFLAGS.JOJO_ANAL_CATCH_COUNTER] = 0;
		doCamp();
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 8) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 9;
		if (!player.hasFur()) {
			doCamp();
			return; //No fur? Return to camp.
		}
		//Update fur
		clearOutput();
		outputText("You did it again don't ya? You went and get fur and now we got trouble to solve...err ok joking just fast pick color for your new shiny fur and nobody would notice ^^");
		furColorSelection1();
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 9) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 10;
		if (flags[kFLAGS.MARAE_LETHICITE] > 0 && player.hasKeyItem("Marae's Lethicite") >= 0) {
			player.removeKeyItem("Marae's Lethicite"); //Remove the old.
			player.createKeyItem("Marae's Lethicite", flags[kFLAGS.MARAE_LETHICITE], 0, 0, 0);
			flags[kFLAGS.MARAE_LETHICITE] = 0; //Reclaim the flag.
		}
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 10) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 11;
		if (player.findPerk(PerkLib.JobMonk) >= 0) {
			player.removePerk(PerkLib.JobMonk);
			player.createPerk(PerkLib.JobBrawler, 0, 0, 0, 0);
		}
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 11) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 12;
		outputText("No worry it's not a bug it's an airplan...err ok your save is just upgraded to the next level ^^");
		if (flags[kFLAGS.EVANGELINE_GEMS_PURSE] < 0) flags[kFLAGS.EVANGELINE_GEMS_PURSE] = 0;
		if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] < 0) flags[kFLAGS.EVANGELINE_SPELLS_CASTED] = 0;
		if (flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] < 0) flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] = 0;
		if (flags[kFLAGS.CAMP_CABIN_PROGRESS] > 5) flags[kFLAGS.CAMP_CABIN_PROGRESS] -= 2;
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 12) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 13;
		clearOutput();
		outputText("And we do it again since game got more shiny then before so we would fast give additional polishing to your save. No worry it will be now +20% more shiny ;)");
		if (player.findPerk(PerkLib.JobSoulCultivator) < 0) player.perkPoints += 1;
		var refund:int = 0;
		if (player.perkv1(PerkLib.AscensionTolerance) > 10) {
			refund += player.perkv1(PerkLib.AscensionTolerance) - 10;
			player.setPerkValue(PerkLib.AscensionTolerance,1,10);
			player.ascensionPerkPoints += refund;
		}
		if (player.findPerk(PerkLib.JobArcher) >= 0) {
			player.removePerk(PerkLib.JobArcher);
			player.createPerk(PerkLib.JobRanger, 0, 0, 0, 0);
		}
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 13) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 14;
		clearOutput();
		outputText("Attention! All Munchkins Kindly leave thou gate sixty and nine. As replacements there will be whole legion of All-Rounders commin in five, four, ...........aaaand they're here ^^");
		if (player.findPerk(PerkLib.DeityJobMunchkin) >= 0) {
			player.removePerk(PerkLib.DeityJobMunchkin);
			player.createPerk(PerkLib.JobAllRounder, 0, 0, 0, 0);
		}
		if (flags[kFLAGS.EVANGELINE_TALKS] < 0) flags[kFLAGS.EVANGELINE_TALKS] = 0;
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 14) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 15;
		clearOutput();
		outputText("Why only use an imitation of bow when you can have A REAL BOW?");
		if (player.hasKeyItem("Bow") >= 0) {
			player.removeKeyItem("Bow");
			player.setWeaponRange(weaponsrange.BOWOLD_);
		}
		if (player.hasKeyItem("Bow") >= 0 && player.hasKeyItem("Kelt's Bow") >= 0) {
			player.removeKeyItem("Bow");
			player.removeKeyItem("Kelt's Bow");
			player.gems = player.gems + 1;
			statScreenRefresh();
			player.setWeaponRange(weaponsrange.BOWKELT);
		}
		if (player.findPerk(PerkLib.ImprovedEndurance) >= 0) {
			player.removePerk(PerkLib.ImprovedEndurance);
			player.createPerk(PerkLib.BasicEndurance, 0, 0, 0, 0);
		}
		if (player.findPerk(PerkLib.AdvancedEndurance) >= 0) {
			player.removePerk(PerkLib.AdvancedEndurance);
			player.createPerk(PerkLib.HalfStepToImprovedEndurance, 0, 0, 0, 0);
		}
		if (player.findPerk(PerkLib.SuperiorEndurance) >= 0) {
			player.removePerk(PerkLib.SuperiorEndurance);
			player.createPerk(PerkLib.ImprovedEndurance, 0, 0, 0, 0);
		}
		if (player.findPerk(PerkLib.ImprovedSelfControl) >= 0) {
			player.removePerk(PerkLib.ImprovedSelfControl);
			player.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
		}
		if (player.findPerk(PerkLib.AdvancedSelfControl) >= 0) {
			player.removePerk(PerkLib.AdvancedSelfControl);
			player.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
		}
		if (player.findPerk(PerkLib.SuperiorSelfControl) >= 0) {
			player.removePerk(PerkLib.SuperiorSelfControl);
			player.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
		}
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 15) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 16;
		clearOutput();
		outputText("Time for...save upgrade ^^");
		if (player.findPerk(PerkLib.EnlightenedNinetails) >= 0) player.createPerk(PerkLib.EnlightenedKitsune, 0, 0, 0, 0);
		if (player.findPerk(PerkLib.CorruptedNinetails) >= 0) player.createPerk(PerkLib.CorruptedKitsune, 0, 0, 0, 0);
		if (player.findPerk(PerkLib.Manyshot) >= 0 && player.findPerk(PerkLib.TripleStrike) < 0) {
			player.removePerk(PerkLib.Manyshot);
			player.createPerk(PerkLib.TripleStrike, 0, 0, 0, 0);
		}
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 16) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 17;
		clearOutput();
		outputText("Tentacled Barks, Divine Barks, Barks everywhere!!! No go back and beat Marae again if you had her bark unused yet");
		if (player.hasKeyItem("Tentacled Bark Plates") >= 0) {
			player.removeKeyItem("Tentacled Bark Plates");
			flags[kFLAGS.CORRUPTED_MARAE_KILLED] = 0;
		}
		if (player.hasKeyItem("Divine Bark Plates") >= 0) {
			player.removeKeyItem("Divine Bark Plates");
			flags[kFLAGS.PURE_MARAE_ENDGAME] = 1;
		}
		if (player.findPerk(PerkLib.JobSoulArcher) >= 0) {
			player.removePerk(PerkLib.JobSoulArcher);
			player.perkPoints = player.perkPoints + 1;
		}
		//Update chitin
		if (player.hasCoatOfType(Skin.CHITIN)) {
			if (player.mantisScore() >= 5) player.skin.coat.color = "green";
			if (player.spiderScore() >= 5) player.skin.coat.color = "pale white";
			if (player.mantisScore() < 5 && player.spiderScore() < 5) {
				if (rand(2) == 1) player.skin.coat.color = "green";
				else player.skin.coat.color = "pale white";
			}
		}
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 17) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 18;
		clearOutput();
		outputText("Multi tails get broken or was it venom in them...so we fixed that both will not gonna mess up other or so we think ^^");
		if (player.tailType == Tail.FOX) {
			player.tailCount = player.tailVenom;
			if (player.tailCount < 1) player.tailCount = 1;
			player.tailVenom = 0;
		}
		if (player.faceType == Face.SNAKE_FANGS) {
			if (player.tailRecharge < 5) player.tailRecharge = 5;
		}
		if (player.findPerk(PerkLib.Cupid) >= 0) {
			player.removePerk(PerkLib.Cupid);
			player.perkPoints = player.perkPoints + 1;
		}
		if (player.findPerk(PerkLib.ElementalArrows) >= 0) {
			player.removePerk(PerkLib.ElementalArrows);
			player.perkPoints = player.perkPoints + 1;
		}
		if (player.findPerk(PerkLib.JobArcaneArcher) >= 0) {
			player.removePerk(PerkLib.JobArcaneArcher);
			player.createPerk(PerkLib.JobHunter, 0, 0, 0, 0);
		}
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 18) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 19;
		clearOutput();
		outputText("Small reorganizing of the house interiors...err I mean mod interiors so not mind it if you not have Soul Cultivator PC. I heard you all likes colors, colors on EVERYTHING ever your belowed lil PC's eyes. So go ahead and pick them. Not much change from addition to appearance screen this small detail. But in future if scene will allow there will be addition of parser for using eyes color too.");
		if (player.findPerk(PerkLib.SoulExalt) >= 0) {
			player.removePerk(PerkLib.SoulExalt);
			player.createPerk(PerkLib.SoulScholar, 0, 0, 0, 0);
		}
		if (player.findPerk(PerkLib.SoulOverlord) >= 0) {
			player.removePerk(PerkLib.SoulOverlord);
			player.createPerk(PerkLib.SoulElder, 0, 0, 0, 0);
		}
		if (flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED] > 0 && flags[kFLAGS.AYANE_FOLLOWER] < 0) flags[kFLAGS.AYANE_FOLLOWER] = 0;
		if (flags[kFLAGS.GOTTEN_INQUISITOR_ARMOR] > 0) flags[kFLAGS.GOTTEN_INQUISITOR_ARMOR] = 2;
		eyesColorSelection();
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 19) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 20;
		if (player.findPerk(PerkLib.JobBarbarian) >= 0) {
			player.removePerk(PerkLib.JobBarbarian);
			player.createPerk(PerkLib.JobSwordsman, 0, 0, 0, 0);
		}
		clearOutput();
		outputText("Switching one perk...if needed.");
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 20) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 21;
		if (player.hasPerk(PerkLib.Lycanthropy)) {
			player.skin.coverage = Skin.COVERAGE_LOW;
			player.coatColor = player.hairColor;
			player.removePerk(PerkLib.Lycanthropy);
			var bonusStats:Number = 0;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) bonusStats += 10;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) bonusStats += 20;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) bonusStats += 30;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) bonusStats += 40;
			player.createPerk(PerkLib.Lycanthropy,bonusStats,0,0,0);
			player.dynStats("str", (bonusStats * (player.newGamePlusMod() + 1)), "tou", (bonusStats * (player.newGamePlusMod() + 1)), "spe", (bonusStats * (player.newGamePlusMod() + 1)), "cor", 20);
		}
		if (flags[kFLAGS.LUNA_MOON_CYCLE] > 8) flags[kFLAGS.LUNA_MOON_CYCLE] = 1;
		clearOutput();
		outputText("Time to defur our werewolfs... no worry it will be only partial deffuring.");
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 21) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 22;
		clearOutput();
		outputText("Time to get from zero to Hero. Also some lil gift if PC is at least on lvl 1 ^^");
		outputText("\n\nThere was also minor reshuffle in chimera body (and some other) perks but let not talk about mutations.... remember kids: don't do mutations... become Mareth Champion and get them for free.");
		if (flags[kFLAGS.STAT_GAIN_MODE] == CoC.STAT_GAIN_CLASSIC) {
			player.statPoints += 5;
			if (player.level > 6) player.statPoints += 30;
			else player.statPoints += (5 * player.level);
		}
		if (player.level > 6) player.perkPoints += 7;
		else player.perkPoints += player.level + 1;
		if (flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] > 0) {
			if (flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] == 1) player.createStatusEffect(StatusEffects.SoulArenaGaunlets1, 2, 0, 0, 0);
			else player.createStatusEffect(StatusEffects.SoulArenaGaunlets1, 2, 2, 0, 0);
			flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] = 0;
		}
		if (player.hasPerk(PerkLib.SenseCorruption)) {
			player.removePerk(PerkLib.SenseCorruption);
			player.perkPoints += 1;
		}
		if (player.hasPerk(PerkLib.SenseWrath)) {
			player.removePerk(PerkLib.SenseWrath);
			player.perkPoints += 1;
		}
		if (player.hasPerk(PerkLib.ChimericalBodyBasicStage)) {
			player.removePerk(PerkLib.ChimericalBodyBasicStage);
			player.createPerk(PerkLib.ChimericalBodySemiBasicStage,0,0,0,0);
		}
		if (player.hasPerk(PerkLib.ChimericalBodyAdvancedStage)) {
			player.removePerk(PerkLib.ChimericalBodyAdvancedStage);
			player.createPerk(PerkLib.ChimericalBodyBasicStage,0,0,0,0);
		}
		if (player.hasPerk(PerkLib.UnlockBody2ndStage)) {
			player.removePerk(PerkLib.UnlockBody2ndStage);
			player.createPerk(PerkLib.UnlockEndurance, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.UnlockId)) {
			player.removePerk(PerkLib.UnlockId);
			player.createPerk(PerkLib.UnlockArdor, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.UnlockId2ndStage)) {
				player.removePerk(PerkLib.UnlockId2ndStage);
				player.createPerk(PerkLib.UnlockId, 0, 0, 0, 0);
			}
		}
		if (player.hasPerk(PerkLib.UnlockMind)) {
			player.removePerk(PerkLib.UnlockMind);
			player.createPerk(PerkLib.UnlockForce, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.UnlockMind2ndStage)) {
				player.removePerk(PerkLib.UnlockMind2ndStage);
				player.createPerk(PerkLib.UnlockSpirit, 0, 0, 0, 0);
			}
		}
		if (player.hasPerk(PerkLib.HalfStepToMythicalEndurance)) {
			player.removePerk(PerkLib.HalfStepToMythicalEndurance);
			player.createPerk(PerkLib.HalfStepToLegendaryEndurance, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.MythicalEndurance)) {
			player.removePerk(PerkLib.MythicalEndurance);
			player.createPerk(PerkLib.LegendaryEndurance, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.HalfStepToMythicalSelfControl)) {
			player.removePerk(PerkLib.HalfStepToMythicalSelfControl);
			player.createPerk(PerkLib.HalfStepToLegendarySelfControl, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.MythicalSelfControl)) {
			player.removePerk(PerkLib.MythicalSelfControl);
			player.createPerk(PerkLib.LegendarySelfControl, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.HalfStepToMythicalSpirituality)) {
			player.removePerk(PerkLib.HalfStepToMythicalSpirituality);
			player.createPerk(PerkLib.HalfStepToLegendarySpirituality, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.MythicalSpirituality)) {
			player.removePerk(PerkLib.MythicalSpirituality);
			player.createPerk(PerkLib.LegendarySpirituality, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.HalfStepToMythicalTranquilness)) {
			player.removePerk(PerkLib.HalfStepToMythicalTranquilness);
			player.createPerk(PerkLib.HalfStepToLegendaryTranquilness, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.MythicalTranquilness)) {
			player.removePerk(PerkLib.MythicalTranquilness);
			player.createPerk(PerkLib.LegendaryTranquilness, 0, 0, 0, 0);
		}
		if (flags[kFLAGS.HIDDEN_CAVE_BOSSES] == 3) {
			flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 6;
			flags[kFLAGS.HIDDEN_CAVE_BOSSES] = 2;
		}
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 22) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 23;
		clearOutput();
		outputText("Transcendenting Transcendental Genetic Memory by 50%, Catching Cowardly dragon-boys and refreshing dose of Productivity Drugs.");
		if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1)) player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 5);
		if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2)) player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 10);
		if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3)) player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 15);
		if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage4)) player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 20);
		if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage5)) player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 25);
		if (flags[kFLAGS.HIDDEN_CAVE_BOSSES] >= 1) {
			flags[kFLAGS.TED_DEFEATS_COUNTER] = 1;
			flags[kFLAGS.TED_LVL_UP] = 1;
		}
		if (player.hasPerk(PerkLib.ProductivityDrugs)) {
			player.removePerk(PerkLib.ProductivityDrugs);
			player.createPerk(PerkLib.ProductivityDrugs,0,10,0,0);
			player.addPerkValue(PerkLib.ProductivityDrugs, 1, Math.round(player.cor/2));
			player.addPerkValue(PerkLib.ProductivityDrugs, 3, player.lib);
			player.addPerkValue(PerkLib.ProductivityDrugs, 4, player.lib);
		}
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 23) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 24;
		clearOutput();
		outputText("Reseting dream about... mechanical oranges i guess. And Drugs seems be so strong to stay at ascension. No worry PC just get detox therapy (again). But wait is it more to that all? Maybe some revolution silently started by mages?");
		flags[kFLAGS.AURORA_LVL] = 0;
		if (player.hasPerk(PerkLib.Archmage)) {
			player.removePerk(PerkLib.Archmage);
			player.createPerk(PerkLib.GrandMage, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.GrandArchmage)) {
			player.removePerk(PerkLib.GrandArchmage);
			player.createPerk(PerkLib.Archmage, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.GreyMage)) {
			player.removePerk(PerkLib.GreyMage);
			player.createPerk(PerkLib.GrandArchmage2ndCircle, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.GreyArchmage)) {
			player.removePerk(PerkLib.GreyArchmage);
			player.createPerk(PerkLib.GrandArchmage3rdCircle, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.Convergence)) {
			player.removePerk(PerkLib.Convergence);
			player.perkPoints += 1;
		}
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 24) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 25;
		clearOutput();
		outputText("I know you all loved been with Neisa but she need to begone but not like begone thot but just begone. As bonus you all will see scene of her leaving that should played at leaving river dungeon assuming your PC already visited it once ^^");
		if (flags[kFLAGS.NEISA_FOLLOWER] == 3) {
			outputText("As the pair of you leave the dungeon Neisa waves off, heading back to town.\n\n");
			outputText("\"<i>Nice going along with you [name], this was worth it. I’m going to go and spend this bling on some well earned reward. See you around up there. If you ever need of my services again I will be at the bar.</i>\"\n\n");
			player.removeStatusEffect(StatusEffects.CombatFollowerNeisa);
			flags[kFLAGS.PLAYER_COMPANION_1] = "";
			flags[kFLAGS.NEISA_FOLLOWER] = 4;
			outputText("Working together with another person has taught you how to manage and plan with a group of people. <b>Gained Perk: Basic Leadership</b>");
			player.createPerk(PerkLib.BasicLeadership,0,0,0,0);
		}
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 25) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 26;
		clearOutput();
		outputText("For all those poor Jiangshi. Go forth young zombie and be alive again... with a bit of recompesation ;) Also Adventure Guld Quest counters. I heard some of you likes to know how many times you brough those blood dripping imp skulls to our cute panda girl so... here you go.");
		if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] > 1) {
			player.setWeapon(weapons.BFTHSWORD);
			player.setWeaponRange(weaponsrange.AVELYNN);
			player.setShield(shields.DRGNSHL);
			player.setArmor(armors.LAYOARM);
			flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
			player.skinTone = "light";
			player.faceType = Face.HUMAN;
			player.eyes.type = Eyes.HUMAN;
			player.horns.type = Horns.NONE;
			player.horns.count = 0;
			player.arms.type = Arms.HUMAN;
			player.lowerBody = LowerBody.HUMAN;
			if (player.hasPerk(PerkLib.HaltedVitals)) player.removePerk(PerkLib.HaltedVitals);
			if (player.hasPerk(PerkLib.SuperStrength)) player.removePerk(PerkLib.SuperStrength);
			if (player.hasPerk(PerkLib.PoisonNails)) player.removePerk(PerkLib.PoisonNails);
			if (player.hasPerk(PerkLib.Rigidity)) player.removePerk(PerkLib.Rigidity);
			if (player.hasPerk(PerkLib.LifeLeech)) player.removePerk(PerkLib.LifeLeech);
			if (player.hasPerk(PerkLib.Undeath)) player.removePerk(PerkLib.Undeath);
			if (player.hasPerk(PerkLib.EnergyDependent)) player.removePerk(PerkLib.EnergyDependent);
			if (player.hasStatusEffect(StatusEffects.EnergyDependent)) player.removeStatusEffect(StatusEffects.EnergyDependent);
			flags[kFLAGS.CURSE_OF_THE_JIANGSHI] = 0;
		}
		if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests1)) {
			player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter1, 0, 0, 0, 0);
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 1, 1);
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 4) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 1, 2);
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 7) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 1, 3);
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 2, 1);
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 4) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 2, 2);
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 7) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 2, 3);
			if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 3, 1);
			if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 4) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 3, 2);
			if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 7) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 3, 3);
		}
		if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests2)) {
			player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter2, 0, 0, 0, 0);
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 1, 1);
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 4) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 1, 2);
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 7) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 1, 3);
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 2, 1);
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 4) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 2, 2);
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 7) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 2, 3);
		}
		if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests4)) {
			player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter4, 0, 0, 0, 0);
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 1, 1);
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) == 5) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 1, 2);
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 2, 1);
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) == 5) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 2, 2);
		}
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 26) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 27;
		clearOutput();
		outputText("A little Backpack cleanup - nothing to worry about. Or maybe... what will you put into a new and larger inventory? Refound included if necessary.");
		if (player.hasKeyItem("Backpack") >= 0) {
			player.gems += 200 * player.keyItemv1("Backpack");
			player.removeKeyItem("Backpack");
		}
		doNext(doCamp);
		return;
	}
/*	if (flags[kFLAGS.MOD_SAVE_VERSION] == 27) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 28;
		clearOutput();
		outputText("Text.");
		if (player.hasPerk(PerkLib.TitanGrip)) {
			player.removePerk(PerkLib.TitanGrip);
			player.createPerk(PerkLib.GigantGrip, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.LegendaryGolemMaker)) {
			player.removePerk(PerkLib.LegendaryGolemMaker);
			player.createPerk(PerkLib.EpicGolemMaker2ndCircle, 0, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.MythicalGolemMaker)) {
			player.removePerk(PerkLib.MythicalGolemMaker);
			player.createPerk(PerkLib.EpicGolemMaker3rdCircle, 0, 0, 0, 0);
		}
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 28) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 29;
		clearOutput();
		outputText("Text.");
		doNext(doCamp);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 29) {
		flags[kFLAGS.MOD_SAVE_VERSION] = 30;
		clearOutput();
		outputText("Text.");
		doNext(doCamp);
		return;
	}
*/	doCamp();
}

private function furColorSelection1():void {
	menu();
	addButton(0, "Brown", chooseFurColorSaveUpdate, "brown");
	addButton(1, "Chocolate", chooseFurColorSaveUpdate, "chocolate");
	addButton(2, "Auburn", chooseFurColorSaveUpdate, "auburn");
	addButton(3, "Orange", chooseFurColorSaveUpdate, "orange");
	
	addButton(5, "Caramel", chooseFurColorSaveUpdate, "caramel");
	addButton(6, "Peach", chooseFurColorSaveUpdate, "peach");
	addButton(7, "Sandy Brown", chooseFurColorSaveUpdate, "sandy brown");
	addButton(8, "Golden", chooseFurColorSaveUpdate, "golden");

	addButton(4, "Next", furColorSelection2);
}
private function furColorSelection2():void {
	menu();
	addButton(0, "Midnight black", chooseFurColorSaveUpdate, "midnight black");
	addButton(1, "Black", chooseFurColorSaveUpdate, "black");
	addButton(2, "Dark gray", chooseFurColorSaveUpdate, "dark gray");
	addButton(3, "Gray", chooseFurColorSaveUpdate, "gray");
	
	addButton(5, "Light gray", chooseFurColorSaveUpdate, "light gray");
	addButton(6, "Silver", chooseFurColorSaveUpdate, "silver");
	addButton(7, "White", chooseFurColorSaveUpdate, "white");
	
	addButton(10, "Orange&White", chooseFurColorSaveUpdate, "orange and white");
	addButton(11, "Brown&White", chooseFurColorSaveUpdate, "brown and white");
	addButton(12, "Black&White", chooseFurColorSaveUpdate, "black and white");
	addButton(13, "Gray&White", chooseFurColorSaveUpdate, "gray and white");
	
	addButton(9, "Previous", furColorSelection1);
}

private function chooseFurColorSaveUpdate(color:String):void {
	clearOutput();
	outputText("You now have " + color + " fur. You will be returned to your [camp] now and you can continue your usual gameplay.");
	player.skin.coat.color = color;
	doNext(doCamp);
}

private function scaleColorSelection1():void {
	menu();
	addButton(0, "Brown", chooseScalesColorSaveUpdate, "brown");
	addButton(1, "Chocolate", chooseScalesColorSaveUpdate, "chocolate");
	addButton(2, "Auburn", chooseScalesColorSaveUpdate, "auburn");
	addButton(3, "Orange", chooseScalesColorSaveUpdate, "orange");
	
	addButton(5, "Caramel", chooseScalesColorSaveUpdate, "caramel");
	addButton(6, "Peach", chooseScalesColorSaveUpdate, "peach");
	addButton(7, "Sandy Brown", chooseScalesColorSaveUpdate, "sandy brown");
	addButton(8, "Golden", chooseScalesColorSaveUpdate, "golden");

//	addButton(4, "Next", furColorSelection2);
}
private function chooseScalesColorSaveUpdate(color:String):void {
	clearOutput();
	outputText("You now have " + color + " scales. You will be returned to your [camp] now and you can continue your usual gameplay.");
	player.coatColor = color;
	doNext(doCamp);
}

private function eyesColorSelection():void {
	menu();
	addButton(0, "Black", chooseEyesColorSaveUpdate, "black");
	addButton(1, "Green", chooseEyesColorSaveUpdate, "green");
	addButton(2, "Blue", chooseEyesColorSaveUpdate, "blue");
	addButton(3, "Red", chooseEyesColorSaveUpdate, "red");
	addButton(4, "White", chooseEyesColorSaveUpdate, "white");
	addButton(5, "Brown", chooseEyesColorSaveUpdate, "brown");
	addButton(6, "Yellow", chooseEyesColorSaveUpdate, "yellow");
	addButton(7, "Grey", chooseEyesColorSaveUpdate, "grey");
	addButton(8, "Purple", chooseEyesColorSaveUpdate, "purple");
	addButton(10, "Silver", chooseEyesColorSaveUpdate, "silver");
	addButton(11, "Golden", chooseEyesColorSaveUpdate, "golden");
}

private function chooseEyesColorSaveUpdate(color:String):void {
	clearOutput();
	player.eyes.colour = color;
	outputText("You now have " + color + " eyes. You will be returned to your [camp] now and you can continue your usual gameplay.");
	doNext(doCamp);
}

//Updates save. Done to ensure your save doesn't get screwed up.
private function updateSaveFlags():void {
	flags[kFLAGS.MOD_SAVE_VERSION] = CoC.instance.modSaveVersion;
	var startOldIds:int = 1195;
	var startNewIds:int = 2001;
	var current:int = 0;
	var target:int = 65;
	while (current < target) {
		trace(flags[startOldIds + current]);
		if (flags[startOldIds + current] != 0) {
			flags[startNewIds + current] = flags[startOldIds + current];
			trace(flags[startNewIds + current]);
			flags[startOldIds + current] = 0;
		}
		else trace("Skipped");
		current++;
	}
	if (player.ass.analLooseness > 0 && flags[kFLAGS.TIMES_ORGASMED] <= 0) flags[kFLAGS.TIMES_ORGASMED] = 1;
	clearOutput();
	outputText("Your save file has been updated by changing the variables used in this mod from old flag position to new flag position.\n\n");
	outputText("As you know, the base game update tends to change flags and that may screw up saves when mod gets updated.\n\n");
	outputText("Unfortunately, I can't guarantee if every flags are retained. You may have lost some furniture or may have lost cabin. I'm sorry if this happens. Your codex entries are still unlocked, don't worry. And if your cabin is built, don't worry, it's still intact and you can re-construct furniture again.\n\n");
	if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) {
		outputText("As a compensation, here's 50 wood and 150 nails to re-construct your furniture.\n\n");
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += 50;
		if (player.hasKeyItem("Carpenter's Toolbox") >= 0) {
			player.addKeyValue("Carpenter's Toolbox", 1, 150);
		}
	}
	//flags[kFLAGS.SHIFT_KEY_DOWN] = 0; //Moved to unFuckSave().
	outputText("Don't worry. Just save the game and you're good to go. We, Ormael/Aimozg, will work out the bugs from time to time, while also bringing in cool new stuff!");
	doNext(doCamp);
}

private function updateAchievements():void {
	//Story
	awardAchievement("Newcomer", kACHIEVEMENTS.STORY_NEWCOMER);
	if (flags[kFLAGS.MARAE_QUEST_COMPLETE] > 0) awardAchievement("Marae's Savior", kACHIEVEMENTS.STORY_MARAE_SAVIOR);
	if (player.hasKeyItem("Zetaz's Map") >= 0) awardAchievement("Revenge at Last", kACHIEVEMENTS.STORY_ZETAZ_REVENGE);
	if (flags[kFLAGS.LETHICE_DEFEATED] > 0) awardAchievement("Demon Slayer", kACHIEVEMENTS.STORY_FINALBOSS);
	
	//Zones
	if (player.exploredForest > 0 && player.exploredLake > 0 && player.exploredDesert > 0 && player.exploredMountain > 0 && flags[kFLAGS.TIMES_EXPLORED_PLAINS] > 0 && flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0 && flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] > 0 && flags[kFLAGS.DISCOVERED_OUTER_BATTLEFIELD] > 0 && flags[kFLAGS.DISCOVERED_CAVES] > 0 && player.hasStatusEffect(StatusEffects.ExploredDeepwoods)
	 && flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] > 0 && flags[kFLAGS.BOG_EXPLORED] > 0 && flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] > 0 && flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] > 0) awardAchievement("Explorer", kACHIEVEMENTS.ZONE_EXPLORER);
	if (placesCount() >= 10) awardAchievement("Sightseer", kACHIEVEMENTS.ZONE_SIGHTSEER);
	if (player.explored >= 1) awardAchievement("Where am I?", kACHIEVEMENTS.ZONE_WHERE_AM_I);
	
	if (player.exploredForest >= 100) awardAchievement("Forest Ranger", kACHIEVEMENTS.ZONE_FOREST_RANGER);
	if (player.exploredLake >= 100) awardAchievement("Vacationer", kACHIEVEMENTS.ZONE_VACATIONER);
	if (player.exploredDesert >= 100) awardAchievement("Dehydrated", kACHIEVEMENTS.ZONE_DEHYDRATED);
	if (flags[kFLAGS.DISCOVERED_OUTER_BATTLEFIELD] >= 100) awardAchievement("Rookie", kACHIEVEMENTS.ZONE_ROOKIE);
	if (player.exploredMountain >= 100) awardAchievement("Mountaineer", kACHIEVEMENTS.ZONE_MOUNTAINEER);
	if (flags[kFLAGS.TIMES_EXPLORED_PLAINS] >= 100) awardAchievement("Rolling Hills", kACHIEVEMENTS.ZONE_ROLLING_HILLS);
	if (flags[kFLAGS.TIMES_EXPLORED_SWAMP] >= 100) awardAchievement("Wet All Over", kACHIEVEMENTS.ZONE_WET_ALL_OVER);
	if (flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] >= 100) awardAchievement("Tainted", kACHIEVEMENTS.ZONE_TAINTED);
	if (flags[kFLAGS.DISCOVERED_BEACH] >= 100) awardAchievement("Sunburned", kACHIEVEMENTS.ZONE_SUNBURNED);
	if (flags[kFLAGS.DISCOVERED_CAVES] >= 100) awardAchievement("Caveman", kACHIEVEMENTS.ZONE_CAVEMAN);
	
	if (player.statusEffectv1(StatusEffects.ExploredDeepwoods) >= 100) awardAchievement("We Need to Go Deeper", kACHIEVEMENTS.ZONE_WE_NEED_TO_GO_DEEPER);
	if (flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] >= 100) awardAchievement("Light-headed", kACHIEVEMENTS.ZONE_LIGHT_HEADED);
	if (flags[kFLAGS.BOG_EXPLORED] >= 100) awardAchievement("All murky", kACHIEVEMENTS.ZONE_ALL_MURKY);
	if (flags[kFLAGS.DISCOVERED_OCEAN] >= 100) awardAchievement("Sea-Legs", kACHIEVEMENTS.ZONE_SAILOR);
	if (flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] >= 100) awardAchievement("Frozen", kACHIEVEMENTS.ZONE_FROZEN);
	if (flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] >= 100) awardAchievement("Roasted", kACHIEVEMENTS.ZONE_ROASTED);
	if (flags[kFLAGS.DISCOVERED_DEEP_SEA] >= 100) awardAchievement("Diver", kACHIEVEMENTS.ZONE_DIVER);
	
	if (player.statusEffectv1(StatusEffects.BoatDiscovery) >= 15) awardAchievement("Sailor", kACHIEVEMENTS.ZONE_SEA_LEGS);
	if (player.statusEffectv1(StatusEffects.MetWhitney) >= 30) awardAchievement("Farmer", kACHIEVEMENTS.ZONE_FARMER);
	if (flags[kFLAGS.AMILY_VILLAGE_EXPLORED] >= 15) awardAchievement("Archaeologist", kACHIEVEMENTS.ZONE_ARCHAEOLOGIST);
	
	//Levels
	if (player.level >= 2) awardAchievement("Level up!", kACHIEVEMENTS.LEVEL_LEVEL_UP);
	if (player.level >= 5) awardAchievement("Novice", kACHIEVEMENTS.LEVEL_NOVICE);
	if (player.level >= 10) awardAchievement("Apprentice", kACHIEVEMENTS.LEVEL_APPRENTICE);
	if (player.level >= 15) awardAchievement("Journeyman", kACHIEVEMENTS.LEVEL_JOURNEYMAN);
	if (player.level >= 20) awardAchievement("Expert", kACHIEVEMENTS.LEVEL_EXPERT);
	if (player.level >= 30) awardAchievement("Master", kACHIEVEMENTS.LEVEL_MASTER);
	if (player.level >= 45) awardAchievement("Grandmaster", kACHIEVEMENTS.LEVEL_GRANDMASTER);
	if (player.level >= 60) awardAchievement("Illuistrous", kACHIEVEMENTS.LEVEL_ILLUSTRIOUS);
	if (player.level >= 75) awardAchievement("Overlord", kACHIEVEMENTS.LEVEL_OVERLORD);
	if (player.level >= 90) awardAchievement("Sovereign", kACHIEVEMENTS.LEVEL_SOVEREIGN);
	if (player.level >= 100) awardAchievement("Are you a god?", kACHIEVEMENTS.LEVEL_ARE_YOU_A_GOD);
	if (player.level >= 120) awardAchievement("Newb God(ess)", kACHIEVEMENTS.LEVEL_NEWB_GOD_ESS);
	if (player.level >= 150) awardAchievement("Mid-tier God(ess)", kACHIEVEMENTS.LEVEL_MID_TIER_GOD_ESS);
	
	//Population
	if (getCampPopulation() >= 2) awardAchievement("My First Companion", kACHIEVEMENTS.POPULATION_FIRST);
	if (getCampPopulation() >= 5) awardAchievement("Hamlet", kACHIEVEMENTS.POPULATION_HAMLET);
	if (getCampPopulation() >= 10) awardAchievement("Village", kACHIEVEMENTS.POPULATION_VILLAGE);
	if (getCampPopulation() >= 25) awardAchievement("Town", kACHIEVEMENTS.POPULATION_TOWN);
	if (getCampPopulation() >= 100) awardAchievement("City", kACHIEVEMENTS.POPULATION_CITY);
	if (getCampPopulation() >= 250) awardAchievement("Metropolis", kACHIEVEMENTS.POPULATION_METROPOLIS);
	if (getCampPopulation() >= 500) awardAchievement("Megalopolis", kACHIEVEMENTS.POPULATION_MEGALOPOLIS);
	if (getCampPopulation() >= 1000) awardAchievement("City-State", kACHIEVEMENTS.POPULATION_CITY_STATE);
	if (getCampPopulation() >= 2500) awardAchievement("Kingdom", kACHIEVEMENTS.POPULATION_KINGDOM);
	if (getCampPopulation() >= 5000) awardAchievement("Empire", kACHIEVEMENTS.POPULATION_EMPIRE);
	if (getCampPopulation() >= 10000) awardAchievement("Large Empire", kACHIEVEMENTS.POPULATION_LARGE_EMPIRE);
	if (getCampUndergroundPopulation() >= 1) awardAchievement("My First Underground Companion", kACHIEVEMENTS.UNDERGROUND_POPULATION_FIRST);
	if (getCampUndergroundPopulation() >= 20) awardAchievement("Underground Hamlet", kACHIEVEMENTS.UNDERGROUND_POPULATION_HAMLET);
	if (getCampUndergroundPopulation() >= 50) awardAchievement("Underground Village", kACHIEVEMENTS.UNDERGROUND_POPULATION_VILLAGE);
	if (getCampUndergroundPopulation() >= 100) awardAchievement("Underground Town", kACHIEVEMENTS.UNDERGROUND_POPULATION_TOWN);
	if (getCampUndergroundPopulation() >= 250) awardAchievement("Underground City", kACHIEVEMENTS.UNDERGROUND_POPULATION_CITY);
	if (getCampUndergroundPopulation() >= 500) awardAchievement("Underground Metropolis", kACHIEVEMENTS.UNDERGROUND_POPULATION_METROPOLIS);
	if (getCampUndergroundPopulation() >= 1000) awardAchievement("Underground Megalopolis", kACHIEVEMENTS.UNDERGROUND_POPULATION_MEGALOPOLIS);
	if (getCampUndergroundPopulation() >= 2500) awardAchievement("Underground Large Megalopolis", kACHIEVEMENTS.UNDERGROUND_POPULATION_LARGE_MEGALOPOLIS);
	if (getCampUndergroundPopulation() >= 5000) awardAchievement("Underground City-State", kACHIEVEMENTS.UNDERGROUND_POPULATION_CITY_STATE);
	if (getCampUndergroundPopulation() >= 10000) awardAchievement("Underground Kingdom", kACHIEVEMENTS.UNDERGROUND_POPULATION_KINGDOM);
	
	//Time
	if (model.time.days >= 30) awardAchievement("It's been a month", kACHIEVEMENTS.TIME_MONTH);
	if (model.time.days >= 90) awardAchievement("Quarter", kACHIEVEMENTS.TIME_QUARTER);
	if (model.time.days >= 180) awardAchievement("Half-year", kACHIEVEMENTS.TIME_HALF_YEAR);
	if (model.time.days >= 365) awardAchievement("Annual", kACHIEVEMENTS.TIME_ANNUAL);
	if (model.time.days >= 730) awardAchievement("Biennial", kACHIEVEMENTS.TIME_BIENNIAL);
	if (model.time.days >= 1095) awardAchievement("Triennial", kACHIEVEMENTS.TIME_TRIENNIAL);
	if (model.time.days >= 1825) awardAchievement("In for the long haul", kACHIEVEMENTS.TIME_LONG_HAUL);
	if (model.time.days >= 3650) awardAchievement("Decade", kACHIEVEMENTS.TIME_DECADE);
	if (model.time.days >= 36500) awardAchievement("Century", kACHIEVEMENTS.TIME_CENTURY);
	
	//Dungeon
	var dungeonsCleared:int = 0;
	if (SceneLib.dungeons.checkFactoryClear()) {
		awardAchievement("Shut Down Everything", kACHIEVEMENTS.DUNGEON_SHUT_DOWN_EVERYTHING);
		dungeonsCleared++;
	}
	if (SceneLib.dungeons.checkDeepCaveClear()) {
		awardAchievement("You're in Deep", kACHIEVEMENTS.DUNGEON_YOURE_IN_DEEP);
		dungeonsCleared++;
	}
	if (SceneLib.dungeons.checkSandCaveClear()) {
		awardAchievement("Friend of the Sand Witches", kACHIEVEMENTS.DUNGEON_SAND_WITCH_FRIEND);
		dungeonsCleared++;
	}
	if (SceneLib.dungeons.checkPhoenixTowerClear()) {
		awardAchievement("Fall of the Phoenix", kACHIEVEMENTS.DUNGEON_PHOENIX_FALL);
		dungeonsCleared++;
		if (flags[kFLAGS.TIMES_ORGASMED] <= 0 && flags[kFLAGS.MOD_SAVE_VERSION] == CoC.instance.modSaveVersion) awardAchievement("Extremely Chaste Delver", kACHIEVEMENTS.DUNGEON_EXTREMELY_CHASTE_DELVER);
	}
	if (SceneLib.dungeons.checkLethiceStrongholdClear()) {
		awardAchievement("End of Reign", kACHIEVEMENTS.DUNGEON_END_OF_REIGN);
		dungeonsCleared++;
	}
	if (SceneLib.dungeons.checkHiddenCaveHiddenStageClear()) {
		awardAchievement("Tiger stalking the Dragon", kACHIEVEMENTS.DUNGEON_TIGER_STALKING_THE_DRAGON);
		dungeonsCleared++;
	}
	if (SceneLib.dungeons.checkRiverDungeon1stFloorClear()) {
		awardAchievement("Mirror Flower, Water Moon", kACHIEVEMENTS.DUNGEON_MIRROR_FLOWER_WATER_MOON);
		awardAchievement("Dungeon Seeker (1st layer)", kACHIEVEMENTS.DUNGEON_DUNGEON_SEEKER_1ST_LAYER);
		dungeonsCleared++;
	}
	if (SceneLib.dungeons.checkDenOfDesireClear()) {
		awardAchievement("Slain the Heroslayer", kACHIEVEMENTS.DUNGEON_SLAIN_THE_HEROSLAYER);
		dungeonsCleared++;
	}
	if (SceneLib.dungeons.checkEbonLabyrinthClear()) {
		awardAchievement("Honorary Minotaur", kACHIEVEMENTS.DUNGEON_HONORARY_MINOTAUR);
		dungeonsCleared++;
	}
	if (dungeonsCleared >= 1) awardAchievement("Delver", kACHIEVEMENTS.DUNGEON_DELVER);
	if (dungeonsCleared >= 2) awardAchievement("Delver Apprentice", kACHIEVEMENTS.DUNGEON_DELVER_APPRENTICE);
	if (dungeonsCleared >= 4) awardAchievement("Delver Expert", kACHIEVEMENTS.DUNGEON_DELVER_MASTER);
	if (dungeonsCleared >= 8) awardAchievement("Delver Master", kACHIEVEMENTS.DUNGEON_DELVER_EXPERT);
	if (dungeonsCleared >= 16) awardAchievement("Delver Grand Master", kACHIEVEMENTS.DUNGEON_DELVER_GRAND_MASTER);//obecnie max 9
	
	//Fashion
	if (player.armor == armors.W_ROBES && player.weapon == weapons.W_STAFF) awardAchievement("Wannabe Wizard", kACHIEVEMENTS.FASHION_WANNABE_WIZARD);
	if (player.previouslyWornClothes.length >= 10) awardAchievement("Cosplayer (Beginner)", kACHIEVEMENTS.FASHION_COSPLAYER);
	if (player.previouslyWornClothes.length >= 30) awardAchievement("Cosplayer (Amateour)", kACHIEVEMENTS.FASHION_COSPLAYER_1);
	if (player.previouslyWornClothes.length >= 60) awardAchievement("Cosplayer (Recognizable)", kACHIEVEMENTS.FASHION_COSPLAYER_2);
	if (player.previouslyWornClothes.length >= 100) awardAchievement("Cosplayer (Seasonal)", kACHIEVEMENTS.FASHION_COSPLAYER_1);
	if (player.previouslyWornClothes.length >= 150) awardAchievement("Cosplayer (Proffesional)", kACHIEVEMENTS.FASHION_COSPLAYER_2);
	//if (player.previouslyWornClothes.length >= 210) awardAchievement("Jessica Nigri apprentice", kACHIEVEMENTS.FASHION_COSPLAYER_3);
	//if (player.previouslyWornClothes.length >= 270) awardAchievement("Yaya Han apprentice", kACHIEVEMENTS.FASHION_COSPLAYER_4);
	if ((player.armor == armors.RBBRCLT || player.armor == armors.BONSTRP || player.armor == armors.NURSECL) && 
	(player.weapon == weapons.RIDINGC || player.weapon == weapons.WHIP || player.weapon == weapons.SUCWHIP || player.weapon == weapons.L_WHIP || player.weapon == weapons.PSWHIP || player.weapon == weapons.PWHIP || player.weapon == weapons.BFWHIP || player.weapon == weapons.DBFWHIP || player.weapon == weapons.NTWHIP || player.weapon == weapons.CNTWHIP)) awardAchievement("Dominatrix", kACHIEVEMENTS.FASHION_DOMINATRIX);
	if (player.armor != ArmorLib.NOTHING && player.lowerGarment == UndergarmentLib.NOTHING && player.upperGarment == UndergarmentLib.NOTHING) awardAchievement("Going Commando", kACHIEVEMENTS.FASHION_GOING_COMMANDO);
	if (player.headJewelry == headjewelries.FIRECRO && player.necklace == necklaces.FIRENEC && player.jewelry == jewelries.FIRERNG && player.jewelry2 == jewelries.FIRERNG && player.jewelry3 == jewelries.FIRERNG && player.jewelry4 == jewelries.FIRERNG) awardAchievement("Hellblazer", kACHIEVEMENTS.FASHION_HELLBLAZER);
	if (player.headJewelry == headjewelries.ICECROW && player.necklace == necklaces.ICENECK && player.jewelry == jewelries.ICERNG && player.jewelry2 == jewelries.ICERNG && player.jewelry3 == jewelries.ICERNG && player.jewelry4 == jewelries.ICERNG) awardAchievement("Less than Zero", kACHIEVEMENTS.FASHION_LESS_THAN_ZERO);
	if (player.headJewelry == headjewelries.LIGHCRO && player.necklace == necklaces.LIGHNEC && player.jewelry == jewelries.LIGHRNG && player.jewelry2 == jewelries.LIGHRNG && player.jewelry3 == jewelries.LIGHRNG && player.jewelry4 == jewelries.LIGHRNG) awardAchievement("Thunderstuck", kACHIEVEMENTS.FASHION_THUNDERSTUCK);
	if (player.headJewelry == headjewelries.DARKCRO && player.necklace == necklaces.DARKNEC && player.jewelry == jewelries.DARKRNG && player.jewelry2 == jewelries.DARKRNG && player.jewelry3 == jewelries.DARKRNG && player.jewelry4 == jewelries.DARKRNG) awardAchievement("Darkness Within", kACHIEVEMENTS.FASHION_DARKNESS_WITHIN);
	if (player.headJewelry == headjewelries.POISCRO && player.necklace == necklaces.POISNEC && player.jewelry == jewelries.POISRNG && player.jewelry2 == jewelries.POISRNG && player.jewelry3 == jewelries.POISRNG && player.jewelry4 == jewelries.POISRNG) awardAchievement("Poison Ivy", kACHIEVEMENTS.FASHION_POISON_IVY);
	if (player.headJewelry == headjewelries.LUSTCRO && player.necklace == necklaces.LUSTNEC && player.jewelry == jewelries.LUSTRNG && player.jewelry2 == jewelries.LUSTRNG && player.jewelry3 == jewelries.LUSTRNG && player.jewelry4 == jewelries.LUSTRNG) awardAchievement("Playboy Bunny", kACHIEVEMENTS.FASHION_POLAYBOY_BUNNY);
	if (player.headJewelry == headjewelries.CROWINT && player.necklace == necklaces.NECKINT && player.jewelry == jewelries.RINGINT && player.jewelry2 == jewelries.RINGINT && player.jewelry3 == jewelries.RINGINT && player.jewelry4 == jewelries.RINGINT) awardAchievement("Throne of Intelligence", kACHIEVEMENTS.FASHION_THRONE_OF_INTELLIGENCE);
	if (player.headJewelry == headjewelries.CROWLIB && player.necklace == necklaces.NECKLIB && player.jewelry == jewelries.RINGLIB && player.jewelry2 == jewelries.RINGLIB && player.jewelry3 == jewelries.RINGLIB && player.jewelry4 == jewelries.RINGLIB) awardAchievement("Throne of Libido", kACHIEVEMENTS.FASHION_THRONE_OF_LIBIDO);
	if (player.headJewelry == headjewelries.CROWSEN && player.necklace == necklaces.NECKSEN && player.jewelry == jewelries.RINGSEN && player.jewelry2 == jewelries.RINGSEN && player.jewelry3 == jewelries.RINGSEN && player.jewelry4 == jewelries.RINGSEN) awardAchievement("Throne of Sensitivity", kACHIEVEMENTS.FASHION_THRONE_OF_SENSITIVITY);
	if (player.headJewelry == headjewelries.CROWSPE && player.necklace == necklaces.NECKSPE && player.jewelry == jewelries.RINGSPE && player.jewelry2 == jewelries.RINGSPE && player.jewelry3 == jewelries.RINGSPE && player.jewelry4 == jewelries.RINGSPE) awardAchievement("Throne of Speed", kACHIEVEMENTS.FASHION_THRONE_OF_SPEED);
	if (player.headJewelry == headjewelries.CROWSTR && player.necklace == necklaces.NECKSTR && player.jewelry == jewelries.RINGSTR && player.jewelry2 == jewelries.RINGSTR && player.jewelry3 == jewelries.RINGSTR && player.jewelry4 == jewelries.RINGSTR) awardAchievement("Throne of Strength", kACHIEVEMENTS.FASHION_THRONE_OF_STRENGTH);
	if (player.headJewelry == headjewelries.CROWTOU && player.necklace == necklaces.NECKTOU && player.jewelry == jewelries.RINGTOU && player.jewelry2 == jewelries.RINGTOU && player.jewelry3 == jewelries.RINGTOU && player.jewelry4 == jewelries.RINGTOU) awardAchievement("Throne of Toughness", kACHIEVEMENTS.FASHION_THRONE_OF_TOUGHNESS);
	if (player.headJewelry == headjewelries.CROWWIS && player.necklace == necklaces.NECKWIS && player.jewelry == jewelries.RINGWIS && player.jewelry2 == jewelries.RINGWIS && player.jewelry3 == jewelries.RINGWIS && player.jewelry4 == jewelries.RINGWIS) awardAchievement("Throne of Wisdom", kACHIEVEMENTS.FASHION_THRONE_OF_WISDOM);
	if (player.isInGoblinMech()) awardAchievement("Suit Up!", kACHIEVEMENTS.FASHION_SUIT_UP);
	if (player.vehicles == vehicles.GOBMPRI) awardAchievement("Rollin' Rollin'", kACHIEVEMENTS.FASHION_ROLLIN_ROLLIN);
	if (player.jewelry.value >= 1000) awardAchievement("Bling Bling", kACHIEVEMENTS.FASHION_BLING_BLING);
	if (player.necklace.value >= 5000) awardAchievement("Ka-Ching!", kACHIEVEMENTS.FASHION_KA_CHING);
	if (player.headJewelry.value >= 4000) awardAchievement("Royalty", kACHIEVEMENTS.FASHION_ROYALTY);
	
	//Wealth
	if (player.gems >= 1000) awardAchievement("Rich", kACHIEVEMENTS.WEALTH_RICH);
	if (player.gems >= 10000) awardAchievement("Hoarder", kACHIEVEMENTS.WEALTH_HOARDER);
	if (player.gems >= 100000) awardAchievement("Gem Vault", kACHIEVEMENTS.WEALTH_GEM_VAULT);
	if (player.gems >= 1000000) awardAchievement("Millionaire", kACHIEVEMENTS.WEALTH_MILLIONAIRE);
	if (flags[kFLAGS.SPIRIT_STONES] >= 200) awardAchievement("Poor Daoist", kACHIEVEMENTS.WEALTH_POOR_DAOIST);
	if (flags[kFLAGS.SPIRIT_STONES] >= 2000) awardAchievement("Sect's Conclave Student", kACHIEVEMENTS.WEALTH_SECTS_CONCLAVE_STUDENT);
	if (flags[kFLAGS.SPIRIT_STONES] >= 20000) awardAchievement("Sect's Head Elder", kACHIEVEMENTS.WEALTH_SECTS_HEAD_ELDER);
	if (flags[kFLAGS.SPIRIT_STONES] >= 500000) awardAchievement("Sect's Patriarch", kACHIEVEMENTS.WEALTH_SECTS_PATRIARCH);
	if (flags[kFLAGS.SPIRIT_STONES] >= 20000000) awardAchievement("Meng Hao", kACHIEVEMENTS.WEALTH_MENG_HAO);
	
	//Combat
	if (player.hasStatusEffect(StatusEffects.KnowsCharge) && player.hasStatusEffect(StatusEffects.KnowsChargeA) && player.hasStatusEffect(StatusEffects.KnowsBlind) && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && player.hasStatusEffect(StatusEffects.KnowsBlizzard) && player.hasStatusEffect(StatusEffects.KnowsLightningBolt) && player.hasStatusEffect(StatusEffects.KnowsChainLighting) && player.hasStatusEffect(StatusEffects.KnowsPyreBurst) ) awardAchievement("Gandalf", kACHIEVEMENTS.COMBAT_GANDALF);
	if (player.hasStatusEffect(StatusEffects.KnowsArouse) && player.hasStatusEffect(StatusEffects.KnowsHeal) && player.hasStatusEffect(StatusEffects.KnowsMight) && player.hasStatusEffect(StatusEffects.KnowsBlink) && player.hasStatusEffect(StatusEffects.KnowsIceSpike) && player.hasStatusEffect(StatusEffects.KnowsDarknessShard) && player.hasStatusEffect(StatusEffects.KnowsDuskWave) && player.hasStatusEffect(StatusEffects.KnowsArcticGale) ) awardAchievement("Sauron", kACHIEVEMENTS.COMBAT_SAURON);
	if (player.hasStatusEffect(StatusEffects.KnowsCharge) && player.hasStatusEffect(StatusEffects.KnowsChargeA) && player.hasStatusEffect(StatusEffects.KnowsBlind) && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && player.hasStatusEffect(StatusEffects.KnowsBlizzard) && player.hasStatusEffect(StatusEffects.KnowsArouse) && player.hasStatusEffect(StatusEffects.KnowsHeal) && player.hasStatusEffect(StatusEffects.KnowsMight) && player.hasStatusEffect(StatusEffects.KnowsBlink) &&
		player.hasStatusEffect(StatusEffects.KnowsIceSpike) && player.hasStatusEffect(StatusEffects.KnowsLightningBolt) && player.hasStatusEffect(StatusEffects.KnowsDarknessShard) && player.hasStatusEffect(StatusEffects.KnowsChainLighting) && player.hasStatusEffect(StatusEffects.KnowsPyreBurst) && player.hasStatusEffect(StatusEffects.KnowsDuskWave) && player.hasStatusEffect(StatusEffects.KnowsArcticGale) ) awardAchievement("Merlin", kACHIEVEMENTS.COMBAT_WIZARD);
	if (flags[kFLAGS.SPELLS_CAST] >= 1 ) awardAchievement("Are you a Wizard?", kACHIEVEMENTS.COMBAT_ARE_YOU_A_WIZARD);
	
	//Realistic
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_FASTING] >= 168 && flags[kFLAGS.HUNGER_ENABLED] > 0) awardAchievement("Fasting", kACHIEVEMENTS.REALISTIC_FASTING);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_FASTING] >= 960 && flags[kFLAGS.HUNGER_ENABLED] > 0) awardAchievement("Lent", kACHIEVEMENTS.REALISTIC_LENT);
	if (player.maxHunger() > 100) awardAchievement("One more dish please", kACHIEVEMENTS.REALISTIC_ONE_MORE_DISH_PLEASE);
	if (player.maxHunger() > 250) awardAchievement("You not gonna eat those ribs?", kACHIEVEMENTS.REALISTIC_YOU_NOT_GONNA_EAT_THOSE_RIBS);
	if (player.maxHunger() > 500) awardAchievement("Dinner for Four", kACHIEVEMENTS.REALISTIC_DINNER_FOR_FOUR);
	if (player.maxHunger() > 1000) awardAchievement("Dinner for Obelix", kACHIEVEMENTS.REALISTIC_DINNER_FOR_OBELIX);

	//Holiday
	if (flags[kFLAGS.NIEVE_STAGE] == 5) awardAchievement("The Lovable Snowman", kACHIEVEMENTS.HOLIDAY_CHRISTMAS_III);

	//General
	if (flags[kFLAGS.DEMONS_DEFEATED] >= 20 && model.time.days >= 10) awardAchievement("Portal Defender", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER);
	if (flags[kFLAGS.DEMONS_DEFEATED] >= 40 && model.time.days >= 25) awardAchievement("Portal Defender 2: Defend Harder", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_2_DEFEND_HARDER);
	if (flags[kFLAGS.DEMONS_DEFEATED] >= 100 && model.time.days >= 45) awardAchievement("Portal Defender 3D: The Longest Night", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_3D_THE_LONGEST_NIGHT);
	if (flags[kFLAGS.DEMONS_DEFEATED] >= 300 && model.time.days >= 70) awardAchievement("Portal Defender 4.0: Die Hard", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_4_0_DIE_HARD);
	if (flags[kFLAGS.DEMONS_DEFEATED] >= 1050 && model.time.days >= 100) awardAchievement("Portal Defender 5: A Good Day to Die Hard", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_5_A_GOOD_DAY_TO_DIE_HARD);
	if (flags[kFLAGS.IMPS_KILLED] >= 25) awardAchievement("Just to Spite You", kACHIEVEMENTS.GENERAL_JUST_TO_SPITE_YOU);
	if (flags[kFLAGS.IMPS_KILLED] >= 125) awardAchievement("Just to Spite You 2: Spite Harder", kACHIEVEMENTS.GENERAL_JUST_TO_SPITE_YOU_2_SPITE_HARDER);
	if (flags[kFLAGS.IMPS_KILLED] >= 625) awardAchievement("Just to Spite You 3: I'm Back", kACHIEVEMENTS.GENERAL_JUST_TO_SPITE_YOU_3_IM_BACK);
	if (flags[kFLAGS.GOBLINS_KILLED] >= 25) awardAchievement("Goblin Slayer", kACHIEVEMENTS.GENERAL_GOBLIN_SLAYER);
	if (flags[kFLAGS.GOBLINS_KILLED] >= 125) awardAchievement("Goblin Slayer 2: Slay Harder", kACHIEVEMENTS.GENERAL_GOBLIN_SLAYER_2_SLAY_HARDER);
	if (flags[kFLAGS.GOBLINS_KILLED] >= 625) awardAchievement("Goblin Slayer 3: I'm Back", kACHIEVEMENTS.GENERAL_GOBLIN_SLAYER_3_IM_BACK);
	if (flags[kFLAGS.HELLHOUNDS_KILLED] >= 10) awardAchievement("Play dead Fido", kACHIEVEMENTS.GENERAL_PLAY_DEAD_FIDO);
	if (flags[kFLAGS.HELLHOUNDS_KILLED] >= 50) awardAchievement("Play dead Fido 2: Play Harder", kACHIEVEMENTS.GENERAL_PLAY_DEAD_FIDO_2_PLAY_HARDER);
	if (flags[kFLAGS.HELLHOUNDS_KILLED] >= 250) awardAchievement("Play dead Fido 3: I'm Back", kACHIEVEMENTS.GENERAL_PLAY_DEAD_FIDO_3_IM_BACK);
	if (flags[kFLAGS.MINOTAURS_KILLED] >= 10) awardAchievement("Killing the bull by the horns", kACHIEVEMENTS.GENERAL_KILLING_THE_BULL_BY_THE_HORNS);
	if (flags[kFLAGS.MINOTAURS_KILLED] >= 50) awardAchievement("Killing the bull by the horns 2: Kill Harder", kACHIEVEMENTS.GENERAL_KILLING_THE_BULL_BY_THE_HORNS_2_KILL_HARDER);
	if (flags[kFLAGS.MINOTAURS_KILLED] >= 250) awardAchievement("Killing the bull by the horns 3: I'm Back", kACHIEVEMENTS.GENERAL_KILLING_THE_BULL_BY_THE_HORNS_3_IM_BACK);
	
	var TotalKillCount:int = 0;
	if (flags[kFLAGS.IMPS_KILLED] > 0) TotalKillCount += flags[kFLAGS.IMPS_KILLED];
	if (flags[kFLAGS.GOBLINS_KILLED] > 0) TotalKillCount += flags[kFLAGS.GOBLINS_KILLED];
	if (flags[kFLAGS.HELLHOUNDS_KILLED] > 0) TotalKillCount += flags[kFLAGS.HELLHOUNDS_KILLED];
	if (flags[kFLAGS.MINOTAURS_KILLED] > 0) TotalKillCount += flags[kFLAGS.MINOTAURS_KILLED];
	if (TotalKillCount >= 47) awardAchievement("Body Count: Monty Python and the Holy Grail", kACHIEVEMENTS.GENERAL_BODY_COUNT_MPATHG);
	if (TotalKillCount >= 80) awardAchievement("Body Count: Deadpool", kACHIEVEMENTS.GENERAL_BODY_COUNT_DEADPOOL);
	if (TotalKillCount >= 144) awardAchievement("Body Count: Robocop", kACHIEVEMENTS.GENERAL_BODY_COUNT_ROBOCOP);
	if (TotalKillCount >= 191) awardAchievement("Body Count: Total Recall", kACHIEVEMENTS.GENERAL_BODY_COUNT_TOTALRECALL);
	if (TotalKillCount >= 247) awardAchievement("Body Count: Rambo", kACHIEVEMENTS.GENERAL_BODY_COUNT_RAMBO);
	if (TotalKillCount >= 307) awardAchievement("Body Count: Titanic", kACHIEVEMENTS.GENERAL_BODY_COUNT_TITANIC);
	if (TotalKillCount >= 468) awardAchievement("Body Count: The Lord of the Rings - Two Towers", kACHIEVEMENTS.GENERAL_BODY_COUNT_LOTR_TT);
	if (TotalKillCount >= 600) awardAchievement("Body Count: 300", kACHIEVEMENTS.GENERAL_BODY_COUNT_300);
	if (TotalKillCount >= 836) awardAchievement("Body Count: The Lord of the Rings - Return of the King", kACHIEVEMENTS.GENERAL_BODY_COUNT_LOTR_ROTK);
	//if (TotalKillCount >= 1410) awardAchievement("Body Count: Bloodiest Champion Ever", kACHIEVEMENTS.GENERAL_BODY_COUNT_BLOODIEST_CHAMPION_EVER);
	
	var NPCsBadEnds:int = 0; //Check how many NPCs got bad-ended.
	if (flags[kFLAGS.D1_OMNIBUS_KILLED] > 0) NPCsBadEnds++;
	if (flags[kFLAGS.ZETAZ_DEFEATED_AND_KILLED] > 0) NPCsBadEnds++;
	if (flags[kFLAGS.HARPY_QUEEN_EXECUTED] > 0) NPCsBadEnds++;
	if (flags[kFLAGS.KELT_KILLED] > 0 || flags[kFLAGS.KELT_BREAK_LEVEL] >= 4) NPCsBadEnds++;
	if (flags[kFLAGS.JOJO_DEAD_OR_GONE] == 2) NPCsBadEnds++;
	if (flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0) NPCsBadEnds++;
	if (flags[kFLAGS.FUCK_FLOWER_KILLED] > 0) NPCsBadEnds++;
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 2 || flags[kFLAGS.CHI_CHI_FOLLOWER] == 5) NPCsBadEnds++;
	if (flags[kFLAGS.PATCHOULI_FOLLOWER] == 3) NPCsBadEnds++;
	//Dungeon 3 encounters
	if (flags[kFLAGS.D3_GARDENER_DEFEATED] == 3) NPCsBadEnds++;
	if (flags[kFLAGS.D3_CENTAUR_DEFEATED] == 1) NPCsBadEnds++;
	if (flags[kFLAGS.D3_MECHANIC_FIGHT_RESULT] == 1) NPCsBadEnds++;
	if (flags[kFLAGS.DRIDERINCUBUS_KILLED] > 0) NPCsBadEnds++;
	if (flags[kFLAGS.MINOTAURKING_KILLED] > 0) NPCsBadEnds++;
	if (flags[kFLAGS.LETHICE_KILLED] > 0) NPCsBadEnds++;
	
	if (NPCsBadEnds >= 2) awardAchievement("Bad Ender", kACHIEVEMENTS.GENERAL_BAD_ENDER);
	if (NPCsBadEnds >= 4) awardAchievement("Bad Ender 2: Electric Boogaloo", kACHIEVEMENTS.GENERAL_BAD_ENDER_2);
	if (NPCsBadEnds >= 8) awardAchievement("Bad Ender 3: Serious Serial Slayer", kACHIEVEMENTS.GENERAL_BAD_ENDER_3);
	if (NPCsBadEnds >= 16) awardAchievement("Bad Ender 4: The Prequel", kACHIEVEMENTS.GENERAL_BAD_ENDER_4);

	if (flags[kFLAGS.TIMES_TRANSFORMED] >= 1) awardAchievement("What's Happening to Me?", kACHIEVEMENTS.GENERAL_WHATS_HAPPENING_TO_ME);
	if (flags[kFLAGS.TIMES_TRANSFORMED] >= 10) awardAchievement("Transformer", kACHIEVEMENTS.GENERAL_TRANSFORMER);
	if (flags[kFLAGS.TIMES_TRANSFORMED] >= 25) awardAchievement("Shapeshifty", kACHIEVEMENTS.GENERAL_SHAPESHIFTY);
	if (flags[kFLAGS.TIMES_TRANSFORMED] >= 100) awardAchievement("Lego-(Wo)Man", kACHIEVEMENTS.GENERAL_LEGO_WO_MAN);
	if (flags[kFLAGS.TIMES_TRANSFORMED] >= 250) awardAchievement("Transformer-o-holic", kACHIEVEMENTS.GENERAL_TRANSFORMER_O_HOLIC);
	if (flags[kFLAGS.TIMES_TRANSFORMED] >= 1000) awardAchievement("Tzimisce Antediluvian", kACHIEVEMENTS.GENERAL_TZIMISCE_ANTEDILUVIAN);
	if (flags[kFLAGS.TIMES_TRANSFORMED] >= 2500) awardAchievement("Just one last transformation item!!!", kACHIEVEMENTS.GENERAL_JUST_ONE_LAST_TRANSFORMATION_ITEM);
	if (flags[kFLAGS.TIMES_MASTURBATED] >= 1) awardAchievement("Fapfapfap", kACHIEVEMENTS.GENERAL_FAPFAPFAP);
	if (flags[kFLAGS.TIMES_MASTURBATED] >= 10) awardAchievement("Faptastic", kACHIEVEMENTS.GENERAL_FAPTASTIC);
	if (flags[kFLAGS.TIMES_MASTURBATED] >= 100) awardAchievement("Master-bation", kACHIEVEMENTS.GENERAL_FAPSTER);
	if (flags[kFLAGS.TIMES_MASTURBATED] >= 1000) awardAchievement("Grand Master-bation", kACHIEVEMENTS.GENERAL_FAPSTER_2);
	
	if (player.armorName == "goo armor") awardAchievement("Goo Armor", kACHIEVEMENTS.GENERAL_GOO_ARMOR);
	if (helspawnFollower()) awardAchievement("Helspawn", kACHIEVEMENTS.GENERAL_HELSPAWN);
	if (flags[kFLAGS.URTA_KIDS_MALES] + flags[kFLAGS.URTA_KIDS_FEMALES] + flags[kFLAGS.URTA_KIDS_HERMS] > 0) awardAchievement("Urta's True Lover", kACHIEVEMENTS.GENERAL_URTA_TRUE_LOVER);
	if (flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0) awardAchievement("Godslayer", kACHIEVEMENTS.GENERAL_GODSLAYER);
	if (followersCount() >= 7) awardAchievement("Follow the Leader (1)", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER);//ponownie przeliczyć followers, lovers, slaves counter
	if (followersCount() >= 14) awardAchievement("Follow the Leader (2)", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER_2);
	if (followersCount() >= 21) awardAchievement("Follow the Leader (3)", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER_3);
	if (loversCount() >= 8) awardAchievement("Gotta Love 'Em All (1)", kACHIEVEMENTS.GENERAL_GOTTA_LOVE_THEM_ALL);
	if (loversCount() >= 16) awardAchievement("Gotta Love 'Em All (2)", kACHIEVEMENTS.GENERAL_GOTTA_LOVE_THEM_ALL_2);
	//if (loversCount() >= 24) awardAchievement("Gotta Love 'Em All (3)", kACHIEVEMENTS.GENERAL_GOTTA_LOVE_THEM_ALL_3);
	if (slavesCount() >= 4) awardAchievement("Meet Your " + player.mf("Master", "Mistress") + " (1)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER);
	if (slavesCount() >= 8) awardAchievement("Meet Your " + player.mf("Master", "Mistress") + " (2)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_2);
	//if (slavesCount() >= 12) awardAchievement("Meet Your " + player.mf("Master", "Mistress") + " (3)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_3);
	if (slavesCount() >= 6 && slavesOptionalCount() >= 2) awardAchievement("Slaver (1)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_TRUE);
	//if (slavesCount() >= 12 && slavesOptionalCount() >= 4) awardAchievement("Slaver (2)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_TRUE_2);
	//if (slavesCount() >= 18 && slavesOptionalCount() >= 6) awardAchievement("Slaver (3)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_TRUE_3);//dodać dodatkowych opcjonalnych Slaves tutaj i dać licznik opcjonalnych z każdym achiev wymagającym wicej np. 2-4-6?
	if (followersCount() + loversCount() + slavesCount() >= 19) awardAchievement("All Your People are Belong to Me (1)", kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ_R_BLNG_2_ME);
	if (followersCount() + loversCount() + slavesCount() >= 38) awardAchievement("All Your People are Belong to Me (2)", kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ_R_BLNG_2_ME_2);
	//if (followersCount() + loversCount() + slavesCount() >= 57) awardAchievement("All Your People are Belong to Me (3)", kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ_R_BLNG_2_ME_3);
	if (flags[kFLAGS.MANSION_VISITED] >= 3) awardAchievement("Freeloader", kACHIEVEMENTS.GENERAL_FREELOADER);
	if (player.perks.length >= 25) awardAchievement("Perky", kACHIEVEMENTS.GENERAL_PERKY);
	if (player.perks.length >= 50) awardAchievement("Super Perky", kACHIEVEMENTS.GENERAL_SUPER_PERKY);
	if (player.perks.length >= 75) awardAchievement("Mega Perky", kACHIEVEMENTS.GENERAL_MEGA_PERKY);
	if (player.perks.length >= 100) awardAchievement("Ultra Perky", kACHIEVEMENTS.GENERAL_ULTRA_PERKY);
	if (player.perks.length >= 200) awardAchievement("Hyper Perky", kACHIEVEMENTS.GENERAL_HYPER_PERKY);
	if (player.perks.length >= 300) awardAchievement("Umber Perky", kACHIEVEMENTS.GENERAL_UMBER_PERKY);
	if (player.perks.length >= 444) awardAchievement("Perky Beast of Death", kACHIEVEMENTS.GENERAL_PERKY_BEAST_OF_DEATH);
	if (player.perks.length >= 600) awardAchievement("Perky King", kACHIEVEMENTS.GENERAL_PERKY_KING);
	if (player.perks.length >= 800) awardAchievement("Ridiculous Perky King", kACHIEVEMENTS.GENERAL_RIDICULOUS_PERKY_KING);
	//if (player.perks.length >= 1000) awardAchievement("Ludicrous Perky King", kACHIEVEMENTS.GENERAL_LUDICROUS_PERKY_KING);
	if (player.internalChimeraScore() >= 4) awardAchievement("Lesser Chimera", kACHIEVEMENTS.GENERAL_LESSER_CHIMERA);
	if (player.internalChimeraScore() >= 8) awardAchievement("Normal Chimera", kACHIEVEMENTS.GENERAL_NORMAL_CHIMERA);
	if (player.internalChimeraScore() >= 16) awardAchievement("Greater Chimera", kACHIEVEMENTS.GENERAL_GREATER_CHIMERA);
	if (player.internalChimeraScore() >= 32) awardAchievement("Elder Chimera", kACHIEVEMENTS.GENERAL_ELDER_CHIMERA);
	if (player.internalChimeraScore() >= 64) awardAchievement("Legendary Chimera", kACHIEVEMENTS.GENERAL_LEGENDARY_CHIMERA);
	if (player.internalChimeraScore() >= 128) awardAchievement("Ultimate Lifeform", kACHIEVEMENTS.GENERAL_ULTIMATE_LIFEFORM);
	if (player.str >= 50 && player.tou >= 50 && player.spe >= 50 && player.inte >= 50 && player.wis >= 50 && player.lib >= 40 && player.sens >= 20) awardAchievement("Jack of All Trades", kACHIEVEMENTS.GENERAL_STATS_50);
	if (player.str >= 100 && player.tou >= 100 && player.spe >= 100 && player.inte >= 100 && player.wis >= 100 && player.lib >= 80 && player.sens >= 40) awardAchievement("Incredible Stats", kACHIEVEMENTS.GENERAL_STATS_100);
	if (player.str >= 150 && player.tou >= 150 && player.spe >= 150 && player.inte >= 150 && player.wis >= 150 && player.lib >= 120 && player.sens >= 60) awardAchievement("Anmazing Stats", kACHIEVEMENTS.GENERAL_STATS_150);
	if (player.str >= 200 && player.tou >= 200 && player.spe >= 200 && player.inte >= 200 && player.wis >= 200 && player.lib >= 160 && player.sens >= 80) awardAchievement("Superhuman Stats", kACHIEVEMENTS.GENERAL_STATS_200);
	if (player.str >= 300 && player.tou >= 300 && player.spe >= 300 && player.inte >= 300 && player.wis >= 300 && player.lib >= 240 && player.sens >= 120) awardAchievement("Inhuman Stats", kACHIEVEMENTS.GENERAL_STATS_300);
	if (player.str >= 500 && player.tou >= 500 && player.spe >= 500 && player.inte >= 500 && player.wis >= 500 && player.lib >= 400 && player.sens >= 200) awardAchievement("Epic Stats", kACHIEVEMENTS.GENERAL_STATS_500);
	if (player.str >= 1000 && player.tou >= 1000 && player.spe >= 1000 && player.inte >= 1000 && player.wis >= 1000 && player.lib >= 800 && player.sens >= 400) awardAchievement("Legendary Stats", kACHIEVEMENTS.GENERAL_STATS_1000);
	if (player.str >= 2000 && player.tou >= 2000 && player.spe >= 2000 && player.inte >= 2000 && player.wis >= 2000 && player.lib >= 1600 && player.sens >= 800) awardAchievement("Mythical Stats", kACHIEVEMENTS.GENERAL_STATS_2000);
	if (player.str >= 5000 && player.tou >= 5000 && player.spe >= 5000 && player.inte >= 5000 && player.wis >= 5000 && player.lib >= 4000 && player.sens >= 2000) awardAchievement("Transcendental Stats", kACHIEVEMENTS.GENERAL_STATS_5000);
	if (player.str >= 15000 && player.tou >= 15000 && player.spe >= 15000 && player.inte >= 15000 && player.wis >= 15000 && player.lib >= 12000 && player.sens >= 6000) awardAchievement("Divine Stats", kACHIEVEMENTS.GENERAL_STATS_15000);
	if (player.str >= 268445279 && player.tou >= 268445279 && player.spe >= 268445279 && player.inte >= 268445279 && player.wis >= 268445279) awardAchievement("OPK", kACHIEVEMENTS.GENERAL_STATS_2000);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCHIZOPHRENIA] >= 4) awardAchievement("Schizophrenic", kACHIEVEMENTS.GENERAL_SCHIZO);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_CLEAN_SLATE] >= 2) awardAchievement("Clean Slate", kACHIEVEMENTS.GENERAL_CLEAN_SLATE);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] >= 100) awardAchievement("I'm No Lumberjack", kACHIEVEMENTS.GENERAL_IM_NO_LUMBERJACK);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] >= 100) awardAchievement("Deforester", kACHIEVEMENTS.GENERAL_DEFORESTER);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_HAMMER_TIME] >= 300) awardAchievement("Hammer Time", kACHIEVEMENTS.GENERAL_HAMMER_TIME);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCAVENGER] >= 200) awardAchievement("Nail Scavenger", kACHIEVEMENTS.GENERAL_NAIL_SCAVENGER);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_YABBA_DABBA_DOO] >= 100) awardAchievement("Yabba Dabba Doo", kACHIEVEMENTS.GENERAL_YABBA_DABBA_DOO);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_ANTWORKS] >= 200) awardAchievement("AntWorks", kACHIEVEMENTS.GENERAL_ANTWORKS);
	if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] >= 1) awardAchievement("Home Sweet Home", kACHIEVEMENTS.GENERAL_HOME_SWEET_HOME);
	if (player.tallness >= 132) awardAchievement("Up to Eleven", kACHIEVEMENTS.GENERAL_UP_TO_11);
	
	var NPCsDedicked:int = 0; //Check how many NPCs are dedicked.
	if (flags[kFLAGS.IZMA_NO_COCK] > 0) NPCsDedicked++;
	if (flags[kFLAGS.CERAPH_HIDING_DICK] > 0) NPCsDedicked++;
	if (flags[kFLAGS.RUBI_ADMITTED_GENDER] > 0 && flags[kFLAGS.RUBI_COCK_SIZE] <= 0) NPCsDedicked++;
	if (flags[kFLAGS.BENOIT_STATUS] == 1 || flags[kFLAGS.BENOIT_STATUS] == 2) NPCsDedicked++;
	if (flags[kFLAGS.ARIAN_HEALTH] > 0 && flags[kFLAGS.ARIAN_COCK_SIZE] <= 0) NPCsDedicked++;
	if (flags[kFLAGS.KATHERINE_UNLOCKED] > 0 && flags[kFLAGS.KATHERINE_DICK_COUNT] <= 0) NPCsDedicked++;
	if (flags[kFLAGS.MET_KITSUNES] > 0 && flags[kFLAGS.redheadIsFuta] == 0) NPCsDedicked++;
	if (flags[kFLAGS.KELT_BREAK_LEVEL] == 4) NPCsDedicked++;
	if (NPCsDedicked >= 3) awardAchievement("Dick Banisher", kACHIEVEMENTS.GENERAL_DICK_BANISHER);
	if (NPCsDedicked >= 7) awardAchievement("You Bastard", kACHIEVEMENTS.GENERAL_YOU_BASTARD); //Take that, dedickers!
	
	if (player.newGamePlusMod() >= 1) awardAchievement("xXx2: The Next Level", kACHIEVEMENTS.EPIC_XXX2_THE_NEXT_LEVEL);
	if (player.newGamePlusMod() >= 2) awardAchievement("xXx: The Return of Mareth Champion", kACHIEVEMENTS.EPIC_XXX_THE_RETURN_OF_MARETH_CHAMPION);
	if (player.newGamePlusMod() >= 3) awardAchievement("xXx 4", kACHIEVEMENTS.EPIC_XXX_4);
	if (player.newGamePlusMod() >= 4) awardAchievement("xXx 5: Mareth's Judgment_Day", kACHIEVEMENTS.EPIC_XXX5_MARETHS_JUDGMENT_DAY);
	if (player.newGamePlusMod() >= 5) awardAchievement("xXx 6: Rise of the Demons", kACHIEVEMENTS.EPIC_XXX6_RISE_OF_THE_DEMONS);/*
	if (player.newGamePlusMod() >= 6) awardAchievement("xXx 7: Salvation", kACHIEVEMENTS.EPIC_XXX7_SALVATION);
	if (player.newGamePlusMod() >= 7) awardAchievement("xXx 8: Genisys", kACHIEVEMENTS.EPIC_XXX8_GENISYS);
	if (player.newGamePlusMod() >= 8) awardAchievement("xXx 8: Dark Fate", kACHIEVEMENTS.EPIC_XXX9_DARK_FATE);*/
	
	if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] > 0 || flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] > 0) awardAchievement("My own Demon Weapon", kACHIEVEMENTS.EPIC_MY_OWN_DEMON_WEAPON);
	var EvolvingItems:int = 0;
	if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] > 0) EvolvingItems++;
	if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] > 0) EvolvingItems++;
	if (EvolvingItems >= 1) awardAchievement("Me Evolve", kACHIEVEMENTS.EPIC_ME_EVOLVE);
	if (EvolvingItems >= 2) awardAchievement("Us Evolve", kACHIEVEMENTS.EPIC_US_EVOLVE);
	//if (EvolvingItems >= 4) awardAchievement("They Evolve", kACHIEVEMENTS.EPIC_THEY_EVOLVE);
	//if (EvolvingItems >= 8) awardAchievement("Everyone Evolve", kACHIEVEMENTS.EPIC_EVERYONE_EVOLVE);
	
	if (player.hasPerk(PerkLib.GargoylePure) || player.hasPerk(PerkLib.GargoyleCorrupted)) awardAchievement("Guardian of Notre-Dame", kACHIEVEMENTS.EPIC_GUARDIAN_OF_NOTRE_DAME);
	if (player.hasStatusEffect(StatusEffects.PlayerPhylactery)) awardAchievement("The Devil Wears Prada", kACHIEVEMENTS.EPIC_THE_DEVIL_WEARS_PRADA);
	if (player.jiangshiScore() >= 20) awardAchievement("Thriller", kACHIEVEMENTS.EPIC_THRILLER);
	
	if (player.hasStatusEffect(StatusEffects.AchievementsNormalShadowTotal)) {
		//Shadow
		if (player.statusEffectv2(StatusEffects.AchievementsNormalShadowTotal) >= 1) awardAchievement("Shadow Initiate", kACHIEVEMENTS.SHADOW_INITIATE);
		if (player.statusEffectv2(StatusEffects.AchievementsNormalShadowTotal) >= 10) awardAchievement("Shadow Squire", kACHIEVEMENTS.SHADOW_SQUIRE);
		if (player.statusEffectv2(StatusEffects.AchievementsNormalShadowTotal) >= 25) awardAchievement("Shadow Knight", kACHIEVEMENTS.SHADOW_KNIGHT);
		if (player.statusEffectv2(StatusEffects.AchievementsNormalShadowTotal) >= 45) awardAchievement("Shadow Paladin", kACHIEVEMENTS.SHADOW_PALADIN);
		if (player.statusEffectv2(StatusEffects.AchievementsNormalShadowTotal) >= 70) awardAchievement("Shadow General", kACHIEVEMENTS.SHADOW_GENERAL);
		//Epic
		if (player.statusEffectv3(StatusEffects.AchievementsNormalShadowTotal) >= 10) awardAchievement("Achievementception", kACHIEVEMENTS.EPIC_ACHIEVEMENTCEPTION);
		if (player.statusEffectv3(StatusEffects.AchievementsNormalShadowTotal) >= 30) awardAchievement("Achievement within Achievement", kACHIEVEMENTS.EPIC_ACHIEVEMENT_WITHIN_ACHIEVEMENT);
		if (player.statusEffectv3(StatusEffects.AchievementsNormalShadowTotal) >= 60) awardAchievement("Achievements - Going Deeper (1st layer)", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_GOING_DEEPER_1L);
		if (player.statusEffectv3(StatusEffects.AchievementsNormalShadowTotal) >= 100) awardAchievement("Achievements - Going Deeper (2nd layer)", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_GOING_DEEPER_2L);
		if (player.statusEffectv3(StatusEffects.AchievementsNormalShadowTotal) >= 300) awardAchievement("Achievements - Going Deeper (3rd layer)", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_GOING_DEEPER_3L);
		if (player.statusEffectv3(StatusEffects.AchievementsNormalShadowTotal) >= 600) awardAchievement("Achievements Limbo", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_LIMBO);
		player.removeStatusEffect(StatusEffects.AchievementsNormalShadowTotal);
	}
}

/*
private function fixHistory():void {
	outputText("<b>New history perks are available during creation.  Since this character was created before they were available, you may choose one now!</b>", true);
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00418] = 2;
	menu();
	doNext(10036);
}
*/
}
}