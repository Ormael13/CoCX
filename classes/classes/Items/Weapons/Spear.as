package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Player;
	
	public class Spear extends Weapon {
		
		public function Spear() {
			super("Spear", "Spear", "deadly spear", "a deadly spear", "piercing stab", 10, 400, "A staff with a sharp blade at the tip designed to pierce through the toughest armor.  This would ignore most armors.  Req. 75+ speed to unleash full attack power.");
		}
		
		override public function get attack():Number {
			var base:int = 0;
			base += 7;
			if (game.player.spe >= 75) base += 3;
			return (base);
		}
	}
}