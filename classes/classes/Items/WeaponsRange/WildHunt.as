package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.Player;
	
	/**
	 * ...
	 * @author Oxdeception
	 */
	public class WildHunt extends WeaponRange
	{
		
		public function WildHunt() 
		{
			super("WildHunt", "Wild Hunt", "wild hunt longbow", "wild hunt longbow", "shot", 60, 3000,
					"The ebony wood of this corrupt bow seems to ignore light. Arrows fired with this weapon seem to have a malignant mind of their own, striking down the weak with brutal efficiency.",
					"Bow"
			);
		}
		override public function get attack():Number{
			return (40 + (game.player.cor / 5));
		}
		
	}

}