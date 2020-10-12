package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.Player;
	
	/**
	 * ...
	 * @author Oxdeception
	 */
	public class Artemis extends WeaponRange
	{
		
		public function Artemis() 
		{
			super("Artemis", "Artemis", "Artemis longbow", "an Artemis longbow", "shot", 60, 3000,
					"The white sandalwood of this blessed bow seems to draw light in. The radiant arrows fired with this holy weapon strike true as if guided by divine hands.",
					"Bow"
			);
		}
		override public function get attack():Number{
			return (40 + ((100 - game.player.cor) / 5));
		}
		
	}

}