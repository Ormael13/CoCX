/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class LowerBody extends SaveableBodyPart {
	public var legCount:int = 2;
	
	public static const HUMAN:int                 = 0;
	public static const HOOFED:int                = 1;
	public static const DOG:int                   = 2;
	public static const NAGA:int                  = 3;
	public static const CENTAUR:int               = 4;//[Deprecated] use HOOFED and legCount = 4
	public static const DEMONIC_HIGH_HEELS:int    = 5;
	public static const DEMONIC_CLAWS:int         = 6;
	public static const BEE:int                   = 7;
	public static const GOO:int                   = 8;
	public static const CAT:int                   = 9;
	public static const LIZARD:int                = 10;
	public static const PONY:int                  = 11;
	public static const BUNNY:int                 = 12;
	public static const HARPY:int                 = 13;
	public static const KANGAROO:int              = 14;
	public static const CHITINOUS_SPIDER_LEGS:int = 15;
	public static const DRIDER:int                = 16;
	public static const FOX:int                   = 17;
	public static const DRAGON:int                = 18;
	public static const RACCOON:int               = 19;
	public static const FERRET:int                = 20;
	public static const CLOVEN_HOOFED:int         = 21;
	public static const ECHIDNA:int               = 23;
	public static const DEERTAUR:int              = 24;//[Deprecated] use CLOVEN_HOOFED and legCount = 4
	public static const SALAMANDER:int            = 25;
	public static const SCYLLA:int                = 26;
	public static const MANTIS:int                = 27;
	public static const SHARK:int                 = 29;
	public static const GARGOYLE:int              = 30;
	public static const PLANT_HIGH_HEELS:int      = 31;
	public static const PLANT_ROOT_CLAWS:int      = 32;
	public static const WOLF:int                  = 33;
	public static const PLANT_FLOWER:int          = 34;
	public static const LION:int                  = 35;
	public static const YETI:int                  = 36;
	public static const ORCA:int                  = 37;
	public static const YGG_ROOT_CLAWS:int        = 38;
	public static const ONI:int                   = 39;
	public static const ELF:int                   = 40;
	public static const RAIJU:int                 = 41;
	public static const RED_PANDA:int             = 42;
	public static const GARGOYLE_2:int            = 43;
	public static const AVIAN:int            	  = 44;
	public static const GRYPHON:int            	  = 45;
	
	override public function set type(value:int):void {
		super.type = value;
		// Reset leg count
		switch (value) {
			case GOO:
			case NAGA:
				legCount = 1;
				break;
			case BEE:
			case BUNNY:
			case CAT:
			case CHITINOUS_SPIDER_LEGS:
			case DEMONIC_CLAWS:
			case DEMONIC_HIGH_HEELS:
			case DOG:
			case DRAGON:
			case ECHIDNA:
			case FERRET:
			case FOX:
			case HARPY:
			case HUMAN:
			case KANGAROO:
			case LIZARD:
			case RACCOON:
			case RED_PANDA:
			case SALAMANDER:
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
		return (type == DRIDER);
	}
	public function isGoo():Boolean {
		return type == GOO;
	}
	public function isBiped():Boolean {
		return legCount == 2;
	}
	public function isNaga():Boolean {
		return type == NAGA;
	}

	public function isTaur():Boolean {
		// driders have genitals on their human part, inlike usual taurs... this is actually bad way to check, but too many places to fix just now
		return legCount == 4 && type != PLANT_FLOWER;
	}
	public function isScylla():Boolean {
		return type == SCYLLA;
	}
	public function isAlraune():Boolean {
		return type == PLANT_FLOWER;
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
