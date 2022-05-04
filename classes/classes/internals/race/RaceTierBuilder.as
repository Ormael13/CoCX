package classes.internals.race {
import classes.BodyData;
import classes.RaceTier;

public class RaceTierBuilder {
	public var tierNumber: int;
	public var raceBuilder:RaceBuilder;
	public var minScore:int;
	public var maleName:String;
	public var maleTauricName:String;
	public var femaleName:String;
	public var femaleTauricName:String;
	public var buffObj:Object = {};
	public var requirements:/*RaceTierRequirement*/Array = [];
	
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
		this.maleName = maleName;
		this.maleTauricName = maleName;
		this.femaleName = femaleName;
		this.femaleTauricName = femaleName;
	}
	
	public function tauricName(name:String, femaleName:String=""):RaceTierBuilder {
		this.maleTauricName = name;
		this.femaleTauricName = femaleName || name;
		return this;
	}
	
	public function buffs(buffObject:Object):RaceTierBuilder {
		this.buffObj = buffObject;
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
	
	public function and():RaceBuilder {
		var nameFunction:Function;
		var names:/*String*/Array = [maleName,femaleName,maleTauricName,femaleTauricName];
		nameFunction = function(body:BodyData):String {
			if (!body.isTaur) {
				return names[body.looksMale?0:1]
			} else {
				return names[body.looksMale?2:3]
			}
		}
		raceBuilder.tiers.push(new RaceTier(
				tierNumber,
				maleName,
				nameFunction,
				minScore,
				buffObj,
				requirements
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
				operatorObject.check
		));
	}
	
}
}
