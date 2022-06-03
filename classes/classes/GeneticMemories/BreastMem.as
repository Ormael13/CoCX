package classes.GeneticMemories {
	import classes.BaseContent;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

	public class BreastMem extends BaseContent {
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
			name: "No Breasts",
			cost: 1000,
			title: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.BreastsNone;
			}
		});

		public static const ONE:int = 1;
		EnumValue.add(Memories, ONE, "ONE", {
			id: "One row breasts",
			name: "One row breasts",
			cost: 500,
			title: "One",
			transformation: function(): Transformation {
				return CoC.instance.transformations.BreastsOne;
			}
		});

		public static const TWO:int = 2;
		EnumValue.add(Memories, TWO, "TWO", {
			id: "Two row breasts",
			name: "Two row breasts",
			cost: 500,
			title: "Two",
			transformation: function(): Transformation {
				return CoC.instance.transformations.BreastsTwo;
			}
		});

		public static const THREE:int = 3;
		EnumValue.add(Memories, THREE, "THREE", {
			id: "Three row breasts",
			name: "Three row breasts",
			cost: 500,
			title: "Three",
			transformation: function(): Transformation {
				return CoC.instance.transformations.BreastsThree;
			}
		});

		public static const FOUR:int = 4;
		EnumValue.add(Memories, FOUR, "FOUR", {
			id: "Four row breasts",
			name: "Four row breasts",
			cost: 500,
			title: "Four",
			transformation: function(): Transformation {
				return CoC.instance.transformations.BreastsFour;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
	}
}
