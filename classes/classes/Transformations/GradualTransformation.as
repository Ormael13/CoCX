package classes.Transformations {
import classes.CoC_Settings;

/**
 * Wrapper for several TFs organized into queue.
 * Every TF in queue requires previous step to be completed.
 *
 * Application: next TF after last present.
 * IsPresent: if last tier is present.
 * IsPossible: if next tier above first missing is possible.
 *
 * Use OrderedTransformation when you group DIFFERENT PART tfs and want to establish an order.
 * Use GradualTransformation when you have tfs of SAME PART and want them to happen one-by-one.
 */
public class GradualTransformation extends Transformation {
	
	public var tfs: /*Transformation*/Array;
	public var tierCount: int;
	
	public function GradualTransformation(
			name:String,
			tfs: /*Transformation*/Array
	) {
		super(name);
		this.tfs = tfs.slice();
		tierCount = tfs.length;
		if (tierCount === 0) throw new Error("Multi-tier TF "+name+" initialized with empty list");
		for each (var tf:Transformation in tfs) {
			if (!tf) throw new Error("Multi-tier TF "+name+" contains nulls");
		}
	}
	
	/**
	 * @return int Max tier (starting 1) of present TF. 0 if no tier present
	 */
	public function currentTier():int {
		var i:int = tierCount;
		while(i-->0) {
			if (tfs[i].isPresent()) return (i+1);
		}
		return 0;
	}
	
	/**
	 * @return Transformation Next transformation, or null if at max tier
	 */
	public function nextTierTf():Transformation {
		var i:int = currentTier(); // current tier = index of next
		if (i < tierCount) return tfs[i];
		return null;
	}
	
	override public function isPresent():Boolean {
		return tfs[tfs.length-1].isPresent();
	}
	
	override public function isPossible():Boolean {
		var tf:Transformation = nextTierTf();
		return tf && tf.isPossible();
	}
	
	override public function applyEffect(doOutput:Boolean = true):void {
		var tf:Transformation = nextTierTf();
		if (!tf) {
			CoC_Settings.error("Multi-tier TF "+name+" apply called at max tier");
			return;
		}
		tf.applyEffect(doOutput);
	}
	
	public function toString():String {
		return "MultiTierTrasformation('"+name+"', ["+mapOneProp(tfs,"name").join(", ")+"])"
	}
}
}
