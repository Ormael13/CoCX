/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

public class LowerBody extends SaveableBodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("HUMAN", "HOOFED")
	 * - name: human-readable default name, ("human", "hoofed")
	 * - legCount: number of legs the part has (defaults to 2 if property doesn't exist)
	 *
	 * - legs: what the part's legs are called (defaults to "legs" if property doesn't exist)
	 * - legsPrefixes: optional list of descriptions to pick randomly before legs (e.g. *vulpine* legs)
	 *
	 * - leg: what the part's leg is called (defaults to "leg" if property doesn't exist)
	 * - legPrefixes: optional list of descriptions to pick randomly before leg (e.g. *vulpine* leg)
	 *
	 * - feet: what the part's leg is called (defaults to "leg" if property doesn't exist)
	 * - feetPrefixes: optional list of descriptions to pick randomly before feet (e.g. *vulpine* feet)
	 *
	 * - foot: what the part's leg is called (defaults to "leg" if property doesn't exist)
	 * - footPrefixes: optional list of descriptions to pick randomly before foot (e.g. *vulpine* foot)
	 *
	 * - appearanceDesc: description for PlayerAppearance.as in the LOWERBODY DESCRIPTION area (always visible)
	 * - appearanceDesc[TypeHere]: same as appearanceDesc, but only shown if player is of the specified type (Biped, Taur, or Drider)
	 *
	 * - claw: Whether the part enables claw actions, meant to be checked during scenes
	 * - tailSlam: Whether the part enables tail slam, meant to be checked during scenes
	 * - tentacle: Whether the part enables tentacle actions, meant to be checked during scenes
	 *
	 * - is[TypeHere]: Whether the part counts the player as specific type (ex: Drider, Goo, Naga, Scylla, etc), defaults to false with no property
	 */

	public static var Types:/*EnumValue*/Array = [];

	public var legCount:int = 2;

	public static const HUMAN:int = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {
		name: "human",
		appearanceDesc: "{legCount} normal human legs grow down from your [hips], ending in normal human feet."
	});

	public static const HOOFED:int = 1;
	EnumValue.add(Types, HOOFED, "HOOFED", {
		name: "hoofed",
		feet: "hooves",
		foot: "hoof",
		appearanceDescBiped: "Your two legs are muscled and jointed oddly, covered in [skin coat.color] fur, and end in a bestial hooves.",
		appearanceDescTaur: "From the waist down, you have the body of a horse, with four muscled legs which are jointed oddly, covered in [skin coat.color] fur, and end in a bestial hooves."
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
		appearanceDesc: "Your {legCount} legs are covered in a shimmering insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than an exoskeleton. A bit of downy yellow and black fur fuzzes your upper thighs, just like a bee."
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
		canPounce: true
	});

	public static const LIZARD:int = 10;
	EnumValue.add(Types, LIZARD, "LIZARD", {
		name: "lizard",
		appearanceDesc: "{legCount} digitigrade legs grow down from your [hips], ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back."
	});

	public static const PONY:int = 11;
	EnumValue.add(Types, PONY, "PONY", {
		name: "pony",
		legs: "cute pony-legs",
		leg: "cartoonish pony-leg",
		feet: "flat pony-feet",
		foot: "flat pony-foot",
		legCount: 4,
		appearanceDescTaur: "From the waist down, you have an incredibly cute and cartoonish parody of a horse's body, with all four legs ending in flat, rounded feet."
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
		appearanceDesc: "Your {legCount} legs are covered with [haircolor] plumage. Thankfully the thick, powerful thighs are perfect for launching you into the air, and your feet remain mostly human, even if they are two-toed and tipped with talons."
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
		appearanceDesc: "Your {legCount} legs are covered in a reflective [skin coat.color], insectile carapace up to your mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton."
	});

	public static const DRIDER:int = 16;
	EnumValue.add(Types, DRIDER, "DRIDER", {
		name: "drider",
		legCount: 8,
		legs: "spider legs",
		appearanceDesc: "Where your legs would normally start, you have grown the body of a spider, with {legCount} spindly legs that sprout from its sides.",
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
		appearanceDesc: "Your {legCount} fox legs are crooked into high knees with hocks and long feet; cute bulbous toes decorate the ends."
	});

	public static const DRAGON:int = 18;
	EnumValue.add(Types, DRAGON, "DRAGON", {
		name: "dragon",
		appearanceDesc: "{legCount} human-like legs grow down from your [hips], sheathed in scales and ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back."
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
		appearanceDesc: "{legCount} digitigrade legs form below your [hips], ending in cloven hooves."
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
		appearanceDesc: "{legCount} digitigrade legs covered in thick, leathery red scales up to the mid-thigh grow down from your [hips], ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back."
	});

	public static const SCYLLA:int = 26;
	EnumValue.add(Types, SCYLLA, "SCYLLA", {
		name: "slippery octopus tentacles",
		tentacle: true,
		appearanceDesc: "Where your legs would normally start, you have grown the body of an octopus, with {legCount} tentacle legs that sprout from your [hips].",
		isScylla: true
	});

	public static const MANTIS:int = 27;
	EnumValue.add(Types, MANTIS, "MANTIS", {
		name: "mantis",
		appearanceDesc: "Your {legCount} legs are covered in a shimmering [skin coat.color], insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton."
	});

	//public static const :int = 28;thunder mantis legs

	public static const SHARK:int = 29;
	EnumValue.add(Types, SHARK, "SHARK", {
		name: "shark",
		appearanceDescBiped: "Your two legs are mostly human save for the webbing between your toes.",
		appearanceDescTaur: "Your four legs end in three-toed scaled paws with webbing between the toes, and an even larger webbing running on the entire length."
	});

	public static const GARGOYLE:int = 30;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, GARGOYLE, "GARGOYLE", {
		name: "gargoyle",
		appearanceDesc: "Your {legCount} digitigrade {gargoyleMaterial} legs end in sharp-clawed stone feet. There are three long toes on the front, and a small hind claw on the back."
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
		appearanceDesc: "Around your waist, the petals of a large {nakedCoatColor} orchid expand, big enough to engulf you entirely on their own, coupled with a pitcher-like structure in the centre, which is filled with syrupy nectar straight from your loins. When you wish to rest, these petals draw up around you, encapsulating you in a beautiful bud.  While you don't technically have legs anymore, you can still move around on your {legCount} vine-like stamens.",
		tentacle: true,
		isAlraune: true
	});

	public static const LION:int = 35;
	EnumValue.add(Types, LION, "LION", {
		name: "lion",
		appearanceDesc: "Your four legs are covered in [skin coat.color] fur up to the thigh where it fades to white. They end with digitigrade lion paws. You can dash on all fours as gracefully as you would on two legs.",
		canPounce: true
	});

	public static const YETI:int = 36;
	EnumValue.add(Types, YETI, "YETI", {
		name: "yeti",
		appearanceDesc: "Your {legCount} fur covered legs end with a pair of very large yeti feet, leaving large tracks and granting you easy mobility in the snow."
	});

	public static const ORCA:int = 37;
	EnumValue.add(Types, ORCA, "ORCA", {
		name: "orca",
		appearanceDesc: "Your {legCount} legs are mostly human save for the webbing between your toes that assists you in swimming."
	});

	public static const YGG_ROOT_CLAWS:int = 38;
	EnumValue.add(Types, YGG_ROOT_CLAWS, "YGG_ROOT_CLAWS", {
		name: "root feet",
		appearanceDesc: "Your {legCount} legs looks quite normal until your feet. Your roots have condensed into a self-contained shape of three clawed toes on the front, and a small hind-claw in the back. You doubt they can gather moisture very well like this, but at least you have an excellent grip."
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
		appearanceDesc: "You have {legCount} fluffy, furred legs that look vaguely like knee high socks. Your pawed feet end in four thick toes, which serve as your main source of balance. You can walk on them as normally as your old plantigrade legs. A thick strand of darkly colored fur breaks out from your ankles, emulating a bolt of lighting in appearance."
	});

	public static const RED_PANDA:int = 42;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
		name: "red panda",
		appearanceDesc: "Your {legCount} legs are equally covered in [skin coat.color] fur, ending on red-panda paws with short claws. They have a nimble and strong build, in case you need to escape from something."
	});

	public static const GARGOYLE_2:int = 43;
	EnumValue.add(Types, GARGOYLE_2, "GARGOYLE_2", {
		name: "gargoyle",
		appearanceDesc: "Your {legCount} {gargoyleMaterial} legs aside of their stone structure look pretty much human."
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
		appearanceDesc: "Your {legCount} bowed legs are covered with a set of scar-like tattoos and your feet end with sharp, pointed nails."
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
		appearanceDesc: "Below your waist your flesh is fused together into the body of a snake which split into {hydraHeads} {doubleHeight} long serpentine coils each ending with a snake head. Your many heads tend to hiss when you are in pain or angry.",
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
		appearanceDesc: "Below your waist, your body fuses and fades away, like a ghost."
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
		tentacle: true,
		appearanceDesc: "Where your legs would normally start, you've grown the body of a giant squid, with {legCount} tentacle legs that sprout from your [hips], two of them larger than the others. Your tentacles reach for up to {doubleHeight} feet in length!",
		isKraken: true
	});

	public static const CRAB:int = 60;
	EnumValue.add(Types, CRAB, "CRAB", {
		name: "crab",
		appearanceDesc: "Your {legCount} legs are covered in a reflective [skin coat.color], crab like carapace up to your mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton."
	});

	public static const CANCER:int = 61;
	EnumValue.add(Types, CANCER, "CANCER", {
		name: "cancer",
		appearanceDesc: "Where your legs would normally start, you have grown the body of a crab, with {legCountMinusTwo} chitin plated legs and two large pincers capable of tearing steel plating to shreds. A pair of stalk mounted crab eyes on the front of your shell look at your surroundings, giving you a full peripheral vision.",
		legCount: 6,
		claw: true,
		isDrider: true
	});

	public static const FROSTWYRM:int = 62;
	EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {
		name: "frost wyrm",
		appearanceDesc: "Below your waist your flesh is fused together into a very long snake-like tail easily {quadrupleHeight} feet long. Your entire tail length up to the waist is covered with thick snow white fur, and underneath is a whole layer of [skin coat.color] dragon scales, harder than steel and capable of deflecting most weapons.",
		tailSlam: true,
		isNaga: true
	});

	public static const USHI_ONI_ONNA:int = 63;
	EnumValue.add(Types, USHI_ONI_ONNA, "USHI_ONI_ONNA", {
		name: "ushi-oni",
		appearanceDesc: "You have the lower body of an ushi-oni, it is like the one of a drider except that it is covered in fur with the exoskeleton under it, the usually black sheen legs of a drider are replaced with rough bone ones of an ushi-oni.",
		isDrider: true
	});

	public static const FLOWER_LILIRAUNE:int = 64;
	EnumValue.add(Types, FLOWER_LILIRAUNE, "FLOWER_LILIRAUNE", {
		name: "liliraune flower",
		tentacle: true,
		appearanceDesc: "Around your waist, the petals of a large {nakedCoatColor} orchid expand, big enough to engulf you entirely on their own, coupled with a pitcher-like structure in the center, which is filled with syrupy nectar straight from your loins. When you wish to rest, these petals draw up around you, encapsulating you in a beautiful bud. While you don't technically have legs anymore, you can still move around on your {legCount} vine-like stamens. You used to be alone in the pitcher, but you now share space with your twin sister, taking turns with her whether it's for battle or sex.",
		isAlraune: true,
		isLiliraune: true
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

	public static const SEADRAGON:int = 70;
	EnumValue.add(Types, SEADRAGON, "SEADRAGON", {
		name: "sea dragon",
		appearanceDesc: "Your {legCount} legs are mostly human save for the webbing between your clawed toes that assists you in swimming."
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

	public static function getAppearanceDescription(opts:Object):String {
		if (Types[opts.id].appearanceDesc) {
			return formatDescription(Types[opts.id].appearanceDesc, opts);
		}

		return "";
	}

	public static function getAppearanceDescriptionBiped(opts:Object):String {
		if (Types[opts.id].appearanceDescBiped) {
			return formatDescription(Types[opts.id].appearanceDescBiped, opts);
		}

		return "";
	}

	public static function getAppearanceDescriptionTaur(opts:Object):String {
		if (Types[opts.id].appearanceDescTaur) {
			return formatDescription(Types[opts.id].appearanceDescTaur, opts);
		}

		return "";
	}

	public static function getAppearanceDescriptionDrider(opts:Object):String {
		if (Types[opts.id].appearanceDescDrider) {
			return formatDescription(Types[opts.id].appearanceDescDrider, opts);
		}

		return "";
	}

	private static function formatDescription(desc:String, opts: Object): String {
		const upperCasePattern:RegExp = /^./;
		const legCountPattern:RegExp = /{legCount}/g;
		const legCountMinusTwoPattern:RegExp = /{legCountMinusTwo}/g;
		const doubleHeightPattern:RegExp = /{doubleHeight}/g;
		const quadrupleHeightPattern:RegExp = /{quadrupleHeight}/g;
		const hydraHeadsPattern:RegExp = /{hydraHeads}/g;
		const gargoyleMaterialPattern:RegExp = /{gargoyleMaterial}/g;

		return " " + desc
			.replace(legCountPattern, opts.legCount)
			.replace(legCountMinusTwoPattern, opts.legCountMinusTwo)
			.replace(doubleHeightPattern, opts.doubleHeight)
			.replace(quadrupleHeightPattern, opts.quadrupleHeight)
			.replace(hydraHeadsPattern, opts.hydraHeads)
			.replace(gargoyleMaterialPattern, opts.gargoyleMaterial)
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
