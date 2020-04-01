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

	public class UndefeatedKingDestroyer extends Weapon {
		
		public function UndefeatedKingDestroyer() 
		{
			super("UDKDest", "UDKDestroyer", "Undefeated King's Destroyer", "an Undefeated King's Destroyer", "smash", 75, 9000, "This unrealistically large two handed mace belonged in the past to the king, which claimed to be undefeated. To just lift it you will need some absurd strength and know special technique to wield such type of weapons.", "Massive");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 250) boost += 25;
			if (game.player.str >= 200) boost += 20;
			if (game.player.str >= 150) boost += 15;
			return (15 + boost); 
		}
		
		override public function canUse():Boolean {
			if (game.player.findPerk(PerkLib.GigantGrip) >= 0) return true;
			outputText("You aren't skilled in handling massive weapons, even when using both hands to use this mace. Just face that truth you not even close to Undefeated King level yet...  ");
			return false;
		}
	}
}