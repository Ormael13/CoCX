/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class DualKatana extends Weapon {
		
		public function DualKatana() 
		{
			super("D.Katana","D.Katana","dual katana","a dual katana","keen cut",15,1360,"A pair of curved bladed weapons that cuts through flesh with the greatest of ease.", "Dual Large", "Dueling");
		}
		
		override public function canUse():Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) && (game.player.hasPerk(PerkLib.GigantGrip) || gameplayer.hasPerk(PerkLib.AntyDexterity))) || (game.player.hasPerk(PerkLib.GigantGrip) && gameplayer.hasPerk(PerkLib.AntyDexterity)) return super.canUse();
			else if (game.player.hasPerk(PerkLib.GigantGrip) || gameplayer.hasPerk(PerkLib.AntyDexterity)) outputText("You aren't skilled in handling large weapons with one hand yet to effectively use those katanas. Unless you want to hurt yourself instead of your enemies when trying to use them...  ");
			else outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}