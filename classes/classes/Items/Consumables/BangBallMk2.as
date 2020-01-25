/**
 * ...
 * @author Ormael
 */
package classes.Items.Consumables
{
	import classes.Items.Consumable;
	import classes.PerkLib;
	//import classes.Monster;
	import classes.internals.Utils;

	public final class BangBallMk2 extends Consumable {
		
		public function BangBallMk2() {
			super("BangBM2", "BangBallMk2", "a bangball mark 2", 36, "A ball-shaped throwing weapon.  Though good for only a single use, it's guaranteed to do low to medium damage to solo or weak group of enemies if it hits.  Inflicts 640 to 2880 base damage.");
		}
		
		override public function canUse():Boolean {
			if (game.inCombat) return true;
			outputText("There's no one to throw it at!");
			return false;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You toss a bangball mk 2 at your foe");
			if (game.monster.findPerk(PerkLib.EnemyGroupType) >= 0) outputText("s");
			outputText("!  It flies straight and true, almost as if it has a mind of its own as it arcs towards " + game.monster.a + game.monster.short + "!\n");
			if (game.monster.spe - 240 > Utils.rand(100) + 1) { //1% dodge for each point of speed over 240
				outputText("Somehow " + game.monster.a + game.monster.short + "'");
				if (!game.monster.plural) outputText("s");
				outputText(" incredible speed allows " + game.monster.pronoun2 + " to avoid the ball!  The deadly sphere shatters when it impacts something in the distance.");
			}
			else { //Not dodged
				var damage:Number = 640 + Utils.rand(321);
				if (game.player.level >= 6) {
					if (game.player.level >= 24) damage *= 3;
					else damage *= 2;
				}
				if (game.monster.findPerk(PerkLib.EnemyGroupType) >= 0) damage *= 5;
				outputText(game.monster.capitalA + game.monster.short + " is hit with the bangball!  It breaks apart as it lacerates " + game.monster.pronoun2 + ". <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
				game.monster.HP -= damage;
				if (game.monster.HP < game.monster.minHP()) game.monster.HP = game.monster.minHP() - 1;
			}
			return(false);
		}
	}
}