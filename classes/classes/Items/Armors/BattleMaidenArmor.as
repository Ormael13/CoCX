/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors
{
import classes.Items.Armor;

	public class BattleMaidenArmor extends Armor {
		
		public function BattleMaidenArmor()
		{
			super("BMArmor", "BMArmor", "Battle maiden armor", "a Battle maiden armor", 80, 40, 4800, "The purified original maiden armor recovered its former property. It fully protects the virginity of its wielder even going so far as to progressively clear the fog of lust from her mind.", "Light", false, false);
			withTag(A_REVEALING);
			withTag(I_LEGENDARY);
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
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (!super.canEquip(doOutput, slot)) return false;
			return LustyMaidensArmor.canUseStatic(doOutput);
		}
	}
}
