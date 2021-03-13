package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionDesiresPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_DESIRES_LEVEL + ") Increases maximum lust by " + params.value1 * 30 + ".";
		}
		
		public function AscensionDesiresPerk() 
		{
			super("Ascension: Desires", "Ascension: Desires", "", "Increases maximum lust by 30 per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}