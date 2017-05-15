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

		public function humanizeLowerBody():void {
			if (player.isTaur()) outputText("\n\nYour quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of human legs</b>!");
			else if (player.isGoo()) outputText("\n\nYour lower body rushes inward, molding into two leg-like shapes that gradually stiffen up.  In moments they solidify into normal-looking legs, complete with regular, human feet.  <b>You now have normal feet!</b>");
			else if (player.isNaga()) outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly where your new feet are forming.  <b>You have human legs again.</b>");
			else if (player.isScylla()) outputText("\n\nYou collapse as your tentacle legs starts to merge.  The pain is immense, particularly where your new feet are forming.  <b>You have human legs again.</b>");
			else /*if (player.isBiped()) */outputText("\n\nYou collapse as your legs shift and twist.  By the time the pain subsides, you notice that you have normal legs and normal feet.  <b>You now have normal feet!</b>");
			player.lowerBody = LOWER_BODY_TYPE_HUMAN;
			player.legCount = 2;
			changes++;
		}

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
			changes++;
		}

		public function growChitin(color:String,coverage:int=Skin.COVERAGE_HIGH):void {
			if (player.hasScales()) outputText("\n\nYour [skin coat.color] scales begin to itch insufferably.  You reflexively scratch yourself, setting off an avalanche of discarded scales.  The itching intensifies as you madly scratch and tear at yourself, revealing a coat of [skin coat.type].  At last the itching stops as <b>you brush a few more loose scales from your new chitin exoskeleton.</b>", false);
			else if (player.hasCoat()) if (player.hasFur()) outputText("Your skin suddenly feels itchy as your [skin coat.type] begins falling out in clumps, <b>revealing smooth chitin</b> underneath.", false);
			else outputText("\n\nAn itchy feeling springs up over every inch of your [skin.type].  As you scratch yourself madly, you feel your skin hardening until <b>you are wholy covered in chitin.</b>", false);
			player.skin.growCoat(SKIN_COAT_CHITIN,{color:color},coverage);
			changes++;
		}

		public function humanizeEars():void {
			outputText("\n\nOuch, your head aches! It feels like your ears are being yanked out of your head, and when you reach up to hold your aching noggin, you find they've vanished! Swooning and wobbling with little sense of balance, you nearly fall a half-dozen times before <b>a pair of normal, human ears sprout from the sides of your head.</b> You had almost forgotten what human ears felt like!");
			player.earType = EARS_HUMAN;
			changes++;
		}

		public function humanizeFace():void {
			outputText("\n\nSudden agony sweeps over your [face], your visage turning hideous as bones twist and your jawline shifts. The pain slowly vanishes, leaving you weeping into your fingers. When you pull your hands away you realize you've been left with a completely normal, human face.");
			player.faceType = FACE_HUMAN;
			changes++;
		}

		public function humanizeEyes():void {
			if (player.eyeType == EYES_BLACK_EYES_SAND_TRAP) {
				outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
			}
			else {
				outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
				if (player.eyeType == EYES_FOUR_SPIDER_EYES) outputText("  Your multiple, arachnid eyes are gone!</b>");
				outputText("  <b>You have normal, humanoid eyes again.</b>");
			}
			player.eyeType = EYES_HUMAN;
			changes++;
		}

		public function humanizeArms(degargoylize:Boolean=false):void {
			switch (player.armType) {
				case ARM_TYPE_HUMAN:
					return;
				case ARM_TYPE_WOLF:
				case ARM_TYPE_FOX:
				case ARM_TYPE_LION:
				case ARM_TYPE_YETI:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' [skin coat.color] fur is flaking away, leaving [skin base.type] behind.  Also the claws on your fingers reverts back into ordinary nails.");
					break;
				case ARM_TYPE_KITSUNE:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' claws retracting back into ordinary nails. You hand looks human again.");
					break;
				case ARM_TYPE_SHARK:
				case ARM_TYPE_ORCA:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' fin suddenly fell down, leaving [skin base.type] behind.  Also webbing between your fingers slowly disappearing.");
					break;
				case ARM_TYPE_PLANT:
				case ARM_TYPE_PLANT2:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' vines are withering.  Leaves also falling donw, leaving [skin base.type] behind.");
					break;
				case ARM_TYPE_SALAMANDER:
				case ARM_TYPE_LIZARD:
				case ARM_TYPE_DRAGON:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' scales are flaking away.  The leathery [skin coat.noadj] [skin coat.isare] soon gone, leaving [skin base.type] behind.");
					break;
				case ARM_TYPE_BEE:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' chitinous covering and fuzz is flaking away.  The glossy black and yellow coating is soon gone, leaving [skin base.type] behind.");
					break;
				case ARM_TYPE_MANTIS:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' chitinous covering is flaking away and scythe shrinking until it vanish completly.  The glossy green coating is soon gone, leaving [skin base.type] behind.");
					break;
				case ARM_TYPE_SPIDER:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' chitinous covering is flaking away.  The glossy black coating is soon gone, leaving [skin base.type] behind.");
					break;
				case ARM_TYPE_HARPY:
				case ARM_TYPE_PHOENIX:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your feathery arms are shedding their feathery coating.  The wing-like shape your arms once had is gone in a matter of moments, leaving " + player.skinDesc + " behind.");
					break;
				case ARM_TYPE_GARGOYLE:
					if (!degargoylize) return;
					outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ");
					break;
				default:
					outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ");
					break;
			}
			player.armType = ARM_TYPE_HUMAN;
			changes++;
		}

		public function removeWings(degargoylize:Boolean=false):void {
			if (player.wingType == WING_TYPE_GARGOYLE_LIKE_LARGE && !degargoylize) return;
			if (player.wingType == WING_TYPE_NONE) return;
			switch(rand(2)) {
				case 0:
					outputText("\n\nSensation fades from your " + player.wingDesc + " wings slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.");
					break;
				case 1:
					outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your shoulder-blades.  After a moment the pain passes, though your wings are gone!");
					break;
			}
			player.wingType = WING_TYPE_NONE;
			player.wingDesc = "non-existant";
			changes++;
		}

		public function updateGills(newGillType:int = GILLS_NONE):int
		{
			trace("Called updateGills(" + newGillType + ")");
			var oldgillType:int = player.gillType;
			if (oldgillType == newGillType) return 0; // no change

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