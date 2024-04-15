package classes.GeneticMemories {
import classes.BaseContent;
import classes.StatusEffects;
import classes.BodyParts.*;
import classes.BodyParts.Arms;
import classes.internals.EnumValue;
import classes.Transformations.Transformation;
import classes.CoC;

	public class ArmsMem extends BaseContent {
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
	
		public static const HUMAN:int = _partid++;
		EnumValue.add(Memories, HUMAN, "HUMAN", {
			id: "Unlocked Metamorph",
			name: "Human Arms",
			cost: 500,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsHuman;
			}
		});

        public static const ANT:int = _partid++;
        EnumValue.add(Memories, ANT, "ANT", {
            id: "Ant Arms",
            name: "Ant Arms",
            cost: 100,
            title: "Ant",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsAnt;
            }
        });
        public static const AVIAN:int = _partid++;
        EnumValue.add(Memories, AVIAN, "AVIAN", {
            id: "Avian Arms",
            name: "Avian Arms",
            cost: 100,
            title: "Avian",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsAvian;
            }
        });

        public static const BAT:int = _partid++;
        EnumValue.add(Memories, BAT, "BAT", {
            id: "Bat Wing Arms",
            name: "Winged Bat Arms",
            cost: 100,
            title: "Bat",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsBatWing;
            }
        });

        public static const BEAR:int = _partid++;
        EnumValue.add(Memories, BEAR, "BEAR", {
            id: "Bear Arms",
            name: "Bear Arms",
            cost: 100,
            title: "Bear",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsBear;
            }
        });

		public static const BEE:int = _partid++;
        EnumValue.add(Memories, BEE, "BEE", {
            id: "Bee Arms",
            name: "Bee Arms",
            cost: 100,
            title: "Bee",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsBee;
            }
        });

        public static const BOAR:int = _partid++;
        EnumValue.add(Memories, BOAR, "BOAR", {
            id: "Boar Arms",
            name: "Boar Arms",
            cost: 100,
            title: "Boar",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsBoar;
            }
        });

        public static const CAT:int = _partid++;
        EnumValue.add(Memories, CAT, "CAT", {
            id: "Cat Arms",
            name: "Cat Paws (Arms)",
            cost: 100,
            title: "Cat",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsCat;
            }
        });

        public static const CAVE_WYRM:int = _partid++;
        EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
            id: "Cave Wyrm Arms",
            name: "Cave Wyrm Arms",
            cost: 100,
            title: "Cave Wyrm",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsCaveWyrm;
            }
        });

        public static const CENTIPEDE:int = _partid++;
        EnumValue.add(Memories, CENTIPEDE, "CENTIPEDE", {
            id: "Centipede Arms",
            name: "Centipede Arms",
            cost: 100,
            title: "Centipede",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsCentipede;
            }
        });

		public static const DEVIL:int = _partid++;
		EnumValue.add(Memories, DEVIL, "DEVIL", {
			id: "Devil Arms",
			name: "Devil Claws (Arms)",
			cost: 100,
			title: "Devil",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsDevil;
			}
		});

        public static const DISPLACER:int = _partid++;
        EnumValue.add(Memories, DISPLACER, "DISPLACER", {
            id: "Displacer Arms",
            name: "Displacer Four Arms",
            cost: 100,
            title: "Displacer",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsDisplacer;
            }
        });

        public static const DRACONIC:int = _partid++;
        EnumValue.add(Memories, DRACONIC, "DRACONIC", {
            id: "Draconic Arms",
            name: "Draconic Arms",
            cost: 100,
            title: "Draconic",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsDraconic;
            }
        });

        public static const FEY_DRACONIC:int = _partid++;
        EnumValue.add(Memories, FEY_DRACONIC, "FEY_DRACONIC", {
            id: "Fey Draconic Arms",
            name: "Fey Draconic Arms",
            cost: 100,
            title: "Fey Draconic",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsFeyDraconic;
            }
        });

        public static const ELF:int = _partid++;
        EnumValue.add(Memories, ELF, "ELF", {
            id: "Elf Arms",
            name: "Elf Arms",
            cost: 100,
            title: "Elf",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsElf;
            }
        });

        public static const FOX:int = _partid++;
        EnumValue.add(Memories, FOX, "FOX", {
            id: "Fox Arms",
            name: "Fox Paws (Arms)",
            cost: 100,
            title: "Fox",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsFox;
            }
        });

        public static const FROSTWYRM:int = _partid++;
        EnumValue.add(Memories, FROSTWYRM, "FROSTWYRM", {
            id: "Frostwyrm Arms",
            name: "Frostwyrm Arms",
            cost: 100,
            title: "Frostwyrm",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsFrostwyrm;
            }
        });

        public static const GAZER:int = _partid++;
        EnumValue.add(Memories, GAZER, "GAZER", {
            id: "Gazer Arms",
            name: "Gazer Arms",
            cost: 100,
            title: "Gazer",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsGazer;
            }
        });

        public static const GHOST:int = _partid++;
        EnumValue.add(Memories, GHOST, "GHOST", {
            id: "Ghost Arms",
            name: "Ghost Arms",
            cost: 100,
            title: "Ghost",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsGhost;
            }
        });

        public static const GOO:int = _partid++;
        EnumValue.add(Memories, GOO, "GOO", {
            id: "Goo Arms",
            name: "Goo Arms",
            cost: 100,
            title: "Goo",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsGoo;
            }
        });

        public static const GRYPHON:int = _partid++;
        EnumValue.add(Memories, GRYPHON, "GRYPHON", {
            id: "Gryphon Arms",
            name: "Gryphon Arms",
            cost: 100,
            title: "Gryphon",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsGryphon;
            }
        });

        public static const HARPY:int = _partid++;
        EnumValue.add(Memories, HARPY, "HARPY", {
            id: "Harpy Arms",
            name: "Harpy Arms",
            cost: 100,
            title: "Harpy",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsHarpy;
            }
        });

        public static const HINEZUMI:int = _partid++;
        EnumValue.add(Memories, HINEZUMI, "HINEZUMI", {
            id: "Hinezumi Arms",
            name: "Hinezumi Arms",
            cost: 100,
            title: "Hinezumi",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsHinezumi;
            }
        });

        public static const HYDRA:int = _partid++;
        EnumValue.add(Memories, HYDRA, "HYDRA", {
            id: "Hydra Arms",
            name: "Hydra Arms",
            cost: 100,
            title: "Hydra",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsHydra;
            }
        });

        public static const JABBERWOCKY:int = _partid++;
        EnumValue.add(Memories, JABBERWOCKY, "JABBERWOCKY", {
            id: "Jabberwocky Arms",
            name: "Jabberwocky Arms",
            cost: 100,
            title: "Jabberwocky",
            permReq: "Draconic Arms",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsJabberwocky;
            }
        });

        public static const KAMAITACHI:int = _partid++;
        EnumValue.add(Memories, KAMAITACHI, "KAMAITACHI", {
            id: "Kamaitachi Arms",
            name: "Kamaitachi Arms",
            cost: 200,
            title: "Kamaitachi",
            permReq: "Weasel Arms",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsKamaitachi;
            }
        });

        public static const KITSUNE:int = _partid++;
        EnumValue.add(Memories, KITSUNE, "KITSUNE", {
            id: "Kitsune Arms",
            name: "Kitsune Claws (Arms)",
            cost: 100,
            title: "Kitsune",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsKitsune;
            }
        });

        public static const KRAKEN:int = _partid++;
        EnumValue.add(Memories, KRAKEN, "KRAKEN", {
            id: "Kraken Arms",
            name: "Kraken Arms",
            cost: 200,
            title: "Kraken",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsKraken;
            }
        });

        public static const LION:int = _partid++;
        EnumValue.add(Memories, LION, "LION", {
            id: "Lion Arms",
            name: "Lion Paws (Arms)",
            cost: 100,
            title: "Lion",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsLion;
            }
        });

        public static const LIZARD:int = _partid++;
        EnumValue.add(Memories, LIZARD, "LIZARD", {
            id: "Lizard Arms",
            name: "Lizard Arms",
            cost: 100,
            title: "Lizard",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsLizard;
            }
        });

        public static const HOUND:int = _partid++;
        EnumValue.add(Memories, HOUND, "HOUND", {
            id: "Hound Arms",
            name: "Hound Arms",
            cost: 100,
            title: "Hound",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsHound;
            }
        });

        public static const JIANGSHI:int = _partid++;
        EnumValue.add(Memories, JIANGSHI, "JIANGSHI", {
            id: "Jiangshi Arms",
            name: "Jiangshi Arms",
            cost: 100,
            title: "Jiangshi",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsJiangshi;
            }
        });

        public static const MANTIS:int = _partid++;
        EnumValue.add(Memories, MANTIS, "MANTIS", {
            id: "Mantis Arms",
            name: "Mantis Arms",
            cost: 100,
            title: "Mantis",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsMantis;
            }
        });

        public static const MELKIE:int = _partid++;
        EnumValue.add(Memories, MELKIE, "MELKIE", {
            id: "Melkie Arms",
            name: "Melkie Arms",
            cost: 100,
            title: "Melkie",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsMelkie;
            }
        });

        public static const ONI:int = _partid++;
        EnumValue.add(Memories, ONI, "ONI", {
            id: "Oni Arms",
            name: "Oni Arms",
            cost: 100,
            title: "Oni",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsOni;
            }
        });

        public static const ORC:int = _partid++;
        EnumValue.add(Memories, ORC, "ORC", {
            id: "Orc Arms",
            name: "Orc Arms",
            cost: 100,
            title: "Orc",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsOrc;
            }
        });

        public static const ORCA:int = _partid++;
        EnumValue.add(Memories, ORCA, "ORCA", {
            id: "Orca Arms",
            name: "Orca Arms",
            cost: 100,
            title: "Orca",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsOrca;
            }
        });

        public static const PHOENIX:int = _partid++;
        EnumValue.add(Memories, PHOENIX, "PHOENIX", {
            id: "Phoenix Arms",
            name: "Phoenix Arms",
            cost: 100,
            title: "Phoenix",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsPhoenix;
            }
        });

        public static const PIG:int = _partid++;
        EnumValue.add(Memories, PIG, "PIG", {
            id: "Pig Arms",
            name: "Pig Arms",
            cost: 100,
            title: "Pig",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsPig;
            }
        });

        public static const PLANT:int = _partid++;
        EnumValue.add(Memories, PLANT, "PLANT", {
            id: "Plant Arms",
            name: "Plant Arms",
            cost: 100,
            title: "Plant",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsPlant;
            }
        });

        public static const PLANT_2:int = _partid++;
        EnumValue.add(Memories, PLANT_2, "PLANT_2", {
            id: "Plant Arms 2",
            name: "Plant Arms 2",
            cost: 100,
            title: "Plant 2",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsPlant2;
            }
        });

        public static const RACCOON:int = _partid++;
        EnumValue.add(Memories, RACCOON, "RACCOON", {
            id: "Raccoon Arms",
            name: "Raccoon Arms",
            cost: 100,
            title: "Raccoon",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsRaccoon;
            }
        });

        public static const RAIJU:int = _partid++;
        EnumValue.add(Memories, RAIJU, "RAIJU", {
            id: "Raiju Arms",
            name: "Raiju Claws (Arms)",
            cost: 100,
            title: "Raiju",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsRaiju;
            }
        });

        public static const RAIJU_PAWS:int = _partid++;
        EnumValue.add(Memories, RAIJU_PAWS, "RAIJU_PAWS", {
            id: "Raiju Paws Arms",
            name: "Raiju Paws (Arms)",
            cost: 100,
            title: "Raiju Paws",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsRaijuPaws;
            }
        });

        public static const RED_PANDA:int = _partid++;
        EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
            id: "Red Panda Arms",
            name: "Red Panda Paws (Arms)",
            cost: 100,
            title: "Red Panda",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsRedPanda;
            }
        });

        public static const SALAMANDER:int = _partid++;
        EnumValue.add(Memories, SALAMANDER, "SALAMANDER", {
            id: "Salamander Arms",
            name: "Salamander Arms",
            cost: 100,
            title: "Salamander",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsSalamander;
            }
        });

        public static const SATYR:int = _partid++;
        EnumValue.add(Memories, SATYR, "SATYR", {
            id: "Satyr Arms",
            name: "Satyr Arms",
            cost: 100,
            title: "Satyr",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsSatyr;
            }
        });

        public static const SEA_DRAGON:int = _partid++;
        EnumValue.add(Memories, SEA_DRAGON, "SEA_DRAGON", {
            id: "SeaDragon Arms",
            name: "SeaDragon Arms",
            cost: 100,
            title: "SeaDragon",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsSeaDragon;
            }
        });

        public static const SHARK:int = _partid++;
        EnumValue.add(Memories, SHARK, "SHARK", {
            id: "Shark Arms",
            name: "Shark Arms",
            cost: 100,
            title: "Shark",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsShark;
            }
        });

        public static const SPHINX:int = _partid++;
        EnumValue.add(Memories, SPHINX, "SPHINX", {
            id: "Sphinx Arms",
            name: "Sphinx Arms",
            cost: 100,
            title: "Sphinx",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsSphinx;
            }
        });

		public static const SPIDER:int = _partid++;
		EnumValue.add(Memories, SPIDER, "SPIDER", {
			id: "Spider Arms",
			name: "Spider Arms",
			cost: 100,
			title: "Spider",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsSpider;
			}
		});

        public static const SQUIRREL:int = _partid++;
        EnumValue.add(Memories, SQUIRREL, "SQUIRREL", {
            id: "Squirrel Arms",
            name: "Squirrel Arms",
            cost: 100,
            title: "Squirrel",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsSquirrel;
            }
        });

        public static const TINY:int = _partid++;
        EnumValue.add(Memories, TINY, "TINY", {
            id: "Tiny Arms",
            name: "Tiny Arms",
            cost: 100,
            title: "Tiny",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsTiny;
            }
        });

        public static const USHI_ONI:int = _partid++;
        EnumValue.add(Memories, USHI_ONI, "USHI_ONI", {
            id: "UshiOni Arms",
            name: "UshiOni Arms",
            cost: 100,
            title: "UshiOni",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsUshiOni;
            }
        });

        public static const WEASEL:int = _partid++;
        EnumValue.add(Memories, WEASEL, "WEASEL", {
            id: "Weasel Arms",
            name: "Weasel Arms",
            cost: 100,
            title: "Weasel",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsWeasel;
            }
        });

        public static const WENDIGO:int = _partid++;
        EnumValue.add(Memories, WENDIGO, "WENDIGO", {
            id: "Wendigo Arms",
            name: "Wendigo Arms",
            cost: 100,
            title: "Wendigo",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsWendigo;
            }
        });

        public static const WOLF:int = _partid++;
        EnumValue.add(Memories, WOLF, "WOLF", {
            id: "Wolf Arms",
            name: "Wolf Arms",
            cost: 100,
            title: "Wolf",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsWolf;
            }
        });

        public static const YETI:int = _partid++;
        EnumValue.add(Memories, YETI, "YETI", {
            id: "Yeti Arms",
            name: "Yeti Arms",
            cost: 100,
            title: "Yeti",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsYeti;
            }
        });

        public static const YUKI_ONNA:int = _partid++;
        EnumValue.add(Memories, YUKI_ONNA, "YUKI_ONNA", {
            id: "Yuki Onna Arms",
            name: "Yuki Onna Arms",
            cost: 100,
            title: "Yuki Onna",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsYukiOnna;
            }
        });

        public static const CANINE:int = _partid++;
        EnumValue.add(Memories, CANINE, "CANINE", {
            id: "Canine Arms",
            name: "Canine Arms",
            cost: 100,
            title: "Canine",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsCanine;
            }
        });

        public static const ABYSSAL_SHARK:int = _partid++;
        EnumValue.add(Memories, ABYSSAL_SHARK, "ABYSSAL_SHARK", {
            id: "Abyssal Shark Arms",
            name: "Abyssal Shark Arms",
            cost: 100,
            title: "A.Shark",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsAbyssalShark;
            }
        });

        public static const ARIGEAN:int = _partid++;
        EnumValue.add(Memories, ARIGEAN, "ARIGEAN", {
            id: "Arigean Arms",
            name: "Arigean Arms",
            cost: 100,
            title: "Arigean",
            transformation: function(): Transformation {
                return CoC.instance.transformations.ArmsArigean;
            }
        });

		public static const DEMON:int = _partid++;
		EnumValue.add(Memories, DEMON, "DEMON", {
			id: "Demon Arms",
			name: "Demon Claws (Arms)",
			cost: 100,
			title: "Demon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsDemon;
			}
		});

		public static const DEER:int = _partid++;
		EnumValue.add(Memories, DEER, "DEER", {
			id: "Deer Arms",
			name: "Deer Arms",
			cost: 100,
			title: "Deer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsDeer;
			}
		});

		public static const REINDEER:int = _partid++;
		EnumValue.add(Memories, REINDEER, "REINDEER", {
			id: "Reindeer Arms",
			name: "Reindeer Arms",
			cost: 200,
			title: "Reindeer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsReindeer;
			}
		});

		public static const MOTH:int = _partid++;
		EnumValue.add(Memories, MOTH, "MOTH", {
			id: "Moth Arms",
			name: "Moth Arms",
			cost: 100,
			title: "Moth",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsMoth;
			}
		});

		public static const TROLL:int = _partid++;
		EnumValue.add(Memories, TROLL, "TROLL", {
			id: "Troll Arms",
			name: "Troll Arms",
			cost: 100,
			title: "Troll",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsTroll;
			}
		});

		public static const GLACIAL_TROLL:int = _partid++;
		EnumValue.add(Memories, GLACIAL_TROLL, "GLACIAL_TROLL", {
			id: "G.Troll Arms",
			name: "G.Troll Arms",
			cost: 100,
			title: "G.Troll",
			transformation: function(): Transformation {
				return CoC.instance.transformations.ArmsGlacialTroll;
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
	}
}
