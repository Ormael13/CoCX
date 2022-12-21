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
			super("D. Pnte", "Drider silk Panties", "drider panties", "Silky Drider-Weave Panties", UT_BOTTOM, 2100, 2, 4, 4, "This pair of panties is exquisitely made, to the point where you genuinely think they belong in a picture frame. Thin strands of silk cross the front in a weblike pattern, offering just enough solid material to cover your most enticing bits. The rest of it is sheer, letting whoever’s looking see pretty much everything else. Brown-tinted bits of silk form the seams, looking for all the world like the twigs such a web would nestle between. Despite the translucent nature of the fabric, the flex of the material is clear, and each strand, while gentle on your fingers and assets, shows no sign of yielding to a blade. \n\nType: Undergarment (Lower)");
			withBuff('spellpower', +0.1);
		}
		
		override public function equipText():void {
			outputText("You slide the Drider-weave panties up your [legs], the cool fabric light as a feather. As you cover your groin, you can all but feel your mana flowing through your endowments and into the fabric, making it shimmer gently.\n\n");
		}
	}
}
