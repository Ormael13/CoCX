/**
 * ...
 * @author Coalsack
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class PrithvirajUrumi extends Weapon
	{
		
		public function PrithvirajUrumi() 
		{
			super("PrUrumi ","Pr.Urumi","Prithviraj urumi","a Prithviraj urumi","slash",24,4800,
					"This urumi is a weapon made of four sharp blades of shining silver-blue steel put together so as to appear like a single blade when not in use. Its handle has a motif of elephants on lacquered ivory, decorated with blue sapphires.",
					"Large", "Sword"
			);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 80) boost += 12;
			return (12 + boost); 
		}	
	}
}