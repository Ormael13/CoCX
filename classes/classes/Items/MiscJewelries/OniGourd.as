/**
 * ...
 * @author Liadri
 */
package classes.Items.MiscJewelries 
{
import classes.Items.MiscJewelry;
import classes.Items.MiscJewelryLib;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;

	public class OniGourd extends MiscJewelry
	{
		
		public function OniGourd()
		{
			super("OniDJug", "OniDJug", "Oni enchanted drinking jug", "an Oni enchanted drinking jug", 0, 0, 1600, "This jug grants an infinite supply of non transformative alcohol and greatly increase attack power. Furthermore drunken power duration is doubled when drinking from the gourd.","Ring");
		}

		override public function playerEquip():MiscJewelry {
			while (game.player.hasPerk(PerkLib.OniDrinkingJug)) game.player.removePerk(PerkLib.OniDrinkingJug);
			game.player.createPerk(PerkLib.OniDrinkingJug,0,0,0,0);
			return super.playerEquip();
		}

		override public function playerRemove():MiscJewelry {
			while (game.player.hasPerk(PerkLib.OniDrinkingJug)) game.player.removePerk(PerkLib.OniDrinkingJug);
			return super.playerRemove();
		}
	}

}