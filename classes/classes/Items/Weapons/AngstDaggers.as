/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.PerkLib;

public class AngstDaggers extends Weapon {
		
		public function AngstDaggers()
		{
			super("AngstD","AngstDaggers","Angst Daggers","a set of Angst Daggers","stab",20,3200,"A pair of small blades filled with anger. To fully unleash potential of those deadly blades is required 300+ speed and 60+ strength.", WP_DUAL_SMALL, WT_DAGGER);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 60 && game.player.spe >= 300) boost += 3;
			if (game.player.str >= 50 && game.player.spe >= 250) boost += 3;
			if (game.player.str >= 40 && game.player.spe >= 200) boost += 3;
			if (game.player.str >= 30 && game.player.spe >= 150) boost += 3;
			if (game.player.str >= 20 && game.player.spe >= 100) boost += 3;
			if (game.player.str >= 10 && game.player.spe >= 50) boost += 3;
			return (2 + boost);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput);
			if(doOutput)outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}
