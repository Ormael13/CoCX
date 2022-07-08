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
			withTag(ItemTags.REVEALING);
		}
		
		override public function get def():Number {
			return 20 + (game.flags[kFLAGS.BIKINI_ARMOR_BONUS] * 2);
		}
		
		override public function canUse():Boolean {
			if (!super.canUse()) return false;
			if (game.player.level < 40) {
				outputText("You try and wear the legendary armor but to your disapointment the item simply refuse to stay on your body. It would seem you yet lack the power and right to wield this item.");
				return false;
			}
			return LustyMaidensArmor.canUseStatic();
		}
		
		override public function afterEquip(slot:int, doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				while (game.player.hasPerk(PerkLib.SluttySeduction)) game.player.removePerk(PerkLib.SluttySeduction);
				game.player.createPerk(PerkLib.SluttySeduction, 10 + (game.flags[kFLAGS.BIKINI_ARMOR_BONUS] * 2), 0, 0, 0);
			}
			super.afterEquip(slot, doOutput);
		}
		
		override public function afterUnequip(slot:int, doOutput:Boolean):void {
			while (game.player.hasPerk(PerkLib.SluttySeduction)) game.player.removePerk(PerkLib.SluttySeduction);
			super.afterUnequip(slot, doOutput);
		}
	}
}
