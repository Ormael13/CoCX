package classes.Transformations {
public class SimpleTransformation extends Transformation {
	private var applyTfFn:Function;
	private var isPresentFn:Function;
	private var isPossibleFn:Function;

	public function SimpleTransformation(
			name: String,
			applyTfFn:Function,
			isPresentFn:Function,
			isPossibleFn:Function = null
	) {
		super(name);
		this.applyTfFn = applyTfFn;
		this.isPresentFn = isPresentFn;
		this.isPossibleFn = isPossibleFn;
	}

	override public function isPresent():Boolean {
		return isPresentFn();
	}

	override public function isPossible():Boolean {
		return (isPossibleFn != null) ? isPossibleFn() : !isPresentFn();
	}

	override public function applyEffect(doOutput:Boolean = true):void {
		applyTfFn(doOutput);
	}
}
}
