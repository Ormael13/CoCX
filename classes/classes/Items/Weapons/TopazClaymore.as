/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class TopazClaymore extends Weapon
	{
		
		public function TopazClaymore() 
		{
			super("TClaymo", "T.Claymore", "topaz claymore", "a topaz claymore", "cleaving sword-slash", 15, 1200, "This two-handed sword is made of eversteel and richly decorated with yellow topazes and copper engravings. The magic within this shining blade will oversaturate the metal with electricity when charged with magic.", "Large", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 40) boost += 8;
			return (7 + boost); 
		}
	}
}