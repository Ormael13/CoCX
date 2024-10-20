package classes.Transformations.Transformations {
import classes.BodyParts.*;
import classes.GeneticMemories.EyesMem;
import classes.Items.MutationsHelper;
import classes.Races.GoblinRace;
import classes.Races.GremlinRace;
import classes.Scenes.Metamorph;
import classes.Transformations.*;

/**
 * Base class for transformation events.
 */
public class EyesTransformations extends MutationsHelper {
	/*
*		███████ ██	  ██ ███████ ███████
*		██		 ██  ██	 ██		 ██
*		█████	   ██    ██████	 ███████
*		██		   ██	 ██		      ██
*		███████	   ██	 ███████ ███████
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
	public const EyesJiangshi: Transformation = new SimpleTransformation("Jiangshi Eyes",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.eyes.type == Eyes.BLACK_EYES_SAND_TRAP) {
					desc += "You feel a twinge in your eyes and you blink. It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.";
				} else {
					desc += "You blink and stumble, a wave of vertigo threatening to pull your [feet] from under you. As you steady and open your eyes, you realize something seems different. Your vision is changed somehow.";
					if (player.eyes.type == Eyes.SPIDER) desc += " Your multiple, arachnid eyes are gone!</b>";
					desc += " <b>You have Jiangshi eyes </b>";
				}

				if (doOutput) outputText(desc);
				player.eyes.type = Eyes.JIANGSHI;
			},
			// is present
			function (): Boolean {
				return player.eyes.type === Eyes.JIANGSHI;
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

				TransformationUtils.applyTFIfNotPresent(transformations.EyesRaijuColors, doOutput);

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
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.WEASEL));
			},
			// is present
			function (): Boolean {
				return player.eyes.type === Eyes.WEASEL;
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

	public const EyesFairy: Transformation = new SimpleTransformation("Fairy Eyes",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesHuman, doOutput);

				desc += "You blink and stumble, a wave of vertigo threatening to pull your feet out from under you. As you steady yourself and open your eyes, you realize something seems different. Your vision is changed somehow. Your pupils draw in light and the color and shapes seems more defined even at great distance. Your new eyes granting you better vision. You go to a puddle to check what happened to them and notice <b>your new eyes are like those of an elf’s with a vertical slit that reflects lights.</b>";

				player.eyes.type = Eyes.FAIRY;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.FAIRY));
			},
			// is present
			function (): Boolean {
				return player.eyes.type === Eyes.FAIRY;
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

				desc += "You blink and stumble, a wave of vertigo threatening to pull your [feet] from under you. As you steady and open your eyes, all seems to be fine until at least it seems so. But when moment later, when you casualy look at your hands pondering if there is any other effect the numbing sensation starts to spread starting from your hands fingers. Worried you focus your gaze at them to notice, that they typical texture becoming grey colored much similar to that of... stone? And slowly you realize the more you look at them, the faster change. Panicked for a moment you look away and then this numbing feeling starting to slowly recede. But looking back at them causing it to return. After moment, and closing eyelids, you conclude that your eyes must have gained an useful ability. <b>Your eyes has turned into gorgon eyes.</b>";

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

				desc += "You suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a snake with sinister black sclera that reflect the sorry state of your soul. <b>You now have fiendish snake eyes!</b>.";

				player.eyes.type = Eyes.SNAKEFIENDISH;
				player.eyes.colour = "yellow";
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.SNAKEFIENDISH));
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

				desc += "You gasp in discomfort as your vision troubles and blurr for a moment. You pass your hand to feel for your face and discover to your absolute surprise you can't feel your nose ridge, heck as you poke yourself in the eye and recoil back in surprise. Seems your eyes merged together into one single all encompassing eye like that of some cyclopean creature.\n";

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
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.RATATOSKR));
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

				desc += "You feel something fundamental change in your sight when you go check yourself in a puddle you notice that <b>they now have horizontal slit like those of an octopus.</b>";

				player.eyes.type = Eyes.KRAKEN;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.KRAKEN));
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
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.FIRE_SNAIL));
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
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.FENRIR));
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
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.DEAD));
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

				desc += "Something shift in your eyes as the level of light around you seems to increase. You go to check on what happened and discover your pupils not only changed to reptilian slits but now glow with a neon blue light. Well, seeing in the dark will be easy with your <b>new dark blue iris with reptilian neon blue pupils that glow in the dark.</b>";

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
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.GRYPHON));
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

				desc += "Your eyes feel like they are burning. You try to soothe them, but to no avail. You endure the agony for a few minutes before it finally fades. You look at yourself in the nearest reflective surface and notice your eyes have taken on a goat like appearance with horizontal pupils in the middle, the sclera turning back to white. <b>You now have eyes with horizontal pupils just like those of a goat!</b>";

				player.eyes.type = Eyes.GOAT;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.GOAT));
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
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.BEAR));
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
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.CANCER));
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
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.CENTIPEDE));
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
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.GHOST));
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
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.FIENDISH));
			},
			// is present
			function (): Boolean {
				return player.eyes.type === Eyes.FIENDISH;
			}
	);

	public const EyesFeral: Transformation = new SimpleTransformation("Feral Eyes",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You suddenly stumble holding your head in pain with both hands as a massive headache overtakes you causing you to shortly fall unconscious. In your mind you see something not unlike a terrible beast of fur fang and claws with two green glowing eyes and as you begin to run away it starts chasing you. ";desc += "Catching up to you in no time it pounces on you and you get to watch in terror as it devours you alive! You wake up screaming with vivid memories of the events in your heart and mind. You wash your face in water to try and jare you fully awake when you notice your eyes. Within them a sinister green glow flashes every now and then like that of the now barely contained beast that lurks within your soul fighting to influence you into doing terrible things. <b>You now have the same feral eyes as a wild beast.</b>";

				player.eyes.type = Eyes.FERAL;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.FERAL));
			},
			// is present
			function (): Boolean {
				return player.eyes.type === Eyes.FERAL;
			}
	);

	public const EyesArigean: Transformation = new SimpleTransformation("Arigean Eyes",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.EyesChangeColor(["green"]), false);

				desc += "";

				player.eyes.type = Eyes.ARIGEAN;
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.eyes.type === Eyes.ARIGEAN;
			}
	);

	public const EyesDemon: Transformation = new SimpleTransformation("Demon Eyes",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You blink and stumble, a wave of vertigo threatening to pull your feet out from under you. As you steady yourself and open your eyes, you realize something seems different. Your vision has changed somehow. Your pupils draw in light and the color and shapes seem more defined even at great distance, they are also more vibrant and alive. This new enhanced vision seems to make everything far more arousing to look at. [if (silly) Is this what they call seeing life in pink?] You go to a puddle to check what happened to them and notice <b>your new pupils are like those of a demon's with a vertical slit that reflects the world in new arousing ways</b>";

				player.eyes.type = Eyes.DEMON;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.DEMON));
			},
			// is present
			function (): Boolean {
				return player.eyes.type === Eyes.DEMON;
			}
	);
	public const EyesMoth: Transformation = new SimpleTransformation("Moth Eyes",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "your eyes suddenly feel strange as the world gets blurry on you, eventually your vision returns but the world seems more vivid, you rush over to the lake and you are shocked to see your eyes look like they belong on some sort of bug. <b>Your eyes are now like a moth’s eyes</b>";
				player.eyes.type = Eyes.MOTH;

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.eyes.type === Eyes.MOTH;
			}
	);
	public const EyesGremlin: Transformation = new SimpleTransformation("Gremlin Eyes",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Aw gosh, you feel tired as hell, it’s like you spent the better part of yesterday night working on some stupid project. Truth is with those darkened eyelids of yours you might just have. That said, perhaps you should think of it less like a sign of fatigue and more like a sign of demonic nature because you easily imagine these on the faces of small fiends or possessed people too. <b>Seems like you have darkened eyelids now.</b>";
				player.eyes.type = Eyes.GREMLIN;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(EyesMem.getMemory(EyesMem.GREMLIN));
			},
			// is present
			function (): Boolean {
				return player.eyes.type === Eyes.GREMLIN;
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
				transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(doOutput);
			},
			// is present
			function (): Boolean {
				return InCollection(player.eyes.colour, GoblinRace.GoblinEyeColors);
			}
	);

	public const EyesGremlinColors: Transformation = new SimpleTransformation("Gremlin Eye Colors",
			// apply effect
			function (doOutput: Boolean): void {
				transformations.EyesChangeColor(GremlinRace.GremlinEyeColors).applyEffect(doOutput);
			},
			// is present
			function (): Boolean {
				return InCollection(player.eyes.colour, GremlinRace.GremlinEyeColors);
			}
	);

	public const EyesRaijuColors: Transformation = new SimpleTransformation("Raiju Eye Colors",
			// apply effect
			function (doOutput: Boolean): void {
				transformations.EyesChangeColor(["blue", "green", "turquoise", "light green"]).applyEffect(doOutput);
			},
			// is present
			function (): Boolean {
				return player.eyes.type === Eyes.RAIJU && InCollection(player.eyes.colour, ["blue", "green", "turquoise", "light green"]);
			}
	);

	public const EyesKirinColors: Transformation = new SimpleTransformation("Kirin Eye Colors",
			// apply effect
			function (doOutput: Boolean): void {
				transformations.EyesChangeColor(["red","light blue","turquoise"]).applyEffect(doOutput);
			},
			// is present
			function (): Boolean {
				return InCollection(player.eyes.colour, ["red","light blue","turquoise"]);
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

	public const EyesAlrauneColors: Transformation = new SimpleTransformation("Alraune Eye Colors",
			// apply effect
			function (doOutput: Boolean): void {
				transformations.EyesChangeColor(["light purple", "green", "light green"]).applyEffect(doOutput);
			},
			// is present
			function (): Boolean {
				return InCollection(player.eyes.colour, ["light purple", "green", "light green"]);
			}
	);

	public const EyesAlicornColors: Transformation = new SimpleTransformation("Alicorn Eye Colors",
			// apply effect
			function (doOutput: Boolean): void {
				transformations.EyesChangeColor(["blue"]).applyEffect(doOutput);
			},
			// is present
			function (): Boolean {
				return InCollection(player.eyes.colour, ["blue"]);
			}
	);

	public const EyesAtlachColors: Transformation = new SimpleTransformation("Atlach Nacha Eye Colors",
			// apply effect
			function (doOutput: Boolean): void {
				transformations.EyesChangeColor(["red"]).applyEffect(doOutput);
			},
			// is present
			function (): Boolean {
				return InCollection(player.eyes.colour,["red"]);
			}
	);

	public const EyesFenrirColor: Transformation = new SimpleTransformation("Fenrir Eye Colors",
			// apply effect
			function (doOutput: Boolean): void {
				transformations.EyesChangeColor(["glacial blue"]).applyEffect(doOutput);
			},
			// is present
			function (): Boolean {
				return InCollection(player.eyes.colour,["glacial blue"]);
			}
	);

	public const EyesDemonColors: Transformation = new SimpleTransformation("Demon Eye Colors",
			// apply effect
			function (doOutput: Boolean): void {
				transformations.EyesChangeColor(["fiendish pink", "pink", "red", "yellow", "blue", "turquoise", "light green"]).applyEffect(doOutput);
			},
			// is present
			function (): Boolean {
				return InCollection(player.eyes.colour, ["fiendish pink", "pink", "red", "yellow", "blue", "turquoise", "light green"]);
			}
	);
	/*
  */
}
}
