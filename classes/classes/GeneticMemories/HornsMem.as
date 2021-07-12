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

		public static const NONE:int = 0;
		EnumValue.add(Memories, NONE, "NONE", {
			name: "No Horns",
			metamorphCost: 500,
			metamorphTitle: "No Horns",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsNone;
			}
		});

		public static const DEMON:int = 1;
		EnumValue.add(Memories, DEMON, "DEMON", {
			name: "Demon Horns",
			metamorphCost: 100,
			metamorphTitle: "Demon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsDemonic;
			}
		});

		public static const COW_MINOTAUR:int = 2;
		EnumValue.add(Memories, COW_MINOTAUR, "COW_MINOTAUR", {
			name: "Cow Minotaur Horns",
			metamorphCost: 100,
			metamorphTitle: "Cow/Mino",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsCowMinotaur;
			}
		});

		public static const DRACONIC_X2:int = 3;
		EnumValue.add(Memories, DRACONIC_X2, "DRACONIC_X2", {
			name: "Draconic Dual Horns",
			metamorphCost: 100,
			metamorphTitle: "Draconic x2",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsDraconicDual;
			}
		});

		public static const DRACONIC_X4:int = 4;
		EnumValue.add(Memories, DRACONIC_X4, "DRACONIC_X4", {
			name: "Draconic Quadruple Horns",
			metamorphCost: 200,
			metamorphTitle: "Draconic x4",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsDraconicQuadruple;
			}
		});

		public static const GOAT:int = 5;
		EnumValue.add(Memories, GOAT, "GOAT", {
			name: "Goat Horns",
			metamorphCost: 100,
			metamorphTitle: "Goat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsGoat;
			}
		});

		public static const UNICORN:int = 6;
		EnumValue.add(Memories, UNICORN, "UNICORN", {
			name: "Unicorn Horn",
			metamorphCost: 100,
			metamorphTitle: "Unicorn",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsUnicorn;
			}
		});

		public static const ONI:int = 7;
		EnumValue.add(Memories, ONI, "ONI", {
			name: "Oni Horn",
			metamorphCost: 100,
			metamorphTitle: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsOni;
			}
		});

		public static const ONI_X2:int = 8;
		EnumValue.add(Memories, ONI_X2, "ONI_X2", {
			name: "Oni Dual Horns",
			metamorphCost: 100,
			metamorphTitle: "Oni x2",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsOniDual;
			}
		});

		public static const BICORN:int = 9;
		EnumValue.add(Memories, BICORN, "BICORN", {
			name: "Bicorn Horns",
			metamorphCost: 100,
			metamorphTitle: "Bicorn",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsBicorn;
			}
		});

  }
}
