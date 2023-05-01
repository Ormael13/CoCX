/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.PerkLib;

public class AngstDagger extends Weapon {
		
		public function AngstDagger() 
		{
			super("AngstD1","AngstDagger","Angst Dagger","an Angst Dagger","stab",21,1680,"A small blade filled with anger. To fully unleash potential of this deadly blade is required 300+ speed and 60+ strength.", WP_SMALL, WT_DAGGER);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 60 && game.player.spe >= 300) boost += 3;
			if (game.player.str >= 50 && game.player.spe >= 250) boost += 3;
			if (game.player.str >= 40 && game.player.spe >= 200) boost += 3;
			if (game.player.str >= 30 && game.player.spe >= 150) boost += 3;
			if (game.player.str >= 20 && game.player.spe >= 100) boost += 3;
			if (game.player.str >= 10 && game.player.spe >= 50) boost += 3;
			return (3 + boost);
		}
	}
}
