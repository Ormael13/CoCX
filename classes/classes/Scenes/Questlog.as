/**
 * ...
 * @author Ormael
 */
package classes.Scenes 
{
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;

public class Questlog extends BaseContent
	{
		
		public function Questlog() 
		{}
		
		public function accessQuestlogMainMenu():void {
			clearOutput();
			outputText("List of all not-started, not yet complited and completed quests. After finishing each of them PC could pick reward but... <i>You only need to click once fool</i>\n");
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
			else if (flags[kFLAGS.D3_DISCOVERED] > 0) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Friend of the Sand Witches:</b> ");
			if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] == 2) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkSandCaveClear()) outputText("Completed");
			else if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Fall of the Phoenix:</b> ");
			if (flags[kFLAGS.CLEARED_HEL_TOWER] == 2) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkPhoenixTowerClear()) outputText("Completed");
			else outputText("Not Started");
			outputText("\n<b>Tiger stalking the Dragon:</b> ");
			if (flags[kFLAGS.HIDDEN_CAVE_BOSSES] == 3) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkHiddenCaveClear()) outputText("Completed");
			else if (flags[kFLAGS.HIDDEN_CAVE_FOUND] > 0) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Slain the Heroslayer:</b> ");
			if (flags[kFLAGS.DEN_OF_DESIRE_QUEST] == 2) outputText("Completed (Reward taken)");
			else if (SceneLib.dungeons.checkDenOfDesireClear()) outputText("Completed");
			else if (flags[kFLAGS.DEN_OF_DESIRE_QUEST] > 1) outputText("In Progress");
			else outputText("Not Started");
			menu();
			if (SceneLib.dungeons.checkFactoryClear() && flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] < 2) addButton(0, "Factory", takeRewardForFactory);
			if (SceneLib.dungeons.checkDeepCaveClear() && flags[kFLAGS.DEFEATED_ZETAZ] < 2) addButton(1, "Deep Cave", takeRewardForDeepCave);
			if (SceneLib.dungeons.checkLethiceStrongholdClear() && flags[kFLAGS.LETHICE_DEFEATED] < 2) addButton(2, "Stronghold", takeRewardForStronghold);
			if (SceneLib.dungeons.checkSandCaveClear() && flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] < 2) addButton(5, "Sand Cave", takeRewardForSandCave);
			if (SceneLib.dungeons.checkPhoenixTowerClear() && flags[kFLAGS.CLEARED_HEL_TOWER] < 2) addButton(6, "Phoenix Tower", takeRewardForPhoenixTower);
			if (SceneLib.dungeons.checkHiddenCaveClear() && flags[kFLAGS.HIDDEN_CAVE_BOSSES] < 3) addButton(10, "Hidden Cave", takeRewardForHiddenCave);
			// (SceneLib.dungeons.checkDenOfDesireClear() && flags[kFLAGS.DEN_OF_DESIRE_QUEST] < 2) addButton(11, "Den of Desire", takeRewardForDenOfDesire);
			//button 13 - Lia undersea chtulu dungeon
			addButton(14, "Back", playerMenu);
		}
		
		public function takeRewardForFactory():void {
			clearOutput();
			outputText("Your contribution in changing Mareth have been noticed.\n\n");
			outputText("<b>Gained 2 perk points and 10 stat points</b>");
			player.perkPoints = player.perkPoints + 2;
			player.statPoints = player.statPoints + 10;
			statScreenRefresh();
			flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] = 2;
			doNext(accessQuestlogMainMenu);
		}
		public function takeRewardForDeepCave():void {
			clearOutput();
			outputText("Your contribution in changing Mareth have been noticed.\n\n");
			outputText("<b>Gained 4 perk points and 20 stat points</b>");
			player.perkPoints = player.perkPoints + 4;
			player.statPoints = player.statPoints + 20;
			statScreenRefresh();
			flags[kFLAGS.DEFEATED_ZETAZ] = 2;
			doNext(accessQuestlogMainMenu);
		}
		public function takeRewardForStronghold():void {
			clearOutput();
			outputText("Your contribution in changing Mareth have been noticed.\n\n");
			outputText("<b>Gained 6 perk points and 30 stat points</b>");
			player.perkPoints = player.perkPoints + 6;
			player.statPoints = player.statPoints + 30;
			statScreenRefresh();
			flags[kFLAGS.LETHICE_DEFEATED] = 2;
			doNext(accessQuestlogMainMenu);
		}
		public function takeRewardForSandCave():void {
			clearOutput();
			outputText("Your contribution in changing Mareth have been noticed.\n\n");
			outputText("<b>Gained 1 perk points and 5 stat points</b>");
			player.perkPoints = player.perkPoints + 1;
			player.statPoints = player.statPoints + 5;
			statScreenRefresh();
			flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] = 2;
			doNext(accessQuestlogMainMenu);
		}
		public function takeRewardForPhoenixTower():void {
			clearOutput();
			outputText("Your contribution in changing Mareth have been noticed.\n\n");
			outputText("<b>Gained 2 perk points and 10 stat points</b>");
			player.perkPoints = player.perkPoints + 2;
			player.statPoints = player.statPoints + 10;
			statScreenRefresh();
			flags[kFLAGS.CLEARED_HEL_TOWER] = 2;
			doNext(accessQuestlogMainMenu);
		}
		public function takeRewardForHiddenCave():void {
			clearOutput();
			outputText("Your contribution in changing Mareth have been noticed.\n\n");
			outputText("<b>Gained 1 perk points and 5 stat points</b>");
			player.perkPoints = player.perkPoints + 1;
			player.statPoints = player.statPoints + 5;
			statScreenRefresh();
			flags[kFLAGS.HIDDEN_CAVE_BOSSES] = 3;
			doNext(accessQuestlogMainMenu);
		}
		public function takeRewardForDenOfDesire():void {
			clearOutput();
			outputText("Your contribution in changing Mareth have been noticed.\n\n");
			outputText("<b>Gained 2 perk points and 10 stat points</b>");
			player.perkPoints = player.perkPoints + 2;
			player.statPoints = player.statPoints + 10;
			statScreenRefresh();
			flags[kFLAGS.DEN_OF_DESIRE_QUEST] = 2;
			doNext(accessQuestlogMainMenu);
		}
	}
}