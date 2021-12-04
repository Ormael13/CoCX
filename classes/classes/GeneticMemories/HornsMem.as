package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Horns;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class HornsMem extends BaseContent {
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
			name: "No Horns",
			cost: 500,
			title: "No Horns",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsNone;
			}
		});

		public static const DEMON:int = 1;
		EnumValue.add(Memories, DEMON, "DEMON", {
			id: "Demon Horns",
			name: "Demon Horns",
			cost: 100,
			title: "Demon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsDemonic;
			}
		});

		public static const COW_MINOTAUR:int = 2;
		EnumValue.add(Memories, COW_MINOTAUR, "COW_MINOTAUR", {
			id: "Cow Minotaur Horns",
			name: "Bovine Horns",
			cost: 100,
			title: "Bovine",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsCowMinotaur;
			}
		});

		public static const DRACONIC_X2:int = 3;
		EnumValue.add(Memories, DRACONIC_X2, "DRACONIC_X2", {
			id: "Draconic Dual Horns",
			name: "Draconic Dual Horns",
			cost: 100,
			title: "Draconic x2",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsDraconicDual;
			}
		});

		public static const DRACONIC_X4:int = 4;
		EnumValue.add(Memories, DRACONIC_X4, "DRACONIC_X4", {
			id: "Draconic Quadruple Horns",
			name: "Draconic Quadruple Horns",
			cost: 200,
			title: "Draconic x4",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsDraconicQuadruple;
			}
		});

		public static const GOAT:int = 5;
		EnumValue.add(Memories, GOAT, "GOAT", {
			id: "Goat Horns",
			name: "Goat Horns",
			cost: 100,
			title: "Goat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsGoat;
			}
		});

		public static const UNICORN:int = 6;
		EnumValue.add(Memories, UNICORN, "UNICORN", {
			id: "Unicorn Horn",
			name: "Unicorn Horn",
			cost: 100,
			title: "Unicorn",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsUnicorn;
			}
		});

		public static const ONI:int = 7;
		EnumValue.add(Memories, ONI, "ONI", {
			id: "Oni Horn",
			name: "Oni Horn",
			cost: 100,
			title: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsOni;
			}
		});

		public static const ONI_X2:int = 8;
		EnumValue.add(Memories, ONI_X2, "ONI_X2", {
			id: "Oni Dual Horns",
			name: "Oni Dual Horns",
			cost: 100,
			title: "Oni x2",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsOniDual;
			}
		});

		public static const BICORN:int = 9;
		EnumValue.add(Memories, BICORN, "BICORN", {
			id: "Bicorn Horns",
			name: "Bicorn Horns",
			cost: 100,
			title: "Bicorn",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsBicorn;
			}
		});

		public static const FROSTWYRM:int = 10;
		EnumValue.add(Memories, FROSTWYRM, "FROSTWYRM", {
			id: "Frostwyrm Horns",
			name: "Frostwyrm Horns",
			cost: 100,
			title: "Frostwyrm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsFrostwyrm;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
