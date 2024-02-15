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
	 * - hairy: has hair material
	 * - fur: has fur material
	 * - feathers: has feathers material
	 * - scales: has scales material
	 * - chitin: has chitin material
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
	 * - canTaur: part can be used with a taur body (4 legs)
	 * - hasTentacles: part has tentacles and enables tentacle actions
	 * - hasPincers: part has pincers and enables pincer actions
	 * - hasTalons: part has talons and enables talon actions
	 * - hasClaws: part enables claw actions
	 *
	 * - draconic: part counts as "dragon or variant"
	 * - feline: part counts as "cat or variant"
	 * - eggLayer: part allows laying eggs if conditions are met
	 *
	 * - noTail: part doesn't allow a separate tail part
	 * - tail: part includes or is tail (also doesn't allow a tail part)
	 * - tailSlam: whether the part enables Tail Slam
	 *
	 * - is[TypeHere]: whether the part counts the creature as specific type (ex: Drider, Goo, Naga, Scylla, etc), defaults to false with no property
	 */

	public static var Types:/*EnumValue*/Array = [];

	public var legCount:int = 2;

	public static const HUMAN:int = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {
		name: "human",
		appearanceDesc: "{legCount} human legs grow down from your [hips], ending in normal human feet."
	});

	public static const HOOFED:int = 1;
	EnumValue.add(Types, HOOFED, "HOOFED", {
		name: "hoofed",
		feet: "hooves",
		foot: "hoof",
		appearanceDescFunc: function(player: *): String {
			var desc: String = ""

			if (player.isBiped()) {
				desc += "Your two legs are muscled and jointed oddly, covered in [fur color] fur, and end in a bestial hooves.";
			}

			if (player.isTaur()) {
				desc += "From the waist down, you have the body of a horse, with four muscled legs which are jointed oddly, covered in [fur color] fur, and end in a bestial hooves."
			}

			return desc;
		},
		canTaur: true,
		fur: true
	});

	public static const DOG:int = 2;
	EnumValue.add(Types, DOG, "DOG", {
		name: "dog",
		feet: "dog paws",
		foot: "dog paw",
		appearanceDesc: "{legCount} digitigrade legs grow downwards from your waist, ending in dog-like hind-paws.",
		canTaur: true,
		fur: true
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
		crotchDescFunc: function(player: *): String {
			var desc: String = "";

			if(player.gender > 0) {
				desc += "Your sex";
				if(player.gender == 3 || player.cockTotal() > 1) desc += "es are ";
				else desc += " is ";
				desc += "concealed within a cavity in your tail when not in use, though when the need arises, you can part your concealing slit and reveal your true self.";
			}

			return desc;
		},
		tail: true,
		tailSlam: true,
		isNaga: true,
		scales: true
	});

	public static const CENTAUR:int = 4;//[Deprecated] use HOOFED and legCount = 4
	EnumValue.add(Types, CENTAUR, "CENTAUR", {
		name: "centaur",
		leg: "equine leg",
		feet: "hooves",
		foot: "hoof"
	});

	public static const DEMONIC_HIGH_HEELS:int = 5;
	EnumValue.add(Types, DEMONIC_HIGH_HEELS, "DEMONIC_HIGH_HEELS", {
		name: "demonic high-heels",
		feet: "demonic high-heels",
		appearanceDesc: "Your {legCount} perfect lissome legs end in mostly human feet, apart from the horns protruding straight down from the heel that force you to walk with a sexy, swaying gait."
	});

	public static const DEMONIC_CLAWS:int = 6;
	EnumValue.add(Types, DEMONIC_CLAWS, "DEMONIC_CLAWS", {
		name: "demonic claws",
		feet: "demonic foot-claws",
		appearanceDesc: "Your {legCount} lithe legs are capped with flexible clawed feet. Sharp black nails grow where once you had toe-nails, giving you fantastic grip."
	});

	public static const BEE:int = 7;
	EnumValue.add(Types, BEE, "BEE", {
		name: "bee",
		appearanceDesc: "Your {legCount} legs are covered in a [chitin color2] shimmering insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than an exoskeleton. A bit of downy [chitin color1] fur fuzzes your upper thighs, just like a bee.",
		chitin: true
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
		canPounce: true,
		feline: true,
		canTaur: true,
		fur: true
	});

	public static const LIZARD:int = 10;
	EnumValue.add(Types, LIZARD, "LIZARD", {
		name: "lizard",
		appearanceDesc: "{legCount} digitigrade legs grow down from your [hips], ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back.",
		canTaur: true,
		scales: true
	});

	public static const PONY:int = 11;
	EnumValue.add(Types, PONY, "PONY", {
		name: "pony",
		legs: "cute pony-legs",
		leg: "cartoonish pony-leg",
		feet: "flat pony-feet",
		foot: "flat pony-foot",
		legCount: 4,
		appearanceDescFunc: function(player: *): String {
			var desc: String = ""

			if (player.isTaur()) {
				desc += "From the waist down, you have an incredibly cute and cartoonish parody of a horse's body, with all four legs ending in flat, rounded feet."
			}

			return desc;
		},
		canTaur: true
	});

	public static const BUNNY:int = 12;
	EnumValue.add(Types, BUNNY, "BUNNY", {
		name: "bunny",
		legsPrefixes: ["fuzzy bunny", "fur-covered", "furry", ""],
		legPrefixes: ["fuzzy bunny", "fur-covered", "furry", ""],
		feetPrefixes: ["large bunny", "rabbit", "large", ""],
		footPrefixes: ["large bunny", "rabbit", "large", ""],
		appearanceDesc: "Your {legCount} legs thicken below the waist as they turn into soft-furred rabbit-like legs. You even have large bunny feet that make hopping around a little easier than walking.",
		canTaur: true,
		fur: true
	});

	public static const HARPY:int = 13;
	EnumValue.add(Types, HARPY, "HARPY", {
		name: "harpy",
		legsPrefixes: ["bird-like", "feathered", ""],
		legPrefixes: ["bird-like", "feathered", ""],
		feetPrefixes: ["taloned", ""],
		foottPrefixes: ["taloned", ""],
		appearanceDesc: "Your {legCount} legs are covered with [feather color] plumage. Thankfully the thick, powerful thighs are perfect for launching you into the air, and your feet remain mostly human, even if they are two-toed and tipped with talons.",
		hasTalons: true,
		eggLayer: true,
		feathers: true
	});

	public static const KANGAROO:int = 14;
	EnumValue.add(Types, KANGAROO, "KANGAROO", {
		name: "kangaroo",
		feet: "foot-paws",
		foot: "foot-paw",
		appearanceDesc: "Your {legCount} furry legs have short thighs and long calves, with even longer feet ending in prominently-nailed toes.",
		fur: true
	});

	public static const CHITINOUS_SPIDER_LEGS:int = 15;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, CHITINOUS_SPIDER_LEGS, "CHITINOUS_SPIDER_LEGS", {
		name: "chitinous spider",
		appearanceDesc: "Your {legCount} legs are covered in a reflective [chitin color1], insectile carapace up to your mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.",
		chitin: true
	});

	public static const DRIDER:int = 16;
	EnumValue.add(Types, DRIDER, "DRIDER", {
		name: "drider",
		legCount: 8,
		legs: "spider legs",
		appearanceDesc: "Where your legs would normally start, you have grown the body of a spider, with {legCount} spindly legs that sprout from its sides.",
		isDrider: true,
		chitin: true
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
		canTaur: true,
		fur: true
	});

	public static const DRAGON:int = 18;
	EnumValue.add(Types, DRAGON, "DRAGON", {
		name: "dragon",
		appearanceDesc: "{legCount} human-like legs grow down from your [hips], sheathed in scales and ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back.",
		draconic: true,
		canTaur: true,
		scales: true
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
		appearanceDesc: "Your {legCount} legs, though covered in fur, are humanlike. Long feet on the ends bear equally long toes, and the pads on the bottoms are quite sensitive to the touch.",
		canTaur: true,
		fur: true
	});

	public static const FERRET:int = 20;
	EnumValue.add(Types, FERRET, "FERRET", {
		name: "ferret",
		appearanceDesc: "{legCount} furry, digitigrade legs form below your [hips]. The fur is thinner on the feet, and your toes are tipped with claws.",
		canTaur: true,
		fur: true
	});

	public static const CLOVEN_HOOFED:int = 21;
	EnumValue.add(Types, CLOVEN_HOOFED, "CLOVEN_HOOFED", {
		name: "cloven-hoofed",
		legsPrefixes: ["pig-like", "cloven-hoofed", "", ""],
		appearanceDesc: "{legCount} digitigrade legs form below your [hips], ending in cloven hooves.",
		canTaur: true,
		fur: true
	});

	//public static const :int = 22;not used anywhere legs number likely ^^

	public static const ECHIDNA:int = 23;
	EnumValue.add(Types, ECHIDNA, "ECHIDNA", {
		name: "echidna",
		canTaur: true
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
		canTaur: true,
		scales: true
	});

	public static const SCYLLA:int = 26;
	EnumValue.add(Types, SCYLLA, "SCYLLA", {
		name: "slippery octopus tentacles",
		appearanceDesc: "Where your legs would normally start, you have grown the body of an octopus, with {legCount} tentacle legs that sprout from your [hips].",
		crotchDescFunc: function(player: *): String {
			var desc: String = "";

			switch (player.gender) {
				case 1:
					desc += "Your sex is concealed between your front octopus tentacle legs dangling freely when not in use.";
				break;
				case 2:
					desc += "Your sex is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal your true self.";
				break;
				case 3:
					desc += "Your sex";
					if(player.cockTotal() > 1) {
						desc += "es are ";
					} else {
						desc += " is ";
					}
					desc += "concealed between your front octopus tentacle legs dangling freely. Other set is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal it.";
			}

			return desc;
		},
		isScylla: true,
		hasTentacles: true,
		noTail: true
	});

	public static const MANTIS:int = 27;
	EnumValue.add(Types, MANTIS, "MANTIS", {
		name: "mantis",
		appearanceDesc: "Your {legCount} legs are covered in a shimmering [chitin color1], insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.",
		canTaur: true,
		chitin: true
	});

	//public static const :int = 28;thunder mantis legs

	public static const SHARK:int = 29;
	EnumValue.add(Types, SHARK, "SHARK", {
		name: "shark",
		appearanceDescFunc: function(player: *): String {
			var desc: String = ""
			if (player.isBiped()) {
				desc += "Your two legs are mostly human save for the webbing between your toes.";
			}
			if (player.isTaur()) {
				desc += "Your four legs end in three-toed scaled paws with webbing between the toes, and an even larger webbing running on the entire length."
			}
			return desc;
		},
		canTaur: true
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
		canPounce: true,
		canTaur: true,
		fur: true
	});

	public static const PLANT_FLOWER:int = 34;
	EnumValue.add(Types, PLANT_FLOWER, "PLANT_FLOWER", {
		name: "plant flower",
		legCount: 12,
		legs: "vine-like tentacle stamens",
		appearanceDesc: "Around your waist, the petals of a large [flowercolor] orchid expand, big enough to engulf you entirely on their own, coupled with a pitcher-like structure in the centre, which is filled with syrupy nectar straight from your loins. When you wish to rest, these petals draw up around you, encapsulating you in a beautiful bud.  While you don't technically have legs anymore, you can still move around on your {legCount} vine-like stamens.",
		tentacle: true,
		isAlraune: true
	});

	public static const LION:int = 35;
	EnumValue.add(Types, LION, "LION", {
		name: "lion",
		appearanceDesc: "Your four legs are covered in [fur color] fur up to the thigh where it fades to white. They end with digitigrade lion paws. You can dash on all fours as gracefully as you would on two legs.",
		canPounce: true,
		feline: true,
		canTaur: true,
		fur: true
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
		canTaur: true
	});

	public static const YGG_ROOT_CLAWS:int = 38;
	EnumValue.add(Types, YGG_ROOT_CLAWS, "YGG_ROOT_CLAWS", {
		name: "root feet",
		appearanceDesc: "Your {legCount} legs looks quite normal until your feet. Your roots have condensed into a self-contained shape of three clawed toes on the front, and a small hind-claw in the back. You doubt they can gather moisture very well like this, but at least you have an excellent grip.",
		draconic: true
	});

	public static const ONI:int = 39;
	EnumValue.add(Types, ONI, "ONI", {
		name: "oni",
		appearanceDesc: "Your {legCount} legs are covered with a set of warlike tattoo and your feet end with sharp black nails."
	});

	public static const ELF:int = 40;
	EnumValue.add(Types, ELF, "ELF", {
		name: "elf",
		appearanceDesc: "Your {legCount} perfect lissom legs end in delicate but agile elven feet, allowing you to move gracefully and swiftly."
	});

	public static const RAIJU:int = 41;
	EnumValue.add(Types, RAIJU, "RAIJU", {
		name: "raiju",
		appearanceDesc: "You have {legCount} fluffy, furred legs that look vaguely like knee high socks. Your pawed feet end in four thick toes, which serve as your main source of balance. You can walk on them as normally as your old plantigrade legs. A thick strand of darkly colored fur breaks out from your ankles, emulating a bolt of lighting in appearance.",
		canTaur: true,
		fur: true
	});

	public static const RED_PANDA:int = 42;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
		name: "red panda",
		appearanceDesc: "Your {legCount} legs are equally covered in [fur color] fur, ending on red-panda paws with short claws. They have a nimble and strong build, in case you need to escape from something.",
		fur: true
	});

	public static const GARGOYLE_2:int = 43;
	EnumValue.add(Types, GARGOYLE_2, "GARGOYLE_2", {
		name: "gargoyle",
		appearanceDesc: "Your {legCount} [gargoylematerial] legs aside of their stone structure look pretty much human."
	});

	public static const AVIAN:int = 44;
	EnumValue.add(Types, AVIAN, "AVIAN", {
		name: "avian",
		appearanceDesc: "You have strong thighs perfect for launching you into the air which end in slender, bird-like legs, covered with a [feather color] plumage down to your knees and slightly rough, [skin] below. You have digitigrade feet, with toes that end in sharp talons.",
		canTaur: true,
		feathers: true
	});

	public static const GRYPHON:int = 45;
	EnumValue.add(Types, GRYPHON, "GRYPHON", {
		name: "gryphon",
		appearanceDesc: "You have strong thighs perfect for launching you into the air ending in furred, feline legs, covered with a coat of soft, [fur color2] fur. Your have digitigrade feet, lion-like, with soft, pink soles and paw pads, with feline toes ending in sharp, retractile claws.",
		canPounce: true,
		canTaur: true,
		fur: true
	});

	public static const ORC:int = 46;
	EnumValue.add(Types, ORC, "ORC", {
		name: "orc",
		appearanceDesc: "Your {legCount} bowed legs are covered with a set of scar-like tattoos and your feet end with sharp, pointed nails."
	});

	public static const CAVE_WYRM:int = 47;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
		name: "cave wyrm",
		appearanceDesc: "{legCount} digitigrade legs covered in thick, leathery black scales up to the mid-thigh grow down from your [hips], ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back.",
		scales: true
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
		appearanceDesc: "Your {legCount} legs are covered with [fur color] fur. They end with powerful bear-like paws.",
		canTaur: true,
		fur: true
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
		crotchDescFunc: function(player: *): String {
			var desc: String = "";

			if(player.gender > 0) {
				desc += "Your sex";
				if(player.gender == 3 || player.cockTotal() > 1) desc += "es are ";
				else desc += " is ";
				desc += "concealed within a cavity in your tail when not in use, though when the need arises, you can part your concealing slit and reveal your true self.";
			}

			return desc;
		},
		tail: true,
		bite: true,
		isNaga: true,
		scales: true
	});

	public static const FIRE_SNAIL:int = 52;
	EnumValue.add(Types, FIRE_SNAIL, "FIRE_SNAIL", {
		name: "fire snail",
		appearanceDesc: "Below your waist your flesh is fused together into the fat tail of a snail, with a flat wet underbelly that glistens continuously.",
		noLowerGarment: true
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
		appearanceDesc: "In place of legs you have the body of a giant centipede. Your long segmented insectoid body has over a dozen pairs of spindly legs and is tipped with a pair of stingers that can pierce even the strongest armor.",
		noTail: true,
		chitin: true
	});

	public static const KRAKEN:int = 59;
	EnumValue.add(Types, KRAKEN, "KRAKEN", {
		name: "kraken",
		appearanceDesc: "Where your legs would normally start, you've grown the body of a giant squid, with {legCount} tentacle legs that sprout from your [hips], two of them larger than the others. Your tentacles reach for up to for at least twice your upper body in length!",
		crotchDescFunc: function(player: *): String {
			var desc: String = "";

			switch (player.gender) {
				case 1:
					desc += "Your sex is concealed between your front octopus tentacle legs, dangling freely when not in use.";
				break;
				case 2:
					desc += "Your sex is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal your true self.";
				break;
				case 3:
					desc += "Your sex";
					if(player.cockTotal() > 1) {
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
		hasTentacles: true,
		noTail: true
	});

	public static const CRAB:int = 60;
	EnumValue.add(Types, CRAB, "CRAB", {
		name: "crab",
		appearanceDesc: "Your {legCount} legs are covered in a reflective [chitin color], crab like carapace up to your mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.",
		chitin: true
	});

	public static const CANCER:int = 61;
	EnumValue.add(Types, CANCER, "CANCER", {
		name: "cancer",
		appearanceDesc: "Where your legs would normally start, you have grown the body of a crab, with {legCountMinusTwo} chitin plated legs and two large pincers capable of tearing steel plating to shreds. A pair of stalk mounted crab eyes on the front of your shell look at your surroundings, giving you a full peripheral vision. On the front of your crab half, covering your privates, is a set of chitinous mandibula covered in feelers, constantly chittering and foaming with your drooling fluids.",
		legCount: 6,
		hasClaws: true,
		hasPincers: true,
		isDrider: true,
		chitin: true
	});

	public static const FROSTWYRM:int = 62;
	EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {
		name: "frost wyrm",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "Below your waist your flesh is fused together into a very long snake-like tail. Your entire tail length up to the waist is covered with thick snow white fur, and underneath is a whole layer of [scale color] dragon scales, harder than steel and capable of deflecting most weapons.";

			if (player.tallness > 120) {
				desc += " Your body is so large it's no wonder your passage underground can cause tremors.";
			}

			return desc;
		},
		crotchDescFunc: function(player: *): String {
			var desc: String = "";

			if(player.gender > 0) {
				desc += "Your sex";
				if(player.gender == 3 || player.cockTotal() > 1) desc += "es are ";
				else desc += " is ";
				desc += "concealed within a cavity in your tail when not in use, though when the need arises, you can part your concealing slit and reveal your true self.";
			}

			return desc;
		},
		tail: true,
		tailSlam: true,
		isNaga: true,
		draconic: true,
		scales: true
	});

	public static const USHI_ONI:int = 63;
	EnumValue.add(Types, USHI_ONI, "USHI_ONI", {
		name: "ushi-oni",
		appearanceDesc: "You have the lower body of an ushi-oni, it is like the one of a drider except that it is covered in fur with the exoskeleton under it, the usually black sheen legs of a drider are replaced with rough bone ones of an ushi-oni.",
		isDrider: true,
		fur: true
	});

	public static const FLOWER_LILIRAUNE:int = 64;
	EnumValue.add(Types, FLOWER_LILIRAUNE, "FLOWER_LILIRAUNE", {
		name: "liliraune flower",
		tentacle: true,
		appearanceDesc: "Around your waist, the petals of a large [flowercolor] orchid expand, big enough to engulf you entirely on their own, coupled with a pitcher-like structure in the center, which is filled with syrupy nectar straight from your loins. When you wish to rest, these petals draw up around you, encapsulating you in a beautiful bud. While you don't technically have legs anymore, you can still move around on your {legCount} vine-like stamens. You used to be alone in the pitcher, but you now share space with your twin sister, taking turns with her whether it's for battle or sex.",
		isAlraune: true,
		isLiliraune: true,
		hasTentacles: true
	});

	public static const WEASEL:int = 65;
	EnumValue.add(Types, WEASEL, "WEASEL", {
		name: "weasel",
		appearanceDesc: "You have {legCount} fluffy, furred legs like those of a weasel. Your pawed feet end in four thick toes, which serve as your main source of balance. You can walk on them as normally as your old plantigrade legs.",
		canTaur: true,
		fur: true
	});

	public static const GAZER:int = 66;
	EnumValue.add(Types, GAZER, "GAZER", {
		name: "gazer",
		appearanceDesc: "Your {legCount} legs are human in appearance but drips with oily black fluids. You've not been using them just as much as of late since you are constantly levitating anyway."
	});

	public static const SQUIRREL:int = 67;
	EnumValue.add(Types, SQUIRREL, "SQUIRREL", {
		name: "squirrel",
		appearanceDesc: "You have {legCount} fluffy, furred legs are covered in [fur color] fur up to the thigh. They end with digitigrade squirrel paws.",
		canTaur: true,
		fur: true
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
		draconic: true,
		canTaur: true
	});

	public static const MINDBREAKER:int = 71;
	EnumValue.add(Types, MINDBREAKER, "MINDBREAKER", {
		name: "mindbreaker",
		appearanceDesc: "Where you would normally have feet, eight tentacles extends, connected together by a fleshy membrane at the base like a skirt. You leave an ominous trail of green slime wherever you pass. Along your legs three extra pairs of green eyes stare at the world lined from your tight to the waist up."
	});

	public static const MINDBREAKERMALE:int = 72;
	EnumValue.add(Types, MINDBREAKERMALE, "MINDBREAKERMALE", {
		name: "mindbreaker",
		appearanceDesc: "You stand bipedal, your feet are mostly human in shape though your toes are webbed, presumably to assist with swimming. They are fit enough to support the weight of yourself and someone else if they were to be on top of you."
	});

	public static const JABBERWOCKY:int = 73;
	EnumValue.add(Types, JABBERWOCKY, "JABBERWOCKY", {
		name: "bunny",
		legsPrefixes: ["fuzzy bunny-like", "fur-covered", "furry", ""],
		legPrefixes: ["fuzzy bunny-like", "fur-covered", "furry", ""],
		feetPrefixes: ["large bunny-like", "rabbit-like", "large", ""],
		footPrefixes: ["large bunny-like", "rabbit-like", "large", ""],
		appearanceDesc: "Your {legCount} legs thicken below the waist as they turn into soft-furred rabbit-like legs. You even have large bunny feet that make hopping around a little easier than walking. Unlike a normal bunny thought your toe ends up with vicious dragon claws capable of rending about just anything.",
		canTaur: true,
		fur: true
	});

	public static const ANT:int = 74;
	EnumValue.add(Types, ANT, "ANT", {
		name: "ant",
		appearanceDesc: "Your {legCount} legs are covered in a slightly reflective [chitin color], insectile carapace up to your hips, looking more like armor than natural body.",
		chitin: true
	});

	public static const KIRIN:int = 75;
	EnumValue.add(Types, KIRIN, "KIRIN", {
		name: "kirin",
		feet: "hooves",
		foot: "hoof",
		appearanceDescFunc: function(player: *): String {
			var desc: String = ""
			if (player.isBiped()) {
				desc += "Your two legs are muscled and jointed oddly, covered in patterned [fur color] fur, and end in a bestial hooves.";
			}
			if (player.isTaur()) {
				desc += "From the waist down, you have the body of a kirin, with four muscled legs which are jointed oddly, covered in patterned [fur color] fur, and end in a bestial hooves."
			}
			return desc;
		},
		canTaur: true,
		fur: true
	});

	public static const FEY_DRAGON:int = 76;
	EnumValue.add(Types, FEY_DRAGON, "FEY_DRAGON", {
		name: "fae dragon",
		appearanceDesc: "{legCount} human-like legs grow down from your [hips], sheathed in scales. A thin layer of fragrant powder falls from your scales as you brush them, making the light reflect madly off your scales. Your legs end in taloned, reptilian feet. There are three long toes on the front, and a small hind-claw on the back.",
		draconic: true,
		canTaur: true,
		scales: true
	});

	public static const TINY:int = 77;
	EnumValue.add(Types, TINY, "TINY", {
		name: "tiny",
		appearanceDesc: "Your legs look human save for your tiny little imp feet which barely support your frame."
	});

	public static const SANDWORM:int = 78;
	EnumValue.add(Types, SANDWORM, "SANDWORM", {
		name: "worm",
		appearanceDesc: "Below your waist your flesh vanishes into a swarm of coiling tentacles, after all this is just a tiny part of your true body. From the outside of the tentacle laced walls that constitute your insides, your body is that of a colossal sand worm. " +
				"Your massive mouth can gobble next to anything for you to aggressively mate with and is laced with a circular set of sharp teeth for a strong bite if you ever tire of playing. The six massive eyes that line the sides of your circular mouth stare at the outside world looking for prey though you can just as well sense them though surface pressure alone and dig underneath them to swallow them in. " +
				"Your entire body length up to the tip is covered with thick plating to protect the soft flesh beneath from abrasion as you freely dig through sand and bedrocks. With a body so large it's no wonder your passage underground can cause tremors.",
		legCount: 1,
		legs: "worm",
		leg: "worm-tail",
		feet: "coils",
		foot: "coiled tail",
		tail: true,
		chitin: true,
		isNaga: true
	});

	public static const ABYSSAL_SHARK:int = 79;
	EnumValue.add(Types, ABYSSAL_SHARK, "ABYSSAL_SHARK", {
		name: "abyss shark",
		appearanceDesc: "Your legs are fairly human, save for the webbing between your toes and a pair of fins that have sprouted on each of your thighs, just below the hips."
	});

	public static const WERESHARK:int = 80;
	EnumValue.add(Types, WERESHARK, "WERESHARK", {
		name: "wereshark",
		appearanceDesc: "Lia would add it later OKAY???."
	});

	public static const ARMORED_LEGS:int = 81;
	EnumValue.add(Types, ARMORED_LEGS, "ARMORED_LEGS", {
		name: "arigean",
		appearanceDesc: "Your legs are human in shape and form but are covered in a protective natural, black metal armor half way up your thighs, a series of complex plates seem to rest at your joints allowing for movement with black, fragile skin underneath."
	});

	public static const DEMONIC_GRACEFUL_FEET:int = 82;
	EnumValue.add(Types, DEMONIC_GRACEFUL_FEET, "DEMONIC_GRACEFUL_FEET", {
		name: "demonic graceful feet",
		feet: "demonic graceful feet",
		appearanceDesc: "Your {legCount} perfect lissom legs end in delicate, clawed feet allowing you to move with supernatural grace."
	});

	public static const CLOVEN_HOOFED_2:int = 83;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, CLOVEN_HOOFED_2, "CLOVEN_HOOFED_2", {
		name: "reindeer",
		legsPrefixes: ["deer-like", "cloven-hoofed", "", ""],
		appearanceDesc: "{legCount} digitigrade legs covered with thick [fur color] fur form below your [hips], ending in cloven hooves.",
		canTaur: true,
		fur: true
	});
	public static const MOTH:int = 84;
	EnumValue.add(Types, MOTH, "MOTH", {
		name: "moth",
		appearanceDesc: "your legs are covered in a bell bottom like fuzzy mass"
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
				if (!legCount) legCount = 2;
		}
	}
	
	override public function hasMaterial(type:int):Boolean {
		switch (type) {
			case BodyMaterial.SKIN:
				return true;
			case BodyMaterial.HAIR:
				return Types[this.type].hairy;
			case BodyMaterial.FUR:
				return Types[this.type].fur;
			case BodyMaterial.SCALES:
				return Types[this.type].scales;
			case BodyMaterial.CHITIN:
				return Types[this.type].chitin;
			case BodyMaterial.FEATHERS:
				return Types[this.type].feathers;
			default:
				return false;
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

	public static function getAppearanceDescription(player: *):String {
		const id: int = player.lowerBody;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(player) : Types[id].appearanceDesc) || "", player);
	}

	public static function getCrotchDescription(player: *):String {
		const id: int = player.lowerBody;

		return formatDescription((Types[id].crotchDescFunc ? Types[id].crotchDescFunc(player) : Types[id].crotchDesc) || "", player);
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

	public function canTaur():Boolean {
		return Types[type].canTaur || false;
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

	public static function allowsTail(id: int):Boolean {
		return !Types[id].tail && !Types[id].noTail || false;
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
