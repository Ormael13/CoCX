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

	public class GiantShuriken extends Weapon {
		
		public function GiantShuriken()
		{
			super("G.Shuri","GiantShuriken","Giant Shuriken","a Giant Shuriken","slash",52,2080,"An inordinately large shuriken. Capable of being thrown by those strong enough to properly hold it.", "Massive");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 250) boost += 24;
			if (game.player.str >= 200) boost += 16;
			if (game.player.str >= 150) boost += 8;
			return (4 + boost); 
		}
		
		override public function canUse():Boolean {
			if (game.player.hasPerk(PerkLib.GigantGrip)) return true;
			outputText("You aren't skilled in handling massive weapons, even when using both hands to use this sword.  ");
			return false;
		}
	}
}