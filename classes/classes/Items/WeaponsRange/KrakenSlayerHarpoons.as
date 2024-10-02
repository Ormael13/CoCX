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
			super("KSlHarp", "Kraken Slayer Harpoons", "kraken slayer harpoons", "a kraken slayer harpoons", "shot", 140, 7000, "A set of ornamented harpoons engraved with design of sea animals. This magical weapon replenish ammunition in its stack naturally allowing the hunter to fight unimpeded and smite the corrupt.", "Throwing");
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
			boost += Math.round((100 - game.player.cor) / scal);
			return (27 + boost);
		}
	}
}
