package classes.Items.Weapons 
{
	import classes.PerkLib;
	public class UnicornStaff extends WeaponWithPerk
	{
		
		public function UnicornStaff() 
		{
			super(
			"U.Staff",
			"U. Staff",
			"unicorn staff",
			"a unicorn staff", 
			"smack", 
			6, 
			1250, 
			"This blessed staff is decorated with a spiral pattern reminiscent of that of an unicorn’s horn. This item seems to greatly enhance the owner's ability to use healing magics, not unlike those of the fabled creature it emulates.", 
			"Staff", 
			PerkLib.WizardsFocus, 1.25, 0, 0, 0);
		}
		override public function get verb():String { 
				return game.player.findPerk(PerkLib.StaffChanneling) >= 0 ? "shot" : "smack"; 
		}
	}

}