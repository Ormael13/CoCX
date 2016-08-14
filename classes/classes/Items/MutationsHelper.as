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

		// I tend to use bitfields rather than lots of optional boolean params.
		// If I consider a method to be finalized and has only one option I'll refactor this to use a boolean value.

		// restoreLegs options
		public static const RESTORELEGS_EXCLUDE_TAUR:int   =  1;
		public static const RESTORELEGS_EXCLUDE_GOO:int    =  2;
		public static const RESTORELEGS_EXCLUDE_NAGA:int   =  4;
		public static const RESTORELEGS_EXCLUDE_DRIDER:int =  8;
		public static const RESTORELEGS_FIX_BIPED:int      = 16;

		public var changes:int = 0;
		public var changeLimit:int = 1;

		public function MutationsHelper() {}

		public function restoreArms(tfSource:String):int
		{
			trace('called restoreArms("' + tfSource + '")');

			if (tfSource == "gooGasmic") {
				// skin just turned gooey. Now lets fix unusual arms.
				var hasClaws:Boolean = player.clawType != CLAW_TYPE_NORMAL;

				if (hasClaws || player.armType == ARM_TYPE_HARPY) outputText("\n\n");
				if (player.armType == ARM_TYPE_HARPY) {
					outputText("The feathers on your arms melt back into your now gooey skin.");
					if (hasClaws) outputText(" Additionally your ");
				} else if (hasClaws) outputText("Your ");

				if (hasClaws) outputText("now gooey claws melt back into your fingers. Well, who cares, gooey claws aren't very useful in combat to begin with.");
				if (hasClaws || player.armType == ARM_TYPE_HARPY) outputText("  <b>You have normal human arms again.</b>");

				updateClaws();
				player.armType = ARM_TYPE_HUMAN;
				return 1;
			}


			if (changes < changeLimit && player.armType != ARM_TYPE_HUMAN) {
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
				updateClaws();
				player.armType = ARM_TYPE_HUMAN;
				changes++;
				return 1;
			}

			return 0;
		}

		public function restoreLegs(keepFeet:Array = null, options:int = 0):Boolean
		{
			var doRestore:Boolean = false;
			
			if (keepFeet == null) keepFeet = [];
			if (keepFeet.indexOf(player.lowerBody) >= 0) return false; // For future TFs

			//(Centaurs -> Normal Human Legs)
			if (!(options & RESTORELEGS_EXCLUDE_TAUR) && player.isTaur() && changes < changeLimit) {
				outputText("\n\nYour quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of human legs</b>!");
				doRestore = true;
			}

			//(Goo -> Normal Human Legs)
			if (!(options & RESTORELEGS_EXCLUDE_GOO) && player.isGoo() && changes < changeLimit) {
				outputText("\n\nYour lower body rushes inward, molding into two leg-like shapes that gradually stiffen up.  In moments they solidify into normal-looking legs, complete with regular, human feet.  <b>You now have normal feet!</b>");
				doRestore = true;
			}

			//(Naga -> Normal Human Legs)
			if (!(options & RESTORELEGS_EXCLUDE_NAGA) && player.isNaga() && changes < changeLimit) {
				outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly where your new feet are forming.  <b>You have human legs again.</b>");
				doRestore = true;
			}

			//(Drider -> Normal Human Legs)
			if (!(options & RESTORELEGS_EXCLUDE_DRIDER) && player.isDrider() && changes < changeLimit) {
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
			if ((options & RESTORELEGS_FIX_BIPED) && player.isBiped() && player.lowerBody != LOWER_BODY_TYPE_HUMAN && changes < changeLimit) {
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
			var benoitMF:Function = getGame().bazaar.benoit.benoitMF;
			var benoitMFText:String = "";
			var hairPinID:int = player.hasKeyItem("Feathery hair-pin");
			trace('called lizardHairChange("' + tfSource + '")');

			switch (tfSource) {
				case "reptilum-lizan":
				case "reptilum-dragonewt":
					//-Hair stops growing!
					if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) {
						outputText("\n\nYour scalp tingles oddly.  In a panic, you reach up to your " + player.hairDescript() + ", but thankfully it appears unchanged.");
						outputText("\n\n(<b>Your hair has stopped growing.</b>)");
						changes++;
						flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 1;
						return -1; // --> hair growth stopped
					}
					return 0;

				case "PlayerEvents":
				case "reptilum-basilisk":
				case "reptilum-dracolisk":
					if (player.hairType == HAIR_BASILISK_PLUME && player.cor < 65) return 0;

					if (player.isFemaleOrHerm() && player.cor < 15 && player.featheryHairPinEquipped() && player.isBasilisk()) {
						benoitMFText = benoitMF(
							" your hair has changed into a plume of feathers that, like legend is told, belongs to a female basilisk!",
							" you have a plume, like a female basilisk!");
						if (player.hairType == HAIR_GOO)
							outputText("\n\nYour gooey hair begins to fall out in globs, eventually leaving you with a bald head.");

						outputText("\n\nYour head begins to tickle and you reach up to scratch at it, only to be surprised by the softness you feel."
						          +" It reminds you of the down of baby chickens, velvety soft and slightly fluffy. You look at yourself in a nearby"
						          +" puddle and gasp, where your hair once was, you now have red feathers, some longer and larger than others. This"
						          +" floppy but soft plume sits daintily on your head, reminding you of a ladies fascinator. You realise soon that"
						          + benoitMFText);

						if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] != 0)
							outputText("\n\n<b>Your hair is growing again and is now a plume of short red feathers.</b>");
						else
							outputText("\n\n<b>Your hair is now a plume of short red feathers.</b>");

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
							outputText("\n\nYour scalp feels tight and hot, causing you to run a hand through your [hair] to rub at it gingerly.");

							if (player.featheryHairPinEquipped())
								outputText("\n\nThe pin in your hair heats up to the point where you have to pull it free and toss it to the ground,"
								          +" it sizzling against the earth.");

							outputText("\n\nTo your shock a handful of your [hair] comes loose, exposing the [skinFurScales] beneath. You wonder why"
							          +" this is happening to you but realise it must be the potion, lizards don't tend to have hair after all."
							          +" You continue to rub at your scalp, the cool air against your slowly revealed skin a welcome relief."
							          +" After several minutes of this, you're certain you've shed all your hair. When you think it's all over,"
							          +" you feel an uncomfortable pressure build, your scalp morphing and changing as you grimace."
							          +" When the sensation finally fades you rush to look at yourself in a puddle. Where you once had hair,"
							          +" you now have a crown of dull reptilian spines!");

						}

						// Female Basilisk to Corrupted Basilisk
						if (player.hairLength > 0 && player.hairType == HAIR_BASILISK_PLUME) {
							outputText("\n\nA sudden sharp pain drills through your skull, a pressure forming across your scalp."
							          +" If you didn't know any better you'd think you were being plucked!");

							if (player.featheryHairPinEquipped())
								outputText("\n\nThe pin in your hair heats up to the point where you have to pull it free and toss it to the ground,"
								          +" it sizzling against the earth.");

							outputText("\n\nYou clutch your head as you feel the feathers on your head push out further, thickening up as they do so."
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
								outputText("\n\nYour gooey hair begins to fall out in globs, eventually leaving you with a bald head.");

							if (player.featheryHairPinEquipped())
								outputText("\n\nThe pin in your hair heats up to the point where you have to pull it free and toss it to the ground,"
								          +" it sizzling against the earth.");

							outputText("\n\nYour scalp feels tight, as though the skin is shifting and morphing."
							          +" You let out groan as you grip your head, praying for the pain to subside quickly. Pressure builds,"
							          +" your head feeling ready to split. As the sensation fades you're left wondering what just happened and you"
							          +" run to look at yourself in a nearby puddle.");
						}

						// Finalize Corrupted Basilisk TFs
						player.hairColor = player.skinTone;                   // hairColor always set to player.skinTone
						player.hairType = HAIR_BASILISK_SPINES;               // hairType set to basilisk spines
						player.hairLength = 2;                                // hairLength set to 2 (inches, displayed as ‘short’)
						flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0; // Hair growth stops
						changes++;
						outputText("\n\n<b>Where your hair would be, you now have a crown of dull reptilian spines!</b>");

						if (player.featheryHairPinEquipped())
							outputText("\n\nYou place the hair-pin in your inventory, no longer able to wear it.");
						else
							outputText("\n\nYour thoughts wander to the hair-pin while you adjust to your new [hair]. You probably won't be able to"
							          +" wear it while you're this tainted.");

						if (hairPinID >= 0) {                                 // hair-pin set to unequipped
							player.keyItems[hairPinID].value1 = 0;
							player.keyItems[hairPinID].value2 = 0;
						}
						if (tfSource == "PlayerEvents") outputText("\n");
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

			// Note, that we don't do the score checks anymore. That was just an unly workaround and we don't want to do that again!
			switch(tfSource) {
				case "emberTFs":
				case "snakeOil":
				case "goldenSeed-HarpyWomb":
				//case "catTransformation-dragonne": // Keep it? Maybe later.
				// TFs with minor changes. Just in case, we change our mind or if we intend to upgrade them.
				case "winterPudding":
				case "rizzaRootEffect":
					return 0; // Don't change it. So we're done, yay!

				case "reptilum":
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

	}
}
