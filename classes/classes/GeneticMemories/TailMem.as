package classes.GeneticMemories {
import classes.BaseContent;
import classes.internals.EnumValue;
import classes.Transformations.Transformation;
import classes.CoC;

	public class TailMem extends BaseContent {
	/**
	 * Entry properties:
	 * - id: the identificator of the Metamorph inside GeneticStorage
	 * - name: how the Metamorph is referred to in displayed texts
	 * - cost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - title: name displayed on the metamorph button
	 * - unlockText: additional text displayed when Metamorph is unlocked
	 * - transformation: TF object that refers to what the metamorph does
	 *
	 * Optional properties:
	 * - info: additional text to be shown underneath the Metamorph cost in the menu when hovering over a button
	 * - lockedInfo: additional text to be shown on *locked* Metamorphs when hovering over a button
	 * - permCost: how many Ascension Perk Points it costs to permanentize this Metamorph, defaults to 5 if not added
	 * - permReq: the ID of another Metamorph which must be permanentized first before the current one can be bought

	 * Template:

		public static const [NAME HERE]:int = [ID HERE];
		EnumValue.add(Memories, [NAME HERE], "[NAME HERE]", {
			id: [Name Saved in GeneticStorage],
			name: [Name Displayed in Texts],
			cost: [Cost Here],
			title: [Race Here],
			unlockText: [Text Displayed On Unlocking Metamorph Here],
			transformation: function(): Transformation {
				return CoC.instance.transformations.[TF Object from TransformationLib];
			}
		});

	 */

    public static var Memories:/*EnumValue*/ Array = [];
	private static var _partid:int = 0;

		public static const NONE:int = _partid++;
		EnumValue.add(Memories, NONE, "NONE", {
			id: "Unlocked Metamorph",
			name: "No Tail",
			cost: 500,
			title: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailNone;
			}
		});

		public static const ANT_ABDOMEN:int = _partid++;
		EnumValue.add(Memories, ANT_ABDOMEN, "ANT_ABDOMEN", {
			id: "Ant Tail",
			name: "Ant Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Ant",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailAnt;
			}
		});

		public static const ATLACH_SPIDER_ADBOMEN:int = _partid++;
		EnumValue.add(Memories, ATLACH_SPIDER_ADBOMEN, "ATLACH_SPIDER_ADBOMEN", {
			id: "SpinneretAtlach Tail",
			name: "SpinneretAtlach Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "SpinneretAtlach",
			info: "Add a SpinneretAtlach tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailSpinneretAtlach;
			}
		});

		public static const AVIAN:int = _partid++;
		EnumValue.add(Memories, AVIAN, "AVIAN", {
			id: "Avian Tail",
			name: "Avian Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Avian",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailAvian;
			}
		});

		public static const AZAZEL:int = _partid++;
		EnumValue.add(Memories, AZAZEL, "AZAZEL", {
			id: "Azazel Tail",
			name: "Azazel Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Azazel",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailAzazel;
			}
		});

		public static const BEE_ABDOMEN:int = _partid++;
		EnumValue.add(Memories, BEE_ABDOMEN, "BEE_ABDOMEN", {
			id: "Bee Tail",
			name: "Bee Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Bee",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailBee;
			}
		});

		public static const BEAR:int = _partid++;
		EnumValue.add(Memories, BEAR, "BEAR", {
			id: "Bear Tail",
			name: "Bear Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Bear",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailBear;
			}
		});

		public static const BURNING:int = _partid++;
		EnumValue.add(Memories, BURNING, "BURNING", {
			id: "Burning Tail",
			name: "Burning Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Burning",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailBurning;
			}
		});

		public static const CAT:int = _partid++;
		EnumValue.add(Memories, CAT, "CAT", {
			id: "Cat Tail",
			name: "Cat Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailCat;
			}
		});

		public static const CAT_2:int = _partid++;
		EnumValue.add(Memories, CAT_2, "CAT_2", {
			id: "Cat 2nd Tail",
			name: "2nd Cat Tail (Nekomata)",
			cost: function():Number { return getTailCost(player.tailCount, 4);},
			title: "Cat 2nd",
			permReq: "Forked 2/3 Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailCat2nd;
			}
		});

		public static const CAVE_WYRM:int = _partid++;
		EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
			id: "Cave Wyrm Tail",
			name: "Cave Wyrm Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Cave Wyrm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailCaveWyrm;
			}
		});

		public static const COW:int = _partid++;
		EnumValue.add(Memories, COW, "COW", {
			id: "Cow Tail",
			name: "Cow Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Cow",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailCow;
			}
		});

		public static const DEMONIC:int = _partid++;
		EnumValue.add(Memories, DEMONIC, "DEMONIC", {
			id: "Demon Tail",
			name: "Demon Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Demon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailDemonic;
			}
		});

		public static const DEER:int = _partid++;
		EnumValue.add(Memories, DEER, "DEER", {
			id: "Deer Tail",
			name: "Deer Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Deer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailDeer;
			}
		});

		public static const DOG:int = _partid++;
		EnumValue.add(Memories, DOG, "DOG", {
			id: "Dog Tail",
			name: "Dog Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Dog",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailDog;
			}
		});

		public static const DRACONIC:int = _partid++;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			id: "Draconic Tail",
			name: "Draconic Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Draconic",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailDraconic;
			}
		});

		public static const FEY_DRACONIC:int = _partid++;
		EnumValue.add(Memories, FEY_DRACONIC, "FEY_DRACONIC", {
			id: "Fey Draconic Tail",
			name: "Fey Draconic Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Fey Draconic",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFeyDraconic;
			}
		});

		public static const FERRET:int = _partid++;
		EnumValue.add(Memories, FERRET, "FERRET", {
			id: "Ferret Tail",
			name: "Ferret Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Ferret",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFerret;
			}
		});

		public static const FOX:int = _partid++;
		EnumValue.add(Memories, FOX, "FOX", {
			id: "Fox Tail",
			name: "Fox Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(1);
			}
		});

		public static const FOX_2:int = _partid++;
		EnumValue.add(Memories, FOX_2, "FOX_2", {
			id: "Fox 2nd Tail",
			name: "2nd Fox Tail",
			cost: function():Number { return getTailCost(player.tailCount, 2);},
			title: "Fox 2nd",
			permReq: "Fox Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(2);
			}
		});

		public static const FOX_3:int = _partid++;
		EnumValue.add(Memories, FOX_3, "FOX_3", {
			id: "Fox 3rd Tail",
			name: "3rd Fox Tail",
			cost: function():Number { return getTailCost(player.tailCount, 3);},
			title: "Fox 3rd",
			permReq: "Fox 2nd Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(3);
			}
		});

		public static const FOX_4:int = _partid++;
		EnumValue.add(Memories, FOX_4, "FOX_4", {
			id: "Fox 4th Tail",
			name: "4th Fox Tail",
			cost: function():Number { return getTailCost(player.tailCount, 4);},
			title: "Fox 4th",
			permReq: "Fox 3rd Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(4);
			}
		});

		public static const FOX_5:int = _partid++;
		EnumValue.add(Memories, FOX_5, "FOX_5", {
			id: "Fox 5th Tail",
			name: "5th Fox Tail",
			cost: function():Number { return getTailCost(player.tailCount, 5);},
			title: "Fox 5th",
			permReq: "Fox 4th Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(5);
			}
		});

		public static const FOX_6:int = _partid++;
		EnumValue.add(Memories, FOX_6, "FOX_6", {
			id: "Fox 6th Tail",
			name: "6th Fox Tail",
			cost: function():Number { return getTailCost(player.tailCount, 6);},
			title: "Fox 6th",
			permReq: "Fox 5th Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(6);
			}
		});

		public static const FOX_7:int = _partid++;
		EnumValue.add(Memories, FOX_7, "FOX_7", {
			id: "Fox 7th Tail",
			name: "7th Fox Tail",
			cost: function():Number { return getTailCost(player.tailCount, 7);},
			title: "Fox 7th",
			permReq: "Fox 6th Tail",
			lockedInfo: "Requires Perk: Nine-tails Kitsune of Balance",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(7);
			}
		});

		public static const FOX_8:int = _partid++;
		EnumValue.add(Memories, FOX_8, "FOX_8", {
			id: "Fox 8th Tail",
			name: "8th Fox Tail",
			cost: function():Number { return getTailCost(player.tailCount, 8);},
			title: "Fox 8th",
			permReq: "Fox 7th Tail",
			lockedInfo: "Requires Perk: Nine-tails Kitsune of Balance",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(8);
			}
		});

		public static const FOX_9:int = _partid++;
		EnumValue.add(Memories, FOX_9, "FOX_9", {
			id: "Fox 9th Tail",
			name: "9th Fox Tail",
			cost: function():Number { return getTailCost(player.tailCount, 9);},
			title: "Fox 9th",
			permReq: "Fox 8th Tail",
			lockedInfo: "Requires Perk: Nine-tails Kitsune of Balance",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(9);
			}
		});

		public static const GOAT:int = _partid++;
		EnumValue.add(Memories, GOAT, "GOAT", {
			id: "Goat Tail",
			name: "Goat Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Goat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailGoat;
			}
		});

		public static const GRIFFIN:int = _partid++;
		EnumValue.add(Memories, GRIFFIN, "GRIFFIN", {
			id: "Griffin Tail",
			name: "Griffin Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Griffin",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailGriffin;
			}
		});

		public static const HARPY:int = _partid++;
		EnumValue.add(Memories, HARPY, "HARPY", {
			id: "Harpy Tail",
			name: "Harpy Feather Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Harpy",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailHarpy;
			}
		});

		public static const HINEZUMI:int = _partid++;
		EnumValue.add(Memories, HINEZUMI, "HINEZUMI", {
			id: "Hinezumi Tail",
			name: "Hinezumi Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Hinezumi",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailHinezumi;
			}
		});

		public static const HORSE:int = _partid++;
		EnumValue.add(Memories, HORSE, "HORSE", {
			id: "Horse Tail",
			name: "Horse Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Horse",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailHorse;
			}
		});

		public static const HYDRA:int = _partid++;
		EnumValue.add(Memories, HYDRA, "HYDRA", {
			id: "Hydra Lower Body",
			name: "Hydra Tail",
			cost: 200,
			title: "Hydra",
			hint: "You need a hydra lower body and less than 12 Hydra tails",
			info: "Add a Hydra tail-head",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailHydra;
			}
		});

		public static const KANGAROO:int = _partid++;
		EnumValue.add(Memories, KANGAROO, "KANGAROO", {
			id: "Kangaroo Tail",
			name: "Kangaroo Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Kangaroo",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailKangaroo;
			}
		});

		public static const KIRIN:int = _partid++;
		EnumValue.add(Memories, KIRIN, "KIRIN", {
			id: "Kirin Tail",
			name: "Kirin Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Kirin",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailKirin;
			}
		});

		public static const KITSHOO:int = _partid++;
		EnumValue.add(Memories, KITSHOO, "KITSHOO", {
			id: "Kitshoo Tail",
			name: "Kitsumori Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Kitsumori",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailKitshoo(1);
			}
		});

		public static const KITSHOO_2:int = _partid++;
		EnumValue.add(Memories, KITSHOO_2, "KITSHOO_2", {
			id: "Kitshoo 2nd Tail",
			name: "2nd Kitsumori Tail",
			cost: function():Number { return getTailCost(player.tailCount, 2);},
			title: "Kitsumori 2nd",
			permReq: "Kitshoo Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailKitshoo(2);
			}
		});

		public static const KITSHOO_3:int = _partid++;
		EnumValue.add(Memories, KITSHOO_3, "KITSHOO_3", {
			id: "Kitshoo 3rd Tail",
			name: "3rd Kitsumori Tail",
			cost: function():Number { return getTailCost(player.tailCount, 3);},
			title: "Kitsumori 3rd",
			permReq: "Kitshoo 2nd Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailKitshoo(3);
			}
		});

		public static const KITSHOO_4:int = _partid++;
		EnumValue.add(Memories, KITSHOO_4, "KITSHOO_4", {
			id: "Kitshoo 4th Tail",
			name: "4th Kitsumori Tail",
			cost: function():Number { return getTailCost(player.tailCount, 4);},
			title: "Kitsumori 4th",
			permReq: "Kitshoo 3rd Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailKitshoo(4);
			}
		});

		public static const KITSHOO_5:int = _partid++;
		EnumValue.add(Memories, KITSHOO_5, "KITSHOO_5", {
			id: "Kitshoo 5th Tail",
			name: "5th Kitsumori Tail",
			cost: function():Number { return getTailCost(player.tailCount, 5);},
			title: "Kitsumori 5th",
			permReq: "Kitshoo 4th Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailKitshoo(5);
			}
		});

		public static const KITSHOO_6:int = _partid++;
		EnumValue.add(Memories, KITSHOO_6, "KITSHOO_6", {
			id: "Kitshoo 6th Tail",
			name: "6th Kitsumori Tail",
			cost: function():Number { return getTailCost(player.tailCount, 6);},
			title: "Kitsumori 6th",
			permReq: "Kitshoo 5th Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailKitshoo(6);
			}
		});

		public static const KITSHOO_7:int = _partid++;
		EnumValue.add(Memories, KITSHOO_7, "KITSHOO_7", {
			id: "Kitshoo 7th Tail",
			name: "7th Kitsumori Tail",
			cost: function():Number { return getTailCost(player.tailCount, 7);},
			title: "Kitsumori 7th",
			permReq: "Kitshoo 6th Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailKitshoo(7);
			}
		});

		public static const KITSHOO_8:int = _partid++;
		EnumValue.add(Memories, KITSHOO_8, "KITSHOO_8", {
			id: "Kitshoo 8th Tail",
			name: "8th Kitsumori Tail",
			cost: function():Number { return getTailCost(player.tailCount, 8);},
			title: "Kitsumori 8th",
			permReq: "Kitshoo 7th Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailKitshoo(8);
			}
		});

		public static const KITSHOO_9:int = _partid++;
		EnumValue.add(Memories, KITSHOO_9, "KITSHOO_9", {
			id: "Kitshoo 9th Tail",
			name: "9th Kitsumori Tail",
			cost: function():Number { return getTailCost(player.tailCount, 9);},
			title: "Kitsumori 9th",
			permReq: "Kitshoo 8th Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailKitshoo(9);
			}
		});

		public static const LIZARD:int = _partid++;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			id: "Lizard Tail",
			name: "Lizard Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Lizard",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailLizard;
			}
		});

		public static const MANTICORE:int = _partid++;
		EnumValue.add(Memories, MANTICORE, "MANTICORE", {
			id: "Manticore Tail",
			name: "Manticore Pussytail",
			cost: 200,
			title: "Manticore",
			permReq: "Scorpion Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailManticore;
			}
		});

		public static const MANTIS_ABDOMEN:int = _partid++;
		EnumValue.add(Memories, MANTIS_ABDOMEN, "MANTIS_ABDOMEN", {
			id: "Mantis Tail",
			name: "Mantis Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Mantis",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailMantis;
			}
		});

		public static const MOUSE:int = _partid++;
		EnumValue.add(Memories, MOUSE, "MOUSE", {
			id: "Mouse Tail",
			name: "Mouse Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Mouse",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailMouse;
			}
		});

		public static const NEKOMATA_FORKED_1_3:int = _partid++;
		EnumValue.add(Memories, NEKOMATA_FORKED_1_3, "NEKOMATA_FORKED_1_3", {
			id: "Forked 1/3 Tail",
			name: "Forked 1/3 Nekomata Tail",
			cost: function():Number { return getTailCost(player.tailCount, 2);},
			title: "Forked 1/3",
			permReq: "Cat Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailNekomataOneThirdForked;
			}
		});

		public static const NEKOMATA_FORKED_2_3:int = _partid++;
		EnumValue.add(Memories, NEKOMATA_FORKED_2_3, "NEKOMATA_FORKED_2_3", {
			id: "Forked 2/3 Tail",
			name: "Forked 2/3 Nekomata Tail",
			cost: function():Number { return getTailCost(player.tailCount, 3);},
			title: "Forked 2/3",
			permReq: "Forked 1/3 Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailNekomataTwoThirdsForked;
			}
		});

		public static const ORCA:int = _partid++;
		EnumValue.add(Memories, ORCA, "ORCA", {
			id: "Orca Tail",
			name: "Orca Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailOrca;
			}
		});

		public static const PIG:int = _partid++;
		EnumValue.add(Memories, PIG, "PIG", {
			id: "Pig Tail",
			name: "Pig Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Pig",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailPig;
			}
		});

		public static const RABBIT:int = _partid++;
		EnumValue.add(Memories, RABBIT, "RABBIT", {
			id: "Rabbit Tail",
			name: "Rabbit Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Rabbit",
			info: "Add a Rabbit tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailRabbit;
			}
		});

		public static const RACCOON:int = _partid++;
		EnumValue.add(Memories, RACCOON, "RACCOON", {
			id: "Raccoon Tail",
			name: "Raccoon Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Raccoon",
			info: "Add a Raccoon tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailRaccoon;
			}
		});

		public static const RAIJU:int = _partid++;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			id: "Raiju Tail",
			name: "Raiju Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailRaiju;
			}
		});

		public static const RED_PANDA:int = _partid++;
		EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
			id: "Red Panda Tail",
			name: "Red Panda Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Red Panda",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailRedPanda;
			}
		});

		public static const SALAMANDER:int = _partid++;
		EnumValue.add(Memories, SALAMANDER, "SALAMANDER", {
			id: "Salamander Tail",
			name: "Salamander Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Salamander",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailSalamander;
			}
		});

		public static const SCORPION:int = _partid++;
		EnumValue.add(Memories, SCORPION, "SCORPION", {
			id: "Scorpion Tail",
			name: "Scorpion Stinger",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Scorpion",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailScorpion;
			}
		});

		public static const SHARK:int = _partid++;
		EnumValue.add(Memories, SHARK, "SHARK", {
			id: "Shark Tail",
			name: "Shark Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailShark;
			}
		});

		public static const SPIDER_ADBOMEN:int = _partid++;
		EnumValue.add(Memories, SPIDER_ADBOMEN, "SPIDER_ADBOMEN", {
			id: "Spider Tail",
			name: "Spider Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Spider",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailSpider;
			}
		});

		public static const SQUIRREL:int = _partid++;
		EnumValue.add(Memories, SQUIRREL, "SQUIRREL", {
			id: "Squirrel Tail",
			name: "Squirrel Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Squirrel",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailSquirrel;
			}
		});

		public static const THUNDERBIRD:int = _partid++;
		EnumValue.add(Memories, THUNDERBIRD, "THUNDERBIRD", {
			id: "Thunderbird Tail",
			name: "Thunderbird Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Thunderbird",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailThunderbird;
			}
		});

		public static const TWINKASKA:int = _partid++;
		EnumValue.add(Memories, TWINKASKA, "TWINKASKA", {
			id: "Twin Burning Tail",
			name: "Twin Burning Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Twin Burning",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailTwinkasha;
			}
		});

		public static const USHI_ONI:int = _partid++;
		EnumValue.add(Memories, USHI_ONI, "USHI_ONI", {
			id: "Ushi Oni Tail",
			name: "Ushi Oni Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Ushi Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailUshiOni;
			}
		});

		public static const WEASEL:int = _partid++;
		EnumValue.add(Memories, WEASEL, "WEASEL", {
			id: "Weasel Tail",
			name: "Weasel Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Weasel",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailWeasel;
			}
		});

		public static const WOLF:int = _partid++;
		EnumValue.add(Memories, WOLF, "WOLF", {
			id: "Wolf Tail",
			name: "Wolf Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Wolf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailWolf;
			}
		});

		public static const YGGDRASIL:int = _partid++;
		EnumValue.add(Memories, YGGDRASIL, "YGGDRASIL", {
			id: "Ygddrasil Tail",
			name: "Ygddrasil Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Ygddrasil",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailYgddrasil;
			}
		});

		public static const ABYSSAL_SHARK:int = _partid++;
		EnumValue.add(Memories, ABYSSAL_SHARK, "ABYSSAL_SHARK", {
			id: "Abyssal Shark Tail",
			name: "A.Shark Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "A.Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailAbyssalShark;
			}
		});

		public static const TROLL:int = _partid++;
		EnumValue.add(Memories, TROLL, "TROLL", {
			id: "Troll Tail",
			name: "Troll Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "Troll",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailAbyssalShark;
			}
		});

		public static const GLACIAL_TROLL:int = _partid++;
		EnumValue.add(Memories, GLACIAL_TROLL, "GLACIAL_TROLL", {
			id: "Glacial Troll Tail",
			name: "G.Troll Tail",
			cost: function():Number { return getTailCost(player.tailCount, 1);},
			title: "G.Troll",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailAbyssalShark;
			}
		});

		public static function getTailCost(startTails:int, endTails:int):int {
			return Math.abs(startTails - endTails)*100 || 100;
		}

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
	}
}
