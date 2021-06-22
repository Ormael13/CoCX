/**
 * ...
 * @author Ormael
 */
package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
import classes.Items.JewelryLib;
import classes.PerkLib;
import classes.Player;
	import classes.StatusEffects;

	public class OniGourd extends Jewelry
	{
		
		public function OniGourd()
		{
			super("OniDJug", "OniDJug", "Oni enchanted drinking jug", "an Oni enchanted drinking jug", JewelryLib.MODIFIER_R_ATTACK_POWER, 30, 10000, "This jug grants an infinite supply of non transformative alcohol and greatly increase attack power. Furthermore drunken power duration is doubled when drinking from the gourd.","Ring");
		}

		override public function playerEquip():Jewelry {
			while (game.player.hasPerk(PerkLib.OniDrinkingJug)) game.player.removePerk(PerkLib.OniDrinkingJug);
			game.player.createPerk(PerkLib.OniDrinkingJug,0,0,0,0);
			return super.playerEquip();
		}

		override public function playerRemove():Jewelry {
			while (game.player.hasPerk(PerkLib.OniDrinkingJug)) game.player.removePerk(PerkLib.OniDrinkingJug);
			return super.playerRemove();
		}
	}

}