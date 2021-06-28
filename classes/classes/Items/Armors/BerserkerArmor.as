/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors 
{
import classes.Items.Armor;
import classes.Items.ItemTags;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;
	
	public class BerserkerArmor extends Armor
	{

		public function BerserkerArmor()
		{
			super("B.Armor","B.Armor","berserker armor","a berserker armor",12,0,30720,"A sturdy albeith skimpy armor made of leather and metal plates tied up to the body with straps. While it offers limited protections it also does not hinder the movement of its owner allowing for greater agility then most armors.","Medium");
			withTag(ItemTags.AGILE);
		}

		override public function playerEquip():Armor {
			while (game.player.hasPerk(PerkLib.BerserkerArmor)) game.player.removePerk(PerkLib.BerserkerArmor);
			game.player.createPerk(PerkLib.BerserkerArmor,0,0,0,0);
			while (game.player.hasPerk(PerkLib.SluttySeduction)) game.player.removePerk(PerkLib.SluttySeduction);
			game.player.createPerk(PerkLib.SluttySeduction,8,0,0,0);
			return super.playerEquip();
		}

		override public function playerRemove():Armor {
			while (game.player.hasPerk(PerkLib.BerserkerArmor)) game.player.removePerk(PerkLib.BerserkerArmor);
			while (game.player.hasPerk(PerkLib.SluttySeduction)) game.player.removePerk(PerkLib.SluttySeduction);
			return super.playerRemove();
		}

	}
}