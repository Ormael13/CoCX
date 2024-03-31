/**
 * Quest Dungeon: The Ebon Labyrinth (for Alvina Black Rose Quest)
 * @author Liadri, reworked by Svalkash
 */
package classes.Scenes.Dungeons
{
import classes.EventParser;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Races;
import classes.Scenes.Areas.BlightRidge.Incubus;
import classes.Scenes.Areas.BlightRidge.Omnibus;
import classes.Scenes.Areas.BlightRidge.Succubus;
import classes.Scenes.Areas.Caves.DarkSlime;
import classes.Scenes.Areas.Caves.DisplacerBeast;
import classes.Scenes.Areas.Forest.TentacleBeast;
import classes.Scenes.Areas.Mountain.Minotaur;
import classes.Scenes.Dungeons.EbonLabyrinth.*;
import classes.Scenes.NPCs.CelessScene;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.display.SpriteDb;

public class EbonLabyrinth extends DungeonAbstractContent {
    //FLAGS:
    //EBON_LABYRINTH: 0 - not discovered, 1 - discovered, 50 / 150 / 300 / 150*x - AWARDED levels
    //EBON_LABYRINTH_RECORD — max reached level. Used for achievements or unlocking waypoints.

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

    //Fountain tracker. When fountain is found, but legendaries are not used, you can take them and use it again.
    public var fountainRoom:Boolean = false;
    public var fountainCorrupt:Boolean = false;

    //Scene instances
    public var chaosChimeraScene:ChaosChimeraScene = new ChaosChimeraScene();
    public var mindbreakerScene:MindbreakerScene = new MindbreakerScene();

    public var darkSlimeEmpressScene:DarkSlimeEmpressScene = new DarkSlimeEmpressScene();
    public var hydraScene:HydraScene = new HydraScene();
    public var hellfireSnailScene:HellfireSnailScene = new HellfireSnailScene();
    public var eyeTyrantScene:EyeTyrantScene = new EyeTyrantScene();
    public var atlachNachaScene:AtlachNachaScene = new AtlachNachaScene();
    public var livingFailureScene:LivingFailureScene = new LivingFailureScene();
    public var draculinaScene:DraculinaScene = new DraculinaScene();

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
            [5, livingFailureScene.encounter],
			[6, draculinaScene.encounter]
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
        outputText("-Woe to whom seeketh the black rose. Thy who enter beware, while riches you may find, death lurks in the Labyrinth's deepest reaches. It ever hungers.- how charming. The ruin of an old campfire is all that's left of the previous adventurers to come here.\n\n");
        outputText("<b>You found the Ebon Labyrinth.</b>\n\n");
        explorer.stopExploring();
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
        fountainRoom = false;
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
        addButtonIfTrue(0, "Sleep", doSleepEL, "It's still too early to go to sleep.",
                isNightTime,  "Turn yourself in for the night. May result in monster ambush!");
        SceneLib.masturbation.masturButton(5);
		if (room == 1) addButtonIfTrue(7, "Cat", shortcuts, "You not even beaten ANY boss yet.", flags[kFLAGS.EBON_LABYRINTH_RECORD] >= 50, "Talk to the cat only if you plan skip some rooms.");
        addButton(9, "Inventory", inventory.inventoryMenu);
        addButton(14, "Exit", confirmExit);
        dungeons.setTopButtons();
    }

    private function confirmExit():void {
        clearOutput();
        outputText("<b>Are you sure about that?</b>");
        doYesNo(exitDungeon, playerMenu);
    }
	
	public function shortcuts():void {
		statScreenRefresh();
        hideUpDown();
        spriteSelect(null);
		outputText("\n\nYou are facing a cat-morph. She would looks quite averange if not for black stripes on purple fur. Without any sound she points behind her and then vanishing.");
        menu();
		addButton(0, "50", navigateToRoomEL050).hint("Skip 50 rooms but beware of the boss at the end of this detour.");
		addButtonIfTrue(1, "100", navigateToRoomEL100, "You not even beaten 2 bosses yet.", flags[kFLAGS.EBON_LABYRINTH_RECORD] >= 100, "Skip 100 rooms but beware of the boss at the end of this detour.");
		addButtonIfTrue(2, "150", navigateToRoomEL150, "You not even beaten 3 bosses yet.", flags[kFLAGS.EBON_LABYRINTH_RECORD] >= 150, "Skip 150 rooms but beware of the boss at the end of this detour.");
		addButtonIfTrue(3, "200", navigateToRoomEL200, "You not even beaten 4 bosses yet.", flags[kFLAGS.EBON_LABYRINTH_RECORD] >= 200, "Skip 200 rooms but beware of the boss at the end of this detour.");
		addButtonIfTrue(4, "250", navigateToRoomEL250, "You not even beaten 5 bosses yet.", flags[kFLAGS.EBON_LABYRINTH_RECORD] >= 250, "Skip 250 rooms but beware of the boss at the end of this detour.");
		addButtonIfTrue(5, "300", navigateToRoomEL300, "You not even beaten 6 bosses yet.", flags[kFLAGS.EBON_LABYRINTH_RECORD] >= 300, "Skip 300 rooms but beware of the boss at the end of this detour.");
		addButtonIfTrue(6, "350", navigateToRoomEL350, "You not even beaten 7 bosses yet.", flags[kFLAGS.EBON_LABYRINTH_RECORD] >= 350, "Skip 350 rooms but beware of the boss at the end of this detour.");
	}

    //Player menu. Doesn't start any encounters.
    //Can print stuff is called with 'true' and new direction.
    public function roomStatic(move:Boolean = false, newDir:int = DIR_DOWN):void {
        clearOutput();
        //check achievements and highscore - so we can remove it from other places
        highScore();
        //text
        outputText("<b><u>Corridor</u></b>\n");
        if (!move) {//called from player menu
            outputText("The room seems to be void of monsters so far.");
            if (fountainRoom) outputText("\nThe fountain stands in the center of the room, shining with its " + (fountainCorrupt ? "unholy" : "holy") + " water.");
        }
        else { //called from 'navigate'
            if (newDir == DIR_UP)
                outputText("You climb back to the upper floor. The corridor seems to be void of monsters so far.");
            else if (newDir == DIR_DOWN)
                outputText("You descend deeper underground. The corridor seems to be void of monsters so far.");
            else if (direction == DIR_UP || direction == DIR_DOWN || newDir == direction) //going forward
                outputText("You walk into an empty corridor. Thankfully, it seems to be void of monsters so far.");
            else
                outputText("You turn the corner wandering into a new corridor, which, thankfully, seems to be void of monsters so far.");
            //save the direction we're going to
            direction = newDir;
        }
        //if (new) direction is UP/DOWN, notify the player about monsters
        if (direction == DIR_DOWN)
            outputText("\n\n<b>You have a strange feeling that monsters here will be stronger than before. Maybe it's not too late to come back?</b>");
        else if (direction == DIR_UP)
            outputText("\n\n<b>The air here is cleaner. You hope that the monsters won't be too much of a problem anymore.</b>");
        outputText("\n\nRooms explored: " + room);
        outputText("\n\nCurrent depth : " + depth);
        setDungeonButtonsEL();
        //unique buttons
        if (fountainRoom) addButton(10, "Fountain", encountersUpgradeFountain, true);
    }

    //Navigation function. Increments the counter and checks the encounters.
    public function navigateToRoomEL(newDir:int):void {
        //clear room-specific
        fountainRoom = false;
        //move
        ++room;
        advanceMinutes(15);
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
        goNext(false);
    }
	public function navigateToRoomEL050():void {
		//clear room-specific
        fountainRoom = false;
        navigateToXRoom(50);
	}
	public function navigateToRoomEL100():void {
		//clear room-specific
        fountainRoom = false;
        navigateToXRoom(100);
	}
	public function navigateToRoomEL150():void {
		//clear room-specific
        fountainRoom = false;
        navigateToXRoom(150);
	}
	public function navigateToRoomEL200():void {
		//clear room-specific
        fountainRoom = false;
        navigateToXRoom(200);
	}
	public function navigateToRoomEL250():void {
		//clear room-specific
        fountainRoom = false;
        navigateToXRoom(250);
	}
	public function navigateToRoomEL300():void {
		//clear room-specific
        fountainRoom = false;
        navigateToXRoom(300);
	}
	public function navigateToRoomEL350():void {
		//clear room-specific
        fountainRoom = false;
        navigateToXRoom(350);
	}
	private function navigateToXRoom(rooms:Number = 50):void {
		//move
        room += rooms;
		resetEncChance();
        bossSelector(0);
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
                case 350:
                    awardAchievement("We need to go deeper!", kACHIEVEMENTS.DUNGEON_WE_NEED_TO_GO_DEEPER);
                    break;
            }
            //award checking
            if (dungeons.checkEbonLabyrinthNotAwarded())
                outputText("<b>New awards are available in 'Questlog' menu!</b>\n\n");
            //cleared message
            //check if unlocked
            if (room == dungeons.clearRoomEL()) { //first time room 351
                outputText("\n\nYou notice the familiar patterns in the corridors. Seems like you won't be able to find anything special down there. Or will you? The corridor slowly but inevitably leads you deeper underground, and the monsters slowly become stronger there. You're sure you'll still encounter big ones sometimes, no matter if you're looking forward to it or not. Focusing your attention, you can even hear the faint sounds of water far ahead - could it be that the fountain you just stumbled upon wasn't the only one in the labyrinth?");
                outputText("\n\nInvestigating your surroundings, you notice a small ladder leading down. You're sure the room below is still a part of the labyrinth, but loud noices warn you that that part is much deeper. The ladder is durable though - you can always return back up... unless you descend even deeper through these intertwined corridors.");
                outputText("\n\n<b>Labyrinth is (semi-)cleared. Endless mode unlocked!</b>");
            }
        }
    }

    //Sleep. Calls enemy encounter with 50% chance
    public function doSleepEL():void {
        clearOutput();
        if (rand(2) == 0) {
            advanceMinutes(15);
            outputText("You ready your bedroll and go to sleep, keen on continuing your exploration tomorrow. Sadly as you prepare to lay down, a creature from the labyrinth stumbles upon your makeshift camp and you are forced to defend yourself.\n");
            enemySelector(false);
            return;
        }
        camp.cheatSleepUntilMorning(); //Let's not overcomplicate it, okay?
        doNext(playerMenu);
    }

    //==================================================================================================
    //Encounters
    //==================================================================================================

    //encounter selector. Returns true if started something, false if nothing (to fall back to 'static' room)
    public function selectEncounter():Boolean {
        //Every 50 levels - boss
        if (room % 50 == 0) {
            resetEncChance();/*
            //if not completed - select from tiers
            if (!dungeons.checkEbonLabyrinthClear())
                bossSelector(room <= 150 ? 1 : 2);
            else//cleared - anything, but avoid making tier2 bosses too weak
                bossSelector(enemyLevelMod < 3 ? 1 : 0);*/
			bossSelector(0);
            return true;
        }
        //Every 10 rooms (not boss) - chest
        else if (room % 10 == 0) {
            incEncChance();
            encountersLootChest();
            return true;
        }
        //Special encounters
        //Room 49 - Alvina's quest chimera
        else if (room >= 49 && flags[kFLAGS.ALVINA_FOLLOWER] == 17) {
            chaosChimeraScene.encounter();
            return true;
        }
        //Room 295 - Rathazul's joke fountain
        else if (room >= 295 && player.hasStatusEffect(StatusEffects.RathazulAprilFool) && player.statusEffectv3(StatusEffects.RathazulAprilFool) == 0) {
            incEncChance();
            encountersFountainOfPurity();
            return true;
        }
        //Rooms AFTER boss, difficulty > 300 (max level).
        else if (enemyLevelMod >= 6 && room > 50 && room % 50 == 1) {
            incEncChance();
            fountainRoom = true;
            fountainCorrupt = rand(2) == 0;
            encountersUpgradeFountain();
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

    private function encountersUpgradeFountain(repeat:Boolean = false):void {
        clearOutput();
        if (!repeat)
            outputText("While exploring the labyrinth you run into a strange fountain, which radiates " + (fountainCorrupt ? "black" : "white") + " magic like you have never seen before, the water flowing with gittering " + (fountainCorrupt ? "purple corruption" : "starlight") + ". Dipping an object and some additional materials into the font could have... unforeseen consequences.\n\n");
        outputText("You can use the fountain's magic to " + (fountainCorrupt ? "corrupt" : "bless") + " specific gear, making a legendary item using radiant shards and gems.");
        menu();
        addButton(0, "Dip Item", CelessScene.itemImproveMenu, 1, fountainCorrupt);
        addButton(4, "Back", playerMenu);
    }

    private function encountersFountainOfPurity():void {
        player.addStatusValue(StatusEffects.RathazulAprilFool, 3, 1);
        clearOutput();
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
        var choices:Array = [displacerEL, darkSlimeEL, succubusEL, incubusEL, amogusEL, tentabeastEL, minotaurEL, mindbreakerEL];
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
        camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_DISPLACER_BEAST);
        startCombat(new DisplacerBeast(), true);
    }
    private function darkSlimeEL(print:Boolean = true):void {
        if (player.isRace(Races.SLIME, 1, false) || player.isRace(Races.MAGMASLIME, 1, false) || player.isRace(Races.DARKSLIME, 1, false)) {
            if (!print) {
                minotaurEL(false); //replace - slime won't attack another slime
                return;
            }
            spriteSelect(SpriteDb.s_darkgoogirlsprite);
            clearOutput();
            outputText("You take the turn at the end of the corridor and run right into a dark slime. For a few second both of you consider each other before the slime shrugs and simply asks.\n\n");
            outputText("\"<i>No luck finding fluids that way?</i>\"");
            outputText("You didn’t find any and if you did you would have pumped it out until it ran dry.\n\n");
            outputText("\"<i>Well darn, if you spot a fleshling do share!</i>\"");
            outputText("Well that was easy… you can only guess slimes don’t get much out of other slimes’ bodies. You proceed deeper into the labyrinth unhindered, though, you wish you indeed had found someone to milk the fluids off.\n\n");
            doNext(playerMenu);
        }
        else {
            spriteSelect(SpriteDb.s_darkgoogirlsprite);
            if (print) {
                clearOutput();
                outputText("As you wander into a new corridor, you come face to face with a purplish jelly-like woman. She giggles upon spotting you, her small, sphere-shaped core emitting an ominous light as she surges toward you with a gooey smile.\n\n");
                outputText("\"<i>Dinner is served! Your fluids are mine, so surrender them now intruder and I promise to make it very pleasurable for you!</i>\"");
            }
            startCombat(new DarkSlime(), true);
        }
    }
    private function succubusEL(print:Boolean = true):void {
        if (print) {
            clearOutput();
            outputText("You run right into a demon. The fiend look at you confused, then attacks with glee.");
            camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_SUCCUBUS);
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
            outputText("Just as you turn the corner, you come face to face with a towering minotaur armed with a pair of huge battleaxes and equipped with a full plate armor. The beast smirks as his cock hardens in anticipation. It must’ve been months since he last fucked something!");
        }
        startCombat(new Minotaur(), true);
    }
    private function mindbreakerEL(print:Boolean = true):void {
        if (print) {
            clearOutput();
            mindbreakerScene.encounter();
        }
        startCombat(new MindbreakerFemale(), true);
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
        outputText("Defeated you fall to the ground and look up just in time to see a mace coming for your head. When you wake up, you're standing on a podium somewhere else. There's demon everywhere around you screaming numbers. Those demons are brandishing gems around for some reasons.\n\n");
        outputText("\"<i>One hundred did I hear one hundred for this " + (player.gender == 3 ? "herm" : player.gender == 1 ? "man" : "woman") + "? One hundred one?!</i>\"\n\n");
        outputText("You realise what's going on now, they're actually auctioning you at the slave market! You try and break free but your bonds are too tight. Eventually you're sold to an Omnibus who just so happen to be collecting human pets. As time passes she eventually sells you to a new master and then you're sold again to another. It never ends. ");
        outputText("Guess you will spend the rest of your life in bondage pleasing some demon until it gets bored and sell you off. Maybe, if your lucky, one will fuck you hard enough that you will cum your soul out and you will actualy get to enjoy rather than loath your slave status.\n\n");
        EventParser.gameOver();
    }
}
}
