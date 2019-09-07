package classes.Items.WeaponsRange 
{
	import classes.PerkLib;
	/**
	 * ...
	 * @author Oxdeception
	 */
	public class Artemis extends WeaponRangeWithPerk
	{
		
		public function Artemis() 
		{
			super("Artemis", "Artemis", "Artemis longbow", "an Artemis longbow", "shot", 25, 2000,
					"The white sandalwood of this blessed bow seems to draw light in. The radiant arrows fired with this holy weapon strike true as if guided by divine hands.",
					"Bow", PerkLib.Accuracy2,30,0,0,0
			);
		}
		override public function get attack():Number{
			return (20 + ((100 - game.player.cor) / 20));
		}
		
	}

}