/**
 * Created by ormael on 05.03.19.
 */
package classes.Items.Shields 
{
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.CoC;
	import classes.Items.Shield;
	import classes.Player;

	public class BeautifulShield extends Shield {
		
		public function BeautifulShield() 
		{
			super("BShield", "B.Shield", "beautiful shield", "a beautiful shield", 1, 30, "This beautiful shield shines brilliantly in the light, showing the flawless craftsmanship as it's decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this shield.");
		}
		
		override public function get block():Number { 
			var temp:int = 4 - (game.player.cor / 10);
			if (temp < 1) temp = 1;
			return temp; 
		}
		
		override public function canUse():Boolean {
			if (game.player.cor < (33 + game.player.corruptionTolerance())) return true;
			outputText("You grab hold of the handle of the shield only to have it grow burning hot.  You're forced to let it go lest you burn yourself.  Something within the shield must be displeased.  ");
			return false;
		}
	}
}