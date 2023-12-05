package classes.Transformations.Transformations {
import classes.Transformations.*;
import classes.BodyParts.Hair;
import classes.GeneticMemories.HairMem;
import classes.GlobalFlags.kFLAGS;
import classes.Items.MutationsHelper;
import classes.Races.*;
import classes.Scenes.Metamorph;

/**
 * Base class for transformation events.
 */
public class HairTransformations extends MutationsHelper {

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
						desc += "You feel something strange going on on your head. Before you can wonder about it, the tentacles you have for hair begin to recede back into your scalp, eventually leaving you with a bald head. Your head is not left bald for long, though. Within moments, a full head of hair sprouts from the skin of your scalp. <b>Your hair is normal again!</b>";
						break;
					case Hair.GOO:
						desc += "Your gooey hair begins to fall out in globs, eventually leaving you with a bald head. Your head is not left bald for long, though. Within moments, a full head of hair sprouts from the skin of your scalp. <b>Your hair is normal again!</b>";
						break;
					case Hair.GORGON:
						player.hairLength = 1;
						desc += "As you finish the root, the scaled critters on your head shake wildly in displeasure. Then, a sudden heat envelopes your scalp. The transformative effects of your spicy meal make themselves notorious, as the writhing mess of snakes starts hissing uncontrollably. Many of them go rigid, any kind of life that they could have had taken away by the root effects. All of the snakes that made up your hair are soon limp and lifeless.";
						desc += "Their dead bodies are separated from your head by a scorching sensation, falling to the ground and turning to dust in a matter of seconds. Examining your head in the stream, you realize that you have a normal, healthy scalp, though devoid of any kind of hair.";
						desc += "The effects don’t end here, though, as the familiar sensation of hair returns to your head a moment later. Looking at yourself in the stream again, you confirm that <b>your once bald head now has normal, short [haircolor] hair</b>.";
						break;
					case Hair.WINDSWEPT:
						desc += "A sensation of weight assaults your scalp. You reach up and grab a handful of hair, confused. Your perplexity only heightens when you actually feel the follicles becoming heavier in your grasp. Plucking a strand, you hold it up before you, surprised to see... it's no longer transparent! You have normal hair!";
						break;
					case Hair.LEAF:
						if (player.hairLength >= 6) {
							desc += "A lock of your leaf-hair droops over your eye. Before you can blow the offending down away, you realize the leaf is changing until all that remains is a normal strand of hair. <b>Your hair is no longer leaf-like!</b>";
						} else {
							desc += "You run your fingers through your leaf-hair while you await the effects of the item you just ingested. While your hand is up there, it detects a change in the texture of your leaves. They're completely disappearing, merging down into strands of regular hair. <b>Your hair is no longer leaf-like!</b>";
						}
						break;
					case Hair.FLUFFY:
						desc += "You feel something strange going on on your head. You reach your hands up to feel your fluffy hair, only to find out that it has vanished and been replaced with normal hair. <b>Your hair is normal again!</b>";
						break;
					case Hair.GRASS:
						desc += "You feel something strange going on on your head. You reach your hands up to feel your grass-hair, only to find out that the long, soft and leafy blades have vanished and been replaced with normal hair. <b>Your hair is normal again!</b>";
						break;
					case Hair.SILKEN:
						desc += "You feel something strange going on on your head. You reach your hands up to feel your silken-hair, only to find out that it has changed back to normal hair. <b>Your hair is normal again!</b>";
						break;
					case Hair.BURNING:
						desc += "Your head begins to cool down until the flames entirely disappear, leaving you with ordinary hair. <b>Your hair is normal again!</b>";
						break;
					default:
						desc += "You feel a strange sensation on your head. Putting a hand to your hair, it feels completely normal. <b>Your hair is normal again!</b>";
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
						desc += " Additionally, its length seems to grow.";
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
				var desc: String = "A strange zapping sound is the only warning you receive before a weak shock runs through the back of your head. Irritated and confused, you bring a hand to the spot and rub it, only for a sudden electrical noise to make itself known at the contact.\n\nKnowing for a fact that your hair shouldn't sound like that, or like anything at all for that matter, you bring both your hands to explore it and make note of several glowing strands shaped like stylized lightning bolts. There's even a single strand that floats just off the side of your face, refusing to stay down no matter how many times you try to reposition it. With a sigh, you give up on it, deciding that it's not really important to defeat your own hair. <b>You now have electrical raiju hair!</b>";

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

				desc += "The feeling of your hair against your skin suddenly changes and it is now cold against you. Wisps of snow occasionally fall down past your face, straining your eyes to look up, and you can see them slowly drifting down from your long snowy white hair.";

				if (player.hairLength < 25) player.hairLength = 25;

				if (doOutput) outputText(desc);
				player.hairType = Hair.SNOWY;
				Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.SNOWY));
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
				Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.LEAF));
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
				Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.GRASS));
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
				if (!InCollection(player.hairColor, SlimeRace.SlimeSkinColors, MagmaSlimeRace.MagmaSlimeSkinColors, DarkSlimeRace.DarkSlimeSkinColors)) {
					player.hairColor = player.skinColor;
					desc += " Stranger still, the hue of your semi-liquid hair changes to " + player.hairColor + ".";
				}

				if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) {
					desc += "  <b>(Your hair has stopped growing.)</b>";
					flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 1;
				}

				player.hairLength = 5;

				if (doOutput) outputText(desc);
				player.hairType = Hair.GOO;
				Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.GOO));
			},
			// is present
			function (): Boolean {
				return player.hairType === Hair.GOO;
			},
			// is possible
			function (): Boolean {
				return player.hairType != Hair.GOO && player.isGooSkin();
			}
	);

	public const HairGhost: Transformation = new SimpleTransformation("Ghost Hair",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "A sensation of weightlessness assaults your scalp. You reach up and grab a handful of hair, confused. Your perplexity only heightens when you actually feel the follicles becoming lighter in your grasp, before you can hardly tell you're holding anything. Plucking a strand, you hold it up before you, surprised to see... it's completely transparent! You have transparent hair!";

				if (doOutput) outputText(desc);
				player.hairType = Hair.GHOST;
                Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.GHOST));
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
                Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.RATATOSKR));
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
                Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.WIND));
			},
			// is present
			function (): Boolean {
				return player.hairType === Hair.WINDSWEPT;
			}
	);

	public const HairWild: Transformation = new SimpleTransformation("Wild Hair",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "Your hair stands in all directions as though you have just been through a windstorm. <b>You now have wild hair!</b>";

				player.hairLength = 5;

				if (doOutput) outputText(desc);
				player.hairType = Hair.NORMAL;
				player.hairStyle = Hair.WILD;
			},
			// is present
			function (): Boolean {
				return player.hairStyle === Hair.WILD;
			}
	);

	public const HairAnemone: Transformation = new SimpleTransformation("Anemone Hair",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "Your balance slides way off, and you plop down on the ground as mass concentrates on your head. Reaching up, you give a little shriek as you feel a disturbingly thick, squirming thing where your hair should be. Pulling it down in front of your eyes, you notice it's still attached to your head; what's more, it's the same color as your hair used to be. <b>You now have squirming tentacles in place of hair!</b>  As you gaze at it, a gentle heat starts to suffuse your hand. The tentacles must be developing their characteristic stingers!  You quickly let go; you'll have to take care to keep them from rubbing on your skin at all hours. On the other hand, they're quite short and you find you can now flex and extend them as you would any other muscle, so that shouldn't be too hard. You settle on a daring, windswept look for now.";

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
                Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.FLUFFY));
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
                Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.CRAZY));
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

	public const HairCow: Transformation = new SimpleTransformation("Cow Hair",
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

	public const HairDripping: Transformation = new SimpleTransformation("Driping Hair",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (doOutput) outputText(desc);
				player.hairType = Hair.DRIPPING;
			},
			// is present
			function (): Boolean {
				return player.hairType === Hair.DRIPPING;
			}
	);

	public const HairPeafowlFeather: Transformation = new SimpleTransformation("Peafowl Feather Hair",
			// apply effect
			function (doOutput: Boolean): void {
				if (doOutput) {
					var desc: String = "";

					desc += "A tingling starts in your scalp, like an itch growing with fervent intensity until you're scratching it madly. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. <b>You have feathers for hair, just like a peafowl!</b>";

					outputText(desc);
				}
				player.hairType = Hair.PEAFOWL;
				Metamorph.unlockMetamorph(HairMem.getMemory(HairMem.PEAFOWL));
			},
			// is present
			function (): Boolean {
				return player.hairType === Hair.PEAFOWL;
			}
	);

	public function HairChangeColor(colors: /*String*/ Array): Transformation {
		return new SimpleTransformation("Hair Color: " + colors.join("|"),
				// apply effect
				function (doOutput: Boolean): void {
					var color: String = randomChoice(colors);
					player.hairColor = color;
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
  */}
}
