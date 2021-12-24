/**
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class DaoistsFocusPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "Increases your magical soulskill effect modifier by " + params.value1 * 100 + "%.";
		}
		
		public function DaoistsFocusPerk() 
		{
			super("Daoist's Focus", "Daoist's Focus (M)",
					"Your daoist's melee weapon grants you additional focus, increasing your soulskills power.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}	
	}
}