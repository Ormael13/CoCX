/**
 * ...
 * @author Liadri
 */
package classes.Items.MiscJewelries
{
import classes.BodyParts.Tail;
import classes.Items.MiscJewelry;

	public class DemonicMageTailOrnament extends MiscJewelry
	{
		
		public function DemonicMageTailOrnament()
		{
			super("DMAGETO", "Demonic mage tail ornament", "Demonic mage tail ornament", "a Demonic mage tail ornament", 0, 0, 9600, 4, "This golden band, covered with black magic incantations, is large enough to be worn as an arm bracelet but is designed to serve as an ornament for a demon's tail. Sexiness +4, +5 intelligence, increases black magic and Infernal Flare power by 25%, Increase mana recovery by 2% per round. Slowly corrupts the user.","Ring");
			withBuffs({'int':5});
		}

		override public function canEquip(doOutput:Boolean, slot:int):Boolean{
			if (game.player.tailType == Tail.DEMONIC) return true;
			if (doOutput) {
				outputText(" Just where do you plan to put this thing? You don't have a demon tail.");
				if (game.player.tailType == Tail.NONE) outputText(", let alone a tail at all");
				outputText(", and this ring is far too wide for your finger!");
			}
			return false;
		}
	}
}
