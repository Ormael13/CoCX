/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class Ascensus extends WeaponWithPerk {
		
		public function Ascensus() {
			super("Ascensus", "Ascensus", "Ascensus", "Ascensus, Element of Ascension", "smack", 15, 2400, "This staff is made from sacred wood and holy bark. Vines and tentacles run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with pulsing crystals adorning the recesses. This staff radiates power, neither pure nor corrupt.", "Staff, Wizard's Focus (+150% Spellpower), x2,5 Spellpower", PerkLib.WizardsFocus, 1.5, 0, 0, 0, "", "Staff");
		}

		override public function get verb():String { 
			return game.player.hasPerk(PerkLib.StaffChanneling) ? "shot" : "smack";
		}
	}
}