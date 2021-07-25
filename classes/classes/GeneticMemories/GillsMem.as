package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Gills;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class GillsMem extends BaseContent {
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
			name: "No Gills",
			metamorphCost: 500,
			metamorphTitle: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.GillsNone;
			}
		});

		public static const FISH:int = 1;
		EnumValue.add(Memories, FISH, "FISH", {
			name: "Fish Gills",
			metamorphCost: 100,
			metamorphTitle: "Fish",
			transformation: function(): Transformation {
				return CoC.instance.transformations.GillsFish;
			}
		});
  }
}
