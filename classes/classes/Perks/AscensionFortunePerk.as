package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class AscensionFortunePerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + ") Increases gems gained in battles by " + params.value1 * 10 + "%.";
		}
		
		public function AscensionFortunePerk() 
		{
			super("Ascension: Fortune", "Ascension: Fortune", "", "Increases gems gains by 10% per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}

}