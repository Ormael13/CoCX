/**
 * ...
 * @author Ormael
 */
package classes.Scenes 
{
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.StatusEffects;

public class Questlog extends BaseContent
	{
		
		public function Questlog() 
		{}
		
		public function accessQuestlogMainMenu():void {
			clearOutput();
			outputText("List of all not-started, not yet completed and completed quests. After finishing each of them PC could pick reward but... <i>You only need to click once fool</i>\n");
			outputText("\n<u><b>Main Quests</b></u>");
			outputText("\n<b>Shut Down Everything:</b> ");
			if (flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] == 2) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkFactoryClear()) outputText("Completed");
			else if (flags[kFLAGS.FACTORY_FOUND] > 0) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>You're in Deep:</b> ");
			if (flags[kFLAGS.DEFEATED_ZETAZ] > 1) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkDeepCaveClear()) outputText("Completed");
			else if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>End of Reign:</b> ");
			if (flags[kFLAGS.LETHICE_DEFEATED] > 1) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkLethiceStrongholdClear()) outputText("Completed");
			else if (flags[kFLAGS.D3_DISCOVERED] > 0) outputText("In Progress (to complete this quest PC must beat either Basilisk Boss or Mirror Demon)");
			else outputText("Not Started");
			outputText("\n\n<u><b>Side Quests</b></u>");
			outputText("\n<b>Friend of the Sand Witches:</b> ");
			if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] == 2) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkSandCaveClear()) outputText("Completed");
			else if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Fall of the Phoenix:</b> ");
			if (flags[kFLAGS.CLEARED_HEL_TOWER] == 2) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkPhoenixTowerClear()) outputText("Completed");
			else outputText("Not Started");
			outputText("\n<b>Victory, Sweet like honey:</b> ");
			if (flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] == 3) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkBeeHiveClear()) outputText("Completed");
			else if (flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] > 0 && flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] < 3) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Tiger stalking the Dragon:</b> ");
			if (flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] == 6) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkHiddenCaveClear()) outputText("Completed");
			else if (flags[kFLAGS.HIDDEN_CAVE_FOUND] > 0) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Tiger stalking the Dragon (Bonus Stage):</b> ");
			if (flags[kFLAGS.HIDDEN_CAVE_BOSSES] == 3) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkHiddenCaveHiddenStageClear()) outputText("Completed");
			else if (flags[kFLAGS.HIDDEN_CAVE_BOSSES] >= 1) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Slain the Heroslayer:</b> ");
			if (flags[kFLAGS.DEN_OF_DESIRE_QUEST] == 2) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkDenOfDesireClear()) outputText("Completed");
			else if (flags[kFLAGS.DEN_OF_DESIRE_BOSSES] > 1) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n\n<u><b>River Dungeon Exploration</b></u>");
			outputText("\n<b>1st Floor:</b> ");
			if (SceneLib.dungeons.checkRiverDungeon1stFloorClear()) {
				if (player.hasStatusEffect(StatusEffects.RiverDungeonFloorRewards)) outputText("Completed (Reward taken)");
				else outputText("Completed");
			}
			else outputText("Not Started/In Progress");
			outputText("\n<b>2nd Floor:</b> ");
			if (SceneLib.dungeons.checkRiverDungeon2ndFloorClear()) {
				if (player.statusEffectv1(StatusEffects.RiverDungeonFloorRewards) > 1) outputText("Completed (Reward taken)");
				else outputText("Completed");
			}
			else outputText("Not Started/In Progress");
			outputText("\n<b>3rd Floor:</b> ");
			if (SceneLib.dungeons.checkRiverDungeon3rdFloorClear()) {
				if (player.statusEffectv1(StatusEffects.RiverDungeonFloorRewards) > 2) outputText("Completed (Reward taken)");
				else outputText("Completed");
			}
			else outputText("Not Started/In Progress");
			outputText("\n<i><b>4th Floor:</b> Soon</i>");
			outputText("\n\n<u><b>Adventure Guild Quests</b></u>");
			outputText("\n<b>Imps Hunt:</b> ");
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 2 || player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 4 || player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 7) outputText("Completed (for today)");
			else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 1 || player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 3 || player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 6) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Demons Hunt:</b> ");
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 2 || player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 4 || player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 7) outputText("Completed (for today)");
			else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 1 || player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 3 || player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 6) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Minotaurs Hunt:</b> ");
			if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 2 || player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 4 || player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 7) outputText("Completed (for today)");
			else if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 1 || player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 3 || player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 6) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Feral Imps Hunt:</b> ");
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 2 || player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 4 || player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 7) outputText("Completed (for today)");
			else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 1 || player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 3 || player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 6) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Feral Tentacle Beasts Hunt:</b> ");
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 2 || player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 4 || player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 7) outputText("Completed (for today)");
			else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 1 || player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 3 || player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 6) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<i><b>Feral Demons Hunt:</b> Soon</i>");
			outputText("\n<b>Green Gel Gathering:</b> ");
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) == 2 || player.statusEffectv2(StatusEffects.AdventureGuildQuests4) == 5) outputText("Completed (for today)");
			else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) == 1 || player.statusEffectv2(StatusEffects.AdventureGuildQuests4) == 4) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Black Chitin Gathering:</b> ");
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) == 2 || player.statusEffectv1(StatusEffects.AdventureGuildQuests4) == 5) outputText("Completed (for today)");
			else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) == 1 || player.statusEffectv1(StatusEffects.AdventureGuildQuests4) == 4) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<i><b>Spider-silk Gathering:</b> Very Soon</i>");
			//outputText("\n<i><b>Dragonscale Gathering:</b> Soon</i>");
			outputText("\n<i><b>Ebonbloom Gathering:</b> Soon</i>");
			//outputText("\n<i><b>World Tree Branch Gathering:</b> Soon</i>");
			outputText("\n\n<u><b>Twilight of the Gods</b></u>");
			outputText("\n<b>Feral Imps Capture:</b> ");
			if (flags[kFLAGS.GALIA_LVL_UP] >= 0.5) outputText("Completed");
			else if (flags[kFLAGS.GALIA_LVL_UP] >= 0.05 && flags[kFLAGS.GALIA_LVL_UP] < 0.5) outputText("In Progress (" + Math.round(flags[kFLAGS.GALIA_LVL_UP] * 20) + " / 10)");
			else if (flags[kFLAGS.GALIA_LVL_UP] >= 0.01 && flags[kFLAGS.GALIA_LVL_UP] < 0.05) outputText("In Progress (0 / 10)");
			else outputText("Not Started");
			outputText("\n<i><b>Feral Tentacle Beasts Capture:</b> Very Soon</i>");
			/*if () outputText("\n\n<u><b>The New Dawn</b></u>");
			else outputText("\n<b>???</b>");*/
			menu();
			if (SceneLib.dungeons.checkFactoryClear() && flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] < 2) addButton(0, "Factory", takeRewardForFactory);
			if (SceneLib.dungeons.checkDeepCaveClear() && flags[kFLAGS.DEFEATED_ZETAZ] < 2) addButton(1, "Deep Cave", takeRewardForDeepCave);
			if (SceneLib.dungeons.checkLethiceStrongholdClear() && flags[kFLAGS.LETHICE_DEFEATED] < 2) addButton(2, "Stronghold", takeRewardForStronghold);
			//button 3 - ?Demon Mine? czy też przesunąc Lethice Stronghold niżej z 2 przycisku jak dodam lochy w main storyline przed D3?
			//button 4 - ?Demon Secret Lab?
			if (SceneLib.dungeons.checkSandCaveClear() && flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] < 2) addButton(5, "Sand Cave", takeRewardForSandCave);
			if (SceneLib.dungeons.checkPhoenixTowerClear() && flags[kFLAGS.CLEARED_HEL_TOWER] < 2) addButton(6, "Phoenix Tower", takeRewardForPhoenixTower);
			if (SceneLib.dungeons.checkBeeHiveClear() && flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] < 3) addButton(7, "Bee Hive", takeRewardForBeeHive);
			if (SceneLib.dungeons.checkRiverDungeon1stFloorClear() && !player.hasStatusEffect(StatusEffects.RiverDungeonFloorRewards)) addButton(8, "River Dungeon", takeRewardForRiverDungeon1stFloor).hint("1st floor reward");
			if (player.hasStatusEffect(StatusEffects.RiverDungeonFloorRewards)) {
				if (SceneLib.dungeons.checkRiverDungeon3rdFloorClear() && player.statusEffectv1(StatusEffects.RiverDungeonFloorRewards) == 2) addButton(8, "River Dungeon", takeRewardForRiverDungeon3rdFloor).hint("3rd floor reward");
				if (SceneLib.dungeons.checkRiverDungeon2ndFloorClear() && player.statusEffectv1(StatusEffects.RiverDungeonFloorRewards) == 1) addButton(8, "River Dungeon", takeRewardForRiverDungeon2ndFloor).hint("2nd floor reward");
			}
			//3rd floor
			//4th floor
            if (flags[kFLAGS.EBON_LABYRINTH])
                addButtonIfTrue(9, "Ebon Labyrinth", takeRewardForEL,
                    "Req. to reach room " + SceneLib.dungeons.nextAwardEL() + ".",
                    SceneLib.dungeons.checkEbonLabyrinthNotAwarded());
            else addButtonDisabled(9, "EL", "Not discovered yet.");
            if (SceneLib.dungeons.checkHiddenCaveClear() && flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] < 6) addButton(10, "Hidden Cave", takeRewardForHiddenCave);
			if (SceneLib.dungeons.checkHiddenCaveHiddenStageClear() && flags[kFLAGS.HIDDEN_CAVE_BOSSES] < 3) addButton(10, "Hidden C.(HS)", takeRewardForHiddenCaveHiddenStage).hint("Hidden Cave (Hidden Stage bonus)");
			if (SceneLib.dungeons.checkDenOfDesireClear() && flags[kFLAGS.DEN_OF_DESIRE_QUEST] < 2) addButton(11, "Den of Desire", takeRewardForDenOfDesire);
			//button 12 - ???
			//button 13 - Lia undersea chtulu dungeon
			addButton(14, "Back", playerMenu);
		}

        public function reward(perkPoints:int = 0, statPoints:int = 0):void {
			clearOutput();
			outputText("Your contribution in changing Mareth have been noticed.\n\n");
			outputText("<b>Gained");
            if (perkPoints > 0) outputText(" " + perkPoints + "perk point" + (perkPoints > 1 ? "s" : ""));
            if (perkPoints > 0 && statPoints > 0) outputText(" and");
            if (statPoints > 0) outputText(" " + statPoints + "stat point" + (statPoints > 1 ? "s" : ""));
            outputText((perkPoints == 0 && statPoints == 0) ? " nothing.</b>" : ".</b>");
            player.perkPoints += perkPoints;
            player.statPoints += statPoints;
			statScreenRefresh();
			doNext(accessQuestlogMainMenu);
        }
        //FUCK, STOP COPYING THE SAME CODE OVER AND OVER

		public function takeRewardForFactory():void {
			flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] = 2;
            reward(2, 10);
		}
		public function takeRewardForDeepCave():void {
			clearOutput();
			flags[kFLAGS.DEFEATED_ZETAZ] = 2;
            reward(4, 20);
		}
		public function takeRewardForStronghold():void {
			flags[kFLAGS.LETHICE_DEFEATED] = 2;
            reward(6, 30);
		}
		public function takeRewardForSandCave():void {
			flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] = 2;
            reward(1, 5);
		}
		public function takeRewardForPhoenixTower():void {
			flags[kFLAGS.CLEARED_HEL_TOWER] = 2;
            reward(2, 10);
		}
		public function takeRewardForBeeHive():void {
			flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] = 3;
            reward(2, 10);
		}
		public function takeRewardForRiverDungeon1stFloor():void {
			player.createStatusEffect(StatusEffects.RiverDungeonFloorRewards,1,0,0,0);
            reward(1, 5);
			doNext(accessQuestlogMainMenu);
		}
		public function takeRewardForRiverDungeon2ndFloor():void {
			player.addStatusValue(StatusEffects.RiverDungeonFloorRewards,1,1);
            reward(1, 5);
		}
		public function takeRewardForRiverDungeon3rdFloor():void {
			player.addStatusValue(StatusEffects.RiverDungeonFloorRewards,1,1);
            reward(1, 5);
		}
		public function takeRewardForEL():void {
			flags[kFLAGS.EBON_LABYRINTH] = SceneLib.dungeons.nextAwardEL();
            reward(1, 5);
			doNext(accessQuestlogMainMenu);
		}
		public function takeRewardForHiddenCave():void {
			flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 6;
            reward(1, 5);
		}
		public function takeRewardForHiddenCaveHiddenStage():void {
			flags[kFLAGS.HIDDEN_CAVE_BOSSES] = 3;
            reward(1, 5);
		}
		public function takeRewardForDenOfDesire():void {
			flags[kFLAGS.DEN_OF_DESIRE_QUEST] = 2;
            reward(3, 15);
		}
	}
}