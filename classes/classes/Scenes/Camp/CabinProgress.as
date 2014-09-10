package classes.Scenes.Camp 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.NPCs.*;
	import classes.Scenes.Camp;
	
	/**
	 * NOT FINISHED YET. Scene currently inaccessible.
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
			enterCabin();
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
				startCabinPart1() 
				return;
				}
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] == 6) { 
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
	private function errorNotEnough():void {
		outputText("\n\n<b>You do not have sufficient resources. You may buy more nails from the carpentry shop in Tel'Adre and get more wood from either the Forest or the Deepwoods.</b>", false)		
	}
	private function errorNotHave():void {
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
		if (player.hasKeyItem("Carpenter's Toolbox")) 
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
		addButton(9, "Leave", noThanks);
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
		if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 100)
		{
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 100;
			outputText(" Your wood capacity is full.", false)
		}
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
		if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 100)
		{
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 100;
			outputText(" Your wood capacity is full..", false)
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
	
	//STAGE 5 - Work on cabin part 1, requires 100 wood. Cut wood.
	private function startCabinPart1():void {
		outputText("With sufficient wood, you begin to cut wood into planks. You know that it will take hours but in the end, you will have a nice, comfortable cabin.\n\n", true);
		if (camp.companionsCount() <= 0)
		{
			outputText("As you're alone, this will take quite a lot of time. You work up your sweat as you cut one piece of wood at a time.\n\n", false);
			outputText("<b>Several hours later...</b>\n", false);
			outputText("It's exhausting but you have finished processing the wood into workable planks. </b>You'll be able to build your cabin!</b>", false);
			fatigue(100);
			doNext(15);
		}
		if (camp.companionsCount() == 1)
		{
			outputText("You call over your only companion to assist you into processing wood.\n\n", false);
			outputText("<b>Few hours later...</b>\n", false);
			outputText("You have finished processing the wood into workable planks. It took half the time thanks to your companion for assistance. <b>You'll be able to build your cabin!</b>", false);
			fatigue(100);
			doNext(14);
		}		
		if (camp.companionsCount() >= 2)
		{
			outputText("You call over your companions to assist you into processing wood.\n\n", false);
			outputText("<b>One hour later...</b>\n", false);
			outputText("You have finished processing the wood into workable planks. Thanks to your companion, it took only one hour! <b>You'll be able to build your cabin!</b>", false);
			fatigue(50);
			doNext(13);
		}
		flags[kFLAGS.CAMP_CABIN_PROGRESS] = 6;
	}
	
	//STAGE 6 - Work on cabin part 2. Planning your cabin.
	private function startCabinPart2():void {
		outputText("With the wood stacked and prepared, you take out a paper, feather pen, and ink quill. You draw some plans and diagrams. You spend one hour editing and perfecting your plans. You review and make some final changes to your plan before you fold the paper and put it away.", true);
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
		doNext(enterCabin);
	}
	
	public function enterCabin():void {
		menu();
		outputText("You are in your cabin. \n\n", true);
		if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0)
		{
			outputText("Your bed is located at one of the corners. It's constructed with wood frame and a mattress is laid on the frame. It's covered in sheet. A pillow leans against the headboard.\n\n", false);
		}
		if (flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] > 0)
		{
			outputText("A nightstand is situated next to your bed. ", false);
			if (player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] <= 0) outputText("A jewelry box sits on your nightstand.", false);
			outputText("\n\n", false)
		}
		if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] > 0)
		{
			outputText("Your dresser is located at side opposite from your bed. ", false);
			if (player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0) outputText("A jewelry box sits on your dresser.", false);
			outputText("\n\n", false)
		}
		if (flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] > 0)
		{
			outputText("A table is located right near the window. ", false);
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] > 0) outputText("A chair is set near the table. ", false);
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] > 0) outputText("Another chair is set at the opposite side from the first chair.", false);
			outputText("\n\n", false)
		}
		outputText("What would you like to do?", false);
		
		addButton(0, "Furniture", menuFurniture);
		addButton(2, "Inventory", eventParser, 1000);
		//addButton(0, "Furniture", menuFurniture);
		addButton(9, "Leave", eventParser, 1);
	}
	
	private function menuFurniture():void {
		menu();
		outputText("What furniture would you like to construct?\n\n", true)
		if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] == 0)
		{
			outputText("<b>Your cabin is empty.</b>\n\n", true);
		}
		if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] <= 0) addButton(0, "Bed", constructFurnitureBedPrompt);
		if (flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] <= 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0) addButton(1, "Nightstand", constructFurnitureNightstandPrompt);
		if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] <= 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0) addButton(2, "Dresser", constructFurnitureDresserPrompt);
		if (flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] <= 0) addButton(3, "Table", constructFurnitureTablePrompt);
		if ((flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] <= 0 || flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] <= 0) && flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] > 0) addButton(4, "Chair", constructFurnitureChairPrompt);
		addButton(9, "Back", enterCabin);
	}
	
	//CONSTRUCT FURNITURE
	//Bed
	private function constructFurnitureBedPrompt():void {
		outputText("Would you like to construct a bed? (Cost: 30 nails and 15 wood.)\n", true);
		outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
		outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
		if (player.hasKeyItem("Carpenter's Toolbox"))
		{
			if (player.keyItemv1("Carpenter's Toolbox") >= 30 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 15)
			{
				doYesNo(constructFurnitureBed, menuFurniture);
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
	
	private function constructFurnitureBed():void {
		player.addKeyValue("Carpenter's Toolbox", 1, -30);
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 15;
		outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a bed. You follow the instructions.\n\n", true);
		outputText("You pick up the wood and begin to construct a bed frame. You put it together and drive nails into place with your hammer.\n\n", false);
		outputText("Next, you add a wooden slab to the bed for mattress. With the bed finished, you go outside to pick up your bedroll and bring it inside. It easily converts to mattress, sheet, and pillow. It took you two hours to completely make a bed from the beginning!\n\n", false);
		outputText("<b>You have finished your bed! (HP and Fatigue recovery increased by 50%!)</b> \n\n", false);
		flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] = 1;
		fatigue(30);
		doNext(14);
	}
	//Nightstand
	private function constructFurnitureNightstandPrompt():void {
		outputText("Would you like to construct a nightstand? (Cost: 20 nails and 10 wood.)\n", true);
		outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
		outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
		if (player.hasKeyItem("Carpenter's Toolbox"))
		{
			if (player.keyItemv1("Carpenter's Toolbox") >= 20 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 10)
			{
				doYesNo(constructFurnitureNightstand, menuFurniture);
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
	
	private function constructFurnitureNightstand():void {
		player.addKeyValue("Carpenter's Toolbox", 1, -20);
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 10;
		outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a nightstand. You follow the instructions.\n\n", true);
		outputText("You pick up the wood and begin to construct a nightstand. You cut the wood into lengths. You put it together by driving nails into place with your hammer. After putting the nightstand together, you paint the nightstand for a polished look.\n\n", false);
		outputText("The paint dries relatively quickly and it only took you one hour to finish your nightstand! \n\n", false);
		outputText("<b>You have finished your nightstand!</b> \n\n", false);
		flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] = 1;
		fatigue(20);
		doNext(13);
	}
	//Dresser
	private function constructFurnitureDresserPrompt():void {
		outputText("Would you like to construct a dresser? (Cost: 50 nails and 30 wood.)\n", true);
		outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
		outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
		if (player.hasKeyItem("Carpenter's Toolbox"))
		{
			if (player.keyItemv1("Carpenter's Toolbox") >= 50 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 30)
			{
				doYesNo(constructFurnitureDresser, menuFurniture);
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
	
	private function constructFurnitureDresser():void {
		player.addKeyValue("Carpenter's Toolbox", 1, -50);
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 30;
		outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a dresser. You follow the instructions.\n\n", true);
		outputText("You pick up the wood and cut it into lengths. You nail the dresser together before you work on the drawers. You cut yet more wood and nail it together. You add a handle and a base. You just completed one of the drawers. You put a drawer into the slot. You repeat the process until all of the drawer slots are filled. \n\n", false);
		outputText("Next, you paint the dresser for a more polished look. \n\n", false);
		outputText("The paint dries relatively quickly and it took you two hours to finish your dresser. \n\n", false);
		outputText("<b>You have finished your dresser!</b> \n\n", false);
		flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] = 1;
		fatigue(40);
		doNext(14);
	}
	//Table
	private function constructFurnitureTablePrompt():void {
		outputText("Would you like to construct a table? (Cost: 20 nails and 15 wood.)\n", true);
		outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
		outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
		if (player.hasKeyItem("Carpenter's Toolbox"))
		{
			if (player.keyItemv1("Carpenter's Toolbox") >= 20 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 15)
			{
				doYesNo(constructFurnitureTable, menuFurniture);
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
	
	private function constructFurnitureTable():void {
		player.addKeyValue("Carpenter's Toolbox", 1, -20);
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 15;
		outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a table. You follow the instructions.\n\n", true);
		outputText("You pick up the wood and begin to construct a table. You cut the wood into lengths. You put it together by driving nails into place with your hammer. After putting the table together, you paint the table for a polished look.\n\n", false);
		outputText("The paint dries relatively quickly and it only took you one hour to finish your table! \n\n", false);
		outputText("<b>You have finished your table!</b> \n\n", false);
		flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] = 1;
		fatigue(40);
		doNext(13);
	}
	//Chair
	private function constructFurnitureChairPrompt():void {
		outputText("Would you like to construct a chair? (Cost: 40 nails and 10 wood.)\n", true);
		outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
		outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
		if (player.hasKeyItem("Carpenter's Toolbox"))
		{
			if (player.keyItemv1("Carpenter's Toolbox") >= 40 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 10)
			{
				doYesNo(constructFurnitureChair, menuFurniture);
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
	
	private function constructFurnitureChair():void {
		player.addKeyValue("Carpenter's Toolbox", 1, -40);
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 10;
		outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a chair. You follow the instructions.\n\n", true);
		outputText("You pick up the wood and begin to construct a table. You cut the wood into lengths. You put it together by drive nails into place with your hammer. After putting the chair together, you paint the chair for a polished look.\n\n", false);
		outputText("The paint dries relatively quickly and it only took you one hour to finish your table! \n\n", false);
		outputText("<b>You have finished your chair!</b> \n\n", false);
		if (flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] >= 1)
		{
			flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] = 1;
		}
		else
		{
			outputText("<b>Of course, you could construct another chair.</b> \n\n", false);
			flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] = 1;
		}
		fatigue(40);
		doNext(13);
	}
	
	}
}