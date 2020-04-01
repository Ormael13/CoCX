/**
 * ...
 * @author Liadri
 */
package classes.Items.Undergarments 
{
	import classes.Items.Undergarment;
	import classes.Player;

	public class TechnomancerBra extends Undergarment
	{
		public static const TYPE_UPPERWEAR:int = 0;
		
		public function TechnomancerBra() 
		{
			super("TechBra", "TechnomancerBra", "Technomancer bra", "a Technomancer bra", TYPE_UPPERWEAR, 600, "A black latex bra to match with the technomancer clothes, it is decorated with a gears motif and is oil, shock and stain proof. This item also improve your aptitude at using technology. \n\nType: Undergarment (Upper)");
		}
		
		override public function canUse():Boolean{
			if (game.player.tallness < 48){return true}
			outputText("There is no way this tiny set of clothing would fit your current size.");
			return false;
		}
		
	}

}