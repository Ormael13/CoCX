/**
 * ...
 * @author Ormael
 */
package classes.Scenes 
{
	import classes.*
	import classes.BaseContent;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class Questlog extends BaseContent
	{
		
		public function Questlog() 
		{}
		
		public function accessQuestlogMainMenu():void {
			clearOutput();
			menu();
			outputText("Tu na razie jest ściernisko ale bedzie San Francisko (I mean it's WIP description for now - in short it should say smth like: after completing each quest you will get bitche...err some rewards after doing as much as clicking. PS. You only need to click once fool (cookie to anyone who get the joke about clicking only once).)\n");
			addButton(14, "Back", playerMenu);
		}
		
	}

}