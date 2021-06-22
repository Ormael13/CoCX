package classes.Transformations {
public class SimpleEffect extends PossibleEffect {
	private var applyTfFn:Function;
	private var isPossibleFn:Function;
	
	public function SimpleEffect(
			name:String,
			applyTfFn:Function,
			isPossibleFn:Function = null
	) {
		super(name);
		this.applyTfFn    = applyTfFn;
		this.isPossibleFn = isPossibleFn;
	}
	
	override public function isPossible():Boolean {
		return (isPossibleFn != null) ? isPossibleFn() : true;
	}
	
	override public function applyEffect(doOutput:Boolean = true):void {
		applyTfFn(doOutput);
	}
}
}
