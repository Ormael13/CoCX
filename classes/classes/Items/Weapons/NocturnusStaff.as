package classes.Items.Weapons 
{
	import classes.PerkLib;
	public class NocturnusStaff extends WeaponWithPerk
	{
		
		public function NocturnusStaff() 
		{
			super("N.Staff", "N. Staff", "nocturnus staff", "a nocturnus staff", "smack", 6, 960,
					"This corrupted staff is made in black ebonwood and decorated with a bat ornament in bronze. Malice seems to seep through the item, devouring the wielder’s mana to channel its unholy power. It is said nocturnus was wielded by the most powerful mages in the land until the staff litteraly consumed the user soul itself.",
					"Staff", PerkLib.WizardsFocus, 0.6, 0, 0, 0, "", "Staff");
		}
		
		override public function get verb():String { 
			return game.player.hasPerk(PerkLib.StaffChanneling) >= 0 ? "shot" : "smack";
		}
	}
}