package classes.Items.Weapons 
{
	import classes.PerkLib;
	public class UnicornStaff extends WeaponWithPerk
	{
		
		public function UnicornStaff() 
		{
			super("U.Staff", "U. Staff", "unicorn staff", "a unicorn staff", "smack", 10, 1600,
					"This blessed staff is decorated with a spiral pattern reminiscent of that of an unicorn’s horn. The magic within seems to greatly enhance the user’s healing spells, not unlike those of the fabled creature that emulates.",
					"Staff", PerkLib.WizardsFocus, 0.9, 0, 0, 0, "", "Staff"
			);
		}
		override public function get verb():String { 
				return game.player.hasPerk(PerkLib.StaffChanneling) ? "shot" : "smack";
		}
	}
}