package classes.Scenes{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Camp.CabinProgress;
	import classes.Scenes.NPCs.*;
	import classes.Scenes.Dungeons.*;

	import coc.view.MainView;

	public class Camp extends NPCAwareContent{

		protected function set timeQ(value:Number):void
		{
			kGAMECLASS.timeQ = value;
		}

		private function get campQ():Boolean
		{
			return kGAMECLASS.campQ;
		}
		private function set campQ(value:Boolean):void
		{
			kGAMECLASS.campQ = value;
		}

		protected function hasItemInStorage(itype:ItemType):Boolean
		{
			return kGAMECLASS.inventory.hasItemInStorage(itype);
		}
		protected function hasItemsInStorage():Boolean
		{
			return kGAMECLASS.inventory.hasItemsInStorage();
		}
		protected function hasItemsInRacks(type:Number = 0):Boolean
		{
			return kGAMECLASS.inventory.hasItemsInRacks(type);
		}
		public function Camp()
		{
		}
		
		public var cabinProgress:CabinProgress = new CabinProgress();
		public var codex:Codex = new Codex();
		public var dungeon1:Factory = new Factory();
		public var dungeon2:DeepCave = new DeepCave();
		//public var dungeon3:LethiceCastle = new LethiceCastle();
		public var dungeonS:DesertCave = new DesertCave();
		public var dungeonH:HelDungeon = new HelDungeon();
		
//  SLEEP_WITH:int = 701;

	//Used to determine scenes if you choose to play joke on them. Should the variables be moved to flags?
	protected var izmaJoinsStream:Boolean;
	protected var marbleJoinsStream:Boolean;
	protected var heliaJoinsStream:Boolean;
	protected var amilyJoinsStream:Boolean;

	
public function doCamp():void {
	//Force autosave on HARDCORE MODE! And level-up.
	if (player.slotName != "VOID" && mainView.getButtonText(0) != "Game Over" && flags[kFLAGS.HARDCORE_MODE] > 0) 
	{
		trace("Autosaving to slot: " + player.slotName);
		
		getGame().saves.saveGame(player.slotName);
	}
	kGAMECLASS.tooltipLoc = "";
	//trace("Current fertility: " + player.totalFertility());
	mainView.showMenuButton( MainView.MENU_NEW_MAIN );
	if(player.findStatusAffect(StatusAffects.PostAkbalSubmission) >= 0) {
		player.removeStatusAffect(StatusAffects.PostAkbalSubmission);
		kGAMECLASS.forest.akbalScene.akbalSubmissionFollowup();
		return;
	}
	if(player.findStatusAffect(StatusAffects.PostAnemoneBeatdown) >= 0) {
		HPChange(Math.round(player.maxHP()/2),false);
		player.removeStatusAffect(StatusAffects.PostAnemoneBeatdown);
	}
	//make sure gameState is cleared if coming from combat or giacomo
	gameState = 0;
	if(kGAMECLASS.inDungeon) {
		mainView.showMenuButton( MainView.MENU_DATA );
		mainView.showMenuButton( MainView.MENU_APPEARANCE );
		kGAMECLASS.dungeons.checkRoom();
		return;
	}
	//Clear out Izma's saved loot status
	flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = "";
	//History perk backup
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00418] == 0) {
		hideMenus();
		fixHistory();
		return;
	}
	fixFlags();
	if(!marbleScene.marbleFollower())
	{
		if(flags[kFLAGS.MARBLE_LEFT_OVER_CORRUPTION] == 1 && player.cor <= 40)
		{
			hideMenus();
			marblePurification.pureMarbleDecidesToBeLessOfABitch();
			return;
		}
	}
	if(marbleScene.marbleFollower())
	{
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
			if(flags[kFLAGS.MARBLE_WARNED_ABOUT_CORRUPTION] == 0 && player.cor >= 50)
			{
				hideMenus();
				marblePurification.marbleWarnsPCAboutCorruption();
				return;
			}
			if(flags[kFLAGS.MARBLE_WARNED_ABOUT_CORRUPTION] == 1 && flags[kFLAGS.MARBLE_LEFT_OVER_CORRUPTION] == 0 && player.cor >= 60)
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
	if(flags[kFLAGS.JACK_FROST_PROGRESS] > 0) {
		hideMenus();
		kGAMECLASS.processJackFrostEvent();
		return;
	}
	if(player.hasKeyItem("Super Reducto") < 0 && milkSlave() && player.findStatusAffect(StatusAffects.CampRathazul) >= 0 && player.statusAffectv2(StatusAffects.MetRathazul) >= 4) {
		hideMenus();
		milkWaifu.ratducto();
		return;
	}
	if(kGAMECLASS.nieveHoliday() && model.time.hours == 6) {
		if(player.hasKeyItem("Nieve's Tear") >= 0 && flags[kFLAGS.NIEVE_STAGE] != 5)
		{
			kGAMECLASS.returnOfNieve();
			hideMenus();
			return;
		}
		else if(flags[kFLAGS.NIEVE_STAGE] == 0) {
			hideMenus();
			kGAMECLASS.snowLadyActive();
			return;
		}
		else if(flags[kFLAGS.NIEVE_STAGE] == 4) {
			hideMenus();
			kGAMECLASS.nieveComesToLife();
			return;
		}
	}
	if (kGAMECLASS.helScene.followerHel()) {
		if (helFollower.isHeliaBirthday() && flags[kFLAGS.HEL_FOLLOWER_LEVEL] >= 2 && flags[kFLAGS.HELIA_BIRTHDAY_OFFERED] == 0) {
			hideMenus();
			helFollower.heliasBirthday();
			return;
		}
		if (kGAMECLASS.helScene.pregnancy.isPregnant) {
			switch (kGAMECLASS.helScene.pregnancy.eventTriggered()) {
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
						if (kGAMECLASS.helScene.pregnancy.incubation == 0 && (model.time.hours == 6 || model.time.hours == 7)) {
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
	if(flags[kFLAGS.HELSPAWN_AGE] == 2 && flags[kFLAGS.HELSPAWN_WEAPON] == 0 && flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] == 3 && model.time.hours >= 10 && model.time.hours <= 18) {
		hideMenus();
		helSpawnScene.helSpawnChoosesAFightingStyle();
		return;
	}
	if(flags[kFLAGS.HELSPAWN_AGE] == 2 && (model.time.hours == 6 || model.time.hours == 7) && flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] == 7 && flags[kFLAGS.HELSPAWN_FUCK_INTERRUPTUS] == 1) {
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
	if(!kGAMECLASS.nieveHoliday() && model.time.hours == 6 && flags[kFLAGS.NIEVE_STAGE] > 0) {
		kGAMECLASS.nieveIsOver();
		return;
	}
	//Amily followup!
	if(flags[kFLAGS.PC_PENDING_PREGGERS] == 1) {
		kGAMECLASS.amilyScene.postBirthingEndChoices();
		flags[kFLAGS.PC_PENDING_PREGGERS] = 2;
		return;
	}
	if(timeQ > 0) {
		if(!campQ) {
			outputText("More time passes...\n", true);
			goNext(timeQ, false);
			return;
		}
		else {
			if(model.time.hours < 6 || model.time.hours > 20) {
				eventParser(41);
				return;
			}
			else {
				eventParser(11);
				return;
			}
		}
	}
	if(flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] > 0) {
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
	//Jojo treeflips!
	if(flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && player.findStatusAffect(StatusAffects.PureCampJojo) >= 0) {
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
	if(player.findStatusAffect(StatusAffects.CampAnemoneTrigger) >= 0) {
		player.removeStatusAffect(StatusAffects.CampAnemoneTrigger);
		anemoneScene.anemoneKidBirthPtII();
		hideMenus();
		return;
	}
	//Exgartuan clearing
	if(player.statusAffectv1(StatusAffects.Exgartuan) == 1 && (player.cockArea(0) < 100 || player.cocks.length == 0)) {
		exgartuanCampUpdate();
		return;
	}
	else if(player.statusAffectv1(StatusAffects.Exgartuan) == 2 && player.biggestTitSize() < 12) {
		exgartuanCampUpdate();
		return;
	}
	//Izzys tits asplode
	if(isabellaFollower() && flags[kFLAGS.ISABELLA_MILKED_YET] >= 10 && player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") >= 0) {
		isabellaFollowerScene.milktasticLacticLactation();
		hideMenus();
		return;
	}
	//Marble meets follower izzy when moving in
	if(flags[kFLAGS.ISABELLA_MURBLE_BLEH] == 1 && isabellaFollower() && player.findStatusAffect(StatusAffects.CampMarble) >= 0) {
		isabellaFollowerScene.angryMurble();
		hideMenus();
		return;
	}
	//Cotton preg freakout
	if (player.pregnancyIncubation <= 280 && player.pregnancyType == PregnancyStore.PREGNANCY_COTTON &&
	   	flags[kFLAGS.COTTON_KNOCKED_UP_PC_AND_TALK_HAPPENED] == 0 && (model.time.hours == 6 || model.time.hours == 7)) {
		kGAMECLASS.telAdre.cotton.goTellCottonShesAMomDad();
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
	if(!kGAMECLASS.urtaQuest.urtaBusy() && flags[kFLAGS.AMILY_VISITING_URTA] == 0 && rand(10) == 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00146] >= 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00147] == 0 && flags[kFLAGS.AMILY_NEED_TO_FREAK_ABOUT_URTA] == 1 && amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && !amilyScene.pregnancy.isPregnant) {
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
	//Rathazul freaks out about jojo
	if(flags[kFLAGS.RATHAZUL_CORRUPT_JOJO_FREAKOUT] == 0 && rand(5) == 0 && player.findStatusAffect(StatusAffects.CampRathazul) >= 0 && campCorruptJojo()) {
		finter.rathazulFreaksOverJojo();
		hideMenus();
		return;
	}
	//Izma/Marble freakout - marble moves in
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00237] == 1) {
		izmaScene.newMarbleMeetsIzma();
		hideMenus();
		return;
	}
	//Izma/Amily freakout - Amily moves in
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00236] == 1) {
		izmaScene.newAmilyMeetsIzma();
		hideMenus();
		return;
	}
	//Amily/Marble Freakout
	if(flags[kFLAGS.AMILY_NOT_FREAKED_OUT] == 0 && player.findStatusAffect(StatusAffects.CampMarble) >= 0 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower()) {
		finter.marbleVsAmilyFreakout();
		hideMenus();
		return;
	}
	//Amily and/or Jojo freakout about Vapula!!
	if(vapulaSlave() && ((player.findStatusAffect(StatusAffects.PureCampJojo) >= 0 && flags[kFLAGS.KEPT_PURE_JOJO_OVER_VAPULA] <= 0) || (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt() && flags[kFLAGS.KEPT_PURE_AMILY_OVER_VAPULA] <= 0))) {
		//Jojo but not Amily
		if(player.findStatusAffect(StatusAffects.PureCampJojo) >= 0 && !(amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) && flags[kFLAGS.KEPT_PURE_JOJO_OVER_VAPULA] == 0)
			vapula.mouseWaifuFreakout(false,true);
		//Amily but not Jojo
		else if ((amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) && !player.findStatusAffect(StatusAffects.PureCampJojo) && flags[kFLAGS.KEPT_PURE_AMILY_OVER_VAPULA] == 0) {
			vapula.mouseWaifuFreakout(true,false);
		}
		//Both
		else vapula.mouseWaifuFreakout(true,true);
		hideMenus();
		return;
	}
	//Go through Helia's first time move in interactions if  you haven't yet.
	if(flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 2 && kGAMECLASS.helScene.followerHel() && flags[kFLAGS.HEL_INTROS_LEVEL] == 0) {
		helFollower.helFollowersIntro();
		hideMenus();
		return;
	}
	//If you've gone through Hel's first time actions and Issy moves in without being okay with threesomes.
	if(flags[kFLAGS.HEL_INTROS_LEVEL] > 9000 && kGAMECLASS.helScene.followerHel() && isabellaFollower() && flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] == 0) {
		helFollower.angryHelAndIzzyCampHelHereFirst();
		hideMenus();
		return;		
	}
	//Reset.
	flags[kFLAGS.CAME_WORMS_AFTER_COMBAT] = 0;
	campQ = false;
	//Build explore menus
	var farm:* = 0;
	var placesNum:* = 0;
	var followers:* = 0;
	var lovers:* = 0;
	var slaves:* = 0;
	var storage:* = 0;
	var canCampStuff:* = 0;
	if(stash()) storage = initiateStash;
	if(placesCount() > 0) placesNum = 71; 
	if(kGAMECLASS.whitney > 0) farm = 7;
	//Clear stuff
	if(player.findStatusAffect(StatusAffects.SlimeCravingOutput) >= 0) player.removeStatusAffect(StatusAffects.SlimeCravingOutput);
	//Reset luststick display status (see event parser)
	flags[kFLAGS.PC_CURRENTLY_LUSTSTICK_AFFECTED] = 0;
	//Display Proper Buttons
	mainView.showMenuButton( MainView.MENU_APPEARANCE );
	mainView.showMenuButton( MainView.MENU_PERKS );
	mainView.showMenuButton( MainView.MENU_STATS );
	mainView.showMenuButton( MainView.MENU_DATA );
	showStats();
	//Change settings of new game buttons to go to main menu
	mainView.setMenuButton( MainView.MENU_NEW_MAIN, "Main Menu", kGAMECLASS.mainMenu );

	//clear up/down arrows
	hideUpDown();
	//Level junk
	if(player.XP >= (player.level) * 100 || player.perkPoints > 0 || player.statPoints > 0) {
		if (player.XP < player.level * 100)
		{
			if (player.statPoints > 0) mainView.setMenuButton( MainView.MENU_LEVEL, "Stat Up" );
			else mainView.setMenuButton( MainView.MENU_LEVEL, "Perk Up" );
		}
		else
			mainView.setMenuButton( MainView.MENU_LEVEL, "Level Up" );
		mainView.showMenuButton( MainView.MENU_LEVEL );
		mainView.statsView.showLevelUp();
	}
	else {
		mainView.hideMenuButton( MainView.MENU_LEVEL );
		mainView.statsView.hideLevelUp();
	}
	//Build main menu
	
	
	var masturbate:* = 0;
	var rest:* = 0;
	var explore:* = 2;
	if(player.fatigue > 50) rest = 11;	
	if(player.lust > 30) masturbate = 42;
	outputText("", true);
	updateAchievements();
	
	outputText(images.showImage("camping"), false);
	//Isabella upgrades camp level!


	if(isabellaFollower()) {
		outputText("Your campsite got a lot more comfortable once Isabella moved in.  Carpets cover up much of the barren ground, simple awnings tied to the rocks provide shade, and hand-made wooden furniture provides comfortable places to sit and sleep.  ", false);
	}
	//Live in-ness
	else {
		if(model.time.days < 10) outputText("Your campsite is fairly simple at the moment.  Your tent and bedroll are set in front of the rocks that lead to the portal.  You have a small fire pit as well.  ", false);
		if(model.time.days >= 10 && model.time.days < 20) outputText("Your campsite is starting to get a very 'lived-in' look.  The fire-pit is well defined with some rocks you've arranged around it, and your bedroll and tent have been set up in the area most sheltered by rocks.  ", false);
		if(model.time.days >= 20) 
		{
			if (!isabellaFollower()) outputText("Your new home is as comfy as a camp site can be. ", false);
			outputText("The fire-pit ", false);
			if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0) outputText("is ", false);
			else outputText("and tent are both ", false);
			outputText("set up perfectly, and in good repair.  ", false);
		}
	}
	if(model.time.days >= 20) outputText("You've even managed to carve some artwork into the rocks around the camp's perimeter.\n\n", false);
	if(flags[kFLAGS.CAMP_CABIN_PROGRESS] == 9) outputText("There's an unfinished wooden structure. As of right now, it's just frames nailed together.\n\n", false)
	if(flags[kFLAGS.CAMP_CABIN_PROGRESS] == 10) outputText("There's an unfinished cabin. It's currently missing windows and door.\n\n", false)
	if(flags[kFLAGS.CAMP_CABIN_PROGRESS] == 11) outputText("There's a nearly-finished cabin. It looks complete from the outside but inside, it's missing flooring.\n\n", false)
	if(flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 12) outputText("Your cabin is situated near the edge of camp.\n\n", false)
	if(flags[kFLAGS.CLARA_IMPRISONED] > 0) 
	{
		marblePurification.claraCampAddition();
	}
	//Nursery
	if(flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] == 100 && player.findStatusAffect(StatusAffects.CampMarble) >= 0) {
		outputText("  Marble has built a fairly secure nursery amongst the rocks to house your ",false);
		if(flags[kFLAGS.MARBLE_KIDS] == 0) outputText("future children", false);
		else {
			outputText(num2Text(flags[kFLAGS.MARBLE_KIDS]) + " child", false);
			if(flags[kFLAGS.MARBLE_KIDS] > 1) outputText("ren", false);
		}
		outputText(".", false);
	}
	//HARPY ROOKERY
	if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] > 0) {
		//Rookery Descriptions (Short)
		//Small (1 mature daughter)
		if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] == 1) {
			outputText("  There's a smallish harpy nest that your daughter has built up with rocks piled high near the fringes of your camp.  It's kind of pathetic, but she seems proud of her accomplishment.");
		}
		//Medium (2-3 mature daughters)
		else if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 3) {
			outputText("  There's a growing pile of stones built up at the fringes of your camp.  It's big enough to be considered a small hill by this point, dotted with a couple small harpy nests just barely big enough for two.");
		}
		//Big (4 mature daughters)
		else if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 4) {
			outputText("  The harpy rookery at the edge of camp has gotten pretty big.  It's taller than most of the standing stones that surround the portal, and there's more nests than harpies at this point.  Every now and then you see the four of them managing a boulder they dragged in from somewhere to add to it.");
		}
		//Large (5-10 mature daughters)
		else if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 10) {
			outputText("  The rookery has gotten quite large.  It stands nearly two stories tall at this point, dotted with nests and hollowed out places in the center.  It's surrounded by the many feathers the assembled harpies leave behind.");
		}
		//Giant (11-20 mature daughters)
		else if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 20) {
			outputText("  A towering harpy rookery has risen up at the fringes of your camp, filled with all of your harpy brood.  It's at least three stories tall at this point, and it has actually begun to resemble a secure structure.  These harpies are always rebuilding and adding onto it.");
		}
		//Massive (21-50 mature daughters)
		else if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] <= 50) {
			outputText("  A massive harpy rookery towers over the edges of your camp.  It's almost entirely built out of stones that are fit seamlessly into each other, with many ledges and overhangs for nests.  There's a constant hum of activity over there day or night.");
		}
		//Immense (51+ Mature daughters)
		else {
			outputText("  An immense harpy rookery dominates the edge of your camp, towering over the rest of it.  Innumerable harpies flit around it, always working on it, assisted from below by the few sisters unlucky enough to be flightless.");
		}
	}
	//Traps
	if(player.findStatusAffect(StatusAffects.DefenseCanopy) >= 0) {
		outputText("  A thorny tree has sprouted near the center of the camp, growing a protective canopy of spiky vines around the portal and your camp.", false);
	}
	else outputText("  You have a number of traps surrounding your makeshift home, but they are fairly simple and may not do much to deter a demon.", false);
	outputText("  The portal shimmers in the background as it always does, looking menacing and reminding you of why you came.\n\n", false);

	//Ember's anti-minotaur crusade!
	if(flags[kFLAGS.EMBER_CURRENTLY_FREAKING_ABOUT_MINOCUM] == 1) {
		//Modified Camp Description
		outputText("Since Ember began " + emberMF("his","her") + " 'crusade' against the minotaur population, skulls have begun to pile up on either side of the entrance to " + emberScene.emberMF("his","her") + " den.  There're quite a lot of them.\n\n");
	}
	//Dat tree!
	if(flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0) {
		outputText("On the outer edges, half-hidden behind a rock, is a large, very healthy tree.  It grew fairly fast, but seems to be fully developed now.  Holli, Marae's corrupt spawn, lives within.\n\n");
	}
	if(flags[kFLAGS.CLARA_IMPRISONED] > 0)
	{
		//claraCampAddition();
	}
	//BIMBO SOPHAH
	if(bimboSophie() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) sophieBimbo.sophieCampLines();
	if(player.findStatusAffect(StatusAffects.CampMarble) >= 0) {
		temp = rand(5);
		outputText("A second bedroll rests next to yours; a large two-handed hammer sometimes rests against it, depending on whether or not its owner needs it at the time.  ", false);
		//Marble is out!
		if(flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 4) outputText("Marble isn’t here right now; she’s still off to see her family.");
		//requires at least 1 kid, time is just before sunset, this scene always happens at this time if the PC has at least one kid.
		else if(flags[kFLAGS.MARBLE_KIDS] >= 1 && (model.time.hours == 19 || model.time.hours == 20)) {
			outputText("Marble herself is currently in the nursery, putting your ");
			if(flags[kFLAGS.MARBLE_KIDS] == 1) outputText("child");
			else outputText("children");
			outputText(" to bed.");
		}
		//at 6-7 in the morning, scene always displays at this time
		else if(model.time.hours == 6 || model.time.hours == 7) outputText("Marble is off in an open area to the side of your camp right now.  She is practicing with her large hammer, going through her daily training.");
		//after nightfall, scene always displays at this time unless PC is wormed
		else if(model.time.hours >= 21 && player.findStatusAffect(StatusAffects.Infested) < 0) {
			outputText("Marble is hanging around her bedroll waiting for you to come to bed.  However, sometimes she lies down for a bit, and sometimes she paces next to it.");
			if(flags[kFLAGS.MARBLE_LUST] > 30) outputText("  She seems to be feeling antsy.");
		}
		else if(flags[kFLAGS.MARBLE_KIDS] > 0 && model.time.hours < 19 && model.time.hours > 7) {
			//requires at least 6 kids, and no other parental characters in camp
			if(rand(2) == 0 && flags[kFLAGS.MARBLE_KIDS] > 5) outputText("Marble is currently tending to your kids, but she looks a bit stressed out right now.  It looks like " + num2Text(flags[kFLAGS.MARBLE_KIDS]) + " might just be too many for her to handle on her own...");
			//requires at least 4 kids
			else if(rand(3) == 0 && flags[kFLAGS.MARBLE_KIDS] > 3) outputText("Marble herself is in the camp right now, telling a story about her travels around the world to her kids as they gather around her.  The children are completely enthralled by her words.  You can't help but smile.");
			//Requires 2 boys
			else if(rand(3) == 0 && flags[kFLAGS.MARBLE_BOYS] > 1)
			{
				outputText("Marble herself is currently refereeing a wrestling match between two of your sons.  It seems like it's a contest to see which one of them gets to go for a ride between her breasts in a game of <i>Bull Blasters</i>, while the loser has to sit on her shoulders.");
			}
			//requires at least 2 kids
			else if(rand(3) == 0 && flags[kFLAGS.MARBLE_KIDS] - flags[kFLAGS.MARBLE_BOYS] > 1) outputText("Marble herself is involved in a play fight with two of your kids brandishing small sticks.  It seems that the <i>mommy monster</i> is terrorising the camp and needs to be stopped by the <i>Mighty Moo and her sidekick Bovine Lass</i>.");
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
					outputText(" playing around the camp right now.");
				}
			}
		}
		//(Choose one of these at random to display each hour)
		else if(temp == 0) outputText("Marble herself has gone off to Whitney's farm to get milked right now.  You're sure she'd be back in moments if you needed her.", false);
		else if(temp == 1) outputText("Marble herself has gone off to Whitney's farm to do some chores right now.  You're sure she'd be back in moments if you needed her.", false);
		else if(temp == 2) outputText("Marble herself isn't at the camp right now; she is probably off getting supplies, though she'll be back soon enough.  You're sure she'd be back in moments if you needed her.", false);
		else if(temp == 3) {
			outputText("Marble herself is resting on her bedroll right now.", false);
			
		}
		else if(temp == 4) {
			outputText("Marble herself is wandering around the camp right now.", false);
		}
		outputText("\n\n", false);	
	}
	//RATHAZUL
	//if rathazul has joined the camp
	if(player.findStatusAffect(StatusAffects.CampRathazul) >= 0) {
		if(flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] <= 1) {
			outputText("Tucked into a shaded corner of the rocks is a bevy of alchemical devices and equipment.  ", false);
			if (!(model.time.hours > 4 && model.time.hours < 23)) outputText("The alchemist is absent from his usual work location. He must be sleeping right now.", false);
			else outputText("The alchemist Rathazul looks to be hard at work with his chemicals, working on who knows what.", false);
			if(flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] == 1) outputText("  Some kind of spider-silk-based equipment is hanging from a nearby rack.  <b>He's finished with the task you gave him!</b>", false);
			outputText("\n\n", false);
		}
		else outputText("Tucked into a shaded corner of the rocks is a bevy of alchemical devices and equipment.  The alchemist Rathazul looks to be hard at work on the silken equipment you've commissioned him to craft.\n\n", false);
	}
	else
	{
		if (flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] == 1)
		{
			outputText("There is a note on your ", false);
			if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0)
			{
				outputText("bed inside your cabin.", false);
			}
			else
			{
				outputText("bedroll", false);
			}
			outputText(". It reads \"<i>Come see me at the lake. I've finished your spider silk ", false)
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] == 1)
			{
				outputText("armor", false);
			}
			else
			{
				outputText("robes", false);
			}
			outputText(". -Rathazul</i>\".", false);
			outputText("\n\n", false);			
		}
	}
	//MOUSEBITCH
	if(amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1) {
		if(flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4) outputText("Amily has relocated her grass bedding to the opposite side of the camp from the strange tree; every now and then, she gives it a suspicious glance, as if deciding whether to move even further.");
		else outputText("A surprisingly tidy nest of soft grasses and sweet-smelling herbs has been built close to your " + (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 ? "cabin": "bedroll") + ". A much-patched blanket draped neatly over the top is further proof that Amily sleeps here. She changes the bedding every few days, to ensure it stays as nice as possible.\n\n", false);
	}
	//Corrupt mousebitch!
	else if(amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 2 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) {
		outputText("Sometimes you hear a faint moan from not too far away. No doubt the result of your slutty toy mouse playing with herself.\n\n", false);
	}
	//Amily out freaking Urta?
	else if(flags[kFLAGS.AMILY_VISITING_URTA] == 1 || flags[kFLAGS.AMILY_VISITING_URTA] == 2) {
		outputText("Amily's bed of grass and herbs lies empty, the mouse-woman still absent from her sojourn to meet your other lover.\n\n", false);
	}
	//JOJO
	//If Jojo is corrupted, add him to the masturbate menu.
	if(campCorruptJojo() && flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 0) outputText("From time to time you can hear movement from around your camp, and you routinely find thick puddles of mouse semen.  You are sure Jojo is here if you ever need to sate yourself.\n\n", false);
	//Pure Jojo
	if (player.findStatusAffect(StatusAffects.PureCampJojo) >= 0) {
		outputText("There is a small bedroll for Jojo near your own", false);
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) outputText(" cabin");
		if (!(model.time.hours > 4 && model.time.hours < 23)) outputText(" and the mouse is sleeping on it right now.\n\n", false);
		else outputText(", though the mouse is probably hanging around the camp's perimeter.\n\n", false);
	}
	
	//Izma
	if(izmaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
		outputText("Neatly laid near the base of your own is a worn bedroll belonging to Izma, your tigershark lover.  It's a snug fit for her toned body, though it has some noticeable cuts and tears in the fabric.  Close to her bed is her old trunk, almost as if she wants to have it at arms length if anyone tries to rob her in her sleep.  ", false);
		temp = rand(3);
		//Text 1} I
		if(temp == 0) outputText("Izma's lazily sitting on the trunk beside her bedroll, reading one of the many books from inside it.  She smiles happily when your eyes linger on her, and you know full well she's only half-interested in it.", false);
		//Text 2
		else if(temp == 1) outputText("You notice Izma isn't around right now.  She's probably gone off to the nearby stream to get some water.  Never mind, she comes around from behind a rock, still dripping wet.", false);
		//Text 3 
		else outputText("Izma is lying on her back near her bedroll.  You wonder at first just why she isn't using her bed, but as you look closer you notice all the water pooled beneath her and the few droplets running down her arm, evidence that she's just returned from the stream.", false);
		outputText("\n\n", false);
	}
	//►[Added Campsite Description]
	if(kGAMECLASS.desert.antsScene.phyllaWaifu()) {
		outputText("You see Phylla's anthill in the distance.  Every now and then you see");
		//If PC has children w/ Phylla:
		if(flags[kFLAGS.ANT_KIDS] > 0) outputText(" one of your many children exit the anthill to unload some dirt before continuing back down into the colony.  It makes you feel good knowing your offspring are so productive.");
		else outputText(" Phylla appear out of the anthill to unload some dirt.  She looks over to your campsite and gives you an excited wave before heading back into the colony.  It makes you feel good to know she's so close.");
		outputText("\n\n");
	}
	//Clear bee-status
	if(player.findStatusAffect(StatusAffects.ParalyzeVenom) >= 0) {
		dynStats("str", player.statusAffectv1(StatusAffects.ParalyzeVenom),"spe", player.statusAffectv2(StatusAffects.ParalyzeVenom));
		player.removeStatusAffect(StatusAffects.ParalyzeVenom);
		outputText("<b>You feel quicker and stronger as the paralyzation venom in your veins wears off.</b>\n\n", false);
	}
	
	//Hunger check!
	if (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger < 25)
	{
		outputText("<b>Your stomach is growling " + (player.hunger < 1 ? "painfully": "loudly") + ". You have to eat something. </b>", false);
		if (player.hunger < 10) {
			outputText("<b>You are getting thinner and you're losing muscles.</b>");
		}
		if (player.hunger <= 0) {
			outputText("<b>You are getting weaker due to starvation. </b>");
		}
		outputText("\n\n");
	}
	
	//The uber horny
	if(player.lust >= 100) {
		if(player.findStatusAffect(StatusAffects.Dysfunction) >= 0) {
			outputText("<b>You are debilitatingly aroused, but your sexual organs are so numbed the only way to get off would be to find something tight to fuck or get fucked...</b>\n\n", false);
		}
		else if(flags[kFLAGS.UNABLE_TO_MASTURBATE_BECAUSE_CENTAUR] > 0 && player.isTaur()) {
			outputText("<b>You are delibitatingly aroused, but your sex organs are so difficult to reach that masturbation isn't at the forefront of your mind.</b>\n\n", false);
		}
		else {
			outputText("<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>\n\n", false);
		}
	}
	//Set up rest stuff
	//Night
	if(model.time.hours < 6 || model.time.hours > 20) {
		outputText("It is dark out, made worse by the lack of stars in the sky.  A blood-red moon hangs in the sky, seeming to watch you, but providing little light.  It's far too dark to leave camp.\n\n", false);
		if (companionsCount() > 0 && !(model.time.hours > 4 && model.time.hours < 23)) {
			outputText("Your camp is silent as your companions are sleeping right now.\n", false);
		}
	}
	//Day Time!
	else {
		if (model.time.hours == 19) outputText("The sun is close to the horizon, getting ready to set. ", false);
		if (model.time.hours == 20) outputText("The sun has already set below the horizon. The sky glows orange. ", false);
		outputText("It's light outside, a good time to explore and forage for supplies with which to fortify your camp.\n", false);
	}
	
	//Unlock cabin.
	if (flags[kFLAGS.CAMP_CABIN_PROGRESS] <= 0 && model.time.days >= 30)
	{
		flags[kFLAGS.CAMP_CABIN_PROGRESS] = 1;
		outputText("You realize that you have spent a month sleeping in tent every night. You think of something so you can sleep nicely and comfortably.", true)
		doNext(1);
		return;
	}
	
	//Unlock something in character creation.
	if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] == 0)
	{
		if (player.gender == 3)
		{
			(flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] = 1)
			outputText("\n\n<b>Congratulations! You have unlocked hermaphrodite option on character creation, accessible from New Game Plus!</b>");
			kGAMECLASS.saves.savePermObject(false);
		}
	}
	//Menu
	//choices("Explore", explore, "Places", placesNum, "Inventory", 1000, "Stash", storage, "Followers", followers, "Lovers", lovers, "Slaves", slaves, "Camp Actions", canCampStuff, baitText, masturbate, restName, restEvent);
	menu();
	addButton(0, "Explore", eventParser, explore);
	if (placesCount() > 0) addButton(1, "Places", places);
	addButton(2, "Camp Action", campActions);
	addButton(3, "Inventory", eventParser, 1000);
	if(stash()) addButton(4, "Stash", initiateStash);
	if (followersCount() > 0) addButton(5, "Followers", campFollowers);
	if (loversCount() > 0) addButton(6, "Lovers", campLoversMenu);
	if (slavesCount() > 0) addButton(7, "Slaves", campSlavesMenu);
	if (player.lust >= 30) {
		addButton(8, "Masturbate", eventParser, 10);
		if (((player.findPerk(PerkLib.HistoryReligious) >= 0 && player.cor <= 66) || (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < 10)) && !(player.findStatusAffect(StatusAffects.Exgartuan) >= 0 && player.statusAffectv2(StatusAffects.Exgartuan) == 0) || flags[kFLAGS.SFW_MODE] >= 1) addButton(8, "Meditate", eventParser, 10);
	}
	addButton(9, "Wait", eventParser, 40);
	if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(9, "Rest", eventParser, 11);
	if (model.time.hours >= 21 || model.time.hours < 6) addButton(9, "Sleep", eventParser, 41);

	//Remove buttons according to conditions.
	if (model.time.hours >= 21 || model.time.hours < 6) {
		removeButton(0);
		removeButton(1);
		if (model.time.hours >= 23 || model.time.hours < 5) {
			removeButton(4);
			removeButton(5);
			removeButton(6);
			removeButton(7);
		}
	}
	if (player.lust >= 100) {
		removeButton(0);
		removeButton(1);
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] < kGAMECLASS.modSaveVersion) {
		promptSaveUpdate();
	}
	
	//Massive Balls Bad End (Realistic Mode only)
	if (flags[kFLAGS.HUNGER_ENABLED] >= 1 && player.ballSize > (18 + (player.str / 2))) {
		badEndGIANTBALLZ();
	}
	//Hunger Bad End
	if (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger <= 0)
	{
		//Bad end at 0 HP!
		if (player.HP <= 0 && (player.str + player.tou) < 30)
		{
			badEndHunger();
		}
	}
	//Min Lust Bad End (Must not have any removable/temporary min lust.)
	if (player.minLust() >= 100 && !flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= 168 && !player.eggs() >= 20 && !player.findStatusAffect(StatusAffects.BimboChampagne) >= 0 && !player.findStatusAffect(StatusAffects.Luststick) >= 0 && player.jewelryEffectId != 1)
	{
		badEndMinLust();
	}
}

//-----------------
//-- STORAGE
//-----------------
public function initiateStash():void {
	trace("Initiating stash");
	stash(false);
}	

public function stash(exists:Boolean = true):Boolean {
	//Use to know if to show/hide stash.
	if(exists) {
		return flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00254] > 0 || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00255] > 0 || player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0 || itemStorage.length > 0 || flags[kFLAGS.ANEMONE_KID] > 0;
	}
	hideMenus();
	/*Hacked in cheat to enable shit
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00254] = 1;
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00255] = 1;*/
	//REMOVE THE ABOVE BEFORE RELASE ()
	var retrieveStuff:Function = null;
	var storeStuff:Number = 0;
	if(hasItemsInStorage()) retrieveStuff = kGAMECLASS.inventory.chooseRetrievalSlot;
	if(itemStorage.length > 0) storeStuff = 1028;
	var weaponRack:Function = null;
	var weaponRetrieve:Function = null;
	var armorRack:Function = null;
	var armorRetrieve:Function = null;
	var jewelBox:Function = null;
	var jewelRetrieve:Function = null;
	var barrel:* = 0;
	outputText("", true);
	if(flags[kFLAGS.ANEMONE_KID] > 0) {
		//(morning)
		if(model.time.hours < 6 || model.time.hours > 22) outputText("Kid A is sleeping in her barrel right now.");
		else if(model.time.hours <= 10) outputText("Kid A stands next to her barrel, refilling it from one of your waterskins.  A second full skin is slung over her shoulder.  She gives you a grin.\n\n");
		else if(flags[kFLAGS.KID_SITTER] > 1) outputText("Kid A is absent from her barrel right now, dragooned into babysitting again.\n\n");
		//(midday)
		else if(model.time.hours < 16) outputText("Kid A is deep in her barrel with the lid on top, hiding from the midday sun.\n\n");
		//(night hours)
		else if(model.time.hours < 22) outputText("Kid A is peeking out of her barrel.  Whenever you make eye contact she breaks into a smile; otherwise she just stares off into the distance, relaxing.\n\n");
		else outputText("Kid A is here, seated demurely on the rim of her barrel and looking somewhat more purple under the red moon.  She glances slyly at you from time to time.\n\n");
		barrel = anemoneScene.approachAnemoneBarrel;
		if(model.time.hours < 6) barrel = 0;
	}
	if (player.hasKeyItem("Camp - Chest") >= 0) {
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0) outputText("You have a large wood and iron chest to help store excess items located in front of your bed inside your cabin.\n\n", false);
		else outputText("You have a large wood and iron chest to help store excess items located near the portal entrance.\n\n", false);
	}
	var weaponNames:Array = [];
	//Weapon rack
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00254] > 0) {
		outputText("There's a weapon rack set up here, set up to hold up to nine various weapons.", false);
		weaponRack = inventory.initiateStoreWeaponRack;
		if(hasItemsInRacks(0)) {
			weaponRetrieve = inventory.initiateTakeWeaponRack;
			temp = 0;
			outputText("  It currently holds ", false);
			while(temp < 9) {
				if(gearStorage[temp].quantity > 0) {
					weaponNames[weaponNames.length] = gearStorage[temp].itype.longName;
				}
				temp++;
			}
			if(weaponNames.length == 1) outputText(weaponNames[0], false);
			else if(weaponNames.length == 2) outputText(weaponNames[0] + " and " + weaponNames[1], false);
			else {
				temp = 0;
				while(temp < weaponNames.length) {
					outputText(weaponNames[temp], false);
					if(temp + 2 >= weaponNames.length && temp + 1 < weaponNames.length) outputText(", and ", false);
					else if(temp + 1 < weaponNames.length) outputText(", ", false);
					temp++;
				}
			}
		}
		outputText(".\n\n", false);
	}
	var armorNames:Array = [];
	//Armor Rack
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00255] > 0) {
		outputText("Your camp has an armor rack set up to hold your various sets of gear.  It appears to be able to hold nine different types of armor.", false);
		armorRack = inventory.initiateStoreArmorRack;
		if(hasItemsInRacks(1)) {
			armorRetrieve = inventory.initiateTakeArmorRack;
			temp = 9;
			outputText("  It currently holds ", false);
			while(temp < 18) {
				if(gearStorage[temp].quantity > 0) {
					armorNames[armorNames.length] = gearStorage[temp].itype.longName;
				}
				temp++;
			}
			if(armorNames.length == 1) outputText(armorNames[0], false);
			else if(armorNames.length == 2) outputText(armorNames[0] + " and " + armorNames[1], false);
			else {
				temp = 0;
				while(temp < armorNames.length) {
					outputText(armorNames[temp], false);
					if(temp + 2 >= armorNames.length && temp + 1 < armorNames.length) outputText(", and ", false);
					else if(temp + 1 < armorNames.length) outputText(", ", false);
					temp++;
				}
			}
		}
		outputText(".\n\n", false);
	}
	var jewelNames:Array = [];
	//Jewelry Box
	if(player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0) {
		outputText("Your jewelry box is located ", false);
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED])
		{
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER])
			{
				outputText("on your dresser inside your cabin.", false);
			}
			else
			{
				if (flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND]) outputText("on your nightstand inside your cabin.", false);
				else  outputText("under your bed inside your cabin.", false);
			}
		}
		else
		{
			outputText("next to your bedroll.", false);
		}		
		jewelBox = inventory.initiateStoreJewelryBox;
		if(hasItemsInRacks(2)) {
			jewelRetrieve = inventory.initiateTakeJewelryBox;
			temp = 18;
			outputText("  It currently holds ", false);
			while(temp < 27) {
				if(gearStorage[temp].quantity > 0) {
					jewelNames[jewelNames.length] = gearStorage[temp].itype.longName;
				}
				temp++;
			}
			if(jewelNames.length == 1) outputText(jewelNames[0], false);
			else if(jewelNames.length == 2) outputText(jewelNames[0] + " and " + jewelNames[1], false);
			else {
				temp = 0;
				while(temp < jewelNames.length) {
					outputText(jewelNames[temp], false);
					if(temp + 2 >= jewelNames.length && temp + 1 < jewelNames.length) outputText(", and ", false);
					else if(temp + 1 < jewelNames.length) outputText(", ", false);
					temp++;
				}
			}
		}
		outputText(".\n\n", false);
	}
	choices("Chest Store",storeStuff,"Chest Take",retrieveStuff,"W.Rack Put",weaponRack,"W.Rack Take",weaponRetrieve,"Anemone",barrel,"A.Rack Put",armorRack,"A.Rack Take",armorRetrieve,"J.Box Store",jewelBox,"J.Box Take",jewelRetrieve,"Back",1);
	return true;
}
	
public function hasCompanions():Boolean {
	return companionsCount() > 0;
}
public function companionsCount():Number {
	return followersCount() + slavesCount() + loversCount();
}
public function followersCount():Number {
	var counter:Number = 0;
	if(emberScene.followerEmber()) counter++;
	if(flags[kFLAGS.VALARIA_AT_CAMP] == 1) counter++;
	if(player.findStatusAffect(StatusAffects.PureCampJojo) >= 0) counter++;
	if(player.findStatusAffect(StatusAffects.CampRathazul) >= 0) counter++;
	if(followerShouldra()) counter++;
	if(sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) counter++;
	if(helspawnFollower()) counter++;
	return counter;
}
public function slavesCount():Number {
	var counter:Number = 0;
	if(latexGooFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 0) counter++;
	if(vapulaSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0) counter++;
	if(campCorruptJojo() && flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 0) counter++;
	if(amilyScene.amilyFollower() && amilyScene.amilyCorrupt() && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) counter++;
	//Bimbo sophie
	if(bimboSophie() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) counter++;
	if(ceraphIsFollower()) counter++;
	if(milkSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0) counter++;
	return counter;
}
public function loversCount():Number {
	var counter:Number = 0;
	if(arianScene.arianFollower()) counter++;
	if(followerHel()) counter++;
	//Izma!
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) counter++;
	if(isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) counter++;
	if(player.findStatusAffect(StatusAffects.CampMarble) >= 0 && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) counter++;
	if(amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) counter++;
	if(followerKiha()) counter++;
	if(flags[kFLAGS.NIEVE_STAGE] == 5) counter++;
	if(flags[kFLAGS.ANT_WAIFU] > 0) counter++;
	return counter;
}

//-----------------
//-- COMPANIONS 
//-----------------
public function campLoversMenu():void {
	hideMenus();
	kGAMECLASS.tooltipLoc = "";
	spriteSelect(-1);
	var isabellaButt:Function = null;
	var marbleEvent:Function = null;
	var izmaEvent:Function = null;
	var kihaButt:Function = null;
	var amilyEvent:Function = null;
	var hel:Function = null;
	var nieve:int = 0;
	clearOutput();
	if(flags[kFLAGS.NIEVE_STAGE] == 5) {
		kGAMECLASS.nieveCampDescs();
		outputText("\n\n");
		nieve = 3965;
	}
	if(kGAMECLASS.helScene.followerHel()) {
		if(flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 2) {
			//Hel @ Camp: Follower Menu
			//(6-7) 
			if(model.time.hours <= 7) outputText("Hel is currently sitting at the edge of camp, surrounded by her scraps of armor, sword, and a few half-empty bottles of vodka.  By the way she's grunting and growling, it looks like she's getting ready to flip her shit and go running off into the plains in her berserker state.\n\n");
			//(8a-5p) 
			else if(model.time.hours <= 17) outputText("Hel's out of camp at the moment, adventuring on the plains.  You're sure she'd be on hand in moments if you needed her, though.\n\n");
			//5-7) 
			else if(model.time.hours <= 19) outputText("Hel's out visiting her family in Tel'Adre right now, though you're sure she's only moments away if you need her.\n\n");
			//(7+)
			else outputText("Hel is fussing around her hammock, checking her gear and sharpening her collection of blades.  Each time you glance her way, though, the salamander puts a little extra sway in her hips and her tail wags happily.\n\n");
		}
		else if(flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 1) {
			if(flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] == 1) {
				outputText("Hel has returned to camp, though for now she looks a bit bored.  Perhaps she is waiting on something.\n\n");
			}
			else {
				outputText("<b>You see the salamander Helia pacing around camp, anxiously awaiting your departure to the harpy roost. Seeing you looking her way, she perks up, obviously ready to get underway.</b>\n\n");
			}
		}
		hel = helFollower.heliaFollowerMenu;
	}
	//Kiha!
	if(followerKiha()) {
		//(6-7) 
		if(model.time.hours < 7) outputText("Kiha is sitting near the fire, her axe laying across her knees as she polishes it.[pg]");
		else if(model.time.hours < 19) outputText("Kiha's out right now, likely patrolling for demons to exterminate.  You're sure a loud call could get her attention.\n\n");
		else outputText("Kiha is utterly decimating a set of practice dummies she's set up out on the edge of camp.  All of them have crudely drawn horns. Most of them are on fire.\n\n");
		kihaButt = kihaScene.encounterKiha;
	}
	//Isabella
	if(isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) {
		isabellaButt = isabellaFollowerScene.callForFollowerIsabella;
		if(model.time.hours >= 21 || model.time.hours <= 5) outputText("Isabella is sound asleep in her bunk and quietly snoring.", false);
		else if(model.time.hours == 6) outputText("Isabella is busy eating some kind of grain-based snack for breakfast.  The curly-haired cow-girl gives you a smile when she sees you look her way.", false);
		else if(model.time.hours == 7) outputText("Isabella, the red-headed cow-girl, is busy with a needle and thread, fixing up some of her clothes.", false);
		else if(model.time.hours == 8) outputText("Isabella is busy cleaning up the camp, but when she notices you looking her way, she stretches up and arches her back, pressing eight bullet-hard nipples into the sheer silk top she prefers to wear.", false);
		else if(model.time.hours == 9) outputText("Isabella is out near the fringes of your campsite.  She has her massive shield in one hand and appears to be keeping a sharp eye out for intruders or demons.  When she sees you looking her way, she gives you a wave.", false);
		else if(model.time.hours == 10) outputText("The cow-girl warrioress, Isabella, is sitting down on a chair and counting out gems from a strange pouch.  She must have defeated someone or something recently.", false);
		else if(model.time.hours == 11) outputText("Isabella is sipping from a bottle labelled 'Lactaid' in a shaded corner.  When she sees you looking she blushes, though dark spots appear on her top and in her skirt's middle.", false);
		else if(model.time.hours == 12) outputText("Isabella is cooking a slab of meat over the fire.  From the smell that's wafting this way, you think it's beef.  Idly, you wonder if she realizes just how much like her chosen food animal she has become.", false);
		else if(model.time.hours == 13) {
			outputText("Isabella ", false);
			var izzyCreeps:Array = [];
			//Build array of choices for izzy to talk to
			if(player.findStatusAffect(StatusAffects.CampRathazul) >= 0)
				izzyCreeps[izzyCreeps.length] = 0;
			if(player.findStatusAffect(StatusAffects.PureCampJojo) >= 0)
				izzyCreeps[izzyCreeps.length] = 1;
			if(amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0)
				izzyCreeps[izzyCreeps.length] = 2;
			if(amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 2 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0)
				izzyCreeps[izzyCreeps.length] = 3;
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0)
				izzyCreeps[izzyCreeps.length] = 4;
			//Base choice - book
			izzyCreeps[izzyCreeps.length] = 5;
			//Select!
			var choice:* = rand(izzyCreeps.length);
				
			if(izzyCreeps[choice] == 0) outputText("is sitting down with Rathazul, chatting amiably about the weather.", false);
			else if(izzyCreeps[choice] == 1) outputText("is sitting down with Jojo, smiling knowingly as the mouse struggles to keep his eyes on her face.", false);
			else if(izzyCreeps[choice] == 2) outputText("is talking with Amily, sharing stories of the fights she's been in and the enemies she's faced down.  Amily seems interested but unimpressed.", false);
			else if(izzyCreeps[choice] == 3) outputText("is sitting down chatting with Amily, but the corrupt mousette is just staring at Isabella's boobs and masturbating.  The cow-girl is pretending not to notice.", false);
			else if(izzyCreeps[choice] == 4) outputText("is sitting down with Izma and recounting some stories, somewhat nervously.  Izma keeps flashing her teeth in a predatory smile.", false);
			else outputText("is sitting down and thumbing through a book.", false);
		}
		else if(model.time.hours == 14) outputText("Isabella is working a grindstone and sharpening her tools.  She even hones the bottom edge of her shield into a razor-sharp cutting edge.  The cow-girl is sweating heavily, but it only makes the diaphanous silk of her top cling more alluringly to her weighty chest.", false);
		else if(model.time.hours == 15) outputText("The warrior-woman, Isabella is busy constructing dummies of wood and straw, then destroying them with vicious blows from her shield.  Most of the time she finishes by decapitating them with the sharp, bottom edge of her weapon.  She flashes a smile your way when she sees you.", false);
		else if(model.time.hours == 16) outputText("Isabella is sitting down with a knife, the blade flashing in the sun as wood shavings fall to the ground.  Her hands move with mechanical, practiced rhythm as she carves a few hunks of shapeless old wood into tools or art.", false);
		else if(model.time.hours == 17) outputText("Isabella is sitting against one of the large rocks near the outskirts of your camp, staring across the wasteland while idly munching on what you assume to be a leg of lamb.  She seems lost in thought, though that doesn't stop her from throwing a wink and a goofy food-filled grin toward you.", false);
		else if(model.time.hours == 18) outputText("The dark-skinned cow-girl, Isabella, is sprawled out on a carpet and stretching.  She seems surprisingly flexible for someone with hooves and oddly-jointed lower legs.", false);
		else if(model.time.hours == 19) {
			//[(Izzy Milked Yet flag = -1)
			if(flags[kFLAGS.ISABELLA_MILKED_YET] == -1) outputText("Isabella has just returned from a late visit to Whitney's farm, bearing a few filled bottles and a small pouch of gems.", false);
			else outputText("Isabella was hidden behind a rock when you started looking for her, but as soon as you spot her in the darkness, she jumps, a guilty look flashing across her features.  She turns around and adjusts her top before looking back your way, her dusky skin even darker from a blush.  The cow-girl gives you a smile and walks back to her part of camp.  A patch of white decorates the ground where she was standing - is that milk?  Whatever it is, it's gone almost as fast as you see it, devoured by the parched, wasteland earth.", false);
		}
		else if(model.time.hours == 20) outputText("Your favorite chocolate-colored cowgirl, Isabella, is moving about, gathering all of her scattered belongings and replacing them in her personal chest.  She yawns more than once, indicating her readiness to hit the hay, but her occasional glance your way lets you know she wouldn't mind some company before bed.", false);
		else outputText("Isabella looks incredibly bored right now.", false);
		outputText("\n\n", false);		
	}
	//Izma
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
		outputText("Neatly laid near the base of your own is a worn bedroll belonging to Izma, your tigershark lover. It's a snug fit for her toned body, though it has some noticeable cuts and tears in the fabric. Close to her bed is her old trunk, almost as if she wants to have it at arms length if anyone tries to rob her in her sleep.\n\n", false);
		izmaEvent = izmaScene.izmaFollowerMenu;
	}
	//MARBLE
	if(player.findStatusAffect(StatusAffects.CampMarble) >= 0 && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) {
		temp = rand(5);
		outputText("A second bedroll rests next to yours; a large two handed hammer sometimes rests against it, depending on whether or not its owner needs it at the time.  ", false);
		//Normal Murbles
		if(flags[kFLAGS.MARBLE_PURIFICATION_STAGE] != 4)
		{
			//(Choose one of these at random to display each hour)
			if(temp == 0) outputText("Marble herself has gone off to Whitney's farm to get milked right now.", false);
			if(temp == 1) outputText("Marble herself has gone off to Whitney's farm to do some chores right now.", false);
			if(temp == 2) outputText("Marble herself isn't at the camp right now; she is probably off getting supplies, though she'll be back soon enough.", false);
			if(temp == 3) {
				outputText("Marble herself is resting on her bedroll right now.", false);
			}
			if(temp == 4) {
				outputText("Marble herself is wandering around the camp right now.", false);
			}
			if(temp < 3) outputText("  You're sure she'd be back in moments if you needed her.", false);
			marbleEvent = marbleScene.interactWithMarbleAtCamp;
		}
		//Out getting family
		else outputText("Marble is out in the wilderness right now, searching for a relative.");
		outputText("\n\n", false);
	}
	//AMILY
	if(amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0) {
		outputText("Amily is currently strolling around your camp, ", false);
		temp = rand(6);
		if(temp == 0) {
			outputText("dripping water and stark naked from a bath in the stream", false);
			if(player.findStatusAffect(StatusAffects.CampRathazul) >= 0) outputText(".  Rathazul glances over and immediately gets a nosebleed", false);
		}
		else if(temp == 1) outputText("slouching in the shade of some particularly prominent rocks, whittling twigs to create darts for her blowpipe", false);
		else if(temp == 2) outputText("dipping freshly-made darts into a jar of something that looks poisonous", false);
		else if(temp == 3) outputText("eating some of your supplies", false);
		else if(temp == 4) outputText("and she flops down on her nest to have a rest", false);
		else outputText("peeling the last strips of flesh off of an imp's skull and putting it on a particularly flat, sun-lit rock to bleach as a trophy", false);
		outputText(".\n\n", false);
		amilyEvent = amilyScene.amilyFollowerEncounter;
	}
	//Amily out freaking Urta?
	else if(flags[kFLAGS.AMILY_VISITING_URTA] == 1 || flags[kFLAGS.AMILY_VISITING_URTA] == 2) {
		outputText("Amily's bed of grass and herbs lies empty, the mouse-woman still absent from her sojourn to meet your other lover.\n\n", false);
	}
	if(arianScene.arianFollower()) outputText("Arian's tent is here, if you'd like to go inside.\n\n");
	//choices("Amily",amilyEvent,"Helia",hel,"Isabella",isabellaButt,"Izma",izmaEvent,"Kiha",kihaButt,"Marble",marbleEvent,"Nieve",nieve,"",0,"",0,"Back",1);	
	menu();
	if(amilyEvent != null) addButton(0,"Amily",amilyEvent);
	if(arianScene.arianFollower()) addButton(1,"Arian",arianScene.visitAriansHouse);
	if (hel != null) addButton(2,"Helia",hel);
	if (isabellaButt != null) addButton(3,"Isabella",isabellaButt);
	if (izmaEvent != null) addButton(4,"Izma",izmaEvent);
	addButton(5,"Kiha",kihaButt);
	if (marbleEvent != null) addButton(6,"Marble",marbleEvent);
	if(nieve > 0) addButton(7,"Nieve",eventParser,nieve);
	if(flags[kFLAGS.ANT_WAIFU] > 0) addButton(8,"Phylla",kGAMECLASS.desert.antsScene.introductionToPhyllaFollower);
	addButton(14,"Back",eventParser,1);
}
public function campSlavesMenu():void {
	hideMenus();
	kGAMECLASS.tooltipLoc = "";
	spriteSelect(-1);
	clearOutput();
	var vapula2:Function = null;
	var amilyEvent:Function = null;
	var ceraph:Function = null;
	var sophieEvent:Function = null;
	var jojoEvent:Function = null;
	var goo:Function = null;
	if(vapulaSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0) {
		vapula.vapulaSlaveFlavorText();
		outputText("\n\n");
		vapula2 = vapula.callSlaveVapula;
	}
	//Bimbo Sophie
	if(bimboSophie() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
		sophieBimbo.sophieCampLines();
		sophieEvent = sophieBimbo.approachBimboSophieInCamp;
	}
	if(latexGooFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 0) {
		outputText(flags[kFLAGS.GOO_NAME] + " lurks in a secluded section of rocks, only venturing out when called for or when she needs to gather water from the stream.\n\n");
		goo = latexGirl.approachLatexy;
	}
	if (ceraphIsFollower()) ceraph = ceraphFollowerScene.ceraphFollowerEncounter;
	//JOJO
	//If Jojo is corrupted, add him to the masturbate menu.
	if(campCorruptJojo() && flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 0) {
		outputText("From time to time you can hear movement from around your camp, and you routinely find thick puddles of mouse semen.  You are sure Jojo is here if you ever need to sate yourself.\n\n", false);
		jojoEvent = jojoScene.corruptCampJojo;
	}
	//Modified Camp/Follower List Description:
	if(amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 2 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) {
		outputText("Sometimes you hear a faint moan from not too far away. No doubt the result of your slutty toy mouse playing with herself.\n\n", false);
		amilyEvent = amilyScene.amilyFollowerEncounter;
	}
	if(milkSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0) {
		outputText("Your well-endowed, dark-skinned milk-girl is here.  She flicks hopeful eyes towards you whenever she thinks she has your attention.\n\n");
	}
	//choices("Amily",amilyEvent,"Ceraph",ceraph,"Jojo",jojoEvent,"Sophie",sophieEvent,"Vapula",vapula,"",0,"",0,"",0,flags[kFLAGS.GOO_NAME],goo,"Back",1);	
	menu();
	if (amilyEvent != null) addButton(0,"Amily", amilyEvent);
	if (ceraph != null) addButton(1,"Ceraph", ceraph);
	if (jojoEvent != null) addButton(2,"Jojo",jojoEvent);
	if (sophieEvent != null) addButton(3,"Sophie",sophieEvent);
	if (vapula2 != null) addButton(4,"Vapula",vapula2);
	if (milkSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0) addButton(7,flags[kFLAGS.MILK_NAME],milkWaifu.milkyMenu);
	if (goo != null) addButton(8,flags[kFLAGS.GOO_NAME],goo);
	addButton(14,"Back",eventParser,1);
}

public function campFollowers():void {
	hideMenus();
	kGAMECLASS.tooltipLoc = "";
	spriteSelect(-1);
	var rathazulEvent:Number = 0;
	var jojoEvent:Number = 0;
	var valeria2:Function = null;
	var shouldra:Function = null;
	var ember:Function = null;
	clearOutput();
	gameState = 0;
	//ADD MENU FLAGS/INDIVIDUAL FOLLOWER TEXTS
	menu();
	if(emberScene.followerEmber()) {
		emberScene.emberCampDesc();
		ember = emberScene.emberCampMenu;
	}
	if(followerShouldra()) {
		shouldra = shouldraFollower.shouldraFollowerScreen;
	}
	//Pure Jojo
	if(player.findStatusAffect(StatusAffects.PureCampJojo) >= 0) {
		outputText("There is a small bedroll for Jojo near your own, though the mouse is probably hanging around the camp's perimeter.\n\n", false);
		jojoEvent = 2150;
	}
	//RATHAZUL
	//if rathazul has joined the camp
	if(player.findStatusAffect(StatusAffects.CampRathazul) >= 0) {
		rathazulEvent = 2070;
		if(flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] <= 1) {
			outputText("Tucked into a shaded corner of the rocks is a bevy of alchemical devices and equipment.  The alchemist Rathazul looks to be hard at work with his chemicals, working on who knows what.", false);
			if(flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] == 1) outputText("  Some kind of spider-silk-based equipment is hanging from a nearby rack.  He's finished with the task you gave him!", false);
			outputText("\n\n", false);
		}
		else outputText("Tucked into a shaded corner of the rocks is a bevy of alchemical devices and equipment.  The alchemist Rathazul looks to be hard at work on the silken equipment you've commissioned him to craft.\n\n", false);
	}

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
		addButton(5,"Sophie",sophieFollowerScene.followerSophieMainScreen);
	}
	if(flags[kFLAGS.VALARIA_AT_CAMP] == 1) valeria2 = valeria.valeriaFollower;
//choices("Ember",ember,"Jojo",jojoEvent,"Rathazul",rathazulEvent,"Shouldra",shouldra,"Valeria",valeria,"",0,"",0,"",0,"",0,"Back",1);	
	addButton(0,"Ember",ember);
	if(helspawnFollower()) addButton(1,flags[kFLAGS.HELSPAWN_NAME],helSpawnScene.helspawnsMainMenu);
	if(jojoEvent > 0) addButton(2,"Jojo",eventParser,jojoEvent);
	if(rathazulEvent > 0) addButton(3,"Rathazul",eventParser,rathazulEvent);
	addButton(4,"Shouldra",shouldra);
	//ABOVE: addButton(4,"Sophie",followerSophieMainScreen);
	addButton(6, "Valeria", valeria2);
	//if (player.armorName == "goo armor") addButton(6, "Valeria (E)", valeria2);
	addButton(14,"Back",eventParser,1);
}
//-----------------
//-- CAMP ACTIONS 
//-----------------
private function campActions():void {
	hideMenus();
	menu();
	outputText("What would you like to do?", true)
	addButton(0, "SwimInStream", swimInStream, null, null, null, "Swim in stream and relax to pass time.");
	addButton(1, "ExaminePortal", examinePortal, null, null, null, "Examine the portal. This scene is placeholder."); //Examine portal.
	if (model.time.hours == 19) addButton(2, "Watch Sunset", watchSunset, null, null, null, "Watch the sunset and relax."); //Relax and watch at the sunset.
	if (flags[kFLAGS.CAMP_CABIN_PROGRESS] > 0 && flags[kFLAGS.CAMP_CABIN_PROGRESS] < 12) addButton(3, "Build Cabin", cabinProgress.initiateCabin, null, null, null, "Work on your cabin."); //Work on cabin.
	if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 12 || flags[kFLAGS.CAMP_BUILT_CABIN] >= 1) addButton(3, "Enter Cabin", cabinProgress.initiateCabin, null, null, null, "Enter your cabin."); //Enter cabin for furnish.
	addButton(8, "Read Codex", codex.accessCodexMenu, null, null, null, "Read any codex entries you have unlocked.");
	addButton(14, "Back", eventParser, 1);
}

private function swimInStream():void {
	izmaJoinsStream = false;
	marbleJoinsStream = false;
	heliaJoinsStream = false;
	amilyJoinsStream = false;
	
	var prankChooser:Number = rand(3);
	outputText("You ponder over the nearby stream that's flowing. Deciding you'd like a dip, ", true);
	if (player.armorName == "slutty swimwear") outputText("you are going to swim while wearing just your swimwear. ", false);
	else outputText("you strip off your [armor] until you are completely naked. ", false);
	outputText("You step into the flowing waters. You shiver at first but you step in deeper. Incredibly, it's not too deep. ", false);
	if (player.tallness < 60) outputText("Your feet aren't even touching the riverbed. ", false);
	if (player.tallness >= 60 && player.tallness < 72) outputText("Your feet are touching the riverbed and your head is barely above the water. ", false);
	if (player.tallness >= 72) outputText("Your feet are touching touching the riverbed and your head is above water. You bend down a bit so you're at the right height. ", false);
	outputText("\n\nYou begin to swim around and relax. ", false);
	//Izma!
	if (rand(2) == 0 && camp.izmaFollower())
	{
		outputText("\n\nYour tiger-shark beta, Izma, joins you. You are frightened at first when you saw the fin protruding from the water and the fin approaches you! ", false);
		outputText("As the fin appoaches you, the familiar figure comes up. \"<i>I was going to enjoy my daily swim, alpha,</i>\" she says.", false);
		izmaJoinsStream = true;
	}
	//Helia!
	if (rand(2) == 0 && camp.followerHel() && flags[kFLAGS.HEL_CAN_SWIM])
	{
		outputText("\n\nHelia, your salamander lover, joins in for a swim. \"<i>Hey, lover mine!</i>\" she says. As she enters the waters, the water seems to become warmer until it begins to steam like a sauna.", false);
		heliaJoinsStream = true;
	}
	//Marble!
	if (rand(2) == 0 && camp.marbleFollower())
	{
		outputText("\n\nYour cow-girl lover Marble strips herself naked and joins you. \"<i>Sweetie, you enjoy swimming, don't you?</i>\" she says.", false);
		marbleJoinsStream = true;
	}
	//Amily! (Must not be corrupted and must have given Slutty Swimwear.)
	if (rand(2) == 0 && camp.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_OWNS_BIKINI] > 0)
	{
		outputText("\n\nYour mouse-girl lover Amily is standing at the riverbank. She looks flattering in her bikini.  ", false)
		if (flags[kFLAGS.AMILY_WANG_LENGTH] > 0) outputText("Especially when her penis is exposed.  ", false)
		outputText("She walks into the waters and swims.  ", false)
		amilyJoinsStream = true;
	}
	//Pranks!
	if (prankChooser == 0 && (camp.izmaFollower() || (camp.followerHel() && flags[kFLAGS.HEL_CAN_SWIM]) || camp.marbleFollower() || (camp.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_OWNS_BIKINI] > 0)) )
	{
		outputText("\n\nYou could play some pranks by making the water curiously warm. Do you?", false)
		doYesNo(swimInStreamPrank1, swimInStreamFinish);
		return;
	}
	/*if (prankChooser == 1 && (camp.izmaFollower() || (camp.followerHel() && flags[kFLAGS.HEL_CAN_SWIM]) || camp.marbleFollower()) )
	{
		outputText("\n\nYou could play some pranks by grabbing the leg of one of them and surprise them. Do you?", false)
		doYesNo(swimInStreamPrank2, swimInStreamFinish);
	}*/
	/*if (prankChooser == 2 && player.lust >= 33) {
		outputText("\n\nYou're feeling horny right now. Do you masturbate in the stream?", false)
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
	if (amilyJoinsStream) prankRoll++
	if (prankRoll > 4) prankRoll = 4;
	//Play joke on them!
	outputText("You look around to make sure no one is looking then you smirk and you can feel yourself peeing. When you're done, you swim away.  ", true)
	if (rand(prankRoll) == 0 && camp.izmaFollower() && pranked == false && izmaJoinsStream == true)
	{
		outputText("\n\nIzma just swims over, unaware of the warm spot you just created. \"<i>Who've pissed in the stream?</i>\" she growls. You swim over to her and tell her that you admit you did pee in the stream. \"<i>Oh, alpha! What a naughty alpha you are,</i>\" she grins, her shark-teeth clearly visible.", false);
		pranked = true;
	}
	if (rand(prankRoll) == 0 && (camp.followerHel() && flags[kFLAGS.HEL_CAN_SWIM]) && pranked == false && heliaJoinsStream == true)
	{
		outputText("\n\nHelia swims around until she hits the warm spot you just created. \"<i>Heyyyyyyy,</i>\" the salamander yells towards you. She comes towards you and asks \"<i>Did you just piss in the stream?</i>\" after which you sheepishly chuckle and tell her that you admit it. Yes, you've done it. \"<i>I knew it! Oh, you're naughty, lover mine!</i>\" she says.", false);
		pranked = true;
	}
	if (rand(prankRoll) == 0 && camp.marbleFollower() && pranked == false && marbleJoinsStream == true)
	{
		outputText("\n\nMarble is oblivious to the warm spot and when she swims over, she yells \"<i>Hey, sweetie! Did you just urinate in the stream?</i>\" You sheepishly smile and admit that yes, you did it. She replies \"<i>You're naughty, you know, sweetie!</i>\"", false);
		pranked = true;
	}
	/*if (rand(prankRoll) == 0 && camp.amilyFollower() && flags[kFLAGS.AMILY_OWNS_BIKINI] > 0 && pranked == false && amilyJoinsStream == true)
	{
		outputText("", false);
		pranked = true;
	}*/
	if (pranked == false) outputText("  No one managed to swim past where you left the warm spot before it dissipated. You feel a bit disappointed and just go back to swimming.", false);
	else outputText("  You feel accomplished from the prank and resume swimming. ", false);
	awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE);
	doNext(swimInStreamFinish);
}

private function swimInStreamFap():void {
	outputText("", true)
	doNext(swimInStreamFinish);
}

private function swimInStreamFinish():void {
	outputText("", true);
	//Blown up factory? Corruption gains.
	if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2 && player.cor < 50) 
	{
		outputText("You feel a bit dirtier after swimming in the tainted waters. \n\n", false);
		dynStats("cor", 0.5);
		dynStats("lust", 15, "resisted", true);
	}
	outputText("Eventually, you swim back to the riverbank and dry yourself off", false);
	if (player.armorName != "slutty swimwear") outputText(" before you re-dress yourself in your " + player.armorName, false);
	outputText(".", false)
	doNext(13);
}

private function examinePortal():void {
	if (flags[kFLAGS.CAMP_PORTAL_PROGRESS] <= 0) {
		outputText("You walk over to the portal. You are reminded by how you came. You begin to wonder if you can go back. You start by picking up a small pebble and throw it through the portal. It passes through the portal. As you walk around the portal, you spot the pebble at the other side. Seems like you can't get back right now.", true)
		flags[kFLAGS.CAMP_PORTAL_PROGRESS] = 1
		doNext(13);
		return;
	}
	else outputText("You walk over to the portal. You are reminded by how you came. You let out a sigh, knowing you can't return to Ingnam.", true)
	doNext(1);
}

private function watchSunset():void {
	var randText:Number = rand(3);
	outputText("You pick a location where the sun is clearly visible from that particular spot and sit down. The sun is just above the horizon, ready to set. It's such a beautiful view. \n\n", true)
	//Childhood nostalgia GO!
	if (randText == 0)
	{
		if (player.cor < 33) 
		{
			outputText("A wave of nostalgia washes over you as you remember your greatest moments from your childhood.", false);
			dynStats("cor", -1, "lib", -1, "lust", -30, "resisted", false);
		}
		if (player.cor >= 33 && player.cor < 66) 
		{
			outputText("A wave of nostalgia washes over you as you remember your greatest moments from your childhood. Suddenly, your memories are somewhat twisted from some of the perverted moments. You shake your head and just relax.", false);
			dynStats("cor", -0.5, "lib", -1, "lust", -20, "resisted", false);
		}
		if (player.cor >= 66) 
		{
			outputText("A wave of nostalgia washes over you as you remember your greatest moments from your childhood. Suddenly, your memories twist into some of the dark and perverted moments. You chuckle at that moment but you suddenly shake your head and focus on relaxing.", false);
			dynStats("cor", 0, "lib", -1, "lust", -10, "resisted", false);
		}
	}
	//Greatest moments GO!
	if (randText == 1)
	{
		if (player.cor < 33) 
		{
			outputText("You reflect back on your greatest adventures and how curiosity got the best of you. You remember some of the greatest places you discovered.", false);
			dynStats("lust", -30, "resisted", false);
		}
		if (player.cor >= 33 && player.cor < 66) 
		{
			outputText("You reflect back on your greatest adventures. Of course, some of them involved fucking and getting fucked by the denizens of Mareth. You suddenly open your eyes from the memory and just relax, wondering why you thought of that in the first place.", false);
			dynStats("lust", -20, "resisted", false);
		}
		if (player.cor >= 66) 
		{
			outputText("You reflect back on your greatest adventures. You chuckle at the moments you were dominating and the moments you were submitting. You suddenly open your eyes from the memory and just relax.", false);
			dynStats("lust", -10, "resisted", false);
		}
	}
	//Greatest moments GO!
	if (randText >= 2)
	{
		outputText("You think of what you'd like to ", false);
		if (rand(2) == 0) outputText("do", false);
		else outputText("accomplish", false);
		outputText(" before you went through the portal. You felt a bit sad that you didn't get to achieve your old goals.", false);
		dynStats("lust", -30, "resisted", false);

	}
	outputText("\n\nAfter the thought, you spend a good while relaxing and watching the sun setting. By now, the sun has already set below the horizon. The sky is glowing orange after the sunset. It looks like you could explore more for a while.", false)
	doNext(13);
}




//-----------------
//-- REST
//-----------------
public function rest():void {
	campQ = true;
	outputText("", true);
	//Multiplier
	var multiplier:Number = 1.0;
	if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0)
	{
		multiplier += 0.5; //Cabin has that comfortable bed. Even more comfortable than sleeping on your bedroll! Adds 0.5 to multiplier.
	}
	if (flags[kFLAGS.HUNGER_ENABLED] > 0)
	{
		if (player.hunger < 25)
		{
			multiplier *= 0.5
		}
	}
	//Fatigue recovery
	var fatRecovery:Number = 4;
	if (player.findPerk(PerkLib.SpeedyRecovery) >= 0) fatRecovery *= 1.5;
	if (player.findPerk(PerkLib.ControlledBreath) >= 0) fatRecovery *= 1.1;
	if (timeQ == 0) {
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0)
		{
			outputText("You head into your cabin to rest. You lie down on your bed to rest for four hours.", false);
		}
		else 
		{
			outputText("You lie down to rest for four hours.\n", false);
		}
		timeQ = 4;
		//Hungry
		if (flags[kFLAGS.HUNGER_ENABLED] > 0)
		{
			if (player.hunger < 25)
			{
				outputText("\nYou have difficulty resting as you toss and turn with your stomach growling.\n", false);
			}
		}
		//Marble withdrawal
		if(player.findStatusAffect(StatusAffects.MarbleWithdrawl) >= 0) {
			outputText("\nYour rest is very troubled, and you aren't able to settle down.  You get up feeling tired and unsatisfied, always thinking of Marble's milk.\n", false);

			HPChange(timeQ * 5 * multiplier, true);

			dynStats("tou", -.1, "int", -.1);
			//fatigue
			fatRecovery /= 2;
			fatigue(-fatRecovery * timeQ * multiplier);
		}
		//REGULAR HP/FATIGUE RECOVERY
		else {
			HPChange(timeQ * 10 * multiplier, true);
			//fatigue
			fatigue(-fatRecovery * timeQ * multiplier); 
		}
	}
	else {
		if(timeQ != 1) outputText("You continue to rest for " + num2Text(timeQ) + " more hours.\n", true);
		else outputText("You continue to rest for another hour.\n", true);
	}
	goNext(timeQ,true);
}
//-----------------
//-- WAIT
//-----------------
public function doWait():void {
	campQ = true;
	outputText("", true);
	//Fatigue recovery
	var fatRecovery:Number = 2;
	if (player.findPerk(PerkLib.SpeedyRecovery) >= 0) fatRecovery *= 1.5;
	if (player.findPerk(PerkLib.ControlledBreath) >= 0) fatRecovery *= 1.1;
	if(timeQ == 0) {
		outputText("You wait four hours...\n", false);
		timeQ = 4;
		//Marble withdrawl
		if(player.findStatusAffect(StatusAffects.MarbleWithdrawl) >= 0) {
			outputText("\nYour time spent waiting is very troubled, and you aren't able to settle down.  You get up feeling tired and unsatisfied, always thinking of Marble's milk.\n", false);
			//fatigue
			fatRecovery /= 2;
			fatigue(-fatRecovery * timeQ);
		}
		//REGULAR HP/FATIGUE RECOVERY
		else {
			//fatigue
			fatigue(-fatRecovery * timeQ); 
		}
	}
	else {
		if(timeQ != 1) outputText("You continue to wait for " + num2Text(timeQ) + " more hours.\n", false);
		else outputText("You continue to wait for another hour.\n", false);
	}
	goNext(timeQ,true);
}
//-----------------
//-- SLEEP
//-----------------
public function doSleep(clrScreen:Boolean = true):void {
	if (kGAMECLASS.urta.pregnancy.incubation == 0 && kGAMECLASS.urta.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER && model.time.hours >= 20 && model.time.hours < 2) {
		urtaPregs.preggoUrtaGivingBirth();
		return;
	}
	campQ = true;
	if(timeQ == 0) {
		if(model.time.hours == 21) timeQ = 9;
		if(model.time.hours == 22) timeQ = 8;
		if(model.time.hours >= 23) timeQ = 7;
		if(model.time.hours == 0) timeQ = 6;
		if(model.time.hours == 1) timeQ = 5;
		if(model.time.hours == 2) timeQ = 4;
		if(model.time.hours == 3) timeQ = 3;
		if(model.time.hours == 4) timeQ = 2;
		if(model.time.hours == 5) timeQ = 1;
		//Autosave stuff		
		if (player.slotName != "VOID" && player.autoSave && mainView.getButtonText( 0 ) != "Game Over") 
		{
			trace("Autosaving to slot: " + player.slotName);
			
			getGame().saves.saveGame(player.slotName);
		}
		//Clear screen
		if(clrScreen) outputText("", true);
		/******************************************************************/
		/*       ONE TIME SPECIAL EVENTS                                  */
		/******************************************************************/
		//HEL SLEEPIES!
		if(helFollower.helAffection() >= 70 && flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE] == 0 && flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 0) {
			getGame().dungeons.heltower.heliaDiscovery();
			sleepRecovery(false);
			return;
		}
		//Shouldra xgartuan fight
		if(player.hasCock() && followerShouldra() && player.statusAffectv1(StatusAffects.Exgartuan) == 1) {
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
		/******************************************************************/
		/*       SLEEP WITH SYSTEM GOOOO                                  */
		/******************************************************************/
		if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && (flags[kFLAGS.SLEEP_WITH] == "" || flags[kFLAGS.SLEEP_WITH] == "Marble"))
		{
			outputText("You head inside your cabin to turn yourself in for the night. ")
		}
		//Marble Sleepies
		if(marbleScene.marbleAtCamp() && player.findStatusAffect(StatusAffects.CampMarble) >= 0 && flags[kFLAGS.SLEEP_WITH] == "Marble" && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) {
			if(marbleScene.marbleNightSleepFlavor()) {
				sleepRecovery(false);
				return;
			}
		}
		else if(flags[kFLAGS.SLEEP_WITH] == "Arian" && arianScene.arianFollower()) {
			arianScene.sleepWithArian();
			return;
		}
		else if(flags[kFLAGS.SLEEP_WITH] == "Sophie" && (bimboSophie() || sophieFollower()) && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
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
			if(flags[kFLAGS.SLEEP_WITH] == "Helia" && kGAMECLASS.helScene.followerHel()) {
				outputText("You curl up next to Helia, planning to sleep for " + num2Text(timeQ) + " ");
			}
			//Normal sleep message
			else outputText("You curl up, planning to sleep for " + num2Text(timeQ) + " ", false);
			if(timeQ == 1) outputText("hour.\n", false);
			else outputText("hours.\n", false);
		}
		sleepRecovery(true);
	}
	else {
		if(timeQ != 1) outputText("You lie down to resume sleeping for the remaining " + num2Text(timeQ) + " hours.\n", true);
		else outputText("You lie down to resume sleeping for the remaining hour.\n", true);
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
	clearOutput();
	if(timeQ != 1) outputText("You lie down to resume sleeping for the remaining " + num2Text(timeQ) + " hours.\n", true);
	else outputText("You lie down to resume sleeping for the remaining hour.\n", true);
	sleepRecovery(true);
	goNext(timeQ, true);
}

public function sleepRecovery(display:Boolean = false):void {
	var multiplier:Number = 1.0;
	if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && (flags[kFLAGS.SLEEP_WITH] == "" || flags[kFLAGS.SLEEP_WITH] == "Marble"))
	{
		multiplier += 0.5;
	}
	if (flags[kFLAGS.HUNGER_ENABLED] > 0)
	{
		if (player.hunger < 25)
		{
			outputText("\nYou have difficulty sleeping as your stomach is growling loudly.\n", false);
			multiplier *= 0.5;
		}
	}	
	//Marble withdrawl
	if(player.findStatusAffect(StatusAffects.MarbleWithdrawl) >= 0) {
		if(display) outputText("\nYour sleep is very troubled, and you aren't able to settle down.  You get up feeling tired and unsatisfied, always thinking of Marble's milk.\n", false);
		HPChange(timeQ * 10 * multiplier, true);
		dynStats("tou", -.1, "int", -.1);
		//fatigue
		fatigue(-int(player.fatigue/2));
		if(player.findPerk(PerkLib.SpeedyRecovery) >= 0) fatigue(-int(player.fatigue/4));
	}
	//Mino withdrawal
	else if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) {
		if(display) outputText("\nYou spend much of the night tossing and turning, aching for a taste of minotaur cum.\n", false);
		HPChange(timeQ * 15 * multiplier, true);
		fatigue(-int(player.fatigue/2)); 
		if(player.findPerk(PerkLib.SpeedyRecovery) >= 0) fatigue(-int(player.fatigue/4));
	}
	//REGULAR HP/FATIGUE RECOVERY
	else {
		HPChange(timeQ * 20 * multiplier, display);
		//fatigue
		fatigue(-player.fatigue); 
	}
}

//Bad End if your balls are too big. Only happens in Realistic Mode.
public function badEndGIANTBALLZ():void {
	outputText("You suddenly fall over due to your extremely large " + player.ballsDescriptLight() + ".  You struggle to get back up but the size made it impossible.  Panic spreads through your mind and your heart races.\n\n", true)
	outputText("You know that you can't move and you're aware that you're going to eventually starve to death.", false)
	menu();
	if (player.hasItem(consumables.REDUCTO, 1)) {
		outputText("\n\nFortunately, you have some Reducto.  You can shrink your balls and get back to your adventures!", false)
		addButton(1, "Reducto", applyReductoAndEscapeBadEnd);
	}
	else if (player.findStatusAffect(StatusAffects.CampRathazul) >= 0) {
		outputText("\n\nYou could call for Rathazul to help you.", false)
		addButton(2, "Rathazul", callRathazulAndEscapeBadEnd);		
	}
	else doBadEnd();
}
private function applyReductoAndEscapeBadEnd():void {
	outputText("You smear the foul-smelling paste onto your " + sackDescript() + ".  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n", true);
	player.ballSize -= (4 + rand(6));
	if (player.ballSize < 1) player.ballSize = 1;
	if (player.ballSize > 18 + (player.str/2)) player.ballSize = 17 + (player.str/2)
	outputText("You feel your scrotum shift, shrinking down along with your " + ballsDescriptLight() + ".  ", false);
	outputText("Within a few seconds the paste has been totally absorbed and the shrinking stops.  ", false);
	dynStats("lib", -2, "lus", -10);
	player.consumeItem(consumables.REDUCTO, 1);
	doNext(13);
}
private function callRathazulAndEscapeBadEnd():void {
	outputText("You shout as loud as you can to call Rathazul.  Your call is answered as the alchemist walks up to you.\n\n", true);
	outputText("\"<i>My, my... Look at yourself! Don't worry, I can help, </i>\" he says.  He rushes to his alchemy equipment and mixes ingredients.  He returns to you with a Reducto.\n\n", false)
	outputText("He rubs the paste all over your massive balls. It's incredibly effective. \n\n", false)
	player.ballSize -= (4 + rand(6));
	if (player.ballSize < 1) player.ballSize = 1;
	if (player.ballSize > 18 + (player.str/2)) player.ballSize = 17 + (player.str/2)
	outputText("You feel your scrotum shift, shrinking down along with your " + ballsDescriptLight() + ".  ", false);
	outputText("Within a few seconds the paste has been totally absorbed and the shrinking stops.  ", false);
	outputText("\"<i>Try not to make your balls bigger. If it happens, make sure you have Reducto, </i>\" he says.  He returns to his alchemy equipment, working on who knows what.\n\n", false)
	doNext(13);
}

//Bad End if you starved to death.
public function badEndHunger():void {
	player.hunger = 0.1; //For Easy Mode/Debug Mode.
	outputText("Too weak to be able to stand up, you collapse onto the ground. Your vision blurs as the world around you finally fades to black. \n\n", true);
	if (companionsCount() > 0) {
		if (companionsCount() > 1) {
			outputText("Your companions gather to mourn over your passing.", false);
		}
		else {
			outputText("Your fellow companion mourns over your passing.", false);
		}
	}
	player.HP = 0;
	doBadEnd();
}
//Bad End if you have 100 min lust.
public function badEndMinLust():void {
	outputText("The thought of release overwhelms you. You frantically remove your " + player.armorName + " and begin masturbating furiously.  The first orgasm hits you but the desire persists.  You continue to masturbate but unfortunately, no matter how hard or how many times you orgasm, your desires will not go away.  Frustrated, you keep masturbating furiously but you are unable to stop.  Your minimum lust is too high.  No matter how hard you try, you cannot even satisfy your desires.\n\n", true);
	outputText("You spend the rest of your life masturbating, unable to stop.", false)
	player.orgasm();
	doBadEnd();	
	removeButton(1); //Can't wake up, must load.
}

public function nightSuccubiRepeat():void {
	spriteSelect(8);
	if(player.gender == 0) {
		if(flags[kFLAGS.CERULEAN_POTION_NEUTER_ATTEMPTED] == 0) {
			outputText("\nAs you sleep, your rest becomes increasingly disturbed. You feel a great weight on top of you and you find it difficult to breathe. Stirred to consciousness, your eyes are greeted by an enormous pair of blue-tinged breasts. The nipples are quite long and thick and are surrounded by large, round areola. A deep, feminine voice breaks the silence, \"<i>I was wondering if you would wake up.</i>\" You turn your head to the voice to see the visage of a sharp featured, attractive woman. The woman grins mischievously and speaks again, \"<i>I was hoping that idiot, Giacomo, did not dilute the 'potion' again.</i>\" Your campfire reflects off the woman's face and her beauty contains some sharply contrasting features. The pupils of her eyes are slit like a cat's. As she grins, she bares her teeth, which contain two pairs of long and short fangs. This woman is clearly NOT human! In shock, you attempt to get up, only prompting the woman to prove her inhuman nature by grabbing your shoulders and pinning you to the ground. You see that each finger on her hand also contains a fourth joint, further proving her status. Before you can speak a word, the woman begins mocking your fear and places her face in front of yours. Her face is almost certainly demonic in nature.\n\n", false);
			outputText("She quickly moves down to your crotch...only to discover no organs down there.\n\n", false);
			outputText("*record scratch*\n\n", false);
	
			outputText("\"<i>Wait a fucking minute.</i>\", the Succubus says, \"<i>Where's your dick?!</i>\"\n\n", false);
	
			outputText("As you state your genderless nature, the succubus hops off and from nowhere pulls out a large folder marked \"<i>Corruption of Champions-Script</i>\" and begins thumbing through the pages. After finding the page she is looking for, she reads it and looks off into the distance in disgust.\n\n", false);
	
			outputText("\"<i>Hey Fenoxo and Dxasmodeus!!!!!!</i>\", the Succubus crows, \"<i>The goddamn script says that I should be milking someone's DICK!!! Man, futa, herm, I don't give a shit. YOUR OWN FUCKING SCRIPT SAYS I SHOULD BE MOUNTING AND MILKING A COCK!!!! THIS IS A SEX GAME!!!!!! THAT MEANS FUCKING! WHAT THE HELL AM I SUPPOSED TO FUCK???!!!</i>\"\n\n", false);
	
			outputText("The Succubus looks at you with utter contempt, \"<i>THIS motherfucker doesn't have a DAMN thing! What am I supposed to do?! I can't exactly order a fucking Happy Meal!!!!!</i>\"\n\n", false); 
	
			outputText("Throwing the script down in an utter rage, the tantrum continues, \"<i>Goddammit! I can't believe this shit! HEY!!!!! INTERN!!!! Bring me my robe, aspirins and cancer sticks!!!!</i>\"\n\n", false);
	
			outputText("The Succubus walks a few paces away where a plain-dressed woman with a clipboard hands the Succubus a pack of cigarettes and a small bottle of aspirin. She takes a fistful of the painkillers and immediately lights up a smoke. The Succubus takes a couple of drags off the cig and rubs her temples.\n\n", false);
	
			outputText("\"<i>You two are killing me!</i>\", she groans in clear frustration, \"<i>I come to work for you perverts based off the promise of MORE perverts to feed from and you do THIS to me! I can't work like this!</i>\"\n\n", false);
	
			outputText("The plain woman hands the Succubus a robe, which she crudely puts on as she storms off into the night.\n\n", false);
	
			outputText("\"<i>I will discuss this horseshit with my agent.</i>\", the Succubus continues bitching, \"<i>THIS was NOT in my contract.</i>\"\n\n", false);
	
			outputText("The Succubus stops, turns and points to you in derision. \"<i>And YOU! You no-cock, no-cunt having pissant! Take your ass back to the lab before they find out you escaped!!!!!</i>\"\n\n", false);
	
			outputText("The Succubus resumes her stormy exit. You look at the bottle of Cerulean Potion and wonder if it REALLY had some psychotropics in it. What the hell just happened?!", false);
			flags[kFLAGS.CERULEAN_POTION_NEUTER_ATTEMPTED] = 1;
		}
		//REPEAT
		else {
			outputText("\nAs you begin to relax, you hear footsteps behind you, expecting the unholy interloper and pray for a better... and more understanding... encounter.\n\n", false);

			outputText("You turn around, hoping for an exciting encounter only to find a rather short, plain-faced woman with horned-rim glasses and a purple dress on. She appears to be holding a stack of papers in her hand.\n\n", false);

			outputText("\"<i>Ahem.</i>\", the woman says meekly, \"<i>I hate to bother you, but I was sent by the CoC writers and staff to hand you this.</i>\"\n\n", false);

			outputText("Scratching your head, you inquire what the document is. The woman smiles shyly and hands it to you.\n\n", false);

			outputText("\"<i>This is the script and production notes for Corruption of Champions,</i>\" she says with a small bit of pride, \"<i>Apparently, you need to read the highlighted sections. They are important.</i>\"\n\n", false);

			outputText("You take the script, scratching your head at the surreal nature of the moment. You thumb through the pages, finding virtually every aspect of your life and encounters written as if foreseen by great mystics. The accuracy is nothing short of horrifying. You find a highlighted section that appears to be what the woman is referring to. The note is terse and outright blunt.\n\n", false);
			
			outputText("\"<i>GENDER NEUTRAL CHARACTERS ARE BUTT-MONKEYS. IF THE ENCOUNTER INVOLVES SEX, EXPECT SOMETHING FUCKED UP TO HAPPEN INSTEAD. ACTORS WHO PLAY NEUTER CHARACTERS SHOULD EXPECT TO PLAY ONLY FOR LULZ</i>.\"\n\n", false);

			outputText("The shock is overwhelming. The script basically says that you will never catch a break. As this reality drapes about you, the script disappears and you hear a cacophony of mocking laughter in all directions. The woman is nowhere to be found.\n\n", false);

			outputText("As the cacophony fades, you only hear one facetiously toned word,\n\n", false);

			outputText("\"<i><b>Problem?</b></i>\"", false);
		}
		doNext(1);
		return;
	}
	player.orgasm();
	dynStats("cor", 2);
	if(player.gender == 1) {
		if(player.cor < 66) {
			outputText("\nAgainst your better judgment, you've again partaken of the cerulean elixir and fallen asleep. You are quickly awakened by a thick nipple being thrust into your mouth and torrents of breast milk gushing down your throat as the succubus returns to have her way with you. Looking up, your eyes meet hers as a hungry manipulative grin stretches across her blue face. Unable to control your lust, your prick jumps to attention, which prompts the demoness to ", false);
			if(player.isTaur()) outputText(" crouch between your legs and impale herself on your " + cockDescript(0) + " with a wet sound caused by her well-lubricated vulva. Y", false);
			else outputText(" open her womb and quickly consume your " + cockDescript(0) + ". She embraces you, entrapping your head in her cleavage as y", false);
			outputText("ou quickly feel her superhuman vaginal muscles work and stroke your " + cockDescript(0) + " better than any human woman or pair of hands could ever hope to accomplish. You are helpless as your unholy embrace milks the both of you in an infernal symphony of debauchery. The familiar cramp of an impending ejaculation grips you and your twitching signals the succubus of your approaching climax.\n\n", false);
			if(player.isTaur()) outputText("Pushing on your forelegs, she engulfs even more of your " + cockDescript(0), false);
			else outputText("Almost crushing your pelvis, she wraps her legs around your body", false);
			outputText(" and her muscles churn mercilessly demanding that you release your 'milk' as freely as she has released hers into you. Stimulated beyond any human ability to maintain control, you bear down and release a milky flood of your own inside the succubus. Moaning in ecstasy, she ", false);
			if(player.isTaur()) outputText("arches under your belly as you feel your " + cockDescript(0) + " bending pleasurably inside her, and", false);
			else outputText("releases you from her grip, allowing you to finally breathe deeply, and leans back, arching high to reveal your joined genitals in the moonlight. You visibly see", false);
			outputText(" her contractions milking your " + cockDescript(0) + " as fiercely as a maid milks a cow! Another torrent of cum pushes its way out of your body and you let out a moan of pleasure and exhaustion.\n\n", false);
			outputText("As you are passing out, you feel a deep kiss upon your lips from the succubus. \"You taste better each time we join. Call upon me soon, lest I take what I want from you anyway,\", says the lustful creature.\n\n", false);
			outputText("Fatigue takes you and you collapse into a deep sleep.  ", false);
		}
		else {
			outputText("\nKnowing the succubus will come, you do not even bother trying to sleep. Instead, you prepare a little surprise for her. You briefly jerk off and start edging yourself, preparing a massive batch to unload inside her. Hopefully, she will be the one to get more than she bargained for.\n\n", true);
			outputText("The succubus comes, as you predicted. Despite her obvious strength and size difference to you, you grab her and push her down to the ground and immediately push your angry cock into her hairy hole. The succubus, surprised and enthralled, laughs at your aggression.\n\n", false);
			outputText("\"<i>I thought I was the hungry one.</i>\", she chuckles. \"I am all yours, little man. FEED ME!\"\n\n", false);
			outputText("You begin bucking your ", false);
			if(player.isTaur()) outputText("flanks", false);
			else outputText("hips", false);
			outputText(" in the all-too-familiar rhythm, hammering away at the succubus' cunt. Impressed with your initiative, she chooses to remain submissive as you work up an impressive load of spunk. Trying with all of your might, you continue to hold off your orgasm, painfully, as you continue stimulating your inhuman lover.\n\n", false);
			outputText("However, she senses your control and immediately brings her own muscles into the little love game. With one good squeeze, she breaks down any control and resistance you have. Sensing you are about to explode, she ", false);
			if(player.isTaur()) outputText("pushes on your forelegs, impaling herself even deeper on your " + cockDescript(0), false);
			else outputText("wraps her legs around your hips and bears down", false);
			outputText(". You feel the head of your prick push past the dilated opening in her cervix, which immediately contracts around your head. Your penis is literally trapped and caught in her womb!\n\n", false);
			outputText("Groaning loudly, long muscle spasms release the painfully stored semen into the deepest parts of the succubus. The sensation of your hot cum so deep inside her body triggers her peak. ", false);
			
			if(player.isTaur()) outputText("She moans inhumanly, and reflexively digs her claws into your forelegs. Searing with lust, the pain means little to you as you only feel the sensation of your body forcing your fluids out of your body and into hers. You press your " + cockDescript(0) + " into her", false);
			else outputText("She embraces you, moaning inhumanly, and reflexively digs her claws into your back. Searing with lust, the pain means little to you as you only feel the sensation of your body forcing your fluids out of your body and into hers. You slam your pelvis into hers", false);
			outputText(", as if to force yourself to cum harder than you already are capable of, prompting an equally pleasurable reaction from her.\n\n", false);
			outputText("For the first time since you have had your 'visits', the succubus appears winded. Without another word, her muscles release your manhood, which she quickly licks clean of your intermingled juices.  She tongues your face in lustful approval and flies away. You quickly fall asleep, utterly spent.  ", false);
			dynStats("lib", -1);
		}
	}
	else if(player.gender == 3) {
		//Bad End-Cerulean Succubus Futa/herm
		//[Conditions: Corruption >50. Drink 10 Cerulean potions over the course of 20 Days. (Other stipulations as required that prevent interference with other events-to be determined)]
		if(flags[kFLAGS.CERULEAN_POTION_BAD_END_FUTA_COUNTER] > 10 && player.cor > 50) {
			outputText("\nAs the Succubus mounts you, an uncontrollable urge takes over your mind and body. Without any thought, you quickly thrust one of her nipples in your mouth and begin suckling wildly like a newborn child. The Succubus cries in shock and pleasure as you begin feeding from her and quickly begins her ritualistic milking of your dong. The warm milk passes into your mouth and down your throat, where it settles peacefully in your stomach. The sensation of fulfillment from her tits is only eclipsed by the massive load of semen you feel cramping your prostate.", false);
			//[ (Herm-Dickgirl variant only)
			if(player.balls > 0) outputText("  Even your nuts are unbearably sore.", false);
			outputText("  As the milk begins to dry out of the Succubus' tit, you release it from your control and launch an impossible load of cum into the succubus. The demoness releases her hold of your cock and hops off your crotch and jumps to place her mouth over your erupting penis. Reflexively grabbing her head, you push your cock as deep as you can in her mouth and for minutes, pump stream after stream of hot lust into her gullet. After the last load leaves your dong, you pass out.\n\n", false);

			outputText("After a short time, you wake up sore from head to toe. The Succubus is sitting next to you with an utterly satisfied look on her face.\n\n", false);

			outputText("\"<i>Well, this was unexpected.</i>\", she says, \"<i>I did not expect you to change. Normally, men are susceptible to my milk, but apparently it works on herms, too.</i>\"\n\n", false); 

			outputText("As you stand, you feel awkward as your body does not feel right. You look at the Succubus and she no longer appears as large as she once was. Quick to realize a problem, you look at your reflection in a small bucket at your campsite. Other than your own unique facial features, you see ANOTHER Cerulean Succubus looking back at you! You ARE a Cerulean Succubus!", false);
			//[(if the player has a large number of transformations) 
			if(player.horseScore() + player.dogScore() + player.nagaScore() + player.goblinScore() + player.sharkScore() + player.minoScore() + player.cowScore() > 5) outputText("  All of the other corruptions and changes to your body have faded away as your new form has taken shape.", false);
			outputText("  As the reality soaks in, you feel a sharp pain in your stomach and your cock. You NEED to feed. Cum, milk, it doesn't matter. Likewise, your dick is hard and you need to cum. Despite your need, you cannot bring yourself to masturbate. You want ANOTHER'S attention.\n\n", false);

			outputText("Without further acknowledgement, you take up your on your demonic wings to find your first \"meal\". The Succubus left behind simply giggles as she sees another of her kind take up the night in search for more meals and pleasure.", false);
			doBadEnd();
			return;
		}
		else {
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00111]++;
			flags[kFLAGS.CERULEAN_POTION_BAD_END_FUTA_COUNTER]++;
			outputText("\nAs you begin to relax from a long day of adventuring, the succubus returns and lands squarely in your lap, just missing your throbbing erection. The succubus growls in arousal as she thrusts one of her fat nipples into your mouth. Reflexively, you begin suckling the teat with neither shame nor restraint. Milk floods into your mouth as you sense the weight of the succubus descend upon your cock. The familiar warmth and snugness of her cunt greet your hungry prick as her muscles begin the savory churning to coax your body into producing the 'milk' she needs to sate her own hunger. Your eyes roll back into your head as the torrent of milk pouring down your throat increases the sensitivity in all of your organs, compelling your hips to reflexively buck to press your dick deeper.\n\n", false);
			
			outputText("The Succubus restrains you without missing a stroke or disrupting your breastfeeding as the pangs of orgasmic pleasure swell up at the base of your cock. You wrap your arms forcefully around the succubus as you bear down upon your crotch, releasing the painfully stockpiled load of lust into the demoness' cunt for her own sustenance. The succubus lets out an inhuman howl of pleasure as her own orgasm begins to crush your cock, draining every last drop out of you.\n\n", false);

			outputText("Your consciousness begins to fade as the orgasm subsides. The succubus pops her tit out of your mouth and squeezes more of her essence into the empty bottle. She licks your lips and flies away just in time for you to pass out.  ", false);
			//Clear out any queue'ed events if bad-end
			//coming.  PC has to dig his own grave.
			if(flags[kFLAGS.CERULEAN_POTION_BAD_END_FUTA_COUNTER] > 10) {
				player.removeStatusAffect(StatusAffects.SuccubiNight);
			}
			fatigue(20);
			player.cumMultiplier++;
			//[Maintain first encounter mechanics. New variable to keep track of subsequent encounters within a specific time period]
		}
	}
	menuLoc = 14;
	inventory.takeItem(consumables.CERUL_P);
	outputText("\n", false);
	player.orgasm();
	dynStats("str", rand(2),"tou", rand(2), "spe", rand(2), "int", rand(2), "cor", 1);
}

//-----------------
//-- PLACES MENU
//-----------------
public function placesCount():int {
	var places:int = 0;
	if (flags[kFLAGS.BAZAAR_ENTERED] > 0) places++;
	if (player.findStatusAffect(StatusAffects.BoatDiscovery) >= 0) places++;
	if (flags[kFLAGS.FOUND_CATHEDRAL] > 0) places++;
	if (flags[kFLAGS.FACTORY_FOUND] >= 0 || flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0 || flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0) places++;
	if (player.findStatusAffect(StatusAffects.MetWhitney) > 0 || flags[kFLAGS.FARM_CORRUPTION_STARTED]) places++; 
	if (flags[kFLAGS.OWCA_UNLOCKED] == 1) places++;
	if (player.findStatusAffect(StatusAffects.HairdresserMeeting) >= 0) places++;
	if (player.statusAffectv1(StatusAffects.TelAdre) >= 1) places++;
	if (flags[kFLAGS.AMILY_VILLAGE_ACCESSIBLE] > 0) places++;
	if (flags[kFLAGS.MET_MINERVA] >= 4) places++;
	return places;
}

//All cleaned up!
public function places():void {
	hideMenus();
	clearOutput();
	outputText("Which place would you like to visit?");
	//if(flags[kFLAGS.PLACES_PAGE] != 0)
	//{
	//	placesPage2();
	//	return;
	//}
	//Build menu
	menu();
	if (flags[kFLAGS.BAZAAR_ENTERED] > 0) addButton(0, "Bazaar", eventParser, 2855);
	if (player.findStatusAffect(StatusAffects.BoatDiscovery) >= 0) addButton(1, "Boat", kGAMECLASS.boat.boatExplore);
	if (flags[kFLAGS.FOUND_CATHEDRAL] > 0) 
	{
		if (flags[kFLAGS.GAR_NAME] == 0) addButton(2, "Cathedral", kGAMECLASS.gargoyle.gargoylesTheShowNowOnWBNetwork);
		else addButton(2, "Cathedral", kGAMECLASS.gargoyle.returnToCathedral);
	}
	if (flags[kFLAGS.FACTORY_FOUND] > 0 || flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0 || flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0 || flags[kFLAGS.DISCOVERED_DUNGEON_3_LETHICE] > 0 || kGAMECLASS.dungeons.checkPhoenixTowerClear()) addButton(3, "Dungeons", dungeons);
	
	if (player.findStatusAffect(StatusAffects.MetWhitney) >= 0) 
	{
		if(player.statusAffectv1(StatusAffects.MetWhitney) > 1 && (flags[kFLAGS.FARM_DISABLED] == 0 || (player.cor >= 70 && player.level >= 12 && kGAMECLASS.farm.farmCorruption.corruptFollowers() >= 2 && flags[kFLAGS.FARM_CORRUPTION_DISABLED] == 0) || player.level >= 20 )) addButton(5, "Farm", kGAMECLASS.farm.farmExploreEncounter);
	}
	if (flags[kFLAGS.FARM_CORRUPTION_STARTED]) addButton(5, "Farm", kGAMECLASS.farm.farmExploreEncounter);
	if (flags[kFLAGS.OWCA_UNLOCKED] == 1) addButton(6, "Owca", kGAMECLASS.owca.gangbangVillageStuff);
	if (player.findStatusAffect(StatusAffects.HairdresserMeeting) >= 0) addButton(7, "Salon", kGAMECLASS.mountain.salon.salonGreeting);
	if (player.statusAffectv1(StatusAffects.TelAdre) >= 1) addButton(8, "Tel'Adre", kGAMECLASS.telAdre.telAdreMenu);
	
	if (flags[kFLAGS.AMILY_VILLAGE_ACCESSIBLE] > 0) addButton(10, "Town Ruins", kGAMECLASS.amilyScene.exploreVillageRuin);
	if (flags[kFLAGS.MET_MINERVA] >= 4) addButton(11, "Oasis Tower", kGAMECLASS.highMountains.minervaScene.encounterMinerva);
	//addButton(13, "Next", placesPage2);
	addButton(14, "Back", eventParser, 1);
}

private function placesPage2():void
{
	menu();
	flags[kFLAGS.PLACES_PAGE] = 1;
	//turn on ruins
	if (flags[kFLAGS.AMILY_VILLAGE_ACCESSIBLE] > 0) addButton(0, "Town Ruins", kGAMECLASS.amilyScene.exploreVillageRuin);
	if (flags[kFLAGS.MET_MINERVA] >= 4) addButton(1, "Oasis Tower", kGAMECLASS.highMountains.minervaScene.encounterMinerva);
	addButton(12,"Previous",placesToPage1);
	addButton(14,"Back",eventParser,1);
}
private function placesToPage1():void
{
	flags[kFLAGS.PLACES_PAGE] = 0;
	places();
}

private function dungeons():void {
	menu();
	//Turn on dungeon 1
	if (flags[kFLAGS.FACTORY_FOUND] > 0) addButton(0, "Factory", dungeon1.enterDungeon);
	//Turn on dungeon 2
	if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0) addButton(1, "Deep Cave", dungeon2.enterDungeon);
	//Turn on dungeon 3
	if (flags[kFLAGS.D3_DISCOVERED] > 0) addButton(2, "Stronghold", kGAMECLASS.d3.enterD3);
	//Side dungeons
	if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0) addButton(5, "Desert Cave", dungeonS.enterDungeon);
	if (kGAMECLASS.dungeons.checkPhoenixTowerClear()) addButton(6, "Phoenix Tower", dungeonH.returnToHeliaDungeon);
	addButton(14,"Back",eventParser,71);
}

private function exgartuanCampUpdate():void {
	//Update Exgartuan stuff
	if(player.findStatusAffect(StatusAffects.Exgartuan) >= 0)
	{
		trace("EXGARTUAN V1: " + player.statusAffectv1(StatusAffects.Exgartuan) + " V2: " + player.statusAffectv2(StatusAffects.Exgartuan));
		//if too small dick, remove him
		if(player.statusAffectv1(StatusAffects.Exgartuan) == 1 && (player.cockArea(0) < 100 || player.cocks.length == 0))
		{
			outputText("", true);
			outputText("<b>You suddenly feel the urge to urinate, and stop over by some bushes.  It takes wayyyy longer than normal, and once you've finished, you realize you're alone with yourself for the first time in a long time.", false);
			if(player.hasCock()) outputText("  Perhaps you got too small for Exgartuan to handle?</b>\n", false);
			else outputText("  It looks like the demon didn't want to stick around without your manhood.</b>\n", false);
			player.removeStatusAffect(StatusAffects.Exgartuan);
			awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, true);
		}
		//Tit removal
		else if(player.statusAffectv1(StatusAffects.Exgartuan) == 2 && player.biggestTitSize() < 12)
		{
			outputText("", true);
			outputText("<b>Black milk dribbles from your " + nippleDescript(0) + ".  It immediately dissipates into the air, leaving you feeling alone.  It looks like you became too small for Exgartuan!\n</b>", false);
			player.removeStatusAffect(StatusAffects.Exgartuan);
		}		
	}
	doNext(1);
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
	if (marbleFollower()) outputText("\n\n\"<i>Are you okay, sweetie?</i>\" Marble asks.  You assure her that you're fine, you've just had a nightmare.");
	if (flags[kFLAGS.HUNGER_ENABLED] > 0) player.hunger = 40;
	if (flags[kFLAGS.HUNGER_ENABLED] >= 1 && player.ballSize > (18 + (player.str / 2))) {
		outputText("\n\nYou realize the consequences of having oversized balls. You need to shrink it right away. Reducto will do.");
		player.ballSize = (15 + (player.str / 2));
	}
	outputText("\n\nYou get up, still feeling traumatized from the nightmares.");
	model.time.days += 1;
	model.time.hours = 6;
	kGAMECLASS.inDungeon = false;
	inRoomedDungeon = false;
	inRoomedDungeonResume = null;
	gameState = 0;
	player.HP = player.maxHP();
	menu();
	addButton(0, "Next", eventParser, 1);
}

//Camp population!
public function getCampPopulation():int {
	var pop:int = 0; //Once you enter Mareth, this will increase to 1.
	if (flags[kFLAGS.IN_INGNAM] <= 0) pop++; //You count toward the population!
	pop += companionsCount()
	//Misc check!
	if (ceraphIsFollower()) pop--; //Ceraph doesn't stay in your camp.
	if (player.armorName == "goo armor") pop++; //Include Valeria if you're wearing her.
	if (flags[kFLAGS.CLARA_IMPRISONED] > 0) pop++;
	if (flags[kFLAGS.ANEMONE_KID] > 0) pop++;
	if (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4) pop++;
	//Children check!
	if (sophieFollower() && flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) pop++;
	if (sophieFollower() && flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] > 0) pop += flags[kFLAGS.SOPHIE_ADULT_KID_COUNT];
	
	if (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] > 0 || flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] > 0) pop += flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] + flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS];
	if (marbleFollower() && flags[kFLAGS.MARBLE_KIDS] > 0) pop += flags[kFLAGS.MARBLE_KIDS];
	if (flags[kFLAGS.ANT_WAIFU] > 0 && (flags[kFLAGS.ANT_KIDS] > 0 || flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] > 0)) pop += (flags[kFLAGS.ANT_KIDS] + flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT]);
	if (flags[kFLAGS.EMBER_CHILDREN_FEMALES] > 0 || flags[kFLAGS.EMBER_CHILDREN_MALES] > 0 || flags[kFLAGS.EMBER_CHILDREN_HERMS] > 0) pop+= flags[kFLAGS.EMBER_CHILDREN_FEMALES] + flags[kFLAGS.EMBER_CHILDREN_MALES] + flags[kFLAGS.EMBER_CHILDREN_HERMS]
	//Return number!
	return pop;
}

private function fixFlags():void {
	//Marae
	if (player.findStatusAffect(StatusAffects.MetMarae) >= 0)
	{
		flags[kFLAGS.MET_MARAE] = 1
		player.removeStatusAffect(StatusAffects.MetMarae);		
	}
	if (player.findStatusAffect(StatusAffects.MaraesQuestStart) >= 0)
	{
		flags[kFLAGS.MARAE_QUEST_START] = 1
		player.removeStatusAffect(StatusAffects.MaraesQuestStart);
	}
	if (player.findStatusAffect(StatusAffects.MaraeComplete) >= 0)
	{
		flags[kFLAGS.MARAE_QUEST_COMPLETE] = 1
		player.removeStatusAffect(StatusAffects.MaraeComplete);		
	}
	if (player.findStatusAffect(StatusAffects.MaraesLethicite) >= 0)
	{
		flags[kFLAGS.MARAE_LETHICITE] = 3
		player.removeStatusAffect(StatusAffects.MaraesLethicite);
	}
	//Factory Demons
	if (player.findStatusAffect(StatusAffects.FactorySuccubusDefeated) >= 0)
	{
		flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED] = 1;
		player.removeStatusAffect(StatusAffects.FactorySuccubusDefeated);
	}
	if (player.findStatusAffect(StatusAffects.FactoryIncubusDefeated) >= 0)
	{
		flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] = 1;
		player.removeStatusAffect(StatusAffects.FactoryIncubusDefeated);
	}
	if (player.findStatusAffect(StatusAffects.FactoryOmnibusDefeated) >= 0) 
	{
		flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] = 1;
		player.removeStatusAffect(StatusAffects.FactoryOmnibusDefeated);
	}
	//Factory Variables
	if (player.findStatusAffect(StatusAffects.FoundFactory) >= 0)
	{
		flags[kFLAGS.FACTORY_FOUND] = 1;
		player.removeStatusAffect(StatusAffects.FoundFactory);
	}
	if (player.findStatusAffect(StatusAffects.IncubusBribed) >= 0)
	{
		flags[kFLAGS.FACTORY_INCUBUS_BRIBED] = 1;
		player.removeStatusAffect(StatusAffects.IncubusBribed);
	}
	if (player.findStatusAffect(StatusAffects.DungeonShutDown) >= 0)
	{
		flags[kFLAGS.FACTORY_SHUTDOWN] = 1;
		player.removeStatusAffect(StatusAffects.DungeonShutDown);
	}
	if (player.findStatusAffect(StatusAffects.FactoryOverload) >= 0)
	{
		flags[kFLAGS.FACTORY_SHUTDOWN] = 2;
		player.removeStatusAffect(StatusAffects.FactoryOverload);
	}
	if (player.findStatusAffect(StatusAffects.TakenLactaid) >= 0)
	{
		flags[kFLAGS.FACTORY_TAKEN_LACTAID] = 5 - (player.statusAffectv1(StatusAffects.TakenLactaid))
		player.removeStatusAffect(StatusAffects.TakenLactaid);
	}
	if (player.findStatusAffect(StatusAffects.TakenGroPlus) >= 0)
	{
		flags[kFLAGS.FACTORY_TAKEN_GROPLUS] = 5 - (player.statusAffectv1(StatusAffects.TakenGroPlus))
		player.removeStatusAffect(StatusAffects.TakenGroPlus);
	}
	/*if (flags[kFLAGS.USE_12_HOURS] > 0)
	{
		player.hunger = flags[kFLAGS.USE_12_HOURS];
		flags[kFLAGS.USE_12_HOURS] = 0;
	}*/
	if (kGAMECLASS.dungeons.checkPhoenixTowerClear()) flags[kFLAGS.CLEARED_HEL_TOWER] = 1;
}
private function promptSaveUpdate():void {
	clearOutput();
	if (flags[kFLAGS.MOD_SAVE_VERSION] < 2) {
		outputText("It appears that you are importing your save from vanilla CoC or older version of this mod.", true);
		outputText("\n\nIs your file last saved in vanilla CoC or pre-version 0.7.1 of the mod?");
		outputText("\n\nI'm only asking because older versions of the mod conflicted with flags. This is now fixed but I can't guarantee if your save is okay.");
		outputText("\n\nPlease select the correct button. Choosing the mod will update the flags, this is necessary for saves from mod to avoid screwing up.");
		menu();
		addButton(0, "Vanilla", doCamp);
		addButton(1, "Pre-0.7.1 mod", updateSaveFlags);
		flags[kFLAGS.MOD_SAVE_VERSION] = 2;
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 2) {
		outputText("Starting in version 0.8 of this mod, achievements are now awarded. To ensure that you don't have to go through scenes again on new savefile, achievements will be awarded depending on flags.");
		outputText("\n\nSome achievements, however, will require you to do it again.");
		updateAchievements();
		outputText("\n\nAchievements are saved in a special savefile so no matter what savefile you're on, any earned achievements will be added to that special savefile.");
		outputText("\n\nTry restarting the game and check the achievements without loading! You'll see! It's permanent.");
		flags[kFLAGS.MOD_SAVE_VERSION] = 3;
		menu();
		doNext(1);
		return;
	}
	if (flags[kFLAGS.MOD_SAVE_VERSION] == 3) {
		//Reclaim flags for future use.
		flags[kFLAGS.GIACOMO_MET] = 0;
		flags[kFLAGS.GIACOMO_NOTICES_WORMS] = 0;
		flags[kFLAGS.PHOENIX_ENCOUNTERED] = 0;
		flags[kFLAGS.PHOENIX_WANKED_COUNTER] = 0;
		if (kGAMECLASS.giacomo > 0) flags[kFLAGS.GIACOMO_MET] = 1;
		flags[kFLAGS.MOD_SAVE_VERSION] = kGAMECLASS.modSaveVersion;
		eventParser(1);
		return;
	}
}

//Updates save. Done to ensure your save doesn't get screwed up.
private function updateSaveFlags():void {
	flags[kFLAGS.MOD_SAVE_VERSION] = kGAMECLASS.modSaveVersion;
	var startOldIds:int = 1195;
	var startNewIds:int = 2001;
	var current:int = 0;
	var target:int = 65;
	while (current < target) {
		trace(flags[startOldIds + current])
		if (flags[startOldIds + current] != 0) {
			flags[startNewIds + current] = flags[startOldIds + current];
			trace(flags[startNewIds + current])
			flags[startOldIds + current] = 0;
		}
		else trace("Skipped")
		current++;
	}
	if (player.ass.analLooseness > 0 && flags[kFLAGS.TIMES_ORGASMED] <= 0) flags[kFLAGS.TIMES_ORGASMED] = 1;
	outputText("Your save file has been updated by changing the variables used in this mod from old flag position to new flag position.\n\n", true)
	outputText("As you know, the base game update tends to change flags and that may screw up saves when mod gets updated.\n\n", false)
	outputText("Unfortunately, I can't guarantee if every flags are retained. You may have lost some furniture or may have lost cabin. I'm sorry if this happens. Your codex entries are still unlocked, don't worry. And if your cabin is built, don't worry, it's still intact and you can re-construct furniture again.\n\n", false)
	if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) {
		outputText("As a compensation, here's 50 wood and 150 nails to re-construct your furniture.\n\n", false)
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += 50;
		if (player.hasKeyItem("Carpenter's Toolbox") >= 0) {
			player.addKeyValue("Carpenter's Toolbox", 1, 150);
		}
	}
	outputText("Don't worry. Just save the game and you're good to go. I, Kitteh6660, will work out the bugs from time to time, while also bringing in cool new stuff!", false)
	doNext(doCamp);
}

private function updateAchievements():void {
	//Story
	awardAchievement("Newcomer", kACHIEVEMENTS.STORY_NEWCOMER);
	if (flags[kFLAGS.MARAE_QUEST_COMPLETE] > 0) awardAchievement("Marae's Savior", kACHIEVEMENTS.STORY_MARAE_SAVIOR);
	if (player.hasKeyItem("Zetaz's Map") >= 0) awardAchievement("Revenge at Last", kACHIEVEMENTS.STORY_ZETAZ_REVENGE);
	
	//Zones
	if (player.exploredForest > 0 && player.exploredLake > 0 && player.exploredDesert > 0 && player.exploredMountain > 0 && flags[kFLAGS.TIMES_EXPLORED_PLAINS] > 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00272] > 0 && player.findStatusAffect(StatusAffects.ExploredDeepwoods) >= 0 && flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] > 0 && flags[kFLAGS.BOG_EXPLORED] > 0 && flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] > 0) awardAchievement("Explorer", kACHIEVEMENTS.ZONE_EXPLORER);
	if (placesCount() >= 10) awardAchievement("Sightseer", kACHIEVEMENTS.ZONE_SIGHTSEER);
	if (player.explored >= 1) awardAchievement("Where am I?", kACHIEVEMENTS.ZONE_WHERE_AM_I);
	if (player.exploredDesert >= 100) awardAchievement("Dehydrated", kACHIEVEMENTS.ZONE_DEHYDRATED);
	if (player.exploredForest >= 100) awardAchievement("Forest Ranger", kACHIEVEMENTS.ZONE_FOREST_RANGER);
	if (player.exploredLake >= 100) awardAchievement("Vacationer", kACHIEVEMENTS.ZONE_VACATIONER);
	if (player.exploredMountain >= 100) awardAchievement("Mountaineer", kACHIEVEMENTS.ZONE_MOUNTAINEER);
	if (flags[kFLAGS.TIMES_EXPLORED_PLAINS] >= 100) awardAchievement("Rolling Hills", kACHIEVEMENTS.ZONE_ROLLING_HILLS);
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00272] >= 100) awardAchievement("Wet All Over", kACHIEVEMENTS.ZONE_WET_ALL_OVER);
	if (player.statusAffectv1(StatusAffects.ExploredDeepwoods) >= 100) awardAchievement("We Need to Go Deeper", kACHIEVEMENTS.ZONE_WE_NEED_TO_GO_DEEPER);
	if (flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] >= 100) awardAchievement("Light-headed", kACHIEVEMENTS.ZONE_LIGHT_HEADED);
	if (flags[kFLAGS.BOG_EXPLORED] >= 100) awardAchievement("All murky", kACHIEVEMENTS.ZONE_ALL_MURKY);
	if (flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] >= 100) awardAchievement("Frozen", kACHIEVEMENTS.ZONE_FROZEN);
	
	if (player.statusAffectv1(StatusAffects.BoatDiscovery) >= 15) awardAchievement("Sea Legs", kACHIEVEMENTS.ZONE_SEA_LEGS);
	if (player.statusAffectv1(StatusAffects.MetWhitney) >= 30) awardAchievement("Farmer", kACHIEVEMENTS.ZONE_FARMER);
	if (flags[kFLAGS.AMILY_VILLAGE_EXPLORED] >= 15) awardAchievement("Archaeologist", kACHIEVEMENTS.ZONE_ARCHAEOLOGIST);
	
	//Levels
	if (player.level >= 2) awardAchievement("Level up!", kACHIEVEMENTS.LEVEL_LEVEL_UP);
	if (player.level >= 5) awardAchievement("Novice", kACHIEVEMENTS.LEVEL_NOVICE);
	if (player.level >= 10) awardAchievement("Apprentice", kACHIEVEMENTS.LEVEL_APPRENTICE);
	if (player.level >= 15) awardAchievement("Journeyman", kACHIEVEMENTS.LEVEL_JOURNEYMAN);
	if (player.level >= 20) awardAchievement("Expert", kACHIEVEMENTS.LEVEL_EXPERT);
	if (player.level >= 30) awardAchievement("Master", kACHIEVEMENTS.LEVEL_MASTER);
	if (player.level >= 40) awardAchievement("Grandmaster", kACHIEVEMENTS.LEVEL_GRANDMASTER);
	//if (player.level >= 50) awardAchievement("Illuistrous", kACHIEVEMENTS.LEVEL_ILLUSTRIOUS);
	//if (player.level >= 60) awardAchievement("Overlord", kACHIEVEMENTS.LEVEL_OVERLORD);
	if (player.level >= 100) awardAchievement("Are you a god?", kACHIEVEMENTS.LEVEL_ARE_YOU_A_GOD);
	
	//Population
	if (getCampPopulation() >= 2) awardAchievement("My First Companion", kACHIEVEMENTS.POPULATION_FIRST);
	if (getCampPopulation() >= 5) awardAchievement("Hamlet", kACHIEVEMENTS.POPULATION_HAMLET);
	if (getCampPopulation() >= 10) awardAchievement("Village", kACHIEVEMENTS.POPULATION_VILLAGE);
	if (getCampPopulation() >= 25) awardAchievement("Town", kACHIEVEMENTS.POPULATION_TOWN);
	if (getCampPopulation() >= 100) awardAchievement("City", kACHIEVEMENTS.POPULATION_CITY);
	if (getCampPopulation() >= 500) awardAchievement("Metropolis", kACHIEVEMENTS.POPULATION_METROPOLIS);
	
	//Time
	if (model.time.days >= 30) awardAchievement("It's been a month", kACHIEVEMENTS.TIME_MONTH);
	if (model.time.days >= 180) awardAchievement("Half-year", kACHIEVEMENTS.TIME_HALF_YEAR);
	if (model.time.days >= 365) awardAchievement("Annual", kACHIEVEMENTS.TIME_ANNUAL);
	if (model.time.days >= 730) awardAchievement("Biennial", kACHIEVEMENTS.TIME_BIENNIAL);
	if (model.time.days >= 1095) awardAchievement("Triennial", kACHIEVEMENTS.TIME_TRIENNIAL);
	if (model.time.days >= 1825) awardAchievement("In for the long haul", kACHIEVEMENTS.TIME_LONG_HAUL);
	if (model.time.days >= 3650) awardAchievement("Decade", kACHIEVEMENTS.TIME_DECADE);
	if (model.time.days >= 36500) awardAchievement("Century", kACHIEVEMENTS.TIME_CENTURY);
	
	//Dungeon
	var dungeonsCleared:int = 0;
	if (kGAMECLASS.dungeons.checkFactoryClear()) {
		awardAchievement("Shut Down Everything", kACHIEVEMENTS.DUNGEON_SHUT_DOWN_EVERYTHING); 
		dungeonsCleared++;
	}
	if (kGAMECLASS.dungeons.checkDeepCaveClear()) {
		awardAchievement("You're in Deep", kACHIEVEMENTS.DUNGEON_YOURE_IN_DEEP);
		dungeonsCleared++;
	}
	if (kGAMECLASS.dungeons.checkSandCaveClear()) {
		awardAchievement("Friend of the Sand Witches", kACHIEVEMENTS.DUNGEON_SAND_WITCH_FRIEND);
		dungeonsCleared++;
	}
	if (kGAMECLASS.dungeons.checkPhoenixTowerClear()) {
		awardAchievement("Fall of the Phoenix", kACHIEVEMENTS.DUNGEON_PHOENIX_FALL);
		dungeonsCleared++;
		if (flags[kFLAGS.TIMES_ORGASMED] <= 0 && flags[kFLAGS.MOD_SAVE_VERSION] == kGAMECLASS.modSaveVersion) awardAchievement("Extremely Chaste Delver", kACHIEVEMENTS.DUNGEON_EXTREMELY_CHASTE_DELVER);
	}
	if (dungeonsCleared >= 3) awardAchievement("Delver", kACHIEVEMENTS.DUNGEON_DELVER);
	if (dungeonsCleared >= 5) awardAchievement("Delver", kACHIEVEMENTS.DUNGEON_DELVER_MASTER);
	
	//Fashion
	if (player.armor == armors.W_ROBES && player.weapon == weapons.W_STAFF) awardAchievement("Wannabe Wizard", kACHIEVEMENTS.FASHION_WANNABE_WIZARD);
	if ((player.armor == armors.RBBRCLT || player.armor == armors.BONSTRP || player.armor == armors.NURSECL) && (player.weapon == weapons.RIDINGC || player.weapon == weapons.WHIP || player.weapon == weapons.SUCWHIP)) awardAchievement("Dominatrix", kACHIEVEMENTS.FASHION_DOMINATRIX);
	if (player.jewelry.value >= 1000) awardAchievement("Bling Bling", kACHIEVEMENTS.FASHION_BLING_BLING);
	
	//Wealth
	if (player.gems >= 1000) awardAchievement("Rich", kACHIEVEMENTS.WEALTH_RICH);
	if (player.gems >= 10000) awardAchievement("Hoarder", kACHIEVEMENTS.WEALTH_HOARDER);
	if (player.gems >= 100000) awardAchievement("Gem Vault", kACHIEVEMENTS.WEALTH_GEM_VAULT);
	if (player.gems >= 1000000) awardAchievement("Millionaire", kACHIEVEMENTS.WEALTH_MILLIONAIRE);
	
	//Combat
	if (player.findStatusAffect(StatusAffects.KnowsCharge) >= 0 && player.findStatusAffect(StatusAffects.KnowsBlind) >= 0 && player.findStatusAffect(StatusAffects.KnowsWhitefire) >= 0 && player.findStatusAffect(StatusAffects.KnowsArouse) >= 0 && player.findStatusAffect(StatusAffects.KnowsHeal) >= 0 && player.findStatusAffect(StatusAffects.KnowsMight) >= 0 ) awardAchievement("Wizard", kACHIEVEMENTS.COMBAT_WIZARD);
	
	//Realistic
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_FASTING] >= 168 && flags[kFLAGS.HUNGER_ENABLED] > 0) awardAchievement("Fasting", kACHIEVEMENTS.REALISTIC_FASTING)
	
	//General
	if (flags[kFLAGS.DEMONS_DEFEATED] >= 25 && model.time.days >= 10) awardAchievement("Portal Defender", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER);
	
	var NPCsBadEnds:int = 0; //Check how many NPCs got bad-ended.
	if (flags[kFLAGS.FACTORY_OMNIBUS_KILLED] > 0) NPCsBadEnds++;
	if (flags[kFLAGS.ZETAZ_DEFEATED_AND_KILLED] > 0) NPCsBadEnds++;
	if (flags[kFLAGS.HARPY_QUEEN_EXECUTED] > 0) NPCsBadEnds++;
	if (flags[kFLAGS.KELT_KILLED] > 0 || flags[kFLAGS.KELT_BREAK_LEVEL] >= 4) NPCsBadEnds++;
	if (flags[kFLAGS.JOJO_DEAD_OR_GONE] == 2) NPCsBadEnds++;
	if (flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0) NPCsBadEnds++;
	if (flags[kFLAGS.FUCK_FLOWER_KILLED] > 0) NPCsBadEnds++;
	if (flags[kFLAGS.D3_GARDENER_DEFEATED] == 3) NPCsBadEnds++; //Dungeon 3 encounters
	if (flags[kFLAGS.D3_CENTAUR_DEFEATED] == 1) NPCsBadEnds++;
	if (flags[kFLAGS.D3_MECHANIC_FIGHT_RESULT] == 1) NPCsBadEnds++;
	
	if (NPCsBadEnds >= 3) awardAchievement("Bad Ender", kACHIEVEMENTS.GENERAL_BAD_ENDER);

	if (flags[kFLAGS.TIMES_TRANSFORMED] >= 1) awardAchievement("What's Happening to Me?", kACHIEVEMENTS.GENERAL_WHATS_HAPPENING_TO_ME);
	if (flags[kFLAGS.TIMES_TRANSFORMED] >= 10) awardAchievement("Transformer", kACHIEVEMENTS.GENERAL_TRANSFORMER);
	if (flags[kFLAGS.TIMES_TRANSFORMED] >= 25) awardAchievement("Shapeshifty", kACHIEVEMENTS.GENERAL_SHAPESHIFTY);
	if (flags[kFLAGS.TIMES_MASTURBATED] >= 1) awardAchievement("Fapfapfap", kACHIEVEMENTS.GENERAL_FAPFAPFAP);
	if (flags[kFLAGS.TIMES_MASTURBATED] >= 10) awardAchievement("Faptastic", kACHIEVEMENTS.GENERAL_FAPTASTIC);
	if (flags[kFLAGS.TIMES_MASTURBATED] >= 100) awardAchievement("Master-bation", kACHIEVEMENTS.GENERAL_FAPSTER);
	
	if (helspawnFollower()) awardAchievement("Helspawn", kACHIEVEMENTS.GENERAL_HELSPAWN);
	if (flags[kFLAGS.URTA_KIDS_MALES] + flags[kFLAGS.URTA_KIDS_FEMALES] + flags[kFLAGS.URTA_KIDS_HERMS] > 0) awardAchievement("Urta's True Lover", kACHIEVEMENTS.GENERAL_URTA_TRUE_LOVER);
	if (flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0) awardAchievement("Godslayer", kACHIEVEMENTS.GENERAL_GODSLAYER);
	if (followersCount() >= 7) awardAchievement("Follow the Leader", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER);
	if (loversCount() >= 8) awardAchievement("Gotta Love 'Em All", kACHIEVEMENTS.GENERAL_GOTTA_LOVE_THEM_ALL);
	if (slavesCount() >= 4) awardAchievement("Meet Your " + player.mf("Master", "Mistress") , kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER);
	if (followersCount() + loversCount() + slavesCount() >= 19) awardAchievement("All Your People are Belong to Me", kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ_R_BLNG_2_ME);
	if (flags[kFLAGS.MANSION_VISITED] >= 3) awardAchievement("Freeloader", kACHIEVEMENTS.GENERAL_FREELOADER);
	if (player.perks.length >= 20) awardAchievement("Perky", kACHIEVEMENTS.GENERAL_PERKY);
	if (player.perks.length >= 35) awardAchievement("Super Perky", kACHIEVEMENTS.GENERAL_SUPER_PERKY);
	if (player.str >= 50 && player.tou >= 50 && player.spe >= 50 && player.inte >= 50) awardAchievement("Jack of All Trades", kACHIEVEMENTS.GENERAL_STATS_50);
	if (player.str >= 100 && player.tou >= 100 && player.spe >= 100 && player.inte >= 100) awardAchievement("Incredible Stats", kACHIEVEMENTS.GENERAL_STATS_100);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCHIZOPHRENIA] >= 4) awardAchievement("Schizophrenic", kACHIEVEMENTS.GENERAL_SCHIZO);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_CLEAN_SLATE] >= 2) awardAchievement("Clean Slate", kACHIEVEMENTS.GENERAL_CLEAN_SLATE);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] >= 100) awardAchievement("I'm No Lumberjack", kACHIEVEMENTS.GENERAL_IM_NO_LUMBERJACK);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] >= 100) awardAchievement("Deforester", kACHIEVEMENTS.GENERAL_DEFORESTER);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_HAMMER_TIME] >= 300) awardAchievement("Hammer Time", kACHIEVEMENTS.GENERAL_HAMMER_TIME);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCAVENGER] >= 200) awardAchievement("Nail Scavenger", kACHIEVEMENTS.GENERAL_NAIL_SCAVENGER);
	if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] >= 1) awardAchievement("Home Sweet Home", kACHIEVEMENTS.GENERAL_HOME_SWEET_HOME);
}

private function fixHistory():void {
	outputText("<b>New history perks are available during creation.  Since this character was created before they were available, you may choose one now!</b>", true);
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00418] = 2;
	doNext(kGAMECLASS.charCreation.menuHistory);
}
}
}
