/**
 * ...
 * @author Liadri
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class PerformancePowerPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "Increase performance power by " + (params.value1 * 100) + "%.";
		}

		public function PerformancePowerPerk() 
		{
			super("Performance Power", "Performance Power",
					"Your equipment boosts your performance power.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
		
	}

}
