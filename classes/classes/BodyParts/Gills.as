package classes.BodyParts {
import classes.internals.EnumValue;

public class Gills extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "ANEMONE")
	 * - name: human-readable default name, ("non-existant", "anemone")
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const NONE:int                   = 0;
	EnumValue.add(Types, NONE, "NONE", {name:"non-existant"})
	public static const ANEMONE:int                = 1;
	EnumValue.add(Types, ANEMONE, "ANEMONE", {name:"anemone"})
	public static const FISH:int                   = 2;
	EnumValue.add(Types, FISH, "FISH", {name:"fish"})
	public static const GILLS_IN_TENTACLE_LEGS:int = 3;
	EnumValue.add(Types, GILLS_IN_TENTACLE_LEGS, "GILLS_IN_TENTACLE_LEGS", {name:"placed in tentacle legs"})

	public function Gills() {
		super(null, null);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
