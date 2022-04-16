package classes.Scenes.Combat {
import classes.internals.EnumValue;

public class DamageType {
	
	public static const Types:/*EnumValue*/Array = [];
	
	// Unspecified damage type that does ignores damage type-based resitances and bonuses
	public static const GENERIC:int = 0;
	EnumValue.add(Types, GENERIC, "GENERIC", {name: "generic"});
	
	public static const PHYSICAL:int = 1;
	EnumValue.add(Types, PHYSICAL, "PHYSICAL", {name: "physical"});
	
	public static const MAGICAL:int = 2;
	EnumValue.add(Types, MAGICAL, "MAGICAL", {name: "magical"});
	
	public static const FIRE:int = 3;
	EnumValue.add(Types, FIRE, "FIRE", {name: "fire"});
	
	public static const ICE:int = 4;
	EnumValue.add(Types, ICE, "ICE", {name: "ice"});
	
	public static const LIGHTNING:int = 5;
	EnumValue.add(Types, LIGHTNING, "LIGHTNING", {name: "lightning"});
	
	public static const DARKNESS:int = 6;
	EnumValue.add(Types, DARKNESS, "DARKNESS", {name: "darkness"});
	
	public static const TRUE:int = 7;
	EnumValue.add(Types, TRUE, "TRUE", {name: "true"});
	
	public static const WATER:int = 8;
	EnumValue.add(Types, WATER, "WATER", {name: "water"});
	
	public static const WIND:int = 9;
	EnumValue.add(Types, WIND, "WIND", {name: "wind"});
	
	public static const EARTH:int = 10;
	EnumValue.add(Types, EARTH, "EARTH", {name: "earth"});
	
	public static const ACID:int = 11;
	EnumValue.add(Types, ACID, "ACID", {name: "acid"});
	
	function DamageType() {
	}
}
}
