package classes.Items.Alchemy {
import classes.BaseContent;
import classes.internals.EnumValue;

public class AlchemyLib extends BaseContent {
	public function AlchemyLib() {
	}
	
	// id values are saved in items - do not change existing, add new to the end
	
	// Pill power tiers
	
	/**
	 * EnumValue properties
	 * * short: button name;
	 * * name: full name;
	 * * chance: effect chance (%).
	 * * power: effect multiplier
	 * * value: value multiplier
	 * * xp: alchemy skill xp gained for refining
	 */
	public static const PillPowerTiers:/*EnumValue*/Array = [];
	public static const PP_DEAD:int                       = EnumValue.add(PillPowerTiers, 0, "DEAD", {
		short : "D.",
		name  : "dead",
		chance: 0,
		power : 0,
		value : 0,
		xp    : 1
	});
	public static const PP_FAINT:int                      = EnumValue.add(PillPowerTiers, 1, "FAINT", {
		short : "F.",
		name  : "faint",
		chance: 50,
		power : 1,
		value : 1,
		xp    : 2
	});
	public static const PP_WEAK:int                       = EnumValue.add(PillPowerTiers, 2, "WEAK", {
		short : "W.",
		name  : "weak",
		chance: 60,
		power : 2,
		value : 2,
		xp    : 5
	});
	public static const PP_NORMAL:int                     = EnumValue.add(PillPowerTiers, 3, "NORMAL", {
		short : "N.",
		name  : "normal",
		chance: 70,
		power : 3,
		value : 5,
		xp    : 10
	});
	public static const PP_POTENT:int                     = EnumValue.add(PillPowerTiers, 4, "POTENT", {
		short : "P.",
		name  : "potent",
		chance: 80,
		power : 4,
		value : 8,
		xp    : 20
	});
	public static const PP_RADIANT:int                    = EnumValue.add(PillPowerTiers, 5, "RADIANT", {
		short : "R.",
		name  : "radiant",
		chance: 100,
		power : 5,
		value : 10,
		xp    : 50
	});
	
	// Reagent types
	
	public static const RT_NOTHING:int   = 0;
	public static const RT_SUBSTANCE:int = 1;
	public static const RT_ESSENCE:int   = 2;
	public static const RT_RESIDUE:int   = 3;
	public static const RT_PIGMENT:int   = 4;
	
	public static const ReagentTypes:/*EnumValue*/Array = [];
	EnumValue.add(ReagentTypes, RT_NOTHING, "NOTHING", {});
	EnumValue.add(ReagentTypes, RT_SUBSTANCE, "SUBSTANCE", {
		name: "substance"
	});
	EnumValue.add(ReagentTypes, RT_ESSENCE, "ESSENCE", {
		name: "essence"
	});
	EnumValue.add(ReagentTypes, RT_RESIDUE, "RESIDUE", {
		name: "residue"
	});
	EnumValue.add(ReagentTypes, RT_PIGMENT, "PIGMENT", {
		name: "pigment"
	});
	
	// Substances (body parts)
	
	/**
	 * * short: button name ("Antn", "Arms");
	 * * name: item name ("Antennae", "Arms").
	 */
	public static const Substances:/*EnumValue*/Array = [];
	public static const AS_NONE:int                   = EnumValue.add(Substances, 0, "NONE", {
		short: "None",
		name : "none"
	});
	public static const AS_ANTENNAE:int               = EnumValue.add(Substances, 1, "ANTENNAE", {
		short: "Antn",
		name : "antennae"
	});
	public static const AS_ARMS:int                   = EnumValue.add(Substances, 2, "ARMS", {
		short: "Arms",
		name : "arms"
	});
	public static const AS_ASS:int                    = EnumValue.add(Substances, 3, "ASS", {
		short: "Ass",
		name : "ass"
	});
	public static const AS_BALLS:int                  = EnumValue.add(Substances, 4, "BALLS", {
		short: "Balls",
		name : "balls"
	});
	public static const AS_BREASTS:int                = EnumValue.add(Substances, 5, "BREASTS", {
		short: "Tits",
		name : "breasts"
	});
	public static const AS_CLIT:int                   = EnumValue.add(Substances, 6, "CLIT", {
		short: "Clit",
		name : "clit"
	});
	public static const AS_COCK:int                   = EnumValue.add(Substances, 7, "COCK", {
		// TODO
		short: "Cock",
		name : "cock"
	});
	public static const AS_EARS:int                   = EnumValue.add(Substances, 8, "EARS", {
		short: "Ears",
		name : "ears"
	});
	public static const AS_EYES:int                   = EnumValue.add(Substances, 9, "EYES", {
		short: "Eyes",
		name : "eyes"
	});
	public static const AS_FACE:int                   = EnumValue.add(Substances, 10, "FACE", {
		short: "Face",
		name : "face"
	});
	public static const AS_GILLS:int                  = EnumValue.add(Substances, 11, "GILLS", {
		short: "Gills",
		name : "gills"
	});
	public static const AS_HAIR:int                   = EnumValue.add(Substances, 12, "HAIR", {
		short: "Hair",
		name : "hair"
	});
	public static const AS_HORNS:int                  = EnumValue.add(Substances, 13, "HORNS", {
		short: "Horns",
		name : "horns"
	});
	public static const AS_LEGS:int                   = EnumValue.add(Substances, 14, "LEGS", {
		short: "Legs",
		name : "legs"
	});
	public static const AS_NIPPLES:int                = EnumValue.add(Substances, 15, "NIPPLES", {
		short: "Nips",
		name : "nipples"
	});
	public static const AS_REAR:int                   = EnumValue.add(Substances, 16, "REAR", {
		short: "Rear",
		name : "rear body"
	});
	public static const AS_SKIN:int                   = EnumValue.add(Substances, 17, "SKIN", {
		short: "Skin",
		name : "skin"
	});
	public static const AS_SKIN_PATTERN:int           = EnumValue.add(Substances, 18, "SKIN_PATTERN", {
		short: "Patt",
		name : "skin pattern"
	});
	public static const AS_TAIL:int                   = EnumValue.add(Substances, 19, "TAIL", {
		short: "Tail",
		name : "tail"
	});
	public static const AS_TONGUE:int                 = EnumValue.add(Substances, 20, "TONGUE", {
		short: "Tong",
		name : "tongue"
	});
	public static const AS_VAGINA:int                 = EnumValue.add(Substances, 21, "VAGINA", {
		// TODO
		short: "Vag",
		name : "vagina"
	});
	public static const AS_WINGS:int                  = EnumValue.add(Substances, 22, "WINGS", {
		short: "Wings",
		name : "wings"
	});
	
	public static const DEFAULT_SUBSTANCES_DROP_TABLE:Array = [
		[0.25, AS_ANTENNAE],
		[1, AS_ARMS],
		[0.25, AS_ASS],
		[0.25, AS_BALLS],
		[0.25, AS_BREASTS],
		[0.25, AS_CLIT],
		[1, AS_COCK],
		[1, AS_EARS],
		[1, AS_EYES],
		[1, AS_FACE],
		[0.25, AS_GILLS],
		[0.5, AS_HAIR],
		[0.5, AS_HORNS],
		[1, AS_LEGS],
		[0.25, AS_NIPPLES],
		[0.5, AS_REAR],
		[1, AS_SKIN],
		[0.25, AS_SKIN_PATTERN],
		[1, AS_TAIL],
		[0.25, AS_TONGUE],
		[0.25, AS_VAGINA],
		[1, AS_WINGS]
	];
	
	// Essences (races or body part effects)
	
	/**
	 * * short: button name ("Cat", "AtNc");
	 * * name: item name ("Cat", "Atlach Nacha").
	 */
	public static const Essences:/*EnumValue*/Array = [];
	public static const AE_NONE:int                 = EnumValue.add(Essences, 0, "NONE", {
		short: "None",
		name : "none"
	});
	public static const AE_REMOVE:int               = EnumValue.add(Essences, 1, "REMOVAL", {
		short: "Rem",
		name : "Removal"
	});
	public static const AE_GROW:int                 = EnumValue.add(Essences, 2, "GROW", {
		short: "Grow",
		name : "Growth"
	});
	public static const AE_SHRINK:int               = EnumValue.add(Essences, 3, "SHRINK", {
		short: "Shr",
		name : "Shrinking"
	});
	
	// 5-99: reserved for non-race essences
	
	public static const AE_HUMAN:int           = EnumValue.add(Essences, 100, "HUMAN", {
		short: "Human",
		name : "Human"
	});
	public static const AE_ALICORN:int         = EnumValue.add(Essences, 101, "ALICORN", {
		short: "Alic",
		name : "Alicorn"
	});
	public static const AE_ALRAUNE:int         = EnumValue.add(Essences, 102, "ALRAUNE", {
		short: "Raune",
		name : "Alraune"
	});
	public static const AE_ANEMONE:int         = EnumValue.add(Essences, 103, "ANEMONE", {
		short: "Anmn",
		name : "Anemone"
	});
	public static const AE_ANT:int             = EnumValue.add(Essences, 104, "ANT", {
		short: "Ant",
		name : "Ant"
	});
	public static const AE_APOPHIS:int         = EnumValue.add(Essences, 105, "APOPHIS", {
		short: "Apphs",
		name : "Apophis"
	});
	public static const AE_ATLACH_NACHA:int    = EnumValue.add(Essences, 106, "ATLACH_NACHA", {
		short: "AtlNc",
		name : "Atlach Nacha"
	});
	public static const AE_AVIAN:int           = EnumValue.add(Essences, 107, "AVIAN", {
		short: "Avian",
		name : "Avian"
	});
	public static const AE_AZAZEL:int          = EnumValue.add(Essences, 108, "AZAZEL", {
		short: "Azzl",
		name : "Azazel"
	});
	public static const AE_BAT:int             = EnumValue.add(Essences, 109, "BAT", {
		short: "Bat",
		name : "Bat"
	});
	public static const AE_BEAR:int            = EnumValue.add(Essences, 110, "BEAR", {
		short: "Bear",
		name : "Bear"
	});
	public static const AE_BEE:int             = EnumValue.add(Essences, 111, "BEE", {
		short: "Bee",
		name : "Bee"
	});
	public static const AE_BICORN:int          = EnumValue.add(Essences, 112, "BICORN", {
		short: "Bic",
		name : "Bicorn"
	});
	public static const AE_BOAR:int            = EnumValue.add(Essences, 113, "BOAR", {
		short: "Boar",
		name : "Boar"
	});
	public static const AE_BUNNY:int           = EnumValue.add(Essences, 114, "BUNNY", {
		short: "Bnuy",
		name : "Bunny"
	});
	public static const AE_CANCER:int          = EnumValue.add(Essences, 115, "CANCER", {
		short: "Ccer",
		name : "Cancer"
	});
	public static const AE_CAT:int             = EnumValue.add(Essences, 116, "CAT", {
		short: "Cat",
		name : "Cat"
	});
	public static const AE_CAVE_WYRM:int       = EnumValue.add(Essences, 117, "CAVE_WYRM", {
		short: "CWyrm",
		name : "Cave wyrm"
	});
	public static const AE_CENTIPEDE:int       = EnumValue.add(Essences, 118, "CENTIPEDE", {
		short: "Cpede",
		name : "Centipede"
	});
	public static const AE_CERBERUS:int        = EnumValue.add(Essences, 119, "CERBERUS", {
		short: "Cerb",
		name : "Cerberus"
	});
	public static const AE_COUATL:int          = EnumValue.add(Essences, 120, "COUATL", {
		short: "Cotl",
		name : "Couatl"
	});
	public static const AE_CHESHIRE:int        = EnumValue.add(Essences, 121, "CHESHIRE", {
		short: "Chesh",
		name : "Cheshire"
	});
	public static const AE_COW:int             = EnumValue.add(Essences, 122, "COW", {
		short: "Cow",
		name : "Cow"
	});
	public static const AE_CYCLOP:int          = EnumValue.add(Essences, 123, "CYCLOP", {
		short: "MonoI",
		name : "Cyclop"
	});
	public static const AE_DARK_SLIME:int      = EnumValue.add(Essences, 124, "DARK_SLIME", {
		short: "DSlim",
		name : "Dark slime"
	});
	public static const AE_DEER:int            = EnumValue.add(Essences, 125, "DEER", {
		short: "Deer",
		name : "Deer"
	});
	public static const AE_DEMON:int           = EnumValue.add(Essences, 126, "DEMON", {
		short: "Demon",
		name : "Demon"
	});
	public static const AE_DEVIL:int           = EnumValue.add(Essences, 127, "DEVIL", {
		short: "Devil",
		name : "Devil"
	});
	public static const AE_DISPLACER_BEAST:int = EnumValue.add(Essences, 128, "DISPLACER_BEAST", {
		short: "DispB",
		name : "Displacer beast"
	});
	public static const AE_DOG:int             = EnumValue.add(Essences, 129, "DOG", {
		short: "Don",
		name : "Dog"
	});
	public static const AE_DRAGON:int          = EnumValue.add(Essences, 130, "DRAGON", {
		short: "Drgn",
		name : "Dragon"
	});
	public static const AE_ECHIDNA:int         = EnumValue.add(Essences, 131, "ECHIDNA", {
		short: "Ech",
		name : "Echidna"
	});
	public static const AE_ELF:int             = EnumValue.add(Essences, 132, "ELF", {
		short: "Elf",
		name : "Elf"
	});
	public static const AE_FAERIE_DRAGON:int   = EnumValue.add(Essences, 133, "FAERIE_DRAGON", {
		short: "FDrgn",
		name : "Faerie dragon"
	});
	public static const AE_FAIRY:int           = EnumValue.add(Essences, 134, "FAIRY", {
		short: "Fey",
		name : "Fairy"
	});
	public static const AE_FENRIR:int          = EnumValue.add(Essences, 135, "FENRIR", {
		short: "Frir",
		name : "Fenrir"
	});
	public static const AE_FIRE_SNAIL:int      = EnumValue.add(Essences, 136, "FIRE_SNAIL", {
		short: "FSnl",
		name : "Fire snail"
	});
	public static const AE_FERRET:int          = EnumValue.add(Essences, 137, "FERRET", {
		short: "Frrt",
		name : "Ferret"
	});
	public static const AE_FOX:int             = EnumValue.add(Essences, 138, "FOX", {
		short: "Fox",
		name : "Fox"
	});
	public static const AE_FROST_WYRM:int      = EnumValue.add(Essences, 139, "FROST_WYRM", {
		short: "FWyrm",
		name : "Frost wyrm"
	});
	public static const AE_GAZER:int           = EnumValue.add(Essences, 140, "GAZER", {
		short: "Gazer",
		name : "Gazer"
	});
	public static const AE_GHOST:int           = EnumValue.add(Essences, 141, "GHOST", {
		short: "Ghost",
		name : "Ghost"
	});
	public static const AE_GOBLIN:int          = EnumValue.add(Essences, 142, "GOBLIN", {
		short: "Gbln",
		name : "Goblin"
	});
	public static const AE_GOAT:int            = EnumValue.add(Essences, 143, "GOAT", {
		short: "Goat",
		name : "Goat"
	});
	public static const AE_GOO:int             = EnumValue.add(Essences, 144, "GOO", {
		short: "Goo",
		name : "Goo"
	});
	public static const AE_GORGON:int          = EnumValue.add(Essences, 145, "GORGON", {
		short: "Grgn",
		name : "Gorgon"
	});
	public static const AE_GREMLIN:int         = EnumValue.add(Essences, 146, "GREMLIN", {
		short: "Grmln",
		name : "Gremlin"
	});
	public static const AE_GRYPHON:int         = EnumValue.add(Essences, 147, "GRYPHON", {
		short: "Grphn",
		name : "Gryphon"
	});
	public static const AE_HARPY:int           = EnumValue.add(Essences, 148, "HARPY", {
		short: "Harpy",
		name : "Harpy"
	});
	public static const AE_HELLCAT:int         = EnumValue.add(Essences, 149, "HELLCAT", {
		short: "HCat",
		name : "Hellcat"
	});
	public static const AE_HINEZUMI:int        = EnumValue.add(Essences, 150, "HINEZUMI", {
		short: "Hnzmi",
		name : "Hinezumi"
	});
	public static const AE_HORSE:int           = EnumValue.add(Essences, 151, "HORSE", {
		short: "Horse",
		name : "Horse"
	});
	public static const AE_HYDRA:int           = EnumValue.add(Essences, 152, "HYDRA", {
		short: "Hydra",
		name : "Hydra"
	});
	public static const AE_IMP:int             = EnumValue.add(Essences, 153, "IMP", {
		short: "Imp",
		name : "Imp"
	});
	public static const AE_JABBERWOCKY:int     = EnumValue.add(Essences, 154, "JABBERWOCKY", {
		short: "Wocky",
		name : "Jabberwocky"
	});
	public static const AE_JIANGSHI:int        = EnumValue.add(Essences, 155, "JIANGSHI", {
		short: "Jshi",
		name : "Jiangshi"
	});
	public static const AE_KAMAITACHI:int      = EnumValue.add(Essences, 156, "KAMAITACHI", {
		short: "Ktchi",
		name : "Kamaitachi"
	});
	public static const AE_KANGAROO:int        = EnumValue.add(Essences, 157, "KANGAROO", {
		short: "Roo",
		name : "Kangaroo"
	});
	public static const AE_KIRIN:int           = EnumValue.add(Essences, 158, "KIRIN", {
		short: "Kirin",
		name : "Kirin"
	});
	public static const AE_KITSUNE:int         = EnumValue.add(Essences, 159, "KITSUNE", {
		short: "Kitsu",
		name : "Kitsune"
	});
	public static const AE_KRAKEN:int          = EnumValue.add(Essences, 160, "KRAKEN", {
		short: "Krak",
		name : "Kraken"
	});
	public static const AE_LION:int            = EnumValue.add(Essences, 161, "LION", {
		short: "Lion",
		name : "Lion"
	});
	public static const AE_LIZARD:int          = EnumValue.add(Essences, 162, "LIZARD", {
		short: "Liz",
		name : "Lizard"
	});
	public static const AE_MANTICORE:int       = EnumValue.add(Essences, 163, "MANTICORE", {
		short: "Mcore",
		name : "Manticore"
	});
	public static const AE_MANTIS:int          = EnumValue.add(Essences, 164, "MANTIS", {
		short: "Mtis",
		name : "Mantis"
	});
	public static const AE_MELKIE:int          = EnumValue.add(Essences, 165, "MELKIE", {
		short: "Melk",
		name : "Melkie"
	});
	public static const AE_MOUSE:int           = EnumValue.add(Essences, 166, "MOUSE", {
		short: "Mouse",
		name : "Mouse"
	});
	public static const AE_NEKOMATA:int        = EnumValue.add(Essences, 167, "NEKOMATA", {
		short: "Neko",
		name : "Nekomata"
	});
	public static const AE_NIGHTMARE:int       = EnumValue.add(Essences, 168, "NIGHTMARE", {
		short: "Nmare",
		name : "Nightmare"
	});
	public static const AE_ONI:int             = EnumValue.add(Essences, 169, "ONI", {
		short: "Oni",
		name : "Oni"
	});
	public static const AE_OOMUKADE:int        = EnumValue.add(Essences, 170, "OOMUKADE", {
		short: "Oomkd",
		name : "Oomukade"
	});
	public static const AE_ORC:int             = EnumValue.add(Essences, 171, "ORC", {
		short: "Orc",
		name : "Orc"
	});
	public static const AE_ORCA:int            = EnumValue.add(Essences, 172, "ORCA", {
		short: "Orca",
		name : "Orca"
	});
	public static const AE_PANDA:int           = EnumValue.add(Essences, 173, "PANDA", {
		short: "Panda",
		name : "Panda"
	});
	public static const AE_PHOENIX:int         = EnumValue.add(Essences, 174, "PHOENIX", {
		short: "Phnx",
		name : "Phoenix"
	});
	public static const AE_PIG:int             = EnumValue.add(Essences, 175, "PIG", {
		short: "Pig",
		name : "Pig"
	});
	public static const AE_PLANT:int           = EnumValue.add(Essences, 176, "PLANT", {
		short: "Plant",
		name : "Plant"
	});
	public static const AE_POLTERGEIST:int     = EnumValue.add(Essences, 177, "POLTERGEIST", {
		short: "Polg",
		name : "Poltergeist"
	});
	public static const AE_RACCOON:int         = EnumValue.add(Essences, 178, "RACCOON", {
		short: "Coon",
		name : "Raccoon"
	});
	public static const AE_RAIJU:int           = EnumValue.add(Essences, 179, "RAIJU", {
		short: "Raiju",
		name : "Raiju"
	});
	public static const AE_RED_PANDA:int       = EnumValue.add(Essences, 180, "RED_PANDA", {
		short: "RedPan",
		name : "Red panda"
	});
	public static const AE_RHINO:int           = EnumValue.add(Essences, 181, "RHINO", {
		short: "Rhino",
		name : "Rhino"
	});
	public static const AE_SALAMANDER:int      = EnumValue.add(Essences, 182, "SALAMANDER", {
		short: "Salam",
		name : "Salamander"
	});
	public static const AE_SAND_TRAP:int       = EnumValue.add(Essences, 183, "SAND_TRAP", {
		short: "STrap",
		name : "Sandtrap"
	});
	public static const AE_SAND_WORM:int       = EnumValue.add(Essences, 184, "SAND_WORM", {
		short: "SWorm",
		name : "Sandworm"
	});
	public static const AE_SCORPION:int        = EnumValue.add(Essences, 185, "SCORPION", {
		short: "Scor",
		name : "Scorpion"
	});
	public static const AE_SCYLLA:int          = EnumValue.add(Essences, 186, "SCYLLA", {
		short: "Scy",
		name : "Scylla"
	});
	public static const AE_SEA_DRAGON:int      = EnumValue.add(Essences, 187, "SEA_DRAGON", {
		short: "SeaD",
		name : "Sea dragon"
	});
	public static const AE_SHARK:int           = EnumValue.add(Essences, 188, "SHARK", {
		short: "Shark",
		name : "Shark"
	});
	public static const AE_SIREN:int           = EnumValue.add(Essences, 189, "SIREN", {
		short: "Siren",
		name : "Siren"
	});
	public static const AE_SNAKE:int           = EnumValue.add(Essences, 190, "SNAKE", {
		short: "Snake",
		name : "Snake"
	});
	public static const AE_SPHINX:int          = EnumValue.add(Essences, 191, "SPHINX", {
		short: "Sphx",
		name : "Sphinx"
	});
	public static const AE_SPIDER:int          = EnumValue.add(Essences, 192, "SPIDER", {
		short: "Spdr",
		name : "Spider"
	});
	public static const AE_SQUIRREL:int        = EnumValue.add(Essences, 193, "SQUIRREL", {
		short: "Squir",
		name : "Squirrel"
	});
	public static const AE_THUNDERBIRD:int     = EnumValue.add(Essences, 194, "THUNDERBIRD", {
		short: "Thbrd",
		name : "Thunderbird"
	});
	public static const AE_USHI_ONI:int        = EnumValue.add(Essences, 195, "USHI_ONI", {
		short: "Ushi",
		name : "Ushi-oni"
	});
	public static const AE_UNICORN:int         = EnumValue.add(Essences, 196, "UNICORN", {
		short: "Unic",
		name : "Unicorn"
	});
	public static const AE_VAMPIRE:int         = EnumValue.add(Essences, 197, "VAMPIRE", {
		short: "Vamp",
		name : "Vampire"
	});
	public static const AE_WEASEL:int          = EnumValue.add(Essences, 198, "WEASEL", {
		short: "Weas",
		name : "Weasel"
	});
	public static const AE_WENDIGO:int         = EnumValue.add(Essences, 199, "WENDIGO", {
		short: "Wendy",
		name : "Wendigo"
	});
	public static const AE_WEREWOLF:int        = EnumValue.add(Essences, 200, "WEREWOLF", {
		short: "WWolf",
		name : "Werewolf"
	});
	public static const AE_WOLF:int            = EnumValue.add(Essences, 201, "WOLF", {
		short: "Wolf",
		name : "Wolf"
	});
	public static const AE_YETI:int            = EnumValue.add(Essences, 202, "YETI", {
		short: "Yeti",
		name : "Yeti"
	});
	public static const AE_YGGDRASIL:int       = EnumValue.add(Essences, 203, "YGGDRASIL", {
		short: "Yggd",
		name : "Yggdrasil"
	});
	public static const AE_YUKI_ONNA:int       = EnumValue.add(Essences, 204, "YUKI_ONNA", {
		short: "Yuki",
		name : "Yuki-onna"
	});
	public static const AE_LEVIATHAN:int       = EnumValue.add(Essences, 205, "LEVIATHAN", {
		short: "Levi",
		name : "Leviathan"
	});
	public static const AE_TROLL:int           = EnumValue.add(Essences, 206, "TROLL", {
		short: "Troll",
		name : "Troll"
	});
	public static const AE_SATYR:int           = EnumValue.add(Essences, 207, "SATYR", {
		short: "Satyr",
		name : "Satyr"
	});
	public static const AE_DRIDER:int          = EnumValue.add(Essences, 208, "DRIDER", {
		short: "Drider",
		name : "Drider"
	});
	public static const AE_WEREFOX:int         = EnumValue.add(Essences, 209, "WEREFOX", {
		short: "WFox",
		name : "Werefox"
	});
	public static const AE_ANUBIS:int          = EnumValue.add(Essences, 210, "ANUBIS", {
		short: "Anubis",
		name : "Anubis"
	});
	public static const AE_WERESHARK:int       = EnumValue.add(Essences, 211, "WERESHARK", {
		short: "WSkark",
		name : "Wereshark"
	});
	public static const AE_ABYSSAL_SHARK:int   = EnumValue.add(Essences, 212, "ABYSSAL_SHARK", {
		short: "AShark",
		name : "Abyssal Shark"
	});
	public static const AE_DRAGONNE:int        = EnumValue.add(Essences, 213, "DRAGONNE", {
		short: "Drgne",
		name : "Dragonne"
	});
	public static const AE_ARIGEAN:int        = EnumValue.add(Essences, 214, "ARIGEAN", {
		short: "Arig",
		name : "Arigean"
	});
	public static const AE_REINDEER:int            = EnumValue.add(Essences, 215, "REINDEER", {
		short: "RDeer",
		name : "Reindeer"
	});
	public static const AE_PEAFOWL:int         = EnumValue.add(Essences, 216, "PEAFOWL", {
		short: "Peafowl",
		name : "Peafowl"
	});
	public static const AE_MOTH:int         = EnumValue.add(Essences, 217, "MOTH", {
		short: "Moth",
		name : "Moth"
	});
	public static const AE_GLACIAL_TROLL:int           = EnumValue.add(Essences, 218, "GLACIAL_TROLL", {
		short: "GTroll",
		name : "Glacial Troll"
	});
	public static function DEFAULT_ESSENCE_DROP_TABLE(mainEssencee:int, withHuman:Boolean = false):Array {
		var result:Array = [
			[10, mainEssencee],
			[1, AE_GROW],
			[0.75, AE_SHRINK],
			[0.25, AE_REMOVE],
		];
		if (withHuman) result.push([2, AE_HUMAN]);
		return result;
	}
	
	public static function MULTIRACE_ESSENCE_DROP_TABLE(...essenceTypes:/*int*/Array):Array {
		var result:Array = [];
		for each (var et:int in essenceTypes) {
			// allow duplicate types to increase the chances
			// ex. AE_KITSUNE, AE_KITSUNE, AE_FOX, AE_HUMAN
			// => [[5, AE_KITSUNE], [2.5, AE_FOX], [2.5, AE_HUMAN]]
			if (result.length > 0 && result[result.length - 1][1] == et) {
				result[result.length - 1][0] += 10 / essenceTypes.length;
			} else {
				result.push([10 / essenceTypes.length, et]);
			}
		}
		result.push([1, AE_GROW],
				[0.75, AE_SHRINK],
				[0.25, AE_REMOVE]);
		return result;
	}
	
	// Residues (stat changes)
	
	/**
	 * short: button name ("Corr", "Speed")
	 * name: item name ("Corruption", "Speed")
	 * stat: stat id or player property ("cor", "spe")
	 * sign: stat change direction (-1, +1)
	 * feedback: feedback text after "You feel"
	 */
	public static const Residues:/*EnumValue*/Array = [];
	public static const AR_NONE:int                 = EnumValue.add(Residues, 0, "NONE", {
		short: "None",
		name : "None"
	});
	public static const AR_STR:int                  = EnumValue.add(Residues, 1, "STR", {
		short   : "Str",
		name    : "Strength",
		stat    : "str",
		sign    : +1,
		feedback: "stronger"
	});
	public static const AR_TOU:int                  = EnumValue.add(Residues, 2, "TOU", {
		short   : "Tou",
		name    : "Toughness",
		stat    : "tou",
		sign    : +1,
		feedback: "tougher"
	});
	public static const AR_SPE:int                  = EnumValue.add(Residues, 3, "SPE", {
		short   : "Spe",
		name    : "Speed",
		stat    : "spe",
		sign    : +1,
		feedback: "faster"
	});
	public static const AR_INT:int                  = EnumValue.add(Residues, 4, "INT", {
		short   : "Int",
		name    : "Intelligence",
		stat    : "int",
		sign    : +1,
		feedback: "smarter"
	});
	public static const AR_WIS:int                  = EnumValue.add(Residues, 5, "WIS", {
		short   : "Wis",
		name    : "Wisdom",
		stat    : "wis",
		sign    : +1,
		feedback: "wiser"
	});
	public static const AR_LIB:int                  = EnumValue.add(Residues, 6, "LIB", {
		short   : "Lib",
		name    : "Libido",
		stat    : "lib",
		sign    : +1,
		feedback: "more horny"
	});
	public static const AR_SENS_INC:int             = EnumValue.add(Residues, 7, "SENS_INC", {
		short   : "Sens",
		name    : "Sensitivity",
		stat    : "sens",
		sign    : +1,
		feedback: "more sensitive"
	});
	public static const AR_SENS_DEC:int             = EnumValue.add(Residues, 8, "SENS_DEC", {
		short   : "Numb",
		name    : "Numbness",
		stat    : "sens",
		sign    : -1,
		feedback: "numb"
	});
	public static const AR_CORR_INC:int             = EnumValue.add(Residues, 9, "CORR_INC", {
		short   : "Corr",
		name    : "Corruption",
		stat    : "cor",
		sign    : +1,
		feedback: "dirty"
	});
	public static const AR_CORR_DEC:int             = EnumValue.add(Residues, 10, "CORR_DEC", {
		short   : "Puri",
		name    : "Purity",
		stat    : "cor",
		sign    : -1,
		feedback: "cleaner"
	});
	public static const AR_FEM:int                  = EnumValue.add(Residues, 11, "FEM", {
		short   : "Fem",
		name    : "Femininity",
		stat    : "femininity",
		sign    : +1,
		feedback: "more feminine"
	});
	public static const AR_MASC:int                 = EnumValue.add(Residues, 12, "MASC", {
		short   : "Masc",
		name    : "Masculinity",
		stat    : "femininity",
		sign    : -1,
		feedback: "more masculine"
	});
}
}
