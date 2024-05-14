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
		private static var _partid:int = 0;

		public static const HUMAN:int = _partid++;
		EnumValue.add(Memories, HUMAN, "HUMAN", {
			id: "Unlocked Metamorph",
			name: "Human Ears",
			cost: 500,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsHuman;
			}
		});

		public static const AVIAN:int = _partid++;
		EnumValue.add(Memories, AVIAN, "AVIAN", {
			id: "Avian Ears",
			name: "Avian Ears",
			cost: 100,
			title: "Avian",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsAvian;
			}
		});

		public static const BAT:int = _partid++;
		EnumValue.add(Memories, BAT, "BAT", {
			id: "Bat Ears",
			name: "Bat Ears",
			cost: 100,
			title: "Bat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsBat;
			}
		});

		public static const BEAR:int = _partid++;
		EnumValue.add(Memories, BEAR, "BEAR", {
			id: "Bear Ears",
			name: "Bear Ears",
			cost: 100,
			title: "Bear",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsBear;
			}
		});

		public static const BIG:int = _partid++;
		EnumValue.add(Memories, BIG, "BIG", {
			id: "Big Ears",
			name: "Big Ears",
			cost: 100,
			title: "Big",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsBig;
			}
		});

		public static const BUNNY:int = _partid++;
		EnumValue.add(Memories, BUNNY, "BUNNY", {
			id: "Bunny Ears",
			name: "Bunny Ears",
			cost: 100,
			title: "Bunny",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsBunny;
			}
		});

		public static const CAT:int = _partid++;
		EnumValue.add(Memories, CAT, "CAT", {
			id: "Cat Ears",
			name: "Cat Ears",
			cost: 100,
			title: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsCat;
			}
		});

		public static const CAVE_WYRM:int = _partid++;
		EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
			id: "Cave Wyrm Ears",
			name: "Cave Wyrm Ears",
			cost: 100,
			title: "Cave Wyrm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsCaveWyrm;
			}
		});

		public static const COW:int = _partid++;
		EnumValue.add(Memories, COW, "COW", {
			id: "Cow Ears",
			name: "Bovine Ears",
			cost: 100,
			title: "Bovine",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsCow;
			}
		});

		public static const DEER:int = _partid++;
		EnumValue.add(Memories, DEER, "DEER", {
			id: "Deer Ears",
			name: "Deer Ears",
			cost: 100,
			title: "Deer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsDeer;
			}
		});

		public static const DISPLACER:int = _partid++;
		EnumValue.add(Memories, DISPLACER, "DISPLACER", {
			id: "Displacer Ears",
			name: "Displacer Ears",
			cost: 100,
			title: "Displacer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsDisplacer;
			}
		});

		public static const DOG:int = _partid++;
		EnumValue.add(Memories, DOG, "DOG", {
			id: "Dog Ears",
			name: "Dog Ears",
			cost: 100,
			title: "Dog",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsDog;
			}
		});

		public static const DRACONIC:int = _partid++;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			id: "Draconic Ears",
			name: "Draconic Ears",
			cost: 100,
			title: "Dragon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsDraconic;
			}
		});

		public static const ELFIN:int = _partid++;
		EnumValue.add(Memories, ELFIN, "ELFIN", {
			id: "Elfin Ears",
			name: "Elfin Ears",
			cost: 100,
			title: "Elfin",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsElfin;
			}
		});

		public static const ELVEN:int = _partid++;
		EnumValue.add(Memories, ELVEN, "ELVEN", {
			id: "Elven Ears",
			name: "Elven Ears",
			cost: 100,
			title: "Elven",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsElven;
			}
		});

		public static const FERRET:int = _partid++;
		EnumValue.add(Memories, FERRET, "FERRET", {
			id: "Ferret Ears",
			name: "Ferret Ears",
			cost: 100,
			title: "Ferret",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsFerret;
			}
		});

		public static const FOX:int = _partid++;
		EnumValue.add(Memories, FOX, "FOX", {
			id: "Fox Ears",
			name: "Fox Ears",
			cost: 100,
			title: "Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsFox;
			}
		});

		public static const GOAT:int = _partid++;
		EnumValue.add(Memories, GOAT, "GOAT", {
			id: "Goat Ears",
			name: "Goat Ears",
			cost: 100,
			title: "Goat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsGoat;
			}
		});

		public static const GREMLIN:int = _partid++;
		EnumValue.add(Memories, GREMLIN, "GREMLIN", {
			id: "Gremlin Ears",
			name: "Gremlin Ears",
			cost: 100,
			title: "Gremlin",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsGremlin;
			}
		});
		
		public static const GRYPHON:int = _partid++;
		EnumValue.add(Memories, GRYPHON, "GRYPHON", {
			id: "Gryphon Ears",
			name: "Gryphon Ears",
			cost: 100,
			title: "Gryphon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsGryphon;
			}
		});

		public static const HORSE:int = _partid++;
		EnumValue.add(Memories, HORSE, "HORSE", {
			id: "Horse Ears",
			name: "Horse Ears",
			cost: 100,
			title: "Horse",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsHorse;
			}
		});

		public static const INSECT:int = _partid++;
		EnumValue.add(Memories, INSECT, "INSECT", {
			id: "Insect Ears",
			name: "Insect Ears",
			cost: 100,
			title: "Insect",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsInsect;
			}
		});

		public static const KANGAROO:int = _partid++;
		EnumValue.add(Memories, KANGAROO, "KANGAROO", {
			id: "Kangaroo Ears",
			name: "Kangaroo Ears",
			cost: 100,
			title: "Kangaroo",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsKangaroo;
			}
		});

		public static const KIRIN:int = _partid++;
		EnumValue.add(Memories, KIRIN, "KIRIN", {
			id: "Kirin Ears",
			name: "Kirin Ears",
			cost: 100,
			title: "Kirin",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsKirin;
			}
		});

		public static const LIZARD:int = _partid++;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			id: "Lizard Ears",
			name: "Lizard Ears",
			cost: 100,
			title: "Lizard",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsLizard;
			}
		});

		public static const LION:int = _partid++;
		EnumValue.add(Memories, LION, "LION", {
			id: "Lion Ears",
			name: "Lion Ears",
			cost: 100,
			title: "Lion",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsLion;
			}
		});
		
		public static const MELKIE:int = _partid++;
		EnumValue.add(Memories, MELKIE, "MELKIE", {
			id: "Melkie Ears",
			name: "Melkie Ears",
			cost: 100,
			title: "Melkie",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsMelkie;
			}
		});

		public static const MOUSE:int = _partid++;
		EnumValue.add(Memories, MOUSE, "MOUSE", {
			id: "Mouse Ears",
			name: "Mouse Ears",
			cost: 100,
			title: "Mouse",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsMouse;
			}
		});

		public static const ONI:int = _partid++;
		EnumValue.add(Memories, ONI, "ONI", {
			id: "Oni Ears",
			name: "Oni Ears",
			cost: 100,
			title: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsOni;
			}
		});

		public static const ORCA:int = _partid++;
		EnumValue.add(Memories, ORCA, "ORCA", {
			id: "Orca Ears",
			name: "Orca Fin Ears",
			cost: 100,
			title: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsOrca;
			}
		});

		public static const ORCA2:int = _partid++;
		EnumValue.add(Memories, ORCA2, "ORCA2", {
			id: "Orca Hole Ears",
			name: "Orca Hole Ears",
			cost: 100,
			title: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsOrca2;
			}
		});

		public static const PANDA:int = _partid++;
		EnumValue.add(Memories, PANDA, "PANDA", {
			id: "Panda Ears",
			name: "Panda Ears",
			cost: 100,
			title: "Panda",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsPanda;
			}
		});

		public static const PIG:int = _partid++;
		EnumValue.add(Memories, PIG, "PIG", {
			id: "Pig Ears",
			name: "Pig Ears",
			cost: 100,
			title: "Pig",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsPig;
			}
		});

		public static const RACCOON:int = _partid++;
		EnumValue.add(Memories, RACCOON, "RACCOON", {
			id: "Raccoon Ears",
			name: "Raccoon Ears",
			cost: 100,
			title: "Raccoon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsRaccoon;
			}
		});

		public static const RAIJU:int = _partid++;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			id: "Raiju Ears",
			name: "Raiju Ears",
			cost: 100,
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsRaiju;
			}
		});

		public static const RED_PANDA:int = _partid++;
		EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
			id: "Red Panda Ears",
			name: "Red Panda Ears",
			cost: 100,
			title: "Red Panda",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsRedPanda;
			}
		});

		public static const SHARK:int = _partid++;
		EnumValue.add(Memories, SHARK, "SHARK", {
			id: "Shark Ears",
			name: "Shark Ears",
			cost: 100,
			title: "Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsShark;
			}
		});

		public static const SNAKE:int = _partid++;
		EnumValue.add(Memories, SNAKE, "SNAKE", {
			id: "Snake Ears",
			name: "Snake Ears",
			cost: 100,
			title: "Snake",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsSnake;
			}
		});

		public static const SQUIRREL:int = _partid++;
		EnumValue.add(Memories, SQUIRREL, "SQUIRREL", {
			id: "Squirrel Ears",
			name: "Squirrel Ears",
			cost: 100,
			title: "Squirrel",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsSquirrel;
			}
		});

		public static const VAMPIRE:int = _partid++;
		EnumValue.add(Memories, VAMPIRE, "VAMPIRE", {
			id: "Vampire Ears",
			name: "Vampire Ears",
			cost: 100,
			title: "Vampire",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsVampire;
			}
		});

		public static const WEASEL:int = _partid++;
		EnumValue.add(Memories, WEASEL, "WEASEL", {
			id: "Weasel Ears",
			name: "Weasel Ears",
			cost: 100,
			title: "Weasel",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsWeasel;
			}
		});

		public static const WOLF:int = _partid++;
		EnumValue.add(Memories, WOLF, "WOLF", {
			id: "Wolf Ears",
			name: "Wolf Ears",
			cost: 100,
			title: "Wolf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsWolf;
			}
		});

		public static const YETI:int = _partid++;
		EnumValue.add(Memories, YETI, "YETI", {
			id: "Yeti Ears",
			name: "Yeti Ears",
			cost: 100,
			title: "Yeti",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsYeti;
			}
		});

		public static const FENNEC_FOX:int = _partid++;
		EnumValue.add(Memories, FENNEC_FOX, "FENNEC_FOX", {
			id: "Fennec Fox Ears",
			name: "Fennec Fox Ears",
			cost: 100,
			title: "Fennec Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsFennecFox;
			}
		});

		public static const JACKAL:int = _partid++;
		EnumValue.add(Memories, JACKAL, "JACKAL", {
			id: "Jackal Ears",
			name: "Jackal Ears",
			cost: 100,
			title: "Jackal",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsJackal;
			}
		});

		public static const TROLL:int = _partid++;
		EnumValue.add(Memories, TROLL, "TROLL", {
			id: "Troll Ears",
			name: "Troll Ears",
			cost: 100,
			title: "Troll",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsTroll;
			}
		});

		public static const GLACIAL_TROLL:int = _partid++;
		EnumValue.add(Memories, GLACIAL_TROLL, "GLACIAL_TROLL", {
			id: "G.Troll Ears",
			name: "G.Troll Ears",
			cost: 100,
			title: "G.Troll",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EarsGlacialTroll;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
