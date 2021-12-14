package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Tail;
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

		public static const NONE:int = 0;
		EnumValue.add(Memories, NONE, "NONE", {
			id: "Unlocked Metamorph",
			name: "No Tail",
			cost: 500,
			title: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailNone;
			}
		});

		public static const HORSE:int = 1;
		EnumValue.add(Memories, HORSE, "HORSE", {
			id: "Horse Tail",
			name: "Horse Tail",
			cost: 100,
			title: "Horse",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailHorse;
			}
		});

		public static const DEMONIC:int = 2;
		EnumValue.add(Memories, DEMONIC, "DEMONIC", {
			id: "Demon Tail",
			name: "Demon Tail",
			cost: 100,
			title: "Demon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailDemonic;
			}
		});

		public static const COW:int = 3;
		EnumValue.add(Memories, COW, "COW", {
			id: "Cow Tail",
			name: "Cow Tail",
			cost: 100,
			title: "Cow",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailCow;
			}
		});

		public static const SPIDER_ADBOMEN:int = 4;
		EnumValue.add(Memories, SPIDER_ADBOMEN, "SPIDER_ADBOMEN", {
			id: "Spider Tail",
			name: "Spider Tail",
			cost: 100,
			title: "Spider",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailSpider;
			}
		});

		public static const BEE_ABDOMEN:int = 5;
		EnumValue.add(Memories, BEE_ABDOMEN, "BEE_ABDOMEN", {
			id: "Bee Tail",
			name: "Bee Tail",
			cost: 100,
			title: "Bee",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailBee;
			}
		});

		public static const SHARK:int = 6;
		EnumValue.add(Memories, SHARK, "SHARK", {
			id: "Shark Tail",
			name: "Shark Tail",
			cost: 100,
			title: "Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailShark;
			}
		});

		public static const LIZARD:int = 7;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			id: "Lizard Tail",
			name: "Lizard Tail",
			cost: 100,
			title: "Lizard",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailLizard;
			}
		});

		public static const HARPY:int = 8;
		EnumValue.add(Memories, HARPY, "HARPY", {
			id: "Harpy Tail",
			name: "Harpy Feather Tail",
			cost: 100,
			title: "Harpy",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailHarpy;
			}
		});

		public static const DRACONIC:int = 9;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			id: "Draconic Tail",
			name: "Draconic Tail",
			cost: 100,
			title: "Draconic",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailDraconic;
			}
		});

		public static const PIG:int = 10;
		EnumValue.add(Memories, PIG, "PIG", {
			id: "Pig Tail",
			name: "Pig Tail",
			cost: 100,
			title: "Pig",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailPig;
			}
		});

		public static const SCORPION:int = 11;
		EnumValue.add(Memories, SCORPION, "SCORPION", {
			id: "Scorpion Tail",
			name: "Scorpion Stinger",
			cost: 100,
			title: "Scorpion",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailScorpion;
			}
		});

		public static const MANTICORE:int = 12;
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

		public static const GOAT:int = 13;
		EnumValue.add(Memories, GOAT, "GOAT", {
			id: "Goat Tail",
			name: "Goat Tail",
			cost: 100,
			title: "Goat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailGoat;
			}
		});

		public static const SALAMANDER:int = 14;
		EnumValue.add(Memories, SALAMANDER, "SALAMANDER", {
			id: "Salamander Tail",
			name: "Salamander Tail",
			cost: 100,
			title: "Salamander",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailSalamander;
			}
		});

		public static const MANTIS_ABDOMEN:int = 15;
		EnumValue.add(Memories, MANTIS_ABDOMEN, "MANTIS_ABDOMEN", {
			id: "Mantis Tail",
			name: "Mantis Tail",
			cost: 100,
			title: "Mantis",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailMantis;
			}
		});

		public static const ORCA:int = 16;
		EnumValue.add(Memories, ORCA, "ORCA", {
			id: "Orca Tail",
			name: "Orca Tail",
			cost: 100,
			title: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailOrca;
			}
		});

		public static const RAIJU:int = 17;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			id: "Raiju Tail",
			name: "Raiju Tail",
			cost: 100,
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailRaiju;
			}
		});

		public static const RED_PANDA:int = 18;
		EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
			id: "Red Panda Tail",
			name: "Red Panda Tail",
			cost: 100,
			title: "Red Panda",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailRedPanda;
			}
		});

		public static const BURNING:int = 19;
		EnumValue.add(Memories, BURNING, "BURNING", {
			id: "Burning Tail",
			name: "Burning Tail",
			cost: 100,
			title: "Burning",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailBurning;
			}
		});

		public static const CAT:int = 20;
		EnumValue.add(Memories, CAT, "CAT", {
			id: "Cat Tail",
			name: "Cat Tail",
			cost: 100,
			title: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailCat;
			}
		});

		public static const NEKOMATA_FORKED_1_3:int = 21;
		EnumValue.add(Memories, NEKOMATA_FORKED_1_3, "NEKOMATA_FORKED_1_3", {
			id: "Forked 1/3 Tail",
			name: "Forked 1/3 Nekomata Tail",
			cost: 200,
			title: "Forked 1/3",
			permReq: "Cat Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailNekomataOneThirdForked;
			}
		});

		public static const NEKOMATA_FORKED_2_3:int = 22;
		EnumValue.add(Memories, NEKOMATA_FORKED_2_3, "NEKOMATA_FORKED_2_3", {
			id: "Forked 2/3 Tail",
			name: "Forked 2/3 Nekomata Tail",
			cost: 300,
			title: "Forked 2/3",
			permReq: "Forked 1/3 Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailNekomataTwoThirdsForked;
			}
		});

		public static const CAT_2:int = 23;
		EnumValue.add(Memories, CAT_2, "CAT_2", {
			id: "Cat 2nd Tail",
			name: "2nd Cat Tail (Nekomata)",
			cost: 400,
			title: "Cat 2nd",
			permReq: "Forked 2/3 Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailCat2nd;
			}
		});

		public static const FOX:int = 24;
		EnumValue.add(Memories, FOX, "FOX", {
			id: "Fox Tail",
			name: "Fox Tail",
			cost: 100,
			title: "Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(1);
			}
		});

		public static const FOX_2:int = 25;
		EnumValue.add(Memories, FOX_2, "FOX_2", {
			id: "Fox 2nd Tail",
			name: "2nd Fox Tail",
			cost: 200,
			title: "Fox 2nd",
			permReq: "Fox Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(2);
			}
		});

		public static const FOX_3:int = 26;
		EnumValue.add(Memories, FOX_3, "FOX_3", {
			id: "Fox 3rd Tail",
			name: "3rd Fox Tail",
			cost: 300,
			title: "Fox 3rd",
			permReq: "Fox 2nd Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(3);
			}
		});

		public static const FOX_4:int = 27;
		EnumValue.add(Memories, FOX_4, "FOX_4", {
			id: "Fox 4th Tail",
			name: "4th Fox Tail",
			cost: 400,
			title: "Fox 4th",
			permReq: "Fox 3rd Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(4);
			}
		});

		public static const FOX_5:int = 28;
		EnumValue.add(Memories, FOX_5, "FOX_5", {
			id: "Fox 5th Tail",
			name: "5th Fox Tail",
			cost: 500,
			title: "Fox 5th",
			permReq: "Fox 4th Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(5);
			}
		});

		public static const FOX_6:int = 29;
		EnumValue.add(Memories, FOX_6, "FOX_6", {
			id: "Fox 6th Tail",
			name: "6th Fox Tail",
			cost: 600,
			title: "Fox 6th",
			permReq: "Fox 5th Tail",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(6);
			}
		});

		public static const FOX_7:int = 30;
		EnumValue.add(Memories, FOX_7, "FOX_7", {
			id: "Fox 7th Tail",
			name: "7th Fox Tail",
			cost: 700,
			title: "Fox 7th",
			permReq: "Fox 6th Tail",
			lockedInfo: "Requires Perk: Nine-tails Kitsune of Balance",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(7);
			}
		});

		public static const FOX_8:int = 31;
		EnumValue.add(Memories, FOX_8, "FOX_8", {
			id: "Fox 8th Tail",
			name: "8th Fox Tail",
			cost: 800,
			title: "Fox 8th",
			permReq: "Fox 7th Tail",
			lockedInfo: "Requires Perk: Nine-tails Kitsune of Balance",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(8);
			}
		});

		public static const FOX_9:int = 32;
		EnumValue.add(Memories, FOX_9, "FOX_9", {
			id: "Fox 9th Tail",
			name: "9th Fox Tail",
			cost: 900,
			title: "Fox 9th",
			permReq: "Fox 8th Tail",
			lockedInfo: "Requires Perk: Nine-tails Kitsune of Balance",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(9);
			}
		});

		public static const WOLF:int = 33;
		EnumValue.add(Memories, WOLF, "WOLF", {
			id: "Wolf Tail",
			name: "Wolf Tail",
			cost: 100,
			title: "Wolf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailWolf;
			}
		});

		public static const CAVE_WYRM:int = 34;
		EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
			id: "Cave Wyrm Tail",
			name: "Cave Wyrm Tail",
			cost: 100,
			title: "Cave Wyrm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailCaveWyrm;
			}
		});

		public static const MOUSE:int = 35;
		EnumValue.add(Memories, MOUSE, "MOUSE", {
			id: "Mouse Tail",
			name: "Mouse Tail",
			cost: 100,
			title: "Mouse",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailMouse;
			}
		});

		public static const HINEZUMI:int = 36;
		EnumValue.add(Memories, HINEZUMI, "HINEZUMI", {
			id: "Hinezumi Tail",
			name: "Hinezumi Tail",
			cost: 100,
			title: "Hinezumi",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailHinezumi;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
