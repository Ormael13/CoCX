/**
 * ...
 * @author Zevos
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class SagesKnowledgePerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "Increases your spell effect modifier by " + params.value1 * 100 + "%.";
		}

		public function SagesKnowledgePerk() 
		{
			super("Sage's Knowledge", "Sage's Knowledge",
					"Your tome grants you additional focus, increasing your spells power.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}
}