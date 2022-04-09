package classes.BodyParts {
import classes.Creature;
import classes.BodyParts.*;
import classes.internals.EnumValue;
import classes.StatusEffects;
import classes.internals.Utils;

public class Hair extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NORMAL", "FEATHER")
	 * - name: human-readable default name, ("normal", "feather")
	 *
	 * - shortDesc: simple description of the hair
	 * - shortDescFunc: function that returns a shortDesc value (shortDesc is ignored if this exists)
	 *
	 * - appearanceDesc: detailed description of the hair for PlayerAppearance.as
	 * - appearanceDescFunc: function that returns an appearanceDesc value (appearanceDesc is ignored if this exists)
	 *
	 * - beardDesc: description of the beard linked to the hair type
	 *
	 * - ignoresStyle: hair's unique appearance ignores normal hairstyles (plain, wild, etc.)
	 */

	public static var Types:/*EnumValue*/Array = [];

	public static const NORMAL:int = 0;
	EnumValue.add(Types, NORMAL, "NORMAL", {
		name:"normal",
		appearanceDesc: "Although not particularly remarkable, your {hairInfo} looks good on you, accentuating your features well."
	});

	public static const FEATHER:int = 1;
	EnumValue.add(Types, FEATHER, "FEATHER", {
		name:"feather",
		shortDesc: "feather-{hair}",
		appearanceDesc: "Your {hairInfo} is made completely out of feathers rather than actual strands.",
		ignoresStyle: true
	});

	public static const GHOST:int = 2;
	EnumValue.add(Types, GHOST, "GHOST", {
		name:"ghost",
		shortDesc: "transparent {hair}",
		appearanceDesc: "Although your {hairInfo} technically has the features of normal human hair, it is also completely transparent.",
		beardDesc: "transparent "
	});

	public static const GOO:int = 3;
	EnumValue.add(Types, GOO, "GOO", {
		name:"goopy",
		shortDesc: "goo-{hair}",
		appearanceDesc: "Atop your head is a gooey {hairInfo}, more like an amorphous blob imitating the familiar shape than the real deal.",
		beardDesc: "gooey "
	});

	public static const ANEMONE:int = 4;
	EnumValue.add(Types, ANEMONE, "ANEMONE", {
		name:"tentacle",
		shortDesc: "tentacle-{hair}",
		appearanceDesc: "Your {hairInfo} is in truth made out of anemone tentacles, only vaguely resembling the real deal.",
		beardDesc: "tentacley ",
		ignoresStyle: true
	});

	public static const QUILL:int = 5;
	EnumValue.add(Types, QUILL, "QUILL", {
		name:"quill",
		shortDesc: "quill-{hair}",
		appearanceDesc: "Your {hairInfo} is made completely out of quills rather than actual strands.",
		ignoresStyle: true
	});

	public static const GORGON:int = 6;
	EnumValue.add(Types, GORGON, "GORGON", {
		name:"snake-like",
		shortDesc: "snakes-{hair}",
		appearanceDesc: "Atop your head is technically {hairInfo}, if one were to ignore that it is made of snakes rather than actual hair.",
		ignoresStyle: true
	});

	public static const LEAF:int = 7;
	EnumValue.add(Types, LEAF, "LEAF", {
		name:"leaf",
		shortDesc: "leaf-{hair}",
		appearanceDesc: "Considering how your {hairInfo} is made completely out of leaves, you seem to have some sort of connection to nature.",
		beardDesc: "moss "
	});

	public static const FLUFFY:int = 8;
	EnumValue.add(Types, FLUFFY, "FLUFFY", {
		name:"fluffy",
		shortDesc: "fluffy {hair}",
		appearanceDesc: "You have a white pillowy {hair}, very much wooly to the touch and constantly trying to lull you to sleep anytime you lie against a surface.",
		ignoresStyle: true
	});

	public static const GRASS:int = 9;
	EnumValue.add(Types, GRASS, "GRASS", {
		name:"grass",
		shortDesc: "grass-{hair}",
		appearanceDesc: "Rather than normal strands, your {hairInfo} is actually made entirely of grass, like some sort of nature spirit's."
	});

	public static const SILKEN:int = 10;
	EnumValue.add(Types, SILKEN, "SILKEN", {
		name:"silky",
		shortDesc: "elven {hair}",
		appearanceDesc: "Your {hairInfo} is extremely glossy and smooth, its elvish features so perfect by human standards to the point of feeling unnatural."
	});

	public static const STORM:int = 11;
	EnumValue.add(Types, STORM, "STORM", {
		name:"glowing lightning-shaped",
		shortDesc: "lightning {hair}",
		appearanceDesc: "Your {hairInfo}'s tips end in glowing lightning-shaped locks, crackling with electricity whenever you will them to."
	});

	public static const BURNING:int = 12;
	EnumValue.add(Types, BURNING, "BURNING", {
		name:"burning",
		shortDesc: "burning hair",
		appearanceDesc: "Your {hairInfo} has its tips overtaken by a magic flame, burning anything you wish it to and nothing more."
	});

	public static const SNOWY:int = 13;
	EnumValue.add(Types, SNOWY, "SNOWY", {
		name:"snowy",
		shortDesc: "snowy {hair}",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "Your {hairInfo} is human in appearance, but cold to the touch and regularly used as a nest by snow flurries";

			if (creature.rearBody.type == RearBody.GLACIAL_AURA) {
				desc += ", an effect amplified by your bone-chilling aura";
			}

			desc += "."

			return desc;
		}
	});

	public static const FAIRY:int = 14;
	EnumValue.add(Types, FAIRY, "FAIRY", {
		name:"otherworldly silky and almost translucent",
		shortDesc: "silky fairy {hair}",
		appearanceDesc: "Despite looking almost human, your {hairInfo} is otherworldly smooth and almost translucent, its fairy traits easy to notice if not identify."
	});

	public static const CRAZY:int = 15;
	EnumValue.add(Types, CRAZY, "CRAZY", {
		name:"crazy",
		shortDesc: "crazy {hair}",
		appearanceDesc: "Your wild {hairInfo} is positively crazy, with spiked tips pointing outwards to your sides.",
		ignoresStyle: true
	});

	public static const WINDSWEPT:int = 16;
	EnumValue.add(Types, WINDSWEPT, "WINDSWEPT", {
		name:"windswept",
		appearanceDesc: "Your {hairInfo} is quite aerodynamic, shaped as to avoid encumbering you even in a windstorm."
	});

	public static const RATATOSKR:int = 17;
	EnumValue.add(Types, RATATOSKR, "RATATOSKR", {
		name:"stripped",
		shortDesc: "stripped {hair}",
		appearanceDesc: "Though your {hairInfo} could almost pass for human, it's stripped at the center with light tips not unlike the head of a chipmunk."
	});

	public static const PRISMATIC:int = 18;
	EnumValue.add(Types, PRISMATIC, "PRISMATIC", {
		name:"prismatic",
		shortDesc: "prismatic {hair}",
		appearanceDesc: "Although your {hairInfo} looks mostly human, that notion is quickly discarded by its prismatic strands, varying in hue along their length to display all the colors of a rainbow."
	});

	public static const MINDBREAKER:int = 19;
	EnumValue.add(Types, MINDBREAKER, "MINDBREAKER", {
		name:"mindbreaker",
		shortDesc: "slimy tentacle {hair}",
		appearanceDesc: "Your {hairInfo} is made out of tentacles, only vaguely resembling the real deal."
	});

	public static const MINDBREAKERMALE:int = 20;
	EnumValue.add(Types, MINDBREAKERMALE, "MINDBREAKERMALE", {
		name:"mindbreaker",
		shortDesc: "slimy tentacle {hair}",
		appearanceDesc: "Smaller webbings frill along the top of your head, forming a crown-like ring. Along these frills are longer hair-like tentacles that reach down to drape past your shoulders, just above your pectorals."
	});

	public static const COW:int = 21;
	EnumValue.add(Types, COW, "COW", {
		name:"cow like",
		shortDesc: "dark spoted {hair}",
		appearanceDesc: "Your {hairInfo} looks about normal except that they have darker spot reminding of cow fur."
	});

	// Additional modifiers for hair descriptions
	public static var Styles:/*EnumValue*/Array = [];

	public static const PLAIN:int  = 0;
	EnumValue.add(Styles, PLAIN, "PLAIN", {
		adjective: ""
	});

	public static const WILD:int = 1;
	EnumValue.add(Styles, WILD, "WILD", {
		adjective: "wild"
	});

	public static const PONYTAIL:int  = 2;
	EnumValue.add(Styles, PONYTAIL, "PONYTAIL", {
		adjective: "ponytailed"
	});

	public static const LONGTRESSES:int  = 3;
	EnumValue.add(Styles, LONGTRESSES, "LONGTRESSES", {
		adjective: "low-ponytailed"
	});

	public static const TWINTAILS:int  = 4;
	EnumValue.add(Styles, TWINTAILS, "TWINTAILS", {
		adjective: "twintailed"
	});

	public static const DWARVEN:int  = 5;
	EnumValue.add(Styles, DWARVEN, "DWARVEN", {
		adjective: "Dwarven"
	});

	public static const SNOWLILY:int  = 6;
	EnumValue.add(Styles, SNOWLILY, "SNOWLILY", {
		adjective: "snowlily"
	});

	public static const FOURWIND:int  = 7;
	EnumValue.add(Styles, FOURWIND, "FOURWIND", {
		adjective: "fourwind"
	});

	public static const FOURWINDL:int  = 8;
	EnumValue.add(Styles, FOURWINDL, "FOURWINDL", {
		adjective: "long fourwind"
	});

	public static const TAURPONYTAIL:int  = 9;
	EnumValue.add(Styles, TAURPONYTAIL, "TAURPONYTAIL", {
		adjective: "centaur ponytail"
	});


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

	public static function getDescription(creature: *): String {
		if (creature.hairLength == 0) {
			if(creature.skinType == Skin.FUR)
				return "furry head";
			else {
				return getHairLength(creature) + " head";
			}
		}

		const id: int = creature.hairType;
		const idStyle: int = creature.hairStyle;

		return (Types[id].ignoresStyle ? "" : Styles[idStyle].adjective + " ") + getHairLength(creature) + " " +  creature.hairColor + " " + formatDescription(Types[id].shortDesc || "{hair}", creature);
	}

	public static function getShortDescription(creature: *): String {
		if (creature.hairLength == 0) {
			if(creature.skinType == Skin.FUR)
				return "furry head";
			else {
				return getHairLength(creature) + " head";
			}
		}

		const id: int = creature.hairType;

		return formatDescription(Types[id].shortDesc || "{hair}", creature);
	}

	public static function getAppearanceDescription(creature: *): String {
		if (creature.hairLength == 0) {
			if(creature.skinType == Skin.FUR)
				return "You have no hair, only a thin layer of fur atop of your head.";
			else {
				return "You have a completely " + getHairLength(creature) + " head, showing only shiny [skintone] [skin.type].";
			}
		}

		const id: int = creature.hairType;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature);
	}

	public static function getStyleDescription(creature: *): String {
		const id: int = creature.hairStyle;
		const hairId: int = creature.hairType;

		var hair:String = "hair";

		//If furry and longish hair sometimes call it a mane (50%)
		if (creature.hasFur() == 1 && creature.hairLength > 3 && rand(2) == 0) {
			hair = "mane";
		}

		if (Types[hairId].ignoresStyle) {
			return formatDescription(Types[hairId].shortDesc || "{hair}", creature);
		} else {
			return formatDescription((Styles[id].adjective + ' ' || '') + "{hair}", creature);
		}
	}

	private static function formatDescription(desc: String, creature: *): String {

		const id: int = creature.hairType;
		const idStyle: int = creature.hairStyle;

		var hair:String = "hair";

		//If furry and longish hair sometimes call it a mane (50%)
		if (creature.hasFur() == 1 && creature.hairLength > 3 && rand(2) == 0) {
			hair = "mane";
		}

		const hairPattern:RegExp = /{hair}/g;
		const hairInfoPattern:RegExp = /{hairInfo}/g;

		return desc
			.replace(hairPattern, hair)
			.replace(hairInfoPattern, (Types[id].ignoresStyle ? "" : Styles[idStyle].adjective + " ") + getHairLength(creature) + " " +  creature.hairColor + " " +  hair);
	}

	public static function getHairLength (creature: *): String {
		var options:Array;
		var hairscale:Number = creature.hairLength / creature.tallness;
		if (hairscale == 0) {
			options = ["shaved", "bald", "smooth", "hairless", "glabrous"];
			return randomChoice(options);
		} else if (hairscale <= 0.05){
			options = ["close-cropped", "trim",	"very short"];
			return randomChoice(options);
		}	else if (hairscale > 0.05 && hairscale <= 0.1){
			return "short";
		}	else if (hairscale > 0.1 && hairscale <= 0.14){
			return "shaggy";
		}	else if (hairscale > 0.14 && hairscale <= 0.17){
			return "moderately long";
		}	else if (hairscale > 0.17 && hairscale <= 0.2){
			if (rand(2) == 0) return "long";
			else return "shoulder-length";
		}	else if (hairscale > 0.2 && hairscale <= 0.25){
			return "very long";
		}	else if (hairscale > 0.25 && hairscale <= 0.4){
			return "back-covering";
		}	else if (hairscale > 0.4 && hairscale <= 0.5){
			return "ass-length";
		}	else if (hairscale > 0.5 && hairscale <= 1){
			return "obscenely long"
		}	else if (hairscale > 1 ){
			return "floor-length";
		}

		return "";
	}

	public static function ignoresStyle (creature: *): Boolean {
		const id: int = creature.hairType;

		return Types[id].ignoresStyle || false;
	}
}
}
