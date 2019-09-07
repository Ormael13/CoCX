/**
 * ...
 * @author Ormael
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class Accuracy2Perk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			return "Lower your accuracy by " + params.value1 * 0.5 + "%.";
		}

		public function Accuracy2Perk()
		{
			super("Accuracy-", "Accuracy-",
					"Your range weapon lowering your accuracy when shooting.");
		}		
	}
}