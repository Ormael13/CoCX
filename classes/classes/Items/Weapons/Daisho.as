/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.PerkLib;

public class Daisho extends Weapon {
		
		public function Daisho()
		{
			super("Daisho ","Daisho","daisho","a daisho","keen cut",15,1360,"Set of katana & wakizashi that cuts through flesh with the greatest of ease.", [WP_HYBRID, WP_AP10].join(", "), WT_DUELING);
		}
	
	override public function canEquip(doOutput:Boolean):Boolean {
		if ((game.player.hasPerk(PerkLib.DualWield) && (game.player.hasPerk(PerkLib.GigantGrip) || game.player.hasPerk(PerkLib.AntyDexterity))) || (game.player.hasPerk(PerkLib.GigantGrip) && game.player.hasPerk(PerkLib.AntyDexterity))) return super.canEquip(doOutput);
		if (doOutput) {
			if (game.player.hasPerk(PerkLib.GigantGrip) || game.player.hasPerk(PerkLib.AntyDexterity)) outputText("You aren't skilled in handling large weapons with one hand yet to effectively use this katanas & wakizashi pair. Unless you want to hurt yourself instead enemies when trying to use them...  ");
			else outputText("You aren't skilled enough to handle this katanas & wakizashi pair!  ");
		}
		return false;
	}
}
}
