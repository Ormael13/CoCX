package classes {
import classes.BodyParts.*;
import classes.internals.EnumValue;
import classes.internals.Utils;
import classes.lists.Gender;

/**
 * This class is an aggregate of most important player body properties, packed into an array.
 */
public class BodyData {
	/**
	 * Entry properties:
	 * - value: numerical id
	 * - id: name of the constant ("FACE_TYPE")
	 * - name: human-readable name ("face")
	 *
	 * - nameFn (optional): function(value:*):String converting values stored in this slot to readable name
	 */
	public static const Slots:/*EnumValue*/Array = [];
	
	// Numbers are never saved, so can be changed between game versions without any problems.
	// As long as they are proper 0..N sequence
	
	private static var _slotid:int = 0;
	// Basic body parts
	public static const SLOT_ANTENNAE_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_ANTENNAE_TYPE, "ANTENNAE_TYPE", {
		name:"antennae",
		nameFn: function(value:int):String {
			if (value == Antennae.NONE) return "no";
			return Antennae.Types[value].name;
		}
	});
	public function get antennaeType():int {
		return data[SLOT_ANTENNAE_TYPE];
	}
	public static const SLOT_ARM_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_ARM_TYPE, "ARM_TYPE", {
		name:"arms",
		nameFn: function(value:int):String {
			return Arms.Types[value].name;
		}
	});
	public function get armType():int {
		return data[SLOT_ARM_TYPE];
	}
	public static const SLOT_EAR_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_EAR_TYPE, "EAR_TYPE", {
		name:"ears",
		nameFn: function(value:int):String {
			return Ears.Types[value].name;
		}
	});
	public function get earType():int {
		return data[SLOT_EAR_TYPE];
	}
	public static const SLOT_EYE_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_EYE_TYPE, "EYE_TYPE", {
		name:"eyes",
		nameFn: function(value:int):String {
			return Eyes.Types[value].name;
		}
	});
	public function get eyeType():int {
		return data[SLOT_EYE_TYPE];
	}
	public static const SLOT_EYE_COLOR:int = _slotid++;
	EnumValue.add(Slots,SLOT_EYE_COLOR, "EYE_COLOR", {
		name:"eye color"
	});
	public function get eyeColor():int {
		return data[SLOT_EYE_COLOR];
	}
	
	public static const SLOT_FACE_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_FACE_TYPE, "FACE_TYPE", {
		name:"face",
		nameFn: function(value:int):String {
			return Face.Types[value].name;
		}
	});
	public function get faceType():int {
		return data[SLOT_FACE_TYPE];
	}
	
	public static const SLOT_GILLS_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_GILLS_TYPE, "GILL_TYPE", {
		name:"gills",
		nameFn: function(value:int):String {
			if (value == Gills.NONE) return "no";
			return Gills.Types[value].name;
		}
	});
	public function get gillsType():int {
		return data[SLOT_GILLS_TYPE];
	}
	
	public static const SLOT_HAIR_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_HAIR_TYPE, "HAIR_TYPE", {
		name:"hair",
		nameFn: function(value:int):String {
			return Hair.Types[value].name;
		}
	});
	public function get hairType():int {
		return data[SLOT_HAIR_TYPE];
	}
	public static const SLOT_HAIR_COLOR:int = _slotid++;
	EnumValue.add(Slots,SLOT_HAIR_COLOR, "HAIR_COLOR", {
		name:"hair color"
	});
	public function get hairColor():int {
		return data[SLOT_HAIR_COLOR];
	}
	
	public static const SLOT_HORN_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_HORN_TYPE, "HORN_TYPE", {
		name:"horns",
		nameFn: function(value:int):String {
			return Horns.Types[value].name;
		}
	});
	public function get hornType():int {
		return data[SLOT_HORN_TYPE];
	}
	
	public static const SLOT_LEG_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_LEG_TYPE, "LEG_TYPE", {
		name:"legs",
		nameFn: function(value:int):String {
			return LowerBody.Types[value].name;
		}
	});
	public function get legType():int {
		return data[SLOT_LEG_TYPE];
	}
	
	public static const SLOT_REAR_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_REAR_TYPE, "REAR_TYPE", {
		name:"rear",
		nameFn: function(value:int):String {
			if (value == RearBody.NONE) return "ordinary";
			return RearBody.Types[value].name;
		}
	});
	public function get rearType():int {
		return data[SLOT_REAR_TYPE];
	}
	
	public static const SLOT_SKIN_COVERAGE:int = _slotid++;
	
	EnumValue.add(Slots,SLOT_SKIN_COVERAGE, "SKIN_BASE_TYPE", {
		name:"covered skin",
		nameFn: function(value:int):String {
			return Skin.CoverageTypes[value].name;
		}
	});
	public function get skinCoverage():int {
		return data[SLOT_SKIN_COVERAGE];
	}
	
	public static const SLOT_SKIN_BASE_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_BASE_TYPE, "SKIN_BASE_TYPE", {
		name:"skin",
		nameFn: function(value:int):String {
			if (value === Skin.PLAIN) return "plain";
			return Skin.SkinTypes[value].name;
		}
	});
	public function get skinBaseType():int {
		return data[SLOT_SKIN_BASE_TYPE];
	}
	public static const SLOT_SKIN_BASE_COLOR:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_BASE_COLOR, "SKIN_BASE_COLOR", {
		name:"skin color"
	});
	public function get skinBaseColor():int {
		return data[SLOT_SKIN_BASE_COLOR];
	}
	
	public static const SLOT_SKIN_BASE_PATTERN:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_BASE_PATTERN, "SKIN_BASE_PATTERN", {
		name:"skin pattern",
		nameFn: function(value:int):String {
			if (value === Skin.PATTERN_NONE) return "no";
			return Skin.PatternTypes[value].name;
		}
	});
	public function get skinBasePattern():int {
		return data[SLOT_SKIN_BASE_PATTERN];
	}
	
	public static const SLOT_SKIN_BASE_ADJ:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_BASE_ADJ, "SKIN_BASE_ADJ", {
		name:"skin"
	});
	public function get skinBaseAdj():int {
		return data[SLOT_SKIN_BASE_ADJ];
	}
	
	public static const SLOT_SKIN_COAT_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_COAT_TYPE, "SKIN_COAT_TYPE", {
		name:"coat",
		nameFn: function(value:int):String {
			return Skin.SkinTypes[value].name;
		}
	});
	public function get skinCoatType():int {
		return data[SLOT_SKIN_COAT_TYPE];
	}
	
	public static const SLOT_SKIN_COAT_COLOR:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_COAT_COLOR, "SKIN_COAT_COLOR", {
		name:"coat color"
	});
	public function get skinCoatColor():int {
		return data[SLOT_SKIN_COAT_COLOR];
	}
	
	public static const SLOT_SKIN_COAT_PATTERN:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_COAT_PATTERN, "SKIN_COAT_PATTERN", {
		name:"coat pattern",
		nameFn: function(value:int):String {
			if (value === Skin.PATTERN_NONE) return "no";
			return Skin.PatternTypes[value].name;
		}
	});
	public function get skinCoatPattern():int {
		return data[SLOT_SKIN_COAT_PATTERN];
	}
	
	public static const SLOT_TAIL_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_TAIL_TYPE, "TAIL_TYPE", {
		name:"tail",
		nameFn: function(value:int):String {
			if (value == Tail.NONE) return "no";
			return Tail.Types[value].name;
		}
	});
	public function get tailType():int {
		return data[SLOT_TAIL_TYPE];
	}
	public static const SLOT_TAIL_COUNT:int = _slotid++;
	EnumValue.add(Slots,SLOT_TAIL_COUNT, "TAIL_COUNT", {
		name:"tail(s)",
		nameFn: function(value:int):String {
			if (value == 0) return "no";
			return Utils.num2Text(value);
		}
	});
	public function get tailCount():int {
		return data[SLOT_TAIL_COUNT];
	}
	
	public static const SLOT_TONGUE_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_TONGUE_TYPE, "TONGUE_TYPE", {
		name:"tongue",
		nameFn: function(value:int):String {
			return Tongue.Types[value].name;
		}
	});
	public function get tongueType():int {
		return data[SLOT_TONGUE_TYPE];
	}
	
	public static const SLOT_WING_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_WING_TYPE, "WING_TYPE", {
		name:"wings",
		nameFn: function(value:int):String {
			if (value == Wings.NONE) return "no";
			return Wings.Types[value].name;
		}
	});
	public function get wingType():int {
		return data[SLOT_WING_TYPE];
	}
	
	// Other stats
	public static const SLOT_GENDER:int = _slotid++;
	EnumValue.add(Slots,SLOT_GENDER, "GENDER", {
		name:"gender",
		nameFn: function(value:int):String {
			switch(value) {
				case Gender.GENDER_NONE: return "genderless";
				case Gender.GENDER_MALE: return "male";
				case Gender.GENDER_FEMALE: return "female";
				case Gender.GENDER_HERM: return "hermaphrodite";
			}
			return ""+value;
		}
	});
	public function get gender():int {
		return data[SLOT_GENDER];
	}
	
	public static const SLOT_HEIGHT:int = _slotid++;
	EnumValue.add(Slots,SLOT_HEIGHT, "HEIGHT", {
		name: "height",
		nameFn: function (value:Number):String {
			return Measurements.footInchOrMetres(value);
		}
	});
	public function get height():int {
		return data[SLOT_HEIGHT];
	}
	
	public var player:Player;
	public var data:Array = [];
	
	public function get isTaur():Boolean {
		return player.isTaur();
	}
	public function get looksMale():Boolean {
		return player.looksMale();
	}
	public function get looksFemale():Boolean {
		return player.looksFemale();
	}
	public function mf(male:String, female:String):String {
		return looksMale ? male : female;
	}
	public function get hasCoat():Boolean {
		return skinCoverage > Skin.COVERAGE_NONE;
	}
	
	public function BodyData(player:Player, update:Boolean = true) {
		this.player = player;
		if (update) {
			this.update();
		}
	}
	
	public function update():void {
		var player:Player = this.player;
		//noinspection JSMismatchedCollectionQueryUpdate
		var data:Array = this.data;
		
		data[SLOT_ANTENNAE_TYPE] = player.antennae.type;
		data[SLOT_ARM_TYPE] = player.arms.type;
		data[SLOT_EAR_TYPE] = player.ears.type;
		data[SLOT_EYE_TYPE] = player.eyes.type;
		data[SLOT_EYE_COLOR] = player.eyes.colour;
		data[SLOT_FACE_TYPE] = player.facePart.type;
		data[SLOT_GILLS_TYPE] = player.gills.type;
		data[SLOT_HAIR_TYPE] = player.hairType;
		data[SLOT_HAIR_COLOR] = player.hairColor;
		data[SLOT_HORN_TYPE] = player.horns.type;
		data[SLOT_LEG_TYPE] = player.lowerBodyPart.type;
		data[SLOT_REAR_TYPE] = player.rearBody.type;
		data[SLOT_SKIN_COVERAGE] = player.skin.coverage;
		data[SLOT_SKIN_BASE_TYPE] = player.skin.base.type;
		data[SLOT_SKIN_BASE_COLOR] = player.skin.base.color;
		data[SLOT_SKIN_BASE_PATTERN] = player.skin.base.pattern;
		data[SLOT_SKIN_BASE_ADJ] = player.skin.base.adj;
		if (player.skin.coverage > Skin.COVERAGE_NONE) {
			data[SLOT_SKIN_COAT_TYPE]  = player.skin.coat.type;
			data[SLOT_SKIN_COAT_COLOR] = player.skin.coat.color;
			data[SLOT_SKIN_COAT_PATTERN] = player.skin.coat.pattern;
		} else {
			data[SLOT_SKIN_COAT_TYPE]  = -1;
			data[SLOT_SKIN_COAT_COLOR] = "no";
			data[SLOT_SKIN_COAT_PATTERN] = Skin.PATTERN_NONE;
		}
		data[SLOT_TAIL_TYPE] = player.tail.type;
		data[SLOT_TAIL_COUNT] = player.tail.count;
		data[SLOT_WING_TYPE] = player.wings.type;
		data[SLOT_GENDER]    = player.gender;
		data[SLOT_HEIGHT]    = player.tallness;
	}
	
	public function equals(other:BodyData):Boolean {
		for (var i:int = 0; i < data.length; i++) {
			if (data[i] !== other.data[i]) return false;
		}
		return true;
	}
	
	public function clone():BodyData {
		var bd: BodyData = new BodyData(player, false);
		bd.data = this.data.slice();
		return bd;
	}
}
}
