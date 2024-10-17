/**
 * ...
 * @author Ormael
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionTranshumanismWisPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_WIS_LEVEL + ") Increases maximum base/core Wisdom by " + params.value1 * 16 + ".";
		}
		
		public function AscensionTranshumanismWisPerk()
		{
			super("Ascension: Transhumanism (Wis)", "Ascension: Transhumanism (Wis)", "", "Increases maximum base/core Wisdom by 16.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
	}

}
