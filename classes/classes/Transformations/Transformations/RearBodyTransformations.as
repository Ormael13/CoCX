package classes.Transformations.Transformations {
import classes.BodyParts.*;
import classes.GeneticMemories.RearBodyMem;
import classes.Items.MutationsHelper;
import classes.Scenes.Metamorph;
import classes.StatusEffects;
import classes.Transformations.*;
import classes.internals.EnumValue;

/**
 * Base class for transformation events.
 */
public class RearBodyTransformations extends MutationsHelper {
	/*
    *    ██████  ███████  █████  ██████      ██████   ██████  ██████  ██    ██
    *    ██   ██ ██      ██   ██ ██   ██     ██   ██ ██    ██ ██   ██  ██  ██
    *    ██████  █████   ███████ ██████      ██████  ██    ██ ██   ██    ██
    *    ██   ██ ██      ██   ██ ██   ██     ██   ██ ██    ██ ██   ██    ██
    *    ██   ██ ███████ ██   ██ ██   ██     ██████   ██████  ██████     ██
    */

	/*
      */
	public const RearBodyNone: Transformation = new SimpleTransformation("No Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "A wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger in it. After a moment the pain passes, though your back is back to what you looked like when you entered this realm!";
				player.rearBody.type = RearBody.NONE;

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.NONE;
			}
	);

	public const RearBodyLionMane: Transformation = new SimpleTransformation("Lion Mane Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You suddenly feel hair growing all around your neck at a crazy pace. It soon get so thick it almost looks as if you're wearing a [haircolor] fur collar. <b>You now have a full lion mane around your neck.</b>";
				player.rearBody.type = RearBody.LION_MANE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.LION_MANE));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.LION_MANE;
			}
	);

	public const RearBodyDisplacerTentacles: Transformation = new SimpleTransformation("Displacer Tentacles Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.RearBodyNone, doOutput);

				desc += "Two large fleshy lumps explode from your shoulders and you scream in pain. These fleshy appendages weave and move like whips in your back and only stop doing so when you finally manage to calm yourself. <b>As you look back to see what's going on, you notice you now have a pair of tentacles with thick, fleshy heads. You can feel the air brushing over the sensitive needles and suction cups that cover both of them, your new venom glistening on the tips.</b>";
				player.rearBody.type = RearBody.DISPLACER_TENTACLES;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.DISPLACER_TENTACLES));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.DISPLACER_TENTACLES;
			}
	);

	public const RearBodyBatCollar: Transformation = new SimpleTransformation("Bat Collar Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "An intense itching sets in around your neck. Bringing your hands to your neck to scratch it, you find sparse, downy fuzz. As you scratch away, it continues lengthening and growing in density until you have a collar of fur around your neck.\n\n Well, this isn’t so bad, the scarf-like look is certainly nice, at the very least. <b>Your neck now sports a collar of fur.</b>";
				player.rearBody.type = RearBody.BAT_COLLAR;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.BAT_COLLAR));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.BAT_COLLAR;
			}
	);

	public const RearBodyRaijuMane: Transformation = new SimpleTransformation("Raiju Mane Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "The base of your neck tingles with delight as little sparks travel across your skin. Strands of hair quickly grow in, giving you a [haircolor] collar of fur around your neck. Several strands of your new fur collar are quite dark, arcing around it like lightning.";
				player.rearBody.type = RearBody.RAIJU_MANE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.RAIJU_MANE));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.RAIJU_MANE;
			}
	);

	public const RearBodyOrcaBlowhole: Transformation = new SimpleTransformation("Orca Blowhole Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.RearBodyNone, doOutput);

				desc += "Pain rushes just behind your shoulder blades as a hole opens up, air rushing in. The hole is burning making you groan in pain as air flows in and out. Eventually you get accustomed to breathing from your back like whales do, but it sure was a weird experience.";
				if (silly()) desc += " Well it doesn't matter because now you can break the world record of the longest breath holding by sitting on the ocean floor for more than 90 minutes.";
				player.rearBody.type = RearBody.ORCA_BLOWHOLE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.ORCA_BLOWHOLE));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.ORCA_BLOWHOLE;
			}
	);

	public const RearBodySharkFin: Transformation = new SimpleTransformation("Shark Fin Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You groan and slump down in pain, almost instantly regretting eating the tooth. You start sweating profusely and panting loudly, feeling the space between your shoulder blades shifting about. You hastily remove your [armor] just in time before a strange fin-like structure bursts from in-between your shoulders. You examine it carefully and make a few modifications to your [armor] to accommodate your new fin.";
				player.rearBody.type = RearBody.SHARK_FIN;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.SHARK_FIN));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.SHARK_FIN;
			}
	);

	public const RearBodyMetamorphicGoo: Transformation = new SimpleTransformation("Metamorphic Goo Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";
				TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyGoo,doOutput);

				desc += "You suddenly lose shape turning into a puddle on the ground. Confused you begin to try and stand up   At the center of the mass that is your translucent [color] body, you actually do have something solid that allows you to shape your form, a heart, or more accurately, a core. You try and pull yourself back up, translucent liquid arms and torso shaping back from your body mass as you need them. Once you've recovered the top of your goey human shape you sigh in relief. Curious you begin to try out your new very malleable form reshaping yourself in various forms from a cube to a literal human dildo. Giggling you take back your standard shape thinking of the many naughty things you can do now with this gooey body of yours.";

				player.rearBody.type = RearBody.METAMORPHIC_GOO;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.METAMORPHIC_GOO));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.METAMORPHIC_GOO;
			},
			function (): Boolean {
				return player.rearBody.type != RearBody.METAMORPHIC_GOO && player.lowerBody == LowerBody.GOO;
			}
	);

	public const RearBodyGhostlyAura: Transformation = new SimpleTransformation("Ghostly Aura Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "A chill makes its way through your body. You can feel your body has changed and become something more incorporeal. An eerie glow surrounds your body as you fully become an otherworldly apparition.";

				player.rearBody.type = RearBody.GHOSTLY_AURA;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.GHOSTLY_AURA));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.GHOSTLY_AURA;
			}
	);

	public const RearBodyTentacleEyestalks: Transformation = new SimpleTransformation("Tentacle Eyestalks Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.rearBody.type != RearBody.TENTACLE_EYESTALKS) {
					desc += "You gasp in alien pleasure as two large protrusions explode from your back freeing a pair of black tentacle stalks. The tips open to a set of eyes the same color as yours gazing at the world. These eyes share their vision with your central eye allowing you to see the world in a full peripheral view. <b>You now have two eye mounted tentacle stalks on your back.</b>";

					player.createStatusEffect(StatusEffects.GazerEyeStalksPlayer, 2, 0, 0, 0);
					player.rearBody.type = RearBody.TENTACLE_EYESTALKS;
				}
				else {
					player.addStatusValue(StatusEffects.GazerEyeStalksPlayer, 1, 2);
					desc +="You gasp in alien pleasure as two new eye mounted tentacle stalks explode from your back joining your previous set. At first you're a little disoriented from being able to see in all those directions but eventually manage to adapt to the new change, the set dripping black oily fluids. <b>You now have "+player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer)+" eye mounted tentacle stalks on your back.</b>";
				}
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.TENTACLE_EYESTALKS));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.TENTACLE_EYESTALKS && player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10;
			}
	);

	public const RearBodyKraken: Transformation = new SimpleTransformation("Kraken Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "As you look at yourself for a second, you notice some small glowing pink dot appearing on your skin as it starts to change hue toward a ghostly white. You think of the deep sea predators using light to confound and capture prey. You realise that you now have <b>bioluminescent ghostly pale skin that will glow slightly even in the darkest reach of the ocean.</b>";

				player.skinColor = "ghostly pale";

				player.rearBody.type = RearBody.KRAKEN;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.KRAKEN));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.KRAKEN;
			}
	);

	public const RearBodyYetiFur: Transformation = new SimpleTransformation("Yeti Fur Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.HairChangeColor(["white"]), doOutput);

				TransformationUtils.applyTFIfNotPresent(transformations.SkinPlain);

				TransformationUtils.applyTFIfNotPresent(transformations.SkinFur(Skin.COVERAGE_LOW, { color: "white" }), false);

				desc += "Your skin itches incessantly around your crotch and chest. You scratch it, feeling as a coat of white fur sprouts in those areas. <b>You are now partially covered in white fur like a bikini.</b>";

				player.rearBody.type = RearBody.YETI_FUR;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.YETI));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.YETI_FUR;
			}
	);

	public const RearBodyGlacialAura: Transformation = new SimpleTransformation("Glacial Aura Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Cold… so cold! You ball yourself up, trying to get some heat but no matter how much you try it gets colder and colder. Just as you think you are about to freeze to death it stops. You look around you in confusion. The air is chilling yet you don't feel it. The ice at your feet covered up with snow and somehow you know deep down if you wanted you could conjure out a blizzard. <b>You gained a Glacial aura!</b>";

				player.rearBody.type = RearBody.GLACIAL_AURA;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.GLACIAL_AURA));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.GLACIAL_AURA;
			}
	);

	public const RearBodyFrostwyrm: Transformation = new SimpleTransformation("Frostwyrm Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You suddenly feel hair growing all around your neck at a crazy pace. It soon gets so thick it almost looks as if you're wearing a white fur collar. <b>Your neck is now well protected against the cold thanks to your thick fur collar.</b>";

				player.rearBody.type = RearBody.FROSTWYRM;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.FROSTWYRM));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.FROSTWYRM;
			}
	);

	public const RearBodySnailShell: Transformation = new SimpleTransformation("Snail Shell Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your back begins to hurt as you feel like your flesh and bones are being torn out. You lie down, screaming in pain as your back keeps on expanding, breathing heavily. Not just that but you feel eviscerated as your guts and organs shift places within your body, causing you to puke from the growing nausea. Eventually it all stops and you take a glimpse behind you. A massive shell has grown behind your back, your organs relocating to inside its safety. Geez, what a deep breath! it's like your lungs doubled in size. You finally manage to calm down and crawl your way to a resting spot in order to finish coping with the transformation and the now massive weight on your back. <b>You now have a Shell.</b>";

				player.chitinColor = "brown";
				player.rearBody.type = RearBody.SNAIL_SHELL;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.SNAIL_SHELL));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.SNAIL_SHELL;
			}
	);

	public const RearBodyCentipede: Transformation = new SimpleTransformation("Centipede Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your neck tingles and begins to itch all of a sudden. You reach up to scratch when your fingers brush up against something hard. You look down to find a pair of grasping pincer like stingers around your neck. They open and close at will and tuck away easily when not in use. <b>It will be easier to hold onto and bite enemies with your new maxillipeds.</b>";

				player.rearBody.type = RearBody.CENTIPEDE;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.CENTIPEDE));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.CENTIPEDE;
			}
	);

	public const RearBodyFenrirIceSpikes: Transformation = new SimpleTransformation("Fenrir Ice Spikes Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "";

				player.rearBody.type = RearBody.FENRIR_ICE_SPIKES;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.FENRIR_ICE_SPIKES));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.FENRIR_ICE_SPIKES;
			}
	);

	public const RearBodyWolfCollar: Transformation = new SimpleTransformation("Wolf Collar Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You suddenly feel hair growing around your neck at a crazy pace. It soon gets so thick it almost looks as if you're wearing a [haircolor] fur collar. <b>You now have a wolf collar around your neck.</b>";

				player.rearBody.type = RearBody.WOLF_COLLAR;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.WOLF_COLLAR));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.WOLF_COLLAR;
			}
	);

	public const RearBodyHellhoundCollar: Transformation = new SimpleTransformation("Hellhound Collar Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "";

				player.rearBody.type = RearBody.HELLHOUND_COLLAR;
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.HELLHOUND_COLLAR;
			}
	);

	public const RearBodyFurCoat: Transformation = new SimpleTransformation("Fur Coat Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "";

				player.rearBody.type = RearBody.FUR_COAT;
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.FUR_COAT));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.FUR_COAT;
			}
	);

	public const RearBodyAtlachNacha: Transformation = new SimpleTransformation("Atlach Nacha rear legs",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				if (player.rearBody.type !== RearBody.NONE) {
					var rear: EnumValue = RearBody.Types[player.rearBody.type];
					desc += "Your old " + rear.name + " " + (rear.plural ? "are" : "is") + " drooping leaving your back as smooth and unbroken as the day you entered the portal. But this state did not last long. ";
				}

				desc += "Pressure is building in multiple spots on your upper back. You can’t help but groan with relief when finally the pressure peaks and many thick protrusions burst impatiently out of your [skin.type]. Four new chitinous limbs thrust their way into being, skittering aimlessly at the air as if to find purchase. After a moment of concentration you cause one of the spindly to rear around into your hand to take a closer look at it.It definitively looks like a spider leg except there's a set of red eyes at the end of the limb blinking back at you. <b>You now have two pairs of spider legs up your back.</b>";

				if (doOutput) outputText(desc);
				player.rearBody.type = RearBody.ATLACH_NACHA;
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.ATLACH_NACHA));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.ATLACH_NACHA
			}
	);

	public const RearBodyCobraHood: Transformation = new SimpleTransformation("Cobra Hood",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

				desc += "Pain lances through your neck as your [skin.type] flesh begins to ondulate and change. It hurts but thankfully the pain is short lived and as soon as you are relieved from it you press a hand behind your neck to check for the changes. It would appear the behind of your head all the way to the middle of your back is covered with one large fleshy hood not unlike that of a cobra. You will likely be able to intimidate your foes into submission with your brand new <b>Cobra hood!</b>";
				player.rearBody.type = RearBody.COBRA_HOOD;

				if (doOutput) outputText(desc);
				player.rearBody.type = RearBody.COBRA_HOOD;
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.COBRA_HOOD));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.COBRA_HOOD
			}
	);

	public const RearBodyAbyssalSharkFin: Transformation = new SimpleTransformation("Abyss Shark Fin Rear Body",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You groan, slumping in pain. Almost immediately, you feel a tinge of regret for eating the tooth. Sweat streaks down your face as you struggle to swallow in air, your breathing staggers as your body begins shifting to accommodate the transformation. ";
				desc += "You"+(player.isNaked()?"r shoulder blades move apart as fin-like protrusions form between them":" hastily remove your [armor] as your shoulder blades move apart as fin-like protrusions form between them")+". Just above your ass, another fin expels from your body, growing firmly into place. You examine the new appendages carefully, thinking about how armor you'll wear must be modified to withstand your new shapes.";
				if (player.isNaked()) desc += " Though, perhaps armor is not the biggest concern you have with your new body.";
				player.rearBody.type = RearBody.ABYSSAL_SHARK_FIN;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.ABYSSAL_SHARK_FIN));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.ABYSSAL_SHARK_FIN;
			}
	);

	public const RearBodyArigeanAuraRed: Transformation = new SimpleTransformation("Arigean Red Aura",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "";

				player.rearBody.type = RearBody.ARIGEAN_RED_AURA;
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.ARIGEAN_RED_AURA;
			}
	);

	public const RearBodyArigeanAuraYellow: Transformation = new SimpleTransformation("Arigean Yellow Aura",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "";

				player.rearBody.type = RearBody.ARIGEAN_YELLOW_AURA;
				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.ARIGEAN_YELLOW_AURA;
			}
	);
	public const RearBodyMoth: Transformation = new SimpleTransformation("Moth Fluffy Collar",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your neck begins to itch as you scratch it, when the itching stops you look in your reflection and you find a fuzzy collar of fur around your neck. <b>You now have a fluffy collar.</b>";
				player.rearBody.type = RearBody.MOTH_COLLAR;

				if (doOutput) outputText(desc);
				//Metamorph.unlockMetamorph(RearBodyMem.getMemory(RearBodyMem.ABYSSAL_SHARK_FIN));
			},
			// is present
			function (): Boolean {
				return player.rearBody.type === RearBody.MOTH_COLLAR;
			}
	);
	/*
  */
}
}
