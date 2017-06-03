/**
 * Coded by aimozg on 04.06.2017.
 */
package coc.view {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

[Style(name="fillColor", type="uint", format="Color", inherit="no")]
public class BitmapDataSprite extends Sprite {
	public function BitmapDataSprite(bd:Class=null) {
		super();
		_clazz = bd;
		_init();
	}
	public function set bdClass(value:Class):void {
		_clazz = value;
		_init();
	}
	private var _clazz:Class = null;
	private var _bd:BitmapData = null;
	private var _color:uint = 0;
	private var _width:Number = 0;
	private var _height:Number = 0;
	public function set fillColor(value:uint):void {
		_color = value;
		_init();
	}
	override public function set width(value:Number):void {
//		super.width = value;
		_width = value;
		_init();
	}
	override public function set height(value:Number):void {
//		super.height = value;
		_height = value;
		_init();
	}
	private function _init():void {
		if (_clazz) {
			this._bd = (new _clazz() as Bitmap).bitmapData;
			this._clazz = null;
			_init();
			return;
		}
		this.graphics.clear();
		if (_bd) {
			this._width = _bd.width;
			this._height = _bd.height;
			this.graphics.beginBitmapFill(_bd);
		} else {
			this.graphics.beginFill(_color,1.0);
		}
		this.graphics.drawRect(0,0,_width,_height);
		this.graphics.endFill();
	}
}
}
