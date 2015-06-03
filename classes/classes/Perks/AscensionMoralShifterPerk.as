package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class AscensionMoralShifterPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + kGAMECLASS.charCreation.MAX_MORALSHIFTER_LEVEL + ") Increases corruption gains and losses by " + params.value1 * 20 + "%.";
		}

		public function AscensionMoralShifterPerk() 
		{
			super("Ascension: Moral Shifter", "Ascension: Moral Shifter", "", "All corruption gains and losses are increased by 20% per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}


}