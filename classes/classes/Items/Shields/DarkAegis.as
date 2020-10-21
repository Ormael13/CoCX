/**
 * ...
 * @author Liadri
 */
package classes.Items.Shields 
{
	import classes.Items.Shield;
	import classes.PerkLib;
	import classes.Player;

	public class DarkAegis extends ShieldWithPerk
	{
		
		public function DarkAegis() 
		{
			super("SanctD", "Dark Aegis", "dark aegis", "a dark aegis", 29, 2900,
					"Gleaming in black metal and obsidian plates, this legendary shield is said to heal and protect a fallen knight. Demonic ornaments cover most of its obsidian-carved surface.",
					"Large", PerkLib.Sanctuary, 2, 0, 0, 0
			);
		}
		
		override public function get block():Number {
			var block:int = 0;
			block += Math.round((game.player.cor) / 5);
			if (game.player.str >= 40) block += 9;
			if (game.player.str >= 20) block += 3;
			return (0 + block);
		}
	}
}