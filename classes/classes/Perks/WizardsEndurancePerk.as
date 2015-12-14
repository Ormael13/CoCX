/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class WizardsEndurancePerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			return "Reduces fatigue cost of spells by " + params.value1 + "%.";
		}

		public function WizardsEndurancePerk()
		{
			super("Wizard's Endurance", "Wizard's Endurance",
					"Your spellcasting equipment makes it harder for spell-casting to fatigue you!");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}
}
