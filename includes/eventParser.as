import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.ItemType;
import classes.Player;
import classes.Items.Consumable;
import classes.Scenes.Areas.Lake;
import classes.Scenes.Camp.ScarredBlade;
import coc.view.MainView;

//Used to jump the fuck out of pregnancy scenarios for menus.
//const EVENT_PARSER_ESCAPE:int = 800;
//const PHYLLA_GEMS_HUNTED_TODAY:int = 893;

public function playerMenu():void {
	mainViewManager.hidePlayerDoll();
	if (!inCombat) {
		spriteSelect(-1);
	}
	mainView.setMenuButton(MainView.MENU_NEW_MAIN, "New Game", charCreation.newGameGo);
	mainView.nameBox.visible = false;
	if (gameState == 1 || gameState == 2) {
		combat.combatMenu();
		return;
	}
	//Clear restriction on item overlaps if not in combat
	plotFight = false;
	if (inDungeon) {
		//dungeonMenu();
		kGAMECLASS.dungeons.checkRoom();
		return;
	}
	else if (inRoomedDungeon) {
		if (inRoomedDungeonResume != null) inRoomedDungeonResume();
		return;
	}
	flags[kFLAGS.PLAYER_PREGGO_WITH_WORMS] = 0;
	doCamp();
}



public function gameOver(clear:Boolean = false):void { //Leaves text on screen unless clear is set to true
	if (testingBlockExiting) {
		doNext(camp.returnToCampUseOneHour); //Prevent ChaosMonkah instances from getting stuck
	}
	else {
		var textChoices:Number = rand(4);
		if (clear) clearOutput();
		outputText("\n\n<font color=\"#800000\">")
		if (textChoices == 0) outputText("<b>GAME OVER</b>");
		if (textChoices == 1) outputText("<b>Game over, man! Game over!</b>");
		if (textChoices == 2) outputText("<b>You just got Bad-Ended!</b>");
		if (textChoices == 3) outputText("<b>Your adventures have came to an end...</b>");
		outputText("</font>");
		//Delete save on hardcore.
		if (flags[kFLAGS.HARDCORE_MODE] > 0) {
			outputText("\n\n<b>Your save file has been deleted as you are on Hardcore Mode!</b>");
			flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] = flags[kFLAGS.HARDCORE_SLOT];
			var test:* = SharedObject.getLocal(flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION], "/");
			if (test.data.exists)
			{
				trace("DELETING SLOT: " + flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION]);
				test.clear();
			}
		}
		flags[kFLAGS.TIMES_BAD_ENDED]++;
		awardAchievement("Game Over!", kACHIEVEMENTS.GENERAL_GAME_OVER, true, true);
		menu();
		addButton(0, "Game Over", gameOverMenuOverride).hint("Your game has ended. Please load a saved file or start a new game.");
		if (flags[kFLAGS.HARDCORE_MODE] <= 0) addButton(1, "Continue", camp.wakeFromBadEnd).hint("It's all just a dream. Wake up.");
		//addButton(3, "NewGamePlus", charCreation.newGamePlus).hint("Start a new game with your equipment, experience, and gems carried over.");
		if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 || debug) addButton(4, "Debug Cheat", playerMenu);
		gameOverMenuOverride();
		
	}
	inCombat = false;
	dungeonLoc = 0; //Replaces inDungeon = false;
}

private function gameOverMenuOverride():void { //Game over event; override whatever the fuck has been done to the UI up to this point to force display of the data and new game buttons
	mainView.showMenuButton(MainView.MENU_NEW_MAIN);
	mainView.showMenuButton(MainView.MENU_DATA);
	mainView.hideMenuButton(MainView.MENU_APPEARANCE);
	mainView.hideMenuButton(MainView.MENU_LEVEL);
	mainView.hideMenuButton(MainView.MENU_PERKS);
}



public function getCurrentStackTrace():String		// Fuck, stack-traces only work in the debug player.
{
	var tempError:Error = new Error();
	var stackTrace:String = tempError.getStackTrace();
	return stackTrace;
}

public function errorPrint(details:* = null):void
{
	rawOutputText("<b>Congratulations, you've found a bug!</b>", true);
	rawOutputText("\nError: Unknown event!");
	rawOutputText("\n\nPlease report that you had an issue with code: \"" + details + "\" ");
	rawOutputText("\nGame version: \"" + ver + "\" (<b>THIS IS IMPORTANT! Please be sure you include it!</b>) ");

	var sTrace:String = getCurrentStackTrace();

	if (sTrace)	// Fuck, stack-traces only work in the debug player.
		rawOutputText("and stack-trace: \n <pre>" + sTrace + "</pre>\n"); 	
	rawOutputText("to fake-name on the forums or better yet, file a bug report on github: ");
	rawOutputText("\nhttps://github.com/herp-a-derp/Corruption-of-Champions");

	rawOutputText("\nPlease try to include the details of what you were doing when you encountered this bug ");
	if (sTrace)
		rawOutputText(" (including the above stack trace copy&pasted into the details),");
	rawOutputText(" to make tracking the issue down easier. Thanks!");

	doNext(camp.returnToCampUseOneHour);
}

//Argument is time passed.  Pass to event parser if nothing happens.
// The time argument is never actually used atm, everything is done with timeQ instead...
public function goNext(time:Number, needNext:Boolean):Boolean  {
	Utils.Begin("eventParser","goNext",time);
	var x:Boolean = goNextWrapped(time,needNext);
	Utils.End("eventParser","goNext");
	return x;
}
private function goNextWrapped(time:Number, needNext:Boolean):Boolean  {
	//Update system time
	//date = new Date();
	//trace ("MONTH: " + date.month + " DATE: " + date.date + " MINUTES: " + date.minutes);
	//clearOutput();
	if (timeAwareLargeLastEntry >= 0) { //Finish calling timeChangeLarge before advancing the hour again
		for (; timeAwareLargeLastEntry < _timeAwareClassList.length; timeAwareLargeLastEntry++) {
			var item:TimeAwareInterface   = _timeAwareClassList[timeAwareLargeLastEntry];
			var classname:String = flash.utils.getQualifiedClassName(item);
			Utils.Begin("TimeAwareInterface", classname + ".timeChangeLarge");
			if (item.timeChangeLarge()){
				Utils.End("TimeAwareInterface", classname + ".timeChangeLarge");
				return true;
			}
			Utils.End("TimeAwareInterface", classname + ".timeChangeLarge");
		}
		timeAwareLargeLastEntry = -1;
	}
	while (timeQ > 0) {
		timeQ--;
		model.time.hours++;
		combat.regeneration(false);
		if (player.findPerk(PerkLib.JobSoulCultivator) >= 0) combat.soulforceregeneration(false);
		if (player.findPerk(PerkLib.JobSorcerer) >= 0) combat.manaregeneration(false);
		if (player.findPerk(PerkLib.Berzerker) >= 0 || player.findPerk(PerkLib.Lustzerker) >= 0) combat.wrathregeneration(false);
		//Inform all time aware classes that a new hour has arrived
		for (var tac:int = 0; tac < _timeAwareClassList.length; tac++) {
			item   = _timeAwareClassList[tac];
			classname = flash.utils.getQualifiedClassName(item);
			Utils.Begin("TimeAwareInterface", classname + ".timeChange");
			if (item.timeChange()) needNext = true;
			Utils.End("TimeAwareInterface", classname + ".timeChange");
		}
		if (model.time.hours > 23) {
			model.time.hours = 0;
			model.time.days++;
		} else if (model.time.hours == 21) {
			if (flags[kFLAGS.LETHICE_DEFEATED] <= 0) outputText("\nThe sky darkens as a starless night falls.  The blood-red moon slowly rises up over the horizon.\n");
			else outputText("\nThe sky darkens as a starry night falls.  The blood-red moon slowly rises up over the horizon.\n");
			needNext = true;
		} else if (model.time.hours == 6) {
			outputText("\nThe sky begins to grow brighter as the moon descends over distant mountains, casting a few last ominous shadows before they burn away in the light.\n");
			needNext = true;
		}
		//BIG EVENTS GO IN HERE
		//BIG EVENTS GO IN HERE
		//BIG EVENTS GO IN HERE
		//BIG EVENTS GO IN HERE

		/* Inform all time aware classes that it's time for large events to trigger. Note that timeChangeLarge could be called multiple times in a single tick
		   of the clock, so any updates should happen in timeChange and any timeChangeLarge events need to make sure they cannot repeat within the same hour.
		   In effect these are the same rules the existing code acted under. */
		for (timeAwareLargeLastEntry = 0; timeAwareLargeLastEntry < _timeAwareClassList.length; timeAwareLargeLastEntry++) {
			item   = _timeAwareClassList[timeAwareLargeLastEntry];
			classname = flash.utils.getQualifiedClassName(item);
			Utils.Begin("TimeAwareInterface", classname + ".timeChangeLarge");
			if (item.timeChangeLarge()){
				Utils.End("TimeAwareInterface", classname + ".timeChangeLarge");
				return true;
			}
			Utils.End("TimeAwareInterface", classname + ".timeChangeLarge");
		}
		timeAwareLargeLastEntry = -1; //If this var is -1 then this function has called timeChangeLarge for all entries in the _timeAwareClassList

		Utils.Begin("eventParser","impGangBangProgress");
		var igb:int = impGangBangProgress();
		Utils.End("eventParser","impGangBangProgress");
		if (igb==1) needNext = true;
		if (igb==2) return true;

		Utils.Begin("eventParser","pregnancyProgress");
		igb = pregnancyProgress();
		Utils.End("eventParser","pregnancyProgress");
		if (igb==1) needNext = true;
		if (igb==2) return true;

		Utils.Begin("eventParser","eggLoot");
		igb = eggLootProgress();
		Utils.End("eventParser","eggLoot");
		if (igb==1) needNext = true;
		if (igb==2) return true;
	}
	
	// Hanging the Uma massage update here, I think it should work...
	telAdre.umasShop.updateBonusDuration(time);
	if (player.hasStatusEffect(StatusEffects.UmasMassage))
	{
		trace("Uma's massage bonus time remaining: " + player.statusEffectv3(StatusEffects.UmasMassage));
	}
	
	highMountains.izumiScenes.updateSmokeDuration(time);
	if (player.hasStatusEffect(StatusEffects.IzumisPipeSmoke))
	{
		trace("Izumis pipe smoke time remaining: " + player.statusEffectv1(StatusEffects.IzumisPipeSmoke));
	}
	
	//Drop axe if too short!
	if (player.tallness < 78 && player.weapon == weapons.L__AXE) {
		outputText("<b>\nThis axe is too large for someone of your stature to use, though you can keep it in your inventory until you are big enough.</b>\n");
		inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
		return true;
	}
	if (player.tallness < 78 && player.weapon == weapons.DL_AXE_) {
		outputText("<b>\nThis dual axes are too large for someone of your stature to use, though you can keep them in your inventory until you are big enough.</b>\n");
		inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
		return true;
	}
	if (player.tallness < 60 && player.weapon == weapons.L_HAMMR) {
		outputText("<b>\nYou've become too short to use this hammer anymore.  You can still keep it in your inventory, but you'll need to be taller to effectively wield it.</b>\n");
		inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
		return true;
	}		
//	if (player.weapon == weapons.CLAYMOR && player.str < 40) {
//		outputText("\n<b>You aren't strong enough to handle the weight of your weapon any longer, and you're forced to stop using it.</b>\n");
//		inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
//		return true;
//	}
//	if (player.weapon == weapons.WARHAMR && player.str < 80) {
//		outputText("\n<b>You aren't strong enough to handle the weight of your weapon any longer!</b>\n");
//		inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
//		return true;
//	}
	//Drop beautiful sword if corrupted!
	if (player.weaponPerk == "holySword" && player.cor >= (33 + player.corruptionTolerance())) {
		outputText("<b>\nThe <u>[weapon]</u> grows hot in your hand, until you are forced to drop it.  Whatever power inhabits this blade appears to be unhappy with you.  Touching it gingerly, you realize it is no longer hot, but as soon as you go to grab the hilt, it nearly burns you.\n\nYou realize you won't be able to use it right now, but you could probably keep it in your inventory.</b>\n\n");
		inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
		return true;
	}
	//Drop scarred blade if not corrupted enough!
	if (player.weapon == weapons.SCARBLD && player.cor < (66 - player.corruptionTolerance()) && flags[kFLAGS.MEANINGLESS_CORRUPTION] <= 0) {
		kGAMECLASS.sheilaScene.rebellingScarredBlade();
		return true;
	}
	if (flags[kFLAGS.SCARRED_BLADE_STATUS] == 1 && player.cor >= 70) {
		kGAMECLASS.sheilaScene.findScarredBlade();
		return true;
	}
	//Unequip Lusty maiden armor
	if (player.armorName == "lusty maiden's armor") {
		//Removal due to no longer fitting:
		//Grew Cock or Balls
		if ((player.hasCock() && !player.hasSheath()) || player.balls > 0) {
			outputText("\nYou fidget uncomfortably in the g-string of your lewd bikini - there simply isn't enough room for your ");
			if (player.hasCock()) outputText("maleness");
			else outputText("bulgy balls");
			outputText(" within the imprisoning leather, and it actually hurts to wear it.  <b>You'll have to find some other form of protection!</b>\n\n");
			inventory.takeItem(player.setArmor(ArmorLib.NOTHING), playerMenu);
			return true;
		}
		//Lost pussy
		else if (!player.hasVagina()) {
			outputText("\nYou fidget uncomfortably as the crease in the gusset of your lewd bikini digs into your sensitive, featureless loins.  There's simply no way you can continue to wear this outfit in comfort - it was expressly designed to press in on the female mons, and without a vagina, <b>you simply can't wear this exotic armor.</b>\n\n");
			inventory.takeItem(player.setArmor(ArmorLib.NOTHING), playerMenu);
			return true;
		}
		//Tits gone or too small
		else if (player.biggestTitSize() < 4) {
			outputText("\nThe fine chain that makes up your lewd bikini-top is dangling slack against your flattened chest.  Every movement and step sends it jangling noisily, slapping up against your [nipples], uncomfortably cold after being separated from your " + player.skinFurScales() + " for so long.  <b>There's no two ways about it - you'll need to find something else to wear.</b>\n\n");
			inventory.takeItem(player.setArmor(ArmorLib.NOTHING), playerMenu);
			return true;
		}
	}
	//Unequip undergarment if you have bizarre lower body.
	if (player.lowerGarment != UndergarmentLib.NOTHING) {
		if (player.isTaur() || player.isDrider() || player.isScylla() || (player.isNaga() && player.lowerGarmentPerk != "NagaWearable")) {
			outputText("You feel something slipping off as if by magic. Looking down on the ground, you realize it's your [lowergarment]. Looking down at your lower body, you let out a sigh and pick up your [lowergarment]. ");
			inventory.takeItem(player.setUndergarment(UndergarmentLib.NOTHING, 1), playerMenu);
			return true;
		}
	}
	//Unequip shield if you're wielding a large weapon.
	if (((player.weaponPerk == "Large" && player.findPerk(PerkLib.TitanGrip) < 0) || player.weaponPerk == "Dual" || player.weaponPerk == "Dual Large") && player.shield != ShieldLib.NOTHING) {
		outputText("Your current weapon requires the use of two hands. As such, your shield has been unequipped automatically. ");
		inventory.takeItem(player.setShield(ShieldLib.NOTHING), playerMenu);
		return true;
	}
	// update cock type as dog/fox depending on whether the player resembles one more then the other.
	// Previously used to be computed directly in cockNoun, but refactoring prevents access to the Player class when in cockNoun now.
	if (player.totalCocks() != 0)
	{
		var counter:Number = player.totalCocks() - 1;
		while (counter >= 0)
		{
			if (player.cocks[counter].cockType == CockTypesEnum.DOG || player.cocks[counter].cockType == CockTypesEnum.FOX)
			{
				if (player.dogScore() >= player.foxScore())
					player.cocks[counter].cockType = CockTypesEnum.DOG;
				else
					player.cocks[counter].cockType = CockTypesEnum.FOX;
			}
			counter--;
			// trace("IMA LOOPIN", counter);
		}
		
	}	
	if (prison.trainingFeed.prisonCaptorFeedingQuestTrainingExists() && prison.trainingFeed.prisonCaptorFeedingQuestTrainingIsTimeUp() && rand(100) < (flags[kFLAGS.PRISON_CAPTURE_CHANCE] + player.obey / 4) && !inDungeon && !inRoomedDungeon && !prison.inPrison && !ingnam.inIngnam) {
		prison.goBackToPrisonBecauseQuestTimeIsUp();
		return true;
	}
	statScreenRefresh();
	if (needNext) {
		doNext(playerMenu);
		return true;
	}
	playerMenu();
	return false;
}
// 0: nothing, 1: needNext, 2: return true
private function eggLootProgress():int {
	//Egg loot!
	if(player.hasStatusEffect(StatusEffects.LootEgg)) {
		trace("EGG LOOT HAS");
		if (!player.hasStatusEffect(StatusEffects.Eggs)) { //Handling of errors.
			outputText("Oops, looks like something went wrong with the coding regarding gathering eggs after pregnancy. Hopefully this should never happen again. If you encounter this again, please let Kitteh6660 know so he can fix it.");
			player.removeStatusEffect(StatusEffects.LootEgg);
			doNext(playerMenu);
			return 2;
		}
		//default
		var itypes:Array = [
			[
				consumables.BROWNEG,
				consumables.PURPLEG,
				consumables.BLUEEGG,
				consumables.PINKEGG,
				consumables.WHITEEG,
				consumables.BLACKEG
			],
			[
				consumables.L_BRNEG,
				consumables.L_PRPEG,
				consumables.L_BLUEG,
				consumables.L_PNKEG,
				consumables.L_WHTEG,
				consumables.L_BLKEG
			]
		];

		var sEgg:ItemType = null;

		if (player.hasStatusEffect(StatusEffects.Eggs))
		{
			var size:int = player.statusEffectv2(StatusEffects.Eggs);

			if (size < 0 || size > 1) size = rand(2);

			var col:int = player.statusEffectv1(StatusEffects.Eggs);

			if (col < 0 || col > 5) col = rand(6);

			sEgg =  itypes[size][col];
		}
		else
		{
			sEgg = consumables.BROWNEG;
		}
		player.removeStatusEffect(StatusEffects.LootEgg);
		player.removeStatusEffect(StatusEffects.Eggs);
		trace("TAKEY NAU");
		inventory.takeItem(sEgg, playerMenu);
		return 2;
	}
	// Benoit preggers update
	if (flags[kFLAGS.FEMOIT_EGGS] > 0) flags[kFLAGS.FEMOIT_INCUBATION]--; // We're not capping it, we're going to use negative values to figure out diff events
	return 0;
}
// 0: nothing, 1: needNext, 2: return true
private function pregnancyProgress():int {
	var needNext:Boolean = false;
	//No diapause?  Normal!
	if (player.findPerk(PerkLib.Diapause) < 0) {
		if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
			flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
			return 2;
		}
		//DOUBLE PREGGERS SPEED
		if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0) {
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		}
		//DOUBLE PREGGERS SPEED
		if (player.findPerk(PerkLib.MagicalFertility) >= 0) {
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		}
		if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
			flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
			return 2;
		}
		if (player.findPerk(PerkLib.FerasBoonBreedingBitch) >= 0) {
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		}
		if (player.findPerk(PerkLib.FerasBoonWideOpen) >= 0 || player.findPerk(PerkLib.FerasBoonMilkingTwat) >= 0) {
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		}
		if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
			flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
			return 2;
		}
		//DOUBLE PREGGERS SPEED
		if (player.findPerk(PerkLib.BroodMother) >= 0) {
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		}
		if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
			flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
			return 2;
		}
	}
	//Diapause!
	else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] > 0 && (player.pregnancyIncubation > 0 || player.buttPregnancyIncubation > 0)) {
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] == 1) {
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 0;
			outputText("\n\nYour body reacts to the influx of nutrition, accelerating your pregnancy. Your belly bulges outward slightly.");
			needNext = true;
		}
		if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
			flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
			return 2;
		}
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228]--;
		if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
			flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
			return 2;
		}
		if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
			flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
			return 2;
		}
		if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
			flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
			return 2;
		}
		//DOUBLE PREGGERS SPEED
		if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0) {
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		}
		//DOUBLE PREGGERS SPEED
		if (player.findPerk(PerkLib.MagicalFertility) >= 0) {
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		}
		if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
			flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
			return 2;
		}
		if (player.findPerk(PerkLib.FerasBoonBreedingBitch) >= 0) {
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		}
		if (player.findPerk(PerkLib.FerasBoonWideOpen) >= 0 || player.findPerk(PerkLib.FerasBoonMilkingTwat) >= 0) {
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		}
		if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
			flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
			return 2;
		}
		//DOUBLE PREGGERS SPEED
		if (player.findPerk(PerkLib.BroodMother) >= 0) {
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
		}
		if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
			flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
			return 2;
		}
	}
	return needNext?1:0;
}
// 0: nothing, 1: needNext, 2: return true
private function impGangBangProgress():int {
	//IMP GANGBAAAAANGA
	//The more imps you create, the more often you get gangraped.
	temp = player.statusEffectv1(StatusEffects.BirthedImps) * 2;
	if (temp > 7) temp = 7;
	if (player.findPerk(PerkLib.PiercedLethite) >= 0) temp += 4;
	if (player.inHeat) temp += 2;
	if (vapula.vapulaSlave()) temp += 7;
	//Reduce chance
	if (flags[kFLAGS.CAMP_WALL_PROGRESS] > 0) temp /= 1 + (flags[kFLAGS.CAMP_WALL_PROGRESS] / 100);
	if (flags[kFLAGS.CAMP_WALL_GATE] > 0) temp /= 2;
	if (flags[kFLAGS.CAMP_WALL_SKULLS] > 0) temp *= 1 - (flags[kFLAGS.CAMP_WALL_SKULLS] / 100);
	if (model.time.hours == 2) {
		if (model.time.days % 30 == 0 && flags[kFLAGS.ANEMONE_KID] > 0 && player.hasCock() && flags[kFLAGS.ANEMONE_WATCH] > 0 && flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 40) {
			anemoneScene.goblinNightAnemone();
			return 1;
		} else if (temp > rand(100) && !player.hasStatusEffect(StatusEffects.DefenseCanopy)) {
			if (player.gender > 0 && (!player.hasStatusEffect(StatusEffects.JojoNightWatch) || !player.hasStatusEffect(StatusEffects.PureCampJojo)) && (flags[kFLAGS.HEL_GUARDING] == 0 || !helFollower.followerHel()) && flags[kFLAGS.ANEMONE_WATCH] == 0 && (flags[kFLAGS.HOLLI_DEFENSE_ON] == 0 || flags[kFLAGS.FUCK_FLOWER_KILLED] > 0) && (flags[kFLAGS.KIHA_CAMP_WATCH] == 0 || !kihaFollower.followerKiha()) && !(flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && (flags[kFLAGS.SLEEP_WITH] == "Marble" || flags[kFLAGS.SLEEP_WITH] == "")) && (flags[kFLAGS.IN_INGNAM] == 0 && flags[kFLAGS.IN_PRISON] == 0)) {
				impScene.impGangabangaEXPLOSIONS();
				doNext(playerMenu);
				return 2;
			}
			else if (flags[kFLAGS.KIHA_CAMP_WATCH] > 0 && kihaFollower.followerKiha()) {
				outputText("\n<b>You find charred imp carcasses all around the camp once you wake.  It looks like Kiha repelled a swarm of the little bastards.</b>\n");
				return 1;
			}
			else if (flags[kFLAGS.HEL_GUARDING] > 0 && helFollower.followerHel()) {
				outputText("\n<b>Helia informs you over a mug of beer that she whupped some major imp asshole last night.  She wiggles her tail for emphasis.</b>\n");
				return 1;
			}
			else if (player.gender > 0 && player.hasStatusEffect(StatusEffects.JojoNightWatch) && player.hasStatusEffect(StatusEffects.PureCampJojo)) {
				outputText("\n<b>Jojo informs you that he dispatched a crowd of imps as they tried to sneak into camp in the night.</b>\n");
				return 1;
			}
			else if (flags[kFLAGS.HOLLI_DEFENSE_ON] > 0 && flags[kFLAGS.FUCK_FLOWER_LEVEL] == 4) {
				outputText("\n<b>During the night, you hear distant screeches of surprise, followed by orgasmic moans.  It seems some imps found their way into Holli's canopy...</b>\n");
				return 1;
			}
			else if (flags[kFLAGS.HOLLI_DEFENSE_ON] > 0 && flags[kFLAGS.FLOWER_LEVEL] == 4) {
				outputText("\n<b>During the night, you hear distant screeches of surprise, followed by screams of pain.  It seems some imps found their way into Holli's canopy...</b>\n");
				return 1;
			}
			else if (flags[kFLAGS.ANEMONE_WATCH] > 0) {
				outputText("\n<b>Your sleep is momentarily disturbed by the sound of tiny clawed feet skittering away in all directions.  When you sit up, you can make out Kid A holding a struggling, concussed imp in a headlock and wearing a famished expression.  You catch her eye and she sheepishly retreats to a more urbane distance before beginning her noisy meal.</b>\n");
				return 1;
			}
			else if(flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && (flags[kFLAGS.SLEEP_WITH] == "Marble" || flags[kFLAGS.SLEEP_WITH] == "") && (player.inte / 5) >= rand(15)) {
				outputText("\n<b>Your sleep is momentarily disturbed by the sound of imp hands banging against your cabin door. Fortunately, you've locked the door before you've went to sleep.</b>\n");
				return 1;
			}
		}
		//wormgasms
		else if (flags[kFLAGS.EVER_INFESTED] == 1 && rand(100) <= 4 && player.hasCock() && !player.hasStatusEffect(StatusEffects.Infested)) {
			if (player.hasCock() && (!player.hasStatusEffect(StatusEffects.JojoNightWatch) || !player.hasStatusEffect(StatusEffects.PureCampJojo)) && (flags[kFLAGS.HEL_GUARDING] == 0 || !helFollower.followerHel()) && flags[kFLAGS.ANEMONE_WATCH] == 0 && (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && flags[kFLAGS.SLEEP_WITH] == "")) {
				kGAMECLASS.mountain.wormsScene.nightTimeInfestation();
				return 2;
			}
			else if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && flags[kFLAGS.SLEEP_WITH] == "") {
				outputText("\n<b>You hear the sound of a horde of worms banging against the door. Good thing you locked it before you went to sleep!</b>\n");
				return 1;
			}
			else if (flags[kFLAGS.HEL_GUARDING] > 0 && helFollower.followerHel()) {
				outputText("\n<b>Helia informs you over a mug of beer that she stomped a horde of gross worms into paste.  She shudders after at the memory.</b>\n");
				return 1;
			}
			else if (player.gender > 0 && player.hasStatusEffect(StatusEffects.JojoNightWatch) && player.hasStatusEffect(StatusEffects.PureCampJojo)) {
				outputText("\n<b>Jojo informs you that he dispatched a horde of tiny, white worms as they tried to sneak into camp in the night.</b>\n");
				return 1;
			}
			else if (flags[kFLAGS.ANEMONE_WATCH] > 0) {
				outputText("\n<b>Kid A seems fairly well fed in the morning, and you note a trail of slime leading off in the direction of the lake.</b>\n"); // Yeah, blah blah travel weirdness. Quickfix so it seems logically correct.
				return 1;
			}
		}
	}
	return 0;
}

public function cheatTime(time:Number, needNext:Boolean = false):void {
	//Advance minutes
	var minutesToPass:Number = (time -= Math.floor(time)) * 60;
	minutesToPass = Math.round(minutesToPass)
	model.time.minutes += minutesToPass;
	if (model.time.minutes > 59) {
		timeQ++;
		model.time.minutes -= 60;
		if (!buttonIsVisible(0)) goNext(timeQ, needNext);
	}
	time = Math.floor(time);
	//Advance hours
	while(time > 0) {
		time--;
		model.time.hours++;
		if(model.time.hours > 23) {
			model.time.days++;
			model.time.hours = 0;
		}
	}
	statScreenRefresh();
}

public function growHair(amount:Number = .1):Boolean {
	//Grow hair!
	temp = player.hairLength;
	player.hairLength += amount;
	if(player.hairLength > 0 && temp == 0) {
		outputText("\n<b>You are no longer bald.  You now have " + hairDescript() + " coating your head.\n</b>");
		return true;
	}
	else if(player.hairLength >= 1 && temp < 1) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairLength >= 3 && temp < 3) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairLength >= 6 && temp < 6) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairType == HAIR_GORGON && player.hairLength >= 6 && temp < 6) {
		outputText("\n<b>Your gorgon's hair growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairLength >= 10 && temp < 10) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairType == HAIR_GORGON && player.hairLength >= 10 && temp < 10) {
		outputText("\n<b>Your gorgon's hair growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairLength >= 16 && temp < 16) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairType == HAIR_GORGON && player.hairLength >= 16 && temp < 16) {
		outputText("\n<b>Your gorgon's hair growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairLength >= 26 && temp < 26) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairType == HAIR_GORGON && player.hairLength >= 26 && temp < 26) {
		outputText("\n<b>Your gorgon's hair growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairLength >= 40 && temp < 40) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairType == HAIR_GORGON && player.hairLength >= 40 && temp < 40) {
		outputText("\n<b>Your gorgon's hair growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairLength >= 40 && player.hairLength >= player.tallness && temp < player.tallness) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	else if(player.hairType == HAIR_GORGON && player.hairLength >= 40 && player.hairLength >= player.tallness && temp < player.tallness) {
		outputText("\n<b>Your gorgon's hair growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>");
		return true;
	}
	return false;
}

public function growBeard(amount:Number = .1):Boolean {
	//Grow beard!

	var tempBeard:Number = player.beardLength;
	player.beardLength += amount;

	if(player.beardLength > 0 && tempBeard == 0) {
		outputText("\n<b>You feel a tingling in your cheeks and chin.  You now have " + beardDescript() + " coating your cheeks and chin.\n</b>");
		return true;
	}
	else if(player.beardLength >= 0.2 && tempBeard < 0.2) {
		outputText("\n<b>Your beard's growth has reached a new threshhold, giving you " + beardDescript() + ".\n</b>");
		return true;
	}
	else if(player.beardLength >= 0.5 && tempBeard < 0.5) {
		outputText("\n<b>Your beard's growth has reached a new threshhold, giving you " + beardDescript() + ".\n</b>");
		return true;
	}
	else if(player.beardLength >= 1.5 && tempBeard < 1.5) {
		outputText("\n<b>Your beard's growth has reached a new threshhold, giving you " + beardDescript() + ".\n</b>");
		return true;
	}
	else if(player.beardLength >= 3 && tempBeard < 3) {
		outputText("\n<b>Your beard's growth has reached a new threshhold, giving you " + beardDescript() + ".\n</b>");
		return true;
	}
	else if(player.beardLength >= 6 && tempBeard < 6) {
		outputText("\n<b>Your beard's growth has reached a new threshhold, giving you " + beardDescript() + ".\n</b>");
		return true;
	}

	return false;
}
