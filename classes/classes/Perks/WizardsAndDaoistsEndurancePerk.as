/**
 * ...
 * @author Zavos
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class WizardsAndDaoistsEndurancePerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "Reduces mana cost of spells by " + params.value1 + "% and soulforce cost of soulskills by " + params.value2 + "%.";
		}

		public function WizardsAndDaoistsEndurancePerk() 
		{
			super("Wizard's and Daoists's Endurance", "Wizard's and Daoists's Endurance",
					"Your equipment makes it harder for spell-casting to drain your mana or souskills to drain your soulforce!");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
		
	}

}