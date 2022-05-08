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
	 */
	public function buffs(body:BodyData):Object {
		return _buffs;
	}
	public function hasBuffs():Boolean {
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
