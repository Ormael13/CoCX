package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.Items.ItemTags;

public class MoonlitSnow extends Weapon
	{
		
		public function MoonlitSnow()
		{
			super(
				"Moonlit Snow","Moonlit Snow","Moonlit Snow","a Moonlit Snow","slash",115,9200,
				"This blessed katana is made in shining steel and heavily decorated with silver and blue sapphires. When used by a pure-hearted knight, the divine will within guides each strike, making it much deadlier.", "Hybrid", "Dueling"
			);
			withTag(ItemTags.I_LEGENDARY);
		}
		override public function get attack():Number {
			var boost:int = 0;
			var scal:Number = 10;
			if (game.player.spe >= 100) {
				boost += 15;
				scal -= 3;
			}
			if (game.player.spe >= 50) {
				boost += 15;
				scal -= 2;
			}
			boost += Math.round((100 - game.player.cor) / scal);
			return (15 + (2 * boost));
		}
	}

}
