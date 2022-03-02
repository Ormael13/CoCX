/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class Daisho extends Weapon {
		
		public function Daisho() 
		{
			super("Daisho ","Daisho","daisho","a daisho","keen cut",15,1360,"Set of katana & wakizashi that cuts through flesh with the greatest of ease.", "Hybrid", "Dueling");
		}
		
		override public function canUse():Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) && game.player.hasPerk(PerkLib.GigantGrip)) return super.canUse();
			if (!game.player.hasPerk(PerkLib.DualWield)) outputText("You aren't skilled in handling large weapons with one hand yet to effectively use this katanas & wakizashi pair. Unless you want to hurt yourself instead enemies when trying to use them...  ");
			else outputText("You aren't skilled enough to handle this katanas & wakizashi pair!  ");
			return false;
		}
	}
}