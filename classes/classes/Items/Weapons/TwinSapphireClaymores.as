/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class TwinSapphireClaymores extends Weapon
	{
		
		public function TwinSapphireClaymores() 
		{
			super("TSClaym", "T.S.Claymore", "twin sapphire claymores", "a twin sapphire claymores", "cleaving sword-slash", 15, 2400, "Those twin two-handed swords are made of azure metal and richly decorated with sapphires and silver engravings. The magic within those azure blades will radiate magical frost when charged with magic.", "Dual Large", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 40) boost += 8;
			return (7 + boost); 
		}
	}
}