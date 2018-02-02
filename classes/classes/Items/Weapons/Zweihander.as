/**
 * ...
 * @author Coalsack
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class Zweihander extends Weapon
	{
		
		public function Zweihander() 
		{
			super("Zwnder ","Zwnder","zweihander","a zweihander","slash",31,2480,"A favorite of the mercenaries of Marethian frontier, this zweihander it’s a weapon that only swordsmen of incredible physical force can wield properly. The pommel is decorated with a fierce-looking wolf, and, as well as the handguard, is made of silver with lupine motifs. The blade is a six foot monster of pure steel, some noticeable waves at each edge giving this weapon it’s distinctive appearance.","Large");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 105) boost += 11;
			return (20 + boost); 
		}	
	}
}