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

	public class DualNodachi extends Weapon {
		
		public function DualNodachi() 
		{
			super("DNodachi","DualNodachi","dual nodachi","a dual nodachi","keen cut",65,5200,"Pair of curved over 3m long bladed weapons that cuts through flesh with the greatest of ease.", "Dual Massive", "Dueling");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 250) boost += 30;
			if (game.player.str >= 200) boost += 20;
			if (game.player.str >= 150) boost += 10;
			return (5 + boost);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) && (game.player.hasPerk(PerkLib.TitanGrip) || (game.player.hasPerk(PerkLib.GigantGripSu) && game.player.playerHasFourArms()))) return super.canEquip(doOutput);
			if (!game.player.hasPerk(PerkLib.TitanGrip)) outputText("You aren't skilled enough to handle this pair of weapons with only two hands!  Unless you want to hurt yourself instead of your enemies when trying to use them...  ");
			else {
				if (game.player.playerHasFourArms()) outputText("You aren't skilled enough to handle this pair of weapons!  Unless you want to hurt yourself instead of your enemies when trying to use them...  ");
				else outputText("You lack second pair of arms!  ");
			}
			return false;
		}
	}
}
