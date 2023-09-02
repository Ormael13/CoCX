/**
 * ...
 * @author Ormael
 */
package classes.Items.WeaponsRange
{
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	
	public class TwinSixShooter extends WeaponRange {
		
		public function TwinSixShooter() 
		{
			super("TwinSixS", "TwinSixShooter", "Twin Six shooter", "a Twin Six shooter", "shot", 20, 1160, "A two revolvers with six chambers. Their shots are deadly and precise.", "Dual Firearms");
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput);
			if (doOutput) outputText("You aren't skilled enough to handle this pair of firearms!  ");
			return false;
		}
	}
}
