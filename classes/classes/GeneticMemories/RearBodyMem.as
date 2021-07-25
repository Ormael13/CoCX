package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.RearBody;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class RearBodyMem extends BaseContent {
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
			name: "No Rear Body",
			metamorphCost: 500,
			metamorphTitle: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyNone;
			}
		});

		public static const LION_MANE:int = 1;
		EnumValue.add(Memories, LION_MANE, "LION_MANE", {
			name: "Lion Mane Rear Body",
			metamorphCost: 100,
			metamorphTitle: "Lion",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyLionMane;
			}
		});

		public static const SHARK_FIN:int = 2;
		EnumValue.add(Memories, SHARK_FIN, "SHARK_FIN", {
			name: "Shark Fin Rear Body",
			metamorphCost: 100,
			metamorphTitle: "Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodySharkFin;
			}
		});

		public static const ORCA_BLOWHOLE:int = 3;
		EnumValue.add(Memories, ORCA_BLOWHOLE, "ORCA_BLOWHOLE", {
			name: "Orca Blowhole Rear Body",
			metamorphCost: 100,
			metamorphTitle: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyOrcaBlowhole;
			}
		});

		public static const RAIJU_MANE:int = 4;
		EnumValue.add(Memories, RAIJU_MANE, "RAIJU_MANE", {
			name: "Raiju Mane Rear Body",
			metamorphCost: 100,
			metamorphTitle: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyRaijuMane;
			}
		});

		public static const BAT_COLLAR:int = 5;
		EnumValue.add(Memories, BAT_COLLAR, "BAT_COLLAR", {
			name: "Bat Collar Rear Body",
			metamorphCost: 100,
			metamorphTitle: "Bat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyBatCollar;
			}
		});

		public static const DISPLACER_TENTACLES:int = 6;
		EnumValue.add(Memories, DISPLACER_TENTACLES, "DISPLACER_TENTACLES", {
			name: "Displacer Tentacles Rear Body",
			metamorphCost: 100,
			metamorphTitle: "Displacer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyDisplacerTentacles;
			}
		});

  }
}
