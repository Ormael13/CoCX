/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class SapphireClaymore extends Weapon
	{
		
		public function SapphireClaymore() 
		{
			super("SClaymo", "S.Claymore", "sapphire claymore", "a sapphire claymore", "cleaving sword-slash", 15, 1200, "This two-handed sword is made of azure metal and richly decorated with sapphires and silver engravings. The magic within this azure blade will radiate magical frost when charged with magic.", "Large", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 40) boost += 8;
			return (7 + boost); 
		}
	}
}