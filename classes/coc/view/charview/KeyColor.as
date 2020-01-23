/**
 * Coded by aimozg on 28.07.2017.
 */
package coc.view.charview {
import classes.internals.Utils;

import coc.view.Color;

public class KeyColor {
	private var _src:uint;
	private var _base:String;
	private var tfs:/*String*/Array;
	public function KeyColor(src:uint, base:String, tf:String) {
		this._src  = src;
		this._base = base;
		if (tf) this.tfs = tf.split(";");
		else this.tfs = [];
	}
	public function transform(baseValue:uint):uint {
		var hsl:* = Color.toHsl(baseValue);
		for each (var tf:String in tfs) {
			var fn:Array               = tf.match(/^(\w+)\(([\d.,-]+)\)/);
			var fname:String  = fn ? fn[1] : undefined;
			var values:Array = fn ? fn[2].split(",") : [];
			for (var i:int = 0; i<values.length; i++) values[i] = parseFloat(values[i]);
			switch (fname) {
				case "shift":
				case "h":
					hsl.h = hsl.h + values[0];
					break;
				case "shiftTo":
				case "hto":
					if (hsl.h > values[0]) {
						hsl.h -= values[1];
					} else {
						hsl.h += values[2];
					}
					break;
				case "saturate":
				case "s":
					hsl.s += values[0];
					break;
				case "desaturate":
					hsl.s -= values[0];
					break;
				case "darken":
					hsl.l -= values[0];
					break;
				case "lighten":
				case "l":
					hsl.l += values[0];
					break;
				default:
					trace("Error: invalid color transform '" + tf + "'");
					break;
			}
			hsl.h = hsl.h % 360;
			while (hsl.h < 0) hsl.h += 360;
			hsl.s = Utils.boundFloat(0, hsl.s, 100);
			hsl.l = Utils.boundFloat(0, hsl.l, 100);
			
		}
		return Color.fromHsl(hsl);
	}
	public function get src():uint {
		return _src;
	}
	public function get base():String {
		return _base;
	}
}
}
