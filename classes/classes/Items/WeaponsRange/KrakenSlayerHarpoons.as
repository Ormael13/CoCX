/**
 * ...
 * @author Liadri
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.GlobalFlags.kFLAGS;
	
	public class KrakenSlayerHarpoons extends WeaponRange
	{
		
		public function KrakenSlayerHarpoons() 
		{
			super("KSlHarp", "Kraken Slayer Harpoons", "kraken slayer harpoons", "a kraken slayer harpoons", "shot", 30, 1500, "A set of ornamented harpoons engraved with design of sea animals. This magical weapon replenish ammunition in its stack naturally allowing the hunter to fight unimpeded and smite the corrupt.", "Throwing");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 5) boost += 10;
			return (20 + boost); 
		}
	}
}