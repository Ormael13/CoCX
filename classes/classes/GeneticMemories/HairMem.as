package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Hair;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class HairMem extends BaseContent {
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

		public static const NORMAL:int = 0;
		EnumValue.add(Memories, NORMAL, "NORMAL", {
			name: "Human Hair",
			metamorphCost: 500,
			metamorphTitle: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HairHuman;
			}
		});

		public static const FEATHER:int = 1;
		EnumValue.add(Memories, FEATHER, "FEATHER", {
			name: "Feather Hair",
			metamorphCost: 100,
			metamorphTitle: "Feather",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HairFeather;
			}
		});

		public static const GORGON:int = 2;
		EnumValue.add(Memories, GORGON, "GORGON", {
			name: "Gorgon Hair",
			metamorphCost: 100,
			metamorphTitle: "Gorgon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HairGorgon;
			}
		});

		public static const ELF:int = 3;
		EnumValue.add(Memories, ELF, "ELF", {
			name: "Silky Hair",
			metamorphCost: 100,
			metamorphTitle: "Elf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HairSilky;
			}
		});

		public static const STORM:int = 4;
		EnumValue.add(Memories, STORM, "STORM", {
			name: "Storm Hair",
			metamorphCost: 100,
			metamorphTitle: "Storm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HairStorm;
			}
		});

		public static const BURNING:int = 5;
		EnumValue.add(Memories, BURNING, "BURNING", {
			name: "Burning Hair",
			metamorphCost: 100,
			metamorphTitle: "Burning",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HairBurning;
			}
		});
  }
}
