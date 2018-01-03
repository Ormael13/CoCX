package classes.BodyParts {
import classes.Creature;

public class Tongue extends BodyPart{
	public static const HUMAN:int    = 0;
	public static const SNAKE:int    = 1;
	public static const DEMONIC:int  = 2;
	public static const DRACONIC:int = 3;
	public static const ECHIDNA:int  = 4;
	public static const CAT:int      = 5;
	public static const ELF:int      = 6;
	
	public function Tongue(creature:Creature, publicPrimitives:Array) {
		super(creature, publicPrimitives);
	}
}
}
