package classes.Scenes.Dungeons 
{
import classes.BaseContent;
import classes.StatusEffects;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

import coc.view.MainView;

public class DungeonEngine extends BaseContent
	{
		//Dungeon constants
		private static const DUNGEON_FACTORY_FOYER:int				= 0;
		private static const DUNGEON_FACTORY_BREAK_ROOM:int			= 1;
		private static const DUNGEON_FACTORY_PUMP_ROOM:int			= 2;
		private static const DUNGEON_FACTORY_FURNACE_ROOM:int		= 3;
		private static const DUNGEON_FACTORY_REPAIR_CLOSET:int		= 4;
		private static const DUNGEON_FACTORY_MAIN_CHAMBER:int		= 5;
		private static const DUNGEON_FACTORY_FOREMANS_OFFICE:int	= 6;
		private static const DUNGEON_FACTORY_PUMP_CONTROL:int		= 7;
		private static const DUNGEON_FACTORY_STORE_ROOM:int			= 8;
		private static const DUNGEON_FACTORY_BATHROOM:int			= 9;
		
		private static const DUNGEON_CAVE_ENTRANCE:int			= 10;
		private static const DUNGEON_CAVE_TUNNEL:int			= 11;
		private static const DUNGEON_CAVE_GATHERING_HALL:int	= 12;
		private static const DUNGEON_CAVE_FUNGUS_CAVERN:int		= 13;
		private static const DUNGEON_CAVE_TORTURE_ROOM:int		= 14;
		private static const DUNGEON_CAVE_SECRET_TUNNEL:int		= 15;
		private static const DUNGEON_CAVE_ZETAZ_CHAMBER:int		= 16;
		
		private static const DUNGEON_HEL_GUARD_HALL:int		= 17;
		private static const DUNGEON_HEL_WINE_CELLAR:int	= 18;
		private static const DUNGEON_HEL_STAIR_WELL:int		= 19;
		private static const DUNGEON_HEL_DUNGEON:int		= 20;
		private static const DUNGEON_HEL_MEZZANINE:int		= 21;
		private static const DUNGEON_HEL_THRONE_ROOM:int	= 22;
		
		private static const DUNGEON_WITCH_ENTRANCE_GATEWAY:int		= 23;
		private static const DUNGEON_WITCH_CAVERNOUS_COMMONS:int	= 24;
		private static const DUNGEON_WITCH_WEST_WARRENS_MAIN:int	= 25;
		private static const DUNGEON_WITCH_CHILDRENS_PLAYROOM:int	= 26;
		private static const DUNGEON_WITCH_PREGNANT_LUST_ROOM:int	= 27;
		private static const DUNGEON_WITCH_WEST_WARRENS_WEST:int	= 28;
		private static const DUNGEON_WITCH_NURSERY:int				= 29;
		private static const DUNGEON_WITCH_PHARMACY:int				= 30;
		private static const DUNGEON_WITCH_EAST_WARRENS_MAIN:int	= 31;
		private static const DUNGEON_WITCH_SLEEPING_CHAMBER:int		= 32;
		private static const DUNGEON_WITCH_BATH_ROOM:int			= 33;
		private static const DUNGEON_WITCH_EAST_WARRENS_EAST:int	= 34;
		private static const DUNGEON_WITCH_CUM_WITCH_BEDROOM:int	= 35;
		private static const DUNGEON_WITCH_CUM_WITCH_OFFICE:int		= 36;
		private static const DUNGEON_WITCH_SACRIFICIAL_ALTAR:int	= 37;
		private static const DUNGEON_WITCH_THRONE_ROOM:int			= 38;
		
		private static const DUNGEON_HIDDEN_CAVE_ENTRANCE:int		= 39;
		private static const DUNGEON_HIDDEN_CAVE_SE_UP:int			= 40;
		private static const DUNGEON_HIDDEN_CAVE_E_UP:int			= 41;
		private static const DUNGEON_HIDDEN_CAVE_NE_UP:int			= 42;
		private static const DUNGEON_HIDDEN_CAVE_N_UP:int			= 43;
		private static const DUNGEON_HIDDEN_CAVE_S_STAIRCASE:int	= 44;
		private static const DUNGEON_HIDDEN_CAVE_S_UP:int			= 45;
		private static const DUNGEON_HIDDEN_CAVE_S_STORAGE:int		= 46;
		private static const DUNGEON_HIDDEN_CAVE_NW_UP:int			= 47;
		private static const DUNGEON_HIDDEN_CAVE_W_UP:int			= 48;
		private static const DUNGEON_HIDDEN_CAVE_SW_UP:int			= 49;
		private static const DUNGEON_HIDDEN_CAVE_NARROW_T_E:int		= 50;
		private static const DUNGEON_HIDDEN_CAVE_NARROW_T  :int		= 51;
		private static const DUNGEON_HIDDEN_CAVE_NARROW_T_N:int		= 52;
		private static const DUNGEON_HIDDEN_CAVE_L_STORAGE_W:int	= 53;
		private static const DUNGEON_HIDDEN_CAVE_L_STORAGE_E:int	= 54;
		private static const DUNGEON_HIDDEN_CAVE_S_STAIRCASE_B:int	= 55;
		private static const DUNGEON_HIDDEN_CAVE_TUNNEL_00:int  	= 56;
		private static const DUNGEON_HIDDEN_CAVE_TUNNEL_01:int  	= 57;
		private static const DUNGEON_HIDDEN_CAVE_TUNNEL_02:int  	= 58;
		private static const DUNGEON_HIDDEN_CAVE_TEDS_LAIR:int   	= 59;
		private static const DUNGEON_HIDDEN_CAVE_SMALL_CAVE_W:int  	= 60;
		private static const DUNGEON_HIDDEN_CAVE_MEDIUM_CAVE:int  	= 61;
		private static const DUNGEON_HIDDEN_CAVE_SMALL_CAVE_E:int  	= 62;
		private static const DUNGEON_HIDDEN_CAVE_SMALL_CAVE_N:int  	= 63;
		
		private static const DUNGEON_DEN_OF_DESIRE_ENTRANCE:int  			= 64;
		private static const DUNGEON_DEN_OF_DESIRE_GREAT_HALL_AREA:int  	= 65;
		private static const DUNGEON_DEN_OF_DESIRE_LABORATORY:int  			= 66;
		private static const DUNGEON_DEN_OF_DESIRE_HERO_SLAYER_OMNIBUS:int  = 67;
		
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_01:int  = 68;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_02:int  = 69;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_03:int  = 70;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_04:int  = 71;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_05:int  = 72;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_06:int  = 73;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_07:int  = 74;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_08:int  = 75;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_09:int  = 76;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_10:int  = 77;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_11:int  = 78;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_12:int  = 79;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_13:int  = 80;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_14:int  = 81;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_15:int  = 82;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_16:int  = 83;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_17:int  = 84;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_18:int  = 85;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_19:int  = 86;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_20:int  = 87;
		
		private static const DUNGEON_ANZU_OUTSIDE:int			= 88;
		private static const DUNGEON_ANZU_HALL_FLOOR1:int 		= 89;
		private static const DUNGEON_ANZU_LIVING_ROOM:int 		= 90;
		private static const DUNGEON_ANZU_BATHROOM:int 			= 91;
		private static const DUNGEON_ANZU_DINING_ROOM:int 		= 92;
		private static const DUNGEON_ANZU_KITCHEN:int 			= 93;
		private static const DUNGEON_ANZU_HALL_FLOOR2:int		= 94;
		private static const DUNGEON_ANZU_BEDROOM:int 			= 95;
		private static const DUNGEON_ANZU_LIBRARY:int 			= 96;
		private static const DUNGEON_ANZU_MULTIUSE_ROOM:int 	= 97;
		private static const DUNGEON_ANZU_HALL_FLOOR3:int 		= 98;
		private static const DUNGEON_ANZU_PALACE_VAULTS:int 	= 99;
		private static const DUNGEON_ANZU_ALCHEMY_ROOM:int 		= 100;
		private static const DUNGEON_ANZU_ROOF:int 				= 101;
		private static const DUNGEON_ANZU_BASEMENT:int 			= 102;
		private static const DUNGEON_ANZU_ARMORY:int 			= 103;
		
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_01:int = 104;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_02:int = 105;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_03:int = 106;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_04:int = 107;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_05:int = 108;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_06:int = 109;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_07:int = 110;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_08:int = 111;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_09:int = 112;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_10:int = 113;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_11:int = 114;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_12:int = 115;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_13:int = 116;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_14:int = 117;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_15:int = 118;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_16:int = 119;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_17:int = 120;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_18:int = 121;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_19:int = 122;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_20:int = 123;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_21:int = 124;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_22:int = 125;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_23:int = 126;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_24:int = 127;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_25:int = 128;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_26:int = 129;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_27:int = 130;
		
		private static const DUNGEON_EBON_LABYRINTH_0:int	= 131;
		private static const DUNGEON_EBON_LABYRINTH_1:int	= 132;
		private static const DUNGEON_EBON_LABYRINTH_2:int	= 133;
		private static const DUNGEON_EBON_LABYRINTH_3:int	= 134;
		
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_01:int = 135;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_02:int = 136;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_03:int = 137;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_04:int = 138;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_05:int = 139;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_06:int = 140;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_07:int = 141;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_08:int = 142;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_09:int = 143;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_10:int = 144;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_11:int = 145;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_12:int = 146;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_13:int = 147;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_14:int = 148;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_15:int = 149;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_16:int = 150;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_17:int = 151;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_18:int = 152;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_19:int = 153;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_20:int = 154;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_21:int = 155;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_22:int = 156;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_23:int = 157;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_24:int = 158;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_25:int = 159;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_26:int = 160;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_27:int = 161;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_28:int = 162;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_29:int = 163;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_30:int = 164;
		/*
		private static const DUNGEON_BEE_HIVE_ENTRANCE:int	= 165;
		private static const DUNGEON_BEE_HIVE_1:int	= 166;
		private static const DUNGEON_BEE_HIVE_2:int	= 167;
		private static const DUNGEON_BEE_HIVE_3:int	= 168;
		private static const DUNGEON_BEE_HIVE_4:int	= 169;
		private static const DUNGEON_BEE_HIVE_5:int	= 170;
		*/
		//Register dungeons
		public var factory:Factory = new Factory;
		public var deepcave:DeepCave = new DeepCave;
		public var desertcave:DesertCave = new DesertCave;
		public var heltower:HelDungeon = new HelDungeon;
		public var cabin:YourCabin = new YourCabin;
		public var riverdungeon:RiverDungeon = new RiverDungeon();
		public var hiddencave:HiddenCave = new HiddenCave();
		public var denofdesire:DenOfDesire = new DenOfDesire();
		public var anzupalace:AnzuPalace = new AnzuPalace();
		public var ebonlabyrinth:EbonLabyrinth = new EbonLabyrinth;
		public var beehive:BeeHive = new BeeHive;
		
		public var map:DungeonMap = new DungeonMap;
		
		public function DungeonEngine() {}
		
		public function checkRoom():void
		{
			//Cabin
			if (DungeonAbstractContent.dungeonLoc == -10) cabin.enterCabin();
			//Factory
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_FOYER) factory.roomLobby();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_BREAK_ROOM) factory.roomBreakRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_PUMP_ROOM) factory.roomPumpRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_FURNACE_ROOM) factory.roomFurnaceRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_REPAIR_CLOSET) factory.roomRepairCloset();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_MAIN_CHAMBER) factory.roomMainChamber();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_FOREMANS_OFFICE) factory.roomForemanOffice();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_PUMP_CONTROL) factory.roomControlRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_STORE_ROOM) factory.roomPremiumStorage();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_BATHROOM) factory.roomBathroom();
			//Deep Cave
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_ENTRANCE) deepcave.roomEntrance();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_TUNNEL) deepcave.roomTunnel();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_GATHERING_HALL) deepcave.roomGatheringHall();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_FUNGUS_CAVERN) deepcave.roomFungusCavern();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_TORTURE_ROOM) deepcave.roomTortureRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_SECRET_TUNNEL) deepcave.roomSecretPassage();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_ZETAZ_CHAMBER) deepcave.roomZetazChamber();
			//Tower of the Phoenix (Helia's Quest)
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HEL_GUARD_HALL) heltower.roomGuardHall();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HEL_WINE_CELLAR) heltower.roomCellar();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HEL_STAIR_WELL) heltower.roomStairwell();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HEL_DUNGEON) heltower.roomDungeon();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HEL_MEZZANINE) heltower.roomMezzanine();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HEL_THRONE_ROOM) heltower.roomThroneRoom();
			//Desert Cave
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_ENTRANCE_GATEWAY) desertcave.roomEntrance();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_CAVERNOUS_COMMONS) desertcave.roomCaveCommons();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_WEST_WARRENS_MAIN) desertcave.roomWestHall1();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_CHILDRENS_PLAYROOM) desertcave.roomPlayRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_PREGNANT_LUST_ROOM) desertcave.roomLustRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_WEST_WARRENS_WEST) desertcave.roomWestHall2();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_NURSERY) desertcave.roomNursery();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_PHARMACY) desertcave.roomPharmacy();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_EAST_WARRENS_MAIN) desertcave.roomEastHall1();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_SLEEPING_CHAMBER) desertcave.roomSleepingChamber();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_BATH_ROOM) desertcave.roomBathroom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_EAST_WARRENS_EAST) desertcave.roomEastHall2();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_CUM_WITCH_BEDROOM) desertcave.roomCumWitchBedroom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_CUM_WITCH_OFFICE) desertcave.roomCumWitchOffice();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_SACRIFICIAL_ALTAR) desertcave.roomSacrificalAltar();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_THRONE_ROOM) desertcave.roomSandMotherThrone();
			//Hidden Cave
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_ENTRANCE) hiddencave.roomEntrance();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_SE_UP) hiddencave.roomSEUP();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_E_UP) hiddencave.roomEUP();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_NE_UP) hiddencave.roomNEUP();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_N_UP) hiddencave.roomNUP();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_S_STAIRCASE) hiddencave.roomSStaircase();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_S_UP) hiddencave.roomSUP();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_S_STORAGE) hiddencave.roomSStorage();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_NW_UP) hiddencave.roomNWUP();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_W_UP) hiddencave.roomWUP();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_SW_UP) hiddencave.roomSWUP();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_NARROW_T_E) hiddencave.roomNTE();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_NARROW_T) hiddencave.roomNT();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_NARROW_T_N) hiddencave.roomNTN();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_L_STORAGE_W) hiddencave.roomLStorageW();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_L_STORAGE_E) hiddencave.roomLStorageE();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_S_STAIRCASE_B) hiddencave.roomSStaircaseB();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_TUNNEL_00) hiddencave.roomTunnel00();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_TUNNEL_01) hiddencave.roomTunnel01();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_TUNNEL_02) hiddencave.roomTunnel02();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_TEDS_LAIR) hiddencave.roomTedsLair();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_SMALL_CAVE_W) hiddencave.roomSmallCaveW();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_MEDIUM_CAVE) hiddencave.roomMediumCave();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_SMALL_CAVE_E) hiddencave.roomSmallCaveE();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HIDDEN_CAVE_SMALL_CAVE_N) hiddencave.roomSmallCaveN();
			//River Dungeon 1st floor
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_01) riverdungeon.roomA01();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_02) riverdungeon.roomA02();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_03) riverdungeon.roomA03();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_04) riverdungeon.roomA04();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_05) riverdungeon.roomA05();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_06) riverdungeon.roomA06();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_07) riverdungeon.roomA07();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_08) riverdungeon.roomA08();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_09) riverdungeon.roomA09();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_10) riverdungeon.roomA10();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_11) riverdungeon.roomA11();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_12) riverdungeon.roomA12();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_13) riverdungeon.roomA13();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_14) riverdungeon.roomA14();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_15) riverdungeon.roomA15();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_16) riverdungeon.roomA16();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_17) riverdungeon.roomA17();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_18) riverdungeon.roomA18();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_19) riverdungeon.roomA19();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_20) riverdungeon.roomA20();
			//River Dungeon 2nd floor
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_01) riverdungeon.roomB01();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_02) riverdungeon.roomB02();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_03) riverdungeon.roomB03();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_04) riverdungeon.roomB04();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_05) riverdungeon.roomB05();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_06) riverdungeon.roomB06();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_07) riverdungeon.roomB07();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_08) riverdungeon.roomB08();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_09) riverdungeon.roomB09();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_10) riverdungeon.roomB10();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_11) riverdungeon.roomB11();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_12) riverdungeon.roomB12();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_13) riverdungeon.roomB13();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_14) riverdungeon.roomB14();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_15) riverdungeon.roomB15();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_16) riverdungeon.roomB16();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_17) riverdungeon.roomB17();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_18) riverdungeon.roomB18();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_19) riverdungeon.roomB19();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_20) riverdungeon.roomB20();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_21) riverdungeon.roomB21();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_22) riverdungeon.roomB22();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_23) riverdungeon.roomB23();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_24) riverdungeon.roomB24();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_25) riverdungeon.roomB25();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_26) riverdungeon.roomB26();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_27) riverdungeon.roomB27();
			//River Dungeon 3rd floor
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_01) riverdungeon.roomC01();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_02) riverdungeon.roomC02();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_03) riverdungeon.roomC03();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_04) riverdungeon.roomC04();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_05) riverdungeon.roomC05();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_06) riverdungeon.roomC06();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_07) riverdungeon.roomC07();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_08) riverdungeon.roomC08();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_09) riverdungeon.roomC09();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_10) riverdungeon.roomC10();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_11) riverdungeon.roomC11();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_12) riverdungeon.roomC12();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_13) riverdungeon.roomC13();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_14) riverdungeon.roomC14();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_15) riverdungeon.roomC15();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_16) riverdungeon.roomC16();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_17) riverdungeon.roomC17();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_18) riverdungeon.roomC18();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_19) riverdungeon.roomC19();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_20) riverdungeon.roomC20();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_21) riverdungeon.roomC21();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_22) riverdungeon.roomC22();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_23) riverdungeon.roomC23();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_24) riverdungeon.roomC24();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_25) riverdungeon.roomC25();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_26) riverdungeon.roomC26();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_27) riverdungeon.roomC27();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_28) riverdungeon.roomC28();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_29) riverdungeon.roomC29();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_30) riverdungeon.roomC30();
			//River Dungeon 4th floor
			//Den of Desire
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_DEN_OF_DESIRE_ENTRANCE) denofdesire.roomEntrance();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_DEN_OF_DESIRE_GREAT_HALL_AREA) denofdesire.roomGreatHallArea();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_DEN_OF_DESIRE_LABORATORY) denofdesire.roomLaboratory();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_DEN_OF_DESIRE_HERO_SLAYER_OMNIBUS) denofdesire.roomHeroSlayerOmnibusRoom();
			//Anzu's Palace
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_OUTSIDE) anzupalace.roomEntrance();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_HALL_FLOOR1) anzupalace.roomFoyer();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_LIVING_ROOM) anzupalace.roomLivingRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_BATHROOM) anzupalace.roomBathroom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_DINING_ROOM) anzupalace.roomDiningRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_KITCHEN) anzupalace.roomKitchen();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_HALL_FLOOR2) anzupalace.roomHallFloor2();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_BEDROOM) anzupalace.roomBedroom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_LIBRARY) anzupalace.roomLibrary();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_MULTIUSE_ROOM) anzupalace.roomMultiuse();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_HALL_FLOOR3) anzupalace.roomHallFloor3();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_PALACE_VAULTS) anzupalace.roomVault();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_ALCHEMY_ROOM) anzupalace.roomAlchemyRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_ROOF) anzupalace.roomRoof();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_BASEMENT) anzupalace.roomBasement();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_ARMORY) anzupalace.roomArmory();
			//Ebon Labyrinth
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_EBON_LABYRINTH_0) ebonlabyrinth.roomAAA();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_EBON_LABYRINTH_1) ebonlabyrinth.roomBBB();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_EBON_LABYRINTH_2) ebonlabyrinth.roomCCC();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_EBON_LABYRINTH_3) ebonlabyrinth.roomDDD();
		}
		
		public function checkFactoryClear():Boolean {
			return (flags[kFLAGS.FACTORY_SHUTDOWN] > 0 && flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED] > 0 && flags[kFLAGS.FACTORY_INCUBUS_DEFEATED] > 0 && flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] > 0);
		}
		public function checkDeepCaveClear():Boolean {
			return (flags[kFLAGS.ZETAZ_IMP_HORDE_DEFEATED] > 0 && flags[kFLAGS.ZETAZ_FUNGUS_ROOM_DEFEATED] > 0 && flags[kFLAGS.FREED_VALA] == 1 && player.hasKeyItem("Zetaz's Map") >= 0);
		}
		public function checkLethiceStrongholdClear():Boolean {
			return (flags[kFLAGS.D3_MIRRORS_SHATTERED] > 0 && flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] > 0 && flags[kFLAGS.D3_GARDENER_DEFEATED] > 0 && flags[kFLAGS.D3_CENTAUR_DEFEATED] > 0 && flags[kFLAGS.LETHICE_DEFEATED] > 0);
		}
		public function checkSandCaveClear():Boolean {
			return ((flags[kFLAGS.ESSRAYLE_ESCAPED_DUNGEON] > 0 || flags[kFLAGS.MET_ESSY] == 0) && (flags[kFLAGS.SAND_WITCHES_FRIENDLY] > 0 || flags[kFLAGS.SAND_WITCHES_COWED] > 0));
		}
		public function checkPhoenixTowerClear():Boolean {
			return (flags[kFLAGS.HARPY_QUEEN_EXECUTED] != 0 && flags[kFLAGS.HEL_HARPIES_DEFEATED] > 0 && flags[kFLAGS.HEL_PHOENIXES_DEFEATED] > 0 && flags[kFLAGS.HEL_BRIGID_DEFEATED] > 0);
		}
		public function checkHiddenCaveClear():Boolean {
			return (flags[kFLAGS.HIDDEN_CAVE_BOSSES] > 0 && flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] > 4 && flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] > 4);
		}
		public function checkHiddenCaveHiddenStageClear():Boolean {
			return (flags[kFLAGS.HIDDEN_CAVE_BOSSES] > 1 && flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] > 4 && flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] > 7);
		}
		public function checkDenOfDesireClear():Boolean {
			return (flags[kFLAGS.DEN_OF_DESIRE_BOSSES] > 2);
		}
		public function checkRiverDungeon1stFloorClear():Boolean {
			return (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 1);//1 - pokonanie 1 golema, 2 pokonanie obu golemów
		}
		public function checkRiverDungeon2ndFloorClear():Boolean {
			return (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 6);//3,4,5,6 - pokonanie każdego z sub-bossów, 7 - pokonanie chimerycznego żywiołaka
		}
		public function checkRiverDungeon3rdFloorClear():Boolean {
			return (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 8);//8 - pokonanie subbossa, 9 - pokonanie bossa
		}
		public function checkEbonLabyrinthClear():Boolean {
			return (flags[kFLAGS.EBON_LABYRINTH] > 1);//exploracja 50 pokoi bez porażki
		}
		
		public function enterFactory():void {
			factory.enterDungeon();
		}
		public function canFindDeepCave():Boolean {
			return flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] == 0
				   && flags[kFLAGS.FACTORY_SHUTDOWN] > 0;
		}
		public function enterDeepCave():void {
			deepcave.enterDungeon();
		}
		public function canFindDenOfDesire():Boolean {
			return flags[kFLAGS.GAR_NAME] != 0;
		}
		public function enterDenOfDesire():void {
			denofdesire.enterDungeon();
		}
		
		public function navigateToRoom(room:Function = null):void {
			cheatTime2(5);
			room();
		}
		public function navigateToRoomRD(room:Function = null):void {
			if (player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.removeStatusEffect(StatusEffects.ThereCouldBeOnlyOne);
			cheatTime2(5);
			room();
		}
		public function navigateToRoomEL(room:Function = null):void {
			if (player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.removeStatusEffect(StatusEffects.ThereCouldBeOnlyOne);
			player.addStatusValue(StatusEffects.EbonLabyrinthB, 1, 1);
			cheatTime2(15);
			room();
		}
		
		/**
		 * Set the top buttons for use while in dungeons.
		 */
		public function setTopButtons():void { //Set top buttons.
			mainView.showMenuButton( MainView.MENU_APPEARANCE );
			mainView.showMenuButton( MainView.MENU_PERKS );
			mainView.showMenuButton( MainView.MENU_STATS );
			mainView.hideMenuButton( MainView.MENU_DATA );
			SceneLib.camp.setLevelButton(true);
		}
		
		/**
		 * Set the buttons for use in dungeons. The parameters can be used to connect to rooms.
		 * @param	northFunction
		 * @param	southFunction
		 * @param	westFunction
		 * @param	eastFunction
		 */
		public function setDungeonButtons(northFunction:Function = null, southFunction:Function = null, westFunction:Function = null, eastFunction:Function = null):void {
			statScreenRefresh();
			hideUpDown();
			spriteSelect(-1);
			menu();
			if (northFunction != null) addButton(6, "North", navigateToRoom, northFunction);
			if (southFunction != null) addButton(11, "South", navigateToRoom, southFunction);
			if (westFunction != null) addButton(10, "West", navigateToRoom, westFunction);
			if (eastFunction != null) addButton(12, "East", navigateToRoom, eastFunction);
            if (player.lust >= 30) addButton(8, "Masturbate", SceneLib.masturbation.masturbateGo);
			else addButtonDisabled(8, "Masturbate", "Req. 30+ lust.");
            addButton(13, "Inventory", inventory.inventoryMenu).hint("The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
			addButton(14, "Map", map.displayMap).hint("View the map of this dungeon.");
			setTopButtons();
		}
		public function setDungeonButtonsRD(northFunction:Function = null, southFunction:Function = null, westFunction:Function = null, eastFunction:Function = null):void {
			statScreenRefresh();
			hideUpDown();
			spriteSelect(-1);
			menu();
			if (northFunction != null) addButton(6, "North", navigateToRoomRD, northFunction);
			if (southFunction != null) addButton(11, "South", navigateToRoomRD, southFunction);
			if (westFunction != null) addButton(10, "West", navigateToRoomRD, westFunction);
			if (eastFunction != null) addButton(12, "East", navigateToRoomRD, eastFunction);
            if (player.lust >= 30) addButton(8, "Masturbate", SceneLib.masturbation.masturbateGo);
			else addButtonDisabled(8, "Masturbate", "Req. 30+ lust.");
            addButton(13, "Inventory", inventory.inventoryMenu).hint("The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
			addButton(14, "Map", map.displayMap2).hint("View the map of this dungeon.");
			setTopButtons();
		}
		public function setDungeonButtonsRD3D(northFunction:Function = null, southFunction:Function = null, westFunction:Function = null, eastFunction:Function = null, upFunction:Function = null, downFunction:Function = null):void {
			statScreenRefresh();
			hideUpDown();
			spriteSelect(-1);
			menu();
			if (northFunction != null) addButton(6, "North", navigateToRoomRD, northFunction);
			if (southFunction != null) addButton(11, "South", navigateToRoomRD, southFunction);
			if (westFunction != null) addButton(10, "West", navigateToRoomRD, westFunction);
			if (eastFunction != null) addButton(12, "East", navigateToRoomRD, eastFunction);
            if (upFunction != null) addButton(5, "Up", navigateToRoomRD, upFunction);
			if (downFunction != null) addButton(7, "Down", navigateToRoomRD, downFunction);
            if (player.lust >= 30) addButton(8, "Masturbate", SceneLib.masturbation.masturbateGo);
			else addButtonDisabled(8, "Masturbate", "Req. 30+ lust.");
            addButton(13, "Inventory", inventory.inventoryMenu).hint("The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
			addButton(14, "Map", map.displayMap2).hint("View the map of this dungeon.");
			setTopButtons();
		}
		public function setDungeonButtonsEL(northFunction:Function = null, southFunction:Function = null, westFunction:Function = null, eastFunction:Function = null, upFunction:Function = null, downFunction:Function = null):void {
			statScreenRefresh();
			hideUpDown();
			spriteSelect(-1);
			menu();
			addButton(2, "North", navigateToRoomEL, northFunction);
			addButton(12, "South", navigateToRoomEL, southFunction);
			addButton(6, "West", navigateToRoomEL, westFunction);
			addButton(8, "East", navigateToRoomEL, eastFunction);
			addButton(1, "Up", navigateToRoomEL, upFunction);
			addButton(13, "Down", navigateToRoomEL, downFunction);
            if (model.time.hours >= 21 || model.time.hours < 6) addButton(0, "Sleep", ebonlabyrinth.doSleepEL).hint("Turn yourself in for the night. May result in monster ambush!");
			else addButtonDisabled(0, "Sleep", "It's still too early to go to sleep.");
            if (player.lust >= 30) addButton(5, "Masturbate", SceneLib.masturbation.masturbateGo);
			else addButtonDisabled(5, "Masturbate", "Req. 30+ lust.");
			addButton(9, "Inventory", inventory.inventoryMenu).hint("The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
            addButton(14, "Exit", ebonlabyrinth.exitDungeon);
			setTopButtons();
		}
		
	}

}