/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Weapon;

public class JeweledRapier extends Weapon {
		
		public function JeweledRapier() {
			super("JRapier", "JRapier", "jeweled rapier", "a jeweled rapier", "slash", 13, 1040, "This jeweled rapier is ancient but untarnished.  The hilt is wonderfully made, and fits your hand like a tailored glove.  The blade is shiny and perfectly designed for stabbing.", WP_AP100, WT_DUELING);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			return (13 + boost);
		}
	}
}
