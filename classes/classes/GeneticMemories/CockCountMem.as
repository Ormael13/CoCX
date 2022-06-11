package classes.GeneticMemories {
	import classes.BaseContent;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

	public class CockCountMem extends BaseContent {
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

		public static const COCK1:int = 0;
		EnumValue.add(Memories, COCK1, "COCK1", {
			id: "One Cock",
			name: "One Cock",
			title: "COCK1"
		});

		public static const COCK2:int = 1;
		EnumValue.add(Memories, COCK2, "COCK2", {
			id: "Two Cocks",
			name: "Two Cocks",
			title: "COCK2"
		});

		public static const COCK3:int = 2;
		EnumValue.add(Memories, COCK3, "COCK3", {
			id: "Three Cocks",
			name: "Three Cocks",
			title: "COCK3"
		});

		public static const COCK4:int = 3;
		EnumValue.add(Memories, COCK4, "COCK4", {
			id: "Four Cocks",
			name: "Four Cocks",
			title: "COCK4"
		});

		public static const COCK5:int = 4;
		EnumValue.add(Memories, COCK5, "COCK5", {
			id: "Five Cocks",
			name: "Five Cocks",
			title: "COCK5"
		});

		public static const COCK6:int = 5;
		EnumValue.add(Memories, COCK6, "COCK6", {
			id: "Six Cocks",
			name: "Six Cocks",
			title: "COCK6"
		});

		public static const COCK7:int = 6;
		EnumValue.add(Memories, COCK7, "COCK7", {
			id: "Seven Cocks",
			name: "Seven Cocks",
			title: "COCK7"
		});

		public static const COCK8:int = 7;
		EnumValue.add(Memories, COCK8, "COCK8", {
			id: "Eight Cocks",
			name: "Eight Cocks",
			title: "COCK8"
		});

		public static const COCK9:int = 8;
		EnumValue.add(Memories, COCK9, "COCK9", {
			id: "Nine Cocks",
			name: "Nine Cocks",
			title: "COCK9"
		});

		public static const COCK10:int = 9;
		EnumValue.add(Memories, COCK10, "COCK10", {
			id: "Ten Cocks",
			name: "Ten Cocks",
			title: "COCK10"
		});


		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
	}
}
