package classes.Items.Weapons
{
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Weapon;

public class QueensGuard extends Weapon
	{
		
		public function QueensGuard()
		{
			super("Q.Guard", "Q. Guard", "queen's guard rapier", "a queen's guard rapier", "slash", 80, 9600,
					" An elegant rapier made in brass and gold, with the seal of Mareth’s former nobility. The ruby gemstones running among the blade and the intricate engravings in gold identify it as belonging to the old kingdom knighthoods orders.", WP_AP100, WT_DUELING
			);
		}
		override public function get attack():Number{
			var boost:int = 0;
			var scal:Number = 20;
			if (game.player.spe >= 100) {
				boost += 20;
				scal -= 5;
			}
			if (game.player.spe >= 50) {
				boost += 20;
				scal -= 5;
			}
			boost += Math.round((100 - game.player.cor) / scal);
			boost += ((100 - game.player.femininity) / scal);
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			return (20 + boost);
		}
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if (doOutput) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
	}

}
