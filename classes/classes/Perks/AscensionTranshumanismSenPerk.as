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
			if (!player || !params) return _desc;
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_SEN_LEVEL + ") Increases Sensitivity by " + params.value1 * 16 + ".";
		}
		
		public function AscensionTranshumanismSenPerk()
		{
			super("Ascension: Transhumanism (Sen)", "Ascension: Transhumanism (Sen)", "", "Increases Sensitivity by 16.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
	}

}
