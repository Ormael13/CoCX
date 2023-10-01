/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class TwinMachineGreatsword extends Weapon {
		
		public function TwinMachineGreatsword() 
		{
			super("TMacgrsw","T.Mach.greatsword","Twin Machine Greatswords","a Twin Machine Greatswords","slash",19,5440,"This twin greatswords are half invention and half weapon. Instead of a sharp straight blade, the weapon’s sides are a set of metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.", "Dual Large, Bleed100", "Exotic");
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput);
			if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}
