/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class DualLargeAxe extends Weapon {
		
		public function DualLargeAxe() {
			super("D.L.Axe", "D.L.Axe", "dual large axes", "an pair of axes large enough for a minotaur", "cleaves", 18, 1440, "This pair of massive axes once belonged to a minotaur.  It'd be hard for anyone smaller than a giant to wield effectively.  Those axes are double-bladed and deadly-looking.  Requires height of 6'6\".", "Dual Large");
		}
		//zmniejszenie do 18 atk jak zrobi aby PC attakował 2x podwójnymi brońmi
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 120) boost += 9;
			return (9 + boost); 
		}
		
		override public function canUse():Boolean {
			if (game.player.findPerk(PerkLib.DualWieldLarge) >= 0) return true;
			outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}	
	}
}