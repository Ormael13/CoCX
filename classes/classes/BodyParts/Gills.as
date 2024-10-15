package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

public class Gills extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "ANEMONE")
	 * - name: human-readable default name, ("non-existant", "anemone")
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const NONE: int = 0;
	EnumValue.add(Types, NONE, "NONE", {
		name:"non-existant",
		appearanceDesc: ""
	});
	public static const ANEMONE: int = 1;
	EnumValue.add(Types, ANEMONE, "ANEMONE", {
		name:"anemone",
		appearanceDesc: "A pair of feathery gills are growing out just below your neck, spreading out horizontally and draping down your chest. They allow you to stay in the water for quite a long time."
	});
	public static const FISH: int = 2;
	EnumValue.add(Types, FISH, "FISH", {
		name:"fish",
		appearanceDesc: "A set of fish-like gills reside on your neck, several small slits that can close flat against your skin. They allow you to stay in the water for quite a long time."
	});
	public static const GILLS_IN_TENTACLE_LEGS: int = 3;
	EnumValue.add(Types, GILLS_IN_TENTACLE_LEGS, "GILLS_IN_TENTACLE_LEGS", {
		name:"placed in tentacle legs",
		appearanceDesc: ""
	});

	public function Gills(creature:Creature) {
		super(creature, null);
	}

	public static function getAppearanceDescription(creature: *):String {
		const id: int = creature.gills.type;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
