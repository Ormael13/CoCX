/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Weapon;

<<<<<<< HEAD
	public class RaphaelsRapier extends Weapon
	{


		override public function get attack():Number
		{
			return 8 + kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING]*2;
		}

		public function RaphaelsRapier()
		{
			super("RRapier","RRapier","vulpine rapier","Raphael's vulpine rapier","slash",8,1000,"He's bound it with his red sash around the length like a ribbon, as though he has now gifted it to you.  Perhaps it is his way of congratulating you. \n\nType: Weapon (Sword) \nAttack: 8 \nBase value: 1,000");
=======
	public class RaphaelsRapier extends Weapon {
		
		public function RaphaelsRapier() {
			super("RRapier", "RRapier", "vulpine rapier", "Raphael's vulpine rapier", "slash", 8, 1000, "He's bound it with his red sash around the length like a ribbon, as though he has now gifted it to you.  Perhaps it is his way of congratulating you.");
>>>>>>> a82163c1688c17102ece58f63f28e75c34388695
		}
		
		override public function get attack():Number { return 8 + kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2; }
	}
}
