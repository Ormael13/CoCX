package classes.Transformations {
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
}
}
