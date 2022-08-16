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


		public static const HUMAN:int = _partid++;
		EnumValue.add(Memories, HUMAN, "HUMAN", {
			id: "Unlocked Metamorph",
			name: "Human",
			cost: 2000,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullHuman;
			}
		});
		public static const ALICORN:int = _partid++;
		EnumValue.add(Memories, ALICORN, "ALICORN", {
			id: "Alicorn Complete",
			name: "Alicorn",
			cost: 2000,
			title: "Alicorn",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullAlicorn;
			}
		});
      /*
        public static const ALRAUNE:int = _partid++;
        EnumValue.add(Memories, ALRAUNE, "ALRAUNE", {
            id: "Alraune Complete",
            name: "Alraune",
            cost: 2000,
            title: "Alraune",
            transformation: function(): Transformation {
                return CoC.instance.transformations.FullAlraune;
            }
        });
        public static const ANT:int = _partid++;
        EnumValue.add(Memories, ANT, "ANT", {
            id: "Ant Complete",
            name: "Ant",
            cost: 2000,
            title: "Ant",
            transformation: function(): Transformation {
                return CoC.instance.transformations.FullAnt;
            }
        });
        public static const COUATL:int = _partid++;
        EnumValue.add(Memories, COUATL, "COUATL", {
            id: "Couatl Complete",
            name: "Couatl",
            cost: 2000,
            title: "Couatl",
            transformation: function(): Transformation {
                return CoC.instance.transformations.FullCouatl;
            }
        });
        public static const GORGON:int = _partid++;
        EnumValue.add(Memories, GORGON, "GORGON", {
            id: "Gorgon Complete",
            name: "Gorgon",
            cost: 2000,
            title: "Gorgon",
            transformation: function(): Transformation {
                return CoC.instance.transformations.FullGorgon;
            }
        });
*/
		public static const ELF:int = _partid++;
		EnumValue.add(Memories, ELF, "ELF", {
            id: "Elf Complete",
            name: "Elf",
            cost: 2000,
            title: "Elf",
            transformation: function ():Transformation {
                return CoC.instance.transformations.FullElf;
            }
        });
		public static const JIANGSHI:int = _partid++;
		EnumValue.add(Memories, JIANGSHI, "JIANGSHI", {
			id: "Jiangshi Complete",
			name: "Jiangshi",
			cost: 2000,
			title: "Jiangshi",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullJiangshi;
			}
		});
		public static const KITSUNE:int = _partid++;
		EnumValue.add(Memories, KITSUNE, "KITSUNE", {
		  id: "Kitsune Complete",
		  name: "Kitsune",
		  cost: 2000,
		  title: "Kitsune",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.FullKitsune;
		  }
		});
/*
		public static const NAGA:int = _partid++;
		EnumValue.add(Memories, NAGA, "NAGA", {
			id: "Naga Complete",
			name: "Naga",
			cost: 2000,
			title: "Naga",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullNaga;
			}
		});

		public static const RACCOON:int = _partid++;
		EnumValue.add(Memories, RACCOON, "RACCOON", {
			id: "Raccoon Complete",
			name: "Raccoon",
			cost: 2000,
			title: "Raccoon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullRaccoon;
			}
		});

		public static const RAIJU:int = _partid++;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			id: "Raiju Complete",
			name: "Raiju",
			cost: 2000,
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullRaiju;
			}
		});

		public static const VOUIVRE:int = _partid++;
		EnumValue.add(Memories, VOUIVRE, "VOUIVRE", {
			id: "Vouivre Complete",
			name: "Vouivre",
			cost: 2000,
			title: "Vouivre",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullVouivre;
			}
		});

		public static const HYDRA:int = _partid++;
		EnumValue.add(Memories, HYDRA, "HYDRA", {
			id: "Hydra Complete",
			name: "Hydra",
			cost: 2000,
			title: "Hydra",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FullHydra;
			}
		});
*/


		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
