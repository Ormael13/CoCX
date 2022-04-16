/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class BodyCultivatorsFocusPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(+" + params.value1 * 100 + "% Physical Soulskills Power)";
		}
		
		public function BodyCultivatorsFocusPerk() 
		{
			super("Body Cultivator's Focus", "Body Cultivator's Focus (M)",
					"Your body cultivator's melee weapon grants you additional focus, increasing your physical soulskills power.");
		}
	}
}