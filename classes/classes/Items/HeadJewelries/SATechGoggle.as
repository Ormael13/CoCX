/**
 * ...
 * @author Liadri
 */
package classes.Items.HeadJewelries
{
import classes.Items.HeadJewelry;
import classes.PerkLib;

public class SATechGoggle extends HeadJewelry
	{
		
		public function SATechGoggle()
		{
			super("SATGog", "SATechGoggle", "S.A Tech Goggles", "a S.A Tech Goggles", 0, 0, 11105, "Better than its previous iteration the Scanner goggles, the tech goggles also reveal opponent's flaws and weaknesses, highlighting their vulnerabilities in red within the goggles glass. The fact it also has a complete logbook and access to previous encounter information also helps catalog foes weaknesses.",HJT_HELMET);
			withPerk(PerkLib.BlindImmunity, 0, 0, 0, 0);
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (!super.canEquip(doOutput, slot)) {
				return false;
			}
			if (game.player.basetallness > 48) { //Taller than 4 ft
				if (doOutput) outputText("You try to put your goggles on but the things clearly weren't designed for someone your size. Frustrated, you put them back in the bag.\n\n");
				return false;
			}
			return true;
		}
		
	}

}
