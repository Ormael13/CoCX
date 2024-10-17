/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.PerkLib;

public class AsteriusRage extends Weapon {
		
		public function AsteriusRage() {
			super("A.R", "A.R", "Asterius Rage", "Asterius Rage", "cleaves", 200, 20000, "This pair of massive axes once belonged to Asterius the god of the minotaurs.  It'd be hard for anyone smaller than a giant to wield effectively, and as a matter of fact, seems to work best in the hands of someone with truly titanic strength.  Those axes are double-bladed and deadly-looking.  Requires height of 6'6 or above\".",
					WT_AXE,WSZ_MASSIVE,true);
			withTag(W_MGWRATH);
			withTag(I_LEGENDARY);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 1300) boost += 40;
			if (game.player.str >= 1200) boost += 35;
			if (game.player.str >= 1100) boost += 30;
			if (game.player.str >= 1000) boost += 30;
			if (game.player.str >= 900) boost += 9;
			if (game.player.str >= 800) boost += 8;
			if (game.player.str >= 700) boost += 7;
			if (game.player.str >= 600) boost += 6;
			if (game.player.str >= 500) boost += 5;
			if (game.player.str >= 400) boost += 4;
			if (game.player.str >= 300) boost += 3;
			if (game.player.str >= 200) boost += 2;
			if (game.player.str >= 100) boost += 1;
			boost += (game.player.cor) / 5;
			return (1 + boost);
		}
	}
}
