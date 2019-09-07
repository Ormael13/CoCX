package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionCumHosePerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_CUM_HOSE_LEVEL + ") Increases cum per orgasm by " + params.value1 * 200 + " mLs.";
		}
		
		public function AscensionCumHosePerk() 
		{
			super("Ascension: Cum Hose", "Ascension: Cum Hose", "", "Increases cum per orgasm by 200 mLs per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}