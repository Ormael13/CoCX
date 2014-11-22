package classes.Scenes.Dungeons 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.BaseContent;
	import classes.Scenes.Dungeons.DungeonAbstractContent;
	import classes.Scenes.Dungeons.DungeonEngine;
	
	public class YourCabin extends DungeonAbstractContent
	{
		
		public function YourCabin() 
		{
		}
		
		public function enterCabin():void {
			kGAMECLASS.inDungeon = true;
			kGAMECLASS.dungeonLoc = -10;
			kGAMECLASS.tooltipLoc = "Cabin";
			menu();
			outputText("<b><u>Your Cabin</u></b>\n", true)
			outputText("You are in your cabin.  Behind you is a door leading back to your camp.  Next to the door is a window to let the sunlight in. \n\n");
			
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0)
			{
				outputText("Your bed is located at one of the corners. It's constructed with wood frame and a mattress is laid on the frame. It's covered in sheet. A pillow leans against the headboard.  ", false);
				if (player.hasKeyItem("Camp - Chest")) outputText("Your storage chest is located in front of your bed.")
				outputText("\n\n", false);
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
				if (flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] <= 0) outputText("A chair is set near the table. ", false);
				if (flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] > 0) outputText("Two chairs are set at opposite sides of the table. ", false);
				outputText("\n\n", false)
			}
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] > 0)
			{
				var books:Number = 0
				books++ //Your codex counts.
				if (player.hasKeyItem("Dangerous Plants") >= 0) books++;
				if (player.hasKeyItem("Traveler's Guide") >= 0) books++;
				if (player.hasKeyItem("Hentai Comic") >= 0) books++;
				if (player.hasKeyItem("Yoga Guide") >= 0) books++;
				if (player.hasKeyItem("Carpenter's Toolbox") >= 0) books++; //Carpenter's Guide is bundled in your toolbox!
				outputText("Located at the corner opposite the door is a bookshelf.  It currently holds " + num2Text(books) + " book", false);
				if (books > 1) outputText("s", false);
				outputText(".", false);
				outputText("\n\n", false)
			}
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] > 0)
			{
				if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] > 0) outputText("A desk is located right next to your bookshelf. ");
				else outputText("Located at the corner opposite the door is a desk. ");
				outputText("It has a drawer to store supplies for writing and studying.  ");
				if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] > 0) outputText("A nicely constructed chair is tucked under the desk. It provides a place for you to sit on and study.");
				outputText("\n\n");
			}
			outputText("What would you like to do?", false);

			dungeons.setDungeonButtons(null, null, null, null);
			//Build menu
			addButton(2, "Furniture", menuFurniture);
			//addButton(1, "Read Books", eventParser, 0);
			addButton(3, "Stash", kGAMECLASS.camp.initiateStash);
			addButton(6, "South (Exit)", exitCabin);
			removeButton(7);
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] >= 1) removeButton(2);
			
		}
		
		private function exitCabin():void {
			kGAMECLASS.inDungeon = false;
			kGAMECLASS.dungeonLoc = -1;
			eventParser(1);
		}
	
		private function menuFurniture():void {
			menu();
			outputText("What furniture would you like to construct?\n\n", true)
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
			outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] == 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] == 0)
			{
				outputText("<b>Your cabin is empty.</b>\n\n");
			}
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] >= 1)
			{
				outputText("<b>You have constructed every furniture available!</b>\n\n");
			}		
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] <= 0) addButton(0, "Bed", constructFurnitureBedPrompt);
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] <= 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0) addButton(1, "Nightstand", constructFurnitureNightstandPrompt);
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] <= 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0) addButton(2, "Dresser", constructFurnitureDresserPrompt);
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] <= 0) addButton(3, "Table", constructFurnitureTablePrompt);
			if ((flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] <= 0 || flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] <= 0) && flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] > 0) addButton(4, "Chair", constructFurnitureChairPrompt);
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] <= 0) addButton(5, "Bookshelf" , constructFurnitureBookshelfPrompt);
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] <= 0) addButton(6, "Desk" , constructFurnitureDeskPrompt);
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] <= 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] > 0) addButton(7, "Chair 4 Desk" , constructFurnitureChairForDeskPrompt);
			addButton(14, "Back", enterCabin);
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
					kGAMECLASS.camp.cabinProgress.errorNotEnough();
					doNext(1);
				}
			}
			else
			{
				kGAMECLASS.camp.cabinProgress.errorNotHave();
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
					kGAMECLASS.camp.cabinProgress.errorNotEnough();
					doNext(1);
				}
			}
			else
			{
				kGAMECLASS.camp.cabinProgress.errorNotHave();
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
					kGAMECLASS.camp.cabinProgress.errorNotEnough();
					doNext(1);
				}
			}
			else
			{
				kGAMECLASS.camp.cabinProgress.errorNotHave();
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
			fatigue(60);
			cheatTime(2);
			doNext(1);
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
					kGAMECLASS.camp.cabinProgress.errorNotEnough();
					doNext(1);
				}
			}
			else
			{
				kGAMECLASS.camp.cabinProgress.errorNotHave();
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
			fatigue(50);
			cheatTime(1);
			doNext(1);
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
					kGAMECLASS.camp.cabinProgress.errorNotEnough();
					doNext(1);
				}
			}
			else
			{
				kGAMECLASS.camp.cabinProgress.errorNotHave();
				doNext(1);
			}		
		}
		
		private function constructFurnitureChair():void {
			player.addKeyValue("Carpenter's Toolbox", 1, -40);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 10;
			outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a chair. You follow the instructions.\n\n", true);
			outputText("You pick up the wood and begin to construct a chair. You cut the wood into lengths. You put it together by driving nails into place with your hammer. After putting the chair together, you paint the chair for a polished look.\n\n", false);
			outputText("The paint dries relatively quickly and it only took you one hour to finish your chair! \n\n", false);
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
			fatigue(20);
			cheatTime(1);
			doNext(1);
		}
		//Bookshelf
		private function constructFurnitureBookshelfPrompt():void {
			outputText("Would you like to construct a bookshelf? (Cost: 75 nails and 25 wood.)\n", true);
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
			outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
			if (player.hasKeyItem("Carpenter's Toolbox"))
			{
				if (player.keyItemv1("Carpenter's Toolbox") >= 75 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 25)
				{
					doYesNo(constructFurnitureBookshelf, menuFurniture);
				}
				else
				{
					kGAMECLASS.camp.cabinProgress.errorNotEnough();
					doNext(1);
				}
			}
			else
			{
				kGAMECLASS.camp.cabinProgress.errorNotHave();
				doNext(1);
			}		
		}
		
		private function constructFurnitureBookshelf():void {
			player.addKeyValue("Carpenter's Toolbox", 1, -75);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 25;
			outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a bookshelf. You follow the instructions.\n\n", true);
			outputText("You pick up the wood and begin to construct a bookshelf. You cut the wood into lengths. You put it together by driving nails into place with your hammer. After putting the bookshelf together, you paint the bookshelf for a polished look.\n\n", false);
			outputText("The paint dries relatively quickly and it only took you two hours to finish your bookshelf! The bookshelf can hold three rows of books but you doubt you'll be able to fill out your bookshelf.\n\n", false);
			outputText("<b>You have finished your bookshelf!</b> \n\n", false);
			if (player.hasKeyItem("Dangerous Plants") >= 0 || player.hasKeyItem("Traveler's Guide") >= 0 || player.hasKeyItem("Hentai Comic") >= 0 || player.hasKeyItem("Yoga Guide") >= 0) {
				outputText("You take your time to place your books into the bookshelf. \n\n", false);
			}
			flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] = 1;
			fatigue(50);
			cheatTime(1);
			doNext(1);
		}
		//Desk
		private function constructFurnitureDeskPrompt():void {
			outputText("Would you like to construct a desk? (Cost: 60 nails and 20 wood.)\n", true);
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
			outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
			if (player.hasKeyItem("Carpenter's Toolbox"))
			{
				if (player.keyItemv1("Carpenter's Toolbox") >= 60 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 20)
				{
					doYesNo(constructFurnitureDesk, menuFurniture);
				}
				else
				{
					kGAMECLASS.camp.cabinProgress.errorNotEnough();
					doNext(1);
				}
			}
			else
			{
				kGAMECLASS.camp.cabinProgress.errorNotHave();
				doNext(1);
			}		
		}
		
		private function constructFurnitureDesk():void {
			player.addKeyValue("Carpenter's Toolbox", 1, -60);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 20;
			outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a desk. You follow the instructions.\n\n", true);
			outputText("You pick up the wood and begin to construct a desk. You cut the wood into lengths. You put it together by driving nails into place with your hammer. After putting the desk together, you paint the bookshelf for a polished look.\n\n", false);
			outputText("Next, you construct a drawer to store small objects. You nail the drawer together and paint it. Finally, you install the drawer in place.\n\n")
			outputText("The paint dries relatively quickly and it only took you two hours to finish your desk! \n\n", false);
			outputText("<b>You have finished your desk!</b> \n\n", false);
			flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] = 1;
			fatigue(60);
			cheatTime(2);
			doNext(1);
		}
		//Chair for Desk
		private function constructFurnitureChairForDeskPrompt():void {
			outputText("Would you like to construct a chair? (Cost: 40 nails and 10 wood.)\n", true);
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/100\n", false);
			outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/200 \n", false);
			if (player.hasKeyItem("Carpenter's Toolbox"))
			{
				if (player.keyItemv1("Carpenter's Toolbox") >= 40 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 10)
				{
					doYesNo(constructFurnitureChairForDesk, menuFurniture);
				}
				else
				{
					kGAMECLASS.camp.cabinProgress.errorNotEnough();
					doNext(1);
				}
			}
			else
			{
				kGAMECLASS.camp.cabinProgress.errorNotHave();
				doNext(1);
			}		
		}
		
		private function constructFurnitureChairForDesk():void {
			player.addKeyValue("Carpenter's Toolbox", 1, -40);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 10;
			outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a chair. You follow the instructions.\n\n", true);
			outputText("You pick up the wood and begin to construct a chair. You cut the wood into lengths. You put it together by driving nails into place with your hammer. After putting the chair together, you paint the chair for a polished look.\n\n", false);
			outputText("The paint dries relatively quickly and it only took you one hour to finish your chair! \n\n", false);
			outputText("<b>You have finished your chair!</b> \n\n", false);
			flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] = 1;
			fatigue(20);
			cheatTime(1);
			doNext(1);
		}
		
	}

}