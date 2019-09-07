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
	public var dx:int;
	public var dy:int;

	public function get width():int {
		return src.width;
	}
	public function get height():int {
		return src.height;
	}

	public function CompositeLayer(name:String, src:BitmapData, dx:int, dy:int) {
		this._name     = name;
		this.src       = src;
		this.dx = dx;
		this.dy = dy;
		this.dst       = new BitmapData(src.width, src.height,true,0);
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
	}

	public function draw():BitmapData {
		if (dirty) doUpdate();
		return dst;
	}

	private function doUpdate():void {
		var kc:Object = keyColors;
		for (var y:uint = 0, height:int = src.height; y < height; y++) {
			for (var x:uint = 0, width:int = src.width; x < width; x++) {
				var pix:uint = src.getPixel32(x, y);
				var alpha:uint = pix&0xff000000;
				var rgb:uint = pix&0x00ffffff;
				if (rgb in kc) rgb = kc[rgb]&0x00ffffff;
				dst.setPixel32(x, y, alpha|rgb);
			}
		}
	}
}
}
