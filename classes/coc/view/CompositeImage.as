/**
 * Coded by aimozg on 10.07.2017.
 */
package coc.view {
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class CompositeImage {
	private var list:/*coc.view.CompositeLayer*/Array;
	private var visibility:Object;
	private var bmp:BitmapData;
	public function get width():int {
		return bmp.width;
	}
	public function get height():int {
		return bmp.height;
	}

	public function CompositeImage(width:uint, height:uint) {
		list       = [];
		visibility = {};
		bmp        = new BitmapData(width, height,true,0);
	}
	public function addLayer(name:String, src:BitmapData, dx:int,dy:int,visible:Boolean = true):void {
		if (name in visibility) removeLayer(name);
		list.unshift(new CompositeLayer(name, src,dx,dy));
		visibility[name] = visible;
	}
	public function removeLayer(name:String):void {
		for (var i:int = 0; i < list.length; i++) {
			if (list[i].name == name) {
				list.splice(i, 1);
				delete visibility[name];
				break;
			}
		}
	}
	public function replaceLayer(name:String, src:BitmapData, dx: int, dy: int):void {
		for (var i:int = 0; i < list.length; i++) {
			if (list[i].name == name) {
				list[i] = new CompositeLayer(name, src, dx, dy);
			}
		}
	}
	public function setMultiVisibility(prefix:String, visible:Boolean):void {
		for (var key:String in visibility) {
			if (key.indexOf(prefix)==0) visibility[key] = visible;
		}
	}
	public function setVisibility(name:String, visible:Boolean):void {
		visibility[name] = visible;
	}
	public function hideAll():void {
		for each (var layer:CompositeLayer in list) {
			visibility[layer.name] = false;
		}
	}
	public function draw(keyColors:Object):BitmapData {
		bmp.fillRect(bmp.rect, 0);
		for each (var layer:CompositeLayer in list) {
			if (visibility[layer.name]) {
				layer.setKeyColors(keyColors);
				var sx:int = 0,sy:int = 0;
				var sw:int = layer.width;
				var sh:int = layer.height;
				var dx:int = layer.dx;
				var dy:int = layer.dy;
				if (dx<0) {
					sx = -dx;
					dx = 0;
				}
				if (dy<0) {
					sy = -dy;
					dy = 0;
				}
				if (dx + sw > width) sw = width - dx;
				if (dy + sh > height) sh = height - dy;
				bmp.copyPixels(layer.draw(),
						new Rectangle(sx,sy,sw,sh),
						new Point(dx,dy),null,null,true);
			}
		}
		return bmp;
	}
}
}




