/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class DualHugeWarhammer extends Weapon {
		
		public function DualHugeWarhammer() 
		{
			super("D.WHam", "D.WarHam", "dual huge warhammer", "a dual huge warhammer", "smash", 15, 2400, "A pair of huge war-hammers made almost entirely of steel that only the strongest warriors could use.  Getting hit with this might stun the victim.", "Dual Large");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 80) boost += 8;
			return (7 + boost); 
		}
		
		override public function canUse():Boolean {
			if (game.player.findPerk(PerkLib.DualWieldLarge) >= 0) return true;
			outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}