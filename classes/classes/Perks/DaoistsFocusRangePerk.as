/**
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class DaoistsFocusRangePerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "Increases your magical soulskill effect modifier by " + params.value1 * 100 + "%.";
		}
		
		public function DaoistsFocusRangePerk() 
		{
			super("Daoist's Focus (R)", "Daoist's Focus (R)",
					"Your daoist's range weapon grants you additional focus, increasing your soulskills power.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}	
	}
}