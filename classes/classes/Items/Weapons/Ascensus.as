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
			super("Ascensus", "Ascensus", "Ascensus", "Ascensus, Element of Ascension", "smack", 15, 2400, "This staff is made from sacred wood and holy bark. Vines and tentacles run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with pulsing crystals adorning the recesses. This staff radiates power, neither pure nor corrupt.", "Staff", PerkLib.WizardsFocus, 1.5, 0, 0, 0, "", "Staff");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Weapon (Staff)";
			if (type != "") {
				desc += "\nWeapon Class: " + type;
			}
			if (perk != "") {
				desc += "\nSpecials: " + perk;
			}
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecials: Wizard's Focus (+150% Spellpower), x2,5 Spellpower";
			return desc;
		}
		
		override public function get verb():String { 
			return game.player.hasPerk(PerkLib.StaffChanneling) ? "shot" : "smack";
		}
	}
}