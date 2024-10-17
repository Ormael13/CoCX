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
			super("D. Bra", "Drider silk Bra", "drider bra", "Silky Drider-Weave Bra", UT_TOP, 1800, 2, 3, 4, "This pure-white, delicate-looking bra is made from silk, braided and woven by a skilled Manaweaver. It’s light, comfortable, and always cool against your skin, yet you can feel power pulsing through each strand. A web-like design supports your chest, with a cute fly motif placed over the center of each cup. \n\nType: Undergarment (upper)");
			withBuff('spellpower', +0.1);
		}
		
	}

}
