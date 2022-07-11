/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.PerkLib;

public class DualDaggers extends Weapon {
		
		public function DualDaggers()
		{
			super("DDagger","D.Daggers","dual daggers","a dual daggers","stab",3,240,"A pair of small blades.  Preferred weapons for the rogues.", WP_DUAL_SMALL, WT_DAGGER);
		}
	
	override public function canEquip(doOutput:Boolean):Boolean {
		if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) {
			return super.canEquip(doOutput);
		}
		if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
		return false;
	}
}
}
