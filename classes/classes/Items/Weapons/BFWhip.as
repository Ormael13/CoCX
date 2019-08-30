/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class BFWhip extends Weapon {
		
		public function BFWhip() 
		{
			super("BFWhip", "B.F.Whip", "big fucking whip", "a big fucking whip", "whipping", 36, 1440, "Big Fucking Whip - the best solution for master tiny e-pen complex at this side of the Mareth!  This 2H 5 meters long whip requires 225 (strength+speed) to fully unleash it power.", "Large");
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
			if (game.player.findPerk(PerkLib.TitanGrip) >= 0) return true;
			outputText("You aren't skilled in handling large weapons with one hand yet to effectively use this whip. Unless you want to hurt yourself instead enemies when trying to use it...  ");
			return false;
		}
	}
}