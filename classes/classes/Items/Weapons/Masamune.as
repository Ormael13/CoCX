package classes.Items.Weapons 
{
	public class Masamune extends WeaponWithPerk
	{
		
		public function Masamune() 
		{
			super(
				"masamune",
				"Masamune",
				"masamune",
				"a masamune",
				"slash",
				30,
				2000,
				"This blessed blade is as beautiful as it is deadly. It strikes true in the hands of a pure hearted warrior as if guided by divine will.",
				"",
				null,
				0,
				0,
				0,
				0
			);
		}
		override public function get attack():Number {
			var boost:int = 0;
			boost += (7 + (20 - game.player.cor / 3));
			return (17 + boost); 
		}
	}

}