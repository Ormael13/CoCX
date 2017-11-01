/**
 * @author Zavos
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class WizardsAndDaoistsFocusPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "Increases your spell effect modifier by " + params.value1 * 100 + "% and your magical soulskill effect modifier by " + params.value2 * 100 + "%.";
		}

		public function WizardsAndDaoistsFocusPerk() 
		{
			super("Wizard's and Daoists's Focus", "Wizard's and Daoists's Focus",
					"Your equipment grants you additional focus, increasing your spells and magical soulskills power.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
		
	}

}