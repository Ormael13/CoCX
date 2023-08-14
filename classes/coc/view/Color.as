/**
 * Coded by aimozg on 11.07.2017.
 * Contains code from:
 * * TinyColor v1.4.1 by Brian Grinstead, MIT License
 */
package coc.view {
import classes.internals.Utils;

public class Color {
	public static const INVALID_COLOR:uint = 0x1ee00ee;
	public function Color() {
	}
	public static function convertColor(input:Object):uint {
		return convertColorEx(input,false);
	}
	public static function convertColor32(input:Object):uint {
		return convertColorEx(input,true);
	}
	public static function toHex(input:uint,alpha:Boolean=false):String {
		var s:String = input.toString(16);
		while (s.length < (alpha ? 8 : 6)) s = "0"+s;
		return "#"+s;
	}
	public static function convertColorEx(input:Object,alpha:Boolean):uint {
		var s:String = input as String;
		if (s) return parseColorString(s);
		if (input is Number) return int(input);
		if (!input) return INVALID_COLOR;
		if ('r' in input && 'g' in input && 'b' in input) {
			var r:Number = input.r;
			var g:Number = input.g;
			var b:Number = input.b;
			var a:Number = ('a' in input) ? input.a : 1.0;
			if (r<=1 && g<=1 && b<=1 && a<=1) return alpha?fromArgbFloat(a,r,g,b):fromRgbFloat(r,g,b);
			return alpha?fromArgb(a,r,g,b):fromRgb(r,g,b);
		}
		return INVALID_COLOR;
	}
	public static function fromArgb(a:uint, r:uint, g:uint, b:uint):uint {
		return ((a & 0xff) << 24) | ((r & 0xff) << 16) | ((g & 0xff) << 8) | (b & 0xff);
	}
	public static function fromRgb(r:uint, g:uint, b:uint):uint {
		return ((r & 0xff) << 16) | ((g & 0xff) << 8) | (b & 0xff);
	}
	/** @return {{a:Number, r:Number, g:Number, b:Number}} object */
	public static function getFloatComponents(argb:uint):Object {
		return {
			a: ((argb >> 24) & 0xff) / 255,
			r: ((argb >> 16) & 0xff) / 255,
			g: ((argb >> 8) & 0xff) / 255,
			b: (argb & 0xff) / 255
		}
	}
	public static function fromArgbFloat(a:Number,r:Number, g:Number, b:Number):uint {
		return fromArgb(a*255,r*255,g*255,b*255);
	}
	public static function fromRgbFloat(r:Number, g:Number, b:Number):uint {
		return fromRgb(r*255,g*255,b*255);
	}
	public static function parseColorString(s:String, alpha:Boolean = false):uint {
		if (s in KnownColors) s = KnownColors[s];
		var a:Array;
		if ((a = s.match(/^(?:0x|\$|#)([a-fA-F0-9]{8})$/))) {
			x = parseInt(a[1],16);
			return alpha ? x : (x & 0x00ffffff);
		}
		var x:uint;
		if ((a = s.match(/^(?:0x|\$|#)([a-fA-F0-9]{6})$/))) {
			x = parseInt(a[1], 16);
		} else if ((a = s.match(/^(?:0x|\$|#)([a-fA-F0-9]{3})$/))) {
			var rgb12:uint = parseInt(a[1], 16);
			var r:uint = (rgb12 & 0xf00)>>8,
				g:uint = (rgb12 & 0x0f0)>>4,
				b:uint = (rgb12 & 0x00f);
			x = (r<<20)|(r<<16)|(g<<12)|(g<<8)|(b<<4)|b;
		} else if ((a = s.match(/^hsl\((\d+),(\d+),(\d+)\)$/))) {
			x = fromHsl({h:a[1],s:a[2],l:a[3]});
		} else {
			return INVALID_COLOR;
		}
		return alpha ? 0xff000000|x : x;
	}
	public static function toHsl(color:uint):Object {
		var a:Number = ((color >> 24) & 0xff)/255.0;
		var r:Number = ((color >> 16) & 0xff)/255.0;
		var g:Number = ((color >> 8) & 0xff)/255.0;
		var b:Number = ((color >> 0) & 0xff)/255.0;

		var max:Number = Math.max(r, g, b), min:Number = Math.min(r, g, b);
		var h:Number, s:Number, l:Number = (max + min) / 2;

		if(max == min) {
			h = s = 0; // achromatic
		}
		else {
			var d:Number = max - min;
			s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
			switch(max) {
				case r: h = (g - b) / d + (g < b ? 6 : 0); break;
				case g: h = (b - r) / d + 2; break;
				case b: h = (r - g) / d + 4; break;
			}

			h /= 6;
		}

		return { h: h*360, s: s*100, l: l*100 , a: a/255.0};
	}
	public static function fromHsl(hsl:Object):uint {
		var r:Number, g:Number, b:Number;

		var h:Number = Utils.boundFloat(0, hsl.h/360, 1);
		var s:Number = Utils.boundFloat(0, hsl.s/100, 1);
		var l:Number = Utils.boundFloat(0, hsl.l/100, 1);

		function hue2rgb(p:Number, q:Number, t:Number):Number {
			if(t < 0) t += 1;
			if(t > 1) t -= 1;
			if(t < 1/6) return p + (q - p) * 6 * t;
			if(t < 1/2) return q;
			if(t < 2/3) return p + (q - p) * (2/3 - t) * 6;
			return p;
		}

		if(s === 0) {
			r = g = b = l; // achromatic
		}
		else {
			var q:Number = l < 0.5 ? l * (1 + s) : l + s - l * s;
			var p:Number = 2 * l - q;
			r = hue2rgb(p, q, h + 1/3);
			g = hue2rgb(p, q, h);
			b = hue2rgb(p, q, h - 1/3);
		}

		if ('a' in hsl) return fromArgbFloat(hsl.a,r,g,b);
		return fromRgbFloat(r,g,b);
	}
	public static function darken(color:uint, amount:Number = 10):uint {
		var hsl:Object = toHsl(color);
		hsl.l = Utils.boundFloat(0,hsl.l-amount,100);
		return fromHsl(hsl);
	}
	public static function lighten(color:uint, amount:Number = 10):uint {
		var hsl:Object = toHsl(color);
		hsl.l = Utils.boundFloat(0,hsl.l+amount,100);
		return fromHsl(hsl);
	}
	public static function interpolate(startARGB:Object, endARGB:Object, t:Number):uint {
		var deltaARGB:Object = {
			a: endARGB.a - startARGB.a,
			r: endARGB.r - startARGB.r,
			g: endARGB.g - startARGB.g,
			b: endARGB.b - startARGB.b
		};
		return fromArgbFloat(
						Utils.lerp(startARGB.a, deltaARGB.a, t),
						Utils.lerp(startARGB.r, deltaARGB.r, t),
						Utils.lerp(startARGB.g, deltaARGB.g, t),
						Utils.lerp(startARGB.b, deltaARGB.b, t)
				);
	}
	private static const KnownColors:Object = {
		transparent: "#00000000",
		
		aliceblue: "#f0f8ff",
		antiquewhite: "#faebd7",
		aqua: "#0ff",
		aquamarine: "#7fffd4",
		azure: "#f0ffff",
		beige: "#f5f5dc",
		bisque: "#ffe4c4",
		black: "#000",
		blanchedalmond: "#ffebcd",
		blue: "#00f",
		blueviolet: "#8a2be2",
		brown: "#a52a2a",
		burlywood: "#deb887",
		burntsienna: "#ea7e5d",
		cadetblue: "#5f9ea0",
		chartreuse: "#7fff00",
		chocolate: "#d2691e",
		coral: "#ff7f50",
		cornflowerblue: "#6495ed",
		cornsilk: "#fff8dc",
		crimson: "#dc143c",
		cyan: "#0ff",
		darkblue: "#00008b",
		darkcyan: "#008b8b",
		darkgoldenrod: "#b8860b",
		darkgray: "#a9a9a9",
		darkgreen: "#006400",
		darkgrey: "#a9a9a9",
		darkkhaki: "#bdb76b",
		darkmagenta: "#8b008b",
		darkolivegreen: "#556b2f",
		darkorange: "#ff8c00",
		darkorchid: "#9932cc",
		darkred: "#8b0000",
		darksalmon: "#e9967a",
		darkseagreen: "#8fbc8f",
		darkslateblue: "#483d8b",
		darkslategray: "#2f4f4f",
		darkslategrey: "#2f4f4f",
		darkturquoise: "#00ced1",
		darkviolet: "#9400d3",
		deeppink: "#ff1493",
		deepskyblue: "#00bfff",
		dimgray: "#696969",
		dimgrey: "#696969",
		dodgerblue: "#1e90ff",
		firebrick: "#b22222",
		floralwhite: "#fffaf0",
		forestgreen: "#228b22",
		fuchsia: "#f0f",
		gainsboro: "#dcdcdc",
		ghostwhite: "#f8f8ff",
		gold: "#ffd700",
		goldenrod: "#daa520",
		gray: "#808080",
		green: "#008000",
		greenyellow: "#adff2f",
		grey: "#808080",
		honeydew: "#f0fff0",
		hotpink: "#ff69b4",
		indianred: "#cd5c5c",
		indigo: "#4b0082",
		ivory: "#fffff0",
		khaki: "#f0e68c",
		lavender: "#e6e6fa",
		lavenderblush: "#fff0f5",
		lawngreen: "#7cfc00",
		lemonchiffon: "#fffacd",
		lightblue: "#add8e6",
		lightcoral: "#f08080",
		lightcyan: "#e0ffff",
		lightgoldenrodyellow: "#fafad2",
		lightgray: "#d3d3d3",
		lightgreen: "#90ee90",
		lightgrey: "#d3d3d3",
		lightpink: "#ffb6c1",
		lightsalmon: "#ffa07a",
		lightseagreen: "#20b2aa",
		lightskyblue: "#87cefa",
		lightslategray: "#789",
		lightslategrey: "#789",
		lightsteelblue: "#b0c4de",
		lightyellow: "#ffffe0",
		lime: "#0f0",
		limegreen: "#32cd32",
		linen: "#faf0e6",
		magenta: "#f0f",
		maroon: "#800000",
		mediumaquamarine: "#66cdaa",
		mediumblue: "#0000cd",
		mediumorchid: "#ba55d3",
		mediumpurple: "#9370db",
		mediumseagreen: "#3cb371",
		mediumslateblue: "#7b68ee",
		mediumspringgreen: "#00fa9a",
		mediumturquoise: "#48d1cc",
		mediumvioletred: "#c71585",
		midnightblue: "#191970",
		mintcream: "#f5fffa",
		mistyrose: "#ffe4e1",
		moccasin: "#ffe4b5",
		navajowhite: "#ffdead",
		navy: "#000080",
		oldlace: "#fdf5e6",
		olive: "#808000",
		olivedrab: "#6b8e23",
		orange: "#ffa500",
		orangered: "#ff4500",
		orchid: "#da70d6",
		palegoldenrod: "#eee8aa",
		palegreen: "#98fb98",
		paleturquoise: "#afeeee",
		palevioletred: "#db7093",
		papayawhip: "#ffefd5",
		peachpuff: "#ffdab9",
		peru: "#cd853f",
		pink: "#ffc0cb",
		plum: "#dda0dd",
		powderblue: "#b0e0e6",
		purple: "#800080",
		rebeccapurple: "#663399",
		red: "#f00",
		rosybrown: "#bc8f8f",
		royalblue: "#4169e1",
		saddlebrown: "#8b4513",
		salmon: "#fa8072",
		sandybrown: "#f4a460",
		seagreen: "#2e8b57",
		seashell: "#fff5ee",
		sienna: "#a0522d",
		silver: "#c0c0c0",
		skyblue: "#87ceeb",
		slateblue: "#6a5acd",
		slategray: "#708090",
		slategrey: "#708090",
		snow: "#fffafa",
		springgreen: "#00ff7f",
		steelblue: "#4682b4",
		tan: "#d2b48c",
		teal: "#008080",
		thistle: "#d8bfd8",
		tomato: "#ff6347",
		turquoise: "#40e0d0",
		violet: "#ee82ee",
		wheat: "#f5deb3",
		white: "#fff",
		whitesmoke: "#f5f5f5",
		yellow: "#ff0",
		yellowgreen: "#9acd32"
	}
}
}
