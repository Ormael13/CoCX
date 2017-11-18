package classes.Items.Weapons 
{
	import classes.PerkLib;
	public class EbonyDestroyer extends WeaponWithPerk
	{
		public function EbonyDestroyer() 
		{
			super(
				"EBNYBlade","Ebony Destroyer","ebony destroyer","an ebony destroyer","slash",62,2480,
				"Once upon a time on Mareth, a demigod of great purity named Nephilim is said to have existed. His duty was to shape the land at the demand of the gods, which he did. His task finished, he disappeared never to be found again. This sword is rumored to have belonged to him. While you don’t know for sure if the story is true, one thing is certain, this blade seeks and destroys corruption wherever it might find it, and will periodically wash its user of any impurity.",
				"Large"
			);
		}
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 150) boost += 23;
			if (game.player.str >= 100) boost += 17;
			if (game.player.str >= 50) boost += 11;
			boost += (game.player.cor - 80 / 3);
			return (5 + boost); 
		}
		
	}

}