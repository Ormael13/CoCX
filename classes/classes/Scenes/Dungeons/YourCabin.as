package classes.Scenes.Dungeons 
{
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Camp.CampStatsAndResources;
import classes.Scenes.SceneLib;

public class YourCabin extends DungeonAbstractContent
	{
		
		public function YourCabin() 
		{
		}
		
		public function enterCabin():void {
			inDungeon = true;
			dungeonLoc = DUNGEON_CABIN;
			menu();
			clearOutput();
			outputText("<b><u>Your Cabin</u></b>\n");
			outputText("You are in your cabin.  Behind you is a door leading back to your camp.  Next to the door is a window to let the sunlight in. \n\n");
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0)
			{
				outputText("Your bed is located at one of the corners. It's constructed with wood frame and a mattress is laid on the frame. It's covered in sheet. A pillow leans against the headboard.  ");
				if (inventory.itemStorageDirectGet().length > 0) {
					var chests:int = 0;
					if (player.hasKeyItem("Camp - Chest") >= 0) chests++;
					if (player.hasKeyItem("Camp - Murky Chest") >= 0) chests++;
					if (player.hasKeyItem("Camp - Ornate Chest") >= 0) chests++;
					outputText("Your storage " + (chests == 1 ? "chest is" : "chests are") + " located in front of your bed.")
				}
				outputText("\n\n");
			}
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] > 0)
			{
				outputText("A nightstand is situated next to your bed. ");
				if (flags[kFLAGS.BENOIT_CLOCK_BOUGHT] > 0) outputText("An alarm clock rests on your nightstand. It's currently set to go off at " + flags[kFLAGS.BENOIT_CLOCK_ALARM] + "am. ");
				if (player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] <= 0) outputText("A jewelry box sits on your nightstand.");
				outputText("\n\n")
			}
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] > 0)
			{
				outputText("Your dresser is located at side opposite from your bed. ");
				if (player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0) outputText("A jewelry box sits on your dresser.");
				outputText("\n\n")
			}
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] > 0)
			{
				outputText("A table is located right near the window. ");
				if (flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] <= 0) outputText("A chair is set near the table. ");
				if (flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] > 0) outputText("Two chairs are set at opposite sides of the table. ");
				outputText("\n\n")
			}
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] > 0)
			{
				var books:Number = 0;
				books++; //Your codex counts.
				if (player.hasKeyItem("Dangerous Plants") >= 0) books++;
				if (player.hasKeyItem("Traveler's Guide") >= 0) books++;
				if (player.hasKeyItem("Hentai Comic") >= 0) books++;
				if (player.hasKeyItem("Yoga Guide") >= 0) books++;
				if (player.hasKeyItem("Carpenter's Toolbox") >= 0) books++; //Carpenter's Guide is bundled in your toolbox!
				if (player.hasKeyItem("Izma's Book - Combat Manual") >= 0) books++;
				if (player.hasKeyItem("Izma's Book - Etiquette Guide") >= 0) books++;
				if (player.hasKeyItem("Izma's Book - Porn") >= 0) books++;
				outputText("Located at the corner opposite the door is a bookshelf.  It currently holds " + num2Text(books) + " book");
				if (books > 1) outputText("s");
				outputText(".");
				outputText("\n\n")
			}
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] > 0)
			{
				if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] > 0) outputText("A desk is located right next to your bookshelf. ");
				else outputText("Located at the corner opposite the door is a desk. ");
				outputText("It has a drawer to store supplies for writing and studying.  ");
				if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] > 0) outputText("A nicely constructed chair is tucked under the desk. It provides a place for you to sit on and study.");
				outputText("\n\n");
			}
			outputText("What would you like to do?");
			dungeons.setDungeonButtons(null, null, null, null);
			//Build menu
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] > 0) addButton(0, "Study", menuStudy);
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] > 0 && flags[kFLAGS.BENOIT_CLOCK_BOUGHT] > 0) addButton(1, "Set Alarm", menuAlarm);
			addButton(3, "Stash", inventory.stash);
			addButton(4, "Furniture", menuFurniture);
			addButton(9, "Wait", camp.doWait); //You can wait/rest/sleep in cabin.
            if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(9, "Rest", SceneLib.camp.rest);
            if (model.time.hours >= 21 || model.time.hours < 6) addButton(9, "Sleep", SceneLib.camp.doSleep);
            addButton(11, "South (Exit)", exitCabin);
			addButton(14, "Codex", camp.codex.accessCodexMenu);
			removeButton(7);
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] >= 1) removeButton(2);
			if (model.time.hours >= 23 || model.time.hours < 6) {
				removeButton(0);
			}
		}
		
		private function exitCabin():void {
			inDungeon = false;
			playerMenu();
		}
		
		private function menuAlarm():void {
			clearOutput();
			outputText("Set the hour the alarm will go off.");
			menu();
			addButton(0, "6am", setAlarm, 6);
			addButton(1, "7am", setAlarm, 7);
			addButton(2, "8am", setAlarm, 8);
			addButton(3, "9am", setAlarm, 9);
			addButton(4, "Back", enterCabin);
		}
		private function setAlarm(timeSet:int = 6):void {
			clearOutput();
			outputText("Alarm has been set to go off at " + timeSet + "am.");
			flags[kFLAGS.BENOIT_CLOCK_ALARM] = timeSet;
			doNext(enterCabin);
		}
		
		private function menuStudy():void {
			clearOutput();
			outputText("What would you like to study?");
			menu();
			if (player.hasKeyItem("Izma's Book - Porn") >= 0) addButton(1, "Porn", studyPorn).hint("Libido++");
			if (player.hasKeyItem("Izma's Book - Etiquette Guide") >= 0) addButton(2, "E.Guide", studyEtiquetteGuide).hint("Libido--");
			if (player.hasKeyItem("Izma's Book - Combat Manual") >= 0) {
				addButton(3, "C.Manual(T)", studyCombatManualToughness).hint("Toughness++");
				addButton(6, "C.Manual(I)", studyCombatManualIntelligence).hint("Intelligence++");
				addButton(7, "C.Manual(Sp)", studyCombatManualSpeed).hint("Speed++");
				addButton(8, "C.Manual(St)", studyCombatManualStrength).hint("Strength++");
			}
			addButton(14, "Back", enterCabin);
		}
		private function studyPorn():void {
			clearOutput();
			outputText("You take the book that's clearly labelled as porn from your bookshelf.  You look around to make sure you have complete privacy.\n\n");
			outputText("You wet your lips as you flick through the pages of the book and admire the rather... detailed illustrations inside.  A bee-girl getting gangbanged by imps, a minotaur getting sucked off by a pair of goblins... the artist certainly has a dirty mind.  As you flip the pages you notice the air around you heating up a bit; you attribute this to weather until you finish and close the book.\n\n");
			//(+2! Libido and lust gain)
			dynStats("lib", 2, "lus", (20+player.lib/10));
			player.KnowledgeBonus("lib",2);
			outputText("Your mind is already filled with sexual desires.  You put the pornographic book back in your bookshelf.");
			doNext(camp.returnToCampUseOneHour);
		}
		private function studyEtiquetteGuide():void {
			clearOutput();
			outputText("You take the book titled 'Etiquette Guide' from the bookshelf and sit down on the chair while you lay the book on the desk.  You open the book and study its content.\n\n");
			outputText("You peruse the strange book in an attempt to refine your manners, though you're almost offended by the stereotypes depicted within.  Still, the book has some good ideas on how to maintain chastity and decorum in the face of lewd advances.\n\n");
			//(-2 Libido, -2 Corruption)
			dynStats("lib", -2, "cor", -2);
			outputText("After reading through the frilly book, you carefully put the book back on your bookshelf.");
			doNext(camp.returnToCampUseOneHour);
		}
		private function studyCombatManualToughness():void {
			clearOutput();
			outputText("You take the book titled 'Combat Manual' from the bookshelf and sit down on the chair while you lay the book on the desk.  You open the book and study its content.\n\n");
			outputText("You learn a few new guarding stances that seem rather promising.");
			//(+2 Toughness)
			dynStats("tou", 2);
			player.KnowledgeBonus("tou",2);
			outputText("\n\nFinished learning what you can from the old rag, you close the book and put it back on your bookshelf.");
			doNext(camp.returnToCampUseOneHour);
		}
		private function studyCombatManualIntelligence():void {
			clearOutput();
			outputText("You take the book titled 'Combat Manual' from the bookshelf and sit down on the chair while you lay the book on the desk.  You open the book and study its content.\n\n");
			outputText("After a quick skim you reach the end of the book. You don't learn any new fighting moves, but the refresher on the overall mechanics and flow of combat and strategy helped.");
			//(+2 Intelligence)
			dynStats("int", 2);
			player.KnowledgeBonus("int",2);
			outputText("\n\nFinished learning what you can from the old rag, you close the book and put it back on your bookshelf.");
			doNext(camp.returnToCampUseOneHour);
		}
		private function studyCombatManualSpeed():void {
			clearOutput();
			outputText("You take the book titled 'Combat Manual' from the bookshelf and sit down on the chair while you lay the book on the desk.  You open the book and study its content.\n\n");
			outputText("You learn a few new fast striking stances that seem decent.");
			//(+2 Speed)
			dynStats("spe", 2);
			player.KnowledgeBonus("spe",2);
			outputText("\n\nFinished learning what you can from the old rag, you close the book and put it back on your bookshelf.");
			doNext(camp.returnToCampUseOneHour);
		}
		private function studyCombatManualStrength():void {
			clearOutput();
			outputText("You take the book titled 'Combat Manual' from the bookshelf and sit down on the chair while you lay the book on the desk.  You open the book and study its content.\n\n");
			outputText("Your read-through of the manual has given you insight into how to put more of your weight behind your strikes without leaving yourself open.  Very useful.");
			//(+2 Strength)
			dynStats("str", 2);
			player.KnowledgeBonus("str",2);
			outputText("\n\nFinished learning what you can from the old rag, you close the book and put it back on your bookshelf.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function menuFurniture():void {
			menu();
			clearOutput();
			outputText("What furniture would you like to construct?\n\n");
			SceneLib.campUpgrades.checkMaterials();
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
			clearOutput();
			outputText("Would you like to construct a bed? (Cost: 45 nails and 25 wood.)\n\n");
			SceneLib.campUpgrades.checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (player.fatigue <= player.maxOverFatigue() - 40) {
					if (CampStatsAndResources.NailsResc >= 45 && CampStatsAndResources.WoodResc >= 25)
					{
						doYesNo(constructFurnitureBed, menuFurniture);
					}
					else
					{
						SceneLib.camp.cabinProgress.errorNotEnough();
						doNext(playerMenu);
					}
				}
				else
				{	
					outputText("You are too exhausted to work on this furniture!");
					doNext(menuFurniture);
				}
			}
			else
			{
				SceneLib.camp.cabinProgress.errorNotHave();
				doNext(playerMenu);
			}		
		}
		
		private function constructFurnitureBed():void {
			clearOutput();
			outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a bed. After moment of thinking over something you looking for a model that could be used by two people. Maybe someday you will need that extra space to sleep since it's Mareth after all. You follow the instructions.\n\n");
			outputText("You pick up the wood and begin to construct a bed frame. You put it together and drive nails into place with your hammer.\n\n");
			outputText("Next, you add a wooden slab to the bed for mattress. With the bed finished, you go outside to pick up your bedroll and bring it inside. It easily converts to mattress, sheet, and pillow. It took you two hours to completely make a large bed from the beginning!\n\n");
			outputText("<b>You have finished your bed! (HP and Fatigue recovery increased by 50%!)</b> \n\n");
			CampStatsAndResources.NailsResc -= 45;
			CampStatsAndResources.WoodResc -= 25;
			flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] = 1;
			fatigue(40);
			doNext(camp.returnToCampUseTwoHours);
		}
		//Nightstand
		private function constructFurnitureNightstandPrompt():void {
			clearOutput();
			outputText("Would you like to construct a nightstand? (Cost: 20 nails and 10 wood.)\n\n");
			SceneLib.campUpgrades.checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (player.fatigue <= player.maxOverFatigue() - 20) {
					if (CampStatsAndResources.NailsResc >= 20 && CampStatsAndResources.WoodResc >= 10)
					{
						doYesNo(constructFurnitureNightstand, menuFurniture);
					}
					else
					{
						SceneLib.camp.cabinProgress.errorNotEnough();
						doNext(playerMenu);
					}
				}
				else
				{	
					outputText("You are too exhausted to work on this furniture!");
					doNext(menuFurniture);
				}
			}
			else
			{
				SceneLib.camp.cabinProgress.errorNotHave();
				doNext(playerMenu);
			}		
		}
		
		private function constructFurnitureNightstand():void {
			clearOutput();
			outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a nightstand. You follow the instructions.\n\n");
			outputText("You pick up the wood and begin to construct a nightstand. You cut the wood into lengths. You put it together by driving nails into place with your hammer. After putting the nightstand together, you paint the nightstand for a polished look.\n\n");
			outputText("The paint dries relatively quickly and it only took you one hour to finish your nightstand! \n\n");
			outputText("<b>You have finished your nightstand!</b> \n\n");
			CampStatsAndResources.NailsResc -= 20;
			CampStatsAndResources.WoodResc -= 10;
			flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] = 1;
			fatigue(20);
			doNext(camp.returnToCampUseOneHour);
		}
		//Dresser
		private function constructFurnitureDresserPrompt():void {
			clearOutput();
			outputText("Would you like to construct a dresser? (Cost: 50 nails and 30 wood.)\n\n");
			SceneLib.campUpgrades.checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (player.fatigue <= player.maxOverFatigue() - 60) {
					if (CampStatsAndResources.NailsResc >= 50 && CampStatsAndResources.WoodResc >= 30)
					{
						doYesNo(constructFurnitureDresser, menuFurniture);
					}
					else
					{
						SceneLib.camp.cabinProgress.errorNotEnough();
						doNext(playerMenu);
					}
				}
				else
				{	
					outputText("You are too exhausted to work on this furniture!");
					doNext(menuFurniture);
				}
			}
			else
			{
				SceneLib.camp.cabinProgress.errorNotHave();
				doNext(playerMenu);
			}		
		}
		
		private function constructFurnitureDresser():void {
			clearOutput();
			outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a dresser. You follow the instructions.\n\n");
			outputText("You pick up the wood and cut it into lengths. You nail the dresser together before you work on the drawers. You cut yet more wood and nail it together. You add a handle and a base. You just completed one of the drawers. You put a drawer into the slot. You repeat the process until all of the drawer slots are filled. \n\n");
			outputText("Next, you paint the dresser for a more polished look. \n\n");
			outputText("The paint dries relatively quickly and it took you two hours to finish your dresser. \n\n");
			outputText("<b>You have finished your dresser!</b> \n\n");
			CampStatsAndResources.NailsResc -= 50;
			CampStatsAndResources.WoodResc -= 30;
			flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] = 1;
			fatigue(60);
			doNext(camp.returnToCampUseOneHour);
		}
		//Table
		private function constructFurnitureTablePrompt():void {
			clearOutput();
			outputText("Would you like to construct a table? (Cost: 20 nails and 15 wood.)\n\n");
			SceneLib.campUpgrades.checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (player.fatigue <= player.maxOverFatigue() - 50) {
					if (CampStatsAndResources.NailsResc >= 20 && CampStatsAndResources.WoodResc >= 15)
					{
						doYesNo(constructFurnitureTable, menuFurniture);
					}
					else
					{
						SceneLib.camp.cabinProgress.errorNotEnough();
						doNext(playerMenu);
					}
				}
				else
				{	
					outputText("You are too exhausted to work on this furniture!");
					doNext(menuFurniture);
				}
			}
			else
			{
				SceneLib.camp.cabinProgress.errorNotHave();
				doNext(playerMenu);
			}		
		}
		
		private function constructFurnitureTable():void {
			clearOutput();
			outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a table. You follow the instructions.\n\n");
			outputText("You pick up the wood and begin to construct a table. You cut the wood into lengths. You put it together by driving nails into place with your hammer. After putting the table together, you paint the table for a polished look.\n\n");
			outputText("The paint dries relatively quickly and it only took you one hour to finish your table! \n\n");
			outputText("<b>You have finished your table!</b> \n\n");
			CampStatsAndResources.NailsResc -= 20;
			CampStatsAndResources.WoodResc -= 15;
			flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] = 1;
			fatigue(50);
			doNext(camp.returnToCampUseOneHour);
		}
		//Chair
		private function constructFurnitureChairPrompt():void {
			clearOutput();
			outputText("Would you like to construct a chair? (Cost: 40 nails and 10 wood.)\n\n");
			SceneLib.campUpgrades.checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (player.fatigue <= player.maxOverFatigue() - 20) {
					if (CampStatsAndResources.NailsResc >= 40 && CampStatsAndResources.WoodResc >= 10)
					{
						doYesNo(constructFurnitureChair, menuFurniture);
					}
					else
					{
						SceneLib.camp.cabinProgress.errorNotEnough();
						doNext(playerMenu);
					}
				}
				else
				{	
					outputText("You are too exhausted to work on this furniture!");
					doNext(menuFurniture);
				}
			}
			else
			{
				SceneLib.camp.cabinProgress.errorNotHave();
				doNext(playerMenu);
			}		
		}
		
		private function constructFurnitureChair():void {
			clearOutput();
			outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a chair. You follow the instructions.\n\n");
			outputText("You pick up the wood and begin to construct a chair. You cut the wood into lengths. You put it together by driving nails into place with your hammer. After putting the chair together, you paint the chair for a polished look.\n\n");
			outputText("The paint dries relatively quickly and it only took you one hour to finish your chair! \n\n");
			outputText("<b>You have finished your chair!</b> \n\n");
			CampStatsAndResources.NailsResc -= 40;
			CampStatsAndResources.WoodResc -= 10;
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] >= 1)
			{
				flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] = 1;
			}
			else
			{
				outputText("<b>Of course, you could construct another chair.</b> \n\n");
				flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] = 1;
			}
			fatigue(20);
			doNext(camp.returnToCampUseOneHour);
		}
		//Bookshelf
		private function constructFurnitureBookshelfPrompt():void {
			clearOutput();
			outputText("Would you like to construct a bookshelf? (Cost: 75 nails and 25 wood.)\n\n");
			SceneLib.campUpgrades.checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (player.fatigue <= player.maxOverFatigue() - 50) {
					if (CampStatsAndResources.NailsResc >= 75 && CampStatsAndResources.WoodResc >= 25)
					{
						doYesNo(constructFurnitureBookshelf, menuFurniture);
					}
					else
					{
						SceneLib.camp.cabinProgress.errorNotEnough();
						doNext(playerMenu);
					}
				}
				else
				{	
					outputText("You are too exhausted to work on this furniture!");
					doNext(menuFurniture);
				}
			}
			else
			{
				SceneLib.camp.cabinProgress.errorNotHave();
				doNext(playerMenu);
			}		
		}
		
		private function constructFurnitureBookshelf():void {
			clearOutput();
			outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a bookshelf. You follow the instructions.\n\n");
			outputText("You pick up the wood and begin to construct a bookshelf. You cut the wood into lengths. You put it together by driving nails into place with your hammer. After putting the bookshelf together, you paint the bookshelf for a polished look.\n\n");
			outputText("The paint dries relatively quickly and it only took you two hours to finish your bookshelf! The bookshelf can hold three rows of books but you doubt you'll be able to fill out your bookshelf.\n\n");
			outputText("<b>You have finished your bookshelf!</b> \n\n");
			if (player.hasKeyItem("Dangerous Plants") >= 0 || player.hasKeyItem("Traveler's Guide") >= 0 || player.hasKeyItem("Hentai Comic") >= 0 || player.hasKeyItem("Yoga Guide") >= 0) {
				outputText("You take your time to place your books into the bookshelf. \n\n");
			}
			CampStatsAndResources.NailsResc -= 75;
			CampStatsAndResources.WoodResc -= 25;
			flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] = 1;
			fatigue(50);
			doNext(camp.returnToCampUseOneHour);
		}
		//Desk
		private function constructFurnitureDeskPrompt():void {
			clearOutput();
			outputText("Would you like to construct a desk? (Cost: 60 nails and 20 wood.)\n\n");
			SceneLib.campUpgrades.checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (player.fatigue <= player.maxOverFatigue() - 60) {
					if (CampStatsAndResources.NailsResc >= 60 && CampStatsAndResources.WoodResc >= 20)
					{
						doYesNo(constructFurnitureDesk, menuFurniture);
					}
					else
					{
						SceneLib.camp.cabinProgress.errorNotEnough();
						doNext(playerMenu);
					}
				}
				else
				{	
					outputText("You are too exhausted to work on this furniture!");
					doNext(menuFurniture);
				}
			}
			else
			{
				SceneLib.camp.cabinProgress.errorNotHave();
				doNext(playerMenu);
			}		
		}
		
		private function constructFurnitureDesk():void {
			clearOutput();
			CampStatsAndResources.NailsResc -= 60;
			CampStatsAndResources.WoodResc -= 20;
			outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a desk. You follow the instructions.\n\n");
			outputText("You pick up the wood and begin to construct a desk. You cut the wood into lengths. You put it together by driving nails into place with your hammer. After putting the desk together, you paint the bookshelf for a polished look.\n\n");
			outputText("Next, you construct a drawer to store small objects. You nail the drawer together and paint it. Finally, you install the drawer in place.\n\n");
			outputText("The paint dries relatively quickly and it only took you two hours to finish your desk! \n\n");
			outputText("<b>You have finished your desk!</b> \n\n");
			flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] = 1;
			fatigue(60);
			doNext(camp.returnToCampUseTwoHours);
		}
		//Chair for Desk
		private function constructFurnitureChairForDeskPrompt():void {
			clearOutput();
			outputText("Would you like to construct a chair? (Cost: 40 nails and 10 wood.)\n\n");
			SceneLib.campUpgrades.checkMaterials();
			if (player.hasKeyItem("Carpenter's Toolbox")>=0)
			{
				if (player.fatigue <= player.maxOverFatigue() - 20) {
					if (CampStatsAndResources.NailsResc >= 40 && CampStatsAndResources.WoodResc >= 10)
					{
						doYesNo(constructFurnitureChairForDesk, menuFurniture);
					}
					else
					{
						SceneLib.camp.cabinProgress.errorNotEnough();
						doNext(playerMenu);
					}
				}
				else
				{	
					outputText("You are too exhausted to work on this furniture!");
					doNext(menuFurniture);
				}
			}
			else
			{
				SceneLib.camp.cabinProgress.errorNotHave();
				doNext(playerMenu);
			}		
		}
		
		private function constructFurnitureChairForDesk():void {
			clearOutput();
			outputText("You take the book from your toolbox and flip pages until you reach pages about how to construct a chair. You follow the instructions.\n\n");
			outputText("You pick up the wood and begin to construct a chair. You cut the wood into lengths. You put it together by driving nails into place with your hammer. After putting the chair together, you paint the chair for a polished look.\n\n");
			outputText("The paint dries relatively quickly and it only took you one hour to finish your chair! \n\n");
			outputText("<b>You have finished your chair!</b> \n\n");
			CampStatsAndResources.NailsResc -= 40;
			CampStatsAndResources.WoodResc -= 10;
			flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] = 1;
			fatigue(20);
			doNext(camp.returnToCampUseOneHour);
		}
	}
}