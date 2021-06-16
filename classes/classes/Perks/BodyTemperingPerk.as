/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class BodyTemperingPerk extends PerkType
	{
		override public function desc(params:PerkClass = null):String
		{
			return "Tempered by tribulations your physical body transcended it limitations. Increases maximum base/core Str/Tou/Spe by " + params.value1 + ".";
		}
		
		public function BodyTemperingPerk() 
		{
			super("Body Tempering", "Body Tempering",
					"Tempered by tribulations your physical body transcended it limitations.");
		}	
	}
}