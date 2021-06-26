/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.PerkLib;
	import classes.Player;
	import classes.Items.Weapon;

	public class DualWhip extends Weapon
	{
		
		public function DualWhip() 
		{
			super("P.Whip ", "P.Whip", "pair of coiled whips", "a pair of coiled whips", "whip-crack", 5, 400, "A pair of coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it!", "Dual");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 2;
			return (5 + boost); 
		}
		
		override public function canUse():Boolean {
			if (game.player.hasPerk(PerkLib.DualWield)) return true;
			outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}