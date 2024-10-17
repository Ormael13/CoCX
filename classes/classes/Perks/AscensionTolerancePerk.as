package classes.Perks
{
import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionTolerancePerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			var mult:int = CoC.instance.gameSettings.sceneHunter_inst.other ? 10 : 5;
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TOLERANCE_LEVEL + ") Increases corruption tolerance by " + params.value1 * mult + " and reduces the corruption requirement by " + params.value1 * mult + ".";
		}
		
		public function AscensionTolerancePerk()
		{
			super("Ascension: Corruption Tolerance", "Ascension: Corruption Tolerance", "", "Increases corruption tolerance by 5 per level and reduces the corruption requirement by 5 per level. With SH:Other - 10 per level for both.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
	}

}
