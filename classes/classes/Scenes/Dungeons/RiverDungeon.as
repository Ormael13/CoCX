//Side Dungeon: River Dungeon (Dungeon with multiple floors below He'Xin'Dao)
/**
 * ...
 * @author Ormael, Liadri
 */
package classes.Scenes.Dungeons 
{
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Shield;
import classes.Items.Weapon;
import classes.Scenes.Areas.Lake.GreenSlime;
import classes.Scenes.Areas.Mountain.HellHound;
import classes.Scenes.Dungeons.RiverDungeon.AirElemental;
import classes.Scenes.Dungeons.RiverDungeon.DarknessElemental;
import classes.Scenes.Dungeons.RiverDungeon.EarthElemental;
import classes.Scenes.Dungeons.RiverDungeon.FireElemental;
import classes.Scenes.Dungeons.RiverDungeon.IceElemental;
import classes.Scenes.Dungeons.RiverDungeon.LightningElemental;
import classes.Scenes.Dungeons.RiverDungeon.QuatroElementalBoss;
import classes.Scenes.Dungeons.RiverDungeon.WaterElemental;
import classes.Scenes.Monsters.FeralImps;
import classes.CoC;
import classes.PerkLib;
import classes.Scenes.Monsters.GolemDummyImproved;
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
		
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_01:int	= 104;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_02:int	= 105;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_03:int	= 106;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_04:int	= 107;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_05:int	= 108;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_06:int	= 109;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_07:int	= 110;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_08:int = 111;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_09:int = 112;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_10:int = 113;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_11:int = 114;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_12:int = 115;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_13:int = 116;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_14:int = 117;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_15:int = 118;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_16:int = 119;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_17:int = 120;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_18:int = 121;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_19:int = 122;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_20:int = 123;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_21:int = 124;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_22:int = 125;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_23:int = 126;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_24:int = 127;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_25:int = 128;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_26:int = 129;
		private static const DUNGEON_RIVER_FLOOR_02_ROOM_27:int = 130;
		
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_01:int = 135;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_02:int = 136;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_03:int = 137;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_04:int = 138;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_05:int = 139;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_06:int = 140;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_07:int = 141;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_08:int = 142;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_09:int = 143;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_10:int = 144;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_11:int = 145;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_12:int = 146;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_13:int = 147;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_14:int = 148;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_15:int = 149;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_16:int = 150;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_17:int = 151;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_18:int = 152;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_19:int = 153;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_20:int = 154;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_21:int = 155;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_22:int = 156;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_23:int = 157;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_24:int = 158;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_25:int = 159;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_26:int = 160;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_27:int = 161;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_28:int = 162;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_29:int = 163;
		private static const DUNGEON_RIVER_FLOOR_03_ROOM_30:int = 164;
		
		public function RiverDungeon() {} //flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] 1 - pok 1 golema, 2 pokonanie obu golemów, ?5? pokonanie chimerycznego żywiołaka
		
		public function enterDungeon():void {
			inDungeon = true;
			dungeonLoc = 68;
			player.createStatusEffect(StatusEffects.RiverDungeonA, 10, 0, 0, 0);
			if (!player.hasStatusEffect(StatusEffects.RivereDungeonIB)) player.createStatusEffect(StatusEffects.RivereDungeonIB, 0, 0, 0, 0);
			playerMenu();
		}
		public function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			if (flags[kFLAGS.NEISA_FOLLOWER] == 3) {
				outputText("As the pair of you leave the dungeon Neisa waves off, heading back to town.\n\n");
				outputText("\"<i>Nice going along with you [name], this was worth it. I’m going to go and spend this bling on some well earned reward. See you around up there. If you ever need of my services again I will be at the bar.</i>\"\n\n");
				player.removeStatusEffect(StatusEffects.CombatFollowerNeisa);
				flags[kFLAGS.PLAYER_COMPANION_1] = "";
				flags[kFLAGS.NEISA_FOLLOWER] = 4;
				outputText("Working together with another person has taught you how to manage and plan with a group of people. <b>Gained Perk: Basic Leadership</b>");
				player.createPerk(PerkLib.BasicLeadership,0,0,0,0);
			}
			else outputText("You leave the river dungeon behind and take off through the He'Xin'Dao back towards the camp.");
			if (player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.removeStatusEffect(StatusEffects.ThereCouldBeOnlyOne);
			player.removeStatusEffect(StatusEffects.RiverDungeonA);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function encountersRuletteA():void {
			if ((rand(100) < player.statusEffectv1(StatusEffects.RiverDungeonA)) && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				var choice:Number = rand(3);
				if (choice == 0) {
					spriteSelect(29);
					outputText("A feral imp suddenly appears from nearby passage and attacks!");
					if (flags[kFLAGS.CODEX_ENTRY_IMPS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_IMPS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Imps!</b>")
					}
					flags[kFLAGS.FERAL_EXTRAS] = 5;
					startCombat(new FeralImps(), true);
				}
				if (choice == 1) {
					spriteSelect(25);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting an amorphous green mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  The beast surges forward to attack!");
					startCombat(new GreenSlime(), true);
				}
				if (choice == 2) {
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
			//cleanupAfterCombat();
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
			outputText("Beaten, you don’t have strength left to stop the golem from knocking you unconscious. After you wake up you find out that you’ve got a pair of gauntlets on your hands connected to a net of thin goo-like things that cover your whole body.\n\n");
			outputText("<i>This one would be much better than those mindless golems we used so far,</i> you suddenly hear a feminine voice in your head say. <i>Of course, living flesh is way better than simple animated stones. Goodnight old owner of this body.</i> With that you once again lose consciousness for the last time. You don’t wake up ever again.\n\n");
			outputText("After taking over control of the champion’s body, the new owner commands it to go out of the dungeon, maintaining the most natural as possible movement before they leave He'Xin'Dao. Then the both gauntlets let out girlish laughter and commands their new host body to go towards a destination known only by them...\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function takeAetherSister1():void {
			clearOutput();
			outputText("Succumbing to your skill in battle, the aether golem slumps backwards against the wall, unable to stand.  You loom over it, grinning as you contemplate what to do with your helpless opponent.\n\n");
			outputText("\"<i>Wait!</i>\" the voice resounds in your head. \"<i>You much better than this souless golem. So i decided to come back with you from this boring and dark place.");
			if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2) outputText(" You even have my twin sister.");
			outputText(" So shall i come with you or wait at 'that camp' you thought moment ago?</i>\"");
			flags[kFLAGS.AETHER_DEXTER_EVO] = 1;
			menu();
			addButton(0, "Wait", takeAetherSister1a);
			addButton(1, "Come", takeAetherSister1b);
		}
		public function takeAetherSister1a():void {
			outputText("\n\nYou tell the voice to wait at the camp. The moment you say it from golem gaunlet extends a thin tendril that wrap around you for a moment and then it returns. Between extending and reciding all the other tendrils, which was covering golem also receeded into the gaunlet. Then it vanish in flash of light leaving behind damaged golem.");
			flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 1;
			cleanupAfterCombat();
			doNext(playerMenu);
		}
		public function takeAetherSister1b():void {
			weapons.AETHERD.useText();
			player.weapon.removeText();
			cleanupAfterCombat();
			outputText("You tell the voice to come. With a giggle the gasunlet that was covering golem arm start to literaly flow form it to the floor then over it till it reaches you and climbing over your body reforms into gaunelt on your right arm and half of the forearm. \"<i>That will a blast!");
			if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2) outputText("</i>\" After this you hear other voice in your head. \"<i>The Aether twins united. Go go go twins!!!");
			outputText("</i>\"\n\n");
			var item:Weapon = player.setWeapon(weapons.AETHERD); //Item is now the player's old weapon
			if (item == null) doNext(roomA20);
			else inventory.takeItem(item, roomA20);
		}
		public function takeAetherSister2():void {
			clearOutput();
			outputText("Succumbing to your skill in battle, the aether golem slumps backwards against the wall, unable to stand.  You loom over it, grinning as you contemplate what to do with your helpless opponent.\n\n");
			outputText("\"<i>Wait!</i>\" the voice resounds in your head. \"<i>You much better than this souless golem. So i decided to come back with you from this boring and dark place.");
			if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2) outputText(" You even have my twin sister.");
			outputText(" So shall i come with you or wait at 'that camp' you thought moment ago?</i>\"");
			flags[kFLAGS.AETHER_SINISTER_EVO] = 1;
			menu();
			addButton(0, "Wait", takeAetherSister2a);
			addButton(1, "Come", takeAetherSister2b);
		}
		public function takeAetherSister2a():void {
			outputText("\n\nYou tell the voice to wait at the camp. The moment you say it from golem gaunlet extends a thin tendril that wrap around you for a moment and then it returns. Between extending and reciding all the other tendrils, which was covering golem also receeded into the gaunlet. Then it vanish in flash of light leaving behind damaged golem.");
			flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 1;
			cleanupAfterCombat();
			doNext(playerMenu);
		}
		public function takeAetherSister2b():void {
			shields.AETHERS.useText();
			player.shield.removeText();
			cleanupAfterCombat();
			outputText("You tell the voice to come. With a giggle the gasunlet that was covering golem arm start to literaly flow form it to the floor then over it till it reaches you and climbing over your body reforms into gaunelt on your right arm and half of the forearm. \"<i>That will a blast!");
			if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2) outputText("</i>\" After this you hear other voice in your head. \"<i>The Aether twins united. Go go go twins!!!");
			outputText("</i>\"\n\n");
			var item:Shield = player.setShield(shields.AETHERS); //Item is now the player's old shield
			if (item == null) doNext(roomA15);
			else inventory.takeItem(item, roomA15);
		}
		
		private function encountersRuletteB():void {
			if ((rand(100) < player.statusEffectv1(StatusEffects.RiverDungeonA)) && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				var choice:Number = rand(4);
				if (choice == 0) {
					//spriteSelect(25);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a small ball of flame rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(3);
					/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
					}*/
					startCombat(new FireElemental(), true);
				}
				if (choice == 1) {
					//spriteSelect(25);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a small blob of water rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(3);
					/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
					}*/
					startCombat(new WaterElemental(), true);
				}
				if (choice == 2) {
					//spriteSelect(25);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a small gust of wind rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(3);
					/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
					}*/
					startCombat(new AirElemental(), true);
				}
				if (choice == 3) {
					//spriteSelect(25);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting small mass of earth rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(3);
					/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
					}*/
					startCombat(new EarthElemental(), true);
				}
				doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 10);
		}
		private function encountersRuletteBFire():void {
			if ((rand(100) < player.statusEffectv1(StatusEffects.RiverDungeonA)) && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				//spriteSelect(25);
				outputText("A soft shuffling sound catches your attention and you turn around, spotting a large ball of flame rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 3;
				/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
					outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
				}*/
				startCombat(new FireElemental(), true);
				doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 20);
		}
		private function encountersRuletteBWater():void {
			if ((rand(100) < player.statusEffectv1(StatusEffects.RiverDungeonA)) && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				outputText("A soft shuffling sound catches your attention and you turn around, spotting a large blob of water rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 3;
				/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
					outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
				}*/
				startCombat(new WaterElemental(), true);
				doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 20);
		}
		private function encountersRuletteBAir():void {
			if ((rand(100) < player.statusEffectv1(StatusEffects.RiverDungeonA)) && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				//spriteSelect(25);
				outputText("A soft shuffling sound catches your attention and you turn around, spotting a large gust of wind rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 3;
				/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
					outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
				}*/
				startCombat(new AirElemental(), true);
				doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 20);
		}
		private function encountersRuletteBEarth():void {
			if ((rand(100) < player.statusEffectv1(StatusEffects.RiverDungeonA)) && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				//spriteSelect(25);
				outputText("A soft shuffling sound catches your attention and you turn around, spotting large mass of earth rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 3;
				/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
					outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
				}*/
				startCombat(new EarthElemental(), true);
				doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 20);
		}
		
		public function defeatedByFireElemental():void {
			clearOutput();
			outputText("Your opponent punch you few more times and then carries all the way back to this floor entrance from upper floor and drop you there. Guess it's back to square one on this floor.\n\n");
			inDungeon = true;
			dungeonLoc = 104;
			playerMenu();
		}
		public function defeatedByWaterElemental():void {
			clearOutput();
			outputText("Your opponent punch you few more times and then carries all the way back to this floor entrance from upper floor and drop you there. Guess it's back to square one on this floor.\n\n");
			inDungeon = true;
			dungeonLoc = 104;
			playerMenu();
		}
		public function defeatedByAirElemental():void {
			clearOutput();
			outputText("Your opponent punch you few more times and then carries all the way back to this floor entrance from upper floor and drop you there. Guess it's back to square one on this floor.\n\n");
			inDungeon = true;
			dungeonLoc = 104;
			playerMenu();
		}
		public function defeatedByEarthElemental():void {
			clearOutput();
			outputText("Your opponent punch you few more times and then carries all the way back to this floor entrance from upper floor and drop you there. Guess it's back to square one on this floor.\n\n");
			inDungeon = true;
			dungeonLoc = 104;
			playerMenu();
		}
		public function defeatedByFireElementalSubBoss():void {
			clearOutput();
			outputText("As You collapse, unable to fight any longer, the Ifrit summons several additional blazing spheres. Her hands heat with blazing fire as she continues the somatics, condensing her hands together as the spheres shoot toward you.\n\n");
			outputText("Your world is set aflame as the fire burns you to ashes. There is nothing left of you but a few burnt remains.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedByWaterElementalSubBoss():void {
			clearOutput();
			outputText("You collapse from your wounds, unable to fight any longer as Undine presses the attack, freely flicking sharp, crescent-shaped shards of water at you.\n\n");
			outputText("As your [skin] is carved away from the jets of water, your mind swirls as your journey comes to an end.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedByAirElementalSubBoss():void {
			clearOutput();
			outputText("As you fall, unable to fight any longer, the Sylph advances upon you. The wind around you swirls as the Sylph prepares another strike. Air currents condense into new crescent-shaped wind blades, covering your paths of retreat. You pause, watching in horror as a wall of wind blades surround you. The sylph waves its hand, sending every last blade in your direction.\n\n");
			outputText("You brace yourself for the lacerations, each blade cuts through you as your journey comes to an end, gone with the wind.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedByEarthElementalSubBoss():void {
			clearOutput();
			outputText("As you collapse, unable to fight any longer, you notice numerous pointed stones circle around the air. The golem swings her hand in a single fluid motion before the razor-like stones dig into you.\n\n");
			outputText("You don't have enough time to scream as the rocks separate your [skin] from the rest of your body. Buried and crushed beneath the stone, your journey comes to an end.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedByQuatroElementalBoss():void {
			clearOutput();
			outputText("You colapse too wounded to continue fighting. Elemental as if enjoying your state approaching you deliberly slowly and grabbing your body with it four larger arms rise it into the air. Then it reach with it smaller pair of arms to your body and grabs your chest. ");
			if (player.statusEffectv1(StatusEffects.RivereDungeonIB) == 3) outputText("Flames");
			if (player.statusEffectv4(StatusEffects.RivereDungeonIB) == 3) outputText("Magma");
			if (player.statusEffectv2(StatusEffects.RivereDungeonIB) == 3) outputText("Magma and steam");
			if (player.statusEffectv3(StatusEffects.RivereDungeonIB) == 3) outputText("Magma, steam and razor sharp air currents");
			outputText(" that are covering them starts to slowly ravish your body adding new wounds. It cause that all very slowly as if it would toying with you until you finaly succub to your wounds fomr fight and it torture and close your eyes for the last time.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatFireElementalSubBoss():void {
			clearOutput();
			outputText("The Ifrit gives you a blank stare, as if deciding her next action. As she stands silently, the flames around her body cackle with embers as her entire form begins shining brightly like a dying star. You're forced to avert your eyes from the painful illumination.\n\n");
			outputText("The light quickly fades as you turn back to where the Ifrit once stood. The only thing that remains is a reddish core, lying dormant on the ground.\n\n");
			player.createKeyItem("Fire Ifrit Core", 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.RivereDungeonIB, 1, 1);
			flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS]++;
			doNext(roomB18);
		}
		public function defeatWaterElementalSubBoss():void {
			clearOutput();
			outputText("The Undine stops moving, holding its place like a body of undisturbed water. Suddenly, without any signs it the body loses shape, the fluid spills onto the ground in a small puddle.\n\n");
			outputText("You notice something lying dormantly within the small pool of water. You cautiously approach to retrieve the blue sphere.\n\n");
			player.createKeyItem("Water Undine Core", 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.RivereDungeonIB, 2, 1);
			flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS]++;
			doNext(roomB21);
		}
		public function defeatAirElementalSubBoss():void {
			clearOutput();
			outputText("The Sylph pauses in its tracks. Without warning, it suddenly shoots a strong gust of wind toward you. You reflexively brace yourself for the attack but the wind dissipates before reaching you.\n\n");
			outputText("You look toward where the air elemental used to be, now nothing but a small, dormant sphere suspended in the air. It slowly descends to the ground as a feather would before you decide to inspect it.\n\n");
			player.createKeyItem("Air Sylph Core", 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.RivereDungeonIB, 3, 1);
			flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS]++;
			doNext(roomB24);
		}
		public function defeatEarthElementalSubBoss():void {
			clearOutput();
			outputText("The Golem stands for a moment as a low rumbling sound enemates from it. Quickly, stones begin sloughing off its body, one by one. As quickly as it started, the humanoid form is lost to a small mound of rubble.\n\n");
			outputText("A single sphere sticks out from the top of the pile of rocks. It lies dormantly before you before you as you inspect it.\n\n");
			player.createKeyItem("Earth Golem Core", 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.RivereDungeonIB, 4, 1);
			flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS]++;
			doNext(roomB27);
		}
		public function defeatQuatroElementalBoss():void {
			clearOutput();
			outputText("The revenant collapses as all the elements it's gained die out. The rubble lies dormantly before you before slowly sinking into the ground. The voices ring as sparks of multicolored embers, each resembling one of the four elements it aligned with fly out, <i>“The elements will rise again.”</i>\n\n");
			outputText("As the sparks fade, all that remains is an empty shell, cold and lifeless. You inspect the elemental carefully, but somehow you know nothing will come from it this time. It's apparently bare now. Though, you can't say for sure if you won't be meeting something like it again later.\n\n");
			outputText("As you begin to take your leave, a sudden glow illuminates within the rubble, pulsating gently. Carefully, you draw closer, moving aside the debris to reveal a small, glowing heart. It pulses gently within your grasp, warm, almost alive.\n\n");
			player.addStatusValue(StatusEffects.RivereDungeonIB, 3, 1);
			player.createKeyItem("Flame Heart", 0, 0, 0, 0);
			flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS]++;
			doNext(roomB08);
		}
		
		private function encountersRuletteC():void {
			if ((rand(100) < player.statusEffectv1(StatusEffects.RiverDungeonA)) && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				var choice:Number = rand(4);
				if (choice == 0) {
					//spriteSelect(25);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a small cluster of ice rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(4);
					/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
					}*/
					startCombat(new IceElemental(), true);
				}
				if (choice == 1) {
					//spriteSelect(25);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a small ball of darkness rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(4);
					/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
					}*/
					startCombat(new DarknessElemental(), true);
				}
				if (choice == 2) {
					//spriteSelect(25);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a small ball of lighting rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(4);
					/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
					}*/
					startCombat(new LightningElemental(), true);
				}/*
				if (choice == 3) {
					//spriteSelect(25);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a small ball of flame rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(4);
					/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
					}
					startCombat(new FireElemental(), true);		yeti
				}
				if (choice == 4) {
					//spriteSelect(25);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a small ball of flame rushing towards you!  Realizing it's been spotted, the elemental's body reform into a humanoid form and attacks!");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(4);
					/*if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Elementals!</b>")
					}
					startCombat(new FireElemental(), true);		raiju
				}*/
				doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 10);
		}
		
		public function defeatedByIceElemental():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			inDungeon = true;
			dungeonLoc = 135;
			playerMenu();
		}
		public function defeatedByLightningElemental():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			inDungeon = true;
			dungeonLoc = 135;
			playerMenu();
		}
		public function defeatedByDarknessElemental():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			inDungeon = true;
			dungeonLoc = 135;
			playerMenu();
		}
		public function defeatedByYeti():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			inDungeon = true;
			dungeonLoc = 135;
			playerMenu();
		}
		public function defeatedByRaiju():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			inDungeon = true;
			dungeonLoc = 135;
			playerMenu();
		}
		/*public function defeatedBy<Boss enemy>():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		
		public function defeated<Boss enemy>():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}*/
		
		/*public function defeatedBy():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			inDungeon = true;
			dungeonLoc = 105;
			playerMenu();
		}
		public function defeatedBy():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			inDungeon = true;
			dungeonLoc = 105;
			playerMenu();
		}
		public function defeatedBy<Boss enemy>():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		
		public function defeated():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			inDungeon = true;
			dungeonLoc = ;starting for each floor room
			playerMenu();
		}
		public function defeated<Boss enemy>():void {
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
			outputText("You run into an old campsite. By the looks of it an adventurer must have rested there, through the fire likely died a month ago by the look of it. What a peculiar fire too, just who the hell would grab bones, set them in a stone circle and then impale a skull on a rusty longsword before setting fire to it?");
			dungeons.setDungeonButtonsRD(null, null, null, roomA02);
			addButton(0, "Teleport C.", teleportCircleFloor1);
			if (flags[kFLAGS.NEISA_AFFECTION] < 10 && flags[kFLAGS.NEISA_FOLLOWER] < 4) addButtonDisabled(10, "Up", "You would leave now but you have yet to find enough to pay Neisa."); 
			else addButton(10, "Up", exitDungeon);
		}
		public function roomA02():void {
			dungeonLoc = 69;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small glittering bones covers the rocky ground ahead of you. Likely those are the remains of some ancient monsters that used to live on Mareth a long time ago.");
			dungeons.setDungeonButtonsRD(roomA03, null, roomA01, null);
		}
		public function roomA03():void {
			dungeonLoc = 70;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You spot a small lizard lazily resting on the cold hard stone above you. The air is humid and cold. On the walls are old graffiti likely left by ancient civilisations of animal morphs.");
			dungeons.setDungeonButtonsRD(roomA08, roomA02, null, roomA04);
			if (flags[kFLAGS.NEISA_AFFECTION] < 5 && flags[kFLAGS.NEISA_FOLLOWER] < 4) tresureRoom1A();
		}
		public function roomA04():void {
			dungeonLoc = 71;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You can hear water running on a nearby wall from a fissure in the rock. You can only hope this thing won’t break open and flood the place over while you are deeper in.");
			dungeons.setDungeonButtonsRD(null, null, roomA03, roomA05);
		}
		public function roomA05():void {
			dungeonLoc = 72;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small glittering bones covers the rocky ground ahead of you. Likely those are the remains of some ancient monsters that used to live on Mareth a long time ago.");
			dungeons.setDungeonButtonsRD(roomA16, roomA06, roomA04, null);
		}
		public function roomA06():void {
			dungeonLoc = 73;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small Bats fly out as you walk by above your head hangs some large stalactites. You think to yourself it would be most unfortunate if one of these was to randomly fall down and run you through.");
			dungeons.setDungeonButtonsRD(roomA05, null, null, null);
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 1) addButton(11, "Down", roomB01);
			else addButtonDisabled(11, "Down", "You still need to beat guardians of this floor to descend into lower strata of the dungeon.");
		}
		public function roomA07():void {
			dungeonLoc = 74;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You run into an old campsite. by the looks of it an adventurer must have rested there, through the fire likely died a month ago by the look of it. What a peculiar fire too, just who the hell would grab bones, set them in a stone circle and then impale a skull on a rusty longsword before setting fire to it?");
			dungeons.setDungeonButtonsRD(roomA11, null, null, roomA08);
		}
		public function roomA08():void {
			dungeonLoc = 75;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small Bats fly out as you walk by above your head hangs some large stalactites. You think to yourself it would be most unfortunate if one of these was to randomly fall down and run you through.");
			dungeons.setDungeonButtonsRD(null, roomA03, roomA07, roomA09);
		}
		public function roomA09():void {
			dungeonLoc = 76;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You can hear running water above you, the river is likely flowing right up your head. Guess explosive magic right now is ill advised.");
			dungeons.setDungeonButtonsRD(roomA10, null, roomA08, null);
		}
		public function roomA10():void {
			dungeonLoc = 77;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You spot a small lizard lazily resting on the cold hard stone above you. The air is humid and cold. On the walls are old graffiti likely left by ancient civilisations of animal morphs.");
			dungeons.setDungeonButtonsRD(null, roomA09, null, null);
			if (flags[kFLAGS.NEISA_AFFECTION] == 5 && flags[kFLAGS.NEISA_FOLLOWER] < 4) tresureRoom2A();
		}
		public function roomA11():void {
			dungeonLoc = 78;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("The walls around you are covered with ancient lichen. You can see a fissure from which small droplets of water fall down the rivulet flowing down deeper in the dungeon.");
			dungeons.setDungeonButtonsRD(roomA12, roomA07, null, null);
		}
		public function roomA12():void {
			dungeonLoc = 79;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small glowy mushrooms cover the walls of the room you move through, just enough for you to see a short distance ahead.");
			dungeons.setDungeonButtonsRD(null, roomA11, roomA13, null);
		}
		public function roomA13():void {
			dungeonLoc = 80;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("A small underground lake has formed in the massive room you move by. You thread a safe distance away from the dark waters wary of what may lurk in its depths.");
			dungeons.setDungeonButtonsRD(roomA15, null, roomA14, roomA12);
		}
		public function roomA14():void {
			dungeonLoc = 81;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("The walls around you are covered with ancient lichen. You can see a fissure from which small droplets of water fall down the rivulet flowing down deeper in the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, roomA13);
		}
		public function roomA15():void {
			dungeonLoc = 82;
			clearOutput();
			if (flags[kFLAGS.AETHER_SINISTER_EVO] < 1) {
				flags[kFLAGS.AETHER_SINISTER_EVO] = 0.5;
				outputText("As you peek into a room, out of nearby shadow emerge golem. Looks like you have encountered aether golem! You ready your [weapon] for a fight!");
				startCombat(new GolemDummyImproved(), true);
			}
			else encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You find some old bones on the ground likely those of a beast that died here. These are at least the size of what could pass back in Ingnam for a cow.");
			dungeons.setDungeonButtonsRD(null, roomA13, null, null);
		}
		public function roomA16():void {
			dungeonLoc = 83;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You can hear running water above you, the river is likely flowing right up your head. Guess explosive magic right now is ill advised.");
			dungeons.setDungeonButtonsRD(roomA17, roomA05, null, null);
		}
		public function roomA17():void {
			dungeonLoc = 84;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small glowy mushrooms cover the walls of the room you move through, just enough for you to see a short distance ahead.");
			dungeons.setDungeonButtonsRD(null, roomA16, null, roomA18);
		}
		public function roomA18():void {
			dungeonLoc = 85;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("A small underground lake has formed in the massive room you move by. You thread a safe distance away from the dark waters wary of what may lurk in its depths.");
			dungeons.setDungeonButtonsRD(roomA20, null, roomA17, roomA19);
		}
		public function roomA19():void {
			dungeonLoc = 86;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You can hear water running on a nearby wall from a fissure in the rock. You can only hope this thing won’t break open and flood the place over while you are deeper in.");
			dungeons.setDungeonButtonsRD(null, null, roomA18, null);
		}
		public function roomA20():void {
			dungeonLoc = 87;
			clearOutput();
			if (flags[kFLAGS.AETHER_DEXTER_EVO] < 1) {
				flags[kFLAGS.AETHER_DEXTER_EVO] = 0.5;
				outputText("As you peek into a room, out of nearby shadow emerge golem. Looks like you have encountered aether golem! You ready your [weapon] for a fight!");
				startCombat(new GolemDummyImproved(), true);
			}
			else encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You find some old bones on the ground likely those of a beast that died here. These are at least the size of what could pass back in Ingnam for a cow.");
			dungeons.setDungeonButtonsRD(null, roomA18, null, null);
		}
		
		public function roomB01():void {
			dungeonLoc = 104;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Your vision is obscured by thick fog. You instinctively tense as the echoes of footsteps bounce off the walls. Enemies could be right next to you, and you wouldn't know unless you bump into one. You break into a light sweat, or is that the moisture condescending onto your [skin]?");
			dungeons.setDungeonButtonsRD(roomB02, null, null, null);
			addButton(0, "Teleport C.", teleportCircleFloor2);
			addButton(11, "Up", roomA06);
		}
		public function roomB02():void {
			dungeonLoc = 105;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(roomB16, roomB01, null, roomB06);
		}
		public function roomB03():void {
			dungeonLoc = 106;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(roomB04, null, roomB25, null);
		}
		public function roomB04():void {
			dungeonLoc = 107;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Your vision is obscured by thick fog. You instinctively tense as the echoes of footsteps bounce off the walls. Enemies could be right next to you, and you wouldn't know unless you bump into one. You break into a light sweat, or is that the moisture condescending onto your [skin]?");
			dungeons.setDungeonButtonsRD(roomB05, roomB03, null, roomB07);
		}
		public function roomB05():void {
			dungeonLoc = 108;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(roomB06, roomB04, null, roomB08);
		}
		public function roomB06():void {
			dungeonLoc = 109;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, roomB05, roomB02, roomB09);
		}
		public function roomB07():void {
			dungeonLoc = 110;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Your vision is obscured by thick fog. You instinctively tense as the echoes of footsteps bounce off the walls. Enemies could be right next to you, and you wouldn't know unless you bump into one. You break into a light sweat, or is that the moisture condescending onto your [skin]?");
			dungeons.setDungeonButtonsRD(roomB08, null, roomB04, roomB10);
		}
		public function roomB08():void {
			dungeonLoc = 111;
			clearOutput();//boss room
			if (player.statusEffectv1(StatusEffects.RivereDungeonIB) == 1 && player.statusEffectv2(StatusEffects.RivereDungeonIB) == 1 && player.statusEffectv3(StatusEffects.RivereDungeonIB) == 1 && player.statusEffectv4(StatusEffects.RivereDungeonIB) == 1) {
				player.addStatusValue(StatusEffects.RivereDungeonIB, 1, 1);
				player.addStatusValue(StatusEffects.RivereDungeonIB, 2, 1);
				player.addStatusValue(StatusEffects.RivereDungeonIB, 3, 1);
				player.addStatusValue(StatusEffects.RivereDungeonIB, 4, 1);
				outputText("As you step into the room, four suddenly erupt with a raucous of flames as the faint smell of incense fills the room. Your ears perk at the distant sound of wind within the tunnels. An echo follows with a gentle stream of water steadily growing closer.\n\n");
				outputText("Your balance shifts as the ground quakes beneath you. You reflexively step back as the ground splits before you as a rift opens. "+(silly() ? "Is that boss music?":"")+" From the darkness of the unsealed rift, a hand emerges before pulling itself out of the crevice.\n\n");
				outputText("The creature hovers ominously. Its ellipsoid torso is accompanied by two short arms, thin with visible segments, tapering into a single point. From its shoulders sprout two additional pairs of arms, twice the size of the smaller one as it ends in insect-like claws.\n\n");
				outputText("Tapering down from its torso is a tail much longer than the body, slowly dangling in the still air. The thing levitates with its lack of legs as you quickly examine it. Its eyes begin to open; the four of them aligning into a diamond shape. The creature stares at you with a distant glare, as if it hasn't realized its purpose in this reality.\n\n");
				outputText("Embers from the braziers slowly crawl toward the rift as the fissure begins to seal.\n\n");
				outputText("The flames begin to merge with the being, setting its arms alight before it hurls itself toward you.\n\n");
				outputText("You brace yourself, it's a fight!n\n");
				startCombat(new QuatroElementalBoss(), true);
			}
			else encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			outputText("\n\nIn four corners of this area are incense burners.\n\nNorthwest one ");
			if (player.hasStatusEffect(StatusEffects.RivereDungeonIB) && (player.statusEffectv1(StatusEffects.RivereDungeonIB) == 1 || player.statusEffectv1(StatusEffects.RivereDungeonIB) == 3)) outputText("burning with a red flame");
			else outputText("is extinguished");
			outputText(".\nNortheast one ");
			if (player.hasStatusEffect(StatusEffects.RivereDungeonIB) && (player.statusEffectv2(StatusEffects.RivereDungeonIB) == 1 || player.statusEffectv2(StatusEffects.RivereDungeonIB) == 3)) outputText("burning with a blue flame");
			else outputText("is extinguished");
			outputText(".\nSoutheast one ");
			if (player.hasStatusEffect(StatusEffects.RivereDungeonIB) && (player.statusEffectv3(StatusEffects.RivereDungeonIB) == 1 || player.statusEffectv3(StatusEffects.RivereDungeonIB) == 3)) outputText("burning with a white flame");
			else outputText("is extinguished");
			outputText(".\nSouthwest one ");
			if (player.hasStatusEffect(StatusEffects.RivereDungeonIB) && (player.statusEffectv4(StatusEffects.RivereDungeonIB) == 1 || player.statusEffectv4(StatusEffects.RivereDungeonIB) == 3)) outputText("burning with a brown flame");
			else outputText("is extinguished");
			outputText(".");
			dungeons.setDungeonButtonsRD(roomB09, roomB07, roomB05, roomB11);
		}
		public function roomB09():void {
			dungeonLoc = 112;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, roomB08, roomB06, roomB12);
		}
		public function roomB10():void {
			dungeonLoc = 113;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Your vision is obscured by thick fog. You instinctively tense as the echoes of footsteps bounce off the walls. Enemies could be right next to you, and you wouldn't know unless you bump into one. You break into a light sweat, or is that the moisture condescending onto your [skin]?");
			dungeons.setDungeonButtonsRD(roomB11, null, roomB07, roomB14);
		}
		public function roomB11():void {
			dungeonLoc = 114;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(roomB12, roomB10, roomB08, null);
		}
		public function roomB12():void {
			dungeonLoc = 115;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Your vision is obscured by thick fog. You instinctively tense as the echoes of footsteps bounce off the walls. Enemies could be right next to you, and you wouldn't know unless you bump into one. You break into a light sweat, or is that the moisture condescending onto your [skin]?");
			dungeons.setDungeonButtonsRD(roomB13, roomB11, roomB09, null);
		}
		public function roomB13():void {
			dungeonLoc = 116;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, roomB12, null, roomB19);
		}
		public function roomB14():void {
			dungeonLoc = 117;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(roomB15, roomB22, roomB10, null);
		}
		public function roomB15():void {
			dungeonLoc = 118;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Your vision is obscured by thick fog. You instinctively tense as the echoes of footsteps bounce off the walls. Enemies could be right next to you, and you wouldn't know unless you bump into one. You break into a light sweat, or is that the moisture condescending onto your [skin]?");
			dungeons.setDungeonButtonsRD(null, roomB14, null, null);
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 6) addButton(6, "Down", roomC01);
			else addButtonDisabled(6, "Down", "You still need to beat guardian of this floor to descend into lower strata of the dungeon.");
		}
		public function roomB16():void {
			dungeonLoc = 119;
			clearOutput();
			encountersRuletteBFire();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you enter the new area, your breaths grow shallow as you have difficulty breathing in new air. Heat washes over you as the sides of the room glow with an orange hue. \n\nPeriodically, you hear a loud hissing as steam rises in the air. Coughing, you continue through the tunnels, wary of potential dangers.");
			dungeons.setDungeonButtonsRD(null, roomB02, roomB17, null);
		}
		public function roomB17():void {
			dungeonLoc = 120;
			clearOutput();
			encountersRuletteBFire();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you enter the new area, your breaths grow shallow as you have difficulty breathing in new air. Heat washes over you as the sides of the room glow with an orange hue. \n\nPeriodically, you hear a loud hissing as steam rises in the air. Coughing, you continue through the tunnels, wary of potential dangers.");
			dungeons.setDungeonButtonsRD(null, roomB18, null, roomB16);
		}
		public function roomB18():void {
			dungeonLoc = 121;
			clearOutput();
			if (player.statusEffectv1(StatusEffects.RivereDungeonIB) == 0) {
				outputText("A crackling sound emanates from this distance. You turn to face a large ball of fire rushing toward you. The ball shifts, forming itself into a humanoid form in your presence. ");
				outputText("It morphs into nine-foot-tall ifrit with a clear feminine shape.  Its entire body is alight as it attacks! You must prepare to fight!");
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 4;
				startCombat(new FireElemental(), true);
			}
			else encountersRuletteBFire();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you enter the new area, your breaths grow shallow as you have difficulty breathing in new air. Heat washes over you as the sides of the room glow with an orange hue. \n\nPeriodically, you hear a loud hissing as steam rises in the air. Coughing, you continue through the tunnels, wary of potential dangers.");
			dungeons.setDungeonButtonsRD(roomB17, null, null, null);
		}
		public function roomB19():void {
			dungeonLoc = 122;
			clearOutput();
			encountersRuletteBWater();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you step into the next room, your balance is nearly thrown off as you can feel yourself sinking slightly with each second of movement. You look down, noticing the thick mud beneath you. Best not to stand still too long lest you get stuck.\n\nThe room is much like the densest bog you've ever traveled in. The mist is so thick, you can hardly see more than a few feet in front of you. ");
			outputText("You tread gingerly through the dank room, making sure not to step in anything you wouldn't want to.");
			dungeons.setDungeonButtonsRD(roomB20, null, roomB13, null);
		}
		public function roomB20():void {
			dungeonLoc = 123;
			clearOutput();
			encountersRuletteBWater();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you step into the next room, your balance is nearly thrown off as you can feel yourself sinking slightly with each second of movement. Best not to stand still too long lest you get stuck.\n\nThe room is much like the densest bog you've ever traveled in. The mist is so thick, you can hardly see more than a few feet in front of you. ");
			outputText("You tread gingerly through the dank room, making sure not to step in anything you wouldn't want to.");
			dungeons.setDungeonButtonsRD(null, roomB19, roomB21, null);
		}
		public function roomB21():void {
			dungeonLoc = 124;
			clearOutput();
			if (player.statusEffectv2(StatusEffects.RivereDungeonIB) == 0) {
				outputText("A soft warble emanates from nearby, it sounds much like rolling waves, quickly approaching. You notice a large sphere of water rolling toward you.  It bounces, the ball jiggling with each hop before it quickly begins to take form.  ");
				outputText("The body of water quickly coalesces into the form a water undine with clear masculine features.  It focuses its attention on you, still dripping with water before it shifts aggressively, prepared to attack. It's a fight!");
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 4;
				startCombat(new WaterElemental(), true);
			}
			else encountersRuletteBWater();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you step into the next room, your balance is nearly thrown off as you can feel yourself sinking slightly with each second of movement. Best not to stand still too long lest you get stuck.\n\nThe room is much like the densest bog you've ever traveled in. The mist is so thick, you can hardly see more than a few feet in front of you. ");
			outputText("You tread gingerly through the dank room, making sure not to step in anything you wouldn't want to.");
			dungeons.setDungeonButtonsRD(null, null, null, roomB20);
		}
		public function roomB22():void {
			dungeonLoc = 125;
			clearOutput();
			encountersRuletteBAir();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("A dense blanket of dark clouds cover the ceiling of the room, not unlike the storms you remember back home in Ignam. Thunder and lightning crash throughout the room at random, accompanied by forceful gusts of wind. If you're not careful, you could be thrown off your feet or struck at any moment. ");
			outputText("Small vortexes swirl within the room, spawning at random. They briefly clear a visible path for you ahead, but you remain careful as you push forward.");
			dungeons.setDungeonButtonsRD(roomB14, null, null, roomB23);
		}
		public function roomB23():void {
			dungeonLoc = 126;
			clearOutput();
			encountersRuletteBAir();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("A dense blanket of dark clouds cover the ceiling of the room, not unlike the storms you remember back home in Ignam. Thunder and lightning crash throughout the room at random, accompanied by forceful gusts of wind. If you're not careful, you could be thrown off your feet or struck at any moment. ");
			outputText("Small vortexes swirl within the room, spawning at random. They briefly clear a visible path for you ahead, but you remain careful as you push forward.");
			dungeons.setDungeonButtonsRD(roomB24, null, roomB22, null);
		}
		public function roomB24():void {
			dungeonLoc = 127;
			clearOutput();
			if (player.statusEffectv3(StatusEffects.RivereDungeonIB) == 0) {
				outputText("A loud howl of wind is heard not far, you turn your attention to the source of the noise as you notice a tornado spinning itself toward you. The tornado is twice the size of the miniature vortexes you've seen earlier. As it draws closer, it quickly shifts into a humanoid form.  ");
				outputText("As the harsh winds die out, the sylph takes a masculine form.  Its eyes focus upon you before it darts toward you. You brace yourself for combat.");
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 4;
				startCombat(new AirElemental(), true);
			}
			else encountersRuletteBAir();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("A dense blanket of dark clouds cover the ceiling of the room, not unlike the storms you remember back home in Ignam. Thunder and lightning crash throughout the room at random, accompanied by forceful gusts of wind. If you're not careful, you could be thrown off your feet or struck at any moment. ");
			outputText("Small vortexes swirl within the room, spawning at random. They briefly clear a visible path for you ahead, but you remain careful as you push forward.");
			dungeons.setDungeonButtonsRD(null, roomB23, null, null);
		}
		public function roomB25():void {
			dungeonLoc = 128;
			clearOutput();
			encountersRuletteBEarth();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you tread through the sandy, desert-like area, you're constantly buffeted by swirling sand. Dust devils whirl about from the strange wind emitting from the walls. Your senses are shut as you try to shield your eyes from the rough sand as the howling sandstorm is deafening to the point you can hardly hear anything else. ");
			outputText("The eerie fog of the dungeon remains, tossed about by the raging fury of disturbed sand. Treading is nearly impossible, but you persevere, mindful of each step you take.");
			dungeons.setDungeonButtonsRD(null, roomB26, null, roomB03);
		}
		public function roomB26():void {
			dungeonLoc = 129;
			clearOutput();
			encountersRuletteBEarth();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you tread through the sandy, desert-like area, you're constantly buffeted by swirling sand. Dust devils whirl about from the strange wind emitting from the walls. Your senses are shut as you try to shield your eyes from the rough sand as the howling sandstorm is deafening to the point you can hardly hear anything else. ");
			outputText("The eerie fog of the dungeon remains, tossed about by the raging fury of disturbed sand. Treading is nearly impossible, but you persevere, mindful of each step you take.");
			dungeons.setDungeonButtonsRD(roomB25, null, null, roomB27);
		}
		public function roomB27():void {
			dungeonLoc = 130;
			clearOutput();
			if (player.statusEffectv4(StatusEffects.RivereDungeonIB) == 0) {
				outputText("An avalanche of rocks rumbles the ground. You glance over and notice a series of stones rolling over each other toward your direction.  It's much larger than the usual elementals.  As it approaches, the stone quickly take shape of a humanoid figure. ");
				outputText("The rocks roll over, taking on a feminine form. Its eyes focus before it raises a fist. You brace yourself, it looks like the fight is on!");
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 4;
				startCombat(new EarthElemental(), true);
			}
			else encountersRuletteBEarth();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you tread through the sandy, desert-like area, you're constantly buffeted by swirling sand. Dust devils whirl about from the strange wind emitting from the walls. Your senses are shut as you try to shield your eyes from the rough sand as the howling sandstorm is deafening to the point you can hardly hear anything else. ");
			outputText("The eerie fog of the dungeon remains, tossed about by the raging fury of disturbed sand. Treading is nearly impossible, but you persevere, mindful of each step you take.");
			dungeons.setDungeonButtonsRD(null, null, roomB26, null);
		}
		public function roomC01():void {
			dungeonLoc = 135;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, roomC02, null, null);
			addButton(0, "Teleport C.", teleportCircleFloor3);
			addButton(6, "Up", roomB15);
		}
		public function roomC02():void {
			dungeonLoc = 136;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(roomC01, null, roomC03, null);
		}
		public function roomC03():void {
			dungeonLoc = 137;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, roomC08, roomC04, roomC02);
		}
		public function roomC04():void {
			dungeonLoc = 138;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, roomC03);//dungeons.setDungeonButtonsRD(null, null, roomC21, roomC03);
		}
		public function roomC05():void {
			dungeonLoc = 139;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, roomC10, roomC06, null);
		}
		public function roomC06():void {
			dungeonLoc = 140;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, roomC07, roomC05);
		}
		public function roomC07():void {
			dungeonLoc = 141;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, roomC08, roomC06);
		}
		public function roomC08():void {
			dungeonLoc = 142;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(roomC03, null, null, roomC07);
		}
		public function roomC09():void {
			dungeonLoc = 143;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC10():void {
			dungeonLoc = 144;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(roomC05, null, null, null);
		}
		public function roomC11():void {
			dungeonLoc = 145;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC12():void {
			dungeonLoc = 146;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC13():void {
			dungeonLoc = 147;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC14():void {
			dungeonLoc = 148;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC15():void {
			dungeonLoc = 149;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC16():void {
			dungeonLoc = 150;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC17():void {
			dungeonLoc = 151;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC18():void {
			dungeonLoc = 152;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC19():void {
			dungeonLoc = 153;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC20():void {
			dungeonLoc = 154;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC21():void {	//ice palace themed section of floor with boss been either yeti/ice queen like ice elemental or smth else related to ice
			dungeonLoc = 155;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, roomC04);
		}
		public function roomC22():void {
			dungeonLoc = 156;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC23():void {
			dungeonLoc = 157;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC24():void {
			dungeonLoc = 158;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC25():void {
			dungeonLoc = 159;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC26():void {
			dungeonLoc = 160;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC27():void {
			dungeonLoc = 161;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC28():void {
			dungeonLoc = 162;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC29():void {
			dungeonLoc = 163;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomC30():void {
			dungeonLoc = 164;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		/*
		public function roomD01():void {
			dungeonLoc = 1xx;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Mists of mystery covers your surrounding making you unable to see what is around you aside passages to other parts of the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		*/
		private function tresureRoom1A():void {
			clearOutput();
			outputText("You notice a faint glimmer in the distance and approach it. The glimmer reveals itself to be embedded in a wall covered with gemstones. Neisa is quick to notice it, too.\n\n");
			outputText("\"<i>Heya, [name] this right here looks to be my pay. You can thank up Marae that I brought a pair of pickaxes just in case, now lets get digging.</i>\"\n\n");
			outputText("The two of you proceed to carefully extract the precious gemstones from the wall as Nessa pockets her payment.\n\n");
			flags[kFLAGS.NEISA_AFFECTION] = 5;
			doNext(roomA03);
		}
		private function tresureRoom2A():void {
			clearOutput();
			outputText("As you tread within the dungeon, you run into what appears to be a pile of loot. Is it a trap? Perhaps more likely it's the hoard and gear of some adventurer before he was taken by demons... or worse. Having seen the horrors of Mareth firsthand, you know the risks of adventuring. Neisa is quick to acknowledge the loot as well.\n\n");
			outputText("\"<i>Aye, I guess one person's misfortune is our benefit. Help me put these into a bag. This should help cover for my pay.</i>\"\n\n");
			outputText("After a little corpse pilfering, the two of you continue treading.\n\n");
			flags[kFLAGS.NEISA_AFFECTION] = 10;
			doNext(roomA10);
		}
		private function teleportCircleFloor1():void {
			menu();
			addButtonDisabled(0, "Floor 1", "You're currently at Floor 1.");
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 1) addButton(1, "Floor 2", teleportToFloor2);
			else addButtonDisabled(1, "Floor 2", "You still need to beat guardians of floor 1 to use this teleport option.");
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 6) addButton(2, "Floor 3", teleportToFloor3);
			else addButtonDisabled(2, "Floor 3", "You still need to beat guardians of floor 2 to use this teleport option.");
			addButton(14, "Back", roomA01);
		}
		private function teleportCircleFloor2():void {
			menu();
			addButton(0, "Floor 1", teleportToFloor1);
			addButtonDisabled(1, "Floor 2", "You're currently at Floor 2.");
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 6) addButton(2, "Floor 3", teleportToFloor3);
			else addButtonDisabled(2, "Floor 3", "You still need to beat guardians of floor 2 to use this teleport option.");
			addButton(14, "Back", roomB01);
		}
		private function teleportCircleFloor3():void {
			menu();
			addButton(0, "Floor 1", teleportToFloor1);
			addButton(1, "Floor 2", teleportToFloor2);
			addButtonDisabled(2, "Floor 3", "You're currently at Floor 3.");
			addButton(14, "Back", roomC01);
		}
		private function teleportCircleFloor4():void {
			
		}
		private function teleportCircleFloor5():void {
			
		}
		private function teleportCircleFloor6():void {
			
		}
		private function teleportCircleFloor7():void {
			
		}
		private function teleportToFloor1():void {
			clearOutput();
			outputText("A circle of energy slowly emerges, wrapping around your team. Magic surges as your vision blurs. In nearly an instant, you're transported to the first room of first floor.\n\n");
			inDungeon = true;
			dungeonLoc = 68;
			playerMenu();
		}
		private function teleportToFloor2():void {
			clearOutput();
			outputText("A circle of energy slowly emerges, wrapping around your team. Magic surges as your vision blurs. In nearly an instant, you're transported to the first room of second floor.\n\n");
			inDungeon = true;
			dungeonLoc = 104;
			playerMenu();
		}
		private function teleportToFloor3():void {
			clearOutput();
			outputText("A circle of energy slowly emerges, wrapping around your team. Magic surges as your vision blurs. In nearly an instant, you're transported to the first room of third floor.\n\n");
			inDungeon = true;
			dungeonLoc = 135;
			playerMenu();
		}
	}
}