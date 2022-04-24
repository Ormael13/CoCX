/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.SaveableState;
	
	public class WaizAbiFollower extends NPCAwareContent implements SaveableState
	{
		public static var WaizAbiState:Number;//state or status (friend, lover, etc.)
		public static var WaizAbiAffection:Number;
		public static var WaizAbiWrathMulti:Number;
		public static var WaizAbiHPMulti:Number;
		public static var WaizAbiSoulforceMulti:Number;
		public static var WaizAbiLustMulti:Number;
		public static var WaizAbiOtherSecondaryBarsMulti:Number;//mana, fatigue ?and hunger?
		public static var WaizAbiStrMulti:Number;
		public static var WaizAbiSpeMulti:Number;
		public static var WaizAbiTouMulti:Number;
		public static var WaizAbiWisMulti:Number;
		public static var WaizAbiIntMulti:Number;
		public static var WaizAbiLibMulti:Number;
		public static var WaizAbiSensMulti:Number;

		public function stateObjectName():String {
			return "WaizAbiFollower";
		}

		public function resetState():void {
			WaizAbiState = 0;
			WaizAbiAffection = 0;
			WaizAbiWrathMulti = 1;
			WaizAbiHPMulti = 1;
			WaizAbiSoulforceMulti = 1;
			WaizAbiLustMulti = 1;
			WaizAbiOtherSecondaryBarsMulti = 1;
			WaizAbiStrMulti = 1;
			WaizAbiSpeMulti = 1;
			WaizAbiTouMulti = 1;
			WaizAbiWisMulti = 1;
			WaizAbiIntMulti = 1;
			WaizAbiLibMulti = 1;
			WaizAbiSensMulti = 1;
		}

		public function saveToObject():Object {
			return {
				"WaizAbiState": WaizAbiState,
				"WaizAbiAffection": WaizAbiAffection,
				"WaizAbiWrathMulti": WaizAbiWrathMulti,
				"WaizAbiHPMulti": WaizAbiHPMulti,
				"WaizAbiSoulforceMulti": WaizAbiSoulforceMulti,
				"WaizAbiLustMulti": WaizAbiLustMulti,
				"WaizAbiOtherSecondaryBarsMulti": WaizAbiOtherSecondaryBarsMulti,
				"WaizAbiStrMulti": WaizAbiStrMulti,
				"WaizAbiSpeMulti": WaizAbiSpeMulti,
				"WaizAbiTouMulti": WaizAbiTouMulti,
				"WaizAbiWisMulti": WaizAbiWisMulti,
				"WaizAbiIntMulti": WaizAbiIntMulti,
				"WaizAbiLibMulti": WaizAbiLibMulti,
				"WaizAbiSensMulti": WaizAbiSensMulti
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				WaizAbiState = o["WaizAbiState"];
				WaizAbiAffection = o["WaizAbiAffection"];
				WaizAbiWrathMulti = o["WaizAbiWrathMulti"];
				WaizAbiHPMulti = o["WaizAbiHPMulti"];
				WaizAbiSoulforceMulti = o["WaizAbiSoulforceMulti"];
				WaizAbiLustMulti = o["WaizAbiLustMulti"];
				WaizAbiOtherSecondaryBarsMulti = o["WaizAbiOtherSecondaryBarsMulti"];
				WaizAbiStrMulti = o["WaizAbiStrMulti"];
				WaizAbiSpeMulti = o["WaizAbiSpeMulti"];
				WaizAbiTouMulti = o["WaizAbiTouMulti"];
				WaizAbiWisMulti = o["WaizAbiWisMulti"];
				WaizAbiIntMulti = o["WaizAbiIntMulti"];
				WaizAbiLibMulti = o["WaizAbiLibMulti"];
				WaizAbiSensMulti = o["WaizAbiSensMulti"];
			} else {
				// loading from old save
				resetState();
			}
		}

		public function WaizAbiFollower() //adorable bimbo monkey... err sayian
		{
			Saves.registerSaveableState(this);
		}
		//WaizAbiStory: 1 - x, 2 - x, 3 - x
		public function bimboMonkey():void {
			clearOutput();
			outputText("\"<i>O Hai there,</i>\" she says looking over you from head to feet and back. \"<i>Mmmmm maybe you could put a good 'fight' or if not then att least good beatdown...</i>\" she trails out licking her lips slowly.\n\n");
			outputText("Wait what fight she mean? Is that some nonsense that any bimbo here would say or is ther deeper meaning to this?\n\n");
			outputText("\"<i>I not know. For now until Overgod decide otherwise you gonna be "+player.mf("blue balled","dry")+".</i>\" Her shoulders lowers in resignation.\n\n");
			menu();
			//1 - Sex (Koshu appearance here)
			//2 - Fight (And here)
			//3 - Drink (but not he.... jk also here appears)
			addButton(14, "Back", curry(SceneLib.journeyToTheEast.enteringInn, false));
		}//outputText("\"<i></i>\"\n\n");
		public function bimboMonkeySex():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
			
		}
		public function bimboMonkeyFight():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
			
		}
		public function bimboMonkeyDrink():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
			
		}
		
		public function WaizAbiMainMenu():void {
			
		}
		
		/*public function c():void {
			
		}
		
		public function b():void {
			
		}
		
		public function a():void {
			
		}*/
	}
}