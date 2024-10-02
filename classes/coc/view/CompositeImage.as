/**
 * Coded by aimozg on 10.07.2017.
 */
package coc.view {
import coc.view.charview.CharViewCompiler;

import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class CompositeImage {
	public static function getPartLayer(part:String):String {
		var i:int = part.indexOf('/');
		if (i >= 0) return part.substring(0, i+1);
		return '';
	}
	
	/** list of all parts, grouped by layers, back-to-front */
	private var renderLists:/*CompositeLayer[]*/Array = [];
	/** backup of renderList to restore after setOffset() */
	private var renderListBackup:/*CompositeLayer[]*/Array = null;
	/** flat list of all parts */
	private var allParts:/*CompositeLayer*/Array = [];
	/** map (layer name) -> (index in renderLists) */
	private var layer2index:Object = {};
	/** map (part name) -> CompositeLayer */
	private var name2part:Object = {};
	/** map (animation name) -> AnimationDef */
	private var name2anim:Object = {};
	private var bmp:BitmapData;
	public function get width():int {
		return bmp.width;
	}
	public function get height():int {
		return bmp.height;
	}

	public function CompositeImage(width:uint, height:uint) {
		bmp        = new BitmapData(width, height,true,0);
	}
	/** add layer to front */
	public function addLayer(name:String):void {
		if (!(name in layer2index)) {
			layer2index[name] = renderLists.length;
			renderLists.push([]);
		}
	}
	/** add layers sorted back-to-front */
	public function addLayers(names:/*String*/Array):void {
		for each (var name:String in names) addLayer(name);
	}
	public function addPart(name:String, src:BitmapData, dx:int, dy:int):void {
		var layerName:String = getPartLayer(name);
		var i:int;
		if (layerName in layer2index) {
			i = layer2index[layerName];
		} else {
			i = renderLists.length;
			layer2index[layerName] = i;
			renderLists.push([]);
		}
		var part:CompositeLayer = new CompositeLayer(this, layerName, name, src,dx,dy);
		name2part[name] = part;
		renderLists[i].push(part);
		allParts.push(part);
	}
	public function getPart(name:String):CompositeLayer {
		return name2part[name];
	}
	public function addAnimation(animation:AnimationDef):void {
		this.name2anim[animation.name] = animation;
	}
	public function advanceTime(dt:int, t2:int):Boolean {
		var dirty:Boolean = false;
		for each (var layer:CompositeLayer in allParts) {
			if (layer.visible && layer.advanceTime(dt, t2)) dirty = true;
		}
		return dirty;
	}
	private function getParts(name:String, prefix:Boolean):/*CompositeLayer*/Array {
		if (prefix) {
			if (name == "") {
				return allParts;
			}
			if (!(name in layer2index)) {
				trace("[ERROR] No such layer '"+name+"'");
				return [];
			}
			var i:int = layer2index[name];
			return renderLists[i];
		} else {
			if (!(name in name2part)) {
				trace("[ERROR] No such part '"+name+"'");
				return [];
			}
			return [name2part[name]];
		}
	}
	public function setVisibility(name:String, prefix:Boolean, visible:Boolean):void {
		for each (var part:CompositeLayer in getParts(name, prefix)) {
			part.visible = visible;
		}
	}
	public function setAnimation(partName:String, prefix:Boolean, animationName:String):void {
		var animation:AnimationDef = name2anim[animationName];
		if (animationName && !animation) {
			trace("[WARN] <animate> called for non-existing animation "+animationName);
			return;
		}
		for each (var part:CompositeLayer in getParts(partName, prefix)) {
			part.setAnimation(animation);
		}
	}
	public function setOffset(partName:String,prefix:Boolean, dx:int, dy:int, targetLayer:String):void {
		//noinspection JSMismatchedCollectionQueryUpdate
		var targetRenderList:/*CompositeLayer*/Array = null;
		if (targetLayer) {
			if (!renderListBackup) {
				renderListBackup = [];
				for each (var list:/*CompositeLayer*/Array in renderLists) {
					renderListBackup.push(list.slice());
				}
			}
			targetRenderList = renderLists[layer2index[targetLayer]];
			if (!targetRenderList) {
				trace("[WARN] Invalid setOfset targetLayer "+targetLayer);
			}
		}
		list = getParts(partName, prefix);
		if (targetRenderList) list = list.slice();
		for each (var part:CompositeLayer in list) {
			if (!part.visible) continue;
			part.offsetx = dx;
			part.offsety = dy;
			if (targetRenderList) {
				var sourceRenderList:Array = renderLists[layer2index[part.currentLayer]];
				var i:int = sourceRenderList.indexOf(part);
				if (i >= 0) {
					sourceRenderList.splice(i, 1);
					targetRenderList.push(part);
					part.currentLayer = targetLayer;
				}
			}
		}
	}
	public function isVisible(name:String):Boolean {
		var part:CompositeLayer;
		if (CharViewCompiler.partIsPrefix(name)) {
			for each (part in getParts(name, true)) {
				if (part.visible) return true;
			}
		}
		part = name2part[name];
		return part && part.visible;
	}
	public function reset():void {
		for each (var part:CompositeLayer in allParts) {
			part.reset();
		}
		if (renderListBackup) {
			renderLists = renderListBackup;
			renderListBackup = null;
		}
	}
	public function draw(keyColors:Object):BitmapData {
		bmp.fillRect(bmp.rect, 0);
		for each (var list:Array in renderLists) {
			for each (var part:CompositeLayer in list) {
				if (part.visible) {
					part.setKeyColors(keyColors);
					var sx:int = 0, sy:int = 0;
					var sw:int = part.width;
					var sh:int = part.height;
					var dx:int = part.dx;
					var dy:int = part.dy;
					if (dx < 0) {
						sx = -dx;
						dx = 0;
					}
					if (dy < 0) {
						sy = -dy;
						dy = 0;
					}
					if (dx + sw > width) sw = width - dx;
					if (dy + sh > height) sh = height - dy;
					bmp.copyPixels(part.draw(),
							new Rectangle(sx, sy, sw, sh),
							new Point(dx, dy), null, null, true);
				}
			}
		}
		return bmp;
	}
}
}




