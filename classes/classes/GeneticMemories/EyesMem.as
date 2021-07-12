package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Eyes;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class EyesMem extends BaseContent {
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
			name: "Human Eyes",
			metamorphCost: 500,
			metamorphTitle: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesHuman;
			}
		});

		public static const SPIDER:int = 1;
		EnumValue.add(Memories, SPIDER, "SPIDER", {
			name: "Spider Eyes",
			metamorphCost: 100,
			metamorphTitle: "Spider",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesSpider;
			}
		});

		public static const CAT:int = 2;
		EnumValue.add(Memories, CAT, "CAT", {
			name: "Cat Eyes",
			metamorphCost: 100,
			metamorphTitle: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesCat;
			}
		});

		public static const GORGON:int = 3;
		EnumValue.add(Memories, GORGON, "GORGON", {
			name: "Gorgon Eyes",
			metamorphCost: 100,
			metamorphTitle: "Gorgon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesGorgon;
			}
		});

		public static const MANTICORE:int = 4;
		EnumValue.add(Memories, MANTICORE, "MANTICORE", {
			name: "Manticore Eyes",
			metamorphCost: 100,
			metamorphTitle: "Manticore",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesManticore;
			}
		});

		public static const FOX:int = 5;
		EnumValue.add(Memories, FOX, "FOX", {
			name: "Fox Eyes",
			metamorphCost: 100,
			metamorphTitle: "Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesFox;
			}
		});

		public static const LIZARD:int = 6;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			name: "Lizard Eyes",
			metamorphCost: 100,
			metamorphTitle: "Lizard",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesLizard;
			}
		});

		public static const SNAKE:int = 7;
		EnumValue.add(Memories, SNAKE, "SNAKE", {
			name: "Snake Eyes",
			metamorphCost: 100,
			metamorphTitle: "Snake",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesSnake;
			}
		});

		public static const DRACONIC:int = 8;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			name: "Draconic Eyes",
			metamorphCost: 100,
			metamorphTitle: "Dragon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesDraconic;
			}
		});

		public static const DEVIL:int = 9;
		EnumValue.add(Memories, DEVIL, "DEVIL", {
			name: "Devil Eyes",
			metamorphCost: 100,
			metamorphTitle: "Devil",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesDevil;
			}
		});

		public static const ONI:int = 10;
		EnumValue.add(Memories, ONI, "ONI", {
			name: "Oni Eyes",
			metamorphCost: 100,
			metamorphTitle: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesOni;
			}
		});

		public static const ELF:int = 11;
		EnumValue.add(Memories, ELF, "ELF", {
			name: "Elf Eyes",
			metamorphCost: 100,
			metamorphTitle: "Elf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesElf;
			}
		});

		public static const RAIJU:int = 12;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			name: "Raiju Eyes",
			metamorphCost: 100,
			metamorphTitle: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesRaiju;
			}
		});

		public static const VAMPIRE:int = 13;
		EnumValue.add(Memories, VAMPIRE, "VAMPIRE", {
			name: "Vampire Eyes",
			metamorphCost: 100,
			metamorphTitle: "Vampire",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesVampire;
			}
		});

		public static const INFERNAL:int = 14;
		EnumValue.add(Memories, INFERNAL, "INFERNAL", {
			name: "Infernal Eyes",
			metamorphCost: 100,
			metamorphTitle: "Infernal",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesInfernal;
			}
		});

		public static const ORC:int = 15;
		EnumValue.add(Memories, ORC, "ORC", {
			name: "Orc Eyes",
			metamorphCost: 100,
			metamorphTitle: "Orc",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesOrc;
			}
		});

		public static const DISPLACER:int = 16;
		EnumValue.add(Memories, DISPLACER, "DISPLACER", {
			name: "Displacer Eyes",
			metamorphCost: 100,
			metamorphTitle: "Displacer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesDisplacer;
			}
		});

  }
}
