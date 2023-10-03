/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class TwinTopazClaymores extends Weapon
	{
		
		public function TwinTopazClaymores() 
		{
			super("TTClaym", "T.T.Claymore", "twin topaz claymores", "a twin topaz claymores", "cleaving sword-slash", 15, 2400, "Those twin two-handed swords are made of eversteel and richly decorated with yellow topazes and copper engravings. The magic within those shining blades will oversaturate the metal with electricity when charged with magic.", "Dual Large", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 40) boost += 8;
			return (7 + boost); 
		}
	}
}