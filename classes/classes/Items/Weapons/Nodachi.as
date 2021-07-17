/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;
	import classes.PerkLib;
	import classes.StatusEffects;

	public class Nodachi extends Weapon {
		
		public function Nodachi() 
		{
			super("Nodachi","Nodachi","nodachi","a nodachi","keen cut",65,2600,"A curved over 3m long bladed weapon that cuts through flesh with the greatest of ease.", "Massive");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 250) boost += 30;
			if (game.player.str >= 200) boost += 20;
			if (game.player.str >= 150) boost += 10;
			return (5 + boost); 
		}
		
		override public function canUse():Boolean {
			if (game.player.hasPerk(PerkLib.GigantGrip)) return true;
			outputText("You aren't skilled in handling massive weapons, even when using both hands to use this sword.  ");
			return false;
		}
	}
}