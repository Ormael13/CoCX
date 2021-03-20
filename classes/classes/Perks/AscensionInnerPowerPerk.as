/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionInnerPowerPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_INNERPOWER_LEVEL + ") Increases maximum Mana by " + params.value1 * 120 + ".";
		}
		
		public function AscensionInnerPowerPerk() 
		{
			super("Ascension: Inner Power", "Ascension: Inner Power", "", "Increases maximum Mana by 120 per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}
}