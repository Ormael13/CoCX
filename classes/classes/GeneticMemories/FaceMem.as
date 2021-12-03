package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Face;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class FaceMem extends BaseContent {
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
			name: "Human Face",
			cost: 500,
			title: "Human",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceHuman;
			}
		});

		public static const HORSE:int = 1;
		EnumValue.add(Memories, HORSE, "HORSE", {
			id: "Horse Face",
			name: "Horse Face",
			cost: 100,
			title: "Horse",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceHorse;
			}
		});

		public static const COW_MINOTAUR:int = 2;
		EnumValue.add(Memories, COW_MINOTAUR, "COW_MINOTAUR", {
			id: "Cow/Minotaur Face",
			name: "Bovine Face",
			cost: 100,
			title: "Bovine",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceCowMinotaur;
			}
		});

		public static const SHARK_TEETH:int = 3;
		EnumValue.add(Memories, SHARK_TEETH, "SHARK_TEETH", {
			id: "Shark Teeth Face",
			name: "Shark Teeth",
			cost: 100,
			title: "Shark",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceSharkTeeth;
			}
		});

		public static const SNAKE_FANGS:int = 4;
		EnumValue.add(Memories, SNAKE_FANGS, "SNAKE_FANGS", {
			id: "Snake Fangs Face",
			name: "Snake Fangs",
			cost: 100,
			title: "Snake",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceSnakeFangs;
			}
		});

		public static const CAT:int = 5;
		EnumValue.add(Memories, CAT, "CAT", {
			id: "Cat Face",
			name: "Cat Face",
			cost: 100,
			title: "Cat",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceCat;
			}
		});

		public static const CAT_CANINES:int = 6;
		EnumValue.add(Memories, CAT_CANINES, "CAT_CANINES", {
			id: "Cat Canines Face",
			name: "Cat Canines",
			cost: 100,
			title: "Cat Canines",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceCatCanines;
			}
		});

		public static const LIZARD:int = 7;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			id: "Lizard Face",
			name: "Lizard Face",
			cost: 100,
			title: "Lizard",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceLizard;
			}
		});

		public static const SPIDER:int = 8;
		EnumValue.add(Memories, SPIDER, "SPIDER", {
			id: "Spider Fangs Face",
			name: "Spider Fangs",
			cost: 100,
			title: "Spider Fangs",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceSpiderFangs;
			}
		});

		public static const FOX:int = 9;
		EnumValue.add(Memories, FOX, "FOX", {
			id: "Fox Face",
			name: "Fox Face",
			cost: 100,
			title: "Fox",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceFox;
			}
		});

		public static const PIG:int = 10;
		EnumValue.add(Memories, PIG, "PIG", {
			id: "Pig Face",
			name: "Pig Face",
			cost: 100,
			title: "Pig",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FacePig;
			}
		});

		public static const BOAR:int = 11;
		EnumValue.add(Memories, BOAR, "BOAR", {
			id: "Boar Face",
			name: "Boar Face",
			cost: 100,
			title: "Boar",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceBoar;
			}
		});

		public static const MANTICORE:int = 12;
		EnumValue.add(Memories, MANTICORE, "MANTICORE", {
			id: "Manticore Face",
			name: "Manticore Fangs",
			cost: 100,
			title: "Manticore",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceManticore;
			}
		});

		public static const SALAMANDER_FANGS:int = 13;
		EnumValue.add(Memories, SALAMANDER_FANGS, "SALAMANDER_FANGS", {
			id: "Salamander Fangs Face",
			name: "Salamander Fangs",
			cost: 100,
			title: "Salamander F.",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceSalamanderFangs;
			}
		});

		public static const ORCA:int = 14;
		EnumValue.add(Memories, ORCA, "ORCA", {
			id: "Orca Face",
			name: "Orca Face",
			cost: 100,
			title: "Orca",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceOrca;
			}
		});

		public static const DRAGON:int = 15;
		EnumValue.add(Memories, DRAGON, "DRAGON", {
			id: "Draconic Face",
			name: "Draconic Face",
			cost: 100,
			title: "Dragon",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceDragon;
			}
		});

		public static const DRAGON_FANGS:int = 16;
		EnumValue.add(Memories, DRAGON_FANGS, "DRAGON_FANGS", {
			id: "Draconic Fangs Face",
			name: "Draconic Fangs",
			cost: 100,
			title: "Dragon Fangs",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceDragonFangs;
			}
		});

		public static const ONI_TEETH:int = 17;
		EnumValue.add(Memories, ONI_TEETH, "ONI_TEETH", {
			id: "Oni Teeth Face",
			name: "Oni Teeth",
			cost: 100,
			title: "Oni Teeh",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceOniTeeth;
			}
		});

		public static const WEASEL:int = 18;
		EnumValue.add(Memories, WEASEL, "WEASEL", {
			id: "Weasel Face",
			name: "Weasel Face",
			cost: 100,
			title: "Weasel",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceWeasel;
			}
		});

		public static const VAMPIRE:int = 19;
		EnumValue.add(Memories, VAMPIRE, "VAMPIRE", {
			id: "Vampire Face",
			name: "Vampire Fangs",
			cost: 100,
			title: "Vampire",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceVampire;
			}
		});

		public static const RED_PANDA:int = 20;
		EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
			id: "Red Panda Face",
			name: "Red Panda Face",
			cost: 100,
			title: "Red Panda",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceRedPanda;
			}
		});

		public static const CHESHIRE:int = 21;
		EnumValue.add(Memories, CHESHIRE, "CHESHIRE", {
			id: "Cheshire Face",
			name: "Cheshire Face",
			cost: 200,
			title: "Cheshire",
			permReq: "Cat Face",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceCheshire;
			}
		});

		public static const CHESHIRE_SMILE:int = 22;
		EnumValue.add(Memories, CHESHIRE_SMILE, "CHESHIRE_SMILE", {
			id: "Cheshire Smile Face",
			name: "Cheshire Smile",
			cost: 200,
			title: "Cheshire Smile",
			permReq: "Cat Canines Face",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceCheshireSmile;
			}
		});

		public static const ORC_FANGS:int = 23;
		EnumValue.add(Memories, ORC_FANGS, "ORC_FANGS", {
			id: "Orc Fangs Face",
			name: "Orc Fangs",
			cost: 200,
			title: "Orc Fangs",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceOrcFangs;
			}
		});

		public static const DEVIL_FANGS:int = 24;
		EnumValue.add(Memories, DEVIL_FANGS, "DEVIL_FANGS", {
			id: "Devil Fangs Face",
			name: "Demonic Fangs",
			cost: 200,
			title: "Dem. Fangs",
			transformation: function(): Transformation {
				return CoC.instance.transformations.FaceDevilFangs;
			}
		});
	  	public static const ELF_FACE:int = 25;
	  	EnumValue.add(Memories, ELF_FACE, "ELF_FACE", {
		  	id: "Elf Face",
		  	name: "Elf Face",
		  	cost: 100,
		 	title: "Elf Face",
		  	transformation: function(): Transformation {
			  	return CoC.instance.transformations.FaceElf;
		  	}
	  	});
	  	public static const WOLF_FACE:int = 26;
	  	EnumValue.add(Memories, WOLF_FACE, "WOLF_FACE", {
		  	id: "Wolf Face",
		  	name: "Wolf Face",
		  	cost: 100,
		 	title: "Wolf Face",
		  	transformation: function(): Transformation {
			  	return CoC.instance.transformations.FaceWolf;
		  	}
	  	});
	  	public static const ANIMAL_TOOTHS:int = 27;
	  	EnumValue.add(Memories, ANIMAL_TOOTHS, "ANIMAL_TOOTHS", {
		  	id: "Animal Teeth",
		  	name: "Animal Teeth",
		  	cost: 100,
		 	title: "Animal Teeth",
		  	transformation: function(): Transformation {
			  	return CoC.instance.transformations.FaceAnimalTeeth;
		  	}
	  	});
	  	public static const BUCKTEETH:int = 28;
	  	EnumValue.add(Memories, BUCKTEETH, "BUCKTEETH", {
		  	id: "Buck Teeth",
		  	name: "Buck Teeth",
		  	cost: 100,
		 	title: "Buck Teeth",
		  	transformation: function(): Transformation {
			  	return CoC.instance.transformations.FaceBuckteeth;
		  	}
	  	});
	  	public static const MOUSE:int = 29;
	  	EnumValue.add(Memories, MOUSE, "MOUSE", {
		  	id: "Mouse Teeth",
		  	name: "Mouse Teeth",
		  	cost: 100,
		 	title: "Mouse Teeth",
		  	transformation: function(): Transformation {
			  	return CoC.instance.transformations.FaceMouse;
		  	}
	  	});
		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
