/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors 
{
import classes.Items.Armor;
import classes.Items.ItemTags;

	public class BattleMaidenArmor extends Armor {
		
		public function BattleMaidenArmor()
		{
			super("BMArmor", "BMArmor", "Battle maiden armor", "a Battle maiden armor", 40, 0, 1600, "The purified original maiden armor recovered its former property. It fully protect the virginity of its wielder even going so far as to progressively clear the fog of lust from her mind.", "Light", false, false);
			withTag(ItemTags.REVEALING);
		}

		override public function canUse():Boolean {
			if (!super.canUse()) return false;
			if (game.player.level < 40) {
				outputText("You try and wear the legendary armor but to your disapointment the item simply refuse to stay on your body. It would seem you yet lack the power and right to wield this item.");
				return false;
			}
			return LustyMaidensArmor.canUseStatic();
		}
	}
}