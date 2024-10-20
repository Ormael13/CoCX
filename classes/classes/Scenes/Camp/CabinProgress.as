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
			outputText("\n\n<b>You do not have sufficient resources. You may buy more nails from the carpentry shop in Tel'Adre, get more wood from either the Forest or the Deepwoods and get more stones from some quarry or if you found someone to help you dig some from underground.</b>")
		}
		public function errorNotHave():void {
			outputText("\n\n<b>You do not have the tools to build.</b>")
		}


		//STAGE 1 - A wild idea appears!
		public function startWork():void {
			outputText("You wander around your camp for a good few moments when suddenly, something crosses your mind. Yes, that's it! A cabin! Just what you would need to live comfortably instead of your tent. You wander for a good while until you find a suitable location to build your cabin. You memorize the location.");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 2;
			doNext(camp.returnToCampUseTwoHours);
		}

		//STAGE 2 - Survey and clear area for cabin site.
		private function startLayout():void {
			outputText("You finally decide to begin your project: a cabin.  A comfortable cabin, come complete with a bed and nightstand along with some furniture. \n\nYou begin clearing away loose debris by picking up loose rocks and sticks and move them somewhere. It takes one hour and you feel a bit exhausted but you've finished creating a space.");
			fatigue(gatherWoodsORquarrySiteMineCost());
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 3;
			endEncounter();
		}

		//STAGE 3 - Think of materials. Obviously, wood.
		private function startThinkingOfMaterials():void {
			outputText("Now that you have cleared an area for your cabin, you'll have to figure out how to get the resources you need. You look at the trees in the distance. Clearly, you'll need something to cut down trees. Maybe there's a shop somewhere?");
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
			if (player.hasStatusEffect(StatusEffects.ResourceNode1) && player.statusEffectv1(StatusEffects.ResourceNode1) >= 5) outputText("You return to the forest where you found a good thick trees ready to be cut down.");
			else outputText("While exploring the forest, you survey the trees. The trees are at the right thickness. You could cut down the trees.\n\n");
			if (!player.hasStatusEffect(StatusEffects.ResourceNode1)) player.createStatusEffect(StatusEffects.ResourceNode1, 0, 0, 0, 0);
			if (player.statusEffectv1(StatusEffects.ResourceNode1) < 5) {
				if (player.statusEffectv1(StatusEffects.ResourceNode1) == 4) outputText("You have found this type of logging area enough times to be able to find them in the future without trouble. ('Woodcutting' option has been unlocked in Places menu)\n\n");
				player.addStatusValue(StatusEffects.ResourceNode1, 1, 1);
			}
			menu();
			if (player.fatigue > player.maxOverFatigue() - gatherWoodsORquarrySiteMineCost()) {
				outputText("<b>You are too tired to consider cutting down the trees. Perhaps some rest will suffice?</b>");
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
				outputText("You suddenly have the strange urge to punch trees. Do you punch the tree? \n");
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
				outputText("You are in goblin mech that have sawblade as melee weapon.\n");
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
			if (player.str >= 90) outputText("Who needs axes when you've got pure strength? Bracing yourself, you crack your knuckles and punch the tree with your mighty strength. Crack begins to form and you keep punching. As soon as the crack gets big enough, a block of wood breaks off. Strangely, the tree floats. ");
			else outputText("Who needs axes when you've got pure strength? Bracing yourself, you crack your knuckles and punch the tree with all your strength. It takes effort and while you're punching the tree, crack appears. It grows bigger as you keep punching. When the crack gets big enough, the log just broke off and the tree strangely floats. ");
			outputText("You shrug and pick up the wood block when you hear crashing sound as the tree falls over and splits into many wooden blocks! Surprisingly, they clump together into one bunch. You pick the bunch of wood, noting how easy it is to carry. You return to your camp. \n\n");
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
			outputText("With your strength, you hack away at the tree, making wedge-shaped cuts. After ten strikes, you yell \"<i>TIMMMMMMMMBER!</i>\" as the tree falls and lands on the ground with a loud crash. You are quite the fine lumberjack! You then cut the felled tree into pieces and you haul the wood back to your camp.\n\n");
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
			if (player.hasStatusEffect(StatusEffects.ResourceNode1) && player.statusEffectv2(StatusEffects.ResourceNode1) >= 5) outputText("You return to the mountain area where you found before a very good mineral formation.");
			else outputText("As you explore the mountain area you run into what appears to be a very good mineral formation.");
			if (player.hasKeyItem("Old Pickaxe") < 0) outputText(" Next to it is an old pickaxe and leather bag with runic engraving left by a native who likely met an unfortunate end.");
			if (!player.hasStatusEffect(StatusEffects.ResourceNode1)) player.createStatusEffect(StatusEffects.ResourceNode1, 0, 0, 0, 0);
			if (player.statusEffectv2(StatusEffects.ResourceNode1) < 5) {
				if (player.statusEffectv2(StatusEffects.ResourceNode1) == 4) outputText("You have found this quarry enough times to be able to find it in the future without trouble. ('Quarry' option has been unlocked in Places menu)\n\n");
				player.addStatusValue(StatusEffects.ResourceNode1, 2, 1);
			}
			menu();
			if (player.hasKeyItem("Old Pickaxe") < 0) {
				addButtonDisabled(0, "Mine", "You would need a pickaxe in order to retrieve the stone.");
				addButton(1, "Pickaxe", quarrySitePickaxe);
			}
			else {
				if (model.time.hours <= 5 || model.time.hours >= 21) addButton(0, "Mine (N)", quarrySiteMine, true);
				else addButton(0, "Mine (D)", quarrySiteMine).hint("Some ores might be available only at night.");
			}
			addButton(14, "Leave", explorer.done);
		}
		private function quarrySitePickaxe():void {
			outputText("\n\nYou pick up the old mining tool. This should prove useful when digging up gems, ore or stone from the landscape. Also inspecting leather bag it turns oput to be some lowest quality bag enchanted to store ores and other crafting materials in it. (It can store up to 5 pieces of 4 types of crafting materials)");
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
				outputText("\n\n<b>You are too tired to consider mining. Perhaps some rest will suffice?</b>");
				endEncounter();
				return;
			}
			if (nightExploration) {
				//later on add here chance to be ambushed by some enemy
			}
			outputText("\n\nYou begin slamming your pickaxe against the stone, spending the better part of the next two hours mining. This done, you bring back your prize to camp. ");
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
							outputText("Something bugged! Please report this bug to Ormael/Aimozg.");
					}
					inventory.takeItem(itype, curry(explorer.done,120));
				}
				else {
					outputText(" After attempting to mine an Ore Vein, you ended up with unusable pieces.");
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
				outputText("You take out the book included in your toolbox. It's titled \"Carpenter's Guide\" and you open the book. There are hundreds of pages, most of them have illustrations on how to use tools and how to build projects. You read through the book, page by page. \n\n");
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
			outputText("You recall Kiha wields an oversized axe. You call out for her. After a minute, she walks over to you and says \"<i>Yes, my idiot?</i>\" You tell her that you would like her to cut down some trees so you can haul the wood. She nods and yells \"<i>Stand back!</i>\" as you stand back while you watch her easily cut down not one but two trees! With the trees cut down, you and Kiha haul the wood back to your camp. ");
			if (player.str < 33) outputText("It's a daunting task as you can only carry few of the wood at a time. Even Kiha is far superior to your carrying capacity as she can carry a lot of wood.");
			if (player.str >= 33 && player.str < 66) outputText("It's quite the chore. Though you can carry several pieces of wood at a time, Kiha is still superior to you when it comes to carrying wood.");
			if (player.str >= 66) outputText("You easily tackle the task of carrying wood. You even manage to carry five pieces of wood at a time!");
			outputText("\n\nIt takes some time but you eventually bring the last of wood back to your camp.\n\n");
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
			outputText("You take out a paper, feather pen, and ink quill to draw some plans and diagrams. You spend one hour editing and perfecting your plans, reviewing and making some final changes to your plan before you fold the paper and put it away.");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 6;
			endEncounter();
		}

		//STAGE 8 - Build cabin part 1.
		private function buildCabinPart1():void {
			//No toolbox? Access denied!
			if (player.hasKeyItem("Carpenter's Toolbox")<0)
			{
				outputText("You realize you don't have the toolbox to work on your cabin. You let out a sigh.");
				doNext(playerMenu);
				return;
			}
			//Got toolbox? Proceed!
			outputText("Now that you have the carpenter's toolbox and your finished plans, you can work on building. Do you start work on framing your cabin? (Cost: 100 nails and 50 wood.)\n");
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
			outputText("Today is the day you'll actually work on building your own cabin! You clear a space and set up some rocks. You take the book from your toolbox and open it. You turn pages until you come across an instruction on how to construct frame. \n\n");
			//if (CoC.instance.amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1) outputText("\"<i>PLACEHOLDER</i>\" Amily asks. \n\n");
			outputText("You start to construct a wooden frame according to the instructions. Using your hammer and nails, you put the wood frame together and put it up. You then add temporary supports to ensure it doesn't fall down. You make two more frames of the same shape. Lastly, you construct one more frame, this time the frame is designed to have door and window.\n\n");
			if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("\"<i>My, my. What are you building?</i>\" Rathazul asks. \n\n");
			if (player.hasStatusEffect(StatusEffects.PureCampJojo)) outputText("\"<i>You're building something?</i>\" Jo"+(flags[kFLAGS.JOJO_BIMBO_STATE] == 3 ? "y":"jo")+" asks. \n\n");
			if (camp.marbleFollower()) outputText("\"<i>Sweetie, you're building a cabin? That's nice,</i>\" Marble says. \n\n");
			if (camp.companionsCount() > 0) outputText("You announce that yes, you're building a cabin.\n\n");
			outputText("You nail the frames together and finally you secure the frame to the foundation.\n\n");
			outputText("Finally, you construct a wooden frame for the roof. This takes few hours.\n\n");
			if (player.canFly() && player.str >= 80) outputText("You use your wings, lift the roof frame and carefully place it on the frame. ");
			else outputText("You construct a temporary ramp to push the roof frame into place. ");
			outputText("You then hammer nails in place to secure the roof frame.\n\n");
			outputText("<b>You have finished framing the cabin! You can work on constructing wall.</b>\n\n");
			if (camp.companionsCount() == 1) outputText("Your lone camp follower comes to see what you've been working on. They nod in approval, impressed by your handiwork.");
			else if (camp.companionsCount() > 1) outputText("Your camp followers come to see what you've built so far. Most of them are even impressed.");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 7;
			fatigue(gatherWoodsORquarrySiteMineCost()*2);
			doNext(camp.returnToCampUseEightHours);
		}

		//Stage 9 - Build cabin part 2.
		private function buildCabinPart2():void {
			clearOutput();
			outputText("You can continue working on your cabin. Do you start working on walls and roof? (Cost: 200 nails and 125 wood.)\n");
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
			outputText("You walk back to your cabin construction site and resume working. You take out the book and flip pages until you come across instructions on how to finish walls and roof. \n\n");
			outputText("Segment by segment, you nail more wood on one side of the cabin. You move on to the next until the frame is covered. There is a hole where the window and door will be. You then climb up the ladder you have constructed from previous session. You then nail down the wood on roof frame. \n\n");
			outputText("Several hours flew by as you've managed to complete the walls and roof. Finally, you apply paint on the roof and walls to ensure that it's waterproof and protected from the elements. \n\n");
			outputText("<b>You have finished constructing the walls and roof!</b>\n\n");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 8;
			fatigue(gatherWoodsORquarrySiteMineCost()*2);
			doNext(camp.returnToCampUseEightHours);
		}

		//Stage 10 - Build cabin part 3 - Install door and window.
		private function buildCabinPart3():void {
			clearOutput();
			outputText("You can continue working on your cabin. Do you start work on installing door and window for your cabin? (Cost: 100 nails and 50 wood.)\n");
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
			outputText("You walk back to your cabin construction site and resume working. You take out the book and flip pages until you come across instructions on how to construct a door.\n\n");
			outputText("Following the instructions, you construct a wooden door that comes complete with a window. You frame the doorway and install the door into place.\n\n");
			outputText("Next, you flip the book pages until you come across instructions on how to construct a window with functional shutters. You measure and cut the wood into the correct sizes before you nail it together into a frame. Next, you construct two shutters and install the shutters into window frame. Finally, you install the window into place.\n\n");
			outputText("<b>You have finished installing the door and window!</b>\n\n");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 9;
			fatigue(gatherWoodsORquarrySiteMineCost()*2);
			doNext(camp.returnToCampUseFourHours);
		}

		//Stage 11 - Build cabin part 4 - Install flooring.
		private function buildCabinPart4():void {
			clearOutput();
			outputText("You can continue working on your cabin. Do you start work on installing flooring for your cabin? (Cost: 200 nails and 50 wood.)\n"); //What about adding a few stones here Additionally? 50 maybe?
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
			outputText("You walk back to your cabin construction site and resume working. You take out the book and flip pages until you come across instructions on how to install wooden flooring.\n\n");
			outputText("Following the instructions, you lay some wood on the ground and measure the gap between each wood to be consistent.\n\n");
			outputText("Next, you lay the wood and nail them in place. This takes time and effort but by the time you've finished putting the flooring into place, your cabin has wooden flooring ready to be polished. You spend the next few hours painting and polishing your floor.\n\n");
			outputText("After spending time painting, you leave the floor to dry.\n\n");
			outputText("<b>You have finished installing the flooring!</b>\n\n");
			outputText("<b>Congratulations! You have finished your cabin structure! You may want to construct some furniture though.</b>\n\n");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 10;
			flags[kFLAGS.CAMP_BUILT_CABIN] = 1;
			fatigue(gatherWoodsORquarrySiteMineCost()*2);
			doNext(enterCabinFirstTime);
		}

		//CABIN INTERACTIONS
		public function enterCabinFirstTime():void {
			clearOutput();
			outputText("You enter your newly-constructed cabin. You are proud of what you've built. Except that your cabin is empty.\n\n");
			flags[kFLAGS.CAMP_BUILT_CABIN] = 1;
			doNext(SceneLib.dungeons.cabin.enterCabin);
		}

	}
}
