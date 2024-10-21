package classes.Transformations.Transformations {
import classes.BodyParts.*;
import classes.GeneticMemories.WingsMem;
import classes.Items.MutationsHelper;
import classes.Scenes.Metamorph;
import classes.Transformations.*;

/**
 * Base class for transformation events.
 */
public class WingsTransformations extends MutationsHelper {
	/*
    *    ██       ██ ██ ███    ██  ██████  ███████
    *    ██       ██ ██ ████   ██ ██       ██
    *    ██  ███  ██ ██ ██ ██  ██ ██   ███ ███████
    *    ██ ██ ██ ██ ██ ██  ██ ██ ██    ██      ██
    *    ████   ████ ██ ██   ████  ██████  ███████
    */

	/*
      */
	public const WingsNone: Transformation = new SimpleTransformation("No Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.wings.type == Wings.BEE_SMALL || player.wings.type == Wings.BEE_LARGE) {
					desc += "Your wings twitch and flap involuntarily. You crane your neck to look at them as best you are able; from what you can see, they seem to be shriveling and curling up. They're starting to look a lot like they did when they first popped out, wet and new. <b>As you watch, they shrivel all the way, then recede back into your body.</b>";
				} else {
					switch (rand(2)) {
						case 0:
							desc += "Sensation fades from your [wings] slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.";
							break;
						case 1:
							desc += "A wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your shoulder-blades. After a moment the pain passes, though your wings are gone!";
							break;
					}
				}

				player.wings.type = Wings.NONE;

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.NONE;
			}
	);

	public const WingsFeatheredSphinx: Transformation = new SimpleTransformation("Feathered Sphinx Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

				desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. "+
						"Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, [haircolor] wings.</b>";
				player.wings.type = Wings.FEATHERED_SPHINX;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_SPHINX));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.FEATHERED_SPHINX;
			}
	);

	public const WingsManticoreLarge: Transformation = new SimpleTransformation("Manticore Large Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsManticoreSmall, doOutput);

				desc += "Your feel your wings growing larger by the second. They keep growing until they reach three times their original size. The transformation finally stops as your wings reach a span of twice your arms length. These will be really useful should you want to fly around in search of a meal. <b>You now have fully grown manticore wings.</b>";
				player.wings.type = Wings.MANTICORE_LARGE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.MANTICORE_LARGE));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.MANTICORE_LARGE;
			}
	);

	public const WingsManticoreSmall: Transformation = new SimpleTransformation("Manticore Small Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "";
				TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

				desc += "You scream something akin to a roar from the tremendous amount of pain you're suddenly experiencing as something starts to push out from your back. Your claws start digging large marks into the ground as the things stretch out and burst through your skin. "+
						"Large bones covered in a thin, yet sturdy layer of skin, forming a pair of small bat-like wings slowly push out before finally staying in place. They are too small right now to allow you to take flight but they sure look good on you. <b>You now have small manticore wings.</b>";
				player.wings.type = Wings.MANTICORE_SMALL;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.MANTICORE_SMALL));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.MANTICORE_SMALL;
			}
	);

	public const WingsNightmare: Transformation = new SimpleTransformation("Nightmare Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";


				if (player.wings.type == Wings.FEATHERED_ALICORN) {
					desc += " Your wings aren’t spared either all the feather falling off to reveal a membranous demonic pair of bat wings.";
				} else {
					TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

					desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. "+
							"Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, white wings.</b>";
				}
				player.wings.type = Wings.NIGHTMARE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.NIGHTMARE));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.NIGHTMARE;
			}
	);

	public const WingsFeatheredAlicorn: Transformation = new SimpleTransformation("Feathered Alicorn Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

				desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. "+
						"Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, white wings.</b>";
				player.wings.type = Wings.FEATHERED_ALICORN;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_ALICORN));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.FEATHERED_ALICORN;
			}
	);

	public const WingsThunderousAura: Transformation = new SimpleTransformation("Thunderous Aura (Wings)",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You've become so charged in electricity that your movements are sometimes accompanied by the sound of static. <b>It's going to be difficult to hide your presence with that thunderous aura of yours.</b>";
				player.wings.type = Wings.THUNDEROUS_AURA;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.THUNDEROUS_AURA));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.THUNDEROUS_AURA;
			}
	);

	public const WingsMantisLarge: Transformation = new SimpleTransformation("Mantis Large Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsMantisSmall, doOutput);

				desc += "Your wings tingle as they grow, filling out covering your back abdomen until they are large enough to lift you from the ground and allow you to fly! You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight. <b>You now have large Mantis wings!</b>";
				player.wings.type = Wings.MANTIS_LARGE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.MANTIS_LARGE));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.MANTIS_LARGE;
			}
	);

	public const WingsMantisSmall: Transformation = new SimpleTransformation("Mantis Small Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

				desc += "You feel an itching between your shoulder-blades as something begins growing there. You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably. A sense of relief erupts from you as you feel something new grow out from your body.";
				desc += "\nYou hastily remove the top portion of your [armor] and marvel as a pair of small Insectile wings sprout from your back. Tenderly flexing your new muscles, you find you can flap them quite fast. Unfortunately you can’t seem to flap your little wings fast enough to fly, but they would certainly slow a fall. "+
						"A few quick modifications to your [armor] later and you are ready to continue your journey with <b>your new mantis wings</b>.";
				player.wings.type = Wings.MANTIS_SMALL;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.MANTIS_SMALL));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.MANTIS_SMALL;
			}
	);

	public const WingsDraconicHuge: Transformation = new SimpleTransformation("Draconic Huge Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsDraconicLarge, doOutput);

				desc += "A not-unpleasant tingling sensation again fills your wings, almost but not quite drowning out the odd, tickly feeling as they swell larger and stronger than before. You spread them wide - they stretch now more than twice further than your arms do - and beat them experimentally, the powerful thrusts sending gusts of wind, and lifting you off your feet effortlesly. "+
						"<b>You now have fully-grown majestic dragon wings, capable of winging you through the air elegantly!</b>";
				player.wings.type = Wings.DRACONIC_HUGE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DRACONIC_HUGE));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.DRACONIC_HUGE;
			}
	);

	public const WingsDraconicLarge: Transformation = new SimpleTransformation("Draconic Large Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsDraconicSmall, doOutput);

				desc += "A not-unpleasant tingling sensation fills your wings, almost but not quite drowning out the odd, tickly feeling as they swell larger and stronger. You spread them wide - they stretch further than your arms do - and beat them experimentally, the powerful thrusts sending gusts of wind, and almost lifting you off your feet. "+
						"<b>You now have fully-grown dragon wings, capable of winging you through the air elegantly!</b>";
				player.wings.type = Wings.DRACONIC_LARGE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DRACONIC_LARGE));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.DRACONIC_LARGE;
			}
	);

	public const WingsDraconicSmall: Transformation = new SimpleTransformation("Draconic Small Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.wings.type == Wings.NONE) desc += "You double over as waves of pain suddenly fill your shoulderblades; your back feels like it's swelling, flesh and muscles ballooning. A sudden sound of tearing brings with it relief and you straighten up. Upon your back now sit small, leathery wings, not unlike a bat's. "+
						"<b>You now have small dragon wings. They're not big enough to fly with, but they look adorable.</b>";
				else desc += "A sensation of numbness suddenly fills your wings. When it dies away, they feel... different. Looking back, you realize that they have been replaced by new, small wings, ones that you can only describe as draconic. <b>Your wings have changed into dragon wings.</b>";
				player.wings.type = Wings.DRACONIC_SMALL;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DRACONIC_SMALL));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.DRACONIC_SMALL;
			}
	);

	public const WingsFeatheredPhoenix: Transformation = new SimpleTransformation("Feathered Phoenix Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. "+
						"Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, crimson wings.</b>";

				player.wings.type = Wings.FEATHERED_PHOENIX;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_PHOENIX));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.FEATHERED_PHOENIX;
			}
	);

	public const WingsFeatheredLarge: Transformation = new SimpleTransformation("Feathered Large Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.wings.type > Wings.NONE) desc += "Sensation fades from your " + player.wings.desc + " wings slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.";
				desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. "+
						"Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, [haircolor] wings.</b>";
				player.wings.type = Wings.FEATHERED_LARGE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_LARGE));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.FEATHERED_LARGE;
			}
	);

	public const WingsCouatl: Transformation = new SimpleTransformation("Coualt wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.wings.type > Wings.NONE) desc += "Sensation fades from your " + player.wings.desc + " wings slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.";
				desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow." +
						" Meanwhile your hair, feathers and scales all begin changing color to match your wings vibrant hues."+
						"Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, colorful couatl wings.</b>";
				player.wings.type = Wings.COUATL;
				player.hairColor = "crimson";
				player.scaleColor1 = "green";
				player.scaleColor2 = "yellow";
				player.featherColor = "blue";

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.COUATL));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.COUATL;
			}
	);

	public const WingsBeeLarge: Transformation = new SimpleTransformation("Bee Large Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsBeeSmall, doOutput);

				desc += "Your wings tingle as they grow, filling out until they are large enough to lift you from the ground and allow you to fly! <b>You now have large bee wings!</b> You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight.";
				player.wings.type = Wings.BEE_LARGE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.BEE_LARGE));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.BEE_LARGE;
			}
	);

	public const WingsBeeSmall: Transformation = new SimpleTransformation("Bee Small Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You feel an itching between your shoulder-blades as something begins growing there. You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably. A sense of relief erupts from you as you feel something new grow out from your body. You hastily remove the top portion of your [armor] and marvel as a pair of small bee-like wings sprout from your back. "+
						"Tenderly flexing your new muscles, you find you can flap them quite fast. Unfortunately you can't seem to flap your little wings fast enough to fly, but they would certainly slow a fall. A few quick modifications to your [armor] later and you are ready to continue your journey with <b>your new bee wings</b>.";
				player.wings.type = Wings.BEE_SMALL;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.BEE_SMALL));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.BEE_SMALL;
			}
	);

	// UNUSED
	// public const WingsDemonicQuadrupleLarge: Transformation = new SimpleTransformation("Demonic Large Quadruple Wings",
	//   // apply effect
	//   function (doOutput: Boolean): void {
	//     var desc: String = "";

	//     TransformationUtils.applyTFIfNotPresent(transformations.WingsDemonicLarge, doOutput);

	//     desc += "Your large demonic wings starts to tremble and then starts to split from the tip. You stretch over your shoulder to stroke them as they divide, turning into two pairs of full-sized demon-wings. <b>Your demonic wings have splited into two pairs!</b>";
	//     player.wings.desc = "two large pairs of bat-like";
	//     player.wings.type = Wings.BAT_LIKE_LARGE_2;

	//     if (doOutput) outputText(desc);
	//     Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DEMONIC_LARGE_X4));
	//   },
	//   // is present
	//   function (): Boolean {
	//     return player.wings.type === Wings.BAT_LIKE_LARGE_2;
	//   }
	// );

	public const WingsDemonicLarge: Transformation = new SimpleTransformation("Demonic Large Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsDemonicTiny, doOutput);

				if (player.wings.type == Wings.DRACONIC_LARGE || player.wings.type == Wings.BEE_LARGE || player.wings.type == Wings.MANTIS_LARGE || player.wings.type == Wings.MANTICORE_LARGE) {
					desc += "The muscles around your shoulders bunch up uncomfortably, changing to support your wings as you feel their weight increasing. You twist your head as far as you can for a look and realize they've changed into large <b>bat-like demon-wings!</b>";
				} else {
					desc += "Your small demonic wings stretch and grow, tingling with the pleasure of being attached to such a tainted body. You stretch over your shoulder to stroke them as they unfurl, turning into full-sized demon-wings. <b>Your demonic wings have grown!</b>";
				}

				player.wings.type = Wings.BAT_LIKE_LARGE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DEMONIC_LARGE));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.BAT_LIKE_LARGE;
			}
	);

	public const WingsDemonicTiny: Transformation = new SimpleTransformation("Demonic Tiny Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

				desc += "A knot of pain forms in your shoulders as they tense up. With a surprising force, a pair of small demonic wings sprout from your back, ripping a pair of holes in the back of your [armor]. <b>You now have tiny demonic wings</b>.";
				player.wings.type = Wings.BAT_LIKE_TINY;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DEMONIC_TINY));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.BAT_LIKE_TINY;
			}
	);

	public const WingsVampire: Transformation = new SimpleTransformation("Vampire Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "A terrible pain flares in the center of your back, a pain so intense that you black out briefly, coming back to your senses as you hit your head against the ground. You hear a horrifying ripping noise as your back stretches and tears to allow new bones to expand, black as tar and far lighter than most of the bones in your body. "+
						"These new bones shift under your shoulder blade skin as you fall on all groaning in pain and clawing at the ground. In a flash of pain they violently break out of your skin sending blood everywhere as you make a chilling scream your wounds slowly closing on their own. Still panting from the pain, you take a look at your new appendage. "+
						"It's a pair of large vampire wings of impressive size. Feeling chilly you fold them back on your body and you ought to admit they indeed look like a large cape. <b>You will be able to enjoy nightly flight using your brand new vampire wings.</b>";
				player.wings.type = Wings.VAMPIRE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.VAMPIRE));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.VAMPIRE;
			}
	);

	public const WingsFeatheredAvian: Transformation = new SimpleTransformation("Feathered Avian Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.wings.type == Wings.DRACONIC_SMALL || player.wings.type == Wings.DRACONIC_LARGE || player.wings.type == Wings.DRACONIC_HUGE || player.wings.type == Wings.BAT_LIKE_TINY || player.wings.type == Wings.BAT_LIKE_LARGE || player.wings.type == Wings.BAT_LIKE_LARGE_2 || Arms.canFly(player.arms.type) || player.wings.type == Wings.VAMPIRE) {
					desc += "Your wings feel suddenly heavier, and you’re forced to sit down to keep balance. Putting attention to the things happening at your back, you realize that the scales covering them are falling!";
					desc += "A bit alarmed, you’re surprised when, not much later, feathers started sprouting everywhere on them. t all the same, as long ones grow at the base, while shorter ones appear on the upper part of them and near your shoulders. When all the growth is finished, your wings are left with a much more bird-like appearance.";
					desc += "<b>In the end, your pair of now avian wings will carry you to skies with ease.</b>";
				} else if (player.wings.type > Wings.NONE) {
					desc += "Your wings feel suddenly heavier, and you’re forced to sit down to keep balance. Putting attention to the things happening at your back, you realize that the delicate tissue of them is becoming skin and flesh, with bones sprouting inside and placing themselves to support the added weight.";
					desc += "Once the muscles and bones are correctly formed, feathers start sprouting everywhere on them. Not all the same, as long ones grow at the base, while shorter ones appear on the upper part of them and near your shoulders. When all the growth is finished, your wings are left with a much more bird-like appearance.";
					desc += "<b>In the end, your pair of now avian wings will carry you to skies with ease.</b>";
				} else {
					desc += "A sudden ache overcomes your back, when you’re at the middle of your daily routine. Knowing from before how hazardous is the food found on the wilds of Mareth, you curse the strange seed that you’ve just eat for this painful state.";
					desc += "Before you can find something to soothe the pain, a piercing sensation of something tearing its way of of your flesh and skin makes you lose the balance and fall. Instinctively, you take off the upper part of your [armor] so anything that it’s growing from back there makes they way out without any trouble.";
					desc += "When everything finishes, you take a look at your backside, noticing two shapes sprouting from your upper back. They grow and grow, and when you recognize them as wings, they’ve already grown to carry with your body ease through the skies. Once the growth stops, you extend them and flex your newly gained bones and muscles. <b>Seems like you’ve gained a pair of avian wings!</b>";
				}

				player.wings.type = Wings.FEATHERED_AVIAN;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_AVIAN));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.FEATHERED_AVIAN;
			}
	);

	public const WingsEthereal: Transformation = new SimpleTransformation("Ethereal Wings Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your body feels lighter than usual, almost as if you’re floating on air. Unintentionally you lean forward, finding yourself floating a few feet off the ground. Confused as to what is happening, you try to move, floating a few paces in the direction you want to go. That’s when you notice three pairs of wispy otherworldly tendrils growing out of your back. "+
						"They glow faintly and almost appear as though they’re moving with the wind. They don’t even hold any weight. <b>You can get used to floating like this with your ethereal wings.</b>";

				player.wings.type = Wings.ETHEREAL;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.ETHEREAL));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.ETHEREAL;
			}
	);

	public const WingsLevitation: Transformation = new SimpleTransformation("Levitation Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You feel so tired you could fall on your knees but to your surprise you don't. Instead of actually hitting the ground you simply float in the air. <b>You are now naturally levitating.</b>";

				player.wings.type = Wings.LEVITATION;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.LEVITATION));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.LEVITATION;
			}
	);

	public const WingsWindyAura: Transformation = new SimpleTransformation("Windy Aura Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Winds begin to amass around you as if the prelude to a gathering storm. At first you think you are about to be attacked before you realise it’s all your doing. Merely by thinking about it the wind suddenly blows into a raging tornado carrying you up before you seize control and give it just enough strength to uplift you into its currents. "+
						"It would seem you have gained the infamous wind control power of the kamaitachi achieving mastery over it. Well, this is going to be fun to play with. <b>You now have the ability to control winds as the Kamaitachi do using your windy aura!</b>";

				player.wings.type = Wings.WINDY_AURA;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.WINDY_AURA));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.WINDY_AURA;
			}
	);

	public const WingsGiantDragonfly: Transformation = new SimpleTransformation("Giant Dragonfly Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You scream and fall to your knees as incredible pain snags at your shoulders, as if needle like hooks were being sunk into your flesh just below your shoulder blades. After about five seconds of white hot, keening agony it is with almost sexual relief that something splits out of your upper back. You clench the dirt as you slide what feel like giant leaves of paper into the open air. "+
						"Eventually the sensation passes and you groggily get to your feet. You can barely believe what you can see by craning your neck behind you - <b>you've grown a set of four giant dragonfly wings</b>, thinner, longer and more pointed than the ones you've seen upon the forest bee girls, but no less diaphanous and beautiful. "+
						"You cautiously flex the new muscle groups in your shoulder blades and gasp as your new wings whirr and lift you several inches off the ground. What fun this is going to be!";

				player.wings.type = Wings.GIANT_DRAGONFLY;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.GIANT_DRAGONFLY));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.GIANT_DRAGONFLY;
			}
	);

	public const WingsSeaDragon: Transformation = new SimpleTransformation("Sea Dragon Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You keel in pain as you feel something penetrating your back. No, nothing is stabbing your back. More so, something is about to burst from within you. The trauma subsides as large bones emerge. A thin yet sturdy layer of skin covers your wings are covered as they fall into place behind you.\n\nAs you examine the fleshy appendage, you realize it's webbed. "+
						"It seems to resemble more of a giant aquatic flipper than wings. The insides are not only colorful but also display several minute light specks. Not unlike those of a deep-sea beast. <b>You can now fly and swim at great speed with your brand new sea dragon wings!</b>";

				player.wings.type = Wings.SEA_DRAGON;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.SEA_DRAGON));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.SEA_DRAGON;
			}
	);

	public const WingsDevilfeather: Transformation = new SimpleTransformation("Devilfeather Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if ((player.wings.type == Wings.BAT_LIKE_LARGE) && player.cor >= 75) {
					desc += "Your wing shrivels before suddenly changing and covering themselves with black feathers. They still look demonic in a sense, albeit they are feathered now. <b>You now have black, feathered wings!</b>";
				} else if (player.wings.type == Wings.BEE_SMALL || player.wings.type == Wings.BEE_LARGE) {
					desc += "The muscles around your shoulders bunch up uncomfortably, changing to support your wings as you feel their weight increasing. You twist your head as far as you can for a look and realize they've changed into <b>black, feathered wings!</b>";
				} else if (player.wings.type != Wings.NONE) {
					desc += "A sensation of numbness suddenly fills your wings. When it dies away, they feel... different. Looking back, you realize that they have been replaced by <b>black, feathered wings!</b>";
				} else {
					desc += "A knot of pain forms in your shoulders as they tense up. With a surprising force, a pair of black feathered wings sprout from your back, ripping a pair of holes in the back of your [armor]. <b>You now have black, feathered wings!</b>";
				}

				player.wings.type = Wings.DEVILFEATHER;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DEVILFEATHER));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.DEVILFEATHER;
			}
	);

	public const WingsPureDevilfeather: Transformation = new SimpleTransformation("Purified Devilfeather Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if ((player.wings.type == Wings.BAT_LIKE_LARGE)) {
					desc += "Your wing shrivels before suddenly changing and covering themselves with immaculate white feathers. They still look demonic in a sense, albeit they are feathered now. <b>You now have white, feathered wings!</b>";
				} else if (player.wings.type == Wings.BEE_SMALL || player.wings.type == Wings.BEE_LARGE) {
					desc += "The muscles around your shoulders bunch up uncomfortably, changing to support your wings as you feel their weight increasing. You twist your head as far as you can for a look and realize they've changed into <b>immaculate white, feathered wings!</b>";
				} else if (player.wings.type != Wings.NONE) {
					desc += "A sensation of numbness suddenly fills your wings. When it dies away, they feel... different. Looking back, you realize that they have been replaced by <b>immaculate white, feathered wings!</b>";
				} else {
					desc += "A knot of pain forms in your shoulders as they tense up. With a surprising force, a pair of immaculate white feathered wings sprout from your back, ripping a pair of holes in the back of your [armor]. <b>You now have white, feathered wings!</b>";
				}

				player.wings.type = Wings.PUREDEVILFEATHER;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.PUREDEVILFEATHER));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.DEVILFEATHER;
			}
	);

	public const WingsFeyDragon: Transformation = new SimpleTransformation("Fey Dragon Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";
				if ((player.wings.type == Wings.NONE)) {
					desc += "You feel a sense of euphoria and start giggling as you feel a slight stabbing pain on your back. You feel light as a feather as you flap your new buterfly-like wings which have a delicate, almost fairy like appearance and you flap them in awe as they not only feel strong but also agile. You now have a set of <b>fey dragon wings.</b>";
				}
				else {
					desc += "You hardly even notice as something happens in your wings. They shrivel and change taking on a delicate, almost fairy like appearance and you flap them in awe as they not only feel strong but also agile. You now have a set of <b>fey dragon wings.</b>";
				}
				player.wings.type = Wings.FEY_DRAGON;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEY_DRAGON));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.FEY_DRAGON;
			}
	);

	public const WingsFairy: Transformation = new SimpleTransformation("Fairy Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";
				if ((player.wings.type == Wings.NONE)) {
					desc += "You feel a sense of euphoria and start giggling as you feel a slight stabbing pain on your back. You feel light as a feather as you flap your new buterfly-like wings which have a delicate, almost fairy like appearance and you flap them in awe as they not only feel strong but also agile. You now have a set of <b>fairy wings.</b>";
				}
				else{
					desc += "You ain't even noticing as something messed up happen in your wings. They shrivel and change taking on a delicate almost fairy like appearance and you flap them in awe as they not only feel strong but also agile. You now have a set of <b>fairy wings.</b>";
				}
				player.wings.type = Wings.FAIRY;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FAIRY));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.FAIRY;
			}
	);

	public const WingsJabberwocky: Transformation = new SimpleTransformation("Jabberwocky Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";
				if ((player.wings.type == Wings.NONE)) {
					desc += "You keel in pain as you feel something penetrating your back. No, nothing is stabbing your back. More so, something is about to burst from within you. The trauma subsides as large bones emerge. A thin yet sturdy layer of skin covers your wings are covered as they fall into place behind you.\n\nAs you examine the fleshy appendage, you realize it's covered in bug like cells. "+
							"It seems your wings are a mix between butterfly and dragon. The insides display several small dots and are segmented like that of a bug, yet the shape is definitively draconic. Just like those of a jabberwock, actually. <b>You can now fly at great speed with your brand new jabberwocky wings!</b>";
				}
				else {
					desc += "You ain't even noticing as something messed up happen in your wings. They shrivel and change taking on a delicate almost fairy like appearance and you flap them in awe as they not only feel strong but also agile. You now have a set of <b>jabberwocky wings.</b>";
				}
				player.wings.type = Wings.JABBERWOCKY;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.JABBERWOCKY));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.JABBERWOCKY;
			}
	);

	public const WingsPlant: Transformation = new SimpleTransformation("Plant Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

				desc += "Pressure is building in multiple spots on your upper back. It feels more like several over-eager erections trapped in incredibly tight undies. You can’t help but groan with relief when finally the pressure peaks and many thick protrusions burst impatiently out of your [skin.type]. "+
						"The hot, thick, vine-like growths thrust their way into being, feet of oily green tentacles, alarmingly energetic and prehensile, thrashing around your [hips]. After a moment of concentration you cause one of these growths to rear around into your hand to take a closer look at it. "+
						"It feels unmistakably dick-like - bulging, tender flesh under the fibrous skin, with quite a bit of flexible, able to bend all along its length and dart its wet, distended head in any direction you wish. <b>You now have cockvine wings.</b>";

				player.wings.type = Wings.PLANT;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.PLANT));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.PLANT;
			}
	);

	public const WingsAntLarge: Transformation = new SimpleTransformation("Ant Large Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsAntSmall, doOutput);

				if (player.wings.type == Wings.BEE_LARGE) desc += "You wince as you feel your wings tearing in half, but after a short moment, they start to tingle and grow longer. <b>You now have four large ant wings</b>.";
				else desc += "Your wings tingle as they grow, filling out until they are large enough to lift you from the ground and allow you to fly! <b>You now have large ant wings!</b> You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight.";
				player.wings.desc = "large ant-like";
				player.wings.type = Wings.ANT_LARGE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.ANT_LARGE));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.ANT_LARGE;
			}
	);

	public const WingsAntSmall: Transformation = new SimpleTransformation("Ant Small Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.wings.type == Wings.BEE_SMALL) desc += "You wince as you feel your wings tearing in half, but after a short moment, they start to tingle as they grow into four small ant wings. You still can't fly with them, but <b>you now have small ant wings</b>."
				else desc += "You feel an itching between your shoulder-blades as something begins growing there. You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably. A sense of relief erupts from you as you feel something new grow out from your body. You hastily remove the top portion of your [armor] and marvel as four small ant-like wings sprout from your back. "+
						"Tenderly flexing your new muscles, you find you can flap them quite fast. Unfortunately you can't seem to flap your little wings fast enough to fly, but they would certainly slow a fall. A few quick modifications to your [armor] later and you are ready to continue your journey with <b>your new ant wings</b>.";
				player.wings.desc = "small ant-like";
				player.wings.type = Wings.ANT_SMALL;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.ANT_SMALL));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.ANT_SMALL;
			}
	);

	public const WingsYggdrasilQuadrupleHuge: Transformation = new SimpleTransformation("Huge Quadruple Yggdrasil Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsYggdrasilHuge, doOutput);

				desc += "You hear the song of the world tree, extending your massive wings wide. Closing your [eyes], you spread your arms and wings in anticipation. To your surprise, your shoulders grow thicker, a painful nub forming under your [skin]. You kneel, as you had before, and to your surprise, a second pair of vines shoot from your back. "+
						"Years of growth seem to happen in an instant, and when your body stops shaking, a second pair of leafy wings have grown from you, only slightly smaller than your first pair. <b>You now have two large, majestic pairs of plant-like wings!</b>";
				player.wings.type = Wings.YGGDRASIL_HUGE_2;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.YGGDRASIL_HUGE_X4));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.YGGDRASIL_HUGE_2;
			}
	);

	public const WingsYggdrasilHuge: Transformation = new SimpleTransformation("Huge Yggdrasil Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsYggdrasilLarge, doOutput);

				desc += "Your wings seem to vibrate with the song of the world tree. They begin to shimmer gold, and you groan as the wooden base thickens, sending a shudder down your spine. You kneel, unfurling your wings as they expand, leafy plumage thickening and several of your twigs expanding into vines of their own. Your wings are massive now. "+
						"Hiding them would be impossible, and even folding them up is a challenge. <b>You now have large, majestic plant-like wings!</b>";
				player.wings.type = Wings.YGGDRASIL_HUGE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.YGGDRASIL_HUGE));
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.YGGDRASIL_HUGE;
			}
	);

	public const WingsYggdrasilLarge: Transformation = new SimpleTransformation("Large Yggdrasil Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";
				
				desc += "You feel your back itching. ";
				if ((player.wings.type != Wings.NONE)) {
					desc += "Your wings feel…warm, lethargic, almost. They begin to sag, ignoring your commands. They wither, turning to a dark, putrid brown before falling off your body. ";
				}
				desc += "The itching turns to pain, your shoulders writhing uncontrollably. You groan as vine-like tendrils break your [skin], shooting into the air. Before you can think too much, thick twigs sprout from the vines, leaves budding all along them. You can feel every new leaf, and the sheer sensation is overwhelming. You close your eyes, bringing your hands up to block out your other senses.\n\n"+
						"It stops, and you slowly open your eyes. You bring your new, flexible leafy wings around, to look at them. The vines are incredibly flexible, and the twigs, while sensitive, are tougher than you thought they’d be. The wings are long and graceful, but easily curled up behind you. You could probably fly with these! <b>You now have large, plant-like wings!</b>";
				
				player.wings.type = Wings.YGGDRASIL_LARGE;
				Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.YGGDRASIL_LARGE));
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.YGGDRASIL_LARGE;
			}
	);
	public const WingsMothSmall: Transformation = new SimpleTransformation("Small Moth Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You feel your back itching. ";
				if ((player.wings.type != Wings.NONE)) {
					desc += "Your wings feel…warm, lethargic, almost. They begin to sag, ignoring your commands. They wither, turning to a dark, putrid brown before falling off your body. ";
				}
				desc += "your back hurts as you suddenly feel something burst out your shoulder blades, reaching back you feel 2 small silky things like wings.\n\n <b>You now have small Moth Wings.</b>";

				player.wings.type = Wings.MOTH_SMALL;
				//Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.YGGDRASIL_LARGE));
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.MOTH_SMALL;
			}
	);

	public const WingsMothLarge: Transformation = new SimpleTransformation("Large Moth Wings",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You feel your back itching. ";
				if ((player.wings.type != Wings.NONE)) {
					desc += "Your wings feel…warm, lethargic, almost. They begin to sag, ignoring your commands. They wither, turning to a dark, putrid brown before falling off your body. ";
				}
				desc += " you suddenly feel a burst of pain in your back before the pain goes away, looking over you see the large white moth wings sticking out your back, with a flex of your muscles you find out that you can flap them. <b>You now have Large Moth Wings.</b>";

				player.wings.type = Wings.MOTH_LARGE;
				//Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.YGGDRASIL_LARGE));
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.wings.type === Wings.MOTH_LARGE;
			}
	);

	/*
  */
}
}