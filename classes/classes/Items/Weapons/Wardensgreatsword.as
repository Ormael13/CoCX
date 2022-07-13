/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class Wardensgreatsword extends Weapon
	{
		
		public function Wardensgreatsword()
		{
			super("WGSword", "WardenGSword", "Warden’s greatsword", "a Warden’s greatsword", "slash", 30, 2400, "Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.", "Large", WT_SWORD);
			withBuffs({
				'psoulskillpower': +0.4,
				'msoulskillpower': +0.4
			})
			withPerk(PerkLib.StrifeWarden);
		}

		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 100) boost += 10;
			if (game.player.str >= 50) boost += 10;
			return (10 + boost);
		}
	}
}
