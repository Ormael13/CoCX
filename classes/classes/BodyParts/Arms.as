package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

public class Arms extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("HUMAN", "HARPY")
	 * - name: human-readable default name, ("human", "harpy")
	 *
	 * - appearanceDesc: description for PlayerAppearance.as (always visible)
	 * - appearanceDescFunc: a function that returns a description for PlayerAppearance.as (appearanceDesc is ignored if this exists)
	 *
	 * - claw: whether the arms include claws
	 * - scythe: whether the arms include scythe-like claws
	 * - armSlam: whether the arms enable armSlam
	 * - canFly: [for winged arms] whether allows flight at the expense of using both arms
	 * - wingSlap: [for winged arms] whether part allows a wing slap
	 * - fourArms: whenever arms are four not two
	 *
	 * - hairy: has hair material
	 * - fur: has fur material
	 * - feathers: has feathers material
	 * - scales: has scales material
	 * - chitin: has chitin material
	 * */
	public static var Types:/*EnumValue*/Array = [];

	public static const HUMAN:int = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {
		name:"human",
		appearanceDesc: "You have a pair of normal human arms without any unusual traits."
	});

	public static const HARPY:int = 1;
	EnumValue.add(Types, HARPY, "HARPY", {
		name:"harpy",
		appearanceDesc: "Feathers hang off your arms from shoulder to wrist.",
		feathers: true
	});

	public static const SPIDER:int = 2;
	EnumValue.add(Types, SPIDER, "SPIDER", {
		name:"spider",
		appearanceDesc: "A shining [chitin color1] exoskeleton covers your arms from the biceps down, resembling a pair of long [chitin color1] gloves from a distance.",
		chitin: true
	});

	public static const MANTIS:int = 3;
	EnumValue.add(Types, MANTIS, "MANTIS", {
		name:"mantis", scythe: true,
		appearanceDesc: "A shining [chitin color1] exoskeleton covers your arms from the biceps down, with long and sharp scythes extending from the wrists.",
		chitin: true
	});

	public static const BEE:int = 4;
	EnumValue.add(Types, BEE, "BEE", {
		name:"bee",
		appearanceDesc: "A shining [chitin color2] exoskeleton covers your arms from the biceps down, resembling a pair of long [chitin color2] gloves ending with a [chitin color1] fuzz from a distance.",
		chitin: true
	});

	public static const SALAMANDER:int = 5;
	EnumValue.add(Types, SALAMANDER, "SALAMANDER", {
		name:"salamander",
		appearanceDesc: "Thick, leathery red scales cover your arms from the biceps down, and your fingernails are short curved claws.",
		claw: true,
		scales: true
	});

	public static const PHOENIX:int = 6;
	EnumValue.add(Types, PHOENIX, "PHOENIX", {
		name:"phoenix",
		appearanceDesc: "Crimson feathers hang off your arms from shoulder to wrist.",
		feathers: true
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
		name:"gargoyle",
		appearanceDesc: "Your [gargoylematerial] arms end in stone sharp clawed hands.",
		claw: true
	});

	public static const WOLF:int = 10;
	EnumValue.add(Types, WOLF, "WOLF", {
		name:"wolf",
		appearanceDesc: "Your arms are covered by thick fur, ending in clawed hands with paw pads.",
		claw: true,
		canPounce: true,
		fur: true
	});

	public static const LION:int = 11;
	EnumValue.add(Types, LION, "LION", {
		name:"lion",
		appearanceDesc: "Your arms are covered by [fur color] fur up to your shoulders, where it turns white, and end in a pair of five-toed lion paws armed with lethal claws.",
		claw: true,
		canPounce: true,
		feline: true,
		fur: true
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
		canPounce: true,
		fur: true
	});

	public static const LIZARD:int = 14;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, LIZARD, "LIZARD", {
		name:"lizard",
		appearanceDesc: "Thick, leathery scales cover your arms from the biceps down, and your fingernails are short curved claws.",
		claw: true,
		scales: true
	});

	public static const DRACONIC:int = 15;
	EnumValue.add(Types, DRACONIC, "DRACONIC", {
		name:"dragon",
		appearanceDesc: "Thick, leathery scales cover your arms from the biceps down, and your fingernails are short curved claws.",
		claw: true,
		scales: true
	});

	public static const YETI:int = 16;
	EnumValue.add(Types, YETI, "YETI", {
		name:"yeti",
		appearanceDesc: "Your two arms covered by thick fur end in large and powerful yeti hands. You can use them to smash or punch things when you're angry.",
		armSlam: true,
		fur: true
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
		claw: true,
		fur: true
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
		claw: true,
		fur: true
	});

	public static const RED_PANDA:int = 23;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
		name:"red-panda",
		appearanceDesc: "Soft, black-brown fluff covers your arms. Your paws have cute, pink paw pads and short claws.",
		claw: true,
		fur: true
	});

	public static const GARGOYLE_2:int = 24;
	EnumValue.add(Types, GARGOYLE_2, "GARGOYLE_2", {
		name:"gargoyle",
		appearanceDesc: "Your [gargoylematerial] arms end in normal human like hands.",
		armSlam: true
	});

	public static const CAT:int = 25;
	EnumValue.add(Types, CAT, "CAT", {
		name:"cat",
		appearanceDesc: "Your arms are covered by [fur color] fur up to your shoulder. They end in a pair of five-toed cat paws armed with lethal claws.",
		claw: true,
		canPounce: true,
		feline: true,
		fur: true
	});

	public static const AVIAN:int = 26;
	EnumValue.add(Types, AVIAN, "AVIAN", {
		name:"avian",
		appearanceDesc: "Your arms are covered by [feather color] colored feathers just a bit past your elbow. Your humanoid hands have [skin color], slightly rough skin, and end in short claws.",
		claw: true,
		feathers: true
	});

	public static const GRYPHON:int = 27;
	EnumValue.add(Types, GRYPHON, "GRYPHON", {
		name:"gryphon",
		appearanceDesc: "The feathers on your arms reach a bit past your elbows, with a fringe of [feather color] plumage leading to your [skin color], slightly rough-skinned hands equipped with short, avian claws.",
		claw: true,
		canPounce: true,
		feahers: true,
		fur: true
	});

	public static const SPHINX:int = 28;
	EnumValue.add(Types, SPHINX, "SPHINX", {
		name:"sphinx",
		appearanceDesc: "Your arms are covered by [fur color] fur. They end in somewhat human-like hands armed with lethal claws.",
		claw: true,
		canPounce: true,
		feline: true,
		fur: true
	});

	public static const PIG:int = 29;
	EnumValue.add(Types, PIG, "PIG", {
		name:"pig",
		appearanceDesc: ""
	});

	public static const BOAR:int = 30;
	EnumValue.add(Types, BOAR, "BOAR", {
		name:"boar",
		appearanceDesc: "Your arms are covered by thick [fur color] fur, ending in hands with sharp black nails.",
		fur: true
	});

	public static const ORC:int = 31;
	EnumValue.add(Types, ORC, "ORC", {
		name:"orc",
		appearanceDesc: "Although your nails are rather sharp, your arms covered in scar-like tattoos look mostly human, aside from being a bit longer than usual."
	});

	public static const DISPLACER:int = 32;
	EnumValue.add(Types, DISPLACER, "DISPLACER", {
		name:"displacer",
		appearanceDesc: "Where a normal creature would have only two arms, you instead have four [fur color] furred appendages, all of which end in a pair of five-toed lion paws armed with lethal claws.",
		fourArms: true,
		claw: true,
		canPounce: true,
		feline: true,
		fur: true
	});

	public static const CAVE_WYRM:int = 33;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
		name:"cave wyrm",
		appearanceDesc: "Thick, leathery black scales cover your arms from the biceps down, and your fingernails are short curved claws.",
		claw: true,
		scales: true
	});

	public static const HINEZUMI:int = 34;
	EnumValue.add(Types, HINEZUMI, "HINEZUMI", {
		name:"hinezumi", armSlam: true,
		appearanceDesc: "Your forearms, while human in shape, are covered by a thick coat of flames that burn depending on your mood."
	});

	public static const BEAR:int = 35;
	EnumValue.add(Types, BEAR, "BEAR", {
		name:"bear",
		appearanceDesc: "You have [fur color] furry arms, ending in a pair of powerful five-toed bear paws armed with lethal claws.",
		claw: true,
		fur: true
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
		claw: true,
		scales: true
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

	public static const RAIJU_PAWS:int = 40;
	EnumValue.add(Types, RAIJU_PAWS, "RAIJU_PAWS", {
		name:"raiju paws",
		appearanceDesc: "Your forearms are covered by dense fur upon which an electric current runs free. Your pawed hands end in sharp claws capable of delivering powerful discharges.",
		claw: true,
		fur: true
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
		claw: true,
		scales: true
	});

	public static const CANCER:int = 46;
	EnumValue.add(Types, CANCER, "CANCER", {
		name:"cancer",
		appearanceDesc: ""
	});

	public static const USHI_ONI:int = 47;
	EnumValue.add(Types, USHI_ONI, "USHI_ONI", {
		name:"ushi-oni",
		appearanceDesc: "You have ushi-oni arms, longer and thicker than those of most races. A strange pattern of fur descends from your middle biceps down to your hands, where you have bone-like claws rather than fingers.",
		fur: true
	});

	public static const KAMAITACHI:int = 48;
	EnumValue.add(Types, KAMAITACHI, "KAMAITACHI", {
		name:"kamaitachi",
		appearanceDesc: "Your arms are covered by [fur color] fur up to your shoulders. They end in a pair of five-toed weasel paws armed with claws. Your forearms' fur part ways slightly as a pair of long scythes-like blades curves outward toward your elbow, sharper than any sword.",
		scythe: true,
		fur: true
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
		appearanceDesc: "Your arms are covered by [fur color] fur up to your shoulders. They end in a pair of five-toed squirrel paws, armed with claws which can assist you when climbing trees.",
		claw: true,
		fur: true
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

	public static const SEA_DRAGON:int = 55;
	EnumValue.add(Types, SEA_DRAGON, "SEA_DRAGON", {
		name:"sea dragon",
		appearanceDesc: "A pair of fins have sprouted on each of your forearms near your elbows, and the skin between your fingers forms a small webbing which assists your swimming. You have sharp and deadly claws which allow you to impale your prey or rip your foes to shreds.",
		claw: true
	});

	public static const MINDBREAKER:int = 56;
	EnumValue.add(Types, MINDBREAKER, "MINDBREAKER", {
		name:"mindbreaker",
		appearanceDesc: "Your arms are sleeved up in a web-like membrane, it’s very likely that they could be good for swimming too."
	});

	public static const JABBERWOCKY:int = 57;
	EnumValue.add(Types, JABBERWOCKY, "JABBERWOCKY", {
		name:"jabberwocky",
		appearanceDesc: "Your forearms are covered by scales which themselves are covered by fur, ending in five fingered clawed hands. Your claws are strong enough to rip and tear through next to anything though you tend to use your arms as a mean to keep your partners pinned down so they don't move during sex.",
		claw: true,
		scales: true
	});

	public static const ANT:int = 58;
	EnumValue.add(Types, ANT, "ANT", {
		name:"ant",
		appearanceDesc: "Where a normal creature would have only two arms, you instead have four, with shining [chitin color] exoskeleton covering them from the biceps down, resembling a pair of long [chitin color] gloves from a distance.",
		fourArms: true,
		claw: true,
		chitin: true
	});

	public static const FEY_DRACONIC:int = 59;
	EnumValue.add(Types, FEY_DRACONIC, "FEY_DRACONIC", {
		name:"fae dragon",
		appearanceDesc: "Leathery scales cover your arms from the biceps down. While soft to the touch, the scales are rigid, acting as sturdy natural armour. Your fingernails are short, and as you flex your fingers, they extend out into thin curved claws.",
		claw: true,
		scales: true
	});

	public static const HOUND:int = 60;
	EnumValue.add(Types, HOUND, "HOUND", {
		name:"hound",
		appearanceDesc: "Your lower arms are covered by thick fur, ending in clawed hands with paw pads.",
		claw: true,
		canPounce: true,
		fur: true
	});

	public static const TINY:int = 61;
	EnumValue.add(Types, TINY, "TINY", {
		name:"tiny",
		appearanceDesc: "Your arms look human save for the disproportion between your clawed hands and body which make them look way too large for the limbs they are attached to.",
		claw: true
	});

	public static const CANINE:int = 62;
	EnumValue.add(Types, CANINE, "CANINE", {
		name:"canine",
		appearanceDesc: "Your arms are covered in thick [fur color] fur ending up with clawed hands with animal like paw pads.",
		claw: true
	});

	public static const ABYSSAL_SHARK:int = 63;
	EnumValue.add(Types, ABYSSAL_SHARK, "ABYSSAL_SHARK", {
		name:"a.shark",
		appearanceDesc: "A pair of large shark fins have sprouted on each of your forearms, just past the elbows. The skin between your fingers has become webbed to further assist with your swimming. At the tip of your fingers, you have sharp, deadly claws that allow you to shred and impale foes with ease.",
		claw: true
	});

	public static const ARMORED_FOREARMS:int = 64;
	EnumValue.add(Types, ARMORED_FOREARMS, "ARMORED_FOREARMS", {
		name:"arigean",
		appearanceDesc: "Your arms are identical to those of a human, However your forearms seem to be covered in fragments of a black, glossy metal acting as natural bracers."
	});

	public static const DEMON:int = 65;
	EnumValue.add(Types, DEMON, "DEMON", {
		name:"demon",
		appearanceDesc: "Your arms and hands are human in appearance save for your pointy claw like demonic nails.",
		claw: true
	});

	public static const DEER:int = 66;
	EnumValue.add(Types, DEER, "DEER", {
		name:"deer",
		appearanceDesc: "Your arms are covered by thick [fur color] fur, ending in hands with paw pads and three fingers ending with hoof-like fingernails.",
		fur: true
	});

	public static const REINDEER:int = 67;
	EnumValue.add(Types, REINDEER, "REINDEER", {
		name:"reindeer",
		appearanceDesc: "Your arms are covered by thick [fur color] fur, ending in hands with paw pads and four fingers ending with hoof-like fingernails.",
		fur: true
	});
	
	public static const MOTH:int = 68;
	EnumValue.add(Types, MOTH, "MOTH", {
		name:"moth",
		appearanceDesc: "Where a normal creature would have only two arms, you instead have four covered in a sleeve like fuzzy mass.",
		fourArms: true
	});

	public static const SATYR:int = 69;
	EnumValue.add(Types, SATYR, "SATYR", {
		name:"satyr",
		appearanceDesc: "Your arms are covered with [fur color] fur. They end with somewhat human-like hands with sharp nails. Such dexterous hands are as adept at playing a piper as they would to draw out moans out of a partner.",
		claw: true,
		fur: true
	});
	
	public static function canFly(id: int): Boolean {
		return Types[id].canFly || false;
	}

	public function Arms(creature:Creature) {
		super(creature, null);
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

	public static function getAppearanceDescription(creature: *):String {
		const id: int = creature.arms.type;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}

	public static function hasFelineArms(creature: *):Boolean {
		const id: int = creature.arms.type;

		return Types[id].feline || false;
	}

	public function hasPawsOrHands():String {
		return Types[type].canPounce ? "paws" : "hands";
	}

	public function hasFourArms():Boolean {
		return Types[type].fourArms || false;
	}
}
}
