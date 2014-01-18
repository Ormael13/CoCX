/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Consumables
{
	import classes.Player;
	import classes.Utils;

	public class BimboLiqueur extends SimpleConsumable
	{

		override public function canConsume(player:Player, output:Boolean):Boolean
		{
			if(player.hasPerk("Futa Form") >= 0) {
				if (output) outputText("Ugh.  This stuff is so, like... last year.  Maybe you can find someone else to feed it to?\n\n");
				return false;
			}
			return true;
		}

		public function BimboLiqueur()
		{
			super("BimboLq", "BimboLq", "a potent bottle of 'Bimbo Liqueur'", Utils.lazy2(getGame,"mutations","bimboLiquer"), 1000,"This small bottle of liqueur is labelled 'Bimbo Liqueur'.  There's a HUGE warning label about the effects being strong and usually permanent, so you should handle this with care.");
		}
	}
}
