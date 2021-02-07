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
	 * - claw:
	 * - tailSlam:
	 * - tentacle:
	 */
	public static var Types:/*EnumValue*/Array = [];

	public var legCount:int = 2;

	public static const HUMAN:int                 = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {name: "human"});
	public static const HOOFED:int                = 1;
	EnumValue.add(Types, HOOFED, "HOOFED", {name: "hoofed"});
	public static const DOG:int                   = 2;
	EnumValue.add(Types, DOG, "DOG", {name: "dog"});
	public static const NAGA:int                  = 3;
	EnumValue.add(Types, NAGA, "NAGA", {name: "naga", tailSlam: true});
	public static const CENTAUR:int               = 4;//[Deprecated] use HOOFED and legCount = 4
	EnumValue.add(Types, CENTAUR, "CENTAUR", {name: "centaur", centaur: true});
	public static const DEMONIC_HIGH_HEELS:int    = 5;
	EnumValue.add(Types, DEMONIC_HIGH_HEELS, "DEMONIC_HIGH_HEELS", {name: "demonic high-heels"});
	public static const DEMONIC_CLAWS:int         = 6;
	EnumValue.add(Types, DEMONIC_CLAWS, "DEMONIC_CLAWS", {name: "demonic claws"});
	public static const BEE:int                   = 7;
	EnumValue.add(Types, BEE, "BEE", {name: "bee"});
	public static const GOO:int                   = 8;
	EnumValue.add(Types, GOO, "GOO", {name: "goo"});
	public static const CAT:int                   = 9;
	EnumValue.add(Types, CAT, "CAT", {name: "cat",canPounce: true});
	public static const LIZARD:int                = 10;
	EnumValue.add(Types, LIZARD, "LIZARD", {name: "lizard"});
	public static const PONY:int                  = 11;
	EnumValue.add(Types, PONY, "PONY", {name: "pony"});
	public static const BUNNY:int                 = 12;
	EnumValue.add(Types, BUNNY, "BUNNY", {name: "bunny"});
	public static const HARPY:int                 = 13;
	EnumValue.add(Types, HARPY, "HARPY", {name: "harpy"});
	public static const KANGAROO:int              = 14;
	EnumValue.add(Types, KANGAROO, "KANGAROO", {name: "kangaroo"});
	public static const CHITINOUS_SPIDER_LEGS:int = 15;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, CHITINOUS_SPIDER_LEGS, "CHITINOUS_SPIDER_LEGS", {name: "chitinous spider legs"});
	public static const DRIDER:int                = 16;
	EnumValue.add(Types, DRIDER, "DRIDER", {name: "drider"});
	public static const FOX:int                   = 17;
	EnumValue.add(Types, FOX, "FOX", {name: "fox"});
	public static const DRAGON:int                = 18;
	EnumValue.add(Types, DRAGON, "DRAGON", {name: "dragon"});
	public static const RACCOON:int               = 19;
	EnumValue.add(Types, RACCOON, "RACCOON", {name: "raccoon"});
	public static const FERRET:int                = 20;
	EnumValue.add(Types, FERRET, "FERRET", {name: "ferret"});
	public static const CLOVEN_HOOFED:int         = 21;
	EnumValue.add(Types, CLOVEN_HOOFED, "CLOVEN_HOOFED", {name: "cloven-hoofed"});
	//public static const :int         = 22;not used anywhere legs number likely ^^
	public static const ECHIDNA:int               = 23;
	EnumValue.add(Types, ECHIDNA, "ECHIDNA", {name: "echidna"});
	public static const DEERTAUR:int              = 24;//[Deprecated] use CLOVEN_HOOFED and legCount = 4
	EnumValue.add(Types, DEERTAUR, "DEERTAUR", {name: "deertaur"});
	public static const SALAMANDER:int            = 25;
	EnumValue.add(Types, SALAMANDER, "SALAMANDER", {name: "salamander"});
	public static const SCYLLA:int                = 26;
	EnumValue.add(Types, SCYLLA, "SCYLLA", {name: "slippery octopus tentacles", tentacle: true});
	public static const MANTIS:int                = 27;
	EnumValue.add(Types, MANTIS, "MANTIS", {name: "mantis"});
	//public static const :int         = 28;thunder mantis legs
	public static const SHARK:int                 = 29;
	EnumValue.add(Types, SHARK, "SHARK", {name: "shark"});
	public static const GARGOYLE:int              = 30;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, GARGOYLE, "GARGOYLE", {name: "gargoyle"});
	public static const PLANT_HIGH_HEELS:int      = 31;
	EnumValue.add(Types, PLANT_HIGH_HEELS, "PLANT_HIGH_HEELS", {name: "vine-covered"});
	public static const PLANT_ROOT_CLAWS:int      = 32;
	EnumValue.add(Types, PLANT_ROOT_CLAWS, "PLANT_ROOT_CLAWS", {name: "root feet"});
	public static const WOLF:int                  = 33;
	EnumValue.add(Types, WOLF, "WOLF", {name: "wolf",canPounce: true});
	public static const PLANT_FLOWER:int          = 34;
	EnumValue.add(Types, PLANT_FLOWER, "PLANT_FLOWER", {name: "plant flower", tentacle: true});
	public static const LION:int                  = 35;
	EnumValue.add(Types, LION, "LION", {name: "lion",canPounce: true});
	public static const YETI:int                  = 36;
	EnumValue.add(Types, YETI, "YETI", {name: "yeti"});
	public static const ORCA:int                  = 37;
	EnumValue.add(Types, ORCA, "ORCA", {name: "orca"});
	public static const YGG_ROOT_CLAWS:int        = 38;
	EnumValue.add(Types, YGG_ROOT_CLAWS, "YGG_ROOT_CLAWS", {name: "root feet"});
	public static const ONI:int                   = 39;
	EnumValue.add(Types, ONI, "ONI", {name: "oni"});
	public static const ELF:int                   = 40;
	EnumValue.add(Types, ELF, "ELF", {name: "elf"});
	public static const RAIJU:int                 = 41;
	EnumValue.add(Types, RAIJU, "RAIJU", {name: "raiju"});
	public static const RED_PANDA:int             = 42;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {name: "red panda"});
	public static const GARGOYLE_2:int            = 43;
	EnumValue.add(Types, GARGOYLE_2, "GARGOYLE_2", {name: "gargoyle"});
	public static const AVIAN:int            	  = 44;//button 0 on 4th page of metamorph
	EnumValue.add(Types, AVIAN, "AVIAN", {name: "avian"});
	public static const GRYPHON:int            	  = 45;
	EnumValue.add(Types, GRYPHON, "GRYPHON", {name: "gryphon"});
	public static const ORC:int	            	  = 46;
	EnumValue.add(Types, ORC, "ORC", {name: "orc"});
	public static const CAVE_WYRM:int	          = 47;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {name: "cave wyrm"});
	public static const MOUSE:int	          	  = 48;
	EnumValue.add(Types, MOUSE, "MOUSE", {name: "mouse"});
	public static const HINEZUMI:int	          = 49;
	EnumValue.add(Types, HINEZUMI, "HINEZUMI", {name: "hinezumi"});
	public static const BEAR:int		          = 50;
	EnumValue.add(Types, BEAR, "BEAR", {name: "bear"});
	public static const HYDRA:int		          = 51;
	EnumValue.add(Types, HYDRA, "HYDRA", {name: "hydra", bite: true});
	public static const FIRE_SNAIL:int		      = 52;
	EnumValue.add(Types, FIRE_SNAIL, "FIRE_SNAIL", {name: "fire snail"});
	public static const GHOST:int			      = 53;
	EnumValue.add(Types, GHOST, "GHOST", {name: "phantom"});
	public static const GHOST_2:int			      = 54;
	EnumValue.add(Types, GHOST_2, "GHOST_2", {name: "poltergeist"});
	public static const JIANGSHI:int			  = 55;
	EnumValue.add(Types, JIANGSHI, "JIANGSHI", {name: "jiangshi"});
	public static const YUKI_ONNA:int			  = 56;//button 0 on 5th page of metamorph
	EnumValue.add(Types, YUKI_ONNA, "YUKI_ONNA", {name: "yuki onna"});
	public static const MELKIE:int			  	  = 57;
	EnumValue.add(Types, MELKIE, "MELKIE", {name: "melkie", tailSlam: true});
	public static const CENTIPEDE:int			  = 58;
	EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {name: "centipede"});
	public static const KRAKEN:int                = 59;
	EnumValue.add(Types, KRAKEN, "KRAKEN", {name: "kraken", tentacle: true});
	public static const CRAB:int                  = 60;
	EnumValue.add(Types, CRAB, "CRAB", {name: "crab"});
	public static const CANCER:int                = 61;
	EnumValue.add(Types, CANCER, "CANCER", {name: "cancer", claw: true});
	public static const FROSTWYRM:int             = 62;
	EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {name: "frost wyrm", tailSlam: true});
	public static const USHI_ONI_ONNA:int         = 63;
	EnumValue.add(Types, USHI_ONI_ONNA, "USHI_ONI_ONNA", {name: "ushi-oni"});
	public static const FLOWER_LILIRAUNE:int	  = 64;
	EnumValue.add(Types, FLOWER_LILIRAUNE, "FLOWER_LILIRAUNE", {name: "liliraune flower", tentacle: true});
	public static const WEASEL:int                = 65;
	EnumValue.add(Types, WEASEL, "WEASEL", {name: "weasel"});
	public static const GAZER:int                 = 66;
	EnumValue.add(Types, GAZER, "GAZER", {name: "gazer"});
	public static const SQUIRREL:int              = 67;
	EnumValue.add(Types, SQUIRREL, "SQUIRREL", {name: "squirrel"});
	public static const WENDIGO:int               = 68;
	EnumValue.add(Types, WENDIGO, "WENDIGO", {name: "wendigo"});

	override public function set type(value:int):void {
		super.type = value;
		// Reset leg count
		switch (value) {
			case GOO:
			case NAGA:
			case HYDRA:
				legCount = 1;
				break;
			case AVIAN:
			case BEE:
			case BUNNY:
			case CAT:
			case CAVE_WYRM:
			case CHITINOUS_SPIDER_LEGS:
			case DEMONIC_CLAWS:
			case DEMONIC_HIGH_HEELS:
			case DOG:
			case DRAGON:
			case ECHIDNA:
			case ELF:
			case FERRET:
			case FOX:
			case GARGOYLE:
			case GARGOYLE_2:
			case GRYPHON:
			case HARPY:
			case HUMAN:
			case KANGAROO:
			case LION:
			case LIZARD:
			case MANTIS:
			case ONI:
			case ORC:
			case ORCA:
			case PLANT_HIGH_HEELS:
			case PLANT_ROOT_CLAWS:
			case RACCOON:
			case RAIJU:
			case RED_PANDA:
			case SALAMANDER:
			case SHARK:
			case WOLF:
			case YETI:
			case YGG_ROOT_CLAWS:
				legCount = 2;
				break;
			case CLOVEN_HOOFED:
			case HOOFED:
				if (legCount != 4) legCount = 2;
				break;
			case PONY:
				legCount = 4;
				break;
			case CENTAUR: // deprecated value
				legCount = 4;
				type     = HOOFED;
				break;
			case DEERTAUR:
				legCount = 4;
				type     = CLOVEN_HOOFED;
				break;
			case DRIDER:
				legCount = 8;
				break;
			case PLANT_FLOWER:
				legCount = 12;
				break;
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
			case DRIDER: return num2Text(legCount) + " spider legs";
			case PLANT_FLOWER: return num2Text(legCount) + " vine-like tentacle stamens";
			case HUMAN: return "legs";
			case HOOFED: return "legs";
			case DOG:  return "legs";
			case NAGA: return "snake-like coils";
			case HYDRA: return "snake-like coils";
			case GOO:  return "mounds of goo";
			case PONY: return "cute pony-legs";
			case BUNNY: {
				switch(Math.floor(Math.random() * (5))) {
					case 0 : return "fuzzy, bunny legs";
					case 1 : return "fur-covered legs";
					case 2 : return "furry legs";
					default: return "legs";
				}
			}
			case HARPY: {
				switch(Math.floor(Math.random() * (5))) {
					case 0 : return "bird-like legs";
					case 1 : return "feathered legs";
					default: return "legs";
				}
			}
			case FOX: {
				switch(Math.floor(Math.random() * (4))) {
					case 0 : return "fox-like legs";
					case 1 : return "legs";
					case 2 : return "legs";
					default: return "vulpine legs";
				}
			}
			case RACCOON: {
				switch(Math.floor(Math.random() * (4))) {
					case 0 : return "raccoon-like legs";
					default: return "legs";
				}
			}
			case CLOVEN_HOOFED: {
				switch(Math.floor(Math.random() * (4))) {
					case 0 : return "pig-like legs";
					case 1 : return "legs";
					case 2 : return "legs";
					default: return "swine legs";
				}
			}
			default:
				return "legs";
		}
	}

	public function leg():String {
		switch(type){
			case HUMAN:
			case HOOFED:
			case DOG:
				return "leg";
			case NAGA:
				return "snake-tail";
			case HYDRA:
				return "hydra-tail";
			case CENTAUR:
				return "equine leg";
			case GOO:
				return "mound of goo";
			case PONY:
				return "cartoonish pony-leg";
			case BUNNY:
				switch(Math.random()*5){
					case 0 : return "fuzzy, bunny leg";
					case 1 : return "fur-covered leg";
					case 2 : return "furry leg";
					default: return "leg";
				}
			case HARPY:
				switch(Math.floor(Math.random() * 5)){
					case 0 : return "bird-like leg";
					case 1 : return "feathered leg";
					default: return "leg";
				}
			case FOX:
				switch(Math.floor(Math.random() * 4)){
					case 0 : return "fox-like leg";
					case 1 : return "vulpine leg";
					default: return "leg";
				}
			case RACCOON:
				switch(Math.floor(Math.random() * 4)){
					case 0 : return "raccoon-like leg";
					default: return "leg";
				}
			default:
				return "leg";
		}
	}

	public function feet():String {
		switch(type){
			case HUMAN: return "feet";
			case HOOFED: return "hooves";
			case DOG: return "paws";
			case NAGA: return "coils";
			case HYDRA: return "coils";
			case CENTAUR: return "hooves";
			case DEMONIC_HIGH_HEELS: return "demonic high-heels";
			case DEMONIC_CLAWS: return "demonic foot-claws";
			case GOO: return "slimey cillia";
			case PONY: return "flat pony-feet";
			case BUNNY: {
				switch(rand(5)){
					case 0 : return "large bunny feet";
					case 1 : return "rabbit feet";
					case 2 : return "large feet";
					default: return "feet";
				}
			}
			case HARPY: {
				switch(Math.floor(Math.random() * 5)){
					case 0 : return "taloned feet";
					default: return "feet";
				}
			}
			case KANGAROO: return "foot-paws";
			case FOX: {
				switch(rand(4)){
					case 0 : return "soft, padded paws";
					case 1 : return "fox-like feet";
					default: return "paws";
				}
			}
			case RACCOON: {
				switch (Math.floor(Math.random() * 3)){
					case 0 : return "raccoon-like feet";
					case 1 : return "long-toed paws";
					case 2 : return "feet";
					default: return "paws";
				}
			}
			default: return "feet";
		}
	}

	public function foot():String {
		switch(type){
			case HUMAN: return "foot";
			case HOOFED: return "hoof";
			case DOG: return "paw";
			case NAGA: return "coiled tail";
			case HYDRA: return "coiled tail";
			case CENTAUR: return "hoof";
			case GOO: return "slimey undercarriage";
			case PONY: return "flat pony-foot";
			case BUNNY: {
				switch(Math.random() * (5)) {
					case 0 : return "large bunny foot";
					case 1 : return "rabbit foot";
					case 2 : return "large foot";
					default: return "foot";
				}
			}
			case HARPY: {
				switch(Math.floor(Math.random() * (5))) {
					case 0 : return "taloned foot";
					default: return "foot";
				}
			}
			case FOX: {
				switch(Math.floor(Math.random() * (4))) {
					case 0 : return "paw";
					case 1 : return "soft, padded paw";
					case 2 : return "fox-like foot";
					default: return "paw";
				}
			}
			case KANGAROO: return "foot-paw";
			case RACCOON: {
				switch(Math.floor(Math.random() * (3))) {
					case 0 : return "raccoon-like foot";
					case 1 : return "long-toed paw";
					case 2 : return "foot";
					default: return "paw";
				}
			}
			default: return "foot";
		}
	}
	public function isDrider():Boolean {
		return (type == DRIDER || type == CANCER || type == USHI_ONI_ONNA);
	}
	public function isGoo():Boolean {
		return type == GOO;
	}
	public function isBiped():Boolean {
		return legCount == 2;
	}
	public function isNaga():Boolean {
		return type == NAGA || type == HYDRA || type == FROSTWYRM;
	}

	public function isTaur():Boolean {
		// driders have genitals on their human part, inlike usual taurs... this is actually bad way to check, but too many places to fix just now
		return legCount == 4 && type != PLANT_FLOWER;
	}
	public function isScylla():Boolean {
		return type == SCYLLA;
	}
	public function isKraken():Boolean {
		return type == KRAKEN;
	}
	public function isAlraune():Boolean {
		return type == PLANT_FLOWER || type == FLOWER_LILIRAUNE;
	}
	public function isLiliraune():Boolean {
		return type == FLOWER_LILIRAUNE;
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
}
}
