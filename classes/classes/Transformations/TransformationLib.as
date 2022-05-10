package classes.Transformations {
import classes.BodyParts.Antennae;
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

import classes.GeneticMemories.*;

import classes.Items.MutationsHelper;
import classes.StatusEffects;
import classes.internals.EnumValue;
import classes.Scenes.Metamorph;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.internals.Utils;
import classes.lists.Gender;

public class TransformationLib extends MutationsHelper {
public function TransformationLib() {}

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

/*
	*/
	public const MutagenSpeSpider:PossibleEffect    = new MutagenEffect(
			"Mutagen Bonus SPE (spider)",
			"spe",
			1.5,
			"Your reflexes feel much faster. Experimentally, you make a grab at a fly on a nearby rock and quickly snatch it out of the air. A compulsion to stuff it in your mouth and eat it surfaces, but you resist the odd desire. Why would you ever want to do something like that?"
	);
	public const MutagenTouSpider:PossibleEffect    = new MutagenEffect(
			"Mutagen Bonus TOU (spider)",
			"tou",
			1,
			"Stretching languidly, you realize you're feeling a little tougher than before, almost as if you had a full-body shell of armor protecting your internal organs. How strange. You probe at yourself, and while your [skinfurscales] doesn't feel much different, the underlying flesh does seem tougher."
	);
	public const MutagenLibSpider:PossibleEffect    = new MutagenEffect(
			"Mutagen Bonus LIB (spider)",
			"lib",
			1,
			"You suddenly feel slightly needier, and your loins stir in quiet reminder that they could be seen to. The aftertaste hangs on your tongue and your teeth. You wish there had been more."
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

					desc += "The spinnerets on your abdomen twitch and drip a little webbing. The entirety of its heavy weight shifts slightly, and somehow you know you'll produce webs faster now.";

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
					desc += " out, you look closely. ";
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

	public const MutagenSpdCat: PossibleEffect = new StatChangeEffect("Mutagen Spd Cat",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

      if (player.spe <= 30) {
          desc += "You feel... more balanced, sure of step. You're certain that you've become just a little bit faster.";
          MutagenBonus("spe", 2);
      } else if (player.spe <= 60) {
          desc += "You stumble as you shift position, surprised by how quickly you move. After a moment or two of disorientation, you adjust. You're certain that you can run faster now.";
          MutagenBonus("spe", 1);
      } else {
          desc += "You pause mid-step and crouch. Your leg muscles have cramped up like crazy. After a few moments, the pain passes and you feel like you could chase anything down.";
          MutagenBonus("spe", 0.5);
      }

	  	if (doOutput) outputText(desc);
	  }
	);

	public const MutagenStrCat: PossibleEffect = new StatChangeEffect("Mutagen Str Cat",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

      if (rand(2) == 0) desc += "Your muscles feel taut, like a coiled spring, and a bit more on edge.";
      else desc += "You arch your back as your muscles clench painfully. The cramp passes swiftly, leaving you feeling like you've gotten a bit stronger.";

			MutagenBonus("str", 1);
	  	if (doOutput) outputText(desc);
	  }
	);
	/*
*/
/*
*    ███████ ██   ██ ██ ███    ██
*    ██      ██  ██  ██ ████   ██
*    ███████ █████   ██ ██ ██  ██
*         ██ ██  ██  ██ ██  ██ ██
*    ███████ ██   ██ ██ ██   ████
*/

/*
  */
	public const SkinPlain: Transformation = new SimpleTransformation("Plain Skin",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    switch (player.coatType()) {
	    case Skin.FUR:
	      desc += "Your fur itches incessantly, so you start scratching it. It starts coming off in big clumps before the whole mess begins sloughing off your body. In seconds, your skin is nude. <b>You've lost your fur!</b>";
	      break;
	    case Skin.SCALES:
	      desc += "Your scales itch incessantly, so you scratch at them. They start falling off wholesale, leaving you standing in a pile of scales after only a few moments. <b>You've lost your scales!</b>";
	      break;
	    case Skin.DRAGON_SCALES:
	      desc += "Your dragon scales itch incessantly, so you scratch at them. They start falling off wholesale, leaving you standing in a pile of scales after only a few moments. <b>You've lost your dragon scales!</b>";
	      break;
	    default:
	      desc += "Your [skin noadj] itches incessantly, and as you scratch it shifts and changes, becoming normal human-like skin. <b>Your skin is once again normal!</b>";
	    }

	    if (doOutput) outputText(desc);
	    player.skin.setBaseOnly({ type: Skin.PLAIN, adj: "", desc: "skin" });
	  },
	  // is present
	  function (): Boolean {
	    return player.skinType === Skin.PLAIN && player.skin.coverage == Skin.COVERAGE_NONE;
	  }
	);

  /**
  * @param options = {color/colors,color2/colors2,pattern,adj,desc}
  */
	public function SkinFur(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation {
	  return new SimpleTransformation("Fur Skin",
	    // apply effect
	    function (doOutput: Boolean): void {
	      options = skinFormatOptions(options, true);

	      const color: String = options.color;

	      var desc: String = "";

	      // Coverage
	      if (player.hasCoatOfType(Skin.FUR)) {
	        if (coverage > player.skin.coverage) {
	          desc += "You suddenly feel a familiar itch on parts of your skin uncovered by fur. You're not surprised when <b>even more " + player.coatColor + " fur sprouts, covering more of your body.</b>";
	        } else if (coverage < player.skin.coverage) {
	          desc += "Sections of your " + player.coatColor + " fur itch incessantly, and as you scratch yourself, it starts coming off in big clumps. <b>You still have " + player.coatColor + " fur on your body, but now it covers less of your skin.</b>";
	        }

	        if (coverage !== player.skin.coverage && color !== player.coatColor) {
	          desc += "\n\n";
	        }

	        if (color !== player.coatColor) {
	          desc += "You feel a strange sensation on your fur, and as soon as you glance at it, you're met with the sight of its hue slowly morphing from " + player.coatColor + " to " + color + ". <b>Your fur is now " + color + ".</b>"
	        }
	      } else {
	        switch (coverage) {
	        case Skin.COVERAGE_LOW:
	          if (!player.hasCoat()) desc += "Your skin itches intensely. You gaze down as more and more hairs break forth from your skin quickly transforming into a coat of " + color + " fur. <b>You are now partialy covered in " + color + " fur.</b>";
	          else if (player.hasScales()) desc += "Your scales itch incessantly. You scratch, feeling them flake off to reveal a coat of " + color + " fur growing out from below!  <b>You are now partialy covered in " + color + " fur.</b>";
	          else desc += "Your skin itch incessantly. You scratch, feeling it current form shifting into a coat of " + color + " fur. <b>You are now partialy covered in " + color + " fur.</b>";
	          break;
	        case Skin.COVERAGE_COMPLETE:
	          if (player.skinType == Skin.SCALES) desc += "Your skin shifts and every scale stands on end, sending you into a mild panic. No matter how you tense, you can't seem to flatten them again. The uncomfortable sensation continues for some minutes until, as one, every scale falls from your body and a fine coat of fur pushes out. You briefly consider collecting them, but when you pick one up, it's already as dry and brittle as if it were hundreds of years old. <b>Oh well, at least you won't need to sun yourself as much with your new " + color + " fur.</b>";
	          else desc += "Your skin itches all over, the sudden intensity and uniformity making you too paranoid to scratch. As you hold still through an agony of tiny tingles and pinches, fine, luxuriant " + color + " fur sprouts from every bare inch of your skin! <b>You're now covered from head to toe in " + color + " fur.</b>";
	          break;
	        default:
	          desc += "ERROR: DESCRIPTION FOR THIS LEVEL OF FUR COVERAGE DOES NOT EXIST"
	        }
	      }

	      // Patterns
	      if (options.pattern && options.pattern !== player.skin.base.pattern) {
	        const pattern: int = options.pattern;

	        if (!options.color2 && options.colors2) {
	          options.color2 = randomChoice(options.colors2);
	          options.colors2 = undefined;
	        }

	        switch (pattern) {
	        case Skin.PATTERN_SPOTTED:
	          if (!options.color2) options.color2 = "black";
	          desc += "\n\nA ripple spreads through your fur as some patches darken and others lighten. After a few moments you're left with a " + options.color2 + " and " + color + " spotted pattern that goes the whole way up to the hair on your head! <b>You've got spotted fur!</b>";
	          break;
	        case Skin.PATTERN_RED_PANDA_UNDERBODY:
	          if (!options.color2) options.color2 = "black";
	          desc += "\n\nA ripple spreads through your fur as your underside changes colors, becoming " + options.color2 + " rather than " + color + ". <b>Now your underside fur is " + options.color2 + ".</b>";
	          break;
	        }
	      }

	      player.skinDesc = "skin";
	      player.skin.growCoat(Skin.FUR, options, coverage);
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.FUR));
	    },
	    // is present
	    function (): Boolean {
	      options = skinFormatOptions(options, true);

	      return player.hasCoatOfType(Skin.FUR) && InCollection(player.coatColor, options.colors) && player.skin.coverage == coverage;
	    }
	  )
	}

	public function SkinScales(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation {
	  return new SimpleTransformation("Scales Skin",
	    // apply effect
	    function (doOutput: Boolean): void {
	      options = skinFormatOptions(options, false);

	      const color: String = options.color;

	      var desc: String = "";

	      // Coverage
	      if (player.hasCoatOfType(Skin.SCALES)) {
	        if (coverage > player.skin.coverage) {
	          desc += "You suddenly feel a familiar itch on parts of your skin uncovered by scales. You're not surprised when <b>even more " + player.coatColor + " scales sprout, covering more of your body.</b>";
	        } else if (coverage < player.skin.coverage) {
	          desc += "Sections of your " + player.coatColor + " scales itch incessantly, and as you scratch yourself, they start falling off wholesale. <b>You still have " + player.coatColor + " scales on your body, but now they cover less of your skin.</b>";
	        }

	        if (coverage !== player.skin.coverage && color !== player.coatColor) {
	          desc += "\n\n";
	        }

	        if (color !== player.coatColor) {
	          desc += "You feel a strange sensation on your scales, and as soon as you glance at them, you're met with the sight of their hue slowly morphing from " + player.coatColor + " to " + color + ". <b>Your scales are now " + color + ".</b>"
	        }
	      } else {
	        switch (coverage) {
	        case Skin.COVERAGE_LOW:
	          if (player.hasFur()) {
	            desc += "You scratch yourself, and come away with a large clump of [skin coat.color] fur. Panicked, you look down and realize that your fur is falling out in huge clumps. It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed. You feel your skin shift as " + color + " scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you. The rest of the fur is easy to remove. <b>Your body is now partially covered with small patches of scales!</b>";
	          } else {
	            desc += "You feel your skin shift as scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you. <b>Your body is now partially covered with small patches of " + color + " scales.</b>";
	          }
	          break;
	        case Skin.COVERAGE_COMPLETE:
	          if (player.hasFur()) {
	            desc += "You scratch yourself, and come away with a large clump of [skin coat.color] fur. Panicked, you look down and realize that your fur is falling out in huge clumps. It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed. Underneath the fur your skin feels incredibly smooth, and as more and more of the stuff comes off, you discover a seamless layer of " + color + " scales covering most of your body. The rest of the fur is easy to remove. <b>You're now covered in scales from head to toe.</b>";
	          } else {
	            desc += "You idly reach back to scratch yourself and nearly jump out of your [armor] when you hit something hard. A quick glance down reveals that scales are growing out of your " + player.skinTone + " skin with alarming speed. As you watch, the surface of your skin is covered in smooth scales. They interlink together so well that they may as well be seamless.  You peel back your [armor] and the transformation has already finished on the rest of your body. <b>You're covered from head to toe in shiny " + color + " scales.</b>";
	          }
	          break;
	        default:
	          desc += "ERROR: DESCRIPTION FOR THIS LEVEL OF SCALES COVERAGE DOES NOT EXIST"
	        }
	      }

	      player.skinDesc = "skin";
	      player.skin.growCoat(Skin.SCALES, options, coverage);
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.SCALES));
	    },
	    // is present
	    function (): Boolean {
	      options = skinFormatOptions(options, false);

	      return player.hasCoatOfType(Skin.SCALES) && InCollection(player.coatColor, options.colors) && player.skin.coverage == coverage;
	    }
	  )
	}

	public function SkinDragonScales(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation {
	  return new SimpleTransformation("Dragon Scales Skin",
	    // apply effect
	    function (doOutput: Boolean): void {
	      options = skinFormatOptions(options, false);

	      const color: String = options.color;

	      var desc: String = "";

	      // Coverage
	      if (player.hasCoatOfType(Skin.DRAGON_SCALES)) {
	        if (coverage > player.skin.coverage) {
	          desc += "You suddenly feel a familiar itch on parts of your skin uncovered by dragon scales. You're not surprised when <b>even more " + player.coatColor + " dragon scales sprout, covering more of your body.</b>";
	        } else if (coverage < player.skin.coverage) {
	          desc += "Sections of your " + player.coatColor + " dragon scales itch incessantly, and as you scratch yourself, they start falling off wholesale. <b>You still have " + player.coatColor + " dragon scales on your body, but now they cover less of your skin.</b>";
	        }

	        if (coverage !== player.skin.coverage && color !== player.coatColor) {
	          desc += "\n\n";
	        }

	        if (color !== player.coatColor) {
	          desc += "You feel a strange sensation on your dragon scales, and as soon as you glance at them, you're met with the sight of their hue slowly morphing from " + player.coatColor + " to " + color + ". <b>Your dragon scales are now " + color + ".</b>"
	        }
	      } else {
	        switch (coverage) {
	        case Skin.COVERAGE_LOW:
	          desc += "Prickling discomfort suddenly erupts all over your body, like every last inch of your skin has suddenly developed pins and needles.  You scratch yourself, hoping for relief; and when you look at your hands you notice small fragments of your " + player.skinFurScales() + " hanging from your fingers.  Nevertheless you continue to scratch yourself, and when you're finally done, you look yourself over. New shield-like scales have grown to replace your peeled off " + player.skinFurScales() + ". It doesn’t cover your skin entirely but should provide excellent protection regardless.  They are smooth and look nearly as tough as iron. <b>Your body is now partially covered in " + color + " shield-shaped dragon scales.</b>";
	          break;
	        case Skin.COVERAGE_COMPLETE:
	          desc += "Prickling discomfort suddenly erupts all over your body, like every last inch of your skin has suddenly developed pins and needles. You scratch yourself, hoping for relief; and when you look at your hands you notice small fragments of your " + player.skinFurScales() + " hanging from your fingers. Nevertheless you continue to scratch yourself, and when you're finally done, you look yourself over. New shield-like scales have grown to replace your peeled off " + player.skinFurScales() + ". They are smooth and look nearly as tough as iron. <b>Your body is now fully covered in " + color + " shield-shaped dragon scales.</b>";
	          break;
	        default:
	          desc += "ERROR: DESCRIPTION FOR THIS LEVEL OF DRAGON SCALES COVERAGE DOES NOT EXIST"
	        }
	      }

	      player.skinDesc = "skin";
	      player.skin.growCoat(Skin.DRAGON_SCALES, options, coverage);
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.DRAGON_SCALES));
	    },
	    // is present
	    function (): Boolean {
	      options = skinFormatOptions(options, false);

	      return player.hasCoatOfType(Skin.DRAGON_SCALES) && InCollection(player.coatColor, options.colors) && player.skin.coverage == coverage;
	    }
	  )
	}

	public function SkinChitin(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation {
	  return new SimpleTransformation("Chitin Skin",
	    // apply effect
	    function (doOutput: Boolean): void {
	      options = skinFormatOptions(options, false);

	      const color: String = options.color;

	      var desc: String = "";

	      // Coverage
	      if (player.hasCoatOfType(Skin.CHITIN)) {
	        if (coverage > player.skin.coverage) {
	          desc += "You suddenly feel a familiar itch on parts of your skin uncovered by chitin. When you scratch yourself, your skin starts to harden, becoming chitin in the same color as what was already on your body. <b>Even more " + player.coatColor + " chitin is covering your body now.</b>";
	        } else if (coverage < player.skin.coverage) {
	          desc += "Sections of your " + player.coatColor + " chitin itch incessantly, and as you scratch yourself, you feel it softening and becoming normal skin again. <b>You still have " + player.coatColor + " chitin on your body, but now it covers less.</b>";
	        }

	        if (coverage !== player.skin.coverage && color !== player.coatColor) {
	          desc += "\n\n";
	        }

	        if (color !== player.coatColor) {
	          desc += "You feel a strange sensation on the chitin covering your skin, and as soon as you glance at it, you're met with the sight of its hue slowly morphing from " + player.coatColor + " to " + color + ". <b>Your chitin is now " + color + ".</b>"
	        }
	      } else {
	        switch (coverage) {
	        case Skin.COVERAGE_LOW:
	          if (player.hasCoat()) {
	            desc += "A slowly-building itch spreads over parts of your body, and as you idly scratch yourself, you find that your [skin coat] [skin coat.isare] falling to the ground, revealing flawless, " + color + " chitin underneath.";
	          } else {
	            desc += "A slowly-building itch spreads over parts of your body, and as you idly scratch yourself, you find that your skin stating to harden turning slowly into chitin.";
	          }
	          desc += " <b>You now have " + color + " chitin exoskeleton covering parts of your body.</b>";

	          break;
	        case Skin.COVERAGE_COMPLETE:
	          if (player.hasCoat()) {
	            desc += "A slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your [skin coat] [skin coat.isare] falling to the ground, revealing flawless, " + color + " chitin underneath.";
	          } else {
	            desc += "A slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your skin stating to harden turning slowly into chitin.";
	          }
	          desc += " <b>You now have " + color + " chitin exoskeleton covering your body.</b>";
	          break;
	        default:
	          desc += "ERROR: DESCRIPTION FOR THIS LEVEL OF FUR COVERAGE DOES NOT EXIST"
	        }
	      }

	      player.skinDesc = "skin";
	      player.skin.growCoat(Skin.CHITIN, options, coverage);
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.CHITIN));
	    },
	    // is present
	    function (): Boolean {
	      options = skinFormatOptions(options, false);

	      return player.hasCoatOfType(Skin.CHITIN) && InCollection(player.coatColor, options.colors) && player.skin.coverage == coverage;
	    }
	  )
	}

	private function skinFormatOptions(options: *, hairy:Boolean = false): * {
        if (!options) options = {};
        if (!options.adj) options.adj = "";
        if (!options.pattern) options.pattern == "";
        if (!options.color && !options.colors)
            if (player.coatColor == "" || (!player.skin.isHairy() && hairy) || (player.skin.isHairy() && !hairy)) {
                //WHY THE F*** DOESN'T THIS TRASH LANGUAGE HAVE LOGICAL XOR?!
                //the third condition - if need fur, and skin is NOT hairy, reset to hair color, and vice versa
                options.color = hairy ? player.hairColor : player.skin.base.color;
                options.colors = [options.color];
            }
            else {
                options.color = player.coatColor;
                options.colors = [options.color];
            }
        else if (!options.color && options.colors)
            options.color = randomChoice(options.colors);

        return options;
	}
  /*
*/

/*
*    ███████ ██   ██ ██ ███    ██ 			███████   █████  ████████ ████████ ███████ ██████  ███    ██
*    ██      ██  ██  ██ ████   ██ 			██   ██  ██   ██    ██       ██    ██      ██   ██ ████   ██
*    ███████ █████   ██ ██ ██  ██ 			███████  ███████    ██       ██    █████   ██████  ██ ██  ██
*         ██ ██  ██  ██ ██  ██ ██ 			██		   ██   ██    ██       ██    ██      ██   ██ ██  ██ ██
*    ███████ ██   ██ ██ ██   ████ 			██		   ██   ██    ██       ██    ███████ ██   ██ ██   ████
*/

/*
  */
	public const SkinPatternNone: Transformation = new SimpleTransformation("No Skin Pattern",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your skin patterns itches incessantly, and as you scratch they shifts and changes, becoming less and less visible till they gone. <b>Your skin is without any skin patterns!</b>";
	    player.skin.base.adj = "";
	    player.skin.base.pattern = Skin.PATTERN_NONE;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.skin.base.pattern === Skin.PATTERN_NONE;
	  }
	);

	public const SkinPatternOrc: Transformation = new SimpleTransformation("Orc Skin Pattern",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You double over suddenly as a harsh, stabbing pain runs across your skin, tattoos in the shape of scars forming on various parts of your body. Considering how you look now, you might as well proudly display your <b>Orc scar tattooed skin.</b>";
	    player.skin.base.color2 = "black";
	    player.skin.base.adj = "scar shaped tattooed";
	    player.skin.base.pattern = Skin.PATTERN_SCAR_SHAPED_TATTOO;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.SCAR_SHAPED));
	  },
	  // is present
	  function (): Boolean {
	    return player.skin.base.pattern === Skin.PATTERN_SCAR_SHAPED_TATTOO;
	  }
	);

	public const SkinPatternRaiju: Transformation = new SimpleTransformation("Raiju Skin Pattern",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You suddenly feel a rush of electricity on your skin as glowing tattoos in the shape of lightning bolts form in various place across your body. Well, how shocking. <b>Your skin is now inscribed with some lightning shaped tattoos.</b>";
	    player.skin.base.adj = "tattooed";
	    player.skin.base.pattern = Skin.PATTERN_LIGHTNING_SHAPED_TATTOO;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.LIGHTNING_SHAPED));
	  },
	  // is present
	  function (): Boolean {
	    return player.skin.base.pattern === Skin.PATTERN_LIGHTNING_SHAPED_TATTOO;
	  }
	);

	public const SkinPatternOni: Transformation = new SimpleTransformation("Oni Skin Pattern",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "As you thought your skin couldn't handle more tattoo a few localised skin burns reveal a new set of drawing along your skin, some decorating your chest. Well you might as well proudly display your <b>Oni tattooed skin.</b>";
	    player.skin.base.adj = "tattooed";
	    player.skin.base.pattern = Skin.PATTERN_BATTLE_TATTOO;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.BATTLE));
	  },
	  // is present
	  function (): Boolean {
	    return player.skin.base.pattern === Skin.PATTERN_BATTLE_TATTOO;
	  }
	);

	public const SkinPatternKitsune: Transformation = new SimpleTransformation("Kitsune Skin Pattern",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face. You are caught by surprise when you are suddenly assaulted by a blinding flash issuing from areas of your skin, and when the spots finally clear from your vision, an assortment of glowing magical tattoos adorns your [skin]. The glow gradually fades, but the distinctive ";
	    if (rand(2) == 0) desc += "angular";
	    else desc += "curved";
	    desc += " markings remain, as if etched into your skin. <b>You now have Kitsune tattoos on your skin.</b>";
	    player.skin.base.color2 = "black";
	    player.skin.base.adj = "tattooed";
	    player.skin.base.pattern = Skin.PATTERN_MAGICAL_TATTOO;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.MAGICAL));
	  },
	  // is present
	  function (): Boolean {
	    return player.skin.base.pattern === Skin.PATTERN_MAGICAL_TATTOO;
	  }
	);

	public const SkinPatternVenomousMarkings: Transformation = new SimpleTransformation("Venomous Markings Skin Pattern",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel an unusual warmth in your chest. You look down to see a purple blot form on your chest and then begin to spread out across your skin like brushstrokes. It doesn't stop until your skin is covered in intricate purple designs. You can feel your venom pumping through them. <b>Your skin is covered in venomous body markings.</b>";

	    player.skin.base.pattern = Skin.PATTERN_VENOMOUS_MARKINGS;
	    player.skin.base.adj = "venomous markings-covered";

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.skin.base.pattern === Skin.PATTERN_MAGICAL_TATTOO;
	  }
	);

	public const SkinPatternWhiteBlackVeins: Transformation = new SimpleTransformation("White Black Veins Skin Pattern",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your skin tingles and itches faintly. You look down to see ";
	    if (player.skin.base.color == "sable") desc += "white";
	    if (player.skin.base.color == "white") desc += "black";
	    desc += " veins etching deep into your skin across the entirety of your body. <b>You now have ";
	    if (player.skin.base.color == "sable") desc += "white";
	    if (player.skin.base.color == "white") desc += "black";
	    desc += " veins.</b>";
	    if (player.skin.base.color == "sable") player.skin.base.color2 = "white";
	    if (player.skin.base.color == "white") player.skin.base.color2 = "black";

	    player.skin.base.pattern = Skin.PATTERN_WHITE_BLACK_VEINS;
	    player.skin.base.adj = "veined";

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.skin.base.pattern === Skin.PATTERN_WHITE_BLACK_VEINS;
	  }
	);

	public const SkinPatternOil: Transformation = new SimpleTransformation("Oil Skin Pattern",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "The black tar like substance begins to drip everywhere around your body now, from your ass, your shoulders and even your chest. Soon your torso looks like it bathed into tar some of it dripping down your body. The fluids however are regularly produced like sweat from your skin so you never run out. <b>Your body now drips black fluids.</b>";

	    player.skin.base.pattern = Skin.PATTERN_OIL;
	    player.skin.base.adj = "oily skin";

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.OIL));
	  },
	  // is present
	  function (): Boolean {
	    return player.skin.base.pattern === Skin.PATTERN_OIL;
	  }
	);

	public const SkinPatternScarWindswept: Transformation = new SimpleTransformation("Scar Windswept Skin Pattern",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You scream in pain as your aura flares again, leaving clean cuts all over your body. The cuts glows green for an instant before taking back on a more ordinary brown tone, closing into what looks like innocuous scars at first glance. <b>Clearly those new windswept scars of yours actually improves your wind control, marking you as a full Kamaitachi.</b>";

	    player.skin.base.pattern = Skin.PATTERN_SCAR_WINDSWEPT;
	    player.skin.base.adj = "windswept scars";
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.skin.base.pattern === Skin.PATTERN_SCAR_WINDSWEPT;
	  }
	);

	public const SkinPatternUshiOniTattoo: Transformation = new SimpleTransformation("Ushi-Oni Tattoo Skin Pattern",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your chest burns as strange marks appear on it, burning your skin until it creates a <b>black spider glyph in your chest</b>. You feel like something is coming up throughout your skin and upon taking your [armor] off, strokes of coarse fur travelling from your abdomen, all the way up to your breasts. Conveniently ending around the nipples, covering them, <b>you know have a Ushi-Oni torso pattern.</b>";

	    player.skin.base.pattern = Skin.PATTERN_USHI_ONI_TATTOO;
	    player.skin.base.adj = "black spider glyph-tattooed";

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.skin.base.pattern === Skin.PATTERN_USHI_ONI_TATTOO;
	  }
	);

	public const SkinPatternBeeStripes:Transformation = new SimpleTransformation("Bee Stripes Skin Pattern",
		// apply effect
		function (doOutput:Boolean):void {
			TransformationUtils.applyTFIfNotPresent(transformations.SkinChitin(Skin.COVERAGE_LOW, { color: "yellow" }), doOutput);
			var desc:String = "A ripple spreads through your chitin as some patches change in color. After a few moments you're left with a yellow and black striped pattern, like a bee's! <b>You've got striped chitin!</b>";
			player.skin.coat.pattern = Skin.PATTERN_BEE_STRIPES;
			if (!InCollection(player.coatColor2, "black", "ebony"))
				player.coatColor2 = randomChoice("black", "ebony");
			if (player.coatColor2 != "yellow")
				player.coatColor = "yellow";
			if (doOutput) outputText(desc);
			Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.BEE_STRIPES));
		},
		// is present
		function ():Boolean {
			return transformations.SkinChitin(Skin.COVERAGE_LOW).isPresent() && player.skin.coat.pattern === Skin.PATTERN_BEE_STRIPES;
		}
	);
  /*
*/

/*
*    ██   ██  ██████  ██████  ███    ██ ███████
*    ██   ██ ██    ██ ██   ██ ████   ██ ██
*    ███████ ██    ██ ██████  ██ ██  ██ ███████
*    ██   ██ ██    ██ ██   ██ ██  ██ ██      ██
*    ██   ██  ██████  ██   ██ ██   ████ ███████
*/

/*
  */
	public const HornsNone: Transformation = new SimpleTransformation("No Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.horns.type == Horns.ORCHID) desc += "Your orchid flowers crumble, falling apart";
	    else desc += "Your horns crumble, falling apart in large chunks";
	    desc += " until they flake away to nothing.";
	    player.horns.count = 0;
	    player.horns.type = Horns.NONE;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.NONE;
	  }
	);

	public const HornsBicorn: Transformation = new SimpleTransformation("Bicorn Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.horns.type == Horns.NONE) desc += "With painful pressure, the skin on your forehead splits around two tiny nub-like horn, a little bit similar to that you would see on the cattle back in your homeland.";
	    else desc += "Your horns vibrate and shift as if made of clay, reforming into horns with a bicorn-like shape.";
	    player.horns.count = 2;
	    player.horns.type = Horns.BICORN;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.BICORN));
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.BICORN;
	  }
	);

	public const HornsUnicorn: Transformation = new SimpleTransformation("Unicorn Horn",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.horns.type == Horns.NONE) desc += "With painful pressure, the skin on your forehead splits around tiny nub-like horn, a little bit similar to that you would see on the cattle back in your homeland.";
	    else desc += "Your horns vibrate and shift as if made of clay, reforming into horn with a unicorn-like shape.";
	    player.horns.count = 1;
	    player.horns.type = Horns.UNICORN;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.UNICORN));
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.UNICORN;
	  }
	);

	public const HornsOniDual: Transformation = new SimpleTransformation("Oni Dual Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	    Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.ONI_X2));
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.ONI_X2;
	  }
	);

	public const HornsOni: Transformation = new SimpleTransformation("Oni Horn",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	    Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.ONI));
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.ONI;
	  }
	);

	public const HornsGoat: Transformation = new SimpleTransformation("Goat Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.horns.type == Horns.NONE) {
	      desc += "You begin to feel a prickling sensation at the top of your head. Reaching up to inspect it, you find a pair of hard stubs. <b>You now have a pair of goat horns.</b>";
	    } else if (player.horns.type == Horns.GOATQUAD) {
	      desc += "You begin to feel an odd itching sensation as you feel your horns repositioning and merging back togueter. Once it's over, you reach up and find a pair of tall-standing goat horns where your four horns used to be. <b>You now have a pair of goat horns.</b>"
	    } else desc += "You begin to feel an odd itching sensation as you feel your horns repositioning. Once it's over, you reach up and find a pair of hard stubs. <b>You now have a pair of goat horns.</b>";

	    player.horns.count = 1;
	    player.horns.type = Horns.GOAT;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.GOAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.GOAT;
	  }
	);

	public const HornsGoatQuadruple: Transformation = new SimpleTransformation("Goat Quadruple Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.horns.type == Horns.GOAT) {
	      desc += "You groan in pleasure mixed pains as your horns begins to split into a second pair ornating the side of your head. If the original pair made you look fiendish your four horns now definitively denounce your demonic nature. <b> You now have four devil horns curving backward behind your head.</b>"
	    }

	    player.horns.count = 1;
	    player.horns.type = Horns.GOATQUAD;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.GOAT;
	  }
	);

	public const HornsDraconicQuadruple: Transformation = new SimpleTransformation("Draconic Quadruple Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.HornsDraconicDual, doOutput);
        desc += "\n\n";
	    if (player.horns.type == Horns.DEMON && player.horns.count > 4) {
	      desc += "Your horns condense, twisting around each other and merging into larger, pointed protrusions. By the time they finish <b>you have four draconic-looking horns, each about twelve inches long.</b>"
	    } else {
	      desc += "A second row of horns erupts under the first, and though they are narrower, they grow nearly as long as your first row before they stop. A sense of finality settles over you. <b>You have four draconic-looking horns, each about twelve inches long.</b>";
	    }

	    player.horns.count = 12;
	    player.horns.type = Horns.DRACONIC_X4_12_INCH_LONG;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.DRACONIC_X4));
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.DRACONIC_X4_12_INCH_LONG;
	  }
	);

	public const HornsDraconicDual: Transformation = new SimpleTransformation("Draconic Dual Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.horns.type === Horns.NONE) {
	      desc += "\n\nWith painful pressure, the skin on the sides of your forehead splits around two tiny nub-like horns. They're angled back in such a way as to resemble those you saw on the dragons in your village's legends. A few inches of horns sprout from your head before stopping. <b>You have about four inches of dragon-like horns.</b>";
	    } else {
	      desc += "\n\nYou feel your horns changing and warping, and reach back to touch them. They have a slight curve and a gradual taper. They must look something like the horns the dragons in your village's legends always had.";

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
	    Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.DRACONIC_X2));
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.DRACONIC_X2;
	  }
	);

	public const HornsCowMinotaur: Transformation = new SimpleTransformation("Cow Minotaur Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	    Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.COW_MINOTAUR));
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.COW_MINOTAUR;
	  }
	);

	public const HornsDemonic: Transformation = new SimpleTransformation("Demonic Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	    Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.DEMON));
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.DEMON;
	  }
	);

	public const HornsAntlers: Transformation = new SimpleTransformation("Antlers Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.horns.type === Horns.NONE) {
	      desc += "You hear the sound of cracking branches erupting from the tip of your skull. Small bulges on either side of your head advance outwards in a straight line, eventually spreading out in multiple directions like a miniature tree. Investigating the exotic additions sprouting from your head, the situation becomes clear. <b>You've grown antlers!</b>";
	    } else {
	      desc += "You hear the sound of cracking branches erupting from the tip of your skull. The horns on your head begin to twist and turn fanatically, their texture and size morphing considerably until they resemble something more like trees than anything else. Branching out rebelliously, you've come to the conclusion that <b>you've somehow gained antlers!</b>";
	    }

	    player.horns.count = 4 + rand(12);

	    player.horns.type = Horns.ANTLERS;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.ANTLERS;
	  }
	);

	public const HornsAntlersWendigo: Transformation = new SimpleTransformation("Wendigo Antlers Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    transformations.HornsAntlers.applyEffect(false);
	    player.horns.count = 30;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.ANTLERS && player.horns.count >= 30;
	  }
	);

	public const HornsGhostlyWisps: Transformation = new SimpleTransformation("Ghostly Wisps Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	  function (): Boolean {
	    return player.horns.type === Horns.GHOSTLY_WISPS;
	  }
	);

	public const HornsOak: Transformation = new SimpleTransformation("Oak Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.horns.type === Horns.NONE) {
	      desc += "You hear the sound of cracking branches erupting from the tip of your skull. Small bulges on either side of your head advance outwards in a straight line, eventually spreading out in multiple directions like a miniature tree. Investigating the exotic additions sprouting from your head, the situation becomes clear. <b>You've grown oak horns!</b>";
	    } else {
	      desc += "You hear the sound of cracking branches erupting from the tip of your skull. The horns on your head begin to twist and turn fanatically, their texture and size morphing considerably until they resemble something more like trees than anything else. Branching out rebelliously, you've come to the conclusion that <b>you've somehow gained oak horns!</b>";
	    }

	    player.horns.count = 4 + rand(12);

	    player.horns.type = Horns.OAK;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.OAK;
	  }
	);

	public const HornsOrchid: Transformation = new SimpleTransformation("Orchid Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.horns.type === Horns.NONE) {
	      desc += "A spot on each side of your head has been getting steadily sorer. You’re beginning to think about finding somewhere quiet to take a look at it when it suddenly and rather shockingly bursts, allowing something hand-sized to bloom out from your [hair]. A huge orchids is now flourishing their floppy petals and stamen above your head!  <b>You've grown twin orchid flowers!</b>";
	    } else {
	      desc += "Your old horns slowly crumbling away until nothing is left. Then a spot on each side of your head has been getting steadily sorer. You’re beginning to think about finding somewhere quiet to take a look at it when it suddenly and rather shockingly bursts, allowing something hand-sized to bloom out from your [hair]. A huge pair of orchids is now flourishing their floppy petals and stamen above your head! <b>You've grown a pair of orchid flowers!</b>";
	    }

	    player.horns.count = 2;
	    player.horns.type = Horns.ORCHID;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.ORCHID;
	  }
	);

	public const HornsKraken: Transformation = new SimpleTransformation("Kraken Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel like your head is going to explode and, in a way, it does. Something large and fleshy grows out of the top of your head. When you move toward the water to check your reflection, you discover that you have grown a <b>large fleshy hood, crowning your head just like a Kraken.</b>";

	    player.horns.count = 4 + rand(12);
	    player.horns.type = Horns.KRAKEN;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.KRAKEN;
	  }
	);

	public const HornsSeadragon: Transformation = new SimpleTransformation("Seadragon Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.horns.type === Horns.NONE) {
	      desc += "\n\nYou writhe in pain as two bony extrusions begin to push out of the side of your head. As a skull-splitting headache wracks through you, in an instant, the pain subsides as you feel two large, scale-colored horns on your head. They are as sensitive as they are sturdy.\n\nA quick look at a puddle also reveals they radiate several specks of bioluminescent light along the horns accompanied by red tips. <b>You have about twelve inches of sea dragon-like horns!</b>";
	    } else {
	      if (player.horns.type == Horns.DEMON && player.horns.count > 4) {
	        desc += "\n\nYour horns condense, twisting around each other and merging into larger, pointed protrusions. By the time they finish you have two sea dragon horns, each about twelve inches long.";
	        player.horns.count = 12;
	      } else {
	        desc += "\n\nYou feel your horns changing and warping, and reach back to touch them. They have a slight curve and a gradual taper. They look must look like the horns of a sea dragon.";
	        if (player.horns.count > 13) {
	          desc += " The change also seems to have shrunken the horns, they're about a foot long now.";
	          player.horns.count = 12;
	        }
	      }
	    }

	    player.horns.count = 4;
	    player.horns.type = Horns.SEA_DRAGON;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.SEA_DRAGON;
	  }
	);

	public const HornsFrostwyrm: Transformation = new SimpleTransformation("Frostwyrm Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.HornsNone, doOutput);

	    desc += "You write in pain as two bony lumps begin to push out of the side of your head. The transformation gives you a hell of a headache but as soon as it is over you feel for the two large spiraling horns on your head similar to those of a ram and unsurprisingly they are as sensitive as they are sturdy. <b>You now have frost wyrm horns!</b>";

	    player.horns.count = 30;
	    player.horns.type = Horns.FROSTWYRM;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.FROSTWYRM));
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.FROSTWYRM;
	  }
	);

	public const HornsJabberwocky: Transformation = new SimpleTransformation("Jabberwocky Horns",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.horns.type === Horns.NONE) {
					desc += "\n\nYou writhe in pain as two bony extrusions begin to push out of the side of your head. As a skull-splitting headache wracks through you, in an instant, the pain subsides as you feel four large, horns on your head. They are as long and curvy.\n\n<b>You have twelve inches of bony jabberwocky horns!</b>";
				} else {
					if (player.horns.type == Horns.DEMON && player.horns.count > 4) {
						desc += "\n\nYour horns condense, twisting around each other and merging into larger, pointed protrusions. By the time they finish you have two sea dragon horns, each about twelve inches long.";
						player.horns.count = 12;
					} else {
						desc += "\n\nYou feel your horns changing and warping, and reach back to touch them. They have a slight curve and a gradual taper. They look must look like the horns of a jabberwocky.";
						if (player.horns.count > 13) {
							desc += " The change also seems to have shrunken the horns, they're about a foot long now.";
							player.horns.count = 12;
						}
					}
				}

				player.horns.count = 4;
				player.horns.type = Horns.JABBERWOCKY;
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.horns.type === Horns.JABBERWOCKY;
			}
	);

	public const HornsUshiOni: Transformation = new SimpleTransformation("Ushi-Oni Horns",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "From the back of your head you feel like something is pushing out of your skull and from the pressure a pair of horns begin to grow, continuing to get bigger and bigger, curving up along the sides of your head. You reach up to feel them and see they have a spiral shape, <b>you now have an Ushi-Oni pair of horns.</b>";

	    player.horns.count = 2;

	    player.horns.type = Horns.USHI_ONI;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.horns.type === Horns.USHI_ONI;
	  }
	);
  /*
*/

/*
*     █████  ███    ██ ████████ ███████ ███    ██ ███    ██  █████  ███████
*    ██   ██ ████   ██ 	  ██    ██      ████   ██ ████   ██ ██   ██ ██
*    ███████ ██ ██  ██    ██    █████   ██ ██  ██ ██ ██  ██ ███████ █████
*    ██   ██ ██  ██ ██    ██    ██      ██  ██ ██ ██  ██ ██ ██   ██ ██
*    ██   ██ ██   ████    ██    ███████ ██   ████ ██   ████ ██   ██ ███████
*/

/*
  */
	public const AntennaeNone: Transformation = new SimpleTransformation("No Antennae",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "The muscles in your brow clench tightly, and you feel a tremendous pressure on your upper forehead. When it passes, you touch yourself and discover your antennae.type have vanished!";
	    player.antennae.type = Antennae.NONE;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.antennae.type === Antennae.NONE;
	  }
	);

	public const AntennaeMantis: Transformation = new SimpleTransformation("Mantis Antennae",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.antennae.type == Antennae.BEE) desc += "Your head itches momentarily as your two floppy antennae changes slowly into long prehensile ones similar to those seen at mantis.";
	    else desc += "Your head itches momentarily as two long prehensile antennae sprout from your [hair].";
	    player.antennae.type = Antennae.MANTIS;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(AntennaeMem.getMemory(AntennaeMem.MANTIS));
	  },
	  // is present
	  function (): Boolean {
	    return player.antennae.type === Antennae.MANTIS;
	  }
	);

	public const AntennaeBee: Transformation = new SimpleTransformation("Bee Antennae",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.antennae.type == Antennae.MANTIS) desc += "Your head itches momentarily as your two long prehensile antennae changes slowly into floppy ones similar to those seen at bees.";
	    else desc += "Your head itches momentarily as two floppy antennae sprout from your " + hairDescript() + ".";
	    player.antennae.type = Antennae.BEE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(AntennaeMem.getMemory(AntennaeMem.BEE));
	  },
	  // is present
	  function (): Boolean {
	    return player.antennae.type === Antennae.BEE;
	  }
	);

	public const AntennaeCentipede: Transformation = new SimpleTransformation("Centipede Antennae",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your head itches momentarily as two long antennae sprout from atop your forehead. You can move both independently as if they're an extension of you.";
		player.antennae.type = Antennae.CENTIPEDE;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.antennae.type === Antennae.CENTIPEDE;
	  }
	);

	public const AntennaeFireSnail: Transformation = new SimpleTransformation("Fire Snail Antennae",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "Two large lumps suddenly pushes out of your head and before you know it a pair of prehensile horn-like antennae are flopping in front of your forehead <b>just like those of a slug or snail</b>.";

	    desc += "";
		player.antennae.type = Antennae.FIRE_SNAIL;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.antennae.type === Antennae.FIRE_SNAIL;
	  }
	);

	public const AntennaeSeaDragon: Transformation = new SimpleTransformation("Sea Dragon Antennae",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A strange feeling washes over you as something crawls along your neck. You reach your hand up as large, thin strands of flesh suddenly shoot out from right beneath your ears.\n\nIt would almost resemble tentacles, but instead, they start producing dim bioluminescent lights, much like the whiskers of deep-sea creatures. <b>Just like a sea dragon you now have four bioluminescent neck strands!</b>";
		player.antennae.type = Antennae.SEA_DRAGON;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.antennae.type === Antennae.SEA_DRAGON;
	  }
	);

	public const AntennaeJabberwocky: Transformation = new SimpleTransformation("Jabberwocky Antennae",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "A strange feeling washes over you as something crawls along your neck. You reach your hand up as two large, thin strands of scale covered flesh suddenly shoot out from right beneath your ears.\n\nIt would almost resemble tentacles thought some could say they are dragon whiskers. <b>Just like a jabberwocky you got two neck tentacles!</b>";
				player.antennae.type = Antennae.JABBERWOCKY;

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.antennae.type === Antennae.JABBERWOCKY;
			}
	);
  /*
*/

/***
*    ██   ██  █████  ██████ ██████
*    ██   ██ ██   ██   ██   ██   ██
*    ███████ ███████   ██   ██████
*    ██   ██ ██   ██   ██   ██   ██
*    ██   ██ ██   ██ ██████ ██   ██
*/

/*
  */
	public const HairHuman: Transformation = new SimpleTransformation("Human Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";
	    switch (player.hairType) {
	    case (Hair.FEATHER || Hair.QUILL):
	      var word1: String;
	      if (player.hairType == Hair.FEATHER) {
	        word1 = "feather";
	      } else {
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
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.NORMAL;
	  }
	);

	public const HairFeather: Transformation = new SimpleTransformation("Feather Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    if (doOutput) {
	      var desc: String = "";

	      desc += "A tingling starts in your scalp, getting worse and worse until you're itching like mad. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. <b>You have feathers for hair, just like a harpy!</b>";

	      outputText(desc);
	    }
	    player.hairType = Hair.FEATHER;
	    Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.FEATHER));
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.FEATHER;
	  }
	);

	public const HairGorgon: Transformation = new SimpleTransformation("Gorgon Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	    Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.GORGON));
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.GORGON;
	  }
	);

	public const HairSilky: Transformation = new SimpleTransformation("Silky Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "Something changes in your scalp, prompting you to pass a hand through it. To your surprise, your hair's texture is turning silky, far more than years of proper care would manage. The touch is so agreeable you can’t help but idly stroke your strands for a few more moments. <b>Your hair has taken on an unbelievably silky texture, just like that of an elf's!</b>";

	    if (doOutput) outputText(desc);
	    player.hairType = Hair.SILKEN;
	    Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.ELF));
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.SILKEN;
	  }
	);

	public const HairStorm: Transformation = new SimpleTransformation("Storm Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "A strange zapping sound is the only warning you receive before a weak shock runs through the back of your head. Irritated and confused, you bring a hand to the spot and rub it, only for a sudden electical noise to make itself known at the contact.\n\nKnowing for a fact that your hair shouldn't sound like that, or like anything at all for that matter, you bring both your hands to explore it and make note of several glowing strands shaped like stylized lightning bolts. There's even a single strand that floats just off the side of your face, refusing to stay down no matter how many times you try to reposition it. With a sigh, you give up on it, deciding that it's not really important to defeat your own hair. <b>You now have electrical raiju hair!</b>";

	    if (doOutput) outputText(desc);
	    player.hairType = Hair.STORM;
	    Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.STORM));
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.STORM;
	  }
	);

	public const HairBurning: Transformation = new SimpleTransformation("Burning Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.HairHuman, doOutput);

	    desc += "Your head is suddenly attacked by warmth, as though it were right next to a campfire. Before you can wonder what's going on, your hair is set ablaze in an spectacular explosion. You very nearly have a panic attack before realizing you're not being harmed by the flames, which instead fade until they only cover your hair's tips.\n\nA few tests later, and you confirm that thankfully the flames don't seem to actually burn anything unless you will them to. <b>You now have burning hellcat hair!</b>";

	    if (doOutput) outputText(desc);
	    player.hairType = Hair.BURNING;
	    Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.BURNING));
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.BURNING;
	  }
	);

	public const HairSnowy: Transformation = new SimpleTransformation("Snowy Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	  function (): Boolean {
	    return player.hairType === Hair.SNOWY;
	  }
	);

	public const HairLeaf: Transformation = new SimpleTransformation("Leaf Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "Your [hair] begins to fall out in globs, eventually leaving you with a bald head. Your head is not left bald for long, though. Within moments, a full head of leaf sprouts from the skin of your scalp. You run your hands through your new growth, sighing at the pleasure of being able to feel each individual leaf. <b>Thin leaves replaced your hair!</b>";

	    if (doOutput) outputText(desc);
	    player.hairType = Hair.LEAF;
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.LEAF;
	  }
	);

	public const HairGrass: Transformation = new SimpleTransformation("Grass Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "Your [hair] begins to fall out in clumps, eventually leaving your scalp completely bald. Although, thankfully, it does not remain like that for long. Within moments a full head of grass sprouts from the skin of your scalp, protecting it from the chilly wind which was starting to annoy you. You run your hands through your newly grown hair-like grass, stifling a moan at how sensitive the thousands of long, soft and leafy blades that replaced your hair are. <b>Your hair has been replaced by grass, your scalp is now covered with soft blades of verdant greenery.</b>";

	    if (doOutput) outputText(desc);
	    player.hairType = Hair.GRASS;
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.GRASS;
	  }
	);

	public const HairGoo: Transformation = new SimpleTransformation("Goo Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";
	    if (player.hairLength <= 0) {
	      desc += "Your head buzzes pleasantly, feeling suddenly hot and wet. You instinctively reach up to feel the source of your wetness, and discover you've grown some kind of gooey hair. From time to time it drips, running down your back to the crack of your [butt].";
	    } else {
	      if (player.hairColor.indexOf("rubbery") == -1 && player.hairColor.indexOf("latex-textured") == -1) {
	        desc += "Your head buzzes pleasantly, feeling suddenly hot and wet. You instinctively reach up to feel the source of your wetness, and discover your hair has become a slippery, gooey mess. From time to time it drips, running down your back to the crack of your [butt].";
	      }
	      //Latexy stuff
	      else {
	        desc += "Your oddly inorganic hair shifts, becoming partly molten as rivulets of liquid material roll down your back. How strange.";
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
	  function (): Boolean {
	    return player.hairType === Hair.GOO;
	  }
	);

	public const HairGhost: Transformation = new SimpleTransformation("Ghost Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "A sensation of weightlessness assaults your scalp. You reach up and grab a handful of hair, confused. Your perplexion only heightens when you actually feel the follicles becoming lighter in your grasp, before you can hardly tell you're holding anything. Plucking a strand, you hold it up before you, surprised to see... it's completely transparent! You have transparent hair!";

	    if (doOutput) outputText(desc);
	    player.hairType = Hair.GHOST;
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.GHOST;
	  }
	);

	public const HairRatatoskr: Transformation = new SimpleTransformation("Ratatoskr Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "You feel an itch in your hair and frustratedly go check on what is going on. To your surprise your hair took on a striped pattern" + " <b>like those of a ratatoskr.</b>";

	    player.hairLength = 1;

	    if (doOutput) outputText(desc);
	    player.hairType = Hair.RATATOSKR;
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.RATATOSKR;
	  }
	);

	public const HairWindswept: Transformation = new SimpleTransformation("Windswept Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "The sharp winds of your aura suddenly blow into your hair, some of the strands being cut clean. To your absolute surprise when you look them up your hair has now taken on a shape more fit to hang around without encumbering you when in the middle of a windstorm, helping your aerodynamism. <b>You now have windswept hair!</b>";

	    player.hairLength = 1;

	    if (doOutput) outputText(desc);
	    player.hairType = Hair.WINDSWEPT;
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.WINDSWEPT;
	  }
	);

	public const HairAnemone: Transformation = new SimpleTransformation("Anemone Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	  function (): Boolean {
	    return player.hairType === Hair.ANEMONE;
	  }
	);

	public const HairFluffy: Transformation = new SimpleTransformation("Fluffy Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "Your hair starts to grow longer and fluffier. It covers all sides of your head perfectly, like a furry helmet, keeping it warm. Only your face and neck are devoid of this hairy armor which still manage to look like a nice short haircut. While it looks like hair at first, touching it proves it to be like a very thick coat of fluff. You now have <b>yeti fluffy [haircolor] hair.</b>";

	    if (doOutput) outputText(desc);
	    player.hairType = Hair.FLUFFY;
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.FLUFFY;
	  }
	);

	public const HairCrazy: Transformation = new SimpleTransformation("Crazy Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	  function (): Boolean {
	    return player.hairType === Hair.CRAZY;
	  }
	);

	public const HairPrismatic: Transformation = new SimpleTransformation("Prismatic Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "You feel your hair begin to slicken with a strange mucus as a fresh coating covers them. You move over to the puddle, gazing at your reflection as the light bounces into your eyes. \n\nYou strain briefly before looking upon your reflection once more. Your hair now glows with a vibrant, multicolored hue, with every color in the spectrum. The prismatic beauty is quite the sight, though your hair remains slick as if you've recently gelled it. Still they turn to [haircolor] toward the root like your old human hair. <b>Your hair is now prismatic!</b>";

	    if (doOutput) outputText(desc);
	    player.hairType = Hair.PRISMATIC;
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.PRISMATIC;
	  }
	);

	public const HairQuill: Transformation = new SimpleTransformation("Quill Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "Your scalp begins to tingle as your hair falls out in clumps, leaving you with a bald head. You aren’t bald for long, though. An uncomfortable pressure racks the entirety of your scalp as hard quills begin to sprout from your hair pores. Their growth stops as they reach shoulder length. <b>You now have quills in place of your hair!</b>";

	    if (doOutput) outputText(desc);
	    player.hairType = Hair.QUILL;
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.QUILL;
	  }
	);

	public const HairFairy: Transformation = new SimpleTransformation("Fairy Hair",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (doOutput) outputText(desc);
	    player.hairType = Hair.FAIRY;
	  },
	  // is present
	  function (): Boolean {
	    return player.hairType === Hair.FAIRY;
	  }
	);

	public const HairCow: Transformation = new SimpleTransformation("Fairy Hair",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "You feel an itch in your hair and frustratedly go check on what is going on. To your surprise your hair took on a striped pattern" + " <b>like those of a cow.</b>";

				if (doOutput) outputText(desc);
				player.hairType = Hair.COW;
			},
			// is present
			function (): Boolean {
				return player.hairType === Hair.COW;
			}
	);

	public function HairChangeColor(colors: /*String*/ Array): Transformation {
	  return new SimpleTransformation("Hair Color: " + colors.join("|"),
	    // apply effect
	    function (doOutput: Boolean): void {
	      var color: String = randomChoice(colors);
	      player.hairColorOnly = color;
	      var desc: String = "";

	      desc += "Your scalp begins to tingle, and you gently grasp a strand of hair, pulling it out to check it. Your hair has become [haircolor]!";

	      if (doOutput) outputText(desc);
	    },
	    // is present
	    function (): Boolean {
	      return InCollection(player.hairColor, colors);
	    }
	  )
	}
  /*
*/

/*
*    ███████  █████   ██████ ███████
*    ██      ██   ██ ██      ██
*    █████   ███████ ██      █████
*    ██      ██   ██ ██      ██
*    ██      ██   ██  ██████ ███████
*/

/*
  */
	public const FaceHuman: Transformation = new SimpleTransformation("Human Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You bring your hands to your [face] as a sudden agony sweeps over it. Through the pain, you can feel its shape changing, details shifting little by little with purpose. When you come back to your senses, you notice <b>you have a perfectly normal human face again!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.HUMAN;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.HUMAN;
	  }
	);

	public const FaceHorse: Transformation = new SimpleTransformation("Horse Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.faceType == Face.DOG) desc += "Mind-numbing pain shatters through you as you feel your facial bones rearranging. You clutch at your face in agony as your skin crawls and shifts, your visage reshaping to replace your dog-like characteristics with those of a horse. <b>You now have a horse's face.</b>";
	    else desc += "Mind-numbing pain shatters through you as you feel your facial bones breaking and shifting. You clutch at yourself in agony as you feel your skin crawl and elongate under your fingers. Eventually the pain subsides, leaving you with a face that seamlessly blends human and equine features. <b>You have a very equine-looking face.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.HORSE;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.HORSE));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.HORSE;
	  }
	);

	public const FaceDog: Transformation = new SimpleTransformation("Dog Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.faceType == Face.HORSE) desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else. <b>Your horse-like features rearrange to take on many canine aspects.</b>";
	    else desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different. You find a puddle to view your reflection...<b>your face is now a cross between human and canine features.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.DOG;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.DOG;
	  }
	);

	public const FaceCowMinotaur: Transformation = new SimpleTransformation("Cow Minotaur Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "Your visage twists painfully, warping and crackling as your bones are molded into a new shape. Once it finishes, you reach up to touch it, and you discover that <b>you now have a bovine face!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.COW_MINOTAUR;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.COW_MINOTAUR));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.COW_MINOTAUR;
	  }
	);

	public const FaceSharkTeeth: Transformation = new SimpleTransformation("Shark Teeth Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

	    desc += "Your [face] explodes with agony, reshaping into a more human-like visage. You firmly grasp your mouth, an intense pain racking your oral cavity. Your gums shift around and the bones in your jaw reset. You blink a few times wondering what just happened. You move over to a puddle to catch sight of your reflection, and you are thoroughly surprised by what you see. A set of retractable shark fangs have grown in front of your normal teeth, and your face has elongated slightly to accommodate them! They even scare you a little.\n(Gain: 'Bite' special attack)";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.SHARK_TEETH;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.SHARK_TEETH));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.SHARK_TEETH;
	  }
	);

	public const FaceSnakeFangs: Transformation = new SimpleTransformation("Snake Fangs Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Without warning, you feel your canine teeth jump almost an inch in size, clashing on your gums, cutting yourself quite badly. As you attempt to find a new way to close your mouth without dislocating your jaw, you notice that they are dripping with a bitter, khaki liquid. Watch out, and <b>try not to bite your tongue with your poisonous fangs!</b>";
	    if (!Face.isHumanShaped(player.faceType)) desc += " As the change progresses, your [face] reshapes. The sensation is far more pleasant than teeth cutting into gums, and as the tingling transformation completes, <b>you've gained with a normal-looking, human visage.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.SNAKE_FANGS;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.SNAKE_FANGS));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.SNAKE_FANGS;
	  }
	);

	public const FaceCat: Transformation = new SimpleTransformation("Cat Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";
	    var choice: int = rand(3);

	    if (choice == 0) desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different. You find a puddle to view your reflection and discover <b>your face is now a cross between human and feline features.</b>";
	    else if (choice == 1) desc += "Mind-numbing pain courses through you as you feel your facial bones rearranging. You clutch at your face in agony as your skin crawls and shifts, your visage reshaping to replace your facial characteristics with those of a feline. <b>You now have an anthropomorphic cat-face.</b>";
	    else desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else. <b>Your facial features rearrange to take on many feline aspects.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.CAT;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.CAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.CAT;
	  }
	);

	public const FaceCatCanines: Transformation = new SimpleTransformation("Cat Canines Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";
			var startsWithCatFace: Boolean = player.faceType === Face.CAT;

	    TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

	    if (!startsWithCatFace) desc += "You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You purr at the change it gives you a cute look. <b>Your mouth is now filled with cat-like canines.</b>";
			else desc += "However, your mouth remains filled with cat-like canines."

	    if (doOutput) outputText(desc);
	    player.faceType = Face.CAT_CANINES;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.CAT_CANINES));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.CAT_CANINES;
	  }
	);

	public const FaceLizard: Transformation = new SimpleTransformation("Lizard Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Terrible agony wracks your [face] as bones crack and shift. Your jawbone rearranges while your cranium shortens. The changes seem to last forever; once they've finished, no time seems to have passed. Your fingers brush against your toothy snout as you get used to your new face. It seems <b>you have a toothy, reptilian visage now.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.LIZARD;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.LIZARD));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.LIZARD;
	  }
	);

	public const FaceBunny: Transformation = new SimpleTransformation("Bunny Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You grunt as your [face] twists and reforms. Even your teeth ache as their positions are rearranged to match some new, undetermined order. When the process finishes, <b>you're left with a bunny face complete with a constantly twitching nose and prominent buck-teeth.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.BUNNY;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.BUNNY;
	  }
	);

	public const FaceKangaroo: Transformation = new SimpleTransformation("Kangaroo Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.faceType == Face.HUMAN || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.SHARK_TEETH || player.faceType == Face.BUNNY) desc += "The base of your nose suddenly hurts, as though someone were pinching and pulling at it. As you shut your eyes against the pain and bring your hands to your face, you can feel your nose and palate shifting and elongating. This continues for about twenty seconds as you stand there, quaking. When the pain subsides, you run your hands all over your face; what you feel is a long muzzle sticking out, whiskered at the end and with a cleft lip under a pair of flat nostrils. You open your eyes and receive confirmation. <b>You now have a kangaroo face!  Crikey!</b>";
	    else desc += "Your nose tingles. As you focus your eyes toward the end of it, it twitches and shifts into a muzzle similar to a stretched-out rabbit's, complete with harelip and whiskers. <b>You now have a kangaroo face!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.KANGAROO;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.KANGAROO;
	  }
	);

	public const FaceSpiderFangs: Transformation = new SimpleTransformation("Spider Fangs Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "Tension builds within your upper gum, just above your canines. You open your mouth and prod at the affected area, pricking your finger on the sharpening tooth. It slides down while you're touching it, lengthening into a needle-like fang. You check the other side and confirm your suspicions. <b>You now have a pair of pointy spider-fangs, complete with their own venom!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.SPIDER_FANGS;
	    if (player.tailRecharge < 5) player.tailRecharge = 5;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.SPIDER));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.SPIDER_FANGS;
	  }
	);

	public const FaceFox: Transformation = new SimpleTransformation("Fox Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your face pinches and you clap your hands to it. Within seconds, your nose is poking through those hands, pushing them slightly to the side as new flesh and bone build and shift behind it, until it stops in a clearly defined, tapered, and familiar point you can see even without the aid of a mirror. <b>Looks like you now have a fox's face.</b>";
	    if (silly()) desc += "  And they called you crazy...";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.FOX;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.FOX));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.FOX;
	  }
	);

	public const FaceDragon: Transformation = new SimpleTransformation("Draconic Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You scream as your face is suddenly twisted; your facial bones begin rearranging themselves under your skin, restructuring into a long, narrow muzzle. Spikes of agony rip through your jaws as your teeth are brutally forced from your gums, giving you new rows of fangs - long, narrow and sharp. Your jawline begins to sprout strange growths; small spikes grow along the underside of your muzzle, giving you an increasingly inhuman visage.\n\nFinally, the pain dies down, and you look for a convenient puddle to examine your changed appearance.\n\nYour head has turned into a reptilian muzzle, with small barbs on the underside of the jaw. <b>You now have a dragon's face.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.DRAGON;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.DRAGON));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.DRAGON;
	  }
	);

	public const FaceDragonFangs: Transformation = new SimpleTransformation("Draconic Fangs Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Sudden agony sweeps over your [face], your visage turning hideous as bones twist and your jawline shifts. The pain slowly vanishes, leaving you weeping into your fingers. When you pull your hands away you realize you've been left with a completely normal, human face. But then your tooth's suddenly hurt as they begin to change. Your canines getting sharper and more adapted to eating meat just like those of a dragon. <b>You now have dragon fangs.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.DRAGON_FANGS;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.DRAGON_FANGS));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.DRAGON_FANGS;
	  }
	);

	public const FaceRaccoonMask: Transformation = new SimpleTransformation("Raccoon Mask Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.faceType == Face.HUMAN || player.faceType == Face.SHARK_TEETH || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.BUNNY) {
	      desc += "A sudden wave of exhaustion passes over you, and your face goes partially numb around your eyes. ";
	      if (player.faceType == Face.SHARK_TEETH || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.BUNNY) {
	        desc += "Your prominent teeth chatter noisily at first, then with diminishing violence, until you can no longer feel them jutting past the rest!  ";
	      }
	      desc += "Shaking your head a bit, you wait for your energy to return, then examine your appearance. ";
	      if (((player.skin.base.color == "ebony" || player.skin.base.color == "black") && !player.hasCoat()) || ((player.hairColor == "black" || player.hairColor == "midnight") && (player.hasFur() || player.hasScales()))) {
	        desc += "Nothing seems different at first. Strange... you look closer and discover a darker, mask-line outline on your already inky visage. Furthermore your canines have slightly alongated not unlike those of an animal. <b>You now have a barely-visible raccoon mask and sharp canines like those of a raccoon.</b>";
	      } else desc += "A dark, almost black mask shades the " + player.skinFurScales() + " around your eyes and over the topmost portion of your nose, lending you a criminal air! Furthermore your canines have slightly alongated not unlike those of an animal. <b>You now have a raccoon mask and sharp canines like those of a raccoon!</b>";
	    } else {
	      desc += "A sudden migraine sweeps over you and you clutch your head in agony as your nose collapses back to human dimensions. A worrying numb spot grows around your eyes, and you entertain several horrible premonitions until it passes as suddenly as it came. Checking your reflection in your water barrel, you find ";
	      //[(if black/midnight fur or if black scales)
	      if (((player.hairColor == "black" || player.hairColor == "midnight") && (player.hasFur() || player.hasScales()))) desc += "your face apparently returned to normal shape, albeit still covered in " + player.skinFurScales() + ". You look closer and discover a darker, mask-line outline on your already inky visage. <b>You now have a barely-visible raccoon mask on your otherwise normal human face.</b>";
	      else if ((player.skin.base.color == "ebony" || player.skin.base.color == "black") && (!player.hasCoat())) desc += "your face apparently returned to normal shape. You look closer and discover a darker, mask-line outline on your already inky visage. <b>You now have a barely-visible raccoon mask on your normal human face.</b>";
	      else desc += "your face returned to human dimensions, but shaded by a black mask around the eyes and over the nose!  <b>You now have a humanoid face with a raccoon mask!</b>";
	    }

	    if (doOutput) outputText(desc);
	    player.faceType = Face.RACCOON_MASK;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.RACCOON_MASK;
	  }
	);

	public const FaceRaccoon: Transformation = new SimpleTransformation("Raccoon Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your face pinches with tension, and you rub the bridge of your nose to release it. The action starts a miniature slide in your bone structure, and your nose extends out in front of you!  You shut your eyes, waiting for the sinus pressure to subside, and when you open them, a triangular, pointed snout dotted with whiskers and capped by a black nose greets you!  <b>You now have a raccoon's face!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.RACCOON;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.RACCOON;
	  }
	);

	public const FaceBuckteeth: Transformation = new SimpleTransformation("Buckteeth Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your teeth grind on their own, and you feel a strange, insistent pressure just under your nose. As you open your mouth and run your tongue along them, you can feel ";
	    if (player.faceType != Face.HUMAN) desc += "the sharp teeth receding and ";
	    desc += "your incisors lengthening. It's not long before they're twice as long as their neighbors and the obvious growth stops, but the pressure doesn't go away completely. Well, you now have rodent incisors and your face aches a tiny bit - wonder if they're going to keep growing? <b>Your mouth has taken on some rabbit-like characteristics!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.BUCKTEETH;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.BUCKTEETH));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.BUCKTEETH;
	  }
	);

	public const FaceMouse: Transformation = new SimpleTransformation("Mouse Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A wave of light-headedness hits you, and you black out. In your unconsciousness, you dream of chewing - food, wood, cloth, paper, leather, even metal... whatever you can fit in your mouth, even if it doesn't taste like anything much. For several minutes you just chew and chew your way through a parade of ordinary objects, savoring the texture of each one against your teeth, until finally you awaken. Your teeth work, feeling longer and more prominent than before, and you hunt up your reflection. <b>Your face has shifted to resemble a mouse's, down to the whiskers!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.MOUSE;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.MOUSE));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.MOUSE;
	  }
	);

	public const FaceFerretMask: Transformation = new SimpleTransformation("Ferret Mask Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A horrible itching begins to encompass the area around your eyes. You grunt annoyedly, rubbing furiously at the afflicted area. Once the feeling passes, you make your way to the nearest reflective surface to see if anything has changed. Your suspicions are confirmed. The [skinFurScales] around your eyes has darkened. <b>You now have a ferret mask!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.FERRET_MASK;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.FERRET_MASK;
	  }
	);

	public const FaceFerret: Transformation = new SimpleTransformation("Ferret Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new ferret face!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.FERRET;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.FERRET;
	  }
	);

	public const FacePig: Transformation = new SimpleTransformation("Pig Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new pig face!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.PIG;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.PIG));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.PIG;
	  }
	);

	public const FaceBoar: Transformation = new SimpleTransformation("Boar Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. Your bottom teeth ache as well. What’s happening to you? As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new tusky boar face!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.BOAR;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.BOAR));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.BOAR;
	  }
	);

	public const FaceRhino: Transformation = new SimpleTransformation("Rhino Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your face suddenly goes numb. You begin to hear bone cracking as you vision suddenly shifts as you face stretches out and thickens. When your face is done growing you can see the edges of your elongated mouth and noise in the center of your field of vision. They barely impede your vision though. <b>You now have a rhino face.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.RHINO;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.RHINO;
	  }
	);

	public const FaceEchidna: Transformation = new SimpleTransformation("Echidna Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You groan loudly as the bones in your face begin to reshape and rearrange. Most notable, you feel your mouth lengthening into a long, thin snout. <b>You now have an echidna face!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.ECHIDNA;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.ECHIDNA;
	  }
	);

	public const FaceDeer: Transformation = new SimpleTransformation("Deer Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel a grinding noise from your jaw, and a massive pressure in your sinuses, as your cheeks pinch in, followed immediately by a pointing of the lower half of your face. You frantically (and gently) feel your face, discovering, to your surprise, that you’ve <b>gained the delicate facial features of a deer.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.DEER;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.DEER;
	  }
	);

	public const FaceWolf: Transformation = new SimpleTransformation("Wolf Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting reforming into something... different, your screams turning into a howl as the change ends. You go to find a puddle in order to view your reflection... <b>Your face looks like the one of a feral looking wolf composed of a maw jagged with threatening canines a wet muzzle and a animalistic tongue.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.WOLF;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.WOLF_FACE));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.WOLF;
	  }
	);

	public const FaceManticore: Transformation = new SimpleTransformation("Manticore Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

	    desc += "You feel your canines changing, elongating into sharp, dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You feel the need to roar like a lion, to show the world how ferocious you are. <b>Your mouth is now filled with dagger-like canines!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.MANTICORE;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.MANTICORE));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.MANTICORE;
	  }
	);

	public const FaceSalamanderFangs: Transformation = new SimpleTransformation("Salamander Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your tooth's suddenly hurt as you feel them changing. Your canines getting sharper and more adapted to eating meat. <b>You now have fangs.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.SALAMANDER_FANGS;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.SALAMANDER_FANGS));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.SALAMANDER_FANGS;
	  }
	);

	public const FaceYetiFangs: Transformation = new SimpleTransformation("Yeti Fangs Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel your canines elongate and sharpen. Your mouth feels somewhat like a human one still, but when you feel your teeth with your tongue you discover that your canines have pretty much turned into proper fangs. <b>You now have yeti fangs.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.YETI_FANGS;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.YETI_FANGS;
	  }
	);

	public const FaceOrca: Transformation = new SimpleTransformation("Orca Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your nose starts to tingle, getting bigger and rounder as your facial features take on a bombed shape. Your nasal hole disappears entirely as you feel your mouth change, your dentition turning into pointed teeth fit for an orca. You go look at your reflection in the water to be sure, and discover your face is now similar in shape to that of a killer whale. Um… you could use a fish or two, you are getting pretty hungry. <b>Taking a bite out of fresh fish would be great with your new orca face.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.ORCA;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.ORCA));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.ORCA;
	  }
	);

	public const FacePlantDragon: Transformation = new SimpleTransformation("Plant Dragon Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "The familiar tingle of transformation spreads across your face. Your ";
	    if (player.hasMuzzle()) desc += "muzzle";
	    else desc += "face";
	    desc += " shifts into a vaguely triangular shape, something that would look at home on a predatory reptile... or a dragon. You feel pride swell within you as you look at your reflection inh a puddle at your feet, your new look now resembles a majestic creature of the old myths. <b>Your face is now a dragonlike muzzle!</b>\n\n";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.PLANT_DRAGON;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.PLANT_DRAGON;
	  }
	);

	public const FaceDevilFangs: Transformation = new SimpleTransformation("Devil Fangs Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel your canines grow slightly longer to take on a sharp appearance like those of a beast. Perhaps not as long as you thought they would end up as but clearly they make your smile all the more fiendish. <b>You now have demonic fangs!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.DEVIL_FANGS;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.DEVIL_FANGS));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.DEVIL_FANGS;
	  }
	);

	public const FaceOniTeeth: Transformation = new SimpleTransformation("Oni Teeth Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

	    desc += "You feel your canines changing, growing bigger and slightly sharper. Hey, you could pretend to be some kind of demon with that kind of mouth. <b>You now have oni canines.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.ONI_TEETH;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.ONI_TEETH));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.ONI_TEETH;
	  }
	);

	public const FaceWeasel: Transformation = new SimpleTransformation("Weasel Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

	    desc += "You feel your two canines grow bigger and slightly sharper, not unlike those of a weasel. <b>You now have weasel canines.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.WEASEL;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.WEASEL));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.WEASEL;
	  }
	);

	public const FaceVampire: Transformation = new SimpleTransformation("Vampire Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You yelp as a throbbing pain takes root in the sides of your mouth. You feel your canines grow longer as your throat grow dryer. You could go for some wine right now, with a bloody steak to top it off… maybe just the steak. Or just the blood, really. You aren’t picky. Really, it’s up to you whether just rip off some poor sod’s throat and drink straight from the tap or drink blood from a wineglass, what with <b>your new vampire fangs!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.VAMPIRE;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.VAMPIRE));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.VAMPIRE;
	  }
	);

	public const FaceBucktooth: Transformation = new SimpleTransformation("Bucktooth Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "While you are busy laughing at the ridicule of this situation your bucktooth begin to pulse in accordance with your laughter growing almost to rabbit like size. You now have Jabberwocky buck tooths!";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.BUCKTOOTH;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.BUCKTOOTH;
	  }
	);

	public const FaceJabberwocky: Transformation = new SimpleTransformation("Jabberwocky Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "While you are busy laughing at the ridicule of this situation your bucktooth begin to pulse in accordance with your laughter growing almost to rabbit like size. You now have a Jabberwocky face!";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.JABBERWOCKY;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.JABBERWOCKY;
	  }
	);

	public const FaceRedPanda: Transformation = new SimpleTransformation("Red Panda Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Numbness comes to your cheekbones and jaw, while the rest of your head is overwhelmed by a tingling sensation. Every muscle on your face tenses and shifts, while the bones and tissue rearrange, radically changing the shape of your head. You have troubles breathing as the changes reach your nose, but you manage to see as it changes into an animalistic muzzle. You jaw joins it and your teeth sharpen a little, not to the point of being true menacing, but gaining unequivocally the shape of those belonging on a little carnivore.\n\nOnce you’re face and jaw has reshaped, fur covers the whole of your head. The soft sensation is quite pleasant. It has a russet-red coloration, that turns to white on your muzzle and cheeks. Small, rounded patches of white cover the area where your eyebrows were. <b>You now have a red-panda head!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.RED_PANDA;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.RED_PANDA));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.RED_PANDA;
	  }
	);

	public const FaceCheshire: Transformation = new SimpleTransformation("Cheshire Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";
			var startsWithCheshireSmile: Boolean = player.faceType === Face.CHESHIRE_SMILE;

	    TransformationUtils.applyTFIfNotPresent(transformations.FaceCat, doOutput);

			if (!startsWithCheshireSmile) desc += "You suddenly feel like smiling. Why actually look so serious? Everything is easier if you take it with a smile and a laughter. Perhaps it's just you taking on that mentality or it's that weird wonderfruit you took but now you feel you could smile forever showing that wide grin of yours. <b>You now have a cheshire smile.</b>";
			else desc += "Of course, your fanged cheshire smile is still there."

	    if (doOutput) outputText(desc);
	    player.faceType = Face.CHESHIRE;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.CHESHIRE));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.CHESHIRE;
	  }
	);

	public const FaceCheshireSmile: Transformation = new SimpleTransformation("Cheshire Smile Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";
			var startsWithCheshireFace: Boolean = player.faceType === Face.CHESHIRE;

			if (player.faceType !== Face.CAT_CANINES) {
	    	TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);
	    	TransformationUtils.applyTFIfNotPresent(transformations.FaceCatCanines, !startsWithCheshireFace);
			}

			if (!startsWithCheshireFace) desc += "You suddenly feel like smiling. Why actually look so serious? Everything is easier if you take it with a smile and a laughter. Perhaps it's just you taking on that mentality or it's that weird wonderfruit you took but now you feel you could smile forever showing that wide grin of yours. <b>You now have a cheshire smile.</b>";
			else desc += "Of course, your fanged cheshire smile is still there."

	    if (doOutput) outputText(desc);
	    player.faceType = Face.CHESHIRE_SMILE;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.CHESHIRE_SMILE));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.CHESHIRE_SMILE;
	  }
	);

	public const FaceAvian: Transformation = new SimpleTransformation("Avian Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.AVIAN;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.AVIAN;
	  }
	);

	public const FaceWolfFangs: Transformation = new SimpleTransformation("Wolf Fangs Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.WOLF_FANGS;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.WOLF_FANGS;
	  }
	);

	public const FaceOrcFangs: Transformation = new SimpleTransformation("Orc Fangs Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

	    desc += "You feel your two lower canines grow bigger and slightly sharper, similar to those of a boar, or in your case, an orc. <b>You now have orc canines.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.ORC_FANGS;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.ORC_FANGS));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.ORC_FANGS;
	  }
	);

	public const FaceAnimalTeeth: Transformation = new SimpleTransformation("Animal Teeth Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

	    desc += "You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. That said, your face remained relatively human even after the change. <b>Your mouth is now filled with sharp canines.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.ANIMAL_TOOTHS;
	    Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.ANIMAL_TOOTHS));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.ANIMAL_TOOTHS;
	  }
	);

	public const FaceBear: Transformation = new SimpleTransformation("Bear Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your nose start to tingle as your general face shape surge forward into a muzzle complete with sharp teeth. At first you though it was a dog face but after further examination conclude it has more in common with bears then canines. <b>You now have a bear face.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.BEAR;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.BEAR;
	  }
	);

	public const FacePanda: Transformation = new SimpleTransformation("Panda Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your nose start to tingle as your general face shape surge forward into a muzzle complete with sharp teeth. At first you though it was a dog face but after further examination conclude it has more in common with bears then canines. <b>You now have a panda face.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.PANDA;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.PANDA;
	  }
	);

	public const FaceFireSnail: Transformation = new SimpleTransformation("Fire Snail Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Just as you though the whole sweating situation couldn't get worse you’re suddenly are assaulted by a spike of pleasure, your entire undercarriage feeling like one single sexual organ. You begin to drool and before you know it you’re constantly drooling from arousal and can't stop. You eventually manage to recover bodily motions but not exactly full control of the drooling which persist. <b>Guess you're stuck with a drooling mouth for a while.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.FIRE_SNAIL;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.FIRE_SNAIL;
	  }
	);

	public const FaceGhost: Transformation = new SimpleTransformation("Ghost Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your face slowly grows numb and stiff. The muscles in your face seem to pull and shift. As the numbness fades, you notice that your face is stuck in a permanent smile. You try to stop smiling but the muscles in your face refuse to budge. <b>People might be disturbed by your unsettling smile.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.GHOST;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.GHOST;
	  }
	);

	public const FaceJiangshi: Transformation = new SimpleTransformation("Jiangshi Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.JIANGSHI;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.JIANGSHI;
	  }
	);

	public const FaceYukiOnna: Transformation = new SimpleTransformation("Yuki Onna Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your lips go numb with cold for a moment and you can barely feel them. You raise your hands and poke at them finding that they are still there and slowly feeling trickles back into them. You examine them and find that they have turned pale blue in color, a sign of the cold nature you now possess, small fumes of cold air regularly escaping your lip.";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.YUKI_ONNA;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.YUKI_ONNA;
	  }
	);

	public const FaceKudere: Transformation = new SimpleTransformation("Kudere Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Hey, why do you even bother with those expressions? Your flat tone and emotionless face is the perfect armor against all the lust mongers out there. Let them guess whether you are aroused or not. Only your bodily movement can betray your hidden desires to mate or your anger now. <b>You now have an expressionless visage.";
	    if (silly()) desc += "Card sharks would gladly sell their souls for a poker face as good as yours.";
	    desc += "</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.KUDERE;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.KUDERE;
	  }
	);

	public const FaceUshiOniOnna: Transformation = new SimpleTransformation("Ushi Oni/Onna Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel something under the skin around your eyes and in your mouth as they begin to burn, smoke coming out of it, from the bottom of your eyes, circling to the upper part. In your mouth your teeth make cracking noises as they remodel themselves. After the torturing experience you feel like <b>you've gained Ushi-" + player.mf("Oni", "Onna") + " fangs,</b> going to a barrel with water you see your face now has a strange tattoo around your eyes.";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.USHI_ONI;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.USHI_ONI;
	  }
	);

	public const FaceFairy: Transformation = new SimpleTransformation("Fairy Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.FAIRY;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.FAIRY;
	  }
	);

	public const FaceCrazy: Transformation = new SimpleTransformation("Crazy Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Thinking on it, you’re smart, small and smuggly. The whole idea makes you laugh uncontrollably. But hey seriously since you’re the superior genius around here, might as well flash these idiots an unsettling smile, heck just thinking about how stupid everyone else is makes you smirk constantly, halfway to laughter. Well they might call you crazy but once you bury these primitive fools in the ground they'll all be the crazy ones. <b>You’re now constantly flashing a crazy grin just like a gremlin.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.CRAZY;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.CRAZY;
	  }
	);

	public const FaceSmug: Transformation = new SimpleTransformation("Smug Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

	    desc += "You suddenly feel pain in your mouth as if something had suddenly grown. At first you think nothing happened but after double checking you confirm that your buck teeth are slightly larger than normal. <b>Your face is now human save for your two buck teeth like those of a squirrel.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.SMUG;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.SMUG;
	  }
	);

	public const FaceSquirrel: Transformation = new SimpleTransformation("Squirrel Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A wave of lightheadedness hits you and you black out. In your unconsciousness, you dream of chewing - food, wood, cloth, paper, leather, even metal... whatever you can fit in your mouth, even if it doesn’t taste like anything though, what you dream most of is big hard nuts. For several minutes you just chew and chew your way through a parade of ordinary objects, savoring the texture of each one against your teeth, until finally you awaken. Your teeth work, feeling longer and more prominent than before, and you hunt up your reflection. <b>Your face has shifted to resemble a squirrel’s!</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.SQUIRREL;
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.SQUIRREL;
	  }
	);

	public const FaceElf: Transformation = new SimpleTransformation("Elf Face",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel tingling across your visage as some small changes begin to happen to it. Curious, you go look down by the nearest pool of water and notice to your amazement that the general shape of your mouth has changed to be in perfect alignment! No tooth is misaligned and your disarming, innocent smile revealing pearlescent white teeth would melt the coldest of hearts.<b>Guess your face is more like that of an elf now.</b>";

	    if (doOutput) outputText(desc);
	    player.faceType = Face.ELF;
		  Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.ELF_FACE));
	  },
	  // is present
	  function (): Boolean {
	    return player.faceType === Face.ELF;
	  }
	);
  /*
*/

/*
*    ████████  ██████  ███    ██  ██████  ██    ██ ███████
*       ██    ██    ██ ████   ██ ██       ██    ██ ██
*       ██    ██    ██ ██ ██  ██ ██   ███ ██    ██ █████
*       ██    ██    ██ ██  ██ ██ ██    ██ ██    ██ ██
*       ██     ██████  ██   ████  ██████   ██████  ███████
*/

/*
  */
	public const TongueHuman: Transformation = new SimpleTransformation("Human Tongue",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel something strange with your tongue. When you pull it out to check what is going on, <b>you realize your tongue is perfectly human again!</b>";
	    player.tongue.type = Tongue.HUMAN;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tongue.type === Tongue.HUMAN;
	  }
	);

	public const TongueCat: Transformation = new SimpleTransformation("Cat Tongue",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your tongue suddenly feels weird. You try to stick it out to see what’s going on and discover it changed to look similar to the tongue of a cat. At least you will be able to groom yourself properly with <b>your new cat tongue.</b>";
	    player.tongue.type = Tongue.CAT;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.CAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.tongue.type === Tongue.CAT;
	  }
	);

	public const TongueElf: Transformation = new SimpleTransformation("Elf Tongue",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your throat starts to ache and your tongue tingles. You try to gasp for air, your eyes opening wide in surprise as the voice that exits your throat is entirely changed. Your words are notes, your sentence a melody. Your voice is like music to your ears and you realize it is because your body became closer to that of an elf, adapting even your tongue and voice. <b>You now have the beautiful voice of the elves.</b>";
	    player.tongue.type = Tongue.ELF;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.ELF));
	  },
	  // is present
	  function (): Boolean {
	    return player.tongue.type === Tongue.ELF;
	  }
	);

	public const TongueDraconic: Transformation = new SimpleTransformation("Dragon Tongue",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your tongue suddenly falls out of your mouth and begins undulating as it grows longer. For a moment it swings wildly, completely out of control; but then settles down and you find you can control it at will, almost like a limb. You're able to stretch it to nearly 4 feet and retract it back into your mouth to the point it looks like a normal human tongue. <b>You now have a draconic tongue.</b>";

	    player.tongue.type = Tongue.DRACONIC;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.DRACONIC));
	  },
	  // is present
	  function (): Boolean {
	    return player.tongue.type === Tongue.DRACONIC;
	  }
	);

	public const TongueSnake: Transformation = new SimpleTransformation("Snake Tongue",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.tongue.type == Tongue.HUMAN) desc += "Your taste-buds start aching as they swell to an uncomfortably large size. Trying to understand what in the world could have provoked such a reaction, you bring your hands up to your mouth, your tongue feeling like it's trying to push its way past your lips. The soreness stops and you stick out your tongue to try and see what would have made it feel the way it did. As soon as you stick your tongue out you realize that it sticks out much further than it did before, and now appears to have split at the end, creating a forked tip. The scents in the air are much more noticeable to you with your snake-like tongue.";
	    else desc += "Your inhuman tongue shortens, pulling tight in the very back of your throat. After a moment the bunched-up tongue-flesh begins to flatten out, then extend forwards. By the time the transformation has finished, your tongue has changed into a long, forked snake-tongue.";
	    player.tongue.type = Tongue.SNAKE;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.SNAKE));
	  },
	  // is present
	  function (): Boolean {
	    return player.tongue.type === Tongue.SNAKE;
	  }
	);

	public const TongueDemonic: Transformation = new SimpleTransformation("Demonic Tongue",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your tongue tingles";
	    if (player.tongue.type != Tongue.HUMAN) desc += ", thickening in your mouth until it feels more like your old human tongue, at least for the first few inches";
	    desc += ". It bunches up inside you, and when you open up your mouth to release it, roughly two feet of tongue dangles out. You find it easy to move and control, as natural as walking. <b>You now have a long demon-tongue.</b>";

	    player.tongue.type = Tongue.DEMONIC;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.DEMONIC));
	  },
	  // is present
	  function (): Boolean {
	    return player.tongue.type === Tongue.DEMONIC;
	  }
	);

	public const TongueRavenous: Transformation = new SimpleTransformation("Ravenous Tongue",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";

	    player.tongue.type = Tongue.RAVENOUS_TONGUE;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tongue.type === Tongue.RAVENOUS_TONGUE;
	  }
	);

	public const TongueCaveWyrm: Transformation = new SimpleTransformation("Cave Wyrm Tongue",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Something change in your mouth and you feel like you are about to choke! You stick your tongue out and discover to your surprise that it now glows with a neon blue light. Furthermore it stick out way further then it should, just like a lizard. <b>You now have a neon blue lizard tongue that glow in the dark.</b>";

	    player.tongue.type = Tongue.CAVE_WYRM;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.CAVE_WYRM));
	  },
	  // is present
	  function (): Boolean {
	    return player.tongue.type === Tongue.CAVE_WYRM;
	  }
	);

	public const TongueGhost: Transformation = new SimpleTransformation("Ghost Tongue",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your tongue tingles and feels heavy in your mouth. Your tongue slips out further than what is considered normal. Your tongue grows at least a foot in length, tapering to a point. It slowly becomes more transparent until you’re able to see right through it. <b>You now have a long transparent ghostly tongue.</b>";

	    player.tongue.type = Tongue.GHOST;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tongue.type === Tongue.GHOST;
	  }
	);

	public const TongueRatatoskr: Transformation = new SimpleTransformation("Ratatoskr Tongue",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your tongue begins to feel stingy and dry, your throat too. You have difficulty speaking so you drink some water and try some basic pronunciation exercises. You find out to your absolute surprise you now have a talent with words and linguistics that you didn't use to, heck it's like the range and variety of sounds you can make just doubled. <b>Your skill with words just improved by leaps and bounds with your new Ratatoskr tongue.</b>";

	    player.tongue.type = Tongue.RATATOSKR;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tongue.type === Tongue.RATATOSKR;
	  }
	);

	public const TongueMelkie: Transformation = new SimpleTransformation("Melkie Tongue",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your throat starts to ache and your tongue tingles. You try to gasp for air, your eyes opening wide in surprise as your voice exit your throat entirely changed. Your words are notes, your sentence a melody. Your voice is like music to your ears and you realise it is because your body became closer to that of a Melkie adapting even your tongue and voice. Well you could always go sit on a rock and sing in case some sailor came by. <b>You now have the mermaid like voice of a Melkie.</b>";

	    player.tongue.type = Tongue.MELKIE;
	    player.createPerk(PerkLib.MelkieSong, 0, 0, 0, 0);
	  },
	  // is present
	  function (): Boolean {
	    return player.tongue.type === Tongue.MELKIE;
	  }
	);
  /*
*/

/*
*    ███████  █████  ██████  ███████
*    ██      ██   ██ ██   ██ ██
*    █████   ███████ ██████  ███████
*    ██      ██   ██ ██   ██      ██
*    ███████ ██   ██ ██   ██ ███████
*/

/*
  */
	public const EarsHuman: Transformation = new SimpleTransformation("Human Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Ouch, your head aches! It feels like your ears are being yanked out of your head, and when you reach up to hold your aching noggin, you find they've vanished! Swooning and wobbling with little sense of balance, you nearly fall a half-dozen times before <b>a pair of normal, human ears sprout from the sides of your head.</b> You had almost forgotten what human ears felt like!";
	    player.ears.type = Ears.HUMAN;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.HUMAN;
	  }
	);

	public const EarsLion: Transformation = new SimpleTransformation("Lion Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.ears.type == Ears.HUMAN) {
	      if (rand(3) == 0) desc += "The skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head. They shift and elongate a little, fur growing on them as they become feline in nature. <b>You now have lion ears.</b>";
	      else if (rand(3) == 1) desc += "Your ears begin to tingle. You reach up with one hand and gently rub them. They appear to be growing fur. Within a few moments, they've migrated up to the top of your head and increased in size. The tingling stops and you find yourself hearing noises in a whole new way. <b>You now have lion ears.</b>";
	      else desc += "Your ears suddenly stretch painfully, making you scream in pain as they move toward the top of your head, growing rounder and bigger. Putting your hands to your ears you discover they are now covered with a fair amount of dark fur. <b>You now have lion ears.</b>";
	    } else {
	      if (rand(2) == 0) desc += "Your ears change shape, morphing into round, feline ears not unlike those of a lion!	They swivel about reflexively as you adjust to them. <b>You now have lion ears.</b>";
	      else desc += "Your ears tingle and begin to change shape. Within a few moments, they've become long and feline. Thanks to the new fuzzy organs, you find yourself able to hear things that eluded your notice up until now. <b>You now have lion ears.</b>";
	    }

	    player.ears.type = Ears.LION;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.LION));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.LION;
	  }
	);

	public const EarsDisplacer: Transformation = new SimpleTransformation("Displacer Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your ears begin to prickle and burn as the skin tears and stretches migrating to the top of your head as they change into long wide, deep ears, perfect for catching any stray sound. Which becomes apparent when your hearing becomes far more clear than it has ever been. <b>Sound has become an entirely new experience now that you have displacer beast ears!</b>";
	    player.coatColor = "midnight";
	    player.ears.type = Ears.DISPLACER;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.DISPLACER));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.DISPLACER;
	  }
	);

	public const EarsCat: Transformation = new SimpleTransformation("Cat Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.CAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.CAT;
	  }
	);

	public const EarsRedPanda: Transformation = new SimpleTransformation("RedPanda Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (flags[kFLAGS.MINO_CHEF_TALKED_RED_RIVER_ROOT] > 0) desc += "The warned dizziness";
	    else desc += "A sudden dizziness";

	    desc += " seems to overcome your head. Your ears tingle, and you’re sure you can feel the flesh on them shifting, as you gradually have trouble hearing. A couple of minutes later the feeling stops. Curious of what has changed you go to check yourself on the stream, only to find that they’ve changed into cute, triangular ears, covered with white fur. <b>You’ve got red-panda ears!</b>";
	    player.ears.type = Ears.RED_PANDA;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.RED_PANDA));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.RED_PANDA;
	  }
	);

	public const EarsHorse: Transformation = new SimpleTransformation("Horse Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.ears.type == -1) desc += "Two painful lumps sprout on the top of your head, forming into tear-drop shaped ears, covered with short fur. ";
	    if (player.ears.type == Ears.HUMAN) desc += "Your ears tug painfully on your face as they begin shifting, moving upwards to the top of your head and transforming into a upright animalistic ears. ";
	    if (player.ears.type == Ears.DOG) desc += "Your ears change shape, morphing into from their doglike shape into equine-like ears! ";
	    else desc += "Your ears change shape, morphing into teardrop-shaped horse ears! ";
	    desc += "<b>You now have horse ears.</b>";
	    player.ears.type = Ears.HORSE;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.HORSE));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.HORSE;
	  }
	);

	public const EarsPig: Transformation = new SimpleTransformation("Pig Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel a pressure on your ears as they begin to reshape. Once the changes finish, you flick them about experimentally, <b>and you’re left with pointed, floppy pig ears.</b>";
	    player.ears.type = Ears.PIG;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.PIG));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.PIG;
	  }
	);

	public const EarsVampire: Transformation = new SimpleTransformation("Vampire Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EarsHuman, doOutput);

	    desc += "Your ears begin to prickle as they elongate to a point, being now reminiscent of those of elves, goblins, or in your case, vampires. Aside from looking cute, you find your new ears have drastically improved your hearing. <b>Sound has become an entirely new experience now that you have pointy vampire ears!</b>";

	    player.ears.type = Ears.VAMPIRE;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.VAMPIRE));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.VAMPIRE;
	  }
	);

	public const EarsBat: Transformation = new SimpleTransformation("Bat Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EarsHuman, doOutput);

	    desc += "Your ears begin to prickle and burn as the skin tears and stretches, changing into wide, deep ears, perfect for catching any stray sound. Which becomes apparent when your hearing becomes far more clear than it has ever been. <b>Sound has become an entirely new experience now that you have bat ears!</b>";

	    player.ears.type = Ears.BAT;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.BAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.BAT;
	  }
	);

	public const EarsWeasel: Transformation = new SimpleTransformation("Weasel Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EarsHuman, doOutput);

	    if (player.raijuScore() >= 5) {
	      desc += "Your ears twitch as jolt of lightning flows through them, replacing all sound with crackling pops. You moan as the lightning arcs up to the top of your head before fanning out to the side. Hearing suddenly returns as you run your hands across your <b>new weasel ears!</b>";
	    } else {
	      desc += "Your ears suddenly stretch painfully, making you scream in pain as they move toward the top of your head, growing rounder and bigger. Putting your hands to your ears you discover they are now covered with a fair amount of dark fur. <b>You now have weasel ears.</b>";
	    }

	    player.ears.type = Ears.WEASEL;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.WEASEL));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.WEASEL;
	  }
	);

	public const EarsOni: Transformation = new SimpleTransformation("Oni Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your ears tingle slightly as their shape sharpen to a point not unlike those of some kind of demonic fiend. Still you know all too well those are <b>Oni ears.</b>";
	    player.ears.type = Ears.ONI;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.ONI));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.ONI;
	  }
	);

	public const EarsElven: Transformation = new SimpleTransformation("Elven Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EarsHuman, doOutput);

	    desc += "Sounds become increasingly audible as a weird tingling runs through your scalp and your [hair] shifts slightly. You reach up to touch and bump <b>your new pointed elven ears.</b> The points are quite sensitive and you will have to get used to your new enhanced hearing ability.";
	    player.ears.type = Ears.ELVEN;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.ELVEN));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.ELVEN;
	  }
	);

	public const EarsGoat: Transformation = new SimpleTransformation("Goat Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your ears elongate and flatten on your head. You flap them a little and discover they have turned into something similar to the ears of a goat. <b>You now have goat ears!</b>";
	    player.ears.type = Ears.GOAT;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.GOAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.GOAT;
	  }
	);

	public const EarsCow: Transformation = new SimpleTransformation("Cow Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel your ears tug on your scalp as they twist shape, becoming oblong and cow-like. <b>You now have [haircolor] cow ears.</b>";
	    player.ears.type = Ears.COW;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.COW));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.COW;
	  }
	);

	public const EarsDraconic: Transformation = new SimpleTransformation("Draconic Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A prickling sensation suddenly fills your ears; unpleasant, but hardly painful. It grows and grows until you can't stand it any more, and reach up to scratch at them. To your surprise, you find them melting away like overheated candles. You panic as they fade into nothingness, leaving you momentarily deaf and dazed, stumbling around in confusion. Then, all of a sudden, hearing returns to you. Gratefully investigating, you find you now have a pair of reptilian ear-holes, one on either side of your head. A sudden pain strikes your temples, and you feel bony spikes bursting through the sides of your head, three on either side, which are quickly sheathed in folds of skin to resemble fins. With a little patience, you begin to adjust these fins just like ears to aid your hearing. <b>You now have dragon ears!</b>";
	    player.ears.type = Ears.DRAGON;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.DRACONIC));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.DRAGON;
	  }
	);

	public const EarsSnake: Transformation = new SimpleTransformation("Snake Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A weird tingling runs through your scalp as your [hair] shifts slightly. You reach up to touch and bump <b>your new pointed ears covered in small scales</b>. You bet they look cute!";
	    player.ears.type = Ears.SNAKE;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.SNAKE));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.SNAKE;
	  }
	);

	public const EarsOrca: Transformation = new SimpleTransformation("Orca Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your ears suddenly begin to lengthen, growing bigger and bigger until their length reaches your shoulders. When you examine them you discover they have grown into a pair of large fins, easily twice as big as your head. <b>Orienting yourself underwater will be easy with your large orca fin ears.</b>";

	    player.ears.type = Ears.ORCA;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.ORCA));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.ORCA;
	  }
	);

	public const EarsOrca2: Transformation = new SimpleTransformation("Orca Ears 2",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Tightness centers on your scalp, pulling your ears down from their normal, fleshy shape into small, fleshy bumps with holes in their centers. <b>You have whales ears!</b>";

	    player.ears.type = Ears.ORCA;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.ORCA;
	  }
	);

	public const EarsLizard: Transformation = new SimpleTransformation("Lizard Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Tightness centers on your scalp, pulling your ears down from their normal, fleshy shape into small, scaley bumps with holes in their centers. <b>You have reptilian ears!</b>";
	    player.ears.type = Ears.LIZARD;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.LIZARD));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.LIZARD;
	  }
	);

	public const EarsFox: Transformation = new SimpleTransformation("Fox Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.ears.type == Ears.HUMAN || player.ears.type == Ears.ELFIN || player.ears.type == Ears.LIZARD) {
	      desc += "The sides of your face painfully stretch as your ears elongate and begin to push past your hairline, toward the top of your head. They elongate, becoming large vulpine triangles covered in bushy fur. <b>You now have fox ears.</b>";
	    } else {
	      desc += "Your ears change, shifting from their current shape to become vulpine in nature. <b>You now have fox ears.</b>";
	    }
	    player.ears.type = Ears.FOX;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.FOX));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.FOX;
	  }
	);

	public const EarsElfin: Transformation = new SimpleTransformation("Elfin Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EarsHuman, doOutput);

	    desc += "A weird tingling runs through your scalp as your [hair] shifts slightly. You reach up to touch and bump <b>your new pointed elfin ears</b>!";

	    if (player.hasFur()) desc += " As you examine your new elfin ears you feel fur grow around them, matching the rest of you.";

	    player.ears.type = Ears.ELFIN;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.ELFIN));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.ELFIN;
	  }
	);

	public const EarsWolf: Transformation = new SimpleTransformation("Wolf Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "The skin on the sides of your face stretches painfully as your ears migrate upwards, toward the top of your head. They shift and elongate becoming lupine in nature. You won't have much trouble hearing through the howling blizzards of the glacial rift with <b>your new Lupine ears.</b>";

	    player.ears.type = Ears.WOLF;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.WOLF));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.WOLF;
	  }
	);

	public const EarsDog: Transformation = new SimpleTransformation("Dog Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.ears.type == -1) desc += "Two painful nubs begin sprouting from your head, growing and opening into canine ears. ";
	    if (player.ears.type == Ears.HUMAN) desc += "The skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head. They shift and elongate, becoming canine in nature. ";
	    if (player.ears.type == Ears.HORSE) desc += "Your equine ears twist as they transform into canine versions. ";
	    if (player.ears.type > Ears.DOG) desc += "Your ears transform, becoming more canine in appearance. ";
	    desc += "<b>You now have dog ears.</b>";

	    player.ears.type = Ears.DOG;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.DOG;
	  }
	);

	public const EarsGremlin: Transformation = new SimpleTransformation("Gremlin Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Whoa, something messed up is going about with your ears. They migrate slowly up your head, elongating and distorting as they get covered in [haircolor] fur. When you go check what the hell happened to them you discover instead of human ears you now have a pair of cute animal ears up on your head. Well these sure will give you a cute look. <b>You now have gremlin ears!</b>";

	    player.ears.type = Ears.GREMLIN;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.GREMLIN;
	  }
	);

	public const EarsShark: Transformation = new SimpleTransformation("Shark Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.ears.type != Ears.HUMAN) {
	      desc += "Your ears twitch once, twice, before starting to shake and tremble madly. They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, fin like ears just like those of a shark girl.</b>";
	    } else {
	      desc += "A weird tingling runs through your scalp as your [hair] shifts slightly. You reach up to touch and bump <b>your new pointed fin like ears just like those of a shark girl</b>. You bet they look cute!";
	    }

	    player.ears.type = Ears.SHARK;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.SHARK;
	  }
	);

	public const EarsCaveWyrm: Transformation = new SimpleTransformation("Cave Wyrm Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your ears suddenly start to tingle. Strangely they change shape into something entirely different from what you would expect on a reptile covering in fur like those of cave wyrms. You can hear sound more acutely with your <b>new cave wyrm furry ears.</b>";

	    player.ears.type = Ears.CAVE_WYRM;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.CAVE_WYRM));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.CAVE_WYRM;
	  }
	);

	public const EarsBunny: Transformation = new SimpleTransformation("Bunny Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your ears twitch and curl in on themselves, sliding around on the flesh of your head. They grow warmer and warmer before they finally settle on the top of your head and unfurl into long, fluffy bunny-ears. <b>You now have a pair of bunny ears.</b>";

	    player.ears.type = Ears.BUNNY;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.BUNNY;
	  }
	);

	public const EarsAvian: Transformation = new SimpleTransformation("Avian Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel your ears twitching, and before you can realize, they recede on your body, leaving behind two holes, almost completely hidden by feathers and your [hair]. Fearing that most of your hearing range and ability was damaged or is blocked by the feathers, you test the sounds around your, and breathe on relief at the realization that your hearing is as good as always.";

	    player.ears.type = Ears.AVIAN;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.AVIAN;
	  }
	);

	public const EarsGryphon: Transformation = new SimpleTransformation("Gryphon Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "After another session under the statue magic, the lingering effects seem to having taken a toll on you, as your ears buzz. The sound turns worse for a second, and then vanish. You hear for a second a light flapping sound, and then, nothing.\n\nWhen everything seems to have finished, you realize that your hearing range has changed, and while your overall sense of hearing remains the same, pinpointing the source of a sounds is much easier. On a nearby reflection you discover the reason: two triangular ears have sprouted at your head, streamlined to flight and with a gryphon like appearance. A short layer of downy feathers covers them, the tip having a distinctive tuft. Checking that your ears are rightly placed on the new auricles, <b>you smile happily at the sight of your gryphon ears,</b> noting how well they compliment your looks.";

	    player.ears.type = Ears.GRYPHON;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.GRYPHON;
	  }
	);

	public const EarsKangaroo: Transformation = new SimpleTransformation("Kangaroo Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.ears.type == Ears.BUNNY) desc += "Your ears stiffen and shift to the sides!	You reach up and find them pointed outwards instead of up and down; they feel a bit wider now as well. As you touch them, you can feel them swiveling in place in response to nearby sounds. <b>You now have a pair of kangaroo ears!</b>";
	    else desc += "Your ears twist painfully as though being yanked upwards and you clap your hands to your head. Feeling them out, you discover them growing!	They stretch upwards, reaching past your fingertips, and then the tugging stops. You cautiously feel along their lengths; they're long and stiff, but pointed outwards now, and they swivel around as you listen. <b>You now have a pair of kangaroo ears!</b>";

	    player.ears.type = Ears.KANGAROO;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.KANGAROO;
	  }
	);

	public const EarsRaiju: Transformation = new SimpleTransformation("Raiju Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your ears twitch as jolts of lightning flows through them, replacing all sound with crackling pops. You moan as the lightning arcs up to the top of your head before fanning out to the side. Hearing suddenly returns as you run your hands across your <b>new raiju ears!</b>";

	    player.ears.type = Ears.RAIJU;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.RAIJU;
	  }
	);

	public const EarsSquirrel: Transformation = new SimpleTransformation("Squirrel Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your ears suddenly stretch painfully, making you scream in pain as they move towards the top of your head, growing bigger. Putting your hands to your ears you discover they are now covered with a fair amount of fur. <b>You now have squirrel ears.</b>";

	    player.ears.type = Ears.SQUIRREL;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.SQUIRREL;
	  }
	);

	public const EarsRaccoon: Transformation = new SimpleTransformation("Raccoon Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.ears.type == Ears.DOG || player.ears.type == Ears.BUNNY || player.ears.type == Ears.KANGAROO) desc += "Your ears compress, constricting your ear canal momentarily. You shake your head to get sound back, and reach up to touch the auricles, to find a pair of stubby egg-shaped ears in their place. <b>You now have raccoon ears!</b>";
	    else if (player.ears.type == Ears.HORSE || player.ears.type == Ears.COW || player.ears.type == Ears.CAT) desc += "Your ears tingle. Huh. Do they feel a bit rounder at the tip now?	<b>Looks like you have raccoon ears.</b>";
	    else desc += "Your ears prick and stretch uncomfortably, poking up through your [hair]. Covering them with your hands, you feel them shaping into little eggdrop ornaments resting atop your head. <b>You have raccoon ears!</b>";

	    player.ears.type = Ears.RACCOON;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.RACCOON;
	  }
	);

	public const EarsMouse: Transformation = new SimpleTransformation("Mouse Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your ears ";
	    if (player.ears.type == Ears.HORSE || player.ears.type == Ears.COW || player.ears.type == Ears.DOG || player.ears.type == Ears.BUNNY || player.ears.type == Ears.KANGAROO) desc += "shrink suddenly";
	    else desc += "pull away from your head";
	    desc += ", like they're being pinched, and you can distinctly feel the auricles taking a rounded shape through the pain. Reaching up to try and massage away their stings, <b>you're not terribly surprised when you find a pair of fuzzy mouse's ears poking through your [hair].</b>";

	    player.ears.type = Ears.MOUSE;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.MOUSE));
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.MOUSE;
	  }
	);

	public const EarsFerret: Transformation = new SimpleTransformation("Ferret Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You squint as you feel a change in your ears. Inspecting your reflection in a nearby puddle you find that <b>your ears have become small, fuzzy, and rounded, just like a ferret’s!</b>";

	    player.ears.type = Ears.FERRET;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.FERRET;
	  }
	);

	public const EarsYeti: Transformation = new SimpleTransformation("Yeti Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel your ears as though they’re growing bigger for a moment. It feels weird, but when you touch them to check what happened they still feel somewhat human. Looking down in a puddle you notice the term human isn’t correct, in your case they look more like those of a monkey. <b>You now have yeti ears.</b>";

	    player.ears.type = Ears.YETI;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.YETI;
	  }
	);

	public const EarsBear: Transformation = new SimpleTransformation("Bear Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your ears begin to tingle. You reach up with one hand and gently rub them. They appear to be growing fur. Within a few moments, they’ve migrated up to the top of your head and increased in size, taking on a rounded shape. The tingling stops and you find yourself hearing noises in a whole new way. <b>You could pass for cute with your new bear ears.</b>";

	    player.ears.type = Ears.BEAR;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.BEAR;
	  }
	);

	public const EarsPanda: Transformation = new SimpleTransformation("Panda Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your ears begin to tingle. You reach up with one hand and gently rub them. They appear to be growing fur. Within a few moments, they’ve migrated up to the top of your head and increased in size, taking on a rounded shape. The tingling stops and you find yourself hearing noises in a whole new way. <b>You could pass for cute with your new panda ears.</b>";

	    player.ears.type = Ears.PANDA;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.PANDA;
	  }
	);

	public const EarsMelkie: Transformation = new SimpleTransformation("Melkie Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your ears start feeling weird as they get longer and longer, eventually reaching your knees and covering with fur. These look like the ears of some sea rabbit or mammal, namely a Melkie. <b>You now have Melkie ears safeguarding your audition from the cold.</b>";

	    player.ears.type = Ears.MELKIE;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.MELKIE;
	  }
	);

	public const EarsDeer: Transformation = new SimpleTransformation("Deer Ears",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";

	    player.ears.type = Ears.DEER;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.ears.type === Ears.DEER;
	  }
	);
  /*
*/

/*
*		███████ ██		██ ███████ ███████
*		██			 ██	 ██	██			██
*		█████		   ██   ███████	███████
*		██				 ██		██					 ██
*		███████		 ██		███████ ███████
*/

/*
  */
	public const EyesHuman: Transformation = new SimpleTransformation("Human Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.eyes.type == Eyes.BLACK_EYES_SAND_TRAP) {
	      desc += "You feel a twinge in your eyes and you blink. It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.";
	    } else {
	      desc += "You blink and stumble, a wave of vertigo threatening to pull your [feet] from under you. As you steady and open your eyes, you realize something seems different. Your vision is changed somehow.";
	      if (player.eyes.type == Eyes.SPIDER) desc += " Your multiple, arachnid eyes are gone!</b>";
	      desc += " <b>You have normal, humanoid eyes again.</b>";
	    }

	    if (doOutput) outputText(desc);
	    player.eyes.type = Eyes.HUMAN;
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.HUMAN;
	  }
	);

	public const EyesManticore: Transformation = new SimpleTransformation("Manticore Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["red"]), doOutput);

	    desc += "For a moment your sight shifts as the ambient light suddenly turns extremely bright, almost blinding you. You walk around disoriented for a moment until the luminosity fades back to normal. You run to a puddle of water to check your reflection and quickly notice your pupils have become cat-like. While you do see way better in the dark, your red eyes are extremely intimidating and clearly don't belong on any normal feline. <b>You now have manticore eyes.</b>";

	    if (doOutput) outputText(desc);
	    player.eyes.type = Eyes.MANTICORE;
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.MANTICORE));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.MANTICORE;
	  }
	);

	public const EyesInfernal: Transformation = new SimpleTransformation("Infernal Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["ember"]), doOutput);

	    desc += "Warmth then rampage all around body altering your body. All of these pleasurable changes are driving you insane with pleasure to the point you would try to cry but just as soon as a tear pearls out of your eye it evaporates as two small flames leaks from their corners instead. <b>You now have infernal eyes.</b>";

	    if (doOutput) outputText(desc);
	    player.eyes.type = Eyes.INFERNAL;
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.INFERNAL));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.INFERNAL;
	  }
	);

	public const EyesDisplacer: Transformation = new SimpleTransformation("Displacer Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["yellow"]), doOutput);

	    desc += "For a moment your sight shifts as the ambient light suddenly turns extremely bright, almost blinding you. You walk around disoriented for a moment until the luminosity fades back to normal. You run to a puddle of water to check your reflection and quickly notice your eyes are now yellow and cat-like however just as you watch your reflection the white of your eyes also begins to darken turning black not unlike the eyes of a displacer beast. <b>You now have displacer beast eyes.</b>";

	    if (doOutput) outputText(desc);
	    player.eyes.type = Eyes.DISPLACER;
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.DISPLACER));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.DISPLACER;
	  }
	);

	public const EyesCat: Transformation = new SimpleTransformation("Cat Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You blink and stumble, a wave of vertigo threatening to pull your [feet] from under you. As you steady and open your eyes, you realize something seems different. Your vision is changed somehow. <b>Your eyes have turned into those of cat with vertical slit.</b>";

	    if (doOutput) outputText(desc);
	    player.eyes.type = Eyes.CAT;
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.CAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.CAT;
	  }
	);

	public const EyesOrc: Transformation = new SimpleTransformation("Orc Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["bloody red"]), doOutput);

	    desc += "You blink and stumble, a wave of vertigo threatening to pull your [feet] from under you. As you steady yourself and open your eyes, you realize something seems different, as if the nerves have been optimized. Your vision has been changed somehow. <b>Your eyes has turned into those of orc.</b>";

	    if (doOutput) outputText(desc);
	    player.eyes.type = Eyes.ORC;
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.ORC));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.ORC;
	  }
	);

	public const EyesVampire: Transformation = new SimpleTransformation("Vampire Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["blood-red"]), doOutput);

	    desc += "Your eyes shift, causing sunlight to suddenly become annoyingly bright for you. It takes several minutes for your eyes to get used to it and, once they do, you still have to keep them half closed, so as to not be blinded by the sun’s glare.";
	    desc += " Upon looking at your reflection in the water, you discover your irises have taken on a blood-red shade. <b>You have Vampire Eyes.</b>";

	    if (doOutput) outputText(desc);
	    player.eyes.type = Eyes.VAMPIRE;
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.VAMPIRE));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.VAMPIRE;
	  }
	);

	public const EyesRaiju: Transformation = new SimpleTransformation("Raiju Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["blue", "green", "teal"]), doOutput);

	    desc += "Bright lights flash into your vision as your eyes glow with electric light. Blinded, you rapidly shake your head around, trying to clear your vision. It takes a moment, but your vision eventually returns to normal. Curious, you go over to a nearby puddle and find <b>glowing [eyecolor] bestial slitted eyes staring back at you.</b>";

	    if (doOutput) outputText(desc);
	    player.eyes.type = Eyes.RAIJU;
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.RAIJU));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.RAIJU;
	  }
	);

	public const EyesWeasel: Transformation = new SimpleTransformation("Weasel Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A sudden gust of wind send sand into your face. Blinded, you rapidly shake your head around, trying to clear your vision. It takes a moment but your vision eventually returns to normal. Curious, you go over to a nearby puddle and find <b>[eyecolor] bestial slitted eyes staring back at you not unlike those of a weasel.</b>";

	    if (doOutput) outputText(desc);
	    player.eyes.type = Eyes.WEASEL;
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.RAIJU;
	  }
	);

	public const EyesOni: Transformation = new SimpleTransformation("Oni Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesOniColors, doOutput);

	    desc += "You feel something fundamental change in your sight when you go check yourself in a puddle you notice <b>your iris now have a slit at the center, giving them a fiendish outlook like an Oni.</b>";

	    player.eyes.type = Eyes.ONI;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.ONI));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.ONI;
	  }
	);

	public const EyesElf: Transformation = new SimpleTransformation("Elf Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

	    desc += "You blink and stumble, a wave of vertigo threatening to pull your feet out from under you. As you steady yourself and open your eyes, you realize something seems different. Your vision is changed somehow. Your pupils draw in light and the color and shapes seems more defined even at great distance. Your new eyes granting you better vision. You go to a puddle to check what happened to them and notice <b>your new eyes are like those of an elf’s with a vertical slit that reflects lights.</b>";

	    player.eyes.type = Eyes.ELF;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.ELF));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.ELF;
	  }
	);

	public const EyesDevil: Transformation = new SimpleTransformation("Devil Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["ember"]), doOutput);

	    desc += "Your eyes feels like they are burning. You try to soothe them, but to no avail. You endure the agony for a few minutes before it finally fades. You look at yourself in the nearest reflective surface and notice your eyes have taken on a demonic appearance: the sclera is black and the pupils ember. Furthermore they seem to glow with a faint inner light. <b>You now have fiendish eyes!</b>";

	    player.eyes.type = Eyes.DEVIL;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.DEVIL));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.DEVIL;
	  }
	);

	public const EyesDraconic: Transformation = new SimpleTransformation("Draconic Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a dragon. <b>You now have dragon eyes!</b>.";

	    player.eyes.type = Eyes.DRACONIC;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.DRACONIC));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.DRACONIC;
	  }
	);

	public const EyesGorgon: Transformation = new SimpleTransformation("Gorgon Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You blink and stumble, a wave of vertigo threatening to pull your [feet] from under you. As you steady and open your eyes, all seems to be fine until at least it seems so. But when moment later, when you casualy look at your hands pondering if there is any other effect the numbing sensation starts to spread starting from your hands fingers. Worried you focus your gaze at them to notice, that they typical texture becoming grey colored much similar to that of... stone? And slowy you realize the more you look at them, the faster change. Panicked for a moment you look away and then this numbing feeling starting to slowly receed. But looking back at them causing it to return. After moment, and closing eyelids, you conclude that your eyes must have gained an useful ability. <b>Your eyes has turned into gorgon eyes.</b>";

	    player.eyes.type = Eyes.GORGON;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.GORGON));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.GORGON;
	  }
	);

	public const EyesSnake: Transformation = new SimpleTransformation("Snake Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a snake. <b>You now have snake eyes!</b>.";

	    player.eyes.type = Eyes.SNAKE;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.SNAKE));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.SNAKE;
	  }
	);

	public const EyesSnakeFiendish: Transformation = new SimpleTransformation("Fiendish Snake Eyes",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a snake with sinister black schlera that reflect the sorry state of your soul. <b>You now have fiendish snake eyes!</b>.";

				player.eyes.type = Eyes.SNAKEFIENDISH;
				player.eyes.colour = "yellow";
				if (doOutput) outputText(desc);
				//Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.SNAKEFIENDISH));
			},
			// is present
			function (): Boolean {
				return player.eyes.type === Eyes.SNAKEFIENDISH;
			}
	);

	public const EyesSpider: Transformation = new SimpleTransformation("Spider Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You suddenly get the strangest case of double vision. Stumbling and blinking around, you clutch at your face, but you draw your hands back when you poke yourself in the eye. Wait, those fingers were on your forehead! You tentatively run your fingertips across your forehead, not quite believing what you felt. <b>There's a pair of eyes on your forehead, positioned just above your normal ones!</b> This will take some getting used to!";

	    player.eyes.type = Eyes.SPIDER;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.SPIDER));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.SPIDER;
	  }
	);

	public const EyesLizard: Transformation = new SimpleTransformation("Lizard Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["yellow"]), doOutput);

	    desc += "You suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice <b>your eyes now have a slitted pupil like that of a reptile.</b>";

	    player.eyes.type = Eyes.LIZARD;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.LIZARD));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.LIZARD;
	  }
	);

	public const EyesFox: Transformation = new SimpleTransformation("Fox Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You blink for an instant as the light and darkness seems to shift within your vision. You head to a pool to check it up and notice your pupils shifted to look more fox-like in a fashion similar to the kitsunes. <b>You now have fox pupils.</b>";

	    player.eyes.type = Eyes.FOX;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.FOX));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.FOX;
	  }
	);

	public const EyesMonoeye: Transformation = new SimpleTransformation("Monoeye Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";

	    player.eyes.type = Eyes.MONOEYE;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.MONOEYE));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.MONOEYE;
	  }
	);

	public const EyesRatatoskr: Transformation = new SimpleTransformation("Ratatoskr Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesRatatoskrColors, doOutput);

	    desc += "Geeze you know so much now it's like everyone around you is an idiot. How come they don't know about this and that is beyond you. <b>It's going to be hard to wipe away that somewhat permanent know it all smug expression from your face when you’re spreading words around your [eyecolor] eyes looking down teasingly on about everyone.</b>";

	    player.eyes.type = Eyes.RATATOSKR;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.RATATOSKR;
	  }
	);

	public const EyesKraken: Transformation = new SimpleTransformation("Kraken Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel something fundamental change in your sight when you go check yourself in a puddle you notice that <b>they now have horizontal slit like those of an octupus.</b>";

	    player.eyes.type = Eyes.KRAKEN;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.KRAKEN;
	  }
	);

	public const EyesFireSnail: Transformation = new SimpleTransformation("Fire Snail Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesFireSnailColors, doOutput);

	    desc += "Something weird happens with your eyes as they suddenly begin to burn and tickle. After a while it stops and as you go check them up in a water puddle the first thing you notice is that your two irises now burn like two incandescent embers, just like those of a fiery creature. <b>Your irises are now incandescent.</b>";

	    player.eyes.type = Eyes.FIRE_SNAIL;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.FIRE_SNAIL;
	  }
	);

	public const EyesFenrir: Transformation = new SimpleTransformation("Fenrir Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["glacial blue"]), false);

	    desc += "You feel an icy chill run through your body as your divine nature reasserts itself over your body. You won't escape your destiny as the Fenrir so easily, it seems.\n\nYou cry out in pain as your eyes once more freeze over, eventually settling back into their proper form. <b>You now have glowing icy eyes.</b>";

	    player.eyes.type = Eyes.FENRIR;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.FENRIR;
	  }
	);

	public const EyesDead: Transformation = new SimpleTransformation("Dead Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";

	    player.eyes.type = Eyes.DEAD;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.DEAD;
	  }
	);

	public const EyesCaveWyrm: Transformation = new SimpleTransformation("Cave Wyrm Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["neon blue"]), false);

	    desc += "Something shift in your eyes as the level of light around you seems to increase. You go to check on what happened and discover your pupils not only changed to reptilian slits but now glow with a neon blue light. Well seeing in the dark will be easy with your <b>new dark blue iris with reptilian neon blue pupils that glow in the dark.</b>";

	    player.eyes.type = Eyes.CAVE_WYRM;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.CAVE_WYRM));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.CAVE_WYRM;
	  }
	);

	public const EyesGryphon: Transformation = new SimpleTransformation("Gryphon Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["golden-orange"]), false);

	    desc += "The mysterious energy coming from the statue continues adapting your body into a more fierce, strong shape. This time, it has affected you eyesight, as you suddenly notice how the long distances that you once had trouble seeing are clear as if you were in front of them, and that you can perceive even the minimal move even from several miles afar.\n\nChecking your changes on the river, you see clearly how your sclera has acquired a golden-orange coloration, as well as your outer iris, separated from the former by a thin circle of black. Both your pupil and your inner iris, which now has enlarged, are solid black. <b>Now you’ll have a blessed vision due those raptor, gryphon-like eyes.</b>";

	    player.eyes.type = Eyes.GRYPHON;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.GRYPHON;
	  }
	);

	public const EyesSandTrap: Transformation = new SimpleTransformation("Sand Trap Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["black"]), false);

	    desc += "You blink, and then blink again. It feels like something is irritating your eyes. Panic sets in as black suddenly blooms in the corner of your left eye and then your right, as if drops of ink were falling into them. You calm yourself down with the thought that rubbing at your eyes will certainly make whatever is happening to them worse; through force of will you hold your hands behind your back and wait for the strange affliction to run its course. The strange inky substance pools over your entire vision before slowly fading, thankfully taking the irritation with it. As soon as it goes you stride quickly over to the stream and stare at your reflection. <b>Your pupils, your irises, your entire eye has turned a liquid black</b>, leaving you looking vaguely like the many half insect creatures which inhabit these lands. You find you are merely grateful the change apparently hasn't affected your vision.";

	    player.eyes.type = Eyes.BLACK_EYES_SAND_TRAP;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.BLACK_EYES_SAND_TRAP));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.BLACK_EYES_SAND_TRAP;
	  }
	);

	public const EyesHinezumi: Transformation = new SimpleTransformation("Hinezumi Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["blazing red"]), doOutput);

	    desc += "Your eyes start to hurt and as a reaction, you start shedding tears. Once your vision clears, you head to a puddle to check what is going on. <b>To your surprise, it seems your irises turned blazing red like those of an Hinezumi.</b>";

	    player.eyes.type = Eyes.HINEZUMI;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.HINEZUMI));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.HINEZUMI;
	  }
	);

	public const EyesFrostwyrm: Transformation = new SimpleTransformation("Frostwyrm Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["yellow"]), doOutput);

	    desc += "You suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil and black sclera like that of a frost wyrm. <b>You now have frost wyrm eyes!</b>.";

	    player.eyes.type = Eyes.FROSTWYRM;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.FROSTWYRM));
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.FROSTWYRM;
	  }
	);

	public const EyesGoat: Transformation = new SimpleTransformation("Goat Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["golden"]), doOutput);

	    desc += "Your eyes feel like they are burning. You try to soothe them, but to no avail. You endure the agony for a few minutes before it finally fades. You look at yourself in the nearest reflective surface and notice your eyes have taken on a goat like appearance with horizontal pupils in the middle, the schlera turning back to white. <b>You now have eyes with horizontal pupils just like those of a goat!</b>";

	    player.eyes.type = Eyes.GOAT;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.GOAT;
	  }
	);

	public const EyesBear: Transformation = new SimpleTransformation("Bear Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["golden"]), doOutput);

	    desc += "Your eyes begin to water for a moment. When your view clears up you move on to a puddle and notice their coloration changed to a golden brown hue not unlike those of a bears. <b>You now have golden bear eyes.</b>";

	    player.eyes.type = Eyes.BEAR;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.BEAR;
	  }
	);

	public const EyesCancer: Transformation = new SimpleTransformation("Cancer Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["orange"]), doOutput);

	    desc += "A slight change happens in your eyes as they begin to water. You clear away the tears, going to a puddle to see what's going on. Your eyes look about the same, save for the fact that your irises now have the particular orange hue characteristic of cancers, with slightly larger pupils. Likely you won’t need to blink while underwater with <b>your orange cancer eyes.</b>";

	    player.eyes.type = Eyes.CANCER;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.CANCER;
	  }
	);

	public const EyesCentipede: Transformation = new SimpleTransformation("Centipede Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel a sudden wave of sadness come over you. You sulk, wanting to find some dank dark place to curl up and hide in. If anyone saw you now they would wonder why you appear so downtrodden. [if (silly) You could really use a hug and a tub of ice cream right now.] You vaguely register the feeling of your teeth sharpening. <b>Though saddened you suppose you could leave someone with a nasty bite with your new sharp teeth.</b>";

	    player.eyes.type = Eyes.CENTIPEDE;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.CENTIPEDE;
	  }
	);

	public const EyesGhost: Transformation = new SimpleTransformation("Ghost Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your vision becomes blurry, making it hard to see. You blink repeatedly, trying to clear your eyes. As your vision returns to normal, you notice that your surroundings appear sharper than normal. The shadows are as clear as day, though everything is tinted with a faint ethereal glow. You look in a puddle to see that your eyes glow an eerie [eyecolor]. <b>You now have glowing ghost eyes.</b>";

	    player.eyes.type = Eyes.GHOST;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.GHOST;
	  }
	);

	public const EyesFiendish: Transformation = new SimpleTransformation("Fiendish Eyes",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";

	    player.eyes.type = Eyes.FIENDISH;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.eyes.type === Eyes.FIENDISH;
	  }
	);

// EYE COLORS

	public function EyesChangeColor(colors: /*String*/ Array): Transformation {
	  return new SimpleTransformation("Eye Color: " + colors.join("|"),
	    // apply effect
	    function (doOutput: Boolean): void {
	      var color: String = randomChoice(colors);
	      player.eyes.colour = color;
	      var desc: String = "";

	      desc += "You feel something change around the upper half of your face, but you're not sure what. There doesn't seem to be much difference, but you should probably check it out the first chance you get. <b>Your eye color is now [eyecolor]!</b>";

	      if (doOutput) outputText(desc);
	    },
	    // is present
	    function (): Boolean {
	      return InCollection(player.eyes.colour, colors);
	    }
	  )
	}

	public const EyesOniColors: Transformation = new SimpleTransformation("Oni Eye Colors",
	  // apply effect
	  function (doOutput: Boolean): void {
	    transformations.EyesChangeColor(["red", "orange", "yellow", "green"]).applyEffect(doOutput);
	  },
	  // is present
	  function (): Boolean {
	    return InCollection(player.eyes.colour, ["red", "orange", "yellow", "green"]);
	  }
	);

	public const EyesPlantColors: Transformation = new SimpleTransformation("Plant Eye Colors",
	  // apply effect
	  function (doOutput: Boolean): void {
	    transformations.EyesChangeColor(["light purple", "green", "light green"]).applyEffect(doOutput);
	  },
	  // is present
	  function (): Boolean {
	    return InCollection(player.eyes.colour, ["light purple", "green", "light green"]);
	  }
	);

	public const EyesGoblinColors: Transformation = new SimpleTransformation("Goblin Eye Colors",
	  // apply effect
	  function (doOutput: Boolean): void {
	    transformations.EyesChangeColor(["red", "yellow", "purple", "orange"]).applyEffect(doOutput);
	  },
	  // is present
	  function (): Boolean {
	    return InCollection(player.eyes.colour, ["red", "yellow", "purple", "orange"]);
	  }
	);

	public const EyesRaijuColors: Transformation = new SimpleTransformation("Raiju Eye Colors",
	  // apply effect
	  function (doOutput: Boolean): void {
	    transformations.EyesChangeColor(["blue", "green", "turquoise", "light green"]).applyEffect(doOutput);
	  },
	  // is present
	  function (): Boolean {
	    return InCollection(player.eyes.colour, ["blue", "green", "turquoise", "light green"]);
	  }
	);

	public const EyesKamaitachiColors: Transformation = new SimpleTransformation("Kamaitachi Eye Colors",
	  // apply effect
	  function (doOutput: Boolean): void {
	    transformations.EyesChangeColor(["golden"]).applyEffect(doOutput);
	  },
	  // is present
	  function (): Boolean {
	    return InCollection(player.eyes.colour, ["golden"]);
	  }
	);

	public const EyesRatatoskrColors: Transformation = new SimpleTransformation("Ratatoskr Eye Colors",
	  // apply effect
	  function (doOutput: Boolean): void {
	    transformations.EyesChangeColor(["green", "light green", "emerald"]).applyEffect(doOutput);
	  },
	  // is present
	  function (): Boolean {
	    return InCollection(player.eyes.colour, ["green", "light green", "emerald"]);
	  }
	);

	public const EyesRaccoonColors: Transformation = new SimpleTransformation("Raccoon Eye Colors",
	  // apply effect
	  function (doOutput: Boolean): void {
	    transformations.EyesChangeColor(["golden"]).applyEffect(doOutput);
	  },
	  // is present
	  function (): Boolean {
	    return InCollection(player.eyes.colour, ["golden"]);
	  }
	);

	public const EyesKrakenColors: Transformation = new SimpleTransformation("Kraken Eye Colors",
	  // apply effect
	  function (doOutput: Boolean): void {
	    transformations.EyesChangeColor(["bright pink", "light purple", "purple"]).applyEffect(doOutput);
	  },
	  // is present
	  function (): Boolean {
	    return InCollection(player.eyes.colour, ["bright pink", "light purple", "purple"]);
	  }
	);

	public const EyesSeadragonColors: Transformation = new SimpleTransformation("Seadragon Eye Colors",
	  // apply effect
	  function (doOutput: Boolean): void {
	    transformations.EyesChangeColor(["orange", "yellow", "light green"]).applyEffect(doOutput);
	  },
	  // is present
	  function (): Boolean {
	    return InCollection(player.eyes.colour, ["orange", "yellow", "light green"]);
	  }
	);

	public const EyesFireSnailColors: Transformation = new SimpleTransformation("Fire Snail Eye Colors",
	  // apply effect
	  function (doOutput: Boolean): void {
	    transformations.EyesChangeColor(["red", "orange", "yellow"]).applyEffect(doOutput);
	  },
	  // is present
	  function (): Boolean {
	    return InCollection(player.eyes.colour, ["red", "orange", "yellow"]);
	  }
	);

	public const EyesSpiderAndMutagenInt: Transformation = EyesSpider.copyWithExtraEffect(
	  "Spider eyes + Mutagen Bonus INT",
	  // extra effect
	  function (doOutput: Boolean): void {
	    MutagenBonus("int", 5);
	  }
	);
  /*
*/

/*
*		 █████	██████	███		 ███ ███████
*		██	 ██ ██	 ██ ████	████ ██
*		███████ ██████	██ ████ ██ ███████
*		██	 ██ ██	 ██ ██	██	██			██
*		██	 ██ ██	 ██ ██			██ ███████
*/

/*
  */
	public const ArmsHuman: Transformation = new SimpleTransformation("Human Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	      desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' chitinous covering is flaking away. The glossy black coating is soon gone, leaving [skin base.type] behind.";
	      break;
	    case Arms.HARPY:
	    case Arms.PHOENIX:
	    case Arms.AVIAN:
	      desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your feathery arms are shedding their feathery coating. The wing-like shape your arms once had is gone in a matter of moments, leaving [skin] behind.";
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
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.HUMAN;
	  }
	);

	public const ArmsSphinx: Transformation = new SimpleTransformation("Sphinx Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	    desc += "Your hands suddenly start to tingle as your arms grow a thin layer of -fur color- fur up to your shoulders. You watch, enthralled, as your nails fall off your fingers, feline claws taking their place on your five-fingered hands. That said, they don't look exactly like paws as your hands retain their dexterity and general appearance which is a perfect mix between human and leonine features. Thanks to their shape, your new bestial hands should not hinder your spellcasting abilities.. <b>Your arms are now covered in fur and end with clawed hands like those of a sphinx.</b>";
	    player.arms.type = Arms.SPHINX;

	    if (doOutput) outputText(desc);

	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.SPHINX));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.SPHINX;
	  }
	);

	public const ArmsLion: Transformation = new SimpleTransformation("Lion Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	    desc += "Your hands suddenly start to hurt as your arms grows a thick coat of [skin coat.color] fur up to your shoulders where it turns [haircolor]. You watch enthralled as your nails fall off your fingers, feline claws taking their place on your now five-fingered paw-like hands. <b>You now have leonine paw hands.</b>";
	    player.arms.type = Arms.LION;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.LION));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.LION;
	  }
	);

	public const ArmsDisplacer: Transformation = new SimpleTransformation("Displacer Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	    desc += "Something weird is happening around the level of your ribcage. Painfully large bumps start expanding on the side of your body. You fall on all fours panting heavily from the pain as two new limbs surge under your arms. As you sit, trying to grab these new limbs to check them out, you grab your arms instead. No wait your arm grabbed your arm that grabs another arm?! As you examine yourself you discover a second set of limbs grew under your arms. <b>Guess if your mind actually managed to process the action correctly you could actually use four weapons at once, instead you move around on your three set of limbs not unlike a displacer beast.</b>";
	    player.arms.type = Arms.DISPLACER;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.DISPLACER));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.DISPLACER;
	  }
	);

	public const ArmsCat: Transformation = new SimpleTransformation("Cat Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	    desc += "Your hands suddenly start to hurt as your arms grows a thick coat of [skin coat.color] fur up to your shoulders. You watch enthralled as your nails fall off your fingers, feline claws taking their place on your now five-fingered paw-like hands. <b>You now have cat paw hands.</b>";
	    player.arms.type = Arms.CAT;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.CAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.CAT;
	  }
	);

	public const ArmsRedPanda: Transformation = new SimpleTransformation("Red Panda Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Weakness overcomes your arms, and no matter what you do, you can’t muster the strength to raise or move them. Sighing you attribute this to the consumption of that strange root. Sitting on the ground, you wait for the limpness to end. As you do so, you realize that the bones at your hands are changing, as well as the muscles on your arms. They’re soon covered, from the shoulders to the tip of your digits, on a layer of soft, fluffy black-brown fur. Your hands gain pink, padded paws where your palms were once, and your nails become short claws, not sharp enough to tear flesh, but nimble enough to make climbing and exploring much easier. <b>Your arms have become like those of a red-panda!</b>";
	    player.arms.type = Arms.RED_PANDA;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.RED_PANDA));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.RED_PANDA;
	  }
	);

	public const ArmsOrc: Transformation = new SimpleTransformation("Orc Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	    desc += "The skin on your arms feels as if they’re being cut open as a whole new set of intricate scar-like tattoos covers them. Furthermore your nails become increasingly pointed just like a set of claws and your arms in general grow a bit longer. Well, it seems you’re going to have some issues hiding your <b>scar tattooed arms and sharp nails.</b>";
	    player.arms.type = Arms.ORC;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.ORC));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.ORC;
	  }
	);

	public const ArmsBoar: Transformation = new SimpleTransformation("Boar Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	    desc += "Your arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive. Furthermore your nails become increasingly pointed turning black just like a set of claws. <b>You now have boar arms.</b>";
	    player.skin.coat.color = player.hairColor;
	    player.arms.type = Arms.BOAR;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.BOAR));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.BOAR;
	  }
	);

	public const ArmsPig: Transformation = new SimpleTransformation("Pig Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	    desc += "Your finguers starts to feels like some bee stungs them as they inflates to a more chubby sizes yours nails tickening and darkening turning into clover-like claws. Aside of your now fat finguers and darker claws your arms remains about the same. <b>You now have pig arms.</b>";
	    player.arms.type = Arms.PIG;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.PIG));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.PIG;
	  }
	);

	public const ArmsBatWing: Transformation = new SimpleTransformation("Bat Wing Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	    desc += "Large bones surge out of your wrists and elbows. You can feel your bones shifting and grinding all over your body as your skeletal structure begins changing into one more fit for a flyincreature, with light, hollow bones. You collapse to the ground as they begin shifting proportions, becoming thinner and longer to maximize area while reducing their density. Leathery flesh begins to cover your new bony protrusions, spreading between each of them like creeping moss. Eventually, the skin stops growing and you admire your new arms. They are very obviously winged bat arms. You close them around your waist, and like this they could easily be mistaken for a large cape when seen from afar. <b>You now have large winged bat arms.</b>";
	    player.arms.type = Arms.BAT;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.BAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.BAT;
	  }
	);

	public const ArmsRaijuPaws: Transformation = new SimpleTransformation("Raiju Paws Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	    desc += "You shiver in delight as fur begins to form on your forearms, high voltage running along from your shoulders to your fingertips. Before you know it your hands turned to paws and your sharp nails to vicious looking claws coated with electricity. You can't wait to wrap those around a juicy cock or dip them into a waiting snatch.";
	    if (player.coatColor == "") player.coatColor = player.hairColor;
	    player.arms.type = Arms.RAIJU_PAWS;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.RAIJU_PAWS));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.RAIJU_PAWS;
	  }
	);

	public const ArmsRaiju: Transformation = new SimpleTransformation("Raiju Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.RAIJU));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.RAIJU;
	  }
	);

	public const ArmsOni: Transformation = new SimpleTransformation("Oni Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";
	    if (player.arms.type != Arms.HUMAN) desc += "You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ";
	    desc += "The skin on your arms feels like it’s burning as a whole set of intricate warlike tattoos covers them. Furthermore your nails become increasingly pointed turning black just like a set of claws. Well it seems you will have issues hiding your <b>war tattooed arms with sharp nails.</b>";
	    player.arms.type = Arms.ONI;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.ONI));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.ONI;
	  }
	);

	public const ArmsElf: Transformation = new SimpleTransformation("Elf Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	    desc += "Something in your hands shift as they change taking on a more feminine fragile yet agile structure. You discover with surprise your dexterity has greatly increased allowing you to manipulate things in your delicate elven fingers with almost unreal precision. However your grip has become weaker as a result, weakening your ability to use raw force over finesse. <b>You now have delicate elven hands.</b>";
	    player.arms.type = Arms.ELF;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.ELF));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.ELF;
	  }
	);

	public const ArmsMantis: Transformation = new SimpleTransformation("Mantis Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, turning the [skin.type] into a shiny green carapace.";
	    desc += "\nA moment later the pain fades and you are able to turn your gaze down to your beautiful new arms, covered in shining green chitin from the upper arm down.";
	    desc += "\nThe transformation end as down the lenght of your forearms you grow a pair of massive scythe like appendage just like a mantis.";
	    desc += "\nYou nonchalantly run them across a young tree slicing the plant trunk in half. This might prove a deadly weapon if used as part of your unarmed strikes. <b>You now have mantis arms.</b>";
	    player.arms.type = Arms.MANTIS;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.MANTIS));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.MANTIS;
	  }
	);

	public const ArmsDevil: Transformation = new SimpleTransformation("Devil Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your hands shapeshift as they cover in fur and morph into the clawed hands of some unknown beast. They retain their dexterity despite their weird shape and paw pads. At least this won't hinder spellcasting. <b>You now have bestial clawed hands!</b>";
	    player.arms.type = Arms.DEVIL;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.DEVIL));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.DEVIL;
	  }
	);

	public const ArmsDraconic: Transformation = new SimpleTransformation("Draconic Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. After ignoring the sensation for a while, you finally glance down in irritation, only to discover that your arms had changed from it's former appearance to that of a draconic, one with leathery scales and short claws replacing your fingernails. <b>You now have a draconic arms.</b>";
	    player.arms.type = Arms.DRACONIC;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.DRACONIC));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.DRACONIC;
	  }
	);

	public const ArmsOrca: Transformation = new SimpleTransformation("Orca Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your fingers suddenly are forced together. When you stretch them back you discover they are now webbed, ready for swimming. You are still examining your hands when something not unlike a pair of fins grow out of your forearms. <b>You can only guess those Orca arms will help you to swim at high speeds!</b>";
	    player.arms.type = Arms.ORCA;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.ORCA));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.ORCA;
	  }
	);

	public const ArmsPhoenix: Transformation = new SimpleTransformation("Phoenix Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A crimson colored avian plumage starts to sprouts from your [skin.type], covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.";
	    player.arms.type = Arms.PHOENIX;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.PHOENIX));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.PHOENIX;
	  }
	);

	public const ArmsSalamander: Transformation = new SimpleTransformation("Salamander Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. After ignoring the sensation for a while, you finally glance down in irritation, only to discover that your arms had changed from it's former appearance to that of a salamander, one with leathery, red scales and short claws replacing your fingernails. <b>You now have a salamander arms.</b>";
	    player.arms.type = Arms.SALAMANDER;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.SALAMANDER));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.SALAMANDER;
	  }
	);

	public const ArmsShark: Transformation = new SimpleTransformation("Shark Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form with exception places between your finger which starting show signs to growing webbing. Soon after you start sweating profusely and panting loudly, feeling the space near your elbows shifting about. You hastily remove your [armor] just in time before a strange fin-like structure bursts from your forearms. You examine them carefully and make a few modifications to your [armor] to accommodate your new fins. <b>You now have shark arms.</b>";
	    player.arms.type = Arms.SHARK;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.SHARK));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.SHARK;
	  }
	);

	public const ArmsSpider: Transformation = new SimpleTransformation("Spider Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.arms.type == Arms.HARPY) desc += "The feathers covering your arms fall away, leaving them to return to a far more human appearance. You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a shiny black carapace</b>. You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
	    else if (player.arms.type == Arms.BEE) desc += "The fizz covering your upper arms starting to fall down leaving only shiny black chitin clad arms.";
	    else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRACONIC) desc += "The scales covering your upper arms starting to fall down leaving only shiny black chitin clad arms.";
	    else if (player.arms.type == Arms.MANTIS) desc += "The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the [skinfurscales] into a shiny black carapace</b>.";
	    else {
				TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

				desc += "You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a shiny black carapace</b>. You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
	    }

	    player.coatColor2 = "black";
	    player.arms.type = Arms.SPIDER;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.SPIDER));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.SPIDER;
	  }
	);

	public const ArmsHarpy: Transformation = new SimpleTransformation("Harpy Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "An avian plumage sprouts from your [skin.type], covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.";
	    player.arms.type = Arms.HARPY;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.HARPY));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.HARPY;
	  }
	);

	public const ArmsBee: Transformation = new SimpleTransformation("Bee Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";
	    if (player.arms.type == Arms.SPIDER) desc += "On your upper arms slowly starting to grown yellow fuzz making them looks more like those of bee.";
	    else if (player.arms.type == Arms.MANTIS) desc += "The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>. Additionaly on your upper arms appear yellow fuzz.";
	    else {
	      if (player.arms.type == Arms.HARPY) desc += "The feathers covering your arms fall away, leaving them to return to a far more human appearance. ";
	      desc += "You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>. A moment later the pain fades and you are able to turn your gaze down to your beautiful new arms, covered in shining black chitin from the upper arm down, and downy yellow fuzz along your upper arm.";
	    }
	    player.arms.type = Arms.BEE;
		if (!InCollection(player.coatColor2, "black","ebony")){
			player.coatColor2 = randomChoice("black","ebony");
		}
		if (player.coatColor2 != "yellow"){
			player.coatColor = "yellow";
		}

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.BEE));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.BEE;
	  }
	);

	public const ArmsLizard: Transformation = new SimpleTransformation("Lizard Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. After ignoring the sensation for a while, you finally glance down in irritation, only to discover that your arms had changed from it's former appearance to that of a lizard, one with leathery scales and short claws replacing your fingernails. <b>You now have a lizard arms.</b>";
	    player.arms.type = Arms.LIZARD;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.LIZARD));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.LIZARD;
	  }
	);

	public const ArmsKitsune: Transformation = new SimpleTransformation("Kitsune Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	    desc += "Your finger tingle as your nails sharpen to point. You run them on a tree bark and they feel way harder than your old human nails. <b>You will be able to claw at your opponent with your sharp kitsune nails.</b>";
	    player.arms.type = Arms.KITSUNE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.KITSUNE));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.KITSUNE;
	  }
	);

	public const ArmsFox: Transformation = new SimpleTransformation("Fox Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

	    desc += "Your arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into wolf like claws so no wonder you felt it that much. <b>You now have pawed hands.</b>";
	    player.arms.type = Arms.FOX;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.FOX));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.FOX;
	  }
	);

	public const ArmsPlant: Transformation = new SimpleTransformation("Plant Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. Soon after you start feel something new tickling and crawling its way into being, this time on your shoulders, working its way down your arms. Looking on them you can see a thin, delicate vines, with spade-shaped leaves unfolding from them as they curl snugly around your biceps and deltoids all the way down to your wrists. <b>You now have vine-covered arms.</b>";

	    player.arms.type = Arms.PLANT;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.PLANT;
	  }
	);

	public const ArmsCentipede: Transformation = new SimpleTransformation("Centipede Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your arms feel strangely warm. You look down at them, noticing purple markings being etched into your skin. Your nails sharpen and take on the same purple hue. <b>You could do some serious damage with your sharp nails.</b>";

	    player.arms.type = Arms.CENTIPEDE;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.CENTIPEDE;
	  }
	);

	public const ArmsWendigo: Transformation = new SimpleTransformation("Wendigo Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";

	    player.arms.type = Arms.WENDIGO;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.WENDIGO;
	  }
	);

	public const ArmsYukiOnna: Transformation = new SimpleTransformation("Yuki Onna Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Something weird happens in your hands. For a few seconds you lose the sense of touch and as it comes back your nails turn pale blue. You can feel terrible cold running at your fingertips. While you can dismiss this cold and enable it at will you can’t help but smirk at your newfound ability. <b>Woe to whoever you decide to touch with your glacial hands.</b>";

	    player.arms.type = Arms.YUKI_ONNA;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.YUKI_ONNA;
	  }
	);

	public const ArmsWolf: Transformation = new SimpleTransformation("Wolf Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into wolf like claws so no wonder you felt it that much. <b>You now have pawed hands.</b>";

	    player.arms.type = Arms.WOLF;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.WOLF));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.WOLF;
	  }
	);

	public const ArmsGoo: Transformation = new SimpleTransformation("Goo Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your arms become increasingly wet, as if they were sweating heavily, until eventually you're unsure whether or not they are even solid. The sweat clears up, turning to [skintone] slime. At first, it feels weird, because they are neither entirely solid or liquid, but the simple act of lengthening your limbs to ridiculous reach amuses you. Furthermore you can see right through your hands as if looking through water. Perhaps there's some use to your <b>new goo dripping arms.</b>";

	    player.arms.type = Arms.GOO;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.GOO;
	  }
	);

	public const ArmsHydra: Transformation = new SimpleTransformation("Hydra Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn’t getting rid of the itch. After a longer moment of ignoring it you finally glance down in irritation, only to discover that your arms former appearance changed into that of a reptile with leathery scales and vicious claws replacing your fingernails. <b>You now have hydra arms.</b>";

	    player.arms.type = Arms.HYDRA;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.HYDRA;
	  }
	);

	public const ArmsCaveWyrm: Transformation = new SimpleTransformation("Cave Wyrm Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. After ignoring the sensation for a while, you finally glance down in irritation, only to discover that your arms had changed from it's former appearance to that of a	cave wyrm, one with leathery, black scales and short claws replacing your fingernails. <b>You now have a cave wyrm arms.</b>";

	    player.arms.type = Arms.CAVE_WYRM;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.CAVE_WYRM));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.CAVE_WYRM;
	  }
	);

	public const ArmsAvian: Transformation = new SimpleTransformation("Avian Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
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
	  function (): Boolean {
	    return player.arms.type === Arms.AVIAN;
	  }
	);

	public const ArmsGryphon: Transformation = new SimpleTransformation("Gryphon Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "The skin on your arms change a bit, as the " + player.skin.coat.color2 + " turning into soft, feline fur. Your palms and fingers acquire pink paw pads, while at the end of each one of your fingers, the talons sharpen and become prehensile, adopting a posture better suited to pounce over a unsuspecting victim.";
	    desc += "From the fringe on your elbows to your armpits, your " + player.skin.coat.color + " colored plumage remains the same. <b>At the end, you’ve gotten gryphon-like arms!</b>.";

	    player.arms.type = Arms.GRYPHON;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.GRYPHON;
	  }
	);

	public const ArmsGhost: Transformation = new SimpleTransformation("Ghost Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A numbing sensation crawls upwards from your hands to your elbows, lingering for a few moments. As the pain subsides, you see that your hands have become incorporeal! Panicking, you reach for your weapon, something to grasp and… surprisingly, you manage to hold it normally. After a few moments when you calm down, you drop it. It seems you need to take extra care when you hold things from now on, as <b>you have ghastly hands!</b>";

	    player.arms.type = Arms.GHOST;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.GHOST;
	  }
	);

	public const ArmsGazer: Transformation = new SimpleTransformation("Gazer Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your arms begin to sweat and drip at high rate until they cover in some kind of oily ink black mucus. It drops from your hands down to the ground oozing like tar. You would say ew but for some reason it doesn't smell so bad, heck taking a whiff it almost smells like perfume or rather aphrodisiacs. Heck thinking on it now from a far glance it looks like you are wearing sleeved gloves. <b>Your arms are now covered from the forearm to the digits into tar like fluids.</b>";

	    player.arms.type = Arms.GAZER;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.GAZER));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.GAZER;
	  }
	);

	public const ArmsSquirrel: Transformation = new SimpleTransformation("Squirrel Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your nails tingle as they elongate into white claws. A coat of fur then begins to form up from your wrist to your elbows, coating your forearms like bracers. Your hands feels stronger in every way, heck <b>with these new claws you could just climb and stick to any surface just like a squirrel.</b>";

	    if (player.coatColor == "") player.coatColor = player.hairColor;
	    player.arms.type = Arms.SQUIRREL;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.SQUIRREL;
	  }
	);

	public const ArmsWeasel: Transformation = new SimpleTransformation("Weasel Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your arms begins cover with fur and you watch spellbound as your nails elongate into small sharp animal claws. They aren't exactly strong enough to deal damage but they'll be fine if you ever want to scratch yourself. <b>You now have furry animal arms with paw-like hands not unlike those of a weasel.</b>";

	    if (player.coatColor == "") player.coatColor = player.hairColor;
	    player.arms.type = Arms.WEASEL;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.WEASEL;
	  }
	);

	public const ArmsKamaitachi: Transformation = new SimpleTransformation("Kamaitachi Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Something in your arm bones begins to shift as they suddenly curve and grow awkwardly through the skin, piercing through your fur like a spike. Now juting outside of your wrists like a pair of natural tonfas. the bones begin to reshape, polish and alter itself, fully taking on the consistency of steel! You admire your two Kamaitachi scythes with stupor, they are sharp and hard enough to leave clean deep cuts even in the hardest material and light enough that you can swing them around as if they weren't even there to begin with, lighter than air indeed. Enemies better fear you now that you got those <b>Kamaitachi arm-scythes.</b>";

	    if (player.coatColor == "") player.coatColor = player.hairColor;
	    player.arms.type = Arms.KAMAITACHI;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.KAMAITACHI;
	  }
	);

	public const ArmsRaccoon: Transformation = new SimpleTransformation("Raccoon Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into small like claws so no wonder you felt it that much. <b>You now have pawed hands like those of a raccoon.</b>";

	    player.arms.type = Arms.RACCOON;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.RACCOON;
	  }
	);

	public const ArmsHinezumi: Transformation = new SimpleTransformation("Hinezumi Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You suddenly feel like your forearms are burning. Burning they indeed begin to do, as they suddenly start blazing, a thick coat of fire covering them up to the fist. That’s going to be a very interesting ability to use in combat. <b>You now have blazing arms!</b>";

	    player.arms.type = Arms.HINEZUMI;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.HINEZUMI));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.HINEZUMI;
	  }
	);

	public const ArmsKraken: Transformation = new SimpleTransformation("Kraken Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You notice your hand and forearm skin slowly darkening until it turns pitch black as your nails disappear entirely. Your hands now look like they’re covered in a thin layer of black rubber like gloves, but you know the truth. These truly are your arms and you can feel the touch on your black hands. At least you'll always be dressed elegantly with your<b> new kraken arms.</b>";

	    player.arms.type = Arms.KRAKEN;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.KRAKEN;
	  }
	);

	public const ArmsYeti: Transformation = new SimpleTransformation("Yeti Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your arms start to become excessively hairy down almost to your hands. They're so hairy that you can no longer see your skin. As the fur growth stops, your hands enlarge to twice their size. They look like huge monkey paws. Well, you guess punching people will be easy with your enormous <b>yeti hands!</b>";

	    player.arms.type = Arms.YETI;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.YETI;
	  }
	);

	public const ArmsSeaDragon: Transformation = new SimpleTransformation("Sea Dragon Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your fingers slowly conjoin with a thin webbing between them. It's a strange, slimy feeling. As you examine your hands, something, not unlike a pair of fins, grows out of your forearms and your nails sharpen into curved reptilian claws. <b>You can only guess those Sea Dragons arms will help you to swim at high speeds!</b>";

	    player.arms.type = Arms.SEA_DRAGON;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.SEA_DRAGON;
	  }
	);

	public const ArmsFrostwyrm: Transformation = new SimpleTransformation("Frostwyrm Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your arms and hands suddenly begins to get thicker and bigger, way beyond human size. Your entire forearms and now massive hands first cover with -scale color- scales then with white fur, giving them the appearance of fluffy padded gloves. From the fur however surges out what used to be your nails, now powerful claws capable of digging through solid rock and ice just like those of a frost wyrm. <b>You now have frost wyrm arms!</b>";

	    player.arms.type = Arms.FROSTWYRM;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.FROSTWYRM));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.FROSTWYRM;
	  }
	);

	public const ArmsJabberwocky: Transformation = new SimpleTransformation("Jabberwocky Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your arms and hands suddenly begins to get thicker and bigger, way beyond human size. Your entire forearms and now massive hands first cover with -scale color- scales then with white fur, giving them the appearance of fluffy padded gloves. From the fur however surges out what used to be your nails, now powerful claws capable of digging through solid rock and ice just like those of a jabberwocky. <b>You now have jabberwocky arms!</b>";

				player.arms.type = Arms.JABBERWOCKY;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.JABBERWOCKY));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.JABBERWOCKY;
			}
	);

	public const ArmsBear: Transformation = new SimpleTransformation("Bear Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your hands suddenly start to hurt as your arms grows a thick coat of [skin coat.color] fur up to your shoulders. You watch enthralled as your nails turn into large ursan claws on your now five-fingered paw-like hands. <b>You now have bear-like paw hands.</b>";

	    player.arms.type = Arms.BEAR;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.BEAR;
	  }
	);

	public const ArmsUshiOni: Transformation = new SimpleTransformation("Ushi-Oni Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your onyx exoskeleton begins to itch. You begin to scratch at it incessantly until you can see [haircolor] fur begin to sprout from your arms from the biceps down, forming a diamond spiral where the fur meets skin. Your fingers begin to shake and sink into your hands as 4 huge strong claws grow in their places. <b>After the painful experience you see that you now have Ushi-Oni bestial arms.</b>";

	    player.coatColor = "black";
	    player.arms.type = Arms.USHI_ONI;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.USHI_ONI;
	  }
	);

	public const ArmsMelkie: Transformation = new SimpleTransformation("Melkie Arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Similar to when your legs merged in your tail your forearm begin to change, turning into a pair of glove like seal arms armed with claws. What's more, you have a pair of fins on your elbow similar to a Melkie. <b>Well it'll take some time to get used to your new seal forearms with fins.</b>";

	    player.arms.type = Arms.MELKIE;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.MELKIE;
	  }
	);

	public const ArmsAtlach: Transformation = new SimpleTransformation("Spider arms",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.arms.type == Arms.HARPY || player.arms.type == Arms.HUMAN) {
	      if (player.arms.type == Arms.HARPY) desc += "The feathers covering your arms fall away, leaving them to return to a far more human appearance. ";
	      desc += "You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a midnight purple carapace</b>. You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
	    } else {
	      if (player.arms.type == Arms.BEE) desc += "The fizz covering your upper arms starting to fall down leaving only midnight purple chitin clad arms.";
	      else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRACONIC) desc += "The scales covering your upper arms starting to fall down leaving only midnight purple chitin clad arms.";
	      else if (player.arms.type == Arms.MANTIS) desc += "The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the [skinfurscales] into a midnight purple carapace</b>.";
	      else desc += "You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a midnight purple carapace</b>. You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
	    }
	    if (doOutput) outputText(desc);
	    player.coatColor = "midnight purple";
	    player.coatColor2 = "midnight purple";
	    player.arms.type = Arms.SPIDER;
	    Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.SPIDER));
	  },
	  // is present
	  function (): Boolean {
	    return player.arms.type === Arms.SPIDER;
	  }
	);
  /*
*/

/*
*     ██████  ██ ██      ██      ███████
*    ██       ██ ██      ██      ██
*    ██   ███ ██ ██      ██      ███████
*    ██    ██ ██ ██      ██           ██
*     ██████  ██ ███████ ███████ ███████
*/

/*
  */
	public const GillsNone: Transformation = new SimpleTransformation("No Gills",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    switch (player.gills.type) {
	    case Gills.ANEMONE:
	      desc += "Your chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.";
	      break;
	    default:
	      desc += "You feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your gills shrink into nothingness, leaving only smooth skin behind. Seems you won't be able to stay in the water quite so long anymore.";
	      break;
	    }

	    desc += " <b>You no longer have gills!</b>";

	    player.gills.type = Gills.NONE;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.gills.type === Gills.NONE;
	  }
	);

	public const GillsFish: Transformation = new SimpleTransformation("Fish Gills",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    switch (player.gills.type) {
	    case Gills.ANEMONE:
	      desc += "You feel your gills tingle, a vague numbness registering across thier feathery exterior. You watch in awe as your gill's feathery folds dry out and fall off like crisp autumn leaves. The slits of your gills then rearrange themselves, becoming thinner and shorter, as they shift to the sides of your neck. They now close in a way that makes them almost invisible. As you run a finger over your neck you feel little more than several small raised lines where they meet your skin.";
	      break;
	    default:
	      TransformationUtils.applyTFIfNotPresent(transformations.GillsNone, doOutput);

	      desc += "You feel a sudden tingle on your neck. You reach up to it to feel, whats the source of it. When you touch your neck, you feel that it begins to grow serveral narrow slits which slowly grow longer. After the changes have stopped you quickly head to a nearby puddle to take a closer look at your neck. You realize, that your neck has grown gills allowing you to breathe under water as if you were standing on land.";
	      break;
	    }

	    desc += " <b>You now have fish gills!</b>";

	    player.gills.type = Gills.FISH;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(GillsMem.getMemory(GillsMem.FISH));
	  },
	  // is present
	  function (): Boolean {
	    return player.gills.type === Gills.FISH;
	  }
	);

	public const GillsAnemone: Transformation = new SimpleTransformation("Anemone Gills",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    switch (player.gills.type) {
	    case Gills.FISH:
	      desc += "You feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your gills shrink into nothingness, leaving only smooth skin behind. When you think it's over you feel something emerge from under your neck, flowing down over your chest and brushing your nipples. You look in surprise as your new feathery gills finish growing out, a film of mucus forming over them shoftly after.";
	      break;
	    default:
	      TransformationUtils.applyTFIfNotPresent(transformations.GillsNone, doOutput);

	      desc += "You feel a pressure in your lower esophageal region and pull your garments down to check the area. Before your eyes a pair of feathery gills start to push out of the center of your chest, just below your neckline, parting sideways and draping over your [nipple]s. They feel a bit uncomfortable in the open air at first, but soon a thin film of mucus covers them and you hardly notice anything at all.";
	      break;
	    }

	    desc += " <b>You now have feathery gills!</b>";

	    player.gills.type = Gills.ANEMONE;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.gills.type === Gills.ANEMONE;
	  }
	);

	public const GillsInTentacleLegs: Transformation = new SimpleTransformation("Tentacle Legs Gills",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";

	    player.gills.type = Gills.GILLS_IN_TENTACLE_LEGS;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.gills.type === Gills.GILLS_IN_TENTACLE_LEGS;
	  }
	);
  /*
*/

/*
*    ██████  ███████  █████  ██████      ██████   ██████  ██████  ██    ██
*    ██   ██ ██      ██   ██ ██   ██     ██   ██ ██    ██ ██   ██  ██  ██
*    ██████  █████   ███████ ██████      ██████  ██    ██ ██   ██    ██
*    ██   ██ ██      ██   ██ ██   ██     ██   ██ ██    ██ ██   ██    ██
*    ██   ██ ███████ ██   ██ ██   ██     ██████   ██████  ██████     ██
*/

/*
  */
	public const RearBodyNone: Transformation = new SimpleTransformation("No Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger in it. After a moment the pain passes, though your back is back to what you looked like when you entered this realm!";
	    player.rearBody.type = RearBody.NONE;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.NONE;
	  }
	);

	public const RearBodyLionMane: Transformation = new SimpleTransformation("Lion Mane Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You suddenly feel hair growing all around your neck at a crazy pace. It soon get so thick it almost looks as if you're wearing a [haircolor] fur collar. <b>You now have a full lion mane around your neck.</b>";
	    player.rearBody.type = RearBody.LION_MANE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.LION_MANE));
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.LION_MANE;
	  }
	);

	public const RearBodyDisplacerTentacles: Transformation = new SimpleTransformation("Displacer Tentacles Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.RearBodyNone, doOutput);

	    desc += "Two large fleshy lumps explode from your shoulders and you scream in pain. These fleshy appendages weave and move like whips in your back and only stop doing so when you finally manage to calm yourself. <b>As you look back to see what's going on, you notice you now have a pair of tentacles with thick, fleshy heads. You can feel the air brushing over the sensitive needles and suction cups that cover both of them, your new venom glistening on the tips.</b>";
	    player.rearBody.type = RearBody.DISPLACER_TENTACLES;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.DISPLACER_TENTACLES));
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.DISPLACER_TENTACLES;
	  }
	);

	public const RearBodyBatCollar: Transformation = new SimpleTransformation("Bat Collar Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "An intense itching sets in around your neck. Bringing your hands to your neck to scratch it, you find sparse, downy fuzz. As you scratch away, it continues lengthening and growing in density until you have a collar of fur around your neck.\n\n Well, this isn’t so bad, the scarf-like look is certainly nice, at the very least. <b>Your neck now sports a collar of fur.</b>";
	    player.rearBody.type = RearBody.BAT_COLLAR;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.BAT_COLLAR));
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.BAT_COLLAR;
	  }
	);

	public const RearBodyRaijuMane: Transformation = new SimpleTransformation("Raiju Mane Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "The base of your neck tingles with delight as little sparks travel across your skin. Strands of hair quickly grow in, giving you a [haircolor] collar of fur around your neck. Several strands of your new fur collar are quite dark, arcing around it like lightning.";
	    player.rearBody.type = RearBody.RAIJU_MANE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.RAIJU_MANE));
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.RAIJU_MANE;
	  }
	);

	public const RearBodyOrcaBlowhole: Transformation = new SimpleTransformation("Orca Blowhole Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.RearBodyNone, doOutput);

	    desc += "Pain rushes just behind your shoulder blades as a hole opens up, air rushing in. The hole is burning making you groan in pain as air flows in and out. Eventually you get accustomed to breathing from your back like whales do, but it sure was a weird experience.";
	    if (silly()) desc += " Well it doesn't matter because now you can break the world record of the longest breath holding by sitting on the ocean floor for more than 90 minutes.";
	    player.rearBody.type = RearBody.ORCA_BLOWHOLE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.ORCA_BLOWHOLE));
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.ORCA_BLOWHOLE;
	  }
	);

	public const RearBodySharkFin: Transformation = new SimpleTransformation("Shark Fin Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You groan and slump down in pain, almost instantly regretting eating the tooth. You start sweating profusely and panting loudly, feeling the space between your shoulder blades shifting about. You hastily remove your [armor] just in time before a strange fin-like structure bursts from in-between your shoulders. You examine it carefully and make a few modifications to your [armor] to accommodate your new fin.";
	    player.rearBody.type = RearBody.SHARK_FIN;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.SHARK_FIN));
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.SHARK_FIN;
	  }
	);

	public const RearBodyMetamorphicGoo: Transformation = new SimpleTransformation("Metamorphic Goo Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You suddenly lose shape turning into a puddle on the ground. Confused you begin to try and stand up   At the center of the mass that is your translucent " + player.skinTone + " body, you actually do have something solid that allows you to shape your form, a heart, or more accurately, a core. You try and pull yourself back up, translucent liquid arms and torso shaping back from your body mass as you need them. Once you've recovered the top of your goey human shape you sigh in relief. Curious you begin to try out your new very malleable form reshaping yourself in various forms from a cube to a literal human dildo. Giggling you take back your standard shape thinking of the many naughty things you can do now with this gooey body of yours.";

	    player.rearBody.type = RearBody.METAMORPHIC_GOO;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.METAMORPHIC_GOO;
	  }
	);

	public const RearBodyGhostlyAura: Transformation = new SimpleTransformation("Ghostly Aura Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A chill makes its way through your body. You can feel your body has changed and become something more incorporeal. An eerie glow surrounds your body as you fully become an otherworldly apparition.";

	    player.rearBody.type = RearBody.GHOSTLY_AURA;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.GHOSTLY_AURA;
	  }
	);

	public const RearBodyTentacleEyestalks: Transformation = new SimpleTransformation("Tentacle Eyestalks Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You gasp in alien pleasure as two large protrusions explode from your back freeing a pair of black tentacle stalks. The tips open to a set of eyes the same color as yours gazing at the world. These eyes share their vision with your central eye allowing you to see the world in a full peripheral view. <b>You now have two eye mounted tentacle stalks on your back.</b>";

	    player.createStatusEffect(StatusEffects.GazerEyeStalksPlayer, 2, 0, 0, 0);
	    player.rearBody.type = RearBody.TENTACLE_EYESTALKS;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.TENTACLE_EYESTALKS));
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.TENTACLE_EYESTALKS;
	  }
	);

	public const RearBodyKraken: Transformation = new SimpleTransformation("Kraken Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "As you look at yourself for a second, you notice some small glowing pink dot appearing on your skin as it starts to change hue toward a ghostly white. You think of the deep sea predators using light to confound and capture prey. You realise that you now have <b>bioluminescent ghostly pale skin that will glow slightly even in the darkest reach of the ocean.</b>";

	    player.coatColor = "ghostly pale";

	    player.rearBody.type = RearBody.KRAKEN;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.KRAKEN;
	  }
	);

	public const RearBodyYetiFur: Transformation = new SimpleTransformation("Yeti Fur Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.HairChangeColor(["white"]), doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.SkinPlain);

	    TransformationUtils.applyTFIfNotPresent(transformations.SkinFur(Skin.COVERAGE_LOW, { color: "white" }), false);

	    desc += "Your skin itches incessantly around your crotch and chest. You scratch it, feeling as a coat of white fur sprouts in those areas. <b>You are now partialy covered in white fur like a bikini.</b>";

	    player.rearBody.type = RearBody.YETI_FUR;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.YETI_FUR;
	  }
	);

	public const RearBodyGlacialAura: Transformation = new SimpleTransformation("Glacial Aura Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Cold… so cold! You ball yourself up, trying to get some heat but no matter how much you try it gets colder and colder. Just as you think you are about to freeze to death it stops. You look around you in confusion. The air is chilling yet you don't feel it. The ice at your feet covered up with snow and somehow you know deep down if you wanted you could conjure out a blizzard. <b>You gained a Glacial aura!</b>";

	    player.rearBody.type = RearBody.GLACIAL_AURA;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.GLACIAL_AURA;
	  }
	);

	public const RearBodyFrostwyrm: Transformation = new SimpleTransformation("Frostwyrm Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You suddenly feel hair growing all around your neck at a crazy pace. It soon gets so thick it almost looks as if you're wearing a white fur collar. <b>Your neck is now well protected against the cold thanks to your thick fur collar.</b>";

	    player.rearBody.type = RearBody.FROSTWYRM;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.FROSTWYRM));
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.FROSTWYRM;
	  }
	);

	public const RearBodySnailShell: Transformation = new SimpleTransformation("Snail Shell Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your back begins to hurt as you feel like your flesh and bones are being torn out. You lie down, screaming in pain as your back keeps on expanding, breathing heavily. Not just that but you feel eviscerated as your guts and organs shift places within your body, causing you to puke from the growing nausea. Eventually it all stops and you take a glimpse behind you. A massive shell has grown behind your back, your organs relocating to inside its safety. Geez, what a deep breath! it's like your lungs doubled in size. You finally manage to calm down and crawl your way to a resting spot in order to finish coping with the transformation and the now massive weight on your back. <b>You now have a Shell.</b>";

	    player.coatColor = "brown";
	    player.rearBody.type = RearBody.SNAIL_SHELL;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.SNAIL_SHELL;
	  }
	);

	public const RearBodyCentipede: Transformation = new SimpleTransformation("Centipede Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your neck tingles and begins to itch all of a sudden. You reach up to scratch when your fingers brush up against something hard. You look down to find a pair of grasping pincer like stingers around your neck. They open and close at will and tuck away easily when not in use. <b>It will be easier to hold onto and bite enemies with your new maxillipeds.</b>";

	    player.rearBody.type = RearBody.CENTIPEDE;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.CENTIPEDE;
	  }
	);

	public const RearBodyFenrirIceSpikes: Transformation = new SimpleTransformation("Fenrir Ice Spikes Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";

	    player.rearBody.type = RearBody.FENRIR_ICE_SPIKES;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.FENRIR_ICE_SPIKES;
	  }
	);

	public const RearBodyFurCoat: Transformation = new SimpleTransformation("Fur Coat Rear Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";

	    player.rearBody.type = RearBody.FUR_COAT;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.FUR_COAT;
	  }
	);

	public const RearBodyAtlachNacha: Transformation = new SimpleTransformation("Atlach Nacha rear legs",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.rearBody.type !== RearBody.NONE) {
	      var rear: EnumValue = RearBody.Types[player.rearBody.type];
	      desc += "Your old " + rear.name + " " + (rear.plural ? "are" : "is") + " drooping leaving your back as smooth and unbroken as the day you entered the portal. But this state did not last long. ";
	    }

	    desc += "Pressure is building in multiple spots on your upper back. You can’t help but groan with relief when finally the pressure peaks and many thick protrusions burst impatiently out of your [skin.type]. Four new chitinous limbs thrust their way into being, skittering aimlessly at the air as if to find purchase. After a moment of concentration you cause one of the spindly to rear around into your hand to take a closer look at it.It definitively looks like a spider leg except there's a set of red eyes at the end of the limb blinking back at you. <b>You now have two pairs of spider legs up your back.</b>";

	    if (doOutput) outputText(desc);
	    player.rearBody.type = RearBody.ATLACH_NACHA;
	  },
	  // is present
	  function (): Boolean {
	    return player.rearBody.type === RearBody.ATLACH_NACHA
	  }
	);

	public const rearBodyCobraHood: Transformation = new SimpleTransformation("Cobra Hood",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

				desc += "Pain lances through your neck as your [skin.type] flesh begins to ondulate and change. It hurts but thankfully the pain is short lived and as soon as you are relieved from it you press a hand behind your neck to check for the changes. It would appear the behind of your head all the way to the middle of your back is covered with one large fleshy hood not unlike that of a cobra. You will likely be able to intimidate your foes into submission with your brand new <b>Cobra hood!</b>";
				player.rearBody.type = RearBody.COBRA_HOOD;

				if (doOutput) outputText(desc);
				player.rearBody.type = RearBody.COBRA_HOOD;
				//Metamorph.unlockMetamorph(WingsMem.getMemory(RearBodyMem.COBRA_HOOD));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.COBRA_HOOD
			}
	);
  /*
*/

/*
*     ██       ██████  ██       ██ ███████ ██████      ██████   ██████  ██████  ██    ██
*     ██      ██    ██ ██       ██ ██      ██   ██     ██   ██ ██    ██ ██   ██  ██  ██
*     ██      ██    ██ ██  ███  ██ █████   ██████      ██████  ██    ██ ██   ██    ██
*     ██      ██    ██ ██ ██ ██ ██ ██      ██   ██     ██   ██ ██    ██ ██   ██    ██
*     ███████  ██████  ████   ████ ███████ ██   ██     ██████   ██████  ██████     ██
*/

/*
  */
	public const LowerBodyBipedal: Transformation = new SimpleTransformation("Bipedal Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.isTaur()) desc += "Your quadrupedal hind-quarters seize, overbalancing your surprised front-end and causing you to stagger and fall to your side. Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow. When it finally stops, <b>you look down to see that you only have two legs</b>! You don't waste time before getting up to test them, confirming that they're working completely fine.";
	    else if (player.lowerBody == LowerBody.MELKIE) desc += "You scream in agony as a horrible pain racks the entire length of your seal-like tail. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the lower body of a seal. Instead, you only have two human legs. <b>You now have a pair of human legs!</b>";
	    else if (player.lowerBody == LowerBody.NAGA) desc += "You scream in agony as a horrible pain racks the entire length of your snake-like coils. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the lower body of a snake. Instead, you only have two human legs. <b>You now have a pair of human legs!</b>";
	    else transformations.LowerBodyHuman.applyEffect(doOutput);

	    if (player.hasStatusEffect(StatusEffects.HydraTailsPlayer)) player.removeStatusEffect(StatusEffects.HydraTailsPlayer);
	    player.legCount = 2;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.legCount === 2;
	  }
	);

	public function LowerBodyTaur(lowerBodyType: int = undefined): Transformation {
	  return new SimpleTransformation("Taur Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      var desc: String = "";

	      // If the target part isn't specified, assume player is becoming Taur from Bipedal version of the same part
	      if (!lowerBodyType) lowerBodyType = player.lowerBody;
	      else player.lowerBody = lowerBodyType;

	      // Fallback parts for attempting to become Taur without legs that allow it
	      if (!player.canTaur() && (player.arms.type != Arms.KITSUNE || player.arms.type != Arms.FOX)) {
	        transformations.LowerBodyHoofed(2).applyEffect();
	        desc += "\n\n";
	      } else if (!player.canTaur()) {
	        transformations.LowerBodyFox(2).applyEffect();
	        desc += "\n\n";
	      }

	      desc += "Immense pain overtakes you as you feel your backbone snap. The agony doesn't stop, blacking you out as your spine lengthens, growing with new flesh from your backside as the bones of your legs flex and twist. Muscle groups shift and rearrange themselves as the change completes, the pain dying away as your consciousness returns. <b>You now have a centaur lower body with four [feet]";
	      if (player.gender > 0) {
	        desc += ", and your genitals now reside between the back legs on your centaur body";
	      }
	      desc += "</b>.";

	      if (player.hasStatusEffect(StatusEffects.HydraTailsPlayer)) player.removeStatusEffect(StatusEffects.HydraTailsPlayer);
	      player.legCount = 4;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.TAUR));
	    },
	    // is present
	    function (): Boolean {
	      return player.legCount === 4;
	    }
	  )
	}

	public const LowerBodyHuman: Transformation = new SimpleTransformation("Human Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.isTaur()) desc += "Your quadrupedal hind-quarters seize, overbalancing your surprised front-end and causing you to stagger and fall to your side. Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow. When it finally stops, <b>you look down to behold your new pair of human legs</b>!";
	    else if (player.isGoo()) desc += "Your lower body rushes inward, molding into two leg-like shapes that gradually stiffen up. In moments they solidify into normal-looking legs, complete with regular, human feet. <b>You now have normal legs!</b>";
	    else if (player.isNaga()) desc += "You collapse as your sinuous snake-tail tears in half, shifting into legs. The pain is immense, particularly where your new feet are forming. <b>You have human legs again.</b>";
	    else if (player.isScylla()) desc += "You collapse as your tentacle legs starts to merge. The pain is immense, particularly where your new feet are forming. <b>You have human legs again.</b>";
	    else if (player.isAlraune()) {
	      desc += "You suddenly lose all feeling from the waist down, your pitcher quickly withering and dying. Soon after it began, your pitcher is reduced to nothing but dust, leaving you to stand on two ordinary human legs. On the ground is all that is left of your flower, a single petal still intact that you proceed to put in your bag. Something tells you you will need it to become an alraune again. <b>You have human legs again.</b>";
	    } else if (player.isBiped()) desc += "You collapse as your legs shift and twist. By the time the pain subsides, you notice that you have normal legs and normal feet. <b>You now have normal legs!</b>";
	    else desc += "Your lower body seizes, causing you to stagger and fall to your side. Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow. When it finally stops, <b>you look down to behold your new pair of human legs</b>!";

	    if (player.hasStatusEffect(StatusEffects.HydraTailsPlayer)) player.removeStatusEffect(StatusEffects.HydraTailsPlayer);
	    player.legCount = 2;
	    player.lowerBody = LowerBody.HUMAN;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.HUMAN && player.legCount === 2;
	  }
	);

	public function LowerBodyHoofed(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Hoofed Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "You stagger as your " + Utils.num2Text(player.legCount) + " [feet] change, curling up into painful angry lumps of flesh. They get tighter and tighter, harder and harder, until at last they solidify into hooves! A coat of beastial fur springs up below your waist, itching as it fills in and completely covers your " + Utils.num2Text(player.legCount) + " [legs].<b> You now have hooves in place of your [feet]!</b>";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.HOOFED) {
	          desc += "\n\nYou stagger as your pair of [feet] change, curling up into painful angry lumps of flesh. They get tighter and tighter, harder and harder, until at last they solidify into hooves! A coat of beastial fur springs up below your waist, itching as it fills in and completely covers your two [legs].<b> You now have hooves in place of your [feet]!</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.HOOFED).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.HOOFED;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.HOOFED));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.HOOFED && player.legCount === legCount;
	    }
	  )
	}

	public const LowerBodySnake: Transformation = new SimpleTransformation("Snake Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    // Doesn't support tails
	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    if (player.lowerBody == LowerBody.SCYLLA) {
	      desc += "You collapse as your tentacle legs starts to merge and the pain is immense. Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience.\n\nOnce you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's.";
	    } else {
	      TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	      desc += "You find it increasingly harder to keep standing as your legs start feeling weak. You swiftly collapse, unable to maintain your own weight. Trying to get back up, you realize that the skin on the inner sides of your thighs is merging together like it was being sewn by an invisible needle. The process continues through the length of your [legs], eventually reaching your [feet].\n\nJust when you think that the transformation is over, you find yourself pinned to the ground by an overwhelming sensation of pain. You hear the horrible sound of your bones snapping, fusing together and changing into something else while you contort in unthinkable agony.\n\nSometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's.\n\n";
	    }
	    desc += "Wondering what happened to your sex, you pass your hand down the front of your body until you find a large, horizontal slit around your pelvic area, which contains all of your sexual organs.";
	    if (player.balls > 0 && player.ballSize > 10) {
	      desc += " You're happy not to have to drag those testicles around with you anymore.";
	    }
	    desc += " But then, scales start to form on the surface of your skin, slowly becoming visible, recoloring all of your body from the waist down in a snake-like pattern. The feeling is... not that bad actually, kind of like callous, except on your whole lower body.\n\nThe transformation complete, you get up, standing on your newly formed snake tail. You can't help feeling proud of this majestic new body of yours.";

	    player.legCount = 1;
	    player.lowerBody = LowerBody.NAGA;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.NAGA));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.NAGA;
	  }
	);

	public const LowerBodyDemonHighHeels: Transformation = new SimpleTransformation("Demon High Heels  Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your [feet]. Something hard breaks through your sole from the inside out. The pain slowly diminishes and your eyes look along a human leg to a thin and sharp horns protruding from the heel. When you relax, your feet are pointing down and their old posture is only possible with an enormous effort. <b>Your feet are now formed into demonic high-heels.</b> Tentatively you stand up and try to take a few steps. To your surprise you feel as if you were born with this and stride vigorously forward, hips swaying.";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.DEMONIC_HIGH_HEELS));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.DEMONIC_HIGH_HEELS;
	  }
	);

	public const LowerBodyDemonClawed: Transformation = new SimpleTransformation("Demon Clawed Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your [feet]. Something hard breaks through your sole from the inside out as your toes splinter and curve cruelly. The pain slowly diminishes and your eyes look along a human leg that splinters at the foot into a claw with sharp black nails. When you relax, your feet grip the ground easily. <b>Your feet are now formed into demonic claws.</b>";

	    player.lowerBody = LowerBody.DEMONIC_CLAWS;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.DEMONIC_CLAWS));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.DEMONIC_CLAWS;
	  }
	);

	public const LowerBodyBee: Transformation = new SimpleTransformation("Bee Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "Your legs tremble with sudden unbearable pain, as if they're being ripped apart from the inside out and being stitched together again all at once. You scream in agony as you hear bones snapping and cracking. A moment later the pain fades and you are able to turn your gaze down to your beautiful new legs, covered in shining black chitin from the thigh down, and downy yellow fuzz along your upper thighs.";

	    player.lowerBody = LowerBody.BEE;
	    player.legCount = 2;
		if (!InCollection(player.coatColor2, "black","ebony")){
			player.coatColor2 = randomChoice("black","ebony");
		}
		if (player.coatColor2 != "yellow"){
			player.coatColor = "yellow";
		}
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.BEE));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.BEE;
	  }
	);

	public function LowerBodyCat(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Cat Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

            desc += "\n\n";
	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        if (player.lowerBody == LowerBody.HOOFED) {
	          desc += "You feel your hooves suddenly splinter, growing into five unique digits. Their flesh softens as your hooves reshape into furred cat paws. <b>You now have cat paws.</b>";
	        } else {
	          desc += "You scream in agony as you feel the bones in your [feet] break and begin to rearrange. When the pain fades, you feel surprisingly well-balanced. <b>You now have cat paws.</b>";
	        }
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        if (player.lowerBody == LowerBody.GOO) {
	          desc += "Your lower body rushes inward, molding into two leg-like shapes that gradually stiffen up. In moments they solidify into digitigrade legs, complete with soft, padded cat-paws. <b>You now have cat-paws!</b>";
	          transformations.LowerBodyBipedal.applyEffect(false);
	          player.lowerBody = LowerBody.CAT;
	        }

	        // Apply TF if the player still isn't Bipedal
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.CAT) {
	          if (player.lowerBody == LowerBody.HOOFED) {
	            desc += "You feel your hooves suddenly splinter, growing into five unique digits. Their flesh softens as your hooves reshape into furred cat paws. <b>You now have cat paws.</b>";
	          } else {
	            desc += "You scream in agony as you feel the bones in your [feet] break and begin to rearrange. When the pain fades, you feel surprisingly well-balanced. <b>You now have cat paws.</b>";
	          }
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.CAT).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.CAT;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.CAT));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.CAT && player.legCount === legCount;
	    }
	  )
	}

	public function LowerBodyLizard(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Lizard Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        if (player.lowerBody == LowerBody.HOOFED) {
	          desc += "\n\nYou scream in agony as you feel your hooves crack and break apart, beginning to rearrange. Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel. <b>You have reptilian legs and claws!</b>";
	        } else {
	          desc += "\n\nPain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration. The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip. <b>You have reptilian legs and claws!</b>";
	        }
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.LIZARD) {
	          if (player.lowerBody == LowerBody.HOOFED) {
	            desc += "\n\nYou scream in agony as you feel your hooves crack and break apart, beginning to rearrange. Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel. <b>You have reptilian legs and claws!</b>";
	          } else {
	            desc += "\n\nPain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration. The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip. <b>You have reptilian legs and claws!</b>";
	          }
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.LIZARD).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.LIZARD;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.LIZARD));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.LIZARD && player.legCount === legCount;
	    }
	  )
	}

	public const LowerBodyHarpy: Transformation = new SimpleTransformation("Harpy Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (!player.isGoo()) {
	      desc += "Your [legs] creak ominously a split-second before they go weak and drop you on the ground. They go completely limp, twisting and reshaping before your eyes in ways that make you wince. Your lower body eventually stops, but the form it's settled on is quite thick in the thighs. Even your [feet] have changed. ";
	    } else {
	      desc += "Your gooey undercarriage loses some of its viscosity, dumping you into the puddle that was once your legs. As you watch, the fluid pulls together into a pair of distinctly leg-like shapes, solidifying into a distinctly un-gooey form. You've even regained a pair of feet! ";
	    }

	    desc += "While humanoid in shape, they have two large, taloned toes on the front and a single claw protruding from the heel. The entire ensemble is coated in [haircolor] feathers from ankle to hip, reminding you of the bird-women of the mountains. <b>You now have harpy legs!</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.HARPY;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.HARPY));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.HARPY;
	  }
	);

	public const LowerBodySpider: Transformation = new SimpleTransformation("Spider Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";
	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "Starting at your [feet], a tingle runs up your [legs], not stopping until it reaches your thighs. From the waist down, your strength completely deserts you, leaving you to fall hard on your [butt] in the dirt. With nothing else to do, you look down, only to be mesmerized by the sight of black exoskeleton creeping up a perfectly human-looking calf. It crests up your knee to envelop the joint in a many-faceted onyx coating. Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton. From a distance it would look almost like a black, thigh-high boot, but you know the truth. <b>You now have human-like legs covered in a black, arachnid exoskeleton.</b>";

	    player.coatColor2 = "black";
	    player.lowerBody = LowerBody.CHITINOUS_SPIDER_LEGS;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.CHITINOUS_SPIDER_LEGS));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.CHITINOUS_SPIDER_LEGS && player.legCount === 2;
	  }
	);

	public const LowerBodyDrider: Transformation = new SimpleTransformation("Drider Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodySpider, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailSpider);

	    desc += "You find yourself suddenly paralyzed below the waist. Your dark, reflective legs splay out and drop you flat on your back. Before you can sit up, you feel tiny feelers of pain mixed with warmth and tingling running through them. Terrified at the thought of all the horrible changes that could be wracking your body, you slowly sit up, expecting to find yourself turned into some incomprehensible monstrosity from the waist down. As if to confirm your suspicions, the first thing you see is that your legs have transformed into eight long, spindly legs. Instead of joining directly with your hips, they now connect with the spider-like body that has sprouted in place of where your legs would normally start. Your abdomen has gotten even larger as well. Once the strength returns to your new, eight-legged lower body, you struggle up onto your pointed 'feet', and wobble around, trying to get your balance. As you experiment with your new form, you find you're even able to twist the spider half of your body down between your legs in an emulation of your old, bipedal stance. That might prove useful should you ever want to engage in 'normal' sexual positions, particularly since your [butt] is still positioned just above the start of your arachnid half. <b>You're now a drider.</b>";

	    player.legCount = 8;
	    player.coatColor2 = "black";
	    player.lowerBody = LowerBody.DRIDER;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.DRIDER));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.DRIDER;
	  }
	);

	public function LowerBodyFox(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Fox Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      if (legCount == 2 && player.lowerBody !== LowerBody.FOX) {
	        if (player.isTaur()) {
	          desc += "You shiver as the strength drains from your back legs. Shaken, you sit on your haunches, forelegs braced wide to stop you from tipping over; their hooves scrape the dirt as your lower body shrinks, dragging them backward until you can feel the upper surfaces of your hindlegs with their undersides. A wave of nausea and vertigo overtakes you, and you close your eyes to shut out the sensations. When they reopen, what greets them are not four legs, but only two... and those roughly in the shape of your old hindleg, except for the furry toes where your hooves used to be. <b>You now have fox legs!</b>";
	        } else if (player.isNaga()) {
	          desc += "Your scales split at the waistline and begin to peel, shedding like old snakeskin. If that weren't curious enough, the flesh - not scales - underneath is pink and new, and the legs it covers crooked into the hocks and elongated feet of a field animal. As the scaly coating falls and you step out of it, walking of necessity on your toes, a fine powder blows from the dry skin. Within minutes, it crumbles completely and is taken by the ever-moving wind. <b>Your legs are now those of a fox!</b>";
	        } else if (player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.DOG || player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.BUNNY || player.lowerBody == LowerBody.KANGAROO) {
	          desc += "Your legs twitch and quiver, forcing you to your seat. As you watch, the ends shape themselves into furry, padded toes. <b>You now have fox feet!</b> Rather cute ones, actually.";
	        } else if (player.lowerBody == LowerBody.DRIDER) {
	          desc += "Your legs buckle under you and you fall, smashing your abdomen on the ground. Though your control deserts and you cannot see behind you, still you feel the disgusting sensation of chitin loosening and sloughing off your body, and the dry breeze on your exposed nerves. Reflexively, your legs cling together to protect as much of their now-sensitive surface as possible. When you try to part them, you find you cannot. Several minutes pass uncomforably until you can again bend your legs, and when you do, you find that all the legs of a side bend together - <b>in the shape of a fox's leg!</b>";
	        } else if (player.isGoo()) {
	          desc += "It takes a while before you notice that your gooey mounds have something more defined in them. As you crane your body and shift them around to look, you can just make out a semi-solid mass in the shape of a crooked, animalistic leg. You don't think much of it until, a few minutes later, you step right out of your swishing gooey undercarriage and onto the new foot. The goo covering it quickly dries up, as does the part you left behind, <b>revealing a pair of dog-like fox legs!</b>";
	        } else {
	          desc += "Your hamstrings tense painfully and begin to pull, sending you onto your face. As you writhe on the ground, you can feel your thighs shortening and your [feet] stretching";
	          if (player.lowerBody == LowerBody.BEE) {
	            desc += ", while a hideous cracking fills the air";
	          }
	          desc += ". When the spasms subside and you can once again stand, <b>you find that your [legs] have been changed to those of a fox!</b>";
	        }

	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, false);
	      } else if (legCount === 2 && player.lowerBody === LowerBody.FOX) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);
	      } else if (legCount === 4 && player.legCount !== 4) {
	        transformations.LowerBodyTaur(LowerBody.FOX).applyEffect();
	      } else if (legCount === 4 && player.legCount === 4) {
	        desc += "Your hamstrings tense painfully and begin to pull, sending you onto your face. As you writhe on the ground, you can feel your four thighs shortening and your [feet] stretching";
	        if (player.lowerBody == LowerBody.BEE) {
	          desc += ", while a hideous cracking fills the air";
	        }
	        desc += ". When the spasms subside and you can once again stand, <b>you find that your [legs] have been changed to those of a fox!</b>";
	      }

	      player.lowerBody = LowerBody.FOX;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.FOX));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.FOX && player.legCount === legCount;
	    }
	  )
	}

	public function LowerBodyDraconic(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Draconic Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

            desc += "\n\n";
	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "You scream in agony as you feel the bones in your [feet] suddenly break and restructure themselves. When the pain is over, you realize that your [feet] have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon [feet].</b>";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        if (player.isTaur()) {
	          desc += "You cry out as spasms of pain suddenly rip through your quadrupedal body, bringing you crashing onto the ground. Words cannot define the agony as muscles and bones twist and shift and collapse violently. When it's all over, you stagger upright, finding yourself standing on two legs again. Though covered in scales and with the paws of some monster lizard instead of [feet], they otherwise look like your old human legs. <b>You now have two dragon feet.</b>";
	          player.lowerBody = LowerBody.DRAGON;
	          transformations.LowerBodyBipedal.applyEffect(false);
	        } else if (player.lowerBody == LowerBody.DRIDER) {
	          desc += "A disquieting feeling ripples through your arachnid abdomen, and you find yourself losing control of your body from the waist down. Your spidery legs flail madly as your abdomen visibly swells, chitin cracking ominously as the pressure builds up inside of you... and then explodes! You wipe the gore from your face in disgust, wondering why you feel no pain. Rolling over, you see that, caked with spider-slime, you now have a new pair of legs, human-like save for the scales and the bestial paws that serve as feet. <b>You now have dragon feet.</b>";
	          player.lowerBody = LowerBody.DRAGON;
	          transformations.LowerBodyBipedal.applyEffect(false);
	        } else if (player.isNaga()) {
	          desc += "You fall on your face to the ground, hissing and screeching in pain - it feels like someone has grabbed the tip of your tail, pulled it viciously straight, and is now splitting it up the middle with a knife! Paralyzed from the waist down, you claw desperately at the earth to try and alleviate the pain, and can only think to thank your lucky stars when it fades away. Looking down where your tail was, though the scales remain, you realize you've become a biped again, your new feet sporting bestial claws on their toes. <b>You now have dragon feet.</b>";
	          player.lowerBody = LowerBody.DRAGON;
	          transformations.LowerBodyBipedal.applyEffect(false);
	        } else if (player.isGoo()) {
	          desc += "A strange tingling sensation fills you, and you watch as your gooey blob of a body begins to ripple and shudder; you try to make it stop, but you can't control it. Before your eyes, it shapes itself into the appearance of legs, the colored slime growing denser and thicker, the surface membrane texturing itself to look like scales. Before you've quite realized what's happened, the slime has set like water freezing, leaving you with humanoid legs once again, though tipped with claws and very reptilian in appearance. <b>You now have dragon feet.</b>";
	          player.lowerBody = LowerBody.DRAGON;
	          transformations.LowerBodyBipedal.applyEffect(false);
	        } else if (player.lowerBody == LowerBody.HOOFED) {
	          desc += "You bellow in pain as your legs break and reform and your hooves seem to suddenly explode, the bones within twisting themselves into monstrous three-toed appendages, more like those of some terrible lizard-thing than anything else. <b>You now have dragon feet.</b>";
	          player.lowerBody = LowerBody.DRAGON;
	          transformations.LowerBodyBipedal.applyEffect(false);
	        } else if (player.isScylla()) {
	          desc += "Something weird happens in your tentacles as your limbs coil into two pillars of flesh and fuse together, your ";
	          if (player.gender == 1) {
	            desc += "[vagina]";
	          } else if (player.gender == 3) {
	            desc += " and ";
	          }
	          if (player.cocks.length > 0) {
	            desc += "[cock],";
	          }
	          desc += " moving back up between your leg to where it used to be. Bones starts to form in your limb and, before you know it, you are staring at a pair of normal human legs. The changes does not end there however. When the pain is over, you realize that you still stand atop human-looking legs, but your [feet] have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon [feet].</b>";
	          player.lowerBody = LowerBody.DRAGON;
	          transformations.LowerBodyBipedal.applyEffect(false);
	        } else if (player.isAlraune()) {
	          desc += "Your petals all withers and fall off as your pitch and flower turn to dust leaving you with normal human legs. The changes does not stop there however. When the pain is over, you realize that you still stand atop human-looking legs, but your [feet] have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon [feet].</b>";
	          player.lowerBody = LowerBody.DRAGON;
	          transformations.LowerBodyBipedal.applyEffect(false);
	        }

	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count and didn't hit any special text
	        if (player.lowerBody !== LowerBody.DRAGON) {
	          desc += "You scream in agony as you feel the bones in your [feet] suddenly break and restructure themselves, toes fusing together, bone swelling out of the merged masses of flesh. When the pain is over, you realize that you still stand atop human-looking legs, but your feet have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon feet.</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.DRAGON).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.DRAGON;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.DRAGON));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.DRAGON && player.legCount === legCount;
	    }
	  )
	}

	public function LowerBodyClovenHoofed(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Cloven Hoofed Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "You feel an odd sensation in your lower region. Your [feet] shift and you hear bones cracking as they reform. Fur grows on your legs and soon you're looking at a <b>new pair of cloven hoofed legs</b>.";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        if (player.lowerBody == LowerBody.NAGA) {
	          desc += "You scream in agony as a horrible pain racks the entire length of your snake-like coils. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the lower body of a snake. Instead, you only have two legs. They are digitigrade and end in cloven hooves. <b>You now have pig legs!</b>";
	          player.lowerBody = LowerBody.CLOVEN_HOOFED;
	          transformations.LowerBodyBipedal.applyEffect(false);
	        } else if (player.lowerBody == LowerBody.MELKIE) {
	          desc += "You scream in agony as a horrible pain racks the entire length of your seal-like tail. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the lower body of a seal. Instead, you only have two legs. They are digitigrade and end in cloven hooves. <b>You now have pig legs!</b>";
	          player.lowerBody = LowerBody.CLOVEN_HOOFED;
	          transformations.LowerBodyBipedal.applyEffect(false);
	        }

	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count and didn't hit any special text
	        if (player.lowerBody !== LowerBody.CLOVEN_HOOFED) {
	          desc += "\n\nYou scream in agony as the bones in your legs break and rearrange. Once the pain subsides, you inspect your legs, finding that they are digitigrade and ending in cloven hooves. <b>You now have a pair of cloven hoofed legs!</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.CLOVEN_HOOFED).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.CLOVEN_HOOFED;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.CLOVEN_HOOFED));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.CLOVEN_HOOFED && player.legCount === legCount;
	    }
	  )
	}

	public function LowerBodySalamander(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Salamander Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        if (player.lowerBody == LowerBody.HOOFED) {
	          desc += "You scream in agony as you feel your hooves crack and break apart, beginning to rearrange. Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel. <b>You have salamander legs and claws!</b>";
	        } else {
	          desc += "Pain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration. The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip. <b>You have salamander legs and claws!</b>";
	        }
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.SALAMANDER) {
	          if (player.lowerBody == LowerBody.HOOFED) {
	            desc += "You scream in agony as you feel your hooves crack and break apart, beginning to rearrange. Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel. <b>You have salamander legs and claws!</b>";
	          } else {
	            desc += "Pain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration. The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip. <b>You have salamander legs and claws!</b>";
	          }
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.SALAMANDER).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.SALAMANDER;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.SALAMANDER));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.SALAMANDER && player.legCount === legCount;
	    }
	  )
	}

	public function LowerBodyMantis(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Mantis Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "Your legs tremble with sudden unbearable pain, as if they’re being ripped apart from the inside out and being stitched together again all at once.\nYou scream in agony as you hear bones snapping and cracking. A moment later the pain fades and you are able to turn your gaze down to your beautiful new legs, covered in shining green chitin from the thigh down. <b>You now have mantis feet.</b>";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.MANTIS) {
	          desc += "Your legs tremble with sudden unbearable pain, as if they’re being ripped apart from the inside out and being stitched together again all at once.\nYou scream in agony as you hear bones snapping and cracking. A moment later the pain fades and you are able to turn your gaze down to your beautiful new legs, covered in shining green chitin from the thigh down. <b>You now have mantis feet.</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.MANTIS).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.MANTIS;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.MANTIS));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.MANTIS && player.legCount === legCount;
	    }
	  )
	}

	public function LowerBodyShark(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Shark Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "You feel something change in your [feet] as they morph into a reptilian-like form and webbing forms between your toes. Well, this is sure to help you swim faster. <b>You now have webbed shark feet!</b>";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.SHARK) {
	          desc += "You feel something change in your [feet] as they morph into a reptilian-like form and webbing forms between your toes. Well, this is sure to help you swim faster. <b>You now have webbed shark feet!</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.SHARK).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.SHARK;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.SHARK));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.SHARK && player.legCount === legCount;
	    }
	  )
	}

	public function LowerBodyLion(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Lion Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "Your legs suddenly shift painfully. You feel new fur growing at a rapid rate all over your legs. Something juts out of your toe as they clench into the ground. As you feel the pain recede you sit and take a look at your [feet]; or rather, your large leonine hind paws, now armed with sharp, retractable claws. <b>You now have leonine paws for feet.</b>";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.LION) {
	          desc += "Your legs suddenly shift painfully. You feel new fur growing at a rapid rate all over your legs. Something juts out of your toe as they clench into the ground. As you feel the pain recede you sit and take a look at your [feet]; or rather, your large leonine hind paws, now armed with sharp, retractable claws. <b>You now have leonine paws for feet.</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.LION).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.LION;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.LION));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.LION && player.legCount === legCount;
	    }
	  )
	}

	public function LowerBodyOrca(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Orca Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "Your toes suddenly are forced together. When you stretch them back you discover they are now webbed, ready for swimming. <b>You can only guess those Orca legs will help you to swim at great speed.</b>";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.ORCA) {
	          desc += "Your toes suddenly are forced together. When you stretch them back you discover they are now webbed, ready for swimming. <b>You can only guess those Orca legs will help you to swim at great speed.</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.ORCA).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.ORCA;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.ORCA));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.ORCA && player.legCount === legCount;
	    }
	  )
	}

	public const LowerBodyOni: Transformation = new SimpleTransformation("Oni Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "The skin on your legs feels like it's burning as a whole set of intricate warlike tattoos covers them. Furthermore, your toenails become increasingly pointed turning black just like a set of claws. Well it seems you will have get used to your <b>war tattooed legs and feet topped with sharp nails.</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.ONI;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.ONI));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.ONI;
	  }
	);

	public const LowerBodyElf: Transformation = new SimpleTransformation("Elf Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "Something shifts in your legs as you feel almost supernatural agility imbue your steps granting a nymph like grace to your stride. Your feet are no longer rough but delicate and agile like those of an elf. <b>You now have agile elven feet.</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.ELF;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.ELF));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.ELF;
	  }
	);

	public function LowerBodyRaiju(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Raiju Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "You have trouble standing as multiple flashes of sensation run across your [legs]. Sitting down before you accidently hurt yourself, you watch with apprehension as your [legs] begin to shift, fluffy patches of fur traveling up your [legs] until they reach your knees. You yelp as the bones in your feet split and rearrange themselves into paws. Eventually, the sensation ebbs and you slowly get used to your <b>Raiju paws!</b>";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.RAIJU) {
	          desc += "You have trouble standing as multiple flashes of sensation run across your [legs]. Sitting down before you accidently hurt yourself, you watch with apprehension as your [legs] begin to shift, fluffy patches of fur traveling up your [legs] until they reach your knees. You yelp as the bones in your feet split and rearrange themselves into paws. Eventually, the sensation ebbs and you slowly get used to your <b>Raiju paws!</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.RAIJU).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.RAIJU;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    	Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.RAIJU));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.RAIJU && player.legCount === legCount;
	    }
	  )
	}

	public const LowerBodyRedPanda: Transformation = new SimpleTransformation("Red Panda Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.isTaur()) {
	      desc += "You legs tremble, forcing you to lie on the ground, as they don't seems to answer you anymore. A burning sensation in them is the last thing you remember before briefly blacking out. When it subsides and you finally awaken, you look at them again, only to see that you’ve left with a single set of digitigrade legs, and a much more humanoid backside. Soon enough, the feeling returns to your reformed legs, only to come with an itching sensation. A thick black-brown coat of fur sprouts from them. It’s soft and fluffy to the touch. Cute pink paw pads complete the transformation. Seems like <b>you’ve gained a set of red-panda paws!</b>";
	    } else if (player.isNaga()) {
	      desc += "A strange feeling in your tail makes you have to lay on the ground. Then, the feeling becomes stronger, as you feel an increasing pain in the middle of your coils. You gaze at them for a second, only to realize that they’re dividing! In a matter of seconds, they’ve reformed into a more traditional set of legs, with the peculiarity being that they’re fully digitigrade in shape. Soon, every scale on them falls off to leave soft [skin] behind. That doesn’t last long, because soon a thick coat of black-brown fur covers them. It feels soft and fluffy to the touch. Cute pink paw pads complete the transformation. Seems like <b>you’ve gained a set of red-panda paws!</b>";
	    } else if (player.isGoo()) {
	      desc += "The blob that forms your lower body becomes suddenly rigid under the rhizome effects, forcing you to stay still until the transformation ends. Amazingly, what was once goo turns into flesh and skill in mere seconds, thus leaving you with a very human-like set of legs and feet.\n\nIt doesn’t stop here as a feeling of unease forces you to sit on a nearby rock, as you feel something within your newly regained feet is changing. Numbness overcomes them, as muscles and bones change, softly shifting, melding and rearranging themselves. For a second you feel that they’re becoming goo again, but after a couple of minutes, they leave you with a set of digitigrade legs with pink pawpads, ending in short black claws and covered in a thick layer of black-brown fur. It feels quite soft and fluffy. <b>You’ve gained a set of red-panda paws!</b>";
	    } else {
	      desc += "A feeling of unease forces your to sit on a nearby rock, as you feel something within your [feet] is changing. Numbness overcomes them, as muscles and bones change, softly shifting, melding and rearranging themselves. After a couple of minutes, they leave you with a set of digitigrade legs with pink pawpads, ending in short black claws and covered in a thick layer of black-brown fur. It feels quite soft and fluffy. <b>You’ve gained a set of red-panda paws!</b>";
	    }

	    player.legCount = 2;
	    player.lowerBody = LowerBody.RED_PANDA;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.RED_PANDA));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.RED_PANDA;
	  }
	);

	public const LowerBodyOrc: Transformation = new SimpleTransformation("Orc Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "You have trouble standing up as multiple flashes of mild pain run across your legs as a whole set of intricate scar shaped tattoos covers them. Furthermore, your toenails become increasingly pointed, looking like a set of claws. Well, it seems you will have get used to your <b>scar tattooed legs and feet topped with pointed nails.</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.ORC;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.ORC));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.ORC;
	  }
	);

	public function LowerBodyDog(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Dog Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        if (player.lowerBody == LowerBody.HUMAN) {
	          desc += "\n\nYou scream in agony as you feel the bones in your feet break and begin to rearrange. <b>You now have paws</b>.";
	        } else if (player.lowerBody == LowerBody.HOOFED) {
	          desc += "\n\nYou feel your hooves suddenly splinter, growing into five unique digits.  Their flesh softens as your hooves reshape into furred paws.";
	        } else {
	          desc += "\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on fur-covered paws!  <b>You now have paws</b>.";
	        }
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.DOG) {
	          if (player.lowerBody == LowerBody.HUMAN) {
	            desc += "\n\nYou scream in agony as you feel the bones in your feet break and begin to rearrange. <b>You now have paws</b>.";
	          } else if (player.lowerBody == LowerBody.HOOFED) {
	            desc += "\n\nYou feel your hooves suddenly splinter, growing into five unique digits.  Their flesh softens as your hooves reshape into furred paws.";
	          } else {
	            desc += "\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on fur-covered paws!  <b>You now have paws</b>.";
	          }
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.DOG).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.DOG;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.DOG && player.legCount === legCount;
	    }
	  )
	}

	public function LowerBodyWolf(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Wolf Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

            desc += "\n\n";
	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "You scream in agony as you feel the bones in your [feet] break and rearrange into bestial paws. Soon your legs cover up with fur from the waist down. The fur is cold to the touch and yet you feel warm and comfortable under it. <b>You now have wolf paws.</b>";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.WOLF) {
	          desc += "You scream in agony as you feel the bones in your [feet] break and rearrange into bestial paws. Soon your legs cover up with fur from the waist down. The fur is cold to the touch and yet you feel warm and comfortable under it. <b>You now have wolf paws.</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.WOLF).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.WOLF;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.WOLF));
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.WOLF && player.legCount === legCount;
	    }
	  )
	}

	public const LowerBodyCentipede: Transformation = new SimpleTransformation("Centipede Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    // Doesn't support tails
	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "Pain shoots through your legs as you stumble to the ground. You can feel the bones in your legs fuse and reshape themselves as they become longer. As the initial pain passes you manage to sit up and look at what happened to you. To your shock or maybe even horror, in place of legs you now have the long, segmented, insectoid body of a centipede. It's easily three times the length as you are tall. Each segment has a pair of pointed spindly legs which will make walking interesting to say the least. At the very end of your insectoid body sits a pair of longer legs that appear to be a set of stingers. You get up to try out your new body. At first you nearly face plant into the ground as you attempt to coordinate your many legs all at once. After some practice you're able to move your new legs in sync and independently with little issue, even enjoying the feeling of curling into yourself. <b>You think you'll have some fun with this new centipede body.</b>";

	    player.legCount = 100;
	    player.lowerBody = LowerBody.CENTIPEDE;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.CENTIPEDE;
	  }
	);

	public const LowerBodyWendigo: Transformation = new SimpleTransformation("Wendigo Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.WENDIGO;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.WENDIGO;
	  }
	);

	public const LowerBodyYukiOnna: Transformation = new SimpleTransformation("Yuki Onna Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "You feel your feet going numb and the numbness spreading up your lower legs. You look down to your feet and notice with surprise that you no longer feel them, aside of the nails turning pale blue there's little to explain the ice forming under your steps. <b>Your feet now chill the ground beneath you.</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.YUKI_ONNA;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.YUKI_ONNA;
	  }
	);

	public const LowerBodyPlantRootClaws: Transformation = new SimpleTransformation("Plant Root Claws Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your [feet]. In few places the skin on your feet breaks up to reveal... a root-like skin underneath. Gradually the rest of the skin around the ankle is shed of uncovering your new feet shape, that are roots arranged in a way to loosely reassemble feet. <b>Your feet are now formed into roots.</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.PLANT_ROOT_CLAWS;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.PLANT_ROOT_CLAWS;
	  }
	);

	public const LowerBodyPlantHighHeels: Transformation = new SimpleTransformation("Plant High Heels Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "You start to feel something new tickling and crawling its way into being, this time on your tights, working its way down your legs.  Looking on them you can see a thin, delicate vines, with spade-shaped leaves unfolding from them as they curl snugly around your thighs and shank all the way down to your ankles. <b>You now have vine-covered legs.</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.PLANT_HIGH_HEELS;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.PLANT_HIGH_HEELS;
	  }
	);

	public const LowerBodyPlantFlower: Transformation = new SimpleTransformation("PlantFlower Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";

	    player.legCount = 12;
	    player.lowerBody = LowerBody.PLANT_FLOWER;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.PLANT_FLOWER;
	  }
	);

	public const LowerBodyGoo: Transformation = new SimpleTransformation("Goo Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your viewpoint rapidly drops as everything below your [butt] and groin melts together into an amorphous blob. Thankfully, you discover you can still roll about on your new slimey undercarriage, but it's still a whole new level of strange.";

	    player.tallness -= 3 + rand(2);
	    if (player.tallness < 36) {
	      player.tallness = 36;;
	    }
	    player.legCount = 1;
	    player.lowerBody = LowerBody.GOO;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.GOO;
	  }
	);

	public const LowerBodyFerret: Transformation = new SimpleTransformation("Ferret Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	    desc += "You scream in agony as the bones in your legs begin to break and rearrange.  Even as the pain passes, an uncomfortable combination of heat and throbbing continues even after the transformation is over.  You rest for a moment, allowing the sensations to subside.  Now feeling more comfortable, <b>you stand up, ready to try out your new ferret legs!</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.FERRET;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.FERRET;
	  }
	);

	public const LowerBodyScylla: Transformation = new SimpleTransformation("Scylla Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    // Doesn't support tails
	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.GillsNone, doOutput);

	    desc += "You suddenly feel your legs giving in bellow you and you fall off to the ground unable to resume standing. You feel something weird down your legs as you notice they are literally boneless! No wonder you fell down there's no way those empty lump of flesh would be able to carry your weight around. As you think over how you will fix this annoying situation wracking pain hits you in waves as your legs seems to stretch to a ridiculous length up to twice your height. Just as you think this can't get any weirder your legs split apart dividing into four then again into eighths! You watch you toe disappearing turning your feet into what could have been described as eight very weird tails when your legs start to cover with what looks like suction cups similar to those of an octopus. <b>Your legs have turned into tentacles!</b>";
	    if (player.gender == Gender.GENDER_FEMALE) desc += " Looking for your privates you notice your pussy is right under your 8 legs just like the center of a fleshy flower and became about huge like a mouth ready to engulf anything.";
	    else if (player.gender == Gender.GENDER_HERM) desc += " Looking for your privates you notice your pussy is right under your 8 legs just like the center of a fleshy flower and became about huge like a mouth ready to engulf anything and your cock is right between your 2 front 'legs' looking almost like another tentacle.";
	    else if (player.gender == Gender.GENDER_MALE) desc += " Looking for your privates you notice your cock is right between your 2 front 'legs' looking almost like another tentacle.";
	    desc += " As you lift yourself standing on your tentacles not only can you still walk somewhat but heck don't you feel like grabbing something and squeezing it in your pleasurable new legs!";

	    transformations.GillsInTentacleLegs.applyEffect(false);
	    player.legCount = 8;
	    player.lowerBody = LowerBody.SCYLLA;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.SCYLLA;
	  }
	);

	public const LowerBodyKraken: Transformation = new SimpleTransformation("Kraken Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    // Doesn't support tails
	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.GillsNone, doOutput);

	    desc += "Something in your tentacle legs shifts as additional limbs grow. You look down to discover two larger tentacles have grown along your eight legs. <b>They look similar to the ones a kraken might have.</b>";

	    transformations.GillsInTentacleLegs.applyEffect(false);
	    player.legCount = 10;
	    player.lowerBody = LowerBody.KRAKEN;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.KRAKEN;
	  }
	);

	public const LowerBodyHydra: Transformation = new SimpleTransformation("Hydra Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodySnake, doOutput);

	    // Doesn't support tails
	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "With a ripping sound your tail suddenly begins to tear apart, splitting from the junction just below your thigh level into two segments as if cut by a scalpel. Pain doubles up as bones snaps, your tail tip growing into larger bulbs which a few second later turns into snake heads hissing loudly and mirroring your pain as blood seeps out of the wound. Finally, the wound left by the splitting of your tail closes at high speed, filling in with new flesh and muscle as your newly acquired hydra regeneration kicks in. <b>You snake tail is now forked with two hydra heads!</b>";

	    if (!player.hasPerk(PerkLib.HydraRegeneration)) player.createPerk(PerkLib.HydraRegeneration, 0, 0, 0, 0);
	    player.createStatusEffect(StatusEffects.HydraTailsPlayer, 2, 0, 0, 0);

	    player.legCount = 2;
	    player.lowerBody = LowerBody.HYDRA;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.HYDRA;
	  }
	);

	public const LowerBodyAvian: Transformation = new SimpleTransformation("Avian Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.isGoo()) {
	      desc += "Trying to advance, you see your goo pseudopod stuck on the ground. Reaching around to look for the cause, you’re surprised to find the goo solidifying, turning into flesh and skin before your eyes.Bones occupy their places on your new legs and feet, and the excess goo evaporates, leaving you with a duo of fully functional, normal legs.\n\nBut, the changes continue as your rearranged pair of feet feel strangely tired, so you sit down and let them rest.  As you shift your attention to them, your toes reshape again, four of them remaining in the the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>";
	    } else if (player.isTaur()) {
	      desc += "An strange sensation overcomes your front legs, and even before you realize it, you found them receding on your body! Standing against a rock to not fall at this change to a more bipedal posture, you contemplate how your spine rearranges itself, and soon, you’re left with the usual set of two legs and a standing spine.\n\nBut, the changes continue as your rearranged pair of feet feel strangely tired, so you sit down and let them rest.  As you shift your attention to them, you realize that they are changing. Before your eyes, your hooves seem to recede, turning back into regular human feet. They don’t last long, though, as your toes reshape again, four of them remaining in the the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>\n\nYour tail splits in two, and eventually reshapes into the more familiar form of two legs. These are far different from the ones that you expected, however; instead of the usual human legs, these have an array of small, shiny golden scales from the knee down, with " + player.skin.coat.color + "-colored feathers taking over the area between your knees and crotch, looking not unlike a bird’s.\n\nYour toes are unusually shaped, too; four of them are in the front, and one of them is on the back of each foot. The toenails have become sharp, menacing talons, best used for snatching prey and the occasional unwilling partner. Looks like <b>you have a new set of avian legs!</b>";
	    } else if (player.lowerBody == LowerBody.MELKIE) desc += "Your body straightens and telescopes suddenly and without the length of your seal half to anchor you, you're left with your face in the dirt.  A shuffling and scraping of falling scales sounds and a terrible cramp takes you as your back half continues migrating, subducting under your [butt] and making you feel extremely bloated. As your once prominent tail dwindles to roughly the length of your torso, a sickly ripping noise fills your head and it bursts apart, revealing two new bird like legs wish sharp claws! Looks like <b>you have a new set of avian legs!</b";
	    else if (player.isScylla()) {
	      desc += "An strange sensation overcomes your " + player.legCount + " tentacles, and even before you realize it, you found that " + (player.legCount - 2) + " of them are receding on your body! Not only that, the ones that remain normal are reshaping themselves into something resembling more an average set of legs. Standing against a rock to not fall at this change to a more bipedal posture, you contemplate how your spine rearranges itself, and soon, you’re left with the usual set of two legs and a standing spine.\n\nBut the changes continue, as your rearranged pair of feet feel strangely tired, so you sit down and let them rest, noticing that you’ve now a set of human-looking feet. They don’t last that way long, though, as your toes reshape again, four of them remaining in the the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>";
	    } else if (player.isAlraune()) {
	      desc += "Trying to advance, you see your floral appendage stuck on the ground. Reaching around to look for the cause, you’re surprised to find the verdant foliage decaying, leaving behind mellified shapes that turn quickly into flesh and skin before your eyes.Bones occupy their places on your new legs and feet, and the excess goo evaporates, leaving you with a duo of fully functional, normal legs.\n\nBut, the changes continue as your rearranged pair of feet feel strangely tired, so you sit down and let them rest.  As you shift your attention to them, your toes reshape again, four of them remaining in the the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>";
	    } else if (player.lowerBody == LowerBody.HOOFED) {
	      desc += "Your feet feel strangely tired, so you sit down and let them rest.  As you shift your attention to them, you realize that they are changing. Before your eyes, your hooves seem to recede, turning back into regular human feet. They don’t last long, though, as your toes reshape again, four of them remaining in the the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>";
	    } else if (player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS) {
	      desc += "Your feet feel strangely tired, so you sit down and let them rest. As you shift your attention to them, you realize that they are changing. The skin below your knees grows an array of small, shiny golden scales and your demonic high-heels recede into your body. Your toes reshape, four of them remaining in the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers sprouting all over the area between your knees and crotch, giving them a more avian visage. Looks like <b>you have a new set of avian legs!</b>";
	    } else {
	      desc += "Your [feet] feel strangely tired, so you sit down and let them rest. As you shift your attention to them, you realize that they are changing. The fur on them below your knees falls off, but is quickly replaced by an array of small, shiny golden scales. Your toes reshape, four of them remaining in the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.";
	      desc += "The rest of your legs change too, " + player.skin.coat.color + "-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage. Looks like <b>you have a new set of avian legs!</b>";
	    }

	    player.legCount = 2;
	    player.lowerBody = LowerBody.AVIAN;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.AVIAN;
	  }
	);

	public const LowerBodyMelkie: Transformation = new SimpleTransformation("Melkie Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "Whoa! Something weird is happening with your legs and without warning, you trip over in confusion. You check to see what the hell is going on, and to your complete surprise, you discover your legs have been replaced by what looks like a seal tail. Just as you ponder in utter confusion and annoyance how you will move on land your vaginal hole opens wide like a suit, letting your two very human legs slide out. Wait what? You got a tail and human legs yet both feels like they are part of the same body. Well, at least you now know where your privates had gone to, though you’re still surprised to discover you have two labia with one between your two human legs. Having a cock slide through both at the same time should feel extra pleasurable. Well, you guess you won’t have trouble walking overland or swimming in the depth of the icy sea with your <b>brand new Melkie tail. Heck, it seems you can get rid of your human legs at will and be a mermaid full time if you want.</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.MELKIE;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.MELKIE;
	  }
	);

	public const LowerBodyUshiOni: Transformation = new SimpleTransformation("Ushi-Oni Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyDrider, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailUshiOni, doOutput);

	    desc += "Your spider body trembles, an intense pressure forming under the chitin, at the same time your plates fall to the ground and [haircolor] fur begins to sprout all over your abdomen. You wince in pain from the sudden growth, your drider legs chitin falls off as well, getting thicker and harder turning into bone. After the torturous session, you look back to see <b>you now have an Ushi-Oni lower body with an internal skeleton and fur.</b>";

	    player.coatColor = "black";
	    player.lowerBody = LowerBody.USHI_ONI;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.USHI_ONI;
	  }
	);

	public const LowerBodyMouse: Transformation = new SimpleTransformation("Mouse Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "Your legs begins to change covering up to the tight with a thin layer of fur. Your feet distort to takes on a more animalistic appearance and the nails sharpens to points more like mouses claws. <b>Seems you now got mouses leg paws now.</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.MOUSE;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.MOUSE));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.MOUSE;
	  }
	);

	public const LowerBodyHinezumi: Transformation = new SimpleTransformation("Hinezumi Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyMouse, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailHinezumi, doOutput);

	    desc += "Your legs grow increasingly hot until suddenly they light up and start blazing, just like your tail. Well wow! Kicking with these is sure to pack an extra punch. The fur under your fiery coat doesn’t seem to burn either, but you're pretty sure anything that gets a kick from your legs is in for a painful experience. <b>You now have blazing mouse legs!</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.HINEZUMI;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.HINEZUMI));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.HINEZUMI;
	  }
	);

	public const LowerBodyYeti: Transformation = new SimpleTransformation("Yeti Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "Your legs start becoming excessively hairy down to your feet. They’re so hairy that you can no longer see your skin. Just as you thought the transformation was over, you see your feet enlarging to twice their size. They look like those of a huge monkey. Well, you guess people can call you Bigfoot now with your enormous <b>yeti feet!</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.YETI;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.YETI;
	  }
	);

	public const LowerBodyGhost: Transformation = new SimpleTransformation("Ghost Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "A numbing sensation crawls upwards from your feet to your thighs, lingering for a few moments. As the pain subsides, you realize to your horror that your legs have become incorporeal!";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.GHOST;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.GHOST;
	  }
	);

	public const LowerBodyGhost2: Transformation = new SimpleTransformation("Ghost 2 Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "A numbing sensation crawls upwards from your feet to your thighs, lingering for a few moments. As the pain subsides, you realize to your horror that your feet have become merged… and incorporeal! You drop on your butt… or so you expect. You feel like you are standing, yet you are severely lacking in actual legs. Regardless, you need to get used to your  <b>brand new ghastly lower body!</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.GHOST_2;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.GHOST_2;
	  }
	);

	public const LowerBodyGazer: Transformation = new SimpleTransformation("Gazer Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "Your legs begin to sweat and drip at high rate until they cover in some kind of oily black fluids just like those of a gazer. <b>You now have gazer legs.</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.GAZER;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.GAZER));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.GAZER;
	  }
	);

	public const LowerBodyFireSnail: Transformation = new SimpleTransformation("Fire Snail Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "You find it increasingly harder to keep standing as your legs start feeling weak. You swiftly collapse, unable to maintain your own weight.\n\nTrying to get back up, you realize that the skin on the inner sides of your thighs is merging together like it was being sewn by an invisible needle. The process continues through the length of your legs, eventually reaching your feet. Just when you think that the transformation is over, you find yourself pinned to the ground by an overwhelming sensation of pain. You hear the horrible sound of your bones changing into something else or disintegrating while you contort in unthinkable agony. Sometime later you feel the pain began to ease and you lay on the ground, spent by the terrible experience. Once you feel you’ve recovered, you try to stand, but to your amazement you discover that you no longer have legs: the bottom half of your body is united in a large wide lump, ending into a point. It’s not that your bones were altered but it’s that everything below your waist was converted to muscle mass like that of an invertebrate. Your spine now reaches all the way up to your waist and ends at your thigh where it vanishes fully.\n\nWondering what happened to your sex, you pass your hand down the front of your body until you find a large, horizontal slit around your pelvic area, which contains all of your sexual organs. Your underbelly begins to sweat profusely so much that it becomes glistening, your fat tail shining wetly as the ground beneath you gets covered with your viscous sticky fluids. Your underbody feels and looks like that of a slug or a snail and come to think of it it might just be exactly that. <b>Your lower body is now a snail tail.</b>";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, false);
	    player.legCount = 1;
	    player.lowerBody = LowerBody.FIRE_SNAIL;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.FIRE_SNAIL;
	  }
	);

	public const LowerBodyFrostwyrm: Transformation = new SimpleTransformation("Frostwyrm Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    const wyrmCoatColor: Array = ["bluish black", "dark gray", "black", "midnight black", "midnight"];

	    // Doesn't support tails
	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    if (player.lowerBody == LowerBody.SCYLLA) {
	      desc += "You collapse as your tentacle legs starts to merge and the pain is immense.  Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's and easily four times your length from the waist up.";
	    } else {
	      if (player.lowerBody == LowerBody.MELKIE) {
	        desc += "\n\n";
	        transformations.LowerBodyHuman.applyEffect();
	        desc += "However this doesn't last long as changes begins to overcome your legs again. ";
	      }
	      desc += "You find it increasingly harder to keep standing as your legs start feeling weak. You swiftly collapse, unable to maintain your own weight as your legs begins to changes.\n\nTrying to get back up, you realize that the skin on the inner sides of your thighs is merging together like it was being sewn by an invisible needle. The process continues through the length of your [legs], eventually reaching your [feet]. Just when you think that the transformation is over, you find yourself pinned to the ground by an overwhelming sensation of pain. You hear the horrible sound of your bones snapping, fusing together and changing into something else while you contort in unthinkable agony. Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's and easily four times your length from the waist up.";
	    }
	    desc += "Wondering what happened to your sex, you pass your hand down the front of your body until you find a large, horizontal slit around your pelvic area, which contains all of your sexual organs.";
	    if (player.balls > 0 && player.ballSize > 10) desc += " You're happy not to have to drag those testicles around with you anymore.";
	    if (!player.hasCoatOfType(Skin.DRAGON_SCALES)) {
	      player.coatColor = randomChoice(wyrmCoatColor);
	    }
	    desc += " But then, " + player.coatColor + " armored scales start to form on the surface of your skin, slowly becoming visible, recoloring all of your body from the waist down in a snake-like pattern. The feeling is... not that bad actually, kind of like callous, except on your whole lower body. The transformation complete, you get up, standing on your newly formed snake tail. You can't help feeling proud of this majestic new body of yours. This said, it doesn't end there as warm snowy white fur covers up the scale up to your thigh area, seems you are dressed for the winter now. <b>You now have a long, warm and fluffy frost wyrm tail.</b>";

	    player.legCount = 1;
	    player.lowerBody = LowerBody.FROSTWYRM;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.FROSTWYRM));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.FROSTWYRM;
	  }
	);

	public const LowerBodyRaccoon: Transformation = new SimpleTransformation("Raccoon Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    //from naga non-feet (gain fatigue and lose lust)
	    if (player.isNaga()) {
	      desc += "Your body straightens and telescopes suddenly and without the length of your snake half to anchor you, you're left with your face in the dirt.  A shuffling and scraping of falling scales sounds and a terrible cramp takes you as your back half continues migrating, subducting under your [butt] and making you feel extremely bloated.  As your once prominent tail dwindles to roughly the length of your torso, a sickly ripping noise fills your head and it bursts apart, revealing two new legs!  The tattered snake-skin continues melding into your groin as you examine the fuzzy legs and long-toed, sensitive feet.  <b>Looks like you now have raccoon hind-paws...</b> and an upset stomach.";
	      dynStats("lus", -30);
	      fatigue(5);
	    } else if (player.lowerBody == LowerBody.MELKIE) {
	      desc += "Your body straightens and telescopes suddenly and without the length of your seal half to anchor you, you're left with your face in the dirt.  A shuffling and scraping of falling scales sounds and a terrible cramp takes you as your back half continues migrating, subducting under your [butt] and making you feel extremely bloated.  As your once prominent tail dwindles to roughly the length of your torso, a sickly ripping noise fills your head and it bursts apart, revealing two new legs covered in fur!  You examine the fuzzy legs and long-toed, sensitive feet.  <b>Looks like you now have raccoon hind-paws...</b> and an upset stomach.";
	      dynStats("lus", -30);
	      fatigue(5);
	    }
	    //from amoeba non-feet
	    else if (player.isGoo()) desc += "Your gooey undercarriage begins to boil violently, and before you can do anything, it evaporates!  Left sitting on just the small pad of sticky half-dried slime that comprises your [butt], a sudden bulge under you is enough to push you onto your back.  Wondering idly and unable to see what's happening, you close your eyes and try to focus on what sensations you can feel from your lower body.  You feel... a swell of expansion, followed by weak muscles trying to contract for the first time, pulling flimsy, folded limbs apart and laying them flat.  As your attention wanders downward, you feel toes wiggling - far longer toes than you remember.  For several minutes you lie still and test muscles gingerly as your body solidifes, but when you can finally move again and look at your legs properly, what you see surprises you very little.  <b>You have fuzzy legs and a pair of long-toed raccoon paws!</b>";
	    //from hooves or hard feet, including centaurs and bees
	    else if (player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.BEE || player.lowerBody == LowerBody.PONY || player.lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS || player.isTaur()) {
	      desc += "Your [feet] feel very... wide, all of a sudden.  You clop around experimentally, finding them far less responsive and more cumbersome than usual.  On one step, one of your feet ";
	      if (player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.PONY) desc += "pops right out of its hoof just in time";
	      else desc += "comes loose inside its long boot, and you pull it free with irritation only";
	      desc += " for you to set it back down on a sharp rock! Biting off a curse, you examine the new bare foot. It looks much like a human's, except for the nearly-twice-as-long toes. You find you can even use them to pick things up; the sharp rock is dropped into your hand and tossed far away. The shed [foot] is quickly joined on the ground by its complement, revealing more long toes. ";
	      if (player.isTaur()) desc += "For a few minutes you amuse yourself with your four prehensile feet... you even make up a game that involves juggling a stone under your body by tossing it between two feet while balancing on the others. It's only a short while, however, before your lower stomach grumbles and a searing pain makes you miss your catch.  Anticipating what will happen, you lie down carefully and close your eyes, biting down on a soft wad of cloth. The pain quickly returns and drives you into unconsciousness, and when you awaken, your back legs are gone. ";
	      desc += "<b>You now have two fuzzy, long-toed raccoon legs.</b>";
	    } else {
	      desc += "Your toes wiggle of their own accord, drawing your attention.  Looking down, you can see them changing from their current shape, stretching into oblongs.  When they finish, your foot appears humanoid, but with long, prehesile toes!  ";
	      if ((player.lowerBody == LowerBody.HUMAN || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.PLANT_HIGH_HEELS) && !player.hasFur()) desc += "The sensation of walking around on what feels like a second pair of hands is so weird that you miss noticing the itchy fur growing in over your legs... <b>You now have raccoon paws!</b>";
	    }

	    player.legCount = 2;
	    player.lowerBody = LowerBody.RACCOON;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.RACCOON;
	  }
	);

	public const LowerBodySquirrel: Transformation = new SimpleTransformation("Squirrel Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "You have trouble standing as multiple flashes of sensation run across your legs. Sitting down before you accidentally hurt yourself, you watch with apprehension as your legs begin to shift, fluffy patches of fur traveling up your legs until they reach your knees. You yelp as the bones in your feet split and rearrange themselves into paws. Eventually, the sensation ebbs and you slowly get used to your <b>squirrel paws!</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.SQUIRREL;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.SQUIRREL;
	  }
	);

	public const LowerBodyKangaroo: Transformation = new SimpleTransformation("Kangaroo Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    //gain roo feet from centaur:
	    if (player.isTaur()) desc += "Your backlegs suddenly wobble and collapse, causing you to pitch over onto your side. Try as you might, you can't get them to stop spasming so you can stand back up; you thrash your hooves wildly as a pins-and-needles sensation overtakes your lower body. A dull throbbing along your spine makes you moan in agony; it's as though someone had set an entire bookshelf on your shoulders and your spine were being compressed far beyond its limit. After a minute of pain, the pressure evaporates and you look down at your legs. Not only are your backlegs gone, but your forelegs have taken on a dogleg shape, with extremely long feet bearing a prominent middle toe! You set about rubbing the feeling back into your legs and trying to move the new feet. <b>You now have kangaroo legs!</b>";
	    //gain roo feet from naga:
	    else if (player.lowerBody == LowerBody.NAGA) desc += "Your tail quivers, then shakes violently, planting you on your face. As you try to bend around to look at it, you can just see the tip shrinking out of your field of vision from the corner of your eye. The scaly skin below your waist tightens intolerably, then splits; you wriggle out of it, only to find yourself with a pair of long legs instead! A bit of hair starts to grow in as you stand up unsteadily on your new, elongated feet.  <b>You now have kangaroo legs!</b> Now, what are you going to do with a giant shed snakeskin?";
	    else if (player.lowerBody == LowerBody.MELKIE) desc += "Your body straightens and telescopes suddenly and without the length of your seal half to anchor you, you're left with your face in the dirt.  A shuffling and scraping of falling scales sounds and a terrible cramp takes you as your back half continues migrating, subducting under your [butt] and making you feel extremely bloated.  As your once prominent tail dwindles to roughly the length of your torso, a sickly ripping noise fills your head and it bursts apart, revealing two new legs covered in fur!  You examine the fuzzy legs and long-toed, sensitive feet. <b>Your legs are now those of a kangaroo!</b>";
	    //gain roo feet from slime:
	    else if (player.lowerBody == LowerBody.GOO) desc += "Your mounds of goo shrink and part involuntarily, exposing your crotch. Modesty overwhelms you and you try to pull them together, but the shrinkage is continuing faster than you can shift your gooey body around.  Before long you've run out of goo to move, and your lower body now ends in a pair of slippery digitigrade legs with long narrow feet. They dry in the air and a bit of fur begins to sprout as you look for something to cover up with.  <b>You now have kangaroo legs!</b> You sigh.  Guess this means it's back to wearing underpants again.";
	    //gain roo feet from human/bee/demon/paw/lizard:
	    else desc += "Your feet begin to crack and shift as the metatarsal bones lengthen.  Your knees buckle from the pain of your bones rearranging themselves, and you fall over.  After fifteen seconds of what feels like your feet being racked, the sensation stops.  You look down at your legs; they've taken a roughly dog-leg shape, but they have extremely long feet with a prominent middle toe!  As you stand up you find that you're equally comfortable standing flat on your feet as you are on the balls of them! <b>You now have kangaroo legs!</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.KANGAROO;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.KANGAROO;
	  }
	);

	public const LowerBodyCaveWyrm: Transformation = new SimpleTransformation("Cave Wyrm Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    //Hooves -
	    if (player.lowerBody == LowerBody.HOOFED) desc += "You scream in agony as you feel your hooves crack and break apart, beginning to rearrange.  Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.";
	    //TAURS -
	    else if (player.isTaur()) desc += "Your lower body is wracked by pain!  Once it passes, you discover that you're standing on digitigrade legs with cave wyrm-like claws.";
	    //feet types -
	    else if (player.lowerBody == LowerBody.HUMAN || player.lowerBody == LowerBody.DOG || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.PLANT_HIGH_HEELS || player.lowerBody == LowerBody.BEE || player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.LIZARD) desc += "You scream in agony as you feel the bones in your legs break and begin to rearrange. They change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.";
	    //Else –
	    else desc += "Pain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration.  The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.";
	    desc += " <b>You have cave wyrm legs and claws!</b>";

	    player.legCount = 2;
	    player.lowerBody = LowerBody.CAVE_WYRM;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.CAVE_WYRM));
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.CAVE_WYRM;
	  }
	);

	public function LowerBodyWeasel(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Weasel Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "You have trouble standing as multiple flashes of sensation run across your legs. Sitting down before you accidentally hurt yourself, you watch with apprehension as your legs begin to shift, fluffy patches of fur traveling up your legs until they reach your knees. You yelp as the bones in your feet split and rearrange themselves into paws. Eventually, the sensation ebbs and you slowly get used to your new <b>weasel paws!</b>";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.WEASEL) {
	          desc += "You have trouble standing as multiple flashes of sensation run across your legs. Sitting down before you accidentally hurt yourself, you watch with apprehension as your legs begin to shift, fluffy patches of fur traveling up your legs until they reach your knees. You yelp as the bones in your feet split and rearrange themselves into paws. Eventually, the sensation ebbs and you slowly get used to your new <b>weasel paws!</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.WEASEL).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.WEASEL;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.WEASEL && player.legCount === legCount;
	    }
	  )
	}

	public function LowerBodyBear(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Bear Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "Your legs suddenly shift, painfully forcing you down on all fours as the bones of your feet change shape into something different. You feel hair growing at a rapid rate all over your legs. Something juts out of your toe as they clench into the ground. As you feel the pain recede, you sit and take a look at your foot or rather, your large bear hind paws, now armed with sharp claws. <b>You now have bear-like paws.</b>";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.BEAR) {
	          desc += "Your legs suddenly shift, painfully forcing you down on all fours as the bones of your feet change shape into something different. You feel hair growing at a rapid rate all over your legs. Something juts out of your toe as they clench into the ground. As you feel the pain recede, you sit and take a look at your foot or rather, your large bear hind paws, now armed with sharp claws. <b>You now have bear-like paws.</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.BEAR).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.BEAR;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.BEAR && player.legCount === legCount;
	    }
	  )
	}

	public function LowerBodySeaDragon(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Sea Dragon Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "Your toes press against each other together as sharp, reptilian claws protrude from your feet. As you unfurl your toes, you notice that they are now webbed. The phalanges seem more suited more for swimming than running. <b>You can only guess those Sea dragon legs will help you to swim at great speeds.</b>";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.SEA_DRAGON) {
	          desc += "Your toes press against each other together as sharp, reptilian claws protrude from your feet. As you unfurl your toes, you notice that they are now webbed. The phalanges seem more suited more for swimming than running. <b>You can only guess those Sea dragon legs will help you to swim at great speeds.</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.SEA_DRAGON).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.SEA_DRAGON;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.SEA_DRAGON && player.legCount === legCount;
	    }
	  )
	}

	public function LowerBodyGryphon(legCount: int = undefined): Transformation {
	  return new SimpleTransformation("Gryphon Lower Body",
	    // apply effect
	    function (doOutput: Boolean): void {
	      if (!legCount) legCount = player.legCount;
	      var desc: String = "";

	      // Case 1: Morph Taur legs without changing leg count
	      if (player.isTaur() && legCount === 4) {
	        desc += "A familiar numbness reaches your legs. The rough skin covering your lower legs and feet change into more usual, soft skin, and shortly after, it starts sprouting " + player.skin.coat.color2 + " colored fur over them.\n\nYour feet themselves reshape, losing their avian stance and gaining one much more feline, complete with soft pink paw pads. The talons at the end of each toe become retractile feline claws. Albeit walking with those seems initially tricky, you easily gain a hold on how using your <b>new gryphon-like legs.</b>";
	      }
	      // Case 2: Bipedal TF
	      else if (legCount === 2) {
	        TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

	        // Display TF text if the player is obtaining this part instead of only changing leg count
	        if (player.lowerBody !== LowerBody.GRYPHON) {
	          desc += "A familiar numbness reaches your legs. The rough skin covering your lower legs and feet change into more usual, soft skin, and shortly after, it starts sprouting " + player.skin.coat.color2 + " colored fur over them.\n\nYour feet themselves reshape, losing their avian stance and gaining one much more feline, complete with soft pink paw pads. The talons at the end of each toe become retractile feline claws. Albeit walking with those seems initially tricky, you easily gain a hold on how using your <b>new gryphon-like legs.</b>";
	        }
	      }
	      // Case 3: Taur TF
	      else if (!player.isTaur() && legCount === 4) {
	        transformations.LowerBodyTaur(LowerBody.GRYPHON).applyEffect(doOutput);
	      }

	      player.lowerBody = LowerBody.GRYPHON;
	      player.legCount = legCount;
	      if (doOutput) outputText(desc);
	    },
	    // is present
	    function (): Boolean {
	      return player.lowerBody === LowerBody.GRYPHON && player.legCount === legCount;
	    }
	  )
	}

	public const LowerBodyBunny: Transformation = new SimpleTransformation("Bunny Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    //Taurs
	    if (player.isTaur()) desc += "Your quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of fur-covered rabbit feet</b>!";
	    //Non-taurs
	    else {
	      desc += "Numbness envelops your [legs] as they pull tighter and tighter.  You overbalance and drop on your " + assDescript();
	      if (player.tailType > Tail.NONE) desc += ", nearly smashing your tail flat";
	      else desc += " hard enough to sting";
	      desc += " while the change works its way through you.  Once it finishes, <b>you discover that you now have fuzzy bunny feet and legs</b>!";
	    }

	    player.legCount = 2;
	    player.lowerBody = LowerBody.BUNNY;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.BUNNY;
	  }
	);

	public const LowerBodyJabberwocky: Transformation = new SimpleTransformation("Jabberwocky Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				//Taurs
				if (player.isTaur()) desc += "Your quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of fur-covered rabbit feet</b>!";
				//Non-taurs
				else {
					desc += "Numbness envelops your [legs] as they pull tighter and tighter.  You overbalance and drop on your " + assDescript();
					if (player.tailType > Tail.NONE) desc += ", nearly smashing your tail flat";
					else desc += " hard enough to sting";
					desc += " while the change works its way through you.  Once it finishes, <b>you discover that you now have fuzzy bunny feet and legs tipped with deadly dragon claws just like a jabberwocky!</b>!";
				}

				player.legCount = 2;
				player.lowerBody = LowerBody.JABBERWOCKY;
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.lowerBody === LowerBody.JABBERWOCKY;
			}
	);

	public const LowerBodyCrab: Transformation = new SimpleTransformation("Crab Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

	    desc += "Your two legs suddenly feel weird, their structure rearranging into bright reddish-orange carapace. You try walking on them, making a few false starts until you manage to achieve a proper gait. Soon enough, it becomes second nature to you. <b>You now have crab legs covered in reddish-orange chitin.</b>";

	    player.coatColor = "reddish-orange";
	    player.legCount = 2;
	    player.lowerBody = LowerBody.CRAB;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.CRAB;
	  }
	);

	public const LowerBodyCancer: Transformation = new SimpleTransformation("Cancer Lower Body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You fall to the ground, your body going limp as you are wracked by intense pain, you faint. When you wake up you are almost scared to look at whatever damage might have occurred. To your surprise, below your waist your body has transformed into that of a huge armored crab, eyes included, with 6 legs and two large pincers strong enough to break rocks. Your privates are at the same place as they were before, hidden behind a quatuor of armored mandibula constantly chittering and foaming. You clench and unclench your pincers, feeling the raw strength in them. Those are going to be soooooo fun to use. <b>You have grown the body of a crab from your waist down.</b>";

	    player.legCount = 6;
	    player.lowerBody = LowerBody.CANCER;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.CANCER;
	  }
	);

	public const LowerBodyAtlach: Transformation = new SimpleTransformation("Chitinous spider legs",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Starting at your [feet], a tingle runs up your [legs], not stopping until it reaches your thighs. From the waist down, your strength completely deserts you, leaving you to fall hard on your [ass] in the dirt. With nothing else to do, you look down, only to be mesmerized by the sight of midnight purple exoskeleton creeping up a perfectly human-looking calf. It crests up your knee to envelop the joint in a many-faceted onyx coating. Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton. From a distance it would look almost like a dark purple, thigh-high boot, but you know the truth. <b>You now have human-like legs covered in a midnight purple, arachnid exoskeleton.</b>";

	    TransformationUtils.applyTFIfNotPresent(transformations.LowerBodySpider, false);
	    player.coatColor = "midnight purple";
	    player.coatColor2 = "midnight purple";
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.CHITINOUS_SPIDER_LEGS && player.legCount === 2;
	  }
	);

	public const LowerBodyAtlachNacha: Transformation = new SimpleTransformation("Atlach Nacha lower body",
	  // apply effect
	  function (doOutput: Boolean): void {
	    if (doOutput) {
	      // No special text outside the event
	    }
	    player.lowerBody = LowerBody.ATLACH_NACHA;
	  },
	  // is present
	  function (): Boolean {
	    return player.lowerBody === LowerBody.ATLACH_NACHA;
	  }
	);
  /*
*/

/*
*    ████████  █████  ██ ██
*       ██    ██   ██ ██ ██
*       ██    ███████ ██ ██
*       ██    ██   ██ ██ ██
*       ██    ██   ██ ██ ███████
*/

/*
  */
	public const TailNone: Transformation = new SimpleTransformation("No Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel something shifting in your backside. Then something detaches from your backside and it falls onto the ground. <b>You no longer have a tail!</b>";
	    player.tailCount = 0;
	    player.tailVenom = 0;
	    player.tailRecharge = 5;
	    player.tailType = Tail.NONE;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.NONE;
	  }
	);

	public const TailScorpion: Transformation = new SimpleTransformation("Scorpion Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType != Tail.NONE) desc += "Painful swelling just above your [ass] doubles you over, and you hear the sound of your tail dropping off onto the ground! Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a segmented scorpion-like tail grows in place of your old one. It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'. <b>You have a scorpion tail.</b>";
	    else desc += "Painful swelling just above your [ass] doubles you over. It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and extending with a series of pops until you have a segmented tail hanging just above your butt. The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide. You sigh as your stinger slides into place with a 'snick', finishing the transformation. <b>You have a scorpion tail.</b>";
	    player.tailVenom = 15;
	    player.tailRecharge = 5;
	    player.tailType = Tail.SCORPION;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.SCORPION));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.SCORPION;
	  }
	);

	public const TailManticore: Transformation = new SimpleTransformation("Manticore Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailScorpion, doOutput);

	    desc += "Your scorpion tail starts shifting as your stinger falls to the ground, leaving you with a wide hole at the tip of your tail. You have a feeling of emptiness in your tail, like if it was hollowed from the inside. The end of your tail where the stinger used to be suddenly explodes into a flower-like bulb of flesh. The petals open into what looks like the inside of a pussy, its folds moist and well lubricated. ";
	    desc += "\n\nRight after the previous transformation’s finished, spikes starts to grow out of the bulbous tip giving your tail tip the appearance of a spiked bulb. Flinging your tail randomly to test your new appendage you shoot one of them straight into a nearby tree. You idly wonder what it will feels like to milk men with this. <b>It seems you've grown the tail of a manticore.</b>";
	    player.tailType = Tail.MANTICORE_PUSSYTAIL;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.MANTICORE));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.MANTICORE_PUSSYTAIL;
	  }
	);

	public const TailBurning: Transformation = new SimpleTransformation("Burning Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "Warmth rampages all over your body before concentrating right above your [ass]. Right on cue, a blade of fire bursts from that spot, spiraling upwards. Strangely, despite the tail being obviously made of flames, it doesn't even feel hot unless you will it to. <b>You now have burning tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.BURNING;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.BURNING));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.BURNING;
	  }
	);

	public const TailTwinkasha: Transformation = new SimpleTransformation("Twinkasha Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailBurning);

	    desc += "Something weird is happening to your tail as the fire suddenly begins to flare to twice its volume. You screech, hiss and yowl in pain like a cat as it suddenly cracks and splits into <b>two fiery cat tails.</b> Feeling horny you proceed to stretch and lick your vagina to damp out your growing heat but it swiftly becomes obvious you will not be able to get rid of that scorching heat without a victim.";

	    player.tailType = Tail.TWINKASHA;
	    player.tailCount = 2;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.TWINKASHA;
	  }
	);

	public const TailCat: Transformation = new SimpleTransformation("Cat Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    var choice: int;
	    if (player.tailType == Tail.NONE) {
	      choice = rand(3);
	      if (choice == 0) desc += "A pressure builds in your backside. You feel under your [armor] and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes and grows most of the way to the ground. A thick coat of fur springs up to cover your new tail. You instinctively keep adjusting it to improve your balance. <b>You now have a cat-tail.</b>";
	      if (choice == 1) desc += "You feel your backside shift and change, flesh molding and displacing into a long, flexible tail! <b>You now have a cat tail.</b>";
	      if (choice == 2) desc += "You feel an odd tingling in your spine and your tail bone starts to throb and then swell. Within a few moments it begins to grow, adding new bones to your spine. Before you know it, you have a tail. Just before you think it's over, the tail begins to sprout soft, glossy [skin coat.color] fur. <b>You now have a cat tail.</b>";
	    } else desc += "You pause and tilt your head... something feels different. Ah, that's what it is; you turn around and look down at your tail as it starts to change shape, narrowing and sprouting glossy fur. <b>You now have a cat tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.CAT;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.CAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.CAT && player.tailCount === 1;
	  }
	);

	public const TailNekomataOneThirdForked: Transformation = new SimpleTransformation("Forked 1/3 Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailCat, doOutput);

	    desc += "A tingling pressure builds on your backside, and your soft, glossy tail begins to glow with an eerie, ghostly light. With a crackle of electrical energy, it starts splitting into two, stopping once the split reaches a third of the way down the length! <b>You now have a cat tail that is forked on the last third of its length.</b>";

	    player.tailType = Tail.NEKOMATA_FORKED_1_3;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.NEKOMATA_FORKED_1_3));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.NEKOMATA_FORKED_1_3;
	  }
	);

	public const TailNekomataTwoThirdsForked: Transformation = new SimpleTransformation("Forked 2/3 Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailCat, doOutput);
	    TransformationUtils.applyTFIfNotPresent(transformations.TailNekomataOneThirdForked, doOutput);

	    desc += "A tingling pressure builds on your backside, and your soft, glossy, and partially forked tail begins to glow with an eerie, ghostly light. With a crackle of electrical energy, it starts splitting into two, stopping as another third of its length becomes forked! <b>You now have a cat tail that is forked at two thirds of its length.</b>";

	    player.tailType = Tail.NEKOMATA_FORKED_2_3;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.NEKOMATA_FORKED_2_3));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.NEKOMATA_FORKED_2_3;
	  }
	);

	public const TailCat2nd: Transformation = new SimpleTransformation("Cat2nd Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailCat, doOutput);
	    TransformationUtils.applyTFIfNotPresent(transformations.TailNekomataOneThirdForked, doOutput);
	    TransformationUtils.applyTFIfNotPresent(transformations.TailNekomataTwoThirdsForked, doOutput);

	    desc += "A tingling pressure builds on your backside, and your soft, glossy, and partially forked tail begins to glow with an eerie, ghostly light. With a crackle of electrical energy, your tail finishes splitting in two! <b>You now have a pair of cat tails.</b>";

	    player.tailType = Tail.CAT;
	    player.tailCount = 2;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.CAT_2));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.CAT && player.tailCount == 2;
	  }
	);

	public const TailRedPanda: Transformation = new SimpleTransformation("RedPanda Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailCount > 1) {
	      desc += "Your tails seem to move on their own, tangling together in a single mass. Before you can ever feel it happening, you realize that they’re merging! An increased sensation of heat, not unlike the flavor of the roots, rushes through your body, and once that it fades, you realize that you now have a single tail.";
	      desc += "The process doesn’t stop here though, as the feel of that spicy root returns, but now the heat is felt only in your tail, as it shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.";
	      desc += "When the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful to the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>";
	    } else if (player.tailType == Tail.NONE) {
	      desc += "Feeling an uncomfortable sensation on your butt, you stretch yourself, attributing it to having sat on a rough surface. A burning sensation runs through your body, similar to the one that you had after eating the root. When it migrates to your back, your attention goes to a mass of fluff that has erupted from your backside. Before you can check it properly, it seems to move on its own, following the heated sensation that now pulsates through your body, and when the heated pulses seem to have stopped, it has become a long, fluffy tube";
	      desc += "Shortly after, the feel of that spicy root returns, but now the heat is felt only in your tail, which shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.";
	      desc += "When the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>";
	    } else if (player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.MANTIS_ABDOMEN) {
	      desc += "Your insectile backside seems affected by the root properties, as your venom production suddenly stops. The flesh within the abdomen retracts into your backside, the chiting covering falling, leaving exposed a layer of soft, bare skin. When the abdomen disappears, your left with a comically sized butt, that soon reverts to its usual size.";
	      desc += "The root keeps doing its thing, as you feel an uncomfortable sensation on your butt. A burning sensation runs through your body, similar to the one that you had after eating the root. When it migrates to your back, your attention goes to a mass of fluff that has erupted from your backside. Before you can check it properly, it seems to move on its own, following the heated sensation that now pulsates through your body, and when the heated pulses seem to have stopped, it has become a long, fluffy tube, quite different from your former abdomen.";
	      desc += "Shortly after, the feel of that spicy root returns, but now the heat is felt only in your tail, which shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.";
	      desc += "When the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>";
	    } else {
	      desc += "The feel of that spicy root returns, but now the heat is felt on your tail, that shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.";
	      desc += "When the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control their moves with easy, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>";
	    }
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.RED_PANDA;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.RED_PANDA));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.RED_PANDA;
	  }
	);

	public const TailHorse: Transformation = new SimpleTransformation("Horse Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN) {
	      desc += "Your insect-like abdomen bunches up as it begins shrinking, exoskeleton flaking off like a snake sheds its skin. It bunches up until it is as small as a tennis ball, then explodes outwards, growing into an animalistic tail shape. Moments later, it explodes into filaments of pain, dividing into hundreds of strands and turning into a shiny horsetail.";
	    } else {
	      TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	      desc += "There is a sudden tickling on your ass, and you notice you have sprouted a long shiny horsetail of the same [haircolor] color as your hair.";
	    }

	    desc += " <b>You now have a horse-tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.HORSE;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.HORSE));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.HORSE;
	  }
	);

	public const TailPig: Transformation = new SimpleTransformation("Pig Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "You feel a tug at the base of your spine as it lengthens ever so slightly. Looking over your shoulder, <b>you find that you have sprouted a small, curly pig tail.</b>";
	    else desc += "You feel a pinching sensation in your [tail] as it begins to warp in change. When the sensation dissipates, <b>you are left with a small, curly pig tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.PIG;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.PIG));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.PIG;
	  }
	);

	public const TailRaiju: Transformation = new SimpleTransformation("Raiju Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "You yelp as a huge lightning bolt bursts out the area just above your ass. You watch in amazement as it twist and curls, slowly becoming thicker and thicker before it fizzles out, <b>leaving you with a silky Raiju tail!</b>";
	    else desc += "You nearly jump out of your skin as your tail burst into a huge lightning bolt. You watch as it curls and twist around before it fizzles out. <b>You now have a silky Raiju tail!</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.RAIJU;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.RAIJU));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.RAIJU;
	  }
	);

	public const TailMantis: Transformation = new SimpleTransformation("Mantis Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "Painful swelling just above your firm backside doubles you over. It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and elongating with a series of pops until you have a bulbous abdomen hanging just above your butt. The whole thing is covered in a hard greenish chitinous material, and large enough to be impossible to hide. <b>You have a Mantis abdomen.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.MANTIS_ABDOMEN;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.MANTIS_ABDOMEN));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.MANTIS_ABDOMEN;
	  }
	);

	public const TailGoat: Transformation = new SimpleTransformation("Goat Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "You feel an odd itchy sensation just above your [ass]. Twisting around to inspect it you find a short stubby tail that wags when you're happy. <b>You now have a goat tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.GOAT;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.GOAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.GOAT;
	  }
	);

	public const TailCow: Transformation = new SimpleTransformation("Cow Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "You feel the flesh above your [butt] knotting and growing. It twists and writhes around itself before flopping straight down, now shaped into a distinctly bovine form. You have a <b>cow tail</b>.";
	    else {
	      if (player.tailType != Tail.SPIDER_ADBOMEN || player.tailType != Tail.BEE_ABDOMEN || player.tailType != Tail.SCORPION || player.tailType != Tail.MANTIS_ABDOMEN) {
	        desc += "Your tail bunches uncomfortably, twisting and writhing around itself before flopping straight down, now shaped into a distinctly bovine form. You have a <b>cow tail</b>.";
	      } else {
	        desc += "Your insect-like abdomen tingles pleasantly as it begins shrinking and softening, chitin morphing and reshaping until it looks exactly like a <b>cow tail</b>.";
	      }
	    }
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.COW;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.COW));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.COW;
	  }
	);

	public const TailDraconic: Transformation = new SimpleTransformation("Draconic Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "A sudden dull, throbbing pain in your [butt] forces your hands to it; you can feel an ominous lump over your tail bone, swelling bigger and bigger with every heartbeat. All of a sudden, it seems to explode, jutting out and around until it hovers near your ankles, the skin under your flesh hard and scaly. <b>You now have a dragon tail flicking at your back, flexible as a whip.</b>";
	    else desc += "An icy sensation fills your behind as your tail suddenly goes curiously numb. Twisting your head around, you watch as it melts and transforms into a reptilian appendage, long and flexible, its tip adorned with wicked spikes. <b>You now have a dragon tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.DRACONIC;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.DRACONIC));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.DRACONIC;
	  }
	);

	public const TailOrca: Transformation = new SimpleTransformation("Orca Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "A large bump starts to grow out of your [ass], making you groan as your spine lengthens for this whole new appendage to form. You finally grow a tail black as midnight with a white underside and a smaller fin closer to your body, likely for hydrodynamism sake. You swing your tail a few times, battering the ground, and realize that you should now be able to easily reach very high speeds on water. <b>You're going to have a lot of fun swimming with your new Orca tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.ORCA;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.ORCA));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.ORCA;
	  }
	);

	public const TailSalamander: Transformation = new SimpleTransformation("Salamander Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "You drop onto the ground as your spine twists and grows, forcing the flesh above your [ass] to bulge out. New bones form, one after another, building a tapered, prehensile tail onto the back of your body. For a brief moment it tip ignite with a red-colored flame that with as little as your merely thought vanish moment later. Still you somehow know you can set ablaze any part or whole your tail at any moment and even use it to burn enemies after lashing them with your tail. <b>You now have a salamander tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.SALAMANDER;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.SALAMANDER));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.SALAMANDER;
	  }
	);

	public const TailShark: Transformation = new SimpleTransformation("Shark Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "Jets of pain shoot down your spine, causing you to gasp in surprise and fall to your hands and knees. Feeling a bulging at the end of your back, you lower your [armor] down just in time for a fully formed shark tail to burst through. You swish it around a few times, surprised by how flexible it is. After some modifications to your clothing, you're ready to go with your brand new shark tail.";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.SHARK;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.SHARK));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.SHARK;
	  }
	);

	public const TailSpider: Transformation = new SimpleTransformation("Spider Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "A burst of pain hits you just above your [butt], coupled with a sensation of burning heat and pressure. You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body. Reaching back, you grab at it with your hands. It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape. The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen! With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones. That may prove useful. <b>You now have a spider's abdomen hanging from above your [butt]!</b>";

	    player.coatColor2 = "black";
	    player.tailVenom = 5;
	    player.tailRecharge = 5;
	    player.tailType = Tail.SPIDER_ADBOMEN;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.SPIDER_ADBOMEN));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.SPIDER_ADBOMEN;
	  }
	);

	public const TailHarpy: Transformation = new SimpleTransformation("Harpy Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType !== Tail.NONE) desc += "Your tail shortens, folding into the crack of your [butt] before it disappears. A moment later, a fan of feathers erupts in its place, fluffing up and down instinctively every time the breeze shifts. <b>You have a feathery harpy tail!</b>";
	    else desc += "A tingling tickles the base of your spine, making you squirm in place. A moment later, it fades, but a fan of feathers erupts from your [skin.type] in its place. The new tail fluffs up and down instinctively with every shift of the breeze. <b>You have a feathery harpy tail!</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.HARPY;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.HARPY));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.HARPY;
	  }
	);

	public const TailBee: Transformation = new SimpleTransformation("Bee Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType !== Tail.NONE) desc += "Painful swelling just above your [butt] doubles you over, and you hear the sound of your tail dropping off onto the ground! Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a rounded bee-like abdomen grows in place of your old tail. It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'.";
	    else desc += "Painful swelling just above your [butt] doubles you over. It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and rounding with a series of pops until you have a bulbous abdomen hanging just above your butt. The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide. You sigh as your stinger slides into place with a 'snick', finishing the transformation. <b>You have a bee's abdomen.</b>";
	    player.tailVenom = 10;
	    player.tailRecharge = 5;
	    player.tailType = Tail.BEE_ABDOMEN;
		if (!InCollection(player.coatColor2, "black","ebony")){
			player.coatColor2 = randomChoice("black","ebony");
		}
		if (player.coatColor2 != "yellow"){
			player.coatColor = "yellow";
		}
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.BEE_ABDOMEN));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.BEE_ABDOMEN;
	  }
	);

	public const TailLizard: Transformation = new SimpleTransformation("Lizard Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "You drop onto the ground as your spine twists and grows, forcing the flesh above your [ass] to bulge out. New bones form, one after another, building a tapered, prehensile tail onto the back of your body. <b>You now have a reptilian tail!</b>";
	    else desc += "You drop to the ground as your tail twists and grows, changing its shape in order to gradually taper to a point. It flicks back and forth, prehensile and totally under your control. <b>You now have a reptilian tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.LIZARD;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.LIZARD));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.LIZARD;
	  }
	);

	public const TailDemonic: Transformation = new SimpleTransformation("Demonic Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType != Tail.NONE) {
	      desc += "";
	      if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN) desc += "You feel a tingling in your insectile abdomen as it stretches, narrowing, the exoskeleton flaking off as it transforms into a flexible demon-tail, complete with a round spaded tip. ";
	      else desc += "You feel a tingling in your tail. You are amazed to discover it has shifted into a flexible demon-tail, complete with a round spaded tip. ";
	      desc += "<b>Your tail is now demonic in appearance.</b>";
	    } else desc += "A pain builds in your backside... growing more and more pronounced. The pressure suddenly disappears with a loud ripping and tearing noise. <b>You realize you now have a demon tail</b>... complete with a cute little spade.";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.DEMONIC;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.DEMONIC));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.DEMONIC;
	  }
	);

	public const TailWolf: Transformation = new SimpleTransformation("Wolf Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) {
	      desc += "A pressure builds in your backside. You feel under your clothes and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes, and grow most of the way to the ground. A thick coat of fur cold to the touch yet warm on your tail skin cover it entirely from the base to the tip. ";
	    }
	    if (player.tailType == Tail.HORSE) desc += "You feel a tightness in your rump, matched by the tightness with which the strands of your tail clump together.  In seconds they fuse into a single tail, rapidly sprouting thick fur. ";
	    else if (player.tailType == Tail.DEMONIC) desc += "The tip of your tail feels strange.  As you pull it around to check on it, the spaded tip disappears, quickly replaced by a thick coat of fur over the entire surface of your tail. ";
	    else desc += "You feel your backside shift and change, flesh molding and displacing into a long puffy tail! ";

	    desc += "<b>You now have a wolf tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.WOLF;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.WOLF));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.WOLF;
	  }
	);

	public const TailDog: Transformation = new SimpleTransformation("Dog Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) {
	      desc += "A pressure builds in your backside. You feel under your clothes and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes, and grow most of the way to the ground. A thick coat of fur springs up to cover your new tail. ";
	    }
	    if (player.tailType == Tail.HORSE) desc += "You feel a tightness in your rump, matched by the tightness with which the strands of your tail clump together.  In seconds they fuse into a single tail, rapidly sprouting thick fur. ";
	    else if (player.tailType == Tail.DEMONIC) desc += "The tip of your tail feels strange.  As you pull it around to check on it, the spaded tip disappears, quickly replaced by a thick coat of fur over the entire surface of your tail. ";
	    else desc += "You feel your backside shift and change, flesh molding and displacing into a long puffy tail! ";

	    desc += "<b>You now have a dog tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.DOG;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.DOG;
	  }
	);

	public const TailCaveWyrm: Transformation = new SimpleTransformation("Cave Wyrm Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "A large bump starts to grow out of your [ass], making you groan as your spine lengthens for this whole new appendage to form. You finally grow a tail with patches of black scales which taper on the ground. Its fat and chubby like that of a newt and its heavy weight helps you keep your balance not to mention that people will just want to outright hug it.  <b>You have grown a large earth wyrm tail.</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.CAVE_WYRM;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.CAVE_WYRM));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.CAVE_WYRM;
	  }
	);

	public const TailRabbit: Transformation = new SimpleTransformation("Rabbit Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "A burning pressure builds at your spine before dissipating in a rush of relief. You reach back and discover a small, fleshy tail that's rapidly growing long, poofy fur. <b>You've got a white bunny-tail! It even twitches when you aren't thinking about it.</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.RABBIT;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.RABBIT;
	  }
	);

	public const TailAvian: Transformation = new SimpleTransformation("Avian Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType !== Tail.NONE) {
	      if (player.tailCount > 1) {
	        desc += "You feel an odd itch down your tail. It’s kind of a familiar feeling, as when you work a muscle to strengthen it. As you’re musing on what could be the cause, something changes on your tails, as they tense and twitch, so you look back to examine what’s happening to them.\n\nWhen you lay your eyes on them, the first thing that you notice if that is they’re entwining in a mess of curls and knots, the flesh on them merging until you have a single one. Then, the lone tail left starts shortening quickly. Soon, it has reduced into a short, fleshy bump of a tail. It doesn’t keep that way long, as it lengthens and wides a little, and start sprouting large, " + player.skin.coat.color + " colored feathers, shaped as wide fan. Some of then are very long, while others, near you [ass], are soft and downy.";
	      } else {
	        desc += "You feel an odd itch down your tail. It’s kind of a familiar feeling, as when you work a muscle to strengthen it. As you’re musing on what could be the cause, something changes on your tail, as it tenses and twitches, so you look back to examine what’s happening.\n\nWhen you lay your eyes on it, the first thing that you notice if that is shortening quickly. Soon, it has reduced into a short, fleshy bump of a tail. It doesn’t keep that way long, as it lengthens and wides a little, and start sprouting large, " + player.skin.coat.color + " colored feathers, shaped as wide fan. Some of then are very long, while others, near you butt, are soft and downy.";
	      }
	    } else {
	      desc += "You feel an odd itch down your spine. It’s kind of a familiar feeling, as when you work a muscle to strengthen it. As you’re musing on what could be the cause, something sprouts just above your butt and you take of your lower clothing so you can examine it.\n\nWhen you lay your eyes on it, you notice a short, fleshy bump of a tail. It doesn’t keep that way long, as it lengthens and wides a little, and start sprouting large, " + player.skin.coat.color + " colored feathers, shaped as wide fan. Some of then are very long, while others, near you butt, are soft and downy.";
	    }
	    desc += " <b>In any case, you have now a full, fan-shaped avian tail above your [butt]!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.AVIAN;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.AVIAN;
	  }
	);

	public const TailGriffin: Transformation = new SimpleTransformation("Griffin Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    desc += "The fan of feathers at your backside reacts under the statue magic effects. An otherworldly magic envelopes it, making the feathers twist and converge in an odd fashion, at the same time that the small bump of your tail elongates until becoming long enough to reach far past your knee.\n\nBefore you notice it, the long feathers have merged into a tuft of " + player.skin.coat.color + " at the end of your now long tail, while the short, downy ones now cover every inch of bare skin that the elongated appendage now have. <b>Well, seems like you gained a griffin-like tail!</b> It’s quite leonine in shape, but its appearance remains a bit avian.";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.GRIFFIN;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.GRIFFIN;
	  }
	);

	public const TailKangaroo: Transformation = new SimpleTransformation("Kangaroo Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "A painful pressure in your lower body causes you to stand straight and lock up. At first you think it might be gas. No... something is growing at the end of your tailbone. As you hold stock still so as not to exacerbate the pain, something thick pushes out from the rear of your garments. The pain subsides and you crane your neck around to look; a long, tapered tail is now attached to your butt and a thin coat of fur is already growing in! <b>You now have a kangaroo tail!</b>";
	    else if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN) {
	      desc += "Your chitinous backside shakes and cracks.  Peering at it as best you can, it appears as though the fuzz is falling out in clumps and the chitin is flaking off.  As convulsions begin to wrack your body and force you to collapse, the ";
	      if (player.tailType == Tail.BEE_ABDOMEN) desc += "hollow stinger drops out of the end, taking the venom organ with it.";
	      else desc += "spinnerets drop out of the end, taking the last of your webbing with it. By the time you're back to yourself, the insectile carapace has fallen off completely, leaving you with a long, thick, fleshy tail in place of your proud, insectile abdomen.  <b>You now have a kangaroo tail!</b>";
	    } else {
	      desc += "Your tail twitches as you eat.  It begins to feel fat and swollen, and you try to look at your own butt as best you can.  What you see matches what you feel as your tail thickens and stretches out into a long cone shape. <b>You now have a kangaroo tail!</b>";
	    }

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.KANGAROO;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.KANGAROO;
	  }
	);

	public const TailThunderbird: Transformation = new SimpleTransformation("Thunderbird Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "You yelp as a huge lightning bolt bursts out the area just above your ass. You watch in amazement as it twist and curls, slowly becoming still before it fully fizzles out, <b>leaving you with a long sinuous bolt shaped thunderbird tail!</b>";
	    else desc += "You nearly jump out of your skin as your tail burst into a huge lightning bolt. You watch as it curls and twist around before it fizzles out. <b>You now have a long sinuous bolt shaped thunderbird tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.THUNDERBIRD;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.THUNDERBIRD;
	  }
	);

	public const TailSquirrel: Transformation = new SimpleTransformation("Squirrel Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "A pressure builds in your backside. You feel under your clothes and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers and bursts out the back of your clothes, it grows most of the way to the ground before suddenly curving back up, turning easily twice as big as you are. A thick coat of light and [skin coat.color] striped fur covers it entirely from the base to the tip. Well it's going to be hard to hide this huge thing, especially since it curls and puffs up just <b>like a squirrel tail.</b>";
	    else desc += "Something weird happens with your tail as it begins to change into something else. Within seconds the shape and coverage becomes closer to what you would expect of a squirrel tail. <b>You now have a squirrel tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.SQUIRREL;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.SQUIRREL;
	  }
	);

	public const TailWeasel: Transformation = new SimpleTransformation("Weasel Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "A pressure builds in your backside. You feel under your waist and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers and bursts out the back of your ass into a tail which gets covered with a thick coat of fur entirely from the base to the tip. <b>You now have a weasel tail.</b>";
	    else desc += "Something weird happens with your tail as it begins to change into something else. Within seconds the shape and coverage becomes closer to what you would expect of a weasel tail. <b>You now have a silky weasel tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.WEASEL;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.WEASEL;
	  }
	);

	public const TailRaccoon: Transformation = new SimpleTransformation("Raccoon Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) {
	      desc += "Pain shivers through your spine and forces you onto the ground; your body locks up despite your attempt to rise again.  You can feel a tug on your spine from your backside, as if someone is trying to pull it out!  Several nodules form along your back, growing into new vertebrae and pushing the old ones downward and into your [armor].  An uncomfortable pressure grows there, as whatever development is taking place fights to free itself from the constriction.  Finally the shifting stops, and you're able to move again; the first thing you do is loosen your bottoms, allowing a matted tail to slide out.  <b>It twitches involuntarily, fluffing out into a ringed raccoon tail!</b>";
	    } else {
	      desc += "Your tail goes rigid with pain, and soon your body follows.  It feels as though your spine is trying to push the growth off of your body... barely, you manage to turn your head to see almost exactly that!  A new ringed, fluffy tail is growing in behind its predecessor, dark bands after light.  Soon it reaches full length and a tear comes to your eye as your old tail parts from its end and drops to the ground like overripe fruit, dissolving.  <b>You now have a raccoon tail!</b>";
	    }

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.RACCOON;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.RACCOON;
	  }
	);

	public const TailMouse: Transformation = new SimpleTransformation("Mouse Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType !== Tail.NONE) {
	      desc += "Your tail clenches and itches simultaneously, leaving you wondering whether to cry out or try to scratch it. The question is soon answered as the pain takes the forefront; looking backward is a horrible strain, but when you manage it, you can see your old appendage morphing into a long, thin line. With a shudder, it begins to shed until it's completely, starkly nude. <b>Your new mouse tail looks a bit peaked.</b>";
	    } else desc += "A small nub pokes from your backside, and you turn to look at it.  When you do, your neck aches as if whiplashed, and you groan as your spine shifts smoothly downward like a rope being pulled, growing new vertebra behind it and expanding the nub into a naked, thin, tapered shape.  <b>Rubbing at your sore neck, you stare at your new mouse tail.</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.MOUSE;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.MOUSE));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.MOUSE;
	  }
	);

	public const TailHinezumi: Transformation = new SimpleTransformation("Hinezumi Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailMouse, doOutput);

	    desc += "You jump in surprise as your tail suddenly sparks and lights ablaze. Oddly, it doesn’t hurt. Your tail doesn’t seem to burn your own skin but whatever it touches is set aflame. Pondering how difficult it will be to move around without torching everything, your tail’s fire suddenly dies down. Seems you can light it up or extinguish it at will. <b>You now have a fiery mouse tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.HINEZUMI;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.HINEZUMI));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.HINEZUMI;
	  }
	);

	public const TailFerret: Transformation = new SimpleTransformation("Ferret Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == 0) {
	      desc += "You slump to the ground as you feel your spine lengthening and twisting, sprouting fur as it finishes growing.  Luckily the new growth does not seem to have ruined your [armor].  <b>You now have a ferret tail!</b>";
	    } else if (player.tailType == Tail.HORSE && player.isTaur()) desc += "You shiver as the wind gets to your tail, all of its shiny bristles having fallen out.  Your tail then begins to lengthen, warming back up as it sprouts a new, shaggier coat of fur.  This new, mismatched tail looks a bit odd on your horse lower body.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.HARPY) desc += "You feel a soft tingle as your tail feathers fall out one by one.  The little stump that once held the feathers down begins to twist and lengthen before sprouting soft, fluffy fur.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.RABBIT) desc += "You feel a pressure at the base of your tiny, poofy bunny tail as it begins to lengthen, gaining at least another foot in length.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.DRACONIC || player.tailType == Tail.LIZARD) desc += "You reach a hand behind yourself to rub at your backside as your tail begins to twist and warp, becoming much thinner than before.  It then sprouts a thick coat of fur.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.COW) desc += "Your tail begins to itch slightly as the poof at the end of your tail begins to spread across its entire surface, making all of its fur much more dense than it was before. It also loses a tiny bit of its former length. <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.CAT) desc += "Your tail begins to itch as its fur becomes much denser than it was before.  It also loses a tiny bit of its former length.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.DOG) desc += "Something about your tail feels... different.  You reach behind yourself, feeling it.  It feels a bit floppier than it was before, and the fur seems to have become a little more dense.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.KANGAROO) desc += "Your tail becomes uncomfortably tight as the entirety of its length begins to lose a lot of its former thickness.  The general shape remains tapered, but its fur has become much more dense and shaggy.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.FOX) desc += "Your tail begins to itch as its fur loses a lot of its former density.  It also appears to have lost a bit of length.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.RACCOON) desc += "Your tail begins to itch as its fur loses a lot of its former density, losing its trademark ring pattern as well.  It also appears to have lost a bit of length.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.HORSE) desc += "You shiver as the wind gets to your tail, all of its shiny bristles having fallen out.  Your tail then begins to lengthen, warming back up as it sprouts a new, shaggier coat of fur.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.MOUSE) desc += "Your tail begins to itch as its bald surface begins to sprout a thick layer of fur.  It also appears to have lost a bit of its former length.  <b>You now have a ferret tail!</b>";
	    else desc += "Your tail begins to itch a moment before it starts writhing, your back muscles spasming as it changes shape. Before you know it, <b>your tail has reformed into a narrow, ferret's tail.</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.FERRET;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.FERRET;
	  }
	);

	public const TailBear: Transformation = new SimpleTransformation("Bear Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType != Tail.NONE) desc += "You feel something shifting in your backside. Then something detaches from your backside and it falls onto the ground. ";
	    desc += "You groan in surprise as you feel your spine lengthening and twisting, sprouting fur as it finishes growing. ";
	    if (!player.isNaked()) desc += "Luckily the new growth does not seem to have ruined your [armor]. ";
	    desc += "Curious, you examine the new appendage, wagging it and smiling as you see your cute, <b>brand new bear-like tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.BEAR;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.BEAR;
	  }
	);

	public const TailUshiOni: Transformation = new SimpleTransformation("Ushi-Oni Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType > Tail.NONE) desc += "You feel something shifting in your backside. Then something detaches from your backside and it falls onto the ground. ";
	    desc += "You feel a little pressure in your rear as you look back you see something emerging from it, a long, dexterous tail appear from it, It looks something along 25 inches witha little orifice in the tip, where the spinneret is located, <b>you now have an Ushi-Oni tail.</b>";

	    player.tailVenom = 5;
	    player.tailRecharge = 5;
	    player.tailType = Tail.USHI_ONI;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.USHI_ONI;
	  }
	);

	public const TailWendigo: Transformation = new SimpleTransformation("Wendigo Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    desc += "";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.WENDIGO;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.WENDIGO;
	  }
	);

	public function TailFox(tailCount: int = 1): Transformation {
	  return new SimpleTransformation("Fox Tail",
	    // apply effect
	    function (doOutput: Boolean): void {
	      var desc: String = "";

	      TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	      if (player.tailType !== Tail.FOX) {
	        transformations.TailNone.applyEffect();

	        desc += "You feel a strange sensation on your backside. When you touch the area, you discover a strange nodule growing there that seems to be getting larger by the second. With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it had a mind of its own. <b>You now have a fox's tail!</b>";

	        player.tailVenom = 0;
	        player.tailRecharge = 0;
	        player.tailType = Tail.FOX;
	        player.tailCount = 1;

	        if (tailCount > 1) {
	          desc += "\n\n";
	        }
	      }

	      if (player.tailCount < tailCount) {
	        const newTails: int = tailCount - player.tailCount;

	        desc += "A tingling pressure builds on your backside, and your bushy tail" + ((player.tailCount > 1) ? "s begin" : " begins") + " to glow with an eerie, ghostly light. With a crackle of electrical energy, ";

	        if (player.tailCount == 1) {
	          desc += "your tail splits itself in " + Utils.num2Text(tailCount) + "!"
	        } else {
	          if (newTails == 1) {
	            desc += "one of your tails splits in two!"
	          } else {
	            desc += "your tails multiply, creating " + Utils.num2Text(newTails) + " more besides the " + Utils.num2Text(player.tailCount) + " you already had!"
	          }
	        }
	      } else if (player.tailCount > tailCount) {
	        const removedTails: int = tailCount - player.tailCount;

	        desc += "A tingling pressure builds on your backside, and your bushy tail" + ((player.tailCount > 1) ? "s begin" : " begins") + " to glow with an eerie, ghostly light. With a crackle of electrical energy, ";

	        if (tailCount == 1) {
	          desc += (player.tailCount == 2 ? "both" : "all") + " your tails"
	        } else if (removedTails == 1) {
	          desc += "two of your tails"
	        } else {
	          desc += "some of your tails"
	        }

	        desc += " magically fuse, leaving you with "

	        if (tailCount == 1) {
	          desc += "only a single remaining fox tail!"
	        } else {
	          desc += Utils.num2Text(tailCount) + " remaining fox tails!"
	        }
	      }

	      desc += " <b>You now have " + Utils.num2Text(tailCount) + " fox tail" + ((tailCount > 1) ? "s" : "") + "!</b>"

		  if (tailCount == 2) ( desc += "<b>\nYour next tail will be available at level 6, provided you have 30 Intelligence and 30 Wisdom.</b>" )
		  else if (tailCount == 3) ( desc += "<b>\nYour next tail will be available at level 12, provided you have 45 Intelligence and 45 Wisdom.</b>" )
		  else if (tailCount == 4) ( desc += "<b>\nYour next tail will be available at level 18, provided you have 60 Intelligence and 60 Wisdom.</b>" )
		  else if (tailCount == 5) ( desc += "<b>\nYour next tail will be available at level 24, provided you have 75 Intelligence and 75 Wisdom.</b>" )
		  else if (tailCount == 6) ( desc += "<b>\nYour next tail will be available at level 30, provided you have 90 Intelligence and 90 Wisdom.\nOnly the truly corrupted would continue gaining tails by directly using the jewels. Pure kitsune should offer up the jewels to Toath.</b>" )
		  else if (tailCount == 7) ( desc += "<b>\nYour next tail will be available at level 36, provided you have 105 Intelligence and 105 Wisdom.</b>" )
		  else if (tailCount == 8) ( desc += "<b>\nYour final tail will be available at level 42, provided you have 120 Intelligence and 120 Wisdom.</b>" )

	      player.tailCount = tailCount;
	      if (doOutput) outputText(desc);

	      switch (tailCount) {
	      case 9:
	        if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance))
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_9));
	      case 8:
	        if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance))
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_8));
	      case 7:
	        if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance))
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_7));
	      case 6:
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_6));
	      case 5:
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_5));
	      case 4:
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_4));
	      case 3:
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_3));
	      case 2:
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_2));
	      case 1:
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX));
	      }
	    },
	    // is present
	    function (): Boolean {
	      return player.tailType == Tail.FOX && player.tailCount == tailCount;
	    }
	  )
	};

	public const TailSpinneretAtlach: Transformation = new SimpleTransformation("Spinneret Atlach Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType !== Tail.NONE) desc += "Your tail shudders as heat races through it, twitching violently until it feels almost as if it's on fire. You jump from the pain at your [butt] and grab at it with your hands. It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape. The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones. That may prove useful. <b>You now have a spider's abdomen hanging from above your [butt]!</b>\n\n";
	    //(No tail)
	    else desc += "A burst of pain hits you just above your [butt], coupled with a sensation of burning heat and pressure. You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body. Reaching back, you grab at it with your hands. It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape. The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones. That may prove useful. <b>You now have a spider's abdomen hanging from above your [butt]!</b>";

	    if (doOutput) outputText(desc);
	    TransformationUtils.applyTFIfNotPresent(transformations.TailSpider, false);
	    player.tailVenom = 5;
	    player.tailRecharge = 5;
	    player.coatColor = "midnight purple";
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.SPIDER_ADBOMEN;
	  }
	);
  /*
*/

/*
*    ██       ██ ██ ███    ██  ██████  ███████
*    ██       ██ ██ ████   ██ ██       ██
*    ██  ███  ██ ██ ██ ██  ██ ██   ███ ███████
*    ██ ██ ██ ██ ██ ██  ██ ██ ██    ██      ██
*    ████   ████ ██ ██   ████  ██████  ███████
*/

/*
  */
	public const WingsNone: Transformation = new SimpleTransformation("No Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.wings.type == Wings.BEE_SMALL || player.wings.type == Wings.BEE_LARGE) {
	      desc += "Your wings twitch and flap involuntarily. You crane your neck to look at them as best you are able; from what you can see, they seem to be shriveling and curling up. They're starting to look a lot like they did when they first popped out, wet and new. <b>As you watch, they shrivel all the way, then recede back into your body.</b>";
	    } else {
	      switch (rand(2)) {
	      case 0:
	        desc += "Sensation fades from your [wings] slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.";
	        break;
	      case 1:
	        desc += "A wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your	shoulder-blades. After a moment the pain passes, though your wings are gone!";
	        break;
	      }
	    }

	    player.wings.desc = "non-existant";
	    player.wings.type = Wings.NONE;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.NONE;
	  }
	);

	public const WingsFeatheredSphinx: Transformation = new SimpleTransformation("Feathered Sphinx Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, [haircolor] wings.</b>";
	    player.wings.desc = "large feathered";
	    player.wings.type = Wings.FEATHERED_SPHINX;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_SPHINX));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.FEATHERED_SPHINX;
	  }
	);

	public const WingsManticoreLarge: Transformation = new SimpleTransformation("Manticore Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsManticoreSmall, doOutput);

	    desc += "Your feel your wings growing larger by the second. They keep growing until they reach three times their original size. The transformation finally stops as your wings reach a span of twice your arms length. These will be really useful should you want to fly around in search of a meal. <b>You now have fully grown manticore wings.</b>";
	    player.wings.desc = "large manticore-like";
	    player.wings.type = Wings.MANTICORE_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.MANTICORE_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.MANTICORE_LARGE;
	  }
	);

	public const WingsManticoreSmall: Transformation = new SimpleTransformation("Manticore Small Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";
	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "You scream something akin to a roar from the tremendous amount of pain you're suddenly experiencing as something starts to push out from your back. Your claws start digging large marks into the ground as the things stretch out and burst through your skin. Large bones covered in a thin, yet sturdy layer of skin, forming a pair of small bat-like wings slowly push out before finally staying in place. They are too small right now to allow you to take flight but they sure look good on you. <b>You now have small manticore wings.</b>";
	    player.wings.desc = "small manticore-like";
	    player.wings.type = Wings.MANTICORE_SMALL;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.MANTICORE_SMALL));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.MANTICORE_SMALL;
	  }
	);

	public const WingsNightmare: Transformation = new SimpleTransformation("Nightmare Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, white wings.</b>";
	    player.wings.desc = "large black leathery";
	    player.wings.type = Wings.NIGHTMARE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.NIGHTMARE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.NIGHTMARE;
	  }
	);

	public const WingsFeatheredAlicorn: Transformation = new SimpleTransformation("Feathered Alicorn Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, white wings.</b>";
	    player.wings.desc = "large white feathered";
	    player.wings.type = Wings.FEATHERED_ALICORN;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_ALICORN));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.FEATHERED_ALICORN;
	  }
	);

	public const WingsThunderousAura: Transformation = new SimpleTransformation("Thunderous Aura (Wings)",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You've become so charged in electricity that your movements are sometimes accompanied by the sound of static. <b>It's going to be difficult to hide your presence with that thunderous aura of yours.</b>";
	    player.wings.desc = "thunderous aura";
	    player.wings.type = Wings.THUNDEROUS_AURA;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.THUNDEROUS_AURA));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.THUNDEROUS_AURA;
	  }
	);

	public const WingsMantisLarge: Transformation = new SimpleTransformation("Mantis Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsMantisSmall, doOutput);

	    desc += "Your wings tingle as they grow, filling out covering your back abdomen until they are large enough to lift you from the ground and allow you to fly! You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight. <b>You now have large Mantis wings!</b>";
	    player.wings.desc = "large mantis-like";
	    player.wings.type = Wings.MANTIS_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.MANTIS_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.MANTIS_LARGE;
	  }
	);

	public const WingsMantisSmall: Transformation = new SimpleTransformation("Mantis Small Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "You feel an itching between your shoulder-blades as something begins growing there. You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably. A sense of relief erupts from you as you feel something new grow out from your body.";
	    desc += "\nYou hastily remove the top portion of your [armor] and marvel as a pair of small Insectile wings sprout from your back. Tenderly flexing your new muscles, you find you can flap them quite fast. Unfortunately you can’t seem to flap your little wings fast enough to fly, but they would certainly slow a fall. A few quick modifications to your [armor] later and you are ready to continue your journey with <b>your new mantis wings</b>.";
	    player.wings.desc = "small mantis-like";
	    player.wings.type = Wings.MANTIS_SMALL;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.MANTIS_SMALL));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.MANTIS_SMALL;
	  }
	);

	public const WingsDraconicHuge: Transformation = new SimpleTransformation("Draconic Huge Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsDraconicLarge, doOutput);

	    desc += "A not-unpleasant tingling sensation again fills your wings, almost but not quite drowning out the odd, tickly feeling as they swell larger and stronger than before. You spread them wide - they stretch now more than twice further than your arms do - and beat them experimentally, the powerful thrusts sending gusts of wind, and lifting you off your feet effortlesly. <b>You now have fully-grown majestic dragon wings, capable of winging you through the air elegantly!</b>";
	    player.wings.desc = "large, majestic draconic";
	    player.wings.type = Wings.DRACONIC_HUGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DRACONIC_HUGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.DRACONIC_HUGE;
	  }
	);

	public const WingsDraconicLarge: Transformation = new SimpleTransformation("Draconic Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsDraconicSmall, doOutput);

	    desc += "A not-unpleasant tingling sensation fills your wings, almost but not quite drowning out the odd, tickly feeling as they swell larger and stronger. You spread them wide - they stretch further than your arms do - and beat them experimentally, the powerful thrusts sending gusts of wind, and almost lifting you off your feet. <b>You now have fully-grown dragon wings, capable of winging you through the air elegantly!</b>";
	    player.wings.desc = "large, draconic";
	    player.wings.type = Wings.DRACONIC_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DRACONIC_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.DRACONIC_LARGE;
	  }
	);

	public const WingsDraconicSmall: Transformation = new SimpleTransformation("Draconic Small Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.wings.type == Wings.NONE) desc += "You double over as waves of pain suddenly fill your shoulderblades; your back feels like it's swelling, flesh and muscles ballooning. A sudden sound of tearing brings with it relief and you straighten up. Upon your back now sit small, leathery wings, not unlike a bat's. <b>You now have small dragon wings. They're not big enough to fly with, but they look adorable.</b>";
	    else desc += "A sensation of numbness suddenly fills your wings. When it dies away, they feel... different. Looking back, you realize that they have been replaced by new, small wings, ones that you can only describe as draconic. <b>Your wings have changed into dragon wings.</b>";
	    player.wings.desc = "small, draconic";
	    player.wings.type = Wings.DRACONIC_SMALL;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DRACONIC_SMALL));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.DRACONIC_SMALL;
	  }
	);

	public const WingsFeatheredPhoenix: Transformation = new SimpleTransformation("Feathered Phoenix Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, crimson wings.</b>";

	    player.wings.desc = "large crimson feathered";
	    player.wings.type = Wings.FEATHERED_PHOENIX;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_PHOENIX));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.FEATHERED_PHOENIX;
	  }
	);

	public const WingsFeatheredLarge: Transformation = new SimpleTransformation("Feathered Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.wings.type > Wings.NONE) desc += "Sensation fades from your " + player.wings.desc + " wings slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.";
	    desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, [haircolor] wings.</b>";
	    player.wings.desc = "large, feathered";
	    player.wings.type = Wings.FEATHERED_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.FEATHERED_LARGE;
	  }
	);

	public const WingsBeeLarge: Transformation = new SimpleTransformation("Bee Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsBeeSmall, doOutput);

	    desc += "Your wings tingle as they grow, filling out until they are large enough to lift you from the ground and allow you to fly! <b>You now have large bee wings!</b> You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight.";
	    player.wings.desc = "large bee-like";
	    player.wings.type = Wings.BEE_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.BEE_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.BEE_LARGE;
	  }
	);

	public const WingsBeeSmall: Transformation = new SimpleTransformation("Bee Small Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel an itching between your shoulder-blades as something begins growing there. You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably. A sense of relief erupts from you as you feel something new grow out from your body. You hastily remove the top portion of your [armor] and marvel as a pair of small bee-like wings sprout from your back. Tenderly flexing your new muscles, you find you can flap them quite fast. Unfortunately you can't seem to flap your little wings fast enough to fly, but they would certainly slow a fall. A few quick modifications to your [armor] later and you are ready to continue your journey with <b>your new bee wings</b>.";
	    player.wings.desc = "small bee-like";
	    player.wings.type = Wings.BEE_SMALL;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.BEE_SMALL));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.BEE_SMALL;
	  }
	);

	// UNUSED
	// public const WingsDemonicQuadrupleLarge: Transformation = new SimpleTransformation("Demonic Large Quadruple Wings",
	//   // apply effect
	//   function (doOutput: Boolean): void {
	//     var desc: String = "";

	//     TransformationUtils.applyTFIfNotPresent(transformations.WingsDemonicLarge, doOutput);

	//     desc += "Your large demonic wings starts to tremble and then starts to split from the tip. You stretch over your shoulder to stroke them as they divide, turning into two pairs of full-sized demon-wings. <b>Your demonic wings have splited into two pairs!</b>";
	//     player.wings.desc = "two large pairs of bat-like";
	//     player.wings.type = Wings.BAT_LIKE_LARGE_2;

	//     if (doOutput) outputText(desc);
	//     Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DEMONIC_LARGE_X4));
	//   },
	//   // is present
	//   function (): Boolean {
	//     return player.wings.type === Wings.BAT_LIKE_LARGE_2;
	//   }
	// );

	public const WingsDemonicLarge: Transformation = new SimpleTransformation("Demonic Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsDemonicTiny, doOutput);

	    if (player.wings.type == Wings.DRACONIC_LARGE || player.wings.type == Wings.BEE_LARGE || player.wings.type == Wings.MANTIS_LARGE || player.wings.type == Wings.MANTICORE_LARGE) {
	      desc += "The muscles around your shoulders bunch up uncomfortably, changing to support your wings as you feel their weight increasing. You twist your head as far as you can for a look and realize they've changed into large <b>bat-like demon-wings!</b>";
	    } else {
	      desc += "Your small demonic wings stretch and grow, tingling with the pleasure of being attached to such a tainted body. You stretch over your shoulder to stroke them as they unfurl, turning into full-sized demon-wings. <b>Your demonic wings have grown!</b>";
	    }

	    player.wings.desc = "large, bat-like";
	    player.wings.type = Wings.BAT_LIKE_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DEMONIC_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.BAT_LIKE_LARGE;
	  }
	);

	public const WingsDemonicTiny: Transformation = new SimpleTransformation("Demonic Tiny Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "A knot of pain forms in your shoulders as they tense up. With a surprising force, a pair of small demonic wings sprout from your back, ripping a pair of holes in the back of your [armor]. <b>You now have tiny demonic wings</b>.";
	    player.wings.desc = "tiny, bat-like";
	    player.wings.type = Wings.BAT_LIKE_TINY;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DEMONIC_TINY));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.BAT_LIKE_TINY;
	  }
	);

	public const WingsVampire: Transformation = new SimpleTransformation("Vampire Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A terrible pain flares in the center of your back, a pain so intense that you black out briefly, coming back to your senses as you hit your head against the ground. You hear a horrifying ripping noise as your back stretches and tears to allow new bones to expand, black as tar and far lighter than most of the bones in your body. These new bones shift under your shoulder blade skin as you fall on all groaning in pain and clawing at the ground. In a flash of pain they violently break out of your skin sending blood everywhere as you make a chilling scream your wounds slowly closing on their own. Still panting from the pain, you take a look at your new appendage. It's a pair of large vampire wings of impressive size. Feeling chilly you fold them back on your body and you ought to admit they indeed look like a large cape. <b>You will be able to enjoy nightly flight using your brand new vampire wings.</b>";
	    player.wings.desc = "large bat";
	    player.wings.type = Wings.VAMPIRE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.VAMPIRE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.VAMPIRE;
	  }
	);

	public const WingsFeatheredAvian: Transformation = new SimpleTransformation("Feathered Avian Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.wings.type == Wings.DRACONIC_SMALL || player.wings.type == Wings.DRACONIC_LARGE || player.wings.type == Wings.DRACONIC_HUGE || player.wings.type == Wings.BAT_LIKE_TINY || player.wings.type == Wings.BAT_LIKE_LARGE || player.wings.type == Wings.BAT_LIKE_LARGE_2 || Arms.canFly(player.arms.type) || player.wings.type == Wings.VAMPIRE) {
	      desc += "Your wings feel suddenly heavier, and you’re forced to sit down to keep balance. Putting attention to the things happening at your back, you realize that the scales covering them are falling!";
	      desc += "A bit alarmed, you’re surprised when, not much later, feathers started sprouting everywhere on them. t all the same, as long ones grow at the base, while shorter ones appear on the upper part of them and near your shoulders. When all the growth is finished, your wings are left with a much more bird-like appearance.";
	      desc += "<b>In the end, your pair of now avian wings will carry you to skies with ease.</b>";
	    } else if (player.wings.type > Wings.NONE) {
	      desc += "Your wings feel suddenly heavier, and you’re forced to sit down to keep balance. Putting attention to the things happening at your back, you realize that the delicate tissue of them is becoming skin and flesh, with bones sprouting inside and placing themselves to support the added weight.";
	      desc += "Once the muscles and bones are correctly formed, feathers start sprouting everywhere on them. Not all the same, as long ones grow at the base, while shorter ones appear on the upper part of them and near your shoulders. When all the growth is finished, your wings are left with a much more bird-like appearance.";
	      desc += "<b>In the end, your pair of now avian wings will carry you to skies with ease.</b>";
	    } else {
	      desc += "A sudden ache overcomes your back, when you’re at the middle of your daily routine. Knowing from before how hazardous is the food found on the wilds of Mareth, you curse the strange seed that you’ve just eat for this painful state.";
	      desc += "Before you can find something to soothe the pain, a piercing sensation of something tearing its way of of your flesh and skin makes you lose the balance and fall. Instinctively, you take off the upper part of your [armor] so anything that it’s growing from back there makes they way out without any trouble.";
	      desc += "When everything finishes, you take a look at your backside, noticing two shapes sprouting from your upper back. They grow and grow, and when you recognize them as wings, they’ve already grown to carry with your body ease through the skies. Once the growth stops, you extend them and flex your newly gained bones and muscles. <b>Seems like you’ve gained a pair of avian wings!</b>";
	    }

	    player.wings.desc = "large, feathered";
	    player.wings.type = Wings.FEATHERED_AVIAN;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.FEATHERED_AVIAN;
	  }
	);

	public const WingsEthereal: Transformation = new SimpleTransformation("Ethereal Wings Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your body feels lighter than usual, almost as if you’re floating on air. Unintentionally you lean forward, finding yourself floating a few feet off the ground. Confused as to what is happening, you try to move, floating a few paces in the direction you want to go. That’s when you notice three pairs of wispy otherworldly tendrils growing out of your back. They glow faintly and almost appear as though they’re moving with the wind. They don’t even hold any weight. <b>You can get used to floating like this with your ethereal wings.</b>";

	    player.wings.desc = "ethereal tendrils";
	    player.wings.type = Wings.ETHEREAL;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.ETHEREAL;
	  }
	);

	public const WingsLevitation: Transformation = new SimpleTransformation("Levitation Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel so tired you could fall on your knees but to your surprise you don't. Instead of actually hitting the ground you simply float in the air. <b>You are now naturally levitating.</b>";

	    player.wings.desc = "levitation";
	    player.wings.type = Wings.LEVITATION;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.LEVITATION));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.LEVITATION;
	  }
	);

	public const WingsWindyAura: Transformation = new SimpleTransformation("Windy Aura Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Winds begin to amass around you as if the prelude to a gathering storm. At first you think you are about to be attacked before you realise it’s all your doing. Merely by thinking about it the wind suddenly blows into a raging tornado carrying you up before you seize control and give it just enough strength to uplift you into its currents. It would seem you have gained the infamous wind control power of the kamaitachi achieving mastery over it. Well this is going to be fun to play with. <b>You now have the ability to control winds as the Kamaitachi do using your windy aura!</b>";

	    player.wings.desc = "windy aura";
	    player.wings.type = Wings.WINDY_AURA;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.WINDY_AURA;
	  }
	);

	public const WingsGiantDragonfly: Transformation = new SimpleTransformation("Giant Dragonfly Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You scream and fall to your knees as incredible pain snags at your shoulders, as if needle like hooks were being sunk into your flesh just below your shoulder blades. After about five seconds of white hot, keening agony it is with almost sexual relief that something splits out of your upper back. You clench the dirt as you slide what feel like giant leaves of paper into the open air. Eventually the sensation passes and you groggily get to your feet. You can barely believe what you can see by craning your neck behind you - <b>you've grown a set of four giant dragonfly wings</b>, thinner, longer and more pointed than the ones you've seen upon the forest bee girls, but no less diaphanous and beautiful. You cautiously flex the new muscle groups in your shoulder blades and gasp as your new wings whirr and lift you several inches off the ground. What fun this is going to be!";

	    player.wings.desc = "giant dragonfly";
	    player.wings.type = Wings.GIANT_DRAGONFLY;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.GIANT_DRAGONFLY;
	  }
	);

	public const WingsSeaDragon: Transformation = new SimpleTransformation("Sea Dragon Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You keel in pain as you feel something penetrating your back. No, nothing is stabbing your back. More so, something is about to burst from within you. The trauma subsides as large bones emerge. A thin yet sturdy layer of skin covers your wings are covered as they fall into place behind you.\n\nAs you examine the fleshy appendage, you realize it's webbed. It seems to resemble more of a giant aquatic flipper than wings. The insides are not only colorful but also display several minute light specks. Not unlike those of a deep-sea beast. <b>You can now fly and swim at great speed with your brand new sea dragon wings!</b>";

	    player.wings.desc = "large majestic aquatic";
	    player.wings.type = Wings.SEA_DRAGON;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.SEA_DRAGON;
	  }
	);

	public const WingsDevilfeather: Transformation = new SimpleTransformation("Devilfeather Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if ((player.wings.type == Wings.BAT_LIKE_LARGE) && player.cor >= 75) {
	      desc += "Your wing shrivels before suddenly changing and covering themselves with black feathers. They still look demonic in a sense, albeit they are feathered now. <b>You now have black, feathered wings!</b>";
	    } else if (player.wings.type == Wings.BEE_SMALL || player.wings.type == Wings.BEE_LARGE) {
	      desc += "The muscles around your shoulders bunch up uncomfortably, changing to support your wings as you feel their weight increasing. You twist your head as far as you can for a look and realize they've changed into <b>black, feathered wings!</b>";
	    } else if (player.wings.type != Wings.NONE) {
	      desc += "A sensation of numbness suddenly fills your wings. When it dies away, they feel... different. Looking back, you realize that they have been replaced by <b>black, feathered wings!</b>";
	    } else {
	      desc += "A knot of pain forms in your shoulders as they tense up. With a surprising force, a pair of black feathered wings sprout from your back, ripping a pair of holes in the back of your [armor]. <b>You now have black, feathered wings!</b>";
	    }

	    player.wings.desc = "black, feathered";
	    player.wings.type = Wings.DEVILFEATHER;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.DEVILFEATHER;
	  }
	);

	public const WingsFeyDragon: Transformation = new SimpleTransformation("Fey Dragon Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";
		if ((player.wings.type == Wings.NONE)) {
			desc += "You keel in pain as you feel something penetrating your back. No, nothing is stabbing your back. More so, something is about to burst from within you. The trauma subsides as large bones emerge. A thin yet sturdy layer of skin covers your wings are covered as they fall into place behind you.\n\nAs you examine the fleshy appendage, you realize it's webbed. It seems to resemble more of a giant aquatic flipper than wings. The insides are not only colorful but also display several minute light specks. Not unlike those of a deep-sea beast. <b>You can now fly and swim at great speed with your brand new sea dragon wings!</b>";
		}
		if ((player.wings.type != Wings.NONE)) {
			desc += "You ain't even noticing as something messed up happen in your wings. They shrivel and change taking on a delicate almost fairy like appearance and you flap them in awe as they not only feel strong but also agile. You now have a set of <b>fey dragon wings.</b>";
		}
	    player.wings.desc = "large majestic fey draconic";
	    player.wings.type = Wings.FEY_DRAGON;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.FEY_DRAGON;
	  }
	);

	public const WingsPlant: Transformation = new SimpleTransformation("Plant Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "Pressure is building in multiple spots on your upper back. It feels more like several over-eager erections trapped in incredibly tight undies. You can’t help but groan with relief when finally the pressure peaks and many thick protrusions burst impatiently out of your [skin.type]. The hot, thick, vine-like growths thrust their way into being, feet of oily green tentacles, alarmingly energetic and prehensile, thrashing around your [hips]. After a moment of concentration you cause one of these growths to rear around into your hand to take a closer look at it. It feels unmistakably dick-like - bulging, tender flesh under the fibrous skin, with quite a bit of flexible, able to bend all along its length and dart its wet, distended head in any direction you wish. <b>You now have cockvine wings.</b>";

	    player.wings.desc = "cockvine";
	    player.wings.type = Wings.PLANT;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.PLANT;
	  }
	);
  /*
*/

/*
*    ██████  ██████  ███████  █████  ███████ ████████ ███████
*    ██   ██ ██   ██ ██      ██   ██ ██         ██    ██
*    ██████  ██████  █████   ███████ ███████    ██    ███████
*    ██   ██ ██   ██ ██      ██   ██      ██    ██         ██
*    ██████  ██   ██ ███████ ██   ██ ███████    ██    ███████
*/

/*
	*/
	public const BreastsGrowUpToDD:Transformation = new SimpleTransformation("Grow breasts up to DD",
		// apply effect
		function (doOutput:Boolean):void {
			var row:int = player.smallestTitRow();
			var desc: String = "";

			desc += "Your chest aches and tingles, and your hands reach up to scratch at it unthinkingly. Just as you start to scratch at your " + breastDescript(row) + ", your chest pushes out in slight but sudden growth.";

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

			desc += "A chill runs over your [allbreasts] and vanishes. You stick a hand under your [armor] and discover that your extra nipples are missing!  You're down to just one per ";
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

			desc += "A tickling sensation plucks at your nipples and you cringe, trying not to giggle. Looking down you are in time to see the last spot of flesh tone disappear from your [nipples]. They have turned an onyx black!";

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
	/*
*/

/*
*     █████  ███████ ███████
*    ██   ██ ██      ██
*    ███████ ███████ ███████
*    ██   ██      ██      ██
*    ██   ██ ███████ ███████
*/

/*
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
	/*
*/

/*
*    ███████ ███████ ██   ██ ██    ██  █████  ██
*    ██      ██       ██ ██  ██    ██ ██   ██ ██
*    ███████ █████     ███   ██    ██ ███████ ██
*         ██ ██       ██ ██  ██    ██ ██   ██ ██
*    ███████ ███████ ██   ██  ██████  ██   ██ ███████
*/


/*
*    ███████ ██████  ███████  ██████ ██  █████  ██          ████████ ███████ ███████
*    ██      ██   ██ ██      ██      ██ ██   ██ ██             ██    ██      ██
*    ███████ ██████  █████   ██      ██ ███████ ██             ██    █████   ███████
*         ██ ██      ██      ██      ██ ██   ██ ██             ██    ██           ██
*    ███████ ██      ███████  ██████ ██ ██   ██ ███████        ██    ██      ███████
*/


/*
*    ████████ ██ ███████ ██████  ███████ ██████      ████████ ███████ ███████
*       ██    ██ ██      ██   ██ ██      ██   ██     	██    ██      ██
*       ██    ██ █████   ██████  █████   ██   ██        ██    █████   ███████
*       ██    ██ ██      ██   ██ ██      ██   ██        ██    ██           ██
*       ██    ██ ███████ ██   ██ ███████ ██████         ██    ██      ███████
*/

/*
		*/
		public const TieredSpiderFace:GradualTransformation = new GradualTransformation("Spider face (gradual)", [
			FaceHuman,
			FaceSpiderFangs
		]);
		/*
*/

/*
*    ██      ██ ███████ ████████ ███████
*    ██      ██ ██         ██    ██
*    ██      ██ ███████    ██    ███████
*    ██      ██      ██    ██         ██
*    ███████ ██ ███████    ██    ███████
*/

/*
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
			SkinChitin(Skin.COVERAGE_LOW, {color: "midnight purple"}),
			TieredSpiderFace,
			HairChangeColor(["midnight purple"]),
			new OrderedTransformation("EyesRedThenSpider", [
			EyesChangeColor(["red"]),
			EyesSpiderAndMutagenInt
			]),
			BreastRowsRemoveToOne,
			NipplesPerBreastOne,
			NipplesBlack,
			ArmsAtlach,
			LowerBodyAtlach,
			TailSpinneretAtlach,
			GillsNone,
			RearBodyAtlachNacha
		];
		/*
*/
}
}