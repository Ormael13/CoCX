/**
 * Coded by aimozg on 04.06.2017.
 */
package coc.view {
import classes.internals.Utils;

import flash.display.Bitmap;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.Matrix;

[Style(name="fillColor", type="uint", format="Color", inherit="no")]
public class BitmapDataSprite extends Sprite {
	public function BitmapDataSprite(options:Object = null) {
		super();
		options = Utils.extend({},options);
		if (options) {
			_fillColor = UIUtils.convertColor(Utils.moveValue(options,'fillColor',_fillColor));
			_borderColor = UIUtils.convertColor(Utils.moveValue(options,'borderColor',_borderColor));
			_width = Utils.moveValue(options,'width',_width);
			_height = Utils.moveValue(options,'height',_height);
			if (_width || _height) setSize(_width,_height);
			_stretch = Utils.moveValue(options,'stretch',_stretch);
			_repeat = Utils.moveValue(options,'repeat',_repeat);
			_crop = Utils.moveValue(options,'crop',_crop);
			_borderImage = Utils.moveValue(options, 'borderImage', _borderImage);
			_bitmapX = Utils.moveValue(options, 'bitmapX', _bitmapX);
			_bitmapY = Utils.moveValue(options, 'bitmapY', _bitmapY);
			bitmapClass = Utils.moveValue(options,'bitmapClass',null);
			bitmap = Utils.moveValue(options,'bitmap',_bitmap);
			for (var key:String in options) {
				if (options.hasOwnProperty(key)) {
					var value:* = options[key];
					if (key in this) {
						this[key] = value;
					} else {
						trace("Unknown BitmapDataSprite property", key)
					}
				}
			}
		}
	}
	private var _bitmap:Bitmap   = null;
	private var _bitmapX:Number = 0;
	private var _bitmapY:Number = 0;
	private var _borderImage:BorderImage = null;
	private var _fillColor:uint  = 0;
	private var _fillAlpha:Number  = 1.0;
	private var _borderColor:uint  = 0;
	private var _borderWidth:uint  = 0;
	private var _borderRadius:uint  = 0;
	private var _width:Number    = 0;
	private var _height:Number   = 0;
	private var _stretch:Boolean = false;
	private var _repeat:Boolean  = false;
	private var _crop:Boolean   = false;
	private var _smooth:Boolean = true;
	
	public function get smooth():Boolean {
		return _smooth;
	}
	public function set smooth(value:Boolean):void {
		_smooth = value;
		redraw();
	}
	
	public function set bitmapClass(value:Class):void {
		if (value as Class) bitmap = (new value()) as Bitmap;
		else bitmap = null;
	}
	public function get bitmapClass():Class {
		return null;
	}
	public function get bitmap():Bitmap {
		return _bitmap;
	}
	public function set bitmap(value:Bitmap):void {
		if (_bitmap == value) return;
		_bitmap = value;
		if (value) {
			if (_width == 0 || !crop && !stretch && !repeat) _width = value.width;
			if (_height == 0 || !crop && !stretch && !repeat) _height = value.height;
		}
		redraw();
	}
	public function get fillColor():uint {
		return _fillColor;
	}
	public function set fillColor(value:*):void {
		if (!(value is Number)) value = Color.convertColor(value);
		if (_fillColor == value) return;
		_fillColor = value;
		redraw();
	}
	public function get fillAlpha():Number {
		return _fillAlpha;
	}
	public function set fillAlpha(value:Number):void {
		if (_fillAlpha == value) return;
		_fillAlpha = value;
		redraw();
	}
	public function get borderColor():uint {
		return _borderColor;
	}
	public function set borderColor(value:*):void {
		if (!(value is Number)) value = Color.convertColor(value);
		if (_borderColor == value) return;
		_borderColor = value;
		if (_borderWidth) redraw();
	}
	public function get borderWidth():uint {
		return _borderWidth;
	}
	public function set borderWidth(value:uint):void {
		if (_borderWidth == value) return;
		_borderWidth = value;
		redraw();
	}
	public function get borderRadius():uint {
		return _borderRadius;
	}
	public function set borderRadius(value:uint):void {
		if (_borderRadius == value) return;
		_borderRadius = value;
		if (borderWidth) redraw();
	}
	public function get borderImage():BorderImage {
		return _borderImage;
	}
	public function set borderImage(value:BorderImage):void {
		if (_borderImage == value) return;
		_borderImage = value;
		redraw();
	}
	override public function set width(value:Number):void {
		setSize(value,_height);
	}
	override public function set height(value:Number):void {
		setSize(_width,value);
	}
	public function setSize(width:Number, height:Number):void {
		_width = width;
		_height = height;
		redraw();
		super.width = width;
		super.height = height;
	}
	public function get stretch():Boolean {
		return _stretch;
	}
	public function set stretch(value:Boolean):void {
		if (_stretch == value) return;
		_stretch = value;
		redraw();
	}
	public function get repeat():Boolean {
		return _repeat;
	}
	public function set repeat(value:Boolean):void {
		if (_repeat == value) return;
		_repeat = value;
		redraw();
	}
	public function get crop():Boolean {
		return _crop;
	}
	public function set crop(value:Boolean):void {
		if (_crop == value) return;
		_crop = value;
		redraw();
	}
	private function redraw():void {
		var graphics:Graphics = this.graphics;
		graphics.clear();
		if (_borderImage) {
			graphics.lineStyle();
		} else {
			this.graphics.lineStyle(borderWidth, _borderColor, borderWidth > 0 ? 1.0 : 0);
		}
		if (bitmap) {
			var m:Matrix = new Matrix();
			if (stretch) {
				m.scale(_width / bitmap.width, _height / bitmap.height);
				graphics.beginBitmapFill(bitmap.bitmapData, m, false, smooth);
			} else {
				m.translate(_bitmapX, _bitmapY);
				graphics.beginBitmapFill(bitmap.bitmapData, m, repeat);
			}
		} else {
			graphics.beginFill(_fillColor, _fillAlpha);
		}
		if (_borderRadius) {
			graphics.drawRoundRect(0, 0, _width, _height, _borderRadius, _borderRadius);
		} else {
			graphics.drawRect(0, 0, _width, _height);
		}
		graphics.endFill();
		if (_borderImage) {
			_borderImage.drawOver(graphics, _width, _height, true);
		}
	}
}
}
