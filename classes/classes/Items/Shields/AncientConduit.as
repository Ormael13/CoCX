/**
 * ...
 * @author Liadri
 */
package classes.Items.Shields 
{
	import classes.Items.Shield;

	public class AncientConduit extends Shield
	{
		
		public function AncientConduit() 
		{
			super("AConduit", "A.Conduit", "Ancient Conduit", "a gold, wing-shaped device", 1, 100, "This golden, wing-shaped Conduit was given to you by the ancient Pharaoh of the Sands. Worn on your off-hand, you can feel the power coursing through the world beneath you as long as you wear it. Your stone slabs, shrunken to the size of playing cards, sit next to your wrist, just waiting for you to draw");
		}
		
		override public function get block():Number {
			var temp:int = 4 - (game.player.cor / 10);
			if (temp < 1) temp = 1;
			return temp;
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.cor < (33 + game.player.corruptionTolerance)) return super.canEquip(doOutput);
			if(doOutput) outputText("You grab hold of the handle of the shield only to have it grow burning hot.  You're forced to let it go lest you burn yourself.  Something within the shield must be displeased.  ");
			return false;
		}
	}
}
