package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class DemonSnakespear extends Weapon
	{
		
		public function DemonSnakespear() 
		{
			super("DSSpear", "Demon Sn Spear", "demon snake spear", "a demon snake spear", "piercing stab", 20, 1600,
				"A dark steel spear imbued with corruption. Along the handle is a snake-like decoration with ruby eyes, from the mouth of which the spear tip emerges. The spear head is poisoned with an unknown venom.",
				""
			);
		}
		override public function get attack():Number {
			var base:int = 0;
			if (game.player.spe >= 75) base += 3;
			base += game.player.cor / 10;
			return (7 + base);
		}
	}

}