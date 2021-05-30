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
	public static const SEADRAGON:int 	= 7;
	EnumValue.add(Types, SEADRAGON, "SEADRAGON", {name: "sea dragon"});
	
	public function Antennae() {
		super(null, null);
	}
}
}
