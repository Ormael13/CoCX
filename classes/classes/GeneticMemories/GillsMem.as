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
			id: "No Gills",
			cost: 500,
			title: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.GillsNone;
			}
		});

		public static const FISH:int = 1;
		EnumValue.add(Memories, FISH, "FISH", {
			id: "Fish Gills",
			cost: 100,
			title: "Fish",
			transformation: function(): Transformation {
				return CoC.instance.transformations.GillsFish;
			}
		});
  }
}
