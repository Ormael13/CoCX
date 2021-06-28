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
	
	public class TravelingMerchantOutfit extends ArmorWithPerk
	{

		public function TravelingMerchantOutfit()
		{
			super("T.M.Outfit","T.M.Outfit","Traveling Merchant Outfit","a Traveling Merchant Outfit",0,0,2000,"This outfit looks to be made in the traditional Tanuki merchant fashion. It has been enchanted to help raise one's fortune.","Light",
					PerkLib.WizardsAndDaoistsEndurance,60,0,0,0);
		}

		override public function playerEquip():Armor {
			while (game.player.hasPerk(PerkLib.TravelingMerchantOutfit)) game.player.removePerk(PerkLib.TravelingMerchantOutfit);
			game.player.createPerk(PerkLib.TravelingMerchantOutfit,0,0,0,0);
			return super.playerEquip();
		}

		override public function playerRemove():Armor {
			while (game.player.hasPerk(PerkLib.TravelingMerchantOutfit)) game.player.removePerk(PerkLib.TravelingMerchantOutfit);
			return super.playerRemove();
		}

	}
}