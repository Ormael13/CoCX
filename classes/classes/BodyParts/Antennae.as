package classes.BodyParts {
import classes.internals.EnumValue;

public class Antennae extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "MANTIS")
	 * - name: human-readable name, ("non-existant", "mantis")
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const NONE:int 		= 0;
	EnumValue.add(Types, NONE, "NONE", {name: "non-existant"});
	public static const MANTIS:int 		= 1;
	EnumValue.add(Types, MANTIS, "MANTIS", {name: "mantis"});
	public static const BEE:int 		= 2;
	EnumValue.add(Types, BEE, "BEE", {name: "bee"});
	public static const COCKATRICE:int 	= 3;
	EnumValue.add(Types, COCKATRICE, "COCKATRICE", {name: "cockatrice"});
	public static const FIRE_SNAIL:int 	= 4;
	EnumValue.add(Types, FIRE_SNAIL, "FIRE_SNAIL", {name: "fire snail"});
	public static const MOTH:int 		= 5;
	EnumValue.add(Types, MOTH, "MOTH", {name: "moth"});
	public static const CENTIPEDE:int 	= 6;
	EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {name: "centipede"});

	public function Antennae() {
		super(null, null);
	}

	public static function getTFDescription(creature: *, bodyPart: *):String {
		return formatDescription((bodyPart.tfDescFunc ? bodyPart.tfDescFunc(creature) : bodyPart.tfDesc) || "", creature);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return " " + desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
