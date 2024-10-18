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
			if (!player || !params) return _desc;
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_STR_LEVEL + ") Increases maximum base/core Strength by " + params.value1 * 16 + ".";
		}
		
		public function AscensionTranshumanismStrPerk()
		{
			super("Ascension: Transhumanism (Str)", "Ascension: Transhumanism (Str)", "", "Increases maximum base/core Strength by 16.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
	}

}
