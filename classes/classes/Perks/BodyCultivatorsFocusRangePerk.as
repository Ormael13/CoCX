/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class BodyCultivatorsFocusRangePerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(+" + params.value1 * 100 + "% Physical Soulskills Power)";
		}
		
		public function BodyCultivatorsFocusRangePerk() 
		{
			super("Body Cultivator's Focus (R)", "Body Cultivator's Focus (R)",
					"Your body cultivator's range weapon grants you additional focus, increasing your physical soulskills power.");
		}
	}
}