package classes.Items.WeaponsRange 
{
	import classes.PerkLib;
	/**
	 * ...
	 * @author Oxdeception
	 */
	public class WildHunt extends WeaponRangeWithPerk
	{
		
		public function WildHunt() 
		{
			super("WildHunt", "Wild Hunt", "wild hunt longbow", "wild hunt longbow", "shot", 25, 2000,
					"The ebony wood of this corrupt bow seems to ignore light. Arrows fired with this weapon seem to have a malignant mind of their own, striking down the weak with brutal efficiency.",
					"Bow", PerkLib.Accuracy2,30,0,0,0
			);
		}
		override public function get attack():Number{
			return (20 + (game.player.cor / 20));
		}
		
	}

}