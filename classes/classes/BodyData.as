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
	
	// Basic body parts
	public static const SLOT_ANTENNAE_TYPE:int = 0;
	EnumValue.add(Slots,SLOT_ANTENNAE_TYPE, "ANTENNAE_TYPE", {
		name:"antennae",
		nameFn: function(value:int):String {
			return Antennae.Types[value].name;
		}
	});
	public static const SLOT_ARM_TYPE:int = 1;
	EnumValue.add(Slots,SLOT_ARM_TYPE, "ARM_TYPE", {
		name:"arms",
		nameFn: function(value:int):String {
			return Arms.Types[value].name;
		}
	});
	public static const SLOT_EAR_TYPE:int = 2;
	EnumValue.add(Slots,SLOT_EAR_TYPE, "EAR_TYPE", {
		name:"ears",
		nameFn: function(value:int):String {
			return Ears.Types[value].name;
		}
	});
	public static const SLOT_EYE_TYPE:int = 3;
	EnumValue.add(Slots,SLOT_EYE_TYPE, "EYE_TYPE", {
		name:"eyes",
		nameFn: function(value:int):String {
			return Eyes.Types[value].name;
		}
	});
	public static const SLOT_EYE_COLOR:int = 4;
	EnumValue.add(Slots,SLOT_EYE_COLOR, "EYE_COLOR", {
		name:"eye color"
	});
	public static const SLOT_FACE_TYPE:int = 5;
	EnumValue.add(Slots,SLOT_FACE_TYPE, "FACE_TYPE", {
		name:"face",
		nameFn: function(value:int):String {
			return Face.Types[value].name;
		}
	});
	public static const SLOT_HAIR_TYPE:int = 6;
	EnumValue.add(Slots,SLOT_HAIR_TYPE, "HAIR_TYPE", {
		name:"hair",
		nameFn: function(value:int):String {
			return Hair.Types[value].name;
		}
	});
	public static const SLOT_HAIR_COLOR:int = 7;
	EnumValue.add(Slots,SLOT_HAIR_COLOR, "HAIR_COLOR", {
		name:"hair color"
	});
	public static const SLOT_LEG_TYPE:int = 8;
	EnumValue.add(Slots,SLOT_LEG_TYPE, "LEG_TYPE", {
		name:"legs",
		nameFn: function(value:int):String {
			return LowerBody.Types[value].name;
		}
	});
	public static const SLOT_REAR_TYPE:int = 9;
	EnumValue.add(Slots,SLOT_REAR_TYPE, "REAR_TYPE", {
		name:"rear",
		nameFn: function(value:int):String {
			return RearBody.Types[value].name;
		}
	});
	public static const SLOT_SKIN_BASE_TYPE:int = 10;
	EnumValue.add(Slots,SLOT_SKIN_BASE_TYPE, "SKIN_BASE_TYPE", {
		name:"skin",
		nameFn: function(value:int):String {
			return Skin.SkinTypes[value].name;
		}
	});
	public static const SLOT_SKIN_BASE_COLOR:int = 11;
	EnumValue.add(Slots,SLOT_SKIN_BASE_COLOR, "SKIN_BASE_COLOR", {
		name:"skin color"
	});
	public static const SLOT_SKIN_COAT_TYPE:int = 12;
	EnumValue.add(Slots,SLOT_SKIN_COAT_TYPE, "SKIN_COAT_TYPE", {
		name:"coat",
		nameFn: function(value:int):String {
			return Skin.SkinTypes[value].name;
		}
	});
	public static const SLOT_SKIN_COAT_COLOR:int = 13;
	EnumValue.add(Slots,SLOT_SKIN_COAT_COLOR, "SKIN_COAT_COLOR", {
		name:"coat color"
	});
	public static const SLOT_TAIL_TYPE:int = 14;
	EnumValue.add(Slots,SLOT_TAIL_TYPE, "TAIL_TYPE", {
		name:"tail",
		nameFn: function(value:int):String {
			return Tail.Types[value].name;
		}
	});
	public static const SLOT_WING_TYPE:int = 15;
	EnumValue.add(Slots,SLOT_WING_TYPE, "WING_TYPE", {
		name:"wings",
		nameFn: function(value:int):String {
			return Wings.Types[value].name;
		}
	});
	// Other stats
	public static const SLOT_GENDER:int = 16;
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
	public static const SLOT_HEIGHT:int = 17;
	EnumValue.add(Slots,SLOT_HEIGHT, "HEIGHT", {
		name: "height",
		nameFn: function (value:Number):String {
			return Measurements.footInchOrMetres(value);
		}
	});
	
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
		data[SLOT_HAIR_TYPE] = player.hairType;
		data[SLOT_HAIR_COLOR] = player.hairColor;
		data[SLOT_LEG_TYPE] = player.lowerBodyPart.type;
		data[SLOT_REAR_TYPE] = player.rearBody.type;
		data[SLOT_SKIN_BASE_TYPE] = player.skin.base.type;
		data[SLOT_SKIN_BASE_COLOR] = player.skin.base.color;
		data[SLOT_SKIN_COAT_TYPE] = player.skin.coat.type;
		data[SLOT_SKIN_COAT_COLOR] = player.skin.coat.color;
		data[SLOT_TAIL_TYPE] = player.tail.type;
		data[SLOT_WING_TYPE] = player.wings.type;
		data[SLOT_GENDER]    = player.gender;
		
	}
	
	public function clone():BodyData {
		var bd: BodyData = new BodyData(player, false);
		bd.data = this.data.slice();
		return bd;
	}
}
}
