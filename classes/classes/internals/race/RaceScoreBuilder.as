package classes.internals.race {

import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.PerkLib;
import classes.PerkType;
import classes.Race;
import classes.StatusEffectClass;
import classes.StatusEffectType;

public class RaceScoreBuilder {
	internal var race:Race;
	internal var minScore:int;
	public function RaceScoreBuilder(
			race:Race,
			minScore:int = 0
	) {
		this.race = race;
		this.minScore = minScore;
	}
	
	public function armType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_ARM_TYPE, type, score, failScore, customName);
		return this;
	}
	public function antennaeType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_ANTENNAE_TYPE, type, score, failScore, customName);
		return this;
	}
	public function noAntennae(score:int):RaceScoreBuilder {
		return antennaeType(Antennae.NONE, score);
	}
	public function biggestCockLength(length:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_BIGGEST_COCK_LENGTH, length, score, failScore, customName);
		return this;
	}
	public function biggestTitSize(size:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_BIGGEST_TIT_SIZE, size, score, failScore, customName);
		return this;
	}
	public function earType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_EAR_TYPE, type, score, failScore, customName);
		return this;
	}
	public function eyeType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_EYE_TYPE, type, score, failScore, customName);
		return this;
	}
	public function eyeColor(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_EYE_COLOR, type, score, failScore, customName);
		return this;
	}
	public function eyeTypeAndColor(type:*, color:*, score:int, failScore:int =0):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"eyes",
						" ",
						slotRequirement(BodyData.SLOT_EYE_COLOR, color, score, failScore, "$name"),
						slotRequirement(BodyData.SLOT_EYE_TYPE, type, score, failScore)
				)
		)
		return this;
	}
	public function faceType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_FACE_TYPE, type, score, failScore, customName);
		return this;
	}
	public function gillType(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_GILLS_TYPE, value, score, failScore, customName);
		return this;
	}
	public function noGills(score:int, failScore:int=0):RaceScoreBuilder {
		return gillType(Gills.NONE, score, failScore);
	}
	public function hairType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HAIR_TYPE, type, score, failScore, customName);
		return this;
	}
	public function hairColor(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HAIR_COLOR, type, score, failScore, customName);
		return this;
	}
	public function hairTypeAndColor(type:*, color:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"hair",
						" ",
						slotRequirement(BodyData.SLOT_HAIR_COLOR, color, score, failScore, "$name"),
						slotRequirement(BodyData.SLOT_HAIR_TYPE, type, score, failScore)
				)
		);
		return this;
	}
	public function hornType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HORN_TYPE, type, score, failScore, customName);
		return this;
	}
	public function hornTypeAndCount(type:*, count:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"horn",
						" ",
						slotRequirement(BodyData.SLOT_HORN_COUNT, count, score, failScore, "$name"),
						slotRequirement(BodyData.SLOT_HORN_TYPE, type, score, failScore)
				), customName
		)
		return this;
	}
	public function noHorns(score:int):RaceScoreBuilder {
		return hornType(Horns.NONE, score);
	}
	public function legType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_LEG_TYPE, type, score, failScore, customName);
		return this;
	}
	public function isTaur(score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		return customRequirement("legs",customName||"is taur",
				function (body:BodyData):Boolean {
					return body.isTaur;
				},
				score, failScore);
	}
	public function isNaga(score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		return customRequirement("legs",customName||"is naga",
				function (body:BodyData):Boolean {
					return body.isNaga;
				},
				score, failScore);
	}
	public function rearType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_REAR_TYPE, type, score, failScore, customName);
		return this;
	}
	public function noRearBody(score:int, failScore:int=0):RaceScoreBuilder {
		return rearType(RearBody.NONE, score, failScore);
	}
	public function skinCoverage(coverage:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COVERAGE, coverage, score, failScore, customName);
		return this;
	}
	public function skinType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_TYPE, type, score, failScore, customName);
		return this;
	}
	public function skinColor(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COLOR, value, score, failScore, customName);
		return this;
	}
	public function skinBaseType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_BASE_TYPE, type, score, failScore, customName);
		return this;
	}
	public function skinBaseColor(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_BASE_COLOR, value, score, failScore, customName);
		return this;
	}
	public function skinBasePattern(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_BASE_PATTERN, value, score, failScore, customName);
		return this;
	}
	public function skinBaseAdj(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_BASE_ADJ, value, score, failScore, customName);
		return this;
	}
	public function skinCoatType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, type, score, failScore, customName);
		return this;
	}
	public function skinCoatColor(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COAT_COLOR, type, score, failScore, customName);
		return this;
	}
	public function skinCoatTypeAndColor(type:*, color:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"skin coat",
						" ",
						slotRequirement(BodyData.SLOT_SKIN_COAT_COLOR, color, score, failScore, "$name"),
						slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, type, score, failScore)
				)
		);
		return this;
	}
	public function skinPlainOnly(score:int, failScore:int=0):RaceScoreBuilder {
		return customRequirement(
				"skin",
				"plain skin",
				function(body:BodyData):Boolean {
					return body.player.hasPlainSkinOnly();
				},
				score,
				failScore
		);
	}
	public function tailType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_TAIL_TYPE, type, score, failScore, customName);
		return this;
	}
	public function noTail(score:int):RaceScoreBuilder {
		return tailType(Tail.NONE, score);
	}
	public function tailTypeAndCount(type:*, count:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"tail",
						" ",
						slotRequirement(BodyData.SLOT_TAIL_COUNT, count, score, failScore, "$name"),
						slotRequirement(BodyData.SLOT_TAIL_TYPE, type, score, failScore)
				), customName
		)
		return this;
	}
	public function tongueType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_TONGUE_TYPE, type, score, failScore, customName);
		return this;
	}
	public function vaginaType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_VAGINA_TYPE, type, score, failScore, customName);
		return this;
	}
	public function wingType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_WING_TYPE, type, score, failScore, customName);
		return this;
	}
	public function noWings(score:int):RaceScoreBuilder {
		return wingType(Wings.NONE, score);
	}
	public function gender(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_GENDER, value, score, failScore, customName);
		return this;
	}
	public function height(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HEIGHT, value, score, failScore, customName);
		return this;
	}
	public function thickness(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_THICKNESS, value, score, failScore, customName);
		return this;
	}
	public function tone(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_TONE, value, score, failScore, customName);
		return this;
	}
	public function corruption(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addOperatorRequirement(
				"stats",
				"$value corruption",
				function (body:BodyData):* { return body.player.cor},
				null,
				value,
				score,
				failScore,
				customName
				)
		return this;
	}
	public function femininity(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_FEMININITY, value, score, failScore, customName);
		return this;
	}
	public function breastRowCount(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addOperatorRequirement(
				"breasts",
				value === 1 ? "$value breast row" : "$value breast rows",
				function (body:BodyData):* { return body.player.breastRows.length},
				null,
				value,
				score,
				failScore,
				customName
				)
		return this;
	}
	
	public function hasCockOfType(type:CockTypesEnum, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"cock",
				type.DisplayName+" cock",
				RaceUtils.hasCockOfTypeFn(type),
				score,
				failScore,
				minScore
		), customName)
		return this;
	}
	public function hasVagina(score: int, failScore:int=0, customName:String = ""): RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"vagina",
				"has vagina",
				RaceUtils.hasVaginaFn(true),
				score,
				failScore,
				minScore
		), customName)
		return this;
	}
	public function noVagina(score: int, failScore:int=0, customName:String = ""): RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"vagina",
				"no vagina",
				RaceUtils.hasVaginaFn(false),
				score,
				failScore,
				minScore
		), customName)
		return this;
	}
	public function hasCock(score: int, failScore:int=0, customName:String = ""): RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"cock",
				"has cock",
				RaceUtils.hasCockFn(true),
				score,
				failScore,
				minScore
		), customName)
		return this;
	}
	public function noCock(score: int, failScore:int=0, customName:String = ""): RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"cock",
				"no cock",
				RaceUtils.hasCockFn(false),
				score,
				failScore,
				minScore
		), customName)
		return this;
	}
	
	public function hasStatusEffect(effect:StatusEffectType, name:String, score:int, failScore:int =0):RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"",
				name,
				function(body:BodyData):Boolean {
					return body.player.hasStatusEffect(effect);
				},
				score,
				failScore,
				minScore
		));
		return this;
	}
	
	public function hasPerk(perk:PerkType, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"perk",
				perk.name()+" perk",
				RaceUtils.hasPerkFn(perk),
				score,
				failScore,
				minScore
		), customName)
		return this;
	}
	
	/**
	 * Require having a perk and give racial score = (score + perkv1)
	 */
	public function givePerkV1(perk:PerkType, score:int=0,failScore:int=0, customName:String = ""):RaceScoreBuilder {
		return customScoreRequirement(
				"perk",
				customName || (perk.name()+" perk"),
				RaceUtils.hasPerkFn(perk),
				function(body:BodyData):int {
					return score + body.player.perkv1(perk);
				},
				failScore
				);
	}
	public function hasAllPerks(perks:/*PerkType*/Array, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"perk",
				perks.map(function(e:PerkType,...rest:Array):String{
					return e.name();
				}).join(", ")+" perks",
				RaceUtils.hasAllPerksFn(perks),
				score,
				failScore,
				minScore
		), customName)
		return this;
	}
	public function hasAnyPerk(perks:/*PerkType*/Array, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		var names:/*String*/Array = perks.map(function (e:PerkType, ...rest:Array):String {
			return e.name();
		});
		var name:String;
		if (perks.length <= 3) name = names.join(" or ") + " perk";
		else name = "any of " + names.join(", ") + " perks";
		addRequirement(new RacialRequirement(
				"perk",
				name,
				RaceUtils.hasAnyPerkFn(perks),
				score,
				failScore,
				minScore
		), customName)
		return this;
	}
	
	/**
	 * @param checkFn `function (body:BodyData):Boolean`
	 */
	public function customRequirement(
			group:String,
			name:String,
			checkFn:Function,
			score: int,
			failScore:int=0
	):RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				group,
				name,
				checkFn,
				score,
				failScore,
				minScore
		));
		return this;
	}
	
	/**
	 * @param checkFn `function (body:BodyData):Boolean`
	 * @param scoreFn `function (body:BodyData):int`
	 */
	public function customScoreRequirement(
			group:String,
			name:String,
			checkFn:Function,
			scoreFn:Function,
			failScore:int=0
	):RaceScoreBuilder {
		addRequirement(new CustomRacialRequirement(
				group,
				name,
				checkFn,
				scoreFn,
				failScore,
				minScore
		));
		return this;
	}
	
	/*************************************************************************************/
	/* builder functions END */
	/*************************************************************************************/
	
	protected function addRequirement(requirement:RacialRequirement,
									  customName:String=""):void {
		if (customName != "") requirement.name = customName;
		race.requirements.push(requirement);
	}
	
	private function addSlotRequirement(
			slot:int,
			type:*,
			score:int,
			failScore: int,
			customName:String=""
	):void {
		var slotName:String = BodyData.Slots[slot].name;
		var nameFn:Function = BodyData.Slots[slot].nameFn;
		var argumentFn:Function = RaceUtils.argumentSlotFn(slot);
		var req:Object = parseArgPair(
				argumentFn, nameFn,
				type, "["+race.name+" "+ slotName+"] ");
		addRequirement(new RacialRequirement(
				slotName,
				customName || (req.name+" "+slotName),
				req.check,
				score,
				failScore,
				minScore
		));
	}
	
	/**
	 * @example
	 * // Would generate requirement named "at least <50> strength"
	 * addOperatorRequirement(
	 *  "stats",
	 *  "$value strength",
	 *  function (body:BodyData):* { return body.player.str; },
	 *  function (value:*):String { return "<"+value+">"; },
	 *  AT_LEAST(50),
	 *  +1,
	 *  0
	 * )
	 *
	 * @param pattern naming template, "$value" is replaced with stringified values
	 * @param argumentFn `(body:BodyData)=>*`
	 * @param nameFn `(value:*)=>String`
	 * @param value Operator descriptor
	 */
	private function addOperatorRequirement(
			group:String,
			pattern:String,
			argumentFn:Function,
			nameFn:Function,
			value:*,
			score:int,
			failScore:int,
			customName:String=""
	):void {
		var oo:Object = RaceUtils.parseOperatorObject(value,nameFn,"["+race.name+" "+pattern+"]");
		addRequirement(new RacialRequirement(
				group,
				customName || pattern.replace(/\$value/g,oo.name),
				RaceUtils.composeOpArg(argumentFn, oo.operatorFn),
				score,
				failScore,
				minScore
		))
	}
	private function slotRequirement(
			slot:int,
			type:*,
			score:int,
			failScore:int,
			namePattern:String = "$name $slot"
	):RacialRequirement {
		var slotName:String = BodyData.Slots[slot].name;
		var nameFn:Function = BodyData.Slots[slot].nameFn;
		var argumentFn:Function = RaceUtils.argumentSlotFn(slot);
		var operatorObject:Object = RaceUtils.parseOperatorObject(
				type,
				nameFn,
				"["+race.name+" "+ slotName+"] "
		);
		return new RacialRequirement(
				slotName,
				namePattern.replace(/\$name/,operatorObject.name).replace(/\$slot/,slotName),
				RaceUtils.composeOpArg(argumentFn, operatorObject.operatorFn),
				score,
				failScore,
				minScore
		)
	}
	
	/**
	 * @return {{
	 *     name: String,
	 *     check(body:BodyData, score:int): Boolean
	 * }}
	 */
	private static function parseArgPair(argumentFn:Function, nameFn: Function, type:*, errorContext:String=""):Object {
		var operatorObject:Object = RaceUtils.parseOperatorObject(
				type,
				nameFn,
				errorContext
		);
		return {
			name: operatorObject.name,
			check: RaceUtils.composeOpArg(argumentFn, operatorObject.operatorFn)
		}
	}
	
}
}
