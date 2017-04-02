/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class StarSphereMasteryPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "Regenerate " + (params.value1 * 2) + " fatigue every round and increase Fox Fire damage by " + (params.value1 * 5) + "%.";
		}
		
		public function StarSphereMasteryPerk() 
		{
			super("Star Sphere Mastery", "Star Sphere Mastery",
					"You have mastered your control over the flow of energy in your star sphere. You are now able to recover fatigue and soulforce over time.");
		}
		
	}

}