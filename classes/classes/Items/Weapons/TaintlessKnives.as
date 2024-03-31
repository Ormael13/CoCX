/**
 * ...
 * @author Canadian Snas
 */
package classes.Items.Weapons
{
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.CoC;
import classes.Items.IELib;
import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class TaintlessKnives extends Weapon
	{
		
		public function TaintlessKnives()
		{
			super("TKnives", "T.Knives", "Taintless Knives", "a Taintless Knives", "slash", 15, 800, "These beautiful steel knives seem to shine with a light all their own. Engraved with white runes, the silk-bound handles seem to mold themselves to your grip. They each have a sheathe, bound to a leather bandolier that fits snugly around your waist without the need for adjustments. The knives themselves feel almost weightless, an extension of your hand.", WT_DAGGER, WSZ_SMALL, true);
			withEffect(IELib.Require_CorBelow, 33);
			withEffect(IELib.AttackBonus_Cor, -1/6)
		}
		
		override public function getItemText(textid:String):String {
			if (textid == "onequip") {
				return "You slide the leather bandolier over your head, fitting it snugly around your waist. The knives, safe in their sheathes, seem to glow brighter as you put a hand on each hilt.\n\n";
			}
			if (textid == "too_corrupt") {
				return "As you loop the bandolier over your head, the leather tightens rapidly. You panic, throwing it back over your head, and the leather tightens just enough to scrape your scalp as you get it over your head. As it leaves your grip, the leather loosens back up, appearing to all your senses like a normal leather bandolier. Inanimate again, you warily pick up the thing again, taking one of your knives’ handles.\n\nThe handle burns your skin on contact, and you yelp, tossing it down and away. For whatever reason, these magical knives aren’t letting you wield them.  "
			}
			return super.getItemText(textid);
		}
	}
}
