/**
 * Created by aimozg on 11.01.14.
 */
package classes.Items.Consumables
{
	import classes.Items.Consumable;
	import classes.Player;
	import classes.internals.Utils;

	public final class WingStick extends Consumable {
		
		public function WingStick() {
			super("W.Stick", "Wingstick", "a wingstick", 16, "A tri-bladed throwing weapon.  Though good for only a single use, it's guaranteed to do high damage if it hits.  Inflicts 40 to 100 base damage, affected by strength.");
		}
		
		override public function canUse():Boolean {
			if (game.inCombat) return true;
			outputText("There's no one to throw it at!");
			return false;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You toss a wingstick at your foe!  It flies straight and true, almost as if it has a mind of its own as it arcs towards " + game.monster.a + game.monster.short + "!\n");
			if (game.monster.spe - 80 > Utils.rand(100) + 1) { //1% dodge for each point of speed over 80
				outputText("Somehow " + game.monster.a + game.monster.short + "'");
				if (!game.monster.plural) outputText("s");
				outputText(" incredible speed allows " + game.monster.pronoun2 + " to avoid the spinning blades!  The deadly device shatters when it impacts something in the distance.");
			}
			else { //Not dodged
				var damage:Number = 40 + Utils.rand(61) + (game.player.str * 2);
				outputText(game.monster.capitalA + game.monster.short + " is hit with the wingstick!  It breaks apart as it lacerates " + game.monster.pronoun2 + ". <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
				game.monster.HP -= damage;
				if (game.monster.HP < 0) game.monster.HP = 0;
			}
			return(false);
		}
	}
}
