package classes.Scenes.API {
import classes.BaseContent;
import classes.internals.EnumValue;

import flash.utils.Dictionary;

public class AbstractQuest extends BaseContent {
	public static const ALL_QUESTS_MAP:Dictionary = new Dictionary();
	public static const ALL_QUESTS_LIST:/*AbstractQuest*/Array = [];
	
	/**
	 * EnumValue properties:
	 * - id: var name ("COMPLETED")
	 * - value: code (3)
	 * - name: display name ("Completed")
	 * - color: text color, optional
	 */
	public static const AllStatuses:/*EnumValue*/Array = [];
	/**
	 * Player does not know about this quest
	 */
	public static const STATUS_UNKNOWN:int     = 0;
	EnumValue.add(AllStatuses, STATUS_UNKNOWN, "UNKNOWN", {
		name: "Unknown"
	});
	/**
	 * Player knows about this quest, but haven't started it
	 */
	public static const STATUS_NOT_STARTED:int = 1;
	EnumValue.add(AllStatuses, STATUS_NOT_STARTED, "NOT_STARTED", {
		name: "Not started"
	});
	/**
	 * Player started the quest, but not completed it yet.
	 * It can also mean that player completed the quest but didn't take the rewards yet.
	 */
	public static const STATUS_IN_PROGRESS:int = 2;
	EnumValue.add(AllStatuses, STATUS_IN_PROGRESS, "IN_PROGRESS", {
		name: "In progress",
		color: "#0080ff"
	});
	/**
	 * Player successfully completed the quests and took the rewards.
	 */
	public static const STATUS_COMPLETED:int = 3;
	EnumValue.add(AllStatuses, STATUS_COMPLETED, "COMPLETED", {
		name: "Completed",
		color: "#00a000"
	});
	/**
	 * Player failed the quest.
	 */
	public static const STATUS_FAILED:int  = 4;
	EnumValue.add(AllStatuses, STATUS_FAILED, "FAILED", {
		name: "Failed",
		color: "#a00000"
	});
	/**
	 * Return value to indicate invalid quest id
	 */
	public static const STATUS_INVALID:int = -1;
	EnumValue.add(AllStatuses, STATUS_INVALID, "INVALID", {
		name: "Invalid",
		color: "#ff0000"
	});
	
	private var _id:String;
	private var _group:String;
	private var _title:String;
	
	public function AbstractQuest(
			id:String,
			group:String,
			title:String
	) {
		this._id    = id;
		this._group = group;
		this._title = title;
		ALL_QUESTS_MAP[_id] = this;
		ALL_QUESTS_LIST.push(this);
	}
	
	public function get id():String { return _id }
	public function get title():String { return _title }
	public function get group():String { return _group }
	
	public function get description():String {
		// Implement in subclass (optional)
		return "";
	}
	/**
	 * Quest objectives, as viewed by player.
	 * Array of parts [status, test]
	 */
	public function objectives():Array {
		// Implement in subclass
		return [
				[STATUS_UNKNOWN, "ERROR: Quest '"+id+"' is missing objectives"]
		];
	}
	public function formattedObjectives(colored:Boolean):/*String*/Array {
		var result:/*String*/Array = [];
		for each (var obj:Array in objectives()) {
			var ev:EnumValue = AllStatuses[obj[0]];
			var s:String;
			if (obj[0] == STATUS_UNKNOWN) {
				s = "???";
			} else {
				s = obj[1];
			}
			if (colored && ev.color) s = '<font color="' + ev.color + '">' + s + '</font>';
			result.push(s);
		}
		return result;
	}
	
	/**
	 * STATUS_XXXX
	 */
	public function get status():int {
		// Implement in subclass
		return STATUS_UNKNOWN;
	}
	public function statusName(colored:Boolean):String {
		var obj:EnumValue = AllStatuses[status];
		var s:String = obj.name;
		if (colored && obj.color) s = '<font color="'+obj.color+'">'+s+'</font>';
		return s;
	}
	/**
	 * Player knows about the quest
	 */
	public function get isKnown():Boolean {
		return status > STATUS_UNKNOWN;
	}
	/**
	 * If quest is unknown, hint to reveal it. Can be empty
	 */
	public function get hintToUnlock():String {
		return "";
	}
	/**
	 * Quest was started but not completed
	 */
	public function get isStarted():Boolean {
		return status == STATUS_IN_PROGRESS;
	}
	/**
	 * Quest was finished (successfully or not)
	 */
	public function get isEnded():Boolean {
		return status == STATUS_COMPLETED || status == STATUS_FAILED;
	}
	public function get isCompleted():Boolean {
		return status == STATUS_COMPLETED;
	}
	public function get isFailed():Boolean {
		return status == STATUS_FAILED;
	}
}
}
