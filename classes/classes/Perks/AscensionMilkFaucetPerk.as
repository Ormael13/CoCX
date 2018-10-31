package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionMilkFaucetPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_MILK_FAUCET_LEVEL + ") Increases milk production by " + params.value1 * 200 + " mL.";
		}
		
		public function AscensionMilkFaucetPerk() 
		{
			super("Ascension: Milk Faucet", "Ascension: Milk Faucet", "", "Increases milk production by 200 mL per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}