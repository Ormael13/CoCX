/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;
	
	public class DwarvenWaraxe extends Weapon
	{
		
		public function DwarvenWaraxe() 
		{
			super("DwarWA","DwarvenWaraxe","dwarven waraxe","a dwarven waraxe","cleave",53,2120,"A dwarven waraxe has a large, ornate head mounted to a thick handle, making it too large to use in one hand without special training.", "Large");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 160) boost += 16;
			if (game.player.str >= 120) boost += 13;
			if (game.player.str >= 80) boost += 10;
			if (game.player.str >= 40) boost += 8;
			return (6 + boost); 
		}
	}
}