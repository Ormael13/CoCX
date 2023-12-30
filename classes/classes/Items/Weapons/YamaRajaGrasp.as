/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;
	import classes.Items.ItemTags;

	public class YamaRajaGrasp extends Weapon
	{
		
		public function YamaRajaGrasp() 
		{
			super("YamaRG", "YamaRajaGrasp", "Yama-Raja gloves", "a pair of Yama-Raja gloves", "punch", 0, 1600, "These black gloves are made in black leather and an ebony alloy. Their corrupt touch seeks to destroy the pure and innocent. As such, it will seek the weak points of its victims when striking.", "", WT_GAUNTLET);
			withBuffs({ 'psoulskillpower': +1.5 });
			withTag(ItemTags.I_LEGENDARY);
		}
		
	}

}