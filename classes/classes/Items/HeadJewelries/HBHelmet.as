/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.ItemType;
	import classes.Items.HeadJewelry;
	import classes.Player;
	
	public class HBHelmet extends HeadJewelry
	{
		
		public function HBHelmet() 
		{
			super("HBHelm ", "HBHelmet", "HB helmet", "a HB helmet", 0, 0, 1440, "A white helmet that seems to be part of set with HBA Armor. It cover mostly your face and sides of your head giving a bit of more protection to the user.","Helmet");
		}
		
		override public function canUse():Boolean {
			if (game.player.tallness >= 84) return super.canUse();
			else outputText("You try to put helmet on but it clearly was't designed for someone your size. Frustrated, you put it back in the bag.  ");
			return false;
		}
	}
}