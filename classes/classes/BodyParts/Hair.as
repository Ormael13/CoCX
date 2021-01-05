package classes.BodyParts {
import classes.internals.EnumValue;

public class Hair extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NORMAL", "FEATHER")
	 * - name: human-readable default name, ("normal", "feather")
	 */
	public static var Types:/*EnumValue*/Array = [];
	
	public static const NORMAL:int  	= 0;
	EnumValue.add(Types, NORMAL, "NORMAL", {name:"normal"});
	public static const FEATHER:int 	= 1;
	EnumValue.add(Types, FEATHER, "FEATHER", {name:"feather"});
	public static const GHOST:int   	= 2;
	EnumValue.add(Types, GHOST, "GHOST", {name:"ghost"});
	public static const GOO:int     	= 3;
	EnumValue.add(Types, GOO, "GOO", {name:"goopy"});
	public static const ANEMONE:int 	= 4;
	EnumValue.add(Types, ANEMONE, "ANEMONE", {name:"tentacle"});
	public static const QUILL:int   	= 5;
	EnumValue.add(Types, QUILL, "QUILL", {name:"quill"});
	public static const GORGON:int  	= 6;
	EnumValue.add(Types, GORGON, "GORGON", {name:"snake-like"});
	public static const LEAF:int    	= 7;
	EnumValue.add(Types, LEAF, "LEAF", {name:"leaf"});
	public static const FLUFFY:int  	= 8;
	EnumValue.add(Types, FLUFFY, "FLUFFY", {name:"fluffy"});
	public static const GRASS:int   	= 9;
	EnumValue.add(Types, GRASS, "GRASS", {name:"grass"});
	public static const SILKEN:int  	= 10;
	EnumValue.add(Types, SILKEN, "SILKEN", {name:"silk-like"});
	public static const STORM:int   	= 11;
	EnumValue.add(Types, STORM, "STORM", {name:"glowing lightning shaped"});
	public static const BURNING:int 	= 12;
	EnumValue.add(Types, BURNING, "BURNING", {name:"burning"});
	public static const SNOWY:int 		= 13;
	EnumValue.add(Types, SNOWY, "SNOWY", {name:"snowy"});
	public static const FAIRY:int 		= 14;
	EnumValue.add(Types, FAIRY, "FAIRY", {name:"otherworldly, silk-like and almost translucent"});
	public static const CRAZY:int 		= 15;
	EnumValue.add(Types, CRAZY, "CRAZY", {name:"crazy"});
	public static const WINDSWEPT:int 	= 16;
	EnumValue.add(Types, WINDSWEPT, "WINDSWEPT", {name:"windswept"});
	public static const RATATOSKR:int 	= 17;
	EnumValue.add(Types, RATATOSKR, "RATATOSKR", {name:"striped"});

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
