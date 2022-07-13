/**
 * ...
 * @author Zavos
 */
package classes.Items.HeadJewelries
{
	import classes.Items.HeadJewelry;
	import classes.PerkLib;

	public class SeersHairpin extends HeadJewelry
	{
		
		public function SeersHairpin()
		{
			super("SeerPin", "Seer’s Hairpin", "seer’s hairpin", "a seer’s hairpin", 0, 0, 1600, "This hairpin is made from silver, the tip twisted into the shape of an eye and fitted with a crystal lens. Both an ornament and a tool, this pin will empower sorcery and soulforce.",HJT_HAIRPIN);
			withPerk(PerkLib.SeersInsight, 0.2, 0, 0, 0);
		}
		
	}

}
