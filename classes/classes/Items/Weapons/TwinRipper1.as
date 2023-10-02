/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class TwinRipper1 extends Weapon {
		
		public function TwinRipper1() 
		{
			super("TRipper1","T.Ripper1.0","Twin Ripper 1.0","a Twin Ripper 1.0","slash",24,16520,"Similar to the machine Greatsword, those weapons are highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.", "Dual Large, Bleed100", "Exotic");
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput);
			if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}
