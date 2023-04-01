package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;
import classes.EngineCore;

public class Ears extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 10)
	 * - id: name of the constant ("HUMAN", "HORSE")
	 * - name: human-readable name, ("human", "horse")
	 *
	 * - hairy: has hair material
	 * - fur: has fur material
	 * - feathers: has feathers material
	 * - scales: has scales material
	 * - chitin: has chitin material
	 * */
	public static var Types:/*EnumValue*/Array = [];

	public static const HUMAN: int = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {
		name: "human",
		appearanceDesc: "A pair of normal human ears stick out from the sides of your head."
	});
	public static const HORSE: int = 1;
	EnumValue.add(Types, HORSE, "HORSE", {
		name: "horse",
		appearanceDesc: "A pair of horse-like ears rise up from the top of your head.",
		fur: true
	});
	public static const DOG: int = 2;
	EnumValue.add(Types, DOG, "DOG", {
		name: "dog",
		appearanceDesc: "A pair of dog ears protrude from your head, flopping down adorably.",
		fur: true
	});
	public static const COW: int = 3;
	EnumValue.add(Types, COW, "COW", {
		name: "cow",
		appearanceDesc: "A pair of round, [fur color] floppy cow ears protrude from the sides of your head.",
		fur: true
	});
	public static const ELFIN: int = 4;
	EnumValue.add(Types, ELFIN, "ELFIN", {
		name: "elfin",
		appearanceDesc: "A pair of large pointy ears stick out from your head."
	});
	public static const CAT: int = 5;
	EnumValue.add(Types, CAT, "CAT", {
		name: "cat",
		appearanceDesc: "A pair of cute, fuzzy cat ears have sprouted from the top of your head.",
		fur: true
	});
	public static const LIZARD: int = 6;
	EnumValue.add(Types, LIZARD, "LIZARD", {
		name: "lizard",
		appearanceDesc: "A pair of rounded protrusions with small holes on the sides of your head serve as your ears."
	});
	public static const BUNNY: int = 7;
	EnumValue.add(Types, BUNNY, "BUNNY", {
		name: "bunny",
		appearanceDesc: "A pair of floppy rabbit ears stick up from the top of your head, flopping around as you walk.",
		fur: true
	});
	public static const KANGAROO: int = 8;
	EnumValue.add(Types, KANGAROO, "KANGAROO", {
		name: "kangaroo",
		appearanceDesc: "",
		fur: true
	});
	public static const FOX: int = 9;
	EnumValue.add(Types, FOX, "FOX", {
		name: "fox",
		appearanceDesc: "A pair of large, adept fox ears sit high on your head, always listening.",
		fur: true
	});
	public static const DRAGON: int = 10;
	EnumValue.add(Types, DRAGON, "DRAGON", {
		name: "dragon",
		appearanceDesc: "A pair of rounded protrusions with small holes on the sides of your head serve as your ears. Bony fins sprout behind them.",
		scales: true
	});
	public static const RACCOON: int = 11;
	EnumValue.add(Types, RACCOON, "RACCOON", {
		name: "raccoon",
		appearanceDesc: "A pair of vaguely egg-shaped, furry raccoon ears adorns your head.",
		fur: true
	});
	public static const MOUSE: int = 12;
	EnumValue.add(Types, MOUSE, "MOUSE", {
		name: "mouse",
		appearanceDesc: "A pair of large, dish-shaped mouse ears tops your head.",
		fur: true
	});
	public static const FERRET: int = 13;
	EnumValue.add(Types, FERRET, "FERRET", {
		name: "ferret",
		appearanceDesc: "A pair of small, rounded ferret ears sit on top of your head.",
		fur: true
	});
	public static const PIG: int = 14;
	EnumValue.add(Types, PIG, "PIG", {
		name: "pig",
		appearanceDesc: "A pair of pointy, floppy pig ears have sprouted from the top of your head."
	});
	public static const RHINO: int = 15;
	EnumValue.add(Types, RHINO, "RHINO", {
		name: "rhino",
		appearanceDesc: "A pair of open tubular rhino ears protrude from your head."
	});
	public static const ECHIDNA: int = 16;
	EnumValue.add(Types, ECHIDNA, "ECHIDNA", {
		name: "echidna",
		appearanceDesc: "A pair of small rounded openings appear on your head that are your ears."
	});
	public static const DEER: int = 17;
	EnumValue.add(Types, DEER, "DEER", {
		name: "deer",
		appearanceDesc: "A pair of deer-like ears rise up from the top of your head.",
		fur: true
	});
	public static const WOLF: int = 18;
	EnumValue.add(Types, WOLF, "WOLF", {
		name: "wolf",
		appearanceDesc: "A pair of pointed wolf ears rise up from the top of your head.",
		fur: true
	});
	public static const LION: int = 19;
	EnumValue.add(Types, LION, "LION", {
		name: "lion",
		appearanceDesc: "A pair of lion ears have sprouted from the top of your head.",
		fur: true
	});
	public static const YETI: int = 20;
	EnumValue.add(Types, YETI, "YETI", {
		name: "yeti",
		appearanceDesc: "A pair of yeti ears, bigger than your old human ones have sprouted from the top of your head."
	});
	public static const ORCA: int = 21;
	EnumValue.add(Types, ORCA, "ORCA", {
		name: "orca",
		appearanceDesc: "A pair of very large fin at least twice as large as your head which help you orient yourself underwater have sprouted from the top of your head. Their underside is [skin color2] while the top is [skin color1]."
	});
	public static const ORCA2: int = 22;
	EnumValue.add(Types, ORCA2, "ORCA2", {
		name: "orca",
		appearanceDesc: "A pair of rounded protrusions with small holes on the sides of your head serve as your ears."
	});
	public static const SNAKE: int = 23;
	EnumValue.add(Types, SNAKE, "SNAKE", {
		name: "snake",
		appearanceDesc: "A pair of large pointy ears covered in small scales stick out from your head.",
		scales: true
	});
	public static const GOAT: int = 24;
	EnumValue.add(Types, GOAT, "GOAT", {
		name: "goat",
		appearanceDesc: "A long pair of goat-like ears stick out from your head, flapping from time to time in response to sounds.",
		fur: true
	});
	public static const ONI: int = 25;
	EnumValue.add(Types, ONI, "ONI", {
		name: "oni",
		appearanceDesc: "A pair of pointed elf-like oni ears stick out from your head."
	});
	public static const ELVEN: int = 26;
	EnumValue.add(Types, ELVEN, "ELVEN", {
		name: "elven",
		appearanceDesc: "A pair of cute, long, elven, pointy ears, bigger than your old human ones and alert to every sound stick out from your head."
	});
	public static const RAIJU: int = 27;
	EnumValue.add(Types, RAIJU, "RAIJU", {
		name: "raiju",
		appearanceDesc: "A pair of sideways leaning raiju ears stick out from your head, flicking toward every slight sound.",
		fur: true
	});
	public static const BAT: int = 28;
	EnumValue.add(Types, BAT, "BAT", {
		name: "bat",
		appearanceDesc: "A pair of bat ears sit atop your head, always perked up to catch any stray sound."
	});
	public static const VAMPIRE: int = 29;
	EnumValue.add(Types, VAMPIRE, "VAMPIRE", {
		name: "vampire",
		appearanceDesc: "A pair of pointed elfin ears powerful enough to catch even the heartbeat of those around you stick out from your head."
	});
	public static const RED_PANDA: int = 30;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
		name: "red-panda",
		appearanceDesc: "Big, white furred, red-panda ears lie atop your head, keeping you well aware to your surroundings.",
		fur: true
	});
	public static const AVIAN: int = 31;
	EnumValue.add(Types, AVIAN, "AVIAN", {
		name: "avian",
		appearanceDesc: "Two small holes at each side of your head serve you as ears. Hidden by tufts of feathers, they’re almost unnoticeable."
	});
	public static const GRYPHON: int = 32;
	EnumValue.add(Types, GRYPHON, "GRYPHON", {
		name: "gryphon",
		appearanceDesc: "A duo of triangular, streamlined ears are located at each side of your head, helping you to pinpoint sounds. They’re covered in soft, [fur color] fur and end in tufts.",
		fur: true
	});
	public static const CAVE_WYRM: int = 33;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
		name: "cave wyrm",
		appearanceDesc: "Your ears are furry yet they do not actually belong to any known type of mammal. You suspect them to be related to an ancestry closer to that of the serpentine dragons they emulate.",
		fur: true
	});
	public static const BEAR: int = 34;
	EnumValue.add(Types, BEAR, "BEAR", {
		name: "bear",
		appearanceDesc: "A pair of two round fuzzy bear ears covered with [fur color] and alert to sound stick out from your head.",
		fur: true
	});
	public static const PANDA: int = 35;
	EnumValue.add(Types, PANDA, "PANDA", {
		name: "panda",
		appearanceDesc: "A pair of two round fuzzy panda ears covered with black fur just like a panda and alert to sound stick out from your head.",
		fur: true
	});
	public static const SHARK: int = 36;
	EnumValue.add(Types, SHARK, "SHARK", {
		name: "shark",
		appearanceDesc: "A pair of fin like ears with fins stick out from your head. They allow you to hear every sound with perfect clarity while underwater."
	});
	public static const DISPLACER: int = 37;
	EnumValue.add(Types, DISPLACER, "DISPLACER", {
		name: "displacer",
		appearanceDesc: "A large long furry ears atop your head, always perked up to catch any stray sound.",
		fur: true
	});
	public static const MELKIE: int = 38;
	EnumValue.add(Types, MELKIE, "MELKIE", {
		name: "melkie",
		appearanceDesc: "Your furry Melkie ears are long and flat, reaching all the way down to your waist.",
		fur: true
	});
	public static const GREMLIN: int = 39;
	EnumValue.add(Types, GREMLIN, "GREMLIN", {
		name: "gremlin",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "A pair of sideways leaning furry ears stick out from the side of your head, they flick toward every slight sound. They don’t belong to any known animal but like anything demonic related, it helps improve your devilish charm." + (EngineCore.silly() ? " With ears like that, anyone would be hard-pressed to resist the urge to headpat you." : "");

			return desc;
		}
	});
	public static const WEASEL: int = 40;
	EnumValue.add(Types, WEASEL, "WEASEL", {
		name: "weasel",
		appearanceDesc: "A pair of two round fuzzy weasel ears covered with [fur color] and alert to sound stick out from your head.",
		fur: true
	});
	public static const SQUIRREL: int = 41;
	EnumValue.add(Types, SQUIRREL, "SQUIRREL", {
		name: "squirrel",
		appearanceDesc: "A pair of sideways round squirrel ears stick out from the side of your head, they flick toward every slight sound.",
		fur: true
	});
	public static const INSECT: int = 42;
	EnumValue.add(Types, INSECT, "INSECT", {
		name: "insect",
		appearanceDesc: "A pair of rounded chitin plates with small holes in their bottom on the sides of your head serve as your ears."
	});
	public static const KIRIN: int = 43;
	EnumValue.add(Types, KIRIN, "KIRIN", {
		name: "kirin",
		appearanceDesc: "A pair of animal like ears rise up from the top of your head. Well animal like is the proper therm seeing as your kirin ears are covered with scales.",
		fur: true
	});
	public static const BIG: int = 44;
	EnumValue.add(Types, BIG, "BIG", {
		name: "big",
		appearanceDesc: "Your oversized ears almost look comical on your head. They are long and very mobile and tend to move up and down, flapping around when you have a burst of emotion or when you deliver a vengeful spell at the reaction of them being mocked."
	});
	
	public static const HoleEars:/*String*/Array = [LIZARD, DRAGON, ORCA2, AVIAN, INSECT];
	
	public function Ears(creature:Creature) {
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
		const id: int = creature.ears.type;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
