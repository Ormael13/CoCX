/**
 * ...
 * @author Ormael
 */
package classes.Items.FlyingSwords 
{
	import classes.ItemType;
	import classes.Items.FlyingSwords;
	import classes.Player;
	
	public class Nothing extends FlyingSwords
	{
		
		public function Nothing() 
		{
			super("noflysword", "noflysword", "nothing", "no flying sword \nAttack: 0", "nothing", 0);
		}
		
		override public function playerRemove():FlyingSwords {
			return null; //There is nothing!
		}
	}
}