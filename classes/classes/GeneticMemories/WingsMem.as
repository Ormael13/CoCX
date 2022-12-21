package classes.GeneticMemories {
  import classes.BaseContent;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class WingsMem extends BaseContent {
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
			name: "No Wings",
			cost: 500,
			title: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsNone;
			}
		});

	  public static const ANT_SMALL:int = _partid++;
	  EnumValue.add(Memories, ANT_SMALL, "ANT_SMALL", {
		  id: "Ant Small Wings",
		  name: "Small Ant Wings",
		  cost: 100,
		  title: "Ant(S)",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsAntSmall;
		  }
	  });

	  public static const ANT_LARGE:int = _partid++;
	  EnumValue.add(Memories, ANT_LARGE, "ANT_LARGE", {
		  id: "Ant Large Wings",
		  name: "Large Ant Wings",
		  cost: 200,
		  title: "Ant(L)",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsAntLarge;
		  }
	  });

		public static const BEE_SMALL:int = _partid++;
		EnumValue.add(Memories, BEE_SMALL, "BEE_SMALL", {
			id: "Bee Small Wings",
			name: "Small Bee Wings",
			cost: 100,
			title: "Bee(S)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsBeeSmall;
			}
		});

		public static const BEE_LARGE:int = _partid++;
		EnumValue.add(Memories, BEE_LARGE, "BEE_LARGE", {
			id: "Bee Large Wings",
			name: "Large Bee Wings",
			cost: 200,
			title: "Bee(L)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsBeeLarge;
			}
		});

	  public static const COUATL:int = _partid++;
	  EnumValue.add(Memories, COUATL, "COUATL", {
		  id: "Couatl Wings",
		  name: "Couatl Wings",
		  cost: 200,
		  title: "Couatl",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsCouatl;
		  }
	  });

		public static const DEMONIC_TINY:int = _partid++;
		EnumValue.add(Memories, DEMONIC_TINY, "DEMONIC_TINY", {
			id: "Demonic Small Wings",
			name: "Small Demonic Wings",
			cost: 100,
			title: "Demonic(S)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsDemonicTiny;
			}
		});

		public static const DEMONIC_LARGE:int = _partid++;
		EnumValue.add(Memories, DEMONIC_LARGE, "DEMONIC_LARGE", {
			id: "Demonic Large Wings",
			name: "Large Demonic Wings",
			cost: 200,
			title: "Demonic(L)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsDemonicLarge;
			}
		});

		// UNUSED
		// public static const DEMONIC_LARGE_X4:int = 5
		// EnumValue.add(Memories, DEMONIC_LARGE_X4, "DEMONIC_LARGE_X4", {
		// 	id: "Demonic Large Quadruple Wings",
		// 	cost: 300,
		// 	title: "Demonic(L) x4",
		// 	transformation: function(): Transformation {
		// 		return CoC.instance.transformations.WingsDemonicQuadrupleLarge;
		// 	}
		// });

	  public static const DEVILFEATHER:int = _partid++;
	  EnumValue.add(Memories, DEVILFEATHER, "DEVILFEATHER", {
		  id: "Devil Feather Wings",
		  name: "Devil Feather Wings",
		  cost: 100,
		  title: "Devilfeather",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsDevilfeather;
		  }
	  });

	  public static const PUREDEVILFEATHER:int = _partid++;
	  EnumValue.add(Memories, PUREDEVILFEATHER, "PUREDEVILFEATHER", {
		  id: "Pure Devil Feather Wings",
		  name: "Pure Devil Feather Wings",
		  cost: 100,
		  title: "Pure Devilfeather",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsPureDevilfeather;
		  }
	  });

		public static const DRACONIC_SMALL:int = _partid++;
		EnumValue.add(Memories, DRACONIC_SMALL, "DRACONIC_SMALL", {
			id: "Draconic Small Wings",
			name: "Small Draconic Wings",
			cost: 100,
			title: "Draconic(S)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsDraconicSmall;
			}
		});

		public static const DRACONIC_LARGE:int = _partid++;
		EnumValue.add(Memories, DRACONIC_LARGE, "DRACONIC_LARGE", {
			id: "Draconic Large Wings",
			name: "Large Draconic Wings",
			cost: 200,
			title: "Draconic(L)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsDraconicLarge;
			}
		});

		public static const DRACONIC_HUGE:int = _partid++;
		EnumValue.add(Memories, DRACONIC_HUGE, "DRACONIC_HUGE", {
			id: "Draconic Huge Wings",
			name: "Huge Draconic Wings",
			cost: 300,
			title: "Draconic(H)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsDraconicHuge;
			}
		});

	  public static const ETHEREAL:int = _partid++;
	  EnumValue.add(Memories, ETHEREAL, "ETHEREAL", {
		  id: "Ethereal Wings",
		  name: "Ethereal Wings",
		  cost: 100,
		  title: "Ethereal",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsEthereal;
		  }
	  });

	  public static const FAIRY:int = _partid++;
	  EnumValue.add(Memories, FAIRY, "FAIRY", {
		  id: "Fairy Wings",
		  name: "Fairy Wings",
		  cost: 100,
		  title: "Fairy",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsFairy;
		  }
	  });

	  public static const FEATHERED_ALICORN:int = _partid++;
	  EnumValue.add(Memories, FEATHERED_ALICORN, "FEATHERED_ALICORN", {
		  id: "Feathered Alicorn Wings",
		  name: "Feathered Alicorn Wings",
		  cost: 200,
		  title: "Alicorn",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsFeatheredAlicorn;
		  }
	  });

	  public static const FEATHERED_AVIAN:int = _partid++;
	  EnumValue.add(Memories, FEATHERED_AVIAN, "FEATHERED_AVIAN", {
		  id: "Feathered Avian Wings",
		  name: "Feathered Avian Wings",
		  cost: 100,
		  title: "FeatheredAvian",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsFeatheredAvian;
		  }
	  });

	  public static const FEATHERED_LARGE:int = _partid++;
	  EnumValue.add(Memories, FEATHERED_LARGE, "FEATHERED_LARGE", {
		  id: "Feathered Large Wings",
		  name: "Large Feathered Wings",
		  cost: 100,
		  title: "Feathered",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsFeatheredLarge;
		  }
	  });

		public static const FEATHERED_PHOENIX:int = _partid++;
		EnumValue.add(Memories, FEATHERED_PHOENIX, "FEATHERED_PHOENIX", {
			id: "Feathered Phoenix Wings",
			name: "Feathered Phoenix Wings",
			cost: 100,
			title: "Phoenix",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsFeatheredPhoenix;
			}
		});

	  public static const FEATHERED_SPHINX:int = _partid++;
	  EnumValue.add(Memories, FEATHERED_SPHINX, "FEATHERED_SPHINX", {
		  id: "Feathered Sphinx Wings",
		  name: "Feathered Sphinx Wings",
		  cost: 100,
		  title: "Sphinx",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsFeatheredSphinx;
		  }
	  });

	  public static const GIANT_DRAGONFLY:int = _partid++;
	  EnumValue.add(Memories, GIANT_DRAGONFLY, "GIANT_DRAGONFLY", {
		  id: "Giant Dragonfly Wings",
		  name: "Giant Dragonfly Wings",
		  cost: 100,
		  title: "Dragonfly",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsGiantDragonfly;
		  }
	  });

	  public static const JABBERWOCKY:int = _partid++;
	  EnumValue.add(Memories, JABBERWOCKY, "JABBERWOCKY", {
		  id: "Jabberwocky Wings",
		  name: "Jabberwocky Wings",
		  cost: 100,
		  title: "Jabberwocky",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsJabberwocky;
		  }
	  });

	  public static const FEY_DRAGON:int = _partid++;
	  EnumValue.add(Memories, FEY_DRAGON, "FEY_DRAGON", {
		  id: "FeyDragon Wings",
		  name: "FeyDragon Wings",
		  cost: 100,
		  title: "FeyDragon",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsFeyDragon;
		  }
	  });

	  public static const LEVITATION:int = _partid++;
	  EnumValue.add(Memories, LEVITATION, "LEVITATION", {
		  id: "Levitation (Wings)",
		  name: "Levitation (Wings)",
		  cost: 100,
		  title: "Levitation",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsLevitation;
		  }
	  });

		public static const MANTICORE_SMALL:int = _partid++;
		EnumValue.add(Memories, MANTICORE_SMALL, "MANTICORE_SMALL", {
			id: "Manticore Small Wings",
			name: "Small Manticore Wings",
			cost: 100,
			title: "Manticore(S)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsManticoreSmall;
			}
		});

		public static const MANTICORE_LARGE:int = _partid++;
		EnumValue.add(Memories, MANTICORE_LARGE, "MANTICORE_LARGE", {
			id: "Manticore Large Wings",
			name: "Large Manticore Wings",
			cost: 200,
			title: "Manticore(L)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsManticoreLarge;
			}
		});

	  public static const MANTIS_SMALL:int = _partid++;
	  EnumValue.add(Memories, MANTIS_SMALL, "MANTIS_SMALL", {
		  id: "Mantis Small Wings",
		  name: "Small Mantis Wings",
		  cost: 100,
		  title: "Mantis(S)",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsMantisSmall;
		  }
	  });

	  public static const MANTIS_LARGE:int = _partid++;
	  EnumValue.add(Memories, MANTIS_LARGE, "MANTIS_LARGE", {
		  id: "Mantis Large Wings",
		  name: "Large Mantis Wings",
		  cost: 200,
		  title: "Mantis(L)",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsMantisLarge;
		  }
	  });

		public static const NIGHTMARE:int = _partid++;
		EnumValue.add(Memories, NIGHTMARE, "NIGHTMARE", {
			id: "Nightmare Wings",
			name: "Nightmare Wings",
			cost: 200,
			title: "Nightmare",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsNightmare;
			}
		});

	  public static const PLANT:int = _partid++;
	  EnumValue.add(Memories, PLANT, "PLANT", {
		  id: "Plant Wings",
		  name: "Plant Wings",
		  cost: 100,
		  title: "Plant",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsPlant;
		  }
	  });

	  public static const SEA_DRAGON:int = _partid++;
	  EnumValue.add(Memories, SEA_DRAGON, "SEA_DRAGON", {
		  id: "SeaDragon Wings",
		  name: "SeaDragon Wings",
		  cost: 100,
		  title: "SeaDragon",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsSeaDragon;
		  }
	  });

		public static const THUNDEROUS_AURA:int = _partid++;
		EnumValue.add(Memories, THUNDEROUS_AURA, "THUNDEROUS_AURA", {
			id: "Thunderous Aura (Wings)",
			name: "Thunderous Aura (Wings)",
			cost: 100,
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsThunderousAura;
			}
		});

	  public static const VAMPIRE:int = _partid++;
	  EnumValue.add(Memories, VAMPIRE, "VAMPIRE", {
		  id: "Vampire Wings",
		  name: "Vampire \"Wings\"",
		  cost: 100,
		  title: "Vampire",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.WingsVampire;
		  }
	  });

		public static const WINDY_AURA:int = _partid++;
		EnumValue.add(Memories, WINDY_AURA, "WINDY_AURA", {
			id: "Windy Aura",
			name: "Windy Aura",
			cost: 100,
			title: "Windy Aura",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsWindyAura;
			}
		});

		public static const YGGDRASIL_LARGE:int = _partid++;
		EnumValue.add(Memories, YGGDRASIL_LARGE, "YGGDRASIL_LARGE", {
			id: "Yggdrasil Large Wings",
			name: "Yggdrasil Large Wings",
			cost: 100,
			title: "Yggdrasil(L)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsYggdrasilLarge;
			}
		});

		public static const YGGDRASIL_HUGE:int = _partid++;
		EnumValue.add(Memories, YGGDRASIL_HUGE, "YGGDRASIL_HUGE", {
			id: "Yggdrasil Huge Wings",
			name: "Yggdrasil Huge Wings",
			cost: 200,
			title: "Yggdrasil(H)",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsYggdrasilHuge;
			}
		});

		public static const YGGDRASIL_HUGE_X4:int = _partid++;
		EnumValue.add(Memories, YGGDRASIL_HUGE_X4, "YGGDRASIL_HUGE_X4", {
			id: "Yggdrasil Huge Quad Wings",
			name: "Yggdrasil Huge Quad Wings",
			cost: 300,
			title: "Yggdrasil(H) x4",
			transformation: function(): Transformation {
				return CoC.instance.transformations.WingsYggdrasilQuadrupleHuge;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
