/**
 * Coded by aimozg on 10.07.2017.
 */
package coc.view {
import coc.script.Eval;
import coc.view.UIUtils;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class CharView extends Sprite {
	/*[Embed(source="../../../res/model.xml", mimeType="application/octet-stream")]
	private static const XML_MODEL_CLASS:Class;*/

	private var xml:XML;
	private var bitmaps:Object = {}; // layer.@file -> BitmapData
	private var composite:CompositeImage;
	private var ss_total:int;
	private var ss_loaded:int;
	private var file_total:int;
	private var file_loaded:int;
	private var _width:uint;
	private var _height:uint;
	private var pendingRedraw:Boolean;
	public function CharView() {
		clearAll();
	}
	public function reload():void {
		clearAll();
		var loader:URLLoader = new URLLoader();
		var req:URLRequest   = new URLRequest('res/model.xml');
		loader.addEventListener(Event.COMPLETE, function (e:Event):void {
			init(XML(loader.data));
		});
		loader.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
			trace("XML file not found: " + e);
		});
		loader.load(req);
	}
	private function clearAll():void {
		this.xml           = null;
		this.bitmaps       = {};
		this.composite     = null;
		this.ss_total      = 0;
		this.ss_loaded     = 0;
		this.file_total    = 0;
		this.file_loaded   = 0;
		this._width        = 1;
		this._height       = 1;
		this.pendingRedraw = false;
	}
	private function init(xml:XML):void {
		this.xml  = xml;
		_width    = xml.@width;
		_height   = xml.@height;
		composite = new CompositeImage(_width, _height);
		ss_loaded = 0;
		ss_total  = -1;
		var n:int = 0;
		for each(var item:XML in xml.spritesheet) {
			n++;
			loadSpritesheet(item);
		}
		ss_total = n;
		if (pendingRedraw) redraw();
		if (n == 0) loadLayers();
		var g:Graphics = graphics;
		g.clear();
		g.beginFill(0, 0);
		g.drawRect(0, 0, _width, _height);
		g.endFill();
	}
	private function loadLayers():void {
		file_loaded = 0;
		var item:XML;
		var n:int   = 0;
		file_total  = -1;
		for each(item in xml.layers..layer) {
			n++;
			loadBitmapsFrom(item);
		}
		file_total = n;
		if (pendingRedraw) redraw();
	}
	private var _character:Object = {};
	public function setCharacter(value:Object):void {
		_character = value;
	}
	public function redraw():void {
		if (!xml || ss_loaded != ss_total || file_loaded != file_total || file_loaded == 0) {
			pendingRedraw = true;
			return;
		}
		pendingRedraw = false;

		// Calcualte palette ( "hair" -> actual color }
		var palette:Object = {};
		for each (var prop:XML in xml.palette.property) {
			var pn:String        = prop.@name;
			var pv:String        = String(Eval.eval(_character, prop.@src));
			var colorval:XMLList = prop.color.(@name == pv);
			if (colorval.length() == 0) {
				// Try default
				colorval = xml.palette.common.color.(@name == pv);
			}
			if (colorval.length() == 0) {
				trace("CharView: not found palette>property[name=" + pn + "]>color[name='" + pv + "']");
				colorval = prop.default;
			}
			if (colorval.length() > 0) palette[pn] = Color.convertColor(colorval[0].toString());
		}

		// Calculate colors ( key color -> actual color }
		var keyColors:Object = {};
		for each (var key:XML in xml.colorkeys.key) {
			var src:uint  = Color.convertColor(key.@src.toString());
			var base:uint = palette[key.@base];
			var tf:String = key.@transform;
			if (tf) {
				var tfs:/*String*/Array = tf.split(";");
				for each (var transform:String in tfs) {
					var fn:Array      = transform.match(/^(\w+)\(([\d.]+)\)/);
					var fname:String  = fn ? fn[1] : undefined;
					var fvalue:Number = fn ? fn[2] : undefined;
					switch (fname) {
						case "darken":
							base = Color.darken(base, fvalue);
							break;
						case "lighten":
							base = Color.lighten(base, fvalue);
							break;
						default:
							trace("Error: invalid color transform '" + transform + "'");
							break;
					}
				}
			}
			keyColors[src] = base & 0x00ffffff;
		}

		// Mark visible layers
		composite.hideAll();
		for each(var item:XML in xml.layers.*) {
			drawItem(item);
		}

		var bd:BitmapData = composite.draw(keyColors);
		var g:Graphics    = graphics;
		g.clear();
		g.beginBitmapFill(bd);
		g.drawRect(0, 0, _width, _height);
		g.endFill();
	}
	private function clear():void {
		var g:Graphics = graphics;
		g.clear();
		g.beginFill(0, 0);
		g.drawRect(0, 0, _width, _height);
		g.endFill();
	}
	private function drawItem(x:XML):void {
		var testval:*;
		var layer:XML;
		switch (x.localName()) {
			case 'layer':
				const lid:String = x.@file;
				composite.setVisibility(lid, true);
				break;
			case 'if':
				testval = Eval.eval(_character, x.@test.toString());
				if (testval) {
					for each (layer in x.*) drawItem(layer);
				}
				break;
			case 'switch':
				var found:Boolean  = false;
				var xcase:XML;
				var hasval:Boolean = x.attribute("value").length() > 0;
				var switchval:*;
				if (hasval) switchval = Eval.eval(_character, x.@value.toString());
				for each (xcase in x.elements("case")) {
					if (hasval) {
						var hasval2:Boolean = xcase.attribute("value").length() > 0;
						if (hasval2) {
							testval = Eval.eval(_character, xcase.@value.toString());
							if (switchval == testval) {
								found = true;
							}
						}
					}
					var hastest:Boolean = xcase.attribute("test").length() > 0;
					if (!found && hastest) {
						testval = Eval.eval(_character, xcase.@test.toString());
						if (testval) {
							found = true;
						}
					}
					if (found) {
						for each (layer in xcase.*) {
							drawItem(layer);
						}
						break;
					}
				}
				if (!found) {
					for each (layer in x.elements("default").*) {
						drawItem(layer);
					}
				}
				break;
		}
	}
	private function loadSpritesheet(ss:XML):void {
		const filename:String = ss.@file;
		const cellwidth:int   = ss.@cellwidth;
		const cellheight:int  = ss.@cellheight;
		var req:URLRequest    = new URLRequest(xml.@dir + filename);
		trace('loading spritesheet ' + req.url);
		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (e:Event):void {
			var li:LoaderInfo = (e.target as LoaderInfo);
			var bmp:Bitmap    = li.content as Bitmap;
			if (!bmp) {
				trace("error: loaded " + li.url + " as " + li.contentType + " " + li.content);
				ss_loaded++;
				if (pendingRedraw) redraw();
				return;
			}
			var y:int = 0;
			for each (var row:XML in ss.row) {
				var x:int                 = 0;
				var files:/*String*/Array = row.text().toString().split(",");
				for each (var f:String in files) {
					if (f) {
						var bd:BitmapData = new BitmapData(cellwidth, cellheight, true, 0);
						bd.copyPixels(bmp.bitmapData, new Rectangle(x, y, cellwidth, cellheight), new Point(0, 0));
						bitmaps[f] = bd;
					}
					x += cellwidth;
				}
				y += cellheight;
			}
			ss_loaded++;
			if (ss_loaded == ss_total) loadLayers();
		});
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
			trace("Spritesheet file not found: " + e);
			ss_loaded++;
			if (pendingRedraw) redraw();
		});
		loader.load(req);
	}
	private function loadBitmapsFrom(item:XML):void {
		const filename:String = item.@file;
		if (filename in bitmaps) {
			file_loaded++;
			composite.addLayer(filename, bitmaps[filename], false);
			if (pendingRedraw) redraw();
			return;
		}
		bitmaps[filename] = new BitmapData(1, 1);
		composite.addLayer(filename, bitmaps[filename], false);
		var req:URLRequest = new URLRequest(xml.@dir + filename);
		trace('loading layer ' + req.url);
		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (e:Event):void {
			var li:LoaderInfo = (e.target as LoaderInfo);
			var bmp:Bitmap    = li.content as Bitmap;
			if (!bmp) {
				trace("error: loaded " + li.url + " as " + li.contentType + " " + li.content);
				return;
			}
			bitmaps[filename] = bmp.bitmapData;
			composite.replaceLayer(filename, bitmaps[filename]);
			file_loaded++;
			if (pendingRedraw) redraw();
		});
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
			trace("Layer file not found: " + e);
			file_loaded++;
			if (pendingRedraw) redraw();
		});
		loader.load(req);
	}

}
}

