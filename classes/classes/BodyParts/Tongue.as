package classes.BodyParts {

public class Tongue extends BodyPart{
	public static const HUMAN:int    = 0;
	public static const SNAKE:int    = 1;
	public static const DEMONIC:int  = 2;
	public static const DRACONIC:int = 3;
	public static const ECHIDNA:int  = 4;
	public static const CAT:int      = 5;
	public static const ELF:int      = 6;
	public static const DOG:int      = 7;
	// Don't forget to add new types in DebugMenu.as list TONGUE_TYPE_CONSTANTS
	
	public function Tongue() {
		super(null, null);
	}
}
}
