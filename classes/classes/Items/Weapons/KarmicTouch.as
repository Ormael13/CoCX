/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;
	import classes.Items.ItemTags;


	public class KarmicTouch extends Weapon
	{
		
		public function KarmicTouch() 
		{
			super("KarmTou", "KarmicTouch", "karmic gloves", "a pair of karmic gloves", "punch", 0, 400, "A pair of gauntlets, ordinary at first glance save by its immaculate appearance in shining metal and snow-white cloth.Their touch brings waste into the wicked flesh, punishing them in the form of blows more painful then should be.", "Stun50", WT_GAUNTLET);
			withBuffs({ 'psoulskillpower': +1.5 });
			withTag(ItemTags.I_LEGENDARY);
		}
		
	}

}