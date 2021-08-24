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
			outputText("As you wander the battlefield, you eventually notice the rundown building in the distance. Intrigued you approach closer seeing a shrine surrounded by a few trees. How could such thing survive in this place where only remains of the massive battle are seen?\n\n");
			outputText("Entering by what seems of the entrance, well vermillion colored wooden gates would count as one likely and guarded behind the entrance on both sides by beings looking like part lions and part dogs you marvel on their almost life like features. One of them have closed mouth and other opened. Further away there is large plaza with statues located on each cardinal direction.\n\n");
			outputText("\"<i>What bring you here, young one?</i>\" while you been thinking over the reason of this place existance a voice rings you back to reality. Before you standing an older person judging by it voice clothed in clothes similar to those weared by monk covering it all body including head. It appeared so sudden as moment ago there wasn't anyone standing so close before you.\n\n");
			outputText("\"<i>You looks confused. Do not mind this old person. I just merely clean up here and there in this shrine of the four gods.</i>\" It talks again and then... vanish. Like literaly you been looking at it and after blinking it no longer there. What the heck is going on here?\n\n");
			outputText("<b>You have discovered Dilapidated Shrine. You can visit it from Places menu.</b>");
			mainmenu();
		}
		public function repeatvisitshrineintro():void {
			clearOutput();
			outputText("You decide to make a trip to the shrine. You enter the sacred ground going throu the vermillion gates and passing by guardian statues.\n\n");
			if (shinshoku()) outputText("\"<i>Ohh that you again? Not mind me i'm just cleaning here.</i>\" After reaching the yard you hear again a voice and noticing an old person that greeted you returning to sweeping the shrine as if nothing happened.\n\n");
			outputText("Reaching the main plaza you see four major sections located on each cardinal direction and also three smaller places located between the major one sections.\n\n");
			outputText("\n\nWhat would you like to do in the shrine?");
			mainmenu();
		}
		public function shrinemainmenu():void {
			clearOutput();
			outputText("You're at the large plaza with large statues situated on each cardinal direction. Behind each of them there is small buildings decorated with braided ropes with strips of paper and pair of smaller lion-dog statues on sides.\n\n");
			outputText("On opposite side of entrance there is path leading to small building with many manuscripts stored. On left there are stairs that seems to lead to underground chamber and on the right you can see small garden area.\n\n");
			outputText("\n\nWhat would you like to do in the shrine?");
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
			outputText("Walking toward the small building you finds yourself inside room that have many shelfs each with some books on them. Despite cleaness of the place you can see marks of time with all the wood furniture looking like it been left uncared for months if not years. In some places you can even see cobweebs. ");
			outputText("But to your suprise the floor looks like it been freshly cleaned up without a single speck of dust you could find.\n\n");
			outputText("Aside books there is writings all over the walls that looks like some sort of ancient language, which you can hardly read up. Maybe you should bring someone who knows more about languages of this realm on one of next visits here.\n\n");
			menu();
			addButtonDisabled(2, "Spellcraft", "Placeholder button until Lia write something on this subject ^^");//story about god of magic			//addButtonDisabled(2, "The Fall", "Placeholder button until Lia write something on this subject ^^");//collection of propercies about gods fall on area later known as battlefield
			addButtonDisabled(6, "Reaper", "Placeholder button until Lia write something on this subject ^^");//story about god of death/transformation
			addButtonDisabled(8, "Lifegiver", "Placeholder button until Lia write something on this subject ^^");//story about god of life				//addButtonDisabled(0, "Souless Ones", "Placeholder button until Lia write something on this subject ^^");//story about early days of demons/their uprising (here or other place in mareth?)
			addButtonDisabled(12, "Warmonger", "Placeholder button until Lia write something on this subject ^^");//story about god of war				//addButtonDisabled(1, "The Descent", "Placeholder button until Lia write something on this subject ^^");//orgin of soul cultivators in Mareth (here or other place in mareth?)
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
			outputText("Standing inside the building located on west direction you see a statue in middle of it, which portrait hideous yet seemly mesmerizing being. Nearly each of it bodypart seems to come from different animal you have seen in this realm, yet all together seems to create harmonical whole despite all this mismatched parts. On it arms grows two sharp extensions, ");
			outputText("that reminds mantis blade on it right arm and kamaitachi blade on it left, like an reaper scythes ready to be used at moment notice. It eyes seems to be only part that isn't misfitting looking suprisingly same, with a x shaped cross over them. At the base of the statue there is plate but due to partial rusty state of it the texts on it reads as 'E.e.ie.'. ");
			outputText("Before it lays on the ground two medium sized plates, probably used to put on offering at times there was more visitors.\n\n");
			//outputText("\n\n");
			menu();
			addButtonDisabled(0, "???", "???");//offering button or some other function
			addButton(14, "Back", shrinemainmenu);
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
			outputText("Standing inside the building located on south direction you see a few statues in middle of it, with largest one portraiting being at peak of it power. Interesting how crafter capture traits of the being making it even statue to giving the same feeling when watching it. If you had to put it into words... you almsot can still feel that being 'killing intent'. ");
			outputText("All surrounding it smaller ones figures looks like they all under some sort of berserker state and recklesly swinging their dual weapons around, each wielding different type of them.  At the base of the statue there is plate but due to partial rusty state of it the texts on it reads as 'Krat..'. ");
			outputText("Before it lays on the ground medium sized plate, probably used to put on offering at times there was more visitors.\n\n");
			menu();
			addButton(14, "Back", shrinemainmenu);
		}
	}
}