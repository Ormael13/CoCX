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
	 * - id: the identificator of the Metamorph inside GeneticStorage
	 * - cost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - title: name displayed on the metamorph button
	 * - transformation: TF object that refers to what the metamorph does
	 *
	 * Optional properties:
	 * - info: additional text to be shown underneath the Metamorph cost in the menu when hovering over a button

	 * Template:

		public static const [NAME HERE]:int = [ID HERE];
		EnumValue.add(Memories, [NAME HERE], "[NAME HERE]", {
			id: [Name Saved in GeneticStorage],
			cost: [Cost Here],
			title: "[Race Here]",
			transformation: function(): Transformation {
				return CoC.instance.transformations.[TF Object from TransformationLib];
			}
		});

	 */

    public static var Memories:/*EnumValue*/ Array = [];

		public static const NONE:int = 0;
		EnumValue.add(Memories, NONE, "NONE", {
			id: "No Rear Body",
			cost: 500,
			title: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyNone;
			}
		});

		public static const LION_MANE:int = 1;
		EnumValue.add(Memories, LION_MANE, "LION_MANE", {
			id: "Lion Mane Rear Body",
			cost: 100,
			title: "Lion",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyLionMane;
			}
		});

		public static const SHARK_FIN:int = 2;
		EnumValue.add(Memories, SHARK_FIN, "SHARK_FIN", {
			id: "Shark Fin Rear Body",
			cost: 100,
			title: "Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodySharkFin;
			}
		});

		public static const ORCA_BLOWHOLE:int = 3;
		EnumValue.add(Memories, ORCA_BLOWHOLE, "ORCA_BLOWHOLE", {
			id: "Orca Blowhole Rear Body",
			cost: 100,
			title: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyOrcaBlowhole;
			}
		});

		public static const RAIJU_MANE:int = 4;
		EnumValue.add(Memories, RAIJU_MANE, "RAIJU_MANE", {
			id: "Raiju Mane Rear Body",
			cost: 100,
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyRaijuMane;
			}
		});

		public static const BAT_COLLAR:int = 5;
		EnumValue.add(Memories, BAT_COLLAR, "BAT_COLLAR", {
			id: "Bat Collar Rear Body",
			cost: 100,
			title: "Bat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyBatCollar;
			}
		});

		public static const DISPLACER_TENTACLES:int = 6;
		EnumValue.add(Memories, DISPLACER_TENTACLES, "DISPLACER_TENTACLES", {
			id: "Displacer Tentacles Rear Body",
			cost: 100,
			title: "Displacer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyDisplacerTentacles;
			}
		});

  }
}
