package classes.Items.Weapons
{
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Weapon;
import classes.Items.ItemTags;
import classes.PerkLib;

public class BlackWidow extends Weapon
	{
		
		public function BlackWidow()
		{
			super("BWidow", "B. Widow", "black widow rapier", "a black widow rapier", "slash", 80, 9600,
					"A rapier that used to belong a deceitful noblewoman, made in a strange, purple metal. Its pommel design looks similar to that of a spiderweb, while the blade and hilt are decorated with amethysts and arachnid-looking engravings.", WP_AP100, WT_DUELING
			);
			withTag(ItemTags.I_LEGENDARY);
		}
		override public function get attack():Number{
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.HiddenJobSwordImmortal)) boost += 64;
			else {
				var scal:Number = 20;
				if (game.player.spe >= 100) {
					boost += 20;
					scal -= 5;
				}
				if (game.player.spe >= 50) {
					boost += 20;
					scal -= 5;
				}
				boost += Math.round(game.player.cor / scal);
				boost += (game.player.femininity / scal);
				if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
				else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			}
			return (20 + boost);
		}
	}

}
