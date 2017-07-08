/**
 * ...
 * @author Zevos
 */
package classes.Scenes.Places.HeXinDao 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.NPCs.NPCAwareContent;

	public class IgnisArenaSeerScene extends NPCAwareContent
	{
		
		public function IgnisArenaSeerScene() 
		{}
		
		public function mainIgnisMenu():void {
			clearOutput();
			outputText("You walk up to Ignis, waving in greeting. ");
			if (flags[kFLAGS.IGNIS_ARENA_SEER] == 1) {
				outputText("You notice that the kitsune has changed out of his traveling gear. He is wearing a loosely fitting men’s kimono, the grey cloth complementing his white fur. His staff lays to the side,should he need to defend himself at a moment’s notice. ");
				flags[kFLAGS.IGNIS_ARENA_SEER]++;
			}
			outputText("He gives a short wave in return, motioning for you to sit next to him.  As you approach, Ignis clears his bag off the bench, making room for you.");
			menu();
			addButton(0, "Appearance", ignisAppearance);
			addButton(4, "Leave", camp.returnToCampUseOneHour);
		}
		
		public function ignisAppearance():void {
			clearOutput();
			outputText("Ignis is a kitsune, of the more animalistic variety.  He has a fox’s head with an angular jawline, adorned by a white pelt and covered by an unkempt mane of silvery hair.  Ignis’ slitted yellow eyes have a maniacal light to them. If you didn’t know better you would believe there was flame burning within them. His lower body is concealed by his flowing grey kimono, but from the way his kimono hangs off him you can see that he has a lithe form with little muscle, and a flat chest. ");
			outputText("His hands are pawlike, covered with pads and tipped with claws. Ignis has seven fox tails, though you have difficulty focusing on them for some reason. The kitsune wears no shoes or sandals, walking on digitigrade fox feet.  From the bulge in the front of his kimono, you can guess that he has a fox cock, probably knotted.  Ignis’ staff is propped nearby, a rod of silver metal engraved with mystic glyphs.");
			menu();
			addButton(14, "Back", mainIgnisMenu);
		}
		
	}

}