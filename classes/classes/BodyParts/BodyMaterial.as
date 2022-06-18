package classes.BodyParts {
import classes.internals.EnumValue;

public class BodyMaterial {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 3)
	 * - id: name of the constant ("SKIN", "SCALES")
	 * - name: short human-readable name, ("skin", "scales")
	 * - plural: name is plural noun (true for scales/feathers)
	 * - defaultColors: initial color is randomly picked from these
	 **/
	public static const Types:Array = [];
	
	public static const SKIN:int   = 0;
	EnumValue.add(Types, SKIN, "SKIN", {
		name: "skin",
		defaultColors: ["light", "fair", "olive", "dark", "ebony", "mahogany", "russet"]
	});
	public static const HAIR:int   = 1;
	EnumValue.add(Types, HAIR, "HAIR", {
		name: "hair",
		defaultColors: ["blonde", "brown", "black", "red", "gray", "white", "auburn"]
	});
	public static const FUR:int    = 2;
	EnumValue.add(Types, FUR, "FUR", {
		name: "fur",
		defaultColors: ["red", "orange", "brown", "white", "silver", "gray", "black"]
	});
	public static const SCALES:int = 3;
	EnumValue.add(Types, SCALES, "SCALES", {
		name: "scales",
		plural: true,
		defaultColors: ["red", "green", "blue", "purple", "pink", "white", "brown", "silver", "gray", "black"]
	});
	public static const CHITIN:int = 4;
	EnumValue.add(Types, CHITIN, "CHITIN", {
		name: "chitin",
		defaultColors: ["black", "purple", "green", "yellow"]
	});
	
	public function BodyMaterial() {
	}
}
}
