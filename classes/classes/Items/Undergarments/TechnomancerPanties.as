/**
 * ...
 * @author Liadri
 */
package classes.Items.Undergarments 
{
	import classes.Items.Undergarment;
	import classes.Player;

	public class TechnomancerPanties extends Undergarment
	{
		public static const TYPE_LOWERWEAR:int = 1;
		
		public function TechnomancerPanties() 
		{
			super("T.Panty", "T.Panties", "Technomancer panties", "a pair of Technomancer panties", TYPE_LOWERWEAR, 600, "A black latex panty to match with the technomancer clothes, it is decorated with a gears motif and is oil, shock and stain proof. This item also improve your aptitude at using technology. \n\nType: Undergarment (Lower)");
		}
		
		override public function canUse():Boolean{
			if (game.player.tallness < 48){return true}
			outputText("There is no way this tiny set of clothing would fit your current size.");
			return false;
		}
		
	}

}