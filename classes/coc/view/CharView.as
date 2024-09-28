/**
 * Coded by aimozg on 10.07.2017.
 */
package coc.view {
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.internals.Utils;

import coc.view.charview.CharViewCompiler;
import coc.view.charview.CharViewContext;
import coc.view.charview.CharViewSprite;
import coc.view.charview.Palette;
import coc.xlogic.Statement;
import coc.xlogic.StmtList;

import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.getTimer;

public class CharView extends Sprite {

	private var loading:Boolean;
	private var sprites:Object = {}; // spritesheet/spritemap -> CharViewSprite
	public var composite:CompositeImage;
	private var ss_total:int;
	private var ss_loaded:int;
	private var file_total:int;
	private var file_loaded:int;
	private var _originX:int;
	private var _originY:int;
	private var _width:uint;
	private var _height:uint;
	private var scale:Number;
	private var pendingRedraw:Boolean;
	private var loaderLocation:String;
	private var parts:Statement;
	private var _palette:Palette;
	public var bgFill:uint = 0;
	private var time:int = 0;

	public function get palette():Palette {
		return _palette;
	}
	public function CharView() {
		clearAll();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	private function onAddedToStage(e:Event):void {
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	private function onRemovedFromStage(e:Event):void {
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	private function onEnterFrame(e:Event):void {
		try {
			var t2:int = getTimer();
			var dt:int = Math.max(0, t2 - time);
			if (composite) {
				if (composite.advanceTime(dt, t2)) {
					composeFrame();
				}
			}
			time = t2;
		} catch (e:Error) {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			throw e;
		}
	}
	/**
	 * @param location "external" or "internal"
	 */

	public function reload(location:String = "external"):void {
		loaderLocation = location;
		if (loading) return;
		try {
			loading = true;
			clearAll();
			if (loaderLocation == "external") trace("loading XML res/model.xml");
			CoCLoader.loadText(CoC.instance.flags[kFLAGS.CHARVIEWER_MODEL] == 0 ? "res/model.xml" : "res/model2.xml", function (success:Boolean, result:String, e:Event):void {
				if (success) {
					init(XML(result));
				} else {
					trace("XML file not found: " + e);
					loading = false;
				}
			}, loaderLocation);
		} catch (e:Error) {
			loading = false;
			trace("[ERROR]\n" + e.getStackTrace());
		}
	}
	private function clearAll():void {
		this.time          = getTimer();
		this.sprites       = {};
		this.composite     = null;
		this.ss_total      = 0;
		this.ss_loaded     = 0;
		this.file_total    = 0;
		this.file_loaded   = 0;
		this._width        = 1;
		this._height       = 1;
		this.scale         = 1;
		this.pendingRedraw = false;
		this.parts         = new StmtList();
	}
	private function init(xml:XML):void {
		_width    = xml.@width;
		_height   = xml.@height;
		_originX  = xml.@originX || 0;
		_originY  = xml.@originY || 0;
		composite = new CompositeImage(_width, _height);
		ss_loaded = 0;
		ss_total  = -1;
		/**/
		loadPalette(xml);
		var compiler:CharViewCompiler = new CharViewCompiler(this);
		this.parts = compiler.compileXMLList(xml.logic.children());
		var n:int  = 0;
		var item:XML;
		for each(item in xml.spritesheet) {
			n++;
			loadSpritesheet(xml, item);
		}
		for each(item in xml.spritemap) {
			n++;
			loadSpritemap(xml, item);
		}
		ss_total = n;
		if (n == 0) loadLayers(xml);
		var g:Graphics = graphics;
		g.clear();
		g.beginFill(bgFill&0x00ffffff, ((bgFill>>24)&0xff)/256.0);
		g.drawRect(0, 0, _width, _height);
		g.endFill();
		scale       = parseFloat(xml.@scale);
		this.scaleX = scale;
		this.scaleY = scale;
		loading     = false;
		if (pendingRedraw) redraw();
	}
	private function loadPalette(xml:XML):void {
		_palette                 = new Palette();
		var commonLookups:Object = {};
		_palette.addLookups("common", commonLookups);
		for each (var xpalette:XML in xml.palette) {
			var palname:String = xpalette.@name.toString();
			var lookups:Object = {};
			for each (var color:XML in xpalette.color) {
				lookups[color.@name.toString()] = color.text().toString();
			}
			_palette.addLookups(palname, lookups);
		}
		for each (var prop:XML in xml.colorprops.property) {
			palname = prop.@palette.toString()
			var propname:String = prop.@name.toString();
			_palette.addPaletteProperty(
					propname,
					prop.@src.toString(),
					Color.convertColor(prop.@default.toString()),
					[palname, "common"]);
		}
		for each (var key:XML in xml.colorkeys.key) {
			var src:uint    = Color.convertColor(key.@src.toString());
			var base:String = key.@base.toString();
			var tf:String   = key.@transform.toString() || "";
			_palette.addKeyColor(src, base, tf);
		}
	}
	public function lookupColorValue(propname:String, colorname:String):uint {
		return _palette.lookupColor(propname, colorname);
	}
	private function loadLayers(xml:XML):void {
		file_loaded = 0;
		var item:XML;
		var n:int   = 0;
		file_total  = -1;
		var layerNames:Array = [];
		for each(item in xml.layers..layer) {
			layerNames.unshift(""+item.@name + "/");
		}
		composite.addLayers(layerNames);
		for (var sname:String in sprites) {
			var sprite:CharViewSprite = sprites[sname];
			composite.addPart(sname, sprite.bmp,
					sprite.dx - _originX, sprite.dy - _originY);
		}
		for each (item in xml.animations..animation) {
			var animation:AnimationDef = new AnimationDef(item.@name.toString());
			for each (var frame:XML in item..frame) {
				var t:int = parseInt(frame.@t.toString());
				var dx:int = parseInt(frame.@dx.toString() || "0");
				var dy:int = parseInt(frame.@dy.toString() || "0");
				var i:String = frame.@i.toString() || "";
				animation.addFrame(t, dx, dy, i);
			}
			composite.addAnimation(animation);
		}
		file_total = n;
		if (pendingRedraw) redraw();
	}
	private var _character:Object = {};
	public function setCharacter(value:Object):void {
		_character = value;
	}
	public function isLoaded():Boolean {
		return !loading && ss_loaded == ss_total && file_loaded == file_total && (ss_total + file_total) > 0;
	}
	public function redraw():void {
		if (file_total == 0 && ss_total == 0 && !loading) {
			reload();
		}
		pendingRedraw = true;
		if (!isLoaded()) {
			return;
		}
		pendingRedraw = false;


		// Mark visible layers
		composite.reset();
		time = getTimer();
		parts.execute(new CharViewContext(this,_character));

		composeFrame();
		this.scaleX = scale;
		this.scaleY = scale;
	}

	protected function composeFrame():void {
		var keyColors:Object = _palette.calcKeyColors(_character);
		var bd:BitmapData    = composite.draw(keyColors);
		var g:Graphics       = graphics;
		g.clear();
		g.beginFill(bgFill & 0x00ffffff, ((bgFill >> 24) & 0xff) / 256.0);
		g.drawRect(0, 0, _width, _height);
		g.endFill();
		g.beginBitmapFill(bd);
		g.drawRect(0, 0, _width, _height);
		g.endFill();
	}

	private function loadSpritemap(xml:XML, sm:XML):void {
		const filename:String = sm.@file;
		var path:String       = xml.@dir + filename;
		if (loaderLocation == "external") trace('loading spritemap ' + path);
		CoCLoader.loadImage(path, function (success:Boolean, result:BitmapData, e:Event):void {
			if (!success) {
				trace("Spritemap file not found: " + e);
				ss_loaded++;
				if (pendingRedraw) redraw();
				return;
			}
			var srects:Object = {};
			var aliasCells:/*[srect:String, name:String, sdx:String, sdy:String]*/Array = [];
			for each (var cell:XML in sm.cell) {
				var srect:String         = cell.@rect.toString();
				var sdx:String           = cell.@dx.toString();
				var sdy:String           = cell.@dy.toString();
				var rect:/*String*/Array = srect.match(/^(\d+),(\d+),(\d+),(\d+)$/);
				var x:int                = rect ? int(rect[1]) : cell.@x;
				var y:int                = rect ? int(rect[2]) : cell.@y;
				var w:int                = rect ? int(rect[3]) : cell.@w;
				var h:int                = rect ? int(rect[4]) : cell.@h;
				var f:String             = cell.@name;
				var dx:int               = cell.@dx;
				var dy:int               = cell.@dy;
				if (rect) {
					if (srect in srects) {
						trace("[WARN] Duplicate <cell rect>: "+f+", "+srects[srect]);
					} else {
						srects[srect] = f;
					}
					try {
						sprites[f] = new CharViewSprite(UIUtils.subsprite(result, x, y, w, h), dx, dy);
					} catch (e:Error) {
						throw new Error("Error in model.xml <cell name='"+f+"'>: "+e.message)
					}
				} else {
					aliasCells.push([srect,f,sdx,sdy]);
				}
			}
			while (aliasCells.length > 0) {
				var progressed:Boolean = false;
				for (var i:int = aliasCells.length-1; i>=0; i--) {
					srect = aliasCells[i][0];
					f = aliasCells[i][1];
					sdx = aliasCells[i][2];
					sdy = aliasCells[i][3];
					if (srect in sprites) {
						progressed = true;
						var ref:CharViewSprite = sprites[srect];
						dx = sdx ? parseInt(sdx) : ref.dx;
						dy = sdy ? parseInt(sdy) : ref.dy;
						try {
							sprites[f] = new CharViewSprite(ref.bmp, dx, dy);
						} catch (e:Error) {
							throw new Error("Error in model.xml <cell name='"+f+"'>: "+e.message)
						}
						aliasCells.splice(i, 1);
					}
				}
				if (!progressed) {
					throw new Error("Cannot resolve reference <cell name='"+aliasCells[0][1]+"' rect='"+aliasCells[0][0]+"'>");
				}
			}
			ss_loaded++;
			if (ss_loaded == ss_total) loadLayers(xml);
		}, loaderLocation);
	}
	private function loadSpritesheet(xml:XML, ss:XML):void {
		const filename:String = ss.@file;
		const cellwidth:int   = ss.@cellwidth;
		const cellheight:int  = ss.@cellheight;
		var path:String       = xml.@dir + filename;
		if (loaderLocation == "external") trace('loading spritesheet ' + path);
		CoCLoader.loadImage(path, function (success:Boolean, result:BitmapData, e:Event):void {
			if (!success) {
				trace("Spritesheet file not found: " + e);
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
						sprites[f] = new CharViewSprite(UIUtils.subsprite(result, x, y, cellwidth, cellheight), 0, 0);
					}
					x += cellwidth;
				}
				y += cellheight;
			}
			ss_loaded++;
			if (ss_loaded == ss_total) loadLayers(xml);
		}, loaderLocation);
	}

}
}

