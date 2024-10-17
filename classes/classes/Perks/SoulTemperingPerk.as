/**
 * ...
 * @author Ormael
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class SoulTemperingPerk extends PerkType
	{
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "Tempered by tribulations your soul transcended its limitations. Increases maximum base/core Int/Wis/Lib by " + params.value1 + " and Sens by " + params.value1 * 5 + ".";
		}
		
		public function SoulTemperingPerk()
		{
			super("Soul Tempering", "Soul Tempering",
					"Tempered by tribulations your soul transcended its limitations.");
		}
	}
}
