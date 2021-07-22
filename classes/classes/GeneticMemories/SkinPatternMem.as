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
	 * - metamorphCost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - metamorphTitle: name displayed on the metamorph button
	 * - transformation: TF object that refers to what the metamorph does

	 * Template:

		public static const [NAME HERE]:int = [ID HERE];
		EnumValue.add(Memories, [NAME HERE], "[NAME HERE]", {
			name: [Name Saved in GeneticStorage],
			metamorphCost: [Cost Here],
			metamorphTitle: "[Race Here]",
			transformation: function(): Transformation {
				return CoC.instance.transformations.[TF Object from TransformationLib];
			}
		});

	 */

    public static var Memories:/*EnumValue*/ Array = [];

		public static const NONE:int = 0;
		EnumValue.add(Memories, NONE, "NONE", {
			name: "No Skin Pattern",
			metamorphCost: 500,
			metamorphTitle: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternNone;
			}
		});

		public static const MAGICAL:int = 1;
		EnumValue.add(Memories, MAGICAL, "MAGICAL", {
			name: "Kitsune Skin Pattern",
			metamorphCost: 100,
			metamorphTitle: "Kitsune",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternKitsune
			}
		});

		public static const BATTLE:int = 2;
		EnumValue.add(Memories, BATTLE, "BATTLE", {
			name: "Oni Skin Pattern",
			metamorphCost: 100,
			metamorphTitle: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternOni
			}
		});

		public static const LIGHTNING_SHAPED:int = 3;
		EnumValue.add(Memories, LIGHTNING_SHAPED, "LIGHTNING_SHAPED", {
			name: "Raiju Skin Pattern",
			metamorphCost: 100,
			metamorphTitle: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternRaiju
			}
		});

		public static const SCAR_SHAPED:int = 4;
		EnumValue.add(Memories, SCAR_SHAPED, "SCAR_SHAPED", {
			name: "Orc Skin Pattern",
			metamorphCost: 100,
			metamorphTitle: "Orc",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternOrc
			}
		});

  }
}
