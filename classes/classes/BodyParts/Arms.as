package classes.BodyParts {
import classes.internals.EnumValue;

public class Arms extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("HUMAN", "HARPY")
	 * - name: human-readable default name, ("human", "harpy")
	 * - appearanceDesc: description of the arms to be displayed
	 * - claw:
	 * - scythe:
	 * - armSlam:
	 * - canFly: [for winged arms] part allows flight at the expense of using both arms, defaults to false
	 * - wingSlap: [for winged arms] part allows a wing slap, defaults to false
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const HUMAN:int = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {
		name:"human",
		appearanceDesc: "You have a pair of normal human arms without any unusual traits."
	});

	public static const HARPY:int = 1;
	EnumValue.add(Types, HARPY, "HARPY", {
		name:"harpy",
		appearanceDesc: "Feathers hang off your arms from shoulder to wrist."
	});

	public static const SPIDER:int = 2;
	EnumValue.add(Types, SPIDER, "SPIDER", {
		name:"spider",
		appearanceDesc: "A shining [skin coat.color] exoskeleton covers your arms from the biceps down, resembling a pair of long [skin coat.color] gloves from a distance."
	});

	public static const MANTIS:int = 3;
	EnumValue.add(Types, MANTIS, "MANTIS", {
		name:"mantis", scythe: true,
		appearanceDesc: "A shining [skin coat.color] exoskeleton covers your arms from the biceps down, with long and sharp scythes extending from the wrists."
	});

	public static const BEE:int = 4;
	EnumValue.add(Types, BEE, "BEE", {
		name:"bee",
		appearanceDesc: "A shining black exoskeleton covers your arms from the biceps down, resembling a pair of long black gloves ending with a yellow fuzz from a distance."
	});

	public static const SALAMANDER:int = 5;
	EnumValue.add(Types, SALAMANDER, "SALAMANDER", {
		name:"salamander",
		appearanceDesc: "Thick, leathery red scales cover your arms from the biceps down, and your fingernails are short curved claws.",
		claw: true
	});

	public static const PHOENIX:int = 6;
	EnumValue.add(Types, PHOENIX, "PHOENIX", {
		name:"phoenix",
		appearanceDesc: "Crimson feathers hang off your arms from shoulder to wrist."
	});

	public static const PLANT:int = 7;
	EnumValue.add(Types, PLANT, "PLANT", {
		name:"plant",
		appearanceDesc: "Delicate vines covered by spade-like leaves crawl down from your shoulders to your wrists, bobbing whenever you move."
	});

	public static const SHARK:int = 8;
	EnumValue.add(Types, SHARK, "SHARK", {
		name:"shark",
		appearanceDesc: "A pair of shark fins have sprouted on each of your forearms near your elbows, and the skin between your fingers forms a small webbing which assists your swimming."
	});

	public static const GARGOYLE:int = 9;
	EnumValue.add(Types, GARGOYLE, "GARGOYLE", {
		name:"gargoyle", armSlam: true,
		appearanceDesc: "Your {gargoyleMaterial} arms end in stone sharp clawed hands."
	});

	public static const WOLF:int = 10;
	EnumValue.add(Types, WOLF, "WOLF", {
		name:"wolf",
		appearanceDesc: "Your arms are covered by thick fur, ending in clawed hands with paw pads.",
		claw: true,
		canPounce: true
	});

	public static const LION:int = 11;
	EnumValue.add(Types, LION, "LION", {
		name:"lion",
		appearanceDesc: "Your arms are covered by [skin coat.color] fur up to your shoulders, where it turns white, and end in a pair of five-toed lion paws armed with lethal claws.",
		claw: true,
		canPounce: true
	});

	public static const KITSUNE:int = 12;
	EnumValue.add(Types, KITSUNE, "KITSUNE", {
		name:"kitsune",
		appearanceDesc: "Your arms are mostly human, save for your sharp nails.",
		claw: true
	});

	public static const FOX:int = 13;
	EnumValue.add(Types, FOX, "FOX", {
		name:"fox",
		appearanceDesc: "Your arms are covered by thick fur, ending in clawed hands with paw pads.",
		claw: true,
		canPounce: true
	});

	public static const LIZARD:int = 14;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, LIZARD, "LIZARD", {
		name:"lizard",
		appearanceDesc: "Thick, leathery scales cover your arms from the biceps down, and your fingernails are short curved claws.",
		claw: true
	});

	public static const DRAGON:int = 15;
	EnumValue.add(Types, DRAGON, "DRAGON", {
		name:"dragon",
		appearanceDesc: "Thick, leathery scales cover your arms from the biceps down, and your fingernails are short curved claws.",
		claw: true
	});

	public static const YETI:int = 16;
	EnumValue.add(Types, YETI, "YETI", {
		name:"yeti",
		appearanceDesc: "Your two arms covered by thick fur end in large and powerful yeti hands. You can use them to smash or punch things when you're angry.",
		armSlam: true
	});

	public static const ORCA:int = 17;
	EnumValue.add(Types, ORCA, "ORCA", {
		name:"orca",
		appearanceDesc: "A pair of orca fins have sprouted on each of your forearms near your elbows, and the skin between your fingers forms a small webbing which assists your swimming."
	});

	public static const PLANT2:int = 18;
	EnumValue.add(Types, PLANT2, "PLANT2", {
		name:"tentacle-covered",
		appearanceDesc: "Vines crawl down from your shoulders to your wrists, tipped with slits that drool precum. They look like innocent decorations from a distance."
	});

	public static const DEVIL:int = 19;
	EnumValue.add(Types, DEVIL, "DEVIL", {
		name:"devil",
		appearanceDesc: "Your forearms are covered by fur and end in four-fingered paw-like hands armed with claws. Despite their weird shape, you have more than enough dexterity to draw even the most complex magical signs when spellcasting.",
		claw: true
	});

	public static const ONI:int = 20;
	EnumValue.add(Types, ONI, "ONI", {
		name:"oni",
		appearanceDesc: "Your arms are mostly human besides sharp black nails, and covered by war tattoos.",
		armSlam: true
	});

	public static const ELF:int = 21;
	EnumValue.add(Types, ELF, "ELF", {
		name:"elf",
		appearanceDesc: "Your delicate elven hands are almost supernaturally dexterous, allowing you to manipulate objects or cast spells with unbelievable ease."
	});

	public static const RAIJU:int = 22;
	EnumValue.add(Types, RAIJU, "RAIJU", {
		name:"raiju",
		appearanceDesc: "Your arms are practically human, save for the sharp white claws you have in place of normal nails.",
		claw: true
	});

	public static const RED_PANDA:int = 23;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
		name:"red-panda",
		appearanceDesc: "Soft, black-brown fluff covers your arms. Your paws have cute, pink paw pads and short claws.",
		claw: true
	});

	public static const GARGOYLE_2:int = 24;
	EnumValue.add(Types, GARGOYLE_2, "GARGOYLE_2", {
		name:"gargoyle",
		appearanceDesc: "Your {gargoyleMaterial} arms end in normal human like hands.",
		claw: true
	});

	public static const CAT:int = 25;
	EnumValue.add(Types, CAT, "CAT", {
		name:"cat",
		appearanceDesc: "Your arms are covered by [skin coat.color] fur up to your shoulder. They end in a pair of five-toed cat paws armed with lethal claws.",
		claw: true,
		canPounce: true
	});

	public static const AVIAN:int = 26;
	EnumValue.add(Types, AVIAN, "AVIAN", {
		name:"avian",
		appearanceDesc: "Your arms are covered by [skin coat.color] colored feathers just a bit past your elbow. Your humanoid hands have {skinTone}, slightly rough skin, and end in short claws.",
		claw: true
	});

	public static const GRYPHON:int = 27;
	EnumValue.add(Types, GRYPHON, "GRYPHON", {
		name:"gryphon",
		appearanceDesc: "The feathers on your arms reach a bit past your elbows, with a fringe of [skin coat.color] plumage leading to your {skinTone}, slightly rough-skinned hands equipped with short, avian claws.",
		claw: true
	});

	public static const SPHINX:int = 28;
	EnumValue.add(Types, SPHINX, "SPHINX", {
		name:"sphinx",
		appearanceDesc: "Your arms are covered by [skin coat.color] fur. They end in somewhat human-like hands armed with lethal claws.",
		claw: true
	});

	public static const PIG:int = 29;
	EnumValue.add(Types, PIG, "PIG", {
		name:"pig",
		appearanceDesc: ""
	});

	public static const BOAR:int = 30;
	EnumValue.add(Types, BOAR, "BOAR", {
		name:"boar",
		appearanceDesc: "Your arms are covered by thick [skin coat.color] fur, ending in hands with sharp black nails."
	});

	public static const ORC:int = 31;
	EnumValue.add(Types, ORC, "ORC", {
		name:"orc",
		appearanceDesc: "Although your nails are rather sharp, your arms covered in scar-like tattoos look mostly human, aside from being a bit longer than usual."
	});

	public static const DISPLACER:int = 32;
	EnumValue.add(Types, DISPLACER, "DISPLACER", {
		name:"displacer",
		appearanceDesc: "Where a normal creature would have only two arms, you instead have four [skin coat.color] furred appendages, all of which end in a pair of five-toed lion paws armed with lethal claws.",
		claw: true,
		canPounce: true
	});

	public static const CAVE_WYRM:int = 33;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
		name:"cave wyrm",
		appearanceDesc: "Thick, leathery black scales cover your arms from the biceps down, and your fingernails are short curved claws.",
		claw: true
	});

	public static const HINEZUMI:int = 34;
	EnumValue.add(Types, HINEZUMI, "HINEZUMI", {
		name:"hinezumi", armSlam: true,
		appearanceDesc: "Your forearms, while human in shape, are covered by a thick coat of flames that burn depending on your mood."
	});

	public static const BEAR:int = 35;
	EnumValue.add(Types, BEAR, "BEAR", {
		name:"bear",
		appearanceDesc: "You have [skin coat.color] furry arms, ending in a pair of powerful five-toed bear paws armed with lethal claws.",
		claw: true
	});

	public static const GOO:int = 36;
	EnumValue.add(Types, GOO, "GOO", {
		name:"goo",
		appearanceDesc: "While usually kept in a human shape, your constantly dripping arms are actually liquid, allowing you to shape them to your convenience."
	});

	public static const HYDRA:int = 37;
	EnumValue.add(Types, HYDRA, "HYDRA", {
		name:"hydra",
		appearanceDesc: "Plate-like scales cover your arms from the biceps down, and your fingernails are sharp curved claws perfect for tearing through flesh.",
		claw: true
	});

	public static const GHOST:int = 38;
	EnumValue.add(Types, GHOST, "GHOST", {
		name:"ghost",
		appearanceDesc: "Your arms and hands are practically human, save for the fact that they are ghastly in nature."
	});

	public static const JIANGSHI:int = 39;
	EnumValue.add(Types, JIANGSHI, "JIANGSHI", {
		name:"jiangshi",
		appearanceDesc: "Your arms are essentially human, but underneath your purple nails is a thick layer of deadly poison.",
		claw: true
	});

	public static const RAIJU_2:int = 40;
	EnumValue.add(Types, RAIJU_2, "RAIJU_2", {
		name:"raiju paws",
		appearanceDesc: "Your forearms are covered by dense fur upon which an electric current runs free. Your pawed hands end in sharp claws capable of delivering powerful discharges.",
		claw: true
	});

	public static const YUKI_ONNA:int = 41;
	EnumValue.add(Types, YUKI_ONNA, "YUKI_ONNA", {
		name:"yuki onna",
		appearanceDesc: "Your arms and hands are human in appearance, but your blue-nailed hands are colder than death."
	});

	public static const MELKIE:int = 42;
	EnumValue.add(Types, MELKIE, "MELKIE", {
		name:"melkie",
		appearanceDesc: "Your arms and hands are human in appearance, but your blue-nailed hands are colder than death.",
		claw: true
	});

	public static const CENTIPEDE:int = 43;
	EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {
		name:"centipede",
		appearanceDesc: "Your arms and hands are mostly human in shape, ending in sharp purple nails. Intricate flowing purple markings stretch from your shoulders to your hands."
	});

	public static const KRAKEN:int = 44;
	EnumValue.add(Types, KRAKEN, "KRAKEN", {
		name:"kraken",
		appearanceDesc: ""
	});

	public static const FROSTWYRM:int = 45;
	EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {
		name:"frostwyrm",
		appearanceDesc: "Your forearms are covered by scales which themselves are covered by fur, ending in five fingered clawed hands. Your claws are strong enough to rip and tear through next to anything.",
		claw: true
	});

	public static const CANCER:int = 46;
	EnumValue.add(Types, CANCER, "CANCER", {
		name:"cancer",
		appearanceDesc: ""
	});

	public static const USHI_ONI_ONNA:int = 47;
	EnumValue.add(Types, USHI_ONI_ONNA, "USHI_ONI_ONNA", {
		name:"ushi-oni",
		appearanceDesc: "You have ushi-oni arms, longer and thicker than those of most races. A strange pattern of fur descends from your middle biceps down to your hands, where you have bone-like claws rather than fingers."
	});

	public static const KAMAITACHI:int = 48;
	EnumValue.add(Types, KAMAITACHI, "KAMAITACHI", {
		name:"kamaitachi",
		appearanceDesc: "Your arms are covered by [skin coat.color] fur up to your shoulders. They end in a pair of five-toed weasel paws armed with claws. Your forearms' fur part ways slightly as a pair of long scythes-like blades curves outward toward your elbow, sharper than any sword.",
		scythe: true
	});

	public static const GAZER:int = 49;
	EnumValue.add(Types, GAZER, "GAZER", {
		name:"gazer",
		appearanceDesc: "Your arms are human in appearance, but drip with oily black fluid."
	});

	public static const RACCOON:int = 50;
	EnumValue.add(Types, RACCOON, "RACCOON", {
		name:"raccoon",
		appearanceDesc: "",
		claw: true
	});

	public static const WEASEL:int = 51;
	EnumValue.add(Types, WEASEL, "WEASEL", {
		name:"weasel",
		appearanceDesc: "",
		claw: true
	});

	public static const SQUIRREL:int = 52;
	EnumValue.add(Types, SQUIRREL, "SQUIRREL", {
		name:"squirrel",
		appearanceDesc: "Your arms are covered by [skin coat.color] fur up to your shoulders. They end in a pair of five-toed squirrel paws, armed with claws which can assist you when climbing trees.",
		claw: true
	});

	public static const WENDIGO:int = 53;
	EnumValue.add(Types, WENDIGO, "WENDIGO", {
		name:"wendigo",
		appearanceDesc: "Your arms and hands are practically human, save for the sharp white claws you have in place of normal nails.",
		claw: true
	});

	public static const BAT:int = 54;
	EnumValue.add(Types, BAT, "BAT", {
		name:"bat",
		appearanceDesc: "The bones in your arms are thin and light, granting you the ability to take flight. Instead of the five fingers you started out with, you now have three that are both larger and stronger. Besides the occasional troubles with an awkward grip, you can still hold various items even with your abnormal hands, albeit at the cost of preventing flight while doing so.",
		claw: true,
		canFly: true,
		wingSlap: true
	});

	public static const SEADRAGON:int = 55;
	EnumValue.add(Types, SEADRAGON, "SEADRAGON", {
		name:"sea dragon",
		appearanceDesc: "A pair of fins have sprouted on each of your forearms near your elbows, and the skin between your fingers forms a small webbing which assists your swimming. You have sharp and deadly claws which allow you to impale your prey or rip your foes to shreds.",
		claw: true
	});

	public static function canFly(id: int): Boolean {
		return Types[id].canFly || false;
	}

	public function Arms() {
		super(null, null);
	}

	public static function getAppearanceDescription(opts:Object):String {
		if (Types[opts.id].appearanceDesc) {
			return formatDescription(Types[opts.id].appearanceDesc, opts);
		}

		return "";
	}

	private static function formatDescription(desc:String, opts: Object): String {
		const upperCasePattern:RegExp = /^./;
		const skinTonePattern:RegExp = /{skinTone}/g;
		const gargoyleMaterialPattern:RegExp = /{gargoyleMaterial}/g;

		return " " + desc
			.replace(skinTonePattern, opts.skinTone)
			.replace(gargoyleMaterialPattern, opts.gargoyleMaterial)
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
