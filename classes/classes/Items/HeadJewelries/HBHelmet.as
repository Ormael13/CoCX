/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries
{
	import classes.Items.HeadJewelry;
	
	public class HBHelmet extends HeadJewelry
	{
		
		public function HBHelmet()
		{
			super("HBHelm ", "HBHelmet", "HB helmet", "a HB helmet", 0, 0, 1440, "A white helmet that seems to be part of a set with HBA Armor. It cover mostly your face and sides of your head giving a bit more protection to the user.",HJT_HELMET);
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.basetallness >= 84) return super.canEquip(doOutput, slot);
			if(doOutput) outputText("You try to put helmet on but it clearly wasn't designed for someone your size (less than 7 feet are we?). Frustrated, you put it back in the bag.  ");
			return false;
		}
	}
}
