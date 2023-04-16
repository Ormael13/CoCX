/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Player;

	public class PurifiedOniChieftainDestroyer extends Weapon
	{
		
		public function PurifiedOniChieftainDestroyer()
		{
			super("POCDest", "POCDestroyer", "Purified Oni Chieftain Destroyer", "a Purified Oni Chieftain Destroyer", "smash", 210, 16800, "This unrealistically large two handed mace was clearly made for some legendary oni chieftain to wield. Even bigger than the standard oni tetsubo this thing could topple buildings. You likely will need some absurd strength just to lift it.", "Large, Whirlwind, LGWrath, Stun15", "Mace/Hammer, Tetsubo");
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
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if (doOutput) {
				outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			}
			return false;
		}
	}
}
