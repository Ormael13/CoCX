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
			super("LevHarp", "LeviathanHarpoons", "leviathan harpoons", "a leviathan harpoons", "shot", 30, 1500, "A set of ornamented harpoons engraved with design of sea animals. This magical weapon replenish ammunition in its stack naturally allowing the hunter to fight unimpeded and smite the pure.", "Throwing");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 5) boost += 10;
			return (20 + boost); 
		}
	}
}