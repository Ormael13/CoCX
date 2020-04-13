package classes.BodyParts {

public class Antennae extends BodyPart {
	public static const NONE:int 		= 0;
	public static const MANTIS:int 		= 1;
	public static const BEE:int 		= 2;
	public static const COCKATRICE:int 	= 3;
	public static const FIRE_SNAIL:int 	= 4;
	public static const MOTH:int 		= 5;
	public static const CENTIPEDE:int 	= 6;
	// Don't forget to add new types in DebugMenu.as list ANTENNA_TYPE_CONSTANTS
	
	public function Antennae() {
		super(null, null);
	}
}
}
