/**
 * Upgrade to PC camp aside walls and cabin.
 * @author Ormael
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.BaseContent;
	
	import classes.Scenes.NPCs.*;
	import classes.Scenes.Camp;
	
	import coc.model.GameModel;
	
	public class CampUpgrades extends BaseContent {
		
		public var maxNailSupply:int = 600;
		public var maxWoodSupply:int = 900;
		public var maxStoneSupply:int = 900;
		
		public var marblehelper:MarbleScene = new MarbleScene();
		public var helhelper:HelFollower = new HelFollower();
		public var kihahelper:KihaFollower = new KihaFollower();
/*
flags[kFLAGS.MATERIALS_STORAGE_UPGRADES]:
1 - Toolbox bought
2 - Nails box bought
3 - Wood storage built
4 - Stone storage built
5 - Stone constructions guide bought
6 - Sand storage built
7 - Concrete storage built (unless building won't be req. so much of it to need another storage ^^ or just make one storage that will increase slightly both sand and concrete store space)
(8 - Possible special materials storage/and or addidtional building guide for specific structures (fireproof dweeling that even with stones and concrete isn't enough?))

flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY]:
1 - 1st Warehouse 1st part built
2 - 1st Warehouse 2nd part built (12 slots)
3 - Granary 1st part built
4 - Granary 2nd part built (9 slots)
5 - 2nd Warehouse 1st part built
6 - 2nd Warehouse 2nd part built (12 slots)

flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE]:
1 - mark the spot
2 - build structure
3 - build altair
4 - get Taoth statue

flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS]:
1 - chance to proc find a spot
2 - find the spot
3 - dig a pool
4 - add the wood walls

flags[kFLAGS.CAMP_UPGRADES_SPARING_RING]:
1 - unlocking building ring
2 - ring build (small)

flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE]:
1 - first arcane circle
2 - second arcane circle
3 - third arcane circle
?4 - 4th?

flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD]:
1 - readed Warding Tome
2 - builded Ward / Inactive Ward
3 - Active Ward

flags[kFLAGS.CAMP_UPGRADES_DAM]:
1 - minor wood dam
2 - major wood dam
3 - minor stone dam
4 - x

flags[kFLAGS.CAMP_UPGRADES_FISHERY]:
1 - fishery

flags[kFLAGS.CAMP_UPGRADES_]:
1 - 

flags[kFLAGS.CAMP_UPGRADES_]:
1 - 

flagi na przyszłościowe surowce coby nie zapomnieć iż je już wpisałem do kodu w kFLAGS
CAMP_CABIN_SAND_RESOURCES
CAMP_CABIN_CONCRETE_RESOURCES
*/
public function buildmisc1Menu():void {
	menu();
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 1 || flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 2) addButton(0, "Wood Storage", materialgatheringstorageupgrade).hint("Build up storage to gather more wood at the camp. (Req. 150 fatigue)");
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 3) addButton(0, "Stone Storage", materialgatheringstorageupgrade).hint("Build up storage to gather more stones at the camp. (Req. 150 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 0 || flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 1) addButton(1, "1st Warehouse", warehousegranary).hint("Build 1st part of the Warehouse to expand your storage space. (Req. 250 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 2 || flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 3) addButton(1, "Granary", warehousegranary).hint("Build Granary to expand your food space. (Req. 250 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 4 || flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 5) addButton(1, "2nd Warehouse", warehousegranary).hint("Build 2nd part of the Warehouse to expand your storage space. (Req. 250 fatigue)");
	if (player.kitsuneScore() >= 6 && (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] < 1 || flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 1 || flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 2)) addButton(2, "Shrine", kitsuneshrine).hint("Build up kitsune shrine at the camp. (Req. 300 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 3) {
		if (player.findPerk(PerkLib.StarSphereMastery) < 0 && !(player.hasItem(useables.GLDSTAT))) addButtonDisabled(2, "Shrine", "You need to have Kitsune Statue and your own Star Sphere to finish the shrine!");
		if (player.findPerk(PerkLib.StarSphereMastery) >= 0 && player.hasItem(useables.GLDSTAT)) addButton(2, "Shrine", kitsuneshrine2).hint("Finish up kitsune shrine at the camp.");
	}
	if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 2 || flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 3) addButton(3, "Hot Spring", hotspring).hint("Build up hot spring at the camp. (Req. 100 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 1 && flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2) addButton(4, "Sparring Ring", sparringRing).hint("Build up sparring ring at the camp. (Unlock sparring option for all camp members that have this option)(Req. 50 fatigue)");
	if (player.findPerk(PerkLib.JobElementalConjurer) >= 0 && flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] < 3) addButton(5, "Arcane Circle", arcaneCircle).hint("Build an arcane circle at the camp. (Unlock elementals summons related options)(Req. 50 fatigue, enough mana and blood)");
	if (player.inte >= 50 && flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 1) addButton(6, "Magic Ward", magicWard).hint("Set up a Magic Ward around the camp. (Req. 200 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_DAM] < 1) addButton(7, "Dam", dam).hint("Build up a dam on the steam next to the camp. (Req. 200 fatigue * tier of build dam)");
	if (flags[kFLAGS.CAMP_UPGRADES_DAM] >= 1 && flags[kFLAGS.CAMP_UPGRADES_FISHERY] < 1) addButton(8, "Fishery", fishery).hint("Build up a fishery on the steam next to the camp. (Req. 200 fatigue)");
	addButton(14, "Back", playerMenu);
}
public function buildCampMembersCabinsMenu():void {
	menu();
	addButtonDisabled(0, "Lair", "You need to have Ember for those upgrades.");
	addButtonDisabled(1, "Ant Hill", "You need to have Phylla for those upgrades.");
	addButtonDisabled(2, "Horse-barn", "You need to have any cow-like camp member for those upgrades.");
	addButtonDisabled(3, "Rockery", "You need to have any flying camp member for those upgrades.");
	addButton(14, "Back", playerMenu);
}

//Materials Storages Upgrade
public function materialgatheringstorageupgrade():void {
	clearOutput();
	if (player.fatigue <= player.maxFatigue() - 150)
	{
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 1) { 
			neednailsbox();
			return; 
		}
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 2) { 
			startWoodStorage();
			return; 
		}
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 3) { 
			startStoneStorage();
			return;
		}
	}
	else
	{	
		outputText("You are too exhausted to work on expanding your materials storage!");
		doNext(playerMenu);
	}
}
public function neednailsbox():void {
	outputText("When you opening book from your toolbox on the page describing how to build properly storage for wood you realize amount of nails that will be needed is much more than your toolbox can keep.  Damn if you would like to build this structure you would spend much of the time on walking to the carpenter shop in Tel'Adre to buy missing nails unless... there is some way to be able store more than 200 nails.  With thoughts that maybe carpenter shopkeeper will help with this issue, you put back book.");
	doNext(playerMenu);
}
public function startWoodStorage():void {
	outputText("Do you start work on building wood storage? (Cost: 250 nails, 250 wood and 100 stones.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 250 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 250 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 100)
	{
		doYesNo(doWoodStorageWork, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function doWoodStorageWork():void {
	var helpers:int = 0;
	var helperArray:Array = [];
	if (marblehelper.marbleFollower()) {
		helperArray[helperArray.length] = "Marble";
		helpers++;
	}
	if (helhelper.followerHel()) {
		helperArray[helperArray.length] = "Helia";
		helpers++;
	}
	if (kihahelper.followerKiha()) {
		helperArray[helperArray.length] = "Kiha";
		helpers++;
	}
	if (flags[kFLAGS.ANT_KIDS] > 100) {
		helperArray[helperArray.length] = "group of your ant children";
		helpers++;
	}
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 250;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 250;
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 100;
	clearOutput();
	outputText("You pull out \"Carpenter's Guide\" and flip pages until you come across instructions on how to build storage for woods. You spend few minutes looking at the instructions.");
	flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] += 1;
	outputText("\n\nYou take the wood, saw it and then cut into planks. You put four long and thick wood posts as base, then you connect them with nails. Next you cut few posts into short fragments and impale at the edges. Inside of prepared frame you put few large wood logs that you fix in place with a few short wood desks and stones. After that last part of building is to put all rest wood planks on prepared base and nail them in place.");
	if (helpers > 0) {
		outputText("\n\n" + formatStringArray(helperArray));
		outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with building the storage, helping to speed up the process and make construction less fatiguing.");
	}
	//Gain fatigue.
	var fatigueAmount:int = 150;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only one hour!");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only two hours.");
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("\n\nIt's " + (fatigueAmount >= 115 ? "a daunting" : "an easy") + " task but you eventually manage to finish building wood storage for your camp. Now you can store safetly larger amount of wood!");
		doNext(camp.returnToCampUseFourHours);
	}
}
public function startStoneStorage():void {
	outputText("Do you start work on building stone storage? (Cost: 350 nails, 400 wood and 200 stones.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 350 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 400 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 200)
	{
		doYesNo(doStoneStorageWork, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function doStoneStorageWork():void {
	var helpers:int = 0;
	var helperArray:Array = [];
	if (marblehelper.marbleFollower()) {
		helperArray[helperArray.length] = "Marble";
		helpers++;
	}
	if (helhelper.followerHel()) {
		helperArray[helperArray.length] = "Helia";
		helpers++;
	}
	if (kihahelper.followerKiha()) {
		helperArray[helperArray.length] = "Kiha";
		helpers++;
	}
	if (flags[kFLAGS.ANT_KIDS] > 100) {
		helperArray[helperArray.length] = "group of your ant children";
		helpers++;
	}
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 350;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 400;
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 200;
	clearOutput();
	outputText("You pull out \"Carpenter's Guide\" and flip pages until you come across instructions on how to build storage for stones. You spend few minutes looking at the instructions.");
	flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] += 1;
	outputText("\n\nYou take the wood, saw it and then cut into planks. Like before you put four long and thick wood posts as base, then you connect them with nails. Next you cut few posts into short fragments and impale at the edges. Inside of prepared frame you put few large wood logs that you fix in place with a few short wood desks and stones. Rest of the stones fill the space inside due to need in future support weight of stones stored above. After that prelast part of building is to put all most of remaining wood planks on prepared base and nail them in place. Final thing to do is use remain wood and nails to make protective barrier around the whole storage.");
	if (helpers > 0) {
		outputText("\n\n" + formatStringArray(helperArray));
		outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with building the storage, helping to speed up the process and make construction less fatiguing.");
	}
	//Gain fatigue.
	var fatigueAmount:int = 150;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only one hour!");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only two hours.");
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("\n\nIt's " + (fatigueAmount >= 115 ? "a daunting" : "an easy") + " task but you eventually manage to finish building stone storage for your camp. Now you can store safetly larger amount of stones!");
		doNext(camp.returnToCampUseFourHours);
	}
}

//Warehouse + Granary Upgrade
public function warehousegranary():void {
	clearOutput();
	if (player.fatigue <= player.maxFatigue() - 250)
	{
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 0) { 
			start1stWarehouse1();
			return; 
		}
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 1) { 
			start1stWarehouse2();
			return; 
		}
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 2) { 
			startGranary1();
			return; 
		}
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 3) { 
			startGranary2();
			return; 
		}
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 4) { 
			start2ndWarehouse1();
			return; 
		}
		if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 5) { 
			start2ndWarehouse2();
			return;
		}
	}
	else
	{	
		outputText("You are too exhausted to work on constructing your storage building!");
		doNext(playerMenu);
	}
}
public function start1stWarehouse1():void {
	outputText("Do you start work on building warehouse frame and walls? (Cost: 200 nails, 100 wood and 40 stones.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 100 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 40)
	{
		doYesNo(do1stWarehouse1Work, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function do1stWarehouse1Work():void {
	var helpers:int = 0;
	var helperArray:Array = [];
	if (marblehelper.marbleFollower()) {
		helperArray[helperArray.length] = "Marble";
		helpers++;
	}
	if (helhelper.followerHel()) {
		helperArray[helperArray.length] = "Helia";
		helpers++;
	}
	if (kihahelper.followerKiha()) {
		helperArray[helperArray.length] = "Kiha";
		helpers++;
	}
	if (flags[kFLAGS.ANT_KIDS] > 100) {
		helperArray[helperArray.length] = "group of your ant children";
		helpers++;
	}
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 100;
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 40;
	clearOutput();
	outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build warehouse. You spend few minutes looking at the instructions.");
	flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
	outputText("\n\nYou pick up a log from a nearby pile and saw it into a rectangular plank, fit to be used for the base of your future warehouse.  You lay out the foundation, rooting in planks, and leaving open corners for the thick logs that will be the corners of the building.");
	outputText("\nAs you begin to connect their tops to make the floor the real work begins, nailing planks together, fitting everything into place.  After a few hours of hard labor the foundation is complete and you wipe the sweat off your brow, tapping a foot on your work and letting out a breathe of air.");
	outputText("\nFor the last bit of work you get the frame of the building itself into place with a lot of elbow grease and brute strength, they don't call you the champion for nothing!");
	outputText("\nRapping a knuckle against the walls you're filled with pride of your hard work, though it still needs a roof and actual flooring, but that can wait until tomorrow, you're pretty beat…");
	if (helpers > 0) {
		outputText("\n\n" + formatStringArray(helperArray));
		outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with building the warehouse frame and walls, helping to speed up the process and make construction less fatiguing.");
	}
	//Gain fatigue.
	var fatigueAmount:int = 250;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only one hour!");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only two hours.");
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("\n\nIt's " + (fatigueAmount >= 185 ? "a daunting" : "an easy") + " task but you eventually manage to finish building warehouse frame and walls.");
		doNext(camp.returnToCampUseFourHours);
	}
}
public function start1stWarehouse2():void {
	outputText("Do you start work on building warehouse roof and floor? (Cost: 400 nails, 300 wood and 140 stones.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 400 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 300 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 140)
	{
		doYesNo(do1stWarehouse2Work, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function do1stWarehouse2Work():void {
	var helpers:int = 0;
	var helperArray:Array = [];
	if (marblehelper.marbleFollower()) {
		helperArray[helperArray.length] = "Marble";
		helpers++;
	}
	if (helhelper.followerHel()) {
		helperArray[helperArray.length] = "Helia";
		helpers++;
	}
	if (kihahelper.followerKiha()) {
		helperArray[helperArray.length] = "Kiha";
		helpers++;
	}
	if (flags[kFLAGS.ANT_KIDS] > 100) {
		helperArray[helperArray.length] = "group of your ant children";
		helpers++;
	}
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 400;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 300;
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 140;
	clearOutput();
	outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build warehouse. You spend few minutes looking at the instructions.");
	flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
	outputText("\n\nAs before you preparing wood planks. Constructing temporally ladder you using it to get on top of the construction. Here one by one you nail prepared earlier wood pieces to form simple roof. After it's finished you getting down and entering inside. Putting in marked places wood logs you fill rest of the space with stones to make sure floor would be able to deal with even heavy weight. As last thing you use left planks to make floor. After tiring work you going out to look at your brand new warehouse.");
	if (helpers > 0) {
		outputText("\n\n" + formatStringArray(helperArray));
		outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with building the warehouse, helping to speed up the process and make construction less fatiguing.");
	}
	//Gain fatigue.
	var fatigueAmount:int = 250;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only one hour!");
		outputText("\n\n<b>You've built first warehouse and gained 12 inventory slots.</b>");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only two hours.");
		outputText("\n\n<b>You've built first warehouse and gained 12 inventory slots.</b>");
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("\n\nIt's " + (fatigueAmount >= 185 ? "a daunting" : "an easy") + " task but you eventually manage to finish building warehouse for your camp. Now you can store safetly larger amount of items!");
		outputText("\n\n<b>You've built first warehouse and gained 12 inventory slots.</b>");
		doNext(camp.returnToCampUseFourHours);
	}
}
public function startGranary1():void {
	outputText("Do you start work on building granary frame and walls? (Cost: 200 nails, 125 wood and 30 stones.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 125 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 30)
	{
		doYesNo(doGranary1Work, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function doGranary1Work():void {
	var helpers:int = 0;
	var helperArray:Array = [];
	if (marblehelper.marbleFollower()) {
		helperArray[helperArray.length] = "Marble";
		helpers++;
	}
	if (helhelper.followerHel()) {
		helperArray[helperArray.length] = "Helia";
		helpers++;
	}
	if (kihahelper.followerKiha()) {
		helperArray[helperArray.length] = "Kiha";
		helpers++;
	}
	if (flags[kFLAGS.ANT_KIDS] > 100) {
		helperArray[helperArray.length] = "group of your ant children";
		helpers++;
	}
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 125;
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 30;
	clearOutput();
	outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build granary. You spend few minutes looking at the instructions.");
	flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
	outputText("\n\nYou pick up a log from a nearby pile and saw it into a rectangular plank, fit to be used for the base of your future granary.  You lay out the foundation, rooting in planks, and leaving open corners for the thick logs that will be the corners of the building.");
	outputText("\nAs you begin to connect their tops to make the floor the real work begins, nailing planks together, fitting everything into place.  After a few hours of hard labor the foundation is complete and you wipe the sweat off your brow, tapping a foot on your work and letting out a breathe of air.");
	outputText("\nFor the last bit of work you get the frame of the building itself into place with a lot of elbow grease and brute strength, they don't call you the champion for nothing!");
	outputText("\nRapping a knuckle against the walls you're filled with pride of your hard work, though it still needs a roof and actual flooring, but that can wait until tomorrow, you're pretty beat…");
	//outputText("\nAfter moment of pondering and short rest to slight recover you make one more adjustment. Using few more pieces of wood and some nails creating small connection part to standing next to the construction site warehouse. It should be now easier move between those two structures without need going outside.");
	if (helpers > 0) {
		outputText("\n\n" + formatStringArray(helperArray));
		outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with building the granary, helping to speed up the process and make construction less fatiguing.");
	}
	//Gain fatigue.
	var fatigueAmount:int = 250;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only one hour!");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only two hours.");
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("\n\nIt's " + (fatigueAmount >= 185 ? "a daunting" : "an easy") + " task but you eventually manage to finish building granary frame and walls.");
		doNext(camp.returnToCampUseFourHours);
	}
}
public function startGranary2():void {
	outputText("Do you start work on building granary roof and floor? (Cost: 300 nails, 225 wood and 105 stones.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 300 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 225 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 105)
	{
		doYesNo(doGranary2Work, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function doGranary2Work():void {
	var helpers:int = 0;
	var helperArray:Array = [];
	if (marblehelper.marbleFollower()) {
		helperArray[helperArray.length] = "Marble";
		helpers++;
	}
	if (helhelper.followerHel()) {
		helperArray[helperArray.length] = "Helia";
		helpers++;
	}
	if (kihahelper.followerKiha()) {
		helperArray[helperArray.length] = "Kiha";
		helpers++;
	}
	if (flags[kFLAGS.ANT_KIDS] > 100) {
		helperArray[helperArray.length] = "group of your ant children";
		helpers++;
	}
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 300;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 225;
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 105;
	clearOutput();
	outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build granary. You spend few minutes looking at the instructions.");
	flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
	outputText("As before you preparing wood planks. Constructing temporally ladder you using it to get on top of the construction. Here one by one you nail prepared earlier wood pieces to form simple roof. After it's finished you getting down and entering inside. Putting in marked places wood logs you fill rest of the space with stones to make sure floor would be able to deal with even heavy weight. As last thing you use left planks to make floor. After tiring work you going out to look at your brand new granary.");
	if (helpers > 0) {
		outputText("\n\n" + formatStringArray(helperArray));
		outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with building the granary, helping to speed up the process and make construction less fatiguing.");
	}
	//Gain fatigue.
	var fatigueAmount:int = 250;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only one hour!");
		outputText("\n\n<b>You've built granary and gained 9 inventory slots for consumable items.</b>");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only two hours.");
		outputText("\n\n<b>You've built granary and gained 9 inventory slots for consumable items.</b>");
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("\n\nIt's " + (fatigueAmount >= 185 ? "a daunting" : "an easy") + " task but you eventually manage to finish building granary for your camp. Now you can store safetly larger amount of consumable items!");
		outputText("\n\n<b>You've built granary and gained 9 inventory slots for consumable items.</b>");
		doNext(camp.returnToCampUseFourHours);
	}
}
public function start2ndWarehouse1():void {
	outputText("Do you start work on building warehouse frame and walls? (Cost: 250 nails, 150 wood and 40 stones.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 250 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 150 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 40)
	{
		doYesNo(do2ndWarehouse1Work, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function do2ndWarehouse1Work():void {
	var helpers:int = 0;
	var helperArray:Array = [];
	if (marblehelper.marbleFollower()) {
		helperArray[helperArray.length] = "Marble";
		helpers++;
	}
	if (helhelper.followerHel()) {
		helperArray[helperArray.length] = "Helia";
		helpers++;
	}
	if (kihahelper.followerKiha()) {
		helperArray[helperArray.length] = "Kiha";
		helpers++;
	}
	if (flags[kFLAGS.ANT_KIDS] > 100) {
		helperArray[helperArray.length] = "group of your ant children";
		helpers++;
	}
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 250;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 150;
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 40;
	clearOutput();
	outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build warehouse. You spend few minutes looking at the instructions.");
	flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
	outputText("\n\nYou pick up a log from a nearby pile and saw it into a rectangular plank, fit to be used for the base of your future granary.  You lay out the foundation, rooting in planks, and leaving open corners for the thick logs that will be the corners of the building.");
	outputText("\nAs you begin to connect their tops to make the floor the real work begins, nailing planks together, fitting everything into place.  After a few hours of hard labor the foundation is complete and you wipe the sweat off your brow, tapping a foot on your work and letting out a breathe of air.");
	outputText("\nFor the last bit of work you get the frame of the building itself into place with a lot of elbow grease and brute strength, they don't call you the champion for nothing!");
	outputText("\nRapping a knuckle against the walls you're filled with pride of your hard work, though it still needs a roof and actual flooring, but that can wait until tomorrow, you're pretty beat…");
	//outputText("\nAfter that you looking at standing next to the frame other two structures. Right it's better to connect them with this one too for future easier access to any of them without need to going outside. So you making another small connection part like earlier between first warehouse and granary.");
	if (helpers > 0) {
		outputText("\n\n" + formatStringArray(helperArray));
		outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with building the warehouse frame and walls, helping to speed up the process and make construction less fatiguing.");
	}
	//Gain fatigue.
	var fatigueAmount:int = 250;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only one hour!");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only two hours.");
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("\n\nIt's " + (fatigueAmount >= 185 ? "a daunting" : "an easy") + " task but you eventually manage to finish building warehouse frame and walls.");
		doNext(camp.returnToCampUseFourHours);
	}
}
public function start2ndWarehouse2():void {
	outputText("Do you start work on building warehouse roof and floor? (Cost: 400 nails, 300 wood and 140 stones.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 400 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 300 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 140)
	{
		doYesNo(do2ndWarehouse2Work, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function do2ndWarehouse2Work():void {
	var helpers:int = 0;
	var helperArray:Array = [];
	if (marblehelper.marbleFollower()) {
		helperArray[helperArray.length] = "Marble";
		helpers++;
	}
	if (helhelper.followerHel()) {
		helperArray[helperArray.length] = "Helia";
		helpers++;
	}
	if (kihahelper.followerKiha()) {
		helperArray[helperArray.length] = "Kiha";
		helpers++;
	}
	if (flags[kFLAGS.ANT_KIDS] > 100) {
		helperArray[helperArray.length] = "group of your ant children";
		helpers++;
	}
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 400;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 300;
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 140;
	clearOutput();
	outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build warehouse. You spend few minutes looking at the instructions.");
	flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
	outputText("\n\nAs before you preparing wood planks. Constructing temporally ladder you using it to get on top of the construction. Here one by one you nail prepared earlier wood pieces to form simple roof. After it's finished you getting down and entering inside. Putting in marked places wood logs you fill rest of the space with stones to make sure floor would be able to deal with even heavy weight. As last thing you use left planks to make floor. After tiring work you going out to look at your brand new warehouse.");
	if (helpers > 0) {
		outputText("\n\n" + formatStringArray(helperArray));
		outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with building the warehouse, helping to speed up the process and make construction less fatiguing.");
	}
	//Gain fatigue.
	var fatigueAmount:int = 250;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only one hour!");
		outputText("\n\n<b>You've built second warehouse and gained 12 inventory slots.</b>");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only two hours.");
		outputText("\n\n<b>You've built second warehouse and gained 12 inventory slots.</b>");
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("\n\nIt's " + (fatigueAmount >= 185 ? "a daunting" : "an easy") + " task but you eventually manage to finish building warehouse for your camp. Now you can store safetly larger amount of items!");
		outputText("\n\n<b>You've built second warehouse and gained 12 inventory slots.</b>");
		doNext(camp.returnToCampUseFourHours);
	}
}

//Kitsune Shrine Upgrade
public function kitsuneshrine():void {
	clearOutput();
	if (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] < 1) { 
		findSpotForShrine();
		return;
	}
	if (player.fatigue <= player.maxFatigue() - 300 && flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 1) { 
		buildStructure();
		return; 
	}
	if (player.fatigue <= player.maxFatigue() - 200 && flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 2) { 
		buildAltair();
		return;
	}
	else
	{	
		outputText("You are too exhausted to work on constructing shrine!");
		doNext(playerMenu);
	}
}
public function findSpotForShrine():void {
	outputText("Unsatisfied with having to go up to the Deepwoods to offer your prayers, you decide to build a shrine next to your camp. You look for a spot and mark it, planning to come back later with the materials.");
	flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] = 1;
	doNext(camp.returnToCampUseOneHour);
}
public function buildStructure():void {
	outputText("Do you start work on building the structure? (Cost: 500 wood, 200 nails, 100 stones.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 500 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 100)
	{
		doYesNo(doBuildStructure, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function doBuildStructure():void {
	var helpers:int = 0;
	var helperArray:Array = [];
	if (marblehelper.marbleFollower()) {
		helperArray[helperArray.length] = "Marble";
		helpers++;
	}
	if (helhelper.followerHel()) {
		helperArray[helperArray.length] = "Helia";
		helpers++;
	}
	if (kihahelper.followerKiha()) {
		helperArray[helperArray.length] = "Kiha";
		helpers++;
	}
	if (flags[kFLAGS.ANT_KIDS] > 100) {
		helperArray[helperArray.length] = "group of your ant children";
		helpers++;
	}
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 500;
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 100;
	clearOutput();
	outputText("You proceed to build the structure of the shrine. You lose track of time as you work at building Taoth a proper place of prayer. ");
	flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] += 1;
	outputText("\n\nSeveral hours later the building is finally ready, although you are completely exhausted.");
	if (helpers > 0) {
		outputText("\n\n" + formatStringArray(helperArray));
		outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with building, helping to speed up the process and make it less fatiguing.");
	}
	//Gain fatigue.
	var fatigueAmount:int = 300;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 50) fatigueAmount = 50;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only four hours!");
		doNext(camp.returnToCampUseFourHours);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only six hours!");
		doNext(camp.returnToCampUseSixHours);
	}
	else {
		outputText("\n\nIt's " + (fatigueAmount >= 150 ? "a daunting" : "an easy") + " task but you eventually manage to finish it.");
		doNext(camp.returnToCampUseEightHours);
	}
}
public function buildAltair():void {
	outputText("Do you start work on building the structure? (Cost: 200 wood and 100 nails)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 200)
	{
		doYesNo(doBuildAltair, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function doBuildAltair():void {
	var helpers:int = 0;
	var helperArray:Array = [];
	if (marblehelper.marbleFollower()) {
		helperArray[helperArray.length] = "Marble";
		helpers++;
	}
	if (helhelper.followerHel()) {
		helperArray[helperArray.length] = "Helia";
		helpers++;
	}
	if (kihahelper.followerKiha()) {
		helperArray[helperArray.length] = "Kiha";
		helpers++;
	}
	if (flags[kFLAGS.ANT_KIDS] > 100) {
		helperArray[helperArray.length] = "group of your ant children";
		helpers++;
	}
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 200;
	clearOutput();
	outputText("You build an altar for your shrine. ");
	flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] += 1;
	outputText("\n\nIt takes a while, but before nighttime your work is finished.");
	if (helpers > 0) {
		outputText("\n\n" + formatStringArray(helperArray));
		outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with building, helping to speed up the process and make it less fatiguing.");
	}
	//Gain fatigue.
	var fatigueAmount:int = 200;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 30) fatigueAmount = 30;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only hour!");
		doNext(camp.returnToCampUseFourHours);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only two hours!");
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("\n\nIt's " + (fatigueAmount >= 75 ? "a daunting" : "an easy") + " task but you eventually manage to finish it.");
		doNext(camp.returnToCampUseFourHours);
	}
}
public function kitsuneshrine2():void {
	clearOutput();
	outputText("You place the statue on the altar, already feeling Taoth's powers coalescing around the shrine like a thick fog.");
	player.consumeItem(useables.GLDSTAT);
	flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] += 1;
	doNext(playerMenu);
}

//Hot Spring Upgrade
public function hotspring():void {
	clearOutput();
	if (player.fatigue <= player.maxFatigue() - 100)
	{
		if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 2) { 
			digApool();
			return; 
		}
		if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 3) { 
			addAWoodenWalls();
			return;
		}
	}
	else
	{	
		outputText("You are too exhausted to work on hot spring!");
		doNext(playerMenu);
	}
}
public function digApool():void {
	outputText("Do you start work on digging the pool? (Cost: 500 stones.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 500)
	{
		doYesNo(doDigAPoolWork, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function doDigAPoolWork():void {
	var helpers:int = 0;
	var helperArray:Array = [];
	if (marblehelper.marbleFollower()) {
		helperArray[helperArray.length] = "Marble";
		helpers++;
	}
	if (helhelper.followerHel()) {
		helperArray[helperArray.length] = "Helia";
		helpers++;
	}
	if (kihahelper.followerKiha()) {
		helperArray[helperArray.length] = "Kiha";
		helpers++;
	}
	if (flags[kFLAGS.ANT_KIDS] > 100) {
		helperArray[helperArray.length] = "group of your ant children";
		helpers++;
	}
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 500;
	clearOutput();
	outputText("You proceed to dig a proper pool and line it and the border with rocks.");
	flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] += 1;
	outputText("\n\nA few hour later the bathing area is steamy and ready for use.");
	if (helpers > 0) {
		outputText("\n\n" + formatStringArray(helperArray));
		outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with digging, helping to speed up the process and make it less fatiguing.");
	}
	//Gain fatigue.
	var fatigueAmount:int = 100;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only one hour!");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only two hours.");
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("\n\nIt's " + (fatigueAmount >= 75 ? "a daunting" : "an easy") + " task but you eventually manage to finish digging it.");
		doNext(camp.returnToCampUseFourHours);
	}
}
public function addAWoodenWalls():void {
	outputText("Do you start work on addine wooden walls? (Cost: 500 wood.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 500)
	{
		doYesNo(doAddAWoodenWallsWork, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function doAddAWoodenWallsWork():void {
	var helpers:int = 0;
	var helperArray:Array = [];
	if (marblehelper.marbleFollower()) {
		helperArray[helperArray.length] = "Marble";
		helpers++;
	}
	if (helhelper.followerHel()) {
		helperArray[helperArray.length] = "Helia";
		helpers++;
	}
	if (kihahelper.followerKiha()) {
		helperArray[helperArray.length] = "Kiha";
		helpers++;
	}
	if (flags[kFLAGS.ANT_KIDS] > 100) {
		helperArray[helperArray.length] = "group of your ant children";
		helpers++;
	}
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 500;
	clearOutput();
	outputText("You start building some cover, so you can actually enjoy bathing without having to worry about potential voyeurs.");
	flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] += 1;
	outputText("\n\nIt takes a few hours, but eventually your wall is finally done.");
	if (helpers > 0) {
		outputText("\n\n" + formatStringArray(helperArray));
		outputText(" " + (helpers == 1 ? "assists" : "assist") + " you with making a wooden wall, helping to speed up the process and make it less fatiguing.");
	}
	//Gain fatigue.
	var fatigueAmount:int = 100;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigueAmount /= (helpers + 1);
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	if (helpers >= 2) {
		outputText("\n\nThanks to your assistants, the construction takes only one hour!");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (helpers == 1) {
		outputText("\n\nThanks to your assistant, the construction takes only two hours.");
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("\n\nIt's " + (fatigueAmount >= 75 ? "a daunting" : "an easy") + " task but you eventually manage to finish making a wooden wall.");
		doNext(camp.returnToCampUseFourHours);
	}
}

//Sparring Ring Upgrade
public function sparringRing():void {
	clearOutput();
	if (player.fatigue <= player.maxFatigue() - 50)
	{
		if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 1) { 
			buildSmallRing();
			return;
		}/*
		if (flags[kFLAGS.] == 2) { 
			digApool() 
			return; 
		}
		if (flags[kFLAGS.] == 3) { 
			addAWoodenWalls() 
			return; 
		}*/
	}
	else
	{	
		outputText("You are too exhausted to work on sparring ring!");
		doNext(playerMenu);
	}
}
public function buildSmallRing():void {
	outputText("Do you start work on making sparring ring? (Cost: 50 wood.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 50)
	{
		doYesNo(doBuildSmallRing, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function doBuildSmallRing():void {
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 50;
	clearOutput();
	outputText("You consider the many people who reside in the camp and realise you could spar with them if you had a ring for it. You proceed to get a rope and some wooden sticks, then build a small provisory ring for your daily sparring matches.");
	flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] += 1;
	outputText("\n\nYou work most of the day on this project but by the end the hole is dug and the ring is made!");
	//Gain fatigue.
	var fatigueAmount:int = 50;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	fatigue(fatigueAmount);
	doNext(camp.returnToCampUseFourHours);
}

//Arcane Circle Upgrade
public function arcaneCircle():void {
	clearOutput();
	if (player.fatigue <= player.maxFatigue() - 50)
	{
		if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] < 1) { 
			buildFirstArcaneCircle();
			return; 
		}
		if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 1) { 
			if (player.findPerk(PerkLib.ElementalContractRank4) >= 0) {
				buildSecondArcaneCircle();
				return; 
			}
			else {
				outputText("You lack the proper knowledge and skill to work on this new ritual circle yet!");
				doNext(playerMenu);
			}
		}
		if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 2) { 
			if (player.findPerk(PerkLib.ElementalContractRank8) >= 0) {
				buildThirdArcaneCircle();
				return;
			}
			else {
				outputText("You lack the proper knowledge and skill to work on this new ritual circle yet!");
				doNext(playerMenu);
			}
		}/*
		if (flags[kFLAGS.] == 3) { 
			addAWoodenWalls() 
			return; 
		}*/
	}
	else
	{	
		outputText("You are too exhausted to work on this new ritual circle yet!");
		doNext(playerMenu);
	}
}
public function buildFirstArcaneCircle():void {
	outputText("Do you start work on making first arcane circle? (Cost: 4 stones, 75 HP and 100 mana.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 4 && player.HP >= 75 && player.mana >= 100)
	{
		doYesNo(doBuildFirstArcaneCircle, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function doBuildFirstArcaneCircle():void {
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 4;
	clearOutput();
	outputText("You get to building your arcane circle. You set a stone at each of the four cardinal point and draw a perfect circle with the blood. That done you inscribe the runes meant to facilitate the chosen entity passage to mareth punctuating each scribing with a word of power. After several hours of hard work your arcane circle is finally done ready to be used to summon various entity to mareth.");
	flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] = 1;
	//Gain fatigue.
	var fatigueAmount:int = 50;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	outputText("\n\n");
	HPChange(-75, true);
	fatigue(fatigueAmount);
	useMana(100);
	doNext(camp.returnToCampUseEightHours);
}
public function buildSecondArcaneCircle():void {
	outputText("Do you start work on making second arcane circle? (Cost: 8 stones, 150 HP and 200 mana.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 8 && player.HP >= 150 && player.mana >= 200)
	{
		doYesNo(doBuildSecondArcaneCircle, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function doBuildSecondArcaneCircle():void {
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 8;
	clearOutput();
	outputText("You decide to upgrade your circle in order to contain a stronger being should the binding ritual fail. You draw a second larger circle around the smaller one inscribing additional protections and ward. Satisfied you nod at the result.");
	flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] += 1;
	outputText(" \"<b>You can now perform the rituals to release more of your minions powers!</b>\"");
	//Gain fatigue.
	var fatigueAmount:int = 50;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	outputText("\n\n");
	HPChange(-150, true);
	fatigue(fatigueAmount);
	useMana(200);
	doNext(camp.returnToCampUseEightHours);
}
public function buildThirdArcaneCircle():void {
	outputText("Do you start work on making third arcane circle? (Cost: 12 stones, 225 HP and 300 mana.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 12 && player.HP >= 225 && player.mana >= 300)
	{
		doYesNo(doBuildThirdArcaneCircle, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function doBuildThirdArcaneCircle():void {
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 12;
	clearOutput();
	outputText("You decide to upgrade your circle in order to contain a stronger being should the binding ritual fail. You draw a third larger circle around the smaller one inscribing additional protections and ward. Satisfied you nod at the result.");
	flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] += 1;
	outputText(" \"<b>You can now perform the rituals to release more of your minions powers!</b>\"");
	//Gain fatigue.
	var fatigueAmount:int = 50;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	outputText("\n\n");
	HPChange(-225, true);
	fatigue(fatigueAmount);
	useMana(300);
	doNext(camp.returnToCampUseEightHours);
}

//Magic Ward Upgrade
public function magicWard():void {
	clearOutput();
	if (player.fatigue <= player.maxFatigue() - 200)
	{
		if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 1) { 
			setUpMagicWard();
			return;
		}
	}
	else
	{	
		outputText("You are too exhausted to work on magic ward!");
		doNext(playerMenu);
	}
}
public function setUpMagicWard():void {
	outputText("You’re confident that with the warding tome as reference, you could build a ward to help keep your camp safe from lesser threats, possibly even demons.  Shall you construct the ward? (Cost: 30 stones.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 30)
	{
		doYesNo(setUpMagicWard2, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function setUpMagicWard2():void {
	flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 30;
	clearOutput();
	outputText("You flip through the tome, and begin to sketch copies of the required glyphs in the dirt.  Yes, this is definitely possible.  You have something ");
	if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) outputText("Tel’Adre doesn’t");
	else outputText("most mages wouldn’t");
	outputText(" the portal.  The ambient energy radiating from it could power the ward, as long as you get the web of magic working properly.  It takes hours, a great deal of stress and a lot of channeling to get the stones to their positions, carved into shape and infused with the requisite runes.  ");
	flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] += 1;
	if (model.time.hours >= 12) outputText("By the time you’re done, it's already dark.");
	else outputText("By the time you’re done, the sun is beginning to droop in the sky.");
	outputText("  But with these warding stones up and running, nothing should chance upon your camp unless it has business there.");
	player.removeKeyItem("Warding Tome");
	//Gain fatigue.
	var fatigueAmount:int = 200;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	doNext(camp.returnToCampUseEightHours);
}

//Dam Upgrade
public function dam():void {
	clearOutput();
	if (flags[kFLAGS.CAMP_UPGRADES_DAM] < 1 && player.fatigue <= player.maxFatigue() - 200) { 
		buildUpMinorWoodDam();
		return;
	}
	if (flags[kFLAGS.CAMP_UPGRADES_DAM] == 1 && player.fatigue <= player.maxFatigue() - 400) { 
		buildUpWoodDam();
		return; 
	}
	if (flags[kFLAGS.CAMP_UPGRADES_DAM] == 2 && player.fatigue <= player.maxFatigue() - 600) { 
		buildUpMajorWoodDam();
		return; 
	}/*
	if (flags[kFLAGS.CAMP_UPGRADES_DAM] == 3 && player.fatigue <= player.maxFatigue() - 800) { 
		buildUpMinorStoneDam();
		return; 
	}*/
	else
	{	
		outputText("You are too exhausted to work on dam!");
		doNext(playerMenu);
	}
}
public function buildUpMinorWoodDam():void {
	outputText("Do you start work on building small wood dam? (Cost: 200 nails, 300 wood.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 300)
	{
		doYesNo(buildUpMinorWoodDam2, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function buildUpMinorWoodDam2():void {
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 300;
	clearOutput();
	outputText("You get down to work building the dam plank by plank. At first it proves to be a challenge to the running water. But you eventually manage to build the structure in full your dam allowing to increase the stream size.");
	flags[kFLAGS.CAMP_UPGRADES_DAM] = 1;
	//Gain fatigue.
	var fatigueAmount:int = 200;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	doNext(camp.returnToCampUseEightHours);
}
public function buildUpWoodDam():void {
	outputText("Do you start work on upgrading your small wood dam? (Cost: 250 nails, 375 wood.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 250 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 375)
	{
		doYesNo(buildUpWoodDam2, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function buildUpWoodDam2():void {
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 250;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 375;
	clearOutput();
	outputText("You get down to work expanding the dam plank by plank starting from sides. At first it goes slowly but you eventualy speed up, to slow down again near end of the work. New taller and wider dam starts to accumulative water to form something between steam and miniature narrow shaped lake.");
	flags[kFLAGS.CAMP_UPGRADES_DAM] = 2;
	//Gain fatigue.
	var fatigueAmount:int = 400;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 40;
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	doNext(camp.returnToCampUseEightHours);
}
public function buildUpMajorWoodDam():void {
	outputText("Do you start work on upgrading your wood dam? (Cost: 300 nails, 450 wood.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 300 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 450)
	{
		doYesNo(buildUpMajorWoodDam2, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function buildUpMajorWoodDam2():void {
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 300;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 450;
	clearOutput();
	outputText("You get down to work on expanding the dam for the second time like the last time putting planks on the sides first. It progress slowly until you put last ones on the top of dam. Tired but satisfied with your work you look how previous widened steam due to higher water accumulation turn into proper miniature yet very narrow mini lake.");
	flags[kFLAGS.CAMP_UPGRADES_DAM] = 3;
	//Gain fatigue.
	var fatigueAmount:int = 600;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 60;
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	doNext(camp.returnToCampUseEightHours);
}

//Fishery Upgrade
public function fishery():void {
	clearOutput();
	if (player.fatigue <= player.maxFatigue() - 200)
	{
		if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] < 1) { 
			buildUpFishery1();
			return;
		}
		if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 1) { 
			if (flags[kFLAGS.CAMP_UPGRADES_DAM] >= 2) {
				buildUpFishery2();
				return;
			}
			else {
				outputText("You need to expand your dam more before you can expand your fishery!");
				doNext(playerMenu);
			}
		}
		//3 stopień rozbudowy na 5 stopniu tamy (2 st. kamiennej tamy) a 4 stopień na 7 stopniu tamy (4 st. kamiennej)
	}
	else
	{	
		outputText("You are too exhausted to work on fishery!");
		doNext(playerMenu);
	}
}
public function buildUpFishery1():void {
	outputText("Do you start work on building fishery? (Cost: 200 nails, 300 wood.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 300)
	{
		doYesNo(buildUpFishery1Yes, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function buildUpFishery1Yes():void {
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 300;
	clearOutput();
	outputText("You spend a 8 hours hammering nail and building your fishery. At the end of it you look at the result with pride. Time to have someone on fishing duty.");
	flags[kFLAGS.CAMP_UPGRADES_FISHERY] = 1;
	flags[kFLAGS.FISHES_STORED_AT_FISHERY] = 0;
	//Gain fatigue.
	var fatigueAmount:int = 200;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	doNext(camp.returnToCampUseEightHours);
}
public function buildUpFishery2():void {
	outputText("Do you start work on building fishery? (Cost: 300 nails, 450 wood.)\n");
	checkMaterials();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 300 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 450)
	{
		doYesNo(buildUpFishery2Yes, noThanks);
	}
	else
	{
		errorNotEnough();
		doNext(playerMenu);
	}
}
private function buildUpFishery2Yes():void {
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 300;
	flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 450;
	clearOutput();
	outputText("You spend a 8 hours hammering nail and expanding your fishery. At the end of it you look at the result with pride. Now you can have two people on fishing duty.");
	flags[kFLAGS.CAMP_UPGRADES_FISHERY] = 2;
	//Gain fatigue.
	var fatigueAmount:int = 200;
	fatigueAmount -= player.str / 5;
	fatigueAmount -= player.tou / 10;
	fatigueAmount -= player.spe / 10;
	if (player.findPerk(PerkLib.IronMan) >= 0) fatigueAmount -= 20;
	if (fatigueAmount < 10) fatigueAmount = 10;
	fatigue(fatigueAmount);
	doNext(camp.returnToCampUseEightHours);
}

public function errorNotEnough():void {
	outputText("\n\n<b>You do not have sufficient resources. You may buy more nails, wood, stones from the carpentry shop in Tel'Adre or find other sources of this materials. It's also possible you lack some of more exotic things.</b>")		
}

public function noThanks():void {
	outputText("Deciding not to work on building a new structure right now, you return to the center of your camp.");
	doNext(playerMenu);
}

public function checkMaterials():void {
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2) { 
	outputText("Nails: " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/600" + " \n");
	}
	else { 
	outputText("Nails: " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/200" + " \n");
	}
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) {
	outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/900" + "\n");
	}
	else {
	outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/300" + "\n");
	}
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4) {
	outputText("Stone: " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/900" + "\n");
	}
	else {
	outputText("Stone: " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/300" + "\n");
	}
}



// Page 1

// button 0 - material gathering storage upgrade
// button 1 - warehouse/granary/?stone enhanced version of warehouse and granary?
// button 2 - Rat lab upgrade/better rest place for rat+mouse-morphs/?Vapula lab upgrade?/Small stone shrine for Jojo or Joy/?upgrade all previous structures to stone lvl?
// button 3 - central camp nursery instead many individual ones?
// button 4 - next page
// button 5 - Phylla cave upgrades - better bed/using wood to make more stable tunnels and having few ranks of this upgrade (?limit max ant children depending on current rank of this upgrade?)
// button 6 - Ember cave upgrades - better bed/?magic loot gathering place?
// button 7 - cabin for camp cow-morphs (Marble+Izzy?+Clara?)
// button 8 - ...
// button 10 - living place for Kiha+Sophie?+Vapula?
// button 11 - using wood making small dam on steam near camp to form small pond/pool/mini lake for camp members users - using later stones to make dam better increasing amount of gathered water
// button 12 - ...
// button 13 - ...
// button 14 - Back

// Page 2

// ?button 0 - Izma rest place upgrades?
// ?button 1 - Milk Slut rest place upgrades?
// ?button 2 - Latex Goo-Girl rest place upgrades?
// ?button 3 - Arian Tent changes?
// ?button 5 - Kid A barrel changes?
// ?button 6 - Behemoth lair upgr?
// ?button 7 - Lith lair upgr? (Rycharde corr drider slave)
// ?button 8 - Kimika(Kindra) living place upgr? (Adorable Sheep-morph archer with "a slight issue" ^^)
// button 9 - previous page
// ?button 10 - Helia + Helspawn living place?
// button 14 - back

}
}