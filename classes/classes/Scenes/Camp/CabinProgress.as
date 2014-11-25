package classes.Scenes.Camp 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.BaseContent;
	
	import classes.Scenes.NPCs.*;
	import classes.Scenes.Camp;
	
	import coc.model.GameModel;
	
	/**
	 * Lovely and comfortable cabin for you to sleep in peace.
	 * @author Kitteh6660
	 */
	public class CabinProgress extends BaseContent {
		
		public function CabinProgress() {
			
		}
		
		public function initiateCabin():void {
			if (player.hasKeyItem("Nails") >= 0) player.removeKeyItem("Nails");
			//Start cabin project!
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 12) flags[kFLAGS.CAMP_BUILT_CABIN] = 1;
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 1) 
			{
				startWork();
				return;
			}
			if (flags[kFLAGS.CAMP_BUILT_CABIN] == 1) 
			{
				kGAMECLASS.dungeons.cabin.enterCabin();
				return;
			}
			if (player.fatigue <= 50)
			{
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 1) { 
					startWork() 
					return; 
				}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 2) { 
					startLayout() 
					return; 
				}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 3) { 
					startThinkingOfMaterials() 
					return; 
				}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 4) { 
					checkMaterials() 
					return; 
				}
				//For stage 4, explore forest.
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 5) { 
					startCabinPart2() 
					return;
					}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 7) { 
					startCabinPart3() 
					return;
				}
				//Build cabin!
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 8) { 
					buildCabinPart1() 
					return; 
				}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 9) { 
					buildCabinPart2() 
					return; 
				}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 10) {
					buildCabinPart3();
					return;
				}
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 11) {
					buildCabinPart4();
					return;
				}
				//Furnish your cabin!
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 12) {
					enterCabinFirstTime();
					return;
				}
			}
			else
			{	
				outputText("You are too exhausted to work on your cabin!", true);
				doNext(1);
			}
		}	
		
		//Error message
		public function errorNotEnough():void {
			outputText("\n\n<b>You do not have sufficient resources. You may buy more nails from the carpentry shop in Tel'Adre and get more wood from either the Forest or the Deepwoods.</b>", false)		
		}
		public function errorNotHave():void {
			outputText("\n\n<b>You do not have the tools to build.</b>", false)		
		}
		
		
		//STAGE 1 - A wild idea appears!
		public function startWork():void {
			outputText("You wander around your camp for a good few moments when suddenly, something crosses your mind. Yes, that's it! A cabin! Just what you would need to live comfortably instead of your tent. You wander for a good while until you find a suitable location to build your cabin. You memorize the location.", true)
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 2;
			doNext(13);
		}
		
		//STAGE 2 - Survey and clear area for cabin site.
		private function startLayout():void {
			outputText("You finally decide to begin your project. You dream of a cabin.  A comfortable cabin, come complete with bed and nightstand along with some furniture. \n\nYou begin clearing away loose debris. You pick up rocks and sticks and move them somewhere. It takes one hour and you feel a bit exhausted but you've finished creating a space.", true)
			fatigue(50);
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 3;
			doNext(13);
		}
		
		//STAGE 3 - Think of materials. Obviously, wood.
		private function startThinkingOfMaterials():void {
			outputText("Now that you have cleared an area for your cabin, you'll have to figure out the materials to build. Wood will suffice but how will you get them? You look at the trees in the distance. Clearly, you'll need something to cut down trees. Maybe there's a shop somewhere?", true);
			if (player.hasItem(weapons.L__AXE) || player.weaponName == "large axe") outputText("\n\nYour large axe will suffice for the daunting task of gathering materials.", false);
			else 
			{	
				outputText("\n\nYou realize something. You need an axe!", false);
				if (camp.followerKiha())
				{
					outputText("\n\nYour dragoness lover, Kiha, might be able to assist you.", false);
				}
			}
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 4;
			doNext(13);
		}
		
		//STAGE 4 - Gather woods, explore forest to encounter.
		public function gatherWoods():void {
			outputText("While exploring the forest, you survey the trees. The trees are at the right thickness. You could cut down the trees. \n\n", true);
			menu();
			if (player.hasItem(weapons.L__AXE) || player.weaponName == "large axe") 
			{
				outputText("You are carrying a large axe with you.", false) 
				addButton(0, "Axe", cutTreeTIMBER);
			}
			if (player.hasKeyItem("Carpenter's Toolbox") >= 0) 
			{
				outputText("You are carrying carpenter's box with you. It contains an axe.\n", false) 
				addButton(0, "Axe", cutTreeTIMBER);
			}
			if (camp.followerKiha()) 
			{
				outputText("You have someone who might help you. Kiha might be able to assist you.\n", false) 
				addButton(1, "Kiha", getHelpFromKiha);
			}
			if (silly() && player.str >= 70) 
			{
				outputText("You suddenly have the strange urge to punch trees. Do you punch the tree? \n", false) 
				addButton(2, "Punch Tree", punchTreeMinecraftStyle);
			}
			addButton(14, "Leave", noThanks);
		}
		//Silly Mode! Punch trees the Minecraft way!
		private function punchTreeMinecraftStyle():void {
			if (player.str >= 90)
			{
				outputText("Who needs axes when you've got pure strength? Bracing yourself, you crack your knuckles and punch the tree with your mighty strength. Crack begins to form and you keep punching. As soon as the crack gets big enough, a block of wood breaks off. Strangely, the tree floats. ", true);
			}
			else
			{
				outputText("Who needs axes when you've got pure strength? Bracing yourself, you crack your knuckles and punch the tree with all your strength. It takes effort and while you're punching the tree, crack appears. It grows bigger as you keep punching. When the crack gets big enough, the log just broke off and the tree strangely floats. ", true);
			}
			outputText("You shrug and pick up the wood block when suddenly, you hear crashing sound as the tree falls over and splits into many wooden blocks! Surprisingly, they clump together into one bunch. You pick the bunch of wood, noting how easy it is to carry. You return to your camp. \n\n", false);
			outputText("<b>+10 wood!</b>", false)
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += 10;
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += 10;
			if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 100)
			{
				flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 100;
				outputText(" Your wood capacity is full.", false)
			}
			awardAchievement("Getting Wood", kACHIEVEMENTS.GENERAL_GETTING_WOOD, true, true);
			fatigue(50);
			doNext(13);
		}
		//Cut down the tree yourself with large axe.
		private function cutTreeTIMBER():void {
			if (player.weaponName == "large axe") outputText("You ready your oversized axe. ", true)
			else outputText("You ready your axe. ", true)
			outputText("With your strength, you hack away at the tree, making wedge-shaped cuts. After ten strikes, you yell \"<i>TIMMMMMMMMBER!</i>\" as the tree falls and lands on the ground with a loud crash. You are quite the fine lumberjack! You then cut the felled tree into pieces and you haul the wood back to your camp.\n\n", false);
			outputText("<b>+10 wood!</b>", false)
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += 10;
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += 10;
			if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 100)
			{
				flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 100;
				outputText(" Your wood capacity is full.", false)
			}
			fatigue(50);
			doNext(14);
		}

		private function checkToolbox():void {
			if (player.hasKeyItem("Carpenter's Toolbox") >= 0 && flags[kFLAGS.CAMP_CABIN_PROGRESS] == 4)
			{
				outputText("You should be able to work on your cabin as you have toolbox. \n\n", false);
				outputText("You take out the book included in your toolbox. It's titled \"Carpenter's Guide\" and you open the book. There are hundreds of pages, most of them have illustrations on how to use tools and how to build projects. \n\n", false);
				flags[kFLAGS.CAMP_CABIN_PROGRESS] = 5;
			}
			else
			{
				outputText("You are missing a toolbox. Maybe one of the shops sell these? \n\n", false);
			}
		}	
		
		private function checkMaterials():void {
			outputText("You walk over to the site where your cabin will be built. You examine your resources. \n\n", true);
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
			outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
			checkToolbox();
			doNext(1);
		}
		
		//Get help from Kiha.
		private function getHelpFromKiha():void {
			outputText("You recall Kiha wields an oversized axe. You call out for her. After a minute, she walks over to you and says \"<i>Yes, my idiot?</i>\" You tell her that you would like her to cut down some tree so you can haul the wood. She nods and yells \"<i>Stand back!</i>\" as you stand back while you watch her easily cut down not one but two trees! With the trees cut down, you and Kiha haul the wood back to your camp. ", true)
			if (player.str < 33) outputText("It's a daunting task as you can only carry few of the wood at a time. Even Kiha is far superior to your carrying capacity as she can carry a lot of wood. \n\n", false);
			if (player.str >= 33 && player.str < 66) outputText("It's quite the chore. Though you can carry several pieces of wood at a time, Kiha is still superior to you when it comes to carrying wood. \n\n", false);
			if (player.str > 66) outputText("You easily tackle the task of carrying wood. You even manage to carry five pieces of wood at a time!\n\n", false);
			outputText("It takes some time but you eventually bring the last of wood back to your camp. \n\n", false);
			outputText("<b>+20 wood!</b>", false)
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += 20;
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] += 20;
			if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 100)
			{
				flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 100;
				outputText(" Your wood capacity is full.", false)
			}
			fatigue(50);
			doNext(14);
		}
		
		private function noThanks():void {
			outputText("Deciding not to cut down the tree at the moment, you return to your camp. ", true);
			doNext(13);
		}
		private function noThanks2():void {
			outputText("Deciding not to work on your cabin right now, you return to the center of your camp.", true);
			doNext(1);
		}
		
		//STAGE 6 - Work on cabin part 2. Planning your cabin.
		private function startCabinPart2():void {
			outputText("You take out a paper, feather pen, and ink quill. You draw some plans and diagrams. You spend one hour editing and perfecting your plans. You review and make some final changes to your plan before you fold the paper and put it away.", true);
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 7;
			doNext(13);
		}
		
		//STAGE 7 - Work on cabin part 3. Gather materials.
		private function startCabinPart3():void {
			outputText("You head back to the pile of wood planks. You unfold the paper containing your plans. You know that it'll be a daunting task. To get it started, you'll need to buy materials.\n\n", true);
			if (!player.statusAffectv1(StatusAffects.TelAdre) >= 1)
			{
				outputText("But where will you buy the materials? You keep thinking of that and finally decide to stop thinking and just get on with trying to find the shop.", false)
				doNext(camp.doCamp);
				return;
			}
			else
			{
				outputText("You are sure there's a shop in Tel'Adre that could offer materials. You estimate that you will need at least 400 gems to buy enough nails. ", false)
			}
			if (!player.hasKeyItem("Carpenter's Toolbox")) outputText("Of course, you'll have to spend more gems on a set of carpentry tools.", false)
			else flags[kFLAGS.CAMP_CABIN_PROGRESS] = 8;
			doNext(camp.doCamp);
		}
		
		//STAGE 8 - Build cabin part 1.
		private function buildCabinPart1():void {
			//No toolbox? Access denied!
			if (!player.hasKeyItem("Carpenter's Toolbox"))
			{
				outputText("You realize you don't have the toolbox to work on your cabin. You let out a sigh.", true);
				doNext(1);
				return;
			}
			//Got toolbox? Proceed!
			outputText("Now that you have the carpenter's toolbox, you can work on building. Do you start work on framing your cabin? (Cost: 100 nails and 50 wood.)\n", true);
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
			outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
			if (player.hasKeyItem("Carpenter's Toolbox"))
			{
				if (player.keyItemv1("Carpenter's Toolbox") >= 100 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 50)
				{
					doYesNo(doCabinWork1, noThanks2);
				}
				else
				{
					errorNotEnough();
					doNext(1);
				}
			}
			else
			{
				errorNotHave();
				doNext(1);
			}
		}
		
		private function doCabinWork1():void {
			player.addKeyValue("Carpenter's Toolbox", 1, -100);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 50;
			outputText("Today is the day you'll actually work on building your own cabin! You clear a space and set up some rocks. You take the book from your toolbox and open it. You turn pages until you come across an instruction on how to construct frame. \n\n", true);
			if (player.findStatusAffect(StatusAffects.CampRathazul) >= 0) outputText("\"<i>My, my. What are you building?</i>\" Rathazul asks. \n\n", false);
			if (player.findStatusAffect(StatusAffects.PureCampJojo) >= 0) outputText("\"<i>You're building something?</i>\" Jojo asks. \n\n", false);
			//if (kGAMECLASS.amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1) outputText("\"<i>PLACEHOLDER</i>\" Amily asks. \n\n", false);
			outputText("You start to construct a wooden frame according to the instructions. Using your hammer and nails, you put the wood frame together and put it up. You then add temporary supports to ensure it doesn't fall down. You make two more frames of the same shape. Lastly, you construct one more frame, this time the frame is designed to have door and window.\n\n", false);
			outputText("You nail the frames together and finally you secure the frame to the foundation.\n\n", false);
			outputText("Finally, you construct a wooden frame for the roof. This takes few hours.\n\n", false);
			if (player.canFly() && player.str >= 80) outputText("You use your wings and you lift the roof frame. You carefully place it on the frame. ", false)
			else outputText("You construct a temporary ramp to push the roof frame into place. ", false)
			outputText("You then hammer nails in place to secure the roof frame.\n\n", false);
			outputText("<b>You have finished framing the cabin! You can work on constructing wall.</b>\n\n", false);
			if (camp.hasCompanions()) outputText("Various people of your camp come to see what you've built so far. Most of them are even impressed.", false);
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 9;
			fatigue(100);
			doNext(16);
		}
		
		//Stage 9 - Build cabin part 2.
		private function buildCabinPart2():void {
			trace("Part 2")
			outputText("You can continue working on your cabin. Do you start working on walls and roof? (Cost: 200 nails and 75 wood.)\n", true);
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
			outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
			if (player.hasKeyItem("Carpenter's Toolbox"))
			{
				if (player.keyItemv1("Carpenter's Toolbox") >= 200 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 75)
				{
					doYesNo(doCabinWork2, noThanks2);
				}
				else
				{
					errorNotEnough();
					doNext(1);
				}
			}
			else
			{
				errorNotHave();
				doNext(1);
			}
		}

		private function doCabinWork2():void {
			player.addKeyValue("Carpenter's Toolbox", 1, -200);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 75;
			outputText("You walk back to your cabin construction site and resume working. You take out the book and flip pages until you come across instructions on how to finish walls and roof. \n\n", true);
			outputText("Segment by segment, you nail more wood on one side of the cabin. You move on to the next until the frame is covered. There is a hole where the window and door will be. You then climb up the ladder you have constructed from previous session. You then nail down the wood on roof frame. \n\n", false);
			outputText("Several hours flew by as you've managed to complete the walls and roof. Finally, you apply paint on the roof and walls to ensure that it's waterproof and protected from the elements. \n\n", false);
			outputText("<b>You have finished constructing the walls and roof!</b>\n\n", false);		
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 10;
			fatigue(100);
			doNext(16);
		}
		
		//Stage 10 - Build cabin part 3 - Install door and window.
		private function buildCabinPart3():void {
			outputText("You can continue working on your cabin. Do you start work on installing door and window for your cabin? (Cost: 100 nails and 50 wood.)\n", true);
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
			outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
			if (player.hasKeyItem("Carpenter's Toolbox"))
			{
				if (player.keyItemv1("Carpenter's Toolbox") >= 100 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 50)
				{
					doYesNo(doCabinWork3, noThanks2);
				}
				else
				{
					errorNotEnough();
					doNext(1);
				}
			}
			else
			{
				errorNotHave();
				doNext(1);
			}
		}

		private function doCabinWork3():void {
			player.addKeyValue("Carpenter's Toolbox", 1, -100);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 50;
			outputText("You walk back to your cabin construction site and resume working. You take out the book and flip pages until you come across instructions on how to construct a door.\n\n", true);
			outputText("Following the instructions, you construct a wooden door that comes complete with a window. You frame the doorway and install the door into place.\n\n", false);
			outputText("Next, you flip the book pages until you come across instructions on how to construct a window with functional shutters. You measure and cut the wood into the correct sizes before you nail it together into a frame. Next, you construct two shutters and install the shutters into window frame. Finally, you install the window into place.\n\n", false);
			outputText("<b>You have finished installing the door and window!</b>\n\n", false);		
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 11;
			fatigue(100);
			doNext(15);
		}
		
		//Stage 11 - Build cabin part 4 - Install flooring.
		private function buildCabinPart4():void {
			outputText("You can continue working on your cabin. Do you start work on installing flooring for your cabin? (Cost: 200 nails and 50 wood.)\n", true);
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
			outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
			if (player.hasKeyItem("Carpenter's Toolbox"))
			{
				if (player.keyItemv1("Carpenter's Toolbox") >= 200 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 50)
				{
					doYesNo(doCabinWork4, noThanks2);
				}
				else
				{
					errorNotEnough();
					doNext(1);
				}
			}
			else
			{
				errorNotHave();
				doNext(1);
			}
		}

		private function doCabinWork4():void {
			player.addKeyValue("Carpenter's Toolbox", 1, -200);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 50;
			outputText("You walk back to your cabin construction site and resume working. You take out the book and flip pages until you come across instructions on how to install wooden flooring.\n\n", true);
			outputText("Following the instructions, you lay some wood on the ground and measure the gap between each wood to be consistent.\n\n", false);
			outputText("Next, you lay the wood and nail them in place. This takes time and effort but by the time you've finished putting the flooring into place, your cabin has wooden flooring ready to be polished. You spend the next few hours painting and polishing your floor.\n\n", false);
			outputText("After spending time painting, you leave the floor to dry.\n\n", false);
			outputText("<b>You have finished installing the flooring!</b>\n\n", false);		
			outputText("<b>Congratulations! You have finished your cabin structure! You may want to construct some furniture though.</b>\n\n", false);		
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 12;
			flags[kFLAGS.CAMP_BUILT_CABIN] = 1;
			fatigue(100);
			doNext(enterCabinFirstTime);
		}

		//CABIN INTERACTIONS
		public function enterCabinFirstTime():void {
			menu();
			outputText("You enter your newly-constructed cabin. You are proud of what you've built. Except that your cabin is empty.\n\n", true);
			flags[kFLAGS.CAMP_BUILT_CABIN] = 1;
			doNext(kGAMECLASS.dungeons.cabin.enterCabin);
		}

	}
}