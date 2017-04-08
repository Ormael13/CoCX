/**
 * Created by aimozg on 26.03.2017.
 */
package classes.Scenes.API {
public class ComplexEncounter extends GroupEncounter {
	private var _chance:*;

	/**
	 * @param chance Number, Boolean, or function() returning Number|Boolean,
	 * @param components Array of Encounter-s
	 */
	public function ComplexEncounter(name:String,chance:*,components:Array) {
		super(name,components);
		this._chance = chance;
	}

	override public function encounterChance():Number {
		return Encounters.convertChance(_chance);
	}

}
}
