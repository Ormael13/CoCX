package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Face;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class FaceMem extends BaseContent {
	/**
	 * Entry properties:
	 * - metamorphCost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - metamorphTitle: name displayed on the metamorph button
	 * - transformation: TF object that refers to what the metamorph does

	 * Template:

		public static const [NAME HERE]:int = [ID HERE];
		EnumValue.add(Memories, [NAME HERE], "[NAME HERE]", {
			name: [Full Name to identify],
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
			name: "Human Face",
			metamorphCost: 500,
			metamorphTitle: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceHuman;
			}
		});

		public static const HORSE:int = 1;
		EnumValue.add(Memories, HORSE, "HORSE", {
			name: "Horse Face",
			metamorphCost: 100,
			metamorphTitle: "Horse",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceHorse;
			}
		});

		public static const COW_MINOTAUR:int = 2;
		EnumValue.add(Memories, COW_MINOTAUR, "COW_MINOTAUR", {
			name: "Cow/Minotaur Face",
			metamorphCost: 100,
			metamorphTitle: "Cow/Mino",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceCowMinotaur;
			}
		});

		public static const SHARK_TEETH:int = 3;
		EnumValue.add(Memories, SHARK_TEETH, "SHARK_TEETH", {
			name: "Shark Teeth Face",
			metamorphCost: 100,
			metamorphTitle: "Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceSharkTeeth;
			}
		});

		public static const SNAKE_FANGS:int = 4;
		EnumValue.add(Memories, SNAKE_FANGS, "SNAKE_FANGS", {
			name: "Snake Fangs Face",
			metamorphCost: 100,
			metamorphTitle: "Snake",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceSnakeFangs;
			}
		});

		public static const CAT:int = 5;
		EnumValue.add(Memories, CAT, "CAT", {
			name: "Cat Face",
			metamorphCost: 100,
			metamorphTitle: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceCat;
			}
		});

		public static const CAT_CANINES:int = 6;
		EnumValue.add(Memories, CAT_CANINES, "CAT_CANINES", {
			name: "Cat Canines Face",
			metamorphCost: 100,
			metamorphTitle: "Cat Canines",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceCatCanines;
			}
		});

		public static const LIZARD:int = 7;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			name: "Lizard Face",
			metamorphCost: 100,
			metamorphTitle: "Lizard",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceLizard;
			}
		});

		public static const SPIDER:int = 8;
		EnumValue.add(Memories, SPIDER, "SPIDER", {
			name: "Spider Fangs Face",
			metamorphCost: 100,
			metamorphTitle: "Spider Fangs",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceSpiderFangs;
			}
		});

		public static const FOX:int = 9;
		EnumValue.add(Memories, FOX, "FOX", {
			name: "Fox Face",
			metamorphCost: 100,
			metamorphTitle: "Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceFox;
			}
		});

		public static const PIG:int = 10;
		EnumValue.add(Memories, PIG, "PIG", {
			name: "Pig Face",
			metamorphCost: 100,
			metamorphTitle: "Pig",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FacePig;
			}
		});

		public static const BOAR:int = 11;
		EnumValue.add(Memories, BOAR, "BOAR", {
			name: "Boar Face",
			metamorphCost: 100,
			metamorphTitle: "Boar",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceBoar;
			}
		});

		public static const MANTICORE:int = 12;
		EnumValue.add(Memories, MANTICORE, "MANTICORE", {
			name: "Manticore Face",
			metamorphCost: 100,
			metamorphTitle: "Manticore",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceManticore;
			}
		});

		public static const SALAMANDER_FANGS:int = 13;
		EnumValue.add(Memories, SALAMANDER_FANGS, "SALAMANDER_FANGS", {
			name: "Salamander Fangs Face",
			metamorphCost: 100,
			metamorphTitle: "Salamander F.",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceSalamanderFangs;
			}
		});

		public static const ORCA:int = 14;
		EnumValue.add(Memories, ORCA, "ORCA", {
			name: "Orca Face",
			metamorphCost: 100,
			metamorphTitle: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceOrca;
			}
		});

		public static const DRAGON:int = 15;
		EnumValue.add(Memories, DRAGON, "DRAGON", {
			name: "Draconic Face",
			metamorphCost: 100,
			metamorphTitle: "Dragon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceDragon;
			}
		});

		public static const DRAGON_FANGS:int = 16;
		EnumValue.add(Memories, DRAGON_FANGS, "DRAGON_FANGS", {
			name: "Draconic Fangs Face",
			metamorphCost: 100,
			metamorphTitle: "Dragon Fangs",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceDragonFangs;
			}
		});

		public static const ONI_TEETH:int = 17;
		EnumValue.add(Memories, ONI_TEETH, "ONI_TEETH", {
			name: "Oni Teeth Face",
			metamorphCost: 100,
			metamorphTitle: "Oni Teeh",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceOniTeeth;
			}
		});

		public static const WEASEL:int = 18;
		EnumValue.add(Memories, WEASEL, "WEASEL", {
			name: "Weasel Face",
			metamorphCost: 100,
			metamorphTitle: "Weasel",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceWeasel;
			}
		});

		public static const VAMPIRE:int = 19;
		EnumValue.add(Memories, VAMPIRE, "VAMPIRE", {
			name: "Vampire Face",
			metamorphCost: 100,
			metamorphTitle: "Vampire",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceVampire;
			}
		});

		public static const RED_PANDA:int = 20;
		EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
			name: "Red Panda Face",
			metamorphCost: 100,
			metamorphTitle: "Red Panda",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceRedPanda;
			}
		});

		public static const CHESHIRE:int = 21;
		EnumValue.add(Memories, CHESHIRE, "CHESHIRE", {
			name: "Cheshire Face",
			metamorphCost: 200,
			metamorphTitle: "Cheshire",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceCheshire;
			}
		});

		public static const CHESHIRE_SMILE:int = 22;
		EnumValue.add(Memories, CHESHIRE_SMILE, "CHESHIRE_SMILE", {
			name: "Cheshire Smile Face",
			metamorphCost: 200,
			metamorphTitle: "Cheshire Smile",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceCheshireSmile;
			}
		});

		public static const ORC_FANGS:int = 23;
		EnumValue.add(Memories, ORC_FANGS, "ORC_FANGS", {
			name: "Orc Fangs Face",
			metamorphCost: 200,
			metamorphTitle: "Orc Fangs",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceOrcFangs;
			}
		});
  }
}
