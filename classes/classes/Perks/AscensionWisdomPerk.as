package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class AscensionWisdomPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + kGAMECLASS.charCreation.MAX_WISDOM_LEVEL + ") Increases experience gained in battles by " + params.value1 * 10 + "%.";
		}

		public function AscensionWisdomPerk() 
		{
			super("Ascension: Wisdom", "Ascension: Wisdom", "", "Increases experience gains by 10% per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}

}