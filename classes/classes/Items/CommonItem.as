/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
import classes.EngineCore;
import classes.CoC;
import classes.ItemType;
import classes.Player;

use namespace CoC;

	public class CommonItem extends ItemType{

		public function get game():CoC{
			return CoC.instance;
		}

		public function clearOutput():void{
			EngineCore.clearOutput();
		}
		public function outputText(text:String):void{
			EngineCore.outputText(text);
		}

		public function CommonItem(id:String, shortName:String=null, longName:String=null, value:Number=0, description:String=null)
		{
			super(id, shortName, longName, value, description);

		}
	}
}