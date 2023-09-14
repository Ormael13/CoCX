package classes.Transformations {
/**
 * TFs grouped with "OR".
 * - is present - any present
 * - is possible - any possible
 * - apply effect - pick random possible
 */
public class TransformationGroupAny extends Transformation {
	
	public var tfs: /*Transformation*/Array;
	
	public function TransformationGroupAny(
			name:String,
			tfs:/*Transformation*/Array
	) {
		super(name);
		if (tfs.length === 0) throw new Error("Group TF "+name+" initialized with empty list");
		this.tfs = tfs;
	}
	
	override public function isPresent():Boolean {
		for each (var tf:Transformation in tfs) {
			if (tf.isPresent()) return true;
		}
		return false;
	}
	
	override public function isPossible():Boolean {
		var anyPossible:Boolean = false;
		for each (var tf:Transformation in tfs) {
			if (tf.isPresent()) return false;
			if (tf.isPossible()) anyPossible = true;
		}
		return anyPossible;
	}
	
	override public function applyEffect(doOutput:Boolean = true):void {
		var tf:PossibleEffect = TransformationUtils.randomPossibleEffect(tfs);
		if (tf) tf.applyEffect(doOutput);
	}
}
}
