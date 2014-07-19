/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Weapon;

	public class JeweledRapier extends Weapon
	{

		override public function get attack():Number
		{
			return (13 + kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING]*2);
		}

		public function JeweledRapier()
		{
			super("JRapier","JRapier","jeweled rapier","a jeweled rapier","slash",13,1400,"This jeweled rapier is ancient but untarnished.  The hilt is wonderfully made, and fits your hand like a tailored glove.  The blade is shiny and perfectly designed for stabbing.");
		}
	}
}
