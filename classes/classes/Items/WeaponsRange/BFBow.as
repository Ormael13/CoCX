/**
 * ...
 * @author Ormael
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	
	public class BFBow extends WeaponRangeWithPerk
	{
		
		public function BFBow() 
		{
			super("B F Bow", "B.F.Bow", "big fucking bow", "a big fucking bow", "shot", 50, 2500, "Big Fucking Bow - the best solution for a tiny e-pen complex at this side of the Mareth!  This 2H 3,5 meters long bow requires 150 speed to fully unleash it power.", "Bow", PerkLib.Accuracy2,30,0,0,0);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.spe >= 150) boost += 20;
			if (game.player.spe >= 100) boost += 15;
			if (game.player.spe >= 50) boost += 10;
			return (5 + boost); 
		}
	}
}