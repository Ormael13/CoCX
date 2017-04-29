/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class Tail extends BodyPart {

	// A number of tails; legacy version used venom for counting
	public var count:int       = 0;
	//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
	public var venom:Number    = 0;
	//Tail recharge determines how fast venom/webs comes back per hour.
	public var recharge:Number = 5;

	public function Tail(creature:Creature) {
		super(creature);
	}

	public function isLong():Boolean {
		if (creature.isNaga()) return true;
		return [
				   TAIL_TYPE_DOG, TAIL_TYPE_DEMONIC, TAIL_TYPE_COW, TAIL_TYPE_SHARK, TAIL_TYPE_CAT,
				   TAIL_TYPE_LIZARD, TAIL_TYPE_KANGAROO, TAIL_TYPE_FOX, TAIL_TYPE_DRACONIC,
				   TAIL_TYPE_RACCOON, TAIL_TYPE_MOUSE, TAIL_TYPE_FERRET, TAIL_TYPE_BEHEMOTH, TAIL_TYPE_SCORPION,
				   TAIL_TYPE_WOLF
			   ].indexOf(type) >= 0;

	}

}
}
