/**
 * Global Variables used across the whole game. I hope to whittle it down slowly.
 */

/**
 * System Variables
 * Debug, Version, etc
 */
//{ region SystemVariables

//DEBUG, used all over the place
var debug:Boolean = false;

//Version NUMBER
var ver:String = "0.8.3d1";
var version:String = "v0.8.3d1 (<b>Dick or Treat</b>)";

//Indicates if building for mobile?
var mobile:Boolean = false;

var images:ImageManager = new ImageManager();
//} endregion

/**
 * Player specific variables
 * The player object and variables associated with the player
 */
//{ region PlayerVariables

//The Player object, used everywhere
var player:Player = new Player();

//Used in perk selection, mainly eventParser, input and engineCore
var tempPerk:String = "";

//Create monster, used all over the place
var monster:Monster = new Monster();
//} endregion

/**
 * State Variables
 * They hold all the information about item states, menu states, game states, etc
 */
//{ region StateVariables

//User all over the place whenever items come up
var itemSwapping:Boolean = false;

//The extreme flag state array. This needs to go. Holds information about everything, whether it be certain attacks for NPCs 
//or state information to do with the game. 
var flags = new DefaultDict();
for (var i = 0; i < 3000; i++)
{
	flags.push(0);
}

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
var gameState:Number = 0;

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
var menuLoc:Number = 0;

//State variable used to indicate whether inside an item submenu
//The item sub menu
var itemSubMenu:Boolean = false;
//} endregion 

/**
 * Display Variables
 * Variables that hold display information like number of days and all the current displayed text
 */
//{ region DisplayVariables

//Holds the date and time display in the bottom left
var hours:Number = 0;
var days:Number = 0;

//The string holds all the "story" text, mainly used in engineCore
var currentText:String = "";
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
var explored:Boolean = false;
var foundForest:Boolean = false;
var foundDesert:Boolean = false;
var foundMountain:Boolean = false;
var foundLake:Boolean = false;
var whitney:Number = 0;
var monk:Number = 0;
var sand:Number = 0;
var giacomo:Number = 0;
var beeProgress:Number = 0;

//Item things
var itemSlot1:itemSlotClass = new itemSlotClass();
var itemSlot2:itemSlotClass = new itemSlotClass();
var itemSlot3:itemSlotClass = new itemSlotClass();
var itemSlot4:itemSlotClass = new itemSlotClass();
var itemSlot5:itemSlotClass = new itemSlotClass();
var itemStorage:Array = new Array;
var gearStorage:Array = new Array;
var shortName:String = "";
//}endregion
