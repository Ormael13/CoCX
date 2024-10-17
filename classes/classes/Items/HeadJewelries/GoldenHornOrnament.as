/**
 * ...
 * @author Liadri
 */
package classes.Items.HeadJewelries
{
import classes.BodyParts.Horns;
import classes.Items.HeadJewelry;

	public class GoldenHornOrnament extends HeadJewelry
	{
		
		public function GoldenHornOrnament() 
		{
			super("GHOrnam", "GoldenHornOrnament", "Golden horn ornament", "a Golden horn ornament", 0, 0, 400, "This set of lovely gold ornaments is meant to be worn on demon horns. While mostly intended to be used as ordinary jewelry they act as a focus for black magic and increase the user's lasciviousness.",HJT_HAIRPIN,"","\nSpecial: +25% to tease / black magic damage while worn.");
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.horns.type == Horns.DEMON) return true;
			if (doOutput) {
				outputText(" Just where do you even plan to put this thing on? You do not have demon horns.");
				if (game.player.horns.type == Horns.NONE) outputText(", let alone horns at all");
				outputText("!");
			}
			return false;
		}
		
	}

}
