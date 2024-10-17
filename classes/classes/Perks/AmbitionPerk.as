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
			if (!player || !params) return _desc;
			return "Increase spell power by " + (params.value1 * 100) + "% and increases power and lowers the cost of white magic by " + (params.value2 * 100) + "%.";
		}

		public function AmbitionPerk()
		{
			super("Ambition", "Ambition",
					"Your equipment boost your spells power and augments your white magic while lowering its cost!");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
		
	}

}
