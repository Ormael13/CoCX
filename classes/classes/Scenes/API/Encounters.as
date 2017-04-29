/**
 * Created by aimozg on 26.03.2017.
 */
package classes.Scenes.API {
import classes.CoC_Settings;

public class Encounters {

	// =================================================================================================================
	//      ENCOUNTER BUILDERS
	// =================================================================================================================

	/**
	 * A complex() encounter executes one of its components, and has its own chance
	 * Unlike group(), complex() encounter chance does not depend on its components
	 * * an ALWAYS component won't affect the complex encounter own chance
	 * * components can have any scale
	 * complex() should be used to list variations of an encounter; however, the upper level encounter can
	 * be of any type (since its chance isn't taken into account)
	 * @param chance: Number or function():Number
	 * @param components: Array of Encounter's. First component may be this complex encounter name
	 */
	public static function complex(chance:*,...components):ComplexEncounter {
		if (components[0] is String) return new ComplexEncounter(components[0],chance,components.slice(1));
		if (components.length==1) return new ComplexEncounter((components[0] as Encounter).encounterName(),chance,components);
		return new ComplexEncounter("complex{"+components.length+"}",chance,components);
	}

	/**
	 * A group() encounter executes one of its components, and has no own chance
	 * Unlike complex(), a group() encounter chance directly depends on its components (sum of components')
	 * * an ALWAYS component chance will raise group's own chance to ALWAYS
	 * * components should have same scale as the upper level encounter (if any)
	 * group() should be used to union encounters in one place and add them as sub-components at once
	 * @param components Array of Encounter's or build def's. First component may be this group encounter name
	 */
	public static function group(...components):GroupEncounter {
		if (components[0] is String) return new GroupEncounter(components[0],components.slice(1));
		if (components.length==1) return new GroupEncounter((components[0] as Encounter).encounterName(),components);
		return new GroupEncounter("group{"+components.length+"}",components);
	}

	/**
	 * Multiply encounter chance
	 */
	public static function wrap2(encounter:Encounter,chances:Array):Encounter {
		if (chances.length==0) return encounter;
		return new SimpleEncounter(encounter.encounterName(),
				fn.product(chances.concat([function():Number{return encounter.encounterChance();}])),
				function():void{encounter.execEncounter()}// < wrap in case it uses `this`
		);
	}


	// =================================================================================================================
	//      CONDITIONS AND CHANCES HELPER FUNCTIONS
	// =================================================================================================================

	public static const ALWAYS:Number = Number.POSITIVE_INFINITY;
	//noinspection JSUntypedDeclaration
	public static const fn: FnHelpers = FnHelpers.FN;

	// =================================================================================================================
	//      EVERYTHING ELSE
	// =================================================================================================================

	/**
	 * Runs the encounter selection check. DOES NOT call .execute()
	 * Returns null if all encounters have chance <= 0
	 */
	public static function selectOrNull(encounters:Array):Encounter {
		var items:Array = [];
		var sum:Number = 0;
		var strace:String = "selecting from";
		var i:int;
		var name:String;
		for (i=0;i<encounters.length;i++) {
			var e:Encounter            = encounters[i];
			name = e.encounterName() || ("#" + i);
			debug_callsite = name;
			var c:Number               = e.encounterChance();
			debug_callsite             = "";
			strace += " " + name + "=" + ch2str(c);
			if (c >= ALWAYS) {
				trace(debug_indent + strace);
				trace(debug_indent + "-> picked encounter " + name + " with chance ALWAYS of total (unknown)");
				return e;
			}
			if (c > 0) {
				sum += c;
				items.push([e, c, i]);
			}
		}
		trace(debug_indent+strace);

		var random:Number = Math.random()*sum;
		strace = "-> random[0.." + ch2str(sum) + "]=" + ch2str(random);
		while(items.length>0) {
			var eci:Array = items.shift();
			e = eci[0];
			c = eci[1];
			i = eci[2];
			random -= c;
			name = e.encounterName()||("#"+i);
			strace += " -" + name + "=" + ch2str(random);
			if (random<=0) {
				//strace += "<0 HIT";
				//trace(debug_indent + strace);
				trace(debug_indent + "-> picked encounter " + name + " with chance " + ch2str(c) + " of total " + ch2str(sum));
				return e;
			}
		}
		trace(strace);
		trace("WARNING Encounters.selectOrNull found no encounter");
		return null;
	}
	internal static var debug_indent:String = "";
	/**
	 * Runs the encounter selection check. DOES NOT call .execute()
	 * Returns last if all encounters have chance <= 0.
	 * Throws an error if there are 0 encounters
	 */
	public static function select(encounters:Array):Encounter {
		return selectOrNull(encounters) || encounters[encounters.length-1];
	}

	/**
	 * @param def An encounter definition object with properties:
	 * name:string - used for debugging
	 * call:function():void or Encounter - encounter code itself, or encounter to wrap with
	 * chance:Number or function():Number -  weight of the encounter among others. default 1.0.
	 * 0 is "never" and fn.ALWAYS (shortcut for Number.POSITIVE_INFINITY) is "ignore others"
	 * when:function():Boolean - additional requirement. default always true. "false" skips encounter no matter the `chance`
	 * mods: Array of chances - additional multipliers for resulting chance
	 */
	public static function build(def:*):Encounter {
		var name:String = def.name||"";
		var chance:* = def.chance;
		var when:* = def.when;
		var mods:* = def.mods;
		var call:* = def.call;
		if (mods === null || mods === undefined) mods = [];
		if (!(mods is Array)) {
			CoC_Settings.error("Bad def.mods "+(typeof mods)+" in "+name);
			mods = [1];
		}
		if (chance !== null && chance !== undefined) {
			if (!isChance(chance)) {
				CoC_Settings.error("Bad def.chance "+(typeof chance)+" in "+name);
			} else mods.push(chance);
		}
		if (when !== null && when !== undefined) {
			if (!isChance(when)) {
				CoC_Settings.error("Bad def.when "+(typeof when)+" in "+name);
			} else mods.push(when);
		}
		if (call is Encounter) {
			return wrap2(call,mods);
		} else {
			if (!(call is Function)) {
				CoC_Settings.error("Bad def.call " + (typeof call) + " in " + name);
			}
			return new SimpleEncounter(name,fn.product(mods), call);
		}
	}

	/**
	 * Calculates/converts a chance
	 * Number -> returned
	 * Function -> executed, result recursively converted
	 * Boolean -> converted
	 */
	public static function convertChance(chance:*):Number {
		while (!(chance is Number)) {
			if (chance === undefined || chance === null) {
				trace("WARNING chance is "+chance+(debug_callsite?" at ":debug_callsite)+"; using 1 as default");
				return 1;
			}
			if (chance is Array) {
				CoC_Settings.error("Array chance argument (rest args?)");
				chance = chance[0];
			} else if (chance is Function) chance = chance();
			else if (chance is Boolean) chance = chance?1:0;
			else {
				CoC_Settings.error("Bad chance of type "+typeof chance+(debug_callsite?" at "+debug_callsite:""));
				return 1;
			}
		}
		return chance;
	}
	public static function isChance(chance:*):Boolean {
		return chance is Function || chance is Number || chance is Boolean;
	}
	private static var debug_callsite:String = "";
	internal static function ch2str(n:Number):String {
		if (n == Number.POSITIVE_INFINITY) return "ALWAYS";
		//if (n <= 0) return "0";
		return n.toFixed(3).replace(/\.?0+$/,"");
	}
}}
