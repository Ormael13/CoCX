package classes.Scenes.Dungeons 
{
	import classes.*;
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Dungeons.D3.D3;
	
	import coc.view.MainView;
	
	public class DungeonCore extends BaseContent
	{
		public var rooms:Object = {};
		public var _currentRoom:String; // I don't think we'll need to save/load this, as we're not gonna allow saving in the dungeon, and it'll be overwritten by calling enterD3();
		
		//Dungeon constants
		//Factory
		public static const DUNGEON_FACTORY_FOYER:int			=  0;
		public static const DUNGEON_FACTORY_BREAK_ROOM:int		=  1;
		public static const DUNGEON_FACTORY_PUMP_ROOM:int		=  2;
		public static const DUNGEON_FACTORY_FURNACE_ROOM:int	=  3;
		public static const DUNGEON_FACTORY_REPAIR_CLOSET:int	=  4;
		public static const DUNGEON_FACTORY_MAIN_CHAMBER:int	=  5;
		public static const DUNGEON_FACTORY_FOREMANS_OFFICE:int	=  6;
		public static const DUNGEON_FACTORY_PUMP_CONTROL:int	=  7;
		public static const DUNGEON_FACTORY_STORE_ROOM:int		=  8;
		public static const DUNGEON_FACTORY_BATHROOM:int		=  9;
		//Deep Cave
		public static const DUNGEON_CAVE_ENTRANCE:int			= 10;
		public static const DUNGEON_CAVE_TUNNEL:int				= 11;
		public static const DUNGEON_CAVE_GATHERING_HALL:int		= 12;
		public static const DUNGEON_CAVE_FUNGUS_CAVERN:int		= 13;
		public static const DUNGEON_CAVE_TORTURE_ROOM:int		= 14;
		public static const DUNGEON_CAVE_SECRET_TUNNEL:int		= 15;
		public static const DUNGEON_CAVE_ZETAZ_CHAMBER:int		= 16;
		//Phoenix Tower
		public static const DUNGEON_HEL_GUARD_HALL:int			= 17;
		public static const DUNGEON_HEL_WINE_CELLAR:int			= 18;
		public static const DUNGEON_HEL_STAIR_WELL:int			= 19;
		public static const DUNGEON_HEL_DUNGEON:int				= 20;
		public static const DUNGEON_HEL_MEZZANINE:int			= 21;
		public static const DUNGEON_HEL_THRONE_ROOM:int			= 22;
		//Desert Cave
		public static const DUNGEON_WITCH_ENTRANCE_GATEWAY:int	= 23;
		public static const DUNGEON_WITCH_CAVERNOUS_COMMONS:int	= 24;
		public static const DUNGEON_WITCH_WEST_WARRENS_MAIN:int	= 25;
		public static const DUNGEON_WITCH_CHILDRENS_PLAYROOM:int= 26;
		public static const DUNGEON_WITCH_PREGNANT_LUST_ROOM:int= 27;
		public static const DUNGEON_WITCH_WEST_WARRENS_WEST:int	= 28;
		public static const DUNGEON_WITCH_NURSERY:int			= 29;
		public static const DUNGEON_WITCH_PHARMACY:int			= 30;
		public static const DUNGEON_WITCH_EAST_WARRENS_MAIN:int	= 31;
		public static const DUNGEON_WITCH_SLEEPING_CHAMBER:int	= 32;
		public static const DUNGEON_WITCH_BATH_ROOM:int			= 33;
		public static const DUNGEON_WITCH_EAST_WARRENS_EAST:int	= 34;
		public static const DUNGEON_WITCH_CUM_WITCH_BEDROOM:int	= 35;
		public static const DUNGEON_WITCH_CUM_WITCH_OFFICE:int	= 36;
		public static const DUNGEON_WITCH_SACRIFICIAL_ALTAR:int	= 37;
		public static const DUNGEON_WITCH_THRONE_ROOM:int		= 38;
		//Anzu's Palace
		public static const DUNGEON_ANZU_OUTSIDE:int			= 39;
		public static const DUNGEON_ANZU_HALL_FLOOR1:int 		= 40;
		public static const DUNGEON_ANZU_LIVING_ROOM:int 		= 41;
		public static const DUNGEON_ANZU_BATHROOM:int 			= 42;
		public static const DUNGEON_ANZU_DINING_ROOM:int 		= 43;
		public static const DUNGEON_ANZU_KITCHEN:int 			= 44;
		public static const DUNGEON_ANZU_HALL_FLOOR2:int		= 45;
		public static const DUNGEON_ANZU_BEDROOM:int 			= 46;
		public static const DUNGEON_ANZU_LIBRARY:int 			= 47;
		public static const DUNGEON_ANZU_MULTIUSE_ROOM:int 		= 48;
		public static const DUNGEON_ANZU_HALL_FLOOR3:int 		= 49;
		public static const DUNGEON_ANZU_PALACE_VAULTS:int 		= 50;
		public static const DUNGEON_ANZU_ALCHEMY_ROOM:int 		= 51;
		public static const DUNGEON_ANZU_ROOF:int 				= 52;
		public static const DUNGEON_ANZU_BASEMENT:int 			= 53;
		public static const DUNGEON_ANZU_ARMORY:int 			= 54;
		
		public function DungeonCore() {}
		
		//Register dungeons
		public var factory:Factory = new Factory;
		public var deepcave:DeepCave = new DeepCave;
		
		public var desertcave:DesertCave = new DesertCave;
		public var heltower:HelDungeon = new HelDungeon;
		public var palace:AnzuPalace = new AnzuPalace;
		public var cabin:YourCabin = new YourCabin;
		
		public var map:DungeonMap = new DungeonMap;
		
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
			//Anzu's Palace
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_OUTSIDE) palace.roomEntrance();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_HALL_FLOOR1) palace.roomFoyer();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_LIVING_ROOM) palace.roomLivingRoom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_BATHROOM) palace.roomBathroom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_DINING_ROOM) palace.roomDiningRoom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_KITCHEN) palace.roomKitchen();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_HALL_FLOOR2) palace.roomHallFloor2();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_BEDROOM) palace.roomBedroom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_LIBRARY) palace.roomLibrary();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_MULTIUSE_ROOM) palace.roomMultiuse();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_HALL_FLOOR3) palace.roomHallFloor3();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_PALACE_VAULTS) palace.roomVault();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_ALCHEMY_ROOM) palace.roomAlchemyRoom();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_ROOF) palace.roomRoof();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_BASEMENT) palace.roomBasement();
			if (kGAMECLASS.dungeonLoc == DUNGEON_ANZU_ARMORY) palace.roomArmory();
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
		public function enterAnzuPalace():void {
			palace.enterDungeon();
		}
		
		public function navigateToRoom(room:Function = null, timeToPass:Number = 1/12):void {
			cheatTime(timeToPass);
			room();
		}
		
		/**
		 * Set the top buttons for use while in dungeons.
		 */
		public function setTopButtons():void { //Set top buttons.
			mainView.setMenuButton( MainView.MENU_NEW_MAIN, "Main Menu", kGAMECLASS.mainMenu.mainMenu );
			mainView.showMenuButton( MainView.MENU_APPEARANCE );
			mainView.showMenuButton( MainView.MENU_PERKS );
			mainView.showMenuButton( MainView.MENU_STATS );
			mainView.hideMenuButton( MainView.MENU_DATA );
			mainView.showMenuButton( MainView.MENU_NEW_MAIN );
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
			else addButtonDisabled(8, "Masturbate", "You are not horny enough to do that.");
			addButton(13, "Inventory", inventory.inventoryMenu, null, null, null, "The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
			addButton(14, "Map", map.displayMap, null, null, null, "View the map of this dungeon.");
			setTopButtons();
			palace.setAnzuButton();
		}
		
		//Dungeon 3 & Grimdark Stuff
		public function resumeFromFight():void
		{
			move(_currentRoom);
		}
		
		public function generateRoomMenu(tRoom:room):void
		{
			statScreenRefresh();
			hideUpDown();
			spriteSelect(-1);
			setTopButtons();
			if (tRoom.NorthExit != null && tRoom.NorthExit.length > 0)
			{
				if (tRoom.NorthExitCondition == null || tRoom.NorthExitCondition())
				{
					addButton(6, "North", move, tRoom.NorthExit, 1/12);
				}
			}
			
			if (tRoom.EastExit != null && tRoom.EastExit.length > 0)
			{
				if (tRoom.EastExitCondition == null || tRoom.EastExitCondition())
				{
					addButton(12, "East", move, tRoom.EastExit, 1/12);
				}
			}
			
			if (tRoom.SouthExit != null && tRoom.SouthExit.length > 0)
			{
				if (tRoom.SouthExitCondition == null || tRoom.SouthExitCondition())
				{
					addButton(11, "South", move, tRoom.SouthExit, 1/12);
				}
			}
			
			if (tRoom.WestExit != null && tRoom.WestExit.length > 0)
			{
				if (tRoom.WestExitCondition == null || tRoom.WestExitCondition())
				{
					addButton(10, "West", move, tRoom.WestExit, 1/12);
				}
			}
			
			addButton(13, "Inventory", inventory.inventoryMenu);
			addButton(14, "Map", kGAMECLASS.dungeons.map.displayMap);
			if (player.lust >= 30) addButton(8, "Masturbate", getGame().masturbation.masturbateGo);
			else addButtonDisabled(8, "Masturbate", "You are not horny enough to consider that.");
		}
		
		public function move(roomName:String, timeToPass:Number = 0):void
		{
			trace("Entering room", roomName);
			cheatTime(timeToPass);
			clearOutput();
			
			if (rooms[roomName] == undefined)
			{
				clearOutput();
				outputText("Error: Couldn't find the room indexed as: " + roomName);
				menu();
				return;
			}
			
			var tRoom:room = rooms[roomName];
			
			if (tRoom.RoomFunction == null)
			{
				outputText("Error: Room entry function for room indexed as '" + roomName + "' was not set.");
				return;
			}
			
			menu();
			
			if (!tRoom.RoomFunction())
			{
				generateRoomMenu(tRoom);
			}
			
			_currentRoom = roomName;
		}
	}

}