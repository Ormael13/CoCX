package classes.Items.Weapons 
{
import classes.Items.Weapon;
import classes.Items.ItemTags;
import classes.PerkLib;

public class Masamune extends Weapon
	{
		
		public function Masamune() 
		{
			super(
				"masamune","Masamune","masamune katana","a masamune katana","slash",112,8960,
				"This blessed katana is made in shining steel and heavily decorated with silver and blue sapphires. When used by a pure-hearted knight, the divine will within guides each strike, making it much deadlier.", "Large", "Dueling"
			);
			withTag(ItemTags.I_LEGENDARY);
		}
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.HiddenJobSwordImmortal)) boost += 50;
			else {
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
			}
			return (12 + (2 * boost)); 
		}
	
	}

}