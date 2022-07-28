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
			super("S.Armor", "S.Armor", "Succubus armor", "a Succubus armor", 20, 0, 800, "The fully corrupted maiden armor became an armor fit for a succubus. It incite its owner to sex and rewards it for debauching herself. It's already suggestive design became downright obscene as the metal and clothes color turned black as night.", "Light", false, false);
			withBuffs({'teasedmg':10});
			withTag(ItemTags.A_REVEALING);
		}
		
		override public function get def():Number {
			return 20 + (game.flags[kFLAGS.BIKINI_ARMOR_BONUS] * 2);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (!super.canEquip(doOutput)) return false;
			if (game.player.level < 40) {
				if (doOutput) outputText("You try and wear the legendary armor, but, to your disapointment, the item simply refuses to stay on your body. It would seem you lack the power and right to wield this item yet.");
				return false;
			}
			return LustyMaidensArmor.canUseStatic(doOutput);
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			_buffs['teasedmg'] =  10 + (game.flags[kFLAGS.BIKINI_ARMOR_BONUS] * 2);
			super.afterEquip(doOutput);
		}
	}
}
