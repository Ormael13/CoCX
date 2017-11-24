package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class SeraphicSpear extends Weapon
	{
		
		public function SeraphicSpear() 
		{
			super("SeSpear", "Seraph Spear", "seraph spear", "a seraph spear", "piercing stab", 20, 1600,
			"A silvery spear imbued with holy power. The weapon appears very simple at first but engraved in the handle is a holy text made to ward evil, the largest letter engraved in the head. This blessed equipment seems to slowly heal its wielder’s wounds.",
			"");
		}
		override public function get attack():Number {
			var boost:int = 0;
			var base:int = 0;
			base += 7;
			if (game.player.spe >= 75) base += 3;
			if (game.player.isMeetingNaturalJousterMasterGradeReq()) boost += base * 4;
			else if (game.player.isMeetingNaturalJousterReq()) boost += base * 2;
			boost += (100 - game.player.cor) / 10;
			return (boost);
		}
		
	}

}