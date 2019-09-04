/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class Tail extends SaveableBodyPart {

	// A number of tails; legacy version used venom for counting
	public var count:int       = 0;
	//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
	public var venom:Number    = 0;
	//Tail recharge determines how fast venom/webs comes back per hour.
	public var recharge:Number = 5;
	
	public static const NONE:int                = 0;
	public static const HORSE:int               = 1;
	public static const DOG:int                 = 2;
	public static const DEMONIC:int             = 3;
	public static const COW:int                 = 4;
	public static const SPIDER_ADBOMEN:int      = 5;
	public static const BEE_ABDOMEN:int         = 6;
	public static const SHARK:int               = 7;
	public static const CAT:int                 = 8;
	public static const LIZARD:int              = 9;
	public static const RABBIT:int              = 10;
	public static const HARPY:int               = 11;
	public static const KANGAROO:int            = 12;
	public static const FOX:int                 = 13;//button 0 on 2nd page of metamorph
	public static const DRACONIC:int            = 14;
	public static const RACCOON:int             = 15;
	public static const MOUSE:int               = 16;
	public static const FERRET:int              = 17;
	public static const BEHEMOTH:int            = 18;
	public static const PIG:int                 = 19;//button 0 on 3rd page of metamorph
	public static const SCORPION:int            = 20;
	public static const GOAT:int                = 21;
	public static const RHINO:int               = 22;
	public static const ECHIDNA:int             = 23;
	public static const DEER:int                = 24;
	public static const SALAMANDER:int          = 25;
	public static const KITSHOO:int             = 26;//button 0 on 4th page of metamorph for 8th kitshoo tail
	public static const MANTIS_ABDOMEN:int      = 27;
	public static const MANTICORE_PUSSYTAIL:int = 28;
	public static const WOLF:int                = 29;
	public static const GARGOYLE:int            = 30;
	public static const ORCA:int                = 31;
	public static const YGGDRASIL:int           = 32;
	public static const RAIJU:int               = 33;
	public static const RED_PANDA:int           = 34;
	public static const GARGOYLE_2:int          = 35;
	public static const AVIAN:int          		= 36;
	public static const GRIFFIN:int          	= 37;
	public static const LION:int                = 38;
	public static const BURNING:int             = 39;//button 0 on 5th page of metamorph
	public static const NEKOMATA_FORKED_1_3:int = 40;
	public static const NEKOMATA_FORKED_2_3:int = 41;
	public static const CAVE_WYRM:int           = 42;
	public static const HINEZUMI:int			= 43;
	public static const THUNDERBIRD:int			= 44;
	public static const BEAR:int				= 45;
	// Don't forget to add new types in DebugMenu.as list TAIL_TYPE_CONSTANTS

	override public function set type(value:int):void {
		var old:int = type;
		super.type = value;
		if (count < 1 || value != FOX) count = 1;
		if (value == NONE) {
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
			DOG, DEMONIC, COW, SHARK, CAT,
			LIZARD, KANGAROO, FOX, DRACONIC,
			RACCOON, MOUSE, FERRET, BEHEMOTH, SCORPION,
			SALAMANDER, WOLF, LION, BURNING, CAVE_WYRM
			   ].indexOf(type) >= 0;

	}

	override protected function loadFromOldSave(savedata:Object):void {
		count = savedata.tailCount || savedata.tailVenum;
		venom = savedata.tailVenum;
		recharge = savedata.tailRecharge;
		type = savedata.tailType;
	}
	override protected function saveToOldSave(savedata:Object):void {
		savedata.tailVenum = type == FOX ? count : venom;
		savedata.tailRecharge = recharge;
		savedata.tailType = type;
	}

}
}
