/**
 * Upgrade to PC camp aside walls and cabin.
 * @author Ormael
 */
package classes.Scenes.Camp {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.BaseContent;
import classes.Scenes.SceneLib;

public class CampUpgrades extends BaseContent {

    public static function builtAnything():Boolean {
        return flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10
            || flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3
            || flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 2
            || flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 1
            || flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100
            || flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] >= 4
            || flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2;
    }

    /*
    flags[kFLAGS.MATERIALS_STORAGE_UPGRADES]:
    01 - Toolbox bought
    02 - Nails box bought
    03 - Wood storage built
    04 - Stone storage built
    05 - Stone constructions guide bought
    ?06 - expanding Wood storage?
    ?07 - expanding Stones storage?
    ?08 - expanding Nails storage?
    ?09 - Sand storage built?
    ?10 - water cystern or req. dam be high enough expanded to provide water in unlimited amount as if needed?
    ?11 - Concrete storage built (unless building won't be req. so much of it to need another storage ^^ or just make one storage that will increase slightly both sand and concrete store space)?
    ?(12 - Possible special materials storage/and or addidtional building guide for specific structures (fireproof dweeling that even with stones and concrete isn't enough?))?
	?xx- metal plates storage, mechanisms, energy core storages?

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
    3 - build altar
    4 - get Taoth statue

    flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS]:
    1 - chance to proc find a spot
    2 - find the spot
    3 - dig a pool
    4 - add the wood walls
    ?5 - expanding hot springs?

    flags[kFLAGS.CAMP_UPGRADES_SPARING_RING]:
    1 - unlocking building ring
    2 - ring build (small) - 6x training time for npc's
    3 - ring build (large) - 5x training time for npc's
    4 - ring build (massive) - 4x training time for npc's
    5 - ring build (massive w/ wood floor) - 3x training time for npc's
    6 - ring build (massive w/ stone floor) - 2x training time for npc's	/NYI
    7 - ring build (collosal w/ stone floor) - 1x training time for npc's	/NYI

    flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE]:
    1 - first arcane circle
    2 - second arcane circle
    3 - third arcane circle
    4 - fourth arcane circle
    5 - fifth arcane circle
    6 - sixth arcane circle
    7 - seventh arcane circle
    8 - eighth arcane circle

    flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD]:
    1 - readed Warding Tome
    2 - builded Ward / Inactive Ward
    3 - Active Ward
    ?4 - ugrade magic ward to better protect camp?
    ?5 - upgade range of protection of ward?

    flags[kFLAGS.CAMP_UPGRADES_DAM]:
    1 - minor wood dam
    2 - wood dam
    3 - major wood dam
    4 - minor stone dam	/NYI
    5 - major stone dam	/NYI

    flags[kFLAGS.CAMP_UPGRADES_FISHERY]:
    1 - fishery (grade 1)
    2 - fishery (grade 2)
    2 - fishery (grade 3)	/NYI

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
        if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 1 || flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 2) addButton(0, "Wood Storage", materialgatheringstorageupgrade).hint("Build up storage to gather more wood at the camp. (Req. "+usedFatigue(150, true)+" fatigue)");
        if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 3) addButton(0, "Stone Storage", materialgatheringstorageupgrade).hint("Build up storage to gather more stones at the camp. (Req. "+usedFatigue(150, true)+" fatigue)");
        if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 0 || flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 1) addButton(1, "1st Warehouse", warehousegranary).hint("Build 1st part of the Warehouse to expand your storage space. (Req. "+usedFatigue(250, true)+" fatigue)");
        if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 2 || flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 3) addButton(1, "Granary", warehousegranary).hint("Build Granary to expand your food space. (Req. "+usedFatigue(250, true)+" fatigue)");
        if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 4 || flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 5) addButton(1, "2nd Warehouse", warehousegranary).hint("Build 2nd part of the Warehouse to expand your storage space. (Req. "+usedFatigue(250, true)+" fatigue)");
        if ((player.isRace(Races.KITSUNE, 1, false) || player.isRace(Races.KITSHOO, 1, false)) && (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] < 1 || flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 1 || flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 2)) addButton(2, "Shrine", kitsuneshrine).hint("Build up kitsune shrine at the camp. (Req. "+usedFatigue(200)+"~"+usedFatigue(300)+" fatigue)");
        if (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 3) {
            if (!(player.hasItem(useables.GLDSTAT))) addButtonDisabled(2, "Shrine", "You need to have Kitsune Statue and your own Star Sphere to finish the shrine!");
            if (!player.hasPerk(PerkLib.StarSphereMastery)) addButtonDisabled(2, "Shrine", "You need to have Kitsune Statue and your own Star Sphere to finish the shrine!");
            if (player.hasPerk(PerkLib.StarSphereMastery) && player.hasItem(useables.GLDSTAT)) addButton(2, "Shrine", kitsuneshrine2).hint("Finish up kitsune shrine at the camp.");
        }
        if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 2 || flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 3) addButton(3, "Hot Spring", hotspring).hint("Build up hot spring at the camp. (Req. "+usedFatigue(100, true)+" fatigue)");
        if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 0) {
            //if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 7) addButton(4, "Sparring Ring", sparringRing).hint("Expand your stone sparing ring to collosal size. (Decrease npc's training time by 1/2 and increase exp from using training dummy by 500% more (1500% of base amount))(Req. "+usedFatigue(12150, true)+" fatigue)");
            //if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 6) addButton(4, "Sparring Ring", sparringRing).hint("Replace wood with stone. (Decrease npc's training time by 1/3 and increase exp from using training dummy by 300% more (1000% of base amount))(Req. "+usedFatigue(4050, true)+" fatigue)");
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 5) addButton(4, "Sparring Ring", sparringRing).hint("Add wood floor to sparring ring for better training experience. (Decrease npc's training time by 1/4 and increase exp from using training dummy by 250% more (700% of base amount))(Req. "+usedFatigue(1350, true)+" fatigue)");
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 4) addButton(4, "Sparring Ring", sparringRing).hint("Expand sparring ring to massive size. (Decrease npc's training time by 1/5 and increase exp from using training dummy by another 200% (450% of base amount))(Req. "+usedFatigue(450, true)+" fatigue)");
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 3) addButton(4, "Sparring Ring", sparringRing).hint("Expand sparring ring to large size. (Decrease npc's training time by 1/6 and increase exp from using training dummy by 150% (250% of base amount))(Req. "+usedFatigue(150, true)+" fatigue)");
            if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2) addButton(4, "Sparring Ring", sparringRing).hint("Build up sparring ring at the camp. (Unlock sparring option for all camp members that have this option)(Req. "+usedFatigue(50, true)+" fatigue)");
        }
        if (player.hasPerk(PerkLib.JobElementalConjurer) && flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] < 8) addButton(5, "Arcane Circle", arcaneCircle).hint("Build an arcane circle at the camp OR add another circle to it. (Unlock elementals summons/rank up related options)(Req. 50 fatigue, enough stones, mana and blood)");
        if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 1) addButton(6, "Elemental E. C.", arcaneCircleUpgrade).hint("Add Elemental Energy Conduits to your arcane circle to store in them elemental energy stored in elementals shards for more easy use. (Allowing to replace mana and reduce fatigue usage when summoning/ranking up normal tier elementals. Allowing to rank up elementals of tiers above normal tier.)(Req. 50 fatigue, enough stones, mana and elemental shards)");
        if (player.inte >= 50 && flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 1) addButton(7, "Magic Ward", magicWard).hint("Set up a Magic Ward around the camp. (Req. 200 fatigue)");
        if (flags[kFLAGS.CAMP_UPGRADES_DAM] < 3) addButton(8, "Dam", dam).hint("Build up a dam on the stream next to the camp. (Req. "+usedFatigue(200, true)+" fatigue * tier of built dam)");
        if (flags[kFLAGS.CAMP_UPGRADES_DAM] >= 1 && flags[kFLAGS.CAMP_UPGRADES_FISHERY] < 2) addButton(9, "Fishery", fishery).hint("Build up a fishery on the stream next to the camp. (Req. "+usedFatigue(200, true)+" fatigue)");
        addButton(14, "Back", camp.campBuildingSim);
    }

    public function checkMaterials():void {
        outputText("Nails: " + CampStatsAndResources.NailsResc + "/" + checkMaterialsCapNails() + "\n");
        outputText("Wood: " + CampStatsAndResources.WoodResc + "/" + checkMaterialsCapWood() + "\n");
        outputText("Stone: " + CampStatsAndResources.StonesResc + "/" + checkMaterialsCapStones() + "\n");
    }
	
	public function checkMaterialsCapNails():Number {
		var cMC1:Number = 250;
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2) cMC1 += 750;
		return cMC1;
	}
	public function checkMaterialsCapWood():Number {
		var cMC1:Number = 400;
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) cMC1 += 1200;
		return cMC1;
	}
	public function checkMaterialsCapStones():Number {
		var cMC1:Number = 400;
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4) cMC1 += 1200;
		return cMC1;
	}

    private function getHelpers():Object {
        var helpers:Object = {
            count: 0,
            names: ""
        };
        var helperArray:Array = [];
        if (flags[kFLAGS.ANT_KIDS] > 100) {
            helperArray[helperArray.length] = "A group of your ant children";
            helpers.count++;
        }
        if (SceneLib.marbleScene.marbleFollower()) {
            helperArray[helperArray.length] = "Marble";
            helpers.count++;
        }
        if (SceneLib.helFollower.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff)) {
            helperArray[helperArray.length] = "Helia";
            helpers.count++;
        }
        if (SceneLib.kihaFollower.followerKiha()) {
            helperArray[helperArray.length] = "Kiha";
            helpers.count++;
        }
        if (flags[kFLAGS.AURORA_LVL] >= 1) {
            helperArray[helperArray.length] = "Aurora";
            helpers.count++;
        }
        if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] >= 5) {
			helperArray[helperArray.length] = "A group of your stone golems";
			helpers.count++;
        }
        helpers.names = formatStringArray(helperArray);
        return helpers;
    }

    private function buildWithHelpers(baseFatigue:int, mummies:Boolean = false, timeWithout:int = 4, timeWithOne:int = 2, timeWithMore:int = 1):void {
        function formatTime(hrs:int):String {
            return hrs > 1 ? NUMBER_WORDS_NORMAL[hrs] + " hours" : "one hour";
        }

        var helpers:Object = getHelpers();
        useFatigue(baseFatigue, helpers.count, mummies);
        if (helpers.count > 0) {
            outputText("\n\n" + helpers.names);
            outputText(" " + (helpers.count == 1 ? "assists" : "assist") + " you, helping to speed up the process and make it less fatiguing.");
        }
        if (helpers.count >= 2) {
            outputText("\n\nThanks to your assistants, the construction takes only " + formatTime(timeWithMore) + "!");
            doNext(camp.returnToCamp, timeWithMore);
        } else if (helpers.count == 1) {
            outputText("\n\nThanks to your assistant, the construction takes only " + formatTime(timeWithOne) + ".");
            doNext(camp.returnToCamp, timeWithOne);
        } else {
            outputText("\n\nIt's a daunting task but you eventually manage to finish it in " + formatTime(timeWithout) + ".");
            doNext(camp.returnToCamp, timeWithout);
        }
    }

    private function useFatigue(base:int, helpersCount:int = 0, mummies:Boolean = false):void {
        var fatigueAmount:int = base;
        fatigueAmount -= player.str / 5;
        fatigueAmount -= player.tou / 10;
        fatigueAmount -= player.spe / 10;
        if (player.hasPerk(PerkLib.IronMan)) fatigueAmount -= 20;
        if (player.hasPerk(PerkLib.ZenjisInfluence3)) fatigueAmount -= 10;
        fatigueAmount /= (helpersCount + 1);
        fatigueAmount = Math.round(fatigueAmount);
        if (fatigueAmount < 10) fatigueAmount = 10;
		if (mummies && player.hasPerk(PerkLib.MummyLord) && player.perkv1(PerkLib.MummyLord) > 0) {
			if (player.perkv1(PerkLib.MummyLord) > 19) fatigueAmount = 0;
			else fatigueAmount = Math.round(fatigueAmount*(1/player.perkv1(PerkLib.MummyLord)));
		}
        fatigue(fatigueAmount);
    }
	private function usedFatigue(base:int, mummies:Boolean = false):Number {
		var baseFatigue:Number = base;
		var helpers:Object = getHelpers();
        baseFatigue -= player.str / 5;
        baseFatigue -= player.tou / 10;
        baseFatigue -= player.spe / 10;
        if (player.hasPerk(PerkLib.IronMan)) baseFatigue -= 20;
        if (player.hasPerk(PerkLib.ZenjisInfluence3)) baseFatigue -= 10;
        if (helpers.count > 0) baseFatigue /= (helpers.count + 1);
		baseFatigue = Math.round(baseFatigue);
        if (baseFatigue < 10) baseFatigue = 10;
		if (mummies && player.hasPerk(PerkLib.MummyLord) && player.perkv1(PerkLib.MummyLord) > 0) {
			if (player.perkv1(PerkLib.MummyLord) > 19) baseFatigue = 0;
			else baseFatigue = Math.round(baseFatigue*(1/player.perkv1(PerkLib.MummyLord)));
		}
		return baseFatigue;
	}

    //Materials Storages Upgrade
    public function materialgatheringstorageupgrade():void {
        clearOutput();
        if (player.fatigue <= player.maxOverFatigue() - usedFatigue(150, true)) {
            if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 1) neednailsbox();
            else if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 2) startWoodStorage();
            else if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 3) startStoneStorage();
        } else {
            outputText("You are too exhausted to work on expanding your materials' storage!");
            doNext(playerMenu);
        }
    }

    public function neednailsbox():void {
        outputText("When you opening book from your toolbox on the page describing how to build properly storage for wood you realize amount of nails that will be needed is much more than your toolbox can keep.  Damn if you would like to build this structure you would spend much of the time on walking to the carpenter shop in Tel'Adre to buy missing nails unless... there is some way to be able to store more than 200 nails.  With thoughts that maybe carpenter shopkeeper will help with this issue, you put back book.");
        doNext(playerMenu);
    }

    public function startWoodStorage():void {
        outputText("Do you start work on building wood storage? (Cost: 250 nails, 250 wood and 100 stones.)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 250 && CampStatsAndResources.WoodResc >= 250 && CampStatsAndResources.StonesResc >= 100) {
            doYesNo(doWoodStorageWork, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doWoodStorageWork():void {
        CampStatsAndResources.NailsResc -= 250;
        CampStatsAndResources.WoodResc -= 250;
        CampStatsAndResources.StonesResc -= 100;
        clearOutput();
        outputText("You pull out \"Carpenter's Guide\" and flip pages until you come across instructions on how to build storage for woods. You spend few minutes looking at the instructions.");
        flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] += 1;
        outputText("\n\nYou take the wood, saw it and then cut into planks. You put four long and thick wood posts as base, then you connect them with nails. Next you cut few posts into short fragments and impale at the edges. Inside of prepared frame you put few large wood logs that you fix in place with a few short wood desks and stones. After that last part of building is to put all rest wood planks on prepared base and nail them in place.");
        buildWithHelpers(150, true);
    }

    public function startStoneStorage():void {
        outputText("Do you start work on building stone storage? (Cost: 350 nails, 400 wood and 200 stones.)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 350 && CampStatsAndResources.WoodResc >= 400 && CampStatsAndResources.StonesResc >= 200) {
            doYesNo(doStoneStorageWork, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doStoneStorageWork():void {
        CampStatsAndResources.NailsResc -= 350;
        CampStatsAndResources.WoodResc -= 400;
        CampStatsAndResources.StonesResc -= 200;
        clearOutput();
        outputText("You pull out \"Carpenter's Guide\" and flip pages until you come across instructions on how to build storage for stones. You spend few minutes looking at the instructions.");
        flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] += 1;
        outputText("\n\nYou take the wood, saw it and then cut into planks. Like before you put four long and thick wood posts as base, then you connect them with nails. Next you cut few posts into short fragments and impale at the edges. Inside of prepared frame you put few large wood logs that you fix in place with a few short wood desks and stones. Rest of the stones fill the space inside due to need in future support weight of stones stored above. After that prelast part of building is to put all most of remaining wood planks on prepared base and nail them in place. Final thing to do is use remain wood and nails to make protective barrier around the whole storage.");
        buildWithHelpers(150, true);
        outputText("\n\nNow you can safely store a larger amount of stones!");
        flushOutputTextToGUI();
    }

    //Warehouse + Granary Upgrade
    public function warehousegranary():void {
        clearOutput();
        if (player.fatigue <= player.maxOverFatigue() - usedFatigue(250, true)) {
            if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 0) start1stWarehouse1();
            else if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 1) startWarehouse2();
            else if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 2) startGranary1();
            else if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 3) startGranary2();
            else if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 4) start2ndWarehouse1();
            else if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 5) startWarehouse2();
        } else {
            outputText("You are too exhausted to work on constructing your storage building!");
            doNext(playerMenu);
        }
    }

    public function start1stWarehouse1():void {
        outputText("Do you start work on building warehouse frame and walls? (Cost: 200 nails, 100 wood and 40 stones.)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.WoodResc >= 100 && CampStatsAndResources.StonesResc >= 40) {
            doYesNo(doWarehouse1Work, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function printLazyWriting(building:String):void {
        outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build a "+building+". You spend few minutes looking at the instructions.");
        outputText("\n\nYou pick up a log from a nearby pile and saw it into a rectangular plank, fit to be used for the base of your future "+building+".  You lay out the foundation, rooting in planks, and leaving open corners for the thick logs that will be the corners of the building.");
        outputText("\nAs you begin to connect their tops to make the floor the real work begins, nailing planks together, fitting everything into place.  After a few hours of hard labor the foundation is complete and you wipe the sweat off your brow, tapping a foot on your work and letting out a breath of air.");
        outputText("\nFor the last bit of work you get the frame of the building itself into place with a lot of elbow grease and brute strength, they don't call you the champion for nothing!");
        outputText("\nRapping a knuckle against the walls you're filled with pride of your hard work, though it still needs a roof and actual flooring, but that can wait until tomorrow, you're pretty beat…");
    }

    private function doWarehouse1Work():void {
        CampStatsAndResources.NailsResc -= 200;
        CampStatsAndResources.WoodResc -= 100;
        CampStatsAndResources.StonesResc -= 40;
        flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
        clearOutput();
        printLazyWriting("warehouse");
        buildWithHelpers(250, true);
    }

    public function startWarehouse2():void {
        outputText("Do you start work on building warehouse roof and floor? (Cost: 400 nails, 300 wood and 140 stones.)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 400 && CampStatsAndResources.WoodResc >= 300 && CampStatsAndResources.StonesResc >= 140) {
            doYesNo(doWarehouse2Work, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }
    
    private function printLazyWriting2(building:String):void {
        outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build a "+building+". You spend a few minutes looking at the instructions.");
        outputText("As before, you prepare some wood planks. Constructing temporally ladder, you use it to get on top of the construction. Here, one by one, you nail the prepared wood pieces to form a simple roof. After it's finished, you get down and entering inside. Putting wood logs in places, you fill rest of the space with stones to make sure that floor will be able to deal with heavy weight. At last, you use the leftover planks to make a floor. After the work, you go out to look at your brand-new "+building+".");
    }

    private function doWarehouse2Work():void {
        CampStatsAndResources.NailsResc -= 400;
        CampStatsAndResources.WoodResc -= 300;
        CampStatsAndResources.StonesResc -= 140;
        flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
        clearOutput();
        printLazyWriting2("warehouse");
        buildWithHelpers(250, true);
        outputText("\n\n<b>You've built the " + (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 1 ? "first" : "second") + " warehouse and gained 12 inventory slots.</b>");
        flushOutputTextToGUI();
    }

    public function startGranary1():void {
        outputText("Do you start work on building granary frame and walls? (Cost: 200 nails, 125 wood and 30 stones.)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.WoodResc >= 125 && CampStatsAndResources.StonesResc >= 30) {
            doYesNo(doGranary1Work, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doGranary1Work():void {
        CampStatsAndResources.NailsResc -= 200;
        CampStatsAndResources.WoodResc -= 125;
        CampStatsAndResources.StonesResc -= 30;
        flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
        clearOutput();
        printLazyWriting("granary");
        buildWithHelpers(250, true);
    }

    public function startGranary2():void {
        outputText("Do you start work on building granary roof and floor? (Cost: 300 nails, 225 wood and 105 stones.)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 300 && CampStatsAndResources.WoodResc >= 225 && CampStatsAndResources.StonesResc >= 105) {
            doYesNo(doGranary2Work, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doGranary2Work():void {
        CampStatsAndResources.NailsResc -= 300;
        CampStatsAndResources.WoodResc -= 225;
        CampStatsAndResources.StonesResc -= 105;
        flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
        clearOutput();
        printLazyWriting2("granary");
        buildWithHelpers(250, true);
        outputText("\n\n<b>You've built a granary and gained 9 inventory slots for consumable items.</b>");
        flushOutputTextToGUI();
    }

    public function start2ndWarehouse1():void {
        outputText("Do you start work on building warehouse frame and walls? (Cost: 250 nails, 150 wood and 40 stones.)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 250 && CampStatsAndResources.WoodResc >= 150 && CampStatsAndResources.StonesResc >= 40) {
            doYesNo(doWarehouse1Work, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    //Kitsune Shrine Upgrade
    public function kitsuneshrine():void {
        clearOutput();
        if (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] < 1) findSpotForShrine();
        else if (player.fatigue <= player.maxOverFatigue() - usedFatigue(300) && flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 1) buildStructure();
        else if (player.fatigue <= player.maxOverFatigue() - usedFatigue(200) && flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 2) buildAltar();
        else {
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
        if (CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.WoodResc >= 500 && CampStatsAndResources.StonesResc >= 100) {
            doYesNo(doBuildStructure, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doBuildStructure():void {
        CampStatsAndResources.NailsResc -= 200;
        CampStatsAndResources.WoodResc -= 500;
        CampStatsAndResources.StonesResc -= 100;
        clearOutput();
        outputText("You proceed to build the structure of the shrine. You lose track of time as you work at building Taoth a proper place of prayer. ");
        flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] += 1;
        outputText("\n\nSeveral hours later the building is finally ready, although you are completely exhausted.");
        buildWithHelpers(300, false, 8, 4, 2);
    }

    public function buildAltar():void {
        outputText("Do you start work on building the structure? (Cost: 200 wood and 100 nails)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 100 && CampStatsAndResources.WoodResc >= 200) {
            doYesNo(doBuildAltar, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doBuildAltar():void {
        CampStatsAndResources.NailsResc -= 100;
        CampStatsAndResources.WoodResc -= 200;
        clearOutput();
        outputText("You build an altar for your shrine. ");
        flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] += 1;
        buildWithHelpers(200);
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
        if (player.fatigue <= player.maxOverFatigue() - usedFatigue(100, true)) {
            if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 2) digApool();
            else if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 3) addAWoodenWalls();
        } else {
            outputText("You are too exhausted to work on hot spring!");
            doNext(playerMenu);
        }
    }

    public function digApool():void {
        outputText("Do you start work on digging the pool? (Cost: 500 stones.)\n");
        checkMaterials();
        if (CampStatsAndResources.StonesResc >= 500) {
            doYesNo(doDigAPoolWork, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doDigAPoolWork():void {
        CampStatsAndResources.StonesResc -= 500;
        clearOutput();
        outputText("You proceed to dig a proper pool and line it and the border with rocks.");
        flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] += 1;
        outputText("\n\nA few hour later the bathing area is steamy and ready for use.");
        buildWithHelpers(100, true);
        outputText("\n\nThe bathing area is steamy and ready for use.");
        flushOutputTextToGUI();
    }

    public function addAWoodenWalls():void {
        outputText("Do you start work on addine wooden walls? (Cost: 500 wood.)\n");
        checkMaterials();
        if (CampStatsAndResources.WoodResc >= 500) {
            doYesNo(doAddAWoodenWallsWork, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doAddAWoodenWallsWork():void {
        CampStatsAndResources.WoodResc -= 500;
        clearOutput();
        outputText("You start building some cover, so you can actually enjoy bathing without having to worry about potential voyeurs.");
        flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] += 1;
        buildWithHelpers(100, true);
    }

    //Sparring Ring Upgrade
    public function sparringRing():void {
        clearOutput();
        if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 1 && player.fatigue <= player.maxOverFatigue() - usedFatigue(50, true)) buildSmallRing();
        else if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 2 && player.fatigue <= player.maxOverFatigue() - usedFatigue(150, true)) buildLargeRing();
        else if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 3 && player.fatigue <= player.maxOverFatigue() - usedFatigue(450, true)) buildMassiveRing();
        else if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 4 && player.fatigue <= player.maxOverFatigue() - usedFatigue(1350, true)) buildRingWoodFloor();
        else {
            outputText("You are too exhausted to work on sparring ring!");
            doNext(playerMenu);
        }
    }

    public function buildSmallRing():void {
        outputText("Do you start work on making sparring ring? (Cost: 50 wood.)\n");
        checkMaterials();
        if (CampStatsAndResources.WoodResc >= 50) {
            doYesNo(doBuildSmallRing, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doBuildSmallRing():void {
        CampStatsAndResources.WoodResc -= 50;
        clearOutput();
        outputText("You consider the many people who reside in the camp and realise you could spar with them if you had a ring for it. You proceed to get a rope and some wooden sticks, then build a small provisory ring for your daily sparring matches.");
        flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] += 1;
        outputText("\n\nYou even moved to its border that training dummy you've found in camp upon your arrival.");
        player.createStatusEffect(StatusEffects.TrainingNPCsTimersReduction, 6, 0, 0, 0);
        buildWithHelpers(50, true, 1, 1, 1);
    }

    public function buildLargeRing():void {
        outputText("Do you start work on expanding sparring ring? (Cost: 150 wood.)\n");
        checkMaterials();
        if (CampStatsAndResources.WoodResc >= 150) {
            doYesNo(doBuildLargeRing, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doBuildLargeRing():void {
        CampStatsAndResources.WoodResc -= 150;
        clearOutput();
        outputText("Looking at your sparing ring seems a bit small for your and your camp members use, so you decide to make it larger. Getting more ropes than last time and many wooden sticks, you start to work on making sparing place bigger and better prepared to handle larger groups of fighters using it at once. And not forgetting about make the training dummy better and more durable.");
        flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] += 1;
        outputText("\n\nYou work without rest on this project but by the end the ring is expanded to large size!");
        player.addStatusValue(StatusEffects.TrainingNPCsTimersReduction, 1, -1);
		buildWithHelpers(150, true, 2, 1, 1);
    }

    public function buildMassiveRing():void {
        outputText("Do you start work on expanding your sparring ring again? (Cost: 450 wood.)\n");
        checkMaterials();
        if (CampStatsAndResources.WoodResc >= 450) {
            doYesNo(doBuildMassiveRing, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doBuildMassiveRing():void {
        CampStatsAndResources.WoodResc -= 450;
        clearOutput();
        outputText("That large sparing ring looks for some reason... too small for your settlement needs. Letting out a barely heard sigh you proceed to go fetch many wooden stick and lots of ropes. Now it will be no longer called merely large ring. With even more durable looking training dummies and small stand on one of the sides it will serve it purpose on much grander scale.");
        flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] += 1;
        outputText("\n\nYou work without rest on this project but by the end the ring is expanded to massive size!");
        player.addStatusValue(StatusEffects.TrainingNPCsTimersReduction, 1, -1);
        buildWithHelpers(450, true);
    }

    public function buildRingWoodFloor():void {
        outputText("Do you start work on adding wood floor to your sparring ring? (Cost: 1200 wood.)\n");
        checkMaterials();
        if (CampStatsAndResources.WoodResc >= 1200) {
            doYesNo(doBuildRingWoodFloor, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doBuildRingWoodFloor():void {
        CampStatsAndResources.WoodResc -= 1200;
        clearOutput();
        outputText("Your massive sparing ring looks pretty fine but you feel it still lacking... floor, that is. Without proper wood floor it only allow fight comfortably only when weeather is good. Letting out a barely heard sigh you proceed to go fetch many wooden planks. While you work on cover whole area with wood you also turn attention to lonely dummy. Maybe it would be mroe use if there will be more of them.");
        flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] += 1;
        outputText("\n\nYou work without rest on this project but by the end the ring get it floor made of wood planks and on one side around previosly lone dummy stands four more similar looking dummies.");
        player.addStatusValue(StatusEffects.TrainingNPCsTimersReduction, 1, -1);
        buildWithHelpers(1350, true, 6, 4, 2);
    }

    //Arcane Circle Upgrade
    public function arcaneCircle():void {
        clearOutput();
        if (player.fatigue <= player.maxOverFatigue() - 50) {
            if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] < 1)
                buildArcaneCircle(1);
            else if (player.statusEffectv1(StatusEffects.ArcaneCircle) > (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] - 1))
                buildArcaneCircle(flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] + 1);
            else {
                outputText("You lack the proper knowledge and skill to work on the new ritual circle yet!");
                doNext(playerMenu);
            }
        } else {
            outputText("You are too exhausted to work on the new ritual circle yet!");
            doNext(playerMenu);
        }
    }

    public function buildArcaneCircle(newTier:int):void {
        var stoneCost:int = newTier * 4;
        var hpCost:int = 75 * newTier;
        var manaCost:int = 100 * newTier;
        outputText("Do you start work on making the " + NUMBER_WORDS_POSITIONAL[newTier] + " arcane circle? (Cost: " + stoneCost + " stones, " + hpCost + " HP and " + manaCost + " mana.)\n");
        checkMaterials();
        if (CampStatsAndResources.StonesResc >= stoneCost && player.HP >= hpCost && player.mana >= manaCost) {
            doYesNo(curry(doBuildArcaneCircle, newTier), noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doBuildArcaneCircle(newTier:int):void {
        clearOutput();
        if (newTier == 1) {
			player.createStatusEffect(StatusEffects.ArcaneCircle, 0, 0, 0, 0);
            outputText("You get to building your arcane circle. You set a stone at each of the four cardinal points and draw a perfect circle with the blood. That done, you inscribe the runes meant to facilitate the chosen entity passage to Mareth, punctuating each scribing with a word of power. After several hours of hard work, your arcane circle is finally done, ready to be used to summon various entities to Mareth.");
		}
        else
            outputText("You decide to upgrade your circle in order to contain a stronger being should the binding ritual fail. You draw the " + NUMBER_WORDS_POSITIONAL[newTier] + " larger circle, inscribing additional protections and wards. As you finish, you look them over, checking for any imperfections in the writing. Satisfied. you nod at the result."
                + "\n\n<b>You can now perform the rituals to release more of your minions powers!</b>");
        flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] = newTier;
        CampStatsAndResources.StonesResc -= 4 * newTier;
        useFatigue(50);
        HPChange(-75 * newTier, true);
        useMana(100 * newTier);
        doNext(camp.returnToCampUseFourHours);
    }

    //Arcane Circle Elemental Energy Conduits Upgrade
    public function arcaneCircleUpgrade():void {
        clearOutput();
        if (player.fatigue <= player.maxOverFatigue() - 50) {
            if (!player.hasStatusEffect(StatusEffects.ElementalEnergyConduits) || player.statusEffectv3(StatusEffects.ElementalEnergyConduits) < 10) {
                var currentTier:int = !player.hasStatusEffect(StatusEffects.ElementalEnergyConduits) ? 0
                    : player.statusEffectv3(StatusEffects.ElementalEnergyConduits) / 2;
                var upgrade:Boolean = player.hasStatusEffect(StatusEffects.ElementalEnergyConduits)
                    && player.statusEffectv3(StatusEffects.ElementalEnergyConduits) % 2 > 0;
                if (currentTier + 1 > flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE]) {
                    outputText("You lack the " + NUMBER_WORDS_POSITIONAL[currentTier + 1] + " ritual circle!");
                    doNext(playerMenu);
                } else buildOrUpgradeElementalEnergyConduit(currentTier, upgrade);
            } else {
                outputText("You can't add a new elemental energy conduit! (Due to having all arcane circles having them or reaching the last possible conduit.)");
                doNext(playerMenu);
            }
        } else {
            outputText("You are too exhausted to work on ritual circle elemental energy conduits!");
            doNext(playerMenu);
        }
    }

    public function buildOrUpgradeElementalEnergyConduit(currentTier:int, upgrade:Boolean):void {
        var stoneShardCost:int = 3 + currentTier;
        var manaCost:int = 150 + currentTier * 50;
        outputText("Do you start " + (upgrade ? "expanding your " : "making the ") + NUMBER_WORDS_POSITIONAL[currentTier + 1] + " elemental energy conduit? (Cost: " + stoneShardCost + " stones, " + stoneShardCost + " Elemental Shards and " + manaCost + " mana.)\n");
        checkMaterials();
        if (CampStatsAndResources.StonesResc >= stoneShardCost && player.hasItem(useables.ELSHARD, stoneShardCost) && player.mana >= manaCost)
            doYesNo(curry(upgrade ? doUpgradeElementalEnergyConduit : doBuildElementalEnergyConduit, currentTier), noThanks);
        else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function doBuildElementalEnergyConduit(currentTier:int):void {
        var stoneShardCost:int = 3 + currentTier;
        var manaCost:int = 300 + currentTier * 100;
        var capacityIncrease:int = 900 + currentTier * 300;
        clearOutput();
        if (currentTier == 0) {
            outputText("You decide to upgrade your first arcane circle in order to better utilise elemental shards. You reach to the shards, enfusing them with your mana and changing them from the inside. You liquify the crystals, pouring them into a stone bowl. You then engrave an intricate series of runes onto three flat stones, carefully pouring the liquid crystal into the engravings, making them shine with power. All three stones are then placed in a triangular formation inside your circle, runes lining up to form veins of magic, conduits pulsing with elemental energy. Each stone is now an elemental node! You can feel that the power is now directly stored in the arcane circle, ready to use.");
            player.createStatusEffect(StatusEffects.ElementalEnergyConduits, 0, capacityIncrease, 1, 0);
            outputText("\n\n<b>You can now convert elemental shards into pure elemental energy.</b>");
        } else {
            outputText("You decide to engrave conduict in second circle. You draw complicated engraving on prepared stones using liquidified elemental shards. Then you place all " + NUMBER_WORDS_NORMAL[stoneShardCost] + " prepared nodes in the " + NUMBER_WORDS_POSITIONAL[currentTier + 1] + " circle, forming a basic elemental conduit in it.");
            player.addStatusValue(StatusEffects.ElementalEnergyConduits, 2, capacityIncrease);
            player.addStatusValue(StatusEffects.ElementalEnergyConduits, 3, 1);
            outputText("\n\n<b>Your arcane circles can store now more elemental energy! (+" + capacityIncrease + ")</b>");
        }
        CampStatsAndResources.StonesResc -= stoneShardCost;
        useFatigue(50);
        useMana(manaCost);
        player.destroyItems(useables.ELSHARD, stoneShardCost);
        doNext(camp.returnToCampUseFourHours);
    }

    private function doUpgradeElementalEnergyConduit(currentTier:int):void {
        var stoneShardCost:int = 3 + currentTier;
        var manaCost:int = 300 + currentTier * 100;
        var capacityIncrease:int = 900 + currentTier * 300;
        clearOutput();
        if (currentTier == 0)
            outputText("You decide that you need more elemental energy on hand, and for that, you need to expand your first energy conduit. You reach to the shards, enfusing them with your mana and changing them from the inside. You liquify the crystals, pouring them into a stone bowl. You then engrave an intricate series of runes onto " + NUMBER_WORDS_NORMAL[stoneShardCost] + " flat stones, carefully pouring the liquid crystal into the engravings, making them shine with power. All " + NUMBER_WORDS_NORMAL[stoneShardCost] + " stones are then placed around one of your pre-existing nodes, runes lining up to form veins of magic, conduits pulsing with elemental energy. One of your basic nodes has been enhanced, and can now store more power.");
        else
            outputText("You decide to expand your " + NUMBER_WORDS_POSITIONAL[currentTier + 1] + " energy conduit in order to store more elemental energy in circle until it will be needed. You draw a complicated engraving on prepared stones using liquidified elemental shards. Then you place all " + NUMBER_WORDS_NORMAL[stoneShardCost] + " prepared nodes in the " + NUMBER_WORDS_POSITIONAL[currentTier + 1] + " circle, upgrading one of your elemental conduits.");
        player.addStatusValue(StatusEffects.ElementalEnergyConduits, 2, capacityIncrease);
        player.addStatusValue(StatusEffects.ElementalEnergyConduits, 3, 1);
        outputText("\n\n<b>Your arcane circles can store now more elemental energy! (+" + capacityIncrease + ")</b>");
        CampStatsAndResources.StonesResc -= stoneShardCost;
        useFatigue(50);
        useMana(manaCost);
        player.destroyItems(useables.ELSHARD, stoneShardCost);
        doNext(camp.returnToCampUseFourHours);
    }

    //Magic Ward Upgrade
    public function magicWard():void {
        clearOutput();
        if (player.fatigue <= player.maxOverFatigue() - 200 && flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 1) setUpMagicWard();
        else {
            outputText("You are too exhausted to work on magic ward!");
            doNext(playerMenu);
        }
    }

    public function setUpMagicWard():void {
        outputText("You’re confident that with the warding tome as reference, you could build a ward to help keep your camp safe from lesser threats, possibly even demons.  Shall you construct the ward? (Cost: 30 stones.)\n");
        checkMaterials();
        if (CampStatsAndResources.StonesResc >= 30) {
            doYesNo(setUpMagicWard2, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function setUpMagicWard2():void {
        CampStatsAndResources.StonesResc -= 30;
        clearOutput();
        outputText("You flip through the tome, and begin to sketch copies of the required glyphs in the dirt.  Yes, this is definitely possible.  You have something ");
        if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) outputText("Tel’Adre doesn’t;");
        else outputText("most mages wouldn’t;");
        outputText(" the portal.  The ambient energy radiating from it could power the ward, as long as you get the web of magic working properly.  It takes hours, a great deal of stress and a lot of channeling to get the stones to their positions, carved into shape and infused with the requisite runes.  ");
        flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] += 1;
        if (model.time.hours >= 12) outputText("By the time you’re done, it's already dark.");
        else outputText("By the time you’re done, the sun is beginning to droop in the sky.");
        outputText("  But with these warding stones up and running, nothing should chance upon your camp unless it has business there.");
        player.removeKeyItem("Warding Tome");
        //Gain fatigue.
        useFatigue(200);
        doNext(camp.returnToCampUseEightHours);
    }

    //Dam Upgrade
    public function dam():void {
        clearOutput();
        if (flags[kFLAGS.CAMP_UPGRADES_DAM] < 1 && player.fatigue <= player.maxOverFatigue() - usedFatigue(200, true)) buildUpMinorWoodDam();
        else if (flags[kFLAGS.CAMP_UPGRADES_DAM] == 1 && player.fatigue <= player.maxOverFatigue() - usedFatigue(400, true)) buildUpWoodDam();
        else if (flags[kFLAGS.CAMP_UPGRADES_DAM] == 2 && player.fatigue <= player.maxOverFatigue() - usedFatigue(600, true)) buildUpMajorWoodDam();
        //else if (flags[kFLAGS.CAMP_UPGRADES_DAM] == 3 && player.fatigue <= player.maxOverFatigue() - usedFatigue(800, true)) buildUpMinorStoneDam();
        else {
            outputText("You are too exhausted to work on dam!");
            doNext(playerMenu);
        }
    }

    public function buildUpMinorWoodDam():void {
        outputText("Do you start work on building small wood dam? (Cost: 200 nails, 300 wood.)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.WoodResc >= 300) {
            doYesNo(buildUpMinorWoodDam2, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function buildUpMinorWoodDam2():void {
        CampStatsAndResources.NailsResc -= 200;
        CampStatsAndResources.WoodResc -= 300;
        clearOutput();
        outputText("You get down to work building the dam plank by plank. At first, it proves to be a challenge, given the running water. But you eventually manage to build the structure in full your dam allowing to increase the stream size.");
        flags[kFLAGS.CAMP_UPGRADES_DAM] = 1;
        buildWithHelpers(200, true, 8, 4, 2);
    }
	
    public function buildUpWoodDam():void {
        outputText("Do you start work on upgrading your small wood dam? (Cost: 250 nails, 375 wood.)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 250 && CampStatsAndResources.WoodResc >= 375)
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
        CampStatsAndResources.NailsResc -= 250;
        CampStatsAndResources.WoodResc -= 375;
        clearOutput();
        outputText("You get down to work expanding the dam plank by plank starting from sides. At first, it goes slowly, but you eventualy speed up, to slow down again near end of the work. New taller and wider dam starts to accumulative water to form something between stream and miniature narrow shaped lake.");
        flags[kFLAGS.CAMP_UPGRADES_DAM] = 2;
        buildWithHelpers(400, true, 8, 4, 2);
    }
	
    public function buildUpMajorWoodDam():void {
        outputText("Do you start work on upgrading your wood dam? (Cost: 300 nails, 450 wood.)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 300 && CampStatsAndResources.WoodResc >= 450)
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
        CampStatsAndResources.NailsResc -= 300;
        CampStatsAndResources.WoodResc -= 450;
        clearOutput();
        outputText("You get down to work on expanding the dam for the second time like the last time putting planks on the sides first. It progress slowly until you put last ones on the top of dam. Tired but satisfied with your work you look how previous widened stream due to higher water accumulation turn into proper miniature yet very narrow mini lake.");
        flags[kFLAGS.CAMP_UPGRADES_DAM] = 3;
        buildWithHelpers(600, true, 8, 4, 2);
    }
	
    //Fishery Upgrade
    public function fishery():void {
        clearOutput();
        if (player.fatigue <= player.maxOverFatigue() - usedFatigue(200, true)) {
            if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] < 1) {
                buildUpFishery1();
                return;
            }
            if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] == 1) {
                if (flags[kFLAGS.CAMP_UPGRADES_DAM] >= 2) buildUpFishery2();
                else {
                    outputText("You need to expand your dam more before you can expand your fishery!");
                    doNext(playerMenu);
                }
            }
            //3 stopień rozbudowy na 5 stopniu tamy (2 st. kamiennej tamy) a 4 stopień na 7 stopniu tamy (4 st. kamiennej)
        } else {
            outputText("You are too exhausted to work on fishery!");
            doNext(playerMenu);
        }
    }

    public function buildUpFishery1():void {
        outputText("Do you start work on building fishery? (Cost: 200 nails, 300 wood.)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.WoodResc >= 300) {
            doYesNo(buildUpFishery1Yes, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function buildUpFishery1Yes():void {
        CampStatsAndResources.NailsResc -= 200;
        CampStatsAndResources.WoodResc -= 300;
        clearOutput();
        outputText("You spend some time building your fishery. At the end of it, you look at the result with pride. Time to have someone on fishing duty.");
        flags[kFLAGS.CAMP_UPGRADES_FISHERY] = 1;
        flags[kFLAGS.FISHES_STORED_AT_FISHERY] = 0;
        buildWithHelpers(200, true, 8, 4, 2);
    }

    public function buildUpFishery2():void {
        outputText("Do you start work on building fishery? (Cost: 300 nails, 450 wood.)\n");
        checkMaterials();
        if (CampStatsAndResources.NailsResc >= 300 && CampStatsAndResources.WoodResc >= 450) {
            doYesNo(buildUpFishery2Yes, noThanks);
        } else {
            errorNotEnough();
            doNext(playerMenu);
        }
    }

    private function buildUpFishery2Yes():void {
        CampStatsAndResources.NailsResc -= 300;
        CampStatsAndResources.WoodResc -= 450;
        clearOutput();
        outputText("You spend some time building your fishery. At the end of it, you look at the result with pride. Now you can have two people on fishing duty.");
        flags[kFLAGS.CAMP_UPGRADES_FISHERY] = 2;
        buildWithHelpers(200, true, 8, 6, 4);
    }

    public function errorNotEnough():void {
        outputText("\n\n<b>You do not have sufficient resources. You may buy more nails, wood, stones from the carpentry shop in Tel'Adre or find other sources of these materials. It's also possible you lack some of more exotic things.</b>")
    }

    public function noThanks():void {
        outputText("Deciding not to work on building a new structure right now, you return to the center of your camp.");
        doNext(playerMenu);
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
// button 11 - using wood making small dam on stream near camp to form small pond/pool/mini lake for camp members users - using later stones to make dam better increasing amount of gathered water
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
// ?button 8 - (Kimika)Kindra living place upgr? (Adorable Sheep-morph archer with "a slight issue" ^^)
// button 9 - previous page
// ?button 10 - Helia + Helspawn living place?
// button 14 - back

}
}