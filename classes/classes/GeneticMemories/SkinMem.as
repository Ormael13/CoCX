package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Skin;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class SkinMem extends BaseContent {
	/**
	 * Entry properties:
	 * - metamorphCost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - metamorphTitle: name displayed on the metamorph button
	 * - availableCoverages: which levels of skin coverage are available for this skin Metamorph
	 * - transformation: TF object that refers to what the metamorph does
	 * - transformationFunc: returns TF function that refers to what the metamorph does, overwrites transformation

	 * Template:

		public static const [NAME HERE]:int = [ID HERE];
		EnumValue.add(Memories, [NAME HERE], "[NAME HERE]", {
			name: [Name Saved in GeneticStorage],
			metamorphCost: [Cost Here],
			metamorphTitle: "[Race Here]",
			availableCoverages: [Skin.COVERAGES_HERE],
			transformation: function(): Transformation {
				return CoC.instance.transformations.[TF Object from TransformationLib];
			},
			transformationFunc: function(function(player: *, coverage: int): Transformation {
				return CoC.instance.transformations.[TF Function from TransformationLib](Necessary Properties);
			}
		});

	 */

    public static var Memories:/*EnumValue*/ Array = [];

		public static const PLAIN:int = 0;
		EnumValue.add(Memories, PLAIN, "PLAIN", {
			name: "Plain Skin",
			metamorphCost: 500,
			metamorphTitle: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPlain;
			}
		});

		public static const FUR:int = 1;
		EnumValue.add(Memories, FUR, "FUR", {
			name: "Fur Skin",
			metamorphCost: 100,
			metamorphTitle: "Fur",
			availableCoverages: [Skin.COVERAGE_LOW, Skin.COVERAGE_COMPLETE],
			transformationFunc: function(coverage: int): Transformation {
				return CoC.instance.transformations.SkinFur(coverage);
			}
		});

		public static const SCALES:int = 2;
		EnumValue.add(Memories, SCALES, "SCALES", {
			name: "Scales Skin",
			metamorphCost: 100,
			metamorphTitle: "Scales",
			availableCoverages: [Skin.COVERAGE_LOW, Skin.COVERAGE_COMPLETE],
			transformationFunc: function(coverage: int): Transformation {
				return CoC.instance.transformations.SkinScales(coverage);
			}
		});

		public static const DRAGON_SCALES:int = 3;
		EnumValue.add(Memories, DRAGON_SCALES, "DRAGON_SCALES", {
			name: "Dragon Scales Skin",
			metamorphCost: 150,
			metamorphTitle: "D.Scales",
			availableCoverages: [Skin.COVERAGE_LOW, Skin.COVERAGE_COMPLETE],
			transformationFunc: function(coverage: int): Transformation {
				return CoC.instance.transformations.SkinDragonScales(coverage);
			}
		});

		public static const CHITIN:int = 4;
		EnumValue.add(Memories, CHITIN, "CHITIN", {
			name: "Chitin Skin",
			metamorphCost: 100,
			metamorphTitle: "Chitin",
			availableCoverages: [Skin.COVERAGE_LOW, Skin.COVERAGE_COMPLETE],
			transformationFunc: function(coverage: int): Transformation {
				return CoC.instance.transformations.SkinChitin(coverage);
			}
		});
  }
}
