package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class AscensionEndurancePerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + kGAMECLASS.charCreation.MAX_ENDURANCE_LEVEL + ") Increases maximum fatigue by " + params.value1 * 5 + ".";
		}
		
		public function AscensionEndurancePerk() 
		{
			super("Ascension: Endurance", "Ascension: Endurance", "", "Increases maximum fatigue by 5 per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}

}