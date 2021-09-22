package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Hair;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class HairMem extends BaseContent {
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

		public static const NORMAL:int = 0;
		EnumValue.add(Memories, NORMAL, "NORMAL", {
			id: "Unlocked Metamorph",
			name: "Human Hair",
			cost: 500,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HairHuman;
			}
		});

		public static const FEATHER:int = 1;
		EnumValue.add(Memories, FEATHER, "FEATHER", {
			id: "Feather Hair",
			name: "Feather Hair",
			cost: 100,
			title: "Feather",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HairFeather;
			}
		});

		public static const GORGON:int = 2;
		EnumValue.add(Memories, GORGON, "GORGON", {
			id: "Gorgon Hair",
			name: "Gorgon \"Hair\" (Snakes)",
			cost: 100,
			title: "Gorgon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HairGorgon;
			}
		});

		public static const ELF:int = 3;
		EnumValue.add(Memories, ELF, "ELF", {
			id: "Silky Hair",
			name: "Silky Hair",
			cost: 100,
			title: "Elf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HairSilky;
			}
		});

		public static const STORM:int = 4;
		EnumValue.add(Memories, STORM, "STORM", {
			id: "Storm Hair",
			name: "Storm Hair",
			cost: 100,
			title: "Storm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HairStorm;
			}
		});

		public static const BURNING:int = 5;
		EnumValue.add(Memories, BURNING, "BURNING", {
			id: "Burning Hair",
			name: "Burning Hair",
			cost: 100,
			title: "Burning",
			transformation: function(): Transformation {
				return CoC.instance.transformations.HairBurning;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
