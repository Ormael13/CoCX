package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Arms;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class ArmsMem extends BaseContent {
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
			name: "Human Arms",
			metamorphCost: 500,
			metamorphTitle: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsHuman;
			}
		});

		public static const HARPY:int = 1;
		EnumValue.add(Memories, HARPY, "HARPY", {
			name: "Harpy Arms",
			metamorphCost: 100,
			metamorphTitle: "Harpy",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsHarpy;
			}
		});

		public static const SPIDER:int = 2;
		EnumValue.add(Memories, SPIDER, "SPIDER", {
			name: "Spider Arms",
			metamorphCost: 100,
			metamorphTitle: "Spider",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsSpider;
			}
		});

		public static const MANTIS:int = 3;
		EnumValue.add(Memories, MANTIS, "MANTIS", {
			name: "Mantis Arms",
			metamorphCost: 100,
			metamorphTitle: "Mantis",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsMantis;
			}
		});

		public static const BEE:int = 4;
		EnumValue.add(Memories, BEE, "BEE", {
			name: "Bee Arms",
			metamorphCost: 100,
			metamorphTitle: "Bee",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsBee;
			}
		});

		public static const SALAMANDER:int = 5;
		EnumValue.add(Memories, SALAMANDER, "SALAMANDER", {
			name: "Salamander Arms",
			metamorphCost: 100,
			metamorphTitle: "Salamander",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsSalamander;
			}
		});

		public static const PHOENIX:int = 6;
		EnumValue.add(Memories, PHOENIX, "PHOENIX", {
			name: "Phoenix Arms",
			metamorphCost: 100,
			metamorphTitle: "Phoenix",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsPhoenix;
			}
		});

		public static const SHARK:int = 7;
		EnumValue.add(Memories, SHARK, "SHARK", {
			name: "Shark Arms",
			metamorphCost: 100,
			metamorphTitle: "Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsShark;
			}
		});

		public static const LION:int = 8;
		EnumValue.add(Memories, LION, "LION", {
			name: "Lion Arms",
			metamorphCost: 100,
			metamorphTitle: "Lion",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsLion;
			}
		});

		public static const FOX:int = 9;
		EnumValue.add(Memories, FOX, "FOX", {
			name: "Fox Arms",
			metamorphCost: 100,
			metamorphTitle: "Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsFox;
			}
		});

		public static const KITSUNE:int = 10;
		EnumValue.add(Memories, KITSUNE, "KITSUNE", {
			name: "Kitsune Arms",
			metamorphCost: 100,
			metamorphTitle: "Kitsune",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsKitsune;
			}
		});

		public static const LIZARD:int = 11;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			name: "Lizard Arms",
			metamorphCost: 100,
			metamorphTitle: "Lizard",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsLizard;
			}
		});

		public static const DRACONIC:int = 12;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			name: "Draconic Arms",
			metamorphCost: 100,
			metamorphTitle: "Draconic",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsDraconic;
			}
		});

		public static const ORCA:int = 13;
		EnumValue.add(Memories, ORCA, "ORCA", {
			name: "Orca Arms",
			metamorphCost: 100,
			metamorphTitle: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsOrca;
			}
		});

		public static const DEVIL:int = 14;
		EnumValue.add(Memories, DEVIL, "DEVIL", {
			name: "Devil Arms",
			metamorphCost: 100,
			metamorphTitle: "Devil",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsDevil;
			}
		});

		public static const ONI:int = 15;
		EnumValue.add(Memories, ONI, "ONI", {
			name: "Oni Arms",
			metamorphCost: 100,
			metamorphTitle: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsOni;
			}
		});

		public static const ELF:int = 16;
		EnumValue.add(Memories, ELF, "ELF", {
			name: "Elf Arms",
			metamorphCost: 100,
			metamorphTitle: "Elf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsElf;
			}
		});

		public static const RAIJU:int = 17;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			name: "Raiju Arms",
			metamorphCost: 100,
			metamorphTitle: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsRaiju;
			}
		});

		public static const RED_PANDA:int = 18;
		EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
			name: "Red Panda Arms",
			metamorphCost: 100,
			metamorphTitle: "Red Panda",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsRedPanda;
			}
		});

		public static const CAT:int = 19;
		EnumValue.add(Memories, CAT, "CAT", {
			name: "Cat Arms",
			metamorphCost: 100,
			metamorphTitle: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsCat;
			}
		});

		public static const SPHINX:int = 20;
		EnumValue.add(Memories, SPHINX, "SPHINX", {
			name: "Sphinx Arms",
			metamorphCost: 100,
			metamorphTitle: "Sphinx",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsSphinx;
			}
		});

		public static const PIG:int = 21;
		EnumValue.add(Memories, PIG, "PIG", {
			name: "Pig Arms",
			metamorphCost: 100,
			metamorphTitle: "Pig",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsPig;
			}
		});

		public static const BOAR:int = 22;
		EnumValue.add(Memories, BOAR, "BOAR", {
			name: "Boar Arms",
			metamorphCost: 100,
			metamorphTitle: "Boar",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsBoar;
			}
		});

		public static const ORC:int = 23;
		EnumValue.add(Memories, ORC, "ORC", {
			name: "Orc Arms",
			metamorphCost: 100,
			metamorphTitle: "Orc",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsOrc;
			}
		});

		public static const DISPLACER:int = 24;
		EnumValue.add(Memories, DISPLACER, "DISPLACER", {
			name: "Displacer Arms",
			metamorphCost: 100,
			metamorphTitle: "Displacer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsDisplacer;
			}
		});

		public static const RAIJU_PAWS:int = 25;
		EnumValue.add(Memories, RAIJU_PAWS, "RAIJU_PAWS", {
			name: "Raiju Paws Arms",
			metamorphCost: 100,
			metamorphTitle: "Raiju Paws",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsRaijuPaws;
			}
		});

		public static const BAT:int = 26;
		EnumValue.add(Memories, BAT, "BAT", {
			name: "Bat Wing Arms",
			metamorphCost: 100,
			metamorphTitle: "Bat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsBatWing;
			}
		});
  }
}
