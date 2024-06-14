/**
 * ...
 * @author Liadri
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
		import classes.GlobalFlags.kFLAGS;
	
	public class LeviathanHarpoons extends WeaponRange
	{
		
		public function LeviathanHarpoons() 
		{
			super("LevHarp", "LeviathanHarpoons", "leviathan harpoons", "a leviathan harpoons", "shot", 140, 7000, "A set of ornamented harpoons engraved with design of sea animals. This magical weapon replenish ammunition in its stack naturally allowing the hunter to fight unimpeded and decimate the pure.", "Throwing");
			withTag(I_LEGENDARY);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 5) boost += 20;
			var scal:Number = 5;
			if (game.player.spe >= 100) {
				boost += 30;
				scal -= 1;
			}
			if (game.player.spe >= 50) {
				boost += 30;
				scal -= 1;
			}
			boost += Math.round(game.player.cor / scal);
			return (27 + boost);
		}
	}
}
