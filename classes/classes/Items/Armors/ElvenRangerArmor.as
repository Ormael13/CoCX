/**
 * @author Liadri
 */
package classes.Items.Armors
{
import classes.Items.Armor;
import classes.Items.ItemTags;
import classes.PerkLib;

public class ElvenRangerArmor extends ArmorWithPerk
	{

		public function ElvenRangerArmor()
		{
			super("ERA", "ElvenRangerArmor", "Elven Ranger Armor", "a elven ranger armor", 0, 18, 10000, "An armor typically worn by wood elves on the rare occasion where they go to battle. This outfit is made of green spider silk specially treated for extra elasticity in order to offer good armor while preserving the user's own agility. Unsurprisingly for an elven armor it is highly revealing and barely tries to hide whatever assets the user may have thus it is as effective for combat as it is for teasing. Several enchantments fortifying archery and spearmanship have been bestowed upon this armor.", "Medium"
					, PerkLib.SluttySeduction,10,0,0,0,"Your incredibly revealing outfits allows you access to 'Seduce', an improved form of 'Tease'.",false,false);
			withTag(ItemTags.REVEALING,ItemTags.AGILE);
		}

		override public function afterEquip(slot:int, doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				while (game.player.hasPerk(PerkLib.ElvenRangerArmor)) game.player.removePerk(PerkLib.ElvenRangerArmor);
				game.player.createPerk(PerkLib.ElvenRangerArmor, 0, 0, 0, 0);
			}
			super.afterEquip(slot, doOutput)
		}

		override public function afterUnequip(slot:int, doOutput:Boolean):void {
			while (game.player.hasPerk(PerkLib.ElvenRangerArmor)) game.player.removePerk(PerkLib.ElvenRangerArmor);
			super.afterUnequip(slot, doOutput);
		}

	}
}
