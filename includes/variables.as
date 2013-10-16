// import classes.creature;

//Create a player
var player:creature = new creature();
var player2:creature = new creature();
var urtaQItems:Array = new Array();
//Create monster
var monster:creature = new creature();
//DEBUG
var debug:Boolean = false;
//used for creation
var temp:Number = 0;
//Used in perk selection
var tempPerk:String = "";
//Version NUMBER
var ver:String = "0.8.3b";
var version:String = "v0.8.3b (<b>Bog Lovin'</b>)";
var mobile:Boolean = false;
var itemSwapping:Boolean = false;
//Used when save/loading
var notes:String = "";
nameBox.maxChars = 54;

//Variable storage
var flags = new Array();
for(var i=0;i < 3000;i++) {
	flags.push(0);
}
//Images for image pack!
var images = new Array();


//System time
var date = new Date();

var args:Array = new Array();
var funcs:Array = new Array();
var buttons:Array = new Array();
var buttonEvents:Array = new Array();

buttons[0] = new buttonBackground0();
buttons[1] = new buttonBackground1();
buttons[2] = new buttonBackground2();
buttons[3] = new buttonBackground3();
buttons[4] = new buttonBackground4();
buttons[5] = new buttonBackground5();
buttons[6] = new buttonBackground6();
buttons[7] = new buttonBackground7();
buttons[8] = new buttonBackground8();
buttons[9] = new buttonBackground9();
temp = 0;
while(temp < 10) {
	buttons[temp].addEventListener(MouseEvent.CLICK, buttonEvent);
	temp++;
}


//Loeri stuff
//import flash.system.*
 
//if ( ApplicationDomain.currentDomain.hasDefinition("Creature")) trace("Class exists");


this.addChild(buttons[0]);
this.addChild(buttons[1]);
this.addChild(buttons[2]);
this.addChild(buttons[3]);
this.addChild(buttons[4]);
this.addChild(buttons[5]);
this.addChild(buttons[6]);
this.addChild(buttons[7]);
this.addChild(buttons[8]);
this.addChild(buttons[9]);
/*
this.setChildIndex(b1Text, 4);
this.setChildIndex(b2Text, 4);
this.setChildIndex(b3Text, 4);
this.setChildIndex(b4Text, 4);
this.setChildIndex(b5Text, 4);
this.setChildIndex(b6Text, 4);
this.setChildIndex(b7Text, 4);
this.setChildIndex(b8Text, 4);
this.setChildIndex(b9Text, 4);
*/


temp = 0;
while(temp < 10) {
	if(temp < 5) {
		buttons[temp].x = 200 + temp * 160;
		buttons[temp].y = 668;
	}
	else {
		buttons[temp].x = 200 + (temp-5) * 160;
		buttons[temp].y = 720;
	}
	this.setChildIndex(buttons[temp], 4);
	buttons[temp].width = 150;
	buttons[temp].height = 40;
	trace("BUTTON #: " + temp + " X: " + buttons[temp].x + " Y: " + buttons[temp].y);
	temp++;
}

/*
0) **Clit (+2 sens)
1) **Dick (+2 lib) adds the word 'pierced' sometimes to the description
2) **Ears
3) **Eyebrow (-.5 def)
4) **Lip (-.5 def)
5) **Nipples (+1 sens, +1 lib)
6) **Nose (+.5 attack)
7) **Tongue (+1 sens)
8) **Vulva (+1 sens)*/
var piercingLoc:Number = 0;

//1. Amethyst (+1 int, +1 lib)
//2. Diamond (+2 int, -1 cor)
//3. Gold (+1 int, +1 sens)
//4. Emerald (+1 spe)
//5. Jade (+1 spe, -.5 tou)
//6. Onyx (+1 tou, -1 spe)
//7. Ruby (+1 lib, +1 sens)
//8. Steel (+2 str, -2 int)
var piercingMat:Number = 0;

//1. Stud
//2. Ring (Called prince albert on dick)
//3. Jacobs Ladder (dick only)
//4. Hoop (ears/nipples/clit)
//5. Chain (nipples only)
var piercingType:Number = 0;

//Key system variables
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
//dungeoneering variables
var inDungeon:Boolean = false;
var dungeonLoc:Number = 0;
var itemSubMenu:Boolean = false;
//Used to restrict random drops from overlapping uniques
var plotFight:Boolean = false;
var timeQ:Number = 0;
var campQ:Boolean = false;

var hours:Number = 0;
var days:Number = 0;
	//Used for output
var currentText:String = "";

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

//Used for stat tracking to keep up/down arrows correct.
var oldStr:Number = 0;
var oldTou:Number = 0;
var oldSpe:Number = 0;
var oldInte:Number = 0;
var oldSens:Number = 0;
var oldLib:Number = 0;
var oldCor:Number = 0;
var oldHP:Number = 0;
var oldLust:Number = 0;

//Input vars
var button0Choice:Number = 0;
var button1Choice:Number = 0;
var button2Choice:Number = 0;
var button3Choice:Number = 0;
var button4Choice:Number = 0;
var button5Choice:Number = 0;
var button6Choice:Number = 0;
var button7Choice:Number = 0;
var button8Choice:Number = 0;
var button9Choice:Number = 0;