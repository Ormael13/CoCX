package classes.Transformations.Transformations {
import classes.Transformations.*;
import classes.BodyParts.*;
import classes.GeneticMemories.TongueMem;
import classes.Items.MutationsHelper;
import classes.PerkLib;
import classes.Scenes.Metamorph;

/**
 * Base class for transformation events.
 */
public class TongueTransformations extends MutationsHelper {
	/*
    *    ████████  ██████  ███    ██  ██████  ██    ██ ███████
    *       ██    ██    ██ ████   ██ ██       ██    ██ ██
    *       ██    ██    ██ ██ ██  ██ ██   ███ ██    ██ █████
    *       ██    ██    ██ ██  ██ ██ ██    ██ ██    ██ ██
    *       ██     ██████  ██   ████  ██████   ██████  ███████
    */

	/*
      */
	public const TongueHuman: Transformation = new SimpleTransformation("Human Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You feel something strange with your tongue. When you pull it out to check what is going on, <b>you realize your tongue is perfectly human again!</b>";
				player.tongue.type = Tongue.HUMAN;
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.HUMAN;
			}
	);

	public const TongueCat: Transformation = new SimpleTransformation("Cat Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your tongue suddenly feels weird. You try to stick it out to see what’s going on and discover it has changed to look similar to the tongue of a cat. At least you will be able to groom yourself properly with <b>your new cat tongue.</b>";
				player.tongue.type = Tongue.CAT;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.CAT));
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.CAT;
			},
			// is possible
			function (): Boolean {
				return InCollection(player.faceType, Face.CAT, Face.CAT_CANINES, Face.CHESHIRE, Face.CHESHIRE_SMILE) && player.tongue.type != Tongue.CAT;
			}
	);

	public const TongueDog: Transformation = new SimpleTransformation("Dog Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "<b>You have a new dog tongue.</b>";
				player.tongue.type = Tongue.DOG;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.DOG));
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.DOG;
			}
	);

	public const TongueElf: Transformation = new SimpleTransformation("Elf Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your throat starts to ache and your tongue tingles. You try to gasp for air, your eyes opening wide in surprise as the voice that exits your throat is entirely changed. Your sentences are a melody, and your words are notes. Your voice is like music to your ears, and you realize it is because your body has become closer to that of an elf, adapting even your tongue and voice. <b>You now have the beautiful voice of the elves.</b>";
				player.tongue.type = Tongue.ELF;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.ELF));
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.ELF;
			}
	);

	public const TongueDraconic: Transformation = new SimpleTransformation("Dragon Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your tongue suddenly falls out of your mouth and begins undulating as it grows longer. For a moment it swings wildly, completely out of control; but then settles down and you find you can control it at will, almost like a limb. You're able to stretch it to nearly 4 feet and retract it back into your mouth to the point where it looks like a normal human tongue. <b>You now have a draconic tongue.</b>";

				player.tongue.type = Tongue.DRACONIC;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.DRACONIC));
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.DRACONIC;
			}
	);

	public const TongueSnake: Transformation = new SimpleTransformation("Snake Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.tongue.type == Tongue.HUMAN) desc += "Your taste-buds start aching as they swell to an uncomfortably large size. Trying to understand what in the world could have provoked such a reaction, you bring your hands up to your mouth, your tongue feeling like it's trying to push its way past your lips. The soreness stops and you stick out your tongue to try and see what would have made it feel the way it did. As soon as you stick your tongue out, you realize that it sticks out much further than it did before, and now appears to have split at the end, creating a forked tip. The scents in the air are much more noticeable to you with your snake-like tongue.";
				else desc += "Your inhuman tongue shortens, pulling tight in the very back of your throat. After a moment the bunched-up tongue-flesh begins to flatten out, then extend forwards. By the time the transformation has finished, your tongue has changed into a long, forked snake-tongue.";
				player.tongue.type = Tongue.SNAKE;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.SNAKE));
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.SNAKE;
			}
	);

	public const TongueDemonic: Transformation = new SimpleTransformation("Demonic Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your tongue tingles";
				if (player.tongue.type != Tongue.HUMAN) desc += ", thickening in your mouth until it feels more like your old human tongue, at least for the first few inches";
				desc += ". It bunches up inside you, and when you open your mouth to release it, roughly two feet of tongue dangles out. You find it easy to move and control, as natural as walking. <b>You now have a long demon-tongue.</b>";

				player.tongue.type = Tongue.DEMONIC;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.DEMONIC));
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.DEMONIC;
			}
	);

	public const TongueRavenous: Transformation = new SimpleTransformation("Ravenous Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "";

				player.tongue.type = Tongue.RAVENOUS_TONGUE;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.RAVENOUS_TONGUE));
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.RAVENOUS_TONGUE;
			}
	);

	public const TongueCaveWyrm: Transformation = new SimpleTransformation("Cave Wyrm Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Something has changed in your mouth and you feel like you are about to choke! You stick your tongue out and discover, to your surprise, that it now glows with a neon blue light. Furthermore, it sticks out way further than it should, just like a lizard. <b> You now have a neon blue lizard tongue that glows in the dark.</b>";

				player.tongue.type = Tongue.CAVE_WYRM;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.CAVE_WYRM));
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.CAVE_WYRM;
			}
	);

	public const TongueGhost: Transformation = new SimpleTransformation("Ghost Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your tongue tingles and feels heavy in your mouth. Your tongue slips out further than what is considered normal. Your tongue grows at least a foot in length, tapering to a point. It slowly becomes more transparent until you’re able to see right through it. <b>You now have a long transparent ghostly tongue.</b>";

				player.tongue.type = Tongue.GHOST;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.GHOST));
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.GHOST;
			}
	);

	public const TongueRatatoskr: Transformation = new SimpleTransformation("Ratatoskr Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your tongue begins to feel stingy and dry, your throat too. You have difficulty speaking so you drink some water and try some basic pronunciation exercises. You find out to your absolute surprise you now have a talent with words and linguistics that you didn't use to, heck it's like the range and variety of sounds you can make just doubled. <b>Your skill with words just improved by leaps and bounds with your new Ratatoskr tongue.</b>";

				player.tongue.type = Tongue.RATATOSKR;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.RATATOSKR));
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.RATATOSKR;
			}
	);

	public const TongueMelkie: Transformation = new SimpleTransformation("Melkie Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your throat starts to ache and your tongue tingles. You try to gasp for air, your eyes opening wide in surprise as your voice exit your throat entirely changed. Your words are notes, your sentence a melody. Your voice is like music to your ears and you realise it is because your body became closer to that of a Melkie adapting even your tongue and voice. Well, you could always go sit on a rock and sing in case some sailor came by. <b>You now have the mermaid like voice of a Melkie.</b>";

				player.tongue.type = Tongue.MELKIE;
				player.createPerk(PerkLib.MelkieSong, 0, 0, 0, 0);
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.MELKIE));
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.MELKIE;
			}
	);

	public const TongueImp: Transformation = new SimpleTransformation("Imp Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your throat starts to ache and your tongue tingles. You try to gasp for air, your eyes opening wide in surprise as the voice that exits your throat is entirely changed. Your voice is far higher pitched than your old human one possibly because it's fit to a small imp body. <b>You now have the squaky voice of the imps.</b>";
				player.tongue.type = Tongue.IMPISH;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(TongueMem.getMemory(TongueMem.IMPISH));
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.ELF;
			}
	);

	public const TongueArigean: Transformation = new SimpleTransformation("Arigean Tongue",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "";

				player.tongue.type = Tongue.ARIGEAN;
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.tongue.type === Tongue.ARIGEAN;
			}
	);
	/*
*/
}
}
