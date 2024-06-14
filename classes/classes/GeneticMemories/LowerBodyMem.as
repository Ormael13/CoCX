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
// TODO: Khovel - Taur Toggle button - Remember Taur setting in Metamorph only

    public static var Memories:/*EnumValue*/ Array = [];
	  private static var _partid:int = 0;

      public static const HUMAN: int = _partid++;
      EnumValue.add(Memories, HUMAN, "HUMAN", {
          id: "Unlocked Metamorph",name: "Human Legs",
          cost: 500,
          title: "Human",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyHuman}});

      public static const TAUR: int = _partid++;
      EnumValue.add(Memories, TAUR, "TAUR", {
          id: "Taur Lower Body",name: "Taur Lower Body",
          cost: 100,
          title: "Taur",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyTaur()}});

      public static const ALRAUNE: int = _partid++;
      EnumValue.add(Memories, ALRAUNE, "ALRAUNE", {
          id: "Alraune Lower Body",name: "Alraune Legs",
          cost: 200,
          title: "Alraune",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyPlantFlower}});

      public static const ANT: int = _partid++;
      EnumValue.add(Memories, ANT, "ANT", {
          id: "Ant Lower Body",name: "Ant Legs",
          cost: 100,
          title: "Ant",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyAnt}});

      public static const ATLACH_NACHA: int = _partid++;
      EnumValue.add(Memories, ATLACH_NACHA, "ATLACH_NACHA", {
          id: "AtlachNacha Lower Body",name: "AtlachNacha Legs",
          cost: 200,
          title: "AtlachNacha",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyAtlachNacha}});

      public static const AVIAN: int = _partid++;
      EnumValue.add(Memories, AVIAN, "AVIAN", {
          id: "Avian Lower Body",name: "Avian Legs",
          cost: 200,
          title: "Avian",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyAvian}});

      public static const BEAR: int = _partid++;
      EnumValue.add(Memories, BEAR, "BEAR", {
          id: "Bear Lower Body",name: "Bear Legs",
          cost: 200,
          title: "Bear",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyBearToggle(true)}});

      public static const BEE: int = _partid++;
      EnumValue.add(Memories, BEE, "BEE", {
          id: "Bee Lower Body",name: "Bee Legs",
          cost: 100,
          title: "Bee",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyBee}});

      public static const BUNNY: int = _partid++;
      EnumValue.add(Memories, BUNNY, "BUNNY", {
          id: "Bunny Lower Body",name: "Bunny Legs",
          cost: 200,
          title: "Bunny",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyBunny}});

      public static const CANCER: int = _partid++;
      EnumValue.add(Memories, CANCER, "CANCER", {
          id: "Cancer Lower Body",name: "Cancer Legs",
          cost: 200,
          title: "Cancer",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyCancer}});

      public static const CAT: int = _partid++;
      EnumValue.add(Memories, CAT, "CAT", {
          id: "Cat Lower Body",name: "Cat Paws (Legs)",
          cost: 100,
          title: "Cat",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyCatToggle(true)}});

      public static const CAVE_WYRM: int = _partid++;
      EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
          id: "Cave Wyrm Lower Body",name: "Cave Wyrm Legs",
          cost: 100,
          title: "Cave Wyrm",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyCaveWyrm}});

      public static const CENTIPEDE: int = _partid++;
      EnumValue.add(Memories, CENTIPEDE, "CENTIPEDE", {
          id: "Centipede Lower Body",name: "Centipede Legs",
          cost: 200,
          title: "Centipede",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyCentipede}});

      public static const CHITINOUS_SPIDER_LEGS: int = _partid++;
      EnumValue.add(Memories, CHITINOUS_SPIDER_LEGS, "CHITINOUS_SPIDER_LEGS", {
          id: "Spider Lower Body",name: "Spider Lower Body",
          cost: 100,
          title: "Spider",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodySpider}});

      public static const CLOVEN_HOOFED: int = _partid++;
      EnumValue.add(Memories, CLOVEN_HOOFED, "CLOVEN_HOOFED", {
          id: "Cloven Hoofed Lower Body",name: "Cloven Hooves (Legs)",
          cost: 100,
          title: "Cl. Hoofed",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyClovenHoofedToggle(true)}});

      public static const CRAB: int = _partid++;
      EnumValue.add(Memories, CRAB, "CRAB", {
          id: "Crab Lower Body",name: "Crab Legs",
          cost: 200,
          title: "Crab",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyCrab}});

      public static const DEMONIC_CLAWS: int = _partid++;
      EnumValue.add(Memories, DEMONIC_CLAWS, "DEMONIC_CLAWS", {
          id: "Demon Clawed Lower Body",name: "Demonic Clawed Feet",
          cost: 100,
          title: "Dem. Claws",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyDemonClawed}});

      public static const DEMONIC_HIGH_HEELS: int = _partid++;
      EnumValue.add(Memories, DEMONIC_HIGH_HEELS, "DEMONIC_HIGH_HEELS", {
          id: "Demon High Heels Lower Body",name: "Demonic High Heels",
          cost: 100,
          title: "Dem. H. Heels",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyDemonHighHeels}});

      public static const DOG: int = _partid++;
      EnumValue.add(Memories, DOG, "DOG", {
          id: "Dog Lower Body",name: "Dog Legs",
          cost: 200,
          title: "Dog",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyDogToggle(true)}});

      public static const DRAGON: int = _partid++;
      EnumValue.add(Memories, DRAGON, "DRAGON", {
          id: "Draconic Lower Body",name: "Draconic Legs",
          cost: 100,
          title: "Dragon",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyDraconicToggle(true)}});

      public static const DRIDER: int = _partid++;
      EnumValue.add(Memories, DRIDER, "DRIDER", {
          id: "Drider Lower Body",name: "Drider Lower Body",
          cost: 300,
          title: "Drider",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyDrider},info: "Includes Spider tail and lower body parts."});

      public static const ELF: int = _partid++;
      EnumValue.add(Memories, ELF, "ELF", {
          id: "Elf Lower Body",name: "Elf Legs",
          cost: 100,
          title: "Elf",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyElf}});

      public static const FEY_DRAGON: int = _partid++;
      EnumValue.add(Memories, FEY_DRAGON, "FEY_DRAGON", {
          id: "Fey Draconic Lower Body",name: "Fey Draconic Legs",
          cost: 100,
          title: "Fey Dragon",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyFeyDraconicToggle(true)}});

      public static const FERRET: int = _partid++;
      EnumValue.add(Memories, FERRET, "FERRET", {
          id: "Ferret Lower Body",name: "Ferret Legs",
          cost: 200,
          title: "Ferret",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyFerret}});

      public static const FIRE_SNAIL: int = _partid++;
      EnumValue.add(Memories, FIRE_SNAIL, "FIRE_SNAIL", {
          id: "FireSnail Lower Body",name: "FireSnail Legs",
          cost: 200,
          title: "FireSnail",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyFireSnail}});

      public static const FOX: int = _partid++;
      EnumValue.add(Memories, FOX, "FOX", {
          id: "Fox Lower Body",name: "Fox Paws (Legs)",
          cost: 100,
          title: "Fox",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyFoxToggle(true)}});

      public static const FROSTWYRM: int = _partid++;
      EnumValue.add(Memories, FROSTWYRM, "FROSTWYRM", {
          id: "Frost wyrm Lower Body",name: "Frost wyrm Lower Body",
          cost: 100,
          title: "Frost wyrm",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyFrostwyrm}});

      public static const GAZER: int = _partid++;
      EnumValue.add(Memories, GAZER, "GAZER", {
          id: "Gazer Lower Body",name: "Gazer Legs",
          cost: 100,
          title: "Gazer",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyGazer}});

      public static const GHOST_2: int = _partid++;
      EnumValue.add(Memories, GHOST_2, "GHOST_2", {
          id: "Ghost2 Lower Body",name: "Ghost2 Legs",
          cost: 200,
          title: "Ghost2",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyGhost2}});

      public static const GHOST: int = _partid++;
      EnumValue.add(Memories, GHOST, "GHOST", {
          id: "Ghost Lower Body",name: "Ghost Legs",
          cost: 200,
          title: "Ghost",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyGhost}});

      public static const GOO: int = _partid++;
      EnumValue.add(Memories, GOO, "GOO", {
          id: "Goo Lower Body",name: "Goo Lower Body",
          cost: 100,
          title: "Goo",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyGoo}});

      public static const GRYPHON: int = _partid++;
      EnumValue.add(Memories, GRYPHON, "GRYPHON", {
          id: "Gryphon Lower Body",name: "Gryphon Legs",
          cost: 200,
          title: "Gryphon",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyGryphonToggle(true)}});

      public static const HARPY: int = _partid++;
      EnumValue.add(Memories, HARPY, "HARPY", {
          id: "Harpy Lower Body",name: "Harpy Lower Body",
          cost: 100,
          title: "Harpy",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyHarpy}});

      public static const HINEZUMI: int = _partid++;
      EnumValue.add(Memories, HINEZUMI, "HINEZUMI", {
          id: "Hinezumi Lower Body",name: "Hinezumi Legs",
          cost: 100,
          title: "Hinezumi",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyHinezumi}});

      public static const HOOFED: int = _partid++;
      EnumValue.add(Memories, HOOFED, "HOOFED", {
          id: "Hoofed Lower Body",name: "Hooves (Legs)",
          cost: 100,
          title: "Hoofed",
          unlockText: "Now you can metamorph into the Taur variant of any lower body part you unlocked when available!",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyHoofedToggle(true)}});

      public static const HYDRA: int = _partid++;
      EnumValue.add(Memories, HYDRA, "HYDRA", {
          id: "Hydra Lower Body",name: "Hydra Lower body",
          cost: 200,
          title: "Hydra",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyHydra}});

      public static const JABBERWOCKY: int = _partid++;
      EnumValue.add(Memories, JABBERWOCKY, "JABBERWOCKY", {
          id: "Jabberwocky Lower Body",name: "Jabberwocky Legs",
          cost: 200,
          title: "Jabberwocky",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyJabberwocky}});

      public static const JIANGSHI: int = _partid++;
      EnumValue.add(Memories, JIANGSHI, "JIANGSHI", {
          id: "Jiangshi Lower Body",name: "Jiangshi Legs",
          cost: 200,
          title: "Jiangshi",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyJiangshi}});

      public static const KANGAROO: int = _partid++;
      EnumValue.add(Memories, KANGAROO, "KANGAROO", {
          id: "Kangaroo Lower Body",name: "Kangaroo Legs",
          cost: 200,
          title: "Kangaroo",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyKangaroo}});

      public static const KIRIN: int = _partid++;
      EnumValue.add(Memories, KIRIN, "KIRIN", {
          id: "Kirin Lower Body",name: "Kirin Legs",
          cost: 200,
          title: "Kirin",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyKirinToggle(true)}});

      public static const KRAKEN: int = _partid++;
      EnumValue.add(Memories, KRAKEN, "KRAKEN", {
          id: "Kraken Lower Body",name: "Kraken Tentacles",
          cost: 300,
          title: "Kraken",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyKraken}});

      public static const LION: int = _partid++;
      EnumValue.add(Memories, LION, "LION", {
          id: "Lion Lower Body",name: "Lion Paws (Legs)",
          cost: 100,
          title: "Lion",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyLionToggle(true)}});

      public static const LIZARD: int = _partid++;
      EnumValue.add(Memories, LIZARD, "LIZARD", {
          id: "Lizard Lower Body",name: "Lizard Legs",
          cost: 100,
          title: "Lizard",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyLizardToggle(true)}});

      public static const MANTIS: int = _partid++;
      EnumValue.add(Memories, MANTIS, "MANTIS", {
          id: "Mantis Lower Body",name: "Mantis Lower Body",
          cost: 100,
          title: "Mantis",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyMantisToggle(true)}});

      public static const MELKIE: int = _partid++;
      EnumValue.add(Memories, MELKIE, "MELKIE", {
          id: "Melkie Lower Body",name: "Melkie Legs",
          cost: 200,
          title: "Melkie",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyMelkie}});

      public static const MOUSE: int = _partid++;
      EnumValue.add(Memories, MOUSE, "MOUSE", {
          id: "Mouse Lower Body",name: "Mouse Legs",
          cost: 100,
          title: "Mouse",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyMouse}});

      public static const NAGA: int = _partid++;
      EnumValue.add(Memories, NAGA, "NAGA", {
          id: "Snake Lower Body",name: "Naga Lower Body",
          cost: 100,
          title: "Naga",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodySnake}});

      public static const ONI: int = _partid++;
      EnumValue.add(Memories, ONI, "ONI", {
          id: "Oni Lower Body",name: "Oni Legs",
          cost: 100,
          title: "Oni",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyOni}});

      public static const ORC: int = _partid++;
      EnumValue.add(Memories, ORC, "ORC", {
          id: "Orc Lower Body",name: "Orc Legs",
          cost: 100,
          title: "Orc",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyOrc}});

      public static const ORCA: int = _partid++;
      EnumValue.add(Memories, ORCA, "ORCA", {
          id: "Orca Lower Body",name: "Orca Legs",
          cost: 100,
          title: "Orca",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyOrcaToggle(true)}});

      public static const PLANT_HIGH_HEELS: int = _partid++;
      EnumValue.add(Memories, PLANT_HIGH_HEELS, "PLANT_HIGH_HEELS", {
          id: "PlantHighHeels Lower Body",name: "PlantHighHeels Legs",
          cost: 200,
          title: "PlantHighHeels",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyPlantHighHeels}});

      public static const PLANT_ROOT_CLAWS: int = _partid++;
      EnumValue.add(Memories, PLANT_ROOT_CLAWS, "PLANT_ROOT_CLAWS", {
          id: "PlantRootClaws Lower Body",name: "PlantRootClaws Legs",
          cost: 200,
          title: "PlantRootClaws",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyPlantRootClaws}});

      public static const RACCOON: int = _partid++;
      EnumValue.add(Memories, RACCOON, "RACCOON", {
          id: "Raccoon Lower Body",name: "Raccoon Legs",
          cost: 200,
          title: "Raccoon",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyRaccoon}});

      public static const RAIJU: int = _partid++;
      EnumValue.add(Memories, RAIJU, "RAIJU", {
          id: "Raiju Lower Body",name: "Raiju Paws (Legs)",
          cost: 100,
          title: "Raiju",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyRaijuToggle(true)}});

      public static const RED_PANDA: int = _partid++;
      EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
          id: "Red Panda Lower Body",name: "Red Panda Paws (Legs)",
          cost: 100,
          title: "Red Panda",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyRedPanda}});

      public static const SALAMANDER: int = _partid++;
      EnumValue.add(Memories, SALAMANDER, "SALAMANDER", {
          id: "Salamander Lower Body",name: "Salamander Legs",
          cost: 100,
          title: "Salamander",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodySalamanderToggle(true)}});

      public static const SCYLLA: int = _partid++;
      EnumValue.add(Memories, SCYLLA, "SCYLLA", {
          id: "Scylla Lower Body",name: "Scylla Tentacles",
          cost: 200,
          title: "Scylla",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyScylla}});

      public static const SEA_DRAGON: int = _partid++;
      EnumValue.add(Memories, SEA_DRAGON, "SEA_DRAGON", {
          id: "SeaDragon Lower Body",name: "SeaDragon Legs",
          cost: 200,
          title: "SeaDragon",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodySeaDragonToggle(true)}});

      public static const SHARK: int = _partid++;
      EnumValue.add(Memories, SHARK, "SHARK", {
          id: "Shark Lower Body",name: "Shark Legs",
          cost: 100,
          title: "Shark",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodySharkToggle(true)}});

      public static const SQUIRREL: int = _partid++;
      EnumValue.add(Memories, SQUIRREL, "SQUIRREL", {
          id: "Squirrel Lower Body",name: "Squirrel Legs",
          cost: 200,
          title: "Squirrel",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodySquirrel}});

      public static const TINY: int = _partid++;
      EnumValue.add(Memories, TINY, "TINY", {
          id: "Tiny Lower Body",name: "Tiny Legs",
          cost: 200,
          title: "Tiny",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyTiny}});

      public static const USHI_ONI: int = _partid++;
      EnumValue.add(Memories, USHI_ONI, "USHI_ONI", {
          id: "UshiOni Lower Body",name: "UshiOni Legs",
          cost: 200,
          title: "UshiOni",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyUshiOni}});

      public static const WEASEL: int = _partid++;
      EnumValue.add(Memories, WEASEL, "WEASEL", {
          id: "Weasel Lower Body",name: "Weasel Legs",
          cost: 200,
          title: "Weasel",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyWeaselToggle(true)}});

      public static const WENDIGO: int = _partid++;
      EnumValue.add(Memories, WENDIGO, "WENDIGO", {
          id: "Wendigo Lower Body",name: "Wendigo Legs",
          cost: 200,
          title: "Wendigo",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyWendigo}});

      public static const WOLF: int = _partid++;
      EnumValue.add(Memories, WOLF, "WOLF", {
          id: "Wolf Lower Body",name: "Wolf Legs",
          cost: 100,
          title: "Wolf",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyWolfToggle(true)}});

      public static const YETI: int = _partid++;
      EnumValue.add(Memories, YETI, "YETI", {
          id: "Yeti Lower Body",name: "Yeti Lower Body",
          cost: 100,
          title: "Yeti",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyYeti;}});

      public static const YUKI_ONNA: int = _partid++;
      EnumValue.add(Memories, YUKI_ONNA, "YUKI_ONNA", {
          id: "YukiOnna Lower Body",name: "YukiOnna Legs",
          cost: 200,
          title: "YukiOnna",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyYukiOnna}});

      public static const YGG_ROOT_CLAWS: int = _partid++;
      EnumValue.add(Memories, YGG_ROOT_CLAWS, "YGG_ROOT_CLAWS", {
          id: "YggRootClaws Lower Body",name: "YggRootClaws Legs",
          cost: 200,
          title: "YggdrasilRootClaws",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyYgddrasilRootClaws}});

      public static const ABYSSAL_SHARK: int = _partid++;
      EnumValue.add(Memories, ABYSSAL_SHARK, "ABYSSAL_SHARK", {
          id: "Abyssal Shark Lower Body",name: "Abyssal Shark Legs",
          cost: 200,
          title: "Abyssal Shark Legs",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyAbyssalShark}});

      public static const WERESHARK: int = _partid++;
      EnumValue.add(Memories, WERESHARK, "WERESHARK", {
          id: "Wereshark Lower Body",name: "Wereshark Legs",
          cost: 200,
          title: "Wereshark Legs",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyWereshark}});

      public static const ARIGEAN: int = _partid++;
      EnumValue.add(Memories, ARIGEAN, "ARIGEAN", {
          id: "Arigean Lower Body",name: "Arigean Legs",
          cost: 100,
          title: "Arigean Legs",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyArigean}});

      public static const DEMONIC_GRACEFUL_FEET: int = _partid++;
      EnumValue.add(Memories, DEMONIC_GRACEFUL_FEET, "DEMONIC_GRACEFUL_FEET", {
          id: "Demon Graceful Feet Lower Body",name: "Demonic Graceful Feet",
          cost: 100,
          title: "Dem. G. Feet",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyDemonGracefulFeet}});

      public static const CLOVEN_HOOFED_2: int = _partid++;
      EnumValue.add(Memories, CLOVEN_HOOFED_2, "CLOVEN_HOOFED_2", {
          id: "Reindeer Lower Body",name: "Reindeer Legs",
          cost: 200,
          title: "Reindeer Legs",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyReindeerToggle(true)}});

      public static const MOTH: int = _partid++;
      EnumValue.add(Memories, MOTH, "MOTH", {
          id: "Moth Lower Body",name: "Moth Legs",
          cost: 100,
          title: "Moth Legs",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyMoth}});

      public static const TROLL: int = _partid++;
      EnumValue.add(Memories, TROLL, "TROLL", {
          id: "Troll Lower Body",name: "Troll Legs",
          cost: 100,
          title: "Troll Legs",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyTroll}});

      public static const GLACIAL_TROLL: int = _partid++;
      EnumValue.add(Memories, GLACIAL_TROLL, "GLACIAL_TROLL", {
          id: "G.Troll Lower Body",name: "G.Troll Legs",
          cost: 100,
          title: "G.Troll Legs",
          transformation: function(): Transformation {return CoC.instance.transformations.LowerBodyGlacialTroll}});

      public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
