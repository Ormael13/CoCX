/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Player;
	import classes.PerkLib;
	import classes.StatusEffects;

	public class BFTHSword extends Weapon {
		
		public function BFTHSword() 
		{
			super("BFTHSword", "BFTHSword", "big fucking two-handed sword", "a big fucking two-handed sword", "slash", 100, 4000, "Big Fucking Two-Handed Sword - if the best solution for a tiny e-pen complex at this side of the Mareth not work take this one!  This 2H 4 meters long sword requires 250 strength to fully unleash it power.", "Massive");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 250) boost += 40;
			if (game.player.str >= 200) boost += 30;
			if (game.player.str >= 150) boost += 20;
			return (10 + boost); 
		}
		
		override public function canUse():Boolean {
			if (game.player.findPerk(PerkLib.TitanGrip) >= 0) return true;
			outputText("You aren't skilled in handling massive weapons, even when using both hands to use this sword. Just face that truth you not able to fix your tiny e-pen complex yet...  ");
			return false;
		}
	}
}