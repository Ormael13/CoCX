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
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if(doOutput) outputText("You try and wield the legendary harpoons but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
	}
}