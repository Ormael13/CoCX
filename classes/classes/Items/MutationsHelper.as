package classes.Items 
{
	import classes.*;
	
	/**
	 * Helper class to get rid of the copy&paste-mess from classes.Items.Mutations
	 * @author Stadler76
	 */
	public class MutationsHelper extends BaseContent 
	{
		include "../../../includes/appearanceDefs.as";

		public function MutationsHelper() 
		{
		}

		public function restoreArms(changes:Number, changeLimit:Number, keepArms:Array = null):Number
		{
			var localChanges:Number = 0;
			if (keepArms == null) keepArms = [];
			if (keepArms.indexOf(player.armType) >= 0) return 0; // For future TFs. Tested and working, but I'm not using it so far (Stadler76)

			if (changes < changeLimit && player.armType != ARM_TYPE_HUMAN && rand(4) == 0) {
				switch (player.armType) {
					case ARM_TYPE_HARPY:
						outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that");
						outputText(" your feathery arms are shedding their feathery coating.  The wing-like shape your arms once had is gone in a matter of moments, leaving " + player.skinFurScales() + " behind.");
						break;

					case ARM_TYPE_SPIDER:
						outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that");
						outputText(" your arms' chitinous covering is flaking away.  The glossy black coating is soon gone, leaving " + player.skinFurScales() + " behind.");
						break;

					case ARM_TYPE_SALAMANDER:
						outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that");
						outputText(" your once scaly arms are shedding their scales and that your claws become normal human fingernails again.");
						player.clawType = CLAW_TYPE_NORMAL;
						break;

					case ARM_TYPE_PREDATOR:
						switch (player.skinType) {
							case SKIN_TYPE_GOO:
								outputText("\n\nYour gooey claws shift back to become more like fingernails again. Well, who cares, gooey claws aren't very useful in combat to begin with.");
								//Gooey claws? Really?!? I'll take a look at goo TF later ...
								break;

							case SKIN_TYPE_PLAIN:
							case SKIN_TYPE_FUR:
							case SKIN_TYPE_SCALES:
								outputText("\n\nYou feel a sudden tingle in your " + player.claws() + " and then you realize, that they have become normal human fingernails again.");
								break;
						}
						player.clawType = CLAW_TYPE_NORMAL;
						break;

					default:
						outputText(" your unusual arms change more and more until they are normal human arms, leaving " + player.skinFurScales() + " behind.");
				}
				player.armType = ARM_TYPE_HUMAN;
				localChanges++;
			}

			return localChanges;
		}

		public function removeFeatheryHair(changes:Number, changeLimit:Number):Number
		{
			var localChanges:Number = 0;

			if (changes < changeLimit && player.hairType == HAIR_FEATHER && rand(4) == 0) {
				//(long):
				if (player.hairLength >= 6) outputText("\n\nA lock of your downy-soft feather-hair droops over your eye.  Before you can blow the offending down away, you realize the feather is collapsing in on itself.  It continues to curl inward until all that remains is a normal strand of hair.  <b>Your hair is no longer feathery!</b>", false);
				//(short)
				else outputText("\n\nYou run your fingers through your downy-soft feather-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your feathers.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer feathery!</b>", false);
				localChanges++;
				player.hairType = HAIR_NORMAL;
			}

			return localChanges;
		}
	}
}
