package classes.BodyParts {
import classes.internals.EnumValue;
import classes.PerkLib;

public class Eyes extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("HUMAN", "SPIDER")
	 * - name: human-readable default name, ("human", "4 spider")
	 *
	 * NOTE: ALWAYS MENTION EYECOLOR IN DESCRIPTIONS, IT'S NOT DESCRIBED ANYWHERE ELSE
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const HUMAN: int = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {
		name:"human",
		appearanceDesc: ""
	});
	public static const SPIDER: int = 1;
	EnumValue.add(Types, SPIDER, "SPIDER", {
		name:"six spider",
		appearanceDesc: "In addition to your primary two [eyecolor] eyes, you have a second, smaller pair on your forehead.",
		Darkvision: true
	});
	public static const BLACK_EYES_SAND_TRAP: int = 2;
	EnumValue.add(Types, BLACK_EYES_SAND_TRAP, "BLACK_EYES_SAND_TRAP", {
		name:"sandtrap",
		appearanceDesc: "Your eyes are solid spheres of inky, alien darkness."
	});
	public static const CAT: int = 3;
	EnumValue.add(Types, CAT, "CAT", {
		name:"cat",
		appearanceDesc: "Your [eyecolor] eyes have vertically slit like those of cat.",
		Darkvision: true
	});
	public static const GORGON: int = 4;
	EnumValue.add(Types, GORGON, "GORGON", {
		name:"snake",
		appearanceDesc: "Your [eyecolor] eyes are similar to those of snake-like gorgons with ability to temporally petrify.",
		Darkvision: true
	});
	public static const FENRIR: int = 5;
	EnumValue.add(Types, FENRIR, "FENRIR", {
		name:"fenrir",
		appearanceDesc: "Your [eyecolor] eyes glow with a freezing blue light, and wisps of icy mist drift from them.",
		Darkvision: true
	});
	public static const MANTICORE: int = 6;
	EnumValue.add(Types, MANTICORE, "MANTICORE", {
		name:"manticore",
		appearanceDesc: "Your eyes are similar to those of a cat, with slit pupils. However, their [eyecolor] iris dismiss any links to the regular felines in favor of something way more ominous.",
		Darkvision: true
	});
	public static const FOX: int = 7;
	EnumValue.add(Types, FOX, "FOX", {
		name:"fox",
		appearanceDesc: "Your [eyecolor] eyes look like those of a fox with a slit in the middle."
	});
	public static const LIZARD: int = 8;
	EnumValue.add(Types, LIZARD, "LIZARD", {
		name:"lizard",
		appearanceDesc: "Your eyes looks like those of a reptile with [eyecolor] irises and a slit."
	});
	public static const SNAKE: int = 9;
	EnumValue.add(Types, SNAKE, "SNAKE", {
		name:"snake",
		appearanceDesc: "Your [eyecolor] eyes have slitted pupils like that of a snake."
	});
	public static const DRACONIC: int = 10;
	EnumValue.add(Types, DRACONIC, "DRACONIC", {
		name:"draconic",
		appearanceDesc: "Your [eyecolor] eyes have slitted pupils like that of a dragon.",
		Darkvision: true
	});
	public static const DEVIL: int = 11;
	EnumValue.add(Types, DEVIL, "DEVIL", {
		name:"devil",
		appearanceDesc: "Your eyes look fiendish, with their black sclera and glowing [eyecolor] iris.",
		Darkvision: true
	});
	public static const ONI: int = 12;
	EnumValue.add(Types, ONI, "ONI", {
		name:"oni",
		appearanceDesc: "Your eyes look normal enough save for their fiendish [eyecolor] iris and slitted pupils."
	});
	public static const ELF: int = 13;
	EnumValue.add(Types, ELF, "ELF", {
		name:"elf",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += " Your [eyecolor] elven eyes looks somewhat human, save for their cat-like vertical slit which draws light right in, allowing you to see with perfect precision both at day and night time.";

			if (creature.hasPerk(PerkLib.BlessingOfTheAncestorTree)) desc += " Despite their otherwordly beauty, the misty hollow at the center of your eyes denounce the absence of a soul, which now resides with the forest.";

			return desc;
		},
		Darkvision: true
	});
	public static const RAIJU: int = 14;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, RAIJU, "RAIJU", {
		name:"raiju",
		appearanceDesc: "Your eyes are of an electric [eyecolor] hue that constantly glows with voltage power. They have slitted pupils like those of a beast."
	});
	public static const VAMPIRE: int = 15;
	EnumValue.add(Types, VAMPIRE, "VAMPIRE", {
		name:"vampire",
		appearanceDesc: "Your eyes looks somewhat normal, but their [eyecolor] irises seem to have the tendency of drawing in people’s gaze, like moths to a flame.",
		Darkvision: true
	});
	public static const GEMSTONES: int = 16;
	EnumValue.add(Types, GEMSTONES, "GEMSTONES", {
		name:"gemstone",
		appearanceDesc: "Instead of regular eyes you see through a pair of gemstones that change hue based on your mood.",
		Darkvision: true
	});
	public static const FERAL: int = 17;
	EnumValue.add(Types, FERAL, "FERAL", {
		name:"feral",
		appearanceDesc: "In your [eyecolor] eyes, sometimes a green light is visibly dancing. Hinting at the beast within. It encompasses your entire pupil when you let it loose.",
		Darkvision: true
	});
	public static const GRYPHON: int = 18;
	EnumValue.add(Types, GRYPHON, "GRYPHON", {
		name:"gryphon",
		appearanceDesc: "Your gifted eyes have a bird-like appearance, having an [eyecolor] sclera and a large, black iris. A thin ring of black separates your sclera from your outer iris."
	});
	public static const INFERNAL: int = 19;
	EnumValue.add(Types, INFERNAL, "INFERNAL", {
		name:"infernal",
		appearanceDesc: "Your eyes look fiendish, with their black sclera and glowing [eyecolor] iris. What's more, a small trail of fire blazes on the corners making them all the more intimidating.",
		Darkvision: true
	});
	public static const ORC: int = 20;
	EnumValue.add(Types, ORC, "ORC", {
		name:"orc",
		appearanceDesc: "Your [eyecolor], slanted eyes have slitted pupils. They usually seem to gleam with a sort of malice, avarice, or lechery, giving off beady-eyed vibe."
	});
	public static const CAVE_WYRM: int = 21;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
		name:"cave wyrm",
		appearanceDesc: "Dark blue iris with [eyecolor] eyes pupil that glow in the dark.",
		Darkvision: true
	});
	public static const HINEZUMI: int = 22;
	EnumValue.add(Types, HINEZUMI, "HINEZUMI", {
		name:"hinezumi",
		appearanceDesc: "Your eyes are human-like. However, their [eyecolor] irises are clearly those of an Hinezumi."
	});
	public static const BEAR: int = 23;
	EnumValue.add(Types, BEAR, "BEAR", {
		name:"bear",
		appearanceDesc: "Your eyes are human save for your [eyecolor] pupils closer to those of a bear."
	});
	public static const DISPLACER: int = 24;
	EnumValue.add(Types, DISPLACER, "DISPLACER", {
		name:"displacer",
		appearanceDesc: "Your eyes are similar to those of a cat, with slit pupils. However, their black sclera dismiss any links to the regular felines clearly identifying you to something else.",
		Darkvision: true
	});
	public static const FIRE_SNAIL: int = 25;
	EnumValue.add(Types, FIRE_SNAIL, "FIRE_SNAIL", {
		name:"fire snail",
		appearanceDesc: "Your eyes are normal save for your [eyecolor] iris which glows like smoldering embers."
	});
	public static const GHOST: int = 26;
	EnumValue.add(Types, GHOST, "GHOST", {
		name:"ghost",
		appearanceDesc: "Your eyes glow [eyecolor] with a ghostly aura. You can see clearly in the shadows and might terrify anyone wandering around alone at night.",
		Darkvision: true
	});
	public static const JIANGSHI: int = 27;
	EnumValue.add(Types, JIANGSHI, "JIANGSHI", {
		name:"jiangshi",
		appearanceDesc: "Your [eyecolor] eyes, while humans are vacant and devoid of the warmth of life.",
		Darkvision: true
	});
	public static const GOAT: int = 28;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, GOAT, "GOAT", {
		name:"goat",
		appearanceDesc: "Your eyes are like those of a goat with horizontal slit pupils at the center of their [eyecolor] iris."
	});
	public static const CENTIPEDE: int = 29;
	EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {
		name:"centipede",
		appearanceDesc: ""
	});
	public static const KRAKEN: int = 30;
	EnumValue.add(Types, KRAKEN, "KRAKEN", {
		name:"kraken",
		appearanceDesc: "Your eyes are like those of a octopus with horizontal slit pupils at the center of their [eyecolor] iris.",
		Darkvision: true
	});
	public static const FROSTWYRM: int = 31;
	EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {
		name:"frost wyrm",
		appearanceDesc: "Your [eyecolor] eyes have slitted pupils and dark sclera like those of a frost wyrm.",
		Darkvision: true
	});
	public static const CANCER: int = 32;
	EnumValue.add(Types, CANCER, "CANCER", {
		name:"cancer",
		appearanceDesc: "Your eyes look human at first glance, save for their natural [eyecolor] irises covered by a completely transparent layer of protective tissue to protect them against things such as salt and sand in the water."
	});
	public static const FAIRY: int = 33;
	EnumValue.add(Types, FAIRY, "FAIRY", {
		name:"fairy",
		appearanceDesc: "Your beautiful [eyecolor] eyes sparkle with the eternal hope and child-like innocence of fairykind."
	});
	public static const GREMLIN: int = 34;
	EnumValue.add(Types, GREMLIN, "GREMLIN", {
		name:"gremlin",
		appearanceDesc: "Your [eyecolor] eyes looks human enough though your eyelids are dark, just as if you very tired althought it's more likely traces of your demonic corruption."
	});
	public static const WEASEL: int = 35;
	EnumValue.add(Types, WEASEL, "WEASEL", {
		name:"weasel",
		appearanceDesc: "Your [eyecolor] eyes have slitted pupils like those of a weasel."
	});
	public static const MONOEYE: int = 36;
	EnumValue.add(Types, MONOEYE, "MONOEYE", {
		name:"monoeye",
		appearanceDesc: "Your eye sockets have merged together to reform into a single cyclopean eye charged with powerful magical powers. Your almighty gaze is as peerless as its unsettling.",
		Darkvision: true
	});
	public static const RATATOSKR: int = 37;
	EnumValue.add(Types, RATATOSKR, "RATATOSKR", {
		name:"ratatoskr",
		appearanceDesc: "Your [eyecolor] eyes have slitted pupils like those of a Ratatoskr. Your know it all smug expression plastered in them at all time upsets quite a few."
	});
	public static const FIENDISH: int = 38;
	EnumValue.add(Types, FIENDISH, "FIENDISH", {
		name:"fiendish",
		appearanceDesc: "Your [eyecolor] eyes looks like those of a fiend with a slit in the middle.",
		Darkvision: true
	});
	public static const DEAD: int = 39;
	EnumValue.add(Types, DEAD, "DEAD", {
		name:"dead",
		appearanceDesc: "Your eyes look dead, but the pupils glow in the dark with a [eyecolor].",
		Darkvision: true
	});
	public static const MINDBREAKER: int = 40;
	EnumValue.add(Types, MINDBREAKER, "MINDBREAKER", {
		name:"eldritch",
		appearanceDesc: "In your hair nests many [eyecolor] eyes, granting you a nearly full peripheral vision. The biggest eye rests on your forehead. It is from this eye that you use your formidable mental powers.",
		Darkvision: true
	});
	public static const MINDBREAKERMALE: int = 41;
	EnumValue.add(Types, MINDBREAKERMALE, "MINDBREAKERMALE", {
		name:"eldritch male",
		appearanceDesc: "You have three two [eyecolor], predatory eyes at the front of your head, giving you full sight and perfect perception of what’s in front of you. The eye along your forehead is considerably larger, it is where you channel your formidable mental powers.",
		Darkvision: true
	});
	public static const SNAKEFIENDISH: int = 42;
	EnumValue.add(Types, SNAKEFIENDISH, "SNAKEFIENDISH", {
		name:"fiendish snake",
		appearanceDesc: "Your [eyecolor] eyes have slitted pupils like that of a snake with black schlera wich betray your corrupted nature."
	});

	public var count:int;
	public var colour:String = "brown";
	public function Eyes() {
		super(null, null);
	}

	public static function getAppearanceDescription(creature: *):String {
		const id: int = creature.eyes.type;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
