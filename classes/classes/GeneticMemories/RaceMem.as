package classes.GeneticMemories {
	import classes.BaseContent;
	import classes.StatusEffects;
	import classes.BodyParts.*;
	import classes.BodyParts.Horns;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;
	import classes.Races.*;
	import classes.GeneticMemories.*;

  public class RaceMem extends BaseContent {
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
	//TODO: Khovel - This lets them show up in the Metamorph Menu
    public static var Memories:/*EnumValue*/ Array = [];
	  private static var _partid:int = 0;
	  private static var metamorphCost:int = 5000;
	  private static var permMetaCost:int = 50;



		public static const HUMAN:int = _partid++;
		EnumValue.add(Memories, HUMAN, "HUMAN", {
			id: "Unlocked Metamorph",
			name: "Human",
			cost: 10000,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullHuman;
			}
		});

		public static const ALICORN:int = _partid++;
		EnumValue.add(Memories, ALICORN, "ALICORN", {
			id: "Alicorn Complete",
			name: "Alicorn",
			cost: metamorphCost,
			title: "Alicorn",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullAlicorn;
			}
		});

        public static const ALRAUNE:int = _partid++;
        EnumValue.add(Memories, ALRAUNE, "ALRAUNE", {
            id: "Alraune Complete",
            name: "Alraune",
            cost: metamorphCost,
            title: "Alraune",
            permCost:permMetaCost,
            transformation: function(): Transformation {
                return CoC.instance.transformations.FullAlraune;
            }
        });

        public static const ANT:int = _partid++;
        EnumValue.add(Memories, ANT, "ANT", {
            id: "Ant Complete",
            name: "Ant",
            cost: metamorphCost,
            title: "Ant",
            permCost:permMetaCost,
            transformation: function(): Transformation {
                return CoC.instance.transformations.FullAnt;
            }
        });

		public static const ATLACHNACHA:int = _partid++;
	  	EnumValue.add(Memories, ATLACHNACHA, "ATLACHNACHA", {
			  id: "AtlachNacha Complete",
			  name: "AtlachNacha",
			  cost: metamorphCost,
			  title: "AtlachNacha",
            permCost:permMetaCost,
			  transformation: function(): Transformation {
				  return CoC.instance.transformations.FullAtlahNacha;
			  }
		  });

        public static const COUATL:int = _partid++;
        EnumValue.add(Memories, COUATL, "COUATL", {
            id: "Couatl Complete",
            name: "Couatl",
            cost: metamorphCost,
            title: "Couatl",
            permCost:permMetaCost,
            transformation: function(): Transformation {
                return CoC.instance.transformations.FullCouatl;
            }
        });

        public static const DRAGON:int = _partid++;
        EnumValue.add(Memories, DRAGON, "DRAGON", {
            id: "Dragon Complete",
            name: "Dragon",
            cost: metamorphCost,
            title: "Dragon",
            permCost:permMetaCost,
            transformation: function(): Transformation {
                return CoC.instance.transformations.FullDragon;
            }
        });

		public static const EASTERBUNNY:int = _partid++;
		EnumValue.add(Memories, EASTERBUNNY, "EASTERBUNNY", {
            id: "EasterBunny Complete",
            name: "EasterBunny",
            cost: metamorphCost,
            title: "EasterBunny",
            permCost:permMetaCost,
            transformation: function ():Transformation {
                return CoC.instance.transformations.FullEasterBunny;
            }
        });

		public static const ELF:int = _partid++;
		EnumValue.add(Memories, ELF, "ELF", {
            id: "Elf Complete",
            name: "Elf",
            cost: metamorphCost,
            title: "Elf",
            permCost:permMetaCost,
            transformation: function ():Transformation {
                return CoC.instance.transformations.FullElf;
            }
        });

		public static const FAIRY:int = _partid++;
		EnumValue.add(Memories, FAIRY, "FAIRY", {
            id: "Fairy Complete",
            name: "Fairy",
            cost: metamorphCost,
            title: "Fairy",
            permCost:permMetaCost,
            transformation: function ():Transformation {
                return CoC.instance.transformations.FullFairy;
            }
        });

        public static const GOBLIN:int = _partid++;
        EnumValue.add(Memories, GOBLIN, "GOBLIN", {
            id: "Goblin Complete",
            name: "Goblin",
            cost: metamorphCost,
            title: "Goblin",
            permCost:permMetaCost,
            transformation: function(): Transformation {
                return CoC.instance.transformations.FullGoblin;
            }
        });

        public static const GORGON:int = _partid++;
        EnumValue.add(Memories, GORGON, "GORGON", {
            id: "Gorgon Complete",
            name: "Gorgon",
            cost: metamorphCost,
            title: "Gorgon",
            permCost:permMetaCost,
            transformation: function(): Transformation {
                return CoC.instance.transformations.FullGorgon;
            }
        });

		public static const HYDRA:int = _partid++;
		EnumValue.add(Memories, HYDRA, "HYDRA", {
			id: "Hydra Complete",
			name: "Hydra",
			cost: metamorphCost,
			title: "Hydra",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullHydra;
			}
		});

		public static const JIANGSHI:int = _partid++;
		EnumValue.add(Memories, JIANGSHI, "JIANGSHI", {
			id: "Jiangshi Complete",
			name: "Jiangshi",
			cost: metamorphCost,
			title: "Jiangshi",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullJiangshi;
			}
		});

		public static const KITSUNE:int = _partid++;
		EnumValue.add(Memories, KITSUNE, "KITSUNE", {
		  id: "Kitsune Complete",
		  name: "Kitsune",
		  cost: metamorphCost,
		  title: "Kitsune",
            permCost:permMetaCost,
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.FullKitsune;
		  }
		});

		public static const KITSHOO:int = _partid++;
		EnumValue.add(Memories, KITSHOO, "KITSHOO", {
		  id: "Kitshoo Complete",
		  name: "Kitshoo",
		  cost: metamorphCost,
		  title: "Kitshoo",
            permCost:permMetaCost,
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.FullKitshoo;
		  }
		});

		public static const NAGA:int = _partid++;
		EnumValue.add(Memories, NAGA, "NAGA", {
			id: "Naga Complete",
			name: "Naga",
			cost: metamorphCost,
			title: "Naga",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullNaga;
			}
		});

		public static const PHOENIX:int = _partid++;
		EnumValue.add(Memories, PHOENIX, "PHOENIX", {
			id: "Phoenix Complete",
			name: "Phoenix",
			cost: metamorphCost,
			title: "Phoenix",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullPhoenix;
			}
		});

		public static const POLTERGEIST:int = _partid++;
		EnumValue.add(Memories, POLTERGEIST, "POLTERGEIST", {
			id: "Poltergeist Complete",
			name: "Poltergeist",
			cost: metamorphCost,
			title: "Poltergeist",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullPoltergeist;
			}
		});

		public static const RACCOON:int = _partid++;
		EnumValue.add(Memories, RACCOON, "RACCOON", {
			id: "Raccoon Complete",
			name: "Raccoon",
			cost: metamorphCost,
			title: "Raccoon",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullRaccoon;
			}
		});

		public static const RAIJU:int = _partid++;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			id: "Raiju Complete",
			name: "Raiju",
			cost: metamorphCost,
			title: "Raiju",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullRaiju;
			}
		});

		public static const SCYLLA:int = _partid++;
		EnumValue.add(Memories, SCYLLA, "SCYLLA", {
			id: "Scylla Complete",
			name: "Scylla",
			cost: metamorphCost,
			title: "Scylla",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullScylla;
			}
		});

		public static const SHARK:int = _partid++;
		EnumValue.add(Memories, SHARK, "SHARK", {
			id: "Shark Complete",
			name: "Shark",
			cost: metamorphCost,
			title: "Shark",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullShark;
			}
		});

		public static const VOUIVRE:int = _partid++;
		EnumValue.add(Memories, VOUIVRE, "VOUIVRE", {
			id: "Vouivre Complete",
			name: "Vouivre",
			cost: metamorphCost,
			title: "Vouivre",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullVouivre;
			}
		});

		public static const WEREWOLF:int = _partid++;
		EnumValue.add(Memories, WEREWOLF, "WEREWOLF", {
			id: "Werewolf Complete",
			name: "Werewolf",
			cost: metamorphCost,
			title: "Werewolf",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullWerewolf;
			}
		});

		public static const WOLF:int = _partid++;
		EnumValue.add(Memories, WOLF, "WOLF", {
			id: "Wolf Complete",
			name: "Wolf",
			cost: metamorphCost,
			title: "Wolf",
            permCost:permMetaCost,
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullWolf;
			}
		});



		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
