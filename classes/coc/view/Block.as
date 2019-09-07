/**
 * Coded by aimozg on 06.06.2017.
 */
package coc.view {
import classes.internals.Utils;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.utils.Dictionary;
import flash.utils.setTimeout;

public class Block extends Sprite {
	public static const ON_LAYOUT:String                       = 'coc$layout';
	/**
	 * Null layout. All elements' positions and sizes are NOT adjusted
	 */
						public static const LAYOUT_NONE:String = 'none';
	/**
	 * Common layout parameters:
	 * * padding{s,Horiz,Vert,Top,Right,Bottom,Left} - a distance from borders of this block to its elements
	 * * `ignoreHidden` - ignore all hidden (visible=false) elements. Default layout-dependent
	 * Common element hints:
	 * * `ignore` - ignore element
	 */
	/**
	 * Grid layout. Aligns elements in a grid of fixed cell size, fixed cell count
	 * Config:
	 * * `rows`, `cols` - number or rows and columns. Default 1
	 * * `setWidth`, `setHeight - should set width/height of elements. Default false
	 * Hints:
	 * * `row`, `col` - 2D position in grid. Defaults to "next cell"
	 * * `setWidth`, `setHeight - should set width/height of this element. Default to layout config
	 */
	public static const LAYOUT_GRID:String = 'grid';
	private function applyGridLayout():void {
		var config:Object        = _layoutConfig;
		var ignoreHidden:Boolean = 'ignoreHidden' in config ? config['ignoreHidden'] : false;
		var rows:Number          = config["rows"] || 1;
		var cols:Number          = config["cols"] || 1;
		var innerw:Number        = innerWidth;
		var innerh:Number        = innerHeight;
		var cellw:Number         = innerw / cols;
		var cellh:Number         = innerh / rows;
		var setcw:Boolean        = config['setWidth'];
		var setch:Boolean        = config['setHeight'];

		var row:int = 0;
		var col:int = 0;
		for (var ci:int = 0, cn:int = _container.numChildren; ci < cn; ci++) {
			var child:DisplayObject = _container.getChildAt(ci);
			var hint:Object         = _layoutHints[child] || {};
			if (hint['ignore'] || !child.visible && ignoreHidden) continue;
			var setw:Boolean = 'setWidth' in hint ? hint['setWidth'] : setcw;
			var seth:Boolean = 'setHeight' in hint ? hint['setHeight'] : setch;
			if ('row' in hint && 'col' in hint) {
				row = hint['row'];
				col = hint['col'];
			}
			child.x = col * cellw + paddingLeft;
			child.y = row * cellh + paddingTop;
			if (setw) child.width = cellw;
			if (seth) child.height = cellh;
			col = col + 1;
			if (col >= cols) {
				col = 0;
				row++;
			}
		}
	}
	/**
	 * Flow layout. Aligns size-providing elements in a row or column
	 * Config:
	 * `direction` - 'row'|'column'. Defaults to 'row'
	 * `gap` - Gap between neighbouring elements. Defaults to 2.
	 * `ignoreHidden` defaults to true
	 * Hints:
	 * `before`, `after` - Additional gap before/after that element. May be negative
	 */
	public static const LAYOUT_FLOW:String = 'flow';
	private function applyFlowLayout():void {
		var config:Object        = _layoutConfig;
		var ignoreHidden:Boolean = 'ignoreHidden' in config ? config['ignoreHidden'] : true;
		var dir:String           = config['direction'] || 'row';
		var gap:Number           = 'gap' in config ? config['gap'] : 2;
		var x:Number             = paddingLeft;
		var y:Number             = paddingTop;
		for (var ci:int = 0, cn:int = _container.numChildren; ci < cn; ci++) {
			var child:DisplayObject = _container.getChildAt(ci);
			var hint:Object         = _layoutHints[child] || {};
			if (hint['ignore'] || !child.visible && ignoreHidden) continue;
			var before:Number = 'before' in hint ? hint['before'] : 0;
			if (dir == 'column') {
				y += before;
			} else {
				x += before;
			}
			child.x          = x;
			child.y          = y;
			var after:Number = 'after' in hint ? hint['after'] : 0;
			if (dir == 'column') {
				y += child.height + after + gap;
			} else {
				x += child.width + after + gap;
			}
		}
	}

	private var _container:Sprite;
	private var _layoutHints:Dictionary = new Dictionary();
	private var _dirty:Boolean          = false;
	private var _layoutConfig:Object;
	private var explicitWidth:Number    = 0;
	private var explicitHeight:Number   = 0;

	public function Block(options:Object = null) {
		super();
		_layoutConfig = {type: LAYOUT_NONE};
		UIUtils.setProperties(this, options || {});
		_container = new Sprite();
		addChild(_container);
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		invalidateLayout();
	}

	private function get xmin():Number {
		var xmin:Number = 0;
		if (_container) {
			for (var i:int = 0, n:int = numElements; i < n; i++) {
				xmin = Math.min(xmin, getElementAt(i).x);
			}
		}
		return xmin;
	}
	private function get ymin():Number {
		var ymin:Number = 0;
		if (_container) {
			for (var i:int = 0, n:int = numElements; i < n; i++) {
				ymin = Math.min(ymin, getElementAt(i).y);
			}
		}
		return ymin;
	}
	override public function get width():Number {
		if (explicitWidth) return explicitWidth;
		return super.width-xmin;
	}
	override public function get height():Number {
		if (explicitHeight) return explicitHeight;
		return super.height-ymin;
	}
	override public function set width(value:Number):void {
		if (width != value) {
			explicitWidth = value;
			resize();
		}
	}
	override public function set height(value:Number):void {
		if (height != value) {
			explicitHeight = value;
			resize();
		}
	}
	private function resize():void {
		if (width > 0 || height > 0) {
			graphics.clear();
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		if (width && height) {
			super.width  = width+Math.max(0,-xmin);
			super.height = height+Math.max(0,-ymin);
		}
	}
	public function get layoutConfig():Object {
		return _layoutConfig;
	}

	public function set layoutConfig(value:Object):void {
		_layoutConfig = value;
		invalidateLayout();
	}
	public function get innerWidth():Number {
		return Math.max(0, (width || explicitWidth) - paddingLeft - paddingRight);
	}
	public function get innerHeight():Number {
		return Math.max(0, (height || explicitHeight) - paddingTop - paddingBottom);
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
	public function getElementAt(index:int):DisplayObject {
		return _container.getChildAt(index);
	}
	public function get numElements():int {
		return _container.numChildren;
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

	public function get paddingTop():Number {
		var config:Object = _layoutConfig;
		if ('paddingTop' in config) return config['paddingTop'];
		if ('paddingVert' in config) return config['paddingVert'];
		if ('padding' in config) return config['padding'];
		return 0;
	}
	public function get paddingRight():Number {
		var config:Object = _layoutConfig;
		if ('paddingRight' in config) return config['paddingRight'];
		if ('paddingHoriz' in config) return config['paddingHoriz'];
		if ('padding' in config) return config['padding'];
		return 0;
	}
	public function get paddingBottom():Number {
		var config:Object = _layoutConfig;
		if ('paddingBottom' in config) return config['paddingBottom'];
		if ('paddingVert' in config) return config['paddingVert'];
		if ('padding' in config) return config['padding'];
		return 0;
	}
	public function get paddingLeft():Number {
		var config:Object = _layoutConfig;
		if ('paddingLeft' in config) return config['paddingLeft'];
		if ('paddingHoriz' in config) return config['paddingHoriz'];
		if ('padding' in config) return config['padding'];
		return 0;
	}
	public function doLayout():void {
		_dirty          = false;
		var type:String = _layoutConfig["type"];
		switch (type) {
			case "grid":
				applyGridLayout();
				break;
			case "flow":
				applyFlowLayout();
				break;
			case "none":
				break;
			default:
				trace("Unknown layout config type ", type);
				break;
		}
		dispatchEvent(new Event(ON_LAYOUT, true, true));
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
		e.antiAliasType = AntiAliasType.ADVANCED;
		if ('defaultTextFormat' in options) {
			e.defaultTextFormat = UIUtils.convertTextFormat(options['defaultTextFormat']);
		}
		UIUtils.setProperties(e, options, {
			defaultTextFormat: UIUtils.convertTextFormat,
			background: UIUtils.convertColor
		});
		if (!('mouseEnabled' in options) && options['type'] != 'input') e.mouseEnabled = false;
		if (!('width' in options || 'height' in options || 'autoSize' in options)) {
			e.autoSize = TextFieldAutoSize.LEFT;
		}
		addElement(e, hint);
		return e;
	}

}
}
