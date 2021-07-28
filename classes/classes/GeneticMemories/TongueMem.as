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

		public static const HUMAN:int = 0;
		EnumValue.add(Memories, HUMAN, "HUMAN", {
			id: "Human Tongue",
			cost: 500,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueHuman;
			}
		});

		public static const SNAKE:int = 1;
		EnumValue.add(Memories, SNAKE, "SNAKE", {
			id: "Snake Tongue",
			cost: 100,
			title: "Snake",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueSnake;
			}
		});

		public static const DEMONIC:int = 2;
		EnumValue.add(Memories, DEMONIC, "DEMONIC", {
			id: "Demon Tongue",
			cost: 100,
			title: "Demon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueDemonic;
			}
		});

		public static const DRACONIC:int = 3;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			id: "Dragon Tongue",
			cost: 100,
			title: "Dragon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueDraconic;
			}
		});

		public static const CAT:int = 4;
		EnumValue.add(Memories, CAT, "CAT", {
			id: "Cat Tongue",
			cost: 100,
			title: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueCat;
			}
		});

		public static const ELF:int = 5;
		EnumValue.add(Memories, ELF, "ELF", {
			id: "Elf Tongue",
			cost: 100,
			title: "Elf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueElf;
			}
		});
  }
}
