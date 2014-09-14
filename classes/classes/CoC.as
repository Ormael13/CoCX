package classes
{
	// BREAKING ALL THE RULES.
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	import classes.CoC_Settings;

	import classes.AssClass;
	import classes.BreastRowClass;
	import classes.Items.*;
	import classes.PerkLib;

	import classes.Player;
	import classes.Cock;
	import classes.Creature;
	import classes.ItemSlotClass;
	import classes.PerkClass;
	import classes.StatusAffectClass;
	import classes.VaginaClass;
	import classes.ImageManager;
	import classes.internals.Utils;


	// This line not necessary, but added because I'm pedantic like that.
	import classes.InputManager;

	import classes.Parser.Parser;

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
	import classes.Scenes.Quests.*;
	import coc.view.MainView;

	import coc.model.GameModel;
	import coc.model.TimeModel;

	// Class based content? In my CoC?! It's more likely than you think!
	import classes.content.*;
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
		
	[SWF( width="1000", height="800", pageTitle="Corruption of Champions" )]

	public class CoC extends MovieClip
	{

		// Include the functions. ALL THE FUNCTIONS
		include "../../includes/customCharCreation.as";
		
		include "../../includes/descriptors.as";
		include "../../includes/appearance.as";

		include "../../includes/InitialiseUI.as";
		include "../../includes/input.as";
		include "../../includes/OnLoadVariables.as";
		include "../../includes/startUp.as";
		include "../../includes/debug.as";
		
		include "../../includes/combat.as";
		include "../../includes/doEvent.as";
		include "../../includes/eventParser.as";
		

		include "../../includes/eventTest.as";
		
		
		include "../../includes/transform.as";
		
		include "../../includes/engineCore.as";

		// Lots of constants
		//include "../../includes/flagDefs.as";
		include "../../includes/appearanceDefs.as";

		//Any classes that need to be aware of the passage of time can add themselves to this array using timeAwareAdd.
		//	Once in the array they will be notified as each hour passes, allowing them to update actions, lactation, pregnancy, etc.
		private static var _timeAwareClassList:Vector.<TimeAwareInterface> = new Vector.<TimeAwareInterface>(); //Accessed by goNext function in eventParser
	
		public static function timeAwareClassAdd(newEntry:TimeAwareInterface):void { _timeAwareClassList.push(newEntry); }
	
		// /
		private var _perkLib:PerkLib = new PerkLib();// to init the static
		private var _statusAffects:StatusAffects = new StatusAffects();// to init the static
		public var charCreation:CharCreation = new CharCreation();
		public var saves:Saves = new Saves();
		// Items/
		public var mutations:Mutations = new Mutations();
		public var consumables:ConsumableLib = new ConsumableLib();
		public var useables:UseableLib = new UseableLib();
		public var weapons:WeaponLib = new WeaponLib();
		public var armors:ArmorLib = new ArmorLib();
		public var miscItems:MiscItemLib = new MiscItemLib();
		// Scenes/
		public var camp:Camp = new Camp();
		public var exploration:Exploration = new Exploration();
		public var inventory:Inventory = new Inventory();
		public var followerInteractions:FollowerInteractions = new FollowerInteractions();
		// Scenes/Areas/
		public var bog:Bog = new Bog();
		public var desert:Desert = new Desert();
		public var forest:Forest = new Forest();
		public var highMountains:HighMountains = new HighMountains();
		public var lake:Lake = new Lake();
		public var mountain:Mountain = new Mountain();
		public var plains:Plains = new Plains();
		public var swamp:Swamp = new Swamp();
		// Scenes/Dungeons
		public var brigidScene:BrigidScene = new BrigidScene();
		// Scenes/Explore/
		public var gargoyle:Gargoyle = new Gargoyle();
		public var lumi:Lumi = new Lumi();
		// Scenes/Monsters/
		public var goblinScene:GoblinScene = new GoblinScene();
		public var impScene:ImpScene = new ImpScene();
		public var goblinAssassinScene:GoblinAssassinScene = new GoblinAssassinScene();
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
		// Scenes/Quests/
		public var urtaQuest:UrtaQuest = new UrtaQuest();

		// Force updates in Pepper Flash ahuehue
		private var _updateHack:Sprite = new Sprite();

		// Other scenes

		include "../../includes/april_fools.as";

		include "../../includes/dreams.as";
		include "../../includes/dungeon2Supplimental.as";
		include "../../includes/dungeonCore.as";
		include "../../includes/dungeonEvents.as";
		include "../../includes/dungeonHelSupplimental.as";
		include "../../includes/dungeonSandwitch.as";
		include "../../includes/fera.as";
		include "../../includes/masturbation.as";
		include "../../includes/pregnancy.as";
		include "../../includes/runa.as";
		include "../../includes/symGear.as";
		include "../../includes/tamaniDildo.as";
		include "../../includes/thanksgiving.as";
		include "../../includes/valentines.as";
		include "../../includes/worms.as";
		include "../../includes/xmas_bitch.as";
		include "../../includes/xmas_gats_not_an_angel.as";
		include "../../includes/xmas_jack_frost.as";
		include "../../includes/xmas_misc.as";
	
		
		/****
			This is used purely for bodges while we get things cleaned up.
			Hopefully, anything you stick to this object can be removed eventually.
			I only used it because for some reason the Flash compiler wasn't seeing
			certain functions, even though they were in the same scope as the
			function calling them.
		****/
		public var semiglobalReferencer :* = {};

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
		public var tempPerk:PerkClass;
		public var monster:Monster;
		public var itemSwapping:Boolean;
		public var flags:DefaultDict;
		public var gameState:Number;
		public var menuLoc:Number;
		public var itemSubMenu:Boolean;
		public var supressGoNext:Boolean = false;
		public var time :TimeModel;
		public var currentText:String;

		public var explored:Boolean;
		public var foundForest:Boolean;
		public var foundDesert:Boolean;
		public var foundMountain:Boolean;
		public var foundLake:Boolean;
		public var whitney:Number;
		public var monk:Number;
		public var sand:Number;
		public var giacomo:Number;
		public var beeProgress:Number;
		public var itemStorage:Array;
		public var gearStorage:Array;
		public var temp:int;
		public var args:Array;
		public var funcs:Array;
		public var oldStats:*; // I *think* this is a generic object
		public var inputManager:InputManager;

		public var monkey:ChaosMonkey;
		public var testingBlockExiting:Boolean;

		public var kFLAGS_REF:*;

		public function rand(max:int):int
		{
			return Utils.rand(max);
		}

		// holidayz
		public function isEaster():Boolean
		{
			return plains.bunnyGirl.isItEaster();
		}

		public function CoC()
		{
			// Cheatmode.
			kGAMECLASS = this;
			
			this.kFLAGS_REF = kFLAGS; 
			// cheat for the parser to be able to find kFLAGS
			// If you're not the parser, DON'T USE THIS

			// This is a flag used to prevent the game from exiting when running under the automated tester
			// (the chaos monkey)
			testingBlockExiting = false;
			
			// Used for stopping chaos monkey on syntax errors. Separate flag so we can make stopping optional
			CoC_Settings.haltOnErrors = false;
			
			this.parser = new Parser(this, CoC_Settings);

			this.model = new GameModel();
			this.mainView = new MainView( this.model );
			this.mainView.name = "mainView";
			this.stage.addChild( this.mainView );

			// Hooking things to MainView.
			this.mainView.onNewGameClick = charCreation.newGameGo;
			this.mainView.onAppearanceClick = appearance;
			this.mainView.onDataClick = saves.saveLoad;
			this.mainView.onLevelClick = levelUpGo;
			this.mainView.onPerksClick = displayPerks;
			this.mainView.onStatsClick = displayStats;

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
			ver = "0.8.16";
			version = ver + " (<b>Femoit Fixes</b>)";

			//Indicates if building for mobile?
			mobile = false;
			model.mobile = mobile;

			this.images = new ImageManager(stage);
			this.inputManager = new InputManager(stage, false);
			include "../../includes/ControlBindings.as";

			this.monkey = new ChaosMonkey(this);

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

			//Used in perk selection, mainly eventParser, input and engineCore
			tempPerk = null;

			//Create monster, used all over the place
			monster = new Monster();
			//} endregion

			/**
			 * State Variables
			 * They hold all the information about item states, menu states, game states, etc
			 */
			//{ region StateVariables

			//User all over the place whenever items come up
			itemSwapping = false;

			//The extreme flag state array. This needs to go. Holds information about everything, whether it be certain attacks for NPCs 
			//or state information to do with the game. 
			flags = new DefaultDict();
			model.flags = flags;


			///Used everywhere to establish what the current game state is
			// Key system variables
			//0 = normal
			//1 = in combat
			//2 = in combat in grapple
			//3 = at start or game over screen
			//4 = at giacomo
			//5 = getting succubi potion
			//6 = at alchemist choices.
			//7 = item duuuuump
			//8 = worked at farm
			gameState = 0;

			//Another state variable used for menu display used everywhere
			//menuLoc
			//0 - normal
			//1 - items menu - no heat statuses when leaving it in combat
			//2 - needs to add an hour after grabbing item
			//3 - In tease menu - no heat statuses when leaving it.
			//8 - Find Farm Pepper - 2 hours wait
			//9 - Armor shop
			//10- Tailor shop
			//11- Midsleep loot
			//12 - lumi potions
			//13 - lumi enhancements
			//14 - late night receive item
			//15 - Weapon shop in TelAdra
			//16 - Incubus Shop
			//17 - 4 hours wait
			//18 - 8 hours wait
			//19 - Bakery!
			//20 - weapon rack stuffing
			//21 - weapon rack taking
			//24 - Niamh booze
			//25 - Owca Shop
			//26 - Benoit Shop
			//27 - Chicken Harpy Shop
			//28 - Items menu
			menuLoc = 0;

			//State variable used to indicate whether inside an item submenu
			//The item sub menu
			itemSubMenu = false;
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
			beeProgress = 0;

			itemStorage = [];
			gearStorage = [];
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

			model.maxHP = maxHP;

			// ******************************************************************************************

			mainView.aCb.dataProvider = new DataProvider([{label:"TEMP",perk:new PerkClass(PerkLib.Acclimation)}]);
			mainView.aCb.addEventListener(Event.CHANGE, changeHandler); 
			 
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
			registerClassAlias("StatusAffectClass", StatusAffectClass);
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