package classes.Scenes.Quests {
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.AbstractQuest;
import classes.Scenes.QuestLib;
import classes.Scenes.SceneLib;

public class ZetazQuest extends AbstractQuest {
	public function ZetazQuest() {
		super("MQZetaz", QuestLib.QGRP_MAIN, "You're in Deep");
	}
	
	public function get canStart():Boolean {
		return SceneLib.dungeons.canFindDeepCave();
	}
	public function get dungeonFound():Boolean {
		return flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0;
	}
	public function get bossDefeated():Boolean {
		return flags[kFLAGS.DEFEATED_ZETAZ] > 0;
	}
	public function get dungeonCleared():Boolean {
		return SceneLib.dungeons.checkDeepCaveClear();
	}
	public function get perkRewardTaken():Boolean {
		return flags[kFLAGS.DEFEATED_ZETAZ] > 1;
	}
	override public function get description():String {
		return "";
	}
	
	override public function objectives():Array {
		if (status == STATUS_NOT_STARTED) return [
			[STATUS_NOT_STARTED, "Search the Deepwoods."]
		];
		if (status != STATUS_IN_PROGRESS) return [];
		var obj1:Array = [STATUS_IN_PROGRESS, "Search the Deepwoods."];
		var obj2:Array = [STATUS_NOT_STARTED, "Defeat Zetaz."];
		var obj3:Array = [STATUS_NOT_STARTED, "Clear the Deep Cave."];
		var obj4:Array = [STATUS_NOT_STARTED, "Take rewards from camp menu."];
		if (dungeonFound) {
			obj1[0] = STATUS_COMPLETED;
			obj2[0] = STATUS_IN_PROGRESS;
			obj3[0] = STATUS_IN_PROGRESS;
			if (bossDefeated) {
				obj2[0] = STATUS_COMPLETED;
				if (dungeonCleared) {
					obj3[0] = STATUS_COMPLETED;
					obj4[0] = STATUS_IN_PROGRESS;
					if (perkRewardTaken) {
						obj4[0] = STATUS_COMPLETED;
					}
				}
			}
		}
		return [
				obj1,
				obj2,
				obj3
		]
	}
	
	override public function get status():int {
		if (perkRewardTaken) return STATUS_COMPLETED;
		if (dungeonFound) return STATUS_IN_PROGRESS;
		if (canStart) return STATUS_NOT_STARTED;
		return STATUS_UNKNOWN;
	}
	
	override public function get hintToUnlock():String {
		return "Complete previous quest";
	}
}
}
