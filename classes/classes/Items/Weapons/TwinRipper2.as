/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class TwinRipper2 extends Weapon {
		
		public function TwinRipper2() 
		{
			super("TRipper2","T.Ripper2.0","Twin Ripper 2.0","a Twin Ripper 2.0","slash",29,34720,"Similar to the machine Greatsword, those weapons are highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. The blades movement is so fast it creates heat along the length and thanks to a small system set, the saws are constantly aflame. Aside of cutting fleshy things in half, it is very good for taking down trees.", "Dual Large, Bleed100", "Exotic");
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput);
			if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}
