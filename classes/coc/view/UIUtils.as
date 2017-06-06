/**
 * Coded by aimozg on 06.06.2017.
 */
package coc.view {
import flash.text.TextFormat;

public class UIUtils {
	public static const INVALID_COLOR:uint = 0x1ee00ee;
	public function UIUtils() {
	}
	public static function convertColor(input:Object):uint {
		var s:String = input as String;
		if (s) return parseColorString(s);
		if (input is Number) return uint(input);
		if (!input) return INVALID_COLOR;
		if ('r' in input && 'g' in input && 'b' in input) {
			var r:Number = input.r;
			var g:Number = input.g;
			var b:Number = input.b;
			if (r<=1 || g<=1 || b<=1) return fromRgbFloat(r,g,b);
			return fromRgb(r,g,b);
		}
		return INVALID_COLOR;
	}
	public static function fromRgb(r:uint, g:uint, b:uint):uint {
		return ((r & 0xff) << 4) | ((g & 0xff) << 2) | (b & 0xff);
	}
	public static function fromRgbFloat(r:Number, g:Number, b:Number):uint {
		return fromRgb(r*255,g*255,b*255);
	}
	public static function convertTextFormat(input:Object):TextFormat {
		if (input is TextFormat) return input as TextFormat;
		var tf:TextFormat = new TextFormat();
		setProperties(tf,input,{
			'color':convertColor
		});
		return tf;
	}
	public static function convertSize(value:Object,ref100pc:Number):Number {
		if (value is Number) return Number(value);
		value = ''+value;
		if (value.indexOf('%') == value.length-1) {
			return Number(value.substr(0,value.length-1))*ref100pc/100;
		}
		return Number(value);
	}
	public static function setProperties(e:Object,options:Object,special:Object=null):Object {
		if (options) for (var key:String in options) {
			if (options.hasOwnProperty(key) && key in e) {
				var spc:Function = special ? special[key] as Function : null;
				var value:*     = options[key];
				e[key] = spc ? spc(value) : value;
			}
		}
		return e;
	}
	public static function parseColorString(s:String):uint {
		var a:Array;
		if ((a = s.match(/^(?:0x|\$|#)([a-fA-F0-9]{6})$/))) {
			return parseInt(a[1], 16);
		} else if ((a = s.match(/^(?:0x|\$|#)([a-fA-F0-9]{3})$/))) {
			var rgb12:uint = parseInt(a[1], 16);
			return ((rgb12 & 0xf00) << (5 - 2) |
					(rgb12 & 0xf00) << (4 - 2) |
					(rgb12 & 0x0f0) << (3 - 1) |
					(rgb12 & 0x0f0) << (2 - 1) |
					(rgb12 & 0x00f) << (1 - 0) |
					(rgb12 & 0x00f) << (0 - 0));
		} else {
			return INVALID_COLOR;
		}
	}
}
}
