package classes.BodyParts {
import classes.internals.EnumValue;

public class Beard extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NORMAL", "GOATEE")
	 * - name: human-readable default name, ("normal", "goatee")
	 */
	public static var Types:/*EnumValue*/Array = [];
	
	public static const NORMAL:int = 0;
	EnumValue.add(Types, NORMAL, "NORMAL", {name:"normal"});
	public static const GOATEE:int = 1;
	EnumValue.add(Types, GOATEE, "GOATEE", {name:"goatee"});
	public static const CLEANCUT:int = 2;
	EnumValue.add(Types, CLEANCUT, "CLEANCUT", {name:"clean-cut"});
	public static const MOUNTAINMAN:int = 3;
	EnumValue.add(Types, MOUNTAINMAN, "MOUNTAINMAN", {name:"mountain-man"});
	
	public var length:Number = 0;
	public function Beard() {
		super(null, null);
	}
}
}
