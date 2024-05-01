/**
 * ...
 * @author Liadri
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.GlobalFlags.kFLAGS;
	
	public class SagittariusBanefulGreatBow extends WeaponRange {
		
		public function SagittariusBanefulGreatBow() 
		{
			super("SagittB", "SagittariusBaneGBow", "Sagittarius Baneful Great Bow", "a Sagittarius Baneful Great Bow", "shot", 260, 13000,
					"Act as a wrath weapon spending wrath on shot as well as fatigue. Unlocks one archer's true potential. Cursed: This item is cursed by the last will of a corrupt centaur chieftain!",
					"Bow"
			);
		}
		
		override public function get attack():Number{
			var boost:int = 0;
			var scal:Number = 5;
			if (game.player.spe >= 100) {
				boost += 40;
				scal -= 1;
			}
			if (game.player.spe >= 50) {
				boost += 30;
				scal -= 1;
			}
			boost += Math.round((100 - game.player.cor) / scal);
			return (27 + boost);
		}
		
		override public function canUnequip(doOutput:Boolean):Boolean {
			if (doOutput) outputText("<b>You cannot remove this item because Lia says so!</b>");
			return false;
		}
		
	}

}
