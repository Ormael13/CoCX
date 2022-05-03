package classes.internals.race {

import classes.BodyData;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.CockTypesEnum;
import classes.PerkType;

public class RaceScoreBuilder {
	internal var raceBuilder:RaceBuilder;
	internal var next:RaceScoreBuilder;
	internal var minScore:int;
	public function RaceScoreBuilder(
			raceBuilder:RaceBuilder,
			next:RaceScoreBuilder = null,
			minScore:int = 0
	) {
		this.raceBuilder = raceBuilder;
		this.next = next || this;
		this.minScore = minScore;
	}
	
	public function earType(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_EAR_TYPE, type1, score1, rest);
		return next;
	}
	public function armType(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_ARM_TYPE, type1, score1, rest);
		return next;
	}
	public function eyeType(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_EYE_TYPE, type1, score1, rest);
		return next;
	}
	public function eyeColor(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_EYE_COLOR, type1, score1, rest);
		return next;
	}
	public function faceType(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_FACE_TYPE, type1, score1, rest);
		return next;
	}
	public function hairType(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HAIR_TYPE, type1, score1, rest);
		return next;
	}
	public function hairColor(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HAIR_COLOR, type1, score1, rest);
		return next;
	}
	public function legType(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_LEG_TYPE, type1, score1, rest);
		return next;
	}
	public function rearType(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_REAR_TYPE, type1, score1, rest);
		return next;
	}
	public function skinCoatType(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, type1, score1, rest);
		return next;
	}
	public function skinCoatColor(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COAT_COLOR, type1, score1, rest);
		return next;
	}
	public function tailType(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_TAIL_TYPE, type1, score1, rest);
		return next;
	}
	public function noTail(score:int):RaceScoreBuilder {
		return tailType(Tail.NONE, score);
	}
	public function wingType(type1:*, score1:int, ...rest:Array):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_WING_TYPE, type1, score1, rest);
		return next;
	}
	public function noWings(score:int):RaceScoreBuilder {
		return wingType(Wings.NONE, score);
	}
	
	public function hasCockOfType(type:CockTypesEnum, score:int):RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"cock",
				type.DisplayName,
				RaceUtils.hasCockOfTypeFn(type),
				score,
				minScore
		))
		return next;
	}
	
	public function perk(perk:PerkType, score:int):RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"",
				"Perk: "+perk.name(),
				RaceUtils.hasPerkFn(perk),
				score,
				minScore
		))
		return next;
	}
	
	public function ifScoreAtLeast(minScore:int):RaceScoreBuilder {
		return new RaceScoreBuilder(raceBuilder, this, minScore);
	}
	
	public function and():RaceBuilder {
		return raceBuilder;
	}
	
	/*************************************************************************************/
	/* builder functions END */
	/*************************************************************************************/
	
	protected function addRequirement(requirement:RacialRequirement):void {
		raceBuilder.addRequirement(requirement);
	}
	
	private function addSlotRequirement(
			slot:int,
			type1:*,
			score1:int,
			rest:Array
	):void {
		var slotName:String = BodyData.Slots[slot].name;
		var requirements:Array = parseArgs(
				slot,
				type1, score1, rest,
				"["+raceBuilder.name+" "+ slotName+"] ");
		for each (var req:* in requirements) {
			addRequirement(new RacialRequirement(
					slotName,
					req.name,
					req.check,
					req.score,
					minScore
			));
		}
	}
	
	/**
	 * @return {{
	 *     score: int,
	 *     name: String,
	 *     check(body:BodyData, score:int): Boolean
	 * }[]}
	 */
	private static function parseArgs(slot:int, type1:*, score1:int, rest:Array, errorContext:String=""):Array {
		if (rest.length%2 !== 0) {
			throw new Error(errorContext+"Invalid argument count ("+(rest.length+2)+")")
		}
		var result:Array = [];
		result.push(parseArgPair(slot, type1, score1));
		for (var i:int = 0; i < rest.length; i+=2) {
			result.push(parseArgPair(slot, rest[i], rest[i+1]));
		}
		return result;
	}
	
	/**
	 * @return {{
	 *     score: int,
	 *     name: String,
	 *     check(body:BodyData, score:int): Boolean
	 * }}
	 */
	private static function parseArgPair(slot:int, type:*, score:int, errorContext:String=""):Object {
		var argumentFn:Function = RaceUtils.argumentSlotFn(slot);
		var operatorObject:Object = RaceUtils.parseOperatorObject(
				type,
				BodyData.Slots[slot].nameFn,
				errorContext
		);
		return {
			score: score,
			name: operatorObject.name,
			check: RaceUtils.composeOpArg(argumentFn, operatorObject.operatorFn)
		}
	}
	
}
}
