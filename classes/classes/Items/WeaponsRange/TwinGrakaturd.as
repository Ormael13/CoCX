/**
 * ...
 * @author Liadri
 */
package classes.Items.WeaponsRange
{
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	
	public class TwinGrakaturd extends WeaponRange {
		
		public function TwinGrakaturd()
		{
			super("TwinGra", "TwinGrakaturd", "Twin Grakaturd", "a Twin Grakaturd", "shot", 25, 860, "A pair of weapon favored by gunners who like to charge in gun blazing and think after.\n\nGoblin Mech Compatibile", "Dual Firearms");
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput, slot);
			if (doOutput) outputText("You aren't skilled enough to handle this pair of firearms! (req. Dual Wield/Anty-Dexternity)  ");
			return false;
		}
	}
}
