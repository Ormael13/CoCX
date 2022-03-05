/**
 * ...
 * @author Lady Aeducan
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class MoonlightGreatsword extends Weapon
	{
		
		public function MoonlightGreatsword() 
		{
			super("MGsword", "MoonlightGreatsword", "moonlight greatsword", "a moonlight greatsword", "cleaving sword-slash", 25, 3000, "This two-handed sword is imbued with his magic, which shall be unleashed as a wave of moonlight. The magic within this will grant greated boon when charged with magic.", "Large", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 50) boost += 10;
			if (game.player.str >= 25) boost += 10;
			return (5 + boost); 
		}
	}
}