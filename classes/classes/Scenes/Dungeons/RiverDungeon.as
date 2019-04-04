//Side Dungeon: River Dungeon (Dungeon with multiple floors below He'Xin'Dao)
/**
 * ...
 * @author Ormael, Liadri
 */
package classes.Scenes.Dungeons 
{
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Lake.GreenSlime;
import classes.Scenes.Areas.Mountain.HellHound;
import classes.Scenes.Monsters.FeralImps;
import classes.CoC;
import classes.PerkLib;
import classes.StatusEffects;

	public class RiverDungeon extends DungeonAbstractContent
	{
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_01:int	= 68;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_02:int	= 69;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_03:int	= 70;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_04:int	= 71;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_05:int	= 72;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_06:int	= 73;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_07:int	= 74;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_08:int	= 75;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_09:int	= 76;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_10:int	= 77;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_11:int	= 78;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_12:int	= 79;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_13:int	= 80;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_14:int	= 81;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_15:int	= 82;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_16:int	= 83;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_17:int	= 84;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_18:int	= 85;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_19:int	= 86;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_20:int	= 87;
		
		public function RiverDungeon() {}//flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] 1 - pok 1 golema, 2 pokonanie 2 golem, 3 pokonanie obu golemów
		
		public function enterDungeon():void {
			inDungeon = true;
			dungeonLoc = 68;
			player.createStatusEffect(StatusEffects.RiverDungeonA, 10, 0, 0, 0);
			playerMenu();
		}
		public function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			if (flags[kFLAGS.NEISA_FOLLOWER] == 1) {
				outputText("As the pair of you leave the dungeon Neisa waves off, heading back to town.\n\n");
				outputText("\"<i>Nice going along with you [name], this was worth it. I’m going to go and spend this bling on some well earned reward. See you around up there. If you ever need of my services again I will be at the bar.</i>\"\n\n");
				player.removeStatusEffect(StatusEffects.CombatFollowerNeisa);
				flags[kFLAGS.PLAYER_COMPANION_1] = "";
				flags[kFLAGS.NEISA_FOLLOWER] = 4;
				outputText("Working together with another person has taught you how to manage and plan with a group of people. <b>Gained Perk: Basic Leadership</b>");
				player.createPerk(PerkLib.BasicLeadership,0,0,0,0);
			}
			else outputText("You leave the river dungeon behind and take off through the He'Xin'Dao back towards camp.");
			player.removeStatusEffect(StatusEffects.RiverDungeonA);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function encountersRuletteA():void {
			if (rand(100) < player.statusEffectv1(StatusEffects.RiverDungeonA)) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				var choice1:Number = rand(3);
				if (choice1 == 0) {
					spriteSelect(29);
					outputText("A feral imp suddenly appears from nearby passage and attacks!");
					if (flags[kFLAGS.CODEX_ENTRY_IMPS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_IMPS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Imps!</b>")
					}
					flags[kFLAGS.FERAL_EXTRAS] = 5;
					startCombat(new FeralImps(), true);
				}
				if (choice1 == 1) {
					spriteSelect(25);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting an amorphous green mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  The beast surges forward to attack!");
					startCombat(new GreenSlime(), true);
				}
				if (choice1 == 2) {
					spriteSelect(27);
					outputText("You hear a fiery howl as a demonic, two-headed beast-man leaps out of nearby passage!");
					if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Hellhounds!</b>")
					}
					startCombat(new HellHound(), true);
				}
				doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 10);
		}
		public function defeatedByFeralImp():void {
			clearOutput();
			outputText("Your opponent done toying with your body it carries you all the way back to the dungeon entrance and drop you there. Guess it's back to square one.\n\n");
			inDungeon = true;
			dungeonLoc = 68;
			playerMenu();
		}
		public function defeatedByGreenSlime():void {
			clearOutput();
			outputText("Your opponent done toying with your body it carries you all the way back to the dungeon entrance and drop you there. Guess it's back to square one.\n\n");
			inDungeon = true;
			dungeonLoc = 68;
			playerMenu();
		}
		public function defeatedByHellHound():void {
			clearOutput();
			outputText("Your opponent done toying with your body it carries you all the way back to the dungeon entrance and drop you there. Guess it's back to square one.\n\n");
			inDungeon = true;
			dungeonLoc = 68;
			playerMenu();
		}
		public function defeatedByAetherGolem():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}/*
		public function defeatedByFeralImp():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}*/
		
		//Rooms
		public function roomA01():void {
			dungeonLoc = 68;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u>Entrance</u></b>\n");
			outputText("You run into an old campsite. by the looks of it an adventurer must have rested there, through the fire likely died a month ago by the look of it. What a peculiar fire too, just who the hell would grab bones, set them in a stone circle and then impale a skull on a rusty longsword before setting fire to it?");
			dungeons.setDungeonButtons(null, null, null, roomA02);
			if (flags[kFLAGS.NEISA_AFFECTION] < 10) addButtonDisabled(10, "Up", "You would leave now but you have yet to find enough to pay Neisa."); 
			else addButton(10, "Up", exitDungeon);
		}
		public function roomA02():void {
			dungeonLoc = 69;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small glittering bones covers the rocky ground ahead of you. Likely those are the remains of some ancient monsters that used to live on Mareth a long time ago.");
			dungeons.setDungeonButtons(roomA03, null, roomA01, null);
		}
		public function roomA03():void {
			dungeonLoc = 70;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You spot a small lizard lazily resting on the cold hard stone above you. The air is humid and cold. On the walls are old graffiti likely left by ancient civilisations of animal morphs.");
			dungeons.setDungeonButtons(roomA08, roomA02, null, roomA04);
			if (flags[kFLAGS.NEISA_AFFECTION] < 5) tresureRoom1A();
		}
		public function roomA04():void {
			dungeonLoc = 71;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You can hear water running on a nearby wall from a fissure in the rock. You can only hope this thing won’t break open and flood the place over while you are deeper in.");
			dungeons.setDungeonButtons(null, null, roomA03, roomA05);
		}
		public function roomA05():void {
			dungeonLoc = 72;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small glittering bones covers the rocky ground ahead of you. Likely those are the remains of some ancient monsters that used to live on Mareth a long time ago.");
			dungeons.setDungeonButtons(roomA16, roomA06, roomA04, null);
		}
		public function roomA06():void {
			dungeonLoc = 73;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small Bats fly out as you walk by above your head hangs some large stalactites. You think to yourself it would be most unfortunate if one of these was to randomly fall down and run you through.");
			dungeons.setDungeonButtons(roomA05, null, null, null);
			addButtonDisabled(11, "Down", "Lower floors still too dangerous to let in PC party!!!");
		}
		public function roomA07():void {
			dungeonLoc = 74;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You run into an old campsite. by the looks of it an adventurer must have rested there, through the fire likely died a month ago by the look of it. What a peculiar fire too, just who the hell would grab bones, set them in a stone circle and then impale a skull on a rusty longsword before setting fire to it?");
			dungeons.setDungeonButtons(roomA11, null, null, roomA08);
		}
		public function roomA08():void {
			dungeonLoc = 75;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small Bats fly out as you walk by above your head hangs some large stalactites. You think to yourself it would be most unfortunate if one of these was to randomly fall down and run you through.");
			dungeons.setDungeonButtons(null, roomA03, roomA07, roomA09);
		}
		public function roomA09():void {
			dungeonLoc = 76;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You can hear running water above you, the river is likely flowing right up your head. Guess explosive magic right now is ill advised.");
			dungeons.setDungeonButtons(roomA10, null, roomA08, null);
		}
		public function roomA10():void {
			dungeonLoc = 77;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You spot a small lizard lazily resting on the cold hard stone above you. The air is humid and cold. On the walls are old graffiti likely left by ancient civilisations of animal morphs.");
			dungeons.setDungeonButtons(null, roomA09, null, null);
			if (flags[kFLAGS.NEISA_AFFECTION] == 5) tresureRoom2A();
		}
		public function roomA11():void {
			dungeonLoc = 78;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("The walls around you are covered with ancient lichen. You can see a fissure from which small droplets of water fall down the rivulet flowing down deeper in the dungeon.");
			dungeons.setDungeonButtons(roomA12, roomA07, null, null);
		}
		public function roomA12():void {
			dungeonLoc = 79;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small glowy mushrooms cover the walls of the room you move through, just enough for you to see a short distance ahead.");
			dungeons.setDungeonButtons(null, roomA11, roomA13, null);
		}
		public function roomA13():void {
			dungeonLoc = 80;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("A small underground lake has formed in the massive room you move by. You thread a safe distance away from the dark waters wary of what may lurk in its depths.");
			dungeons.setDungeonButtons(roomA15, null, roomA14, roomA12);
		}
		public function roomA14():void {
			dungeonLoc = 81;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("The walls around you are covered with ancient lichen. You can see a fissure from which small droplets of water fall down the rivulet flowing down deeper in the dungeon.");
			dungeons.setDungeonButtons(null, null, null, roomA13);
		}
		public function roomA15():void {
			dungeonLoc = 82;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			//boss room
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You find some old bones on the ground likely those of a beast that died here. These are at least the size of what could pass back in Ingnam for a cow.");
			dungeons.setDungeonButtons(null, roomA13, null, null);
		}
		public function roomA16():void {
			dungeonLoc = 83;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You can hear running water above you, the river is likely flowing right up your head. Guess explosive magic right now is ill advised.");
			dungeons.setDungeonButtons(roomA17, roomA05, null, null);
		}
		public function roomA17():void {
			dungeonLoc = 84;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small glowy mushrooms cover the walls of the room you move through, just enough for you to see a short distance ahead.");
			dungeons.setDungeonButtons(null, roomA16, null, roomA18);
		}
		public function roomA18():void {
			dungeonLoc = 85;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("A small underground lake has formed in the massive room you move by. You thread a safe distance away from the dark waters wary of what may lurk in its depths.");
			dungeons.setDungeonButtons(roomA20, null, roomA17, roomA19);
		}
		public function roomA19():void {
			dungeonLoc = 86;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You can hear water running on a nearby wall from a fissure in the rock. You can only hope this thing won’t break open and flood the place over while you are deeper in.");
			dungeons.setDungeonButtons(null, null, roomA18, null);
		}
		public function roomA20():void {
			dungeonLoc = 87;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			//boss room
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You find some old bones on the ground likely those of a beast that died here. These are at least the size of what could pass back in Ingnam for a cow.");
			dungeons.setDungeonButtons(null, roomA18, null, null);
		}
		
		private function tresureRoom1A():void {
			clearOutput();
			outputText("You notice a small glimmer in the distance and approach it. it is revealed to be a wall covered with gemstones. Neisa is quick to notice it too.\n\n");
			outputText("\"<i>Heya [name] this right here looks to be my pay. You can thank up Marae that I brought a pair of pickaxe just in case, now lets dig.</i>\"\n\n");
			outputText("The pair of you proceed to extract the precious gemstones from the wall, Neisa pocketing up the loot.\n\n");
			flags[kFLAGS.NEISA_AFFECTION] = 5;
			doNext(roomA03);
		}
		private function tresureRoom2A():void {
			clearOutput();
			outputText("As you move around you run into what appears to be a pile of loot, likely the hoard and gear of some adventurer before he was taken by the demons or worse. Having seen the horrors of Mareth firsthand you know the risks of adventuring. Neisa is quick to acknowledge the loot as well.\n\n");
			outputText("\"<i>Aye I guess one person's misfortune is our fortune. Help me put these into a bag this should help cover for my pay.</i>\"\n\n");
			outputText("Once done the both of you resume moving.\n\n");
			flags[kFLAGS.NEISA_AFFECTION] = 10;
			doNext(roomA10);
		}
	}
}