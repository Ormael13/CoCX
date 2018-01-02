package classes.BodyParts {
import classes.Creature;

public class Antennae extends BodyPart {
	public static const NONE:int = 0;
	public static const MANTIS:int = 1;
	public static const BEE:int = 2;
	public static const COCKATRICE:int = 3;
	
	public function Antennae(creature:Creature, publicPrimitives:Array) {
		super(creature, publicPrimitives);
	}
}
}
