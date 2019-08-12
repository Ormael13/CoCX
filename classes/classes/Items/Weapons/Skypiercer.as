/**
 * ...
 * @author Ormael & Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class Skypiercer extends Weapon {
		
		public function Skypiercer() 
		{
			super("Skypier", "Skypiercer", "Skypiercer", "a Skypiercer", "piercing stab", 55, 3840, "Tales has it that this spear tip is so sharp it is said it could pierce through the sky.  Req. 300+ speed and 100+ strength to unleash full attack power", "Large");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.spe >= 300 && game.player.str >= 100) boost += 7;
			if (game.player.spe >= 270 && game.player.str >= 90) boost += 6;
			if (game.player.spe >= 240 && game.player.str >= 80) boost += 6;
			if (game.player.spe >= 210 && game.player.str >= 70) boost += 6;
			if (game.player.spe >= 180 && game.player.str >= 60) boost += 6;
			if (game.player.spe >= 150 && game.player.str >= 50) boost += 5;
			if (game.player.spe >= 120 && game.player.str >= 40) boost += 5;
			if (game.player.spe >= 90 && game.player.str >= 30) boost += 5;
			if (game.player.spe >= 60 && game.player.str >= 20) boost += 5;
			return (4 + boost); 
		}
	}
}