/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class DualBFWhip extends Weapon {
		
		public function DualBFWhip() 
		{
			super("DBFWhip", "D.B.F.Whip", "dual big fucking whips", "a pair of big fucking whips", "whipping", 36, 2880, "Big Fucking Whips - the best solution for master tiny e-pen complex at this side of the Mareth!  This pair of 2H 5 meters long whips requires xx0 strength to fully unleash it power.", "Dual Large");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if ((game.player.str + game.player.spe) >= 225) {
				if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 27;
				else boost += 18;
			}
			if ((game.player.str + game.player.spe) >= 100) {
				if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 21;
				else boost += 12;
			}
			if ((game.player.str + game.player.spe) >= 75) {
				if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 15;
				else boost += 6;
			}
            if (((game.player.str + game.player.spe) < 75) && game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 9;
			return (9 + boost);
        }
		
		override public function canUse():Boolean {
			if (game.player.findPerk(PerkLib.DualWieldLarge) >= 0) return true;
			outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}