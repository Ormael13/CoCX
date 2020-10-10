/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionTranshumanismSenPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_SEN_LEVEL + ") Increases maximum Sen by " + params.value1 * 40 + ".";
		}
		
		public function AscensionTranshumanismSenPerk() 
		{
			super("Ascension: Transhumanism (Sen)", "Ascension: Transhumanism (Sen)", "", "Increases maximum Sen by 40.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}