/**
 * Coded by aimozg on 11.07.2017.
 */
package coc.view {
import coc.view.CompositeImage;

import flash.display.BitmapData;

internal class CompositeLayer {
	private var _composite:CompositeImage;
	private var _layer:String;
	private var _name:String;
	private var src:BitmapData;
	private var dst:BitmapData;
	private var keyColors:Object;// uint color24 -> uint color24
	private var _dx:int;
	private var _dy:int;
	
	public var visible:Boolean = false;
	private var dirty:Boolean = true;
	public var offsetx:int;
	public var offsety:int;
	public var currentLayer:String;
	private var animation:LayerAnimation;

	public function get width():int {
		return src.width;
	}
	public function get height():int {
		return src.height;
	}
	
	public function get dx():int {
		return _dx + offsetx + (animation ? animation.dx() : 0);
	}
	
	public function get dy():int {
		return _dy + offsety + (animation ? animation.dy() : 0);
	}
	
	public function get composite():CompositeImage {
		return _composite;
	}
	
	public function advanceTime(dt:int, t2:int):Boolean {
		if (animation) {
			return animation.advanceTime(dt,t2);
		}
		return false;
	}
	public function resetAnimation():void {
		if (animation) animation.reset();
	}

	public function CompositeLayer(composite:CompositeImage, layer:String,name:String, src:BitmapData, dx:int, dy:int) {
		this._composite = composite;
		this._layer     = layer;
		this._name      = name;
		this.src = src;
		this._dx = dx;
		this._dy = dy;
		this.dst = new BitmapData(src.width, src.height,true,0);
		this.keyColors = {};
		this.reset();
		this.dst.draw(src);
	}
	public function reset():void {
		animation = null;
		offsetx = 0;
		offsety = 0;
		visible = false;
		currentLayer = _layer;
		dirty = true;
	}

	public function get name():String {
		return _name;
	}
	public function setKeyColors(newKeyColors:Object):void {
		for (var kc:String in keyColors) {
			if (!(kc in newKeyColors)) {
				dirty = true;
				delete keyColors[kc];
			}
		}
		for (kc in newKeyColors) {
			if (!(kc in keyColors) || keyColors[kc] != newKeyColors[kc]) {
				dirty         = true;
				keyColors[kc] = newKeyColors[kc];
			}
		}
//		if (animation) {
//			animation.setKeyColors(keyColors);
//		}
	}
	public function setAnimation(animation:AnimationDef):void {
		if (!this.animation && !animation) return;
		this.animation = animation ? new LayerAnimation(animation, this) : null;
//		if (animation) {
//			animation.setKeyColors(keyColors);
//		}
		dirty = true;
	}

	public function draw():BitmapData {
		if (dirty) doUpdate();
		var image:CompositeLayer = animation ? animation.image() : null;
		if (image && !image.animation) {
			image.setKeyColors(keyColors);
			return image.draw();
		}
		return dst;
	}

	protected function doUpdate():void {
		recolor(keyColors, src, dst);
	}
	public static function recolor(keyColors:Object, src:BitmapData, dst:BitmapData):void {
		for (var y:uint = 0, height:int = src.height; y < height; y++) {
			for (var x:uint = 0, width:int = src.width; x < width; x++) {
				var pix:uint = src.getPixel32(x, y);
				var alpha:uint = pix&0xff000000;
				var rgb:uint = pix&0x00ffffff;
				if (rgb in keyColors) rgb = keyColors[rgb]&0x00ffffff;
				dst.setPixel32(x, y, alpha|rgb);
			}
		}
	}
}
}
