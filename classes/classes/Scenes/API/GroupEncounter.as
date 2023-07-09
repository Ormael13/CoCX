/**
 * Created by aimozg on 26.03.2017.
 */
package classes.Scenes.API {
import classes.internals.Utils;

public class GroupEncounter implements Encounter {
	protected var components:Array;// of Encounter
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

	public function encounterChance():Number {
		var sum:Number = 0;
		for each (var encounter:Encounter in components) sum += encounter.encounterChance();
		return sum;
	}
}
}
