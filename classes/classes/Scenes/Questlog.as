/**
 * ...
 * @author Ormael
 */
package classes.Scenes
{
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.AbstractQuest;
import classes.StatusEffects;

public class Questlog extends BaseContent
	{
		
		public function Questlog()
		{}
		
		public function printQuest(quest:AbstractQuest):void {
			if (!quest.isKnown) {
				var hint:String = quest.hintToUnlock;
				outputText("<b>???</b>");
				if (hint) outputText(" <i>("+hint+")</i>");
				outputText("\n");
			} else {
				outputText("<b>"+quest.title+" ("+quest.statusName(true)+")</b>: ");
				outputText(quest.description);
				if (quest.objectives().length > 0) {
					outputText("<ul><li>" +
							quest.formattedObjectives(true).join("</li><li>") +
							"</li></ul>"
					);
				} else {
					outputText("\n");
				}
			}
		}
		public function printQuestGroup(group:String):void {
			for each(var quest:AbstractQuest in questLib.allQuests(group)) {
				printQuest(quest);
			}
		}
		
		public function accessQuestlogMainMenu():void {
			clearOutput();
			outputText("List of all not-started, not yet completed and completed quests. After finishing each of them PC could pick reward but... <i>You only need to click once fool</i>");
			
			outputText("\n\n<u><b>Main Quests</b></u>\n");
			printQuestGroup(QuestLib.QGRP_MAIN);
			outputText("<b>Chimera Squad:</b> ");
			if (flags[kFLAGS.DEMON_LABORATORY_DISCOVERED] > 1) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkDemonLaboratoryClear()) outputText("Completed");
			else if (flags[kFLAGS.DEMON_LABORATORY_DISCOVERED] == 1) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>End of Reign:</b> ");
			if (flags[kFLAGS.LETHICE_DEFEATED] > 1) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkLethiceStrongholdClear()) outputText("Completed");
			else if (flags[kFLAGS.D3_DISCOVERED] > 0) outputText("In Progress (to complete this quest PC must beat either Basilisk Boss or Mirror Demon)");
			else outputText("Not Started");
			
			outputText("\n\n<u><b>Side Quests</b></u>\n");
			printQuestGroup(QuestLib.QGRP_SIDE);
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
			outputText("\n<b>4th Floor:</b> ");
			if (SceneLib.dungeons.checkRiverDungeon4thFloorClear()) {
				if (player.statusEffectv1(StatusEffects.RiverDungeonFloorRewards) > 3) outputText("Completed (Reward taken)");
				else outputText("Completed");
			}
			else outputText("Not Started/In Progress");
			outputText("\n<i><b>5th Floor:</b> Soon</i>");

			outputText("\n\n<u><b>Adventure Guild Quests</b></u>\n");
			printQuestGroup(QuestLib.QGRP_AGUILD);
			outputText("<i><b>Feral Demons Hunt:</b> Soon</i>\n");
			outputText("<i><b>Spider-silk Gathering:</b> Very Soon</i>\n");
			//outputText("<i><b>Dragonscale Gathering:</b> Soon</i>\n");
			outputText("<i><b>Ebonbloom Gathering:</b> Soon</i>\n");
			//outputText("<i><b>World Tree Branch Gathering:</b> Soon</i>\n");
			
			outputText("\n\n<u><b>Twilight of the Gods</b></u>");
			outputText("\n<b>Feral Imps Capture:</b> ");
			if (flags[kFLAGS.GALIA_LVL_UP] >= 0.5) outputText("Completed");
			else if (flags[kFLAGS.GALIA_LVL_UP] >= 0.05 && flags[kFLAGS.GALIA_LVL_UP] < 0.5) outputText("In Progress (" + Math.round(flags[kFLAGS.GALIA_LVL_UP] * 20) + " / 10)");
			else if (flags[kFLAGS.GALIA_LVL_UP] >= 0.01 && flags[kFLAGS.GALIA_LVL_UP] < 0.05) outputText("In Progress (0 / 10)");
			else outputText("Not Started");
			outputText("\n<i><b>Feral Tentacle Beasts Capture:</b> Very Soon</i>");
			/*if () outputText("\n\n<u><b>The New Dawn</b></u>");
			else outputText("\n<b>???</b>");*/
			
			outputText("\n\n<u><b>Other Quests</b></u>\n");
			printQuestGroup(QuestLib.QGRP_OTHER);
			
			menu();
			if (questLib.MQ_Factory.factoryCleared && !questLib.MQ_Factory.perkRewardTaken) addButton(0, "Factory", takeRewardForFactory);
			if (questLib.MQ_Zetaz.dungeonCleared && !questLib.MQ_Zetaz.perkRewardTaken) addButton(1, "Deep Cave", takeRewardForDeepCave);
			if (SceneLib.dungeons.checkDemonLaboratoryClear() && flags[kFLAGS.DEMON_LABORATORY_DISCOVERED] < 2) addButton(2, "Demon Laboratory", takeRewardForDemonLaboratory);
			//button 4 - ?Demon Mine?
			if (SceneLib.dungeons.checkLethiceStrongholdClear() && flags[kFLAGS.LETHICE_DEFEATED] < 2) addButton(3, "Stronghold", takeRewardForStronghold);
			if (SceneLib.dungeons.checkSandCaveClear() && flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] < 2) addButton(5, "Sand Cave", takeRewardForSandCave);
			if (SceneLib.dungeons.checkPhoenixTowerClear() && flags[kFLAGS.CLEARED_HEL_TOWER] < 2) addButton(6, "Phoenix Tower", takeRewardForPhoenixTower);
			if (SceneLib.dungeons.checkBeeHiveClear() && flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] < 3) addButton(7, "Bee Hive", takeRewardForBeeHive);
			if (SceneLib.dungeons.checkRiverDungeon1stFloorClear() && !player.hasStatusEffect(StatusEffects.RiverDungeonFloorRewards)) addButton(8, "River Dungeon", takeRewardForRiverDungeon1stFloor).hint("1st floor reward");
			if (player.hasStatusEffect(StatusEffects.RiverDungeonFloorRewards)) {
				if (SceneLib.dungeons.checkRiverDungeon4thFloorClear() && player.statusEffectv1(StatusEffects.RiverDungeonFloorRewards) == 3) addButton(8, "River Dungeon", takeRewardForRiverDungeon4thFloor).hint("4th floor reward");
				if (SceneLib.dungeons.checkRiverDungeon3rdFloorClear() && player.statusEffectv1(StatusEffects.RiverDungeonFloorRewards) == 2) addButton(8, "River Dungeon", takeRewardForRiverDungeon3rdFloor).hint("3rd floor reward");
				if (SceneLib.dungeons.checkRiverDungeon2ndFloorClear() && player.statusEffectv1(StatusEffects.RiverDungeonFloorRewards) == 1) addButton(8, "River Dungeon", takeRewardForRiverDungeon2ndFloor).hint("2nd floor reward");
			}
			//5th floor
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

        public function reward(perkPoints:int = 0, statPoints:int = 0, bonusReward:Boolean = false):void {
			clearOutput();
			outputText("Your contribution in changing Mareth have been noticed.\n\n");
			outputText("<b>Gained");
            if (perkPoints > 0) outputText(" " + perkPoints + " perk point" + (perkPoints > 1 ? "s" : ""));
            if (perkPoints > 0 && statPoints > 0) outputText(" and");
            if (statPoints > 0) outputText(" " + statPoints + " stat point" + (statPoints > 1 ? "s" : ""));
            outputText((perkPoints == 0 && statPoints == 0) ? " nothing.</b>" : ".</b>");
			if (bonusReward) {
				outputText("\n\n<b>Additional reward for progressing main storyline - 1 super perk point</b>");
				player.superPerkPoints++;
			}
            player.perkPoints += perkPoints;
            player.statPoints += statPoints;
			statScreenRefresh();
			doNext(accessQuestlogMainMenu);
        }
        //FUCK, STOP COPYING THE SAME CODE OVER AND OVER

		public function takeRewardForFactory():void {
			flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] = 2;
            reward(2, 10, true);
		}
		public function takeRewardForDeepCave():void {
			clearOutput();
			flags[kFLAGS.DEFEATED_ZETAZ] = 2;
            reward(4, 20, true);
		}
		public function takeRewardForDemonLaboratory():void {
			clearOutput();
			flags[kFLAGS.DEMON_LABORATORY_DISCOVERED] = 2;
            reward(6, 30, true);
		}
		public function takeRewardForStronghold():void {
			flags[kFLAGS.LETHICE_DEFEATED] = 2;
            reward(8, 40, true);
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
		public function takeRewardForRiverDungeon4thFloor():void {
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
