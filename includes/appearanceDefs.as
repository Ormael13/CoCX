// The comment structure in the following section is very specific, as the comment contents
// are actually parsed into regexes that are used by my refactoring tool to refactor
// the relevant descriptions.

// Description constants

// gender
public static const GENDER_NONE:int                                                 =    0;
public static const GENDER_MALE:int                                                 =    1;
public static const GENDER_FEMALE:int                                               =    2;
public static const GENDER_HERM:int                                                 =    3;

// skinType
public static const SKIN_TYPE_PLAIN:int                                             =    0;
public static const SKIN_TYPE_FUR:int                                               =    1;
public static const SKIN_TYPE_SCALES:int                                            =    2;
public static const SKIN_TYPE_GOO:int                                               =    3;
public static const SKIN_TYPE_UNDEFINED:int                                         =    4;

// hairType
public static const HAIR_NORMAL:int                                                =     0;
public static const HAIR_FEATHER:int                                               =     1;
public static const HAIR_GHOST:int                                                 =     2;
public static const HAIR_GOO:int                                                   =     3;
public static const HAIR_ANEMONE:int                                               =     4;
public static const HAIR_QUILL:int                                                 =     5;

// beardType
public static const BEARD_NORMAL:int                                               =     0;
public static const BEARD_GOATEE:int                                               =     1;
public static const BEARD_CLEANCUT:int                                             =     2;
public static const BEARD_MOUNTAINMAN:int                                          =     3;

// faceType
public static const FACE_HUMAN:int                                                  =    0;
public static const FACE_HORSE:int                                                  =    1;
public static const FACE_DOG:int                                                    =    2;
public static const FACE_COW_MINOTAUR:int                                           =    3;
public static const FACE_SHARK_TEETH:int                                            =    4;
public static const FACE_SNAKE_FANGS:int                                            =    5;
public static const FACE_CAT:int                                                    =    6;
public static const FACE_LIZARD:int                                                 =    7;
public static const FACE_BUNNY:int                                                  =    8;
public static const FACE_KANGAROO:int                                               =    9;
public static const FACE_SPIDER_FANGS:int                                           =   10;
public static const FACE_FOX:int                                                    =   11;
public static const FACE_DRAGON:int                                                 =   12;
public static const FACE_RACCOON_MASK:int                                           =   13;
public static const FACE_RACCOON:int                                                =   14;
public static const FACE_BUCKTEETH:int                                              =   15;
public static const FACE_MOUSE:int                                                  =   16;
public static const FACE_FERRET_MASK:int                                            =   17;
public static const FACE_FERRET:int                                            		=   18;
public static const FACE_PIG:int                                            		=   19;
public static const FACE_BOAR:int                                            		=   20;
public static const FACE_RHINO:int                                            		=   21;
public static const FACE_ECHIDNA:int                                            	=   22;
public static const FACE_DEER:int                                               	=   23;

// tongueType
public static const TONUGE_HUMAN:int                                                =   0;
public static const TONUGE_SNAKE:int                                                =   1;
public static const TONUGE_DEMONIC:int                                              =   2;
public static const TONUGE_DRACONIC:int                                             =   3;
public static const TONUGE_ECHIDNA:int                                              =   4;

// eyeType
public static const EYES_HUMAN:int                                                  =   0;
public static const EYES_FOUR_SPIDER_EYES:int                                       =   1;
public static const EYES_BLACK_EYES_SAND_TRAP:int                                   =   2;

// earType
public static const EARS_HUMAN:int                                                  =   0;
public static const EARS_HORSE:int                                                  =   1;
public static const EARS_DOG:int                                                    =   2;
public static const EARS_COW:int                                                    =   3;
public static const EARS_ELFIN:int                                                  =   4;
public static const EARS_CAT:int                                                    =   5;
public static const EARS_LIZARD:int                                                 =   6;
public static const EARS_BUNNY:int                                                  =   7;
public static const EARS_KANGAROO:int                                               =   8;
public static const EARS_FOX:int                                                    =   9;
public static const EARS_DRAGON:int                                                 =  10;
public static const EARS_RACCOON:int                                                =  11;
public static const EARS_MOUSE:int                                                  =  12;
public static const EARS_FERRET:int                                                 =  13;
public static const EARS_PIG:int                                                    =  14;
public static const EARS_RHINO:int                                                  =  15;
public static const EARS_ECHIDNA:int                                                =  16;
public static const EARS_DEER:int                                                   =  17;

// hornType
public static const HORNS_NONE:int                                                  =   0;
public static const HORNS_DEMON:int                                                 =   1;
public static const HORNS_COW_MINOTAUR:int                                          =   2;
public static const HORNS_DRACONIC_X2:int                                           =   3;
public static const HORNS_DRACONIC_X4_12_INCH_LONG:int                              =   4;
public static const HORNS_ANTLERS:int                                               =   5;
public static const HORNS_GOAT:int                                                  =   6;
public static const HORNS_UNICORN:int                                               =   7;
public static const HORNS_RHINO:int                                                 =   8;

// antennae
public static const ANTENNAE_NONE:int                                               =   0;
public static const ANTENNAE_BEE:int                                                =   2;

// armType
public static const ARM_TYPE_HUMAN:int                                              =   0;
public static const ARM_TYPE_HARPY:int                                              =   1;
public static const ARM_TYPE_SPIDER:int                                             =   2;

// tailType
public static const TAIL_TYPE_NONE:int                                              =   0;
public static const TAIL_TYPE_HORSE:int                                             =   1;
public static const TAIL_TYPE_DOG:int                                               =   2;
public static const TAIL_TYPE_DEMONIC:int                                           =   3;
public static const TAIL_TYPE_COW:int                                               =   4;
public static const TAIL_TYPE_SPIDER_ADBOMEN:int                                    =   5;
public static const TAIL_TYPE_BEE_ABDOMEN:int                                       =   6;
public static const TAIL_TYPE_SHARK:int                                             =   7;
public static const TAIL_TYPE_CAT:int                                               =   8;
public static const TAIL_TYPE_LIZARD:int                                            =   9;
public static const TAIL_TYPE_RABBIT:int                                            =  10;
public static const TAIL_TYPE_HARPY:int                                             =  11;
public static const TAIL_TYPE_KANGAROO:int                                          =  12;
public static const TAIL_TYPE_FOX:int                                               =  13;
public static const TAIL_TYPE_DRACONIC:int                                          =  14;
public static const TAIL_TYPE_RACCOON:int                                           =  15;
public static const TAIL_TYPE_MOUSE:int                                             =  16;
public static const TAIL_TYPE_FERRET:int                                            =  17;
public static const TAIL_TYPE_BEHEMOTH:int                                          =  18;
public static const TAIL_TYPE_PIG:int                                               =  19;
public static const TAIL_TYPE_SCORPION:int                                          =  20;
public static const TAIL_TYPE_GOAT:int                                              =  21;
public static const TAIL_TYPE_RHINO:int                                             =  22;
public static const TAIL_TYPE_ECHIDNA:int                                           =  23;
public static const TAIL_TYPE_DEER:int                                              =  24;

//breast size
public static const BREAST_CUP_FLAT:int												=   0;
public static const BREAST_CUP_A:int												=   1;
public static const BREAST_CUP_B:int												=   2;
public static const BREAST_CUP_C:int												=   3;
public static const BREAST_CUP_D:int												=   4;
public static const BREAST_CUP_DD:int												=   5;
public static const BREAST_CUP_DD_BIG:int											=   6;
public static const BREAST_CUP_E:int												=   7;
public static const BREAST_CUP_E_BIG:int											=   8;
public static const BREAST_CUP_EE:int												=   9;
public static const BREAST_CUP_EE_BIG:int											=  10;
public static const BREAST_CUP_F:int												=  11;
public static const BREAST_CUP_F_BIG:int											=  12;
public static const BREAST_CUP_FF:int												=  13;
public static const BREAST_CUP_FF_BIG:int											=  14;
public static const BREAST_CUP_G:int												=  15;
public static const BREAST_CUP_G_BIG:int											=  16;
public static const BREAST_CUP_GG:int												=  17;
public static const BREAST_CUP_GG_BIG:int											=  18;
public static const BREAST_CUP_H:int												=  19;
public static const BREAST_CUP_H_BIG:int											=  20;
public static const BREAST_CUP_HH:int												=  21;
public static const BREAST_CUP_HH_BIG:int											=  22;
public static const BREAST_CUP_HHH:int												=  23;
public static const BREAST_CUP_I:int												=  24;
public static const BREAST_CUP_I_BIG:int											=  25;
public static const BREAST_CUP_II:int												=  26;
public static const BREAST_CUP_II_BIG:int											=  27;
public static const BREAST_CUP_J:int												=  28;
public static const BREAST_CUP_J_BIG:int											=  29;
public static const BREAST_CUP_JJ:int												=  30;
public static const BREAST_CUP_JJ_BIG:int											=  31;
public static const BREAST_CUP_K:int												=  32;
public static const BREAST_CUP_K_BIG:int											=  33;
public static const BREAST_CUP_KK:int												=  34;
public static const BREAST_CUP_KK_BIG:int											=  35;
public static const BREAST_CUP_L:int												=  36;
public static const BREAST_CUP_L_BIG:int											=  37;
public static const BREAST_CUP_LL:int												=  38;
public static const BREAST_CUP_LL_BIG:int											=  39;
public static const BREAST_CUP_M:int												=  40;
public static const BREAST_CUP_M_BIG:int											=  41;
public static const BREAST_CUP_MM:int												=  42;
public static const BREAST_CUP_MM_BIG:int											=  43;
public static const BREAST_CUP_MMM:int												=  44;
public static const BREAST_CUP_MMM_LARGE:int										=  45;
public static const BREAST_CUP_N:int												=  46;
public static const BREAST_CUP_N_LARGE:int											=  47;
public static const BREAST_CUP_NN:int												=  48;
public static const BREAST_CUP_NN_LARGE:int											=  49;
public static const BREAST_CUP_O:int												=  50;
public static const BREAST_CUP_O_LARGE:int											=  51;
public static const BREAST_CUP_OO:int												=  52;
public static const BREAST_CUP_OO_LARGE:int											=  53;
public static const BREAST_CUP_P:int												=  54;
public static const BREAST_CUP_P_LARGE:int											=  55;
public static const BREAST_CUP_PP:int												=  56;
public static const BREAST_CUP_PP_LARGE:int											=  57;
public static const BREAST_CUP_Q:int												=  58;
public static const BREAST_CUP_Q_LARGE:int											=  59;
public static const BREAST_CUP_QQ:int												=  60;
public static const BREAST_CUP_QQ_LARGE:int											=  61;
public static const BREAST_CUP_R:int												=  62;
public static const BREAST_CUP_R_LARGE:int											=  63;
public static const BREAST_CUP_RR:int												=  64;
public static const BREAST_CUP_RR_LARGE:int											=  65;
public static const BREAST_CUP_S:int												=  66;
public static const BREAST_CUP_S_LARGE:int											=  67;
public static const BREAST_CUP_SS:int												=  68;
public static const BREAST_CUP_SS_LARGE:int											=  69;
public static const BREAST_CUP_T:int												=  70;
public static const BREAST_CUP_T_LARGE:int											=  71;
public static const BREAST_CUP_TT:int												=  72;
public static const BREAST_CUP_TT_LARGE:int											=  73;
public static const BREAST_CUP_U:int												=  74;
public static const BREAST_CUP_U_LARGE:int											=  75;
public static const BREAST_CUP_UU:int												=  76;
public static const BREAST_CUP_UU_LARGE:int											=  77;
public static const BREAST_CUP_V:int												=  78;
public static const BREAST_CUP_V_LARGE:int											=  79;
public static const BREAST_CUP_VV:int												=  80;
public static const BREAST_CUP_VV_LARGE:int											=  81;
public static const BREAST_CUP_W:int												=  82;
public static const BREAST_CUP_W_LARGE:int											=  83;
public static const BREAST_CUP_WW:int												=  84;
public static const BREAST_CUP_WW_LARGE:int											=  85;
public static const BREAST_CUP_X:int												=  86;
public static const BREAST_CUP_X_LARGE:int											=  87;
public static const BREAST_CUP_XX:int												=  88;
public static const BREAST_CUP_XX_LARGE:int											=  89;
public static const BREAST_CUP_Y:int												=  90;
public static const BREAST_CUP_Y_LARGE:int											=  91;
public static const BREAST_CUP_YY:int												=  92;
public static const BREAST_CUP_YY_LARGE:int											=  93;
public static const BREAST_CUP_Z:int												=  94;
public static const BREAST_CUP_Z_LARGE:int											=  95;
public static const BREAST_CUP_ZZ:int												=  96;
public static const BREAST_CUP_ZZ_LARGE:int											=  97;
public static const BREAST_CUP_ZZZ:int												=  98;
public static const BREAST_CUP_ZZZ_LARGE:int										=  99;

// wingType
public static const WING_TYPE_NONE:int                                              =   0;
public static const WING_TYPE_BEE_LIKE_SMALL:int                                    =   1;
public static const WING_TYPE_BEE_LIKE_LARGE:int                                    =   2;
public static const WING_TYPE_HARPY:int                                             =   4;
public static const WING_TYPE_IMP:int                                               =   5;
public static const WING_TYPE_BAT_LIKE_TINY:int                                     =   6;
public static const WING_TYPE_BAT_LIKE_LARGE:int                                    =   7;
public static const WING_TYPE_SHARK_FIN:int                                         =   8;
public static const WING_TYPE_FEATHERED_LARGE:int                                   =   9;
public static const WING_TYPE_DRACONIC_SMALL:int                                    =  10;
public static const WING_TYPE_DRACONIC_LARGE:int                                    =  11;
public static const WING_TYPE_GIANT_DRAGONFLY:int                                   =  12;

// lowerBody
public static const LOWER_BODY_TYPE_HUMAN:int                                       =   0;
public static const LOWER_BODY_TYPE_HOOFED:int                                      =   1;
public static const LOWER_BODY_TYPE_DOG:int                                         =   2;
public static const LOWER_BODY_TYPE_NAGA:int                                        =   3;
public static const LOWER_BODY_TYPE_CENTAUR:int                                     =   4; // DEPRECATED, use LOWER_BODY_TYPE_HOOFED and legCount=4
public static const LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS:int                          =   5;
public static const LOWER_BODY_TYPE_DEMONIC_CLAWS:int                               =   6;
public static const LOWER_BODY_TYPE_BEE:int                                         =   7;
public static const LOWER_BODY_TYPE_GOO:int                                         =   8;
public static const LOWER_BODY_TYPE_CAT:int                                         =   9;
public static const LOWER_BODY_TYPE_LIZARD:int                                      =  10;
public static const LOWER_BODY_TYPE_PONY:int                                        =  11;
public static const LOWER_BODY_TYPE_BUNNY:int                                       =  12;
public static const LOWER_BODY_TYPE_HARPY:int                                       =  13;
public static const LOWER_BODY_TYPE_KANGAROO:int                                    =  14;
public static const LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS:int                       =  15;
public static const LOWER_BODY_TYPE_DRIDER_LOWER_BODY:int                           =  16;
public static const LOWER_BODY_TYPE_FOX:int                                         =  17;
public static const LOWER_BODY_TYPE_DRAGON:int                                      =  18;
public static const LOWER_BODY_TYPE_RACCOON:int                                     =  19;
public static const LOWER_BODY_TYPE_FERRET:int                                      =  20;
public static const LOWER_BODY_TYPE_CLOVEN_HOOFED:int                               =  21;
//public static const LOWER_BODY_TYPE_RHINO:int                                       =  22;
public static const LOWER_BODY_TYPE_ECHIDNA:int                                     =  23;
public static const LOWER_BODY_TYPE_DEERTAUR:int                                    =  24; // DEPRECATED, use LOWER_BODY_TYPE_CLOVEN_HOOFED and legCount=4

// piercingtypesNOPEDISABLED
public static const PIERCING_TYPE_NONE:int                                          =   0;
public static const PIERCING_TYPE_STUD:int                                          =   1;
public static const PIERCING_TYPE_RING:int                                          =   2;
public static const PIERCING_TYPE_LADDER:int                                        =   3;
public static const PIERCING_TYPE_HOOP:int                                          =   4;
public static const PIERCING_TYPE_CHAIN:int                                         =   5;

// vaginatypesNOPEDISABLED
public static const VAGINA_TYPE_HUMAN:int                                           =   0;
public static const VAGINA_TYPE_EQUINE:int                                          =   1;
public static const VAGINA_TYPE_BLACK_SAND_TRAP:int                                 =   5;

// vaginalWetness
public static const VAGINA_WETNESS_DRY:int                                          =   0;
public static const VAGINA_WETNESS_NORMAL:int                                       =   1;
public static const VAGINA_WETNESS_WET:int                                          =   2;
public static const VAGINA_WETNESS_SLICK:int                                        =   3;
public static const VAGINA_WETNESS_DROOLING:int                                     =   4;
public static const VAGINA_WETNESS_SLAVERING:int                                    =   5;

// vaginalLooseness
public static const VAGINA_LOOSENESS_TIGHT:int                                      =   0;
public static const VAGINA_LOOSENESS_NORMAL:int                                     =   1;
public static const VAGINA_LOOSENESS_LOOSE:int                                      =   2;
public static const VAGINA_LOOSENESS_GAPING:int                                     =   3;
public static const VAGINA_LOOSENESS_GAPING_WIDE:int                                =   4;
public static const VAGINA_LOOSENESS_LEVEL_CLOWN_CAR:int                            =   5;

// analwetnesslevelsNOPEDISABLED
public static const ANAL_WETNESS_DRY:int                                            =   0;
public static const ANAL_WETNESS_NORMAL:int                                         =   1;
public static const ANAL_WETNESS_MOIST:int                                          =   2;
public static const ANAL_WETNESS_SLIMY:int                                          =   3;
public static const ANAL_WETNESS_DROOLING:int                                       =   4;
public static const ANAL_WETNESS_SLIME_DROOLING:int                                 =   5;

// analloosenesslevelsNOPEDISABLED
public static const ANAL_LOOSENESS_VIRGIN:int                                       =   0;
public static const ANAL_LOOSENESS_TIGHT:int                                        =   1;
public static const ANAL_LOOSENESS_NORMAL:int                                       =   2;
public static const ANAL_LOOSENESS_LOOSE:int                                        =   3;
public static const ANAL_LOOSENESS_STRETCHED:int                                    =   4;
public static const ANAL_LOOSENESS_GAPING:int                                       =   5;

// hipRating
public static const HIP_RATING_BOYISH:int                                           =   0;
public static const HIP_RATING_SLENDER:int                                          =   2;
public static const HIP_RATING_AVERAGE:int                                          =   4;
public static const HIP_RATING_AMPLE:int                                            =   6;
public static const HIP_RATING_CURVY:int                                            =  10;
public static const HIP_RATING_FERTILE:int                                          =  15;
public static const HIP_RATING_INHUMANLY_WIDE:int                                   =  20;

// buttRating
public static const BUTT_RATING_BUTTLESS:int                                        =   0;
public static const BUTT_RATING_TIGHT:int                                           =   2;
public static const BUTT_RATING_AVERAGE:int                                         =   4;
public static const BUTT_RATING_NOTICEABLE:int                                      =   6;
public static const BUTT_RATING_LARGE:int                                           =   8;
public static const BUTT_RATING_JIGGLY:int                                          =  10;
public static const BUTT_RATING_EXPANSIVE:int                                       =  13;
public static const BUTT_RATING_HUGE:int                                            =  16;
public static const BUTT_RATING_INCONCEIVABLY_BIG:int                               =  20;

// End Description constants

