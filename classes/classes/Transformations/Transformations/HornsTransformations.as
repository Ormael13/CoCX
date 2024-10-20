package classes.Transformations.Transformations {
import classes.Transformations.*;
import classes.BodyParts.Horns;
import classes.GeneticMemories.HornsMem;
import classes.Items.MutationsHelper;
import classes.Scenes.Metamorph;

/**
 * Base class for transformation events.
 */
public class HornsTransformations extends MutationsHelper {

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

				if (player.horns.type == Horns.NONE) desc += "With painful pressure, the skin on your forehead splits around two tiny nub-like horn, a little bit similar to that you would see on the cattle back in your homeland. ";
				else if (player.horns.type == Horns.UNICORN) desc += "A sudden wave of pleasure strike you, making you moan as your horn begins to split in two.";
				else if (player.horns.type == Horns.BICORN) desc += "A splitting pain on your forehead heralds your bicorn horns gaining a few inches.";
				else desc += "Your horns vibrate and shift as if made of clay, reforming into a bicorn-like shape.";

				if (player.horns.type != Horns.BICORN &&player.horns.type != Horns.UNICORN && player.horns.type != Horns.KIRIN)
					player.horns.count = 2;
				if (player.horns.type == Horns.BICORN)
					player.horns.count += rand(4);
				player.horns.type = Horns.BICORN;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.BICORN));
			},
			// is present
			function (): Boolean {
				return player.horns.type === Horns.BICORN && player.horns.count >= 20;
			}
	);

	public const HornsUnicorn: Transformation = new SimpleTransformation("Unicorn Horn",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.horns.type == Horns.NONE) desc += "With painful pressure, the skin on your forehead splits around a tiny nub-like horn, a little bit similar to that you would see on the cattle back in your homeland.";
				else if (player.horns.type == Horns.BICORN) desc += "One of your horns crumble to dust, leaving you with a single pure unicorn horn.";
				else if (player.horns.type == Horns.UNICORN) desc += "A splitting pain on your forehead heralds your unicorn horn gaining a few inches.";
				else desc += "Your horns vibrate and shift as if made of clay, reforming into horn with a unicorn-like shape.";
				if (player.horns.type != Horns.BICORN && player.horns.type != Horns.UNICORN && player.horns.type != Horns.KIRIN)
					player.horns.count = 1;
				if (player.horns.type == Horns.UNICORN)
					player.horns.count += rand(4);
				player.horns.type = Horns.UNICORN;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.UNICORN));
			},
			// is present
			function (): Boolean {
				return player.horns.type === Horns.UNICORN && player.horns.count >= 20;
			}
	);

	public const HornsKirin: Transformation = new SimpleTransformation("Kirin Horn",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.horns.type == Horns.NONE) desc += "With painful pressure, the skin on your forehead splits around a tiny nub-like horn, a little bit similar to that you would see on the cattle back in your homeland.";
				else if (player.horns.type == Horns.KIRIN) desc += "A splitting pain on your forehead heralds your horn gaining a few inches.";
				else desc += "Your horns vibrate and shift as if made of clay, reforming into horn with a kirin-like shape.";
				if (player.horns.type != Horns.BICORN &&player.horns.type != Horns.UNICORN && player.horns.type != Horns.KIRIN)
					player.horns.count = 1;
				if (player.horns.type == Horns.KIRIN)
					player.horns.count += rand(4);
				player.horns.type = Horns.KIRIN;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.KIRIN));
			},
			// is present
			function (): Boolean {
				return player.horns.type === Horns.KIRIN;
			}
	);

	public const HornsOniDual: Transformation = new SimpleTransformation("Oni Dual Horns",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.horns.type == Horns.NONE) desc += "You moan in pleasure as a pair of bony horns push forward out of your forehead,";
				else desc += "You begin to feel an odd itching sensation as you feel your horns repositioning,";
				desc += " the things are actually surprisingly sensitive and you reach orgasm just from them reaching full size,";
				if (player.gender == 1 || player.gender == 3) desc += " your [cock] splattering cum on the ground";
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
				if (player.gender == 1 || player.gender == 3) desc += " your [cock] splattering cum on the ground";
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
					desc += "You begin to feel an odd itching sensation as you feel your horns repositioning and merging back together. Once it's over, you reach up and find a pair of tall-standing goat horns where your four horns used to be. <b>You now have a pair of goat horns.</b>"
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

				TransformationUtils.applyTFIfNotPresent(transformations.HornsGoat, doOutput);

				desc += "You groan in pleasure mixed with pain as your horns split into a second pair that ornaments the side of your head. If the original pair made you look fiendish, your four horns now definitively denounce your demonic nature. <b> You now have four devil horns curving backward behind your head.</b>"

				player.horns.count = 1;
				player.horns.type = Horns.GOATQUAD;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.GOATQUAD));
			},
			// is present
			function (): Boolean {
				return player.horns.type === Horns.GOATQUAD;
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
					desc += "With painful pressure, the skin on the sides of your forehead splits around two tiny nub-like horns. They're angled back in such a way as to resemble those you saw on the dragons in your village's legends. A few inches of horns sprout from your head before stopping. <b>You have about four inches of dragon-like horns.</b>";
					if (player.horns.count < 4) {
						player.horns.count = 4;
					}
				} else {
					desc += "You feel your horns changing and warping, and reach back to touch them. They have a slight curve and a gradual taper. They must look something like the horns the dragons in your village's legends always had.";
					if (player.horns.count < 4) {
						player.horns.count = 4;
					}
				}
				if (player.horns.type == Horns.DRACONIC_X2) {
					if (player.horns.count < 12) {
						if (rand(2) == 0) {
							outputText("[pg]You get a headache as an inch of fresh horns escapes from your pounding skull.");
							player.horns.count += 1;
						} else {
							outputText("[pg]Your head aches as your horns grow a few inches longer.  They get even thicker about the base, giving you a menacing appearance.");
							player.horns.count += 2 + rand(4);
						}
						if (player.horns.count >= 12) outputText("  <b>Your horns settle down quickly, as if they're reached their full size.</b>");
						changes++;
					}
				}
				if (player.horns.count > 12) {
					desc += " The change seems to have shrunken the horns, they're about a foot long now.";
					player.horns.count = 12;
				}



				player.horns.type = Horns.DRACONIC_X2;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.DRACONIC_X2));
			},
			// is present
			function (): Boolean {
				return player.horns.type === Horns.DRACONIC_X2 && player.horns.count >= 12;
			}
	);

	public const HornsCowMinotaur: Transformation = new SimpleTransformation("Cow Minotaur Horns",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.horns.type == Horns.COW_MINOTAUR || player.horns.type == Horns.NONE) {
					if (player.horns.type == Horns.COW_MINOTAUR) {
						if (player.horns.count < 5) {
							desc += "Your small horns get a bit bigger, stopping as medium-sized nubs.";
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
					if (player.horns.count == 0) {
						desc += "A small pair of demon horns erupts from your forehead. They actually look kind of cute. <b>You have horns!</b>";
					} else desc += "Another pair of demon horns, larger than the last, forms behind the first row.";
					player.horns.count += 2;
					player.horns.type = Horns.DEMON;
				} else if (player.horns.type != Horns.DEMON) {
					desc += "Your horns shift, shrinking into two small demonic-looking horns.";
					player.horns.count = 2;
					player.horns.type = Horns.DEMON;
				}
				else
					desc += "The transformation seems to have no effect...";

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.DEMON));
			},
			// is present
			function (): Boolean {
				return player.horns.type === Horns.DEMON && player.horns.count >= 12;
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
				Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.ANTLER));
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
				Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.GHOSTLY_WISP));
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
				Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.OAK));
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
				player.featherColor = randomChoice("snow white","pink","red","blue","purple","peach");
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.ORCHID));
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
					player.horns.count = 4;
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

				player.horns.type = Horns.SEA_DRAGON;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.SEA_DRAGON));
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
				var desc: String = "[pg]";

				if (player.horns.type === Horns.NONE) {
					desc += "You writhe in pain as two bony extrusions begin to push out of the side of your head. As a skull-splitting headache wracks through you, in an instant, the pain subsides as you feel four large, horns on your head. They are as long and curvy. <b>You have twelve inches of bony jabberwocky horns!</b>";
					player.horns.count = 4;
				} else {
					if (player.horns.type == Horns.DEMON && player.horns.count > 4) {
						desc += "Your horns condense, twisting around each other and merging into larger, pointed protrusions. By the time they finish <b>you have two jabberwocky horns</b>, each about twelve inches long.";
						player.horns.count = 12;
					} else {
						desc += "You feel your horns changing and warping, and reach back to touch them. They have a slight curve and a gradual taper. <b>They look must look like the horns of a jabberwocky.</b>";
						if (player.horns.count > 13) {
							desc += " The change also seems to have shrunken the horns, they're about a foot long now.";
							player.horns.count = 12;
						}
					}
				}

				player.horns.type = Horns.JABBERWOCKY;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(HornsMem.getMemory(HornsMem.JABBERWOCKY));
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

	public const HornsJiangshi: Transformation = new SimpleTransformation("Jiangshi Spell Tag Horns",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Out of nowhere, a mysterious parchment appears in a  burst of flames on your forehead. Nothing you do seems to be able to remove it. <b>You now have Jiangshi Spell Tag</b>";

				player.horns.count = 1;

				player.horns.type = Horns.SPELL_TAG;
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.horns.type === Horns.SPELL_TAG;
			}
	);

	public const HornsArchImp: Transformation = new SimpleTransformation("Arch-Imp Horns",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.horns.type != Horns.ARCH_IMP) {
					desc += "You suddenly fall to the floor, clutching at your forehead as a spliting headache hits your with the force of a minotaur charge. Your small demon horns burst forth to form large thick demonic horns before becoming extreamely hot, small runes engraving them into your horns, almost too small to see. You can sense your magic will be more powerful now. <b>You have Arch-Imp horns!</b>";
					if (player.horns.count < 4) player.horns.count = 4;
				}
				else {
					desc += "As a skull-splitting headache wracks through you, your horns extend another couple of inches.";
					player.horns.count += 2;
				}
				player.horns.type = Horns.ARCH_IMP;
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.horns.type === Horns.ARCH_IMP;
			}
	);
	/*
  */

}
}
