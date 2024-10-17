/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors 
{
import classes.Items.Armor;
import classes.PerkLib;
import classes.Player;

	public class SpiritFlareQipao extends Armor {
		
		public function SpiritFlareQipao() 
		{
			super("SFlareQ","S.FlareQipao","Spirit Flare Qipao","a Spirit Flare Qipao",10,60,12000,"A traditional qipao from the land of rice. Many folks of this land have strong elemental affinities, and it has been heavily enchanted with elemental magic to enhance the potency of elemental attack and martial arts. When worn by a compatible species, the gathered elements assist in a fast recovery.","Light");
			withTag(I_LEGENDARY);
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) game.player.createPerk(PerkLib.Misdirection, 0, 0, 1, 0);
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			if (game.player.perkv4(PerkLib.Misdirection) == 0 && game.player.perkv3(PerkLib.Misdirection) > 0) game.player.removePerk(PerkLib.Misdirection);
			super.afterUnequip(doOutput, slot);
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
