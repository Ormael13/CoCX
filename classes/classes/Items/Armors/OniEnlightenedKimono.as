/**
 * @author Liadri
 */
package classes.Items.Armors
{
	import classes.CoC;
	import classes.Items.Armor;
import classes.PerkLib;
import classes.Player;
	
	public class OniEnlightenedKimono extends Armor
	{
		
		public function OniEnlightenedKimono()
		{
			super("OE Kimo", "OniEnlightenedKimono", "Oni Noble kimono", "an oni noble kimono", 30, 50, 27000, "This deceptively sturdy kimono belonged to a beloved shogun amngst oni nobility. Despite their natural predisposition for domination over smaller races, some oni lords decide to rule as benevolent rulers rather than slavemasters. These benevolent oni lords more often than not are in search of the so called drunken enlightenment.", "Light");
			withTag(A_AGILE);
			withPerk(PerkLib.OniEnlightenedKimono, 0, 0, 0, 0);
			withTag(I_LEGENDARY);
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.tallness >= 80) return super.canEquip(doOutput, slot);
			if (doOutput) outputText("You aren't tall enough to wear this kimono!  ");
			return false;
		}
		override public function get def():Number{
			var mod:int = (100-game.player.cor)/10;
			return 20 + mod;
		}
		override public function get mdef():Number{
			var mod:int = (100-game.player.cor)/5;
			return 30 + mod;
		}
	}
}
