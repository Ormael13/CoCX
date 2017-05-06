/**
 * ...
 * @author Zavos
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class AmbitionPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "Increase spell power by " + (params.value1 * 100) + "% and increase power/lower cost of white magic by " + (params.value2 * 100) + "%.";
		}

		public function AmbitionPerk() 
		{
			super("Ambition", "Ambition",
					"Your equipment boost your spells power and argument your white magic at the same time lowering it costs!");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
		
	}

}