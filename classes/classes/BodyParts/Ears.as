package classes.BodyParts {
import classes.internals.EnumValue;

public class Ears extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 10)
	 * - id: name of the constant ("HUMAN", "HORSE")
	 * - name: human-readable name, ("human", "horse")
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const HUMAN:int     = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {name: "human"});
	public static const HORSE:int     = 1;
	EnumValue.add(Types, HORSE, "HORSE", {name: "horse"});
	public static const DOG:int       = 2;
	EnumValue.add(Types, DOG, "DOG", {name: "dog"});
	public static const COW:int       = 3;
	EnumValue.add(Types, COW, "COW", {name: "cow"});
	public static const ELFIN:int     = 4;
	EnumValue.add(Types, ELFIN, "ELFIN", {name: "elfin"});
	public static const CAT:int       = 5;
	EnumValue.add(Types, CAT, "CAT", {name: "cat"});
	public static const LIZARD:int    = 6;
	EnumValue.add(Types, LIZARD, "LIZARD", {name: "lizard"});
	public static const BUNNY:int     = 7;
	EnumValue.add(Types, BUNNY, "BUNNY", {name: "bunny"});
	public static const KANGAROO:int  = 8;
	EnumValue.add(Types, KANGAROO, "KANGAROO", {name: "kangaroo"});
	public static const FOX:int       = 9;
	EnumValue.add(Types, FOX, "FOX", {name: "fox"});
	public static const DRAGON:int    = 10;
	EnumValue.add(Types, DRAGON, "DRAGON", {name: "dragon"});
	public static const RACCOON:int   = 11;
	EnumValue.add(Types, RACCOON, "RACCOON", {name: "raccoon"});
	public static const MOUSE:int     = 12;
	EnumValue.add(Types, MOUSE, "MOUSE", {name: "mouse"});
	public static const FERRET:int    = 13;
	EnumValue.add(Types, FERRET, "FERRET", {name: "ferret"});
	public static const PIG:int       = 14;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, PIG, "PIG", {name: "pig"});
	public static const RHINO:int     = 15;
	EnumValue.add(Types, RHINO, "RHINO", {name: "rhino"});
	public static const ECHIDNA:int   = 16;
	EnumValue.add(Types, ECHIDNA, "ECHIDNA", {name: "echidna"});
	public static const DEER:int      = 17;
	EnumValue.add(Types, DEER, "DEER", {name: "deer"});
	public static const WOLF:int      = 18;
	EnumValue.add(Types, WOLF, "WOLF", {name: "wolf"});
	public static const LION:int      = 19;
	EnumValue.add(Types, LION, "LION", {name: "lion"});
	public static const YETI:int      = 20;
	EnumValue.add(Types, YETI, "YETI", {name: "yeti"});
	public static const ORCA:int      = 21;
	EnumValue.add(Types, ORCA, "ORCA", {name: "orca"});
	public static const ORCA2:int     = 22;
	EnumValue.add(Types, ORCA2, "ORCA2", {name: "orca"});
	public static const SNAKE:int     = 23;
	EnumValue.add(Types, SNAKE, "SNAKE", {name: "snake"});
	public static const GOAT:int      = 24;
	EnumValue.add(Types, GOAT, "GOAT", {name: "goat"});
	public static const ONI:int       = 25;
	EnumValue.add(Types, ONI, "ONI", {name: "oni"});
	public static const ELVEN:int     = 26;
	EnumValue.add(Types, ELVEN, "ELVEN", {name: "elven"});
	public static const RAIJU:int     = 27;
	EnumValue.add(Types, RAIJU, "RAIJU", {name: "raiju"});
	public static const BAT:int       = 28;
	EnumValue.add(Types, BAT, "BAT", {name: "bat"});
	public static const VAMPIRE:int   = 29;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, VAMPIRE, "VAMPIRE", {name: "vampire"});
	public static const RED_PANDA:int = 30;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {name: "red-panda"});
	public static const AVIAN:int	  = 31;
	EnumValue.add(Types, AVIAN, "AVIAN", {name: "avian"});
	public static const GRYPHON:int	  = 32;
	EnumValue.add(Types, GRYPHON, "GRYPHON", {name: "gryphon"});
	public static const CAVE_WYRM:int = 33;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {name: "cave wyrm"});
	public static const BEAR:int	  = 34;
	EnumValue.add(Types, BEAR, "BEAR", {name: "bear"});
	public static const PANDA:int	  = 35;
	EnumValue.add(Types, PANDA, "PANDA", {name: "panda"});
	public static const SHARK:int     = 36;
	EnumValue.add(Types, SHARK, "SHARK", {name: "shark"});
	public static const DISPLACER:int = 37;
	EnumValue.add(Types, DISPLACER, "DISPLACER", {name: "displacer"});
	public static const MELKIE:int 	  = 38;
	EnumValue.add(Types, MELKIE, "MELKIE", {name: "melkie"});
	public static const GREMLIN:int   = 39;
	EnumValue.add(Types, GREMLIN, "GREMLIN", {name: "gremlin"});
	public static const WEASEL:int    = 40;
	EnumValue.add(Types, WEASEL, "WEASEL", {name: "weasel"});
	public static const SQUIRREL:int  = 41;
	EnumValue.add(Types, SQUIRREL, "SQUIRREL", {name: "squirrel"});

	public function Ears() {
		super(null, null);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
