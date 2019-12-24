package classes.Scenes.Camp 
{
import classes.*;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Camp;
import classes.Scenes.SceneLib;

/**
	 * Lovely and comfortable cabin for you to sleep in peace.
	 * @author Kitteh6660
	 */
	public class CabinProgress extends BaseContent {
		
		public var maxNailSupply:int = 600;
		public function get maxWoodSupply():int {
			if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) return 900;
			return 300;
		}
		public var maxStoneSupply:int = 900;
		
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
			if (player.fatigue <= player.maxFatigue() - 50)
			{
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 1) { 
					startWork();
					return; 
				}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 2) { 
					startLayout();
					return; 
				}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 3) { 
					startThinkingOfMaterials();
					return; 
				}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 4) { 
					checkToolbox();
					return; 
				}
				//For stage 4, explore forest.
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 5) { 
					startCabinPart2();
					return;
				}
				//Build cabin!
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 6) { 
					buildCabinPart1();
					return; 
				}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 7) { 
					buildCabinPart2();
					return; 
				}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 8) {
					buildCabinPart3();
					return;
				}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 9) {
					buildCabinPart4();
					return;
				}
				//Furnish your cabin!
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 10) {
					enterCabinFirstTime();
					return;
				}
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
			doNext(camp.returnToCampUseOneHour);
		}
		
		//STAGE 2 - Survey and clear area for cabin site.
		private function startLayout():void {
			outputText("You finally decide to begin your project: a cabin.  A comfortable cabin, come complete with a bed and nightstand along with some furniture. \n\nYou begin clearing away loose debris by picking up loose rocks and sticks and move them somewhere. It takes one hour and you feel a bit exhausted but you've finished creating a space.");
			fatigue(50);
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 3;
			doNext(camp.returnToCampUseOneHour);
		}
		
		//STAGE 3 - Think of materials. Obviously, wood.
		private function startThinkingOfMaterials():void {
			outputText("Now that you have cleared an area for your cabin, you'll have to figure out how to get the resources you need. You look at the trees in the distance. Clearly, you'll need something to cut down trees. Maybe there's a shop somewhere?");
			if (player.hasItem(weapons.L__AXE) || player.weaponName == "large axe") outputText("\n\nYour large axe will suffice for the daunting task of gathering materials.");
			else 
			{	
				outputText("\n\nYou realize something; you need an axe!");
				if (camp.followerKiha())
				{
					outputText("\n\nYour dragoness lover, Kiha, might be able to assist you.");
				}
			}
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 4;
			doNext(camp.returnToCampUseOneHour);
		}

		public function canGatherWoods():Boolean {
			return (player.hasKeyItem("Carpenter's Toolbox") >= 0 || player.weapon == weapons.L__AXE || player.weapon == weapons.MACGRSW || player.weapon == weapons.RIPPER1 || player.weapon == weapons.RIPPER2 || player.isInGoblinMech()) && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] < maxWoodSupply;
		}
		//STAGE 4 - Gather woods, explore forest to encounter.
		public function gatherWoods():void {
			cleanupAfterCombat();
			outputText("While exploring the forest, you survey the trees. The trees are at the right thickness. You could cut down the trees. \n\n");
			menu();
			if (player.fatigue > player.maxFatigue() - 30) {
				outputText("<b>You are too tired to consider cutting down the trees. Perhaps some rest will suffice?</b>");
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			if (player.hasItem(weapons.L__AXE) || player.weaponName == "large axe") 
			{
				outputText("You are carrying a large axe with you.");
				addButton(0, "Axe", cutTreeTIMBER);
			}
			if (player.hasKeyItem("Carpenter's Toolbox") >= 0) 
			{
				outputText("You are carrying carpenter's box with you. It contains an axe.\n");
				addButton(0, "Axe", cutTreeTIMBER);
			}
			if (player.weapon == weapons.MACGRSW || player.weapon == weapons.RIPPER1 || player.weapon == weapons.RIPPER2) 
			{
				if (player.weapon == weapons.RIPPER2) {
					outputText("You are carrying a Ripper 2.0 with you.");
					addButton(1, "Ripper 2.0", cutTreeMechTIMBER);
				}
				else if (player.weapon == weapons.RIPPER1) {
					outputText("You are carrying a Ripper 1.0 with you.");
					addButton(1, "Ripper 1.0", cutTreeMechTIMBER);
				}
				else {
					outputText("You are carrying a Machined greatsword with you.");
					addButton(1, "Mach.Greatsword", cutTreeMechTIMBER);
				}
			}
			if (player.isInGoblinMech())
			{
				outputText("You are in goblin mech that have sawblade as melee weapon.\n");
				addButton(0, "Sawblade", cutTreeMechTIMBER);
			}
			if (camp.followerKiha()) 
			{
				outputText("You have someone who might help you. Kiha might be able to assist you.\n");
				addButton(2, "Kiha", getHelpFromKiha);
			}
			if (silly() && player.str >= 70) 
			{
				outputText("You suddenly have the strange urge to punch trees. Do you punch the tree? \n");
				addButton(3, "Punch Tree", punchTreeMinecraftStyle);
			}
			if (!(buttonIsVisible(0) || buttonIsVisible(1) || buttonIsVisible(2))) {
				outputText("<b>Unfortunately, there is nothing you can do right now.</b>");
			}
			addButton(14, "Leave", noThanks);
		}
		//Silly Mode! Punch trees the Minecraft way!
		private function punchTreeMinecraftStyle():void {
			clearOutput();
			if (player.str >= 90)
			{
				outputText("Who needs axes when you've got pure strength? Bracing yourself, you crack your knuckles and punch the tree with your mighty strength. Crack begins to form and you keep punching. As soon as the crack gets big enough, a block of wood breaks off. Strangely, the tree floats. ");
			}
			else
			{
				outputText("Who needs axes when you've got pure strength? Bracing yourself, you crack your knuckles and punch the tree with all your strength. It takes effort and while you're punching the tree, crack appears. It grows bigger as you keep punching. When the crack gets big enough, the log just broke off and the tree strangely floats. ");
			}
			outputText("You shrug and pick up the wood block when you hear crashing sound as the tree falls over and splits into many wooden blocks! Surprisingly, they clump together into one bunch. You pick the bunch of wood, noting how easy it is to carry. You return to your camp. \n\n");
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += (10 + Math.floor(player.str / 8));
			incrementWoodSupply(10 + Math.floor(player.str / 8));
			awardAchievement("Getting Wood", kACHIEVEMENTS.GENERAL_GETTING_WOOD);
			fatigue(50, USEFATG_PHYSICAL);
			doNext(camp.returnToCampUseOneHour);
		}
		//Cut down the tree yourself with large axe.
		private function cutTreeTIMBER():void {
			clearOutput();
			if (player.weaponName == "large axe") outputText("You ready your oversized axe. ");
			else outputText("You ready your axe. ");
			outputText("With your strength, you hack away at the tree, making wedge-shaped cuts. After ten strikes, you yell \"<i>TIMMMMMMMMBER!</i>\" as the tree falls and lands on the ground with a loud crash. You are quite the fine lumberjack! You then cut the felled tree into pieces and you haul the wood back to your camp.\n\n");
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += (10 + Math.floor(player.str / 8));
			incrementWoodSupply(10 + Math.floor(player.str / 8));
			fatigue(50, USEFATG_PHYSICAL);
			doNext(camp.returnToCampUseTwoHours);
		}
		//Cut down the tree yourself with Machined greatsword.
		private function cutTreeMechTIMBER():void {
			clearOutput();
			outputText("You rev up your ");
			if (player.isInGoblinMech()) outputText("chainsaw");
			else {
				if (player.weapon == weapons.RIPPER2) outputText("Ripper 2.0");
				else if (player.weapon == weapons.RIPPER1) outputText("Ripper 1.0");
				else outputText("chainsaw sword");
			}
			outputText(" as the metal teeth begin to spin. ");
			if (player.isInGoblinMech()) outputText("Pressing the joystick on your command board you move ");
			else outputText("Grabbing a hold of the handle, you press ");
			outputText("the blade into the trunk of the tree, watching it cut straight through as wood chips fly all over the place. Eventually you reach the other side of the trunk, and the tree falls over with a mighty thud. You then proceed to cut the trunk into smaller pieces and haul them back to your camp.\n\n");
			if (player.isInGoblinMech()) {
				flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += (22 + Math.floor(player.str / 4));
				incrementWoodSupply(22 + Math.floor(player.str / 4));
				doNext(camp.returnToCampUseOneHour);
			}
			else {
				flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += (13 + Math.floor(player.str / 7));
				incrementWoodSupply(13 + Math.floor(player.str / 7));
				fatigue(50, USEFATG_PHYSICAL);
				doNext(camp.returnToCampUseTwoHours);
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
			doNext(camp.returnToCampUseOneHour); //- wadą tego etapu to brak menu lub menu za wcześnie?
		}	
		
		//Get help from Kiha.
		private function getHelpFromKiha():void {
			outputText("You recall Kiha wields an oversized axe. You call out for her. After a minute, she walks over to you and says \"<i>Yes, my idiot?</i>\" You tell her that you would like her to cut down some trees so you can haul the wood. She nods and yells \"<i>Stand back!</i>\" as you stand back while you watch her easily cut down not one but two trees! With the trees cut down, you and Kiha haul the wood back to your camp. ");
			if (player.str < 33) outputText("It's a daunting task as you can only carry few of the wood at a time. Even Kiha is far superior to your carrying capacity as she can carry a lot of wood. \n\n");
			if (player.str >= 33 && player.str < 66) outputText("It's quite the chore. Though you can carry several pieces of wood at a time, Kiha is still superior to you when it comes to carrying wood. \n\n");
			if (player.str >= 66) outputText("You easily tackle the task of carrying wood. You even manage to carry five pieces of wood at a time!\n\n");
			outputText("It takes some time but you eventually bring the last of wood back to your camp. \n\n");
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += (20 + Math.floor(player.str / 5));
			incrementWoodSupply(20 + Math.floor(player.str / 5));
			fatigue(50, USEFATG_PHYSICAL);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		private function noThanks():void {
			outputText("Deciding not to cut down the tree at the moment, you return to your camp. ");
			doNext(camp.returnToCampUseOneHour);
		}
		private function noThanks2():void {
			outputText("Deciding not to work on your cabin right now, you return to the center of your camp.");
			doNext(playerMenu);
		}
		
		public function incrementWoodSupply(amount:int):void {
			outputText("<b>(+" + amount + " wood!");
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += amount;
			if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= maxWoodSupply) {
				flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = maxWoodSupply;
				outputText(" Your wood capacity is full.")
			}
			outputText(")</b>");
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
		
		//STAGE 6 - Work on cabin part 2. Planning your cabin.
		private function startCabinPart2():void {
			outputText("You take out a paper, feather pen, and ink quill to draw some plans and diagrams. You spend one hour editing and perfecting your plans, reviewing and making some final changes to your plan before you fold the paper and put it away.");
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 6;
			doNext(camp.returnToCampUseOneHour);
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
			checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 50)
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
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 50;
			outputText("Today is the day you'll actually work on building your own cabin! You clear a space and set up some rocks. You take the book from your toolbox and open it. You turn pages until you come across an instruction on how to construct frame. \n\n");
			//if (CoC.instance.amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1) outputText("\"<i>PLACEHOLDER</i>\" Amily asks. \n\n");
			outputText("You start to construct a wooden frame according to the instructions. Using your hammer and nails, you put the wood frame together and put it up. You then add temporary supports to ensure it doesn't fall down. You make two more frames of the same shape. Lastly, you construct one more frame, this time the frame is designed to have door and window.\n\n");
			if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("\"<i>My, my. What are you building?</i>\" Rathazul asks. \n\n");
			if (player.hasStatusEffect(StatusEffects.PureCampJojo)) outputText("\"<i>You're building something?</i>\" Jojo asks. \n\n");
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
			fatigue(100);
			doNext(camp.returnToCampUseEightHours);
		}
		
		//Stage 9 - Build cabin part 2.
		private function buildCabinPart2():void {
			clearOutput();
			outputText("You can continue working on your cabin. Do you start working on walls and roof? (Cost: 200 nails and 125 wood.)\n");
			checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 125)
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
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 125;
			outputText("You walk back to your cabin construction site and resume working. You take out the book and flip pages until you come across instructions on how to finish walls and roof. \n\n");
			outputText("Segment by segment, you nail more wood on one side of the cabin. You move on to the next until the frame is covered. There is a hole where the window and door will be. You then climb up the ladder you have constructed from previous session. You then nail down the wood on roof frame. \n\n");
			outputText("Several hours flew by as you've managed to complete the walls and roof. Finally, you apply paint on the roof and walls to ensure that it's waterproof and protected from the elements. \n\n");
			outputText("<b>You have finished constructing the walls and roof!</b>\n\n");		
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 8;
			fatigue(100);
			doNext(camp.returnToCampUseEightHours);
		}
		
		//Stage 10 - Build cabin part 3 - Install door and window.
		private function buildCabinPart3():void {
			clearOutput();
			outputText("You can continue working on your cabin. Do you start work on installing door and window for your cabin? (Cost: 100 nails and 50 wood.)\n");
			checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 50)
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
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 50;
			outputText("You walk back to your cabin construction site and resume working. You take out the book and flip pages until you come across instructions on how to construct a door.\n\n");
			outputText("Following the instructions, you construct a wooden door that comes complete with a window. You frame the doorway and install the door into place.\n\n");
			outputText("Next, you flip the book pages until you come across instructions on how to construct a window with functional shutters. You measure and cut the wood into the correct sizes before you nail it together into a frame. Next, you construct two shutters and install the shutters into window frame. Finally, you install the window into place.\n\n");
			outputText("<b>You have finished installing the door and window!</b>\n\n");		
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 9;
			fatigue(100);
			doNext(camp.returnToCampUseFourHours);
		}
		
		//Stage 11 - Build cabin part 4 - Install flooring.
		private function buildCabinPart4():void {
			clearOutput();
			outputText("You can continue working on your cabin. Do you start work on installing flooring for your cabin? (Cost: 200 nails and 50 wood.)\n"); //What about adding few stones here additionaly? 50 maybe?
			checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 50)
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
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 50;
			outputText("You walk back to your cabin construction site and resume working. You take out the book and flip pages until you come across instructions on how to install wooden flooring.\n\n");
			outputText("Following the instructions, you lay some wood on the ground and measure the gap between each wood to be consistent.\n\n");
			outputText("Next, you lay the wood and nail them in place. This takes time and effort but by the time you've finished putting the flooring into place, your cabin has wooden flooring ready to be polished. You spend the next few hours painting and polishing your floor.\n\n");
			outputText("After spending time painting, you leave the floor to dry.\n\n");
			outputText("<b>You have finished installing the flooring!</b>\n\n");		
			outputText("<b>Congratulations! You have finished your cabin structure! You may want to construct some furniture though.</b>\n\n");		
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 10;
			flags[kFLAGS.CAMP_BUILT_CABIN] = 1;
			fatigue(100);
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
