package classes {
import classes.BodyParts.Hair;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.ArmorLib;
import classes.Items.ShieldLib;
import classes.Items.UndergarmentLib;
import classes.Items.WeaponLib;
import classes.Scenes.Dungeons.DungeonAbstractContent;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

import coc.view.MainView;

import flash.net.SharedObject;
import flash.utils.getQualifiedClassName;

public class EventParser {
    private static var _timeAwareClassList:Vector.<TimeAwareInterface> = new Vector.<TimeAwareInterface>();
    //Used by the eventParser in calling timeAwareLarge
    private static var timeAwareLargeLastEntry:int = -1;
    private static var _doCamp:Function;
    private static var _campSet:Boolean = false;

    public static function playerMenu():void {
        CoC.instance.mainViewManager.hidePlayerDoll();
        if (!CoC.instance.inCombat) {
            CoC.instance.spriteSelect(-1);
        }
        CoC.instance.mainView.setMenuButton(MainView.MENU_NEW_MAIN, "New Game", CoC.instance.charCreation.newGameGo);
        CoC.instance.mainView.nameBox.visible = false;
        if (CoC.instance.gameState == 1 || CoC.instance.gameState == 2) {
            SceneLib.combat.combatMenu();
            return;
        }
        //Clear restriction on item overlaps if not in combat
        CoC.instance.plotFight = false;
        if (DungeonAbstractContent.inDungeon) {
            //dungeonMenu();
            SceneLib.dungeons.checkRoom();
            return;
        }
        else if (DungeonAbstractContent.inRoomedDungeon) {
            if (DungeonAbstractContent.inRoomedDungeonResume != null) DungeonAbstractContent.inRoomedDungeonResume();
            return;
        }
        CoC.instance.flags[kFLAGS.PLAYER_PREGGO_WITH_WORMS] = 0;
        _doCamp();
    }

    public static function gameOver(clear:Boolean = false):void { //Leaves text on screen unless clear is set to true
        if (CoC.instance.testingBlockExiting) {
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour); //Prevent ChaosMonkah instances from getting stuck
        }
        else {
            var textChoices:Number = Utils.rand(4);
            if (clear) EngineCore.clearOutput();
            EngineCore.outputText("\n\n<font color=\"#800000\">");
            if (textChoices == 0) EngineCore.outputText("<b>GAME OVER</b>");
            if (textChoices == 1) EngineCore.outputText("<b>Game over, man! Game over!</b>");
            if (textChoices == 2) EngineCore.outputText("<b>You just got Bad-Ended!</b>");
            if (textChoices == 3) EngineCore.outputText("<b>Your adventures have came to an end...</b>");
            EngineCore.outputText("</font>");
            //Delete save on hardcore.
            if (CoC.instance.flags[kFLAGS.HARDCORE_MODE] > 0) {
                EngineCore.outputText("\n\n<b>Your save file has been deleted as you are on Hardcore Mode!</b>");
                CoC.instance.flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] = CoC.instance.flags[kFLAGS.HARDCORE_SLOT];
                var test:* = SharedObject.getLocal(CoC.instance.flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION], "/");
                if (test.data.exists) {
                    trace("DELETING SLOT: " + CoC.instance.flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION]);
                    test.clear();
                }
            }
            CoC.instance.flags[kFLAGS.TIMES_BAD_ENDED]++;
            EngineCore.awardAchievement("Game Over!", kACHIEVEMENTS.GENERAL_GAME_OVER, true, true);
            EngineCore.menu();
            EngineCore.addButton(0, "Game Over", gameOverMenuOverride).hint("Your game has ended. Please load a saved file or start a new game.");
            if (CoC.instance.flags[kFLAGS.HARDCORE_MODE] <= 0) EngineCore.addButton(1, "Continue", SceneLib.camp.wakeFromBadEnd).hint("It's all just a dream. Wake up.");
            //addButton(3, "NewGamePlus", charCreation.newGamePlus).hint("Start a new game with your equipment, experience, and gems carried over.");
            if (CoC.instance.flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 || CoC.instance.debug) EngineCore.addButton(4, "Debug Cheat", playerMenu);
            gameOverMenuOverride();

        }
        CoC.instance.inCombat = false;
        DungeonAbstractContent.dungeonLoc = 0; //Replaces inDungeon = false;
		
		if (CoC.instance.player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) {
			if (CoC.instance.player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) CoC.instance.player.removeStatusEffect(StatusEffects.ThereCouldBeOnlyOne);
			CoC.instance.player.removeStatusEffect(StatusEffects.EbonLabyrinthA);
			CoC.instance.player.removeStatusEffect(StatusEffects.EbonLabyrinthB);
			if (CoC.instance.player.hasStatusEffect(StatusEffects.EbonLabyrinthBoss1)) CoC.instance.player.removeStatusEffect(StatusEffects.EbonLabyrinthBoss1);
			if (CoC.instance.player.hasStatusEffect(StatusEffects.EbonLabyrinthBoss2)) CoC.instance.player.removeStatusEffect(StatusEffects.EbonLabyrinthBoss2);
		}
		if (CoC.instance.player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
			if (CoC.instance.player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) CoC.instance.player.removeStatusEffect(StatusEffects.ThereCouldBeOnlyOne);
			CoC.instance.player.removeStatusEffect(StatusEffects.RiverDungeonA);
		}
    }

    private static function gameOverMenuOverride():void { //Game over event; override whatever the fuck has been done to the UI up to this point to force display of the data and new game buttons
        CoC.instance.mainView.showMenuButton(MainView.MENU_NEW_MAIN);
        CoC.instance.mainView.showMenuButton(MainView.MENU_DATA);
        CoC.instance.mainView.hideMenuButton(MainView.MENU_APPEARANCE);
        CoC.instance.mainView.hideMenuButton(MainView.MENU_LEVEL);
        CoC.instance.mainView.hideMenuButton(MainView.MENU_PERKS);
    }

    public static function getCurrentStackTrace():String		// Fuck, stack-traces only work in the debug player.
    {
        var tempError:Error = new Error();
        var stackTrace:String = tempError.getStackTrace();
        return stackTrace;
    }

    public static function errorPrint(details:* = null):void {
        EngineCore.rawOutputText("<b>Congratulations, you've found a bug!</b>", true);
        EngineCore.rawOutputText("\nError: Unknown event!");
        EngineCore.rawOutputText("\n\nPlease report that you had an issue with code: \"" + details + "\" ");
        EngineCore.rawOutputText("\nGame version: \"" + CoC.instance.ver + "\" (<b>THIS IS IMPORTANT! Please be sure you include it!</b>) ");

        var sTrace:String = getCurrentStackTrace();

        if (sTrace)	// Fuck, stack-traces only work in the debug player.
            EngineCore.rawOutputText("and stack-trace: \n <pre>" + sTrace + "</pre>\n");
        EngineCore.rawOutputText("to fake-name on the forums or better yet, file a bug report on github: ");
        EngineCore.rawOutputText("\nhttps://github.com/herp-a-derp/Corruption-of-Champions");

        EngineCore.rawOutputText("\nPlease try to include the details of what you were doing when you encountered this bug ");
        if (sTrace)
            EngineCore.rawOutputText(" (including the above stack trace copy&pasted into the details),");
        EngineCore.rawOutputText(" to make tracking the issue down easier. Thanks!");

        EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
    }

    public static function goNext(time:Number, needNext:Boolean):Boolean {
        Utils.Begin("eventParser", "goNext", time);
        var x:Boolean = goNextWrapped(time, needNext);
        Utils.End("eventParser", "goNext");
        return x;
    }

    private static function goNextWrapped(time:Number, needNext:Boolean):Boolean {
        var player:Player = CoC.instance.player;
        //Update system time
        //date = new Date();
        //trace ("MONTH: " + date.month + " DATE: " + date.date + " MINUTES: " + date.minutes);
        //clearOutput();
        if (timeAwareLargeLastEntry >= 0) { //Finish calling timeChangeLarge before advancing the hour again
            for (; timeAwareLargeLastEntry < _timeAwareClassList.length; timeAwareLargeLastEntry++) {
                var item:TimeAwareInterface = _timeAwareClassList[timeAwareLargeLastEntry];
                var classname:String = getQualifiedClassName(item);
                Utils.Begin("TimeAwareInterface", classname + ".timeChangeLarge");
                if (item.timeChangeLarge()) {
                    Utils.End("TimeAwareInterface", classname + ".timeChangeLarge");
                    return true;
                }
                Utils.End("TimeAwareInterface", classname + ".timeChangeLarge");
            }
            timeAwareLargeLastEntry = -1;
        }
        while (CoC.instance.timeQ > 0) {
            CoC.instance.timeQ--;
            CoC.instance.model.time.hours++;
            SceneLib.combat.regeneration(false);
            if (player.findPerk(PerkLib.JobSoulCultivator) >= 0) SceneLib.combat.soulforceregeneration(false);
            if (player.findPerk(PerkLib.JobSorcerer) >= 0) SceneLib.combat.manaregeneration(false);
            SceneLib.combat.wrathregeneration(false);
            //Inform all time aware classes that a new hour has arrived
            for (var tac:int = 0; tac < _timeAwareClassList.length; tac++) {
                item = _timeAwareClassList[tac];
                classname = getQualifiedClassName(item);
                Utils.Begin("TimeAwareInterface", classname + ".timeChange");
                if (item.timeChange()) needNext = true;
                Utils.End("TimeAwareInterface", classname + ".timeChange");
            }
            if (CoC.instance.model.time.hours > 23) {
                CoC.instance.model.time.hours = 0;
                CoC.instance.model.time.days++;
            } else if (CoC.instance.model.time.hours == 21) {
                if (CoC.instance.flags[kFLAGS.LETHICE_DEFEATED] <= 0) EngineCore.outputText("\nThe sky darkens as a starless night falls.  The blood-red moon slowly rises up over the horizon.\n");
                else EngineCore.outputText("\nThe sky darkens as a starry night falls.  The blood-red moon slowly rises up over the horizon.\n");
                needNext = true;
            } else if (CoC.instance.model.time.hours == 6) {
                EngineCore.outputText("\nThe sky begins to grow brighter as the moon descends over distant mountains, casting a few last ominous shadows before they burn away in the light.\n");
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
                item = _timeAwareClassList[timeAwareLargeLastEntry];
                classname = getQualifiedClassName(item);
                Utils.Begin("TimeAwareInterface", classname + ".timeChangeLarge");
                if (item.timeChangeLarge()) {
                    Utils.End("TimeAwareInterface", classname + ".timeChangeLarge");
                    return true;
                }
                Utils.End("TimeAwareInterface", classname + ".timeChangeLarge");
            }
            timeAwareLargeLastEntry = -1; //If this var is -1 then this function has called timeChangeLarge for all entries in the _timeAwareClassList

            Utils.Begin("eventParser", "impGangBangProgress");
            var igb:int = impGangBangProgress();
            Utils.End("eventParser", "impGangBangProgress");
            if (igb == 1) needNext = true;
            if (igb == 2) return true;

            Utils.Begin("eventParser", "pregnancyProgress");
            igb = pregnancyProgress();
            Utils.End("eventParser", "pregnancyProgress");
            if (igb == 1) needNext = true;
            if (igb == 2) return true;

            Utils.Begin("eventParser", "eggLoot");
            igb = eggLootProgress();
            Utils.End("eventParser", "eggLoot");
            if (igb == 1) needNext = true;
            if (igb == 2) return true;
        }

        // Hanging the Uma massage update here, I think it should work...
        SceneLib.telAdre.umasShop.updateBonusDuration(time);
        if (player.hasStatusEffect(StatusEffects.UmasMassage)) {
            trace("Uma's massage bonus time remaining: " + player.statusEffectv3(StatusEffects.UmasMassage));
        }

        SceneLib.highMountains.izumiScenes.updateSmokeDuration(time);
        if (player.hasStatusEffect(StatusEffects.IzumisPipeSmoke)) {
            trace("Izumis pipe smoke time remaining: " + player.statusEffectv1(StatusEffects.IzumisPipeSmoke));
        }

        //Drop axe if too short!
        if (player.tallness < 78 && player.weapon == CoC.instance.weapons.L__AXE) {
            EngineCore.outputText("<b>\nThis axe is too large for someone of your stature to use, though you can keep it in your inventory until you are big enough.</b>\n");
            SceneLib.inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
            return true;
        }
        if (player.tallness < 78 && player.weapon == CoC.instance.weapons.DL_AXE_) {
            EngineCore.outputText("<b>\nThis dual axes are too large for someone of your stature to use, though you can keep them in your inventory until you are big enough.</b>\n");
            SceneLib.inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
            return true;
        }
        if (player.tallness < 60 && player.weapon == CoC.instance.weapons.L_HAMMR) {
            EngineCore.outputText("<b>\nYou've become too short to use this hammer anymore.  You can still keep it in your inventory, but you'll need to be taller to effectively wield it.</b>\n");
            SceneLib.inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
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
            EngineCore.outputText("<b>\nThe <u>[weapon]</u> grows hot in your hand, until you are forced to drop it.  Whatever power inhabits this blade appears to be unhappy with you.  Touching it gingerly, you realize it is no longer hot, but as soon as you go to grab the hilt, it nearly burns you.\n\nYou realize you won't be able to use it right now, but you could probably keep it in your inventory.</b>\n\n");
            SceneLib.inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
            return true;
        }
        //Drop Excalibur if corrupted!
        if (player.weaponPerk == "Excalibur" && player.cor >= (33 + player.corruptionTolerance())) {
            EngineCore.outputText("<b>\nThe <u>[weapon]</u> grows hot in your hand, until you are forced to drop it.  Whatever power inhabits this blade appears to be unhappy with you.  Touching it gingerly, you realize it is no longer hot, but as soon as you go to grab the hilt, it nearly burns you.\n\nYou realize you won't be able to use it right now, but you could probably keep it in your inventory.</b>\n\n");
            SceneLib.inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
            return true;
        }
        //Drop scarred blade if not corrupted enough!
        if (player.weapon == CoC.instance.weapons.SCARBLD && player.cor < (66 - player.corruptionTolerance()) && CoC.instance.flags[kFLAGS.MEANINGLESS_CORRUPTION] <= 0) {
            SceneLib.sheilaScene.rebellingScarredBlade();
            return true;
        }
        if (CoC.instance.flags[kFLAGS.SCARRED_BLADE_STATUS] == 1 && player.cor >= 70) {
            SceneLib.sheilaScene.findScarredBlade();
            return true;
        }
        //Unequip Lusty maiden armor
        if (player.armorName == "lusty maiden's armor") {
            //Removal due to no longer fitting:
            //Grew Cock or Balls
            if ((player.hasCock() && !player.hasSheath()) || player.balls > 0) {
                EngineCore.outputText("\nYou fidget uncomfortably in the g-string of your lewd bikini - there simply isn't enough room for your ");
                if (player.hasCock()) EngineCore.outputText("maleness");
                else EngineCore.outputText("bulgy balls");
                EngineCore.outputText(" within the imprisoning leather, and it actually hurts to wear it.  <b>You'll have to find some other form of protection!</b>\n\n");
                SceneLib.inventory.takeItem(player.setArmor(ArmorLib.NOTHING), playerMenu);
                return true;
            }
            //Lost pussy
            else if (!player.hasVagina()) {
                EngineCore.outputText("\nYou fidget uncomfortably as the crease in the gusset of your lewd bikini digs into your sensitive, featureless loins.  There's simply no way you can continue to wear this outfit in comfort - it was expressly designed to press in on the female mons, and without a vagina, <b>you simply can't wear this exotic armor.</b>\n\n");
                SceneLib.inventory.takeItem(player.setArmor(ArmorLib.NOTHING), playerMenu);
                return true;
            }
            //Tits gone or too small
            else if (player.biggestTitSize() < 4) {
                EngineCore.outputText("\nThe fine chain that makes up your lewd bikini-top is dangling slack against your flattened chest.  Every movement and step sends it jangling noisily, slapping up against your [nipples], uncomfortably cold after being separated from your " + player.skinFurScales() + " for so long.  <b>There's no two ways about it - you'll need to find something else to wear.</b>\n\n");
                SceneLib.inventory.takeItem(player.setArmor(ArmorLib.NOTHING), playerMenu);
                return true;
            }
        }
        //Unequip undergarment if you have bizarre lower body.
        if (player.lowerGarment != UndergarmentLib.NOTHING) {
            if (player.isTaur() || player.isDrider() || player.isScylla() || (player.isNaga() && player.lowerGarmentPerk != "NagaWearable")) {
                EngineCore.outputText("You feel something slipping off as if by magic. Looking down on the ground, you realize it's your [lowergarment]. Looking down at your lower body, you let out a sigh and pick up your [lowergarment]. ");
                SceneLib.inventory.takeItem(player.setUndergarment(UndergarmentLib.NOTHING, 1), playerMenu);
                return true;
            }
        }
        //Unequip shield if you're wielding a large weapon.
        if (((player.weaponPerk == "Large" && player.findPerk(PerkLib.TitanGrip) < 0) || player.weaponPerk == "Dual" || player.weaponPerk == "Dual Large") && player.shield != ShieldLib.NOTHING) {
            EngineCore.outputText("Your current weapon requires the use of two hands. As such, your shield has been unequipped automatically. ");
            SceneLib.inventory.takeItem(player.setShield(ShieldLib.NOTHING), playerMenu);
            return true;
        }
        // update cock type as dog/fox depending on whether the player resembles one more then the other.
        // Previously used to be computed directly in cockNoun, but refactoring prevents access to the Player class when in cockNoun now.
        if (player.cockTotal() != 0) {
            var counter:Number = player.cockTotal() - 1;
            while (counter >= 0) {
                if (player.cocks[counter].cockType == CockTypesEnum.DOG || player.cocks[counter].cockType == CockTypesEnum.FOX) {
                    if (player.dogScore() >= player.foxScore())
                        player.cocks[counter].cockType = CockTypesEnum.DOG;
                    else
                        player.cocks[counter].cockType = CockTypesEnum.FOX;
                }
                counter--;
                // trace("IMA LOOPIN", counter);
            }

        }
        if (SceneLib.prison.trainingFeed.prisonCaptorFeedingQuestTrainingExists() && SceneLib.prison.trainingFeed.prisonCaptorFeedingQuestTrainingIsTimeUp() && Utils.rand(100) < (CoC.instance.flags[kFLAGS.PRISON_CAPTURE_CHANCE] + player.obey / 4) && !DungeonAbstractContent.inDungeon && !DungeonAbstractContent.inRoomedDungeon && !SceneLib.prison.inPrison && !SceneLib.ingnam.inIngnam) {
            SceneLib.prison.goBackToPrisonBecauseQuestTimeIsUp();
            return true;
        }
        EngineCore.statScreenRefresh();
        if (needNext) {
            EngineCore.doNext(playerMenu);
            return true;
        }
        playerMenu();
        return false;
    }

    private static function eggLootProgress():int {
        //Egg loot!
        var player:Player = CoC.instance.player;
        if (player.hasStatusEffect(StatusEffects.LootEgg)) {
            trace("EGG LOOT HAS");
            if (!player.hasStatusEffect(StatusEffects.Eggs)) { //Handling of errors.
                EngineCore.outputText("Oops, looks like something went wrong with the coding regarding gathering eggs after pregnancy. Hopefully this should never happen again. If you encounter this again, please let Ormael/Aimozg/Oxdeception know so he can fix it.");
                player.removeStatusEffect(StatusEffects.LootEgg);
                EngineCore.doNext(playerMenu);
                return 2;
            }
            //default
            var itypes:Array = [
                [
                    CoC.instance.consumables.BROWNEG,
                    CoC.instance.consumables.PURPLEG,
                    CoC.instance.consumables.BLUEEGG,
                    CoC.instance.consumables.PINKEGG,
                    CoC.instance.consumables.WHITEEG,
                    CoC.instance.consumables.BLACKEG
                ],
                [
                    CoC.instance.consumables.L_BRNEG,
                    CoC.instance.consumables.L_PRPEG,
                    CoC.instance.consumables.L_BLUEG,
                    CoC.instance.consumables.L_PNKEG,
                    CoC.instance.consumables.L_WHTEG,
                    CoC.instance.consumables.L_BLKEG
                ]
            ];

            var sEgg:ItemType = null;

            if (player.hasStatusEffect(StatusEffects.Eggs)) {
                var size:int = player.statusEffectv2(StatusEffects.Eggs);

                if (size < 0 || size > 1) {
                    size = Utils.rand(2);
                }
                var col:int = player.statusEffectv1(StatusEffects.Eggs);

                if (col < 0 || col > 5) {
                    col = Utils.rand(6);
                }
                sEgg = itypes[size][col];
            }
            else {
                sEgg = CoC.instance.consumables.BROWNEG;
            }
            player.removeStatusEffect(StatusEffects.LootEgg);
            player.removeStatusEffect(StatusEffects.Eggs);
            trace("TAKEY NAU");
            SceneLib.inventory.takeItem(sEgg, playerMenu);
            return 2;
        }
        // Benoit preggers update
        if (CoC.instance.flags[kFLAGS.FEMOIT_EGGS] > 0) CoC.instance.flags[kFLAGS.FEMOIT_INCUBATION]--; // We're not capping it, we're going to use negative values to figure out diff events
        return 0;
    }

    private static function pregnancyProgress():int {
        var needNext:Boolean = false;
        //No diapause?  Normal!
        var player:Player = CoC.instance.player;
        var flags:DefaultDict = CoC.instance.flags;
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
                EngineCore.outputText("\n\nYour body reacts to the influx of nutrition, accelerating your pregnancy. Your belly bulges outward slightly.");
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
        return needNext ? 1 : 0;
    }

    private static function impGangBangProgress():int {
        //IMP GANGBAAAAANGA
        //The more imps you create, the more often you get gangraped.
        var player:Player = CoC.instance.player;
        var chance:Number = player.statusEffectv1(StatusEffects.BirthedImps) * 2;
        if (chance > 7) chance = 7;
        if (player.findPerk(PerkLib.PiercedLethite) >= 0) chance += 4;
        if (player.inHeat) chance += 2;
        if (SceneLib.vapula.vapulaSlave()) chance += 7;
        //Reduce chance
        var flags:DefaultDict = CoC.instance.flags;
        if (flags[kFLAGS.CAMP_WALL_PROGRESS] > 0) chance /= 1 + (flags[kFLAGS.CAMP_WALL_PROGRESS] / 100);
        if (flags[kFLAGS.CAMP_WALL_GATE] > 0) chance /= 2;
        if (flags[kFLAGS.CAMP_WALL_SKULLS] > 0) chance *= 1 - (flags[kFLAGS.CAMP_WALL_SKULLS] / 100);
        if (CoC.instance.model.time.hours == 2) {
            if (CoC.instance.model.time.days % 30 == 0 && flags[kFLAGS.ANEMONE_KID] > 0 && player.hasCock() && flags[kFLAGS.ANEMONE_WATCH] > 0 && flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 40) {
                SceneLib.anemoneScene.goblinNightAnemone();
                return 1;
            } else if (chance > Utils.rand(100) && !player.hasStatusEffect(StatusEffects.DefenseCanopy)) {
                if (player.gender > 0 && (!player.hasStatusEffect(StatusEffects.JojoNightWatch) || !player.hasStatusEffect(StatusEffects.PureCampJojo)) && (flags[kFLAGS.HEL_GUARDING] == 0 || !SceneLib.helFollower.followerHel()) && flags[kFLAGS.ANEMONE_WATCH] == 0 && (flags[kFLAGS.HOLLI_DEFENSE_ON] == 0 || flags[kFLAGS.FUCK_FLOWER_KILLED] > 0) && (flags[kFLAGS.KIHA_CAMP_WATCH] == 0 || !SceneLib.kihaFollower.followerKiha()) && !(flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && (flags[kFLAGS.SLEEP_WITH] == "Marble" || flags[kFLAGS.SLEEP_WITH] == "")) &&
                        (flags[kFLAGS.IN_INGNAM] == 0 && flags[kFLAGS.IN_PRISON] == 0) || flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 2) {
                    SceneLib.impScene.impGangabangaEXPLOSIONS();
                    EngineCore.doNext(playerMenu);
                    return 2;
                }
                else if (flags[kFLAGS.KIHA_CAMP_WATCH] > 0 && SceneLib.kihaFollower.followerKiha()) {
                    EngineCore.outputText("\n<b>You find charred imp carcasses all around the camp once you wake.  It looks like Kiha repelled a swarm of the little bastards.</b>\n");
                    return 1;
                }
                else if (flags[kFLAGS.HEL_GUARDING] > 0 && SceneLib.helFollower.followerHel()) {
                    EngineCore.outputText("\n<b>Helia informs you over a mug of beer that she whupped some major imp asshole last night.  She wiggles her tail for emphasis.</b>\n");
                    return 1;
                }
                else if (player.gender > 0 && player.hasStatusEffect(StatusEffects.JojoNightWatch) && player.hasStatusEffect(StatusEffects.PureCampJojo)) {
                    EngineCore.outputText("\n<b>Jojo informs you that he dispatched a crowd of imps as they tried to sneak into camp in the night.</b>\n");
                    return 1;
                }
                else if (flags[kFLAGS.HOLLI_DEFENSE_ON] > 0 && flags[kFLAGS.FUCK_FLOWER_LEVEL] == 4) {
                    EngineCore.outputText("\n<b>During the night, you hear distant screeches of surprise, followed by orgasmic moans.  It seems some imps found their way into Holli's canopy...</b>\n");
                    return 1;
                }
                else if (flags[kFLAGS.HOLLI_DEFENSE_ON] > 0 && flags[kFLAGS.FLOWER_LEVEL] == 4) {
                    EngineCore.outputText("\n<b>During the night, you hear distant screeches of surprise, followed by screams of pain.  It seems some imps found their way into Holli's canopy...</b>\n");
                    return 1;
                }
                else if (flags[kFLAGS.ANEMONE_WATCH] > 0) {
                    EngineCore.outputText("\n<b>Your sleep is momentarily disturbed by the sound of tiny clawed feet skittering away in all directions.  When you sit up, you can make out Kid A holding a struggling, concussed imp in a headlock and wearing a famished expression.  You catch her eye and she sheepishly retreats to a more urbane distance before beginning her noisy meal.</b>\n");
                    return 1;
                }
                else if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && (flags[kFLAGS.SLEEP_WITH] == "Marble" || flags[kFLAGS.SLEEP_WITH] == "") && (player.inte / 5) >= Utils.rand(15)) {
                    EngineCore.outputText("\n<b>Your sleep is momentarily disturbed by the sound of imp hands banging against your cabin door. Fortunately, you've locked the door before you've went to sleep.</b>\n");
                    return 1;
                }
                else if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 3) {
                    EngineCore.outputText("\n<b>You notice an unusual pulse in the ward surrounding the camp.  It appears that a few uninvited visitors attempted to locate your camp last night.</b>\n");
                    return 1;
                }
            }
            //wormgasms
            else if (flags[kFLAGS.EVER_INFESTED] == 1 && Utils.rand(100) <= 4 && player.hasCock() && !player.hasStatusEffect(StatusEffects.Infested)) {
                if (player.hasCock() && (!player.hasStatusEffect(StatusEffects.JojoNightWatch) || !player.hasStatusEffect(StatusEffects.PureCampJojo)) && (flags[kFLAGS.HEL_GUARDING] == 0 || !SceneLib.helFollower.followerHel()) && flags[kFLAGS.ANEMONE_WATCH] == 0 && (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && flags[kFLAGS.SLEEP_WITH] == "")) {
                    SceneLib.mountain.wormsScene.nightTimeInfestation();
                    return 2;
                }
                else if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && flags[kFLAGS.SLEEP_WITH] == "") {
                    EngineCore.outputText("\n<b>You hear the sound of a horde of worms banging against the door. Good thing you locked it before you went to sleep!</b>\n");
                    return 1;
                }
                else if (flags[kFLAGS.HEL_GUARDING] > 0 && SceneLib.helFollower.followerHel()) {
                    EngineCore.outputText("\n<b>Helia informs you over a mug of beer that she stomped a horde of gross worms into paste.  She shudders after at the memory.</b>\n");
                    return 1;
                }
                else if (player.gender > 0 && player.hasStatusEffect(StatusEffects.JojoNightWatch) && player.hasStatusEffect(StatusEffects.PureCampJojo)) {
                    EngineCore.outputText("\n<b>Jojo informs you that he dispatched a horde of tiny, white worms as they tried to sneak into camp in the night.</b>\n");
                    return 1;
                }
                else if (flags[kFLAGS.ANEMONE_WATCH] > 0) {
                    EngineCore.outputText("\n<b>Kid A seems fairly well fed in the morning, and you note a trail of slime leading off in the direction of the lake.</b>\n"); // Yeah, blah blah travel weirdness. Quickfix so it seems logically correct.
                    return 1;
                }
            }
        }
        return 0;
    }

    public static function cheatTime(time:Number, needNext:Boolean = false):void {
        //Advance minutes
        var minutesToPass:Number = (time -= Math.floor(time)) * 60;
        minutesToPass = Math.round(minutesToPass);
        CoC.instance.model.time.minutes += minutesToPass;
        if (CoC.instance.model.time.minutes > 59) {
            CoC.instance.timeQ++;
            CoC.instance.model.time.minutes -= 60;
            if (!EngineCore.buttonIsVisible(0)) goNext(CoC.instance.timeQ, needNext);
        }
        time = Math.floor(time);
        //Advance hours
        while (time > 0) {
            time--;
            CoC.instance.model.time.hours++;
            if (CoC.instance.model.time.hours > 23) {
                CoC.instance.model.time.days++;
                CoC.instance.model.time.hours = 0;
            }
        }
        EngineCore.statScreenRefresh();
    }
	public static function cheatTime2(time:Number, needNext:Boolean = false):void {
        //Advance minutes
        var minutesToPass:Number = time;
        CoC.instance.model.time.minutes += minutesToPass;
        if (CoC.instance.model.time.minutes > 59) {
            CoC.instance.timeQ++;
            CoC.instance.model.time.minutes -= 60;
            if (!EngineCore.buttonIsVisible(0)) goNext(CoC.instance.timeQ, needNext);
        }
        time = Math.floor(time);
        //Advance hours
        if (CoC.instance.timeQ > 0) {
            CoC.instance.timeQ--;
            CoC.instance.model.time.hours++;
            if (CoC.instance.model.time.hours > 23) {
                CoC.instance.model.time.days++;
                CoC.instance.model.time.hours = 0;
            }
        }
        EngineCore.statScreenRefresh();
    }

    public static function growHair(amount:Number = .1):Boolean {
        //Grow hair!
        var player:Player = CoC.instance.player;
        var currentLength:Number = player.hairLength;
        player.hairLength += amount;
        if (player.hairLength > 0 && currentLength == 0) {
            EngineCore.outputText("\n<b>You are no longer bald.  You now have " + Appearance.hairDescription(player) + " coating your head.\n</b>");
            return true;
        }
        else if (player.hairLength >= 1 && currentLength < 1) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 3 && currentLength < 3) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 6 && currentLength < 6) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairType == Hair.GORGON && player.hairLength >= 6 && currentLength < 6) {
            EngineCore.outputText("\n<b>Your gorgon's hair growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 10 && currentLength < 10) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairType == Hair.GORGON && player.hairLength >= 10 && currentLength < 10) {
            EngineCore.outputText("\n<b>Your gorgon's hair growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 16 && currentLength < 16) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairType == Hair.GORGON && player.hairLength >= 16 && currentLength < 16) {
            EngineCore.outputText("\n<b>Your gorgon's hair growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 26 && currentLength < 26) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairType == Hair.GORGON && player.hairLength >= 26 && currentLength < 26) {
            EngineCore.outputText("\n<b>Your gorgon's hair growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 40 && currentLength < 40) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairType == Hair.GORGON && player.hairLength >= 40 && currentLength < 40) {
            EngineCore.outputText("\n<b>Your gorgon's hair growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 40 && player.hairLength >= player.tallness && currentLength < player.tallness) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairType == Hair.GORGON && player.hairLength >= 40 && player.hairLength >= player.tallness && currentLength < player.tallness) {
            EngineCore.outputText("\n<b>Your gorgon's hair growth has reached a new threshhold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        return false;
    }

    public static function growBeard(amount:Number = .1):Boolean {
        //Grow beard!
        var player:Player = CoC.instance.player;
        var tempBeard:Number = player.beardLength;
        player.beardLength += amount;

        if (player.beardLength > 0 && tempBeard == 0) {
            EngineCore.outputText("\n<b>You feel a tingling in your cheeks and chin.  You now have " + Appearance.beardDescription(player) + " coating your cheeks and chin.\n</b>");
            return true;
        }
        else if (player.beardLength >= 0.2 && tempBeard < 0.2) {
            EngineCore.outputText("\n<b>Your beard's growth has reached a new threshhold, giving you " + Appearance.beardDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.beardLength >= 0.5 && tempBeard < 0.5) {
            EngineCore.outputText("\n<b>Your beard's growth has reached a new threshhold, giving you " + Appearance.beardDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.beardLength >= 1.5 && tempBeard < 1.5) {
            EngineCore.outputText("\n<b>Your beard's growth has reached a new threshhold, giving you " + Appearance.beardDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.beardLength >= 3 && tempBeard < 3) {
            EngineCore.outputText("\n<b>Your beard's growth has reached a new threshhold, giving you " + Appearance.beardDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.beardLength >= 6 && tempBeard < 6) {
            EngineCore.outputText("\n<b>Your beard's growth has reached a new threshhold, giving you " + Appearance.beardDescription(player) + ".\n</b>");
            return true;
        }

        return false;
    }
    //Any classes that need to be aware of the passage of time can add themselves to this array using timeAwareAdd.
    //	Once in the array they will be notified as each hour passes, allowing them to update actions, lactation, pregnancy, etc.

    public static function timeAwareClassAdd(newEntry:TimeAwareInterface):void {
        _timeAwareClassList.push(newEntry);
    }

    public static function timeAwareClassRemove(toRemove:TimeAwareInterface):void {
        var i:int = _timeAwareClassList.indexOf(toRemove);
        if (i >= 0) {
            _timeAwareClassList.splice(i, 1);
        }
    }

    public static function set doCamp(value:Function):void {
        if(_campSet){throw new Error("Multiple Docamp Inits");return;}
        _doCamp = value;
        _campSet = true;
    }
}
}
