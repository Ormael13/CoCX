/**
 * Coded by aimozg on 28.07.2017.
 */
package coc.view.charview {
import coc.view.Color;

public class Palette {
	private var _keyColorsList:/*KeyColor*/Array       = [];
	private var _paletteProps:/*PaletteProperty*/Array = [];

	public function Palette() {
	}
	public function addKeyColor(src:uint,base:String,tf:String):void {
		this._keyColorsList.push(new KeyColor(src,base,tf));
	}
	public function addPaletteProperty(name:String,expr:String,defaultt:uint,lookups:/*Object*/Array):void {
		this._paletteProps.push(new PaletteProperty(name,expr,defaultt,lookups));
	}
	public function lookupColor(propname:String,colorname:String):uint {
		for each (var property:PaletteProperty in _paletteProps) {
			if (property.name == propname) return property.lookup(colorname);
		}
		return 0xfff000e0;
	}
	// { key_color -> actual_color }
	public function calcKeyColors(character:Object):Object {
		var props:Object = {};
		for each (var property:PaletteProperty in _paletteProps) {
			props[property.name] = property.colorValue(character);
		}
		var keyColorsMap:Object = {};
		for each (var color:KeyColor in _keyColorsList) {
			keyColorsMap[color.src] = color.transform(props[color.base]);
		}
		return keyColorsMap;
	}
	public function get paletteProps():Array {
		return _paletteProps;
	}
	public function get keyColorsList():Array {
		return _keyColorsList;
	}
}
}


