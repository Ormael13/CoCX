package classes.Transformations {
import classes.EngineCore;
import classes.internals.Utils;

public class TransformationUtils {
	function TransformationUtils() {
	}
    
    public static function allPresent(transformations: /*Transformation*/Array): Boolean {
        return transformations.every(function(tf:Transformation, ...args):Boolean {
            return tf.isPresent();
        });
    }
    public static function anyPresent(transformations: /*Transformation*/Array): Boolean {
        return transformations.some(function(tf:Transformation, ...args):Boolean {
            return tf.isPresent();
        })
    }
    public static function anyPossible(transformations: /*PossibleEffect*/Array): Boolean {
        return transformations.some(function(tf:PossibleEffect, ...args):Boolean {
            return tf.isPossible();
        })
    }
    public static function missingTfs(transformations: /*Transformation*/Array): /*Transformation*/Array {
        return transformations.filter(function(tf:Transformation, ...args):Boolean {
            return !tf.isPresent();
        })
    }
    public static function possibleEffects(transformations: /*PossibleEffect*/Array): /*PossibleEffect*/Array {
        return transformations.filter(function(tf:PossibleEffect, ...args):Boolean {
            return tf.isPossible();
        })
    }
    public static function randomPossibleEffect(transformations: /*PossibleEffect*/Array): PossibleEffect {
        var choices:/*PossibleEffect*/Array = possibleEffects(transformations);
        if (choices.length === 0) {
            trace("No possible effects!")
            return null;
        }
        var choice: PossibleEffect = Utils.randomChoice(choices);
        trace("Picked "+choice.name+" out of "+Utils.mapOneProp(transformations,'name').join(", "));
        return choice;
    }
    
    /**
     * Pick `count` effects from `effects` array (if `allowDuplicates` is false, don't pick them twice) and apply
     * their effects.
     * @return Number of effects applied
     */
    public static function pickAndRunMultipleEffects(effects: /*PossibleEffect*/Array, count:int, allowDuplicates:Boolean, doOutput:Boolean, textSeparator:String = '\n\n'):int {
        if (!allowDuplicates) effects = effects.slice();
        var result:int = 0;
        while (count --> 0) {
            var tf:PossibleEffect = randomPossibleEffect(effects);
            if (!tf) break;
            if (doOutput) EngineCore.outputText(textSeparator);
            tf.applyEffect(doOutput);
            if (!allowDuplicates) effects.splice(effects.indexOf(tf), 1);
            result++;
        }
        return result;
    }
}
}
