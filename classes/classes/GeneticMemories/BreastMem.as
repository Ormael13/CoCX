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
		private static var _partid:int = 0;

		public static const NONE:int = _partid++;
		EnumValue.add(Memories, NONE, "NONE", {
			id: "Unlocked Metamorph",
			name: "No Breasts",
			cost: 500,
			title: "No Breasts",
			transformation: function(): Transformation {
				return CoC.instance.transformations.BreastsShrinkToNothing;
			}
		});

		public static const BREAST1:int = _partid++;
		EnumValue.add(Memories, BREAST1, "BREAST1", {
			id: "One Breast Row",
			name: "One Breast Row",
			cost: 200,
			title: "Breast row 1",
			transformation: function(): Transformation {
				return CoC.instance.transformations.BreastRowsOne;
			}
		});

		public static const BREAST2:int = _partid++;
		EnumValue.add(Memories, BREAST2, "BREAST2", {
			id: "Two Breast Rows",
			name: "Two Breast Rows",
			cost: 200,
			title: "Breast row 2",
			permReq: "One Breast Row",
			transformation: function(): Transformation {
				return CoC.instance.transformations.BreastRowsTwo;
			}
		});

		public static const BREAST3:int = _partid++;
		EnumValue.add(Memories, BREAST3, "BREAST3", {
			id: "Three Breast Rows",
			name: "Three Breast Rows",
			cost: 200,
			title: "Breast row 3",
			permReq: "Two Breast Rows",
			transformation: function(): Transformation {
				return CoC.instance.transformations.BreastRowsThree;
			}
		});

		public static const BREAST4:int = _partid++;
		EnumValue.add(Memories, BREAST4, "BREAST4", {
			id: "Four Breast Rows",
			name: "Four Breast Rows",
			cost: 200,
			title: "Breast row 4",
			permReq: "Three Breast Rows",
			transformation: function(): Transformation {
				return CoC.instance.transformations.BreastRowsFour;
			}
		});

		public static const NOLACTATE:int = _partid++;
		EnumValue.add(Memories, NOLACTATE, "NOLACTATE", {
			id: "Unlocked Metamorph",
			name: "No Lactate",
			cost: 200,
			title: "No Lactation",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RemoveLactation;
			}
		});

		public static const STARTLACTATE:int = _partid++;
		EnumValue.add(Memories, STARTLACTATE, "STARTLACTATE", {
			id: "Unlocked Metamorph",
			name: "Start Lactate",
			cost: 200,
			title: "Lactation",
			transformation: function(): Transformation {
				return CoC.instance.transformations.StartLactation;
			}
		});

		public static const ONENIPPLE:int = _partid++;
		EnumValue.add(Memories, ONENIPPLE, "ONENIPPLE", {
			id: "Unlocked Metamorph",
			name: "One Nipple",
			cost: 200,
			title: "One Nipple",
			transformation: function(): Transformation {
				return CoC.instance.transformations.NipplesPerBreastOne;
			}
		});

		public static const QUADNIPPLE:int = _partid++;
		EnumValue.add(Memories, QUADNIPPLE, "QUADNIPPLE", {
			id: "Quad Nipples",
			name: "Quad Nipples",
			cost: 200,
			title: "Quad Nipples",
			transformation: function(): Transformation {
				return CoC.instance.transformations.NipplesPerBreastFour;
			}
		});

		public static const FUCKNIPPLE:int = _partid++;
		EnumValue.add(Memories, FUCKNIPPLE, "FUCKNIPPLE", {
			id: "Fuckable Nipples",
			name: "Fuckable Nipples",
			cost: 200,
			title: "Fuckable",
			transformation: function(): Transformation {
				return CoC.instance.transformations.NipplesFuckableForce;
			}
		});

		public static const UNFUCKNIPPLE:int = _partid++;
		EnumValue.add(Memories, UNFUCKNIPPLE, "UNFUCKNIPPLE", {
			id: "Unlocked Metamorph",
			name: "Non-Fuckable Nips",
			cost: 200,
			title: "Non-Fuckable",
			transformation: function(): Transformation {
				return CoC.instance.transformations.NipplesUnfuck;
			}
		});

		public static const BLACKNIPPLE:int = _partid++;
		EnumValue.add(Memories, BLACKNIPPLE, "BLACKNIPPLE", {
			id: "Black Nipples",
			name: "Black Nipples",
			cost: 200,
			title: "Black Nipples",
			transformation: function(): Transformation {
				return CoC.instance.transformations.NipplesBlack;
			}
		});

		public static const GLOWINGNIPPLE:int = _partid++;
		EnumValue.add(Memories, GLOWINGNIPPLE, "GLOWINGNIPPLE", {
			id: "Glowing Nipples",
			name: "Glowing Nipples",
			cost: 200,
			title: "Glow Nipples",
			transformation: function(): Transformation {
				return CoC.instance.transformations.NipplesGlowing;
			}
		});

		public static const DEFAULTNIPPLE:int = _partid++;
		EnumValue.add(Memories, DEFAULTNIPPLE, "DEFAULTNIPPLE", {
			id: "Unlocked Metamorph",
			name: "Regular Nipples",
			cost: 200,
			title: "Reg. Nipples",
			transformation: function(): Transformation {
				return CoC.instance.transformations.NipplesNoColor;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
	}
}
