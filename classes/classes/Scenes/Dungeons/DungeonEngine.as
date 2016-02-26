package classes.Scenes.Dungeons 
{
	import classes.*;
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	
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
		
		//Register dungeons
		public var factory:Factory = new Factory;
		public var deepcave:DeepCave = new DeepCave;
		public var desertcave:DesertCave = new DesertCave;
		public var heltower:HelDungeon = new HelDungeon;
		public var cabin:YourCabin = new YourCabin;
		
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
		}
		
		public function checkFactoryClear():Boolean {
			return (flags[kFLAGS.FACTORY_SHUTDOWN] > 0 && flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED] > 0 && flags[kFLAGS.FACTORY_INCUBUS_DEFEATED] > 0 && flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] > 0);
		}
		public function checkDeepCaveClear():Boolean {
			return (flags[kFLAGS.ZETAZ_IMP_HORDE_DEFEATED] > 0 && flags[kFLAGS.ZETAZ_FUNGUS_ROOM_DEFEATED] > 0 && flags[kFLAGS.FREED_VALA] == 1 && player.hasKeyItem("Zetaz's Map") >= 0);
		}
		public function checkSandCaveClear():Boolean {
			return ((flags[kFLAGS.ESSRAYLE_ESCAPED_DUNGEON] > 0 || flags[kFLAGS.MET_ESSY] == 0) && (flags[kFLAGS.SAND_WITCHES_FRIENDLY] > 0 || flags[kFLAGS.SAND_WITCHES_COWED] > 0));
		}
		public function checkPhoenixTowerClear():Boolean {
			return (flags[kFLAGS.HARPY_QUEEN_EXECUTED] != 0 && flags[kFLAGS.HEL_HARPIES_DEFEATED] > 0 && flags[kFLAGS.HEL_PHOENIXES_DEFEATED] > 0 && flags[kFLAGS.HEL_BRIGID_DEFEATED] > 0);
		}
		public function checkLethiceStrongholdClear():Boolean {
			return (flags[kFLAGS.D3_MIRRORS_SHATTERED] > 0 && flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] > 0 && flags[kFLAGS.D3_GARDENER_DEFEATED] > 0 && flags[kFLAGS.D3_CENTAUR_DEFEATED] > 0 && flags[kFLAGS.LETHICE_DEFEATED] > 0);
		}
		
		public function enterFactory():void {
			factory.enterDungeon();
		}
		public function enterDeepCave():void {
			deepcave.enterDungeon();
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
			if ((player.XP >= (player.level) * 100 && player.level < kGAMECLASS.levelCap) || player.perkPoints > 0 || player.statPoints > 0) {
				if (player.XP < player.level * 100 || player.level >= kGAMECLASS.levelCap)
				{
					if (player.statPoints > 0) mainView.setMenuButton( MainView.MENU_LEVEL, "Stat Up" );
					else mainView.setMenuButton( MainView.MENU_LEVEL, "Perk Up" );
				}
				else {
					mainView.setMenuButton( MainView.MENU_LEVEL, "Level Up" );
					if (flags[kFLAGS.AUTO_LEVEL] > 0) {
						getGame().playerInfo.levelUpGo();
						return;
					}
				}
				mainView.showMenuButton( MainView.MENU_LEVEL );
				mainView.statsView.showLevelUp();
			}
			else {
				mainView.hideMenuButton( MainView.MENU_LEVEL );
				mainView.statsView.hideLevelUp();
			}
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
			if (player.lust >= 30) addButton(8, "Masturbate", getGame().masturbation.masturbateGo);
			addButton(13, "Inventory", inventory.inventoryMenu, null, null, null, "The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
			addButton(14, "Map", map.displayMap, null, null, null, "View the map of this dungeon.");
			setTopButtons();
		}
		
	}

}