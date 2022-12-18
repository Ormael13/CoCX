/**
 * ...
 * @author Lady Aeducan
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class MoonlightClaws extends Weapon
	{
		
		public function MoonlightClaws()
		{
			super("MClaws", "MoonlightClaws", "moonlight claws", "a pair of moonlight claws", "clawing punch", 0, 4000, "This pair of claws is imbued with magic, which shall be unleashed as a wave of moonlight. The magic within this will grant greated boon when charged with magic.", WP_BLEED25, WT_GAUNTLET);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 50) boost += 10;
			if (game.player.str >= 25) boost += 10;
			return (5 + boost); 
		}
	}
}