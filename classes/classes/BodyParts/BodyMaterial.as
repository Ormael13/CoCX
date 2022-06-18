package classes.BodyParts {
import classes.internals.EnumValue;

public class BodyMaterial {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 3)
	 * - id: name of the constant ("SKIN", "SCALES")
	 * - name: short human-readable name, ("skin", "scales")
	 * - plural: name is plural noun (true for scales)
	 **/
	public static const Types:Array = [];
	
	public static const SKIN:int   = 0;
	EnumValue.add(Types, SKIN, "SKIN", {
		name: "skin"
	});
	public static const HAIR:int   = 1;
	EnumValue.add(Types, HAIR, "HAIR", {
		name: "hair"
	})
	public static const FUR:int    = 2;
	EnumValue.add(Types, FUR, "FUR", {
		name: "fur"
	})
	public static const SCALES:int = 3;
	EnumValue.add(Types, SCALES, "SCALES", {
		name: "scales",
		plural: true
	})
	public static const CHITIN:int = 4;
	EnumValue.add(Types, CHITIN, "CHITIN", {
		name: "chitin"
	})
	
	public function BodyMaterial() {
	}
}
}
