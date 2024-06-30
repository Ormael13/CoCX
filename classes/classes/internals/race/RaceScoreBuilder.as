package classes.internals.race {

import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.PerkType;
import classes.Race;
import classes.StatusEffectType;
import classes.VaginaClass;

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
	public function ballSize(size:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_BALL_SIZE, size, score, failScore, customName);
		return this;
	}
	public function biggestCockLength(length:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_BIGGEST_COCK_LENGTH, length, score, failScore, customName);
		return this;
	}
	public function biggestTitSize(size:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_BIGGEST_TIT_SIZE, size, score, failScore, customName);
		return this;
	}
	public function chitinColors(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_CHITIN_COLORS, color, score, failScore, customName);
		return this;
	}
	public function chitinColor1(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_CHITIN_COLOR1, color, score, failScore, customName);
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
	public function eyeTypeAndColor(type:*, color:*, score:int, failScore:int =0, customName:String=""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"eyes",
						"; ",
						slotRequirement(BodyData.SLOT_EYE_COLOR, color, score, failScore),
						slotRequirement(BodyData.SLOT_EYE_TYPE, type, score, failScore)
				),
				customName
		)
		return this;
	}
	public function faceType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_FACE_TYPE, type, score, failScore, customName);
		return this;
	}
	public function furColors(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"skin coat",
						" colored ",
						slotRequirement(BodyData.SLOT_FUR_COLORS, color, score, failScore, false),
						slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, Skin.FUR, score, failScore)
				), customName
		);
		return this;
	}
	public function furColor1(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"skin coat",
						" colored ",
						slotRequirement(BodyData.SLOT_FUR_COLOR1, color, score, failScore, false),
						slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, Skin.FUR, score, failScore)
				), customName
		);
		return this;
	}
	public function furColor01(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_FUR_COLOR1, color, score, failScore, customName);
		return this;
	}
	public function furColor2(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"skin coat",
						" colored ",
						slotRequirement(BodyData.SLOT_FUR_COLOR2, color, score, failScore, false),
						slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, Skin.FUR, score, failScore)
				), customName
		);
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
	public function hairColors(type:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HAIR_COLORS, type, score, failScore, customName);
		return this;
	}
	public function hairColor1(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HAIR_COLOR1, type, score, failScore, customName);
		return this;
	}
	public function hairColor2(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_HAIR_COLOR2, type, score, failScore, customName);
		return this;
	}
	public function hairTypeAndColor1(type:*, color:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"hair",
						"; ",
						slotRequirement(BodyData.SLOT_HAIR_COLOR1, color, score, failScore),
						slotRequirement(BodyData.SLOT_HAIR_TYPE, type, score, failScore)
				), customName
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
						slotRequirement(BodyData.SLOT_HORN_COUNT, count, score, failScore, false),
						slotRequirement(BodyData.SLOT_HORN_TYPE, type, score, failScore)
				), customName
		)
		return this;
	}
	public function noHorns(score:int, failScore:int=0):RaceScoreBuilder {
		return hornType(Horns.NONE, score, failScore);
	}
	public function legType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_LEG_TYPE, type, score, failScore, customName);
		return this;
	}
	public function isTaur(score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		return customRequirement("legs",customName||"taur lower body",
				function (body:BodyData):Boolean {
					return body.isTaur;
				},
				score, failScore);
	}
	public function isNotTaur(score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		return customRequirement("legs",customName||"not taur lower body",
				function (body:BodyData):Boolean {
					return !body.isTaur;
				},
				score, failScore);
	}
	public function isNaga(score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		return customRequirement("legs",customName||"naga-like lower body",
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
	public function scaleColors(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SCALE_COLORS, color, score, failScore, customName);
		return this;
	}
	public function scaleColor1(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SCALE_COLOR1, color, score, failScore, customName);
		return this;
	}
	public function scaleColor2(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SCALE_COLOR2, color, score, failScore, customName);
		return this;
	}

	public function featherColors(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"skin coat",
						" colored ",
						slotRequirement(BodyData.SLOT_FEATHER_COLORS, color, score, failScore, false),
						slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, Skin.FEATHER, score, failScore)
				), customName
		);
		return this;
	}

	public function featherColor1(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"skin coat",
						" colored ",
						slotRequirement(BodyData.SLOT_FEATHER_COLOR1, color, score, failScore, false),
						slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, Skin.FEATHER, score, failScore)
				), customName
		);
		return this;
	}

	public function featherColor2(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"skin coat",
						" colored ",
						slotRequirement(BodyData.SLOT_FEATHER_COLOR2, color, score, failScore, false),
						slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, Skin.FEATHER, score, failScore)
				), customName
		);
		return this;
	}

	public function skinCoverage(coverage:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COVERAGE, coverage, score, failScore, customName);
		return this;
	}
	public function skinType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_TYPE, type, score, failScore, customName);
		return this;
	}
	public function bodyColors(value:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_BODY_COLORS, value, score, failScore, customName);
		return this;
	}
	public function bodyColor1(value:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_BODY_COLOR1, value, score, failScore, customName);
		return this;
	}
	public function skinBaseType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_BASE_TYPE, type, score, failScore, customName);
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
	public function skinColors(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COLORS, color, score, failScore, customName);
		return this;
	}
	public function skinColor1(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COLOR1, color, score, failScore, customName);
		return this;
	}
	public function skinColor2(color:*, score:int, failScore:int =0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COLOR2, color, score, failScore, customName);
		return this;
	}
	public function skinCoatTypeAndColors(type:*, color:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"skin coat",
						" colored ",
						slotRequirement(BodyData.SLOT_SKIN_COAT_COLORS, color, score, failScore, false),
						slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, type, score, failScore)
				), customName
		);
		return this;
	}
	public function skinCoatTypeAndColor1(type:*, color:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addRequirement(
				RacialRequirement.joinAnd(
						"skin coat",
						" colored ",
						slotRequirement(BodyData.SLOT_SKIN_COAT_COLOR1, color, score, failScore, false),
						slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, type, score, failScore)
				), customName
		);
		return this;
	}
	public function skinCoatPattern(value:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_SKIN_COAT_PATTERN, value, score, failScore, customName);
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
	public function plainSkinOfAdj(adj:*, score:int, failScore:int=0):RaceScoreBuilder {
		var oo:Object = RaceUtils.parseOperatorObject(adj, null);
		return customRequirement(
				"skin",
				function (): String {
					return oo.nameFn()+" plain skin";
				},
				function(body:BodyData):Boolean {
					return body.player.hasPlainSkinOnly() && oo.operatorFn(body.skinBaseAdj);
				},
				score,
				failScore
		);
	}
	public function plainSkinOfColor1(color:*, score:int, failScore:int=0):RaceScoreBuilder {
		var oo:Object = RaceUtils.parseOperatorObject(color, BodyData.defaultPhraseFn(" plain skin",null));
		return customRequirement(
				"skin",
				oo.nameFn,
				function(body:BodyData):Boolean {
					return body.player.hasPlainSkinOnly() && oo.operatorFn(body.skinColor1);
				},
				score,
				failScore
		);
	}
	public function tailType(type:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		addSlotRequirement(BodyData.SLOT_TAIL_TYPE, type, score, failScore, customName);
		return this;
	}
	public function noTail(score:int, failScore:int=0):RaceScoreBuilder {
		return tailType(Tail.NONE, score, failScore);
	}
	public function tailTypeAndCount(type:*, count:*, score:int, failScore:int=0, customName:String = ""):RaceScoreBuilder {
		var req:RacialRequirement = RacialRequirement.joinAnd(
				"tail",
				" ",
				slotRequirement(BodyData.SLOT_TAIL_COUNT, count, score, failScore, false),
				slotRequirement(BodyData.SLOT_TAIL_TYPE, type, score, failScore, false)
		);
		const nameFn:Function = function():String {
			var suffix:String = "";
			if (count is Number) {
				if (count > 1) suffix = " tails";
				else suffix = " tail";
			} else {
				suffix = " tail(s)"
			}
			return req.getName() + suffix;
		};
		addRequirement(req.withNameFn(nameFn), customName);
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
	public function noWings(score:int, failScore:int=0):RaceScoreBuilder {
		return wingType(Wings.NONE, score, failScore);
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
	public function cockOrVaginaOfType(cockType:CockTypesEnum,vaginaType:int,score:int,failScore:int=0,customName:String=""):RaceScoreBuilder {
		if (!customName) {
			var c:String = cockType.DisplayName;
			var v:String = VaginaClass.Types[vaginaType].name;
			if (c == v) {
				customName = c+" cock or vagina";
			} else {
				customName = c+" cock or "+v+" vagina";
			}
		}
		return customRequirement("genitals",
				customName,
				function (body:BodyData):Boolean {
					return body.vaginaType == vaginaType || body.player.countCocksWithType(cockType) > 0;
				},
				score,
				failScore
				);
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
	public function hasBalls(score: int, failScore:int=0, customName:String = ""): RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"balls",
				"has balls",
				RaceUtils.hasBallsFn(true),
				score,
				failScore,
				minScore
		), customName)
		return this;
	}
	public function noBalls(score: int, failScore:int=0, customName:String = ""): RaceScoreBuilder {
		addRequirement(new RacialRequirement(
				"balls",
				"no balls",
				RaceUtils.hasBallsFn(false),
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
			name:*/*String|Function*/,
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
		if (customName != "") requirement.setNameStr(customName);
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
		var argumentFn:Function = RaceUtils.argumentSlotFn(slot);
		var req:Object = parseArgPair(
				argumentFn, BodyData.slotPhraseFn(slot),
				type, "["+race.name+" "+ slotName+"] ");
		addRequirement(new RacialRequirement(
				slotName,
				customName || req.nameFn,
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
		var oo:Object = RaceUtils.parseOperatorObject(value,BodyData.defaultPhraseFn("",nameFn),"["+race.name+" "+pattern+"]");
		addRequirement(new RacialRequirement(
				group,
				customName || function (): String {
					return pattern.replace(/\$value/g,oo.nameFn())
				},
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
			suffix:Boolean=true
	):RacialRequirement {
		var slotName:String = BodyData.Slots[slot].name;
		var argumentFn:Function = RaceUtils.argumentSlotFn(slot);
		var operatorObject:Object = RaceUtils.parseOperatorObject(
				type,
				BodyData.slotPhraseFn(slot,suffix),
				"["+race.name+" "+ slotName+"] "
		);
		return new RacialRequirement(
				slotName,
				operatorObject.nameFn,
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
	private static function parseArgPair(argumentFn:Function, phraseFn: Function, type:*, errorContext:String=""):Object {
		var operatorObject:Object = RaceUtils.parseOperatorObject(
				type,
				phraseFn,
				errorContext
		);
		return {
			nameFn: operatorObject.nameFn,
			check: RaceUtils.composeOpArg(argumentFn, operatorObject.operatorFn)
		}
	}
	
}
}
