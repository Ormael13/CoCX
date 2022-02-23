package classes.Items.Weapons 
{
	import classes.PerkLib;
	public class UnicornStaff extends WeaponWithPerk
	{
		
		public function UnicornStaff() 
		{
			super("U.Staff", "U. Staff", "unicorn staff", "a unicorn staff", "smack", 6, 960,
					"This blessed staff is made in pearl-white sandalwood and decorated with a golden spiral pattern, reminiscent of a unicorn’s horn. The magic within seems to greatly enhance the user’s healing spells, not unlike those of the fabled creature that it emulates. Furthermore the staff allows the user to preserve mana when casting using a minimal ammount of energy on each spell.",
					"Staff", PerkLib.WizardsFocus, 0.6, 0, 0, 0, "", "Staff"
			);
		}
		override public function get verb():String { 
				return game.player.hasPerk(PerkLib.StaffChanneling) ? "shot" : "smack";
		}
	}
}