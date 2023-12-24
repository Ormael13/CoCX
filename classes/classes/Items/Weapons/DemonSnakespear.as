package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.Items.ItemTags;

public class DemonSnakespear extends Weapon
	{
		
		public function DemonSnakespear()
		{
			super("DSSpear", "Demon Sn Spear", "demon snake spear", "a demon snake spear", "piercing stab", 60, 4800,
				"A dark steel spear imbued with corruption. Along the handle is a snake-like decoration with ruby eyes, from the mouth of which the spear tip emerges. The spear head is poisoned with an unknown venom.",
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
			boost += Math.round(game.player.cor / scal);
			return (20 + boost);
		}
	}

}
