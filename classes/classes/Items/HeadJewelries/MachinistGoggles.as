/**
 * ...
 * @author Liadri
 */
package classes.Items.HeadJewelries
{
	import classes.Items.HeadJewelry;
	import classes.PerkLib;

	public class MachinistGoggles extends HeadJewelry
	{
		
		public function MachinistGoggles()
		{
			super("MachGog", "MachinistGoggles", "Machinist Goggles", "a Machinist Goggles", 0, 0, 400, "A pair of ordinary machinist goggles. One of the basic tools of anyone working with engines. Helps prevent blindness.","Helmet");
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
