/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors
{
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armor;
import classes.Items.ItemTags;
import classes.PerkLib;

	public class SuccubusArmor extends Armor {
		
		public function SuccubusArmor()
		{
			super("S.Armor", "S.Armor", "Succubus armor", "a Succubus armor", 50, 25, 3000, "The fully corrupted maiden armor became an armor fit for a succubus. It incite its owner to sex and rewards it for debauching herself. It's already suggestive design became downright obscene as the metal and clothes color turned black as night.", "Light", false, false);
			withBuffs({'teasedmg':10, 'minlustx': 0.3});
			withTag(ItemTags.A_REVEALING);
		}
		
		override public function get def():Number {
			var mod:int = 0;
			mod += game.player.cor/10;
			mod += (game.flags[kFLAGS.BIKINI_ARMOR_BONUS] * 2);
			return 20 + mod;
		}
		override public function get mdef():Number{
			var mod:int = 0;
			mod += game.player.cor/20;
			mod += game.flags[kFLAGS.BIKINI_ARMOR_BONUS];
			return 10 + mod;
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (!super.canEquip(doOutput)) return false;
			if (game.player.level < 54) {
				if (doOutput) outputText("You try and wear the legendary armor, but, to your disapointment, the item simply refuses to stay on your body. It would seem you lack the power and right to wield this item yet.");
				return false;
			}
			return LustyMaidensArmor.canUseStatic(doOutput);
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			_buffs['teasedmg'] = (10 + game.flags[kFLAGS.BIKINI_ARMOR_BONUS]) * 5;
			super.afterEquip(doOutput);
		}
	}
}
