package classes.Items.Weapons 
{
	import classes.PerkLib;
	/**
	 * ...
	 * @author Oxdeception
	 */
	public class LifehuntScythe extends WeaponWithPerk
	{
		
		public function LifehuntScythe() 
		{
			super("LifScyt", "L.Scythe", "lifehunt scythe", "a lifehunt scythe", "slash", 25, 2000, "This enchanted scythe with a white blade seems to drink in blood and heal it’s user’s wounds. People say the original Bloodhunt was the weapon of a former godslayer of the dragon tribe, though if such a being ever existed, it has long departed from Mareth.", "Large", 
				PerkLib.Sanctuary, 1, 0, 0, 0);
		}
		override public function get attack():Number{
			return 20 + ((100 - game.player.cor) / 20);
		}
		
	}

}