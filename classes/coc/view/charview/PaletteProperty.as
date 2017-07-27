package coc.view.charview {
import classes.internals.Utils;

import coc.script.Eval;

public class PaletteProperty {
	private var name:String;
	private var srcfn:Eval;
	private var defaultt:String;
	private var lookups:Object;

	public function PaletteProperty(name:String, expr:String,defaultt:String,lookups:Object) {
		this.name = name;
		this.srcfn = Eval.compile(expr);
		this.defaultt = defaultt;
		this.lookups = Utils.extend({},lookups);
	}

	public function sourceValue(src:Object):* {
		return srcfn.call(src);
	}
	public function getValue(src:Object):String {
		return lookups[sourceValue(src)] || defaultt;
	}
}
}
