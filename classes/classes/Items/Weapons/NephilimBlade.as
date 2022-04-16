package classes.Items.Weapons
{
import classes.Items.Weapon;

public class NephilimBlade extends Weapon
	{

		public function NephilimBlade()
		{
			super(
				"NPHMBlade","Nephilim Blade","nephilim blade","a nephilim blade","slash",62,2480,
				"A long lost sword, made in a shining metal, that once belonged to the demigod Nephilim. This masterfully crafted blade seeks and destroys corruption wherever it might find it, and will periodically cleanse their user body and soul.",
				"Large, LGWrath", "Sword"
			);
		}
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 150) boost += 20;
			if (game.player.str >= 100) boost += 15;
			if (game.player.str >= 50) boost += 10;
			boost += Math.round((100-game.player.cor) / 10);
			return (7 + boost);
		}
		override public function canUse():Boolean {
			if (game.player.level >= 40) return super.canUse();
			outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
	}

}