/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;
import classes.StatusEffects;
import classes.BodyParts.Tail;

public class LowerBody extends SaveableBodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("HUMAN", "HOOFED")
	 * - name: human-readable default name, ("human", "hoofed")
	 *
	 * - metamorphFlag: which status effect defines whether the metamorph was unlocked (if there's none, it can't be unlocked)
	 * - metamorphCost: how much SF it costs to metamorph this part (defaults to 100)
	 * - metamorphTitle: name displayed on the metamorph button
	 * - tfDesc: TF scene for the part
	 * - tfDescFunc: function that returns a tfDesc string value (tfDesc is ignored if this exists)
	 * - tfFunc: effects of the TF on the creature
	 *
	 * - legCount: number of legs the part has (defaults to 2)
	 *
	 * - legs: what the part's legs are called (defaults to "legs")
	 * - legsPrefixes: optional list of descriptions to pick randomly before legs (e.g. *vulpine* legs)
	 *
	 * - leg: what the part's leg is called (defaults to "leg")
	 * - legPrefixes: optional list of descriptions to pick randomly before leg (e.g. *vulpine* leg)
	 *
	 * - feet: what the part's leg is called (defaults to "leg")
	 * - feetPrefixes: optional list of descriptions to pick randomly before feet (e.g. *vulpine* feet)
	 *
	 * - foot: what the part's leg is called (defaults to "leg")
	 * - footPrefixes: optional list of descriptions to pick randomly before foot (e.g. *vulpine* foot)
	 *
	 * - appearanceDesc: lower body part description for PlayerAppearance.as
	 * - appearanceDescFunc: function that returns an appearanceDesc string value (appearanceDesc is ignored if this exists)
	 *
	 * - crotchDesc: crotch description for PlayerAppearance.as, such as whether there are tentacles covering the crotch (not a penis or vagina description)
	 * - crotchDescFunc: function that returns a crotchDesc string value (crotchDesc is ignored if this exists)
	 *
	 * - noLowerGarment: whether the part disables wearing lower garment (defaults to false)
	 * - noLowerGarmentFunc: function that returns a noLowerGarment boolean value (noLowerGarment is ignored if this exists)
	 *
	 * - hasTentacles: part has tentacles and enables tentacle actions
	 * - hasPincers: part has pincers and enables pincer actions
	 * - hasTalons: part has talons and enables talon actions
	 * - hasClaws: part enables claw actions
	 *
	 * - draconic: part counts as "dragon or variant"
	 * - feline: part counts as "cat or variant"
	 * - eggLayer: part allows laying eggs if conditions are met
	 *
	 * - tail: part includes or is tail
	 * - tailSlam: whether the part enables Tail Slam
	 *
	 * - is[TypeHere]: whether the part counts the creature as specific type (ex: Drider, Goo, Naga, Scylla, etc), defaults to false with no property
	 */

	public static var Types:/*EnumValue*/Array = [];

	public var legCount:int = 2;

	public static const HUMAN:int = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {
		name: "human",
		appearanceDesc: "{legCount} human legs grow down from your [hips], ending in normal human feet.",
		metamorphFlag: StatusEffects.UnlockedHumanLowerBody,
		metamorphCost: 500,
		metamorphTitle: "Human",
		tfDescFunc: function(creature: *, restoration: String = ""): String {
			var desc: String = "";
			if (creature.isTaur()) {
				desc += "Your quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side. Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow. When it finally stops, <b>you look down to behold your new pair of human legs</b>!";
			} else {
				if (creature.isGoo()) {
					desc += "Your lower body rushes inward, molding into two leg-like shapes that gradually stiffen up. In moments they solidify into normal-looking legs, complete with regular, human feet.";
				}
				if (creature.isNaga()) {
					desc += "You collapse as your sinuous snake-tail tears in half, shifting into legs. The pain is immense, particularly where your new feet are forming.";
				}
				if (creature.isScylla()) {
					desc += "You collapse as your tentacle legs starts to merge. The pain is immense, particularly where your new feet are forming.";
				}
				//(Non-human -> Normal Human Legs)
				if (creature.isBiped() && creature.lowerBody != LowerBody.HUMAN) {
					desc += "You collapse as your legs shift and twist. By the time the pain subsides, you notice that you have normal legs and normal feet.";
				}
				desc += " <b>You now have normal feet!</b>";
			}

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.HUMAN;
			creature.legCount = 2;
		}
	});

	public static const HOOFED:int = 1;
	EnumValue.add(Types, HOOFED, "HOOFED", {
		name: "hoofed",
		feet: "hooves",
		foot: "hoof",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = ""

			if (creature.isBiped()) {
				desc += "Your two legs are muscled and jointed oddly, covered in [skin coat.color] fur, and end in a bestial hooves.";
			}

			if (creature.isTaur()) {
				desc += "From the waist down, you have the body of a horse, with four muscled legs which are jointed oddly, covered in [skin coat.color] fur, and end in a bestial hooves."
			}

			return desc;
		},
		metamorphFlag: StatusEffects.UnlockedHoofedLegs,
		metamorphCost: 100,
		metamorphTitle: "Hoofed",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.isNaga()) {
				desc += "You collapse as your sinuous snake-tail tears in half, shifting into legs. The pain is immense, particularly in your new feet as they curl inward and transform into hooves!";
			} else {
				desc += "You stagger as your [feet] change, curling up into painful angry lumps of flesh. They get tighter and tighter, harder and harder, until at last they solidify into hooves!";
			}
			desc += " A coat of beastial fur springs up below your waist, itching as it fills in.<b> You now have hooves in place of your feet!</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.HOOFED;
			creature.legCount = 2;
		}

	});

	public static const DOG:int = 2;
	EnumValue.add(Types, DOG, "DOG", {
		name: "dog",
		feet: "paws",
		foot: "paw",
		appearanceDesc: "{legCount} digitigrade legs grow downwards from your waist, ending in dog-like hind-paws."
	});

	public static const NAGA:int = 3;
	EnumValue.add(Types, NAGA, "NAGA", {
		name: "naga",
		legCount: 1,
		legs: "snake-like coils",
		leg: "snake-tail",
		feet: "coils",
		foot: "coiled tail",
		appearanceDesc: "Below your waist, your flesh is fused together into a very long snake-like tail.",
		metamorphFlag: StatusEffects.UnlockedSnakeLowerBody,
		metamorphCost: 100,
		metamorphTitle: "Naga",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody == LowerBody.SCYLLA) {
				desc += "You collapse as your tentacle legs starts to merge and the pain is immense. Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience.\n\nOnce you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's.";
			} else {
				desc += "You find it increasingly harder to keep standing as your legs start feeling weak.  You swiftly collapse, unable to maintain your own weight. Trying to get back up, you realize that the skin on the inner sides of your thighs is merging together like it was being sewn by an invisible needle. The process continues through the length of your [legs], eventually reaching your [feet].\n\nJust when you think that the transformation is over, you find yourself pinned to the ground by an overwhelming sensation of pain. You hear the horrible sound of your bones snapping, fusing together and changing into something else while you contort in unthinkable agony.\n\nSometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's.\n\n";
			}
			desc += "Wondering what happened to your sex, you pass your hand down the front of your body until you find a large, horizontal slit around your pelvic area, which contains all of your sexual organs.";
			if (creature.balls > 0 && creature.ballSize > 10) {
				desc += " You're happy not to have to drag those testicles around with you anymore.";
			}
			desc += " But then, scales start to form on the surface of your skin, slowly becoming visible, recoloring all of your body from the waist down in a snake-like pattern. The feeling is... not that bad actually, kind of like callous, except on your whole lower body.\n\nThe transformation complete, you get up, standing on your newly formed snake tail. You can't help feeling proud of this majestic new body of yours.";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.NAGA;
			creature.legCount = 1;
		},
		tailSlam: true,
		isNaga: true
	});

	public static const CENTAUR:int = 4;//[Deprecated] use HOOFED and legCount = 4
	EnumValue.add(Types, CENTAUR, "CENTAUR", {
		name: "centaur",
		leg: "equine leg",
		feet: "hooves",
		foot: "hoof",
		centaur: true
	});

	public static const DEMONIC_HIGH_HEELS:int = 5;
	EnumValue.add(Types, DEMONIC_HIGH_HEELS, "DEMONIC_HIGH_HEELS", {
		name: "demonic high-heels",
		feet: "demonic high-heels",
		appearanceDesc: "Your {legCount} perfect lissome legs end in mostly human feet, apart from the horns protruding straight down from the heel that force you to walk with a sexy, swaying gait.",
		metamorphFlag: StatusEffects.UnlockedDemonHighHeels,
		metamorphCost: 100,
		metamorphTitle: "Dem. H. Heels",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody != LowerBody.HUMAN) {
				desc += LowerBody.Types[LowerBody.HUMAN].tfDescFunc(creature);
				LowerBody.Types[LowerBody.HUMAN].tfFunc(creature);
				desc += "\n\n";
			}

			desc += "Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your [feet]. Something hard breaks through your sole from the inside out. The pain slowly diminishes and your eyes look along a human leg to a thin and sharp horns protruding from the heel. When you relax, your feet are pointing down and their old posture is only possible with an enormous effort. <b>Your feet are now formed into demonic high-heels.</b> Tentatively you stand up and try to take a few steps. To your surprise you feel as if you were born with this and stride vigorously forward, hips swaying.";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			creature.legCount = 2;
		}
	});

	public static const DEMONIC_CLAWS:int = 6;
	EnumValue.add(Types, DEMONIC_CLAWS, "DEMONIC_CLAWS", {
		name: "demonic claws",
		feet: "demonic foot-claws",
		appearanceDesc: "Your {legCount} lithe legs are capped with flexible clawed feet. Sharp black nails grow where once you had toe-nails, giving you fantastic grip.",
		metamorphFlag: StatusEffects.UnlockedDemonClawedLegs,
		metamorphCost: 100,
		metamorphTitle: "Dem. Claws",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody != LowerBody.HUMAN) {
				desc += LowerBody.Types[LowerBody.HUMAN].tfDescFunc(creature);
				LowerBody.Types[LowerBody.HUMAN].tfFunc(creature);
				desc += "\n\n";
			}

			desc += "Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your [feet]. Something hard breaks through your sole from the inside out as your toes splinter and curve cruelly. The pain slowly diminishes and your eyes look along a human leg that splinters at the foot into a claw with sharp black nails. When you relax, your feet grip the ground easily. <b>Your feet are now formed into demonic claws.</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.DEMONIC_CLAWS;
		}
	});

	public static const BEE:int = 7;
	EnumValue.add(Types, BEE, "BEE", {
		name: "bee",
		appearanceDesc: "Your {legCount} legs are covered in a shimmering insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than an exoskeleton. A bit of downy yellow and black fur fuzzes your upper thighs, just like a bee.",
		metamorphFlag: StatusEffects.UnlockedBeeLegs,
		metamorphCost: 100,
		metamorphTitle: "Bee",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody != LowerBody.HUMAN) {
				desc += LowerBody.Types[LowerBody.HUMAN].tfDescFunc(creature);
				LowerBody.Types[LowerBody.HUMAN].tfFunc(creature);
				desc += "\n\n";
			}

			desc += "Your legs tremble with sudden unbearable pain, as if they're being ripped apart from the inside out and being stitched together again all at once. You scream in agony as you hear bones snapping and cracking. A moment later the pain fades and you are able to turn your gaze down to your beautiful new legs, covered in shining black chitin from the thigh down, and downy yellow fuzz along your upper thighs.";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.BEE;
		}
	});

	public static const GOO:int = 8;
	EnumValue.add(Types, GOO, "GOO", {
		name: "goo",
		legs: "mounds of goo",
		leg: "mound of goo",
		feet: "slimey cillia",
		foot: "slimey undercarriage",
		legCount: 1,
		appearanceDesc: "In place of legs you have a shifting amorphous blob. Thankfully it's quite easy to propel yourself around on. The lowest portions of your [armor] float around inside you, bringing you no discomfort.",
		isGoo: true
	});

	public static const CAT:int = 9;
	EnumValue.add(Types, CAT, "CAT", {
		name: "cat",
		appearanceDesc: "{legCount} digitigrade legs grow downwards from your waist, ending in soft, padded cat-paws.",
		metamorphFlag: StatusEffects.UnlockedCatLegs,
		metamorphCost: 100,
		metamorphTitle: "Cat",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody == LowerBody.HOOFED) {
				desc += "You feel your hooves suddenly splinter, growing into five unique digits. Their flesh softens as your hooves reshape into furred cat paws. <b>You now have cat paws.</b>";
				if (creature.isTaur()) {
					desc += " You feel woozy and collapse on your side. When you wake, you're no longer a centaur and your body has returned to a humanoid shape.";
				}
			} else if (creature.lowerBody == LowerBody.GOO) {
				desc += "Your lower body rushes inward, molding into two leg-like shapes that gradually stiffen up. In moments they solidify into digitigrade legs, complete with soft, padded cat-paws. <b>You now have cat-paws!</b>";
			} else {
				desc += "You scream in agony as you feel the bones in your [feet] break and begin to rearrange. When the pain fades, you feel surprisingly well-balanced. <b>You now have cat paws.</b>";
			}

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.CAT;
			creature.legCount = 2;
		},
		canPounce: true,
		feline: true
	});

	public static const LIZARD:int = 10;
	EnumValue.add(Types, LIZARD, "LIZARD", {
		name: "lizard",
		appearanceDesc: "{legCount} digitigrade legs grow down from your [hips], ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back.",
		metamorphFlag: StatusEffects.UnlockedLizardLegs,
		metamorphCost: 100,
		metamorphTitle: "Lizard",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody == LowerBody.HOOFED) {
				desc += "You scream in agony as you feel your hooves crack and break apart, beginning to rearrange. Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.";
			} else if (creature.isTaur()) {
				desc += "Your lower body is wracked by pain! Once it passes, you discover that you're standing on digitigrade legs with lizard-like claws.";
			} else if (creature.lowerBody == LowerBody.HUMAN || creature.lowerBody == LowerBody.DOG || creature.lowerBody == LowerBody.DEMONIC_HIGH_HEELS || creature.lowerBody == LowerBody.DEMONIC_CLAWS || creature.lowerBody == LowerBody.PLANT_HIGH_HEELS || creature.lowerBody == LowerBody.PLANT_ROOT_CLAWS || creature.lowerBody == LowerBody.BEE || creature.lowerBody == LowerBody.CAT || creature.lowerBody == LowerBody.LIZARD) {
				desc += "You scream in agony as you feel the bones in your legs break and begin to rearrange. They change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.";
			} else {
				desc += "Pain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration. The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.";
			}
			desc += " <b>You have reptilian legs and claws!</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.LIZARD;
			creature.legCount = 2;
		}
	});

	public static const PONY:int = 11;
	EnumValue.add(Types, PONY, "PONY", {
		name: "pony",
		legs: "cute pony-legs",
		leg: "cartoonish pony-leg",
		feet: "flat pony-feet",
		foot: "flat pony-foot",
		legCount: 4,
		appearanceDescFunc: function(creature: *): String {
			var desc: String = ""

			if (creature.isTaur()) {
				desc += "From the waist down, you have an incredibly cute and cartoonish parody of a horse's body, with all four legs ending in flat, rounded feet."
			}

			return desc;
		}
	});

	public static const BUNNY:int = 12;
	EnumValue.add(Types, BUNNY, "BUNNY", {
		name: "bunny",
		legsPrefixes: ["fuzzy bunny", "fur-covered", "furry", ""],
		legPrefixes: ["fuzzy bunny", "fur-covered", "furry", ""],
		feetPrefixes: ["large bunny", "rabbit", "large", ""],
		footPrefixes: ["large bunny", "rabbit", "large", ""],
		appearanceDesc: "Your {legCount} legs thicken below the waist as they turn into soft-furred rabbit-like legs. You even have large bunny feet that make hopping around a little easier than walking."
	});

	public static const HARPY:int = 13;
	EnumValue.add(Types, HARPY, "HARPY", {
		name: "harpy",
		legsPrefixes: ["bird-like", "feathered", ""],
		legPrefixes: ["bird-like", "feathered", ""],
		feetPrefixes: ["taloned", ""],
		foottPrefixes: ["taloned", ""],
		appearanceDesc: "Your {legCount} legs are covered with [haircolor] plumage. Thankfully the thick, powerful thighs are perfect for launching you into the air, and your feet remain mostly human, even if they are two-toed and tipped with talons.",
		metamorphFlag: StatusEffects.UnlockedHarpyLegs,
		metamorphCost: 100,
		metamorphTitle: "Harpy",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (!creature.isGoo()) {
				desc += "Your [legs] creak ominously a split-second before they go weak and drop you on the ground. They go completely limp, twisting and reshaping before your eyes in ways that make you wince. Your lower body eventually stops, but the form it's settled on is quite thick in the thighs. Even your [feet] have changed. ";
			} else {
				desc += "Your gooey undercarriage loses some of its viscosity, dumping you into the puddle that was once your legs. As you watch, the fluid pulls together into a pair of distinctly leg-like shapes, solidifying into a distinctly un-gooey form. You've even regained a pair of feet! ";
			}

			desc += "While humanoid in shape, they have two large, taloned toes on the front and a single claw protruding from the heel. The entire ensemble is coated in [haircolor] feathers from ankle to hip, reminding you of the bird-women of the mountains. <b>You now have harpy legs!</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.HARPY;
			creature.legCount = 2;
		},
		hasTalons: true,
		eggLayer: true
	});

	public static const KANGAROO:int = 14;
	EnumValue.add(Types, KANGAROO, "KANGAROO", {
		name: "kangaroo",
		feet: "foot-paws",
		foot: "foot-paw",
		appearanceDesc: "Your {legCount} furry legs have short thighs and long calves, with even longer feet ending in prominently-nailed toes."
	});

	public static const CHITINOUS_SPIDER_LEGS:int = 15;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, CHITINOUS_SPIDER_LEGS, "CHITINOUS_SPIDER_LEGS", {
		name: "chitinous spider legs",
		appearanceDesc: "Your {legCount} legs are covered in a reflective [skin coat.color], insectile carapace up to your mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.",
		metamorphFlag: StatusEffects.UnlockedSpiderLegs,
		metamorphCost: 100,
		metamorphTitle: "Spider",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";


			if (creature.lowerBody != LowerBody.HUMAN) {
				desc += LowerBody.Types[LowerBody.HUMAN].tfDescFunc(creature);
				LowerBody.Types[LowerBody.HUMAN].tfFunc(creature);
				desc += "\n\n";
			}

			desc += "Starting at your [feet], a tingle runs up your [legs], not stopping until it reaches your thighs. From the waist down, your strength completely deserts you, leaving you to fall hard on your [butt] in the dirt. With nothing else to do, you look down, only to be mesmerized by the sight of black exoskeleton creeping up a perfectly human-looking calf. It crests up your knee to envelop the joint in a many-faceted onyx coating. Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton. From a distance it would look almost like a black, thigh-high boot, but you know the truth. <b>You now have human-like legs covered in a black, arachnid exoskeleton.</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.CHITINOUS_SPIDER_LEGS;
		}
	});

	public static const DRIDER:int = 16;
	EnumValue.add(Types, DRIDER, "DRIDER", {
		name: "drider",
		legCount: 8,
		legs: "spider legs",
		appearanceDesc: "Where your legs would normally start, you have grown the body of a spider, with {legCount} spindly legs that sprout from its sides.",
		metamorphFlag: StatusEffects.UnlockedDriderLegs,
		metamorphCost: 500,
		metamorphTitle: "Drider",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";


			if (creature.lowerBody != LowerBody.CHITINOUS_SPIDER_LEGS) {
				desc += LowerBody.Types[LowerBody.CHITINOUS_SPIDER_LEGS].tfDescFunc(creature);
				LowerBody.Types[LowerBody.CHITINOUS_SPIDER_LEGS].tfFunc(creature);
				desc += "\n\n";
			}

			// TODO: Call metamorph of SPIDER_ABDOMEN
			if (creature.tailType != Tail.SPIDER_ADBOMEN) {
				creature.tailType = Tail.SPIDER_ADBOMEN;
			}

			desc += "You find yourself suddenly paralyzed below the waist. Your dark, reflective legs splay out and drop you flat on your back. Before you can sit up, you feel tiny feelers of pain mixed with warmth and tingling running through them. Terrified at the thought of all the horrible changes that could be wracking your body, you slowly sit up, expecting to find yourself turned into some incomprehensible monstrosity from the waist down. As if to confirm your suspicions, the first thing you see is that your legs have transformed into eight long, spindly legs. Instead of joining directly with your hips, they now connect with the spider-like body that has sprouted in place of where your legs would normally start. Your abdomen has gotten even larger as well. Once the strength returns to your new, eight-legged lower body, you struggle up onto your pointed 'feet', and wobble around, trying to get your balance. As you experiment with your new form, you find you're even able to twist the spider half of your body down between your legs in an emulation of your old, bipedal stance. That might prove useful should you ever want to engage in 'normal' sexual positions, particularly since your [butt] is still positioned just above the start of your arachnid half. <b>You're now a drider.</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.DRIDER;
			creature.legCount = 8;
		},
		isDrider: true
	});

	public static const FOX:int = 17;
	EnumValue.add(Types, FOX, "FOX", {
		name: "fox",
		legsPrefixes: ["fox", "vulpine", "", ""],
		legPrefixes: ["fox", "vulpine", "", ""],
		feet: "paws",
		feetPrefixes: ["soft padded", "fox", ""],
		foot: "paw",
		footPrefixes: ["soft padded", "fox", "", ""],
		appearanceDesc: "Your {legCount} fox legs are crooked into high knees with hocks and long feet; cute bulbous toes decorate the ends.",
		metamorphFlag: StatusEffects.UnlockedFoxLowerBody,
		metamorphCost: 100,
		metamorphTitle: "Fox",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.isTaur()) {
				desc += "You shiver as the strength drains from your back legs. Shaken, you sit on your haunches, forelegs braced wide to stop you from tipping over; their hooves scrape the dirt as your lower body shrinks, dragging them backward until you can feel the upper surfaces of your hindlegs with their undersides. A wave of nausea and vertigo overtakes you, and you close your eyes to shut out the sensations. When they reopen, what greets them are not four legs, but only two... and those roughly in the shape of your old hindleg, except for the furry toes where your hooves used to be. <b>You now have fox legs!</b>";
			} else if (creature.isNaga()) {
				desc += "Your scales split at the waistline and begin to peel, shedding like old snakeskin. If that weren't curious enough, the flesh - not scales - underneath is pink and new, and the legs it covers crooked into the hocks and elongated feet of a field animal. As the scaly coating falls and you step out of it, walking of necessity on your toes, a fine powder blows from the dry skin. Within minutes, it crumbles completely and is taken by the ever-moving wind. <b>Your legs are now those of a fox!</b>";
			} else if (creature.lowerBody == LowerBody.HOOFED || creature.lowerBody == LowerBody.DOG || creature.lowerBody == LowerBody.CAT || creature.lowerBody == LowerBody.BUNNY || creature.lowerBody == LowerBody.KANGAROO) {
				desc += "Your legs twitch and quiver, forcing you to your seat. As you watch, the ends shape themselves into furry, padded toes. <b>You now have fox feet!</b> Rather cute ones, actually.";
			} else if (creature.lowerBody == LowerBody.DRIDER) {
				desc += "Your legs buckle under you and you fall, smashing your abdomen on the ground. Though your control deserts and you cannot see behind you, still you feel the disgusting sensation of chitin loosening and sloughing off your body, and the dry breeze on your exposed nerves. Reflexively, your legs cling together to protect as much of their now-sensitive surface as possible. When you try to part them, you find you cannot. Several minutes pass uncomforably until you can again bend your legs, and when you do, you find that all the legs of a side bend together - <b>in the shape of a fox's leg!</b>";
			} else if (creature.isGoo()) {
				desc += "It takes a while before you notice that your gooey mounds have something more defined in them. As you crane your body and shift them around to look, you can just make out a semi-solid mass in the shape of a crooked, animalistic leg. You don't think much of it until, a few minutes later, you step right out of your swishing gooey undercarriage and onto the new foot. The goo covering it quickly dries up, as does the part you left behind, <b>revealing a pair of dog-like fox legs!</b>";
			} else {
				desc += "Your hamstrings tense painfully and begin to pull, sending you onto your face. As you writhe on the ground, you can feel your thighs shortening and your feet stretching";
				if (creature.lowerBody == LowerBody.BEE) {
						desc += ", while a hideous cracking fills the air";
				}
				desc += ". When the spasms subside and you can once again stand, <b>you find that your legs have been changed to those of a fox!</b>";
			}

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.FOX;
			creature.legCount = 2;
		}
	});

	public static const DRAGON:int = 18;
	EnumValue.add(Types, DRAGON, "DRAGON", {
		name: "dragon",
		appearanceDesc: "{legCount} human-like legs grow down from your [hips], sheathed in scales and ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back.",
		metamorphFlag: StatusEffects.UnlockedDraconicLegs,
		metamorphCost: 100,
		metamorphTitle: "Dragon",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody == LowerBody.DRIDER) {
				desc += "A disquieting feeling ripples through your arachnid abdomen, and you find yourself losing control of your body from the waist down. Your spidery legs flail madly as your abdomen visibly swells, chitin cracking ominously as the pressure builds up inside of you... and then explodes! You wipe the gore from your face in disgust, wondering why you feel no pain. Rolling over, you see that, caked with spider-slime, you now have a new pair of legs, human-like save for the scales and the bestial paws that serve as feet. <b>You now have dragon feet.</b>";
			} else if (creature.isNaga()) {
				desc += "You fall on your face to the ground, hissing and screeching in pain - it feels like someone has grabbed the tip of your tail, pulled it viciously straight, and is now splitting it up the middle with a knife! Paralyzed from the waist down, you claw desperately at the earth to try and alleviate the pain, and can only think to thank your lucky stars when it fades away. Looking down where your tail was, though the scales remain, you realize you've become a biped again, your new feet sporting bestial claws on their toes. <b>You now have dragon feet.</b>";
			} else if (creature.isGoo()) {
				desc += "A strange tingling sensation fills you, and you watch as your gooey blob of a body begins to ripple and shudder; you try to make it stop, but you can't control it. Before your eyes, it shapes itself into the appearance of legs, the colored slime growing denser and thicker, the surface membrane texturing itself to look like scales. Before you've quite realized what's happened, the slime has set like water freezing, leaving you with humanoid legs once again, though tipped with claws and very reptilian in appearance. <b>You now have dragon feet.</b>";
			} else if (creature.lowerBody == LowerBody.HOOFED) {
				desc += "You bellow in pain as your legs break and reform and your hooves seem to suddenly explode, the bones within twisting themselves into monstrous three-toed appendages, more like those of some terrible lizard-thing than anything else. <b>You now have dragon feet.</b>";
			} else if (creature.isTaur()) {
				desc += "You cry out as spasms of pain suddenly rip through your quadrupedal body, bringing you crashing onto the ground. Words cannot define the agony as muscles and bones twist and shift and collapse violently. When it's all over, you stagger upright, finding yourself standing on two legs again. Though covered in scales and with the paws of some monster lizard instead of feet, they otherwise look like your old human legs. <b>You now have dragon feet.</b>";
			} else if (creature.isScylla()) {
				desc += "Something weird happens in your tentacles as your limbs coil into two pillars of flesh and fuse together, your ";
				if (creature.gender == 1) {
					desc += "[vagina]";
				} else if (creature.gender == 3) {
					desc += " and ";
				}
				if (creature.cocks.length > 0) {
					desc += "[cock],";
				}
				desc += " moving back up between your leg to where it used to be. Bones starts to form in your limb and, before you know it, you are staring at a pair of normal human legs. The changes does not end there however. When the pain is over, you realize that you still stand atop human-looking legs, but your feet have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon feet.</b>";
			} else if (creature.isAlraune()) {
				desc += "Your petals all withers and fall off as your pitch and flower turn to dust leaving you with normal human legs. The changes does not stop there however. When the pain is over, you realize that you still stand atop human-looking legs, but your feet have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon feet.</b>";
			} else {
				desc += "You scream in agony as you feel the bones in your feet suddenly break and restructure themselves, toes fusing together, bone swelling out of the merged masses of flesh. When the pain is over, you realize that you still stand atop human-looking legs, but your feet have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon feet.</b>";
			}

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.DRAGON;
			creature.legCount = 2;
		},
		draconic: true
	});

	public static const RACCOON:int = 19;
	EnumValue.add(Types, RACCOON, "RACCOON", {
		name: "raccoon",
		legsPrefixes: ["raccoon-like", ""],
		legPrefixes: ["raccoon-like", ""],
		feet: "paws",
		feetPrefixes: ["raccoon", "long-toed", ""],
		foot: "paw",
		footPrefixes: ["raccoon", "long-toed", ""],
		appearanceDesc: "Your {legCount} legs, though covered in fur, are humanlike. Long feet on the ends bear equally long toes, and the pads on the bottoms are quite sensitive to the touch."
	});

	public static const FERRET:int = 20;
	EnumValue.add(Types, FERRET, "FERRET", {
		name: "ferret",
		appearanceDesc: "{legCount} furry, digitigrade legs form below your [hips]. The fur is thinner on the feet, and your toes are tipped with claws."
	});

	public static const CLOVEN_HOOFED:int = 21;
	EnumValue.add(Types, CLOVEN_HOOFED, "CLOVEN_HOOFED", {
		name: "cloven-hoofed",
		legsPrefixes: ["pig-like", "swine", "", ""],
		appearanceDesc: "{legCount} digitigrade legs form below your [hips], ending in cloven hooves.",
		metamorphFlag: StatusEffects.UnlockedClovenHoofedLegs,
		metamorphCost: 100,
		metamorphTitle: "Cl. Hoofed",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "You feel an odd sensation in your lower region. Your [feet] shift and you hear bones cracking as they reform. Fur grows on your legs and soon you're looking at a <b>new pair of goat legs</b>.";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.CLOVEN_HOOFED;
			creature.legCount = 2;
		}
	});

	//public static const :int = 22;not used anywhere legs number likely ^^

	public static const ECHIDNA:int = 23;
	EnumValue.add(Types, ECHIDNA, "ECHIDNA", {
		name: "echidna"
	});

	public static const DEERTAUR:int = 24;//[Deprecated] use CLOVEN_HOOFED and legCount = 4
	EnumValue.add(Types, DEERTAUR, "DEERTAUR", {
		name: "deertaur"
	});

	public static const SALAMANDER:int = 25;
	EnumValue.add(Types, SALAMANDER, "SALAMANDER", {
		name: "salamander",
		appearanceDesc: "{legCount} digitigrade legs covered in thick, leathery red scales up to the mid-thigh grow down from your [hips], ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back.",
		eggLayer: true,
		metamorphFlag: StatusEffects.UnlockedSalamanderLegs,
		metamorphCost: 100,
		metamorphTitle: "Salamander",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody == LowerBody.HOOFED) {
				desc += "You scream in agony as you feel your hooves crack and break apart, beginning to rearrange. Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.";
			} else if (creature.isTaur()) {
				desc += "Your lower body is wracked by pain! Once it passes, you discover that you're standing on digitigrade legs with salamander-like claws.";
			} else if (creature.lowerBody == LowerBody.HUMAN || creature.lowerBody == LowerBody.DOG || creature.lowerBody == LowerBody.DEMONIC_HIGH_HEELS || creature.lowerBody == LowerBody.DEMONIC_CLAWS || creature.lowerBody == LowerBody.DEMONIC_CLAWS || creature.lowerBody == LowerBody.PLANT_HIGH_HEELS || creature.lowerBody == LowerBody.BEE || creature.lowerBody == LowerBody.CAT || creature.lowerBody == LowerBody.LIZARD) {
				desc += "You scream in agony as you feel the bones in your legs break and begin to rearrange. They change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.";
			} else {
				desc += "Pain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration. The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.";
			}
			desc += " <b>You have salamander legs and claws!</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.SALAMANDER;
			creature.legCount = 2;
		}
	});

	public static const SCYLLA:int = 26;
	EnumValue.add(Types, SCYLLA, "SCYLLA", {
		name: "slippery octopus tentacles",
		appearanceDesc: "Where your legs would normally start, you have grown the body of an octopus, with {legCount} tentacle legs that sprout from your [hips].",
		crotchDescFunc: function(creature: *): String {
			var desc: String = "";

			switch (creature.gender) {
				case 1:
					desc += "Your sex is concealed between your front octopus tentacle legs dangling freely when not in use.";
				break;
				case 2:
					desc += "Your sex is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal your true self.";
				break;
				case 3:
					desc += "Your sex";
					if(creature.cockTotal() > 1) {
						desc += "es are ";
					} else {
						desc += " is ";
					}
					desc += "concealed between your front octopus tentacle legs dangling freely. Other set is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal it.";
			}

			return desc;
		},
		isScylla: true,
		hasTentacles: true
	});

	public static const MANTIS:int = 27;
	EnumValue.add(Types, MANTIS, "MANTIS", {
		name: "mantis",
		appearanceDesc: "Your {legCount} legs are covered in a shimmering [skin coat.color], insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.",
		metamorphFlag: StatusEffects.UnlockedMantisLegs,
		metamorphCost: 100,
		metamorphTitle: "Mantis",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "Your legs tremble with sudden unbearable pain, as if they’re being ripped apart from the inside out and being stitched together again all at once.\nYou scream in agony as you hear bones snapping and cracking. A moment later the pain fades and you are able to turn your gaze down to your beautiful new legs, covered in shining green chitin from the thigh down. <b>You now have mantis feet.</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.MANTIS;
			creature.legCount = 2;
		}
	});

	//public static const :int = 28;thunder mantis legs

	public static const SHARK:int = 29;
	EnumValue.add(Types, SHARK, "SHARK", {
		name: "shark",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = ""

			if (creature.isBiped()) {
				desc += "Your two legs are mostly human save for the webbing between your toes.";
			}

			if (creature.isTaur()) {
				desc += "Your four legs end in three-toed scaled paws with webbing between the toes, and an even larger webbing running on the entire length."
			}

			return desc;
		},
		metamorphFlag: StatusEffects.UnlockedSharkLegs,
		metamorphCost: 100,
		metamorphTitle: "Shark",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody != LowerBody.HUMAN) {
				desc += LowerBody.Types[LowerBody.HUMAN].tfDescFunc(creature);
				LowerBody.Types[LowerBody.HUMAN].tfFunc(creature);
				desc += "\n\n";
			}

			desc += "You feel something change in your feets as webbing forms between your toes. Well, this is sure to help you swim faster. <b>You now have webbed shark feet!</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.SHARK;
			creature.legCount = 2;
		}
	});

	public static const GARGOYLE:int = 30;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, GARGOYLE, "GARGOYLE", {
		name: "gargoyle",
		appearanceDesc: "Your {legCount} digitigrade [gargoylematerial] legs end in sharp-clawed stone feet. There are three long toes on the front, and a small hind claw on the back."
	});

	public static const PLANT_HIGH_HEELS:int = 31;
	EnumValue.add(Types, PLANT_HIGH_HEELS, "PLANT_HIGH_HEELS", {
		name: "vine-covered",
		appearanceDesc: "Your {legCount} perfect lissome legs end in human feet, apart from delicate vines covered in spade-like leaves crawling around them on the whole length."
	});

	public static const PLANT_ROOT_CLAWS:int = 32;
	EnumValue.add(Types, PLANT_ROOT_CLAWS, "PLANT_ROOT_CLAWS", {
		name: "root feet",
		appearanceDesc: "Your {legCount} legs looks quite normal aside feet. They turned literally into roots only vaguely retaining the shape of the feet."
	});

	public static const WOLF:int = 33;
	EnumValue.add(Types, WOLF, "WOLF", {
		name: "wolf",
		appearanceDesc: "{legCount} digitigrade legs grow downwards from your waist, ending in clawed wolf-like hind-paws.",
		canPounce: true
	});

	public static const PLANT_FLOWER:int = 34;
	EnumValue.add(Types, PLANT_FLOWER, "PLANT_FLOWER", {
		name: "plant flower",
		legCount: 12,
		legs: "vine-like tentacle stamens",
		appearanceDesc: "Around your waist, the petals of a large [skin coat.nakedcolor] orchid expand, big enough to engulf you entirely on their own, coupled with a pitcher-like structure in the centre, which is filled with syrupy nectar straight from your loins. When you wish to rest, these petals draw up around you, encapsulating you in a beautiful bud. While you don't technically have legs anymore, you can still move around on your {legCount} vine-like stamens.",
		isAlraune: true,
		hasTentacles: true
	});

	public static const LION:int = 35;
	EnumValue.add(Types, LION, "LION", {
		name: "lion",
		appearanceDesc: "Your four legs are covered in [skin coat.color] fur up to the thigh where it fades to white. They end with digitigrade lion paws. You can dash on all fours as gracefully as you would on two legs.",
		metamorphFlag: StatusEffects.UnlockedLionLegs,
		metamorphCost: 100,
		metamorphTitle: "Lion",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody != LowerBody.HUMAN) {
				desc += LowerBody.Types[LowerBody.HUMAN].tfDescFunc(creature);
				LowerBody.Types[LowerBody.HUMAN].tfFunc(creature);
				desc += "\n\n";
			}

			desc += "Your legs suddenly shift painfully, forcing you down on all fours as the bone of your feet changes shape into something entirely different. You feel hairs growing at a rapid rate all over your legs. Something juts out of your toe as they clench into the ground. As you feel the pain recede you sit and take a look at your [feet]; or rather, your large leonine hind paws, now armed with sharp, retractable claws. <b>You now have leonine paws.</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.LION;
			creature.legCount = 2;
		},
		canPounce: true,
		feline: true
	});

	public static const YETI:int = 36;
	EnumValue.add(Types, YETI, "YETI", {
		name: "yeti",
		appearanceDesc: "Your {legCount} fur covered legs end with a pair of very large yeti feet, leaving large tracks and granting you easy mobility in the snow."
	});

	public static const ORCA:int = 37;
	EnumValue.add(Types, ORCA, "ORCA", {
		name: "orca",
		appearanceDesc: "Your {legCount} legs are mostly human save for the webbing between your toes that assists you in swimming.",
		metamorphFlag: StatusEffects.UnlockedOrcaLegs,
		metamorphCost: 100,
		metamorphTitle: "Orca",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody != LowerBody.HUMAN) {
				desc += LowerBody.Types[LowerBody.HUMAN].tfDescFunc(creature);
				LowerBody.Types[LowerBody.HUMAN].tfFunc(creature);
				desc += "\n\n";
			}

			desc += "Your toes suddenly are forced together. When you stretch them back you discover they are now webbed, ready for swimming. <b>You can only guess those Orca legs will help you to swim at great speed.</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.ORCA;
		}
	});

	public static const YGG_ROOT_CLAWS:int = 38;
	EnumValue.add(Types, YGG_ROOT_CLAWS, "YGG_ROOT_CLAWS", {
		name: "root feet",
		appearanceDesc: "Your {legCount} legs looks quite normal until your feet. Your roots have condensed into a self-contained shape of three clawed toes on the front, and a small hind-claw in the back. You doubt they can gather moisture very well like this, but at least you have an excellent grip."
	});

	public static const ONI:int = 39;
	EnumValue.add(Types, ONI, "ONI", {
		name: "oni",
		appearanceDesc: "Your {legCount} legs are covered with a set of warlike tattoo and your feet end with sharp black nails.",
		metamorphFlag: StatusEffects.UnlockedOniLegs,
		metamorphCost: 100,
		metamorphTitle: "Oni",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody != LowerBody.HUMAN) {
				desc += LowerBody.Types[LowerBody.HUMAN].tfDescFunc(creature);
				LowerBody.Types[LowerBody.HUMAN].tfFunc(creature);
				desc += "\n\n";
			}

			desc += "Not again! Now it's the skin on your legs that is burning as a whole set of intricate warlike tattoos covers them. Furthermore, your toenails become increasingly pointed turning black just like a set of claws. Well it seems you will have get used to your <b>war tattooed legs and feet topped with sharp nails.</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.ONI;
			creature.legCount = 2;
		}
	});

	public static const ELF:int = 40;
	EnumValue.add(Types, ELF, "ELF", {
		name: "elf",
		appearanceDesc: "Your {legCount} perfect lissom legs end in delicate but agile elven feet, allowing you to move gracefully and swiftly.",
		metamorphFlag: StatusEffects.UnlockedElfLegs,
		metamorphCost: 100,
		metamorphTitle: "Elf",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody != LowerBody.HUMAN) {
				desc += LowerBody.Types[LowerBody.HUMAN].tfDescFunc(creature);
				LowerBody.Types[LowerBody.HUMAN].tfFunc(creature);
				desc += "\n\n";
			}

			desc += "Something shifts in your legs as you feel almost supernatural agility imbue your steps granting a nymph like grace to your stride. Your feet are no longer rough but delicate and agile like those of an elf. <b>You now have agile elven feet.</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.ELF;
			creature.legCount = 2;
		}
	});

	public static const RAIJU:int = 41;
	EnumValue.add(Types, RAIJU, "RAIJU", {
		name: "raiju",
		appearanceDesc: "You have {legCount} fluffy, furred legs that look vaguely like knee high socks. Your pawed feet end in four thick toes, which serve as your main source of balance. You can walk on them as normally as your old plantigrade legs. A thick strand of darkly colored fur breaks out from your ankles, emulating a bolt of lighting in appearance.",
		metamorphFlag: StatusEffects.UnlockedRaijuLegs,
		metamorphCost: 100,
		metamorphTitle: "Raiju",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody != LowerBody.HUMAN) {
				desc += LowerBody.Types[LowerBody.HUMAN].tfDescFunc(creature);
				LowerBody.Types[LowerBody.HUMAN].tfFunc(creature);
				desc += "\n\n";
			}

			desc += "You have trouble standing as multiple flashes of sensation run across your legs. Sitting down before you accidently hurt yourself, you watch with apprehension as your legs begin to shift, fluffy patches of fur traveling up your legs until they reach your knees. You yelp as the bones in your feet split and rearrange themselves into paws. Eventually, the sensation ebbs and you slowly get used to your <b>Raiju paws!</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.RAIJU;
			creature.legCount = 2;
		}
	});

	public static const RED_PANDA:int = 42;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
		name: "red panda",
		appearanceDesc: "Your {legCount} legs are equally covered in [skin coat.color] fur, ending on red-panda paws with short claws. They have a nimble and strong build, in case you need to escape from something.",
		metamorphFlag: StatusEffects.UnlockedRedPandaLegs,
		metamorphCost: 100,
		metamorphTitle: "Red Panda",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.isTaur()) {
				desc += "You legs tremble, forcing you to lie on the ground, as they don't seems to answer you anymore. A burning sensation in them is the last thing you remember before briefly blacking out. When it subsides and you finally awaken, you look at them again, only to see that you’ve left with a single set of digitigrade legs, and a much more humanoid backside. Soon enough, the feeling returns to your reformed legs, only to come with an itching sensation. A thick black-brown coat of fur sprouts from them. It’s soft and fluffy to the touch. Cute pink paw pads complete the transformation. Seems like <b>you’ve gained a set of red-panda paws!</b>";
			} else if (creature.isNaga()) {
				desc += "A strange feeling in your tail makes you have to lay on the ground. Then, the feeling becomes stronger, as you feel an increasing pain in the middle of your coils. You gaze at them for a second, only to realize that they’re dividing! In a matter of seconds, they’ve reformed into a more traditional set of legs, with the peculiarity being that they’re fully digitigrade in shape. Soon, every scale on them falls off to leave soft [skin] behind. That doesn’t last long, because soon a thick coat of black-brown fur covers them. It feels soft and fluffy to the touch. Cute pink paw pads complete the transformation. Seems like <b>you’ve gained a set of red-panda paws!</b>";
			} else if (creature.isGoo()) {
				desc += "The blob that forms your lower body becomes suddenly rigid under the rhizome effects, forcing you to stay still until the transformation ends. Amazingly, what was once goo turns into flesh and skill in mere seconds, thus leaving you with a very human-like set of legs and feet.\n\nIt doesn’t stop here as a feeling of unease forces you to sit on a nearby rock, as you feel something within your newly regained feet is changing. Numbness overcomes them, as muscles and bones change, softly shifting, melding and rearranging themselves. For a second you feel that they’re becoming goo again, but after a couple of minutes, they leave you with a set of digitigrade legs with pink pawpads, ending in short black claws and covered in a thick layer of black-brown fur. It feels quite soft and fluffy. <b>You’ve gained a set of red-panda paws!</b>";
			} else {
				desc += "A feeling of unease forces your to sit on a nearby rock, as you feel something within your [feet] is changing. Numbness overcomes them, as muscles and bones change, softly shifting, melding and rearranging themselves. After a couple of minutes, they leave you with a set of digitigrade legs with pink pawpads, ending in short black claws and covered in a thick layer of black-brown fur. It feels quite soft and fluffy. <b>You’ve gained a set of red-panda paws!</b>";
			}

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.RED_PANDA;
			creature.legCount = 2;
		}
	});

	public static const GARGOYLE_2:int = 43;
	EnumValue.add(Types, GARGOYLE_2, "GARGOYLE_2", {
		name: "gargoyle",
		appearanceDesc: "Your {legCount} [gargoylematerial] legs aside of their stone structure look pretty much human."
	});

	public static const AVIAN:int = 44;//button 0 on 4th page of metamorph
	EnumValue.add(Types, AVIAN, "AVIAN", {
		name: "avian",
		appearanceDesc: "You have strong thighs perfect for launching you into the air which end in slender, bird-like legs, covered with a [skin coat.color] plumage down to your knees and slightly rough, [skin] below. You have digitigrade feet, with toes that end in sharp talons."
	});

	public static const GRYPHON:int = 45;
	EnumValue.add(Types, GRYPHON, "GRYPHON", {
		name: "gryphon",
		appearanceDesc: "You have strong thighs perfect for launching you into the air ending in furred, feline legs, covered with a coat of soft, [skin coat.color2] fur. Your have digitigrade feet, lion-like, with soft, pink soles and paw pads, with feline toes ending in sharp, retractile claws."
	});

	public static const ORC:int = 46;
	EnumValue.add(Types, ORC, "ORC", {
		name: "orc",
		appearanceDesc: "Your {legCount} bowed legs are covered with a set of scar-like tattoos and your feet end with sharp, pointed nails.",
		metamorphFlag: StatusEffects.UnlockedOrcLegs,
		metamorphCost: 100,
		metamorphTitle: "Orc",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.lowerBody != LowerBody.HUMAN) {
				desc += LowerBody.Types[LowerBody.HUMAN].tfDescFunc(creature);
				LowerBody.Types[LowerBody.HUMAN].tfFunc(creature);
				desc += "\n\n";
			}

			desc += "You have trouble standing up as multiple flashes of mild pain run across your legs as a whole set of intricate scar shaped tattoos covers them. Furthermore, your toenails become increasingly pointed, looking like a set of claws. Well, it seems you will have get used to your <b>scar tattooed legs and feet topped with pointed nails.</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.lowerBody = LowerBody.ORC;
			creature.legCount = 2;
		}
	});

	public static const CAVE_WYRM:int = 47;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
		name: "cave wyrm",
		appearanceDesc: "{legCount} digitigrade legs covered in thick, leathery black scales up to the mid-thigh grow down from your [hips], ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back."
	});

	public static const MOUSE:int = 48;
	EnumValue.add(Types, MOUSE, "MOUSE", {
		name: "mouse",
		appearanceDesc: "You stand on {legCount} digitigrade mouse legs ending in five toed clawed paws."
	});

	public static const HINEZUMI:int = 49;
	EnumValue.add(Types, HINEZUMI, "HINEZUMI", {
		name: "hinezumi",
		appearanceDesc: "Your {legCount} digitigrade mouse legs are covered in flames up to your knee. Your kicks leave a vicious burn on those who cross you, which they are sure to remember."
	});

	public static const BEAR:int = 50;
	EnumValue.add(Types, BEAR, "BEAR", {
		name: "bear",
		appearanceDesc: "Your {legCount} legs are covered with [skin coat.color] fur. They end with powerful bear-like paws."
	});

	public static const HYDRA:int = 51;
	EnumValue.add(Types, HYDRA, "HYDRA", {
		name: "hydra",
		legCount: 1,
		legs: "snake-like coils",
		leg: "hydra-tail",
		feet: "coils",
		foot: "coiled tail",
		appearanceDesc: "Below your waist your flesh is fused together into the body of a snake which split into [hydraheads] [doubletallness] long serpentine coils each ending with a snake head. Your many heads tend to hiss when you are in pain or angry.",
		bite: true,
		isNaga: true
	});

	public static const FIRE_SNAIL:int = 52;
	EnumValue.add(Types, FIRE_SNAIL, "FIRE_SNAIL", {
		name: "fire snail",
		appearanceDesc: "Below your waist your flesh is fused together into the fat tail of a snail, with a flat wet underbelly that glistens continuously."
	});

	public static const GHOST:int = 53;
	EnumValue.add(Types, GHOST, "GHOST", {
		name: "phantom",
		appearanceDesc: "You have {legCount} partially transparent due to their ghostly nature human legs grow down from your waist, ending in normal human feet."
	});

	public static const GHOST_2:int = 54;
	EnumValue.add(Types, GHOST_2, "GHOST_2", {
		name: "poltergeist",
		appearanceDesc: "Below your waist, your body fuses and fades away, like a ghost.",
		noLowerGarment: true
	});

	public static const JIANGSHI:int = 55;
	EnumValue.add(Types, JIANGSHI, "JIANGSHI", {
		name: "jiangshi",
		appearanceDesc: "While your legs are human in appearance your body is so rigid due to this pseudo rigor mortis that the only way you found for movement is by hopping around."
	});

	public static const YUKI_ONNA:int = 56;//button 0 on 5th page of metamorph
	EnumValue.add(Types, YUKI_ONNA, "YUKI_ONNA", {
		name: "yuki onna",
		appearanceDesc: "Your legs are human in appearance albeit for the bluish nails."
	});

	public static const MELKIE:int = 57;
	EnumValue.add(Types, MELKIE, "MELKIE", {
		name: "melkie",
		appearanceDesc: "Beneath your waist your body ends in the tail of a leopard seal. It allows you to swim gracefully in arctic waters. However, when the time to move on land arises, you can part the fur at your waist in order to let your two human legs out and walk on solid ground as the land dwellers do.",
		crotchDesc: "You have a outer set of vaginal lips at the junction between your human body and seal tail, in which your internal sex and human legs are hidden when not in use.",
		tailSlam: true
	});

	public static const CENTIPEDE:int = 58;
	EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {
		name: "centipede",
		appearanceDesc: "In place of legs you have the body of a giant centipede. Your long segmented insectoid body has over a dozen pairs of spindly legs and is tipped with a pair of stingers that can pierce even the strongest armor."
	});

	public static const KRAKEN:int = 59;
	EnumValue.add(Types, KRAKEN, "KRAKEN", {
		name: "kraken",
		appearanceDesc: "Where your legs would normally start, you've grown the body of a giant squid, with {legCount} tentacle legs that sprout from your [hips], two of them larger than the others. Your tentacles reach for up to [doubletallness] feet in length!",
		crotchDescFunc: function(creature: *): String {
			var desc: String = "";

			switch (creature.gender) {
				case 1:
					desc += "Your sex is concealed between your front octopus tentacle legs, dangling freely when not in use.";
				break;
				case 2:
					desc += "Your sex is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal your true self.";
				break;
				case 3:
					desc += "Your sex";
					if(creature.cockTotal() > 1) {
						desc += "es are ";
					} else {
						desc += " is ";
					}
					desc += "concealed between your front octopus tentacle legs, dangling freely. The other set is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal it.";
			}

			return desc;
		},
		isScylla: true,
		isKraken: true,
		hasTentacles: true
	});

	public static const CRAB:int = 60;
	EnumValue.add(Types, CRAB, "CRAB", {
		name: "crab",
		appearanceDesc: "Your {legCount} legs are covered in a reflective [skin coat.color], crab like carapace up to your mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton."
	});

	public static const CANCER:int = 61;
	EnumValue.add(Types, CANCER, "CANCER", {
		name: "cancer",
		appearanceDesc: "Where your legs would normally start, you have grown the body of a crab, with {legCountMinusTwo} chitin plated legs and two large pincers capable of tearing steel plating to shreds. A pair of stalk mounted crab eyes on the front of your shell look at your surroundings, giving you a full peripheral vision. On the front of your crab half, covering your privates, is a set of chitinous mandibula covered in feelers, constantly chittering and foaming with your drooling fluids.",
		legCount: 6,
		hasClaws: true,
		hasPincers: true,
		isDrider: true
	});

	public static const FROSTWYRM:int = 62;
	EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {
		name: "frost wyrm",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "Below your waist your flesh is fused together into a very long snake-like tail easily [quadrupletallness] feet long. Your entire tail length up to the waist is covered with thick snow white fur, and underneath is a whole layer of [skin coat.color] dragon scales, harder than steel and capable of deflecting most weapons.";

			if (creature.tallness > 120) {
				desc += " Your body is so large it's no wonder your passage underground can cause tremors.";
			}

			return desc;
		},
		tail: true,
		tailSlam: true,
		isNaga: true,
		draconic: true
	});

	public static const USHI_ONI:int = 63;
	EnumValue.add(Types, USHI_ONI, "USHI_ONI", {
		name: "ushi-oni",
		appearanceDesc: "You have the lower body of an ushi-oni, it is like the one of a drider except that it is covered in fur with the exoskeleton under it, the usually black sheen legs of a drider are replaced with rough bone ones of an ushi-oni.",
		isDrider: true
	});

	public static const FLOWER_LILIRAUNE:int = 64;
	EnumValue.add(Types, FLOWER_LILIRAUNE, "FLOWER_LILIRAUNE", {
		name: "liliraune flower",
		appearanceDesc: "Around your waist, the petals of a large {nakedCoatColor} orchid expand, big enough to engulf you entirely on their own, coupled with a pitcher-like structure in the center, which is filled with syrupy nectar straight from your loins. When you wish to rest, these petals draw up around you, encapsulating you in a beautiful bud. While you don't technically have legs anymore, you can still move around on your {legCount} vine-like stamens. You used to be alone in the pitcher, but you now share space with your twin sister, taking turns with her whether it's for battle or sex.",
		isAlraune: true,
		isLiliraune: true,
		hasTentacles: true
	});

	public static const WEASEL:int = 65;
	EnumValue.add(Types, WEASEL, "WEASEL", {
		name: "weasel",
		appearanceDesc: "You have {legCount} fluffy, furred legs like those of a weasel. Your pawed feet end in four thick toes, which serve as your main source of balance. You can walk on them as normally as your old plantigrade legs."
	});

	public static const GAZER:int = 66;
	EnumValue.add(Types, GAZER, "GAZER", {
		name: "gazer",
		appearanceDesc: "Your {legCount} are human in appearance but drips with oily black fluids. You've not been using them just as much as of late since you are constantly levitating anyway."
	});

	public static const SQUIRREL:int = 67;
	EnumValue.add(Types, SQUIRREL, "SQUIRREL", {
		name: "squirrel",
		appearanceDesc: "You have {legCount} fluffy, furred legs are covered in [skin coat.color] fur up to the thigh. They end with digitigrade squirrel paws."
	});

	public static const WENDIGO:int = 68;
	EnumValue.add(Types, WENDIGO, "WENDIGO", {
		name: "wendigo",
		appearanceDesc: "Your legs are covered in fur up to the knee however they are entirely devoid of feet."
	});

	public static const ATLACH_NACHA:int          = 69;
	EnumValue.add(Types, ATLACH_NACHA, "ATLACH_NACHA", {
		name: "atlach nacha",
		legCount: 8,
		legs: "spider legs",
		isDrider: true,
		appearanceDesc: "Where your legs would normally start you have grown the body of a spider, with {legCount} spindly legs that sprout from its sides."
	});

	public static const SEA_DRAGON:int = 70;
	EnumValue.add(Types, SEA_DRAGON, "SEA_DRAGON", {
		name: "sea dragon",
		appearanceDesc: "Your {legCount} legs are mostly human save for the webbing between your clawed toes that assists you in swimming.",
		draconic: true
	});

	override public function set type(value:int):void {
		super.type = value;
		// Reset leg count

		switch (value) {
			// Migration from older versions
			case CENTAUR:
				legCount = 4;
				type = HOOFED;
				break;
			// Migration from older versions
			case DEERTAUR:
				legCount = 4;
				type = CLOVEN_HOOFED;
				break;
			// Exception: Parts can have 2 or 4 legs
			case CLOVEN_HOOFED:
			case HOOFED:
				if (legCount != 4) legCount = 2;
				break;
			default:
				legCount = Types[value].legCount || 2;
		}
	}

	public function LowerBody(creature:Creature) {
		super(creature,"lowerBodyPart",["legCount"]);
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		legCount = 2;
	}

	override protected function loadFromOldSave(savedata:Object):void {
		type = intOr(savedata.lowerBody, HUMAN);
		if (type === CENTAUR) {
			type = HOOFED;
		} else if (type === DEERTAUR) {
			type = CLOVEN_HOOFED;
		}
		legCount = intOr(savedata.legCount,2);
	}

	override protected function saveToOldSave(savedata:Object):void {
		savedata.lowerBody = type;
		savedata.legCount = legCount;
	}

	public static function getAppearanceDescription(creature: *):String {
		const id: int = creature.lowerBody;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature);
	}

	public static function getCrotchDescription(creature: *):String {
		const id: int = creature.lowerBody;

		return formatDescription((Types[id].crotchDescFunc ? Types[id].crotchDescFunc(creature) : Types[id].crotchDesc) || "", creature);
	}

	public static function getTFDescription(creature: *, bodyPart: *):String {
		return (bodyPart.tfDescFunc ? bodyPart.tfDescFunc(creature) : bodyPart.metamorphDesc) || "";
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;
		const legCountPattern:RegExp = /{legCount}/g;
		const legCountMinusTwoPattern:RegExp = /{legCountMinusTwo}/g;

		return desc
			.replace(legCountPattern, num2Text(creature.legCount))
			.replace(legCountMinusTwoPattern, num2Text(creature.legCount - 2))
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}

	public function legs():String {
		if (isTaur())
			return num2Text(legCount) + " legs";

		switch (type) {
			// Exception: Includes number of legs
			case DRIDER:
			case ATLACH_NACHA:
			case PLANT_FLOWER: return num2Text(legCount) + " " + Types[type].legs;
			default:
				var prefix:String = "";
				if (Types[type].legsPrefixes) {
					prefix = Types[type].legsPrefixes[Math.floor(Math.random() * Types[type].legsPrefixes.length)];
				}

				return prefix + " " + (Types[type].legs || "legs");
		}
	}

	public function leg():String {
		var prefix:String = "";
		if (Types[type].legPrefixes) {
			prefix = Types[type].legPrefixes[Math.floor(Math.random() * Types[type].legPrefixes.length)];
		}

		return prefix + " " + (Types[type].leg || "leg");
	}

	public function feet():String {
		var prefix:String = "";
		if (Types[type].feetPrefixes) {
			prefix = Types[type].feetPrefixes[Math.floor(Math.random() * Types[type].feetPrefixes.length)];
		}

		return prefix + " " + (Types[type].feet || "feet");
	}

	public function foot():String {
		var prefix:String = "";
		if (Types[type].footPrefixes) {
			prefix = Types[type].footPrefixes[Math.floor(Math.random() * Types[type].footPrefixes.length)];
		}

		return prefix + " " + (Types[type].foot || "foot");
	}

	public function isBiped():Boolean {
		return legCount == 2;
	}

	public function isTaur():Boolean {
		// driders have genitals on their human part, unlike usual taurs... this is actually bad way to check, but too many places to fix just now
		return legCount == 4 && (type != PLANT_FLOWER && type != HYDRA);
	}

	public function isDrider():Boolean {
		return Types[type].isDrider || false;
	}

	public function isGoo():Boolean {
		return Types[type].isGoo || false;
	}

	public function isNaga():Boolean {
		return Types[type].isNaga || false;
	}

	public function isScylla():Boolean {
		return Types[type].isScylla || false;
	}

	public function isKraken():Boolean {
		return Types[type].isKraken || false;
	}

	public function isAlraune():Boolean {
		return Types[type].isAlraune || false;
	}

	public function isLiliraune():Boolean {
		return Types[type].isLiliraune || false;
	}

	public static function lowerGarmentDisabled(creature: *, perk: String = ""):Boolean {
		const id: int = creature.lowerBody;

		if (creature.isTaur() || creature.isDrider() || creature.isScylla() || creature.isKraken() || creature.isAlraune() || creature.isLiliraune() || (creature.isNaga() && (perk || creature.lowerGarmentPerk) != "NagaWearable")) {
			return true;
		}

		return Types[id].noLowerGarmentFunc ? Types[id].noLowerGarmentFunc(creature) : (Types[id].noLowerGarment || false);
	}

	public static function hasDraconicLegs(creature: *):Boolean {
		const id: int = creature.lowerBody;

		return Types[id].draconic || false;
	}

	public static function hasFelineLegs(creature: *):Boolean {
		const id: int = creature.lowerBody;

		return Types[id].feline || false;
	}

	public static function canLayEggs(creature: *):Boolean {
		const id: int = creature.lowerBody;

		return Types[id].eggLayer || false;
	}

	public static function hasTail(creature: *):Boolean {
		const id: int = creature.lowerBody;

		return Types[id].tail || false;
	}

	public static function hasTentacles(creature: *):Boolean {
		const id: int = creature.lowerBody;

		return Types[id].hasTentacles || false;
	}

	public static function hasPincers(creature: *):Boolean {
		const id: int = creature.lowerBody;

		return Types[id].hasPincers || false;
	}

	public static function hasTalons(creature: *):Boolean {
		const id: int = creature.lowerBody;

		return Types[id].hasTalons || false;
	}

	public static function hasClaws(creature: *):Boolean {
		const id: int = creature.lowerBody;

		return Types[id].hasClaws || false;
	}

	public static function isGoo(creature: *):Boolean {
		const id: int = creature.lowerBody;

		return Types[id].isGoo || false;
	}

	public static function canTailSlam(creature: *):Boolean {
		const id: int = creature.lowerBody;

		return Types[id].tailSlam || false;
	}
}
}
