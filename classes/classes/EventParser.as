package classes {
import classes.BodyParts.Hair;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GeneticMemories.CockMem;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armors.BattleMaidenArmor;
import classes.Items.Armors.LustyMaidensArmor;
import classes.Items.Armors.SuccubusArmor;
import classes.Items.WeaponLib;
import classes.Scenes.Dungeons.DungeonAbstractContent;
import classes.Scenes.Metamorph;
import classes.Scenes.NPCs.EtnaDaughterScene;
import classes.Scenes.NPCs.ZenjiScenes;
import classes.Scenes.SceneLib;
import classes.Stats.Buff;
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
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        if (!CoC.instance.inCombat) {
            CoC.instance.spriteSelect(null);
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
        if (SceneLib.explorationEngine.isActive) {
            SceneLib.explorationEngine.doExplore();
            return;
        }
        _doCamp();
    }

    public static var badEnded:Boolean = false; //set to 'true' to track bad ended state in save-load menu

    public static function gameOver(clear:Boolean = false):void { //Leaves text on screen unless clear is set to true
        if (CoC.instance.testingBlockExiting) EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour); //Prevent ChaosMonkah instances from getting stuck
        else {
            badEnded = true;
            var textChoices:Array = ["GAME OVER",
                "Game over, man! Game over!",
                "You just got Bad-Ended!",
                "Your adventures have come to an end...",
                //Silly Mode
                "Don't lose hope... " + CoC.instance.player.short + "! Stay determined!",
                "Wasted",
                "YOU DIED",
                "Git gud!",
                "Get rekt, noob!",
                "OOF."];
            if (clear) EngineCore.clearOutput();
            EngineCore.outputText("\n\n<font color=\"#800000\">");
            EngineCore.outputText("<b>" + textChoices[Utils.rand(EngineCore.silly() ? textChoices.length : 4)] + "</b>");
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
			if (CoC.instance.player.hasStatusEffect(StatusEffects.PCClone) && CoC.instance.player.statusEffectv3(StatusEffects.PCClone) >= 1) EngineCore.addButton(2, "Rebirth", SceneLib.camp.rebirthFromBadEnd).hint("You can move your nascent soul into your body clone achieving rebirth.");
            //addButton(3, "NewGamePlus", charCreation.newGamePlus).hint("Start a new game with your equipment, experience, and gems carried over.");
            if (CoC.instance.flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 || CoC.instance.debug) EngineCore.addButton(4, "Debug Cheat", debugCheatBadEnd);
            gameOverMenuOverride();
        }
        CoC.instance.inCombat = false;
		DungeonAbstractContent.inDungeon = false;
		if (CoC.instance.player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
			if (CoC.instance.flags[kFLAGS.NEISA_FOLLOWER] == 3) CoC.instance.flags[kFLAGS.PLAYER_COMPANION_1] = "";
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
    private static function debugCheatBadEnd():void {
        badEnded = false;
        playerMenu();
    }

    public static function goNext(needNext:Boolean):Boolean {
        Utils.Begin("eventParser", "goNext");
        var x:Boolean = goNextWrapped(needNext);
        Utils.End("eventParser", "goNext");
        return x;
    }

    private static function goNextWrapped(needNext:Boolean):Boolean {
        var player:Player = CoC.instance.player;
        //clearOutput();
        if (timeAwareLargeLastEntry >= 0 && (!DungeonAbstractContent.inDungeon && !SceneLib.explorationEngine.isActive)) {
            //Finish calling timeChangeLarge before advancing the hour again
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
        var time:Number = CoC.instance.timeQ;
        while (CoC.instance.timeQ > 0 || CoC.instance.timeQmin > 0) {
            // Advance minutes, but only 1 hour at a time
            if (CoC.instance.timeQmin >= 60) {
                CoC.instance.model.time.minutes += 60;
                CoC.instance.timeQmin -= 60;
            } else {
                CoC.instance.model.time.minutes += CoC.instance.timeQmin;
                CoC.instance.timeQmin = 0;
            }
            if (CoC.instance.model.time.minutes >= 60) {
                CoC.instance.model.time.minutes -= 60;
                CoC.instance.timeQ++;
            }
            if (CoC.instance.timeQ <= 0) {
                // There were minutes scheduled, but they didn't result in hour change.
                break;
            }
            CoC.instance.timeQ--;
            CoC.instance.model.time.hours++;
            var HPPercent:Number;
            HPPercent = player.HP/player.maxHP();
            player.statStore.advanceTime(Buff.RATE_HOURS,1);
            player.HP = HPPercent*player.maxHP();
            if (player.statStore.recentlyRemovedTags["IzumiSmoke"]) {
                EngineCore.outputText("\n<b>You groan softly as your thoughts begin to clear somewhat. It looks like the effects of Izumi's pipe smoke have worn off.</b>\n");
            }
            if (player.statStore.recentlyRemovedTags["AndysSmoke"]) {
                EngineCore.outputText("\n<b>You groan softly as your body begins to feels less sluggish and mind less sharp. It looks like the effects of Andy's pipe smoke have worn off.</b>\n");
            }
            if (player.statStore.recentlyRemovedTags["DrunkenPowerEmpower"]) {
                EngineCore.outputText("\nYou sober up, loosing the benefits of your oni drunken rampage.\n");
            }
            if (player.statStore.recentlyRemovedTags["Hangover"]) {
                EngineCore.outputText("\nYour head finally clears as your hangover wears off. Drinking with the shemale lizard was definitely a bad idea.\n");
            }
            if (player.statStore.recentlyRemovedTags["Feeding Euphoria"]) {
                EngineCore.outputText("\nThe change in your body agility prowess confirms that the effects of cum must have worn off.\n");
            }
            player.HP = HPPercent*player.maxHP();
            SceneLib.combat.regeneration1(false);
            if (player.hasPerk(PerkLib.JobSoulCultivator)) SceneLib.combat.soulforceregeneration1(false);
            if (player.hasPerk(PerkLib.JobSorcerer) || player.hasPerk(PerkLib.JobElementalConjurer)) SceneLib.combat.manaregeneration1(false);
            SceneLib.combat.wrathregeneration1(false);
			SceneLib.combat.fatigueRecovery1(false);
			SceneLib.combat.venomCombatRecharge1(false);
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
                HPPercent = player.HP/player.maxHP();
                player.statStore.advanceTime(Buff.RATE_DAYS,1);
                player.HP = HPPercent*player.maxHP();
                if (player.statStore.recentlyRemovedTags["KitsuneShrine"]){
                    EngineCore.outputText("\nYou feel like you should meditate again at the kitsune shrine as the serenity and peace you have recently aquired has waned.\n");
                }
                if (player.statStore.recentlyRemovedTags["WellFed"]){
                    EngineCore.outputText("\nYou begin feeling hungry again as the satisfaction of your last cooked meal has all but disapeared.\n");
                }
                if (player.statStore.recentlyRemovedTags["TaothBlessing"] || player.statStore.recentlyRemovedTags["FenrirBlessing"]){
                    EngineCore.outputText("\nThe divine blessing starts to fade. You think it’s high time you go back to the temple and pray.\n");
                }
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
            for (timeAwareLargeLastEntry = 0; timeAwareLargeLastEntry < _timeAwareClassList.length && !DungeonAbstractContent.inDungeon; timeAwareLargeLastEntry++) {
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

            if (!DungeonAbstractContent.inDungeon) {
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
        }

        // Hanging the Uma massage update here, I think it should work...
        SceneLib.telAdre.umasShop.updateBonusDuration(time);
        if (player.hasStatusEffect(StatusEffects.UmasMassage)) {
            trace("Uma's massage bonus time remaining: " + player.statusEffectv3(StatusEffects.UmasMassage));
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
        //Remove tail ornament if no demonic tail
        if (player.miscJewelry1 == CoC.instance.miscjewelries.DMAGETO && player.tailType != Tail.DEMONIC) {
            EngineCore.outputText("<b>\nSince you don't have a demonic tail anymore, your beautiful ornament becomes useless.</b>\n");
            SceneLib.inventory.takeItem(player.unequipMiscJewelry1(false,true), playerMenu);
            return true;
        }
        if (player.miscJewelry2 == CoC.instance.miscjewelries.DMAGETO && player.tailType != Tail.DEMONIC) {
            EngineCore.outputText("<b>\nSince you don't have a demonic tail anymore, your beautiful ornament becomes useless.</b>\n");
            SceneLib.inventory.takeItem(player.unequipMiscJewelry2(false,true), playerMenu);
            return true;
        }
        //Drop Excalibur / beautiful sword / beautiful staff / beautiful fly-whisk if corrupted!
        if ((player.weapon == CoC.instance.weapons.EXCALIB || player.weapon == CoC.instance.weapons.B_SWORD || player.weapon == CoC.instance.weapons.B_STAFF || player.weapon == CoC.instance.weapons.B_FLYWHISK) && player.cor >= 33 + player.corruptionTolerance) {
            EngineCore.outputText("<b>\nThe <u>[weapon]</u> grows hot in your hand, until you are forced to drop it.  Whatever power inhabits this weapon appears to be unhappy with you.  Touching it gingerly, you realize it is no longer hot, but as soon as you go to grab the hilt, it nearly burns you.\n\nYou realize you won't be able to use it right now, but you could probably keep it in your inventory.</b>\n\n");
            SceneLib.inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
            return true;
        }
        if ((player.weapon == CoC.instance.weapons.DEXCALI || player.weapon == CoC.instance.weapons.DBSWORD) && player.cor >= 33 + player.corruptionTolerance) {
            EngineCore.outputText("<b>\nThe <u>[weapon]</u> grows hot in your hand, until you are forced to drop them.  Whatever power inhabits those weapons appears to be unhappy with you.  Touching them gingerly, you realize they are no longer hot, but as soon as you go to grab the hilts, they nearly burns you.\n\nYou realize you won't be able to use them right now, but you could probably keep them in your inventory.</b>\n\n");
            SceneLib.inventory.takeItem(player.setWeapon(WeaponLib.FISTS), playerMenu);
            return true;
        }
        //Drop beautiful bow if corrupted!
        if (player.weaponRange == CoC.instance.weaponsrange.BEA_BOW && player.cor >= 33 + player.corruptionTolerance) {
            EngineCore.outputText("<b>\nThe <u>[weaponrange]</u> grows hot in your hand, until you are forced to drop it.  Whatever power inhabits this range weapon appears to be unhappy with you.  Touching it gingerly, you realize it is no longer hot, but as soon as you go to grab the riser, it nearly burns you.\n\nYou realize you won't be able to use it right now, but you could probably keep it in your inventory.</b>\n\n");
            SceneLib.inventory.takeItem(player.unequipWeaponRange(), playerMenu);
            return true;
        }
        //Drop beautiful shield if corrupted!
        if (player.shield == CoC.instance.shields.BSHIELD && player.cor >= 33 + player.corruptionTolerance) {
            EngineCore.outputText("<b>\nThe <u>[shield]</u> grows hot in your hand, until you are forced to drop it.  Whatever power inhabits this shield appears to be unhappy with you.  Touching it gingerly, you realize it is no longer hot, but as soon as you go to grab the enarmes, it nearly burns you.\n\nYou realize you won't be able to use it right now, but you could probably keep it in your inventory.</b>\n\n");
            SceneLib.inventory.takeItem(player.unequipShield(), playerMenu);
            return true;
        }
        //Drop scarred blade if not corrupted enough!
        if (player.weapon == CoC.instance.weapons.SCARBLD && player.cor < 66 - player.corruptionTolerance) {
            SceneLib.sheilaScene.rebellingScarredBlade();
            return true;
        }
        if (CoC.instance.flags[kFLAGS.SCARRED_BLADE_STATUS] == 1 && player.cor >= 70) {
            SceneLib.sheilaScene.findScarredBlade();
            return true;
        }
        //Unequip Lusty maiden armor
        if (player.armor is LustyMaidensArmor || player.armor is SuccubusArmor || player.armor is BattleMaidenArmor) {
            //Removal due to no longer fitting:
            //Grew Cock or Balls
            if ((player.hasCock() && !player.hasSheath()) || player.hasBalls()) {
                EngineCore.outputText("\nYou fidget uncomfortably in the g-string of your lewd bikini - there simply isn't enough room for your ");
                if (player.hasCock()) EngineCore.outputText("maleness");
                else EngineCore.outputText("bulgy balls");
                EngineCore.outputText(" within the imprisoning leather, and it actually hurts to wear it.  <b>You'll have to find some other form of protection!</b>\n\n");
                SceneLib.inventory.takeItem(player.unequipArmor(), playerMenu);
                return true;
            }
            //Lost pussy
            else if (!player.hasVagina()) {
                EngineCore.outputText("\nYou fidget uncomfortably as the crease in the gusset of your lewd bikini digs into your sensitive, featureless loins.  There's simply no way you can continue to wear this outfit in comfort - it was expressly designed to press in on the female mons, and without a vagina, <b>you simply can't wear this exotic armor.</b>\n\n");
                SceneLib.inventory.takeItem(player.unequipArmor(), playerMenu);
                return true;
            }
            //Tits gone or too small
            else if (player.biggestTitSize() < 4) {
                EngineCore.outputText("\nThe fine chain that makes up your lewd bikini-top is dangling slack against your flattened chest.  Every movement and step sends it jangling noisily, slapping up against your [nipples], uncomfortably cold after being separated from your " + player.skinFurScales() + " for so long.  <b>There's no two ways about it - you'll need to find something else to wear.</b>\n\n");
                SceneLib.inventory.takeItem(player.unequipArmor(), playerMenu);
                return true;
            }
        }
        //Unequip undergarment if you have bizarre lower body.
        if (!player.lowerGarment.isNothing && LowerBody.lowerGarmentDisabled(player)) {
            EngineCore.outputText("You feel something slipping off as if by magic. Looking down on the ground, you realize it's your [lowergarment]. Looking down at your lower body, you let out a sigh and pick up your [lowergarment]. ");
            SceneLib.inventory.takeItem(player.unequipUnderBottom(false, true), playerMenu);
            return true;
        }
        //Unequip shield if you're wielding a large weapon.
        if (((player.weaponSpecials("Large") && !player.hasPerk(PerkLib.GigantGrip) && !player.hasPerk(PerkLib.AntyDexterity)) || (player.weaponSpecials("Dual") && !player.hasPerk(PerkLib.AntyDexterity)) || player.weaponSpecials("Dual Large") || player.weapon == CoC.instance.weapons.DAISHO) && !player.shield.isNothing) {
            EngineCore.outputText("Your current weapon requires the use of two hands. As such, your shield has been unequipped automatically. ");
            SceneLib.inventory.takeItem(player.unequipShield(), playerMenu);
            return true;
        }
        // update cock type as dog/fox depending on whether the player resembles one more then the other.
        // Previously used to be computed directly in cockNoun, but refactoring prevents access to the Player class when in cockNoun now.
        if (player.cockTotal() != 0) {
            var counter:Number = player.cockTotal() - 1;
            while (counter >= 0) {
                if (player.cocks[counter].cockType == CockTypesEnum.DOG || player.cocks[counter].cockType == CockTypesEnum.FOX) {
                    if (player.racialScore(Races.DOG) >= player.racialScore(Races.FOX)) {
                        player.cocks[counter].cockType = CockTypesEnum.DOG;
                        Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.DOG));
                    }
                    else {
                        player.cocks[counter].cockType = CockTypesEnum.FOX;
                        Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.FOX));
                    }                }
                counter--;
                // trace("IMA LOOPIN", counter);
            }

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
                EngineCore.outputText("Oops, looks like something went wrong with the coding regarding gathering eggs after pregnancy. Hopefully this should never happen again. If you encounter this again, please let Ormael/Aimozg know so he can fix it.");
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

            var sEgg:ItemType;

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
        var player:Player = CoC.instance.player;
        var flags:DefaultDict = CoC.instance.flags;

        if (player.hasPerk(PerkLib.Diapause)) {
            if (flags[kFLAGS.DIAPAUSE_FLUID_STORE] <= 0 || !player.isPregnant() && !player.isButtPregnant()) //no pregnancy, I guess?
                return 0;
            //unique checks for diapause
            if (flags[kFLAGS.DIAPAUSE_DISPLAYED] == 1) {
                flags[kFLAGS.DIAPAUSE_DISPLAYED] = 0;
                EngineCore.outputText("\n\nYour body reacts to the influx of nutrition, accelerating your pregnancy. Your belly bulges outward slightly.");
                needNext = true;
            }
            flags[kFLAGS.DIAPAUSE_FLUID_STORE]--;
            if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
            if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
        }
        //checks not depending on diapause
        if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
        //DOUBLE PREGGERS SPEED
        if (player.hasPerk(PerkLib.MaraesGiftFertility)) {
            if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
        }
        //DOUBLE PREGGERS SPEED
        if (player.hasPerk(PerkLib.MagicalFertility)) {
            if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
        }
        if (player.hasPerk(PerkLib.FerasBoonBreedingBitch)) {
            if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
        }
        if (player.hasPerk(PerkLib.FerasBoonWideOpen) || player.hasPerk(PerkLib.FerasBoonMilkingTwat)) {
            if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
        }
        //DOUBLE PREGGERS SPEED
        if (player.hasPerk(PerkLib.BroodMother)) {
            if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
        }
        if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
            flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
            return 2;
        }
        return needNext ? 1 : 0;
    }

    private static function impGangBangProgress():int {
        //IMP GANGBAAAAANGA
        //The more imps you create, the more often you get gangraped.
        var player:Player = CoC.instance.player;
        var chance:Number = player.statusEffectv1(StatusEffects.BirthedImps) * 2;
        if (chance > 7) chance = 7;
        if (player.hasPerk(PerkLib.PiercedLethite)) chance += 4;
        if (player.inHeat) chance += 2;
        if (SceneLib.vapula.vapulaSlave()) chance += 7;
        //Reduce chance
        var flags:DefaultDict = CoC.instance.flags;
        if (flags[kFLAGS.CAMP_WALL_PROGRESS] > 0) chance /= 1 + (flags[kFLAGS.CAMP_WALL_PROGRESS] / 100);
        if (flags[kFLAGS.CAMP_WALL_GATE] > 0) chance /= 2;
        if (flags[kFLAGS.CAMP_WALL_SKULLS] > 0) chance *= 1 - (flags[kFLAGS.CAMP_WALL_SKULLS] / 100);
        if (CoC.instance.model.time.hours == 2) {
            if (CoC.instance.model.time.days % 30 == 0 && flags[kFLAGS.ANEMONE_KID] > 0 && player.hasCock() && flags[kFLAGS.ANEMONE_WATCH] > 0 && flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 40) {
                SceneLib.kidAScene.goblinNightAnemone();
                return 1;
            } else if (chance > Utils.rand(100) && !player.hasStatusEffect(StatusEffects.DefenseCanopy)) {
                if (player.gender > 0 && (!player.hasStatusEffect(StatusEffects.JojoNightWatch) || !player.hasStatusEffect(StatusEffects.PureCampJojo)) && (flags[kFLAGS.HEL_GUARDING] == 0 || !SceneLib.helFollower.followerHel()) && !player.hasStatusEffect(StatusEffects.HeliaOff) && flags[kFLAGS.ANEMONE_WATCH] == 0 && (flags[kFLAGS.HOLLI_DEFENSE_ON] == 0 || flags[kFLAGS.FUCK_FLOWER_KILLED] > 0) && (flags[kFLAGS.KIHA_CAMP_WATCH] == 0 || !SceneLib.kihaFollower.followerKiha()) && EtnaDaughterScene.EtnaDaughterGuardingCamp != 2 && SceneLib.midokaScene.MidokaGuardingCamp != 2 &&
                        !(SceneLib.camp.sleepInCabin() && (player.inte / 5 >= Utils.rand(15) || player.lust < 0.8 * player.maxLust() || CoC.instance.gameSettings.sceneHunter_inst.other)) && !flags[kFLAGS.IN_INGNAM] || flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 2) {
                    SceneLib.impScene.impGangabangaEXPLOSIONS();
                    EngineCore.doNext(playerMenu);
                    return 2;
                }
                else if (flags[kFLAGS.KIHA_CAMP_WATCH] > 0 && SceneLib.kihaFollower.followerKiha()) {
                    EngineCore.outputText("\n<b>You find charred imp carcasses all around the camp once you wake.  It looks like Kiha repelled a swarm of the little bastards.</b>\n");
                    return 1;
                }
                else if (flags[kFLAGS.HEL_GUARDING] > 0 && SceneLib.helFollower.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff)) {
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
                else if (ZenjiScenes.ZenjiNightWatch == 1) {
                    EngineCore.outputText("\n<b>Zenji informs you that he managed to fend off creatures that tried to assault you during the night.</b>\n");
                    return 1;
                }
                else if (EtnaDaughterScene.EtnaDaughterGuardingCamp == 2) {
                    EngineCore.outputText("\n<b>A group of imps tried to attack that night but you heard their screams in the distance as [etnakidname] laughed and made a feast out of them.</b>\n");
                    return 1;
                }
                else if (SceneLib.camp.sleepInCabin() && player.inte / 5 >= Utils.rand(15) && player.lust < 0.8 * player.maxLust()) { //lust condition: horny - less smart!
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
                if (player.hasCock() && (!player.hasStatusEffect(StatusEffects.JojoNightWatch) || !player.hasStatusEffect(StatusEffects.PureCampJojo)) && (flags[kFLAGS.HEL_GUARDING] == 0 || !SceneLib.helFollower.followerHel()) && !player.hasStatusEffect(StatusEffects.HeliaOff) && flags[kFLAGS.ANEMONE_WATCH] == 0 && (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && flags[kFLAGS.SLEEP_WITH] == "")) {
                    SceneLib.mountain.wormsScene.nightTimeInfestation();
                    return 2;
                }
                else if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && flags[kFLAGS.SLEEP_WITH] == "") {
                    EngineCore.outputText("\n<b>You hear the sound of a horde of worms banging against the door. Good thing you locked it before you went to sleep!</b>\n");
                    return 1;
                }
                else if (flags[kFLAGS.HEL_GUARDING] > 0 && SceneLib.helFollower.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff)) {
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
        var minutesToPass:Number = (time - Math.floor(time)) * 60;
        minutesToPass = Math.round(minutesToPass);
        CoC.instance.model.time.minutes += minutesToPass;
        if (CoC.instance.model.time.minutes > 59) {
            CoC.instance.timeQ++;
            CoC.instance.model.time.minutes -= 60;
            if (!EngineCore.buttonIsVisible(0)) goNext(needNext);
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
    /**
     * Advance time by `time` minutes. If overflows into next hour, delay this until next EngineCode.goNext call
     * @param time
     */
	public static function advanceMinutes(time:Number):void {
        // Ex. minutes = 45, time = 20, overflow = 6
        var overflow:Number = (CoC.instance.model.time.minutes + time) - 59;
        if (overflow > 0) {
            CoC.instance.timeQmin += overflow;
            time -= overflow;
        }
        CoC.instance.model.time.minutes += time;
		SceneLib.combat.regeneration(time);
		if (CoC.instance.player.hasPerk(PerkLib.JobSoulCultivator)) SceneLib.combat.soulforceregeneration(time);
		if (CoC.instance.player.hasPerk(PerkLib.JobSorcerer) || CoC.instance.player.hasPerk(PerkLib.JobElementalConjurer)) SceneLib.combat.manaregeneration(time);
		SceneLib.combat.wrathregeneration(time);
		SceneLib.combat.fatigueRecovery(time);
		SceneLib.combat.venomCombatRecharge(time);
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
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 3 && currentLength < 3) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 6 && currentLength < 6) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairType == Hair.GORGON && player.hairLength >= 6 && currentLength < 6) {
            EngineCore.outputText("\n<b>Your gorgon's hair growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 10 && currentLength < 10) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairType == Hair.GORGON && player.hairLength >= 10 && currentLength < 10) {
            EngineCore.outputText("\n<b>Your gorgon's hair growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 16 && currentLength < 16) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairType == Hair.GORGON && player.hairLength >= 16 && currentLength < 16) {
            EngineCore.outputText("\n<b>Your gorgon's hair growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 26 && currentLength < 26) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairType == Hair.GORGON && player.hairLength >= 26 && currentLength < 26) {
            EngineCore.outputText("\n<b>Your gorgon's hair growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 40 && currentLength < 40) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairType == Hair.GORGON && player.hairLength >= 40 && currentLength < 40) {
            EngineCore.outputText("\n<b>Your gorgon's hair growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairLength >= 40 && player.hairLength >= player.tallness && currentLength < player.tallness) {
            EngineCore.outputText("\n<b>Your hair's growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.hairType == Hair.GORGON && player.hairLength >= 40 && player.hairLength >= player.tallness && currentLength < player.tallness) {
            EngineCore.outputText("\n<b>Your gorgon's hair growth has reached a new threshold, giving you " + Appearance.hairDescription(player) + ".\n</b>");
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
            EngineCore.outputText("\n<b>Your beard's growth has reached a new threshold, giving you " + Appearance.beardDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.beardLength >= 0.5 && tempBeard < 0.5) {
            EngineCore.outputText("\n<b>Your beard's growth has reached a new threshold, giving you " + Appearance.beardDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.beardLength >= 1.5 && tempBeard < 1.5) {
            EngineCore.outputText("\n<b>Your beard's growth has reached a new threshold, giving you " + Appearance.beardDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.beardLength >= 3 && tempBeard < 3) {
            EngineCore.outputText("\n<b>Your beard's growth has reached a new threshold, giving you " + Appearance.beardDescription(player) + ".\n</b>");
            return true;
        }
        else if (player.beardLength >= 6 && tempBeard < 6) {
            EngineCore.outputText("\n<b>Your beard's growth has reached a new threshold, giving you " + Appearance.beardDescription(player) + ".\n</b>");
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
        if(_campSet){throw new Error("Multiple Docamp Inits");}
        _doCamp = value;
        _campSet = true;
    }
}
}
