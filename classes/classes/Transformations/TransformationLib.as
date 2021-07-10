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
				player.faceType = Face.USHI_ONI_ONNA;
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

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["bloody red"]), doOutput);

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
