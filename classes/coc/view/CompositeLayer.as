/**
 * Coded by aimozg on 11.07.2017.
 */
package coc.view {
import flash.display.BitmapData;

internal class CompositeLayer {
	private var _name:String;
	private var src:BitmapData;
	private var dst:BitmapData;
	private var keyColors:Object;// uint color24 -> uint color24
	private var dirty:Boolean = true;
	private var _dx:int;
	private var _dy:int;
	private var animation:LayerAnimation;

	public function get width():int {
		return src.width;
	}
	public function get height():int {
		return src.height;
	}
	
	public function get dx():int {
		return _dx + (animation ? animation.dx() : 0);
	}
	
	public function get dy():int {
		return _dy + (animation ? animation.dy() : 0);
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

	public function CompositeLayer(name:String, src:BitmapData, dx:int, dy:int) {
		this._name     = name;
		this.src = src;
		this._dx = dx;
		this._dy = dy;
		this.dst = new BitmapData(src.width, src.height,true,0);
		this.keyColors = {};
		this.dst.draw(src);
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
	public function setAnimation(animation:AnimationDef, composite:CompositeImage):void {
		if (!this.animation && !animation) return;
		this.animation = animation ? new LayerAnimation(animation, this, composite) : null;
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
