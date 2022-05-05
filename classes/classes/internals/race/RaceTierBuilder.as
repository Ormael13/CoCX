package classes.internals.race {
import classes.BodyData;
import classes.PerkType;
import classes.RaceTier;
import classes.internals.Utils;

public class RaceTierBuilder {
	public var tierNumber: int;
	public var raceBuilder:RaceBuilder;
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
	
	public function RaceTierBuilder(
			raceBuilder: RaceBuilder,
			tierNumber: int,
			minScore: int,
			maleName: String,
			femaleName: String
	) {
		this.raceBuilder = raceBuilder;
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
	
	public function end():RaceBuilder {
		raceBuilder.tiers.push(new RaceTier(
				tierNumber,
				name,
				nameFn,
				minScore,
				buffObj,
				requirements,
				extraBonuses
		))
		return raceBuilder;
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
				"["+raceBuilder.name+" "+BodyData.Slots[slot].name+"]"
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
