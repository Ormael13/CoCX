package classes.Scenes.Quests {
import classes.ItemType;
import classes.Scenes.API.AbstractQuest;
import classes.Scenes.Places.HeXinDao.AdventurerGuild;
import classes.Scenes.QuestLib;
import classes.StatusEffectType;

/**
 * Adventure guild delivery quest
 */
public class SimpleGuildQuest extends AbstractQuest {
	// Status effect codes
	private static const SE_T1_NOT_STARTED:int = 0;
	private static const SE_T1_STARTED:int     = 1;
	private static const SE_T1_COMPLETED:int   = 2;
	private static const SE_T2_STARTED:int     = 3;
	private static const SE_T2_COMPLETED:int   = 4;
	private static const SE_T3_STARTED:int     = 6;
	private static const SE_T3_COMPLETED:int   = 7;
	
	private var _guildLevel:int;
	private var _item:ItemType;
	private var _numbers:/*int*/Array;
	private var _setype:StatusEffectType;
	private var _valueIndex:int;
	
	public function SimpleGuildQuest(
			id:String,
			title:String,
			/** 1: copper, 2: iron, ... */
			guildLevel:int,
			item:ItemType,
			/** [ t1number, t2number, t3number ] */
			numberByTier:/*int*/Array,
			statusEffectType:StatusEffectType,
			valueIndex:int
	) {
		super(id, QuestLib.QGRP_AGUILD, title);
		this._guildLevel = guildLevel;
		this._item       = item;
		this._numbers    = numberByTier;
		this._setype     = statusEffectType;
		this._valueIndex = valueIndex;
	}
	
	protected function get statusValue():Number {
		return player.getStatusValue(_setype, _valueIndex);
	}
	
	override public function get description():String {
		var s:String = "Bring " + item.longName + " x " + quantity+". "
		if (status == STATUS_COMPLETED) s += "You can repeat this quest tomorrow. "
		return s;
	}
	
	override public function get hintToUnlock():String {
		var playerGuildLevel:int = AdventurerGuild.playerGuildLevel;
		if (playerGuildLevel == 0)
			return "Join the Adventurers Guild"
		if (playerGuildLevel < guildLevel)
			return "Reach  Adventurers Guild "+AdventurerGuild.GuildRanks[guildLevel].name+"rank";
		return "Visit Yang";
	}
	override public function objectives():Array {
		var status:int = this.status;
//		if (status == STATUS_NOT_STARTED)
//			return [[STATUS_IN_PROGRESS, "Visit Yang"]];
		if (status != STATUS_IN_PROGRESS) return [];
		var pcount:int = player.itemCount(item, true);
		var need:int = quantity;
		var obj1:String = item.shortName + " " + pcount + "/" + need;
		var obj2:String = "Return to Yang";
		if (pcount < need) {
			return [
				[STATUS_IN_PROGRESS, obj1],
				[STATUS_NOT_STARTED, obj2]
			]
		} else {
			return [
				[STATUS_COMPLETED, obj1],
				[STATUS_IN_PROGRESS, obj2]
			]
		}
	}
	
	public function get guildLevel():int { return _guildLevel }
	public function get item():ItemType { return _item }
	public function get quantity():int { return tierQuantity(tier) }
	public function get tier():int {
		var value:Number = statusValue;
		if (value == SE_T1_NOT_STARTED || value == SE_T1_STARTED || value == SE_T1_COMPLETED) return 1;
		if (value == SE_T2_STARTED || value == SE_T2_COMPLETED) return 2;
		if (value == SE_T3_STARTED || value == SE_T3_COMPLETED) return 3;
		return 0;
	}
	public function tierQuantity(tier:int):int {
		if (tier <= 0 || tier > 3) return -1;
		return _numbers[tier - 1];
	}
	override public function get status():int {
		if (AdventurerGuild.playerGuildLevel < guildLevel) return STATUS_UNKNOWN;
		if (!player.hasStatusEffect(_setype)) return STATUS_UNKNOWN;
		var value:Number = statusValue;
		if (value == SE_T1_NOT_STARTED) return STATUS_NOT_STARTED;
		if (value == SE_T1_STARTED || value == SE_T2_STARTED || value == SE_T3_STARTED) return STATUS_IN_PROGRESS;
		// Because you can start next quest tier right away, completed II = not started III
		if (value == SE_T1_COMPLETED || value == SE_T2_COMPLETED && _numbers.length > 2) return STATUS_NOT_STARTED;
		if (value == SE_T3_COMPLETED || value == SE_T2_COMPLETED && _numbers.length == 2) return STATUS_COMPLETED;
		return STATUS_INVALID;
	}
	
}
}
