/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
import classes.PerkLib;
	
	public class GoblinTechnomancerClothes extends Armor
	{
		
		public function GoblinTechnomancerClothes()
		{
			super("GTechC", "GTechC", "Goblin Technomancer clothes", "a Goblin Technomancer clothes", 0, 0, 400, "These goblin technomancer clothes increase the effectiveness of all technology attacks. Too small for anyone but a goblin to wear. It features a pair of latex pants with a large opening at the right level in order to display whatever panties you may have on, if any at all. Along with the pants are two black latex shoes, black latex gloves, and a mechanist’s latex overcoat of matching color, generally kept open for a practical display of the user’s… assets. Oil, shock and stain proof. These garbs also improve your skill at using technology.", "Light");
			withBuff('teasedmg', +10);
			withTag(A_REVEALING);
			withTag(A_AGILE);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean{
			if (game.player.tallness < 48) return super.canEquip(doOutput)
			if (doOutput) outputText("There is no way this tiny set of clothing would fit your current size.");
			return false;
		}
		
	}

}
