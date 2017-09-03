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
			super("WildHunt", "Wild Hunt", "Wild Hunt", "Wild Hunt", "shot", 25, 2000, "The ebony wood of this corrupt bow seems to ignore light. Arrows fired with this weapon seems to have a malignant mind of their own. This bow rewards a true hunter striking down the weak with brutal efficiency and setting its wielder as the apex predator.", "Bow",
				PerkLib.Accuracy2,30,0,0,0);
		}
		override public function get attack():Number{
			return (20 + (game.player.cor / 20));
		}
		
	}

}