/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
import classes.Items.Weapon;
import classes.PerkLib;

public class DualDaggerWhips extends Weapon {
		
		public function DualDaggerWhips() 
		{
			super("DDagWhip","DualDaggerWhip","dual dagger whip","a dual dagger whip","whip-like slash",5,400,"Two small blades that is tied to the wrist by an 8 ft. cloth each.  Could be used to attack few enemies at once.", [WP_DUAL_SMALL, WP_WHIPPING].join(", "), WT_DAGGER);
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
