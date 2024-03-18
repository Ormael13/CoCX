/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors
{
import classes.Items.Armor;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;

	public class InariBlessedKimono extends Armor {
		
		public function InariBlessedKimono()
		{
			super("I.B.Kimono","I.B.Kimono","Inari Blessed Kimono","a Inari Blessed Kimono",10,60,12000,"It is said that this beautiful Kimono decorated with flower motifs was worn by lady Inari, firstborn of Taoth who became the first leader of the kitsunes. Increase the potency of spells and soulskill by up to 50% based on purity and empower all Kitsunes ability. Like most kitsune outfit this Kimono is made to improve ones charms and thus leaves you as agile as if naked.","Light");
			withBuffs({
				'spellcost': -0.60,
				'teasedmg': +15
			});
			withPerk(PerkLib.InariBlessedKimono,0,0,0,0);
			withTag(A_REVEALING);
			withTag(I_LEGENDARY);
		}
		
		override public function get def():Number{
			var mod:int = (100-game.player.cor)/20;
			return 5 + mod;
		}
		override public function get mdef():Number{
			var mod:int = (100-game.player.cor)/5;
			return 40 + mod;
		}
	}
}
