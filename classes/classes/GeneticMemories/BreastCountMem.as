package classes.GeneticMemories {
	import classes.BaseContent;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

	public class BreastCountMem extends BaseContent {
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

		public static const BREAST1:int = 0;
		EnumValue.add(Memories, BREAST1, "BREAST1", {
			id: "One Breast Row",
			name: "One Breast Row",
			title: "BREAST1"
		});

		public static const BREAST2:int = 1;
		EnumValue.add(Memories, BREAST2, "BREAST2", {
			id: "Two Breast Rows",
			name: "Two Breast Rows",
			title: "BREAST2"
		});

		public static const BREAST3:int = 2;
		EnumValue.add(Memories, BREAST3, "BREAST3", {
			id: "Three Breast Rows",
			name: "Three Breast Rows",
			title: "BREAST3"
		});

		public static const BREAST4:int = 3;
		EnumValue.add(Memories, BREAST4, "BREAST4", {
			id: "Four Breast Rows",
			name: "Four Breast Rows",
			title: "BREAST4"
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
	}
}
