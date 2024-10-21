package classes.Scenes.Camp
{
import classes.*;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Crafting;
import classes.Scenes.SceneLib;

/**
	 * Lovely and comfortable cabin for you to sleep in peace.
	 * @author Kitteh6660
	 */
	public class CabinProgress extends BaseContent {
	public static var CampResc:CampStatsAndResources = new CampStatsAndResources();

		public function CabinProgress() {

		}

		public function initiateCabin():void {
			clearOutput();
			//if (player.hasKeyItem("Nails") >= 0) player.removeKeyItem("Nails");
			//Start cabin project!
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10) flags[kFLAGS.CAMP_BUILT_CABIN] = 1;
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 1)
			{
				startWork();
				return;
			}
			if (flags[kFLAGS.CAMP_BUILT_CABIN] == 1)
			{
				SceneLib.dungeons.cabin.enterCabin();
				return;
			}
			if (player.fatigue <= player.maxOverFatigue() - gatherWoodsORquarrySiteMineCost())
			{
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 1) startWork();
				else if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 2) startLayout();
				else if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 3) startThinkingOfMaterials();
				else if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 4) checkToolbox();
				//For stage 4, explore forest.
				else if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 5) startCabinPart2();
				//Build cabin!
				else if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 6) buildCabinPart1();
				else if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 7) buildCabinPart2();
				else if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 8) buildCabinPart3();
				else if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 9) buildCabinPart4();
				//Furnish your cabin!
				else if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 10) enterCabinFirstTime();
			}
			else
			{
				outputText("You are too exhausted to work on your cabin!");
				doNext(playerMenu);
			}
		}

		//Error message
		public function errorNotEnough():void {
			outputText("\n\n<b>You do not have sufficient resources. You may buy more nails from the carpentry shop in Tel'Adre, gather more wood from either the Forest or the Deepwoods, and obtain more stones from the Mountains, or find someone to help you dig some from underground.</b>")
		}
		public function errorNotHave():void {
			outputText("\n\n<b>You do not have the tools to build.</b>")
		}


		//STAGE 1 - A wild idea appears!
		public function startWork():void {
			outputText("You wander around your camp for a few moments when, suddenly, an idea crosses your mind. Yes, that's it! A cabin! Just what you need to live more comfortably than in your tent. After some time, you find a suitable location to build it and memorize the location.");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 2;
			doNext(camp.returnToCampUseTwoHours);
		}

		//STAGE 2 - Survey and clear area for cabin site.
		private function startLayout():void {
			outputText("You finally decide to begin your project: a cabin.  A comfortable cabin, complete with a bed, nightstand, and some furniture. \n\nYou start by clearing away debris, picking up loose rocks and sticks, and moving them elsewhere. It takes an hour, and though you feel a bit exhausted, you've finished creating a space.");
			fatigue(gatherWoodsORquarrySiteMineCost());
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 3;
			endEncounter();
		}

		//STAGE 3 - Think of materials. Obviously, wood.
		private function startThinkingOfMaterials():void {
			outputText("Now that you have cleared an area for your cabin, you need to figure out how to gather the resources required. You look at the trees in the distance. Clearly, you'll need something to cut down trees. Perhaps the carpentry shop in Tel'Adre has some spare tools?");
			if (player.hasItem(weapons.L__AXE) || player.weaponName == "large axe") outputText("\n\nYour large axe will suffice for the daunting task of gathering materials.");
			else if (player.hasKeyItem("Carpenter's Toolbox") >= 0) outputText("\n\nHappily, you have already bought it!");
			else
			{
				outputText("\n\nYou realize something; you need an axe!");
				if (camp.followerKiha())
				{
					outputText("\n\nYour dragoness lover, Kiha, might be able to assist you.");
				}
			}
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 4;
			endEncounter();
		}

		public function canGatherWoods():Boolean {
			return (player.weapon == weapons.L__AXE || player.weapon == weapons.DL_AXE_ || player.weapon == weapons.MACGRSW || player.weapon == weapons.TMACGRSW || player.weapon == weapons.RIPPER1 || player.weapon == weapons.TRIPPER1 || player.weapon == weapons.RIPPER2 || player.weapon == weapons.TRIPPER2
			|| player.weaponOff == weapons.L__AXE || player.weaponOff == weapons.DL_AXE_ || player.weaponOff == weapons.MACGRSW || player.weaponOff == weapons.TMACGRSW || player.weaponOff == weapons.RIPPER1 || player.weaponOff == weapons.TRIPPER1 || player.weaponOff == weapons.RIPPER2 || player.weaponOff == weapons.TRIPPER2
			|| player.hasKeyItem("Carpenter's Toolbox") >= 0 || player.isInGoblinMech()) && CampStatsAndResources.WoodResc < SceneLib.campUpgrades.checkMaterialsCapWood() && player.statusEffectv1(StatusEffects.ResourceNode1) < 5;
		}
		//STAGE 4 - Gather woods, explore forest to encounter.
		public function gatherWoods():void {
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.ResourceNode1) && player.statusEffectv1(StatusEffects.ResourceNode1) >= 5) outputText("You return to the forest where you found some thick trees, ready to be cut down.");
			else outputText("While exploring the forest, you survey the trees. The trees are at the right thickness. You could cut down the trees.\n\n");
			if (!player.hasStatusEffect(StatusEffects.ResourceNode1)) player.createStatusEffect(StatusEffects.ResourceNode1, 0, 0, 0, 0);
			if (player.statusEffectv1(StatusEffects.ResourceNode1) < 5) {
				if (player.statusEffectv1(StatusEffects.ResourceNode1) == 4) outputText("You’ve discovered this type of logging area enough times to easily find them in the future. ('Woodcutting' option has been unlocked in the Places menu.)\n\n");
				player.addStatusValue(StatusEffects.ResourceNode1, 1, 1);
			}
			menu();
			if (player.fatigue > player.maxOverFatigue() - gatherWoodsORquarrySiteMineCost()) {
				outputText("<b>You’re too tired to think about cutting down the trees. Perhaps some rest will help?</b>");
				endEncounter();
				return;
			}
			if (player.hasItem(weapons.L__AXE) || player.weapon == weapons.DL_AXE_ || player.weaponOff == weapons.L__AXE || player.weaponOff == weapons.DL_AXE_) {
				outputText("You are carrying a large axe with you.");
				addButton(0, "Axe", cutTreeTIMBER);
			}
			if (player.hasKeyItem("Carpenter's Toolbox") >= 0) {
				outputText("You are carrying carpenter's box with you. It contains an axe.\n");
				addButton(0, "Axe", cutTreeTIMBER);
			}
			if (camp.followerKiha()) {
				outputText("You have someone who might help you. Kiha might be able to assist you.\n");
				addButton(1, "Kiha", getHelpFromKiha);
			}
			if (silly() && player.str >= 70) {
				outputText("You suddenly feel a strange urge to punch the trees. Do you punch the tree? \n");
				addButton(2, "Punch Tree", punchTreeMinecraftStyle);
			}
			if (player.weapon == weapons.MACGRSW || player.weapon == weapons.TMACGRSW || player.weapon == weapons.RIPPER1 || player.weapon == weapons.TRIPPER1 || player.weapon == weapons.RIPPER2 || player.weapon == weapons.TRIPPER2
			|| player.weaponOff == weapons.MACGRSW || player.weaponOff == weapons.TMACGRSW || player.weaponOff == weapons.RIPPER1 || player.weaponOff == weapons.TRIPPER1 || player.weaponOff == weapons.RIPPER2 || player.weaponOff == weapons.TRIPPER2) {
				if (player.weapon == weapons.RIPPER2 || player.weapon == weapons.TRIPPER2 || player.weaponOff == weapons.RIPPER2 || player.weaponOff == weapons.TRIPPER2) {
					outputText("You are carrying a Ripper 2.0 with you.\n");
					addButton(3, "Ripper 2.0", cutTreeMechTIMBER);
				}
				else if (player.weapon == weapons.RIPPER1 || player.weapon == weapons.TRIPPER1 || player.weaponOff == weapons.RIPPER1 || player.weaponOff == weapons.TRIPPER1) {
					outputText("You are carrying a Ripper 1.0 with you.\n");
					addButton(3, "Ripper 1.0", cutTreeMechTIMBER);
				}
				else {
					outputText("You are carrying a Machined greatsword with you.\n");
					addButton(3, "Mach.Greatsword", cutTreeMechTIMBER);
				}
			}
			if (player.isInGoblinMech()) {
				outputText("You’re in a goblin mech equipped with sawblades as melee weapons.\n");
				addButton(4, "Sawblade", cutTreeMechTIMBER);
			}
			if (!(buttonIsVisible(0) || buttonIsVisible(1) || buttonIsVisible(2) || buttonIsVisible(3) || buttonIsVisible(4))) {
				outputText("<b>Unfortunately, there is nothing you can do right now.</b>");
			}
			addButton(14, "Leave", noThanks);
		}
		//Silly Mode! Punch trees the Minecraft way!
		private function punchTreeMinecraftStyle():void {
			clearOutput();
			if (player.str >= 90) outputText("Who needs axes when you’ve got pure strength? Bracing yourself, you crack your knuckles and punch the tree with all your might. A crack begins to form, and you keep punching. As soon as it’s big enough, a block of wood breaks off. Strangely, the block of wood floats. ");
			else outputText("Who needs axes when you've got pure strength? Bracing yourself, you crack your knuckles and punch the tree with all your strength. It takes effort, and as you keep punching, a crack begins to form. The crack grows bigger with each hit. When it’s large enough, the log breaks off, and it strangely floats in the air. ");
			outputText("You shrug and pick up the wood block when you suddenly hear a crashing sound as the tree falls over and splits into several wooden blocks! Surprisingly, they clump together into a single bunch. You pick up the bunch of wood, noting how easy it is to carry, and return to your camp. \n\n");
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += (10 + ((player.strStat.core.value + player.strStat.train.value) * 4));
			incrementWoodSupply(10 + ((player.strStat.core.value + player.strStat.train.value) * 4));
			awardAchievement("Getting Wood", kACHIEVEMENTS.GENERAL_GETTING_WOOD);
			fatigue(gatherWoodsORquarrySiteMineCost(), USEFATG_PHYSICAL);
			endEncounter();
		}
		//Cut down the tree yourself with large axe.
		private function cutTreeTIMBER():void {
			clearOutput();
			if (player.weaponName == "large axe") outputText("You ready your oversized axe. ");
			else if (player.weapon == weapons.DL_AXE_) outputText("You ready your oversized axes. ");
			else outputText("You ready your axe. ");
			outputText("With your strength, you hack away at the tree, making wedge-shaped cuts. After ten strikes, you yell, \"<i>TIMMMMMMMBER!</i>\" as the tree falls to the ground with a loud crash. You’re quite the lumberjack! You then cut the felled tree into pieces and haul the wood back to your camp.\n\n");
			var cTT:Number = (10 + ((player.strStat.core.value + player.strStat.train.value) * 4));
			if (player.weapon == weapons.DL_AXE_) cTT = Math.round(cTT*1.5);
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += cTT;
			incrementWoodSupply(cTT);
			fatigue(gatherWoodsORquarrySiteMineCost(), USEFATG_PHYSICAL);
			endEncounter(120);
		}
		//Cut down the tree yourself with Machined greatsword.
		private function cutTreeMechTIMBER():void {
			clearOutput();
			outputText("You rev up your ");
			if (player.isInGoblinMech()) outputText("chainsaw");
			else {
				if (player.weapon == weapons.RIPPER2) outputText("Ripper 2.0");
				else if (player.weapon == weapons.TRIPPER2) outputText("Twin Ripper 2.0");
				else if (player.weapon == weapons.RIPPER1) outputText("Ripper 1.0");
				else if (player.weapon == weapons.TRIPPER1) outputText("Twin Ripper 1.0");
				else if (player.weapon == weapons.TMACGRSW) outputText("chainsaw swords");
				else outputText("chainsaw sword");
			}
			outputText(" as the metal teeth begin to spin. ");
			if (player.isInGoblinMech()) outputText("Pressing the joystick on your command board you move ");
			else outputText("Grabbing a hold of the handle, you press ");
			outputText("the blade into the trunk of the tree, watching it cut straight through as wood chips fly all over the place. Eventually you reach the other side of the trunk, and the tree falls over with a mighty thud. You then proceed to cut the trunk into smaller pieces and haul them back to your camp.\n\n");
			if (player.isInGoblinMech()) {
				flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += (22 + ((player.strStat.core.value + player.strStat.train.value) * 5));
				incrementWoodSupply(22 + ((player.strStat.core.value + player.strStat.train.value) * 5));
				endEncounter();
			}
			else {
				var cTMT:Number = (13 + ((player.strStat.core.value + player.strStat.train.value) * 4));
				if (player.weapon == weapons.TMACGRSW || player.weapon == weapons.TRIPPER1 || player.weapon == weapons.TRIPPER2) cTMT = Math.round(cTMT*1.5);
				flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += cTMT;
				incrementWoodSupply(cTMT);
				fatigue(gatherWoodsORquarrySiteMineCost(), USEFATG_PHYSICAL);
				endEncounter(120);
			}
		}

		public function quarrySite():void {
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.ResourceNode1) && player.statusEffectv2(StatusEffects.ResourceNode1) >= 5) outputText("You return to the mountain area where you previously found a rich mineral formation.");
			else outputText("As you explore the mountain area you run into what appears to be a very good mineral formation.");
			if (player.hasKeyItem("Old Pickaxe") < 0) outputText(" Next to it lies an old pickaxe and a leather bag with runic engravings, likely left by a native who met an unfortunate end.");
			if (!player.hasStatusEffect(StatusEffects.ResourceNode1)) player.createStatusEffect(StatusEffects.ResourceNode1, 0, 0, 0, 0);
			if (player.statusEffectv2(StatusEffects.ResourceNode1) < 5) {
				if (player.statusEffectv2(StatusEffects.ResourceNode1) == 4) outputText("You’ve found this quarry enough times to easily find it again in the future. ('Quarry' option has been unlocked in the Places menu.)\n\n");
				player.addStatusValue(StatusEffects.ResourceNode1, 2, 1);
			}
			menu();
			if (player.hasKeyItem("Old Pickaxe") < 0) {
				addButtonDisabled(0, "Mine", "You’ll need a pickaxe to retrieve the stone.");
				addButton(1, "Pickaxe", quarrySitePickaxe);
			}
			else {
				if (model.time.hours <= 5 || model.time.hours >= 21) addButton(0, "Mine (N)", quarrySiteMine, true);
				else addButton(0, "Mine (D)", quarrySiteMine).hint("Some ores may only be available at night.");
			}
			addButton(14, "Leave", explorer.done);
		}
		private function quarrySitePickaxe():void {
			outputText("\n\nYou pick up the old mining tool—it should prove useful for digging up gems, ore, or stone from the landscape. Upon inspecting the leather bag, it turns out to be a low-quality, enchanted bag designed to store ores and other crafting materials. (It can hold up to 5 pieces of 4 different types of crafting materials.)");
			player.createKeyItem("Old Pickaxe", 0, 0, 0, 0);
			player.createKeyItem("Tarnished Ore Bag (Lowest grade)", 0, 0, 0, 0);
			Crafting.BagSlot01Cap = 5;
			Crafting.BagSlot02Cap = 5;
			Crafting.BagSlot03Cap = 5;
			Crafting.BagSlot04Cap = 5;
			doNext(quarrySite);
		}
		private function gatherWoodsORquarrySiteMineCost():Number {
			var fatigueAmount:Number = 50;
			if (player.hasPerk(PerkLib.MummyLord) && player.perkv1(PerkLib.MummyLord) > 0) {
				if (player.perkv1(PerkLib.MummyLord) > 19) fatigueAmount = 0;
				else fatigueAmount = Math.round(50*(1/player.perkv1(PerkLib.MummyLord)));
			}
			return fatigueAmount;
		}
		private function quarrySiteMine(nightExploration:Boolean = false):void {
			if (player.fatigue > player.maxOverFatigue() - gatherWoodsORquarrySiteMineCost()) {
				outputText("\n\n<b>You’re too tired to think about mining. Perhaps some rest will help?</b>");
				endEncounter();
				return;
			}
			if (nightExploration) {
				//later on add here chance to be ambushed by some enemy
			}
			outputText("\n\nYou begin slamming your pickaxe against the stone, spending the better part of two hours mining. Once finished, you bring your prize back to camp. ");
			var minedStones:Number = 13 + ((player.strStat.core.value + player.strStat.train.value) * 4);
			fatigue(gatherWoodsORquarrySiteMineCost(), USEFATG_PHYSICAL);
			if (minedStones > (40 + (2 * player.miningLevel) + (20 * player.newGamePlusMod()))) minedStones = (40 + (2 * player.miningLevel) + (20 * player.newGamePlusMod()));
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_YABBA_DABBA_DOO] += minedStones;
			incrementStoneSupply(minedStones);
			var mineEXP:Number = player.MiningMulti();
			player.mineXP(mineEXP);
			if (rand(10) == 0) {
				var gemsMined:Number = 1 + rand(1+player.miningLevel);
				outputText(" Along with the stone you managed to dig up " + gemsMined + " gems!");
				player.gems += gemsMined;
			}
			findOre(nightExploration);
		}

		private function findOre(nightExploration:Boolean = false):void {
			if (player.miningLevel > 0) {
				if (rand(4) == 0) {
					var itype:ItemType;
					var ore:Number = 2; //0 = copper, 1 = tin, 2 = iron, 3 = moonstone
					if (player.miningLevel > 1) ore += 1;
					if (player.miningLevel > 2 && nightExploration) ore += 1;
					var choice:Number = rand(ore);
					switch(choice) {
						case 0:
							itype = useables.TIN_ORE;
							break;
						case 1:
							itype = useables.COP_ORE;
							break;
						case 2:
							itype = useables.IRONORE;
							break;
						case 3:
							itype = useables.MOONSTO;
							break;
						default:
							outputText("Something's bugged! Please report this bug to Ormael/Aimozg.");
					}
					inventory.takeItem(itype, curry(explorer.done,120));
				}
				else {
					outputText(" After attempting to mine an Ore Vein, you ended up with nothing but unusable pieces.");
					endEncounter(120);
				}
			}
			else {
				outputText(" Your mining skill is too low to find any ore.");
				endEncounter(120);
			}
		}

		private function checkToolbox():void {
			if (player.hasKeyItem("Carpenter's Toolbox") >= 0 && flags[kFLAGS.CAMP_CABIN_PROGRESS] == 4)
			{
				outputText("You should be able to work on your cabin as you have toolbox. \n\n");
				outputText("You take out the book included in your toolbox titled \"Carpenter's Guide\" and open it. There are hundreds of pages, most of them have illustrations on how to use tools and how to build various projects. You read through the book, page by page. \n\n");
				dynStats("int", 1);
				flags[kFLAGS.CAMP_CABIN_PROGRESS] = 5;
			}
			else
			{
				outputText("You are missing a toolbox. Maybe one of the shops sell these? \n\n");
			}
			endEncounter(); //- wadą tego etapu to brak menu lub menu za wcześnie?
		}

		//Get help from Kiha.
		private function getHelpFromKiha():void {
            clearOutput();
			outputText("You recall Kiha wields an oversized axe and call out to her. After a minute, she walks over and says \"<i>Yes, my idiot?</i>\" You tell her that you would like her to cut down some trees so you can haul the wood. She nods and yells \"<i>Stand back!</i>\" You step aside and watch as she easily fells not one, but two trees! With the trees cut down, you and Kiha haul the wood back to your camp. ");
			if (player.str < 33) outputText("It’s a daunting task, as you can only carry a few pieces of wood at a time. Even Kiha far surpasses your carrying capacity, easily hauling much more wood than you.");
			if (player.str >= 33 && player.str < 66) outputText("It's quite the chore. Though you can carry several pieces of wood at a time, Kiha is still superior to you when it comes to hauling wood.");
			if (player.str >= 66) outputText("You easily tackle the task of carrying wood. You even manage to carry five logs at a time!");
			outputText("\n\nIt takes some time, but you eventually bring the last of the wood back to your camp.\n\n");
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += (20 + ((player.strStat.core.value + player.strStat.train.value) * 8));
			incrementWoodSupply(20 + ((player.strStat.core.value + player.strStat.train.value) * 8));
			fatigue(gatherWoodsORquarrySiteMineCost(), USEFATG_PHYSICAL);
			endEncounter(120);
		}

		private function noThanks():void {
			outputText("Deciding not to cut down the tree at the moment, you return to your camp. ");
			endEncounter();
		}
		private function noThanks2():void {
			outputText("Deciding not to work on your cabin right now, you return to the center of your camp.");
			doNext(playerMenu);
		}

		public function incrementWoodSupply(amount:int):void {
			CampStatsAndResources.WoodResc += amount;
			outputText("<b>(+" + amount + " wood! "+CampStatsAndResources.WoodResc+"/"+SceneLib.campUpgrades.checkMaterialsCapWood()+" total!");
			if (CampStatsAndResources.WoodResc >= SceneLib.campUpgrades.checkMaterialsCapWood()) {
				CampStatsAndResources.WoodResc = SceneLib.campUpgrades.checkMaterialsCapWood();
				outputText(" Your wood capacity is full.")
			}
			outputText(")</b>");
		}

		public function incrementStoneSupply(amount:int):void {
			CampStatsAndResources.StonesResc += amount;
			outputText("<b>(+" + amount + " stone"+(amount>1?"s":"")+"! "+CampStatsAndResources.StonesResc+"/"+SceneLib.campUpgrades.checkMaterialsCapStones()+" total!");
			if (CampStatsAndResources.StonesResc >= SceneLib.campUpgrades.checkMaterialsCapStones()) {
				CampStatsAndResources.StonesResc = SceneLib.campUpgrades.checkMaterialsCapStones();
				outputText(" Your stone capacity is full.")
			}
			outputText(")</b>");
		}

		private function noMoreSrt():Number {
			var nMS:Number = player.str;
			if (nMS > 10) nMS = 10;
			return nMS;
		}

		//STAGE 6 - Work on cabin part 2. Planning your cabin.
		private function startCabinPart2():void {
			outputText("You take out a sheet of paper, a feather pen, and an ink quill to draw some plans and diagrams. You spend an hour editing and perfecting your work, reviewing and making final changes before folding the paper and putting it away.");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 6;
			endEncounter();
		}

		//STAGE 8 - Build cabin part 1.
		private function buildCabinPart1():void {
			//No toolbox? Access denied!
			if (player.hasKeyItem("Carpenter's Toolbox")<0)
			{
				outputText("You realize you don’t have the toolbox to work on your cabin and let out a sigh.");
				doNext(playerMenu);
				return;
			}
			//Got toolbox? Proceed!
			outputText("Now that you have the carpenter's toolbox and your finished plans, you’re ready to start building. Do you begin work on framing your cabin? (Cost: 100 nails and 50 wood.)\n");
			SceneLib.camp.campUpgrades.checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (CampStatsAndResources.NailsResc >= 100 && CampStatsAndResources.WoodResc >= 50)
				{
					doYesNo(doCabinWork1, noThanks2);
				}
				else
				{
					errorNotEnough();
					doNext(playerMenu);
				}
			}
			else
			{
				errorNotHave();
				doNext(playerMenu);
			}
		}

		private function doCabinWork1():void {
			clearOutput();
			CampStatsAndResources.NailsResc -= 100;
			CampStatsAndResources.WoodResc -= 50;
			outputText("Today is the day you'll actually work on building your own cabin! You clear a space and set up some rocks. You take the book from your toolbox and open it, flipping through the pages until you find instructions on how to construct the frame. \n\n");
			//if (CoC.instance.amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1) outputText("\"<i>PLACEHOLDER</i>\" Amily asks. \n\n");
			outputText("You begin constructing a wooden frame according to the instructions. Using your hammer and nails, you assemble the frame and put it up. You then add temporary supports to keep it from falling. You make two more frames of the same shape. Next, you make two more frames of the same shape. Finally, you construct one last frame, this time designed to include a door and window.\n\n");
			if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("\"<i>My, my. What are you building?</i>\" Rathazul asks. \n\n");
			if (player.hasStatusEffect(StatusEffects.PureCampJojo)) outputText("\"<i>You're building something?</i>\" Jo"+(flags[kFLAGS.JOJO_BIMBO_STATE] == 3 ? "y":"jo")+" asks. \n\n");
			if (camp.marbleFollower()) outputText("\"<i>Sweetie, you're building a cabin? That's nice,</i>\" Marble says. \n\n");
			if (camp.companionsCount() > 0) outputText("You announce with confidence that, yes, you're building a cabin.\n\n");
			outputText("You nail the frames together and finally secure them to the foundation.\n\n");
			outputText("Finally, you construct a wooden frame for the roof, which takes a few hours.\n\n");
			if (player.canFly() && player.str >= 80) outputText("Using your wings, you lift the roof frame and carefully place it on the structure. ");
			else outputText("You construct a temporary ramp to push the roof frame into place. ");
			outputText("You then hammer nails in place to secure the roof frame.\n\n");
			outputText("<b>You’ve finished framing the cabin! Now you can start working on constructing the walls.</b>\n\n");
			if (camp.companionsCount() == 1) outputText("Your lone camp follower comes to see what you've been working on. They nod in approval, impressed by your handiwork.");
			else if (camp.companionsCount() > 1) outputText("Your camp followers come to see what you've built so far, and most of them are very impressed.");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 7;
			fatigue(gatherWoodsORquarrySiteMineCost()*2);
			doNext(camp.returnToCampUseEightHours);
		}

		//Stage 9 - Build cabin part 2.
		private function buildCabinPart2():void {
			clearOutput();
			outputText("You can continue working on your cabin. Do you want to start on the walls and roof? (Cost: 200 nails and 125 wood.)\n");
			SceneLib.camp.campUpgrades.checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.WoodResc >= 125)
				{
					doYesNo(doCabinWork2, noThanks2);
				}
				else
				{
					errorNotEnough();
					doNext(playerMenu);
				}
			}
			else
			{
				errorNotHave();
				doNext(playerMenu);
			}
		}

		private function doCabinWork2():void {
			clearOutput();
			CampStatsAndResources.NailsResc -= 200;
			CampStatsAndResources.WoodResc -= 125;
			outputText("You walk back to your cabin construction site and resume working. Taking out the book, you flip through the pages until you find the instructions on how to finish the walls and roof. \n\n");
			outputText("Segment by segment, you nail more wooden planks onto one side of the cabin, then move on to the next until the frame is fully covered, leaving openings for the windows and door. You climb up the ladder you built during a previous session and begin nailing down the wood on the roof frame. \n\n");
			outputText("Several hours fly by as you complete the walls and roof. Finally, you apply paint to the roof and walls to ensure they’re waterproof and protected from the elements. \n\n");
			outputText("<b>You have finished constructing the walls and roof!</b>\n\n");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 8;
			fatigue(gatherWoodsORquarrySiteMineCost()*2);
			doNext(camp.returnToCampUseEightHours);
		}

		//Stage 10 - Build cabin part 3 - Install door and window.
		private function buildCabinPart3():void {
			clearOutput();
			outputText("You can continue working on your cabin. Do you want to start installing the door and windows? (Cost: 100 nails and 50 wood.)\n");
			SceneLib.camp.campUpgrades.checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (CampStatsAndResources.NailsResc >= 100 && CampStatsAndResources.WoodResc >= 50)
				{
					doYesNo(doCabinWork3, noThanks2);
				}
				else
				{
					errorNotEnough();
					doNext(playerMenu);
				}
			}
			else
			{
				errorNotHave();
				doNext(playerMenu);
			}
		}

		private function doCabinWork3():void {
			clearOutput();
			CampStatsAndResources.NailsResc -= 100;
			CampStatsAndResources.WoodResc -= 50;
			outputText("You walk back to your cabin construction site and resume working. Taking out the book, you flip through the pages until you find the instructions on how to construct a door.\n\n");
			outputText("Following the instructions, you construct a wooden door that comes complete with a window. You frame the doorway and install the door into place.\n\n");
			outputText("Next, you flip through the book until you find instructions on how to construct a window with functional shutters. You measure and cut the wood to the correct sizes before nailing it together into a frame. Then, you build two shutters and install them into the window frame. Finally, you secure the window in place.\n\n");
			outputText("<b>You have finished installing the door and windows!</b>\n\n");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 9;
			fatigue(gatherWoodsORquarrySiteMineCost()*2);
			doNext(camp.returnToCampUseFourHours);
		}

		//Stage 11 - Build cabin part 4 - Install flooring.
		private function buildCabinPart4():void {
			clearOutput();
			outputText("You can continue working on your cabin. Do you want to start installing the flooring? (Cost: 200 nails and 50 wood.)\n"); //What about adding a few stones here Additionally? 50 maybe?
			SceneLib.camp.campUpgrades.checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.WoodResc >= 50)
				{
					doYesNo(doCabinWork4, noThanks2);
				}
				else
				{
					errorNotEnough();
					doNext(playerMenu);
				}
			}
			else
			{
				errorNotHave();
				doNext(playerMenu);
			}
		}

		private function doCabinWork4():void {
			clearOutput();
			CampStatsAndResources.NailsResc -= 200;
			CampStatsAndResources.WoodResc -= 50;
			outputText("You walk back to your cabin construction site and resume working. Taking out the book, you flip through the pages until you find the instructions on how to install wooden flooring.\n\n");
			outputText("Following the instructions, you lay the wooden planks on the ground, carefully measuring the gaps between each one to ensure consistency.\n\n");
			outputText("Next, you lay the wooden planks and nail them in place. It takes time and effort, but by the time you’re finished, the flooring is ready to be polished. You then spend the next few hours painting and polishing the floor.\n\n");
			outputText("After spending time painting, you leave the floor to dry.\n\n");
			outputText("<b>You have finished installing the flooring!</b>\n\n");
			outputText("<b>Congratulations! You have finished your cabin structure! You may want to construct some furniture though...</b>\n\n");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 10;
			flags[kFLAGS.CAMP_BUILT_CABIN] = 1;
			fatigue(gatherWoodsORquarrySiteMineCost()*2);
			doNext(enterCabinFirstTime);
		}

		//CABIN INTERACTIONS
		public function enterCabinFirstTime():void {
			clearOutput();
			outputText("You enter your newly-constructed cabin. You are proud of what you've built—except that it’s completely empty.\n\n");
			flags[kFLAGS.CAMP_BUILT_CABIN] = 1;
			doNext(SceneLib.dungeons.cabin.enterCabin);
		}

	}
}
