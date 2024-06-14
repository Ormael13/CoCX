package classes {
import classes.Transformations.Transformation;
import classes.Transformations.Transformations.RaceTransformations;
import classes.internals.Utils;
import classes.internals.race.ConditionedRaceScoreBuilder;
import classes.internals.race.RaceScoreBuilder;
import classes.internals.race.RaceTierBuilder;
import classes.internals.race.RaceTierRequirement;
import classes.internals.race.RacialRequirement;
import classes.GeneticMemories.RaceMem;
import classes.Scenes.Metamorph;

public class Race {
	public static const RaceById:Object                    = {};
	
	public static function byId(id:int):Race {
		return RaceById[id];
	}
	
    public var name:String;
    public var id:int;
	public var requirements:/*RacialRequirement*/Array = [];
	public var tiers:/*RaceTier*/Array = [];
	public var bloodlinePerks:/*PerkType*/Array = [];
	/**
	 * Array of pairs: `[mutationPerk:IMutationPerkType, scorePerStage:int]`
	 */
	public var mutations:/*Array*/Array = [];
	/**
	 * Min score to get bonuses from mutation
	 */
	public var mutationThreshold:int = 3;
	
	/**
	 * true - do not display the race in menus
	 */
	public var hidden:Boolean = false;
	
	/**
	 * true - do not apply any bonuses
	 */
	public var disabled:Boolean = false;
	/**
	 * Tier to contribute to chimera score. 0 or -1 if this race doesn't contribute.
	 */
	public var chimeraTier:int = 1;
	/**
	 * Tier to contribute to grand chimera score. 0 or -1 if this race doesn't contribute.
	 */
	public var grandChimeraTier:int = 2;

    /**
	 * Used to do Full Body Transformations
     */
    public var tfRace : int = 0;

    /**
     * @param _name Display name of the race
     * @param _id Unique number id
     */
    function Race(_name:String, _id:int, raceBody/*String*/:Array) {
        this.name = _name;
        this.id = _id;
		if (_id in RaceById) {
			trace("[ERROR] Duplicate race id "+_id);
		}
		initRaceMemory(_name, raceBody);
		RaceById[_id] = this;
    }
	/**
	 * Configure tiers, requirements & other stuff
	 */
	public function setup():void {
	
	}
	
	public function basicScore(body:BodyData):int {
		var score:int = 0;
		try {
			Utils.Begin("Race", "basicScore", name);
			for each(var req:RacialRequirement in requirements) {
				score += req.calcScore(body, score);
			}
		} finally {
			Utils.End("Race", "basicScore");
		}
		return score;
	}
	
	public function totalScore(body:BodyData, checkRP:Boolean = true):int {
		return finalizeScore(body, basicScore(body), checkRP);
	}
	
	/**
	 * Complete racial score calculation
	 * @param body
	 * @param score basic score
	 * @param checkRP set to true to check Racial Paragon and other conditions, setting the score to zero.
	 * @param outputText Optional function `(reason:String, scoreChange:int)=>void` to print reason of score changes.
	 * @return final racial score
	 */
	public function finalizeScore(
			body:BodyData,
			score:int,
			checkRP:Boolean = true,
			outputText:Function = null
	):int {
		var player:Player = body.player;
		var bonus:int;
		if (bloodlinePerks.length > 0) {
			bonus = 0;
			for each (var perk:PerkType in bloodlinePerks) {
				if (score >= mutationThreshold && body.player.hasPerk(perk)) {
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
				var pt:PerkType = entry[0];
				var pc:PerkClass = body.player.getPerk(pt);
				var stage:Number = pc ? pc.value1 : 0;
				bonus = score >= mutationThreshold ? stage*entry[1] : 0;
				if (outputText != null) outputText("Mutation: "+pt.name(pc), bonus);
				score += bonus;
				maxStage = Math.max(maxStage, stage);
			}
			//if (outputText != null) outputText("Mutations", bonus);
			//score += bonus;
			if (body.player.hasPerk(PerkLib.ChimericalBodySemiImprovedStage)) {
				bonus = score >= mutationThreshold && maxStage >= 1 ? +1 : 0;
				if (outputText != null) outputText("Chimerical Body: Semi-Improved Stage", bonus);
				score += bonus;
			}
			if (body.player.hasPerk(PerkLib.ChimericalBodySemiImprovedStageEx) || body.player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStageEx)
				 || body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx)) {
				bonus = score >= mutationThreshold && maxStage >= 1 ? +1 : 0;
				if (outputText != null) {
					var s1text:String = "";
					if (body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx)) s1text = "Epic";
					else if (body.player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStageEx)) s1text = "Superior";
					else s1text = "Improved"
					outputText("Chimerical Body: Semi-"+s1text+" (Ex) Stage", bonus);
				}
				score += bonus;
			}
			if (body.player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStage)) {
				bonus = score >= mutationThreshold && maxStage >= 2 ? +1 : 0;
				if (outputText != null) outputText("Chimerical Body: Semi-Superior Stage", bonus);
				score += bonus;
			}
			if (body.player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStageEx) || body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx)) {
				bonus = score >= mutationThreshold && maxStage >= 2 ? +1 : 0;
				if (outputText != null) {
					var s2text:String = "";
					if (body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx)) s2text = "Epic";
					else s2text = "Superior"
					outputText("Chimerical Body: Semi-"+s2text+" (Ex) Stage", bonus);
				}
				score += bonus;
			}
			if (body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStage)) {
				bonus = score >= mutationThreshold && maxStage >= 3 ? +1 : 0;
				if (outputText != null) outputText("Chimerical Body: Semi-Epic Stage", bonus);
				score += bonus;
			}
			if (body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx)) {
				bonus = score >= mutationThreshold && maxStage >= 3 ? +1 : 0;
				if (outputText != null) outputText("Chimerical Body: Semi-Epic (Ex) Stage", bonus);
				score += bonus;
			}
		}
		if (this != Races.HUMAN) {
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
		if (checkRP) {
			if (player.hasPerk(PerkLib.RacialParagon) && this != player.racialParagonSelectedRace()) {
				if (outputText != null) outputText("Racial Paragon", Math.min(-1, -score));
				return 0;
			}
			if (player.isGargoyle() && this != Races.GARGOYLE) {
				if (outputText != null) outputText("Gargoyle", -score);
				return 0;
			}
			if (player.hasPerk(PerkLib.ElementalBody) && this != Races.ELEMENTALFUSION) {
				if (outputText != null) outputText("Elemental", -score);
				return 0;
			}
		}
		if (score < 0) return 0;
        // TODO: Khovel - Find better place to check for race unlock...
        unlockRaceMetamorph(getTierNumber(body, score, checkRP));
		return score;
	}

	
	public function getTier(body:BodyData, score:int=-1, checkRP:Boolean = true):RaceTier {
		if (score < 0) score = this.totalScore(body, checkRP);
		var tier:RaceTier = null;
		var prev:Boolean = false;
		for each(var i:RaceTier in tiers) {
			if (i.requiresPreviousTier && !prev) continue;
			if (i.check(body, score)) {
				tier = i;
				prev = true;
			} else {
				prev = false;
			}
		}
		return tier;
	}
	public function getTierNumber(body:BodyData, score:int=-1, checkRP:Boolean = true):int {
		var tier:RaceTier = getTier(body, score, checkRP);
		if (!tier) return 0;
		return tier.tierNumber;
	}
	public function tier(tierNumber:int):RaceTier {
		return this.tiers[tierNumber-1];
	}
	public function maxTier():int {
		return (tiers.length === 0) ? 0 : tiers[tiers.length-1].tierNumber;
	}
	
	public function nameFor(body:BodyData, score:int=-1):String {
		if (score < 0) score = this.totalScore(body);
		var tier:RaceTier = getTier(body, score);
		if (tier) return tier.nameFor(body);
		if (tiers.length > 0) return tiers[0].nameFor(body);
		return name;
	}
	
	public function get minScore():int {
		if (this.tiers.length == 0) return 1;
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
			s += rr.getName();
			if (rr.varyingScore() && !pass) {
				// do not display (+X) for requirements that have varying values and
				// didn't pass, because value could be incorrect
				if (rscore <= -1000) {
					s += " [/font][font-red](required)";
				} else if (rscore != 0) {
					s += " [/font][font-red]("+rscore+" penalty)";
				}
			} else {
				var pscore:int = rr.passScore(body);
				s += " (" + (pscore>0?"+"+pscore:pscore)+")";
				if (rr.failScore < 0) {
					s += "[/font]"
					if (!pass && rscore == 0) {
						// failScore < 0, rscore == 0 - this happens if requirement was skipped due to minScore
						s += "[font-default]";
					} else if (!pass) {
						s += "[font-red]";
					} else if (rr.failScore <= -1000) {
						s += "[font-green]";
					} else {
						s += "[font-default]";
					}
					if (rr.failScore <= -1000) {
						s += " (required)"
					} else {
						s += " (" + rr.failScore + " penalty)";
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
			else if (change < 0) s += "[font-red]"
			else s += "[font-default]"
			s += reason+" ("+(change>0?"+"+change:change)+")";
			s += "[/font]\n";
		}
		score = finalizeScore(body, score, true, finalizerOutput);
		if (tiers.length>0) {
			s += "\t<b>Tiers:</b>\n";
		}
		var actualTier:RaceTier = getTier(body, score);
		for each(var tier:RaceTier in tiers) {
			s += "\t<b>";
			var present:Boolean = tier.check(body, score);
			if (tier == actualTier) {
				s += "[font-lblue]"+tier.nameFor(body);
			} else if (present) {
				s += "[font-green]"+tier.nameFor(body);
			} else {
				s += "[font-default]"+tier.name;
			}
			s += " ("+tier.minScore+")[/font] </b>";
			if (tier == actualTier) {
				s += "[font-lblue]"
			} else {
				s += "[font-default]"
			}
			s += tier.describeBuffs(present ? body : null);
			s += "[/font]";
			if (tier.requirements.length > 0) {
				s += '. Requires ';
				s += tier.requirements.map(Utils.varargify(function(rtr:RaceTierRequirement):String {
					// green: pass, red: pass core fail req, black: fail req
					//noinspection JSReferencingMutableVariableFromClosure
					return (score < tier.minScore ? "[font-default]" :
									rtr.check(body) ? "[font-green]" : "[font-red]") +
							rtr.name + "[/font]"
				})).join(", ");
				if (tier.requiresPreviousTier) {
					s += " and previous tier";
				}
				s+=".";
			} else if (tier.requiresPreviousTier) {
				s += ". Requires previous tier."
			}
			s += '\n';
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
		return {operator:"le",value:value};
	}
	protected static function AT_LEAST(value:Number):* {
		return {operator:"ge",value:value};
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
	protected function addBloodline(descendantPerk:PerkType, bloodlinePerk:PerkType):void {
		bloodlinePerks.push(descendantPerk);
		bloodlinePerks.push(bloodlinePerk);
	}
	protected function addMutation(mutation:IMutationPerkType, scorePerStage:int=+1):void {
		this.mutations.push([mutation,scorePerStage]);
	}
	protected function buildTier(minScore:int, name:String):RaceTierBuilder {
		return new RaceTierBuilder(this, tiers.length+1, minScore, name);
	}
	
	/**
	 * Key: debug form name
	 * Value: a list of elements of type:
	 * - function(player:Player):void
	 * - Transformation
	 * - StatusEffectType
	 * - IMutationPerkType
	 * - PerkType
	 * - array of form [StatusEffectType, value1, value2, value3, value4]
	 * - array of form [IMutationPerkType, stage]
	 * - array of form [PerkType, value1, value2, value3, value4]
	 */
	protected var debugForms:Object = {};
	public function debugFormNames():/*String*/Array {
		return Utils.keys(debugForms);
	}
	public function takeForm(player:Player, tfName:String):void {
		for each (var o:* in debugForms[tfName]) {
			var f:Function = o as Function;
			if (f != null) {
				f(player);
				continue;
			}
			var tf:Transformation = o as Transformation;
			if (tf) {
				if (tf.isPossible()) {
					tf.applyEffect();
				}
				continue;
			}
			var st:StatusEffectType = o as StatusEffectType;
			if (st) {
				player.createOrFindStatusEffect(st,0,0,0,0);
				continue;
			}
			var mt:IMutationPerkType = o as IMutationPerkType;
			if (mt) {
				mt.acquireMutation(player, "none", mt.maxLvl);
				continue;
			}
			var pt:PerkType = o as PerkType;
			if (pt) {
				if (!player.hasPerk(pt)) {
					player.createPerk(pt, 0, 0, 0, 0);
				}
				continue;
			}
			var a:Array = o as Array;
			if (a && a.length>0) {
				st = a[0] as StatusEffectType;
				if (st && a.length == 5) {
					var sec:StatusEffectClass = player.createOrFindStatusEffect(st,a[1],a[2],a[3],a[4]);
					sec.value1 = a[1];
					sec.value2 = a[2];
					sec.value3 = a[3];
					sec.value4 = a[4];
					continue;
				}
				
				mt = o[0] as IMutationPerkType;
				if (mt && a.length == 2) {
					mt.acquireMutation(player, "none", a[1]);
					continue;
				}
				pt = a[0] as PerkType;
				if (pt && a.length == 5) {
					var pc:PerkClass = player.getPerk(pt);
					if (!pc) {
						player.createPerk(pt,a[1],a[2],a[3],a[4]);
					} else {
						pc.value1 = a[1];
						pc.value2 = a[2];
						pc.value3 = a[3];
						pc.value4 = a[4];
					}
					continue;
				}
			}
			trace("[ERROR] In "+name+".transform() element "+o);
		}
	}

    public function unlockRaceMetamorph(tier:int = 0):void{
        //if(tier > 0 && tfRace > 0 && tier == maxTier())
        //     Metamorph.unlockMetamorphMastery(RaceMem.getMemory(tfRace));
    }
	public function initRaceMemory(name:String, raceBody:/*String*/Array):void{
        if(raceBody.length > 1)
            tfRace = RaceMem.appendEnumVal(name, RaceTransformations.raceTransform(name, raceBody, this));
    }


    protected function get game():CoC {
		return CoC.instance;
	}
    }
}
