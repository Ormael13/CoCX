/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.PerkLib;
	import classes.Player;
	import classes.Items.Weapon;

	public class NineTailWhip extends Weapon
	{
		
		public function NineTailWhip() 
		{
			super("NTWhip ", "NineTailWhip", "nine tail whip", "a nine tail whip", "whipping", 18, 720, "A rope that unravelled into three small ropes, each of which is unravelled again designed to whip your foes into submission.", "Large");
		}
		//przerobić na mid grade wrath weapon?
		override public function get attack():Number {
			var boost:int = 0;
			var base:int = 0;
			if ((game.player.str + game.player.spe) >= 120) {
				base += 9;
				if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 4;
			}
			if ((game.player.str + game.player.spe) >= 60) {
				base += 4;
				if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 2;
			}
			if (((game.player.str + game.player.spe) < 60) && game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 2;
			return (5 + base + boost); 
		}
		
		override public function canUse():Boolean {
			if (game.player.findPerk(PerkLib.GigantGrip) >= 0) return true;
			outputText("You aren't skilled in handling large weapons with one hand yet to effectively use this whip. Unless you want to hurt yourself instead enemies when trying to use it...  ");
			return false;
		}
	}
}