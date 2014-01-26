/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class PiercedFertitePerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			return "Increases cum production by " + Math.round(2*params.value1) + "% and fertility by " + Math.round(params.value1) + ".";
		}

		public function PiercedFertitePerk()
		{
			super("Pierced: Fertite", "Pierced: Fertite",
					"You've been pierced with Fertite and any male or female organs have become more fertile.");
		}
	}
}
