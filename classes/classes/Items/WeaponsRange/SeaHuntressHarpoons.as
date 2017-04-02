/**
 * ...
 * @author Liadri
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	
	public class SeaHuntressHarpoons extends WeaponRange
	{
		
		public function SeaHuntressHarpoons() {
			super("SHunHar", "SHuntHarp", "sea huntress harpoons", "a sea huntress harpoons", "shot", 15, 750, "A set of ornamented harpoons engraved with design of sea animals. This magical weapon replenish ammunition in its stack naturally allowing the hunter to fight unimpeded.", "Throwing");
		}
		
	//	override public function get attack():Number {
	//		var boost:int = 0;
	//		if (game.player.str >= 70) boost += 10;
	//		return (15 + boost); 
	//	}
		
	}

}