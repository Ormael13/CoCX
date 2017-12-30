package classes.BodyParts {
import classes.Creature;

public class Gills extends BodyPart {
	public static const NONE:int                   = 0;
	public static const ANEMONE:int                = 1;
	public static const FISH:int                   = 2;
	public static const GILLS_IN_TENTACLE_LEGS:int = 3;
	
	public function Gills(creature:Creature, publicPrimitives:Array) {
		super(creature, publicPrimitives);
	}
}
}
