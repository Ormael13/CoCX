package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.LowerBody;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class LowerBodyMem extends BaseContent {
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
	 * - taurVariant: the Metamorph is a Taur variant of another and should only be displayed after the player became Taur at least once

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

		public static const HUMAN: int = _partid++;
		EnumValue.add(Memories, HUMAN, "HUMAN", {
		  id: "Unlocked Metamorph",
			name: "Human Legs",
		  cost: 500,
		  title: "Human",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyHuman
		  }
		});

		public static const TAUR: int = _partid++;
		EnumValue.add(Memories, TAUR, "TAUR", {
		  id: "Taur Lower Body",
			name: "Taur Lower Body",
		  cost: 100,
		  title: "Taur",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyTaur()
		  }
		});

		public static const HOOFED: int = _partid++;
		EnumValue.add(Memories, HOOFED, "HOOFED", {
		  id: "Hoofed Lower Body",
			name: "Hooves (Legs)",
		  cost: 100,
		  title: "Hoofed",
			unlockText: "Now you can metamorph into the Taur variant of any lower body part you unlocked when available!",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyHoofed(2)
		  }
		});

		public static const HOOFED_TAUR: int = _partid++;
		EnumValue.add(Memories, HOOFED_TAUR, "HOOFED_TAUR", {
		  id: "Hoofed Lower Body",
			name: "Hooves (Legs)",
		  cost: 200,
		  title: "Hoofed (4)",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyHoofed(4)
		  },
			taurVariant: true
		});

		public static const NAGA: int = _partid++;
		EnumValue.add(Memories, NAGA, "NAGA", {
		  id: "Snake Lower Body",
			name: "Naga Lower Body",
		  cost: 100,
		  title: "Naga",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodySnake
		  }
		});

		public static const DEMONIC_HIGH_HEELS: int = _partid++;
		EnumValue.add(Memories, DEMONIC_HIGH_HEELS, "DEMONIC_HIGH_HEELS", {
		  id: "Demon High Heels Lower Body",
			name: "Demonic High Heels",
		  cost: 100,
		  title: "Dem. H. Heels",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyDemonHighHeels
		  }
		});

		public static const DEMONIC_CLAWS: int = _partid++;
		EnumValue.add(Memories, DEMONIC_CLAWS, "DEMONIC_CLAWS", {
		  id: "Demon Clawed Lower Body",
			name: "Demonic Clawed Feet",
		  cost: 100,
		  title: "Dem. Claws",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyDemonClawed
		  }
		});

		public static const BEE: int = _partid++;
		EnumValue.add(Memories, BEE, "BEE", {
		  id: "Bee Lower Body",
			name: "Bee Legs",
		  cost: 100,
		  title: "Bee",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyBee
		  }
		});

		public static const CAT: int = _partid++;
		EnumValue.add(Memories, CAT, "CAT", {
		  id: "Cat Lower Body",
			name: "Cat Paws (Legs)",
		  cost: 100,
		  title: "Cat",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyCat(2)
		  }
		});

		public static const CAT_TAUR: int = _partid++;
		EnumValue.add(Memories, CAT_TAUR, "CAT_TAUR", {
		  id: "Cat Lower Body",
			name: "Cat Paws (Legs)",
		  cost: 200,
		  title: "Cat (4)",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyCat(4)
		  },
			taurVariant: true
		});

		public static const LIZARD: int = _partid++;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
		  id: "Lizard Lower Body",
			name: "Lizard Legs",
		  cost: 100,
		  title: "Lizard",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyLizard(2)
		  }
		});

		public static const LIZARD_TAUR: int = _partid++;
		EnumValue.add(Memories, LIZARD_TAUR, "LIZARD_TAUR", {
		  id: "Lizard Lower Body",
			name: "Lizard Legs",
		  cost: 200,
		  title: "Lizard (4)",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyLizard(4)
		  },
			taurVariant: true
		});

		public static const HARPY: int = _partid++;
		EnumValue.add(Memories, HARPY, "HARPY", {
		  id: "Harpy Lower Body",
			name: "Harpy Lower Body",
		  cost: 100,
		  title: "Harpy",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyHarpy
		  }
		});

		public static const CHITINOUS_SPIDER_LEGS: int = _partid++;
		EnumValue.add(Memories, CHITINOUS_SPIDER_LEGS, "CHITINOUS_SPIDER_LEGS", {
		  id: "Spider Lower Body",
			name: "Spider Lower Body",
		  cost: 100,
		  title: "Spider",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodySpider
		  }
		});

		public static const DRIDER: int = _partid++;
		EnumValue.add(Memories, DRIDER, "DRIDER", {
		  id: "Drider Lower Body",
			name: "Drider Lower Body",
		  cost: 300,
		  title: "Drider",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyDrider
		  },
			info: "Includes Spider tail and lower body parts."
		});

		public static const FOX: int = _partid++;
		EnumValue.add(Memories, FOX, "FOX", {
		  id: "Fox Lower Body",
			name: "Fox Paws (Legs)",
		  cost: 100,
		  title: "Fox",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyFox(2)
		  }
		});

		public static const FOX_TAUR: int = _partid++;
		EnumValue.add(Memories, FOX_TAUR, "FOX_TAUR", {
		  id: "Fox Lower Body",
			name: "Fox Paws (Legs)",
		  cost: 200,
		  title: "Fox (4)",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyFox(4)
		  },
			taurVariant: true
		});

		public static const DRAGON: int = _partid++;
		EnumValue.add(Memories, DRAGON, "DRAGON", {
		  id: "Draconic Lower Body",
			name: "Draconic Legs",
		  cost: 100,
		  title: "Dragon",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyDraconic(2)
		  }
		});

		public static const DRAGON_TAUR: int = _partid++;
		EnumValue.add(Memories, DRAGON_TAUR, "DRAGON_TAUR", {
		  id: "Draconic Lower Body",
			name: "Draconic Legs",
		  cost: 200,
		  title: "Dragon (4)",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyDraconic(4)
		  },
			taurVariant: true
		});

		public static const CLOVEN_HOOFED: int = _partid++;
		EnumValue.add(Memories, CLOVEN_HOOFED, "CLOVEN_HOOFED", {
		  id: "Cloven Hoofed Lower Body",
			name: "Cloven Hooves (Legs)",
		  cost: 100,
		  title: "Cl. Hoofed",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyClovenHoofed(2)
		  }
		});

		public static const CLOVEN_HOOFED_TAUR: int = _partid++;
		EnumValue.add(Memories, CLOVEN_HOOFED_TAUR, "CLOVEN_HOOFED_TAUR", {
		  id: "Cloven Hoofed Lower Body",
			name: "Cloven Hooves (Legs)",
		  cost: 200,
		  title: "Cl. Hoofed (4)",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyClovenHoofed(4)
		  },
			taurVariant: true
		});

		public static const SALAMANDER: int = _partid++;
		EnumValue.add(Memories, SALAMANDER, "SALAMANDER", {
		  id: "Salamander Lower Body",
			name: "Salamander Legs",
		  cost: 100,
		  title: "Salamander",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodySalamander(2)
		  }
		});

		public static const SALAMANDER_TAUR: int = _partid++;
		EnumValue.add(Memories, SALAMANDER_TAUR, "SALAMANDER_TAUR", {
		  id: "Salamander Lower Body",
			name: "Salamander Legs",
		  cost: 200,
		  title: "Salam. (4)",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodySalamander(4)
		  },
			taurVariant: true
		});

		public static const MANTIS: int = _partid++;
		EnumValue.add(Memories, MANTIS, "MANTIS", {
		  id: "Mantis Lower Body",
			name: "Mantis Lower Body",
		  cost: 100,
		  title: "Mantis",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyMantis(2)
		  }
		});

		public static const MANTIS_TAUR: int = _partid++;
		EnumValue.add(Memories, MANTIS_TAUR, "MANTIS_TAUR", {
		  id: "Mantis Lower Body",
			name: "Mantis Lower Body",
		  cost: 200,
		  title: "Mantis (4)",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyMantis(4)
		  },
			taurVariant: true
		});

		public static const SHARK: int = _partid++;
		EnumValue.add(Memories, SHARK, "SHARK", {
		  id: "Shark Lower Body",
			name: "Shark Legs",
		  cost: 100,
		  title: "Shark",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyShark(2)
		  }
		});

		public static const SHARK_TAUR: int = _partid++;
		EnumValue.add(Memories, SHARK_TAUR, "SHARK_TAUR", {
		  id: "Shark Lower Body",
			name: "Shark Legs",
		  cost: 200,
		  title: "Shark",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyShark(4)
		  },
			taurVariant: true
		});

		public static const LION: int = _partid++;
		EnumValue.add(Memories, LION, "LION", {
		  id: "Lion Lower Body",
			name: "Lion Paws (Legs)",
		  cost: 100,
		  title: "Lion",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyLion(2)
		  }
		});

		public static const LION_TAUR: int = _partid++;
		EnumValue.add(Memories, LION_TAUR, "LION_TAUR", {
		  id: "Lion Lower Body",
			name: "Lion Paws (Legs)",
		  cost: 200,
		  title: "Lion (4)",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyLion(4)
		  },
			taurVariant: true
		});

		public static const ORCA: int = _partid++;
		EnumValue.add(Memories, ORCA, "ORCA", {
		  id: "Orca Lower Body",
			name: "Orca Legs",
		  cost: 100,
		  title: "Orca",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyOrca(2)
		  }
		});

		public static const ORCA_TAUR: int = _partid++;
		EnumValue.add(Memories, ORCA_TAUR, "ORCA_TAUR", {
		  id: "Orca Lower Body",
			name: "Orca Legs",
		  cost: 200,
		  title: "Orca (4)",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyOrca(4)
		  },
			taurVariant: true
		});

		public static const ONI: int = _partid++;
		EnumValue.add(Memories, ONI, "ONI", {
		  id: "Oni Lower Body",
			name: "Oni Legs",
		  cost: 100,
		  title: "Oni",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyOni
		  }
		});

		public static const ELF: int = _partid++;
		EnumValue.add(Memories, ELF, "ELF", {
		  id: "Elf Lower Body",
			name: "Elf Legs",
		  cost: 100,
		  title: "Elf",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyElf
		  }
		});

		public static const RAIJU: int = _partid++;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
		  id: "Raiju Lower Body",
			name: "Raiju Paws (Legs)",
		  cost: 100,
		  title: "Raiju",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyRaiju(2)
		  }
		});

		public static const RAIJU_TAUR: int = _partid++;
		EnumValue.add(Memories, RAIJU_TAUR, "RAIJU_TAUR", {
		  id: "Raiju Lower Body",
			name: "Raiju Paws (Legs)",
		  cost: 200,
		  title: "Raiju (4)",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyRaiju(4)
		  },
			taurVariant: true
		});

		public static const RED_PANDA: int = _partid++;
		EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
		  id: "Red Panda Lower Body",
			name: "Red Panda Paws (Legs)",
		  cost: 100,
		  title: "Red Panda",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyRedPanda
		  }
		});

		public static const ORC: int = _partid++;
		EnumValue.add(Memories, ORC, "ORC", {
		  id: "Orc Lower Body",
			name: "Orc Legs",
		  cost: 100,
		  title: "Orc",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyOrc
		  }
		});

		public static const WOLF: int = _partid++;
		EnumValue.add(Memories, WOLF, "WOLF", {
		  id: "Wolf Lower Body",
			name: "Wolf Legs",
		  cost: 100,
		  title: "Wolf",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyWolf(2)
		  }
		});

		public static const WOLF_TAUR: int = _partid++;
		EnumValue.add(Memories, WOLF_TAUR, "WOLF_TAUR", {
		  id: "Wolf Lower Body",
			name: "Wolf Paws (Legs)",
		  cost: 200,
		  title: "Wolf (4)",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyWolf(4)
		  },
			taurVariant: true
		});

		public static const CAVE_WYRM: int = _partid++;
		EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
		  id: "Cave Wyrm Lower Body",
			name: "Cave Wyrm Legs",
		  cost: 100,
		  title: "Cave Wyrm",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyCaveWyrm
		  }
		});

		public static const MOUSE: int = _partid++;
		EnumValue.add(Memories, MOUSE, "MOUSE", {
		  id: "Mouse Lower Body",
			name: "Mouse Legs",
		  cost: 100,
		  title: "Mouse",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyMouse
		  }
		});

		public static const HINEZUMI: int = _partid++;
		EnumValue.add(Memories, HINEZUMI, "HINEZUMI", {
		  id: "Hinezumi Lower Body",
			name: "Hinezumi Legs",
		  cost: 100,
		  title: "Hinezumi",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyHinezumi
		  }
		});

		public static const GAZER: int = _partid++;
		EnumValue.add(Memories, GAZER, "GAZER", {
		  id: "Gazer Lower Body",
			name: "Gazer Legs",
		  cost: 100,
		  title: "Gazer",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyGazer
		  }
		});

		public static const FROSTWYRM: int = _partid++;
		EnumValue.add(Memories, FROSTWYRM, "FROSTWYRM", {
		  id: "Frost wyrm Lower Body",
			name: "Frost wyrm Lower Body",
		  cost: 100,
		  title: "Frost wyrm",
		  transformation: function(): Transformation {
		    return CoC.instance.transformations.LowerBodyFrostwyrm
		  }
		});

	  public static const YETI: int = _partid++;
	  EnumValue.add(Memories, YETI, "YETI", {
		  id: "Yeti Lower Body",
		  name: "Yeti Lower Body",
		  cost: 100,
		  title: "Yeti",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.LowerBodyYeti;
		  }
	  });

	  public static const SCYLLA: int = _partid++;
	  EnumValue.add(Memories, SCYLLA, "SCYLLA", {
		  id: "Scylla Lower Body",
		  name: "Scylla Tentacles",
		  cost: 200,
		  title: "Scylla",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.LowerBodyScylla
		  }
	  });

	  public static const KRAKEN: int = _partid++;
	  EnumValue.add(Memories, KRAKEN, "KRAKEN", {
		  id: "Kraken Lower Body",
		  name: "Kraken Tentacles",
		  cost: 300,
		  title: "Kraken",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.LowerBodyKraken
		  }
	  });

	  public static const HYDRA: int = _partid++;
	  EnumValue.add(Memories, HYDRA, "HYDRA", {
		  id: "Hydra Lower Body",
		  name: "Hydra Lower body",
		  cost: 200,
		  title: "Hydra",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.LowerBodyHydra
		  }
	  });

	  public static const GOO: int = _partid++;
	  EnumValue.add(Memories, GOO, "GOO", {
		  id: "Goo Lower Body",
		  name: "Goo Lower Body",
		  cost: 100,
		  title: "Goo",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.LowerBodyGoo
		  }
	  });
    
	  public static const ANT: int = _partid++;
	  EnumValue.add(Memories, ANT, "ANT", {
		  id: "Ant Lower Body",
		  name: "Ant Legs",
		  cost: 100,
		  title: "Ant",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.LowerBodyAnt
		  }
	  });
    
	  public static const ALRAUNE: int = _partid++;
	  EnumValue.add(Memories, ALRAUNE, "ALRAUNE", {
		  id: "Alraune Lower Body",
		  name: "Alraune Legs",
		  cost: 200,
		  title: "Alraune",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.LowerBodyPlantFlower
		  }
	  });
    
	  public static const RACCOON: int = _partid++;
	  EnumValue.add(Memories, RACCOON, "RACCOON", {
		  id: "Raccoon Lower Body",
		  name: "Raccoon Legs",
		  cost: 200,
		  title: "Raccoon",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.LowerBodyRaccoon
		  }
	  });

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
