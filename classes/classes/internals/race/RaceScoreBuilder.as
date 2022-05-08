package classes.internals.race {

import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.PerkLib;
import classes.PerkType;
import classes.Race;

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
	public function eyeTypeOfColor(type:*, color:*, score:int, failScore:int=0):RaceScoreBuilder {
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
	public function height(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HEIGHT, type, score, failScore, customName);
		return this;
	}
	public function hornType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HORN_TYPE, type, score, failScore, customName);
		return this;
	}
	public function noHorns(score:int):RaceScoreBuilder {
		return hornType(Horns.NONE, score);
	}
	public function legType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_LEG_TYPE, type, score, failScore, customName);
		return this;
	}
	public function rearType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_REAR_TYPE, type, score, failScore, customName);
		return this;
	}
	public function noRearBody(score:int, failScore:int=0):RaceScoreBuilder {
		return rearType(RearBody.NONE, score, failScore);
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
	public function wingType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_WING_TYPE, type, score, failScore, customName);
		return this;
	}
	public function noWings(score:int):RaceScoreBuilder {
		return wingType(Wings.NONE, score);
	}
	public function gender(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_GENDER, type, score, failScore, customName);
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
	 * +1 per each perk present. Listed as a single entry named "mutations"
	 */
	public function mutationPerks(perks:/*PerkType*/Array):RaceScoreBuilder {
		return customScoreRequirement(
				"perk",
				"Mutations",
				RaceUtils.hasAnyPerkFn(perks),
				function (body:BodyData):int {
					var score:int = 0;
					for each (var perk:PerkType in perks) {
						if (body.player.hasPerk(perk)) score++;
					}
					return score;
				});
	}
	
	/**
	 * +1 if has "Chimerical Body: Semi-Improved Stage" perk and any of these
	 */
	public function chimericalBodyPerks1(perks:/*PerkType*/Array):RaceScoreBuilder {
		return chimericalBodyPerks(
				PerkLib.ChimericalBodySemiImprovedStage,
				"Chimerical Body Semi-Improved Stage + Mutation I",
				perks
		)
	}
	/**
	 * +1 if has "Chimerical Body: Semi-Superior Stage" perk and any of these
	 */
	public function chimericalBodyPerks2(perks:/*PerkType*/Array):RaceScoreBuilder {
		return chimericalBodyPerks(
				PerkLib.ChimericalBodySemiSuperiorStage,
				"Chimerical Body Semi-Superior Stage + Mutation II",
				perks
		)
	}
	/**
	 * +1 if has "Chimerical Body: Semi-Epic Stage" perk and any of these
	 */
	public function chimericalBodyPerks3(perks:/*PerkType*/Array):RaceScoreBuilder {
		return chimericalBodyPerks(
				PerkLib.ChimericalBodySemiEpicStage,
				"Chimerical Body Semi-Epic Stage + Mutation III",
				perks
		)
	}
	/**
	 * +1 if has chimerical perk and any of these
	 */
	private function chimericalBodyPerks(
			chimericalBodyPerk:PerkType,
			name:String,
			perks:/*PerkType*/Array
	):RaceScoreBuilder {
		return customRequirement(
				"perk",
				name,
				function (body:BodyData):Boolean {
					if (!body.player.hasPerk(chimericalBodyPerk)) return false;
					for each (var perk:PerkType in perks) {
						if (body.player.hasPerk(perk)) return true;
					}
					return false;
				},
				+1
		)
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
			customName:String
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
