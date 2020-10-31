package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class Marakumo extends Weapon
	{
		
		public function Marakumo()
		{
			super(
				"MarKumo","Marakumo","Marakumo","a Marakumo","slash",42,3360,
				"This dark blade is as beautiful as it is deadly, made in black metal and decorated with crimson ruby gemstones. Lending its power to a corrupt warrior, it will strike with an unholy force, albeit, draining some blood from its wielder on the process.", "Large"
			);
		}
		override public function get attack():Number {
			var boost:int = 0;
			boost += Math.round(game.player.cor / 10);
			return (12 + (3 * boost)); 
		}
		
	}

}