/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Player;
	import classes.Items.ItemTags;

	public class DefiledOniChieftainDestroyer extends Weapon
	{
		
		public function DefiledOniChieftainDestroyer()
		{
			super("DOCDest", "DOCDestroyer", "Defiled Oni Chieftain Destroyer", "a Defiled Oni Chieftain Destroyer", "smash", 210, 16800, "This unrealistically large two handed mace was clearly made for some legendary oni chieftain to wield. Even bigger than the standard oni tetsubo this thing could topple buildings. You likely will need some absurd strength just to lift it.", "Large, Whirlwind, LGWrath, Stun15", "Mace/Hammer ,Tetsubo");
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
			boost += Math.round(game.player.cor / scal);
			return (10 + boost);
		}
	}
}
