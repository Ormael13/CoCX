package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;

	public class CleansingPalmPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			if (kGAMECLASS.player.cor >= (10 + kGAMECLASS.player.corruptionTolerance())) return "<b>DISABLED</b> - Corruption too high!";
			else return super.desc(params);
		}

		public function CleansingPalmPerk()
		{
			super("Cleansing Palm", "Cleansing Palm", "A ranged fighting technique of Jojo’s order, allows you to blast your enemies with waves of pure spiritual energy, weakening them and hurting the corrupt.");
		}
	}
}