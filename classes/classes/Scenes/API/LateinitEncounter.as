/**
 * Created by aimozg on 01.04.2017.
 */
package classes.Scenes.API {

/**
 * A lazily initialized (on first access) Encounter wrapper
 */
public class LateinitEncounter implements Encounter {

	protected var _proxied:Encounter = null;
	protected var scope:Object = null;
	protected function get proxied():Encounter {
		return _proxied ||= createEncounter.apply(scope);
	}
	protected var createEncounter:Function;

	public function encounterChance():Number {
		return proxied.encounterChance();
	}

	public function execEncounter():void {
		proxied.execEncounter();
	}

	public function encounterName():String {
		return proxied.encounterName();
	}

	/**
	 *
	 * @param scope: A "this" object that is implicitly or explicitly used in function
	 * @param createEncounterFn: A function that constructs an Encounter.
	 */
	public function LateinitEncounter(scope:Object,createEncounterFn:Function) {
		this.createEncounter = createEncounterFn;
		this.scope = scope;
	}
}
}
