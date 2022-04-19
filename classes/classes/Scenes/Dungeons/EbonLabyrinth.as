/**
 * Quest Dungeon: The Ebon Labyrinth (for Alvina Black Rose Quest)
 * @author Liadri
 */
package classes.Scenes.Dungeons 
{
import classes.CockTypesEnum;
import classes.EventParser;
import classes.PerkLib;
import classes.Scenes.SceneLib;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Scenes.Areas.BlightRidge.Incubus;
import classes.Scenes.Areas.BlightRidge.Omnibus;
import classes.Scenes.Areas.BlightRidge.Succubus;
import classes.Scenes.Areas.Caves.DarkSlime;
import classes.Scenes.Areas.Caves.DisplacerBeast;
import classes.Scenes.Areas.Forest.TentacleBeast;
import classes.Scenes.Areas.Mountain.Minotaur;
import classes.Scenes.Dungeons.EbonLabyrinth.*;
import classes.StatusEffects;
import classes.display.SpriteDb;

public class EbonLabyrinth extends DungeonAbstractContent {
    //FLAGS:
    //EBON_LABYRINTH: 0 - not discovered, 1 - discovered, 50 / 150 / 300 / 150*x - AWARDED levels
    //EBON_LABYRINTH_RECORD — max reached level. Used for achievements only.

    //Current room number
    public var room:int = 1;

    //Minimum enemy level MODIFIER. Depends on the current room.
    // Enemies now scale evenly with the bosses. Otherwise, formulae would be messy.
    // Bosses are 5L stronger than regular enemies before them. This is intended.
    // It can be easily changed in constructors.
    // Here is level MODIFIERS. Starting from 0. They are read by constructors (from EL instance in DungeonEngine) to calculate levels and stats.
    public var depth:int = 0; //controlled by the player
    public function get enemyLevelMod():int { return int(room / 50) + depth; }

    //Encounter chance, base = 10. Increased each time for an empty room / boss, peaceful encounters, also after...defeats?
    // Reset after "peaceful" encounters (Atlach after TF), exit / bad-end,  after "regular" encounters.
    public var encChance:int = 10;
    public function resetEncChance():void { encChance = 10; }
    public function incEncChance():void { encChance += 10; }

    //Direction constants
    public static const DIR_NORTH   :int = 0;
    public static const DIR_WEST    :int = 1;
    public static const DIR_SOUTH   :int = 2;
    public static const DIR_EAST    :int = 3;
    public static const DIR_UP      :int = 4;
    public static const DIR_DOWN    :int = 5;
    //Current direction. Used only for the text
    public var direction:int  = DIR_NORTH;

    //Only one?
    //Cute scene?
    //Reuse flag?

    //Scene instances
    public var chaosChimeraScene:ChaosChimeraScene = new ChaosChimeraScene();

    public var darkSlimeEmpressScene:DarkSlimeEmpressScene = new DarkSlimeEmpressScene();
    public var hydraScene:HydraScene = new HydraScene();
    public var hellfireSnailScene:HellfireSnailScene = new HellfireSnailScene();

    public var eyeTyrantScene:EyeTyrantScene = new EyeTyrantScene();
    public var atlachNachaScene:AtlachNachaScene = new AtlachNachaScene();
    public var livingFailureScene:LivingFailureScene = new LivingFailureScene();

    /*
    //Boss tracker
    Boss tracker uses binary encoding. Every boss in the pool is assigned a number: Empress - 0, Hydra - 1, etc.
    Every bit is set to 1 after the boss is encountered, and the group is reset to 0 after it's full.
    This WILL break if any boss uses numbers longer than 32. You're warned.
    Possible solution - use Number instead? Or just another int.
    Alvina's thing is not in the pool - it's called explicitly
    */
    public var bossTracker:int  = 0;
    //containts the references... right?
    private var bossPool:Array;
    
    public function EbonLabyrinth() {
        //init boss arrays.
        bossPool = [];
        bossPool[1] = [
            [0, darkSlimeEmpressScene.encounter],
            [1, hydraScene.encounter],
            [2, hellfireSnailScene.encounter]
        ];
        bossPool[2] = [
            [3, eyeTyrantScene.encounter],
            [4, atlachNachaScene.encounter],
            [5, livingFailureScene.encounter]
        ];
        bossPool[0] = bossPool[1].concat(bossPool[2]);
    }

    //==================================================================================================
    //Menu and room methods
    //==================================================================================================

    //First encounter
    public function ebonlabyrinthdiscovery():void {
        flags[kFLAGS.EBON_LABYRINTH] = 1;
        clearOutput();
        outputText("You find the entrance to what appears to be a tunnel made of stone. This place looks man made as if carved by humanoid hands yet sports no decoration. Just empty linear corridors and corners dimly lit by magical torches. On a wall you find a sign reading ");
        outputText("-Woe to who seeketh the black rose. Thy who enter beware, while riches you may find, death lurks in the Labyrinth deepest reaches. It ever hungers.- how charming. The ruin of an old campfire is all that's left of the previous adventurers to come here.\n\n");
        outputText("<b>You found the Ebon Labyrinth.</b>\n\n");
        doNext(enterDungeon);
    }

    //Init - resets all flags
    public function enterDungeon():void {
        inDungeon = true;
        dungeonLoc = DUNGEON_EBON_LABYRINTH; //one 'room' for all directions. Make things simpler!
        direction = DIR_NORTH;
        //reset all
        room = 1;
        depth = 0;
        bossTracker = 0;
        playerMenu(); //calls checkRoom -> roomStatic
    }

    //removes inDungeon and prints the text
    public function exitDungeon():void {
        inDungeon = false;
        clearOutput();
        outputText("You leave the Ebon Labyrinth behind and take off back towards the camp.");
        doNext(camp.returnToCampUseOneHour);
    }

    public function setDungeonButtonsEL():void {
        statScreenRefresh();
        hideUpDown();
        spriteSelect(null);
        menu();
        addButton(2, "North",   navigateToRoomEL, DIR_NORTH);
        addButton(12,"South",   navigateToRoomEL, DIR_SOUTH);
        addButton(6, "West",    navigateToRoomEL, DIR_WEST);
        addButton(8, "East",    navigateToRoomEL, DIR_EAST);
        if (dungeons.checkEbonLabyrinthClear()) {
            if (depth > 0)
                addButton(1, "Up", navigateToRoomEL, DIR_UP).hint("Return to higher floor.");
            else
                addButtonDisabled(1, "Up", "Too late! Exit the dungeon, or descend deeper!");
            addButton(13, "Down", navigateToRoomEL, DIR_DOWN).hint("Descend even deeper. The monsters will be tougher, but you'll always be able to climb back.");
        }
        if (model.time.hours >= 21 || model.time.hours < 6) addButton(0, "Sleep", doSleepEL).hint("Turn yourself in for the night. May result in monster ambush!");
        else addButtonDisabled(0, "Sleep", "It's still too early to go to sleep.");
        if (player.lust >= 30) addButton(5, "Masturbate", SceneLib.masturbation.masturbateGo);
        else addButtonDisabled(5, "Masturbate", "Req. 30+ lust.");
        addButton(9, "Inventory", inventory.inventoryMenu);
        addButton(14, "Exit", confirmExit);
        dungeons.setTopButtons();
    }

    private function confirmExit():void {
        clearOutput();
        outputText("<b>Are you sure about that?</b>");
        doYesNo(exitDungeon, playerMenu);
    }
		
    //Player menu. Doesn't start any encounters.
    //Can print stuff is called with 'true' and new direction.
    public function roomStatic(move:Boolean = false, newDir:int = DIR_DOWN):void {
        clearOutput();
        //check achievements and highscore - so we can remove it from other places
        highScore();
        //text
        outputText("<b><u>Corridor</u></b>\n");
        if (!move) //called from player menu
            outputText("The corridor seems to be void of monsters so far.");
        else { //called from 'navigate'
            if (newDir == DIR_UP)
                outputText("You climb back to the upper floor. The corridor seems to be void of monsters so far.");
            else if (newDir == DIR_DOWN)
                outputText("You descend deeper underground. The corridor seems to be void of monsters so far.");
            else if (direction == DIR_UP || direction == DIR_DOWN || newDir == direction) //going forward
                outputText("You walk into an empty corridor. Thankfully, it seems to be void of monsters so far.");
            else
                outputText("You turn the corner wandering into a new corridor which, thankfully, seems to be void of monsters so far.");
            //save the direction we're going to
            direction = newDir;
        }
        //if (new) direction is UP/DOWN, notify the player about monsters
        if (direction == DIR_DOWN)
            outputText("\n\n<b>You have a strange feeling that monsters here will be stronger than before. Maybe it's not too late to come back?</b>");
        else if (direction == DIR_UP)
            outputText("\n\n<b>The air here is cleaner. You hope that the monsters won't be too much of a problem anymore.</b>");
        //check if unlocked
        if (room == dungeons.clearRoomEL()) {
            outputText("\n\nYou notice the familiar patterns in the corridors. Seems like there's nothing new to find here. Or not? The corridor slowly but inevitably leads you underground, and the monsters slowly become stronger.")
            outputText("\nInvestigating your surroundings, you notice a small ladder leading down. You're sure the room below is still a part of the labyrinth, but loud noices hint you that that part is much deeper. The ladder is durable though - you can always return back up... unless you go even deeper through these intertwined corridors.");
            outputText("\n\n<b>Labyrinth is (semi-)cleared. Endless mode unlocked!</b>");
        }
        outputText("\n\nRooms explored: " + room);
        outputText("\n\nCurrent depth : " + depth);
        setDungeonButtonsEL();
    }
	
    //Navigation function. Increments the counter and checks the encounters.
    public function navigateToRoomEL(newDir:int):void {
        ++room;
        eachMinuteCount(15);
        //modify enemy level
        if (newDir == DIR_DOWN)
            ++depth;
        else if (newDir == DIR_UP) //minLevel must be checked already
            --depth;
        //try to find the encounter
        if (selectEncounter()) {
            direction = newDir; //still save the direction.
            return;
        }
        //static otherwise
        roomStatic(true, newDir);
    }

    //if a new highscore is set, checks achievements
    public function highScore():void {
        if (flags[kFLAGS.EBON_LABYRINTH_RECORD] < room) {
            flags[kFLAGS.EBON_LABYRINTH_RECORD] = room;
            //achievements checking. Checks the flag only the
            switch(flags[kFLAGS.EBON_LABYRINTH_RECORD]) {
                case 50:
                    awardAchievement("Honorary Minotaur", kACHIEVEMENTS.DUNGEON_HONORARY_MINOTAUR);
                    break;
                case 100:
                    awardAchievement("Got lost?", kACHIEVEMENTS.DUNGEON_GOT_LOST);
                    break;
                case 150:
                    awardAchievement("Hug the left wall", kACHIEVEMENTS.DUNGEON_HUG_THE_LEFT_WALL);
                    break;
                case 200:
                    awardAchievement("Pan ain't got nothing on you", kACHIEVEMENTS.DUNGEON_PAN_AINT_GOT_NOTHING_ON_YOU);
                    break;
                case 250:
                    awardAchievement("Master of the labyrinth", kACHIEVEMENTS.DUNGEON_MASTER_OF_THE_LABYRINT);
                    break;
                case 300:
                    awardAchievement("Why are you here?", kACHIEVEMENTS.DUNGEON_WHY_ARE_YOU_HERE);
                    break;
            }
            //award checking
            if (dungeons.checkEbonLabyrinthNotAwarded())
                outputText("<b>New awards are available in 'Questlog' menu!</b>\n\n");
        }
    }

    //Sleep. Calls enemy encounter with 50% chance
    public function doSleepEL():void {
        clearOutput();
        if (rand(2) == 0) {
            eachMinuteCount(15);
            outputText("You ready your bedroll and go to sleep, keen on continuing your exploration tomorrow. Sadly as you prepare to lay down, a creature from the labyrinth stumbles upon your makeshift camp and you are forced to defend yourself.\n");
            enemySelector(false);
            return;
        }
        //normal sleep
        //FUCK, LEARN ARITHMETICS
        var timeQ:Number = 24 + 6 - model.time.hours;
        if (player.isGargoyle()) outputText("You sit on your pedestal, your body petrifying like stone as you go to sleep, keen on continuing your exploration tomorrow.\n");
        else if (player.isAlraune()) outputText("You lie down in your pitcher, dozing off for the night as you close off your petals to sleep.\n");
        else outputText("You ready your bedroll and go to sleep, keen on continuing your exploration tomorrow.\n");
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
        if (player.hasPerk(PerkLib.SpeedyRecovery)) fatRecovery += 5;
        if (player.hasPerk(PerkLib.SpeedyRecuperation)) fatRecovery += 10;
        if (player.hasPerk(PerkLib.SpeedyRejuvenation)) fatRecovery += 20;
        if (player.hasPerk(PerkLib.ControlledBreath)) fatRecovery *= 1.1;
        if (player.hasStatusEffect(StatusEffects.BathedInHotSpring)) fatRecovery *= 1.2;
        if (player.hasPerk(PerkLib.RecuperationSleep)) multiplier += 1;
        if (player.hasPerk(PerkLib.RejuvenationSleep)) multiplier += 2;
        if (flags[kFLAGS.HUNGER_ENABLED] > 0) {
            if (player.hunger < 25) {
                outputText("\nYou have difficulty sleeping as your stomach is growling loudly.\n");
                multiplier *= 0.5;
            }
        }
        //Marble withdrawl
        if(player.hasStatusEffect(StatusEffects.MarbleWithdrawl)) {
            outputText("\nYour sleep is very troubled, and you aren't able to settle down.  You get up feeling tired and unsatisfied, always thinking of Marble's milk.\n");
            multiplier *= 0.5;
            dynStats("tou", -.1, "int", -.1);
        }
        //Mino withdrawal
        else if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) {
            outputText("\nYou spend much of the night tossing and turning, aching for a taste of minotaur cum.\n");
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
        HPChange((timeQ * hpRecovery * multiplier), false);
        fatigue( -(timeQ * fatRecovery * multiplier));
        model.time.hours += timeQ;
        SceneLib.combat.regeneration1(false);
        if (player.hasPerk(PerkLib.JobSoulCultivator)) SceneLib.combat.soulforceregeneration1(false);
        if (player.hasPerk(PerkLib.JobSorcerer)) SceneLib.combat.manaregeneration1(false);
        SceneLib.combat.wrathregeneration1(false);
        SceneLib.combat.fatigueRecovery1(false);
        if (model.time.hours > 23) {
            model.time.hours -= 24;
            model.time.days++;
        }
        doNext(playerMenu);
    }

    //==================================================================================================
    //Encounters
    //==================================================================================================

    //encounter selector. Returns true if started something, false if nothing (to fall back to 'static' room)
    public function selectEncounter():Boolean {
        //Every 50 levels - boss
        if (room % 50 == 0) {
            resetEncChance();
            //if not completed - select from tiers
            if (!dungeons.checkEbonLabyrinthClear())
                bossSelector(room <= 150 ? 1 : 2);
            else//cleared - anything, but avoid making tier2 bosses too weak
                bossSelector(enemyLevelMod < 3 ? 1 : 0);
            return true;
        }
        //Every 10 rooms (not boss) - chest
        else if (room % 10 == 0) {
            incEncChance();
            encountersLootChest();
            return true;
        }
        //Special encounters
        else if (room >= 49 && flags[kFLAGS.ALVINA_FOLLOWER] == 17) {
            chaosChimeraScene.encounter();
            return true;
        }
        else if (room >= 295 && player.hasStatusEffect(StatusEffects.RathazulAprilFool) && player.statusEffectv3(StatusEffects.RathazulAprilFool) == 0) {
            incEncChance();
            encountersFountainOfPurity();
            return true;
        }
        //If passed - enemy
        else if (rand(100) < encChance) {
            resetEncChance();
            enemySelector();
            return true;
        }
        //Increase chance otherwise
        incEncChance();
        return false;
    }
	
    private function encountersFountainOfPurity():void {
        player.addStatusValue(StatusEffects.RathazulAprilFool, 3, 1);
        outputText("As you explore the labyrinth you stumble upon what appears to be a room with fountain of purity.\n\n");
        outputText("<b>You've collected a vial from the fountain of purity.</b> It's time to bring it back to Rathazul.\n\n");
        doNext(roomStatic);
    }

    private function encountersLootChest():void {
        clearOutput();
        //adjusting rewards to enemy level. Sounds fair to me
		var exp:int = int(2000 * Math.exp(0.2*enemyLevelMod));
		var gems:int = int(500 * Math.exp(0.2*enemyLevelMod));
        player.XP += exp;
        player.gems += gems;
        outputText("As you explore the labyrinth you stumble upon what appears to be a room filled with gems and a pillar upon which sits a single jewel. Grabbing the jewel, you see green mist swirl out of the stone then around you before entering your body. Memories not your own flash through your mind. ");
        outputText("Battles of the present and the past. You know you've learned from these battles and as you gather the gems and leave the room you do so with new enriching experiences. (+" + exp + " EXP, +" + gems + " gems)\n\n");
        doNext(roomStatic); //easier to implement.
    }

    //Selects the boss. Tier (1,2) selects the boss pool. 0 - includes ALL tiers
    private function bossSelector(tier:int = 0):void {
        //Make the pool of encounters
        var choices:Array = [];
        var boss:int;
        for (boss = 0; boss < bossPool[tier].length; ++boss) //[bit_num, function]
            if (!getBit(bossTracker, bossPool[tier][boss][0])) //if the bit is not set
                choices.push(boss); //save boss index
        //If the array is empty, clear tracker and restart.
        if (choices.length == 0) {
            //reset the bits AND add them to the array
            for (boss = 0; boss < bossPool[tier].length; ++boss) { //[bit_num, function]
                bossTracker = setBit(bossTracker, bossPool[tier][boss][0], false); //set the boss bit
                choices.push(boss);
            }
        }
        //Otherwise, select the boss and set the bit.
        boss = choices[rand(choices.length)]; //select boss index
        bossTracker = setBit(bossTracker, bossPool[tier][boss][0], true); //set the boss bit
        bossPool[tier][boss][1](); //call encounter function
    }

    //selects an enemy and starts the encounter
    //'print' argument disables printing (used for night ambushes)
    private function enemySelector(print:Boolean = true):void {
        var choices:Array = [displacerEL, darkSlimeEL, succubusEL, incubusEL, amogusEL, tentabeastEL, minotaurEL];
        choices[rand(choices.length)](print);
    }
    
    //==================================================================================================
    //Random enemy attacks (one-liners, not worth moving into classes)
    //==================================================================================================
    
    private function displacerEL(print:Boolean = true):void {
        
        if (print) {
            clearOutput();
            outputText("You turn around the corner and come face to face with a greyish six armed catgirl. She would be terrifying already even without the two tentacles on her back that writhe in excitation. Readying for battle is the best you can do as the beast woman charges you with a gleam of hunger in her feral eyes.");
        }
        if (flags[kFLAGS.CODEX_ENTRY_DISPLACER_BEAST] <= 0) {
            flags[kFLAGS.CODEX_ENTRY_DISPLACER_BEAST] = 1;
            outputText("\n\n<b>New codex entry unlocked: Displacer beast!</b>")
        }
        startCombat(new DisplacerBeast(), true);
    }
    private function darkSlimeEL(print:Boolean = true):void {
        if (player.gooScore() >= 11 || player.magmagooScore() >= 13 || player.darkgooScore() >= 13) {
            if (!print) {
                minotaurEL(false); //replace - slime won't attack another slime
                return;
            }
            spriteSelect(SpriteDb.s_darkgoogirlsprite_16bit);
            clearOutput();
            outputText("You take the turn at the end of the corridor and run right into a dark slime. For a few second the both of you consider each other before the slime shrugs and simply asks.\n\n");
            outputText("\"<i>No luck finding fluids that way?</i>\"");
            outputText("You didn’t find any and if you did you would have pumped it out until it ran dry.\n\n");
            outputText("\"<i>Well darn, if you spot a fleshling do share!</i>\"");
            outputText("Well that was easy… you can only guess slimes don’t get much out of other slimes’ bodies. You proceed deeper into the labyrinth unhindered, though, you wish you indeed had found someone to milk the fluids off.\n\n");
        }
        else {
            spriteSelect(SpriteDb.s_darkgoogirlsprite_16bit);
            if (print) {
                clearOutput();
                outputText("As you wander into a new corridor you come face to face with a purplish jelly-like woman. She giggles upon spotting you, her small, sphere-shaped core emitting an ominous light as she surges toward you with a gooey smile.\n\n");
                outputText("\"<i>Dinner is served! Your fluids are mine, so surrender them now intruder and I promise to make it very pleasurable for you!</i>\"");
            }
            startCombat(new DarkSlime(), true);
        }
    }
    private function succubusEL(print:Boolean = true):void {
        if (print) {
            clearOutput();
            outputText("You run right into a demon. The fiend look at you confused, then attacks with glee.");
            if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
                flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
                outputText("\n\n<b>New codex entry unlocked: Succubus!</b>")
            }
        }
        startCombat(new Succubus(), true);
    }
    private function incubusEL(print:Boolean = true):void {
        if (print) {
            clearOutput();
            outputText("You run right into a demon. The fiend look at you confused, then attacks with glee.");
        }
        startCombat(new Incubus(), true);
    }
    private function amogusEL(print:Boolean = true):void {
        if (print) {
            clearOutput();
            outputText("You run right into a demon. The fiend look at you confused, then attacks with glee.");
        }
        startCombat(new Omnibus(), true);
    }
    private function tentabeastEL(print:Boolean = true):void {
        if (print) {
            clearOutput();
            outputText("You’ve barely walked yourself into the corridor when you spot a tentacle beast of absurd size rushing right at you, it looks hungry!");
        }
        startCombat(new TentacleBeast(), true);
    }
    private function minotaurEL(print:Boolean = true):void {
        if (print) {
            clearOutput();
            outputText("Just as you turn the corner, you come face to face with a towering minotaur armed with a pair of huge battle axes and equipped with a full plate armor. The beast smirks as his cock hardens in anticipation. It must’ve been months since he last fucked something!");
        }
        startCombat(new Minotaur(), true);
    }

    //==================================================================================================
    //Shit
    //==================================================================================================
	
    //rework this to SceneLib, please
    public function defeatedByStrayDemon():void {
        clearOutput();//succubus, incibus or omnibus
        if (player.isAlraune()) {
            SceneLib.uniqueSexScene.AlrauneDungeonBadEnd();
            return;
        }
        outputText("Defeated you fall to the ground and look up just in time to see a mace coming for your head. When you wake up you're standing on a podium somewhere else. There's demon everywhere around you screaming numbers. Those demons are brandishing gems around for some reasons.\n\n");
        outputText("\"<i>One hundred did I hear one hundred for this " + (player.gender == 3 ? "herm" : player.gender == 1 ? "man" : "woman") + "? One hundred one?!</i>\"\n\n");
        outputText("You realise what's going on now, they're actually auctioning you at the slave market! You try and break free but your bonds are to tight. Eventually you're sold to an Omnibus who just so happen to be collecting human pets. As time passes she eventually sells you to a new master and then you're sold again to another. It never ends. ");
        outputText("Guess you will spend the rest of your life in bondage pleasing some demon until it gets bored and sell you off. Maybe, if your lucky, one will fuck you hard enough that you will cum your soul out and you will actualy get to enjoy rather then loath your slave status.\n\n");
        EventParser.gameOver();
    }
}
}