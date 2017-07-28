/**
 * Coded by aimozg on 28.07.2017.
 */
package coc.view.charview {
import coc.script.Eval;
import coc.view.Color;

public class PaletteProperty {
	public var name:String;
	private var srcfn:Eval;
	private var defaultt:uint;
	private var lookups:/*Object*/Array;

	public function PaletteProperty(name:String, expr:String,defaultt:uint,lookups:/*Object*/Array) {
		this.name = name;
		this.srcfn = Eval.compile(expr);
		this.defaultt = defaultt;
		this.lookups = lookups.slice(0);
	}

	public function sourceValue(src:Object):* {
		return srcfn.call(src);
	}
	public function colorValue(src:Object):uint {
		var sv:String = String(sourceValue(src));
		return lookup(sv);
	}
	public function lookup(sv:String):uint {
		if (sv.charAt(0) == '$') return Color.convertColor(sv.substr(1));
		for each (var lookup:Object in lookups) {
			if (sv in lookup) return Color.convertColor(lookup[sv]);
		}
		return defaultt;
	}
}
}
