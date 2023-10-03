/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class TwinRubyClaymores extends Weapon
	{
		
		public function TwinRubyClaymores() 
		{
			super("TRClaym", "T.R.Claymore", "twin ruby claymores", "a twin ruby claymores", "cleaving sword-slash", 15, 2400, "Those twin two-handed swords are made of crimson metal and richly decorated with rubies and gold engravings. The magic within those crimson blades will flare up with magical flames when charged with magic.", "Dual Large", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 40) boost += 8;
			return (7 + boost); 
		}
	}
}