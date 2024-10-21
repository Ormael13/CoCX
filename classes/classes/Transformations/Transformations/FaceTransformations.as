package classes.Transformations.Transformations {
import classes.Transformations.*;
import classes.BodyParts.*;
import classes.GeneticMemories.FaceMem;
import classes.Items.MutationsHelper;
import classes.Scenes.Metamorph;

/**
 * Base class for transformation events.
 */
public class FaceTransformations extends MutationsHelper {

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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.DOG));
			},
			// is present
			function (): Boolean {
				return player.faceType === Face.DOG;
			},
			// is possible
			function (): Boolean {
				return player.faceType != Face.DOG && player.hasFullCoatOfType(Skin.FUR) && player.lowerBody == LowerBody.DOG;
			}
	);

	public const FaceCerberus: Transformation = new SimpleTransformation("Cerberus Tripple Head",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different. You find a puddle to view your reflection...<b>your face is now a cross between human and canine features.</b>";
				desc += "Flanking your main head are two more wich never truly fully agree with one another. You regularly need to put them back into their place and remind them who leads this body lest they start fighting each other.";

				if (doOutput) outputText(desc);
				player.faceType = Face.CERBERUS;
			},
			// is present
			function (): Boolean {
				return player.faceType === Face.CERBERUS;
			},
			// is possible
			function (): Boolean {
				return player.faceType == Face.DOG && player.hasFullCoatOfType(Skin.FUR) && player.lowerBody == LowerBody.DOG;
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.BUNNY));
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.KANGAROO));
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

				desc += "Sudden agony sweeps over your [face], your visage turning hideous as bones twist and your jawline shifts. The pain slowly vanishes, leaving you weeping into your fingers. When you pull your hands away you realize you've been left with a completely normal, human face. But then your teeth suddenly hurt as they begin to change. Your canines getting sharper and more adapted to eating meat just like those of a dragon. <b>You now have dragon fangs.</b>";

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
					if (((player.skinColor == "ebony" || player.skinColor == "black") && !player.hasCoat()) || ((player.hairColor == "black" || player.hairColor == "midnight") && (player.isFurCovered() || player.isScaleCovered()))) {
						desc += "Nothing seems different at first. Strange... you look closer and discover a darker, mask-line outline on your already inky visage. Furthermore your canines have slightly elongated not unlike those of an animal. <b>You now have a barely-visible raccoon mask and sharp canines like those of a raccoon.</b>";
					} else desc += "A dark, almost black mask shades the " + player.skinFurScales() + " around your eyes and over the topmost portion of your nose, lending you a criminal air! Furthermore your canines have slightly elongated not unlike those of an animal. <b>You now have a raccoon mask and sharp canines like those of a raccoon!</b>";
				} else {
					desc += "A sudden migraine sweeps over you and you clutch your head in agony as your nose collapses back to human dimensions. A worrying numb spot grows around your eyes, and you entertain several horrible premonitions until it passes as suddenly as it came. Checking your reflection in your water barrel, you find ";
					//[(if black/midnight fur or if black scales)
					if (((player.hairColor == "black" || player.hairColor == "midnight") && (player.isFurCovered() || player.isScaleCovered()))) desc += "your face apparently returned to normal shape, albeit still covered in " + player.skinFurScales() + ". You look closer and discover a darker, mask-line outline on your already inky visage. <b>You now have a barely-visible raccoon mask on your otherwise normal human face.</b>";
					else if ((player.skinColor == "ebony" || player.skinColor == "black") && (!player.hasCoat())) desc += "your face apparently returned to normal shape. You look closer and discover a darker, mask-line outline on your already inky visage. <b>You now have a barely-visible raccoon mask on your normal human face.</b>";
					else desc += "your face returned to human dimensions, but shaded by a black mask around the eyes and over the nose!  <b>You now have a humanoid face with a raccoon mask!</b>";
				}

				if (doOutput) outputText(desc);
				player.faceType = Face.RACCOON_MASK;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.RACCOONMASK));
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.RACCOON));
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

				desc += "A horrible itching begins to encompass the area around your eyes. You grunt in annoyance, rubbing furiously at the afflicted area. Once the feeling passes, you make your way to the nearest reflective surface to see if anything has changed. Your suspicions are confirmed. The [skinFurScales] around your eyes has darkened. <b>You now have a ferret mask!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.FERRET_MASK;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.FERRET_MASK));
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.FERRET));
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.RHINO));
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.ECHIDNA));
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.DEER));
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

				desc += "Your teeth suddenly hurt as you feel them changing. Your canines getting sharper and more adapted to eating meat. <b>You now have fangs.</b>";

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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.YETI));
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
				desc += " shifts into a vaguely triangular shape, something that would look at home on a predatory reptile... or a dragon. You feel pride swell within you as you look at your reflection in a puddle at your feet, your new look now resembles a majestic creature of the old myths. <b>You now have a draconic muzzle!</b>\n\n";

				if (doOutput) outputText(desc);
				player.faceType = Face.PLANT_DRAGON;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.PLANT_DRAGON));
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

	public const FaceInnocent: Transformation = new SimpleTransformation("Azazel Innocent Face",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You bring your hands to your [face] as a sudden agony sweeps over it. Through the pain, you can feel its shape changing, details shifting little by little with purpose. When you come back to your senses, you notice <b>you have a innocent, almost angelic face!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.INNOCENT;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.INNOCENT));
			},
			// is present
			function (): Boolean {
				return player.faceType === Face.INNOCENT;
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

				desc += "While you are busy laughing at the ridicule of this situation your bucktooth begin to pulse in accordance with your laughter growing almost to rabbit like size. You now have Jabberwocky buck teeths!";

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

				desc += "With the nutty flavor of the fruit still lingering, you gasp as your face feels weird and tingling, and aware of the transformative nature of the food on this strange land, you quickly associate it with the strange fruit that you’ve just eaten. Your ";
				if (player.faceType == Face.HUMAN) desc += "mouth and nose feels numb, and you’re left a bit confused, dizzy even, so your sit until your head clears. As you do so, several feathers start sprouting on your head, those ones small and downy, and cover every bit of skin.[pg]Too busy giving attention to this, you don’t notice when something big and hard suddenly obscures your vision. Sensing it with your hands, you feel it attached to your face. Rushing to the nearest pool of water, you look up your reflection, only to realize that you have a full avian, face, covered in feathers and complete with a hooked beak.[pg]A bit worried about the new…implications of this on your sexual life, you test the borders on your beak, fearing it sharp and dangerous, only to happily discover that it's not sharpened in any way, only not as soft as an usual set of lips. If you wanted to damage someone with it, you’ll had to apply pressure, not unlike on an usual set of tooth. Even with that, kisses would be…interesting from now on, to say the least.[pg]This isn’t the only major change, as you feel your ears twitching, and before you can realize, they recede on your body, leaving behind two holes, almost completely hidden by feathers and your [hair]. Fearing that most of your hearing range and ability was damaged or is blocked by the feathers, you test the sounds around your, and breathe on relief at the realization that your hearing is as good as always. <b>Anyways, after a lot of changes, you’re left with an avian head!</b>";
				else desc += "[face] feels numb, and you’re left a bit confused, dizzy even, so your sit until your head clears. As you do so, several feathers start sprouting on your head, those ones small and downy, and cover every bit of skin.[pg]Too busy giving attention to this, you don’t notice when something big and hard suddenly obscures your vision. Sensing it with your hands, you feel it attached to your face. Rushing to the nearest pool of water, you look up your reflection, only to realize that you have a full avian, face, covered in feathers and complete with a hooked beak. That's quite the change, even for your [face].[pg]A bit worried about the new…implications of this on your sexual life, you test the borders on your beak, fearing it sharp and dangerous, only to happily discover that it's not sharpened in any way, only not as soft as an usual set of lips. If you wanted to damage someone with it, you’ll had to apply pressure, not unlike of an usual set of tooth. Even with that, kisses would be…interesting from now on, to say the least.[pg]This isn’t the only major change, as you feel your [ears] twitching, and before you can realize, they recede on your body, leaving behind two holes, almost completely hidden by feathers and your [hair]. Fearing that most of your hearing range and ability was damaged or is blocked by the feathers, you test the sounds around your, and breathe on relief at the realization that your hearing is as good as always. <b>Anyways, after a lot of changes, you’re left with an avian head!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.AVIAN;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.AVIAN));
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
				var startsWithWolfFace: Boolean = player.faceType === Face.WOLF;

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

				if (!startsWithWolfFace) desc += "You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. <b>Your mouth is now filled with wolf-like canines.</b>";
				else desc += "However, your mouth remains filled with wolf-like canines."

				if (doOutput) outputText(desc);
				player.faceType = Face.WOLF_FANGS;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.WOLF_FANGS));
			},
			// is present
			function (): Boolean {
				return player.faceType === Face.WOLF_FANGS;
			}
	);

	public const FaceFoxFangs: Transformation = new SimpleTransformation("Fox Fangs Face",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";
				var startsWithFoxFace: Boolean = player.faceType === Face.FOX;

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

				if (!startsWithFoxFace) desc += "You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. <b>Your mouth is now filled with fox-like canines.</b>";
				else desc += "However, your mouth remains filled with fox-like canines."

				if (doOutput) outputText(desc);
				player.faceType = Face.FOX_FANGS;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.FOX_FANGS));
			},
			// is present
			function (): Boolean {
				return player.faceType === Face.FOX_FANGS;
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.BEAR));
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.PANDA));
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.FIRE_SNAIL));
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.GHOST));
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.YUKI_ONNA));
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

				desc += "Thinking on it, you’re smart, small and smuggly. The whole idea makes you laugh uncontrollably. But hey seriously since you’re the superior genius around here, might as well flash these idiots an unsettling smile, heck just thinking about how stupid everyone else is makes you smirk constantly, halfway to laughter. Well, they might call you crazy but once you bury these primitive fools in the ground they'll all be the crazy ones. <b>You’re now constantly flashing a crazy grin just like a gremlin.</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.CRAZY;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.CRAZY));
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.SMUG));
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
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.SQUIRREL));
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

	public const FaceAnt: Transformation = new SimpleTransformation("Ant Face",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "Tension builds at the back of your cheeks, just behind your cheekbones. You reach to touch the affected area, pricking your finger on a sharpening bone. It slides forward while you're touching it, lengthening into an ant-like mandible. You check the other side and confirm your suspicions. <b>You now have a pair of mandibles, complete with their own formic acid!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.ANT;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.ANT));
			},
			// is present
			function (): Boolean {
				return player.faceType === Face.ANT;
			}
	);

	public const FaceAbyssalShark: Transformation = new SimpleTransformation("Abyssal Shark Face",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);

				desc += "Your [face] explodes in a shot of agony, reshaping into a more human-like visage. Your face might as well be sloughing off, hacked off piece by piece as your entire facial structure reshapes itself more. Your grasp at your mouth, intense pain wracking your oral cavity. Your gums shift as your jawline readjusts itself. You try to feel around your cheeks, your forehead... everything slowly begins setting into place. You can open your eyes as the pain recedes, almost as quickly as it came. ";
				desc += "You need a moment to adjust to your vision before you look at your reflection in the nearest source of water. A set of retractable shark fangs have grown over your normal teeth, and your face has elongated a little to accomdate them! That's not the worst part, as your eyes are no longer located deep within your skull, but at the bony extrusions of your upper face bones. Your head more closely resembles the shape of a hammer. This'll take a bit to get used to.\n(Gain: 'Bite' special attack)";

				if (doOutput) outputText(desc);
				player.faceType = Face.ABYSSAL_SHARK;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.ABYSSAL_SHARK));
			},
			// is present
			function (): Boolean {
				return player.faceType === Face.ABYSSAL_SHARK;
			}
	);

	public const FaceArigean: Transformation = new SimpleTransformation("Arigean Face",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (doOutput) outputText(desc);
				player.faceType = Face.ARIGEAN;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.ARIGEAN));
			},
			// is present
			function (): Boolean {
				return player.faceType === Face.ARIGEAN;
			}
	);

	public const FaceDemon: Transformation = new SimpleTransformation("Demon Face",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You gasp in pleasure as your face suddenly begins to change the flesh and bones reshaping themselves like so much clay. In your mouth you feel your canines grow slightly longer, taking on a sharp appearance like those of a beast. Perhaps not as long as you thought they would end up as, but clearly they will make your smile all the more fiendish. Curious to see the change in full you head to the stream and take a look at yourself gasping at the sight. Hello " + player.mf("handsome","gorgeous")+" new me! Your face is so hot it's gonna take everyone great effort to resist falling for you. <b>With your brand new demonic face, who could ever say no to you?</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.DEMON;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.DEMON));
			},
			// is present
			function (): Boolean {
				return player.faceType === Face.DEMON;
			}
	);

	public const FaceTroll: Transformation = new SimpleTransformation("Troll Face",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);
				desc += "You feel tremendous pressure in your jaws and skull. Slight pain and extreme discomfort run through you as you feel tusks sprout from your jaw past your lips. Your nose also becomes more pronounced. <b>You now have troll tusks!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.TROLL;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.TROLL));
			},
			// is present
			function (): Boolean {
				return player.faceType === Face.TROLL;
			}
	);

	public const FaceGlacialTroll: Transformation = new SimpleTransformation("Glacial Troll Face",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.FaceHuman, doOutput);
				desc += "You feel tremendous pressure in your jaws and skull. Slight pain and extreme discomfort run through you as you feel tusks sprout from your jaw past your lips. Your nose also becomes more pronounced. <b>You now have glacial troll tusks!</b>";

				if (doOutput) outputText(desc);
				player.faceType = Face.GLACIAL_TROLL;
				Metamorph.unlockMetamorph(FaceMem.getMemory(FaceMem.GLACIAL_TROLL));
			},
			// is present
			function (): Boolean {
				return player.faceType === Face.GLACIAL_TROLL;
			}
	);
}
}
