package classes.BodyParts {
import classes.Creature;
import classes.BodyParts.*;
import classes.internals.EnumValue;
import flash.utils.Dictionary;

public class Hair extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NORMAL", "FEATHER")
	 * - name: human-readable default name, ("normal", "feather")
	 * - shortDesc: simple description of the hair
	 * - longDesc: detailed description of the hair
	 * - beardDesc: description of the beard linked to the hair type
	 */

	public static var Types:/*EnumValue*/Array = [];

	public static const NORMAL:int = 0;
	EnumValue.add(Types, NORMAL, "NORMAL", {
		name:"normal"
	});

	public static const FEATHER:int = 1;
	EnumValue.add(Types, FEATHER, "FEATHER", {
		name:"feather",
		shortDesc: "feather-{hair}"
	});

	public static const GHOST:int = 2;
	EnumValue.add(Types, GHOST, "GHOST", {
		name:"ghost",
		shortDesc: "transparent {hair}",
		beardDesc: "transparent "
	});

	public static const GOO:int = 3;
	EnumValue.add(Types, GOO, "GOO", {
		name:"goopy",
		shortDesc: "goo-{hair}",
		beardDesc: "gooey "
	});

	public static const ANEMONE:int = 4;
	EnumValue.add(Types, ANEMONE, "ANEMONE", {
		name:"tentacle",
		shortDesc: "tentacle-{hair}",
		beardDesc: "tentacley "
	});

	public static const QUILL:int = 5;
	EnumValue.add(Types, QUILL, "QUILL", {
		name:"quill",
		shortDesc: "quill-{hair}"
	});

	public static const GORGON:int = 6;
	EnumValue.add(Types, GORGON, "GORGON", {
		name:"snake-like",
		shortDesc: "snakes-{hair}",
		longDesc: "snakes instead of {hair}"
	});

	public static const LEAF:int = 7;
	EnumValue.add(Types, LEAF, "LEAF", {
		name:"leaf",
		shortDesc: "leaf-{hair}",
		beardDesc: "moss "
	});

	public static const FLUFFY:int = 8;
	EnumValue.add(Types, FLUFFY, "FLUFFY", {
		name:"fluffy",
		shortDesc: "fluffy {hair}"
	});

	public static const GRASS:int = 9;
	EnumValue.add(Types, GRASS, "GRASS", {
		name:"grass",
		shortDesc: "grass-{hair}"
	});

	public static const SILKEN:int = 10;
	EnumValue.add(Types, SILKEN, "SILKEN", {
		name:"silk-like",
		shortDesc: "silk-like-{hair}"
	});

	public static const STORM:int = 11;
	EnumValue.add(Types, STORM, "STORM", {
		name:"glowing lightning-shaped",
		shortDesc: "lightning-shaped {hair}",
		longDesc: "{hair} with tips that end with glowing lightning-shaped locks"
	});

	public static const BURNING:int = 12;
	EnumValue.add(Types, BURNING, "BURNING", {
		name:"burning",
		shortDesc: "burning mane",
		longDesc: "mane of fire that burns things only when you wish it to"
	});

	public static const SNOWY:int = 13;
	EnumValue.add(Types, SNOWY, "SNOWY", {
		name:"snowy",
		shortDesc: "snowy {hair}",
		longDesc: "snowy {hair}, human in appearance but still regularly used as a nest by snow flurries"
	});

	public static const FAIRY:int = 14;
	EnumValue.add(Types, FAIRY, "FAIRY", {
		name:"otherworldly, silk-like and almost translucent",
		shortDesc: "silky {hair}",
		longDesc: "otherworldly, silk-like and almost translucent {hair}"
	});

	public static const CRAZY:int = 15;
	EnumValue.add(Types, CRAZY, "CRAZY", {
		name:"crazy",
		shortDesc: "crazy {hair}"
	});

	public static const WINDSWEPT:int = 16;
	EnumValue.add(Types, WINDSWEPT, "WINDSWEPT", {
		name:"windswept"
	});

	public static const RATATOSKR:int = 17;
	EnumValue.add(Types, RATATOSKR, "RATATOSKR", {
		name:"striped",
		shortDesc: "stripped Ratatoskr {hair}",
		longDesc: "{hair}, stripped at the center with light tips not unlike the head of a chipmunk"
	});

	public static const PRISMATIC:int = 18;
	EnumValue.add(Types, PRISMATIC, "PRISMATIC", {
		name:"prismatic",
		shortDesc: "{hair} with prismatic strands that vary in color like the rainbow"
	});

	public static const PLAIN:int  = 0;
	public static const WILD:int = 1;
	public static const PONYTAIL:int  = 2;
	public static const LONGTRESSES:int  = 3;
	public static const TWINPIGTAIL:int  = 4;
	public static const DWARVEN:int  = 5;

	public var color:String = "no";
	public var length:Number = 0.0;

	public function Hair() {
		super(null, null);
	}

	public override function restore(keepColor:Boolean = true):void {
		super.restore();
		color = "no";
		length = 0.0;
	}
}
}
