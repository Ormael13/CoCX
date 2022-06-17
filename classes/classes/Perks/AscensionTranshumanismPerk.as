/**
 * ...
 * @author Ormael
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionTranshumanismPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_LEVEL + ") Increases maximum base/core Str/Tou/Spe/Int/Wis/Lib by " + params.value1 * 2 + ".";
		}
		
		public function AscensionTranshumanismPerk()
		{
			super("Ascension: Transhumanism", "Ascension: Transhumanism", "", "Increases maximum base/core Str/Tou/Spe/Int/Wis/Lib/Sen by 2.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
	}

}
