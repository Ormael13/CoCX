package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class MilkMaidPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "(Rank: " + params.value1 + "/10) Increases milk production by " + (200 + (params.value1 * 100)) + "mL.";
		}
		
		public function MilkMaidPerk()
		{
			super("Milk Maid", "Milk Maid", "Increases milk production by ---mL. Allows you to lactate perpetually.");
		}
	}
}
