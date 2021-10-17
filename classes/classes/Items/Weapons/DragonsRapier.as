/**
 * ...
 * @author Ormael
 * */
package classes.Items.Weapons
{
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Items.Weapon;

	public class DragonsRapier extends Weapon {
		
		public function DragonsRapier() {
			super("DRapier", "DRapier", "dragon rapier", "Dragon's Rapier", "slash", 18, 1440, "Ancient looking rapier forged in dragon fire. Tales saying that some of the dragon fire could still linger inside of it.  Still blade is piece of an extraordinatry quality and perfect for stabbing.", "", "Dueling");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			return (18 + boost); 
		}
	}
}