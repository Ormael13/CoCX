/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class AmphystStaff extends WeaponWithPerk {
		
		public function AmphystStaff() {
			super("A.Staff", "A. Staff", "amphyst staff", "an amphyst staff", "smack", 2, 240, "This staff is made of very old wood and seems to tingle to the touch.  The top has amethyst embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.", "Staff", PerkLib.WizardsFocus, 0.2, 0, 0, 0, "", "Staff");
		}
		
		override public function get verb():String { 
				return game.player.hasPerk(PerkLib.StaffChanneling) ? "shot" : "smack";
		}
	}
}