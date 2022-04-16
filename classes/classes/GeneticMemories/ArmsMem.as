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
			name: "Human Arms",
			cost: 500,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsHuman;
			}
		});

		public static const HARPY:int = 1;
		EnumValue.add(Memories, HARPY, "HARPY", {
			id: "Harpy Arms",
			name: "Harpy Arms",
			cost: 100,
			title: "Harpy",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsHarpy;
			}
		});

		public static const SPIDER:int = 2;
		EnumValue.add(Memories, SPIDER, "SPIDER", {
			id: "Spider Arms",
			name: "Spider Arms",
			cost: 100,
			title: "Spider",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsSpider;
			}
		});

		public static const MANTIS:int = 3;
		EnumValue.add(Memories, MANTIS, "MANTIS", {
			id: "Mantis Arms",
			name: "Mantis Arms",
			cost: 100,
			title: "Mantis",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsMantis;
			}
		});

		public static const BEE:int = 4;
		EnumValue.add(Memories, BEE, "BEE", {
			id: "Bee Arms",
			name: "Bee Arms",
			cost: 100,
			title: "Bee",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsBee;
			}
		});

		public static const SALAMANDER:int = 5;
		EnumValue.add(Memories, SALAMANDER, "SALAMANDER", {
			id: "Salamander Arms",
			name: "Salamander Arms",
			cost: 100,
			title: "Salamander",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsSalamander;
			}
		});

		public static const PHOENIX:int = 6;
		EnumValue.add(Memories, PHOENIX, "PHOENIX", {
			id: "Phoenix Arms",
			name: "Phoenix Arms",
			cost: 100,
			title: "Phoenix",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsPhoenix;
			}
		});

		public static const SHARK:int = 7;
		EnumValue.add(Memories, SHARK, "SHARK", {
			id: "Shark Arms",
			name: "Shark Arms",
			cost: 100,
			title: "Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsShark;
			}
		});

		public static const LION:int = 8;
		EnumValue.add(Memories, LION, "LION", {
			id: "Lion Arms",
			name: "Lion Paws (Arms)",
			cost: 100,
			title: "Lion",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsLion;
			}
		});

		public static const FOX:int = 9;
		EnumValue.add(Memories, FOX, "FOX", {
			id: "Fox Arms",
			name: "Fox Paws (Arms)",
			cost: 100,
			title: "Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsFox;
			}
		});

		public static const KITSUNE:int = 10;
		EnumValue.add(Memories, KITSUNE, "KITSUNE", {
			id: "Kitsune Arms",
			name: "Kitsune Claws (Arms)",
			cost: 100,
			title: "Kitsune",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsKitsune;
			}
		});

		public static const LIZARD:int = 11;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			id: "Lizard Arms",
			name: "Lizard Arms",
			cost: 100,
			title: "Lizard",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsLizard;
			}
		});

		public static const DRACONIC:int = 12;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			id: "Draconic Arms",
			name: "Draconic Arms",
			cost: 100,
			title: "Draconic",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsDraconic;
			}
		});

		public static const ORCA:int = 13;
		EnumValue.add(Memories, ORCA, "ORCA", {
			id: "Orca Arms",
			name: "Orca Arms",
			cost: 100,
			title: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsOrca;
			}
		});

		public static const DEVIL:int = 14;
		EnumValue.add(Memories, DEVIL, "DEVIL", {
			id: "Devil Arms",
			name: "Devil Claws (Arms)",
			cost: 100,
			title: "Devil",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsDevil;
			}
		});

		public static const ONI:int = 15;
		EnumValue.add(Memories, ONI, "ONI", {
			id: "Oni Arms",
			name: "Oni Arms",
			cost: 100,
			title: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsOni;
			}
		});

		public static const ELF:int = 16;
		EnumValue.add(Memories, ELF, "ELF", {
			id: "Elf Arms",
			name: "Elf Arms",
			cost: 100,
			title: "Elf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsElf;
			}
		});

		public static const RAIJU:int = 17;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			id: "Raiju Arms",
			name: "Raiju Claws (Arms)",
			cost: 100,
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsRaiju;
			}
		});

		public static const RED_PANDA:int = 18;
		EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
			id: "Red Panda Arms",
			name: "Red Panda Paws (Arms)",
			cost: 100,
			title: "Red Panda",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsRedPanda;
			}
		});

		public static const CAT:int = 19;
		EnumValue.add(Memories, CAT, "CAT", {
			id: "Cat Arms",
			name: "Cat Paws (Arms)",
			cost: 100,
			title: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsCat;
			}
		});

		public static const SPHINX:int = 20;
		EnumValue.add(Memories, SPHINX, "SPHINX", {
			id: "Sphinx Arms",
			name: "Sphinx Arms",
			cost: 100,
			title: "Sphinx",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsSphinx;
			}
		});

		public static const PIG:int = 21;
		EnumValue.add(Memories, PIG, "PIG", {
			id: "Pig Arms",
			name: "Pig Arms",
			cost: 100,
			title: "Pig",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsPig;
			}
		});

		public static const BOAR:int = 22;
		EnumValue.add(Memories, BOAR, "BOAR", {
			id: "Boar Arms",
			name: "Boar Arms",
			cost: 100,
			title: "Boar",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsBoar;
			}
		});

		public static const ORC:int = 23;
		EnumValue.add(Memories, ORC, "ORC", {
			id: "Orc Arms",
			name: "Orc Arms",
			cost: 100,
			title: "Orc",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsOrc;
			}
		});

		public static const DISPLACER:int = 24;
		EnumValue.add(Memories, DISPLACER, "DISPLACER", {
			id: "Displacer Arms",
			name: "Displacer Four Arms",
			cost: 100,
			title: "Displacer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsDisplacer;
			}
		});

		public static const RAIJU_PAWS:int = 25;
		EnumValue.add(Memories, RAIJU_PAWS, "RAIJU_PAWS", {
			id: "Raiju Paws Arms",
			name: "Raiju Paws (Arms)",
			cost: 100,
			title: "Raiju Paws",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsRaijuPaws;
			}
		});

		public static const BAT:int = 26;
		EnumValue.add(Memories, BAT, "BAT", {
			id: "Bat Wing Arms",
			name: "Winged Bat Arms",
			cost: 100,
			title: "Bat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsBatWing;
			}
		});

		public static const WOLF:int = 27;
		EnumValue.add(Memories, WOLF, "WOLF", {
			id: "Wolf Arms",
			name: "Wolf Arms",
			cost: 100,
			title: "Wolf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsWolf;
			}
		});

		public static const CAVE_WYRM:int = 28;
		EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
			id: "Cave Wyrm Arms",
			name: "Cave Wyrm Arms",
			cost: 100,
			title: "Cave Wyrm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsCaveWyrm;
			}
		});

		public static const HINEZUMI:int = 29;
		EnumValue.add(Memories, HINEZUMI, "HINEZUMI", {
			id: "Hinezumi Arms",
			name: "Hinezumi Arms",
			cost: 100,
			title: "Hinezumi",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsHinezumi;
			}
		});

		public static const GAZER:int = 30;
		EnumValue.add(Memories, GAZER, "GAZER", {
			id: "Gazer Arms",
			name: "Gazer Arms",
			cost: 100,
			title: "Gazer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsGazer;
			}
		});

		public static const FROSTWYRM:int = 31;
		EnumValue.add(Memories, FROSTWYRM, "FROSTWYRM", {
			id: "Frostwyrm Arms",
			name: "Frostwyrm Arms",
			cost: 100,
			title: "Frostwyrm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsFrostwyrm;
			}
		});

	  	public static const JABBERWOCKY:int = 32;
	  	EnumValue.add(Memories, JABBERWOCKY, "JABBERWOCKY", {
		  id: "Jabberwocky Arms",
		  name: "Jabberwocky Arms",
		  cost: 100,
		  title: "Jabberwocky",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.ArmsJabberwocky;
		  }
	  	});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
