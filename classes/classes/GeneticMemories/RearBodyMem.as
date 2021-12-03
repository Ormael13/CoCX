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
			name: "No Rear Body",
			cost: 500,
			title: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyNone;
			}
		});

		public static const LION_MANE:int = 1;
		EnumValue.add(Memories, LION_MANE, "LION_MANE", {
			id: "Lion Mane Rear Body",
			name: "Lion Mane",
			cost: 100,
			title: "Lion",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyLionMane;
			}
		});

		public static const SHARK_FIN:int = 2;
		EnumValue.add(Memories, SHARK_FIN, "SHARK_FIN", {
			id: "Shark Fin Rear Body",
			name: "Shark Fin",
			cost: 100,
			title: "Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodySharkFin;
			}
		});

		public static const ORCA_BLOWHOLE:int = 3;
		EnumValue.add(Memories, ORCA_BLOWHOLE, "ORCA_BLOWHOLE", {
			id: "Orca Blowhole Rear Body",
			name: "Orca Blowhole",
			cost: 100,
			title: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyOrcaBlowhole;
			}
		});

		public static const RAIJU_MANE:int = 4;
		EnumValue.add(Memories, RAIJU_MANE, "RAIJU_MANE", {
			id: "Raiju Mane Rear Body",
			name: "Raiju Mane",
			cost: 100,
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyRaijuMane;
			}
		});

		public static const BAT_COLLAR:int = 5;
		EnumValue.add(Memories, BAT_COLLAR, "BAT_COLLAR", {
			id: "Bat Collar Rear Body",
			name: "Bat Collar",
			cost: 100,
			title: "Bat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyBatCollar;
			}
		});

		public static const DISPLACER_TENTACLES:int = 6;
		EnumValue.add(Memories, DISPLACER_TENTACLES, "DISPLACER_TENTACLES", {
			id: "Displacer Tentacles Rear Body",
			name: "Displacer Tentacles",
			cost: 100,
			title: "Displacer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyDisplacerTentacles;
			}
		});

		public static const TENTACLE_EYESTALKS:int = 7;
		EnumValue.add(Memories, TENTACLE_EYESTALKS, "TENTACLE_EYESTALKS", {
			id: "Gazer Tentacle Eyestalks Rear Body",
			name: "Gazer Tentacle Eyestalks",
			cost: 100,
			title: "Gazer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyTentacleEyestalks;
			}
		});

		public static const FROSTWYRM:int = 8;
		EnumValue.add(Memories, FROSTWYRM, "FROSTWYRM", {
			id: "Frostwyrm Rear Body",
			name: "Frostwyrm Collar",
			cost: 100,
			title: "Frostwyrm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.RearBodyFrostwyrm;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
