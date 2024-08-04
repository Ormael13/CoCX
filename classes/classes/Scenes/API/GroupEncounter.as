/**
 * Created by aimozg on 26.03.2017.
 */
package classes.Scenes.API {
import classes.internals.Utils;

public class GroupEncounter implements Encounter {
	public var components:/*Encounter*/Array;
	protected var name:String;
	public function GroupEncounter(name:String, components:Array) {
		this.name = name;
		this.components = [];
		for each (var c:* in components) {
			add(c);
		}
	}

	public function encounterName():String {
		return name;
	}

	/**
	 * Builds and adds encounters.
	 * Sample usage:
	 * build({
	 *   name: "encounter1", call: function1,
	 *   chance: 0.2, when: Encounters.fn.ifMinLevel(5)
	 * },{
	 *   name: "encounter2",
	 *   call: function():void{},
	 *   chance: function():Number {}, // default 1
	  *  when: function():Boolean {} // default true
	 * })
	 * @param defs Array of defs objects or Encounter-s.
	 * @see Encounters.build
	 */
	public function add(...defs):GroupEncounter {
		for each (var def:* in defs) {
			if (def is GroupEncounter && !(def is ComplexEncounter)) Utils.pushAll(components, (def as GroupEncounter).components);
			else if (def is Encounter) components.push(def);
			else components.push(Encounters.build(def));
		}
		return this;
	}

	public function execEncounter():void {
		trace(Encounters.debug_indent+encounterName()+".execEncounter()");
		Encounters.debug_indent += "  ";
		Encounters.select(components).execEncounter();
		Encounters.debug_indent = Encounters.debug_indent.slice(2);
	}
	/**
	 * @param [filter] function(e:Encounter):boolean
	 * @return
	 */
	public function pickEncounter(filter:Function=null):Encounter {
		var e:Encounter = Encounters.select(components, filter);
		if (e is GroupEncounter) return (e as GroupEncounter).pickEncounter(filter);
		return e;
	}
	/**
	 * @param [filter] function(e:Encounter):boolean
	 * @return
	 */
	public function pickEncounterOrNull(filter:Function=null):Encounter {
		var e:Encounter = Encounters.selectOrNull(components, filter);
		if (e is GroupEncounter) return (e as GroupEncounter).pickEncounterOrNull(filter);
		return e;
	}
	
	public function findByName(name:String):SimpleEncounter {
		for each (var encounter:Encounter in components) {
			var se:SimpleEncounter = encounter as SimpleEncounter;
			if (se && se.encounterName() == name) return se;
			if (encounter is GroupEncounter) {
				se = (encounter as GroupEncounter).findByName(name);
				if (se) return se;
			}
		}
		return null;
	}

	public function encounterChance():Number {
		var sum:Number = 0;
		for each (var encounter:Encounter in components) {
			var chance:Number = encounter.encounterChance();
			if (chance >= Encounters.ALWAYS) return Encounters.ALWAYS;
			if (chance > 0) sum += chance;
		}
		return sum;
	}
	
	/**
	 * Return a copy of this group encounter with extra condition and chance multipliers
	 * @param when Extra condition. Can be null if not needed
	 * @param chances Chance multipliers. Can be null or empty array if not needed
	 * @return
	 */
	public function wrap(when:Function, chances:Array):GroupEncounter {
		var result:GroupEncounter = new GroupEncounter(name,[]);
		for each (var e:Encounter in components) {
			result.components.push(Encounters.wrap2(e, when, chances));
		}
		return result;
	}
	public function withCondition(when:Function):GroupEncounter {
		return wrap(when,null);
	}
	public function withChanceFactor(chance:*):GroupEncounter {
		return wrap(null, [chance]);
	}
}
}
