package classes {
import classes.BodyParts.*;
import classes.internals.EnumValue;
import classes.internals.Utils;
import classes.internals.race.RaceUtils;
import classes.lists.BreastCup;
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
	 * - suffix: suffix appended to phrase about this type
	 *
	 * - nameFn (optional): `function(value:*):String` converting values stored in this slot to readable name (minus name of the entry itself)
	 * - phraseFn (optional): `function(operator:String value:*):String` to create text definition of a requirement phrase
	 *
	 * phraseFn semantics
	 * ==================
	 *
	 * Equality (x == value)
	 * - call: phraseFn("eq", value).
	 * - default: nameFn(value) + " " + slot.suffix
	 * - example (face): phraseFn("eq", Face.HUMAN), default is "human face"
	 *
	 * Inequality (x != value)
	 * - call: phraseFn("ne", value)
	 * - default: "not " + nameFn(value) + " " + slot.suffix
	 * - example (face): phraseFn("eq", Face.HUMAN), default is "not human face"
	 *
	 * Other comparison operators: > "gt", < "lt", >= "ge", <= "le"
	 * - call: phraseFn("gt"|"lt"|"ge"|"le", value)
	 * - default: "more than/less than/at least/at most" + nameFn(value) + " " + slot.suffix
	 * - example (tail count): phraseFn("ge", 2), default "at least 2 tail(s)"
	 *
	 * Inclusion: values.indexOf(x) >= 0
	 * - call: phraseFn("any", values)
	 * - default: (values converted with nameFn joined with ", " and " or ") + " " + slot.suffix
	 * - example: phraseFn("any", [Ears.WOLF, Ears.FOX, Ears.CAT]),
	 *            default would be "wolf, fox or cat ears"
	 *
	 * Inclusion: values.indexOf(x) >= 0
	 * - call: phraseFn("any", values)
	 * - default: "neither " + (values converted with nameFn joined with ", " and " nor ") + " " + slot.suffix
	 * - example: phraseFn("none", [Ears.WOLF, Ears.FOX, Ears.CAT]),
	 *            default would be "neither wolf, fox nor cat ears"
	 */
	public static const Slots:/*EnumValue*/Array = [];
	
	public static function defaultPhrase(operator:String, value:*, nameFn:Function, suffix:String):String {
		if (nameFn == null) nameFn = function (value:*):String {
			return ""+value;
		}
		switch (operator) {
			case "eq":
				return nameFn(value)+suffix;
			case "ne":
				return "not "+nameFn(value)+suffix;
			case "ge":
			case "le":
			case "gt":
			case "lt":
				return {
					"gt": "more than ",
					"lt": "less than ",
					"ge": "at least ",
					"le": "at most "
				}[operator] + nameFn(value)+suffix;
			case "any":
			case "none":
				var any:Boolean = operator === "any";
				return (any?"":"neither ") +
						Utils.mergeSentences(
								(value as Array).map(Utils.varargify(nameFn)),
								(any?" or ":" nor "),
								", ",
								false
						) + suffix;
		}
		throw new Error("Invalid operator "+operator);
	}
	public static function defaultPhraseFn(suffix:String, nameFn:Function):Function {
		return function(operator:String, value:*):String {
			return defaultPhrase(operator, value, nameFn, suffix);
		}
	}
	public static function slotPhraseFn(slotid:int, suffix:Boolean=true):Function {
		var decl:Object = Slots[slotid];
		if (decl.phraseFn) return decl.phraseFn;
		var slotName:String = ("suffix" in decl) ? decl.suffix : decl.name;
		var nameFn:Function = decl.nameFn || function (value:*):String {
			return ""+value;
		};
		return function(operator:String, value:*):String {
			return defaultPhrase(operator, value, nameFn,suffix?Utils.trimRight(" " + slotName):"");
		}
	}
	
	// Numbers are never saved, so can be changed between game versions without any problems.
	// As long as they are proper 0..N sequence
	// Don't forget to add a corresponding entry in update() function!
	
	private static var _slotid:int = 0;
	// Basic body parts - sorted by name
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
	
	public static const SLOT_BODY_COLORS:int = _slotid++;
	EnumValue.add(Slots,SLOT_BODY_COLORS, "BODY_COLORS", {
		name:"body color",
		suffix:"skin"
	});
	public function get bodyColors():String {
		return data[SLOT_BODY_COLORS];
	}
	
	public static const SLOT_BODY_COLOR1:int = _slotid++;
	EnumValue.add(Slots,SLOT_BODY_COLOR1, "BODY_COLOR1", {
		name:"body primary color",
		suffix:"skin"
	});
	public function get bodyColor1():String {
		return data[SLOT_BODY_COLOR1];
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
	
	public static const SLOT_CHITIN_COLORS:int = _slotid++;
	EnumValue.add(Slots, SLOT_CHITIN_COLORS, "CHITIN_COLOR", {
		name: "chitin color",
		suffix: "chitin"
	});
	
	public static const SLOT_CHITIN_COLOR1:int = _slotid++;
	EnumValue.add(Slots, SLOT_CHITIN_COLOR1, "CHITIN_COLOR1", {
		name: "chitin primary color",
		suffix: "chitin"
	});
	
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
		name:"eye color",
		suffix:"eyes"
	});
	public function get eyeColor():String {
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
	
	public static const SLOT_FUR_COLORS:int = _slotid++;
	EnumValue.add(Slots, SLOT_FUR_COLORS, "FUR_COLOR", {
		name: "fur color",
		suffix: "fur"
	});
	public function get furColors():String {
		return data[SLOT_FUR_COLORS];
	}
	
	public static const SLOT_FUR_COLOR1:int = _slotid++;
	EnumValue.add(Slots, SLOT_FUR_COLOR1, "FUR_COLOR1", {
		name: "fur primary color",
		suffix: "fur"
	});
	public static const SLOT_FUR_COLOR2:int = _slotid++;
	EnumValue.add(Slots, SLOT_FUR_COLOR2, "FUR_COLOR2", {
		name: "fur secondary color",
		suffix: "fur"
	});
	public function get furColor1():String {
		return data[SLOT_FUR_COLOR1];
	}
	public function get furColor2():String {
		return data[SLOT_FUR_COLOR2];
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
	
	public static const SLOT_HAIR_COLORS:int = _slotid++;
	EnumValue.add(Slots,SLOT_HAIR_COLORS, "HAIR_COLOR", {
		name:"hair color",
		suffix:"hair"
	});
	public function get hairColors():String {
		return data[SLOT_HAIR_COLORS];
	}
	
	public static const SLOT_HAIR_COLOR1:int = _slotid++;
	EnumValue.add(Slots,SLOT_HAIR_COLOR1, "HAIR_COLOR1", {
		name:"hair primary color",
		suffix:"hair"
	});
	public static const SLOT_HAIR_COLOR2:int = _slotid++;
	EnumValue.add(Slots,SLOT_HAIR_COLOR2, "HAIR_COLOR2", {
		name:"hair secondary color",
		suffix:"hair"
	});
	public function get hairColor1():String {
		return data[SLOT_HAIR_COLOR1];
	}
	public function get hairColor2():String {
		return data[SLOT_HAIR_COLOR2];
	}


	public static const SLOT_HORN_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_HORN_TYPE, "HORN_TYPE", {
		name:"horns",
		nameFn: function(value:int):String {
			if (value == Horns.NONE) return "no ";
			return Horns.Types[value].name;
		}
	});
	public function get hornType():int {
		return data[SLOT_HORN_TYPE];
	}
	
	public static const SLOT_HORN_COUNT:int = _slotid++;
	EnumValue.add(Slots,SLOT_HORN_COUNT, "HORN_COUNT", {
		name:"horn count/size",
		suffix:"horns",
		nameFn: function(value:int):String {
			if (value === 0) return "no";
			return ""+value;
		}
	});
	public function get hornCount():int {
		return data[SLOT_HORN_COUNT];
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
		suffix:"",
		nameFn: function(value:int):String {
			if (value == RearBody.NONE) return "ordinary rear";
			return RearBody.Types[value].name;
		}
	});
	public function get rearType():int {
		return data[SLOT_REAR_TYPE];
	}
	
	public static const SLOT_SCALE_COLORS:int = _slotid++;
	EnumValue.add(Slots, SLOT_SCALE_COLORS, "SCALE_COLOR", {
		name: "scale color",
		suffix: "scales"
	});
	public function get scaleColors():String {
		return data[SLOT_SCALE_COLORS];
	}
	
	public static const SLOT_SCALE_COLOR1:int = _slotid++;
	EnumValue.add(Slots, SLOT_SCALE_COLOR1, "SCALE_COLOR1", {
		name: "scale primary color",
		suffix: "scales"
	});
	public function get scaleColor1():String {
		return data[SLOT_SCALE_COLOR1];
	}

	public static const SLOT_SCALE_COLOR2:int = _slotid++;
	EnumValue.add(Slots, SLOT_SCALE_COLOR2, "SCALE_COLOR2", {
		name: "scale secondary color",
		suffix: "scales"
	});
	public function get scaleColor2():String {
		return data[SLOT_SCALE_COLOR2];
	}

	public static const SLOT_FEATHER_COLORS:int = _slotid++;
	EnumValue.add(Slots, SLOT_FEATHER_COLORS, "FEATHER_COLOR", {
		name: "feather color",
		suffix: "feathers"
	});
	public function get featherColors():String {
		return data[SLOT_FEATHER_COLORS];
	}

	public static const SLOT_FEATHER_COLOR1:int = _slotid++;
	EnumValue.add(Slots, SLOT_FEATHER_COLOR1, "FEATHER_COLOR1", {
		name: "feather primary color",
		suffix: "feathers"
	});
	public function get featherColor1():String {
		return data[SLOT_FEATHER_COLOR1];
	}

	public static const SLOT_FEATHER_COLOR2:int = _slotid++;
	EnumValue.add(Slots, SLOT_FEATHER_COLOR2, "FEATHER_COLOR2", {
		name: "feather secondary color",
		suffix: "feathers"
	});
	public function get featherColor2():String {
		return data[SLOT_FEATHER_COLOR2];
	}
	
	public static const SLOT_SKIN_COLORS:int = _slotid++;
	EnumValue.add(Slots, SLOT_SKIN_COLORS, "SKIN_COLOR", {
		name: "skin color",
		suffix: "skin"
	});
	public function get skinColors():String {
		return data[SLOT_SKIN_COLORS];
	}
	
	public static const SLOT_SKIN_COLOR1:int = _slotid++;
	EnumValue.add(Slots, SLOT_SKIN_COLOR1, "SKIN_COLOR1", {
		name: "skin primary color",
		suffix: "skin"
	});
	public function get skinColor1():String {
		return data[SLOT_SKIN_COLOR1];
	}
	
	public static const SLOT_SKIN_COLOR2:int = _slotid++;
	EnumValue.add(Slots, SLOT_SKIN_COLOR2, "SKIN_COLOR2", {
		name: "skin secondary color",
		suffix: "skin"
	});
	public function get skinColor2():String {
		return data[SLOT_SKIN_COLOR2];
	}
	
	public static const SLOT_SKIN_COVERAGE:int = _slotid++;
	
	EnumValue.add(Slots,SLOT_SKIN_COVERAGE, "SKIN_COVERATE", {
		name:"skin coverage",
		suffix:"covered skin",
		nameFn: function(value:int):String {
			return [
					"not",
					"partially",
					"medium",
					"mostly",
					"fully"
			][value];
		},
		phraseFn: function(operator:String, value:*):String {
			if (operator == "eq" && value == Skin.COVERAGE_NONE) return "no coat";
			return defaultPhrase(operator, value, this.nameFn, "covered skin");
		}
	});
	public function get skinCoverage():int {
		return data[SLOT_SKIN_COVERAGE];
	}
	
	public static const SLOT_SKIN_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_TYPE, "SKIN_TYPE", {
		name:"skin",
		nameFn: function(value:int):String {
			if (value === Skin.PLAIN) return "plain";
			return Skin.SkinTypes[value].name;
		}
	});
	public function get skinType():int {
		return data[SLOT_SKIN_TYPE];
	}
	
	public static const SLOT_SKIN_BASE_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_BASE_TYPE, "SKIN_BASE_TYPE", {
		name:"skin",
		nameFn: function(value:int):String {
			if (value === Skin.PLAIN) return "plain";
			return (Skin.SkinTypes[value].adj != undefined) ? Skin.SkinTypes[value].adj : Skin.SkinTypes[value].name;
		}
	});
	public function get skinBaseType():int {
		return data[SLOT_SKIN_BASE_TYPE];
	}
	
	public static const SLOT_SKIN_BASE_COLORS:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_BASE_COLORS, "SKIN_BASE_COLOR", {
		name:"skin color",
		suffix:"skin"
	});
	public function get skinBaseColors():String {
		return data[SLOT_SKIN_BASE_COLORS];
	}
	
	public static const SLOT_SKIN_BASE_PATTERN:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_BASE_PATTERN, "SKIN_BASE_PATTERN", {
		name:"skin pattern",
		suffix:"pattern",
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
	public function get skinBaseAdj():String {
		return data[SLOT_SKIN_BASE_ADJ];
	}
	
	public static const SLOT_SKIN_COAT_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_COAT_TYPE, "SKIN_COAT_TYPE", {
		name:"coat",
		suffix:"",
		nameFn: function(value:int):String {
			return Skin.SkinTypes[value].name;
		}
	});
	public function get skinCoatType():int {
		return data[SLOT_SKIN_COAT_TYPE];
	}
	
	public static const SLOT_SKIN_COAT_COLORS:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_COAT_COLORS, "SKIN_COAT_COLOR", {
		name:"coat color",
		suffix:"coat"
	});
	public function get skinCoatColors():String {
		return data[SLOT_SKIN_COAT_COLORS];
	}
	
	public static const SLOT_SKIN_COAT_COLOR1:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_COAT_COLOR1, "SKIN_COAT_COLOR1", {
		name:"coat primary color",
		suffix:"coat"
	});
	public function get skinCoatColor1():String {
		return data[SLOT_SKIN_COAT_COLOR1];
	}
	
	public static const SLOT_SKIN_COAT_PATTERN:int = _slotid++;
	EnumValue.add(Slots,SLOT_SKIN_COAT_PATTERN, "SKIN_COAT_PATTERN", {
		name:"coat pattern",
		suffix:"pattern",
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
			if (value == Tail.NEKOMATA_FORKED_1_3) return "forked at 1/3 cat";
			if (value == Tail.NEKOMATA_FORKED_2_3) return "forked at 2/3 cat";
			return Tail.Types[value].name;
		}
	});
	public function get tailType():int {
		return data[SLOT_TAIL_TYPE];
	}
	public static const SLOT_TAIL_COUNT:int = _slotid++;
	EnumValue.add(Slots,SLOT_TAIL_COUNT, "TAIL_COUNT", {
		name:"tail count",
		suffix:"tail(s)",
		nameFn: function(value:int):String {
			if (value == 0) return "no";
			return Utils.num2Text(value);
		}/*,
		phraseFn: function (operator:String, value:*):String {
			if (value is Number) {
				if (value == 0 || value == 1) return defaultPhrase(operator, value, Slots[SLOT_TAIL_COUNT].nameFn, " tail");
			}
			return defaultPhrase(operator, value, Slots[SLOT_TAIL_COUNT].nameFn, " tails");
		}*/
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
	
	public static const SLOT_VAGINA_TYPE:int = _slotid++;
	EnumValue.add(Slots,SLOT_VAGINA_TYPE, "VAGINA_TYPE", {
		name:"vagina",
		nameFn: function(value:int):String {
			return VaginaClass.Types[value].name;
		}
	});
	public function get vaginaType():int {
		return data[SLOT_VAGINA_TYPE];
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
		suffix:"",
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
		},
		phraseFn: function (operator:String, value:*):String {
			switch (operator) {
				case "ge":
					return Measurements.footInchOrMetres(value)+" tall or more";
				case "gt":
					return "taller than "+Measurements.footInchOrMetres(value);
				case "le":
					return Measurements.footInchOrMetres(value)+" tall or less";
				case "lt":
					return "shorter than "+Measurements.footInchOrMetres(value);
			}
			return defaultPhrase(operator, value, Measurements.footInchOrMetres, "height");
		}
	});
	public function get height():int {
		return data[SLOT_HEIGHT];
	}
	
	public static const SLOT_FEMININITY:int = _slotid++;
	EnumValue.add(Slots,SLOT_FEMININITY, "FEMININITY", {
		name: "femininity",
		nameFn: function (value:Number):String {
			if (value == 100) return ""+value+" (maximum feminine)"
			if (value > 55) return ""+value+" (feminine)"
			if (value > 45) return ""+value+" (androgynous)";
			if (value == 0) return ""+value+" (maximum masculine)"
			return ""+value+" (masculine)"
		},
		phraseFn: function (operator:String, value:*):String {
			return "femininity "+defaultPhrase(operator, value, Slots[SLOT_FEMININITY].nameFn, "");
		}
	});
	public function get femininity():int {
		return data[SLOT_FEMININITY];
	}
	
	public static const SLOT_TONE:int = _slotid++;
	EnumValue.add(Slots,SLOT_TONE, "TONE", {
		name: "muscle tone",
		nameFn: function (value:Number):String {
			if (value > 75) return ""+value+" (muscular)"
			if (value > 25) return ""+value+" (average)";
			return ""+value+" (soft)"
		}
	});
	public function get tone():int {
		return data[SLOT_TONE];
	}
	
	public static const SLOT_THICKNESS:int = _slotid++;
	EnumValue.add(Slots,SLOT_THICKNESS, "THICKESS", {
		name: "thickness",
		nameFn: function (value:Number):String {
			if (value > 75) return ""+value+" (thick)"
			if (value > 25) return ""+value+" (average)";
			return ""+value+" (thin)"
		}
	});
	public function get thickness():int {
		return data[SLOT_THICKNESS];
	}
	
	public static const SLOT_BALL_SIZE:int = _slotid++;
	EnumValue.add(Slots,SLOT_BALL_SIZE, "BALL_SIZE", {
		name:"balls size",
		nameFn: function(value:Number):String {
			return Measurements.inchesOrCentimetres(value);
		}
	});
	public function get ballSize():int {
		return data[SLOT_BALL_SIZE];
	}

	public static const SLOT_BALL_COUNT:int = _slotid++;
	EnumValue.add(Slots,SLOT_BALL_COUNT, "BALL_COUNT", {
		name:"balls count",
		nameFn: function(value:Number):String {
			return ""+ value;
		}
	});
	public function get ballCount():int {
		return data[SLOT_BALL_COUNT];
	}
	
	public static const SLOT_BIGGEST_COCK_LENGTH:int = _slotid++;
	EnumValue.add(Slots,SLOT_BIGGEST_COCK_LENGTH, "BIGGEST_COCK_LENGTH", {
		name:"cock length",
		suffix:"long cock",
		nameFn: function(value:Number):String {
			return Measurements.inchesOrCentimetres(value);
		}
	});
	public function get biggestCockSize():int {
		return data[SLOT_BIGGEST_COCK_LENGTH];
	}

	public static const SLOT_COCK_COUNT:int = _slotid++;
	EnumValue.add(Slots,SLOT_COCK_COUNT, "COCK_COUNT", {
		name:"cock count",
		suffix:"cocks",
		nameFn: function(value:Number):String {
			return ""+value;
		}
	});
	public function get cockCount():int {
		return data[SLOT_COCK_COUNT];
	}
	
	public static const SLOT_BIGGEST_TIT_SIZE:int = _slotid++;
	EnumValue.add(Slots,SLOT_BIGGEST_TIT_SIZE, "BIGGEST_TIT_SIZE", {
		name:"breast size",
		suffix:"breasts",
		nameFn: function(value:int):String {
			return Appearance.breastCup(value);
		},
		phraseFn: function (operator:String, value:*):String {
			switch (operator) {
				case "gt":
					return "bigger than "+Appearance.breastCup(value)+" breasts";
				case "gte":
					return "at least "+Appearance.breastCup(value)+" breasts";
				case "lt":
					return "smaller than "+Appearance.breastCup(value)+" breasts";
				case "lte":
					return "no bigger than "+Appearance.breastCup(value)+" breasts";
			}
			return defaultPhrase(operator, value, Appearance.breastCup, "breasts");
		}
	});
	public function get biggestTitSize():int {
		return data[SLOT_BIGGEST_TIT_SIZE];
	}
	
	public var player:Player;
	public var data:Array = [];
	
	public function get isTaur():Boolean {
		return player.isTaur();
	}
	public function get isNaga():Boolean {
		return player.isNaga();
	}
	public function get isDrider():Boolean {
		return player.isDrider();
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
	public function get hasVagina():Boolean {
		return gender === Gender.GENDER_FEMALE || gender === Gender.GENDER_HERM;
	}
	public function get hasCock():Boolean {
		return gender === Gender.GENDER_MALE || gender === Gender.GENDER_HERM;
	}
	public function get hasBalls():Boolean {
		return player.hasBalls();
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
		
		data[SLOT_ANTENNAE_TYPE]     = player.antennae.type;
		data[SLOT_ARM_TYPE]          = player.arms.type;
		data[SLOT_BODY_COLORS]       = player.skin.color;
		data[SLOT_BODY_COLOR1]       = player.skin.color1;
		data[SLOT_CHITIN_COLORS]     = player.chitinColor;
		data[SLOT_CHITIN_COLOR1]     = player.chitinColor1;
		data[SLOT_EAR_TYPE]          = player.ears.type;
		data[SLOT_EYE_TYPE]          = player.eyes.type;
		data[SLOT_EYE_COLOR]         = player.eyes.colour;
		data[SLOT_FACE_TYPE]         = player.facePart.type;
		data[SLOT_FUR_COLORS]        = player.furColor;
		data[SLOT_FUR_COLOR1]        = player.furColor1;
		data[SLOT_FUR_COLOR2]        = player.furColor2;
		data[SLOT_GILLS_TYPE]        = player.gills.type;
		data[SLOT_HAIR_TYPE]         = player.hairType;
		data[SLOT_HAIR_COLORS]       = player.hairColor;
		data[SLOT_HAIR_COLOR1]       = player.hairColor1;
		data[SLOT_HAIR_COLOR2]       = player.hairColor2;
		data[SLOT_HORN_TYPE]         = player.horns.type;
		data[SLOT_HORN_COUNT]        = player.horns.count;
		data[SLOT_LEG_TYPE]          = player.lowerBodyPart.type;
		data[SLOT_REAR_TYPE]         = player.rearBody.type;
		data[SLOT_SCALE_COLORS]      = player.scaleColor;
		data[SLOT_SCALE_COLOR1]      = player.scaleColor1;
		data[SLOT_SCALE_COLOR2]      = player.scaleColor2;
		data[SLOT_FEATHER_COLORS]    = player.featherColor;
		data[SLOT_FEATHER_COLOR1]    = player.featherColor1;
		data[SLOT_FEATHER_COLOR2]    = player.featherColor2;
		data[SLOT_SKIN_COLORS]       = player.skinColor;
		data[SLOT_SKIN_COLOR1]       = player.skinColor1;
		data[SLOT_SKIN_COVERAGE]     = player.skin.coverage;
		data[SLOT_SKIN_TYPE]         = player.skin.type;
		data[SLOT_SKIN_BASE_TYPE]    = player.skin.base.type;
		data[SLOT_SKIN_BASE_COLORS]  = player.skin.base.color;
		data[SLOT_SKIN_BASE_PATTERN] = player.skin.base.pattern;
		data[SLOT_SKIN_BASE_ADJ]     = player.skin.base.adj;
		if (player.skin.coverage > Skin.COVERAGE_NONE) {
			data[SLOT_SKIN_COAT_TYPE]    = player.skin.coat.type;
			data[SLOT_SKIN_COAT_COLORS]  = player.skin.coat.color;
			data[SLOT_SKIN_COAT_COLOR1]  = player.skin.coat.color1;
			data[SLOT_SKIN_COAT_PATTERN] = player.skin.coat.pattern;
		} else {
			data[SLOT_SKIN_COAT_TYPE]    = -1;
			data[SLOT_SKIN_COAT_COLORS]  = "no";
			data[SLOT_SKIN_COAT_COLOR1]  = "no";
			data[SLOT_SKIN_COAT_PATTERN] = Skin.PATTERN_NONE;
		}
		data[SLOT_TAIL_TYPE]            = player.tail.type;
		data[SLOT_TAIL_COUNT]           = player.tail.count;
		data[SLOT_TONGUE_TYPE]          = player.tongue.type;
		data[SLOT_VAGINA_TYPE]          = player.vaginaType();
		data[SLOT_WING_TYPE]            = player.wings.type;
		
		data[SLOT_GENDER]              = player.gender;
		data[SLOT_HEIGHT]              = player.tallness;
		data[SLOT_FEMININITY]          = player.femininity;
		data[SLOT_TONE]                = player.tone;
		data[SLOT_THICKNESS]           = player.thickness;
		data[SLOT_BALL_SIZE]           = player.balls ? player.ballSize : 0;
		data[SLOT_BIGGEST_COCK_LENGTH] = player.biggestCockLength();
		data[SLOT_BIGGEST_TIT_SIZE]    = player.biggestTitSize();
		data[SLOT_COCK_COUNT]          = player.cocks.length;
		data[SLOT_BALL_COUNT]          = player.balls;
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
