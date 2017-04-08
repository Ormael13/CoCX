/*
 * Created by aimozg on 26.03.2017.
 */
package classes.Scenes.API {
import classes.CoC_Settings;

public class SimpleEncounter implements Encounter {
	private var _weight:*;
	private var name:String;
	private var _body:Function;
	public function SimpleEncounter(name:String,weight:*, body:Function) {
		if (!(weight is Function) && !(weight is Number)) {
			CoC_Settings.error("Encounters.make(weight=" + (typeof weight) + ")");
			weight = 100;
		}
		this.name = name;
		this._weight = weight;
		this._body = body;
	}

	public function encounterChance():Number {
		if (_weight is Function) return _weight();
		return _weight;
	}

	public function execEncounter():void {
		var rslt:* = _body();
		if (rslt !== null && rslt !== undefined) {
			trace("WARNING SimpleEncounter returned "+rslt+" ("+(typeof rslt)+"), value ignored")
		}
	}

	public function encounterName():String {
		return name;
	}
}
}
