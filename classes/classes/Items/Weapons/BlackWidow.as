package classes.Items.Weapons
{
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Weapon;

public class BlackWidow extends Weapon
	{
		
		public function BlackWidow()
		{
			super("BWidow", "B. Widow", "black widow rapier", "a black widow rapier", "slash", 20, 2400,
					"A rapier that used to belong a deceitful noblewoman, made in a strange, purple metal. Its pommel design looks similar to that of a spiderweb, while the blade and hilt are decorated with amethysts and arachnid-looking engravings.", WP_AP100, WT_DUELING
			);
		}
		override public function get attack():Number{
			var boost:int = 0;
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			boost += ((game.player.femininity) / 20) + ((game.player.cor) / 20) / 2;
			return (20 + boost);
		}
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 40) return super.canEquip(doOutput);
			if (doOutput) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
	}

}
