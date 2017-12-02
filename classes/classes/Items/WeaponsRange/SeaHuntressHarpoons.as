/**
 * ...
 * @author Liadri
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.GlobalFlags.kFLAGS;
	
	public class SeaHuntressHarpoons extends WeaponRange
	{
		
		public function SeaHuntressHarpoons() {
			super("SHunHar", "SHuntHarp", "sea huntress harpoons", "a sea huntress harpoons", "shot", 25, 1250, "A set of ornamented harpoons engraved with design of sea animals. This magical weapon replenish ammunition in its stack naturally allowing the hunter to fight unimpeded.", "Throwing");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 5) boost += 10;
			return (15 + boost); 
		}
	}
}