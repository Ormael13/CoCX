package classes.Items.Weapons
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class Spear extends Weapon {
		
		public function Spear() {
			super("Spear", "Spear", "deadly spear", "a deadly spear", "piercing stab", 8, 320, "A staff with a sharp blade at the tip designed to pierce through the toughest armor.  This would ignore most armors.");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (((game.player.isTaur() || game.player.isDrider()) && game.player.spe >= 60) && game.player.findPerk(PerkLib.Naturaljouster) >= 0 && game.player.findPerk(PerkLib.DoubleAttack) >= 0 && kGAMECLASS.flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0) boost += 16;
			else if (game.player.spe >= 120 && game.player.findPerk(PerkLib.Naturaljouster) >= 0 && game.player.findPerk(PerkLib.DoubleAttack) >= 0 && kGAMECLASS.flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0) boost += 16;
			else if (((game.player.isTaur() || game.player.isDrider()) && game.player.spe >= 60) && game.player.findPerk(PerkLib.Naturaljouster) >= 0 && game.player.findPerk(PerkLib.DoubleAttack) < 0) boost += 16;
			else if (game.player.spe >= 120 && game.player.findPerk(PerkLib.Naturaljouster) >= 0 && game.player.findPerk(PerkLib.DoubleAttack) < 0) boost += 16;
			return (8 + boost);
		}
	}
}