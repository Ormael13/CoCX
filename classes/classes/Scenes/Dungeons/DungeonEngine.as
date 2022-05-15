package classes.Scenes.Dungeons 
{
import classes.StatusEffects;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

import coc.view.MainView;

//now derived to keep easy access to variables
public class DungeonEngine extends DungeonAbstractContent {
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
    
    public function getRoomFunc(dungeonLoc:int):Function {
        switch(dungeonLoc) {
            //Cabin
            case DUNGEON_CABIN: return cabin.enterCabin;
            //Factory
            case DUNGEON_FACTORY_FOYER:             return factory.roomLobby;
            case DUNGEON_FACTORY_BREAK_ROOM:        return factory.roomBreakRoom;
            case DUNGEON_FACTORY_PUMP_ROOM:         return factory.roomPumpRoom;
            case DUNGEON_FACTORY_FURNACE_ROOM:      return factory.roomFurnaceRoom;
            case DUNGEON_FACTORY_REPAIR_CLOSET:     return factory.roomRepairCloset;
            case DUNGEON_FACTORY_MAIN_CHAMBER:      return factory.roomMainChamber;
            case DUNGEON_FACTORY_FOREMANS_OFFICE:   return factory.roomForemanOffice;
            case DUNGEON_FACTORY_PUMP_CONTROL:      return factory.roomControlRoom;
            case DUNGEON_FACTORY_STORE_ROOM:        return factory.roomPremiumStorage;
            case DUNGEON_FACTORY_BATHROOM:          return factory.roomBathroom;
            //Deep Cave
            case DUNGEON_CAVE_ENTRANCE:         return deepcave.roomEntrance;
            case DUNGEON_CAVE_TUNNEL:           return deepcave.roomTunnel;
            case DUNGEON_CAVE_GATHERING_HALL:   return deepcave.roomGatheringHall;
            case DUNGEON_CAVE_FUNGUS_CAVERN:    return deepcave.roomFungusCavern;
            case DUNGEON_CAVE_TORTURE_ROOM:     return deepcave.roomTortureRoom;
            case DUNGEON_CAVE_SECRET_TUNNEL:    return deepcave.roomSecretPassage;
            case DUNGEON_CAVE_ZETAZ_CHAMBER:    return deepcave.roomZetazChamber;
            //Tower of the Phoenix (Helia's Quest)
            case DUNGEON_HEL_GUARD_HALL:    return heltower.roomGuardHall;
            case DUNGEON_HEL_WINE_CELLAR:   return heltower.roomCellar;
            case DUNGEON_HEL_STAIR_WELL:    return heltower.roomStairwell;
            case DUNGEON_HEL_DUNGEON:       return heltower.roomDungeon;
            case DUNGEON_HEL_MEZZANINE:     return heltower.roomMezzanine;
            case DUNGEON_HEL_THRONE_ROOM:   return heltower.roomThroneRoom;
            //Desert Cave
            case DUNGEON_WITCH_ENTRANCE_GATEWAY:    return desertcave.roomEntrance;
            case DUNGEON_WITCH_CAVERNOUS_COMMONS:   return desertcave.roomCaveCommons;
            case DUNGEON_WITCH_WEST_WARRENS_MAIN:   return desertcave.roomWestHall1;
            case DUNGEON_WITCH_CHILDRENS_PLAYROOM:  return desertcave.roomPlayRoom;
            case DUNGEON_WITCH_PREGNANT_LUST_ROOM:  return desertcave.roomLustRoom;
            case DUNGEON_WITCH_WEST_WARRENS_WEST:   return desertcave.roomWestHall2;
            case DUNGEON_WITCH_NURSERY:             return desertcave.roomNursery;
            case DUNGEON_WITCH_PHARMACY:            return desertcave.roomPharmacy;
            case DUNGEON_WITCH_EAST_WARRENS_MAIN:   return desertcave.roomEastHall1;
            case DUNGEON_WITCH_SLEEPING_CHAMBER:    return desertcave.roomSleepingChamber;
            case DUNGEON_WITCH_BATH_ROOM:           return desertcave.roomBathroom;
            case DUNGEON_WITCH_EAST_WARRENS_EAST:   return desertcave.roomEastHall2;
            case DUNGEON_WITCH_CUM_WITCH_BEDROOM:   return desertcave.roomCumWitchBedroom;
            case DUNGEON_WITCH_CUM_WITCH_OFFICE:    return desertcave.roomCumWitchOffice;
            case DUNGEON_WITCH_SACRIFICIAL_ALTAR:   return desertcave.roomSacrificalAltar;
            case DUNGEON_WITCH_THRONE_ROOM:         return desertcave.roomSandMotherThrone;
            //Hidden Cave
            case DUNGEON_HIDDEN_CAVE_ENTRANCE:      return hiddencave.roomEntrance;
            case DUNGEON_HIDDEN_CAVE_SE_UP:         return hiddencave.roomSEUP;
            case DUNGEON_HIDDEN_CAVE_E_UP:          return hiddencave.roomEUP;
            case DUNGEON_HIDDEN_CAVE_NE_UP:         return hiddencave.roomNEUP;
            case DUNGEON_HIDDEN_CAVE_N_UP:          return hiddencave.roomNUP;
            case DUNGEON_HIDDEN_CAVE_S_STAIRCASE:   return hiddencave.roomSStaircase;
            case DUNGEON_HIDDEN_CAVE_S_UP:          return hiddencave.roomSUP;
            case DUNGEON_HIDDEN_CAVE_S_STORAGE:     return hiddencave.roomSStorage;
            case DUNGEON_HIDDEN_CAVE_NW_UP:         return hiddencave.roomNWUP;
            case DUNGEON_HIDDEN_CAVE_W_UP:          return hiddencave.roomWUP;
            case DUNGEON_HIDDEN_CAVE_SW_UP:         return hiddencave.roomSWUP;
            case DUNGEON_HIDDEN_CAVE_NARROW_T_E:    return hiddencave.roomNTE;
            case DUNGEON_HIDDEN_CAVE_NARROW_T:      return hiddencave.roomNT;
            case DUNGEON_HIDDEN_CAVE_NARROW_T_N:    return hiddencave.roomNTN;
            case DUNGEON_HIDDEN_CAVE_L_STORAGE_W:   return hiddencave.roomLStorageW;
            case DUNGEON_HIDDEN_CAVE_L_STORAGE_E:   return hiddencave.roomLStorageE;
            case DUNGEON_HIDDEN_CAVE_S_STAIRCASE_B: return hiddencave.roomSStaircaseB;
            case DUNGEON_HIDDEN_CAVE_TUNNEL_00:     return hiddencave.roomTunnel00;
            case DUNGEON_HIDDEN_CAVE_TUNNEL_01:     return hiddencave.roomTunnel01;
            case DUNGEON_HIDDEN_CAVE_TUNNEL_02:     return hiddencave.roomTunnel02;
            case DUNGEON_HIDDEN_CAVE_TEDS_LAIR:     return hiddencave.roomTedsLair;
            case DUNGEON_HIDDEN_CAVE_SMALL_CAVE_W:  return hiddencave.roomSmallCaveW;
            case DUNGEON_HIDDEN_CAVE_MEDIUM_CAVE:   return hiddencave.roomMediumCave;
            case DUNGEON_HIDDEN_CAVE_SMALL_CAVE_E:  return hiddencave.roomSmallCaveE;
            case DUNGEON_HIDDEN_CAVE_SMALL_CAVE_N:  return hiddencave.roomSmallCaveN;
            //River Dungeon 1st floor
            case DUNGEON_RIVER_FLOOR_01_ROOM_01: return riverdungeon.roomA01;
            case DUNGEON_RIVER_FLOOR_01_ROOM_02: return riverdungeon.roomA02;
            case DUNGEON_RIVER_FLOOR_01_ROOM_03: return riverdungeon.roomA03;
            case DUNGEON_RIVER_FLOOR_01_ROOM_04: return riverdungeon.roomA04;
            case DUNGEON_RIVER_FLOOR_01_ROOM_05: return riverdungeon.roomA05;
            case DUNGEON_RIVER_FLOOR_01_ROOM_06: return riverdungeon.roomA06;
            case DUNGEON_RIVER_FLOOR_01_ROOM_07: return riverdungeon.roomA07;
            case DUNGEON_RIVER_FLOOR_01_ROOM_08: return riverdungeon.roomA08;
            case DUNGEON_RIVER_FLOOR_01_ROOM_09: return riverdungeon.roomA09;
            case DUNGEON_RIVER_FLOOR_01_ROOM_10: return riverdungeon.roomA10;
            case DUNGEON_RIVER_FLOOR_01_ROOM_11: return riverdungeon.roomA11;
            case DUNGEON_RIVER_FLOOR_01_ROOM_12: return riverdungeon.roomA12;
            case DUNGEON_RIVER_FLOOR_01_ROOM_13: return riverdungeon.roomA13;
            case DUNGEON_RIVER_FLOOR_01_ROOM_14: return riverdungeon.roomA14;
            case DUNGEON_RIVER_FLOOR_01_ROOM_15: return riverdungeon.roomA15;
            case DUNGEON_RIVER_FLOOR_01_ROOM_16: return riverdungeon.roomA16;
            case DUNGEON_RIVER_FLOOR_01_ROOM_17: return riverdungeon.roomA17;
            case DUNGEON_RIVER_FLOOR_01_ROOM_18: return riverdungeon.roomA18;
            case DUNGEON_RIVER_FLOOR_01_ROOM_19: return riverdungeon.roomA19;
            case DUNGEON_RIVER_FLOOR_01_ROOM_20: return riverdungeon.roomA20;
            //River Dungeon 2nd floor
            case DUNGEON_RIVER_FLOOR_02_ROOM_01: return riverdungeon.roomB01;
            case DUNGEON_RIVER_FLOOR_02_ROOM_02: return riverdungeon.roomB02;
            case DUNGEON_RIVER_FLOOR_02_ROOM_03: return riverdungeon.roomB03;
            case DUNGEON_RIVER_FLOOR_02_ROOM_04: return riverdungeon.roomB04;
            case DUNGEON_RIVER_FLOOR_02_ROOM_05: return riverdungeon.roomB05;
            case DUNGEON_RIVER_FLOOR_02_ROOM_06: return riverdungeon.roomB06;
            case DUNGEON_RIVER_FLOOR_02_ROOM_07: return riverdungeon.roomB07;
            case DUNGEON_RIVER_FLOOR_02_ROOM_08: return riverdungeon.roomB08;
            case DUNGEON_RIVER_FLOOR_02_ROOM_09: return riverdungeon.roomB09;
            case DUNGEON_RIVER_FLOOR_02_ROOM_10: return riverdungeon.roomB10;
            case DUNGEON_RIVER_FLOOR_02_ROOM_11: return riverdungeon.roomB11;
            case DUNGEON_RIVER_FLOOR_02_ROOM_12: return riverdungeon.roomB12;
            case DUNGEON_RIVER_FLOOR_02_ROOM_13: return riverdungeon.roomB13;
            case DUNGEON_RIVER_FLOOR_02_ROOM_14: return riverdungeon.roomB14;
            case DUNGEON_RIVER_FLOOR_02_ROOM_15: return riverdungeon.roomB15;
            case DUNGEON_RIVER_FLOOR_02_ROOM_16: return riverdungeon.roomB16;
            case DUNGEON_RIVER_FLOOR_02_ROOM_17: return riverdungeon.roomB17;
            case DUNGEON_RIVER_FLOOR_02_ROOM_18: return riverdungeon.roomB18;
            case DUNGEON_RIVER_FLOOR_02_ROOM_19: return riverdungeon.roomB19;
            case DUNGEON_RIVER_FLOOR_02_ROOM_20: return riverdungeon.roomB20;
            case DUNGEON_RIVER_FLOOR_02_ROOM_21: return riverdungeon.roomB21;
            case DUNGEON_RIVER_FLOOR_02_ROOM_22: return riverdungeon.roomB22;
            case DUNGEON_RIVER_FLOOR_02_ROOM_23: return riverdungeon.roomB23;
            case DUNGEON_RIVER_FLOOR_02_ROOM_24: return riverdungeon.roomB24;
            case DUNGEON_RIVER_FLOOR_02_ROOM_25: return riverdungeon.roomB25;
            case DUNGEON_RIVER_FLOOR_02_ROOM_26: return riverdungeon.roomB26;
            case DUNGEON_RIVER_FLOOR_02_ROOM_27: return riverdungeon.roomB27;
            //River Dungeon 3rd floor
            case DUNGEON_RIVER_FLOOR_03_ROOM_01: return riverdungeon.roomC01;
            case DUNGEON_RIVER_FLOOR_03_ROOM_02: return riverdungeon.roomC02;
            case DUNGEON_RIVER_FLOOR_03_ROOM_03: return riverdungeon.roomC03;
            case DUNGEON_RIVER_FLOOR_03_ROOM_04: return riverdungeon.roomC04;
            case DUNGEON_RIVER_FLOOR_03_ROOM_05: return riverdungeon.roomC05;
            case DUNGEON_RIVER_FLOOR_03_ROOM_06: return riverdungeon.roomC06;
            case DUNGEON_RIVER_FLOOR_03_ROOM_07: return riverdungeon.roomC07;
            case DUNGEON_RIVER_FLOOR_03_ROOM_08: return riverdungeon.roomC08;
            case DUNGEON_RIVER_FLOOR_03_ROOM_09: return riverdungeon.roomC09;
            case DUNGEON_RIVER_FLOOR_03_ROOM_10: return riverdungeon.roomC10;
            case DUNGEON_RIVER_FLOOR_03_ROOM_11: return riverdungeon.roomC11;
            case DUNGEON_RIVER_FLOOR_03_ROOM_12: return riverdungeon.roomC12;
            case DUNGEON_RIVER_FLOOR_03_ROOM_13: return riverdungeon.roomC13;
            case DUNGEON_RIVER_FLOOR_03_ROOM_14: return riverdungeon.roomC14;
            case DUNGEON_RIVER_FLOOR_03_ROOM_15: return riverdungeon.roomC15;
            case DUNGEON_RIVER_FLOOR_03_ROOM_16: return riverdungeon.roomC16;
            case DUNGEON_RIVER_FLOOR_03_ROOM_17: return riverdungeon.roomC17;
            case DUNGEON_RIVER_FLOOR_03_ROOM_18: return riverdungeon.roomC18;
            case DUNGEON_RIVER_FLOOR_03_ROOM_19: return riverdungeon.roomC19;
            case DUNGEON_RIVER_FLOOR_03_ROOM_20: return riverdungeon.roomC20;
            case DUNGEON_RIVER_FLOOR_03_ROOM_21: return riverdungeon.roomC21;
            case DUNGEON_RIVER_FLOOR_03_ROOM_22: return riverdungeon.roomC22;
            case DUNGEON_RIVER_FLOOR_03_ROOM_23: return riverdungeon.roomC23;
            case DUNGEON_RIVER_FLOOR_03_ROOM_24: return riverdungeon.roomC24;
            case DUNGEON_RIVER_FLOOR_03_ROOM_25: return riverdungeon.roomC25;
            case DUNGEON_RIVER_FLOOR_03_ROOM_26: return riverdungeon.roomC26;
            case DUNGEON_RIVER_FLOOR_03_ROOM_27: return riverdungeon.roomC27;
            case DUNGEON_RIVER_FLOOR_03_ROOM_28: return riverdungeon.roomC28;
            case DUNGEON_RIVER_FLOOR_03_ROOM_29: return riverdungeon.roomC29;
            case DUNGEON_RIVER_FLOOR_03_ROOM_30: return riverdungeon.roomC30;
            case DUNGEON_RIVER_FLOOR_03_ROOM_31: return riverdungeon.roomC31;
            case DUNGEON_RIVER_FLOOR_03_ROOM_32: return riverdungeon.roomC32;
            case DUNGEON_RIVER_FLOOR_03_ROOM_33: return riverdungeon.roomC33;
            case DUNGEON_RIVER_FLOOR_03_ROOM_34: return riverdungeon.roomC34;
            //River Dungeon 4th floor
            //Den of Desire
            case DUNGEON_DEN_OF_DESIRE_ENTRANCE:            return denofdesire.roomEntrance;
            case DUNGEON_DEN_OF_DESIRE_GREAT_HALL_AREA:     return denofdesire.roomGreatHallArea;
            case DUNGEON_DEN_OF_DESIRE_LABORATORY:          return denofdesire.roomLaboratory;
            case DUNGEON_DEN_OF_DESIRE_HERO_SLAYER_OMNIBUS: return denofdesire.roomHeroSlayerOmnibusRoom;
            //Anzu's Palace
            case DUNGEON_ANZU_OUTSIDE:          return anzupalace.roomEntrance;
            case DUNGEON_ANZU_HALL_FLOOR1:      return anzupalace.roomFoyer;
            case DUNGEON_ANZU_LIVING_ROOM:      return anzupalace.roomLivingRoom;
            case DUNGEON_ANZU_BATHROOM:         return anzupalace.roomBathroom;
            case DUNGEON_ANZU_DINING_ROOM:      return anzupalace.roomDiningRoom;
            case DUNGEON_ANZU_KITCHEN:          return anzupalace.roomKitchen;
            case DUNGEON_ANZU_HALL_FLOOR2:      return anzupalace.roomHallFloor2;
            case DUNGEON_ANZU_BEDROOM:          return anzupalace.roomBedroom;
            case DUNGEON_ANZU_LIBRARY:          return anzupalace.roomLibrary;
            case DUNGEON_ANZU_MULTIUSE_ROOM:    return anzupalace.roomMultiuse;
            case DUNGEON_ANZU_HALL_FLOOR3:      return anzupalace.roomHallFloor3;
            case DUNGEON_ANZU_PALACE_VAULTS:    return anzupalace.roomVault;
            case DUNGEON_ANZU_ALCHEMY_ROOM:     return anzupalace.roomAlchemyRoom;
            case DUNGEON_ANZU_ROOF:             return anzupalace.roomRoof;
            case DUNGEON_ANZU_BASEMENT:         return anzupalace.roomBasement;
            case DUNGEON_ANZU_ARMORY:           return anzupalace.roomArmory;
            //Ebon Labyrinth
            case DUNGEON_EBON_LABYRINTH: return ebonlabyrinth.roomStatic;
            //Beehive
            case DUNGEON_BEE_HIVE_1: return beehive.room1South;
            case DUNGEON_BEE_HIVE_2: return beehive.room4East;
            case DUNGEON_BEE_HIVE_3: return beehive.room2Center;
            case DUNGEON_BEE_HIVE_4: return beehive.room3West;
            case DUNGEON_BEE_HIVE_5: return beehive.room5North;
            //error
            default: throw new Error("Illegal dungeon location!")
        }
    }

    public function checkRoom():void {
        getRoomFunc(dungeonLoc)(); //no null-checking - error will be already thrown
    }
    
    public function checkFactoryClear():Boolean {
        return (flags[kFLAGS.FACTORY_SHUTDOWN] > 0 && flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED] > 0 && flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] > 0 && (flags[kFLAGS.FACTORY_INCUBUS_DEFEATED] > 0 || flags[kFLAGS.FACTORY_INCUBUS_BRIBED] > 0));
    }
    public function checkDeepCaveClear():Boolean {
        return (flags[kFLAGS.ZETAZ_IMP_HORDE_DEFEATED] > 0 && flags[kFLAGS.ZETAZ_FUNGUS_ROOM_DEFEATED] > 0 && player.hasKeyItem("Zetaz's Map") >= 0);
    }
    public function checkLethiceStrongholdClear():Boolean {
        return ((flags[kFLAGS.D3_MIRRORS_SHATTERED] > 0 || flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] > 0) && flags[kFLAGS.D3_GARDENER_DEFEATED] > 0 && flags[kFLAGS.D3_CENTAUR_DEFEATED] > 0 && flags[kFLAGS.LETHICE_DEFEATED] > 0);
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
    public function checkBeeHiveClear():Boolean {
        return (flags[kFLAGS.TIFA_FOLLOWER] > 5);
    }
    public function checkRiverDungeon1stFloorClear():Boolean {
        return (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 1);//1 - pokonanie 1 golema, 2 pokonanie obu golemów
    }
    public function checkRiverDungeon2ndFloorClear():Boolean {
        return (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 6);//3,4,5,6 - pokonanie każdego z sub-bossów, 7 - pokonanie chimerycznego żywiołaka
    }
    public function checkRiverDungeon3rdFloorClear():Boolean {
        return (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 8);//8 - otwarcie drzwi boss room-u, 9 - pokonanie bossa
    }

    //returns the room required for clearing
    public function clearRoomEL():int {
        return 300;
    }
    //returns the room required for the next award
    public function nextAwardEL():int {
        //Using the original award pattern - for first 50 and each 150 rooms.
        if (flags[kFLAGS.EBON_LABYRINTH] < 50) return 50;
        else return (int(flags[kFLAGS.EBON_LABYRINTH] / 150) + 1) * 150;
    }
    public function checkEbonLabyrinthClear():Boolean {
        //Now the dungeon contains different bosses up to floor 300. Let's give people a hint?
        return (flags[kFLAGS.EBON_LABYRINTH_RECORD] >= clearRoomEL());
        //return (flags[kFLAGS.EBON_LABYRINTH] > 1);//exploracja 50 pokoi bez porażki
    }
    //returns true if there are any pending awards
    public function checkEbonLabyrinthNotAwarded():Boolean {
        return flags[kFLAGS.EBON_LABYRINTH_RECORD] >= nextAwardEL();
        //return (flags[kFLAGS.EBON_LABYRINTH] > 1);//exploracja 50 pokoi bez porażki
    }
    
    
    public function canFindDeepCave():Boolean {
        return flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] == 0
                && flags[kFLAGS.FACTORY_SHUTDOWN] > 0;
    }
    public function canFindDenOfDesire():Boolean {
        return flags[kFLAGS.GAR_NAME] != 0;
    }
    
    public function navigateToRoom(room:Function = null):void {
        eachMinuteCount(5);
        room();
    }
    public function navigateToRoomRD(room:Function = null):void {
        if (player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.removeStatusEffect(StatusEffects.ThereCouldBeOnlyOne);
        eachMinuteCount(5);
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
        spriteSelect(null);
        menu();
        if (northFunction != null) addButton(6, "North", navigateToRoom, northFunction);
        if (southFunction != null) addButton(11, "South", navigateToRoom, southFunction);
        if (westFunction != null) addButton(10, "West", navigateToRoom, westFunction);
        if (eastFunction != null) addButton(12, "East", navigateToRoom, eastFunction);
        if (player.lust >= 30) addButton(8, "Masturbate", SceneLib.masturbation.masturbateGo);
        else addButtonDisabled(8, "Masturbate", "Req. 30+ lust.");
        addButton(13, "Inventory", inventory.inventoryMenu).hint("The inventory allows you to use an item.  Be careful, as this leaves you open to a counterattack when in combat.");
        addButton(14, "Map", map.displayMap).hint("View the map of this dungeon.");
        setTopButtons();
    }

    //Stop copying the code!!!
    public function setDungeonButtonsRD(northFunction:Function = null, southFunction:Function = null, westFunction:Function = null, eastFunction:Function = null):void {
        setDungeonButtons (
            northFunction   == null ? null : curry(navigateToRoomRD, northFunction),
            southFunction   == null ? null : curry(navigateToRoomRD, southFunction),
            westFunction    == null ? null : curry(navigateToRoomRD, westFunction),
            eastFunction    == null ? null : curry(navigateToRoomRD, eastFunction)
        );
        addButton(14, "Map", map.displayMapOnlyOne).hint("View the map of this dungeon."); //replace map button with this "only one" thing
    }

    public function setDungeonButtonsRD3D(northFunction:Function = null, southFunction:Function = null, westFunction:Function = null, eastFunction:Function = null, upFunction:Function = null, downFunction:Function = null):void {
        setDungeonButtonsRD(northFunction, southFunction, westFunction, eastFunction);
        //add Up/Down buttons
        if (upFunction != null) addButton(5, "Up", navigateToRoomRD, upFunction);
        if (downFunction != null) addButton(7, "Down", navigateToRoomRD, downFunction);
    }

    //Old button function here. The function itself was moved into EL, but can be brought back for new dungeons.
    /*
    public function navigateToRoomEL(room:Function = null):void {
        if (player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.removeStatusEffect(StatusEffects.ThereCouldBeOnlyOne);
        player.addStatusValue(StatusEffects.EbonLabyrinthB, 1, 1);
        eachMinuteCount(15);
        room();
    }
    public function setDungeonButtonsEL(northFunction:Function = null, southFunction:Function = null, westFunction:Function = null, eastFunction:Function = null, upFunction:Function = null, downFunction:Function = null):void {
        statScreenRefresh();
        hideUpDown();
        spriteSelect(null);
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
        addButton(14, "Exit", AreYouSureAboutThat);
        setTopButtons();
    }
    private function AreYouSureAboutThat():void {
        clearOutput();
        outputText("\"<i>Are you sure about that?</i>\"");
        menu();
        addButton(1, "No", playerMenu);
        addButton(3, "Yes", ebonlabyrinth.exitDungeon);
    }
    */
    
}
}