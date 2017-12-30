/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.view.charview {
import classes.AppearanceDefs;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Beard;
import classes.BodyParts.Butt;
import classes.BodyParts.Claws;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Piercing;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.lists.BreastCup;
import classes.lists.Gender;

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

// Revamp compatibility layer
class Antennae {
	public static const NONE:int   = classes.BodyParts.Antennae.NONE;
	public static const MANTIS:int = classes.BodyParts.Antennae.MANTIS;
	public static const BEE:int    = classes.BodyParts.Antennae.BEE;
}
class Arms {
	public static const HUMAN:int      = classes.BodyParts.Arms.HUMAN;
	public static const HARPY:int      = classes.BodyParts.Arms.HARPY;
	public static const SPIDER:int     = classes.BodyParts.Arms.SPIDER;
	public static const MANTIS:int     = classes.BodyParts.Arms.MANTIS;
	public static const BEE:int        = classes.BodyParts.Arms.BEE;
	public static const SALAMANDER:int = classes.BodyParts.Arms.SALAMANDER;
	public static const PHOENIX:int    = classes.BodyParts.Arms.PHOENIX;
	public static const PLANT:int      = classes.BodyParts.Arms.PLANT;
	public static const SHARK:int      = classes.BodyParts.Arms.SHARK;
	public static const GARGOYLE:int   = classes.BodyParts.Arms.GARGOYLE;
	public static const WOLF:int       = classes.BodyParts.Arms.WOLF;
	public static const LION:int       = classes.BodyParts.Arms.LION;
	public static const KITSUNE:int    = classes.BodyParts.Arms.KITSUNE;
	public static const FOX:int        = classes.BodyParts.Arms.FOX;
	public static const LIZARD:int     = classes.BodyParts.Arms.LIZARD;
	public static const DRAGON:int     = classes.BodyParts.Arms.DRAGON;
	public static const YETI:int       = classes.BodyParts.Arms.YETI;
	public static const ORCA:int       = classes.BodyParts.Arms.ORCA;
	public static const PLANT2:int     = classes.BodyParts.Arms.PLANT2;
	public static const DEVIL:int      = classes.BodyParts.Arms.DEVIL;
	public static const ONI:int        = classes.BodyParts.Arms.ONI;
	public static const ELF:int        = classes.BodyParts.Arms.ELF;
	public static const RAIJU:int      = classes.BodyParts.Arms.RAIJU;
}
class Beard {
	public static const NORMAL:int      = classes.BodyParts.Beard.NORMAL;
	public static const GOATEE:int      = classes.BodyParts.Beard.GOATEE;
	public static const CLEANCUT:int    = classes.BodyParts.Beard.CLEANCUT;
	public static const MOUNTAINMAN:int = classes.BodyParts.Beard.MOUNTAINMAN;
}
class BreastCup {
	public static const FLAT:int   = classes.lists.BreastCup.FLAT;
	public static const A:int      = classes.lists.BreastCup.A;
	public static const B:int      = classes.lists.BreastCup.B;
	public static const C:int      = classes.lists.BreastCup.C;
	public static const D:int      = classes.lists.BreastCup.D;
	public static const DD:int     = classes.lists.BreastCup.DD;
	public static const DD_BIG:int = classes.lists.BreastCup.DD_BIG;
	public static const E:int      = classes.lists.BreastCup.E;
	public static const E_BIG:int  = classes.lists.BreastCup.E_BIG;
	public static const EE:int     = classes.lists.BreastCup.EE;
	public static const EE_BIG:int = classes.lists.BreastCup.EE_BIG;
	public static const F:int      = classes.lists.BreastCup.F;
	public static const F_BIG:int  = classes.lists.BreastCup.F_BIG;
	public static const FF:int     = classes.lists.BreastCup.FF;
	public static const FF_BIG:int = classes.lists.BreastCup.FF_BIG;
	public static const G:int      = classes.lists.BreastCup.G;
}
class Butt {
	public static const RATING_BUTTLESS:int          = classes.BodyParts.Butt.RATING_BUTTLESS;
	public static const RATING_TIGHT:int             = classes.BodyParts.Butt.RATING_TIGHT;
	public static const RATING_AVERAGE:int           = classes.BodyParts.Butt.RATING_AVERAGE;
	public static const RATING_NOTICEABLE:int        = classes.BodyParts.Butt.RATING_NOTICEABLE;
	public static const RATING_LARGE:int             = classes.BodyParts.Butt.RATING_LARGE;
	public static const RATING_JIGGLY:int            = classes.BodyParts.Butt.RATING_JIGGLY;
	public static const RATING_EXPANSIVE:int         = classes.BodyParts.Butt.RATING_EXPANSIVE;
	public static const RATING_HUGE:int              = classes.BodyParts.Butt.RATING_HUGE;
	public static const RATING_INCONCEIVABLY_BIG:int = classes.BodyParts.Butt.RATING_INCONCEIVABLY_BIG;
}
class Claws {
	public static const NORMAL:int     = classes.BodyParts.Claws.NORMAL;
	public static const LIZARD:int     = classes.BodyParts.Claws.LIZARD;
	public static const DRAGON:int     = classes.BodyParts.Claws.DRAGON;
	public static const SALAMANDER:int = classes.BodyParts.Claws.SALAMANDER;
	public static const CAT:int        = classes.BodyParts.Claws.CAT;
	public static const DOG:int        = classes.BodyParts.Claws.DOG;
	public static const RAPTOR:int     = classes.BodyParts.Claws.RAPTOR;
	public static const MANTIS:int     = classes.BodyParts.Claws.MANTIS;
}
class Ears {
	public static const HUMAN:int    = classes.BodyParts.Ears.HUMAN;
	public static const HORSE:int    = classes.BodyParts.Ears.HORSE;
	public static const DOG:int      = classes.BodyParts.Ears.DOG;
	public static const COW:int      = classes.BodyParts.Ears.COW;
	public static const ELFIN:int    = classes.BodyParts.Ears.ELFIN;
	public static const CAT:int      = classes.BodyParts.Ears.CAT;
	public static const LIZARD:int   = classes.BodyParts.Ears.LIZARD;
	public static const BUNNY:int    = classes.BodyParts.Ears.BUNNY;
	public static const KANGAROO:int = classes.BodyParts.Ears.KANGAROO;
	public static const FOX:int      = classes.BodyParts.Ears.FOX;
	public static const DRAGON:int   = classes.BodyParts.Ears.DRAGON;
	public static const RACCOON:int  = classes.BodyParts.Ears.RACCOON;
	public static const MOUSE:int    = classes.BodyParts.Ears.MOUSE;
	public static const FERRET:int   = classes.BodyParts.Ears.FERRET;
	public static const PIG:int      = classes.BodyParts.Ears.PIG;
	public static const RHINO:int    = classes.BodyParts.Ears.RHINO;
	public static const ECHIDNA:int  = classes.BodyParts.Ears.ECHIDNA;
	public static const DEER:int     = classes.BodyParts.Ears.DEER;
	public static const WOLF:int     = classes.BodyParts.Ears.WOLF;
	public static const LION:int     = classes.BodyParts.Ears.LION;
	public static const YETI:int     = classes.BodyParts.Ears.YETI;
	public static const ORCA:int     = classes.BodyParts.Ears.ORCA;
	public static const SNAKE:int    = classes.BodyParts.Ears.SNAKE;
	public static const GOAT:int     = classes.BodyParts.Ears.GOAT;
	public static const ONI:int      = classes.BodyParts.Ears.ONI;
	public static const ELVEN:int    = classes.BodyParts.Ears.ELVEN;
	public static const WEASEL:int   = classes.BodyParts.Ears.WEASEL;
	public static const BAT:int      = classes.BodyParts.Ears.BAT;
	public static const VAMPIRE:int  = classes.BodyParts.Ears.VAMPIRE;
}
class Eyes {
	public static const HUMAN:int                = classes.BodyParts.Eyes.EYES_HUMAN;
	public static const FOUR_SPIDER_EYES:int     = classes.BodyParts.Eyes.EYES_FOUR_SPIDER_EYES;
	public static const BLACK_EYES_SAND_TRAP:int = classes.BodyParts.Eyes.EYES_BLACK_EYES_SAND_TRAP;
	public static const CAT_SLITS:int            = classes.BodyParts.Eyes.EYES_CAT_SLITS;
	public static const GORGON:int               = classes.BodyParts.Eyes.EYES_GORGON;
	public static const FENRIR:int               = classes.BodyParts.Eyes.EYES_FENRIR;
	public static const MANTICORE:int            = classes.BodyParts.Eyes.EYES_MANTICORE;
	public static const FOX:int                  = classes.BodyParts.Eyes.EYES_FOX;
	public static const REPTILIAN:int            = classes.BodyParts.Eyes.EYES_REPTILIAN;
	public static const SNAKE:int                = classes.BodyParts.Eyes.EYES_SNAKE;
	public static const DRAGON:int               = classes.BodyParts.Eyes.EYES_DRAGON;
	public static const DEVIL:int                = classes.BodyParts.Eyes.EYES_DEVIL;
	public static const ONI:int                  = classes.BodyParts.Eyes.EYES_ONI;
	public static const ELF:int                  = classes.BodyParts.Eyes.EYES_ELF;
	public static const RAIJU:int                = classes.BodyParts.Eyes.EYES_RAIJU;
	public static const VAMPIRE:int              = classes.BodyParts.Eyes.EYES_VAMPIRE;
}
class Face {
	public static const HUMAN:int            = classes.BodyParts.Face.HUMAN;
	public static const HORSE:int            = classes.BodyParts.Face.HORSE;
	public static const DOG:int              = classes.BodyParts.Face.DOG;
	public static const COW_MINOTAUR:int     = classes.BodyParts.Face.COW_MINOTAUR;
	public static const SHARK_TEETH:int      = classes.BodyParts.Face.SHARK_TEETH;
	public static const SNAKE_FANGS:int      = classes.BodyParts.Face.SNAKE_FANGS;
	public static const CAT:int              = classes.BodyParts.Face.CAT;
	public static const LIZARD:int           = classes.BodyParts.Face.LIZARD;
	public static const BUNNY:int            = classes.BodyParts.Face.BUNNY;
	public static const KANGAROO:int         = classes.BodyParts.Face.KANGAROO;
	public static const SPIDER_FANGS:int     = classes.BodyParts.Face.SPIDER_FANGS;
	public static const FOX:int              = classes.BodyParts.Face.FOX;
	public static const DRAGON:int           = classes.BodyParts.Face.DRAGON;
	public static const RACCOON_MASK:int     = classes.BodyParts.Face.RACCOON_MASK;
	public static const RACCOON:int          = classes.BodyParts.Face.RACCOON;
	public static const BUCKTEETH:int        = classes.BodyParts.Face.BUCKTEETH;
	public static const MOUSE:int            = classes.BodyParts.Face.MOUSE;
	public static const FERRET_MASK:int      = classes.BodyParts.Face.FERRET_MASK;
	public static const FERRET:int           = classes.BodyParts.Face.FERRET;
	public static const PIG:int              = classes.BodyParts.Face.PIG;
	public static const BOAR:int             = classes.BodyParts.Face.BOAR;
	public static const RHINO:int            = classes.BodyParts.Face.RHINO;
	public static const ECHIDNA:int          = classes.BodyParts.Face.ECHIDNA;
	public static const DEER:int             = classes.BodyParts.Face.DEER;
	public static const WOLF:int             = classes.BodyParts.Face.WOLF;
	public static const MANTICORE:int        = classes.BodyParts.Face.MANTICORE;
	public static const SALAMANDER_FANGS:int = classes.BodyParts.Face.SALAMANDER_FANGS;
	public static const YETI_FANGS:int       = classes.BodyParts.Face.YETI_FANGS;
	public static const ORCA:int             = classes.BodyParts.Face.ORCA;
	public static const PLANT_DRAGON:int     = classes.BodyParts.Face.PLANT_DRAGON;
	public static const DRAGON_FANGS:int     = classes.BodyParts.Face.DRAGON_FANGS;
	public static const DEVIL_FANGS:int      = classes.BodyParts.Face.DEVIL_FANGS;
	public static const ONI_TEETH:int        = classes.BodyParts.Face.ONI_TEETH;
	public static const RAIJU_FANGS:int      = classes.BodyParts.Face.RAIJU_FANGS;
	public static const VAMPIRE:int          = classes.BodyParts.Face.VAMPIRE;
}
class Gender {
	public static const NONE:int   = classes.lists.Gender.GENDER_NONE;
	public static const MALE:int   = classes.lists.Gender.GENDER_MALE;
	public static const FEMALE:int = classes.lists.Gender.GENDER_FEMALE;
	public static const HERM:int   = classes.lists.Gender.GENDER_HERM;
}
class Gills {
	public static const NONE:int             = classes.BodyParts.Gills.NONE;
	public static const ANEMONE:int          = classes.BodyParts.Gills.ANEMONE;
	public static const FISH:int             = classes.BodyParts.Gills.FISH;
	public static const IN_TENTACLE_LEGS:int = classes.BodyParts.Gills.GILLS_IN_TENTACLE_LEGS;
}
class Hair {
	public static const NORMAL:int  = classes.BodyParts.Hair.NORMAL;
	public static const FEATHER:int = classes.BodyParts.Hair.FEATHER;
	public static const GHOST:int   = classes.BodyParts.Hair.GHOST;
	public static const GOO:int     = classes.BodyParts.Hair.GOO;
	public static const ANEMONE:int = classes.BodyParts.Hair.ANEMONE;
	public static const QUILL:int   = classes.BodyParts.Hair.QUILL;
	public static const GORGON:int  = classes.BodyParts.Hair.GORGON;
	public static const LEAF:int    = classes.BodyParts.Hair.LEAF;
	public static const FLUFFY:int  = classes.BodyParts.Hair.FLUFFY;
	public static const GRASS:int   = classes.BodyParts.Hair.GRASS;
	public static const SILKEN:int  = classes.BodyParts.Hair.SILKEN;
	public static const STORM:int   = classes.BodyParts.Hair.STORM;
}
class Hips {
	public static const RATING_BOYISH:int         = classes.BodyParts.Hips.RATING_BOYISH;
	public static const RATING_SLENDER:int        = classes.BodyParts.Hips.RATING_SLENDER;
	public static const RATING_AVERAGE:int        = classes.BodyParts.Hips.RATING_AVERAGE;
	public static const RATING_AMPLE:int          = classes.BodyParts.Hips.RATING_AMPLE;
	public static const RATING_CURVY:int          = classes.BodyParts.Hips.RATING_CURVY;
	public static const RATING_FERTILE:int        = classes.BodyParts.Hips.RATING_FERTILE;
	public static const RATING_INHUMANLY_WIDE:int = classes.BodyParts.Hips.RATING_INHUMANLY_WIDE;
}
class Horns {
	public static const NONE:int                     = classes.BodyParts.Horns.NONE;
	public static const DEMON:int                    = classes.BodyParts.Horns.DEMON;
	public static const COW_MINOTAUR:int             = classes.BodyParts.Horns.COW_MINOTAUR;
	public static const DRACONIC_X2:int              = classes.BodyParts.Horns.DRACONIC_X2;
	public static const DRACONIC_X4_12_INCH_LONG:int = classes.BodyParts.Horns.DRACONIC_X4_12_INCH_LONG;
	public static const ANTLERS:int                  = classes.BodyParts.Horns.ANTLERS;
	public static const GOAT:int                     = classes.BodyParts.Horns.GOAT;
	public static const UNICORN:int                  = classes.BodyParts.Horns.UNICORN;
	public static const RHINO:int                    = classes.BodyParts.Horns.RHINO;
	public static const OAK:int                      = classes.BodyParts.Horns.OAK;
	public static const GARGOYLE:int                 = classes.BodyParts.Horns.GARGOYLE;
	public static const ORCHID:int                   = classes.BodyParts.Horns.ORCHID;
	public static const ONI_X2:int                   = classes.BodyParts.Horns.ONI_X2;
	public static const ONI:int                      = classes.BodyParts.Horns.ONI;
}
class LowerBody {
	public static const HUMAN:int                 = classes.BodyParts.LowerBody.HUMAN;
	public static const HOOFED:int                = classes.BodyParts.LowerBody.HOOFED;
	public static const DOG:int                   = classes.BodyParts.LowerBody.DOG;
	public static const NAGA:int                  = classes.BodyParts.LowerBody.NAGA;
	public static const DEMONIC_HIGH_HEELS:int    = classes.BodyParts.LowerBody.DEMONIC_HIGH_HEELS;
	public static const DEMONIC_CLAWS:int         = classes.BodyParts.LowerBody.DEMONIC_CLAWS;
	public static const BEE:int                   = classes.BodyParts.LowerBody.BEE;
	public static const GOO:int                   = classes.BodyParts.LowerBody.GOO;
	public static const CAT:int                   = classes.BodyParts.LowerBody.CAT;
	public static const LIZARD:int                = classes.BodyParts.LowerBody.LIZARD;
	public static const PONY:int                  = classes.BodyParts.LowerBody.PONY;
	public static const BUNNY:int                 = classes.BodyParts.LowerBody.BUNNY;
	public static const HARPY:int                 = classes.BodyParts.LowerBody.HARPY;
	public static const KANGAROO:int              = classes.BodyParts.LowerBody.KANGAROO;
	public static const CHITINOUS_SPIDER_LEGS:int = classes.BodyParts.LowerBody.CHITINOUS_SPIDER_LEGS;
	public static const DRIDER_LOWER_BODY:int     = classes.BodyParts.LowerBody.DRIDER;
	public static const FOX:int                   = classes.BodyParts.LowerBody.FOX;
	public static const DRAGON:int                = classes.BodyParts.LowerBody.DRAGON;
	public static const RACCOON:int               = classes.BodyParts.LowerBody.RACCOON;
	public static const FERRET:int                = classes.BodyParts.LowerBody.FERRET;
	public static const CLOVEN_HOOFED:int         = classes.BodyParts.LowerBody.CLOVEN_HOOFED;
	public static const ECHIDNA:int               = classes.BodyParts.LowerBody.ECHIDNA;
	public static const SALAMANDER:int            = classes.BodyParts.LowerBody.SALAMANDER;
	public static const SCYLLA:int                = classes.BodyParts.LowerBody.SCYLLA;
	public static const MANTIS:int                = classes.BodyParts.LowerBody.MANTIS;
	public static const SHARK:int                 = classes.BodyParts.LowerBody.SHARK;
	public static const GARGOYLE:int              = classes.BodyParts.LowerBody.GARGOYLE;
	public static const PLANT_HIGH_HEELS:int      = classes.BodyParts.LowerBody.PLANT_HIGH_HEELS;
	public static const PLANT_ROOT_CLAWS:int      = classes.BodyParts.LowerBody.PLANT_ROOT_CLAWS;
	public static const WOLF:int                  = classes.BodyParts.LowerBody.WOLF;
	public static const PLANT_FLOWER:int          = classes.BodyParts.LowerBody.PLANT_FLOWER;
	public static const LION:int                  = classes.BodyParts.LowerBody.LION;
	public static const YETI:int                  = classes.BodyParts.LowerBody.YETI;
	public static const ORCA:int                  = classes.BodyParts.LowerBody.ORCA;
	public static const YGG_ROOT_CLAWS:int        = classes.BodyParts.LowerBody.YGG_ROOT_CLAWS;
	public static const ONI:int                   = classes.BodyParts.LowerBody.ONI;
	public static const ELF:int                   = classes.BodyParts.LowerBody.ELF;
	public static const RAIJU:int                 = classes.BodyParts.LowerBody.RAIJU;
}
class Neck {

}
class Pattern {
	public static const NONE:int                    = classes.BodyParts.Skin.PATTERN_NONE;
	public static const MAGICAL_TATTOO:int          = classes.BodyParts.Skin.PATTERN_MAGICAL_TATTOO;
	public static const ORCA_UNDERBODY:int          = classes.BodyParts.Skin.PATTERN_ORCA_UNDERBODY;
	public static const BEE_STRIPES:int             = classes.BodyParts.Skin.PATTERN_BEE_STRIPES;
	public static const TIGER_STRIPES:int           = classes.BodyParts.Skin.PATTERN_TIGER_STRIPES;
	public static const BATTLE_TATTOO:int           = classes.BodyParts.Skin.PATTERN_BATTLE_TATTOO;
	public static const SPOTTED:int                 = classes.BodyParts.Skin.PATTERN_SPOTTED;
	public static const LIGHTNING_SHAPED_TATTOO:int = classes.BodyParts.Skin.PATTERN_LIGHTNING_SHAPED_TATTOO;
}
class Piercing {
	public static const NONE:int   = classes.BodyParts.Piercing.NONE;
	public static const STUD:int   = classes.BodyParts.Piercing.STUD;
	public static const RING:int   = classes.BodyParts.Piercing.RING;
	public static const LADDER:int = classes.BodyParts.Piercing.LADDER;
	public static const HOOP:int   = classes.BodyParts.Piercing.HOOP;
	public static const CHAIN:int  = classes.BodyParts.Piercing.CHAIN;
}
class RearBody {
	public static const NONE:int              = classes.BodyParts.RearBody.NONE;
	public static const DRACONIC_MANE:int     = classes.BodyParts.RearBody.DRACONIC_MANE;
	public static const DRACONIC_SPIKES:int   = classes.BodyParts.RearBody.DRACONIC_SPIKES;
	public static const FENRIR_ICE_SPIKES:int = classes.BodyParts.RearBody.FENRIR_ICE_SPIKES;
	public static const LION_MANE:int         = classes.BodyParts.RearBody.LION_MANE;
	public static const BEHEMOTH:int          = classes.BodyParts.RearBody.BEHEMOTH;
	public static const SHARK_FIN:int         = classes.BodyParts.RearBody.SHARK_FIN;
	public static const ORCA_BLOWHOLE:int     = classes.BodyParts.RearBody.ORCA_BLOWHOLE;
	public static const RAIJU_MANE:int        = classes.BodyParts.RearBody.RAIJU_MANE;
	public static const BAT_COLLAR:int        = classes.BodyParts.RearBody.BAT_COLLAR;
}
class Skin {
	public static const COVERAGE_NONE:int         = 0;
	public static const COVERAGE_LOW:int          = 1;
	public static const COVERAGE_MEDIUM:int       = 2;
	public static const COVERAGE_HIGH:int         = 3;
	public static const COVERAGE_COMPLETE:int     = 4;
	public static const PLAIN:int                 = classes.BodyParts.Skin.PLAIN;
	public static const FUR:int                   = classes.BodyParts.Skin.FUR;
	public static const SCALES:int                = classes.BodyParts.Skin.SCALES;
	public static const GOO:int                   = classes.BodyParts.Skin.GOO;
	public static const CHITIN:int                = classes.BodyParts.Skin.CHITIN;
	public static const BARK:int                  = classes.BodyParts.Skin.BARK;
	public static const STONE:int                 = classes.BodyParts.Skin.STONE;
	public static const TATTOED:int               = classes.BodyParts.Skin.TATTOED;
	public static const AQUA_SCALES:int           = classes.BodyParts.Skin.AQUA_SCALES;
	public static const DRAGON_SCALES:int         = classes.BodyParts.Skin.DRAGON_SCALES;
	public static const MOSS:int                  = classes.BodyParts.Skin.MOSS;
	public static const AQUA_RUBBER_LIKE:int      = classes.BodyParts.Skin.AQUA_RUBBER_LIKE;
}
class Tail {
	public static const NONE:int                = classes.BodyParts.Tail.NONE;
	public static const HORSE:int               = classes.BodyParts.Tail.HORSE;
	public static const DOG:int                 = classes.BodyParts.Tail.DOG;
	public static const DEMONIC:int             = classes.BodyParts.Tail.DEMONIC;
	public static const COW:int                 = classes.BodyParts.Tail.COW;
	public static const SPIDER_ADBOMEN:int      = classes.BodyParts.Tail.SPIDER_ADBOMEN;
	public static const BEE_ABDOMEN:int         = classes.BodyParts.Tail.BEE_ABDOMEN;
	public static const SHARK:int               = classes.BodyParts.Tail.SHARK;
	public static const CAT:int                 = classes.BodyParts.Tail.CAT;
	public static const LIZARD:int              = classes.BodyParts.Tail.LIZARD;
	public static const RABBIT:int              = classes.BodyParts.Tail.RABBIT;
	public static const HARPY:int               = classes.BodyParts.Tail.HARPY;
	public static const KANGAROO:int            = classes.BodyParts.Tail.KANGAROO;
	public static const FOX:int                 = classes.BodyParts.Tail.FOX;
	public static const DRACONIC:int            = classes.BodyParts.Tail.DRACONIC;
	public static const RACCOON:int             = classes.BodyParts.Tail.RACCOON;
	public static const MOUSE:int               = classes.BodyParts.Tail.MOUSE;
	public static const FERRET:int              = classes.BodyParts.Tail.FERRET;
	public static const BEHEMOTH:int            = classes.BodyParts.Tail.BEHEMOTH;
	public static const PIG:int                 = classes.BodyParts.Tail.PIG;
	public static const SCORPION:int            = classes.BodyParts.Tail.SCORPION;
	public static const GOAT:int                = classes.BodyParts.Tail.GOAT;
	public static const RHINO:int               = classes.BodyParts.Tail.RHINO;
	public static const ECHIDNA:int             = classes.BodyParts.Tail.ECHIDNA;
	public static const DEER:int                = classes.BodyParts.Tail.DEER;
	public static const SALAMANDER:int          = classes.BodyParts.Tail.SALAMANDER;
	public static const KITSHOO:int             = classes.BodyParts.Tail.KITSHOO;
	public static const MANTIS_ABDOMEN:int      = classes.BodyParts.Tail.MANTIS_ABDOMEN;
	public static const MANTICORE_PUSSYTAIL:int = classes.BodyParts.Tail.MANTICORE_PUSSYTAIL;
	public static const WOLF:int                = classes.BodyParts.Tail.WOLF;
	public static const GARGOYLE:int            = classes.BodyParts.Tail.GARGOYLE;
	public static const ORCA:int                = classes.BodyParts.Tail.ORCA;
	public static const YGGDRASIL:int           = classes.BodyParts.Tail.YGGDRASIL;
	public static const RAIJU:int               = classes.BodyParts.Tail.RAIJU;
}
class Tongue {
	public static const HUMAN:int    = classes.BodyParts.Tongue.HUMAN;
	public static const SNAKE:int    = classes.BodyParts.Tongue.SNAKE;
	public static const DEMONIC:int  = classes.BodyParts.Tongue.DEMONIC;
	public static const DRACONIC:int = classes.BodyParts.Tongue.DRACONIC;
	public static const ECHIDNA:int  = classes.BodyParts.Tongue.ECHIDNA;
	public static const CAT:int      = classes.BodyParts.Tongue.CAT;
	public static const ELF:int      = classes.BodyParts.Tongue.ELF;
}
class UnderBody {

}
class Wings {
	public static const NONE:int                 = classes.BodyParts.Wings.NONE;
	public static const BEE_LIKE_SMALL:int       = classes.BodyParts.Wings.BEE_LIKE_SMALL;
	public static const BEE_LIKE_LARGE:int       = classes.BodyParts.Wings.BEE_LIKE_LARGE;
	public static const HARPY:int                = classes.BodyParts.Wings.HARPY;
	public static const IMP:int                  = classes.BodyParts.Wings.IMP;
	public static const BAT_LIKE_TINY:int        = classes.BodyParts.Wings.BAT_LIKE_TINY;
	public static const BAT_LIKE_LARGE:int       = classes.BodyParts.Wings.BAT_LIKE_LARGE;
	public static const SHARK_FIN:int            = classes.BodyParts.Wings.SHARK_FIN;
	public static const FEATHERED_LARGE:int      = classes.BodyParts.Wings.FEATHERED_LARGE;
	public static const DRACONIC_SMALL:int       = classes.BodyParts.Wings.DRACONIC_SMALL;
	public static const DRACONIC_LARGE:int       = classes.BodyParts.Wings.DRACONIC_LARGE;
	public static const GIANT_DRAGONFLY:int      = classes.BodyParts.Wings.GIANT_DRAGONFLY;
	public static const BAT_LIKE_LARGE_2:int     = classes.BodyParts.Wings.BAT_LIKE_LARGE_2;
	public static const DRACONIC_HUGE:int        = classes.BodyParts.Wings.DRACONIC_HUGE;
	public static const FEATHERED_PHOENIX:int    = classes.BodyParts.Wings.FEATHERED_PHOENIX;
	public static const FEATHERED_ALICORN:int    = classes.BodyParts.Wings.FEATHERED_ALICORN;
	public static const MANTIS_LIKE_SMALL:int    = classes.BodyParts.Wings.MANTIS_LIKE_SMALL;
	public static const MANTIS_LIKE_LARGE:int    = classes.BodyParts.Wings.MANTIS_LIKE_LARGE;
	public static const MANTIS_LIKE_LARGE_2:int  = classes.BodyParts.Wings.MANTIS_LIKE_LARGE_2;
	public static const GARGOYLE_LIKE_LARGE:int  = classes.BodyParts.Wings.GARGOYLE_LIKE_LARGE;
	public static const PLANT:int                = classes.BodyParts.Wings.PLANT;
	public static const MANTICORE_LIKE_SMALL:int = classes.BodyParts.Wings.MANTICORE_LIKE_SMALL;
	public static const MANTICORE_LIKE_LARGE:int = classes.BodyParts.Wings.MANTICORE_LIKE_LARGE;
	public static const BAT_ARM:int              = classes.BodyParts.Wings.BAT_ARM;
	public static const VAMPIRE:int              = classes.BodyParts.Wings.VAMPIRE;
}
