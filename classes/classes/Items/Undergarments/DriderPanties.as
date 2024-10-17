/**
 * ...
 * @author Canadian Snas
 */
package classes.Items.Undergarments
{
	import classes.Items.Undergarment;
	import classes.PerkLib;

	public class DriderPanties extends Undergarment
	{
		
		public function DriderPanties()
		{
			super("D. Pnte", "Drider silk Panties", "drider panties", "Silky Drider-Weave Panties", UT_BOTTOM, 2100, 2, 4, 4, "This pair of panties is exquisitely crafted, so fine that they seem worthy of being displayed in a frame. Thin strands of silk cross the front in a web-like pattern, providing just enough material to cover your most intimate areas. The rest is sheer, leaving almost nothing to the imagination. The seams, made from brown-tinted silk, resemble twigs where a web might rest. Despite the translucent nature of the fabric, the flex of the material is clear, and each strand, while gentle on your fingers, shows no sign of yielding even to a blade. \n\nType: Undergarment (Lower)");
			withBuff('spellpower', +0.1);
		}
		
		override public function equipText():void {
			outputText("You slide the Drider-weave panties up your [legs], the cool fabric light as a feather. As you cover your groin, you can all but feel your mana flowing through your endowments and into the fabric, making it shimmer gently.\n\n");
		}
	}
}
