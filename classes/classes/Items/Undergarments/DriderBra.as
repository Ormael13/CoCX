/**
 * ...
 * @author Canadian Snas
 */
package classes.Items.Undergarments
{
	import classes.Items.Undergarment;
	import classes.PerkLib;

	public class DriderBra extends Undergarment
	{
		
		public function DriderBra()
		{
			super("D. Bra", "Drider silk Bra", "drider bra", "Silky Drider-Weave Bra", UT_TOP, 1800, 2, 3, 4, "This pure-white, delicate-looking bra is made from silk, braided and molded by a skilled Manaweaver. While it’s light and comfortable, always cool on your assets, you can feel power pulsing through each strand of silk. A weblike design cups your assets, with a cutesy fly design in the center, over your nipples. \n\nType: Undergarment (upper)");
			withBuff('spellpower', +0.1);
		}
		
	}

}
