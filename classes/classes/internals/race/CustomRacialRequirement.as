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
			failScore:int,
			minScore:int
	) {
		super(
				group,
				name,
				checkFn,
				0,
				failScore,
				minScore
		);
		this.scoreFn = scoreFn;
	}
	
	override public function passScore(body:BodyData):int {
		return scoreFn(body);
	}
	
	override public function varyingScore():Boolean {
		return true;
	}
}
}
