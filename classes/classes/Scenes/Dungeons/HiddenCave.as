/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.BaseContent;
	import classes.Scenes.Dungeons.DungeonAbstractContent;
	import classes.Scenes.Dungeons.DungeonEngine;
	import classes.Scenes.Dungeons.HiddenCave.*;
	import classes.Scenes.NPCs.Ted;
	import classes.PerkLib;
	
	public class HiddenCave extends DungeonAbstractContent
	{
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
		private static const DUNGEON_HIDDEN_CAVE_TUNNEL_03:int  	= 60;
		
		
		public function HiddenCave() {}
		
		public function enterDungeon():void {
			kGAMECLASS.inDungeon = true;
			kGAMECLASS.dungeonLoc = 39;
			playerMenu();
		}
		public function exitDungeon():void {
			kGAMECLASS.inDungeon = false;
			outputText("You leave the cave behind and take off through the hills back towards camp.", true);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function defeatedByLoliBatGolem():void {
			clearOutput();
			outputText("As you fall defeated to the ground the construct continue to pummel you to death. By the time it's done there will be nothing left of you but a bloodstain on the stone floor.\n\n");
			//[GAME OVER]
			getGame().gameOver();
			removeButton(1);
		}
		
		public function defeatedByGuardianGolems():void {
			clearOutput();
			outputText("As you fall defeated to the ground the constructs continue to pummel you to death. By the time they are done there will be nothing left of you but a bloodstain on the stone floor.\n\n");
			//[GAME OVER]
			getGame().gameOver();
			removeButton(1);
		}
		
		//Rooms
		public function roomEntrance():void {
			kGAMECLASS.dungeonLoc = 39;
			outputText("<b><u>Entrance</u></b>\n", true);
			outputText("The entrance of this old cave is decorated with torches. Someone seems to like the idea of decorating his lair with fancy lights.");
			dungeons.setDungeonButtons(null, null, roomSEUP, null);
			addButton(11, "Leave", exitDungeon);
		}
		public function roomSEUP():void {
			kGAMECLASS.dungeonLoc = 40;
			outputText("<b><u>SE Underground Passage</u></b>\n", true);
			outputText("The corridor in front of you is covered with crystal formation that glow eerily in the dark. Every now and then, you spot a shadow from the corner of your eyes but clearly this must only be your imagination.");
			dungeons.setDungeonButtons(roomEUP, null, roomSUP, roomEntrance);
			if(flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] < 1) {
				outputText("\n\nA bat-shaped figures standing near you suddenly starting to move toward you with clearly hostile intentions.");
				startCombat(new LoliBatGolem(), true);
				flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 1;
				doNext(playerMenu);
				return;
			}
		}
		public function roomEUP():void {
			kGAMECLASS.dungeonLoc = 41;
			outputText("<b><u>E Underground Passage</u></b>\n", true);
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(roomNEUP, roomSEUP, null, null);
		}
		public function roomNEUP():void {
			kGAMECLASS.dungeonLoc = 42;
			outputText("<b><u>NE Underground Passage</u></b>\n", true);
			outputText("The corridor in front of you is covered with crystal formation that glow eerily in the dark. Every now and then, you spot a shadow from the corner of your eyes but clearly this must only be your imagination.");
			dungeons.setDungeonButtons(null, roomEUP, roomNUP, null);
			if(flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] == 1) {
				outputText("\n\nA bat-shaped figures standing near you suddenly starting to move toward you with clearly hostile intentions.");
				startCombat(new LoliBatGolem(), true);
				flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 2;
				doNext(playerMenu);
				return;
			}
		}
		public function roomNUP():void {
			kGAMECLASS.dungeonLoc = 43;
			outputText("<b><u>N Underground Passage</u></b>\n", true);
			outputText("Various shattered humanoid squeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(null, null, roomNWUP, roomNEUP);
		}
		public function roomSStaircase():void {
			kGAMECLASS.dungeonLoc = 44;
			outputText("<b><u>Stone Staircase</u></b>\n", true);
			outputText("This room was hidden by a secret passage. It leads down below.");
			dungeons.setDungeonButtons(null, null, null, roomSStorage);
			addButton(7, "Downstairs", roomSStaircaseB);
		}
		public function roomSUP():void {
			kGAMECLASS.dungeonLoc = 45;
			outputText("<b><u>S Underground Passage</u></b>\n", true);
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(null, null, roomSWUP, roomSEUP);
		}
		public function roomSStorage():void {
			kGAMECLASS.dungeonLoc = 46;
			outputText("<b><u></u>Small Storage</b>\n", true);
			outputText("This room is filled with storage crates.");
			dungeons.setDungeonButtons(roomSWUP, null, null, null);
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] < 1) {
				outputText("\n\nA few of golem figures preset in storage suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 1;
				doNext(playerMenu);
				return;
			}
			if (flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] > 4 && flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] > 2) addButton(10, "West", roomSStaircase);
			if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_SOULPILLS] > 0) {
				if(flags[kFLAGS.HIDDEN_CAVE_TAKEN_SOULPILLS] < 5) {
					outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_SOULPILLS]) + " pill bottles inside.\n\n", false);
					addButton(0, "SoulPill", takeSoulPill);
				}
			}
			else {
				outputText("\n\nThere is an unopened crate with five pill bottles.\n\n");
				addButton(0, "SoulPill", takeSoulPill);
			}
		}
		public function roomNWUP():void {
			kGAMECLASS.dungeonLoc = 47;
			outputText("<b><u>NW Underground Passage</u></b>\n", true);
			outputText("The corridor in front of you is covered with crystal formation that glow eerily in the dark. Every now and then, you spot a shadow from the corner of your eyes but clearly this must only be your imagination.");
			dungeons.setDungeonButtons(null, roomWUP, null, roomNUP);
			if(flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] == 3) {
				outputText("\n\nA bat-shaped figures standing near you suddenly starting to move toward you with clearly hostile intentions.");
				startCombat(new LoliBatGolem(), true);
				flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 4;
				doNext(playerMenu);
				return;
			}
		}
		public function roomWUP():void {
			kGAMECLASS.dungeonLoc = 48;
			outputText("<b><u>W Underground Passage</u></b>\n", true);
			outputText("Various shattered humanoid squeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(roomNWUP, roomSWUP, null, null);
			if (flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] > 3) addButton(10, "West", roomNTE);
		}
		public function roomSWUP():void {
			kGAMECLASS.dungeonLoc = 49;
			outputText("<b><u>SW Underground Passage</u></b>\n", true);
			outputText("The corridor in front of you is covered with crystal formation that glow eerily in the dark. Every now and then, you spot a shadow from the corner of your eyes but clearly this must only be your imagination.");
			dungeons.setDungeonButtons(roomWUP, null, null, roomSUP);
			if(flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] == 2) {
				outputText("\n\nA bat-shaped figures standing near you suddenly starting to move toward you with clearly hostile intentions.");
				startCombat(new LoliBatGolem(), true);
				flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 3;
				doNext(playerMenu);
				return;
			}
			if (flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] > 3) addButton(11, "South", roomSStorage);
		}
		public function roomNTE():void {
			kGAMECLASS.dungeonLoc = 50;
			outputText("<b><u>Narrow Tunnel (E)</u></b>\n", true);
			outputText("Various shattered humanoid squeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(null, null, roomNT, roomWUP);
		}
		public function roomNT():void {
			kGAMECLASS.dungeonLoc = 51;
			outputText("<b><u>Narrow Tunnel</u></b>\n", true);
			outputText("The corridor in front of you is covered with crystal formation that glow eerily in the dark. Every now and then, you spot a shadow from the corner of your eyes but clearly this must only be your imagination.");
			dungeons.setDungeonButtons(roomNTN, null, null, roomNTE);
			if(flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] == 4) {
				outputText("\n\nA bat-shaped figures standing near you suddenly starting to move toward you with clearly hostile intentions.");
				startCombat(new LoliBatGolem(), true);
				flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 5;
				doNext(playerMenu);
				return;
			}
		}
		public function roomNTN():void {
			kGAMECLASS.dungeonLoc = 52;
			outputText("<b><u>Narrow Tunnel (N)</u></b>\n", true);
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(roomLStorageW, roomNT, null, null);
		}
		public function roomLStorageW():void {
			kGAMECLASS.dungeonLoc = 53;
			outputText("<b><u>Large Storage (W)</u></b>\n", true);
			outputText("A big heap of treasure is scattered around the room. For most gold and jewels.");
			dungeons.setDungeonButtons(null, roomNTN, null, roomLStorageE);
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 1) {
				outputText("\n\nA few of golem figures preset in storage suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 2;
				doNext(playerMenu);
				return;
			}
			if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_TSTOOTH] > 0) {
				if(flags[kFLAGS.HIDDEN_CAVE_TAKEN_TSTOOTH] < 5) {
					outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_TSTOOTH]) + " glowing tiger shark tooth inside.", false);
					addButton(0, "TSharkT", takeTSharkTooth);
				}
			}
			else {
				outputText("\n\nThere is an unopened crate with five glowing tiger shark teeth inside.");
				addButton(0, "TSharkT", takeTSharkTooth);
			}
			if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_GLDSEED] > 0) {
				if(flags[kFLAGS.HIDDEN_CAVE_TAKEN_GLDSEED] < 5) {
					outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_GLDSEED]) + " golden seed inside.", false);
					addButton(1, "GoldSeed", takeGoldenSeed);
				}
			}
			else {
				outputText("\n\nThere is an unopened crate with five golden seeds inside.");
				addButton(1, "GoldSeed", takeGoldenSeed);
			}
			if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_MARAFRU] > 0) {
				if(flags[kFLAGS.HIDDEN_CAVE_TAKEN_MARAFRU] < 5) {
					outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_MARAFRU]) + " Mara fruit inside.", false);
					addButton(2, "MaraFruit", takeMaraFruit);
				}
			}
			else {
				outputText("\n\nThere is an unopened crate with five Mara fruits inside.");
				addButton(2, "MaraFruit", takeMaraFruit);
			}
			if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_SALAMFW] > 0) {
				if(flags[kFLAGS.HIDDEN_CAVE_TAKEN_SALAMFW] < 5) {
					outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_SALAMFW]) + " bottle of Salamander firewater inside.", false);
					addButton(3, "SalamFW", takeSalamFireWat);
				}
			}
			else {
				outputText("\n\nThere is an unopened crate with five bottles of Salamander firewater inside.");
				addButton(3, "SalamFW", takeSalamFireWat);
			}
		}
		public function roomLStorageE():void {
			kGAMECLASS.dungeonLoc = 54;
			outputText("<b><u>Large Storage (E)</u></b>\n", true);
			outputText("A big heap of treasure is scattered around the room. For most gold and jewels.");
			dungeons.setDungeonButtons(null, null, roomLStorageW, null);
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 2) {
				outputText("\n\nA few of golem figures preset in storage suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 3;
				doNext(playerMenu);
				return;
			}
			if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS] == 1) {
		//		outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_TSTOOTH]) + " glowing tiger shark tooth inside.\n\n", false);
				addButtonDisabled(0, "???", "???");
			}
			else {
				outputText("\n\nThere is an unopened crate with something inside.\n\n");
				addButton(0, "Crate 1", takeGuidedBow);
			}
		}
		public function roomSStaircaseB():void {
			kGAMECLASS.dungeonLoc = 55;
			outputText("<b><u>Stone Staircase (Basement)</u></b>\n", true);
			outputText("In front of you is a stairway leading back to the upper level.");
			dungeons.setDungeonButtons(roomTunnel00, null, null, null);
			addButton(5, "Upstairs", roomSStaircase);
		}
		public function roomTunnel00():void {
			kGAMECLASS.dungeonLoc = 56;
			outputText("<b><u>Tunnel</u></b>\n", true);
			outputText("Various shattered humanoid squeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(null, roomSStaircaseB, roomTunnel01, null);
		}
		public function roomTunnel01():void {
			kGAMECLASS.dungeonLoc = 57;
			outputText("<b><u>Tunnel</u></b>\n", true);
			outputText("Various shattered humanoid squeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(null, null, roomTunnel02, roomTunnel00);
		}
		public function roomTunnel02():void {
			kGAMECLASS.dungeonLoc = 58;
			outputText("<b><u>Tunnel</u></b>\n", true);
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(null, roomTedsLair, null, roomTunnel01);
			if (flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] > 0) addButton(6, "North", roomTunnel03);
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 3) {
				outputText("\n\nA few of golem figures staning on both sides of the tunnel suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 4;
				doNext(playerMenu);
				return;
			}
		}
		public function roomTedsLair():void {
			kGAMECLASS.dungeonLoc = 59;
			outputText("<b><u>Ted's Lair</u></b>\n", true);
			outputText("This room is huge. At the center is the throne where the dragon man used to sit. ");
			if (player.findPerk(PerkLib.SoulSense) >= 0) outputText("There is a small suspicious lever on the right next to a bed. ");
			outputText("On the left is a small tatami used for meditations.");
			dungeons.setDungeonButtons(roomTunnel02, null, null, null);
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 4) {
				outputText("\n\n\"<i>Did you come to worship me mortal?</i>\" A dommering voice reaching your ears moment you enter the room. Stunned you stopped to look around.");
				outputText("\n\n\"<i>So you not my worshiper YET... but you will bend to power of BAM HAMMER!!!</i>\"");
				startCombat(new Ted(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 5;
				doNext(playerMenu);
				return;
			}
		}
		public function roomTunnel03():void {
			kGAMECLASS.dungeonLoc = 60;
			outputText("<b><u>Tunnel</u></b>\n", true);
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(null, roomTunnel02, null, null);//north(6), south(11), west(10), east(12), up(5), down(7)
		}
		
		private function takeSoulPill():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_SOULPILLS]++
			inventory.takeItem(consumables.LG_SFRP, roomSStorage);
		}
		private function takeTSharkTooth():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_TSTOOTH]++
			inventory.takeItem(consumables.TSTOOTH, roomLStorageW);
		}
		private function takeGoldenSeed():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_GLDSEED]++
			inventory.takeItem(consumables.GLDSEED, roomLStorageW);
		}
		private function takeMaraFruit():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_MARAFRU]++
			inventory.takeItem(consumables.MARAFRU, roomLStorageW);
		}
		private function takeSalamFireWat():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_SALAMFW]++
			inventory.takeItem(consumables.SALAMFW, roomLStorageW);
		}
		private function takeGuidedBow():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS] = 1;
			inventory.takeItem(weaponsrange.BOWGUID, roomLStorageE);
		}
	}

}