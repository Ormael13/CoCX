/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.ItemTags;
	import classes.Player;

	public class PurifiedOniChieftainDestroyer extends Weapon
	{
		
		public function PurifiedOniChieftainDestroyer()
		{
			super("POCDest", "POCDestroyer", "Purified Oni Chieftain Destroyer", "a Purified Oni Chieftain Destroyer", "smash", 210, 16800, "This unrealistically large two handed mace was clearly made for some legendary oni chieftain to wield. Even bigger than the standard oni tetsubo this thing could topple buildings. You likely will need some absurd strength just to lift it.", "Large, Whirlwind, LGWrath, Stun15", "Mace/Hammer, Tetsubo");
			withTag(ItemTags.I_LEGENDARY);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			var scal:Number = 5;
			if (game.player.str >= 270) {
				boost += 50;
				scal -= 1;
			}
			if (game.player.str >= 180) {
				boost += 50;
				scal -= 1;
			}
			if (game.player.str >= 90) {
				boost += 50;
				scal -= 1;
			}
			boost += Math.round((100 - game.player.cor) / scal);
			return (10 + boost);
		}
	}
}
