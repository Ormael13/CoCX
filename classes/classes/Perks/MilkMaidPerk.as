package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class MilkMaidPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "Increases milk production by " + (200 + (params.value1 * 100)) + "mL. (Rank: " + params.value1 + "/10)";
		}
		
		public function MilkMaidPerk() 
		{
			super("Milk Maid", "Milk Maid", "Increases milk production by ---mL. Allows you to lactate perpetually.");
		}
	}
}