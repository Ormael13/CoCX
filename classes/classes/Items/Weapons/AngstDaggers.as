/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class AngstDaggers extends Weapon {
		
		public function AngstDaggers() 
		{
			super("AngstD","AngstDaggers","Angst Daggers","an Angst Daggers","stab",21,3360,"A pair of small blades filled with anger. To fully unleash potential of those deadly blades is required 300+ speed and 60+ strength.", "Dual Small");
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
		
		override public function canUse():Boolean {
			if (game.player.findPerk(PerkLib.DualWieldSmall) >= 0) return true;
			outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}