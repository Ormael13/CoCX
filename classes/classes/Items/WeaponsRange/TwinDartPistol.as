/**
 * ...
 * @author Liadri
 */
package classes.Items.WeaponsRange
{
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	
	public class TwinDartPistol extends WeaponRange {
		
		public function TwinDartPistol()
		{
			super("TDPisto", "TwinDartPistol", "Twin Dart pistol", "a Twin Dart pistol", "shot", 1, 240, "A pair of dart pistol. This weapon is not designed to wound but to deliver loads of chemical into the victim bloodstream.\n\nGoblin Mech Compatibile", "Dual Firearms");
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput);
			if (doOutput) outputText("You aren't skilled enough to handle this pair of firearms! (req. Dual Wield/Anty-Dexternity)  ");
			return false;
		}
	}
}
