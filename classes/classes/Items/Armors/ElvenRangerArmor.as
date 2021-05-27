/**
 * @author Liadri
 */
package classes.Items.Armors
{
	import classes.CoC;
	import classes.Items.Armor;
import classes.PerkLib;
import classes.Player;
import classes.Items.ItemTags;

	public class ElvenRangerArmor extends ArmorWithPerk
	{

		public function ElvenRangerArmor()
		{
			super("ERA", "ElvenRangerArmor", "Elven Ranger Armor", "a elven ranger armor", 0, 18, 10000, "An armor typically worn by wood elves on the rare occasion where they go to battle. This outfit is made of green spider silk specially treated for extra elasticity in order to offer good armor while preserving the user's own agility. Unsurprisingly for an elven armor it is highly revealing and barely tries to hide whatever assets the user may have thus it is as effective for combat as it is for teasing. Several enchantments fortifying archery and spearmanship have been bestowed upon this armor.", "Medium"
					, PerkLib.SluttySeduction,10,0,0,0,"Your incredibly revealing outfits allows you access to 'Seduce', an improved form of 'Tease'.",false,false);
			withTag(ItemTags.REVEALING,ItemTags.AGILE);
		}

		override public function playerEquip():Armor {
			while (game.player.hasPerk(PerkLib.ElvenRangerArmor)) game.player.removePerk(PerkLib.ElvenRangerArmor);
			game.player.createPerk(PerkLib.ElvenRangerArmor,0,0,0,0);
			return super.playerEquip();
		}

		override public function playerRemove():Armor {
			while (game.player.hasPerk(PerkLib.ElvenRangerArmor)) game.player.removePerk(PerkLib.ElvenRangerArmor);
			return super.playerRemove();
		}

	}
}
