package classes {
import classes.Stats.StatUtils;
import classes.internals.Utils;
import classes.internals.race.RaceTierRequirement;

public class RaceTier {
	
	public var tierNumber:int;
	public var requirements:/*RaceTierRequirement*/Array;
	public var name:String;
	private var nameFn:Function;
	public var minScore:int;
	protected var _buffs:Object;
	public var extraBonuses:/*String*/Array;
	public var requiresPreviousTier:Boolean = false;
	
	public function RaceTier(
			tierNumber:int,
			name:String,
			nameFn:Function,
			minScore:int,
			buffs:Object,
			requirements:/*RaceTierRequirement*/Array,
			extraBonuses:/*String*/Array
	) {
		var thiz:RaceTier = this;
		this.tierNumber = tierNumber;
		this.name = name;
		this.nameFn = nameFn || function(body:BodyData):String { return thiz.name };
		this.minScore = minScore;
		this._buffs = buffs
		this.requirements = requirements.slice();
		this.extraBonuses = extraBonuses.slice();
	}
	
	public function nameFor(body:BodyData):String {
		return nameFn(body);
	}
	
	public function check(body:BodyData, score:int):Boolean {
		if (score < minScore) return false;
		for each(var r:RaceTierRequirement in requirements) {
			if (!r.check(body)) return false;
		}
		return true;
	}
	
	/**
	 * @param body null if player doesn't have this tier, otherwise player body data
	 * @return buffs, NG+ scaled
	 */
	public function buffs(body:BodyData):Object {
		var buffs:Object = unscaledBuffs(body);
		var factor:Number = CoC.instance.newGamePlusFactor();
		if (factor == 1) return buffs;
		for each(var buffName:String in StatUtils.NgScaledRacialBuffs) {
			if (buffName in buffs) buffs[buffName] *= factor;
		}
		return buffs;
	}
	/**
	 * @param body null if player doesn't have this tier, otherwise player body data
	 * @return buffs, not NG+ scaled. The object could be modified, so a copy should be returned.
	 */
	public function unscaledBuffs(body:BodyData):Object {
		return Utils.extend({}, _buffs);
	}
	public function hasBuffs():Boolean {
		if (extraBonuses.length > 0) return true;
		//noinspection LoopStatementThatDoesntLoopJS
		for (var key:String in _buffs) {
			return true;
		}
		return false;
	}
	public function describeBuffs(body:BodyData, separator:String = ", ", withExtraBonuses:Boolean = true):String {
		var s:Array = [];
		var buffs:Object = this.buffs(body);
		for (var key:String in buffs) {
			s.push(StatUtils.explainBuff(key,buffs[key]));
		}
		if (withExtraBonuses) Utils.pushAll(s, extraBonuses);
		if (s.length > 0) {
			return s.join(separator);
		}
		return "";
	}
}
}
