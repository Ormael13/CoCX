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
			name: "Human Eyes",
			cost: 500,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesHuman;
			}
		});

		public static const SPIDER:int = 1;
		EnumValue.add(Memories, SPIDER, "SPIDER", {
			id: "Spider Eyes",
			name: "Spider Eyes",
			cost: 100,
			title: "Spider",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesSpider;
			}
		});

		public static const CAT:int = 2;
		EnumValue.add(Memories, CAT, "CAT", {
			id: "Cat Eyes",
			name: "Cat Eyes",
			cost: 100,
			title: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesCat;
			}
		});

		public static const GORGON:int = 3;
		EnumValue.add(Memories, GORGON, "GORGON", {
			id: "Gorgon Eyes",
			name: "Gorgon Eyes",
			cost: 100,
			title: "Gorgon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesGorgon;
			}
		});

		public static const MANTICORE:int = 4;
		EnumValue.add(Memories, MANTICORE, "MANTICORE", {
			id: "Manticore Eyes",
			name: "Manticore Eyes",
			cost: 100,
			title: "Manticore",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesManticore;
			}
		});

		public static const FOX:int = 5;
		EnumValue.add(Memories, FOX, "FOX", {
			id: "Fox Eyes",
			name: "Fox Eyes",
			cost: 100,
			title: "Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesFox;
			}
		});

		public static const LIZARD:int = 6;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			id: "Lizard Eyes",
			name: "Lizard Eyes",
			cost: 100,
			title: "Lizard",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesLizard;
			}
		});

		public static const SNAKE:int = 7;
		EnumValue.add(Memories, SNAKE, "SNAKE", {
			id: "Snake Eyes",
			name: "Snake Eyes",
			cost: 100,
			title: "Snake",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesSnake;
			}
		});

		public static const DRACONIC:int = 8;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			id: "Draconic Eyes",
			name: "Draconic Eyes",
			cost: 100,
			title: "Dragon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesDraconic;
			}
		});

		public static const DEVIL:int = 9;
		EnumValue.add(Memories, DEVIL, "DEVIL", {
			id: "Devil Eyes",
			name: "Devil Eyes",
			cost: 100,
			title: "Devil",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesDevil;
			}
		});

		public static const ONI:int = 10;
		EnumValue.add(Memories, ONI, "ONI", {
			id: "Oni Eyes",
			name: "Oni Eyes",
			cost: 100,
			title: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesOni;
			}
		});

		public static const ELF:int = 11;
		EnumValue.add(Memories, ELF, "ELF", {
			id: "Elf Eyes",
			name: "Elf Eyes",
			cost: 100,
			title: "Elf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesElf;
			}
		});

		public static const RAIJU:int = 12;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			id: "Raiju Eyes",
			name: "Raiju Eyes",
			cost: 100,
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesRaiju;
			}
		});

		public static const VAMPIRE:int = 13;
		EnumValue.add(Memories, VAMPIRE, "VAMPIRE", {
			id: "Vampire Eyes",
			name: "Vampire Eyes",
			cost: 100,
			title: "Vampire",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesVampire;
			}
		});

		public static const INFERNAL:int = 14;
		EnumValue.add(Memories, INFERNAL, "INFERNAL", {
			id: "Infernal Eyes",
			name: "Infernal Eyes",
			cost: 100,
			title: "Infernal",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesInfernal;
			}
		});

		public static const ORC:int = 15;
		EnumValue.add(Memories, ORC, "ORC", {
			id: "Orc Eyes",
			name: "Orc Eyes",
			cost: 100,
			title: "Orc",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesOrc;
			}
		});

		public static const DISPLACER:int = 16;
		EnumValue.add(Memories, DISPLACER, "DISPLACER", {
			id: "Displacer Eyes",
			name: "Displacer Eyes",
			cost: 100,
			title: "Displacer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesDisplacer;
			}
		});

		public static const CAVE_WYRM:int = 17;
		EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
			id: "Cave Wyrm Eyes",
			name: "Cave Wyrm Eyes",
			cost: 100,
			title: "Cave Wyrm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesCaveWyrm;
			}
		});

		public static const HINEZUMI:int = 18;
		EnumValue.add(Memories, HINEZUMI, "HINEZUMI", {
			id: "Hinezumi Eyes",
			name: "Hinezumi Eyes",
			cost: 100,
			title: "Hinezumi",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesHinezumi;
			}
		});

		public static const MONOEYE:int = 19;
		EnumValue.add(Memories, MONOEYE, "MONOEYE", {
			id: "Monoeye",
			name: "Monoeye",
			cost: 100,
			title: "Monoeye",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesMonoeye;
			}
		});

		public static const BLACK_EYES_SAND_TRAP:int = 20;
		EnumValue.add(Memories, BLACK_EYES_SAND_TRAP, "BLACK_EYES_SAND_TRAP", {
			id: "Black Eyes",
			name: "Black Eyes",
			cost: 100,
			title: "Black Eyes",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesSandTrap;
			}
		});

		public static const FROSTWYRM:int = 21;
		EnumValue.add(Memories, FROSTWYRM, "FROSTWYRM", {
			id: "Frost wyrm Eyes",
			name: "Frost wyrm Eyes",
			cost: 100,
			title: "Frost wyrm Eyes",
			transformation: function(): Transformation {
				return CoC.instance.transformations.EyesFrostwyrm;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
