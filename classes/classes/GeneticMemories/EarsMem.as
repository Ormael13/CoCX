package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Ears;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class EarsMem extends BaseContent {
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

		public static const HUMAN:int = 0;
		EnumValue.add(Memories, HUMAN, "HUMAN", {
			id: "Unlocked Metamorph",
			name: "Human Ears",
			cost: 500,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsHuman;
			}
		});

		public static const HORSE:int = 1;
		EnumValue.add(Memories, HORSE, "HORSE", {
			id: "Horse Ears",
			name: "Horse Ears",
			cost: 100,
			title: "Horse",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsHorse;
			}
		});

		public static const COW:int = 2;
		EnumValue.add(Memories, COW, "COW", {
			id: "Cow Ears",
			name: "Bovine Ears",
			cost: 100,
			title: "Bovine",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsCow;
			}
		});

		public static const ELFIN:int = 3;
		EnumValue.add(Memories, ELFIN, "ELFIN", {
			id: "Elfin Ears",
			name: "Elfin Ears",
			cost: 100,
			title: "Elfin",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsElfin;
			}
		});

		public static const CAT:int = 4;
		EnumValue.add(Memories, CAT, "CAT", {
			id: "Cat Ears",
			name: "Cat Ears",
			cost: 100,
			title: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsCat;
			}
		});

		public static const LIZARD:int = 5;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			id: "Lizard Ears",
			name: "Lizard Ears",
			cost: 100,
			title: "Lizard",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsLizard;
			}
		});

		public static const FOX:int = 6;
		EnumValue.add(Memories, FOX, "FOX", {
			id: "Fox Ears",
			name: "Fox Ears",
			cost: 100,
			title: "Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsFox;
			}
		});

		public static const DRACONIC:int = 7;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			id: "Draconic Ears",
			name: "Draconic Ears",
			cost: 100,
			title: "Dragon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsDraconic;
			}
		});

		public static const PIG:int = 8;
		EnumValue.add(Memories, PIG, "PIG", {
			id: "Pig Ears",
			name: "Pig Ears",
			cost: 100,
			title: "Pig",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsPig;
			}
		});

		public static const LION:int = 9;
		EnumValue.add(Memories, LION, "LION", {
			id: "Lion Ears",
			name: "Lion Ears",
			cost: 100,
			title: "Lion",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsLion;
			}
		});

		public static const ORCA:int = 10;
		EnumValue.add(Memories, ORCA, "ORCA", {
			id: "Orca Ears",
			name: "Orca Ears",
			cost: 100,
			title: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsOrca;
			}
		});

		public static const SNAKE:int = 11;
		EnumValue.add(Memories, SNAKE, "SNAKE", {
			id: "Snake Ears",
			name: "Snake Ears",
			cost: 100,
			title: "Snake",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsSnake;
			}
		});

		public static const GOAT:int = 12;
		EnumValue.add(Memories, GOAT, "GOAT", {
			id: "Goat Ears",
			name: "Goat Ears",
			cost: 100,
			title: "Goat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsGoat;
			}
		});

		public static const ONI:int = 13;
		EnumValue.add(Memories, ONI, "ONI", {
			id: "Oni Ears",
			name: "Oni Ears",
			cost: 100,
			title: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsOni;
			}
		});

		public static const ELVEN:int = 14;
		EnumValue.add(Memories, ELVEN, "ELVEN", {
			id: "Elven Ears",
			name: "Elven Ears",
			cost: 100,
			title: "Elven",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsElven;
			}
		});

		public static const WEASEL:int = 15;
		EnumValue.add(Memories, WEASEL, "WEASEL", {
			id: "Raiju Ears",
			name: "Raiju Ears",
			cost: 100,
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsWeasel;
			}
		});

		public static const BAT:int = 16;
		EnumValue.add(Memories, BAT, "BAT", {
			id: "Bat Ears",
			name: "Bat Ears",
			cost: 100,
			title: "Bat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsBat;
			}
		});

		public static const VAMPIRE:int = 17;
		EnumValue.add(Memories, VAMPIRE, "VAMPIRE", {
			id: "Vampire Ears",
			name: "Vampire Ears",
			cost: 100,
			title: "Vampire",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsVampire;
			}
		});

		public static const RED_PANDA:int = 18;
		EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
			id: "Red Panda Ears",
			name: "Red Panda Ears",
			cost: 100,
			title: "Red Panda",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsRedPanda;
			}
		});

		public static const DISPLACER:int = 19;
		EnumValue.add(Memories, DISPLACER, "DISPLACER", {
			id: "Displacer Ears",
			name: "Displacer Ears",
			cost: 100,
			title: "Displacer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsDisplacer;
			}
		});

		public static const WOLF:int = 20;
		EnumValue.add(Memories, WOLF, "WOLF", {
			id: "Wolf Ears",
			name: "Wolf Ears",
			cost: 100,
			title: "Wolf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsWolf;
			}
		});

		public static const CAVE_WYRM:int = 21;
		EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
			id: "Cave Wyrm Ears",
			name: "Cave Wyrm Ears",
			cost: 100,
			title: "Cave Wyrm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsCaveWyrm;
			}
		});

		public static const MOUSE:int = 22;
		EnumValue.add(Memories, MOUSE, "MOUSE", {
			id: "Mouse Ears",
			name: "Mouse Ears",
			cost: 100,
			title: "Mouse",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsMouse;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
