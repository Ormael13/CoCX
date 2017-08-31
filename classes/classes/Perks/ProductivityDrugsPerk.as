package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class ProductivityDrugsPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			return "Minimum libido increased by " + int(params.value1) + ", minimum corruption increased by " + int(params.value2) + ", cum production (if applicable) increased by "
			+ int(params.value3) + "mL, and milk production (if applicable) increased by " + int(params.value4) + "mL.";
		}

		public function ProductivityDrugsPerk()
		{
			super("Productivity Drugs","Productivity Drugs", "The drugs from the factory significantly increase your minimum libido, minimum corruption, and fluid production.");
		}
	}
}