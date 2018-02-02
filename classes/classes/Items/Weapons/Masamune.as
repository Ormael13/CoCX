package classes.Items.Weapons 
{
import classes.Items.Weapon;

public class Masamune extends Weapon
	{
		
		public function Masamune() 
		{
			super(
				"masamune","Masamune","masamune katana","a masamune katana","slash",30,2400,
				"This blessed katana is made in shining steel and heavily decorated with silver and blue sapphires. When used by a pure-hearted knight, the divine will within guides each strike, making it much deadlier.",
				""
			);
		}
		override public function get attack():Number {
			var boost:int = 0;
			boost += (2 * (20 - game.player.cor / 3));
			return (18 + boost); 
		}
	}

}