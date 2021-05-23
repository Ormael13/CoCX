package classes.Transformations {
import classes.BaseContent;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Items.MutationsHelper;
import classes.StatusEffects;
import classes.internals.EnumValue;

public class TransformationLib extends MutationsHelper {
	public function TransformationLib() {
	}
	
	// VARIABLE NAMING: <body part> + <what to do> + <flavour>
	// e.g. "grow 9th fox tail" -> TailFox9
	// Complex TF should have prefix "Complex" or "Tiered" and can have any naming
	
	// Template - copy and fill
	// "is possible" function is optional default is "possible if not present"
	/*
	public const NAME:Transformation = new SimpleTransformation("Tf Name",
			// apply effect
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("TF Effect")
				}
				apply_TF
			},
			// is present
			// is present
			function():Boolean {
				return true_if_TF_already_present_on_player
			},
			// is possible
			// is possible
			function():Boolean {
				return true_if_TF_can_be_applied_to_player
			}
	);
	 */
	
	
	/***
	 *    ███████ ███████ ███████ ███████  ██████ ████████ ███████
	 *    ██      ██      ██      ██      ██         ██    ██
	 *    █████   █████   █████   █████   ██         ██    ███████
	 *    ██      ██      ██      ██      ██         ██         ██
	 *    ███████ ██      ██      ███████  ██████    ██    ███████
	 *
	 *
	 */
	// Template for non-tf effects and tf effects that cannot be "present" (ex. enlarge cock)
	// "is possible" function is optional, default always possible
	/*
	public const NAME:PossibleEffect = new SimpleEffect("Effect name",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("TF Effect");
				}
				apply_effect
			},
			// is possible?
			function ():Boolean {
				return true_if_effect_can_be_applied_to_player
			}
	);
	 */
	public const MutagenSpeSpider:PossibleEffect    = new MutagenEffect(
			"Mutagen Bonus SPE (spider)",
			"spe",
			1.5,
			"Your reflexes feel much faster. Experimentally, you make a grab at a fly on a nearby rock and quickly snatch it out of the air.  A compulsion to stuff it in your mouth and eat it surfaces, but you resist the odd desire.  Why would you ever want to do something like that?"
	);
	public const MutagenTouSpider:PossibleEffect    = new MutagenEffect(
			"Mutagen Bonus TOU (spider)",
			"tou",
			1,
			"Stretching languidly, you realize you're feeling a little tougher than before, almost as if you had a full-body shell of armor protecting your internal organs.  How strange.  You probe at yourself, and while your [skinfurscales] doesn't feel much different, the underlying flesh does seem tougher."
	);
	public const MutagenLibSpider:PossibleEffect    = new MutagenEffect(
			"Mutagen Bonus LIB (spider)",
			"lib",
			1,
			"You suddenly feel slightly needier, and your loins stir in quiet reminder that they could be seen to. The aftertaste hangs on your tongue and your teeth.  You wish there had been more."
	);
	public const SensUpSpider:PossibleEffect        = new DynstatEffect(
			"Spider sens up",
			"sen",
			+1,
			"The hairs on your arms and legs stand up straight for a few moments, detecting the airflow around you. Touch appears to be more receptive from now on."
	);
	public const VenomRechargeSpider:PossibleEffect = new SimpleEffect(
			"Recharge spider venom",
			// apply
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("The spinnerets on your abdomen twitch and drip a little webbing.  The entirety of its heavy weight shifts slightly, and somehow you know you'll produce webs faster now.");
				}
				player.tailRecharge += 5;
			},
			// is possible
			function ():Boolean {
				return player.tailType == Tail.SPIDER_ADBOMEN && player.tailRecharge < 25;
			}
	);
	
	public const VaginaTightenAndMutagenLib:PossibleEffect  = new SimpleEffect(
			"Tighten vagina + Mutagen Bonus LIB",
			// apply
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("With a gasp, you feel your [vagina] tightening, making you leak sticky girl-juice. After a few seconds, it stops, and you rub on your [vagina] excitedly. You can't wait to try this out!");
				}
				player.vaginas[0].vaginalLooseness--;
				dynStats("lus", 25);
				MutagenBonus("lib", 2);
			},
			// is possible
			function ():Boolean {
				return player.hasVagina() && player.looseness() > 1
			}
	);
	public const AssholeTightenAndMutagenLib:PossibleEffect = new SimpleEffect(
			"Tighten asshole + Mutagen Bonus LIB",
			// apply
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("You let out a small cry as your [asshole] shrinks, becoming smaller and tighter. When it's done, you feel much hornier and eager to stretch it out again.");
				}
				player.ass.analLooseness--;
				dynStats("lus", 25);
				MutagenBonus("lib", 2);
			},
			// is possible
			function ():Boolean {
				return player.ass.analLooseness > 1;
			}
	);
	public const CocksThickenAll:PossibleEffect             = new SimpleEffect(
			"Thicken all cocks",
			// apply
			function (doOutput:Boolean):void {
				var thickened:Boolean = false;
				for (var i:int = 0; i < player.cockTotal(); i++) {
					if (player.cocks[i].cockThickness * 5.5 < player.cocks[i].cockLength) {
						player.cocks[i].cockThickness += .1;
						thickened = true;
					}
				}
				if (thickened && doOutput) {
					outputText("You can feel your [cocks] filling out in your [armor]. Pulling ");
					if (player.cockTotal() == 1) outputText("it");
					else outputText("them");
					outputText(" out, you look closely.  ");
					if (player.cockTotal() == 1) outputText("It's");
					else outputText("They're");
					outputText(" definitely thicker.");
				}
			},
			// is possible
			function ():Boolean {
				return player.hasCock();
			}
	);

	public function makeHairColorTf(colors:/*String*/Array):Transformation {
		return new SimpleTransformation("hair color: " + colors.join("|"),
				// apply effect
				function (doOutput:Boolean):void {
					var color:String = randomChoice(colors);
					player.hairColorOnly = color;
					if (doOutput) {
						outputText("Your scalp begins to tingle, and you gently grasp a strand of hair, pulling it out to check it.  Your hair has become [haircolor]!");
					}
				},
				// is present
				function ():Boolean {
					return InCollection(player.hairColor, colors);
				}
		)
	}

	public const SpinneretAtlach:Transformation = new SimpleTransformation("Chitinous spider legs",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					if (player.tailType > Tail.NONE) outputText("Your tail shudders as heat races through it, twitching violently until it feels almost as if it's on fire.  You jump from the pain at your " + buttDescript() + " and grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your " + buttDescript() + "!</b>\n\n");
					//(No tail)
					else outputText("A burst of pain hits you just above your " + buttDescript() + ", coupled with a sensation of burning heat and pressure.  You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body.  Reaching back, you grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your " + buttDescript() + "!</b>");
				}
				//(Pre-existing tails)
				setTailType(Tail.SPIDER_ADBOMEN);
				player.tailVenom = 5;
				player.tailRecharge = 5;
				player.coatColor = "midnight purple";
			},
			// is present
			function ():Boolean {
				return player.tailType === Tail.SPIDER_ADBOMEN;
			}
	);
	
	/***
	 *    ███████ ██   ██ ██ ███    ██
	 *    ██      ██  ██  ██ ████   ██
	 *    ███████ █████   ██ ██ ██  ██
	 *         ██ ██  ██  ██ ██  ██ ██
	 *    ███████ ██   ██ ██ ██   ████
	 */
	
	
	public const SkinChitin:Transformation = new SimpleTransformation("Chitin skin",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					if (player.hasCoat()) {
						outputText("A slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your [skin coat] [skin coat.isare] falling to the ground, revealing flawless, midnight purple chitin underneath.");
					} else {
						outputText("A slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your skin stating to harden turning slowly into chitin.");
					}
					outputText("  <b>You now have midnight purple chitin exoskeleton partialy covering your body.</b>");
				}
				player.skin.growCoat(Skin.CHITIN, {color: "midnight purple"}, Skin.COVERAGE_LOW);
				addGeneticMemory(StatusEffects.UnlockedChitin, "Chitin", doOutput);
			},
			// is present
			function ():Boolean {
				return player.hasCoatOfType(Skin.CHITIN);
			}
	);
	
	
	/***
	 *    ███████  █████   ██████ ███████
	 *    ██      ██   ██ ██      ██
	 *    █████   ███████ ██      █████
	 *    ██      ██   ██ ██      ██
	 *    ██      ██   ██  ██████ ███████
	 */
	public const FaceHuman:Transformation       = new SimpleTransformation("Human face",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("Wracked by pain, your face slowly reforms into a perfect human shape.  Awed by the transformation, you run your fingers delicately over the new face, marvelling at the change.  <b>You have a human face again!</b>");
				}
				setFaceType(Face.HUMAN);
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.HUMAN;
			}
	);
	public const FaceSpiderFangs:Transformation = new SimpleTransformation("Spider fangs face",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("Tension builds within your upper gum, just above your canines.  You open your mouth and prod at the affected area, pricking your finger on the sharpening tooth.  It slides down while you're touching it, lengthening into a needle-like fang.  You check the other side and confirm your suspicions.  <b>You now have a pair of pointy spider-fangs, complete with their own venom!</b>")
				}
				setFaceType(Face.SPIDER_FANGS);
				if (player.tailRecharge < 5) player.tailRecharge = 5;
			},
			// is present
			function ():Boolean {
				return player.faceType === Face.SPIDER_FANGS;
			}
	);
	
	/***
	 *    ███████  █████  ██████  ███████
	 *    ██      ██   ██ ██   ██ ██
	 *    █████   ███████ ██████  ███████
	 *    ██      ██   ██ ██   ██      ██
	 *    ███████ ██   ██ ██   ██ ███████
	 *
	 *
	 */
	public const EarsElfin:Transformation = new SimpleTransformation("Elfin ears",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					if (player.ears.type != Ears.HUMAN) {
						outputText("Your ears twitch once, twice, before starting to shake and tremble madly.  They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, pointed elfin ears.</b>");
					} else {
						outputText("A weird tingling runs through your scalp as your [hair] shifts slightly.  You reach up to touch and bump <b>your new pointed elfin ears</b>.  You bet they look cute!");
					}
				}
				setEarType(Ears.ELFIN);
			},
			// is present
			function ():Boolean {
				return player.ears.type === Ears.ELFIN
			}
	)
	
	/***
	 *    ███████ ██    ██ ███████ ███████
	 *    ██       ██  ██  ██      ██
	 *    █████     ████   █████   ███████
	 *    ██         ██    ██           ██
	 *    ███████    ██    ███████ ███████
	 */
	
	public function makeEyeColorTf(colors:/*String*/Array):Transformation {
		return new SimpleTransformation("Eye color: " + colors.join("|"),
				// apply effect
				function (doOutput:Boolean):void {
					var color:String = randomChoice(colors);
					player.eyes.colour = color;
					if (doOutput) {
						outputText("You feel something fundamental change in your sight when you go check yourself in a puddle you notice that not only do they look human but your irises are now <b>[eyecolor].</b>");
					}
				},
				// is present
				function ():Boolean {
					return InCollection(player.eyes.colour, colors);
				}
		)
	}
	
	public const EyesSpider:Transformation              = new SimpleTransformation("Spider eyes",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("You suddenly get the strangest case of double vision.  Stumbling and blinking around, you clutch at your face, but you draw your hands back when you poke yourself in the eye.  Wait, those fingers were on your forehead!  You tentatively run your fingertips across your forehead, not quite believing what you felt.  <b>There's a pair of eyes on your forehead, positioned just above your normal ones!</b>  This will take some getting used to!");
				}
				setEyeType(Eyes.FOUR_SPIDER_EYES);
			},
			// is present
			function ():Boolean {
				return player.eyes.type === Eyes.FOUR_SPIDER_EYES
			}
	);
	public const EyesSpiderAndMutagenInt:Transformation = EyesSpider.copyWithExtraEffect(
			"Spider eyes + Mutagen Bonus INT",
			// extra effect
			function (doOutput:Boolean):void {
				MutagenBonus("int", 5);
			}
	);
	
	public const EyesHumanToSpider:Transformation = EyesSpider.copyWithExtraCondition(
			"Human eyes to spider eyes",
			// extra condition
			function ():Boolean {
				return player.eyes.type === Eyes.HUMAN
			}
	);
	
	/***
	 *    ██      ███████  ██████  ███████
	 *    ██      ██      ██       ██
	 *    ██      █████   ██   ███ ███████
	 *    ██      ██      ██    ██      ██
	 *    ███████ ███████  ██████  ███████
	 */
	
	public const LegsHuman:Transformation  = new SimpleTransformation("Human legs",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					if (player.isTaur()) outputText("Your quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of human legs</b>!");
					else if (player.isGoo()) outputText("Your lower body rushes inward, molding into two leg-like shapes that gradually stiffen up.  In moments they solidify into normal-looking legs, complete with regular, human feet.  <b>You now have normal feet!</b>");
					else if (player.isNaga()) outputText("You collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly where your new feet are forming.  <b>You have human legs again.</b>");
					else if (player.isScylla()) outputText("You collapse as your tentacle legs starts to merge.  The pain is immense, particularly where your new feet are forming.  <b>You have human legs again.</b>");
					else if (player.isAlraune()) {
						outputText("You suddenly lose all feeling from the waist down, your pitcher quickly withering and dying. Soon after it began, your pitcher is reduced to nothing but dust, leaving you to stand on two ordinary human legs. ");
						outputText("On the ground is all that is left of your flower, a single petal still intact that you proceed to put in your bag. Something tells you you will need it to become an alraune again.  <b>You have human legs again.</b>");
					} else /*if (player.isBiped()) */outputText("You collapse as your legs shift and twist.  By the time the pain subsides, you notice that you have normal legs and normal feet.  <b>You now have normal feet!</b>");
				}
				if (player.hasStatusEffect(StatusEffects.HydraTailsPlayer)) player.removeStatusEffect(StatusEffects.HydraTailsPlayer);
				setLowerBody(LowerBody.HUMAN);
				player.legCount = 2;
			},
			// is present
			function ():Boolean {
				return player.lowerBody === LowerBody.HUMAN && player.legCount === 2;
			}
	);
	public const LegsSpider:Transformation = new SimpleTransformation("Chitinous spider legs",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("Starting at your [feet], a tingle runs up your [legs], not stopping until it reaches your thighs.  From the waist down, your strength completely deserts you, leaving you to fall hard on your [ass] in the dirt.  With nothing else to do, you look down, only to be mesmerized by the sight of black exoskeleton creeping up a perfectly human-looking calf.  It crests up your knee to envelop the joint in a many-faceted onyx coating.  Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton.  From a distance it would look almost like a black, thigh-high boot, but you know the truth.  <b>You now have human-like legs covered in a black, arachnid exoskeleton.</b>");
				}
				setLowerBody(LowerBody.CHITINOUS_SPIDER_LEGS);
				player.legCount  = 2;
				player.coatColor = "black";
			},
			// is present
			function ():Boolean {
				return player.lowerBody === LowerBody.CHITINOUS_SPIDER_LEGS && player.legCount === 2;
			}
	);
	public const LegsAtlach:Transformation = new SimpleTransformation("Chitinous spider legs",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("Starting at your [feet], a tingle runs up your [legs], not stopping until it reaches your thighs.  From the waist down, your strength completely deserts you, leaving you to fall hard on your [ass] in the dirt.  With nothing else to do, you look down, only to be mesmerized by the sight of midnight purple exoskeleton creeping up a perfectly human-looking calf.  It crests up your knee to envelop the joint in a many-faceted onyx coating.  Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton.  From a distance it would look almost like a dark purple, thigh-high boot, but you know the truth.  <b>You now have human-like legs covered in a midnight purple, arachnid exoskeleton.</b>");
				}
				setLowerBody(LowerBody.CHITINOUS_SPIDER_LEGS);
				player.legCount  = 2;
				player.coatColor = "midnight purple";
				player.coatColor2 = "midnight purple";
			},
			// is present
			function ():Boolean {
				return player.lowerBody === LowerBody.CHITINOUS_SPIDER_LEGS && player.legCount === 2;
			}
	);
	public const LegsAtlachNacha:Transformation = new SimpleTransformation("Atlach Nacha lower body",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					// No special text outside the event
					// outputText("");
				}
				setLowerBody(LowerBody.ATLACH_NACHA);
			},
			// is present
			function ():Boolean {
				return player.lowerBody === LowerBody.ATLACH_NACHA;
			}
	);
	
	/***
	 *    ██████  ███████  █████  ██████
	 *    ██   ██ ██      ██   ██ ██   ██
	 *    ██████  █████   ███████ ██████
	 *    ██   ██ ██      ██   ██ ██   ██
	 *    ██   ██ ███████ ██   ██ ██   ██
	 */
	
	
	public const RearAtlachNacha:Transformation = new SimpleTransformation("Atlach Nacha rear legs",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					if (player.rearBody.type !== RearBody.NONE) {
						var rear:EnumValue = RearBody.Types[player.rearBody.type];
						outputText("Your old " + rear.name + " " +
								(rear.plural ? "are" : "is") +
								" drooping leaving your back as smooth and unbroken as the day you entered the portal. But this state did not last long. ");
					}
					outputText("Pressure is building in multiple spots on your upper back. You can’t help but groan with relief when finally the pressure peaks and many thick protrusions burst impatiently out of your [skin.type]. Four new chitinous limbs thrust their way into being, skittering aimlessly at the air as if to find purchase. After a moment of concentration you cause one of the spindly to rear around into your hand to take a closer look at it.It definitively looks like a spider leg except there's a set of red eyes at the end of the limb blinking back at you. <b>You now have two pairs of spider legs up your back.</b>");
				}
				player.rearBody.type = RearBody.ATLACH_NACHA;
			},
			// is present
			function ():Boolean {
				return player.rearBody.type === RearBody.ATLACH_NACHA
			}
	);
	
	/***
	 *     █████  ██████  ███    ███ ███████
	 *    ██   ██ ██   ██ ████  ████ ██
	 *    ███████ ██████  ██ ████ ██ ███████
	 *    ██   ██ ██   ██ ██  ██  ██      ██
	 *    ██   ██ ██   ██ ██      ██ ███████
	 */
	
	/**
	 * Also paint coat black
	 */
	public const ArmsSpider:Transformation = new SimpleTransformation("Spider arms",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					if (player.arms.type == Arms.HARPY || player.arms.type == Arms.HUMAN) {
						//(Bird pretext)
						if (player.arms.type == Arms.HARPY) outputText("The feathers covering your arms fall away, leaving them to return to a far more human appearance.  ");
						outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a shiny black carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.");
					} else {
						if (player.arms.type == Arms.BEE) outputText("The fizz covering your upper arms starting to fall down leaving only shiny black chitin clad arms.");
						else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRAGON) outputText("The scales covering your upper arms starting to fall down leaving only shiny black chitin clad arms.");
						else if (player.arms.type == Arms.MANTIS) outputText("The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the [skinfurscales] into a shiny black carapace</b>.");
						else outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a shiny black carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.");
					}
				}
				setArmType(Arms.SPIDER);
				player.coatColor = "black";
			},
			// is present
			function ():Boolean {
				return player.arms.type === Arms.SPIDER;
			}
	);

	public const ArmsAtlach:Transformation = new SimpleTransformation("Spider arms",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					if (player.arms.type == Arms.HARPY || player.arms.type == Arms.HUMAN) {
						//(Bird pretext)
						if (player.arms.type == Arms.HARPY) outputText("The feathers covering your arms fall away, leaving them to return to a far more human appearance.  ");
						outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a midnight purple carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.");
					} else {
						if (player.arms.type == Arms.BEE) outputText("The fizz covering your upper arms starting to fall down leaving only midnight purple chitin clad arms.");
						else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRAGON) outputText("The scales covering your upper arms starting to fall down leaving only midnight purple chitin clad arms.");
						else if (player.arms.type == Arms.MANTIS) outputText("The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the [skinfurscales] into a midnight purple carapace</b>.");
						else outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a midnight purple carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.");
					}
				}
				setArmType(Arms.SPIDER);
				player.coatColor = "midnight purple";
				player.coatColor2 = "midnight purple";
			},
			// is present
			function ():Boolean {
				return player.arms.type === Arms.SPIDER;
			}
	);
	
	/***
	 *     ██████  ██ ██      ██      ███████
	 *    ██       ██ ██      ██      ██
	 *    ██   ███ ██ ██      ██      ███████
	 *    ██    ██ ██ ██      ██           ██
	 *     ██████  ██ ███████ ███████ ███████
	 */
	
	public const GillsNone:Transformation = new SimpleTransformation("No gills",
			// apply effect
			function (doOutput:Boolean):void {
				updateGills(Gills.NONE)
			},
			// is present
			function ():Boolean {
				return player.gills.type === Gills.NONE;
			}
	);
	
	/***
	 *    ██████  ██████  ███████  █████  ███████ ████████ ███████
	 *    ██   ██ ██   ██ ██      ██   ██ ██         ██    ██
	 *    ██████  ██████  █████   ███████ ███████    ██    ███████
	 *    ██   ██ ██   ██ ██      ██   ██      ██    ██         ██
	 *    ██████  ██   ██ ███████ ██   ██ ███████    ██    ███████
	 */
	
	public const BreastsGrowUpToDD:Transformation = new SimpleTransformation("Grow breasts up to DD",
			// apply effect
			function (doOutput:Boolean):void {
				var row:int = player.smallestTitRow();
				if (doOutput) {
					outputText("Your chest aches and tingles, and your hands reach up to scratch at it unthinkingly.  Just as you start to scratch at your " + breastDescript(row) + ", your chest pushes out in slight but sudden growth.");
				}
				player.breastRows[row].breastRating++;
			},
			// is present
			function ():Boolean {
				return player.smallestTitSize() >= 6;
			}
	);
	
	public const BreastRowsRemoveToOne:Transformation = new SimpleTransformation("One pair of breasts",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("You stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ");
					if (player.bRows() >= 3) outputText("abdomen");
					else outputText("chest");
					outputText(". The " + nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ");
					if (player.hasFur()) outputText(player.hairColor + " " + player.skinDesc);
					else outputText(player.skinTone + " " + player.skinDesc);
					outputText(" remains. <b>You've lost a row of breasts!</b>");
				}
				dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
			},
			// is present
			function ():Boolean {
				return player.breastRows.length == 1;
			},
			// is possible
			function ():Boolean {
				return player.breastRows.length > 1;
			}
	);
	
	public const NipplesPerBreastOne:Transformation = new SimpleTransformation("One nipple per breast",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("A chill runs over your [allbreasts] and vanishes.  You stick a hand under your [armor] and discover that your extra nipples are missing!  You're down to just one per ");
					if (player.biggestTitSize() < 1) outputText("'breast'.");
					else outputText("breast.");
				}
				for (var i:int = 0; i < player.breastRows.length; i++) {
					player.breastRows[i].nipplesPerBreast = 1;
				}
			},
			// is present
			function ():Boolean {
				return player.averageNipplesPerBreast() == 1;
			},
			// is possible
			function ():Boolean {
				return player.averageNipplesPerBreast() > 1;
			}
	);
	
	public const NipplesBlack:Transformation = new SimpleTransformation("Black nipples",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("A tickling sensation plucks at your nipples and you cringe, trying not to giggle.  Looking down you are in time to see the last spot of flesh tone disappear from your [nipples].  They have turned an onyx black!");
				}
				player.createStatusEffect(StatusEffects.BlackNipples, 0, 0, 0, 0);
			},
			// is present
			function ():Boolean {
				return player.hasStatusEffect(StatusEffects.BlackNipples)
			},
			// is possible
			function ():Boolean {
				return !player.hasStatusEffect(StatusEffects.BlackNipples) && player.lowerBody !== LowerBody.GARGOYLE
			}
	);
	
	/***
	 *     █████  ███████ ███████
	 *    ██   ██ ██      ██
	 *    ███████ ███████ ███████
	 *    ██   ██      ██      ██
	 *    ██   ██ ███████ ███████
	 */
	
	public const AssGrowUpTo11:Transformation = new SimpleTransformation("Grow ass up to 11",
			// apply
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("You look over your shoulder at your [ass] only to see it expand just slightly. You gape in confusion before looking back at the remaining silk in your hands. You finish it anyway. Dammit!");
				}
				player.butt.type++;
			},
			// is present
			function ():Boolean {
				return player.butt.type < 11;
			}
	);
	
	/***
	 *    ███████ ███████ ██   ██ ██    ██  █████  ██
	 *    ██      ██       ██ ██  ██    ██ ██   ██ ██
	 *    ███████ █████     ███   ██    ██ ███████ ██
	 *         ██ ██       ██ ██  ██    ██ ██   ██ ██
	 *    ███████ ███████ ██   ██  ██████  ██   ██ ███████
	 *
	 *
	 */
	
	
	/***
	 *    ███████ ██████  ███████  ██████ ██  █████  ██          ████████ ███████ ███████
	 *    ██      ██   ██ ██      ██      ██ ██   ██ ██             ██    ██      ██
	 *    ███████ ██████  █████   ██      ██ ███████ ██             ██    █████   ███████
	 *         ██ ██      ██      ██      ██ ██   ██ ██             ██    ██           ██
	 *    ███████ ██      ███████  ██████ ██ ██   ██ ███████        ██    ██      ███████
	 */
	
	
	/***
	 *    ████████ ██ ███████ ██████  ███████ ██████      ████████ ███████ ███████
	 *       ██    ██ ██      ██   ██ ██      ██   ██        ██    ██      ██
	 *       ██    ██ █████   ██████  █████   ██   ██        ██    █████   ███████
	 *       ██    ██ ██      ██   ██ ██      ██   ██        ██    ██           ██
	 *       ██    ██ ███████ ██   ██ ███████ ██████         ██    ██      ███████
	 *
	 *
	 */
	
	public const TieredSpiderFace:GradualTransformation = new GradualTransformation("Spider face (gradual)", [
		FaceHuman,
		FaceSpiderFangs
	]);
	
	/***
	 *    ██      ██ ███████ ████████ ███████
	 *    ██      ██ ██         ██    ██
	 *    ██      ██ ███████    ██    ███████
	 *    ██      ██      ██    ██         ██
	 *    ███████ ██ ███████    ██    ███████
	 */
	
	
	public const List_AtlachNacha: /*Transformation*/ Array = [
		MutagenLibSpider,
		MutagenTouSpider,
		MutagenSpeSpider,
		SensUpSpider,
		
		VenomRechargeSpider,
		VaginaTightenAndMutagenLib,
		AssholeTightenAndMutagenLib,
		CocksThickenAll,
		BreastsGrowUpToDD,
		AssGrowUpTo11,

		EarsElfin,
		SkinChitin,
		TieredSpiderFace,
		makeHairColorTf(["midnight purple"]),
		new OrderedTransformation("EyesRedThenSpider", [
			makeEyeColorTf(["red"]),
			EyesSpiderAndMutagenInt
		]),
		BreastRowsRemoveToOne,
		NipplesPerBreastOne,
		NipplesBlack,
		ArmsAtlach,
		LegsAtlach,
		SpinneretAtlach,
		GillsNone,
		RearAtlachNacha
	];
}
}
