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
		public static var WaizAbiState:Number;
		public static var WaizAbiAffection:Number;

		public function stateObjectName():String {
			return "WaizAbiFollower";
		}

		public function resetState():void {
			WaizAbiState = 0;
			WaizAbiAffection = 0;
		}

		public function saveToObject():Object {
			return {
				"WaizAbiState": WaizAbiState,
				"WaizAbiAffection": WaizAbiAffection
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				WaizAbiStory = o["WaizAbiState"];
				WaizAbiAffection = o["WaizAbiAffection"];
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
		public function a():void {
			
		}
		
		public function b():void {
			
		}
		
		public function c():void {
			
		}
	}
}