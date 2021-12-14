/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class OniTetsubo extends Weapon
	{
		
		public function OniTetsubo() 
		{
			super("O.Tetsu", "OniTetsubo", "Oni Tetsubo", "an Oni Tetsubo", "smash", 45, 3600, "This unrealistically large two handed mace was clearly made for Oni warriors to wield. You likely will need some ridiculous strength just to lift it.", "Large, Whirlwind, LGWrath, Stun10", "Mace/Hammer, Tetsubo");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 180) boost += 15;
			if (game.player.str >= 120) boost += 15;
			if (game.player.str >= 60) boost += 10;
			return (5 + boost); 
		}
	}
}