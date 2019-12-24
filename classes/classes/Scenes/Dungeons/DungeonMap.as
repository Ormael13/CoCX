package classes.Scenes.Dungeons {
import classes.*;
import classes.GlobalFlags.*;
import classes.Scenes.SceneLib;

public class DungeonMap extends BaseContent
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
		
		public function chooseRoomToDisplay():void {
			if (DungeonAbstractContent.dungeonLoc >= 0 && DungeonAbstractContent.dungeonLoc < 10) { //Factory
				outputText("Factory, " + (DungeonAbstractContent.dungeonLoc >= 6 && DungeonAbstractContent.dungeonLoc < 9 ? "2": "1") + "F");
				if (DungeonAbstractContent.dungeonLoc == 0) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[P]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 1) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[P]");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 2) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[P]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 3) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[P]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 4) {
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 5) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[P]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 6) {
					rawOutputText("\n[P]—[ ]    ");
					findLockedDoor2();
					rawOutputText("\n[ ]        ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 7) {
					rawOutputText("\n[S]—[P]    ");
					findLockedDoor2();
					rawOutputText("\n[ ]        ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 8) {
					rawOutputText("\n[S]—[ ]    ");
					findLockedDoor2();
					rawOutputText("\n[P]        ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 9) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[P]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
			}
			else if (DungeonAbstractContent.dungeonLoc >= 10 && DungeonAbstractContent.dungeonLoc < 17) { //Zetaz's Lair
				rawOutputText("Zetaz's Lair");
				if (DungeonAbstractContent.dungeonLoc == 10) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 11) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 12) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[P]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 13) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[P]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 14) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[P]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 15) {
					rawOutputText("\n    [ ]—[P]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 16) {
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
			else if (DungeonAbstractContent.dungeonLoc >= 17 && DungeonAbstractContent.dungeonLoc < 23) { //Tower of the Phoenix
				rawOutputText("Tower of the Phoenix");
				if (DungeonAbstractContent.dungeonLoc == 17) {
					rawOutputText(", 1F");
					rawOutputText("\n    [S]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 18) {
					rawOutputText(", B1");
					rawOutputText("\n    [S]    ");
					rawOutputText("\n           ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 19) {
					rawOutputText(", 1F");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [S]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 20) {
					rawOutputText(", B1");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n           ");
					rawOutputText("\n    [S]    ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 21) {
					rawOutputText(", 2F");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 22) {
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
			else if (DungeonAbstractContent.dungeonLoc >= 23 && DungeonAbstractContent.dungeonLoc < 39) {
				rawOutputText("Cave of the Sand Witches");
				if (DungeonAbstractContent.dungeonLoc == 23) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [P] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 24) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[P]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 25) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[P]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 26) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [P] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 27) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [P] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 28) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[P]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 29) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[P] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 30) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[P] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 31) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[P]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 32) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [P]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 33) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[P]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 34) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[P]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 35) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[P]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 36) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [P]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 37) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [P] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 38) {
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
			else if (DungeonAbstractContent.dungeonLoc >= 39 && DungeonAbstractContent.dungeonLoc < 64) { //Hidden Cave
				rawOutputText("Hidden Cave");
				if (DungeonAbstractContent.dungeonLoc == 39) {
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
				else if (DungeonAbstractContent.dungeonLoc == 40) {
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
				else if (DungeonAbstractContent.dungeonLoc == 41) {
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
				else if (DungeonAbstractContent.dungeonLoc == 42) {
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
				else if (DungeonAbstractContent.dungeonLoc == 43) {
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
				else if (DungeonAbstractContent.dungeonLoc == 44) {
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
				else if (DungeonAbstractContent.dungeonLoc == 45) {
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
				else if (DungeonAbstractContent.dungeonLoc == 46) {
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
				else if (DungeonAbstractContent.dungeonLoc == 47) {
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
				else if (DungeonAbstractContent.dungeonLoc == 48) {
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
				else if (DungeonAbstractContent.dungeonLoc == 49) {
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
				else if (DungeonAbstractContent.dungeonLoc == 50) {
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
				else if (DungeonAbstractContent.dungeonLoc == 51) {
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
				else if (DungeonAbstractContent.dungeonLoc == 52) {
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
				else if (DungeonAbstractContent.dungeonLoc == 53) {
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
				else if (DungeonAbstractContent.dungeonLoc == 54) {
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
					if (DungeonAbstractContent.dungeonLoc == 55) {
						rawOutputText(", Stone Staircase Basement");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [P]");
					}
					else if (DungeonAbstractContent.dungeonLoc == 56) {
						rawOutputText(", Tunnel");
						rawOutputText("\n[ ]—[ ]—[P]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (DungeonAbstractContent.dungeonLoc == 57) {
						rawOutputText(", Tunnel");
						rawOutputText("\n[ ]—[P]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (DungeonAbstractContent.dungeonLoc == 58) {
						rawOutputText(", Tunnel");
						rawOutputText("\n[P]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (DungeonAbstractContent.dungeonLoc == 59) {
						rawOutputText(", Ted's Lair");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[P]     [S]");
					}
				}
				else if (flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] > 0) {
					if (DungeonAbstractContent.dungeonLoc == 55) {
						rawOutputText(", Stone Staircase Basement");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [P]");
					}
					else if (DungeonAbstractContent.dungeonLoc == 56) {
						rawOutputText(", Tunnel");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[P]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (DungeonAbstractContent.dungeonLoc == 57) {
						rawOutputText(", Tunnel");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[P]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (DungeonAbstractContent.dungeonLoc == 58) {
						rawOutputText(", Tunnel");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[P]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (DungeonAbstractContent.dungeonLoc == 59) {
						rawOutputText(", Ted's Lair");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[P]     [S]");
					}
					else if (DungeonAbstractContent.dungeonLoc == 60) {
						rawOutputText(", Small Cave (W)");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[P]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (DungeonAbstractContent.dungeonLoc == 61) {
						rawOutputText(", Medium Cave");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[P]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (DungeonAbstractContent.dungeonLoc == 62) {
						rawOutputText(", Small Cave (E)");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[P]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (DungeonAbstractContent.dungeonLoc == 63) {
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
			else if (DungeonAbstractContent.dungeonLoc >= 64 && DungeonAbstractContent.dungeonLoc < 68) { //Den of Desire
				rawOutputText("Den of Desire");
				if (DungeonAbstractContent.dungeonLoc == 64) {
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
				else if (DungeonAbstractContent.dungeonLoc == 64) {
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
				else if (DungeonAbstractContent.dungeonLoc == 66) {
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
				else if (DungeonAbstractContent.dungeonLoc == 67) {
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
			else if (DungeonAbstractContent.dungeonLoc >= 68 && DungeonAbstractContent.dungeonLoc < 88) { //River Dungeon: Floor 1
				rawOutputText("River Dungeon");
				if (DungeonAbstractContent.dungeonLoc == 68) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[P]-[ ]     [S]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 69) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[P]     [S]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 70) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [P]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 71) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[P]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 72) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[P]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 73) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [P]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 74) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[P]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 75) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[P]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 76) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [ ]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[P]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 77) {
					rawOutputText(", Floor 1");
					rawOutputText("\n        [P]    ");
					rawOutputText("\n |       |     ");
					rawOutputText("\n[ ]-[ ]-[ ]    ");
					rawOutputText("\n     |       | ");
					rawOutputText("\n    [ ]-[ ]-[ ]");
					rawOutputText("\n     |       | ");
					rawOutputText("\n[S]-[ ]     [S]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 78) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[ ]");
					rawOutputText("\n         | ");
					rawOutputText("\n        [P]");
					rawOutputText("\n         | ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 79) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[P]");
					rawOutputText("\n         | ");
					rawOutputText("\n        [ ]");
					rawOutputText("\n         | ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 80) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[P]-[ ]");
					rawOutputText("\n         | ");
					rawOutputText("\n        [ ]");
					rawOutputText("\n         | ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 81) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[P]-[ ]-[ ]");
					rawOutputText("\n         | ");
					rawOutputText("\n        [ ]");
					rawOutputText("\n         | ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 82) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[ ]");
					rawOutputText("\n         | ");
					rawOutputText("\n        [ ]");
					rawOutputText("\n         | ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 83) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[ ]");
					rawOutputText("\n |         ");
					rawOutputText("\n[P]        ");
					rawOutputText("\n |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 84) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[P]-[ ]-[ ]");
					rawOutputText("\n |         ");
					rawOutputText("\n[ ]        ");
					rawOutputText("\n |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 85) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[P]-[ ]");
					rawOutputText("\n |         ");
					rawOutputText("\n[ ]        ");
					rawOutputText("\n |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 86) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[P]");
					rawOutputText("\n |         ");
					rawOutputText("\n[ ]        ");
					rawOutputText("\n |         ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 87) {
					rawOutputText(", Floor 1");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]-[ ]-[ ]");
					rawOutputText("\n |         ");
					rawOutputText("\n[ ]        ");
					rawOutputText("\n |         ");
				}
			}
			else if (DungeonAbstractContent.dungeonLoc >= 88 && DungeonAbstractContent.dungeonLoc < 104) { //Anzu's Palace
				rawOutputText("Anzu's Palace");
				if (DungeonAbstractContent.dungeonLoc == 88) {
					rawOutputText(", Palace Grounds");
					rawOutputText("\n[ ]     [ ]");
					rawOutputText("\n |       | ");
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 89) {
					rawOutputText(", Hall, Floor 1");
					rawOutputText("\n[ ]     [ ]");
					rawOutputText("\n |       | ");
					rawOutputText("\n[ ]—[P]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 90) {
					rawOutputText(", Living Room");
					rawOutputText("\n[ ]     [ ]");
					rawOutputText("\n |       | ");
					rawOutputText("\n[P]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 91) {
					rawOutputText(", Bathroom");
					rawOutputText("\n[P]     [ ]");
					rawOutputText("\n |       | ");
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 92) {
					rawOutputText(", Dining Room");
					rawOutputText("\n[ ]     [ ]");
					rawOutputText("\n |       | ");
					rawOutputText("\n[ ]—[ ]—[P]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 93) {
					rawOutputText(", Kitchen");
					rawOutputText("\n[ ]     [P]");
					rawOutputText("\n |       | ");
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 94) {
					rawOutputText(", Hall, Floor 2");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]—[P]—[ ]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 95) {
					rawOutputText(", Bedroom");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[P]—[ ]—[ ]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 96) {
					rawOutputText(", Library");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]—[ ]—[P]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 97) {
					rawOutputText(", Multi-use Room");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[ ]—[ ]—[ ]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 98) {
					rawOutputText(", Hall, Floor 3");
					rawOutputText("\n           ");
					rawOutputText("\n[ ]—[P]—[ ]");
					rawOutputText("\n           ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 99) {
					rawOutputText(", Vault");
					rawOutputText("\n           ");
					rawOutputText("\n[P]—[ ]—[ ]");
					rawOutputText("\n           ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 100) {
					rawOutputText(", Alchemy Room");
					rawOutputText("\n           ");
					rawOutputText("\n[ ]—[ ]—[P]");
					rawOutputText("\n           ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 101) {
					rawOutputText(", Roof");
					rawOutputText("\n           ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n           ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 102) {
					rawOutputText(", Basement");
					rawOutputText("\n           ");
					rawOutputText("\n[ ]—[P]    ");
					rawOutputText("\n           ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 103) {
					rawOutputText(", Armory");
					rawOutputText("\n           ");
					rawOutputText("\n[P]—[ ]    ");
					rawOutputText("\n           ");
				}
			}
			else if (DungeonAbstractContent.dungeonLoc >= 104 && DungeonAbstractContent.dungeonLoc < 131) { //River Dungeon: Floor 2
				rawOutputText("River Dungeon");
				if (DungeonAbstractContent.dungeonLoc == 104) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[P] [ ]-[ ]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 105) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[P]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[ ]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 106) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[ ]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[P]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 107) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[ ]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [P]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 108) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [P]-[ ]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 109) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[P]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[ ]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 110) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[ ]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[P]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 111) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[P]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 112) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[P]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[ ]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 113) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[ ]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[P]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 114) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[ ]-[P] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 115) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[P]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[ ]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 116) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [P]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[ ]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 117) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[ ]-[ ] [ ]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[P]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 118) {
					rawOutputText(", Floor 2");
					rawOutputText("\n            [ ]-   ");
					rawOutputText("\n |           |     ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ]    ");
					rawOutputText("\n |   |   |   |     ");
					rawOutputText("\n[ ] [ ]-[ ]-[ ] [P]");
					rawOutputText("\n     |   |   |   | ");
					rawOutputText("\n    [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n     |           | ");
					rawOutputText("\n   -[ ]            ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 119) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[ ]—[P]");
					rawOutputText("\n |   | ");
					rawOutputText("\n[ ]    ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 120) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[P]—[ ]");
					rawOutputText("\n |   | ");
					rawOutputText("\n[ ]    ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 121) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[ ]—[ ]");
					rawOutputText("\n |   | ");
					rawOutputText("\n[P]    ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 122) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[ ]—[ ]");
					rawOutputText("\n     | ");
					rawOutputText("\n   —[P]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 123) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[ ]—[P]");
					rawOutputText("\n     | ");
					rawOutputText("\n   —[ ]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 124) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[P]—[ ]");
					rawOutputText("\n     | ");
					rawOutputText("\n   —[ ]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 125) {
					rawOutputText(", Floor 2");
					rawOutputText("\n    [ ]");
					rawOutputText("\n |   | ");
					rawOutputText("\n[P]—[ ]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 126) {
					rawOutputText(", Floor 2");
					rawOutputText("\n    [ ]");
					rawOutputText("\n |   | ");
					rawOutputText("\n[ ]—[P]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 127) {
					rawOutputText(", Floor 2");
					rawOutputText("\n    [P]");
					rawOutputText("\n |   | ");
					rawOutputText("\n[ ]—[ ]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 128) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[P]—   ");
					rawOutputText("\n |     ");
					rawOutputText("\n[ ]—[ ]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 129) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[ ]—   ");
					rawOutputText("\n |     ");
					rawOutputText("\n[P]—[ ]");
				}
				else if (DungeonAbstractContent.dungeonLoc == 130) {
					rawOutputText(", Floor 2");
					rawOutputText("\n[ ]—   ");
					rawOutputText("\n |     ");
					rawOutputText("\n[ ]—[P]");
				}
			}
			else if (DungeonAbstractContent.dungeonLoc >= 131 && DungeonAbstractContent.dungeonLoc < 135) { //Ebon Labyrinth
				rawOutputText("Ebon Labyrinth");
				if (DungeonAbstractContent.dungeonLoc == 131) {
					rawOutputText(", Corridor");
					rawOutputText("\n   |   |   ");
					rawOutputText("\n —[P]—[ ]— ");
					rawOutputText("\n   |   |   ");
					rawOutputText("\n —[ ]—[ ]— ");
					rawOutputText("\n   |   |   ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 132) {
					rawOutputText(", Corridor");
					rawOutputText("\n   |   |   ");
					rawOutputText("\n —[ ]—[P]— ");
					rawOutputText("\n   |   |   ");
					rawOutputText("\n —[ ]—[ ]— ");
					rawOutputText("\n   |   |   ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 133) {
					rawOutputText(", Corridor");
					rawOutputText("\n   |   |   ");
					rawOutputText("\n —[ ]—[ ]— ");
					rawOutputText("\n   |   |   ");
					rawOutputText("\n —[ ]—[P]— ");
					rawOutputText("\n   |   |   ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 134) {
					rawOutputText(", Corridor");
					rawOutputText("\n   |   |   ");
					rawOutputText("\n —[ ]—[ ]— ");
					rawOutputText("\n   |   |   ");
					rawOutputText("\n —[P]—[ ]— ");
					rawOutputText("\n   |   |   ");
				}
			}
			else if (DungeonAbstractContent.dungeonLoc >= 135 && DungeonAbstractContent.dungeonLoc < 165) { //River Dungeon: Floor 3
				rawOutputText("River Dungeon");
				if (DungeonAbstractContent.dungeonLoc == 135) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [P]        ");
					rawOutputText("\n                 |         ");
					rawOutputText("\n       -[ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[ ]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 136) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [ ]        ");
					rawOutputText("\n                 |         ");
					rawOutputText("\n       -[ ]-[ ]-[P]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[ ]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 137) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [ ]        ");
					rawOutputText("\n                 |         ");
					rawOutputText("\n       -[ ]-[P]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[ ]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 138) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [ ]        ");
					rawOutputText("\n                 |         ");
					rawOutputText("\n       -[P]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[ ]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 139) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [ ]        ");
					rawOutputText("\n                 |         ");
					rawOutputText("\n       -[ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[ ]-[P]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[ ]     [ ]-[ ]-[ ]-[ ]    ");
				}
				else if (DungeonAbstractContent.dungeonLoc == 140) {
					rawOutputText(", Floor 3");
					rawOutputText("\n                [ ]        ");
					rawOutputText("\n                 |         ");
					rawOutputText("\n       -[ ]-[ ]-[ ]        ");
					rawOutputText("\n             |             ");
					rawOutputText("\n[ ]         [ ]-[ ]-[P]-[ ]");
					rawOutputText("\n |           |   |       | ");
					rawOutputText("\n[ ]-[ ]-[ ]-[ ] [ ]     [ ]");
					rawOutputText("\n |       |       |         ");
					rawOutputText("\n[ ]     [ ]-[ ]-[ ]-[ ]    ");
				}
			}
			
			
			
		}
		/* - layout for future dungeon use
					if (CoC.instance.dungeonLoc == 55) {
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
		public function displayMap2():void {
			clearOutput();
			player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
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
		
	}

}