package classes.Items 
{
	import classes.*;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
	
	/**
	 * Helper class to get rid of the copy&paste-mess in classes.Items.Mutations
	 * @since July 8, 2016
	 * @author Stadler76
	 */
	public class MutationsHelper extends BaseContent
	{
		include "../../../includes/appearanceDefs.as";

		public var changes:int = 0;
		public var changeLimit:int = 1;

		public function MutationsHelper() { }

		public function humanizeSkin():void {
			switch (player.coatType()) {
				case SKIN_COAT_FUR:
					outputText("\n\nYour fur itches incessantly, so you start scratching it.  It starts coming off in big clumps before the whole mess begins sloughing off your body.  In seconds, your skin is nude.  <b>You've lost your fur!</b>");
					break;
				case SKIN_COAT_SCALES:
					outputText("\n\nYour scales itch incessantly, so you scratch at them.  They start falling off wholesale, leaving you standing in a pile of scales after only a few moments.  <b>You've lost your scales!</b>");
					break;
				default:
					outputText("\n\nYour [skin noadj] itches incessantly, and as you scratch it shifts and changes, becoming normal human-like skin.  <b>Your skin is once again normal!</b>");
			}
			player.skin.setBaseOnly({type:SKIN_BASE_PLAIN});
		}

		public function updateGills(newGillType:int = GILLS_NONE):int
		{
			trace("Called updateGills(" + newGillType + ")");
			var oldgillType:int = player.gillType;
			if (player.gillType == newGillType) return 0; // no change

			player.gillType = newGillType;
			changes++;

			// for now, we only have anemone gills on the chest
			switch (newGillType) {
				case GILLS_NONE:
					if (oldgillType == GILLS_ANEMONE) {
						outputText("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your"
						           +" skin.");
					} else { // losing fish gills
						outputText("\n\nYou feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your"
						           +" gills shrink into nothingness, leaving only smooth skin behind. Seems you won't be able to stay in the water"
						           +" quite so long anymore.");
					}
					outputText("  <b>You no longer have gills!</b>");
					return -1; // Gills lost

				case GILLS_ANEMONE:
					if (oldgillType == GILLS_FISH) {
						outputText("\n\nYou feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your"
						           +" gills shrink into nothingness, leaving only smooth skin behind. When you think it's over you feel something"
						           +" emerge from under your neck, flowing down over your chest and brushing your nipples. You look in surprise as"
						           +" your new feathery gills finish growing out, a film of mucus forming over them shoftly after.");
					} else { // if no gills
						outputText("\n\nYou feel a pressure in your lower esophageal region and pull your garments down to check the area."
						           +" Before your eyes a pair of feathery gills start to push out of the center of your chest,"
						           +" just below your neckline, parting sideways and draping over your " + player.nippleDescript(0) + "s."
						           +" They feel a bit uncomfortable in the open air at first, but soon a thin film of mucus covers them and you"
						           +" hardly notice anything at all. You redress carefully.");
					}
					outputText("\n\n<b>You now have feathery gills!</b>");
					return 1; // Gained gills or gillType changed

				case GILLS_FISH:
					if (oldgillType == GILLS_ANEMONE) {
						outputText("\n\nYou feel your gills tingle, a vague numbness registering across thier feathery exterior. You watch in awe as"
						           +" your gill's feathery folds dry out and fall off like crisp autumn leaves. The slits of your gills then"
						           +" rearrange themselves, becoming thinner and shorter, as they shift to the sides of your neck. They now close in"
						           +" a way that makes them almost invisible. As you run a finger over your neck you feel little more than several"
						           +" small raised lines where they meet your skin.");
					} else { // if no gills
						outputText("\n\nYou feel a sudden tingle on your neck. You reach up to it to feel, whats the source of it. When you touch"
						           +" your neck, you feel that it begins to grow serveral narrow slits which slowly grow longer. After the changes"
						           +" have stopped you quickly head to a nearby puddle to take a closer look at your neck. You realize,"
						           +" that your neck has grown gills allowing you to breathe under water as if you were standing on land.");
					}
					outputText("\n\n<b>You now have fish like gills!</b>");
					return 1; // Gained gills or gillType changed

				default:
					player.gillType = oldgillType;
					changes--;
					trace("ERROR: Unimplemented new gillType (" + newGillType + ") used");
					return 0; // failsafe, should hopefully never happen
			}
		}

		
	}

}