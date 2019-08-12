/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class DualDaggers extends Weapon {
		
		public function DualDaggers() 
		{
			super("DDagger","D.Daggers","dual daggers","a dual daggers","stab",3,240,"A pair of small blades.  Preferred weapons for the rogues.", "Dual Small");
		}
		
		override public function canUse():Boolean {
			if (game.player.findPerk(PerkLib.DualWieldSmall) >= 0) return true;
			outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}