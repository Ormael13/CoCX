package classes.Scenes.Dungeons {
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.StatusEffects;

//derived to make access easier
public class DungeonMaps extends DungeonAbstractContent
	{
		public function DungeonMaps() {}

		//List of dungeon maps.
		private var maps:Array = [
            //Example - the location's (displayed) name and map array itself
			new DungeonMap("Factory, 1st floor", [
					"    [e]    ",
					"     |     ",
					"[S]—[c]—[d]",
					"     L     ",
					"[f]—[a]—[b]",
					"     |     ",
				],
                //Rooms - each letter is replaced with 'P' or a space  (latter - except 'S' by default)
				{
					'a': DUNGEON_FACTORY_FOYER,
					'b': DUNGEON_FACTORY_BREAK_ROOM,
					'c': DUNGEON_FACTORY_PUMP_ROOM,
					'd': DUNGEON_FACTORY_FURNACE_ROOM,
					'e': DUNGEON_FACTORY_REPAIR_CLOSET,
					'S': DUNGEON_FACTORY_MAIN_CHAMBER,
					'f': DUNGEON_FACTORY_BATHROOM
				},
                //Unique symbols, replaced by another one after checking the condition
				function():Object { return {
					'L': player.hasKeyItem("Iron Key") >= 0 ? "|": "L"
				}; }
			),
			new DungeonMap("Factory, 2nd floor", [
					"[S]—[a]    ",
					" L         ",
					"[b]        ",
				],
				{
					'S': DUNGEON_FACTORY_FOREMANS_OFFICE,
					'a': DUNGEON_FACTORY_PUMP_CONTROL,
					'b': DUNGEON_FACTORY_STORE_ROOM
				},
				function():Object { return {
					'L': player.hasKeyItem("Supervisor's Key") >= 0 ? "|": "L"
				}; }
			),
			new DungeonMap("Zetaz's Lair", [
					"    [g]—[f]",
                    "     L   | ",
					"[d]—[c]—[e]",
					"     |     ",
					"    [b]    ",
					"     |     ",
					"    [a]    ",
					"     |     ",
				],
				{
					'a': DUNGEON_CAVE_ENTRANCE,
					'b': DUNGEON_CAVE_TUNNEL,
					'c': DUNGEON_CAVE_GATHERING_HALL,
					'd': DUNGEON_CAVE_FUNGUS_CAVERN,
					'e': DUNGEON_CAVE_TORTURE_ROOM,
					'f': DUNGEON_CAVE_SECRET_TUNNEL,
					'g': DUNGEON_CAVE_ZETAZ_CHAMBER
				},
				function():Object { return {
					'L': flags[kFLAGS.ZETAZ_DOOR_UNLOCKED] > 0 ? "|": "L"
				}; }
			),
            //Fucking tower. 4 maps for 4 rooms!
			new DungeonMap("Tower of the Phoenix, 1st floor", [
					"    [S]    ",
					"     |     ",
					"    [a]    ",
					"     |     ",
				],
				{
					'a': DUNGEON_HEL_GUARD_HALL,
					'S': DUNGEON_HEL_STAIR_WELL
				}
			),
			new DungeonMap("Tower of the Phoenix, basement", [
					"    [s]    ",
					"           ",
					"    [W]    ",
					"           ",
				],
				{
					'W': DUNGEON_HEL_WINE_CELLAR,
					's': DUNGEON_HEL_DUNGEON
				},
                null,
                ['s', 'W'] //don't replace 'W' with a space!
			),
			new DungeonMap("Tower of the Phoenix, 2nd floor", [
					"    [S]    ",
					"           ",
					"           ",
					"           ",
				],
				{
					'S': DUNGEON_HEL_MEZZANINE
				}
			),
			new DungeonMap("Tower of the Phoenix, 3rd floor", [
					"    [S]    ",
					"           ",
					"           ",
					"           ",
					"           ",
				],
				{
					'S': DUNGEON_HEL_MEZZANINE
				}
			),
			new DungeonMap("Cave of the Sand Witches", [
					"        [p]        ",
					"         |         ",
					"[g] [d] [o] [j]—[k]",
					" |   |   L   |     ",
					"[f]—[c]—[b]—[i]—[l]",
					" |   |   |       | ",
					"[h] [e] [a] [n]—[m]",
					"         |         ",
				],
				{
					'a': DUNGEON_WITCH_ENTRANCE_GATEWAY,
					'b': DUNGEON_WITCH_CAVERNOUS_COMMONS,
					'c': DUNGEON_WITCH_WEST_WARRENS_MAIN,
					'd': DUNGEON_WITCH_CHILDRENS_PLAYROOM,
					'e': DUNGEON_WITCH_PREGNANT_LUST_ROOM,
					'f': DUNGEON_WITCH_WEST_WARRENS_WEST,
					'g': DUNGEON_WITCH_NURSERY,
					'h': DUNGEON_WITCH_PHARMACY,
					'i': DUNGEON_WITCH_EAST_WARRENS_MAIN,
					'j': DUNGEON_WITCH_SLEEPING_CHAMBER,
					'k': DUNGEON_WITCH_BATH_ROOM,
					'l': DUNGEON_WITCH_EAST_WARRENS_EAST,
					'm': DUNGEON_WITCH_CUM_WITCH_BEDROOM,
					'n': DUNGEON_WITCH_CUM_WITCH_OFFICE,
					'o': DUNGEON_WITCH_SACRIFICIAL_ALTAR,
					'p': DUNGEON_WITCH_THRONE_ROOM
				},
				function():Object { return {
					'L': flags[kFLAGS.SANDWITCH_THRONE_UNLOCKED] > 0 ? "|": "L"
				}; }
			),
			new DungeonMap("Hidden Cave, 1st floor", [
					"[n]—[o]                ",
					" |                     ",
					"[m]     [h]—[e]—[d]    ",
					" |       |       |     ",
					"[l]—[k]—[i]     [c]    ",
					"         |       |     ",
					"        [j]—[f]—[b]—[a]",
					"         |           | ",
					"    [S]—[g]            ",
				],
				{
					'a': DUNGEON_HIDDEN_CAVE_ENTRANCE,
					'b': DUNGEON_HIDDEN_CAVE_SE_UP,
					'c': DUNGEON_HIDDEN_CAVE_E_UP,
					'd': DUNGEON_HIDDEN_CAVE_NE_UP,
					'e': DUNGEON_HIDDEN_CAVE_N_UP,
					'S': DUNGEON_HIDDEN_CAVE_S_STAIRCASE,
					'f': DUNGEON_HIDDEN_CAVE_S_UP,
					'g': DUNGEON_HIDDEN_CAVE_S_STORAGE,
					'h': DUNGEON_HIDDEN_CAVE_NW_UP,
					'i': DUNGEON_HIDDEN_CAVE_W_UP,
					'j': DUNGEON_HIDDEN_CAVE_SW_UP,
					'k': DUNGEON_HIDDEN_CAVE_NARROW_T_E,
					'l': DUNGEON_HIDDEN_CAVE_NARROW_T,
					'm': DUNGEON_HIDDEN_CAVE_NARROW_T_N,
					'n': DUNGEON_HIDDEN_CAVE_L_STORAGE_W,
					'o': DUNGEON_HIDDEN_CAVE_L_STORAGE_E
				},
				function():Object { return {
					'L': flags[kFLAGS.SANDWITCH_THRONE_UNLOCKED] > 0 ? "|": "L"
				}; }
			),
			new DungeonMap("Hidden Cave, 2nd floor", [
					"     ?     ",
					"[c]—[b]—[a]",
                    " |       | ",
                    "[d]     [S]",
				],
				{
					'S': DUNGEON_HIDDEN_CAVE_S_STAIRCASE_B,
					'a': DUNGEON_HIDDEN_CAVE_TUNNEL_00,
					'b': DUNGEON_HIDDEN_CAVE_TUNNEL_01,
					'c': DUNGEON_HIDDEN_CAVE_TUNNEL_02,
					'd': DUNGEON_HIDDEN_CAVE_TEDS_LAIR
				},
				function():Object { return {
					'?': flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] > 0 ? "|": " "
				}; }
			),
			new DungeonMap("Hidden Cave, hidden sub-cave", [
					"    [d]    ",
                    "     |     ",
                    "[a]—[b]—[c]",
                    "     |     ",
				],
				{
					'a': DUNGEON_HIDDEN_CAVE_SMALL_CAVE_W,
					'b': DUNGEON_HIDDEN_CAVE_MEDIUM_CAVE,
					'c': DUNGEON_HIDDEN_CAVE_SMALL_CAVE_E,
					'd': DUNGEON_HIDDEN_CAVE_SMALL_CAVE_N
				}
			),
			new DungeonMap("Den of Desire", [
					"    [d]    ",
					"     |     ",
					"    [c]    ",
					"     |     ",
					"    [b]    ",
					"     |     ",
					"    [a]    ",
					"     |     ",
				],
				{
					'a': DUNGEON_DEN_OF_DESIRE_ENTRANCE,
					'b': DUNGEON_DEN_OF_DESIRE_GREAT_HALL_AREA,
					'c': DUNGEON_DEN_OF_DESIRE_LABORATORY,
					'd': DUNGEON_DEN_OF_DESIRE_HERO_SLAYER_OMNIBUS
				}
			),
			new DungeonMap("Twilight Grove", [
					"    [f]    ",
					"     |     ",
					"    [e]    ",
					"     |     ",
					"    [d]    ",
					"     |     ",
					"    [c]    ",
					"     |     ",
					"    [b]    ",
					"     |     ",
					"    [a]    ",
					"     |     ",
				],
				{
					'a': DUNGEON_TWILIGHT_GROVE_1,
					'b': DUNGEON_TWILIGHT_GROVE_2,
					'c': DUNGEON_TWILIGHT_GROVE_3,
					'd': DUNGEON_TWILIGHT_GROVE_4,
					'e': DUNGEON_TWILIGHT_GROVE_5,
					'f': DUNGEON_TWILIGHT_GROVE_6
				}
			),
			new DungeonMap("River Dungeon, 1st floor", [
					"        [h]    ",
					" |       |     ",
					"[e]-[f]-[g]    ",
					"     |       | ",
					"    [b]-[c]-[d]",
					"     |       | ",
					"[s]-[a]     [S]",
				],
				{
					's': DUNGEON_RIVER_FLOOR_01_ROOM_01,
					'a': DUNGEON_RIVER_FLOOR_01_ROOM_02,
					'b': DUNGEON_RIVER_FLOOR_01_ROOM_03,
					'c': DUNGEON_RIVER_FLOOR_01_ROOM_04,
					'd': DUNGEON_RIVER_FLOOR_01_ROOM_05,
					'S': DUNGEON_RIVER_FLOOR_01_ROOM_06,
					'e': DUNGEON_RIVER_FLOOR_01_ROOM_07,
					'f': DUNGEON_RIVER_FLOOR_01_ROOM_08,
					'g': DUNGEON_RIVER_FLOOR_01_ROOM_09,
					'h': DUNGEON_RIVER_FLOOR_01_ROOM_10
				}
			),
			new DungeonMap("River Dungeon, 1st floor, sub-area A", [
					"    [e]    ",
					"     |     ",
					"[d]-[c]-[b]",
					"         | ",
					"        [a]",
					"         | ",
				],
				{
					'a': DUNGEON_RIVER_FLOOR_01_ROOM_11,
					'b': DUNGEON_RIVER_FLOOR_01_ROOM_12,
					'c': DUNGEON_RIVER_FLOOR_01_ROOM_13,
					'd': DUNGEON_RIVER_FLOOR_01_ROOM_14,
					'e': DUNGEON_RIVER_FLOOR_01_ROOM_15
				}
			),
			new DungeonMap("River Dungeon, 1st floor, sub-area B", [
					"    [e]    ",
					"     |     ",
					"[b]-[c]-[d]",
					" |         ",
					"[a]        ",
					" |         ",
				],
				{
					'a': DUNGEON_RIVER_FLOOR_01_ROOM_16,
					'b': DUNGEON_RIVER_FLOOR_01_ROOM_17,
					'c': DUNGEON_RIVER_FLOOR_01_ROOM_18,
					'd': DUNGEON_RIVER_FLOOR_01_ROOM_19,
					'e': DUNGEON_RIVER_FLOOR_01_ROOM_20
				}
			),
			new DungeonMap("River Dungeon, 2nd floor", [
					"            [l]-   ",
					" |           |     ",
					"[a]-[e]-[h]-[k]    ",
					" |   |   |   |     ",
					"[s] [d]-[g]-[j] [S]",
					"     |   |   |   | ",
					"    [c]-[f]-[i]-[m]",
					"     |           | ",
					"   -[b]            ",
				],
				{
					's': DUNGEON_RIVER_FLOOR_02_ROOM_01,
					'a': DUNGEON_RIVER_FLOOR_02_ROOM_02,
					'b': DUNGEON_RIVER_FLOOR_02_ROOM_03,
					'c': DUNGEON_RIVER_FLOOR_02_ROOM_04,
					'd': DUNGEON_RIVER_FLOOR_02_ROOM_05,
					'e': DUNGEON_RIVER_FLOOR_02_ROOM_06,
					'f': DUNGEON_RIVER_FLOOR_02_ROOM_07,
					'g': DUNGEON_RIVER_FLOOR_02_ROOM_08,
					'h': DUNGEON_RIVER_FLOOR_02_ROOM_09,
					'i': DUNGEON_RIVER_FLOOR_02_ROOM_10,
					'j': DUNGEON_RIVER_FLOOR_02_ROOM_11,
					'k': DUNGEON_RIVER_FLOOR_02_ROOM_12,
					'l': DUNGEON_RIVER_FLOOR_02_ROOM_13,
					'm': DUNGEON_RIVER_FLOOR_02_ROOM_14,
					'S': DUNGEON_RIVER_FLOOR_02_ROOM_15
				}
			),
			new DungeonMap("River Dungeon, 2nd floor, sub-area A", [
					"[b]—[a]",
					" |   | ",
					"[c]    ",
				],
				{
					'a': DUNGEON_RIVER_FLOOR_02_ROOM_16,
					'b': DUNGEON_RIVER_FLOOR_02_ROOM_17,
					'c': DUNGEON_RIVER_FLOOR_02_ROOM_18
				}
			),
			new DungeonMap("River Dungeon, 2nd floor, sub-area B", [
					"[c]—[b]",
					"     | ",
					"   —[a]",
				],
				{
					'a': DUNGEON_RIVER_FLOOR_02_ROOM_19,
					'b': DUNGEON_RIVER_FLOOR_02_ROOM_20,
					'c': DUNGEON_RIVER_FLOOR_02_ROOM_21
				}
			),
			new DungeonMap("River Dungeon, 2nd floor, sub-area C", [
					"    [c]",
					" |   | ",
					"[a]—[b]",
				],
				{
					'a': DUNGEON_RIVER_FLOOR_02_ROOM_22,
					'b': DUNGEON_RIVER_FLOOR_02_ROOM_23,
					'c': DUNGEON_RIVER_FLOOR_02_ROOM_24
				}
			),
			new DungeonMap("River Dungeon, 2nd floor, sub-area D", [
					"[a]—   ",
					" |     ",
					"[b]—[c]",
				],
				{
					'a': DUNGEON_RIVER_FLOOR_02_ROOM_25,
					'b': DUNGEON_RIVER_FLOOR_02_ROOM_26,
					'c': DUNGEON_RIVER_FLOOR_02_ROOM_27
				}
			),
			new DungeonMap("River Dungeon, 3rd floor", [
					"                [s]        ",
					"         |       |         ",
					"        [c]-[b]-[a]        ",
					"             |             ",
					"[h]         [g]-[f]-[e]-[d]",
					" |           |   |       | ",
					"[n]-[m]-[l]-[k] [j]     [i]",
					" |       |       |         ",
					"[S]     [t]-[r]-[p]-[o]    ",
				],
				{
					's': DUNGEON_RIVER_FLOOR_03_ROOM_01,
					'a': DUNGEON_RIVER_FLOOR_03_ROOM_02,
					'b': DUNGEON_RIVER_FLOOR_03_ROOM_03,
					'c': DUNGEON_RIVER_FLOOR_03_ROOM_04,
					'd': DUNGEON_RIVER_FLOOR_03_ROOM_05,
					'e': DUNGEON_RIVER_FLOOR_03_ROOM_06,
					'f': DUNGEON_RIVER_FLOOR_03_ROOM_07,
					'g': DUNGEON_RIVER_FLOOR_03_ROOM_08,
					'h': DUNGEON_RIVER_FLOOR_03_ROOM_09,
					'i': DUNGEON_RIVER_FLOOR_03_ROOM_10,
					'j': DUNGEON_RIVER_FLOOR_03_ROOM_11,
					'k': DUNGEON_RIVER_FLOOR_03_ROOM_12,
					'l': DUNGEON_RIVER_FLOOR_03_ROOM_13,
					'm': DUNGEON_RIVER_FLOOR_03_ROOM_14,
					'n': DUNGEON_RIVER_FLOOR_03_ROOM_15,
					'o': DUNGEON_RIVER_FLOOR_03_ROOM_16,
					'p': DUNGEON_RIVER_FLOOR_03_ROOM_17,
					'r': DUNGEON_RIVER_FLOOR_03_ROOM_18, //s missed - used for stairs
					't': DUNGEON_RIVER_FLOOR_03_ROOM_19,
					'S': DUNGEON_RIVER_FLOOR_03_ROOM_20
				}
			),
			new DungeonMap("River Dungeon, 3rd floor, hall", [
					"[n]-[j]-[g]-[d]",
					" |   |   |   | ",
					"[m]-[i]-[f]-[c]",
					" |   |   |   | ",
					"[l]-[h]-[e]-[b]",
                    " L           | ",
                    "[k]         [a]",
					"             | ",
				],
				{
					'a': DUNGEON_RIVER_FLOOR_03_ROOM_21,
					'b': DUNGEON_RIVER_FLOOR_03_ROOM_22,
					'c': DUNGEON_RIVER_FLOOR_03_ROOM_23,
					'd': DUNGEON_RIVER_FLOOR_03_ROOM_24,
					'e': DUNGEON_RIVER_FLOOR_03_ROOM_25,
					'f': DUNGEON_RIVER_FLOOR_03_ROOM_26,
					'g': DUNGEON_RIVER_FLOOR_03_ROOM_27,
					'h': DUNGEON_RIVER_FLOOR_03_ROOM_28,
					'i': DUNGEON_RIVER_FLOOR_03_ROOM_29,
					'j': DUNGEON_RIVER_FLOOR_03_ROOM_30,
					'k': DUNGEON_RIVER_FLOOR_03_ROOM_31,
					'l': DUNGEON_RIVER_FLOOR_03_ROOM_32,
					'm': DUNGEON_RIVER_FLOOR_03_ROOM_33,
					'n': DUNGEON_RIVER_FLOOR_03_ROOM_34
				},
				function():Object { return {
					'L': flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 7 ? "|": "L"
				}; }
			),
			new DungeonMap("River Dungeon, 4th floor", [
					"[S]K[c]-[b]         [a]    ",
					"         |           L     ",
					"        [e]         [d]    ",
					"         |           |     ",
					"[j]     [i]-[h]-[g]-[f]-[s]",
					" |       |       |         ",
					"[n]-[m]-[l]     [k]        ",
					"     |           |         ",
					"    [u]     [t]-[r]-[p]-[o]",
					"     |       |       |     ",
					"    [z]-[y]-[x]     [w]    ",
				],
				{
					'a': DUNGEON_RIVER_FLOOR_04_ROOM_01,
					'b': DUNGEON_RIVER_FLOOR_04_ROOM_02,
					'c': DUNGEON_RIVER_FLOOR_04_ROOM_03,
					'S': DUNGEON_RIVER_FLOOR_04_ROOM_04,
					'd': DUNGEON_RIVER_FLOOR_04_ROOM_05,
					'e': DUNGEON_RIVER_FLOOR_04_ROOM_06,
					's': DUNGEON_RIVER_FLOOR_04_ROOM_07,
					'f': DUNGEON_RIVER_FLOOR_04_ROOM_08,
					'g': DUNGEON_RIVER_FLOOR_04_ROOM_09,
					'h': DUNGEON_RIVER_FLOOR_04_ROOM_10,
					'i': DUNGEON_RIVER_FLOOR_04_ROOM_11,
					'j': DUNGEON_RIVER_FLOOR_04_ROOM_12,
					'k': DUNGEON_RIVER_FLOOR_04_ROOM_13,
					'l': DUNGEON_RIVER_FLOOR_04_ROOM_14,
					'm': DUNGEON_RIVER_FLOOR_04_ROOM_15,
					'n': DUNGEON_RIVER_FLOOR_04_ROOM_16,
					'o': DUNGEON_RIVER_FLOOR_04_ROOM_17,
					'p': DUNGEON_RIVER_FLOOR_04_ROOM_18,
					'r': DUNGEON_RIVER_FLOOR_04_ROOM_19, //s missed - used for stairs
					't': DUNGEON_RIVER_FLOOR_04_ROOM_20,
					'u': DUNGEON_RIVER_FLOOR_04_ROOM_21,
					'w': DUNGEON_RIVER_FLOOR_04_ROOM_22,
					'x': DUNGEON_RIVER_FLOOR_04_ROOM_23,
					'y': DUNGEON_RIVER_FLOOR_04_ROOM_24,
					'z': DUNGEON_RIVER_FLOOR_04_ROOM_25
				},
				function():Object { return {
					'K': flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 11 ? "—": "L",
					'L': flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 9 ? "|": "L"
				}; }
			),
			new DungeonMap("River Dungeon, 5th floor", [
					"[S]—[a]—[b]     [c]—[d]—[e]",
					"         |       |         ",
					"        [f]—[g]—[h]        ",
					"         |       |         ",
					"[i]     [j]     [k]     [s]",
					" |       |       |       | ",
					"[l]—[m]—[n]     [o]—[p]—[r]",
					" |       |       |       | ",
					"[t]     [u]—[w]—[x]     [y]",
					" |           |           | ",
					"[z]         [A]         [B]",
					" |           |           | ",
					"[C]—[D]     [E]     [F]—[G]",
				],
				{
					'S': DUNGEON_RIVER_FLOOR_05_ROOM_01,
					'a': DUNGEON_RIVER_FLOOR_05_ROOM_02,
					'b': DUNGEON_RIVER_FLOOR_05_ROOM_03,
					'c': DUNGEON_RIVER_FLOOR_05_ROOM_04,
					'd': DUNGEON_RIVER_FLOOR_05_ROOM_05,
					'e': DUNGEON_RIVER_FLOOR_05_ROOM_06,
					'f': DUNGEON_RIVER_FLOOR_05_ROOM_07,
					'g': DUNGEON_RIVER_FLOOR_05_ROOM_08,
					'h': DUNGEON_RIVER_FLOOR_05_ROOM_09,
					'i': DUNGEON_RIVER_FLOOR_05_ROOM_10,
					'j': DUNGEON_RIVER_FLOOR_05_ROOM_11,
					'k': DUNGEON_RIVER_FLOOR_05_ROOM_12,
					's': DUNGEON_RIVER_FLOOR_05_ROOM_13,
					'l': DUNGEON_RIVER_FLOOR_05_ROOM_14,
					'm': DUNGEON_RIVER_FLOOR_05_ROOM_15,
					'n': DUNGEON_RIVER_FLOOR_05_ROOM_16,
					'o': DUNGEON_RIVER_FLOOR_05_ROOM_17,
					'p': DUNGEON_RIVER_FLOOR_05_ROOM_18,
					'r': DUNGEON_RIVER_FLOOR_05_ROOM_19, //s missed - used for stairs
					't': DUNGEON_RIVER_FLOOR_05_ROOM_20,
					'u': DUNGEON_RIVER_FLOOR_05_ROOM_21,
					'w': DUNGEON_RIVER_FLOOR_05_ROOM_22,
					'x': DUNGEON_RIVER_FLOOR_05_ROOM_23,
					'y': DUNGEON_RIVER_FLOOR_05_ROOM_24,
					'z': DUNGEON_RIVER_FLOOR_05_ROOM_25,
					'A': DUNGEON_RIVER_FLOOR_05_ROOM_26,
					'B': DUNGEON_RIVER_FLOOR_05_ROOM_27,
					'C': DUNGEON_RIVER_FLOOR_05_ROOM_28,
					'D': DUNGEON_RIVER_FLOOR_05_ROOM_29,
					'E': DUNGEON_RIVER_FLOOR_05_ROOM_30,
					'F': DUNGEON_RIVER_FLOOR_05_ROOM_31,
					'G': DUNGEON_RIVER_FLOOR_05_ROOM_32
				}
			),
			new DungeonMap("River Dungeon, 6th floor", [
					//"[b]—[c]",
					//" |     ",
					"[a]—   ",
				],
				{
					'a': DUNGEON_RIVER_FLOOR_06_ROOM_01,
					'b': DUNGEON_RIVER_FLOOR_06_ROOM_02,
					'c': DUNGEON_RIVER_FLOOR_06_ROOM_03
				}
			),/*
			new DungeonMap("River Dungeon, 7th floor", [
					"[a]—   ",
					" |     ",
					"[b]—[c]",
				],
				{
					'a': DUNGEON_RIVER_FLOOR_07_ROOM_01,
					'b': DUNGEON_RIVER_FLOOR_07_ROOM_02,
					'c': DUNGEON_RIVER_FLOOR_07_ROOM_03
				}
			),*/
            //TODO: place other RD levels here/*
            //FFS, ANOTHER TOWER, I HATE YOU
			new DungeonMap("Anzu's Palace, 1st floor", [
					"[c]     [e]",
					" |       | ",
					"[b]—[S]—[d]",
					"     |     ",
					"    [a]    ",
					"     |     ",
				],
				{
					'a': DUNGEON_ANZU_OUTSIDE,
					'S': DUNGEON_ANZU_HALL_FLOOR1,
					'b': DUNGEON_ANZU_LIVING_ROOM,
					'c': DUNGEON_ANZU_BATHROOM,
					'd': DUNGEON_ANZU_DINING_ROOM,
					'e': DUNGEON_ANZU_KITCHEN
				}
			),
			new DungeonMap("Anzu's Palace, 2nd floor", [
					"    [c]    ",
					"     |     ",
					"[a]—[S]—[b]",
					"           ",
					"           ",
					"           ",
				],
				{
					'S': DUNGEON_ANZU_HALL_FLOOR2,
					'a': DUNGEON_ANZU_BEDROOM,
					'b': DUNGEON_ANZU_LIBRARY,
					'c': DUNGEON_ANZU_MULTIUSE_ROOM
				}
			),
			new DungeonMap("Anzu's Palace, 3rd floor", [
					"           ",
					"           ",
					"[a]—[S]—[b]",
					"           ",
					"           ",
					"           ",
				],
				{
					'S': DUNGEON_ANZU_HALL_FLOOR3,
					'a': DUNGEON_ANZU_PALACE_VAULTS,
					'b': DUNGEON_ANZU_ALCHEMY_ROOM
				}
			),
			new DungeonMap("Anzu's Palace, roof", [
					"           ",
					"           ",
					"    [s]    ",
					"           ",
					"           ",
					"           ",
				],
				{
					's': DUNGEON_ANZU_ROOF
				}
			),
			new DungeonMap("Anzu's Palace, basement", [
					"           ",
					"           ",
					"[a]—[s]    ",
					"           ",
					"           ",
					"           ",
				],
				{
					's': DUNGEON_ANZU_BASEMENT,
					'a': DUNGEON_ANZU_ARMORY
				}
			),
			new DungeonMap("Ebon Labyrinth", [
                    "   |  ",
                    " —[a]—",
                    "   |  ",
					"Did you <i>REALLY</i> expect a to get a <b>map</b> of a <b>labyrinth</b>?",
				],
				{
					'a': DUNGEON_EBON_LABYRINTH
				}
			),
			new DungeonMap("Bee Hive", [
                    "    [e]    ",
					"     |     ",
					"[d]-[c]-[b]",
					"     |     ",
					"    [a]    ",
					"     |     ",
				],
				{
					'a': DUNGEON_BEE_HIVE_1,
					'b': DUNGEON_BEE_HIVE_2,
					'c': DUNGEON_BEE_HIVE_3,
					'd': DUNGEON_BEE_HIVE_4,
					'e': DUNGEON_BEE_HIVE_5
				}
			),
			new DungeonMap("Demon Lab", [
					"    [i]    ",
					"     L     ",
					"    [g]K[S]",
					"     |     ",
					"[e]K[d]—[f]",
					"     |     ",
					"[s]K[b]    ",
					"     |     ",
					"    [a]    ",
				],
				{
					'a': DUNGEON_LAB_ENTRANCE,
					'b': DUNGEON_LAB_BALLROOM_1,
					's': DUNGEON_LAB_TYRANT_1,
					'd': DUNGEON_LAB_BALLROOM_2,
					'e': DUNGEON_LAB_FSPREADER,
					'f': DUNGEON_LAB_INCEL,
					'g': DUNGEON_LAB_BALLROOM_3,
					'S': DUNGEON_LAB_NIGHTWALKER_1,
					'i': DUNGEON_LAB_PANIC_ROOM
				},
				function():Object { return {
					'K': dungeons.demonLab.hasKeycard() ? "—": "L",
					'L': dungeons.demonLab.canEnterPanic() ? "|": "L"
				}; }
			),
			new DungeonMap("Demon Lab, drider prison", [
					"    [b]    ",
					"     |     ",
					"    [s]    ",
				],
				{
					's': DUNGEON_LAB_TYRANT_PRISON,
					'b': DUNGEON_LAB_TYRANT_2
				}
			),
			new DungeonMap("Demon Lab, Nightwalker cave", [
					"    [a]    ",
				],
				{
					'a': DUNGEON_LAB_NIGHTWALKER_2
				}
			),
            //D3 maps. Note that they use 'currentRoom' instead of 'dungeonLoc'
			new DungeonMap("Basilisk Cave", [
                    "     [g]—   ",
                    "      |     ",
                    "     [f]    ",
                    "      |     ",
                    "     [e]    ",
                    "      |     ",
                    "     [c]—[d]",
                    "      |     ",
                    "—[a]—[b]    ",
				],
				{
					'a': "entrance",
					'b': "tunnel1",
					'c': "antechamber",
					'd': "roomofmirrors",
					'e': "magpiehalls",
					'f': "magpiehalln",
					'g': "tunnel2"
				}
			),
			new DungeonMap("Lethice's Keep", [
                    "    [r]    ",
                    "     L     ",
                    "[h]—[i]—[j]",
                    " |       | ",
                    "[g]     [k]",
                    " |       | ",
                    "[f]—[o]—[l]",
                    " |       | ",
                    "[e]     [m]",
                    " |       | ",
                    "[d]—[c]—[n]",
                    "     |   | ",
                    "    [b] [p]",
                    "     |     ",
                    "   —[a]    ",
				],
				{
					'a': "edgeofkeep",
					'b': "northentry",
					'c': "southcourtyard",
					'd': "southwestcourtyard",
					'e': "southwestwalk",
					'f': "westwalk",
					'g': "northwestwalk",
					'h': "northwestcourtyard",
					'i': "northcourtyard",
					'j': "northeastcourtyard",
					'k': "northeastwalk",
					'l': "eastwalk",
					'm': "southeastwalk",
					'n': "southeastcourtyard",
					'o': "courtyardsquare",
					'p': "greatlift",
					'r': "throneroom"
				},
				function():Object { return {
					'L': SceneLib.d3.unlockedThroneRoom() ? "|": "L"
				}; }
			),
		];

        //not sure if it's still needed, but I'll leave it there
        /* - layout for future dungeon use
        "    [ ]             [ ]    ",
        "     |               |     ",
        "[ ]—[ ]—[ ]—[ ]—[ ]—[ ]—[ ]",
        "     |               |     ",
        "    [ ]             [ ]    ",
        "     |               |     ",
        "    [ ]     [T]—[ ]—[ ]    ",
        "     |           |         ",
        "    [ ]         [ ]        ",
        "     |           |         ",
        "[ ]—[ ]—[ ]—[ ]—[ ]—[ ]—[ ]",
        "     |               |     ",
        "    [ ]—[ ]—[ ]     [ ]    ",
        "     |       |             ",
        "    [ ]     [P]            ",
		*/

		public function chooseRoomToDisplay(location:*):void {
			for each (var map:DungeonMap in maps)
				if (map.playerIsHere(location)) {
					rawOutputText(map.parseMap(location));
					return;
				}
            //should never be reached.
            outputText("<b>ERROR: No map for this area.</b>");
		}
		
		public function displayMap():void {
			clearOutput();
			outputText("<b><font face=\"_typewriter\">");
			if (inRoomedDungeon)
				chooseRoomToDisplay(SceneLib.d3._currentRoom);
			else
                chooseRoomToDisplay(dungeonLoc);
			outputText("</font></b>");
			outputText("\n\n<b><u>Legend</u></b>");
			outputText("\n<font face=\"_typewriter\"><b>P</b></font> — Player Location");
			outputText("\n<font face=\"_typewriter\"><b>L</b></font> — Locked Door");
			outputText("\n<font face=\"_typewriter\"><b>S,s</b></font> — Stairs");
			menu();
			addButton(0, "Close Map", playerMenu);
		}
        
		public function displayMapOnlyOne():void {
			player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
			displayMap();
		}
		
	}

}