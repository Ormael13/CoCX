/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.PerkLib;

	public class SoulDrinkerPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String {
			if (!player || !params) return _desc;
			return "The creatures you defeat and drink from have parts of their soul stolen with their blood, increasing your overall stats by " + params.value1 + "% (1% for each victim drained).";
		}

		public function SoulDrinkerPerk() 
		{
			super("Soul Drinker", "Soul Drinker",
					"NOT RELEVANT TEXT");
		}

		override public function keepOnAscension(respec:Boolean = false):Boolean {
			return true;
		}
	}
}
