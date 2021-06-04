/**
 * ...
 * @author Liadri
 */
package classes.Items.MiscJewelries 
{
import classes.BodyParts.Tail;
import classes.Items.MiscJewelry;
import classes.PerkLib;
import classes.StatusEffects;
import classes.Player;

	public class DemonicMageTailOrnament extends MiscJewelry
	{
		
		public function DemonicMageTailOrnament() 
		{
			super("DMAGETO", "Demonic mage tail ornament", "Demonic mage tail ornament", "a Demonic mage tail ornament", 0, 0, 9600, "This golden band covered with black magic incantation is big enough for an arm bracelet but was designed so it could serve as a ornament for a demon tail. Sexiness +4, +5 intelligence, raise black magic and Infernal flare power by 25%, Increase mana recovery by 2% per round, Slowly corrupt the user.","Ring");
		}

		override public function canUse():Boolean{
			if (game.player.tailType == Tail.DEMONIC){return true}
			outputText(" Just where do you even plan to put this thing on? You do not have a demon tail");
			if (game.player.tailType == Tail.NONE) outputText(" let alone a tail at all");
			outputText("and this ring is way to wide for your finger!");
			return false;
		}

		override public function playerEquip():MiscJewelry {
			game.player.statStore.addBuff('int',+5,'DemonicMageTailOrnament',{text:'Demonic mage tail ornament'});
			return super.playerEquip();
		}

		override public function playerRemove():MiscJewelry {
			game.player.statStore.removeBuffs('DemonicMageTailOrnament');
			return super.playerRemove();
		}
	}
}