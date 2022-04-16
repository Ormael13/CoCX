package classes.Scenes.Dungeons {
import classes.StatusEffects;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

//derived to make access easier
public class DungeonMap extends DungeonAbstractContent
	{
		
		public function DungeonMap() 
		{
		}
		
		public function findLockedDoor1():void { //Door that requires iron key.
			rawOutputText("\n     " + (player.hasKeyItem("Iron Key") >= 0 ? "|": "L") +"     ");
		}
		
		public function findLockedDoor2():void { //Door that requires supervisors key.
			rawOutputText("\n " + (player.hasKeyItem("Supervisor's Key") >= 0 ? "|": "L") + "        ");
		}
		
		public function findLockedDoor3():void { //Door in Zetaz's lair.
			rawOutputText("\n     " + (flags[kFLAGS.ZETAZ_DOOR_UNLOCKED] > 0 ? "|": "L") + "   | ");
		}
		
		public function findLockedDoor4():void { //Door in desert cave.
			rawOutputText("\n |   |   " + (flags[kFLAGS.SANDWITCH_THRONE_UNLOCKED] > 0 ? "|": "L") + "   |     ");
		}
		
		public function findLockedDoorLethiceThrone():void {
			if (SceneLib.d3.unlockedThroneRoom()) rawOutputText("\n      |      ");
			else rawOutputText("\n      L      ");
		}
		
		public function findLockedDoorOnRDThirdFloor():void {
			rawOutputText("\n " + (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 7 ? "|": "L") + "           | ");
		}
		
		public function chooseRoomToDisplay():void {
			if (dungeonLoc >= DUNGEON_FACTORY_FOYER && dungeonLoc < DUNGEON_CAVE_ENTRANCE) { //Factory
				outputText("Factory, " + (dungeonLoc >= DUNGEON_FACTORY_FOREMANS_OFFICE && dungeonLoc < DUNGEON_FACTORY_BATHROOM ? "2": "1") + "F");
				if (dungeonLoc == DUNGEON_FACTORY_FOYER) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[P]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_FACTORY_BREAK_ROOM) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[P]");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_FACTORY_PUMP_ROOM) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[P]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_FACTORY_FURNACE_ROOM) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[P]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_FACTORY_REPAIR_CLOSET) {
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_FACTORY_MAIN_CHAMBER) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[P]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_FACTORY_FOREMANS_OFFICE) {
					rawOutputText("\n[P]—[ ]    ");
					findLockedDoor2();
					rawOutputText("\n[ ]        ");
				}
				else if (dungeonLoc == DUNGEON_FACTORY_PUMP_CONTROL) {
					rawOutputText("\n[S]—[P]    ");
					findLockedDoor2();
					rawOutputText("\n[ ]        ");
				}
				else if (dungeonLoc == DUNGEON_FACTORY_STORE_ROOM) {
					rawOutputText("\n[S]—[ ]    ");
					findLockedDoor2();
					rawOutputText("\n[P]        ");
				}
				else if (dungeonLoc == DUNGEON_FACTORY_BATHROOM) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[P]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
			}
			else if (dungeonLoc >= DUNGEON_CAVE_ENTRANCE && dungeonLoc < DUNGEON_HEL_GUARD_HALL) { //Zetaz's Lair
				rawOutputText("Zetaz's Lair");
				if (dungeonLoc == DUNGEON_CAVE_ENTRANCE) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_CAVE_TUNNEL) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_CAVE_GATHERING_HALL) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[P]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_CAVE_FUNGUS_CAVERN) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[P]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_CAVE_TORTURE_ROOM) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[P]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_CAVE_SECRET_TUNNEL) {
					rawOutputText("\n    [ ]—[P]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_CAVE_ZETAZ_CHAMBER) {
					rawOutputText("\n    [P]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
			}
			else if (dungeonLoc >= DUNGEON_HEL_GUARD_HALL && dungeonLoc < DUNGEON_WITCH_ENTRANCE_GATEWAY) { //Tower of the Phoenix
				rawOutputText("Tower of the Phoenix");
				if (dungeonLoc == DUNGEON_HEL_GUARD_HALL) {
					rawOutputText(", 1F");
					rawOutputText("\n    [S]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (dungeonLoc == DUNGEON_HEL_WINE_CELLAR) {
					rawOutputText(", B1");
					rawOutputText("\n    [S]    ");
					rawOutputText("\n           ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (dungeonLoc == DUNGEON_HEL_STAIR_WELL) {
					rawOutputText(", 1F");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [S]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (dungeonLoc == DUNGEON_HEL_DUNGEON) {
					rawOutputText(", B1");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n           ");
					rawOutputText("\n    [S]    ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (dungeonLoc == DUNGEON_HEL_MEZZANINE) {
					rawOutputText(", 2F");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (dungeonLoc == DUNGEON_HEL_THRONE_ROOM) {
					rawOutputText(", 3F");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
			}
			else if (dungeonLoc >= DUNGEON_WITCH_ENTRANCE_GATEWAY && dungeonLoc < DUNGEON_HIDDEN_CAVE_ENTRANCE) {
				rawOutputText("Cave of the Sand Witches");
				if (dungeonLoc == DUNGEON_WITCH_ENTRANCE_GATEWAY) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [P] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_CAVERNOUS_COMMONS) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[P]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_WEST_WARRENS_MAIN) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[P]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_CHILDRENS_PLAYROOM) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [P] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_PREGNANT_LUST_ROOM) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [P] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_WEST_WARRENS_WEST) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[P]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_NURSERY) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[P] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_PHARMACY) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[P] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_EAST_WARRENS_MAIN) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[P]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_SLEEPING_CHAMBER) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [P]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_BATH_ROOM) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[P]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_EAST_WARRENS_EAST) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[P]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_CUM_WITCH_BEDROOM) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[P]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_CUM_WITCH_OFFICE) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [P]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_SACRIFICIAL_ALTAR) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [P] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (dungeonLoc == DUNGEON_WITCH_THRONE_ROOM) {
					rawOutputText("\n        [P]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
			}
			else if (dungeonLoc >= DUNGEON_HIDDEN_CAVE_ENTRANCE && dungeonLoc < DUNGEON_DEN_OF_DESIRE_ENTRANCE) { //Hidden Cave
				rawOutputText("Hidden Cave");
				if (dungeonLoc == DUNGEON_HIDDEN_CAVE_ENTRANCE) {
					rawOutputText(", Entrance");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[P]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_SE_UP) {
					rawOutputText(", SE Underground Passage");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[P]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_E_UP) {
					rawOutputText(", E Underground Passage");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [P]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_NE_UP) {
					rawOutputText(", NE Underground Passage");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[P]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_N_UP) {
					rawOutputText(", N Underground Passage");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[P]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_S_STAIRCASE) {
					rawOutputText(", Stone Staircase");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [P]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_S_UP) {
					rawOutputText(", S Underground Passage");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[P]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_S_STORAGE) {
					rawOutputText(", Small Storage");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[P]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_NW_UP) {
					rawOutputText(", NW Underground Passage");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [P]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_W_UP) {
					rawOutputText(", W Underground Passage");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[P]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_SW_UP) {
					rawOutputText(", SW Underground Passage");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [P]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_NARROW_T_E) {
					rawOutputText(", Narrow Tunnel (E)");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[P]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_NARROW_T  ) {
					rawOutputText(", Narrow Tunnel");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[P]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_NARROW_T_N) {
					rawOutputText(", Narrow Tunnel (N)");
					rawOutputText("\n[ ]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[P]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_L_STORAGE_W) {
					rawOutputText(", Large Storage (W)");
					rawOutputText("\n[P]—[ ]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_L_STORAGE_E) {
					rawOutputText(", Large Storage (E)");
					rawOutputText("\n[ ]—[P]                ");
					rawOutputText("\n |                     ");
					rawOutputText("\n[ ]     [ ]—[ ]—[ ]    ");
					rawOutputText("\n |       |       |     ");
					rawOutputText("\n[ ]—[ ]—[ ]     [ ]    ");
					rawOutputText("\n         |       |     ");
					rawOutputText("\n        [ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n         |           | ");
					rawOutputText("\n    [S]—[ ]            ");
				}
				else if (flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] < 1) {
					if (dungeonLoc == DUNGEON_HIDDEN_CAVE_S_STAIRCASE_B) {
						rawOutputText(", Stone Staircase Basement");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [P]");
					}
					else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_TUNNEL_00) {
						rawOutputText(", Tunnel");
						rawOutputText("\n[ ]—[ ]—[P]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_TUNNEL_01) {
						rawOutputText(", Tunnel");
						rawOutputText("\n[ ]—[P]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_TUNNEL_02) {
						rawOutputText(", Tunnel");
						rawOutputText("\n[P]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_TEDS_LAIR) {
						rawOutputText(", Ted's Lair");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[P]     [S]");
					}
				}
				else if (flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] > 0) {
					if (dungeonLoc == DUNGEON_HIDDEN_CAVE_S_STAIRCASE_B) {
						rawOutputText(", Stone Staircase Basement");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [P]");
					}
					else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_TUNNEL_00) {
						rawOutputText(", Tunnel");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[P]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_TUNNEL_01) {
						rawOutputText(", Tunnel");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[P]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_TUNNEL_02) {
						rawOutputText(", Tunnel");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[P]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_TEDS_LAIR) {
						rawOutputText(", Ted's Lair");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[P]     [S]");
					}
					else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_SMALL_CAVE_W) {
						rawOutputText(", Small Cave (W)");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[P]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_MEDIUM_CAVE) {
						rawOutputText(", Medium Cave");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[P]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_SMALL_CAVE_E) {
						rawOutputText(", Small Cave (E)");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[P]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (dungeonLoc == DUNGEON_HIDDEN_CAVE_SMALL_CAVE_N) {
						rawOutputText(", Small Cave (N)");
						rawOutputText("\n    [P]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
				}
			}
			else if (dungeonLoc >= DUNGEON_DEN_OF_DESIRE_ENTRANCE && dungeonLoc < DUNGEON_RIVER_FLOOR_01_ROOM_01) { //Den of Desire
				rawOutputText("Den of Desire");
				if (dungeonLoc == DUNGEON_DEN_OF_DESIRE_ENTRANCE) {
					rawOutputText(", Entrance");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_DEN_OF_DESIRE_GREAT_HALL_AREA) {
					rawOutputText(", Great Hall");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_DEN_OF_DESIRE_LABORATORY) {
					rawOutputText(", Laboratory");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_DEN_OF_DESIRE_HERO_SLAYER_OMNIBUS) {
					rawOutputText(", Hero slayer omnibus room");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
			}
			else if (dungeonLoc >= DUNGEON_RIVER_FLOOR_01_ROOM_01 && dungeonLoc < DUNGEON_ANZU_OUTSIDE) { //River Dungeon: Floor 1
				rawOutputText("River Dungeon");
				if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_01) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[P]-[ ]     [S]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_02) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[P]     [S]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_03) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [P]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_04) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[P]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_05) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[P]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_06) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [P]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_07) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[P]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_08) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[P]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_09) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[P]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_10) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [P]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_11) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[ ]");
					rawOutputText("\n         | ");
					rawOutputText("\n        [P]");
					rawOutputText("\n         | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_12) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[P]");
					rawOutputText("\n         | ");
					rawOutputText("\n        [ ]");
					rawOutputText("\n         | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_13) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[P]-[ ]");
					rawOutputText("\n         | ");
					rawOutputText("\n        [ ]");
					rawOutputText("\n         | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_14) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[P]-[ ]-[ ]");
					rawOutputText("\n         | ");
					rawOutputText("\n        [ ]");
					rawOutputText("\n         | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_15) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[ ]");
					rawOutputText("\n         | ");
					rawOutputText("\n        [ ]");
					rawOutputText("\n         | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_16) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[ ]");
					rawOutputText("\n |         ");
					rawOutputText("\n[P]        ");
					rawOutputText("\n |         ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_17) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[P]-[ ]-[ ]");
					rawOutputText("\n |         ");
					rawOutputText("\n[ ]        ");
					rawOutputText("\n |         ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_18) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[P]-[ ]");
					rawOutputText("\n |         ");
					rawOutputText("\n[ ]        ");
					rawOutputText("\n |         ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_19) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[P]");
					rawOutputText("\n |         ");
					rawOutputText("\n[ ]        ");
					rawOutputText("\n |         ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_01_ROOM_20) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[ ]");
					rawOutputText("\n |         ");
					rawOutputText("\n[ ]        ");
					rawOutputText("\n |         ");
				}
			}
			else if (dungeonLoc >= DUNGEON_ANZU_OUTSIDE && dungeonLoc < DUNGEON_RIVER_FLOOR_02_ROOM_01) { //Anzu's Palace
				rawOutputText("Anzu's Palace");
				if (dungeonLoc == DUNGEON_ANZU_OUTSIDE) {
					rawOutputText(", Palace Grounds");
					rawOutputText("\n[ ]     [ ]");
					rawOutputText("\n |       | ");
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_ANZU_HALL_FLOOR1) {
					rawOutputText(", Hall, Floor 1");
					rawOutputText("\n[ ]     [ ]");
					rawOutputText("\n |       | ");
					rawOutputText("\n[ ]—[P]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_ANZU_LIVING_ROOM) {
					rawOutputText(", Living Room");
					rawOutputText("\n[ ]     [ ]");
					rawOutputText("\n |       | ");
					rawOutputText("\n[P]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_ANZU_BATHROOM) {
					rawOutputText(", Bathroom");
					rawOutputText("\n[P]     [ ]");
					rawOutputText("\n |       | ");
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_ANZU_DINING_ROOM) {
					rawOutputText(", Dining Room");
					rawOutputText("\n[ ]     [ ]");
					rawOutputText("\n |       | ");
					rawOutputText("\n[ ]—[ ]—[P]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_ANZU_KITCHEN) {
					rawOutputText(", Kitchen");
					rawOutputText("\n[ ]     [P]");
					rawOutputText("\n |       | ");
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_ANZU_HALL_FLOOR2) {
					rawOutputText(", Hall, Floor 2");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]—[P]—[ ]");
				}
				else if (dungeonLoc == DUNGEON_ANZU_BEDROOM) {
					rawOutputText(", Bedroom");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[P]—[ ]—[ ]");
				}
				else if (dungeonLoc == DUNGEON_ANZU_LIBRARY) {
					rawOutputText(", Library");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]—[ ]—[P]");
				}
				else if (dungeonLoc == DUNGEON_ANZU_MULTIUSE_ROOM) {
					rawOutputText(", Multi-use Room");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]—[ ]—[ ]");
				}
				else if (dungeonLoc == DUNGEON_ANZU_HALL_FLOOR3) {
					rawOutputText(", Hall, Floor 3");
					rawOutputText("\n           ");
					rawOutputText("\n[ ]—[P]—[ ]");
					rawOutputText("\n           ");
				}
				else if (dungeonLoc == DUNGEON_ANZU_PALACE_VAULTS) {
					rawOutputText(", Vault");
					rawOutputText("\n           ");
					rawOutputText("\n[P]—[ ]—[ ]");
					rawOutputText("\n           ");
				}
				else if (dungeonLoc == DUNGEON_ANZU_ALCHEMY_ROOM) {
					rawOutputText(", Alchemy Room");
					rawOutputText("\n           ");
					rawOutputText("\n[ ]—[ ]—[P]");
					rawOutputText("\n           ");
				}
				else if (dungeonLoc == DUNGEON_ANZU_ROOF) {
					rawOutputText(", Roof");
					rawOutputText("\n           ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n           ");
				}
				else if (dungeonLoc == DUNGEON_ANZU_BASEMENT) {
					rawOutputText(", Basement");
					rawOutputText("\n           ");
					rawOutputText("\n[ ]—[P]    ");
					rawOutputText("\n           ");
				}
				else if (dungeonLoc == DUNGEON_ANZU_ARMORY) {
					rawOutputText(", Armory");
					rawOutputText("\n           ");
					rawOutputText("\n[P]—[ ]    ");
					rawOutputText("\n           ");
				}
			}
			else if (dungeonLoc >= DUNGEON_RIVER_FLOOR_02_ROOM_01 && dungeonLoc < DUNGEON_EBON_LABYRINTH) { //River Dungeon: Floor 2
				rawOutputText("River Dungeon");
				if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_01) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[P] [ ]-[ ]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_02) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[P]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[ ]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_03) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[ ]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[P]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_04) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[ ]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [P]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_05) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [P]-[ ]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_06) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[P]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[ ]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_07) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[ ]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[P]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_08) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[P]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_09) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[P]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[ ]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_10) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[ ]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[P]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_11) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[ ]-[P] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_12) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[P]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[ ]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_13) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [P]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[ ]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_14) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[ ]-[ ] [S]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[P]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_15) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[S] [ ]-[ ]-[ ] [P]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_16) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[ ]—[P]");
					rawOutputText("\n |   | ");
					rawOutputText("\n[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_17) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[P]—[ ]");
					rawOutputText("\n |   | ");
					rawOutputText("\n[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_18) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[ ]—[ ]");
					rawOutputText("\n |   | ");
					rawOutputText("\n[P]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_19) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[ ]—[ ]");
					rawOutputText("\n     | ");
					rawOutputText("\n   —[P]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_20) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[ ]—[P]");
					rawOutputText("\n     | ");
					rawOutputText("\n   —[ ]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_21) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[P]—[ ]");
					rawOutputText("\n     | ");
					rawOutputText("\n   —[ ]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_22) {
					rawOutputText(", Floor 2");
					rawOutputText("\n    [ ]");
					rawOutputText("\n |   | ");
					rawOutputText("\n[P]—[ ]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_23) {
					rawOutputText(", Floor 2");
					rawOutputText("\n    [ ]");
					rawOutputText("\n |   | ");
					rawOutputText("\n[ ]—[P]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_24) {
					rawOutputText(", Floor 2");
					rawOutputText("\n    [P]");
					rawOutputText("\n |   | ");
					rawOutputText("\n[ ]—[ ]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_25) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[P]—   ");
					rawOutputText("\n |     ");
					rawOutputText("\n[ ]—[ ]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_26) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[ ]—   ");
					rawOutputText("\n |     ");
					rawOutputText("\n[P]—[ ]");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_02_ROOM_27) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[ ]—   ");
					rawOutputText("\n |     ");
					rawOutputText("\n[ ]—[P]");
				}
			}
			else if (dungeonLoc == DUNGEON_EBON_LABYRINTH) { //Ebon Labyrinth
				rawOutputText("Ebon Labyrinth, corridor");
                if (silly())
                    rawOutputText("\nDid you <i>REALLY</i> expect a to get a <b>map</b> of the <b>labyrinth</b>? Why didn't you bring some threads with you?");
                else {
                    rawOutputText("\n   |  ");
                    rawOutputText("\n —[P]—");
                    rawOutputText("\n   |  ");
                }
			}
			else if (dungeonLoc >= DUNGEON_RIVER_FLOOR_03_ROOM_01 && dungeonLoc < DUNGEON_BEE_HIVE_1) { //River Dungeon: Floor 3
				rawOutputText("River Dungeon");
				if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_01) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [P]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_02) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[P]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_03) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[P]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_04) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [P]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_05) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[P]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_06) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[P]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_07) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[P]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_08) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [P]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_09) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[P]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_10) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [P]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_11) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [P]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_12) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[P] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_13) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[P]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_14) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[P]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_15) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[P]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_16) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[ ]-[P]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_17) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[ ]-[P]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_18) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [ ]-[P]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_19) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[S]     [P]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_20) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [S]        ");
					rawOutputText("\n         |       |         ");
					rawOutputText("\n        [ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[P]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_21) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [P]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_22) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[P]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [ ]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_23) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[P]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [ ]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_24) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[ ]-[ ]-[P]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [ ]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_25) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[P]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [ ]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_26) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[P]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [ ]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_27) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[ ]-[P]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [ ]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_28) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[P]-[ ]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [ ]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_29) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[P]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [ ]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_30) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[P]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [ ]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_31) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[P]         [ ]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_32) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[P]-[ ]-[ ]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [ ]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_33) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[P]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [ ]");
					rawOutputText("\n             | ");
				}
				else if (dungeonLoc == DUNGEON_RIVER_FLOOR_03_ROOM_34) {
					rawOutputText(", Floor 3");
					rawOutputText("\n[P]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |   |   |   | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]");
					findLockedDoorOnRDThirdFloor();
					rawOutputText("\n[ ]         [ ]");
					rawOutputText("\n             | ");
				}
			}
			else if (dungeonLoc >= DUNGEON_BEE_HIVE_1 && dungeonLoc < 174) { //Bee Hive
				rawOutputText("Bee Hive");
				if (dungeonLoc == DUNGEON_BEE_HIVE_1) {
					rawOutputText(", Entrance");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_BEE_HIVE_2) {
					rawOutputText(", Princess cells");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[P]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_BEE_HIVE_3) {
					rawOutputText(", Honey Brewers halls");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[P]-[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_BEE_HIVE_4) {
					rawOutputText(", Library");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[P]-[ ]-[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (dungeonLoc == DUNGEON_BEE_HIVE_5) {
					rawOutputText(", Far corridor towards the throne room");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
			}
			
			
			
		}
		/* - layout for future dungeon use
					if (CoC.instance.dungeonLoc == DUNGEON_HIDDEN_CAVE_S_STAIRCASE_B) {
						rawOutputText(", Stone Staircase Basement<");
						rawOutputText("\n    [ ]             [ ]    ");
						rawOutputText("\n     |               |     ");
						rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]—[ ]—[ ]");
						rawOutputText("\n     |               |     ");
						rawOutputText("\n    [ ]             [ ]    ");
						rawOutputText("\n     |               |     ");
						rawOutputText("\n    [ ]     [T]—[ ]—[ ]    ");
						rawOutputText("\n     |           |         ");
						rawOutputText("\n    [ ]         [ ]        ");
						rawOutputText("\n     |           |         ");
						rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]—[ ]—[ ]");
						rawOutputText("\n     |               |     ");
						rawOutputText("\n    [ ]—[ ]—[ ]     [ ]    ");
						rawOutputText("\n     |       |             ");
						rawOutputText("\n    [ ]     [P]            ");
					}
		*/
		public function chooseRoomToDisplayD3():void {
			//Basilisk Cave
            if (SceneLib.d3._currentRoom == "entrance") {
                rawOutputText("Basilisk Cave");
				rawOutputText("\n     [ ]—   ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]    ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]—[ ]");
				rawOutputText("\n      |     ");
				rawOutputText("\n—[P]—[ ]    ");
			}
            else if (SceneLib.d3._currentRoom == "tunnel1") {
                rawOutputText("Basilisk Cave");
				rawOutputText("\n     [ ]—   ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]    ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]—[ ]");
				rawOutputText("\n      |     ");
				rawOutputText("\n—[ ]—[P]    ");
			}
            else if (SceneLib.d3._currentRoom == "antechamber") {
                rawOutputText("Basilisk Cave");
				rawOutputText("\n     [ ]—   ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]    ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [P]—[ ]");
				rawOutputText("\n      |     ");
				rawOutputText("\n—[ ]—[ ]    ");
			}
            else if (SceneLib.d3._currentRoom == "roomofmirrors") {
                rawOutputText("Basilisk Cave");
				rawOutputText("\n     [ ]—   ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]    ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]—[P]");
				rawOutputText("\n      |     ");
				rawOutputText("\n—[ ]—[ ]    ");
			}
            else if (SceneLib.d3._currentRoom == "magpiehalls" || SceneLib.d3._currentRoom == "magpiehalln") {
                rawOutputText("Basilisk Cave");
				rawOutputText("\n     [ ]—   ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [P]    ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]—[ ]");
				rawOutputText("\n      |     ");
				rawOutputText("\n—[ ]—[ ]    ");
			}
            else if (SceneLib.d3._currentRoom == "tunnel2") {
                rawOutputText("Basilisk Cave");
				rawOutputText("\n     [P]—   ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]    ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]—[ ]");
				rawOutputText("\n      |     ");
				rawOutputText("\n—[ ]—[ ]    ");
			}
			//Lethice's Keep
            if (SceneLib.d3._currentRoom == "edgeofkeep") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[P]     ");
			}
            else if (SceneLib.d3._currentRoom == "northentry") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [P] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}

else if (SceneLib.d3._currentRoom == "southcourtyard") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[P]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}

else if (SceneLib.d3._currentRoom == "southwestcourtyard") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[P]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "southwestwalk") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [P]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "westwalk") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [P]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "northwestwalk") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[P]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "northwestcourtyard") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [P]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "northcourtyard") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[P]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "northeastcourtyard") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[P] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "northeastwalk") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [P]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "eastwalk") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[P] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "southeastwalk") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [P] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "southeastcourtyard") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[P]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "courtyardsquare") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[P]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "greatlift") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [ ]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [P] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
            else if (SceneLib.d3._currentRoom == "throneroom") {
                rawOutputText("Lethice's Keep");
				rawOutputText("\n     [P]     ");
				findLockedDoorLethiceThrone();
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]     [ ]—");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]—[ ]—[ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n [ ]     [ ] ");
				rawOutputText("\n  |       |  ");
				rawOutputText("\n—[ ]—[ ]—[ ]—");
				rawOutputText("\n      |   |  ");
				rawOutputText("\n     [ ] [ ] ");
				rawOutputText("\n      |      ");
				rawOutputText("\n    —[ ]     ");
			}
		}
		
		public function displayMap():void {
			clearOutput();
			outputText("<b><font face=\"_typewriter\">");
			if (inRoomedDungeon) chooseRoomToDisplayD3();
			else chooseRoomToDisplay();
			outputText("</font></b>");
			outputText("\n\n<b><u>Legend</u></b>");
			outputText("\n<font face=\"_typewriter\"><b>P</b></font> — Player Location");
			outputText("\n<font face=\"_typewriter\"><b>L</b></font> — Locked Door");
			outputText("\n<font face=\"_typewriter\"><b>S</b></font> — Stairs");
			menu();
			addButton(0, "Close Map", playerMenu);
		}
        
		public function displayMapOnlyOne():void {
			player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
			displayMap();
		}
		
	}

}