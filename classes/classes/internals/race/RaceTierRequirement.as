package classes.internals.race {
import classes.BodyData;

public class RaceTierRequirement {
	public var name:String;
	/**
	 * `(body:BodyData)=>Boolean`
	 */
	private var checkFn:Function;
	
	/**
	 * @param name
	 * @param checkFn `(body)=>Boolean`
	 */
	public function RaceTierRequirement(
			name:String,
			checkFn:Function
	) {
		this.name = name;
		this.checkFn = checkFn;
	}
	
	public function check(bodyData:BodyData):Boolean {
		return checkFn(bodyData);
	}
}
}
