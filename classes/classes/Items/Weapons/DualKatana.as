/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.PerkLib;

public class DualKatana extends Weapon {
		
		public function DualKatana()
		{
			super("D.Katana","D.Katana","dual katana","a dual katana","keen cut",15,1360,"A pair of curved bladed weapons that cuts through flesh with the greatest of ease.", [WP_DUAL_LARGE, WP_AP10].join(", "), WT_DUELING);
		}
	
	override public function canEquip(doOutput:Boolean):Boolean {
		if ((game.player.hasPerk(PerkLib.DualWield) && (game.player.hasPerk(PerkLib.GigantGrip) || game.player.hasPerk(PerkLib.AntyDexterity))) || (game.player.hasPerk(PerkLib.GigantGrip) && game.player.hasPerk(PerkLib.AntyDexterity))) {
			return super.canEquip(doOutput);
		}
		if (!game.player.hasPerk(PerkLib.GigantGrip) && !game.player.hasPerk(PerkLib.AntyDexterity)) {
			if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
		if (doOutput) outputText("You aren't skilled in handling large weapons with one hand yet to effectively use those katanas. Unless you want to hurt yourself instead of your enemies when trying to use them...  ");
		return false;
	}
	}
}
