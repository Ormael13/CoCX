package classes.Items.Weapons 
{
	public class DemonSnakespear extends WeaponWithPerk
	{
		
		public function DemonSnakespear() 
		{
			super("DSSpear", "Demon Sn Spear", "demon snake spear", "a demon snake spear", "piercing stab", 12, 590,
			"A dark steel spear imbued with corruption. Along the handle is a snake decoration with ruby eyes, from the mouth of which the spear tip emerges. The spear head is poisoned with an unknown venom.",
			"",
			null, 0, 0, 0, 0);
		}
		override public function get attack():Number {
			var boost:int = 0;
			var base:int = 0
			base += 11;
			if (game.player.spe >= 75) base += 3;
			if (game.player.isMeetingNaturalJousterMasterGradeReq()) boost += base * 4;
			else if (game.player.isMeetingNaturalJousterReq()) boost += base * 2;
			boost += game.player.cor / 10;
			return (boost);
		}
	}

}