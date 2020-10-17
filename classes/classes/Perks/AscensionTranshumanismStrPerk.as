/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionTranshumanismStrPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_STR_LEVEL + ") Increases maximum Str by " + params.value1 * 8 + ".";
		}
		
		public function AscensionTranshumanismStrPerk() 
		{
			super("Ascension: Transhumanism (Str)", "Ascension: Transhumanism (Str)", "", "Increases maximum Str by 40.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}