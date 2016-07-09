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
public static const SKIN_TYPE_UNDEFINED:int                                         =    4; // DEPRECATED, silently discarded upon loading a saved game

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
public static const TONGUE_HUMAN:int                                                =   0;
public static const TONGUE_SNAKE:int                                                =   1;
public static const TONGUE_DEMONIC:int                                              =   2;
public static const TONGUE_DRACONIC:int                                             =   3;
public static const TONGUE_ECHIDNA:int                                              =   4;

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
public static const ARM_TYPE_PREDATOR:int                                           =   4;
public static const ARM_TYPE_SALAMANDER:int                                         =   5;

// clawType
public static const CLAW_TYPE_NORMAL:int                                            =   0;
public static const CLAW_TYPE_LIZARD:int                                            =   1;
public static const CLAW_TYPE_DRAGON:int                                            =   2;
public static const CLAW_TYPE_SALAMANDER:int                                        =   3;
public static const CLAW_TYPE_CAT:int                                               =   4; // NYI! Placeholder for now!! (See http://tiny.cc/coc-revamp-claws)
public static const CLAW_TYPE_DOG:int                                               =   5; // NYI! Placeholder for now!! (See http://tiny.cc/coc-revamp-claws)
public static const CLAW_TYPE_RAPTOR:int                                            =   6; // NYI! Placeholder for now!! (See http://tiny.cc/coc-revamp-claws) Giev teh Rapturs :-)
public static const CLAW_TYPE_MANTIS:int                                            =   7; // NYI! Placeholder for Xianxia mod (See http://tiny.cc/coc-xianxia-mod)

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
public static const TAIL_TYPE_SALAMANDER:int						             			=  25;

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
public static const LOWER_BODY_TYPE_SALAMANDER:int						       			=  25;

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

//breast size (moved here because it's the largest list)
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
public static const BREAST_CUP_HYPER_A:int											= 100; // <-- HYPER
public static const BREAST_CUP_HYPER_B:int											= 101;
public static const BREAST_CUP_HYPER_C:int											= 102;
public static const BREAST_CUP_HYPER_D:int											= 103;
public static const BREAST_CUP_HYPER_DD:int											= 104;
public static const BREAST_CUP_HYPER_DD_BIG:int										= 105;
public static const BREAST_CUP_HYPER_E:int											= 106;
public static const BREAST_CUP_HYPER_E_BIG:int										= 107;
public static const BREAST_CUP_HYPER_EE:int											= 108;
public static const BREAST_CUP_HYPER_EE_BIG:int										= 109;
public static const BREAST_CUP_HYPER_F:int											= 110;
public static const BREAST_CUP_HYPER_F_BIG:int										= 111;
public static const BREAST_CUP_HYPER_FF:int											= 112;
public static const BREAST_CUP_HYPER_FF_BIG:int										= 113;
public static const BREAST_CUP_HYPER_G:int											= 114;
public static const BREAST_CUP_HYPER_G_BIG:int										= 115;
public static const BREAST_CUP_HYPER_GG:int											= 116;
public static const BREAST_CUP_HYPER_GG_BIG:int										= 117;
public static const BREAST_CUP_HYPER_H:int											= 118;
public static const BREAST_CUP_HYPER_H_BIG:int										= 119;
public static const BREAST_CUP_HYPER_HH:int											= 120;
public static const BREAST_CUP_HYPER_HH_BIG:int										= 121;
public static const BREAST_CUP_HYPER_HHH:int										= 122;
public static const BREAST_CUP_HYPER_I:int											= 123;
public static const BREAST_CUP_HYPER_I_BIG:int										= 124;
public static const BREAST_CUP_HYPER_II:int											= 125;
public static const BREAST_CUP_HYPER_II_BIG:int										= 126;
public static const BREAST_CUP_HYPER_J:int											= 127;
public static const BREAST_CUP_HYPER_J_BIG:int										= 128;
public static const BREAST_CUP_HYPER_JJ:int											= 129;
public static const BREAST_CUP_HYPER_JJ_BIG:int										= 130;
public static const BREAST_CUP_HYPER_K:int											= 131;
public static const BREAST_CUP_HYPER_K_BIG:int										= 132;
public static const BREAST_CUP_HYPER_KK:int											= 133;
public static const BREAST_CUP_HYPER_KK_BIG:int										= 134;
public static const BREAST_CUP_HYPER_L:int											= 135;
public static const BREAST_CUP_HYPER_L_BIG:int										= 136;
public static const BREAST_CUP_HYPER_LL:int											= 137;
public static const BREAST_CUP_HYPER_LL_BIG:int										= 138;
public static const BREAST_CUP_HYPER_M:int											= 139;
public static const BREAST_CUP_HYPER_M_BIG:int										= 140;
public static const BREAST_CUP_HYPER_MM:int											= 141;
public static const BREAST_CUP_HYPER_MM_BIG:int										= 142;
public static const BREAST_CUP_HYPER_MMM:int										= 143;
public static const BREAST_CUP_HYPER_MMM_LARGE:int									= 144;
public static const BREAST_CUP_HYPER_N:int											= 145;
public static const BREAST_CUP_HYPER_N_LARGE:int									= 146;
public static const BREAST_CUP_HYPER_NN:int											= 147;
public static const BREAST_CUP_HYPER_NN_LARGE:int									= 148;
public static const BREAST_CUP_HYPER_O:int											= 149;
public static const BREAST_CUP_HYPER_O_LARGE:int									= 150;
public static const BREAST_CUP_HYPER_OO:int											= 151;
public static const BREAST_CUP_HYPER_OO_LARGE:int									= 152;
public static const BREAST_CUP_HYPER_P:int											= 153;
public static const BREAST_CUP_HYPER_P_LARGE:int									= 154;
public static const BREAST_CUP_HYPER_PP:int											= 155;
public static const BREAST_CUP_HYPER_PP_LARGE:int									= 156;
public static const BREAST_CUP_HYPER_Q:int											= 157;
public static const BREAST_CUP_HYPER_Q_LARGE:int									= 158;
public static const BREAST_CUP_HYPER_QQ:int											= 159;
public static const BREAST_CUP_HYPER_QQ_LARGE:int									= 160;
public static const BREAST_CUP_HYPER_R:int											= 161;
public static const BREAST_CUP_HYPER_R_LARGE:int									= 162;
public static const BREAST_CUP_HYPER_RR:int											= 163;
public static const BREAST_CUP_HYPER_RR_LARGE:int									= 164;
public static const BREAST_CUP_HYPER_S:int											= 165;
public static const BREAST_CUP_HYPER_S_LARGE:int									= 166;
public static const BREAST_CUP_HYPER_SS:int											= 167;
public static const BREAST_CUP_HYPER_SS_LARGE:int									= 168;
public static const BREAST_CUP_HYPER_T:int											= 169;
public static const BREAST_CUP_HYPER_T_LARGE:int									= 170;
public static const BREAST_CUP_HYPER_TT:int											= 171;
public static const BREAST_CUP_HYPER_TT_LARGE:int									= 172;
public static const BREAST_CUP_HYPER_U:int											= 173;
public static const BREAST_CUP_HYPER_U_LARGE:int									= 174;
public static const BREAST_CUP_HYPER_UU:int											= 175;
public static const BREAST_CUP_HYPER_UU_LARGE:int									= 176;
public static const BREAST_CUP_HYPER_V:int											= 177;
public static const BREAST_CUP_HYPER_V_LARGE:int									= 178;
public static const BREAST_CUP_HYPER_VV:int											= 179;
public static const BREAST_CUP_HYPER_VV_LARGE:int									= 180;
public static const BREAST_CUP_HYPER_W:int											= 181;
public static const BREAST_CUP_HYPER_W_LARGE:int									= 182;
public static const BREAST_CUP_HYPER_WW:int											= 183;
public static const BREAST_CUP_HYPER_WW_LARGE:int									= 184;
public static const BREAST_CUP_HYPER_X:int											= 185;
public static const BREAST_CUP_HYPER_X_LARGE:int									= 186;
public static const BREAST_CUP_HYPER_XX:int											= 187;
public static const BREAST_CUP_HYPER_XX_LARGE:int									= 188;
public static const BREAST_CUP_HYPER_Y:int											= 189;
public static const BREAST_CUP_HYPER_Y_LARGE:int									= 190;
public static const BREAST_CUP_HYPER_YY:int											= 191;
public static const BREAST_CUP_HYPER_YY_LARGE:int									= 192;
public static const BREAST_CUP_HYPER_Z:int											= 193;
public static const BREAST_CUP_HYPER_Z_LARGE:int									= 194;
public static const BREAST_CUP_HYPER_ZZ:int											= 195;
public static const BREAST_CUP_HYPER_ZZ_LARGE:int									= 196;
public static const BREAST_CUP_HYPER_ZZZ:int										= 197;
public static const BREAST_CUP_HYPER_ZZZ_LARGE:int									= 198;
public static const BREAST_CUP_JACQUES00:int										= 199; // <-- Jacques00-cup

// End Description constants

