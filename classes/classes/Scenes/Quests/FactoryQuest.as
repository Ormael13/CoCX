package classes.Scenes.Quests {
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.AbstractQuest;
import classes.Scenes.QuestLib;
import classes.Scenes.SceneLib;

public class FactoryQuest extends AbstractQuest {
	public function FactoryQuest() {
		super("MQFactory", QuestLib.QGRP_MAIN, "Shut Down Everything");
	}
	
	override public function get description():String {
		return "";
	}
	public function get questStarted():Boolean {
		return flags[kFLAGS.MARAE_QUEST_START] >= 0.5;
	}
	public function get factoryFound():Boolean {
		return flags[kFLAGS.FACTORY_FOUND] > 0;
	}
	public function get bossDefeated():Boolean {
		return flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] > 0;
	}
	public function get factoryShutdownOrDestroyed():Boolean {
		return flags[kFLAGS.FACTORY_SHUTDOWN] > 0;
	}
	public function get factoryShutdown():Boolean {
		return flags[kFLAGS.FACTORY_SHUTDOWN] == 1
	}
	public function get factoryDestroyed():Boolean {
		return flags[kFLAGS.FACTORY_SHUTDOWN] == 2
	}
	public function get maraeReportedPure():Boolean {
		return flags[kFLAGS.MARAE_QUEST_COMPLETE] > 0
	}
	public function get maraeReportedCorrupt():Boolean {
		return flags[kFLAGS.MET_MARAE_CORRUPTED] > 0
	}
	public function get factoryCleared():Boolean {
		return SceneLib.dungeons.checkFactoryClear();
	}
	public function get perkRewardTaken():Boolean {
		return flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] == 2;
	}
	override public function objectives():Array {
		if (status != STATUS_IN_PROGRESS) return [];
		var obj1:Array  = [STATUS_IN_PROGRESS, "Find the factory at the hills."];
		var obj2:Array  = [STATUS_NOT_STARTED, "Defeat the factory boss."];
		var obj3:Array  = [STATUS_NOT_STARTED, "Clear the factory."];
		var obj4a:Array = [STATUS_UNKNOWN, "Option A: Shut down the factory."];
		var obj4b:Array = [STATUS_UNKNOWN, "Option B: Destroy the factory."];
		var obj6:Array  = [STATUS_NOT_STARTED, "Report to Marae."];
		var obj7:Array  = [STATUS_NOT_STARTED, "Take rewards from camp menu."];
		if (factoryFound) {
			obj1[0] = STATUS_COMPLETED;
			obj2[0] = STATUS_IN_PROGRESS;
			obj3[0] = STATUS_IN_PROGRESS;
			if (bossDefeated) {
				obj2[0]  = STATUS_COMPLETED;
				obj4a[0] = STATUS_IN_PROGRESS;
				obj4b[0] = STATUS_IN_PROGRESS;
				if (factoryShutdown) {
					obj4a[0] = STATUS_COMPLETED;
					obj4b[0] = STATUS_FAILED;
					obj6[0]  = STATUS_IN_PROGRESS;
					if (maraeReportedPure) {
						obj6[0] = STATUS_COMPLETED;
					}
				} else if (factoryDestroyed) {
					obj4a[0] = STATUS_FAILED;
					obj4b[0] = STATUS_COMPLETED;
					obj6[0]  = STATUS_IN_PROGRESS;
					if (maraeReportedCorrupt) {
						obj6[0] = STATUS_COMPLETED;
					}
				}
				if (factoryCleared) {
					obj3[0] = STATUS_COMPLETED;
					obj7[0] = STATUS_IN_PROGRESS;
					if (perkRewardTaken) {
						obj7[0] = STATUS_COMPLETED;
					}
				}
			}
		}
		return [
			obj1,
			obj2,
			obj4a,
			obj4b,
			obj6,
			obj3,
			obj7
		]
	}
	override public function get status():int {
		if (perkRewardTaken && (maraeReportedPure || maraeReportedCorrupt)) return STATUS_COMPLETED;
		if (questStarted) return STATUS_IN_PROGRESS;
		return STATUS_UNKNOWN;
	}
	override public function get hintToUnlock():String {
		if (flags[kFLAGS.MET_MARAE] > 0) return "Visit Marae. Don't be too corrupt, or be a corrupted race."
		return "Visit the lake island.";
	}
}
}
