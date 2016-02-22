package classes.Scenes.Seasonal 
{
	import classes.*;
	import classes.GlobalFlags.*;
	
	public class XmasBase extends BaseContent
	{
		public var xmasElf:XmasElf = new XmasElf();
		public var xmasMisc:XmasMisc = new XmasMisc();
		public var jackFrost:XmasJackFrost = new XmasJackFrost();
		public var snowAngel:XmasSnowAngel = new XmasSnowAngel();
		
		public function XmasBase() {}
		
		public function isItHolidays():Boolean {
			return (date.date >= 25 && date.month == 11 || flags[kFLAGS.ITS_EVERY_DAY] > 0 || player.findPerk(PerkLib.AChristmasCarol) >= 0);
		}
		
	}

}