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
	public var buffs:Object;
	
	public function RaceTier(
			tierNumber:int,
			name:String,
			nameFn:Function,
			minScore:int,
			buffs:Object,
			requirements:/*RaceTierRequirement*/Array
	) {
		this.tierNumber = tierNumber;
		this.name = name;
		this.nameFn = nameFn;
		this.minScore = minScore;
		this.buffs = buffs
		this.requirements = requirements.slice();
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
	
	public function hasBuffs():Boolean {
		for (var key:String in buffs) {
			return true;
		}
		return false;
	}
	public function describeBuffs(separator:String = ", "):String {
		var s:Array = [];
		for (var key:String in buffs) {
			s.push(StatUtils.explainBuff(key,buffs[key]));
		}
		if (s.length > 0) {
			return Utils.mergeSentences(s, separator, separator);
		}
		return "";
	}
}
}
