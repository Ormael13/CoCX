/**
 * ...
 * @author Liadri
 */
package classes.Items.Undergarments
{
	import classes.Items.Undergarment;

	public class TechnomancerBra extends Undergarment
	{
		public function TechnomancerBra()
		{
			super("TechBra", "TechnomancerBra", "Technomancer bra", "a Technomancer bra", UT_TOP, 600, 0, 0, 0, "A black latex bra designed to complement technomancer clothing, decorated with a gear motif. It is oil, shock, and stainproof. This item also improves your aptitude for using technology. \n\nType: Undergarment (Upper)");
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean{
			if (game.player.basetallness < 48){return super.canEquip(doOutput, slot)}
			if (doOutput) outputText("There is no way this tiny set of clothing would fit your current size.");
			return false;
		}
		
	}

}
