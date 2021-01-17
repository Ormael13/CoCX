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
	
	public class InariBlessedKimono extends ArmorWithPerk
	{

		public function InariBlessedKimono()
		{
			super("I.B.Kimono","I.B.Kimono","Inari Blessed Kimono","a Tamamo no Mae Cursed Kimono",0,30,12000,"It is said that this beautiful Kimono decorated with flower motifs was worn by lady Inari, firstborn of Taoth who became the first leader of the kitsunes. Increase the potency of spells and soulskill by up to 50% based on corruption and empower all Kitsunes ability. Like most kitsune outfit this Kimono is made to improve ones charms and thus leaves you as agile as if naked.","Light",
					PerkLib.WizardsAndDaoistsEndurance,60,0,0,0);
		}

		override public function playerEquip():Armor {
			while (game.player.findPerk(PerkLib.InariBlessedKimono) >= 0) game.player.removePerk(PerkLib.InariBlessedKimono);
			game.player.createPerk(PerkLib.InariBlessedKimono,0,0,0,0);
			while (game.player.findPerk(PerkLib.SluttySeduction) >= 0) game.player.removePerk(PerkLib.SluttySeduction);
			game.player.createPerk(PerkLib.SluttySeduction,15,0,0,0);
			return super.playerEquip();
		}

		override public function playerRemove():Armor {
			while (game.player.findPerk(PerkLib.InariBlessedKimono) >= 0) game.player.removePerk(PerkLib.InariBlessedKimono);
			while (game.player.findPerk(PerkLib.SluttySeduction) >= 0) game.player.removePerk(PerkLib.SluttySeduction);
			return super.playerRemove();
		}

	}
}