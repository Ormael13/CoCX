package classes.Transformations {
/**
 * TFs grouped with "OR".
 * - is present - all present
 * - is possible - any possible
 * - apply effect - pick random possible
 */
public class TransformationGroupAll extends Transformation {
    public var tfs: /*Transformation*/Array;
    
    public function TransformationGroupAll(
            name:String,
            tfs:/*Transformation*/Array
    ) {
        super(name);
        if (tfs.length === 0) throw new Error("Group TF "+name+" initialized with empty list");
        this.tfs = tfs;
    }
    
    override public function isPresent():Boolean {
        for each (var tf:Transformation in tfs) {
            if (!tf.isPresent()) return false;
        }
        return true;
    }
    
    override public function isPossible():Boolean {
        for each (var tf:Transformation in tfs) {
            if (tf.isPossible()) return true;
        }
        return false;
    }
    
    override public function applyEffect(doOutput:Boolean = true):void {
        var tf:PossibleEffect = TransformationUtils.randomPossibleEffect(tfs);
        if (tf) tf.applyEffect(doOutput);
    }
}
}
