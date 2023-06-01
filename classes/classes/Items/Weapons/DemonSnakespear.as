package classes.Items.Weapons
{
import classes.Items.Weapon;

public class DemonSnakespear extends Weapon
	{
		
		public function DemonSnakespear()
		{
			super("DSSpear", "Demon Sn Spear", "demon snake spear", "a demon snake spear", "piercing stab", 60, 4800,
				"A dark steel spear imbued with corruption. Along the handle is a snake-like decoration with ruby eyes, from the mouth of which the spear tip emerges. The spear head is poisoned with an unknown venom.",
				WP_AP100, WT_SPEAR
			);
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
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if (doOutput) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
	}

}
