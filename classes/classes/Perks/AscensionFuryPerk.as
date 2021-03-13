/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionFuryPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_INNERPOWER_LEVEL + ") Increases maximum Wrath by " + params.value1 * 100 + ".";
		}
		
		public function AscensionFuryPerk() 
		{
			super("Ascension: FURY", "Ascension: FURY", "", "Increases maximum Wrath by 100 per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}
}