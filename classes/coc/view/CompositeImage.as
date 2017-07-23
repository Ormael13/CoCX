/**
 * Coded by aimozg on 10.07.2017.
 */
package coc.view {
import flash.display.BitmapData;

public class CompositeImage {
	private var list:/*coc.view.CompositeLayer*/Array;
	private var visibility:Object;
	private var bmp:BitmapData;

	public function CompositeImage(width:uint, height:uint) {
		list       = [];
		visibility = {};
		bmp        = new BitmapData(width, height,true,0);
	}
	public function addLayer(name:String, src:BitmapData, visible:Boolean = true):void {
		if (name in visibility) removeLayer(name);
		list.unshift(new CompositeLayer(name, src));
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
	public function replaceLayer(name:String, src:BitmapData):void {
		for (var i:int = 0; i < list.length; i++) {
			if (list[i].name == name) {
				list[i] = new CompositeLayer(name, src);
			}
		}
	}
	public function setVisibility(name:String, visible:Boolean):void {
		if (name in visibility && visibility[name] != visible) {
			visibility[name] = visible;
		}
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
				bmp.draw(layer.draw());
			}
		}
		return bmp;
	}
}
}




