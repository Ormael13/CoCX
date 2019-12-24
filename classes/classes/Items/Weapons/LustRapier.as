/**
 * ...
 * @author ...
 */
package classes.Items.Weapons 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Items.Weapon;

	public class LustRapier extends Weapon {
		
		public function LustRapier() 
		{
			super("LRapier", "LRapier", "lust rapier", "lust-coated rapier", "slash", 8, 640, "A rapier with edge that seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			return (8 + boost); 
		}
	}
}