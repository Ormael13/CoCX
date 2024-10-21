package classes.Transformations.Transformations {
import classes.BodyParts.*;
import classes.GeneticMemories.LowerBodyMem;
import classes.GeneticMemories.TailMem;
import classes.Items.MutationsHelper;
import classes.PerkLib;
import classes.Scenes.Metamorph;
import classes.StatusEffects;
import classes.Transformations.*;
import classes.internals.Utils;
import classes.lists.Gender;

/**
 * Base class for transformation events.
 */
public class LowerBodyTransformations extends MutationsHelper {
	/*
    *      ████████  █████  ██    ██  ██████     ██       ██████  ██       ██ ███████ ██████      ██████   ██████  ██████  ██    ██
    *         ██    ██   ██ ██    ██  ██   ██    ██      ██    ██ ██       ██ ██      ██   ██     ██   ██ ██    ██ ██   ██  ██  ██
    *         ██    ███████ ██    ██  ██████     ██      ██    ██ ██  ███  ██ █████   ██████      ██████  ██    ██ ██   ██    ██
    *         ██    ██   ██ ██    ██  ██   ██    ██      ██    ██ ██ ██ ██ ██ ██      ██   ██     ██   ██ ██    ██ ██   ██    ██
    *         ██    ██   ██  ██████   ██   ██    ███████  ██████  ████   ████ ███████ ██   ██     ██████   ██████  ██████     ██
    */


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

				if (doOutput) outputText(desc);
				if (player.hasStatusEffect(StatusEffects.HydraTailsPlayer)) player.removeStatusEffect(StatusEffects.HydraTailsPlayer);
				player.legCount = 4;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.TAUR));
			},
			// is present
			function (): Boolean {
				return player.legCount >= 4;
			}
		)
	}

	public function LowerBodyHoofed(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Hoofed Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.HOOFED ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}
				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.HOOFED).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.HOOFED;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.HOOFED));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.HOOFED;
			}
		)
	}

	public function LowerBodyKirin(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Kirin Hoofed Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.KIRIN ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}

				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
					desc += "You stagger as your " + Utils.num2Text(player.legCount) + " [feet] change, curling up into painful angry lumps of flesh. They get tighter and tighter, harder and harder, until at last they solidify into hooves! A coat of scales springs up below your waist accompanied by an outline of fur, itching as it fills in and completely covers your " + Utils.num2Text(player.legCount) + " [legs].<b> You now have hooves in place of your [feet] with furry and scaly legs!</b>";
				}
				// Case 2: Bipedal TF
				else if (legCount === 2) {
					TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

					// Display TF text if the player is obtaining this part instead of only changing leg count
					if (player.lowerBody !== LowerBody.KIRIN) {
						desc += "\n\nYou stagger as your pair of [feet] change, curling up into painful angry lumps of flesh. They get tighter and tighter, harder and harder, until at last they solidify into hooves! A coat of scales springs up below your waist accompanied by an outline of fur, itching as it fills in and completely covers your two [legs].<b> You now have hooves in place of your [feet] with furry and scaly legs!</b>";
					}
				}
				// Case 3: Taur TF
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.KIRIN).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.KIRIN;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.KIRIN));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.KIRIN;
			}
		)
	}
	
	public function LowerBodyCat(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Cat Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.CAT ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}
				var desc: String = "";

				desc += "\n\n";
				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.CAT).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.CAT;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.CAT));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.CAT;
			}
		)
	}

	public function LowerBodyLizard(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Lizard Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.LIZARD ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}

				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.LIZARD).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.LIZARD;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.LIZARD));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.LIZARD;
			}
		)
	}

	public function LowerBodyFox(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Fox Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.FOX ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}

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
				} else if (legCount >= 4 && player.legCount !== 4) {
					transformations.LowerBodyTaur(LowerBody.FOX).applyEffect();
				} else if (legCount >= 4 && player.legCount >= 4) {
					desc += "Your hamstrings tense painfully and begin to pull, sending you onto your face. As you writhe on the ground, you can feel your four thighs shortening and your [feet] stretching";
					if (player.lowerBody == LowerBody.BEE) {
						desc += ", while a hideous cracking fills the air";
					}
					desc += ". When the spasms subside and you can once again stand, <b>you find that your [legs] have been changed to those of a fox!</b>";
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.FOX;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.FOX));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.FOX;
			}
		)
	}

	public function LowerBodyDraconic(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Draconic Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.DRAGON ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}

				desc += "\n\n";
				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
					desc += "You scream in agony as you feel the bones in your [feet] suddenly break and restructure themselves. When the pain is over, you realize that your [feet] have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon [feet].</b>";
				}
				// Case 2: Bipedal TF
				else if (legCount === 2) {
					if (player.isTaur()) {
						desc += "You cry out as spasms of pain suddenly rip through your quadrupedal body, bringing you crashing onto the ground. Words cannot define the agony as muscles and bones twist and shift and collapse violently. When it's all over, you stagger upright, finding yourself standing on two legs again. Though covered in scales and with the paws of some monster lizard instead of [feet], they otherwise look like your old human legs. <b>You now have two dragon feet.</b>";
					} else if (player.lowerBody == LowerBody.DRIDER) {
						desc += "A disquieting feeling ripples through your arachnid abdomen, and you find yourself losing control of your body from the waist down. Your spidery legs flail madly as your abdomen visibly swells, chitin cracking ominously as the pressure builds up inside of you... and then explodes! You wipe the gore from your face in disgust, wondering why you feel no pain. Rolling over, you see that, caked with spider-slime, you now have a new pair of legs, human-like save for the scales and the bestial paws that serve as feet. <b>You now have dragon feet.</b>";
					} else if (player.isNaga()) {
						desc += "You fall on your face to the ground, hissing and screeching in pain - it feels like someone has grabbed the tip of your tail, pulled it viciously straight, and is now splitting it up the middle with a knife! Paralyzed from the waist down, you claw desperately at the earth to try and alleviate the pain, and can only think to thank your lucky stars when it fades away. Looking down where your tail was, though the scales remain, you realize you've become a biped again, your new feet sporting bestial claws on their toes. <b>You now have dragon feet.</b>";
					} else if (player.isGoo()) {
						desc += "A strange tingling sensation fills you, and you watch as your gooey blob of a body begins to ripple and shudder; you try to make it stop, but you can't control it. Before your eyes, it shapes itself into the appearance of legs, the colored slime growing denser and thicker, the surface membrane texturing itself to look like scales. Before you've quite realized what's happened, the slime has set like water freezing, leaving you with humanoid legs once again, though tipped with claws and very reptilian in appearance. <b>You now have dragon feet.</b>";
					} else if (player.lowerBody == LowerBody.HOOFED) {
						desc += "You bellow in pain as your legs break and reform and your hooves seem to suddenly explode, the bones within twisting themselves into monstrous three-toed appendages, more like those of some terrible lizard-thing than anything else. <b>You now have dragon feet.</b>";
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
					} else if (player.isAlraune()) {
						desc += "Your petals all withers and fall off as your pitch and flower turn to dust leaving you with normal human legs. The changes does not stop there however. When the pain is over, you realize that you still stand atop human-looking legs, but your [feet] have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon [feet].</b>";
					}

					if (!player.isBiped()){
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.DRAGON).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.DRAGON;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.DRAGON));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.DRAGON;
			}
		)
	}

	public function LowerBodyFeyDraconic(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Draconic Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.FEY_DRAGON ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
				}

				desc += "\n\n";
				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
					desc += "You scream in agony as you feel the bones in your [feet] suddenly break and restructure themselves. When the pain is over, you realize that your [feet] have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon [feet].</b>";
				}
				// Case 2: Bipedal TF
				else if (legCount === 2) {
					if (player.isTaur()) {
						desc += "You cry out as spasms of pain suddenly rip through your quadrupedal body, bringing you crashing onto the ground. Words cannot define the agony as muscles and bones twist and shift and collapse violently. When it's all over, you stagger upright, finding yourself standing on two legs again. Though covered in scales and with the paws of some monster lizard instead of [feet], they otherwise look like your old human legs. <b>You now have two dragon feet.</b>";
					} else if (player.lowerBody == LowerBody.DRIDER) {
						desc += "A disquieting feeling ripples through your arachnid abdomen, and you find yourself losing control of your body from the waist down. Your spidery legs flail madly as your abdomen visibly swells, chitin cracking ominously as the pressure builds up inside of you... and then explodes! You wipe the gore from your face in disgust, wondering why you feel no pain. Rolling over, you see that, caked with spider-slime, you now have a new pair of legs, human-like save for the scales and the bestial paws that serve as feet. <b>You now have dragon feet.</b>";
					} else if (player.isNaga()) {
						desc += "You fall on your face to the ground, hissing and screeching in pain - it feels like someone has grabbed the tip of your tail, pulled it viciously straight, and is now splitting it up the middle with a knife! Paralyzed from the waist down, you claw desperately at the earth to try and alleviate the pain, and can only think to thank your lucky stars when it fades away. Looking down where your tail was, though the scales remain, you realize you've become a biped again, your new feet sporting bestial claws on their toes. <b>You now have dragon feet.</b>";
					} else if (player.isGoo()) {
						desc += "A strange tingling sensation fills you, and you watch as your gooey blob of a body begins to ripple and shudder; you try to make it stop, but you can't control it. Before your eyes, it shapes itself into the appearance of legs, the colored slime growing denser and thicker, the surface membrane texturing itself to look like scales. Before you've quite realized what's happened, the slime has set like water freezing, leaving you with humanoid legs once again, though tipped with claws and very reptilian in appearance. <b>You now have dragon feet.</b>";
					} else if (player.lowerBody == LowerBody.HOOFED) {
						desc += "You bellow in pain as your legs break and reform and your hooves seem to suddenly explode, the bones within twisting themselves into monstrous three-toed appendages, more like those of some terrible lizard-thing than anything else. <b>You now have dragon feet.</b>";
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
					} else if (player.isAlraune()) {
						desc += "Your petals all withers and fall off as your pitch and flower turn to dust leaving you with normal human legs. The changes does not stop there however. When the pain is over, you realize that you still stand atop human-looking legs, but your [feet] have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon [feet].</b>";
					}

					if (!player.isBiped()){
						player.lowerBody = LowerBody.FEY_DRAGON;
						transformations.LowerBodyBipedal.applyEffect(false);
					}

					TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

					// Display TF text if the player is obtaining this part instead of only changing leg count and didn't hit any special text
					if (player.lowerBody !== LowerBody.FEY_DRAGON) {
						desc += "You scream in agony as you feel the bones in your [feet] suddenly break and restructure themselves, toes fusing together, bone swelling out of the merged masses of flesh. When the pain is over, you realize that you still stand atop human-looking legs, but your feet have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon feet.</b>";
					}
				}
				// Case 3: Taur TF
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.FEY_DRAGON).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.FEY_DRAGON;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.FEY_DRAGON));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.FEY_DRAGON;
			}
		)
	}
	
	public function LowerBodyClovenHoofed(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Cloven Hoofed Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.CLOVEN_HOOFED ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}

				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
					desc += "You feel an odd sensation in your lower region. Your [feet] shift and you hear bones cracking as they reform. Fur grows on your legs and soon you're looking at a <b>new pair of cloven hoofed legs</b>.";
					legCount = 4;
				}
				// Case 2: Bipedal TF
				else if (legCount === 2) {
					if (player.lowerBody == LowerBody.NAGA) {
						desc += "You scream in agony as a horrible pain racks the entire length of your snake-like coils. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the lower body of a snake. Instead, you only have two legs. They are digitigrade and end in cloven hooves. <b>You now have deer legs!</b>";
						player.lowerBody = LowerBody.CLOVEN_HOOFED;
						transformations.LowerBodyBipedal.applyEffect(false);
					} else if (player.lowerBody == LowerBody.MELKIE) {
						desc += "You scream in agony as a horrible pain racks the entire length of your seal-like tail. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the lower body of a seal. Instead, you only have two legs. They are digitigrade and end in cloven hooves. <b>You now have deer legs!</b>";
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.CLOVEN_HOOFED).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.CLOVEN_HOOFED;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.CLOVEN_HOOFED));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.CLOVEN_HOOFED;
			}
		)
	}

	public function LowerBodySalamander(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Salamander Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.SALAMANDER ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}

				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.SALAMANDER).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.SALAMANDER;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.SALAMANDER));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.SALAMANDER;
			}
		)
	}

	public function LowerBodyMantis(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Mantis Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.MANTIS ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}

				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.MANTIS).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.MANTIS;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.MANTIS));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.MANTIS;
			}
		)
	}

	public function LowerBodyShark(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Shark Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.SHARK ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}

				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.SHARK).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.SHARK;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.SHARK));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.SHARK;
			}
		)
	}

	public function LowerBodyLion(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Lion Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.LION ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}

				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.LION).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.LION;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.LION));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.LION;
			}
		)
	}

	public function LowerBodyOrca(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Orca Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.ORCA ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}

				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.ORCA).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.ORCA;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.ORCA));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.ORCA;
			}
		)
	}
	
	public function LowerBodyRaiju(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Raiju Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.RAIJU ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}

				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
					desc += "You have trouble standing as multiple flashes of sensation run across your [legs]. Sitting down before you accidentally hurt yourself, you watch with apprehension as your [legs] begin to shift, fluffy patches of fur traveling up your [legs] until they reach your knees. You yelp as the bones in your feet split and rearrange themselves into paws. Eventually, the sensation ebbs and you slowly get used to your <b>Raiju paws!</b>";
				}
				// Case 2: Bipedal TF
				else if (legCount === 2) {
					TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

					// Display TF text if the player is obtaining this part instead of only changing leg count
					if (player.lowerBody !== LowerBody.RAIJU) {
						desc += "You have trouble standing as multiple flashes of sensation run across your [legs]. Sitting down before you accidentally hurt yourself, you watch with apprehension as your [legs] begin to shift, fluffy patches of fur traveling up your [legs] until they reach your knees. You yelp as the bones in your feet split and rearrange themselves into paws. Eventually, the sensation ebbs and you slowly get used to your <b>Raiju paws!</b>";
					}
				}
				// Case 3: Taur TF
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.RAIJU).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.RAIJU;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.RAIJU));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.RAIJU;
			}
		)
	}
	
	public function LowerBodyDog(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Dog Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
					if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.DOG ){
						if (toggleTaur && legCount === 2) legCount = 4;
						else if (toggleTaur && legCount >= 4) legCount = 2;
					}

				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.DOG).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.DOG;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.DOG));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.DOG;
			},
			// is possible
			function (): Boolean {
				return player.lowerBody != LowerBody.DOG && player.tailType == Tail.DOG && player.ears.type == Ears.DOG;
			}
	); }

	public function LowerBodyWolf(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Wolf Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
					if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.WOLF ){
						if (toggleTaur && legCount === 2) legCount = 4;
						else if (toggleTaur && legCount >= 4) legCount = 2;
					}

				desc += "\n\n";
				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.WOLF).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.WOLF;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.WOLF));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.WOLF;
			},
			// is possible
			function (): Boolean {
				return player.lowerBody != LowerBody.WOLF && player.tailType == Tail.WOLF && player.ears.type == Ears.WOLF;
			}
	); }
	
	public function LowerBodyWeasel(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Weasel Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";

				if(player.lowerBody == LowerBody.WEASEL ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}
				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.WEASEL).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.WEASEL;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.WEASEL));
				player.legCount = legCount;
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.WEASEL;
			}
		)
	}

	public function LowerBodyBear(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Bear Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";


				if(player.lowerBody == LowerBody.BEAR ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}
				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.BEAR).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.BEAR;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.BEAR));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.BEAR;
			}
		)
	}

	public function LowerBodySeaDragon(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Sea Dragon Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";

				if(player.lowerBody == LowerBody.SEA_DRAGON ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}
				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
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
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.SEA_DRAGON).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.SEA_DRAGON;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.SEA_DRAGON));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.SEA_DRAGON;
			}
		)
	}

	public function LowerBodyGryphon(legCount: int = undefined, toggleTaur:Boolean = false): Transformation {
		return new SimpleTransformation("Gryphon Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(player.lowerBody == LowerBody.GRYPHON ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}
				
				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
					desc += "A familiar numbness reaches your legs. The rough skin covering your lower legs and feet change into more usual, soft skin, and shortly after, it starts sprouting " + player.furColor2 + " colored fur over them.\n\nYour feet themselves reshape, losing their avian stance and gaining one much more feline, complete with soft pink paw pads. The talons at the end of each toe become retractile feline claws. Albeit walking with those seems initially tricky, you easily gain a hold on how using your <b>new gryphon-like legs.</b>";
				}
				// Case 2: Bipedal TF
				else if (legCount === 2) {
					TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

					// Display TF text if the player is obtaining this part instead of only changing leg count
					if (player.lowerBody !== LowerBody.GRYPHON) {
						desc += "A familiar numbness reaches your legs. The rough skin covering your lower legs and feet change into more usual, soft skin, and shortly after, it starts sprouting " + player.furColor2 + " colored fur over them.\n\nYour feet themselves reshape, losing their avian stance and gaining one much more feline, complete with soft pink paw pads. The talons at the end of each toe become retractile feline claws. Albeit walking with those seems initially tricky, you easily gain a hold on how using your <b>new gryphon-like legs.</b>";
					}
				}
				// Case 3: Taur TF
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.GRYPHON).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.GRYPHON;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.GRYPHON));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.GRYPHON;
			}
		)
	}
	
	public function LowerBodyReindeer(legCount: int = undefined, toggleTaur: Boolean = false): Transformation {
		return new SimpleTransformation("Reindeer Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				if (!legCount) legCount = player.legCount;
				var desc: String = "";
				if(Metamorph.checkTaurUnlock() && player.lowerBody == LowerBody.CLOVEN_HOOFED_2 ){
					if (toggleTaur && legCount === 2) legCount = 4;
					else if (toggleTaur && legCount >= 4) legCount = 2;
					else if (legCount === 1) legCount = 2;
				}

				// Case 1: Morph Taur legs without changing leg count
				if (player.isTaur() && legCount >= 4) {
					desc += "You feel an odd sensation in your lower region. Your [feet] shift and you hear bones cracking as they reform. Thick fur grows on your legs and soon you're looking at a <b>new pair of reindeer legs</b>.";
					legCount = 4;
				}
				// Case 2: Bipedal TF
				else if (legCount === 2) {
					if (player.lowerBody == LowerBody.NAGA) {
						desc += "You scream in agony as a horrible pain racks the entire length of your snake-like coils. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the lower body of a snake. Instead, you only have two legs. They are digitigrade and end in cloven hooves. <b>You now have reindeer legs!</b>";
						player.lowerBody = LowerBody.CLOVEN_HOOFED_2;
						transformations.LowerBodyBipedal.applyEffect(false);
					} else if (player.lowerBody == LowerBody.MELKIE) {
						desc += "You scream in agony as a horrible pain racks the entire length of your seal-like tail. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the lower body of a seal. Instead, you only have two legs. They are digitigrade and end in cloven hooves. <b>You now have reindeer legs!</b>";
						player.lowerBody = LowerBody.CLOVEN_HOOFED_2;
						transformations.LowerBodyBipedal.applyEffect(false);
					}

					TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

					// Display TF text if the player is obtaining this part instead of only changing leg count and didn't hit any special text
					if (player.lowerBody !== LowerBody.CLOVEN_HOOFED_2) {
						desc += "\n\nYou scream in agony as the bones in your legs break and rearrange. Once the pain subsides, you inspect your legs, finding that they are digitigrade and ending in cloven hooves. <b>You now have a pair of reindeer legs!</b>";
					}
				}
				// Case 3: Taur TF
				else if (!player.isTaur() && legCount >= 4) {
					transformations.LowerBodyTaur(LowerBody.CLOVEN_HOOFED_2).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
				player.lowerBody = LowerBody.CLOVEN_HOOFED_2;
				player.legCount = legCount;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.CLOVEN_HOOFED_2));
			},
			// is present
			function (): Boolean {
				return !Metamorph.checkTaurUnlock() && player.lowerBody === LowerBody.CLOVEN_HOOFED_2;
			}
		)
	}

	
	
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

			if (doOutput) outputText(desc);
			if (player.hasStatusEffect(StatusEffects.HydraTailsPlayer)) player.removeStatusEffect(StatusEffects.HydraTailsPlayer);
			player.legCount = 2;
			if (player.lowerBody == LowerBody.MELKIE || player.lowerBody == LowerBody.NAGA) player.lowerBody = LowerBody.HUMAN;
		},
		// is present
		function (): Boolean {
			return player.legCount === 2;
		}
	);

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
			else desc += "Your lower body seizes, causing you to stagger and fall to your side. Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow. When it finally stops, <b>you look down to behold your new pair of human legs</b>!\n";

			if (doOutput) outputText(desc);
			if (player.hasStatusEffect(StatusEffects.HydraTailsPlayer)) player.removeStatusEffect(StatusEffects.HydraTailsPlayer);
			player.legCount = 2;
			player.lowerBody = LowerBody.HUMAN;
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.HUMAN && player.legCount === 2;
		}
	);

	public const LowerBodySnake: Transformation = new SimpleTransformation("Snake Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";

			// Doesn't support tails
			TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

			if (player.lowerBody == LowerBody.SCYLLA) {
				desc += "You collapse as your tentacle legs starts to merge and the pain is immense. Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience.\n\nOnce you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's.";
			} else {
				TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyBipedal, doOutput);

				desc += "You find it increasingly harder to keep standing as your legs start feeling weak. You swiftly collapse, unable to maintain your own weight. Trying to get back up, you realize that the skin on the inner sides of your thighs is merging together like it was being sewn by an invisible needle. The process continues through the length of your [legs], eventually reaching your [feet].\n\nJust when you think that the transformation is over, you find yourself pinned to the ground by an overwhelming sensation of pain. You hear the horrible sound of your bones snapping, fusing together and changing into something else while you contort in unthinkable agony.\n\n"+
						"Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terribleexperience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's.\n\n";
			}
			desc += "Wondering what happened to your sex, you pass your hand down the front of your body until you find a large, horizontal slit around your pelvic area, which contains all of your sexual organs.";
			if (player.hasBalls() && player.ballSize > 10) {
				desc += " You're happy not to have to drag those testicles around with you anymore.";
			}
			desc += " But then, scales start to form on the surface of your skin, slowly becoming visible, recoloring all of your body from the waist down in a snake-like pattern. The feeling is... not that bad actually, kind of like callous, except on your whole lower body.\n\nThe transformation complete, you get up, standing on your newly formed snake tail. You can't help feeling proud of this majestic new body of yours.";

			if (doOutput) outputText(desc);
			player.legCount = 1;
			player.lowerBody = LowerBody.NAGA;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.NAGA));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.NAGA;
		},
		// is possible
		function (): Boolean {
			return player.faceType == Face.SNAKE_FANGS && player.lowerBody != LowerBody.NAGA && player.lowerBody != LowerBody.HYDRA;
		}
	);

	public const LowerBodyDemonHighHeels: Transformation = new SimpleTransformation("Demon High Heels Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";

			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

			desc += "Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your [feet]. Something hard breaks through your sole from the inside out. The pain slowly diminishes and your eyes look along a human leg to a thin and sharp horns protruding from the heel. When you relax, your feet are pointing down and their old posture is only possible with an enormous effort. <b>Your feet are now formed into demonic high-heels.</b> Tentatively you stand up and try to take a few steps. To your surprise you feel as if you were born with this and stride vigorously forward, hips swaying.";

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
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

			if (doOutput) outputText(desc);
			player.lowerBody = LowerBody.DEMONIC_CLAWS;
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

			if (doOutput) outputText(desc);
			player.lowerBody = LowerBody.BEE;
			player.legCount = 2;
			if (!InCollection(player.chitinColor2, "black","ebony")){
				player.chitinColor2 = randomChoice("black","ebony");
			}
			if (player.chitinColor1 != "yellow"){
				player.chitinColor1 = "yellow";
			}
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.BEE));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.BEE;
		}
	);

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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.HARPY;
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

			if (player.lowerBody == LowerBody.ANT) {
				desc += "Feeling as though something is crawling down your legs, you glance down and realize the chitin covering your hips drops to only cover up to your thighs. ";
				if (!player.chitinColor2 == "black") desc += "You also realize that the color changes to black. ";
				desc += "<b>You now have human-like legs covered in a black, arachnid exoskeleton.</b>"
			}
			else desc += "Starting at your [feet], a tingle runs up your [legs], not stopping until it reaches your thighs. From the waist down, your strength completely deserts you, leaving you to fall hard on your [butt] in the dirt. With nothing else to do, you look down, only to be mesmerized by the sight of black exoskeleton creeping up a perfectly human-looking calf. It crests up your knee to envelop the joint in a many-faceted onyx coating. Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton. From a distance it would look almost like a black, thigh-high boot, but you know the truth. <b>You now have human-like legs covered in a black, arachnid exoskeleton.</b>";

			if (doOutput) outputText(desc);
			player.chitinColor2 = "black";
			player.lowerBody = LowerBody.CHITINOUS_SPIDER_LEGS;
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

			desc += "You find yourself suddenly paralyzed below the waist. Your dark, reflective legs splay out and drop you flat on your back. Before you can sit up, you feel tiny feelers of pain mixed with warmth and tingling running through them. Terrified at the thought of all the horrible changes that could be wracking your body, you slowly sit up, expecting to find yourself turned into some incomprehensible monstrosity from the waist down. As if to confirm your suspicions, the first thing you see is that your legs have transformed into eight long, spindly legs. Instead of joining directly with your hips, they now connect with the spider-like body that has sprouted in place of where your legs would normally start.\n\n"+
					" Your abdomen has gotten even larger as well. Once the strength returns to your new, eight-legged lower body, you struggle up onto your pointed 'feet', and wobble around, trying to get your balance. As you experiment with your new form, you find you're even able to twist the spider half of your body down between your legs in an emulation of your old, bipedal stance. That might prove useful should you ever want to engage in 'normal' sexual positions, particularly since your [butt] is still positioned just above the start of your arachnid half. <b>You're now a drider.</b>";

			if (doOutput) outputText(desc);
			player.legCount = 8;
			player.chitinColor2 = "black";
			player.lowerBody = LowerBody.DRIDER;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.DRIDER));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.DRIDER;
		}
	);

	public const LowerBodyOni: Transformation = new SimpleTransformation("Oni Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";

			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

			desc += "The skin on your legs feels like it's burning as a whole set of intricate warlike tattoos covers them. Furthermore, your toenails become increasingly pointed turning black just like a set of claws. Well, it seems you will have get used to your <b>war tattooed legs and feet topped with sharp nails.</b>";

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.ONI;
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.ELF;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.ELF));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.ELF;
		}
	);

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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.RED_PANDA;
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.ORC;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.ORC));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.ORC;
		}
	);

	public const LowerBodyCentipede: Transformation = new SimpleTransformation("Centipede Lower Body",
		// apply effect
		function (doOutput: Boolean): void {//TODO Metamorph
			var desc: String = "";

			// Doesn't support tails
			TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

			desc += "Pain shoots through your legs as you stumble to the ground. You can feel the bones in your legs fuse and reshape themselves as they become longer. As the initial pain passes you manage to sit up and look at what happened to you. To your shock or maybe even horror, in place of legs you now have the long, segmented, insectoid body of a centipede. It's easily three times the length as you are tall. Each segment has a pair of pointed spindly legs which will make walking interesting to say the least. At the very end of your insectoid body sits a pair of longer legs that appear to be a set of stingers. You get up to try out your new body. At first you nearly face plant into the ground as you attempt to coordinate your many legs all at once. After some practice you're able to move your new legs in sync and independently with little issue, even enjoying the feeling of curling into yourself. <b>You think you'll have some fun with this new centipede body.</b>";

			if (doOutput) outputText(desc);
			player.legCount = 100;
			player.lowerBody = LowerBody.CENTIPEDE;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.CENTIPEDE));
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.WENDIGO;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.WENDIGO));
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.YUKI_ONNA;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.YUKI_ONNA));
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.PLANT_ROOT_CLAWS;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.PLANT_ROOT_CLAWS));
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.PLANT_HIGH_HEELS;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.PLANT_HIGH_HEELS));
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

			if (doOutput) outputText(desc);
			player.legCount = 12;
			player.lowerBody = LowerBody.PLANT_FLOWER;
			Metamorph.unlockMetamorphEx(LowerBodyMem.getMemory(LowerBodyMem.ALRAUNE));
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
			if (player.hasVagina())
				outputText("[pg]The internal walls of your [vagOrAss] feel a tingly wave of strange tightness.  Experimentally, you slip a few fingers, then your hand, then most of your forearm inside yourself.  <b>It seems you're now able to accommodate just about ANYTHING inside your body.</b>");

			player.tallness -= 3 + rand(2);
			if (player.basetallness < 36) {
				player.tallness = 36;
			}
			if (doOutput) outputText(desc);
			player.legCount = 1;
			player.lowerBody = LowerBody.GOO;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.GOO));
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.FERRET;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.FERRET));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.FERRET;
		},
		// is possible
		function (): Boolean {
			return player.isGooSkin() && player.arms.type == Arms.GOO && player.lowerBody != LowerBody.GOO;
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
			if (player.gender == Gender.GENDER_FEMALE) desc += " Looking for your privates you notice your pussy is right under your 8 legs just like the center of a fleshy flower and became huge like a mouth ready to engulf anything.";
			else if (player.gender == Gender.GENDER_HERM) desc += " Looking for your privates you notice your pussy is right under your 8 legs just like the center of a fleshy flower and became huge like a mouth ready to engulf anything and your cock is right between your 2 front 'legs' looking almost like another tentacle.";
			else if (player.gender == Gender.GENDER_MALE) desc += " Looking for your privates you notice your cock is right between your 2 front 'legs' looking almost like another tentacle.";
			desc += " As you lift yourself standing on your tentacles not only can you still walk somewhat but heck don't you feel like grabbing something and squeezing it in your pleasurable new legs!";

			if (doOutput) outputText(desc);
			transformations.GillsInTentacleLegs.applyEffect(false);
			player.legCount = 8;
			player.lowerBody = LowerBody.SCYLLA;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.SCYLLA));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.SCYLLA;
		},
		//is possible
		function (): Boolean {
			return !InCollection(player.lowerBody, LowerBody.SCYLLA, LowerBody.KRAKEN, LowerBody.NAGA, LowerBody.HYDRA, LowerBody.CLOVEN_HOOFED);
		}
	);

	public const LowerBodyKraken: Transformation = new SimpleTransformation("Kraken Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";

			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyScylla, doOutput);

			// Doesn't support tails
			TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

			TransformationUtils.applyTFIfNotPresent(transformations.GillsNone, doOutput);

			desc += "Something in your tentacle legs shifts as additional limbs grow. You look down to discover two larger tentacles have grown along your eight legs. <b>They look similar to the ones a kraken might have.</b>";

			if (doOutput) outputText(desc);
			transformations.GillsInTentacleLegs.applyEffect(false);
			player.legCount = 10;
			player.lowerBody = LowerBody.KRAKEN;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.KRAKEN));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.KRAKEN;
		},
		// is possible
		function (): Boolean {
			return player.lowerBody == LowerBody.SCYLLA;
		}
	);

	public const LowerBodyHydra: Transformation = new SimpleTransformation("Hydra Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";

			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodySnake, doOutput);

			// Doesn't support tails
			TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

			desc += "\nWith a ripping sound your tail suddenly begins to tear apart, splitting from the junction just below your thigh level into two segments as if cut by a scalpel. Pain doubles up as bones snaps, your tail tip growing into larger bulbs which a few second later turns into snake heads hissing loudly and mirroring your pain as blood seeps out of the wound. Finally, the wound left by the splitting of your tail closes at high speed, filling in with new flesh and muscle as your newly acquired hydra regeneration kicks in. <b>You snake tail is now forked with two hydra heads!</b>";

			if (!player.hasPerk(PerkLib.HydraRegeneration)) player.createPerk(PerkLib.HydraRegeneration, 0, 0, 0, 0);
			player.createStatusEffect(StatusEffects.HydraTailsPlayer, 2, 0, 0, 0);

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.HYDRA;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.HYDRA));
			Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.HYDRA));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.HYDRA;
		}
	);

	public const LowerBodyAvian: Transformation = new SimpleTransformation("Avian Lower Body",
		// apply effect
		function (doOutput: Boolean): void {//TODO Metamorph
			var desc: String = "";

			if (player.isGoo()) {
				desc += "Trying to advance, you see your goo pseudopod stuck on the ground. Reaching around to look for the cause, you’re surprised to find the goo solidifying, turning into flesh and skin before your eyes.Bones occupy their places on your new legs and feet, and the excess goo evaporates, leaving you with a duo of fully functional, normal legs.\n\nBut, the changes continue as your rearranged pair of feet feel strangely tired, so you sit down and let them rest.  As you shift your attention to them, your toes reshape again, four of them remaining in the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.\n\nThe rest of your legs change too, [feather color]-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>";
			} else if (player.isTaur()) {
				desc += "An strange sensation overcomes your front legs, and even before you realize it, you found them receding on your body! Standing against a rock to not fall at this change to a more bipedal posture, you contemplate how your spine rearranges itself, and soon, you’re left with the usual set of two legs and a standing spine.\n\nBut, the changes continue as your rearranged pair of feet feel strangely tired, so you sit down and let them rest.  As you shift your attention to them, you realize that they are changing. Before your eyes, your hooves seem to recede, turning back into regular human feet. They don’t last long, though, as your toes reshape again, four of them remaining in the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.\n\n"+
						"The rest of your legs change too, [feather color]-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>\n\nYour tail splits in two, and eventually reshapes into the more familiar form of two legs. These are far different from the ones that you expected, however; instead of the usual human legs, these have an array of small, shiny golden scales from the knee down, with [feather color]-colored feathers taking over the area between your knees and crotch, looking not unlike a bird’s.\n\nYour toes are unusually shaped, too; four of them are in the front, and one of them is on the back of each foot. The toenails have become sharp, menacing talons, best used for snatching prey and the occasional unwilling partner. Looks like <b>you have a new set of avian legs!</b>";
			} else if (player.lowerBody == LowerBody.MELKIE) desc += "Your body straightens and telescopes suddenly and without the length of your seal half to anchor you, you're left with your face in the dirt.  A shuffling and scraping of falling scales sounds and a terrible cramp takes you as your back half continues migrating, subducting under your [butt] and making you feel extremely bloated. As your once prominent tail dwindles to roughly the length of your torso, a sickly ripping noise fills your head and it bursts apart, revealing two new bird like legs wish sharp claws! Looks like <b>you have a new set of avian legs!</b";
			else if (player.isScylla()) {
				desc += "An strange sensation overcomes your " + player.legCount + " tentacles, and even before you realize it, you found that " + (player.legCount - 2) + " of them are receding on your body! Not only that, the ones that remain normal are reshaping themselves into something resembling more an average set of legs. Standing against a rock to not fall at this change to a more bipedal posture, you contemplate how your spine rearranges itself, and soon, you’re left with the usual set of two legs and a standing spine.\n\nBut the changes continue, as your rearranged pair of feet feel strangely tired, so you sit down and let them rest, noticing that you’ve now a set of human-looking feet. They don’t last that way long, though, as your toes reshape again, four of them remaining in the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.\n\n"+
						"The rest of your legs change too, [feather color]-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>";
			} else if (player.isAlraune()) {
				desc += "Trying to advance, you see your floral appendage stuck on the ground. Reaching around to look for the cause, you’re surprised to find the verdant foliage decaying, leaving behind mellified shapes that turn quickly into flesh and skin before your eyes.Bones occupy their places on your new legs and feet, and the excess goo evaporates, leaving you with a duo of fully functional, normal legs.\n\nBut, the changes continue as your rearranged pair of feet feel strangely tired, so you sit down and let them rest.  As you shift your attention to them, your toes reshape again, four of them remaining in the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.\n\n"+
						"The rest of your legs change too, [feather color]-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>";
			} else if (player.lowerBody == LowerBody.HOOFED) {
				desc += "Your feet feel strangely tired, so you sit down and let them rest.  As you shift your attention to them, you realize that they are changing. Before your eyes, your hooves seem to recede, turning back into regular human feet. They don’t last long, though, as your toes reshape again, four of them remaining in the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.\n\nThe rest of your legs change too, [feather color]-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>";
			} else if (player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS) {
				desc += "Your feet feel strangely tired, so you sit down and let them rest. As you shift your attention to them, you realize that they are changing. The skin below your knees grows an array of small, shiny golden scales and your demonic high-heels recede into your body. Your toes reshape, four of them remaining in the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.\n\nThe rest of your legs change too, [feather color]-colored feathers sprouting all over the area between your knees and crotch, giving them a more avian visage. Looks like <b>you have a new set of avian legs!</b>";
			} else {
				desc += "Your [feet] feel strangely tired, so you sit down and let them rest. As you shift your attention to them, you realize that they are changing. The fur on them below your knees falls off, but is quickly replaced by an array of small, shiny golden scales. Your toes reshape, four of them remaining in the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.";
				desc += "The rest of your legs change too, [feather color]-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage. Looks like <b>you have a new set of avian legs!</b>";
			}

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.AVIAN;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.AVIAN));
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

			desc += "Whoa! Something weird is happening with your legs and without warning, you trip over in confusion. You check to see what the hell is going on, and to your complete surprise, you discover your legs have been replaced by what looks like a seal tail. Just as you ponder in utter confusion and annoyance how you will move on land your vaginal hole opens wide like a suit, letting your two very human legs slide out. Wait what? You got a tail and human legs yet both feels like they are part of the same body. Well, at least you now know where your privates had gone to, though you’re still surprised to discover you have two labia with one between your two human legs. Having a cock slide through both at the same time should feel extra pleasurable. "+
					"Well, you guess you won’t have trouble walking overland or swimming in the depth of the icy sea with your <b>brand new Melkie tail. Heck, it seems you can get rid of your human legs at will and be a mermaid full time if you want.</b>";

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.MELKIE;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.MELKIE));
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

			if (doOutput) outputText(desc);
			player.furColor = "black";
			player.lowerBody = LowerBody.USHI_ONI;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.USHI_ONI));
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.MOUSE;
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

			desc += "Your legs grow increasingly hot until suddenly they light up and start blazing, just like your tail. Well, wow! Kicking with these is sure to pack an extra punch. The fur under your fiery coat doesn’t seem to burn either, but you're pretty sure anything that gets a kick from your legs is in for a painful experience. <b>You now have blazing mouse legs!</b>";

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.HINEZUMI;
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.YETI;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.YETI));
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.GHOST;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.GHOST));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.GHOST;
		}
	);

	public const LowerBodyJiangshi: Transformation = new SimpleTransformation("Jiangshi Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";

			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

			desc += "A numbing sensation crawls upwards from your feet to your thighs, lingering for a few moments. As the pain subsides, you realize to your horror that your legs have become incorporeal!";

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.JIANGSHI;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.JIANGSHI));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.JIANGSHI;
		}
	);

	public const LowerBodyGhost2: Transformation = new SimpleTransformation("Ghost 2 Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";

			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

			desc += "A numbing sensation crawls upwards from your feet to your thighs, lingering for a few moments. As the pain subsides, you realize to your horror that your feet have become merged… and incorporeal! You drop on your butt… or so you expect. You feel like you are standing, yet you are severely lacking in actual legs. Regardless, you need to get used to your  <b>brand new ghastly lower body!</b>";

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.GHOST_2;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.GHOST_2));
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.GAZER;
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

			desc += "You find it increasingly harder to keep standing as your legs start feeling weak. You swiftly collapse, unable to maintain your own weight.\n\nTrying to get back up, you realize that the skin on the inner sides of your thighs is merging together like it was being sewn by an invisible needle. The process continues through the length of your legs, eventually reaching your feet. Just when you think that the transformation is over, you find yourself pinned to the ground by an overwhelming sensation of pain. "+
					"You hear the horrible sound of your bones changing into something else or disintegrating while you contort in unthinkable agony. Sometime later you feel the pain began to ease and you lay on the ground, spent by the terrible experience. Once you feel you’ve recovered, you try to stand, but to your amazement you discover that you no longer have legs: the bottom half of your body is united in a large wide lump, ending into a point. It’s not that your bones were altered but it’s that everything below your waist was converted to muscle mass like that of an invertebrate. Your spine now reaches all the way up to your waist and ends at your thigh where it vanishes fully.\n\n"+
					"Wondering what happened to your sex, you pass your hand down the front of your body until you find a large, horizontal slit around your pelvic area, which contains all of your sexual organs. Your underbelly begins to sweat profusely so much that it becomes glistening, your fat tail shining wetly as the ground beneath you gets covered with your viscous sticky fluids. Your underbody feels and looks like that of a slug or a snail and come to think of it it might just be exactly that. <b>Your lower body is now a snail tail.</b>";

			if (doOutput) outputText(desc);
			TransformationUtils.applyTFIfNotPresent(transformations.TailNone, false);
			player.legCount = 1;
			player.lowerBody = LowerBody.FIRE_SNAIL;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.FIRE_SNAIL));
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
			if (player.hasBalls() && player.ballSize > 10) desc += " You're happy not to have to drag those testicles around with you anymore.";
			if (!player.hasCoatOfType(Skin.DRAGON_SCALES) && (!InCollection(player.scaleColor1, wyrmCoatColor))) {
				player.scaleColor = randomChoice(wyrmCoatColor);
			}
			desc += " But then, [scale color] armored scales start to form on the surface of your skin, slowly becoming visible, recoloring all of your body from the waist down in a snake-like pattern. The feeling is... not that bad actually, kind of like callous, except on your whole lower body. The transformation complete, you get up, standing on your newly formed snake tail. You can't help feeling proud of this majestic new body of yours. This said, it doesn't end there as warm snowy white fur covers up the scale up to your thigh area, seems you are dressed for the winter now. <b>You now have a long, warm and fluffy frost wyrm tail.</b>";

			if (doOutput) outputText(desc);
			player.legCount = 1;
			player.lowerBody = LowerBody.FROSTWYRM;
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
				dynStats("lus", -30, "scale", false);
				fatigue(5);
			} else if (player.lowerBody == LowerBody.MELKIE) {
				desc += "Your body straightens and telescopes suddenly and without the length of your seal half to anchor you, you're left with your face in the dirt.  A shuffling and scraping of falling scales sounds and a terrible cramp takes you as your back half continues migrating, subducting under your [butt] and making you feel extremely bloated.  As your once prominent tail dwindles to roughly the length of your torso, a sickly ripping noise fills your head and it bursts apart, revealing two new legs covered in fur!  You examine the fuzzy legs and long-toed, sensitive feet.  <b>Looks like you now have raccoon hind-paws...</b> and an upset stomach.";
				dynStats("lus", -30, "scale", false);
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
				if ((player.lowerBody == LowerBody.HUMAN || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.PLANT_HIGH_HEELS) && !player.isFurCovered()) desc += "The sensation of walking around on what feels like a second pair of hands is so weird that you miss noticing the itchy fur growing in over your legs... <b>You now have raccoon paws!</b>";
			}

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.RACCOON;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.RACCOON));
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.SQUIRREL;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.SQUIRREL));
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.KANGAROO;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.KANGAROO));
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

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.CAVE_WYRM;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.CAVE_WYRM));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.CAVE_WYRM;
		}
	);

	public const LowerBodyBunny: Transformation = new SimpleTransformation("Bunny Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";

			//Taurs
			if (player.isTaur()) desc += "Your quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of fur-covered rabbit feet</b>!";
			//Non-taurs
			else {
				desc += "Numbness envelops your [legs] as they pull tighter and tighter.  You overbalance and drop on your [ass]";
				if (player.tailType > Tail.NONE) desc += ", nearly smashing your tail flat";
				else desc += " hard enough to sting";
				desc += " while the change works its way through you.  Once it finishes, <b>you discover that you now have fuzzy bunny feet and legs</b>!";
			}

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.BUNNY;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.BUNNY));
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
				desc += "Numbness envelops your [legs] as they pull tighter and tighter.  You overbalance and drop on your [ass]";
				if (player.tailType > Tail.NONE) desc += ", nearly smashing your tail flat";
				else desc += " hard enough to sting";
				desc += " while the change works its way through you.  Once it finishes, <b>you discover that you now have fuzzy bunny feet and legs tipped with deadly dragon claws just like a jabberwocky!</b>!";
			}

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.JABBERWOCKY;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.JABBERWOCKY));
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

			if (doOutput) outputText(desc);
			player.coatColor = "reddish-orange";
			player.legCount = 2;
			player.lowerBody = LowerBody.CRAB;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.CRAB));
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

			if (doOutput) outputText(desc);
			player.legCount = 6;
			player.lowerBody = LowerBody.CANCER;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.CANCER));
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

			if (doOutput) outputText(desc);
			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodySpider, false);
			player.chitinColor = "midnight purple";
			player.chitinColor2 = "";
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
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.ATLACH_NACHA));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.ATLACH_NACHA;
		}
	);

	public const LowerBodyAnt: Transformation = new SimpleTransformation("Ant Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";
			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

			if (player.lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS) desc += "Feeling as though something is crawling up your legs, you glance down and realize the chitin covering your thighs rises to also cover up to your hips. <b>You now have human-like legs covered in a shiny, ant-like exoskeleton.</b>";
			else desc += "Starting at your [feet], a tingle runs up your [legs], not stopping until it reaches your hips. From the waist down, your strength completely deserts you, leaving you to fall hard on your [butt] in the dirt. With nothing else to do, you look down, only to be mesmerized by the sight of shiny exoskeleton creeping up a perfectly human-looking calf. It crests up your knee to envelop the joint in a many-faceted coating. Then, it resumes its slow upward crawl, not stopping until it has girded your hips in shiny exoskeleton. <b>You now have human-like legs covered in a shiny, ant-like exoskeleton.</b>";

			if (doOutput) outputText(desc);
			player.lowerBody = LowerBody.ANT;
			player.legCount = 2;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.ANT));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.ANT && player.legCount === 2;
		}
	);

	public const LowerBodyTiny: Transformation = new SimpleTransformation("Tiny Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

				desc += "Your legs and feet shrink till they are almost comically small and can barely support your frame";

				if (doOutput) outputText(desc);
				player.legCount = 2;
				player.lowerBody = LowerBody.TINY;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.TINY));
			},
			// is present
			function (): Boolean {
				return player.lowerBody === LowerBody.TINY && player.legCount === 2;
			}
	);

	public const LowerBodyWorm: Transformation = new SimpleTransformation("Worm Lower Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				// Doesn't support tails
				TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

				player.chitinColor = "pink";

				if (doOutput) outputText(desc);
				player.legCount = 1;
				player.lowerBody = LowerBody.SANDWORM;
			},
			// is present
			function (): Boolean {
				return player.lowerBody === LowerBody.SANDWORM;
			}
	);
	
	public const LowerBodyYgddrasilRootClaws: Transformation = new SimpleTransformation("Ygddrasil Root Claws Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";
			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

			desc += "You lose your balance and fall to the ground as your feet begin to contort. You watch as your roots rearrange into a more solid configuration. <b>Your roots have assumed the form of three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.</b>";

			if (doOutput) outputText(desc);
			player.lowerBody = LowerBody.YGG_ROOT_CLAWS;
			player.legCount = 2;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.YGG_ROOT_CLAWS));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.YGG_ROOT_CLAWS && player.legCount === 2;
		}
	);
	
	public const LowerBodyAbyssalShark: Transformation = new SimpleTransformation("Abyssal Shark Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";
			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

			desc += "You feel your [feet] tingle, and you can only watch as they morph into a webbed, reptilian-like form. With all this webbing between your toes, it'll surely help you swim even faster, right? Before you have time to dwell on the thought, a torrent of sweat begins streaming from your forehead as you gasp and swallow for air, panting loudly. ";
			desc += "The area around your hips shifts a"+(player.isNaked()?"s you can only endure and watch your body more as fin-like protrusions rise from your thighs":"bout as you hastily remove your [armor] with just enough time before fin-like protrusions rise from your thighs")+". You examine your hips warily, touching the fins that jut from your thighs lightly. They're firm and dense, but flexible as you'd expect. You think about how difficult it may be to restructure apparel to fit your new body.";
			if (player.isNaked()) desc += " Though, perhaps that's the least of your concerns.";
			desc += " <b>You now have webbed abyssal shark feet!</b>";

			if (doOutput) outputText(desc);
			player.lowerBody = LowerBody.ABYSSAL_SHARK;
			player.legCount = 2;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.ABYSSAL_SHARK));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.ABYSSAL_SHARK && player.legCount === 2;
		}
	);
	
	public const LowerBodyWereshark: Transformation = new SimpleTransformation("Wereshark Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";
			// Doesn't support tails
			TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

			desc += "You feel your [feet] tingle, and you can only watch as they morph into a webbed, reptilian-like form. With all this webbing between your toes, it'll surely help you swim even faster, right? Before you have time to dwell on the thought, a torrent of sweat begins streaming from your forehead as you gasp and swallow for air, panting loudly. Whoa! Something weird is happening with your legs... Without warning, you trip over, stumbling in confusion as your legs fail you. ";
			desc += "You check to see what is going on; you discover your legs have been replaced by what appears to be a shark tail. You idly ponder on the possibility of moving on land now, but as it turns out, your new muscles are powerful enough to simply propel yourself through the sheer power of throwing your body forward and jumping. Well, you guess you won’t have trouble hopping around overland or swimming in the depths of the sea with your <b>brand-new wereshark tail.</b>";

			if (doOutput) outputText(desc);
			player.lowerBody = LowerBody.WERESHARK;
			player.legCount = 1;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.WERESHARK));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.WERESHARK;
		}
	);

	public const LowerBodyArigean: Transformation = new SimpleTransformation("Arigean lower body",
		// apply effect
		function (doOutput: Boolean): void {
			if (doOutput) {
				// No special text outside the event
			}
			player.lowerBody = LowerBody.ARMORED_LEGS;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.ARIGEAN));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.ARMORED_LEGS;
		}
	);

	public const LowerBodyDemonGracefulFeet: Transformation = new SimpleTransformation("Demon Graceful Feet Lower Body",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "";

			TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);

			desc += "Something in your legs suddenly shifts and you fall over, losing balance. Standing up you realize the way you walk has changed dramatically. While your nails elongate a little taking on a demonic claw-like appearance the real change is the seductive grace in your steps which is nothing short of supernatural. Those legs belong on a succubus confidant and sure of her ability to seduce anything and anyone. <b>You now have graceful demonic feet.</b>";

			if (doOutput) outputText(desc);
			player.legCount = 2;
			player.lowerBody = LowerBody.DEMONIC_GRACEFUL_FEET;
			Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.DEMONIC_GRACEFUL_FEET));
		},
		// is present
		function (): Boolean {
			return player.lowerBody === LowerBody.DEMONIC_GRACEFUL_FEET;
		}
	);

	public const LowerBodyMoth: Transformation = new SimpleTransformation("Moth lower body",
			// apply effect
			function (doOutput: Boolean): void {
				if (doOutput) {
					var desc: String = "";

					desc += "Your legs begin to itch as you scratch at them, eventually you look over and discover your legs are now covered in a bell bottom like fuzzy mass. <b>You now have Moth Legs</b>";

					if (doOutput) outputText(desc);
					player.legCount = 2;
				}
				player.lowerBody = LowerBody.MOTH;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.MOTH));
			},
			// is present
			function (): Boolean {
				return player.lowerBody === LowerBody.MOTH;
			}
	);

	public const LowerBodyTroll: Transformation = new SimpleTransformation("Troll lower body",
			// apply effect
			function (doOutput: Boolean): void {
				if (doOutput) {
					var desc: String = "";

					TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);
					desc += "You can feel your toes start to merge together and you look down to notice a coat of fur now covering your feet. <b>You now have troll feet!</b>";

					if (doOutput) outputText(desc);
					player.legCount = 2;
				}
				player.lowerBody = LowerBody.TROLL;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.TROLL));
			},
			// is present
			function (): Boolean {
				return player.lowerBody === LowerBody.TROLL;
			}
	);

	public const LowerBodyGlacialTroll: Transformation = new SimpleTransformation("Glacial Troll lower body",
			// apply effect
			function (doOutput: Boolean): void {
				if (doOutput) {
					var desc: String = "";

					TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHuman, doOutput);
					desc += "You can feel your toes start to merge together and you look down to notice a heavy coat of fur now covering your feet. <b>You now have glacial troll feet!</b>";

					if (doOutput) outputText(desc);
					player.legCount = 2;
				}
				player.lowerBody = LowerBody.GLACIAL_TROLL;
				Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.GLACIAL_TROLL));
			},
			// is present
			function (): Boolean {
				return player.lowerBody === LowerBody.GLACIAL_TROLL;
			}
	);
	
	/*
  */
}
}