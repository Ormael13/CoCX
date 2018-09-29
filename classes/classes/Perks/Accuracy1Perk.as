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
					"You have mastered your control over the flow of energy in your star sphere. You are now able to recover fatigue and soulforce over time.");
		}		
	}
}