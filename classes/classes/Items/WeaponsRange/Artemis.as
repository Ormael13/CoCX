package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.Player;
	
	/**
	 * ...
	 * @author Oxdeception
	 */
	public class Artemis extends WeaponRange
	{
		
		public function Artemis() 
		{
			super("Artemis", "Artemis", "Artemis longbow", "an Artemis longbow", "shot", 130, 6500,
					"The white sandalwood of this blessed bow seems to draw light in. The radiant arrows fired with this holy weapon strike true as if guided by divine hands.",
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
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if(doOutput) outputText("You try and wield the legendary bow but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
		
	}

}