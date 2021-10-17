/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Items.Weapon;

	public class RaphaelsRapier extends Weapon {
		
		public function RaphaelsRapier() {
			super("RRapier", "RRapier", "vulpine rapier", "Raphael's vulpine rapier", "slash", 8, 640, "He's bound it with his red sash around the length like a ribbon, as though he has now gifted it to you.  Perhaps it is his way of congratulating you.", "", "Dueling");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			return (8 + boost); 
		}
	}
}