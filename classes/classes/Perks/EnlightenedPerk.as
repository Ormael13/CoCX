package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;

	public class EnlightenedPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			if (CoC.instance.player.cor >= (10 + CoC.instance.player.corruptionTolerance)) return "<b>DISABLED</b> - Corruption too high!";
			else return super.desc(params);
		}

		public function EnlightenedPerk()
		{
			super("Enlightened", "Enlightened", "Jojo’s tutelage has given you the focus of a master, and you can feel the universe in all its glory spread out before you. As a result, you’ve finally surpassed your teacher.");
		}
	}
}
