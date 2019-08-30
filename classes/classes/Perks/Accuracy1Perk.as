/**
 * ...
 * @author Ormael
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class Accuracy1Perk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			return "Rise your accuracy by " + params.value1 * 0.5 + "%.";
		}

		public function Accuracy1Perk()
		{
			super("Accuracy+", "Accuracy+",
					"Your range weapon rising your accuracy when shooting.");
		}		
	}
}