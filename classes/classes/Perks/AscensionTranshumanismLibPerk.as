/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionTranshumanismLibPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_LIB_LEVEL + ") Increases maximum base/core Lib by " + params.value1 * 16 + ".";
		}
		
		public function AscensionTranshumanismLibPerk() 
		{
			super("Ascension: Transhumanism (Lib)", "Ascension: Transhumanism (Lib)", "", "Increases maximum base/core Lib by 16.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}