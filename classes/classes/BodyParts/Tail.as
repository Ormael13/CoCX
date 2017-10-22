/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.AppearanceDefs;
import classes.Creature;

public class Tail extends SaveableBodyPart {

	// A number of tails; legacy version used venom for counting
	public var count:int       = 0;
	//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
	public var venom:Number    = 0;
	//Tail recharge determines how fast venom/webs comes back per hour.
	public var recharge:Number = 5;

	override public function set type(value:int):void {
		var old:int = type;
		super.type = value;
		if (count < 1 || value != AppearanceDefs.TAIL_TYPE_FOX) count = 1;
		if (value == AppearanceDefs.TAIL_TYPE_NONE) {
			count = 0;
			venom = 0;
		}
	}

	public function Tail(creature:Creature) {
		super(creature,"tail",["count","venom","recharge"]);
	}

	public function isLong():Boolean {
		if (creature.isNaga()) return true;
		return [
				   AppearanceDefs.TAIL_TYPE_DOG, AppearanceDefs.TAIL_TYPE_DEMONIC, AppearanceDefs.TAIL_TYPE_COW, AppearanceDefs.TAIL_TYPE_SHARK, AppearanceDefs.TAIL_TYPE_CAT,
				   AppearanceDefs.TAIL_TYPE_LIZARD, AppearanceDefs.TAIL_TYPE_KANGAROO, AppearanceDefs.TAIL_TYPE_FOX, AppearanceDefs.TAIL_TYPE_DRACONIC,
				   AppearanceDefs.TAIL_TYPE_RACCOON, AppearanceDefs.TAIL_TYPE_MOUSE, AppearanceDefs.TAIL_TYPE_FERRET, AppearanceDefs.TAIL_TYPE_BEHEMOTH, AppearanceDefs.TAIL_TYPE_SCORPION,
				   AppearanceDefs.TAIL_TYPE_WOLF
			   ].indexOf(type) >= 0;

	}

	override protected function loadFromOldSave(savedata:Object):void {
		count = savedata.tailCount || savedata.tailVenum;
		venom = savedata.tailVenum;
		recharge = savedata.tailRecharge;
		type = savedata.tailType;
	}
	override protected function saveToOldSave(savedata:Object):void {
		savedata.tailVenum = type == AppearanceDefs.TAIL_TYPE_FOX ? count : venom;
		savedata.tailRecharge = recharge;
		savedata.tailType = type;
	}

}
}
