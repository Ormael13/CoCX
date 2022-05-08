package classes.internals.race {
import classes.BodyData;
import classes.PerkType;
import classes.Race;
import classes.RaceTier;
import classes.Stats.StatUtils;
import classes.internals.Utils;

public class RaceTierBuilder {
	public var tierNumber: int;
	public var race:Race;
	public var minScore:int;
	public var name:String;
	/**
	 * (body)=>String
	 */
	public var nameFn:Function;
	public var buffObj:Object = {};
	public var requirements:/*RaceTierRequirement*/Array = [];
	public var requiresPreviousTier:Boolean = false;
	public var extraBonuses:/*String*/Array = [];
	
	private static var currentBuilder:RaceTierBuilder = null;
	
	public function RaceTierBuilder(
			race: Race,
			tierNumber: int,
			minScore: int,
			maleName: String,
			femaleName: String
	) {
		if (currentBuilder != null) {
			trace('[ERROR] Race tier '+currentBuilder.name+" end() was not called.");
		}
		currentBuilder = this;
		this.race = race;
		this.tierNumber = tierNumber;
		this.minScore = minScore;
		this.name = maleName;
		this.nameFn = function(body:BodyData):String {
			return body.looksFemale ? femaleName : maleName;
		}
	}
	
	public function tauricName(name:String, femaleName:String=""):RaceTierBuilder {
		femaleName ||=name;
		var oldNameFn:Function = this.nameFn;
		this.nameFn = function(body:BodyData):String {
			if (body.isTaur) return body.looksFemale ? name : femaleName;
			return oldNameFn(body);
		}
		return this;
	}
	
	/**
	 * @param fn `function (body:BodyData):String` returning gendered/tauric/otherwise special name
	 */
	public function customNamingFunction(fn:Function):RaceTierBuilder {
		this.nameFn = fn;
		return this;
	}
	
	public function buffs(buffObject:Object):RaceTierBuilder {
		this.buffObj = buffObject;
		return this;
	}
	
	/**
	 * Add description of bonuses other than buffs.
	 */
	public function withExtraBonuses(...bonusDescriptions:/*String*/Array):RaceTierBuilder {
		Utils.pushAll(extraBonuses,bonusDescriptions);
		return this;
	}
	
	public function requireSkinCoatType(type:*):RaceTierBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, type);
		return this;
	}
	public function requireSkinCoatColor(color:*):RaceTierBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COAT_COLOR, color);
		return this;
	}
	public function requireTailType(type:*):RaceTierBuilder {
		addSlotRequirement(BodyData.SLOT_TAIL_TYPE, type);
		return this;
	}
	public function requireTailCount(count:*):RaceTierBuilder {
		addSlotRequirement(BodyData.SLOT_TAIL_COUNT, count);
		return this;
	}
	public function requirePerk(perk:PerkType):RaceTierBuilder {
		requirements.push(new RaceTierRequirement(
				perk.name+" perk",
				RaceUtils.hasPerkFn(perk)
		));
		return this;
	}
	public function requirePreviousTier():RaceTierBuilder {
		requiresPreviousTier = true;
		return this;
	}
	
	/**
	 * @param checkFn (body:BodyData)=>Boolean
	 * @return
	 */
	public function require(name:String, checkFn:Function):RaceTierBuilder {
		requirements.push(new RaceTierRequirement(name,checkFn));
		return this;
	}
	
	public function end():void {
		for (var stat:String in buffObj) {
			if (!StatUtils.isKnownStat(stat)) {
				trace("[ERROR] Race "+race.name+" tier "+name+" buffs non-existing stat "+stat);
			}
		}
		race.tiers.push(new RaceTier(
				tierNumber,
				name,
				nameFn,
				minScore,
				buffObj,
				requirements,
				extraBonuses
		))
		currentBuilder = null;
	}
	
	/*************************************************************************************/
	/* builder functions END */
	/*************************************************************************************/
	
	private function addSlotRequirement(
			slot:int,
			type:*
	):void {
		var operatorObject:Object = RaceUtils.parseOperatorObject(
				type,
				BodyData.Slots[slot].nameFn,
				"["+race.name+" "+BodyData.Slots[slot].name+"]"
		);
		var checkFn:Function = RaceUtils.composeOpArg(
				RaceUtils.argumentSlotFn(slot),
				operatorObject.operatorFn
		);
		requirements.push(new RaceTierRequirement(
				operatorObject.name,
				checkFn
		));
	}
	
}
}
