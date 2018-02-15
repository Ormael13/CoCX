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
			super("Puritas", "Puritas", "Puritas", "Puritas, Element of Purity", "smack", 6, 480, "This staff is made from sacred wood, infused with Marae’s bark. Vines run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff glows with power, radiating purity.", "Staff", PerkLib.WizardsFocus, 0, 0, 0, 0);
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Weapon (Staff)";
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Daoist's Focus (+60% Spellpower)";
			return desc;
		}
		
		override public function get verb():String { 
				return game.player.findPerk(PerkLib.StaffChanneling) >= 0 ? "shot" : "smack"; 
		}
	}
}