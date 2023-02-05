package classes.Transformations.Transformations {
import classes.GeneticMemories.BreastMem;
import classes.Items.MutationsHelper;
import classes.PerkLib;
import classes.Scenes.Metamorph;
import classes.StatusEffects;
import classes.Transformations.*;
import classes.lists.BreastCup;

/**
 * Base class for transformation events.
 */
public class BreastsTransformations extends MutationsHelper {
	/*
    *    ██████  ██████  ███████  █████  ███████ ████████ ███████
    *    ██   ██ ██   ██ ██      ██   ██ ██         ██    ██
    *    ██████  ██████  █████   ███████ ███████    ██    ███████
    *    ██   ██ ██   ██ ██      ██   ██      ██    ██         ██
    *    ██████  ██   ██ ███████ ██   ██ ███████    ██    ███████
    */

	/*
        */
	public function UnlockBreasts(): void {
		//noinspection FallThroughInSwitchStatementJS	// Fallthrough is intended for retroactively unlocking in Metamorph after getting GeneticMemory
		switch (player.bRows()) {
			case 4: Metamorph.unlockMetamorphEx(BreastMem.getMemory(BreastMem.BREAST4));
			case 3: Metamorph.unlockMetamorphEx(BreastMem.getMemory(BreastMem.BREAST3));
			case 2: Metamorph.unlockMetamorphEx(BreastMem.getMemory(BreastMem.BREAST2));
			case 1: Metamorph.unlockMetamorphEx(BreastMem.getMemory(BreastMem.BREAST1));
				break;
			default: break;
		}
	}

	public const BreastsGrowUpToDD:Transformation = new SimpleTransformation("Grow breasts up to DD",
			// apply effect
			function (doOutput:Boolean):void {
				var row:int = player.smallestTitRow();
				var desc: String = "";

				desc += "Your chest aches and tingles, and your hands reach up to scratch at it unthinkingly. Just as you start to scratch at your " + breastDescript(row) + ", your chest pushes out in slight but sudden growth.";

				if (doOutput) outputText(desc);
				player.breastRows[row].breastRating++;
			},
			// is present
			function ():Boolean {
				return player.smallestTitSize() >= 6;
			}
	);

	public const BreastsShrinkToNothing:Transformation = new SimpleTransformation("Shrink breasts to nothing",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "A tingle starts in your [nipples] before the tight buds grow warm, hot even.  ";
				if (player.biggestLactation() >= 1) desc += "Somehow, you know that the milk you had been producing is gone, reabsorbed by your body.  ";
				desc += "They pinch in towards your core, shrinking along with your flattening [allbreasts].  You shudder and flex in response.  Your chest isn't just shrinking, it's reforming, sculping itself into a massive pair of chiseled pecs.  ";
				if (player.breastRows.length > 1) {
					desc += "The breasts below vanish entirely.  ";
					while (player.breastRows.length > 1) {
						player.removeBreastRow(player.breastRows.length - 1, 1);
					}
				}
				player.breastRows[0].breastRating = 0;
				player.breastRows[0].nipplesPerBreast = 1;
				player.breastRows[0].fuckable = false;
				if (player.nippleLength > .5) player.nippleLength = .25;
				player.breastRows[0].lactationMultiplier = 0;
				player.removeStatusEffect(StatusEffects.Feeder);
				if (player.hasPerk(PerkLib.Feeder)) {
					outputText("<b>(Perk Lost - Feeder!)</b>\n");
					player.removePerk(PerkLib.Feeder);
				}
				desc += "All too soon, your boobs are gone.  Whoa![pg]";

				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return !player.hasBreasts();
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
				//if (player.isFurCovered()) outputText(player.hairColor + " " + player.skinDesc);
				//else outputText(player.bodyColor + " " + player.skinDesc);
				desc += "[skin full] remains. <b>You've lost a row of breasts!</b>";

				if (doOutput) outputText(desc);
				dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
				transformations.UnlockBreasts();
			},
			// is present
			function ():Boolean {
				return player.breastRows.length <= 1;
			}
	);

	public const BreastRowsOne:Transformation = new SimpleTransformation("One pair of breasts ONLY",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				while (player.bRows() > 1)
					transformations.BreastRowsRemoveToOne.applyEffect(doOutput);

				if (player.bRows() == 0 || player.breastRows[0].breastRating < 3) {
					transformations.CreateBreastRow(3).applyEffect(doOutput);
				}

				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.breastRows.length == 1 && (player.breastRows[0].breastRating > BreastCup.FLAT);
			}
	);

	public const BreastRowsTwo:Transformation = new SimpleTransformation("Two pairs of breasts ONLY",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				while (player.bRows() > 2)
					transformations.BreastRowsRemoveToOne.applyEffect(doOutput);

				if (player.bRows() == 0 || player.breastRows[0].breastRating < 3) {
					transformations.CreateBreastRow(3).applyEffect(doOutput);
					desc += "[pg]"
				}
				if (player.bRows() < 2)
					transformations.CopyBreastRow().applyEffect();

				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.breastRows.length == 2;
			}
	);

	public const BreastRowsThree:Transformation = new SimpleTransformation("Three pairs of breasts ONLY",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				while (player.bRows() > 3)
					transformations.BreastRowsRemoveToOne.applyEffect(doOutput);

				if (player.bRows() == 0 || player.breastRows[0].breastRating < 3) {
					transformations.CreateBreastRow(3).applyEffect(doOutput);
					desc += "[pg]"
				}
				var first:Boolean = true;
				while (player.bRows() < 3) {
					transformations.CopyBreastRow().applyEffect(first);
					if (!first)
						desc += "[pg]Another row of breasts grow in at " + player.breastCup(player.bRows()-1) + ", looking just like the row above";
					first = false;
				}

				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.breastRows.length == 3;
			}
	);

	public const BreastRowsFour:Transformation = new SimpleTransformation("Four pairs of breasts ONLY",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				while (player.bRows() > 4)
					transformations.BreastRowsRemoveToOne.applyEffect(doOutput);

				if (player.bRows() == 0 || player.breastRows[0].breastRating < 3) {
					transformations.CreateBreastRow(3).applyEffect(doOutput);
					desc += "[pg]"
				}
				var first:Boolean = true;
				while (player.bRows() < 4) {
					transformations.CopyBreastRow().applyEffect(first);
					if (!first)
						desc += "[pg]Another row of breasts grow in at " + player.breastCup(player.bRows()-1) + ", looking just like the row above";
					first = false;
				}

				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.breastRows.length == 4;
			}
	);

	public function CreateBreastRow(size:int = 2):Transformation { return new SimpleTransformation("Create a breast row",
			// apply effect
			function (doOutput:Boolean):void {
				var desc:String = "[pg]";

				if (size < 0) size = 0;
				if (player.bRows() < 3 || player.breastRows[0].breastRating < size)
					desc += "Your chest tingles uncomfortably as your center of balance shifts.  <b>You now have a pair of " +breastSize(size)+ " breasts.</b>";
				else {
					if (size == 0) desc += "Your abdomen tingles and twitches as a new row of breasts sprouts below the others.";
					else desc +="Your abdomen tingles and twitches as a new row of " + breastSize(size) + " " + breastDescript(player.bRows()-1) + " sprouts below your others.";

				}
				if (player.bRows() == 0) {
					desc += "  A sensitive nub grows on the summit of each tit, becoming a new nipple.";
					player.createBreastRow(size);
					if (player.nippleLength < .25) player.nippleLength = .25;
				} else if (player.breastRows[0].breastRating == BreastCup.FLAT) {
					player.breastRows[0].breastRating = size;
				} else {
					player.createBreastRow(size, player.breastRows[player.bRows() - 1].nipplesPerBreast);
					if (player.breastRows[player.bRows() - 1].nipplesPerBreast == 1)
						desc += "  A sensitive nub grows on the summit of each tit, becoming a new nipple.";
					else
						desc += "  A set of sensitive nubs grow on the summit of each tit, becoming new nipples.";
					if (player.hasFuckableNipples()) {
						player.breastRows[player.bRows() - 1].fuckable = true;
						desc += "  Your new nipples are leaking and you can even press your finger inside, they are fuckable!"
					}
					player.breastRows[player.bRows() - 1].lactationMultiplier = player.breastRows[player.bRows() - 2].lactationMultiplier;
					dynStats("lus", 30, "scale", false);
					player.addCurse("sen", 2, 1);
				}
				if (doOutput) outputText(desc);
				transformations.UnlockBreasts();
			},
			// is present
			function ():Boolean {
				return player.bRows() >= 4;
			}
	); }

	public function CopyBreastRow(keepSize:Boolean = false):Transformation { return new SimpleTransformation("Copy last breast row but shrink 1 size",
			// apply effect
			function (doOutput:Boolean):void {
				var desc:String = "[pg]";

				if (player.breastRows[player.bRows() - 1].breastRating > BreastCup.FLAT) {
					var size:Number = player.breastRows[player.bRows() - 1].breastRating;
					if (!keepSize) size--;
					if (size < 0) size = 0;
					desc += "There's an itching below your [allbreasts].  You idly scratch at it, but gods be damned, it hurts!  You peel off part of your [armor] to inspect the unwholesome itch, ";
					if (player.biggestTitSize() >= 8) desc += "it's difficult to see past the wall of tits obscuring your view.";
					else desc += "it's hard to get a good look at.";
					desc += "  A few gentle prods draw a pleasant gasp from your lips, and you realize that you didn't have an itch - you were growing new nipples!";
					desc += "[pg]A closer examination reveals your new nipples to be just like the ones above in size and shape";
					if (player.breastRows[player.bRows() - 1].nipplesPerBreast > 1) desc += ", not to mention number";
					else if (player.hasFuckableNipples()) desc += ", not to mention penetrability";
					if (size > 0) {
						desc += ".  While you continue to explore your body's newest addition, a strange heat builds behind the new nubs. Soft, jiggly breastflesh begins to fill your cupped hands.  Radiant warmth spreads through you, eliciting a moan of pleasure from your lips as your new breasts ";
						if (keepSize) desc += "catch up to the pair above.";
						else desc += "stop just short of the ones above.";
						desc += "  They stop at " + breastSize(size) + "s.";
					} else desc += "  Your new breasts stay flat and masculine, not growing any larger.";
					desc += "  <b>You have " + num2Text(player.bRows() + 1) + " rows of breasts!</b>";
					if (doOutput) outputText(desc);

					player.createBreastRow(size, player.breastRows[player.bRows() - 1].nipplesPerBreast);
					if (player.hasFuckableNipples()) player.breastRows[player.bRows() - 1].fuckable = true;
					player.breastRows[player.bRows() - 1].lactationMultiplier = player.breastRows[player.bRows() - 2].lactationMultiplier;
					dynStats("lus", 30, "scale", false);
					player.addCurse("sen", 2, 1);
				}
				else transformations.CreateBreastRow(2).applyEffect(doOutput);
				transformations.UnlockBreasts();
			},
			// is present
			function ():Boolean {
				return player.bRows() >= 4;
			}
	); }

	public const NipplesPerBreastOne:Transformation = new SimpleTransformation("One nipple per breast",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "A chill runs over your [allbreasts] and vanishes. You stick a hand under your [armor] and discover that your extra nipples are missing!  You're down to just one per ";
				if (player.biggestTitSize() < 1) desc += "'breast'.";
				else desc += "breast.";


				if (doOutput) outputText(desc);
				for (var i:int = 0; i < player.breastRows.length; i++)
					player.breastRows[i].nipplesPerBreast = 1;
			},
			// is present
			function ():Boolean {
				return player.averageNipplesPerBreast() == 1;
			}
	);

	public const NipplesPerBreastFour:Transformation = new SimpleTransformation("Four nipples per breast",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";
				TransformationUtils.applyTFIfNotPresent(transformations.NipplesUnfuck, doOutput);

				desc += "[pg]Your " + nippleDescript(0) + "s tingle and itch.  You pull back your [armor] and watch in shock as they split into four distinct nipples!  <b>You now have four nipples on each side of your chest!</b>";
				if (player.breastRows.length >= 2 && player.breastRows[1].nipplesPerBreast == 1)
					desc += "A moment later your second row of " + breastDescript(1) + " does the same.";
				if (player.breastRows.length >= 3 && player.breastRows[2].nipplesPerBreast == 1) {
					desc += "Finally, your ";
					if (player.bRows() == 3) desc +="third row of " + breastDescript(2) + " mutates along with its sisters, sprouting into a wonderland of nipples.";
					else desc +="everything from the third row down mutates, sprouting into a wonderland of nipples.";
				}
				if (doOutput) outputText(desc);
				for (var i:int = 0; i < player.breastRows.length; i++)
					player.breastRows[i].nipplesPerBreast = 4;
				if (player.bRows() > 1)
					outputText("  <b>You have a total of " + num2Text(player.totalNipples()) + " nipples.</b>");
				Metamorph.unlockMetamorph(BreastMem.getMemory(BreastMem.QUADNIPPLE));
			},
			// is present
			function ():Boolean {
				return player.averageNipplesPerBreast() == 4;
			}
	);

	public const NipplesFuckableForce:Transformation = new SimpleTransformation("Increase Nipple size >= 2",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";
				TransformationUtils.applyTFIfNotPresent(transformations.NipplesPerBreastOne, doOutput);

				if (player.nippleLength < 2) {
					desc += "[pg]Your nipples engorge, prodding hard against the inside of your [armor].  Abruptly you realize they've grown rapidly to 2 inches."
					player.nippleLength = 2;
				}
				if (doOutput) outputText(desc);

				TransformationUtils.applyTFIfNotPresent(transformations.NipplesFuckable, doOutput);
			},
			// is present
			function ():Boolean {
				return player.hasFuckableNipples();
			}
	);

	public const NipplesFuckable:Transformation = new SimpleTransformation("Fuckable nipples",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";
				TransformationUtils.applyTFIfNotPresent(transformations.NipplesPerBreastOne, doOutput);

				var nowFuckable:Boolean;
				//Set nipplecunts on every row.
				for (var i:int = 0; i < player.breastRows.length; i++)
					if (!player.breastRows[i].fuckable && player.nippleLength >= 2) {
						player.breastRows[i].fuckable = true;
						nowFuckable = true;
					}
				desc += "[pg]Your [allbreasts] tingle with warmth that slowly migrates to your nipples, filling them with warmth.  You pant and moan, rubbing them with your fingers.  A trickle of wetness suddenly coats your finger as it slips inside the nipple.  Shocked, you pull the finger free.  <b>You now have fuckable nipples!</b>";
				//Talk about if anything was changed.
				if (doOutput && nowFuckable) outputText(desc);
				if (nowFuckable) Metamorph.unlockMetamorph(BreastMem.getMemory(BreastMem.FUCKNIPPLE));
			},
			// is present
			function ():Boolean {
				return player.hasFuckableNipples() || player.biggestTitSize() == 0;
			},
			// is possible
			function ():Boolean {
				return !player.hasFuckableNipples() && player.bRows() > 0 && player.averageNipplesPerBreast() == 1 && player.nippleLength >= 2
			}
	);

	public const NipplesUnfuck:Transformation = new SimpleTransformation("Unfuck nipples",
			// apply effect
			function (doOutput:Boolean): void {
				var desc: String = "";
				var unfucked:Boolean;
				for (var i:int = 0; i < player.breastRows.length; i++)
					if (player.breastRows[i].fuckable) {
						player.breastRows[i].fuckable = false;
						unfucked = true;
					}
				desc += "[pg]Your [allbreasts] tingle with a chill that slowly migrates to your nipples.  You pant and moan, rubbing them with your fingers.  You notice that you can no longer penetrate your nipples like before.  ";
				//Talk about if anything was changed.
				if (doOutput && unfucked) outputText(desc);
			},
			// is present
			function (): Boolean {
				return !player.hasFuckableNipples();
			}
	);

	public const StartLactation:Transformation = new SimpleTransformation("Start lactating",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";

				desc += "You feel your [nipple]s become tight and engorged.  A single droplet of milk escapes each, rolling down the curves of your breasts.  <b>You are now lactating!</b>";
				for (var i:int = 0; i < player.breastRows.length; i++) {
					player.breastRows[i].lactationMultiplier += 2;
				}

				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.isLactating();
			}
	);

	public const RemoveLactation:Transformation = new SimpleTransformation("Stop lactating",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (player.totalNipples() == 2) desc += "[pg]Both of your";
				else desc += "[pg]All of your many";
				desc += " nipples relax.  It's a strange feeling, and you pull back your top to touch one.  It feels fine, though there doesn't seem to be any milk leaking out.  You give it a squeeze and marvel when nothing ";
				if (player.hasFuckableNipples()) desc += "but sexual fluid ";
				desc += "escapes it.  <b>You are no longer lactating.</b>  That makes sense, only mammals lactate!  Smiling, you muse at how much time this will save you when cleaning your gear.";
				if (player.hasPerk(PerkLib.Feeder) || player.hasStatusEffect(StatusEffects.Feeder)) {
					desc += "[pg](<b>Feeder perk lost!</b>)";
					player.removePerk(PerkLib.Feeder);
					player.removeStatusEffect(StatusEffects.Feeder);
				}
				//Loop through and reset lactation
				for (var i:int = 0; i < player.breastRows.length; i++) {
					player.breastRows[i].lactationMultiplier = 0;
				}
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return !player.isLactating();
			}
	);

	public const NipplesNoColor:Transformation = new SimpleTransformation("Black nipples",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				//Cant have multicoloured nips...
				if (player.hasStatusEffect(StatusEffects.GlowingNipples) || player.hasStatusEffect(StatusEffects.BlackNipples))
					desc +="[pg]Something invisible brushes against your [nipples], making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.";
				if (player.hasStatusEffect(StatusEffects.GlowingNipples))
					player.removeStatusEffect(StatusEffects.GlowingNipples);
				if (player.hasStatusEffect(StatusEffects.BlackNipples))
					player.removeStatusEffect(StatusEffects.BlackNipples);

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(BreastMem.getMemory(BreastMem.DEFAULTNIPPLE));
			},
			// is present
			function ():Boolean {
				return !player.hasStatusEffect(StatusEffects.BlackNipples) && !player.hasStatusEffect(StatusEffects.GlowingNipples);
			}
	);

	public const NipplesBlack:Transformation = new SimpleTransformation("Black nipples",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				//Cant have multicoloured nips...
				TransformationUtils.applyTFIfNotPresent(transformations.NipplesNoColor, doOutput);

				desc += "A tickling sensation plucks at your nipples and you cringe, trying not to giggle. Looking down you are in time to see the last spot of flesh tone disappear from your [nipples]. They have turned an onyx black!";

				if (doOutput) outputText(desc);
				player.createStatusEffect(StatusEffects.BlackNipples, 0, 0, 0, 0);
				Metamorph.unlockMetamorph(BreastMem.getMemory(BreastMem.BLACKNIPPLE));
			},
			// is present
			function ():Boolean {
				return player.hasStatusEffect(StatusEffects.BlackNipples);
			}
	);

	public const NipplesGlowing:Transformation = new SimpleTransformation("Glowing nipples",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				//Cant have multicoloured nips...
				TransformationUtils.applyTFIfNotPresent(transformations.NipplesNoColor, doOutput);

				desc += "[pg]You suddenly feel an itch in your nipples and undress to check up on them. To your surprise they begin to glow with a fluorescent blue light as latent electricity build up within them. Well, this will be interesting.  <b>You now have neon blue nipples that glow in the dark.</b>";

				if (doOutput) outputText(desc);
				player.createStatusEffect(StatusEffects.GlowingNipples, 0, 0, 0, 0);
				Metamorph.unlockMetamorph(BreastMem.getMemory(BreastMem.GLOWINGNIPPLE));
			},
			// is present
			function ():Boolean {
				return player.hasStatusEffect(StatusEffects.GlowingNipples);
			}
	);
	/*
*/
}
}
