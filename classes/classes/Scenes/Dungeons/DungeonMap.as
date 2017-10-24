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
			if (kGAMECLASS.dungeonLoc >= 0 && kGAMECLASS.dungeonLoc < 10) { //Factory
				outputText("Factory, " + (kGAMECLASS.dungeonLoc >= 6 && kGAMECLASS.dungeonLoc < 9 ? "2": "1") + "F");
				if (kGAMECLASS.dungeonLoc == 0) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[P]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (kGAMECLASS.dungeonLoc == 1) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[P]");
					rawOutputText("\n     |     ");
				}
				else if (kGAMECLASS.dungeonLoc == 2) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[P]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (kGAMECLASS.dungeonLoc == 3) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[P]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (kGAMECLASS.dungeonLoc == 4) {
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (kGAMECLASS.dungeonLoc == 5) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[P]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
				else if (kGAMECLASS.dungeonLoc == 6) {
					rawOutputText("\n[P]—[ ]    ");
					findLockedDoor2();
					rawOutputText("\n[ ]        ");
				}
				else if (kGAMECLASS.dungeonLoc == 7) {
					rawOutputText("\n[S]—[P]    ");
					findLockedDoor2();
					rawOutputText("\n[ ]        ");
				}
				else if (kGAMECLASS.dungeonLoc == 8) {
					rawOutputText("\n[S]—[ ]    ");
					findLockedDoor2();
					rawOutputText("\n[P]        ");
				}
				else if (kGAMECLASS.dungeonLoc == 9) {
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n[S]—[ ]—[ ]");
					findLockedDoor1();
					rawOutputText("\n[P]—[ ]—[ ]");
					rawOutputText("\n     |     ");
				}
			}
			else if (kGAMECLASS.dungeonLoc >= 10 && kGAMECLASS.dungeonLoc < 17) { //Zetaz's Lair
				rawOutputText("Zetaz's Lair");
				if (kGAMECLASS.dungeonLoc == 10) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
				}
				else if (kGAMECLASS.dungeonLoc == 11) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (kGAMECLASS.dungeonLoc == 12) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[P]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (kGAMECLASS.dungeonLoc == 13) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[P]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (kGAMECLASS.dungeonLoc == 14) {
					rawOutputText("\n    [ ]—[ ]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[P]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (kGAMECLASS.dungeonLoc == 15) {
					rawOutputText("\n    [ ]—[P]");
					findLockedDoor3();
					rawOutputText("\n[ ]—[ ]—[ ]");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [ ]    ");
					rawOutputText("\n     |     ");
				}
				else if (kGAMECLASS.dungeonLoc == 16) {
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
			else if (kGAMECLASS.dungeonLoc >= 17 && kGAMECLASS.dungeonLoc < 23) { //Tower of the Phoenix
				rawOutputText("Tower of the Phoenix");
				if (kGAMECLASS.dungeonLoc == 17) {
					rawOutputText(", 1F");
					rawOutputText("\n    [S]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (kGAMECLASS.dungeonLoc == 18) {
					rawOutputText(", B1");
					rawOutputText("\n    [S]    ");
					rawOutputText("\n           ");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (kGAMECLASS.dungeonLoc == 19) {
					rawOutputText(", 1F");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n    [S]    ");
					rawOutputText("\n     |     ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (kGAMECLASS.dungeonLoc == 20) {
					rawOutputText(", B1");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n           ");
					rawOutputText("\n    [S]    ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (kGAMECLASS.dungeonLoc == 21) {
					rawOutputText(", 2F");
					rawOutputText("\n    [P]    ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
					rawOutputText("\n           ");
				}
				else if (kGAMECLASS.dungeonLoc == 22) {
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
			else if (kGAMECLASS.dungeonLoc >= 23 && kGAMECLASS.dungeonLoc < 39) {
				rawOutputText("Cave of the Sand Witches");
				if (kGAMECLASS.dungeonLoc == 23) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [P] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 24) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[P]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 25) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[P]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 26) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [P] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 27) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [P] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 28) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[P]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 29) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[P] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 30) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[P] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 31) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[P]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 32) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [P]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 33) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[P]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 34) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[P]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 35) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[P]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 36) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [P]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 37) {
					rawOutputText("\n        [ ]        ");
					rawOutputText("\n         |         ");
					rawOutputText("\n[ ] [ ] [P] [ ]—[ ]");
					findLockedDoor4();
					rawOutputText("\n[ ]—[ ]—[ ]—[ ]—[ ]");
					rawOutputText("\n |   |   |       | ");
					rawOutputText("\n[ ] [ ] [ ] [ ]—[ ]");
					rawOutputText("\n         |         ");
				}
				else if (kGAMECLASS.dungeonLoc == 38) {
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
			else if (kGAMECLASS.dungeonLoc >= 39 && kGAMECLASS.dungeonLoc < 64) { //Hidden Cave
				rawOutputText("Hidden Cave");
				if (kGAMECLASS.dungeonLoc == 39) {
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
				else if (kGAMECLASS.dungeonLoc == 40) {
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
				else if (kGAMECLASS.dungeonLoc == 41) {
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
				else if (kGAMECLASS.dungeonLoc == 42) {
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
				else if (kGAMECLASS.dungeonLoc == 43) {
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
				else if (kGAMECLASS.dungeonLoc == 44) {
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
				else if (kGAMECLASS.dungeonLoc == 45) {
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
				else if (kGAMECLASS.dungeonLoc == 46) {
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
				else if (kGAMECLASS.dungeonLoc == 47) {
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
				else if (kGAMECLASS.dungeonLoc == 48) {
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
				else if (kGAMECLASS.dungeonLoc == 49) {
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
				else if (kGAMECLASS.dungeonLoc == 50) {
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
				else if (kGAMECLASS.dungeonLoc == 51) {
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
				else if (kGAMECLASS.dungeonLoc == 52) {
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
				else if (kGAMECLASS.dungeonLoc == 53) {
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
				else if (kGAMECLASS.dungeonLoc == 54) {
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
					if (kGAMECLASS.dungeonLoc == 55) {
						rawOutputText(", Stone Staircase Basement");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [P]");
					}
					else if (kGAMECLASS.dungeonLoc == 56) {
						rawOutputText(", Tunnel");
						rawOutputText("\n[ ]—[ ]—[P]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (kGAMECLASS.dungeonLoc == 57) {
						rawOutputText(", Tunnel");
						rawOutputText("\n[ ]—[P]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (kGAMECLASS.dungeonLoc == 58) {
						rawOutputText(", Tunnel");
						rawOutputText("\n[P]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (kGAMECLASS.dungeonLoc == 59) {
						rawOutputText(", Ted's Lair");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[P]     [S]");
					}
				}
				else if (flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] > 0) {
					if (kGAMECLASS.dungeonLoc == 55) {
						rawOutputText(", Stone Staircase Basement<");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [P]");
					}
					else if (kGAMECLASS.dungeonLoc == 56) {
						rawOutputText(", Tunnel");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[P]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (kGAMECLASS.dungeonLoc == 57) {
						rawOutputText(", Tunnel");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[P]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (kGAMECLASS.dungeonLoc == 58) {
						rawOutputText(", Tunnel");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[P]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (kGAMECLASS.dungeonLoc == 59) {
						rawOutputText(", Ted's Lair");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[P]     [S]");
					}
					else if (kGAMECLASS.dungeonLoc == 60) {
						rawOutputText(", Small Cave (W)");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[P]—[ ]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (kGAMECLASS.dungeonLoc == 61) {
						rawOutputText(", Medium Cave");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[P]—[ ]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (kGAMECLASS.dungeonLoc == 62) {
						rawOutputText(", Small Cave (E)");
						rawOutputText("\n    [ ]    ");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[P]");
						rawOutputText("\n     |     ");
						rawOutputText("\n[ ]—[ ]—[ ]");
						rawOutputText("\n |       | ");
						rawOutputText("\n[ ]     [S]");
					}
					else if (kGAMECLASS.dungeonLoc == 63) {
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
			else if (kGAMECLASS.dungeonLoc >= 64 && kGAMECLASS.dungeonLoc < 68) { //Den of Desire
				rawOutputText("Den of Desire");
				if (kGAMECLASS.dungeonLoc == 64) {
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
				else if (kGAMECLASS.dungeonLoc == 64) {
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
				else if (kGAMECLASS.dungeonLoc == 66) {
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
				else if (kGAMECLASS.dungeonLoc == 67) {
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
		}
		/* - layout for future dungeon use
					if (kGAMECLASS.dungeonLoc == 55) {
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
		
	}

}