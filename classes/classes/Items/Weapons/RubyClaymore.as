/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class RubyClaymore extends Weapon
	{
		
		public function RubyClaymore() 
		{
			super("RClaymo", "R.Claymore", "ruby claymore", "a ruby claymore", "cleaving sword-slash", 15, 1200, "This two-handed sword is made of crimson metal and richly decorated with rubies and gold engravings. The magic within this crimson blade will flare up with magical flames when charged with magic.", "Large", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 40) boost += 8;
			return (7 + boost); 
		}
	}
}