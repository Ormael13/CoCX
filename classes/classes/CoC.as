/* 
 CoC Main File - This is what loads when the game begins. If you want to start understanding the structure of CoC,
 this is the place to start.
 First, we import all the classes from many different files across the codebase. It would be wise not to alter the
 order of these imports until more is known about what needs to load and when.
*/

﻿package classes
{
	// BREAKING ALL THE RULES.
	import classes.GlobalFlags.kFLAGS; // This file contains most of the persistent gamestate flags.
	import classes.GlobalFlags.kGAMECLASS; // This file creates the gameclass that the game will run within.
	import classes.GlobalFlags.kACHIEVEMENTS; // This file creates the flags for the achievements system.
	import classes.Scenes.Combat.Combat;
	import classes.Scenes.Dungeons.DungeonEngine; // This file creates all the dungeons, their rooms, and their completion states except for D3. This also includes cabin code. See file for more details.
	import classes.Scenes.Dungeons.D3.D3; // Likely due to D3's complexity, that dungeon is split out separately.
	import classes.Scenes.Seasonal.AprilFools;
	import classes.Scenes.Seasonal.Fera;
	import classes.Scenes.Seasonal.Thanksgiving;
	import classes.Scenes.Seasonal.Valentines;
	import classes.Scenes.Seasonal.XmasBase;

	import classes.CoC_Settings; // This file creates basic variables for CoC itself (debug flags, buffers, button manipulation)

/* 
One very important thing to know about descriptions in this game is that many words are based on hidden integer values. 
These integers are compared to tables or queried directly to get the words used for particular parts of descriptions. For instance,
AssClass below has variables for wetness, looseness, fullness, and virginity. You'll often find little tables like this
scattered through the code:
butt looseness
		0 - virgin
		1 - normal
		2 - loose
		3 - very loose
		4 - gaping
		5 - monstrous
Tracking down a full list of description variables, how their integer values translate to descriptions, and how to call them
would be a very useful task for anyone who wants to extend content using variables.
Further complicating this is that the code will also sometimes have a randomized list of words for certain things just to keep 
the text from being too boring.
*/

	import classes.AssClass; // Creates the class that holds ass-related variables as described above. 
	import classes.BreastRowClass; // Creates the class that holds breast-related variables.
	import classes.Items.*; // This pulls in all the files in the Items folder. Basically any inventory item in the game
	import classes.PerkLib; // This instantiates the IDs, names, and descriptions of perks. Does NOT have any code related to the actual perk! Use the ID field to search the code base for that. 

	import classes.Player; // Creates a player with all that entails. See file for more info. Also see Creature.as.
	import classes.Cock; // Creates the class that holds cock-related variables. Also has several functions for growing and shrinking cocks.
	import classes.Creature; // Creates basic information for all characters in CoC. Contains many descriptors.
	import classes.ItemSlotClass; // Creates item slots
	import classes.PerkClass; // The function in this file pulls perk information from PerkLib for later querying
	import classes.StatusEffectClass; // Similar to PerkClass, but for status effects in combat.
	import classes.VaginaClass; // Creates vaginas
	import classes.ImageManager; // Image voodoo for sprites
	import classes.internals.Utils; // This file contains much voodoo for randomizing item arrays and other useful functions.


	// This line not necessary, but added because I'm pedantic like that.
	import classes.InputManager;

	import classes.Parser.Parser; // Much text voodoo for how to make all the description/pronoun/etc replacement work.

// All the files below with Scenes loads the main content for the game.

	import classes.Scenes.*;
	import classes.Scenes.Areas.*;
	import classes.Scenes.Areas.Desert.*
	import classes.Scenes.Areas.Forest.*
	import classes.Scenes.Areas.HighMountains.*
	import classes.Scenes.Areas.Mountain.*
	import classes.Scenes.Areas.Swamp.*
	import classes.Scenes.Dungeons.DeepCave.*;
	import classes.Scenes.Dungeons.DesertCave.*;
	import classes.Scenes.Dungeons.Factory.*;
	import classes.Scenes.Dungeons.HelDungeon.*;
	import classes.Scenes.Explore.*;
	import classes.Scenes.Monsters.*;
	import classes.Scenes.NPCs.*;
	import classes.Scenes.Places.*;
	import classes.Scenes.Places.TelAdre.*;
	import classes.Scenes.Seasonal.*;
	import classes.Scenes.Quests.*;
	import coc.view.MainView; // Creates the framework for the game screen.
	import coc.model.GameModel; // Uncertain.
	import coc.model.TimeModel; // Various time-related functions for setting the game clock and querying its state.

	// Class based content? In my CoC?! It's more likely than you think!
	import classes.content.*;
	
	// All the imports below are for Flash.
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.*
	import flash.net.FileReference;
	import flash.net.navigateToURL;
	import flash.net.registerClassAlias;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.text.*;
	import flash.utils.ByteArray;
	import flash.system.Capabilities;
	import flash.display.Sprite;

	/****
		classes.CoC: The Document class of Corruption of the Champions.
	****/
	
	// This class instantiates the game. If you create a new place/location/scene you'll likely have to add it into here.
	// Add in descriptions for the include statements. Many of the description text code is inside of these.
	// Suggest moving or removing old comments referencing things that aren't needed anymore.
		
	[SWF( width="1000", height="800", pageTitle="Corruption of Champions" )]

	public class CoC extends MovieClip 
	{

		// Include the functions. ALL THE FUNCTIONS
//No longer needed. Added into CharCreation.as:		include "../../includes/customCharCreation.as";
		
//No longer needed:		include "../../includes/descriptors.as";
//No longer needed. Moved to PlayerAppearance.as:		include "../../includes/appearance.as";

//No longer needed:		include "../../includes/InitialiseUI.as";
		include "../../includes/input.as";
		include "../../includes/OnLoadVariables.as";
		include "../../includes/startUp.as";
		
//No longer needed. Split up into 3 files.		include "../../includes/combat.as";
		include "../../includes/debug.as";
//No longer needed. This file has been chopped up and spread throughout the codebase:		include "../../includes/doEvent.as";
		include "../../includes/eventParser.as";
//Merged into debug.as:		include "../../includes/eventTest.as";
		include "../../includes/engineCore.as";

		// Lots of constants
		include "../../includes/appearanceDefs.as";

		//Any classes that need to be made aware when the game is saved or loaded can add themselves to this array using saveAwareAdd.
		//	Once in the array they will be notified by Saves.as whenever the game needs them to write or read their data to the flags array.
		private static var _saveAwareClassList:Vector.<SaveAwareInterface> = new Vector.<SaveAwareInterface>();
	
		//Called by the saveGameObject function in Saves
		public static function saveAllAwareClasses(game:CoC):void { for (var sac:int = 0; sac < _saveAwareClassList.length ; sac++) _saveAwareClassList[sac].updateBeforeSave(game); }

		//Called by the loadGameObject function in Saves
		public static function loadAllAwareClasses(game:CoC):void { for (var sac:int = 0; sac < _saveAwareClassList.length ; sac++) _saveAwareClassList[sac].updateAfterLoad(game); }

		public static function saveAwareClassAdd(newEntry:SaveAwareInterface):void { _saveAwareClassList.push(newEntry); }
	
		//Any classes that need to be aware of the passage of time can add themselves to this array using timeAwareAdd.
		//	Once in the array they will be notified as each hour passes, allowing them to update actions, lactation, pregnancy, etc.
		private static var _timeAwareClassList:Vector.<TimeAwareInterface> = new Vector.<TimeAwareInterface>(); //Accessed by goNext function in eventParser
		private static var timeAwareLargeLastEntry:int = -1; //Used by the eventParser in calling timeAwareLarge
		private var playerEvent:PlayerEvents;
		
		public static function timeAwareClassAdd(newEntry:TimeAwareInterface):void { _timeAwareClassList.push(newEntry); }
		
		private static var doCamp:Function; //Set by campInitialize, should only be called by playerMenu
		private static function campInitialize(passDoCamp:Function):void { doCamp = passDoCamp; }
		
		// /
		private var _perkLib:PerkLib = new PerkLib();// to init the static
		private var _statusEffects:StatusEffects = new StatusEffects();// to init the static
		public var charCreation:CharCreation = new CharCreation();
		public var playerAppearance:PlayerAppearance = new PlayerAppearance();
		public var playerInfo:PlayerInfo = new PlayerInfo();
		public var saves:Saves = new Saves(gameStateDirectGet, gameStateDirectSet);
		// Items/
		public var mutations:Mutations = new Mutations();
		public var consumables:ConsumableLib = new ConsumableLib();
		public var useables:UseableLib;
		public var weapons:WeaponLib = new WeaponLib();
		public var armors:ArmorLib = new ArmorLib();
		public var undergarments:UndergarmentLib = new UndergarmentLib();
		public var jewelries:JewelryLib = new JewelryLib();
		public var shields:ShieldLib = new ShieldLib();
		public var miscItems:MiscItemLib = new MiscItemLib();
		// Scenes/
		public var camp:Camp = new Camp(campInitialize);
		public var dreams:Dreams = new Dreams();
		public var exploration:Exploration = new Exploration();
		public var followerInteractions:FollowerInteractions = new FollowerInteractions();
		public var inventory:Inventory = new Inventory(saves);
		public var masturbation:Masturbation = new Masturbation();
		public var pregnancyProgress:PregnancyProgression = new PregnancyProgression();
		// Scenes/Areas/
		public var bog:Bog = new Bog();
		public var desert:Desert = new Desert();
		public var forest:Forest = new Forest();
		public var glacialRift:GlacialRift = new GlacialRift();
		public var highMountains:HighMountains = new HighMountains();
		public var lake:Lake = new Lake();
		public var mountain:Mountain = new Mountain();
		public var plains:Plains = new Plains();
		public var swamp:Swamp = new Swamp();
		public var volcanicCrag:VolcanicCrag = new VolcanicCrag();
		// Scenes/Combat/
		public var combat:Combat = new Combat();
		// Scenes/Dungeons
		public var brigidScene:BrigidScene = new BrigidScene();
		public var d3:D3 = new D3();
		// Scenes/Explore/
		public var gargoyle:Gargoyle = new Gargoyle();
		public var lumi:Lumi = new Lumi();
		public var giacomoShop:Giacomo = new Giacomo();
		// Scenes/Monsters/
		public var goblinScene:GoblinScene = new GoblinScene();
		public var goblinAssassinScene:GoblinAssassinScene = new GoblinAssassinScene();
		public var goblinWarriorScene:GoblinWarriorScene = new GoblinWarriorScene();
		public var goblinShamanScene:GoblinShamanScene = new GoblinShamanScene();
		public var goblinElderScene:GoblinElderScene = new GoblinElderScene();
		public var impScene:ImpScene = new ImpScene();
		public var mimicScene:MimicScene = new MimicScene();
		public var succubusScene:SuccubusScene = new SuccubusScene();
		// Scenes/NPC/
		public var amilyScene:AmilyScene = new AmilyScene();
		public var anemoneScene:AnemoneScene = new AnemoneScene();
		public var arianScene:ArianScene = new ArianScene();
		public var ceraphScene:CeraphScene = new CeraphScene();
		public var ceraphFollowerScene:CeraphFollowerScene = new CeraphFollowerScene();
		public var emberScene:EmberScene = new EmberScene();
		public var exgartuan:Exgartuan = new Exgartuan();
		public var helFollower:HelFollower = new HelFollower();
		public var helScene:HelScene = new HelScene();
		public var helSpawnScene:HelSpawnScene = new HelSpawnScene();
		public var holliScene:HolliScene = new HolliScene();
		public var isabellaScene:IsabellaScene = new IsabellaScene();
		public var isabellaFollowerScene:IsabellaFollowerScene = new IsabellaFollowerScene();
		public var izmaScene:IzmaScene = new IzmaScene();
		public var jojoScene:JojoScene = new JojoScene();
		public var joyScene:JoyScene = new JoyScene();
		public var kihaFollower:KihaFollower = new KihaFollower();
		public var kihaScene:KihaScene = new KihaScene();
		public var latexGirl:LatexGirl = new LatexGirl();
		public var marbleScene:MarbleScene = new MarbleScene();
		public var marblePurification:MarblePurification = new MarblePurification();
		public var milkWaifu:MilkWaifu = new MilkWaifu();
		public var raphael:Raphael = new Raphael();
		public var rathazul:Rathazul = new Rathazul();
		public var sheilaScene:SheilaScene = new SheilaScene();
		public var shouldraFollower:ShouldraFollower = new ShouldraFollower();
		public var shouldraScene:ShouldraScene = new ShouldraScene();
		public var sophieBimbo:SophieBimbo = new SophieBimbo();
		public var sophieFollowerScene:SophieFollowerScene = new SophieFollowerScene();
		public var sophieScene:SophieScene = new SophieScene();
		public var urta:Urta = new Urta();
		public var urtaHeatRut:UrtaHeatRut = new UrtaHeatRut();
		public var urtaPregs:UrtaPregs = new UrtaPregs();
		public var valeria:Valeria = new Valeria();
		public var vapula:Vapula = new Vapula();
		// Scenes/Places/
		public var bazaar:Bazaar = new Bazaar();
		public var boat:Boat = new Boat();
		public var farm:Farm = new Farm();
		public var owca:Owca = new Owca();
		public var telAdre:TelAdre = new TelAdre();
		public var dungeons:DungeonEngine = new DungeonEngine();
		public var ingnam:Ingnam = new Ingnam();
		public var prison:Prison = new Prison();
		// Scenes/Seasonal/
		public var aprilFools:AprilFools = new AprilFools();
		public var fera:Fera = new Fera();
		public var thanksgiving:Thanksgiving = new Thanksgiving();
		public var valentines:Valentines = new Valentines();
		public var xmas:XmasBase = new XmasBase();
		// Scenes/Quests/
		public var urtaQuest:UrtaQuest = new UrtaQuest();
		
		public var debugMenu:DebugMenu = new DebugMenu();
		
		public var crafting:Crafting = new Crafting();
		
		// Force updates in Pepper Flash ahuehue
		private var _updateHack:Sprite = new Sprite();
		
		public var mainViewManager:MainViewManager = new MainViewManager();
		//Scenes in includes folder GONE! Huzzah!
		
		/****
			This is used purely for bodges while we get things cleaned up.
			Hopefully, anything you stick to this object can be removed eventually.
			I only used it because for some reason the Flash compiler wasn't seeing
			certain functions, even though they were in the same scope as the
			function calling them.
		****/

		public var mainView :MainView;

		public var model :GameModel;

		public var parser:Parser;

		// ALL THE VARIABLES:
		// Declare the various global variables as class variables.
		// Note that they're set up in the constructor, not here.
		public var debug:Boolean;
		public var ver:String;
		public var version:String;
		public var mobile:Boolean;
		public var images:ImageManager;
		public var player:Player;
		public var player2:Player;
		public var monster:Monster;
		public var flags:DefaultDict;
		public var achievements:DefaultDict;
		private var gameState:int;
		public var time :TimeModel;
		public var currentText:String;

		public var explored:Boolean;
		public var foundForest:Boolean;
		public var foundDesert:Boolean;
		public var foundMountain:Boolean;
		public var foundLake:Boolean;
		//These plot variables are to be replaced.
		public var whitney:Number;
		public var monk:Number;
		public var sand:Number;
		public var giacomo:int;

		public var temp:int;
		public var args:Array;
		public var funcs:Array;
		public var oldStats:*; // I *think* this is a generic object
		public var inputManager:InputManager;
		
		public var kFLAGS_REF:*;
		public var kACHIEVEMENTS_REF:*;
		
		public function get inCombat():Boolean { return gameState == 1; }
		
		public function set inCombat(value:Boolean):void { gameState = (value ? 1 : 0); }
		
		private function gameStateDirectGet():int { return gameState; }
		
		private function gameStateDirectSet(value:int):void { gameState = value; }
		
		public function rand(max:int):int
		{
			return Utils.rand(max);
		}

		public function CoC()
		{
			// Cheatmode.
			kGAMECLASS = this;
			
			useables = new UseableLib();
			
			this.kFLAGS_REF = kFLAGS; 
			this.kACHIEVEMENTS_REF = kACHIEVEMENTS; 
			// cheat for the parser to be able to find kFLAGS
			// If you're not the parser, DON'T USE THIS
			
			this.parser = new Parser(this, CoC_Settings);

			this.model = new GameModel();
			this.mainView = new MainView(/*this.model*/);
			this.mainView.name = "mainView";
			this.stage.addChild( this.mainView );

			// Hooking things to MainView.
			this.mainView.onNewGameClick = charCreation.newGameGo;
			this.mainView.onAppearanceClick = playerAppearance.appearance;
			this.mainView.onDataClick = saves.saveLoad;
			this.mainView.onLevelClick = playerInfo.levelUpGo;
			this.mainView.onPerksClick = playerInfo.displayPerks;
			this.mainView.onStatsClick = playerInfo.displayStats;

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
			ver = "1.0.2_mod_1.3.25";
			version = ver + " (<b>Ember Spar Intensifies</b>)";

			//Indicates if building for mobile?
			mobile = false;
			model.mobile = mobile;

			this.images = new ImageManager(stage);
			this.inputManager = new InputManager(stage, false);
			include "../../includes/ControlBindings.as";

			//} endregion

			/**
			 * Player specific variables
			 * The player object and variables associated with the player
			 */
			//{ region PlayerVariables

			//The Player object, used everywhere
			player = new Player();
			model.player = player;
			player2 = new Player();
			playerEvent = new PlayerEvents();

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

			//User all over the place whenever items come up
//No longer used:			itemSwapping = false;

			//The extreme flag state array. This needs to go. Holds information about everything, whether it be certain attacks for NPCs 
			//or state information to do with the game. 
			flags = new DefaultDict();
			//model.flags = flags;
			
			achievements = new DefaultDict();
			//model.achievements = achievements;

			///Used everywhere to establish what the current game state is
			// Key system variables
			//0 = normal
			//1 = in combat
			//2 = in combat in grapple
			//3 = at start or game over screen
			gameState = 0;

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
			//}endregion 

			/**
			 * Item variables
			 * Holds all the information about items in your inventory and stashes away
			 */
			//{region ItemVariables

			/**
			 * Plot Variables
			 * Booleans and numbers about whether you've found certain places
			 */
			//{ region PlotVariables

			//Plot variables
			explored = false;
			foundForest = false;
			foundDesert = false;
			foundMountain = false;
			foundLake = false;
			whitney = 0;
			monk = 0;
			sand = 0;
			giacomo = 0;
//Replaced by flag			beeProgress = 0;

//			itemStorage = [];
//			gearStorage = [];
			//}endregion


			// These are toggled between by the [home] key.
			mainView.textBGWhite.visible = false;
			mainView.textBGTan.visible = false;

			// *************************************************************************************

			// import flash.events.MouseEvent;

			//const DOUBLE_ATTACK_STYLE:int = 867;
			//const SPELLS_CAST:int = 868;

			//Fenoxo loves his temps
			temp = 0;

			//Used to set what each action buttons displays and does.
			args = [];
			funcs = [];

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
			oldStats.oldHunger = 0;
			
			//model.maxHP = maxHP;

			// ******************************************************************************************

			mainView.aCb.dataProvider = new DataProvider([{label:"TEMP",perk:new PerkClass(PerkLib.Acclimation)}]);
			mainView.aCb.addEventListener(Event.CHANGE, playerInfo.changeHandler); 
			 
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

			this.addFrameScript( 0, this.run );
		}

		public function run():void
		{
			mainMenu();
			this.stop();

			_updateHack.name = "wtf";
			_updateHack.graphics.beginFill(0xFF0000, 1);
			_updateHack.graphics.drawRect(0, 0, 2, 2);
			_updateHack.graphics.endFill();

			stage.addChild(_updateHack);
			_updateHack.x = 999;
			_updateHack.y = 799;
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
	}
}
