package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.Items.ItemTags;

public class SeraphicSpear extends Weapon
	{
		
		public function SeraphicSpear()
		{
			super("SeSpear", "Seraph Spear", "seraph spear", "a seraph spear", "piercing stab", 60, 4800,
				"A silvery spear imbued with holy power and decorated with blue sapphire gemstones. Engraved in the handle is an ancient runic spell made to ward evil. This blessed equipment seems to slowly heal its wielder’s wounds.",
				WP_AP100, WT_SPEAR
			);
			withTag(ItemTags.I_LEGENDARY);
		}
		override public function get attack():Number {
			var boost:int = 0;
			var scal:Number = 10;
			if (game.player.str >= 100) {
				boost += 20;
				scal -= 3;
			}
			if (game.player.str >= 50) {
				boost += 20;
				scal -= 2;
			}
			boost += Math.round((100 - game.player.cor) / scal);
			return (20 + boost);
		}
	}

}
