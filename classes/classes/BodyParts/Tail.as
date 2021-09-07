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
	 *
	 * - appearanceDesc: description for PlayerAppearance.as
	 * - appearanceDescFunc: a function that returns a description for PlayerAppearance.as (appearanceDesc is ignored if this exists)
	 *
	 * - draconic: part counts as "dragon or variant"
	 *
	 * - stinger: whether part has a stringer
	 * - tailSlam: whether part enables tail slam
	 * - isLong: Wwhether the tail is long
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const NONE: int = 0;
	EnumValue.add(Types, NONE, "NONE", {
		name:"non-existant",
		appearanceDesc: ""
	});
	public static const HORSE: int = 1;
	EnumValue.add(Types, HORSE, "HORSE", {
		name:"horse",
		appearanceDesc: "A long [skin coat.color] horse tail hangs from your [butt], smooth and shiny."
	});
	public static const DOG: int = 2;
	EnumValue.add(Types, DOG, "DOG", {
		name:"dog",
		appearanceDesc: "A fuzzy [skin coat.color] dog tail sprouts just above your [butt], wagging to and fro whenever you're happy.",
		isLong: true
	});
	public static const DEMONIC: int = 3;
	EnumValue.add(Types, DEMONIC, "DEMONIC", {
		name:"demonic",
		appearanceDesc: "A narrow tail ending in a spaded tip curls down from your [butt], wrapping around your [leg] sensually at every opportunity.",
		isLong: true
	});
	public static const COW: int = 4;
	EnumValue.add(Types, COW, "COW", {
		name:"cow",
		appearanceDesc: "A long cow tail with a puffy tip swishes back and forth, as if swatting at flies.",
		isLong: true
	});
	public static const SPIDER_ADBOMEN: int = 5;
	EnumValue.add(Types, SPIDER_ADBOMEN, "SPIDER_ADBOMEN", {
		name:"spider abdomen",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "A large, spherical spider abdomen has grown out from your backside, covered in shiny [skin coat.color] chitin. Though it's heavy and bobs with every motion, it doesn't seem to slow you down."

			if (player.tailVenom > (player.maxVenom() * 0.5) && player.tailVenom < (player.maxVenom() * 0.8)) {
				desc += " Your bulging arachnid posterior feels fairly full of webbing.";
			} else if (player.tailVenom >= (player.maxVenom() * 0.8) && player.tailVenom < player.maxVenom()) {
				desc += " Your arachnid rear bulges and feels very full of webbing.";
			} else if (player.tailVenom == player.maxVenom()) {
				desc += " Your swollen spider-butt is distended with the sheer amount of webbing it's holding.";
			}

			return desc;
		}
	});
	public static const BEE_ABDOMEN: int = 6;
	EnumValue.add(Types, BEE_ABDOMEN, "BEE_ABDOMEN", {
		name:"bee abdomen",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "A large bee abdomen dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard chitin with black and yellow stripes, and tipped with a dagger-like stinger."

			if (player.tailVenom > (player.maxVenom() * 0.5) && player.tailVenom < (player.maxVenom() * 0.8)) {
				desc += " A single drop of poison hangs from your exposed stinger.";
			} else if (player.tailVenom >= (player.maxVenom() * 0.8) && player.tailVenom < player.maxVenom()) {
				desc += " Poisonous bee venom coats your stinger completely.";
			} else if (player.tailVenom == player.maxVenom()) {
				desc += " Venom drips from your poisoned stinger regularly.";
			}

			return desc;
		},
		stinger: true
	});
	public static const SHARK: int = 7;
	EnumValue.add(Types, SHARK, "SHARK", {
		name:"shark",
		appearanceDesc: "A long shark tail trails down from your backside, swaying to and fro while giving you a dangerous air.",
		tailSlam: true,
		isLong: true
	});
	public static const CAT: int = 8;
	EnumValue.add(Types, CAT, "CAT", {
		name:"cat",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "A soft [skin coat.color] cat tail sprouts just above your [butt], curling and twisting with every step to maintain perfect balance."

			if (player.tailCount == 2) {
				desc = "A pair of soft [skin coat.color] cat tails sprout just above your [butt], curling and twisting with every step to maintain perfect balance."
			}

			return desc;
		},
		isLong: true
	});
	public static const LIZARD: int = 9;
	EnumValue.add(Types, LIZARD, "LIZARD", {
		name:"lizard",
		appearanceDesc: "A tapered tail hangs down from just above your [butt]. It sways back and forth, assisting you in keeping your balance.",
		tailSlam: true,
		isLong: true
	});
	public static const RABBIT: int = 10;
	EnumValue.add(Types, RABBIT, "RABBIT", {
		name:"rabbit",
		appearanceDesc: "A short, soft bunny tail sprouts just above your [butt], twitching constantly even when you don't think about it."
	});
	public static const HARPY: int = 11;
	EnumValue.add(Types, HARPY, "HARPY", {
		name:"harpy",
		appearanceDesc: "A tail of feathers fans out from just above your [butt], twitching instinctively to help guide you if you were to take flight."
	});
	public static const KANGAROO: int = 12;
	EnumValue.add(Types, KANGAROO, "KANGAROO", {
		name:"kangaroo",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "A conical, ";

			if (player.hasFur()) {
				desc += "furry, and [skin coat.color] ";
			} else {
				desc += "gooey, and [skintone] ";
			}
			desc += "tail extends from your [butt], bouncing up and down as you move to assist in your balance.";
		},
		isLong: true
	});
	public static const FOX: int = 13;
	EnumValue.add(Types, FOX, "FOX", {
		name:"fox",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "A swishing [skin coat.color] fox brush extends from your [butt], curling around your body; the soft fur feels lovely, and you wonder how many would be enticed by it."

			if (player.tailCount > 1) {
				desc = "[TailCount] swishing [skin coat.color] fox tails extend from your [butt], curling around your body; the soft fur feels lovely, and you wonder how many would be enticed by it."
			}

			return desc;
		},
		isLong: true
	});
	public static const DRACONIC: int = 14;
	EnumValue.add(Types, DRACONIC, "DRACONIC", {
		name:"draconic",
		appearanceDesc: "A thin, scaly, prehensile reptilian tail, almost as long as you are tall, swings behind you like a living bullwhip. The end of its tip is equipped with spikes of bone, meant to deliver painful blows.",
		draconic: true,
		tailSlam: true,
		isLong: true
	});
	public static const RACCOON: int = 15;
	EnumValue.add(Types, RACCOON, "RACCOON", {
		name:"raccoon",
		appearanceDesc: "A black-and-[skin coat.color]-ringed raccoon tail waves behind you.",
		isLong: true
	});
	public static const MOUSE: int = 16;
	EnumValue.add(Types, MOUSE, "MOUSE", {
		name:"mouse",
		appearanceDesc: "A naked, [skintone] mouse tail pokes from your butt, dragging on the ground and twitching occasionally.",
		isLong: true
	});
	public static const FERRET: int = 17;
	EnumValue.add(Types, FERRET, "FERRET", {
		name:"ferret",
		appearanceDesc: "",
		isLong: true
	});
	public static const BEHEMOTH: int = 18;
	EnumValue.add(Types, BEHEMOTH, "BEHEMOTH", {
		name:"behemoth",
		appearanceDesc: "A long, seemingly tapering behemoth tail pokes from your butt, ending in spikes.",
		tailSlam: true,
		isLong: true
	});
	public static const PIG: int = 19;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, PIG, "PIG", {
		name:"pig",
		appearanceDesc: "A short, curly pig tail sprouts from just above your butt."
	});
	public static const SCORPION: int = 20;
	EnumValue.add(Types, SCORPION, "SCORPION", {
		name:"scorpion",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "A large insectile scorpion tail dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard chitin and tipped with a stinger."

			if (player.tailVenom > (player.maxVenom() * 0.5) && player.tailVenom < (player.maxVenom() * 0.8)) {
				desc += "A single drop of poison hangs from your exposed stinger.";
			} else if (player.tailVenom >= (player.maxVenom() * 0.8) && player.tailVenom < player.maxVenom()) {
				desc += "Poisonous bee venom coats your stinger completely.";
			} else if (player.tailVenom == player.maxVenom()) {
				desc += "Venom drips from your poisoned stinger regularly.";
			}

			return desc;
		},
		stinger: true,
		isLong: true
	});
	public static const GOAT: int = 21;
	EnumValue.add(Types, GOAT, "GOAT", {
		name:"goat",
		appearanceDesc: "A stubby goat tail sprouts from just above your butt."
	});
	public static const RHINO: int = 22;
	EnumValue.add(Types, RHINO, "RHINO", {
		name:"rhino",
		appearanceDesc: "A ropey rhino tail sprouts from just above your butt, swishing from time to time."
	});
	public static const ECHIDNA: int = 23;
	EnumValue.add(Types, ECHIDNA, "ECHIDNA", {
		name:"echidna",
		appearanceDesc: "A stumpy echidna tail forms just above your [butt]."
	});
	public static const DEER: int = 24;
	EnumValue.add(Types, DEER, "DEER", {
		name:"deer",
		appearanceDesc: "A stubby deer tail sprouts from just above your butt."
	});
	public static const SALAMANDER: int = 25;
	EnumValue.add(Types, SALAMANDER, "SALAMANDER", {
		name:"salamander",
		appearanceDesc: "A tapered tail covered in red scales hangs down from just above your [butt]. It sways back and forth, improving your balance, and you can set it ablaze in red-hot fire whenever you want.",
		tailSlam: true,
		isLong: true
	});
	public static const KITSHOO: int = 26;
	EnumValue.add(Types, KITSHOO, "KITSHOO", {
		name:"kitshoo",
		appearanceDesc: ""
	});
	public static const MANTIS_ABDOMEN: int = 27;
	EnumValue.add(Types, MANTIS_ABDOMEN, "MANTIS_ABDOMEN", {
		name:"mantis abdomen",
		appearanceDesc: "A large insectile mantis abdomen dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard [skin coat.color] chitinous material."
	});
	public static const MANTICORE_PUSSYTAIL: int = 28;
	EnumValue.add(Types, MANTICORE_PUSSYTAIL, "MANTICORE_PUSSYTAIL", {
		name:"manticore pussytail",
		appearanceDesc: "Your tail is covered in armored chitin from the base to the tip, ending in a flower-like bulb. You can open and close your tail tip at will, and its pussy-like interior can be used to milk male organs. The deadly set of spikes covering the tip regularly drips with your potent venom. When impaling your tail spikes in a prey isn’t enough, you can fling them at a target with a precision matching a talented archer.",
		stinger: true
	});
	public static const WOLF: int = 29;
	EnumValue.add(Types, WOLF, "WOLF", {
		name:"wolf",
		appearanceDesc: "A bushy [skin coat.color] wolf tail sprouts just above your [butt], wagging to and fro whenever you are happy.",
		isLong: true
	});
	public static const GARGOYLE: int = 30;
	EnumValue.add(Types, GARGOYLE, "GARGOYLE", {
		name:"mace-shaped gargoyle",
		appearanceDesc: "A long spiked tail hangs down from just above your [butt]. It sways back and forth, improving your balance.",
		tailSlam: true
	});
	public static const ORCA: int = 31;
	EnumValue.add(Types, ORCA, "ORCA", {
		name:"orca",
		appearanceDesc: "A long, powerful orca tail trails down from your backside, swaying to and fro, always ready to propulse you through the water or smack an opponent on the head. It has a huge fin at the end, and a smaller one not so far from your ass.",
		draconic: true,
		tailSlam: true
	});
	public static const YGGDRASIL: int = 32;
	EnumValue.add(Types, YGGDRASIL, "YGGDRASIL", {
		name:"yggdrasil",
		appearanceDesc: "A thin, prehensile reptilian tail swings behind you, covered in [skin coat]. Adorning its tip is a leaf, bobbing with each of your tail's movements."
	});
	public static const RAIJU: int = 33;
	EnumValue.add(Types, RAIJU, "RAIJU", {
		name:"raiju",
		appearanceDesc: "Your silky tail extends out from just above your [butt]. Its fur is lovely to the touch and glows with lightning at the tip.",
		energy: true
	});
	public static const RED_PANDA: int = 34;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
		name:"red-panda",
		appearanceDesc: "Sprouting from your [ass] is a long, bushy tail adorned by a beautiful pattern of [skin coat.color] rings. It waves playfully as you walk, giving your step a mesmerizing touch."
	});
	public static const GARGOYLE_2: int = 35;
	EnumValue.add(Types, GARGOYLE_2, "GARGOYLE_2", {
		name:"axe-shaped gargoyle",
		appearanceDesc: "A long tail ending with an axe blade on both sides hangs down from just above your [butt]. It sways back and forth, improving your balance.",
		tailSlam: true
	});
	public static const AVIAN: int = 36;
	EnumValue.add(Types, AVIAN, "AVIAN", {
		name:"avian",
		appearanceDesc: "A fan-like tail made of [skin coat.color] feathers rests above your [butt], twitching instinctively to help guide you if you were to take flight."
	});
	public static const GRIFFIN: int = 37;
	EnumValue.add(Types, GRIFFIN, "GRIFFIN", {
		name:"griffin",
		appearanceDesc: "From your backside hangs a long tail, leonine in shape and covered mostly by a layer of [skin coat.color2] fur, featuring a tip made of a tuft of [skin coat.color] feathers. It moves sinuously as you walk."
	});
	public static const LION: int = 38;
	EnumValue.add(Types, LION, "LION", {
		name:"lion",
		appearanceDesc: "A soft [skin coat.color] lion tail sprouts just above your [butt], curling and twisting with every step to maintain perfect balance. It ends in a small puffy hair.",
		isLong: true
	});
	public static const BURNING: int = 39;
	EnumValue.add(Types, BURNING, "BURNING", {
		name:"burning",
		appearanceDesc: "A blazing cat tail pokes out from your [butt]. It has a tendency to light things on fire if you are not careful, but at least it assists with your balance.",
		isLong: true
	});
	public static const NEKOMATA_FORKED_1_3: int = 40;
	EnumValue.add(Types, NEKOMATA_FORKED_1_3, "NEKOMATA_FORKED_1_3", {
		name:"forked cat",
		appearanceDesc: "A soft [skin coat.color] cat-tail, forked on its one-third length, sprouts just above your [butt], curling and twisting with every step to maintain perfect balance."
	});
	public static const NEKOMATA_FORKED_2_3: int = 41;
	EnumValue.add(Types, NEKOMATA_FORKED_2_3, "NEKOMATA_FORKED_2_3", {
		name:"forked cat",
		appearanceDesc: "A soft [skin coat.color] cat-tail, forked on its two-thirds length, sprouts just above your [butt], curling and twisting with every step to maintain perfect balance."
	});
	public static const CAVE_WYRM: int = 42;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
		name:"cave wyrm",
		appearanceDesc: "A large newt tail trails down from your [butt], tapering on the ground behind you. While it is heavy and plump, it allows you to swim underwater like a fish, if necessary.",
		tailSlam: true,
		isLong: true
	});
	public static const HINEZUMI: int = 43;
	EnumValue.add(Types, HINEZUMI, "HINEZUMI", {
		name:"hinezumi",
		appearanceDesc: "A blazing, [skintone] mouse tail pokes out from your [butt]. It has a tendency to light things on fire if you are not careful."
	});
	public static const THUNDERBIRD: int = 44;
	EnumValue.add(Types, THUNDERBIRD, "THUNDERBIRD", {
		name:"thunderbird",
		appearanceDesc: "From just above your [butt] extends a long thin sinuous tail, tipped with feathers shaped like a lightning bolt.",
		energy: true
	});
	public static const BEAR: int = 45;
	EnumValue.add(Types, BEAR, "BEAR", {
		name:"bear",
		appearanceDesc: "A cute, furry ursan tail sits up from your backside."
	});
	public static const TWINKASHA: int = 46;
	EnumValue.add(Types, TWINKASHA, "TWINKASHA", {
		name:"twinkasha",
		appearanceDesc: "A pair blazing cat tail pokes out from your [butt]. They have a tendency to light things on fire if you are not careful, but at least they assist with your balance. From these tails you draw in tremendous fell power."
	});
	public static const USHI_ONI: int = 47;
	EnumValue.add(Types, USHI_ONI, "USHI_ONI", {
		name:"ushi-oni",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "You have an ushi-oni tail whose furred member is " + (player.tallness > 72 ? "five" : "four") + " feet long and prehensile. Its tip can shoot very thick and strong web strings which double as an aphrodisiac when in contact with the victim.";

			return desc;
		}
	});
	public static const WEASEL: int = 48;
	EnumValue.add(Types, WEASEL, "WEASEL", {
		name:"weasel",
		appearanceDesc: "Your short, silky weasel tail extends out from just above your [butt]. Its fur is lovely to the touch."
	});
	public static const SQUIRREL: int = 49;
	EnumValue.add(Types, SQUIRREL, "SQUIRREL", {
		name:"squirrel",
		appearanceDesc: "From your back sprouts a furry, striped squirrel tail that curves upwards."
	});
	public static const MONKEY: int = 50;
	EnumValue.add(Types, MONKEY, "MONKEY", {
		name:"monkey",
		appearanceDesc: ""
	});
	public static const WENDIGO: int = 51;
	EnumValue.add(Types, WENDIGO, "WENDIGO", {
		name:"wendigo",
		appearanceDesc: "Your silky tail extends out from just above your [butt]. Its fur is lovely to the touch and warm, and it protects you well against the cold."
	});

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

		return Types[type].isLong || false;
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

	public static function getAppearanceDescription(player: *):String {
		const id: int = player.tailType;

		return formatDescription((Types[id].appearanceDescFunc? Types[id].appearanceDescFunc(player) : Types[id].appearanceDesc) || "", player);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;
		const legCountPattern:RegExp = /{legCount}/g;
		const legCountMinusTwoPattern:RegExp = /{legCountMinusTwo}/g;

		return desc
			.replace(legCountPattern, num2Text(creature.legCount))
			.replace(legCountMinusTwoPattern, num2Text(creature.legCount - 2))
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}

	public static function hasDraconicTail(creature: *):Boolean {
		const id: int = creature.tailType;

		return Types[id].draconic || false;
	}
}
}
