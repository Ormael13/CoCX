/**
 * Created by aimozg on 11.01.14.
 */
package classes.Items.Consumables
{
	import classes.Items.ConsumableLib;
	import classes.Player;
	import classes.internals.Utils;

	public final class LustStick extends SimpleConsumable
	{

		override public function canUse(player:Player, output:Boolean):Boolean
		{
			if (player.hasCock() && player.hasPerk("Luststick Adapted")<0){
				clearOutput();
				outputText("You look at the tube of lipstick, but get the idea it would be a pretty bad idea to smear a thick coating of cock-hardening aphrodisiacs over your own lips.  ");
				return false;
			}
			return true;
		}

		private function applyLustStick(player:Player):void{
			game.mutations.applyLustStick(player);
		}

		public function LustStick()
		{
			super("LustStk","LustStk","a tube of golden lipstick",applyLustStick,ConsumableLib.DEFAULT_VALUE,"This tube of golden lipstick is used by harpies to keep males aroused.  It has aphrodisiac properties on anyone with male genitalia and is most effective when applied to the lips or groin.");
		}
	}
}
