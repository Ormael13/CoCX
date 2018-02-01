package classes.Items.Weapons
{
import classes.Items.Weapon;

public class NephilimBlade extends Weapon
	{

		public function NephilimBlade()
		{
			super(
				"NPHMBlade","Nephilim Blade","nephilim blade","a nephilim blade","slash",62,2480,
				"A long lost sword, made in a shining metal. It once belonged to the demigod Nephilim. This masterfully crafted blade seeks and destroys corruption wherever it might find it. It will periodically cleanse their user body and soul.",
				"Large"
			);
		}
		override public function get attack():Number {
			var strMod:int = Math.floor(Math.min(game.player.str, 150))/50;
			var boost:int = (6 * strMod) + 5;
			boost += (20 - game.player.cor / 3);
			return (5 + boost);
		}
	}

}