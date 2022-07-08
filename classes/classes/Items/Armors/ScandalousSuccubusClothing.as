/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors
{
import classes.BodyParts.LowerBody;
import classes.Items.Armor;
import classes.Items.ItemTags;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;
	
	public class ScandalousSuccubusClothing extends ArmorWithPerk
	{

		public function ScandalousSuccubusClothing()
		{
			super("S.S.Clothing","S.S.Clothing","Scandalous Succubus Clothing","a Scandalous Succubus Clothing",0,30,6000,"This black leather vestment consist of two sleeves open at the hands with fur trimming, a choker with a large gold ring to which a chain can be attached, a very minimalistic panty and two pairs of socks with a golden trim at the tight. Since the bra is very thin your breasts are almost fully on display for whoever wants to see and grope them. A perfectly decadent dress for a supremely lewd succubus.","Light",
					PerkLib.SluttySeduction,15,0,0,0,"Your incredibly revealing outfits allows you access to 'Seduce', an improved form of 'Tease'.",false,false);
			withTag(ItemTags.REVEALING, ItemTags.AGILE);
		}

		//override public function canUse():Boolean{
		//	if (game.player.isFemale() && (!game.player.isTaur() || !game.player.lowerBody == LowerBody.NAGA || !game.player.lowerBody == LowerBody.SCYLLA || !game.player.lowerBody == LowerBody.KRAKEN || !game.player.lowerBody == LowerBody.CENTIPEDE || !game.player.lowerBody == LowerBody.GOO || !game.player.lowerBody == LowerBody.MELKIE || !game.player.lowerBody == LowerBody.DRIDER)){return super.canUse()}
		//	outputText("This armor is designed for females let alone females with normal two legged bodies.");
		//	return false;
		//}
		
		override public function afterEquip(slot:int, doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				while (game.player.hasPerk(PerkLib.ScandalousSuccubusClothing)) game.player.removePerk(PerkLib.ScandalousSuccubusClothing);
				game.player.createPerk(PerkLib.ScandalousSuccubusClothing, 0, 0, 0, 0);
			}
			super.afterEquip(slot, doOutput);
		}
		
		override public function afterUnequip(slot:int, doOutput:Boolean):void {
			while (game.player.hasPerk(PerkLib.ScandalousSuccubusClothing)) game.player.removePerk(PerkLib.ScandalousSuccubusClothing);
			super.afterUnequip(slot, doOutput);
		}

	}
}
