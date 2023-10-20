/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.CoC;
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class DualBeautifulSword extends Weapon {
		
		public function DualBeautifulSword() 
		{
			super("DBSword", "DB.Sword", "dual beautiful swords", "a dual beautiful shining swords", "slash", 7, 1120, "Those beautiful swords shines brilliantly in the light, showing the flawless craftsmanship of their blades.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into those blade.", "Dual", "Sword");
		}
		
		override public function get attack():Number {
			var temp:int = 7 + (10 - game.player.cor / 3);
			if (temp < 5) temp = 5;
			return temp;
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if ((game.player.cor < (33 + game.player.corruptionTolerance)) || (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity))) return super.canEquip(doOutput);
			if (doOutput) {
				if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) outputText("You aren't skilled enough to handle this pair of weapons!  ");
				else outputText("You grab hold of the handle of the swords only to have it grow burning hot.  You're forced to let it go lest you burn yourself.  Something within the swords must be displeased.  ");
			}
			return false;
		}
	}
}
