/**
 * @author Liadri
 */
package classes.Items.Armors 
{
	import classes.CoC;
	import classes.Items.Armor;
	import classes.Player;
	
	public class SakuraPetalKimono extends Armor
	{
		
		public function SakuraPetalKimono() 
		{
			super("SP Kimo", "SakuraPetalKimono", "sakura petal kimono", "a sakura petal kimono", 0, 1, 160, "This kimono belonged to Izumi. One of the many dresses she brought from her homeland it is comfortable and fills you with a sense of contained primal strength.", "Light");
		}
		
		override public function canUse():Boolean {
			if (game.player.tallness >= 80) return true;
			outputText("You aren't tall enough to wear this kimono!  ");
			return false;
		}
	}
}