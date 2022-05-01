/**
 * ...
 * @author ...
 */
package classes.Scenes.Areas.Battlefield 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;

	public class DilapidatedShrine extends BaseContent
	{
		
		public function DilapidatedShrine() 
		{}
		
		public function firstvisitshrineintro():void {
			flags[kFLAGS.DILAPIDATED_SHRINE_UNLOCKED] = 2;
			clearOutput();
			outputText("As you explore the battlefield, you notice a dilapidated building not far from you. You cautiously approach as your curiosity takes hold of you. A sparse amount of trees surround a shrine. It almost sparkles within the faint ambient light.\n\n");
			outputText("How could such a thing survive in a place where nothing but war has waged?\n\nYou enter what you can only assume to be the entreance. You push open the wooden door. ");
			outputText("The vermillion hued gates are remarkably crafted, yet you remain wary of potential danger. As the entrance falls behind you, you notice at both your sides rest two statues of strange beings. They seem to be half-lion and half-dog, a creature the likes of which you've never seen. You marvel at their almost life-like features. One stands with its jaw agape, the other with its lips sealed.\n\n");
			outputText("Deeper into the shrine is a large plaza with statues located on each of your cardinal directions.\n\n");
			outputText("A voice rings, breaking your thoughts, \"<i>What brings you here, young one?</i>\" Its voice is slightly raspy, clearly aged."+(silly()?" That or they seriously need to stop smoking.":"")+"\n\n");
			outputText("You turn to face an elderly person, judging by their voice and wear, not unlike something you'd expect a monk to be dressed in. Not an inch of skin is shown, everything is completely sealed within layers of fabric.\n\n");
			outputText("\"<i>You looks confused. Oh, Don't mind little ol' me. I'm merely cleaning up here and there. I can't let the shrine of the four gods grow dusty, can I?</i>\"\n\n");
			outputText("You only blink and in that instant, they've vanished. An apparition? Illusion? Best to keep your guard up, lest danger will get the best of you.\n\n");
			outputText("<b>You have discovered Dilapidated Shrine. You can visit it from Places menu.</b>");
			mainmenu();
		}
		public function repeatvisitshrineintro():void {
			clearOutput();
			outputText("You decide to make a trip to the shrine. Entering the sacred grounds, you walk through the vermillion gates, passing the guardian statues.\n\n");
			if (shinshoku()) outputText("As you reach the yard, you hear a voice again, \"<i>Oh, is that you again? Don't mind me, I'm simply maintaining the dust. They can get so riled up sometimes.</i>\" As you notice them, the old person that greeted you has returned to sweeping the shrine like you aren't even here.\n\n");
			outputText("Upon reaching the main plaza, you see four major sections located on each cardinal direction. There are three smaller places located between the major wings.\n\n");
			outputText("You consider where to go or what you should do.");
			mainmenu();
		}
		public function shrinemainmenu():void {
			clearOutput();
			outputText("You're at the open plaza, large statues situated at each cardinal direction watch over you. Behind each statue are several small buildings decorated with braded ropes, strips of paper and smaller lion-dog statues at the sides.");
			outputText("At the opposide side of the entrace is a path leading to small building with several manuscripts stored.");
			outputText("At your left is a set of stairs that seem to lead into an underground chamber.");
			outputText("At your right, you can see a small garden area.");
			outputText("You consider what you should do or where to go.");
			mainmenu();
		}
		private function mainmenu():void {
			menu();
			addButton(0, "Library", shrineLibrary);
			addButtonDisabled(2, "North", "???");//magic god subshrine
			addButtonDisabled(4, "Garden", "???");
			addButton(6, "West", westSection);
			addButtonDisabled(7, "Shinshoku", "???");//mysterious old housekeeper
			addButtonDisabled(8, "East", "???");//life god subshrine
			addButtonDisabled(10, "Crypt", "???");//heavenly kings resting place
			addButton(12, "South", southSection);
			addButton(14, "Leave", camp.returnToCampUseOneHour);
		}
		
		private function shinshoku():Boolean {
			return rand(5) == 0 && ((model.time.hours > 6 && model.time.hours < 10) || (model.time.hours > 18 && model.time.hours < 22));
		}
		
		private function shrineLibrary():void {
			clearOutput();
			outputText("As you walk toward the small building, you find yourself inside a room with countless shelves, many of which contain an assortment of books haphazardly strewn on them. Despite the cleanliness of the place, you can see the passage of time on the surrounding furniture. This place seems to have been untouched for months, if not years.\n\n");
			outputText("You notice in the corners of the room, and beneath a few shelves are cobwebs and dust bunnies, yet the floor is strangely pristine. Did someone recently sweep the place? There's not a speck of dust on the ground.\n\n");
			outputText("Aside from the books, there are scrawlings over the walls of what seems to be an ancient language. It's almost completely indecipherable. Perhaps you should bring someone who knows more about different languages next time?\n\n");
			menu();
			addButtonDisabled(2, "Spellcraft", "Placeholder button until one of the writers write something on this subject ^^");//story about god of magic			//addButtonDisabled(2, "The Fall", "Placeholder button until Lia write something on this subject ^^");//collection of propercies about gods fall on area later known as battlefield
			addButtonDisabled(6, "Reaper", "Placeholder button until one of the writers write something on this subject ^^");//story about god of death/transformation
			addButtonDisabled(8, "Lifegiver", "Placeholder button until one of the writers write write something on this subject ^^");//story about god of life				//addButtonDisabled(0, "Souless Ones", "Placeholder button until Lia write something on this subject ^^");//story about early days of demons/their uprising (here or other place in mareth?)
			addButtonDisabled(12, "Warmonger", "Placeholder button until one of the writers write write something on this subject ^^");//story about god of war				//addButtonDisabled(1, "The Descent", "Placeholder button until Lia write something on this subject ^^");//orgin of soul cultivators in Mareth (here or other place in mareth?)
			addButton(14, "Back", shrinemainmenu);
		}
		
		private function northSection():void {
			clearOutput();
			outputText("Standing inside the building located on north direction you see a statue in middle of it, ");
			outputText("Before it lays on the ground medium sized plate, probably used to put on offering at times there was more visitors.\n\n");
			menu();
			addButton(14, "Back", shrinemainmenu);
		}
		
		private function shrineGarden():void {
			clearOutput();
			outputText("\n\n");
			menu();
			addButton(14, "Back", shrinemainmenu);
		}
		
		private function westSection():void {
			clearOutput();
			outputText("Westward within the building, you see a statue in an open clearing. The towering figure portrays a hideously mesmerizing creature frozen in an aggressive pose as if it were watching you with scorn. Each limb comes from a different animal you have seen in this realm, yet all together seems to create a harmonical whole despite the chaotic ensemble.\n\n");
			outputText("Each arm extends into sharp points, much like a blade. Its left arm resembles what appears to be a mantis blade, while the right arm is a kamaitachi blade. The statue wields each arm, seemingly ready to make a move, yet almost inviting as if it wishes to guide you somewhere.\n\n");
			outputText("Its eyes seem ordinarily human-like, with an x shaped cross for pupils.\n\n");
			outputText("At the base of the statue lies a metallic plaque. Given the rust coating it, the text is hard to decipher You can only make out, 'E.e.ie.'.\n\n");
			outputText("Below the plaque lies two ornate wooden bowls, presumably used to put offerings in a time when this was a place people actively visited.\n\n");
            //The hint gives everything away. Remove it, and people won't understand what to do. Maybe no checks here?
			//if (shinshoku()) {
            outputText("A soft voice rings not far from behind you, \"<i>Sometimes all you need is a small token of goodwill to get a response. Perhaps a few chilly peppers would be enough...</i>\"\n\n");
            outputText("You turn around, expecting to see the old monk you've seen before. As you peer about, nobody is around. Are you hearing voices or was he truly here moments prior?\n\n");
			//}
			//outputText("\n\n");
			menu();
			if (player.hasItem(consumables.CHILLYP, 3)) addButton(0, "Offering", westSectionOffering);
			else addButtonDisabled(0, "???", "Perhaps if you came back with 3 Chilly peppers, like the voice said...");
			addButton(14, "Back", shrinemainmenu);
		}
		private function westSectionOffering():void {
			clearOutput();
			player.destroyItems(consumables.CHILLYP, 3);
			outputText("You place the peppers in one of the bowls, and wait for a bit. A noise distracts you for half a moment, but when you turn back, the peppers are gone, ");
			switch(rand(10)) {
				case 1:
					outputText("in the other bowl, a small, glowing syringe.");
					inventory.takeItem(useables.E_ICHOR, westSection);
					break;
				case 3:
					outputText("and a bottle of Nocello sitting in front of the statue.");
					inventory.takeItem(consumables.NOCELIQ, westSection);
					break;
				case 5:
					outputText("and a single Storm Seed rests in the other bowl.");
					inventory.takeItem(consumables.SRMSEED, westSection);
					break;
				case 7:
					outputText("replaced by a familiar looking bottle of Enigmanium.");
					inventory.takeItem(consumables.ENIGMANIUM, westSection);
					break;
				case 9:
					outputText("instead, a bottle of Infernal Wine sits before the statue.");
					inventory.takeItem(consumables.INFWINE, westSection);
					break;
				default:
					outputText("and nothing for your troubles. How disappointing.");
					break;
			}
			outputText("\n\n")
			doNext(westSection);
			cheatTime(1/12);
		}
		
		private function shrineShinshoku():void {
			clearOutput();
			outputText("\n\n");
			menu();
			addButton(14, "Back", shrinemainmenu);
		}
		
		private function eastSection():void {
			clearOutput();
			outputText("Standing inside the building located on east direction you see a statue in middle of it, ");
			outputText("Before it lays on the ground medium sized plate, probably used to put on offering at times there was more visitors.\n\n");
			menu();
			addButton(14, "Back", shrinemainmenu);
		}
		
		private function shrineCrypt():void {
			clearOutput();
			outputText("\n\n");
			menu();
			addButton(14, "Back", shrinemainmenu);
		}
		
		private function southSection():void {
			clearOutput();
			outputText("Southward within the building, you see a group of statues in an open clearing. The largest one portrays a being, one of peak strength and power.\n\n");
			outputText("It's magnificent, how crafter manages to capture traits of the being's power allows the statue to radiate awe as you gaze toward it. It's as if the figure is filled with the intent to slay and destroy anything that stands in its way.\n\n");
			outputText("The surrounding statuettes wield weapons high. Each one carrying dual weapons of a different caliber. Axes, blades, warhammers, almost recklessly waving their weapons about.\n\n");
			outputText("At the base of the largest statue lies a metallic plaque. Given the rust coating it, the text is hard to decipher. You can only make out 'Krat..' within the text.\n\n");
			outputText("Below the plaque lies an ornate wooden bowl, presumably used to put offerings in a time when this was a place people actively visited.\n\n");
			menu();
			addButton(14, "Back", shrinemainmenu);
		}
	}
}