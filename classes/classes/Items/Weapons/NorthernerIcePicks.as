/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.PerkLib;

public class NorthernerIcePicks extends Weapon {
		
		public function NorthernerIcePicks()
		{
			super("NorthIP","North.I.P.","Northerner ice picks", "a Northerner ice picks", "stabs", 5, 800, "These items are normally used by climbers to move across vertical icy surfaces. While these were not to be originally used as weapons this pair of pickaxes easily pierces through armors and hides.", [WP_DUAL_SMALL, WP_AP100].join(", "), WT_EXOTIC);
		}
	
	override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput);
			if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}
