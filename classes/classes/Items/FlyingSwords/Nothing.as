/**
 * ...
 * @author Ormael
 */
package classes.Items.FlyingSwords
{
	import classes.Items.FlyingSwords;
	
	public class Nothing extends FlyingSwords
	{
		
		public function Nothing()
		{
			super("noflysword", "noflysword", "nothing", "no flying sword \nAttack: 0", "nothing", 0);
		}
		
		override public function get isNothing():Boolean {
			return true;
		}
	}
}
