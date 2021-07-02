package classes.Transformations {
import classes.BaseContent;
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
import classes.Items.MutationsHelper;
import classes.StatusEffects;
import classes.internals.EnumValue;
import classes.Scenes.Metamorph;
import classes.GlobalFlags.kFLAGS;
import classes.Transformations.TransformationUtils;

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

				setHairType(Hair.NORMAL);
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
				setHairType(Hair.FEATHER);
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

				setHairType(Hair.GORGON);
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
				setHairType(Hair.SILKEN);
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
				setHairType(Hair.STORM);
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

				TransformationUtils.applyIfNotPresent(transformations.HairHuman, doOutput);

				desc += "Your head is suddenly attacked by warmth, as though it were right next to a campfire. Before you can wonder what's going on, your hair is set ablaze in an spectacular explosion. You very nearly have a panic attack before realizing you're not being harmed by the flames, which instead fade until they only cover your hair's tips.\n\nA few tests later, and you confirm that thankfully the flames don't seem to actually burn anything unless you will them to. <b>You now have burning hellcat hair!</b>";

				if (doOutput) outputText(desc);
				setHairType(Hair.BURNING);
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
				setHairType(Hair.SNOWY);
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
				setHairType(Hair.LEAF);
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
				setHairType(Hair.GRASS);
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
				setHairType(Hair.GOO);
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
				setHairType(Hair.GHOST);
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
				setHairType(Hair.RATATOSKR);
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
				setHairType(Hair.WINDSWEPT);
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
				setHairType(Hair.ANEMONE);
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
				setHairType(Hair.FLUFFY);
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
				setHairType(Hair.CRAZY);
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
				setHairType(Hair.PRISMATIC);
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
				setHairType(Hair.QUILL);
			},
			// is present
			function ():Boolean {
				return player.hairType === Hair.QUILL;
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
				setFaceType(Face.HUMAN);
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
				setFaceType(Face.HORSE);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.DOG);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.DOG;
			}
	);

	public const FaceCowMinotaur:Transformation = new SimpleTransformation("Cow Minotaur Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "Your visage twists painfully, warping and crackling as your bones are molded into a new shape. Once it finishes, you reach up to touch it, and you discover that <b>your face is like that of a cow!</b>";

				if (doOutput) outputText(desc);
				setFaceType(Face.COW_MINOTAUR);
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

				TransformationUtils.applyIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "Your [face] explodes with agony, reshaping into a more human-like visage. You firmly grasp your mouth, an intense pain racking your oral cavity. Your gums shift around and the bones in your jaw reset. You blink a few times wondering what just happened. You move over to a puddle to catch sight of your reflection, and you are thoroughly surprised by what you see. A set of retractable shark fangs have grown in front of your normal teeth, and your face has elongated slightly to accommodate them! They even scare you a little.\n(Gain: 'Bite' special attack)";

				if (doOutput) outputText(desc);
				setFaceType(Face.SHARK_TEETH);
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
				setFaceType(Face.SNAKE_FANGS);
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
				setFaceType(Face.CAT);
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

				TransformationUtils.applyIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You purr at the change it gives you a cute look. <b>Your mouth is now filled with Cat-like canines.</b>";

				if (doOutput) outputText(desc);
				setFaceType(Face.CAT_CANINES);
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
				setFaceType(Face.LIZARD);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.BUNNY);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.KANGAROO);
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
				setFaceType(Face.SPIDER_FANGS);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.FOX);
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
				setFaceType(Face.DRAGON);
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
				setFaceType(Face.DRAGON_FANGS);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.RACCOON_MASK);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.RACCOON);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.BUCKTEETH);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.MOUSE);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.FERRET_MASK);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.FERRET);
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
				setFaceType(Face.PIG);
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
				setFaceType(Face.BOAR);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.RHINO);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.ECHIDNA);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.DEER);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.WOLF);
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

				TransformationUtils.applyIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "You feel your canines changing, elongating into sharp, dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You feel the need to roar like a lion, to show the world how ferocious you are. <b>Your mouth is now filled with dagger-like canines!</b>";

				if (doOutput) outputText(desc);
				setFaceType(Face.MANTICORE);
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
				setFaceType(Face.SALAMANDER_FANGS);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.YETI_FANGS);
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
				setFaceType(Face.ORCA);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.PLANT_DRAGON);
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
				setFaceType(Face.DEVIL_FANGS);
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

				TransformationUtils.applyIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "You feel your canines changing, growing bigger and slightly sharper. Hey, you could pretend to be some kind of demon with that kind of mouth. <b>You now have oni canines.</b>";

				if (doOutput) outputText(desc);
				setFaceType(Face.ONI_TEETH);
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

				TransformationUtils.applyIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "You feel your two canines grow bigger and slightly sharper, not unlike those of a weasel or in your case a raiju. <b>You now have raiju canines.</b>";

				if (doOutput) outputText(desc);
				setFaceType(Face.WEASEL);
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
				setFaceType(Face.VAMPIRE);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.BUCKTOOTH);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.JABBERWOCKY);
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
				setFaceType(Face.RED_PANDA);
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

				TransformationUtils.applyIfNotPresent(transformations.FaceHuman, doOutput);

				if (choice == 0) desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different. You find a puddle to view your reflection and discover <b>your face is now a cross between human and feline features.</b>";
				else if (choice == 1) desc += "Mind-numbing pain courses through you as you feel your facial bones rearranging. You clutch at your face in agony as your skin crawls and shifts, your visage reshaping to replace your facial characteristics with those of a feline. <b>You now have an anthropomorphic cat-face.</b>";
				else desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else. <b>Your facial features rearrange to take on many feline aspects.</b>";

				desc += "You suddenly feel like smiling. Why actually look so serious? Everything is easier if you take it with a smile and a laughter. Perhaps it's just you taking on that mentality or it's that weird wonderfruit you took but now you feel you could smile forever showing that wide grin of yours. <b>You now have a cheshire smile.</b>";

				if (doOutput) outputText(desc);
				setFaceType(Face.CHESHIRE);
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

				TransformationUtils.applyIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You purr at the change it gives you a cute look. <b>Your mouth is now filled with Cat-like canines.</b>";

				desc += "You suddenly feel like smiling. Why actually look so serious? Everything is easier if you take it with a smile and a laughter. Perhaps it's just you taking on that mentality or it's that weird wonderfruit you took but now you feel you could smile forever showing that wide grin of yours. <b>You now have a cheshire smile.</b>";

				if (doOutput) outputText(desc);
				setFaceType(Face.CHESHIRE_SMILE);
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
				setFaceType(Face.AVIAN);
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
				setFaceType(Face.WOLF_FANGS);
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

				TransformationUtils.applyIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "You feel your two lower canines grow bigger and slightly sharper, similar to those of a boar, or in your case, an orc. <b>You now have orc canines.</b>";

				if (doOutput) outputText(desc);
				setFaceType(Face.ORC_FANGS);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.ANIMAL_TOOTHS);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.BEAR);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.PANDA);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.FIRE_SNAIL);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.GHOST);
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
				setFaceType(Face.JIANGSHI);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.YUKI_ONNA);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.KUDERE);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.USHI_ONI_ONNA);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.USHI_ONI_ONNA;
			}
	);

	public const FaceFairy:Transformation = new SimpleTransformation("Fairy Face",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (doOutput) outputText(desc);
				setFaceType(Face.FAIRY);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.CRAZY);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.SMUG);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.SQUIRREL);
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

				if (doOutput) outputText(desc);
				setFaceType(Face.ELF);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.ELF;
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
	public const EarsElfin:Transformation = new SimpleTransformation("Elfin ears",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (player.ears.type != Ears.HUMAN) {
					desc += "Your ears twitch once, twice, before starting to shake and tremble madly.  They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, pointed elfin ears.</b>";
				} else {
					desc += "A weird tingling runs through your scalp as your [hair] shifts slightly.  You reach up to touch and bump <b>your new pointed elfin ears</b>.  You bet they look cute!";
					}


				if (doOutput) outputText(desc);
				setEarType(Ears.ELFIN);
			},
			// is present
			function ():Boolean {
				return player.ears.type === Ears.ELFIN
			}
	)

	/***
	 *    ███████ ██    ██ ███████ ███████
	 *    ██       ██  ██  ██      ██
	 *    █████     ████   █████   ███████
	 *    ██         ██    ██           ██
	 *    ███████    ██    ███████ ███████
	 */

	public function makeEyeColorTf(colors:/*String*/Array):Transformation {
		return new SimpleTransformation("Eye color: " + colors.join("|"),
				// apply effect
				function (doOutput:Boolean):void {
					var color:String = randomChoice(colors);
					player.eyes.colour = color;
					var desc: String = "";

					desc += "You feel something fundamental change in your sight when you go check yourself in a puddle you notice that not only do they look human but your irises are now <b>[eyecolor].</b>";


					if (doOutput) outputText(desc);
				},
				// is present
				function ():Boolean {
					return InCollection(player.eyes.colour, colors);
				}
		)
	}

	public const EyesSpider:Transformation        = new SimpleTransformation("Spider eyes",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You suddenly get the strangest case of double vision.  Stumbling and blinking around, you clutch at your face, but you draw your hands back when you poke yourself in the eye.  Wait, those fingers were on your forehead!  You tentatively run your fingertips across your forehead, not quite believing what you felt.  <b>There's a pair of eyes on your forehead, positioned just above your normal ones!</b>  This will take some getting used to!";

				if (doOutput) outputText(desc);
				setEyeType(Eyes.FOUR_SPIDER_EYES);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.FOUR_SPIDER_EYES
			}
	);
	public const EyesSpiderAndMutagenInt:Transformation = EyesSpider.copyWithExtraEffect(
			"Spider eyes + Mutagen Bonus INT",
			// extra effect
			function (doOutput:Boolean):void {
				MutagenBonus("int", 5);
			}
	);

	public const EyesHumanToSpider:Transformation = EyesSpider.copyWithExtraCondition(
			"Human eyes to spider eyes",
			// extra condition
			function ():Boolean {
				return player.eyes.type === Eyes.HUMAN
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

	/**
	 * Also paint coat black
	 */
	public const ArmsSpider:Transformation = new SimpleTransformation("Spider arms",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (player.arms.type == Arms.HARPY || player.arms.type == Arms.HUMAN) {
					if (player.arms.type == Arms.HARPY) desc += "The feathers covering your arms fall away, leaving them to return to a far more human appearance. You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a shiny black carapace</b>. You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
				} else {
					if (player.arms.type == Arms.BEE) desc += "The fizz covering your upper arms starting to fall down leaving only shiny black chitin clad arms.";
					else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRAGON) desc += "The scales covering your upper arms starting to fall down leaving only shiny black chitin clad arms.";
					else if (player.arms.type == Arms.MANTIS) desc += "The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the [skinfurscales] into a shiny black carapace</b>.";
					else desc += "You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a shiny black carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
				}

				if (doOutput) outputText(desc);
				setArmType(Arms.SPIDER);
				player.coatColor = "black";
			},
			// is present
			function ():Boolean {
				return player.arms.type === Arms.SPIDER;
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
					else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRAGON) desc += "The scales covering your upper arms starting to fall down leaving only midnight purple chitin clad arms.";
					else if (player.arms.type == Arms.MANTIS) desc += "The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the [skinfurscales] into a midnight purple carapace</b>.";
					else desc += "You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a midnight purple carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
				}
				if (doOutput) outputText(desc);
				setArmType(Arms.SPIDER);
				player.coatColor = "midnight purple";
				player.coatColor2 = "midnight purple";
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
	 *    ████████ ██ ███████ ██████  ███████ ██████      ████████ ███████ 				 ██    ██ ██      █
	 *       ██    ██ ██      ██   ██ ██      ██   ██        	  ██               ██            ██
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
			makeEyeColorTf(["red"]),
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
