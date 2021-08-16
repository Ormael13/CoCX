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
	 * - id: the identificator of the Metamorph inside GeneticStorage
	 * - name: how the Metamorph is referred to in displayed texts
	 * - cost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - title: name displayed on the metamorph button
	 * - unlockText: additional text displayed when Metamorph is unlocked
	 * - availableCoverages: which levels of skin coverage are available for this skin Metamorph
	 * - transformation: TF object that refers to what the metamorph does
	 * - transformationCoverage: returns TF function that refers to what the metamorph does, overwrites transformation
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
			availableCoverages: [Skin.COVERAGES_HERE],
			transformation: function(): Transformation {
				return CoC.instance.transformations.[TF Object from TransformationLib];
			},
			transformationCoverage: function(function(player: *, coverage: int): Transformation {
				return CoC.instance.transformations.[TF Function from TransformationLib](Necessary Properties);
			}
		});

	 */

    public static var Memories:/*EnumValue*/ Array = [];

		public static const PLAIN:int = 0;
		EnumValue.add(Memories, PLAIN, "PLAIN", {
			id: "Unlocked Metamorph",
			name: "Human Skin",
			cost: 500,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPlain;
			}
		});

		public static const FUR:int = 1;
		EnumValue.add(Memories, FUR, "FUR", {
			id: "Fur Skin",
			name: "Fur",
			cost: 100,
			title: "Fur",
			availableCoverages: [Skin.COVERAGE_LOW, Skin.COVERAGE_COMPLETE],
			transformationCoverage: function(coverage: int): Transformation {
				return CoC.instance.transformations.SkinFur(coverage);
			}
		});

		public static const SCALES:int = 2;
		EnumValue.add(Memories, SCALES, "SCALES", {
			id: "Scales Skin",
			name: "Scales",
			cost: 100,
			title: "Scales",
			availableCoverages: [Skin.COVERAGE_LOW, Skin.COVERAGE_COMPLETE],
			transformationCoverage: function(coverage: int): Transformation {
				return CoC.instance.transformations.SkinScales(coverage);
			}
		});

		public static const DRAGON_SCALES:int = 3;
		EnumValue.add(Memories, DRAGON_SCALES, "DRAGON_SCALES", {
			id: "Dragon Scales Skin",
			name: "Dragon Scales",
			cost: 150,
			title: "D.Scales",
			availableCoverages: [Skin.COVERAGE_LOW, Skin.COVERAGE_COMPLETE],
			transformationCoverage: function(coverage: int): Transformation {
				return CoC.instance.transformations.SkinDragonScales(coverage);
			}
		});

		public static const CHITIN:int = 4;
		EnumValue.add(Memories, CHITIN, "CHITIN", {
			id: "Chitin Skin",
			name: "Chitin",
			cost: 100,
			title: "Chitin",
			availableCoverages: [Skin.COVERAGE_LOW, Skin.COVERAGE_COMPLETE],
			transformationCoverage: function(coverage: int): Transformation {
				return CoC.instance.transformations.SkinChitin(coverage);
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
