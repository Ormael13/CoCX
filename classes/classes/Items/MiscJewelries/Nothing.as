/**
 * ...
 * @author Ormael
 */
package classes.Items.MiscJewelries 
{
	import classes.ItemType;
	import classes.Items.MiscJewelry;
	import classes.Player;
	
	public class Nothing extends MiscJewelry
	{
		
		public function Nothing() 
		{
			super("nomiscjewel", "nomiscjewel", "nothing", "nothing", 0, 0, 0, "no jewelry", "miscacc");
		}
		
		override public function playerRemove():MiscJewelry {
			return null; //There is nothing!
		}
	}
}