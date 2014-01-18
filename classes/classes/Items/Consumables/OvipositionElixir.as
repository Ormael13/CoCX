/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Consumables
{
	import classes.Player;
	import classes.Utils;

	public class OvipositionElixir extends SimpleConsumable
	{


		override public function canConsume(player:Player, output:Boolean):Boolean
		{
			if (player.hasVagina()) return true;
			if (output) {
				clearOutput();
				outputText("You pop the cork and prepare to drink the stuff, but the smell nearly makes you gag.  You cork it hastily.\n\n");
			}
			return false;
		}

		public function OvipositionElixir()
		{
			super("OviElix","OviElix", "a hexagonal crystal bottle tagged with an image of an egg", Utils.lazy2(getGame,"mutations","ovipositionElixer"),30, "This hexagonal crystal bottle is filled with a strange green fluid.  A tag with a picture of an egg is tied to the neck of the bottle, indicating it is somehow connected to egg-laying.");
		}
	}
}
