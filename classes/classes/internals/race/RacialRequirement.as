package classes.internals.race {
import classes.BodyData;

public class RacialRequirement {
	
	public var group:String;
	public var name:String;
	/**
	 * `(bodyData) => boolean`
	 */
	public var checkFn:Function;
	private var _score:int;
	public var failScore:int;
	public var minScore:int;
	
	/**
	 * @param group ex. "face"
	 * @param name ex. "Wolf"
	 * @param check `(body:BodyData) => boolean`
	 * @param score points if check passed
	 * @param failScore points if check failed
	 * @param minScore
	 */
	public function RacialRequirement(
			group: String,
			name: String,
			check: Function,
			score: int,
			failScore: int,
			minScore: int
	) {
		this.group = group;
		this.name = name;
		this.checkFn = check;
		this._score = score;
		this.failScore = failScore;
		this.minScore = minScore;
	}
	public function passScore(body:BodyData): int {
		return _score;
	}
	public function varyingScore():Boolean {
		return false;
	}
	
	public function check(body:BodyData, currentScore:int):Boolean {
		return (minScore === 0 || currentScore >= minScore) && checkFn(body);
	}
	public function calcScore(body: BodyData, currentScore:int):int {
		if (minScore > 0 && currentScore < minScore) return 0;
		return check(body, currentScore) ? passScore(body) : failScore;
	}
	public function describe(body: BodyData):String {
		var score:int = this.passScore(body);
		return name+" ("+(score>0?"+"+score:score)+")";
	}
	
	public function withCondition(conditionFn:Function, conditionName:String):RacialRequirement {
		return new RacialRequirement(
				group,
				conditionName+" "+name,
				function(body:BodyData):Boolean {
					return conditionFn(body) && checkFn(body);
				},
				_score,
				failScore,
				minScore
		)
	}
	
	/**
	 * Group multiple requirements as a single one. Uses score of first.
	 * @param nameSeparator string to join description, ex. " and " -> "fox ears and naga tail"
	 */
	public static function joinAnd(
			group:String,
			nameSeparator:String,
			req1:RacialRequirement,
			...rest:/*RacialRequirement*/Array
	): RacialRequirement {
		var names:/*String*/Array = [req1.name];
		var checkfns:/*Function*/Array = [req1.checkFn];
		for each(var i:RacialRequirement in rest) {
			names.push(i.name);
			checkfns.push(i.checkFn);
		}
		return new RacialRequirement(
				group,
				names.join(nameSeparator),
				function(body:BodyData):Boolean {
					for each (var fn:Function in checkfns) {
						if (!fn(body)) return false;
					}
					return true;
				},
				req1._score,
				req1.failScore,
				req1.minScore
		)
	}
}
}
