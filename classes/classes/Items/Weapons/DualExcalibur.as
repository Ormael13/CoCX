/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.ItemTags;
	import classes.PerkLib;
	import classes.Player;
	import classes.GlobalFlags.*;
	
	public class DualExcalibur extends Weapon
	{
		
		public function DualExcalibur() 
		{
			super("DExcalib", "DualExcalibur", "Dual Excalibur", "a Dual Excalibur", "slash", 40, 1600, "A legendary dual swords said to have been made by Marae for her champion. Those weapon radiates divine power, purifying its wielder and protecting them from impurity.", "Dual", "Sword");
			withTag(ItemTags.I_LEGENDARY);
		}
		
		override public function get attack():Number {
			var temp:int = 10 + int((90 - game.player.cor) / 3);
			if (temp < 10) temp = 10;
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
