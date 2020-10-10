package classes.internals {
/**
 * Object that contains state that should be written to & read from save file.
 *
 * Register it in Saves.registerSaveableState
 *
 * When no related data is found, `null` is passed to loadFromObject. Take care.
 */
public interface SaveableState extends Jsonable {
	/**
	 * @return unique name for this object (e.g. NPC or scene name). Should never change across versions!
	 */
	function stateObjectName():String;
	
	/**
	 * Reset to "new game" state
	 */
	function resetState():void;
}
}
