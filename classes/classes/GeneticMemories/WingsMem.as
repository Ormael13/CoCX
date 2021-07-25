package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Wings;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class WingsMem extends BaseContent {
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

		public static const NONE:int = 0
		EnumValue.add(Memories, NONE, "NONE", {
			name: "No Wings",
			metamorphCost: 500,
			metamorphTitle: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsNone;
			}
		});

		public static const BEE_SMALL:int = 1
		EnumValue.add(Memories, BEE_SMALL, "BEE_SMALL", {
			name: "Bee Small Wings",
			metamorphCost: 100,
			metamorphTitle: "Bee(S)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsBeeSmall;
			}
		});

		public static const BEE_LARGE:int = 2
		EnumValue.add(Memories, BEE_LARGE, "BEE_LARGE", {
			name: "Bee Large Wings",
			metamorphCost: 200,
			metamorphTitle: "Bee(L)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsBeeLarge;
			}
		});

		public static const DEMONIC_TINY:int = 3
		EnumValue.add(Memories, DEMONIC_TINY, "DEMONIC_TINY", {
			name: "Demonic Small Wings",
			metamorphCost: 100,
			metamorphTitle: "Demonic(S)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsDemonicTiny;
			}
		});

		public static const DEMONIC_LARGE:int = 4
		EnumValue.add(Memories, DEMONIC_LARGE, "DEMONIC_LARGE", {
			name: "Demonic Large Wings",
			metamorphCost: 200,
			metamorphTitle: "Demonic(L)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsDemonicLarge;
			}
		});

		// UNUSED
		// public static const DEMONIC_LARGE_X4:int = 5
		// EnumValue.add(Memories, DEMONIC_LARGE_X4, "DEMONIC_LARGE_X4", {
		// 	name: "Demonic Large Quadruple Wings",
		// 	metamorphCost: 300,
		// 	metamorphTitle: "Demonic(L) x4",
		// 	transformation: function(): Transformation {
		// 		return CoC.instance.transformations.WingsDemonicQuadrupleLarge;
		// 	}
		// });

		public static const FEATHERED_LARGE:int = 6
		EnumValue.add(Memories, FEATHERED_LARGE, "FEATHERED_LARGE", {
			name: "Harpy Wings",
			metamorphCost: 100,
			metamorphTitle: "Harpy",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsFeatheredLarge;
			}
		});

		public static const DRACONIC_SMALL:int = 7
		EnumValue.add(Memories, DRACONIC_SMALL, "DRACONIC_SMALL", {
			name: "Draconic Small Wings",
			metamorphCost: 100,
			metamorphTitle: "Draconic(S)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsDraconicSmall;
			}
		});

		public static const DRACONIC_LARGE:int = 8
		EnumValue.add(Memories, DRACONIC_LARGE, "DRACONIC_LARGE", {
			name: "Draconic Large Wings",
			metamorphCost: 200,
			metamorphTitle: "Draconic(L)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsDraconicLarge;
			}
		});

		public static const DRACONIC_HUGE:int = 9
		EnumValue.add(Memories, DRACONIC_HUGE, "DRACONIC_HUGE", {
			name: "Draconic Huge Wings",
			metamorphCost: 300,
			metamorphTitle: "Draconic(H)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsDraconicHuge;
			}
		});

		public static const FEATHERED_PHOENIX:int = 10
		EnumValue.add(Memories, FEATHERED_PHOENIX, "FEATHERED_PHOENIX", {
			name: "Phoenix Wings",
			metamorphCost: 100,
			metamorphTitle: "Phoenix",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsFeatheredPhoenix;
			}
		});

		public static const FEATHERED_ALICORN:int = 11
		EnumValue.add(Memories, FEATHERED_ALICORN, "FEATHERED_ALICORN", {
			name: "Alicorn Wings",
			metamorphCost: 200,
			metamorphTitle: "Alicorn",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsFeatheredAlicorn;
			}
		});

		public static const MANTIS_SMALL:int = 12
		EnumValue.add(Memories, MANTIS_SMALL, "MANTIS_SMALL", {
			name: "Mantis Small Wings",
			metamorphCost: 100,
			metamorphTitle: "Mantis(S)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsMantisSmall;
			}
		});

		public static const MANTIS_LARGE:int = 13
		EnumValue.add(Memories, MANTIS_LARGE, "MANTIS_LARGE", {
			name: "Mantis Large Wings",
			metamorphCost: 200,
			metamorphTitle: "Mantis(L)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsMantisLarge;
			}
		});

		public static const MANTICORE_SMALL:int = 14
		EnumValue.add(Memories, MANTICORE_SMALL, "MANTICORE_SMALL", {
			name: "Manticore Small Wings",
			metamorphCost: 100,
			metamorphTitle: "Manticore(S)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsManticoreSmall;
			}
		});

		public static const MANTICORE_LARGE:int = 15
		EnumValue.add(Memories, MANTICORE_LARGE, "MANTICORE_LARGE", {
			name: "Manticore Large Wings",
			metamorphCost: 200,
			metamorphTitle: "Manticore(L)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsManticoreLarge;
			}
		});

		public static const VAMPIRE:int = 16
		EnumValue.add(Memories, VAMPIRE, "VAMPIRE", {
			name: "Vampire Wings",
			metamorphCost: 100,
			metamorphTitle: "Vampire",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsVampire;
			}
		});

		public static const NIGHTMARE:int = 17
		EnumValue.add(Memories, NIGHTMARE, "NIGHTMARE", {
			name: "Nightmare Wings",
			metamorphCost: 200,
			metamorphTitle: "Nightmare",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsNightmare;
			}
		});

		public static const FEATHERED_SPHINX:int = 18
		EnumValue.add(Memories, FEATHERED_SPHINX, "FEATHERED_SPHINX", {
			name: "Sphinx Wings",
			metamorphCost: 100,
			metamorphTitle: "Sphinx",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsFeatheredSphinx;
			}
		});

		public static const THUNDEROUS_AURA:int = 19
		EnumValue.add(Memories, THUNDEROUS_AURA, "THUNDEROUS_AURA", {
			name: "Thunderous Aura (Wings)",
			metamorphCost: 100,
			metamorphTitle: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsThunderousAura;
			}
		});
  }
}
