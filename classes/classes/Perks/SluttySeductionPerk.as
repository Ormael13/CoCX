/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class SluttySeductionPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			return "Increases odds of successfully teasing and lust damage of successful teases by " + params.value1 + " points."
		}

		public function SluttySeductionPerk()
		{
			super("Slutty Seduction", "Slutty Seduction",
					"Your armor allows you access to 'Seduce', an improved form of 'Tease'.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}
}
