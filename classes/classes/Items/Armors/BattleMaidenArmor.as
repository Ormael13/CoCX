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
			super("BMArmor", "BMArmor", "Battle maiden armor", "a Battle maiden armor", 80, 40, 4800, "The purified original maiden armor recovered its former property. It fully protect the virginity of its wielder even going so far as to progressively clear the fog of lust from her mind.", "Light", false, false);
			withTag(ItemTags.A_REVEALING);
		}
		
		override public function get def():Number{
			var mod:int = 0;
			if (game.player.hasVirginVagina()) mod += 40;
			mod += (100-game.player.cor)/5;
			return 20 + mod;
		}
		override public function get mdef():Number{
			var mod:int = 0;
			if (game.player.hasVirginVagina()) mod += 20;
			mod += (100 - game.player.cor) / 10;
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
	}
}
