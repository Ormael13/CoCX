package classes.Transformations {
import classes.CoC_Settings;

/**
 * Wrapper for several TFs organized into queue.
 * Every TF in queue requires all previous steps to be completed.
 *
 * Application: first possible TF
 * IsPresent: if all are present
 * IsPossible: if any is possible
 *
 * Use OrderedTransformation when you group DIFFERENT PART tfs and want to establish an order.
 * Use GradualTransformation when you have tfs of SAME PART and want them to happen one-by-one.
 */
public class OrderedTransformation extends Transformation {
    
    public var tfs: /*Transformation*/Array;
    public var tierCount: int;
    public var compatible: Boolean;
    
    public function OrderedTransformation(
            name:String,
            tfs: /*Transformation*/Array
    ) {
        super(name);
        this.tfs = tfs.slice();
        tierCount = tfs.length;
        if (tierCount === 0) throw new Error("Ordered TF "+name+" initialized with empty list");
        for each (var tf:Transformation in tfs) {
            if (!tf) throw new Error("Ordered TF "+name+" contains nulls");
        }
    }
    
    /**
     * @return int Last present tier, 0 if none
     */
    public function currentTier():int {
        var i:int = 0;
        while(i<tierCount) {
            if (!tfs[i].isPresent()) return i;
            i++;
        }
        return tierCount;
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
            CoC_Settings.error("Ordered TF "+name+" apply called at max tier");
            return;
        }
        tf.applyEffect(doOutput);
    }
    
    public function toString():String {
        return "OrderedTrasformation('"+name+"', ["+mapOneProp(tfs,"name").join(", ")+"])"
    }
}
}
