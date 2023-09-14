/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class DemonFlail extends Weapon {
		
		public function DemonFlail() 
		{
			super("D.Flail", "D.Flail", "Demon flail", "a Demon flail", "smash", 25, 8000, "A leather-coated steel whip ending in a wide, heavy spiked ball of the same material. It reeks of corruption and its core seems to exude strong aphrodisiac that cover the blunt spikes of the ball, which look quite adapted to fit a whole range of orifices. Only the strongest warriors would be able to use such a large weapon, but it can deal tremendous damage as well as inspire lust.",
			"Large, Whirlwind, Stun10", WT_MACE_HAMMER);
			withBuffs({'teasedmg': 35});
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 75) boost += 5;
			if (game.player.str >= 50) boost += 5;
			if (game.player.str >= 25) boost += 5;
			boost += Math.round(game.player.cor / 20);
			return (5 + boost);
        }
	}
}
