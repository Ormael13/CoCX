package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class NephilimBlade extends Weapon
	{
		
		public function NephilimBlade() 
		{
			super(
				"NPHMBlade","Nephilim Blade","nephilim blade","a nephilim blade","slash",62,2480,
				"Once upon a time on Mareth, a demigod of great purity named Nephilim is said to have existed. This sword is rumored to have belonged to him. While you don’t know for sure if this story is true, one thing is certain, this blade seeks and destroys corruption wherever it might find it, and will periodically wash its user of any impurity.",
				"Large"
			);
		}
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 150) boost += 23;
			if (game.player.str >= 100) boost += 17;
			if (game.player.str >= 50) boost += 11;
			boost += (20 - game.player.cor / 3);
			return (5 + boost); 
		}	
	}

}