/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.PerkLib;

public class DualKama extends Weapon {
		
		public function DualKama() 
		{
			
		}
	
	override public function canEquip(doOutput:Boolean):Boolean {
		if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) {
			return super.canEquip(doOutput);
		}
		if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
		return false;
	}
}
}
