package classes.GeneticMemories {
import classes.BaseContent;
import classes.internals.EnumValue;
import classes.Transformations.Transformation;
import classes.CoC;

public class VaginaMem extends BaseContent {
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
		  name: "No Vagina",
		  cost: 1000,
		  title: "None",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.VaginaNone();
		  }
		});

		public static const HUMAN:int = 1;
		EnumValue.add(Memories, HUMAN, "HUMAN", {
			id: "Human Vagina",
			name: "Human Vagina",
			cost: 500,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.VaginaHuman();
			}
		});

		public static const EQUINE:int = 2;
		EnumValue.add(Memories, EQUINE, "EQUINE", {
			id: "Equine Vagina",
			name: "Equine Vagina",
			cost: 500,
			title: "Equine",
			transformation: function(): Transformation {
				return CoC.instance.transformations.VaginaHorse();
			}
		});

		public static const BLACK_SAND_TRAP:int = 3;
		EnumValue.add(Memories, BLACK_SAND_TRAP, "BLACK_SAND_TRAP", {
			id: "Black Sand Trap Vagina",
			name: "Black Sand Trap Vagina",
			cost: 500,
			title: "Sand Trap",
			transformation: function(): Transformation {
				return CoC.instance.transformations.VaginaSandTrap();
			}
		});

		public static const CAVE_WYRM:int = 4;
		EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
			id: "Cave Wyrm Vagina",
			name: "Cave Wyrm Vagina",
			cost: 500,
			title: "Cave Wyrm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.VaginaCaveWyrm();
			}
		});

		public static const VENOM_DRIPPING:int = 5;
		EnumValue.add(Memories, VENOM_DRIPPING, "VENOM_DRIPPING", {
			id: "Centipede Vagina",
			name: "Centipede Vagina",
			cost: 500,
			title: "Centipede",
			transformation: function(): Transformation {
				return CoC.instance.transformations.VaginaCentipede();
			}
		});

		public static const MANTICORE:int = 6;
		EnumValue.add(Memories, MANTICORE, "MANTICORE", {
			id: "Manticore Vagina",
			name: "Manticore Vagina",
			cost: 500,
			title: "Manticore",
			transformation: function(): Transformation {
				return CoC.instance.transformations.VaginaManticore();
			}
		});

	public static const CANCER:int = 7;
	EnumValue.add(Memories, CANCER, "CANCER", {
		id: "Cancer Vagina",
		name: "Cancer Vagina",
		cost: 500,
		title: "Cancer",
		transformation: function(): Transformation {
			return CoC.instance.transformations.VaginaCancer();
		}
	});

		public static const DEMONIC:int = 8;
		EnumValue.add(Memories, DEMONIC, "DEMONIC", {
			id: "Demon Vagina",
			name: "Demon Vagina",
			cost: 500,
			title: "Demon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.VaginaDemonic();
			}
		});

		public static const SCYLLA:int = 9;
		EnumValue.add(Memories, SCYLLA, "SCYLLA", {
			id: "Scylla Vagina",
			name: "Scylla Vagina",
			cost: 500,
			title: "Scylla",
			transformation: function(): Transformation {
				return CoC.instance.transformations.VaginaScylla();
			}
		});

		public static const NAGA:int = 10;
		EnumValue.add(Memories, NAGA, "NAGA", {
			id: "Naga Vagina",
			name: "Naga Vagina",
			cost: 500,
			title: "Naga",
			transformation: function(): Transformation {
				return CoC.instance.transformations.VaginaNaga();
			}
		});

		public static const SHARK:int = 11;
		EnumValue.add(Memories, SHARK, "SHARK", {
			id: "Shark Vagina",
			name: "Shark Vagina",
			cost: 500,
			title: "Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.VaginaShark();
			}
		});

		public static const RAIJU:int = 12;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			id: "Raiju Vagina",
			name: "Raiju Vagina",
			cost: 500,
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.VaginaRaiju();
			}
		});


		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
