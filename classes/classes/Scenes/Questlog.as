/**
 * ...
 * @author Ormael
 */
package classes.Scenes 
{
	import classes.*
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class Questlog extends BaseContent
	{
		
		public function Questlog() 
		{}
		
		public function accessQuestlogMainMenu():void {
			clearOutput();
			outputText("List of all not-started, not yet complited and completed quests. After finishing each of them PC could pick reward but... <i>You only need to click once fool</i>\n");
			outputText("\n<b>Shut Down Everything:</b> ");
		/*	if () outputText("Completed (Reward taken)");
			else */if (kGAMECLASS.dungeons.checkFactoryClear()) outputText("Completed");
			else if (flags[kFLAGS.FACTORY_FOUND] > 0) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>You're in Deep:</b> ");
		/*	if () outputText("Completed (Reward taken)");
			else */if (kGAMECLASS.dungeons.checkDeepCaveClear()) outputText("Completed");
			else if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>End of Reign:</b> ");
		/*	if () outputText("Completed (Reward taken)");
			else */if (kGAMECLASS.dungeons.checkLethiceStrongholdClear()) outputText("Completed");
			else if (flags[kFLAGS.D3_DISCOVERED] > 0) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Friend of the Sand Witches:</b> ");
		/*	if () outputText("Completed (Reward taken)");
			else */if (kGAMECLASS.dungeons.checkSandCaveClear()) outputText("Completed");
			else if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0) outputText("In Progress");
			else outputText("Not Started");
			outputText("\n<b>Fall of the Phoenix:</b> ");
		/*	if () outputText("Completed (Reward taken)");
			else */if (kGAMECLASS.dungeons.checkPhoenixTowerClear()) outputText("Completed");
			else outputText("Not Started");
			outputText("\n<b>Tiger stalking the Dragon:</b> ");
		/*	if () outputText("Completed (Reward taken)");
			else */if (kGAMECLASS.dungeons.checkHiddenCaveClear()) outputText("Completed");
			else if (flags[kFLAGS.HIDDEN_CAVE_FOUND] > 0) outputText("In Progress");
			else outputText("Not Started");
			menu();
			addButton(14, "Back", playerMenu);
		}
		
	}

}