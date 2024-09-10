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
	private var layers:Object;
	private var animations:Object;
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
		layers     = {};
		animations = {};
		visibility = {};
		bmp        = new BitmapData(width, height,true,0);
	}
	public function addLayer(name:String, src:BitmapData, dx:int,dy:int,visible:Boolean = true):void {
		if (name in visibility) removeLayer(name);
		var layer:CompositeLayer = new CompositeLayer(name, src,dx,dy);
		layers[name] = layer;
		list.unshift(layer);
		visibility[name] = visible;
	}
	public function getLayer(name:String):CompositeLayer {
		return layers[name];
	}
	public function addAnimation(animation:AnimationDef):void {
		this.animations[animation.name] = animation;
	}
	public function advanceTime(dt:int, t2:int):Boolean {
		var dirty:Boolean = false;
		for each (var layer:CompositeLayer in list) {
			if (visibility[layer.name]) {
				if (layer.advanceTime(dt, t2)) dirty = true;
			}
		}
		return dirty;
	}
	public function removeLayer(name:String):void {
		for (var i:int = 0; i < list.length; i++) {
			if (list[i].name == name) {
				list.splice(i, 1);
				delete visibility[name];
				break;
			}
		}
		delete layers[name];
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
		if (name in visibility) {
			visibility[name] = visible;
		} else {
			trace("[WARN] <" + (visible?"show":"hide") + "> called for non-existing layer "+name);
		}
	}
	public function isVisible(name:String):Boolean {
		return !!visibility[name];
	}
	public function setAnimation(layerName:String, animationName:String):void {
		var layer:CompositeLayer = layers[layerName];
		if (!layer) {
			trace("[WARN] <animate> called for non-existing layer "+layerName);
			return;
		}
		if (!visibility[layerName]) return;
		var animation:AnimationDef = animations[animationName];
		if (animationName && !animation) {
			trace("[WARN] <animate> called for non-existing animation "+animationName);
			return;
		}
		layer.setAnimation(animation, this);
	}
	public function setMultiAnimation(prefix:String, animationName:String):void {
		var animation:AnimationDef = animations[animationName];
		if (animationName && !animation) {
			trace("[WARN] <animate> called for non-existing animation "+animationName);
			return;
		}
		for (var key:String in visibility) {
			if (key.indexOf(prefix)==0 && visibility[key]) {
				(layers[key] as CompositeLayer).setAnimation(animation, this);
			}
		}
	}
	public function resetAnimations():void {
		for each (var layer:CompositeLayer in list) {
			layer.resetAnimation();
		}
	}
	public function hideAll():void {
		for each (var layer:CompositeLayer in list) {
			visibility[layer.name] = false;
			layer.setAnimation(null, null);
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




