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

	public final class BangBallMk3 extends Consumable {
		
		public function BangBallMk3() {
			super("BangBM3", "BangBallMk3", "a bangball mark 3", 54, "A ball-shaped throwing weapon.  Though good for only a single use, it's guaranteed to do medium to high damage to solo or weak group of enemies if it hits.  Inflicts 90 to 540 base damage.");
		}
		
		override public function canUse():Boolean {
			if (game.inCombat) return true;
			outputText("There's no one to throw it at!");
			return false;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You toss a bangball mk 3 at your foe");
			if (game.monster.findPerk(PerkLib.EnemyGroupType) >= 0) outputText("s");
			outputText("!  It flies straight and true, almost as if it has a mind of its own as it arcs towards " + game.monster.a + game.monster.short + "!\n");
			if (game.monster.spe - 320 > Utils.rand(100) + 1) { //1% dodge for each point of speed over 320
				outputText("Somehow " + game.monster.a + game.monster.short + "'");
				if (!game.monster.plural) outputText("s");
				outputText(" incredible speed allows " + game.monster.pronoun2 + " to avoid the ball!  The deadly sphere shatters when it impacts something in the distance.");
			}
			else { //Not dodged
				var damage:Number = 90 + Utils.rand(46);
				if (game.player.level >= 6) {
					if (game.player.level >= 24) {
						if (game.player.level >= 42) damage *= 4;
						else damage *= 3;
					}
					else damage *= 2;
				}
				if (game.monster.findPerk(PerkLib.EnemyGroupType) >= 0) damage *= 5;
				outputText(game.monster.capitalA + game.monster.short + " is hit with the bangball!  It breaks apart as it lacerates " + game.monster.pronoun2 + ". <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
				game.monster.HP -= damage;
				if (game.monster.HP < 0) game.monster.HP = 0;
			}
			return(false);
		}
	}
}