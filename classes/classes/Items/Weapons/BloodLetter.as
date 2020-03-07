package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class BloodLetter extends Weapon
	{
		
		public function BloodLetter() 
		{
			super(
				"BLDLetter","Blood Letter","bloodletter katana","a bloodletter katana","slash",42,3360,
				"This dark blade is as beautiful as it is deadly, made in black metal and decorated with crimson ruby gemstones. Lending its power to a corrupt warrior, it will strike with an unholy force, albeit, draining some blood from its wielder on the process.",
				"Large"
			);
		}
		override public function get attack():Number {
			var boost:int = 0;
			boost += Math.round(game.player.cor / 10);
			return (12 + (3 * boost)); 
		}
		
	}

}