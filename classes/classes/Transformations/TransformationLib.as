package classes.Transformations {
import classes.BaseContent;

import classes.BodyParts.Horns;
import classes.BodyParts.Hair;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.BodyParts.Tongue;

import classes.Items.MutationsHelper;
import classes.StatusEffects;
import classes.internals.EnumValue;
import classes.Scenes.Metamorph;
import classes.GlobalFlags.kFLAGS;
import classes.Transformations.TransformationUtils;
import classes.PerkLib;

public class TransformationLib extends MutationsHelper {
	public function TransformationLib() {
	}

	// VARIABLE NAMING: <body part> + <what to do> + <flavour>
	// e.g. "grow 9th fox tail" -> TailFox9
	// Complex TF should have prefix "Complex" or "Tiered" and can have any naming

	// Template - copy and fill
	// "is possible" function is optional default is "possible if not present"
	/*
	public const NAME:Transformation = new SimpleTransformation("Tf Name",
			// apply effect
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("TF Effect")
				}
				apply_TF
			},
			// is present
			// is present
			function():Boolean {
				return true_if_TF_already_present_on_player
			},
			// is possible
			// is possible
			function():Boolean {
				return true_if_TF_can_be_applied_to_player
			}
	);
	 */


	/***
	 *    ███████ ███████ ███████ ███████  ██████ ████████ ███████
	 *    ██      ██      ██      ██      ██         ██    ██
	 *    █████   █████   █████   █████   ██         ██    ███████
	 *    ██      ██      ██      ██      ██         ██         ██
	 *    ███████ ██      ██      ███████  ██████    ██    ███████
	 *
	 *
	 */
	// Template for non-tf effects and tf effects that cannot be "present" (ex. enlarge cock)
	// "is possible" function is optional, default always possible
	/*
	public const NAME:PossibleEffect = new SimpleEffect("Effect name",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (doOutput) outputText(desc);
				apply_effect
			},
			// is possible?
			function ():Boolean {
				return true_if_effect_can_be_applied_to_player
			}
	);
	 */
	public const MutagenSpeSpider:PossibleEffect    = new MutagenEffect(
			"Mutagen Bonus SPE (spider)",
			"spe",
			1.5,
			"Your reflexes feel much faster. Experimentally, you make a grab at a fly on a nearby rock and quickly snatch it out of the air.  A compulsion to stuff it in your mouth and eat it surfaces, but you resist the odd desire.  Why would you ever want to do something like that?"
	);
	public const MutagenTouSpider:PossibleEffect    = new MutagenEffect(
			"Mutagen Bonus TOU (spider)",
			"tou",
			1,
			"Stretching languidly, you realize you're feeling a little tougher than before, almost as if you had a full-body shell of armor protecting your internal organs.  How strange.  You probe at yourself, and while your [skinfurscales] doesn't feel much different, the underlying flesh does seem tougher."
	);
	public const MutagenLibSpider:PossibleEffect    = new MutagenEffect(
			"Mutagen Bonus LIB (spider)",
			"lib",
			1,
			"You suddenly feel slightly needier, and your loins stir in quiet reminder that they could be seen to. The aftertaste hangs on your tongue and your teeth.  You wish there had been more."
	);
	public const SensUpSpider:PossibleEffect        = new DynstatEffect(
			"Spider sens up",
			"sen",
			+1,
			"The hairs on your arms and legs stand up straight for a few moments, detecting the airflow around you. Touch appears to be more receptive from now on."
	);
	public const VenomRechargeSpider:PossibleEffect = new SimpleEffect(
			"Recharge spider venom",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "The spinnerets on your abdomen twitch and drip a little webbing.  The entirety of its heavy weight shifts slightly, and somehow you know you'll produce webs faster now.";

				if (doOutput) outputText(desc);
				player.tailRecharge += 5;
			},
			// is possible
			function ():Boolean {
				return player.tailType == Tail.SPIDER_ADBOMEN && player.tailRecharge < 25;
			}
	);

	public const VaginaTightenAndMutagenLib:PossibleEffect  = new SimpleEffect(
			"Tighten vagina + Mutagen Bonus LIB",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "With a gasp, you feel your [vagina] tightening, making you leak sticky girl-juice. After a few seconds, it stops, and you rub on your [vagina] excitedly. You can't wait to try this out!";

				if (doOutput) outputText(desc);
				player.vaginas[0].vaginalLooseness--;
				dynStats("lus", 25);
				MutagenBonus("lib", 2);
			},
			// is possible
			function ():Boolean {
				return player.hasVagina() && player.looseness() > 1
			}
	);
	public const AssholeTightenAndMutagenLib:PossibleEffect = new SimpleEffect(
			"Tighten asshole + Mutagen Bonus LIB",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You let out a small cry as your [asshole] shrinks, becoming smaller and tighter. When it's done, you feel much hornier and eager to stretch it out again.";

				if (doOutput) outputText(desc);
				player.ass.analLooseness--;
				dynStats("lus", 25);
				MutagenBonus("lib", 2);
			},
			// is possible
			function ():Boolean {
				return player.ass.analLooseness > 1;
			}
	);
	public const CocksThickenAll:PossibleEffect             = new SimpleEffect(
			"Thicken all cocks",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";
				var thickened:Boolean = false;
				for (var i:int = 0; i < player.cockTotal(); i++) {
					if (player.cocks[i].cockThickness * 5.5 < player.cocks[i].cockLength) {
						player.cocks[i].cockThickness += .1;
						thickened = true;
					}
				}
				if (thickened) {
					desc += "You can feel your [cocks] filling out in your [armor]. Pulling ";
					if (player.cockTotal() == 1) desc += "it";
					else desc += "them";
					desc += " out, you look closely.  ";
					if (player.cockTotal() == 1) desc += "It's";
					else desc += "They're";
					desc += " definitely thicker.";
				}

				if (doOutput) outputText(desc);
			},
			// is possible
			function ():Boolean {
				return player.hasCock();
			}
	);

	public function makeHairColorTf(colors:/*String*/Array):Transformation {
		return new SimpleTransformation("hair color: " + colors.join("|"),
				// apply effect
				function (doOutput:Boolean):void {
					var color:String = randomChoice(colors);
					player.hairColorOnly = color;
					var desc: String = "";

					desc += "Your scalp begins to tingle, and you gently grasp a strand of hair, pulling it out to check it.  Your hair has become [haircolor]!";

					if (doOutput) outputText(desc);
				},
				// is present
				function ():Boolean {
					return InCollection(player.hairColor, colors);
				}
		)
	}

	public const SpinneretAtlach:Transformation = new SimpleTransformation("Chitinous spider legs",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (player.tailType > Tail.NONE) desc += "Your tail shudders as heat races through it, twitching violently until it feels almost as if it's on fire.  You jump from the pain at your [butt] and grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your [butt]!</b>\n\n";
				//(No tail)
				else desc += "A burst of pain hits you just above your [butt], coupled with a sensation of burning heat and pressure.  You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body.  Reaching back, you grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your [butt]!</b>";

				if (doOutput) outputText(desc);
				//(Pre-existing tails)
				setTailType(Tail.SPIDER_ADBOMEN);
				player.tailVenom = 5;
				player.tailRecharge = 5;
				player.coatColor = "midnight purple";
			},
			// is present
			function ():Boolean {
				return player.tailType === Tail.SPIDER_ADBOMEN;
			}
	);

	/***
	 *    ███████ ██   ██ ██ ███    ██
	 *    ██      ██  ██  ██ ████   ██
	 *    ███████ █████   ██ ██ ██  ██
	 *         ██ ██  ██  ██ ██  ██ ██
	 *    ███████ ██   ██ ██ ██   ████
	 */


	public const SkinChitin:Transformation = new SimpleTransformation("Chitin skin",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (player.hasCoat()) {
						desc += "A slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your [skin coat] [skin coat.isare] falling to the ground, revealing flawless, midnight purple chitin underneath.";
				} else {
						desc += "A slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your skin stating to harden turning slowly into chitin.";
				}
					desc += "  <b>You now have midnight purple chitin exoskeleton partialy covering your body.</b>";

				if (doOutput) outputText(desc);
				player.skin.growCoat(Skin.CHITIN, {color: "midnight purple"}, Skin.COVERAGE_LOW);
				addGeneticMemory(StatusEffects.UnlockedChitin, "Chitin");
			},
			// is present
			function ():Boolean {
				return player.hasCoatOfType(Skin.CHITIN);
			}
	);

	/***
	 *    ██   ██  ██████  ██████  ███    ██ ███████
	 *    ██   ██ ██    ██ ██   ██ ████   ██ ██
	 *    ███████ ██    ██ ██████  ██ ██  ██ ███████
	 *    ██   ██ ██    ██ ██   ██ ██  ██ ██      ██
	 *    ██   ██  ██████  ██   ██ ██   ████ ███████
	 */
	public const HornsNone: Transformation = new SimpleTransformation("No Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        if (player.horns.type == Horns.ORCHID) desc += "Your orchid flowers crumble, falling apart";
	        else desc += "Your horns crumble, falling apart in large chunks";
	        desc += " until they flake away to nothing.";
	        player.horns.count = 0;
	        player.horns.type = Horns.NONE;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("No Horns", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.NONE;
	    }
	);

	public const HornsBicorn: Transformation = new SimpleTransformation("Bicorn Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        if (player.horns.type == Horns.NONE) desc += "With painful pressure, the skin on your forehead splits around two tiny nub-like horn, a little bit similar to that you would see on the cattle back in your homeland.";
	        else desc += "Your horns vibrate and shift as if made of clay, reforming into horns with a bicorn-like shape.";
	        player.horns.count = 2;
	        player.horns.type = Horns.BICORN;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Bicorn Horns", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.BICORN;
	    }
	);

	public const HornsUnicorn: Transformation = new SimpleTransformation("Unicorn Horn",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        if (player.horns.type == Horns.NONE) desc += "With painful pressure, the skin on your forehead splits around tiny nub-like horn, a little bit similar to that you would see on the cattle back in your homeland.";
	        else desc += "Your horns vibrate and shift as if made of clay, reforming into horn with a unicorn-like shape.";
	        player.horns.count = 1;
	        player.horns.type = Horns.UNICORN;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Unicorn Horn", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.UNICORN;
	    }
	);

	public const HornsOniDual: Transformation = new SimpleTransformation("Oni Dual Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        if (player.horns.type == Horns.NONE) desc += "You moan in pleasure as a pair of bony horns push forward out of your forehead,";
	        else desc += "You begin to feel an odd itching sensation as you feel your horns repositioning,";
	        desc += " the things are actually surprisingly sensitive and you reach orgasm just from them reaching full size,";
	        if (player.gender == 1 || player.gender == 3) desc += " your [cock] splatering cum on the ground";
	        if (player.gender == 3) desc += " and";
	        if (player.gender == 2 || player.gender == 3) desc += " your pussy gushing with a copious amount of juice";
	        desc += ". You would rather your opponent not know you have a G spot at the tip of your forehead and so you keep this information to yourself. <b>You now have a pair of horns just like an oni.</b>";
	        player.horns.count = 2;
	        player.horns.type = Horns.ONI_X2;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Oni Dual Horns", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.ONI_X2;
	    }
	);

	public const HornsOni: Transformation = new SimpleTransformation("Oni Horn",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        if (player.horns.type == Horns.NONE) desc += "You moan in pleasure as a single bony horns push forward out of your forehead,";
	        else desc += "You begin to feel an odd itching sensation as you feel your horns repositioning and merging into one,";
	        desc += " the thing is actually surprisingly sensitive and you reach orgasm just from it reaching full size,";
	        if (player.gender == 1 || player.gender == 3) desc += " your [cock] splatering cum on the ground";
	        if (player.gender == 3) desc += " and";
	        if (player.gender == 2 || player.gender == 3) desc += " your pussy gushing with a copious amount of juice";
	        desc += ". You would rather your opponent not know you have a G spot at the tip of your forehead and so you keep this information to yourself. <b>You now have a horns just like an oni.</b>";
	        player.horns.count = 1;
	        player.horns.type = Horns.ONI;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Oni Horn", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.ONI;
	    }
	);

	public const HornsGoat: Transformation = new SimpleTransformation("Goat Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        if (player.horns.type == Horns.NONE) {
						desc += "You begin to feel a prickling sensation at the top of your head. Reaching up to inspect it, you find a pair of hard stubs. <b>You now have a pair of goat horns.</b>";
					} else if(player.horns.type == Horns.GOATQUAD) {
						desc += "You begin to feel an odd itching sensation as you feel your horns repositioning and merging back togueter. Once it's over, you reach up and find a pair of tall-standing goat horns where your four horns used to be. <b>You now have a pair of goat horns.</b>"
					} else desc += "You begin to feel an odd itching sensation as you feel your horns repositioning. Once it's over, you reach up and find a pair of hard stubs. <b>You now have a pair of goat horns.</b>";

	        player.horns.count = 1;
	        player.horns.type = Horns.GOAT;
	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Goat Horns", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.GOAT;
	    }
	);

	public const HornsGoatQuadruple: Transformation = new SimpleTransformation("Goat Quadruple Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        if(player.horns.type == Horns.GOAT) {
						desc += "You groan in pleasure mixed pains as your horns begins to split into a second pair ornating the side of your head. If the original pair made you look fiendish your four horns now definitively denounce your demonic nature. <b> You now have four devil horns curving backward behind your head.</b>"
					}

	        player.horns.count = 1;
	        player.horns.type = Horns.GOATQUAD;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.GOAT;
	    }
	);

	public const HornsDraconicQuadruple: Transformation = new SimpleTransformation("Draconic Quadruple Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					TransformationUtils.applyTFIfNotPresent(transformations.HornsDraconicDual, doOutput);

					if (player.horns.type == Horns.DEMON && player.horns.count > 4) {
						desc += "Your horns condense, twisting around each other and merging into larger, pointed protrusions.  By the time they finish <b>you have four draconic-looking horns, each about twelve inches long.</b>"
					} else {
						desc += "A second row of horns erupts under the first, and though they are narrower, they grow nearly as long as your first row before they stop. A sense of finality settles over you. <b>You have four draconic-looking horns, each about twelve inches long.</b>";
					}

					player.horns.count = 12;
	        player.horns.type = Horns.DRACONIC_X4_12_INCH_LONG;
	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Draconic Quadruple Horns", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.DRACONIC_X4_12_INCH_LONG;
	    }
	);

	public const HornsDraconicDual: Transformation = new SimpleTransformation("Draconic Dual Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					if (player.horns.type === Horns.NONE) {
						desc += "With painful pressure, the skin on the sides of your forehead splits around two tiny nub-like horns.  They're angled back in such a way as to resemble those you saw on the dragons in your village's legends.  A few inches of horns sprout from your head before stopping.  <b>You have about four inches of dragon-like horns.</b>";
					} else {
						desc += "You feel your horns changing and warping, and reach back to touch them. They have a slight curve and a gradual taper. They must look something like the horns the dragons in your village's legends always had.";

						if (player.horns.count > 13) {
							desc += " The change seems to have shrunken the horns, they're about a foot long now.";
							player.horns.count = 12;
						}
					}

					if (player.horns.count < 4) {
	        	player.horns.count = 4;
					}

	        player.horns.type = Horns.DRACONIC_X2;
	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Draconic Dual Horns", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.DRACONIC_X2;
	    }
	);

	public const HornsCowMinotaur: Transformation = new SimpleTransformation("Cow Minotaur Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        if (player.horns.type == Horns.COW_MINOTAUR || player.horns.type == Horns.NONE) {
	            if (player.horns.type == Horns.COW_MINOTAUR) {
	                if (player.horns.count < 5) {
	                    desc += "Your small horns get a bit bigger, stopping as medium sized nubs.";
	                    player.horns.count += 1 + rand(2);
	                }
	            }
	            if (player.horns.type == Horns.NONE || player.horns.count == 0) {
	                desc += "With painful pressure, the skin on your forehead splits around two tiny nub-like horns, similar to those you would see on the cattle back in your homeland.";
	                player.horns.count = 1;
	            }
	            if (player.horns.type != Horns.NONE && player.horns.type != Horns.COW_MINOTAUR && player.horns.type != Horns.ORCHID && player.horns.count > 0) {
	                desc += "Your horns twist, filling your skull with agonizing pain for a moment as they transform into cow-horns.";
	            }
	        }
	        if ((player.horns.type == Horns.DEMON || player.horns.type > Horns.COW_MINOTAUR) && player.horns.type != Horns.ORCHID) {
	            desc += "Your horns vibrate and shift as if made of clay, reforming into two small bovine nubs.";
	            player.horns.count = 2;
	        }
	        player.horns.type = Horns.COW_MINOTAUR;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Cow minotaur Horns", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.COW_MINOTAUR;
	    }
	);

	public const HornsDemonic: Transformation = new SimpleTransformation("Demonic Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        if (player.horns.count < 12 && (player.horns.type == Horns.NONE || player.horns.type == Horns.DEMON)) {
	            desc += "";
	            if (player.horns.count == 0) {
	                desc += "A small pair of demon horns erupts from your forehead. They actually look kind of cute. <b>You have horns!</b>";
	            } else desc += "Another pair of demon horns, larger than the last, forms behind the first row.";
	        } else if (player.horns.type > Horns.DEMON && player.horns.type != Horns.ORCHID) {
	            desc += "";
	            desc += "Your horns shift, shrinking into two small demonic-looking horns.";
	        }
	        player.horns.count = 2;
	        player.horns.type = Horns.DEMON;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Demon Horns", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.DEMON;
	    }
	);

	public const HornsAntlers: Transformation = new SimpleTransformation("Antlers Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					if (player.horns.type === Horns.NONE) {
						desc += "You hear the sound of cracking branches erupting from the tip of your skull. Small bulges on either side of your head advance outwards in a straight line, eventually spreading out in multiple directions like a miniature tree.  Investigating the exotic additions sprouting from your head, the situation becomes clear. <b>You've grown antlers!</b>";
					} else {
						desc += "You hear the sound of cracking branches erupting from the tip of your skull.  The horns on your head begin to twist and turn fanatically, their texture and size morphing considerably until they resemble something more like trees than anything else.  Branching out rebelliously, you've come to the conclusion that <b>you've somehow gained antlers!</b>";
					}

	        player.horns.count = 4 + rand(12);

	        player.horns.type = Horns.ANTLERS;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.ANTLERS;
	    }
	);

	public const HornsAntlersWendigo: Transformation = new SimpleTransformation("Wendigo Antlers Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
				var desc: String = "";

				transformations.HornsAntlers.applyEffect(false);
				player.horns.count = 30;

	      if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.ANTLERS && player.horns.count >= 30;
	    }
	);

	public const HornsGhostlyWisps: Transformation = new SimpleTransformation("Ghostly Wisps Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					if (player.horns.type === Horns.NONE) {
						desc += "You notice something bright moving out of the corner of your eye. You look over to see an ethereal ball of light floating above your head. You can see four more floating with it slowly circling above your head. You touch one, surprised that you can actually feel it accompanied by a chilling sensation. <b>It seems that these ghostly wisps are a part of you.</b>";
					} else {
						desc += "Your old horns slowly crumbling away until nothing is left. Then you notice something bright moving out of the corner of your eye. You look over to see an ethereal ball of light floating above your head. You can see four more floating with it slowly circling above your head. You touch one, surprised that you can actually feel it accompanied by a chilling sensation. <b>It seems that these ghostly wisps are a part of you.</b>";
					}

	        player.horns.count = 2;
	        player.horns.type = Horns.GHOSTLY_WISPS;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.GHOSTLY_WISPS;
	    }
	);

	public const HornsOak: Transformation = new SimpleTransformation("Oak Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					if (player.horns.type === Horns.NONE) {
						desc += "You hear the sound of cracking branches erupting from the tip of your skull.  Small bulges on either side of your head advance outwards in a straight line, eventually spreading out in multiple directions like a miniature tree.  Investigating the exotic additions sprouting from your head, the situation becomes clear.  <b>You've grown oak horns!</b>";
					} else {
						desc += "You hear the sound of cracking branches erupting from the tip of your skull.  The horns on your head begin to twist and turn fanatically, their texture and size morphing considerably until they resemble something more like trees than anything else.  Branching out rebelliously, you've come to the conclusion that <b>you've somehow gained oak horns!</b>";
					}

	        player.horns.count = 4 + rand(12);

	        player.horns.type = Horns.OAK;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.OAK;
	    }
	);

	public const HornsOrchid: Transformation = new SimpleTransformation("Orchid Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					if (player.horns.type === Horns.NONE) {
						desc += "A spot on each side of your head has been getting steadily sorer.  You’re beginning to think about finding somewhere quiet to take a look at it when it suddenly and rather shockingly bursts, allowing something hand-sized to bloom out from your [hair]. A huge orchids is now flourishing their floppy petals and stamen above your head!  <b>You've grown twin orchid flowers!</b>";
					} else {
						desc += "Your old horns slowly crumbling away until nothing is left.  Then a spot on each side of your head has been getting steadily sorer.  You’re beginning to think about finding somewhere quiet to take a look at it when it suddenly and rather shockingly bursts, allowing something hand-sized to bloom out from your [hair]. A huge pair of orchids is now flourishing their floppy petals and stamen above your head! <b>You've grown a pair of orchid flowers!</b>";
					}

	        player.horns.count = 2;
	        player.horns.type = Horns.ORCHID;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.ORCHID;
	    }
	);

	public const HornsKraken: Transformation = new SimpleTransformation("Kraken Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					desc += "You feel like your head is going to explode and, in a way, it does. Something large and fleshy grows out of the top of your head. When you move toward the water to check your reflection, you discover that you have grown a <b>large fleshy hood, crowning your head just like a Kraken.</b>";

	        player.horns.count = 4 + rand(12);
	        player.horns.type = Horns.KRAKEN;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.KRAKEN;
	    }
	);

	public const HornsSeadragon: Transformation = new SimpleTransformation("Seadragon Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					if (player.horns.type === Horns.NONE) {
						desc += "You writhe in pain as two bony extrusions begin to push out of the side of your head. As a skull-splitting headache wracks through you, in an instant, the pain subsides as you feel two large, scale-colored horns on your head. They are as sensitive as they are sturdy.\n\nA quick look at a puddle also reveals they radiate several specks of bioluminescent light along the horns accompanied by red tips. <b>You have about twelve inches of sea dragon-like horns!</b>";
					} else {
						if (player.horns.type == Horns.DEMON && player.horns.count > 4) {
              desc += "Your horns condense, twisting around each other and merging into larger, pointed protrusions.  By the time they finish you have two sea dragon horns, each about twelve inches long.";
              player.horns.count = 12;
            } else {
              desc += "\n\nYou feel your horns changing and warping, and reach back to touch them.  They have a slight curve and a gradual taper.  They look must look like the horns of a sea dragon.";
              if (player.horns.count > 13) {
                  desc += " The change also seems to have shrunken the horns, they're about a foot long now.";
                  player.horns.count = 12;
              }
            }
					}

	        player.horns.count = 4;
	        player.horns.type = Horns.SEADRAGON;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.SEADRAGON;
	    }
	);

	public const HornsFrostwyrm: Transformation = new SimpleTransformation("Frostwyrm Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					TransformationUtils.applyTFIfNotPresent(transformations.HornsNone);

					desc += "You write in pain as two bony lumps begins to push out of the side of your head. The transformation gives you a hell of a headache but as soon as it is over you feel for the two large spiraling horns on your head similar to those of a ram and unsurprisingly they are as sensitive as they are sturdy. <b>You now have frost wyrm horns!</b>";

	        player.horns.count = 2;

	        player.horns.type = Horns.FROSTWYRM;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.FROSTWYRM;
	    }
	);

	public const HornsUshiOni: Transformation = new SimpleTransformation("Ushi-Oni Horns",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					desc += "From the back of your head you feel like something is pushing out of your skull and from the pressure a pair of horns begin to grow, continuing to get bigger and bigger, curving up along the sides of your head. You reach up to feel them and see they have a spiral shape, <b>you now have an Ushi-Oni pair of horns.</b>";

	        player.horns.count = 2;

	        player.horns.type = Horns.USHI_ONI;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.horns.type === Horns.USHI_ONI;
	    }
	);

	/***
	 *    ██   ██  █████  ██████ ██████
	 *    ██   ██ ██   ██   ██   ██   ██
	 *    ███████ ███████   ██   ██████
	 *    ██   ██ ██   ██   ██   ██   ██
	 *    ██   ██ ██   ██ ██████ ██   ██
	 */
	public const HairHuman:Transformation = new SimpleTransformation("Human Hair",
			// apply effect
			function (doOutput:Boolean):void {
  			var desc: String = "";
				switch (player.hairType) {
					case (Hair.FEATHER || Hair.QUILL):
  					var word1:String;
  					if (player.hairType == Hair.FEATHER) {
  						word1 = "feather";
  					}	else {
  						word1 = "quill";
  					}
  					if (player.hairLength >= 6) {
  						desc += "A lock of your downy-soft " + word1 + "-hair droops over your eye. Before you can blow the offending down away, you realize the " + word1 + " is collapsing in on itself. It continues to curl inward until all that remains is a normal strand of hair. <b>Your hair is no longer " + word1 + "-like!</b>";
  					} else {
  						desc += "You run your fingers through your downy-soft " + word1 + "-hair. While your hand is up there, it detects a change in the texture of your " + word1 + "s. They're completely disappearing, merging down into strands of regular hair. <b>Your hair is no longer " + word1 + "-like!</b>";
  					}
						break;
					case Hair.ANEMONE:
  					desc += "You feel something strange going in on your head. Before you can wonder about it, the tentacles you have for hair begin to recede back into your scalp, eventually leaving you with a bald head. Your head is not left bald for long, though. Within moments, a full head of hair sprouts from the skin of your scalp. <b>Your hair is normal again!</b>";
						break;
					case Hair.GOO:
  					desc += "Your gooey hair begins to fall out in globs, eventually leaving you with a bald head. Your head is not left bald for long, though. Within moments, a full head of hair sprouts from the skin of your scalp. <b>Your hair is normal again!</b>";
						break;
					case Hair.GORGON:
  					player.hairLength = 1;
  					desc += "As you finish the root, the scaled critters on your head shake wildly in displeasure. Then, a sudden heat envelopes your scalp. The transformative effects of your spicy meal make themselves notorious, as the writhing mess of snakes start hissing uncontrollably. Many of them go rigid, any kind of life that they could had taken away by the root effects. Soon all the snakes that made your hair are limp and lifeless.";
  					desc += "Their dead bodies are separated from you head by a scorching sensation, and start falling to the ground, turning to dust in a matter of seconds. Examining your head on the stream, you realize that you have a normal, healthy scalp, though devoid of any kind of hair.";
  					desc += "The effects don’t end here, though as the familiar sensation of hair returns to your head a moment later. After looking yourself on the stream again, you confirm that <b>your once bald head now has normal, short [haircolor] hair</b>.";
						break;
					case Hair.WINDSWEPT:
  					desc += "A sensation of weight assaults your scalp. You reach up and grab a handful of hair, confused. Your perplexion only heightens when you actually feel the follicles becoming heavier in your grasp. Plucking a strand, you hold it up before you, surprised to see... it's no longer transparent! You have normal hair!";
						break;
					case Hair.LEAF:
  					if (player.hairLength >= 6) {
  						desc += "A lock of your leaf-hair droops over your eye. Before you can blow the offending down away, you realize the leaf is changing until all that remains is a normal strand of hair. <b>Your hair is no longer leaf-like!</b>";
  					} else {
  						desc += "You run your fingers through your leaf-hair while you await the effects of the item you just ingested. While your hand is up there, it detects a change in the texture of your leafs. They're completely disappearing, merging down into strands of regular hair. <b>Your hair is no longer leaf-like!</b>";
  					}
						break;
					case Hair.FLUFFY:
  					desc += "You feel something strange going in on your head. You reach your hands up to feel your fluffy hair, only to find out that they have vanished and replaced with normal hair. <b>Your hair is normal again!</b>";
						break;
					case Hair.GRASS:
  					desc += "You feel something strange going in on your head. You reach your hands up to feel your grass-hair, only to find out that the long, soft and leafy blades have vanished and replaced with normal hair. <b>Your hair is normal again!</b>";
						break;
					case Hair.SILKEN:
  					desc += "You feel something strange going in on your head. You reach your hands up to feel your silken-hair, only to find out that they have changed back to normal hair. <b>Your hair is normal again!</b>";
						break;
					case Hair.BURNING:
  					desc += "Your head begins to cool down until the flames entirely disappear, leaving you with ordinary hair. <b>Your hair is normal again!</b>";
						break;
					default:
						desc += "You feel a strange sensation on your head. Passing a hand on it, you realize it feels completely human. <b>Your hair is normal again!</b>";
				}

				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;

				if (doOutput) outputText(desc);

				player.hairType = Hair.NORMAL;
				Metamorph.unlockMetamorph("Human Hair", doOutput);
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.NORMAL;
			}
	);

	public const HairFeather:Transformation = new SimpleTransformation("Feather Hair",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
  				var desc: String = "";

					desc += "A tingling starts in your scalp, getting worse and worse until you're itching like mad. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. <b>You have feathers for hair, just like a harpy!</b>";

					outputText(desc);
				}
				player.hairType = Hair.FEATHER;
				Metamorph.unlockMetamorph("Feather Hair", doOutput);
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.FEATHER;
			}
	);

	public const HairGorgon:Transformation = new SimpleTransformation("Gorgon Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "Nothing seems to be happening, until you feel a tingling sensation atop your head.";

				if (player.hairLength == 0) {
					desc += " You run your fingers over it and feel small nubs growing quickly, becoming something akin to small ropes. After a moment, the growth stops and the nubs are gradually covered by scales.";
				} else {
					desc += "You run your fingers through your [hair], noticing a change in the texture. The strands are fusing together, becoming as thick as small ropes whilst being slowly covered by scales.";
					if (player.hairLength < 6) {
						desc += " Additionaly, its length seems to grow.";
						player.hairLength = 6;
					}
				}
				desc += "\n\nBut that's not all. At the end of each oversized strand, something is taking shape. Bringing one to your face, you watch as the rope-like strand covered in scales morphs into a somewhat cute snake, and you can somehow feel as the same happens to the other strands, now more than just hair. <b>Your hair has turned into snakes!</b>";

				if (doOutput) outputText(desc);

				player.hairType = Hair.GORGON;
				Metamorph.unlockMetamorph("Gorgon Hair", doOutput);
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.GORGON;
			}
	);

	public const HairSilky:Transformation = new SimpleTransformation("Silky Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "Something changes in your scalp, prompting you to pass a hand through it. To your surprise, your hair's texture is turning silky, far more than years of proper care would manage. The touch is so agreeable you can’t help but idly stroke your strands for a few more moments. <b>Your hair has taken on an unbelievably silky texture, just like that of an elf's!</b>";

				if (doOutput) outputText(desc);
				player.hairType = Hair.SILKEN;
				Metamorph.unlockMetamorph("Silky Hair", doOutput);
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.SILKEN;
			}
	);

	public const HairStorm:Transformation = new SimpleTransformation("Storm Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "A strange zapping sound is the only warning you receive before a weak shock runs through the back of your head. Irritated and confused, you bring a hand to the spot and rub it, only for a sudden electical noise to make itself known at the contact.\n\nKnowing for a fact that your hair shouldn't sound like that, or like anything at all for that matter, you bring both your hands to explore it and make note of several glowing strands shaped like stylized lightning bolts. There's even a single strand that floats just off the side of your face, refusing to stay down no matter how many times you try to reposition it. With a sigh, you give up on it, deciding that it's not really important to defeat your own hair. <b>You now have electrical raiju hair!</b>";

				if (doOutput) outputText(desc);
				player.hairType = Hair.STORM;
				Metamorph.unlockMetamorph("Storm Hair", doOutput);
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.STORM;
			}
	);

	public const HairBurning:Transformation = new SimpleTransformation("Burning Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.HairHuman, doOutput);

				desc += "Your head is suddenly attacked by warmth, as though it were right next to a campfire. Before you can wonder what's going on, your hair is set ablaze in an spectacular explosion. You very nearly have a panic attack before realizing you're not being harmed by the flames, which instead fade until they only cover your hair's tips.\n\nA few tests later, and you confirm that thankfully the flames don't seem to actually burn anything unless you will them to. <b>You now have burning hellcat hair!</b>";

				if (doOutput) outputText(desc);
				player.hairType = Hair.BURNING;
				Metamorph.unlockMetamorph("Burning Hair", doOutput);
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.BURNING;
			}
	);

	public const HairSnowy:Transformation = new SimpleTransformation("Snowy Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

        if (rand(3) == 0) player.hairColor = "snow white";
        else {
            if (rand(2) == 0) player.hairColor = "silver white";
            else player.hairColor = "platinum blonde";
        }

				desc += "The feeling of your hair against your skin suddenly changes and it is now cold against you. You notice wisps of snow sometime fallindown past your face and straining your eyes to look up you can see them slowly drifting down from your long snowy white hair.";

				if (player.hairLength < 25) player.hairLength = 25;

				if (doOutput) outputText(desc);
				player.hairType = Hair.SNOWY;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.SNOWY;
			}
	);

	public const HairLeaf:Transformation = new SimpleTransformation("Leaf Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "Your [hair] begins to fall out in globs, eventually leaving you with a bald head. Your head is not left bald for long, though. Within moments, a full head of leaf sprouts from the skin of your scalp. You run your hands through your new growth, sighing at the pleasure of being able to feel each individual leaf. <b>Thin leaves replaced your hair!</b>";

				if (doOutput) outputText(desc);
				player.hairType = Hair.LEAF;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.LEAF;
			}
	);

	public const HairGrass:Transformation = new SimpleTransformation("Grass Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "Your [hair] begins to fall out in clumps, eventually leaving your scalp completely bald. Although, thankfully, it does not remain like that for long. Within moments a full head of grass sprouts from the skin of your scalp, protecting it from the chilly wind which was starting to annoy you.  You run your hands through your newly grown hair-like grass, stifling a moan at how sensitive the thousands of long, soft and leafy blades that replaced your hair are. <b>Your hair has been replaced by grass, your scalp is now covered with soft blades of verdant greenery.</b>";

				if (doOutput) outputText(desc);
				player.hairType = Hair.GRASS;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.GRASS;
			}
	);

	public const HairGoo:Transformation = new SimpleTransformation("Goo Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";
        if (player.hairLength <= 0) {
            desc += "Your head buzzes pleasantly, feeling suddenly hot and wet.  You instinctively reach up to feel the source of your wetness, and discover you've grown some kind of gooey hair.  From time to time it drips, running down your back to the crack of your [butt].";
        } else {
            if (player.hairColor.indexOf("rubbery") == -1 && player.hairColor.indexOf("latex-textured") == -1) {
                desc += "Your head buzzes pleasantly, feeling suddenly hot and wet.  You instinctively reach up to feel the source of your wetness, and discover your hair has become a slippery, gooey mess.  From time to time it drips, running down your back to the crack of your [butt].";
            }
            //Latexy stuff
            else {
                desc += "Your oddly inorganic hair shifts, becoming partly molten as rivulets of liquid material roll down your back.  How strange.";
            }
        }
        if (player.hairColor != "green" && player.hairColor != "purple" && player.hairColor != "blue" && player.hairColor != "cerulean" && player.hairColor != "emerald") {
        		player.hairColor = player.skin.base.color;
            desc += " Stranger still, the hue of your semi-liquid hair changes to " + player.hairColor + ".";
        }

				if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) {
            desc += "  <b>(Your hair has stopped growing.)</b>";
						flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 1;
        }

        player.hairLength = 5;

				if (doOutput) outputText(desc);
				player.hairType = Hair.GOO;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.GOO;
			}
	);

	public const HairGhost:Transformation = new SimpleTransformation("Ghost Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "A sensation of weightlessness assaults your scalp. You reach up and grab a handful of hair, confused. Your perplexion only heightens when you actually feel the follicles becoming lighter in your grasp, before you can hardly tell you're holding anything. Plucking a strand, you hold it up before you, surprised to see... it's completely transparent! You have transparent hair!";

				if (doOutput) outputText(desc);
				player.hairType = Hair.GHOST;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.GHOST;
			}
	);

	public const HairRatatoskr:Transformation = new SimpleTransformation("Ratatoskr Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "You feel an itch in your hair and frustratedly go check on what is going on. To your surprise your hair took on a striped pattern" + " <b>like those of a ratatoskr.</b>";

        player.hairLength = 1;

				if (doOutput) outputText(desc);
				player.hairType = Hair.RATATOSKR;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.RATATOSKR;
			}
	);

	public const HairWindswept:Transformation = new SimpleTransformation("Windswept Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "The sharp winds of your aura suddenly blow into your hair, some of the strands being cut clean. To your absolute surprise when you look them up your hair has now taken on a shape more fit to hang around without encumbering you when in the middle of a windstorm, helping your aerodynamism. <b>You now have windswept hair!</b>";

        player.hairLength = 1;

				if (doOutput) outputText(desc);
				player.hairType = Hair.WINDSWEPT;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.WINDSWEPT;
			}
	);

	public const HairAnemone:Transformation = new SimpleTransformation("Anemone Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "Your balance slides way off, and you plop down on the ground as mass concentrates on your head. Reaching up, you give a little shriekas you feel a disturbingly thick, squirming thing where your hair should be. Pulling it down in front of your eyes, you notice it's still attached toyour head; what's more, it's the same color as your hair used to be. <b>You now have squirming tentacles in place of hair!</b>  As you gaze at it, agentle heat starts to suffuse your hand. The tentacles must be developing their characteristic stingers!  You quickly let go; you'll have to take care tokeep them from rubbing on your skin at all hours. On the other hand, they're quite short and you find you can now flex and extend them as you would anyother muscle, so that shouldn't be too hard. You settle on a daring, windswept look for now.";

				if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) {
            desc += "  <b>(Your hair has stopped growing.)</b>";
						flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 1;
        }

				player.hairLength = 5;

				if (doOutput) outputText(desc);
				player.hairType = Hair.ANEMONE;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.ANEMONE;
			}
	);

	public const HairFluffy:Transformation = new SimpleTransformation("Fluffy Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "Your hair starts to grow longer and fluffier. It covers all sides of your head perfectly, like a furry helmet, keeping it warm. Only your face and neck are devoid of this hairy armor which still manage to look like a nice short haircut. While it looks like hair at first, touching it proves it to be like a very thick coat of fluff. You now have <b>yeti fluffy [haircolor] hair.</b>";

				if (doOutput) outputText(desc);
				player.hairType = Hair.FLUFFY;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.FLUFFY;
			}
	);

	public const HairCrazy:Transformation = new SimpleTransformation("Crazy Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "You feel as if electricity is running through you and responding to the static your hair distorts in all possible directions. When the statics drops your hair is permanently frozen in a new… spiked form? You've heard of hair curling, dropping flat and what not but naturally spiking up? <b>You won’t need to put gel in your hair anymore to look like some </b>";

        if (silly()) {
          desc += "<b>punk kid from an anime series</b>";
  	    } else {
          desc += "<b>weirdo</b>";
        }
        desc += "<b>, your hair naturally spikes up in a wild way which remind you of animal fur. </b>";

				if (doOutput) outputText(desc);
				player.hairType = Hair.CRAZY;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.CRAZY;
			}
	);

	public const HairPrismatic:Transformation = new SimpleTransformation("Prismatic Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "You feel your hair begin to slicken with a strange mucus as a fresh coating covers them. You move over to the puddle, gazing at your reflection as the light bounces into your eyes. \n\nYou strain briefly before looking upon your reflection once more. Your hair now glows with a vibrant, multicolored hue, with every color in the spectrum. The prismatic beauty is quite the sight, though your hair remains slick as if you've recently gelled it. Still they turn to [haircolor] toward the root like your old human hair. <b>Your hair is now prismatic!</b>";

				if (doOutput) outputText(desc);
				player.hairType = Hair.PRISMATIC;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.PRISMATIC;
			}
	);

	public const HairQuill:Transformation = new SimpleTransformation("Quill Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "Your scalp begins to tingle as your hair falls out in clumps, leaving you with a bald head. You aren’t bald for long, though. An uncomfortable pressure racks the entirety of your scalp as hard quills begin to sprout from your hair pores. Their growth stops as they reach shoulder length. <b>You now have quills in place of your hair!</b>";

				if (doOutput) outputText(desc);
				player.hairType = Hair.QUILL;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.QUILL;
			}
	);

	public const HairFairy:Transformation = new SimpleTransformation("Fairy Hair",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (doOutput) outputText(desc);
				player.hairType = Hair.FAIRY;
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.FAIRY;
			}
	);


	/***
	 *    ███████  █████   ██████ ███████
	 *    ██      ██   ██ ██      ██
	 *    █████   ███████ ██      █████
	 *    ██      ██   ██ ██      ██
	 *    ██      ██   ██  ██████ ███████
	 */
	public const FaceHuman:Transformation = new SimpleTransformation("Human Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You bring your hands to your [face] as a sudden agony sweeps over it. Through the pain, you can feel its shape changing, details shifting little by little with purpose. When you come back to your senses, you notice <b>you have a perfectly normal human face again!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.HUMAN;
				Metamorph.unlockMetamorph("Human Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.HUMAN;
			}
	);

	public const FaceHorse:Transformation = new SimpleTransformation("Horse Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (player.faceType == Face.DOG) desc += "Mind-numbing pain shatters through you as you feel your facial bones rearranging. You clutch at your face in agony as your skin crawls and shifts, your visage reshaping to replace your dog-like characteristics with those of a horse. <b>You now have a horse's face.</b>";
				else desc+= "Mind-numbing pain shatters through you as you feel your facial bones breaking and shifting. You clutch at yourself in agony as you feel your skin crawl and elongate under your fingers. Eventually the pain subsides, leaving you with a face that seamlessly blends human and equine features. <b>You have a very equine-looking face.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.HORSE;
				Metamorph.unlockMetamorph("Horse Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.HORSE;
			}
	);

	public const FaceDog:Transformation = new SimpleTransformation("Dog Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

        if (player.faceType == Face.HORSE) desc += "Your face is wracked with pain.  You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else.  <b>Your horse-like features rearrange to take on many canine aspects.</b>";
        else desc += "Your face is wracked with pain.  You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different.  You find a puddle to view your reflection...<b>your face is now a cross between human and canine features.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.DOG;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.DOG;
			}
	);

	public const FaceCowMinotaur:Transformation = new SimpleTransformation("Cow Minotaur Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "Your visage twists painfully, warping and crackling as your bones are molded into a new shape. Once it finishes, you reach up to touch it, and you discover that <b>you now have a bovine face!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.COW_MINOTAUR;
				Metamorph.unlockMetamorph("Cow Minotaur Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.COW_MINOTAUR;
			}
	);

	public const FaceSharkTeeth:Transformation = new SimpleTransformation("Shark Teeth Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "Your [face] explodes with agony, reshaping into a more human-like visage. You firmly grasp your mouth, an intense pain racking your oral cavity. Your gums shift around and the bones in your jaw reset. You blink a few times wondering what just happened. You move over to a puddle to catch sight of your reflection, and you are thoroughly surprised by what you see. A set of retractable shark fangs have grown in front of your normal teeth, and your face has elongated slightly to accommodate them! They even scare you a little.\n(Gain: 'Bite' special attack)";

				if (doOutput) outputText(desc);
				player.faceType = Face.SHARK_TEETH;
				Metamorph.unlockMetamorph("Shark Teeth Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.SHARK_TEETH;
			}
	);

	public const FaceSnakeFangs:Transformation = new SimpleTransformation("Snake Fangs Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Without warning, you feel your canine teeth jump almost an inch in size, clashing on your gums, cutting yourself quite badly. As you attempt to find a new way to close your mouth without dislocating your jaw, you notice that they are dripping with a bitter, khaki liquid. Watch out, and <b>try not to bite your tongue with your poisonous fangs!</b>";
				if (!Face.isHumanShaped(player.faceType)) desc += " As the change progresses, your [face] reshapes. The sensation is far more pleasant than teeth cutting into gums, and as the tingling transformation completes, <b>you've gained with a normal-looking, human visage.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.SNAKE_FANGS;
				Metamorph.unlockMetamorph("Snake Fangs Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.SNAKE_FANGS;
			}
	);

	public const FaceCat:Transformation = new SimpleTransformation("Cat Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";
				var choice: int = rand(3);

				if (choice == 0) desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different. You find a puddle to view your reflection and discover <b>your face is now a cross between human and feline features.</b>";
				else if (choice == 1) desc += "Mind-numbing pain courses through you as you feel your facial bones rearranging. You clutch at your face in agony as your skin crawls and shifts, your visage reshaping to replace your facial characteristics with those of a feline. <b>You now have an anthropomorphic cat-face.</b>";
				else desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else. <b>Your facial features rearrange to take on many feline aspects.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.CAT;
				Metamorph.unlockMetamorph("Cat Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.CAT;
			}
	);

	public const FaceCatCanines:Transformation = new SimpleTransformation("Cat Canines Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You purr at the change it gives you a cute look. <b>Your mouth is now filled with cat-like canines.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.CAT_CANINES;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.CAT_CANINES;
			}
	);

	public const FaceLizard:Transformation = new SimpleTransformation("Lizard Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Terrible agony wracks your [face] as bones crack and shift. Your jawbone rearranges while your cranium shortens. The changes seem to last forever; once they've finished, no time seems to have passed. Your fingers brush against your toothy snout as you get used to your new face. It seems <b>you have a toothy, reptilian visage now.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.LIZARD;
				Metamorph.unlockMetamorph("Lizard Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.LIZARD;
			}
	);

	public const FaceBunny:Transformation = new SimpleTransformation("Bunny Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You grunt as your [face] twists and reforms.  Even your teeth ache as their positions are rearranged to match some new, undetermined order. When the process finishes, <b>you're left with a bunny face complete with a constantly twitching nose and prominent buck-teeth.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.BUNNY;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.BUNNY;
			}
	);

	public const FaceKangaroo:Transformation = new SimpleTransformation("Kangaroo Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (player.faceType == Face.HUMAN || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.SHARK_TEETH || player.faceType == Face.BUNNY) desc += "The base of your nose suddenly hurts, as though someone were pinching and pulling at it.  As you shut your eyes against the pain and bring your hands to your face, you can feel your nose and palate shifting and elongating.  This continues for about twenty seconds as you stand there, quaking.  When the pain subsides, you run your hands all over your face; what you feel is a long muzzle sticking out, whiskered at the end and with a cleft lip under a pair of flat nostrils.  You open your eyes and receive confirmation. <b>You now have a kangaroo face!  Crikey!</b>";
        else desc += "Your nose tingles. As you focus your eyes toward the end of it, it twitches and shifts into a muzzle similar to a stretched-out rabbit's, complete with harelip and whiskers.  <b>You now have a kangaroo face!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.KANGAROO;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.KANGAROO;
			}
	);

	public const FaceSpiderFangs:Transformation = new SimpleTransformation("Spider Fangs Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "Tension builds within your upper gum, just above your canines. You open your mouth and prod at the affected area, pricking your finger on the sharpening tooth. It slides down while you're touching it, lengthening into a needle-like fang. You check the other side and confirm your suspicions. <b>You now have a pair of pointy spider-fangs, complete with their own venom!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.SPIDER_FANGS;
				if (player.tailRecharge < 5) player.tailRecharge = 5;
				Metamorph.unlockMetamorph("Spider Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.SPIDER_FANGS;
			}
	);

	public const FaceFox:Transformation = new SimpleTransformation("Fox Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Your face pinches and you clap your hands to it. Within seconds, your nose is poking through those hands, pushing them slightly to the side as new flesh and bone build and shift behind it, until it stops in a clearly defined, tapered, and familiar point you can see even without the aid of a mirror. <b>Looks like you now have a fox's face.</b>";
				if (silly()) desc += "  And they called you crazy...";

				if (doOutput) outputText(desc);
				player.faceType = Face.FOX;
				Metamorph.unlockMetamorph("Fox Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.FOX;
			}
	);

	public const FaceDragon:Transformation = new SimpleTransformation("Draconic Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You scream as your face is suddenly twisted; your facial bones begin rearranging themselves under your skin, restructuring into a long, narrow muzzle. Spikes of agony rip through your jaws as your teeth are brutally forced from your gums, giving you new rows of fangs - long, narrow and sharp. Your jawline begins to sprout strange growths; small spikes grow along the underside of your muzzle, giving you an increasingly inhuman visage.\n\nFinally, the pain dies down, and you look for a convenient puddle to examine your changed appearance.\n\nYour head has turned into a reptilian muzzle, with small barbs on the underside of the jaw. <b>You now have a dragon's face.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.DRAGON;
				Metamorph.unlockMetamorph("Draconic Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.DRAGON;
			}
	);

	public const FaceDragonFangs:Transformation = new SimpleTransformation("Draconic Fangs Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Sudden agony sweeps over your [face], your visage turning hideous as bones twist and your jawline shifts. The pain slowly vanishes, leaving you weeping into your fingers. When you pull your hands away you realize you've been left with a completely normal, human face. But then your tooth's suddenly hurt as they begin to change. Your canines getting sharper and more adapted to eating meat just like those of a dragon. <b>You now have dragon fangs.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.DRAGON_FANGS;
				Metamorph.unlockMetamorph("Draconic Fangs Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.DRAGON_FANGS;
			}
	);

	public const FaceRaccoonMask:Transformation = new SimpleTransformation("Raccoon Mask Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

        if (player.faceType == Face.HUMAN || player.faceType == Face.SHARK_TEETH || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.BUNNY) {
          desc += "A sudden wave of exhaustion passes over you, and your face goes partially numb around your eyes.  ";
          if (player.faceType == Face.SHARK_TEETH || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.BUNNY) {
              desc += "Your prominent teeth chatter noisily at first, then with diminishing violence, until you can no longer feel them jutting past the rest!  ";
          }
          desc += "Shaking your head a bit, you wait for your energy to return, then examine your appearance.  ";
          if (((player.skin.base.color == "ebony" || player.skin.base.color == "black") && !player.hasCoat()) || ((player.hairColor == "black" || player.hairColor == "midnight") && (player.hasFur() || player.hasScales()))) {
              desc += "Nothing seems different at first.  Strange... you look closer and discover a darker, mask-line outline on your already inky visage. Furthermore your canines have slightly alongated not unlike those of an animal. <b>You now have a barely-visible raccoon mask and sharp canines like those of a raccoon.</b>";
          } else desc += "A dark, almost black mask shades the " + player.skinFurScales() + " around your eyes and over the topmost portion of your nose, lending you a criminal air! Furthermore your canines have slightly alongated not unlike those of an animal. <b>You now have a raccoon mask and sharp canines like those of a raccoon!</b>";
     		}
     		else {
     		    desc += "A sudden migraine sweeps over you and you clutch your head in agony as your nose collapses back to human dimensions.  A worrying numb spot grows around your eyes, and you entertain several horrible premonitions until it passes as suddenly as it came.  Checking your reflection in your water barrel, you find ";
     		    //[(if black/midnight fur or if black scales)
     		    if (((player.hairColor == "black" || player.hairColor == "midnight") && (player.hasFur() || player.hasScales()))) desc += "your face apparently returned to normal shape, albeit still covered in " + player.skinFurScales() + ".  You look closer and discover a darker, mask-line outline on your already inky visage.  <b>You now have a barely-visible raccoon mask on your otherwise normal human face.</b>";
     		    else if ((player.skin.base.color == "ebony" || player.skin.base.color == "black") && (!player.hasCoat())) desc += "your face apparently returned to normal shape.  You look closer and discover a darker, mask-line outline on your already inky visage.  <b>You now have a barely-visible raccoon mask on your normal human face.</b>";
     		    else desc += "your face returned to human dimensions, but shaded by a black mask around the eyes and over the nose!  <b>You now have a humanoid face with a raccoon mask!</b>";
     		}

				if (doOutput) outputText(desc);
				player.faceType = Face.RACCOON_MASK;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.RACCOON_MASK;
			}
	);

	public const FaceRaccoon:Transformation = new SimpleTransformation("Raccoon Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Your face pinches with tension, and you rub the bridge of your nose to release it.  The action starts a miniature slide in your bone structure, and your nose extends out in front of you!  You shut your eyes, waiting for the sinus pressure to subside, and when you open them, a triangular, pointed snout dotted with whiskers and capped by a black nose greets you!  <b>You now have a raccoon's face!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.RACCOON;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.RACCOON;
			}
	);

	public const FaceBuckteeth:Transformation = new SimpleTransformation("Buckteeth Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

        desc += "Your teeth grind on their own, and you feel a strange, insistent pressure just under your nose.  As you open your mouth and run your tongue along them, you can feel ";
        if (player.faceType != Face.HUMAN) desc += "the sharp teeth receding and ";
        desc += "your incisors lengthening.  It's not long before they're twice as long as their neighbors and the obvious growth stops, but the pressure doesn't go away completely. Well, you now have rodent incisors and your face aches a tiny bit - wonder if they're going to keep growing? <b>Your mouth has taken on some rabbit-like characteristics!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.BUCKTEETH;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.BUCKTEETH;
			}
	);

	public const FaceMouse:Transformation = new SimpleTransformation("Mouse Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "A wave of light-headedness hits you, and you black out. In your unconsciousness, you dream of chewing - food, wood, cloth, paper, leather, even metal... whatever you can fit in your mouth, even if it doesn't taste like anything much.  For several minutes you just chew and chew your way through a parade of ordinary objects, savoring the texture of each one against your teeth, until finally you awaken. Your teeth work, feeling longer and more prominent than before, and you hunt up your reflection. <b>Your face has shifted to resemble a mouse's, down to the whiskers!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.MOUSE;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.MOUSE;
			}
	);

	public const FaceFerretMask:Transformation = new SimpleTransformation("Ferret Mask Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "A horrible itching begins to encompass the area around your eyes.  You grunt annoyedly, rubbing furiously at the afflicted area.  Once the feeling passes, you make your way to the nearest reflective surface to see if anything has changed.  Your suspicions are confirmed.  The [skinFurScales] around your eyes has darkened.  <b>You now have a ferret mask!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.FERRET_MASK;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.FERRET_MASK;
			}
	);

	public const FaceFerret:Transformation = new SimpleTransformation("Ferret Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You cry out in pain as the bones in your face begin to break and rearrange.  You rub your face furiously in an attempt to ease the pain, but to no avail.  As the sensations pass, you examine your face in a nearby puddle.  <b>You nearly gasp in shock at the sight of your new ferret face!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.FERRET;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.FERRET;
			}
	);

	public const FacePig:Transformation = new SimpleTransformation("Pig Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new pig face!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.PIG;
				Metamorph.unlockMetamorph("Pig Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.PIG;
			}
	);

	public const FaceBoar:Transformation = new SimpleTransformation("Boar Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. Your bottom teeth ache as well. What’s happening to you? As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new tusky boar face!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.BOAR;
				Metamorph.unlockMetamorph("Boar Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.BOAR;
			}
	);

	public const FaceRhino:Transformation = new SimpleTransformation("Rhino Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Your face suddenly goes numb. You begin to hear bone cracking as you vision suddenly shifts as you face stretches out and thickens. When your face is done growing you can see the edges of your elongated mouth and noise in the center of your field of vision. They barely impede your vision though. <b>You now have a rhino face.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.RHINO;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.RHINO;
			}
	);

	public const FaceEchidna:Transformation = new SimpleTransformation("Echidna Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You groan loudly as the bones in your face begin to reshape and rearrange. Most notable, you feel your mouth lengthening into a long, thin snout. <b>You now have an echidna face!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.ECHIDNA;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.ECHIDNA;
			}
	);

	public const FaceDeer:Transformation = new SimpleTransformation("Deer Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You feel a grinding noise from your jaw, and a massive pressure in your sinuses, as your cheeks pinch in, followed immediately by a pointing of the lower half of your face. You frantically (and gently) feel your face, discovering, to your surprise, that you’ve <b>gained the delicate facial features of a deer.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.DEER;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.DEER;
			}
	);

	public const FaceWolf:Transformation = new SimpleTransformation("Wolf Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting reforming into something... different, your screams turning into a howl as the change ends. You go to find a puddle in order to view your reflection...  <b>Your face looks like the one of a feral looking wolf composed of a maw jagged with threatening canines a wet muzzle and a animalistic tongue.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.WOLF;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.WOLF;
			}
	);

	public const FaceManticore:Transformation = new SimpleTransformation("Manticore Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "You feel your canines changing, elongating into sharp, dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You feel the need to roar like a lion, to show the world how ferocious you are. <b>Your mouth is now filled with dagger-like canines!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.MANTICORE;
				Metamorph.unlockMetamorph("Manticore Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.MANTICORE;
			}
	);

	public const FaceSalamanderFangs:Transformation = new SimpleTransformation("Salamander Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Your tooth's suddenly hurt as you feel them changing. Your canines getting sharper and more adapted to eating meat. <b>You now have fangs.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.SALAMANDER_FANGS;
				Metamorph.unlockMetamorph("Salamander Fangs Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.SALAMANDER_FANGS;
			}
	);

	public const FaceYetiFangs:Transformation = new SimpleTransformation("Yeti Fangs Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You feel your canines elongate and sharpen. Your mouth feels somewhat like a human one still, but when you feel your teeth with your tongue you discover that your canines have pretty much turned into proper fangs. <b>You now have yeti fangs.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.YETI_FANGS;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.YETI_FANGS;
			}
	);

	public const FaceOrca:Transformation = new SimpleTransformation("Orca Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Your nose starts to tingle, getting bigger and rounder as your facial features take on a bombed shape. Your nasal hole disappears entirely as you feel your mouth change, your dentition turning into pointed teeth fit for an orca. You go look at your reflection in the water to be sure, and discover your face is now similar in shape to that of a killer whale. Um… you could use a fish or two, you are getting pretty hungry. <b>Taking a bite out of fresh fish would be great with your new orca face.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.ORCA;
				Metamorph.unlockMetamorph("Orca Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.ORCA;
			}
	);

	public const FacePlantDragon:Transformation = new SimpleTransformation("Plant Dragon Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "The familiar tingle of transformation spreads across your face. Your ";
				if (player.hasMuzzle()) desc += "muzzle";
				else desc += "face";
				desc += " shifts into a vaguely triangular shape, something that would look at home on a predatory reptile...  or a dragon. You feel pride swell within you as you look at your reflection inh a puddle at your feet, your new look now resembles a majestic creature of the old myths. <b>Your face is now a dragonlike muzzle!</b>\n\n";

				if (doOutput) outputText(desc);
				player.faceType = Face.PLANT_DRAGON;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.PLANT_DRAGON;
			}
	);

	public const FaceDevilFangs:Transformation = new SimpleTransformation("Devil Fangs Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You feel your canines grow slightly longer to take on a sharp appearance like those of a beast. Perhaps not as long as you thought they would end up as but clearly they make your smile all the more fiendish. <b>You now have demonic fangs!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.DEVIL_FANGS;
				Metamorph.unlockMetamorph("Devil Fangs Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.DEVIL_FANGS;
			}
	);

	public const FaceOniTeeth:Transformation = new SimpleTransformation("Oni Teeth Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "You feel your canines changing, growing bigger and slightly sharper. Hey, you could pretend to be some kind of demon with that kind of mouth. <b>You now have oni canines.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.ONI_TEETH;
				Metamorph.unlockMetamorph("Oni Teeth Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.ONI_TEETH;
			}
	);

	public const FaceWeasel:Transformation = new SimpleTransformation("Weasel Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "You feel your two canines grow bigger and slightly sharper, not unlike those of a weasel or in your case a raiju. <b>You now have raiju canines.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.WEASEL;
				Metamorph.unlockMetamorph("Weasel Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.WEASEL;
			}
	);

	public const FaceVampire:Transformation = new SimpleTransformation("Vampire Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You yelp as a throbbing pain takes root in the sides of your mouth. You feel your canines grow longer as your throat grow dryer. You could go for some wine right now, with a bloody steak to top it off… maybe just the steak. Or just the blood, really. You aren’t picky. Really, it’s up to you whether just rip off some poor sod’s throat and drink straight from the tap or drink blood from a wineglass, what with <b>your new vampire fangs!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.VAMPIRE;
				Metamorph.unlockMetamorph("Vampire Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.VAMPIRE;
			}
	);

	public const FaceBucktooth:Transformation = new SimpleTransformation("Bucktooth Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "While you are busy laughing at the ridicule of this situation your bucktooth begin to pulse in accordance with your laughter growing almost to rabbit like size. You now have Jabberwocky buck tooths!";

				if (doOutput) outputText(desc);
				player.faceType = Face.BUCKTOOTH;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.BUCKTOOTH;
			}
	);

	public const FaceJabberwocky:Transformation = new SimpleTransformation("Jabberwocky Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "While you are busy laughing at the ridicule of this situation your bucktooth begin to pulse in accordance with your laughter growing almost to rabbit like size. You now have a Jabberwocky face!";

				if (doOutput) outputText(desc);
				player.faceType = Face.JABBERWOCKY;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.JABBERWOCKY;
			}
	);

	public const FaceRedPanda:Transformation = new SimpleTransformation("Red Panda Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Numbness comes to your cheekbones and jaw, while the rest of your head is overwhelmed by a tingling sensation. Every muscle on your face tenses and shifts, while the bones and tissue rearrange, radically changing the shape of your head. You have troubles breathing as the changes reach your nose, but you manage to see as it changes into an animalistic muzzle. You jaw joins it and your teeth sharpen a little, not to the point of being true menacing, but gaining unequivocally the shape of those belonging on a little carnivore.\n\nOnce you’re face and jaw has reshaped, fur covers the whole of your head. The soft sensation is quite pleasant. It has a russet-red coloration, that turns to white on your muzzle and cheeks. Small, rounded patches of white cover the area where your eyebrows were. <b>You now have a red-panda head!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.RED_PANDA;
				Metamorph.unlockMetamorph("Red Panda Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.RED_PANDA;
			}
	);

	public const FaceCheshire:Transformation = new SimpleTransformation("Cheshire Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";
				var choice: int = rand(3);

				TransformationUtils.applyTFIfNotPresent(transformations.FaceCat, doOutput);

				if (choice == 0) desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different. You find a puddle to view your reflection and discover <b>your face is now a cross between human and feline features.</b>";
				else if (choice == 1) desc += "Mind-numbing pain courses through you as you feel your facial bones rearranging. You clutch at your face in agony as your skin crawls and shifts, your visage reshaping to replace your facial characteristics with those of a feline. <b>You now have an anthropomorphic cat-face.</b>";
				else desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else. <b>Your facial features rearrange to take on many feline aspects.</b>";

				desc += "You suddenly feel like smiling. Why actually look so serious? Everything is easier if you take it with a smile and a laughter. Perhaps it's just you taking on that mentality or it's that weird wonderfruit you took but now you feel you could smile forever showing that wide grin of yours. <b>You now have a cheshire smile.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.CHESHIRE;
				Metamorph.unlockMetamorph("Cheshire Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.CHESHIRE;
			}
	);

	public const FaceCheshireSmile:Transformation = new SimpleTransformation("Cheshire Smile Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";
				var choice:int;

				TransformationUtils.applyTFIfNotPresent(transformations.FaceCatCanines, doOutput);

				desc += "You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You purr at the change it gives you a cute look. <b>Your mouth is now filled with Cat-like canines.</b>";

				desc += "You suddenly feel like smiling. Why actually look so serious? Everything is easier if you take it with a smile and a laughter. Perhaps it's just you taking on that mentality or it's that weird wonderfruit you took but now you feel you could smile forever showing that wide grin of yours. <b>You now have a cheshire smile.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.CHESHIRE_SMILE;
				Metamorph.unlockMetamorph("Cheshire Smile Face", doOutput);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.CHESHIRE_SMILE;
			}
	);

	public const FaceAvian:Transformation = new SimpleTransformation("Avian Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (doOutput) outputText(desc);
				player.faceType = Face.AVIAN;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.AVIAN;
			}
	);

	public const FaceWolfFangs:Transformation = new SimpleTransformation("Wolf Fangs Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (doOutput) outputText(desc);
				player.faceType = Face.WOLF_FANGS;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.WOLF_FANGS;
			}
	);

	public const FaceOrcFangs:Transformation = new SimpleTransformation("Orc Fangs Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "You feel your two lower canines grow bigger and slightly sharper, similar to those of a boar, or in your case, an orc. <b>You now have orc canines.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.ORC_FANGS;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.ORC_FANGS;
			}
	);

	public const FaceAnimalTeeth:Transformation = new SimpleTransformation("Animal Teeth Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

        desc += "You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. That said, your face remained relatively human even after the change. <b>Your mouth is now filled with sharp canines.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.ANIMAL_TOOTHS;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.ANIMAL_TOOTHS;
			}
	);

	public const FaceBear:Transformation = new SimpleTransformation("Bear Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Your nose start to tingle as your general face shape surge forward into a muzzle complete with sharp teeth. At first you though it was a dog face but after further examination conclude it has more in common with bears then canines. <b>You now have a bear face.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.BEAR;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.BEAR;
			}
	);

	public const FacePanda:Transformation = new SimpleTransformation("Panda Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Your nose start to tingle as your general face shape surge forward into a muzzle complete with sharp teeth. At first you though it was a dog face but after further examination conclude it has more in common with bears then canines. <b>You now have a panda face.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.PANDA;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.PANDA;
			}
	);

	public const FaceFireSnail:Transformation = new SimpleTransformation("Fire Snail Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Just as you though the whole sweating situation couldn't get worse you’re suddenly are assaulted by a spike of pleasure, your entire undercarriage feeling like one single sexual organ. You begin to drool and before you know it you’re constantly drooling from arousal and can't stop. You eventually manage to recover bodily motions but not exactly full control of the drooling which persist. <b>Guess you're stuck with a drooling mouth for a while.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.FIRE_SNAIL;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.FIRE_SNAIL;
			}
	);

	public const FaceGhost:Transformation = new SimpleTransformation("Ghost Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Your face slowly grows numb and stiff. The muscles in your face seem to pull and shift. As the numbness fades, you notice that your face is stuck in a permanent smile. You try to stop smiling but the muscles in your face refuse to budge. <b>People might be disturbed by your unsettling smile.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.GHOST;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.GHOST;
			}
	);

	public const FaceJiangshi:Transformation = new SimpleTransformation("Jiangshi Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (doOutput) outputText(desc);
				player.faceType = Face.JIANGSHI;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.JIANGSHI;
			}
	);

	public const FaceYukiOnna:Transformation = new SimpleTransformation("Yuki Onna Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Your lips go numb with cold for a moment and you can barely feel them. You raise your hands and poke at them finding that they are still there and slowly feeling trickles back into them. You examine them and find that they have turned pale blue in color, a sign of the cold nature you now possess, small fumes of cold air regularly escaping your lip.";

				if (doOutput) outputText(desc);
				player.faceType = Face.YUKI_ONNA;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.YUKI_ONNA;
			}
	);

	public const FaceKudere:Transformation = new SimpleTransformation("Kudere Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Hey, why do you even bother with those expressions? Your flat tone and emotionless face is the perfect armor against all the lust mongers out there. Let them guess whether you are aroused or not. Only your bodily movement can betray your hidden desires to mate or your anger now. <b>You now have an expressionless visage.";
        if (silly()) desc += "Card sharks would gladly sell their souls for a poker face as good as yours.";
        desc += "</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.KUDERE;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.KUDERE;
			}
	);

	public const FaceUshiOniOnna:Transformation = new SimpleTransformation("Ushi Oni/Onna Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You feel something under the skin around your eyes and in your mouth as they begin to burn, smoke coming out of it, from the bottom of your eyes, circling to the upper part. In your mouth your teeth make cracking noises as they remodel themselves. After the torturing experience you feel like <b>you've gained Ushi-" + player.mf("Oni", "Onna") + " fangs,</b> going to a barrel with water you see your face now has a strange tattoo around your eyes.";

				if (doOutput) outputText(desc);
				player.faceType = Face.USHI_ONI;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.USHI_ONI;
			}
	);

	public const FaceFairy:Transformation = new SimpleTransformation("Fairy Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (doOutput) outputText(desc);
				player.faceType = Face.FAIRY;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.FAIRY;
			}
	);

	public const FaceCrazy:Transformation = new SimpleTransformation("Crazy Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Thinking on it, you’re smart, small and smuggly. The whole idea makes you laugh uncontrollably. But hey seriously since you’re the superior genius around here, might as well flash these idiots an unsettling smile, heck just thinking about how stupid everyone else is makes you smirk constantly, halfway to laughter. Well they might call you crazy but once you bury these primitive fools in the ground they'll all be the crazy ones. <b>You’re now constantly flashing a crazy grin just like a gremlin.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.CRAZY;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.CRAZY;
			}
	);

	public const FaceSmug:Transformation = new SimpleTransformation("Smug Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "You suddenly feel pain in your mouth as if something had suddenly grown. At first you think nothing happened but after double checking you confirm that your buck teeth are slightly larger than normal. <b>Your face is now human save for your two buck teeth like those of a squirrel.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.SMUG;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.SMUG;
			}
	);

	public const FaceSquirrel:Transformation = new SimpleTransformation("Squirrel Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "A wave of lightheadedness hits you and you black out. In your unconsciousness, you dream of chewing - food, wood, cloth, paper, leather, even metal... whatever you can fit in your mouth, even if it doesn’t taste like anything though, what you dream most of is big hard nuts. For several minutes you just chew and chew your way through a parade of ordinary objects, savoring the texture of each one against your teeth, until finally you awaken. Your teeth work, feeling longer and more prominent than before, and you hunt up your reflection. <b>Your face has shifted to resemble a squirrel’s!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.SQUIRREL;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.SQUIRREL;
			}
	);

	public const FaceElf:Transformation = new SimpleTransformation("Elf Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You feel tingling across your visage as some small changes begin to happen to it. Curious, you go look down by the nearest pool of water and notice to your amazement that the general shape of your mouth has changed to be in perfect alignment! No tooth is misaligned and your disarming, innocent smile revealing pearlescent white teeth would melt the coldest of hearts.<b>Guess your face is more like that of an elf now.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.ELF;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.ELF;
			}
	);

	/***
	 *    ████████  ██████  ███    ██  ██████  ██    ██ ███████
	 *       ██    ██    ██ ████   ██ ██       ██    ██ ██
	 *       ██    ██    ██ ██ ██  ██ ██   ███ ██    ██ █████
	 *       ██    ██    ██ ██  ██ ██ ██    ██ ██    ██ ██
	 *       ██     ██████  ██   ████  ██████   ██████  ███████
	 *
	 *
	 */
	public const TongueHuman:Transformation = new SimpleTransformation("Human Tongue",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

	      desc += "You feel something strange with your tongue. When you pull it out to check what is going on, <b>you realize your tongue is perfectly human again!</b>";
	      player.tongue.type = Tongue.HUMAN;
				Metamorph.unlockMetamorph("Human Tongue", doOutput);
			},
			// is present
			function ():Boolean {
				return player.tongue.type === Tongue.HUMAN;
			}
	);

	public const TongueCat:Transformation = new SimpleTransformation("Cat Tongue",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

	      desc += "Your tongue suddenly feels weird. You try to stick it out to see what’s going on and discover it changed to look similar to the tongue of a cat. At least you will be able to groom yourself properly with <b>your new cat tongue.</b>";
	      player.tongue.type = Tongue.CAT;
				Metamorph.unlockMetamorph("Cat Tongue", doOutput);
			},
			// is present
			function ():Boolean {
				return player.tongue.type === Tongue.CAT;
			}
	);

	public const TongueElf:Transformation = new SimpleTransformation("Elf Tongue",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

	      TransformationUtils.applyTFIfNotPresent(transformations.HairHuman, doOutput);

	      desc += "Your throat starts to ache and your tongue tingles. You try to gasp for air, your eyes opening wide in surprise as the voice that exits your throat is entirely changed. Your words are notes, your sentence a melody. Your voice is like music to your ears and you realize it is because your body became closer to that of an elf, adapting even your tongue and voice. <b>You now have the beautiful voice of the elves.</b>";
	      player.tongue.type = Tongue.ELF;
				Metamorph.unlockMetamorph("Elf Tongue", doOutput);
			},
			// is present
			function ():Boolean {
				return player.tongue.type === Tongue.ELF;
			}
	);

	public const TongueDraconic:Transformation = new SimpleTransformation("Dragon Tongue",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

	      desc += "Your tongue suddenly falls out of your mouth and begins undulating as it grows longer. For a moment it swings wildly, completely out of control; but then settles down and you find you can control it at will, almost like a limb. You're able to stretch it to nearly 4 feet and retract it back into your mouth to the point it looks like a normal human tongue. <b>You now have a draconic tongue.</b>";
	      player.tongue.type = Tongue.DRACONIC;
				Metamorph.unlockMetamorph("Draconic Tongue", doOutput);
			},
			// is present
			function ():Boolean {
				return player.tongue.type === Tongue.DRACONIC;
			}
	);

	public const TongueSnake:Transformation = new SimpleTransformation("Snake Tongue",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

	      if (player.tongue.type == Tongue.HUMAN) desc += "Your taste-buds start aching as they swell to an uncomfortably large size. Trying to understand what in the world could have provoked such a reaction, you bring your hands up to your mouth, your tongue feeling like it's trying to push its way past your lips. The soreness stops and you stick out your tongue to try and see what would have made it feel the way it did. As soon as you stick your tongue out you realize that it sticks out much further than it did before, and now appears to have split at the end, creating a forked tip. The scents in the air are much more noticeable to you with your snake-like tongue.";
	      else desc += "Your inhuman tongue shortens, pulling tight in the very back of your throat. After a moment the bunched-up tongue-flesh begins to flatten out, then extend forwards. By the time the transformation has finished, your tongue has changed into a long, forked snake-tongue.";
	      player.tongue.type = Tongue.SNAKE;
				Metamorph.unlockMetamorph("Snake Tongue", doOutput);
			},
			// is present
			function ():Boolean {
				return player.tongue.type === Tongue.SNAKE;
			}
	);

	public const TongueDemonic:Transformation = new SimpleTransformation("Demonic Tongue",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

	      desc += "Your tongue tingles";
        if (player.tongue.type != Tongue.HUMAN) desc += ", thickening in your mouth until it feels more like your old human tongue, at least for the first few inches";
        desc += ". It bunches up inside you, and when you open up your mouth to release it, roughly two feet of tongue dangles out.  You find it easy to move and control, as natural as walking.  <b>You now have a long demon-tongue.</b>";

	      player.tongue.type = Tongue.DEMONIC;
				Metamorph.unlockMetamorph("Demonic Tongue", doOutput);
			},
			// is present
			function ():Boolean {
				return player.tongue.type === Tongue.DEMONIC;
			}
	);

	public const TongueRavenous:Transformation = new SimpleTransformation("Ravenous Tongue",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

	      desc += "";

	      player.tongue.type = Tongue.RAVENOUS_TONGUE;
			},
			// is present
			function ():Boolean {
				return player.tongue.type === Tongue.RAVENOUS_TONGUE;
			}
	);

	public const TongueCaveWyrm:Transformation = new SimpleTransformation("Cave Wyrm Tongue",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

	      desc += "Something change in your mouth and you feel like you are about to choke! You stick your tongue out and discover to your surprise that it now glows with a neon blue light. Furthermore it stick out way further then it should, just like a lizard. <b>You now have a neon blue lizard tongue that glow in the dark.</b>";

	      player.tongue.type = Tongue.CAVE_WYRM;
			},
			// is present
			function ():Boolean {
				return player.tongue.type === Tongue.CAVE_WYRM;
			}
	);

	public const TongueGhost:Transformation = new SimpleTransformation("Ghost Tongue",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

	      desc += "Your tongue tingles and feels heavy in your mouth. Your tongue slips out further than what is considered normal. Your tongue grows at least a foot in length, tapering to a point. It slowly becomes more transparent until you’re able to see right through it. <b>You now have a long transparent ghostly tongue.</b>";

	      player.tongue.type = Tongue.GHOST;
			},
			// is present
			function ():Boolean {
				return player.tongue.type === Tongue.GHOST;
			}
	);

	public const TongueRatatoskr:Transformation = new SimpleTransformation("Ratatoskr Tongue",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

	      desc += "Your tongue begins to feel stingy and dry, your throat too. You have difficulty speaking so you drink some water and try some basic pronunciation exercises. You find out to your absolute surprise you now have a talent with words and linguistics that you didn't use to, heck it's like the range and variety of sounds you can make just doubled. <b>Your skill with words just improved by leaps and bounds with your new Ratatoskr tongue.</b>";

	      player.tongue.type = Tongue.RATATOSKR;
			},
			// is present
			function ():Boolean {
				return player.tongue.type === Tongue.RATATOSKR;
			}
	);

	public const TongueMelkie:Transformation = new SimpleTransformation("Melkie Tongue",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

	      desc += "Your throat starts to ache and your tongue tingles. You try to gasp for air, your eyes opening wide in surprise as your voice exit your throat entirely changed. Your words are notes, your sentence a melody. Your voice is like music to your ears and you realise it is because your body became closer to that of a Melkie adapting even your tongue and voice. Well you could always go sit on a rock and sing in case some sailor came by. <b>You now have the mermaid like voice of a Melkie.</b>";

	      player.tongue.type = Tongue.MELKIE;
        player.createPerk(PerkLib.MelkieSong, 0, 0, 0, 0);
			},
			// is present
			function ():Boolean {
				return player.tongue.type === Tongue.MELKIE;
			}
	);

	/***
	 *    ███████  █████  ██████  ███████
	 *    ██      ██   ██ ██   ██ ██
	 *    █████   ███████ ██████  ███████
	 *    ██      ██   ██ ██   ██      ██
	 *    ███████ ██   ██ ██   ██ ███████
	 *
	 *
	 */
  public const EarsHuman: Transformation = new SimpleTransformation("Human Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Ouch, your head aches! It feels like your ears are being yanked out of your head, and when you reach up to hold your aching noggin, you find they've vanished! Swooning and wobbling with little sense of balance, you nearly fall a half-dozen times before <b>a pair of normal, human ears sprout from the sides of your head.</b> You had almost forgotten what human ears felt like!";
          player.ears.type = Ears.HUMAN;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Human Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.HUMAN;
      }
  );

  public const EarsLion: Transformation = new SimpleTransformation("Lion Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

					if (player.ears.type == Ears.HUMAN) {
						if (rand(3) == 0) desc += "The skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head. They shift and elongate a little, fur growing on them as they become feline in nature. <b>You now have lion ears.</b>";
						else if (rand(3) == 1) desc += "Your ears begin to tingle. You reach up with one hand and gently rub them. They appear to be growing fur. Within a few moments, they've migrated up to the top of your head and increased in size. The tingling stops and you find yourself hearing noises in a whole new way. <b>You now have lion ears.</b>";
						else desc += "Your ears suddenly stretch painfully, making you scream in pain as they move toward the top of your head, growing rounder and bigger. Putting your hands to your ears you discover they are now covered with a fair amount of dark fur. <b>You now have lion ears.</b>";
					} else {
						if (rand(2) == 0) desc += "Your ears change shape, morphing into round, feline ears not unlike those of a lion!  They swivel about reflexively as you adjust to them.  <b>You now have lion ears.</b>";
						else desc += "Your ears tingle and begin to change shape. Within a few moments, they've become long and feline.  Thanks to the new fuzzy organs, you find yourself able to hear things that eluded your notice up until now. <b>You now have lion ears.</b>";
					}

          player.ears.type = Ears.LION;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Lion Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.LION;
      }
  );

  public const EarsDisplacer: Transformation = new SimpleTransformation("Displacer Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Your ears begin to prickle and burn as the skin tears and stretches migrating to the top of your head as they change into long wide, deep ears, perfect for catching any stray sound. Which becomes apparent when your hearing becomes far more clear than it has ever been. <b>Sound has become an entirely new experience now that you have displacer beast ears!</b>";
          player.coatColor = "midnight";
          player.ears.type = Ears.DISPLACER;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Displacer Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.DISPLACER;
      }
  );

  public const EarsCat: Transformation = new SimpleTransformation("Cat Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          if (player.ears.type == Ears.HUMAN) {
              if (rand(2) == 0) desc += "The skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head. They shift and elongate a little, fur growing on them as they become feline in nature. <b>You now have cat ears.</b>";
              else desc += "Your ears begin to tingle. You reach up with one hand and gently rub them. They appear to be growing fur. Within a few moments, they've migrated up to the top of your head and increased in size. The tingling stops and you find yourself hearing noises in a whole new way. <b>You now have cat ears.</b>";
          } else {
              if (rand(2) == 0) desc += "Your ears change shape, morphing into pointed, feline ears! They swivel about reflexively as you adjust to them. <b>You now have cat ears.</b>";
              else desc += "Your ears tingle and begin to change shape. Within a few moments, they've become long and feline. Thanks to the new fuzzy organs, you find yourself able to hear things that eluded your notice up until now. <b>You now have cat ears.</b>";
          }
          player.ears.type = Ears.CAT;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Cat Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.CAT;
      }
  );

  public const EarsRedPanda: Transformation = new SimpleTransformation("RedPanda Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

					if (flags[kFLAGS.MINO_CHEF_TALKED_RED_RIVER_ROOT] > 0) desc+= "The warned dizziness";
          else desc += "A sudden dizziness";

          desc += " seems to overcome your head. Your ears tingle, and you’re sure you can feel the flesh on them shifting, as you gradually have trouble hearing. A couple of minutes later the feeling stops. Curious of what has changed you go to check yourself on the stream, only to find that they’ve changed into cute, triangular ears, covered with white fur. <b>You’ve got red-panda ears!</b>";
          player.ears.type = Ears.RED_PANDA;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Red_panda Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.RED_PANDA;
      }
  );

  public const EarsHorse: Transformation = new SimpleTransformation("Horse Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

					if (player.ears.type == -1) desc += "Two painful lumps sprout on the top of your head, forming into tear-drop shaped ears, covered with short fur.  ";
          if (player.ears.type == Ears.HUMAN) desc += "Your ears tug painfully on your face as they begin shifting, moving upwards to the top of your head and transforming into a upright animalistic ears. ";
          if (player.ears.type == Ears.DOG) desc += "Your ears change shape, morphing into from their doglike shape into equine-like ears! ";
          else desc += "Your ears change shape, morphing into teardrop-shaped horse ears! ";
          desc += "<b>You now have horse ears.</b>";
          player.ears.type = Ears.HORSE;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Horse Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.HORSE;
      }
  );

  public const EarsPig: Transformation = new SimpleTransformation("Pig Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "You feel a pressure on your ears as they begin to reshape. Once the changes finish, you flick them about experimentally, <b>and you’re left with pointed, floppy pig ears.</b>";
          player.ears.type = Ears.PIG;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Pig Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.PIG;
      }
  );

  public const EarsVampire: Transformation = new SimpleTransformation("Vampire Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

					TransformationUtils.applyTFIfNotPresent(transformations.EarsHuman, doOutput);

          desc += "Your ears begin to prickle as they elongate to a point, being now reminiscent of those of elves, goblins, or in your case, vampires. Aside from looking cute, you find your new ears have drastically improved your hearing. <b>Sound has become an entirely new experience now that you have pointy vampire ears!</b>";

          player.ears.type = Ears.VAMPIRE;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Vampire Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.VAMPIRE;
      }
  );

  public const EarsBat: Transformation = new SimpleTransformation("Bat Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

					TransformationUtils.applyTFIfNotPresent(transformations.EarsHuman, doOutput);

          desc += "Your ears begin to prickle and burn as the skin tears and stretches, changing into wide, deep ears, perfect for catching any stray sound. Which becomes apparent when your hearing becomes far more clear than it has ever been. <b>Sound has become an entirely new experience now that you have bat ears!</b>";

          player.ears.type = Ears.BAT;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Bat Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.BAT;
      }
  );

  public const EarsWeasel: Transformation = new SimpleTransformation("Weasel Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          TransformationUtils.applyTFIfNotPresent(transformations.EarsHuman, doOutput);

					if (player.raijuScore() >= 5) {
						desc += "Your ears twitch as jolt of lightning flows through them, replacing all sound with crackling pops. You moan as the lightning arcs up to the top of your head before fanning out to the side. Hearing suddenly returns as you run your hands across your <b>new weasel ears!</b>";
					} else {
						desc += "Your ears suddenly stretch painfully, making you scream in pain as they move toward the top of your head, growing rounder and bigger. Putting your hands to your ears you discover they are now covered with a fair amount of dark fur. <b>You now have weasel ears.</b>";
					}

          player.ears.type = Ears.WEASEL;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Weasel Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.WEASEL;
      }
  );

  public const EarsOni: Transformation = new SimpleTransformation("Oni Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Your ears tingle slightly as their shape sharpen to a point not unlike those of some kind of demonic fiend. Still you know all too well those are <b>Oni ears.</b>";
          player.ears.type = Ears.ONI;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Oni Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.ONI;
      }
  );

  public const EarsElven: Transformation = new SimpleTransformation("Elven Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          TransformationUtils.applyTFIfNotPresent(transformations.EarsHuman, doOutput);

          desc += "Sounds become increasingly audible as a weird tingling runs through your scalp and your [hair] shifts slightly. You reach up to touch and bump <b>your new pointed elven ears.</b> The points are quite sensitive and you will have to get used to your new enhanced hearing ability.";
          player.ears.type = Ears.ELVEN;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Elven Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.ELVEN;
      }
  );

  public const EarsGoat: Transformation = new SimpleTransformation("Goat Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Your ears elongate and flatten on your head. You flap them a little and discover they have turned into something similar to the ears of a goat. <b>You now have goat ears!</b>";
          player.ears.type = Ears.GOAT;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Goat Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.GOAT;
      }
  );

  public const EarsCow: Transformation = new SimpleTransformation("Cow Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "You feel your ears tug on your scalp as they twist shape, becoming oblong and cow-like. <b>You now have [haircolor] cow ears.</b>";
          player.ears.type = Ears.COW;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Cow Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.COW;
      }
  );

  public const EarsDraconic: Transformation = new SimpleTransformation("Draconic Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "A prickling sensation suddenly fills your ears; unpleasant, but hardly painful. It grows and grows until you can't stand it any more, and reach up to scratch at them. To your surprise, you find them melting away like overheated candles. You panic as they fade into nothingness, leaving you momentarily deaf and dazed, stumbling around in confusion. Then, all of a sudden, hearing returns to you. Gratefully investigating, you find you now have a pair of reptilian ear-holes, one on either side of your head. A sudden pain strikes your temples, and you feel bony spikes bursting through the sides of your head, three on either side, which are quickly sheathed in folds of skin to resemble fins. With a little patience, you begin to adjust these fins just like ears to aid your hearing. <b>You now have dragon ears!</b>";
          player.ears.type = Ears.DRAGON;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Draconic Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.DRAGON;
      }
  );

  public const EarsSnake: Transformation = new SimpleTransformation("Snake Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "A weird tingling runs through your scalp as your [hair] shifts slightly. You reach up to touch and bump <b>your new pointed ears covered in small scales</b>. You bet they look cute!";
          player.ears.type = Ears.SNAKE;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Snake Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.SNAKE;
      }
  );

  public const EarsOrca: Transformation = new SimpleTransformation("Orca Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Your ears suddenly begin to lengthen, growing bigger and bigger until their length reaches your shoulders. When you examine them you discover they have grown into a pair of large fins, easily twice as big as your head. <b>Orienting yourself underwater will be easy with your large orca fin ears.</b>";

          player.ears.type = Ears.ORCA;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Orca Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.ORCA;
      }
  );

  public const EarsOrca2: Transformation = new SimpleTransformation("Orca Ears 2",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Tightness centers on your scalp, pulling your ears down from their normal, fleshy shape into small, fleshy bumps with holes in their centers.  <b>You have whales ears!</b>";

          player.ears.type = Ears.ORCA;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.ORCA;
      }
  );

  public const EarsLizard: Transformation = new SimpleTransformation("Lizard Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Tightness centers on your scalp, pulling your ears down from their normal, fleshy shape into small, scaley bumps with holes in their centers. <b>You have reptilian ears!</b>";
          player.ears.type = Ears.LIZARD;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Lizard Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.LIZARD;
      }
  );

  public const EarsFox: Transformation = new SimpleTransformation("Fox Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          if (player.ears.type == Ears.HUMAN || player.ears.type == Ears.ELFIN || player.ears.type == Ears.LIZARD) {
              desc += "The sides of your face painfully stretch as your ears elongate and begin to push past your hairline, toward the top of your head. They elongate, becoming large vulpine triangles covered in bushy fur. <b>You now have fox ears.</b>";
          } else {
              desc += "Your ears change, shifting from their current shape to become vulpine in nature. <b>You now have fox ears.</b>";
          }
          player.ears.type = Ears.FOX;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Fox Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.FOX;
      }
  );

  public const EarsElfin: Transformation = new SimpleTransformation("Elfin Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

					TransformationUtils.applyTFIfNotPresent(transformations.EarsHuman, doOutput);

          desc += "A weird tingling runs through your scalp as your [hair] shifts slightly. You reach up to touch and bump <b>your new pointed elfin ears</b>!";

					if (player.hasFur()) desc += " As you examine your new elfin ears you feel fur grow around them, matching the rest of you.";

          player.ears.type = Ears.ELFIN;
          if (doOutput) outputText(desc);
          Metamorph.unlockMetamorph("Elfin Ears", doOutput);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.ELFIN;
      }
  );

  public const EarsWolf: Transformation = new SimpleTransformation("Wolf Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "The skin on the sides of your face stretches painfully as your ears migrate upwards, toward the top of your head. They shift and elongate becoming lupine in nature. You won't have much trouble hearing through the howling blizzards of the glacial rift with <b>your new Lupine ears.</b>";

          player.ears.type = Ears.WOLF;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.WOLF;
      }
  );

  public const EarsDog: Transformation = new SimpleTransformation("Dog Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          if (player.ears.type == -1) desc += "Two painful nubs begin sprouting from your head, growing and opening into canine ears.  ";
          if (player.ears.type == Ears.HUMAN) desc += "The skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head.  They shift and elongate, becoming canine in nature. ";
          if (player.ears.type == Ears.HORSE) desc += "Your equine ears twist as they transform into canine versions. ";
          if (player.ears.type > Ears.DOG) desc += "Your ears transform, becoming more canine in appearance. ";
          desc += "<b>You now have dog ears.</b>";

          player.ears.type = Ears.DOG;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.DOG;
      }
  );

  public const EarsGremlin: Transformation = new SimpleTransformation("Gremlin Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Whoa, something messed up is going about with your ears. They migrate slowly up your head, elongating and distorting as they get covered in [haircolor] fur. When you go check what the hell happened to them you discover instead of human ears you now have a pair of cute animal ears up on your head. Well these sure will give you a cute look. <b>You now have gremlin ears!</b>";

          player.ears.type = Ears.GREMLIN;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.GREMLIN;
      }
  );

  public const EarsShark: Transformation = new SimpleTransformation("Shark Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          if (player.ears.type != Ears.HUMAN) {
            desc += "Your ears twitch once, twice, before starting to shake and tremble madly.  They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, fin like ears just like those of a shark girl.</b>";
          } else {
            desc += "A weird tingling runs through your scalp as your [hair] shifts slightly.  You reach up to touch and bump <b>your new pointed fin like ears just like those of a shark girl</b>.  You bet they look cute!";
          }

          player.ears.type = Ears.SHARK;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.SHARK;
      }
  );

  public const EarsCaveWyrm: Transformation = new SimpleTransformation("Cave Wyrm Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Your ears suddenly start to tingle. Strangely they change shape into something entirely different from what you would expect on a reptile covering in fur like those of cave wyrms. You can hear sound more acutely with your <b>new cave wyrm furry ears.</b>";

          player.ears.type = Ears.CAVE_WYRM;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.CAVE_WYRM;
      }
  );

  public const EarsBunny: Transformation = new SimpleTransformation("Bunny Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Your ears twitch and curl in on themselves, sliding around on the flesh of your head.  They grow warmer and warmer before they finally settle on the top of your head and unfurl into long, fluffy bunny-ears.  <b>You now have a pair of bunny ears.</b>";

          player.ears.type = Ears.BUNNY;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.BUNNY;
      }
  );

  public const EarsAvian: Transformation = new SimpleTransformation("Avian Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "You feel your ears twitching, and before you can realize, they recede on your body, leaving behind two holes, almost completely hidden by feathers and your [hair]. Fearing that most of your hearing range and ability was damaged or is blocked by the feathers, you test the sounds around your, and breathe on relief at the realization that your hearing is as good as always.";

          player.ears.type = Ears.AVIAN;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.AVIAN;
      }
  );

  public const EarsGryphon: Transformation = new SimpleTransformation("Gryphon Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "After another session under the statue magic, the lingering effects seem to having taken a toll on you, as your ears buzz. The sound turns worse for a second, and then vanish. You hear for a second a light flapping sound, and then, nothing.\n\nWhen everything seems to have finished, you realize that your hearing range has changed, and while your overall sense of hearing remains the same, pinpointing the source of a sounds is much easier. On a nearby reflection you discover the reason: two triangular ears have sprouted at your head, streamlined to flight and with a gryphon like appearance. A short layer of downy feathers covers them, the tip having a distinctive tuft. Checking that your ears are rightly placed on the new auricles, <b>you smile happily at the sight of your gryphon ears,</b> noting how well they compliment your looks.";

          player.ears.type = Ears.GRYPHON;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.GRYPHON;
      }
  );

  public const EarsKangaroo: Transformation = new SimpleTransformation("Kangaroo Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          if (player.ears.type == Ears.BUNNY) desc += "Your ears stiffen and shift to the sides!  You reach up and find them pointed outwards instead of up and down; they feel a bit wider now as well.  As you touch them, you can feel them swiveling in place in response to nearby sounds.  <b>You now have a pair of kangaroo ears!</b>";
          else desc += "Your ears twist painfully as though being yanked upwards and you clap your hands to your head.  Feeling them out, you discover them growing!  They stretch upwards, reaching past your fingertips, and then the tugging stops.  You cautiously feel along their lengths; they're long and stiff, but pointed outwards now, and they swivel around as you listen.  <b>You now have a pair of kangaroo ears!</b>";

          player.ears.type = Ears.KANGAROO;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.KANGAROO;
      }
  );

  public const EarsRaiju: Transformation = new SimpleTransformation("Raiju Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Your ears twitch as jolts of lightning flows through them, replacing all sound with crackling pops. You moan as the lightning arcs up to the top of your head before fanning out to the side. Hearing suddenly returns as you run your hands across your <b>new raiju ears!</b>";

          player.ears.type = Ears.RAIJU;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.RAIJU;
      }
  );

  public const EarsSquirrel: Transformation = new SimpleTransformation("Squirrel Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Your ears suddenly stretch painfully, making you scream in pain as they move towards the top of your head, growing bigger. Putting your hands to your ears you discover they are now covered with a fair amount of fur. <b>You now have squirrel ears.</b>";

          player.ears.type = Ears.SQUIRREL;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.SQUIRREL;
      }
  );

  public const EarsRaccoon: Transformation = new SimpleTransformation("Raccoon Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          if (player.ears.type == Ears.DOG || player.ears.type == Ears.BUNNY || player.ears.type == Ears.KANGAROO) desc += "Your ears compress, constricting your ear canal momentarily.  You shake your head to get sound back, and reach up to touch the auricles, to find a pair of stubby egg-shaped ears in their place.  <b>You now have raccoon ears!</b>";
          else if (player.ears.type == Ears.HORSE || player.ears.type == Ears.COW || player.ears.type == Ears.CAT) desc += "Your ears tingle.  Huh.  Do they feel a bit rounder at the tip now?  <b>Looks like you have raccoon ears.</b>";
          else desc += "Your ears prick and stretch uncomfortably, poking up through your [hair].  Covering them with your hands, you feel them shaping into little eggdrop ornaments resting atop your head.  <b>You have raccoon ears!</b>";

          player.ears.type = Ears.RACCOON;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.RACCOON;
      }
  );

  public const EarsMouse: Transformation = new SimpleTransformation("Mouse Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Your ears ";
          if (player.ears.type == Ears.HORSE || player.ears.type == Ears.COW || player.ears.type == Ears.DOG || player.ears.type == Ears.BUNNY || player.ears.type == Ears.KANGAROO) desc += "shrink suddenly";
          else desc += "pull away from your head";
          desc += ", like they're being pinched, and you can distinctly feel the auricles taking a rounded shape through the pain.  Reaching up to try and massage away their stings, <b>you're not terribly surprised when you find a pair of fuzzy mouse's ears poking through your [hair].</b>";

          player.ears.type = Ears.MOUSE;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.MOUSE;
      }
  );

  public const EarsFerret: Transformation = new SimpleTransformation("Ferret Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "You squint as you feel a change in your ears.  Inspecting your reflection in a nearby puddle you find that <b>your ears have become small, fuzzy, and rounded, just like a ferret’s!</b>";

          player.ears.type = Ears.FERRET;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.FERRET;
      }
  );

  public const EarsYeti: Transformation = new SimpleTransformation("Yeti Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "You feel your ears as though they’re growing bigger for a moment. It feels weird, but when you touch them to check what happened they still feel somewhat human. Looking down in a puddle you notice the term human isn’t correct, in your case they look more like those of a monkey. <b>You now have yeti ears.</b>";

          player.ears.type = Ears.YETI;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.YETI;
      }
  );

  public const EarsBear: Transformation = new SimpleTransformation("Bear Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Your ears begin to tingle. You reach up with one hand and gently rub them. They appear to be growing fur. Within a few moments, they’ve migrated up to the top of your head and increased in size, taking on a rounded shape. The tingling stops and you find yourself hearing noises in a whole new way. <b>You could pass for cute with your new bear ears.</b>";

          player.ears.type = Ears.BEAR;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.BEAR;
      }
  );

  public const EarsPanda: Transformation = new SimpleTransformation("Panda Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Your ears begin to tingle. You reach up with one hand and gently rub them. They appear to be growing fur. Within a few moments, they’ve migrated up to the top of your head and increased in size, taking on a rounded shape. The tingling stops and you find yourself hearing noises in a whole new way. <b>You could pass for cute with your new panda ears.</b>";

          player.ears.type = Ears.PANDA;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.PANDA;
      }
  );

  public const EarsMelkie: Transformation = new SimpleTransformation("Melkie Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "Your ears start feeling weird as they get longer and longer, eventually reaching your knees and covering with fur. These look like the ears of some sea rabbit or mammal, namely a Melkie. <b>You now have Melkie ears safeguarding your audition from the cold.</b>";

          player.ears.type = Ears.MELKIE;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.MELKIE;
      }
  );

  public const EarsDeer: Transformation = new SimpleTransformation("Deer Ears",
      // apply effect
      function(doOutput: Boolean): void {
          var desc: String = "";

          desc += "";

          player.ears.type = Ears.DEER;
          if (doOutput) outputText(desc);
      },
      // is present
      function(): Boolean {
          return player.ears.type === Ears.DEER;
      }
  );

	/***
	 *    ███████ ██    ██ ███████ ███████
	 *    ██       ██  ██  ██      ██
	 *    █████     ████   █████   ███████
	 *    ██         ██    ██           ██
	 *    ███████    ██    ███████ ███████
	 */
	public const EyesHuman:Transformation = new SimpleTransformation("Human Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (player.eyes.type == Eyes.BLACK_EYES_SAND_TRAP) {
					desc += "You feel a twinge in your eyes and you blink. It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.";
				}
				else {
					desc += "You blink and stumble, a wave of vertigo threatening to pull your [feet] from under you. As you steady and open your eyes, you realize something seems different. Your vision is changed somehow.";
					if (player.eyes.type == Eyes.SPIDER) desc += " Your multiple, arachnid eyes are gone!</b>";
					desc += " <b>You have normal, humanoid eyes again.</b>";
				}

				if (doOutput) outputText(desc);
				player.eyes.type = Eyes.HUMAN;
				Metamorph.unlockMetamorph("Human Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.HUMAN;
			}
	);

	public const EyesManticore:Transformation = new SimpleTransformation("Manticore Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["red"]), doOutput);

				desc += "For a moment your sight shifts as the ambient light suddenly turns extremely bright, almost blinding you. You walk around disoriented for a moment until the luminosity fades back to normal. You run to a puddle of water to check your reflection and quickly notice your pupils have become cat-like. While you do see way better in the dark, your red eyes are extremely intimidating and clearly don't belong on any normal feline. <b>You now have manticore eyes.</b>";

				if (doOutput) outputText(desc);
				player.eyes.type = Eyes.MANTICORE;
				Metamorph.unlockMetamorph("Manticore Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.MANTICORE;
			}
	);

	public const EyesInfernal:Transformation = new SimpleTransformation("Infernal Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["ember"]), doOutput);

				desc += "Warmth then rampage all around body altering your body. All of these pleasurable changes are driving you insane with pleasure to the point you would try to cry but just as soon as a tear pearls out of your eye it evaporates as two small flames leaks from their corners instead. <b>You now have infernal eyes.</b>";

				if (doOutput) outputText(desc);
				player.eyes.type = Eyes.INFERNAL;
				Metamorph.unlockMetamorph("Infernal Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.INFERNAL;
			}
	);

	public const EyesDisplacer:Transformation = new SimpleTransformation("Displacer Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["yellow"]), doOutput);

				desc += "For a moment your sight shifts as the ambient light suddenly turns extremely bright, almost blinding you. You walk around disoriented for a moment until the luminosity fades back to normal. You run to a puddle of water to check your reflection and quickly notice your eyes are now yellow and cat-like however just as you watch your reflection the white of your eyes also begins to darken turning black not unlike the eyes of a displacer beast. <b>You now have displacer beast eyes.</b>";

				if (doOutput) outputText(desc);
				player.eyes.type = Eyes.DISPLACER;
				Metamorph.unlockMetamorph("Displacer Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.DISPLACER;
			}
	);

	public const EyesCat:Transformation = new SimpleTransformation("Cat Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You blink and stumble, a wave of vertigo threatening to pull your [feet] from under you. As you steady and open your eyes, you realize something seems different. Your vision is changed somehow. <b>Your eyes have turned into those of cat with vertical slit.</b>";

				if (doOutput) outputText(desc);
				player.eyes.type = Eyes.CAT;
				Metamorph.unlockMetamorph("Cat Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.CAT;
			}
	);

	public const EyesOrc:Transformation = new SimpleTransformation("Orc Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["bloody red"]), doOutput);

				desc += "You blink and stumble, a wave of vertigo threatening to pull your [feet] from under you. As you steady yourself and open your eyes, you realize something seems different, as if the nerves have been optimized. Your vision has been changed somehow. <b>Your eyes has turned into those of orc.</b>";

				if (doOutput) outputText(desc);
				player.eyes.type = Eyes.ORC;
				Metamorph.unlockMetamorph("Orc Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.ORC;
			}
	);

	public const EyesVampire:Transformation = new SimpleTransformation("Vampire Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["blood-red"]), doOutput);

				desc += "Your eyes shift, causing sunlight to suddenly become annoyingly bright for you. It takes several minutes for your eyes to get used to it and, once they do, you still have to keep them half closed, so as to not be blinded by the sun’s glare.";
				desc += " Upon looking at your reflection in the water, you discover your irises have taken on a blood-red shade. <b>You have Vampire Eyes.</b>";

				if (doOutput) outputText(desc);
				player.eyes.type = Eyes.VAMPIRE;
				Metamorph.unlockMetamorph("Vampire Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.VAMPIRE;
			}
	);

	public const EyesRaiju:Transformation = new SimpleTransformation("Raiju Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["blue", "green", "teal"]), doOutput);

				desc += "Bright lights flash into your vision as your eyes glow with electric light. Blinded, you rapidly shake your head around, trying to clear your vision. It takes a moment, but your vision eventually returns to normal. Curious, you go over to a nearby puddle and find <b>glowing [eyecolor] bestial slitted eyes staring back at you.</b>";

				if (doOutput) outputText(desc);
				player.eyes.type = Eyes.RAIJU;
				Metamorph.unlockMetamorph("Raiju Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.RAIJU;
			}
	);

	public const EyesWeasel:Transformation = new SimpleTransformation("Weasel Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "A sudden gust of wind send sand into your face. Blinded, you rapidly shake your head around, trying to clear your vision. It takes a moment but your vision eventually returns to normal. Curious, you go over to a nearby puddle and find <b>[eyecolor] bestial slitted eyes staring back at you not unlike those of a weasel.</b>";

				if (doOutput) outputText(desc);
				player.eyes.type = Eyes.WEASEL;
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.RAIJU;
			}
	);

	public const EyesOni:Transformation = new SimpleTransformation("Oni Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesOniColors, doOutput);

				desc += "You feel something fundamental change in your sight when you go check yourself in a puddle you notice <b>your iris now have a slit at the center, giving them a fiendish outlook like an Oni.</b>";

				player.eyes.type = Eyes.ONI;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph("Oni Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.ONI;
			}
	);

	public const EyesElf:Transformation = new SimpleTransformation("Elf Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

				desc += "You blink and stumble, a wave of vertigo threatening to pull your feet out from under you. As you steady yourself and open your eyes, you realize something seems different. Your vision is changed somehow. Your pupils draw in light and the color and shapes seems more defined even at great distance. Your new eyes granting you better vision. You go to a puddle to check what happened to them and notice <b>your new eyes are like those of an elf’s with a vertical slit that reflects lights.</b>";

				player.eyes.type = Eyes.ELF;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph("Elf Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.ELF;
			}
	);

	public const EyesDevil:Transformation = new SimpleTransformation("Devil Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["ember"]), doOutput);

				desc += "Your eyes feels like they are burning. You try to soothe them, but to no avail. You endure the agony for a few minutes before it finally fades. You look at yourself in the nearest reflective surface and notice your eyes have taken on a demonic appearance: the sclera is black and the pupils ember. Furthermore they seem to glow with a faint inner light. <b>You now have fiendish eyes!</b>";

				player.eyes.type = Eyes.DEVIL;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph("Devil Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.DEVIL;
			}
	);

	public const EyesDraconic:Transformation = new SimpleTransformation("Draconic Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a dragon. <b>You now have dragon eyes!</b>.";

				player.eyes.type = Eyes.DRACONIC;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph("Draconic Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.DRACONIC;
			}
	);

	public const EyesGorgon:Transformation = new SimpleTransformation("Gorgon Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You blink and stumble, a wave of vertigo threatening to pull your [feet] from under you. As you steady and open your eyes, all seems to be fine until at least it seems so. But when moment later, when you casualy look at your hands pondering if there is any other effect the numbing sensation starts to spread starting from your hands fingers. Worried you focus your gaze at them to notice, that they typical texture becoming grey colored much similar to that of... stone? And slowy you realize the more you look at them, the faster change. Panicked for a moment you look away and then this numbing feeling starting to slowly receed. But looking back at them causing it to return. After moment, and closing eyelids, you conclude that your eyes must have gained an useful ability. <b>Your eyes has turned into gorgon eyes.</b>";

				player.eyes.type = Eyes.GORGON;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph("Gorgon Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.GORGON;
			}
	);

	public const EyesSnake:Transformation = new SimpleTransformation("Snake Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a snake. <b>You now have snake eyes!</b>.";

				player.eyes.type = Eyes.SNAKE;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph("Snake Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.SNAKE;
			}
	);

	public const EyesSpider:Transformation = new SimpleTransformation("Spider Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You suddenly get the strangest case of double vision. Stumbling and blinking around, you clutch at your face, but you draw your hands back when you poke yourself in the eye. Wait, those fingers were on your forehead! You tentatively run your fingertips across your forehead, not quite believing what you felt. <b>There's a pair of eyes on your forehead, positioned just above your normal ones!</b> This will take some getting used to!";

				player.eyes.type = Eyes.SPIDER;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph("Spider Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.SPIDER;
			}
	);

	public const EyesLizard:Transformation = new SimpleTransformation("Lizard Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["yellow"]), doOutput);

				desc += "You suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice <b>your eyes now have a slitted pupil like that of a reptile.</b>";

				player.eyes.type = Eyes.LIZARD;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph("Lizard Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.LIZARD;
			}
	);

	public const EyesFox:Transformation = new SimpleTransformation("Fox Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You blink for an instant as the light and darkness seems to shift within your vision. You head to a pool to check it up and notice your pupils shifted to look more fox-like in a fashion similar to the kitsunes. <b>You now have fox pupils.</b>";

				player.eyes.type = Eyes.FOX;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph("Fox Eyes", doOutput);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.FOX;
			}
	);

	public const EyesMonoeye:Transformation = new SimpleTransformation("Monoeye Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "";

				player.eyes.type = Eyes.MONOEYE;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.MONOEYE;
			}
	);

	public const EyesRatatoskr:Transformation = new SimpleTransformation("Ratatoskr Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesRatatoskrColors, doOutput);

				desc += "Geeze you know so much now it's like everyone around you is an idiot. How come they don't know about this and that is beyond you. <b>It's going to be hard to wipe away that somewhat permanent know it all smug expression from your face when you’re spreading words around your [eyecolor] eyes looking down teasingly on about everyone.</b>";

				player.eyes.type = Eyes.RATATOSKR;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.RATATOSKR;
			}
	);

	public const EyesKraken:Transformation = new SimpleTransformation("Kraken Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You feel something fundamental change in your sight when you go check yourself in a puddle you notice that <b>they now have horizontal slit like those of an octupus.</b>";

				player.eyes.type = Eyes.KRAKEN;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.KRAKEN;
			}
	);

	public const EyesFireSnail:Transformation = new SimpleTransformation("Fire Snail Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesFireSnailColors, doOutput);

				desc += "Something weird happens with your eyes as they suddenly begin to burn and tickle. After a while it stops and as you go check them up in a water puddle the first thing you notice is that your two irises now burn like two incandescent embers, just like those of a fiery creature. <b>Your irises are now incandescent.</b>";

				player.eyes.type = Eyes.FIRE_SNAIL;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.FIRE_SNAIL;
			}
	);

	public const EyesFenrir:Transformation = new SimpleTransformation("Fenrir Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["glacial blue"]), false);

				desc += "You feel an icy chill run through your body as your divine nature reasserts itself over your body. You won't escape your destiny as the Fenrir so easily, it seems.\n\nYou cry out in pain as your eyes once more freeze over, eventually settling back into their proper form. <b>You now have glowing icy eyes.</b>";

				player.eyes.type = Eyes.FENRIR;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.FENRIR;
			}
	);

	public const EyesDead:Transformation = new SimpleTransformation("Dead Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "";

				player.eyes.type = Eyes.DEAD;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.DEAD;
			}
	);

	public const EyesCaveWyrm:Transformation = new SimpleTransformation("Cave Wyrm Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["neon blue"]), false);

				desc += "Something shift in your eyes as the level of light around you seems to increase. You go to check on what happened and discover your pupils not only changed to reptilian slits but now glow with a neon blue light. Well seeing in the dark will be easy with your <b>new dark blue iris with reptilian neon blue pupils that glow in the dark.</b>";

				player.eyes.type = Eyes.CAVE_WYRM;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.CAVE_WYRM;
			}
	);

	public const EyesGryphon:Transformation = new SimpleTransformation("Gryphon Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["golden-orange"]), false);

				desc += "The mysterious energy coming from the statue continues adapting your body into a more fierce, strong shape. This time, it has affected you eyesight, as you suddenly notice how the long distances that you once had trouble seeing are clear as if you were in front of them, and that you can perceive even the minimal move even from several miles afar.\n\nChecking your changes on the river, you see clearly how your sclera has acquired a golden-orange coloration, as well as your outer iris, separated from the former by a thin circle of black. Both your pupil and your inner iris, which now has enlarged, are solid black. <b>Now you’ll have a blessed vision due those raptor, gryphon-like eyes.</b>";

				player.eyes.type = Eyes.GRYPHON;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.GRYPHON;
			}
	);

	public const EyesSandTrap:Transformation = new SimpleTransformation("Sand Trap Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["black"]), false);

				desc += "You blink, and then blink again.  It feels like something is irritating your eyes. Panic sets in as black suddenly blooms in the corner of your left eye and then your right, as if drops of ink were falling into them.  You calm yourself down with the thought that rubbing at your eyes will certainly make whatever is happening to them worse; through force of will you hold your hands behind your back and wait for the strange affliction to run its course. The strange inky substance pools over your entire vision before slowly fading, thankfully taking the irritation with it. As soon as it goes you stride quickly over to the stream and stare at your reflection. <b>Your pupils, your irises, your entire eye has turned a liquid black</b>, leaving you looking vaguely like the many half insect creatures which inhabit these lands. You find you are merely grateful the change apparently hasn't affected your vision.";

				player.eyes.type = Eyes.BLACK_EYES_SAND_TRAP;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.BLACK_EYES_SAND_TRAP;
			}
	);

	public const EyesHinezumi:Transformation = new SimpleTransformation("Hinezumi Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["blazing red"]), doOutput);

				desc += "Your eyes start to hurt and as a reaction, you start shedding tears. Once your vision clears, you head to a puddle to check what is going on. <b>To your surprise, it seems your irises turned blazing red like those of an Hinezumi.</b>";

				player.eyes.type = Eyes.HINEZUMI;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.HINEZUMI;
			}
	);

	public const EyesFrostwyrm:Transformation = new SimpleTransformation("Frostwyrm Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["yellow"]), doOutput);

				desc += "You suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil and black sclera like that of a frost wyrm. <b>You now have frost wyrm eyes!</b>.";

				player.eyes.type = Eyes.FROSTWYRM;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.FROSTWYRM;
			}
	);

	public const EyesGoat:Transformation = new SimpleTransformation("Goat Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["golden"]), doOutput);

				desc += "Your eyes feel like they are burning. You try to soothe them, but to no avail. You endure the agony for a few minutes before it finally fades. You look at yourself in the nearest reflective surface and notice your eyes have taken on a goat like appearance with horizontal pupils in the middle, the schlera turning back to white. <b>You now have eyes with horizontal pupils just like those of a goat!</b>";

				player.eyes.type = Eyes.GOAT;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.GOAT;
			}
	);

	public const EyesBear:Transformation = new SimpleTransformation("Bear Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["golden"]), doOutput);

				desc += "Your eyes begin to water for a moment. When your view clears up you move on to a puddle and notice their coloration changed to a golden brown hue not unlike those of a bears. <b>You now have golden bear eyes.</b>";

				player.eyes.type = Eyes.BEAR;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.BEAR;
			}
	);

	public const EyesCancer:Transformation = new SimpleTransformation("Cancer Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["orange"]), doOutput);

				desc += "A slight change happens in your eyes as they begin to water. You clear away the tears, going to a puddle to see what's going on. Your eyes look about the same, save for the fact that your irises now have the particular orange hue characteristic of cancers, with slightly larger pupils. Likely you won’t need to blink while underwater with <b>your orange cancer eyes.</b>";

				player.eyes.type = Eyes.CANCER;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.CANCER;
			}
	);

	public const EyesCentipede:Transformation = new SimpleTransformation("Centipede Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You feel a sudden wave of sadness come over you. You sulk, wanting to find some dank dark place to curl up and hide in. If anyone saw you now they would wonder why you appear so downtrodden. [if (silly) You could really use a hug and a tub of ice cream right now.] You vaguely register the feeling of your teeth sharpening. <b>Though saddened you suppose you could leave someone with a nasty bite with your new sharp teeth.</b>";

				player.eyes.type = Eyes.CENTIPEDE;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.CENTIPEDE;
			}
	);

	public const EyesGhost:Transformation = new SimpleTransformation("Ghost Eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Your vision becomes blurry, making it hard to see. You blink repeatedly, trying to clear your eyes. As your vision returns to normal, you notice that your surroundings appear sharper than normal. The shadows are as clear as day, though everything is tinted with a faint ethereal glow. You look in a puddle to see that your eyes glow an eerie [eyecolor]. <b>You now have glowing ghost eyes.</b>";

				player.eyes.type = Eyes.GHOST;
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.GHOST;
			}
	);

	// EYE COLORS
	public function EyesChangeColor(colors:/*String*/Array):Transformation {
		return new SimpleTransformation("Eye color: " + colors.join("|"),
				// apply effect
				function (doOutput:Boolean):void {
					var color:String = randomChoice(colors);
					player.eyes.colour = color;
					var desc: String = "";

					desc += "You feel something change around the upper half of your face, but you're not sure what. There doesn't seem to be much difference, but you should probably check it out the first chance you get. <b>Your eye color is now [eyecolor]!</b>";

					if (doOutput) outputText(desc);
				},
				// is present
				function ():Boolean {
					return InCollection(player.eyes.colour, colors);
				}
		)
	}

	public const EyesOniColors:Transformation = new SimpleTransformation("Oni Eye Colors",
			// apply effect
			function (doOutput:Boolean):void {
				transformations.EyesChangeColor(["red", "orange", "yellow", "green"]).applyEffect(doOutput);
			},
			// is present
			function ():Boolean {
				return InCollection(player.eyes.colour, ["red", "orange", "yellow", "green"]);
			}
	);

	public const EyesPlantColors:Transformation = new SimpleTransformation("Plant Eye Colors",
			// apply effect
			function (doOutput:Boolean):void {
				transformations.EyesChangeColor(["light purple", "green", "light green"]).applyEffect(doOutput);
			},
			// is present
			function ():Boolean {
				return InCollection(player.eyes.colour, ["light purple", "green", "light green"]);
			}
	);

	public const EyesGoblinColors:Transformation = new SimpleTransformation("Goblin Eye Colors",
			// apply effect
			function (doOutput:Boolean):void {
				transformations.EyesChangeColor(["red", "yellow", "purple", "orange"]).applyEffect(doOutput);
			},
			// is present
			function ():Boolean {
				return InCollection(player.eyes.colour, ["red", "yellow", "purple", "orange"]);
			}
	);

	public const EyesRaijuColors:Transformation = new SimpleTransformation("Raiju Eye Colors",
			// apply effect
			function (doOutput:Boolean):void {
				transformations.EyesChangeColor(["blue", "green", "turquoise"]).applyEffect(doOutput);
			},
			// is present
			function ():Boolean {
				return InCollection(player.eyes.colour, ["blue", "green", "turquoise"]);
			}
	);

	public const EyesKamaitachiColors:Transformation = new SimpleTransformation("Kamaitachi Eye Colors",
			// apply effect
			function (doOutput:Boolean):void {
				transformations.EyesChangeColor(["golden"]).applyEffect(doOutput);
			},
			// is present
			function ():Boolean {
				return InCollection(player.eyes.colour, ["golden"]);
			}
	);

	public const EyesRatatoskrColors:Transformation = new SimpleTransformation("Ratatoskr Eye Colors",
			// apply effect
			function (doOutput:Boolean):void {
				transformations.EyesChangeColor(["green","light green","emerald"]).applyEffect(doOutput);
			},
			// is present
			function ():Boolean {
				return InCollection(player.eyes.colour, ["green","light green","emerald"]);
			}
	);

	public const EyesRaccoonColors:Transformation = new SimpleTransformation("Raccoon Eye Colors",
			// apply effect
			function (doOutput:Boolean):void {
				transformations.EyesChangeColor(["golden"]).applyEffect(doOutput);
			},
			// is present
			function ():Boolean {
				return InCollection(player.eyes.colour, ["golden"]);
			}
	);

	public const EyesKrakenColors:Transformation = new SimpleTransformation("Kraken Eye Colors",
			// apply effect
			function (doOutput:Boolean):void {
				transformations.EyesChangeColor(["bright pink", "light purple", "purple"]).applyEffect(doOutput);
			},
			// is present
			function ():Boolean {
				return InCollection(player.eyes.colour, ["bright pink", "light purple", "purple"]);
			}
	);

	public const EyesSeadragonColors:Transformation = new SimpleTransformation("Seadragon Eye Colors",
			// apply effect
			function (doOutput:Boolean):void {
				transformations.EyesChangeColor(["orange", "yellow", "light green"]).applyEffect(doOutput);
			},
			// is present
			function ():Boolean {
				return InCollection(player.eyes.colour, ["orange", "yellow", "light green"]);
			}
	);

	public const EyesFireSnailColors:Transformation = new SimpleTransformation("Fire Snail Eye Colors",
			// apply effect
			function (doOutput:Boolean):void {
				transformations.EyesChangeColor(["red", "orange", "yellow"]).applyEffect(doOutput);
			},
			// is present
			function ():Boolean {
				return InCollection(player.eyes.colour, ["red", "orange", "yellow"]);
			}
	);

	public const EyesSpiderAndMutagenInt:Transformation = EyesSpider.copyWithExtraEffect(
			"Spider eyes + Mutagen Bonus INT",
			// extra effect
			function (doOutput:Boolean):void {
				MutagenBonus("int", 5);
			}
	);

	/***
	 *    ██      ███████  ██████  ███████
	 *    ██      ██      ██       ██
	 *    ██      █████   ██   ███ ███████
	 *    ██      ██      ██    ██      ██
	 *    ███████ ███████  ██████  ███████
	 */

	public const LegsHuman:Transformation = new SimpleTransformation("Human legs",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (player.isTaur()) desc += "Your quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of human legs</b>!";
				else if (player.isGoo()) desc += "Your lower body rushes inward, molding into two leg-like shapes that gradually stiffen up.  In moments they solidify into normal-looking legs, complete with regular, human feet.  <b>You now have normal feet!</b>";
				else if (player.isNaga()) desc += "You collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly where your new feet are forming.  <b>You have human legs again.</b>";
				else if (player.isScylla()) desc += "You collapse as your tentacle legs starts to merge.  The pain is immense, particularly where your new feet are forming.  <b>You have human legs again.</b>";
				else if (player.isAlraune()) {
					desc += "You suddenly lose all feeling from the waist down, your pitcher quickly withering and dying. Soon after it began, your pitcher is reduced to nothing but dust, leaving you to stand on two ordinary human legs. On the ground is all that is left of your flower, a single petal still intact that you proceed to put in your bag. Something tells you you will need it to become an alraune again.  <b>You have human legs again.</b>";
				} else if (player.isBiped()) desc += "You collapse as your legs shift and twist.  By the time the pain subsides, you notice that you have normal legs and normal feet.  <b>You now have normal feet!</b>";


				if (player.hasStatusEffect(StatusEffects.HydraTailsPlayer)) player.removeStatusEffect(StatusEffects.HydraTailsPlayer);
				if (doOutput) outputText(desc);
				setLowerBody(LowerBody.HUMAN);
				player.legCount = 2;
			},
			// is present
			function ():Boolean {
				return player.lowerBody === LowerBody.HUMAN && player.legCount === 2;
			}
	);
	public const LegsSpider:Transformation = new SimpleTransformation("Chitinous spider legs",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Starting at your [feet], a tingle runs up your [legs], not stopping until it reaches your thighs.  From the waist down, your strength completely deserts you, leaving you to fall hard on your [ass] in the dirt.  With nothing else to do, you look down, only to be mesmerized by the sight of black exoskeleton creeping up a perfectly human-looking calf.  It crests up your knee to envelop the joint in a many-faceted onyx coating.  Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton.  From a distance it would look almost like a black, thigh-high boot, but you know the truth.  <b>You now have human-like legs covered in a black, arachnid exoskeleton.</b>";

				setLowerBody(LowerBody.CHITINOUS_SPIDER_LEGS);
				if (doOutput) outputText(desc);
				player.legCount  = 2;
				player.coatColor = "black";
			},
			// is present
			function ():Boolean {
				return player.lowerBody === LowerBody.CHITINOUS_SPIDER_LEGS && player.legCount === 2;
			}
	);
	public const LegsAtlach:Transformation = new SimpleTransformation("Chitinous spider legs",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "Starting at your [feet], a tingle runs up your [legs], not stopping until it reaches your thighs.  From the waist down, your strength completely deserts you, leaving you to fall hard on your [ass] in the dirt.  With nothing else to do, you look down, only to be mesmerized by the sight of midnight purple exoskeleton creeping up a perfectly human-looking calf.  It crests up your knee to envelop the joint in a many-faceted onyx coating.  Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton.  From a distance it would look almost like a dark purple, thigh-high boot, but you know the truth.  <b>You now have human-like legs covered in a midnight purple, arachnid exoskeleton.</b>";

				if (doOutput) outputText(desc);
				setLowerBody(LowerBody.CHITINOUS_SPIDER_LEGS);
				player.legCount  = 2;
				player.coatColor = "midnight purple";
				player.coatColor2 = "midnight purple";
			},
			// is present
			function ():Boolean {
				return player.lowerBody === LowerBody.CHITINOUS_SPIDER_LEGS && player.legCount === 2;
			}
	);
	public const LegsAtlachNacha:Transformation = new SimpleTransformation("Atlach Nacha lower body",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					// No special text outside the event
				}
				setLowerBody(LowerBody.ATLACH_NACHA);
			},
			// is present
			function ():Boolean {
				return player.lowerBody === LowerBody.ATLACH_NACHA;
			}
	);

	/***
	 *    ██████  ███████  █████  ██████
	 *    ██   ██ ██      ██   ██ ██   ██
	 *    ██████  █████   ███████ ██████
	 *    ██   ██ ██      ██   ██ ██   ██
	 *    ██   ██ ███████ ██   ██ ██   ██
	 */


	public const RearAtlachNacha:Transformation = new SimpleTransformation("Atlach Nacha rear legs",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (player.rearBody.type !== RearBody.NONE) {
					var rear:EnumValue = RearBody.Types[player.rearBody.type];
					desc += "Your old " + rear.name + " " +	(rear.plural ? "are" : "is") + " drooping leaving your back as smooth and unbroken as the day you entered the portal. But this state did not last long. ";
				}

				desc += "Pressure is building in multiple spots on your upper back. You can’t help but groan with relief when finally the pressure peaks and many thick protrusions burst impatiently out of your [skin.type]. Four new chitinous limbs thrust their way into being, skittering aimlessly at the air as if to find purchase. After a moment of concentration you cause one of the spindly to rear around into your hand to take a closer look at it.It definitively looks like a spider leg except there's a set of red eyes at the end of the limb blinking back at you. <b>You now have two pairs of spider legs up your back.</b>";

				if (doOutput) outputText(desc);
				player.rearBody.type = RearBody.ATLACH_NACHA;
			},
			// is present
			function ():Boolean {
				return player.rearBody.type === RearBody.ATLACH_NACHA
			}
	);

	/***
	 *     █████  ██████  ███    ███ ███████
	 *    ██   ██ ██   ██ ████  ████ ██
	 *    ███████ ██████  ██ ████ ██ ███████
	 *    ██   ██ ██   ██ ██  ██  ██      ██
	 *    ██   ██ ██   ██ ██      ██ ███████
	 */


	public const ArmsHuman: Transformation = new SimpleTransformation("Human Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					switch (player.arms.type) {
						case Arms.WOLF:
						case Arms.FOX:
						case Arms.LION:
						case Arms.YETI:
						case Arms.DEVIL:
						case Arms.CAT:
						case Arms.BOAR:
						case Arms.BEAR:
						case Arms.RAIJU_PAWS:
							desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' [skin coat.color] fur is flaking away, leaving [skin base.type] behind. Also the claws on your fingers reverts back into ordinary nails.";
							break;
						case Arms.DISPLACER:
							desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' [skin coat.color] fur is flaking away, leaving [skin base.type] behind. Also the claws on your fingers reverts back into ordinary nails.\n\nYou feel highly uncomfortable as your extra set of arms vanishes into your body following the loss of your leonine paw hands. Guess your back with only two arms now.";
							break;
						case Arms.ELF:
						case Arms.KITSUNE:
						case Arms.ONI:
						case Arms.ORC:
						case Arms.RAIJU:
						case Arms.PIG:
						case Arms.YUKI_ONNA:
							desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' claws retracting back into ordinary nails. You hand looks human again.";
							break;
						case Arms.SHARK:
						case Arms.ORCA:
							desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' fin suddenly fell down, leaving [skin base.type] behind. Also webbing between your fingers slowly disappearing.";
							break;
						case Arms.PLANT:
						case Arms.PLANT2:
							desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' vines are withering. Leaves also falling donw, leaving [skin base.type] behind.";
							break;
						case Arms.SALAMANDER:
						case Arms.LIZARD:
						case Arms.DRACONIC:
						case Arms.HYDRA:
							desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' scales are flaking away. The leathery [skin coat.noadj] [skin coat.isare] soon gone, leaving [skin base.type] behind.";
							break;
						case Arms.BEE:
							desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' chitinous covering and fuzz is flaking away. The glossy black and yellow coating is soon gone, leaving [skin base.type] behind.";
							break;
						case Arms.MANTIS:
							desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' chitinous covering is flaking away and scythe shrinking until it vanish completly. The glossy green coating is soon gone, leaving [skin base.type] behind.";
							break;
						case Arms.SPIDER:
						case Arms.USHI_ONI:
							desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' chitinous covering is flaking away.  The glossy black coating is soon gone, leaving [skin base.type] behind.";
							break;
						case Arms.HARPY:
						case Arms.PHOENIX:
						case Arms.AVIAN:
							desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your feathery arms are shedding their feathery coating.  The wing-like shape your arms once had is gone in a matter of moments, leaving [skin] behind.";
							break;
						case Arms.GARGOYLE:
							desc += "You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form.";
							break;
						case Arms.BAT:
							desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your bones are breaking down and reforming in a frenzy. Your parchment-like skin begins to fall off in clumps, leaving the mess of malformed bones that are your arms right now naked for all to see. However, even as you watch, dark blood creeps over the bone, properly aligning them before healing them over, although not in their old form. Within seconds, your bones are remade into ones alike those you were born with, in structure if nothing else, the eldritch power of your blood finally ebbing away, but not before the last of it settles and turns into a brand new patch of skin.";
							break;
						default:
							desc += "You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form.";
							break;
					}
					desc += " You now have <b>human arms</b>!";

	        player.arms.type = Arms.HUMAN;
	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Human Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.HUMAN;
	    }
	);

	public const ArmsSphinx: Transformation = new SimpleTransformation("Sphinx Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        desc += "Your hands suddenly start to tingle as your arms grow a thin layer of -fur color- fur up to your shoulders. You watch, enthralled, as your nails fall off your fingers, feline claws taking their place on your five-fingered hands. That said, they don't look exactly like paws as your hands retain their dexterity and general appearance which is a perfect mix between human and leonine features. Thanks to their shape, your new bestial hands should not hinder your spellcasting abilities.. <b>Your arms are now covered in fur and end with clawed hands like those of a sphinx.</b>";
	        player.arms.type = Arms.SPHINX;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Sphinx Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.SPHINX;
	    }
	);

	public const ArmsLion: Transformation = new SimpleTransformation("Lion Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        desc += "Your hands suddenly start to hurt as your arms grows a thick coat of [skin coat.color] fur up to your shoulders where it turns [haircolor]. You watch enthralled as your nails fall off your fingers, feline claws taking their place on your now five-fingered paw-like hands. <b>You now have leonine paw hands.</b>";
	        player.arms.type = Arms.LION;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Lion Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.LION;
	    }
	);

	public const ArmsDisplacer: Transformation = new SimpleTransformation("Displacer Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        desc += "Something weird is happening around the level of your ribcage. Painfully large bumps start expanding on the side of your body. You fall on all fours panting heavily from the pain as two new limbs surge under your arms. As you sit, trying to grab these new limbs to check them out, you grab your arms instead. No wait your arm grabbed your arm that grabs another arm?! As you examine yourself you discover a second set of limbs grew under your arms. <b>Guess if your mind actually managed to process the action correctly you could actually use four weapons at once, instead you move around on your three set of limbs not unlike a displacer beast.</b>";
	        player.arms.type = Arms.DISPLACER;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Displacer Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.DISPLACER;
	    }
	);

	public const ArmsCat: Transformation = new SimpleTransformation("Cat Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        desc += "Your hands suddenly start to hurt as your arms grows a thick coat of [skin coat.color] fur up to your shoulders. You watch enthralled as your nails fall off your fingers, feline claws taking their place on your now five-fingered paw-like hands. <b>You now have cat paw hands.</b>";
	        player.arms.type = Arms.CAT;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Cat Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.CAT;
	    }
	);

	public const ArmsRedPanda: Transformation = new SimpleTransformation("Red Panda Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Weakness overcomes your arms, and no matter what you do, you can’t muster the strength to raise or move them. Sighing you attribute this to the consumption of that strange root. Sitting on the ground, you wait for the limpness to end. As you do so, you realize that the bones at your hands are changing, as well as the muscles on your arms. They’re soon covered, from the shoulders to the tip of your digits, on a layer of soft, fluffy black-brown fur. Your hands gain pink, padded paws where your palms were once, and your nails become short claws, not sharp enough to tear flesh, but nimble enough to make climbing and exploring much easier. <b>Your arms have become like those of a red-panda!</b>";
	        player.arms.type = Arms.RED_PANDA;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Red Panda Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.RED_PANDA;
	    }
	);

	public const ArmsOrc: Transformation = new SimpleTransformation("Orc Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        desc += "The skin on your arms feels as if they’re being cut open as a whole new set of intricate scar-like tattoos covers them. Furthermore your nails become increasingly pointed just like a set of claws and your arms in general grow a bit longer. Well, it seems you’re going to have some issues hiding your <b>scar tattooed arms and sharp nails.</b>";
	        player.arms.type = Arms.ORC;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Orc Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.ORC;
	    }
	);

	public const ArmsBoar: Transformation = new SimpleTransformation("Boar Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        desc += "Your arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive. Furthermore your nails become increasingly pointed turning black just like a set of claws. <b>You now have boar arms.</b>";
					player.skin.coat.color = player.hairColor;
	        player.arms.type = Arms.BOAR;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Boar Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.BOAR;
	    }
	);

	public const ArmsPig: Transformation = new SimpleTransformation("Pig Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        desc += "Your finguers starts to feels like some bee stungs them as they inflates to a more chubby sizes yours nails tickening and darkening turning into clover-like claws. Aside of your now fat finguers and darker claws your arms remains about the same. <b>You now have pig arms.</b>";
	        player.arms.type = Arms.PIG;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Pig Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.PIG;
	    }
	);

	public const ArmsBatWing: Transformation = new SimpleTransformation("Bat Wing Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        desc += "Large bones surge out of your wrists and elbows. You can feel your bones shifting and grinding all over your body as your skeletal structure begins changing into one more fit for a flyincreature, with light, hollow bones. You collapse to the ground as they begin shifting proportions, becoming thinner and longer to maximize area while reducing their density. Leathery flesh begins to cover your new bony protrusions, spreading between each of them like creeping moss. Eventually, the skin stops growing and you admire your new arms. They are very obviously winged bat arms. You close them around your waist, and like this they could easily be mistaken for a large cape when seen from afar. <b>You now have large winged bat arms.</b>";
	        player.arms.type = Arms.BAT;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Bat Wing Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.BAT;
	    }
	);

	public const ArmsRaijuPaws: Transformation = new SimpleTransformation("Raiju Paws Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        desc += "You shiver in delight as fur begins to form on your forearms, high voltage running along from your shoulders to your fingertips. Before you know it your hands turned to paws and your sharp nails to vicious looking claws coated with electricity. You can't wait to wrap those around a juicy cock or dip them into a waiting snatch.";
					if (player.coatColor == "") player.coatColor = player.hairColor;
	        player.arms.type = Arms.RAIJU_PAWS;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Raiju Paws Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.RAIJU_PAWS;
	    }
	);

	public const ArmsRaiju: Transformation = new SimpleTransformation("Raiju Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

					if (transformations.ArmsRaijuPaws.isPresent()) {
						desc += "Fur falls of your arms as your pawed hands revert back to human ones. Almost human ones actually as you nail retained their claw like sharpness.";
					} else {
						TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        	desc += "Your nails tingle as they elongate into white claws! They look quite dangerous, but you feel the strange need to use them to stimulate your ";
	        	if (player.gender == 1 || player.gender == 3) desc += "[cock]";
	        	if (player.gender == 3) desc += " and ";
	        	if (player.gender > 1) desc += "[clit]";
	        	desc += ". ";
	        	if (player.cor >= 50) desc += "You give a lusty smile, thinking that it wouldn't be so bad...";
	        	else desc += "You scowl, shaking away the impure thoughts.";
					}

	        player.arms.type = Arms.RAIJU;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Raiju Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.RAIJU;
	    }
	);

	public const ArmsOni: Transformation = new SimpleTransformation("Oni Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "";
	        if (player.arms.type != Arms.HUMAN) desc += "You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ";
	        desc += "The skin on your arms feels like it’s burning as a whole set of intricate warlike tattoos covers them. Furthermore your nails become increasingly pointed turning black just like a set of claws. Well it seems you will have issues hiding your <b>war tattooed arms with sharp nails.</b>";
	        player.arms.type = Arms.ONI;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Oni Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.ONI;
	    }
	);

	public const ArmsElf: Transformation = new SimpleTransformation("Elf Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        desc += "Something in your hands shift as they change taking on a more feminine fragile yet agile structure. You discover with surprise your dexterity has greatly increased allowing you to manipulate things in your delicate elven fingers with almost unreal precision. However your grip has become weaker as a result, weakening your ability to use raw force over finesse. <b>You now have delicate elven hands.</b>";
	        player.arms.type = Arms.ELF;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Elf Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.ELF;
	    }
	);

	public const ArmsMantis: Transformation = new SimpleTransformation("Mantis Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, turning the [skin.type] into a shiny green carapace.";
	        desc += "\nA moment later the pain fades and you are able to turn your gaze down to your beautiful new arms, covered in shining green chitin from the upper arm down.";
	        desc += "\nThe transformation end as down the lenght of your forearms you grow a pair of massive scythe like appendage just like a mantis.";
	        desc += "\nYou nonchalantly run them across a young tree slicing the plant trunk in half. This might prove a deadly weapon if used as part of your unarmed strikes. <b>You now have mantis arms.</b>";
	        player.arms.type = Arms.MANTIS;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Mantis Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.MANTIS;
	    }
	);

	public const ArmsDevil: Transformation = new SimpleTransformation("Devil Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your hands shapeshift as they cover in fur and morph into the clawed hands of some unknown beast. They retain their dexterity despite their weird shape and paw pads. At least this won't hinder spellcasting. <b>You now have bestial clawed hands!</b>";
	        player.arms.type = Arms.DEVIL;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Devil Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.DEVIL;
	    }
	);

	public const ArmsDraconic: Transformation = new SimpleTransformation("Draconic Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. After ignoring the sensation for a while, you finally glance down in irritation, only to discover that your arms had changed from it's former appearance to that of a draconic, one with leathery scales and short claws replacing your fingernails. <b>You now have a draconic arms.</b>";
	        player.arms.type = Arms.DRACONIC;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Draconic Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.DRACONIC;
	    }
	);

	public const ArmsOrca: Transformation = new SimpleTransformation("Orca Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your fingers suddenly are forced together. When you stretch them back you discover they are now webbed, ready for swimming. You are still examining your hands when something not unlike a pair of fins grow out of your forearms. <b>You can only guess those Orca arms will help you to swim at high speeds!</b>";
	        player.arms.type = Arms.ORCA;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Orca Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.ORCA;
	    }
	);

	public const ArmsPhoenix: Transformation = new SimpleTransformation("Phoenix Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "A crimson colored avian plumage starts to sprouts from your [skin.type], covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.";
	        player.arms.type = Arms.PHOENIX;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Phoenix Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.PHOENIX;
	    }
	);

	public const ArmsSalamander: Transformation = new SimpleTransformation("Salamander Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. After ignoring the sensation for a while, you finally glance down in irritation, only to discover that your arms had changed from it's former appearance to that of a salamander, one with leathery, red scales and short claws replacing your fingernails. <b>You now have a salamander arms.</b>";
	        player.arms.type = Arms.SALAMANDER;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Salamander Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.SALAMANDER;
	    }
	);

	public const ArmsShark: Transformation = new SimpleTransformation("Shark Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form with exception places between your finger which starting show signs to growing webbing. Soon after you start sweating profusely and panting loudly, feeling the space near your elbows shifting about. You hastily remove your [armor] just in time before a strange fin-like structure bursts from your forearms. You examine them carefully and make a few modifications to your [armor] to accommodate your new fins. <b>You now have shark arms.</b>";
	        player.arms.type = Arms.SHARK;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Shark Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.SHARK;
	    }
	);

	public const ArmsSpider: Transformation = new SimpleTransformation("Spider Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        if (player.arms.type == Arms.HARPY || player.arms.type == Arms.HUMAN) {
					if (player.arms.type == Arms.HARPY) desc += "The feathers covering your arms fall away, leaving them to return to a far more human appearance. You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a shiny black carapace</b>. You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
					} else {
						if (player.arms.type == Arms.BEE) desc += "The fizz covering your upper arms starting to fall down leaving only shiny black chitin clad arms.";
						else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRACONIC) desc += "The scales covering your upper arms starting to fall down leaving only shiny black chitin clad arms.";
						else if (player.arms.type == Arms.MANTIS) desc += "The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the [skinfurscales] into a shiny black carapace</b>.";
						else desc += "You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a shiny black carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
					}

					player.coatColor = "black";
	        player.arms.type = Arms.SPIDER;
	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Spider Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.SPIDER;
	    }
	);

	public const ArmsHarpy: Transformation = new SimpleTransformation("Harpy Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "An avian plumage sprouts from your [skin.type], covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.";
	        player.arms.type = Arms.HARPY;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Harpy Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.HARPY;
	    }
	);

	public const ArmsBee: Transformation = new SimpleTransformation("Bee Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "";
	        if (player.arms.type == Arms.SPIDER) desc += "On your upper arms slowly starting to grown yellow fuzz making them looks more like those of bee.";
	        else if (player.arms.type == Arms.MANTIS) desc += "The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>. Additionaly on your upper arms appear yellow fuzz.";
	        else {
	            if (player.arms.type == Arms.HARPY) desc += "The feathers covering your arms fall away, leaving them to return to a far more human appearance. ";
	            desc += "You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>. A moment later the pain fades and you are able to turn your gaze down to your beautiful new arms, covered in shining black chitin from the upper arm down, and downy yellow fuzz along your upper arm.";
	        }
	        player.arms.type = Arms.BEE;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Bee Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.BEE;
	    }
	);

	public const ArmsLizard: Transformation = new SimpleTransformation("Lizard Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. After ignoring the sensation for a while, you finally glance down in irritation, only to discover that your arms had changed from it's former appearance to that of a lizard, one with leathery scales and short claws replacing your fingernails. <b>You now have a lizard arms.</b>";
	        player.arms.type = Arms.LIZARD;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Lizard Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.LIZARD;
	    }
	);

	public const ArmsKitsune: Transformation = new SimpleTransformation("Kitsune Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        desc += "Your finger tingle as your nails sharpen to point. You run them on a tree bark and they feel way harder than your old human nails. <b>You will be able to claw at your opponent with your sharp kitsune nails.</b>";
	        player.arms.type = Arms.KITSUNE;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Kitsune Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.KITSUNE;
	    }
	);

	public const ArmsFox: Transformation = new SimpleTransformation("Fox Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	        desc += "Your arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into wolf like claws so no wonder you felt it that much. <b>You now have pawed hands.</b>";
	        player.arms.type = Arms.FOX;

	        if (doOutput) outputText(desc);
	        Metamorph.unlockMetamorph("Fox Arms", doOutput);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.FOX;
	    }
	);

	public const ArmsPlant: Transformation = new SimpleTransformation("Plant Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. Soon after you start feel something new tickling and crawling its way into being, this time on your shoulders, working its way down your arms.  Looking on them you can see a thin, delicate vines, with spade-shaped leaves unfolding from them as they curl snugly around your biceps and deltoids all the way down to your wrists. <b>You now have vine-covered arms.</b>";

					player.arms.type = Arms.PLANT;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.PLANT;
	    }
	);

	public const ArmsCentipede: Transformation = new SimpleTransformation("Centipede Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your arms feel strangely warm. You look down at them, noticing purple markings being etched into your skin. Your nails sharpen and take on the same purple hue. <b>You could do some serious damage with your sharp nails.</b>";

					player.arms.type = Arms.CENTIPEDE;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.CENTIPEDE;
	    }
	);

	public const ArmsWendigo: Transformation = new SimpleTransformation("Wendigo Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "";

					player.arms.type = Arms.WENDIGO;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.WENDIGO;
	    }
	);

	public const ArmsYukiOnna: Transformation = new SimpleTransformation("Yuki Onna Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Something weird happens in your hands. For a few seconds you lose the sense of touch and as it comes back your nails turn pale blue. You can feel terrible cold running at your fingertips.  While you can dismiss this cold and enable it at will you can’t help but smirk at your newfound ability. <b>Woe to whoever you decide to touch with your glacial hands.</b>";

					player.arms.type = Arms.YUKI_ONNA;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.YUKI_ONNA;
	    }
	);

	public const ArmsWolf: Transformation = new SimpleTransformation("Wolf Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into wolf like claws so no wonder you felt it that much. <b>You now have pawed hands.</b>";

					player.arms.type = Arms.WOLF;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.WOLF;
	    }
	);

	public const ArmsGoo: Transformation = new SimpleTransformation("Goo Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your arms become increasingly wet, as if they were sweating heavily, until eventually you're unsure whether or not they are even solid. The sweat clears up, turning to [skintone] slime. At first, it feels weird, because they are neither entirely solid or liquid, but the simple act of lengthening your limbs to ridiculous reach amuses you. Furthermore you can see right through your hands as if looking through water. Perhaps there's some use to your <b>new goo dripping arms.</b>";

					player.arms.type = Arms.GOO;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.GOO;
	    }
	);

	public const ArmsHydra: Transformation = new SimpleTransformation("Hydra Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn’t getting rid of the itch. After a longer moment of ignoring it you finally glance down in irritation, only to discover that your arms former appearance changed into that of a reptile with leathery scales and vicious claws replacing your fingernails. <b>You now have hydra arms.</b>";

					player.arms.type = Arms.HYDRA;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.HYDRA;
	    }
	);

	public const ArmsCaveWyrm: Transformation = new SimpleTransformation("Cave Wyrm Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. After ignoring the sensation for a while, you finally glance down in irritation, only to discover that your arms had changed from it's former appearance to that of a  cave wyrm, one with leathery, black scales and short claws replacing your fingernails. <b>You now have a cave wyrm arms.</b>";

					player.arms.type = Arms.CAVE_WYRM;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.CAVE_WYRM;
	    }
	);

	public const ArmsAvian: Transformation = new SimpleTransformation("Avian Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

          if (player.skin.hasChitin()) {
              desc += "Ughh, was that seed good for your body? You wince in pain, as some part of you is obviously not happy of being subjected to the fruit mysterious properties. As you direct your attention to your arms, you’re alarmed by their increasingly rigid feeling, and, to make things worse, the process continues, as the worrying sensation creeps up your arms until it reaches your shoulders. Soon, no matter how much you try, you aren’t able to move your arms in any way.";
              desc += "Just when you thought that nothing could feel worse, you see how the chitin on your arms fissures, falling to the ground like pieces of a broken vase and leaving a mellified tissue beneath. To you relief, the ‘jelly’ also fall, leaving only normal skin on your arms.";
              desc += "Then, a cloak of soft, " + player.skin.coat.color + ", colored feathers start sprouting from your armpits, covering every bare inch of skin up your elbows, stopping a few inches before your hands. When the growing stops, the skin over your hands changes too, turning into a layer of [skin], skin, albeit rougher than the usual, and made of thousands of diminutive scales. The structure of your palm and fingers remain the same, tough your fingernails turn into short talons.";
          } else if (player.hasFur()) {
              desc += "A bit weary about the possible effects of the seed on your body, you quickly notice when the fur covering your starts thickening, some patches merging an thickening, first forming barbs, and then straight-out feathers. To your surprise, your hand and forearms become strangely numb, and, to make things worse, the process continues, as the worrying sensation creeps up your arms until it reaches your shoulders. Soon, no matter how much you try, you aren’t able to move your arms in any way.";
              desc += "The newly formed feathers keep growing making the excess fur fall, until you’ve gained a cloak of soft, " + player.skin.coat.color + ", colored feathers start sprouting from your armpits, covering every bare inch of skin up your elbows, stopping a few inches before your hands. Once the effects on that area end, the fur over your hands changes too, falling quickly and leaving behind soft, bare skin, that quickly turns into a layer of [skin], skin, ";
              desc += "albeit rougher than the usual, made of thousands of diminutive scales. The structure of your palm and fingers remain the same, though your fingernails turn into short talons.";
          } else if (player.hasScales()) {
              desc += "Undoubtedly affected by the dry fruit reactives, the layer of scales covering your arms falls like snowflakes, leaving only a soft layer of [skin] behind. To your surprise, your hand and forearms become strangely numb, and, to make things worse, the process continues, as the worrying sensation creeps up your arms until it reaches your shoulders. Soon, no matter how much you try, you aren’t able to move your arms in any way.";
              desc += "Then, a cloak of soft, " + player.skin.coat.color + ", colored feathers start sprouting from your armpits, covering every bare inch of skin up your elbows, stopping a few inches before your hands. When the growing stops, the skin over your hands changes too, turning into a layer of [skin], skin, albeit rougher than the usual, and made of thousands of diminutive scales. The structure of your palm and fingers remain the same, though your fingernails turn into short talons.";
          } else {
              desc += "Just after finishing the fruit, your hand and forearms become strangely numb, and, to make things worse, the process continues, as the worrying sensation creeps up your arms until it reaches your shoulders. Soon, no matter how much you try, you aren’t able to move your arms in any way.";
              desc += "Then, a cloak of soft, " + player.skin.coat.color + ", colored feathers start sprouting from your armpits, covering every bare inch of skin up your elbows, stopping a few inches before your hands. When the growing stops, the skin over your hands changes too, turning into a layer of [skin], skin, albeit rougher than the usual, and made of thousands of diminutive scales. The structure of your palm and fingers remain the same, though your fingernails turn into short talons.";
          }
          desc += "Luckily, the sensation returns to your arms, and you’re able to use them with normalcy, with the difference that <b>they’re now avian looking ones!</b>.";

					player.arms.type = Arms.AVIAN;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.AVIAN;
	    }
	);

	public const ArmsGryphon: Transformation = new SimpleTransformation("Gryphon Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

          desc += "The skin on your arms change a bit, as the " + player.skin.coat.color2 + " turning into soft, feline fur. Your palms and fingers acquire pink paw pads, while at the end of each one of your fingers, the talons sharpen and become prehensile, adopting a posture better suited to pounce over a unsuspecting victim.";
          desc += "From the fringe on your elbows to your armpits, your " + player.skin.coat.color + " colored plumage remains the same. <b>At the end, you’ve gotten gryphon-like arms!</b>.";

					player.arms.type = Arms.GRYPHON;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.GRYPHON;
	    }
	);

	public const ArmsGhost: Transformation = new SimpleTransformation("Ghost Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "A numbing sensation crawls upwards from your hands to your elbows, lingering for a few moments. As the pain subsides, you see that your hands have become incorporeal! Panicking, you reach for your weapon, something to grasp and… surprisingly, you manage to hold it normally. After a few moments when you calm down, you drop it. It seems you need to take extra care when you hold things from now on, as <b>you have ghastly hands!</b>";

					player.arms.type = Arms.GHOST;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.GHOST;
	    }
	);

	public const ArmsGazer: Transformation = new SimpleTransformation("Gazer Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your arms begin to sweat and drip at high rate until they cover in some kind of oily ink black mucus. It drops from your hands down to the ground oozing like tar. You would say ew but for some reason it doesn't smell so bad, heck taking a whiff it almost smells like perfume or rather aphrodisiacs. Heck thinking on it now from a far glance it looks like you are wearing sleeved gloves. <b>Your arms are now covered from the forearm to the digits into tar like fluids.</b>";

					player.arms.type = Arms.GAZER;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.GAZER;
	    }
	);

	public const ArmsSquirrel: Transformation = new SimpleTransformation("Squirrel Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your nails tingle as they elongate into white claws. A coat of fur then begins to form up from your wrist to your elbows, coating your forearms like bracers. Your hands feels stronger in every way, heck <b>with these new claws you could just climb and stick to any surface just like a squirrel.</b>";

          if (player.coatColor == "") player.coatColor = player.hairColor;
					player.arms.type = Arms.SQUIRREL;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.SQUIRREL;
	    }
	);

	public const ArmsWeasel: Transformation = new SimpleTransformation("Weasel Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your arms begins cover with fur and you watch spellbound as your nails elongate into small sharp animal claws. They aren't exactly strong enough to deal damage but they'll be fine if you ever want to scratch yourself. <b>You now have furry animal arms with paw-like hands not unlike those of a weasel.</b>";

					if (player.coatColor == "") player.coatColor = player.hairColor;
					player.arms.type = Arms.WEASEL;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.WEASEL;
	    }
	);

	public const ArmsKamaitachi: Transformation = new SimpleTransformation("Kamaitachi Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Something in your arm bones begins to shift as they suddenly curve and grow awkwardly through the skin, piercing through your fur like a spike. Now juting outside of your wrists like a pair of natural tonfas. the bones begin to reshape, polish and alter itself, fully taking on the consistency of steel! You admire your two Kamaitachi scythes with stupor, they are sharp and hard enough to leave clean deep cuts even in the hardest material and light enough that you can swing them around as if they weren't even there to begin with, lighter than air indeed. Enemies better fear you now that you got those <b>Kamaitachi arm-scythes.</b>";

					if (player.coatColor == "") player.coatColor = player.hairColor;
					player.arms.type = Arms.KAMAITACHI;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.KAMAITACHI;
	    }
	);

	public const ArmsRaccoon: Transformation = new SimpleTransformation("Raccoon Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into small like claws so no wonder you felt it that much. <b>You now have pawed hands like those of a raccoon.</b>";

					player.arms.type = Arms.RACCOON;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.RACCOON;
	    }
	);

	public const ArmsHinezumi: Transformation = new SimpleTransformation("Hinezumi Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "You suddenly feel like your forearms are burning. Burning they indeed begin to do, as they suddenly start blazing, a thick coat of fire covering them up to the fist. That’s going to be a very interesting ability to use in combat. <b>You now have blazing arms!</b>";

					player.arms.type = Arms.HINEZUMI;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.HINEZUMI;
	    }
	);

	public const ArmsKraken: Transformation = new SimpleTransformation("Kraken Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "You notice your hand and forearm skin slowly darkening until it turns pitch black as your nails disappear entirely. Your hands now look like they’re covered in a thin layer of black rubber like gloves, but you know the truth. These truly are your arms and you can feel the touch on your black hands. At least you'll always be dressed elegantly with your<b> new kraken arms.</b>";

					player.arms.type = Arms.KRAKEN;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.KRAKEN;
	    }
	);

	public const ArmsYeti: Transformation = new SimpleTransformation("Yeti Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your arms start to become excessively hairy down almost to your hands. They're so hairy that you can no longer see your skin. As the fur growth stops, your hands enlarge to twice their size. They look like huge monkey paws. Well, you guess punching people will be easy with your enormous <b>yeti hands!</b>";

					player.arms.type = Arms.YETI;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.YETI;
	    }
	);

	public const ArmsSeaDragon: Transformation = new SimpleTransformation("Sea Dragon Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your fingers slowly conjoin with a thin webbing between them. It's a strange, slimy feeling. As you examine your hands, something, not unlike a pair of fins, grows out of your forearms and your nails sharpen into curved reptilian claws. <b>You can only guess those Sea Dragons arms will help you to swim at high speeds!</b>";

					player.arms.type = Arms.SEADRAGON;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.SEADRAGON;
	    }
	);

	public const ArmsFrostwyrm: Transformation = new SimpleTransformation("Frostwyrm Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your arms and hands suddenly begins to get thicker and bigger, way beyond human size. Your entire forearms and now massive hands first cover with -scale color- scales then with white fur, giving them the appearance of fluffy padded gloves. From the fur however surges out what used to be your nails, now powerful claws capable of digging through solid rock and ice just like those of a frost wyrm. <b>You now have frost wyrm arms!</b>";

					player.arms.type = Arms.FROSTWYRM;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.FROSTWYRM;
	    }
	);

	public const ArmsBear: Transformation = new SimpleTransformation("Bear Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your hands suddenly start to hurt as your arms grows a thick coat of [skin coat.color] fur up to your shoulders. You watch enthralled as your nails turn into large ursan claws on your now five-fingered paw-like hands. <b>You now have bear-like paw hands.</b>";

					player.arms.type = Arms.BEAR;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.BEAR;
	    }
	);

	public const ArmsUshiOni: Transformation = new SimpleTransformation("Ushi-Oni Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Your onyx exoskeleton begins to itch. You begin to scratch at it incessantly until you can see [haircolor] fur begin to sprout from your arms from the biceps down, forming a diamond spiral where the fur meets skin. Your fingers begin to shake and sink into your hands as 4 huge strong claws grow in their places. <b>After the painful experience you see that you now have Ushi-Oni bestial arms.</b>";

          player.coatColor = "black";
					player.arms.type = Arms.USHI_ONI;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.USHI_ONI;
	    }
	);

	public const ArmsMelkie: Transformation = new SimpleTransformation("Melkie Arms",
	    // apply effect
	    function(doOutput: Boolean): void {
	        var desc: String = "";

	        desc += "Similar to when your legs merged in your tail your forearm begin to change, turning into a pair of glove like seal arms armed with claws. What's more, you have a pair of fins on your elbow similar to a Melkie. <b>Well it'll take some time to get used to your new seal forearms with fins.</b>";

					player.arms.type = Arms.MELKIE;
	        if (doOutput) outputText(desc);
	    },
	    // is present
	    function(): Boolean {
	        return player.arms.type === Arms.MELKIE;
	    }
	);

	public const ArmsAtlach:Transformation = new SimpleTransformation("Spider arms",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (player.arms.type == Arms.HARPY || player.arms.type == Arms.HUMAN) {
					if (player.arms.type == Arms.HARPY) desc += "The feathers covering your arms fall away, leaving them to return to a far more human appearance.  ";
					desc += "You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a midnight purple carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
				} else {
					if (player.arms.type == Arms.BEE) desc += "The fizz covering your upper arms starting to fall down leaving only midnight purple chitin clad arms.";
					else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRACONIC) desc += "The scales covering your upper arms starting to fall down leaving only midnight purple chitin clad arms.";
					else if (player.arms.type == Arms.MANTIS) desc += "The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the [skinfurscales] into a midnight purple carapace</b>.";
					else desc += "You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a midnight purple carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
				}
				if (doOutput) outputText(desc);
				player.coatColor = "midnight purple";
				player.coatColor2 = "midnight purple";
	      player.arms.type = Arms.SPIDER;
	      Metamorph.unlockMetamorph("Spider Arms", doOutput);
			},
			// is present
			function ():Boolean {
				return player.arms.type === Arms.SPIDER;
			}
	);

	/***
	 *     ██████  ██ ██      ██      ███████
	 *    ██       ██ ██      ██      ██
	 *    ██   ███ ██ ██      ██      ███████
	 *    ██    ██ ██ ██      ██           ██
	 *     ██████  ██ ███████ ███████ ███████
	 */

	public const GillsNone:Transformation = new SimpleTransformation("No gills",
			// apply effect
			function (doOutput:Boolean):void {
				updateGills(Gills.NONE)
			},
			// is present
			function ():Boolean {
				return player.gills.type === Gills.NONE;
			}
	);

	/***
	 *    ██████  ██████  ███████  █████  ███████ ████████ ███████
	 *    ██   ██ ██   ██ ██      ██   ██ ██         ██    ██
	 *    ██████  ██████  █████   ███████ ███████    ██    ███████
	 *    ██   ██ ██   ██ ██      ██   ██      ██    ██         ██
	 *    ██████  ██   ██ ███████ ██   ██ ███████    ██    ███████
	 */

	public const BreastsGrowUpToDD:Transformation = new SimpleTransformation("Grow breasts up to DD",
			// apply effect
			function (doOutput:Boolean):void {
				var row:int = player.smallestTitRow();
				var desc: String = "";

				desc += "Your chest aches and tingles, and your hands reach up to scratch at it unthinkingly.  Just as you start to scratch at your " + breastDescript(row) + ", your chest pushes out in slight but sudden growth.";

				if (doOutput) outputText(desc);
				player.breastRows[row].breastRating++;
			},
			// is present
			function ():Boolean {
				return player.smallestTitSize() >= 6;
			}
	);

	public const BreastRowsRemoveToOne:Transformation = new SimpleTransformation("One pair of breasts",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ";
				if (player.bRows() >= 3) desc += "abdomen";
				else desc += "chest";
					desc += ". The " + nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ";
				if (player.hasFur()) outputText(player.hairColor + " " + player.skinDesc);
				else outputText(player.skinTone + " " + player.skinDesc);
				desc += " remains. <b>You've lost a row of breasts!</b>";

				if (doOutput) outputText(desc);
				dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
			},
			// is present
			function ():Boolean {
				return player.breastRows.length == 1;
			},
			// is possible
			function ():Boolean {
				return player.breastRows.length > 1;
			}
	);

	public const NipplesPerBreastOne:Transformation = new SimpleTransformation("One nipple per breast",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "A chill runs over your [allbreasts] and vanishes.  You stick a hand under your [armor] and discover that your extra nipples are missing!  You're down to just one per ";
				if (player.biggestTitSize() < 1) desc += "'breast'.";
				else desc += "breast.";


				if (doOutput) outputText(desc);
				for (var i:int = 0; i < player.breastRows.length; i++) {
					player.breastRows[i].nipplesPerBreast = 1;
				}
			},
			// is present
			function ():Boolean {
				return player.averageNipplesPerBreast() == 1;
			},
			// is possible
			function ():Boolean {
				return player.averageNipplesPerBreast() > 1;
			}
	);

	public const NipplesBlack:Transformation = new SimpleTransformation("Black nipples",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "A tickling sensation plucks at your nipples and you cringe, trying not to giggle.  Looking down you are in time to see the last spot of flesh tone disappear from your [nipples].  They have turned an onyx black!";

				if (doOutput) outputText(desc);
				player.createStatusEffect(StatusEffects.BlackNipples, 0, 0, 0, 0);
			},
			// is present
			function ():Boolean {
				return player.hasStatusEffect(StatusEffects.BlackNipples)
			},
			// is possible
			function ():Boolean {
				return !player.hasStatusEffect(StatusEffects.BlackNipples) && player.lowerBody !== LowerBody.GARGOYLE
			}
	);

	/***
	 *     █████  ███████ ███████
	 *    ██   ██ ██      ██
	 *    ███████ ███████ ███████
	 *    ██   ██      ██      ██
	 *    ██   ██ ███████ ███████
	 */

	public const AssGrowUpTo11:Transformation = new SimpleTransformation("Grow ass up to 11",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You look over your shoulder at your [ass] only to see it expand just slightly. You gape in confusion before looking back at the remaining silk in your hands. You finish it anyway. Dammit!";

				if (doOutput) outputText(desc);
				player.butt.type++;
			},
			// is present
			function ():Boolean {
				return player.butt.type < 11;
			}
	);

	/***
	 *    ███████ ███████ ██   ██ ██    ██  █████  ██
	 *    ██      ██       ██ ██  ██    ██ ██   ██ ██
	 *    ███████ █████     ███   ██    ██ ███████ ██
	 *         ██ ██       ██ ██  ██    ██ ██   ██ ██
	 *    ███████ ███████ ██   ██  ██████  ██   ██ ███████
	 *
	 *
	 */


	/***
	 *    ███████ ██████  ███████  ██████ ██  █████  ██          ████████ ███████ ███████
	 *    ██      ██   ██ ██      ██      ██ ██   ██ ██             ██    ██      ██
	 *    ███████ ██████  █████   ██      ██ ███████ ██             ██    █████   ███████
	 *         ██ ██      ██      ██      ██ ██   ██ ██             ██    ██           ██
	 *    ███████ ██      ███████  ██████ ██ ██   ██ ███████        ██    ██      ███████
	 */


	/***
	 *    ████████ ██ ███████ ██████  ███████ ██████      ████████ ███████ ███████
	 *       ██    ██ ██      ██   ██ ██      ██   ██     	 ██    ██      ██
	 *       ██    ██ █████   ██████  █████   ██   ██        ██    █████   ███████
	 *       ██    ██ ██      ██   ██ ██      ██   ██        ██    ██           ██
	 *       ██    ██ ███████ ██   ██ ███████ ██████         ██    ██      ███████
	 *
	 *
	 */

	public const TieredSpiderFace:GradualTransformation = new GradualTransformation("Spider face (gradual)", [
		FaceHuman,
		FaceSpiderFangs
	]);

	/***
	 *    ██      ██ ███████ ████████ ███████
	 *    ██      ██ ██         ██    ██
	 *    ██      ██ ███████    ██    ███████
	 *    ██      ██      ██    ██         ██
	 *    ███████ ██ ███████    ██    ███████
	 */


	public const List_AtlachNacha: /*Transformation*/ Array = [
		MutagenLibSpider,
		MutagenTouSpider,
		MutagenSpeSpider,
		SensUpSpider,

		VenomRechargeSpider,
		VaginaTightenAndMutagenLib,
		AssholeTightenAndMutagenLib,
		CocksThickenAll,
		BreastsGrowUpToDD,
		AssGrowUpTo11,

		EarsElfin,
		SkinChitin,
		TieredSpiderFace,
		makeHairColorTf(["midnight purple"]),
		new OrderedTransformation("EyesRedThenSpider", [
			EyesChangeColor(["red"]),
			EyesSpiderAndMutagenInt
		]),
		BreastRowsRemoveToOne,
		NipplesPerBreastOne,
		NipplesBlack,
		ArmsAtlach,
		LegsAtlach,
		SpinneretAtlach,
		GillsNone,
		RearAtlachNacha
	];
}
}
