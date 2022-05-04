package classes.internals.race {
import classes.BodyData;

public class CustomRacialRequirement extends RacialRequirement{
	private var scoreFn:Function;
	
	/**
	 *
	 * @param group
	 * @param name
	 * @param checkFn (body)=>Boolean
	 * @param scoreFn (body)=>int
	 * @param minScore
	 */
	public function CustomRacialRequirement(
			group:String,
			name:String,
			checkFn:Function,
			scoreFn:Function,
			minScore:int
	) {
		super(
				group,
				name,
				checkFn,
				0,
				minScore
		);
		this.scoreFn = scoreFn;
	}
	
	override public function score(body:BodyData):int {
		return scoreFn(body);
	}
}
}
