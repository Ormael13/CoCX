package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Tongue;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class TongueMem extends BaseContent {
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

		public static const HUMAN:int = 0;
		EnumValue.add(Memories, HUMAN, "HUMAN", {
			id: "Unlocked Metamorph",
			name: "Human Tongue",
			cost: 500,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueHuman;
			}
		});

		public static const SNAKE:int = 1;
		EnumValue.add(Memories, SNAKE, "SNAKE", {
			id: "Snake Tongue",
			name: "Snake Tongue",
			cost: 100,
			title: "Snake",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueSnake;
			}
		});

		public static const DEMONIC:int = 2;
		EnumValue.add(Memories, DEMONIC, "DEMONIC", {
			id: "Demon Tongue",
			name: "Demon Tongue",
			cost: 100,
			title: "Demon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueDemonic;
			}
		});

		public static const DRACONIC:int = 3;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			id: "Draconic Tongue",
			name: "Draconic Tongue",
			cost: 100,
			title: "Dragon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueDraconic;
			}
		});

		public static const CAT:int = 4;
		EnumValue.add(Memories, CAT, "CAT", {
			id: "Cat Tongue",
			name: "Cat Tongue",
			cost: 100,
			title: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueCat;
			}
		});

		public static const ELF:int = 5;
		EnumValue.add(Memories, ELF, "ELF", {
			id: "Elf Tongue",
			name: "Elf Tongue",
			cost: 100,
			title: "Elf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueElf;
			}
		});

		public static const CAVE_WYRM:int = 6;
		EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
			id: "Cave Wyrm Tongue",
			name: "Cave Wyrm Tongue",
			cost: 100,
			title: "Cave Wyrm",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueCaveWyrm;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
