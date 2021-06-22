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
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_SEN_LEVEL + ") Increases Sen by " + params.value1 * 16 + ".";
		}
		
		public function AscensionTranshumanismSenPerk() 
		{
			super("Ascension: Transhumanism (Sen)", "Ascension: Transhumanism (Sen)", "", "Increases Sen by 16.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}