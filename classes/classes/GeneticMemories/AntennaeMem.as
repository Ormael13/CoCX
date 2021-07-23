package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Antennae;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class AntennaeMem extends BaseContent {
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
			name: "No Antennae",
			metamorphCost: 500,
			metamorphTitle: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.AntennaeNone;
			}
		});

		public static const MANTIS:int = 1;
		EnumValue.add(Memories, MANTIS, "MANTIS", {
			name: "Mantis Antennae",
			metamorphCost: 100,
			metamorphTitle: "Mantis",
			transformation: function(): Transformation {
				return CoC.instance.transformations.AntennaeMantis;
			}
		});

		public static const BEE:int = 2;
		EnumValue.add(Memories, BEE, "BEE", {
			name: "Bee Antennae",
			metamorphCost: 100,
			metamorphTitle: "Bee",
			transformation: function(): Transformation {
				return CoC.instance.transformations.AntennaeBee;
			}
		});


  }
}
