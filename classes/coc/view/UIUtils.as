/**
 * Coded by aimozg on 06.06.2017.
 */
package coc.view {
import classes.internals.Utils;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.filters.DropShadowFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class UIUtils {
	public function UIUtils() {
	}
	public static function convertColor(input:Object):uint {
		return Color.convertColor(input);
	}
	public static function convertTextFormat(input:Object):TextFormat {
		if (input is TextFormat) return input as TextFormat;
		var tf:TextFormat = new TextFormat();
		setProperties(tf,input,{
			'color':Color.convertColor
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
			if (key.indexOf('on') == 0) {
				e.addEventListener(key.substr(2), Utils.bindThis(options[key] as Function, e));
			} else if (options.hasOwnProperty(key) && key in e) {
				var spcobj:* = special ? special[key] : undefined;
				if (spcobj === null) continue;
				var spc:Function = spcobj as Function;
				var value:*      = options[key];
				e[key]           = spc != null ? spc(value) : value;
			}
		}
		return e;
	}
	
	public static function newTextField(options:Object=null):TextField {
		if (options is String) options ={text:options};
		var e:TextField = new TextField();
		e.antiAliasType = AntiAliasType.ADVANCED;
		if ('defaultTextFormat' in options) {
			e.defaultTextFormat = UIUtils.convertTextFormat(options['defaultTextFormat']);
		}
		UIUtils.setProperties(e, options, {
			defaultTextFormat: UIUtils.convertTextFormat,
			background: UIUtils.convertColor,
			textColor: UIUtils.convertColor,
			autoSize: null, // set later
			text: null, // set later
			htmlText: null
		});
		if (!('mouseEnabled' in options) && options['type'] != 'input') e.mouseEnabled = false;
		if (!('width' in options || 'height' in options || 'autoSize' in options)) {
			e.autoSize = TextFieldAutoSize.LEFT;
		} else if ('autoSize' in options) {
			// set it after sizes
			e.autoSize = options['autoSize'];
		}
		if ('htmlText' in options) e.htmlText = options.htmlText;
		else if ('text' in options) e.text = options.text;
		return e;
	}
	public static function outlineFilter(color:*):DropShadowFilter {
		return new DropShadowFilter(
				0.0,
				0,
				Color.convertColor32(color),
				1.0,
				4.0,
				4.0,
				10.0
		)
	}
	public static function subsprite(src:BitmapData, x:int, y:int, width:int, height:int):BitmapData {
		var dst:BitmapData = new BitmapData(width, height, true, 0);
		if (width > 0 && height > 0) dst.copyPixels(src, new Rectangle(x, y, width, height), new Point(0, 0));
		return dst;
	}
	public static function drawBitmap(g:Graphics, bmp:BitmapData, x:int, y:int, width:int=-1, height:int=-1):void {
		if (width == -1) width = bmp.width;
		if (height == -1) height = bmp.height;
		// We can't just draw a bitmap onto Graphics, we have to use beginBitmapFill
		// It fills the shape with repeated bitmap pattern
		// with origin at graphics' 0,0 corner.
		// To compensate and avoid weird tiling artifact, we transorm the bitmap fill.
		var m:Matrix = new Matrix();
		m.translate(x,y);
		g.beginBitmapFill(bmp, m);
		g.drawRect(x, y, width, height);
		g.endFill();
	}
	public static function getRelativePos(element:DisplayObject, container:DisplayObject):Point {
		var x:Number = 0;
		var y:Number = 0;
		while (element && element != container) {
			x += element.x;
			y += element.y;
			element = element.parent;
		}
		return new Point(x,y);
	}
}
}
