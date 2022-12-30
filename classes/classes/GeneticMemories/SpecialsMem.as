package classes.GeneticMemories {
	import classes.BaseContent;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

	public class SpecialsMem extends BaseContent {
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

		public static const NO_OVIPOSITOR:int = _partid++;
		EnumValue.add(Memories, NO_OVIPOSITOR, "NO_OVIPOSITOR", {
			id: "Unlocked Metamorph",
			name: "Remove Ovipositor",
			cost: 400,
			title: "No Ovipositor",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RemoveOvipositor;
			}
		});

		public static const OVIPOSITOR:int = _partid++;
		EnumValue.add(Memories, OVIPOSITOR, "OVIPOSITOR", {
			id: "Gain Ovipositor",
			name: "Gain Ovipositor",
			cost: 400,
			title: "Ovipositor",
			hint: "Need to get any ovipositor and a compatible abdomen first (bee, spider, mantis, ant)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.GainOvipositor;
			}
		});

		public static const NO_OVIPOSITION:int = _partid++;
		EnumValue.add(Memories, NO_OVIPOSITION, "NO_OVIPOSITION", {
			id: "Unlocked Metamorph",
			name: "Remove Oviposition",
			cost: 400,
			title: "No Oviposition",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RemoveOviposition;
			}
		});

		public static const OVIPOSITION:int = _partid++;
		EnumValue.add(Memories, OVIPOSITION, "OVIPOSITION", {
			id: "Gain Oviposition",
			name: "Gain Oviposition",
			cost: 400,
			title: "Oviposition",
			hint: "Need to be a compatible race first",
			transformation: function(): Transformation {
				return CoC.instance.transformations.GainOviposition;
			}
		});

		public static const GLOWINGASSHOLE:int = _partid++;
		EnumValue.add(Memories, GLOWINGASSHOLE, "GLOWINGASSHOLE", {
			id: "Glowing Asshole",
			name: "Glowing Asshole",
			cost: 200,
			title: "Glow Asshole",
			transformation: function(): Transformation {
				return CoC.instance.transformations.AssholeGlowing;
			}
		});

		public static const PLAINASSHOLE:int = _partid++;
		EnumValue.add(Memories, PLAINASSHOLE, "PLAINASSHOLE", {
			id: "Unlocked Metamorph",
			name: "Normal Asshole",
			cost: 200,
			title: "Plain Asshole",
			transformation: function(): Transformation {
				return CoC.instance.transformations.AssholeNormal;
			}
		});


		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
	}
}
