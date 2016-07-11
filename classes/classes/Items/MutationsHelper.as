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

		// I tend to use bitfields rather than lots of optional boolean params.
		// If I consider a method to be finalized and has only one option I'll refactor this to use a boolean value.
		// I'll add more consts later if needed. This one is just here for the sake of being an example for starters (Stadler)

		// restoreArms options
		public static const RESTOREARMS_FROMGOOSKINTF:int = 1;

		public function MutationsHelper() 
		{
		}

		public function restoreArms(changes:Number, changeLimit:Number, keepArms:Array = null, options:int = 0):Number
		{
			var localChanges:Number = 0;
			if (keepArms == null) keepArms = [];
			if (keepArms.indexOf(player.armType) >= 0) return 0; // For future TFs. Tested and working, but I'm not using it so far (Stadler)

			if (options & RESTOREARMS_FROMGOOSKINTF >= 0) {
				// skin just turned gooey. Now lets fix unusual arms.
				var hasClaws:Boolean = player.clawType != CLAW_TYPE_NORMAL;

				if (hasClaws || player.armType == ARM_TYPE_HARPY) outputText("\n\n");
				if (player.armType == ARM_TYPE_HARPY) {
					outputText("The feathers on your arms melt back into your now gooey skin.");
					if (hasClaws) outputText(" Additionally your ");
				} else if (hasClaws) outputText("Your ");

				if (hasClaws) outputText("now gooey claws melt back into your fingers. Well, who cares, gooey claws aren't very useful in combat to begin with.");
				if (hasClaws || player.armType == ARM_TYPE_HARPY) outputText("  <b>You have normal human arms again.</b>");

				player.clawType = CLAW_TYPE_NORMAL;
				player.armType = ARM_TYPE_HUMAN;
				return 0;
			}


			if (changes < changeLimit && player.armType != ARM_TYPE_HUMAN && rand(4) == 0) {
				if ([ARM_TYPE_HARPY, ARM_TYPE_SPIDER, ARM_TYPE_SALAMANDER].indexOf(player.armType) >= 0)
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that");

				switch (player.armType) {
					case ARM_TYPE_HARPY:
						outputText(" your feathery arms are shedding their feathery coating.  The wing-like shape your arms once had is gone in a matter of moments, leaving " + player.skinFurScales() + " behind.");
						break;

					case ARM_TYPE_SPIDER:
						outputText(" your arms' chitinous covering is flaking away.  The glossy black coating is soon gone, leaving " + player.skinFurScales() + " behind.");
						break;

					case ARM_TYPE_SALAMANDER:
						outputText(" your once scaly arms are shedding their scales and that your claws become normal human fingernails again.");
						break;

					case ARM_TYPE_PREDATOR:
						switch (player.skinType) {
							case SKIN_TYPE_GOO:
								if (player.clawType != CLAW_TYPE_NORMAL)
									outputText("\n\nYour gooey claws melt into your fingers. Well, who cares, gooey claws aren't very useful in combat to begin with.");
									//Gooey claws? Really?!? I'll take a look at goo TF later ...
								break;

							case SKIN_TYPE_PLAIN:
							case SKIN_TYPE_FUR:
							case SKIN_TYPE_SCALES:
								outputText("\n\nYou feel a sudden tingle in your " + player.claws() + " and then you realize, that they have become normal human fingernails again.");
								break;
						}
						break;

					default:
						outputText(" your unusual arms change more and more until they are normal human arms, leaving " + player.skinFurScales() + " behind.");
				}
				outputText("  <b>You have normal human arms again.</b>");
				player.clawType = CLAW_TYPE_NORMAL;
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

		public function newLizardSkinTone():String
		{
			if (rand(10) == 0) {
				//rare skinTone
				return rand(2) == 0 ? "purple" : "silver";
			}

			//non rare skinTone
			switch (rand(5)) {
				case 0: return "red";
				case 1: return "green";
				case 2: return "white";
				case 3: return "blue";
				case 4: return "black";
			}

			return "invalid"; // Will never happen. Suppresses 'Error: Function does not return a value.'
		}
	}
}
