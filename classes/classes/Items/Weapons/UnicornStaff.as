package classes.Items.Weapons 
{
	import classes.PerkLib;
	public class UnicornStaff extends WeaponWithPerk
	{
		
		public function UnicornStaff() 
		{
			super("U.Staff", "U. Staff", "unicorn staff", "a unicorn staff", "smack", 6, 480, "This blessed staff is decorated with a spiral pattern reminiscent of that of an unicorn’s horn. This item seems to greatly enhance the owner's ability to use healing magics, not unlike those of the fabled creature it emulates.", "Staff", PerkLib.WizardsFocus, 0.9 + ((100 - game.player.cor) * 0.01), 0, 0, 0);
		}
		override public function get verb():String { 
				return game.player.findPerk(PerkLib.StaffChanneling) >= 0 ? "shot" : "smack"; 
		}
	}
}