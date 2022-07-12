/**
 * @author Liadri
 */
package classes.Items.Armors
{
	import classes.CoC;
	import classes.Items.Armor;
import classes.Items.ItemTags;
import classes.PerkLib;
import classes.Player;
	
	public class OniEnlightenedKimono extends Armor
	{
		
		public function OniEnlightenedKimono()
		{
			super("OE Kimo", "OniEnlightenedKimono", "Oni Noble kimono", "a oni noble kimono", 0, 20, 10000, "This deceptively sturdy kimono belonged to a beloved shogun amonst oni nobility. Despite their natural predisposition for domination over smaller races, some oni lords decides to rule as benevolent rulers rather then slavemasters. These benevolent oni lords more often then not are in search of the so called drunken enlightment.", "Light");
			withTag(ItemTags.A_AGILE);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.tallness >= 80 || game.player.level >= 40) return super.canEquip(doOutput);
			if (doOutput) {
				if (game.player.level >= 40) outputText("You try and wear the legendary armor but to your disapointment the item simply refuse to stay on your body. It would seem you yet lack the power and right to wield this item.");
				else outputText("You aren't tall enough to wear this kimono!  ");
			}
			return false;
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				while (game.player.hasPerk(PerkLib.OniEnlightenedKimono)) game.player.removePerk(PerkLib.OniEnlightenedKimono);
				game.player.createPerk(PerkLib.OniEnlightenedKimono, 0, 0, 0, 0);
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			while (game.player.hasPerk(PerkLib.OniEnlightenedKimono)) game.player.removePerk(PerkLib.OniEnlightenedKimono);
			super.afterUnequip(doOutput);
		}

		override public function get def():Number{
			var mod:int = (100-game.player.cor)/10;
			return 13 + mod;
		}
	}
}
