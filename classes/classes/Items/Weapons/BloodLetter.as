package classes.Items.Weapons 
{
	import classes.PerkLib;
	public class BloodLetter extends WeaponWithPerk
	{
		
		public function BloodLetter() 
		{
			super(
				"BLDLetter","Blood Letter","blood letter","a blood letter","slash",40,3000,
				"This dark blade is as beautiful as it is deadly. While it will only lend its unholy power to a warrior as corrupt as itself, it is too powerful a blade to be controlled by mere mortal hands. Due to this, it, has a tendency to turn on it’s wielder, drawing blood both ways.",
				"",
				PerkLib.Sanctuary,0,0,0,0
			);
		}
		override public function get attack():Number {
			var boost:int = 0;
			boost += (7 + (game.player.cor - 80 / 3));
			return (17 + boost); 
		}
		
	}

}