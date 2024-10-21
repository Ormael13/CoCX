package classes.Transformations.Transformations {
import classes.Transformations.*;
import classes.BodyParts.*;
import classes.GeneticMemories.EarsMem;
import classes.GlobalFlags.kFLAGS;
import classes.Items.MutationsHelper;
import classes.Races;
import classes.Scenes.Metamorph;

/**
 * Base class for transformation events.
 */
public class EarsTransformations extends MutationsHelper {
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
				player.furColor = "midnight";
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

	public const EarsKirin: Transformation = new SimpleTransformation("Kirin Ears",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.ears.type == -1) desc += "Two painful lumps sprout on the top of your head, forming into tear-drop shaped ears, covered with short fur and hard scales. ";
				if (player.ears.type == Ears.HUMAN) desc += "Your ears tug painfully on your face as they begin shifting, turning into sideway animalistic ears. ";
				if (player.ears.type == Ears.DOG) desc += "Your ears change shape, morphing into from their doglike shape into scaly animalistic ears! ";
				else desc += "Your ears change shape, morphing into teardrop-shaped sideway kirin ears! ";
				desc += "<b>You now have kirin ears.</b>";
				player.ears.type = Ears.KIRIN;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.KIRIN));
			},
			// is present
			function (): Boolean {
				return player.ears.type === Ears.KIRIN;
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

				if (player.racialScore(Races.RAIJU, false) >= 5) desc += "Your ears twitch as jolt of lightning flows through them, replacing all sound with crackling pops. You moan as the lightning arcs up to the top of your head before fanning out to the side. Hearing suddenly returns as you run your hands across your <b>new weasel ears!</b>";
				else desc += "Your ears suddenly stretch painfully, making you scream in pain as they move toward the top of your head, growing rounder and bigger. Putting your hands to your ears you discover they are now covered with a fair amount of dark fur. <b>You now have weasel ears.</b>";

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
				player.ears.type = Ears.ORCA2;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.ORCA2));
			},
			// is present
			function (): Boolean {
				return player.ears.type === Ears.ORCA2;
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

	public const EarsInsect: Transformation = new SimpleTransformation("Insect Ears",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Tightness centers on your scalp, pulling your ears down from their normal, fleshy shape into small, chitin lumps with holes in their bottom. <b>You have insect ears!</b>";
				player.ears.type = Ears.INSECT;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.INSECT));
			},
			// is present
			function (): Boolean {
				return player.ears.type === Ears.INSECT;
			}
	);

	public const EarsFox: Transformation = new SimpleTransformation("Fox Ears",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.ears.type == Ears.HUMAN || player.ears.type == Ears.ELFIN || player.ears.type == Ears.LIZARD) desc += "The sides of your face painfully stretch as your ears elongate and begin to push past your hairline, toward the top of your head. They elongate, becoming large vulpine triangles covered in bushy fur. <b>You now have fox ears.</b>";
				else desc += "Your ears change, shifting from their current shape to become vulpine in nature. <b>You now have fox ears.</b>";

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
				if (player.isFurCovered()) desc += " As you examine your new elfin ears you feel fur grow around them, matching the rest of you.";

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
			},
			// is possible
			function (): Boolean {
				return player.ears.type != Ears.WOLF && player.tailType == Tail.WOLF;
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.DOG));
			},
			// is present
			function (): Boolean {
				return player.ears.type === Ears.DOG;
			},
			// is possible
			function (): Boolean {
				return player.ears.type != Ears.DOG && player.tailType == Tail.DOG;
			}
	);

	public const EarsGremlin: Transformation = new SimpleTransformation("Gremlin Ears",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Whoa, something messed up is going about with your ears. They migrate slowly up your head, elongating and distorting as they get covered in [haircolor] fur. When you go check what the hell happened to them you discover instead of human ears you now have a pair of cute animal ears up on your head. Well, these sure will give you a cute look. <b>You now have gremlin ears!</b>";
				player.ears.type = Ears.GREMLIN;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.GREMLIN));
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

				if (player.ears.type != Ears.HUMAN) desc += "Your ears twitch once, twice, before starting to shake and tremble madly. They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, fin like ears just like those of a shark girl.</b>";
				else desc += "A weird tingling runs through your scalp as your [hair] shifts slightly. You reach up to touch and bump <b>your new pointed fin like ears just like those of a shark girl</b>. You bet they look cute!";

				player.ears.type = Ears.SHARK;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.SHARK));
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.BUNNY));
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.AVIAN));
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.GRYPHON));
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.KANGAROO));
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.RAIJU));
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.SQUIRREL));
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.RACCOON));
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.FERRET));
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.YETI));
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.BEAR));
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.PANDA));
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
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.MELKIE));
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
				if (player.ears.type == -1) desc += "Two painful lumps sprout on the top of your head, forming into teardrop shaped ears, covered with short fur.  ";
				if (player.ears.type == Ears.HUMAN) desc += "Your ears tug painfully on your face as they begin shifting, moving upwards to the top of your head and transforming into upright animalistic ears.  ";
				if (player.ears.type == Ears.DOG) desc += "Your ears change shape, morphing into from their doglike shape into deer-like ears!  ";
				if (player.ears.type > Ears.DOG) desc += "Your ears change shape, morphing into teardrop-shaped deer ears!  ";
				desc += "<b>You now have deer ears.</b>";

				player.ears.type = Ears.DEER;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.DEER));
			},
			// is present
			function (): Boolean {
				return player.ears.type === Ears.DEER;
			}
	);

	public const EarsBig: Transformation = new SimpleTransformation("Big Ears",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Whoa, something messed up is going about with your ears. They are elongating and distorting as they grow comically large. When you check on them you discover you now have a pair of oversized pointed ears that tend to move up and down, flapping around when you have a burst of emotion or when you deliver a vengeful spell at the reaction of them being mocked. <b>You now have big ears!</b>";
				player.ears.type = Ears.BIG;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.BIG));
			},
			// is present
			function (): Boolean {
				return player.ears.type === Ears.BIG;
			}
	);

	public const EarsFennecFox: Transformation = new SimpleTransformation("Fennec Fox Ears",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.ears.type == Ears.HUMAN || player.ears.type == Ears.ELFIN || player.ears.type == Ears.LIZARD) desc += "The sides of your face painfully stretch as your ears elongate and begin to push past your hairline, toward the top of your head. They elongate, becoming large and oversized vulpine triangles covered in bushy fur. <b>You now have fennec fox ears.</b>";
				else desc += "Your ears change, shifting from their current shape to become vulpine in nature. <b>You now have fennec fox ears.</b>";

				player.ears.type = Ears.FENNEC_FOX;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.FENNEC_FOX));
			},
			// is present
			function (): Boolean {
				return player.ears.type === Ears.FENNEC_FOX;
			}
	);

	public const EarsJackal: Transformation = new SimpleTransformation("Jackal Ears",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You moan as your ears suddenly become extremely sensitive making you twitch uncontrollably as they migrate toward the top of your head, growing pointier and bigger. Putting your hands to your new ears you discover they are now covered with a fair amount of fur. <b>You now have jackals ears.</b>";

				player.ears.type = Ears.JACKAL;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.JACKAL));
			},
			// is present
			function (): Boolean {
				return player.ears.type === Ears.JACKAL;
			}
	);

	public const EarsTroll: Transformation = new SimpleTransformation("Troll Ears",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your ears prickle and itch as you feel the cartilage shift and contort as your skin is stretched taut. You can feel your ears growing, gaining an acute sense of hearing as fur starts to coat your ears. <b>Your hand reaches up as the transformation stops and you realize that you now have troll ears!</b>";

				player.ears.type = Ears.TROLL;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.TROLL));
			},
			// is present
			function (): Boolean {
				return player.ears.type === Ears.TROLL;
			}
	);

	public const EarsGlacialTroll: Transformation = new SimpleTransformation("Glacial Troll Ears",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your ears prickle and itch as you feel the cartilage shift and contort as your skin is stretched taut. You can feel your ears growing, gaining an acute sense of hearing as a heavy coat of fur starts to coat your ears. <b>Your hand reaches up as the transformation stops and you realize that you now have glacial troll ears!</b>";

				player.ears.type = Ears.GLACIAL_TROLL;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EarsMem.getMemory(EarsMem.GLACIAL_TROLL));
			},
			// is present
			function (): Boolean {
				return player.ears.type === Ears.GLACIAL_TROLL;
			}
	);
	/*
  */
}
}
