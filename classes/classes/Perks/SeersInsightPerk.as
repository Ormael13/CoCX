/**
 * ...
 * @author Zavos
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class SeersInsightPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "Increase spell/magical soulskills power and lower specials fatigue/soulforce cost by " + (params.value1 * 100) + "%.";
		}

		public function SeersInsightPerk()
		{
			super("Seer’s Insight", "Seer’s Insight",
					"Your equipment boosts your spell and magical soul skill power and lowering the costs of specials and soul skills!");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
		
	}

}
