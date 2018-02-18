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
			super("Zwnder ","Zwnder","zweihander","a zweihander","slash",31,2480,
					"The zweihander is a longsword recognizable by its six foot monster of a blade and its wavy edges. On this one, the pommel and handle are decorated with a fierce-looking wolf and made of silver with other lupine motifs as ornaments.",
					"Large"
			);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 105) boost += 11;
			return (20 + boost); 
		}	
	}
}