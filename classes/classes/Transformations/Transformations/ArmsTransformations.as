package classes.Transformations.Transformations {
import classes.BodyParts.*;
import classes.GeneticMemories.ArmsMem;
import classes.Items.MutationsHelper;
import classes.Scenes.Metamorph;
import classes.Transformations.*;

/**
 * Base class for transformation events.
 */
public class ArmsTransformations extends MutationsHelper {
	/*
    *		 █████	██████	███		 ███ ███████
    *		██	 ██ ██	 ██ ████	████ ██
    *		███████ ██████	██  ████  ██ ███████
    *		██	 ██ ██	 ██ ██	 ██	  ██      ██
    *		██	 ██ ██	 ██ ██		  ██ ███████
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
					case Arms.RACCOON:
					case Arms.RAIJU_PAWS:
					case Arms.CANINE:
						desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' [fur color] fur is flaking away, leaving [skin base.type] behind. Also the claws on your fingers reverts back into ordinary nails.";
						break;
					case Arms.DISPLACER:
						desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' [fur color] fur is flaking away, leaving [skin base.type] behind. Also the claws on your fingers reverts back into ordinary nails.\n\nYou feel highly uncomfortable as your extra set of arms vanishes into your body following the loss of your leonine paw hands. Guess your back with only two arms now.";
						break;
					case Arms.ELF:
					case Arms.DEMON:
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
						desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' vines are withering. Leaves also falling down, leaving [skin base.type] behind.";
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
						desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' chitinous covering is flaking away and scythe shrinking until it vanish completely. The glossy green coating is soon gone, leaving [skin base.type] behind.";
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
					case Arms.ANT:
						desc += "You double over, a sudden pain just below your shoulders. Finding you cannot reach your lower arms to feel at each other, you look down and realize that they're shrinking back into your torso."
						if (!player.isChitinCovered()) desc += " Because you are shocked over your lower arms going away, you don't even notice the carapace of your primary arms softening into [skin coat]."
						break;
					case Arms.MOTH:
						desc += "You double over, a sudden pain just below your shoulders. Finding you cannot reach your lower arms to feel at each other, you look down and realize that they're shrinking back into your torso."
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

				desc += "Your hands suddenly start to tingle as your arms grow a thin layer of [fur color] fur up to your shoulders. You watch, enthralled, as your nails fall off your fingers, feline claws taking their place on your five-fingered hands. That said, they don't look exactly like paws as your hands retain their dexterity and general appearance which is a perfect mix between human and leonine features. Thanks to their shape, your new bestial hands should not hinder your spellcasting abilities.. <b>Your arms are now covered in fur and end with clawed hands like those of a sphinx.</b>";
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

				desc += "Your hands suddenly start to hurt as your arms grows a thick coat of [fur color] fur up to your shoulders where it turns [haircolor]. You watch enthralled as your nails fall off your fingers, feline claws taking their place on your now five-fingered paw-like hands. <b>You now have leonine paw hands.</b>";
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

				desc += "Your hands suddenly start to hurt as your arms grows a thick coat of [fur color] fur up to your shoulders. You watch enthralled as your nails fall off your fingers, feline claws taking their place on your now five-fingered paw-like hands. <b>You now have cat paw hands.</b>";
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

				desc += "Your fingers starts to feels like some bee stings them as they inflates to a more chubby sizes yours nails tickening and darkening turning into clover-like claws. Aside of your now fat finguers and darker claws your arms remains about the same. <b>You now have pig arms.</b>";
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
				desc += "The skin on your arms feels like it’s burning as a whole set of intricate warlike tattoos covers them. Furthermore your nails become increasingly pointed turning black just like a set of claws. Well, it seems you will have issues hiding your <b>war tattooed arms with sharp nails.</b>";
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

				desc += "Something in your hands shift as they change taking on a more feminine fragile yet agile structure. You discover with surprise your dexterity has greatly increased allowing you to manipulate things in your delicate elven fingers with almost unreal precision. However, your grip has become weaker as a result, weakening your ability to use raw force over finesse. <b>You now have delicate elven hands.</b>";
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
				desc += "\nThe transformation end as down the length of your forearms you grow a pair of massive scythe like appendage just like a mantis.";
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

				desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. After ignoring the sensation for a while, you finally glance down in irritation, only to discover that your arms had changed from it's former appearance to that of a dragon, one with leathery scales and short claws replacing your fingernails. <b>You now have draconic arms.</b>";
				player.arms.type = Arms.DRACONIC;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.DRACONIC));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.DRACONIC;
			}
	);

	public const ArmsFeyDraconic: Transformation = new SimpleTransformation("Fey Draconic Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. After ignoring the sensation for a while, you finally glance down in irritation, only to discover that your arms had changed from it's former appearance to that of a dragon, one with leathery scales and short claws replacing your fingernails. <b>You now have fey draconic arms.</b>";
				player.arms.type = Arms.FEY_DRACONIC;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.FEY_DRACONIC));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.FEY_DRACONIC;
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

				player.chitinColor2 = "black";
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
				else if (player.arms.type == Arms.MANTIS) desc += "The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>. Additionally on your upper arms appear yellow fuzz.";
				else {
					if (player.arms.type == Arms.HARPY) desc += "The feathers covering your arms fall away, leaving them to return to a far more human appearance. ";
					desc += "You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>. A moment later the pain fades and you are able to turn your gaze down to your beautiful new arms, covered in shining black chitin from the upper arm down, and downy yellow fuzz along your upper arm.";
				}
				player.arms.type = Arms.BEE;
				if (!InCollection(player.chitinColor2, "black","ebony")){
					player.chitinColor2 = randomChoice("black","ebony");
				}
				if (player.chitinColor1 != "yellow"){
					player.chitinColor1 = "yellow";
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
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.PLANT));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.PLANT;
			}
	);

	public const ArmsPlant2: Transformation = new SimpleTransformation("Plant Arms 2",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You watch, spellbound, while your arms gradually change their entire outer structure into plain human-like form. Soon after you start feel something new tickling and crawling its way into being, this time on your shoulders, working its way down your arms.Looking over them you can see veined, vaguely phallic vines wrapping their way around your entire arm, in a manner that is decorative but oddly perverse. They remind you of the tentacle monsters in the forest...  <b>You now have tentacle-covered arms.</b>";

				player.arms.type = Arms.PLANT2;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.PLANT_2));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.PLANT2;
			}
	);

	public const ArmsCentipede: Transformation = new SimpleTransformation("Centipede Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your arms feel strangely warm. You look down at them, noticing purple markings being etched into your skin. Your nails sharpen and take on the same purple hue. <b>You could do some serious damage with your sharp nails.</b>";

				player.arms.type = Arms.CENTIPEDE;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.CENTIPEDE));
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
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.WENDIGO));
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
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.YUKI_ONNA));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.YUKI_ONNA;
			}
	);

	public const ArmsJiangshi: Transformation = new SimpleTransformation("Jiangshi Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "<b>You now have Jiangshi arms.</b>";

				player.arms.type = Arms.JIANGSHI;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.JIANGSHI));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.JIANGSHI;
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

	public const ArmsHound: Transformation = new SimpleTransformation("Hound Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into dog like claws so no wonder you felt it that much. <b>You now have pawed hands.</b>";

				player.arms.type = Arms.HOUND;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.HOUND));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.HOUND;
			}
	);

	public const ArmsGoo: Transformation = new SimpleTransformation("Goo Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your arms become increasingly wet, as if they were sweating heavily, until eventually you're unsure whether or not they are even solid. The sweat clears up, turning to [color] slime. At first, it feels weird, because they are neither entirely solid or liquid, but the simple act of lengthening your limbs to ridiculous reach amuses you. Furthermore you can see right through your hands as if looking through water. Perhaps there's some use to your <b>new goo dripping arms.</b>";

				player.arms.type = Arms.GOO;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.GOO));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.GOO;
			},
			//is possible
			function (): Boolean {
				return player.arms.type != Arms.GOO;
			}
	);

	public const ArmsHydra: Transformation = new SimpleTransformation("Hydra Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn’t getting rid of the itch. After a longer moment of ignoring it you finally glance down in irritation, only to discover that your arms former appearance changed into that of a reptile with leathery scales and vicious claws replacing your fingernails. <b>You now have hydra arms.</b>";

				player.arms.type = Arms.HYDRA;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.HYDRA));
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

				if (player.skin.isChitinCovered()) {
					desc += "Ughh, was that seed good for your body? You wince in pain, as some part of you is obviously not happy of being subjected to the fruit mysterious properties. As you direct your attention to your arms, you’re alarmed by their increasingly rigid feeling, and, to make things worse, the process continues, as the worrying sensation creeps up your arms until it reaches your shoulders. Soon, no matter how much you try, you aren’t able to move your arms in any way.";
					desc += "Just when you thought that nothing could feel worse, you see how the chitin on your arms fissures, falling to the ground like pieces of a broken vase and leaving a mellified tissue beneath. To you relief, the ‘jelly’ also fall, leaving only normal skin on your arms.";
					desc += "Then, a cloak of soft, [feather color], colored feathers start sprouting from your armpits, covering every bare inch of skin up your elbows, stopping a few inches before your hands. When the growing stops, the skin over your hands changes too, turning into a layer of [skin], skin, albeit rougher than the usual, and made of thousands of diminutive scales. The structure of your palm and fingers remain the same, tough your fingernails turn into short talons.";
				} else if (player.isFurCovered()) {
					desc += "A bit weary about the possible effects of the seed on your body, you quickly notice when the fur covering your starts thickening, some patches merging an thickening, first forming barbs, and then straight-out feathers. To your surprise, your hand and forearms become strangely numb, and, to make things worse, the process continues, as the worrying sensation creeps up your arms until it reaches your shoulders. Soon, no matter how much you try, you aren’t able to move your arms in any way.";
					desc += "The newly formed feathers keep growing making the excess fur fall, until you’ve gained a cloak of soft, [feather colors], colored feathers start sprouting from your armpits, covering every bare inch of skin up your elbows, stopping a few inches before your hands. Once the effects on that area end, the fur over your hands changes too, falling quickly and leaving behind soft, bare skin, that quickly turns into a layer of [skin], skin, ";
					desc += "albeit rougher than the usual, made of thousands of diminutive scales. The structure of your palm and fingers remain the same, though your fingernails turn into short talons.";
				} else if (player.isScaleCovered()) {
					desc += "Undoubtedly affected by the dry fruit reactives, the layer of scales covering your arms falls like snowflakes, leaving only a soft layer of [skin] behind. To your surprise, your hand and forearms become strangely numb, and, to make things worse, the process continues, as the worrying sensation creeps up your arms until it reaches your shoulders. Soon, no matter how much you try, you aren’t able to move your arms in any way.";
					desc += "Then, a cloak of soft, [feather color], colored feathers start sprouting from your armpits, covering every bare inch of skin up your elbows, stopping a few inches before your hands. When the growing stops, the skin over your hands changes too, turning into a layer of [skin], skin, albeit rougher than the usual, and made of thousands of diminutive scales. The structure of your palm and fingers remain the same, though your fingernails turn into short talons.";
				} else {
					desc += "Just after finishing the fruit, your hand and forearms become strangely numb, and, to make things worse, the process continues, as the worrying sensation creeps up your arms until it reaches your shoulders. Soon, no matter how much you try, you aren’t able to move your arms in any way.";
					desc += "Then, a cloak of soft, [feather color], colored feathers start sprouting from your armpits, covering every bare inch of skin up your elbows, stopping a few inches before your hands. When the growing stops, the skin over your hands changes too, turning into a layer of [skin], skin, albeit rougher than the usual, and made of thousands of diminutive scales. The structure of your palm and fingers remain the same, though your fingernails turn into short talons.";
				}
				desc += "Luckily, the sensation returns to your arms, and you’re able to use them with normalcy, with the difference that <b>they’re now avian looking ones!</b>.";

				player.arms.type = Arms.AVIAN;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.AVIAN));
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

				desc += "The skin on your arms change a bit, as the " + player.skin.describe() + " turning into soft, feline fur. Your palms and fingers acquire pink paw pads, while at the end of each one of your fingers, the talons sharpen and become prehensile, adopting a posture better suited to pounce over a unsuspecting victim.";
				desc += "From the fringe on your elbows to your armpits, your " + player.furColor2 + " colored plumage remains the same. <b>At the end, you’ve gotten gryphon-like arms!</b>.";

				player.arms.type = Arms.GRYPHON;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.GRYPHON));
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
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.GHOST));
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

				player.arms.type = Arms.SQUIRREL;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.SQUIRREL));
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

				player.arms.type = Arms.WEASEL;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.WEASEL));
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
				TransformationUtils.applyTFIfNotPresent(transformations.ArmsWeasel, doOutput);

				desc += "Something in your arm bones begins to shift as they suddenly curve and grow awkwardly through the skin, piercing through your fur like a spike. Now juting outside of your wrists like a pair of natural tonfas. the bones begin to reshape, polish and alter itself, fully taking on the consistency of steel! You admire your two Kamaitachi scythes with stupor, they are sharp and hard enough to leave clean deep cuts even in the hardest material and light enough that you can swing them around as if they weren't even there to begin with, lighter than air indeed. Enemies better fear you now that you got those <b>Kamaitachi arm-scythes.</b>";

				player.arms.type = Arms.KAMAITACHI;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.KAMAITACHI));
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
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.RACCOON));
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
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.KRAKEN));
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
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.YETI));
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
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.SEA_DRAGON));
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

				desc += "Your hands suddenly start to hurt as your arms grows a thick coat of [fur color] fur up to your shoulders. You watch enthralled as your nails turn into large ursan claws on your now five-fingered paw-like hands. <b>You now have bear-like paw hands.</b>";

				player.arms.type = Arms.BEAR;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.BEAR));
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

				player.furColor = "black";
				player.arms.type = Arms.USHI_ONI;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.USHI_ONI));
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
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.MELKIE));
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
				player.chitinColor = "midnight purple";
				player.chitinColor2 = "";
				player.arms.type = Arms.SPIDER;
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.SPIDER));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.SPIDER;
			}
	);

	public const ArmsAnt: Transformation = new SimpleTransformation("Ant Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.arms.type == Arms.HARPY) desc += "The feathers covering your arms fall away, leaving them to return to a far more human appearance. You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a shiny carapace</b>.  A second pair has even begun sprouting just underneath, forming these same traits. You touch the exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
				else if (player.arms.type == Arms.BEE) desc += "A second pair of arms starts sprouting underneath your original pair, and the fizz covering your upper arms starting to fall down leaving only four shiny chitin clad arms.";
				else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRACONIC) desc += "A second pair of arms starts sprouting underneath your original pair, and the scales covering your upper arms starting to fall down leaving only four shiny chitin clad arms.";
				else if (player.arms.type == Arms.MANTIS) desc += "The long scythe extending from your wrist crumbling, leaving you with shiny, chitonous but humanoid arms. A second pair then starts to sprout out below";
				else if (player.arms.type == Arms.SPIDER) desc += "There's a sudden swelling below your armpits, and you look to see a second pair of chitinous arms sprouting below your main pair."
				else {
					TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

					desc += "You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a shiny  carapace</b>. A second pair has even begun sprouting just underneath, forming these same traits. You touch the exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
				}

				player.arms.type = Arms.ANT;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.ANT));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.ANT;
			}
	);

	public const ArmsTiny: Transformation = new SimpleTransformation("Tiny Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);
				desc += " Your arms shrink to almost comical proportions as your hands morph to tiny clawed imp hands.";
				desc += " You now have <b>tiny arms</b>!";

				player.arms.type = Arms.TINY;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.TINY));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.TINY;
			}
	);

	public const ArmsCanine: Transformation = new SimpleTransformation("Canine Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into canine like claws so no wonder you felt it that much. <b>You now have pawed hands.</b>";

				player.arms.type = Arms.CANINE;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.CANINE));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.CANINE;
			}
	);
/*
	public const ArmsWerespider: Transformation = new SimpleTransformation("Werespider Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.arms.type == Arms.HARPY) desc += "The feathers covering your arms fall away, leaving them to return to a far more human appearance. You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a shiny carapace</b>.  A second pair has even begun sprouting just underneath, forming these same traits. You touch the exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
				else if (player.arms.type == Arms.BEE) desc += "A second pair of arms starts sprouting underneath your original pair, and the fizz covering your upper arms starting to fall down leaving only four shiny chitin clad arms.";
				else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRACONIC) desc += "A second pair of arms starts sprouting underneath your original pair, and the scales covering your upper arms starting to fall down leaving only four shiny chitin clad arms.";
				else if (player.arms.type == Arms.MANTIS) desc += "The long scythe extending from your wrist crumbling, leaving you with shiny, chitonous but humanoid arms. A second pair then starts to sprout out below";
				else if (player.arms.type == Arms.SPIDER) desc += "There's a sudden swelling below your armpits, and you look to see a second pair of chitinous arms sprouting below your main pair."
				else {
					TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

					desc += "You watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a shiny  carapace</b>. A econd pair has even begun sprouting just underneath, forming these same traits. You touch the exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.";
				}

				player.arms.type = Arms.ANT;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.ANT));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.ANT;
			}
	);*/

	public const ArmsAbyssalShark: Transformation = new SimpleTransformation("Abyssal Shark Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You watch, spellbound as your arms gradually change its entire outer-structure into a plain, almost human-like form, if not for the parts between your fingers forming fresh webbing and your nails sharpening into curved claws. Immediately following this, your begin to sweat profusely as your breathing grows ragged and rapid. ";
				desc += "The space between your elbows begins to shift as you "+(player.isNaked()?"watch":"remove your armor")+" just in time to see strange fin-like structures burst from your forearms. You examine them  carefully. It'd seem any armor you wear will need to adjust to fit within them.";
				if (player.isNaked()) desc += " Perhaps that's not as big of an issue as it could be.";
				desc += " <b>You now have abyssal shark arms.</b>";

				player.arms.type = Arms.ABYSSAL_SHARK;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.ABYSSAL_SHARK));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.ABYSSAL_SHARK;
			}
	);

	public const ArmsArigean: Transformation = new SimpleTransformation("Arigean Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "";

				player.arms.type = Arms.ARMORED_FOREARMS;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.ARIGEAN));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.ARMORED_FOREARMS;
			}
	);

	public const ArmsDemon: Transformation = new SimpleTransformation("Demon Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "A sharp pain runs through your hands as your nail suddenly grows longer and pointier like those of a demon. <b>You now have demonic nails!</b>";
				player.arms.type = Arms.DEMON;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.DEMON));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.DEMON;
			}
	);

	public const ArmsDeer: Transformation = new SimpleTransformation("Deer Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your arms and hands start covering in thin fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into hoof like claws so no wonder you felt it that much. <b>You now have deer arms.</b>";

				player.arms.type = Arms.DEER;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.DEER));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.DEER;
			}
	);

	public const ArmsReindeer: Transformation = new SimpleTransformation("Reindeer Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your arms and hands start covering in thick fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into hoof like claws so no wonder you felt it that much. <b>You now have reindeer arms.</b>";

				player.arms.type = Arms.REINDEER;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.REINDEER));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.REINDEER;
			}
	);
	public const ArmsMoth: Transformation = new SimpleTransformation("Moth Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

				desc += "Your arms begin to itch so you scratch at them, eventually you look over and discover your arms are now covered in a sleeve like fuzzy mass. A second pair has even begun sprouting just underneath, forming these same traits. <b>You now have Moth arms</b>";

				player.arms.type = Arms.MOTH;
				if (doOutput) outputText(desc);
				//Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.REINDEER));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.MOTH;
			}
	);

	public const ArmsSatyr: Transformation = new SimpleTransformation("Satyr Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);

				desc += "Your hands suddenly start to tingle as your arms grow a thin layer of [fur color] fur up to your shoulders. You watch, enthralled, as your nails sharpen to lethal point. You try out your hands at various things discovering that your overall dexterity has also been enhanced. Heck you got some instinctual know-how of how to use a few musical instruments. Must be the whole goat man/woman deal. With hands like those the dream of becoming a skilled musician is easily within your reach. <b>Your arms are now covered in fur and end with sharpened nails like those of a satyr or faun.</b>";
				player.arms.type = Arms.SATYR;

				if (doOutput) outputText(desc);

				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.SATYR));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.SATYR;
			}
	);

	public const ArmsTroll: Transformation = new SimpleTransformation("Troll Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);
				desc += " You feel your fingers tighten as they feel more dexterous. You look down and before you know it you’ve lost a finger, the rest seem slightly bigger now as well. <b>You now have troll arms!</b>!";

				player.arms.type = Arms.TROLL;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.TROLL));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.TROLL;
			}
	);

	public const ArmsGlacialTroll: Transformation = new SimpleTransformation("Glacial Troll Arms",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.ArmsHuman, doOutput);
				desc += " You can feel your nails elongate and sharpen, before you know it you have claws! As this happens they feel more dexterous. You look down and before you know it you’ve lost a finger, the rest seem slightly bigger now as well. <b>You now have glacial troll arms!</b>!";

				player.arms.type = Arms.GLACIAL_TROLL;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(ArmsMem.getMemory(ArmsMem.GLACIAL_TROLL));
			},
			// is present
			function (): Boolean {
				return player.arms.type === Arms.GLACIAL_TROLL;
			}
	);
	/*
  */
}
}
