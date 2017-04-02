/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class WizardsAndSoulcultivatorsEndurancePerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "Reduces fatigue cost of spells by " + params.value1 + "% and soulforce cost of soulskills by " + params.value2 + "%.";
		}

		public function WizardsAndSoulcultivatorsEndurancePerk() 
		{
			super("Wizard's and Soul Cultivator's Endurance", "Wizard's and Soul Cultivator's Endurance",
					"Your equipment makes it harder for spell-casting to fatigue you or souskills to drain your soulforce!");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
		
	}

}