package classes.Transformations {
public class StatChangeEffect extends Transformation {
	private var applyTfFn:Function;

	public function StatChangeEffect(
			name: String,
			applyTfFn:Function
	) {
		super(name);
		this.applyTfFn = applyTfFn;
	}

	override public function isPresent():Boolean {
		return true;
	}

	override public function isPossible():Boolean {
		return true;
	}

	override public function applyEffect(doOutput:Boolean = true):void {
		applyTfFn(doOutput);
	}
}
}
