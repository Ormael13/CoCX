/**
 * ...
 * @author Liadri
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.IMutations.IMutationsLib;

	public class DemonEnergyThirstPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			var mTPCur:Number = params.value1;
			var mTPCap:Number = 5 * player.perkv1(IMutationsLib.FiendishMetabolismIM);
			if (mTPCur > mTPCap) mTPCur = mTPCap;
			return "You can metabolise sex into energy and can feed from your partners orgasms. Increases tease damage by " + (mTPCur * 10) + "%.";
		}

		public function DemonEnergyThirstPerk() 
		{
			super("Demonic hunger", "Demonic hunger",
					"You can metabolise sex into energy and can feed from your partners orgasms.");
		}
	}
}
