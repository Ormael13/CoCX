/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.view.charview {
import classes.AppearanceDefs;

import coc.view.*;
import coc.xlogic.ExecContext;

public class CharViewContext extends ExecContext {
	private var charview:CharView;
	public function CharViewContext(charview:CharView, character:*) {
		super([
			character,
			AppearanceDefs,
			{ // Revamp compatibility layer
				Antennae : Antennae,
				Arms     : Arms,
				Beard    : Beard,
				BreastCup: BreastCup,
				Butt     : Butt,
				Claws    : Claws,
				Ears     : Ears,
				Eyes     : Eyes,
				Face     : Face,
				Gender   : Gender,
				Gills    : Gills,
				Hair     : Hair,
				Hips     : Hips,
				Horns    : Horns,
				LowerBody: LowerBody,
				Neck     : Neck,
				Pattern  : Pattern,
				Piercing : Piercing,
				RearBody : RearBody,
				Skin     : Skin,
				Tail     : Tail,
				Tongue   : Tongue,
				UnderBody: UnderBody,
				Wings    : Wings
			}
		]);
		this.charview = charview;
	}
}
}

import classes.AppearanceDefs;

// Revamp compatibility layer
class Antennae {
	public static const NONE:int   = AppearanceDefs.ANTENNAE_NONE;
	public static const MANTIS:int = AppearanceDefs.ANTENNAE_MANTIS;
	public static const BEE:int    = AppearanceDefs.ANTENNAE_BEE;
}
class Arms {
	public static const HUMAN:int      = AppearanceDefs.ARM_TYPE_HUMAN;
	public static const HARPY:int      = AppearanceDefs.ARM_TYPE_HARPY;
	public static const SPIDER:int     = AppearanceDefs.ARM_TYPE_SPIDER;
	public static const MANTIS:int     = AppearanceDefs.ARM_TYPE_MANTIS;
	public static const BEE:int        = AppearanceDefs.ARM_TYPE_BEE;
	public static const SALAMANDER:int = AppearanceDefs.ARM_TYPE_SALAMANDER;
	public static const PHOENIX:int    = AppearanceDefs.ARM_TYPE_PHOENIX;
	public static const PLANT:int      = AppearanceDefs.ARM_TYPE_PLANT;
	public static const SHARK:int      = AppearanceDefs.ARM_TYPE_SHARK;
	public static const GARGOYLE:int   = AppearanceDefs.ARM_TYPE_GARGOYLE;
	public static const WOLF:int       = AppearanceDefs.ARM_TYPE_WOLF;
	public static const LION:int       = AppearanceDefs.ARM_TYPE_LION;
	public static const KITSUNE:int    = AppearanceDefs.ARM_TYPE_KITSUNE;
	public static const FOX:int        = AppearanceDefs.ARM_TYPE_FOX;
	public static const LIZARD:int     = AppearanceDefs.ARM_TYPE_LIZARD;
	public static const DRAGON:int     = AppearanceDefs.ARM_TYPE_DRAGON;
	public static const YETI:int       = AppearanceDefs.ARM_TYPE_YETI;
	public static const ORCA:int       = AppearanceDefs.ARM_TYPE_ORCA;
	public static const PLANT2:int     = AppearanceDefs.ARM_TYPE_PLANT2;
	public static const DEVIL:int      = AppearanceDefs.ARM_TYPE_DEVIL;
	public static const ONI:int        = AppearanceDefs.ARM_TYPE_ONI;
	public static const ELF:int        = AppearanceDefs.ARM_TYPE_ELF;
	public static const RAIJU:int      = AppearanceDefs.ARM_TYPE_RAIJU;
}
class Beard {
	public static const NORMAL:int      = AppearanceDefs.BEARD_NORMAL;
	public static const GOATEE:int      = AppearanceDefs.BEARD_GOATEE;
	public static const CLEANCUT:int    = AppearanceDefs.BEARD_CLEANCUT;
	public static const MOUNTAINMAN:int = AppearanceDefs.BEARD_MOUNTAINMAN;
}
class BreastCup {
	public static const FLAT:int   = AppearanceDefs.BREAST_CUP_FLAT;
	public static const A:int      = AppearanceDefs.BREAST_CUP_A;
	public static const B:int      = AppearanceDefs.BREAST_CUP_B;
	public static const C:int      = AppearanceDefs.BREAST_CUP_C;
	public static const D:int      = AppearanceDefs.BREAST_CUP_D;
	public static const DD:int     = AppearanceDefs.BREAST_CUP_DD;
	public static const DD_BIG:int = AppearanceDefs.BREAST_CUP_DD_BIG;
	public static const E:int      = AppearanceDefs.BREAST_CUP_E;
	public static const E_BIG:int  = AppearanceDefs.BREAST_CUP_E_BIG;
	public static const EE:int     = AppearanceDefs.BREAST_CUP_EE;
	public static const EE_BIG:int = AppearanceDefs.BREAST_CUP_EE_BIG;
	public static const F:int      = AppearanceDefs.BREAST_CUP_F;
	public static const F_BIG:int  = AppearanceDefs.BREAST_CUP_F_BIG;
	public static const FF:int     = AppearanceDefs.BREAST_CUP_FF;
	public static const FF_BIG:int = AppearanceDefs.BREAST_CUP_FF_BIG;
	public static const G:int      = AppearanceDefs.BREAST_CUP_G;
}
class Butt {
	public static const RATING_BUTTLESS:int          = AppearanceDefs.BUTT_RATING_BUTTLESS;
	public static const RATING_TIGHT:int             = AppearanceDefs.BUTT_RATING_TIGHT;
	public static const RATING_AVERAGE:int           = AppearanceDefs.BUTT_RATING_AVERAGE;
	public static const RATING_NOTICEABLE:int        = AppearanceDefs.BUTT_RATING_NOTICEABLE;
	public static const RATING_LARGE:int             = AppearanceDefs.BUTT_RATING_LARGE;
	public static const RATING_JIGGLY:int            = AppearanceDefs.BUTT_RATING_JIGGLY;
	public static const RATING_EXPANSIVE:int         = AppearanceDefs.BUTT_RATING_EXPANSIVE;
	public static const RATING_HUGE:int              = AppearanceDefs.BUTT_RATING_HUGE;
	public static const RATING_INCONCEIVABLY_BIG:int = AppearanceDefs.BUTT_RATING_INCONCEIVABLY_BIG;
}
class Claws {
	public static const NORMAL:int     = AppearanceDefs.CLAW_TYPE_NORMAL;
	public static const LIZARD:int     = AppearanceDefs.CLAW_TYPE_LIZARD;
	public static const DRAGON:int     = AppearanceDefs.CLAW_TYPE_DRAGON;
	public static const SALAMANDER:int = AppearanceDefs.CLAW_TYPE_SALAMANDER;
	public static const CAT:int        = AppearanceDefs.CLAW_TYPE_CAT;
	public static const DOG:int        = AppearanceDefs.CLAW_TYPE_DOG;
	public static const RAPTOR:int     = AppearanceDefs.CLAW_TYPE_RAPTOR;
	public static const MANTIS:int     = AppearanceDefs.CLAW_TYPE_MANTIS;
}
class Ears {
	public static const HUMAN:int    = AppearanceDefs.EARS_HUMAN;
	public static const HORSE:int    = AppearanceDefs.EARS_HORSE;
	public static const DOG:int      = AppearanceDefs.EARS_DOG;
	public static const COW:int      = AppearanceDefs.EARS_COW;
	public static const ELFIN:int    = AppearanceDefs.EARS_ELFIN;
	public static const CAT:int      = AppearanceDefs.EARS_CAT;
	public static const LIZARD:int   = AppearanceDefs.EARS_LIZARD;
	public static const BUNNY:int    = AppearanceDefs.EARS_BUNNY;
	public static const KANGAROO:int = AppearanceDefs.EARS_KANGAROO;
	public static const FOX:int      = AppearanceDefs.EARS_FOX;
	public static const DRAGON:int   = AppearanceDefs.EARS_DRAGON;
	public static const RACCOON:int  = AppearanceDefs.EARS_RACCOON;
	public static const MOUSE:int    = AppearanceDefs.EARS_MOUSE;
	public static const FERRET:int   = AppearanceDefs.EARS_FERRET;
	public static const PIG:int      = AppearanceDefs.EARS_PIG;
	public static const RHINO:int    = AppearanceDefs.EARS_RHINO;
	public static const ECHIDNA:int  = AppearanceDefs.EARS_ECHIDNA;
	public static const DEER:int     = AppearanceDefs.EARS_DEER;
	public static const WOLF:int     = AppearanceDefs.EARS_WOLF;
	public static const LION:int     = AppearanceDefs.EARS_LION;
	public static const YETI:int     = AppearanceDefs.EARS_YETI;
	public static const ORCA:int     = AppearanceDefs.EARS_ORCA;
	public static const SNAKE:int    = AppearanceDefs.EARS_SNAKE;
	public static const GOAT:int     = AppearanceDefs.EARS_GOAT;
	public static const ONI:int      = AppearanceDefs.EARS_ONI;
	public static const ELVEN:int    = AppearanceDefs.EARS_ELVEN;
	public static const WEASEL:int   = AppearanceDefs.EARS_WEASEL;
	public static const BAT:int      = AppearanceDefs.EARS_BAT;
	public static const VAMPIRE:int  = AppearanceDefs.EARS_VAMPIRE;
}
class Eyes {
	public static const HUMAN:int                = AppearanceDefs.EYES_HUMAN;
	public static const FOUR_SPIDER_EYES:int     = AppearanceDefs.EYES_FOUR_SPIDER_EYES;
	public static const BLACK_EYES_SAND_TRAP:int = AppearanceDefs.EYES_BLACK_EYES_SAND_TRAP;
	public static const CAT_SLITS:int            = AppearanceDefs.EYES_CAT_SLITS;
	public static const GORGON:int               = AppearanceDefs.EYES_GORGON;
	public static const FENRIR:int               = AppearanceDefs.EYES_FENRIR;
	public static const MANTICORE:int            = AppearanceDefs.EYES_MANTICORE;
	public static const FOX:int                  = AppearanceDefs.EYES_FOX;
	public static const REPTILIAN:int            = AppearanceDefs.EYES_REPTILIAN;
	public static const SNAKE:int                = AppearanceDefs.EYES_SNAKE;
	public static const DRAGON:int               = AppearanceDefs.EYES_DRAGON;
	public static const DEVIL:int                = AppearanceDefs.EYES_DEVIL;
	public static const ONI:int                  = AppearanceDefs.EYES_ONI;
	public static const ELF:int                  = AppearanceDefs.EYES_ELF;
	public static const RAIJU:int                = AppearanceDefs.EYES_RAIJU;
	public static const VAMPIRE:int              = AppearanceDefs.EYES_VAMPIRE;
}
class Face {
	public static const HUMAN:int            = AppearanceDefs.FACE_HUMAN;
	public static const HORSE:int            = AppearanceDefs.FACE_HORSE;
	public static const DOG:int              = AppearanceDefs.FACE_DOG;
	public static const COW_MINOTAUR:int     = AppearanceDefs.FACE_COW_MINOTAUR;
	public static const SHARK_TEETH:int      = AppearanceDefs.FACE_SHARK_TEETH;
	public static const SNAKE_FANGS:int      = AppearanceDefs.FACE_SNAKE_FANGS;
	public static const CAT:int              = AppearanceDefs.FACE_CAT;
	public static const LIZARD:int           = AppearanceDefs.FACE_LIZARD;
	public static const BUNNY:int            = AppearanceDefs.FACE_BUNNY;
	public static const KANGAROO:int         = AppearanceDefs.FACE_KANGAROO;
	public static const SPIDER_FANGS:int     = AppearanceDefs.FACE_SPIDER_FANGS;
	public static const FOX:int              = AppearanceDefs.FACE_FOX;
	public static const DRAGON:int           = AppearanceDefs.FACE_DRAGON;
	public static const RACCOON_MASK:int     = AppearanceDefs.FACE_RACCOON_MASK;
	public static const RACCOON:int          = AppearanceDefs.FACE_RACCOON;
	public static const BUCKTEETH:int        = AppearanceDefs.FACE_BUCKTEETH;
	public static const MOUSE:int            = AppearanceDefs.FACE_MOUSE;
	public static const FERRET_MASK:int      = AppearanceDefs.FACE_FERRET_MASK;
	public static const FERRET:int           = AppearanceDefs.FACE_FERRET;
	public static const PIG:int              = AppearanceDefs.FACE_PIG;
	public static const BOAR:int             = AppearanceDefs.FACE_BOAR;
	public static const RHINO:int            = AppearanceDefs.FACE_RHINO;
	public static const ECHIDNA:int          = AppearanceDefs.FACE_ECHIDNA;
	public static const DEER:int             = AppearanceDefs.FACE_DEER;
	public static const WOLF:int             = AppearanceDefs.FACE_WOLF;
	public static const MANTICORE:int        = AppearanceDefs.FACE_MANTICORE;
	public static const SALAMANDER_FANGS:int = AppearanceDefs.FACE_SALAMANDER_FANGS;
	public static const YETI_FANGS:int       = AppearanceDefs.FACE_YETI_FANGS;
	public static const ORCA:int             = AppearanceDefs.FACE_ORCA;
	public static const PLANT_DRAGON:int     = AppearanceDefs.FACE_PLANT_DRAGON;
	public static const DRAGON_FANGS:int     = AppearanceDefs.FACE_DRAGON_FANGS;
	public static const DEVIL_FANGS:int      = AppearanceDefs.FACE_DEVIL_FANGS;
	public static const ONI_TEETH:int        = AppearanceDefs.FACE_ONI_TEETH;
	public static const RAIJU_FANGS:int      = AppearanceDefs.FACE_RAIJU_FANGS;
	public static const VAMPIRE:int          = AppearanceDefs.FACE_VAMPIRE;
}
class Gender {
	public static const NONE:int   = AppearanceDefs.GENDER_NONE;
	public static const MALE:int   = AppearanceDefs.GENDER_MALE;
	public static const FEMALE:int = AppearanceDefs.GENDER_FEMALE;
	public static const HERM:int   = AppearanceDefs.GENDER_HERM;
}
class Gills {
	public static const NONE:int             = AppearanceDefs.GILLS_NONE;
	public static const ANEMONE:int          = AppearanceDefs.GILLS_ANEMONE;
	public static const FISH:int             = AppearanceDefs.GILLS_FISH;
	public static const IN_TENTACLE_LEGS:int = AppearanceDefs.GILLS_IN_TENTACLE_LEGS;
}
class Hair {
	public static const NORMAL:int  = AppearanceDefs.HAIR_NORMAL;
	public static const FEATHER:int = AppearanceDefs.HAIR_FEATHER;
	public static const GHOST:int   = AppearanceDefs.HAIR_GHOST;
	public static const GOO:int     = AppearanceDefs.HAIR_GOO;
	public static const ANEMONE:int = AppearanceDefs.HAIR_ANEMONE;
	public static const QUILL:int   = AppearanceDefs.HAIR_QUILL;
	public static const GORGON:int  = AppearanceDefs.HAIR_GORGON;
	public static const LEAF:int    = AppearanceDefs.HAIR_LEAF;
	public static const FLUFFY:int  = AppearanceDefs.HAIR_FLUFFY;
	public static const GRASS:int   = AppearanceDefs.HAIR_GRASS;
	public static const SILKEN:int  = AppearanceDefs.HAIR_SILKEN;
	public static const STORM:int   = AppearanceDefs.HAIR_STORM;
}
class Hips {
	public static const RATING_BOYISH:int         = AppearanceDefs.HIP_RATING_BOYISH;
	public static const RATING_SLENDER:int        = AppearanceDefs.HIP_RATING_SLENDER;
	public static const RATING_AVERAGE:int        = AppearanceDefs.HIP_RATING_AVERAGE;
	public static const RATING_AMPLE:int          = AppearanceDefs.HIP_RATING_AMPLE;
	public static const RATING_CURVY:int          = AppearanceDefs.HIP_RATING_CURVY;
	public static const RATING_FERTILE:int        = AppearanceDefs.HIP_RATING_FERTILE;
	public static const RATING_INHUMANLY_WIDE:int = AppearanceDefs.HIP_RATING_INHUMANLY_WIDE;
}
class Horns {
	public static const NONE:int                     = AppearanceDefs.HORNS_NONE;
	public static const DEMON:int                    = AppearanceDefs.HORNS_DEMON;
	public static const COW_MINOTAUR:int             = AppearanceDefs.HORNS_COW_MINOTAUR;
	public static const DRACONIC_X2:int              = AppearanceDefs.HORNS_DRACONIC_X2;
	public static const DRACONIC_X4_12_INCH_LONG:int = AppearanceDefs.HORNS_DRACONIC_X4_12_INCH_LONG;
	public static const ANTLERS:int                  = AppearanceDefs.HORNS_ANTLERS;
	public static const GOAT:int                     = AppearanceDefs.HORNS_GOAT;
	public static const UNICORN:int                  = AppearanceDefs.HORNS_UNICORN;
	public static const RHINO:int                    = AppearanceDefs.HORNS_RHINO;
	public static const OAK:int                      = AppearanceDefs.HORNS_OAK;
	public static const GARGOYLE:int                 = AppearanceDefs.HORNS_GARGOYLE;
	public static const ORCHID:int                   = AppearanceDefs.HORNS_ORCHID;
	public static const ONI_X2:int                   = AppearanceDefs.HORNS_ONI_X2;
	public static const ONI:int                      = AppearanceDefs.HORNS_ONI;
}
class LowerBody {
	public static const HUMAN:int                 = AppearanceDefs.LOWER_BODY_TYPE_HUMAN;
	public static const HOOFED:int                = AppearanceDefs.LOWER_BODY_TYPE_HOOFED;
	public static const DOG:int                   = AppearanceDefs.LOWER_BODY_TYPE_DOG;
	public static const NAGA:int                  = AppearanceDefs.LOWER_BODY_TYPE_NAGA;
	public static const DEMONIC_HIGH_HEELS:int    = AppearanceDefs.LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;
	public static const DEMONIC_CLAWS:int         = AppearanceDefs.LOWER_BODY_TYPE_DEMONIC_CLAWS;
	public static const BEE:int                   = AppearanceDefs.LOWER_BODY_TYPE_BEE;
	public static const GOO:int                   = AppearanceDefs.LOWER_BODY_TYPE_GOO;
	public static const CAT:int                   = AppearanceDefs.LOWER_BODY_TYPE_CAT;
	public static const LIZARD:int                = AppearanceDefs.LOWER_BODY_TYPE_LIZARD;
	public static const PONY:int                  = AppearanceDefs.LOWER_BODY_TYPE_PONY;
	public static const BUNNY:int                 = AppearanceDefs.LOWER_BODY_TYPE_BUNNY;
	public static const HARPY:int                 = AppearanceDefs.LOWER_BODY_TYPE_HARPY;
	public static const KANGAROO:int              = AppearanceDefs.LOWER_BODY_TYPE_KANGAROO;
	public static const CHITINOUS_SPIDER_LEGS:int = AppearanceDefs.LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS;
	public static const DRIDER_LOWER_BODY:int     = AppearanceDefs.LOWER_BODY_TYPE_DRIDER_LOWER_BODY;
	public static const FOX:int                   = AppearanceDefs.LOWER_BODY_TYPE_FOX;
	public static const DRAGON:int                = AppearanceDefs.LOWER_BODY_TYPE_DRAGON;
	public static const RACCOON:int               = AppearanceDefs.LOWER_BODY_TYPE_RACCOON;
	public static const FERRET:int                = AppearanceDefs.LOWER_BODY_TYPE_FERRET;
	public static const CLOVEN_HOOFED:int         = AppearanceDefs.LOWER_BODY_TYPE_CLOVEN_HOOFED;
	public static const ECHIDNA:int               = AppearanceDefs.LOWER_BODY_TYPE_ECHIDNA;
	public static const SALAMANDER:int            = AppearanceDefs.LOWER_BODY_TYPE_SALAMANDER;
	public static const SCYLLA:int                = AppearanceDefs.LOWER_BODY_TYPE_SCYLLA;
	public static const MANTIS:int                = AppearanceDefs.LOWER_BODY_TYPE_MANTIS;
	public static const SHARK:int                 = AppearanceDefs.LOWER_BODY_TYPE_SHARK;
	public static const GARGOYLE:int              = AppearanceDefs.LOWER_BODY_TYPE_GARGOYLE;
	public static const PLANT_HIGH_HEELS:int      = AppearanceDefs.LOWER_BODY_TYPE_PLANT_HIGH_HEELS;
	public static const PLANT_ROOT_CLAWS:int      = AppearanceDefs.LOWER_BODY_TYPE_PLANT_ROOT_CLAWS;
	public static const WOLF:int                  = AppearanceDefs.LOWER_BODY_TYPE_WOLF;
	public static const PLANT_FLOWER:int          = AppearanceDefs.LOWER_BODY_TYPE_PLANT_FLOWER;
	public static const LION:int                  = AppearanceDefs.LOWER_BODY_TYPE_LION;
	public static const YETI:int                  = AppearanceDefs.LOWER_BODY_TYPE_YETI;
	public static const ORCA:int                  = AppearanceDefs.LOWER_BODY_TYPE_ORCA;
	public static const YGG_ROOT_CLAWS:int        = AppearanceDefs.LOWER_BODY_TYPE_YGG_ROOT_CLAWS;
	public static const ONI:int                   = AppearanceDefs.LOWER_BODY_TYPE_ONI;
	public static const ELF:int                   = AppearanceDefs.LOWER_BODY_TYPE_ELF;
	public static const RAIJU:int                 = AppearanceDefs.LOWER_BODY_TYPE_RAIJU;
}
class Neck {

}
class Pattern {
	public static const NONE:int                    = AppearanceDefs.PATTERN_NONE;
	public static const MAGICAL_TATTOO:int          = AppearanceDefs.PATTERN_MAGICAL_TATTOO;
	public static const ORCA_UNDERBODY:int          = AppearanceDefs.PATTERN_ORCA_UNDERBODY;
	public static const BEE_STRIPES:int             = AppearanceDefs.PATTERN_BEE_STRIPES;
	public static const TIGER_STRIPES:int           = AppearanceDefs.PATTERN_TIGER_STRIPES;
	public static const BATTLE_TATTOO:int           = AppearanceDefs.PATTERN_BATTLE_TATTOO;
	public static const SPOTTED:int                 = AppearanceDefs.PATTERN_SPOTTED;
	public static const LIGHTNING_SHAPED_TATTOO:int = AppearanceDefs.PATTERN_LIGHTNING_SHAPED_TATTOO;
}
class Piercing {
	public static const NONE:int   = AppearanceDefs.PIERCING_TYPE_NONE;
	public static const STUD:int   = AppearanceDefs.PIERCING_TYPE_STUD;
	public static const RING:int   = AppearanceDefs.PIERCING_TYPE_RING;
	public static const LADDER:int = AppearanceDefs.PIERCING_TYPE_LADDER;
	public static const HOOP:int   = AppearanceDefs.PIERCING_TYPE_HOOP;
	public static const CHAIN:int  = AppearanceDefs.PIERCING_TYPE_CHAIN;
}
class RearBody {
	public static const NONE:int              = AppearanceDefs.REAR_BODY_NONE;
	public static const DRACONIC_MANE:int     = AppearanceDefs.REAR_BODY_DRACONIC_MANE;
	public static const DRACONIC_SPIKES:int   = AppearanceDefs.REAR_BODY_DRACONIC_SPIKES;
	public static const FENRIR_ICE_SPIKES:int = AppearanceDefs.REAR_BODY_FENRIR_ICE_SPIKES;
	public static const LION_MANE:int         = AppearanceDefs.REAR_BODY_LION_MANE;
	public static const BEHEMOTH:int          = AppearanceDefs.REAR_BODY_BEHEMOTH;
	public static const SHARK_FIN:int         = AppearanceDefs.REAR_BODY_SHARK_FIN;
	public static const ORCA_BLOWHOLE:int     = AppearanceDefs.REAR_BODY_ORCA_BLOWHOLE;
	public static const RAIJU_MANE:int        = AppearanceDefs.REAR_BODY_RAIJU_MANE;
	public static const BAT_COLLAR:int        = AppearanceDefs.REAR_BODY_BAT_COLLAR;
}
class Skin {
	public static const COVERAGE_NONE:int         = 0;
	public static const COVERAGE_LOW:int          = 1;
	public static const COVERAGE_MEDIUM:int       = 2;
	public static const COVERAGE_HIGH:int         = 3;
	public static const COVERAGE_COMPLETE:int     = 4;
	public static const PLAIN:int                 = AppearanceDefs.SKIN_TYPE_PLAIN;
	public static const FUR:int                   = AppearanceDefs.SKIN_TYPE_FUR;
	public static const SCALES:int                = AppearanceDefs.SKIN_TYPE_SCALES;
	public static const GOO:int                   = AppearanceDefs.SKIN_TYPE_GOO;
	public static const CHITIN:int                = AppearanceDefs.SKIN_TYPE_CHITIN;
	public static const BARK:int                  = AppearanceDefs.SKIN_TYPE_BARK;
	public static const STONE:int                 = AppearanceDefs.SKIN_TYPE_STONE;
	public static const TATTOED:int               = AppearanceDefs.SKIN_TYPE_TATTOED;
	public static const AQUA_SCALES:int           = AppearanceDefs.SKIN_TYPE_AQUA_SCALES;
	public static const DRAGON_SCALES:int         = AppearanceDefs.SKIN_TYPE_DRAGON_SCALES;
	public static const MOSS:int                  = AppearanceDefs.SKIN_TYPE_MOSS;
	public static const AQUA_RUBBER_LIKE:int      = AppearanceDefs.SKIN_TYPE_AQUA_RUBBER_LIKE;
}
class Tail {
	public static const NONE:int                = AppearanceDefs.TAIL_TYPE_NONE;
	public static const HORSE:int               = AppearanceDefs.TAIL_TYPE_HORSE;
	public static const DOG:int                 = AppearanceDefs.TAIL_TYPE_DOG;
	public static const DEMONIC:int             = AppearanceDefs.TAIL_TYPE_DEMONIC;
	public static const COW:int                 = AppearanceDefs.TAIL_TYPE_COW;
	public static const SPIDER_ADBOMEN:int      = AppearanceDefs.TAIL_TYPE_SPIDER_ADBOMEN;
	public static const BEE_ABDOMEN:int         = AppearanceDefs.TAIL_TYPE_BEE_ABDOMEN;
	public static const SHARK:int               = AppearanceDefs.TAIL_TYPE_SHARK;
	public static const CAT:int                 = AppearanceDefs.TAIL_TYPE_CAT;
	public static const LIZARD:int              = AppearanceDefs.TAIL_TYPE_LIZARD;
	public static const RABBIT:int              = AppearanceDefs.TAIL_TYPE_RABBIT;
	public static const HARPY:int               = AppearanceDefs.TAIL_TYPE_HARPY;
	public static const KANGAROO:int            = AppearanceDefs.TAIL_TYPE_KANGAROO;
	public static const FOX:int                 = AppearanceDefs.TAIL_TYPE_FOX;
	public static const DRACONIC:int            = AppearanceDefs.TAIL_TYPE_DRACONIC;
	public static const RACCOON:int             = AppearanceDefs.TAIL_TYPE_RACCOON;
	public static const MOUSE:int               = AppearanceDefs.TAIL_TYPE_MOUSE;
	public static const FERRET:int              = AppearanceDefs.TAIL_TYPE_FERRET;
	public static const BEHEMOTH:int            = AppearanceDefs.TAIL_TYPE_BEHEMOTH;
	public static const PIG:int                 = AppearanceDefs.TAIL_TYPE_PIG;
	public static const SCORPION:int            = AppearanceDefs.TAIL_TYPE_SCORPION;
	public static const GOAT:int                = AppearanceDefs.TAIL_TYPE_GOAT;
	public static const RHINO:int               = AppearanceDefs.TAIL_TYPE_RHINO;
	public static const ECHIDNA:int             = AppearanceDefs.TAIL_TYPE_ECHIDNA;
	public static const DEER:int                = AppearanceDefs.TAIL_TYPE_DEER;
	public static const SALAMANDER:int          = AppearanceDefs.TAIL_TYPE_SALAMANDER;
	public static const KITSHOO:int             = AppearanceDefs.TAIL_TYPE_KITSHOO;
	public static const MANTIS_ABDOMEN:int      = AppearanceDefs.TAIL_TYPE_MANTIS_ABDOMEN;
	public static const MANTICORE_PUSSYTAIL:int = AppearanceDefs.TAIL_TYPE_MANTICORE_PUSSYTAIL;
	public static const WOLF:int                = AppearanceDefs.TAIL_TYPE_WOLF;
	public static const GARGOYLE:int            = AppearanceDefs.TAIL_TYPE_GARGOYLE;
	public static const ORCA:int                = AppearanceDefs.TAIL_TYPE_ORCA;
	public static const YGGDRASIL:int           = AppearanceDefs.TAIL_TYPE_YGGDRASIL;
	public static const RAIJU:int               = AppearanceDefs.TAIL_TYPE_RAIJU;
}
class Tongue {
	public static const HUMAN:int    = AppearanceDefs.TONGUE_HUMAN;
	public static const SNAKE:int    = AppearanceDefs.TONGUE_SNAKE;
	public static const DEMONIC:int  = AppearanceDefs.TONGUE_DEMONIC;
	public static const DRACONIC:int = AppearanceDefs.TONGUE_DRACONIC;
	public static const ECHIDNA:int  = AppearanceDefs.TONGUE_ECHIDNA;
	public static const CAT:int      = AppearanceDefs.TONGUE_CAT;
	public static const ELF:int      = AppearanceDefs.TONGUE_ELF;
}
class UnderBody {

}
class Wings {
	public static const NONE:int                 = AppearanceDefs.WING_TYPE_NONE;
	public static const BEE_LIKE_SMALL:int       = AppearanceDefs.WING_TYPE_BEE_LIKE_SMALL;
	public static const BEE_LIKE_LARGE:int       = AppearanceDefs.WING_TYPE_BEE_LIKE_LARGE;
	public static const HARPY:int                = AppearanceDefs.WING_TYPE_HARPY;
	public static const IMP:int                  = AppearanceDefs.WING_TYPE_IMP;
	public static const BAT_LIKE_TINY:int        = AppearanceDefs.WING_TYPE_BAT_LIKE_TINY;
	public static const BAT_LIKE_LARGE:int       = AppearanceDefs.WING_TYPE_BAT_LIKE_LARGE;
	public static const SHARK_FIN:int            = AppearanceDefs.WING_TYPE_SHARK_FIN;
	public static const FEATHERED_LARGE:int      = AppearanceDefs.WING_TYPE_FEATHERED_LARGE;
	public static const DRACONIC_SMALL:int       = AppearanceDefs.WING_TYPE_DRACONIC_SMALL;
	public static const DRACONIC_LARGE:int       = AppearanceDefs.WING_TYPE_DRACONIC_LARGE;
	public static const GIANT_DRAGONFLY:int      = AppearanceDefs.WING_TYPE_GIANT_DRAGONFLY;
	public static const BAT_LIKE_LARGE_2:int     = AppearanceDefs.WING_TYPE_BAT_LIKE_LARGE_2;
	public static const DRACONIC_HUGE:int        = AppearanceDefs.WING_TYPE_DRACONIC_HUGE;
	public static const FEATHERED_PHOENIX:int    = AppearanceDefs.WING_TYPE_FEATHERED_PHOENIX;
	public static const FEATHERED_ALICORN:int    = AppearanceDefs.WING_TYPE_FEATHERED_ALICORN;
	public static const MANTIS_LIKE_SMALL:int    = AppearanceDefs.WING_TYPE_MANTIS_LIKE_SMALL;
	public static const MANTIS_LIKE_LARGE:int    = AppearanceDefs.WING_TYPE_MANTIS_LIKE_LARGE;
	public static const MANTIS_LIKE_LARGE_2:int  = AppearanceDefs.WING_TYPE_MANTIS_LIKE_LARGE_2;
	public static const GARGOYLE_LIKE_LARGE:int  = AppearanceDefs.WING_TYPE_GARGOYLE_LIKE_LARGE;
	public static const PLANT:int                = AppearanceDefs.WING_TYPE_PLANT;
	public static const MANTICORE_LIKE_SMALL:int = AppearanceDefs.WING_TYPE_MANTICORE_LIKE_SMALL;
	public static const MANTICORE_LIKE_LARGE:int = AppearanceDefs.WING_TYPE_MANTICORE_LIKE_LARGE;
	public static const BAT_ARM:int              = AppearanceDefs.WING_TYPE_BAT_ARM;
	public static const VAMPIRE:int              = AppearanceDefs.WING_TYPE_VAMPIRE;
}
