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
	 * - metamorphCost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - metamorphTitle: name displayed on the metamorph button
	 * - transformation: TF object that refers to what the metamorph does

	 * Template:

		public static const [NAME HERE]:int = [ID HERE];
		EnumValue.add(Memories, [NAME HERE], "[NAME HERE]", {
			name: [Name Saved in GeneticStorage],
			metamorphCost: [Cost Here],
			metamorphTitle: "[Race Here]",
			transformation: function(): Transformation {
				return CoC.instance.transformations.[TF Object from TransformationLib];
			}
		});

	 */

    public static var Memories:/*EnumValue*/ Array = [];

		public static const NONE:int = 0;
		EnumValue.add(Memories, NONE, "NONE", {
			name: "No Tail",
			metamorphCost: 500,
			metamorphTitle: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailNone;
			}
		});

		public static const HORSE:int = 1;
		EnumValue.add(Memories, HORSE, "HORSE", {
			name: "Horse Tail",
			metamorphCost: 100,
			metamorphTitle: "Horse",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailHorse;
			}
		});

		public static const DEMONIC:int = 2;
		EnumValue.add(Memories, DEMONIC, "DEMONIC", {
			name: "Demon Tail",
			metamorphCost: 100,
			metamorphTitle: "Demon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailDemonic;
			}
		});

		public static const COW:int = 3;
		EnumValue.add(Memories, COW, "COW", {
			name: "Cow Tail",
			metamorphCost: 100,
			metamorphTitle: "Cow",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailCow;
			}
		});

		public static const SPIDER_ADBOMEN:int = 4;
		EnumValue.add(Memories, SPIDER_ADBOMEN, "SPIDER_ADBOMEN", {
			name: "Spider Tail",
			metamorphCost: 100,
			metamorphTitle: "Spider",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailSpider;
			}
		});

		public static const BEE_ABDOMEN:int = 5;
		EnumValue.add(Memories, BEE_ABDOMEN, "BEE_ABDOMEN", {
			name: "Bee Tail",
			metamorphCost: 100,
			metamorphTitle: "Bee",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailBee;
			}
		});

		public static const SHARK:int = 6;
		EnumValue.add(Memories, SHARK, "SHARK", {
			name: "Shark Tail",
			metamorphCost: 100,
			metamorphTitle: "Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailShark;
			}
		});

		public static const LIZARD:int = 7;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			name: "Lizard Tail",
			metamorphCost: 100,
			metamorphTitle: "Lizard",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailLizard;
			}
		});

		public static const HARPY:int = 8;
		EnumValue.add(Memories, HARPY, "HARPY", {
			name: "Harpy Tail",
			metamorphCost: 100,
			metamorphTitle: "Harpy",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailHarpy;
			}
		});

		public static const DRACONIC:int = 9;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			name: "Draconic Tail",
			metamorphCost: 100,
			metamorphTitle: "Draconic",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailDraconic;
			}
		});

		public static const PIG:int = 10;
		EnumValue.add(Memories, PIG, "PIG", {
			name: "Pig Tail",
			metamorphCost: 100,
			metamorphTitle: "Pig",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailPig;
			}
		});

		public static const SCORPION:int = 11;
		EnumValue.add(Memories, SCORPION, "SCORPION", {
			name: "Scorpion Tail",
			metamorphCost: 100,
			metamorphTitle: "Scorpion",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailScorpion;
			}
		});

		public static const MANTICORE:int = 12;
		EnumValue.add(Memories, MANTICORE, "MANTICORE", {
			name: "Manticore Tail",
			metamorphCost: 200,
			metamorphTitle: "Manticore",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailManticore;
			}
		});

		public static const GOAT:int = 13;
		EnumValue.add(Memories, GOAT, "GOAT", {
			name: "Goat Tail",
			metamorphCost: 100,
			metamorphTitle: "Goat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailGoat;
			}
		});

		public static const SALAMANDER:int = 14;
		EnumValue.add(Memories, SALAMANDER, "SALAMANDER", {
			name: "Salamander Tail",
			metamorphCost: 100,
			metamorphTitle: "Salamander",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailSalamander;
			}
		});

		public static const MANTIS_ABDOMEN:int = 15;
		EnumValue.add(Memories, MANTIS_ABDOMEN, "MANTIS_ABDOMEN", {
			name: "Mantis Tail",
			metamorphCost: 100,
			metamorphTitle: "Mantis",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailMantis;
			}
		});

		public static const ORCA:int = 16;
		EnumValue.add(Memories, ORCA, "ORCA", {
			name: "Orca Tail",
			metamorphCost: 100,
			metamorphTitle: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailOrca;
			}
		});

		public static const RAIJU:int = 17;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			name: "Raiju Tail",
			metamorphCost: 100,
			metamorphTitle: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailRaiju;
			}
		});

		public static const RED_PANDA:int = 18;
		EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
			name: "Red Panda Tail",
			metamorphCost: 100,
			metamorphTitle: "Red Panda",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailRedPanda;
			}
		});

		public static const BURNING:int = 19;
		EnumValue.add(Memories, BURNING, "BURNING", {
			name: "Burning Tail",
			metamorphCost: 100,
			metamorphTitle: "Burning",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailBurning;
			}
		});

		public static const CAT:int = 20;
		EnumValue.add(Memories, CAT, "CAT", {
			name: "Cat Tail",
			metamorphCost: 100,
			metamorphTitle: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailCat;
			}
		});

		public static const NEKOMATA_FORKED_1_3:int = 21;
		EnumValue.add(Memories, NEKOMATA_FORKED_1_3, "NEKOMATA_FORKED_1_3", {
			name: "Forked 1/3 Tail",
			metamorphCost: 200,
			metamorphTitle: "Forked 1/3",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailNekomataOneThirdForked;
			}
		});

		public static const NEKOMATA_FORKED_2_3:int = 22;
		EnumValue.add(Memories, NEKOMATA_FORKED_2_3, "NEKOMATA_FORKED_2_3", {
			name: "Forked 2/3 Tail",
			metamorphCost: 300,
			metamorphTitle: "Forked 2/3",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailNekomataTwoThirdsForked;
			}
		});

		public static const CAT_2:int = 23;
		EnumValue.add(Memories, CAT_2, "CAT_2", {
			name: "Cat 2nd Tail",
			metamorphCost: 400,
			metamorphTitle: "Cat 2nd",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailCat2nd;
			}
		});

		public static const FOX:int = 24;
		EnumValue.add(Memories, FOX, "FOX", {
			name: "Fox Tail",
			metamorphCost: 100,
			metamorphTitle: "Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(1);
			}
		});

		public static const FOX_2:int = 25;
		EnumValue.add(Memories, FOX_2, "FOX_2", {
			name: "Fox 2nd Tail",
			metamorphCost: 200,
			metamorphTitle: "Fox 2nd",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(2);
			}
		});

		public static const FOX_3:int = 26;
		EnumValue.add(Memories, FOX_3, "FOX_3", {
			name: "Fox 3rd Tail",
			metamorphCost: 300,
			metamorphTitle: "Fox 3rd",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(3);
			}
		});

		public static const FOX_4:int = 27;
		EnumValue.add(Memories, FOX_4, "FOX_4", {
			name: "Fox 4th Tail",
			metamorphCost: 400,
			metamorphTitle: "Fox 4th",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(4);
			}
		});

		public static const FOX_5:int = 28;
		EnumValue.add(Memories, FOX_5, "FOX_5", {
			name: "Fox 5th Tail",
			metamorphCost: 500,
			metamorphTitle: "Fox 5th",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(5);
			}
		});

		public static const FOX_6:int = 29;
		EnumValue.add(Memories, FOX_6, "FOX_6", {
			name: "Fox 6th Tail",
			metamorphCost: 600,
			metamorphTitle: "Fox 6th",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(6);
			}
		});

		public static const FOX_7:int = 30;
		EnumValue.add(Memories, FOX_7, "FOX_7", {
			name: "Fox 7th Tail",
			metamorphCost: 700,
			metamorphTitle: "Fox 7th",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(7);
			}
		});

		public static const FOX_8:int = 31;
		EnumValue.add(Memories, FOX_8, "FOX_8", {
			name: "Fox 8th Tail",
			metamorphCost: 800,
			metamorphTitle: "Fox 8th",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(8);
			}
		});

		public static const FOX_9:int = 32;
		EnumValue.add(Memories, FOX_9, "FOX_9", {
			name: "Fox 9th Tail",
			metamorphCost: 900,
			metamorphTitle: "Fox 9th",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TailFox(9);
			}
		});
  }
}
