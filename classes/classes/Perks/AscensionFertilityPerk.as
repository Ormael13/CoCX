package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionFertilityPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_FERTILITY_LEVEL + ") Increases base fertility by " + params.value1 * 5 + ".";
		}
		
		public function AscensionFertilityPerk()
		{
			super("Ascension: Fertility", "Ascension: Fertility", "", "Increases fertility rating by 5 per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
	}

}
