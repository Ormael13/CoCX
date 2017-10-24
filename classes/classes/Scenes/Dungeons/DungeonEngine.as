package classes.Scenes.Dungeons 
{
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
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
		
		//Register dungeons
		public var factory:Factory = new Factory;
		public var deepcave:DeepCave = new DeepCave;
		public var desertcave:DesertCave = new DesertCave;
		public var heltower:HelDungeon = new HelDungeon;
		public var cabin:YourCabin = new YourCabin;
		public var hiddencave:HiddenCave = new HiddenCave();
		public var denofdesire:DenOfDesire = new DenOfDesire();
		
		public var map:DungeonMap = new DungeonMap;
		
		public function DungeonEngine() {}
		
		public function checkRoom():void
		{
			//Cabin
			if (kGAMECLASS.dungeonLoc == -10) cabin.enterCabin();
			//Factory
			if (kGAMECLASS.dungeonLoc == DUNGEON_FACTORY_FOYER) factory.roomLobby();
			if (kGAMECLASS.dungeonLoc == DUNGEON_FACTORY_BREAK_ROOM) factory.roomBreakRoom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_FACTORY_PUMP_ROOM) factory.roomPumpRoom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_FACTORY_FURNACE_ROOM) factory.roomFurnaceRoom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_FACTORY_REPAIR_CLOSET) factory.roomRepairCloset();
			if (kGAMECLASS.dungeonLoc == DUNGEON_FACTORY_MAIN_CHAMBER) factory.roomMainChamber();
			if (kGAMECLASS.dungeonLoc == DUNGEON_FACTORY_FOREMANS_OFFICE) factory.roomForemanOffice();
			if (kGAMECLASS.dungeonLoc == DUNGEON_FACTORY_PUMP_CONTROL) factory.roomControlRoom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_FACTORY_STORE_ROOM) factory.roomPremiumStorage();
			if (kGAMECLASS.dungeonLoc == DUNGEON_FACTORY_BATHROOM) factory.roomBathroom();
			//Deep Cave
			if (kGAMECLASS.dungeonLoc == DUNGEON_CAVE_ENTRANCE) deepcave.roomEntrance();
			if (kGAMECLASS.dungeonLoc == DUNGEON_CAVE_TUNNEL) deepcave.roomTunnel();
			if (kGAMECLASS.dungeonLoc == DUNGEON_CAVE_GATHERING_HALL) deepcave.roomGatheringHall();
			if (kGAMECLASS.dungeonLoc == DUNGEON_CAVE_FUNGUS_CAVERN) deepcave.roomFungusCavern();
			if (kGAMECLASS.dungeonLoc == DUNGEON_CAVE_TORTURE_ROOM) deepcave.roomTortureRoom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_CAVE_SECRET_TUNNEL) deepcave.roomSecretPassage();
			if (kGAMECLASS.dungeonLoc == DUNGEON_CAVE_ZETAZ_CHAMBER) deepcave.roomZetazChamber();
			//Tower of the Phoenix (Helia's Quest)
			if (kGAMECLASS.dungeonLoc == DUNGEON_HEL_GUARD_HALL) heltower.roomGuardHall();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HEL_WINE_CELLAR) heltower.roomCellar();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HEL_STAIR_WELL) heltower.roomStairwell();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HEL_DUNGEON) heltower.roomDungeon();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HEL_MEZZANINE) heltower.roomMezzanine();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HEL_THRONE_ROOM) heltower.roomThroneRoom();
			//Desert Cave
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_ENTRANCE_GATEWAY) desertcave.roomEntrance();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_CAVERNOUS_COMMONS) desertcave.roomCaveCommons();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_WEST_WARRENS_MAIN) desertcave.roomWestHall1();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_CHILDRENS_PLAYROOM) desertcave.roomPlayRoom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_PREGNANT_LUST_ROOM) desertcave.roomLustRoom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_WEST_WARRENS_WEST) desertcave.roomWestHall2();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_NURSERY) desertcave.roomNursery();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_PHARMACY) desertcave.roomPharmacy();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_EAST_WARRENS_MAIN) desertcave.roomEastHall1();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_SLEEPING_CHAMBER) desertcave.roomSleepingChamber();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_BATH_ROOM) desertcave.roomBathroom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_EAST_WARRENS_EAST) desertcave.roomEastHall2();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_CUM_WITCH_BEDROOM) desertcave.roomCumWitchBedroom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_CUM_WITCH_OFFICE) desertcave.roomCumWitchOffice();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_SACRIFICIAL_ALTAR) desertcave.roomSacrificalAltar();
			if (kGAMECLASS.dungeonLoc == DUNGEON_WITCH_THRONE_ROOM) desertcave.roomSandMotherThrone();
			//Hidden Cave
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_ENTRANCE) hiddencave.roomEntrance();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_SE_UP) hiddencave.roomSEUP();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_E_UP) hiddencave.roomEUP();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_NE_UP) hiddencave.roomNEUP();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_N_UP) hiddencave.roomNUP();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_S_STAIRCASE) hiddencave.roomSStaircase();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_S_UP) hiddencave.roomSUP();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_S_STORAGE) hiddencave.roomSStorage();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_NW_UP) hiddencave.roomNWUP();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_W_UP) hiddencave.roomWUP();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_SW_UP) hiddencave.roomSWUP();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_NARROW_T_E) hiddencave.roomNTE();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_NARROW_T) hiddencave.roomNT();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_NARROW_T_N) hiddencave.roomNTN();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_L_STORAGE_W) hiddencave.roomLStorageW();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_L_STORAGE_E) hiddencave.roomLStorageE();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_S_STAIRCASE_B) hiddencave.roomSStaircaseB();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_TUNNEL_00) hiddencave.roomTunnel00();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_TUNNEL_01) hiddencave.roomTunnel01();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_TUNNEL_02) hiddencave.roomTunnel02();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_TEDS_LAIR) hiddencave.roomTedsLair();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_SMALL_CAVE_W) hiddencave.roomSmallCaveW();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_MEDIUM_CAVE) hiddencave.roomMediumCave();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_SMALL_CAVE_E) hiddencave.roomSmallCaveE();
			if (kGAMECLASS.dungeonLoc == DUNGEON_HIDDEN_CAVE_SMALL_CAVE_N) hiddencave.roomSmallCaveN();
			//Den of Desire
			if (kGAMECLASS.dungeonLoc == DUNGEON_DEN_OF_DESIRE_ENTRANCE) denofdesire.roomEntrance();
			if (kGAMECLASS.dungeonLoc == DUNGEON_DEN_OF_DESIRE_GREAT_HALL_AREA) denofdesire.roomGreatHallArea();
			if (kGAMECLASS.dungeonLoc == DUNGEON_DEN_OF_DESIRE_LABORATORY) denofdesire.roomLaboratory();
			if (kGAMECLASS.dungeonLoc == DUNGEON_DEN_OF_DESIRE_HERO_SLAYER_OMNIBUS) denofdesire.roomHeroSlayerOmnibusRoom();
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
			return (flags[kFLAGS.HIDDEN_CAVE_BOSSES] > 1 && flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] > 4 && flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] > 7);
		}
		public function checkDenOfDesireClear():Boolean {
			return (flags[kFLAGS.DEN_OF_DESIRE_QUEST] > 1 && flags[kFLAGS.DEN_OF_DESIRE_BOSSES] > 2);
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
		
		public function navigateToRoom(room:Function = null, timeToPass:Number = 1/12):void {
			cheatTime(timeToPass);
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
            addButton(13, "Inventory", inventory.inventoryMenu).hint("The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
			addButton(14, "Map", map.displayMap).hint("View the map of this dungeon.");
			setTopButtons();
		}
		
	}

}