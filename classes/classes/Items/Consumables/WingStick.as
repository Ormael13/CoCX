/**
 * Created by aimozg on 11.01.14.
 */
package classes.Items.Consumables
{
	import classes.Player;
	import classes.internals.Utils;

	public final class WingStick extends SimpleConsumable
	{


		override public function canUse(player:Player, output:Boolean):Boolean
		{
			if(game.gameState != 1 && game.gameState != 2) {
				if (output){
					clearOutput();
					outputText("There's no one to throw it at!");
				}
				return false;
			}
			return true;
		}

		private function wingStick(player:Player):void{
			game.mutations.wingStick(player);
		}

		public function WingStick()
		{
			super("W.Stick","W.Stick","a wingstick",wingStick,16,"A tri-bladed throwing weapon.  Though good for only a single use, it's guaranteed to do high damage if it hits.  (Cost: 16) (DMG: 40-100)");
		}
	}
}
