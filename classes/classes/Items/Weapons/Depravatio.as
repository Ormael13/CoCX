/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class Depravatio extends WeaponWithPerk {
		
		public function Depravatio() {
			super("Depravatio", "Depravatio", "Depravatio", "Depravatio, Element of Corruption", "smack", 6, 480, "This staff is made from sacred wood, infused with Marae’s bark. Tentacles run along the staff, and attempt to grope you when they think you’re not watching. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff seethes with corruption.", "Staff", PerkLib.WizardsFocus, 0.6, 0, 0, 0);
		}
		
		override public function get verb():String { 
				return game.player.findPerk(PerkLib.StaffChanneling) >= 0 ? "shot" : "smack"; 
		}
	}
}