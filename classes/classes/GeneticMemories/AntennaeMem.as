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
	 * - id: the identificator of the Metamorph inside GeneticStorage
	 * - cost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - title: name displayed on the metamorph button
	 * - transformation: TF object that refers to what the metamorph does
	 *
	 * Optional properties:
	 * - info: additional text to be shown underneath the Metamorph cost in the menu when hovering over a button

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
			id: "No Antennae",
			cost: 500,
			title: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.AntennaeNone;
			}
		});

		public static const MANTIS:int = 1;
		EnumValue.add(Memories, MANTIS, "MANTIS", {
			id: "Mantis Antennae",
			cost: 100,
			title: "Mantis",
			transformation: function(): Transformation {
				return CoC.instance.transformations.AntennaeMantis;
			}
		});

		public static const BEE:int = 2;
		EnumValue.add(Memories, BEE, "BEE", {
			id: "Bee Antennae",
			cost: 100,
			title: "Bee",
			transformation: function(): Transformation {
				return CoC.instance.transformations.AntennaeBee;
			}
		});


  }
}
