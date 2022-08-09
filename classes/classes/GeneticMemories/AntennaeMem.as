package classes.GeneticMemories {
	import classes.BaseContent;
	import classes.StatusEffects;
	import classes.BodyParts.*;
	import classes.BodyParts.Antennae;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

	public class AntennaeMem extends BaseContent {
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
			name: "No Antennae",
			cost: 500,
			title: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.AntennaeNone;
			}
		});

        public static const ANT:int = _partid++;
        EnumValue.add(Memories, ANT, "ANT", {
            id: "Ant Antennae",
            name: "Ant Antennae",
            cost: 100,
            title: "Ant",
            transformation: function(): Transformation {
                return CoC.instance.transformations.AntennaeAnt;
            }
        });

        public static const BEE:int = _partid++;
        EnumValue.add(Memories, BEE, "BEE", {
            id: "Bee Antennae",
            name: "Bee Antennae",
            cost: 100,
            title: "Bee",
            transformation: function(): Transformation {
                return CoC.instance.transformations.AntennaeBee;
            }
        });

        public static const CENTIPEDE:int = _partid++;
        EnumValue.add(Memories, CENTIPEDE, "CENTIPEDE", {
            id: "Centipede Antennae",
            name: "Centipede Antennae",
            cost: 100,
            title: "Centipede",
            transformation: function(): Transformation {
                return CoC.instance.transformations.AntennaeCentipede;
            }
        });

        public static const FIRE_SNAIL:int = _partid++;
        EnumValue.add(Memories, FIRE_SNAIL, "FIRE_SNAIL", {
            id: "Fire Snail Antennae",
            name: "Fire Snail  Antennae",
            cost: 100,
            title: "Fire Snail",
            transformation: function(): Transformation {
                return CoC.instance.transformations.AntennaeFireSnail;
            }
        });

        public static const JABBERWOCKY:int = _partid++;
        EnumValue.add(Memories, JABBERWOCKY, "JABBERWOCKY", {
            id: "Jabberwocky Antennae",
            name: "Jabberwocky Antennae",
            cost: 100,
            title: "Jabberwocky",
            transformation: function(): Transformation {
                return CoC.instance.transformations.AntennaeJabberwocky;
            }
        });

		public static const MANTIS:int = _partid++;
		EnumValue.add(Memories, MANTIS, "MANTIS", {
			id: "Mantis Antennae",
			name: "Mantis Antennae",
			cost: 100,
			title: "Mantis",
			transformation: function(): Transformation {
				return CoC.instance.transformations.AntennaeMantis;
			}
		});

		public static const SEA_DRAGON:int = _partid++;
		EnumValue.add(Memories, SEA_DRAGON, "SEA_DRAGON", {
			id: "Sea Dragon Antennae",
			name: "Sea Dragon Antennae",
			cost: 100,
			title: "Sea Dragon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.AntennaeSeaDragon;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
