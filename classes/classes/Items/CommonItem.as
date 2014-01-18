/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.CoC;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.ItemType;
	import classes.Player;

	use namespace kGAMECLASS;

	public class CommonItem extends ItemType{

		public function get game():CoC{
			return kGAMECLASS;
		}
		public function getGame():CoC{
			return kGAMECLASS;
		}

		public function clearOutput():void{
			kGAMECLASS.clearOutput();
		}
		public function outputText(text:String):void{
			kGAMECLASS.outputText(text);
		}

		public function CommonItem(id:String, shortName:String=null, longName:String=null, value:Number=0, description:String=null)
		{
			super(id, shortName, longName, value, description);

		}
	}
}
