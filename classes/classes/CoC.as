package classes
{
	// BREAKING ALL THE RULES.
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	import classes.CoC_Settings;

	import classes.assClass;
	import classes.breastRowClass;
	
	import classes.Player;
	import classes.Cock;
	import classes.Creature;
	import classes.itemSlotClass;
	import classes.perkClass;
	import classes.statusAffectClass;
	import classes.vaginaClass;
	import classes.ImageManager; // This line not necessary, but added because I'm pedantic like that.
	import classes.InputManager;

	import classes.Parser.Main.Parser; 	// import getting long enough yet?

	import classes.Monsters.*;		// import all the various monsters
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

	/****
		classes.CoC: The Document class of Corruption of the Champions.
	****/
		
	[SWF( width="1000", height="800", pageTitle="Corruption of Champions" )]

	public class CoC extends MovieClip
	{

		// Include the functions. ALL THE FUNCTIONS
		include "../../includes/charCreation.as";
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
		
		include "../../includes/exploration.as";
		include "../../includes/followerInteractions.as";
		include "../../includes/telAdre.as";
		
		include "../../includes/bazaar.as";
		
		include "../../includes/eventTest.as";
		
		
		include "../../includes/transform.as";
		
		include "../../includes/engineCore.as";
		include "../../includes/saves.as";
		
		// Lots of constants
		//include "../../includes/flagDefs.as";
		include "../../includes/appearanceDefs.as";

		public var umasShop:UmasShop = new UmasShop();
		
		include "../../includes/akbal.as";
		include "../../includes/amily.as";
		include "../../includes/anemone.as";
		include "../../includes/ants.as";
		include "../../includes/april_fools.as";
		include "../../includes/arian.as";
		include "../../includes/auntNancy.as";
		include "../../includes/bakery.as";
		include "../../includes/basilisk.as";
		include "../../includes/bee.as";
		include "../../includes/benoit.as";
		include "../../includes/brooke.as";
		include "../../includes/bunbun.as";
		include "../../includes/camp.as";
		include "../../includes/ceraph.as";
		include "../../includes/ceraphFollower.as";
		include "../../includes/chameleons.as";
		include "../../includes/cinnabar.as";
		include "../../includes/cotton.as";
		include "../../includes/dreams.as";
		include "../../includes/drider.as";
		include "../../includes/dungeon2Supplimental.as";
		include "../../includes/dungeonCore.as";
		include "../../includes/dungeonEvents.as";
		include "../../includes/dungeonHelSupplimental.as";
		include "../../includes/dungeonSandwitch.as";
		include "../../includes/edryn.as";
		include "../../includes/ember.as";
		include "../../includes/essrayle.as";
		include "../../includes/exgartuan.as";
		include "../../includes/faerie.as";
		include "../../includes/fapArena.as";
		include "../../includes/fellatrix.as";
		include "../../includes/fera.as";
		include "../../includes/fetishCultist.as";
		include "../../includes/fetishZealot.as";
		include "../../includes/froggirl.as";
		include "../../includes/fuckingTree.as";
		include "../../includes/gangbangVillage.as";
		include "../../includes/gargoyle.as";
		include "../../includes/gnoll.as";
		include "../../includes/gnoll_alternate.as";
		include "../../includes/goblin.as";
		include "../../includes/gooGirl.as";
		include "../../includes/harpy.as";
		include "../../includes/harpySophie.as";
		include "../../includes/harpySophieBimbo.as";
		include "../../includes/harpySophieFollower.as";
		include "../../includes/heckel.as";
		include "../../includes/heliaFollower.as";
		include "../../includes/heliaPreggers.as";
		include "../../includes/hellhound.as";
		include "../../includes/hellhoundInfested.as";
		include "../../includes/ifris.as";
		include "../../includes/imp.as";
		include "../../includes/isabella.as";
		include "../../includes/isabellaFollower.as";
		include "../../includes/items.as";
		include "../../includes/izma.as";
		include "../../includes/jasun.as";
		include "../../includes/jojo.as";
		include "../../includes/kaiju.as";
		include "../../includes/katherine.as";
		include "../../includes/kelly.as";
		include "../../includes/kelt.as";
		include "../../includes/kiha.as";
		include "../../includes/kihaFollower.as";
		include "../../includes/kitsunes.as";
		include "../../includes/latexy.as";
		include "../../includes/library.as";
		include "../../includes/lilium.as";
		include "../../includes/loppe.as";
		include "../../includes/lottie.as";
		include "../../includes/lumi.as";
		include "../../includes/maddie.as";
		include "../../includes/marae.as";
		include "../../includes/marble.as";
		include "../../includes/masturbation.as";
		include "../../includes/milkWaifu.as";
		include "../../includes/minerva.as";
		include "../../includes/minotaur.as";
		include "../../includes/minotaurGang.as";
		include "../../includes/naga.as";
		include "../../includes/niamh.as";
		include "../../includes/oasis.as";
		include "../../includes/ooze.as";
		//include "../../includes/parser.as";
		include "../../includes/perkPicker.as";
		include "../../includes/pregnancy.as";
		include "../../includes/Raphael.as";
		include "../../includes/rathazul.as";
		include "../../includes/rogar.as";
		include "../../includes/roxanne.as";
		include "../../includes/rubi.as";
		include "../../includes/runa.as";
		include "../../includes/salamander.as";
		include "../../includes/salon.as";
		include "../../includes/sandtrap.as";
		include "../../includes/sandwitch.as";
		include "../../includes/satyr.as";
		include "../../includes/scylla.as";
		include "../../includes/sexMachine.as";
		include "../../includes/sharkgirls.as";
		include "../../includes/sheila.as";
		include "../../includes/shouldra.as";
		include "../../includes/shouldraFollower.as";
		include "../../includes/spiderMorph.as";
		include "../../includes/spiderMorphMale.as";
		include "../../includes/swordInStone.as";
		include "../../includes/symGear.as";
		include "../../includes/tamani.as";
		include "../../includes/tamaniDildo.as";
		include "../../includes/tamanisDaughters.as";
		include "../../includes/tentacle.as";
		include "../../includes/thanksgiving.as";
		include "../../includes/urta.as";
		include "../../includes/urtaPregs.as";
		include "../../includes/urtaQuest.as";
		include "../../includes/valaria.as";
		include "../../includes/valentines.as";
		include "../../includes/wanderer.as";
		include "../../includes/whitneyFarm.as";
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
		public var tempPerk:String;
		public var monster:Monster;
		public var itemSwapping:Boolean;
		public var flags:DefaultDict;
		public var gameState:Number;
		public var menuLoc:Number;
		public var itemSubMenu:Boolean;
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
		public var itemSlot1:itemSlotClass;
		public var itemSlot2:itemSlotClass;
		public var itemSlot3:itemSlotClass;
		public var itemSlot4:itemSlotClass;
		public var itemSlot5:itemSlotClass;
		public var itemSlots:Array;
		public var itemStorage:Array;
		public var gearStorage:Array;
		public var shortName:String;
		public var temp:int;
		public var args:Array;
		public var funcs:Array;
		public var oldStats:*; // I *think* this is a generic object
		public var inputManager:InputManager;

		public var monkey:ChaosMonkey;
		public var testingBlockExiting:Boolean;

		public function CoC()
		{
			// Cheatmode.
			kGAMECLASS = this;
			
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
			this.mainView.onNewGameClick = newGameGo;
			this.mainView.onAppearanceClick = appearance;
			this.mainView.onDataClick = saveLoad;
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
			ver = "0.8.3f2";
			version = "v0.8.3f2 (<b>Uma Likes 'em Pretty</b>)";

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
			tempPerk = "";

			//Create monster, used all over the place
			monster = new Monster(this);
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

			//Item things
			itemSlot1 = new itemSlotClass();
			itemSlot2 = new itemSlotClass();
			itemSlot3 = new itemSlotClass();
			itemSlot4 = new itemSlotClass();
			itemSlot5 = new itemSlotClass();
			

			itemSlots = [itemSlot1, itemSlot2, itemSlot3, itemSlot4, itemSlot5];

			itemStorage = new Array();
			gearStorage = new Array();
			shortName = "";
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
			args = new Array();
			funcs = new Array();

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

			mainView.aCb.dataProvider = new DataProvider(perkList); 
			mainView.aCb.addEventListener(Event.CHANGE, changeHandler); 
			 
			//mainView._getButtonToolTipText = getButtonToolTipText;


			//Register the classes we need to be able to serialize and reconstitute so
			// they'll get reconstituted into the correct class when deserialized
			registerClassAlias("assClass", assClass);
			registerClassAlias("Character", Character);
			registerClassAlias("Cock", Cock);
			registerClassAlias("CockTypesEnum", CockTypesEnum);
			registerClassAlias("Enum", Enum);
			registerClassAlias("Creature", Creature);
			registerClassAlias("itemSlotClass", itemSlotClass);
			registerClassAlias("keyItemClass", keyItemClass);
			registerClassAlias("Monster", Monster);
			registerClassAlias("Player", Player);
			registerClassAlias("statusAffectClass", statusAffectClass);
			registerClassAlias("vaginaClass", vaginaClass);
			//registerClassAlias("Enum", Enum);
			//registerClassAlias("cockClass", cockClass);

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
		}
	}
}