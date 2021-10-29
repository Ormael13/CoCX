/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class Puritas extends WeaponWithPerk {
		
		public function Puritas() {
			super("Puritas", "Puritas", "Puritas", "Puritas, Element of Purity", "smack", 6, 960, "This staff is made from sacred wood, infused with Marae’s bark. Vines run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff glows with power, radiating purity.", "Staff, Wizard's Focus (+60% Spellpower), x1,6 Spellpower", PerkLib.WizardsFocus, 0.6, 0, 0, 0);
		}

		override public function get verb():String { 
			return game.player.hasPerk(PerkLib.StaffChanneling) ? "shot" : "smack";
		}
	}
}