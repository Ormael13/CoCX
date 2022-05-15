package classes {
import classes.internals.Utils;
import classes.internals.race.ConditionedRaceScoreBuilder;
import classes.internals.race.RaceScoreBuilder;
import classes.internals.race.RaceTierBuilder;
import classes.internals.race.RacialRequirement;

public class Race {
	public static const RaceById:Object                    = {};
	/**
	 * All races, including disabled
	 */
	public static const AllRacesWithDisabled:/*Race*/Array = [];
	/**
	 * All races except disabled; use this array to calc racial scores and apply bonuses
	 */
	public static var AllEnabledRaces:/*Race*/Array      = [];
	/**
	 * All races except disabled and hidden
	 */
	public static var AllVisibleRaces:/*Race*/Array = [];
	/**
	 * All visible enabled races, sorted by name
	 */
	public static var AllRacesByName:/*Race*/Array = [];
	
	public static function byId(id:int):Race {
		return RaceById[id];
	}
	
    public var name:String;
    public var id:int;
    private var playerFunctionName:String;
	public var requirements:/*RacialRequirement*/Array = [];
	public var tiers:/*RaceTier*/Array = [];
	public var bloodlinePerks:/*PerkType*/Array = [];
	/**
	 * Array of pairs: `[mutationPerk:PerkType, scorePerStage:int]`
	 */
	public var mutations:/*Array*/Array = [];
	private var _minScore:int;
	
	/**
	 * true - do not display the race in menus
	 */
	public var hidden:Boolean = false;
	
	/**
	 * true - do not apply any bonuses
	 */
	public var disabled:Boolean = false;

    /**
     * @param _name Display name of the race
     * @param _id Unique number id
     * @param _playerFunctionName (old system) Function in Player class that returns score for this race
	 * @param _minScore (old system) Min score for player to be qualified as this race
     */
    function Race(_name:String, _id:int, _playerFunctionName: String="", _minScore:int=0) {
        this.name = _name;
        this.id = _id;
        this.playerFunctionName = _playerFunctionName;
        RaceById[_id] = this;
		AllRacesWithDisabled.push(this);
		this._minScore = _minScore;
    }
	
	public function basicScore(body:BodyData):int {
		if (playerFunctionName) {
			return body.player[playerFunctionName]();
		} else {
			var score:int = 0;
			try {
				Utils.Begin("Race", "basicScore", name);
				for each(var req:RacialRequirement in requirements) {
					score += req.calcScore(body, score);
				}
				if (score < 0) score = 0;
			} finally {
				Utils.End("Race", "basicScore");
			}
			return score;
		}
	}
	
	public function totalScore(body:BodyData):int {
		return finalizeScore(body, basicScore(body));
	}
	
	/**
	 * Complete racial score calculation
	 * @param body
	 * @param score basic score
	 * @param outputText Optional function `(reason:String, scoreChange:int)=>void` to print reason of score changes.
	 * @return final racial score
	 */
	public function finalizeScore(
			body:BodyData,
			score:int,
			outputText:Function = null
	):int {
		var player:Player = body.player;
		var bonus:int;
		
		if (bloodlinePerks.length > 0) {
			bonus = 0;
			for each (var perk:PerkType in bloodlinePerks) {
				if (body.player.hasPerk(perk)) {
					bonus += body.player.increaseFromBloodlinePerks();
					break;
				}
			}
			if (outputText != null) outputText("Bloodline", bonus);
			score += bonus;
		}
		if (mutations.length > 0) {
			bonus = 0;
			var maxStage:int = 0;
			for each (var entry:Array in mutations) {
				// entry: [mutationPerk:PerkType, scorePerStage:int]
				var stage:Number = body.player.perkv1(entry[0]);
				bonus += stage*entry[1];
				maxStage = Math.max(maxStage, stage);
			}
			if (outputText != null) outputText("Mutations", bonus);
			score += bonus;
			if (body.player.hasPerk(PerkLib.ChimericalBodySemiImprovedStage)) {
				bonus = maxStage >= 1 ? +1 : 0;
				if (outputText != null) outputText("Chimerical Body: Semi-Improved Stage", bonus);
				score += bonus;
			}
			if (body.player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStage)) {
				bonus = maxStage >= 2 ? +1 : 0;
				if (outputText != null) outputText("Chimerical Body: Semi-Superior Stage", bonus);
				score += bonus;
			}
			if (body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStage)) {
				bonus = maxStage >= 3 ? +1 : 0;
				if (outputText != null) outputText("Chimerical Body: Semi-Epic Stage", bonus);
				score += bonus;
			}
		}
		
		if (player.hasPerk(PerkLib.RacialParagon) && this != player.racialParagonSelectedRace()) {
			if (outputText != null) outputText("Racial Paragon",-score);
			return 0;
		}
		if (player.isGargoyle() && this != Races.GARGOYLE) {
			if (outputText != null) outputText("Gargoyle",-score);
			return 0;
		}
		if (player.hasPerk(PerkLib.ElementalBody) && this != Races.ELEMENTALFUSION) {
			if (outputText != null) outputText("Elemental",-score);
			return 0;
		}
		if (this != Races.HUMAN && this != Races.ELEMENTALFUSION && this != Races.GARGOYLE) {
			if (player.hasPerk(PerkLib.AscensionCruelChimerasThesis) && score >= minScore-2) {
				if (outputText != null) outputText("Ascension: Cruel Chimera's Thesis", +1);
				score += 1;
			}
			if (player.hasPerk(PerkLib.AscensionHybridTheory) && score >= minScore-1) {
				if (outputText != null) outputText("Ascension: Hybrid Theory", +1);
				score += 1;
			}
			if (player.hasPerk(PerkLib.ChimericalBodyUltimateStage)) {
				if (outputText != null) outputText("Chimerical Body: Ultimate Stage", +50);
				score += 50;
			}
		}
		return score;
	}
	
	public function getTier(body:BodyData, score:int=-1):RaceTier {
		if (score < 0) score = this.totalScore(body);
		var tier:RaceTier = null;
		for each(var i:RaceTier in tiers) {
			if (i.check(body, score)) tier = i;
		}
		return tier;
	}
	public function getTierNumber(body:BodyData, score:int=-1):int {
		var tier:RaceTier = getTier(body,score);
		if (!tier) return 0;
		return tier.tierNumber;
	}
	
	public function nameFor(body:BodyData, score:int=-1):String {
		if (score < 0) score = this.totalScore(body);
		var tier:RaceTier = getTier(body, score);
		if (tier) return tier.nameFor(body);
		if (tiers.length > 0) return tiers[0].nameFor(body);
		return name;
	}
	
	public function get minScore():int {
		if (this.tiers.length == 0) return _minScore;
		return this.tiers[0].minScore;
	}
	
	public function printDetails(body:BodyData):String {
		var s:String = "";
		var score:int = 0;
		var minScore:int = 0;
		for each (var rr:RacialRequirement in requirements) {
			if (rr.minScore != minScore) {
				s += "\t<b>After score "+rr.minScore+":</b>\n";
				minScore = rr.minScore;
			}
			s += "\t";
			var pass:Boolean = rr.check(body, score);
			var rscore:int = rr.calcScore(body, score);
			if (pass && rscore >= 0) {
				s += "[font-green]";
			} else if (pass && rscore < 0) {
				s += "[font-yellow]";
			} else {
				s += "[font-default]";
			}
			score += rscore;
			s += rr.name;
			if (rr.varyingScore() && !rr.check(body, score)) {
				// do not display (+X) for requirements that have varying values and
				// didn't pass, because value could be incorrect
				if (rscore != 0) {
					s += " [/font][font-red]("+rscore+" penalty)";
				}
			} else {
				rscore = rr.passScore(body);
				s += " (" + (rscore>0?"+"+rscore:rscore)+")";
				if (rr.failScore < 0) {
					if (pass) {
						s += "[/font][font-default] (" + rr.failScore + " penalty)";
					} else {
						s += "[/font][font-red] (" + rr.failScore + " penalty)";
					}
				}
			}
			s += "[/font]\n";
		}
		var hasFinalizer:Boolean = false;
		function finalizerOutput(reason:String, change:int):void {
			if (!hasFinalizer) {
				s += "\t<b>Other:</b>\n";
				hasFinalizer = true;
			}
			s += "\t";
			if (change > 0) s += "[font-green]"
			else if (change < 0) s += "[font-green]"
			else s += "[font-default]"
			s += reason+" ("+(change>0?"+"+change:change)+")";
			s += "[/font]\n";
		}
		finalizeScore(body, score, finalizerOutput);
		if (tiers.length>0) {
			s += "\t<b>Tiers:</b>\n";
		}
		for each(var tier:RaceTier in tiers) {
			s += "\t<b>";
			var present:Boolean = tier.check(body, score);
			if (present) {
				s += "[font-blue]"+tier.nameFor(body)+"[/font]";
			} else {
				s += tier.nameFor(body);
			}
			s += " ("+tier.minScore+") </b>";
			s += tier.describeBuffs(present ? body : null);
			s += "\n";
		}
		return s;
	}
	
	// Race builder helper functions. Can be used as a substitute for type
	// Ex. faceType( ANY(Face.HUMAN, Face.TROLL), +1)
	// instead of faceType(Face.HUMAN, +1).faceType(Face.TROLL, +1)
	
	protected static function ANY(...options:Array):* {
		return {operator:"any",options:Utils.flatten(options)};
	}
	protected static function NONE(...options:Array):* {
		return {operator:"none",options:Utils.flatten(options)};
	}
	protected static function LESS_THAN(value:Number):* {
		return {operator:"lt",value:value};
	}
	protected static function GREATER_THAN(value:Number):* {
		return {operator:"gt",value:value};
	}
	protected static function AT_MOST(value:Number):* {
		return {operator:"lte",value:value};
	}
	protected static function AT_LEAST(value:Number):* {
		return {operator:"gte",value:value};
	}
	protected static function NOT(value:*):* {
		return {operator:"ne",value:value};
	}
	
	// Race builder functions
	
	protected function addScores():RaceScoreBuilder {
		return new RaceScoreBuilder(this);
	}
	protected function addScoresAfter(minScore:int):RaceScoreBuilder {
		return new RaceScoreBuilder(this, minScore);
	}
	/**
	 * @param conditionFn `(body:BodyData) => boolean`
	 */
	public function addConditionedScores(
			conditionFn:Function,
			conditionName:String,
			minScore:int=0
	):RaceScoreBuilder {
		return new ConditionedRaceScoreBuilder(this,conditionFn, conditionName, minScore);
	}
	protected function addBloodline(bloodlinePerks:/*PerkType*/Array):void {
		Utils.pushAll(this.bloodlinePerks, bloodlinePerks);
	}
	protected function addMutation(perkType:PerkType, scorePerStage:int=+1):void {
		this.mutations.push([perkType,scorePerStage]);
	}
	protected function buildTier(minScore:int, name:String, femaleName:String =""):RaceTierBuilder {
		return new RaceTierBuilder(this, tiers.length+1, minScore, name, femaleName||name);
	}

    }
}
