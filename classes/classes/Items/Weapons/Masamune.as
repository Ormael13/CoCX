package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class Masamune extends Weapon
	{
		
		public function Masamune() 
		{
			super(
				"masamune","Masamune","masamune","a masamune","slash",30,2400,
				"This blessed blade is as beautiful as it is deadly. It strikes true in the hands of a pure hearted warrior as if guided by divine will.",
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