/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class Claws extends BodyPart {
	public static const TYPE_NORMAL:int     = 0;
	public static const TYPE_LIZARD:int     = 1;
	public static const TYPE_DRAGON:int     = 2;
	public static const TYPE_SALAMANDER:int = 3;
	public static const TYPE_CAT:int        = 4; // NYI! Placeholder for now!! (See http://tiny.cc/coc-revamp-claws)
	public static const TYPE_DOG:int        = 5; // NYI! Placeholder for now!! (See http://tiny.cc/coc-revamp-claws)
	public static const TYPE_RAPTOR:int     = 6; // NYI! Placeholder for now!! (See http://tiny.cc/coc-revamp-claws) Giev teh Rapturs :-)
	public static const TYPE_MANTIS:int     = 7; // NYI! Placeholder for Xianxia mod (See http://tiny.cc/coc-xianxia-mod)

	public var tone:String                  = "";

	public function Claws(creature:Creature) {
		super(creature);
		addPublicPrimitives("tone");
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		tone = "";
	}

	override public function describe(options:Object):String {
		var toneText:String = tone == "" ? " " : (", " + tone + " ");
		switch (type) {
			case TYPE_NORMAL: return "fingernails";
			case TYPE_LIZARD: return "short curved" + toneText + "claws";
			case TYPE_DRAGON: return "powerful, thick curved" + toneText + "claws";
			// Since mander arms are hardcoded and the others are NYI, we're done here for now
		}
		return "fingernails";
	}
}
}
