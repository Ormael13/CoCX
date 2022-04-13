//Side Dungeon: Hidden Cave (aka Elemental Cave)
/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons 
{
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Scenes.Dungeons.HiddenCave.*;
import classes.Scenes.NPCs.Ted;

public class HiddenCave extends DungeonAbstractContent
	{
		public function HiddenCave() {}
		
		public function enterDungeon():void {
			inDungeon = true;
			dungeonLoc = DUNGEON_HIDDEN_CAVE_ENTRANCE;
			playerMenu();
		}
		public function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			outputText("You leave the cave behind and take off through the hills back towards camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function defeatedByLoliBatGolem():void {
			clearOutput();
			outputText("As you fall defeated to the ground the construct continue to pummel you to death. By the time it's done there will be nothing left of you but a bloodstain on the stone floor.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedByGuardianGolems():void {
			clearOutput();
			outputText("As you fall defeated to the ground the constructs continue to pummel you to death. By the time they are done there will be nothing left of you but a bloodstain on the stone floor.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedByBossGolems():void {
			clearOutput();
			outputText("As you fall defeated, with barely any time to collapse to the ground as the constructs continue to smash or slash you to death with their tails. By the time they are done with you there will be nothing left but a bloodstain on the stone floor...and some of you on the walls and maybe a little bit on cave roof too. Wait how did part of you get there?\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedBossGolems():void {
			clearOutput();
			outputText("You sigh in relief as the last guardian statue fall to rubble. Its arm tries to grab your leg but you step on it and smash the fingers. All that's left of the squad of golden is a piles of rocks.\n\n");
			flags[kFLAGS.HIDDEN_CAVE_BOSSES] = 2;
			cleanupAfterCombat();
		}
		
		//Rooms
		public function roomEntrance():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_ENTRANCE;
			clearOutput();
			outputText("<b><u>Entrance</u></b>\n");
			outputText("The entrance of this old cave is decorated with torches. Someone seems to like the idea of decorating his lair with fancy lights.");
			dungeons.setDungeonButtons(null, null, roomSEUP, null);
			addButton(11, "Leave", exitDungeon);
		}
		public function roomSEUP():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_SE_UP;
			clearOutput();
			outputText("<b><u>SE Underground Passage</u></b>\n");
			if(flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] < 1) {
				outputText("\n\nA bat-shaped figures standing near you suddenly starting to move toward you with clearly hostile intentions.");
				startCombat(new LoliBatGolem(), true);
				flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 1;
				doNext(playerMenu);
				return;
			}
			outputText("The corridor in front of you is covered with crystal formation that glow eerily in the dark. Every now and then, you spot a shadow from the corner of your eyes but clearly this must only be your imagination.");
			dungeons.setDungeonButtons(roomEUP, null, roomSUP, roomEntrance);
		}
		public function roomEUP():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_E_UP;
			clearOutput();
			outputText("<b><u>E Underground Passage</u></b>\n");
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(roomNEUP, roomSEUP, null, null);
		}
		public function roomNEUP():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_NE_UP;
			clearOutput();
			outputText("<b><u>NE Underground Passage</u></b>\n");
			if(flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] == 1) {
				outputText("\n\nA bat-shaped figures standing near you suddenly starting to move toward you with clearly hostile intentions.");
				startCombat(new LoliBatGolem(), true);
				flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 2;
				doNext(playerMenu);
				return;
			}
			outputText("The corridor in front of you is covered with crystal formation that glow eerily in the dark. Every now and then, you spot a shadow from the corner of your eyes but clearly this must only be your imagination.");
			dungeons.setDungeonButtons(null, roomEUP, roomNUP, null);
		}
		public function roomNUP():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_N_UP;
			clearOutput();
			outputText("<b><u>N Underground Passage</u></b>\n");
			outputText("Various shattered humanoid skeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(null, null, roomNWUP, roomNEUP);
		}
		public function roomSStaircase():void {
            dungeonLoc = DUNGEON_HIDDEN_CAVE_S_STAIRCASE;
			clearOutput();
			outputText("<b><u>Stone Staircase</u></b>\n");
			outputText("This room was hidden by a secret passage. It leads down below.");
			dungeons.setDungeonButtons(null, null, null, roomSStorage);
			addButton(7, "Downstairs", roomSStaircaseB);
		}
		public function roomSUP():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_S_UP;
			clearOutput();
			outputText("<b><u>S Underground Passage</u></b>\n");
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(null, null, roomSWUP, roomSEUP);
		}
		public function roomSStorage():void {
            var beatmore:int = 8 - flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] - flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS];
			dungeonLoc = DUNGEON_HIDDEN_CAVE_S_STORAGE;
			clearOutput();
			outputText("<b><u></u>Small Storage</b>\n");
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] < 1) {
				outputText("\n\nA few of golem figures preset in storage suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 1;
				doNext(playerMenu);
				return;
			}
			outputText("This room is filled with storage crates.");
			dungeons.setDungeonButtons(roomSWUP, null, null, null);
			if (flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] > 4 && flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] > 2) addButton(10, "West", roomSStaircase);
			else addButtonDisabled(10, "West", "You still need to beat " + beatmore + " enemies to deactivate restriction formation from this hidden passage.");
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
			dungeonLoc = DUNGEON_HIDDEN_CAVE_NW_UP;
			clearOutput();
			outputText("<b><u>NW Underground Passage</u></b>\n");
			if(flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] == 3) {
				outputText("\n\nA bat-shaped figures standing near you suddenly starting to move toward you with clearly hostile intentions.");
				startCombat(new LoliBatGolem(), true);
				flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 4;
				doNext(playerMenu);
				return;
			}
			outputText("The corridor in front of you is covered with crystal formation that glow eerily in the dark. Every now and then, you spot a shadow from the corner of your eyes but clearly this must only be your imagination.");
			dungeons.setDungeonButtons(null, roomWUP, null, roomNUP);
		}
		public function roomWUP():void {
			var beatmore:int = 5 - flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] - flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS];
            dungeonLoc = DUNGEON_HIDDEN_CAVE_W_UP;
			clearOutput();
			outputText("<b><u>W Underground Passage</u></b>\n");
			outputText("Various shattered humanoid skeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(roomNWUP, roomSWUP, null, null);
			if (flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] > 3 && flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] > 0) addButton(10, "West", roomNTE);
			else addButtonDisabled(10, "West", "You still need to beat "+ beatmore +" enemies to deactivate restriction formation from this passage.");
		}
		public function roomSWUP():void {
            var beatmore:int = 4 - flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS];
			dungeonLoc = DUNGEON_HIDDEN_CAVE_SW_UP;
			clearOutput();
			outputText("<b><u>SW Underground Passage</u></b>\n");
			if(flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] == 2) {
				outputText("\n\nA bat-shaped figures standing near you suddenly starting to move toward you with clearly hostile intentions.");
				startCombat(new LoliBatGolem(), true);
				flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 3;
				doNext(playerMenu);
				return;
			}
			outputText("The corridor in front of you is covered with crystal formation that glow eerily in the dark. Every now and then, you spot a shadow from the corner of your eyes but clearly this must only be your imagination.");
			dungeons.setDungeonButtons(roomWUP, null, null, roomSUP);
			if (flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] > 3) addButton(11, "South", roomSStorage);
			else addButtonDisabled(11, "South", "You still need to beat "+ beatmore +" enemies to deactivate restriction formation from this passage.");
		}
		public function roomNTE():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_NARROW_T_E;
			clearOutput();
			outputText("<b><u>Narrow Tunnel (E)</u></b>\n");
			outputText("Various shattered humanoid skeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(null, null, roomNT, roomWUP);
		}
		public function roomNT():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_NARROW_T  ;
			clearOutput();
			outputText("<b><u>Narrow Tunnel</u></b>\n");
			if(flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] == 4) {
				outputText("\n\nA bat-shaped figures standing near you suddenly starting to move toward you with clearly hostile intentions.");
				startCombat(new LoliBatGolem(), true);
				flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 5;
				doNext(playerMenu);
				return;
			}
			outputText("The corridor in front of you is covered with crystal formation that glow eerily in the dark. Every now and then, you spot a shadow from the corner of your eyes but clearly this must only be your imagination.");
			dungeons.setDungeonButtons(roomNTN, null, null, roomNTE);
		}
		public function roomNTN():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_NARROW_T_N;
			clearOutput();
			outputText("<b><u>Narrow Tunnel (N)</u></b>\n");
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(roomLStorageW, roomNT, null, null);
		}
		public function roomLStorageW():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_L_STORAGE_W;
			clearOutput();
			outputText("<b><u>Large Storage (W)</u></b>\n");
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 1) {
				outputText("\n\nA few of golem figures preset in storage suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 2;
				doNext(playerMenu);
				return;
			}
			outputText("A big heap of treasure is scattered around the room. For most gold and jewels.");
			dungeons.setDungeonButtons(null, roomNTN, null, roomLStorageE);
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
			dungeonLoc = DUNGEON_HIDDEN_CAVE_L_STORAGE_E;
			clearOutput();
			outputText("<b><u>Large Storage (E)</u></b>\n");
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 2) {
				outputText("\n\nA few of golem figures preset in storage suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 3;
				doNext(playerMenu);
				return;
			}
			outputText("A big heap of treasure is scattered around the room. For most gold and jewels.");
			dungeons.setDungeonButtons(null, null, roomLStorageW, null);
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
			dungeonLoc = DUNGEON_HIDDEN_CAVE_S_STAIRCASE_B;
			clearOutput();
			outputText("<b><u>Stone Staircase (Basement)</u></b>\n");
			outputText("In front of you is a stairway leading back to the upper level.");
			dungeons.setDungeonButtons(roomTunnel00, null, null, null);
			addButton(5, "Upstairs", roomSStaircase);
			if (player.hasKeyItem("Jade Talisman") >= 0 || flags[kFLAGS.AURORA_LVL] == 0.2) {
				addButton(0, "J.Talisman", putInTheJadeTalisman);
			}
		}
		public function roomTunnel00():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_TUNNEL_00;
			clearOutput();
			outputText("<b><u>Tunnel</u></b>\n");
			outputText("Various shattered humanoid skeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(null, roomSStaircaseB, roomTunnel01, null);
		}
		public function roomTunnel01():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_TUNNEL_01;
			clearOutput();
			outputText("<b><u>Tunnel</u></b>\n");
			outputText("Various shattered humanoid skeletons litter the floor in this corridor. They look demonic in origin. Whatever lives heres kills demon in cold blood.");
			dungeons.setDungeonButtons(null, null, roomTunnel02, roomTunnel00);
			if (flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] > 0) addButton(6, "North", roomMediumCave);
		}
		public function roomTunnel02():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_TUNNEL_02;
			clearOutput();
			outputText("<b><u>Tunnel</u></b>\n");
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 3) {
				outputText("\n\nA few of golem figures standing on both sides of the tunnel suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 4;
				doNext(playerMenu);
				return;
			}
			outputText("This corridor is decorated with many silent statue. You somehow have the impression that they are watching you.");
			dungeons.setDungeonButtons(null, roomTedsLair, null, roomTunnel01);
		}
		public function roomTedsLair():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_TEDS_LAIR;
			clearOutput();
			outputText("<b><u>Ted's Lair</u></b>\n");
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 4) {
				outputText("\n\n\"<i>You come to worship me mortal?</i>\" A dommering, neither masculine nor feminine voice reached your ears the very moment you enter the room. Suprised you stopped to look around to find it source.");
				outputText("\n\n\"<i>So you're not my worshiper YET... but my BAM HAMMER will make sure you will be!!!</i>\"");
				startCombat(new Ted(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] = 5;
				doNext(playerMenu);
				return;
			}
			outputText("The chamber you have entered is large.. At the center is an imposing throne with several shield like green scales littered around it. ");
			if (player.hasPerk(PerkLib.SoulSense)) {
				outputText("There is a small suspicious lever on the right next to a bed. ");
				if (flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] > 0) outputText("And you already pulled it. ");
			}
			outputText("On the left is a small tatami mat and incense, it's obviously used for meditation.");
			dungeons.setDungeonButtons(roomTunnel02, null, null, null);
			if (player.hasPerk(PerkLib.SoulSense) && flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] == 0) {
				addButton(0, "Pull Lever", pullTheLever).hint("Pull the lever. You suspect that it might open some secret door.");
			}
		}
		public function roomSmallCaveW():void {
			dungeonLoc = DUNGEON_HIDDEN_CAVE_SMALL_CAVE_W;
			clearOutput();
			outputText("<b><u>Small Cave (W)</u></b>\n");
			if (flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 5) {
				outputText("\n\nA few of golem figures standing near cave walls on your right and left suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS]++;
				doNext(playerMenu);
				return;
			}
			outputText("This cave is filled with various storage crates.");
			dungeons.setDungeonButtons(null, null, null, roomMediumCave);
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
			dungeonLoc = DUNGEON_HIDDEN_CAVE_MEDIUM_CAVE;
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
			dungeonLoc = DUNGEON_HIDDEN_CAVE_SMALL_CAVE_E;
			clearOutput();
			outputText("<b><u>Small Cave (E)</u></b>\n");
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 6) {
				outputText("\n\nA few of golem figures standing near cave walls on your right and left suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS]++;
				doNext(playerMenu);
				return;
			}
			outputText("This cave is filled with various storage crates.");
			dungeons.setDungeonButtons(null, null, roomMediumCave, null);
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
			dungeonLoc = DUNGEON_HIDDEN_CAVE_SMALL_CAVE_N;
			clearOutput();
			outputText("<b><u>Small Cave (N)</u></b>\n");
			if(flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS] == 7) {
				outputText("\n\nA few of golem figures standing near cave walls on your right and left suddenly starting to move forming a small group encirling you.");
				startCombat(new GuardianGolems(), true);
				flags[kFLAGS.HIDDEN_CAVE_GOLEM_GROUPS]++;
				doNext(playerMenu);
				return;
			}
			outputText("This cave is filled with various storage crates.");
			dungeons.setDungeonButtons(null, roomMediumCave, null, null);
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
		
		private function putInTheJadeTalisman():void {
			clearOutput();
			if (flags[kFLAGS.AURORA_LVL] == 0.2) outputText("When you return to the chamber again, it lights up like last time. And the chained golem in the middle of it just looks at you for a long moment before asking. \"<i>Master?</i>\"\n\n");
			else {
				outputText("Coming back to the cave, you stand before a wall you’ve seen in your dreams and it indeed has some sort of crack. A crack you swear you didn’t see last time you were here. Holding the talisman in your hand, you slowly go forward, step by step towards the wall until you stop before it. Looking at the crack and the jade talisman in your hand, it looks like it may fit pretty well into that crack. ");
				outputText("So was it actually some sort of key? But why did that dragon-boy call it severing karma by losing it? There are many questions and only one way to find any answers. With a short click you insert the talisman into the crack and steps back to see what will happen.\n\n");
				player.removeKeyItem("Jade Talisman");
				outputText("And nothing happens... for minute or two. When you start to doubt if it was the key...The wall gently trembles as it opens itself, revealing another room behind it. Almost fully covered in shadows and the only light that disperses the darkness is the light coming through the opened doors. Keeping your guard up you slowly enter inside. While your eyes slowly adapt to the darkness, ");
				outputText("you see a pair of faint glowing green lights deeper inside. The moment when you look directly in the direction of the glowing lights, your hand touches something. Looking to the side you see it's something that begins in the nearby floor and runs across the room towards the direction of the glowing green lights. From touch, it feels like some sort of metal and it’s shape ");
				outputText("looks like some sort of thick chain. Looking carefully around you, you start to distinguish other objects in darkness that seems to start on the nearby floor and they all go towards one point. They also look like chains but why are they here?\n\n");
				outputText("Thinking over this probably important question, you seem to step on something, moments later the floor near your legs start to shine with some sort of runes. One after another, new runes start to glow, spreading outwards from your position toward the sides of the chamber. After a moment or two when you stop moving, preparing for what may come, some of runes start to glow on the walls. ");
				outputText("Then you see some shadow before you or more accurately, you cast a shadow on the nearby wall due to a new source of light lightening up somewhere behind you. This causes the gradual vanishing of shadows and darkness inside, revealing the place where before you’ve seen glowing green lights.\n\n");
				outputText("The source of this light gradually reveals itself to be ");
				if (player.tallness < 72) outputText("towering above you");
				else if (player.tallness >= 72 && player.tallness < 85) outputText("closely to your own height");
				else outputText("shorter than you");
				outputText(", a crouching figure sitting on some sort of wide pillar. It has a pair of quite big wings that stick out a bit from behind and on the left side you see something that looks like an end of a tail. When another two sources of light light up on the sides of the room, you can see the beings shape more clearly and it seems it's female or so you suspect due her chest rivaling many lower succubi ");
				outputText("with its size, emphasized by fact she holds her hands to her sides, further squeezing them between them. What you took before as the dark grey color of her skin, after the room got brighter, it turns out to be light turquoise with blue markings and a white belly. Her face and head looks like one of those bat golems you fought before but looking much more mature and the pair of glowing lights ");
				outputText("was her glowing eyes. She still stays motionlessly despite you being here for a longer moment, so you cautiously make a  few steps closer. Then you notice above her shapeful chest some mark. With all the light present in chamber it looks like black tattoo of the letter A above 3 lines, forming the Roman numeral 3.\n\n");
				outputText("\"<i>Master?</i>\" your examination is interrupted when a low and much more mature voice than that of the other bat golems resounds in the chamber. To your surprise, sitting on the pedestal, the figure’s head is now looking at you with her glowing eyes, which dim a bit to show her normal looking green eyes without that glow that made them look alien a moment ago. What will you do now?\n\n");
			}
			menu();
			if (silly()) addButton(1, "FTSIO", putInTheJadeTalisman1).hint("Fuck This Shit I'm out");
			else addButton(1, "No", putInTheJadeTalisman1);
			if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0 || player.hasKeyItem("Adventurer Guild: Iron plate") >= 0) addButton(3, "Yes", putInTheJadeTalisman2);
			else addButtonDisabled(3, "Yes", "Req. to have Adventurer Guild plate.");
		}
		private function putInTheJadeTalisman1():void {
			outputText("Wait she thinks you're her master? But wouldn't that be that weird and arrogant dragon boy?\n\n");
			outputText("\"<i>No. He just sent me to check on you as he's busy,</i>\" you say as a fast put together lie. \"<i>Since I see you're okay,  I'll go back to report this.</i>\" You add and trying to not look suspicious, you turn around and slowly walks toward exit.\n\n");
			outputText("She doesn’t say anything more and the lights in the chamber starts to slowly dim, letting shadows and darkness once again reclaim this place.\n\n");
			flags[kFLAGS.AURORA_LVL] = 0.2;
			doNext(playerMenu);
		}
		private function putInTheJadeTalisman2():void {
			outputText("Wait she think you're her master? But wouldn't that be that weird and arrogant dragon boy?\n\n");
			outputText("\"<i>No. He ran away like a coward</i>\" you speak the truth. Hearing this she seems stay silent for a longer moment before speaking again. \"<i>Are you my new master?</i>\"\n\n");
			outputText("New master? Confused, you ask her what she means. She straightforwardly replies. \"<i>Since you came here, which required Master’s jade talisman, Master wouldn't give it to noone not his servant, so that makes you my new master, right?</i>\"\n\n");
			outputText("You think for a moment. She looks like some sort of golem so having one in camp wouldn't be harmful. \"<i>Yes I’m your new Master</i>\" you reply with a confident voice.\n\n");
			outputText("\"<i>Then would you set me free? Or should I stay chained here?</i>\" she asks. And that makes you realize you had no idea that she was chained here.\n\n");
			outputText("\"<i>Stay here for a bit longer, I need to do few things first before I can take you with me</i>\" having said this, you turn around and start walking toward the exit of the room.\n\n");
			outputText("\"<i>Yes Master.</i>\" Her words resounds before darkness starts to claim the chamber once again.\n\n");
			outputText("After the doors close behind you, you start to think. Who could be helpful to remove those chains? Despite looking like she's some sort of sex golem, she may have other uses too. Few moments later some place comes to your mind. The Adventurer’s Guild. ");
			outputText("You took and completed some quests for them but would they accept your request for finding a person to solve this problem? It's always worth it to give it a try.\n\n");
			flags[kFLAGS.AURORA_LVL] = 0.3;
			doNext(playerMenu);
		}
		private function pullTheLever():void {
			clearOutput();
			outputText("There is a loud rumbling from the direction of the tunnel...");
			flags[kFLAGS.HIDDEN_CAVE_2ND_FLOOR] = 1;
			doNext(playerMenu);
		}
		private function takeSoulPill():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_SOULPILLS]++;
			inventory.takeItem(consumables.LG_SFRP, roomSStorage);
		}
		private function takeSoulPill2():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_2]++;
			inventory.takeItem(consumables.MG_SFRP, roomSmallCaveW);
		}
		private function takeSoulPill3():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_3]++;
			inventory.takeItem(consumables.MG_SFRP, roomSmallCaveE);
		}
		private function takeSoulPill4():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_ITEMS_4]++;
			inventory.takeItem(consumables.MG_SFRP, roomSmallCaveN);
		}
		private function takeTSharkTooth():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_TSTOOTH]++;
			inventory.takeItem(consumables.TSTOOTH, roomLStorageE);
		}
		private function takeGoldenSeed():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_GLDSEED]++;
			inventory.takeItem(consumables.GLDSEED, roomLStorageE);
		}
		private function takeMaraFruit():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_MARAFRU]++;
			inventory.takeItem(consumables.MARAFRU, roomLStorageE);
		}
		private function takeSalamFireWat():void {
			flags[kFLAGS.HIDDEN_CAVE_TAKEN_SALAMFW]++;
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