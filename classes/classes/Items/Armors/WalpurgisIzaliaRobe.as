/**
 * ...
 * @author Zavos
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
			super("W.I.Robe","W.I.Robe","Walpurgis Izalia robes","a Walpurgis Izalia robes",0,30,2000,"This black robes conceal most of the user's body when closed but turns into an open cape when the users wills it. Very similar to the clothes of the hellcat witches cabal this robe include golden filigree shaped like fiery tongues and troubling arcane design. Rumored to have been the prized clothes of the legendary Izalia herself who created the original whitefire.","Light",
					PerkLib.WizardsAndDaoistsEndurance,60,0,0,0);
		}

		override public function playerEquip():Armor {
			while (game.player.findPerk(PerkLib.WalpurgisIzaliaRobe) >= 0) game.player.removePerk(PerkLib.WalpurgisIzaliaRobe);
			game.player.createPerk(PerkLib.WalpurgisIzaliaRobe,0,0,0,0);
			while (game.player.findPerk(PerkLib.SluttySeduction) >= 0) game.player.removePerk(PerkLib.SluttySeduction);
			game.player.createPerk(PerkLib.SluttySeduction,10,0,0,0);
			return super.playerEquip();
		}

		override public function playerRemove():Armor {
			while (game.player.findPerk(PerkLib.WalpurgisIzaliaRobe) >= 0) game.player.removePerk(PerkLib.WalpurgisIzaliaRobe);
			while (game.player.findPerk(PerkLib.SluttySeduction) >= 0) game.player.removePerk(PerkLib.SluttySeduction);
			return super.playerRemove();
		}

	}
}