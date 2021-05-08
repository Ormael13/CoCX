/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

public class Tail extends SaveableBodyPart {

	// A number of tails; legacy version used venom for counting
	public var count:int       = 0;
	//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
	public var venom:Number    = 0;
	//Tail recharge determines how fast venom/webs comes back per hour.
	public var recharge:Number = 5;

	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "HORSE")
	 * - name: human-readable default name, ("non-existant", "horse")
	 * - stinger:
	 * - tailSlam:
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const NONE:int                = 0;
	EnumValue.add(Types, NONE, "NONE", {name:"non-existant"});
	public static const HORSE:int               = 1;
	EnumValue.add(Types, HORSE, "HORSE", {name:"horse"});
	public static const DOG:int                 = 2;
	EnumValue.add(Types, DOG, "DOG", {name:"dog"});
	public static const DEMONIC:int             = 3;
	EnumValue.add(Types, DEMONIC, "DEMONIC", {name:"demonic"});
	public static const COW:int                 = 4;
	EnumValue.add(Types, COW, "COW", {name:"cow"});
	public static const SPIDER_ADBOMEN:int      = 5;
	EnumValue.add(Types, SPIDER_ADBOMEN, "SPIDER_ADBOMEN", {name:"spider abdomen"});
	public static const BEE_ABDOMEN:int         = 6;
	EnumValue.add(Types, BEE_ABDOMEN, "BEE_ABDOMEN", {name:"bee abdomen", stinger: true});
	public static const SHARK:int               = 7;
	EnumValue.add(Types, SHARK, "SHARK", {name:"shark", tailSlam: true});
	public static const CAT:int                 = 8;
	EnumValue.add(Types, CAT, "CAT", {name:"cat"});
	public static const LIZARD:int              = 9;
	EnumValue.add(Types, LIZARD, "LIZARD", {name:"lizard", tailSlam: true});
	public static const RABBIT:int              = 10;
	EnumValue.add(Types, RABBIT, "RABBIT", {name:"rabbit"});
	public static const HARPY:int               = 11;
	EnumValue.add(Types, HARPY, "HARPY", {name:"harpy"});
	public static const KANGAROO:int            = 12;
	EnumValue.add(Types, KANGAROO, "KANGAROO", {name:"kangaroo"});
	public static const FOX:int                 = 13;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, FOX, "FOX", {name:"fox"});
	public static const DRACONIC:int            = 14;
	EnumValue.add(Types, DRACONIC, "DRACONIC", {name:"draconic", tailSlam: true});
	public static const RACCOON:int             = 15;
	EnumValue.add(Types, RACCOON, "RACCOON", {name:"raccoon"});
	public static const MOUSE:int               = 16;
	EnumValue.add(Types, MOUSE, "MOUSE", {name:"mouse"});
	public static const FERRET:int              = 17;
	EnumValue.add(Types, FERRET, "FERRET", {name:"ferret"});
	public static const BEHEMOTH:int            = 18;
	EnumValue.add(Types, BEHEMOTH, "BEHEMOTH", {name:"behemoth", tailSlam: true});
	public static const PIG:int                 = 19;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, PIG, "PIG", {name:"pig"});
	public static const SCORPION:int            = 20;
	EnumValue.add(Types, SCORPION, "SCORPION", {name:"scorpion", stinger: true});
	public static const GOAT:int                = 21;
	EnumValue.add(Types, GOAT, "GOAT", {name:"goat"});
	public static const RHINO:int               = 22;
	EnumValue.add(Types, RHINO, "RHINO", {name:"rhino"});
	public static const ECHIDNA:int             = 23;
	EnumValue.add(Types, ECHIDNA, "ECHIDNA", {name:"echidna"});
	public static const DEER:int                = 24;
	EnumValue.add(Types, DEER, "DEER", {name:"deer"});
	public static const SALAMANDER:int          = 25;
	EnumValue.add(Types, SALAMANDER, "SALAMANDER", {name:"salamander", tailSlam: true});
	public static const KITSHOO:int             = 26;//button 0 on 4th page of metamorph for 8th kitshoo tail
	EnumValue.add(Types, KITSHOO, "KITSHOO", {name:"kitshoo"});
	public static const MANTIS_ABDOMEN:int      = 27;
	EnumValue.add(Types, MANTIS_ABDOMEN, "MANTIS_ABDOMEN", {name:"mantis abdomen"});
	public static const MANTICORE_PUSSYTAIL:int = 28;
	EnumValue.add(Types, MANTICORE_PUSSYTAIL, "MANTICORE_PUSSYTAIL", {name:"manticore pussytail", stinger: true});
	public static const WOLF:int                = 29;
	EnumValue.add(Types, WOLF, "WOLF", {name:"wolf"});
	public static const GARGOYLE:int            = 30;
	EnumValue.add(Types, GARGOYLE, "GARGOYLE", {name:"mace-shaped gargoyle", tailSlam: true});
	public static const ORCA:int                = 31;
	EnumValue.add(Types, ORCA, "ORCA", {name:"orca", tailSlam: true});
	public static const YGGDRASIL:int           = 32;
	EnumValue.add(Types, YGGDRASIL, "YGGDRASIL", {name:"yggdrasil"});
	public static const RAIJU:int               = 33;
	EnumValue.add(Types, RAIJU, "RAIJU", {name:"raiju", energy: true});
	public static const RED_PANDA:int           = 34;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {name:"red-panda"});
	public static const GARGOYLE_2:int          = 35;
	EnumValue.add(Types, GARGOYLE_2, "GARGOYLE_2", {name:"axe-shaped gargoyle", tailSlam: true});
	public static const AVIAN:int          		= 36;
	EnumValue.add(Types, AVIAN, "AVIAN", {name:"avian"});
	public static const GRIFFIN:int          	= 37;
	EnumValue.add(Types, GRIFFIN, "GRIFFIN", {name:"griffin"});
	public static const LION:int                = 38;
	EnumValue.add(Types, LION, "LION", {name:"lion"});
	public static const BURNING:int             = 39;//button 0 on 5th page of metamorph
	EnumValue.add(Types, BURNING, "BURNING", {name:"burning"});
	public static const NEKOMATA_FORKED_1_3:int = 40;
	EnumValue.add(Types, NEKOMATA_FORKED_1_3, "NEKOMATA_FORKED_1_3", {name:"forked cat"});
	public static const NEKOMATA_FORKED_2_3:int = 41;
	EnumValue.add(Types, NEKOMATA_FORKED_2_3, "NEKOMATA_FORKED_2_3", {name:"forked cat"});
	public static const CAVE_WYRM:int           = 42;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {name:"cave wyrm", TailSlam: true});
	public static const HINEZUMI:int			= 43;
	EnumValue.add(Types, HINEZUMI, "HINEZUMI", {name:"hinezumi"});
	public static const THUNDERBIRD:int			= 44;
	EnumValue.add(Types, THUNDERBIRD, "THUNDERBIRD", {name:"thunderbird", energy: true});
	public static const BEAR:int				= 45;
	EnumValue.add(Types, BEAR, "BEAR", {name:"bear"});
	public static const TWINKASHA:int			= 46;
	EnumValue.add(Types, TWINKASHA, "TWINKASHA", {name:"twinkasha"});
	public static const USHI_ONI_ONNA:int		= 47;
	EnumValue.add(Types, USHI_ONI_ONNA, "USHI_ONI_ONNA", {name:"ushi-oni"});
	public static const WEASEL:int				= 48;
	EnumValue.add(Types, WEASEL, "WEASEL", {name:"weasel"});
	public static const SQUIRREL:int			= 49;
	EnumValue.add(Types, SQUIRREL, "SQUIRREL", {name:"squirrel"});
	public static const MONKEY:int				= 50;
	EnumValue.add(Types, MONKEY, "MONKEY", {name:"monkey"});
	public static const WENDIGO:int				= 51;
	EnumValue.add(Types, WENDIGO, "WENDIGO", {name:"wendigo"});

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
