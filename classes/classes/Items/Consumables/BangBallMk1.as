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

	public final class BangBallMk1 extends Consumable {
		
		public function BangBallMk1() {
			super("BangBM1", "BangBallMk1", "a bangball mark 1", 21, "A ball-shaped throwing weapon.  Though good for only a single use, it's guaranteed to do very low to low damage to solo or weak group of enemies if it hits.  Inflicts 70 to 210 base damage.");
		}
		
		override public function canUse():Boolean {
			if (game.inCombat) return true;
			outputText("There's no one to throw it at!");
			return false;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You toss a bangball mk 1 at your foe");
			if (game.monster.findPerk(PerkLib.EnemyGroupType) >= 0) outputText("s");
			outputText("!  It flies straight and true, almost as if it has a mind of its own as it arcs towards " + game.monster.a + game.monster.short + "!\n");
			if (game.monster.spe - 160 > Utils.rand(100) + 1) { //1% dodge for each point of speed over 160
				outputText("Somehow " + game.monster.a + game.monster.short + "'");
				if (!game.monster.plural) outputText("s");
				outputText(" incredible speed allows " + game.monster.pronoun2 + " to avoid the ball!  The deadly sphere shatters when it impacts something in the distance.");
			}
			else { //Not dodged
				var damage:Number = 70 + Utils.rand(36);
				if (game.player.level >= 6) damage *= 2;
				if (game.monster.findPerk(PerkLib.EnemyGroupType) >= 0) damage *= 5;
				outputText(game.monster.capitalA + game.monster.short + " is hit with the bangball!  It breaks apart as it lacerates " + game.monster.pronoun2 + ". <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
				game.monster.HP -= damage;
				if (game.monster.HP < 0) game.monster.HP = 0;
			}
			return(false);
		}
	}
}