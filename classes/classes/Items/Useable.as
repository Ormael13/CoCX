/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.CoC_Settings;
	import classes.Player;

	/**
	 * Represent item that can be used but does not necessarily disappears on use. Direct subclasses should overrride
	 * "useItem" method.
	 */
	public class Useable extends CommonItem
	{

		public function useItem(player:Player,output:Boolean):void
		{
			CoC_Settings.errorAMC("Useable", "useItem", id);
		}

		public function Useable(id:String, shortName:String = null, longName:String = null, value:Number = 0, description:String = null)
		{
			super(id, shortName, longName, value, description);
		}
	}
}
