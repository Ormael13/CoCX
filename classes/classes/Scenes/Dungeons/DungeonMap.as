package classes.Scenes.Dungeons {
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Scenes.Dungeons.*;
	
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
			if (kGAMECLASS.d3.unlockedThroneRoom()) rawOutputText("\n      |      ");
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
		}
		
		public function chooseRoomToDisplayD3():void {
			//Basilisk Cave
			if (getGame().d3._currentRoom == "entrance") {
				rawOutputText("Basilisk Cave");
				rawOutputText("\n     [ ]—   ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]    ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]—[ ]");
				rawOutputText("\n      |     ");
				rawOutputText("\n—[P]—[ ]    ");
			}
			else if (getGame().d3._currentRoom == "tunnel1") {
				rawOutputText("Basilisk Cave");
				rawOutputText("\n     [ ]—   ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]    ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]—[ ]");
				rawOutputText("\n      |     ");
				rawOutputText("\n—[ ]—[P]    ");
			}
			else if (getGame().d3._currentRoom == "antechamber") {
				rawOutputText("Basilisk Cave");
				rawOutputText("\n     [ ]—   ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]    ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [P]—[ ]");
				rawOutputText("\n      |     ");
				rawOutputText("\n—[ ]—[ ]    ");
			}
			else if (getGame().d3._currentRoom == "roomofmirrors") {
				rawOutputText("Basilisk Cave");
				rawOutputText("\n     [ ]—   ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]    ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]—[P]");
				rawOutputText("\n      |     ");
				rawOutputText("\n—[ ]—[ ]    ");
			}
			else if (getGame().d3._currentRoom == "magpiehalls" || getGame().d3._currentRoom == "magpiehalln") {
				rawOutputText("Basilisk Cave");
				rawOutputText("\n     [ ]—   ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [P]    ");
				rawOutputText("\n      |     ");
				rawOutputText("\n     [ ]—[ ]");
				rawOutputText("\n      |     ");
				rawOutputText("\n—[ ]—[ ]    ");
			}
			else if (getGame().d3._currentRoom == "tunnel2") {
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
			if (getGame().d3._currentRoom == "edgeofkeep") {
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
			else if (getGame().d3._currentRoom == "northentry") {
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
			else if (getGame().d3._currentRoom == "southcourtyard") {
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
			else if (getGame().d3._currentRoom == "southwestcourtyard") {
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
			else if (getGame().d3._currentRoom == "southwestwalk") {
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
			else if (getGame().d3._currentRoom == "westwalk") {
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
			else if (getGame().d3._currentRoom == "northwestwalk") {
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
			else if (getGame().d3._currentRoom == "northwestcourtyard") {
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
			else if (getGame().d3._currentRoom == "northcourtyard") {
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
			else if (getGame().d3._currentRoom == "northeastcourtyard") {
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
			else if (getGame().d3._currentRoom == "northeastwalk") {
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
			else if (getGame().d3._currentRoom == "eastwalk") {
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
			else if (getGame().d3._currentRoom == "southeastwalk") {
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
			else if (getGame().d3._currentRoom == "southeastcourtyard") {
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
			else if (getGame().d3._currentRoom == "courtyardsquare") {
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
			else if (getGame().d3._currentRoom == "greatlift") {
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
			else if (getGame().d3._currentRoom == "throneroom") {
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