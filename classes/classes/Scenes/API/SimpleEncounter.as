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
			CoC_Settings.error("Encounters.make(name="+name+", weight=" + (typeof weight) + ")");
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
		return !(_whenFn is Function && !_whenFn()) && originalChance() > 0;
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
	
	/**
	 * Return a copy of this encounter with extra condition and chance multipliers.
	 * @param when Extra condition. Can be null if not needed
	 * @param chances Chance multipliers. Can be null or empty array if not needed
	 * @return
	 */
	public function wrap(whenFn:Function,chances:Array):SimpleEncounter {
		if (whenFn != null) {
			if (this._whenFn != null) whenFn = FnHelpers.FN.all(whenFn, this._whenFn)
		} else whenFn = this._whenFn;
		var result:SimpleEncounter = new SimpleEncounter(
				name,
				whenFn,
				!chances || chances.length == 0 ? this._weight : FnHelpers.FN.product(chances.concat(this._weight)),
				this._body
		);
		for (var key:String in this) {
			if (!(key in result)) result[key] = this[key];
		}
		return result;
	}
	public function getKind():String {
		var kind:* = null;
		if ('kind' in this) kind = this['kind'];
		if (kind is Function) kind = kind();
		return kind ? String(kind).toLowerCase() : "";
	}
	public function getLabel():String {
		var label:* = getTooltipHeader();
		if ('shortLabel' in this) label = this['shortLabel'];
		if (label is Function) label = label();
		return String(label);
	}
	public function getTooltipHint():String {
		var hint:* = 'Trigger this encounter.';
		if ('hint' in this) hint = this['hint'];
		if (hint is Function) hint = hint();
		return String(hint);
	}
	public function getTooltipHeader():String {
		var hint:* = Utils.capitalizeFirstLetter(encounterName());
		if ('label' in this) hint = this['label'];
		if (hint is Function) hint = hint();
		return String(hint);
	}
}
}
