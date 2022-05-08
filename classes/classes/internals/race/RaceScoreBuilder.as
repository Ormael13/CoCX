package classes.internals.race {

import classes.BodyData;
import classes.BodyParts.Antennae;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.CockTypesEnum;
import classes.PerkType;
import classes.internals.Utils;

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
	
	public function armType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_ARM_TYPE, type, score, customName);
		return next;
	}
	public function antennaeType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_ANTENNAE_TYPE, type, score, customName);
		return next;
	}
	public function noAntennae(score:int):RaceScoreBuilder {
		return antennaeType(Antennae.NONE, score);
	}
	public function earType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_EAR_TYPE, type, score, customName);
		return next;
	}
	public function eyeType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_EYE_TYPE, type, score, customName);
		return next;
	}
	public function eyeColor(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_EYE_COLOR, type, score, customName);
		return next;
	}
	public function eyeTypeOfColor(type:*, color:*, score:int):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"eyes",
						" ",
						slotRequirement(BodyData.SLOT_EYE_COLOR, color, score, "$name"),
						slotRequirement(BodyData.SLOT_EYE_TYPE, type, score)
				)
		)
		return next;
	}
	public function faceType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_FACE_TYPE, type, score, customName);
		return next;
	}
	public function hairType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HAIR_TYPE, type, score, customName);
		return next;
	}
	public function hairColor(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HAIR_COLOR, type, score, customName);
		return next;
	}
	public function height(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HEIGHT, type, score, customName);
		return next;
	}
	public function hornType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HORN_TYPE, type, score, customName);
		return next;
	}
	public function legType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_LEG_TYPE, type, score, customName);
		return next;
	}
	public function rearType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_REAR_TYPE, type, score, customName);
		return next;
	}
	public function skinBaseType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_BASE_TYPE, type, score, customName);
		return next;
	}
	public function skinBaseColor(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_BASE_COLOR, type, score, customName);
		return next;
	}
	public function skinCoatType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, type, score, customName);
		return next;
	}
	public function skinCoatColor(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COAT_COLOR, type, score, customName);
		return next;
	}
	public function skinPlainOnly(score:int):RaceScoreBuilder {
		return customRequirement(
				"skin",
				"plain skin",
				function(body:BodyData):Boolean {
					return body.player.hasPlainSkinOnly();
				},
				score
		);
	}
	public function tailType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_TAIL_TYPE, type, score, customName);
		return next;
	}
	public function noTail(score:int):RaceScoreBuilder {
		return tailType(Tail.NONE, score);
	}
	public function tailTypeAndCount(type:*, count:*, score:int, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"tail",
						" ",
						slotRequirement(BodyData.SLOT_TAIL_COUNT, count, score, "$name"),
						slotRequirement(BodyData.SLOT_TAIL_TYPE, type, score)
				), customName
		)
		return next;
	}
	public function tongueType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_TONGUE_TYPE, type, score, customName);
		return next;
	}
	public function wingType(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_WING_TYPE, type, score, customName);
		return next;
	}
	public function noWings(score:int):RaceScoreBuilder {
		return wingType(Wings.NONE, score);
	}
	public function gender(type:*, score:int, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_GENDER, type, score, customName);
		return next;
	}
	
	public function hasCockOfType(type:CockTypesEnum, score:int, customName:String = ""):RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"cock",
				type.DisplayName+" cock",
				RaceUtils.hasCockOfTypeFn(type),
				score,
				minScore
		), customName)
		return next;
	}
	public function hasVagina(score: int, customName:String = ""): RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"vagina",
				"has vagina",
				RaceUtils.hasVaginaFn(true),
				score,
				minScore
		), customName)
		return next;
	}
	
	public function perk(perk:PerkType, score:int, customName:String = ""):RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"",
				perk.name()+" perk",
				RaceUtils.hasPerkFn(perk),
				score,
				minScore
		), customName)
		return next;
	}
	public function allPerks(perks:/*PerkType*/Array, score:int, customName:String = ""):RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"",
				perks.map(function(e:PerkType,...rest:Array):String{
					return e.name();
				}).join(", ")+" perks",
				RaceUtils.hasAllPerksFn(perks),
				score,
				minScore
		), customName)
		return next;
	}
	public function anyPerk(perks:/*PerkType*/Array, score:int, customName:String = ""):RaceScoreBuilder {
		var names:/*String*/Array = perks.map(function (e:PerkType, ...rest:Array):String {
			return e.name();
		});
		var name:String;
		if (perks.length <= 3) name = names.join(" or ") + " perk";
		else name = "any of " + names.join(", ") + " perks";
		addRequirement(new RacialRequirement(
				"",
				name,
				RaceUtils.hasAnyPerkFn(perks),
				score,
				minScore
		), customName)
		return next;
	}
	
	/**
	 * @param checkFn `function (body:BodyData):Boolean`
	 */
	public function customRequirement(
			group:String,
			name:String,
			checkFn:Function,
			score: int
	):RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				group,
				name,
				checkFn,
				score,
				minScore
		));
		return next;
	}
	
	/**
	 * @param checkFn `function (body:BodyData):Boolean`
	 * @param scoreFn `function (body:BodyData):int`
	 */
	public function customScoreRequirement(
			group:String,
			name:String,
			checkFn:Function,
			scoreFn:Function
	):RaceScoreBuilder {
		addRequirement(new CustomRacialRequirement(
				group,
				name,
				checkFn,
				scoreFn,
				minScore
		));
		return next;
	}
	
	public function end():RaceBuilder {
		return raceBuilder;
	}
	
	/*************************************************************************************/
	/* builder functions END */
	/*************************************************************************************/
	
	protected function addRequirement(requirement:RacialRequirement,
									  customName:String=""):void {
		raceBuilder.addRequirement(requirement, customName);
	}
	
	private function addSlotRequirement(
			slot:int,
			type:*,
			score:int,
			customName:String
	):void {
		var slotName:String = BodyData.Slots[slot].name;
		var nameFn:Function = BodyData.Slots[slot].nameFn;
		var argumentFn:Function = RaceUtils.argumentSlotFn(slot);
		var req:Object = parseArgPair(
				argumentFn, nameFn,
				type, score,
				"["+raceBuilder.name+" "+ slotName+"] ");
		addRequirement(new RacialRequirement(
				slotName,
				customName || (req.name+" "+slotName),
				req.check,
				req.score,
				minScore
		));
	}
	private function slotRequirement(
			slot:int,
			type:*,
			score:int,
			namePattern:String = "$name $slot"
	):RacialRequirement {
		var slotName:String = BodyData.Slots[slot].name;
		var nameFn:Function = BodyData.Slots[slot].nameFn;
		var argumentFn:Function = RaceUtils.argumentSlotFn(slot);
		var operatorObject:Object = RaceUtils.parseOperatorObject(
				type,
				nameFn,
				"["+raceBuilder.name+" "+ slotName+"] "
		);
		return new RacialRequirement(
				slotName,
				namePattern.replace(/\$name/,operatorObject.name).replace(/\$slot/,slotName),
				RaceUtils.composeOpArg(argumentFn, operatorObject.operatorFn),
				score,
				minScore
		)
	}
	
	/**
	 * @return {{
	 *     score: int,
	 *     name: String,
	 *     check(body:BodyData, score:int): Boolean
	 * }}
	 */
	private static function parseArgPair(argumentFn:Function, nameFn: Function, type:*, score:int, errorContext:String=""):Object {
		var operatorObject:Object = RaceUtils.parseOperatorObject(
				type,
				nameFn,
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
