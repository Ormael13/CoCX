/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class DualBFTHSword extends Weapon {
		
		public function DualBFTHSword() 
		{
			super("DBFTHSwo", "DBFTHSword", "dual big fucking two-handed swords", "a pair of big fucking two-handed swords", "slash", 100, 8000, "Big Fucking Two-Handed Swords - if the best solution for a tiny e-pen complex at this side of the Mareth not work take this one! This pair of 2H 4 meters long swords requires 250 strength to fully unleash their power.", "Dual Massive, LGWrath", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 250) boost += 40;
			if (game.player.str >= 200) boost += 30;
			if (game.player.str >= 150) boost += 20;
			return (10 + boost);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) && game.player.hasPerk(PerkLib.GigantGripSu) && game.player.playerHasFourArms()) return super.canEquip(doOutput);
			if (doOutput) {
				if (game.player.playerHasFourArms()) outputText("You aren't skilled enough to handle this pair of weapons!  Unless you want to hurt yourself instead of your enemies when trying to use them...  ");
				else outputText("You lack second pair of arms!  ");
			}
			return false;
		}
	}
}
