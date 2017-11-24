/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.AppearanceDefs;
import classes.Creature;

public class LowerBody extends SaveableBodyPart {
	public var legCount:int = 2;

	override public function set type(value:int):void {
		super.type = value;
		// Reset leg count
		switch (value) {
			case AppearanceDefs.LOWER_BODY_TYPE_GOO:
			case AppearanceDefs.LOWER_BODY_TYPE_NAGA:
				legCount = 1;
				break;
			case AppearanceDefs.LOWER_BODY_TYPE_BEE:
			case AppearanceDefs.LOWER_BODY_TYPE_BUNNY:
			case AppearanceDefs.LOWER_BODY_TYPE_CAT:
			case AppearanceDefs.LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS:
			case AppearanceDefs.LOWER_BODY_TYPE_DEMONIC_CLAWS:
			case AppearanceDefs.LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS:
			case AppearanceDefs.LOWER_BODY_TYPE_DOG:
			case AppearanceDefs.LOWER_BODY_TYPE_DRAGON:
			case AppearanceDefs.LOWER_BODY_TYPE_ECHIDNA:
			case AppearanceDefs.LOWER_BODY_TYPE_FERRET:
			case AppearanceDefs.LOWER_BODY_TYPE_FOX:
			case AppearanceDefs.LOWER_BODY_TYPE_HARPY:
			case AppearanceDefs.LOWER_BODY_TYPE_HUMAN:
			case AppearanceDefs.LOWER_BODY_TYPE_KANGAROO:
			case AppearanceDefs.LOWER_BODY_TYPE_LIZARD:
			case AppearanceDefs.LOWER_BODY_TYPE_RACCOON:
			case AppearanceDefs.LOWER_BODY_TYPE_SALAMANDER:
				legCount = 2;
				break;
			case AppearanceDefs.LOWER_BODY_TYPE_CLOVEN_HOOFED:
			case AppearanceDefs.LOWER_BODY_TYPE_HOOFED:
				if (legCount != 4) legCount = 2;
				break;
			case AppearanceDefs.LOWER_BODY_TYPE_PONY:
				legCount = 4;
				break;
			case AppearanceDefs.LOWER_BODY_TYPE_CENTAUR: // deprecated value
				legCount = 4;
				type     = AppearanceDefs.LOWER_BODY_TYPE_HOOFED;
				break;
			case AppearanceDefs.LOWER_BODY_TYPE_DEERTAUR:
				legCount = 4;
				type     = AppearanceDefs.LOWER_BODY_TYPE_CLOVEN_HOOFED;
				break;
			case AppearanceDefs.LOWER_BODY_TYPE_DRIDER_LOWER_BODY:
				legCount = 8;
				break;
			case AppearanceDefs.LOWER_BODY_TYPE_PLANT_FLOWER:
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
	public function leg():String {
		var select:Number = 0;
		//type:
		//0 - normal
		if (type == 0)
			return "leg";
		//1 - hooves
		if (type == 1)
			return "leg";
		//2 - paws
		if (type == 2)
			return "leg";
		//3 - snakelike body
		if (type == 3)
			return "snake-tail";
		//4 - centaur!
		if (type == 4)
			return "equine leg";
		//8 - goo shit
		if (type == 8)
			return "mound of goo";
		//PONY
		if (type == 11)
			return "cartoonish pony-leg";
		//BUNNAH
		if (type == 12) {
			select = Math.random() * (5);
			if (select == 0)
				return "fuzzy, bunny leg";
			else if (select == 1)
				return "fur-covered leg";
			else if (select == 2)
				return "furry leg";
			else
				return "leg";
		}
		if (type == 13) {
			select = Math.floor(Math.random() * (5));
			if (select == 0)
				return "bird-like leg";
			else if (select == 1)
				return "feathered leg";
			else
				return "leg";
		}
		if (type == 17) {
			select = Math.floor(Math.random() * (4));
			if (select == 0)
				return "fox-like leg";
			else if (select == 1)
				return "leg";
			else if (select == 2)
				return "leg";
			else
				return "vulpine leg";
		}
		if (type == 19) {
			select = Math.floor(Math.random() * (4));
			if (select == 0)
				return "raccoon-like leg";
			else
				return "leg";
		}
		return "leg";
	}

	public function feet():String {
		var select:Number = 0;
		//type:
		//0 - normal
		if (type == 0)
			return "feet";
		//1 - hooves
		if (type == 1)
			return "hooves";
		//2 - paws
		if (type == 2)
			return "paws";
		//3 - snakelike body
		if (type == 3)
			return "coils";
		//4 - centaur!
		if (type == 4)
			return "hooves";
		//5 - demonic heels
		if (type == 5)
			return "demonic high-heels";
		//6 - demonic claws
		if (type == 6)
			return "demonic foot-claws";
		//8 - goo shit
		if (type == 8)
			return "slimey cillia";
		if (type == 11)
			return "flat pony-feet";
		//BUNNAH
		if (type == 12) {
			select = rand(5);
			if (select == 0)
				return "large bunny feet";
			else if (select == 1)
				return "rabbit feet";
			else if (select == 2)
				return "large feet";
			else
				return "feet";
		}
		if (type == 13) {
			select = Math.floor(Math.random() * (5));
			if (select == 0)
				return "taloned feet";
			else
				return "feet";
		}
		if (type == 14)
			return "foot-paws";
		if (type == 17) {
			select = rand(4);
			if (select == 0)
				return "paws";
			else if (select == 1)
				return "soft, padded paws";
			else if (select == 2)
				return "fox-like feet";
			else
				return "paws";
		}
		if (type == 19) {
			select = Math.floor(Math.random() * (3));
			if (select == 0)
				return "raccoon-like feet";
			else if (select == 1)
				return "long-toed paws";
			else if (select == 2)
				return "feet";
			else
				return "paws";
		}
		return "feet";
	}

	public function foot():String {
		var select:Number = 0;
		//type:
		//0 - normal
		if (type == 0)
			return "foot";
		//1 - hooves
		if (type == 1)
			return "hoof";
		//2 - paws
		if (type == 2)
			return "paw";
		//3 - snakelike body
		if (type == 3)
			return "coiled tail";
		//4 - centaur!
		if (type == 4)
			return "hoof";
		//8 - goo shit
		if (type == 8)
			return "slimey undercarriage";
		//PONY
		if (type == 11)
			return "flat pony-foot";
		//BUNNAH
		if (type == 12) {
			select = Math.random() * (5);
			if (select == 0)
				return "large bunny foot";
			else if (select == 1)
				return "rabbit foot";
			else if (select == 2)
				return "large foot";
			else
				return "foot";
		}
		if (type == 13) {
			select = Math.floor(Math.random() * (5));
			if (select == 0)
				return "taloned foot";
			else
				return "foot";
		}
		if (type == 17) {
			select = Math.floor(Math.random() * (4));
			if (select == 0)
				return "paw";
			else if (select == 1)
				return "soft, padded paw";
			else if (select == 2)
				return "fox-like foot";
			else
				return "paw";
		}
		if (type == 14)
			return "foot-paw";
		if (type == 19) {
			select = Math.floor(Math.random() * (3));
			if (select == 0)
				return "raccoon-like foot";
			else if (select == 1)
				return "long-toed paw";
			else if (select == 2)
				return "foot";
			else
				return "paw";
		}
		return "foot";
	}
	public function isDrider():Boolean {
		return (type == AppearanceDefs.LOWER_BODY_TYPE_DRIDER_LOWER_BODY);
	}
	public function isGoo():Boolean {
		return type == AppearanceDefs.LOWER_BODY_TYPE_GOO;
	}
	public function isBiped():Boolean {
		return legCount == 2;
	}
	public function isNaga():Boolean {
		return type == AppearanceDefs.LOWER_BODY_TYPE_NAGA;
	}

	public function isTaur():Boolean {
		// driders have genitals on their human part, inlike usual taurs... this is actually bad way to check, but too many places to fix just now
		return legCount == 4 && type != AppearanceDefs.LOWER_BODY_TYPE_PLANT_FLOWER;
	}
	public function isScylla():Boolean {
		return type == AppearanceDefs.LOWER_BODY_TYPE_SCYLLA;
	}
	public function isAlraune():Boolean {
		return type == AppearanceDefs.LOWER_BODY_TYPE_PLANT_FLOWER;
	}
	public function legs():String {
		var select:Number = 0;
		//lowerBody:
		//4 legs - centaur!
		if (isDrider())
			return num2Text(legCount) + " spider legs";
		if (isTaur())
			return num2Text(legCount) + " legs";
		if (isAlraune())
			return num2Text(legCount) + " vine-like tentacle stamens";

		switch (type) {
			case AppearanceDefs.LOWER_BODY_TYPE_HUMAN:
				return "legs";
			case AppearanceDefs.LOWER_BODY_TYPE_HOOFED:
				return "legs";
			case AppearanceDefs.LOWER_BODY_TYPE_DOG:
				return "legs";
			case AppearanceDefs.LOWER_BODY_TYPE_NAGA:
				return "snake-like coils";
			case AppearanceDefs.LOWER_BODY_TYPE_GOO:
				return "mounds of goo";
			case AppearanceDefs.LOWER_BODY_TYPE_PONY:
				return "cute pony-legs";
			case AppearanceDefs.LOWER_BODY_TYPE_BUNNY: {
				select = Math.floor(Math.random() * (5));
				if (select == 0)
					return "fuzzy, bunny legs";
				else if (select == 1)
					return "fur-covered legs";
				else if (select == 2)
					return "furry legs";
				else
					return "legs";
			}
			case AppearanceDefs.LOWER_BODY_TYPE_HARPY: {
				select = Math.floor(Math.random() * (5));
				if (select == 0)
					return "bird-like legs";
				else if (select == 1)
					return "feathered legs";
				else
					return "legs";
			}
			case AppearanceDefs.LOWER_BODY_TYPE_FOX: {
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "fox-like legs";
				else if (select == 1)
					return "legs";
				else if (select == 2)
					return "legs";
				else
					return "vulpine legs";
			}
			case AppearanceDefs.LOWER_BODY_TYPE_RACCOON: {
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "raccoon-like legs";
				else
					return "legs";
			}
			case AppearanceDefs.LOWER_BODY_TYPE_CLOVEN_HOOFED: {
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "pig-like legs";
				else if (select == 1)
					return "legs";
				else if (select == 2)
					return "legs";
				else
					return "swine legs";
			}
			default:
				return "legs";
		}
	}
	override protected function loadFromOldSave(savedata:Object):void {
		type = intOr(savedata.lowerBody,AppearanceDefs.LOWER_BODY_TYPE_HUMAN);
		if (type === AppearanceDefs.LOWER_BODY_TYPE_CENTAUR) {
			type = AppearanceDefs.LOWER_BODY_TYPE_HOOFED;
		} else if (type === AppearanceDefs.LOWER_BODY_TYPE_DEERTAUR) {
			type = AppearanceDefs.LOWER_BODY_TYPE_CLOVEN_HOOFED;
		}
		legCount = intOr(savedata.legCount,2);
	}

	override protected function saveToOldSave(savedata:Object):void {
		savedata.lowerBody = type;
		savedata.legCount = legCount;
	}
}
}
