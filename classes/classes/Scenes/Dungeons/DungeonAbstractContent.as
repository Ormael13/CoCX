package classes.Scenes.Dungeons 
{
import classes.BaseContent;
import classes.Scenes.SceneLib;

public class DungeonAbstractContent extends BaseContent
{
    public function DungeonAbstractContent() {}
    
    public static var inDungeon:Boolean = false;
    public static var dungeonLoc:int = DUNGEON_CABIN;
    public static var inRoomedDungeon:Boolean = false;
    public static var inRoomedDungeonResume:Function = null;

    protected function get dungeons():DungeonEngine {
        return SceneLib.dungeons;
    }

    //Dungeon constants. Moved here so derived classes will have easier access to them
    public static const DUNGEON_CABIN:int				        = -10;

    public static const DUNGEON_FACTORY_FOYER:int				= 0;
    public static const DUNGEON_FACTORY_BREAK_ROOM:int			= 1;
    public static const DUNGEON_FACTORY_PUMP_ROOM:int			= 2;
    public static const DUNGEON_FACTORY_FURNACE_ROOM:int		= 3;
    public static const DUNGEON_FACTORY_REPAIR_CLOSET:int		= 4;
    public static const DUNGEON_FACTORY_MAIN_CHAMBER:int		= 5;
    public static const DUNGEON_FACTORY_BATHROOM:int			= 6;
    public static const DUNGEON_FACTORY_FOREMANS_OFFICE:int	    = 7;
    public static const DUNGEON_FACTORY_PUMP_CONTROL:int		= 8;
    public static const DUNGEON_FACTORY_STORE_ROOM:int			= 9;
    
    public static const DUNGEON_CAVE_ENTRANCE:int			= 10;
    public static const DUNGEON_CAVE_TUNNEL:int			    = 11;
    public static const DUNGEON_CAVE_GATHERING_HALL:int	    = 12;
    public static const DUNGEON_CAVE_FUNGUS_CAVERN:int		= 13;
    public static const DUNGEON_CAVE_TORTURE_ROOM:int		= 14;
    public static const DUNGEON_CAVE_SECRET_TUNNEL:int		= 15;
    public static const DUNGEON_CAVE_ZETAZ_CHAMBER:int		= 16;
    
    public static const DUNGEON_HEL_GUARD_HALL:int		= 17;
    public static const DUNGEON_HEL_WINE_CELLAR:int	    = 18;
    public static const DUNGEON_HEL_STAIR_WELL:int		= 19;
    public static const DUNGEON_HEL_DUNGEON:int		    = 20;
    public static const DUNGEON_HEL_MEZZANINE:int		= 21;
    public static const DUNGEON_HEL_THRONE_ROOM:int	    = 22;
    
    public static const DUNGEON_WITCH_ENTRANCE_GATEWAY:int		= 23;
    public static const DUNGEON_WITCH_CAVERNOUS_COMMONS:int	    = 24;
    public static const DUNGEON_WITCH_WEST_WARRENS_MAIN:int	    = 25;
    public static const DUNGEON_WITCH_CHILDRENS_PLAYROOM:int	= 26;
    public static const DUNGEON_WITCH_PREGNANT_LUST_ROOM:int	= 27;
    public static const DUNGEON_WITCH_WEST_WARRENS_WEST:int	    = 28;
    public static const DUNGEON_WITCH_NURSERY:int				= 29;
    public static const DUNGEON_WITCH_PHARMACY:int				= 30;
    public static const DUNGEON_WITCH_EAST_WARRENS_MAIN:int	    = 31;
    public static const DUNGEON_WITCH_SLEEPING_CHAMBER:int		= 32;
    public static const DUNGEON_WITCH_BATH_ROOM:int			    = 33;
    public static const DUNGEON_WITCH_EAST_WARRENS_EAST:int	    = 34;
    public static const DUNGEON_WITCH_CUM_WITCH_BEDROOM:int	    = 35;
    public static const DUNGEON_WITCH_CUM_WITCH_OFFICE:int		= 36;
    public static const DUNGEON_WITCH_SACRIFICIAL_ALTAR:int	    = 37;
    public static const DUNGEON_WITCH_THRONE_ROOM:int			= 38;
    
    public static const DUNGEON_HIDDEN_CAVE_ENTRANCE:int		= 39;
    public static const DUNGEON_HIDDEN_CAVE_SE_UP:int			= 40;
    public static const DUNGEON_HIDDEN_CAVE_E_UP:int			= 41;
    public static const DUNGEON_HIDDEN_CAVE_NE_UP:int			= 42;
    public static const DUNGEON_HIDDEN_CAVE_N_UP:int			= 43;
    public static const DUNGEON_HIDDEN_CAVE_S_STAIRCASE:int	    = 44;
    public static const DUNGEON_HIDDEN_CAVE_S_UP:int			= 45;
    public static const DUNGEON_HIDDEN_CAVE_S_STORAGE:int		= 46;
    public static const DUNGEON_HIDDEN_CAVE_NW_UP:int			= 47;
    public static const DUNGEON_HIDDEN_CAVE_W_UP:int			= 48;
    public static const DUNGEON_HIDDEN_CAVE_SW_UP:int			= 49;
    public static const DUNGEON_HIDDEN_CAVE_NARROW_T_E:int		= 50;
    public static const DUNGEON_HIDDEN_CAVE_NARROW_T  :int		= 51;
    public static const DUNGEON_HIDDEN_CAVE_NARROW_T_N:int		= 52;
    public static const DUNGEON_HIDDEN_CAVE_L_STORAGE_W:int	    = 53;
    public static const DUNGEON_HIDDEN_CAVE_L_STORAGE_E:int	    = 54;
    public static const DUNGEON_HIDDEN_CAVE_S_STAIRCASE_B:int	= 55;
    public static const DUNGEON_HIDDEN_CAVE_TUNNEL_00:int  	    = 56;
    public static const DUNGEON_HIDDEN_CAVE_TUNNEL_01:int  	    = 57;
    public static const DUNGEON_HIDDEN_CAVE_TUNNEL_02:int  	    = 58;
    public static const DUNGEON_HIDDEN_CAVE_TEDS_LAIR:int   	= 59;
    public static const DUNGEON_HIDDEN_CAVE_SMALL_CAVE_W:int  	= 60;
    public static const DUNGEON_HIDDEN_CAVE_MEDIUM_CAVE:int  	= 61;
    public static const DUNGEON_HIDDEN_CAVE_SMALL_CAVE_E:int  	= 62;
    public static const DUNGEON_HIDDEN_CAVE_SMALL_CAVE_N:int  	= 63;
    
    public static const DUNGEON_DEN_OF_DESIRE_ENTRANCE:int  			= 64;
    public static const DUNGEON_DEN_OF_DESIRE_GREAT_HALL_AREA:int  	    = 65;
    public static const DUNGEON_DEN_OF_DESIRE_LABORATORY:int  			= 66;
    public static const DUNGEON_DEN_OF_DESIRE_HERO_SLAYER_OMNIBUS:int   = 67;
    
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_01:int  = 68;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_02:int  = 69;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_03:int  = 70;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_04:int  = 71;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_05:int  = 72;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_06:int  = 73;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_07:int  = 74;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_08:int  = 75;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_09:int  = 76;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_10:int  = 77;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_11:int  = 78;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_12:int  = 79;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_13:int  = 80;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_14:int  = 81;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_15:int  = 82;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_16:int  = 83;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_17:int  = 84;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_18:int  = 85;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_19:int  = 86;
    public static const DUNGEON_RIVER_FLOOR_01_ROOM_20:int  = 87;
    
    public static const DUNGEON_ANZU_OUTSIDE:int			= 88;
    public static const DUNGEON_ANZU_HALL_FLOOR1:int 		= 89;
    public static const DUNGEON_ANZU_LIVING_ROOM:int 		= 90;
    public static const DUNGEON_ANZU_BATHROOM:int 			= 91;
    public static const DUNGEON_ANZU_DINING_ROOM:int 		= 92;
    public static const DUNGEON_ANZU_KITCHEN:int 			= 93;
    public static const DUNGEON_ANZU_HALL_FLOOR2:int		= 94;
    public static const DUNGEON_ANZU_BEDROOM:int 			= 95;
    public static const DUNGEON_ANZU_LIBRARY:int 			= 96;
    public static const DUNGEON_ANZU_MULTIUSE_ROOM:int 	    = 97;
    public static const DUNGEON_ANZU_HALL_FLOOR3:int 		= 98;
    public static const DUNGEON_ANZU_PALACE_VAULTS:int 	    = 99;
    public static const DUNGEON_ANZU_ALCHEMY_ROOM:int 		= 100;
    public static const DUNGEON_ANZU_ROOF:int 				= 101;
    public static const DUNGEON_ANZU_BASEMENT:int 			= 102;
    public static const DUNGEON_ANZU_ARMORY:int 			= 103;
    
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_01:int = 104;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_02:int = 105;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_03:int = 106;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_04:int = 107;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_05:int = 108;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_06:int = 109;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_07:int = 110;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_08:int = 111;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_09:int = 112;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_10:int = 113;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_11:int = 114;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_12:int = 115;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_13:int = 116;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_14:int = 117;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_15:int = 118;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_16:int = 119;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_17:int = 120;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_18:int = 121;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_19:int = 122;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_20:int = 123;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_21:int = 124;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_22:int = 125;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_23:int = 126;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_24:int = 127;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_25:int = 128;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_26:int = 129;
    public static const DUNGEON_RIVER_FLOOR_02_ROOM_27:int = 130;
    
    public static const DUNGEON_EBON_LABYRINTH:int = 131;
    
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_01:int = 135;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_02:int = 136;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_03:int = 137;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_04:int = 138;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_05:int = 139;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_06:int = 140;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_07:int = 141;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_08:int = 142;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_09:int = 143;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_10:int = 144;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_11:int = 145;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_12:int = 146;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_13:int = 147;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_14:int = 148;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_15:int = 149;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_16:int = 150;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_17:int = 151;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_18:int = 152;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_19:int = 153;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_20:int = 154;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_21:int = 155;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_22:int = 156;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_23:int = 157;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_24:int = 158;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_25:int = 159;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_26:int = 160;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_27:int = 161;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_28:int = 162;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_29:int = 163;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_30:int = 164;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_31:int = 165;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_32:int = 166;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_33:int = 167;
    public static const DUNGEON_RIVER_FLOOR_03_ROOM_34:int = 168;
    
    public static const DUNGEON_BEE_HIVE_1:int	= 169;
    public static const DUNGEON_BEE_HIVE_2:int	= 170;
    public static const DUNGEON_BEE_HIVE_3:int	= 171;
    public static const DUNGEON_BEE_HIVE_4:int	= 172;
    public static const DUNGEON_BEE_HIVE_5:int	= 173;

    public static const DUNGEON_LAB_ENTRANCE:int		= 174;
    public static const DUNGEON_LAB_BALLROOM_1:int		= 175;
    public static const DUNGEON_LAB_TYRANT_1:int		= 176;
    public static const DUNGEON_LAB_TYRANT_PRISON:int	= 177;
    public static const DUNGEON_LAB_TYRANT_2:int		= 178;
    public static const DUNGEON_LAB_BALLROOM_2:int		= 179;
    public static const DUNGEON_LAB_FSPREADER:int		= 180;
    public static const DUNGEON_LAB_INCEL:int			= 181;
    public static const DUNGEON_LAB_BALLROOM_3:int		= 182;
    public static const DUNGEON_LAB_NIGHTWALKER_1:int	= 183;
    public static const DUNGEON_LAB_NIGHTWALKER_2:int	= 184;
    public static const DUNGEON_LAB_PANIC_ROOM:int		= 185;
	
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_01:int = 186;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_02:int = 187;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_03:int = 188;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_04:int = 189;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_05:int = 190;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_06:int = 191;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_07:int = 192;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_08:int = 193;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_09:int = 194;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_10:int = 195;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_11:int = 196;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_12:int = 197;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_13:int = 198;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_14:int = 199;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_15:int = 200;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_16:int = 201;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_17:int = 202;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_18:int = 203;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_19:int = 204;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_20:int = 205;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_21:int = 206;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_22:int = 207;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_23:int = 208;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_24:int = 209;
    public static const DUNGEON_RIVER_FLOOR_04_ROOM_25:int = 210;
	
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_01:int = 211;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_02:int = 212;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_03:int = 213;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_04:int = 214;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_05:int = 215;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_06:int = 216;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_07:int = 217;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_08:int = 218;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_09:int = 219;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_10:int = 220;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_11:int = 221;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_12:int = 222;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_13:int = 223;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_14:int = 224;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_15:int = 225;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_16:int = 226;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_17:int = 227;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_18:int = 228;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_19:int = 229;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_20:int = 230;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_21:int = 231;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_22:int = 232;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_23:int = 233;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_24:int = 234;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_25:int = 235;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_26:int = 236;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_27:int = 237;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_28:int = 238;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_29:int = 239;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_30:int = 240;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_31:int = 241;
    public static const DUNGEON_RIVER_FLOOR_05_ROOM_32:int = 242;
	
    public static const DUNGEON_TWILIGHT_GROVE_1:int	= 132;
    public static const DUNGEON_TWILIGHT_GROVE_2:int	= 133;
    public static const DUNGEON_TWILIGHT_GROVE_3:int	= 134;
    public static const DUNGEON_TWILIGHT_GROVE_4:int	= 243;
    public static const DUNGEON_TWILIGHT_GROVE_5:int	= 244;
    public static const DUNGEON_TWILIGHT_GROVE_6:int	= 245;
	
    public static const DUNGEON_RIVER_FLOOR_06_ROOM_01:int = 246;
    public static const DUNGEON_RIVER_FLOOR_06_ROOM_02:int = 247;
    public static const DUNGEON_RIVER_FLOOR_06_ROOM_03:int = 248;
    public static const DUNGEON_RIVER_FLOOR_06_ROOM_04:int = 249;
    public static const DUNGEON_RIVER_FLOOR_06_ROOM_05:int = 250;
    public static const DUNGEON_RIVER_FLOOR_06_ROOM_06:int = 251;
}
}