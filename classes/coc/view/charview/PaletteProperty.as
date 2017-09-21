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
	private var lookupNames:/*String*/Array;

	public function PaletteProperty(name:String, expr:String,defaultt:uint,lookupNames:/*String*/Array) {
		this.name = name;
		this.srcfn = Eval.compile(expr);
		this.defaultt = defaultt;
		this.lookupNames = lookupNames.slice(0);
	}

	public function sourceValue(src:Object):* {
		return srcfn.call(src);
	}
	public function colorValue(src:Object,lookupObjects:Object):uint {
		var sv:String = String(sourceValue(src));
		return lookup(sv,lookupObjects);
	}
	public function lookup(sv:String,lookupObjects:Object):uint {
		if (sv.charAt(0) == '$') return Color.convertColor(sv.substr(1));
		for each (var ln:String in lookupNames) {
			var lookup:Object = lookupObjects[ln];
			if (lookup && sv in lookup) return Color.convertColor(lookup[sv]);
		}
		return defaultt;
	}
}
}
