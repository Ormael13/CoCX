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
	 * - metamorphCost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - metamorphTitle: name displayed on the metamorph button
	 * - transformation: TF object that refers to what the metamorph does

	 * Template:

		public static const [NAME HERE]:int = [ID HERE];
		EnumValue.add(Memories, [NAME HERE], "[NAME HERE]", {
			name: [Full Name to identify],
			metamorphCost: [Cost Here],
			metamorphTitle: "[Race Here]",
			transformation: function(): Transformation {
				return CoC.instance.transformations.[TF Object from TransformationLib];
			}
		});

	 */

    public static var Memories:/*EnumValue*/ Array = [];

		public static const HUMAN:int = 0;
		EnumValue.add(Memories, HUMAN, "HUMAN", {
			name: "Human Tongue",
			metamorphCost: 500,
			metamorphTitle: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueHuman;
			}
		});

		public static const SNAKE:int = 1;
		EnumValue.add(Memories, SNAKE, "SNAKE", {
			name: "Snake Tongue",
			metamorphCost: 100,
			metamorphTitle: "Snake",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueSnake;
			}
		});

		public static const DEMONIC:int = 2;
		EnumValue.add(Memories, DEMONIC, "DEMONIC", {
			name: "Demon Tongue",
			metamorphCost: 100,
			metamorphTitle: "Demon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueDemonic;
			}
		});

		public static const DRACONIC:int = 3;
		EnumValue.add(Memories, DRACONIC, "DRACONIC", {
			name: "Dragon Tongue",
			metamorphCost: 100,
			metamorphTitle: "Dragon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueDraconic;
			}
		});

		public static const CAT:int = 4;
		EnumValue.add(Memories, CAT, "CAT", {
			name: "Cat Tongue",
			metamorphCost: 100,
			metamorphTitle: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueCat;
			}
		});

		public static const ELF:int = 5;
		EnumValue.add(Memories, ELF, "ELF", {
			name: "Elf Tongue",
			metamorphCost: 100,
			metamorphTitle: "Elf",
			transformation: function(): Transformation {
				return CoC.instance.transformations.TongueElf;
			}
		});
  }
}
