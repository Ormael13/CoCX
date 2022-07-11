/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class DualSwords extends Weapon {
		
		public function DualSwords() {
			super("DSwords", "DualSwords", "dual swords", "a pair of swords", "slashes", 10, 800, "A pair of swords made of the finest steel usefull for fight groups of enemies.", "Dual", "Sword");
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput);
			if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}
