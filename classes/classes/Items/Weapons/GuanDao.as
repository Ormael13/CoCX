/**
 * ...
 * @author Shamanknight
 */
package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.PerkLib;

public class GuanDao extends Weapon {
		
		public function GuanDao() {
			super("GuanDao", "GuanDao", "Guan Dao", "a Guan Dao", "slash", 75, 3000, "Made of a 7 foot long wooden pole, attached on top is an imposing sword blade measuring about 21 inches long, gleaming with a sharp light. You figure this weapon should be effective versus groups of foes.  Req. 300 strength to unleash full attack power.", [WP_MASSIVE, WP_WHIRLWIND, WP_AP60].join(", "), WT_POLEARM);
		}
		
		override public function get attack():Number {
			var base:int = 0;
			if (game.player.hasPerk(PerkLib.HiddenJobSwordImmortal)) base += 69;
			else {
				if (game.player.str >= 300) base += 28;
				if (game.player.str >= 200) base += 20;
				if (game.player.str >= 100) base += 12;
				if (game.player.str >= 50) base += 9;
			}
			return (6 + base);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) && (game.player.hasPerk(PerkLib.TitanGrip) || (game.player.hasPerk(PerkLib.GigantGripSu) && game.player.playerHasFourArms()))) return super.canEquip(doOutput);
			if (!game.player.hasPerk(PerkLib.TitanGrip)) outputText("You aren't skilled enough to handle this pair of weapons with only two hands!  Unless you want to hurt yourself instead of your enemies when trying to use them...  ");
			else {
				if (game.player.playerHasFourArms()) outputText("You aren't skilled enough to handle this pair of weapons!  Unless you want to hurt yourself instead of your enemies when trying to use them...  ");
				else outputText("You lack second pair of arms!  ");
			}
			return false;
		}
	}
}
