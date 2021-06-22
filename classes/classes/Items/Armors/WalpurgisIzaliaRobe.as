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
	
	public class WalpurgisIzaliaRobe extends ArmorWithPerk
	{

		public function WalpurgisIzaliaRobe()
		{
			super("W.I.Cloak","W.I.Cloak","Walpurgis Izalia Cloak","a Walpurgis Izalia Cloak",0,30,12000,"This black cloak is very similar to the clothes of the hellcat witches cabal this cloak include golden filigree shaped like fiery tongues and troubling arcane design. Rumored to have been the prized cloak of the legendary Izalia herself who created the original whitefire.","Light",
					PerkLib.WizardsAndDaoistsEndurance,60,0,0,0);
		}

		override public function playerEquip():Armor {
			while (game.player.hasPerk(PerkLib.WalpurgisIzaliaRobe)) game.player.removePerk(PerkLib.WalpurgisIzaliaRobe);
			game.player.createPerk(PerkLib.WalpurgisIzaliaRobe,0,0,0,0);
			while (game.player.hasPerk(PerkLib.SluttySeduction)) game.player.removePerk(PerkLib.SluttySeduction);
			game.player.createPerk(PerkLib.SluttySeduction,10,0,0,0);
			return super.playerEquip();
		}

		override public function playerRemove():Armor {
			while (game.player.hasPerk(PerkLib.WalpurgisIzaliaRobe)) game.player.removePerk(PerkLib.WalpurgisIzaliaRobe);
			while (game.player.hasPerk(PerkLib.SluttySeduction)) game.player.removePerk(PerkLib.SluttySeduction);
			return super.playerRemove();
		}

	}
}