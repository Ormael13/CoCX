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
			super("Depravatio", "Depravatio", "Depravatio", "Depravatio, Element of Corruption", "smack", 6, 480, "This staff is made from sacred wood, infused with Marae’s bark. Tentacles run along the staff, and attempt to grope you when they think you’re not watching. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff seethes with corruption.", "Staff", PerkLib.WizardsFocus, 0, 0, 0, 0);
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
			desc += "\nSpecial: Wizard's Focus (+60% Spellpower)";
			return desc;
		}
		
		override public function get verb():String { 
				return game.player.hasPerk(PerkLib.StaffChanneling) ? "shot" : "smack";
		}
	}
}