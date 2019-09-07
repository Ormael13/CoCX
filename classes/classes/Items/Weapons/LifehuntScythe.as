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
			super("LifScyt", "L.Scythe", "lifehunt scythe", "a lifehunt scythe", "slash", 25, 2000,
					"This enchanted scythe is made of a white metal, and its surface is decorated with ruby gemstones and silver engravings depicting dragons. It seems to drink in the opponents blood use it to heal its user’s wounds.",
					"Large", PerkLib.Sanctuary, 1, 0, 0, 0
			);
		}
		override public function get attack():Number{
			return 20 + ((100 - game.player.cor) / 20);
		}
		
	}

}