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
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (!super.canEquip(doOutput)) {
				return false;
			}
			if (game.player.tallness > 48) { //Taller than 4 ft
				if (doOutput) outputText("You try to put your goggles on but the things clearly weren't designed for someone your size. Frustrated, you put them back in the bag.\n\n");
				return false;
			}
			return true;
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				while (game.player.hasPerk(PerkLib.BlindImmunity)) game.player.removePerk(PerkLib.BlindImmunity);
				game.player.createPerk(PerkLib.BlindImmunity, 0, 0, 0, 0);
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			while (game.player.hasPerk(PerkLib.BlindImmunity)) game.player.removePerk(PerkLib.BlindImmunity);
			super.afterUnequip(doOutput);
		}
		
	}

}
