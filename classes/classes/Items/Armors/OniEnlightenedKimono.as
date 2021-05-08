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
			super("OE Kimo", "OniEnlightenedKimono", "Oni Noble kimono", "a oni noble kimono", 0, 20, 160, "This deceptively sturdy kimono belonged to a shogun amonst oni nobility. Despite their natural predisposition for domination over smaller races, some oni lords decides to rule as benevolent rulers rather then slavemastersr. These oni typicaly are in search of the so called drunken enlightment.", "Light");
		}
		
		override public function canUse():Boolean {
			if (game.player.tallness >= 80) return true;
			outputText("You aren't tall enough to wear this kimono!  ");
			return false;
		}

		override public function playerEquip():Armor {
			while (game.player.findPerk(PerkLib.OniEnlightenedKimono) >= 0) game.player.removePerk(PerkLib.OniEnlightenedKimono);
			game.player.createPerk(PerkLib.OniEnlightenedKimono,0,0,0,0);
			return super.playerEquip();
		}

		override public function playerRemove():Armor {
			while (game.player.findPerk(PerkLib.OniEnlightenedKimono) >= 0) game.player.removePerk(PerkLib.OniEnlightenedKimono);
			return super.playerRemove();
		}
	}
}