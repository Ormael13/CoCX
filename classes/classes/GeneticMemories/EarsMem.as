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

				public static const HUMAN:int = 0;
		EnumValue.add(Memories, HUMAN, "HUMAN", {
			name: "Human Ears",
			metamorphCost: 500,
			metamorphTitle: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsHuman;
			}
		});

		public static const HORSE:int = 1;
		EnumValue.add(Memories, HORSE, "HORSE", {
			name: "Horse Ears",
			metamorphCost: 100,
			metamorphTitle: "Horse",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsHorse;
			}
		});

		public static const COW:int = 2;
		EnumValue.add(Memories, COW, "COW", {
			name: "Cow Ears",
			metamorphCost: 100,
			metamorphTitle: "Cow",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsCow;
			}
		});

		public static const ELFIN:int = 3;
		EnumValue.add(Memories, ELFIN, "ELFIN", {
			name: "Elfin Ears",
			metamorphCost: 100,
			metamorphTitle: "Elfin",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsElfin;
			}
		});

		public static const CAT:int = 4;
		EnumValue.add(Memories, CAT, "CAT", {
			name: "Cat Ears",
			metamorphCost: 100,
			metamorphTitle: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsCat;
			}
		});

		public static const LIZARD:int = 5;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			name: "Lizard Ears",
			metamorphCost: 100,
			metamorphTitle: "Lizard",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsLizard;
			}
		});

		public static const FOX:int = 6;
		EnumValue.add(Memories, FOX, "FOX", {
			name: "Fox Ears",
			metamorphCost: 100,
			metamorphTitle: "Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsFox;
			}
		});

		public static const DRACONIC:int = 7;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			name: "Draconic Ears",
			metamorphCost: 100,
			metamorphTitle: "Dragon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsDraconic;
			}
		});

		public static const PIG:int = 8;
		EnumValue.add(Memories, PIG, "PIG", {
			name: "Pig Ears",
			metamorphCost: 100,
			metamorphTitle: "Pig",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsPig;
			}
		});

		public static const LION:int = 9;
		EnumValue.add(Memories, LION, "LION", {
			name: "Lion Ears",
			metamorphCost: 100,
			metamorphTitle: "Lion",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsLion;
			}
		});

		public static const ORCA:int = 10;
		EnumValue.add(Memories, ORCA, "ORCA", {
			name: "Orca Ears",
			metamorphCost: 100,
			metamorphTitle: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsOrca;
			}
		});

		public static const SNAKE:int = 11;
		EnumValue.add(Memories, SNAKE, "SNAKE", {
			name: "Snake Ears",
			metamorphCost: 100,
			metamorphTitle: "Snake",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsSnake;
			}
		});

		public static const GOAT:int = 12;
		EnumValue.add(Memories, GOAT, "GOAT", {
			name: "Goat Ears",
			metamorphCost: 100,
			metamorphTitle: "Goat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsGoat;
			}
		});

		public static const ONI:int = 13;
		EnumValue.add(Memories, ONI, "ONI", {
			name: "Oni Ears",
			metamorphCost: 100,
			metamorphTitle: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsOni;
			}
		});

		public static const ELVEN:int = 14;
		EnumValue.add(Memories, ELVEN, "ELVEN", {
			name: "Elven Ears",
			metamorphCost: 100,
			metamorphTitle: "Elven",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsElven;
			}
		});

		public static const WEASEL:int = 15;
		EnumValue.add(Memories, WEASEL, "WEASEL", {
			name: "Raiju Ears",
			metamorphCost: 100,
			metamorphTitle: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsWeasel;
			}
		});

		public static const BAT:int = 16;
		EnumValue.add(Memories, BAT, "BAT", {
			name: "Bat Ears",
			metamorphCost: 100,
			metamorphTitle: "Bat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsBat;
			}
		});

		public static const VAMPIRE:int = 17;
		EnumValue.add(Memories, VAMPIRE, "VAMPIRE", {
			name: "Vampire Ears",
			metamorphCost: 100,
			metamorphTitle: "Vampire",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsVampire;
			}
		});

		public static const RED_PANDA:int = 18;
		EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
			name: "Red Panda Ears",
			metamorphCost: 100,
			metamorphTitle: "Red Panda",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsRedPanda;
			}
		});

		public static const DISPLACER:int = 19;
		EnumValue.add(Memories, DISPLACER, "DISPLACER", {
			name: "Displacer Ears",
			metamorphCost: 100,
			metamorphTitle: "Displacer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsDisplacer;
			}
		});
  }
}
