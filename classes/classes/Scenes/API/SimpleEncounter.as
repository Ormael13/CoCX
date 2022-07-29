/*
 * Created by aimozg on 26.03.2017.
 */
package classes.Scenes.API {
import classes.CoC_Settings;
import classes.internals.Utils;

public dynamic class SimpleEncounter implements Encounter {
	private var _weight:*;
	private var _whenFn:Function;
	private var name:String;
	private var _body:Function;
	public var adjustment:Number = 0; // added to the chance
	
	public function SimpleEncounter(name:String, whenFn:Function, weight:*, body:Function) {
		if (!(weight is Function) && !(weight is Number)) {
			CoC_Settings.error("Encounters.make(weight=" + (typeof weight) + ")");
			weight = 100;
		}
		this.name = name;
		this._weight = weight;
		this._whenFn = whenFn;
		this._body = body;
	}

	// chance or 0 if cannot happen
	public function encounterChance():Number {
		if (!canHappen()) return 0;
		return adjustedChance();
	}
	
	public function canHappen():Boolean {
		return !(_whenFn is Function && !_whenFn());
	}
	
	public function adjustedChance():Number {
		return Utils.round(originalChance() + adjustment, 2);
	}
	
	public function originalChance():Number {
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
