package classes.Transformations {
import classes.BaseContent;

/**
 * Abstract superclass for applicable effects that have a condition (for example, transformative effects)
 */
public class PossibleEffect extends BaseContent {
	
	/**
	 * Name (for display and debugging)
	 */
	public var name: String;
	
	public function PossibleEffect(name:String) {
		this.name = name;
	}
	public function isPossible():Boolean {
		return true;
	}
	
	/**
	 * Apply effect the effect to player.
	 * If doOutput is false, do not print any text.
	 * Should not do clearOutput or setup any menus!
	 */
	public function applyEffect(doOutput:Boolean = true):void {
	}
}
}
