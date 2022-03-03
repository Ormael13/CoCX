/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class Spellblade extends WeaponWithPerk {
		
		public function Spellblade() {
			super("S.Blade", "S.Blade", "inscribed spellblade", "a spellblade", "slash", 8, 640, "Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic. Unlike the wizard staves it is based on, this weapon also has a sharp edge, a technological innovation which has proven historically useful in battle.", "", PerkLib.WizardsFocus, 0.5, 0, 0, 0, "", "Sword, StaffPart");
		}

		override public function get verb():String { 
			return game.player.hasPerk(PerkLib.StaffChanneling) ? "shoot magic bolt" : "slash";
		}
	}
}