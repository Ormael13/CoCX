/**
 * @author Zavos
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class DaoistsFocusPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "Increases your soulskill effect modifier by " + params.value1 * 100 + "%.";
		}
		
		public function DaoistsFocusPerk() 
		{
			super("Daoist's Focus", "Daoist's Focus",
					"Your daoist's weapon grants you additional focus, reducing the use of soulforce for soulskills.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}	
	}
}