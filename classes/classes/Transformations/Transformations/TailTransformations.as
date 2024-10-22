package classes.Transformations.Transformations {
import classes.BodyParts.*;
import classes.GeneticMemories.TailMem;
import classes.Items.MutationsHelper;
import classes.PerkLib;
import classes.Scenes.Metamorph;
import classes.StatusEffects;
import classes.Transformations.*;
import classes.internals.Utils;

/**
 * Base class for transformation events.
 */
public class TailTransformations extends MutationsHelper {
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
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.TWINKASKA));
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
					if (choice == 2) desc += "You feel an odd tingling in your spine and your tail bone starts to throb and then swell. Within a few moments it begins to grow, adding new bones to your spine. Before you know it, you have a tail. Just before you think it's over, the tail begins to sprout soft, glossy [fur color] fur. <b>You now have a cat tail.</b>";
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
				} else if (player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN || player.tailType == Tail.ANT_ABDOMEN) {
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

				if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN || player.tailType == Tail.ANT_ABDOMEN) {
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

	public const TailKirin: Transformation = new SimpleTransformation("Kirin Tail",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

				if (player.tailType == Tail.NONE) desc += "You yelp as a huge lightning bolt bursts out the area just above your ass. You watch in amazement as it twist and curls, slowly becoming thicker and thicker before it fizzles out, <b>leaving you with a short but silky kirin tail!</b>";
				else desc += "You nearly jump out of your skin as your tail burst into a huge lightning bolt. You watch as it curls and twist around before it fizzles out. <b>You now have a short but silky kirin tail!</b>";

				player.tailVenom = 0;
				player.tailRecharge = 0;
				player.tailType = Tail.KIRIN;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KIRIN));
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.KIRIN;
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
					if (!InCollection(player.tailType, Tail.SPIDER_ADBOMEN, Tail.BEE_ABDOMEN, Tail.SCORPION, Tail.MANTIS_ABDOMEN, Tail.ANT_ABDOMEN)) {
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

	public const TailFeyDraconic: Transformation = new SimpleTransformation("Fey Draconic Tail",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

				if (player.tailType == Tail.NONE) desc += "A sudden dull, throbbing pain in your [butt] forces your hands to it; you can feel an ominous lump over your tail bone, swelling bigger and bigger with every heartbeat. All of a sudden, it seems to explode, jutting out and around until it hovers near your ankles, the skin under your flesh hard and scaly. <b>You now have a fey dragon tail flicking at your back, flexible as a whip.</b>";
				else desc += "An icy sensation fills your behind as your tail suddenly goes curiously numb. Twisting your head around, you watch as it melts and transforms into a reptilian appendage, long and flexible. <b>You now have a fey dragon tail.</b>";
				player.tailVenom = 0;
				player.tailRecharge = 0;
				player.tailType = Tail.FEY_DRACONIC;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FEY_DRACONIC));
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.FEY_DRACONIC;
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

	public const TailHydra: Transformation = new SimpleTransformation("Hydra Tails",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";
				TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHydra, doOutput);

				player.addStatusValue(StatusEffects.HydraTailsPlayer, 1, 1);
				desc +="[pg]You groan in discomfort as your tail splits again, a new snake head growing from the bloodied flesh lump to join the others. <b>You now have " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " hydra heads below your waist.</b>";

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 12;
			},
			// is possible
			function (): Boolean {
				return player.lowerBody == LowerBody.HYDRA && player.statusEffectv1(StatusEffects.HydraTailsPlayer) < 12;
			}
	);

	public const TailShark: Transformation = new SimpleTransformation("Shark Tail",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

				desc += "Jets of pain shoot down your spine, causing you to gasp in surprise and fall to your hands and knees. Feeling a bulging at the end of your back, you lower your [armor] down just in time for a fully formed shark tail to burst through. You swish it around a few times, surprised by how flexible it is. After some modifications to your clothing, you're ready to go with <b>your brand new shark tail.</b>";
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

	public const TailAbyssalShark: Transformation = new SimpleTransformation("Abyssal Shark Tail",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

				desc += "Jets of pain shoot down your spine, forcing a surprised gasp as you fall to your knees, reeling as your hands clutch the ground beneath you. A bulging sensation gathers at the base of your back as you "+(player.isNaked()?"":"lower your [armor] and ")+"look at your backside to see a shark tail quickly start to form. Fins burst out as the tail grows out at the base, spreading out from you as a pair of smaller fins sproud at the mid-section of the tail. You're surprised how flexible it is as you sway it around seamlessly. With a few modifications to your armor, you'll be ready to advance with the <b>abyssal shark tail</b> at your behind.";
				player.tailVenom = 0;
				player.tailRecharge = 0;
				player.tailType = Tail.ABYSSAL_SHARK;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.ABYSSAL_SHARK));
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.ABYSSAL_SHARK;
			}
	);

	public const TailSpider: Transformation = new SimpleTransformation("Spider Tail",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

				desc += "A burst of pain hits you just above your [butt], coupled with a sensation of burning heat and pressure. You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body. Reaching back, you grab at it with your hands. It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape. The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen! With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones. That may prove useful. <b>You now have a spider's abdomen hanging from above your [butt]!</b>";

				player.chitinColor2 = "black";
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
				if (!InCollection(player.chitinColor2, "black","ebony")){
					player.chitinColor2 = randomChoice("black","ebony");
				}
				if (player.chitinColor1 != "yellow"){
					player.chitinColor1 = "yellow";
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
					if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.ANT_ABDOMEN || player.tailType == Tail.MANTIS_ABDOMEN) desc += "You feel a tingling in your insectile abdomen as it stretches, narrowing, the exoskeleton flaking off as it transforms into a flexible demon-tail, complete with a round spaded tip. ";
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


	public const TailAzazel: Transformation = new SimpleTransformation("Demonic Tail",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

				if (player.tailType != Tail.NONE) {
					desc += "";
					if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.ANT_ABDOMEN || player.tailType == Tail.MANTIS_ABDOMEN) desc += "You feel a tingling in your insectile abdomen as it stretches, narrowing, the exoskeleton flaking off as it transforms into a  ";
					else desc += "You feel a tingling in your tail. You are amazed to discover it has shifted into a ";
					desc += "thin, scaly, prehensile reptilian tail almost as long as you are tall and covered in [fur color] fur, swings behind you like a living bullwhip. The end of its tip is tapered and thin like the end of a whip. <b>Your tail is now demonic in appearance.</b>";
				} else desc += "A pain builds in your backside... growing more and more pronounced. The pressure suddenly disappears with a loud ripping and tearing noise. <b>You realize you now have an azazel tail</b>... it looks thin, scaly, prehensile reptilian tail almost as long as you are tall and covered in [fur color] fur, swings behind you like a living bullwhip. The end of its tip is tapered and thin like the end of a whip.";
				player.tailVenom = 0;
				player.tailRecharge = 0;
				player.tailType = Tail.AZAZEL;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.AZAZEL));
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
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.DOG));
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
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.RABBIT));
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
						desc += "You feel an odd itch down your tail. It’s kind of a familiar feeling, as when you work a muscle to strengthen it. As you’re musing on what could be the cause, something changes on your tails, as they tense and twitch, so you look back to examine what’s happening to them.\n\nWhen you lay your eyes on them, the first thing that you notice if that is they’re entwining in a mess of curls and knots, the flesh on them merging until you have a single one. Then, the lone tail left starts shortening quickly. Soon, it has reduced into a short, fleshy bump of a tail. It doesn’t keep that way long, as it lengthens and wides a little, and start sprouting large, [feather color] colored feathers, shaped as wide fan. Some of then are very long, while others, near you [ass], are soft and downy.";
					} else {
						desc += "You feel an odd itch down your tail. It’s kind of a familiar feeling, as when you work a muscle to strengthen it. As you’re musing on what could be the cause, something changes on your tail, as it tenses and twitches, so you look back to examine what’s happening.\n\nWhen you lay your eyes on it, the first thing that you notice if that is shortening quickly. Soon, it has reduced into a short, fleshy bump of a tail. It doesn’t keep that way long, as it lengthens and wides a little, and start sprouting large, [feather color] colored feathers, shaped as wide fan. Some of then are very long, while others, near you butt, are soft and downy.";
					}
				} else {
					desc += "You feel an odd itch down your spine. It’s kind of a familiar feeling, as when you work a muscle to strengthen it. As you’re musing on what could be the cause, something sprouts just above your butt and you take of your lower clothing so you can examine it.\n\nWhen you lay your eyes on it, you notice a short, fleshy bump of a tail. It doesn’t keep that way long, as it lengthens and wides a little, and start sprouting large, [feather color] colored feathers, shaped as wide fan. Some of then are very long, while others, near you butt, are soft and downy.";
				}
				desc += " <b>In any case, you have now a full, fan-shaped avian tail above your [butt]!</b>";

				player.tailVenom = 0;
				player.tailRecharge = 0;
				player.tailType = Tail.AVIAN;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.AVIAN));
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

				desc += "The fan of feathers at your backside reacts under the statue magic effects. An otherworldly magic envelopes it, making the feathers twist and converge in an odd fashion, at the same time that the small bump of your tail elongates until becoming long enough to reach far past your knee.\n\nBefore you notice it, the long feathers have merged into a tuft of [fur color] at the end of your now long tail, while the short, downy ones now cover every inch of bare skin that the elongated appendage now have. <b>Well, seems like you gained a griffin-like tail!</b> It’s quite leonine in shape, but its appearance remains a bit avian.";

				player.tailVenom = 0;
				player.tailRecharge = 0;
				player.tailType = Tail.GRIFFIN;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.GRIFFIN));
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
				else if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN || player.tailType == Tail.ANT_ABDOMEN) {
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
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KANGAROO));
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
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.THUNDERBIRD));
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

				if (player.tailType == Tail.NONE) desc += "A pressure builds in your backside. You feel under your clothes and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers and bursts out the back of your clothes, it grows most of the way to the ground before suddenly curving back up, turning easily twice as big as you are. A thick coat of light and [fur color] striped fur covers it entirely from the base to the tip. Well, it's going to be hard to hide this huge thing, especially since it curls and puffs up just <b>like a squirrel tail.</b>";
				else desc += "Something weird happens with your tail as it begins to change into something else. Within seconds the shape and coverage becomes closer to what you would expect of a squirrel tail. <b>You now have a squirrel tail!</b>";

				player.tailVenom = 0;
				player.tailRecharge = 0;
				player.tailType = Tail.SQUIRREL;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.SQUIRREL));
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
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.WEASEL));
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
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.RACCOON));
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
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FERRET));
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
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.BEAR));
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
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.USHI_ONI));
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

	/**
	 * @param tailCount target tail count
	 * @param magnitude max. number of added/removed tails
	 * @param canRemove can remove tails (if false, this is "at least [tailCount] fox tails" TF)
	 */
	public function TailFox(tailCount:int = 1, magnitude:int = 9, canRemove:Boolean = true):Transformation {
		return new SimpleTransformation("Fox Tail",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "";

					TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

					if (player.tailType !== Tail.FOX) {
						TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

						desc += "You feel a strange sensation on your backside. When you touch the area, you discover a strange nodule growing there that seems to be getting larger by the second. With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it had a mind of its own. <b>You now have a fox's tail!</b>";

						player.tailVenom    = 0;
						player.tailRecharge = 0;
						player.tailType     = Tail.FOX;
						player.tailCount    = 1;

						if (tailCount > 1) {
							desc += "\n\n";
						}
					}

					if (player.tailCount < tailCount) {
						const newTails:int = Math.min(tailCount - player.tailCount, magnitude);
						tailCount          = player.tailCount + newTails;

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
					} else if (player.tailCount > tailCount && canRemove) {
						const removedTails:int = Math.min(player.tailCount - tailCount, magnitude);
						tailCount              = player.tailCount - removedTails;

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

					if (tailCount == 2) (desc += "<b>\nYour next tail will be available at level 6, provided you have: 30 Intelligence and 30 Wisdom (kitsune) OR 60 Wisdom (werefox).</b>")
					else if (tailCount == 3) (desc += "<b>\nYour next tail will be available at level 12, provided you have: 45 Intelligence and 45 Wisdom (kitsune) OR 90 Wisdom (werefox).</b>")
					else if (tailCount == 4) (desc += "<b>\nYour next tail will be available at level 18, provided you have: 60 Intelligence and 60 Wisdom (kitsune) OR 120 Wisdom (werefox).</b>")
					else if (tailCount == 5) (desc += "<b>\nYour next tail will be available at level 24, provided you have: 75 Intelligence and 75 Wisdom (kitsune) OR 150 Wisdom (werefox).</b>")
					else if (tailCount == 6) (desc += "<b>\nYour next tail will be available at level 30, provided you have: 90 Intelligence and 90 Wisdom (kitsune) OR 180 Wisdom (werefox).\nOnly the truly corrupted would continue gaining tails by directly using the jewels. Pure kitsune should offer up the jewels to Taoth.</b>")
					else if (tailCount == 7) (desc += "<b>\nYour next tail will be available at level 36, provided you have: 105 Intelligence and 105 Wisdom (kitsune) OR 210 Wisdom (werefox).</b>")
					else if (tailCount == 8) (desc += "<b>\nYour final tail will be available at level 42, provided you have: 120 Intelligence and 120 Wisdom (kitsune) OR 240 Wisdom (werefox).</b>")

					player.tailCount = tailCount;
					if (doOutput) outputText(desc);
					if (tailCount == 9 && player.hasVagina()) {
						// ninetails -> get vag of holding!
						outputText("[pg]You clutch your stomach with both hands, dropping to the ground in pain as your internal organs begin to twist and shift violently inside you.  As you clench your eyes shut in agony, you are overcome with a sudden calm.  The pain in your abdomen subsides, and you feel at one with the unfathomable infinity of the universe, warmth radiating through you from the vast swirling cosmos contained within your womb.");
						if (silly()) outputText("  <b>Your vagina has become a universe unto itself, capable of accepting colossal insertions beyond the scope of human comprehension!</b>");
						else outputText("  <b>Your vagina is now capable of accepting even the most ludicrously sized insertions with no ill effects.</b>");
					}

					//noinspection FallThroughInSwitchStatementJS			// Fallthrough is intended for retroactively unlocking in Metamorph after getting GeneticMemory
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
							break;
					}
				},
				// is present
				function ():Boolean {
					return player.tailType == Tail.FOX && (player.tailCount == tailCount || !canRemove && player.tailCount >= tailCount);
				}
		)
	}

	public function TailKitshoo(tailCount: int = 1): Transformation {
		return new SimpleTransformation("Cinder Fox Tail",
				// apply effect
				function (doOutput: Boolean): void {
					var desc: String = "";

					TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

					if (player.tailType !== Tail.KITSHOO) {
						TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);
						desc += "You feel a strange sensation on your backside. When you touch the area, you discover a strange nodule growing there that seems to be getting larger by the second. With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, sending hot embers around. <b>You now have a cinder fox's tail!</b>";

						player.tailVenom = 0;
						player.tailRecharge = 0;
						player.tailType = Tail.KITSHOO;
						player.tailCount = 1;

						if (tailCount > 1) {
							desc += "\n\n";
						}
					}

					if (player.tailCount < tailCount) {
						const newTails: int = tailCount - player.tailCount;

						desc += "A tingling pressure builds on your backside, and your bushy flame tail" + ((player.tailCount > 1) ? "s begin" : " begins") + " to glow with an eerie, crimson light. With a few stray embers, ";

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

						desc += "A tingling pressure builds on your backside, and your bushy flame tail" + ((player.tailCount > 1) ? "s begin" : " begins") + " to glow with an eerie, crimson light. With a few stray embers, ";

						if (tailCount == 1) {
							desc += (player.tailCount == 2 ? "both" : "all") + " your tails"
						} else if (removedTails == 1) {
							desc += "two of your tails"
						} else {
							desc += "some of your tails"
						}

						desc += " magically fuse, leaving you with "

						if (tailCount == 1) {
							desc += "only a single remaining cinder fox tail!"
						} else {
							desc += Utils.num2Text(tailCount) + " remaining cinder fox tails!"
						}
					}

					desc += " <b>You now have " + Utils.num2Text(tailCount) + " cinder fox tail" + ((tailCount > 1) ? "s" : "") + "!</b>"

					if (tailCount == 2) ( desc += "<b>\nYour next tail will be available at level 6, provided you have 30 Intelligence and 30 Wisdom.</b>" )
					else if (tailCount == 3) ( desc += "<b>\nYour next tail will be available at level 12, provided you have 45 Intelligence and 45 Wisdom.</b>" )
					else if (tailCount == 4) ( desc += "<b>\nYour next tail will be available at level 18, provided you have 60 Intelligence and 60 Wisdom.</b>" )
					else if (tailCount == 5) ( desc += "<b>\nYour next tail will be available at level 24, provided you have 75 Intelligence and 75 Wisdom.</b>" )
					else if (tailCount == 6) ( desc += "<b>\nYour next tail will be available at level 30, provided you have 90 Intelligence and 90 Wisdom.</b>" )
					else if (tailCount == 7) ( desc += "<b>\nYour next tail will be available at level 36, provided you have 105 Intelligence and 105 Wisdom.</b>" )
					else if (tailCount == 8) ( desc += "<b>\nYour final tail will be available at level 42, provided you have 120 Intelligence and 120 Wisdom.</b>" )

					player.tailCount = tailCount;
					if (doOutput) outputText(desc);

					//noinspection FallThroughInSwitchStatementJS			// Fallthrough is intended for retroactively unlocking in Metamorph after getting GeneticMemory
					switch (tailCount) {
						case 9:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_9));
						case 8:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_8));
						case 7:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_7));
						case 6:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_6));
						case 5:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_5));
						case 4:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_4));
						case 3:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_3));
						case 2:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_2));
						case 1:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO));
							break;
					}
				},
				// is present
				function (): Boolean {
					return player.tailType == Tail.KITSHOO && player.tailCount == tailCount;
				}
		)
	}

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
				player.chitinColor = "midnight purple";
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.ATLACH_SPIDER_ADBOMEN));
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.SPIDER_ADBOMEN && player.chitinColor === "midnight purple";
			}
	);

	public const TailAnt: Transformation = new SimpleTransformation("Ant Tail",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

				desc += "A burst of pain hits you just above your [butt], coupled with a sensation of burning heat and pressure. You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body. Reaching back, you grab at it with your hands. It's huge... and you can feel it toughening under your touches, firming up until the whole tail has become quite hard and elliptical in shape. The heat fades, leaving behind a gentle warmth, and you realize your tail has become an ant's abdomen! As you start to shift your seat, however, you feel a sudden tug, and feel like something was just spat out--you must have a small stinger back there as well. <b>You now have an ant's abdomen.</b>";
				player.tailVenom = 10;
				player.tailRecharge = 5;
				player.tailType = Tail.ANT_ABDOMEN;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.ANT_ABDOMEN));
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.ANT_ABDOMEN;
			}
	);

	public const TailDeer: Transformation = new SimpleTransformation("Deer Tail",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

				desc += "You feel a tightening just above your ass, as if a massive hand was pinching you.  It releases with a curious \"pomf\"-ing noise.  You turn this way and that, finally managing to crane your neck to see your <b>fluffy, flicking deer tail.</b>";
				player.tailType = Tail.DEER;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.DEER));
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.DEER;
			}
	);

	public const TailYgddrasil: Transformation = new SimpleTransformation("Ygddrasil Tail",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

				desc += "You feel a weird sensation in your ";
				if (player.tailType > Tail.NONE) {
					desc += "tail";
					if (player.tailCount > 1) desc += "s";
				}
				else desc += "tailbone";
				desc += ". It kind of feels cool, pleasurable and makes you queasy all at once. Suddenly, ";
				if (player.tailType > Tail.NONE) desc += "it begins to twist and writhe as the odd sensation intensifies.  Before your eyes, it twists into a reptilian appendage";
				else desc += "your tailbone erupts and elongates into a new limb, your new tail";
				desc += ". Long, thin, prehensile, good for maintaining your balance. As if in conclusion, a leaf suddenly sprouts from the tip of your tail. <b>You now have a leaf-tipped reptilian tail!</b>";
				player.tailType = Tail.YGGDRASIL;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.YGGDRASIL));
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.YGGDRASIL;
			}
	);

	public const TailArigeanGreen: Transformation = new SimpleTransformation("Arigean Tail (Green)",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

				desc += "";

				player.tailVenom = 0;
				player.tailRecharge = 0;
				player.tailType = Tail.ARIGEAN_GREEN;
				player.tailCount = 2;

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.ARIGEAN_GREEN;
			}
	);

	public const TailArigeanRed: Transformation = new SimpleTransformation("Arigean Tail (Red)",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

				desc += "";

				player.tailVenom = 0;
				player.tailRecharge = 0;
				player.tailType = Tail.ARIGEAN_RED;
				player.tailCount = 2;

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.ARIGEAN_RED;
			}
	);

	public const TailArigeanYellow: Transformation = new SimpleTransformation("Arigean Tail (Yellow)",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

				desc += "";

				player.tailVenom = 0;
				player.tailRecharge = 0;
				player.tailType = Tail.ARIGEAN_YELLOW;
				player.tailCount = 2;

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.ARIGEAN_YELLOW;
			}
	);

	public const TailMoth: Transformation = new SimpleTransformation("Moth Abdomen",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);


				desc += "you suddenly feel like your tailbone is in pain, like something is bursting out of it, suddenly the pain subsides and you feel something resting atop your ass, eventually you stop noticing it. <b>You now have a moth abdomen</b>";
				player.tailType = Tail.MOTH_ABDOMEN;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				//Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.DEER));
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.MOTH_ABDOMEN;
			}
	);

	public const TailTroll: Transformation = new SimpleTransformation("Troll Tail",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

				desc += "You feel your spine tingle as pressure builds up right above your rear end. A sharp pain briefly flows through you for a fleeting moment before you can feel more pressure build up. You feel a tail sprout from just above your rear coil down to your legs which is about 3 feet long. <b>You now have a troll tail!</b>";
				player.tailType = Tail.TROLL;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.TROLL));
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.TROLL;
			}
	);

	public const TailGlacialTroll: Transformation = new SimpleTransformation("Glacial Troll Tail",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

				desc += "You feel your spine tingle as pressure builds up right above your rear end. A sharp pain briefly flows through you for a fleeting moment before you can feel more pressure build up. You feel a tail sprout from just above your rear coil down to your legs which is about 3 feet long. <b>You now have a glacial troll tail!</b>";
				player.tailType = Tail.GLACIAL_TROLL;
				player.tailCount = 1;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.GLACIAL_TROLL));
			},
			// is present
			function (): Boolean {
				return player.tailType === Tail.GLACIAL_TROLL;
			}
	);
	/*
  */
}
}
