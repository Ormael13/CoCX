/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class EldritchStaff extends WeaponWithPerk {
		
		public function EldritchStaff() {
			super("E.Staff", "E.Staff", "eldritch staff", "an eldritch staff", "thwack", 10, 800, "This eldritch staff once belonged to the Harpy Queen, who was killed after her defeat at your hands.  It fairly sizzles with magical power.", "Staff", PerkLib.WizardsFocus, 0.6, 0, 0, 0);
		}
		
		override public function get verb():String { 
			return game.player.hasPerk(PerkLib.StaffChanneling) ? "shot" : "thwack";
		}
	}
}