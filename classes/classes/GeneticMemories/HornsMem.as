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
	 * - cost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - title: name displayed on the metamorph button
	 * - transformation: TF object that refers to what the metamorph does
	 *
	 * Optional properties:
	 * - info: additional text to be shown underneath the Metamorph cost in the menu when hovering over a button
	 * - lockedInfo: additional text to be shown on *locked* Metamorphs when hovering over a button

	 * Template:

		public static const [NAME HERE]:int = [ID HERE];
		EnumValue.add(Memories, [NAME HERE], "[NAME HERE]", {
			id: [Name Saved in GeneticStorage],
			cost: [Cost Here],
			title: "[Race Here]",
			transformation: function(): Transformation {
				return CoC.instance.transformations.[TF Object from TransformationLib];
			}
		});

	 */

    public static var Memories:/*EnumValue*/ Array = [];

		public static const NONE:int = 0;
		EnumValue.add(Memories, NONE, "NONE", {
			id: "No Horns",
			cost: 500,
			title: "No Horns",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsNone;
			}
		});

		public static const DEMON:int = 1;
		EnumValue.add(Memories, DEMON, "DEMON", {
			id: "Demon Horns",
			cost: 100,
			title: "Demon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsDemonic;
			}
		});

		public static const COW_MINOTAUR:int = 2;
		EnumValue.add(Memories, COW_MINOTAUR, "COW_MINOTAUR", {
			id: "Cow Minotaur Horns",
			cost: 100,
			title: "Cow/Mino",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsCowMinotaur;
			}
		});

		public static const DRACONIC_X2:int = 3;
		EnumValue.add(Memories, DRACONIC_X2, "DRACONIC_X2", {
			id: "Draconic Dual Horns",
			cost: 100,
			title: "Draconic x2",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsDraconicDual;
			}
		});

		public static const DRACONIC_X4:int = 4;
		EnumValue.add(Memories, DRACONIC_X4, "DRACONIC_X4", {
			id: "Draconic Quadruple Horns",
			cost: 200,
			title: "Draconic x4",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsDraconicQuadruple;
			}
		});

		public static const GOAT:int = 5;
		EnumValue.add(Memories, GOAT, "GOAT", {
			id: "Goat Horns",
			cost: 100,
			title: "Goat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsGoat;
			}
		});

		public static const UNICORN:int = 6;
		EnumValue.add(Memories, UNICORN, "UNICORN", {
			id: "Unicorn Horn",
			cost: 100,
			title: "Unicorn",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsUnicorn;
			}
		});

		public static const ONI:int = 7;
		EnumValue.add(Memories, ONI, "ONI", {
			id: "Oni Horn",
			cost: 100,
			title: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsOni;
			}
		});

		public static const ONI_X2:int = 8;
		EnumValue.add(Memories, ONI_X2, "ONI_X2", {
			id: "Oni Dual Horns",
			cost: 100,
			title: "Oni x2",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsOniDual;
			}
		});

		public static const BICORN:int = 9;
		EnumValue.add(Memories, BICORN, "BICORN", {
			id: "Bicorn Horns",
			cost: 100,
			title: "Bicorn",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HornsBicorn;
			}
		});

  }
}
