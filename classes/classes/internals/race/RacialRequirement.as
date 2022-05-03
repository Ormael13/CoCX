package classes.internals.race {
import classes.BodyData;

public class RacialRequirement {
	public var group:String;
	public var name:String;
	/**
	 * `(bodyData, currentScore) => boolean`
	 */
	public var checkFn:Function;
	public var score:int;
	public var minScore:int;
	
	/**
	 * @param group ex. "face"
	 * @param name ex. "Wolf"
	 * @param check `(body:BodyData, score:int) => boolean`
	 * @param score
	 * @param minScore
	 */
	public function RacialRequirement(
			group: String,
			name: String,
			check: Function,
			score: int,
			minScore: int
	) {
		this.group = group;
		this.name = name;
		this.checkFn = check;
		this.score = score;
		this.minScore = minScore;
	}
	
	public function check(body:BodyData, currentScore:int):Boolean {
		return currentScore >= minScore && checkFn(body, currentScore);
	}
	public function getScore(body: BodyData, currentScore:int):int {
		return check(body, currentScore) ? score : 0;
	}
	public function describe(withGroup:Boolean=false):String {
		return (withGroup&&group?group+": ":"")+name+"("+(score>0?"+"+score:score)+")";
	}
	
	public function withCondition(conditionFn:Function, conditionName:String):RacialRequirement {
		return new RacialRequirement(
				group,
				name+conditionName,
				function(body:BodyData, score:int):Boolean {
					return conditionFn(body, score) && checkFn(body,score);
				},
				score,
				minScore
		)
	}
}
}
