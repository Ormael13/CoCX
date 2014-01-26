/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class PentUpPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			return "Increases minimum lust by " + Math.round(params.value1) + " and makes you more vulnerable to seduction.";
		}

		public function PentUpPerk()
		{
			super("Pent Up","Pent Up", "Increases minimum lust and makes you more vulnerable to seduction");
		}
	}
}
