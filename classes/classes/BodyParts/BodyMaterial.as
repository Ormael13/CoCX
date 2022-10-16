package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

public class BodyMaterial extends BodyPart {
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
	public static const FEATHERS:int = 5;
	EnumValue.add(Types, FEATHERS, "FEATHERS", {
		name: "feathers",
		plural: true,
		defaultColors: ["red", "green", "blue", "purple", "pink", "white", "brown", "silver", "gray", "black"]
	});
	public static const BARK:int = 6;
	EnumValue.add(Types, BARK, "BARK", {
		name: "bark",
		defaultColors: ["mahogany", "brown", "black"]
	});
	
	// these 4 values are kept in sync in setters
	private var _color:String;
	private var _color1:String;
	private var _color2:String;
	private var _binary:Boolean;
	
	public function get name():String {
		return Types[type].name;
	}
	/**
	 * Two different colors
	 */
	public function get binary():Boolean {
		return _binary;
	}
	public function get color():String {
		return _color;
	}
	public function set color(value:String):void {
		var i:int = value.indexOf(" and ");
		_color = value;
		if (i >= 0) {
			_binary = true;
			_color1 = value.substr(0, i);
			_color2 = value.substr(i+" and ".length);
		} else {
			_binary = false;
			_color1 = value;
			_color2 = value;
		}
	}
	public function get color1():String {
		return _color1;
	}
	public function set color1(value:String):void {
		if (!_binary) {
			color = value;
			return;
		}
		_color1 = value;
		_binary = _color1 !== _color2;
		if (_binary) {
			_color = value+" and "+_color2;
		} else {
			_color2 = value;
			_color = value;
		}
	}
	public function get color2():String {
		return _color2;
	}
	public function set color2(value:String):void {
		_color2 = value;
		_binary = _color1 !== _color2;
		if (_binary) {
			_color = _color1+" and "+value;
		} else {
			_color = value;
		}
	}
	
	public function BodyMaterial(creature: Creature, type:int) {
		super(creature,["color1","color2"]);
		this.type = type;
		this.color = randomChoice(Types[type].defaultColors);
	}
}
}
