/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Player;

	public class HugeWarhammer extends Weapon {
		
		public function HugeWarhammer() {
			super("Warhamr", "Warhammer", "huge warhammer", "a huge warhammer", "smash", 15, 1200, "A huge war-hammer made almost entirely of steel that only the strongest warriors could use.  Getting hit with this might stun the victim.", "Large, Whirlwind, Stun10", "Mace/Hammer");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 80) boost += 8;
			return (7 + boost); 
		}	
	}
}