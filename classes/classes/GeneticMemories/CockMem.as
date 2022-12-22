package classes.GeneticMemories {
	import classes.BaseContent;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

	public class CockMem extends BaseContent {
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
			name: "No Cock",
			cost: 500,
			title: "None",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockNone(cockIndex);
			}
		});

		public static const KNOT:int = _partid++;
		EnumValue.add(Memories, KNOT, "KNOT", {
			id: "Unlocked Metamorph",
			name: "Increase Knot",
			cost: 200,
			title: "Knot",
			hint: "You need a dog-like dick",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.GrowKnot(cockIndex, 3);
			}
		});

		public static const HUMAN:int = _partid++;
		EnumValue.add(Memories, HUMAN, "HUMAN", {
			id: "Unlocked Metamorph",
			name: "Human cock",
			cost: 200,
			title: "Human",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockHuman(cockIndex);
			}
		});

		public static const HORSE:int = _partid++;
		EnumValue.add(Memories, HORSE, "HORSE", {
			id: "Horse cock",
			name: "Horse cock",
			cost: 200,
			title: "Horse",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockHorse(cockIndex);
			}
		});

		public static const DOG:int = _partid++;
		EnumValue.add(Memories, DOG, "DOG", {
			id: "Dog cock",
			name: "Dog cock",
			cost: 200,
			title: "Dog",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockDog(cockIndex);
			}
		});

		public static const DEMON:int = _partid++;
		EnumValue.add(Memories, DEMON, "DEMON", {
			id: "Demon cock",
			name: "Demon cock",
			cost: 200,
			title: "Demon",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockDemon(cockIndex);
			}
		});

		public static const TENTACLE:int = _partid++;
		EnumValue.add(Memories, TENTACLE, "TENTACLE", {
			id: "Tentacle cock",
			name: "Tentacle cock",
			cost: 200,
			title: "Tentacle",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockTentacle(cockIndex);
			}
		});

		public static const SCYLLATENTACLE:int = _partid++;
		EnumValue.add(Memories, SCYLLATENTACLE, "SCYLLATENTACLE", {
			id: "Scylla tentacle cock",
			name: "Scylla tentacle cock",
			cost: 200,
			title: "Scylla",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockScylla(cockIndex);
			}
		});

		public static const CAT:int = _partid++;
		EnumValue.add(Memories, CAT, "CAT", {
			id: "Cat cock",
			name: "Cat cock",
			cost: 200,
			title: "Cat",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockCat(cockIndex);
			}
		});

		public static const CANCER:int = _partid++;
		EnumValue.add(Memories, CANCER, "CANCER", {
			id: "Cancer cock",
			name: "Cancer cock",
			cost: 200,
			title: "Cancer",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockCancer(cockIndex);
			}
		});

		public static const LIZARD:int = _partid++;
		EnumValue.add(Memories, LIZARD, "LIZARD", {
			id: "Lizard cock",
			name: "Lizard cock",
			cost: 200,
			title: "Lizard",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockLizard(cockIndex);
			}
		});

		public static const CAVE_WYRM:int = _partid++;
		EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
			id: "Cave Wyrm cock",
			name: "Cave Wyrm cock",
			cost: 200,
			title: "Cave Wyrm",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockCaveWyrm(cockIndex);
			}
		});

		public static const ANEMONE:int = _partid++;
		EnumValue.add(Memories, ANEMONE, "ANEMONE", {
			id: "Anemone cock",
			name: "Anemone cock",
			cost: 200,
			title: "Anemone",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockAnemone(cockIndex);
			}
		});

		public static const KANGAROO:int = _partid++;
		EnumValue.add(Memories, KANGAROO, "KANGAROO", {
			id: "Kangaroo cock",
			name: "Kangaroo cock",
			cost: 200,
			title: "Kangaroo",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockKangaroo(cockIndex);
			}
		});

		public static const DRAGON:int = _partid++;
		EnumValue.add(Memories, DRAGON, "DRAGON", {
			id: "Dragon cock",
			name: "Dragon cock",
			cost: 200,
			title: "Dragon",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockDragon(cockIndex);
			}
		});

		public static const DISPLACER:int = _partid++;
		EnumValue.add(Memories, DISPLACER, "DISPLACER", {
			id: "Displacer cock",
			name: "Displacer cock",
			cost: 200,
			title: "Displacer",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockDisplacer(cockIndex);
			}
		});

		public static const FOX:int = _partid++;
		EnumValue.add(Memories, FOX, "FOX", {
			id: "Fox cock",
			name: "Fox cock",
			cost: 200,
			title: "Fox",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockFox(cockIndex);
			}
		});

		public static const BEE:int = _partid++;
		EnumValue.add(Memories, BEE, "BEE", {
			id: "Bee cock",
			name: "Bee cock",
			cost: 200,
			title: "Bee",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockBee(cockIndex);
			}
		});

		public static const PIG:int = _partid++;
		EnumValue.add(Memories, PIG, "PIG", {
			id: "Pig cock",
			name: "Pig cock",
			cost: 200,
			title: "Pig",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockPig(cockIndex);
			}
		});

		public static const AVIAN:int = _partid++;
		EnumValue.add(Memories, AVIAN, "AVIAN", {
			id: "Avian cock",
			name: "Avian cock",
			cost: 200,
			title: "Avian",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockAvian(cockIndex);
			}
		});

		public static const RHINO:int = _partid++;
		EnumValue.add(Memories, RHINO, "RHINO", {
			id: "Rhino cock",
			name: "Rhino cock",
			cost: 200,
			title: "Rhino",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockRhino(cockIndex);
			}
		});

		public static const ECHIDNA:int = _partid++;
		EnumValue.add(Memories, ECHIDNA, "ECHIDNA", {
			id: "Echidna cock",
			name: "Echidna cock",
			cost: 200,
			title: "Echidna",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockEchidna(cockIndex);
			}
		});

		public static const WOLF:int = _partid++;
		EnumValue.add(Memories, WOLF, "WOLF", {
			id: "Wolf cock",
			name: "Wolf cock",
			cost: 200,
			title: "Wolf",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockWolf(cockIndex);
			}
		});

		public static const STAMEN:int = _partid++;
		EnumValue.add(Memories, STAMEN, "STAMEN", {
			id: "Stamen cock",
			name: "Stamen cock",
			cost: 200,
			title: "Stamen",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockStamen(cockIndex);
			}
		});

		public static const RED_PANDA:int = _partid++;
		EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
			id: "Red Panda cock",
			name: "Red Panda cock",
			cost: 200,
			title: "Red Panda",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockRedPanda(cockIndex);
			}
		});

		public static const GRYPHON:int = _partid++;
		EnumValue.add(Memories, GRYPHON, "GRYPHON", {
			id: "Gryphon cock",
			name: "Gryphon cock",
			cost: 200,
			title: "Gryphon",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockGryphon(cockIndex);
			}
		});

		public static const OOMUKADE:int = _partid++;
		EnumValue.add(Memories, OOMUKADE, "OOMUKADE", {
			id: "Ookamude cock",
			name: "Ookamude cock",
			cost: 200,
			title: "Centipede",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockCentipede(cockIndex);
			}
		});

		public static const RAIJU:int = _partid++;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			id: "Raiju cock",
			name: "Raiju cock",
			cost: 200,
			title: "Raiju",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockRaiju(cockIndex);
			}
		});

		public static const USHI_ONI:int = _partid++;
		EnumValue.add(Memories, USHI_ONI, "USHI_ONI", {
			id: "Ushi Oni cock",
			name: "Ushi Oni cock",
			cost: 200,
			title: "Ushi Oni",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockUshiOni(cockIndex);
			}
		});

		public static const INSECT:int = _partid++;
		EnumValue.add(Memories, INSECT, "INSECT", {
			id: "Insect cock",
			name: "Insect cock",
			cost: 500,
			title: "Insect",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockInsect(cockIndex);
			}
		});

		public static const KIRIN:int = _partid++;
		EnumValue.add(Memories, KIRIN, "KIRIN", {
			id: "Kirin cock",
			name: "Kirin cock",
			cost: 200,
			title: "Kirin",
			transformation: function(cockIndex:int): Transformation {
				return CoC.instance.transformations.CockKirin(cockIndex);
			}
		});


		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
	}
}
