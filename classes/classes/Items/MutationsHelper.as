package classes.Items 
{
	import classes.*;
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

		public function MutationsHelper() {}

		public function restoreArms(tfSource:String):int
		{
			trace('called restoreArms("' + tfSource + '")');
			var message:String = "";

			if (tfSource == "gooGasmic") {
				// skin just turned gooey. Now lets fix unusual arms.
				var hasClaws:Boolean = player.clawType != CLAW_TYPE_NORMAL;

				message = "\n\n";
				if (player.armType == ARM_TYPE_HARPY) {
					message += "The feathers on your arms melt back into your now gooey skin.";
					if (hasClaws) message += " Additionally your now gooey claws melt back into your fingers.";
				} else if (hasClaws) {
					message += "Your now gooey claws melt back into your fingers.";
				}

				if (hasClaws) message += " Well, who cares, gooey claws aren't very useful in combat to begin with.";
				if (hasClaws || player.armType == ARM_TYPE_HARPY) output.text(message + "  <b>You have normal human arms again.</b>");

				updateClaws();
				player.armType = ARM_TYPE_HUMAN;
				return 1;
			}


			if (changes < changeLimit && player.armType != ARM_TYPE_HUMAN) {
				if ([ARM_TYPE_HARPY, ARM_TYPE_SPIDER, ARM_TYPE_SALAMANDER].indexOf(player.armType) >= 0)
					message += "\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.";

				switch (player.armType) {
					case ARM_TYPE_HARPY:
						message += "  Glancing down in irritation, you discover that your feathery arms are shedding their feathery coating."
						          +"  The wing-like shape your arms once had is gone in a matter of moments, leaving [skinfurscales] behind.";
						break;

					case ARM_TYPE_SPIDER:
						message += "  Glancing down in irritation, you discover that your arms' chitinous covering is flaking away."
						          +"  The glossy black coating is soon gone, leaving [skinfurscales] behind.";
						break;

					case ARM_TYPE_SALAMANDER:
						message += "  Glancing down in irritation, you discover that your once scaly arms are shedding their scales and that"
						          +" your claws become normal human fingernails again.";
						break;

					case ARM_TYPE_PREDATOR:
						switch (player.skinType) {
							case SKIN_TYPE_GOO:
								if (player.clawType != CLAW_TYPE_NORMAL)
									message += "\n\nYour gooey claws melt into your fingers."
									          +" Well, who cares, gooey claws aren't very useful in combat to begin with.";
								break;

							case SKIN_TYPE_PLAIN:
							case SKIN_TYPE_FUR:
							case SKIN_TYPE_LIZARD_SCALES:
								message += "\n\nYou feel a sudden tingle in your [claws] and then you realize,"
								          +" that they have become normal human fingernails again.";
								break;
						}
						break;

					default:
						message += "\n\nYour unusual arms change more and more until they are normal human arms, leaving [skinfurscales] behind.";
				}
				output.text(message + "  <b>You have normal human arms again.</b>");
				updateClaws();
				player.armType = ARM_TYPE_HUMAN;
				changes++;
				return 1;
			}

			return 0;
		}

		public function restoreLegs(tfSource:String):Boolean
		{
			trace('called restoreLegs("' + tfSource + '")');
			var doRestore:Boolean = false;
			var tsParts:Array = tfSource.split("-");
			tfSource = tsParts[0];

			//(Centaurs -> Normal Human Legs)
			if (player.isTaur()) {
				outputText("\n\nYour quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of human legs</b>!");
				doRestore = true;
			}

			//(Goo -> Normal Human Legs)
			if (player.isGoo()) {
				outputText("\n\nYour lower body rushes inward, molding into two leg-like shapes that gradually stiffen up.  In moments they solidify into normal-looking legs, complete with regular, human feet.  <b>You now have normal feet!</b>");
				doRestore = true;
			}

			//(Naga -> Normal Human Legs)
			if (player.isNaga()) {
				outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly where your new feet are forming.  <b>You have human legs again.</b>");
				doRestore = true;
			}

			//(Drider -> Normal Human Legs)
			if (tfSource != "sweetGossamer" && player.isDrider()) {
				outputText("\n\nYour legs buckle under you and you fall, smashing your abdomen on the ground."
				          +"  Though your control deserts and you cannot see behind you,"
				          +" still you feel the disgusting sensation of chitin loosening and sloughing off your body,"
				          +" and the dry breeze on your exposed nerves."
				          +"  Reflexively, your legs cling together to protect as much of their now-sensitive surface as possible."
				          +"  When you try to part them, you find you cannot."
				          +"  Several minutes pass uncomforably until you can again bend your legs,"
				          +" and when you do, you find that all the legs of a side bend together.");
				outputText("  <b>You have human legs again.</b>");
				doRestore = true;
			}

			//(Non-human -> Normal Human Legs)
			if (tfSource == "regularHummus" && player.isBiped() && player.lowerBody != LOWER_BODY_TYPE_HUMAN) {
				outputText("\n\nYou collapse as your legs shift and twist.  By the time the pain subsides, you notice that you have normal legs and normal feet.  <b>You now have normal feet!</b>");
				doRestore = true;
			}

			if (doRestore) {
				player.lowerBody = LOWER_BODY_TYPE_HUMAN;
				player.legCount = 2;
				changes++;
				return true;
			}

			return false;
		}

		public function removeFeatheryHair():Boolean
		{
			if (changes < changeLimit && player.hairType == HAIR_FEATHER && rand(4) == 0) {
				//(long):
				if (player.hairLength >= 6) outputText("\n\nA lock of your downy-soft feather-hair droops over your eye.  Before you can blow the offending down away, you realize the feather is collapsing in on itself.  It continues to curl inward until all that remains is a normal strand of hair.  <b>Your hair is no longer feathery!</b>", false);
				//(short)
				else outputText("\n\nYou run your fingers through your downy-soft feather-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your feathers.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer feathery!</b>", false);
				player.hairType = HAIR_NORMAL;
				changes++;
				return true;
			}

			return false;
		}

		public function removeBassyHair():Boolean
		{
			// Failsafe, duh
			if ([HAIR_BASILISK_PLUME, HAIR_BASILISK_SPINES].indexOf(player.hairType) == -1) return false;

			if (player.hairType == HAIR_BASILISK_PLUME) {
				// TF blurb derived from losing feathery hair
				//(long):
				if (player.hairLength >= 5)
					outputText("\n\nA lock of your feathery plume droops over your eye.  Before you can blow the offending down away,"
					          +" you realize the feather is collapsing in on itself."
					          +" It continues to curl inward until all that remains is a normal strand of hair.");
				//(short)
				else
					outputText("\n\nYou run your fingers through your feathery plume while you await the effects of the item you just ingested."
					          +" While your hand is up there, it detects a change in the texture of your feathers.  They're completely disappearing,"
					          +" merging down into strands of regular hair.");

					outputText("\n\n<b>Your hair is no longer feathery!</b>");
			} else {
				outputText("\n\nYou feel a tingling on your scalp. You reach up to your basilisk spines to find out what is happening. The moment"
					          +" your hand touches a spine, it comes loose and falls in front of you. One after another the other spines fall out,"
					          +" until all the spines that once decorated your head now lay around you, leaving you with a bald head.");

				outputText("\n\n<b>You realize, that you'll grow normal human hair again!</b>");
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				player.hairLength = 0;
			}
			player.hairType = HAIR_NORMAL;
			changes++;
			return true;
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

		public function updateClaws(clawType:int = CLAW_TYPE_NORMAL):String
		{
			var clawTone:String = "";
			var oldClawTone:String = player.clawTone;

			switch (clawType) {
				case CLAW_TYPE_DRAGON:       clawTone = "steel-gray";   break;
				case CLAW_TYPE_SALAMANDER:   clawTone = "fiery-red";    break;
				case CLAW_TYPE_LIZARD:
					// See http://www.bergenbattingcenter.com/lizard-skins-bat-grip/ for all those NYI! lizard skin colors
					// I'm still not that happy with these claw tones. Any suggestion would be nice.
					switch (player.skinTone) {
						case "red":          clawTone = "reddish";      break;
						case "green":        clawTone = "greenish";     break;
						case "white":        clawTone = "light-gray";   break;
						case "blue":         clawTone = "bluish";       break;
						case "black":        clawTone = "dark-gray";    break;
						case "purple":       clawTone = "purplish";     break;
						case "silver":       clawTone = "silvery";      break;
						case "pink":         clawTone = "pink";         break; // NYI! Maybe only with a new Skin Oil?
						case "orange":       clawTone = "orangey";      break; // NYI!
						case "yellow":       clawTone = "yellowish";    break; // NYI!
						case "desert-camo":  clawTone = "pale-yellow";  break; // NYI!
						case "gray-camo":    clawTone = "gray";         break; // NYI!
						default:             clawTone = "gray";         break;
					}
					break;
				default:
					clawTone = "";
			}

			player.clawType = clawType;
			player.clawTone = clawTone;

			return oldClawTone;
		}

		public function lizardHairChange(tfSource:String):int
		{
			var hairPinID:int = player.hasKeyItem("Feathery hair-pin");
			trace('called lizardHairChange("' + tfSource + '")');

			switch (tfSource) {
				case "reptilum-lizan":
				case "reptilum-dragonewt":
					//-Hair stops growing!
					if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) {
						output.text("\n\nYour scalp tingles oddly.  In a panic, you reach up to your [hair], but thankfully it appears unchanged.");
						output.text("\n\n(<b>Your hair has stopped growing.</b>)");
						changes++;
						flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 1;
						return -1; // --> hair growth stopped
					}
					return 0;

				case "PlayerEvents-benoitHairPin":
				case "reptilum-basilisk":
				case "reptilum-dracolisk":
					if (player.hairType == HAIR_BASILISK_PLUME && player.cor < 65) return 0;

					if (player.isFemaleOrHerm() && player.cor < 15 && player.featheryHairPinEquipped() && player.isBasilisk()) {
						var benoitMFText:String = getGame().bazaar.benoit.benoitMF(
							" your hair has changed into a plume of feathers that, like legend is told, belongs to a female basilisk!",
							" you have a plume, like a female basilisk!"
						);

						if (player.hairType == HAIR_GOO)
							output.text("\n\nYour gooey hair begins to fall out in globs, eventually leaving you with a bald head.");

						output.text("\n\nYour head begins to tickle and you reach up to scratch at it, only to be surprised by the softness you feel."
						           +" It reminds you of the down of baby chickens, velvety soft and slightly fluffy. You look at yourself in a nearby"
						           +" puddle and gasp, [if (hairlength <= 0) where your hair once was] you now have red feathers,"
						           +" some longer and larger than others. This floppy but soft plume sits daintily on your head,"
						           +" reminding you of a ladies fascinator. You realise soon that" + benoitMFText);

						if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] != 0)
							output.text("\n\n<b>Your hair is growing again and is now a plume of short red feathers.</b>");
						else
							output.text("\n\n<b>Your hair is now a plume of short red feathers.</b>");

						flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
						player.hairLength = 2;
						player.hairColor = "red";
						player.hairType = HAIR_BASILISK_PLUME;
						player.keyItems[hairPinID].value2 = 0;
						changes++;
						return 1; // --> gained basilisk hair (plume)
					}

					if (player.cor >= 65 && player.hairType != HAIR_BASILISK_SPINES && player.hasLizardScales() && player.hasReptileFace()) {
						// Corrupted Basilisk
						if (player.hairLength > 0 && [HAIR_GOO, HAIR_BASILISK_PLUME].indexOf(player.hairType) == -1) {
							output.text("\n\nYour scalp feels tight and hot, causing you to run a hand through your [hair] to rub at it gingerly.");

							if (player.featheryHairPinEquipped())
								output.text("\n\nThe pin in your hair heats up to the point where you have to pull it free and toss it to the ground,"
								           +" it sizzling against the earth.");

							output.text("\n\nTo your shock a handful of your [hair] comes loose, exposing the [skinFurScales] beneath. You wonder why"
							           +" this is happening to you but realise it must be the potion, lizards don't tend to have hair after all."
							           +" You continue to rub at your scalp, the cool air against your slowly revealed skin a welcome relief."
							           +" After several minutes of this, you're certain you've shed all your hair. When you think it's all over,"
							           +" you feel an uncomfortable pressure build, your scalp morphing and changing as you grimace."
							           +" When the sensation finally fades you rush to look at yourself in a puddle. Where you once had hair,"
							           +" you now have a crown of dull reptilian spines!");

						}

						// Female Basilisk to Corrupted Basilisk
						if (player.hairLength > 0 && player.hairType == HAIR_BASILISK_PLUME) {
							output.text("\n\nA sudden sharp pain drills through your skull, a pressure forming across your scalp."
							           +" If you didn't know any better you'd think you were being plucked!");

							if (player.featheryHairPinEquipped())
								output.text("\n\nThe pin in your hair heats up to the point where you have to pull it free and toss it to the ground,"
								           +" it sizzling against the earth.");

							output.text("\n\nYou clutch your head as you feel the feathers on your head push out further, thickening up as they do so."
							           +" The soft vane seems to fall from the spine of the feathers, stripping them bare as the red fluff falls to"
							           +" the floor. Soon the tips of the feathers follow, leaving some rather alien looking spines behind. Your head"
							           +" throbs with dull pain as the transformation seems to end and you go to look at your reflection in a nearby"
							           +" puddle. Your once magnificent plume has turned into a dull crown of spines, like that of the corrupt"
							           +" basilisk of the mountains. As you mourn the loss of your feathered hair, you notice your spines move with"
							           +" your emotions, their sensitive tips picking up on the breeze as they lower closer to your skull.");
						}

						// Corrupted basilisk with gooey or no hair (bald)
						if (player.hairType == HAIR_GOO || player.hairLength <= 0) {
							if (player.hairType == HAIR_GOO)
								output.text("\n\nYour gooey hair begins to fall out in globs, eventually leaving you with a bald head.");

							if (player.featheryHairPinEquipped())
								output.text("\n\nThe pin in your hair heats up to the point where you have to pull it free and toss it to the ground,"
								           +" it sizzling against the earth.");

							output.text("\n\nYour scalp feels tight, as though the skin is shifting and morphing."
							           +" You let out groan as you grip your head, praying for the pain to subside quickly. Pressure builds,"
							           +" your head feeling ready to split. As the sensation fades you're left wondering what just happened and you"
							           +" run to look at yourself in a nearby puddle.");
						}

						// Finalize Corrupted Basilisk TFs
						player.hairColor = player.skinTone;                   // hairColor always set to player.skinTone
						player.hairType = HAIR_BASILISK_SPINES;               // hairType set to basilisk spines
						player.hairLength = 2;                                // hairLength set to 2 (inches, displayed as ‘short’)
						flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 1; // Hair growth stops
						changes++;
						output.text("\n\n<b>Where your hair would be, you now have a crown of dull reptilian spines!</b>");

						if (player.featheryHairPinEquipped())
							output.text("\n\nYou place the hair-pin in your inventory, no longer able to wear it.");
						else if (hairPinID >= 0)
							output.text("\n\nYour thoughts wander to the hair-pin while you adjust to your new [hair]. You probably won't be able to"
							           +" wear it while you're this tainted.");

						if (hairPinID >= 0) {                                 // hair-pin set to unequipped
							player.keyItems[hairPinID].value1 = 0;
							player.keyItems[hairPinID].value2 = 0;
						}
						if (tfSource == "PlayerEvents-benoitHairPin") output.text("\n");
						return 1;
					}
					return 0;

				default:
					return 0;
			}
		}

		/**
		 * Updates the perk Oviposition depending on the class/method stored in tfSource, that called it.
		 * @param	tfSource	The method- or classname plus additional info seperated by the '-'-character
		 * @return	-1: lost the perk, 0: no change, 1: gained the perk
		 * @author	Stadler76
		 */
		public function updateOvipositionPerk(tfSource:String):int
		{
			trace('called updateOvipositionPerk("' + tfSource + '")');
			var tsParts:Array = tfSource.split("-");
			if (tsParts.length > 1 && ["goldenSeed", "catTransformation"].indexOf(tsParts[0]) == -1)
				tfSource = tsParts[0];

			// First things first :)
			if (player.findPerk(PerkLib.BasiliskWomb) >= 0) {
				if (player.findPerk(PerkLib.Oviposition) >= 0)
					return 0; // we already have it => no change

				// Basilisk Womb but no Oviposition? Fix, whats broken
				outputText("\n\nDeep inside yourself there is a change.  It makes you feel a little woozy, but passes quickly."
				          +"  Beyond that, you aren't sure exactly what just happened, but you are sure it originated from your basilisk womb.\n");
				outputText("(<b>Perk Gained: Oviposition</b>)");

				player.createPerk(PerkLib.Oviposition, 0, 0, 0, 0);
				return 1; // true => gained Oviposition Perk
			}

			if (changes >= changeLimit) return 0;

			// Note, that we don't do the score checks anymore. That was just an ugly workaround and we don't want to do that again!
			switch(tfSource) {
				case "EmberTFs":
				case "snakeOil":
				case "goldenSeed-HarpyWomb":
				//case "catTransformation-dragonne": // Keep it? Maybe later.
				// TFs with minor changes. Just in case, we change our mind or if we intend to upgrade them.
				case "winterPudding":
				case "rizzaRootEffect":
					return 0; // Don't change it. So we're done, yay!

				case "reptilum":
				case "echidnaTFs":
					if (player.findPerk(PerkLib.Oviposition) >= 0) return 0;
					outputText("\n\nDeep inside yourself there is a change.  It makes you feel a little woozy, but passes quickly."
					          +"  Beyond that, you aren't sure exactly what just happened, but you are sure it originated from your womb.\n");
					outputText("(<b>Perk Gained: Oviposition</b>)");

					player.createPerk(PerkLib.Oviposition, 0, 0, 0, 0);
					changes++;
					return 1; // Gained it
					break;

				default:
					if (player.findPerk(PerkLib.Oviposition) < 0) return 0;
					if (player.lizardScore() >= 8) return 0; // Still high, so don't remove Oviposition yet!
					if (tfSource != "superHummus") {
						outputText("\n\nAnother change in your uterus ripples through your reproductive systems."
						          +"  Somehow you know you've lost a little bit of reptilian reproductive ability.\n");
						outputText("(<b>Perk Lost: Oviposition</b>)\n");
					}
					player.removePerk(PerkLib.Oviposition);
					return -1; // Lost it
			}
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
						output.text("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your"
						           +" skin.");
					} else { // losing fish gills
						output.text("\n\nYou feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your"
						           +" gills shrink into nothingness, leaving only smooth skin behind. Seems you won't be able to stay in the water"
						           +" quite so long anymore.");
					}
					output.text("  <b>You no longer have gills!</b>");
					return -1; // Gills lost

				case GILLS_ANEMONE:
					if (oldgillType == GILLS_FISH) {
						output.text("\n\nYou feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your"
						           +" gills shrink into nothingness, leaving only smooth skin behind. When you think it's over you feel something"
						           +" emerge from under your neck, flowing down over your chest and brushing your nipples. You look in surprise as"
						           +" your new feathery gills finish growing out, a film of mucus forming over them shoftly after.");
					} else { // if no gills
						output.text("\n\nYou feel a pressure in your lower esophageal region and pull your garments down to check the area."
						           +" Before your eyes a pair of feathery gills start to push out of the center of your chest,"
						           +" just below your neckline, parting sideways and draping over your " + player.nippleDescript(0) + "s."
						           +" They feel a bit uncomfortable in the open air at first, but soon a thin film of mucus covers them and you"
						           +" hardly notice anything at all. You redress carefully.");
					}
					output.text("\n\n<b>You now have feathery gills!</b>");
					return 1; // Gained gills or gillType changed

				case GILLS_FISH:
					if (oldgillType == GILLS_ANEMONE) {
						output.text("\n\nYou feel your gills tingle, a vague numbness registering across thier feathery exterior. You watch in awe as"
						           +" your gill's feathery folds dry out and fall off like crisp autumn leaves. The slits of your gills then"
						           +" rearrange themselves, becoming thinner and shorter, as they shift to the sides of your neck. They now close in"
						           +" a way that makes them almost invisible. As you run a finger over your neck you feel little more than several"
						           +" small raised lines where they meet your skin.");
					} else { // if no gills
						output.text("\n\nYou feel a sudden tingle on your neck. You reach up to it to feel, whats the source of it. When you touch"
						           +" your neck, you feel that it begins to grow serveral narrow slits which slowly grow longer. After the changes"
						           +" have stopped you quickly head to a nearby puddle to take a closer look at your neck. You realize,"
						           +" that your neck has grown gills allowing you to breathe under water as if you were standing on land.");
					}
					output.text("\n\n<b>You now have fish like gills!</b>");
					return 1; // Gained gills or gillType changed

				default:
					player.gillType = oldgillType;
					changes--;
					trace("ERROR: Unimplemented new gillType (" + newGillType + ") used");
					return 0; // failsafe, should hopefully never happen
			}
		}

		public function gainSnakeTongue():Boolean
		{
			if (player.tongueType != TONGUE_SNAKE && changes < changeLimit) {
				if (player.tongueType == TONGUE_HUMAN) {
					outputText("\n\nYour taste-buds start aching as they swell to an uncomfortably large size. "
					          +"Trying to understand what in the world could have provoked such a reaction, you bring your hands up to your mouth, "
					          +"your tongue feeling like it's trying to push its way past your lips.");
					outputText("  The soreness stops and you stick out your tongue to try and see what would have made it feel the way it did. "
					          +"As soon as you stick your tongue out you realize that it sticks out much further than it did before, "
					          +"and now appears to have split at the end, creating a forked tip.");
					outputText("  <b>The scents in the air are much more noticeable to you with your snake-like tongue.</b>");
				} else {
					outputText("\n\nYour inhuman tongue shortens, pulling tight in the very back of your throat.");
					outputText("  After a moment the bunched-up tongue-flesh begins to flatten out, then extend forwards.");
					outputText("  By the time the transformation has finished, <b>your tongue has changed into a long, forked snake-tongue.</b>");
				}
				player.tongueType = TONGUE_SNAKE;
				dynStats("sen", 5);
				changes++;
				return true;
			}

			return false;
		}

		public function gainLizardTongue():Boolean
		{
			if (player.tongueType != TONGUE_LIZARD) {
				outputText("\n\nYour tongue goes numb, making your surprised noise little more than a gurgle as your tongue flops comically. ");
				switch (player.tongueType) {
					case TONGUE_SNAKE:
						outputText("\nSlowly your tongue swells, thickening up until it's about as thick as your thumb, while staying quite "
					              +" flexible. You drool, your tongue lolling out of your mouth as you slowly begin to regain control of your forked"
					              +" organ. When you retract your tongue however, you are shocked to find it is much longer than it used to be,"
					              +" now a foot long. As you cram your newly shifted appendage back in your mouth, you feel a sudden SNAP,"
					              +" and on inspection, find you've snapped off your fangs! Well, you suppose you needed the room anyway.");
						break;

					case TONGUE_DEMONIC:
						outputText("\nYour tongue gently shrinks down, the thick appendage remaining flexible but getting much smaller. There's"
					              +" little you can do but endure the weird pinching feeling as your tongue eventually settles at being a foot long."
					              +" The pinching sensation continues as the tip of your tongue morphs, becoming a distinctly forked shape."
					              +" As you inspect your tongue you slowly regain control, retracting it into your mouth, the forked tips picking up"
					              +" on things you couldn't taste before.");
						break;

					case TONGUE_DRACONIC:
						outputText("\nYour tongue rapidly shrinks down, the thick appendage remaining flexible but getting much smaller. There's"
					              +" little you can do but endure the weird pinching feeling as your tongue eventually settles at being a foot long."
					              +" The pinching sensation continues as the tip of your tongue morphs, becoming a distinctly forked shape."
					              +" As you inspect your tongue you slowly regain control, retracting it into your mouth, the forked tips picking up"
					              +" on things you couldn't taste before.");
						break;

					case TONGUE_ECHIDNA:
						outputText("\nSlowly your tongue swells, thickening up until it’s about as thick as your thumb, while staying long."
					              +" The tip pinches making you wince, morphing into a distinctly forked shape. As you inspect your tongue you slowly"
					              +" regain control, retracting it into your mouth, the forked tips picking up on things you couldn't taste before.");
						break;

					default:
						outputText("\nSlowly your tongue swells, thickening up until it’s about as thick as your thumb, filling your mouth as you"
					              +" splutter. It begins lengthening afterwards, continuing until it hangs out your mouth, settling at 1 foot long."
					              +" The tip pinches making you wince, morphing into a distinctly forked shape. As you inspect your tongue you slowly"
					              +" regain control, retracting it into your mouth, the forked tips picking up on things you couldn't taste before.");
				}
				outputText("\n\n<b>You now have a lizard tongue!</b>");
				player.tongueType = TONGUE_LIZARD;
				dynStats("sen", 5); // Sensitivy gain since its forked
				changes++;
			}

			return false;
		}

		public function gainDraconicHorns(tfSource:String):void
		{
			trace('called gainDraconicHorns("' + tfSource + '")');
			var tsParts:Array = tfSource.split("-");
			var race:String;

			if (tsParts[0] == "EmberTFs")
				race = "dragon";
			else if (tsParts[0] == "reptilum" && tsParts.length > 1)
				race = tsParts[1];
			else
				throw new Error("Unimplemented tfSource: '" + tfSource + "' used in gainDraconicHorns!");

			//No dragon horns yet.
			if (player.hornType != HORNS_DRACONIC_X2 && player.hornType != HORNS_DRACONIC_X4_12_INCH_LONG) {
				//Already have horns
				if (player.horns > 0) {
					//High quantity demon horns
					if (player.hornType == HORNS_DEMON && player.horns > 4) {
						outputText("\n\nYour horns condense, twisting around each other and merging into larger, pointed protrusions.  By the time they finish you have four draconic-looking horns, each about twelve inches long.");
						player.horns = 12;
						player.hornType = HORNS_DRACONIC_X4_12_INCH_LONG;
					}
					else {
						outputText("\n\nYou feel your horns changing and warping, and reach back to touch them.  They have a slight curve and a gradual taper.  They must look something like the horns the dragons in your village's legends always had.");
						player.hornType = HORNS_DRACONIC_X2;
						if (player.horns > 13) {
							outputText("  The change seems to have shrunken the horns, they're about a foot long now.");
							player.horns = 12;
						}

					}
					changes++;
				}
				//No horns
				else {
					//-If no horns, grow a pair
					outputText("\n\nWith painful pressure, the skin on the sides of your forehead splits around two tiny nub-like horns.  They're angled back in such a way as to resemble those you saw on the dragons in your village's legends.  A few inches of horn sprout from your head before stopping.  <b>You have about four inches of dragon-like horn.</b>");
					player.horns = 4;
					player.hornType = HORNS_DRACONIC_X2;

					changes++;
				}
			}
			//ALREADY DRAGON
			else {
				if (player.hornType == HORNS_DRACONIC_X2) {
					if (player.horns < 12) {
						if (rand(3) == 0) {
							outputText("\n\nYou get a headache as an inch of fresh horn escapes from your pounding skull.");
							player.horns += 1;
						}
						else {
							outputText("\n\nYour head aches as your horns grow a few inches longer.  They get even thicker about the base, giving you a menacing appearance.");
							player.horns += 3 + rand(3);
						}
						if (player.horns >= 12) outputText("  <b>Your horns settle down quickly, as if they're reached their full size.</b>");
						changes++;
					}
					//maxxed out, new row
					else {
						//--Next horn growth adds second row and brings length up to 12\"
						outputText("\n\nA second row of horns erupts under the first, and though they are narrower, they grow nearly as long as your first row before they stop.  A sense of finality settles over you.  <b>You have as many horns as a " + race + " can grow.</b>");
						player.hornType = HORNS_DRACONIC_X4_12_INCH_LONG;
						changes++;
					}
				}
			}
		}
	}
}
