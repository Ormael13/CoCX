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
			super("MachGog", "MachinistGoggles", "Machinist Goggles", "a Machinist Goggles", 0, 0, 400, "A pair of ordinary machinist goggles. One of the basic tools of anyone working with engines. Helps prevent blindness.",HJT_HELMET);
			withPerk(PerkLib.BlindImmunity, 0, 0, 0, 0)
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
