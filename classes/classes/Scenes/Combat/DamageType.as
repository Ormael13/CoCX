package classes.Scenes.Combat {
import classes.internals.EnumValue;

public class DamageType {
	
	public static const Types:/*EnumValue*/Array = [];
	
	public static const PHYSICAL:int = 0;
	EnumValue.add(Types, PHYSICAL, "PHYSICAL", {name: "physical"});
	
	public static const MAGICAL:int = 1;
	EnumValue.add(Types, MAGICAL, "MAGICAL", {name: "magical"});
	
	public static const FIRE:int = 2;
	EnumValue.add(Types, FIRE, "FIRE", {name: "fire"});
	
	public static const ICE:int = 3;
	EnumValue.add(Types, ICE, "ICE", {name: "ice"});
	
	public static const LIGHTNING:int = 4;
	EnumValue.add(Types, LIGHTNING, "LIGHTNING", {name: "lightning"});
	
	public static const DARKNESS:int = 5;
	EnumValue.add(Types, DARKNESS, "DARKNESS", {name: "darkness"});
	
	function DamageType() {
	}
}
}
