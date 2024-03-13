package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.Items.ItemTags;
import classes.PerkLib;

public class NephilimBlade extends Weapon
	{

		public function NephilimBlade()
		{
			super(
				"NPHMBlade","Nephilim Blade","nephilim blade","a nephilim blade","slash",180,7200,
				"A long lost sword, made in a shining metal, that once belonged to the demigod Nephilim. This masterfully crafted blade seeks and destroys corruption wherever it might find it, and will periodically cleanse their user body and soul.",
				"Large, LGWrath", "Sword"
			);
			withTag(ItemTags.I_LEGENDARY);
		}
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.HiddenJobSwordImmortal)) boost += 170;
			else {
				var scal:Number = 10;
				if (game.player.str >= 250) {
					boost += 50;
					scal -= 1;
				}
				if (game.player.str >= 200) {
					boost += 40;
					scal -= 1;
				}
				if (game.player.str >= 150) {
					boost += 30;
					scal -= 1;
				}
				if (game.player.str >= 100) {
					boost += 20;
					scal -= 1;
				}
				if (game.player.str >= 50) {
					boost += 10;
					scal -= 1;
				}
				boost += Math.round((100 - game.player.cor) / scal);
			}
			return (10 + boost);
		}
	}

}
