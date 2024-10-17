/**
 * ...
 * @author Liadri
 */
package classes.Items.HeadJewelries
{
import classes.Items.HeadJewelry;
import classes.PerkLib;

public class ScannerGoggle extends HeadJewelry
	{
		
		public function ScannerGoggle()
		{
			super("Scangog", "Scangoggle", "Scanner goggles", "a Scanner goggles", 0, 0, 4030, "This set of goggles naturally include a user interface and scanner, revealing information about your opponents.",HJT_HELMET);
			withPerk(PerkLib.BlindImmunity, 0, 0, 0, 0);
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (!super.canEquip(doOutput, slot)) {
				return false;
			}
			if (game.player.basetallness > 48) { //Taller than 4 ft
				if (doOutput) outputText("You try to put your goggles on but they clearly weren't designed for someone your size. Frustrated, you put them back in the bag.\n\n");
				return false;
			}
			return true;
		}
		
	}

}
