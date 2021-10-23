package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Skin;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class SkinPatternMem extends BaseContent {
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
			name: "No Skin Pattern",
			cost: 500,
			title: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternNone;
			}
		});

		public static const MAGICAL:int = 1;
		EnumValue.add(Memories, MAGICAL, "MAGICAL", {
			id: "Kitsune Skin Pattern",
			name: "Runic Kitsune Tattoos",
			cost: 100,
			title: "Kitsune",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternKitsune
			}
		});

		public static const BATTLE:int = 2;
		EnumValue.add(Memories, BATTLE, "BATTLE", {
			id: "Oni Skin Pattern",
			name: "Oni Battle Tattoos",
			cost: 100,
			title: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternOni
			}
		});

		public static const LIGHTNING_SHAPED:int = 3;
		EnumValue.add(Memories, LIGHTNING_SHAPED, "LIGHTNING_SHAPED", {
			id: "Raiju Skin Pattern",
			name: "Lightning-shaped Raiju Tattoos",
			cost: 100,
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternRaiju
			}
		});

		public static const SCAR_SHAPED:int = 4;
		EnumValue.add(Memories, SCAR_SHAPED, "SCAR_SHAPED", {
			id: "Orc Skin Pattern",
			name: "Scar-shaped Orc Tattoos",
			cost: 100,
			title: "Orc",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternOrc
			}
		});

		public static const OIL:int = 5;
		EnumValue.add(Memories, OIL, "OIL", {
			id: "Gazer Skin Pattern",
			name: "Drips black fluids",
			cost: 100,
			title: "Gazer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternOil
			}
		});

		public static const BEE_STRIPES:int = 6;
		EnumValue.add(Memories, BEE_STRIPES, "BEE_STRIPES", {
			id: "Bee Skin Pattern",
			name: "Bee Stripes",
			cost: 200,
			title: "Bee Stripes",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternBeeStripes
			},
			info: "Includes Chitin skin"
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
