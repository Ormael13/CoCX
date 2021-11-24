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
	
	function DamageType() {
	}
}
}
