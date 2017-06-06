/**
 * Coded by aimozg on 06.06.2017.
 */
package coc.view {
import classes.internals.Utils;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.utils.Dictionary;
import flash.utils.setTimeout;

public class Block extends Sprite {
	/**
	 * Null layout. All elements' positions and sizes are NOT adjusted
	 */
	public static const LAYOUT_NONE:String = 'none';
	/**
	 * Common layout parameters:
	 * * padding{s,Horiz,Vert,Top,Right,Bottom,Left} - a distance from borders of this block to its elements
	 * * `width`, `height` - override container size
	 */
	/**
	 * Grid layout.
	 * Config:
	 * * `rows`, `cols` - number or rows and columns. Default 1
	 * Hints:
	 * * `row`, `col` - 2D position in grid. Defaults to 'next' to a previous element
	 */
	public static const LAYOUT_GRID:String = 'grid';
	private function applyGridLayout():void {
		var config:Object  = _layoutConfig;
		var rows:Number    = config["rows"] || 1;
		var cols:Number    = config["cols"] || 1;
		var paddings:Array = this.paddings();
		var width:Number = this.parent.width;
		var height:Number = this.parent.height;
		if ('width' in config) {
			width = UIUtils.convertSize(config['width'],width);
		}
		if ('height' in config) {
			height = UIUtils.convertSize(config['height'],height);
		}
		var innerw:Number = Math.max(0, width - paddings[1] - paddings[3]);
		var innerh:Number = Math.max(0, height - paddings[0] - paddings[2]);
		var cellw:Number  = innerw / cols;
		var cellh:Number  = innerh / rows;

		var row:int = 0;
		var col:int = 0;
		for (var ci:int = 0, cn:int = _container.numChildren; ci < cn; ci++) {
			var child:DisplayObject = _container.getChildAt(ci);
			var hint:Object         = _layoutHints[child] || {};
			if ('row' in hint && 'col' in hint) {
				row = hint['row'];
				col = hint['col'];
			}
			child.x = col * cellw + paddings[3];
			child.y = row * cellh + paddings[0];
			col     = col + 1;
			if (col >= cols) {
				col = 0;
				row++;
			}
		}
	}

	private var _container:Sprite;
	private var _layoutHints:Dictionary = new Dictionary();
	private var _dirty:Boolean          = false;
	private var _layoutConfig:Object;

	public function Block(options:Object = null) {
		super();
		_layoutConfig = {type: LAYOUT_NONE};
		UIUtils.setProperties(this, options || {});
		_container = new Sprite();
		addChild(_container);
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		invalidateLayout();
	}

	public function get layoutConfig():Object {
		return _layoutConfig;
	}

	public function set layoutConfig(value:Object):void {
		_layoutConfig = value;
		invalidateLayout();
	}
	protected function addedToStage(e:Event):void {
	}

	public function addElement(e:DisplayObject, hint:Object = null):DisplayObject {
		_container.addChild(e);
		layElement(e, hint);
		return e;
	}

	public function addElementAt(e:DisplayObject, index:int, hint:Object = null):DisplayObject {
		_container.addChildAt(e, index);
		layElement(e, hint);
		return e;
	}

	public function layElement(e:DisplayObject, hint:Object):Block {
		_layoutHints[e] = hint;
		invalidateLayout();
		return this;
	}

	public function getElementIndex(e:DisplayObject):int {
		return _container.getChildIndex(e);
	}

	public function getElementByName(name:String):DisplayObject {
		return _container.getChildByName(name);
	}

	public function removeElement(e:DisplayObject):void {
		_container.removeChild(e);
		delete _layoutHints[e];
		invalidateLayout();
	}

	public function invalidateLayout():void {
		if (!_dirty) {
			_dirty = true;
			setTimeout(maybeDoLayout, 0);
		}
	}

	private function paddings():Array {
		var config:Object = _layoutConfig;
		var rslt:Array    = [0, 0, 0, 0];
		var x:Number;
		if ('padding' in config) rslt[0] = rslt[1] = rslt[2] = rslt[3] = config['padding'];
		if ('paddingHoriz' in config) rslt[1] = rslt[3] = config['paddingHoriz'];
		if ('paddingVert' in config) rslt[0] = rslt[2] = config['paddingVert'];
		if ('paddingTop' in config) rslt[0] = config['paddingTop'];
		if ('paddingRight' in config) rslt[1] = config['paddingRight'];
		if ('paddingBottom' in config) rslt[2] = config['paddingBottom'];
		if ('paddingLeft' in config) rslt[3] = config['paddingLeft'];
		return rslt;
	}
	public function doLayout():void {
		_dirty          = false;
		var type:String = _layoutConfig["type"];
		switch (type) {
			case "grid":
				applyGridLayout();
				break;
			case "none":
				break;
			default:
				trace("Unknown layout config type ", type);
				break;
		}
	}

	protected function maybeDoLayout():void {
		if (_dirty) doLayout();
	}

	/////////////////
	// Helper methods
	/////////////////

	public function addBitmapDataSprite(options:Object, hint:Object = null):BitmapDataSprite {
		var e:BitmapDataSprite = new BitmapDataSprite(options);
		addElement(e, hint);
		return e;
	}
	public function addTextField(options:Object, hint:Object = null):TextField {
		var e:TextField = new TextField();
		UIUtils.setProperties(e, options, {
			defaultTextFormat: UIUtils.convertTextFormat
		});
		addElement(e, hint);
		return e;
	}
}
}
