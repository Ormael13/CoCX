package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class MagicalFertilityPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "" + (10 + (params.value1 * 5)) + "% higher chance of pregnancy and increased pregnancy speed.";
		}

		public function MagicalFertilityPerk()
		{
			super("Magical Fertility","Magical Fertility", "10% higher chance of pregnancy and increased pregnancy speed.");
		}
	}
}
