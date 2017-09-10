package classes.Items.Weapons 
{
	import classes.PerkLib;
	public class NocturnusStaff extends WeaponWithPerk
	{
		
		public function NocturnusStaff() 
		{
			super(
			"N.Staff",
			"N. Staff",
			"nocturnus staff",
			"a nocturnus staff", 
			"smack", 
			6, 
			1250, 
			"This corrupted staff is decorated with a bat ornament. Malice seems to seep through the item, devouring the wielder’s mana to channel its unholy power.", 
			"Staff", 
			PerkLib.WizardsFocus, 2, 0, 0, 0);
		}
		
		override public function get verb():String { 
			return game.player.findPerk(PerkLib.StaffChanneling) >= 0 ? "shot" : "smack"; 
		}
		
	}

}