/**
 * ...
 * @author Canadian Snas
 */
package classes.Items.Weapons
{
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.CoC;
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class TaintlessKnives extends Weapon
	{
		
		public function TaintlessKnives()
		{
			super("TKnives", "T.Knives", "Taintless Knives", "a Taintless Knives", "slash", 5, 800, "These beautiful steel knives seem to shine with a light all their own. Engraved with white runes, the silk-bound handles seem to mold themselves to your grip. They each have a sheathe, bound to a leather bandolier that fits snugly around your waist without the need for adjustments. The knives themselves feel almost weightless, an extension of your hand.", "Dual Small", "Dagger");
		}
		
		override public function get attack():Number {
			var temp:int = 5 + (10 - game.player.cor / 6);
			if (temp < 1) temp = 1;
			return temp;
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (!super.canEquip(doOutput)) {
				return false;
			}
			else if (!game.player.hasPerk(PerkLib.DualWield) && !game.player.hasPerk(PerkLib.AntyDexterity)) {
				if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
				return false;
			}
			else if (game.player.cor >= (33 + game.player.corruptionTolerance)) {
				if (doOutput) {
					outputText("As you loop the bandolier over your head, the leather tightens rapidly. You panic, throwing it back over your head, and the leather tightens just enough to scrape your scalp as you get it over your head. As it leaves your grip, the leather loosens back up, appearing to all your senses like a normal leather bandolier. Inanimate again, you warily pick up the thing again, taking one of your knives’ handles.\n\n");
					outputText("The handle burns your skin on contact, and you yelp, tossing it down and away. For whatever reason, these magical knives aren’t letting you wield them.  ");
				}
				return false;
			}
			return true;
		}
		override public function equipText():void {
			outputText("You slide the leather bandolier over your head, fitting it snugly around your waist. The knives, safe in their sheathes, seem to glow brighter as you put a hand on each hilt.\n\n");
		}
	}
}
