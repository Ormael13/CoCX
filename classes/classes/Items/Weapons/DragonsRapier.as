/**
 * ...
 * @author Ormael
 * */
package classes.Items.Weapons
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Weapon;

	public class DragonsRapier extends Weapon {
		
		public function DragonsRapier() {
			super("DRapier", "DRapier", "dragon rapier", "Dragon's Rapier", "slash", 18, 1440, "Ancient looking rapier forged in dragon fire. Tales saying that some of the dragon fire could still linger inside of it.  Still blade is piece of an extraordinatry quality and perfect for stabbing.");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			return (18 + boost); 
		}
	}
}