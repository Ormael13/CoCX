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
			super("NTWhip ", "NineTailWhip", "nine tail whip", "a nine tail whip", "whipping", 9, 360, "A rope that unravelled into three small ropes, each of which is unravelled again designed to whip your foes into submission.");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 4;
			return (9 + boost); 
		}
	}
}