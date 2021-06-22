/*
 CoC Main File - This is what loads when the game begins. If you want
import classes.EngineCore;to start understanding the structure of CoC,
 this is the place to start.
 First, we import all the classes from many different files across the codebase. It would be wise not t
import classes.Scenes.NPCs.JojoScene;o alter the
 order of th
import classes.Scenes.SceneLib;ese imports until more is known about what needs to load and when.
*/

package classes
{
// BREAKING ALL THE RULES.
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Items.*;
import classes.Parser.Parser;
import classes.Scenes.*;
import classes.Scenes.NPCs.JojoScene;
import classes.Transformations.TransformationLib;
import classes.display.DebugInfo;
import classes.display.PerkMenu;
import classes.display.SpriteDb;

import coc.model.GameModel;
import coc.model.TimeModel;
import coc.view.CoCButton;
import coc.view.MainView;
import coc.xxc.Story;
import coc.xxc.StoryCompiler;
import coc.xxc.StoryContext;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.*;
import flash.net.registerClassAlias;
import flash.text.TextFormat;
import flash.utils.setTimeout;

import mx.logging.Log;
import mx.logging.LogEventLevel;
import mx.logging.targets.TraceTarget;

/****
 classes.CoC: The Document class of Corruption of the Champions.
 ****/

    // This class instantiates the game. If you create a new place/location/scene you'll likely have to add it into here.
    // Add in descriptions for the include statements. Many of the description text code is inside of these.
    // Suggest moving or removing old comments referencing things that aren't needed anymore.

[SWF( width="1420", height="800", pageTitle="Corruption of Champions", backgroundColor="#000000")]

public class CoC extends MovieClip
{
    {
        /*
         * This is a static initializer block, used as an ugly hack to setup
         * logging before any of the class variables are initialized.
         * This is done because they could log messages during construction.
         */

        CoC.setUpLogging();
    }
    private static var _instance:CoC;
    public static function get instance():CoC{
        return _instance;
    }
    //System time
    public var date:Date = new Date();

    //Mod save version.
    public var modSaveVersion:Number = 32;
    public var levelCap:Number = 185;

    //Used to restrict random drops from overlapping uniques
    public var plotFight:Boolean = false;
    public var timeQ:Number = 0;
    //FIXME @OXDECEPTION Move above vars to more appropriate classes if possible

    /*private static var doCamp:Function; //Set by campInitialize, should only be called by playerMenu
    private static function campInitialize(passDoCamp:Function):void { doCamp = passDoCamp; }*/

    public var charCreation:CharCreation           = new CharCreation();
    public var saves:Saves                         = new Saves(gameStateDirectGet, gameStateDirectSet);
    public var playerAppearance:PlayerAppearance   = new PlayerAppearance();
    // Libraries
    public var mutations:Mutations                 = new Mutations();
    public var transformations:TransformationLib   = new TransformationLib();
    // Items/
    public var consumables:ConsumableLib           = new ConsumableLib();
    public var useables:UseableLib;
    public var weapons:WeaponLib                   = new WeaponLib();
    public var weaponsrange:WeaponRangeLib         = new WeaponRangeLib();
    public var weaponsflyingswords:FlyingSwordsLib = new FlyingSwordsLib();
    public var armors:ArmorLib                     = new ArmorLib();
    public var undergarments:UndergarmentLib       = new UndergarmentLib();
    public var miscjewelries:MiscJewelryLib        = new MiscJewelryLib();
    public var headjewelries:HeadJewelryLib        = new HeadJewelryLib();
    public var necklaces:NecklaceLib               = new NecklaceLib();
    public var jewelries:JewelryLib                = new JewelryLib();
    public var shields:ShieldLib                   = new ShieldLib();
    public var vehicles:VehiclesLib                = new VehiclesLib();


    // Force updates in Pepper Flash ahuehue
    private var _updateHack:Sprite = new Sprite();

    public var mainViewManager:MainViewManager = new MainViewManager();
    public var mainMenu:MainMenu = new MainMenu();
    public var perkMenu:PerkMenu = new PerkMenu();
    public var playerInfo:PlayerInfo = new PlayerInfo();
    public var debugInfoMenu:DebugInfo = new DebugInfo();
    public var gameSettings:GameSettings = new GameSettings();
    public var rootStory:Story = new Story("story",null,"root",true);
    public var compiler:StoryCompiler = new StoryCompiler("content/").attach(rootStory);
    public var context:StoryContext;

    public var perkTree:PerkTree = new PerkTree();

    /****
     This is used purely for bodges while we get things cleaned up.
     Hopefully, anything you stick to this object can be removed eventually.
     I only used it because for some reason the Flash compiler wasn't seeing
     certain functions, even though they were in the same scope as the
     function calling them.
     ****/
//Looks like this dangerous little var is no longer used anywhere, huzzah.		public var semiglobalReferencer :* = {};

    public var mainView :MainView;

    public var model :GameModel;

    // ALL THE VARIABLES:
    // Declare the various global variables as class variables.
    // Note that they're set up in the constructor, not here.
    public var debug:Boolean;
    public var ver:String;
    public var version:String;
    public var versionID:uint = 0;
    public var permObjVersionID:uint = 0;
    public var images:ImageManager;
    public var player:Player;
    public var player2:Player;
    public var monster:Monster;
    public var flags:DefaultDict;
    public var achievements:DefaultDict;
    private var _gameState:int;
    public var time :TimeModel;
    public var textHistory:Array;
    public var currentText:String;
    public var oldStats:*; // I *think* this is a generic object
    public var inputManager:InputManager;
    public var monkey:ChaosMonkey;
    public var testingBlockExiting:Boolean;

    public var kFLAGS_REF:*;
    public var kACHIEVEMENTS_REF:*;

    public function get inCombat():Boolean { return _gameState == 1; }

    public function set inCombat(value:Boolean):void { _gameState = (value ? 1 : 0); }

    public function resetGameState():void {
        _gameState = 3;
    }
    private function gameStateDirectGet():int { return _gameState; }

    private function gameStateDirectSet(value:int):void { _gameState = value; }

    private static function setUpLogging():void {
        var traceTarget:TraceTarget = new TraceTarget();

        traceTarget.level = LogEventLevel.WARN;

        CONFIG::debug
        {
            traceTarget.level = LogEventLevel.DEBUG;
        }

        //Add date, time, category, and log level to the output
        traceTarget.includeDate = true;
        traceTarget.includeTime = true;
        traceTarget.includeCategory = true;
        traceTarget.includeLevel = true;

        // let the logging begin!
        Log.addTarget(traceTarget);
    }

    public function CoC()
    {
        // Cheatmode.
        _instance = this;
        context = new StoryContext(this);

        useables = new UseableLib();

        this.kFLAGS_REF = kFLAGS;
        this.kACHIEVEMENTS_REF = kACHIEVEMENTS;
        // cheat for the parser to be able to find kFLAGS
        // If you're not the parser, DON'T USE THIS

        // This is a flag used to prevent the game from exiting when running under the automated tester
        // (the chaos monkey)
        testingBlockExiting = false;

        // Used for stopping chaos monkey on syntax errors. Separate flag so we can make stopping optional
        CoC_Settings.haltOnErrors = false;

        this.model = new GameModel();
        this.mainView = new MainView(/*this.model*/);
        this.mainView.name = "mainView";
        this.mainView.addEventListener("addedToStage",_postInit);
        this.stage.addChild( this.mainView );
    }
    private function _postInit(e:Event):void {
        // Hooking things to MainView.
        this.mainView.onNewGameClick = charCreation.newGameGo;
        this.mainView.onAppearanceClick = playerAppearance.appearance;
        this.mainView.onDataClick = saves.saveLoad;
        this.mainView.onLevelClick = playerInfo.levelUpGo;
        this.mainView.onPerksClick = perkMenu.displayPerks;
        this.mainView.onStatsClick = playerInfo.displayStats;
        this.mainView.onBottomButtonClick = function(i:int):void {
            textHistory.push("<br>["+EngineCore.button(i).labelText+"]<br>");
        };
        CoCButton.clickErrorHandler = function(error:Error, button:CoCButton):void {
            trace(error.getStackTrace());
            EngineCore.addButton(0, "Rescue", EventParser.playerMenu);
            mainView.mainText.htmlText +=
                    "\n----\nError in scene: "+error.message+"\n"+error.getStackTrace()+"\n----\n";
        }

        // Set up all the messy global stuff:

        // ******************************************************************************************

        var mainView :MainView = this.mainView;
        var model :GameModel = this.model;


        /**
         * Global Variables used across the whole game. I hope to whittle it down slowly.
         */

        /**
         * System Variables
         * Debug, Version, etc
         */
        //{ region SystemVariables

        //DEBUG, used all over the place
        debug = false;
        //model.debug = debug; // TODO: Set on model?

			//Version NUMBER
			ver = "1.0.2_mod_Xianxia_0.8s";
			version = ver + " (<b></b>)";

        this.images = new ImageManager(stage, mainView);
        this.inputManager = new InputManager(stage, mainView, false);
        new ControlBindings().run(inputManager);

        this.monkey = new ChaosMonkey(this);

        //} endregion

        /**
         * Player specific variables
         * The player object and variables associated with the player
         */
        //{ region PlayerVariables

			//The Player object, used everywhere
			//player = new Player();
			model.player = player;
			player2 = new Player();
			new PlayerEvents();

        //Used in perk selection, mainly eventParser, input and engineCore
        //tempPerk = null;

        //Create monster, used all over the place
        monster = new Monster();
        //} endregion

        /**
         * State Variables
         * They hold all the information about item states, menu states, game states, etc
         */
        //{ region StateVariables


        //The extreme flag state array. This needs to go. Holds information about everything, whether it be certain attacks for NPCs
        //or state information to do with the game.
        flags = new DefaultDict();

        achievements = new DefaultDict();

        ///Used everywhere to establish what the current game state is
        // Key system variables
        //0 = normal
        //1 = in combat
        //2 = in combat in grapple
        //3 = at start or game over screen
        _gameState = 0;

        //} endregion

        /**
         * Display Variables
         * Variables that hold display information like number of days and all the current displayed text
         */
        //{ region DisplayVariables

        //Holds the date and time display in the bottom left
        time = new TimeModel();
        model.time = time;

        //The string holds all the "story" text, mainly used in engineCore
        currentText = "";
        textHistory = [];
        //}endregion


        // These are toggled between by the [home] key.
        mainView.textBGWhite.visible = false;
        mainView.textBGTan.visible = false;

        // *************************************************************************************

        //Used for stat tracking to keep up/down arrows correct.
        oldStats = {};
        model.oldStats = oldStats;
        oldStats.oldStr  = 0;
        oldStats.oldTou  = 0;
        oldStats.oldSpe  = 0;
        oldStats.oldInte = 0;
        oldStats.oldSens = 0;
        oldStats.oldLib  = 0;
        oldStats.oldCor  = 0;
        oldStats.oldHP   = 0;
        oldStats.oldLust = 0;
        oldStats.oldFatigue = 0;
        oldStats.oldSoulforce = 0;
        oldStats.oldHunger = 0;

        // ******************************************************************************************

        //mainView._getButtonToolTipText = getButtonToolTipText;


        //Register the classes we need to be able to serialize and reconstitute so
        // they'll get reconstituted into the correct class when deserialized
        registerClassAlias("AssClass", AssClass);
        registerClassAlias("Character", Character);
        registerClassAlias("Cock", Cock);
        registerClassAlias("CockTypesEnum", CockTypesEnum);
        registerClassAlias("Enum", Enum);
        registerClassAlias("Creature", Creature);
        registerClassAlias("ItemSlotClass", ItemSlotClass);
        registerClassAlias("KeyItemClass", KeyItemClass);
        registerClassAlias("Monster", Monster);
        registerClassAlias("Player", Player);
        registerClassAlias("StatusEffectClass", StatusEffectClass);
        registerClassAlias("VaginaClass", VaginaClass);
        //registerClassAlias("Enum", Enum);

        //Hide sprites
        mainView.hideSprite();
        //Hide up/down arrows
        mainView.statsView.hideUpDown();
        new Story("lib",rootStory,"monsters",true);
        execPostInit();
        loadStory();
        this.addFrameScript( 0, this.run );
        //setTimeout(this.run,0);
    }

    private function loadStory():void {
        compiler.includeFile("coc.xml", true);
    }

    public function run():void
    {
        mainMenu.mainMenu();
        this.stop();

        if (_updateHack) {
            _updateHack.name = "wtf";
            _updateHack.graphics.beginFill(0xFF0000, 1);
            _updateHack.graphics.drawRect(0, 0, 2, 2);
            _updateHack.graphics.endFill();

            stage.addChild(_updateHack);
            _updateHack.x = 999;
            _updateHack.y = 799;
        }
    }

    public function forceUpdate():void
    {
        _updateHack.x = 999;
        _updateHack.addEventListener(Event.ENTER_FRAME, moveHackUpdate);
    }

    public function moveHackUpdate(e:Event):void
    {
        _updateHack.x -= 84;

        if (_updateHack.x < 0)
        {
            _updateHack.x = 0;
            _updateHack.removeEventListener(Event.ENTER_FRAME, moveHackUpdate);
        }
    }

    public function spriteSelect(choice:Object = 0):void {
        // Inlined call from lib/src/coc/view/MainView.as
        // TODO: When flags goes away, if it goes away, replace this with the appropriate settings thing.
        if (choice <= 0 || choice == null || flags[kFLAGS.SHOW_SPRITES_FLAG] == 1) {
            mainViewManager.hideSprite();
        } else {
            if (choice is Class) {
                mainViewManager.showSpriteBitmap(SpriteDb.bitmapData(choice as Class));
            } else if (choice is Number) {
                mainViewManager.showSpriteBitmap(SpriteDb.bitmapDataFromIndex(int(choice)));
            } else {
                mainViewManager.hideSprite();
            }
        }
    }

    public function outputHistory():void {
        mainView.hideTestInputPanel();
        EngineCore.clearOutputTextOnly();
        var txt:String = textHistory.join("<br>");
        textHistory = [];
        EngineCore.rawOutputText(txt);
        // On the next animation frame
        setTimeout(function():void {
            mainView.scrollBar.scrollPosition = mainView.scrollBar.maxScrollPosition;
        },0);
    }
    /*
    public static function main(container:DisplayObjectContainer):void {
//			MainView._layout = layout;

        container.addChild(new CoC(container.stage).mainView);
        /!*var e:DisplayObjectContainer = main.parent;
         while (e && !e.stage) e = e.parent;
         new CoC(e?e.stage:null);*!/
    }
    */
    public static const STAT_GAIN_CLASSIC:int = 0;
    public function flushOutputTextToGUI():void
    {
        var fmt:TextFormat = mainView.mainText.defaultTextFormat;

        if (flags[kFLAGS.CUSTOM_FONT_SIZE] != 0) fmt.size = flags[kFLAGS.CUSTOM_FONT_SIZE];
        fmt.color                           = mainViewManager.darkThemeImpl() ? 0xffffff : 0;
        mainView.mainText.defaultTextFormat = fmt;
        mainView.setOutputText(currentText);
    }
    /**
     * Places combobox after the visible text.
     */
    public function placeComboBoxAfterText():void {
        flushOutputTextToGUI();
        mainView.placeComboBox(mainView.mainText.x+10, mainView.mainText.y+mainView.mainText.textHeight+10);
        EngineCore.outputText("\n\n\n");
    }
    public function showComboBox(items:Array,prompt:String,onChange:Function):void {
        mainView.showComboBox(items,prompt,onChange);
        placeComboBoxAfterText();
    }
    private static var initQueue:/*Function*/Array      = [];
    public static function onGameInit(f:Function):void {
        initQueue.push(f);
    }
    private static function execPostInit():void {
        var f:Function;
        while ((f = initQueue.shift())) f();
    }

    public function get gameState():int {
        return _gameState;
    }
}
}
