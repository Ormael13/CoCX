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
			super("SATGog", "SATechGoggle", "S.A Tech Goggles", "a S.A Tech Goggles", 0, 0, 11105, "Better than its previous iteration the Scanner goggles, the tech goggles also reveal opponent's flaws and weaknesses, highlighting their vulnerabilities in red within the goggles glass. The fact it also has a complete logbook and access to previous encounter information also helps catalog foes weaknesses.","Helmet");
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
