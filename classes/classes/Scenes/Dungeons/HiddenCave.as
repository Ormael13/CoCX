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
		private static const DUNGEON_HIDDEN_CAVE_SMALL_CAVE_W:int  	= 60;
		private static const DUNGEON_HIDDEN_CAVE_MEDIUM_CAVE:int  	= 61;
		private static const DUNGEON_HIDDEN_CAVE_SMALL_CAVE_E:int  	= 62;
		private static const DUNGEON_HIDDEN_CAVE_SMALL_CAVE_N:int  	= 63;
		
		
		public function HiddenCave() {}
		
		public function enterDungeon():void {
			kGAMECLASS.inDungeon = true;
			kGAMECLASS.dungeonLoc = 39;
			playerMenu();
		}
		public function exitDungeon():void {
			kGAMECLASS.inDungeon = false;
			clearOutput();
			outputText("You leave the cave behind and take off through the hills back towards camp.");
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
		public function defeatedByBossGolems():void {
			clearOutput();
			outputText("As you fall defeated, with barely any time to collapse to the ground as the constructs continue to smash or slash you to death with their tails. By the time they are done with you there will be nothing left but a bloodstain on the stone floor...and some of you on the walls and maybe a little bit on cave roof too. Wait how did part of you get there?\n\n");
			//[GAME OVER]
			getGame().gameOver();
			removeButton(1);
		}
		public function defeatedBossGolems():void {
			clearOutput();
			outputText("For now PLACEHOLDER text.\n\n");
			flags[kFLAGS.HIDDEN_CAVE_BOSSES] = 2;
			cleanupAfterCombat();
		}
		
		//Rooms
		public function roomEntrance():void {
			kGAMECLASS.dungeonLoc = 39;
			clearOutput();
			outputText("<b><u>Entrance</u></b>\n");
			outputText("The entrance of this old cave is decorated with torches. Someone seems to like the idea of decorating his lair with fancy lights.");
			dungeons.setDungeonButtons(null, null, roomSEUP, null);
			addButton(11, "Leave", exitDungeon);
		}
		public function roomSEUP():void {
			kGAMECLASS.dungeonLoc = 40;
			clearOutput();
			outputText("<b><u>SE Underground Passage</u></b>\n");
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
			clearOutput();
			outputText("<b><u>E Underground Passage</u></b>\n");
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(roomNEUP, roomSEUP, null, null);
		}
		public function roomNEUP():void {
			kGAMECLASS.dungeonLoc = 42;
			clearOutput();
			outputText("<b><u>NE Underground Passage</u></b>\n");
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
			clearOutput();
			outputText("<b><u>N Underground Passage</u></b>\n");
			outputText("Various shattered humanoid skeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(null, null, roomNWUP, roomNEUP);
		}
		public function roomSStaircase():void {
			kGAMECLASS.dungeonLoc = 44;
			clearOutput();
			outputText("<b><u>Stone Staircase</u></b>\n");
			outputText("This room was hidden by a secret passage. It leads down below.");
			dungeons.setDungeonButtons(null, null, null, roomSStorage);
			addButton(7, "Downstairs", roomSStaircaseB);
		}
		public function roomSUP():void {
			kGAMECLASS.dungeonLoc = 45;
			clearOutput();
			outputText("<b><u>S Underground Passage</u></b>\n");
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(null, null, roomSWUP, roomSEUP);
		}
		public function roomSStorage():void {
			kGAMECLASS.dungeonLoc = 46;
			clearOutput();
			outputText("<b><u></u>Small Storage</b>\n");
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
					outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_SOULPILLS]) + " pill bottles inside.\n\n");
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
			clearOutput();
			outputText("<b><u>NW Underground Passage</u></b>\n");
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
			clearOutput();
			outputText("<b><u>W Underground Passage</u></b>\n");
			outputText("Various shattered humanoid skeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(roomNWUP, roomSWUP, null, null);
			if (flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] > 3 && flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] > 0) addButton(10, "West", roomNTE);
		}
		public function roomSWUP():void {
			kGAMECLASS.dungeonLoc = 49;
			clearOutput();
			outputText("<b><u>SW Underground Passage</u></b>\n");
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
			clearOutput();
			outputText("<b><u>Narrow Tunnel (E)</u></b>\n");
			outputText("Various shattered humanoid skeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(null, null, roomNT, roomWUP);
		}
		public function roomNT():void {
			kGAMECLASS.dungeonLoc = 51;
			clearOutput();
			outputText("<b><u>Narrow Tunnel</u></b>\n");
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
			clearOutput();
			outputText("<b><u>Narrow Tunnel (N)</u></b>\n");
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(roomLStorageW, roomNT, null, null);
		}
		public function roomLStorageW():void {
			kGAMECLASS.dungeonLoc = 53;
			clearOutput();
			outputText("<b><u>Large Storage (W)</u></b>\n");
			outputText("A big heap of treasure is scattered around the room. For most gold and jewels.");
			dungeons.setDungeonButtons(null, roomNTN, null, roomLStorageE);
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 1) {
				outputText("\n\nA few of golem figures preset in storage suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 2;
				doNext(playerMenu);
				return;
			}
			if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_1] == 2) {
				outputText("\n\nThere is an opened crate with some sort of weapon inside.\n\n");
				addButton(0, "Crate 1", takeEldritchRibbon);
			}
			else if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_1] == 1) {
				outputText("\n\nThere is an opened crate with two items inside.\n\n");
				addButton(0, "Crate 1", takeDiamond);
			}
			else if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_1] == 0) {
				outputText("\n\nThere is an unopened crate with something inside.\n\n");
				addButton(0, "Crate 1", takeAmetist);
			}
		}
		public function roomLStorageE():void {
			kGAMECLASS.dungeonLoc = 54;
			clearOutput();
			outputText("<b><u>Large Storage (E)</u></b>\n");
			outputText("A big heap of treasure is scattered around the room. For most gold and jewels.");
			dungeons.setDungeonButtons(null, null, roomLStorageW, null);
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 2) {
				outputText("\n\nA few of golem figures preset in storage suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 3;
				doNext(playerMenu);
				return;
			}
			if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_TSTOOTH] > 0) {
				if(flags[kFLAGS.HIDDEN_CAVE_TAKEN_TSTOOTH] < 5) {
					outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_TSTOOTH]) + " glowing tiger shark tooth inside.");
					addButton(0, "TSharkT", takeTSharkTooth);
				}
			}
			else {
				outputText("\n\nThere is an unopened crate with five glowing tiger shark teeth inside.");
				addButton(0, "TSharkT", takeTSharkTooth);
			}
			if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_GLDSEED] > 0) {
				if(flags[kFLAGS.HIDDEN_CAVE_TAKEN_GLDSEED] < 5) {
					outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_GLDSEED]) + " golden seed inside.");
					addButton(1, "GoldSeed", takeGoldenSeed);
				}
			}
			else {
				outputText("\n\nThere is an unopened crate with five golden seeds inside.");
				addButton(1, "GoldSeed", takeGoldenSeed);
			}
			if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_MARAFRU] > 0) {
				if(flags[kFLAGS.HIDDEN_CAVE_TAKEN_MARAFRU] < 5) {
					outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_MARAFRU]) + " Mara fruit inside.");
					addButton(2, "MaraFruit", takeMaraFruit);
				}
			}
			else {
				outputText("\n\nThere is an unopened crate with five Mara fruits inside.");
				addButton(2, "MaraFruit", takeMaraFruit);
			}
			if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_SALAMFW] > 0) {
				if(flags[kFLAGS.HIDDEN_CAVE_TAKEN_SALAMFW] < 5) {
					outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_SALAMFW]) + " bottle of Salamander firewater inside.");
					addButton(3, "SalamFW", takeSalamFireWat);
				}
			}
			else {
				outputText("\n\nThere is an unopened crate with five bottles of Salamander firewater inside.");
				addButton(3, "SalamFW", takeSalamFireWat);
			}
		}
		public function roomSStaircaseB():void {
			kGAMECLASS.dungeonLoc = 55;
			clearOutput();
			outputText("<b><u>Stone Staircase (Basement)</u></b>\n");
			outputText("In front of you is a stairway leading back to the upper level.");
			dungeons.setDungeonButtons(roomTunnel00, null, null, null);
			addButton(5, "Upstairs", roomSStaircase);
		}
		public function roomTunnel00():void {
			kGAMECLASS.dungeonLoc = 56;
			clearOutput();
			outputText("<b><u>Tunnel</u></b>\n");
			outputText("Various shattered humanoid skeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(null, roomSStaircaseB, roomTunnel01, null);
		}
		public function roomTunnel01():void {
			kGAMECLASS.dungeonLoc = 57;
			clearOutput();
			outputText("<b><u>Tunnel</u></b>\n");
			outputText("Various shattered humanoid skeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(null, null, roomTunnel02, roomTunnel00);
			if (flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] > 0) addButton(6, "North", roomMediumCave);
		}
		public function roomTunnel02():void {
			kGAMECLASS.dungeonLoc = 58;
			clearOutput();
			outputText("<b><u>Tunnel</u></b>\n");
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(null, roomTedsLair, null, roomTunnel01);
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 3) {
				outputText("\n\nA few of golem figures standing on both sides of the tunnel suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 4;
				doNext(playerMenu);
				return;
			}
		}
		public function roomTedsLair():void {
			kGAMECLASS.dungeonLoc = 59;
			clearOutput();
			outputText("<b><u>Ted's Lair</u></b>\n");
			outputText("The chamber you have entered is large.. At the center is an imposing throne with several shield like green scales littered around it. ");
			if (player.findPerk(PerkLib.SoulSense) >= 0) {
				outputText("There is a small suspicious lever on the right next to a bed. ");
				if (flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] > 0) outputText("And you already pulled it. ");
			}
			outputText("On the left is a small tatami mat and incense, it's obviously used for meditation.");
			dungeons.setDungeonButtons(roomTunnel02, null, null, null);
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 4) {
				outputText("\n\n\"<i>You come to worship me mortal?</i>\" A dommering, neither masculine nor feminine voice reached your ears the very moment you enter the room. Suprised you stopped to look around to find it source.");
				outputText("\n\n\"<i>So you're not my worshiper YET... but my BAM HAMMER will make sure you will be!!!</i>\"");
				startCombat(new Ted(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 5;
				doNext(playerMenu);
				return;
			}
			if (player.findPerk(PerkLib.SoulSense) >= 0 && flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] == 0) {
				addButton(0, "Pull Lever", pullTheLever).hint("Pull the lever. You suspect that it might open some secret door.");
			}
		}
		public function roomSmallCaveW():void {
			kGAMECLASS.dungeonLoc = 60;
			clearOutput();
			outputText("<b><u>Small Cave (W)</u></b>\n");
			outputText("This cave is filled with various storage crates.");
			dungeons.setDungeonButtons(null, null, null, roomMediumCave);
			if (flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 5) {
				outputText("\n\nA few of golem figures standing near cave walls on your right and left suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS]++;
				doNext(playerMenu);
				return;
			}
			if (flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] > 5) {
			/*	if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_2] == 5) {
					outputText("\n\nThere is a crate with " +  + " pill bottles inside.\n\n");
					addButton(0, "", takeSoulPill4);
				}
			*/	if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_2] > 0) {
					if(flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_2] < 5) {
						outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_2]) + " pill bottles inside.\n\n");
						addButton(0, "SoulPill", takeSoulPill2);
					}
				}
				else {
					outputText("\n\nThere is an unopened crate with five pill bottles.\n\n");
					addButton(0, "SoulPill", takeSoulPill2);
				}
			}
		}
		public function roomMediumCave():void {
			kGAMECLASS.dungeonLoc = 61;
			clearOutput();
			outputText("<b><u>Medium Cave</u></b>\n");
			outputText("This medium sized cave is decorated with many silent statues. You somehow have the impression that they are watching you or maybe watching... ");
			/*if(flags[kFLAGS.HIDDEN_CAVE_BOSSES] >= 1) outputText("empty space in the middle with some resin remains.");
			else */outputText("something embeded in half translucent resin in the middle.");
			dungeons.setDungeonButtons(roomSmallCaveN, roomTunnel01, roomSmallCaveW, roomSmallCaveE);//north(6), south(11), west(10), east(12), up(5), down(7)
			if (flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 8 && flags[kFLAGS.HIDDEN_CAVE_BOSSES] < 2 && flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_2] == 5 && flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_3] == 5 && flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_4] == 5) {
				outputText("\n\nA few of unusualy shaped golem figures standing near cave walls on your right and left suddenly starting to move forming a small group encirling you.");
				startCombat(new BossGolems(), true);
				doNext(playerMenu);
				return;
			}
		}
		public function roomSmallCaveE():void {
			kGAMECLASS.dungeonLoc = 62;
			clearOutput();
			outputText("<b><u>Small Cave (E)</u></b>\n");
			outputText("This cave is filled with various storage crates.");
			dungeons.setDungeonButtons(null, null, roomMediumCave, null);
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 6) {
				outputText("\n\nA few of golem figures standing near cave walls on your right and left suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS]++;
				doNext(playerMenu);
				return;
			}
			if (flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] > 6) {
			/*	if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_3] == 5) {
					outputText("\n\nThere is a crate with " +  + " pill bottles inside.\n\n");
					addButton(0, "", takeSoulPill4);
				}
			*/	if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_3] > 0) {
					if(flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_3] < 5) {
						outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_3]) + " pill bottles inside.\n\n");
						addButton(0, "SoulPill", takeSoulPill3);
					}
				}
				else {
					outputText("\n\nThere is an unopened crate with five pill bottles.\n\n");
					addButton(0, "SoulPill", takeSoulPill3);
				}
			}
		}
		public function roomSmallCaveN():void {
			kGAMECLASS.dungeonLoc = 63;
			clearOutput();
			outputText("<b><u>Small Cave (N)</u></b>\n");
			outputText("This cave is filled with various storage crates.");
			dungeons.setDungeonButtons(null, roomMediumCave, null, null);
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 7) {
				outputText("\n\nA few of golem figures standing near cave walls on your right and left suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS]++;
				doNext(playerMenu);
				return;
			}
			if (flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] > 7) {
			/*	if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_4] == 5) {
					outputText("\n\nThere is a crate with " +  + " pill bottles inside.\n\n");
					addButton(0, "", takeSoulPill4);
				}
			*/	if (flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_4] > 0) {
					if(flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_4] < 5) {
						outputText("\n\nThere is a crate with " + num2Text(5 - flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_4]) + " pill bottles inside.\n\n");
						addButton(0, "SoulPill", takeSoulPill4);
					}
				}
				else {
					outputText("\n\nThere is an unopened crate with five pill bottles.\n\n");
					addButton(0, "SoulPill", takeSoulPill4);
				}
			}
		}
		
		private function pullTheLever():void {
			clearOutput();
			outputText("There is a loud rumbling from the direction of the tunnel...");
			flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] = 1;
			doNext(playerMenu);
		}
		private function takeSoulPill():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_SOULPILLS]++
			inventory.takeItem(consumables.LG_SFRP, roomSStorage);
		}
		private function takeSoulPill2():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_2]++
			inventory.takeItem(consumables.MG_SFRP, roomSmallCaveW);
		}
		private function takeSoulPill3():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_3]++
			inventory.takeItem(consumables.MG_SFRP, roomSmallCaveE);
		}
		private function takeSoulPill4():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_4]++
			inventory.takeItem(consumables.MG_SFRP, roomSmallCaveN);
		}
		private function takeTSharkTooth():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_TSTOOTH]++
			inventory.takeItem(consumables.TSTOOTH, roomLStorageE);
		}
		private function takeGoldenSeed():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_GLDSEED]++
			inventory.takeItem(consumables.GLDSEED, roomLStorageE);
		}
		private function takeMaraFruit():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_MARAFRU]++
			inventory.takeItem(consumables.MARAFRU, roomLStorageE);
		}
		private function takeSalamFireWat():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_SALAMFW]++
			inventory.takeItem(consumables.SALAMFW, roomLStorageE);
		}
		private function takeAmetist():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_1] = 1;
			inventory.takeItem(useables.AMETIST, roomLStorageW);
		}
		private function takeDiamond():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_1] = 2;
			inventory.takeItem(useables.DIAMOND, roomLStorageW);
		}
		private function takeEldritchRibbon():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_1] = 3;
			inventory.takeItem(weapons.ERIBBON, roomLStorageW);
		}
	}

}