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
	
	public class FairyQueenRegalia extends ArmorWithPerk
	{

		public function FairyQueenRegalia()
		{
			super("F.Q.Regalia","F.Q.Regalia","Fairy Queen Regalia","a Fairy Queen Regalia",0,30,6000,"This long dress has full glove sleeves to match, and changes color depending on your mood. It is lighter than air and about almost as transparent. Modeled after its people carefree nature this dress barely conceal anything though it still hide your assets just enough that you don’t appear outright naked. It also magicaly enhances one's ability to evade and is especially useful when worn by someone trained in the art of misdirection or fey magic. It comes with an assorted Tiara and choker.","Light",
					PerkLib.WizardsAndDaoistsEndurance,60,0,0,0);
		}

		override public function playerEquip():Armor {
			while (game.player.findPerk(PerkLib.FairyQueenRegalia) >= 0) game.player.removePerk(PerkLib.FairyQueenRegalia);
			game.player.createPerk(PerkLib.FairyQueenRegalia,0,0,0,0);
			while (game.player.findPerk(PerkLib.SluttySeduction) >= 0) game.player.removePerk(PerkLib.SluttySeduction);
			game.player.createPerk(PerkLib.SluttySeduction,10,0,0,0);
			return super.playerEquip();
		}

		override public function playerRemove():Armor {
			while (game.player.findPerk(PerkLib.FairyQueenRegalia) >= 0) game.player.removePerk(PerkLib.FairyQueenRegalia);
			while (game.player.findPerk(PerkLib.SluttySeduction) >= 0) game.player.removePerk(PerkLib.SluttySeduction);
			return super.playerRemove();
		}

	}
}