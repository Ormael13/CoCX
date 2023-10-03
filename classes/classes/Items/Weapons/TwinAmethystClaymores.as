/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class TwinAmethystClaymores extends Weapon
	{
		
		public function TwinAmethystClaymores() 
		{
			super("TAClaym", "T.A.Claymore", "twin amethyst claymores", "a twin amethyst claymores", "cleaving sword-slash", 15, 2400, "Those twin two-handed swords are made of obsidian and grotesquely decorated with amethysts and lead engravings. The magic within those murky blades will bleed unnatural darkness when charged with magic.", "Dual Large", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 40) boost += 8;
			return (7 + boost); 
		}
	}
}