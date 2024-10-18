/**
 * ...
 * @author Ormael
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionKillingIntentPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_KILLINGINTENT_LEVEL + ") Increases melee physical attack multiplier by " + params.value1 * 10 + "% multiplicatively.";
		}
		
		public function AscensionKillingIntentPerk()
		{
			super("Ascension: Killing Intent", "Ascension: Killing Intent", "", "Increases melee physical attack multiplier by 10% per level, multiplicatively.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
	}

}
