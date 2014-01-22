/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Consumables
{
	import classes.Player;
	import classes.internals.Utils;

	public class OvipositionElixir extends SimpleConsumable
	{


		override public function canUse(player:Player, output:Boolean):Boolean
		{
			if (player.hasVagina()) return true;
			if (output) {
				clearOutput();
				outputText("You pop the cork and prepare to drink the stuff, but the smell nearly makes you gag.  You cork it hastily.\n\n");
			}
			return false;
		}

		private function ovipositionElixer(player:Player):void
		{
			game.mutations.ovipositionElixer(player);
		}

		public function OvipositionElixir()
		{
			super("OviElix","OviElix", "a hexagonal crystal bottle tagged with an image of an egg", ovipositionElixer,30, "This hexagonal crystal bottle is filled with a strange green fluid.  A tag with a picture of an egg is tied to the neck of the bottle, indicating it is somehow connected to egg-laying.");
		}
	}
}
