/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class DefiledOniChieftainDestroyer extends Weapon
	{
		
		public function DefiledOniChieftainDestroyer() 
		{
			super("DOCDest", "DOCDestroyer", "Defiled Oni Chieftain Destroyer", "a Defiled Oni Chieftain Destroyer", "smash", 60, 4800, "This unrealistically large two handed mace was clearly made for some legendary oni chieftain to wield. Even bigger than the standard oni tetsubo this thing could topple buildings. You likely will need some absurd strength just to lift it.", "Large");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 210) boost += 10;
			if (game.player.str >= 140) boost += 10;
			if (game.player.str >= 70) boost += 10;
			boost += (game.player.cor) / 5;
			return (10 + boost); 
		}
	}
}